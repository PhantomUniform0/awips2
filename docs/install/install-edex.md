# Install EDEX <i class="fa fa-linux"></i>

EDEX is the **E**nvironmental **D**ata **Ex**change system that represents the backend server for AWIPS.  EDEX is only supported for Linux systems: CentOS and RHEL, and ideally, it should be on its own dedicated machine.  It requires administrator priviledges to make root-level changes. EDEX can run on a single machine or be spread across multiple machines.  To learn more about that please look at [Distributed EDEX, Installing Across Multiple Machines](/edex/distributed-computing/)

---

## System requirements

- 64-bit CentOS/RHEL 7
- 16+ CPU cores (each CPU core can run a decorder in parallel)
- 24GB RAM
- 700GB+ Disk Space
- gcc-c++ package
    - Run `rpm -qa | grep gcc-c++` to verify if the package is installed
    - If it is not installed, run `yum install gcc-c++` to install the package
- A **Solid State Drive (SSD)** is recommended
    - A SSD should be mounted either to `/awips2` (to contain the entire EDEX system) or to `/awips2/edex/data/hdf5` (to contain the large files in the decoded data store). EDEX can scale to any system by adjusting the incoming LDM data feeds or adjusting the resources (CPU threads) allocated to each data type.

> Note: EDEX is only supported for 64-bit CentOS and RHEL 7 Operation Systems.  You may have luck with Fedora Core 12 to 14 and Scientific Linux.

!!! warning "EDEX is **not** supported in Debian, Ubuntu, SUSE, Solaris, macOS, or Windows."

---

## Download and Installation Instructions

All of these command should be run as **root**

### 1. Create AWIPS User

Create user awips and group fxalpha

```
groupadd fxalpha && useradd -G fxalpha awips
```

or if the awips account already exists:
```
groupadd fxalpha && usermod -G fxalpha awips
```

### 2. Install EDEX

