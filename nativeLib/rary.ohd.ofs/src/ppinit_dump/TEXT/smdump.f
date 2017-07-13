C MODULE SMDUMP
C-----------------------------------------------------------------------
C
C  MAIN ROUTINE FOR DUMPING PARAMETERS.
C
      SUBROUTINE SMDUMP (LARRAY,ARRAY,NFLD,ISTAT)
C
      CHARACTER*4 ZTYPE,UNITS,PLOT,SUMARY,SORT,PREST,DEGMIN
      CHARACTER*4 PDTYPE
      CHARACTER*8 STRNG28
      CHARACTER*8 DDNAME
      CHARACTER*8 XTYPE,XSORT,XSPACE
      CHARACTER*8 BLNK8/' '/
      PARAMETER (MOPTN=16)
      CHARACTER*8 OPTN(MOPTN)
     *       /'PRINT   ','PUNCH   ','BOTH    ','PLOT    ',
     *        'UNITS   ','SUMMARY ','SORT    ','PRNTEST ',
     *        'LEVEL   ','DEGMIN  ','SPACEING','SPACING ',
     *        'NONE    ','TYPE    ','        ','        '/
      PARAMETER (MGROUP=36)
      CHARACTER*8 GROUP(MGROUP)
     *       /'AREA    ','BASIN   ','STATION ','STA     ',
     *        'USER    ','NAMES   ','ORDER   ','NETWORK ',
     *        'PARMS   ','ARRAY   ','PPDPTRS ','        ',
     *        '        ','FCID    ','PPDINDX ','PPPINDX ',
     *        'PDBINDX ','DFLT    ','PPPTYPE ','STATS   ',
     *        'CHAR    ','MMMT    ','GBOX    ','RFRO    ',
     *        'PPDCNTL ','MDRGRID ','FILECRAT','DSATTR  ',
     *        'PPFNDR  ','OUTPUT  ','PDFNDR  ','TSHDR   ',
     *        'PPPPTRS ','        ','        ','        '/
      CHARACTER*72 STRNG,STRNG2
C
      DIMENSION ARRAY(LARRAY)
C
      INCLUDE 'uiox'
      INCLUDE 'scommon/sudbgx'
      INCLUDE 'scommon/suoptx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_dump/RCS/smdump.f,v $
     . $',                                                             '
     .$Id: smdump.f,v 1.5 2001/06/13 13:55:52 dws Exp $
     . $' /
C    ===================================================================
C
C
      IF (ISTRCE.GT.0) THEN
         WRITE (IOSDBG,*) 'ENTER SMDUMP'
         CALL SULINE (IOSDBG,1)
         ENDIF
C
C  SET DEBUG LEVEL
      LDEBUG=ISBUG('DUMP')
C
      ISTAT=0
C
      LSTRNG=LEN(STRNG)/4
      LSTRNG2=LEN(STRNG2)/4
      LSTRNG28=LEN(STRNG28)/4
C
      LGROUP=0
      IGROUP=0
      ILPFND=0
      IRPFND=0
      ICFGRP=0
      NUMOPT=0
      IENDIN=0
      NUMERR=0
      NUMWRN=0
C
C  SET DEFAULT OPTIONS
      XTYPE='PRINT'
      UNITS='ENGL'
      PLOT='YES'
      SUMARY='NO'
      SORT='ID'
      PREST='NO'
      DEGMIN='NO'
      NSPACE=0
      LEVEL=1
C
C  PRINT CARD
      IF (ISLEFT(10).GT.0) CALL SUPAGE
      CALL SUPCRD
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
      ISTRT=1
