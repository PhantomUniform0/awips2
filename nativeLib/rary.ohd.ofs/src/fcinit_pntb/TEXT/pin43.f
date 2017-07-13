C MODULE PIN43
C-----------------------------------------------------------------------
C
      SUBROUTINE PIN43 (PO,LEFTP,IUSEP,CO,LEFTC,IUSEC)
C
C  THIS ROUTINE READS AND CHECKS ALL CARD INPUT FOR SEGMENT
C  DEFINITION FOR THE API-HFD OPERATION.  IT THEN FILLS
C  THE PO AND CO ARRAYS.
C
C  INITIALLY WRITTEN BY - KEN MACK - NERFC - 9/95
C
C  OUT: PO     .... PARAMETER ARRAY
C  OUT: LEFTP  .... NUMBER OF WORDS UNUSED IN THE PO ARRAY
C  OUT: IUSEP  .... NUMBER OF WORDS USED IN THE PO ARRAY
C  OUT: CO     .... CARRYOVER ARRAY
C  OUT: LEFTC  .... NUMBER OF WORDS UNUSED IN THE CO ARRAY
C  OUT: IUSEC  .... NUMBER OF WORKDS USED IN THE CO ARRAY
C
C#######################################################################
C
C  CONTENTS OF THE PO ARRAY:
C
C     WORD    NAME       DESCRIPTION                            UNITS
C  ________   _______    _______________________________________________
C      1      VERS       VERSION NUMBER
C    2 - 3    RID        RUNOFF ZONE ID
C    4 - 8    RNAME      RUNOFF ZONE NAME
C      9      IRNUM      RUNOFF ZONE NUMBER
C     10      RLAT       LATITUDE OF RUNOFF ZONE CENTROID       DEG DEC
C     11      RLNG       LONGITUDE OF RUNOFF ZONE CENTROID      DEG DEC
C     12      RFCTR      RUNOFF ADJUSTMENT FACTOR
C     13      R24        24-HOUR API RECESSION FACTOR
C     14      PMAX       MAX LIMIT FOR NEW STORM RAIN/MELT      INCHES
C     15      ULIMW      UPPER ATI LIMIT (WINTER CURVE)         INCHES
C     16      BLIMW      BOTTOM ATI LIMIT (WINTER CURVE)        INCHES
C     17      ULIMS      UPPER ATI LIMIT (SUMMER CURVE)         INCHES
C     18      BLIMS      BOTTOM ATI LIMIT (SUMMER CURVE)        INCHES
C     19      TBAR       ACTUAL AVG ANNUAL BASIN TEMPERATURE    DEGF
C     20      TTBAR      CORRECTED ANNUAL AVERAGE BASIN TEMPERATURE
C   21 - 22   EMPTY
C     23      NREL       GEOGRAPHICAL RELATIONSHIP NUMBER
C     24      IDELTA     COMPUTATIONAL TIME STEP                HOURS
C     25      NSW        NEW STORM WINDOW                       HOURS
C     26      NSPER      NUMBER OF PERIODS IN NSW
C     27      IUSEC      NUMBER OF WORDS NEEDED IN CO ARRAY
C     28      IOFAAA     I/O FLAG FOR API, ATI & FI TIME SERIES
C     29      ICOF       CARRYOVER INPUT FLAG
C   30 - 31   EMPTY
C     32      LMTS       LOCATION OF MANDATORY TIME SERIES INFORMATION 
C                        IN PO ARRAY
C     33      LWKT       LOCATION OF WEEKLY BASIN TEMPERATURES IN PO
C     34      LOTS       LOCATION OF OPTIONAL OUTPUT TIME SERIES
C                        INFORMATION IN PO
C   35 - 36   EMPTY
C
C LMTS - +1   TSIDRM     TIME SERIES ID FOR RAIN/MELT
C   LMTS+2    DTCRM      DATA TYPE CODE FOR RAIN/MELT
C   +3 - +4   TSIDRO     TIME SERIES ID FOR RUNOFF
C   LMTS+5    DTCRO      DATA TYPE CODE FOR RUNOFF
C 
C LWKT - +51  MATI       WEEKLY BASIN TEMPERATURES
C
C LOTS - +1   TSIDAPI    TIME SERIES ID FOR API
C   LOTS+2    DTCAPI     DATA TYPE CODE FOR API
C   +3 - +4   TSIDAT     TIME SERIES ID FOR ATI
C   LOTS+5    DTCAT      DATA TYPE CODE FOR ATI
C   +6 - +7   TSIDRI     TIME SERIES ID FOR RI
C   LOTS+8    DTCRI      DATA TYPE CODE FOR RI
C
C#######################################################################
C
C  CONTENTS OF THE CO ARRAY
C
C     WORD    NAME       DESCRIPTION                            UNITS
C  ________   _______    _______________________________________________
C      1      TAPI       12Z API VALUE                          INCHES
C      2      TATI       12Z ATI VALUE                          INCHES
C      3      TRI        12Z RI VALUE
C      4      SAPI       STORM API VALUE AT 12Z                 INCHES
C      5      SATI       STORM ATI VALUE AT 12Z                 INCHES
C      6      SRI        STORM RI VALUE AT 12Z
C      7      SRAIM      STORM RAIN/MELT                        INCHES
C      8      SRO        STORM RUNOFF                           INCHES
C      9      DRAIM      24-HOUR RAIN/MELT                      INCHES
C     10      DRO        24-HOUR RUNOFF                         INCHES
C   11 - 34   RNSP       RAIN/MELT IN EACH PERIOD OF THE        INCHES
C                        NEW STORM WINDOW
C
C#######################################################################
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fclfls'
C
      CHARACTER*8 SUBNAM
      CHARACTER*80 CARD
      DIMENSION PO(*),CO(*)
      DIMENSION RID(2),RNAME(5),TSIDRM(2),TSIDAT(2),TSIDRO(2)
      DIMENSION TSIDRI(2),TSIDAP(2),RNSP(24),MATI(52)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_pntb/RCS/pin43.f,v $
     . $',                                                             '
     .$Id: pin43.f,v 1.3 2002/02/11 19:02:25 dws Exp $
     . $' /
