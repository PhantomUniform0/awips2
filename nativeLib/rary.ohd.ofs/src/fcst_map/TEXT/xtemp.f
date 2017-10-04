C MEMBER XTEMP
C  (from old member PPXTEMP)
C
      SUBROUTINE XTEMP(FGV,AID,FRN,DID,ONLY,DIST,PP24,PPVR,
     1 PTVR,MDR6,PPSR,PARM,NX,LWORK,IERR)
C.......................................
C     THIS SUBROUTINE WRITES THE DATA NEEDED BY EACH MAP AREA
C       FOR A GIVEN DAY TO THE TEMPORARY FILE FOR THAT DAY.
C.......................................
C     WRITTEN BY -- ERIC ANDERSON, HRL -- FEBRUARY 1983
C.......................................
      INTEGER*2 PP24(1),PPVR(1),PTVR(1),MDR6(1),PPSR(1)
      INTEGER*2 MSNG24,MSNG6,MSGMDR,MSNGSR
      DIMENSION AID(1),FRN(1),ONLY(1),DIST(1),FGV(1),PARM(1)
      DIMENSION AREAID(2),FGN(2),CGN(2),TNAME(2),AONLY(2),ADIST(2)
      DIMENSION SNAME(2),DID(1),DUMMY(20)
C
C     COMMON BLOCKS
      COMMON/PUDBUG/IOPDBG,IPTRCE,NDBUG,PDBUG(20),IPALL
      COMMON/XOPT/IXTYPE,XNAME(2),IESTPX,ICONVC,CNVDIS,CVDISW,
     1 NOEST6,IUSESR,PPUSER(2),IMOSUM,IMOWTR,IWTEST
      COMMON/XTIME/KZDA,KDA,KHR,LSTMO,KMO,KID,KYR,KIH,TZCODE,
     1 ISW,IUTMP,NSSR,IDAY
      COMMON/XSIZE/NMAP,NDUPL,NSLT24,NSLOT6,LDATA6,LMDR,LPPSR,
     1 MSNG24,MSNG6,MSGMDR,MSNGSR,NRECTP,MXTEMP,SMALL
      COMMON/XMDR/MDRSTA,ICTMDR,MDRST6,ICMDR,NCMDR,IRMDR,
     1 NRMDR,NMDR,MDR,MDRNUV
      COMMON/IONUM/IN,IPR,IPU
      COMMON/WHERE/ID(2),IND,SUB(2)
      COMMON/FCTIME/IZDA,IJHRUN,LZDA,LJHRUN,LZDOBS,LJHOBS,NOW(5),
     1 LOCAL,NOUTZ,NOUTDS,NLSTZ,IDA,IHR,LDA,LHR,IZHHDA
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_map/RCS/xtemp.f,v $
     . $',                                                             '
     .$Id: xtemp.f,v 1.1 1995/09/17 19:00:16 dws Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENTS
      DATA XWTF,BLANK/4HXWTF,4H    /
      DATA AMAPS/4HMAPS/
      DATA AONLY,ADIST/4HMDRO,4HNLY ,4HMDRD,4HIST /
      DATA SNAME/4HXTEM,4HP   /
C.......................................
C     CHECK TRACE LEVEL
      IF(IPTRCE.GE.1) WRITE(IOPDBG,900)
  900 FORMAT(1H0,16H** XTEMP ENTERED)
C.......................................
C     CHECK IF DEBUG ON.
      IBUG=0
      IF(IPBUG(AMAPS).EQ.1) IBUG=1
      JBUG=0
      IF (IPBUG(XWTF).EQ.1) JBUG=1
C.......................................
C     SET WHERE COMMON BLOCK.
      IND=-1
      SUB(1)=SNAME(1)
      SUB(2)=SNAME(2)
C.......................................
C     SET INTIAL VALUES
      IERR=0
      NA=0
      NFG=1
      ISONLY=0
      ISDIST=0
      IF (IDAY.EQ.1) NRECTP=0
C.......................................
C     SET CGROUP AND FGROUP NAMES IF NEEDED FOR HIDCHK.
      IF(MDRNUV.EQ.0) GO TO 100
      IF(IXTYPE-2) 101,103,105
  101 DO 102 I=1,2
      CGN(I)=BLANK
  102 FGN(I)=BLANK
      GO TO 100
  103 DO 104 I=1,2
      CGN(I)=BLANK
  104 FGN(I)=XNAME(I)
      GO TO 100
  105 DO 106 I=1,2
      CGN(I)=XNAME(I)
  106 FGN(I)=FGV(I)
      NAFG=FGV(3)
C.......................................
C.......................................
C     BEGIN AREA LOOP.
  100 DO 110 N=1,NMAP
      L=(N-1)*2
      AREAID(1)=AID(L+1)
      AREAID(2)=AID(L+2)
      IF(IXTYPE.NE.3) GO TO 115
