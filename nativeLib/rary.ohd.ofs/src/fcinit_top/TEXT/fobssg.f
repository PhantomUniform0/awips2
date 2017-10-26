C MODULE FOBSSG
C-----------------------------------------------------------------------
C
C  ROUTINE SET A SEGMENT TO DELETED.
C
      SUBROUTINE FOBSSG (INID,IRECRD)
C
C  USED TO CHANGE SEGMENT IDENTIFIER TO 'OBSOLETE' IN FORECAST COMPONENT
C  FILES. THIS IS DONE AFTER AN EXISTING SEGMENT IS REDEFINED TO SET THE
C  OLD DEFINITION TO 'OBSOLETE' OR WHEN A SEGMENT IS DELETED.
C
C  ROUTINE ORIGINALLY WRITTEN BY -- ED JOHNSON -- HRL -- 11/1979
C
      CHARACTER*8 RTNNAM,OPNOLD
C
      DIMENSION INID(2)
      DIMENSION OBSLET(2)
      DIMENSION IZZBUF(100)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fciobf'
      INCLUDE 'common/fcsegp'
      INCLUDE 'common/fccgd'
      INCLUDE 'common/fcunit'
      INCLUDE 'common/fctime'
C
      EQUIVALENCE (IZZBUF(1),ZZZBUF(1))
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_top/RCS/fobssg.f,v $
     . $',                                                             '
     .$Id: fobssg.f,v 1.3 2000/03/14 11:57:48 page Exp $
     . $' /
C    ===================================================================
C
      DATA OBSLET/4HOBSO,4HLETE/
C
C
      RTNNAM='FOBSSG'
C
      IF (ITRACE.GT.0) WRITE (IODBUG,*) 'ENTER ',RTNNAM
C
      IOPNUM=0
      CALL FSTWHR (RTNNAM,IOPNUM,OPNOLD,IOLDOP)
C
      IBUG=IFBUG('DLTE')+IFBUG('SEGD')
      IF (IFBUG('BUFW').EQ.1) IBUG=2
C
      IF (IBUG.GE.1) WRITE (IODBUG,10) INID,IRECRD
10    FORMAT (' INID=',2A4,' IRECRD=',I6)
C
C  FILE FCSEGSTS
      IF (IRECRD.GT.0.AND.IRECRD.LE.NRSTS) GO TO 30
         WRITE (IPR,20) IRECRD,INID
20    FORMAT ('0**ERROR** IN FOBSSG - SEGMENT RECORD NUMBER (',I6,
     *   ') FOR SEGMENT ',2A4,' IS INVALID.')
         CALL ERROR
         GO TO 130
30    CALL UREADT (KFSGST,IRECRD,ZZZBUF,IERR)
      IPREC=IZZBUF(17)
      IWOCRY=IZZBUF(18)
      IF (IZZBUF(1).EQ.INID(1).AND.IZZBUF(2).EQ.INID(2)) GO TO 50
         WRITE (IPR,40) INID,IRECRD,IZZBUF(1),IZZBUF(2)
40    FORMAT ('0**ERROR** IN FOBSSG - SEGMENT ',2A4' TO BE DELETED ',
     *   ' AT RECORD ',I6,' OF FILE FSEGSTS BUT RECORD CONTAINS ',
     *   'SEGMENT ',2A4,'.')
         CALL ERROR
         GO TO 130
50    IF (IBUG.GE.2) CALL FCDMP2 (IRECRD,42)
      ZZZBUF(1)=OBSLET(1)
      ZZZBUF(2)=OBSLET(2)
      CALL UWRITT (KFSGST,IRECRD,ZZZBUF,IERR)
C
C  FILE FCPARAM
      IF (IBUG.GE.1) WRITE (IODBUG,*) 'IPREC=',IPREC
      IF (IPREC.GT.0.AND.IPREC.LE.NRP) GO TO 70
         WRITE (IPR,60) IPREC,INID
60    FORMAT ('0**WARNING** IN FOBSSG - PARAMETER RECORD NUMBER (',I6,
     *   ') FOR SEGMENT ',2A4,' IS INVALID.')
         CALL WARN
         GO TO 80
70    CALL UREADT (KFPARM,IPREC,ZZZBUF,IERR)
      ZZZBUF(1)=OBSLET(1)
      ZZZBUF(2)=OBSLET(2)
      CALL UWRITT (KFPARM,IPREC,ZZZBUF,IERR)
C
C  FILE FCCARRY
80    IF (IWOCRY.GT.0.AND.IWOCRY.LT.NWPS) GO TO 100
         WRITE (IPR,90) IWOCRY,INID
90    FORMAT ('0**WARNING** IN FOBSSG - CARRYOVER WORD OFFSET (',I6,
     *   ') FOR SEGMENT ',2A4,' IS INVALID.')
         CALL WARN
         GO TO 130
100   NROFF=(IWOCRY+NWR-1)/NWR
      IW1=MOD(IWOCRY,NWR)
      IF (IW1.EQ.0)IW1=NWR
      IW2=IW1+1
      IF (IW1.EQ.NWR)IW2=1
      IF (IBUG.GE.1) WRITE (IODBUG,*) 'NROFF=',NROFF,
     *   ' IW1=',IW1,' IW2=',IW2,' NSLOTS=',NSLOTS,' NRSLOT=',NRSLOT
      DO 120 I=1,NSLOTS
         J=(I-1)*NRSLOT+NROFF
         IF (IW2.EQ.1) GO TO 110
            CALL FCWTCF (J,IW1,IW2,OBSLET,1)
            GO TO 120
110      CALL FCWTCF (J,IW1,IW1,OBSLET,1)
         J=J+1
         CALL FCWTCF (J,IW2,IW2,OBSLET(2),1)
120      CONTINUE
C
130   CALL FSTWHR (OPNOLD,IOLDOP,OPNOLD,IOLDOP)
C
      IF (ITRACE.GT.0) WRITE (IODBUG,*) 'EXIT ',RTNNAM
C
      RETURN
C
      END