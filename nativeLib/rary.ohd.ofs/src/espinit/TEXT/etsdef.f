C$PRAGMA C (GET_APPS_DEFAULTS)
C MODULE ETSDEF
C-----------------------------------------------------------------------
C
      SUBROUTINE ETSDEF (TTS,MTTS,TS,MTS,NWORK,
     *  IREADC,TSID,DTYPE,UNITS,IDT,TSTYPE,EFILETP,ETSTYPEN,LOC,
     *  IER)
C
C  THIS SUBROUTINE READS TS DEFINITION INFO AND CREATES TEMPORARY TS
C
C  THIS SUBROUTINE WAS WRITTEN BY GERALD N DAY.
C
C  MODIFIED TO RUN ON UNIX SYSTEM BY EDWIN WELLES - 1/1995
C
      DIMENSION TTS(MTTS),TS(MTS)
      DIMENSION FNAME(3),STAID(3),DESCRP(5)
      DIMENSION EXTLOC(50)
C
      CHARACTER*4 DTYPE,EDTYPE,DTYPEN
      CHARACTER*4 EFILETP,EFILETPN
      CHARACTER*4 UNITS
      CHARACTER*8 TSID,ETSID,TSIDN
      CHARACTER*8 TSTYPE,ETSTYPEN,TSTYPEN
      CHARACTER*8 OLDOPN,GENTYP,SEGID
      CHARACTER*12 ESEGID
      CHARACTER*32 TSNAME
      CHARACTER*80 CARD
      CHARACTER*80 DIRNAM
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/where'
      INCLUDE 'common/fcsegn'
      INCLUDE 'clbcommon/crwctl'
      INCLUDE 'clbcommon/bhtime'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/espinit/RCS/etsdef.f,v $
     . $',                                                             '
     .$Id: etsdef.f,v 1.7 2002/02/11 19:54:49 dws Exp $
     . $' /
C    ===================================================================
C
      DATA FDIM/4hL3/T/
      DATA VDIM/4hL3  /
      DATA RINST/4hINST/
      DATA ACCM/4hACCM/
C
C
      IOPNUM=0
      CALL FSTWHR ('ETSDEF  ',IOPNUM,OLDOPN,IOLDOP)
C
      IF (ITRACE.GE.1) WRITE (IODBUG,*) 'ETSDEF ENTERED'
C
      IBUG=IFBUG('EARY')
C
      IF (IBUG.EQ.1) THEN
         WRITE (IODBUG,*) 'TSID=',TSID,
     *      ' DTYPE=',DTYPE,' UNITS=',UNITS,
     *      ' TSTYPE=',TSTYPE,' EFILETP=',EFILETP,' ETSTYPEN=',ETSTYPEN,
     *      ' LOC=',LOC
         ENDIF
C
      IER=0
      IREPL=0
      IUPD=0
C
      IF (IREADC.EQ.1) THEN
         LOC=0
         ENDIF
C
      TSTYPEN=TSTYPE
      IF (ETSTYPEN.NE.' ') THEN
         TSTYPEN=ETSTYPEN
         IF (IBUG.EQ.1) THEN
            WRITE (IODBUG,*) 'TSTYPEN=',TSTYPEN
            ENDIF
         ENDIF
C
10    IF (LOC.GT.MTTS) THEN
         WRITE (IPR,20)
20    FORMAT ('0**ERROR** NOT ENOUGH SPACE IN THE TTS ARRAY.')
         CALL ERROR
         GO TO 700
         ENDIF
C
C  SET TS TYPE = 0
      TTS(LOC+1)=0.01
C
      IF (IREADC.EQ.1) THEN
         READ (IN,'(A)') CARD
         READ (CARD,30,ERR=31) TSID,DTYPE,IDT,TSTYPEN,EFILETP
30    FORMAT (A,3X,A,3X,I2,12X,A,6X,A)
         GO TO 33
31       CALL FRDERR (IPR,'GENERAL TIME SERIES',CARD)
33       ENDIF
C
      IF (TSID.EQ.'END') GO TO 710
C
      IF (TSTYPEN.EQ.' ') THEN
