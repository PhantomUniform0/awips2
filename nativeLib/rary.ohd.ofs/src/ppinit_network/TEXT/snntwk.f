C MODULE SNNTWK
C-----------------------------------------------------------------------
C
C  ROUTINE TO PERFORM NETWORK COMPUTATIONS.
C
      SUBROUTINE SNNTWK (LARRAY,ARRAY,NFLD,ISTAT)
C
      CHARACTER*4 OPTN4,UNITS,OPTION,VALUE
      CHARACTER*4 DISP,RDISP,WDISP
      CHARACTER*4 PSORT,SORTBY,XSORT
      CHARACTER*8 UPDATE
      CHARACTER*8 TYPERR
      CHARACTER*8 BLNK8/' '/
      PARAMETER (MOPTN=20)
      CHARACTER*8 OPTN(MOPTN)
     *         /'NEW     ','PCPN    ','TEMP    ','MAP     ',
     *          'MAT     ','BASN    ','MAPE    ','DLY     ',
     *          'RRS     ','ALL     ','SORT    ','BASNMDR ',
     *          'SETIND  ','UPDTEIND','GP24    ','OG24    ',
     *          'GP24OG24','TSHDR   ','NOPRINT ','        '/
      CHARACTER*20 CHAR/' '/,CHK/' '/
C
      DIMENSION ARRAY(LARRAY)
C
      INCLUDE 'uio'
      INCLUDE 'scommon/sudbgx'
      INCLUDE 'scommon/sutmrx'
      INCLUDE 'scommon/sntwfx'
      INCLUDE 'scommon/sntwkx'
      INCLUDE 'scommon/sugnlx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_network/RCS/snntwk.f,v $
     . $',                                                             '
     .$Id: snntwk.f,v 1.3 1998/04/07 17:58:37 page Exp $
     . $' /
C    ===================================================================
C
C
C
C  SET TRACE LEVEL
      CALL SBLTRC ('NTWK','NTWKMAIN','SNNTWK  ',LTRACE)
C
      IF (LTRACE.GT.0) THEN
         WRITE (IOSDBG,1330)
         CALL SULINE (IOSDBG,1)
         ENDIF
C
C  SET DEBUG LEVEL
      CALL SBLDBG ('NTWK','NTWKMAIN','SNNTWK  ',LDEBUG)
C
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1350) LARRAY,NFLD
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      ISTAT=0
C
      LCHAR=LEN(CHAR)/4
      LCHK=LEN(CHK)/4
      LCHK=LEN(CHK)/4
C
      ISTRT=1
      OPTN4=' '
      NUMERR=0
      NUMWRN=0
      IENDIN=0
      NUMOPT=0
      NOPFLD=0
      IALL=-1
      IPFALL=0
      IOPTN=0
      IOPEN=0
      IPASS=0
      IRNTWK=0
      ILNTWK=0
      ISORT=0
      IBMDR=0
      IGP24=0
      IOG24=0
      UPDATE='AFTER'
      IPNTWK=1
      DO 10 I=1,NNWFLG
         INWFLT(I)=-1
10       CONTINUE
      IRUGNL=-1    
      UNSD=-999.
C
C  SET OPTION TO FORCE UPDATING OF MAP AND MAT TIME SERIES HEADERS
      ITSHDR=1
C
C  PRINT CARD
      IF (NFLD.NE.-1) CALL SUPCRD
C
C  PRINT HEADER LINE
      IF (ISLEFT(10).GT.0) CALL SUPAGE
      WRITE (LP,1340)
      CALL SULINE (LP,2)
C
C  SET DEFAULT STATUS
      DISP='OLD'
C
C  CHECK IF AUTOMATIC NETWORK RUN
      IF (NFLD.EQ.-1) THEN
         IENDIN=1
         GO TO 360
         ENDIF
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  CHECK FIELDS FOR NETWORK OPTIONS
C
20    CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPE,NREP,INTEGR,REAL,
     *   LCHAR,CHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,IERR)
      IF (NFLD.EQ.-1) GO TO 330
      IF (LDEBUG.GT.0) THEN      
         CALL UPRFLD (NFLD,ISTRT,LENGTH,ITYPE,NREP,INTEGR,REAL,
     *      LCHAR,CHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,IERR)
         ENDIF
      IF (IERR.EQ.1) THEN
         IF (LDEBUG.GT.0) THEN
            WRITE (IOSDBG,1600) NFLD
            CALL SULINE (IOSDBG,1)
            ENDIF
         GO TO 20
         ENDIF
C
C  CHECK FOR COMMAND
      IF (LATSGN.EQ.1) GO TO 330
C
C  CHECK FOR ABORT COMMAND
      IF (CHAR.EQ.'@ABORT') GO TO 1320
C
      IF (NFLD.EQ.1) CALL SUPCRD
C
C  CHECK FOR PARENTHESIS IN FIELD
      IF (LLPAR.GT.0) CALL UFPACK (LCHK,CHK,ISTRT,1,LLPAR-1,IERR)
      IF (LLPAR.EQ.0) CALL UFPACK (LCHK,CHK,ISTRT,1,LENGTH,IERR)
C
C  CHECK FOR OPTION
      IF (MOPTN.EQ.0) THEN
         WRITE (LP,1380) NFLD,CHAR(1:LENSTR(CHAR))
         CALL SUERRS (LP,2,NUMERR)
         GO TO 20
         ENDIF
      DO 50 IOPTN=1,MOPTN
         NWORDS=2
         CALL SUCOMP (NWORDS,CHK,OPTN(IOPTN),IMATCH)
         IF (IMATCH.EQ.1) GO TO 60