C    ===================================================================
C
      DATA DIML/4HL   /,DLES/4HDLES/
      DATA DIMT/4HTEMP/
C
C
C  CALL DEBUG CHECK ROUTINE
      SUBNAM='PIN43'
      NOP=43
      CALL FPRBUG(SUBNAM,1,NOP,IFDEB)
C
C  SET INITIAL VARIABLES     
      VERS  = 1.0
      IUSEP = 103
      ICHKDM = 1

      IF(IFDEB)110,110,4100

C  READ 8 LETTER RUNOFF ZONE ID, 20 CHARACTER RUNOFF ZONE NAME,
C  RUNOFF ZONE NUMBER, AND LATITUDE AND LONGITUDE OF RUNOFF ZONE
C  CENTROID.

110   READ (IN,7110) RID,RNAME,IRNUM,RLAT,RLNG
7110  FORMAT(2A4,6X,5A4,5X,I4,6X,F5.2,5X,F5.2)

      IF(IFDEB)115,115,4110

C  READ BASIN RUNOFF FACTOR, 24 HOUR API RECESSION COEFFICIENT,
C  NEW STORM RAIN/MELT LIMIT AND UPPER AND BOTTOM LIMITS
C  FOR ATI VALUES (WINTER AND SUMMER).

 115  READ (IN,7115) RFCTR,R24,PMAX,ULIMW,BLIMW,ULIMS,BLIMS,TBAR
7115  FORMAT(3F6.2,5F6.1)

      TTBAR = TBAR

      IF(IFDEB)120,120,4115

C  READ API/ATI/RI CURVE NUMBER, COMPUTATIONAL TIME STEP INTERVAL,
C  NEW STORM WINDOW, I/O FLAG FOR API, ATI, AND RI TIME SERIES,
C  AND CARRYOVER INPUT FLAG.

 120  READ (IN,7120) NREL,IDELTA,NSW,IOFAAA,ICOF
7120  FORMAT(7I6)
      IF(IFDEB)130,130,4120

C  READ IN TIME SERIES INFORMATION

 130   READ (IN,7130) TSIDRM,DTCRM,TSIDRO,DTCRO
