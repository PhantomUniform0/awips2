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
package com.raytheon.uf.edex.decodertools.aircraft;

/**
 * Various tools to locate and manipulate parts of a weather message.
 * 
 * <pre>
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * 20071227            384 jkorman       Ported to edex.
 * </pre>
 * 
 * @author jkorman
 * @version 1
 */
public class AircraftFlightLevel {

    private Integer flightLevel = null;
    
    public AircraftFlightLevel(Integer level) {
        flightLevel = level;
    }

    public AircraftFlightLevel(Double level) {
        if(level != null) {
            flightLevel = level.intValue();
        }
    }
    
    public Integer getFlightLevel() {
        return flightLevel;
    }

    public void setFlightLevel(Integer flightLevel) {
        this.flightLevel = flightLevel;
    }
}