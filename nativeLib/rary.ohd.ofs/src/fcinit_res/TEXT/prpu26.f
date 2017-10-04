C MEMBER PRPU26
C  (from old member FCPRPU26)
C
      SUBROUTINE PRPU26(PO,IBASE,LP,LT)
C
C***********************************************************:
C
C     PRINT UTILITIES
C
      REAL NORMP,NORMQ
      REAL*8 RAINKW(3),ADJKW(7)
      LOGICAL NOPARM
c      DIMENSION PO(*),X(365),Y(365),IDAY(365),UTILS(22),
      DIMENSION PO(*),X(365),Y(365),IDAY(365),
     1 ANAME(5),ADJFAC(6)
      INCLUDE 'common/ionum'
      INCLUDE 'common/comn26'
      COMMON/CNVP26/CONV1,CONV2,CONV3,CONV4,CONV5,UNT1,UNT2,UNT3,UNT4,
     .      UNT5
      COMMON/ADJ26/NTS17
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_res/RCS/prpu26.f,v $
     . $',                                                             '
     .$Id: prpu26.f,v 1.5 2004/04/07 14:42:46 hsu Exp $
     . $' /
C    ===================================================================
C
C
      DATA BLANK/4H    /
C
c      DATA UTILS/4HRULE,4HADJ ,4HSUMI,4HNF  ,4HRAIN,4HEVAP,4HADJU,
c     1 4HST  ,4HBACK,4HFLOW ,4HCONV,4H24  ,4HMAXQ,4H    ,4HENTE,
c     2 4HRISC,4HSETM,4HIN  ,4HSETM,4HAX  ,4HGOFL,4HASH /
C
      DATA ADJFAC/4HRATI,4HOS. ,4H    ,
     .            4HDIFF,4HEREN,4HCES./
      DATA RAINKW/8HPCPN    ,8HEVAP    ,8HADDQ      /
      DATA ADJKW/8HOBSQO   ,8HOBSQOM  ,8HOBSH      ,8HADJQO   ,
     18HADJQOM  ,8HADJH    ,8HADJS    /
C
      NUM=IBASE-150
      IGOTO=NUM
      J2=NUM*2
      J1=J2-1
      GO TO (1510,1520,1530,1540,1550,1560,1570,1580,1590,1600
     &       ,1610,1620),IGOTO
C***********************************************************************
C***********************************************************************
C
C     RULECURVE ADJUSTMENT UTILITY
C
 1510  WRITE(IPR,699)
cc      WRITE(IPR,2000)UTILS(J1),UTILS(J2)
      WRITE(IPR,2000)
 2000 FORMAT(1H0,10X,7HRULEADJ,30H -RULECURVE ADJUSTMENT UTILITY)
      NVAL=PO(LP)
      LO=LP
      MOVE=0
      NLOC=LO
      IF(NVAL.GT.0)GO TO 261
      MOVE=1
      LO=-1*NVAL+PO(10)-1
 261  NVAL=PO(LO)
      DO 262 J=1,NVAL
 262  IDAY(J)=PO(LO+J)
      LO=LO+NVAL
      DO 264 J=1,NVAL
 264  X(J)=PO(LO+J)*CONV1
      WRITE(IPR,820)
      JB=1
      JE=NVAL
      IF(JE.GT.8)JE=8
 265  WRITE(IPR,825) (IDAY(J),J=JB,JE)
      WRITE(IPR,830)UNT1,(X(J),J=JB,JE)
      IF(JE.GE.NVAL)GO TO 266
      JB=JE+1
      JE=JE+8
      IF(JE.GT.NVAL)JE=NVAL
      GO TO 265
 266  LO=LO+NVAL+1
      ITIME=PO(LO)
      LO=LO+1
      IF(MOVE.EQ.1)LO=NLOC+1
      IF(ITIME.GE.0) WRITE(IPR,832)ITIME
      INT=PO(LO)
      DIFF=PO(LO+1)*CONV1
      QABOVE=PO(LO+2)*CONV2
      WRITE(IPR,2015)INT
 2015 FORMAT(1H0,20X,50HNUMBER OF TIME PERIODS FOR COMPUTING DEVIATION
     1 =,I8)
      WRITE(IPR,2020)DIFF,UNT1
 2020 FORMAT(1H0,20X,37HMAX DIFFERENCE BETWEEN OBSERVED LEVEL/,23X,
     1 48HAND RULE CURVE FOR WHICH TO IGNORE DEVIATIONS  =,F11.2,1X,A4)
      WRITE(IPR,2025)QABOVE,UNT2
 2025 FORMAT(1H0,20X,40HINFLOW VALUE ABOVE WHICH DEVIATIONS FROM/,23X,
     1 48HTHE RULECURVE ARE IGNORED                      =,F11.2,1X,A4)
