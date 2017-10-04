C MODULE PIN20
C-----------------------------------------------------------------------
C
      SUBROUTINE PIN20(PO,LEFTP,IUSEP,CO,LEFTC,IUSEC)
C
C     THIS IS THE INPUT SUBROUTINE FOR OPERATION WHICH CHANGES THE
C       TIME INTERVAL OF ONE TIME SERIES TO ANOTHER.  THIS SUBROUTINE
C       READS INPUT, DOES CHECKS, AND FILLS THE PO AND CO ARRAYS.
C
C     RULES: 1. DATA UNITS MUST BE THE SAME FOR THE TIME SERIES
C            2. THREE WAYS OF CONVERTING-INST,MEAN,OR ACCUM. CAN BE
C       INCREASING OR DECREASING DELTA T. THE TIME INTERVALS MUST BE
C       MULTIPLES OF EACH OTHER.
C
C     EXCEPTION TO RULES: CAN GO FROM MEAN DAILY Q TO INST Q IF TIME
C     INTERVAL IS DECREASING
C
C  ROUTINE ORIGINALLY WRITTEN BY - ED VANBLARGAN - HRL - 4/1981
C
      CHARACTER*80 CARD
      LOGICAL IERR
C
      DIMENSION PO(*),CO(*)
      DIMENSION ISUBN(2),IDA(2),IDB(2)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_pntb/RCS/pin20.f,v $
     . $',                                                             '
     .$Id: pin20.f,v 1.3 2002/02/11 19:01:08 dws Exp $
     . $' /
C    ===================================================================
C
      DATA ISUBN,LTRACE,NOP,IZER,IONE/4HPIN2,4H0   ,1,20,0,1/
      DATA MEAN,INST,IACC/4HMEAN,4HINST,4HACCM/
      DATA IYES,IUNIT/3HYES,4HCMSD/,NTRP/4HNTRP/
C
C
      CALL FPRBUG(ISUBN,LTRACE,NOP,IBUG)
C
C ....INITIALIZE VARIABLES
C
      IUSEP=0
      IUSEC=0
      IVER=1
      IERR=.FALSE.
C
C ....NEXT,READ INPUT CONTAINING IDENTIFICATION OF THE TWO TIME SERIES
C     AND CARRYOVER.
C
      READ (IN,'(A)') CARD
      READ (CARD,100,ERR=101) IDA,IDTA,ITA,IDB,IDTB,ITB,NOPT,IRDCO,
     * PREVQ,PREVAL
100   FORMAT(2X,2A4,1X,A4,3X,I2,2X,2A4,1X,A4,3X,I2,1X,A4,2X,A3,2F10.0)
      GO TO 102
