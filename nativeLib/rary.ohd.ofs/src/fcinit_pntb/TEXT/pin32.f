C MODULE PIN32
C-----------------------------------------------------------------------
C
      SUBROUTINE PIN32 (PO,LEFTP,IUSEP,P,MP,PARRY,LPARRY)
C
C  THIS ROUTINE READS AND CHECKS ALL CARD IMAGE INPUT FOR SEGMENT
C  DEFINITION FOR THE FFG OPERATION AND FILLS THE PO ARRAY.
C
C***********************************************************************
C  INITIALLY WRITTEN BY
C       JANICE LEWIS -  HYDROLOGIC RESEARCH LAB, W/OH3   OCT 1991
C
C  UPDATED TO ALLOW BASIN BOUNDARY ID EVEN THOUGH NOT USED BY
C  MAP OR MAPX (I.E. PREDETERMINED WEIGHTS).
C      TIM SWEENEY, HYDROLOGIC RESEARCH LAB              OCT 1993
C
C  ADDED MINIMUM AND MAXIMUM THRESHOLD RUNOFF VALUES AS OPTIONS.
C      TIM SWEENEY, HYDROLOGIC RESEARCH LAB              JAN 1995
C
C  ADDED ROUTINE DEL32 TO DELETE FFG DATA TYPE IN PPPDB.  DEL32
C  CALLED FROM ROUTINE SEGDEF AND DELSEG.  ADDED LIST OF CONTENTS OF
C  PARRY ARRAY (FFG ARRAY IN PPPDB).
C      TIM SWEENEY, HRL                                  MAY 1997
C***********************************************************************
C  PRINCIPAL VARIABLES...
C
C  FOR DEFINITION OF VARIABLES IN ROUTINE ARGUMENT LIST, SEE SECTION
C  VIII.4.2-PIN OF THE NWSRFS USER'S MANUAL.
C
C  FOR DEFINITION OF VARIABLES IN COMMON BLOCKS, SEE SECTION IX.3.3C
C  OF THE NWSRFS USER'S MANUAL.
C
C     BASNID       BASIN BOUNDARY IDENTIFIER
C     BASNTYP      BASIN BOUNDARY DATA TYPE (BASN)
C     BBX          HRAP COLUMN OF CENTROID OF AREA
C     BBY          HRAP ROW OF CENTROID OF AREA
C     FFGAID       FLASH FLOOD GUIDANCE AREA IDENTIFIER
C     FFGDSC       FLASH FLOOD GUIDANCE AREA DESCRIPTION
C     IBUG         DEBUG OUTPUT SWITCH, 0 = OFF, 1 = ON
C     IDUR         DURATION FLAG, 0 = 1-, 3-, AND 6-HOUR DURATIONS ONLY,
C                    1 = 12- AND 24-HOUR DURATIONS ALSO.
C     INDERR       FATAL ERROR FLAG, 0 = NO FATAL ERRORS, 1 = ERRORS
C     IOPRR        STARTING LOCATION OF RAINFALL-RUNOFF PARAMETERS IN
C                    THE P ARRAY, 0 = OPERATION NOT IN SEGMENT
C     IOPSN        STARTING LOCATION OF SNOW PARAMETERS IN THE P ARRAY,
C                    0 = OPERATION NOT IN SEGMENT
C     IREC         STARTING LOCATION OF BASIN PARAMETERS IN PREPROCESSOR
C                    PARAMETRIC DATA BASE
C     IRECNX       POINTER TO NEXT PARAMETER RECORD OF 'BASN' DATA TYPE
C                    (NOT NEEDED)
C     ISTAT        BASIN BOUNDARY STATUS CODE, 0 = SUCCESSFUL READ,
C                    2 = RECORD NOT FOUND, NOT 0 OR 2 UNABLE TO READ REC
C     IRROP(6)     ALLOWABLE RAINFALL-RUNOFF OPERATIONS USED BY THIS
C                    OPERATION: SAC-SMA, API-CONT, API-MKC, API-CIN,
C                    API-HAR, AND API-HFD (API-SLC IS NOT AVAILABLE)
C     IUSEP        NUMBER OF WORDS REQUIRED IN THE P ARRAY FOR
C                    THIS OPERATION
C     LPARRY       MAXIMUM SIZE OF TEMPORARY WORK SPACE TO HOLD BASIN
C                    BOUNDARY PARAMETER / FFG PARAMETER ARRAY
C     LEFTC        NUMBER OF WORDS AVAILABLE IN THE C ARRAY
C     LEFTP        NUMBER OF WORDS AVAILABLE IN THE P ARRAY
C     MFFG         MAXIMUM SIZE OF FLASH FLOOD GUIDANCE PARAMETER ARRAY
C     NFILL        NUMBER OF FULL WORDS FILL IN PBASN ARRAY
C     NOP          NUMBER OF THIS OPERATION (32)
C     NOPRR        NUMBER OF OPERATION ASSIGNED TO RAINFALL-RUNOFF
C                    OPERATION
C     NOPSN        NUMBER OF OPERATION ASSIGNED TO SNOW OPERATION
C     OPNARR       OPERATION NAME OF RAINFALL-RUNOFF MODEL
C     OPNASN       OPERATION NAME OF SNOW MODEL
C     OPTYRR       OPERATION TYPE OF RAINFALL-RUNOFF MODEL
C     OPTYSN       OPERATION TYPE OF SNOW MODEL
C     PARRY(LPARRY) TEMPORARY WORK ARRAY FOR BASIN BOUNDARY /  FLASH
C                    FLOOD GUIDANCE PARAMETERS
C     PO(*)        INPUT PARAMETRIC DATA FROM P ARRAY
C     RRCOTP(10)   TEMPORARY STORAGE ARRAY FOR RAINFALL/RUNOFF CO VALUES
C     SNCOTP(10)   TEMPORARY STORAGE ARRAY FOR SNOW CO VALUES
C     TSIDRR       RAIN+MELT TIME SERIES IDENTIFIER FOR RAINFALL-RUNOFF
C                    OPERATION
C     TSIDSN       PRECIPITATION TIME SERIES IDENTIFIER FOR SNOW
C                    OPERATION
C     TSDTRR       RAIN+MELT TIME SERIES DATA TYPE FOR RAINFALL-RUNOFF
C                    OPERATION
C     TSDTSN       PRECIPITATION TIME SERIES DATA TYPE FOR SNOW
C                    OPERATION
C     TSMAP        TIME SERIES IDENTIFIER FOR MAP DATA TYPE IN BASIN
C                    BOUNDARY
C     TSMAPX       TIME SERIES IDENTIFIER FOR MAPX DATA TYPE IN BASIN
C                    BOUNDARY
C     TSTADT       TIME INTERVAL OF AIR TEMPERATURE TIME SERIES
C     VERS         VERSION NUMBER
C
C***********************************************************************
C  CONTENTS OF THE PO ARRAY...
C
C       WORD   ITEM
C     -------  ---------------------------------------------------------
C        1     VERSION NUMBER
C       2-3    FLASH FLOOD GUIDANCE AREA IDENTIFIER
C       4-8    DESCRIPTION
C       9-10   OPERATION TYPE FOR RAINFALL-RUNOFF MODEL
C      11-12   OPERATION NAME FOR RAINFALL-RUNOFF MODEL
C      13-14   OPERATION TYPE FOR SNOW MODEL
C      15-16   OPERATION NAME FOR SNOW MODEL
C      17-18   BASIN BOUNDARY IDENTIFIER
C       19     DURATION FLAG
C       20     SWITCH INDICATING SNOW IS USED
C       21     OPERATION NUMBER OF RAINFALL/RUNOFF NUMBER
C       22     STARTING LOCATION OF FFG INFORMATION IN PPPDB
C       23     NUMBER OF WORDS IN THE PPPDB FFG RECORD
C       24     LOCATION OF MIN AND MAX THRESHOLD RUNOFF IN PO ARRAY
C                (= 30, MIN & MAX SUPPLIED BY USER)
C                (= 0, MIN & MAX NOT SUPPLIED BY USER)
C      25-29   EMPTY SPACE (ZEROES)
C     PO(24)   MINIMUM THRESHOLD RUNOFF, WHEN DEFAULT 0.10 NOT DESIRED
C    PO(24)+1  MAXIMUM THRESHOLD RUNOFF, WHEN DEFAULT 2.50 INCHES
C              NOT DESIRED
C
C***********************************************************************
C  CONTENTS OF THE PARRY ARRAY (FFG ARRAY IN PPPDB):
C
C      WORD        ITEM
C     -------      -----------------------------------------------------
C        1         Version number
C       2-3        Flash Flood Guidance area identifier
C       4-8        Flash Flood Guidance areaescription
C       9-10       Basin boundary identifier
C       11         HRAP row (y coordinate) of basin centroid
C       12         HRAP column (x coordinate) of basin centroid
C       13         Duration flag:
C                    0 = for 1, 3, and 6 hours
C                    1 = for 1, 3, 6, and 12 hours
C                    2 = for 1, 3, 6, 12, and 24 hours
C       14         Location of snow model info in this array (LS):
C                    0 = not used
C     15-16        Not used
C       17         Date and time (LSTCMPDY) of values (julian
C                    hour since 0Z on 1/01/1900)
C     18-25        Four pairs of alternating rainfall and runoff values
C                    that define the curve for 1-hour duration
C     26-33        Same for 3-hour duration
C     34-41        Same for 6-hour duration
C     42-49        Same for 12-hour duration (optional)
C     50-57        Same for 24-hour duration (optional)
C 42-43 or 58-59   Rainfall-runoff model type
C 44-45 or 60-61   Rainfall-runoff model name
C    46 or 62      Number of rainfall-runoff model carryover values
C 47-var or 63-var State variables from rainfall-runoff model
C    LS to LS+1    Snow model type
C  LS+2 to LS+3    Snow model name
C     LS+4         Number of snow model carryover values
C  LS+5 to var     State variables from snow model
C
C***********************************************************************
C
      CHARACTER*4 FFGTYP,BASNTYP
      CHARACTER*4 TSDTSN,TSDTRR
      CHARACTER*8 RTNNAM
      CHARACTER*8 SEGID,FFGAID,BASNID
      CHARACTER*8 OPNARR,OPTYRR,OPNASN,OPTYSN
      CHARACTER*8 RRTY,RRNA,SNTY,SNNA
      CHARACTER*8 TSIDRR,TSIDSN,TSMAP,TSMAPX
      CHARACTER*20 FFGDSC
      CHARACTER*10 STRING
