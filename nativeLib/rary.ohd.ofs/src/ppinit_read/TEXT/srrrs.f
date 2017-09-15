C MODULE SRRRS
C-----------------------------------------------------------------------
C
C  ROUTINE TO READ STATION RRS PARAMETERS.
C
      SUBROUTINE SRRRS (IVRRS,STAID,NBRSTA,DESCRP,STATE,
     *   NRRSTP,NMISS,NDIST,RRSTYP,URMISS,IRTIME,NVLPOB,
     *   MNODAY,NUMOBS,ITSREC,INTERP,EXTRAP,FLOMIN,FRACT,
     *   UNUSED,LARRAY,ARRAY,IPTR,IPRERR,IPTRNX,IREAD,ISTAT)
C
      DIMENSION ARRAY(LARRAY)
      DIMENSION UNUSED(1)
C
      INCLUDE 'scommon/dimsta'
      INCLUDE 'scommon/dimrrs'
C
      INCLUDE 'uio'
      INCLUDE 'scommon/sudbgx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_read/RCS/srrrs.f,v $
     . $',                                                             '
     .$Id: srrrs.f,v 1.3 2000/12/18 21:34:07 dws Exp $
     . $' /
C    ===================================================================
C
C
      IF (ISTRCE.GT.1) THEN
         WRITE (IOSDBG,*) 'ENTER SRRRS'
         CALL SULINE (IOSDBG,1)
         ENDIF
C
C  SET DEBUG LEVEL
      LDEBUG=ISBUG('RRS ')
C
      IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,*) 'LARRAY=',LARRAY
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      ISTAT=0
C
      IF (IREAD.EQ.0) GO TO 10
C
C  OPEN DATA BASE
      CALL SUDOPN (1,'PPP ',IERR)
      IF (IERR.NE.0) THEN
         ISTAT=1
         GO TO 180
         ENDIF
C
C  READ PARAMETER RECORD
      CALL RPPREC (STAID,'RRS ',IPTR,LARRAY,ARRAY,NFILL,IPTRNX,IERR)
      IF (IERR.NE.0) THEN
         ISTAT=IERR
         IF (ISTAT.EQ.6) GO TO 180
         IF (IPRERR.GT.0) THEN
            CALL SRPPST (STAID,'RRS ',IPTR,LARRAY,NFILL,IPTRNX,IERR)
            ENDIF
         GO TO 180
         ENDIF
C
10    NPOS=0
C
C  SET PARAMETER ARRAY VERSION NUMBER
      NPOS=NPOS+1
      IVRRS=ARRAY(1)
C
C  SET STATION IDENTIFIER
      NCHAR=4
      NWORDS=LEN(STAID)/NCHAR
      NCHK=2
      IF (NWORDS.NE.NCHK) THEN
         WRITE (LP,200) 'STAID',NWORDS,NCHK,STAID
         CALL SUERRS (LP,2,-1)
         ISTAT=1
         GO TO 180
         ENDIF
      DO 20 I=1,NWORDS
         NPOS=NPOS+1
         N=(I-1)*NCHAR+1
         CALL SUBSTR (ARRAY(NPOS),1,4,STAID(N:N),1)
20       CONTINUE
C
C  SET USER SPECIFIED STATION NUMBER
      NPOS=NPOS+1
      NBRSTA=ARRAY(NPOS)
C
C  SET DESCRIPTIVE INFORMATION
      NCHAR=4
      NWORDS=LEN(DESCRP)/NCHAR
      NCHK=5
      IF (NWORDS.NE.NCHK) THEN
         WRITE (LP,200) 'DESCRP',NWORDS,NCHK,STAID
         CALL SUERRS (LP,2,-1)
         ISTAT=1
         GO TO 180
         ENDIF
      DO 30 I=1,NWORDS
         NPOS=NPOS+1
         N=(I-1)*NCHAR+1
         CALL SUBSTR (ARRAY(NPOS),1,NCHAR,DESCRP(N:N),1)
30       CONTINUE
C
C  SET STATE IDENTIFIER
      NPOS=NPOS+1
      STATE=ARRAY(NPOS)
C
C  THE NEXT POSITION IS UNUSED
      NPOS=NPOS+1
      UNUSED(I)=ARRAY(NPOS)
C
C  SET NUMBER OF DATA TYPES
      NPOS=NPOS+1
      NRRSTP=ARRAY(NPOS)
C
C  SET NUMBER OF DATA TYPES FOR WHICH MISSING IS NOT ALLOWED
      NPOS=NPOS+1
      NMISS=ARRAY(NPOS)
