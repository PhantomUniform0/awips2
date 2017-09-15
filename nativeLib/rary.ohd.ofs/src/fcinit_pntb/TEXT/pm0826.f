C MODULE PM0826
C
      SUBROUTINE PM0826(WORK,IUSEW,LEFTW,NP08,GAGE2,C7,IUSEC7,LEFTC7,
     .                  STAGEQ,LENDSU,JDEST,IERR)
C---------------------------------------------------------------------
C  SUBROUTINE TO READ AND INTERPRET PARAMETER INPUT FOR S/U #08
C    DOWNSTREAM STAGE AND POOL ELEVATION CONTROLLED DISCHARGE
C---------------------------------------------------------------------
C  JTOSTROWSKI - HRL - DECEMBER 1983
C----------------------------------------------------------------
C
      INCLUDE 'common/comn26'
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
C
      INCLUDE 'common/err26'
C
      INCLUDE 'common/fld26'
C
      INCLUDE 'common/mult26'
C
      INCLUDE 'common/rc26'
C
      INCLUDE 'common/read26'
C
      INCLUDE 'common/suid26'
C
      INCLUDE 'common/suin26'
C
      INCLUDE 'common/suky26'
C
      INCLUDE 'common/warn26'
C
      COMMON/FRES7/MENNST,LAGDT,NCD7,NLAGK
C
      INCLUDE 'common/errdat'
C
      DIMENSION INPUT(2,14),LINPUT(14),QDIST(24),ITRIB(2),
     . ENDSU(2),CTL1(50),CTL2(50),CTL3(50),CTL4(50),RISING(50),
     . WORK(1),FALING(50),IRREL(50),IFREL(50),RCVAL(50),
     . IP(14),OK(14),P7(400),C7(1),IPREQ(6),RESKEY(2),RATING(2)
      LOGICAL ALLOK,OK,GETRUL,GETTIM,GAGE2,GFALL2,STAGEQ,GETRC
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_pntb/RCS/pm0826.f,v $
     . $',                                                             '
     .$Id: pm0826.f,v 1.7 2000/07/21 17:01:01 page Exp $
     . $' /
C    ===================================================================
C
C
C
       DATA INPUT/
     .            4HQDIS,4HT   ,4HGAGE,4H1   ,4HLAG ,4H    ,
     .            4HRATI,4HNG  ,4HCONT,4HROL1,4HCONT,4HROL2,
     .            4HCONT,4HROL3,4HCONT,4HROL4,4HRISI,4HNG  ,
     .            4HFALL,4HING ,4HCURV,4HE   ,4HRULE,4HTIME,
     .            4HLAG/,4HK   ,4HGAGE,4H2   /
      DATA LINPUT/2,2,1,2,2,2,2,2,2,2,2,2,2,2/
      DATA NINPUT/14/
      DATA NDINPU/2/
C
      DATA STCODE/1080.01/
C
      DATA IPREQ/2,2,5,9,10,13/
      DATA BLANK/4H    /
      DATA QINE/4HQINE/
      DATA TRIB/4HTRIB/
      DATA RESKEY/4HRES-,4HSNGL/
C
C  INITIALIZE LOCAL VARIABLES AND COUNTERS
C
      NP08 = 0
      ALLOK = .TRUE.
      GETRUL = .FALSE.
      GETTIM = .FALSE.
      RTIME=-999.0
      NRULA = 0
      GAGE2 = .FALSE.
      GFALL2 = .FALSE.
      GETRC = .FALSE.
      STAGEQ = .FALSE.
      RLSETY = 0.01
      NLAGK = 0
      HLAG = 0.0
      LAGDT = MINODT
      INTEMP = IN
      IN = MUNI26
      NGAGES = 1
      RATING(1) = BLANK
      RATING(2) = BLANK
      CONVDS = CONVLT
      NEXTC7 = 1
      DO I=1,2
      ITRIB(I)=0
      ENDDO
C
      DO 1 I=1,14
      OK(I) = .FALSE.
    1 CONTINUE
C
C  SET OK SWITCHES TO TRUE FOR ALL OPTIONAL KEYWORDS
C
      OK(1) = .TRUE.
      OK(3) = .TRUE.
      OK(4) = .TRUE.
      OK(6) = .TRUE.
      OK(7) = .TRUE.
      OK(8) = .TRUE.
      OK(10)= .TRUE.
      OK(11)= .TRUE.
      OK(12) = .TRUE.
      OK(14)= .TRUE.
C
      DO 3 I = 1,14
           IP(I) = 0
    3 CONTINUE
C
      CODEST = STCODE + SULEVL
C
      IERR = 0
C
C  PARMS FOUND, LOOKING FOR ENDP
C
      LPOS = LSPEC + NCARD + 1
      LASTCD = LENDSU
      IBLOCK = 1
C
    5 IF (NCARD .LT. LASTCD) GO TO 8
           CALL STRN26(59,1,SUKYWD(1,7),3)
           IERR = 99
           GO TO 9
    8 NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF .GT. 0 ) GO TO 9000
      NUMWD = (LEN -1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,SUKYWD,LSUKEY,NSUKEY,NDSUKY)
      IF (IDEST.EQ.0) GO TO 5
C
C  IDEST = 7 IS FOR ENDP
C
      IF (IDEST.EQ.7.OR.IDEST.EQ.8) GO TO 9
          CALL STRN26(59,1,SUKYWD(1,7),3)
          JDEST = IDEST
          IERR = 89
    9 LENDP = NCARD
C
C  ENDP CARD OR TS OR CO FOUND AT LENDP,
C  ALSO ERR RECOVERY IF NEITHER ONE OF THEM FOUND.
C
      IBLOCK = 2
      CALL POSN26(MUNI26,LPOS)
      NCARD = LPOS - LSPEC -1
C
   10 CONTINUE
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF .GT. 0) GO TO 9000
   15 CONTINUE
      NUMWD = (LEN -1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,INPUT,LINPUT,NINPUT,NDINPU)
      IF(IDEST .GT. 0) GO TO 50
      IF(NCARD .GE. LENDP) GO TO 5000
C
C  NO VALID KEYWORD FOUND
C
      CALL STER26(1,1)
      ALLOK = .FALSE.
      GO TO 10
C
C  NOW SEND CONTROL TO PROPER LOCATION FOR PROCESSING EXPECTED INPUT
C
   50 CONTINUE
      GO TO (100,200,300,400,500,600,700,800,900,1000,1100,1200,
     .    1300,5000) , IDEST
C
C-----------------------------------------------------------------
C  'QDIST' KEYWORD FOUND.
C
  100 CONTINUE
