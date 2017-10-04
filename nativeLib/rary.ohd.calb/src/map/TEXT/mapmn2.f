C MODULE MAPMN2
C-----------------------------------------------------------------------
C
      SUBROUTINE MAPMN2 (MC,IP,DIMF,DTYPE,IGS,
     * ANAME,AREAID,BASE,FILES,IMCOR,IND,IOBCGE,MOCHK,NEXTRD,NORMAL,
     * NSEQ,OBTMO,OBTMOX,PCORR,PX,PXSUM,SCORF,STAID,SUN,SW,SWX,
     * TIMEOB,X,XDATA,Y)
C
c   hourly_flag(i,j) = array of flags indicating missing, estimated,d
c                       distributed or observed data
c                    = 0 -- observed
c                    = 1 -- estimated/missing/distributed
c                    - initialized to all 0
c                    - calculated in DISREC/DISNRC
c                    - used in calculation of monthly_flag
c                    - i = station number, j = hour number
c
c   monthly_flag(i,j) = array of flags indicating missing, estimated,
c                        distributed  or observed data
c                     = 0 -- observed
c                     = 1 -- estimated/missing/distributed
c                     - initialized to all 0
c                     - calculated in MPCHEK
c                     - read by IDMA
c                     - i = station number, j = month number
c
c   NCDX = number of hours in the month (defined in subroutine MPDATA)
c   MSEGS is the max number of line segments for basin boundaries
c   MBPTS is the maximum number of basin boundary points
c   NBPTS is the number of basin boundary points
c
c   INDERR = overall error code for input
c            allows for read through all input before calculating map
C
      PARAMETER (MBPTS=3000)
      PARAMETER (MSEGS=3000)
      DIMENSION IY(MSEGS),IXB(MSEGS),IXE(MSEGS)
C
      CHARACTER FILENM*1,FMT*1,FN*112,OFORMAT*12,FN1*12
      CHARACTER*12 BASNID1(50),BASNID2(50)
      CHARACTER*112 FULLNAME(50)
      CHARACTER*4 LABEL,ILABEL,LLABEL,MLABEL
      CHARACTER*4 QLABEL,RLABEL,SLABEL,OLABEL
      CHARACTER*4 UNITA,ENGL
      CHARACTER*4 AUNITS,XMI2
      CHARACTER*30 STRNG
      INTEGER*2 HOURLY_FLAG(200,817),MONTHLY_FLAG(200,600)
      INTEGER BMO,BYR,DEBUG,DEBUGA,EMO,EYR
      INTEGER OBTMO,OBTMOX,OPT1,OPT2,OPT3,OPT4,OPT5,OPT6,OPT8,OPT9
      INTEGER OUTMO,OUTYR,RSTA,OPT10
      REAL NORMAL
C
      DIMENSION ANAME(5,M2),AREAID(3,M2),BASE(3,M3),BX(3000),BY(3000)
      DIMENSION IGS(3,M1),iun(50)
      DIMENSION DUMMY(2),FILES(3,M2),FLON(3000),FNAME(3),IMCOR(M1,MC)
      DIMENSION FLAT(3000)
      DIMENSION IND(M1),IOBCGE(M1,MC),IPT(3000)
      DIMENSION JXX(3000),JYY(3000),JN(3000)
      DIMENSION NEXTRD(M2),NORMAL(M1,12),NPG(3)
      DIMENSION NSEQ(M2),OBTMO(M1),OBTMOX(M1),PCORR(M1,MC),PX(M1,M3)
      DIMENSION PXSUM(M2,M6,12),STACC(2,200),STAID(7,M1),STAWT(200)
      DIMENSION STID(7,200),SUN(2,M3),SW(M1),SWX(M2,M1,2),TIMEOB(M1,MC)
      DIMENSION MOCHK(M3)
      DIMENSION X(M1),XDATA(744,M2),Y(M1)
      DIMENSION SCORF(M1,MC),C(200,817)
      DIMENSION NDUMST(200)
C
      INCLUDE 'uiox'
      INCLUDE 'ucmdbx'
      INCLUDE 'clbcommon/bhtime'
      INCLUDE 'clbcommon/crwctl'
      INCLUDE 'scommon/sntwkx'
      COMMON /DIST/ IHRT,ILE5(200),IGT5(200),ACCMAX(200)
      COMMON /CARRAY/ C
      COMMON /DIM/ M1,M2,M3,M4,M5,M6
      COMMON /MAP/ DEBUG,DEBUGA
      COMMON /LSDTA/ IDEC,BMO,BYR,EMO,EYR,UNITW,FILE(3),TYPE,IT,
     *               TSTAID(3),DESCRP(5),DESCR(5),JMO,JYR,TDATA(744)
      COMMON /MNC1/ AREA,DUNITS,FLAT,FLON,FNAME,FUNITS,ILIST,NDUMST
      COMMON /MNC2/ IMOS,IMOW,IPT,IPUNCH,ISTAT,ISTRT,JB,NBASIN,NFLD
      COMMON /MNC3/ NRSTA,NUM,NUMM5,NUMM6,OBNEW,OPT1,OPT2,OPT3,OPT4
      COMMON /MNC4/ OPT5,OPT6,OPT8,OPT9,OPT10,RSTA,IERR,STMNWT