50       CONTINUE
C
      IF (NOPFLD.EQ.1) GO TO 150
C
C  INVALID OPTION
      WRITE (LP,1580) CHK(1:LENSTR(CHK))
      CALL SUERRS (LP,2,NUMERR)
      GO TO 320
C
60    IF (IOPTN.LE.10.OR.IOPTN.EQ.15.OR.IOPTN.EQ.16) NUMOPT=NUMOPT+1
      GO TO (80,350,350,350,350,
     *       350,350,350,350,90,
     *       100,140,150,240,350,
     *       350,350,280,285,70),IOPTN
70       WRITE (LP,1590) IOPTN
         CALL SULINE (LP,2)
         GO TO 320
C
C  DISPOSITION OPTION
80    DISP='NEW'
      WRITE (LP,1360) DISP
      CALL SULINE (LP,2)
      GO TO 320
C
C  ALL OPTION
90    IALL=1
      IPFALL=1
      IBMDR=1
      WRITE (LP,1370) 'ALL'
      CALL SULINE (LP,2)
      GO TO 360
C
C  SORT OPTION
100   IF (LLPAR.GT.0) GO TO 110
         CHK='ID'
         WRITE (LP,1400) OPTN(IOPTN),CHK(1:LENSTR(CHK))
         CALL SULINE (LP,2)
         GO TO 130
110   IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,1410) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LCHK,CHK,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (CHK.EQ.'ID'.OR.
     *    CHK.EQ.'DESC') GO TO 130
         WRITE (LP,1420) OPTN(IOPTN),CHK(1:LENSTR(CHK))
         CALL SUERRS (LP,2,NUMERR)
         GO TO 320
130   IF (CHK.EQ.'ID') ISORT=1
      IF (CHK.EQ.'DESC') ISORT=2
      XSORT=CHK
      WRITE (LP,1440) OPTN(IOPTN),XSORT
      CALL SULINE (LP,2)
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1450) XSORT,ISORT
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 320
C
C  OPTION TO COMPUTE MDR BOXES FOR MAP AREAS USING BASIN BOUNDARIES
140   IBMDR=1
      IALL=0
      IOPTN=0
      GO TO 320
C
C  OPTION TO SET NTWK INDICATOR VALUES
150   NOPFLD=1
      IBEG=1
      IF (LLPAR.GT.0) IBEG=LLPAR+1
      IEND=LEQUAL-1
      IDEFLT=0
      IF (LEQUAL.GT.0.AND.LEQUAL.GT.IBEG) GO TO 160
         VALUE='YES'
         WRITE (LP,1480) NFLD,VALUE
         CALL SUWRNS (LP,2,NUMWRN)
         IDEFLT=1
         IEND=LENGTH
         IF (LRPAR.GT.0) IEND=LRPAR-1
160   CALL UFPACK (1,OPTION,ISTRT,IBEG,IEND,IERR)
      IF (OPTION.NE.'ALL') THEN
         CALL UFINFX (IPOS,ISTRT,IBEG,IEND,IERR)
         IF (IPOS.LT.1.OR.IPOS.GT.NNWFLG) THEN
            WRITE (LP,1510) IPOS,NNWFLG
            CALL SUWRNS (LP,2,NUMWRN)
            GO TO 220
            ENDIF
         ENDIF
      IF (IDEFLT.EQ.0) THEN
         IBEG=LEQUAL+1
         IEND=LENGTH
         IF (LRPAR.GT.0) IEND=LRPAR-1
         NCHAR=IEND-LEQUAL
         IF (NCHAR.EQ.0) THEN
            VALUE='YES'            
            WRITE (LP,1485) NFLD,VALUE
            CALL SUWRNS (LP,2,NUMWRN)
            ELSE
               IF (NCHAR.GT.4) THEN
                  WRITE (LP,1540) NCHAR,CHAR
                  CALL SUERRS (LP,2,NUMERR)
                  GO TO 220
                  ENDIF
               CALL SUBSTR (CHAR,IBEG,NCHAR,VALUE,1)
            ENDIF
         ENDIF
      IF (VALUE.EQ.'YES') IVAL=1
      IF (VALUE.EQ.'NO') IVAL=0
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1490) VALUE,IVAL
         CALL SULINE (IOSDBG,1)
         ENDIF
      IF (OPTION.NE.'ALL') GO TO 210
         WRITE (LP,1500) VALUE
         CALL SULINE (LP,2)
         DO 200 I=1,NNWFLG
            INWFLT(I)=IVAL
200         CONTINUE
         WRITE (LP,1545) NNWFLG,VALUE
         CALL SULINE (LP,2)
         GO TO 230
210   WRITE (LP,1550) IPOS,VALUE
      CALL SULINE (LP,2)
220   IF (LRPAR.GT.0) NOPFLD=0
      INWFLT(IPOS)=IVAL
230   IPASS=-1
      GO TO 320
C
C  OPTION TO UPDATE NTWK INDICATOR VALUES
240   IF (LLPAR.GT.0) GO TO 250
         UPDATE='AFTER'
         WRITE (LP,1400) OPTN(IOPTN),UPDATE
         CALL SULINE (LP,2)
         GO TO 320
250   IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.GT.0) GO TO 260
         WRITE (LP,1410) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
