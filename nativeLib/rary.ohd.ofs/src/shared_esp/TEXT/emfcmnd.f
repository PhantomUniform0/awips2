C MODULE EMFCMND
C-----------------------------------------------------------------------
C
      SUBROUTINE EMFCMND (NCARDS,MECARDS,ICMND,IDATE,LDATE,KDATE,istrt)
C
C     THIS ROUTINE FINDS A MOD COMMAND CARD IMAGE
C     AND DECODES ANY DATES ON THIS CARD
cew This is a modification of the original mfcmnd routine for use in the
cew mods updating scheme for esp.
C
      CHARACTER*8 CMDNAM,COMX,COMZ
C
      INCLUDE 'udatas'
      INCLUDE 'ufreex'
      INCLUDE 'common/ionum'
      INCLUDE 'common/fpwarn'
      INCLUDE 'common/modctl'
      COMMON/MDFLTD/MHDFLT
      COMMON/MFG/ISFG,NDTS
C
      character mecards(80,ncards)
      DIMENSION JDATE(7),IFIELD(3)
      DIMENSION OLDOPN(2)
      DIMENSION COMX(2),COMZ(1)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/shared_esp/RCS/emfcmnd.f,v $
     . $',                                                             '
     .$Id: emfcmnd.f,v 1.3 1998/10/14 15:27:52 page Exp $
     . $' /
C    ===================================================================
C
C
      DATA COMX/'BASEF   ','ROCHNG  '/
      DATA COMZ/'ROMULT  '/
C
      NCOMX=2
      NCOMZ=1
C
C     INITIALIZE VARIABLES IDATE, LDATE, KDATE
C
      IDATE=0
      LDATE=0
      KDATE=0
C
      CALL FSTWHR(8HEMFCMND ,0,OLDOPN,IOLDOP)
C
C     GET FIRST FIELD FROM CARD IMAGE
C
      ICKDAT=0
C
C     GET FIRST FIELD FROM CARD IMAGE
C
10    NFLD=0
      ISTRT=-3
      NCHAR=3
