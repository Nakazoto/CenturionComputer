********************************************************************************
*                                  HAWK XMIT                                   *
********************************************************************************
*
* The assembly in this Hawk Transmit program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, Gecho and Meisaka provided a 
* a massive amount of help with figuring out assembly, DMA and other drive
* shenanigans. And of course, Ken Romaine is an absolute legend for remembering
* so much about the Centurion and the Hawk.
* Notably, this program has been modified to work on CPU5 systems. Therefore,
* it should work on just about any Centurion under the sun.
* Thank you everyone so much for walking me through this!
*
* External symbols used by the program and provided by OSLIB
          EXT       MVSSF          ; FILR instruction implementation (OSLIB)
          EXT       @HEX16         ; Converts a stored value to hex (OSLIB)
*
          TITLE     'HKDUMP'
ZHKDUMP   BEGIN     X'0100'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
NUBYTE    EQU       X'FE6F'        ; How many bytes to read X'FFFF'-X'0190'
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
*
ENTRY     LDA=      X'8000'        ; Set the stack pointer
          XAS                      ; to the top of 32k RAM.
* Initialize MUX ports
          LDAB=     MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX0
          LDAB=     MUX3CB         ; Load Mux 3 Control Byte into A
          STAB/     MUX3CTRL       ; Store A into MUX3CTRL, MMIO port for MUX3
* Print Welcome Screen
* 8D = CR, 8A = LF, 8C = Clear
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'HAWK TRANSMIT PROGRAM'
          DW        X'8D8A'
          DC        'PC SIDE RECEIVE PROGRAM MUST BE RUNNING!'
          DW        X'8D8A'
          DC        'PRESS SELECT ON FRONT PANEL TO RETURN TO LOADER'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'CAUTION! THIS PROGRAM HAS NO ERROR HANDLING'
          DW        X'8D8A'
          DC        'INPUT SANE VALUES ARE YOU WILL GET GARBAGE OUT'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'CENTURION COUNTS TOP DOWN'
          DW        X'8D8A'
          DC   'PLATTER 0 = DRIVE 0 REMOVABLE, PLATTER 1 = DRIVE 0 FIXED, ETC.'
          DW        X'8D8A'
          DC        'ENTER PLATTER NUMBER (0 ~ 7): '
          DB        0              ; Null terminator
* Start Doing Productive Stuff
          JSR/      PICKDR         ; Pick your drive and platter
TOP       JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'THE HAWK HAS X3300 TOTAL TRACKS'
          DW        X'8D8A'
          DC        'ENTER START TRACK IN HEX: '
          DB        0
          JSR/      PICKST         ; Pick the starting track
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'ENTER ENDING TRACK IN HEX: '
          DB        0
          JSR/      PICKEND        ; Pick the ending track
          JSR/      HWKRTZ         ; RTZ the Hawk
          JSR/      PRPROG         ; Print track 0
          JSR/      CHKPCRDY       ; Check for Ready byte from PC
LOOP      JSR/      DMAREAD        ; Read 400 bytes, DMA it to memory
          JSR/      CRCMARK        ; Calculate the CRC and create marker
TRYAGAIN  JSR/      DMPDATA        ; Dump out 400 bytes of data
          JSR/      CHKNGOK        ; Wait for PC to confirm if data is NG or OK
          BNL       TRYAGAIN       ; If link not set, dump data again
          JSR/      INCRMNT1       ; Increment the track
          JSR/      CHKESC         ; Check if user pressed escape sequence
          JMP/      LOOP           ; What it says on the tin
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
ETRACK    DW        X'3300'        ; Define ending track
INSTRING  DW        X'0000'        ; This is the area where we store
          DW        X'0000'        ; the incoming ASCII bytes
INLENGTH  DB        4              ; Used to tell CTB how many bytes to check
TEMPA     DW        X'0000'        ; Temp storage location for converted bytes
PICKDR    JSR/      CHKBYTE
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load B with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          STAB/     X'F140'        ; Stab it into F140, the MMIO register
          RSR                      ; Back to main loop
PICKST    JSR/      FILLSTR        ; Jump to routine that fills incoming ASCII
          STA/      HWKSCT         ; Store A (starting track) into read cmd str
          STA/      PRTSCT         ; Store A (starting track) into print cmd str
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
CONVERTB  LDAB/     INSTRING       ; Grab ASCII value from loc. 0 of INSTRING
          JSR/      HEX2INT        ; Convert that to a nibble
          SLRB      AL,4           ; Shift that nibble to the upper half
          STAB/     TEMPA          ; Stab it into TEMPA
          LDAB/     INSTRING+1     ; Grab ASCII value from loc. 1 of INSTRING
          JSR/      HEX2INT        ; Convert to nibble
          LDBB/     TEMPA          ; Load the first nibble into BL
          ORIB      BL,AL          ; OR AL and BL and store in AL
          STAB/     TEMPA          ; Store that byte back into TEMPA
          LDAB/     INSTRING+2     ; Grab ASCII value from loc. 2 of INSTRING
          JSR/      HEX2INT        ; Convert that to a nibble
          SLRB      AL,4           ; Shift that nibble to the upper half
          STAB/     TEMPA+1        ; Stab it into TEMPA
          LDAB/     INSTRING+3     ; Grab ASCII value from loc. 3 of INSTRING
          JSR/      HEX2INT        ; Convert to nibble
          LDBB/     TEMPA+1        ; Load the first nibble into BL
          ORIB      BL,AL          ; OR AL and BL and store in AL
          STAB/     TEMPA+1        ; Store that byte back into TEMPA
          LDA/      TEMPA          ; Load new word built in TEMPA into A
          RSR
