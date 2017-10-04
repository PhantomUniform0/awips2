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

// Generated Oct 17, 2008 2:22:17 PM by Hibernate Tools 3.2.2.GA

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import com.raytheon.uf.common.dataplugin.persist.PersistableDataObject;
import com.raytheon.uf.common.serialization.annotations.DynamicSerialize;
import com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement;

/**
 * DatalimitsId generated by hbm2java
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
 * May 23, 2016       5590     bkowal  Cleanup.
 * 
 * </pre>
 * 
 * @author jkorman
 */
@Embeddable
@DynamicSerialize
public class DatalimitsId extends PersistableDataObject<DatalimitsId> implements
        Serializable {

    private static final long serialVersionUID = 1L;

    @DynamicSerializeElement
    private String pe;

    @DynamicSerializeElement
    private short dur;

    @DynamicSerializeElement
    private String monthdaystart;

    public DatalimitsId() {
    }

    public DatalimitsId(String pe, short dur, String monthdaystart) {
        this.pe = pe;
        this.dur = dur;
        this.monthdaystart = monthdaystart;
    }

    @Column(name = "pe", nullable = false, length = 2)
    public String getPe() {
        return this.pe;
    }

    public void setPe(String pe) {
        this.pe = pe;
    }

    @Column(name = "dur", nullable = false)
    public short getDur() {
        return this.dur;
    }

    public void setDur(short dur) {
        this.dur = dur;
    }

    @Column(name = "monthdaystart", nullable = false, length = 5)
    public String getMonthdaystart() {
        return this.monthdaystart;
    }

    public void setMonthdaystart(String monthdaystart) {
        this.monthdaystart = monthdaystart;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof DatalimitsId))
            return false;
        DatalimitsId castOther = (DatalimitsId) other;

        return ((this.getPe() == castOther.getPe()) || (this.getPe() != null
                && castOther.getPe() != null && this.getPe().equals(
                castOther.getPe())))
                && (this.getDur() == castOther.getDur())
                && ((this.getMonthdaystart() == castOther.getMonthdaystart()) || (this
                        .getMonthdaystart() != null
                        && castOther.getMonthdaystart() != null && this
                        .getMonthdaystart()
                        .equals(castOther.getMonthdaystart())));
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + (getPe() == null ? 0 : this.getPe().hashCode());
        result = 37 * result + this.getDur();
        result = 37
                * result
                + (getMonthdaystart() == null ? 0 : this.getMonthdaystart()
                        .hashCode());
        return result;
    }

}