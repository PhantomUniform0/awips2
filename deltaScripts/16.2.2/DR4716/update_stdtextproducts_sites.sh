#!/bin/bash
# DR #4716 - This script updates site in stdtextproducts based on xxxid.

PSQL="/awips2/psql/bin/psql"

# These entries based on icao_lookup_table.dat.
# This script should be modified to reflect any changes to the file.
simpleSites='
K1Y7
K40J
K7VM
KAAF
KABE
KABI
KABQ
KABR
KABX
KACT
KACY
KADG
KAEX
KAGS
KAHN
KAIA
KAKQ
KALB
KALO
KALR
KALS
KALW
KALY
KAMA
KAMX
KAPA
KAPC
KAPN
KAPX
KARB
KARX
KASE
KAST
KATL
KATR
KATX
KAUO
KAUS
KAVL
KAVP
KAYS
KBBX
KBCT
KBDL
KBDR
KBFF
KBFI
KBFL
KBGM
KBHM
KBHX
KBIH
KBIL
KBIS
KBIX
KBJC
KBKW
KBLU
KBLX
KBMX
KBNA
KBNO
KBOI
KBOS
KBOU
KBOX
KBPT
KBRO
KBTM
KBTR
KBTV
KBUF
KBVY
KBWI
KBYX
KBYZ
KBZN
KCAE
KCAK
KCAO
KCAR
KCBW
KCBX
KCCX
KCEC
KCHA
KCHH
KCHI
KCHM
KCHS
KCIC
KCIR
KCKL
KCLE
KCLL
KCLT
KCLX
KCMH
KCNK
KCNU
KCON
KCOS
KCOU
KCPR
KCRH
KCRP
KCRW
KCSG
KCTP
KCVG
KCXX
KCYS
KDAB
KDAX
KDAY
KDBQ
KDCA
KDDC
KDEN
KDFW
KDIX
KDLH
KDMO
KDMX
KDNR
KDRA
KDRT
KDSM
KDTW
KDTX
KDVN
KEAT
KEAX
KEEW
KEGE
KEHU
KEKA
KEKN
KEKO
KELP
KELY
KEMP
KEMX
KENX
KEPZ
KERI
KERO
KESF
KESX
KEUG
KEVV
KEWR
KEWX
KEYW
KEYX
KFAR
KFAT
KFCA
KFCH
KFCX
KFFC
KFGF
KFGZ
KFLG
KFLL
KFLO
KFMY
KFNT
KFSD
KFSM
KFSX
KFTG
KFTW
KFWA
KFWD
KFWR
KFWS
KGBG
KGCK
KGCN
KGEG
KGFF
KGGG
KGGW
KGID
KGJT
KGJX
KGLD
KGLH
KGLS
KGPI
KGRB
KGRI
KGRK
KGRR
KGSO
KGSP
KGTF
KGVW
KGWC
KGWX
KGYX
KHAR
KHAT
KHCO
KHDO
KHGX
KHLN
KHMS
KHNX
KHON
KHOU
KHSI
KHSV
KHTL
KHTS
KHTX
KHUF
KHUN
KHUT
KHVN
KHVR
KIAD
KIAG
KIAH
KICT
KICX
KILG
KILM
KILN
KILX
KIND
KINL
KINW
KINX
KIOW
KIPL
KIPT
KISN
KIWA
KIWX
KIXD
KJAN
KJAX
KJCT
KJEF
KJFK
KJKL
KKCI
KKEY
KKRF
KLAF
KLAN
KLAS
KLAX
KLBB
KLBF
KLBG
KLCH
KLEX
KLGA
KLGB
KLIC
KLIT
KLIX
KLKN
KLMK
KLMT
KLND
KLNK
KLNX
KLOT
KLOX
KLRX
KLSE
KLSX
KLTX
KLUB
KLUK
KLVX
KLWS
KLWX
KLYH
KLZK
KMAF
KMAX
KMBX
KMCI
KMCN
KMCO
KMEG
KMEI
KMEM
KMFD
KMFL
KMFR
KMGM
KMGW
KMHK
KMHS
KMHX
KMIA
KMKC
KMKE
KMKG
KMKR
KMKX
KMLB
KMLF
KMLI
KMLS
KMMO
KMOB
KMOD
KMPX
KMQT
KMRX
KMRY
KMSN
KMSO
KMSP
KMSR
KMSV
KMSX
KMSY
KMTH
KMTR
KMTX
KMUX
KMVX
KMWI
KMXX
KMYR
KNBC
KNBK
KNCF
KNEC
KNES
KNEW
KNFD
KNHK
KNHZ
KNMA
KNMK
KNMW
KNQA
KNRX
KNXK
KNYC
KOAK
KOAX
KOFK
KOHX
KOJC
KOKC
KOKX
KOLM
KOMA
KONT
KORD
KORF
KORH
KORK
KORL
KORN
KOTH
KOTX
KOUN
KOVN
KPAH
KPBI
KPBS
KPBZ
KPDR
KPDT
KPDX
KPGA
KPHI
KPHL
KPHX
KPIA
KPIE
KPIH
KPIT
KPKB
KPMD
KPNE
KPNS
KPPF
KPQR
KPSP
KPSR
KPTR
KPUB
KPUX
KPVD
KPWM
KRAH
KRAL
KRAP
KRAX
KRBD
KRBL
KRDD
KRDG
KRDM
KRDU
KREV
KRFD
KRGX
KRHA
KRIC
KRIV
KRIW
KRLX
KRMG
KRNK
KRNO
KROA
KROC
KROW
KRRD
KRSA
KRST
KRTX
KRYY
KSAC
KSAN
KSAT
KSAV
KSBA
KSBN
KSCK
KSCS
KSDB
KSDF
KSDM
KSEA
KSEP
KSEW
KSEZ
KSFO
KSFX
KSGF
KSGX
KSHD
KSHR
KSHV
KSIL
KSJC
KSJT
KSLC
KSLE
KSLN
KSMF
KSMP
KSMX
KSNA
KSNS
KSOX
KSPI
KSPS
KSRX
KSSM
KSTC
KSTJ
KSTL
KSTN
KSTO
KSTR
KSUA
KSUX
KSWF
KSXT
KSYR
KSYS
KTAE
KTAR
KTBW
KTCS
KTDW
KTFX
KTIR
KTLH
KTLR
KTLX
KTMB
KTOI
KTOL
KTOP
KTPA
KTRI
KTRM
KTSA
KTUA
KTUL
KTUP
KTUR
KTUS
KTWC
KTWF
KTWX
KTYS
KTYX
KUCR
KUDX
KUEX
KUIL
KUKI
KUMN
KUNR
KVBX
KVCT
KVEF
KVQN
KVTN
KVTU
KVTX
KVUY
KWAL
KWBJ
KWMC
KWNC
KWNH
KWNJ
KWNO
KWNP
KWNS
KWSH
KYKM
KYNG
KYUM
KYUX
NSTU
PAAQ
PABE
PABR
PACD
PACV
PADQ
PAFA
PAHO
PAJN
PAKN
PAMC
PANC
PANT
PAOM
PAOT
PASN
PAUN
PAVD
PAVW
PAWU
PAYA
PHEB
PHLI
PHNL
PHTO
PKMR
PNSB
PTKK
PTKR
PTSA
PTTP
PTYA
PWCZ
TIST
TISX
TJBQ
TJMZ
TJNR
TJPS
TJSJ
TSPN'