7130  FORMAT(2A4,3X,A4,4X,2A4,3X,A4,5X,2A4,3X,A4)

      IF(IFDEB)132,132,4130

C  CHECK TO SEE IF THESE TIME SERIES ARE DEFINED FOR THIS OPERATION

C  TIME SERIES FOR THE API-HFD OPERATION CONTAIN NO
C  MISSING VALUES AND HAVE ONLY 1 VALUE PER TIME INTERVAL.

132   MISS=0
      NOVAL=1
      CALL CHEKTS (TSIDRM,DTCRM,IDELTA,ICHKDM,DIML,MISS,NOVAL,IERR)
      CALL CHEKTS (TSIDRO,DTCRO,IDELTA,ICHKDM,DIML,MISS,NOVAL,IERR)

C  READ IN INFORMATION FOR API, ATI, AND RI TIME SERIES, IF REQUESTED.

      IF(IOFAAA) 140,140,135
135   READ (IN,7130) TSIDAP,DTCAP,TSIDAT,DTCAT,TSIDRI,DTCRI

      IF(IFDEB) 137,137,4135
137   CALL CHEKTS (TSIDAP,DTCAP,IDELTA,ICHKDM,DIML,MISS,NOVAL,IERR)
      CALL CHEKTS (TSIDAT,DTCAT,24,ICHKDM,DIMT,MISS,NOVAL,IERR)
      CALL CHEKTS (TSIDRI,DTCRI,IDELTA,ICHKDM,DLES,MISS,NOVAL,IERR)

C  CHECK VALIDITY OF PARAMETRIC DATA JUST READ IN

140   IF((IRNUM.LT.0).OR.(IRNUM.GT.1000))GO TO 5140
150   IF((RLAT.LT.40.50).OR.(RLAT.GT.47.20))GO TO 5150
160   IF((RLNG.LT.67.40).OR.(RLNG.GT.78.65))GO TO 5160
170   IF((RFCTR.LT.0.0).OR.(RFCTR.GT.5.00))GO TO 5170
180   IF((R24.LT.0.75).OR.(R24.GE.1.00))GO TO 5180
190   IF((PMAX.LT.0.0).OR.(PMAX.GT.1.00))GO TO 5190
200   IF((ULIMW.GT.60.00).OR.(ULIMW.LT.33.00))GO TO 5200
202   IF((BLIMW.GT.60.00).OR.(BLIMW.LT.33.00))GO TO 5202
210   IF((ULIMS.GT.60.00).OR.(ULIMS.LT.33.00))GO TO 5210
212   IF((BLIMS.GT.60.00).OR.(BLIMS.LT.33.00))GO TO 5212
215   IF(TTBAR.LT.40)GO TO 5215
216   IF(TTBAR.GT.49)GO TO 5216
222   IF((NREL.LT.1).OR.(NREL.GT.3))GO TO 5222
230   IF((IDELTA.LT.1).OR.(IDELTA.GT.24))GO TO 5230
240   IF((NSW.LT.1).OR.(NSW.GT.24))GO TO 5240

C  CONSTRUCT ALL ADDITIONAL INFO NEEDED FOR THE API - HFD OPERATION
C  FROM THIS PARAMETRIC DATA.

C  FIRST, CHECK TO MAKE SURE THE NEW STORM WINDOW IS A POSITIVE,
C  NON-ZERO INTEGER MULTIPLE OF IDELTA.  IF NOT, PRINT A WARNING
C  MESSAGE.

300   RX1=FLOAT(NSW)/FLOAT(IDELTA)
      NSPER=NSW/IDELTA
      RX1=RX1*IDELTA
      RX2=NSPER*IDELTA
      IF(RX1-RX2)5310,310,5310

C  CHECK TO MAKE SURE NSPER IS GREATER THAN ZERO AND LESS THAN OR
C  EQUAL TO 24.

310   IF(NSPER)5320,5320,320
320   IF(24-NSPER)5330,330,330
330   IUSEC=NSPER+10

C  CHECK TO SEE IF CARRYOVER VALUES ARE BEING INPUT
      IF(ICOF)380,380,370

C  READ CARRYOVER VALUES
370   READ (IN,'(A)') CARD
      READ (CARD,7150,ERR=371) TAPI,TATI,TRI,SAPI,SATI,SRI,SRAIM,SRO,
     *   DRAIM,DRO
