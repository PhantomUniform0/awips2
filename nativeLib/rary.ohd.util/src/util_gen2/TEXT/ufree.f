C MEMBER UFREE
C-----------------------------------------------------------------------
C
C @PROCESS LVL(77)
C
      SUBROUTINE UFREE (IBCOL,IECOL)
C
C  ROUTINE TO FIND FIELDS
C
C VALUES OF IFTYPE FOR NUMBER-NUMBER FORMAT TO SPECIFY A RANGE
C   IFTYPE=4 IF FIRST NUMBER IN RANGE
C   IFTYPE=5 IF LAST  NUMBER IN RANGE
C   IFTYPE=6 IF A DASH FOUND
C
      INCLUDE 'uio'
      INCLUDE 'udsi'
      INCLUDE 'ufreei'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/util/src/util_gen2/RCS/ufree.f,v $
     . $',                                                             '
     .$Id: ufree.f,v 1.2 1995/10/05 14:25:05 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA IDOLR/4H$   /
      DATA IQUOTE/4H'   /
      DATA ICOMMA/4H,   /
      DATA LPAREN/4H(   /
C
C
      IF (NOBUG.GT.0) THEN
         WRITE (LPD,*) '*** ENTER UFREE',
     *      ' IBCOL=',IBCOL,
     *      ' IECOL=',IECOL,
     *      ' '
         WRITE (LPD,'(A,80A1)') ' IBUF=',IBUF
         ENDIF
C
      IDASH=0
      ISVDSH=0
      II=IBCOL
      NFIELD=0
C
C  SEARCH FOR NON-BLANK CHARACTER
10    CALL UNOBLK (IBUF,II,IECOL,IBEGIN)
      IF (IBEGIN.EQ.IECOL+1) GO TO 90
C
C  CHECK FOR COMMENT
      IF (IBUF(IBEGIN).EQ.IDOLR) THEN
         IF (NFIELD.EQ.0) THEN
            NFIELD=NFIELD+1
            IFTYPE(NFIELD)=3
            IFSTOP(NFIELD)=IBEGIN
            IFSTRT(NFIELD)=IBEGIN
            IFCNT(NFIELD)=1
            ENDIF
         GO TO 90
         ENDIF
C
C  SEARCH FOR BLANK OR COMMA
      CALL USRBLK (IBUF,IBEGIN,IECOL,IEND)
      IF (IEND.EQ.IBEGIN.AND.IBUF(IBEGIN).EQ.ICOMMA) THEN
         NFIELD=NFIELD+1
         IFTYPE(NFIELD)=0
         IFSTOP(NFIELD)=IEND
         IFSTRT(NFIELD)=IBEGIN
         IFCNT(NFIELD)=1
         GO TO 80
         ENDIF
C
C  SEARCH FOR QUOTE
      CALL USRCHR (IQUOTE,IBEGIN,IEND,IX)
      IF (IX.EQ.0) GO TO 40
C
C  SET BEGINNING TO ONE MORE IF FIRST CHAR
      IF (IX.EQ.IBEGIN) IBEGIN=IBEGIN+1
C
C  SEARCH FOR ENDING QUOTE
      IXX=IX+1
      DO 20 I=1,40
         CALL USRCHR (IQUOTE,IXX,IECOL,IX)
         IF (IX.EQ.0) GO TO 40
         IF (IBUF(IX+1).NE.IQUOTE) GO TO 30
         IXX=IX+2
20       CONTINUE
C
C  FIND THE NEW END
30    CALL USRBLK (IBUF,IX,IECOL,IEND)
      IF (IEND.EQ.IX+1) IEND=IX
C
C  CHARACTER VALUE
40    IEND=IEND-1
      NFIELD=NFIELD+1
      IFTYPE(NFIELD)=3
      IFSTOP(NFIELD)=IEND
      IFSTRT(NFIELD)=IBEGIN
      IFCNT(NFIELD)=1
C
      IF (IDASH.EQ.0) GO TO 50
C
C  CHECK FOR DASH
      CALL USRDSH (IBUF,IBEGIN,IEND,KK)
      IF (KK.GT.IEND) GO TO 50
C
C  CHECK FOR INTEGER VALUE
      CALL UCKINT (IBUF,IBEGIN,KK-1,IERR)
      IF (IERR.EQ.1) GO TO 80
      IFTYPE(NFIELD)=4
      IFSTOP(NFIELD)=KK-1
      NFIELD=NFIELD+1
      IFTYPE(NFIELD)=6
      IFSTRT(NFIELD)=KK
      IFSTOP(NFIELD)=KK
      IFCNT(NFIELD)=1
      NFIELD=NFIELD+1
      IFSTRT(NFIELD)=KK+1
      IFSTOP(NFIELD)=IEND
      CALL UCKINT (IBUF,KK+1,IEND,IERR)
      IFTYPE(NFIELD)=5
      IFCNT(NFIELD)=1
      IF (IERR.EQ.1) GO TO 80
      ISVDSH=ISVDSH+1
      GO TO 80
C
C  CHECK FOR ASTERSIK
50    CALL USRAST (IBUF,IBEGIN,IEND,KK)
      IF (KK.GT.IEND) GO TO 60
      IF (KK.EQ.IBEGIN) GO TO 80
      CALL UCKINT (IBUF,IBEGIN,KK-1,IERR)
      IF (IERR.EQ.1) GO TO 80
      CALL UNUMIC (IBUF,IBEGIN,KK-1,NUM)
      IF (NUM.LT.0) GO TO 60
      IF (IBUF(KK+1).EQ.LPAREN) GO TO 80
      IFCNT(NFIELD)=NUM
      IBEGIN=KK+1
      IFSTRT(NFIELD)=IBEGIN
C
C  CHECK IF INTEGER VALUE
60    CALL UCKINT (IBUF,IBEGIN,IEND,IERR)
      IF (IERR.EQ.1) GO TO 70
      IFTYPE(NFIELD)=1
      GO TO 80
C
C  CHECK IF REAL VALUE
70    CALL UCKFLT (IBUF,IBEGIN,IEND,KKK,IERR)
      IF (IERR.EQ.1) GO TO 80
      IFTYPE(NFIELD)=2
C
80    IF (IBUF(IEND+1).EQ.IQUOTE) IEND=IEND+1
      II=IEND+2
      IF (II.GT.IECOL) GO TO 100
      GO TO 10
C
90    IDASH=ISVDSH
C
100   IF (NOBUG.GT.0) THEN
         WRITE (LPD,*) ' NFIELD=',NFIELD
         DO 110 I=1,NFIELD
            WRITE (LPD,*)
     *         ' I=',I,
     *         ' IFTYPE(I)=',IFTYPE(I),
     *         ' IFCNT(I)=',IFCNT(I),
     *         ' IFSTRT(I)=',IFSTRT(I),
     *         ' IFSTOP(I)=',IFSTOP(I),
     *         ' '
110         CONTINUE
         WRITE (LPD,*) '*** EXIT UFREE'
         ENDIF
C
      RETURN
C
      END
