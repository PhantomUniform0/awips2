C MEMBER PRC7
C  (from old member FCPRC7)
C
      SUBROUTINE PRC7(P,C)
C.......................................................................
C
C      THIS SUBROUTINE PRINTS THE CARRYOVER FOR THE LAG/K OPERATION.
C.......................................................................
C
C      SUBROUTINE ORIGINALLY PROGRAMMED BY
C                 GEORGE F. SMITH - HRL -   NOVEMBER, 1979.
C                      UPDATED MARCH 1982 TO PRINT IN ENGLISH OR
C                        METRIC UNITS
C                       UPDATED FEB 1990 TO SET IATL VARIABLE BASED
C                         ON FT. WORTH TRANS LOSS COMPUTATIONS
C.......................................................................
C
      COMMON/IONUM/IN,IPR,IPU
      COMMON/FDBUG/IODBUG,IXX(23)
      COMMON/FCONIT/IV
      COMMON/FATLGK/IATL,C1,C2
      COMMON/FENGMT/METRIC
C
      DIMENSION P(1),C(1),SUBN(2),IUFLOW(2),IUVOL(2),TEMP(5)
C
      LOGICAL FOP7,MEANQ
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_prpc/RCS/prc7.f,v $
     . $',                                                             '
     .$Id: prc7.f,v 1.1 1995/09/17 18:49:51 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA SUBN,LTRACE,NOP/4HPRC7,4H    ,1,7/
      DATA L3/4HL3  /
      DATA IUFLOW/4HCFS ,4HCMS /,IUVOL/4HCFSD,4HCMSD/
C
C.......................................................................
C
C      PRINT DEBUG INFORMATION AND TURN ON DEBUG FLAG.
C.......................................................................
C
      CALL FPRBUG(SUBN,LTRACE,NOP,IBUG)
C
      DTYPIN=P(4)
      CALL FDCODE(DTYPIN,STDUNT,INDIMS,MSNG,NUPDT,TSCALE,NEXTRA,IER)
      MEANQ=.FALSE.
      IF(INDIMS.EQ.L3)MEANQ=.TRUE.
C
      WRITE(IPR,600)
  600 FORMAT(1H0,11X,30HLAG AND/OR K CARRYOVER VALUES.)
C
      NDFLT=P(17)
      IBK=P(18)
      IBK1=IBK+1
      NPQT=C(5)
C
      TLRC = P(11)
      IATL = 1
      IF(TLRC .GT. 0.0) IATL = 0
C
      IMETR=P(10)
      IF(METRIC.EQ.0)IMETR=0
      IF(METRIC.EQ.1)IMETR=1
      IMETRP = IMETR+1
C
      IF(IMETR.EQ.1)GO TO 25
      CALL FCONVT(4HCMS ,4HL3/T,IU,CFSM,CFSA,IER)
      CALL FCONVT(4HCMSD,4HL3  ,IU,CFDM,CFDA,IER)
C
   25 IF(NDFLT.NE.0.OR.IV.NE.1)GO TO 20
C
      IF(.NOT.FOP7(P(19),P(20)).OR..NOT.FOP7(P(IBK),P(IBK1)))GO TO 10
C
      WRITE(IPR,601)
  601 FORMAT(16X,'LAG AND K CARRYOVER HAVE BEEN SET TO A DEFAULT ',
     1  'VALUE OF ZERO.')
C
      RETURN
C
   10 IF(FOP7(P(19),P(20)))WRITE(IPR,602)
  602 FORMAT(16X,'LAG CARRYOVER HAS BEEN SET TO A DEFAULT VALUE OF ',
     1  'ZERO.')
C
      IF(FOP7(P(IBK),P(IBK1)))WRITE(IPR,603)
  603 FORMAT(16X,'K CARRYOVER HAS BEEN SET TO A DEFAULT VALUE OF ',
     1  'ZERO.')
C
      RETURN
C
   20 IF(.NOT.FOP7(P(19),P(20)))GO TO 30
C
      WRITE(IPR,604)NPQT
  604 FORMAT(16X,'THE MAXIMUM NUMBER OF PAIRS OF Q AND TIME LAG ',
     1  'CARRYOVER IS ',I3,1H.)
