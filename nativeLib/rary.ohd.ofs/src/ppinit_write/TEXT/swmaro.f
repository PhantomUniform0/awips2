C MEMBER SWMARO
C-----------------------------------------------------------------------
C
C                             LAST UPDATE: 03/09/94.08:10:45 BY $WC20SV
C
C @PROCESS LVL(77)
C
C DESC WRITE OR UPDATE MEAN AREAL RUNOFF (MARO) PARAMETERS
C
      SUBROUTINE SWMARO (IVMARO,XMAROI,XDESCR,CENTRD,NGRID,
     *   ITSREC,NMSGPA,XSTAID,MMDRBX,MDRGPA,NMGPA,NMRFRO,UNUSED,
     *   LARRAY,ARRAY,IPTR,DISP,ISTAT)
C
      REAL NEW/4HNEW /,OLD/4HOLD /
      DIMENSION ARRAY(LARRAY)
      INCLUDE 'scommon/dimmaro'
C
      INCLUDE 'uio'
      INCLUDE 'scommon/sudbgx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_write/RCS/swmaro.f,v $
     . $',                                                             '
     .$Id: swmaro.f,v 1.1 1995/09/17 19:16:15 dws Exp $
     . $' /
C    ===================================================================
C
C
C
      IF (ISTRCE.GT.0) WRITE (IOSDBG,130)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
C  SET DEBUG LEVEL
      LDEBUG=ISBUG(4HMARO)
C
      IF (LDEBUG.GT.0) WRITE (IOSDBG,140) IVMARO,UNUSED,LARRAY
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
C
      ISTAT=0
C
C  CHECK FOR SUFFICIENT SPACE IN PARAMETER ARRAY
      MINLEN=25+(2*NGRID)
      IF (LDEBUG.GT.0) WRITE (IOSDBG,160) MINLEN
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
      IF (MINLEN.LE.LARRAY) GO TO 10
         WRITE (LP,170) LARRAY,MINLEN
         CALL SUERRS (LP,2,-1)
         ISTAT=1
         GO TO 120
C
C  STORE PARAMETER ARRAY VERSION NUMBER
10    ARRAY(1)=IVMARO+.01
C
C  STORE MARO AREA IDENTIFIER
      ARRAY(2)=XMAROI(1)
      ARRAY(3)=XMAROI(2)
C
      NPOS=3
C
C  STORE DESCRIPTIVE INFORMATION
      DO 20 I=1,5
         NPOS=NPOS+1
         ARRAY(NPOS)=XDESCR(I)
20       CONTINUE
C
C  STORE CENTROID OF AREA (LAT/LON IN DECIMAL DEGREES)
      DO 30 I=1,2
         NPOS=NPOS+1
         ARRAY(NPOS)=CENTRD(I)
30       CONTINUE
C
C  STORE NUMBER OF GRID POINTS IN AREA
      NPOS=NPOS+1
      ARRAY(NPOS)=NGRID+.01
C
C  STORE RECORD NUMBER OF MAPG AND MAPI TIME SERIES HEADERS
      DO 45 I=1,2
         NPOS=NPOS+1
         ARRAY(NPOS)=ITSREC(I)+.01
45       CONTINUE
C
C  STORE GRID POINT ADDRESS OF FIRST OFDER STATION ASSIGNED TO THE MARO
      NPOS=NPOS+1
      ARRAY(NPOS)=NMSGPA+.01
C
C  STORE FIRST ORDER STATION IDENTIFIER
      DO 50 I=1,2
         NPOS=NPOS+1
         ARRAY(NPOS)=XSTAID(I)
50       CONTINUE
C
C  STORE MDR BOX NUMBER OF 3 MDR BOXES THAT SURROUND AREA
      DO 54 I=1,3
         NPOS=NPOS+1
         ARRAY(NPOS)=MMDRBX(I)+.01
54       CONTINUE
C
C  STORE GRID POINT ADDRESS OF THE CENTROID OF EACH OF THE 3 MDR BOXES
      DO 56 I=1,3
         NPOS=NPOS+1
         IF (MDRGPA(I).GE.0) ARRAY(NPOS)=MDRGPA(I)+.01
         IF (MDRGPA(I).LT.0) ARRAY(NPOS)=MDRGPA(I)-.01
