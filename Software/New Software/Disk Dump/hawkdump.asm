********************************************************************************
*                                  HAWK DUMP                                   *
********************************************************************************
*
* The assembly in this Finch Dump program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, Gecho and Meisaka provided a 
* a massive amount of help with figuring out assembly, DMA and other drive
* shenanigans. And of course, Ken Romaine is an absolute legend for remembering
* so much about the Centurion and the Hawk.
* Thank you everyone so much for walking me through this!
*
          TITLE     'HKDUMP'
ZHKDUMP   BEGIN     X'0100'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
REDATA    EQU       X'1000'        ; Where the read data goes
NUBYTE    EQU       X'FE6F'        ; How many bytes to read X'FFFF'-X'0190'
MAXCYL    EQU       X'3200'        ; The highest we can count for cylinders
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
* 8D = CR, 8A = LF, 8C = Clear
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'HAWK DUMP PROGRAM'
          DW        X'8D8A'
          DC        'CENTURION COUNTS TOP DOWN'
          DW        X'8D8A'
          DC   'PLATTER 0 = DRIVE 0 REMOVABLE, PLATTER 1 = DRIVE 0 FIXED, ETC.'
          DW        X'8D8A'
          DC        'ENTER PLATTER NUMBER (0 ~ 7): '
          DB        0              ; Null terminator
* Start Doing Productive Stuff
          JSR/      PICKDR         ; Pick your drive and platter
          JSR/      HWKRTZ         ; RTZ the Hawk
          JSR/      PRPROG         ; Print track 0
LOOP      JSR/      DMAREAD        ; Read 400 bytes, DMA it to memory
          JSR/      DMPDATA        ; Dump memory to CRT3
          JSR/      INCRMNT1       ; Increment the track
          JSR/      CHKESC         ; Check if user pressed escape sequence
          JMP/      LOOP           ; What it says on the tin
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
PICKDR    LDAB=     X'01'          ; Set mask to check if rx byte available
          XAYB                     ; AL -> YL
          LDAB/     MUX0CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Subtract AL from YL
          BNZ       GRABRX         ; If not zero, then receive bit set
          JMP/      PICKDR         ; If not zero, then loop
GRABRX    LDAB/     MUX0DATA       ; Read in the receive byte to the B 
          STAB/     MUX0DATA       ; Echo that digit back
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load B with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          STAB/     X'F140'        ; Stab it into F140, the MMIO register
          RSR                      ; Back to main loop
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
CHKRED    LDAB/     X'F144'        ; Load the status register of the Hawk
          XAYB                     ; AL -> YL
          LDAB=     X'FF'          ; Load A with X'FF' inverse of all good
          ANDB      YL,AL          ; AND AL and YL
          BZ        PRINTDOT       ; Success, print dot and go
          LDAB=     X'F0'          ; Load A with X'F0' to check for errors
          ANDB      YL,AL          ; AND AL and YL, should give zero
          BNZ       PRINTEX        ; If not 0, then we have an error
          JMP/      CHKRED         ; If value is '01', DSK is busy, so loop
PRINTDOT  JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR
PRINTEX   JSR/      PRINTNULL      ; Print a 'X' to denote read error
          DC        'X'
          DB        0
          RSR
CHKREADY  LDAB=     B'00110000'    ; Load AL with '0011 0000'
          XAYB                     ; AL -> YL
CHKONCYL  LDAB/     X'F145'        ; Load the drive status
          ANDB      YL,AL          ; clear all the other bits
          OREB      YL,AL          ; Desired bits will both be zero when ready
          BNZ       CHKONCYL       ; Loop back, waiting for drive to be ready
          RSR
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* Hawk has X'0190' cylinders, 2 tracks per cyl., 16 sectors per track
* Layout is 00CC CCCC CCCH SSSS, which makes max count X'3200'
INCRMNT1  LDA=      MAXCYL         ; Load max cylinder count into A
          XFR       A,Z            ; Transfer A over to Z
          LDA/      HWKSCT         ; Load current sector into A
          INR       A              ; Increment it by one
          STA/      HWKSCT         ; Store it back in memory
          SUB       Z,A            ; Subtract A from Z
          BNZ       INCRMNT2       ; If we haven't reached maxcyl yet, proceed
          JMP/      THEEND         ; If we have reached maxcyl, all done
INCRMNT2  LDB/      PRTSCT         ; Load the printable sector
          LDA/      HWKSCT         ; Load the current hawk sector
          SRR       A,5            ; Shift A 5-bits to the right (high bit = 0)
          SUB       A,B            ; Subtract that from PRTSCT to see if diff.
          BNZ       PREPRPROG      ; If so, then update and print
          RSR                      ; Return to main loop
TRKDIGITS EQU       4              ; Digits to display for the track.
PREPRPROG LDA/      HWKSCT         ; Load the Hawk sectors into A
          SRR       A,5            ; Shift right 5 times to just get the cyl.
          STA/      PRTSCT         ; Store that new value into PRTSCT
PRPROG    MVF       (TRKDIGITS)='@@#@',/PRPROGTRK ; Set the track format.
          LDAB=     TRKDIGITS      ; AL = digits to display for the track.
          LDBB=     '0'            ; BL = padding character.
          CFB       /PRPROGTRK(16),/PRTSCT(2) ; Convert READCMD+5(w) to hex
          JSR/      PRINTNULL
          DW        X'8D8A'        ; Carriage return and line feed        
          DC        'TRACK: '
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
          LDA=      X'0190'        ; Total number of bytes to count
          XFR       A,Z            ; Transfer result of ADD to Z
          LDA=      REDATA         ; Start of 400 bytes of DMA'd data
          ADD       A,Z            ; Add X'0190' to Z (400 bytes)
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
          ANDB      YL,AL          ; Subtract AL from YL
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
          DC        'Press any key to return to loader.'
          DB        0
GOODBYE   LDAB=     B'01'          ; Set mask to check if rx byte available
          XAYB                     ; AL -> YL
          LDAB/     MUX0CTRL       ; AL = MUX status byte
          SUBB      YL,AL          ; Subtract AL from YL
          BNZ       GOODBYE        ; If not zero, loop back to checking for rx
          END       ENTRY          ; Set the entry point
LOADER    JMP/      X'FC00'        ; Jump to bootstrap ROM