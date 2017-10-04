C MODULE TESTI
C-----------------------------------------------------------------------
C
      SUBROUTINE TESTI (IARY,MIARY,NTOTM,IMONTH,IDAY,IYEAR,IPART,MSNG,
     1 NSTA,IORD,IER)
C
C   THIS ROUTINE ESTIMATES THE MISSING DATA AND CALCULATES THE
C   6 HOUR MEANS FOR THE INSTANTANEOUS STATIONS.
C
C   THIS ROUTINE WAS ORIGINALLY WRITTEN BY GERALD N. DAY .
C
      CHARACTER*1 KODE,O,E,C,II,SYMBOL
C
      CHARACTER*8 STAID

      INTEGER*2 IARY,ITP12,INSTT,ITI,ITI1,ITI2,ITX1,ITX2,MAXT,
     1 MINT,MSNG,IORD,M1,M2
C
      DIMENSION PTI(3,4),WTI(3,4),DESCR(5),DUM(2)
      DIMENSION OLDOPN(2),KODE(10),IARY(1),INSTT(8),IORD(1)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/pudbug'
      INCLUDE 'common/fctime'
      INCLUDE 'common/tscrat'
      INCLUDE 'common/tloc'
      INCLUDE 'common/tout'
      INCLUDE 'common/tary'
C
      EQUIVALENCE (ARY(2),STAID),(ARY(5),DESCR(1)),(ARY(83),STATE)
      EQUIVALENCE (ARY(42),PTI(1,1)),(ARY(54),WTI(1,1))
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_mat/RCS/testi.f,v $
     . $',                                                             '
     .$Id: testi.f,v 1.4 2000/07/21 19:18:46 page Exp $
     . $' /
C    ===================================================================
C
      DATA TEMP/4hTEMP/,BLANK/4h    /
      DATA O/1h /,E/1hE/,C/1hC/,II/1hI/
C
C
      IF (IPTRCE.GE.1) WRITE (IOPDBG,*) 'ENTER TESTI'
C
      IBUG=IPBUG('ESTI')
C
      IOPNUM=-1
      CALL FSTWHR ('TESTI   ',IOPNUM,OLDOPN,IOLDOP)
C
      IF (IBUG.GT.0) THEN
         WRITE(IOPDBG,910)
  910 FORMAT(' AT START OF TESTI - IARY AND ARY ARRAYS:')
         WRITE(IOPDBG,920) (IARY(I),I=1,LAST)
  920 FORMAT(5X,20I6)
         WRITE(IOPDBG,930) (ARY(I),I=ISTDAT,IUSE)
  930 FORMAT(5X,10F10.2)
         ENDIF
C
      IFLAG=1
      IER=0
C
      LHOURS=24
      IF (IPART.EQ.1) LHOURS=LHRCPD
C
C   LOOP THROUGH MAX/MIN POINTER ARRAY LOOKING FOR STATIONS WITH
C   INST. DATA. IF NSTA=0 THE STATIONS ARE PROCESSED IN THE ORDER
C   THEY ARE STORED IN THE MAX/MIN POINTER ARRAY. IF NSTA>0 THE
C   THE STATIONS ARE PROCESSED IN THE ORDER SPECIFIED BY THE
C   IORD ARRAY.
C
      LOC=LOCMP
      MAXSTA=NTOTM
      IF (NSTA.EQ.0) GO TO 16
      MAXSTA=NSTA
   16 CONTINUE
      DO 800 I=1,MAXSTA
      IPOS=I
      IF (NSTA.EQ.0) GO TO 18
      LOC=LOCMP+IORD(I)-1
      IPOS=IORD(I)/5+1
   18 IF (IARY(LOC).EQ.0) GO TO 790
      IF (IARY(LOC+2).LE.0) GO TO 790
C
C   STATION HAS INST. DATA
C
      KNTMSN=0
      IPREC=IARY(LOC)
      DUM(1)=BLANK
      DUM(2)=BLANK