C
      IP(1) = IP(1) + 1
      IF (IP(1).GT.1) CALL STER26(39,1)
C
C  ONE VALUE PER TIME PERIOD MUST FOLLOW
C
  110 CONTINUE
      OK(1) = .FALSE.
C
C  GET LIST OF VALUES
C
      NQDIST=24
      CALL GLST26(1,1,IX,QDIST,IX,NQDIST,OK(1))
      IF (.NOT.OK(1)) GO TO 10
C
C  MUST HAVE 24/MINODT VALUES
C
      IF (NQDIST.EQ.24/MINODT) GO TO 120
C
      CALL STER26(62,1)
      GO TO 10
C
C  ALL VALUES MUST BE POSITIVE
C
  120 CONTINUE
C
      TOTAL = 0.000
      DO 130 I=1,NQDIST
C
      IF (QDIST(I) .GE. 0.00) GO TO 125
C
      CALL STER26(61,1)
      GO TO 10
C
  125 CONTINUE
      TOTAL = TOTAL + QDIST(I)
  130 CONTINUE
C
C  TOTAL MUST SUM TO 1.000 +- .001
C
      DIFF = ABS(TOTAL-1.000)
      IF (DIFF .LE. 0.001) GO TO 140
C
      CALL STER26(71,1)
      GO TO 10
C
C  EVERYTHING IS OK
C
  140 CONTINUE
      OK(1) = .TRUE.
      RLSETY = 1.01
      GO TO 10
C
C--------------------------------------------------------------------
C  'GAGE1' FOUND. ONLY CAN BE ENTERED ONCE.
C
  200 CONTINUE
      IP(2) = IP(2) + 1
      IF (IP(2) .GT. 1) CALL STER26(39,1)
      IF (IP(2) .EQ. 1) OK(2) = .TRUE.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
C
C  IF NOTHING ON CARD, DEFAULT TO D/S FLOW CONDITION CONTROL
C
      IF (IERF.GE.1) GO TO 240
      NUMWD = (LEN-1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,TRIB,1,1,1)
      IF (IDEST.EQ.1) ITRIB(1)=1
  240 CONTINUE
C
  250 CONTINUE
      GO TO 10
C
C-----------------------------------------------------------------
C  'LAG' KEYWORD FOUND. NEED POSITIVE INTEGER SPECIFICATION FOR THIS
C   KEYWORD.
C
  300 CONTINUE
C
      IP(3) = IP(3) + 1
      IF (IP(3).GT.1) CALL STER26(39,1)
C
C  AN INTEGER VALUE MUST FOLLOW
C
  310 CONTINUE
      OK(3) = .FALSE.
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GE.1) GO TO 9000
C
      IF (ITYPE.EQ.0) GO TO 320
      CALL STER26(5,1)
      GO TO 10
C
C  NO. OF HOURS OF LAG MUST BE GREATER THAN OR EQUAL TO ZERO
C
  320 CONTINUE
C
      IF (INTEGR.GE.0) GO TO 330
      CALL STER26(61,1)
      GO TO 10
C
  330 CONTINUE
      HLAGX = INTEGR
C
C  EVERYTHING IS OK
C
  350 CONTINUE
      OK(3) = .TRUE.
      GO TO 10
C
C---------------------------------------------------------------------
C  'RATING' IS FOUND NEXT. RATING CURVE MUST BE DEFINED AT FORECAST
C   COMPONENT LEVEL.
C
  400 CONTINUE
      IP(4) = IP(4) + 1
      IF (IP(4).GT.1) CALL STER26(39,1)
C
C  IF RATING CURVE USED FOR FIRST GAGE IT MUST BE USED FOR SECOND GAGE.
C
ccc      IF (.NOT.GAGE2) GETRC = .TRUE.
ccc      IF (GAGE2 .AND. .NOT.GETRC) CALL STRN26(60,1,INPUT(1,4),LINPUT(4))
      GETRC = .TRUE.
      STAGEQ = .TRUE.
C
C  LOOK FOR RATING CURVE NAME
C
      OK(4) = .FALSE.
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
C  SEE IF RATING CURVE HAS BEEN DEFINED WITHIN THE FORECAST SEGMENT
C
      CALL CHEKRC(CHAR,IERC)
      IF (IERC.EQ.0) GO TO 410
C
      CALL STRN26(118,1,CHAR,2)
      GO TO 10
C
C  SEE IF THIS DEFINITION IS COMPATIBLE WITH OTHER RATING CURVE INPUTS.
C
  410 CONTINUE
      CALL CKRC26(3,CHAR,IERC)
      IF (IERC.GT.0) GO TO 10
C
C  CURVE IS REFERRED TO PROPERLY.
C
      RATING(1) = CHAR(1)
      RATING(2) = CHAR(2)
      CONVDS = CONVL
      OK(4) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CONTROL1' IS NEXT IN LINE.
C
  500 CONTINUE
C
      IP(5) = IP(5) + 1
      IF (IP(5).GT.1) CALL STER26(39,1)
      OK(5) = .FALSE.
C
C GET LIST OF VALUES FOR DEFINING THE FIRST CONTROL SCHEDULE
C
      NCTL1=50
      CALL GLST26(1,1,X,CTL1,X,NCTL1,OK(5))
      IF (.NOT.OK(5)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE STAGE/DISCHARGE VALUES MUST BE IN ASCENDING ORDER,
C   3) THE RELEASES MUST BE IN DESCENDING ORDER,
C   4) THE RELEASES AND STAGE/DISCHARGE VALUES MUST BE POSITIVE.
C
      IF (MOD(NCTL1,2).EQ.0) GO TO 530
C
      CALL STER26(40,1)
      GO TO 10
C
  530 CONTINUE
      NHALF = NCTL1/2
      NSEC = NHALF + 1