C
C  CHECK FIELDS FOR DUMP OPTIONS
10    IPFGRP=ICFGRP
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPE,NREP,INT,REAL,
     *   LSTRNG,STRNG,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,IERR)
      IF (NFLD.EQ.-1) GO TO 320
      IF (LDEBUG.GT.0) THEN
         CALL UPRFLD (NFLD,ISTRT,LENGTH,ITYPE,NREP,INT,REAL,
     *      LSTRNG,STRNG,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,IERR)
         ENDIF
      IF (IERR.EQ.1) THEN
         IF (LDEBUG.GT.0) THEN
            WRITE (IOSDBG,900) NFLD
            CALL SULINE (IOSDBG,1)
            ENDIF
         GO TO 10
         ENDIF
C
C  CHECK FOR COMMAND
      IF (LATSGN.EQ.1) GO TO 320
C
C  CHECK FOR PAIRED PARENTHESES
      NPCFLD=0
      CALL SUPFND (ILPFND,IRPFND,NFLD,NPCFLD)
      IF (LLPAR.GT.0) ILPFND=1
      IF (LRPAR.GT.0) IRPFND=1
C
C  CHECK FOR PARENTHESIS IN FIELD
      IF (LLPAR.EQ.1) GO TO 60
      IF (LLPAR.GT.0) CALL UFPACK (LSTRNG2,STRNG2,ISTRT,1,LLPAR-1,IERR)
      IF (LLPAR.EQ.0) CALL UFPACK (LSTRNG2,STRNG2,ISTRT,1,LENGTH,IERR)
C
      IF (XTYPE.EQ.OPTN(1)) ZTYPE='PRNT'
      IF (XTYPE.EQ.OPTN(2)) ZTYPE='PNCH'
      IF (XTYPE.EQ.OPTN(3)) ZTYPE='BOTH'
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,*) 'XTYPE=',XTYPE,
     *      ' ZTYPE=',ZTYPE
         CALL SULINE (IOSDBG,1)
         ENDIF
C
C  CHECK FOR GROUP
      DO 40 IGROUP=1,MGROUP
         IF (STRNG2.EQ.GROUP(IGROUP)) THEN
            ICFGRP=1
            INDOPT=0
            IF (IGROUP.EQ.1.OR.
     *          IGROUP.EQ.3.OR.
     *          IGROUP.EQ.4.OR.
     *          IGROUP.EQ.7.OR.
     *          IGROUP.EQ.23.OR.
     *          IGROUP.EQ.24) INDOPT=1
            IF (INDOPT.EQ.0) GO TO 30
            IF (IPFGRP.EQ.1.AND.ICFGRP.EQ.1) THEN
               WRITE (LP,830) STRNG2(1:LENSTR(STRNG2)),GROUP(LGROUP)
               CALL SUWRNS (LP,2,NUMWRN)
               ENDIF
30          LGROUP=IGROUP
            IF (LDEBUG.GT.0) THEN
               WRITE (IOSDBG,910) GROUP(LGROUP),INDOPT
               CALL SULINE (IOSDBG,1)
               ENDIF
            IF (NFLD.EQ.1.AND.ISNWPG(LP).EQ.0.AND.IOPNWP.EQ.1)
     *         CALL SUPAGE
            IF (NFLD.EQ.1) CALL SUPCRD
            IF (INDOPT.EQ.0) GO TO 330
            GO TO 10
            ENDIF
40       CONTINUE
C
      IF (LGROUP.GT.0) GO TO 330
C
C  CHECK FOR OPTION
      DO 50 IOPTN=1,MOPTN
         IF (STRNG2.EQ.OPTN(IOPTN)) GO TO 70
50       CONTINUE
C
C  CHECK FOR KEYWORD
      CALL SUIDCK ('DMPG',STRNG2,NFLD,0,IKEYWD,IERR)
      IF (IERR.GT.0) GO TO 60
         IF (LDEBUG.GT.0) THEN
            WRITE (IOSDBG,930) STRNG2
            CALL SULINE (IOSDBG,1)
            ENDIF
         GO TO 330