# Sites impacted by the override and removed from simpleSites
#PAER
#PALU
#PACR
#PAFC
#PAFG
#PAJK
#PGUM
#PHFO
#KSJU

# From site3LetterTo4LetterOverride.dat
site3to4override='
AER:PAFC
ALU:PAFC
ACR:PACR
AFC:PAFC
AFG:PAFG
AJK:PAJK
GUM:PGUM
HFO:PHFO
SJU:TJSJ
'

function addUpdate {
	site=$1
	xxx=$2
	cmd="${PSQL} -U awips -d fxatext -c \"UPDATE stdtextproducts set site='${site}' where xxxid='${xxx}' ;\""
	echo echo $cmd >> ${script}
	echo $cmd >> ${script}
}

script=/awips2/tmp/DR4716_updateScript.txt
rm -f ${script}
touch ${script}

for site in ${simpleSites} ; do
	xxx=`echo ${site} | sed -e 's/^.//'`
	addUpdate ${site} ${xxx}
done

for line in ${site3to4override} ; do
	xxx=`echo ${line} | sed -e 's/^\([^:]*\):.*$/\1/'`
	site=`echo ${line} | sed -e 's/^.*:\(\S*\)\s*$/\1/'`
	addUpdate $site $xxx
done

. ${script}
rm -f ${script}

