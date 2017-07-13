C   MODULE TMEANI
C
      SUBROUTINE TMEANI(MAXT,MINT,ITP12,INSTT,NINST,IDT,MEAN6,DV,IPART,
     1 MSNG,curr_staid)
C
C   THIS SUBROUTINE CALCULATES 6 HR MEAN TEMPS. FOR INST. STATION
C   TEMPERATURE DATA.
C
C   THIS SUBROUTINE WAS ORIGINALLY WRITTEN BY W. GILREATH
C
      character*8 curr_staid
      INTEGER*2 MAXT,MINT,ITP12,INSTT,MEAN6,MSNG
      LOGICAL LBUG
      DIMENSION DV(4),SBNAME(2),OLDOPN(2),INSTT(1),MEAN6(4),DFLT(4)
      INCLUDE 'common/pudbug'
      INCLUDE 'common/ionum'
      INCLUDE 'common/where'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_mat/RCS/tmeani.f,v $
     . $',                                                             '
     .$Id: tmeani.f,v 1.2 1997/12/31 19:46:38 page Exp $
     . $' /
C    ===================================================================
C
      DATA DCODE/4HTMNI/,SBNAME/4HTMEA,4HNI  /
      DATA DFLT/0.45,0.8,0.45,0.25/
      IF(IPTRCE.GE.1) WRITE(IOPDBG,900)
  900 FORMAT(1H0,15HTMEANI ENTERED.)
      LBUG = .FALSE.
      IF(IPBUG(DCODE).EQ.1) LBUG = .TRUE.
C
      IOLDOP=IOPNUM
      IOPNUM=-1
      DO 5 I=1,2
      OLDOPN(I)=OPNAME(I)
    5 OPNAME(I)=SBNAME(I)
C
      IF(LBUG)WRITE(IOPDBG,910)MAXT,MINT,ITP12,IDT,IPART,NINST,
     1(INSTT(I),I=1,NINST)
  910 FORMAT(1H0,'BEFORE CALCULATIONS IN PTMNI'/'  MAXT =',I5,
     1'  MINT =',I5,'  ITP12 =',I5,'  IDT =',I2,'  IPART =',I2,
     2'  INSTT(1) TO INSTT(',I1,') =',(8I5))
      IF(LBUG)WRITE(IOPDBG,915)
  915 FORMAT(1H ,'AFTER CALCULATIONS IN PTMNI')
C
C IF IDT EQUALS 3 CALCULATE 6 HOUR MEANS FROM 3 HOUR INSTANTANEOUS
C TEMPERATURE VALUES, OTHERWISE IDT EQUALS 6 AND CALCULATIONS ARE
C FROM 6 HOUR INSTANTANEOUS VALUES
C
      IF(IDT.EQ.3) GO TO 100
C
C IF IPART EQUALS 0 CALCULATIONS ARE FOR A FULL DAY, OTHERWISE IPART
C EQUALS 1 AND CALCULATIONS ARE FOR A PARTIAL DAY.
C
      IF(IPART.EQ.1) GO TO 50
C
C DO LOOP 10 CALCULATES 6 HOUR MEAN TEMPERATURES FROM 6 HOUR
C INSTANTANEOUS VALUES FOR A FULL DAY
C
      if(curr_staid.eq.'YCG     ') then
      idt=idt
      endif

      MEAN6(1)=(ITP12+INSTT(1))/2
      DO 10 N = 2,4
   10 MEAN6(N) = (INSTT(N-1) + INSTT(N))/2
      IF(LBUG)WRITE(IOPDBG,920)IDT,IPART,NINST,(MEAN6(N),N=1,NINST)
  920 FORMAT(1H ,'  IDT =',I2,'  IPART =',I2,'  MEAN6(1) TO MEAN6(',
     1I1,') =',(4I5))
C
C FOLLOWING STATEMENTS (THRU DO LOOP 20) FIND THE LOWEST 6 HOUR MEAN
C TEMPERATURE AND THE HIGHEST 6 HOUR MEAN TEMPERATURE
C
      MIN = MEAN6(1)
      L = 1
      MAX = MEAN6(1)
      M = 1
      DO 20 I = 2,4
      IF(MEAN6(I).GE.MIN) GO TO 15
      MIN = MEAN6(I)
      L = I
   15 IF(MEAN6(I).LT.MAX) GO TO 20
      MAX = MEAN6(I)
      M = I
   20 CONTINUE