C
C  INVALID DUMP OPTION
60    IF (NFLD.EQ.1.AND.ISNWPG(LP).EQ.0.AND.IOPNWP.EQ.1) CALL SUPAGE
      IF (NFLD.EQ.1) CALL SUPCRD
      WRITE (LP,840) STRNG(1:LENSTR(STRNG))
      CALL SUERRS (LP,2,NUMERR)
      ILPFND=0
      GO TO 10
C
70    IF (NFLD.EQ.1) THEN
         IF (ISNWPG(LP).EQ.0.AND.IOPNWP.EQ.1) CALL SUPAGE
         IF (NFLD.EQ.1) CALL SUPCRD
         ENDIF
C
      ILPFND=0
      IRPFND=0
C
      GO TO (90,90,90,110,
     *       130,150,170,190,
     *       210,240,260,270,
     *       90,290,80,80),IOPTN
80       WRITE (LP,890) STRNG(1:LENSTR(STRNG))
         CALL SUERRS (LP,2,NUMERR)
         GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SET DUMP TYPE
C
90    CALL SUBSTR (STRNG2,1,LEN(XTYPE),XTYPE,1)
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,920) XTYPE
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      IF (XTYPE.EQ.OPTN(1)) GO TO 10
      IF (XTYPE.EQ.OPTN(13)) GO TO 10
C
      IF (XTYPE.EQ.OPTN(3)) GO TO 100
C
C  CHECK IF SUMMARY OPTION SPECIFIED
      IF (SUMARY.EQ.'YES') THEN
         SUMARY='NO'
         WRITE (LP,730) OPTN(2),SUMARY
         CALL SUWRNS (LP,2,NUMWRN)
         ENDIF
C
C  CHECK IF PUNCH UNITS IS ALLOCATED
100   DDNAME=' '
      NUNIT=ICDPUN
      IPRERR=0
      CALL UDDNST (DDNAME,NUNIT,IPRERR,IERR)
      IF (IERR.GT.0) THEN
         IF (IERR.NE.3) THEN
            WRITE (LP,740) ICDPUN,LP
            CALL SUWRNS (LP,2,NUMWRN)
            ICDPUN=LP
            ENDIF
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  PLOT OPTION
C
110   IF (LLPAR.EQ.0) THEN
         STRNG2='YES'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 120
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'YES'.OR.STRNG2.EQ.'NO') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
120   PLOT=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,810) OPTN(IOPTN),PLOT
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  UNITS OPTION
C
130   IF (LLPAR.EQ.0) THEN
         STRNG2='ENGL'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 140
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'ENGL'.OR.STRNG2.EQ.'METR') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
140   UNITS=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,810) OPTN(IOPTN),UNITS
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SUMMARY OPTION
C
150   IF (LLPAR.EQ.0) THEN
         STRNG2='YES'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 160
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'YES'.OR.STRNG2.EQ.'NO') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
160   SUMARY=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,810) OPTN(IOPTN),SUMARY
         CALL SULINE (IOSDBG,1)
         ENDIF
C
C  CHECK IF DUMP TYPE OF PUNCH SPECIFIED
      IF (XTYPE.NE.OPTN(2)) GO TO 10
         SUMARY='NO'
         WRITE (LP,730) OPTN(2),SUMARY
         CALL SUWRNS (LP,2,NUMWRN)
         GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SORT OPTION
C
170   IF (LLPAR.EQ.0) THEN
         STRNG2='ID'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 180
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'ID'.OR.
     *    STRNG2.EQ.'DESC'.OR.
     *    STRNG2.EQ.'NUM'.OR.
     *    STRNG2.EQ.'NO') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
180   CALL UREPET (' ',SORT,LEN(SORT))
      SORT=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,810) OPTN(IOPTN),SORT
         CALL SULINE (IOSDBG,1)
         ENDIF
      IF (SORT.EQ.'NUM'.AND.ISUPRT('NUM').EQ.0) THEN
         SORT='ID'
         WRITE (LP,750) STRNG2(1:LENSTR(STRNG2)),SORT
         CALL SUWRNS (LP,2,NUMWRN)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  PRNTEST OPTION
