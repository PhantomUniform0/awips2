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

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Colorname generated by hbm2java
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
@Table(name = "colorname")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Colorname extends
        com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements
        java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String colorName;

    // @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    // private Set<Colorvalue> colorvalues = new HashSet<Colorvalue>(0);

    // @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    // private Set<Coloroverlay> coloroverlaies = new HashSet<Coloroverlay>(0);

    public Colorname() {
    }

    public Colorname(String colorName) {
        this.colorName = colorName;
    }

    // public Colorname(String colorName, Set<Colorvalue> colorvalues,
    // Set<Coloroverlay> coloroverlaies) {
    // this.colorName = colorName;
    // this.colorvalues = colorvalues;
    // this.coloroverlaies = coloroverlaies;
    // }

    @Id
    @Column(name = "color_name", unique = true, nullable = false, length = 25)
    public String getColorName() {
        return this.colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    // @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy =
    // "colorname")
    // public Set<Colorvalue> getColorvalues() {
    // return this.colorvalues;
    // }

    // public void setColorvalues(Set<Colorvalue> colorvalues) {
    // this.colorvalues = colorvalues;
    // }

    // @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy =
    // "colorname")
    // public Set<Coloroverlay> getColoroverlaies() {
    // return this.coloroverlaies;
    // }

    // public void setColoroverlaies(Set<Coloroverlay> coloroverlaies) {
    // this.coloroverlaies = coloroverlaies;
    // }

}