260   CALL UFPACK (LCHK,CHK,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (CHK.EQ.'BEFORE'.OR.
     *    CHK.EQ.'AFTER'.OR.
     *    CHK.EQ.'BOTH'.OR.
     *    CHK.EQ.'NEITHER'.OR.
     *    CHK.EQ.'ONLY') GO TO 270
         WRITE (LP,1420) OPTN(IOPTN),CHK(1:LENSTR(CHK))
         CALL SUERRS (LP,2,NUMERR)
         GO TO 320
270   UPDATE=CHK
      WRITE (LP,1440) OPTN(IOPTN),UPDATE
      CALL SULINE (LP,2)
      GO TO 320
C
C  OPTION TO FORCE UPDATING OF MAP AND MAT TIME SERIES HEADERS
280   IF (LLPAR.GT.0) GO TO 290
         ITSHDR=1
         WRITE (LP,1400) OPTN(IOPTN),'YES'
         CALL SULINE (LP,2)
         GO TO 320
290   IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.GT.0) GO TO 300
         WRITE (LP,1410) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
300   CALL UFPACK (LCHK,CHK,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (CHK.EQ.'YES'.OR.CHK.EQ.'NO') GO TO 310
         WRITE (LP,1420) OPTN(IOPTN),CHK(1:LENSTR(CHK))
         CALL SUERRS (LP,2,NUMERR)
         GO TO 320
310   IF (CHK.EQ.'NO') ITSHDR=0
      IF (CHK.EQ.'YES') ITSHDR=1
      IF (ITSHDR.EQ.0) THEN
         WRITE (LP,1520)
         CALL SULINE (LP,2)
         ENDIF
      IF (ITSHDR.EQ.1) THEN
         WRITE (LP,1530)
         CALL SULINE (LP,2)
         ENDIF
      GO TO 320
C
C  OPTION TO NOT PRINT NTWK PARAMETERS WHEN UPDATE OPTION SPECIFIED
285   IPNTWK=0
      WRITE (LP,1445) OPTN(IOPTN)
      CALL SULINE (LP,2)
      GO TO 320
C
320   IOPTN=0
      GO TO 20
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  END OF INPUT FOR NETWORK COMMAND FOUND
330   IENDIN=1
      IF (IPFALL.EQ.1.OR.NUMOPT.GT.0) GO TO 340
         IPFALL=1
         GO TO 360
340   IF (IPASS.EQ.-1) GO TO 390
      GO TO 1260
C
C  OPTION SPECIFIED
350   IALL=0
      IBMDR=0
C
C  CHECK IF FIRST PASS
360   IF (IPASS.GT.0) GO TO 520
C
C  CHECK IF NEW VALUE OF NTWK INDICATOR SPECIFIED
      IF (IPASS.EQ.-1) GO TO 390
C
      IF (IBMDR.GT.0) THEN
         WRITE (LP,1560)
         CALL SULINE (LP,2)
         ENDIF
C
C  READ NTWK PARAMETERS
370   RDISP='OLD'
      CALL SUGTNF (LARRAY,ARRAY,RDISP,NUMERR,IERR)
      IF (IERR.NE.0) THEN
         WRITE (LP,1610)
         CALL SULINE (LP,2)
         GO TO 20
         ENDIF
      IRNTWK=1
C
390   IF (IRNTWK.EQ.0) GO TO 370
C
C  CHECK IF ANY NEW VALUES FOR NTWK INDICATORS SPECIFIED
      DO 400 I=1,NNWFLG
         IF (INWFLT(I).NE.-1) INWFLG(I)=INWFLT(I)
400      CONTINUE
C
      IF (UPDATE.EQ.'AFTER'.OR.
     *    UPDATE.EQ.'NEITHER') GO TO 410
C
C  UPDATE NTWK PARAMETERS WITH SPECIFIED VALUES
      WDISP='OLD'
      CALL SWNTWK (IVNTWK,UNSD,NNWFLG,INWFLG,INWDTE,
     *   LARRAY,ARRAY,WDISP,IERR)
      IF (IERR.GT.0) GO TO 20
C
C  PRINT NTWK PARAMETERS
410   IF (IPNTWK.EQ.1) THEN
         CALL SPNTWK (IVNTWK,INWDTE,NNWFLG,INWFLG,UNUSED,IERR)
         ENDIF
C
C  CHECK IF END OF INPUT FOR COMMAND
      IF (IENDIN.EQ.0) GO TO 420
      IF (NUMOPT.GT.0) GO TO 1270
C
C  CHECK IF NTWK PARAMETERS ONLY TO BE UPDATED
420   IF (UPDATE.EQ.'ONLY') THEN
         IF (IENDIN.EQ.0) GO TO 20
         GO TO 1270
         ENDIF
C
      IF (IOPEN.EQ.1) GO TO 520
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
      IF (IOPTN.GT.0.OR.IBMDR.GT.0) GO TO 440
C
C  CHECK IF ANY COMPUTATIONS NEED TO BE DONE
      DO 430 I=1,NNWFLG
         IF (INWFLG(I).NE.0) GO TO 440
430      CONTINUE
      WRITE (LP,1620)
      CALL SULINE (LP,2)
      GO TO 1260
C
C  CHECK IF PREPROCESSOR PARAMETRIC DATA BASE ALLOCATED
440   IDPPD=1
      IDPPP=1
      CALL SUDALC (0,0,0,IDPPD,IDPPP,0,0,0,0,0,NUMERR,IERR)
      IF (IERR.NE.0) THEN
         WRITE (LP,1640)
         CALL SUERRS (LP,2,NUMERR)
         GO TO 1260
         ENDIF
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
      IF (IUGFIL.EQ.0) THEN
C     READ UGNL PARAMETER RECORD
         IRUGNL=0
         IPRERR=0
         INCLUDE 'scommon/callsrugnl'
         IF (IERR.EQ.2) THEN
            WRITE (LP,1650)
            CALL SUERRS (LP,2,NUMERR)
            GO TO 1260
            ENDIF
         IUGFIL=1
         ENDIF
C
      IRUGNL=1
C
C  CHECK VALUE OF MINIMUM WEIGHT OF STATIONS TO BE KEPT WHEN DOING
C  STATION WEIGHTING
      STWTMX=.1
      IF (STMNWT.GT.0.0.AND.STMNWT.LE.STWTMX) GO TO 480
         WRITE (LP,1660) STMNWT,STWTMX
         CALL SUERRS (LP,2,NUMERR)
         GO TO 1250
C
C  PRINT UGNL PARAMETERS
480   IF (LDEBUG.GT.0) THEN
         UNITS='ENGL'
         INCLUDE 'scommon/callspugnl'
         ENDIF
C
      IF (ISORT.EQ.0) GO TO 490
         PSORT=XSORT
         GO TO 510
C
C  SET SORT INDICATOR
490   XSORT=SORTBY
      IF (XSORT.EQ.'ID'.OR.XSORT.EQ.'DESC') GO TO 500
         WRITE (LP,1670) XSORT
         CALL SUERRS (LP,2,NUMERR)
         XSORT='ID'
500   IF (XSORT.EQ.'ID') ISORT=1
      IF (XSORT.EQ.'DESC') ISORT=2
      PSORT=XSORT
510   WRITE (LP,1680) PSORT
      CALL SULINE (LP,2)
C
      IOPEN=1
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
520   IF (ILNTWK.EQ.1.OR.IOPTN.EQ.8.OR.IOPTN.EQ.9) GO TO 640
C
C  CHECK IF 'ALL' OPTION SPECIFIED
      IF (IALL.NE.1) GO TO 530
         INTP=2
         GO TO 570
C
C  CHECK NETWORK FLAGS FOR HOW NETWORK COMMON BLOCK IS TO BE LOADED
530   INTYPE=0
      DO 540 I=1,5
         IF (INWFLG(I).GT.0) INTYPE=1
540      CONTINUE
      DO 550 I=6,11
         IF (INWFLG(I).GT.0) INTYPE=2
550      CONTINUE
      DO 560 I=12,15
         IF (INTYPE.EQ.0.AND.INWFLG(I).GT.0.AND.ISORT.EQ.1) INTYPE=3
         IF (INTYPE.EQ.0.AND.INWFLG(I).GT.0.AND.ISORT.EQ.2) INTYPE=4
560      CONTINUE
      IF (INTYPE.EQ.0.AND.INWFLG(17).GT.0.AND.ISORT.EQ.1) INTYPE=3
      IF (INTYPE.EQ.0.AND.INWFLG(17).GT.0.AND.ISORT.EQ.2) INTYPE=4
C
C  CHECK SPECIFIED OPTIONS FOR HOW NETWORK COMMON BLOCK IS TO BE LOADED
      INTP=INTYPE
      IF (IOPTN.GE.2.AND.IOPTN.LE.7) INTP=-1
      IF ((IOPTN.EQ.8.OR.IOPTN.EQ.9.OR.IOPTN.EQ.15).AND.ISORT.EQ.1)
     *   INTP=3
      IF ((IOPTN.EQ.8.OR.IOPTN.EQ.9.OR.IOPTN.EQ.15).AND.ISORT.EQ.2)
     *   INTP=4
      IF (INTP.EQ.0) GO TO 600
C
C  LOAD NETWORK COMMON BLOCK
570   CALL SNSTAN (INTP,LARRAY,ARRAY,IERR)
      IF (IERR.NE.0) THEN
         WRITE (LP,1630)
         CALL SUERRS (LP,2,NUMERR)
         GO TO 1250
         ENDIF
C
C  CHECK NUMBER OF STATIONS STORED IN NETWORK COMMON BLOCK
      IF (INWFIL.EQ.0) THEN
         WRITE (LP,1570)
         CALL SUWRNS (LP,2,NUMWRN)
         GO TO 1250
         ENDIF
C
      ILNTWK=1
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SAVE OLD VALUES OF MAP AND MAT STATUS INDICATORS
600   ICMAP=ICUGNL(1)
      ICMAT=ICUGNL(2)
C
C  CHECK IF NEED TO SET MAP FILE STATUS INDICATOR TO INCOMPLETE
      IF (INWFLG(1).EQ.1.OR.
     *    INWFLG(2).EQ.1.OR.
     *    INWFLG(6).EQ.1.OR.
     *    INWFLG(7).EQ.1.OR.
     *    INWFLG(9).EQ.1) ICUGNL(1)=1
C
C  CHECK IF NEED TO SET MAT FILE STATUS INDICATOR TO INCOMPLETE
      IF (INWFLG(3).EQ.1.OR.
     *    INWFLG(4).EQ.1.OR.
     *    INWFLG(5).EQ.1.OR.
     *    INWFLG(8).EQ.1.OR.
     *    INWFLG(10).EQ.1) ICUGNL(2)=1
C
      IWUGNL=0
C
C  CHECK IF NEED TO UPDATE UGNL PARAMTERS      
      IF (ICUGNL(1).EQ.0.AND.ICUGNL(2).EQ.0) GO TO 640
C
C  UPDATE UGNL PARAMETERS
      WDISP='OLD'
      INCLUDE 'scommon/callswugnl'
      IF (IERR.NE.0) THEN
         WRITE (LP,1690) IERR
         CALL SUERRS (LP,2,NUMERR)
         GO TO 1320
         ENDIF
C
C  CLOSE PARAMETRIC DATA BASE TO WRITE UGNL PARAMETERS TO FILE
      CALL SUPCLS (1,'PPP ',IERR)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
640   IF (IOPTN.GT.0) CALL SUBSTR (OPTN(IOPTN),1,4,OPTN4,1)
C
      IF (IPASS.EQ.0.AND.ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C  SET INDICATOR THAT COMPUTATIONS TO BE DONE FOR STATIONS
      IRTYPE=1
C
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1700) LARRAY,IRTYPE,IALL,IOPTN,IBMDR
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      IUEND=0
      NPAGE=0
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  STATION PCPN PARAMETERS
C
      NOPTN=2
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 660
      IF (IOPTN.NE.NOPTN) GO TO 700
C
660   IF (INWFLG(1).EQ.1.OR.
     *    INWFLG(2).EQ.1) GO TO 670
         IF (IOPTN.EQ.0) GO TO 700
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
670   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE 5 CLOSEST 24-HR OR 3 CLOSEST <24-HR PCPN STATIONS/QUADRANT
      CALL SNPCPN (IRTYPE,IALL,IOPTN,LARRAY,ARRAY,INWFLG,
     *   IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(1)=0
         INWFLG(2)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  STATION TEMP PARAMETERS
C
700   NOPTN=3
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 710
      IF (IOPTN.NE.NOPTN) GO TO 750
C
710   IF (INWFLG(3).EQ.1.OR.
     *    INWFLG(4).EQ.1.OR.
     *    INWFLG(5).EQ.1) GO TO 720
         IF (IOPTN.EQ.0) GO TO 750
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
720   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE 3 CLOSEST MAX/MIN, 3 CLOSEST INST AND/OR 2 CLOSEST FCST TEMP
C  STATIONS/QUADRANT
      CALL SNTEMP (IRTYPE,IALL,IOPTN,LARRAY,ARRAY,INWFLG,
     *   IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(3)=0
         INWFLG(4)=0
         INWFLG(5)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SET INDICATOR THAT COMPUTATIONS TO BE DONE FOR AREAS
750   IRTYPE=2
C
C  MAP AREA PARAMETERS
C
      NOPTN=4
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 760
      IF (IOPTN.NE.NOPTN) GO TO 800
C
760   IF (INWFLG(6).EQ.1.OR.
     *    INWFLG(7).EQ.1) GO TO 770
         IF (IOPTN.EQ.0) GO TO 800
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
770   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE MAP TIME DISTRIBUTION AND STATION WEIGHTS
      IBASN=0
      CALL SNMAP (IRTYPE,IALL,IBMDR,IOPTN,OPTN4,LARRAY,ARRAY,
     *   NNWFLG,INWFLG,STMNWT,IBASN,ITSHDR,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(6)=0
         INWFLG(7)=0
         INWFLG(9)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  MAT AREA PARAMETERS
C
800   NOPTN=5
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 810
      IF (IOPTN.NE.NOPTN) GO TO 850
C
810   IF (INWFLG(8).EQ.1) GO TO 820
         IF (IOPTN.EQ.0) GO TO 850
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
820   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE MAT TIME DISTRIBUTION AND STATION WEIGHTS
      IBASN=0
      CALL SNMAT (IRTYPE,IALL,IOPTN,OPTN4,LARRAY,ARRAY,
     *   NNWFLG,INWFLG,STMNWT,IBASN,ITSHDR,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(8)=0
         INWFLG(10)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  MAP AND MAT DUE TO BASIN PARAMETER CHANGES
C
850   NOPTN=6
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 860
      IF (IBMDR.EQ.1) GO TO 860
      IF (IOPTN.NE.NOPTN) GO TO 960
C
860   IF (INWFLG(9).EQ.1.OR.
     *    INWFLG(10).EQ.1) GO TO 870
         IF (IOPTN.EQ.0) GO TO 960
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
            GO TO 880
C
870   IF (IBMDR.EQ.1) GO TO 880
C
      IF (INWFLG(9).EQ.0) GO TO 910
C
C  WRITE TO PROGRAM LOG
880   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE MAP VALUES DUE TO BASIN BOUNDARY CHANGE
      IBASN=1
      CALL SNMAP (IRTYPE,IALL,IBMDR,IOPTN,OPTN4,LARRAY,ARRAY,
     *   NNWFLG,INWFLG,STMNWT,IBASN,ITSHDR,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(9)=0
         ENDIF
C         
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
      IF (IERR.EQ.0.AND.IBMDR.EQ.1) GO TO 950
C
910   IF (IABS(IALL).EQ.1) GO TO 920
      IF (IOPTN.EQ.NOPTN) GO TO 930
      IF (IBMDR.EQ.1) GO TO 930
C
920   IF (INWFLG(10).EQ.0) GO TO 950
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE MAT VALUES DUE TO BASIN BOUNDARY CHANGE
930   IBASN=1
      CALL SNMAT (IRTYPE,IALL,IOPTN,OPTN4,LARRAY,ARRAY,
     *   NNWFLG,INWFLG,STMNWT,IBASN,ITSHDR,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(10)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
950   ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  MAPE AREA PARAMETERS
C
960   NOPTN=7
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 970
      IF (IOPTN.NE.NOPTN) GO TO 1010
C
970   IF (INWFLG(11).EQ.1) GO TO 980
         IF (IOPTN.EQ.0) GO TO 1010
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
980   ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE MAPE 1/D**POWER WEIGHTS
      CALL SNMAPE (IRTYPE,LARRAY,ARRAY,STMNWT,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(11)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SET VALUES FOR CHECKING IF SUFFICIENT CPU TIME AVAILABLE
C
1010  ICKRGN=0
      ICKCPU=1
      MINCPU=10
      IPRERR=1
      IPUNIT=LP
      TYPERR='ERROR'
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  DAILY STATION ALPHABETICAL ORDER PARAMETERS
C
      NOPTN=8
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 1020
      IF (IOPTN.NE.NOPTN) GO TO 1060
C
1020  IF (INWFLG(11).EQ.1.OR.
     *    INWFLG(12).EQ.1.OR.
     *    INWFLG(13).EQ.1.OR.
     *    INWFLG(14).EQ.1.OR.
     *    INWFLG(15).EQ.1) GO TO 1030
         IF (IOPTN.EQ.0) GO TO 1060
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
1030  ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
C  CHECK IF SUFFICIENT CPU TIME AVAILABLE
      INCLUDE 'clugtres'
      IF (IERR.NE.0) THEN
         CALL SUFATL
         IUEND=1
         GO TO 1270
         ENDIF
C
      CALL SNNTW2 (LP,IPRINT)
C
C  UPDATE DAILY STATION ALPHABETICAL ORDER
      CALL SNODLY (IALL,IOPTN,ISORT,LARRAY,ARRAY,NNWFLG,INWFLG,
     *   IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  UPDATE STATION GRID-POINT LOCATION PARAMETERS
C
1060  NOPTN=15
      NOPTN2=17
      NIOPTN=NOPTN
      IF (IOPTN.EQ.NOPTN2) NIOPTN=NOPTN2
      IERR=0
      IF (IABS(IALL).EQ.1) GO TO 1070
      IF (IOPTN.NE.NOPTN.AND.IOPTN.NE.NOPTN2) GO TO 1100
C
1070  IF (INWFLG(17).EQ.1) GO TO 1080
         IF (IOPTN.EQ.0) GO TO 1100
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN.OR.IOPTN.EQ.NOPTN2)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN.OR.IOPTN.EQ.NOPTN2)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
1080  ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NIOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  CHECK IF SUFFICIENT CPU TIME AVAILABLE
      INCLUDE 'clugtres'
      IF (IERR.NE.0) THEN
         CALL SUFATL
         IUEND=1
         GO TO 1270
         ENDIF
C
      CALL SNGP24 (ISORT,LARRAY,ARRAY,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IGP24=1
C
      IF (IOPTN.EQ.NOPTN2) GO TO 1100
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NIOPTN),BLNK8,NPAGE,ISTART,IERR)
C
C  UPDATE GRID-POINT STATION ALPHABETICAL ORDER PARAMETERS
C
1100  NOPTN=16
      IPRINT=0
      NIOPTN=NOPTN
      IF (IOPTN.EQ.NOPTN2) NIOPTN=NOPTN2
      IERR2=0
      IF (IABS(IALL).EQ.1) GO TO 1110
      IF (IOPTN.NE.NOPTN.AND.IOPTN.NE.NOPTN2) GO TO 1150
C
1110  IF (INWFLG(17).EQ.1) GO TO 1120
         IF (IOPTN.EQ.0) GO TO 1150
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN.OR.IOPTN.EQ.NOPTN2)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN.OR.IOPTN.EQ.NOPTN2)
     *         CALL SULINE (LP,2)
C
1120  IF (IOPTN.EQ.NOPTN2) GO TO 1130
C
C  WRITE TO PROGRAM LOG
      ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NIOPTN),BLNK8,NPAGE,ISTART,IERR)
C
1130  CALL SNNTW2 (LP,IPRINT)
C
C  CHECK IF SUFFICIENT CPU TIME AVAILABLE
      INCLUDE 'clugtres'
      IF (IERR.NE.0) THEN
         CALL SUFATL
         IUEND=1
         GO TO 1270
         ENDIF
C
      CALL SNOG24 (ISORT,LARRAY,ARRAY,IUEND,IERR2)
      IF (IUEND.EQ.1) GO TO 1270
      IOG24=1
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NIOPTN),BLNK8,NPAGE,ISTART,IERR)
C
1150  IF (IGP24.EQ.0.AND.IOG24.EQ.0) GO TO 1160
      IF (IGP24.EQ.1.AND.IOG24.EQ.1) GO TO 1160
         WRITE (LP,1740)
         CALL SULINE (LP,2)
         GO TO 1190
