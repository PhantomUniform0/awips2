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
package com.raytheon.uf.common.mpe.gribit2.grid;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

import com.raytheon.uf.common.mpe.gribit2.grib.IMultiGridDefinitionMapping;

/**
 * Abstraction of a latitude/longitude grid definition. Based on:
 * /rary.ohd.pproc.gribit/TEXT/w3fi71.f
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Jul 13, 2016 4619       bkowal      Initial creation
 * Aug 10, 2016 4619       bkowal      Implement {@link IMultiGridDefinitionMapping}.
 * 
 * </pre>
 * 
 * @author bkowal
 */
@XmlAccessorType(XmlAccessType.NONE)
public abstract class AbstractLatLonGridDefinition extends
        AbstractLatLonCommon12 implements IMultiGridDefinitionMapping {

    /**
     * SCANNING MODE FLAGS (CODE TABLE 8)
     */
    @XmlElement(required = true)
    private int scanningModeFlag;

    @Override
    public int get9thValue() {
        return getExtremePointLat();
    }

    @Override
    public int get10thValue() {
        return getExtremePointLon();
    }

    @Override
    public int get11thValue() {
        return getIncrementLat();
    }

    @Override
    public int get12thValue() {
        return getIncrementLon();
    }

    @Override
    public int getScanningModeFlag() {
        return scanningModeFlag;
    }

    public void setScanningModeFlag(int scanningModeFlag) {
        this.scanningModeFlag = scanningModeFlag;
    }

    @Override
    public String toString() {
        /*
         * The class name and opening, closing brackets are excluded in this
         * toString method because this method should ideally only be used
         * directly by a subclass.
         */
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString());
        sb.append(", scanningModeFlag=").append(scanningModeFlag);
        return sb.toString();
    }
}