C
      EQUIVALENCE (FN1,FNAME)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/calb/src/map/RCS/mapmn2.f,v $
     . $',                                                             '
     .$Id: mapmn2.f,v 1.11 2001/06/12 19:44:17 dws Exp $
     . $' /
C    ===================================================================
C
      DATA ILABEL,LLABEL / '@I  ','@L  ' /
      DATA MLABEL,QLABEL / '@M  ','@Q  ' /
      DATA RLABEL,SLABEL / '@R  ','@S  ' /
      DATA OLABEL        / '@O  ' /
      DATA UNITA,ENGL    / 'METR','ENGL' /
      DATA XMI2          / 'MI2 ' /
      DATA BLANK/4H    /
      DATA CFWS/4HW  S/
      DATA JIMM1/0/
      DATA FN/' '/
      DATA OFORMAT/'(4F7.2)     '/
      DATA FULLNAME / 50*' ' /
      DATA BASNID1  / 50*' ' /
      DATA BASNID2  / 50*' ' /
C
C
      ICNT=0
      IUSTOP=0
      LDEBUG=0
      INDERR=0
      FN=FN1
C
C  SET UNIT NUMBER AND OPEN SCRATCH FILE
      ITUNIT=19
      FILENM=' '
      LRECL=745
      FMT='U'
      CALL UPOPEN (ITUNIT,FILENM,LRECL,FMT,IERR)
C
      NN5=0
      NSTART=0
      SUN3=0
      SUN4=0
      X21=0
      X23=0.
      X25=0.
      X26=0.
      IHRT=0
c
      DO 20 J=1,NUM
C     STORE STATION ID IN STID ARRAY
         DO 5 I=1,7
            STID(I,J)=STAID(I,J)
    5       CONTINUE
c     INITIALIZE HOURLY_FLAG AND MONTHLY_FLAG ARRAY TO 0 
         DO 10 I=1,817
            HOURLY_FLAG(J,I)=0
   10       CONTINUE
         DO 15 I=1,600
            MONTHLY_FLAG(J,I)=0
   15       CONTINUE
20       CONTINUE
C
      IF (NBASIN.EQ.0) GO TO 250
C
C  READ AREA INFORMATION
      DO 240 JB=1,NBASIN
         LABEL=ILABEL
         NCHAR=1
C     GET CARD LABEL
30       CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
         IF (ISTAT.EQ.7) GO TO 30
C     GET AREA IDENTIFIER
         NCHAR=-LEN(STRNG)
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,STRNG,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL UMEMOV (STRNG,AREAID(1,JB),3)
         MCHAR=12
         IF (LENGTH.GT.MCHAR) THEN
            CALL UEROR (LP,0,-1)
            WRITE (LP,813) 'AREA IDENTIFIER',LENGTH,MCHAR
            INDERR=1
            ENDIF   
         IF (STRNG.EQ.' ') THEN
            CALL UEROR (LP,0,-1)
            WRITE (LP,815) 'AREA IDENTIFIER'
            INDERR=1
            ELSE
               CALL AFTERU (LATSGN,ITYPEU,STRNG,LABEL,2,ISTAT,LENGTH,
     *            IERR)
               IF (ISTAT.EQ.6) ISTRT=-1
               IF (ISTAT.EQ.6) GO TO 80
               IF (ISTAT.EQ.1.OR.ISTAT.EQ.2) THEN
                  CALL UEROR (LP,0,-1)
                  WRITE (LP,820) 'AREA IDENTIFIER'
                  INDERR=1
                  ENDIF
            ENDIF
C     GET AREA DESCRIPTION
         NCHAR=-LEN(STRNG)
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,STRNG,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL UMEMOV (STRNG,ANAME(1,JB),5)
         MCHAR=20
         IF (LENGTH.GT.MCHAR) THEN
            CALL UEROR (LP,0,-1)
            WRITE (LP,813) 'AREA DESCRIPTION',LENGTH,MCHAR
            INDERR=1
            ENDIF   
         IF (STRNG.EQ.' ') THEN
            CALL UEROR (LP,0,-1)
            WRITE (LP,815) 'AREA DESCRIPTION'
            INDERR=1
            ELSE
               CALL AFTERU (LATSGN,ITYPEU,STRNG,LABEL,2,ISTAT,LENGTH,
     *            IERR)
               IF (ISTAT.EQ.6) ISTRT=-1
               IF (ISTAT.EQ.6) GO TO 80
               IF (ISTAT.EQ.1.OR.ISTAT.EQ.2) THEN
                  WRITE (LP,820) 'AREA DESCRIPTION'
                  INDERR=1
                  ENDIF
            ENDIF
C     GET AREA SIZE
         NCHAR=1
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,AREA,
     *    NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,1,ISTAT,LENGTH,IERR)
         IF (ISTAT.EQ.6) ISTRT=-1
         IF (ISTAT.EQ.6) GO TO 80
