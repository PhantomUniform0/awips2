      SUBROUTINE SUPFLO55(PO,CO,Z,ST1,LTST1,T1,LTT1,POLH,LTPOLH,ITWT,
     . LTITWT,QLJ,LTQLJ,QL,LTQL,QDI,YDI,JNK,NCML,HS,XX,QC,QD,QU,YC,YD,
     . YU,DDX,YJ,KRCH,KU,C,D,ISS,YUMN,IOBS,MIXF,ISSS,ISN,KSUPC,
     . K1,K2,K4,K7,K8,K9,K10,K15,K16,K19,K20,K21)
C
C
C  THIS SUBROUTINE HANDLE SUPERCRITICAL FLOW USING CASCADING METHOD
C
      COMMON/M155/NU,JN,JJ,KIT,G,DT,TT,TIMF,F1
      COMMON/SS55/NCS,A,B,DB,R,DR,AT,BT,P,DP,ZH
      COMMON/VS55/MUD,IWF,SHR,VIS,UW,PB,SIMUD
      COMMON/FLP55/KFLP
      COMMON/IT55/ITER
      COMMON/IONUM/IN,IPR

      INCLUDE 'common/fdbug'
      INCLUDE 'common/ofs55'
C
      DIMENSION PO(*),CO(*),Z(*),ST1(*),LTST1(*),T1(*),LTT1(*)
      DIMENSION QC(K2,K1),QD(K2,K1),QU(K2,K1),HS(K9,K2,K1),XX(K15)
      DIMENSION YC(K2,K1),YD(K2,K1),YU(K2,K1),DDX(K2,K1)
      DIMENSION YJ(K1),KRCH(K2,K1),KU(K1),C(K15),D(4,K15)
      DIMENSION YUMN(K2,K1),MIXF(K1),QDI(K2,K1),YDI(K2,K1)
      CHARACTER*8 SNAME
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_fldwav/RCS/supflo55.f,v $
     . $',                                                             '
     .$Id: supflo55.f,v 1.4 2004/02/02 21:52:31 jgofus Exp $
     . $' /
C    ===================================================================
C

      DATA SNAME/ 'SUPFLO55' /
C
      CALL FPRBUG(SNAME,1,55,IBUG)

      J=JJ
      ISSS1=ISSS+1
      ISSSM=ISSS-1
      ISS1=ISS+1
      ISSM=ISS-1
      IF(ISSSM.NE.ISS) GO TO 4993
      IF(ISSSM.GT.1) GO TO 4991
      IF(ITER.GT.1) GO TO 4993
      IF (IOBS.GE.0) GO TO 40
      CALL MATHQ55(YQ1,PO(LOTPG),PO(LORHO),PO(LOGAMA),PO(LOYQI),K1)

      GO TO 50
   40 YQ1=YJ(J)
      IF(KU(J).GE.1) THEN
        TX=TT
        LT1=LTT1(J)
        LST1=LTST1(J)-1
        CALL INTERP55(T1(LT1),NU,TX,IT1,IT2,TINP)
        IF(TX.GT.T1(LT1)) THEN
          YQ1=ST1(IT1+LSTA)+(ST1(IT2+LST1)-ST1(IT1+LST1))*TINP
        ELSE
          IF(KU(J).EQ.1) YQ1=YDI(I,J)+(ST1(1+LST1)-YDI(I,J))*TX/T1(LT1)
          IF(KU(J).EQ.2) YQ1=QDI(I,J)+(ST1(1+LST1)-QDI(I,J))*TX/T1(LT1)
        ENDIF
      ENDIF

   50 IF(KU(J).EQ.1) YU(1,J)=YQ1
      IF(KU(J).EQ.2) QU(1,J)=YQ1
 4991 IF(ISS.EQ.1) GO TO 9984