C
      CALL UFIEL2(NCARDS,MECARDS,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      ICKDAT=1
C
C     VALID STATUS?
C
      IF(ISTAT.EQ.0)GO TO 20
C
C     PROBLEMS - CANNOT BE COMMAND CARD - AT END OF INPUT?
C
      IF(ISTAT.NE.3)GO TO 10
C
C     AT END OF INPUT - SET ICMND TO 0
C
      ICMND=0
      GO TO 120
C
20    ICMND=MIFCMD(IFIELD,LEN,NFLD)
C
      IF(ICMND.EQ.0)GO TO 10
C
C     VALID COMMAND - NOW DECODE DATES ON THE COMMAND CARD
C     IF NEEDED - IF JUST CHECKING FOR A VALID COMMAND - RETURN
C
      IF(NDTS.EQ.0)GO TO 120
C
C     HAVE DATES TO DECODE
C
      ISTRT=-3
      NCHAR=3
C
      CALL UFIEL2(NCARDS,MECARDS,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      NUMBER=0
C
C     VALID DATE FIELD?
C
      IF(ISTAT.NE.5)GO TO 70
C
C     DOES FIELD CONTAIN AN ASTERISK?
C
      IF(LASK.GT.0)GO TO 70
C
C  DATE IS VALID - STORE IN VARIABLE IDATE
      IPACK=1
      NHRADD=0
      NHSWCH=1
      IPRINT=0
      CALL HDATEA (LEN,ICDBUF(ISTRT:ISTRT),IPACK,NHRADD,NHSWCH,IPRINT,
     *   JDA,IHR,IDATE,ISTAT)
      IF (MHDFLT.EQ.0) IDATE=-IDATE

C     DATE IS VALID - STORE IN VARIABLE IDATE
C
cew      CALL HDATEA (LEN,ICDBUF(ISTRT:ISTRT),0,0,1,0,JDA,IHR,IDATE,ISTAT)
cew      IF(MHDFLT.EQ.0)IDATE=-IDATE
C
C     IS A SECOND DATE EXPECTED?
C
      IF(NDTS.EQ.1)GO TO 120
C
C     YES - DECODE AND STORE IN VARIABLE LDATE
C
      ISTRT=-3
      NCHAR=3
C
      CALL UFIEL2(NCARDS,MECARDS,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
C  CHECK FOR A NULL FIELD
C
      IF (ISTRT.NE.-2) GOTO 40
      CALL MCMDNA(ICMND,CMDNAM)
C
      DO 30 I=1,NCOMX
C        IF ((CMDNAM .EQ. COMX(I)).AND.(NFLD .EQ. 2)) GOTO 9999
         IF (CMDNAM.EQ.COMX(I)) GOTO 120
30    CONTINUE
C
40    NUMBER=1
C
C     VALID DATE FIELD?
C
      IF(ISTAT.NE.5)GO TO 70
C
C     DOES FIELD CONTAIN AN ASTERISK?
C
      IF(LASK.GT.0)GO TO 70
C
C     DATE IS VALID - STORE IN VARIABLE LDATE
C
      CALL HDATEA (LEN,ICDBUF(ISTRT:ISTRT),0,0,1,0,JDA,IHR,LDATE,ISTAT)
      IF(MHDFLT.EQ.0)LDATE=-LDATE
C
C
C     IS A THIRD DATE EXPECTED?
C
      IF(NDTS.EQ.2)GO TO 120
C
C     YES - DECODE AND STORE IN VARIABLE KDATE
C
      ISTRT=-3
      NCHAR=3
C
      CALL UFIEL2(NCARDS,MECARDS,NFLD,ISTRT,LEN,ITYPE,NREP,INTGER,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF (ISTRT.NE.-2) GOTO 60
      CALL MCMDNA(ICMND,CMDNAM)
C
      DO 50 I=1,NCOMZ
C        IF ((CMDNAM .EQ. COMZ(I)).AND.(NFLD .EQ. 3)) GOTO 9999
         IF (CMDNAM.EQ.COMZ(I)) GOTO 120
50    CONTINUE
C
60    NUMBER=2
C
C     VALID DATE FIELD?
C
      IF(ISTAT.NE.5)GO TO 70
C
C     DOES FIELD CONTAIN AN ASTERISK?
C
      IF(LASK.GT.0)GO TO 70
C
C     DATE IS VALID - STORE IN VARIABLE KDATE
C
      CALL HDATEA (LEN,ICDBUF(ISTRT:ISTRT),0,0,1,0,JDA,IHR,KDATE,ISTAT)
      IF(MHDFLT.EQ.0)KDATE=-KDATE
C
      GO TO 120
C
C     GET HERE WITH AN ERROR ON A DATE FIELD FOR A VALID COMMAND
C
70    IF(IWHERE.GT.1.OR.MODWRN.EQ.0)GO TO 110
C     ICMDNU=MCMDNA(ICMND,CMDNAM)
      CALL MCMDNA(ICMND,CMDNAM)
C
      IF(ISTRT.NE.-2)WRITE(IPR,80)CMDNAM
80    FORMAT(1H0,10X,'** WARNING ** ERROR IN A DATE FIELD FOR ',
     1  'MOD COMMAND ',A8/11X,'THIS MOD COMMAND WILL BE SKIPPED')
C
      IF(ISTRT.EQ.-2)WRITE(IPR,90)NDTS,CMDNAM,NUMBER
90    FORMAT(1H0,10X,'** WARNING **',I3,' DATES ARE EXPECTED FOR THE ',
     1 A8,' MOD COMMAND.',I3,' DATES WERE ENTERED.'/
     2 26X,'THIS MOD COMMAND WILL BE SKIPPED.')
      WRITE(IPR,100) (MECARDS(I,NRDCRD),I=1,20)
100   FORMAT(23X,'THE MOD CARD IMAGE IS: ',20A4)
      CALL WARN
C
110   ICMND=-ICMND
C
120   CALL FSTWHR(OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      RETURN
C
      END