C     GET AREA UNITS
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,AUNITS,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,AUNITS,LABEL,2,ISTAT,LENGTH,IERR)
         IF (ISTAT.EQ.6) ISTRT=-1
C     GET BASIN NAME - IF FIELD 5 IS SET TO AREA DESCRIPTION
         NCHAR=3
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,BASNID1(JB),LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,BASNID1(JB),LABEL,2,ISTAT,LENGTH,
     *    IERR)
         IF (ISTAT.EQ.1.OR.ISTAT.EQ.2) THEN
            WRITE (LP,820) 'BASIN NAME'
            INDERR=1
            ENDIF
         IF (ISTAT.EQ.6) THEN 
            BASNID1(JB)=' '
            BASNID2(JB)=' '
            ISTRT=-1
            GO TO 80
            ENDIF
C    GET FILE NAME - IF NOT SPECIFIED TO BASIN NAME 
         NCHAR=3
         CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,BASNID2(JB),LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,BASNID2(JB),LABEL,2,ISTAT,LENGTH,
     *    IERR)
         IF (ISTAT.EQ.1.OR.ISTAT.EQ.2) THEN
            WRITE (LP,820) 'FILE NAME'
            INDERR=1
            ENDIF
         IF (ISTAT.EQ.6) THEN
            BASNID2(JB)=BASNID1(JB)
            ISTRT=-1
            ENDIF
80       CALL UPAGE (IPR)
         WRITE (LP,830) (ANAME(J,JB),J=1,5),(AREAID(J,JB),J=1,3)
C     READ ASSIGNED STATION WEIGHTS, ANNUAL OR SEASONAL
         IF ((OPT1.NE.2).AND.(OPT1.NE.3)) GO TO 150
         IW=1
         IF (OPT1.EQ.3)  IW=2
         LABEL=LLABEL
         NCHAR=1
90       CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
         IF (ISTAT.EQ.7) GO TO 90
         DO 130 IP=1,IW
         DO 100 J=1,NUM
            CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,SW(J),
     *       NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
            CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,1,ISTAT,LENGTH,IERR)
            IF (ISTAT.EQ.6) ISTRT=-1
            IF (ISTAT.EQ.6) GO TO 110
100         CONTINUE
110         CONTINUE
            DO 120 JW=1,NUM
               IF (OPT9.EQ.2.AND.JW.EQ.NUMM5) SW(JW)=0.0
               SWX(JB,JW,IP)=SW(JW)
120            CONTINUE
130         CONTINUE
         WRITE (LP,790) AREA,AUNITS
         WRITE (LP,860)
         IF (OPT1.EQ.2) WRITE (LP,890)
         IF (OPT1.EQ.3) WRITE (LP,900)
         DO 140 J=1,NUM
            IF (OPT1.EQ.2) WRITE (LP,910) J,(STAID(I,J),I=1,7),
     *         SWX(JB,J,1)
            IF (OPT1.EQ.3) WRITE (LP,910) J,(STAID(I,J),I=1,7),
     *         (SWX(JB,J,I),I=1,2)
140         CONTINUE
         GO TO 240
C      READ BASIN BOUNDARY POINTS
150      CALL JREAD(MBPTS,FLAT,FLON,NBPTS,ISTRT,NFLD,ISTAT,LDEBUG,IERR)
         IF (IERR.EQ.-1) THEN
            INDERR=1
            GO TO 250
            ENDIF
C     COMPUTE GRID POINT DEFINITION 
         IF (NBPTS.GT.1) THEN
            IF (AUNITS.EQ.XMI2) UNITA=ENGL
            CALL SFBDRV (BX,BY,FLAT,FLON,IY,IXB,IXE,MSEGS,NBPTS,LFACTR,
     *         AREA,UAREA,CAREA,XC,YC,UNITA,NSEGS,ISTAT)
            IF (ISTAT.NE.0) THEN
               WRITE (LP,160)
               CALL USTOP (LP,IUSTOP)
               ENDIF
C        CONVERT BASIN CENTROID TO LAT/LON AND PRINT
         CALL SBLLGD (CLON,CLAT,1,XC,YC,0,ISTAT)
            DO 170 I=1,NUM
               JXX(I)=X(I)+0.5
               JYY(I)=Y(I)+0.5
170            CONTINUE
C           PLOT STATION LOCATIONS AND PRINT OTHER INFO
            WRITE (LP,840)
            IF (IERR.EQ.0) CALL SBPLOT (2,80,IY,IXB,IXE,NSEGS,X,Y,
     *         JXX,JYY,NUM,LFACTR,XC,YC,JN,ISTAT)
            IF (IERR.GT.0) WRITE (LP,800)
            WRITE (LP,840)
            WRITE (LP,780) CLAT,CLON
            WRITE (LP,790) AREA,AUNITS
            ELSE
               IF (OPT1.NE.4) THEN
                  WRITE (LP,810)
                  INDERR=1
                  GO TO 250
                  ENDIF
               CALL SBLLGD (FLON,FLAT,1,XC,YC,1,ISTAT)
            ENDIF
