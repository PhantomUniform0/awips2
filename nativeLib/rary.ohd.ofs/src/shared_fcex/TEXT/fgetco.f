C MODULE FGETCO
C-----------------------------------------------------------------------
C
      SUBROUTINE FGETCO (IDSEG,ICDAYX,ICHRX,C,MC,MSGTYP,IER)
C
C  ROUTINE TO READ CARRYOVER FOR A SELECTED DATE FOR A SEGMENT.
C
C  ARGUMENT LIST:
C    IDSEG  - SEGMENT IDENTIFIER
C    ICDAYX - ABSOLUTE JULIAN DAY OF REQUESTED CARRYOVER
C    ICHRX  - HOUR OF CARRYOVER
C        C  - CARRYOVER ARRAY - FILLED IN THIS ROUTINE
C       MC  - LENGTH OF CARRYOVER ARRAY
C    MSGTYP - MESSAGE TYPE ('ERROR' OR 'WARNING')
C      IER  - ERROR RETURN CODE
C              0=NO ERRORS
C              1=STARTING OR ENDING RUN DATES (IN /FCTIME/) CHANGED
C              2=COULD NOT READ CARRYOVER FOR THE REQUESTED DATE
C                OR ANY DATE FOLLOWING THE REQUESTED DATE
C              3=ERROR READING CARRYOVER
C
      CHARACTER*(*) MSGTYP
      CHARACTER*4 RELOP
      CHARACTER*8 OLDOPN,OLDSEG,SEGNAM
C
      DIMENSION IDSEG(2),C(MC)
      DIMENSION IDSEGZ(2)
      DIMENSION LDATE(20),LHOUR(20)
      DIMENSION IZZBUF(1)
      EQUIVALENCE (ZZZBUF(1),IZZBUF(1))
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/where'
      INCLUDE 'common/errdat'
      INCLUDE 'common/fccgd'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fccgd1'
      INCLUDE 'common/fciobf'
      INCLUDE 'common/fcsegc'
      INCLUDE 'common/fcsegn'
      INCLUDE 'common/fctime'
      INCLUDE 'common/fctim2'
      INCLUDE 'common/fcsgc1'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/shared_fcex/RCS/fgetco.f,v $
     . $',                                                             '
     .$Id: fgetco.f,v 1.8 2005/03/18 20:15:31 jgofus Exp $
     . $' /
C    ===================================================================
C
      DATA IBLANK/4h    /
C
C
      IF (ITRACE.GE.1) WRITE (IODBUG,*) 'ENTER FGETCO'
C
      IOPNUM=0
      CALL FSTWHR ('FGETCO  ',IOPNUM,OLDOPN,IOLDOP)
      CALL UMEMOV (ISEG,OLDSEG,2)
      CALL UMEMOV (IDSEG,ISEG,2)
C
      IBUG=0
      IF (IFBUG('COTR').EQ.1) IBUG=1
      IF (IFBUG('COBG').EQ.1) IBUG=2
      IF (IFBUG('BUFW').EQ.1) IBUG=3
C
      IER=0
C
      IF (IBUG.GT.0) WRITE (IODBUG,20) IDSEG,IDSEGN,IDC,ICDAYX,ICHRX,MC
20    FORMAT (' IN FGETCO - IDSEG=',2A4,' IDSEGN=',2A4,' IDC=',2A4,
     *   ' ICDAYX=',I5,' ICHRX=',I5,' MC=',I5)
C
C  CHECK IF HOUR IS IN RANGE 1 TO 24
      ICDAY=ICDAYX
      ICHR=ICHRX
      IF (ICHR.GT.0.AND.ICHR.LT.25) GO TO 30
C
C  SPECIAL CASE OCCURS FOR REORDER PROGRAM - A SEGMENT NOT BELONGING
C  TO ANY CARRYOVER GROUP (AND NEVER HAVING ITS CARRYOVER DATED) WILL
C  HAVE THE DEFAULT DATES OF ZERO FOR ITS CARRYOVER
      IF (ICDAY.EQ.0.AND.ICHR.EQ.0) GO TO 30
C
C  HOUR NOT IN 1 TO 24 RANGE
      ICDAY=ICDAYX-1
      ICHR=24
C
C  CHECK IF IDENTIFIER INPUT IS THE SAME AS THAT STORED IN COMMON FCSEGN
30    DO 40 I=1,2
         IF (IDSEG(I).NE.IDSEGN(I)) GO TO 50
40       CONTINUE
      GO TO 70