C     DEFAULT IS INTERNAL TIME SERIES
         ITSTYP=4
         GO TO 50
         ENDIF
      ITSTYP=0
      IF (TSTYPEN.EQ.'INPUT') ITSTYP=1
      IF (TSTYPEN.EQ.'UPDATE') ITSTYP=2
      IF (TSTYPEN.EQ.'OUTPUT') ITSTYP=3
      IF (TSTYPEN.EQ.'INTERNAL') ITSTYP=4
      IF (ITSTYP.EQ.0) THEN
         WRITE (IPR,40) TSTYPEN,TSID
40    FORMAT ('0**ERROR** TIME SERIES TYPE CODE ',A,'IS INVALID. ',
     * 'ONLY INPUT, OUTPUT, UPDATE AND INTERNAL ARE ALLOWED. ',
     * 'TSID=',A)
         CALL ERROR
         IER=1
         GO TO 700
         ENDIF
C
C  CHECK DATA TYPE
50    CALL FDCODE (DTYPE,UNITS,DIM,MSG,NPDT,TSCALE,NADD,IERR)
      IF (IERR.EQ.0) GO TO 70
         WRITE (IPR,60) DTYPE,TSID
60    FORMAT ('0**ERROR** ',A,' IS AN INVALID DATA TYPE. TSID = ',A)
         CALL ERROR
         IER=1
         GO TO 700
C
C  CHECK TIME INTERVAL
70    IF (IDT.LE.0.OR.IDT.GT.24) GO TO 80
      IF (IDT*(24/IDT).EQ.24) GO TO 100
80       WRITE (IPR,90) IDT,TSID
90    FORMAT ('0**ERROR** ',I3,' IS AN INVALID TIME INTERVAL. TSID=',A)
         CALL ERROR
         IER=1
         GO TO 700
C
C  CHECK TSID NOT BLANK
100   IF (TSID.EQ.' ') THEN
         WRITE (IPR,110)
110   FORMAT ('0**ERROR** TIME SERIES IDENTIFIER IS BLANK.')
         CALL ERROR
         IER=1
         GO TO 700
         ENDIF
C
      IF (IREPL.EQ.1) GO TO 130
C
C  START FILLING THE TTS ARRAY
      NEED=LOC+11
      IF (ITSTYP.EQ.4) NEED=LOC+9
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+1)=ITSTYP+.01
      CALL UMEMOV (TSID,TTS(LOC+3),2)
      CALL UMEMOV (DTYPE,TTS(LOC+5),1)
      TTS(LOC+6)=IDT+.01
      TTS(LOC+7)=NPDT+.01
      TTS(LOC+8)=.01
      IF (ITSTYP.EQ.4) GO TO 690
      CALL UMEMOV (EFILETP,TTS(LOC+10),1)
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
      IF (ITSTYP.NE.1) GO TO 520
C
C  INPUT TIME SERIES
C
      TTS(LOC+9)=1.01
      TTS(LOC+11)=0.01
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
130   IF (EFILETP.NE.'CALB') GO TO 180
C
C  INPUT FILE TYPE CALB
C
      KMO1=0
      KYR1=0
      KMO2=0
      KYR2=0
      CALL CZRORD
      CALL LOCATE(KMO1,KYR1,KMO2,KYR2,UNITS,FNAME,DTYPEI,IDTI,
     *   STAID,DESCRP,NXTRD,LPTR)
      IF (IERR.EQ.0) GO TO 150
         IER=1
         IERR=0
         WRITE (IPR,140)
140   FORMAT ('0**ERROR** UNABLE TO LOCATE TIME SERIES.')
         CALL ERROR
         GO TO 700
150   NEED=LOC+29
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+2)=LOC+30.01
      TTS(LOC+12)=16.01
      DO 170 I=1,3
         TTS(LOC+12+I)=FNAME(I)
         TTS(LOC+18+I)=STAID(I)
170      CONTINUE
      TTS(LOC+16)=DTYPEI
      TTS(LOC+17)=IDTI+.01