C     COMPUTE WEIGHTS
         LARRAY=1
         IPARM=2
         DO 180 J=1,M1
            SW(J)=0.0
180         CONTINUE
C     ASSIGN ITYPE USING OPTION 1
         IF (OPT1.EQ.0) ITYPE=1
         IF (OPT1.EQ.1) ITYPE=2
         IF (OPT1.EQ.4) ITYPE=3
         IF ((OPT1.EQ.2).OR.(OPT1.EQ.3)) GO TO 190
         MULT=0
         CALL SFADRV (DUMMY,DUMMY,LARRAY,IPARM,ITYPE,MULT,STMNWT,
     *      NSEGS,LFACTR,IY,IXB,IXE,XC,YC,M1,NSTATN,STAID,STAWT,IPT,
     *      STACC,ISTAT)
C     STORE WEIGHTS IN SW
190      DO 200 I=1,INWFIL
            IF (IPT(I).EQ.0) GO TO 200
               SW(IPT(I))=STAWT(I)
200         CONTINUE
C     CHECK FOR HOURLY AND DAILY STATION AT SAME LOCATION
C     IF FOUND, THEN GIVE WEIGHT TO DAILY STATION
C     WEIGHTING ROUTINES WILL GIVE FIRST STATION IN LIST ALL WEIGHT IN
C     THIS CASE -- HOURLY STATIONS ARE ALWAYS LISTED FIRST FOR MAP
C     CORDNW(1/2,I/J) ARE THE X,Y COORDINATES OF THE STATIONS
         DO 210 I=1,RSTA
            DO 210 J=RSTA+1,NUM
            IF (CORDNW(1,I).EQ.CORDNW(1,J).AND.
     *          CORDNW(2,I).EQ.CORDNW(2,J)) THEN
               IF (SW(I).GT.0.0) THEN
                  SW(J)=SW(I)
                  SW(I)=0.0
                  ENDIF
               ENDIF
210         CONTINUE
C     STORE WEIGHTS IN SWX
         DO 220 JW=1,NUM
            IF (OPT9.EQ.2.AND.JW.EQ.NUMM5) SW(JW)=0.0
            SWX(JB,JW,IP)=SW(JW)
220         CONTINUE
C     WRITE STATION WEIGHTS
         WRITE (LP,870)
         WRITE (LP,1250)
         DO 230 J=1,NUM
            WRITE (LP,1260) J,(STID(I,J),I=1,7),SW(J)
230         CONTINUE
240      CONTINUE
C
      IF (DEBUG.EQ.1) WRITE (LP,1180)
C
C  IF STOP OPTION IS ON OR ERROR OCCURRED WHILE READING INPUT, THEN
C  STOP PROGRAM HERE
250   IF (OPT2.EQ.0) CALL USTOP (LP,IUSTOP)
      IF (IERR.NE.0) CALL USTOP (LP,IUSTOP)
C
C  INITIALIZE OBSERVATION TIME CHANGE ARRAYS
      DO 260 I=1,M1
         DO 260 J=1,MC
            IOBCGE(I,J)=9999
260      CONTINUE
C
C  READ CHANGES IN OBSERVATION TIME
      IF (OPT10.EQ.1) GO TO 320
      IMO=BYR*12+BMO
      CALL UPAGE (IPR)
      WRITE (LP,920)
      WRITE (LP,930)
270   LABEL=MLABEL
      NCHAR=1
280   CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.7) GO TO 280
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JS,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 290
      IF (JS.EQ.999) GO TO 320
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JM,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 290
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JJY,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 290
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,OBNEW,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,1,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
290   IF (DEBUG.EQ.1) WRITE (LP,1190)
      WRITE (LP,940)  JS,(STID(I,JS),I=1,7),JM,JJY,OBNEW
      JS=JS-RSTA
      ICMO=(JJY-1900)*12+JM
      ICMO=ICMO-IMO+1
      DO 300 I=1,MC
         IF (IOBCGE(JS,I).LT.9999) GO TO 300
            IOBCGE(JS,I)=ICMO
            J=I
            GO TO 310
300      CONTINUE
      WRITE (LP,1140)  MC
      CALL USTOP (LP,IUSTOP)
310   TIMEOB(JS,(J+1))=OBNEW
      GO TO 270
C
C  INITIALIZE PRECIPITATION ADJUSTMENT FACTOR ARRAYS
320   DO 330 I=1,M1
         DO 330 J=1,MC
            PCORR(I,J)=1.0
            IMCOR(I,J)=9999
            SCORF(I,J)=BLANK
330      CONTINUE
C
C  READ PRECIPITATION ADJUSTMENT FACTORS
      IF (OPT4.EQ.1) GO TO 390
      IFMON= BYR*12+BMO
      IF (DEBUG.EQ.1) WRITE (LP,1200)
      CALL UPAGE (IPR)
      WRITE (LP,950)
      IF (OPT6.EQ.2) WRITE (LP,990) IMOW,IMOS
      WRITE (LP,960)
340   LABEL=OLABEL
      NCHAR=1