C
C  SEE IF STAGE/DISCHARGE VALUES ARE IN ASCENDING ORDER
C
      CALL ASCN26(CTL1,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF RELEASES ARE IN DESCENDING ORDER
C
cc      CALL DSCN26(CTL1(NSEC),NHALF,IERA)
cc      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ALL VALUES ARE ALL POSITIVE
C
cc      DO 550 I=1,NCTL1
cc      IF (CTL1(I).GE.0.00) GO TO 550
C
cc      CALL STER26(95,1)
cc      GO TO 10
C
cc  550 CONTINUE
C
C  CONVERT RELEASES TO METRIC. THE STAGE/DISCHARGE SPECS WILL BE
C  CONVERTED JUST PRIOR TO STORAGE IN THE WORK ARRAY.
C
      DO 555 I=NSEC,NCTL1
C      IF(CTL1(I).LT.0.0) THEN
      IF (ABS(CTL1(I)+999.0).LT.0.1) THEN
         GETRUL = .TRUE.
         GO TO 555
      ENDIF
      IF(CTL1(I).GT.0.0) CTL1(I) = CTL1(I)/CONVLT
  555 CONTINUE
C
C  CURVE IS DEFINED OK
C
      OK(5) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CONTROL2' IS NEXT IN LINE.
C
  600 CONTINUE
C
      OK(6) = .FALSE.
      IP(6) = IP(6) + 1
      IF (IP(6).GT.1) CALL STER26(39,1)
      IF (IP(5) .GT. 0) GO TO 610
      CALL STRN26(59,1,INPUT(1,5),LINPUT(5))
      GO TO 10
C
  610 CONTINUE
C
C GET LIST OF VALUES FOR DEFINING THE SECOND CONTROL SCHEDULE
C
      NCTL2=50
      CALL GLST26(1,1,X,CTL2,X,NCTL2,OK(6))
      IF (.NOT.OK(6)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE STAGE/DISCHARGE VALUES MUST BE IN ASCENDING ORDER,
C   3) THE RELEASES MUST BE IN DESCENDING ORDER,
C   4) THE RELEASES AND STAGE/DISCHARGE VALUES MUST BE POSITIVE.
C
      IF (MOD(NCTL2,2).EQ.0) GO TO 630
C
      CALL STER26(40,1)
      GO TO 10
C
  630 CONTINUE
      NHALF = NCTL2/2
      NSEC = NHALF + 1
C
C  SEE IF STAGE/DISCHARGE VALUES ARE IN ASCENDING ORDER
C
      CALL ASCN26(CTL2,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF RELEASES ARE IN DESCENDING ORDER
C
cc      CALL DSCN26(CTL2(NSEC),NHALF,IERA)
cc      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ALL VALUES ARE ALL POSITIVE
C
cc      DO 650 I=1,NCTL2
cc      IF (CTL2(I).GE.0.00) GO TO 650
C
cc      CALL STER26(95,1)
cc      GO TO 10
C
cc  650 CONTINUE
C
C  CONVERT RELEASES TO METRIC. THE STAGE/DISCHARGE SPECS WILL BE
C  CONVERTED JUST PRIOR TO STORAGE IN THE WORK ARRAY.
C
      DO 655 I=NSEC,NCTL2
c      IF(CTL2(I).LT.0.0) THEN
      IF (ABS(CTL2(I)+999.0).LT.0.1) THEN
         GETRUL = .TRUE.
         GO TO 655
      ENDIF
      IF(CTL2(I).GT.0.0) CTL2(I) = CTL2(I)/CONVLT
  655 CONTINUE
C
C  CURVE IS DEFINED OK
C
      OK(6) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CONTROL3' IS NEXT IN LINE.
C
  700 CONTINUE
C
      OK(7) = .FALSE.
      IP(7) = IP(7) + 1
      IF (IP(7).GT.1) CALL STER26(39,1)
      IF (IP(6) .GT. 0) GO TO 710
      CALL STRN26(59,1,INPUT(1,6),LINPUT(5))
      GO TO 10
C
  710 CONTINUE
C
C GET LIST OF VALUES FOR DEFINING THE THIRD CONTROL SCHEDULE
C
      NCTL3=50
      CALL GLST26(1,1,X,CTL3,X,NCTL3,OK(7))
      IF (.NOT.OK(7)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE STAGE/DISCHARGE VALUES MUST BE IN ASCENDING ORDER,
C   3) THE RELEASES MUST BE IN DESCENDING ORDER,
C   4) THE RELEASES AND STAGE/DISCHARGE VALUES MUST BE POSITIVE.
C
      IF (MOD(NCTL3,2).EQ.0) GO TO 730
C
      CALL STER26(40,1)
      GO TO 10
C
  730 CONTINUE
      NHALF = NCTL3/2
      NSEC = NHALF + 1
C
C  SEE IF STAGE/DISCHARGE VALUES ARE IN ASCENDING ORDER
C
      CALL ASCN26(CTL3,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF RELEASES ARE IN DESCENDING ORDER
C
cc      CALL DSCN26(CTL3(NSEC),NHALF,IERA)
cc      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ALL VALUES ARE ALL POSITIVE
C
cc      DO 750 I=1,NCTL3
cc      IF (CTL3(I).GE.0.00) GO TO 750
C
cc      CALL STER26(95,1)
cc      GO TO 10
C
cc  750 CONTINUE
C
C  CONVERT RELEASES TO METRIC. THE STAGE/DISCHARGE SPECS WILL BE
C  CONVERTED JUST PRIOR TO STORAGE IN THE WORK ARRAY.
C
      DO 755 I=NSEC,NCTL3
c      IF(CTL3(I).LT.0.0) THEN
      IF (ABS(CTL3(I)+999.0).LT.0.1) THEN
         GETRUL = .TRUE.
         GO TO 755
      ENDIF
      IF(CTL3(I).GT.0.0) CTL3(I) = CTL3(I)/CONVLT
  755 CONTINUE
C
C  CURVE IS DEFINED OK
C
      OK(7) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CONTROL4' IS NEXT IN LINE.
C
  800 CONTINUE
C
      OK(8) = .FALSE.
      IP(8) = IP(8) + 1
      IF (IP(8).GT.1) CALL STER26(39,1)
      IF (IP(7) .GT. 0) GO TO 810
      CALL STRN26(59,1,INPUT(1,7),LINPUT(7))
      GO TO 10
C
  810 CONTINUE
C
C GET LIST OF VALUES FOR DEFINING THE FOURTH CONTROL SCHEDULE
C
      NCTL4=50
      CALL GLST26(1,1,X,CTL4,X,NCTL4,OK(8))
      IF (.NOT.OK(8)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE STAGE/DISCHARGE VALUES MUST BE IN ASCENDING ORDER,
C   3) THE RELEASES MUST BE IN DESCENDING ORDER,
C   4) THE RELEASES AND STAGE/DISCHARGE VALUES MUST BE POSITIVE.
C
      IF (MOD(NCTL4,2).EQ.0) GO TO 830
C
      CALL STER26(40,1)
      GO TO 10
C
  830 CONTINUE
      NHALF = NCTL4/2
      NSEC = NHALF + 1
