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
 * Hydrologicmethod generated by hbm2java
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
@Table(name = "hydrologicmethod")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Hydrologicmethod extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String hydrolMethod;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Fcstptesp> fcstptesps = new HashSet<Fcstptesp>(0);

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Set<Fcstptdeterm> fcstptdeterms = new HashSet<Fcstptdeterm>(0);

    public Hydrologicmethod() {
    }

    public Hydrologicmethod(String hydrolMethod) {
        this.hydrolMethod = hydrolMethod;
    }

    public Hydrologicmethod(String hydrolMethod, Set<Fcstptesp> fcstptesps,
            Set<Fcstptdeterm> fcstptdeterms) {
        this.hydrolMethod = hydrolMethod;
        this.fcstptesps = fcstptesps;
        this.fcstptdeterms = fcstptdeterms;
    }

    @Id
    @Column(name = "hydrol_method", unique = true, nullable = false, length = 30)
    public String getHydrolMethod() {
        return this.hydrolMethod;
    }

    public void setHydrolMethod(String hydrolMethod) {
        this.hydrolMethod = hydrolMethod;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "hydrologicmethod")
    public Set<Fcstptesp> getFcstptesps() {
        return this.fcstptesps;
    }

    public void setFcstptesps(Set<Fcstptesp> fcstptesps) {
        this.fcstptesps = fcstptesps;
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "hydrologicmethod")
    public Set<Fcstptdeterm> getFcstptdeterms() {
        return this.fcstptdeterms;
    }

    public void setFcstptdeterms(Set<Fcstptdeterm> fcstptdeterms) {
        this.fcstptdeterms = fcstptdeterms;
    }

}