*
********************************************************************************
*                            HAWK SUBROUTINES                                  *
********************************************************************************
*
HWKSCT    DW        X'0000'        ; Sector address
PRTSCT    DW        X'0000'        ; Printable sector count
HWKRTZ    LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'HAWK RTZ INITIATED'
          DB        0
          RSR
DMAREAD   JSR/      CHKREADY
          LDA/      HWKSCT         ; Load sector count into A
          STA/      X'F141'        ; Stab it into F141, the MMIO register
          LDAB=     X'02'          ; Load seek command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      CHKREADY
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          LDA=      REDATA         ; Load location where to put bytes
          DMA       SAD,A          ; Where to put the bytes (X'1000')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'0190')
          LDAB=     X'00'          ; Load read command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          LDB=      X'FFFF'        ; Load B with all 1's
CHKDMA    DMA       RCT,A          ; Load the DMA count register into A
          SUB       B,A            ; Add B and A and store in A
          BNZ       CHKDMA         ; If the link bit isn't set, DMA aint done
CHKRED    LDAB/     X'F144'        ; Load the status register of the Hawk
          XAYB                     ; AL -> YL
          LDAB=     X'FF'          ; Load A with X'FF' inverse of all good
          ANDB      YL,AL          ; AND AL and YL
          BZ        PRINTDOT       ; Success, print dot and go
          LDAB=     X'F0'          ; Load A with X'F0' to check for errors
          ANDB      YL,AL          ; AND AL and YL, should give zero
          BNZ       WEGOTERR       ; If not 0, then we have an error
          JMP/      CHKRED         ; If value is '01', DSK is busy, so loop
PRINTDOT  JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR
WEGOTERR  JSR/      PRINTNULL      ; Print a 'X' to denote read error
          DC        'X'
          DB        0
          LDA=      X'0190'        ; Load A with length to fill (400 bytes)
          LDB=      REDATA         ; Load B with starting place to fill
          JSR/      MVSSF          ; Fill buffer
          DB        X'FF'          ; with FF
          RSR
CHKREADY  LDAB=     B'00110000'    ; Load AL with '0011 0000'
          XAYB                     ; AL -> YL
CHKONCYL  LDAB/     X'F145'        ; Load the drive status
          ANDB      YL,AL          ; Clear all the other bits
          OREB      YL,AL          ; Desired bits will both be zero when ready
          BNZ       CHKONCYL       ; Loop back, waiting for drive to be ready
          RSR
*
********************************************************************************
*                         MARKER AND CRC SUBROUTINE                            *
********************************************************************************
*
MARKER    DW 'HA'.XOR.X'80A0'
          DW 'WK'.XOR.X'A0A0'
          DW 'DU'.XOR.X'80A0'
          DW 'MP'.XOR.X'A0A0'      ; Marker "HawkDump"
          DW X'0D0A'               ; CR, LF to terminate marker
MKDATA    DS 2                     ; 2 byte sector address
REDATA    DS 400                   ; 400 bytes of sector data
CRCDATA   DS 2                     ; 2 byte CRC
          DW X'0D0A'               ; CR, LF to terminate sector data
DUMPLEN   EQU *-MARKER             ; Amount of data to dump
CRCINT    DW        0              ; Define CRCINT as 0
CRCMARK   STX-      S-             ; Push return address (X reg) onto stack
          CLA                      ; A = 0.
          STA/      CRCINT         ; A -> *CRCINT
          LDA=      REDATA         ; Load A with the location of the read data
          XAY                      ; Transfer that over to Y
NEXTCRC   LDAB+     Y+             ; Load value pointed at by Y and incrmnt Y
          XAZB                     ; Transfer AL into ZL
          LDA=      X'80'          ; A = 0x80.
          LDB/      CRCINT         ; *CRCINT -> B.
CRCLOOP   LDX=      X'8000'        ; Load X with literal value X'8000'
          AND       B,X            ; AND B and X and store in X
          XFRB      ZL,ZU          ; ZL -> ZU.
          ANDB      AL,ZU          ; AL & ZU -> ZU.
          BZ        SKIPXOR        ; If 0, don't XOR with high bit.
          STA-      S-             ; Push A reg onto stack
          LDA=      X'8000'        ; Load A with literal X'8000'
          ORE       A,X            ; Exclusive OR A and X and store in X
          LDA+      S+             ; Pop A from the stack
