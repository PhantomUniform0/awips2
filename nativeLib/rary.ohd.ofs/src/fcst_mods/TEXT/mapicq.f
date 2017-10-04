C MODULE MAPICQ
C-----------------------------------------------------------------------
C
C
C     DESC - THIS SUBROUTINE PERFORMS THE APICQN MOD
C
      SUBROUTINE MAPICQ(MP,P,NCARDS,MODCRD,IIDATE,
     1  NXTOPN,NXTNAM,IHZERO)
C
      LOGICAL FIRST
      CHARACTER*8 NXTNAM,OPID,BLANK8,MODNAM
C
      INCLUDE 'ufreex'
      INCLUDE 'common/ionum'
      INCLUDE 'common/fctime'
      INCLUDE 'common/fctim2'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fpwarn'
      INCLUDE 'common/fmodft'
      COMMON/MOD129/NDT29,IDT29(5),VAL29(5)
C
      DIMENSION P(MP)
      DIMENSION OLDOPN(2),MODCRD(20,NCARDS)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_mods/RCS/mapicq.f,v $
     . $',                                                             '
     .$Id: mapicq.f,v 1.4 1998/07/02 20:36:11 page Exp $
     . $' /
C    ===================================================================
C
C
      DATA ISLASH/4H/   /,BLANK8/'        '/
      DATA MODNAM/'APICQN  '/
C
      CALL FSTWHR(8HMAPICQ  ,0,OLDOPN,IOLDOP)
C
C     SET DEBUG FLAG
C
      IBUG=IFBUG(4HMODS)+IFBUG(4HAPIC)
C
      IF(IBUG.GT.0)WRITE(IODBUG,10)NXTOPN,NXTNAM
10    FORMAT(11X,'*** SUBROUTINE MAPICQ ENTERED *** NEXT OPERATION ',
     1 'NUMBER =',I3,', OPERATION NAME = ',A8)
C
C  CHECK IF NEXT OPERATION IS AN API OPERATION
C   NUMBER 29 IS API-MKC
C   NUMBER 33 IS API-CIN
C   NUMBER 34 IS API-SLC
C   NUMBER 35 IS API-HAR
C   NUMBER 41 IS API-HAR2
C   NUMBER 43 IS API-HFD
C
      IF(NXTOPN.EQ.29.OR.NXTOPN.EQ.33.OR.
     1   NXTOPN.EQ.34.OR.NXTOPN.EQ.35.OR.
     2   NXTOPN.EQ.41.OR.NXTOPN.EQ.43) GOTO 20
      GO TO 370
C
20    IDATE=IIDATE
C     IF(MOD(IDATE,24).EQ.0)GO TO 222
      IF(MOD(IDATE,24).EQ.0)GO TO 40
C
C  SKIP MOD IF DATE ENTERED IS NOT AT THE END OF A HYDROLOGIC DAY
C
      IF(MODWRN.EQ.0)GO TO 370
      IXDA=IDATE/24+1
      IXHR=IDATE-(IXDA-1)*24
      CALL MDYH2(IXDA,IXHR,IM1,ID1,IY1,IH1,DUM1,DUM2,MODTZC)
C
      WRITE(IPR,30)IM1,ID1,IY1,IH1,MODTZC
30    FORMAT(1H0,10X,'**WARNING** THE DATE FOR CHANGES IN THE ',
     1 'APICQN MOD (',I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/11X,
     2 'IS NOT AT THE END OF A HYDROLOGIC DAY.'/11X,
     3 'CHANGES FOR THIS DATE WILL BE IGNORED.')
      CALL WARN
      GO TO 370
C
40    CONTINUE
      ICOMP=((LDACPD-1)*24)+LHRCPD
      IF (IDATE.LE.ICOMP) GOTO 50
         IF (MODWRN.EQ.0) GOTO 370
         ITYPE=2
         CALL MODS1(NCARDS,ICMND,MODNAM,MODCRD,ITYPE)
         GOTO 370
C
C     SEE IF DATE IS WITHIN RUN PERIOD
C
50    ISTHR=(IDA-1)*24+IHZERO
      IENHR=(LDA-1)*24+LHR
C
      IF(ISTHR.LE.IDATE.AND.IENHR.GE.IDATE)GO TO 80
C
C     DATE FOR CHANGES NOT IN ALLOWABLE WINDOW
C
      IF(MODWRN.EQ.0)GO TO 370
      CALL MDYH2(IDA,IHZERO,IM1,ID1,IY1,IH1,DUM1,DUM2,MODTZC)
      CALL MDYH2(LDA,LHR,IM2,ID2,IY2,IH2,DUM1,DUM2,MODTZC)
      IXDA=IDATE/24+1
      IXHR=IDATE-(IXDA-1)*24
      IF(IXHR.EQ.0)IXDA=IXDA-1
      IF(IXHR.EQ.0)IXHR=24
      CALL MDYH2(IXDA,IXHR,IM3,ID3,IY3,IH3,DUM1,DUM2,MODTZC)
