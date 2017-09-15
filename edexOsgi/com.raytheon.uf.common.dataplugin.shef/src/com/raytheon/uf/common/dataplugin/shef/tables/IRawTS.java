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

/**
 * Interface for RawPC and RawPP.
 * 
 * <pre>
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Nov 23, 2008 1662       grichard    Initial creation.
 * May 26, 2016 5571       skorolev    Added methods.
 * 
 * </pre>
 * 
 * @author grichard
 */

public interface IRawTS {
    public String getLid();

    public String getTs();

    public short getDur();

    public String getExtremum();

    public java.util.Date getObstime();

    public String getShefQualCode();

    public Double getValue();
}