C
      DIMENSION PO(*),P(MP),PARRY(LPARRY)
      DIMENSION RRCOTP(10),SNCOTP(10)
      PARAMETER (NRROP=6)
      INTEGER IRROP(NRROP)/1,24,29,33,35,43/
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/fclfls'
      INCLUDE 'common/where'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_pntb/RCS/pin32.f,v $
     . $',                                                             '
     .$Id: pin32.f,v 1.7 2003/11/26 12:56:22 scv Exp $
     . $' /
C    ===================================================================
C
C
      RTNNAM='PIN32'
C
      IF (ITRACE.GT.0) WRITE (IODBUG,*) 'ENTER ',RTNNAM
C
      IBUG=IFBUG('FFG')
C
      VERS=1.12
C
      IF (IBUG.GT.0) WRITE (IODBUG,*) 'VERS=',VERS
C
      IF (IBUG.EQ.1) WRITE (IODBUG,'(A,2A4)') ' IN PIN32 - ISEG=',ISEG
      CALL UMEMOV (ISEG,SEGID,2)
      IF (IBUG.EQ.1) WRITE (IODBUG,*) 'IN PIN32 - SEGID=',SEGID
C
      INDERR=0
      IUSEP=29
      IRRDO=0
      ISNDO=0
C
C  READ DATA TYPE CODE AND ID OF HYDROLOGIC LOCATION, DURATION SWITCH,
C  OPTIONAL MINIMUM & MAXIMUM THRESHOLD RUNOFF,
C  OPERATION TYPE AND NAME OF BOTH SNOW AND RAINFALL-RUNOFF MODEL
10    READ (IN,20,END=730,ERR=710) FFGAID,FFGDSC,IDUR,ROMIN,ROMAX
20    FORMAT (A,1X,A,5X,I1,2F5.2)
      IF (FFGAID(1:1).EQ.'$') GO TO 10
      IF (IBUG.GT.0) WRITE (IODBUG,30) FFGAID,FFGDSC,IDUR,ROMIN,ROMAX