C
      IF(ISTHR.NE.IDATE)
     .WRITE(IPR,60)IM3,ID3,IY3,IH3,MODTZC,IM1,ID1,IY1,IH1,MODTZC,
     1IM2,ID2,IY2,IH2,MODTZC
60    FORMAT(1H0,10X,'**WARNING** THE DATE FOR CHANGES IN THE ',
     1 'APICQN MOD (',I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/11X,
     2 'IS NOT IN THE CURRENT RUN PERIOD (',I2,1H/,I2,
     3 1H/,I4,1H-,I2,1X,A4,4H TO ,I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/
     4 11X,'THESE CHANGES WILL BE IGNORED.')
C     IF(ISTHR.EQ.IDATE)
C    .WRITE(IPR,652)IM3,ID3,IY3,IH3,MODTZC
C 652 FORMAT(1H0,10X,'**WARNING** THE DATE FOR CHANGES IN THE ',
C    1 'APICQN MOD (',I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/11X,
C    2 'IS AT THE START OF THE CURRENT RUN PERIOD.'/
C    3 11X,'THESE CHANGES WILL BE IGNORED.')
      WRITE(IPR,70)(MODCRD(I,NRDCRD),I=1,20)
70    FORMAT(15X,'THE MOD CARD IMAGE IS: ',20A4)
      CALL WARN
      GO TO 370
C
80    MXVALS=1
C
C     READ CARD - IF COMMAND LEAVE - IF COMMAND AND 1ST CARD ERROR
C
      FIRST=.TRUE.
      IF(NRDCRD.EQ.NCARDS)GO TO 100
C
90    IF(NRDCRD.EQ.NCARDS)GO TO 370
C
      OPID=BLANK8
C
      IF(MISCMD(NCARDS,MODCRD).EQ.0)GO TO 120
C
      IF(.NOT.FIRST)GO TO 370
C
C     HAVE FOUND COMMAND AS FIRST SUBSEQUENT CARD - ERROR
C
100   IF(MODWRN.EQ.1)WRITE(IPR,110)
110   FORMAT(1H0,10X,'**WARNING** NO SUBSEQUENT CARDS FOUND FOR THE ',
     1 'APICQN MOD.  PROCESSING CONTINUES.')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 370
C
120   FIRST=.FALSE.
C
C     CALL SUBROUTINE TO READ VALUE
C
      NFLD=1
      NRDCRD=NRDCRD+1
C
      CALL MRDVAL(NCARDS,MODCRD,NFLD,MXVALS,NVALS,VALUE,ISTAT)
C
      IF(IBUG.GT.0)WRITE(IODBUG,130)ISTAT,FIRST,NVALS,VALUE
130   FORMAT(11X,'**IN MAPICQ** AFTER CALL TO MRDVAL - ISTAT=',I3,
     1 ', FIRST=',L4,', NVALS=',I2,', VALUE=',G10.2)
C
C     ISTAT RETURNED FROM MRDVAL MEANS
C       =0, VALUE READ OK, NO ADDITIONAL FIELDS ON CARD
C       =2, VALUE READ OK, ADDITIONAL FIELDS ON CARD
C       =-1, NO VALUES ENTERED
C       ELSE, MORE THAN 1 VALUE ENTERED
C
      IF(ISTAT.EQ.0)GO TO 250
      IF(ISTAT.EQ.2)GO TO 170
      IF(ISTAT.EQ.-1)GO TO 150
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,140)(MODCRD(I,NRDCRD),I=1,20)
140   FORMAT(1H0,10X,'** WARNING ** IN APICQN MOD - MORE THAN 1 ',
     1 'VALUE ENTERED.'/11X,'CURRENT MOD CARD IMAGE IS'/11X,20A4)
      GO TO 360
C
150   IF(MODWRN.EQ.1)
     .WRITE(IPR,160)(MODCRD(I,NRDCRD),I=1,20)
160   FORMAT(1H0,10X,'**WARNING** ',
     1  'NO VALUES ENTERED ON A SUBSEQUENT CARD FOR APICQN MOD'/
     2  11X,'THE CURRENT MOD CARD IMAGE IS'/11X,20A4)
      GO TO 360
C
C     HAVE ADDITIONAL FIELDS - LOOK FOR A SLASH (/) AND
C     AN OPERATION NAME - REPROCESS CURRENT FIELD TO SEE IF A SLASH
C
170   ISTRT=-1
      NCHAR=1
      ICKDAT=0
C
      IF(IBUG.GT.0)WRITE(IODBUG,180)NFLD,NRDCRD
180   FORMAT(11X,'ABOUT TO CALL UFIEL2 - LOOKING FOR A SLASH',
     1 ', NFLD=',I3,', NRDCRD=',I3)
C
      CALL UFIEL2(NCARDS,MODCRD,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF(IBUG.GT.0)WRITE(IODBUG,190)NFLD,ISTRT,LEN,ITYPE,IFIELD,ISTAT
190   FORMAT(11X,'AFTER UFIEL2 - NFLD,ISTRT,LEN,ITYPE,IFIELD,ISTAT='/
     1 26X,I3,I6,I4,I6,3X,A4,I6)
C
      IF(IFIELD.EQ.ISLASH)GO TO 210
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,200)(MODCRD(I,NRDCRD),I=1,20)
200   FORMAT(1H0,10X,'** WARNING ** IN APICQN MOD - A SLASH ',
     1 'WAS NOT FOUND WHERE EXPECTED ON THE FOLLOWING CARD'/
     2 11X,20A4/11X,'NO CHANGES ENTERED ON THIS CARD WILL BE MADE')
      GO TO 360