C
190   IF (LLPAR.EQ.0) THEN
         STRNG2='YES'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 200
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'YES'.OR.STRNG2.EQ.'NO') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
200   PREST=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,850) OPTN(IOPTN),PREST
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  LEVEL OPTION
C
210   IF (LLPAR.EQ.0) THEN
         INTEGR=1
         WRITE (LP,790) OPTN(IOPTN),INTEGR
         CALL SUWRNS (LP,2,NUMWRN)
         GO TO 220
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFINFX (INTEGR,ISTRT,LLPAR+1,LRPAR-1,IERR)
220   IF (INTEGR.GE.1.AND.INTEGR.LE.2) GO TO 230
         WRITE (LP,870) INTEGR
         CALL SUERRS (LP,2,NUMERR)
         GO TO 10
230   LEVEL=INTEGR
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,800) OPTN(IOPTN),LEVEL
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  DEGMIN OPTION
C
240   IF (LLPAR.EQ.0) THEN
         STRNG2='YES'
         WRITE (LP,770) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
         CALL SULINE (LP,2)
         GO TO 250
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG2,STRNG2,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG2.EQ.'YES'.OR.STRNG2.EQ.'NO') THEN
         ELSE
            WRITE (LP,850) OPTN(IOPTN),STRNG2(1:LENSTR(STRNG2))
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
250   DEGMIN=STRNG2
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,810) OPTN(IOPTN),DEGMIN
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SPACING OPTION
C
260   WRITE (LP,880) OPTN(IOPTN),OPTN(IOPTN+1)
      CALL SULINE (LP,2)
C
C  SPACING OPTION
C
270   IF (LLPAR.EQ.0) THEN
         STRNG28='SINGLE'
         WRITE (LP,780) OPTN(IOPTN),STRNG28
         CALL SULINE (LP,2)
         GO TO 280
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG28,STRNG28,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG28.EQ.'SINGLE'.OR.STRNG28.EQ.'DOUBLE') THEN
        ELSE
            WRITE (LP,860) OPTN(IOPTN),STRNG28
            CALL SUERRS (LP,2,NUMERR)
            GO TO 10
         ENDIF
280   IF (STRNG28.EQ.'SINGLE') NSPACE=0
      IF (STRNG28.EQ.'DOUBLE') NSPACE=1
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,820) OPTN(IOPTN),STRNG28
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  TYPE OPTION
C
290   IF (LLPAR.EQ.0) THEN
         STRNG28='PRINT'
         WRITE (LP,780) OPTN(IOPTN),STRNG28
         CALL SULINE (LP,2)
         GO TO 300
         ENDIF
      IF (LRPAR.GT.0) IRPFND=1
      IF (LRPAR.EQ.0) THEN
         WRITE (LP,760) NFLD
         CALL SULINE (LP,2)
         LRPAR=LENGTH+1
         ENDIF
      CALL UFPACK (LSTRNG28,STRNG28,ISTRT,LLPAR+1,LRPAR-1,IERR)
      IF (STRNG28.EQ.OPTN(1).OR.
     *    STRNG28.EQ.OPTN(2).OR.
     *    STRNG28.EQ.OPTN(3).OR.
     *    STRNG28.EQ.OPTN(13)) GO TO 300
         WRITE (LP,860) OPTN(IOPTN),STRNG28
         CALL SUERRS (LP,2,NUMERR)
         GO TO 10
300   IF (STRNG28.EQ.OPTN(1).OR.
     *    STRNG28.EQ.OPTN(2).OR.
     *    STRNG28.EQ.OPTN(3).OR.
     *    STRNG28.EQ.OPTN(13)) GO TO 310
         WRITE (LP,860) OPTN(IOPTN),STRNG28
         CALL SUERRS (LP,2,NUMERR)
         GO TO 10