30    FORMAT (' FFGAID=',A,' FFGDSC=',A,' IDUR=',I1,
     +        ' ROMIN=',F5.2,' ROMAX=',F5.2)
      READ (IN,40,END=730,ERR=710) BASNID,OPTYRR,OPNARR,OPTYSN,OPNASN
40    FORMAT (A,1X,4(A,2X))
      IF (IBUG.GT.0) WRITE (IODBUG,50) BASNID,OPTYRR,OPNARR,OPTYSN,
     +   OPTYSN,OPNASN
50    FORMAT (' BASNID=',A,' OPTYRR=',A,' OPNARR=',A,
     +   ' OPTYSN=',A,' OPNASN=',A)
C
C  CHECK THRESHOLD RUNOFF RANGE
C  NO RUNOFF RANGE DEFINED (USUAL CASE)
      IF (ROMIN.LE.-0.001.OR.ROMIN.GT.0.001) GO TO 60
      IF (ROMAX.LE.-0.001.OR.ROMAX.GT.0.001) GO TO 60
      LMMRO = 0
      GO TO 90
C
C  RUNOFF RANGE DEFINED
60    LMMRO = 30
      IF (ROMIN.LT.0.05.OR.ROMIN.GT. 3.0) GO TO 70
      IF (ROMAX.LT.2.0 .OR.ROMAX.GT.10.0) GO TO 70
      IF (ROMIN.GE.ROMAX) GO TO 70
      GO TO 90
