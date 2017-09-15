C MEMBER USTOP
C-----------------------------------------------------------------------
C
      SUBROUTINE USTOP (NUNIT,NSTOP)
C
C  ROUTINE TO PRINTS A SUMMARY OF ERRORS AND WARNINGS AND STOPS THE
C  PROGRAM EXECUTION IF SPECIFIED.
C
      INCLUDE 'uiox'
      INCLUDE 'ucmdbx'
      INCLUDE 'uerorx'
      INCLUDE 'utimrx'
      INCLUDE 'upagex'
      INCLUDE 'ustopx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/util/src/util_upage/RCS/ustop.f,v $
     . $',                                                             '
     .$Id: ustop.f,v 1.1 1995/09/17 19:05:19 dws Exp $
     . $' /
C    ===================================================================
C
C
C
      IF (ICMTRC.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,*) '*** ENTER USTOP :',
     *      ' NUNIT=',NUNIT,
     *      ' NSTOP=',NSTOP
         ENDIF
C
      IUNIT=IABS(NUNIT)
      ISTOP=IABS(NSTOP)
C
      IF (ICMDBG.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,130) IPSPAG(IUNIT),IERPRT,ICDPRT,ITMPRT
         ENDIF
C
C  SET MINUMUM NUMBER OF LINES PRINTED
      MINLIN=18
C
C  CHECK IF UNIT HAD ERRORS AND WARNINGS COUNTED
      DO 10 LUNIT=1,MXUERR
         IF (ICMDBG.GT.1) THEN
            CALL ULINE (ICMPRU,1)
            WRITE (ICMPRU,*) ' LUNIT=',LUNIT,
     *         'LUEROR(LUNIT)=',LUEROR(LUNIT),
     *         'IUNIT=',IUNIT
            ENDIF
         IF (LUEROR(LUNIT).EQ.IUNIT) GO TO 20
10       CONTINUE
C
C  CHECK LINES LEFT ON PAGE
      IF (IPSPAG(IUNIT).GT.0) THEN
         CALL ULINEL (IUNIT,MINLIN,IRETRN)
         IF (IRETRN.GT.0) CALL UPAGE (IUNIT)
         ENDIF
      CALL ULINE (IUNIT,2)
      WRITE (IUNIT,150)
      GO TO 90
C
C  CHECK NUMBER OF LINES LEFT ON PAGE
20    IF (IPSPAG(IUNIT).GT.0) THEN
         NPER=10
         NUM=MINLIN+
     *       (NPGERR(LUNIT)+NPER-1)/NPER+
     *       (NPGWRN(LUNIT)+NPER-1)/NPER
         CALL ULINEL (IUNIT,NUM,IRETRN)
         IF (IRETRN.GT.0) CALL UPAGE (IUNIT)
         ENDIF
C
      CALL ULINE (IUNIT,2)
      WRITE (IUNIT,150)
C
C  SET COMPLETION CODE
      DO 40 I=1,MXUERR
         IF (NTERR(LUNIT).GT.0) ISTOPX=8
40       CONTINUE
      DO 50 I=1,MXUERR
         IF (NTWRN(LUNIT).GT.0) ISTOPX=4
50       CONTINUE
C
C  CHECK IF HIGHEST CONDITION CODE ENCOUNTERED FOR RUN GREATER THAN
C  CURRENT CONDITION CODE.
      IF (MAXCDE.GT.ISTOPX) ISTOPX=MAXCDE
C
      IF (IERPRT.EQ.0) GO TO 90
C
C  CHECK NUMBER OF ERRORS AND WARNINGS ENCOUNTERED
      IF (ICMDBG.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,240) NTERR(LUNIT),NTWRN(LUNIT),
     *      NPGERR(LUNIT),NPGWRN(LUNIT)
         ENDIF
      IF (NTERR(LUNIT).LT.0.AND.NTWRN(LUNIT).LT.0) GO TO 90
