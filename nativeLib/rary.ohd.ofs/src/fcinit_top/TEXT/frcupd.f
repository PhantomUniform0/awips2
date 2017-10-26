C MEMBER FRCUPD
C  (from old member FCFRCUPD)
C
C  UPDATE OPTION FOR FDEFRC
C-----------------------------------------------------------------------
C                             LAST UPDATE: 07/10/95.11:44:32 BY $WC21DT
C
C @PROCESS LVL(77)
C
      SUBROUTINE FRCUPD(WORK,MAXPTS,IFOUND,KEEPOP)
C
C        FRCUPD - HANDLES UPDATE OPTION FOR FDEFRC
C
C SUBROUTINE FRCUPD HANDLES THE UPDATE OPTION FOR DEFINING RATING CURVE.
C UPDATE ALLOWS NEW STAGE-Q VALUES TO BE INPUT FOR A PREVIOUSLY
C DEFINED RATING CURVE ONLY.
C ONLY STAGE-Q VALUES ARE UPDATED. THIS ROUTINE DOES THE FOLLOWING:
C  1. READ NEW STAGE-Q VALUES
C  3. SHIFTS THE X.S. AND OPTIONAL INFO FORWARD OR BACKWARD IN WORK
C     ARRAY AS NECESSARY.
C
C THE ARGUMENT LIST IS:
C   WORK - WORK SPACE ARRAY
C   MAXPTS - MAX DIMENSION OF WORK
C   IFOUND-OUTPUT-STATUS CODE FOR 'ID' OR 'END' CARD ENCOUNTERED
C   KEEOP -I- OPTION FOR KEEP OLD POINTS
C             0=DONT KEPP ANY OLD RC POINTS
C             1=KEEP OLD POINTS HIGHER THAN HIGHEST NEW VALUE
C                0=NO 1=ID 2=END
C
C.......................................................................
C
C SUBROUTINE ORIGINALLY BY ED VANBLARGAN - HRL - FEB,1983
C   STORED IN PANVALET UNDER FDEFRC
C.......................................................................
C
C GENERAL OUTLINE IS TO:
C   1. READ NUMBER OF NEW POINTS AND UNITS USED
C   2. READ NEW STAGE,DISCHARGE VALUES INTO WORK
C   3. DETERMINE IF AND WHAT OLD VALUES MUST BE KEPT
C   4. UPDATE THE WORK ARRAY WITH NEW VALUES AND ANY OLD INFO
C   5. TRANSFERS VALUES FROM WORK TO XRC(X.S. AND OPTIONAL INFO MAY
C      BE SHIFTED FORWARD OR BACK).
C
C VARIABLES USED (OTHER THAN COMMON BLOCK AND ARGUMENT LIST):
C ** INTERNAL VARIABLES USED **
C
C VARIABLE DIM. DESCRIPTION
C -------- ---- ------------------------------
C INIT       1  STARTING LOCATION OR 1ST COLUMN IN A SPECIFIC FIELD
C IFIN       1  LAST LOCATION     "  LAST  "     "    "        "
C
C FACTOR     1  CONVERSION FACTOR FOR UNITS
C FACLEN     1      "        "    "   UNITS TO M.
C FACVOL     1      "        "    "   UNITS TO CUBIC M
C HMAXNU     1  MAX STAGE VALUE OF NEWLY INPUT VALUES
C IER        1  ERROR FLAG
C ISUMPT     1  RUNNING SUM OF POINTS READ IN SO FAR
C IWARN      1  WARNING FLAG
C LNEWH      1  STARTING LOCATION OF NEW STAGE(H)   VALUES IN WORK
C LNEWQ      1     "        "     "   "  DISCHARGE(Q)  "   "   "
C LNEWEL     1     "        "     "   "  ELEV.         "   "   "
C LNEWTW     1     "        "     "   "  TOPWIDTH      "   "   "
C LNEWOP     1     "        "     "   "  OPTIONAL INFO "   "   "
C LNH        1  CURRENT LOCATION POINTER OF H VALUE IN WORK
C LNQ        1    "        "        "    "  Q   "   "   "
C LXH        1    "        "        "    "  H   "   "  XRC
C LXQ        1    "        "        "    "  Q   "   "   "
C LXKEEP     1  LOCATION IN XRC THAT STARTS STAGE VALUES TO BE KEPT
C NXKEEP     1  NUMBER OF STAGE (OR Q) VALUES IN XRC TO BE KEPT
C LOCW       1  LOCATION TO CURRENT LOCATION IN WORK
C LOCXRC     1  POINTER TO LOCATION IN XRC ARRAY
C NEXLOC     1  LOCATION OF NEXT PIECE OF OPTIONAL INFO IN XRC
C NEWPTS     1  NUMBER OF NEW R.C. PAIRS
C NUMPAR     1  NUMBER OF PAIRS READ IN SO FAR
C NUMPTS     1  NUMBER OF POINTS (NUMBER OF PAIRS*2)
C NUPTOT     1  NUMBER OF NEW R.C. POINTS TOTAL (INCL. NEW PTS + OLD
C               VALUES TO BE KEPT)
C OPTN       1  UNITS USED FOR INPUT (BLANK-DEFAULT TO ORIGINAL-OPTION)
C
C
      LOGICAL ENGUNT,NEEDFQ
      CHARACTER*8 EXINT,EXLOG,EXLIN
      DIMENSION WORK(1)