C  IF 1ST SECTION OF THE SUPER CRITICAL FLOW REACH IS A DAM
C  USE NORMAL WATER DEPTH
C  OTHERWISE USE CRITICAL DEPTH
      KRA=IABS(KRCH(ISSM,J))
      IF(KRA.LT.10 .OR. KRA.GT.30) GO TO 4993
      QQ=QU(ISS,J)
      SO=(HS(1,ISS,J)-HS(1,ISS1,J))/DDX(ISS,J)
      IF(SO.LT.0.000001) SO=0.000001
      DO 105 LL=1,NCS
      LST=NCS-LL+1
      IF(ABS(HS(LST,ISS,J)).GT.0.0001) GO TO 106
  105 CONTINUE
  106 YMXX=HS(LST,ISS,J)
      YMNN=HS(1,ISS,J)
      Y1=YD(ISS,J)
      IRCH=ISS
      DYNX=0.5*(HS(1,ISS,J)-HS(1,ISS1,J))
      CALL HNORM55(PO,JNK,NCML,PO(LONQCM),J,ISS,IRCH,Y1,QQ,SO,YMNN,YMXX,
     . DYNX,LC,K1,K2,K7,K8,K9)
      YU(ISS,J)=Y1
      IF(Y1.GE.YU(ISSM,J)) YU(ISS,J)=YU(ISSM,J)
      GO TO 4993
 9984 IF(MUD.GE.1) GO TO 47
      Y1=YD(ISS,J)
      CALL SECT55(PO(LCPR),PO(LOAS),PO(LOBS),PO(LOHS),PO(LOASS),
     1 PO(LOBSS),J,ISS,Y1,PO(LCHCAV),PO(LCIFCV),K1,K2,K9)
      A1=A
      Y2=YD(ISS1,J)
      CALL SECT55(PO(LCPR),PO(LOAS),PO(LOBS),PO(LOHS),PO(LOASS),
     1 PO(LOBSS),J,ISS1,Y2,PO(LCHCAV),PO(LCIFCV),K1,K2,K9)
      A2=A
      AA=0.5*(A1+A2)
      TERM1=(YD(ISS,J)-YD(ISS1,J))/DDX(ISS,J)
      SM1=1.0 
      BET1=1.06
      BET2=1.06
      IF(KFLP.EQ.0) GO TO 145
      Y=(YC(ISS,J)+YD(ISS,J)+YC(ISS1,J)+YD(ISS1,J))/4.
      CALL SINC55(Y,J,ISS,ISS1,NCS,PO(LOHS),PO(LOSNC),SC,DSC,
     * PO(LOSNM),SM1,DSM,K1,K2,K9)
      CALL CONV55(PO(LOQKC),PO(LOHKC),PO(LCBEV),PO(LCNKC),J,ISS,Y1,QK1,
     * DQK1,BET1,DBE1,0,K1,K2)
      CALL CONV55(PO(LOQKC),PO(LOHKC),PO(LCBEV),PO(LCNKC),J,ISS1,Y2,QK2,
     * DQK2,BET2,DBE2,0,K1,K2)
  145 DQDT1=0.5*SM1*(QC(ISS,1)+QC(ISS1,1)-QD(ISS,1)-QD(ISS1,1))/DT
      TERM2=DQDT1/(G*AA)
      TERM3=(BET1*QD(ISS,J)**2./A1-BET2*QD(ISS1,J)**2./A2)/
     *  (G*AA*DDX(ISS,J))
      SF=TERM1+TERM2+TERM3
      IF(KRCH(ISS,J).EQ.1) SF=TERM1
      SDUM=(YUMN(ISS,J)-YUMN(ISS1,J))/DDX(ISS,J)
      FN=SQRT(SDUM)*100.
      IF(FN.LE.1.0) FN=1.0
      SMIN=SDUM/FN
      IF(SMIN.LE.0.000001) SMIN=0.000001
      IF(SF.LE.SMIN) SF=SMIN
      IF(JNK.GE.9) WRITE(IPR,9102) TERM1,TERM2,TERM3,SF,SMIN
 9102 FORMAT(/1X,5E13.5,5X,'(TERM1,TERM2,TERM3,SF,SMIN)')
      IF(MIXF(J).LE.2) SO=SF
      IF(MIXF(J).GT.2) SO=(HS(1,ISS,J)-HS(1,ISS1,J))/DDX(ISS,J)
      GO TO 148
   47 QQ=QU(ISS,J)
      SO=(HS(1,ISS,J)-HS(1,ISS1,J))/DDX(ISS,J)
      IF(SO.LT.0.000001) SO=0.000001
  148 QQ=QU(ISS,J)
      DO 103 LL=1,NCS
      LST=NCS-LL+1
      IF(ABS(HS(LST,ISS,J)).GT.0.0001) GO TO 104
  103 CONTINUE
  104 YMXX=HS(LST,ISS,J)
      YMNN=HS(1,ISS,J)
      Y1=YD(ISS,J)
      IRCH=ISS
      DYNX=0.5*(HS(1,ISS,J)-HS(1,ISS1,J))
      CALL HNORM55(PO,JNK,NCML,PO(LONQCM),J,ISS,IRCH,Y1,QQ,SO,YMNN,YMXX,
     1 DYNX,LC,K1,K2,K7,K8,K9)
      YU(ISS,J)=Y1
      C(1)=0.
      D(1,1)=1.0
      D(1,2)=0.0
 4993 NRCH=ISSSM
      NROW=1
