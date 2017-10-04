C MODULE UROE24
C-----------------------------------------------------------------------
C
      SUBROUTINE UROE24 (LARRAY,ARRAY,LPNTRS,IPNTRS,LPEA24,IPEA24,
     *   ISTAT)
C
C    THIS ROUTINE REORDERS THE PE PARAMETRIC RECORDS BASED
C    ON THE ALPHABETICALLY ORDERED LIST OF PE STATIONS STORED
C    IN THE PREPROCESSOR PARAMETRIC DATA BASE PARAMETER TYPE OE24.
C
C    IF THE OE24 RECORD DOES NOT EXIST THE RECORDS WILL BE COPIED IN
C    THE PRESENT ORDER TO THE NEW FILES.
C
C    ARGUMENT LIST:
C
C       NAME     TYPE   I/O  DIM     DESCRIPTION
C       ------   ----   ---  ------  -----------
C       LARRAY    I*4    I     1     LENGTH OF ARRAY
C       ARRAY     I*4   I/O  LARRAY  PARAMETER RECORD ARRAY
C       LPNTRS    I*4    I     1     LENGTH OF IPNTRS
C       IPNTRS    I*2   I/O  LPNTRS  OLD FILE POINTERS
C       LPEA24    I*4    I     1     LENGTH OF IPEA24
C       IPEA24    I*2   I/O  LPEA24  OE24 PARAMETER RECORD
C       ISTAT     I*4    I     1     STATUS CODE:
C                                      0=NORMAL RETURN
C                                      OTHER=ERROR
C
      CHARACTER*4 XDISP,PTYPE
      CHARACTER*8 PARMID,STAID
C
      DIMENSION ARRAY(LARRAY)
      DIMENSION IDATES(1)
      INTEGER*2 IPNTRS(LPNTRS),IPEA24(LPEA24)
      INTEGER*2 MSNG
C
      INCLUDE 'uiox'
      INCLUDE 'udebug'
      INCLUDE 'udatas'
      INCLUDE 'ucommon/uordrx'
      INCLUDE 'urcommon/urcdta'
      INCLUDE 'urcommon/urppdt'
      INCLUDE 'pppcommon/ppdtdr'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/reorder/RCS/uroe24.f,v $
     . $',                                                             '
     .$Id: uroe24.f,v 1.2 2001/06/13 14:09:14 dws Exp $
     . $' /
C    ===================================================================
C
C
      IF (IPPTR.GT.0) THEN
         CALL SULINE (IOGDB,1)
         WRITE (IOGDB,*) 'ENTER UROE24'
         ENDIF
C
      ISTAT=0
      LDATA=1
      LENDAT=1
C
      CALL SULINE (LP,2)
      WRITE (LP,300)
C
C  FIND TYPE IN OLD DIRECTORY
      XDISP='OLD'
      PTYPE='PE'
      IAMORD=0
      IDXOLD=IPCKDT(PTYPE)
      IF (IDXOLD.GT.0) GO TO 10
         WRITE (LP,310) PTYPE,XDISP
         CALL SUERRS (LP,2,-1)
         GO TO 240
C
C  CHECK NUMBER OF PARAMETER RECORDS DEFINED
10    IF (IPDTDR(5,IDXOLD).GT.0) GO TO 20
         WRITE (LP,290)
         CALL SULINE (LP,2)
         GO TO 270
C
C  FIND TYPE IN NEW DIRECTORY
20    XDISP='NEW'
      IAMORD=1
      IDXNEW=IPCKDT(PTYPE)
      IF (IDXNEW.GT.0) GO TO 30
         WRITE (LP,310) PTYPE,XDISP
         CALL SUERRS (LP,2,-1)
         GO TO 240
C
C  GET PARAMETER RECORDS FOR TYPE OE24
30    PARMID=' '
      PTYPE='OE24'
      IPTR=0
      IAMORD=0
      CALL RPPREC (PARMID,PTYPE,IPTR,LPEA24,IPEA24,NFILL,IPTRNX,ISTAT)
      IF (ISTAT.EQ.0) GO TO 80
      IF (ISTAT.EQ.2.OR.ISTAT.EQ.4) GO TO 40
         CALL SRPPST (PARMID,PTYPE,IPTR,LPEA24,NFILL,IPTRNX,ISTAT)
         GO TO 240
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  OE24 RECORDS NOT FOUND - PE RECORDS WILL BE COPIED
40    CALL SULINE (LP,2)
      WRITE (LP,320)
