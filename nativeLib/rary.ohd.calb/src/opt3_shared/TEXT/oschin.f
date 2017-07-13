C     MEMBER OSCHIN
C
      SUBROUTINE OSCHIN
C
C.......................................
C     THIS SUBROUTINE READS AND PRINTS PATTERN SEARCH OPTIONS.
C.......................................
C     SUBROUTINE INITIALLY WRITTEN BY
C            L. E. BRAZIL - HRL   FEB 1984   VERSION 1
C.......................................
C
      DIMENSION PINCR(2),FIX(2),PERC(2)
      DIMENSION OLDOPN(2)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'ocommon/opschm'
      INCLUDE 'ocommon/odrop'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/calb/src/opt3_shared/RCS/oschin.f,v $
     . $',                                                             '
     .$Id: oschin.f,v 1.2 1996/07/11 20:56:25 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA FIX/4H FIX,4HED  /
      DATA PERC/4HPERC,4HENT /
C
C     TRACE LEVEL=1
      IF(ITRACE.GE.1) WRITE(IODBUG,1000)
 1000 FORMAT(1H0,17H** OSCHIN ENTERED)
C
      CALL FSTWHR('OSCHIN  ',0,OLDOPN,IOLDOP)
C
C  READ CARD FOR PATTERN SEARCH OPTIONS
C
      READ(IN,800) NPER,KC,KSTOP,PCENTO
  800 FORMAT(3I5,F5.2)
C
      IF(NPER.EQ.0.OR.NPER.EQ.1) GO TO 102
      WRITE(IPR,904) NPER
  904 FORMAT(1H0,10X,12H**WARNING** ,I1,41H IS NOT A VALID PARAMETER INC
     *REMENT TYPE.,/22X,39HFIXED QUANTITY INCREMENTS WILL BE USED.)
      NPER=0
C
      CALL WARN
C
  102 IF(KSTOP.GT.0.AND.KSTOP.LE.9) GO TO 104
      WRITE(IPR,906) KSTOP
  906 FORMAT(1H0,10X,'**WARNING** THE NUMBER OF TRIALS IN WHICH THE CRIT
     *ERION VALUE MUST CHANGE MUST BE GREATER THAN 0 AND LESS THAN 10. '
     */,23X,I3,32H WAS SPECIFIED.  5 WILL BE USED.)
      KSTOP=5
      CALL WARN
C
C  PRINT PATTERN SEARCH OPTIONS
C
  104 WRITE(IPR,910)
  910 FORMAT(1H0,//,30X,'PATTERN SEARCH OPTIMIZATION SCHEME',/,30X,34(1H
     *=),///,16X,'PARAMETER',12X,'MAX NO.',12X,'REQUIRED IMPROVEMENT',/,
     *16X,'INCREMENT',10X,'RESOLUTIONS',10X,'PERCENT',3X,
     *'NO. TRIALS',/,16X,9(1H-),10X,11(1H-),10X,7(1H-),3X,10(1H-))
C
      PINCR(1)=FIX(1)
      PINCR(2)=FIX(2)
      IF(NPER.NE.1) GO TO 110
      PINCR(1)=PERC(1)
      PINCR(2)=PERC(2)
C
  110 PCENTA=PCENTO*100.
C
      WRITE(IPR,912) PINCR,KC,PCENTA,KSTOP
C
  912 FORMAT(1H0,16X,2A4,11X,I5,16X,F4.1,8X,I2)
C
      CALL FSTWHR(OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      IF(ITRACE.GE.1) WRITE(IODBUG,1002)
 1002 FORMAT(1H0,14H** EXIT OSCHIN)
C
      RETURN
      END