C  NCL1 AND NCL2 NOT NEEDED BUT SUPPLIED SO THAT THEY ARE DEFINED
      NCL1=2
      NCL2=1
      NCL3=4
      NCL4=3
      CALL INTER55(PO,CO,Z,ST1,LTST1,T1,LTT1,POLH,LTPOLH,ITWT,LTITWT,
     . QLJ,LTQLJ,QL,LTQL,NCML,PO(LONQCM),PO(LONQL),C,PO(LONB),
     . PO(LONJUN),QD,QU,YD,YU,DDX,D,PO(LOATF),Z(LZQLV),Z(LZQLSM),KRCH,
     . KSUPC,MIXF,PO(LOKFTR),PO(LOFKEC),PO(LCTFT),PO(LOKLPI),PO(LOX),
     . PO(LOXLOS),PO(LOQLOS),PO(LOALOS),PO(LOKLOS),CO(LXQDI),
     . PO(LOSLFI),PO(LOMRU),PO(LONJUM),PO(LOMRV),Z(LZQJ),YJ,ISSSM,
     . ISN,NCL1,NCL2,NCL3,NCL4,K1,K2,K7,K8,K9,K10,K15,K16,K19,K20,K21)
C
C  C(1)=C(Q2,H2); C(2)=M(Q2,H2)
C  D(3,1)=PCPQ2; D(4,1)=PCPH2; D(3,2)=PMPQ2; D(4,2)=PMPH2
C  D(3,1)*DQ + D(4,1)*DH = C(1) -- continuity
C  D(3,2)*DQ + D(4,2)*DH = C(2) -- momentum
C  XX(1)=DQ; XX(2)=DH
      IF(ISS.EQ.ISSSM) GO TO 4994
      KRA=IABS(KRCH(ISSSM,J))
      IF(KRA.GE.10 .AND. KRA.LE.30) GO TO 310
 4994 BB=-D(3,2)/D(3,1)
      D(4,2)=BB*D(4,1)+D(4,2)
      C(2)=BB*C(1)+C(2)
      XX(2)=C(2)/D(4,2)
      XX(1)=(C(1)-D(4,1)*XX(2))/D(3,1)
      GO TO 320
C  INTERNAL DAM FOUND WITHIN SUPERCRITICAL FLOW REACH
  310 QQ=QU(ISSSM,J)
      QU(ISSS,J)=QQ
      SO=(HS(1,ISSS,J)-HS(1,ISSS1,J))/DDX(ISSS,J)
      IF(SO.LT.0.000001) SO=0.000001
      DO 101 LL=1,NCS
      LST=NCS-LL+1
      IF(ABS(HS(LST,ISSS,J)).GT.0.0001) GO TO 102
  101 CONTINUE
  102 YMXX=HS(LST,ISSS,J)
      YMNN=HS(1,ISSS,J)
      Y1=YU(ISSS,J)
      IRCH=ISSS
      DYNX=0.5*(HS(1,ISSS,J)-HS(1,ISSS1,J))
      CALL HNORM55(PO,JNK,NCML,PO(LONQCM),J,ISSS,IRCH,Y1,QQ,SO,YMNN,
     1 YMXX,DYNX,LC,K1,K2,K7,K8,K9)
      YU(ISSS,J)=Y1
      IF(Y1.GE.YU(ISSSM,J)) YU(ISSS,J)=YU(ISSSM,J)
      XX(1)=0.0
      XX(2)=0.0
  320 RETURN
      END