SKIPXOR   SLR       B              ; B <<= 1.
          XFR       X,X            ; X -> X.
          BZ        SKIPPOLY       ; If 0, don't XOR with poly.
          STB-      S-             ; Push A reg onto stack
          LDA=      X'1021'        ; Load A with literal X'1021'
          ORE       B,X            ; Exclusive OR A and X and store in X
          LDB+      S+             ; Pop A from the stack
SKIPPOLY  SRA                      ; A >>= 1.
          BNZ       CRCLOOP        ; If not zero, do the next bit.
          STB/      CRCINT         ; B -> *CRCINT.
CHECKY    LDA=      CRCDATA        ; A = one past end of sector data
          SUB       Y,A            ; Compare Y to one past the end
          BZ        CRCEND         ; Branch to the end of CRC junk if A is zero
          JMP       NEXTCRC        ; Jump back up and go again
CRCEND    LDX+      S+             ; Pop X back off of stack so we can return
          LDA/      HWKSCT         ; Load the Hawk sectors into A
          STA/      MKDATA         ; Store it into memory for transfer out
          LDA/      CRCINT         ; Load calculated CRC into A
          STA/      CRCDATA        ; Store it into memory for transfer out
          RSR                      ; Return back to main loop
*
********************************************************************************
*                            PC COMMS SUBROUTINE                               *
********************************************************************************
*
* PC SHOULD SEND X'FF' WHEN READY
CHKPCRDY  LDAB/     MUX3CTRL       ; Load MUX3 status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKPCRDY       ; Loop back to top if Link is not set!!
          LDAB/     MUX3DATA       ; Read in the receive byte
          LDBB=     X'01'          ; Load BL with 01
          ADDB      BL,AL          ; ADD BL and AL (if AL is FF, this sets link)
          BNL       CHKPCRDY       ; Loop back up to CHKPCRDY and try again!!
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
* Hawk has X'0190' cylinders, 2 tracks per cyl., 16 sectors per track
* Layout is 00CC CCCC CCCH SSSS, which makes max count X'3200'
INCRMNT1  LDA=      ETRACK         ; Load max cylinder (ETRACK) count into A
          XFR       A,Z            ; Transfer A over to Z
          LDA/      HWKSCT         ; Load current sector into A
          INR       A              ; Increment it by one
          STA/      HWKSCT         ; Store it back in memory
          SUB       Z,A            ; Subtract A from Z
          BNZ       INCRMNT2       ; If we haven't reached ETRACK yet, proceed
          JMP/      THEEND         ; If we have reached ETRACK, all done
INCRMNT2  LDB/      PRTSCT         ; Load the printable sector
          LDA/      HWKSCT         ; Load the current hawk sector
          SRR       A,5            ; Shift A 5-bits to the right (high bit = 0)
          SUB       A,B            ; Subtract that from PRTSCT to see if diff.
          BNZ       PRPROG         ; If so, then update and print
          RSR                      ; Return to main loop
PRPROG    LDA/      HWKSCT         ; Load the Hawk sectors into A
          XAB                      ; A -> B.
          SRR       A,5            ; Shift right 5 times to just get the cyl.
          STA/      PRTSCT   
          JSR/      @HEX16         ; Convert A to hex at PTRK
          DW        PTRK
          XFR       B,A
          JSR/      @HEX16         ; Convert A to hex at PSCT
          DW        PSCT
          JSR/      PRINTNULL      
          DW        X'8D8A'        ; Carriage return and line feed        
          DC        'TRACK: '      
PTRK      DC        'XXXX, SECTOR: '
PSCT      DC        'XXXX'
          DB        0              ; Null terminator
          RSR
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
*
********************************************************************************
*                        EXTRA SUBROUTINES FOR CPU5                            *
********************************************************************************
*
* Convert a hex character to integer value. The character is in AL and the value
* is returned in AL. AL is set to negative on error.
HEX2INT   STB-      S-             ; Push B to the stack.
          LDBB=     '0'            ; Load 0 to
          SABB                     ; convert the ASCII to the value.
          XFRB      BL,BU          ; BL -> BU.
          BM        H2IERROR       ; If less than 0, error.
          LDBB=     ':'            ; Load : to
          SABB                     ; compare against decimal digits.
          BM        H2IEND         ; If 0-9, done.
          LDBB=     'A'            ; Load A to
          SABB                     ; convert the ASCII to a hex digit > 9.
          XFRB      BL,BU          ; BL -> BU.
          BM        H2IERROR       ; If less than 0, error.
          LDBB=     'G'            ; Load G to
          SABB                     ; compare against hex digits A-F.
          BP        H2IERROR       ; If G or more, error.
          LDBB=     10             ; BL = 10.
          ADDB      BL,BU          ; BL + BU -> BU.
          JMP       H2IEND         ; Successful end.
H2IERROR  LDB=      -1             ; Signal an error.
H2IEND    XFRB      BU,AL          ; BU -> AL.
          LDB+      S+             ; Pop B from the stack.
          RSR                      ; Return.
*