C
C  PRINT SUMMARY OF ERRORS AND WARNINGS
      CALL ULINE (IUNIT,2)
      WRITE (IUNIT,160) IUNIT
      CALL ULINE (IUNIT,1)
      WRITE (IUNIT,170) NTERR(LUNIT)
      IF (NPGERR(LUNIT).EQ.0) GO TO 70
      IF (NTERR(LUNIT).EQ.0) GO TO 70
C
C  PRINT PAGES ON WHICH ERRORS OCCURRED
      NUM=NPGERR(LUNIT)
      IF (NUM.GT.NPER) NUM=NPER
      NTIME=(NPGERR(LUNIT)-NPER)/NPER
      IF (MOD(NPGERR(LUNIT),NPER).NE.0) NTIME=NTIME+1
      CALL ULINEL (IUNIT,2+NTIME,IRETRN)
      IF (IRETRN.GT.0) CALL UPAGE (IUNIT)
      CALL ULINE (IUNIT,1)
      WRITE (IUNIT,190) (LPGERR(LUNIT,I),I=1,NUM)
      IF (NPGERR(LUNIT).LE.NPER) GO TO 70
         NUM1=NPER+1
         NUM2=NPER*2
         DO 60 J=1,NTIME
            IF (NUM2.GT.NPGERR(LUNIT)) NUM2=NPGERR(LUNIT)
            CALL ULINE (IUNIT,1)
            WRITE (IUNIT,210) (LPGERR(LUNIT,I),I=NUM1,NUM2)
            NUM1=NUM1+NPER
            NUM2=NUM2+NPER
60          CONTINUE
C
70    CALL ULINE (IUNIT,1)
      WRITE (IUNIT,180) NTWRN(LUNIT)
C
      IF (NPGWRN(LUNIT).EQ.0) GO TO 90
      IF (NTWRN(LUNIT).EQ.0) GO TO 90
C
C  PRINT PAGES ON WHICH WARNINGS OCCURRED
      NUM=NPGWRN(LUNIT)
      IF (NUM.GT.NPER) NUM=NPER
      NTIME=(NPGWRN(LUNIT)-NPER)/NPER
      IF (MOD(NPGWRN(LUNIT),NPER).NE.0) NTIME=NTIME+1
      IF (ICMDBG.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,*) 'LUNIT=',LUNIT,
     *      ' NPGWRN(LUNIT)=',NPGWRN(LUNIT),
     *      ' NUM=',NUM,
     *      ' NPER=',NPER,
     *      ' NTIME=',NTIME
          ENDIF
      CALL ULINEL (IUNIT,2+NTIME,IRETRN)
      IF (IRETRN.GT.0) CALL UPAGE (IUNIT)
      CALL ULINE (IUNIT,1)
      WRITE (IUNIT,200) (LPGWRN(LUNIT,I),I=1,NUM)
      IF (NPGWRN(LUNIT).LE.NPER) GO TO 90
         NUM1=NPER+1
         NUM2=NPER*2
         DO 80 J=1,NTIME
            IF (NUM2.GT.NPGWRN(LUNIT)) NUM2=NPGWRN(LUNIT)
            CALL ULINE (IUNIT,1)
            WRITE (IUNIT,210) (LPGWRN(LUNIT,I),I=NUM1,NUM2)
            NUM1=NUM1+NPER
            NUM2=NUM2+NPER
80          CONTINUE
C
C  PRINT COMPLETION CODE
90    IF (NSTOP.GT.0) ISTOPX=NSTOP
      IF (ICDPRT.EQ.1) THEN
         CALL ULINE (IUNIT,2)
         WRITE (IUNIT,220) ISTOPX
         ENDIF
C
      IF (ITMPRT.EQ.0) GO TO 100
C
C  PRINT CPU TIME USED
      CALL UCPUTM (-1,ITMELA,ITMTOT)
      NSEC=(ITMTOT+50)/100
      NCPMIN=NSEC/60
      NCPSEC=NSEC-NCPMIN*60
      CALL ULINE (IUNIT,2)
      WRITE (IUNIT,230) NCPMIN,NCPSEC
