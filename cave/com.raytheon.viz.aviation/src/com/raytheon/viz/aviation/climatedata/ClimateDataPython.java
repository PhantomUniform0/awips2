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
package com.raytheon.viz.aviation.climatedata;

import java.io.File;
import java.io.FileFilter;

import jep.JepException;

import com.raytheon.uf.common.localization.IPathManager;
import com.raytheon.uf.common.localization.PathManagerFactory;
import com.raytheon.uf.common.python.PyUtil;
import com.raytheon.uf.common.status.IUFStatusHandler;
import com.raytheon.uf.common.status.UFStatus;
import com.raytheon.uf.common.status.UFStatus.Priority;
import com.raytheon.uf.viz.core.VizApp;
import com.raytheon.uf.viz.core.exception.VizException;
import com.raytheon.viz.aviation.climatology.ClimatePython;
import com.raytheon.viz.aviation.monitor.AvnPyUtil;

/**
 * This invokes python to run climate data python code derived from AWIP I.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Nov 17, 2009            avarani     Initial creation
 * Feb 16, 2011 7878       rferrel     Modifications for create ident/site.
 * Jul 07, 2015 16907      zhao        Changed 'ish-' to 'isd-'
 * Jun 16, 2016 5693       rferrel     Added method getSiteList.
 * 
 * </pre>
 * 
 * @author avarani
 * @version 1.0
 */

public class ClimateDataPython {
    private static final transient IUFStatusHandler statusHandler = UFStatus
            .getHandler(ClimateDataPython.class);

    private final static String HD5_SUFFIX = ".hd5";

    private static PythonClimateDataProcess initializePython()
            throws JepException {
        IPathManager pm = PathManagerFactory.getPathManager();
        File runner = pm.getStaticFile("aviation/python/ClimateDataEntry.py");
        String filePath = runner.getPath();
        String includePath = PyUtil.buildJepIncludePath(runner.getParentFile()
                .getPath(), AvnPyUtil.getLoggingHandlerDir(), AvnPyUtil
                .getPointDataDir(), AvnPyUtil.getCommonPythonDir());
        PythonClimateDataProcess python = new PythonClimateDataProcess(
                filePath, includePath, ClimatePython.class.getClassLoader());
        return python;
    }

    public static synchronized PythonClimateDataProcess getClimateInterpreter() {
        PythonClimateDataProcess python = null;
        try {
            python = initializePython();
        } catch (JepException e) {
            statusHandler.handle(Priority.PROBLEM,
                    "Error initializing climate python interpreter", e);
        }
        return python;
    }

    /**
     * Obtain path name of the directory with the ISD files and verify the files
     * exist.
     * 
     * @return dataDir
     * @throws VizException
     *             when unable to find ISD files
     */
    public static String getIshFilePath() throws VizException {
        File dataDir = getClimateDir();

        File histFile = new File(dataDir, "isd-history.txt");
        if (histFile == null || !histFile.exists()) {
            throw new VizException(String.format(
                    "ISD history file: \"%s\" does not exist.",
                    histFile.getPath()));
        }

        File invFile = new File(dataDir, "isd-inventory.txt");
        if (invFile == null || !invFile.exists()) {
            throw new VizException(String.format(
                    "ISD inventory file: \"%s\" does not exist.",
                    invFile.getPath()));
        }

        return dataDir.getPath();
    }

    public static String getClimateFilePath(String site) throws VizException {
        File dataDir = getClimateDir();
        File file = new File(dataDir, site + HD5_SUFFIX);
        String climateFile = file.getPath();
        return climateFile;
    }

    /**
     * Get a list of sites with hd5 files in the climate directory.
     * 
     * @return sites
     * @throws VizException
     */
    public static String[] getSiteList() throws VizException {
        File dataDir = getClimateDir();
        File[] files = dataDir.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return pathname.getName().endsWith(HD5_SUFFIX)
                        && pathname.isFile();
            }
        });
        String[] sites = new String[files.length];
        int sufixLength = HD5_SUFFIX.length();
        for (int index = 0; index < files.length; ++index) {
            String filename = files[index].getName();
            sites[index] = filename.substring(0, filename.length()
                    - sufixLength);
        }
        return sites;
    }

    /**
     * 
     * @return climate data directory
     * @throws VizException
     */
    private static File getClimateDir() throws VizException {
        String dataDirStr = VizApp.getDataDir();
        File dataDir = new File(dataDirStr + "/aviation");
        if (!dataDir.exists() || !dataDir.isDirectory()) {
            throw new VizException(String.format(
                    "Directory: \"%s\" does not exist.", dataDir.getPath()));
        }
        return dataDir;
    }

}