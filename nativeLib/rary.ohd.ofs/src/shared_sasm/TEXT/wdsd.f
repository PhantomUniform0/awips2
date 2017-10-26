C MODULE WDSD
C----------------------------------------------------------------------
C
C  ROUTINE TO DELETE A STATION IN THE SASM CONTROL FILE.
C
      SUBROUTINE WDSD (USERID,PPDBID,ISTAT)
C
C
      CHARACTER*8 USERID,PPDBID
      CHARACTER*8 USERIDX,PPDBIDX,SAIDX,SMIDX
      CHARACTER*20 DESCRP
      CHARACTER*128 FILENAME
C
      INCLUDE 'uio'
      INCLUDE 'udebug'
      INCLUDE 'dscommon/dsunts'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/shared_sasm/RCS/wdsd.f,v $
     . $',                                                             '
     .$Id: wdsd.f,v 1.2 1998/04/07 18:40:37 page Exp $
     . $' /
C    ===================================================================
C
C
C
      ISTAT=0
C
      IF (IDETR.GT.0 ) WRITE (IOGDB,10)
10    FORMAT (' *** ENTER WDSD')
C
C  OPEN FILE
      IOPEN=2
      CALL UDOPEN (KDSRCF,IOPEN,FILENAME,LRECL,IERR)
      IF (IERR.NE.0) THEN
         WRITE (LP,20) FILENAME(1:LENSTR(FILENAME))
20    FORMAT ('0*** ERROR - IN WDSD - CANNOT OPEN FILE ',A,'.')
         ISTAT=1
         GO TO 180
         ENDIF
C
C  READ NUMBER OF ENTRIES
      READ (KDSRCF,REC=1,ERR=60) NHEAD
      IF (NHEAD.GT.0) GO TO 80
         WRITE (LP,50) FILENAME(1:LENSTR(FILENAME))
50    FORMAT ('0*** NOTE - IN WDSD - NO STATIONS EXIST IN FILE ',A,'.')
         ISTAT=2
         GO TO 170
60     WRITE (LP,70) FILENAME(1:LENSTR(FILENAME))
70     FORMAT ('0*** ERROR - IN WDSD - BAD READ IN FILE ',A,'.')
       ISTAT=1
       GO TO 170
C
C  SEARCH FILE FOR STATION
80    NHEAD=NHEAD+1
      DO 90 NHD=2,NHEAD
         READ (KDSRCF,REC=NHD,ERR=110) USERIDX,SAIDX,SMIDX,
     *      PPDBIDX,DESCRP,STALAT,IDTPP,IDTTA,IPE,ISD,ISW
         IF (USERIDX.EQ.USERID.AND.PPDBIDX.EQ.PPDBID) GO TO 130
90       CONTINUE
      IF (IDEDB.GT.0) WRITE (IOGDB,100) PPDBID,
     *   FILENAME(1:LENSTR(FILENAME))
100    FORMAT (' PPDBID ',A,' NOT FOUND IN FILE ',A)
       ISTAT=3
       GO TO 170
110    WRITE (LP,120) FILENAME(1:LENSTR(FILENAME))
120    FORMAT ('0*** ERROR - IN WDSD - BAD READ OR EOF IN FILE ',A,'.')
       ISTAT=1
       GO TO 170
C
C  DELETE STATION
130   PPDBIDX='*DELETED'
      WRITE (KDSRCF,REC=NHD,ERR=150) USERIDX,SAIDX,SMIDX,PPDBIDX,
     *   DESCRP,STALAT,IDTPP,IDTTA,IPE,ISD,ISW
      IF (IDEDB.GT.0) WRITE (IOGDB,140) PPDBID,NHD,
     *    FILENAME(1:LENSTR(FILENAME))
140   FORMAT (' PPDBID ',A,' DELETED AT RECORD',I5,' IN ',A)
      GO TO 170
150   WRITE (LP,160) FILENAME(1:LENSTR(FILENAME))
160   FORMAT ('0*** ERROR - IN WDSD - BAD WRITE TO FILE ',A,'.')
      ISTAT=1
C
C  CLOSE FILE
170   CALL UPCLOS (KDSRCF,' ',IERR)
C
180   IF (IDETR.GT.0) WRITE (IOGDB,190)
190   FORMAT (' *** EXIT WDSD')
C
      RETURN
C
      END