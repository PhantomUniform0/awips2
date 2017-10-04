C MEMBER FPROPS
C  (from old member FCFPROPS)
C
      SUBROUTINE FPROPS(NUMOP,ISFG,NDATES,MDATES,JDAYS,IHRS,ITITLE)
C.......................................
C     THIS SUBROUTINE CONTROLS THE DISPLAY OF CARRYOVER VALUES AND
C     SELECT PARAMETERS FOR CERTAIN KEY OPERATIONS.  IT IS CALLED
C     FOR EACH OPERATION AND FORECAST OR CARRYOVER GROUP TO
C     BE DISPLAYED BY PRINTOPS COMMAND IN FCINIT.  THE FCRUNC
C     COMMON BLOCK IS FILLED IN THE CALLING ROUTINE.
C.......................................
C     INITIALLY WRITTEN BY --ERIC ANDERSON, HRL   MARCH 1982
C  MODIFIED TO ADD SNOW-17 OPERATION -- GEORGE SMITH, HRL, JAN 1988
C  ALSO ADDED IDSEGX VARIABLE FOR TEMP STORAGE OF SEGMENT ID
C  MODIFIED TO ADD SNOW-43 OPERATION -- RUSS ERB, HRL, MAY 1997
C.......................................
      DIMENSION JDAYS(MDATES), IHRS(MDATES), IOTIME(3,20), DUMMY(2)
      DIMENSION IDSEGX(2)
C
C     COMMON BLOCKS
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fctime'
      INCLUDE 'common/fcrunc'
      INCLUDE 'common/fp'
      INCLUDE 'common/ft'
      INCLUDE 'common/fts'
      INCLUDE 'common/fcsegn'
      INCLUDE 'common/fcsegc'
      INCLUDE 'common/fccgd'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_printops/RCS/fprops.f,v $
     . $',                                                             '
     .$Id: fprops.f,v 1.2 1997/06/24 19:53:02 page Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENT
      DATA SP,ST/2HP ,2HT /
      DATA IBLNK/4H    /
C.......................................
C     CHECK TRACE LEVEL--TRACE LEVEL=1.
      IF(ITRACE.GE.1) WRITE(IODBUG,900)
 900  FORMAT(1H0,17H** FPROPS ENTERED)
C.......................................
C     CHECK IF DEBUG ON
      IBUG=IFBUG(4HPROP)+IFBUG(4HPRPX)
C
C     INITIALIZE VALUES.
      NXD=1
      NXOLDP=1
      IFLUSH=0
      LINE=0
C
C     STORE CARRYOVER DISPLAY DATES IN MM/DD-HR FORM--NORMAL
C        FGROUP OR CGROUP.
      IF (ISFG.EQ.1) GO TO 100
      DO 101 I=1,NDATES
      CALL MDYH1(JDAYS(I),IHRS(I),IOTIME(1,I),IOTIME(2,I),
     1   J,IOTIME(3,I),NOUTZ,NOUTDS,TZC)
 101  CONTINUE
      NUMD=NDATES
C.......................................
C     BEGIN SEGMENT LOOP.
C     READ FCSEGSTS FILE AND GET P AND T ARRAYS
 100  IOPT=1
      J=0
      IREC=IRSGEX(ISEGEX)
      CALL FGETSG(DUMMY,IREC,MP,P,MT,T,MTS,TS,IOPT,J,IER)
      IF(IER.EQ.0) GO TO 105
      GO TO 199
 105  IF(ISFG.EQ.0) GO TO 120
C.......................................
C     SPECIAL FGROUP-GET CARRYOVER DATES FOR CURRENT SEGMENT.
      J=0
      CALL FCDATE(IDSEGN,J)
      IDC(1)=IBLNK
      IDC(2)=IBLNK
      N=0
      IF(NDATES.LT.0) GO TO 110
C
C     CHECK THAT ALL DATES TO BE DISPLAYED EXIST FOR THIS
C     SPECIAL FGROUP.  SET JDAYS( ) TO NEGATIVE IF DATE
C     DOES NOT EXIST FOR THIS GROUP.
      NUMD=NDATES
      DO 106 I=1,NUMD
      DO 107 J=1,NSLOTS
      IF(ICDAYC(J).EQ.0) GO TO 108
      IF((ICDAYC(J).EQ.JDAYS(I)).AND.(ICHRC(J).EQ.IHRS(I))) GO TO 109
 107  CONTINUE
 108  JDAYS(I)=-JDAYS(I)
      GO TO 106
 109  N=N+1
 106  CONTINUE
      IF(N.GT.0) GO TO 120
