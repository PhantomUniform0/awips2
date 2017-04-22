      SUBROUTINE RDCLXS55(XFACT,J,I1,IN1,L,HS,FKC,FMC,FKF,FMF,
     1 FKO,FMO,SLFI,CHNMN,CHNMX,NODESC,K2,K4,K9)

      CHARACTER*80 DESC
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/IONUM/IN,IPR,IPU
      DIMENSION HS(K9,K2,1),FKC(K4,1),FMC(K4,1),FKF(K4,1)
      DIMENSION FMF(K4,1),FKO(K4,1),FMO(K4,1),CHNMN(K4,1)
      DIMENSION CHNMX(K4,1),SLFI(K2,1)
      CHARACTER*8 SNAME
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_fldwav/RCS/rdclxs55.f,v $
     . $',                                                             '
     .$Id: rdclxs55.f,v 1.2 2004/02/02 20:39:52 jgofus Exp $
     . $' /
C    ===================================================================
C
      DATA SNAME/'RDCLS55 '/

      CALL FPRBUG(SNAME, 1, 55, IBUG)

C.......................................................................
C     KAM   --  METHOD FOR READING IN CROSS-SECTION FOR CALIBRATION
C     CHNMN --  MINIMUM ACCEPTABLE CALIBRATED MANNING N VALUE
C     CHNMX --  MAXIMUM ACCEPTABLE CALIBRATED MANNING N VALUE
C.......................................................................
      READ(IN,'(A)',END=1000) DESC
      READ(IN,2071) KAM,CHNMN(L,J),CHNMX(L,J),SXS
      IF(CHNMN(L,J).LT.0.001) CHNMN(L,J)=0.003
      IF(CHNMX(L,J).LT.0.001) CHNMX(L,J)=0.15
      IF(NODESC.EQ.0)THEN
      IF(IBUG.EQ.1) WRITE(IODBUG,800)
  800 FORMAT(//
     .10X,'KAM  = METHOD FOR READING IN CROSS-SECTION FOR CALIBRATION'/
     .10X,'CHNMN= MINIMUM ACCEPTABLE CALIBRATED MANNING N VALUE'/
     .10X,'CHNMX= MAXIMUM ACCEPTABLE CALIBRATED MANNING N VALUE'/)
      ENDIF
      IF(IBUG.EQ.1) WRITE(IODBUG,114) L,J
  114 FORMAT(/
     .7X,3HKAM,5X,5HCHNMN,5X,5HCHNMX,7X,3HSXS,3X,2HL=,I3,2X,2HJ=,I2)
      IF(IBUG.EQ.1) WRITE(IODBUG,2071) KAM,CHNMN(L,J),CHNMX(L,J),SXS
      SLFI(I1,J)=SXS/XFACT
      I11=I1+1
      DO 500 I=I11,IN1
  500 SLFI(I,J)=SLFI(I1,J)
      IF(KAM.EQ.0) GO TO 506