C
C  SEE IF STAGE/DISCHARGE VALUES ARE IN ASCENDING ORDER
C
      CALL ASCN26(CTL4,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF RELEASES ARE IN DESCENDING ORDER
C
cc      CALL DSCN26(CTL4(NSEC),NHALF,IERA)
cc      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ALL VALUES ARE ALL POSITIVE
C
cc      DO 850 I=1,NCTL4
cc      IF (CTL4(I).GE.0.00) GO TO 850
C
cc      CALL STER26(95,1)
cc      GO TO 10
C
cc  850 CONTINUE
C
C  CONVERT RELEASES TO METRIC. THE STAGE/DISCHARGE SPECS WILL BE
C  CONVERTED JUST PRIOR TO STORAGE IN THE WORK ARRAY.
C
      DO 855 I=NSEC,NCTL4
c      IF(CTL4(I).LT.0.0) THEN
      IF (ABS(CTL4(I)+999.0).LT.0.1) THEN
         GETRUL = .TRUE.
         GO TO 855
      ENDIF
      IF(CTL4(I).GT.0.0) CTL4(I) = CTL4(I)/CONVLT
  855 CONTINUE
C
C  CURVE IS DEFINED OK
C
      OK(8) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'RISING' IS NEXT IN LINE.
C
  900 CONTINUE
C
      IP(9) = IP(9) + 1
      IF (IP(9).GT.1) CALL STER26(39,1)
      OK(9) = .FALSE.
C
C GET LIST OF VALUES FOR DEFINING THE RISING CONTROL SCHEDULE
C
      NRSING=50
      CALL GLST26(1,1,X,RISING,X,NRSING,OK(9))
      IF (.NOT.OK(9)) GO TO 10
C
C  FOUR CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE ELEVATIONS MUST BE IN ASCENDING ORDER,
C   3) THE ELEVATIONS MUST BE WITHIN THE ELVSSTOR CURVE.
C   4) THE RELATIONS REFERRED TO MUST HAVE BEEN DEFINED.
C
      IF (MOD(NRSING,2).EQ.0) GO TO 910
C
      CALL STER26(40,1)
      GO TO 10
C
  910 CONTINUE
      NHALFR = NRSING/2
      NSEC = NHALFR + 1
C
C  IF ANY ELEVATION IS -999.0, A RULE CURVE IS NEEDED. HOLD ANY VALUE
C  CHECKING UNTIL WE GET THE RULE CURVE.
C
      DO 920 I=1,NHALFR
      IF (ABS(RISING(I)+999.0).GT.0.1) GO TO 920
C
      GETRUL = .TRUE.
      GO TO 925
C
  920 CONTINUE
      GO TO 945
C
C  IF 'RULECURVE' HAS ALREADY BEEN DEFINED, DO BOPUNDARY CHECK HERE.
C
  925 CONTINUE
      IF (IP(11) .EQ. 0 .OR. .NOT.OK(11)) GO TO 950
C
C  CONVERT ELEVATIONS.
C
      DO 935 I=1,NHALFR
          IF (RISING(I).LE.0.0) GO TO 935
          RISING(I) = RISING(I)/CONVL
  935 CONTINUE
C
      IF (NHALFR .LE. 1) GO TO 960
      NENDR = NHALFR - 1
      DO 940 I=2,NENDR
      IF (ABS(RISING(I)+999.0).GT.0.1) GO TO 940
      IF  (RISING(I-1).LT.ELOWR.AND.ELOWR.LT.RISING(I+1). AND.
     .     RISING(I-1).LT.ELUPR.AND.ELUPR.LT.RISING(I+1)) GO TO 940
C
      CALL STRN26(67,1,INPUT(1,9),LINPUT(9))
      GO TO 10
C
  940 CONTINUE
      GO TO 960
C
C  SEE IF ELEVATIONS ARE IN ASCENDING ORDER (ONLY IF NO RULE CURVE
C  REFERENCES USED.)
C
  945 CONTINUE
      CALL ASCN26(RISING,NHALFR,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELEV VS. STORAGE CURVE
C  IF CURVE WAS NOT DEFINED, CALL IT AN ERROR
C
  950 CONTINUE
C
C  CONVERT ELEVATIONS.
C
      DO 955 I=1,NHALFR
          IF (RISING(I).LE.0.0) GO TO 955
          RISING(I) = RISING(I)/CONVL
  955 CONTINUE
C
  960 CONTINUE
      CALL ELST26(RISING,NHALFR,IERST)
      IF (IERST.GT.0) GO TO 10
C
C  COPY REAL VALUES OF RELATION NOS. INTO INTEGER ARRAY FOR DEFINITION
C  CHECKING.
C
      IR = 0
      DO 970 I=NSEC,NRSING
          IRREL(I-NHALFR) = RISING(I)
          IREL = IRREL(I-NHALFR)
          IF (IREL.LT.1 .OR. IREL.GT.4) GO TO 965
          IF (IP(IREL+4) .GT. 0) GO TO 970
C
        CALL STRN26(59,1,INPUT(1,IREL+4),LINPUT(IREL+4))
        IR = 1
        GO TO 970
C
  965 CONTINUE
      CALL STER26(106,1)
      IR = 1
C
  970 CONTINUE
C
      IF (IR.GT.0) GO TO 10
      OK(9) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'FALLING' IS NEXT IN LINE.
C
 1000 CONTINUE
C
      IP(10) = IP(10) + 1
      IF (IP(10).GT.1) CALL STER26(39,1)
      OK(10) = .FALSE.
C
C  IF ON FIRST GAGE, INDICATE THAT FALLING RELATION IS NEEDED FOR THE
C  SECOND GAGE. ALSO, IF THIS IS SECOND GAGE, AND WE DIDN'T USE FALLING
C  RELATION ON FIRST GAGE, CALL IT AN ERROR.
C
      IF (.NOT.GAGE2) GFALL2 = .TRUE.
      IF (GAGE2 .AND. .NOT.GFALL2) CALL STRN26(60,1,INPUT(1,10),
     .   LINPUT(10))
C
C GET LIST OF VALUES FOR DEFINING THE FALLING CONTROL SCHEDULE
C
      NFLING=50
      CALL GLST26(1,1,X,FALING,X,NFLING,OK(10))
      IF (.NOT.OK(10)) GO TO 10
C
C  FOUR CHECKS MUST BE MADE ON THE SCHEDULE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE ELEVATIONS MUST BE IN ASCENDING ORDER,
C   3) THE ELEVATIONS MUST BE WITHIN THE ELVSSTOR CURVE.
C   4) THE RELATIONS REFERRED TO MUST HAVE BEEN DEFINED.
C
      IF (MOD(NFLING,2).EQ.0) GO TO 1010
C
      CALL STER26(40,1)
      GO TO 10
C
 1010 CONTINUE
      NHALFF = NFLING/2
      NSEC = NHALFF + 1
