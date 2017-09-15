C MEMBER COX29
C  (from old member FCCOX29)
C
      SUBROUTINE COX29 (POLD,COLD,PONEW,CONEW)
C                             LAST UPDATE: 02/08/94.09:15:44 BY $WC20SV
C
C
C***********************************************************************
C
C  THIS SUBROUTINE TRANSFERS OLD CARRYOVER VALUES TO THE NEW CO ARRAY
C  WHEN A SEGMENT IS REDEFINED.
C
C  CURRENTLY, NO MODIFICATIONS ARE MADE TO ANY CARRYOVER VALUES.  THE
C  OLD AND NEW PO ARRAYS ARE RETAINED IN THE ARGUMENT LIST FOR DISPLAY
C  PURPOSES AND POSSIBLE FUTURE APPLICATIONS.
C
C***********************************************************************
C  SUBROUTINE INITIALLY WRITTEN BY
C        LARRY BLACK - MBRFC     JULY 1982
C***********************************************************************
C  PRINCIPAL VARIABLES...
C
C  THE VARIABLES POLD AND PONEW ARE THE SAME AS THE PO ARRAY IN THE
C  PIN ROUTINE  LIKEWISE, THE VARIABLES COLD AND CONEW ARE THE SAME AS
C  THE CO ARRAY.  FOR A DESCRIPTION OF THESE CONTENTS, SEE THE PIN29
C  USER DOCUMENTATION.
C
C  FOR DEFINITION OF VARIABLES IN COMMON BLOCKS, SEE SECTION IX.3.3C
C  OF THE NWSRFS USER'S MANUAL.
C
C     AI             CURRENT AI VALUE
C     AIADJ          AI ADJUSTMENT FACTOR
C     AICO           STORM AI VALUE
C     API            CURRENT API VALUE
C     IAIREL         API/AI RELATIONSHIP NUMBER
C     IDELT          DELTA-T OF TIME SERIES FOR RAINFALL/MELT AND RUNOFF
C     IFDEB          DEBUG OUTPUT SWITCH, 0 = OFF, 1 = ON
C     IFUTWK         FUTURE WEEK NUMBER
C     INCOFL         READ/NO READ CARRYOVER FLAG, 0 = NO READ, 1 = READ
C     IVERS          VERSION NUMBER
C     NEWSTM         STORM PERIOD COUNTER
C     NOP            NUMBER OF OPERATION ASSIGNED TO THIS OPERATION
C     NOZON          RUNOFF ZONE NUMBER
C     NUMCO          THE NUMBER OF ELEMENTS IN THE CO, COLD, AND CONEW
C                      ARRAYS.
C     NUMPO          THE NUMBER OF ELEMENTS IN THE PO, POLD, AND PONEW
C                      ARRAYS.
C     RAINCO         STORM RAINFALL VALUE
C     ROCO           STORM RUNOFF VALUE
C     SUBNAM(2)      SUBROUTINE NAME
C     TOT24          24-HOUR RAINFALL/MELT ENDING 12Z
C     WE             CURRENT WATER EQUIVALENT VALUE
C
C***********************************************************************
C
C
      DIMENSION POLD(1),COLD(1),PONEW(1),CONEW(1),SUBNAM(2)
C
      COMMON /FDBUG/ IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_cox/RCS/cox29.f,v $
     . $',                                                             '
     .$Id: cox29.f,v 1.1 1995/09/17 18:47:18 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA SUBNAM/4hCOX2,4h9   /,NOP/29/,EMPTY/4h    /
C
C
C  CALL DEBUG CHECK ROUTINE.
C
      CALL FPRBUG (SUBNAM,1,NOP,IFDEB)
C
C  SET NUMBER OF WORDS IN CO ARRAY.
C
      NUMCO=8
C
C  TRANSFER CO VALUES.
C
      DO 1001 I=1,NUMCO
      CONEW(I)=COLD(I)
 1001 CONTINUE
      IF(IFDEB.LE.0) RETURN
C
C  DEBUG OUTPUT STATEMENTS.
C
      IVERS=PONEW(1)
      NOZON=PONEW(8)
      IAIREL=PONEW(10)
      IFUTWK=PONEW(11)
      AIADJ=PONEW(12)/10.0
      IDELT=PONEW(13)
      INCOFL=PONEW(31)
      NEWSTM=CONEW(1)
      RAINCO=CONEW(2)/100.0
      AICO=CONEW(3)/10.0
      ROCO=CONEW(4)/100.0
      API=CONEW(5)/100.0
      AI=CONEW(6)/10.0
      WE=CONEW(7)/100.0
      TOT24=CONEW(8)/100.0
      WRITE(IODBUG,11) SUBNAM,IVERS
      WRITE(IODBUG,12) (PONEW(I),I=2,7),NOZON,PONEW(9),IAIREL,IFUTWK,
     1                 AIADJ,INCOFL,(PONEW(I),I=14,16),IDELT,
     2                 (PONEW(I),I=17,19),IDELT,(PONEW(I),I=20,22)
      IF(PONEW(34).EQ.EMPTY) GO TO 101
      WRITE(IODBUG,13) (PONEW(I),I=32,34)
  101 IF(PONEW(37).EQ.EMPTY) GO TO 102
      WRITE(IODBUG,14) (PONEW(I),I=35,37)
  102 WRITE(IODBUG,15) (PONEW(I),I=23,30)
      WRITE(IODBUG,16) NEWSTM,RAINCO,AICO,ROCO,API,AI,WE,TOT24
      RETURN
C
C
   11 FORMAT(/5X,2A4,' DEBUG OUTPUT.',5X,'VERSION:',I4)
   12 FORMAT(/12X,'ZONE NAME:',2X,6A4,
     1       3X,'ZONE NUMBER:',I8,5X,'RFC ID CODE:',4X,A4/
     2       51X,'API/AI REL NO:',I6,5X,'FUTURE WEEK NO:',I5/
     3       51X,'AI ADJ FACTOR:',F6.1,5X,'C/O INPUT FLAG:',I5//
     4       20X,'TIME SERIES USED BY THIS OPERATION...'/
     5       25X,'CONTENTS',15X,'TS I.D.',5X,'TYPE',5X,'TIME INTERVAL'/
     6       25X,20('-'),2X,8('-'),5X,4('-'),5X,13('-')/
     7       25X,'RAINFALL/MELT',9X,2A4,5X,A4,I9,' HOURS'/
     8       25X,'RUNOFF',16X,2A4,5X,A4,I9,' HOURS'/
     9       25X,'WATER EQUIVALENT',6X,2A4,5X,A4,7X,'24 HOURS')
   13 FORMAT(25X,'CURRENT API',11X,2A4,5X,A4,7X,'24 HOURS')
   14 FORMAT(25X,'CURRENT AI',12X,2A4,5X,A4,7X,'24 HOURS')
   15 FORMAT(20X,'API/AI CONSTANTS AND RECESSION FACTORS...'/
     1       29X,'C1',8X,'C2',8X,'C3',8X,'C4',8X,'C5',8X,'C6',
     2       6X,'REG1',6X,'REG2'/
     3       21X,6F10.3,2F10.2)
   16 FORMAT(20X,'CARRYOVER VALUES...'/
     1       25X,'NEWSTM    RAINCO      AICO      ROCO       ',
     2       'API        AI        WE     TOT24'/
     3       27X,I4,F10.2,F10.1,2F10.2,F10.1,2F10.2)
      END