C
C FOLLOWING 2 STATEMENTS RECALCULATE MINIMUM 6 HOUR MEAN AND MAXIMUM
C 6 HOUR MEAN BY INCLUDING THE INSTANTANEOUS VALUES AND ALSO
C THE MAXIMUM AND MINIMUM VALUES
C
      MEAN6(L) = .5*MEAN6(L) + .5*MINT
      MEAN6(M) = .5*MEAN6(M) + .5*MAXT
      IF(LBUG)WRITE(IOPDBG,930)L,MEAN6(L),M,MEAN6(M)
  930 FORMAT(1X,'  MEAN6(',I1,') RECALCULATED =',I5,
     1'  MEAN6(',I1,') RECALCULATED =',I5)
C
C FOLLOWING STATEMENTS (THRU DO LOOP 30) CALCULATE DIURNAL VARIATIONS
C
      TN = MINT
      TX = MAXT
      TDIFF=TX-TN
      IF (TDIFF.LE.0.0) GO TO 37
      DO 35 I = 1,4
      DV(I) = (MEAN6(I)-TN)/(TX-TN)
      if((dv(i).gt.1.1) .or. (dv(i).lt.-0.1)) then
cew  Its a trick!  This code exists in two places in this subroutine.
      write(ipr,'(A,A)') '*** WARNING  *** PROBLEM IN COMPUTING TIMING W
     +EIGHTS, ASSIGNING DEFAULT VALUES, STATION=', curr_staid
      write(ipr,'(A)')'CHECK THE MAX/MIN AND INSTANTANEOUS DATA VALUES,
     + TO BE SURE THEY ARE IN AGREEMENT.  LOOK AT THE PREVIOUS DAY 12Z V
     +ALUE ALSO.'
      CALL WARN
      GOTO 37
      endif
   35 continue
      GOTO 40
  37  DO 38 I = 1,4
   38 DV(I) = DFLT(I)
40    IF(LBUG)WRITE(IOPDBG,940)NINST,(DV(I),I=1,NINST)
  940 FORMAT(1H ,'  DV(1) TO DV(',I1,') =',(4F5.2))
      GO TO 300
C
C DO LOOP 60 CALCULATES 6 HOUR MEANS FOR A PARTIAL DAY, IF INSTANTANEOUS
C VALUES ARE MISSING LEAVE 6 HOUR MEAN MISSING
C
   50 IF(ITP12.EQ.MSNG.OR.INSTT(1).EQ.MSNG) GO TO 55
      MEAN6(1)=(ITP12+INSTT(1))/2
   55 IF(NINST.EQ.1) GO TO 65
      DO 60 N = 2,NINST
      IF((INSTT(N-1).EQ.MSNG).OR.(INSTT(N).EQ.MSNG)) GO TO 60
      MEAN6(N) = (INSTT(N-1) + INSTT(N))/2
   60 CONTINUE
   65 IF(LBUG)WRITE(IOPDBG,920)IDT,IPART,NINST,(MEAN6(N),N=1,NINST)
      GO TO 300
C
C IF IPART EQUALS 0 CALCULATIONS ARE FOR A FULL DAY, OTHERWISE IPART
C EQUALS 1 AND CALCULATIONS ARE FOR A PARTIAL DAY
C
  100 IF(IPART.EQ.1) GO TO 150
C
C DO LOOP 110 CALCULATES 6 HOUR MEAN TEMPERATURES FROM 3 HOUR
C INSTANTANEOUS VALUES FOR A FULL DAY
C
      MEAN6(1)=ITP12/4.+INSTT(1)/2.+INSTT(2)/4.
      DO 110 N=2,4
      I=N*2
      MEAN6(N)=INSTT(I-2)/4.+INSTT(I-1)/2.+INSTT(I)/4.
  110 CONTINUE
      IF(LBUG)WRITE(IOPDBG,920)IDT,IPART,I,(MEAN6(N),N=1,4)