C.......................................................................
C     FKC  --   CHANNEL PORTION OF SYNTHETIC SECTION SCALING SWITCH
C     FMC  --   CHANNEL PORTION OF SYNTHETIC SECTION SHAPE FACTOR
C     FKF  --   FLOODPLAIN PORTION OF SYNTHETIC SECTION SCALING SWITCH
C     FMF  --   FLOODPLAIN PORTION OF SYNTHETIC SECTION SHAPE FACTOR
C     FKO  --   INACTIVE PORTION OF SYNTHETIC SECTION SCALING SWITCH
C     FMO  --   INACTIVE PORTION OF SYNTHETIC SECTION SHAPE FACTOR
C     HB   --   ELEVATION OF SECTION AT TOP OF BANK (CALIBRATION)
C     HF   --   ELEVATION OF SECTION AT TOP OF FLOODPLAIN
C.......................................................................
      READ(IN,'(A)',END=1000) DESC
      READ(IN,2070) FKC(L,J),FMC(L,J),FKF(L,J),FMF(L,J),FKO(L,J),
     1  FMO(L,J),HB,HF
      IF(NODESC.EQ.0)THEN
      IF(IBUG.EQ.1) WRITE(IODBUG,803)
  803 FORMAT(//
     .10X,'FKC  = CHANNEL PORTION OF SYNTHETIC SECTION SCALING SWITCH'/
     .10X,'FMC  = CHANNEL PORTION OF SYNTHETIC SECTION SHAPE FACTOR'/
     .10X,'FKF  = FLOODPLAIN PORTION OF SYN SECTION SCALING SWITCH'/
     .10X,'FMF  = FLOODPLAIN PORTION OF SYN SECTION SHAPE FACTOR'/
     .10X,'FKO  = INACTIVE PORTION OF SYN SECTION SCALING SWITCH'/
     .10X,'FMO  = INACTIVE PORTION OF SYN SECTION SHAPE FACTOR'/
     .10X,'HB   = ELEVATION OF SECTION AT TOP OF BANK'/
     .10X,'HF   = ELEVATION OF SECTION AT TOP OF FLOODPLAIN'/)
      ENDIF
      IF(IBUG.EQ.1) WRITE(IODBUG,230)
  230 FORMAT(/
     .7X,3HFKC,7X,3HFMC,7X,3HFKF,7X,3HFMF,7X,3HFKO,7X,3HFMO,8X,2HHB,8X,
     .2HHF)
      IF(IBUG.EQ.1) WRITE(IODBUG,2070)FKC(L,J),FMC(L,J),FKF(L,J),
     . FMF(L,J),FKO(L,J),FMO(L,J),HB,HF
      GO TO 555
C.......................................................................
C     B1    --  ACTIVE TOPWIDTH AT DEPTH Y1 (CALIBRATION)
C     B2    --  ACTIVE TOPWIDTH AT DEPTH Y2 (CALIBRATION)
C     B3    --  ACTIVE TOPWIDTH AT DEPTH Y3 (CALIBRATION)
C     B4    --  ACTIVE TOPWIDTH AT DEPTH Y4 (CALIBRATION)
C     B5    --  INACTIVE TOPWIDTH AT DEPTH Y3 (CALIBRATION)
C     B6    --  INACTIVE TOPWIDTH AT DEPTH Y4 (CALIBRATION)
C.......................................................................
  506 READ(IN,'(A)',END=1000) DESC
      READ(IN,2070) B1,B2,B3,B4,B5,B6
      IF(NODESC.EQ.0)THEN
      IF(IBUG.EQ.1) WRITE(IODBUG,801)
  801 FORMAT(//
     .10X,'B1   = ACTIVE TOPWIDTH AT DEPTH Y1 (CALIBRATION)'/
     .10X,'B2   = ACTIVE TOPWIDTH AT DEPTH Y2 (CALIBRATION)'/
     .10X,'B3   = ACTIVE TOPWIDTH AT DEPTH Y3 (CALIBRATION)'/
     .10X,'B4   = ACTIVE TOPWIDTH AT DEPTH Y4 (CALIBRATION)'/
     .10X,'B5   = INACTIVE TOPWIDTH AT DEPTH Y3 (CALIBRATION)'/
     .10X,'B6   = INACTIVE TOPWIDTH AT DEPTH Y4 (CALIBRATION)'/)
      ENDIF
      IF(IBUG.EQ.1) WRITE(IODBUG,618)
  618 FORMAT(/
     .8X,2HB1,8X,2HB2,8X,2HB3,8X,2HB4,8X,2HB5,8X,2HB6)
      IF(IBUG.EQ.1) WRITE(IODBUG,2070)B1,B2,B3,B4,B5,B6