C
50    WRITE (IPR,60) IDSEG,IDSEGN
60    FORMAT ('0**ERROR** SEGMENT IDENTIFIER PASSED (',2A4,
     *   ') DOES NOT MATCH THE IDENTIFIER IN COMMON FCSEGN (',2A4,').')
      IER=2
      CALL ERROR
      GO TO 450
C
C  CHECK TO INSURE ALL REQUESTED CARRYOVER VALUES WILL FIT IN C ARRAY
70    IF (NC.LE.MC) GO TO 90
         WRITE (IPR,80) NC,IDSEG,MC
80    FORMAT ('0**ERROR** THE SPACE NEEDED FOR CARRYOVER IS ',I3,
     *   ' WORDS FOR SEGMENT ',2A4,'. ONLY ',I3,' ARE AVAILABLE.')
         IER=2
         CALL ERROR
         GO TO 450
C
C  CHECK IF SEGMENT IDENTIFIER MATCHES THAT HELD IN COMMON FCSEGC
90    DO 100 I=1,2
         IF (IDSEG(I).NE.IDC(I)) GO TO 110
100      CONTINUE
      GO TO 120
C
C  NO MATCH FOUND - READ DATES FROM COMMON FCCGD1 OR CARRYOVER FILE
110   NEROLD=NERRS
      CALL FCDATE (IDSEG,0)
      IF (NERRS.EQ.NEROLD) GO TO 120
         IER=2
         GO TO 450
C
C  CHECK FOR A MATCH BETWEEN THE DATES INPUT AND THE CARRYOVER DATES
C  DEFINED FOR THIS SEGMENT
120   DO 130 I=1,NSLOTS
         IF (ICDAY.NE.ICDAYC(I).OR.ICHR.NE.ICHRC(I)) GO TO 130
            NSL=I
            GO TO 230
130      CONTINUE
C
C  NO MATCH FOUND
      IER=1
      CALL MDYH2 (ICDAY,ICHR,MMO,MIDAY,MIYR,MIHR,NDUMZ,NDUMDS,INPTZC)
      WRITE (IPR,140) MMO,MIDAY,MIYR,MIHR,INPTZC
140   FORMAT ('0**WARNING** NO MATCH FOUND FOR THE REQUESTED ',
     *   'DATE (',I2.2,'/',I2.2,'/',I4,'-',I2.2,' ',A4,
     *   '). CARRYOVER EXISTS FOR THE FOLLOWING DATES:')
      DO 160 I=1,NSLOTS
         CALL MDYH2 (ICDAYC(I),ICHRC(I),MMO,MIDAY,MIYR,MIHR,NDUMZ,
     *      NDUMDS,INPTZC)
         WRITE (IPR,150) I,MMO,MIDAY,MIYR,MIHR,INPTZC
150   FORMAT (5X,I2,') ',I2.2,'/',I2.2,'/',I4,'-',I2.2,' ',A4)
160      CONTINUE
      CALL WARN
C
      WRITE (IPR,170)
170   FORMAT ('0**NOTE** ATTEMPT WILL BE MADE TO FIND THE CLOSEST ',
     *   'FOLLOWING DATE FROM ALL THE DEFINED CARRYOVER DATES.')
C
C  FIND ALL CARRYOVER DATES PAST THE REQUESTED DATE
      IF (IBUG.GE.2) WRITE (IODBUG,180)
180   FORMAT (' START CARRYOVER DATE NOT FOUND IN LIST - START SEARCH')
      LD=0
      DO 190 J=1,NSLOTS
         LDATE(J)=0
         LHOUR(J)=0
         NSL=J
         RELOP='GT'
         CALL FDATCK (ICDAYC(J),ICHRC(J),ICDAY,ICHR,RELOP,ISW)
         IOPNUM=0
         CALL UMEMOV ('FGETCO  ',OPNAME,2)
         IF (ISW.NE.1) GO TO 190
            LD=LD+1
            LDATE(LD)=ICDAYC(J)
            LHOUR(LD)=ICHRC(J)
            IF (LD.GT.0) GO TO 210
190      CONTINUE
C
      WRITE (IPR,200) MSGTYP(1:LENSTR(MSGTYP))
200   FORMAT ('0**',A,'** ALL CARRYOVER DATES ON CARRYOVER FILE ',
     *   'PRECEDE THE REQUESTED DATE.')
      IF (MSGTYP.EQ.'ERROR') CALL ERROR
      IF (MSGTYP.EQ.'WARNING') CALL WARN
      IER=2
      GO TO 450