56       CONTINUE
C
C  THE NEXT TWO POSITIONS ARE UNUSED
      DO 60 I=1,2
         NPOS=NPOS+1
         ARRAY(NPOS)=UNUSED
60       CONTINUE
C
C  STORE GRID POINT ADDRESS OF EACH GRID POINT IN THE AREA
      DO 80 I=1,NGRID
         NPOS=NPOS+1
         ARRAY(NPOS)=NMGPA(I)+.01
80       CONTINUE
C
C  STORE RAINFALL-RUNOFF RELATIONSHIP NUMBER ASSOCIATED WITH EACH GRID
C  POINT
      DO 90 I=1,NGRID
         NPOS=NPOS+1
         ARRAY(NPOS)=NMRFRO(I)+.01
90       CONTINUE
C
C  WRITE PARAMTER RECORD TO FILE
      IF (LDEBUG.GT.0) WRITE (IOSDBG,150) NPOS
      IF (LDEBUG.GT.0) CALL SULINE (IOSDBG,1)
      CALL SUDOPN (1,4HPPP ,IERR)
      IPTR=0
      CALL WPPREC (XMAROI,4HMARO,NPOS,ARRAY,IPTR,IERR)
      IF (IERR.EQ.0) GO TO 100
         CALL SWPPST (XMAROI,4HMARO,NPOS,IPTR,IERR)
         WRITE (LP,190) IERR
         CALL SUERRS (LP,2,-1)
         ISTAT=3
C
100   IF (LDEBUG.GT.0) CALL SUPDMP (4HMARO,4HBOTH,0,NPOS,ARRAY,ARRAY)
C
      IF (ISTAT.EQ.0.AND.DISP.EQ.NEW) WRITE (LP,200) XMAROI
      IF (ISTAT.EQ.0.AND.DISP.EQ.OLD) WRITE (LP,205) XMAROI
      IF (ISTAT.EQ.0) CALL SULINE (LP,2)
      IF (ISTAT.EQ.0) CALL SUDWRT (1,4HPPP ,IERR)
      IF (ISTAT.GT.0.AND.DISP.EQ.NEW) WRITE (LP,210) XMAROI
      IF (ISTAT.GT.0.AND.DISP.EQ.OLD) WRITE (LP,215) XMAROI
      IF (ISTAT.GT.0) CALL SULINE (LP,2)
C
120   IF (ISTRCE.GT.0) WRITE (IOSDBG,220)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
130   FORMAT (' *** ENTER SWMARO')
140   FORMAT (' IVMARO=',I2,3X,'UNUSED=',F7.2,3X,'LARRAY=',I5)
150   FORMAT (' NPOS=',I2)
160   FORMAT (' MINLEN=',I5)
170   FORMAT ('0*** ERROR - IN SWMARO - NOT ENOUGH SPACE IN PARAMETER ',
     *   'ARRAY: NUMBER OF WORDS IN PARAMETER ARRAY=',I5,3X,
     *   'NUMBER OF WORDS NEEDED=',I5)
190   FORMAT ('0*** ERROR - IN SWMARO - UNSUCCESSFUL CALL TO WPPREC : ',
     *   'STATUS CODE=',I3)
200   FORMAT ('0*** NOTE - MARO PARAMETERS SUCCESSFULLY ',
     *   'WRITTEN FOR AREA ',2A4,'.')
205   FORMAT ('0*** NOTE - MARO PARAMETERS SUCCESSFULLY ',
     *   'UPDATED FOR AREA ',2A4,'.')
210   FORMAT ('0*** NOTE - MARO PARAMETERS NOT SUCCESSFULLY ',
     *   'WRITTEN FOR AREA ',2A4,'.')
215   FORMAT ('0*** NOTE - MARO PARAMETERS NOT SUCCESSFULLY ',
     *   'UPDATED FOR AREA ',2A4,'.')
220   FORMAT (' *** EXIT SWMARO')
C
      END