C
C
      INCLUDE 'common/ionum'
C
      INCLUDE 'common/fdbug'
C
      INCLUDE 'ufreei'
C
      INCLUDE 'common/frcers'
C
      INCLUDE 'common/fratng'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_top/RCS/frcupd.f,v $
     . $',                                                             '
     .$Id: frcupd.f,v 1.2 2000/07/21 18:51:52 page Exp $
     . $' /
C    ===================================================================
C
C
C
      DATA RTCV/4HRTCV/,ENGL/4HENGL/,BLANK/4H    /
      DATA EXLOG/'LOG-LOG '/,EXLIN/' LINEAR '/
C INITIALIZE
      IBUG=IFBUG(RTCV)
      NEEDFQ=.TRUE.
C
C **********************************************************************
C
C ** CARD 2 ** - RUN INFORMATION - NEWPTS,(OPTION),STGMIN
C
C  THE FOLLOWING CHANGE MADE ON 4/16/90 -- MAIN. #493, #593
C      NCD=NCD+1
C  END OF CHANGE OF 4/16/90 -- MAIN. #493, #593
      NCIS=2
      MXF=3
      MNF=2
      IER=0
      CALL FRCRDC(IBUG,IFOUND)
      IF (IFOUND.NE.0) GO TO 9999
      IF (NFIELD.GT.MXF .OR. NFIELD.LT.MNF) CALL FRCERR(1)
C
C FIELD 1 - NEWPTS - NUMBER OF NEW RATING CURVE POINTS
C
      NFC=1
      NFIS=1
      IF (IFTYPE(1).NE.1) IER=1
      CALL UNUMIC(IBUF,IFSTRT(1),IFSTOP(1),NEWPTS)
      IF (NEWPTS.GT.MAXPTS .OR. NEWPTS.LE.0) IER=1
      IF (IER.EQ.1) CALL FRCERR(3)
C
C FIELD 2 - OPTN - UNITS USED (OPTIONAL)
C
C CHECK FOR 'ENGL' OR 'METR' (OR 'E' OR 'M') OR BLANK FOR DEFAULT TO
C ORIGINAL UNITS.
C
      ENGUNT=.FALSE.
      IF (NFIELD.EQ.MXF) GO TO 700
C
C FIELD IS BLANK, THEREFORE DEFUALT TO ORIGINAL UNITS
C
      IF (OPTION.EQ.ENGL) ENGUNT=.TRUE.
      GO TO 800