C
C  SORT DATE AND TIME ARRAYS TO FIND CLOSEST TO THE REQUESTED DATE.
210   CALL FCOBBL (LDATE,LHOUR,LD)
      ICDAY=LDATE(1)
      ICHR=LHOUR(1)
C
C  FIND SLOT NUMBER OF CLOSEST SUCCEEDING DATE
      DO 220 K=1,NSLOTS
         NSL=K
         RELOP='EQ'
         CALL FDATCK (LDATE(1),LHOUR(1),ICDAYC(K),ICHRC(K),RELOP,ISW)
         IF (ISW.EQ.1) GO TO 230
220      CONTINUE
C
      ISLOT=NSL
C
C  CHECK IF SEGMENT DOES NOT BELONG TO A CARRYOVER GROUP
230   IF (ICGID(1).EQ.IBLANK.AND.ICGID(2).EQ.IBLANK) GO TO 250
C
cfan
C  HSD bug r22-36:
C      ESP cannot handle successive segments not having carryover.
C
C  CHECK IF THERE IS CARRYOVER
C  NCOPS = number of carryover operations
C
C      IF (NCOPS .LT. 1) GO TO 410      !cfan
C jgg tightened the check added above to fix bug r25-64  3/05
      IF (MAINUM .EQ. 2 .AND. NCOPS .LT. 1) GO TO 410
cfan
C
      IF (MOD(IPC(NSL),2).NE.0) GO TO 250
         CALL MDYH2 (ICDAYC(NSL),ICHRC(NSL),MM,MD,MY,MH,NDUMZ,NDUMDS,
     *      INPTZC)
         WRITE (IPR,240) NSL,MM,MD,MY,MH,INPTZC,CGIDC
240   FORMAT ('0**ERROR** SLOT NUMBER ',I2,
     *      ' HOLDING CARRYOVER FOR ',I2.2,'/',I2.2,'/',I4,'-',I2.2,A4,
     *      ' FOR CARRYOVER GROUP ',2A4 /
     *   ' HAS BEEN MARKED INCOMPLETE AND CAN NOT BE USED.'/
     *   ' THE SLOT CAN BE RECOVERED BY REDEFINING THE SEGMENT OR ',
     *      'SAVING CARRYOVER FOR THAT DATE AND TIME.')
         IER=2
         CALL ERROR
         GO TO 450
C
C  CHECK IF MARKED INCOMPLETE
250   IF (INCSEG(NSL).EQ.1) GO TO 270
         CALL MDYH2 (ICDAYC(NSL),ICHRC(NSL),MM,MD,MY,MH,NDUMZ,NDUMDS,
     *      INPTZC)
         WRITE (IPR,260) NSL,MM,MD,MY,MH,INPTZC,IDSEG
260   FORMAT ('0**ERROR** SLOT NUMBER ',I2,
     *      ' HOLDING CARRYOVER FOR ',I2.2,'/',I2.2,'/',I4,'-',I2.2,A4,
     *      ' FOR SEGMENT ',2A4 /
     *   ' THE SLOT CAN BE RECOVERED BY REDEFINING THE SEGMENT OR ',
     *      'SAVING CARRYOVER FOR THAT DATE AND TIME.')
         IER=2
         CALL ERROR
         GO TO 450
C
270   ISEREC=(NSL-1)*NRSLOT+((IWOCRY-1)/NWR)+1
      NBUF=MOD(IWOCRY,NWR)
      IF (NBUF.EQ.0) NBUF=NWR
C
      IF (IBUG.GT.0) WRITE (IODBUG,280) ISEREC,NBUF,NWR,NRSLOT,IWOCRY,
     *   NSL
280   FORMAT (' IN FGETCO - ISEREC=',I4,' NBUF=',I4,' NWR=',I4,
     *   ' NRSLOT=',I5,' IWOCRY=',I5,' NSL=',I4)
C
C  READ CARRYOVER VALUES FROM THE CARRYOVER FILE
      LOC=1
      CALL FCRDCF (ISEREC,1,MZZBUF,ZZZBUF,IERR)
      IF (IERR.GT.0) THEN
         WRITE (IPR,285) IDSEG
285   FORMAT ('0**ERROR** IN FCRDCF - READING CARRYOVER ',
     *   'FOR SEGMENT ',2A4,'.')
         CALL ERROR
         IER=3
         GO TO 450
         ENDIF
C
      IF (IBUG.GE.3) CALL FCDMP2 (ISEREC,MZZBUF)
      IOPNUM=0
      CALL UMEMOV ('FGETCO  ',OPNAME,2)
C
      LOC=1
      NCST=0
      NSTART=0
