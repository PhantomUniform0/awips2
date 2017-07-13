C MEMBER EX12
C  (from old member FCEX12)
C-----------------------------------------------------------------------
C
C                             LAST UPDATE: 04/27/95.08:22:15 BY $WC20SV
C
C @PROCESS LVL(77)
C
      SUBROUTINE EX12(P,PCPN,RO,D,LPLOTQ,ORD,ORDI,LSYM,IDTQ,PSBL,IQDAY)
C
C     THIS IS THE EXECUTION ROUTINE FOR THE INSTANTANEOUS
C     DISCHARGE PLOT OPERATION
C
C     THIS ROUTINE INITIALLY WRITTEN BY
C          DAVID REED-- HRL    NOV 1979
C
C
      DIMENSION P(*),RO(1),PCPN(1),D(1),LPLOTQ(*),ORD(101),ORDI(1),
     *   LSYM(1),IDTQ(1),PSBL(1),IQDAY(1)
      DIMENSION CMO(12),NDAYS(12),SCALE(10),UNIT(2),UNITP(2)
C
C     COMMON BLOCKS
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fctime'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fengmt'
      INCLUDE 'common/fpltab'
      INCLUDE 'common/fnopr'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_insqplot/RCS/ex12.f,v $
     . $',                                                             '
     .$Id: ex12.f,v 1.1 1995/09/17 18:56:34 dws Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENTS
C
      DATA CMO/3HJAN,3HFEB,3HMAR,3HAPR,3HMAY,3HJUN,3HJUL,3HAUG,
     13HSEP,3HOCT,3HNOV,3HDEC/
      DATA NDAYS/31,28,31,30,31,30,31,31,30,31,30,31/
      DATA UNIT/3HCFS,3HCMS/,UNITP/2HIN,2HMM/
      DATA SDBG/4HEX12/
C
C     CHECK TRACE LEVEL-FOR THIS ROUTINE=1
C
      IF(ITRACE.GE.1)WRITE(IODBUG,900)
  900 FORMAT(1H0,15H** EX12 ENTERED)
      IF(IPLHY.EQ.-1)GO TO 801
      IF(NOPROT.EQ.1)GO TO 801
C
C     CHECK TO SEE IF SYSTEM DEBUG CODE 'EX12' IS ON
C     THIS PRINTS BEFORE AND AFTER CALL TO PPT12
C
      JBUG=IFBUG(SDBG)
C
C     CHECK TO SEE IF DEBUG OUTPUT IS NEEDED
C
      IBUG=0
      IF(IDBALL.GT.0)IBUG=1
      IF(NDEBUG.EQ.0)GO TO 100
      DO 10 I=1,NDEBUG
      IF(IDEBUG(I).EQ.12) GO TO 11
   10 CONTINUE
      GO TO 100
   11 IBUG=1
  100 NPLOTS=P(7)
      IOPTAB=P(8)
      IOPLT=P(9)
      IF(IPLHY.EQ.1)IOPLT=0
      IDTPLT=P(10)
      IF(IOPTAB.EQ.0)NTAB=0
      IF(IOPTAB.EQ.1)NTAB=1
      IF(IOPTAB.EQ.2)NTAB=1
      IF(IOPTAB.EQ.3)NTAB=2
      NPREQ=11+NTAB*7+NPLOTS*8
      IRC=P(11)
      IF(IRC.GT.0)NPREQ=NPREQ+5
C
C     PRINT DEBUG OUTPUT IF NEEDED
C
      IF(IBUG.EQ.0) GO TO 110
      WRITE(IODBUG,901)NPREQ
  901 FORMAT(1H0,10X,43HCONTENTS OF THE P ARRAY--NUMBER OF VALUES =,
     1I3)
      WRITE(IODBUG,902)(P(I),I=1,NPREQ)
  902 FORMAT(1H0,14(F8.3,1X))
      WRITE(IODBUG,909)
  909 FORMAT(1H0,10X,20HP ARRAY IN A4 FORMAT)
      WRITE(IODBUG,903)(P(I),I=1,NPREQ)
  903 FORMAT(1H0,14(A4,5X))
  110 IPTR=11
      IF(NTAB.EQ.0)GO TO 120
      IF(IOPTAB.EQ.3) GO TO 130
      IF(IOPTAB.EQ.1)IDTPN=P(IPTR+4)
      IF(IOPTAB.EQ.2)IDTRO=P(IPTR+4)
      IPTR=IPTR+7
      GO TO 120
  130 IDTPN=P(IPTR+4)
      IPTR=IPTR+7
      IDTRO=P(IPTR+4)
      IPTR=IPTR+7
  120 DO 140 I=1,NPLOTS
      IF(IOPLT.NE.I)GO TO 121
      DOPT1=P(IPTR+1)
      DOPT2=P(IPTR+2)
      DTYPE=P(IPTR+3)
      IIDT=P(IPTR+4)
  121 IDTQ(I)=P(IPTR+4)
      PSBL(I)=P(IPTR+8)
  140 IPTR=IPTR+8
      KHR=IHR
      KDA=IDA
      IPTIM=0
      CALL MDYH1(IDA,IHR,IMTHST,IDAYST,IYRST,IHRST,NOUTZ,NOUTDS,TZON)
      CALL MDYH1(LDA,LHR,IMTHND,IDAYND,IYRND,IHRND,NOUTZ,NOUTDS,TZON)
      IF(((IYRST/4)*4).EQ.IYRST)NDAYS(2)=29