C
C   READ TEMPERATURE PARAMETERS
C
      LIMIT=ISTDAT-1
      NPREC=-IPREC
      CALL RPPREC (DUM,TEMP,NPREC,LIMIT,ARY,NFILL,IPTRNX,ISTAT)
      IF (ISTAT.NE.0) THEN
         CALL PSTRDC (ISTAT,TEMP,DUM,IPREC,LIMIT,NFILL)
         IER=1
         GO TO 999
	 ENDIF
C
C  GET STATION PARAMETERS FROM THE ARY ARRAY
      IF (IBUG.GT.0) CALL PDUMPA (NFILL,ARY,TEMP,DUM,1)
C
C  CHECK IF NETWORK HAS BEEN RUN FOR THIS STATION.
      INETWK=ARY(16)
      IF (INETWK.EQ.0) GO TO 790
C
      NUM=ARY(4)
C
C  GET POINTERS
      LMEAN=IARY(LOC+1)
      LIP=IARY(LOC+2)
      ICFMAX=IARY(LOC+3)
      ICFMIN=IARY(LOC+4)
      LMD=IPOS*2-1
      MAXT=IARY(LOCMD+LMD-1)
      MINT=IARY(LOCMD+LMD)
      LID=IARY(LOCIP+LIP+1)
C
C   SET UP DISPLAY CODES
      SYMBOL=O
      IF (ICFMAX.NE.0.OR.ICFMIN.NE.0) SYMBOL=C
      KODE(1)=O
      KODE(2)=O
      IF (IPART.EQ.1) GO TO 22
      IF (ICFMAX.NE.0) KODE(1)=C
      IF (ICFMIN.NE.0) KODE(2)=C
C
C   GET TIME INTERVAL. IF IDT=1,3   3 HR. DATA TREAT AS 3 HR. STATION
C                    IF IDT=-1,-3   3 HR. DATA TREAT AS 6 HR. STATION
C
   22 IDTEFF=IARY(LOCIP+LIP)
      IF (IABS(IDTEFF).EQ.1) IDTEFF=IDTEFF*3
      IDT=IDTEFF
      ISKIP=1
      IF (IDTEFF.GT.0) GO TO 23
      IDT=IABS(IDTEFF)
      IDTEFF=6
      ISKIP=IDTEFF/IDT
   23 NINST=LHOURS/IDTEFF
C
C   IF IDTEFF = 3 , THERE SHOULD BE NO MISSING DATA.
C
C
C   CHECK IF PREVIOUS 12Z VALUE WAS MISSING
C
      IF (IARY(LOCP12+IPOS-1).GT.MSNG) GO TO 50
C
C********************************************************
C
C   THIS SECTION IS USED TO ESTIMATE THE PREVIOUS 12Z VALUE,
C   IF IT COULD NOT BE ESTIMATED YESTERDAY. THE PROGRAM SHOULD
C   NEVER REACH HERE IF WE ARE TREATING THE STATION AS A
C   3 HR. STATION.
C
      KK=1
      DO 25 L=1,NINST
      IF (IARY(LOCID+LID-2+KK*ISKIP).GT.MSNG) GO TO 30
      KK=KK+1
   25 CONTINUE
C
C   PREV. VALUE CAN'T BE ESTIMATED
C
      ITP12=MSNG
      KNTMSN=1
      GO TO 55