7150  FORMAT(F6.2,F6.1,2F6.2,F6.1,5F6.2)
      GO TO 372
371   CALL FRDERR (IPR,' ',CARD)
372   READ (IN,'(A)') CARD
      READ (CARD,7160,ERR=373) (RNSP(I),I=1,NSPER)
7160  FORMAT( 12F5.2 )
      GO TO 374
373   CALL FRDERR (IPR,' ',CARD)
374   GOTO 410
C
C  DEFAULT CARRYOVER VALUES
380   TAPI  = 1.93
      TATI  = 54.0
      TRI   = 34.2
      SAPI  = 1.93
      SATI  = 54.0
      SRI   = 34.2
      SRAIM = 0.0
      SRO   = 0.0
      DRAIM = 0.0
      DRO   = 0.0
      DO 390 I=1,NSPER
390   RNSP(I)=0.0

C  READ WEEKLY BASIN TEMPERATURES 
410   DO 413 I=1,4
         NPER=13
         J1=(I-1)*NPER+1
         J2=I*NPER
         READ (IN,'(A)') CARD
         READ (CARD,7170,ERR=411) (MATI(J),J=J1,J2)
7170  FORMAT( 13(1X,I3))
         GO TO 413
411      CALL FRDERR (IPR,' ',CARD)
413      CONTINUE
C
      IF(IFDEB)610,610,4380

C  CHECK VALIDITY OF CARRYOVER DATA

610   IF((TAPI.LT.0.10).OR.(TAPI.GT.5.00))GO TO 5610
620   IF((TATI.LT.33.0).OR.(TATI.GT.60.0))GO TO 5620
630   IF((TRI.LT.10.0).OR.(TRI.GT.80.0))GO TO 5630
640   IF((SAPI.LT.0.10).OR.(SAPI.GT.5.00))GO TO 5640
650   IF((SATI.LT.33.0).OR.(SATI.GT.60.0))GO TO 5650
660   IF((SRI.LT.10.0).OR.(SRI.GT.80.0))GO TO 5660
665   IF((SRAIM.LT.0.0).OR.(SRAIM.GT.30.0))GO TO 5665
670   IF((SRO.LT.0.0).OR.(SRO.GT.30.0))GO TO 5670
690   RNS=0.0
      DO 695 I=1,NSPER
695   RNS=RNSP(I)+RNS
      IF((RNS.LT.0.0).OR.(RNS.GT.30.0))GO TO 5685

C  CHECK P ARRAY TO MAKE SURE SPACE IS AVAILABLE TO STORE PARAMETRIC
C  DATA

710   CALL CHECKP(IUSEP,LEFTP,IERR)
      IF(IERR)730,730,720
720   CALL ERROR
      IUSEP=0
      GO TO 755

C  NOW STORE PARAMETRIC DATA IN PO ARRAY.

730   PO(1)=VERS
      DO 740 I=1,2
740   PO(I+1)=RID(I)
      DO 750 I=1,5
750   PO(I+3)=RNAME(I)
      PO(9)=IRNUM+0.01
      PO(10)=RLAT
      PO(11)=RLNG
      PO(12)=RFCTR
      PO(13)=R24
      PO(14)=PMAX
      PO(15)=ULIMW
      PO(16)=BLIMW
      PO(17)=ULIMS
      PO(18)=BLIMS
      PO(19)=TBAR
      PO(20)=TTBAR
      PO(21)=0.01
      PO(22)=0.01
      PO(23)=NREL+0.01
      PO(24)=IDELTA+0.01
      PO(25)=NSW
      PO(26)=NSPER
      PO(27)=IUSEC
      PO(28)=IOFAAA
      PO(29)=ICOF
      PO(30)=0.01
      PO(31)=0.01
c if you change LMTS then you must also change
c some code in mldrro
      LMTS = 37
      PO(32) = LMTS
      LWKT = 43
      PO(33) = LWKT
      LOTS = 95
      PO(34) = LOTS
      PO(35) = 0.01
      PO(36) = 0.01
