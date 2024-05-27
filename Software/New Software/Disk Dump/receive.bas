REM Receive dumps from Centurion over a serial port

DEFINT A-Z

DECLARE SUB InitCRC ()
DECLARE FUNCTION AddCRC% (crc%, value%)

DIM SHARED CCITT_BE(255) AS INTEGER
DIM SHARED sector_dump_len AS INTEGER
DIM SHARED fileWritten AS LONG
DIM SHARED sectorCount AS INTEGER
DIM SHARED resendCount AS INTEGER

CONST MIN_MARKER = 10

port$ = "4"
baud$ = "19200"

fileName$ = "dumpfile.dat" ' Default file name
dumpType$ = "auto"

' Initialize CRC table
CALL InitCRC

' Set baud rate and other serial port settings here
' Open serial port
OPEN "COM" + port$ + ":" + baud$ + ",N,8,1,BIN,CS0,DS0" FOR RANDOM AS #1 LEN = 1 '420

' Send the initial ACK to wake things up...
DIM ack AS STRING * 1: ack = CHR$(&HFF)
PUT #1, , ack

' Open file for writing
OPEN fileName$ FOR BINARY AS #2

'DIM sector AS STRING * 420
buffer$ = ""

fileWritten = 0
sectorCount = 0
resendCount = 0

DIM byte AS STRING * 1

DO WHILE NOT EOF(1)

  ' Read sector data from serial port
  DO UNTIL LOC(1) = 0
    GET #1, , byte: buffer$ = buffer$ + byte
  LOOP

  ' Validate and process sector
  IF LEN(buffer$) >= MIN_MARKER THEN
    IF dumpType$ = "auto" THEN
      dumpType$ = DetectDumpType(buffer$)
      PRINT "Dump type is: "; dumpType$
    END IF
    IF ValidateSector(buffer$, dumpType$) THEN
      sectorCount = sectorCount + 1
      PUT #2, , buffer$
      fileWritten = fileWritten + 420
    ELSE
      resendCount = resendCount + 1
    END IF
    buffer$ = ""
  END IF

LOOP

CLOSE #2
CLOSE #1

PRINT "Received: "; sectorCount; " sectors"
PRINT "Retransmits: "; resendCount
PRINT "Wrote: "; fileWritten; " bytes"

SUB InitCRC
  poly = &H1021
  FOR i = 0 TO 255
    v = i * 256
    FOR x = 0 TO 7
      IF v AND &H8000 THEN
        v = (v * 2) XOR poly
      ELSE
        v = v * 2
      END IF
    NEXT
    CCITT_BE(i) = v AND &HFFFF
  NEXT
END SUB

FUNCTION AddCRC (crc, value)
  AddCRC = ((crc * 256) XOR CCITT_BE(((crc \ 256) XOR value) AND &HFF)) AND &HFFFF
END FUNCTION

FUNCTION DetectDumpType$ (sector$)
  DetectDumpType$ = "unknown"
  IF LEFT$(sector$, 8) = "HawkDump" THEN DetectDumpType$ = "hawk"
  IF LEFT$(sector$, 9) = "FinchDump" THEN DetectDumpType$ = "finch"
END FUNCTION

FUNCTION ValidateSector (sector$, dumpType$)
  ' Dummy validation logic for simplicity
  IF RIGHT$(sector$, 2) = CHR$(13) + CHR$(10) THEN ValidateSector = -1 ELSE ValidateSector = 0
END FUNCTION