C.......................................................................
C     Y1    --  DEPTH OF TYPICAL SEC AT MIDPT BET INVERT & TOP BANK
C     Y2    --  DEPTH OF TYPICAL SECTION AT TOP OF BANK
C     Y3    --  DEPTH BET TOP OF BANK & ESTIMATED MAX FLOOD ELEVATION
C     Y4    --  DEPTH OF TYPICAL CROSS SECTION AT MAX FLOOD ELEVATION
C.......................................................................
      READ(IN,'(A)',END=1000) DESC
      READ(IN,2070) Y1,Y2,Y3,Y4
      IF(ABS(Y1).LT.0.01) Y1=Y2/5.
      IF(ABS(Y3).LT.0.01) Y3=Y2+(Y4-Y2)/5.
      IF(NODESC.EQ.0)THEN
      IF(IBUG.EQ.1) WRITE(IODBUG,802)
  802 FORMAT(//
     .10X,'Y1   = DEPTH OF TYPICAL SEC AT MIDPT BET INVERT & TOP BANK'/
     .10X,'Y2   = DEPTH OF TYPICAL SECTION AT TOP OF BANK'/
     .10X,'Y3   = DEPTH BET TOP OF BANK & ESTIMATED MAX FLOOD ELEV.'/
     .10X,'Y4   = DEPTH OF TYPICAL CROSS SECTION AT MAX FLOOD ELEV.'/)
      ENDIF
      IF(IBUG.EQ.1) WRITE(IODBUG,126)
  126 FORMAT(/
     .8X,2HY1,8X,2HY2,8X,2HY3,8X,2HY4)
      IF(IBUG.EQ.1) WRITE(IODBUG,2070)Y1,Y2,Y3,Y4
      IF(B1.LT.3.0) FMC(L,J)=B1
      IF(B1.LT.3.0) GO TO 510
      FMC(L,J)=(ALOG10(B2)-ALOG10(B1))/(ALOG10(Y2)-ALOG10(Y1))
  510 FKC(L,J)=B2/(Y2**FMC(L,J))
      HB=Y2
      IF(B4.LT.3.0) GO TO 515
      IF(B3.LT.5.0) FMF(L,J)=B3
      IF(B3.LT.5.0) GO TO 525
      GO TO 520
  515 FMF(L,J)=0.0
      FKF(L,J)=0.0
      GO TO 530
  520 FMF(L,J)=(ALOG10(B4-B2)-ALOG10(B3-B2))/(ALOG10(Y4-Y2)-
     1   ALOG10(Y3-Y2))
  525 FKF(L,J)=(B4-B2)/(Y4-Y2)**FMF(L,J)
  530 IF(B6.GT.2.0) GO TO 540
      FMO(L,J)=0.0
      FKO(L,J)=0.0
      GO TO 550
  540 FMO(L,J)=(ALOG10(B6)-ALOG10(B5))/(ALOG10(Y4-Y2)-ALOG10(Y3-Y2))
      FKO(L,J)=B6/(Y4-Y2)**FMO(L,J)
  550 CONTINUE
      HF=Y4-Y2
  555 CONTINUE
      IF(HF.LT.0.01) HF=1.0
      FAC=5.0
      IF(FMC(L,J).GT.1.05) FAC=2.0
      HS(2,I1,J)=HS(1,I1,J)+HB/FAC
      HS(3,I1,J)=HS(1,I1,J)+HB
      FAC=5.0
      IF(FMF(L,J).GT.1.05) FAC=2.0
      HS(4,I1,J)=HS(3,I1,J)+HF/FAC
      HS(5,I1,J)=HS(3,I1,J)+HF
      HS(6,I1,J)=HS(5,I1,J)+100.
 2070 FORMAT(8F10.2)
 2071 FORMAT(I10,7F10.4)
 2072 FORMAT(8I10)
C      IF(IBUG.EQ.1) WRITE(IODBUG,11111)
11111 FORMAT(1X,'** EXIT RDCLXS **')
      GO TO 2000
 1000 IF(IBUG.EQ.1) WRITE(IODBUG,1010)
 1010 FORMAT(/5X,'**ERROR** END OF FILE ENCOUNTERED WHILE READING INPUT
     *.  PROGRAM TERMINATED.'/)
 2000 RETURN
      END