C
50    PTYPE='PE'
      CALL URCPYR (PTYPE,LARRAY,ARRAY,
     *   1,DMARR1,1,DMARR2,1,DMARR3,1,DMARR4,ISTAT)
      IF (IWURFL.NE.0.OR.ISTAT.NE.0) GO TO 240
C
C  READ DAILY DATA RECORD FOR OE24 TO GET POINTER ARRAY FOR 24 HR DATA
      PTYPE='EA24'
      IRDATE=0
      CALL RPDFIL (PTYPE,IRDATE,LPFIL,LDFIL,ISTAT)
      IF (ISTAT.EQ.0) THEN
         IF (LPFIL.GT.LPNTRS) THEN
            WRITE (LP,330) PTYPE,LPNTRS,LPFIL
            CALL SUERRS (LP,2,-1)
            IERR=1
            GO TO 240
            ENDIF
         ENDIF
      IRETRN=2
      IF (IPPDB.GT.0) THEN
         CALL SULINE (IOGDB,1)
         WRITE (IOGDB,*) 'ISTAT=',ISTAT,
     *      ' PTYPE=',PTYPE,
     *      ' IRDATE=',IRDATE,
     *      ' IRETRN=',IRETRN
         ENDIF
      CALL RPDDLY (PTYPE,IRDATE,IRETRN,LPNTRS,IPNTRS,LPFIL,LDATA,IDATA,
     *   LDFILL,NUMSTA,MSNG,LENDAT,IDATES,ISTAT)
      IF (ISTAT.EQ.0) GO TO 70
      GO TO (160,70,160,70,180,200,70,220),ISTAT
C
C  WRITE POINTERS
70    CALL URWPTR (PTYPE,IPNTRS,ISTAT)
      IF (ISTAT.NE.0) GO TO 240
      CALL SULINE (LP,2)
      WRITE (LP,340) JPDTDR(5,IDXNEW)
      WRITE (LP,340)
      GO TO 270
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  REORDER PE PARAMETER RECORDS FOR STATIONS WITH 24 HOUR DATA
C
C  READ DAILY DATA RECORD FOR OE24 TO GET POINTER ARRAY FOR 24 HR DATA
80    PTYPE='EA24'
      IRDATE=0
      IRETRN=2
      CALL RPDDLY (PTYPE,IRDATE,IRETRN,LPNTRS,IPNTRS,LPFIL,LDATA,IDATA,
     *   LDFILL,NUMSTA,MSNG,LENDAT,IDATES,ISTAT)
      IF (ISTAT.EQ.0) GO TO 90
      GO TO (160,90,160,90,180,200,90,220),ISTAT
C
C  CHECK NUMBER OF STATIONS
90    CALL UMEMOV (IPEA24(9),REAL,1)
      NUMSTA=REAL
      IF (NUMSTA.GT.0) GO TO 100
         CALL SULINE (LP,2)
         WRITE (LP,350)
         GO TO 50
C
C  SET PE PARAMETER RECORD NUMBER
100   DO 110 I=1,LPFIL
         IPNTRS(I)=-IPNTRS(I)
110      CONTINUE
C
      IF (IPPDB.GT.0) THEN
         CALL SULINE (IOGDB,1)
         WRITE (IOGDB,*) 'NUMSTA=',NUMSTA
         ENDIF
C
C  PROCESS EACH STATION
      IPOS=11
      PTYPE='PE'
      DO 140 I=1,NUMSTA
         IE24PT=IPEA24(IPOS)
C     GET PE PARAMETER NUMBER RECORD FROM POINTER ARRAY USING
C     SUBSCRIPT FROM OE24 RECORD.
         NREC=IPNTRS(IE24PT)
         NREC=IABS(NREC)
         IF (NREC.LE.0) GO TO 140
         IAMORD=0
         STAID=' '
         CALL RPPREC (STAID,PTYPE,NREC,LARRAY,ARRAY,NUMFIL,IPTRNX,
     *      ISTAT)
         IF (ISTAT.EQ.0) GO TO 120
            CALL SRPPST (STAID,PTYPE,NREC,LARRAY,NUMFIL,IPTRNX,ISTAT)
            GO TO 240