C
C  IF ANY ELEVATION IS -999.0, A RULE CURVE IS NEEDED. HOLD ANY VALUE
C  CHECKING UNTIL WE GET THE RULE CURVE.
C
      DO 1020 I=1,NHALFF
      IF (ABS(FALING(I)+999.0).GT.0.1) GO TO 1020
C
      GETRUL = .TRUE.
      GO TO 1025
C
 1020 CONTINUE
      GO TO 1045
C
C  IF 'RULECURVE' HAS ALREADY BEEN DEFINED, DO BOUNDARY CHECK HERE.
C
 1025 CONTINUE
      IF (IP(11) .EQ. 0 .OR. .NOT.OK(11)) GO TO 1050
C
C  CONVERT ELEVATIONS.
C
      DO 1035 I=1,NHALFF
          IF (FALING(I).LE.0.0) GO TO 1035
          FALING(I) = FALING(I)/CONVL
 1035 CONTINUE
C
      IF (NHALFF .LE. 1) GO TO 1060
      NENDF = NHALFF - 1
      DO 1040 I=2,NENDF
      IF (ABS(FALING(I)+999.0).GT.0.1) GO TO 1040
      IF  (FALING(I-1).LT.ELOWR.AND.ELOWR.LT.FALING(I+1). AND.
     .     FALING(I-1).LT.ELUPR.AND.ELUPR.LT.FALING(I+1)) GO TO 1040
C
      CALL STRN26(67,1,INPUT(1,10),LINPUT(10))
      GO TO 10
C
 1040 CONTINUE
      GO TO 1060
C
C  SEE IF ELEVATIONS ARE IN ASCENDING ORDER (ONLY IF NO RULE CURVE
C  REFERENCES USED.)
C
 1045 CONTINUE
      CALL ASCN26(FALING,NHALFF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELEV VS. STORAGE CURVE
C  IF CURVE WAS NOT DEFINED, CALL IT AN ERROR
C
 1050 CONTINUE
C
C  CONVERT ELEVATIONS.
C
      DO 1055 I=1,NHALFF
          IF (FALING(I).LE.0.0) GO TO 1055
          FALING(I) = FALING(I)/CONVL
 1055 CONTINUE
C
 1060 CONTINUE
      CALL ELST26(FALING,NHALFF,IERST)
      IF (IERST.GT.0) GO TO 10
C
C  COPY REAL VALUES OF RELATION NOS. INTO INTEGER ARRAY FOR DEFINITION
C  CHECKING.
C
      IR = 0
      DO 1070 I=NSEC,NFLING
          IFREL(I-NHALFF) = FALING(I)
          IREL = IFREL(I-NHALFF)
          IF (IREL.LT.1 .OR. IREL.GT.4) GO TO 1065
          IF (IP(IREL+4) .GT. 0) GO TO 1070
C
        CALL STRN26(59,1,INPUT(1,IREL+4),LINPUT(IREL+4))
        IR = 1
        GO TO 1070
C
 1065 CONTINUE
      CALL STER26(106,1)
      IR = 1
C
 1070 CONTINUE
C
      IF (IR.GT.0) GO TO 10
      OK(10) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CURVE' IS FOUND NEXT. ONLY NEEDED IF EITHER RISING OR FALLING
C   RELATION USES A RULE CURVE REFERENCE (I.E. -999.0)
C
 1100 CONTINUE
      IP(11) = IP(11) + 1
      IF (IP(11).GT.1) CALL STER26(39,1)
cc      IF (GETRUL) GO TO 1110
C
cc           CALL STRN26(60,1,INPUT(1,IDEST),LINPUT(IDEST))
cc           OK(11) = .FALSE.
C
C  READ FIRST FIELD AFTER 'CURVE'. IF IT'S NUMERIC, GET LIST OF
C   NUMBERS FOR DEFINING CURVE
C  IF IT'S CHARACTER, ASSUME A MULTIPLE USE REFERENCE HAS BEEN ENTERED,
C   AND SEE IF SPEC IS VALID.
C
C
cc 1110 CONTINUE
C
      OK(11) = .FALSE.
      ELUPR = -999999.
      ELOWR = 999999.
C
      LPOSST = LSPEC + NCARD
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
      ICTYPE = ITYPE
      IF (ICTYPE.GT.1) GO TO 1160
C
C  REPOSITION TO READ FIRST FIELD AFTER 'CURVE'
C
      GETTIM = .TRUE.
      CALL POSN26(MUNI26,LPOSST)
      NCARD = LPOSST - LSPEC -1
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
C
C
C GET LIST OF VALUES FOR DEFINING THE RULE CURVE
C
      NRCVAL=50
      CALL GLST26(1,1,X,RCVAL,X,NRCVAL,OK(11))
      IF (.NOT.OK(11)) GO TO 10
C
C  FOUR CHECKS MUST BE MADE ON THE CURVE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE ELEVATIONS MUST BE BETWEEN THE DEFINED BOUNDARIES OF THE ELEV
C      VS STORAGE CURVE,
C   3) THE DATES MUST BE BETWEEN 2 AND 366, AND
C   4) THE DATES MUST BE IN ASCENDIONG ORDER.
C
      IF (MOD(NRCVAL,2).EQ.0) GO TO 1120
C
      CALL STER26(40,1)
      GO TO 10
C
 1120 CONTINUE
      NRHALF = NRCVAL/2
      NRSEC = NRHALF + 1