C      
      PO(LMTS)   = TSIDRM(1)
      PO(LMTS+1) = TSIDRM(2)
      PO(LMTS+2) = DTCRM
      PO(LMTS+3) = TSIDRO(1)
      PO(LMTS+4) = TSIDRO(2)
      PO(LMTS+5) = DTCRO
C
      DO 1150 I=1,52
1150  PO(LWKT+I-1) = MATI(I)
C
      IF(IOFAAA.LT.1) GOTO 755
      PO(LOTS)   = TSIDAP(1)
      PO(LOTS+1) = TSIDAP(2)
      PO(LOTS+2) = DTCAP
      PO(LOTS+3) = TSIDAT(1)
      PO(LOTS+4) = TSIDAT(2)
      PO(LOTS+5) = DTCAT
      PO(LOTS+6) = TSIDRI(1)
      PO(LOTS+7) = TSIDRI(2)
      PO(LOTS+8) = DTCRI
C
C  CHECK C ARRAY TO MAKE SURE SPACE IS AVAILABLE TO STORE
C  CARRYOVER DATA
C
755   CALL CHECKC(IUSEC,LEFTC,IERR)
      IF(IERR)770,770,760
760   CALL ERROR
      IUSEC=0
      GO TO 10000
770   CO(1)=TAPI
      CO(2)=TATI
      CO(3)=TRI
      CO(4)=SAPI
      CO(5)=SATI
      CO(6)=SRI
      CO(7)=SRAIM
      CO(8)=SRO
      CO(9)=DRAIM
      CO(10)=DRO
      DO 780 I=1,NSPER
780   CO(I+10)=RNSP(I)
      GO TO 10000

C#######################################################################
C
C  DEBUG WRITE STATEMENTS
C
C#######################################################################

4100  WRITE(IODBUG,8100)SUBNAM,VERS
      GO TO 110
4110  WRITE(IODBUG,8110)RID,RNAME,IRNUM,RLAT,RLNG
      GO TO 115
4115  WRITE(IODBUG,8115)RFCTR,R24,PMAX,ULIMW,BLIMW,ULIMS,BLIMS,TBAR
      GO TO 120
4120  WRITE(IODBUG,8120) NREL,IDELTA,NSW,IOFAAA,ICOF
      GO TO 130
4130  WRITE(IODBUG,8130)TSIDRM,DTCRM,TSIDRO,DTCRO
      GO TO 132
4135  WRITE(IODBUG,8135)TSIDAP,DTCAP,TSIDAT,DTCAT,TSIDRI,DTCRI
      GO TO 137
4380  WRITE(IODBUG,8380)TAPI,TATI,TRI,SAPI,SATI,SRI,SRAIM,SRO,DRAIM,DRO
      WRITE(IODBUG,8381)(RNSP(I),I=1,NSPER)
      WRITE(IODBUG,8382)(MATI(I),I=1,52)
      GO TO 610

C#######################################################################
C
C  ERROR AND WARNING WRITE STATEMENTS
C
C#######################################################################

5140  WRITE(IPR,9140)IRNUM
      CALL WARN
      GO TO 150
5150  WRITE(IPR,9150)RLAT
      CALL WARN
      GO TO 160
5160  WRITE(IPR,9160)RLNG
      CALL WARN
      GO TO 170
5170  WRITE(IPR,9170)RFCTR
      CALL ERROR
      GO TO 180
5180  WRITE(IPR,9180)R24
      CALL ERROR
      GO TO 190
5190  WRITE(IPR,9190)PMAX
      CALL ERROR
      GO TO 200
5200  WRITE(IPR,9200)ULIMW
      CALL ERROR
      GO TO 202
5202  WRITE(IPR,9202)BLIMW
      CALL ERROR
      GO TO 210
5210  WRITE(IPR,9210)ULIMS
      CALL ERROR
      GO TO 212
5212  WRITE(IPR,9212)BLIMS
      CALL ERROR
      GO TO 215
5215  WRITE(IPR,9215)TTBAR
      CALL WARN 
      IF(TTBAR.LT.40)TTBAR=40
      GO TO 216
5216  WRITE(IPR,9216)TTBAR
      CALL WARN 
      IF(TTBAR.GT.49)TTBAR=49
      GO TO 222
