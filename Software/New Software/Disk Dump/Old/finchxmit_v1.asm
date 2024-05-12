********************************************************************************
*                                  FINCH XMIT                                  *
********************************************************************************
*
* The assembly in this Finch Transmit program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, Gecho and Meisaka provided a 
* a massive amount of help with figuring out assembly, DMA and other drive
* shenanigans.
* Thank you all so much for walking me through this!
*
          TITLE     'FIDUMP'
ZFIDUMP   BEGIN     X'0100'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address
MUX3CTRL  EQU       X'F206'        ; Fourth MUX port data MMIO address
MUX3DATA  EQU       X'F207'        ; Fourth MUX port control MMIO address
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1
MUX3CB    EQU       X'F6'          ; Third MUX port at 19,200 8N1
*
********************************************************************************
*                                 MAIN LOOP                                    *
********************************************************************************
ENTRY     XFR=      X'F000',S      ; Set the stack pointer to just below MMIO
* Initialize MUX ports
          LDAB=     MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX0
          LDAB=     MUX3CB         ; Load Mux 3 Control Byte into A
          STAB/     MUX3CTRL       ; Store A into MUX3CTRL, MMIO port for MUX3
* Print Welcome Screen
* 8D = CR, 8A = LF, 8C = Clear?
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'FINCH SERIAL TRANSMIT PROGRAM'
          DW        X'8D8A'
          DC        'PC SIDE RECEIVE PROGRAM MUST BE RUNNING!'
          DW        X'8D8A'
          DC        'PRESS CONTROL + C TO QUIT DURING DATA DUMP'
          DW        X'8D8A'
          DC        'PRESS SELECT ON FRONT PANEL TO RETURN TO LOADER'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'CAUTION! THIS PROGRAM HAS NO ERROR HANDLING'
          DW        X'8D8A'
          DC        'INPUT SANE VALUES ARE YOU WILL GET GARBAGE OUT'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'ENTER NUMBER LOGICAL DISKS (1 ~ 4): '
          DB        0              ; Null terminator
* Start Doing Productive Stuff
          JSR/      PICKDR         ; Pick max number of disks
TOP       JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'THE FINCH HAS X025D TOTAL TRACKS'
          DW        X'8D8A'
          DC        'ENTER START TRACK IN HEX: '
          DB        0
          JSR/      PICKST         ; Pick the starting track
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'ENTER ENDING TRACK IN HEX: '
          DB        0
          JSR/      PICKEND        ; Pick the ending track
          JSR/      DMARTZ         ; RTZ the Finch
          JSR/      PRPROG         ; Print disk 0, track 0, sector 0
          JSR/      CHKRDY         ; Check for Ready byte from PC
LOOP      JSR/      DMAREAD        ; Get to reading
          JSR/      CRCMARK        ; Calculate the CRC and create marker
TRYAGAIN  JSR/      DMPDATA        ; Dump out 400 bytes of data
          JSR/      CHKNGOK        ; Wait for PC to confirm if data is NG or OK
          BNL       TRYAGAIN       ; If link not set, dump data again
          JSR/      INCRMNT1       ; Increment to next sector/track/disk
          JSR/      CHKESC         ; Check for CTRL+C
          JMP/      LOOP           ; Back to the top
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
MAXDISK   DB        3              ; Max number of disks
ETRACK    DW        X'025D'        ; Define ending track
INSTRING  DW        X'0000'        ; This is the area where we store
          DW        X'0000'        ; the incoming ASCII bytes
INLENGTH  DB        4              ; Used to tell CTB how many bytes to check
INVALUE   DW        X'0000'        ; Where CTB stores the converted bytes
PICKDR    JSR/      CHKBYTE        ; Jump to subroutine that checks rx byte
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load B with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          XAYB                     ; Toss it back into Y
          LDAB=     X'01'          ; Load A with 0001
          SUBB      YL,AL          ; Subtract YL - AL and store in AL
          STAB/     MAXDISK        ; Stab it into MAXDISK used by INCRMNT3
          RSR                      ; Back to main loop
PICKST    JSR/      FILLSTR        ; Jump to routine that fills incoming ASCII
          STA/      READCMD+5      ; Store A (starting track) into read cmd str
          RSR                      ; Return to main loop
