##
# This software was developed and / or modified by Raytheon Company,
# pursuant to Contract DG133W-05-CQ-1067 with the US Government.
# 
# U.S. EXPORT CONTROLLED TECHNICAL DATA
# This software product contains export-restricted data whose
# export/transfer/disclosure is restricted by U.S. law. Dissemination
# to non-U.S. persons whether in the United States or abroad requires
# an export license or other authorization.
# 
# Contractor Name:        Raytheon Company
# Contractor Address:     6825 Pine Street, Suite 340
#                         Mail Stop B8
#                         Omaha, NE 68106
#                         402.291.0100
# 
# See the AWIPS II Master Rights File ("Master Rights File.pdf") for
# further licensing information.
##
# ----------------------------------------------------------------------------
# This software is in the public domain, furnished "as is", without technical
# support, and with no warranty, express or implied, as to its usefulness for
# any purpose.
#
# VTEC EXT time adjust to NOW tests
#
# Author:
# ----------------------------------------------------------------------------

scripts = [
    {
    "commentary": "Clear out all Hazards Table and Grids.",
    "name": "VTEC_EXPtoNow_0",
    "productType": None,
    "clearHazardsTable": 1,
    "checkStrings": [],
    },

    {
    "commentary": "1 zone setup in future",
    "name": "VTEC_EXPtoNow_1a",
    "drtTime": "20100101_0000",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 24, 36, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 010000",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "700 PM EST Thu Dec 31 2009",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-010800-",
      "/O.NEW.KTBW.DU.Y.0001.100102T0000Z-100102T1200Z/",
      "Coastal Pasco-",
      "700 PM EST Thu Dec 31 2009",
      "...BLOWING DUST ADVISORY IN EFFECT FROM 7 PM FRIDAY TO 7 AM EST SATURDAY...",
      "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect from 7 PM Friday to 7 AM EST Saturday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - EXT to future",
    "name": "VTEC_EXPtoNow_1b",
    "drtTime": "20100101_0400",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 24, 48, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 010400",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "1100 PM EST Thu Dec 31 2009",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-011200-",
       "/O.EXT.KTBW.DU.Y.0001.100102T0000Z-100103T0000Z/",
       "Coastal Pasco-",
       "1100 PM EST Thu Dec 31 2009",
       "...BLOWING DUST ADVISORY NOW IN EFFECT FROM 7 PM FRIDAY TO 7 PM EST SATURDAY...",
#        "The Blowing Dust Advisory is now in effect from 7 PM Friday to 7 PM EST Saturday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - EXT back towards present",
    "name": "VTEC_EXPtoNow_1c",
    "drtTime": "20100101_1300",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 18, 48, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 011300",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "800 AM EST Fri Jan 1 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-012100-",
      "/O.EXT.KTBW.DU.Y.0001.100101T1800Z-100103T0000Z/",
      "Coastal Pasco-",
      "800 AM EST Fri Jan 1 2010",
      "...BLOWING DUST ADVISORY NOW IN EFFECT FROM 1 PM THIS AFTERNOON TO 7 PM EST SATURDAY...",
#       "The Blowing Dust Advisory is now in effect from 1 PM this afternoon to 7 PM EST Saturday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",

       ],
    },

    {
    "commentary": "1 zone setup in future - EXT back to now",
    "name": "VTEC_EXPtoNow_1d",
    "drtTime": "20100101_1500",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 15, 48, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 011500",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "1000 AM EST Fri Jan 1 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-012300-",
       "/O.EXT.KTBW.DU.Y.0001.100101T1500Z-100103T0000Z/",
       "Coastal Pasco-",
       "1000 AM EST Fri Jan 1 2010",
       "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 7 PM EST SATURDAY...",
#        "The Blowing Dust Advisory is now in effect until 7 PM EST Saturday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - CAN",
    "name": "VTEC_EXPtoNow_1e",
    "drtTime": "20100101_1900",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ],
    "checkStrings": [
       "WWUS72 KTBW 011900",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "200 PM EST Fri Jan 1 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-012000-",
       "/O.CAN.KTBW.DU.Y.0001.000000T0000Z-100103T0000Z/",
       "Coastal Pasco-",
       "200 PM EST Fri Jan 1 2010",
       "...BLOWING DUST ADVISORY IS CANCELLED...",
       "The National Weather Service in Tampa Bay Ruskin has cancelled the Blowing Dust Advisory.",
       "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future (NEW->CON->EXT test)",
    "name": "VTEC_EXPtoNow_2a",
    "drtTime": "20100102_0000",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 30, 36, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 020000",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "700 PM EST Fri Jan 1 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-020800-",
      "/O.NEW.KTBW.DU.Y.0002.100102T0600Z-100102T1200Z/",
      "Coastal Pasco-",
      "700 PM EST Fri Jan 1 2010",
      "...BLOWING DUST ADVISORY IN EFFECT FROM 1 AM TO 7 AM EST SATURDAY...",
      "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect from 1 AM to 7 AM EST Saturday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->CON->EXT test)",
    "name": "VTEC_EXPtoNow_2b",
    "drtTime": "20100102_0200",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 30, 36, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 020200",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "900 PM EST Fri Jan 1 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-021000-",
       "/O.CON.KTBW.DU.Y.0002.100102T0600Z-100102T1200Z/",
       "Coastal Pasco-",
       "900 PM EST Fri Jan 1 2010",
       "...BLOWING DUST ADVISORY REMAINS IN EFFECT FROM 1 AM TO 7 AM EST SATURDAY...",
#        "A Blowing Dust Advisory remains in effect from 1 AM to 7 AM EST Saturday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->CON->EXT test)",
    "name": "VTEC_EXPtoNow_2c",
    "drtTime": "20100102_0400",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 28, 36, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 020400",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1100 PM EST Fri Jan 1 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-021200-",
      "/O.EXT.KTBW.DU.Y.0002.100102T0400Z-100102T1200Z/",
      "Coastal Pasco-",
      "1100 PM EST Fri Jan 1 2010",
      "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 7 AM EST SATURDAY...",
#       "The Blowing Dust Advisory is now in effect until 7 AM EST Saturday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->CON->EXT test)",
    "name": "VTEC_EXPtoNow_2d",
    "drtTime": "20100102_0600",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ],
    "checkStrings": [
      "WWUS72 KTBW 020600",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "100 AM EST Sat Jan 2 2010",
      "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
      "FLZ149-020700-",
      "/O.CAN.KTBW.DU.Y.0002.000000T0000Z-100102T1200Z/",
      "Coastal Pasco-",
      "100 AM EST Sat Jan 2 2010",
      "...BLOWING DUST ADVISORY IS CANCELLED...",
      "The National Weather Service in Tampa Bay Ruskin has cancelled the Blowing Dust Advisory.",
      "$$",
       ],
    },


    {
    "commentary": "1 zone setup in future (NEW->EXT test)",
    "name": "VTEC_EXPtoNow_3a",
    "drtTime": "20100103_0000",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 50, 60, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 030000",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "700 PM EST Sat Jan 2 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-030800-",
      "/O.NEW.KTBW.DU.Y.0003.100103T0200Z-100103T1200Z/",
      "Coastal Pasco-",
      "700 PM EST Sat Jan 2 2010",
      "...BLOWING DUST ADVISORY IN EFFECT UNTIL 7 AM EST SUNDAY...",
      "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect until 7 AM EST Sunday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT test)",
    "name": "VTEC_EXPtoNow_3b",
    "drtTime": "20100103_0100",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 49, 60, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 030100",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "800 PM EST Sat Jan 2 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-030900-",
      "/O.EXT.KTBW.DU.Y.0003.100103T0100Z-100103T1200Z/",
      "Coastal Pasco-",
      "800 PM EST Sat Jan 2 2010",
      "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 7 AM EST SUNDAY...",
#       "The Blowing Dust Advisory is now in effect until 7 AM EST Sunday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT test)",
    "name": "VTEC_EXPtoNow_3c",
    "drtTime": "20100103_0200",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 49, 60, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 030200",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "900 PM EST Sat Jan 2 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-031000-",
      "/O.CON.KTBW.DU.Y.0003.000000T0000Z-100103T1200Z/",
      "Coastal Pasco-",
      "900 PM EST Sat Jan 2 2010",
      "...BLOWING DUST ADVISORY REMAINS IN EFFECT UNTIL 7 AM EST SUNDAY...",
#       "A Blowing Dust Advisory remains in effect until 7 AM EST Sunday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },


    {
    "commentary": "1 zone setup in future (EXP,NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3d",
    "drtTime": "20100103_1200",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 70, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 031200",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "700 AM EST Sun Jan 3 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-032000-",
      "/O.EXP.KTBW.DU.Y.0003.000000T0000Z-100103T1200Z/",
      "/O.NEW.KTBW.DU.Y.0004.100103T1700Z-100103T2200Z/",
      "Coastal Pasco-",
      "700 AM EST Sun Jan 3 2010",
      "...BLOWING DUST ADVISORY IN EFFECT FROM NOON TODAY TO 5 PM EST THIS AFTERNOON...",
      "...BLOWING DUST ADVISORY HAS EXPIRED...",
      "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect from noon today to 5 PM EST this afternoon.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3e",
    "drtTime": "20100103_1240",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 80, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 031240",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "740 AM EST Sun Jan 3 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-032045-",
       "/O.EXT.KTBW.DU.Y.0004.100103T1700Z-100104T0800Z/",
       "Coastal Pasco-",
       "740 AM EST Sun Jan 3 2010",
       "...BLOWING DUST ADVISORY NOW IN EFFECT FROM NOON TODAY TO 3 AM EST MONDAY...",
#        "The Blowing Dust Advisory is now in effect from noon today to 3 AM EST Monday.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },
    {
    "commentary": "1 zone setup in future - (NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3f",
    "drtTime": "20100103_1659",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 80, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 031659",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1159 AM EST Sun Jan 3 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-040100-",
      "/O.CON.KTBW.DU.Y.0004.100103T1700Z-100104T0800Z/",
      "Coastal Pasco-",
      "1159 AM EST Sun Jan 3 2010",
      "...BLOWING DUST ADVISORY REMAINS IN EFFECT UNTIL 3 AM EST MONDAY...",
#       "A Blowing Dust Advisory remains in effect until 3 AM EST Monday.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3g",
    "drtTime": "20100103_1700",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 80, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 031700",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1200 PM EST Sun Jan 3 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-040100-",
      "/O.CON.KTBW.DU.Y.0004.000000T0000Z-100104T0800Z/",
      "Coastal Pasco-",
      "1200 PM EST Sun Jan 3 2010",
      "...BLOWING DUST ADVISORY REMAINS IN EFFECT UNTIL 3 AM EST MONDAY...",
#       "A Blowing Dust Advisory remains in effect until 3 AM EST Monday.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3h",
    "drtTime": "20100103_1701",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 80, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 031701",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1201 PM EST Sun Jan 3 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-040115-",
      "/O.CON.KTBW.DU.Y.0004.000000T0000Z-100104T0800Z/",
      "Coastal Pasco-",
      "1201 PM EST Sun Jan 3 2010",
      "...BLOWING DUST ADVISORY REMAINS IN EFFECT UNTIL 3 AM EST MONDAY...",
#       "A Blowing Dust Advisory remains in effect until 3 AM EST Monday.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "1 zone setup in future - (NEW->EXT+ test)",
    "name": "VTEC_EXPtoNow_3i",
    "drtTime": "20100104_0747",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 65, 80, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 040747",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "247 AM EST Mon Jan 4 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ149-040900-",
      "/O.EXP.KTBW.DU.Y.0004.000000T0000Z-100104T0800Z/",
      "Coastal Pasco-",
      "247 AM EST Mon Jan 4 2010",
      "...BLOWING DUST ADVISORY WILL EXPIRE AT 3 AM EST EARLY THIS MORNING...",
#       "The Blowing Dust Advisory will expire at 3 AM EST early this morning.",
      "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXA test)",
    "name": "VTEC_EXPtoNow_4a",
    "drtTime": "20100105_0000",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 100, 120, "DU.Y", ["FLZ149"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 050000",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "700 PM EST Mon Jan 4 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ149-050800-",
       "/O.NEW.KTBW.DU.Y.0005.100105T0400Z-100106T0000Z/",
       "Coastal Pasco-",
       "700 PM EST Mon Jan 4 2010",
       "...BLOWING DUST ADVISORY IN EFFECT FROM 11 PM THIS EVENING TO 7 PM EST TUESDAY...",
       "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect from 11 PM this evening to 7 PM EST Tuesday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXT/EXB test)",
    "name": "VTEC_EXPtoNow_4b",
    "drtTime": "20100105_0218",
    "productType": "Hazard_NPW_Local",
    "decodeVTEC": 0,
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 100, 130, "DU.Y", ["FLZ149","FLZ057"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 050218",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "918 PM EST Mon Jan 4 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ057-051030-",
      "/O.EXB.KTBW.DU.Y.0005.100105T0400Z-100106T1000Z/",
      "Highlands-",
      "918 PM EST Mon Jan 4 2010",
      "...BLOWING DUST ADVISORY IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
      "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect until 5 AM EST Wednesday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
      "FLZ149-051030-",
      "/O.EXT.KTBW.DU.Y.0005.100105T0400Z-100106T1000Z/",
      "Coastal Pasco-",
      "918 PM EST Mon Jan 4 2010",
      "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
#       "The Blowing Dust Advisory is now in effect until 5 AM EST Wednesday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXT/EXB test)",
    "name": "VTEC_EXPtoNow_4c",
    "drtTime": "20100105_0218",
    "productType": "Hazard_NPW_Local",
    "decodeVTEC": 0,
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 99, 130, "DU.Y", ["FLZ149","FLZ057"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 050218",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "918 PM EST Mon Jan 4 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ057-051030-",
       "/O.EXB.KTBW.DU.Y.0005.100105T0300Z-100106T1000Z/",
       "918 PM EST Mon Jan 4 2010",
       "...BLOWING DUST ADVISORY IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
       "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect until 5 AM EST Wednesday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       "FLZ149-051030-",
       "/O.EXT.KTBW.DU.Y.0005.100105T0300Z-100106T1000Z/",
       "Coastal Pasco-",
       "918 PM EST Mon Jan 4 2010",
       "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
#        "The Blowing Dust Advisory is now in effect until 5 AM EST Wednesday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXT/EXB test)",
    "name": "VTEC_EXPtoNow_4d",
    "drtTime": "20100105_0218",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 98, 130, "DU.Y", ["FLZ149","FLZ057"]),
       ],
    "checkStrings": [
       "WWUS72 KTBW 050218",
       "NPWTBW",
       "URGENT - WEATHER MESSAGE",
       "National Weather Service Tampa Bay Ruskin FL",
       "918 PM EST Mon Jan 4 2010",
       "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
       "FLZ057-051030-",
       "/O.EXB.KTBW.DU.Y.0005.100105T0218Z-100106T1000Z/",
       "Highlands-",
       "918 PM EST Mon Jan 4 2010",
       "...BLOWING DUST ADVISORY IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
       "The National Weather Service in Tampa Bay Ruskin has issued a Blowing Dust Advisory, which is in effect until 5 AM EST Wednesday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       "FLZ149-051030-",
       "/O.EXT.KTBW.DU.Y.0005.100105T0218Z-100106T1000Z/",
       "Coastal Pasco-",
       "918 PM EST Mon Jan 4 2010",
       "...BLOWING DUST ADVISORY NOW IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
#        "The Blowing Dust Advisory is now in effect until 5 AM EST Wednesday.",
#        "|* SEGMENT TEXT GOES HERE *|.",
       "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
       "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXT/EXB test)",
    "name": "VTEC_EXPtoNow_4e",
    "drtTime": "20100105_0400",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ("Fcst", "Hazards", "DISCRETE", 98, 130, "DU.Y", ["FLZ149","FLZ057"]),
       ],
    "checkStrings": [
      "WWUS72 KTBW 050400",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1100 PM EST Mon Jan 4 2010",
      "...|*Overview headline (must edit)*|...",
      ".|*Overview (must edit)*|.",
      "FLZ057-149-051200-",
      "/O.CON.KTBW.DU.Y.0005.000000T0000Z-100106T1000Z/",
      "Highlands-Coastal Pasco-",
      "1100 PM EST Mon Jan 4 2010",
      "...BLOWING DUST ADVISORY REMAINS IN EFFECT UNTIL 5 AM EST WEDNESDAY...",
#       "A Blowing Dust Advisory remains in effect until 5 AM EST Wednesday.",
#       "|* SEGMENT TEXT GOES HERE *|.",
      "A Blowing Dust Advisory means that blowing dust will restrict visibilities. Travelers are urged to use caution.",
      "$$",
       ],
    },

    {
    "commentary": "2 zone setup in future (NEW->EXT/EXB test)",
    "name": "VTEC_EXPtoNow_4f",
    "drtTime": "20100105_0522",
    "productType": "Hazard_NPW_Local",
    "createGrids": [
       ("Fcst", "Hazards", "DISCRETE", -100, 100, "<None>", "all"),
       ],
    "checkStrings": [
      "WWUS72 KTBW 050522",
      "NPWTBW",
      "URGENT - WEATHER MESSAGE",
      "National Weather Service Tampa Bay Ruskin FL",
      "1222 AM EST Tue Jan 5 2010",
      "...|*Overview headline (must edit)*|...",
       ".|*Overview (must edit)*|.",
      "FLZ057-149-050630-",
      "/O.CAN.KTBW.DU.Y.0005.000000T0000Z-100106T1000Z/",
      "Highlands-Coastal Pasco-",
      "1222 AM EST Tue Jan 5 2010",
      "...BLOWING DUST ADVISORY IS CANCELLED...",
      "The National Weather Service in Tampa Bay Ruskin has cancelled the Blowing Dust Advisory.",
      "$$",
       ],
    },

    {
    "commentary": "Deleting hazard grids.",
    "name": "VTEC_EXPtoNow_Cleanup",
    "productType": None,
    "checkStrings": [],
    "clearHazardsTable": 1,
    },
    ]

       
import TestScript
def testScript(self, dataMgr):
    defaults = {
        "database": "<site>_GRID__Fcst_00000000_0000",
        "publishGrids": 0,
        "decodeVTEC": 1,
        "gridsStartTime": "20100101_0000",
        "orderStrings": 1,
        "vtecMode": "O",
        "deleteGrids": [("Fcst", "Hazards", "SFC", "all", "all")],
        }
    return TestScript.generalTestScript(self, dataMgr, scripts, defaults)