C  THE VALUES FOR POSITIONS 18-26 COME FROM COMMON BLOCK BHTIME
      TTS(LOC+18)=LHEAD+.01
      TTS(LOC+22)=KMO+.01
      TTS(LOC+23)=KDA+.01
      TTS(LOC+24)=KYR+.01
      TTS(LOC+25)=KHRMIN+.01
      TTS(LOC+26)=KSEC+.01
      TTS(LOC+27)=.01
      TTS(LOC+28)=.01
      IF (IREPL.EQ.1) GO TO 480
      IF (IUPD.EQ.1) GO TO 530
      TTS(LOC+29)=.01
      LOC=LOC+29
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
180   IF (EFILETP.NE.'ESP') GO TO 240
C
C  INPUT FILE TYPE ESP
C
      READ (IN,'(A)') CARD
      READ (CARD,190,ERR=191) ESEGID,ETSID,EDTYPE,IDTE,IDEL
190   FORMAT (A,3X,A,2X,A,1X,I5,I5)
      GO TO 193
191   CALL FRDERR (IPR,'INPUT FILE TYPE ESP',CARD)
193   NEED=LOC+29
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+2)=LOC+30.01
      TTS(LOC+12)=16.01
      CALL UMEMOV (ETSID,TTS(LOC+13),2)
      CALL UMEMOV (EDTYPE,TTS(LOC+15),1)
      TTS(LOC+16)=IDTE+.01
      CALL FDCODE (EDTYPE,UNITSF,DIMF,MSGF,NPDTF,TSCALE,NADDF,IERR)
      IF (IERR.EQ.0.AND.NPDTF.EQ.NPDT) GO TO 210
         WRITE (IPR,60) EDTYPE,ETSID
         CALL ERROR
         IER=1
         GO TO 700
210   IF (IDTE.NE.IDT) THEN
         WRITE (IPR,90) IDTE,ETSID
         CALL ERROR
         IER=1
         GO TO 700
         ENDIF
      CALL UMEMOV (ESEGID,TTS(LOC+17),3)
      TTS(LOC+20)=IDEL+.01
      TTS(LOC+21)=.01
      TTS(LOC+22)=.01
      TTS(LOC+23)=.01
      TTS(LOC+24)=.01
      TTS(LOC+25)=.01
      TTS(LOC+26)=.01
      TTS(LOC+27)=.01
      TTS(LOC+28)=.01
      IF (IREPL.EQ.1) GO TO 480
      IF (IUPD.EQ.1) GO TO 530
      TTS(LOC+29)=.01
      LOC=LOC+29
      CALL TSPRT_ESP_INPUT (EFILETP,ESEGID,ETSID,EDTYPE,IDTE,IDEL)
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
240   IF (EFILETP.NE.'MSNG') GO TO 280
C
C  INPUT FILE TYPE MSNG
C
      IF (MSG.EQ.1) GO TO 260
         WRITE (IPR,250) DTYPE
250   FORMAT ('0**ERROR** MISSING DATA IS NOT ALLOWED FOR DATA TYPE ',
     * A,'.')
         CALL ERROR
         IER=1
         GO TO 700
260   NEED=LOC+13
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+2)=LOC+14+.01
      TTS(LOC+12)=.01
C
      IF (IREPL.EQ.1) GO TO 480
      IF (IUPD.EQ.1) GO TO 530
      TTS(LOC+13)=.01
      LOC=LOC+13
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
280   IF (EFILETP.NE.'GENR') GO TO 340
C
C  INPUT FILE TYPE GENR
C
      READ (IN,290) GENTYP
290   FORMAT (A)
      ILOC=LOC+13
      IF (GENTYP.EQ.'CREAT-PE') THEN
         CALL EGIN01 (TTS,MTTS,ILOC,NUSE,GENTYP,IERR)
         CALL TSPRT_CREAT_PE (EFILETP,GENTYP,TTS(ILOC+2))
         GO TO 310
         ENDIF
      IF (GENTYP.EQ.'BLEND-TS') THEN
         CALL EGIN02 (TTS,MTTS,ILOC,NUSE,GENTYP,TS,MTS,NWORK,IERR)
         CALL TSPRT_BLEND_TS (EFILETP,GENTYP,TTS(ILOC+2))
         GO TO 310
         ENDIF
      WRITE (IPR,300) GENTYP
300   FORMAT ('0**ERROR** ',A,' IS AN INVALID GENERATE SUBCOMMAND.')
      CALL ERROR
      IER=1
      GO TO 700
310   IF (IERR.EQ.0) GO TO 320
      IER=1
      GO TO 700