C
C  SET SEGMENT IDENTIFIER
300   IDSEGZ(1)=IZZBUF(NBUF)
      GO TO 410
310   IDSEGZ(2)=IZZBUF(NBUF)
C
C  CHECK SEGMENT IDENTIFIER
      CALL UMEMOV (IDSEGZ,SEGNAM,2)
      IF (IBUG.GT.0) WRITE (IODBUG,315) IDSEG,IDSEGZ
315   FORMAT (' IN FGETCO - IDSEG=',2A4,' IDSEGZ=',2A4)
      IF (SEGNAM.NE.'OBSOLETE') THEN
         IF (IDSEG(1).NE.IDSEGZ(1).OR.IDSEG(2).NE.IDSEGZ(2)) THEN
            WRITE (IPR,317) ISEREC,IDSEGZ,IDSEG
317   FORMAT ('0**ERROR** SEGMENT NAME FOUND AT RECORD ',I5,
     *   ' OF CARRYOVER FILE (',2A4,
     *   ') DOES NOT MATCH REQUESTED SEGMENT NAME (',2A4,').')
            IER=2
            CALL ERROR
            GO TO 450
            ENDIF
         ENDIF
      GO TO 410
C
320   ICD1=IZZBUF(NBUF)
      IF (ICD1.EQ.ICDAY) GO TO 410
      IRH=0
      CALL MDYH2 (ICDAY,IHR,MM1,MD1,MY1,MH1,NDUMZ,NDUMDS,
     *   INPTZC)
      CALL MDYH2 (ICD1,IRH,MM2,MD2,MY2,MH2,NDUMZ,NDUMDS,
     *   INPTZC)
      WRITE (IPR,330) MM1,MD1,MY1,MM2,MD2,MY2
330   FORMAT ('0**ERROR** DATE TO BE READ (',
     *   I2.2,'/',I2.2,'/',I4,
     *   ') DOES NOT MATCH THE DATE FOUND ON THE FILE (',
     *   I2.2,'/',I2.2,'/',I4,
     *   ').')
      IER=2
      CALL ERROR
      GO TO 450
C
340   ICHR1=IZZBUF(NBUF)
      IF (ICHR1.EQ.ICHR) GO TO 410
      WRITE (IPR,350) ICHR1,ICHR
350   FORMAT ('0**ERROR** INITIAL CARRYOVER HOUR (',I6,
     *   ') DOES NOT MATCH THE HOUR FOUND ON THE CARRYOVER FILE (',I6,
     *   ').')
      IER=2
      CALL ERROR
      GO TO 450
C
360   NCF=IZZBUF(NBUF)
      IF (NCF.EQ.NC) GO TO 410
      WRITE (IPR,370) NC,NCF
370   FORMAT ('0**ERROR** LENGTH OF CARRYOVER ARRAY ',
     *  'IN COMMON FCSEGN (',I4,') IS DIFFERENT THAN ',
     *  'THAT STORED ON CARRYOVER FILE (',I4,').')
      IER=2
      CALL ERROR
      GO TO 450
C
380   NSTART=NSTART+1
      IF (NSTART.GT.5) GO TO 400
      ICOWCT(NSTART)=IZZBUF(NBUF)
      GO TO 410
C
400   NCST=NCST+1
      IF (NCST.GT.NC) GO TO 450
      C(NCST)=ZZZBUF(NBUF)
      GO TO 410
C
410   CALL FCBFCK (NBUF,LOC,LOCSVE)
      IF (IBUG.GT.2) WRITE (IODBUG,420) NBUF,LOC,LOCSVE
420   FORMAT (' IN FGETCO - NBUF=',I4,' LOC=',I4,' LOCSVE=',I4)
C
      GO TO (440,430),LOCSVE
C
430   ISEREC=ISEREC+1
      CALL FCRDCF (ISEREC,1,MZZBUF,ZZZBUF,IERR)
      IF (IERR.GT.0) THEN
         WRITE (IPR,285) IDSEG
         CALL ERROR
         IER=3
         GO TO 450
         ENDIF
      IF (IBUG.GE.3) CALL FCDMP2 (ISEREC,MZZBUF)
      IOPNUM=0
      CALL UMEMOV ('FGETCO  ',OPNAME,2)
C
440   GO TO (300,310,320,340,360,380,380,380,380,380,400),LOC
C
450   CALL FSTWHR (OLDOPN,IOLDOP,OLDOPN,IOLDOP)
      CALL UMEMOV (OLDSEG,ISEG,2)
C
      IF (ITRACE.GE.1) WRITE (IODBUG,*) 'EXIT FGETCO'
C
      RETURN
C
      END