350   CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.7) GO TO 350
      NCHAR=1
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     * NCHAR,SCF,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,2,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 360
      IF (INTEGR.EQ.999) GO TO 380
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JSTA,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 360
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JMO,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 360
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,JJYR,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 360
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,PCOR,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,1,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
360   SCFP=SCF
      IF (SCF.EQ.BLANK)  SCFP=CFWS
      JYR=JJYR-1900
      WRITE (LP,970)  JSTA,(STID(I,JSTA),I=1,7),JMO,JJYR,PCOR,SCFP
      ICMON=JYR*12+JMO
      ICMON=ICMON-IFMON+1
      DO 370 I=1,MC
         IF (IMCOR(JSTA,I).LT.9999) GO TO 370
            IMCOR(JSTA,I)=ICMON
            SCORF(JSTA,I)=SCF
            PCORR(JSTA,I)=PCOR
            GO TO 340
370      CONTINUE
      WRITE (LP,1150) MC
      CALL USTOP (LP,IUSTOP)
380   WRITE (LP,980)
390   CONTINUE
C
      IF (DEBUGA.GT.0) THEN
         WRITE (LP,870)
         DO 400 I=1,MC
            DO 400 J=1,NRSTA
               WRITE (LP,1120)  IOBCGE(I,J)
400         CONTINUE
         WRITE (LP,870)
         DO 410 I=1,MC
            DO 410 J=1,NRSTA
               WRITE (LP,1130)  TIMEOB(I,J)
410         CONTINUE
         ENDIF
C
      IF (INDERR.NE.0) CALL USTOP (LP,IUSTOP)
C
C   READ TIME SERIES HEADER CARDS
      LABEL=QLABEL
      NCHAR=1
430   CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.7) GO TO 430
C
C   IF ERROR HAS OCCURRED READING M,O OR Q CARDS, THEN STOP
      IF (IERR.NE.0) CALL USTOP (LP,IUSTOP)
C
C   READ PRECIPITATION DATA
      CALL UPAGE (IPR)
      CALL MPRDTS (DUNITS,BMO,BYR,EMO,EYR,NUM,RSTA,IMOW,IMOS,
     *   TIMEOB,PCORR,IMCOR,IOBCGE,SCORF,MC,NDUMST,ITUNIT)
C
      IF (DEBUG.EQ.1) WRITE (LP,1210)
      IF (DEBUG.EQ.1) WRITE (LP,1160)
C
      DO 450 I=1,M1
         DO 450 J=1,817
            C(I,J)=0.0
450      CONTINUE
C
C  READ ONE MONTH OF PRECIP DATA FOR EACH STATION INTO C ARRAY
      IFIRST=1
      CALL MPDATA (BMO,BYR,EMO,EYR,NUM,OPT8,KSTART,K1,N,OUTMO,
     *   OUTYR,IEND,NCDX,MOX,MYR,OBTMO,OBTMOX,C,IND,LT,LS,
     *   ITUNIT,IFIRST)
      IF (DEBUGA.EQ.1) WRITE (LP,1110) (J,OBTMO(J),OBTMOX(J),J=1,NUM)
C
      DO 460 J=1,M1
         ACCMAX(J)=0.
         ILE5(J)=0
         IGT5(J)=0
460      CONTINUE
C
c  BEGIN LOOP ON MONTH
c
470   CONTINUE
C
C  CHECK RECORDER STATIONS (hourly data) FOR MISSING OR ACCUMULATED DATA AND
C  ESTIMATE OR DISTRIBUTE ACCORDING TO OTHER RECORDER (hourly) STATIONS
C
      CALL DISREC  (RSTA,KSTART,K1,OPT9,NUMM5,N,OUTMO,DUNITS,OPT8,X,Y,
     *               C,IND,STID,NORMAL,hourly_flag)
C
C  DISTRIBUTE NON RECORDER (daily data) STATIONS DATA ACCORDING TO TIME OF
C  OBSERVATION AND RECORDER (hourly) STATION NETWORK
c
      CALL DISNRC  (RSTA,KSTART,K1,NUM,OPT9,NUMM5,N,OUTMO,DUNITS,OPT8,
     *               X,Y,OBTMO,OBTMOX,C,IND,STID,NORMAL,hourly_flag)
C
C  CALCULATE ONE MONTH OF MAP FOR GIVEN INCREMENT OF TIME.
      N=IT
      K1=K1-49
C
      IF (OPT6.EQ.0) GO TO 480
C
C  CHECK DATA FOR EXTREME PRECIP VALUES
      CALL MPCHEK (NUM,RSTA,BMO,BYR,EMO,EYR,NSTART,DUNITS,OPT8,OPT9,
     *   NUMM5,PX,MT,C,STID,MOCHK,MCC,hourly_flag,monthly_flag)
C
480   IF (NBASIN.EQ.0) GO TO 550
      IF (DEBUG.EQ.1) WRITE (LP,1220)