C
C     CHECK PLOT OPTION
C
      IF(IOPLT.GT.0)GO TO 500
      CALL SCAL12(NPLOTS,IDTQ,LPLOTQ,D,ORD,DIV,SCALE)
      IF(IBUG.EQ.0)GO TO 534
      WRITE(IODBUG,966)(SCALE(K),K=1,10),DIV,(LPLOTQ(L),L=1,NPLOTS)
  966 FORMAT(1H0,10X,5HSCALE/2X,10G12.5/10X,4HDIV=,G12.5/10X,
     16HLPLOTQ/2X,10I8)
C
C     SET INITIAL VALUES AND DETERMINE STARTING AND ENDING REAL TIME
C
  534 KHR=IHR
      KDA=IDA
      IPTIM=0
      CALL MDYH1(IDA,IHR,IMTHST,IDAYST,IYRST,IHRST,NOUTZ,NOUTDS,TZON)
      CALL MDYH1(LDA,LHR,IMTHND,IDAYND,IYRND,IHRND,NOUTZ,NOUTDS,TZON)
      IF(((IYRST/4)*4).EQ.IYRST)NDAYS(2)=29
C
C
C
C     PRINT HEADING AND ADDITIONAL INFORMATION
C
      CALL HDNG12(P,IDTQ,PSBL,CMO,NDAYS,UNIT,UNITP,NPLOTS,IOPTAB,SCALE,
     1  LOCFS,LOCLL,LOCUL,IBUG)
      KDART=IDAYST
      KHRRT=IHRST
      IMTHRT=IMTHST
      IYRRT=IYRST
      KDA=IDA
      KHR=IHR
      IPTIM=0
  499 IPTIM=IPTIM+IDTPLT
C
      IF(JBUG.EQ.1)WRITE(IODBUG,627)
  627 FORMAT(' *** ABOUT TO CALL ROUTINE PPT12 *** FIRST IN EX12')
C
      CALL PPT12(P,D,PCPN,RO,ORDI,PSBL,LSYM,ORD,LPLOTQ,IDTQ,DIV,
     1  KDA,KHR,KDART,KHRRT,IDTPN,IDTRO,NPLOTS,IOPTAB,IPTIM,
     2  IDTPLT,LOCFS,LOCLL,LOCUL,IRC,JBUG)
C
      IF(JBUG.EQ.1)WRITE(IODBUG,628)
  628 FORMAT(' *** BACK IN EX12 FROM PPT12 ***')
C
C    CHECK TIMES AND INCREMENT
C
      IF((KDA.EQ.LDA).AND.(KHR.EQ.LHR))GO TO 800
      ITIME=KHR+IDTPLT
      IF(ITIME.GT.24)GO TO 371
      KHR=KHR+IDTPLT
      GO TO 372
  371 KDA=KDA+1
      KHR=KHR+IDTPLT-24
  372 ITIME=KHRRT+IDTPLT
      IF(ITIME.GT.24)GO TO 373
      KHRRT=KHRRT+IDTPLT
      GO TO 499
  373 KDART=KDART+1
      KHRRT=KHRRT+IDTPLT-24
      NDAYS(2)=28
      IF(((IYRRT/4)*4).EQ.IYRRT) NDAYS(2)=29
      IF(KDART.LE.NDAYS(IMTHRT)) GO TO 499
      KDART=1
      IMTHRT=IMTHRT+1
      IF(IMTHRT.LE.12)GO TO 499
      IMTHRT=1
      IYRRT=IYRRT+1
      GO TO 499
  500 CONTINUE
      NPPDAY=24/IDTPLT
