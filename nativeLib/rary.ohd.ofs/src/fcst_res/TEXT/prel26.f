C MEMBER PREL26
C  (from old member FCPREL26)
C***********************************************************************
      SUBROUTINE PREL26(ELEVC,STOR,ELEV)
C***********************************************************************
C SUBROUTINE PREL26 USES PRESCRIBED ELEVATIONS TO DETERMINE DISCHARGES
C FROM A RESERVOIR.  THE SUPERVISORY EXECUTION ROUTINE WILL BYPASS
C PREL26 AFTER THE LAST TIME PERIOD WHEN PRESCRIBED ELEVATIONS ARE TO BE
C USED.  IF PRESCRIBED ELEVATIONS ARE MISSING, OPTIONS ARE TO PASS
C INFLOW OR REPEAT THE LAST IREPE VALUES OF POOL ELEVATIONS.  SINCE
C OBSERVED POOL ELEVATIONS PRIOR TO RUN TIME WOULD BE CONSIDERED PRE-
C SCRIBED ELEVATIONS, COMPUTED VALUES OF STORAGE AND OUTFLOWS WILL BE
C THE SAME FOR SIMULATED AND ADJUSTED RUNS.  THEREFORE, ONLY ONE RUN
C WILL BE MADE.
C FOR THE ADJUSTED RUN PRIOR TO RUN TIME, POOL STORAGES PASSED TO
C THIS SUBROUTINE MAY BE OBSERVED, COMPUTED FROM OBSERVED MEAN OUTFLOWS
C AND ADJUSTED MEAN INFLOWS, INTERPOLATED BETWEEN OBSERVED VALUES,
C OR MISSING.  POOL ELEVATIONS WILL BE OBSERVED OR MISSING.  MEAN OUT-
C FLOWS MAY BE OBSERVED OR COMPUTED FROM ADJUSTED MEAN INFLOWS AND
C OBSERVED OR ADJUSTED STORAGES.  MEAN OUTFLOWS FOR THE TIME INTERVAL,
C POOL STORAGE, POOL ELEVATION, AND INSTANTANEOUS OUTFLOW AT THE END OF
C THE TIME INTERVAL ARE PASSED TO THIS SUBROUTINE IN THE VARIABLES QOM,
C S2, ELEV2, AND QO2, RESPECTIVELY.  MISSING VALUES ARE PASSED AS -999.0
C***********************************************************************
C THIS SUBROUTINE WAS ORIGINALLY PROGRAMMED BY
C     WILLIAM E. FOX -- CONSULTING HYDROLOGIST
C     OCTOBER, 1981
C***********************************************************************
C SUBROUTINE PREL26 IS IN
C***********************************************************************
C VARIABLES PASSED TO OR FROM THIS SUBROUTINE ARE DEFINED AS FOLLOWS:
C     FCST -- LOGICAL VARIABLE.  IF TRUE, TIME PERIOD IS IN THE FORECAST
C       TIME.
C     NS2 -- POSITION IN ARRAYS AT END OF TIME PERIOD.
C     IOPT -- OPTION WHEN PRESCRIBED ELEVATION IS MISSING.  PASS INFLOW
C       (IOPT==0) OR REPEAT LAST IOPT  VALUES OF ELEVATION (IOPT=NO. OF
C       ELEVATION VALUES TO REPEAT).
C     ELEVC -- BACK ELEVATION VALUES IN CARRYOVER ARRAY NEEDED WHEN IOPT
C       IS NOT 0 AND DEFINES THE NUMBER OF ELEVC VALUES.
C     QIM -- MEAN INFLOW FOR TIME PERIOD.
C     QO2 -- OUTFLOW AT END OF TIME PERIOD.
C     QOM -- MEAN OUTFLOW FOR TIME PERIOD.
C     S1 -- STORAGE AT BEGINNING OF TIME PERIOD IN UNITS OF MEAN
C       DISCHARGE FOR THE TIME PERIOD.
C     S2 -- STORAGE AT END OF TIME PERIOD IN UNITS OF MEAN DISCHARGE FOR
C       THE TIME PERIOD.
C     ELEV1 -- ELEVATION AT BEGINNING OF TIME PERIOD.
C     ELEV2 -- ELEVATION AT END OF TIME PERIOD.
C     STOR -- STORAGES FOR STORAGE VS ELEVATION CURVE IN UNITS OF MEAN
C       DISCHARGE FOR THE TIME PERIOD.
C     ELEV -- ELEVATIONS FOR STORAGE VS ELEVATION CURVE.
C     NSE -- NO. OF PAIRS OF STOR AND ELEV VALUES.
C     NTERP -- INDICATES ARITHMETIC (NTERP=0) OR LOGARITHMIC
C       INTERPOLATION (NTERP=1).
C     IBUG -- NO TRACE OR DEBUG (IBUG=0), TRACE ONLY (IBUG=1),TRACE AND
C       DEBUG (IBUG=2).
C***********************************************************************
C EXCEPT WHEN OBSERVED VALUES ARE AVAILABLE, QO2,QOM,S2, AND ELEV2 WILL
C BE COMPUTED IN THIS SUBROUTINE.  OTHER VARIABLES IN THE ARGUMENT LIST
C WILL HAVE VALUES FURNISHED BY THE SUPERVISORY EXECUTION ROUTINE.
C***********************************************************************
C
      INCLUDE 'common/fdbug'
      INCLUDE 'common/resv26'
      INCLUDE 'common/pres26'