C
320   NEED=LOC+13+NUSE
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+2)=LOC+14.01+NUSE
      TTS(LOC+12)=NUSE+.01
      IF (IREPL.EQ.1) GO TO 480
      IF (IUPD.EQ.1) GO TO 530
      TTS(LOC+13+NUSE)=.01
      LOC=LOC+13+NUSE
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
340   IF (EFILETP.NE.'CARD') GO TO 400
C
C  INPUT FILE TYPE CARD
C
      ITSTYPO=ITSTYP
      IF (IUPD.EQ.0) GO TO 350
      ITSTYP=1
C
350   CALL CARDIO (ITSTYP,NUMEXT,EXTLOC,DTYPE,UNITS,DIM,IDT,NPDT,TSNAME,
     *   IERR)
      ITSTYP=ITSTYPO
      IF (IERR.EQ.0) GO TO 370
         IER=1
         IERR=0
         WRITE (IPR,360) TSNAME(1:LENSTR(TSNAME))
360   FORMAT ('0**ERROR** CANNOT FIND FILE ',A,'.')
         CALL ERROR
         GO TO 700
370   NEED=NUMEXT+LOC+13
      IF (NEED.GT.MTTS) THEN
          WRITE (IPR,20)
          CALL ERROR
          GO TO 700
          ENDIF
      TTS(LOC+2)=NEED+1.01
      TTS(LOC+12)=NUMEXT+0.01
      DO 390 I=1,NUMEXT
         J=LOC+12+I
         TTS(J)=EXTLOC(I)
390      CONTINUE
C  CLOSE THE CARD FILE
      IUNIT=TTS(LOC+12+1)
      CALL CLFILE ('DATACARD',IUNIT,IERR)
C  SET THE UNIT NUMBER POSITION TO -99 FOR USE IN ROUTINE ECARDF
      TTS(LOC+12+1)=-99
      IF (IREPL.EQ.1) GO TO 480
      IF (IUPD.EQ.1) GO TO 530
C  IADD=LOCATION OF NUMBER OF PIECES OF ADDITIONAL INFORMATION
      IADD=LOC+13+NUMEXT
      NADD=0
      TTS(IADD)=NADD+0.01
      LOC=LOC+NUMEXT+13
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
400   IF (EFILETP.NE.'REPL') GO TO 500
C
C  INPUT FILE TYPE REPL
C
      IF (IREPL.EQ.1.OR.IUPD.EQ.1) GO TO 500
C
      IF (DIM.EQ.FDIM.AND.TSCALE.EQ.RINST.AND.IDT.LE.12) GO TO 420
         WRITE (IPR,410) EFILETP,TSID,DTYPE,IDT
410   FORMAT ('0**ERROR** INVALID TIME SERIES FOR ',A,' PROCEDURE : ',
     * A,2X,A,2X,I2)
         CALL ERROR
         IER=1
         GO TO 700
420   IF (MSG.EQ.1) GO TO 440
         WRITE (IPR,430) DTYPE
430   FORMAT ('0**ERROR** MISSING DATA NOT ALLOWED FOR DATA TYPE ',A,
     * '.')
         CALL ERROR
         IER=1
         GO TO 700
440   READ (IN,'(A)') CARD
      READ (CARD,450,ERR=451) TSIDN,DTYPEN,IDTN,EFILETPN
450   FORMAT (A,3X,A,3X,I2,26X,A)
      GO TO 453
451   CALL FRDERR (IPR,'INPUT FILE TYPE REPL',CARD)
453   CALL FDCODE (DTYPEN,UNITS,DIM,MSG,NPDT,TSCALE,NADD,IERR)
      IF (IERR.EQ.0) GO TO 460
         WRITE (IPR,60) DTYPEN,TSIDN
         CALL ERROR
         IER=1
         GO TO 700
460   IF (DIM.EQ.VDIM.AND.TSCALE.EQ.ACCM.AND.IDTN.EQ.24) GO TO 470
         WRITE (IPR,410) EFILETP,TSIDN,DTYPEN,IDTN
         CALL ERROR
         IER=1
         GO TO 700
470   IREPL=1
      EFILETP=EFILETPN
      TSID=TSIDN
      DTYPE=DTYPEN
      IDT=IDTN
      GO TO 70