C
      IT=PO(LT+3)
      WRITE(IPR,795)
      WRITE(IPR,798)PO(LT),PO(LT+1),PO(LT+2),IT
      GO TO 500
C***********************************************************************
C
C     INFLOW SUMMATION UTILITY
C
 1520  WRITE(IPR,699)
cc      WRITE(IPR,2040)UTILS(J1),UTILS(J2)
      WRITE(IPR,2040)
 2040 FORMAT(1H0,10X,6HSUMINF,26H -INFLOW SUMMATION UTILITY)
      NORMQ=PO(LP)*CONV2
      CREST=PO(LP+1)*CONV1
      WRITE(IPR,2050)NORMQ,UNT2
      WRITE(IPR,2055)CREST,UNT1
 2050 FORMAT(1H0,20X,50HNORMAL OPERATION RELEASE
     1 =,F11.2,1X,A4)
 2055 FORMAT(1H0,20X,50HPOOL LEVEL CRITERION
     1 =,F11.2,1X,A4)
      GO TO 500
C***********************************************************************
C
C     RAIN/EVAP UTILITY
C
 1530  WRITE(IPR,699)
CC      WRITE(IPR,2062)UTILS(J1),UTILS(J2)
      WRITE(IPR,2062)
 2062 FORMAT(1H0,10X,8HRAINEVAP,30H -RAINFALL/EVAPORATION UTILITY)
      IWHICH=PO(LP)
      LO=LP
      IF(IWHICH.EQ.0)GO TO 284
      IF(IWHICH.LT.0)WRITE(IPR,2065)
 2065 FORMAT(1H0,20X,38HEVAPORATION EFFECTS ARE NOT CONSIDERED)
      IF(IWHICH.LT.0)GO TO 287
      WRITE(IPR,2070)
 2070 FORMAT(1H0,20X,41HEVAPORATION IS SPECIFIED BY A TIME SERIES)
C  THE FOLLOWING CHANGE MADE ON 10/17/90
C      GO TO 287
      GO TO 281
C  END OF CHANGE OF 10/17/90
C
 284  DO 286 J=1,12
 286  X(J)=PO(LO+J)*CONV5
      LO=LO+12
      WRITE(IPR,2067)UNT5
 2067 FORMAT(1H0,20X,31HMEAN MONTHLY EVAPORATION VALUES,1H(,A4,1H))
      WRITE(IPR,2068)(X(J),J=1,12)
 2068 FORMAT(1H0,25X,12F7.2)
C  THE FOLLOWING CHANGE MADE ON 10/17/90
C      IT=PO(7)
  281 IT=PO(7)
C  END OF CHANGE OF 10/17/90
      NDT=24/IT
      WRITE(IPR,2066)
 2066 FORMAT(1H0,20X,26HDAILY DISTRIBUTION FACTORS)
      DO 283 J=1,NDT
 283  X(J)=PO(LO+J)
      LO=LO+NDT
      WRITE(IPR,2069)(X(J),J=1,NDT)
 2069 FORMAT(1H0,(T26,8F10.6))
C
 287  LO=LO+1