C
1160  IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1730) IERR,IERR2
         CALL SULINE (IOSDBG,1)
         ENDIF
      IF (IERR.EQ.0.AND.IERR2.EQ.0) THEN
         INWFLG(17)=0
         ENDIF
C         
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  RRS STATION ALPHABETICAL ORDER PARAMETERS
C
C  DONE LAST SINCE CONTENTS OF NETWORK COMMON BLOCK IS OVERWRITTEN.
C
1190  NOPTN=9
      IPRINT=0
      IF (IABS(IALL).EQ.1) GO TO 1200
      IF (IOPTN.NE.NOPTN) GO TO 1250
C
1200  IF (INWFLG(16).EQ.1) GO TO 1210
         IF (IOPTN.EQ.0) GO TO 1250
            CALL SNNTW2 (LP,IPRINT)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         WRITE (LP,1750) OPTN(NOPTN)
            IF (IABS(IALL).EQ.1.OR.IOPTN.EQ.NOPTN)
     *         CALL SULINE (LP,2)
C
C  WRITE TO PROGRAM LOG
1210  ISTART=1
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      CALL SNNTW2 (LP,IPRINT)
C
C  CHECK IF SUFFICIENT CPU TIME AVAILABLE
      INCLUDE 'clugtres'
      IF (IERR.NE.0) THEN
         CALL SUFATL
         IUEND=1
         GO TO 1270
         ENDIF