C
C     CHECK IF STARTING NEW FGROUP
      NA=NA+1
      IF(NA.LE.NAFG) GO TO 115
      NA=1
      NFG=NFG+1
      I=(NFG-1)*3
      FGN(1)=FGV(I+1)
      FGN(2)=FGV(I+2)
      NAFG=FGV(I+3)
C
C     IF AREAID IS ALL BLANKS--SKIP
  115 IF((AREAID(1).EQ.BLANK).AND.(AREAID(2).EQ.BLANK)) GO TO 110
C.......................................
C     READ MAPS PARAMETERS FOR THE AREA
      TYPE=AMAPS
      IREC=FRN(N)
      CALL RPPREC(AREAID,TYPE,IREC,LWORK,PARM,NFILL,I,ISTAT)
      IF(ISTAT.EQ.0) GO TO 120
      CALL PSTRDC(ISTAT,TYPE,AREAID,IREC,LWORK,NFILL)
      WRITE(IPR,901)
  901 FORMAT(1H0,40H**FATAL ERROR** THE ABOVE ERROR IS FATAL)
      CALL KILLFN(8HMAP     )
      IERR=1
      GO TO 99
  120 IF(IBUG.EQ.1) CALL PDUMPA(NFILL,PARM,TYPE,AREAID,1)
      IF ((IXTYPE.EQ.1).AND.(IDAY.EQ.1)) FRN(N)=IREC+0.01
      MAPRN=PARM(7)
C.......................................
C     SET DEFAULT VALUES AND CHECK FOR NON-UNIVERSAL TECHNIQUES
      JONLY=0
      JDIST=0
      IF(MDRNUV.EQ.0) GO TO 150
      IF(IDAY.EQ.0) GO TO 145
C
C     FIRST DAY--GET NONUNIVERSAL TECHNIQUE VALUES FROM HCL
      IDUPL=0
      IF(IXTYPE.NE.3) GO TO 130
C
C     CARRYOVER GROUP--CHECK IF DUPLICATE AREA.
      IF(NDUPL.EQ.0) GO TO 130
      DO 121 I=1,NDUPL
      J=(I-1)*2+1
      IF((AREAID(1).NE.DID(J)).OR.(AREAID(2).NE.DID(J+1))) GO TO 121
      LDUPL=I
      GO TO 122
  121 CONTINUE
      GO TO 130
C
C     THIS IS A DUPLICATE AREA.
  122 IDUPL=1
      IONLY=ONLY(LDUPL)
      IF (IONLY.EQ.0) GO TO 130
C
C     MDRONLY ON FOR AREA, DON'T HAVE TO COMPUTE AGAIN.
      AID(L+1)=BLANK
      AID(L+2)=BLANK
      GO TO 110
C
C     CALL HIDCHK TO SET MDRONLY AND MDRDIST FOR AREA.
  130 I=0
      CALL HIDCHK(AREAID,FGN,CGN,I,DUMMY,J,K)
C
C     GET VALUE OF TECHNIQUE MDRONLY
      IF (MDRNUV.EQ.2) GO TO 135
      TNAME(1)=AONLY(1)
      TNAME(2)=AONLY(2)
      CALL HPAST(TNAME,IVAL,ISTAT)
      IF(ISTAT.LT.2) GO TO 131
      IF(ISONLY.EQ.1) GO TO 132
      ISONLY=1
      WRITE(IPR,902)TNAME
  902 FORMAT(1H0,10X,25H**WARNING** HCL TECHNIQUE,1X,2A4,1X,
     1 37HIS NOT DEFINED.  VALUE IS SET TO OFF.)
      CALL WARN
  132 IVAL=0
  131 IF((IVAL.EQ.0).OR.(IVAL.EQ.1)) GO TO 133
      WRITE(IPR,903)IVAL,TNAME
  903 FORMAT(1H0,10X,22H**WARNING** A VALUE OF,I3,1X,
     1 25HWAS ENTERED FOR TECHNIQUE,1X,2A4,/16X,
     2 57HONLY VALUES OF 0 OR 1 ARE ALLOWED.  VALUE IS SET TO ZERO.)
      CALL WARN
      IVAL=0
  133 IF(IVAL.EQ.0) GO TO 135
      IF(IDUPL.EQ.1)  ONLY(LDUPL)=1.01
      JONLY=1
      GO TO 140
  135 IF(IDUPL.EQ.0) GO TO 136
      IDIST=DIST(LDUPL)
      IF (IDIST.EQ.0) GO TO 136
C
C     MDRONLY OFF, BUT MDRDIST ON, DON'T HAVE TO COMPUTE AGAIN
      AID(L+1)=BLANK
      AID(L+2)=BLANK
      GO TO 110