C
70    LMMRO = 0
      WRITE (IPR,80) ROMIN,ROMAX
80    FORMAT ('0**ERROR** INVALID MINIMUM (',F5.2,
     +      ') AND/OR MAXIMUM (',F5.2,') THRESHOLD RUNOFF RANGE.' /
     +   11X,'VALID MINIMUM RUNOFF RANGE:  0.05 TO  3.00 ' /
     +   11X,'VALID MAXIMUM RUNOFF RANGE:  2.00 TO 10.00')
      CALL ERROR
      INDERR=1
      GO TO 270
C
90    IF (IBUG.GT.0) WRITE (IODBUG,100) LMMRO
100   FORMAT (' LMMRO=',I3)
C
C  CHECK RAINFALL-RUNOFF MODEL - DOES IT EXIST?
      CALL FOPCDE (OPTYRR,NOPRR)
      IF (IBUG.GT.0) WRITE (IODBUG,110) OPTYRR,NOPRR
110   FORMAT (' OPTYRR=',A,' NOPRR=',I2)
      IF (NOPRR.NE.0) GO TO 130
         WRITE (IPR,120) OPTYRR
120   FORMAT ('0**ERROR** INVALID OPERATION TYPE FOR RAINFALL-RUN ',
     *   'OFF MODEL: ',A,' DOES NOT EXIST.')
         CALL ERROR
         INDERR=1
         GO TO 270
C
C  CHECK RAINFALL-RUNOFF MODEL - IS IT IN THIS SEGMENT?
130   IOPRR=0
      CALL FSERCH (NOPRR,OPNARR,IOPRR,P,MP)
      IF (IBUG.GT.0) WRITE (IODBUG,140) NOPRR,OPNARR,IOPRR
140   FORMAT (' NOPRR=',I2,' OPNARR=',A,' IOPRR=',I4)
      IF (IOPRR.NE.0) GO TO 160
         WRITE (IPR,150) OPNARR
150   FORMAT ('0**ERROR** INVALID OPERATION NAME FOR RAINFALL-RUN ',
     *    'OFF MODEL: ',A,' IS NOT IN THIS SEGMENT.')
         CALL ERROR
         INDERR=1
         GO TO 270
C
C  CHECK RAINFALL-RUNOFF MODEL - IS IT AN ACCEPTABLE RR TYPE
160   DO 170 I=1,NRROP
         IF (NOPRR.NE.IRROP(I)) GO TO 170
            ICNT=I
            GO TO 190
170      CONTINUE
      WRITE (IPR,180) OPTYRR
180   FORMAT ('0**ERROR** INVALID OPERATION TYPE FOR RAINFALL-RUN ',
     * 'OFF MODEL: ',A,' IS NOT ALLOWED IN THIS OPERATION')
      CALL ERROR
      INDERR=1
      GO TO 270
C
C  FIND THE TIME SERIES FOR THE RAINFALL/RUNOFF MODEL
190   TSTARR=0.01
      GO TO (200,220,230,240,250,260),ICNT
      GO TO 270
C
C  SAC-SMA MODEL
200   CALL UMEMOV (P(IOPRR+7),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+9),TSDTRR,1)
      NCORR=7
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
210   FORMAT (' OPNARR=',A,' TSIDRR=',A,' TSDTRR=',A)
      GO TO 270
C
C  API-CONT MODEL
220   CALL UMEMOV (P(IOPRR+7),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+9),TSDTRR,1)
      TSTARR=P(IOPRR+17)
      NCORR=8
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
      GO TO 270
C
C  API-MKC MODEL
230   CALL UMEMOV (P(IOPRR+13),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+15),TSDTRR,1)
      NCORR=6
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
      GO TO 270
C
C  API-CIN MODEL
240   CALL UMEMOV (P(IOPRR+13),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+15),TSDTRR,1)
      NCORR=8
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
      GO TO 270
C
C  API-SLC MODEL
CCC245   CALL UMEMOV (P(IOPRR+11),TSIDRR,2)
CCC      CALL UMEMOV (P(IOPRR+13),TSDTRR,1)
CCC      NCORR=3
CCC      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
CCC      GO TO 200
C
C  API-HAR MODEL
250   CALL UMEMOV (P(IOPRR+25),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+27),TSDTRR,1)
      NCORR=8
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
      GO TO 270
