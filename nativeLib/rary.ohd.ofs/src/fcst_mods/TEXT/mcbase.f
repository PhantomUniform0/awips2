C MODULE MCBASE
C
C     DESC - SUBROUTINE MCBASE PERFORMS THE CBASEF MOD
C
C  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C
      SUBROUTINE MCBASE(NCARDS,MODCRD,P,MP,IDATE,ISTATT,IHZERO)
C
      CHARACTER*8   OPNAME,OPN,BLANK8,MODNAM
      LOGICAL FIRST
      INCLUDE 'ufreex'
      INCLUDE 'common/fmodft'
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fctime'
      INCLUDE 'common/fctim2'
      INCLUDE 'common/fpwarn'
C
      DIMENSION MODCRD(20,NCARDS),P(MP),IFIELD(3),UNITS(2)
      DIMENSION OLDOPN(2),MODNAM(2)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_mods/RCS/mcbase.f,v $
     . $',                                                             '
     .$Id: mcbase.f,v 1.2 1998/07/02 20:44:20 page Exp $
     . $' /
C    ===================================================================
C
C
      DATA ISLASH/4H/   /,BLANK8/8H        /,UNITS/4HMI. ,4HKM. /
      DATA MODNAM/8HCBASEF  ,8HCBFRATE /
C
      IMOD=1
C
      CALL FSTWHR(8HMCBASE  ,0,OLDOPN,IOLDOP)
C
C     SET DEBUG SWITCH
C
      IBUG=IFBUG(4HMODS)+IFBUG(4HCBAS)
C
      IF(IBUG.GT.0)WRITE(IODBUG,900)MODNAM(IMOD),IDATE
  900 FORMAT(11X,'*** ENTERING SUBROUTINE MCBASE, ',A8,'MOD ***  IDATE='
     1 ,I11)
C
      ISTATT=1
C
C     SEE IF DATE IS WITHIN RUN PERIOD
C
      ISTHR=(IDA-1)*24+IHZERO
      IENHR=(LDA-1)*24+LHR
C
      IF(ISTHR.LE.IDATE.AND.IENHR.GE.IDATE)GO TO 11
C
C     DATE NOT WITHIN ALLOWABLE WINDOW
C
      CALL MDYH2(IDA,IHZERO,IM1,ID1,IY1,IH1,DUM1,DUM2,MODTZC)
      CALL MDYH2(LDA,LHR,IM2,ID2,IY2,IH2,DUM1,DUM2,MODTZC)
      IXDA=IDATE/24+1
      IXHR=IDATE-(IXDA-1)*24
      IF(IXHR.EQ.0)IXDA=IXDA-1
      IF(IXHR.EQ.0)IXHR=24
      CALL MDYH2(IXDA,IXHR,IM3,ID3,IY3,IH3,DUM1,DUM2,MODTZC)
C
      IF(MODWRN.EQ.1)WRITE(IPR,602)MODNAM(IMOD),
     . IM3,ID3,IY3,IH3,MODTZC,IM1,ID1,IY1,IH1,MODTZC,
     1 IM2,ID2,IY2,IH2,MODTZC
  602 FORMAT(1H0,10X,'**WARNING** THE DATE FOR CHANGES ENTERED IN THE ',
     1 A8,'MOD (',I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/11X,
     2 'IS NOT WITHIN THE CURRENT RUN PERIOD (',I2,1H/,I2,
     3 1H/,I4,1H-,I2,1X,A4,4H TO ,I2,1H/,I2,1H/,I4,1H-,I2,1X,A4,1H)/
     4 11X,'THESE CHANGES WILL BE IGNORED.')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 999
C
   11 CONTINUE
C
C     READ CARD - IF COMMAND, LEAVE - IF COMMAND AND 1ST CARD, ERROR
C
      OPNAME=BLANK8
      OPN=BLANK8
      FIRST=.TRUE.
      IXX=IUMAPI+1
C
      IF(NRDCRD.EQ.NCARDS)GO TO 13
C
    1 IF(NRDCRD.EQ.NCARDS)GO TO 999
C
      IF(MISCMD(NCARDS,MODCRD).EQ.0)GO TO 17
C
      IF(.NOT.FIRST)GO TO 999
C
C     HAVE FOUND COMMAND AS FIRST SUBSEQUENT CARD - ERROR
C
   13 IF(MODWRN.EQ.1)
     .WRITE(IPR,920)MODNAM(IMOD)
  920 FORMAT(1H0,10X,'**WARNING** NO SUBSEQUENT CARDS FOUND FOR THE ',
     1  A8,'MOD.  PROCESSING CONTINUES')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 999