C  CONVERSION FROM SQUARE KILOMETER TO ACRE
      HREA=PO(LO)
      IF(HREA .LE. 1.0) GO TO 289
      IF(IMETEN .LE. 0) GO TO 288
      WRITE(IPR,2060) HREA
 2060 FORMAT(1H0,20X,'SURFACE AREA FOR RAIN-EVAP HELD AT',
     1' ELEVATION= ',F11.0,' METER')
      GO TO 289
 288  HREAX= HREA*CONV1
      WRITE(IPR,2061) HREAX
 2061 FORMAT(1H0,20X,'SURFACE AREA FOR RAIN-EVAP HELD AT',
     1' ELEVATION= ',F11.0,' FT')
C
C     PRINT TIME SERIES INFORMATION
 289  WRITE(IPR,795)
      DO 285 J=1,3
      IF(J.EQ.2 .AND. IWHICH.LE.0)GO TO 285
      IF(PO(LT).EQ.BLANK)GO TO 282
      IT=PO(LT+3)
      WRITE(IPR,799) RAINKW(J),PO(LT),PO(LT+1),PO(LT+2),IT
      LT=LT+5
      GO TO 285
 282  LT=LT+2
 285  CONTINUE
      GO TO 500
C***********************************************************************
C
C     DISCHARGE AND POOL ELEVATION ADJUSTMENT UTILITY
C
 1540  WRITE(IPR,699)
CC      WRITE(IPR,2085)UTILS(J1),UTILS(J2)
      WRITE(IPR,2085)
 2085 FORMAT(1H0,10X,6HADJUST,
     & 50H -DISCHARGE AND POOL ELEVATION ADJUSTMENT UTILITY )
C
C  PRINT PARAMETER INFO IF INST. DATA IS USED.
C
      NOPARM = .FALSE.
      IF (PO(LT).EQ.BLANK .AND. PO(LT+1).EQ.BLANK) NOPARM = .TRUE.
      IF (NOPARM) WRITE(IPR,3025)
      IF (NOPARM) GO TO 291
C
      IPO = PO(LP)
      WRITE(IPR,2081) IPO
 2081 FORMAT(1H0,20X,50HNUMBER OF BLEND PERIODS
     . =,I5)
      IST = PO(LP+1)*3. + 1
      WRITE(IPR,2082) ADJFAC(IST),ADJFAC(IST+1),ADJFAC(IST+2)
 2082 FORMAT(1H0,20X,37HMISSING VALUES INTERPOLATED BY USING ,3A4)
C
C     PRINT TIME SERIES INFORMATION
C
  291 CONTINUE
      WRITE(IPR,795)
      LO=LT
      DO 292 J=1,NTS17
      IF(PO(LO).EQ.BLANK)GO TO 295
      IT=PO(LO+3)
      WRITE(IPR,799) ADJKW(J),PO(LO),PO(LO+1),PO(LO+2),IT
      LO=LO+5
      GO TO 292
 295   LO=LO+2
 292   CONTINUE
      GO TO 500
C***********************************************************************
C
C     BACK COMPUTING INFLOW UTILITY
C
 1550  WRITE(IPR,699)
CC      WRITE(IPR,3020)UTILS(J1),UTILS(J2)
      WRITE(IPR,3020)
 3020 FORMAT(1H0,10X,8HBACKFLOW,31H -BACK COMPUTING INFLOW UTILITY)
      WRITE(IPR,3025)
 3025 FORMAT(1H0,20X,54HNO ADDITIONAL PARAMETERS ARE REQUIRED FOR THIS U
     1TILITY)
      WRITE(IPR,795)
      LO=LT
      DO 305 J=1,3
      IF(PO(LO).EQ.BLANK)GO TO 302
      IT=PO(LO+3)
      WRITE(IPR,798)PO(LO),PO(LO+1),PO(LO+2),IT
      LO=LO+5
      GO TO 305
 302  LO=LO+2
 305  CONTINUE
      GO TO 500
C***********************************************************************
 1560  CONTINUE
      GO TO 500