C FIELD IS PRESENT
700   NFC=2
      NFIS=2
      MXC=4
      INIT=IFSTRT(NFC)
      NCHAR=IFSTOP(NFC)-INIT+1
      CALL FRCOPT(INIT,ENGUNT,OPTN)
C
C SET UP CONVERSION FACTORS TO GET INTO METRIC(=1 FOR 'METR')
C
800   FACLEN=1.0
      FACVOL=1.0
      IF (ENGUNT) CALL FRCUN(FACLEN,FACVOL,FACMKM,IER)
      IERSUM=IERSUM+IER
C
C FIELD 3 - STGMIN - MINIMUM ALLOWABLE STAGE
C
      NFC=NFC+1
      NFIS=3
      CALL UFIXED(IBUF,STGMIN,IFSTRT(NFC),IFSTOP(NFC),2,0,IER)
      IF (IER.NE.0 .OR. IFMSNG(STGMIN).NE.0) CALL FRCERR(3)
      STGMIN=STGMIN/FACLEN
C
C **********************************************************************
C
C ** CARD 3 ** STAGE,DISCHARGE PAIRS
C
      K=NCD+1
      NCIS=6
      MXF=2
      MNF=2
      IWARN=0
C
C FIELD 1,2 - NEW STAGE,DISCHARGE PAIRS - READ INTO WORK ARRAY
C
C READ INPUT VALUES UNTIL NUMBER OF VALUES EXPECTED (NEWPTS*2) HAS BEEN
C SATISFIED. CONVERT EACH VALUE TO METRIC, PUT INTO WORK ARRAY
C SEQUENTIALLY, AND CHECK THAT VALUES ARE ASCENDING AND Q'S ARE POSITIVE
C
C PROCEDURE IS TO CONTINUE READING CARDS UNTIL THE NUMBER OF POINTS
C EXPECTED IS SATISFIED. FOR EACH CARD ANALYZE THE PAIRS OF H,Q VALUES
C BY USING A NESTLED LOOP. THE OUTER LOOP SIMPLY LOOPS TWICE FOR FIELD 1
C OR FIELD 2 AND THE INNER LOOP CHECKS EACH VALUE USING AN LOOP
C INCREMENTOR OF 2 SO THAT ON 1ST PASS THE 1ST VALUES (H) IN THE PAIR
C ARE GOTTEN AND ON 2ND PASS THE 2ND VALUES IN THE PAIRS (Q) ARE
C GOTTEN.
C
C FIRST SET STARTING LOCATIONS (LNEWH,LNEWQ), THE NUMBER OF VALUES EXPEC
C (NUMPTS), THE LOCATION IN WORK(LOCW) TO START, AND SUM OF POINTS READ
C COUNTER(ISUMPT=2 SINCE IST PAIR IS TREATED SEPARATELY AS EXPLAINED BEL
C
      LNEWH=1
      LNEWQ=NEWPTS+1
      NUMPTS=NEWPTS*2
      IF (NUMPTS.GT.MAXPTS) GO TO 9990
      ISUMPT=2
      LOCW=1
C
C READ CARD, SET NUMBER OF PAIRS READ SO FAR (NOT REALLY VALID FOR FIRST
C CARD) AND CHECK THAT NFIELD IS AN EVEN NUMBER.
C
2500  CALL FRCRDC(IBUG,IFOUND)
      IF (IFOUND.NE.0) GO TO 9999
      IF (NFIELD.EQ.0) GO TO 2500
      IF (MOD(NFIELD,2).NE.0) CALL FRCERR(1)
      NUMPAR=ISUMPT/2
      FACTOR=FACLEN
C
C OUTER LOOP FOLLOWS THAT WILL LOOP THRU CARD TWICE, ONCE FOR H VALUES
C AND ONCE FOR Q VALUES.
C
C ** START OUTER LOOP **
      DO 2800 NFIS=1,2
      INIT=NFIS
      IF (NFIS.EQ.2) FACTOR=FACVOL
C
C COULD SIMPLY SET POINTERS FOR NESTLED LOOP BELOW EXCEPT FOR 1ST PAIR
C BECAUSE ASCENDING ORDER IS CHECKED IN NESTLED LOOP AND 1ST PAIR
C CAN'T BE CHECKED. THEREFORE IF ON 1ST CARD(NCD=K) THEN ANALYZE
C IST PAIR SEPARATELY(CONVERT TO REAL AND METRIC) AND SET POINTERS
C TO 2ND PAIR (INIT=3 OR 4), THEN GO TO NESTLED LOOP.
C
      IF (NCD.NE.K) GO TO 2520
      INIT=INIT+2
      IF(NFIS.EQ.2) LOCW=LNEWQ
      CALL UFIXED(IBUF,WORK(LOCW),IFSTRT(NFIS),IFSTOP(NFIS),2,0,IER)
      IF (IER.NE.0) CALL FRCERR(3)
      WORK(LOCW)=WORK(LOCW)/FACTOR
      GO TO 2550
C
C THIS IS NOT FIRST CARD, THEREFORE SIMPLY SET LOCW AND GO INTO
C NESTLED LOOP BELOW.
C LOCW IS SET= NUMBER OF PAIRS READ SO FAR FOR FIELD 1(H VALUES) OR
C LOCW IS SET= PAIRS READ PLUS TOTAL PAIRS EXPECTED(NEWPTS)
C
2520  LOCW=NUMPAR
      IF (NFIS.EQ.2) LOCW=NUMPAR+NEWPTS
C
C NESTLED LOOP FOLLOWS TO GO THRU THE FIELDS. LOOP INCREMENTER=2 SINCE
C WE WANT 1 VALUE FROM EACH PAIR. INITIAL COUNTER (INIT)=1 TO GO THRU
C H VALUES AND INIT=2 TO GO THRU Q VALUES. THIS WAS SET ABOVE IN
C OUTER LOOP (EXCEPTION IS FOR VERY 1ST CARD, INIT IS 3 OR 4).
C FIRST THING INSIDE LOOP IS TO INCREMENT LOCATION AND SUM OF POINTS
C READ COUNTERS.
C
C ** START INNER LOOP **
2550  DO 2700 NFC=INIT,NFIELD,2
      LOCW=LOCW+1
      ISUMPT=ISUMPT+1
C
C NO. OF POINTS READ MUST BE .LE. NUMBER OF VALUES EXPECTED, OTHERWISE
C GIVE WARNING AND STOP ANALYSIS. ONLY WARN IF 1ST TIME(IWARN=0).
C
      IF ((ISUMPT/2+2-NFIS).LE.NEWPTS) GO TO 2600
      IF (IWARN.EQ.1) GO TO 2800
      WRITE(IPR,8115) NEWPTS,NCIS
      CALL WARN
      IWARN=1
      GO TO 2800
C
C CONVERT EACH VALUE TO REAL AND METRIC, THEN CHECK IF IT IS IN
C ASCENDING ORDER. IF NOT GIVE ERROR.
C
2600  CALL UFIXED(IBUF,WORK(LOCW),IFSTRT(NFC),IFSTOP(NFC),2,0,IER)
      IF (IER.NE.0) CALL FRCERR(3)
      WORK(LOCW)=WORK(LOCW)/FACTOR
      IF (WORK(LOCW).GT.WORK(LOCW-1)) GO TO 2700
      CALL FRCERR(3)
      WRITE(IPR,8135)
C
2700  CONTINUE
C ** END INNER LOOP **
2800  CONTINUE
C ** END OUTER LOOP **
C
C CARD IS NOW DONE, THEREFORE CHECK IF ALL RC POINTS ARE IN. IF NOT,
C GO BACK UP AND LOOP THRU FIELDS ON THE NEXT CARD
C
      IF (ISUMPT.LT.NUMPTS) GO TO 2500
      IF (KEEPOP.EQ.-1) GO TO 9999
C
C CHECK THAT FIRST DISCHARGE IS POSITIVE
C
      NFC=1
      IF (WORK(LNEWQ).GE.0.) GO TO 3000
      CALL FRCERR(3)
      WRITE(IPR,8155) WORK(LNEWQ)
C
C.............DEBUG TIME................................................
3000  IF(IBUG.GT.0) WRITE(IODBUG,8965) LNEWH,LNEWQ,(WORK(L),L=1,LOCW)
C.......................................................................
C
C **********************************************************************
C
C NOW THAT NEW R.C. VALUES ARE IN WORK.... ADD ANY OLD VALUES TO BE KEPT
C AND ANY X.S. OR OPTIONAL INFO.
C DO THIS BY:
C  1. IF NEWPTS LE NRCPTS AND ALL OLD H VALUES ARE LE HIGHEST
C     NEW STAGE; THEN SIMPLY TRANSFER ANY X.S. OR OPTIONAL INFO
C      FROM XRC TO WORK (PUT IMMEDIATELY AFTER NEW .R.C. VALUES)
C
C  2. OTHERWISE,
C      -IF SOME OLD STAGES MUST BE KEPT THEN
C       2A. SHIFT NEW Q VALUES IN WORK (TO ALLOW ROOM FOR OLD H'S)
C       2B. ADD OLD VALUES(H AND Q) FROM XRC INTO WORK
C           ALSO ADD ANY X.S. OR OPTIONAL INFO
C       2C. SHIFT POINTERS FOR XRC UP OR BACK DEPENDING ON TOTAL
C           IN WORK
C      -IF ONLY NRCPTS GT NEWPTS BUT NO OLD STAGES TO BE KEPT THEN
C       2A. SHIFT ANY X.S. OR OPTIONAL INFO FROM XRC TO WORK
C       2B. UPDATE POINTERS FOR XRC (SHIFT BACK)
C
C
C FIRST LOOP THRU XRC TO SEE IF ANY OLD POINTS NEED TO BE KEPT.
C KEEP ANY OLD STAGE THAT IS HIGHER THAN HIGHEST NEW STAGE
C BY MORE THAN 0.01.
C ALSO CHECK THAT CORRESPONDING OLD Q IS HIGHER.
C
      NUPTOT=NEWPTS
C EV MOD-IF OPTION=0 THEN CAN SKIP ALL THEIS LOGIC ABOUT
C        CHECKING AND ADDING OLD POINTS
      IF (KEEPOP.EQ.0) GO TO 4400
      HMAXNU=WORK(LNEWH+NEWPTS-1)
      QMAXNU=WORK(LNEWQ+NEWPTS-1)
C
      N=NRCPTS+LOCH-1
      DO 4000 LXH=LOCH,N
      LXKEEP=LXH
      HKEEP=XRC(LXH)
      IF (HKEEP.LE.HMAXNU+0.01) GO TO 4000
C OLD H WAS FOUND THAT IS HIGHER-CHECK CORREDSPONDING Q
      QKEEP=XRC(LOCQ+LXH-1)
      IF (QKEEP.GT.QMAXNU) GO TO 4100
      WRITE(IPR,8335) QKEEP,QMAXNU
      IERSUM=IERSUM+1
      CALL ERROR
      GO TO 9999
4000  CONTINUE
C
      NXKEEP=0
      LXKEEP=0
      GO TO 4400
C
C NEED TO KEEP SOME OLD POINTS, THEREFORE, CHECK IF NEW FLOOD Q NEEDED
C AND IF SLOPE R.C. SLOPE CHANGED TOO MUCH. THEN,
C   1. SHIFT ALL Q VALUES BACK IN WORK TO ALLOW FOR ADDITIONAL
C      H VALUES - AND UPDATE LNEWQ
C   2. ADD OLD Q VALUES TO END OF WORK (FIRST CHECK IF ROOM EXISTS)
C   3. ADD OLD H VALUES INTO WORK AFTER NEW H VALUES
C
C CHECK IF NEW FLOODQ NEEDED
4100  IF (FLDSTG.GE.HKEEP) NEEDFQ=.FALSE.
C
C CHECK CHANGE IN SLOPE (LOG-LOG) AT JUNCTION OF OLD AND NEW R.C.
C PRINT WARNING IF SLOPE CHANGES BY MORE THAN 10 %.
C CHECK SLOPES SUCH THAT STAGE DIFFERENCES ARE GT SOME SPECIFIED
C TOLERANCES.
C
      TOLER=0.5
      ICMPR=0
C FIND NEW STAGE THAT DIFFERS FROM HMAXNU BY MORE THAN TOLER.
      DO 4102 N=2,NEWPTS
      XLOWH=WORK(LNEWH+NEWPTS-N)
      XLOWQ=WORK(LNEWQ+NEWPTS-N)
      IF (HMAXNU-XLOWH.GT.TOLER) GO TO 4104
4102  CONTINUE
      ICMPR=1
C FIND OLD STAGE THAT DIFFERS FROM HMAXNU BY MORE THAN TOLER
4104  IF (HKEEP-HMAXNU.GT.TOLER) GO TO 4108
      L=NRCPTS+LOCH-1
      DO 4106 N=LXKEEP,L
      HKEEP=XRC(N)
      QKEEP=XRC(LOCQ+N-1)
      IF (HKEEP-HMAXNU.GT.TOLER) GO TO 4108
4106  CONTINUE
      ICMPR=1
C CHECK IF ANY VALUES EQUAL 0 OR IF ONLY 1 NEW POINT
4108  IF (NEWPTS.EQ.1) ICMPR=1
      IF (XLOWH.EQ.0.0 .OR. XLOWQ.LT.0.001) ICMPR=1
      LXOFF=EMPTY(2)
      IF (LXOFF.GT.0) ICMPR=1
      IF (ICMPR.EQ.0) GO TO 4110
      WRITE(IPR,8165)
      GO TO 4150
C COMPUTE SLOPES, OLD AND NEW
 4110 CONTINUE
      QN=QMAXNU
      QO=QKEEP
      HN=HMAXNU
      HO=HKEEP
      XLQ=XLOWQ
      XLH=XLOWH
      IF(EMPTY(4) .GT. 1.0) GO TO 4120
      QN=ALOG(QN)
      QO=ALOG(QO)
      HN=ALOG(HN)
      HO=ALOG(HO)
      XLQ=ALOG(XLQ)
      XLH=ALOG(XLH)
4120  SLPNEW=(QN-XLQ) / (HN-XLH)
      SLPOLD=(QO-QN) / (HO-HN)
C SEE IF NEW SLOPE CHANGED TOO MUCH (GT 10%)
      DELMAX=0.10*SLPOLD
      IF (SLPNEW.LE.DELMAX+SLPOLD .AND. SLPNEW.GE.SLPOLD-DELMAX)
     $ GO TO 4150
C NEW SLOPE CHANGED MORE THAN EXPECTED
      EXINT=EXLOG
      IF(EMPTY(4) .GT. 1.0) EXINT=EXLIN
      WRITE(IPR,8170) EXINT
      CALL WARN
C
C NOW SHIFT THINGS IN WORK ARRAY
C
4150  NXKEEP=NRCPTS-LXKEEP+1
      NUPTOT=NEWPTS+NXKEEP
      IF (NUPTOT*2.GT.MAXPTS) GO TO 9990
C SHIFT Q'S - START WITH HIGHEST AND WORK BACK TO LOWEST
C (NEW H VALUES CAN STAY PUT IN WORK)
      LNQ=LNEWQ+NUPTOT
      LOCW=LNEWQ+NEWPTS
      DO 4200 L=1,NEWPTS
4200  WORK(LNQ-L)=WORK(LOCW-L)
      LNEWQ=LNEWH+NUPTOT
C ADD OLD Q'S AND OLD H'S
      LNH=LNEWH+NEWPTS-1
      LXH=LXKEEP-1
      LNQ=LNEWQ+NEWPTS-1
      LXQ=LXH+NRCPTS
      DO 4300 L=1,NXKEEP
      WORK(LNH+L)=XRC(LXH+L)
      WORK(LNQ+L)=XRC(LXQ+L)
4300  CONTINUE
C RESET NRCPTS
4400  NRCPTS=NUPTOT
C
C STAGE-DISCHARGE VALUES IN WORK ARE NOW COMPLETE...
C NOW TRANSFER ANY X.S. OR OPTIONAL INFO FROM XRC TO WORK
C
C DO GSOFFSET INFO - IST SET POINTERS
C
      LNEWX=LNEWQ+NUPTOT
      LXOFF=EMPTY(2)
      IF (LXOFF.EQ.0) GO TO 4599
      NGSOFF=XRC(LXOFF)+0.01
      IF (LNEWX+NGSOFF.GT.MAXPTS) GO TO 9990
      WORK(LNEWX)=NGSOFF+.01
      N=NGSOFF*2
      DO 4586 L=1,N
      WORK(LNEWX+L)=XRC(LXOFF+L)
4586  CONTINUE
      EMPTY(2)=LNEWX+.01
C
C DO X.S. INFO - IST SET POINTERS
C
4599  CONTINUE
      LNEWEL=-999
      LNEWTW=-999
      IF (NCROSS.EQ.0) GO TO 4600
      LNEWEL=LNEWQ+NUPTOT
      IF (LXOFF.GT.0) LNEWEL=LNEWX+NGSOFF*2+1
      LNEWTW=LNEWEL+NCROSS
      LNEWOP=LNEWTW+NCROSS
      IF (LNEWOP.GT.MAXPTS) GO TO 9990
C
      DO 4500 L=1,NCROSS
      WORK(LNEWEL+L-1)=XRC(LXELEV+L-1)
      WORK(LNEWTW+L-1)=XRC(LXTOPW+L-1)
4500  CONTINUE
C
C TRANSFER ANY OPTIONAL INFO
C GO THRU THE INFO FOR EACH CODE UNTIL A -1 IS FOUND. FOR EACH DO:
C   1. CHECK IF CODE = -1. IF SO, END OPTIONAL INFO
C   2. DETERMINE HOW MANY PIECES OF INFO FOR THIS CODE(NUMPTS)
C   3. LOOP THRU NUMPTS AND TRANSFER EACH PIECE OF INFO TO WORK
C
4600  LOCXRC=IPOPT
      LOCW=LNEWQ+NUPTOT
      IF (LXOFF.GT.0) LOCW=LOCW+NGSOFF*2+1
      IF (NCROSS.GT.0) LOCW=LOCW+NCROSS*2
      LNEWOP=LOCW
C
4700  WORK(LOCW)=XRC(LOCXRC)
      IF (WORK(LOCW).LE.-1.) GO TO 4900
      NEXLOC=XRC(LOCXRC+1) + 0.001
      NUMPTS=NEXLOC-LOCXRC
      IF (LOCW+NUMPTS.GT.MAXPTS) GO TO 9990
C
      N=NUMPTS-1
      DO 4800 L=1,N
4800  WORK(LOCW+L)=XRC(LOCXRC+L)
C RESET LOCXRC TO NEXLOCATION AND UPDATE NEXT LOCATION IN WORK (LOCW+1)
      LOCXRC=NEXLOC
      WORK(LOCW+1)=LOCW+NUMPTS
      LOCW=WORK(LOCW+1)
      GO TO 4700
C
C
C WORK ARRAY NOW COMPLETE...SO TRANSFER WORK ARRAY TO XRC AND
C UPDATE XRC POINTERS
C
4900  DO 5000 L=1,LOCW
5000  XRC(L)=WORK(L)
      IF (LOCW.EQ.MAXPTS) GO TO 5100
      NW=LOCW+1
      DO 5050 L=NW,MAXPTS
         XRC(L)=BLANK
5050     CONTINUE
5100  LOCH=LNEWH
      LOCQ=LNEWQ
      LXELEV=LNEWEL
      LXTOPW=LNEWTW
      IPOPT=LNEWOP
C CHECK ANY OFFSET INFO
      IF (LXOFF.EQ.0 .OR. NGSOFF.EQ.0) GO TO 4601
      LXOFF=EMPTY(2)
      DO 4596 L=1,NGSOFF
      YVAL=XRC(LXOFF+L)
      DO 4597 I=1,NRCPTS
        HVAL=XRC(LOCH+I-1)
        IF(YVAL.GE.HVAL-0.001.AND.YVAL.LE.HVAL+0.001) GO TO 4596
4597  CONTINUE
      WRITE(IPR,4593)
4593  FORMAT(1X,'ERROR GS OFFSET NOT COMPATIBLE WITH NEW RC POINTS')
      IERSUM=IERSUM+1
4596  CONTINUE
4601  CONTINUE
C
C GET FLOODQ (IF NECESSARY- NEEDFQ=TRUE) AND GET SHIFT FACTOR
C
      IF (NEEDFQ) CALL FRCFQ(FACVOL,IBUG)
      CALL FRCSHF(1.0,WORK)
      GO TO 9999
C
C COMES HERE WHEN NOT ENOUGH ROOM EXISTED IN WORK ARRAY FOR OPTIONAL
C INFO
C
9990  WRITE(IPR,8315)
      IERSUM=IERSUM+1
      CALL ERROR
C
C
C
9999  RETURN
C
C ...............FORMATS................................................
C
8115  FORMAT(1H0,10X,41H**WARNING** TOO MANY POINTS ENTERED. ONLY,
     * 9H EXPECTED,I4,30H POINTS FOR INPUT SUMMARY CARD,I3)
C
8135  FORMAT(11X,39HINPUT PAIRS ARE NOT IN ASCENDING ORDER.,
     * 46H CHECK INPUT VALUES ON THIS AND PREVIOUS CARD.)
C
8155  FORMAT(11X,43HSECOND VALUE IN 1ST INPUT PAIR IS NEGATIVE=,F10.2)
C
8165  FORMAT(1H0,10X,45H**NOTE SLOPE OF RATING CURVE WAS NOT CHECKED.)
C
8170  FORMAT(1H0,10X,44H**WARNING** SLOPE OF NEW POINTS DIFFERS FROM,
     $ ' OLD BY MORE THAN 10 PERCENT BASED ON A ',A8,'ANALYSIS.')
C
8315  FORMAT(1H0,10X,40H**ERROR** NOT ENOUGH ROOM EXISTS IN WORK,
     * 49H ARRAY FOR UPDATING WITHOUT ERASING SOME EXISTING,
     * 59H OPTIONAL INFO. USE "REPL" OPTION TO REDEFINE RATING CURVE.)
C
8335  FORMAT(1H0,10X,40H**ERROR** FOUND AN OLD STAGE HIGHER THAN,
     $ 58H LAST UPDATE STAGE, BUT CORRESPONDING DISCHARGE WAS LOWER.
     $ / 20X,7HOLD Q =,F10.2,2X,7HNEW Q =,F10.2)
C
C DEBUG FORMATS
C
8965  FORMAT(1X,25HLNEWH,LNEWQ,WORK(NRCPTS)=,2I4 / (1X,10F10.2 /))
C
C.......................................................................
C
      END