C
480   IREPL=0
      NUMEXT=TTS(LOC+12)
      NUMESP=5
      NEED=LOC+13+NUMEXT+NUMESP
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+13+NUMEXT)=NUMESP+.01
      CALL UMEMOV (EFILETP,TTS(LOC+14+NUMEXT),1)
      CALL UMEMOV (TSID,TTS(LOC+15+NUMEXT),2)
      CALL UMEMOV (DTYPE,TTS(LOC+17+NUMEXT),1)
      TTS(LOC+18+NUMEXT)=IDT+.01
      TTS(LOC+2)=LOC+14+NUMEXT+NUMESP+.01
      LOC=LOC+13+NUMEXT+NUMESP
      CALL TSPRT_REPL_INPUT (EFILETP,TSIDN,DTYPEN,IDTN,EFILETPN)
      GO TO 700
C
500   WRITE (IPR,510) EFILETP,TSID,DTYPE,IDT
510   FORMAT ('0**ERROR** ESP FILE TYPE (',A,') FOR IDENTIFIER ',A,
     *   ' DATA TYPE ',A,' AND DATA TIME INTERVAL ',I2,' IS INVALID.')
      CALL ERROR
      IER=1
      GO TO 700
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
520   IF (ITSTYP.NE.2) GO TO 610
C
C  UPDATE TIME SERIES
C
      TTS(LOC+9)=1.01
      TTS(LOC+11)=0.01
      IUPD=1
      GO TO 130
530   IUPD=0
      READ (IN,540) EFILETPN
540   FORMAT (A)
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
      IF (EFILETPN.NE.'ESP') GO TO 570
C
C  UPDATE FILE TYPE ESP
C
      READ (IN,'(A)') ESEGID
      NUMEXT=TTS(LOC+12)
      NVO=16
      NUMESP=NVO+2
      NEED=LOC+31+NUMEXT
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+13+NUMEXT)=NUMESP+.01
      CALL UMEMOV (EFILETPN,TTS(LOC+14+NUMEXT),1)
      TTS(LOC+15+NUMEXT)=NVO+.01
      CALL UMEMOV (TSID,TTS(LOC+NUMEXT+16),2)
      CALL UMEMOV (DTYPE,TTS(LOC+NUMEXT+18),1)
      TTS(LOC+NUMEXT+19)=IDT+.01
      CALL UMEMOV (ESEGID,TTS(LOC+NUMEXT+20),3)
      TTS(LOC+NUMEXT+23)=.01
      TTS(LOC+NUMEXT+24)=.01
      TTS(LOC+NUMEXT+25)=.01
      TTS(LOC+NUMEXT+26)=.01
      TTS(LOC+NUMEXT+27)=.01
      TTS(LOC+NUMEXT+28)=.01
      TTS(LOC+NUMEXT+29)=.01
      TTS(LOC+NUMEXT+30)=.01
      TTS(LOC+NUMEXT+31)=.01
      TTS(LOC+2)= LOC+32+NUMEXT+.01
      LOC=LOC+31+NUMEXT
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
570   IF (EFILETPN.NE.'NONE') GO TO 590
C
C  UPDATE FILE TYPE NONE
C
      NUMEXT=TTS(LOC+12)
      NEED=LOC+13+NUMEXT
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+1)=1.01
      TTS(LOC+2)=LOC+NUMEXT+14.01
      TTS(LOC+NUMEXT+13)=.01
      LOC=LOC+13+NUMEXT
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
590   IF (EFILETPN.NE.'CARD') GO TO 500
C
C  UPDATE FILE TYPE CARD
C
      NUMEXT=TTS(LOC+12)
      NVO=0
      NUMESP=NVO+2
      NEED=LOC+15+NUMEXT
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
C  UPDATE FILE TYPES SHOULD JUST OVERWRITE THE EXISTING FILE
      TTS(LOC+13+NUMEXT)=NUMESP+.01
      CALL UMEMOV (EFILETPN,TTS(LOC+14+NUMEXT),1)
      TTS(LOC+15+NUMEXT)=NVO+.01
      TTS(LOC+2)=LOC+NUMEXT+16.01
      LOC=LOC+15+NUMEXT
      GO TO 700
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
610   IF (ITSTYP.NE.3) GO TO 690
C
C  OUTPUT TIME SERIES
C
      TTS(LOC+9)=0.01
      TTS(LOC+11)=0.01
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
      IF (EFILETP.NE.'ESP') GO TO 650