C
C  SET NUMBER OF DATA TYPES FOR WHICH DISTRIBUTION IS ALLOWED
      NPOS=NPOS+1
      NDIST=ARRAY(NPOS)
C
      IF (NRRSTP.EQ.0) GO TO 170
C
C  SET DATA TYPE CODES
      DO 40 I=1,NRRSTP
         NPOS=NPOS+1
         CALL SUBSTR (ARRAY(NPOS),1,4,RRSTYP(I),1)
40       CONTINUE
C
C  SET INDICATOR WHETHER MISSING DATA IS ALLOWED
      DO 50 I=1,NRRSTP
         NPOS=NPOS+1
         CALL SUBSTR (ARRAY(NPOS),1,4,URMISS(I),1)
50       CONTINUE
C
C  SET DATA TIME INTERVAL (HOURS)
      DO 60 I=1,NRRSTP
         NPOS=NPOS+1
         IRTIME(I)=ARRAY(NPOS)
60       CONTINUE
C
C  SET NUMBER OF VALUES PER OBSERVATION
      DO 70 I=1,NRRSTP
         NPOS=NPOS+1
         NVLPOB(I)=ARRAY(NPOS)
70       CONTINUE
C
C  SET MINIMUM NUMBER OF DAYS OF DATA TO BE RETAINED IN PPDB
      DO 80 I=1,NRRSTP
         NPOS=NPOS+1
         MNODAY(I)=ARRAY(NPOS)
80       CONTINUE
C
C  SET TYPICAL NUMBER OF OBSERVATIONS HELD IN PPDB
      DO 90 I=1,NRRSTP
         NPOS=NPOS+1
         NUMOBS(I)=ARRAY(NPOS)
90       CONTINUE
C
C  SET RECORD NUMBER OF TIME SERIES HEADER
      DO 100 I=1,NRRSTP
         NPOS=NPOS+1
         ITSREC(I)=ARRAY(NPOS)
         IF (IREAD.EQ.1) THEN
            IF (IRTIME(I).GT.0.AND.ITSREC(I).EQ.0) THEN
               WRITE (LP,210) RRSTYP(I),STAID
               CALL SUWRNS (LP,2,-1)
               ENDIF
            ENDIF
100      CONTINUE
C
      IF (NMISS.EQ.0) GO TO 130
C
C  SET INTERPOLATION OPTION
      DO 110 I=1,NMISS
         NPOS=NPOS+1
         INTERP(I)=ARRAY(NPOS)
110      CONTINUE
C
C  SET EXTRAPOLATION RECESSION CONSTANT
      DO 120 I=1,NMISS
         NPOS=NPOS+1
         EXTRAP(I)=ARRAY(NPOS)
120      CONTINUE
C
130   IF (NDIST.EQ.0) GO TO 170
C
C  SET MINIMUM FLOW
      DO 140 I=1,NRRSTP
         NPOS=NPOS+1
         FLOMIN(I)=ARRAY(NPOS)
140      CONTINUE
C
C  SET FRACTION OF FLOW OCCURRING IN EACH HOUR
      DO 160 I=1,NRRSTP
         DO 150 J=1,24
            IF (FLOMIN(I).EQ.-997.) GO TO 160
            NPOS=NPOS+1
            FRACT(J,I)=ARRAY(NPOS)
150         CONTINUE
160      CONTINUE
C
170   IF (LDEBUG.GT.0) THEN
         WRITE (IOSDBG,*)
     *      ' NPOS=',NPOS,
     *      ' NFILL=',NFILL,
     *      ' IPTRNX=',IPTRNX,
     *      ' IVRRS=',IVRRS,
     *      ' '
         CALL SULINE (IOSDBG,1)
         CALL SUPDMP ('RRS ','REAL',0,NPOS,ARRAY,ARRAY)
         ENDIF
C
180   IF (ISTRCE.GT.1) THEN
         WRITE (IOSDBG,*) 'EXIT SRRRS'
         CALL SULINE (IOSDBG,1)
         ENDIF
C
      RETURN
C
C - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
200   FORMAT ('0*** ERROR - IN SRRRS - NUMBER OF WORDS IN VARIABLE ',
     *   A,'(',I2,') IS NOT ',I2,' FOR STATION ',A,'.')
210   FORMAT ('0*** WARNING - IN SRRRS - TIME SERIES RECORD NUMBER ',
     *   'IS ZERO FOR DATA TYPE ',A4,' FOR STATION ',A,'.')
C
      END