PICKEND   JSR/      FILLSTR        ; Jump to routine that fills incoming ASCII
          STA/      ETRACK         ; Store A (ending track) into memory
          RSR                      ; Return to main loop
FILLSTR   JSR/      CHKBYTE        ; Grab the 1st incoming ASCII byte
          STAB/     INSTRING       ; Drop it into location 0 of INSTRING
          JSR/      CHKBYTE        ; Grab the 2nd incoming ASCII byte
          STAB/     INSTRING+1     ; Drop it into location 1 of INSTRING
          JSR/      CHKBYTE        ; Grab the 3rd incoming ASCII byte
          STAB/     INSTRING+2     ; Drop it into location 2 of INSTRING
          JSR/      CHKBYTE        ; Grab the 4th incoming ASCII byte
          STAB/     INSTRING+3     ; Drop it into location 3 of INSTRING
          JSR/      CONVERTB       ; Jump to subroutine to convert byte
          RSR                      ; Return to main loop
CHKBYTE   LDAB/     MUX0CTRL       ; Load MUX status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKBYTE        ; Loop back to top if Link is not set
          LDAB/     MUX0DATA       ; Read in the receive byte
          STAB/     MUX0DATA       ; Echo that digit back
          RSR
CONVERTB  LDAB/     INLENGTH       ; AL = string length
          CTB       /INSTRING(16),/INVALUE(2) 
          LDA/      INVALUE        ; The integer value represented by string
          RSR
*
********************************************************************************
*                        COMAND STRING INITIAL SETUP                           *
********************************************************************************
*
RTZCMD    DW        X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          DW        X'8400'        ; 84 = Disk Select, 00 = Disk 0
          DW        X'82FF'        ; 82 = RTZ
READCMD   DW        X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          DW        X'8400'        ; 84 = Disk Select, 00 = Disk 0
          DB        X'83'          ; 83 = Seek
          DW        X'0000'        ; 0000 = Track 0000
          DB        X'8A'          ; 8A = Read
          DB        X'00'          ; 00 = Sector (Up to 1D)
          DW        X'0190'        ; 0190 = Number of bytes
          DB        X'FF'
*
********************************************************************************
*                             DMA SUBROUTINES                                  *
********************************************************************************
*
DMARTZ    LDA=      X'0000'        ; Since it's an RTZ, no bytes will be read
          STA-      S-             ; Push A to the stack
          LDA=      RTZCMD         ; Where the RTZ command string is
          STA-      S-             ; Push A to the stack
          LDA=      X'FFFF'-6      ; How many bytes to read in command string
          STA-      S-             ; Push A to the stack
          JMP       DMAIT          ; Jump ahead skipping the next section
DMAREAD   LDA=      X'0190'        ; Should read back 400 bytes/1 sector
          STA-      S-             ; Push A to the stack
          LDA=      READCMD        ; Where the read command string is
          STA-      S-             ; Push A to the stack
          LDA=      X'FFFF'-12     ; How many bytes to read in command string
          STA-      S-             ; Push A to the stack
DMAIT     JSR/      CHKFIN         ; Check that FFC is ready
          LDA+      S+             ; Pop A from the stack (FFFF-12 or FFFF-6)
          DMA       SCT,A          ; Load DMA Count from A word register
          LDA+      S+             ; Pop A from the stack(RTZCMD or READCMD)
          DMA       SAD,A          ; Tell FFC where the command bytes are
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'43'          ; 43 = Transfer command to FFC
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          JSR/      CHKFIN         ; Check that FFC is ready
          LDA+      S+             ; Pop A from the stack (0000 or 0190)
          DMA       SCT,A          ; Load DMA Count from A word register
          LDA=      REDATA         ; Store all read bytes to this address
          DMA       SAD,A          ; FFC and CPU on same page about # of bytes
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'45'          ; 43 = Execute
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          JSR/      CHKFIN         ; Check that FFC is ready
          RSR
* Status register is at F801 -> if XXX1 then all good?
CHKFIN    LDA=      X'0100'        ; Load A with a countdown counter
          XAY                      ; Move that over to Y