C
      WRITE(IPR,608)
  608 FORMAT(16X,'NOTE -- TIME IS IN HOURS AFTER CARRYOVER DATE.')
C
      DO 100 I=1,NPQT
      J=I*2
      IF(C(5+J).LE.0.0)GO TO 110
  100 CONTINUE
      J=J+2
C
  110 NPQTA=J/2 - 1
C
      WRITE(IPR,605)NPQTA
  605 FORMAT(16X,'THE NUMBER OF NONZERO PAIRS OF Q AND TIME LAG ',
     1  'CARRYOVER IS ',I3,1H.)
C
      IF(NPQTA.GT.0)CALL FPRQT7(C(6),NPQTA,IPR,IMETR)
C
      IF(FOP7(P(IBK),P(IBK1)))GO TO 40
C
      TEMP(3)=C(3)
      IF(IMETR.EQ.0)TEMP(3)=TEMP(3)*CFSM
C
      WRITE(IPR,607)TEMP(3),IUFLOW(IMETRP)
  607 FORMAT(16X,'THE LAG CARRYOVER VALUE FOR CURRENT OUTFLOW IS ',
     1  F12.2,1X,A4)
C
      RETURN
C
   30 IF(.NOT.FOP7(P(IBK),P(IBK1)))RETURN
C
 40   IF(IATL.NE.0.OR.MEANQ)GO TO 50
      FAC=1.
      IF(IMETR.EQ.0)FAC=CFSM
      DO 45 I=2,4
   45 TEMP(I)=TEMP(I)*FAC
      WRITE(IPR,606)IUFLOW(IMETRP),(TEMP(I),I=2,4)
  606 FORMAT(16X,'THE K CARRYOVER VALUES IN ',A4,' ARE'/
     1  16X,51HCURRENT INFLOW   CURRENT OUTFLOW   PREVIOUS OUTFLOW/
     2  15X,F12.2,10X,F12.2,10X,F12.2)
   50 IF(IATL.NE.0.OR..NOT.MEANQ)GO TO 60
      TEMP(3)=C(3)
      TEMP(4)=C(4)
      IF(IMETR.EQ.1)GO TO 58
      TEMP(3)=TEMP(3)*CFSM
      TEMP(4)=TEMP(4)*CFDM
   58 WRITE(IPR,610)IUFLOW(IMETRP),IUVOL(IMETRP),(TEMP(I),I=3,4)
  610 FORMAT(16X,26HTHE K CARRYOVER VALUES ARE/
     1   16X,'CURRENT OUTFLOW (',A4,')  CURRENT STORAGE (',A4,')'/
     2    19X,F12.2,9X,F12.2)
   60 IF(IATL.NE.1.OR.MEANQ)GO TO 70
      DO 62 I=2,4
   62 TEMP(I)=C(I)
      IF(IMETR.EQ.1)GO TO 65
      TEMP(2)=TEMP(2)*CFSM
      TEMP(3)=TEMP(3)*CFSM
      TEMP(4)=TEMP(4)*CFDM
   65 J=IMETR+1
      WRITE(IPR,609)IUFLOW(J),IUFLOW(J),IUVOL(J),(TEMP(I),I=2,4)
  609 FORMAT(16X,26HTHE K CARRYOVER VALUES ARE/
     1  16X,'CURRENT INFLOW (',A4,')  CURRENT OUTFLOW (',A4,
     1  ')  CURRENT STORAGE (',A4,')'/
     2  16X,F12.2,9X,F12.2,9X,F12.2)
   70 IF(IATL.NE.1.OR..NOT.MEANQ)GO TO 80
      TEMP(3)=C(3)
      TEMP(4)=C(4)
      IF(IMETR.EQ.1)GO TO 75
      TEMP(3)=TEMP(3)*CFSM
      TEMP(4)=TEMP(4)*CFDM
   75 WRITE(IPR,611)IUFLOW(IMETRP),IUVOL(IMETRP),(TEMP(I),I=3,4)
  611 FORMAT(16X,'THE K CARRYOVER VALUES ARE'/
     1  16X,'CURRENT OUTFLOW (',A4,')  CURRENT STORAGE (',A4,')'/
     2  16X,F12.2,9X,F12.2)
C
   80 RETURN
      END