C-----------------------------------------------------------------------
      SUBROUTINE GETGIR(LUGB,MSK1,MSK2,MNUM,MBUF,CBUF,NLEN,NNUM,IRET)
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM: GETGIR         READS A GRIB INDEX FILE
C   PRGMMR: IREDELL          ORG: W/NMC23     DATE: 95-10-31
C
C ABSTRACT: READ A GRIB FILE AND RETURN ITS INDEX CONTENTS.
C   THE INDEX BUFFER RETURNED CONTAINS INDEX RECORDS WITH THE INTERNAL FORMAT:
C       BYTE 001-004: BYTES TO SKIP IN DATA FILE BEFORE GRIB MESSAGE
C       BYTE 005-008: BYTES TO SKIP IN MESSAGE BEFORE PDS
C       BYTE 009-012: BYTES TO SKIP IN MESSAGE BEFORE GDS (0 IF NO GDS)
C       BYTE 013-016: BYTES TO SKIP IN MESSAGE BEFORE BMS (0 IF NO BMS)
C       BYTE 017-020: BYTES TO SKIP IN MESSAGE BEFORE BDS
C       BYTE 021-024: BYTES TOTAL IN THE MESSAGE
C       BYTE 025-025: GRIB VERSION NUMBER
C       BYTE 026-053: PRODUCT DEFINITION SECTION (PDS)
C       BYTE 054-095: GRID DEFINITION SECTION (GDS) (OR NULLS)
C       BYTE 096-101: FIRST PART OF THE BIT MAP SECTION (BMS) (OR NULLS)
C       BYTE 102-112: FIRST PART OF THE BINARY DATA SECTION (BDS)
C       BYTE 113-172: (OPTIONAL) BYTES 41-100 OF THE PDS
C       BYTE 173-184: (OPTIONAL) BYTES 29-40 OF THE PDS
C       BYTE 185-320: (OPTIONAL) BYTES 43-178 OF THE GDS
C
C PROGRAM HISTORY LOG:
C   95-10-31  IREDELL
C   96-10-31  IREDELL   AUGMENTED OPTIONAL DEFINITIONS TO BYTE 320
C
C USAGE:    CALL GETGIR(LUGB,MSK1,MSK2,MNUM,MBUF,CBUF,NLEN,NNUM,IRET)
C   INPUT ARGUMENTS:
C     LUGB         INTEGER UNIT OF THE UNBLOCKED GRIB FILE
C     MSK1         INTEGER NUMBER OF BYTES TO SEARCH FOR FIRST MESSAGE
C     MSK2         INTEGER NUMBER OF BYTES TO SEARCH FOR OTHER MESSAGES
C     MNUM         INTEGER NUMBER OF INDEX RECORDS TO SKIP (USUALLY 0)
C     MBUF         INTEGER LENGTH OF CBUF IN BYTES
C   OUTPUT ARGUMENTS:
C     CBUF         CHARACTER*1 (MBUF) BUFFER TO RECEIVE INDEX DATA
C     NLEN         INTEGER LENGTH OF EACH INDEX RECORD IN BYTES
C     NNUM         INTEGER NUMBER OF INDEX RECORDS
C                  (=0 IF NO GRIB MESSAGES ARE FOUND)
C     IRET         INTEGER RETURN CODE
C                    0      ALL OK
C                    1      CBUF TOO SMALL TO HOLD INDEX DATA
C
C SUBPROGRAMS CALLED:
C   SKGB           SEEK NEXT GRIB MESSAGE
C   IXGB           MAKE INDEX RECORD
C
C REMARKS: SUBPROGRAM CAN BE CALLED FROM A MULTIPROCESSING ENVIRONMENT.
C   DO NOT ENGAGE THE SAME LOGICAL UNIT FROM MORE THAN ONE PROCESSOR.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  CRAY, WORKSTATIONS
C
C$$$
      CHARACTER CBUF(MBUF)
      PARAMETER(MINDEX=320)
	if (mbuf.le.0) then
	    write(*,*) 'getirprogram error mbuf = ',mbuf
	    stop 8
	endif
C - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C  SEARCH FOR FIRST GRIB MESSAGE
      ISEEK=0
      CALL SKGB(LUGB,ISEEK,MSK1,LSKIP,LGRIB)
      IF(LGRIB.GT.0.AND.MINDEX.LE.MBUF) THEN
        CALL IXGB(LUGB,LSKIP,LGRIB,MINDEX,1,NLEN,CBUF)
      ELSE
        NLEN=MINDEX
      ENDIF
      DO M=1,MNUM
        IF(LGRIB.GT.0) THEN
          ISEEK=LSKIP+LGRIB
          CALL SKGB(LUGB,ISEEK,MSK2,LSKIP,LGRIB)
        ENDIF
      ENDDO
C - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C  MAKE AN INDEX RECORD FOR EVERY GRIB RECORD FOUND
      NNUM=0
      IRET=0
      DOWHILE(IRET.EQ.0.AND.LGRIB.GT.0)
        IF(NLEN*(NNUM+1).LE.MBUF) THEN
          NNUM=NNUM+1
          CALL IXGB(LUGB,LSKIP,LGRIB,NLEN,NNUM,MLEN,CBUF)
          ISEEK=LSKIP+LGRIB
          CALL SKGB(LUGB,ISEEK,MSK2,LSKIP,LGRIB)
        ELSE
          IRET=1
        ENDIF
      ENDDO
C - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      RETURN
      END