C
C  SEE IF DATES ARE IN ASCENDING ORDER
C
      CALL ASCN26(RCVAL,NRHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF DATES ARE BETWEEN 1 AND 366
C
      DO 1140 I=1,NRHALF
      IF (1.0.LE.RCVAL(I).AND.RCVAL(I).LE.366.02) GO TO 1140
C
      CALL STER26(64,1)
      GO TO 10
C
 1140 CONTINUE
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELEV VS. STORAGE CURVE
C  IF CURVE WAS NOT DEFINED, CALL IT AN ERROR
C
      DO 1155 I=NRSEC,NRCVAL
      RCVAL(I) = RCVAL(I)/CONVL
      ELUPR = AMAX1(ELUPR,RCVAL(I))
      ELOWR = AMIN1(ELOWR,RCVAL(I))
 1155 CONTINUE
C
      CALL ELST26(RCVAL(NRSEC),NRHALF,IERST)
      IF (IERST.GT.0) GO TO 10
C
C  STORE CODE FOR RULECURVE IN /MULT26/
C
      NMDEF(1) = NMDEF(1) + 1
      DMCODE(NMDEF(1),1) = CODEST
C
      GO TO 1170
C
C--------------------------------
C  FIRST FIELD AFTER 'CURVE' IS CHARACTER. SEE IF IT'S A VALID S/U ID
C  WITH OR WITHOUT PARENTHESES
C
 1160 CONTINUE
      GETTIM = .FALSE.
      CALL MREF26(1,CODEST,LOCWK,LOCCST,IERM)
      IF (IERM.GT.0) GO TO 10
C
C  GET THE UPPER AND LOWER BOUNDS OF THE RULE CURVE
C
      CALL BDRC26(WORK,LOCWK,ELUPR,ELOWR,IERC)
      IF (IERC.GT.0) GO TO 10
C
C  NOW MUST CHECK TO SEE IF RISING/FALLING SPECS (USING RULE CURVE
C  VALUES ARE BRACKETED PROPERLY. IF A RULE CURVE ELEVATION IS TO BE
C  USED THE RANGE OF VALUES MUST FIT WITHIN THE NEXT LOWEST AND NEXT
C  HIGHEST POOL ELEVATIONS IN THE RISING/FALLING RELATIONS.
C
 1170 CONTINUE
      IF (IP(9) .EQ. 0 .AND. IP(10) .EQ. 0) GO TO 1195
C
      IF (IP(9) .EQ. 0 .OR. .NOT.OK(9)) GO TO 1195
      IF (NHALFR .LE. 1) GO TO 1185
      NENDR = NHALFR - 1
      DO 1180 I=2,NENDR
      IF (ABS(RISING(I)+999.0).GT.0.1) GO TO 1180
      IF  (RISING(I-1).LT.ELOWR.AND.ELOWR.LT.RISING(I+1). AND.
     .     RISING(I-1).LT.ELUPR.AND.ELUPR.LT.RISING(I+1)) GO TO 1180
C
      CALL STRN26(67,1,INPUT(1,9),LINPUT(9))
      GO TO 10
C
 1180 CONTINUE
C
 1185 CONTINUE
      IF (IP(10) .EQ. 0 .OR. .NOT.OK(10)) GO TO 1195
      IF (NHALFF .LE. 1) GO TO 1195
      NENDF = NHALFF - 1
      DO 1190 I=2,NENDF
      IF (ABS(FALING(I)+999.0).GT.0.1) GO TO 1190
      IF  (FALING(I-1).LT.ELOWR.AND.ELOWR.LT.FALING(I+1). AND.
     .     FALING(I-1).LT.ELUPR.AND.ELUPR.LT.FALING(I+1)) GO TO 1190
C
      CALL STRN26(67,1,INPUT(1,10),LINPUT(10))
      GO TO 10
C
 1190 CONTINUE
C
C  CURVE IS DEFINED OK
C
 1195 CONTINUE
      OK(11) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------
C  'RULETIME' KEYWORD EXPECTED. IF FOUND, GET NEXT FIELD ON CARD
C   IF NOT FOUND, STORE VALUES IN WORK USING DEFAULT
C
 1200 CONTINUE
C
      IP(12) = IP(12) + 1
      IF (IP(12).GT.1) CALL STER26(39,1)
      IF (GETTIM) GO TO 1210
C
C  'RULETIME' FOUND BUT NOT NEEDED. (I.E. - A REFERENCE TO 'CURVE' WAS
C   FOUND.)
C
      CALL STRN26(60,1,INPUT(1,12),2)
      GO TO 10
C
C  AN INTEGER VALUE ( OR A NULL FIELD) MUST FOLLOW
C
 1210 CONTINUE
C
      OK(12) = .FALSE.
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 1250
C
C  SPECIFICATION MUST BE INTEGER
C
      IF (ITYPE.EQ.0) GO TO 1220
      CALL STER26(5,1)
      GO TO 10
C
 1220 CONTINUE
C
C  RULETIME MUST BE .GE. ZERO
C
      IF (INTEGR.GE.0) GO TO 1230
C
      CALL STER26(95,1)
      GO TO 10
C
C  TIME MUST BE MULTIPLE OF OPERATION TIME INTERCVAL.
C
 1230 CONTINUE
C$     IF (MOD(INTEGR,MINODT).EQ.0) GO TO 1240
C
C$     CALL STER26(47,1)
C$     GO TO 10
C
C$ 1240 CONTINUE
      RTIME = INTEGR + 0.01
C
C  EVERYTHING IS OK
C
 1250 CONTINUE
      OK(12) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------
C  'LAG/K' FOUND. MUST SET SOME VARIABLES AND CALL INPUT ROUTINE FOR
C  LAG/K OPERATION.
C
 1300 CONTINUE
      IP(13) = IP(13) + 1
      IF (IP(13) .GT. 1) CALL STER26(39,1)
C
      OK(13) = .FALSE.
ccc      MENNST = 0
ccc      IF (GAGE2) MENNST = 1
      LEFTP7 = 400
      IUSEP7 = 0
      NERTMP = NERRS
      NLAGK = NLAGK + 1
C
      CALL PIN7(P7,LEFTP7,IUSEPT,C7(NEXTC7),LEFTC7,IUSECT)
C
      HLAG = P7(20)
      NCARD = NCARD + NCD7
      LEFTP7 = LEFTP7 - IUSEPT
      LEFTC7 = LEFTC7 - IUSECT
      IUSEP7 = IUSEP7 + IUSEPT
      IUSEC7 = IUSEC7 + IUSECT
      NEXTP7 = IUSEP7 + 1
      NEXTC7 = IUSEC7 + 1
C
C  IF THIS IS THE SECOND GAGE, ONLY ONE LAG/K SPECIFICATION IS NEEDED.
C
      IF (GAGE2) GO TO 1350
      IF (P7(4).EQ.QINE) GO TO 1350
C
C  SET CURRENT LINE RECORD FOR LATER POSITIONING.
C
      LPOSST = LSPEC + NCARD + 1
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF .GT. 0) GO TO 9000
C
C  SEE IF NEXT LINE STARTS WITH 'RES-SNGL' INDICATING A SECOND LAG/K
C  PROCEDURE. MUST REPOSITION REGARDLESS OF INFO FOUND ON CARD.
C
      CALL POSN26(MUNI26,LPOSST)
      NCARD = NCARD - 1
      IF (IUSAME(CHAR,RESKEY,2) .EQ. 0) GO TO 1350
C
C  'RES-SNGL' FOUND. RESET SOME VARIABLES AND CALL PIN7 AGAIN.
C
      MENNST = 1
      NLAGK = NLAGK + 1
C
      CALL PIN7(P7(NEXTP7),LEFTP7,IUSEPT,C7(NEXTC7),LEFTC7,IUSECT)
C
      HLAG = P7(NEXTP7+19)
      NCARD = NCARD + NCD7
      IUSEP7 = IUSEP7 + IUSEPT
      IUSEC7 = IUSEC7 + IUSECT
      NEXTC7 = IUSEC7 + 1
C
 1350 CONTINUE
      IF (NERRS .EQ. NERTMP) GO TO 1390
C
      CALL STER26(117,1)
      GO TO 10
C
C  EVERYTHING IS OK WITH LAG/K DEFINITION
C
 1390 CONTINUE
      OK(13) = .TRUE.
      GO TO 10
C
C--------------------------------------------------------------------
C  EITHER 'GAGE2' OR 'ENDP' WAS FOUND. STORE INFORMATION FOR SCHEME IN
C  WORK ARRAY. SLIGHTLY DIFFERENT STARTEGIES ARE USED FOR END OF INPUT
C  VERSUS FINDING 'GAGE2'.
C
 5000 CONTINUE
C
      IF (IDEST .EQ. 0) GO TO 5002
C
      IP(14) = IP(14) + 1
      IF (IP(14) .GT. 1) CALL STER26(39,1)
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
C
C  IF NOTHING ON CARD, DEFAULT TO D/S FLOW CONDITION CONTROL
C
      IF (IERF.GE.1) GO TO 242
      NUMWD = (LEN-1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,TRIB,1,1,1)
      IF (IDEST.EQ.1) ITRIB(2)=1
 242  CONTINUE
C
C
C  SEE IF ALL UNCONDITIONALLY REQUIRED PARMS WERE ENTERED
C
 5002 CONTINUE
      DO 5005 I = 1,6
            NIP = IPREQ(I)
            IF (IP(NIP).EQ.0)
     .      CALL STRN26(59,1,INPUT(1,NIP),LINPUT(NIP))
 5005 CONTINUE
C
C  SEE IF RULE CURVE WAS NEEDED AND GOTTEN
C
      IF (GETRUL .AND. IP(11) .EQ. 0) CALL STRN26(59,1,INPUT(1,11),
     .       LINPUT(11))
C
C  IF ON SECOND GAGE AND FALLING RELATION WAS USED ON FIRST GAGE, SEE
C  IF FALLING WAS ENTERED FOR SECOND GAGE.
C
      IF (GAGE2 .AND. GFALL2 .AND. IP(10).EQ.0)
     .             CALL STRN26(59,1,INPUT(1,10),LINPUT(10))
C
C  IF ON SECOND GAGE AND RATING CURVE USED ON FIRST, RATING CURVE MUST
C  BE ENTERED FOR SECOND GAGE.
C
cc      IF (GAGE2 .AND. GETRC .AND. IP(4).EQ.0)
cc     .              CALL STRN26(59,1,INPUT(1,4),LINPUT(4))
C
C  SEE IF ALL PARMS WERE ENTERED WITHOUT ERROR.
C
      IF (IBUG.GE.2) WRITE(IODBUG,1666) (OK(L),L=1,13)
 1666 FORMAT('  OK = ',13(1X,L4))
      DO 5010 I=1,13
      IF (OK(I)) GO TO 5010
C
      IF (IDEST .EQ. 14) GO TO 5240
      GO TO 9999
C
 5010 CONTINUE
C
C  IF THIS IS INFO FOR THE SECOND GAGE, THEN THE HEADER INFO NEED NOT
C  BE WRITTEN
C
      IF (GAGE2) GO TO 5020
      IF (IDEST .EQ. 14) NGAGES = 2
      GAGENO = NGAGES + 0.02
      IF(ITRIB(1).EQ.1 .OR. ITRIB(2).EQ.1)
     & GAGENO=NGAGES*100+ITRIB(1)*10+ITRIB(2)+0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,GAGENO,501)
      NP08 = NP08 + 1