5222  WRITE(IPR,9220)NREL
      CALL ERROR
      GO TO 230
5230  WRITE(IPR,9230)IDELTA
      CALL ERROR
      GO TO 240
5240  WRITE(IPR,9240)NSW
      CALL ERROR
      GO TO 300
5310  WRITE(IPR,9310)NSW,IDELTA
      CALL ERROR
      GO TO 310
5320  WRITE(IPR,9320)NSPER
      CALL ERROR
      GO TO 330
5330  WRITE(IPR,9330)NSPER
      CALL ERROR
      GO TO 330
5610  WRITE(IPR,9610)TAPI
      CALL ERROR
      GO TO 620
5620  WRITE(IPR,9620)TATI
      CALL ERROR
      GO TO 630
5630  WRITE(IPR,9630)TRI
      CALL ERROR
      GO TO 640
5640  WRITE(IPR,9640)SAPI
      CALL ERROR
      GO TO 650
5650  WRITE(IPR,9650)SATI
      CALL ERROR
      GO TO 660
5660  WRITE(IPR,9660)SRI
      CALL ERROR
      GO TO 665
5665  WRITE(IPR,9665)SRAIM
      CALL ERROR
      GO TO 670
5670  WRITE(IPR,9670)SRO
      CALL ERROR
      GO TO 690
5685  WRITE(IPR,9685)RNS
      CALL ERROR
      GO TO 710
 
C#######################################################################
C
C  DEBUG FORMAT STATEMENTS
C
C#######################################################################

8100  FORMAT(/5X,2A4,' DEBUG OUTPUT.',5X,'VERSION: ',F4.2)
8110  FORMAT(/30X,'RID   = ',2A4,/30X,'RNAME = ',5A4,
     1      /30X,'IRNUM = ',I4,/30X,'RLAT  = ',F5.2,
     2      /30X,'RLNG  = ',F5.2)
8115  FORMAT(/30X,'RFCTR = ',F5.2,/30X,'R24   = ',F5.2,
     1      /30X,'PMAX  = ',F5.2,/30X,'ULIMW = ',F5.1,
     2      /30X,'BLIMW = ',F5.1,/30X,'ULIMS = ',F5.1,
     3      /30X,'BLIMS = ',F5.1,/30X,'TBAR  = ',F5.1)
8120  FORMAT(
     1      /30X,'NREL  = ',I4,/30X,'IDELTA= ',I4,
     2      /30X,'NSW   = ',I4,/30X,'IOFAAA= ',I4,
     3      /30X,'ICOF  = ',I4)
8130  FORMAT(/20X,'TSIDRM= ',2A4,4X,'DTCRM= ',A4,
     1       /20X,'TSIDRO= ',2A4,4X,'DTCRO= ',A4)
8135  FORMAT(/20X,'TSIDAP= ',2A4,4X,'DTCAP= ',A4,
     1       /20X,'TSIDAT= ',2A4,4X,'DTCAT= ',A4,
     2       /20X,'TSIDRI= ',2A4,4X,'DTCRI= ',A4)
8380  FORMAT(/30X,'TAPI  = ',F5.2,/30X,'TATI  = ',F5.1,
     1      /30X,'TRI   = ',F5.2,/30X,'SAPI  = ',F5.2,
     2      /30X,'SATI  = ',F5.1,/30X,'SRI   = ',F5.2,
     3      /30X,'SRAIM = ',F5.2,/30X,'SRO   = ',F5.2,
     4      /30X,'DRAIM = ',F5.2,/30X,'DRO   = ',F5.2)
8381  FORMAT(/,2X,'RAIN/MELT FOR EACH PERIOD WITHIN THE NEW STORM ',
     1      'WINDOW (OLDEST PERIOD IS FIRST):',
     2      /5X,12(F5.2,3X),/5X,12(F5.2,3X))
8382  FORMAT(/,2X,'WEEKLY BASIN TEMPERATURES AS INPUT FROM THE ',
     1      'OPERATIONS TABLE (BEGIN WITH WEEK #1 FIRST):',
     2      4( /5X,13(1X,I3) ) )
8500  FORMAT(' ** EXIT ',2A4)
C
C#######################################################################
C
C  ERROR AND WARNING FORMAT STATEMENTS
C
C#######################################################################