C
C  UPDATE RRS STATION ALPHABETICAL ORDER PARAMETERS
      CALL SNORRS (ISORT,LARRAY,ARRAY,IUEND,IERR)
      IF (IUEND.EQ.1) GO TO 1270
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,1710) (INWFLG(I),I=1,NNWFLG)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,1720) IERR
         CALL SULINE (IOSDBG,1)
         INCLUDE 'scommon/callspugnl'
         ENDIF
      IF (IERR.EQ.0) THEN
         INWFLG(16)=0
         ENDIF
C
C  WRITE TO PROGRAM LOG
      ISTART=0
      CALL SUWLOG ('OPTN',OPTN(NOPTN),BLNK8,NPAGE,ISTART,IERR)
C
      IF (ITMAUT.EQ.1) CALL SUTIMR (LP,ITMELA,ITMTOT)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
1250  IPASS=1
C
C  CHECK FOR END OF INPUT
1260  IF (IENDIN.EQ.0) GO TO 20
C
C  CHECK FOR ERRORS
1270  IF (NUMERR.EQ.0) GO TO 1280
         WRITE (LP,1760) NUMERR
         CALL SULINE (LP,2)
C
1280  IF (IUEND.EQ.0.AND.IPASS.EQ.0) GO TO 1320
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  CHECK IF NTWK PARAMETERS ARE TO BE UPDATED
      IF (UPDATE.EQ.'ONLY') GO TO 1320
      IF (UPDATE.EQ.'AFTER'.OR.
     *    UPDATE.EQ.'BOTH') GO TO 1290
         WRITE (LP,1770) OPTN(14),UPDATE
         CALL SULINE (LP,2)
         GO TO 1300