C
      NPOPT=24/IDTQ(IOPLT)
      IDT=IDTQ(IOPLT)
C
C     TEST DAY #1 FOR DATA
C
      KYRT=IYRST
      KMRT=IMTHST
      KDA=IDA
      KHR=IHR
      KDRT=IDAYST
      KHRT=IHRST
      IF(IDTPLT.EQ.IDT) GO TO 501
      KHRT=KHRT+IDT-IDTPLT
      KHR=KHR+IDT-IDTPLT
      IF(KHR.LE.24)GO TO 501
      KHR=KHR-24
      KDA=KDA+1
  501 IQDAY(1)=0
  502 I=(KDA-IDADAT)*24/IDT+KHR/IDT
      LOC=LPLOTQ(IOPLT)+I-1
C
C
C  THIS PRINT STATEMENT IS INSERTED IN AN EFFORT TO NULLIFY CHANGES IN
C  THE CODING RESULTING FROM USING THE OPTIMIZE(2) COMPILER
C  IT DOES NOT ENTER INTO ANY CALCULATIONS
C
      IF(LOC.LT.-1000)WRITE(IPR,997)IQDAY(1)
  997 FORMAT(1H ,5X,G12.5)
C
      IF(D(LOC).LT.0.)GO TO 505
C
      IF(LOC.LT.-1000)WRITE(IPR,997)IQDAY(1)
C
      IQDAY(1)=1
  505 KHRT=KHRT+IDT
      KHR=KHR+IDT
      IF(KHR.LE.24)GO TO 503
      KHR=KHR-24
      KDA=KDA+1
  503 IF(KHRT.LE.24)GO TO 502
      KHRT=IDT
      KDRT=KDRT+1
      IF(KDRT.LE.NDAYS(KMRT))GO TO 504
      KDRT=1
      KMRT=KMRT+1
      IF(KMRT.LE.12)GO TO 504
      KMRT=1
      KYRT=KYRT+1
      NDAYS(2)=28
      IF(((KYRT/4)*4).EQ.KYRT)NDAYS(2)=29
C
C     CHECK REMAINING DAYS
C
  504 J=1
  522 J=J+1
      IQDAY(J)=0
  521 I=(KDA-IDADAT)*24/IDT+KHR/IDT
      LOC=LPLOTQ(IOPLT)+I-1
      IF(D(LOC).GE.0.)IQDAY(J)=1
      KHRT=KHRT+IDT
      KHR=KHR+IDT
      IF(KHR.LE.24) GO TO 519
      KHR=KHR-24
      KDA=KDA+1
  519 IF((KDRT.EQ.IDAYND).AND.(KMRT.EQ.IMTHND)) GO TO 520
       IF(KHRT.LE.24)GO TO 521
      GO TO 498
  520 IF(KHRT.GT.IHRND)GO TO 526
      GO TO 521
  498 KHRT=KHRT-24
      KDRT=KDRT+1
      IF(KDRT.LE.NDAYS(KMRT))GO TO 522
      KDRT=1
      KMRT=KMRT+1
      IF(KMRT.LE.12)GO TO 522
      KMRT=1
      KYRT=KYRT+1
      IF(((KYRT/4)*4).EQ.KYRT)GO TO 525
      NDAYS(2)=28
      GO TO 522
  525 NDAYS(2)=29
      GO TO 522
  526 IPTIM=0
      NDAY=J
      IDATA=0
      DO 222 IJ=1,NDAY
  222 IF(IQDAY(IJ).EQ.1)IDATA=1
      IF(IDATA.EQ.1)GO TO 529
      GO TO 801
  529 IYRRT=IYRST
C
C    DETERMINE MAX AND MIN FLOWS
C
      QMAX=0.
      QMIN=999999.
      IPTIM=IDTPLT
      KDA=IDA
      KHR=IHR
      KDRT=IDAYST
      KHRT=IHRST
      KMTHRT=IMTHST
      NPPDAY=24/IDTPLT
      CALL MAX12(IQDAY,NPLOTS,IPTIM,IDTPLT,IDTQ,LPLOTQ,D,
     1 KHRT,KDRT,KMTHRT,IYRRT,SCALE,DIV,ORD,NDAYS,NDAY,IHRND,NPPDAY)
      IF(IBUG.EQ.0)GO TO 533
      WRITE(IODBUG,966)(SCALE(K),K=1,10),DIV,(LPLOTQ(L),L=1,NPLOTS)
  533 KDA=IDA
      KHR=IHR
      KDRT=IDAYST
      KHRT=IHRST
      KMTHRT=IMTHST
      CALL HDNG12(P,IDTQ,PSBL,CMO,NDAYS,UNIT,UNITP,NPLOTS,IOPTAB,SCALE,
     1  LOCFS,LOCLL,LOCUL,IBUG)