C***********************************************************************
C
C     MAXIMUM OUTFLOW FROM DAM UTILITY
C
 1570  WRITE(IPR,699)
CC      WRITE(IPR,3075)UTILS(J1),UTILS(J2)
      WRITE(IPR,3075)
 3075 FORMAT(1H0,10X,4HMAXQ,34H -MAXIMUM OUTFLOW FROM DAM UTILITY)
      LO=LP
      IWHICH=PO(LO)
      LO=LO+1
      IF(IWHICH.NE.0)GO TO 3210
      NORMQ=PO(LO)*CONV2
      WRITE(IPR,909)NORMQ,UNT2
 909  FORMAT(1H0,20X,50HCONSTANT NON-SPILLWAY MAXIMUM DISCHARGE
     1 =,F11.2,1X,A4)
      LO=LO+1
 3210 MOVE=0
      NLOC=LO
      NVAL=PO(LO)
      IF(NVAL.GT.0)GO TO 321
      MOVE=1
      LO=-1*NVAL+PO(10)-1
      NVAL=PO(LO)
 321  DO 322 J=1,NVAL
 322  X(J)=PO(LO+J)*CONV1
      LO=LO+NVAL
      DO 323 J=1,NVAL
 323  Y(J)=PO(LO+J)*CONV2
      LO=LO+NVAL+1
      IF(MOVE.EQ.1)LO=NLOC+1
      IF(IWHICH.GE.0)WRITE(IPR,862)
      IF(IWHICH.LT.0)WRITE(IPR,863)
      JB=1
      JE=NVAL
      IF(JE.GT.8)JE=8
 324  WRITE(IPR,864)UNT1,(X(J),J=JB,JE)
      IF(IWHICH.GE.0)WRITE(IPR,866)UNT2,(Y(J),J=JB,JE)
      IF(IWHICH.LT.0)WRITE(IPR,867)UNT2,(Y(J),J=JB,JE)
 867  FORMAT(1H ,25X,5HMAXQ(,A4,1H),1X,8F11.2)
      IF(JE.GE.NVAL)GO TO 325
      JB=JE+1
      JE=JE+8
      IF(JE.GT.NVAL)JE=NVAL
      GO TO 324
 325  IF(IWHICH.LE.0)GO TO 500
      NVAL=PO(LO)
      MOVE=0
      IF(NVAL.EQ.0)GO TO 3282
      NLOC=LO
      MOVE=0
      IF(NVAL.GT.0)GO TO 326
      MOVE=1
      LO=-1*NVAL+PO(10)-1
      NVAL=PO(LO)
 326  DO 327 J=1,NVAL
 327  X(J)=PO(LO+J)*CONV1
      LO=LO+NVAL
      DO 328 J=1,NVAL
 328  Y(J)=PO(LO+J)*CONV2
      WRITE(IPR,874)
      JB=1
      JE=NVAL
      IF(JE.GT.8)JE=8
 329  WRITE(IPR,876)UNT1,(X(J),J=JB,JE)
      WRITE(IPR,877)UNT2,(Y(J),J=JB,JE)
      IF(JE.GE.NVAL)GO TO 3282
      JB=JE+1
      JE=JE+8
      IF(JE.GT.NVAL)JE=NVAL
      GO TO 329
C
 3282 LO=LO+NVAL+1
      IF(MOVE.EQ.1)LO=NLOC+1
      ANAME(1)=PO(LO)
      ANAME(2)=PO(LO+1)
      WRITE(IPR,872)ANAME(1),ANAME(2)
      LO=LO+2
      CONV=PO(LO)
      WRITE(IPR,910)CONV
 910  FORMAT(1H0,20X,50HCONVERGENCE CRITERION
     1 =,F10.3)
      LO=LO+1
C
      GO TO 500
C***********************************************************************
C
C     ENTERISC
C
 1580  CONTINUE
      GO TO 500