C
C  UPDATE NTWK PARAMETER ARRAY
1290  WDISP='OLD'
      CALL SWNTWK (IVNTWK,UNSD,NNWFLG,INWFLG,INWDTE,
     *   LARRAY,ARRAY,WDISP,IERR)
      IF (IERR.GT.0) GO TO 1320
C
C  CLOSE PARAMETRIC DATA BASE TO WRITE NTWK PARAMETERS TO FILE
      CALL SUPCLS (1,'PPP ',IERR)
C
C  READ NTWK PARAMETERS
1300  CALL SRNTWK (LARRAY,ARRAY,IVNTWK,INWDTE,NNWFLG,INWFLG,UNUSED,
     *   IPRERR,IERR)
      IF (IERR.GT.0) GO TO 1320
C
C  PRINT NTWK PARAMETERS
      CALL SPNTWK (IVNTWK,INWDTE,NNWFLG,INWFLG,UNUSED,IERR)
C
C  CHECK IF NEED TO UPDATE UGNL PARAMTERS      
CCC   IF (IWUGNL.EQ.0) GO TO 1315
C
C  CHECK IF UGNL PARAMETERS SUCCESSFULLY READ
      IF (IRUGNL.EQ.-1) GO TO 1315
      IF (IRUGNL.EQ.1) GO TO 1310
         WRITE (LP,1780)
         CALL SUERRS (LP,2,NUMERR)
         GO TO 1320