310   CALL SUBSTR (STRNG28,1,LEN(XTYPE),XTYPE,1)
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,820) OPTN(IOPTN),STRNG28
         CALL SULINE (IOSDBG,1)
         ENDIF
      GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  END OF DUMP COMMAND INPUT
320   IF (NUMOPT.GT.0) GO TO 700
      IENDIN=1
C
C  CHECK WHICH PARAMETER TYPE IS TO BE DUMPED
330   IF (LGROUP.GT.0) GO TO 340
         IF (NFLD.EQ.1.AND.ISNWPG(LP).EQ.0.AND.IOPNWP.EQ.1) CALL SUPAGE
         IF (NFLD.EQ.1) CALL SUPCRD
         WRITE (LP,940) STRNG(1:LENSTR(STRNG))
         CALL SUWRNS (LP,2,NUMWRN)
         IF (IENDIN.EQ.1) GO TO 700
         GO TO 10
C
340   IF (LGROUP.EQ.30) GO TO 350
C
C  PRINT OPTIONS IN EFFECT
      CALL UREPET ('?',XSORT,LEN(XSORT))
      IF (SORT.EQ.'ID') XSORT=SORT
      IF (SORT.EQ.'DESC') XSORT=SORT
      IF (SORT.EQ.'NUM') XSORT=SORT
      IF (SORT.EQ.'NO') XSORT=SORT
      CALL UREPET ('?',XSPACE,LEN(XSPACE))
      IF (NSPACE.EQ.0) XSPACE='SINGLE'
      IF (NSPACE.EQ.1) XSPACE='DOUBLE'
      IF (ISLEFT(5).GT.0) CALL SUPAGE
      WRITE (LP,950)
     *  DEGMIN,
     *  LEVEL,
     *  PLOT,
     *  PREST,
     *  XSORT,
     *  XSPACE,
     *  SUMARY,
     *  XTYPE,
     *  UNITS
      CALL SULINE (LP,3)
C
350   IF (LRPAR.GT.0) IRPFND=1
C
C  WRITE TO PROGRAM LOG
      NPAGE=0
      ISTART=1
      CALL SUWLOG ('OPTN',GROUP(LGROUP),BLNK8,NPAGE,ISTART,IERR)
C
      GO TO (370,380,390,390,400,410,420,430,440,450,
     *       460,360,360,480,490,500,510,520,530,540,
     *       550,560,570,580,590,600,610,620,630,640,
     *       650,660,670),LGROUP
360      WRITE (LP,890) GROUP(LGROUP)
         CALL SULINE (LP,2)
         GO TO 10
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  DUMP AREA
370   CALL SMAREA (LARRAY,ARRAY,ZTYPE,UNITS,SUMARY,PLOT,SORT,
     *   NSPACE,NFLD,IERR)
      GO TO 680
C
C  DUMP BASIN
380   CALL SMBASN (LARRAY,ARRAY,ZTYPE,UNITS,SUMARY,PLOT,SORT,
     *   NSPACE,NFLD,IERR)
      GO TO 680
C
C  DUMP STATION
390   CALL SMSTA (LARRAY,ARRAY,XTYPE,UNITS,SUMARY,SORT,PREST,LEVEL,
     *   DEGMIN,NSPACE,NFLD,IERR)
      GO TO 680
C
C  DUMP USER
400   CALL SMUSER (LARRAY,ARRAY,ZTYPE,UNITS,NFLD,IERR)
      GO TO 680
C
C  DUMP NAMES
410   CALL SMNAME (LARRAY,ARRAY,ZTYPE,SORT,NFLD,IERR)
      GO TO 680
C
C  DUMP ORDER
420   CALL SMORDR (LARRAY,ARRAY,ZTYPE,LEVEL,NFLD,IERR)
      GO TO 680
C
C  DUMP NETWORK
430   CALL SMNTWK (LARRAY,ARRAY,LEVEL,NFLD,IERR)
      GO TO 680
