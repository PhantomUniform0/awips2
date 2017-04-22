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
package com.raytheon.uf.edex.plugin.mpe.dao.impl;

import java.util.List;

import com.raytheon.uf.common.dataplugin.shef.tables.Ingestfilter;
import com.raytheon.uf.common.dataplugin.shef.tables.IngestfilterId;
import com.raytheon.uf.edex.plugin.mpe.dao.AbstractIHFSDbDao;

/**
 * IHFS Database Dao for interacting with the {@link Ingestfilter} entity.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * May 16, 2016 5571       skorolev    Initial creation
 * Jul 01, 2016 4623       skorolev    Added ({@link #getIngestInfo}
 * 
 * </pre>
 * 
 * @author skorolev
 */
public class IngestFilterDao extends
        AbstractIHFSDbDao<Ingestfilter, IngestfilterId> {
    public IngestFilterDao() {
        super(Ingestfilter.class);
    }

    /**
     * Retrieves {@link Ingestfilter} records using lid and pe.
     * 
     * @param lid
     * @param pe
     * @return a {@link List} of {@link Ingestfilter} records
     */
    public List<Ingestfilter> getTs(String lid, String pe) {

        return findByNamedQueryAndNamedParams(
                Ingestfilter.SELECT_INGESTFILTER_BY_LID_AND_PE, new String[] {
                        "lid", "pe" }, new Object[] { lid, pe });
    }

    /**
     * Retrieves {@link Ingestfilter} records using ingest = "T".
     * 
     * @return a {@link List} of {@link Ingestfilter} records
     */
    public List<Ingestfilter> getIngestInfo() {

        return findByNamedQuery(Ingestfilter.SELECT_INGESTFILTER);
    }
}
