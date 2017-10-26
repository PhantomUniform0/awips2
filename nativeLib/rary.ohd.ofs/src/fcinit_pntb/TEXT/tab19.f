C MEMBER TAB19
C  (from old member FCTAB19)
C
      SUBROUTINE TAB19(TO,LEFT,IUSET,NXT,LPS,PS,LCS,TS,MTS,NWORK,
     1   LWORK,IDT)
C.......................................
C     THIS IS THE OPERATION TABLE ENTRY SUBROUTINE FOR THE 'SNOW-17 '
C        OPERATION.
C.......................................
C     SUBROUTINE INITIALLY WRITTEN BY...
C        ERIC ANDERSON - HRL   MAY 1980

CVK     MODIFIED 4/00 BY V. KOREN: SIMULATED SNOW DEPTH ADDED
cav     Added Observed snow depth 6/2003
C.......................................
      INTEGER TO(1)
      DIMENSION TS(MTS),PS(1)
      DIMENSION SNAME(2)
C
C     COMMON BLOCK
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/FPROG/MAINUM,VERS,VDATE(2),PNAME(5),NDD
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_pntb/RCS/tab19.f,v $
     . $',                                                             '
     .$Id: tab19.f,v 1.5 2006/10/03 19:33:26 hsu Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENT
      DATA SNAME/4HTAB1,4H9   /
C.......................................
C     TRACE LEVEL=1,DEBUG SWITCH=IBUG
      CALL FPRBUG(SNAME,1,19,IBUG)
C.......................................
C     INITIAL VALUES
CVK  LENGTH OF TO ARRAY IS INCREASED BY ONE DUE TO INCLUDE 
CVK  SIMULATED SNOW DEPTH TIME SERIES
CVK      LENGTH=14
cav  Added Observed snow depth
cav      LENGTH=15
      LENGTH=16
C.......................................
C     CHECK IF SPACE IS AVAILABLE IN T().
      CALL CHECKT(LENGTH,LEFT,IERR)
      IF(IERR.EQ.0) GO TO 100
      IUSET=0
      IDT=0
      LWORK=0
      RETURN
C.......................................
C     SPACE IS AVAILABLE--MAKE ENTRIES INTO TO().
  100 TO(1)=19
      TO(2)=NXT+LENGTH
      TO(3)=LPS
      TO(4)=LCS
C
C     PRECIPITATION TIME SERIES.
      ITPX=PS(10)
      CALL CKINPT(PS(7),PS(9),ITPX,LD,TS,MTS,IERR)
      TO(5)=LD
C
C     AIR TEMPERATURE TIME SERIES.
      IDT=PS(14)
      CALL CKINPT(PS(11),PS(13),IDT,LD,TS,MTS,IERR)
      TO(6)=LD
      NDT=IDT/ITPX
C
C     RAIN+MELT TIME SERIES
      LOC=PS(17)
      IF (LOC.GT.0) GO TO 96
      TO(7)=0
      GO TO 95
   96 CALL FINDTS(PS(LOC),PS(LOC+2),ITPX,LD,LTS,DIM)
      TO(7)=LD
      IF(LTS.GT.0) TS(LTS+8)=1.01
C
C     PERCENT SNOWFALL TIME SERIES
   95 LOC=PS(18)
      IF(LOC.GT.0) GO TO 101
      TO(8)=0
      GO TO 105
  101 CALL CKINPT(PS(LOC),PS(LOC+2),ITPX,LD,TS,MTS,IERR)
      TO(8)=LD
C
C     OBSERVED WATER-EQUIVALENT TIME SERIES.
  105 LOC=PS(19)
      IF(LOC.GT.0) GO TO 106
      TO(9)=0
      GO TO 110
  106 IT=PS(LOC+3)
      CALL CKINPT(PS(LOC),PS(LOC+2),IT,LD,TS,MTS,IERR)
      TO(9)=LD

C     RAIN-SNOW ELEVATION TIME SERIES
  110 LAEC=PS(30)
      IF (LAEC.GT.0) GO TO 111
      TO(10)=0
      GO TO 115
  111 LOC=LAEC+2
      CALL CKINPT(PS(LOC),PS(LOC+2),IDT,LD,TS,MTS,IERR)
      TO(10)=LD
C
C     SIMULATED WATER-EQUIVALENT TIME SERIES.
  115 LOC=PS(20)
      IF(LOC.GT.0) GO TO 116
      TO(11)=0
      GO TO 120
  116 IT=PS(LOC+3)
      CALL FINDTS(PS(LOC),PS(LOC+2),IT,LD,LTS,DIM)
      TO(11)=LD
      IF(LTS.GT.0) TS(LTS+8)=1.01