C
C   USE KK TH VALUE FOR ESTIMATION
C
   30 ITX2=IARY(LOCID+LID-2+KK*ISKIP)
      SUMD=0.
      SUMN=0.
      DO 40 J=1,4
      DO 35 K=1,3
      LIPE=PTI(K,J)
      IF (LIPE.LE.0) GO TO 35
      IDTE=IARY(LOCIP+LIPE)
      IDTE=IABS(IDTE)
      IF (IDTE.EQ.1) IDTE=3
      ISKIPE=IDTEFF/IDTE
      LIDE=IARY(LOCIP+LIPE+1)
      ITI2=IARY(LOCID+LIDE-2+KK*ISKIPE)
      IF (ITI2.LE.MSNG) GO TO 35
      LMPE=IARY(LOCIP+LIPE-1)
      IE=(LMPE-1)/5
      ITI=IARY(LOCP12+IE)
      IF (ITI.LE.-4000) GO TO 35
      W=WTI(K,J)
      Q=(ITI+ITX2-ITI2)*W
      SUMN=SUMN+Q
      SUMD=SUMD+W
      GO TO 40
   35 CONTINUE
   40 CONTINUE
      IF (SUMD.LE.5.0E-08) GO TO 45
C
C   PREVIOUS 12Z VALUE IS ESTIMATED
C
      ITP12=SUMN/SUMD
      GO TO 55
   45 CONTINUE
C
C*********************************************************
C
C   PREVIOUS 12Z VALUE COULD NOT BE ESTIMATED.
C
      ITP12=MSNG
      KNTMSN=1
      GO TO 55
C
C   PREVIOUS 12Z VALUE WAS AVAILABLE.
C
   50 ITP12=IARY(LOCP12+IPOS-1)
      IF (ITP12.LT.-4000) ITP12=ITP12+5000
C
C   CHECK IF ANY INST. VALUES ARE MISSING
C
   55 DO 230 N=1,NINST
      I1=0
      I2=0
      KODE(2+N)=SYMBOL
      IF (IARY(LOCID+LID-2+N*ISKIP).GT.MSNG) GO TO 220
C
C   MISSING INST. VALUE FOUND
C   FIND T1.
C
      IF (N.GT.1) GO TO 65
C
C   FIRST VALUE IS MISSING
C
   60 IF (IARY(LOCP12+IPOS-1).LT.-4000) GO TO 90
      ITX1=ITP12
      ITIME1=0
      I1=1
      GO TO 90
C
   65 ITIME1=N-1
      L2=N-1
      DO 70 L=1,L2
      IF (IARY(LOCID+LID-2+ITIME1*ISKIP).GT.MSNG) GO TO 80
      ITIME1=ITIME1-1
   70 CONTINUE
      GO TO 60
C
   80 ITX1=IARY(LOCID+LID-2+ITIME1*ISKIP)
      I1=1
C
C   FIND T2
C
   90 IF (N.EQ.NINST) GO TO 120
      ITIME2=N+1
      L2=NINST-N
      DO 100 L=1,L2
      IF (IARY(LOCID+LID-2+ITIME2*ISKIP).GT.MSNG) GO TO 110
      ITIME2=ITIME2+1
  100 CONTINUE
      GO TO 120
  110 ITX2=IARY(LOCID+LID-2+ITIME2*ISKIP)
      I2=1
C
C   ESTIMATE THE MISSING VALUE.
C
  120 SUMD=0.
      SUMN=0.
      DO 200 J=1,4
      DO 190 K=1,3
      IST1=0
      IST2=0
      LIPE=PTI(K,J)
      IF (LIPE.LE.0) GO TO 190
C
C   GET TIME INTERVAL OF ESTIMATOR STATION
C
      IDTE=IARY(LOCIP+LIPE)
      IDTE=IABS(IDTE)
      IF (IDTE.EQ.1) IDTE=3
      ISKIPE=IDTEFF/IDTE
      LIDE=IARY(LOCIP+LIPE+1)
C
C   SEE IF ESTIMATOR STATION HAS VALUE AT T
C
      IF (IARY(LOCID+LIDE-2+ISKIPE*N).LE.MSNG) GO TO 190
      ITI=IARY(LOCID+LIDE-2+ISKIPE*N)
C
      IF (I1.EQ.0) GO TO 130