9140  FORMAT('0**WARNING** ILLEGAL RUNOFF ZONE NUMBER :  ',I4,
     1      /20X,'LIMITS ARE 0 THROUGH 1000.',
     2      /20X,'NOTE:  RUNOFF ZONE NUMBER IS ENTERED FOR POSSIBLE ',
     3      'EXTERNAL USE,',/20X,'BUT IS NOT NEEDED BY THE API-HFD',
     4      'OPERATION ITSELF.')
9150  FORMAT('0**WARNING** ILLEGAL RUNOFF ZONE LATITUDE :  ',F6.2,
     1      /20X,'LIMITS ARE 40.51 THROUGH 47.17 DEG DECIMAL.',
     2      /20X,'NOTE:  RUNOFF ZONE LATITUDE IS ENTERED FOR POSSIBLE ',
     3      'EXTERNAL USE,',/20X,'BUT IS NOT NEEDED BY THE API-HFD' ,
     4      'OPERATION ITSELF.')
9160  FORMAT('0**WARNING** ILLEGAL RUNOFF ZONE LONGITUDE :  ',
     1      F6.2,/24X,'LIMITS ARE 67.37 THROUGH 78.65 DEG DECIMAL.',
     2      /20X,'NOTE:  RUNOFF ZONE LONGITUDE IS ENTERED FOR ',
     3      'POSSIBLE EXTERNAL USE,',/20X,'BUT IS NOT NEEDED BY THE ',
     4      'API-HFD OPERATION ITSELF.')
9170  FORMAT('0**ERROR** ILLEGAL ZONE RUNOFF FACTOR :  ',F6.2,
     1      /20X,'LIMITS ARE 0 THROUGH 5.00.',
     2      /20X,'A VALUE OF 0.0 MEANS NO ADJUSTMENTS TO API-HFD',
     3      'COMPUTED RUNOFF.')
9180  FORMAT('0**ERROR** ILLEGAL 24-HOUR API RECESSION ',
     1      'FACTOR :  ',F6.2,/20X,'LIMITS ARE 0.75 THROUGH 0.99.')
9190  FORMAT('0**ERROR** ILLEGAL NEW STORM RAIN/MELT LIMIT :  ',
     1      F6.2,/20X,'LIMITS ARE 0.0 THROUGH 1.00 INCHES.')
9200  FORMAT('0**ERROR** ILLEGAL UPPER LIMIT FOR ATI ',
     1      '(WINTER CURVE) :  ',F5.1,/20X,'LIMITS ARE 33.0 THROUGH ',
     2      '60.0 DEGREES.')
9202  FORMAT('0**ERROR** ILLEGAL LOWER LIMIT FOR ATI ',
     1      '(WINTER CURVE) :  ',F5.1,/20X,'LIMITS ARE 33.0 THROUGH ',
     2      '60.0 DEGREES.')
9210  FORMAT('0**ERROR** ILLEGAL UPPER LIMIT FOR ATI ',
     1      '(SUMMER CURVE) :  ',F5.1,/20X,'LIMITS ARE 33.0 THROUGH ',
     2      '60.0 DEGREES.')
9212  FORMAT('0**ERROR** ILLEGAL LOWER LIMIT FOR ATI ',
     1      '(SUMMER CURVE) :  ',F5.1,/20X,'LIMITS ARE 33.0 THROUGH ',
     2      '60.0 DEGREES.')
9215  FORMAT('0**WARNING** ILLEGAL LOWER LIMIT FOR TBAR ',F5.1,
     1      /,20X,'THE LOWER LIMIT IS 40.0...',/,20X,'TBAR WILL BE ',
     2      'RESET TO 40.0 DEGREES.')
9216  FORMAT('0**WARNING** ILLEGAL UPPER LIMIT FOR TBAR ',F5.1,
     1      /,20X,'THE UPPER LIMIT IS 49.0...',/,24X,'TBAR WILL BE ',
     2      'RESET TO 49.0 DEGREES.')
9220  FORMAT('0**ERROR** ILLEGAL GEOGRAPHICAL RELATIONSHIP ',
     1      'NUMBER :  ',I5,/20X,'LIMITS ARE 1 THROUGH 3.')