FINLOOP   LDAB/     X'F801'        ; Load the Finch status in
          SRAB                     ; Shift the status bit over to link
          SRAB                     ; Shift the status bit over to link
          BNL       CHKBSY         ; If link isn't set, FIN is okay
          DLY                      ; Chill for 4.55ms
          DCR       Y              ; Drop our timer down by one
          CLA                      ; Clear A
          SUB       Y,A            ; Subtract A from Y store in A
          BZ        FIERROR        ; Branch to error message
          JMP       FINLOOP        ; Loop back annd try again
CHKBSY    LDA=      X'0100'        ; Load A with a countdown counter
          XAY                      ; Move that over to Y
BSYLOOP   LDAB/     X'F801'        ; Load the Finch status in
          LDBB=     B'00001000'    ; Load the mask into B register
          NABB                     ; AND AL register and BL register
          BZ        ALLGOOD        ; If zero, busy cleared, continue on
          DLY
          DCR       Y              ; Drop our timer down by one
          CLA                      ; Clear A
          SUB       Y,A            ; Subtract A from Y store in A
          BZ        FIERROR        ; Branch to error message
          JMP       BSYLOOP        ; Loop back annd try again
ALLGOOD   RF                       ; Reset fault. Necessary? DIAG does it...
          RSR                      ; Status is good, go back and proceed
FIERROR   JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'FINCH ERROR'
          DW        X'8D8A'
          DC        'DUMP PROGRAM CANCELLED, PRESS ANY KEY TO RETURN TO LOADER'
          DB        0
          JMP/      GOODBYE
*
********************************************************************************
*                         MARKER AND CRC SUBROUTINE                            *
********************************************************************************
*
MARKER    DW 'FI'.XOR.X'80A0'
          DW 'NC'.XOR.X'A0A0'
          DW 'HD'.XOR.X'A080'
          DW 'UM'.XOR.X'A0A0'
          DB 'P'.XOR.X'A0'         ; Marker "FinchDump"
          DW X'0D0A'               ; CR, LF to terminate marker
MKDATA    DS 2+1+1                 ; 2 byte track, 1 byte disk, 1 byte sector
REDATA    DS 400                   ; 400 bytes of sector data
CRCDATA   DS 2                     ; 2 byte CRC
          DW X'0D0A'               ; CR, LF to terminate sector data
DUMPLEN   EQU *-MARKER             ; Amount of data to dump
CRCINT    DW        0              ; Define CRCINT as 0
CRCMARK   STK       X,2            ; Push return address (X reg) onto stack
          CLA                      ; A = 0.
          STA/      CRCINT         ; A -> *CRCINT
          LDA=      REDATA         ; Load A with the location of the read data
          XAY                      ; Transfer that over to Y
NEXTCRC   LDAB+     Y+             ; Load value pointed at by Y and incrmnt Y
          XAZB                     ; Transfer AL into ZL
          LDA=      X'80'          ; A = 0x80.
          LDB/      CRCINT         ; *CRCINT -> B.
CRCLOOP   AND=      X'8000',B,X    ; 0x8000 & B -> X.
          XFRB      ZL,ZU          ; ZL -> ZU.
          ANDB      AL,ZU          ; AL & ZU -> ZU.
          BZ        SKIPXOR        ; If 0, don't XOR with high bit.
          ORE=      X'8000',X      ; 0x8000 ^ X -> X.
SKIPXOR   SLR       B              ; B <<= 1.
          XFR       X,X            ; X -> X.
          BZ        SKIPPOLY       ; If 0, don't XOR with poly.
          ORE=      X'1021',B      ; 0x1021 ^ B -> B.
SKIPPOLY  SRA                      ; A >>= 1.
          BNZ       CRCLOOP        ; If not zero, do the next bit.
          STB/      CRCINT         ; B -> *CRCINT.
CHECKY    LDA=      CRCDATA        ; A = one past end of sector data
          SUB       Y,A            ; Compare Y to one past the end
          BZ        CRCEND         ; Branch to the end of CRC junk if A is zero
          JMP       NEXTCRC        ; Jump back up and go again