C
C  API-HFD MODEL
260   CALL UMEMOV (P(IOPRR+25),TSIDRR,2)
      CALL UMEMOV (P(IOPRR+27),TSDTRR,1)
      NCORR = 8
      IF (IBUG.GT.0) WRITE (IODBUG,210) OPNARR,TSIDRR,TSDTRR
C
C  CHECK SNOW MODEL
270   NOPSN = 0
      IF (OPTYSN.EQ.' ') GO TO 350
C  CHECK SNOW MODEL - WAS THE CORRECT TYPE READ IN?
      CALL FOPCDE (OPTYSN,NOPSN)
      IF (IBUG.GT.0) WRITE (IODBUG,280) OPTYSN,NOPSN
280   FORMAT (' OPTYSN=',A,' NOPSN=',I2)
      IF (NOPSN.NE.0) GO TO 300
         WRITE (IPR,290) OPTYSN
290   FORMAT ('0**ERROR** INVALID OPERATION TYPE FOR SNOW MODEL:',A)
         CALL ERROR
         INDERR=1
         GO TO 350
C  CHECK SNOW MODEL - IS IT IN THIS SEGMENT?
300   IOPSN=0
      CALL FSERCH (NOPSN,OPNASN,IOPSN,P,MP)
      IF (IBUG.GT.0) WRITE (IODBUG,310) NOPSN,OPNASN,IOPSN
310   FORMAT (' NOPSN=',I2,' OPNASN=',A,' IOPSN=',I5)
      IF (IOPSN.NE.0) GO TO 330
         WRITE (IPR,320) OPNASN
320   FORMAT ('0**ERROR** INVALID OPERATION NAME FOR SNOW MODEL: ',A,
     +   ' IS NOT IN THIS SEGMENT.')
         CALL ERROR
         INDERR=1
         GO TO 730
330   CALL UMEMOV (P(IOPSN+6),TSIDSN,2)
      CALL UMEMOV (P(IOPSN+8),TSDTSN,1)
      PDTSN=P(IOPSN+9)
      NCOSN=10+(5/PDTSN)+2
      IF (IBUG.GT.0) WRITE (IODBUG,340) OPNASN,TSIDSN,TSDTSN
340   FORMAT (' OPNASN=',A,' TSIDSN=',A,' TSDTSN=',A)
C
C  CHECK BASIN BOUNDARY
350   IF (INDERR.EQ.1) GO TO 730
      BASNTYP='BASN'
      IREC=0
      CALL RPPREC (BASNID,BASNTYP,IREC,LPARRY,PARRY,NFILL,IRECNX,ISTAT)
      IF (IBUG.GT.0) WRITE (IODBUG,360) BASNID,BASNTYP,IREC,ISTAT
360   FORMAT (' BASNID=',A,' BASNTYP=',A,' IREC=',I5,' ISTAT=',I2)
      IF (ISTAT.NE.0) THEN
         CALL PSTRDC (ISTAT,BASNTYP,BASNID,IREC,LPARRY,NFILL)
         INDERR=1
         GO TO 730
         ENDIF
C  GET MAP/MAPX IDENTIFIERS AND HRAP COORDINATES OF CENTROID
      BBY=PARRY(12)
      BBX=PARRY(13)
      CALL UMEMOV (PARRY(14),TSMAP,2)
      CALL UMEMOV (PARRY(20),TSMAPX,2)
      IF (IBUG.GT.0) WRITE (IODBUG,380) TSMAP,TSMAPX
380   FORMAT (' TSMAP=',A,' TSMAPX=',A)
C
C  CHECK IF PRECIP TIME SERIES ID IN SNOW OPERATION MATCHES ID OF MAP
C  OR MAPX AREA USING THIS BASIN BOUNDARY
C
      IF (OPTYSN.EQ.' ') GO TO 410
C
C  (ASSUME MAP OR MAPX ID IS USED FOR THE PRECIP TIME SERIES ID)
      IF (TSDTSN.EQ.'MAP '.AND.TSIDSN.EQ.TSMAP) GO TO 420
      IF (TSDTSN.EQ.'MAPX'.AND.TSIDSN.EQ.TSMAPX) GO TO 420
      IF (TSDTSN.EQ.'MAP ') THEN
         WRITE (IPR,390) TSDTSN,TSIDSN,'SNOW',TSMAP