C
C  PRINT CLOCK TIME USED
      CALL UCLKTM (JULDAY,NHMS,IERR)
      IDAY=ISTDAY
      IHMS=ISTHMS
      IF (JULDAY.GT.IDAY) NHMS=NHMS+2400*100
      CALL UDSECS (IHMS,NSEC1)
      CALL UDSECS (NHMS,NSEC2)
      NSEC=NSEC2-NSEC1
      NETMIN=NSEC/60
      NETSEC=NSEC-NETMIN*60
      ETUSD=NETMIN*1.+NSEC/60.
      IF (ICMDBG.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,250) NHMS,IHMS,NETMIN,NETSEC,ETUSD
         ENDIF
      CALL ULINE (IUNIT,2)
      WRITE (IUNIT,260) NETMIN,NETSEC
C
C  PRINT NUMBER OF PAGES AND LINES PRINTED
100   IF (IPSPAG(IUNIT).EQ.1) THEN
         NPAGES=NPSPAG(IUNIT)
         IF (NPSPAG(IUNIT).LT.0) NPAGES=0
         CALL ULINE (IUNIT,2)
         WRITE (IUNIT,270) IUNIT,NPAGES,IUNIT,NPSNLT(IUNIT)
         ENDIF
C
      CALL ULINE (IUNIT,0)
      WRITE (IUNIT,150)
C
      IF (ICMDBG.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,*) 'MAXCDE=',MAXCDE,
     *      ' ISTOP=',ISTOP,
     *      ' ISTOPX=',ISTOPX
         ENDIF
C
      IF (NSTOP.EQ.-1) GO TO 110
C
C  STOP THE PROGRAM
      CALL USTOP2
C
110   IF (ICMTRC.GT.0) THEN
         CALL ULINE (ICMPRU,1)
         WRITE (ICMPRU,*) '*** EXIT USTOP :',
     *      ' ISTOPX=',ISTOPX
         ENDIF
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
130   FORMAT (' IPSPAG(IUNIT)=',I2,3X,
     *   'IERPRT=',I2,3X,
     *   'ICDPRT=',I2,3X,
     *   'ITMPRT=',I2)
150   FORMAT ('0',132('*'))
160   FORMAT ('0',15X,'SUMMARY OF ERRORS AND WARNINGS PRINTED ON ',
     *   'UNIT ',I2.2,' : ')
170   FORMAT (' ',23X,'TOTAL NUMBER OF ERRORS   = ',I3)
180   FORMAT (' ',23X,'TOTAL NUMBER OF WARNINGS = ',I3)
190   FORMAT (' ',28X,'ERRORS   OCCURRED ON THE FOLLOWING ',
     *   'PAGES :  ',10I5)
200   FORMAT (' ',28X,'WARNINGS OCCURRED ON THE FOLLOWING ',
     *   'PAGES :  ',10I5)
210   FORMAT (T74,10I5)
220   FORMAT ('0',15X,'COMPLETION CODE = ',I2)
230   FORMAT ('0',15X,'CPU   TIME USED = ',I4,' MINUTES,',1X,
     *   I2,' SECONDS')
240   FORMAT (' NTERR(LUNIT)=',I3,3X,'NTWRN(LUNIT)=',I3,3X,
     *   'NPGERR(LUNIT)=',I3,3X,'NPGWRN(LUNIT)=',I3)
250   FORMAT (' NHMS=',I8,3X,'IHMS=',I8,3X,'NETMIN=',I6,3X,
     *   'NETSEC=',I6,3X,'ETUSD=',F8.2)
260   FORMAT ('0',15X,'CLOCK TIME USED = ',I4,' MINUTES,',1X,
     *   I2,' SECONDS')
270   FORMAT ('0',15X,'NUMBER OF PAGES PRINTED ON UNIT ',I2.2,' = ',I4,
     *      10X,
     *   'NUMBER OF LINES PRINTED ON UNIT ',I2.2,' = ',I6)
C
      END