C     NONE OF THE DATES TO BE DISPLAYED EXIST FOR THIS SEGMENT.
C        GO ON TO THE NEXT SEGMENT
      GO TO 180
C
C     FIND MOST RECENT CARRYOVER DATES FOR SEGMENT AND
C        STORE IN JDAYS( ),IHRS( ) IN ASCENDING ORDER.
 110  CALL FCOBBL(ICDAYC,ICHRC,NSLOTS)
      NUMD=-NDATES
      J=NSLOTS-NUMD
      DO 111 I=1,NUMD
      JDAYS(I)=ICDAYC(J+I)
      IHRS(I)=ICHRC(J+I)
      IF(JDAYS(I).GT.0) N=N+1
 111  CONTINUE
      IF(N.GT.0) GO TO 120
C
C     NO CARRYOVER DATES EXIST--GO TO NEXT SEGMENT.
      GO TO 180
C.......................................
C  COPY SEGMENT ID INTO TEMPORARY VARIABLE BEFORE CALLING FPRXXX SUBS
C
 120  IDSEGX(1)=IDSEGN(1)
      IDSEGX(2)=IDSEGN(2)
C
C     PRINT DEBUG IF REQUESTED.
      IF(IBUG.EQ.0) GO TO 121
      WRITE(IODBUG,902)NUMOP,IDSEGX,ISEGEX,NSEGEX,IREC,ISFG,
     1   NXD,NXOLDP,IFLUSH,LINE,NUMD,(JDAYS(I),IHRS(I),I=1,NUMD)
 902  FORMAT(1H0,20HFPROPS DEBUG--NUMOP=,I2,1X,7HIDSEGX=,2A4,1X,
     17HISEGEX=,I3,1X,7HNSEGEX=,I3,1X,5HIREC=,I5,1X,5HISFG=,I1,
     21X,4HNXD=,I4,1X,7HNXOLDP=,I4,1X,7HIFLUSH=,I1,1X,
     35HLINE=,I2,1X,5HNUMD=,I2,/1X,8HCO DATES,1X,10(I7,I3))
      IF (IBUG.LT.2.OR.IFLUSH.EQ.1) GO TO 121
      CALL FDMPT(ST,T,MT)
      CALL FDMPA(SP,P,MP)
C.......................................
C     CALL ROUTINE THAT STORES AND DISPLAYS VALUES FOR THE
C       REQUESTED OPERATION.
C.......................................
C  SAC-SMA OPERATION
 121  IF(NUMOP.NE.1) GO TO 122
      CALL FSVSAC(IDSEGX,NUMD,MDATES,JDAYS,IHRS,ISFG,
     1   P,MP,T,MT,NXD,NXOLDP,IOTIME,IFLUSH,LINE,IBUG,ITITLE)
C.......................................
C  SNOW-17 OPERATION
 122  IF(NUMOP.NE.19) GO TO 123
      CALL FSVSNW(IDSEGX,NUMD,MDATES,JDAYS,IHRS,ISFG,
     1   P,MP,T,MT,NXD,NXOLDP,IOTIME,IFLUSH,LINE,IBUG,ITITLE)
C.......................................
C  SNOW-43 OPERATION
 123  IF(NUMOP.NE.31) GO TO 180
      CALL FSVS43(IDSEGX,NUMD,MDATES,JDAYS,IHRS,ISFG,
     1   P,MP,T,MT,NXD,NXOLDP,IOTIME,IFLUSH,LINE,IBUG,ITITLE)
C.......................................
C     INCREMENT TO THE NEXT SEGMENT
 180  IF(IFLUSH.EQ.1) GO TO 199
      IF(ISEGEX.EQ.NSEGEX) GO TO 190
      ISEGEX=ISEGEX+1
      IF(ISFG.EQ.0) GO TO 100
      IF(NDATES.LT.0) GO TO 100
      DO 181 I=1,NDATES
      IF(JDAYS(I).LT.0)JDAYS(I)=-JDAYS(I)
 181  CONTINUE
      GO TO 100
C.......................................
C     FLUSH DISPLAY ARRAYS BEFORE RETURN.
 190  IF(NXD.EQ.1) GO TO 199
      IFLUSH=1
      GO TO 120
C.......................................
C     EXIT SUBROTUINE
 199  IF(ITRACE.GE.1)WRITE(IODBUG,901)
 901  FORMAT(1H0,14H** EXIT FPROPS)
C.......................................
      RETURN
      END