C
C  UPDATE MAP AND MAT FILE STATUS INDICATORSS TO COMPLETE IF COMPLETE
C  WHEN STARTED
1310  IF (ICMAP.EQ.0) ICUGNL(1)=0
      IF (ICMAT.EQ.0) ICUGNL(2)=0
C
C  UPDATE UGNL PARAMETERS      
      WDISP='OLD'
      INCLUDE 'scommon/callswugnl'
      IF (IERR.GT.0) GO TO 1320
C
C  CLOSE DATA BASE
      CALL SUPCLS (1,'PPP ',IERR)
C
      IF (LDEBUG.GT.0) THEN
         INCLUDE 'scommon/callspugnl'
         ENDIF
C
C  CHECK IF TO END RUN
1315  IF (IUEND.EQ.1) CALL SUEND
C
C  RESET AUTOMATIC NETWORK RUN INDICATOR
      INAUTO=0
C
1320  IF (LTRACE.GT.0) THEN
         WRITE (IOSDBG,1790) ISTAT
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
1330  FORMAT (' *** ENTER SNNTWK')
1340  FORMAT ('0*--> COMPUTE PARAMETERS')
1350  FORMAT (' LARRAY=',I6,3X,'NFLD=',I2)
1360  FORMAT ('0*** NOTE - DISPOSITION SET TO ',A,'.')
1370  FORMAT ('0*** NOTE - ''',A,''' OPTION SPECIFIED.')
1380  FORMAT ('0*** ERROR - NO NETWORK OPTIONS ARE CURRENTLY ',
     *   'AVAILABLE. INPUT IN CARD FIELD ',I2,' (',A,') IGNORED.')
1400  FORMAT ('0*** NOTE - NO LEFT PARENTHESIS FOUND. ',A,' ',
     *   'OPTION SET TO ',A,'.')
1410  FORMAT ('0*** NOTE - RIGHT PARENTHESIS ASSUMED IN FIELD ',I2,'.')
1420  FORMAT ('0*** ERROR - INVALID ',A,' OPTION : ',A)
1440  FORMAT ('0*** NOTE - ',A,' OPTION SET TO ',A,'.')
1445  FORMAT ('0*** NOTE - ',A,' OPTION SET.')
1450  FORMAT (' SORT OPTION SET TO ',A,3X,'(ISORT=',I1,')')
1480  FORMAT ('0*** WARNING - EQUAL SIGN NOT FOUND IN FIELD ',I2,'. ',
     *   'VALUE ASSUMED TO BE ',A,'.')
1485  FORMAT ('0*** WARNING - EQUAL SIGN FOUND IN FIELD ',I2,' ',
     *   'BUT NO VALUE SPECIFIED. ',
     *   'VALUE ASSUMED TO BE ',A,'.')
1490  FORMAT (' VALUE=',A,3X,'IVAL=',I2)
1500  FORMAT ('0*** NOTE - ALL NTWK INDICATORS WILL BE SET TO ',A,'.')
1510  FORMAT ('0*** WARNING - NTWK ARRAY POSITION ',I2,' IS INVALID. ',
     *   'VALID RANGE IS 1 TO ',I2,'.')
1520  FORMAT ('0*** NOTE - MAP AND MAT TIME SERIES HEADERS WILL ',
     *   'BE UPDATED ONLY IF BASIN BOUNDAY HAS CHANGED.')
1530  FORMAT ('0*** NOTE - MAP AND MAT TIME SERIES HEADERS WILL ',
     *   'BE UPDATED EVEN IF BASIN BOUNDAY HAS CHANGED.')
1540  FORMAT ('0*** ERROR - NUMBER OF CHARACTERS (',I2,') IN INPUT ',
     *   'FIELD ',I2,' EXCEEDS MAXIMUM THAT CAN BE PROCESSED.')
1545  FORMAT ('0*** NOTE - NTWK ARRAY POSITIONS 1 THROUGH ',I2,' ',
     *   'SET TO ',A,'.')
1550  FORMAT ('0*** NOTE - NTWK ARRAY POSITION ',I2,' ',
     *   'SET TO ',A,'.')
1560  FORMAT ('0*** NOTE - MDR BOXES FOR MAP AREAS USING BASIN ',
     *   'BOUNDARIES WILL BE RECOMPUTED.')
1570  FORMAT ('0*** WARNING - NO STATIONS WITH COMPLETE DEFINITIONS ',
     *   'FOUND. NETWORK COMMAND EXECUTION STOPPED.')
1580  FORMAT ('0*** ERROR - INVALID NETWORK OPTION : ',A)
1590  FORMAT ('0*** ERROR - PROCESSING NETWORK OPTION NUMBER ',I2,'.')
1600  FORMAT (' NULL FIELD FOUND IN FIELD ',I2)
1610  FORMAT ('0*** NOTE - NTWK PARAMETERS NOT SUCCESSFULLY ',
     *   'READ. NETWORK CANNOT BE RUN.')
1620  FORMAT ('0*** NOTE - NO NETWORK COMPUTATIONS NEED TO BE DONE.')
1630  FORMAT ('0*** ERROR - NETWORK COMMON BLOCK NOT SUCCESSFULLY ',
     *   'FILLED. NETWORK WILL NOT BE RUN.')
1640  FORMAT ('0*** ERROR - PREPROCESSOR PARAMETRIC DATA BASE FILES ',
     *   'ARE NOT ALLOCATED. NETWORK CANNOT BE RUN.')
1650  FORMAT ('0*** ERROR - UGNL PARAMETERS NOT FOUND. ',
     *   'GENERAL USER PARAMETERS MUST BE DEFINED BEFORE NETWORK ',
     *   'CAN BE RUN.')
1660  FORMAT ('0*** ERROR - MINIMUM STATION WEIGHT TO BE KEPT (',
     *   F8.2,') IS NOT GREATER THAN ZERO OR LESS THEN OR EQUAL TO ',
     *   F4.1,'.')
1670  FORMAT ('0*** ERROR - IN SNNTWK - INVALID SORT INDICATOR (',A,
     *   ') OBTAINED FROM UGNL PARAMETERS. SORT BY ID WILL BE USED.')
1680  FORMAT ('0*** NOTE - STATION INFORMATION WILL BE SORTED BY ',
     *   A,'.')
1690  FORMAT ('0*** ERROR - IN SNNTWK - ERROR WRITING UGNL ',
     *   'PARAMETERS : STATUS CODE=',I2,'.')
1700  FORMAT (' LARRAY=',I5,3X,'IRTYPE=',I2,3X,'IALL=',I2,3X,
     *    'IOPTN=',I2,3X,'IBMDR=',I2)
1710  FORMAT (' INWFLG=',20(I2,1X))
1720  FORMAT (' IERR=',I2)
1730  FORMAT (' IERR=',I2,3X,'IERR2=',I2)
1740  FORMAT ('0*** NOTE - GP24/OG24 NETWORK FLAG NOT UPDATED ',
     *   'BECAUSE BOTH PARAMETER ARRAYS NOT WRITTEN.')
1750  FORMAT ('0*** NOTE - NO ',A,' COMPUTATIONS NEED TO BE DONE.')
1760  FORMAT ('0*** NOTE - ',I3,' ERRORS  ENCOUNTERED BY NETWORK ',
     *   'COMMAND.')
1770  FORMAT ('0*** NOTE - NTWK PARAMETERS WILL NOT BE UPDATED ',
     *   'BECAUSE ',A,'(',A,') OPTION SPECIFIED.')
1780  FORMAT ('0*** ERROR - IN SNNTWK - UGNL PARAMETERS NOT ',
     *   'UPDATED BECAUSE UGNL PARAMETERS NOT SUCCESSFULLY READ.')
1790  FORMAT (' *** EXIT SNNTWK : ISTAT=',I2)
C
      END