C
C  TRIBUTARY CONTROL SELECTED
C  REQUIRE BLEND AND QMAX PARAMETERS IN THE COMPUTATION
C  RULE CURVE MUST BE DEFINED USING RULECURVE SCHEME,
C  THEN REFERENCED TO IT IN THE STPOOLQ SCHEME
C
CC      ISX=CODEST/10
CC      ISCODE=ISX*10
CC      IF (GAGENO.GT.2 .AND. ISCODE.NE.1040) THEN
CC        CALL STER26(124,1)
CC        GO TO 10
CC      ENDIF
C
C  IF 'QDIST' WAS ENTERED WE NEED TO ENTER THE DISTRIBUTION CURVE
C
      CALL FLWK26(WORK,IUSEW,LEFTW,RLSETY,501)
      NP08 = NP08 + 1
      IF (RLSETY .LT. 1.00) GO TO 5020
C
      DO 5015 I=1,NQDIST
      CALL FLWK26(WORK,IUSEW,LEFTW,QDIST(I),501)
 5015 CONTINUE
      NP08 = NP08 + NQDIST
C
C  ENTER THE LAG TO THE DS GAGE
C
 5020 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,HLAG,501)
      NP08 = NP08 + 1
C
C  ENTER RATING CURVE NAME FOR GAGE (WILL BE BLANK IF NO RATING CURVE
C  USED).
C
      CALL FLWK26(WORK,IUSEW,LEFTW,RATING(1),501)
      CALL FLWK26(WORK,IUSEW,LEFTW,RATING(2),501)
      NP08 = NP08 + 2
C
C  STORE NO. OF CONTROL SCHEDULES ENTERED
C
      NCNTL = 0
      DO 5030 I=5,8
      IF (IP(I) .GT. 0) NCNTL = NCNTL + 1
 5030 CONTINUE
      CNTLNO = NCNTL + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,CNTLNO,501)
      NP08 = NP08 + 1
C
C  STORE THE FIRST CONTROL SCHEDULE
C
      CTL1NO = NCTL1 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL1NO,501)
      NP08 = NP08 + 1
C
      DO 5040 I=1,NCTL1
      IF (I.LE.NCTL1/2) CTL1(I) = CTL1(I)/CONVDS
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL1(I),501)
 5040 CONTINUE
      NP08 = NP08 + NCTL1
C
C  STORE THE SECOND RELEASE SCHEDULE (IF ENTERED)
C
      IF (NCNTL .LT. 2) GO TO 5080
C
      CTL2NO = NCTL2 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL2NO,501)
      NP08 = NP08 + 1
C
      DO 5050 I=1,NCTL2
      IF (I.LE.NCTL2/2) CTL2(I) = CTL2(I)/CONVDS
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL2(I),501)
 5050 CONTINUE
      NP08 = NP08 + NCTL2