101   CALL FRDERR (IPR,' ',CARD)
C
C ....NEXT,ROUTINES TO CHECK TIME SERIES ID'S
C ....CHECK IF ANY ERRORS WERE OUTPUT
C
102   CALL CHEKTS (IDA,IDTA,ITA,IZER,IDIMA,IONE,IONE,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
      CALL FDCODE(IDTA,ISUNA,IDIMS,MSGA,NPDT,ITSA,NADD,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
C
      CALL CHEKTS(IDB,IDTB,ITB,IZER,IDIMB,IONE,IONE,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
      CALL FDCODE(IDTB,ISUNB,IDIMS,MSGB,NPDT,ITSB,NADD,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
C
C
C ....CHECK IF SPACE EXISTS IN P ARRAY
C
      NEEDP=14
      CALL CHECKP(NEEDP,LEFTP,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
C
C ....TIME INTERVAL ARE EQUAL (DIFFERENT DATA TYPE PERMITTED)
C ....MISSING DATA IN 1ST TIME SERIES ARE GERATED BY LINEAR
C ....INTEPOLATION THEN MOVED INTO 2ND TIME SERIES
C 
      IF(ITA.EQ.ITB) THEN
         NEEDC=0
         GO TO 1000
      ENDIF
C
C     CHECK IF MISSING VALUES ALLOWED. IF MSGA=1 WHILE MSGB=0 IT IS
C     ERROR (MSG=1 MEANS MISSING DATA ALLOWED).
C
      IF (MSGB.NE.0) GO TO 160
      IF (MSGA.NE.1) GO TO 160
      WRITE (IPR,150)
150   FORMAT(1H0,10X,36H**ERROR** INPUT TIME SERIES CAN HAVE,
     *46H MISSING VALUES BUT OUTPUT TIME SERIES CANNOT.)
      CALL ERROR
      IERR=.TRUE.
160   CONTINUE
C
C ....CHECK IF DIMENSIONS ARE EQUAL AND  CHECK IF TIME SCALES ARE
C ....COMPATIBLE FOR THE TWO TIME SERIES.  BOTH MUST BE EQUAL
C ....OR BE MEAN Q(TIME SCALE=MEAN) AND INST Q.
C
      IF (ITSA.EQ.IACC .AND. ITSB.EQ.INST) GO TO 255
      IF (ISUNA.EQ.ISUNB) GO TO 250
      WRITE (IPR,200) ISUNA,ISUNB
200   FORMAT(1H0,10X,14H**ERROR UNITS-,A4,5H AND ,A4,
     $15H- ARE DIFFERENT)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
250   IF (ITSA.EQ.ITSB) GO TO 500
C
C ....TIME SCALES NOT COMPATIBLE IF THIS POINT REACHED
C
      WRITE (IPR,300) ITSA,ITSB
300   FORMAT(1H0,10X,24H**ERROR** TIME SCALES - ,A4,5H AND ,A4,
     $21H - ARE NOT COMPATIBLE)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
C
C ....TIME SCALES ARE ACCM AND INST.
C     NOW CHECK THAT ITA IS 24 HR., INPUT UNITS ARE CMSD, AND
C     TIME INTERVAL IS DECREASING
C
255   IF (ITA.EQ.24) GO TO 265
      WRITE (IPR,260) ITA
260   FORMAT(1H0,10X,47H**ERROR** INPUT TIME INTERVAL SHOULD BE 24 NOT ,
     *I3,30H FOR THE CASE OF MEAN TO INST.)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
C
265   IF(ISUNA.EQ.IUNIT) GO TO 270
      WRITE(IPR,267) ISUNA
267   FORMAT(1H0,10X,36H**ERROR** MEAN TO INST CONVERSION IS,
     * 57H INTENDED FOR DISCHARGE, UNITS=CMSD. THE INPUT UNITS ARE ,A4)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
C
270   IF (ITA.LE.ITB) GO TO 450
      ICASE=7
C
C ....CHECK THAT INTERVALS ARE MULTIPLES OF EACH OTHER
      IF (MOD(ITA,ITB).EQ.0) GO TO 610
      WRITE (IPR,580)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
C
C ....ERROR- WE HAVE MEAN Q AND INST Q BUT TIME IS NOT DECREASING
C
450   WRITE (IPR,470)
470   FORMAT(1H0,10X,71H**ERROR** OPERATION IS ONLY FOR DECREASING TIME
     $INTERVAL WHEN DATA TYPE / 1H0,10X,23HCODES ARE MEAN TO INST.)
C
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
C
C ....CHECK WHICH TIME SCALES ARE INVOLVED AND IF TIME INTERVAL IS
C ....INCREASING OR DECREASING AND IF INTERVALS ARE MULTIPLES.
C ....FIRST CHECK THAT TIME INTERVALS ARE NOT EQUAL
C
500   IF (ITA.NE.ITB) GO TO 600
cc      WRITE (IPR,550) IDTA,IDTB
cc550   FORMAT(1H0,10X,'**ERROR** SAME DATATYPE MUST BE USED TO',
cc     $' GENERATE MISSING DATA VIA LINEAR INTERPOLATION:',
cc     $ 1X,A4,' VS',1X,A4)
cc      CALL ERROR
cc      IERR=.TRUE.
cc      GO TO 1000
C
C
C     SET WHICHEVER CASE WE HAVE.
C ....CHECK TIME SCALE AND FOR INCREASING OR DECREASING TIME INTERVAL
C
600   ITIME=0
      IF (ITA.GT.ITB) ITIME=3
      IF (ITSA.EQ.MEAN) IDTYP=1
      IF (ITSA.EQ.INST) IDTYP=2
      IF (ITSA.EQ.IACC) IDTYP=3
C
      ICASE=ITIME+IDTYP
C
C CHECK TO SEE IF NTRP OPTION IS ON FOR CASE 5; IF SO MAKE CASE
C = -5. IF NTRP IS ON MAKE SURE OUTPUT TS CAN CONTAIN MISSING(MSB=1),
C OTHERWISE DEFAULT TO CASE 5 WITHOUT NTRP AND PRINT WARNING.
C
      IF (ICASE.NE.5 .OR. NOPT.NE.NTRP) GO TO 555
      ICASE=-ICASE
      IF (MSGB.EQ.1) GO TO 555
      WRITE(IPR,554)
      ICASE=IABS(ICASE)
      CALL WARN
554   FORMAT(1H0,10X,43H**WARNING** THE NTRRP OPTION IS NOT ALLOWED,
     $ 59H SINCE THE OUPUT TIME SERIES CANNOT CONTAIN MISSING VALUES.
     $ / 11X,21HOPTION IS TURNED OFF.)
C
C ....CHECK THAT INTERVALS ARE MULTIPLES OF EACH OTHER
C ....CHECK BOTH TIME INCREASING AND DECREASING
555   IF (ITA.LT.ITB) GO TO 560
      IF (MOD(ITA,ITB).EQ.0) GO TO 610
C ....ERROR- TIME INTERVALS ARE NOT MULTIPLES
      WRITE (IPR,580)
      CALL ERROR
      IERR=.TRUE.
      GO TO 1000
560   IF (MOD(ITB,ITA).EQ.0) GO TO 610
C ....ERROR- TIME INTERVALS ARE NOT MULTIPLES
      WRITE (IPR,580)
      CALL ERROR
      IERR=.TRUE.
580   FORMAT(1H0,10X,57H**ERROR** TIME INTERVALS ARE NOT MULTIPLES OF EA
     $CH OTHER.)
      GO TO 1000
C
C ....CHECK IF CARRYOVER NEEDED. FOR NEGATIVE ICASE, NO CO NEEDED.
C
610   GO TO (615,650,615,650,615,650,615),ICASE
      GO TO 650
C
C
C ....CARRYOVER IS NEEDED
C     2 CO VALUES NEEDED FOR CASE 7.
C
615   NEEDC=1
      IF (ICASE.EQ.7) NEEDC=2
      CALL CHECKC(NEEDC,LEFTC,IEROR)
      IF (IEROR.EQ.1) IERR=.TRUE.
C ....CHECK IF INITIAL CARRYOVER IS READ IN OR IS DEFAULTED
       IF (IRDCO.EQ.IYES) GO TO 620
      IRDCO=0
      GO TO 1000
620   IRDCO=1
      GO TO 1000
C
C ....CARRYOVER NOT NEEDED
C
650   NEEDC=0
      IRDCO=0
C
C ....CHECK FOR ANY ERRORS UP TO THIS POINT. IF SO, RETURN.
C
1000  IF (.NOT.IERR) GO TO 1200
        WRITE (IPR,1100)
1100  FORMAT(1H0,10X,45HTHIS OPERATION WILL BE IGNORED BECAUSE OF THE,
     $       1X,18HPRECEEDING ERRORS.)
        GO TO 999
C
C ....LOAD PO AND CO ARRAYS. FOR PO(12), INSTEAD OF JUST ADDING 0.01
C     MULTIPLY BY ICASE CAUSE ICASE COULD BE NEGATIVE.
C
1200  PO(1)=IVER+0.01
      PO(5)=ITA+0.01
      PO(9)=ITB+0.01
      PO(10)=NEEDC+0.01
      PO(11)=IRDCO+0.01
      PO(12)=ICASE+0.0001*ICASE
C
C ....LOAD CHARACTER VALUES THRU SUBROUTINE (CTRN...CHARACTER TRANSFER)
C ....SO THAT INTEGER/REAL CONVERSIONS ARE NOT INVOLVED
C
      CALL CTRN20(IDA,IDTA,IDB,IDTB,ITSA,ITSB,PO(2))
C
C ....LOAD CARRYOVER IF NECESSARY
C
      IF (NEEDC.EQ.0) GO TO 1300
      CO(1)=PREVQ
      IF (ICASE.EQ.7) CO(2)=PREVAL
C
C ....SET REMAINING VARIABLE VALUES
C
1300  IUSEP=NEEDP
      IUSEC=NEEDC
C
C     ALL ENTRIES ARE NOW IN PO AND CO ARRAYS
C .....................................................................
C     TIME FOR DEBUG IF NECESSARY
C
      IF (IBUG.EQ.0) GO TO 999
      WRITE (IODBUG,1400) (PO(I),I=1,NEEDP),ISUNA,ISUNB
1400  FORMAT(/ 1X,26HCHANGE TIME INTERVAL DEBUG / 1X,10HPO ARRAY= ,
     $F4.0,1X,2A4,1X,A4,F4.0,1X,2A4,1X,A4,4F4.0,A4,1X,A4
     */ 1X,10HUNITS ARE ,A4,5H AND ,A4)
C
      IF (NEEDC.GE.1) GO TO 1700
      WRITE (IODBUG,1500)
1500  FORMAT(/ 1X,20HCARRYOVER NOT NEEDED)
      GO TO 999
C
1700  WRITE (IODBUG,1800) (CO(I),I=1,NEEDC)
1800  FORMAT(/ 1X,10HCO ARRAY= ,2F10.0)
C
C
C .....................................................................
C     CONTENTS OF PO ARRAY--CHANGE TIME INTERVAL OPERATION
C
C     POSITION          CONTENTS
C         1      VERSION NUMBER FOR OPERATION
C       2-3      IDENTIFIER FOR FIRST TIME SERIES (A)
C         4      DATA TYPE FOR TIME SERIES A
C         5      TIME INTERVAL FOR TIME SERIES A
C       6-7      IDENTIFIER FOR SECOND TIME SERIES (B)
C         8      DATA TYPE FOR TIME SERIES B
C         9      TIME INTERVAL FOR TIME SERIES B
C        10      CARRYOVER NEEDED   0 = NO CARRYOVER
C                              1 0R 2 = CARRYOVER NEEDED
C        11      SOURCE OF INITIAL CARRYOVER
C                                   0 = DEFAULT VALUE USED
C                                   1 = VALUE READ IN
C        12      CASE INDICATOR
C                  1 = MEAN TIME SCALE, TIME INTERVAL INCREASING
C                  2 = INST TIME SCALE, TIME INTERVAL INCREASING
C                  3 = ACCM TIME SCALE, TIME INTERVAL INCREASING
C                  4 = MEAN TIME SCALE, TIME INTERVAL DECREASING
C                  5 = INST TIME SCALE, TIME INTERVAL DECREASING
C                 -5 = SAME AS 5 EXCEPT NO-INTERPOLATION OPTION ON
C                  6 = ACCM TIME SCALE, TIME INTERVAL DECREASING
C                  7 = MEAN Q - INST Q, TIME INTERVAL DECREASING
C                 TIME INCREASE IS FOR ITA LT ITB
C                 TIME DECREASE IS FOR ITA GT ITB
C
C        13      TIME SCALE FOR TIME SERIES A
C        14      TIME SCALE FOR TIME SERIES B
C
999   RETURN
      END