C
C     NOW READ OPERATION NAME
C
210   ISTRT=-3
      NCHAR=2
      ICKDAT=0
C
      CALL UFIEL2(NCARDS,MODCRD,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,OPID,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF(ISTRT.NE.-2)GO TO 230
      IF(MODWRN.EQ.0)GO TO 90
      WRITE(IODBUG,220)(MODCRD(I,NRDCRD),I=1,20)
220   FORMAT(11X,'** WARNING ** NO OPERATION NAME ENTERED ',
     1 'AFTER A SLASH ON THE FOLLOWING MOD CARD'/11X,20A4/
     2 11X,'THIS CARD IS IGNORED.')
      GO TO 360
230   CONTINUE
C
C     CHECK THAT OPERATION NAME ENTERED MATCHES NXTNAM -
C     IF NOT, READ NEXT CARD
C
      IF(IBUG.GT.0)WRITE(IODBUG,240)OPID,NXTNAM
240   FORMAT(11X,'OPERATION NAME INPUT IS ',A8,', NEXT OPERATION ',
     1 'IN OPERATIONS TABLE IS ',A8,'.')
C
      IF(OPID.EQ.NXTNAM)GO TO 250
      GO TO 90
C
C     CONVERT TO INCHES IF NEEDED
C
250   IF(IUMAPI.EQ.0)GO TO 260
C
C     MUST CONVERT FROM MM TO INCHES
C
      CALL FCONVT(4HMM  ,4HL   ,ENGUN,AMM2IN,BMM2IN,IER)
C
      VALUE=VALUE*AMM2IN
C
C     STORE VALUE IN COMMON BLOCK /MOD129/
C
260   IF(NDT29.GT.0)GO TO 270
C
C     NO VALUES CURRENTLY IN COMMON BLOCK /MOD129/
C
      NDT29=1
      IDT29(1)=IDATE
      VAL29(1)=VALUE
      GO TO 330
C
C     VALUES CURRENTLY IN COMMON BLOCK /MOD129/
C     SEE IF DATE MATCHES EXACTLY ONE IN COMMON BLOCK
C
270   DO 280 I=1,NDT29
      IF(IDT29(I).NE.IDATE)GO TO 280
C
C     YES - MATCHES - REPLACE VALUE IN COMMON BLOCK
C
      VAL29(I)=VALUE
      GO TO 330
C
280   CONTINUE
C
C     NO MATCH
C     IF THERE IS ROOM - PUT THIS VALUE IN IN CHRONOLOGICAL ORDER
C
      IF(NDT29.LT.5)GO TO 300
C
C     NO ROOM
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,290)(MODCRD(I,NRDCRD),I=1,20)
290   FORMAT(1H0,10X,'** WARNING ** IN APICQN MOD - NO ROOM IN ',
     1 'COMMON BLOCK /MOD129/'/11X,'THE VALUE ON THE FOLLOWING MOD ',
     2 'CARD IS IGNORED'/11X,20A4)
      GO TO 360
C
C     THERE IS ROOM - INSERT CHRONOLOGICALLY
C
300   IEND29=NDT29
      DO 320 I=1,IEND29
      IF(IDT29(I).LT.IDATE)GO TO 320
C
      MOVE=NDT29-I+1
      DO 310 J=1,MOVE
      K=NDT29+2-J
      IDT29(K)=IDT29(K-1)
310   VAL29(K)=VAL29(K-1)
      IDT29(I)=IDATE
      VAL29(I)=VALUE
      NDT29=NDT29+1
      GO TO 330
C
320   CONTINUE
C
C     ADD AT END
C
      NDT29=NDT29+1
      IDT29(NDT29)=IDATE
      VAL29(NDT29)=VALUE
C
330   IF(IBUG.LT.1)GO TO 90
C
      WRITE(IODBUG,340)IDATE,VALUE,NDT29,NXTNAM
340   FORMAT(11X,'IN SUBROUTINE MAPICQ - APICQN MOD'/11X,
     1 'IDATE, VALUE, NDT29, NXTNAM = ',I11,1X,G9.2,1X,I3,1X,A8)
      IF(NDT29.GT.0)WRITE(IODBUG,350)(IDT29(I),VAL29(I),I=1,NDT29)
350   FORMAT(11X,'IDT29, VAL29 ='/(11X,2G9.2))
      GO TO 90
C
360   IF(MODWRN.EQ.1)CALL WARN
      GO TO 90
C
370   IF(IBUG.GT.0)WRITE(IODBUG,380)
380   FORMAT(11X,'**LEAVING SUBROUTINE MAPICQ**')
      CALL FSTWHR(OLDOPN,IOLDOP,OLDOPN,IOLDOP)
      RETURN
      END