Download the and run the installer: [**awips_install.sh** <i class="fa fa-download"></i>](https://www.unidata.ucar.edu/software/awips2/awips_install.sh)
```
wget https://www.unidata.ucar.edu/software/awips2/awips_install.sh
chmod 755 awips_install.sh
sudo ./awips_install.sh --edex
```


!!! note "**awips_install.sh --edex** will perform the following steps (it's always a good idea to review downloaded shell scripts):"

       1. Saves the appropriate Yum repo file to `/etc/yum.repos.d/awips2.repo`
       2. Increases process and file limits for the the *awips* account in `/etc/security/limits.conf`
       3. Creates `/awips2/data_store` if it does not exist already
       4. Runs `yum groupinstall awips2-server`
       5. Attempts to configure the EDEX hostname defined in `/awips2/edex/bin/setup.env`
       6. Alerts the user if the *awips* account does not exist (the RPMs will still install)


### 3. EDEX Setup

Change user and run edex setup:

```
sudo su - awips
sudo edex setup
```

The command `edex setup` will try to determine your fully-qualified domain name and set it in `/awips2/edex/bin/setup.env`. EDEX Server Administrators should double-check that the addresses and names defined in setup.env are resolvable from both inside and outside the server, and make appropriate edits to `/etc/hosts` if necessary.

#### Setup Example
For example, in the XSEDE Jetstream cloud, the fully-qualified domain name defined in `/awips2/edex/bin/setup.env`

```
export EXT_ADDR=js-196-132.jetstream-cloud.org
export DB_ADDR=localhost
export DB_PORT=5432
export BROKER_ADDR=localhost
export PYPIES_SERVER=http://${EXT_ADDR}:9582
```

The external address needs to direct to localhost in `/etc/hosts`

```
127.0.0.1   localhost localhost.localdomain js-196-132.jetstream-cloud.org
```

### 4. Configure iptables

Configure iptables to allow TCP connections on ports 9581 and 9582 if you want to serve data to CAVE clients and the Python API.

#### Open Port 9588

If you are running a Registry (Data Delivery) server, you will also want to open port **9588**.

##### To open ports to all connections

```
vi /etc/sysconfig/iptables

*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 9581 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 9582 -j ACCEPT
#-A INPUT -m state --state NEW -m tcp -p tcp --dport 9588 -j ACCEPT # for registry/dd
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
```

##### To open ports to specific IP addresses

In this example, the IP range `128.117.140.0/24` will match all 128.117.140.\* addresses, while `128.117.156.0/24` will match 128.117.156.\*.

```
vi /etc/sysconfig/iptables

*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
:EXTERNAL - [0:0]
:EDEX - [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -p icmp --icmp-type any -j ACCEPT
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -s 128.117.140.0/24 -j EDEX
-A INPUT -s 128.117.156.0/24 -j EDEX
-A INPUT -j EXTERNAL
-A EXTERNAL -j REJECT
-A EDEX -m state --state NEW -p tcp --dport 22 -j ACCEPT
-A EDEX -m state --state NEW -p tcp --dport 9581 -j ACCEPT
-A EDEX -m state --state NEW -p tcp --dport 9582 -j ACCEPT
#-A EDEX -m state --state NEW -p tcp --dport 9588 -j ACCEPT # for registry/dd
-A EDEX -j REJECT
COMMIT
```

#### Restart iptables

```
service iptables restart
```

#### Troubleshooting 

For CentOS 7 error:
>Redirecting to /bin/systemctl restart  iptables.service  
>Failed to restart iptables.service: Unit iptables.service failed to load: No such >file or directory.

The solution is:
```
yum install iptables-services
systemctl enable iptables
service iptables restart
```

### 5. Start EDEX
```
edex start
```
To manually start, stop, and restart:
```
service edex_postgres start
service httpd-pypies start
service qpidd start
service edex_camel start
```
The fifth service, **edex_ldm**, does **not run at boot** to prevent filling up disk space if EDEX is not running.
```
ldmadmin start
```
To start *all services except the LDM* (good for troubleshooting):
```
edex start base
```
To restart EDEX
```
edex restart
```

---

## Additional Steps

### Increase Process Limit

**/etc/security/limits.conf** defines the number of user processes and files (this step is automatically performed by `./awips_install.sh --edex`). Without these definitions, Qpid is known to crash during periods of high ingest.

    awips soft nproc 65536
    awips soft nofile 65536

---

### Ensure SELinux is Disabled

!!! note "This step is no longer necessary with version *LDM-6.13* or higher.  The version shipped with Unidata's EDEX is higher than this cutoff."

```
vi /etc/sysconfig/selinux

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

!!! note "Read more about selinux at [redhat.com](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Enabling_and_Disabling_SELinux-Disabling_SELinux.html)"

---

### SSD Mount

Though a Solid State Drive is not required, it is *strongly encouraged* in order to handle the amount of disk IO for real-time IDD feeds.

The simplest configuration would be to mount an 500GB+ SSD to **/awips2** to contain both the installed software (approx. 20GB) and the real-time data (approx. 150GB per day).

The default [purge rules](/edex/data-purge/) are configured such that the processed data in **/awips2** does not exceed 450GB. The raw data is located in **/awips2/data_store**, and is scoured every hour and should not exceed 50GB.

If you want to increase EDEX data retention you should mount a large disk to **/awips2/edex/data/hdf5** since this will be where the archived processed data exists, and any case studies created.

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        30G  2.5G   26G   9% /
tmpfs            28G     0   28G   0% /dev/shm
/dev/sdc1       788G   81G  667G  11% /awips2
/dev/sdb1       788G   41G  708G  10% /awips2/edex/data/hdf5
```

---

### Configure LDM Feeds

EDEX installs its own version of the LDM to the directory **/awips2/ldm**.  As with a the default LDM configuration, two files are used to control what IDD feeds are ingested:

#### Configuration file: /awips2/ldm/etc/ldmd.conf

This file specifies an upstream LDM server to request data from, and what feeds to request:

```
REQUEST NEXRAD3 "./p(DHR|DPR|DSP|DTA|DAA|DVL|EET|HHC|N0Q|N0S|N0U|OHA|NVW|NTV|NST)." idd.unidata.ucar.edu
REQUEST FNEXRAD|IDS|DDPLUS|UNIWISC ".*" idd.unidata.ucar.edu
REQUEST NGRID ".*" idd.unidata.ucar.edu
REQUEST NOTHER "^TIP... KNES.*" idd.unidata.ucar.edu
```

!!! note "[Read more about ldmd.conf in the LDM User Manual](https://www.unidata.ucar.edu/software/ldm/ldm-current/basics/ldmd.conf.html)"

#### Configuration File: /awips2/ldm/etc/pqact.conf

This file specifies the WMO headers and file pattern actions to request:

```
# Redbook graphics
ANY     ^([PQ][A-Z0-9]{3,5}) (....) (..)(..)(..) !redbook [^/]*/([^/]*)/([^/]*)/([^/]*)/([0-9]{8})
        FILE    -overwrite -close -edex /awips2/data_store/redbook/\8/\4\5Z_\8_\7_\6-\1_\2_(seq).rb.%Y%m%d%H
# NOAAPORT GINI images
NIMAGE  ^(sat[^/]*)/ch[0-9]/([^/]*)/([^/]*)/([^ ]*) ([^/]*)/([^/]*)/([^/]*)/ (T[^ ]*) ([^ ]*) (..)(..)(..)
        FILE    -overwrite -close -edex /awips2/data_store/sat/\(11)\(12)Z_\3_\7_\6-\8_\9_(seq).satz.%Y%m%d%H
```

!!! note "[Read more about pqact.conf in the LDM User Manual](https://www.unidata.ucar.edu/software/ldm/ldm-current/basics/pqact.conf.html)"
!!! tip "[See available AWIPS LDM feeds](/edex/ldm/)"

---

### Directories to Know

* `/awips2` - Contains all of the installed AWIPS software.
* `/awips2/edex/logs` - EDEX logs.
* `/awips2/httpd_pypies/var/log/httpd` - httpd-pypies logs.
* `/awips2/database/data/pg_log` - PostgreSQL logs.
* `/awips2/qpid/log` - Qpid logs.
* `/awips2/edex/data/hdf5` - HDF5 data store.
* `/awips2/edex/data/utility` - Localization store and configuration files.
* `/awips2/ldm/etc` - Location of **ldmd.conf** and **pqact.conf**
* `/awips2/ldm/logs` - LDM logs.
* `/awips2/data_store` - Raw data store.
* `/awips2/data_store/ingest` - Manual data ingest endpoint.

---

### What Version is my EDEX?
```
rpm -qa | grep awips2-edex
```