C
      DIMENSION ELEVC(1),STOR(1),ELEV(1)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_res/RCS/prel26.f,v $
     . $',                                                             '
     .$Id: prel26.f,v 1.1 1995/09/17 19:05:58 dws Exp $
     . $' /
C    ===================================================================
C
C
C***********************************************************************
C WRITE TRACE AND DEBUG IF REQUIRED.
C***********************************************************************
      IF(IBUG-1)50,10,20
   10 WRITE(IODBUG,30)
      GO TO 50
   20 WRITE(IODBUG,30)
   30 FORMAT(1H0,10X,17H** PREL26 ENTERED)
      WRITE(IODBUG,40) FCST,NS2,IOPT,QIM,QO2,QOM,S1,S2,ELEV1,
     $ELEV2,NTERP,IBUG
   40 FORMAT(1H0,62H FCST,NS2,IOPT,QIM,QO2,QOM,S1,S2,ELEV1,ELEV2,
     $NTERP,IBUG/1X,L5,2I6,7F12.3,2I6)
C
C LCHANG IS SET TO 0 TO INDICATE COMPUTED ELEV2 IS NOT CHANGED IN THE
C SUBROUTINE.  IF ELEV2 HAS TO BE CHANGED FROM THE FIRST COMPUTATION
C DUE TO CHANGE IN MEAN OUTFLOW (OR HASN'T BEEN COMPUTED), LCHANG WILL
C BE SET TO 1.
C
   50 LCHANG=0
C
C  TO BE CONSISTEN WITH OTHER SCHEMES, DON'T USE OBSV26 UNLESS IT'S AN
C  ADJUSTED RUN AND WE'RE WITHIN THE OBSERVED PERIOD. (JTO - 8/83)
C
      IF(FCST.OR.IFCST.EQ.0) GO TO 60
      OBSQO2=QO2
C
C USE FUNCTION OBSV26 TO CHECK FOR A VALUE OF STORAGE AT THE END OF THE
C TIME INTERVAL.  THE TIME INTERVAL IS PRIOR TO OR AT RUN TIME.
C
      IGO=OBSV26(S2,IBUG)
      IF(ELEV2.EQ.-999.0) LCHANG=1
      IF(IGO.EQ.1) GO TO 120
C
C WHEN IGO IS 1, THE POOL STORAGE IS OBSERVED; COMPUTED FROM OBSERVED
C MEAN OUTFLOWS AND ADJUSTED MEAN INFLOWS; OR INTERPOLATED BETWEEN
C OBSERVED VALUES.  WHEN IGO IS 0, THE STORAGE IS MISSING.  IF THE MEAN
C OUTFLOW IS OBSERVED BUT THE STORAGE AT THE END OF THE TIME INTERVAL IS
C MISSING, THE ENDING STORAGE WILL BE COMPUTED IN STATEMENT 101
C FROM THE OBSERVED MEAN INFLOW, THE ADJUSTED MEAN INFLOW, AND THE
C COMPUTED STORAGE AT THE BEGINNING OF THE TIME INTERVAL.
C
      IF(QOM.EQ.-999.0) GO TO 60
      GO TO 101
C***********************************************************************
C CHECK FOR MISSING PRESCRIBED ELEVATION (ELEV2) AT END OF TIME PERIOD.
C***********************************************************************
   60 IF(ELEV2.NE.-999.0)GO TO 100
      IF(IOPT.GT.0) GO TO 80
C***********************************************************************
C PASS INFLOW WHEN IOPT=0.
C***********************************************************************
      ELEV2=ELEV1
      S2=S1
      QOM=QIM
C
C MEAN INFLOW (QIM) CAN BE NEGATIVE DUE TO RESERVOIR EVAPORATION.  SET
C MEAN OUTFLOW (QOM) TO 0 IF QIM IS NEGATIVE AND SET LCHANG TO 1 TO
C INDICATE THAT ELEV2 MUST BE RECOMPUTED.
C
      IF(QOM.GE.0.) GO TO 70
      QOM=0.
      LCHANG=1
      S2=S1+QIM
   70 QO2=QOM
      IF(FCST.OR.IFCST.EQ.0) GO TO 130
      IF(OBSQO2.NE.-999.0) QO2=OBSQO2
      GO TO 130
C***********************************************************************
C GET BACK ELEVATION FROM CARRYOVER ARRAY (ELEVC) TO REPEAT LAST IOPT
C VALUES.
C  (THE REPEAT VALUE IS ALWAYS THE FIRST VALUE IN THE CARRYOVER ARRAY
C  AS THE CARRYOVER ARRAY IS UPDATED FOR EACH TIME PERIOD.  JTO - 8/83)
C***********************************************************************
   80 CONTINUE
      ELEV2=ELEVC(1)
C***********************************************************************
C COMPUTE STORAGE(S2) WITH ARITHMETIC (NTERP=0) OR LOGARITHMIC
C INTERPOLATION (NTERP=1).
C***********************************************************************
  100 CALL NTER26(ELEV2,S2,ELEV,STOR,NSE,IFLAG,NTERP,IBUG)
      QOM=S1+QIM-S2
      IF(QOM.GE.0.) GO TO 110
C
C MEAN OUTFLOW (QOM) WILL BE CHANGED AND A NEW VALUE OF ENDING STORAGE
C (S2) WILL BE COMPUTED.
C
      IF(QOM.LT.0.) QOM=0.
      LCHANG=1
  101 S2=S1+QIM-QOM
C***********************************************************************
C SET QO2 EQUAL TO QOM IF QO2 IS NOT AN OBSERVED VALUE.  THIS GIVES A
C MORE REALISTIC VALUE FOR QO2 THAN COMPUTING IT FROM QO1 AND QOM.
C***********************************************************************
  110 QO2=QOM
      IF(FCST.OR.IFCST.EQ.0) GO TO 130
  120 QO2=QOM
      IF(OBSQO2.NE.-999.0) QO2=OBSQO2
      IF(ELEV2.NE.-999.0)GO TO 140
  130 IF(LCHANG.EQ.0) GO TO 140
C***********************************************************************
C COMPUTE ELEV2 FROM S2 WHEN ELEV2 WAS NOT AN OBSERVED VALUE PRIOR TO
C OR AT NRUN TIME PERIOD BUT S2 WAS COMPUTED OR INTERPOLATED.
C***********************************************************************
      CALL NTER26(S2,ELEV2,STOR,ELEV,NSE,IFLAG,NTERP,IBUG)
  140 IF(IBUG-1)230,210,150
  150 WRITE(IODBUG,160)
  160 FORMAT(1H0,45H VALUES AT THE END  OF PREL26 ARE AS FOLLOWS:)
      WRITE(IODBUG,40) FCST,NS2,IOPT,QIM,QO2,QOM,S1,S2,ELEV1,ELEV2,
     $NTERP,IBUG
      IF(IOPT.EQ.0)GO TO 190
      WRITE(IODBUG,170)(ELEVC(I),I=1,IOPT)
  170 FORMAT(1H0,43H BACK ELEVATIONS IN THE CARRYOVER ARRAY ARE/(1X,
     $10F12.3))
  190 WRITE(IODBUG,200)IFLAG,NSE,(STOR(I),ELEV(I),I=1,NSE)
  200 FORMAT(1H0,9H IFLAG IS,I6,43H.  NO OF POINTS ON ELEV. - STORAGE CU
     $RVE IS,I4,1H./1H0,48H ALTERNATING VALUES OF STORAGE AND ELEVATION
     $ARE/(1X,5(F12.3,F9.3,3X)))
  210 WRITE(IODBUG,220)
  220 FORMAT(1H0,10X,17H** LEAVING PREL26)
  230 RETURN
      END