C
C   PRINT PRECIP DATA FOR COMPARISON
C
C   NUMM5 = SEQUENCE NUMBER OF STATION TO BE REPLACED
C   NUMM6 =     "        "  "  DUMMY STATION
C
      IF (OPT9.EQ.1) GO TO 540
      CALL UPAGE (IPR)
      WRITE (LP,1020) NUMM5,NUMM6
C
      K=0
      KDAY=N
C
      DO 530 I=1,NUM
      IF (I.EQ.NUMM5) GO TO 490
      GO TO 510
490   WRITE (LP,1030) NUMM5
      IF (I.GT.RSTA) GO TO 500
C
      WRITE (LP,1000) (C(I,J),J=25,768)
      GO TO 510
500   K=OBTMO(NUMM5)+24
      KK=(K+(KDAY-1)*24)
      WRITE (LP,1010) (C(NUMM5,II),II=K,KK,24)
510   IF (I.EQ.NUMM6) GO TO 520
      GO TO 530
520   WRITE (LP,1030) NUMM6
      WRITE (LP,1000) (C(I,J),J=25,768)
530   CONTINUE
C
C  CALL ROUTINE FOR STATISTICAL ANALYSIS
C
      CALL MPSTAT (NUMM5,NUMM6,NUM,JIMM1,SUN3,SUN4,
     *   RSTA,K,KK,X25,X26,NN5,X21,X23,SUN,C)
C
C  COMPUTE MAP
C
  540 continue
      CALL MPCMPT (NBASIN,K1,N,NUM,OPT3,OPT8,OUTMO,OUTYR,
     *   DTYPE,IT,DUNITS,FUNITS,DIMF,IPUNCH,MOX,MYR,ANAME,AREAID,SWX,C,
     *   PXSUM,BMO,BYR,EMO,EYR,IMOW,IMOS,OPT1,iun,fullname,ICNT,
     *   basnid1,basnid2)
C
C  REINITIALIZE THE FIRST 3 DAYS OF C ARRAY AND HOURLY_FLAG ARRAY
C   MOVE LAST 3 DAYS OF C ARRAY DATA TO POSITIONS FOR FIRST 3 DAYS
C   LAST 3 DAYS IN C ARRAY CONSIST OF LAST DAY OF CURRENT MONTH AND
C   FIRST 2 DAYS OF NEXT MONTH
C
  550 DO 560 J=1,NUM
         DO 560 K=1,72
            C(J,K)=0.0
            HOURLY_FLAG(J,K)=0
560      CONTINUE
C
      DO 570 J=1,NUM
         DO 570 K=1,72
            JX=NCDX+K
            C(J,K)=C(J,JX)
            HOURLY_FLAG(J,K)=HOURLY_FLAG(J,JX)
570      CONTINUE
C
      IF (MOX.EQ.EMO.AND.MYR.EQ.EYR) GO TO 580
      IFIRST=0
      CALL MPDATA (BMO,BYR,EMO,EYR,NUM,OPT8,KSTART,K1,N,OUTMO,
     *   OUTYR,IEND,NCDX,MOX,MYR,OBTMO,OBTMOX,C,IND,LT,LS,
     *   ITUNIT,IFIRST)
      IF (IEND.EQ.0) GO TO 470
C
580   CALL UPAGE (IPR)
      WRITE (LP,590)
      WRITE (LP,600)DUNITS
      JJ=RSTA+1
      DO 620 N=JJ,NUM
         WRITE (LP,610)N,(STID(I,N),I=1,7),ILE5(N),IGT5(N),ACCMAX(N)
620      CONTINUE
      WRITE (LP,630) IHRT
      WRITE (LP,640)
C
C  CLOSE ALL OUTPUT FILES
      CALL CCLOSL
      CALL UPCLOS (ITUNIT,' ',ICOND)
C
C  LIST MAP DATA FROM DATA FILE
      IF (ILIST.EQ.0.OR.OPT5.EQ.0) GO TO 650
         DO 647 MM=1,NBASIN
            CALL MPLSTS (FULLNAME(MM),MM,XDATA)
  647       CONTINUE
C
650   IF (OPT6.EQ.0) GO TO 730
C      
C   READ R AND S CARDS
      LABEL=RLABEL
      NCHAR=1
660   CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) GO TO 660
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,NG,UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 680
      IF (NG.EQ.0) GO TO 720
      DO 670 IG=1,NG
      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,NPG(IG),UREAL,
     * NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
      CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
      IF (ISTAT.EQ.6) ISTRT=-1
      IF (ISTAT.EQ.6) GO TO 680
670   CONTINUE
680   CONTINUE
      LABEL=SLABEL
      DO 710 IG=1,NG
         NCHAR=1
