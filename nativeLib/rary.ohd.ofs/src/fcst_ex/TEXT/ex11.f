C MEMBER EX11
C  (from ole member FCEX11)
C
      SUBROUTINE EX11(P,C,QIN,QOUT,R)
C
C     THIS IS THE EXECUTION SUBROUTINE FOR
C     LAYERED COEFFICIENT ROUTING
C
C     THIS SUBROUTINE INITIALLY WRITTEN BY
C          DAVID REED--HRL   OCT 1979
C
      DIMENSION P(1),C(1),QIN(1),QOUT(1),R(1)
C
C     COMMON BLOCKS
C
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/FCTIME/IDARUN,IHRRUN,LDARUN,LHRRUN,LDACPD,LHRCPD,
     1NOW(5),LOCAL,NOUTZ,NOUTDS,NLSTZ,IDA,IHR,LDA,LHR,IDADAT
      COMMON/IONUM/IN,IPR,IPU
      COMMON/FCARY/IFILLC,NCSTOR,ICDAY(20),ICHOUR(20)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_ex/RCS/ex11.f,v $
     . $',                                                             '
     .$Id: ex11.f,v 1.1 1995/09/17 18:56:33 dws Exp $
     . $' /
C    ===================================================================
C
C
C     CHECK TRACE LEVEL-FOR THIS SUBROUTINE =1
C
      IF(ITRACE.GE.1) WRITE(IODBUG,900)
  900 FORMAT(1H0,14H**EX11 ENTERED)
C
C     CHECK TO SEE IF DEBUG OUTPUT IS NEEDED
C
      IBUG=0
      IF(IDBALL.GT.0) IBUG=1
      IF(NDEBUG.EQ.0) GO TO 100
      DO 10 I=1,NDEBUG
      IF(IDEBUG(I).EQ.11) GO TO 11
   10 CONTINUE
      GO TO 100
   11 IBUG=1
  100 NC=P(16)
      NM1=NC-1
      NM2=NC-2
      NQST=17+NC
      NQLST=NQST+NM2
C
C     CHECK TO SEE IF DEBUG OUTPUT IS NEEDED
C
      IF(IBUG.EQ.0) GO TO 101
      WRITE(IODBUG,901)(P(I),I=2,6),NQLST,NC
  901 FORMAT(1H0,10X,32HLAYERED COEFFICIENT ROUTING FOR ,5A4,//,11X,
     151HCONTENTS OF P AND C ARRAYS     NUMBER OF VALUES  P=,
     2I3,5H  C =,I3)
      WRITE(IODBUG,902)(P(I),I=1,NQLST)
  902 FORMAT(1H0,14(F8.3,1X))
      WRITE(IODBUG,902)(C(I),I=1,NC)
  101 IC=1
      KDA=IDA
      KHR=IHR
      KDT=P(10)
      DO 201 I=1,NC
  201 R(I)=C(I)
C
C     BEGIN COMPUTATIONAL LOOP
C
  102 I=(KDA-IDADAT)*24/KDT+KHR/KDT
C
C     DETERMINE LAYER INFLOW
C
C
C     DETERMINE LAYER OF FLOW
C
      QTOTAL=0.
      IF(NC.EQ.1) GO TO 200
      DO 210 J=1,NC
      IF(J.EQ.NC) GO TO 220
      IF(QIN(I).LE.P(NQST+J-1)) GO TO 220
  210 CONTINUE
  200 J=1
  220 LAYER=J
C
C     ROUTE INFLOW FOR ONE LAYER AT A TIME
C
      DO 230 K=1,NC
      Q=0.
      IF((K.EQ.1).AND.(LAYER.EQ.1))Q=QIN(I)+R(K)
      IF((K.EQ.1).AND.(LAYER.GT.1))Q=P(NQST)+R(K)
      IF(K.EQ.1) GO TO 240
      IF(K.EQ.LAYER)Q=QIN(I)-P(NQST+K-2)+R(K)
      IF(K.EQ.LAYER) GO TO 240
      IF(K.GT.LAYER) Q=R(K)
      IF(K.GT.LAYER) GO TO 240
      Q=P(NQST+K-1)-P(NQST+K-2)+R(K)
  240 QTOTAL=QTOTAL+Q*P(16+K)
      IF(QTOTAL.LT.0.) QTOTAL=0.
      R(K)=Q*(1.-P(16+K))
      IF(R(K).LT.0.00001) R(K)=0.
  230 CONTINUE
      QOUT(I)=QTOTAL
C
C     CHECK TO SEE IF CARRYOVER SHOULD BE STORED
C
      IF(IFILLC.EQ.0) GO TO 115
      IF(IC.GT.NCSTOR) GO TO 115
      IF((KDA.EQ.ICDAY(IC)).AND.(KHR.EQ.ICHOUR(IC))) GO TO 116
      GO TO 115
C
C     INTERMEDIATE CARRYOVER BEING SAVED
C
  116 CALL FCWTCO(KDA,KHR,R,NC)
C
      IC=IC+1
C
C    CHECK FOR FINISH TIME AND ALSO INCREMENT TIME
C
  115 IF((KDA.EQ.LDA).AND.(KHR.EQ.LHR)) GO TO 117
      IHOUR=KHR+KDT
      IF(IHOUR.GT.24) GO TO 118
      KHR=KHR+KDT
      GO TO 102
  118 KDA=KDA+1
      KHR=KHR+KDT-24
      GO TO 102
C
C     CHECK TO SEE IF CARRYOVER SHOULD BE STORED
C
  117 IF(IFILLC.EQ.0) GO TO 119
      DO 120 J=1,NC
  120 C(J)=R(J)
C
C     CHECK FOR DEBUG OUTPUT
C
  119 IF(IBUG.EQ.0) GO TO 121
      WRITE(IODBUG,901)(P(I),I=2,6),NQLST,NC
      WRITE(IODBUG,902)(P(I),I=1,NQLST)
      WRITE(IODBUG,902)(C(I),I=1,NC)
  121 RETURN
      END