C
C   SEE IF ESTIMATOR STATION HAS VALUE AT T1
C
      IF (ITIME1.NE.0) GO TO 125
C
C   T1 IS PREVIOUS 12Z
C
      LMPE=IARY(LOCIP+LIPE-1)
      IE=(LMPE-1)/5
      IF (IARY(LOCP12+IE).LT.-4000) GO TO 130
C
C   FOUND P12Z VALUE
C
      ITI1=IARY(LOCP12+IE)
      IST1=1
      GO TO 130
C
C   REGULAR DATA VALUE
C
  125 IF (IARY(LOCID+LIDE-2+ITIME1*ISKIPE).LE.MSNG) GO TO 130
C
C   FOUND T1 VALUE
C
      ITI1=IARY(LOCID+LIDE-2+ITIME1*ISKIPE)
      IST1=1
C
C   FIND T2 VALUE
C
  130 IF (I2.EQ.0) GO TO 140
      IF (IARY(LOCID+LIDE-2+ITIME2*ISKIPE).LE.MSNG) GO TO 140
C
C   FOUND T2
C
      ITI2=IARY(LOCID+LIDE-2+ITIME2*ISKIPE)
      IST2=1
      GO TO 160
  140 IF (IST1.EQ.0) GO TO 190
C
C   ESTIMATOR FOUND
C
  160 W=WTI(K,J)
      IF (IST1.EQ.0) GO TO 170
      IF (IST2.EQ.1) GO TO 175
C
C   T1 ONLY
C
      Q=(ITI+ITX1-ITI1)*W
      GO TO 180
C
C   T2 ONLY
C
C
  170 Q=(ITI+ITX2-ITI2)*W
      GO TO 180
C
C   T1 AND T2
C
  175 Q=(ITI+(ITX1-ITI1)*1.*(ITIME2-N)/(ITIME2-ITIME1)+
     1 (ITX2-ITI2)*1.*(N-ITIME1)/(ITIME2-ITIME1))*W
C
  180 SUMN=SUMN+Q
      SUMD=SUMD+W
      GO TO 200
C
  190 CONTINUE
  200 CONTINUE
      IF (SUMD.GT.5.0E-08) GO TO 210
C
C   NO ESTIMATOR FOUND
C
      INSTT(N)=MSNG
      KODE(2+N)=O
      KNTMSN=KNTMSN+1
      GO TO 230
C
C   MISSING VALUE IS ESTIMATED
C
  210 INSTT(N)=SUMN/SUMD
      KODE(2+N)=E
      IF (MINT.LE.MSNG) GO TO 215
         IF (INSTT(N).GE.MINT) GO TO 215
         IF (IBUG.GT.0) WRITE(IPR,620) DUM,INSTT(N),MINT,IMONTH,IDAY,
     *      IYEAR
         INSTT(N)=MINT
         GO TO 230
  215 IF (MAXT.LE.MSNG) GO TO 230
         IF (INSTT(N).LE.MAXT) GO TO 230
         IF (IBUG.GT.0) WRITE(IPR,630) DUM,INSTT(N),MAXT,IMONTH,IDAY,
     *      IYEAR
         INSTT(N)=MAXT
         GO TO 230
C
C   INST. VALUE IS AVAILABLE
C
  220 INSTT(N)=IARY(LOCID+LID-2+N*ISKIP)
  230 CONTINUE
C
      IF (IPART.EQ.1) GO TO 350
C
      IF (KNTMSN.EQ.0) GO TO 280
C
C   ALL VALUES WERE NOT ESTIMATED
C
      IF (KNTMSN.EQ.1) GO TO 250
C
C   MORE THAN ONE VALUE IS MISSING, SET POINTER TO INST DATA
C   NEGATIVE TO INDICATE MAX/MIN STATION ONLY.
C
  240 IARY(LOC+2)=-IARY(LOC+2)
      GO TO 800