CRCEND    POP       X,2            ; Pop X back off of stack so we can return
          LDA/      READCMD+5      ; Load the current track word into A
          STA/      MKDATA         ; Store it into memory for transfer out
          LDAB/     READCMD+3      ; Load the current disk byte into A
          STAB/     MKDATA+2       ; Store it into memory for transfer out
          LDAB/     READCMD+8      ; Load the current sector byte into A
          STAB/     MKDATA+3       ; Store it into memory for transfer out
          LDA/      CRCINT         ; Load calculated CRC into A
          STA/      CRCDATA        ; Store it into memory for transfer out
          RSR                      ; Return back to main loop
*
********************************************************************************
*                            PC COMMS SUBROUTINE                               *
********************************************************************************
*
* PC SHOULD SEND X'FF' WHEN READY
CHKRDY    LDAB/     MUX3CTRL       ; Load MUX3 status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKRDY         ; Loop back to top if Link is not set
          LDAB/     MUX3DATA       ; Read in the receive byte
          LDBB=     X'01'          ; Load BL with 01
          ADDB      BL,AL          ; ADD BL and AL (if AL is FF, this sets link)
          BNL       CHKRDY         ; Loop back up to CHKRDY and try again
          RSR
* PC SHOULD SEND X'FF' WHEN CRC CHECKS GOOD
CHKNGOK   LDAB/     MUX3CTRL       ; Load MUX3 status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKNGOK        ; Loop back to top if Link is not set
          LDAB/     MUX3DATA       ; Read in the received byte
          LDBB=     X'01'          ; Load BL with 01
          ADDB      BL,AL          ; ADD BL and AL (if AL is FF, this sets link)
          RSR
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* Command string: 81 02 84 00 83 00 00 8A 00 01 90 FF
* 81 = Unit Select, 02 = Unit 2 (Finch 0), 84 = Disk Select, 00 = Disk 0
* 83 = Seek, 0000 = Track 0000, 8A = Read, 00 = Sector, 0190 = 400 bytes
* Finch has 4 Disks, 605 Tracks per Disk, 29 Sectors per Track
INCRMNT1  LDAB/     READCMD+8      ; Load the sector count into AL
          XAYB                     ; Transfer it over to YL
          LDAB=     X'1D'          ; Load max sector count into AL
          SUBB      Y,A            ; Subtract AL from YL
          BNZ       SECTINC        ; Branch if not Zero to Sector Increment
          LDAB=     X'00'          ; Reset sector count to 0
          STAB/     READCMD+8      ; Store back into command string
          JMP/      INCRMNT2       ; Jump to Increment 2
SECTINC   LDAB/     READCMD+8      ; Load the sector count into AL
          INRB      A              ; Increment by one
          STAB/     READCMD+8      ; Store back into command string
          JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR                      ; Return to main loop
INCRMNT2  LDAB/     READCMD+3      ; Load the disk count into AL
          XAYB                     ; Transfer it over to YL
          LDAB/     MAXDISK        ; Load max disk count into AL
          SUBB      YL,AL          ; Subtract AL from YL
          BNZ       DISKINC        ; Branch if not Zero to Disk Increment
          LDAB=     X'00'          ; Reset sector count to 0
          STAB/     READCMD+3      ; Store back into command string
          JMP/      INCRMNT3       ; Jump to Increment 3          
DISKINC   LDAB/     READCMD+3      ; Load the disk count into AL
          INRB      AL             ; Increment the disk number
          STAB/     READCMD+3      ; Store back into command string
          JMP/      PRPROG         ; Jump to print progress
INCRMNT3  LDA/      READCMD+5      ; Load the track count into A
          XAY                      ; Transfer it over to Y
          LDA/      ETRACK         ; Load max track count into A
          SUB       Y,A            ; Subtract A from Y
          BNZ       TRACKINC       ; Branch if not Zero to Track Increment
          JMP/      THEEND
TRACKINC  LDA/      READCMD+5      ; Load the track count into A
          INR       A              ; Increment by one
          STA/      READCMD+5      ; Store back into command string
          JMP/      PRPROG         ; Jump to print progress