390   FORMAT ('0**WARNING** ',A,' TYPE TIME SERIES FOR ID (MAP ',
     *      'OR MAPX ID DEFINED IN BASIN BOUNDARY) ',A /
     *   13X,'DOES NOT MATCH TIME SERIES ID FOR ',A,' MODEL ',A,'.')
         CALL WARN
         GO TO 420
         ENDIF
      IF (TSDTSN.EQ.'MAPX') THEN
         WRITE (IPR,390) TSDTSN,TSIDSN,'SNOW',TSMAPX
         CALL WARN
         GO TO 420
         ENDIF
      WRITE (IPR,400) 'SNOW',TSDTSN
400   FORMAT ('0**ERROR** ',A,' IS AN INVALID DATA TYPE FOR ',A,
     *   ' MODELS. ONLY DATA TYPES MAP OR MAPX ARE ALLOWED.')
      CALL ERROR
      INDERR=1
      GO TO 730
C
410   IF (TSDTRR.EQ.'MAP '.AND.TSIDRR.EQ.TSMAP) GO TO 420
      IF (TSDTRR.EQ.'MAPX'.AND.TSIDRR.EQ.TSMAPX) GO TO 420
      IF (TSDTRR.EQ.'MAP ') THEN
         WRITE (IPR,390) TSDTRR,TSIDRR,'RAINFALL-RUNOFF',TSMAP
         CALL WARN
         GO TO 420
         ENDIF
      IF (TSDTRR.EQ.'MAPX') THEN
         WRITE (IPR,390) TSDTRR,TSIDRR,'RAINFALL-RUNOFF',TSMAPX
         CALL WARN
         GO TO 420
         ENDIF
      WRITE (IPR,400) TSDTRR,'RAINFALL-RUNOFF'
      CALL ERROR
      INDERR=1
      GO TO 730
C
C  CHECK P ARRAY TO MAKE SURE SPACE IS AVAILABLE FOR PO ARRAY
420   CALL CHECKP (IUSEP,LEFTP,IERR)
      IF (IERR.NE.0) THEN
         INDERR=1
         GO TO 730
         ENDIF
C
C  STORE PARAMETRIC DATA IN PO ARRAY
      PO(1) = VERS
      CALL UMEMOV (FFGAID,PO(2),LEN(FFGAID)/4)
      CALL UMEMOV (FFGDSC,PO(4),LEN(FFGDSC)/4)
      CALL UMEMOV (OPTYRR,PO(9),2)
      CALL UMEMOV (OPNARR,PO(11),LEN(OPNARR)/4)
      CALL UMEMOV (OPTYSN,PO(13),2)
      CALL UMEMOV (OPNASN,PO(15),2)
      CALL UMEMOV (BASNID,PO(17),LEN(BASNID)/4)
      PO(19) = IDUR + 0.01
      PO(20) = NOPSN + 0.01
      PO(21) = NOPRR + 0.01
C
      PO(24) = LMMRO + 0.01
C
      DO 430 I=25,29
         PO(I) = 0.01
430      CONTINUE
C
      IF (LMMRO.GT.0) THEN
         PO(LMMRO) = ROMIN
         PO(LMMRO+1) = ROMAX
         IUSEP = 31
         ENDIF
C
C  CHECK IF FFG AREA IDENTIFIER USED BY ANOTHER SEGMENT
      CALL CHK32 (SEGID,FFGAID,ISTAT)
C
C  CHECK FFG PARAMETER RECORD EXISTS
      IUPDT=1
      FFGTYP='FFG'
      IREC=0
      CALL RPPREC (FFGAID,FFGTYP,IREC,LPARRY,PARRY,NFILL,IRECNX,ISTAT)
      IF (IBUG.GT.0) WRITE (IODBUG,440) FFGAID,FFGTYP,IREC,ISTAT
440   FORMAT (' FFGAID=',A,' FFGTYP=',A,' IREC=',I5,' ISTAT=',I2)
      IF (ISTAT.EQ.0) THEN
         IF (IBUG.NE.0) THEN
            WRITE (IODBUG,*) 'IN PIN32 - NFILL=',NFILL,' IREC=',IREC,
     *         ' IWRPPP=',IWRPPP
            WRITE (IODBUG,*) 'CONTENTS OF FFG ARRAY (PARRY):'
            WRITE (IODBUG,700) (PARRY(I),I=1,NFILL)
            ENDIF
         ICKSEG=0
         IF (ICKSEG.EQ.1) THEN
            INEWSEG=0
            CALL FLOCSG (SEGID,IRSEG)
            IF (IRSEG.EQ.0) INEWSEG=1
            IF (INEWSEG.EQ.1) THEN
               WRITE (IPR,450) FFGTYP,FFGAID