C
C   ONE VALUE WAS NOT ESTIMATED
C
  250 IF (MAXT.LE.MSNG.OR.MINT.LE.MSNG) GO TO 240
C
C   MAX AND MIN ARE AVAILABLE TO ESTIMATE 1 MISSING VALUE.
C
      AVG=(MAXT+MINT)/2
      SUM=0.0
      IF (ITP12.GT.MSNG) GO TO 260
C
C   PREVIOUS 12Z IS THE MISSING VALUE
C
      N2=NINST-1
      DO 255 N=1,N2
         SUM=SUM+INSTT(N)
  255    CONTINUE
      SUM=SUM+INSTT(NINST)/2.
      ITP12=(AVG*NINST-SUM)*2.
      IF (ITP12.GE.MINT) GO TO 258
         IF (IBUG.GT.0) WRITE(IPR,620) DUM,ITP12,MINT,IMONTH,IDAY,
     *      IYEAR
  620 FORMAT(' STATION ',2A4,' ESTIMATED VALUE ',I5,
     1 ' IS LESS THAN DAILY MINIMUM ',I5,' ON DAY ',I2,'/',I2,'/',I4,
     2 ' - VALUE SET TO THE MINIMUM')
         ITP12=MINT
         GO TO 280
  258 IF (ITP12.LE.MAXT) GO TO 280
         IF (IBUG.GT.0) WRITE (IPR,630) DUM,ITP12,MAXT,IMONTH,IDAY,
     *      IYEAR
  630 FORMAT(' STATION ',2A4,' ESTIMATED VALUE ',I5,
     1 ' IS GREATER THAN DAILY MINIMUM ',I5,' ON DAY ',I2,'/',I2,'/',I4,
     2 ' - VALUE SET TO THE MAXIMUM')
         ITP12=MAXT
         GO TO 280
C
  260 SUM=ITP12
      N2=NINST-1
      IMSN=NINST
      DO 270 N=1,N2
      IF (INSTT(N).GT.MSNG) GO TO 265
      IMSN=N
      GO TO 270
  265 SUM=SUM+INSTT(N)
  270 CONTINUE
C
      IF (IMSN.EQ.NINST) GO TO 274
      SUM=SUM+INSTT(NINST)/2.
      INSTT(IMSN)=AVG*NINST-SUM
      KODE(2+IMSN)=E
      GO TO 276
C
C   LAST VALUE IS MISSING
C
  274 INSTT(NINST)=(AVG*NINST-SUM)*2.
      KODE(2+NINST)=E
C
  276 IF (INSTT(IMSN).GE.MINT) GO TO 278
         IF (IBUG.GT.0) WRITE(IPR,620) DUM,INSTT(IMSN),MINT,IMONTH,IDAY,
     *      IYEAR
         INSTT(IMSN)=MINT
         GO TO 280
  278 IF (INSTT(IMSN).LE.MAXT) GO TO 280
         IF (IBUG.GT.0) WRITE(IPR,630) DUM,INSTT(IMSN),MAXT,IMONTH,IDAY,
     *      IYEAR
         INSTT(IMSN)=MAXT
C
C   ESTIMATION COMPLETE FOR INST. VALUES
C
  280 IF (MAXT.GT.MSNG.AND.MINT.GT.MSNG) GO TO 350
C
C  MAX, MIN OR BOTH ARE MISSING -  ESTIMATE FROM INSTANTANEOUS VALUES
C
      M1=ITP12
      M2=ITP12
      DO 290 N=1,NINST
         IF (INSTT(N).GT.M2) M2=INSTT(N)
         IF (INSTT(N).LT.M1) M1=INSTT(N)
  290    CONTINUE
      IRANGE=M2-M1
C
      IF (MAXT.GT.MSNG) GO TO 300
C
C   ESTIMATE THE MAX
C
      ADJMAX=0.13*IDTEFF/6
      MAXT=ADJMAX*IRANGE+M2
      KODE(1)=II