C***********************************************************************
C
C     SET OUTPUT TO MINIMUM UTILITY
C
 1590  WRITE(IPR,699)
CC      WRITE(IPR,4080)UTILS(J1),UTILS(J2)
      WRITE(IPR,4080)
 4080 FORMAT(1H0,10X,6HSETMIN,31H -SET OUTPUT TO MINIMUM UTILITY)
      NVAL=PO(LP)
      IF(NVAL.EQ.1)WRITE(IPR,4085)
      IF(NVAL.EQ.2)WRITE(IPR,4090)
      IF(NVAL.EQ.3)WRITE(IPR,4095)
 4085 FORMAT(1H0,20X,43HSELECT MINIMUM FROM INSTANTANEOUS DISCHARGE)
 4090 FORMAT(1H0,20X,34HSELECT MINIMUM FROM MEAN DISCHARGE)
 4095 FORMAT(1H0,20X,34HSELECT MINIMUM FROM POOL ELEVATION)
      GO TO 500
C***********************************************************************
C
C     SET OUTPUT TO MAXIMUM UTILITY
C
 1600  WRITE(IPR,699)
CC      WRITE(IPR,5000)UTILS(J1),UTILS(J2)
      WRITE(IPR,5000)
 5000 FORMAT(1H0,10X,6HSETMAX,31H -SET OUTPUT TO MAXIMUM UTILITY)
      NVAL=PO(LP)
      IF(NVAL.EQ.1)WRITE(IPR,5005)
      IF(NVAL.EQ.2)WRITE(IPR,5010)
      IF(NVAL.EQ.3)WRITE(IPR,5015)
 5005 FORMAT(1H0,20X,43HSELECT MAXIMUM FROM INSTANTANEOUS DISCHARGE)
 5010 FORMAT(1H0,20X,34HSELECT MAXIMUM FROM MEAN DISCHARGE)
 5015 FORMAT(1H0,20X,34HSELECT MAXIMUM FROM POOL ELEVATION)
      GO TO 500
C***********************************************************************
C
C     GOFLASH
C
 1610  CONTINUE
      GO TO 500
C***********************************************************************
C
C  WATER USE UTILITY
C
 1620  CONTINUE
      GO TO 500
C***********************************************************************
C
 500  CONTINUE
 740  FORMAT(1H0,10X,37HLINEAR INTERPOLATION IS USED IN CURVE)
 742  FORMAT(1H0,10X,42HLOGARITHMIC INTERPOLATION IS USED IN CURVE)
 795  FORMAT(1H0,20X,64HADDITIONAL TIME SERIES:         ID         TYPE
     1        TIME(HR)/)
  798 FORMAT(1H ,52X,2A4,3X,A4,11X,I2)
  799 FORMAT(1H ,34X,A8,10X,2A4,3X,A4,11X,I2)
 820  FORMAT(1H0,20X,16HRULECURVE VALUES)
 825  FORMAT(1H0,25X,10HJULIAN DAY,8I11)
 830  FORMAT(1H ,25X,5HELEV(,A4,1H),8F11.2)
 832  FORMAT(1H0,20X,50HTIME OF DAY RULE CURVE IS SET
     1 -,I8)
 862  FORMAT(1H0,20X,21HSPILLWAY RATING CURVE)
 864  FORMAT(1H0,25X,5HELEV(,A4,1H),1X,8F11.2)
 866  FORMAT(1H ,25X,6HDISCH(,A4,1H),8F11.2)
 874  FORMAT(1H0,20X,23HHEAD VS DISCHARGE CURVE)
 876  FORMAT(1H0,25X,5HHEAD(,A4,1H),1X,8F11.2)
 877  FORMAT(1H ,25X,6HDISCH(,A4,1H),8F11.2)
 872  FORMAT(1H0,20X,30HTAILWATER RATING CURVE NAME - ,2A4)
 699  FORMAT(1H )
 863  FORMAT(1H0,20X,36HELEVATION VS MAXIMUM DISCHARGE CURVE)
      RETURN
      END