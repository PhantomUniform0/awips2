      SUBROUTINE W3FI59_SUB(FIELD,NPTS,NBITS,NWORK,NPFLD,ISCALE,LEN,RMIN)
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    W3FI59      FORM AND PACK POSITIVE, SCALED DIFFERENCES
C   PRGMMR:  ALLARD, R.      ORG: NMC41      DATE:  84-08-01
C
C ABSTRACT:  CONVERTS AN ARRAY OF SINGLE PRECISION REAL NUMBERS INTO
C   AN ARRAY OF POSITIVE SCALED DIFFERENCES (NUMBER(S) - MINIMUM VALUE),
C   IN INTEGER FORMAT AND PACKS THE ARGUMENT-SPECIFIED NUMBER OF
C   SIGNIFICANT BITS FROM EACH DIFFERENCE.
C
C PROGRAM HISTORY LOG:
C   84-08-01  ALLARD      ORIGINAL AUTHOR
C   90-05-17  R.E.JONES   CONVERT TO CRAY CFT77 FORTRAN
C   90-05-18  R.E.JONES   CHANGE NAME PAKMAG TO W3LIB NAME W3FI59
C   93-07-06  R.E.JONES   ADD NINT TO DO LOOP 2000 SO NUMBERS ARE
C                         ROUNDED TO NEAREST INTEGER, NOT TRUNCATED.
C   94-01-05  IREDELL     COMPUTATION OF ISCALE FIXED WITH RESPECT TO
C                         THE 93-07-06 CHANGE.
C   98-06-30  EBISUZAKI   LINUX PORT
C
C USAGE:    CALL W3FI59(FIELD,NPTS,NBITS,NWORK,NPFLD,ISCALE,LEN,RMIN)
C   INPUT ARGUMENT LIST:
C     FIELD - ARRAY OF FLOATING POINT DATA FOR PROCESSING  (REAL)
C     NPTS  - NUMBER OF DATA VALUES TO PROCESS IN FIELD (AND NWORK)
C             WHERE, NPTS > 0
C     NBITS - NUMBER OF SIGNIFICANT BITS OF PROCESSED DATA TO BE PACKED
C             WHERE, 0 < NBITS < 32+1
C
C   OUTPUT ARGUMENT LIST:
C     NWORK - ARRAY FOR INTEGER CONVERSION  (INTEGER)
C             IF PACKING PERFORMED (SEE NOTE BELOW), THE ARRAY WILL
C             CONTAIN THE PRE-PACKED, RIGHT ADJUSTED, SCALED, INTEGER
C             DIFFERENCES UPON RETURN TO THE USER.
C             (THE USER MAY EQUIVALENCE FIELD AND NWORK.  SAME SIZE.)
C     NPFLD - ARRAY FOR PACKED DATA  (character*1)
C             (DIMENSION MUST BE AT LEAST (NBITS * NPTS) / 64 + 1  )
C     ISCALE- POWER OF 2 FOR RESTORING DATA, SUCH THAT
C             DATUM = (DIFFERENCE * 2**ISCALE) + RMIN
C     LEN   - NUMBER OF PACKED BYTES IN NPFLD (SET TO 0 IF NO PACKING)
C             WHERE, LEN = (NBITS * NPTS + 7) / 8 WITHOUT REMAINDER
C     RMIN  - MINIMUM VALUE (REFERENCE VALUE SUBTRACTED FROM INPUT DATA)
C             THIS IS A CRAY FLOATING POINT NUMBER, IT WILL HAVE TO BE
C             CONVERTED TO AN IBM370 32 BIT FLOATING POINT NUMBER AT
C             SOME POINT IN YOUR PROGRAM IF YOU ARE PACKING GRIB DATA.
C
C REMARKS:  LEN = 0 AND NO PACKING PERFORMED IF
C
C        (1)  RMAX = RMIN  (A CONSTANT FIELD)
C        (2)  NBITS VALUE OUT OF RANGE  (SEE INPUT ARGUMENT)
C        (3)  NPTS VALUE LESS THAN 1  (SEE INPUT ARGUMENT)
C
C ATTRIBUTES:
C   LANGUAGE: CRAY CFT77 FORTRAN
C   MACHINE:  CRAY C916/256, Y-MP8/864, Y-MP EL92/256, J916/2048
C
C$$$
C  NATURAL LOGARITHM OF 2 AND 0.5 PLUS NOMINAL SAFE EPSILON
      PARAMETER(ALOG2=0.69314718056,HPEPS=0.500001)
C
      REAL    FIELD(*)
C
      CHARACTER*1 NPFLD(*)
      INTEGER NWORK(*)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob81/ohd/pproc/src/gribit_sub/RCS/w3fi59.f,v $
     . $',                                                             '
     .$Id: w3fi59.f,v 1.1 2006/10/19 16:06:04 dsa Exp $
     . $' /
C    ===================================================================
C
C
      DATA KZERO / 0 /
C
C / / / / / /
C
      LEN    = 0
      ISCALE = 0
      IF (NBITS.LE.0.OR.NBITS.GT.32) GO TO 3000
      IF (NPTS.LE.0) GO TO 3000
C
C FIND THE MAX-MIN VALUES IN FIELD.
C
      RMAX = FIELD(1)
      RMIN = RMAX
      DO 1000 K = 2,NPTS
        RMAX = AMAX1(RMAX,FIELD(K))
        RMIN = AMIN1(RMIN,FIELD(K))
 1000 CONTINUE
C
C IF A CONSTANT FIELD, RETURN WITH NO PACKING PERFORMED AND 'LEN' = 0.
C
      IF (RMAX.EQ.RMIN) GO TO 3000
C
C DETERMINE LARGEST DIFFERENCE IN FIELD (BIGDIF).
C
      BIGDIF = RMAX - RMIN
C
C ISCALE IS THE POWER OF 2 REQUIRED TO RESTORE THE PACKED DATA.
C ISCALE IS COMPUTED AS THE LEAST INTEGER SUCH THAT
C   BIGDIF*2**(-ISCALE) < 2**NBITS-0.5
C IN ORDER TO ENSURE THAT THE PACKED INTEGERS (COMPUTED IN LOOP 2000
C WITH THE NEAREST INTEGER FUNCTION) STAY LESS THAN 2**NBITS.
C
      ISCALE=NINT(ALOG(BIGDIF/(2.**NBITS-0.5))/ALOG2+HPEPS)
C
C FORM DIFFERENCES, RESCALE, AND CONVERT TO INTEGER FORMAT.
C
      TWON = 2.0 ** (-ISCALE)
      DO 2000 K = 1,NPTS
        NWORK(K) = NINT( (FIELD(K) - RMIN) * TWON )
 2000 CONTINUE
C
C PACK THE MAGNITUDES (RIGHTMOST NBITS OF EACH WORD).
C
      KOFF  = 0
      ISKIP = 0
C
C     USE NCAR ARRAY BIT PACKER SBYTES  (GBYTES PACKAGE)
C
      CALL SBYTESC(NPFLD,NWORK,KOFF,NBITS,ISKIP,NPTS)
C
C ADD 7 ZERO-BITS AT END OF PACKED DATA TO INSURE BYTE BOUNDARY.
C     USE NCAR WORD BIT PACKER SBYTE
C
      NOFF = NBITS * NPTS
      CALL SBYTEC(NPFLD,KZERO,NOFF,7)
C
C DETERMINE BYTE LENGTH (LEN) OF PACKED FIELD (NPFLD).
C
      LEN = (NOFF + 7) / 8
C
 3000 CONTINUE
      RETURN
C
      END