C     WRITE THE PARAMETER RECORD TO THE NEW FILE
120      IAMORD=1
         IRECNW=0
         CALL WPPREC (STAID,PTYPE,NUMFIL,ARRAY,IRECNW,ISTAT)
         IF (ISTAT.NE.0) GO TO 240
C     UPDATE RECORD NUMBER IN THE GENL PARAMETER RECORD
         IAMORD=0
         CALL URUDGL (STAID,PTYPE,IRECNW,LARRAY,ARRAY,ISTAT)
         IF (ISTAT.NE.0) THEN
            IF (ISTAT.EQ.1) GO TO 240
            GO TO 130
            ENDIF
         IPNTRS(IE24PT)=IRECNW
130      IPOS=IPOS+1
140      CONTINUE
C
C  WRITE POINTER ARRAY
      PTYPE='EA24'
      CALL URWPTR (PTYPE,IPNTRS,ISTAT)
      IF (ISTAT.NE.0) GO TO 240
      GO TO 260
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
160   WRITE (LP,170) LPNTRS,PTYPE
      CALL SUERRS (LP,2,-1)
170   FORMAT ('0*** ERROR - IN UROE24 - SIZE OF POINTER ARRAY (',I6,
     *   ') TOO SMALL FOR DAILY DATA TYPE ',A,'.')
      GO TO 240
C
180   WRITE (LP,190) PTYPE
      CALL SUERRS (LP,2,-1)
190   FORMAT ('0*** ERROR - IN UROE24 -  ',A,' IS AN INVALID DAILY ',
     *   'DATA TYPE.')
      GO TO 240
C
200   CALL SULINE (LP,2)
      WRITE (LP,210) PTYPE
210   FORMAT ('0*** NOTE - NO STATIONS DEFINED FOR TYPE ',A,
     *   ' IN PREPROCESSOR DATA BASE.')
      GO TO 270
C
220   WRITE (LP,230) ISTAT
      CALL SUERRS (LP,2,-1)
230   FORMAT ('0*** ERROR - IN UROE24 - SYSTEM ERROR FROM RPDDLY. ',
     *   'ISTAT=',I3)
C
C  SET ERROR FLAG
240   IWURFL=1
C
      CALL SULINE (LP,2)
      WRITE (LP,250)
250   FORMAT ('0*** NOTE - ERRORS HAVE OCCURRED IN THE REORDER OF PE ',
     *   'PARAMETER RECORDS.')
      GO TO 270
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
260   CALL SULINE (LP,2)
      WRITE (LP,360) JPDTDR(5,IDXNEW)
      GO TO 270
C
270   IF (IPPTR.GT.0) THEN
         CALL SULINE (IOGDB,1)
         WRITE (IOGDB,*) 'EXIT UROE24'
         ENDIF
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
290   FORMAT ('0*** NOTE - PE PARAMETER RECORDS ARE NOT DEFINED ON ',
     *   'FILES.')
300   FORMAT ('0*** NOTE - BEGIN TO REORDER  << PE PARAMETER >>  ',
     *   'RECORDS.')
310   FORMAT ('0*** ERROR - IN UROE24 - TYPE ',A,' NOT FOUND IN ',
     *   A,' PREPROCESSOR PARAMETRIC DATA BASE DIRECTORY.')
320   FORMAT ('0*** NOTE - PARAMETER TYPE OE24 NOT FOUND. PE ',
     *   'PARAMETER RECORDS WILL BE COPIED AND NOT REORDERED.')
330   FORMAT ('0*** ERROR - IN URCPYR - ARRAY TO HOLD POINTERS FOR ',
     *   'DATA TYPE ',A,' TOO SMALL. ',I5,' AVAILABLE. ',
     *   I5,' NEEDED.')
340   FORMAT ('0*** NOTE - ',I4,' PE   PARAMETER RECORDS HAVE BEEN ',
     *   'SUCCESSFULLY COPIED.')
350   FORMAT ('0*** NOTE - NO STATIONS DEFINED IN OE24 RECORD. PE ',
     *   'RECORDS WILL NOT BE REORDERED JUST COPIED.')
360   FORMAT ('0*** NOTE - ',I4,' PE   PARAMETER RECORDS HAVE BEEN ',
     *   'SUCCESSFULLY REORDERED.')
C
      END