450   FORMAT ('0**ERROR** SEGMENT IS BEING DEFINED AS A NEW SEGMENT ',
     *   'BUT A ',A,' PARAMETER RECORD EXISTS FOR IDENTIFIER ',A,'.')
               CALL ERROR
               INDERR=1
               GO TO 730
               ENDIF
            ENDIF
         PO(22)=IREC+0.01
         PO(23)=NFILL
         ELSE IF (ISTAT.EQ.2) THEN
           IUPDT=0
           ELSE
              CALL PSTRDC (ISTAT,FFGTYP,FFGAID,IREC,LPARRY,NFILL)
              INDERR=1
              GO TO 730
         ENDIF
C
C  CHECK SPACE IN PARAMETER ARRAY
      NFFG=41+IDUR*8
      NUM=NFFG
      LS=NFFG+NCORR+6
      NFFG=LS-1
      IF (NOPSN.GT.0) NFFG=NFFG+NCOSN+5
      IF (NFFG.GT.LPARRY) THEN
         WRITE (IPR,460) NFFG,LPARRY
460   FORMAT ('0**ERROR** NUMBER OF WORDS NEEDED IN FFG PARAMETER ',
     +   ' ARRAY (',I3,') EXCEEDS MAXIMUM (',I6,').')
         CALL ERROR
         INDERR=1
         GO TO 730
         ENDIF
C
      IF (IUPDT.EQ.0) GO TO 490
C
C  UPDATE FLASH FLOOD GUIDANCE PARAMETRIC DATA
      IDURO=PARRY(13)
      LSO=PARRY(14)
      NFFGO=42+IDURO*8
      CALL UMEMOV (PARRY(NFFGO),RRTY,2)
      CALL UMEMOV (PARRY(NFFGO+2),RRNA,2)
      IF (RRTY.NE.OPTYRR) IRRDO=1
      IF (RRNA.NE.OPNARR) IRRDO=1
C
      NCORRO = PARRY(NFFGO+4)
      IF (NCORRO.NE.NCORR) IUPDT = 0
C
      IF ((LSO.EQ.0.AND.NOPSN.NE.0).OR.
     *    (LSO.NE.0.AND.NOPSN.EQ.0)) ISNDO=1
      IF ((LSO.EQ.0).OR.(NOPSN.EQ.0)) GO TO 490
      CALL UMEMOV (PARRY(LSO),SNTY,2)
      CALL UMEMOV (PARRY(LSO+2),SNNA,2)
      IF (SNTY.NE.OPTYSN) ISNDO=1
      IF (SNNA.NE.OPNASN) ISNDO=1
C
C  INITIALIZE FLASH FLOOD GUIDANCE PARAMETERS
490   PARRY(1)=VERS
      CALL UMEMOV (FFGAID,PARRY(2),LEN(FFGAID)/4)
      CALL UMEMOV (FFGDSC,PARRY(4),LEN(FFGDSC)/4)
      CALL UMEMOV (BASNID,PARRY(9),LEN(BASNID)/4)
      PARRY(11)=BBY
      PARRY(12)=BBX
      PARRY(13)=IDUR+0.01
      PARRY(14)=0.01
      IF (NOPSN.GT.0) PARRY(14)=LS
      PARRY(15)=0.01
      PARRY(16)=0.01
C
      MORCRV=0
      IF (IUPDT.EQ.1) GO TO 510
C
C  STORE INITIAL CURVE VALUES AND TIME AS MISSING
      DO 500 I=17,NUM
         PARRY(I)=-999.
500      CONTINUE
      CALL UMEMOV (OPTYRR,PARRY(NUM+1),2)
      CALL UMEMOV (OPNARR,PARRY(NUM+3),LEN(OPNARR)/4)
      PARRY(NUM+5)=NCORR + 0.01
      NUM=NUM+5
      GO TO 610
C
510   IF (IDUR.EQ.IDURO) GO TO 600
C
C  STORE THE RAINFALL/RUNOFF STATE VARIABLES IN TEMPORARY SPACE
      II=NFFGO+4
      NUMRR=PARRY(II)
      DO 520 I=1,NUMRR
         RRCOTP(I)=PARRY(II+I)
520      CONTINUE
C
      IF (NOPSN.EQ.0.OR.LSO.EQ.0) GO TO 540
C
C  STORE THE SNOW STATE VARIABLES INTO TEMPORARY SPACE
      II=LSO+4
      NUMSN=PARRY(II)
      DO 530 I=1,NUMSN
         SNCOTP(I)=PARRY(II+I)
530      CONTINUE
C
540   IF (IDUR.LT.IDURO) GO TO 560
C
C  THE LAST TWO CURVES WERE ADDED - INITIALIZE AS MISSING
      I1=42+IDURO*8
      I2=I1+(IDUR-IDURO)*8-1
      DO 550 I=I1,I2
         PARRY(I)=-999.
