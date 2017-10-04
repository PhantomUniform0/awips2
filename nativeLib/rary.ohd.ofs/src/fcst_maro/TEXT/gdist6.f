C MEMBER GDIST6
C  (from old member PPGDIST6)
C
      SUBROUTINE GDIST6(TMARO, TMAPG, PCT, RMARO, RMAPG)
C
C.....SUBROUTINE GDIST6 -- COMPUTES SIX-HOURLY BREAKDOWNS OF MARO AND
C.....MAPG FROM 24-HOUR VALUES.
C
C.....THE ARGUMENT LIST IS:
C
C.....TMARO  - 24-HOUR VALUE OF MARO.
C.....TMAPG  - 24-HOUR VALUE OF MAPG.
C.....PCT    - SIX-HOUR PERCENTAGE DISTRIBUTIONS FOR THE MARO AREA.
C.....RMARO  - 6-HOUR VALUES OF MARO.
C.....RMAPG  - 6-HOUR VALUES OF MAPG.
C
C.....JERRY M. NUNN     WGRFC FT. WORTH     SEPTEMBER 16, 1987
C
      DIMENSION PCT(1), SNAME(2), RMARO(4), IPCT(4), RMAPG(4), MARO(4)
      DIMENSION MAPG(4), IORDR(4)
      INCLUDE 'common/where'
      INCLUDE 'common/pudbug'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_maro/RCS/gdist6.f,v $
     . $',                                                             '
     .$Id: gdist6.f,v 1.1 1995/09/17 19:01:25 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA GDST /4hGDST/
      DATA SNAME /4hGDIS, 4hT6  /
