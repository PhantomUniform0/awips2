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
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Wfo generated by hbm2java
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
@Table(name = "wfo")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Wfo extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String wfo;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Counties> countiesesForSecondaryBack = new HashSet<Counties>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Counties> countiesesForWfo = new HashSet<Counties>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Counties> countiesesForPrimaryBack = new HashSet<Counties>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Nwrtransmitter> nwrtransmitters = new HashSet<Nwrtransmitter>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Location> locations = new HashSet<Location>(0);

    public Wfo() {
    }

    public Wfo(String wfo) {
        this.wfo = wfo;
    }

    public Wfo(String wfo, Set<Counties> countiesesForSecondaryBack,
            Set<Counties> countiesesForWfo,
            Set<Counties> countiesesForPrimaryBack,
            Set<Nwrtransmitter> nwrtransmitters, Set<Location> locations) {
        this.wfo = wfo;
        this.countiesesForSecondaryBack = countiesesForSecondaryBack;
        this.countiesesForWfo = countiesesForWfo;
        this.countiesesForPrimaryBack = countiesesForPrimaryBack;
        this.nwrtransmitters = nwrtransmitters;
        this.locations = locations;
    }

    @Id
    @Column(name = "wfo", unique = true, nullable = false, length = 3)
    public String getWfo() {
        return this.wfo;
    }

    public void setWfo(String wfo) {
        this.wfo = wfo;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "wfoBySecondaryBack")
    public Set<Counties> getCountiesesForSecondaryBack() {
        return this.countiesesForSecondaryBack;
    }

    public void setCountiesesForSecondaryBack(
            Set<Counties> countiesesForSecondaryBack) {
        this.countiesesForSecondaryBack = countiesesForSecondaryBack;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "wfoByWfo")
    public Set<Counties> getCountiesesForWfo() {
        return this.countiesesForWfo;
    }

    public void setCountiesesForWfo(Set<Counties> countiesesForWfo) {
        this.countiesesForWfo = countiesesForWfo;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "wfoByPrimaryBack")
    public Set<Counties> getCountiesesForPrimaryBack() {
        return this.countiesesForPrimaryBack;
    }

    public void setCountiesesForPrimaryBack(
            Set<Counties> countiesesForPrimaryBack) {
        this.countiesesForPrimaryBack = countiesesForPrimaryBack;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "wfo")
    public Set<Nwrtransmitter> getNwrtransmitters() {
        return this.nwrtransmitters;
    }

    public void setNwrtransmitters(Set<Nwrtransmitter> nwrtransmitters) {
        this.nwrtransmitters = nwrtransmitters;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "wfo")
    public Set<Location> getLocations() {
        return this.locations;
    }

    public void setLocations(Set<Location> locations) {
        this.locations = locations;
    }

}