C
C   CHECK THAT MAX IS NOT GREATER THAN ANY INST VALUES
C
c  this estimated MAXT should be saved back in to the IARY array
      IARY(LOCMD+LMD-1) = maxt
C
      IF (IDT.EQ.IDTEFF) GO TO 300
      NUMI=LHOURS/IDT
      DO 295 N=1,NUMI
         IF (IARY(LOCID+LID-2+N).LE.MSNG) GO TO 295
         IF (IARY(LOCID+LID-2+N).GT.MAXT) MAXT=IARY(LOCID+LID-2+N)
  295    CONTINUE
C
c  this estimated MAXT should be saved back in to the IARY array
cew do this line again incase the maxt has been changed
      IARY(LOCMD+LMD-1) = maxt
C
  300 IF (MINT.GT.MSNG) GO TO 350
C
C   ESTIMATE THE MIN FROM INSTANTANEOUS VALUES
C
      ADJMIN=0.03*IDTEFF/6
      MINT=M1-(ADJMIN*IRANGE)
      KODE(2)=II
C
C   CHECK THAT MINT IS NOT LESS THAN ANY INST VALUES
C
c  this estimated MINT should be saved back in to the IARY array
      IARY(LOCMD+LMD) = mint
C
      IF (IDT.EQ.IDTEFF) GO TO 350
      NUMI=LHOURS/IDT
      DO 320 N=1,NUMI
         IF (IARY(LOCID+LID-2+N).LE.MSNG) GO TO 320
         IF (IARY(LOCID+LID-2+N).LT.MINT) MINT=IARY(LOCID+LID-2+N)
  320    CONTINUE
C
c  this estimated MINT should be saved back in to the IARY array
cew do this line again incase the maxt has been changed
      IARY(LOCMD+LMD) = mint
C
C   FINISHED MAX/MIN ESTIMATION
C
  350 IF (IPRIO.EQ.0) GO TO 360
      IF (IPRLST.EQ.1.AND.IDA.NE.LDACPD) GO TO 360
C
C   DISPLAY INST. DATA
C
      CALL TDSPI(NUM,STAID,STATE,DESCR,MAXT,MINT,INSTT,NINST,IDTEFF,
     1 KODE,IFLAG)
      IFLAG=0
C
C   CALCULATE THE 6 HR MEANS FOR THE INST. DATA
C
  360 L6M=LOC6M+(IPOS-1)*4
      LOCDV=ISTDAT+(LIP-1)/3*4
      CALL TMEANI (MAXT,MINT,ITP12,INSTT,NINST,IDTEFF,IARY(L6M),
     1 ARY(LOCDV),IPART,MSNG,STAID)
C
      IF (IPART.EQ.1) GO TO 790
C
C   UPDATE THE DAY (PUT THE CURRENT VALUES IN THE PREV.) VALUE ARRAYS.
C
      CALL TUPDAT (MAXT,MINT,INSTT,NINST,IARY,LOC,0,KODE,MSNG)
C
  790 IF (NSTA.GT.0) GO TO 800
      LOC=LOC+5
      IF (LOC.GT.MIARY) THEN
         WRITE (IPR,640) MIARY
  640 FORMAT ('0**ERROR** ATTEMPT TO EXCEED THE LENGTH OF THE ',
     1    ' IARY ARRAY (',I6,').')
         CALL ERROR
            IER=1
         GO TO 999
	 ENDIF
800   CONTINUE
C
      IF (IBUG.GT.0) THEN
         WRITE(IOPDBG,940)
  940 FORMAT(' AT END OF TESTI - IARY AND ARY ARRAYS:')
         WRITE(IOPDBG,920) (IARY(I),I=1,LAST)
         WRITE(IOPDBG,930) (ARY(I),I=ISTDAT,IUSE)
	 ENDIF
C
  999 CALL FSTWHR (OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      RETURN
C
      END