C
  906 FORMAT(1H0, '*** GDIST6 ENTERED ***')
  907 FORMAT(1X,  '*** EXIT GDIST6 ***')
  908 FORMAT(1X,  1X, '6HR MARO VALUES...IN REAL:  ', 4F8.4, 3X, 'IN INT
     *EGER:  ', 4I6, /, 2X, '6HR MAPG VALUES...IN REAL:  ', 4F8.4, 3X,
     * 'IN INTEGER:  ', 4I6)
  909 FORMAT(1X,  1X, '6HR DISTRIBUTION PERCENTAGES ARE...IN REAL:  ',
     * 4F6.2, 3X, 'IN INTEGER:  ', 4I6)
  910 FORMAT(1X,  'ORDER ARRAY (HIGHEST TO LOWEST ORDINATE OF 6HR DISTRI
     *BUTION PERCENTAGES):  ', 4I4)
  911 FORMAT(1X,  '24HR TOTAL MARO VALUES...IN REAL:  ', F6.2, 3X, 'IN I
     *NTEGER:  ', I6, /, 1X, 'SUM OF 6HR MARO VALUES...IN REAL:  ',
     * F6.2, 3X, 'IN INTEGER:  ', I6, //, 1X, '24HR TOTAL MAPG VALUES...
     *IN REAL:  ', F6.2, 3X, 'IN INTEGER:  ', I6, /, 1X, 'SUM OF 6HR MAP
     *G VALUES...IN REAL:  ', F6.2, 3X, 'IN INTEGER:  ', I6)
  912 FORMAT(1X,  'DIFFERENCE (24HR TOTAL - 6HR SUM)...MARO:  ', I4, 5X,
     * 'MAPG:  ', I4)
      INCLUDE 'gcommon/setwhere'
C
      IF(IPTRCE .GE. 8) WRITE(IOPDBG,906)
C
C.....CHECK IF DEBUG DESIRED.
C
      JBUG = IPBUG(GDST)
C
C.....COMPUTE THE DISTRIBUTION AND COUNTERS.
C
      JTMARO = 0
      JTMAPG = 0
C
      DO 10 NP = 1, 4
      RMARO(NP) = TMARO*PCT(NP)
      RMAPG(NP) = TMAPG*PCT(NP)
      MARO(NP)  = RMARO(NP)*100.
      MAPG(NP)  = RMAPG(NP)*100.
      JTMARO    = JTMARO + MARO(NP)
      JTMAPG    = JTMAPG + MAPG(NP)
      IPCT(NP) = PCT(NP)*100.
   10 CONTINUE
C
      ITMARO = TMARO*100.
      ITMAPG = TMAPG*100.
C
C.....COMPUTE ANY DIFFERENCES BETWEEN 24 HR TOTAL AND SUM OF SIX HRLY
C.....BREAKDOWNS. IF NO DIFFERENCE EXISTS, GET OUT OF THE SUBROUTINE.
C
      IDIF = ITMARO - JTMARO
      JDIF = ITMAPG - JTMAPG
      I2DIF = IDIF
      J2DIF = JDIF
C
      IF((IDIF .EQ. 0) .AND. (JDIF .EQ. 0)) GOTO 998
C
C.....DETERMINE SIGN OF DIFFERENCES.
C
      ICOEFF = 1
      IF(IDIF .GT. 0) GOTO 20
      ICOEFF = -1
      IDIF = -IDIF
C
   20 JCOEFF = 1
      IF(JDIF .GT. 0) GOTO 30
      JCOEFF = -1
      JDIF = -JDIF
C
C.....DETERMINE THE ORDER OF THE DISTRIBUTION PERCENTAGES...FROM
C.....HIGHEST TO LOWEST.
C
   30 KP = 4
C
      DO 35 NP = 1, 4
      IORDR(NP) = KP
      KP = KP - 1
   35 CONTINUE
C
C.....IF THERE IS A DISTRIBUTION...ORDER THE POINTERS FROM HIGHEST
C.....PERCENTAGE TO LOWEST.
C
      DO 45 NP = 1, 3
      LP = IORDR(NP)
      MP = NP + 1
C
      DO 40 KP = MP, 4
      JP = IORDR(KP)
      IF(IPCT(LP) .GE. IPCT(JP)) GOTO 40
      IORDR(NP) = JP
      IORDR(KP) = LP
      LP = IORDR(NP)
   40 CONTINUE
C
   45 CONTINUE
C
C.....DUMP OUT DEBUG OUTPUT HERE...IF SUCH IS DESIRED.
C
      IF(JBUG .EQ. 0) GOTO 48
C
      WRITE(IOPDBG,908) (RMARO(NP), NP = 1, 4), (MARO(NP), NP = 1, 4),
     * (RMAPG(NP), NP = 1, 4), (MAPG(NP), NP = 1, 4)
      WRITE(IOPDBG,909) (PCT(NP), NP = 1, 4), (IPCT(NP), NP = 1, 4)
      WRITE(IOPDBG,910) (IORDR(NP), NP = 1, 4)
      TSMARO = JTMARO
      TSMAPG = JTMAPG
      TSMARO = TSMARO/100.
      TSMAPG = TSMAPG/100.
      WRITE(IOPDBG,911) TMARO, ITMARO, TSMARO, JTMARO, TMAPG, ITMAPG,
     * TSMAPG, JTMAPG
      WRITE(IOPDBG,912) I2DIF, J2DIF
C
C.....PUT THE DIFFERENCES (IF ANY) INTO THE 4 SLOTS OF THE MARO AND
C.....MAPG ARRAYS. BEGIN WITH THE TIME SLOT WITH THE HIGHEST
C.....DISTRIBUTION PERCENTAGE, AND CONTINUE DOWN IN MAGNITUDE. PUT
C.....ONLY .01 (INCH OR MM) IN EACH TIME SLOT. THE DIFFERENCE WILL
C.....NOT BE GREATER THAN .03 (INCH OR MM).
C
   48 DO 55 IP = 1, 4
      KP = IORDR(IP)
      IF(IDIF .EQ. 0) GOTO 52
      IF((MARO(KP) .EQ. 0) .AND. (ICOEFF .EQ. -1)) GOTO 52
      MARO(KP) = MARO(KP) + ICOEFF
      IDIF = IDIF - 1
C
   52 IF(JDIF .EQ. 0) GOTO 55
      IF((MAPG(KP) .EQ. 0) .AND. (JCOEFF .EQ. -1)) GOTO 55
      MAPG(KP) = MAPG(KP) + JCOEFF
      JDIF = JDIF - 1
   55 CONTINUE
C
C
      IF(I2DIF .EQ. 0) GOTO 70
C
      JTMARO = 0
C
      DO 60 NP = 1, 4
      R = MARO(NP)
      RMARO(NP) = R/100.
      JTMARO    = JTMARO + MARO(NP)
   60 CONTINUE
C
      TMARO = JTMARO
      TMARO = TMARO/100.
C
   70 IF(J2DIF .EQ. 0) GOTO 998
C
      JTMAPG = 0
C
      DO 80 NP = 1, 4
      R = MAPG(NP)
      RMAPG(NP) = R/100.
      JTMAPG    = JTMAPG + MAPG(NP)
   80 CONTINUE
C
      TMAPG = JTMAPG
      TMAPG = TMAPG /100.
C
  998 IF(IPTRCE .GE. 8) WRITE(IOPDBG,907)
      RETURN
      END