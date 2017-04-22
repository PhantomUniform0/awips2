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

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import com.raytheon.uf.common.serialization.annotations.DynamicSerialize;
import com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement;

/**
 * DailyppId generated by hbm2java
 * 
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Oct 17, 2008                        Initial generation by hbm2java
 * Aug 19, 2011 10672      jkorman     Move refactor to new project
 * Oct 07, 2013  2361      njensen     Removed XML annotations
 * Jun 16, 2016  4623      skorolev    Cleanup
 * 
 * </pre>
 * 
 * @author jkorman
 */
@Embeddable
@DynamicSerialize
public class DailyppId implements Serializable {

    private static final long serialVersionUID = 1L;

    @DynamicSerializeElement
    private String lid;

    @DynamicSerializeElement
    private String ts;

    @DynamicSerializeElement
    private Date obstime;

    public DailyppId() {
    }

    public DailyppId(String lid, String ts, Date obstime) {
        this.lid = lid;
        this.ts = ts;
        this.obstime = obstime;
    }

    @Column(name = "lid", nullable = false, length = 8)
    public String getLid() {
        return this.lid;
    }

    public void setLid(String lid) {
        this.lid = lid;
    }

    @Column(name = "ts", nullable = false, length = 2)
    public String getTs() {
        return this.ts;
    }

    public void setTs(String ts) {
        this.ts = ts;
    }

    @Column(name = "obstime", nullable = false, length = 29)
    public Date getObstime() {
        return this.obstime;
    }

    public void setObstime(Date obstime) {
        this.obstime = obstime;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof DailyppId))
            return false;
        DailyppId castOther = (DailyppId) other;

        return ((this.getLid() == castOther.getLid()) || (this.getLid() != null
                && castOther.getLid() != null && this.getLid().equals(
                castOther.getLid())))
                && ((this.getTs() == castOther.getTs()) || (this.getTs() != null
                        && castOther.getTs() != null && this.getTs().equals(
                        castOther.getTs())))
                && ((this.getObstime() == castOther.getObstime()) || (this
                        .getObstime() != null && castOther.getObstime() != null && this
                        .getObstime().equals(castOther.getObstime())));
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result
                + (getLid() == null ? 0 : this.getLid().hashCode());
        result = 37 * result + (getTs() == null ? 0 : this.getTs().hashCode());
        result = 37 * result
                + (getObstime() == null ? 0 : this.getObstime().hashCode());
        return result;
    }

}