550      CONTINUE
      MORCRV = 1
      GO TO 570
C
C  SOME OF THE CURVES WERE DELETED
560   I2=41+IDUR*8
      MORCRV = -1
C
C  STORE THE RAINFALL/RUNOFF PARAMETERS
570   CALL UMEMOV (OPTYRR,PARRY(I2+1),2)
      CALL UMEMOV (OPNARR,PARRY(I2+3),LEN(OPNARR)/4)
      I1=I2+5
      PARRY(I1)=NUMRR+0.01
      DO 580 I=1,NUMRR
         PARRY(I1+I)=RRCOTP(I)
580      CONTINUE
C
C  STORE THE SNOW PARAMETERS
      IF (NOPSN.EQ.0.OR.LSO.EQ.0) GO TO 600
         I2=I1+NUMRR
         CALL UMEMOV (OPTYSN,PARRY(I2+1),2)
         CALL UMEMOV (OPNASN,PARRY(I2+3),2)
         I2=I2+5
         PARRY(I2)=NUMSN+0.01
         DO 590 I=1,NUMSN
            PARRY(I2+I)=SNCOTP(I)
590         CONTINUE
C
600   IF (IRRDO.EQ.0) GO TO 630
C
C  SET INITIAL RAINFALL/RUNOFF CARRYOVER VALUES TO MISSING
610   DO 620 I=1,NCORR
         PARRY(NUM+I)=-999.
620      CONTINUE
      NUM=NUM+NCORR
C
630   IF (IUPDT.EQ.1) GO TO 640
C
      IF (NOPSN.EQ.0) GO TO 670
C
C  STORE SNOW INFORMATION INTO THE PARRY ARRAY
      CALL UMEMOV (OPTYSN,PARRY(NUM+1),2)
      CALL UMEMOV (OPNASN,PARRY(NUM+3),2)
      PARRY(NUM+5)=NCOSN+0.01
      NUM=NUM+5
      GO TO 650
C
640   IF (ISNDO.EQ.0) GO TO 670
C
C  SET INITIAL SNOW CARRYOVER VALUES TO MISSING
650   DO 660 I=1,NCOSN
         PARRY(NUM+I)=-999.
660      CONTINUE
      NUM=NUM+NCOSN
C
C  CHECK IF NEED TO WRITE FFG PARAMETER RECORD
670   IREC=0
      IF (IBUG.EQ.1) WRITE (IODBUG,*) 'IN PIN32 - FFGAID=',FFGAID,
     *   ' IUPDT=',IUPDT,
     *   ' IRRDO=',IRRDO,' ISNDO=',ISNDO,' MORCRV=',MORCRV
CCC      IF (INEWSEG.EQ.1.OR.
CCC     *    IUPDT.EQ.0.OR.
CCC     *    IRRDO.EQ.1.OR.
CCC     *    ISNDO.EQ.1.OR.
CCC     *    MORCRV.NE.0) THEN
         CALL WPPREC (FFGAID,FFGTYP,NFFG,PARRY,IREC,ISTAT)
         IF (ISTAT.NE.0) THEN
            CALL WRST32 (ISTAT,FFGTYP,FFGAID)
            GO TO 730
            ELSE
               IF (IUPDT.EQ.1) THEN
                  STRING='UPDATED'
                  ELSE
                     STRING='WRITTEN'
                  ENDIF
              WRITE (IPR,680) FFGTYP,STRING(1:LENSTR(STRING)),FFGAID
680   FORMAT ('0**NOTE** ',A,' PARAMETER RECORD ',A,' FOR ',
     *   'IDENTIFIER ',A,'.')
            ENDIF
CCC         ENDIF
      IF (IREC.GT.0) THEN
         PO(22)=IREC+0.01
         PO(23)=NFFG+0.01
         IWRPPP=1
         IF (IBUG.EQ.1) THEN
            WRITE (IODBUG,*) 'IN PIN32 - NFFG=',NFFG,' IREC=',IREC,
     *         ' IWRPPP=',IWRPPP
            WRITE (IODBUG,*) 'CONTENTS OF FFG ARRAY (PARRY):'
            WRITE (IODBUG,700) (PARRY(I),I=1,NFFG)
700   FORMAT (1X,10F10.3)
            ENDIF
         ENDIF
      GO TO 730
C
710   WRITE (IPR,720)
720   FORMAT ('0**ERROR** READ ERROR ENCOUNTERED READING INPUT CARD.')
      CALL ERROR
      INDERR=1
C
730   IF (INDERR.EQ.1) IUSEP=0
C
      RETURN
C
      END