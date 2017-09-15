C MEMBER F3WAYY
C  (from old member FCF3WAYY)
C
      SUBROUTINE F3WAYY(X,Y,Z,XX,YY,ZZ,NY,NZ,IBUG)
C
C SUBROUTINE F3WAYY INTERPOLATES THE Y VALUE IN A THREE-WAY RELATION
C WHERE YY (ORDINATE VALUES) AND ZZ (PARAMETER VALUES) ARE SINGLE ARRAYS
C AND XX (ABSCISSA VALUES) IS A DOUBLE ARRAY.  EACH PARAMETER (ZZ) VALUE
C HAS AN ASSOCIATED CURVE DEFINED BY A SET OF YY VS XX VALUES.  YY
C VALUES MUST BE THE SAME FOR ALL ZZ CURVES.  X AND Z ARE KNOWN ABSCISSA
C AND PARAMETER VALUES.
C
C THIS SUBROUTINE WAS ORIGINALLY PROGRAMMED BY
C     WILLIAM E. FOX -- CONSULTING HYDROLOGIST
C     DECEMBER, 1981
C
C  MODIFIED TO REARRANGE THE XX ARRAY FROM (NZ,NY) TO (NY,NZ) FOR MORE
C  STRAIGHTFORWARD INPUT AND DISPLAY PURPOSES - (JTO - 1/84)
C
C SUBROUTINE F3WAYY IS IN
C
C VARIABLES IN THE ARGUMENT LIST ARE DEFINED AS FOLLOWS:
C     X -- KNOWN ABSCISSA VALUE.
C     Y -- UNKNOWN ORDINATE VALUE TO BE COMPUTED.
C     Z -- KNOWN PARAMETER VALUE.
C     XX -- DOUBLE ARRAY OF ABSCISSA VALUES WITH DIMENSIONS OF (NY,NZ).
C     YY -- SINGLE ARRAY OF ORDINATE VALUES.  YY VALUES ARE THE SAME FOR
C       ALL PARAMETER (ZZ) CURVES.
C     ZZ -- SINGLE ARRAY OF PARAMETER VALUES.  EACH ZZ CURVE IS DEFINED
C       BY THE YY VALUES AND DIFFERENT SETS OF XX VALUES.
C     NY -- NO. OF VALUES IN YY ARRAY.
C     NZ -- NO. OF VALUES IN ZZ ARRAY.
C
      DIMENSION ZZ(1),YY(1),XX(NY,1)
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_res/RCS/f3wayy.f,v $
     . $',                                                             '
     .$Id: f3wayy.f,v 1.1 1995/09/17 19:05:37 dws Exp $
     . $' /
C    ===================================================================
C
C
C WRITE TRACE AND DEBUG IF REQUIRED.
C
      IF (IBUG.EQ.1) GO TO 10
      IF (IBUG.GE.5) GO TO 20
      GO TO 50
   10 WRITE(IODBUG,30)
      GO TO 50
   20 WRITE(IODBUG,30)
   30 FORMAT(1H0,10X,17H** F3WAYY ENTERED)
      WRITE(IODBUG,40) X,Z
   40 FORMAT(1H0,12H X AND Z ARE,2F12.3,22H.  Y WILL BE COMPUTED.)
C
C BRACKET THE KNOWN Z VALUE.
C
   50 DO 60 J=2,NZ
      IF(ZZ(J).GT.Z) GO TO 70
   60 CONTINUE
      J=NZ
   70 Z2=ZZ(J)
      Z1=ZZ(J-1)
      J1=J-1
      J2=J
C
C BRACKET THE KNOWN X VALUE ALONG THE Z2 CURVE IN THE XX ARRAY.
C
      DO 80 I=2,NY
      IF(XX(J2,I).GT.X) GO TO 90
   80 CONTINUE
      I=NY
   90 XX2=XX(I,J2)
      XX1=XX(I-1,J2)
      YY2=YY(I)
      YY1=YY(I-1)
C
C IF XX2 IS EQUAL TO XX1, Y2 IS INDETERMINATE BUT WILL BE SET TO YY2.
C XX2 CAN EQUAL XX1 ONLY IF THE LAST TWO VALUES OF XX ON THE Z2 LINE
C ARE EQUAL.
C
      IF(XX2.NE.XX1) GO TO 91
      Y2=YY2
      GO TO 92
C
C COMPUTE Y2, THE Y VALUE ON THE Z2 CURVE CORRESPONDING TO THE KNOWN
C X VALUE.
C
   91 Y2=YY1+(X-XX1)*(YY2-YY1)/(XX2-XX1)
C
C BRACKET THE KNOWN X VALUE ALONG THE Z1 CURVE IN THE XX ARRAY.
C
   92 DO 100 I=2,NY
      IF(XX(J1,I).GT.X) GO TO 110
  100 CONTINUE
      I=NY
  110 XX4=XX(I,J1)
      XX3=XX(I-1,J1)
      YY4=YY(I)
      YY3=YY(I-1)
C
C IF XX4 IS EQUAL TO XX3, Y1 IS INDETERMINATE BUT WILL BE SET TO YY4.
C XX4 CAN EQUAL XX3 ONLY IF THE TWO HIGHEST XX VALUES ON THE Z1 CURVE
C ARE EQUAL.
C
      IF(XX4.NE.XX3) GO TO 111
      Y1=YY4
      GO TO 112
C
C COMPUTE Y1, THE Y VALUE ON THE Z1 CURVE CORRESPONDING TO THE KNOWN
C X VALUE.
C
  111 Y1=YY3+(X-XX3)*(YY4-YY3)/(XX4-XX3)
C
C Z1 SHOULD NOT BE THE SAME AS Z2 BUT, IN CASE THEY ARE EQUAL, Y WILL BE
C SET EQUAL TO Y1 WHICH IS EQUAL TO Y2.
C
  112 IF(Z1.NE.Z2) GO TO 113
      Y=Y1
      GO TO 114
C
C COMPUTE Y, THE UNKNOWN VALUE.
C
  113 Y=Y2+(Z-Z2)*(Y1-Y2)/(Z1-Z2)
C
C WRITE TRACE AND DEBUG IF REQUIRED.
C
  114 IF (IBUG.EQ.1) GO TO 180
      IF (IBUG.GE.5) GO TO 120
      GO TO 200
  120 WRITE(IODBUG,130) X,Y,Z
  130 FORMAT(1H0,43H X,Y, AND Z VALUES AT THE END OF F3WAYY ARE,3F12.3)
      WRITE(IODBUG,140) (YY(I),I=1,NY)
  140 FORMAT(1H0,36H YY VALUES IN THE 3-WAY RELATION ARE/(1X,10F12.3))
      WRITE(IODBUG,150) (ZZ(I),I=1,NZ)
  150 FORMAT(1H0,14H ZZ VALUES ARE/(1X,10F12.3))
      DO 160 I=1,NZ
  160 WRITE(IODBUG,170) ZZ(I),(YY(J),XX(J,I),J=1,NY)
  170 FORMAT(1H0,48H ALTERNATING VALUES OF YY AND XX FOR ZZ VALUE OF,F12
     $.3, 4H ARE/(1X,4(2F12.3,4X)))
  180 WRITE(IODBUG,190)
  190 FORMAT(1H0,10X,17H** LEAVING F3WAYY)
  200 RETURN
      END