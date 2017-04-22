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
package com.raytheon.edex.plugin.gfe.config;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.raytheon.edex.plugin.gfe.exception.GfeConfigurationException;
import com.raytheon.edex.plugin.gfe.exception.GfeMissingConfigurationException;
import com.raytheon.uf.common.dataplugin.gfe.discrete.DiscreteDefinition;
import com.raytheon.uf.common.dataplugin.gfe.discrete.DiscreteKey;
import com.raytheon.uf.common.dataplugin.gfe.python.GfePyIncludeUtil;
import com.raytheon.uf.common.dataplugin.gfe.weather.WeatherSubKey;
import com.raytheon.uf.common.dataplugin.gfe.weather.WxDefinition;
import com.raytheon.uf.common.localization.IPathManager;
import com.raytheon.uf.common.localization.LocalizationContext;
import com.raytheon.uf.common.localization.LocalizationUtil;
import com.raytheon.uf.common.localization.PathManagerFactory;
import com.raytheon.uf.common.python.PyUtil;
import com.raytheon.uf.common.python.PythonEval;

/**
 * Manages the serverConfigs of active sites
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Jul 9, 2009             njensen     Initial creation
 * Dec 11, 2012 14360      ryu         Throw specific exception for missing configuration.
 * Feb 20, 2014 #2824      randerso    Fixed import of localVTECPartners to use siteID
 *                                     Added common python path for LogStream
 * Jul 09, 2014 #3146      randerso    Improved exception handling
 * Dec 15, 2015 #5166      kbisanz     Update logging to use SLF4J
 * Jul 13, 2016 #5747      dgilling    Move edex_static to common_static.
 * Aug 08, 2016 #5747      randerso    Moved additional files to common static.
 *                                     Eliminated wrapper.py
 * 
 * </pre>
 * 
 * @author njensen
 */

public class IFPServerConfigManager {

    private static final Logger logger = LoggerFactory
            .getLogger(IFPServerConfigManager.class);

    private static final String CONFIG_PATH = LocalizationUtil.join("gfe",
            "config");

    private static Map<String, IFPServerConfig> configMap = new HashMap<>();

    private static Set<String> activeSites = new HashSet<>();

    /**
     * Returns the sites that have active configurations
     * 
     * @return
     */
    protected static Set<String> getActiveSites() {
        return activeSites;
    }

    /**
     * Gets the server configuration for a particular site
     * 
     * @param siteID
     *            the site
     * @return the site's configuration
     * @throws GfeConfigurationException
     *             if the site is not active
     */
    public static IFPServerConfig getServerConfig(String siteID)
            throws GfeConfigurationException {
        IFPServerConfig config = configMap.get(siteID);
        if (config == null) {
            throw new GfeConfigurationException("Site " + siteID
                    + " has no active GFE configuration.");
        }
        return config;
    }

    /**
     * Initializes a site's serverConfig by reading in the site's localConfig
     * 
     * @param siteID
     *            the site
     * @return the site's configuration
     * @throws GfeConfigurationException
     */
    protected static IFPServerConfig initializeSite(String siteID)
            throws GfeConfigurationException {
        IFPServerConfig siteConfig = null;
        siteConfig = initializeConfig(siteID);
        if (siteConfig != null) {
            configMap.put(siteID, siteConfig);
        }

        WxDefinition wxDef = siteConfig.getWxDefinition();
        WeatherSubKey.setWxDefinition(siteID, wxDef);

        DiscreteDefinition dxDef = siteConfig.getDiscreteDefinition();
        DiscreteKey.setDiscreteDefinition(siteID, dxDef);

        return siteConfig;
    }

    /**
     * Add a site to the active sites list
     * 
     * @param siteID
     *            the site to be added
     */
    public static void addActiveSite(String siteID) {
        activeSites.add(siteID);
    }

    /**
     * Initialize an IFPServerConfig object for a site
     * 
     * @param siteID
     *            the desired site
     * @return the IFPServerConfig object
     * @throws GfeConfigurationException
     */
    public static IFPServerConfig initializeConfig(String siteID)
            throws GfeConfigurationException {
        String baseDir = "";
        String siteDir = "";
        IFPServerConfig siteConfig = null;

        IPathManager pathMgr = PathManagerFactory.getPathManager();
        LocalizationContext baseCtx = pathMgr.getContext(
                LocalizationContext.LocalizationType.COMMON_STATIC,
                LocalizationContext.LocalizationLevel.BASE);
        LocalizationContext siteCtx = pathMgr.getContextForSite(
                LocalizationContext.LocalizationType.COMMON_STATIC, siteID);

        baseDir = pathMgr.getFile(baseCtx, CONFIG_PATH).getPath();
        File siteDirFile = pathMgr.getFile(siteCtx, CONFIG_PATH);
        if (siteDirFile.exists()) {
            File[] siteFiles = siteDirFile.listFiles();
            boolean siteConfigFound = false;
            for (File f : siteFiles) {
                if (f.getName().equals("siteConfig.py")) {
                    siteConfigFound = true;
                    break;
                }
            }
            if (!siteConfigFound) {
                throw new GfeMissingConfigurationException(
                        "No siteConfig.py file found for " + siteID);
            }
        } else {
            throw new GfeMissingConfigurationException(
                    "No site config directory found for " + siteID);
        }
        siteDir = siteDirFile.getPath();

        String gfeCommonPath = GfePyIncludeUtil.getCommonGfeIncludePath();

        String vtecPath = GfePyIncludeUtil.getVtecIncludePath(siteID);

        try (PythonEval py = new PythonEval(PyUtil.buildJepIncludePath(siteDir,
                baseDir, gfeCommonPath, vtecPath),
                IFPServerConfig.class.getClassLoader())) {
            py.eval("from serverConfig import *");
            SimpleServerConfig simpleConfig = (SimpleServerConfig) py.execute(
                    "getSimpleConfig", null);
            siteConfig = new IFPServerConfig(simpleConfig);
        } catch (Throwable e) {
            throw new GfeConfigurationException(
                    "Exception occurred while processing serverConfig for site "
                            + siteID, e);
        }

        return siteConfig;
    }

    /**
     * Removes a site's configuration from the set of active configurations
     * 
     * @param siteID
     */
    protected static void removeSite(String siteID) {
        if (configMap.containsKey(siteID)) {
            configMap.remove(siteID);
            activeSites.remove(siteID);
        } else {
            logger.debug("Can't deactivate inactive site " + siteID);
        }
    }

    protected static void removeActiveSite(String siteID) {
        activeSites.remove(siteID);
    }

}
