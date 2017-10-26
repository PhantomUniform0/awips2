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

import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Counties generated by hbm2java
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
@Table(name = "counties")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Counties extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private CountiesId id;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Wfo wfoByPrimaryBack;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private State state;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Wfo wfoBySecondaryBack;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Wfo wfoByWfo;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String countynum;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Location> locations = new HashSet<Location>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Nwrtransmitter> nwrtransmitters = new HashSet<Nwrtransmitter>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Location> locations_1 = new HashSet<Location>(0);

    public Counties() {
    }

    public Counties(CountiesId id, Wfo wfoByPrimaryBack, State state,
            Wfo wfoBySecondaryBack, Wfo wfoByWfo) {
        this.id = id;
        this.wfoByPrimaryBack = wfoByPrimaryBack;
        this.state = state;
        this.wfoBySecondaryBack = wfoBySecondaryBack;
        this.wfoByWfo = wfoByWfo;
    }

    public Counties(CountiesId id, Wfo wfoByPrimaryBack, State state,
            Wfo wfoBySecondaryBack, Wfo wfoByWfo, String countynum,
            Set<Location> locations, Set<Nwrtransmitter> nwrtransmitters,
            Set<Location> locations_1) {
        this.id = id;
        this.wfoByPrimaryBack = wfoByPrimaryBack;
        this.state = state;
        this.wfoBySecondaryBack = wfoBySecondaryBack;
        this.wfoByWfo = wfoByWfo;
        this.countynum = countynum;
        this.locations = locations;
        this.nwrtransmitters = nwrtransmitters;
        this.locations_1 = locations_1;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "county", column = @Column(name = "county", nullable = false, length = 20)),
            @AttributeOverride(name = "state", column = @Column(name = "state", nullable = false, length = 2)) })
    public CountiesId getId() {
        return this.id;
    }

    public void setId(CountiesId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "primary_back", nullable = false)
    public Wfo getWfoByPrimaryBack() {
        return this.wfoByPrimaryBack;
    }

    public void setWfoByPrimaryBack(Wfo wfoByPrimaryBack) {
        this.wfoByPrimaryBack = wfoByPrimaryBack;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "state", nullable = false, insertable = false, updatable = false)
    public State getState() {
        return this.state;
    }

    public void setState(State state) {
        this.state = state;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "secondary_back", nullable = false)
    public Wfo getWfoBySecondaryBack() {
        return this.wfoBySecondaryBack;
    }

    public void setWfoBySecondaryBack(Wfo wfoBySecondaryBack) {
        this.wfoBySecondaryBack = wfoBySecondaryBack;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "wfo", nullable = false)
    public Wfo getWfoByWfo() {
        return this.wfoByWfo;
    }

    public void setWfoByWfo(Wfo wfoByWfo) {
        this.wfoByWfo = wfoByWfo;
    }

    @Column(name = "countynum", length = 4)
    public String getCountynum() {
        return this.countynum;
    }

    public void setCountynum(String countynum) {
        this.countynum = countynum;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "counties")
    public Set<Location> getLocations() {
        return this.locations;
    }

    public void setLocations(Set<Location> locations) {
        this.locations = locations;
    }

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    public Set<Nwrtransmitter> getNwrtransmitters() {
        return this.nwrtransmitters;
    }

    public void setNwrtransmitters(Set<Nwrtransmitter> nwrtransmitters) {
        this.nwrtransmitters = nwrtransmitters;
    }

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    public Set<Location> getLocations_1() {
        return this.locations_1;
    }

    public void setLocations_1(Set<Location> locations_1) {
        this.locations_1 = locations_1;
    }

}