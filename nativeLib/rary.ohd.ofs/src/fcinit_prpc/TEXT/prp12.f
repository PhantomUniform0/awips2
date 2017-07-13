C MEMBER PRP12
C  (from old member FCPRP12)
C
      SUBROUTINE PRP12(P)
C
C     THIS IS THE PRINT PARAMETER SUBROUTINE FOR THE INSTANTANEOUS
C     DISCHARGE PLOT OPERATION
C
C     THIS SUBROUTINE INITIALLY WRITTEN BY
C          DAVID REED--HRL   NOV 1979
C
      DIMENSION P(1)
C
C     COMMON BLOCKS
C
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/IONUM/IN,IPR,IPU
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_prpc/RCS/prp12.f,v $
     . $',                                                             '
     .$Id: prp12.f,v 1.1 1995/09/17 18:49:59 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA BLANK/1H /
C
C     CHECK TRACE LEVEL-FOR THIS SUBROUTINE=1
C
      IF(ITRACE.GE.1)WRITE(IODBUG,900)
  900 FORMAT(1H0,16H** PRP12 ENTERED)
C
C     NO DEBUG OUTPUT FOR THIS SUBROUTINE
C
      NPLOTS=P(7)
      IOPTAB=P(8)
      IOPLT=P(9)
      IDTPLT=P(10)
      IRC=P(11)
      NTAB=0
      WRITE(IPR,901)(P(I),I=2,6)
  901 FORMAT(1H0,10X,38HINSTANTANEOUS FLOW PLOT DISCHARGE FOR ,5A4)
      WRITE(IPR,902)IDTPLT,NPLOTS
  902 FORMAT(1H0,10X,20HPLOT TIME INTERVAL =,I2,
     156H HOURS   NUMBER OF DISCHARGE TIME SERIES TO BE PLOTTED =,I2)
      IF(IOPTAB.EQ.0)NTAB=0
      IF(IOPTAB.EQ.1)NTAB=1
      IF(IOPTAB.EQ.2)NTAB=1
      IF(IOPTAB.EQ.3)NTAB=2
      IPTR=11
      IF(NPLOTS.LE.2)NTTAB=NTAB+NPLOTS
      IF(NPLOTS.GT.2)NTTAB=NTAB+2
C
C     WRITE TIME SERIES USED BY THIS OPERATION
C
      WRITE(IPR,903)
  903 FORMAT(1H0,20X,34HTIME SERIES USED BY THIS OPERATION//16X,
     18HCONTENTS,17X,4HI.D.,9X,4HTYPE,6X,13HTIME INTERVAL,5X,
     215HPLOTTING SYMBOL)
      IF(NTAB.EQ.0) GO TO 100
      DO 110 I=1,NTAB
      IDT=P(IPTR+4)
      WRITE(IPR,904)(P(IPTR+J),J=5,7),(P(IPTR+K),K=1,3),IDT
  904 FORMAT(1H0,15X,3A4,13X,2A4,5X,A4,7X,I2,6H HOURS,15X,3HN/A)
  110 IPTR=IPTR+7
  100 DO 120 I=1,NPLOTS
      IDT=P(IPTR+4)
      IF(I.EQ.IOPLT) GO TO 140
      WRITE(IPR,905)(P(IPTR+J),J=5,7),(P(IPTR+K),K=1,3),IDT,P(IPTR+8)
  905 FORMAT(1H0,15X,3A4,13X,2A4,5X,A4,7X,I2,6H HOURS,16X,A1)
      GO TO 120
  140 WRITE(IPR,905)(P(IPTR+J),J=5,7),(P(IPTR+K),K=1,3),IDT,P(IPTR+8)
      IDTOPT=IDT
      QTOPT=P(IPTR+3)
      QID1=P(IPTR+1)
      QID2=P(IPTR+2)
  120 IPTR=IPTR+8
      IF(IOPLT.EQ.0) GO TO 150
      WRITE(IPR,907)QID1,QID2,QTOPT,IDTOPT
  907 FORMAT(1H0,10X,15HTIME SERIES ID=,2A4,6H TYPE=,A4,15H TIME INTERVA
     1L=,I2,52H HOURS MUST HAVE AT LEAST ONE NON-MISSING VALUE FOR
     2/40X,44HA DAY BEFORE ANY TIME SERIES WILL BE PLOTTED)
  150 WRITE(IPR,941)NTTAB
  941 FORMAT(1H0,10X,9HTHE FIRST,I2,30H TIME SERIES WILL BE TABULATED)
      IF(IRC.EQ.0)GO TO 160
      WRITE(IPR,950)P(IRC),P(IRC+1)
  950 FORMAT(1H0,10X,'A STAGE SCALE WILL BE COMPUTED USING ',
     1  'RATING CURVE ',2A4,1H.)
      WRITE(IPR,954)
  954 FORMAT(1H0)
      IF(P(IRC+2).NE.BLANK)WRITE(IPR,951)P(IRC+2)
  951 FORMAT(11X,'FLOOD STAGE WILL BE INDICATED BY THE SYMBOL ',A1)
      IF(P(IRC+3).NE.BLANK)WRITE(IPR,952)P(IRC+3)
  952 FORMAT(11X,'THE RATING CURVE LOWER LIMIT WILL BE INDICATED ',
     1  'BY THE SYMBOL ',A1)
      IF(P(IRC+4).NE.BLANK)WRITE(IPR,953)P(IRC+4)
  953 FORMAT(11X,'THE RATING CURVE UPPER LIMIT WILL BE INDICATED ',
     1  'BY THE SYMBOL ',A1)
  160 RETURN
      END