9230  FORMAT('0**ERROR** ILLEGAL TIME STEP INTERVAL :  ',I5,
     1      /20X,'LEGAL VALUES ARE 1,2,3,4,6,8,12 OR 24 HOURS.')
9240  FORMAT('0**ERROR** ILLEGAL NEW STORM WINDOW ',I5,
     1      /20X,'LEGAL VALUES ARE 1,2,3,4,6,8,12 OR 24 HOURS.')
9310  FORMAT('0**ERROR** THE NUMBER OF HOURS USED TO DEFINE ',
     1      'THE NEW STORM WINDOW ',/20X,'IS NOT A POSITIVE, NON-ZERO ',
     2      'INTEGER MULTIPLE OF THE COMPUTATIONAL TIME STEP INTERVAL.',
     3      /20X,'THIS MEANS THAT THE TIME INTERVAL OVER WHICH THE ',
     4      'API-HFD OPERATION CHECKS FOR A STORM BREAK ',/20X,
     5      'MAY NOT BE WHAT IS ACTUALLY DESIRED.  SUGGESTED REMEDY:  ',
     6      'ADJUST THE NEW STORM WINDOW AND/OR THE COMPUTATIONAL ',
     7      'TIME STEP INTERVAL.',/20X,'THE RESPECTIVE VALUES OF THESE',
     8      ' VARIABLES JUST READ IN ARE ',I5,' AND ',I5)
9320  FORMAT('0**ERROR** THE NUMBER OF PERIODS CALCULATED ',
     1      'FROM THE SPECIFIED NEW STORM WINDOW IS LESS THAN 1 :  ',
     2      F6.0,/20X,'LIMITS ARE 1 THROUGH 24.')
9330  FORMAT('0**ERROR** THE NUMBER OF PERIODS CALCULATED ',
     1      'FROM THE SPECIFIED NEW STORM WINDOW IS GREATER THAN 24 :',
     2      '  ',F6.0,/20X,'LIMITS ARE 1 THROUGH 24.')
9610  FORMAT('0**ERROR** ILLEGAL 12Z API VALUE :  ',F6.2,
     1      /20X,'LIMITS ARE 0.10 THROUGH 5.00 INCHES.')
9620  FORMAT('0**ERROR** ILLEGAL 12Z ATI VALUE :  ',F5.1,
     1      /20X,'LIMITS ARE 33.0 THROUGH 60.0 DEGREES.')
9630  FORMAT('0**ERROR** ILLEGAL 12Z RI VALUE :  ',F6.2,
     1      /20X,'LIMITS ARE 10.00 THROUGH 80.00 ')
9640  FORMAT('0**ERROR** ILLEGAL 12Z STORM API VALUE :  ',F6.2,
     1      /20X,'LIMITS ARE 0.10 THROUGH 5.00 INCHES.')
9650  FORMAT('0**ERROR** ILLEGAL 12Z STORM ATI VALUE :  ',F5.1,
     1      /20X,'LIMITS ARE 33.0 THROUGH 60.0 DEGREES.')
9660  FORMAT('0**ERROR** ILLEGAL 12Z STORM RI VALUE :  ',F6.2,
     1      /20X,'LIMITS ARE 10.00 THROUGH 80.00 ')
9665  FORMAT('0**ERROR** ILLEGAL STORM RAIN/MELT VALUE ',
     1      'AT 12Z :  ',F6.2
     2      /20X,'LIMITS ARE 0.00 THROUGH 30.00 INCHES.')
9670  FORMAT('0**ERROR** ILLEGAL STORM RUNOFF VALUE ',
     1      'AT 12Z :  ',F6.2
     2      /20X,'LIMITS ARE 0.00 THROUGH 30.00 INCHES.')
9685  FORMAT('0**ERROR** ILLEGAL RAIN/MELT TOTAL IN THE ',
     1      'NEW STORM WINDOW :  ',F6.2
     2      /20X,'LIMITS ARE 0.00 THROUGH 30.00 INCHES.')
C
10000 IF(ITRACE.GE.1) WRITE(IODBUG,8500) SUBNAM
C
      RETURN
C
      END