DSKDIGITS EQU       2              ; Digits to display for the disk.
TRKDIGITS EQU       4              ; Digits to display for the track.
PRPROG    MVF       (DSKDIGITS)='#@',/PRPROGDSK   ; Set the disk format.
          MVF       (TRKDIGITS)='@@#@',/PRPROGTRK ; Set the track format.
          LDAB=     DSKDIGITS      ; AL = digits to display for the disk.
          LDBB=     '0'            ; BL = padding character.
          CFB       /PRPROGDSK(16),/READCMD+3(1) ; Convert READCMD+3(b) to hex
          LDAB=     TRKDIGITS      ; AL = digits to display for the track.
          LDBB=     '0'            ; BL = padding character.
          CFB       /PRPROGTRK(16),/READCMD+5(2) ; Convert READCMD+5(w) to hex
          JSR/      PRINTNULL
          DW        X'8D8A'        ; Carriage return and line feed        
          DC        'DISK: '
PRPROGDSK DS        DSKDIGITS
          DC        ', TRACK: '
PRPROGTRK DS        TRKDIGITS
          DC        ', SECTOR: '
          DB        0              ; Null terminator
          RSR                      ; Return back to main loop
*
********************************************************************************
*                             PRINT SUBROUTINES                                *
********************************************************************************
*
* Print the null-terminated string at X to the CRT
PRINTNULL STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
PNLOOP    LDBB+     X+             ; Load the next byte
          BZ        PNEND          ; If 0, we are done
PNWAIT    LDAB/     MUX0CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        PNWAIT         ; If not empty, loop
          STBB/     MUX0DATA       ; Store the character to the MUX data
          JMP       PNLOOP         ; Go to the next character
PNEND     LDAB+     S+             ; Pop YL from the stack
          XAYB                     ; AL -> YL
          LDBB+     S+             ; Pop BL from the stack
          LDAB+     S+             ; Pop AL from the stack
          RSR
*
* Dump data out CRT3
DMPDATA   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDA=      DUMPLEN        ; Total number of bytes to count
          XFR       A,Z            ; Transfer result of ADD to Z
          LDA=      MARKER         ; Start Marker which is followed by data/crc
          ADD       A,Z            ; Add total length to start
          XFR       A,B            ; Transfer A -> B
          XAY                      ; Transfer A -> Y
DCHECK    SUB       Z,Y            ; Subtracts Z-Y and stores in Y
          BZ        DEND           ; Branch is zero to da end yo
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
DWAIT     LDAB/     MUX3CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        DWAIT          ; If not empty, loop
          LDAB+     B              ; Load byte at address pointed to by B
          STAB/     MUX3DATA       ; Store the character to the MUX data
          INR       B              ; Increment B
          XFR       B,Y            ; Transfer B -> Y
          JMP       DCHECK         ; Go to the next character
DEND      LDAB+     S+             ; Pop YL from the stack
          XAYB                     ; AL -> YL
          LDBB+     S+             ; Pop BL from the stack
          LDAB+     S+             ; Pop AL from the stack
          RSR                      ; Return
*
********************************************************************************
*                        ESCAPE AND END SUBROUTINES                            *
********************************************************************************
*
CHKESC    LDAB=     B'01'          ; Set mask to check if rx byte available
          XAYB                     ; AL -> YL
          LDAB/     MUX0CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; AND AL and YL
          BNZ       CHKRX          ; If not zero, then receive bit set
          RSR                      ; If zero, then go back to business
CHKRX     LDAB=     X'03'          ; Set mask to check if rx byte is ctrl+c
          XAYB                     ; AL -> YL          
          LDAB/     MUX0DATA       ; Read in the receive byte
          SUBB      YL,AL          ; Subtract AL from YL
          BZ        THEEND         ; If zero, then we're all done here
          RSR                      ; If not zero, then go back to business
THEEND    JSR/      PRINTNULL
          DW        X'8D8A'        ; Carriage return and line feed
          DC        'All done!'
          DW        X'8D8A'        ; Carriage return and line feed
          DC        'Press any key to return to top of program.'
          DB        0
GOODBYE   LDAB=     B'01'          ; Set mask to check if rx byte available
          XAYB                     ; AL -> YL
          LDAB/     MUX0CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; AND AL and YL
          BZ        GOODBYE        ; If not zero, loop back to checking for rx
          LDAB/     MUX0DATA       ; Read in the receive byte to the B 
          JSR/      PRINTNULL
          DB        X'8C'          ; Clear the screen
          DB        0
          JMP/      TOP            ; Jump to top of program
          END       ENTRY          ; Set the entry point