690      CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,INTEGR,UREAL,
     *    NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
         CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,3,ISTAT,LENGTH,IERR)
         IF (ISTAT.EQ.7) GO TO 690
         NUM=NPG(IG)
         DO 700 I=1,NUM
            CALL UFIELD (NFLD,ISTRT,LENGTH,ITYPEU,NREP,IGS(IG,I),UREAL,
     *       NCHAR,UCHAR,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
            CALL AFTERU (LATSGN,ITYPEU,UCHAR,LABEL,0,ISTAT,LENGTH,IERR)
            IF (ISTAT.EQ.6) ISTRT=-1
            IF (ISTAT.EQ.6) GO TO 720
700         CONTINUE
710      CONTINUE
C
C   IF ERROR OCCURRED READING R OR S CARDS, THEN STOP
720   IF (IERR.NE.0) CALL USTOP (LP,IUSTOP)
C
C  PRINT CONSISTENCY PLOTS
      CALL PLOTD (NUM,STID,BMO,BYR,DUNITS,IMOW,IMOS,IGS,NG,NPG,
     *   BASE,OPT6,PX,MT,C,monthly_flag)
C
730   IF (OPT9.EQ.1) GO TO 760
      IF (DEBUG.EQ.1) WRITE (LP,1240)
C
C  PRINT BIAS AND RMS
      CALL UPAGE (IPR)
      WRITE (LP,1040)
      WRITE (LP,1050)
      DO 740 I=1,JIMM1
            WRITE (LP,1060) SUN(1,I),SUN(2,I),I
740   CONTINUE
      WRITE (LP,1070)
      WRITE (LP,1060) SUN3,SUN4
      IF (NUMM5.GT.RSTA) GO TO 750
         WRITE (LP,1080) X25,X26
         AVEP=SUN3/NN5
         WRITE (LP,1100) AVEP,NN5
         GO TO 770
750   WRITE (LP,1090)
C
760   IF (NBASIN.EQ.0) GO TO 770
C
C  PRINT MAP SUMMARY TABLE
      CALL MPSMRY (PXSUM,NBASIN,BMO,BYR,EMO,EYR,ANAME,AREAID,
     *   IMOW,IMOS,DUNITS)
C
770   RETURN
C
160   FORMAT ('0*** ERROR - THE BASIN BOUNDARY DEFINITION IS ',
     *   ' INCORRECT.')
590   FORMAT (// T35,'SUMMARY TABLE OF DISTRIBUTION MESSAGES ' //
     * ' DAILY VALUES THAT COULD NOT BE DISTRIBUTED:')
600   FORMAT (1H0,T44,'NUMBER OF DAILY OBS. NOT DISTRIBUTED:',T90,
     *      'MAX. PRECIPITATION' /
     *   T7,7HSTATION,T17,7HSTATION,T44,'PRECIP <= 0.5 IN',
     *      T64,'PRECIP > 0.5 IN ',T89,'VALUE WHICH COULD NOT' /
     *   T7,6HNUMBER,T17,4HNAME,T47,'(1.25 CM)',T67,'(1.25 CM)',
     *      T88,'BE DISTRIBUTED  (',A4,')' /
     *  T7,7('-'),T17,23('-'),T43,18('-'),T63,18('-'),T88,22('-'))
610   FORMAT(1HO,T8,I3,T17,6A4,A1,T49,I4,T69,I4,T94,F5.2)
630   FORMAT ('0NUMBER OF HOURLY VALUES THAT COULD NOT BE ESTIMATED = ',
     *  I6 /
     * ' PRECIPITATION IS SET TO ZERO FOR ALL HOURLY STATIONS FOR ',
     *  'EACH OF THESE HOURS')
640   FORMAT ('0**NOTE** IF THE NUMBER OF HOURS THAT COULD NOT BE ',
     *   'ESTIMATED IS HIGH, SIGNIFICANT BIAS MAY BE INTRODUCED INTO ',
     *   'THE MAP FOR THE BASIN.' /
     * ' MORE HOURLY STATIONS SHOULD BE ADDED TO THE ANALYSIS.' /
     * ' IF ANY DAILY STATIONS HAVE LARGE NUMBERS OF DAILY ',
     *   'OBSERVATIONS (RELATIVE TO THE OTHER STATIONS) THAT WERE NOT ',
     *   'DISTRIBUTED, ' /
     * ' EITHER THE OBSERVATION TIME MAY BE WRONG OR MORE HOURLY ',
     *   'STATIONS NEED TO BE ADDED TO THE ANALYSIS.')
780   FORMAT(// 3X,'COMPUTED BASIN CENTROID:  LAT=',F6.2,5X,'LON=',F7.2)
790   FORMAT(/ 3X,'BASIN AREA = ',F6.0,1X,A3)
800   FORMAT('0*** NOTE - PLOT OMITTED DUE TO PREVIOUS ERROR.')
810   FORMAT('0*** ERROR - WEIGHTING OPTION SPECIFIED ON CARD B',
     *   1X,'CANNOT BE USED WITH BASIN CENTROID.')
813   FORMAT ('0*** ERROR - NUMBER OF CHARACTERS IN ',A,' (',I2,
     *   ') EXCEEDS THE MAXIMUM ALLOWED (',I2,').')
815   FORMAT ('0*** ERROR - ',A,' IS BLANK.')
820   FORMAT ('0*** ERROR - INVALID ',A,'.')
830   FORMAT(// 30X,'*** AREA:  ',5A4,' ***' /
     *   30X,'*** ID:  ',3A4,10X,' ***')
840   FORMAT(' ',1X,80('*'))
860   FORMAT (1H0)
870   FORMAT (///)
890   FORMAT (T3,7HSTATION,T24,7HSTATION,T45,7HSTATION /
     * T3,6HNUMBER,T25,4HNAME,T45,6HWEIGHT  /
     * T3,7H-------,T15,25H-------------------------,T45,7H-------)
900   FORMAT (T3,7HSTATION,T24,7HSTATION,T45,15HSTATION  WEIGHT  /
     *        T3,6HNUMBER,T25,4HNAME,T45,15HWINTER   SUMMER   /
     *        T3,7H-------,T15,25H-------------------------,
     *        T45,15H---------------     )
910   FORMAT (1H ,T5,I3,T15,6A4,A1,T46,F5.2,4X,F5.2)
920   FORMAT(// 20X,'*** OBSERVATION TIME CHANGES ***')
930   FORMAT (1H0,T72,3HNEW  /  T5,7HSTATION,T26,7HSTATION,T68,
     *        11HOBSERVATION   /
     *        T5,6HNUMBER,T27,4HNAME,T47,5HMONTH,T58,4HYEAR,T72,
     *        4HTIME    /
     *        T5,7H-------,T17,25H-------------------------,T47,
     *        5H-----,T58,4H---- ,T68,11H-----------  )
940   FORMAT (1H0,T7,I3,T17,6A4,A1,T48,I3,T58,I4,T71,F4.0)
950   FORMAT(// 20X,'*** PRECIPITATION ADJUSTMENT FACTORS ***')
960   FORMAT (1H0,T68,13HPRECIPITATION ,T86,9HSEASON OF    /
     *        T5,7HSTATION,T26,7HSTATION,T69,10HADJUSTMENT ,
     *        T86,10HADJUSTMENT  /
     *        T5,6HNUMBER,T27,4HNAME,T47,5HMONTH,T58,4HYEAR,T71,
     *        6HFACTOR ,T88,6HFACTOR  /
     *        T5,7H-------,T17,25H-------------------------,T47,
     *        5H-----,T58,4H---- ,T68,13H------------- ,
     *        T86,10H----------     )
970   FORMAT (1H0,T7,I3,T17,6A4,A1,T48,I3,T58,I4,T71,F5.2,T89,A4)
980   FORMAT ( / 1H0,T87,8HW=WINTER  /  T87,8HS=SUMMER  )
990   FORMAT (/25H0WINTER BEGINS IN MONTH  ,I2  /
     *          24H0SUMMER BEGINS IN MONTH  ,I2   )
1000  FORMAT (5X,24F5.2)
1010  FORMAT (20X,10F7.2)
1020  FORMAT (1H1,32HPRECIP COMPARISON FOR STATIONS  ,I5,5H AND ,I5)
1030  FORMAT (1H0,5X,23HPRECIP DATA FOR STATION,I5)
1040  FORMAT (69H MONTHLY SUMS OF OBSERVED AND CALCULATED PRECIP FOR THE
     * SAME LOCATION)
1050  FORMAT (20X,10HOBSERVED  ,10X,10HSIMULATED ,10X,5HMONTH)
1060  FORMAT (25X,F7.2,15X,F7.2,10X,I5)
1070  FORMAT (1H0,42H PRECIPITATION TOTALS FOR SELECTED PERIOD-)
1080  FORMAT (5X,16HPERCENT BIAS IS ,F9.2,5X,9H  RMS IS ,F9.2  )
1090  FORMAT (5X,67HBIAS AND RMS NOT CALCULATED IF REPLACED STATION IS A
     * DAILY STATION.       )
1100  FORMAT (5X,32HAVERAGE HOURLY OBSERVED EVENT   ,F8.4,5X,29HTOTAL NU
     *MBER OF HOURLY EVENTS,I5)
1110  FORMAT (1X,3I10)
1120  FORMAT (1H ,40I3)
1130  FORMAT (1H ,40F3.0)
1140  FORMAT ('0***ERROR - MAXIMUM NUMBER OF OBSERVATION TIME ',
     *   'CHANGES (',I2,') EXCEEDED.')
1150  FORMAT ('0***ERROR - MAXIMUM NUMBER OF PRECIPITATION CORRECTION ',
     *   'FACTORS (',I2,' EXCEEDED.')
1160  FORMAT ( 8H0TRACE 6 )
1180  FORMAT ( 8H0TRACE13 )
1190  FORMAT ( 8H0TRACE14 )
1200  FORMAT ( 8H0TRACE15 )
1210  FORMAT ( 8H0TRACE16 )
1220  FORMAT ( 8H0TRACE17 )
1240  FORMAT ( 8H0TRACE20 )
1250  FORMAT(T3,7HSTATION,T24,7HSTATION /
     * T3,6HNUMBER,T25,4HNAME,T45,6HWEIGHT /
     * T3,7H-------,T15,25H-------------------------,T45,6H------  )
1260  FORMAT(1H ,T5,I2,T15,6A4,A1,T45,F5.2)
C
      END