C
C  OUTPUT FILE TYPE ESP
C
      READ (IN,'(A)') CARD
      READ (CARD,620,ERR=621) ESEGID,ISCRT
620   FORMAT (A,2X,I5)
      GO TO 623
621   CALL FRDERR (IPR,'OUTPUT FILE TYPE ESP',CARD)
623   CALL UMEMOV (ISEG,SEGID,2)
      IF (ESEGID(1:8).EQ.SEGID.AND.ESEGID(9:12).EQ.' ') THEN
         ELSE
            WRITE (IPR,625) ESEGID,SEGID
625   FORMAT ('0**WARNING** ESP SEGMENT IDENTIFIER (',A,
     *   ') IS NOT THE SAME AS THE SEGMENT IDENTIFIER (',A,
     *   ').' /
     * 13X,'THE ESP SEGMENT IDENTIFIER MUST BE SAME AS THE ',
     *   'SEGMENT IDENTIFIER FOR PROGRAM ESPADP TO FIND THE FILES.')
            CALL WARN
         ENDIF
      NUMEXT=16
      NEED=LOC+29
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      TTS(LOC+12)=NUMEXT+.01
      CALL UMEMOV (TSID,TTS(LOC+13),2)
      CALL UMEMOV (DTYPE,TTS(LOC+15),2)
      TTS(LOC+16)=IDT+.01
      CALL UMEMOV (ESEGID,TTS(LOC+17),3)
      TTS(LOC+20)=ISCRT+.01
      TTS(LOC+21)=.01
      TTS(LOC+22)=.01
      TTS(LOC+23)=.01
      TTS(LOC+24)=.01
      TTS(LOC+25)=.01
      TTS(LOC+26)=.01
      TTS(LOC+27)=.01
      TTS(LOC+28)=.01
      TTS(LOC+2)=LOC+30.01
      TTS(LOC+29)=.01
      LOC=LOC+29
      CALL TSPRT_ESP_OUTPUT (EFILETP,ESEGID,ISCRT)
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
650   IF (EFILETP.NE.'CARD') GO TO 680
C
C  OUTPUT FILE TYPE CARD
C
      DIRNAM=' '
      TSNAME=' '
      READ (IN,*) TSNAME
      NUMEXT=37
      NEED=LOC+13+NUMEXT
      IF (NEED.GT.MTTS) THEN
         WRITE (IPR,20)
         CALL ERROR
         GO TO 700
         ENDIF
      CALL GET_APPS_DEFAULTS ('calb_area_ts_dir',16,DIRNAM,LDIRNAM)
      TTS(LOC+12)=NUMEXT+.01
      TTS(LOC+13)=0.01
      TTS(LOC+14)=0.01
      TTS(LOC+15)=0.01
      TTS(LOC+16)=0.01
      TTS(LOC+17)=0.01
      TTS(LOC+18)=0.01
      TTS(LOC+19)=0.01
      TTS(LOC+20)=LDIRNAM
      READ (DIRNAM,660) (TTS(I),I=LOC+21,LOC+40)
660   FORMAT (20A4)
      READ (TSNAME,670) (TTS(I),I=LOC+41,LOC+48)
670   FORMAT (8A4)
      TTS(LOC+49)=.01
      TTS(LOC+2)=LOC+14.01+NUMEXT
      LOC=LOC+13+NUMEXT
      GO TO 700
C
C    -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
C
680   IF (EFILETP.NE.'NONE') GO TO 500
C
C  OUTPUT FILE TYPE NONE - TREAT AS INTERNAL
C
      TTS(LOC+1)=4.01
      TTS(LOC+2)=LOC+10.01
      LOC=LOC+9
      GO TO 700
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
C  INTERNAL TIME SERIES
C
690   TTS(LOC+9)=0.01
      TTS(LOC+2)=LOC+10.01
      LOC=LOC+9
      GO TO 700
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
700   IF (IREADC.EQ.1) GO TO 10
C
710   IF (IBUG.GT.0) THEN
         WRITE ( IODBUG,720)
720   FORMAT (' TTS ARRAY:')
         WRITE (IODBUG,730) (TTS(I),I=1,MTTS)
730   FORMAT (1X,10F10.0)
         ENDIF
C
      CALL FSTWHR (OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      RETURN
C
      END