C
C      PLOT DAY # 1 IF NEEDED
C
      IPTIM=IDTPLT
      NPPDAY=24/IDTPLT
  531 IF(IQDAY(1).EQ.0)GO TO 530
C
      IF(JBUG.EQ.1)WRITE(IODBUG,629)
  629 FORMAT(' *** ABOUT TO CALL ROUTINE PPT12 *** SECOND IN EX12')
C
      CALL PPT12(P,D,PCPN,RO,ORDI,PSBL,LSYM,ORD,LPLOTQ,IDTQ,DIV,
     1  KDA,KHR,KDRT,KHRT,IDTPN,IDTRO,NPLOTS,IOPTAB,IPTIM,
     2  IDTPLT,LOCFS,LOCLL,LOCUL,IRC,JBUG)
C
      IF(JBUG.EQ.1)WRITE(IODBUG,628)
C
  530 KHR=KHR+IDTPLT
      IF(KHR.LE.24) GO TO 532
      KHR=KHR-24
      KDA=KDA+1
  532 IPTIM=IPTIM+IDTPLT
      KHRT=KHRT+IDTPLT
      IF(KHRT.LE.24)GO TO 531
      KHRT=KHRT-24
      KDRT=KDRT+1
      IF(KDRT.LE.NDAYS(KMTHRT))GO TO 540
      KDRT=1
      KMTHRT=KMTHRT+1
      IF(KMTHRT.LE.12)GO TO 540
      KMTHRT=1
      IYRRT=IYRRT+1
      IF(((IYRRT/4)*4).EQ.IYRRT)GO TO 541
      NDAYS(2)=28
      GO TO  540
  541 NDAYS(2)=29
  540 KHRT=IDTPLT
      DO 600 J=2,NDAY
      IF(IQDAY(J).EQ.0)GO TO 590
      IF(J.EQ.NDAY)NPPDAY=IHRND/IDTPLT
      DO 601 K=1,NPPDAY
C
      IF(JBUG.EQ.1)WRITE(IODBUG,630)
  630 FORMAT(' *** ABOUT TO CALL ROUTINE PPT12 *** THIRD IN EX12')
C
      CALL PPT12(P,D,PCPN,RO,ORDI,PSBL,LSYM,ORD,LPLOTQ,IDTQ,DIV,
     1  KDA,KHR,KDRT,KHRT,IDTPN,IDTRO,NPLOTS,IOPTAB,IPTIM,
     2  IDTPLT,LOCFS,LOCLL,LOCUL,IRC,JBUG)
C
      IF(JBUG.EQ.1)WRITE(IODBUG,628)
C
      KHR=KHR+IDTPLT
      IF(KHR.LE.24)GO TO 610
      KHR=KHR-24
      KDA=KDA+1
  610 IPTIM=IPTIM+IDTPLT
      KHRT=KHRT+IDTPLT
      IF(KHRT.LE.24)GO TO 601
      KHRT=IDTPLT
      KDRT=KDRT+1
      IF(KDRT.LE.NDAYS(KMTHRT))GO TO 601
      KDRT=1
      KMTHRT=KMTHRT+1
      IF(KMTHRT.LE.12)GO TO 601
      KMTHRT=1
      IYRRT=IYRRT+1
      IF(((IYRRT/4)*4).EQ.IYRRT)GO TO 602
      NDAYS(2)=28
      GO TO 601
  602 NDAYS(2)=29
  601 CONTINUE
      GO TO 600
  590 IF(IQDAY(J-1).EQ.1)WRITE(IPR,929)
  929 FORMAT(1H0)
      IF(J.EQ.NDAY)GO TO 600
      KHRT=IDTPLT
      IPTIM=IPTIM+24
      KDA=KDA+1
      KDRT=KDRT+1
      IF(KDRT.LE.NDAYS(KMTHRT))GO TO 600
      KDRT=1
      KMTHRT=KMTHRT+1
      IF(KMTHRT.LE.12)GO TO 600
      KMTHRT=1
      IYRRT=IYRRT+1
      IF(((IYRRT/4)*4).EQ.IYRRT)GO TO 604
      NDAYS(2)=28
      GO TO 600
  604 NDAYS(2)=29
  600 CONTINUE
  800 WRITE(IPR,929)
C
  801 RETURN
C
      END