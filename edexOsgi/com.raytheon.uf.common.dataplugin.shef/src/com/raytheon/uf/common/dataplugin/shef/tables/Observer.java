/**
* This software was developed and / or modified by Raytheon Company,
* pursuant to Contract DG133W-05-CQ-1067 with the US Government.
* 
* U.S. EXPORT CONTROLLED TECHNICAL DATA
* This software product contains export-restricted data whose
* export/transfer/disclosure is restricted by U.S. law. Dissemination
* to non-U.S. persons whether in the United States or abroad requires
* an export license or other authorization.
* 
* Contractor Name:        Raytheon Company
* Contractor Address:     6825 Pine Street, Suite 340
*                         Mail Stop B8
*                         Omaha, NE 68106
*                         402.291.0100
* 
* See the AWIPS II Master Rights File ("Master Rights File.pdf") for
* further licensing information.
**/
package com.raytheon.uf.common.dataplugin.shef.tables;
// default package
// Generated Oct 17, 2008 2:22:17 PM by Hibernate Tools 3.2.2.GA

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Observer generated by hbm2java
 * 
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Oct 17, 2008                        Initial generation by hbm2java
 * Aug 19, 2011      10672     jkorman Move refactor to new project
 * Oct 07, 2013       2361     njensen Removed XML annotations
 * 
 * </pre>
 * 
 * @author jkorman
 * @version 1.1
 */
@Entity
@Table(name = "observer")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Observer extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String lid;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Location location;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private State state;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Cooprecip cooprecip;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Coopcomms coopcomms;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Coopspons coopspons;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String a1;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String a2;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String a3;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String city;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String zip;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Date dos;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String gn;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String hphone;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String firstname;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String lastname;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String phone;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String email;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String ornr;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double rate;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String rprt;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String ssn;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String tsk;

    public Observer() {
    }

    public Observer(String lid, Location location, State state,
            Cooprecip cooprecip, Coopcomms coopcomms, Coopspons coopspons) {
        this.lid = lid;
        this.location = location;
        this.state = state;
        this.cooprecip = cooprecip;
        this.coopcomms = coopcomms;
        this.coopspons = coopspons;
    }

    public Observer(String lid, Location location, State state,
            Cooprecip cooprecip, Coopcomms coopcomms, Coopspons coopspons,
            String a1, String a2, String a3, String city, String zip, Date dos,
            String gn, String hphone, String firstname, String lastname,
            String phone, String email, String ornr, Double rate, String rprt,
            String ssn, String tsk) {
        this.lid = lid;
        this.location = location;
        this.state = state;
        this.cooprecip = cooprecip;
        this.coopcomms = coopcomms;
        this.coopspons = coopspons;
        this.a1 = a1;
        this.a2 = a2;
        this.a3 = a3;
        this.city = city;
        this.zip = zip;
        this.dos = dos;
        this.gn = gn;
        this.hphone = hphone;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.email = email;
        this.ornr = ornr;
        this.rate = rate;
        this.rprt = rprt;
        this.ssn = ssn;
        this.tsk = tsk;
    }

    @Id
    @Column(name = "lid", unique = true, nullable = false, length = 8)
    public String getLid() {
        return this.lid;
    }

    public void setLid(String lid) {
        this.lid = lid;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "lid", unique = true, nullable = false, insertable = false, updatable = false)
    public Location getLocation() {
        return this.location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "state", nullable = false)
    public State getState() {
        return this.state;
    }

    public void setState(State state) {
        this.state = state;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "recip", nullable = false)
    public Cooprecip getCooprecip() {
        return this.cooprecip;
    }

    public void setCooprecip(Cooprecip cooprecip) {
        this.cooprecip = cooprecip;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "comm", nullable = false)
    public Coopcomms getCoopcomms() {
        return this.coopcomms;
    }

    public void setCoopcomms(Coopcomms coopcomms) {
        this.coopcomms = coopcomms;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "spons", nullable = false)
    public Coopspons getCoopspons() {
        return this.coopspons;
    }

    public void setCoopspons(Coopspons coopspons) {
        this.coopspons = coopspons;
    }

    @Column(name = "a1", length = 30)
    public String getA1() {
        return this.a1;
    }

    public void setA1(String a1) {
        this.a1 = a1;
    }

    @Column(name = "a2", length = 30)
    public String getA2() {
        return this.a2;
    }

    public void setA2(String a2) {
        this.a2 = a2;
    }

    @Column(name = "a3", length = 30)
    public String getA3() {
        return this.a3;
    }

    public void setA3(String a3) {
        this.a3 = a3;
    }

    @Column(name = "city", length = 30)
    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(name = "zip", length = 10)
    public String getZip() {
        return this.zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "dos", length = 13)
    public Date getDos() {
        return this.dos;
    }

    public void setDos(Date dos) {
        this.dos = dos;
    }

    @Column(name = "gn", length = 1)
    public String getGn() {
        return this.gn;
    }

    public void setGn(String gn) {
        this.gn = gn;
    }

    @Column(name = "hphone", length = 18)
    public String getHphone() {
        return this.hphone;
    }

    public void setHphone(String hphone) {
        this.hphone = hphone;
    }

    @Column(name = "firstname", length = 12)
    public String getFirstname() {
        return this.firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Column(name = "lastname", length = 28)
    public String getLastname() {
        return this.lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Column(name = "phone", length = 18)
    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "email", length = 60)
    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "ornr", length = 4)
    public String getOrnr() {
        return this.ornr;
    }

    public void setOrnr(String ornr) {
        this.ornr = ornr;
    }

    @Column(name = "rate", precision = 17, scale = 17)
    public Double getRate() {
        return this.rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    @Column(name = "rprt", length = 60)
    public String getRprt() {
        return this.rprt;
    }

    public void setRprt(String rprt) {
        this.rprt = rprt;
    }

    @Column(name = "ssn", length = 11)
    public String getSsn() {
        return this.ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    @Column(name = "tsk", length = 13)
    public String getTsk() {
        return this.tsk;
    }

    public void setTsk(String tsk) {
        this.tsk = tsk;
    }

}