C
   17 FIRST=.FALSE.
      NRDCRD=NRDCRD+1
C
C     NOW READ 2ND FIELD - MUST BE A REAL NO. OR INTEGER
C
      NFLD=1
      ISTRT=-3
      NCHAR=3
      ICKDAT=0
C
      CALL UFIEL2(NCARDS,MODCRD,NFLD,ISTRT,LEN,ITYPE,NREP,IVALUE,VALUE,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF(ISTAT.EQ.0)GO TO 28
C
C     ERROR - DATA EXPECTED - PROCESS NEXT CARD
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,921)MODNAM(IMOD),(MODCRD(I,NRDCRD),I=1,20)
  921 FORMAT(1H0,10X,'**WARNING** IN THE ',A8,'MOD - NOT ENOUGH ',
     1  'FIELDS ON SUBSEQUENT CARD.  THE CARD BEING PROCESSED IS:'/
     2  11X,20A4)
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
   28 IF(ITYPE.LT.2.AND.NREP.EQ.-1)GO TO 40
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,922)MODNAM(IMOD),(MODCRD(I,NRDCRD),I=1,20)
  922 FORMAT(1H0,10X,'**WARNING** IN ',A8,',MOD - INVALID VALUE ',
     1  'FOUND THE CARD BEING PROCESSED IS:'/11X,20A4)
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
   40 IF(VALUE.GE.0.)GO TO 15
C
C     BAD CONSTANT BASELOW VALUE ENTERED
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,604)MODNAM(IMOD),VALUE
  604 FORMAT(1H0,10X,'**WARNING** IN ',A8,'MOD - VALUE IS OUT OF ',
     1 'VALID RANGE '/11X,'VALUE = ',G10.4)
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
   15 CONTINUE
C
C  IF CBASEF MOD (IMOD=1) --
C   VALUE ENTERED IS CMS IF METRIC UNITS (IUMAPI=1)
C                 OR CFS IF ENGLISH UNITS (IUMAPI=0)
C   IF METRIC - NO CONVERSION NEEDED
C   IF ENGLISH - CHANGE TO CMS
C
C  IF CBFRATE MOD (IMOD=2) --
C   VALUE ENTERED IS CMS/SQ KM IF METRIC UNITS (IUMAPI=1)
C                 OR CFS/SQ MI IF ENGLISH UNITS (IUMAPI=0)
C   IF METRIC - NO CONVERSIONS NEEDED - JUST MULTIPLY VALUE
C               BY AREA AS STORED IN P() (I.E., IN SQ KM)
C   IF ENGLISH - 1ST CHANGE TO CMS/SQ MI
C                THEN CONVERT AREA TO SQ MI BEFORE MULTIPLYING BELOW
C
      IF(IUMAPI.EQ.1)GO TO 111
C
C     MUST CONVERT FROM CFS TO CMS
C
      CALL FCONVT(4HCMS ,4HL3/T,ENGUN,ACM2CF,BCM2CF,IER)
C
      VALUE=VALUE/ACM2CF
C
  111 CONTINUE
C
C  IF CBFRATE MOD --
C    NOW VALUE IS IN UNITS OF CMS PER AREA
C    WILL CONVERT AREA BEFORE STORING IN P ARRAY IF NEEDED
C
C     LOOK FOR BASEFLOW OPERATIONS IN THIS SEGMENT WITH NAME OPNAME
C     IF OPNAME BLANK - CHANGE FOR ALL BASEFLOW OPERS IN THIS SEGMENT
C
C     READ NEXT FIELD - IF NONE CHANGE ALL BASEFLOW OPERS IN SEGMENT
C     IF A SLASH FOUND - READ OPERATION NAME IN FOLLOWING FIELD
C
      ISTRT=-3
      NCHAR=3
      ICKDAT=0
C
      CALL UFIEL2(NCARDS,MODCRD,NFLD,ISTRT,LEN,ITYPE,NREP,INTEGR,REAL,
     1  NCHAR,IFIELD,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF(ISTRT.EQ.-2)GO TO 20
C
C     FIELD FOUND - MUST BE A SLASH
C
      IF(LEN.EQ.1.AND.IFIELD(1).EQ.ISLASH)GO TO 55
C
C     FIELD IS NOT SLASH - ERROR
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,930)(MODCRD(I,NRDCRD),I=1,20)
  930 FORMAT(1H0,10X,'**WARNING** A SLASH WAS EXPECTED AS THE THIRD ',
     1 'FIELD OF THE FOLLOWING MOD CARD:'/11X,20A4,/11X,
     2 'THIS CARD IS IGNORED AND PROCESSING CONTINUES')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
   55 CONTINUE