C
C  DUMP PARAMETERS
440   CALL SSPPP2 (LARRAY,ARRAY,LEVEL,IERR)
      GO TO 690
C
C  DUMP PARAMETER ARRAY CONTENTS
450   CALL SMARAY (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP PREPROCESSOR DATA BASE POINTERS
460   PDTYPE=' '
      CALL SMPPDP (LARRAY*2,ARRAY,NFLD,PDTYPE,NDELTP,NDELTD,IERR)
      GO TO 680
C
C  DUMP FORECAST COMPONENT TIME SERIES IDENTIFIERS
480   CALL SMFCID (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP PREPROCESSOR DATA BASE INDEX
490   CALL SMPPDI (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP PARAMETRIC DATA BASE INDEX
500   CALL SMPPPI (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP PROCESSED DATA BASE INDEX
510   CALL SMPRDI (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP USER DEFAULTS
520   CALL SMDFLT (LARRAY,ARRAY,IERR)
      GO TO 690
C
C  DUMP PARAMETRIC RECORDS
530   CALL SMPPPT (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP STATISTICS
540   CALL SMSTAT (LARRAY,ARRAY,SUMARY,SORT,NFLD,IERR)
      GO TO 680
C
C  DUMP STATION CHARACTERISTICS
550   CALL SMCHAR (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP STATION MEAN MONTHLY MAX/MIN TEMPERATURES
560   CALL SMMMMT (LARRAY,ARRAY,NFLD,IERR)
      GO TO 680
C
C  DUMP GRID BOX PARAMETERS
570   CALL SMGBOX (LARRAY,ARRAY,ZTYPE,SUMARY,SORT,NFLD,IERR)
      GO TO 680
C
C  DUMP RAINFALL-RUNNOFF PARAMETERS
580   CALL SMRFRO (LARRAY,ARRAY,ZTYPE,SUMARY,SORT,NFLD,IERR)
      GO TO 680
C
C  DUMP PREPROCESSOR DATA BASE CONTROLS
590   CALL SMPPDC (IERR)
      GO TO 690
C
C  DUMP MDRGRID PARAMETERS
600   CALL SMGMDR (LARRAY,ARRAY,IERR)
      GO TO 690
C
C  DUMP FILECRAT CARDS
610   CALL SMFCRT (IERR)
      GO TO 690
C
C  DUMP DATASET ATTRIBUTES
620   NUNIT1=1
      NUNIT2=99
      DDNAME=' '
      IPRHDR=1
      IROUND=0
      CALL UDDTBL (NUNIT1,NUNIT2,DDNAME,IPRHDR,IROUND,LBUFRS,LP,IERR)
      GO TO 690
C
C  DUMP PREPROCESSOR PARAMETRIC DATA BASE INDEX RECORD
630   CALL SMPPFN (NFLD,IERR)
      GO TO 680
C
C  OUTPUT CARD IMAGES
640   CALL SUOPUT (NFLD,LSTRNG,STRNG,LSTRNG2,STRNG2,ZTYPE,IERR)
      GO TO 680
C
C  DUMP PREPROCESSOR DATA BASE INDEX RECORD
650   CALL SMPDFN (NFLD,IERR)
      GO TO 680
C
C  DUMP TIMES SERIES HEADER RECORDS
660   CALL SMTSHD (NFLD,IERR)
      GO TO 680
C
C  DUMP PARAMETRIC DATA BASE POINTERS
670   CALL SMPPPP (LARRAY,ARRAY,IERR)
      GO TO 690
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  SET INDICATOR TO REREAD CURRENT FIELD
680   ISTRT=-1
C
C  LAST FIELD READ WAS NOT A GROUP
690   ICFGRP=0
C
      NUMOPT=NUMOPT+1
C
C  WRITE TO PROGRAM LOG
      NPAGE=0
      ISTART=0
      CALL SUWLOG ('OPTN',GROUP(LGROUP),BLNK8,NPAGE,ISTART,IERR)
C
C  CHECK FOR END OF DUMP COMMAND INPUT
      IF (NFLD.EQ.-1) IENDIN=1
      IF (IENDIN.EQ.1) GO TO 700
C
      LGROUP=0
      GO TO 10
C
C  CHECK IF NO OPTIONS SPECIFIED
700   IF (NUMOPT.GT.0) GO TO 710
         WRITE (LP,960)
         CALL SUWRNS (LP,2,NUMWRN)
C
710   IF (ISTRCE.GT.0) THEN
         WRITE (IOSDBG,*) 'EXIT SMDUMP'
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
730   FORMAT ('0*** WARNING - SUMMARY OPTION CANNOT BE SPECIFIED IF ',
     *   'DUMP TYPE IS ',A,'. SUMMARY OPTION SET TO ',A,'.')
740   FORMAT ('0*** WARNING - PUNCH UNIT (',I2,') IS NOT ALLOCATED. ',
     *   'CARD IMAGES WILL BE WRITTEN TO PRINT UNIT (',I2,').')
750   FORMAT ('0*** WARNING - SORT OPTION BY ',A,' IS NOT CURRENTLY ',
     *   'AVAILABLE. SORT BY ',A,' WILL BE USED.')
760   FORMAT ('0*** NOTE - RIGHT PARENTHESIS ASSUMED IN FIELD ',I2,
     *   '.')
770   FORMAT ('0*** NOTE - NO LEFT PARENTHESIS FOUND. ',A,' OPTION ',
     *   'SET TO ',A,'.')
780   FORMAT ('0*** NOTE - NO LEFT PARENTHESIS FOUND. ',A,' OPTION ',
     *   'SET TO ',A,'.')
790   FORMAT ('0*** NOTE - NO LEFT PARENTHESIS FOUND. ',A,' OPTION ',
     *   'SET TO ',I1,'.')
800   FORMAT (' ',A,' OPTION SET TO ',I4)
810   FORMAT (' ',A,' OPTION SET TO ',A)
820   FORMAT (' ',A,' OPTION SET TO ',A)
830   FORMAT ('0*** WARNING - THE GROUP  ',A,'  WAS FOUND WHEN ',
     *   'ANOTHER GROUP (',A,') WAS JUST SPECIFIED.')
840   FORMAT ('0*** ERROR - INVALID DUMP OPTION : ',A)
850   FORMAT ('0*** ERROR - INVALID ',A,' CODE : ',A)
860   FORMAT ('0*** ERROR - INVALID ',A,' CODE : ',A)
870   FORMAT ('0*** ERROR - INVALID LEVEL VALUE : ',I2,'. VALID ',
     *   'VALUES ARE 1 OR 2.')
880   FORMAT ('0*** NOTE - ',A,' OPTION NO LONGER VALID. ',
     *   A,' OPTION ASSUMED.')
890   FORMAT ('0*** ERROR - ERROR PROCESSING OPTION : ',A)
900   FORMAT (' BLANK STRING FOUND IN FIELD ',I2)
910   FORMAT (' GROUP=',A,3X,'INDOPT=',I2)
920   FORMAT (' DUMP TYPE IS ',A)
930   FORMAT (' INPUT FIELD = ',A)
940   FORMAT ('0*** WARNING - NO GROUP NAME SPECIFIED BEFORE KEYWORD ',
     *   A,' FOUND.')
950   FORMAT ('0DUMP OPTIONS IN EFFECT : ',
     *   'DEGMIN=',A,3X,
     *   'LEVEL=',I1,3X,
     *   'PLOT=',A,3X,
     *   'PRNTEST=',A,3X,
     *   'SORT=',A,3X,
     *   'SPACING=',A,3X,
     *   'SUMMARY=',A,3X,
     *   / T27,
     *   'TYPE=',A,3X,
     *   'UNITS=',A,3X)
960   FORMAT ('0*** WARNING - NO DUMP OPTIONS FOUND.')
C
      END