C
C     GET VALUE OF TECHNIQUE MDRDIST
  136 IF (MDRNUV.EQ.1) GO TO 140
      TNAME(1)=ADIST(1)
      TNAME(2)=ADIST(2)
      CALL HPAST(TNAME,IVAL,ISTAT)
      IF(ISTAT.LT.2) GO TO 137
      IF(ISDIST.EQ.1) GO TO 138
      ISDIST=1
      WRITE(IPR,902)TNAME
      CALL WARN
  138 IVAL=0
  137 IF((IVAL.EQ.0).OR.(IVAL.EQ.1)) GO TO 139
      WRITE(IPR,903)IVAL,TNAME
      CALL WARN
      IVAL=0
  139 IF(IVAL.EQ.0) GO TO 140
      IF(IDUPL.EQ.1) DIST(LDUPL)=1.01
      JDIST=1
C
C     FOR DAY ONE, STORE THE VALUES OF THE NON-UNIVERSAL TECHNIQUES
C        WITH THE MAPS PARAMETERS AND WRITE BACK TO THE PPPDB.
C        ONLY WRITE TO PPPDB IF MORE THAN ONE DAY IN THE RUN.
  140 IF(IDA.EQ.LDA) GO TO 150
      PARM(14)=JONLY+0.01
      PARM(15)=JDIST+0.01
      CALL WPPREC(AREAID,TYPE,NFILL,PARM,IREC,ISTAT)
      IF(ISTAT.EQ.0) GO TO 144
      WRITE(IPR,904)ISTAT
  904 FORMAT(1H0,74H**FATAL ERROR** COULD NOT WRITE MAPS PARAMETERS BACK
     1 TO THE PPPDB--STATUS=,I2)
      CALL KILLFN(8HMAP     )
      IERR=1
      GO TO 99
  144 IF (IBUG.EQ.1) CALL PDUMPA(NFILL,PARM,TYPE,AREAID,1)
      GO TO 150
C
C     DAY OTHER THAN DAY ONE--GET VALUES OF NON-UNIVERSAL TECHNIQUES
C       FROM THE MAPS RECORD.
  145 JONLY=PARM(14)
      JDIST=PARM(15)
C.......................................
C     REMOVE VALUES FROM MAPS RECORD NEEDED TO DETERMINE WHICH
C      DATA ARE TO BE WRITTEN TO THE TEMPORARY FILE.
  150 NSTWT=PARM(11)
      NPCPN=PARM(12)
      NBOX=PARM(13)
      IF(NBOX.GT.0) GO TO 151
      JONLY=0
      JDIST=0
  151 IDTP=NFILL+1
      IF(NSSR.EQ.0) GO TO 152
      XC=PARM(4)
      YC=PARM(5)
      RI=PARM(6)
  152 I=PARM(8)
      L6=14+I
      L24=L6+NSTWT
      LMR=L24+NPCPN
      LHW=(LWORK-NFILL)*2
      MX=NX+LWORK-1
C.......................................
C     CALL ROUTINE TO SELECT DATA TO BE WRITTEN TO THE TEMPORARY
C      FILE AND STORE IT IN I*2 FORM.
      IF(JBUG.EQ.1) WRITE(IOPDBG,906)AREAID,MAPRN,JONLY,JDIST
  906 FORMAT(1H ,21HTEMP FILE RECORD--ID=,2A4,3I5)
      IF (JBUG.EQ.1) WRITE(IOPDBG,907) NSTWT,NPCPN,NBOX,NX,LWORK,MX,
     1  NFILL,NSSR,L6,L24,LMR,LHW,MSNGSR
  907 FORMAT(1H ,5X,13I8)
      CALL XTMPVL(PP24,NPCPN,PARM(L24),PPVR,PTVR,NSTWT,PARM(L6),
     1 MDR6,NBOX,PARM(LMR),JONLY,JDIST,PPSR,MSNGSR,XC,YC,RI,MX,
     2 LHW,PARM(IDTP),NFHW,N24,N6,NMR,NSR,KONLY,KDIST,JBUG,IERR)
      IF(IERR.EQ.1) GO TO 99
C
C     COMPUTE LENGTH OF DATA VALUES TO BE WRITTEN TO THE
C        TEMPORARY FILE IN FULL WORDS.
      NFULL=(NFHW-1)/2+1
      LDTP=IDTP+NFULL-1
C
C     WRITE RECORD TO TEMPORARY FILE, COUNT NUMBER WRITTEN IF
C         FIRST DAY, AND COMPUTE MAX LENGTH.
      WRITE(IUTMP)AREAID,MAPRN,KONLY,KDIST,N24,N6,NMR,NSR,NFULL,
     1 (PARM(I),I=IDTP,LDTP)
      IF(IDAY.EQ.0) GO TO 155
      NRECTP=NRECTP+1
  155 IF(NFULL.GT.MXTEMP) MXTEMP=NFULL
  110 CONTINUE
C     END OF AREA LOOP
C.......................................
C.......................................
   99 IF(IPTRCE.GE.1) WRITE(IOPDBG,905)
  905 FORMAT(1H0,13H** EXIT XTEMP)
      RETURN
      END