C
C     SLASH FOUND - NOW READ OPERATION NAME
C
      ISTRT=-3
      NCHAR=2
      ICKDAT=0
C
      CALL UFIEL2(NCARDS,MODCRD,NFLD,ISTRT,LEN,ITYPE,NREP,INTEGR,REAL,
     1  NCHAR,OPNAME,LLPAR,LRPAR,LASK,LATSGN,LAMPS,LEQUAL,ISTAT)
C
      IF(ISTRT.NE.-2)GO TO 57
C
C     NO FIELD FOUND FOR OPERATION NAME - ERROR
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,933)(MODCRD(I,NRDCRD),I=1,20)
  933 FORMAT(1H0,10X,'**WARNING** NO OPERATION NAME WAS FOUND AFTER ',
     1 'THE SLASH ON THE FOLLOWING MOD CARD:'/11X,20A4/11X,
     2 'THIS CARD IS IGNORED AND PROCESSING CONTINUES')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
C     HAVE A SPECIFIC OPERATION NAME - FIND THAT OPERATION
C
   57 LOCP=0
      CALL FSERCH(38,OPNAME,LOCP,P,MP)
C
      IF(LOCP.GT.0)GO TO 18
C
C     HAVE NOT FOUND THE REQUESTED OPERATION - ERROR
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,605)OPNAME,MODNAM(IMOD)
  605 FORMAT(1H0,10X,'**WARNING** A BASEFLOW OPERATION WITH NAME ',
     1 A8,' HAS NOT BEEN FOUND IN THIS SEGMENT.'/11X,
     2 'THE ',A8,'MOD CANNOT BE PERFORMED FOR THIS OPERATION.')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 1
C
   18 CONTINUE
C
C     HAVE FOUND OPERATION - CHANGE VALUE IN P ARRAY
C
      AREABF=1.0
C
      P(LOCP+7)=VALUE*AREABF
      ISTATT=0
C
      IF(IBUG.EQ.0)GO TO 1
      WRITE(IODBUG,902)MODNAM(IMOD),P(LOCP+7),OPNAME
  902 FORMAT(11X,'IN ',A8,'MOD - SUBROUTINE MCBASE'/11X,
     1 'A VALUE OF ',F8.2,' HAS BEEN STORED IN THE P ARRAY OF ',
     2 'BASEFLOW OPERATION ',A8,' AS THE CONSTANT BASEFLOW IN CMS.')
      GO TO 1
C
   20 CONTINUE
C
C     CHANGE ALL OCCURENCES OF BASEFLOW OPERATION IN THIS SEGMENT
C
      NCHNGE=0
      LOCP=1
   30 CALL FSERCH(38,OPN,LOCP,P,MP)
C
      IF(LOCP.EQ.0.AND.NCHNGE.GT.0)GO TO 1
      IF(LOCP.GT.0)GO TO 35
C
C     IF GET HERE HAVE NOT FOUND ANY BASEFLOW OPERATIONS IN THIS SEGMENT
C
      IF(MODWRN.EQ.1)
     .WRITE(IPR,606)MODNAM(IMOD)
  606 FORMAT(1H0,10X,'**WARNING** A ',A8,'MOD WAS REQUESTED FOR ',
     1 'THIS SEGMENT'/11X,'BUT NO BASEFLOW OPERATIONS WERE FOUND.')
      IF(MODWRN.EQ.1)CALL WARN
      GO TO 999
C
   35 CONTINUE
C
C     HAVE FOUND A BASEFLOW OPERATION - CHANGE P ARRAY
C
      AREABF=1.0
C
      NCHNGE=NCHNGE+1
      P(LOCP+7)=VALUE*AREABF
      ISTATT=0
C
      IF(IBUG.EQ.0)GO TO 30
      WRITE(IODBUG,902)MODNAM(IMOD),P(LOCP+7),OPN
      GO TO 30
C
  999 CALL FSTWHR(OLDOPN,IOLDOP,OLDOPN,IOLDOP)
      IF(IBUG.GT.0)WRITE(IODBUG,842)MODNAM(IMOD)
  842 FORMAT(11X,'*** LEAVING SUBROUTINE MCBASE, ',A8,'MOD')
C
      RETURN
      END