C
C  STORE THE THIRD RELEASE SCHEDULE (IF ENTERED)
C
      IF (NCNTL .LT. 3) GO TO 5080
C
      CTL3NO = NCTL3 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL3NO,501)
      NP08 = NP08 + 1
C
      DO 5060 I=1,NCTL3
      IF (I.LE.NCTL3/2) CTL3(I) = CTL3(I)/CONVDS
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL3(I),501)
 5060 CONTINUE
      NP08 = NP08 + NCTL3
C
C  STORE THE FOURTH RELEASE SCHEDULE (IF ENTERED)
C
      IF (NCNTL .LT. 4) GO TO 5080
C
      CTL4NO = NCTL4 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL4NO,501)
      NP08 = NP08 + 1
C
      DO 5070 I=1,NCTL4
      IF (I.LE.NCTL4/2) CTL4(I) = CTL4(I)/CONVDS
      CALL FLWK26(WORK,IUSEW,LEFTW,CTL4(I),501)
 5070 CONTINUE
      NP08 = NP08 + NCTL4
C
C  WRITE RISING STAGE/DISCHARGE RELATION
C
 5080 CONTINUE
      RSING = NHALFR + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,RSING,501)
      NP08 = NP08 + 1
C
      NHALF = NRSING/2
C
      DO 5090 I=1,NHALF
      CALL FLWK26(WORK,IUSEW,LEFTW,RISING(I),501)
 5090 CONTINUE
C
      DO 5095 I=1,NHALF
      RREL = IRREL(I) + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,RREL,501)
 5095 CONTINUE
      NP08 = NP08 + NRSING
C
C  STORE INDICATION OF USE OF FALLING STAGE/DISCHARGE RELATION AND
C  STORE THE RELATION IF ENTERED.
C
      IF (IP(10) .EQ. 0) NFLING = 0
      FLING = NHALFF + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,FLING,501)
      NP08 = NP08 + 1
C
      IF (NFLING .EQ. 0) GO TO 5110
C
      NHALF = NFLING/2
      DO 5100 I=1,NHALF
      CALL FLWK26(WORK,IUSEW,LEFTW,FALING(I),501)
 5100 CONTINUE
C
      DO 5105 I=1,NHALF
      FREL = IFREL(I) + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,FREL,501)
 5105 CONTINUE
      NP08 = NP08 + NFLING
C
 5110 CONTINUE
C
C  ONLY NEED TO ENTER THE RULE CURVE (IF USED) FOR THE FIRST GAGE
C
cc      IF (GAGE2) GO TO 5200
      IF (GAGE2) THEN
        IF (.NOT.GETRUL) GO TO 5200
        IF(NRULA.LE.0) CALL STER26(123,1)
        GO TO 5200
      ENDIF
      IF (GETRUL) GO TO 5115
C
      CALL FLWK26(WORK,IUSEW,LEFTW,0.01,501)
      NP08 = NP08 + 1
      GO TO 5200
C
 5115 CONTINUE
      IF (ICTYPE.GT.1) GO TO 5130
C
C  CURVE WAS DEFINED IN THIS SCHEME
C
      PAIR = NRCVAL/2 + 0.01
      NRULA = PAIR
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
C
C  STORE LOCATION FOR THIS RULE CURVE DEFINITION
C
      IPOWD(NMDEF(1),1) = NPMENT + NP08 + 1
      IWKWD(NMDEF(1),1) = IUSEW
C
C  STORE CURVE DEFINITION
C
      DO 5120 I=1,NRCVAL
      CALL FLWK26(WORK,IUSEW,LEFTW,RCVAL(I),501)
 5120 CONTINUE
C
C  STORE RULE CURVE TIME
C
      CALL FLWK26(WORK,IUSEW,LEFTW,RTIME,501)
      NRCVAL = NRCVAL + 1
      GO TO 5150
C
C  STORE REFERENCE TO PREVIOUS DEFINITION IN WORK
C
 5130 CONTINUE
      CDELOC = - (LOCCST + 0.01)
      NRULA = ABS(CDELOC)
      NRCVAL = 0
      CALL FLWK26(WORK,IUSEW,LEFTW,CDELOC,501)
C
 5150 CONTINUE
C
      NP08 = NP08 + NRCVAL + 1
C
C  WRITE LAG/K INFORMATION HERE
C
 5200 CONTINUE
      QULAGK = NLAGK + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,QULAGK,501)
      NP08 = NP08 + 1
C
      DO 5210 I=1,IUSEP7
      CALL FLWK26(WORK,IUSEW,LEFTW,P7(I),501)
 5210 CONTINUE
      NP08 = NP08 + IUSEP7
C
C  IF THIS IS THE SECOND GAGE, JUST EXIT THE ROUTINE
C  OTHERWISE, WE MUST RESET MANY VARIABLE VALUES FOR READING KEYWORDS
C  FOR THE SECOND GAGE.
C
      IF (IDEST .EQ. 0) GO TO 9999
C
 5240 CONTINUE
      GAGE2 = .TRUE.
      NLAGK = 0
      RATING(1) = BLANK
      RATING(2) = BLANK
      CONVDS = CONVLT
C
      DO 5250 I=1,13
      OK(I) = .FALSE.
 5250 CONTINUE
C
C  SET OK SWITCHES TO TRUE FOR ALL OPTIONAL KEYWORDS
C
      OK(1) = .TRUE.
      OK(2) = .TRUE.
      OK(3) = .TRUE.
      OK(4) = .TRUE.
      OK(6) = .TRUE.
      OK(7) = .TRUE.
      OK(8) = .TRUE.
      OK(10)= .TRUE.
      OK(11)= .TRUE.
      OK(12) = .TRUE.
      OK(14)= .TRUE.
C
      DO 5260 I = 3,10
           IP(I) = 0
 5260 CONTINUE
      IP(13) = 0
C
      GO TO 10
C
C--------------------------------------------------------------
C  ERROR IN UFLD26
C
 9000 CONTINUE
      IF (IERF.EQ.1) CALL STER26(19,1)
      IF (IERF.EQ.2) CALL STER26(20,1)
      IF (IERF.EQ.3) CALL STER26(21,1)
      IF (IERF.EQ.4) CALL STER26( 1,1)
C
      IF (NCARD.GE.LASTCD) GO TO 9100
      IF (IBLOCK.EQ.1)  GO TO 5
      IF (IBLOCK.EQ.2)  GO TO 10
C
 9100 USEDUP = .TRUE.
C
 9999 CONTINUE
      IN = INTEMP
      RETURN
      END