C
C FOLLOWING STATEMENTS (THRU DO LOOP 120) FIND THE LOWEST 6 HOUR MEAN
C TEMPERATURE AND THE HIGHEST 6 HOUR MEAN TEMPERATURE
C
      MIN = MEAN6(1)
      L = 1
      MAX = MEAN6(1)
      M = 1
      DO 120 I = 2,4
      IF(MEAN6(I).GT.MIN) GO TO 115
      MIN = MEAN6(I)
      L = I
  115 IF(MEAN6(I).LT.MAX) GO TO 120
      MAX = MEAN6(I)
      M = I
  120 CONTINUE
C
C FOLLOWING 2 STATEMENTS RECALCULATE MINIMUM 6 HOUR MEAN AND MAXIMUM
C 6 HOUR MEAN BY INCLUDING THE INSTANTANEOUS TEMPERATURE VALUES AND
C ALSO THE MAXIMUM AND MINIMUM VALUES
C
      MEAN6(L) = .75*MEAN6(L) + .25*MINT
      MEAN6(M) = .75*MEAN6(M) + .25*MAXT
      IF(LBUG)WRITE(IOPDBG,930)L,MEAN6(L),M,MEAN6(M)
C
C FOLLOWINF STATEMENTS (THRU DO LOOP 130) CALCULATE DIURNAL VARIATIONS
C
      TN = MINT
      TX = MAXT
      TDIFF=TX-TN
      IF (TDIFF.LE.0.0) GO TO 137
      DO 135 I = 1,4
      DV(I) = (MEAN6(I)-TN)/(TX-TN)
      if((dv(i).gt.1.1) .or. (dv(i).lt.-0.1)) then
cew its a trick!! this code existst in two places in this routine
      write(ipr,'(A,A)') '*** WARNING  *** PROBLEM COMPUTING TIMING WEIG
     +HTS, ASSIGNING DEFAULT VALUES, STATION=', curr_staid
       write(ipr,'(A)')'CHECK THE MAX/MIN AND INSTANTANEOUS DATA VALUES,
     + TO BE SURE THEY ARE IN AGREEMENT.  LOOK AT THE PREVIOUS DAY 12Z V
     +ALUE ALSO.'
      CALL WARN
      GOTO 137
      endif
  135 continue
      GOTO 140
 137  DO 138 I = 1,4
  138 DV(I) = DFLT(I)
140   IF(LBUG)WRITE(IOPDBG,940)NINST,(DV(I),I=1,4)
      GO TO 300
C
C DO LOOP 160 CALCULATES 6 HOUR MEANS FOR A PARTIAL DAY, IF
C INSTANTANEOUS VALUES ARE MISSING LEAVE 6 HOUR MEAN MISSING
C
  150 NPER=(NINST*IDT)/6
      IF(NPER.LT.1) GO TO 300
      IF(ITP12.EQ.MSNG.OR.INSTT(1).EQ.MSNG.OR.INSTT(2).EQ.MSNG)
     1 GO TO 155
      MEAN6(1)=ITP12/4.+INSTT(1)/2.+INSTT(2)/4.
  155 IF(NPER.EQ.1) GO TO 165
      DO 160 N=2,NPER
      I=N*2
      IF(INSTT(I-2).EQ.MSNG.OR.INSTT(I-1).EQ.MSNG.OR.INSTT(I).EQ.MSNG)
     1 GO TO 160
      MEAN6(N)=INSTT(I-2)/4.+INSTT(I-1)/2.+INSTT(I)/4.
  160 CONTINUE
  165 IF(LBUG)WRITE(IOPDBG,920)IDT,IPART,NPER,(MEAN6(N),N=1,NPER)
  300 IF(LBUG)WRITE(IOPDBG,950)MAXT,MINT,ITP12,NINST,
     1(INSTT(I),I=1,NINST)
  950 FORMAT(1H ,'  MAXT =',I5,'  MINT =',I5,'  ITP12 =',I5,
     1'  INSTT(1) TO INSTT(',I1,') =',(8I5))
C
      IOPNUM=IOLDOP
      OPNAME(1)=OLDOPN(1)
      OPNAME(2)=OLDOPN(2)
C
      RETURN
      END