C
C     OBSERVED AREAL SNOW COVER TIME SERIES.
  120 LOC=PS(21)
      IF(LOC.GT.0) GO TO 121
      TO(12)=0
      GO TO 125
  121 IT=PS(LOC+3)
      CALL CKINPT(PS(LOC),PS(LOC+2),IT,LD,TS,MTS,IERR)
      TO(12)=LD
C
C     SIMULATED AREAL SNOW COVER TIME SERIES.
  125 LOC=PS(22)
      IF(LOC.GT.0) GO TO 126
      TO(13)=0
CVK      GO TO 130
      GO TO 136
  126 IT=PS(LOC+3)
      CALL FINDTS(PS(LOC),PS(LOC+2),IT,LD,LTS,DIM)
      TO(13)=LD
      IF(LTS.GT.0) TS(LTS+8)=1.01
C
CVK  SIMULATED SNOW DEPTH TIME SERIES
  136 LOC=PS(31)
      IF(LOC .GT. 0) GOTO 137
      TO(14)=0
      GOTO 138
  137 IT=PS(LOC+3)
      CALL FINDTS(PS(LOC),PS(LOC+2),IT,LD,LTS,DIM)
      TO(14)=LD
      IF(LTS .GT. 0) TS(LTS+8)=1.01
C
Cav  observed SNOW DEPTH TIME SERIES
  138 LOC=PS(32)
      IF(LOC .GT. 0) GOTO 139
      TO(15)=0
      GOTO 130
  139 IT=PS(LOC+3)
      CALL FINDTS(PS(LOC),PS(LOC+2),IT,LD,LTS,DIM)
      TO(15)=LD
      IF(LTS .GT. 0) TS(LTS+8)=1.01
C
C     WORKING SPACE
CVK  CHANGE LOCATION OF WHERE WORKING SPACE LOCATION IS STORED
CVK  130 TO(14)=NWORK
cav  130 TO(15)=NWORK
  130 TO(16)=NWORK 
      LWORK=3*NDT+24/IDT
      IF (MAINUM.NE.1) GO TO 135
      I=(24/ITPX)*NDD
      IF (I.GT.LWORK) LWORK=I
  135 IUSET=LENGTH
C     ALL ENTRIES HAVE BEEN MADE.
C.......................................
C     DEBUG OUTPUT
      IF(IBUG.EQ.0) GO TO 199
      WRITE(IODBUG,900) IDT,LWORK
  900 FORMAT(1H0,24HSNOW-17--CONTENTS OF TO.,5X,3HDT=,I3,5X,6HLWORK=,I6)
      WRITE(IODBUG,901) (TO(I),I=1,IUSET)
  901 FORMAT(1H ,20I6)
C.......................................
C     CONTENTS OF THE TO ARRAY.
C     POSITION                    CONTENTS
C        1.   I.D. NUMBER FOR THE OPERATION=19
C        2.   LOCATION OF NEXT OPERATION IN THE T ARRAY.
C        3.   LOCATION OF PARAMETERS IN P ARRAY=LPS
C        4.   LOCATION OF CARRYOVER IN C ARRAY=LCS
C        5.   LOCATION OF PRECIPITATION DATA IN THE D ARRAY
C        6.   LOCATION OF TEMPERATURE DATA IN THE D ARRAY
C        7.   LOCATION TO PUT RAIN+MELT DATA IN D().
C        8.   LOCATION OF PERCENT SNOWFALL DATA IN D(),=0 IF NONE
C        9.   LOCATION OF OBS.W.E. DATA IN D(),=0 IF NONE
C       10.   LOCATION OF RAIN-SNOW ELEV DATA IN D(), =0 IF NONE
C       11.   LOCATION TO PUT SIM.W.E. DATA IN D(),=0 IF NONE
C       12.   LOCATION OF OBS. PCT.COVER DATA IN D(),=0 IF NONE
C       13.   LOCATION TO PUT SIM. PCT. COVER DATA IN D(),=0 IF NONE
CVK  NEW SIMULATED SNOW DEPTH TIME SERIES IS ADDED, SO LOCATION OF WORKING 
CVK  SPACE IN D ARRAY IS MOVED TO THE NEXT POSITION
CVK     14.   LOCATION TO PUT SIM. SNOW DEPTH DATA IN D(),=0 IF NONE  
Cav  NEW OBSERVED SNOW DEPTH TIME SERIES IS ADDED, SO LOCATION OF WORKING 
Cav  SPACE IN D ARRAY IS MOVED TO THE NEXT POSITION
Cav     15.   LOCATION OF OBS. SNOW DEPTH DATA IN D(),=0 IF NONE  
CVK     16.   LOCATION OF WORKING SPACE IN THE D ARRAY.
C.......................................
  199 CONTINUE
      RETURN
      END