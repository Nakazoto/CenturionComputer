********************************************************************************
*                                  HAWK DUMP                                   *
********************************************************************************
*
* The assembly in this Hawk Dump program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, all the DMA and drive related
* control was learned from Gecho and Ken Romaine, who were very patient with me.
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
NUBYTE    EQU       X'0190'        ; How many bytes to read
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
          DC        'HAWK DUMP PROGRAM'
          DW        X'8D8A'
          DB        0              ; Null terminator
* Start Doing Productive Stuff
          JSR/      PICKDR         ; Pick your drive and platter
          JSR/      HWKRTZ         ; RTZ the Hawk
          JSR/      PRPROG         ; Print track 0
LOOP      JSR/      DMAREAD        ; Read 400 bytes, DMA it to memory
          JSR/      DMPDATA        ; Dump memory to CRT3
          JSR/      INCRMNT1       ; Inncrement the track
          JSR/      CHKESC         ; Check if user pressed escape sequene
          JMP/      LOOP           ; What it says on the tin
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
HWKCMD    DB        X'00'          ; Unit select
HWKSCT    DW        X'0000'        ; Sector address
PICKDR    JSR/      PRINTNULL
          DC        'CENTURION COUNTS TOP DOWN'
          DW        X'8D8A'
          DC        'PLAT0 = DRIVE 0 REMOVABLE, PLAT1 = DRIVE 0 FIXED, ETC.'
          DW        X'8D8A'
          DC        'ENTER PLATTER NUMBER (0 ~ 7): '
          DB        0
          LDAB=     B'01'          ; Set mask to check if rx byte available
WAITRX    XAYB                     ; AL -> YL
          LDAB/     MUX0CTRL       ; AL = MUX status byte
          SUBB      YL,AL          ; Subtract AL from YL
          BZ        GRABRX         ; If zero, then receive bit set
          JMP/      WAITRX         ; If not zero, then loop
RXMASK    DW        X'B0B1'        ; B0 = 0, B1 = 1, B2 = 2, etc.
          DW        X'B2B3'
          DW        X'B4B5'
          DW        X'B6B7'
MIC       DB        X'00'
          LDAB=     RXMASK+MIC
GRABRX    LDBB/     MUX0DATA       ; Read in the receive byte to the B register
          SUBB      BL,AL          ; Subtract AL from BL
          BZ        STORDR         ; If it's zero, let's go!
          LDAB/     MIC            ; If not, load MIC into A
          INRB      A              ; Increase by one
          STAB/     MIC            ; Put A back into MIC
          LDAB=     X'08'          ; If MIC has counted more than 8 times, error
          LDBB=     MIC            ; Load MIC
          SUBB      B,A            ; A quick subtract
          BGZ       PICKDR         ; Jump back to top and pick the correct value
          JMP/      GRABRX         ; Loop back and try again
STORDR    LDAB/     MIC            ; Load byte at MIC
          STAB/     HWKCMD         ; Store that byte into HWKCMD
          RSR                      ; Back to main loop
*
********************************************************************************
*                            HAWK SUBROUTINES                                  *
********************************************************************************
*
HWKRTZ    LDAB=     HWKCMD         ; Load in the Hawk unit select
          STAB/     F'140'         ; Stab it into F140, the MMIO register
          LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     F'148'         ; Stab it into F148, the MMIO cmd register
          RSR
DMAREAD   JSR/      CHKSTAT        ; Check status to make sure its good
          LDA=      HWKSCT         ; Load sector count into A
          STA/      X'F141'        ; Stab it into F141, the MMIO register
          LDAB=     X'02'          ; Load seek command into A
          STAB/     F'148'         ; Stab it into F148, the MMIO cmd register
          JSR/      CHKSTAT        ; Check status to make sure its good
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          DMA       SAD,REDATA     ; Where to put the bytes (X'1000')
          DMA       SCT,NUBYTE     ; How many bytes to read (X'0190')
          LDAB=     X'00'          ; Load read command into A
          STAB/     F'148'         ; Stab it into F148, the MMIO cmd register
          JSR/      CHKRED         ; Jump to see if the read data worked
          RSR
CHKSTAT   

CHKRED    LDAB/     X'F144'

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
          XFRB      AL,YL          ; Transfer it over to YL
          LDAB=     X'1D'          ; Load max sector count into AL
          SUBB      Y,A            ; Subtract AL from YL
          BNZ       SECTINC        ; Branch if not Zero to Sector Increment
          LDAB=     X'00'          ; Reset sector count to 0
          STA/      READCMD+8      ; Store back into command string
          JMP/      INCRMNT2       ; Jump to Increment 2
SECTINC   LDAB/     READCMD+8      ; Load the sector count into AL
          INRB      A              ; Increment by one
          STAB/     READCMD+8      ; Store back into command string
          JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR                      ; Return to main loop
INCRMNT2  LDA/      READCMD+5      ; Load the track count into A
          XFR       A,Y            ; Transfer it over to Y
          LDA=      X'025D'        ; Load max track count into A
          SUB       Y,A            ; Subtract A from Y
          BNZ       TRACKINC       ; Branch if not Zero to Track Increment
          LDA=      X'0000'        ; Reset sector count to 0
          STA/      READCMD+5      ; Store back into command string
          JMP/      INCRMNT3       ; Jump to Increment 3
TRACKINC  LDA/      READCMD+5      ; Load the track count into A
          INR       A              ; Increment by one
          STA/      READCMD+5      ; Store back into command string
          JMP/      PRPROG         ; Jump to print progress
INCRMNT3  LDAB/     READCMD+3      ; Load the disk count into AL
          XFRB      AL,YL          ; Transfer it over to YL
          LDAB=     X'03'          ; Load max disk count into AL
          SUBB      YL,AL          ; Subtract AL from YL
          BNZ       DISKINC        ; Branch if not Zero to Disk Increment
          JMP/      THEEND
DISKINC   LDAB/     READCMD+3      ; Load the disk count into AL
          INRB      AL             ; Increment the disk number
          STAB/     READCMD+3      ; Store back into command string
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
          CFB       /PRPROGTRK(16),/READCMD+5(1) ; Convert READCMD+5(w) to hex
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
*          
* Dump data out CRT3
DMPDATA   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDX=      READDATA       ; Start of 400 bytes of DMA'd data
          XFR       X,Z            ; Transfer X over to Z
          ADD=      X'0190',Z      ; Add X'0190' to Z (400 bytes)
DCHECK    XFR       X,Y            ; Transfer X into Y
          SUB       Z,Y            ; Subtracts Z-Y -> 0x190 - Counter
          BZ        DEND           ; Branch is zero to da end yo
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
DWAIT     LDAB/     MUX3CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        DWAIT          ; If not empty, loop
          STBB/     MUX3DATA       ; Store the character to the MUX data
          INR       X              ; Increment X
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
          SUBB      YL,AL          ; Subtract AL from YL
          BZ        CHKRX          ; If zero, then receive bit set
          RSR                      ; If not zero, then go back to business
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
          BZ        LOADER         ; If zero then rx byte available, time to go
          JMP/      GOODBYE        ; Otherwise, loop back to checking for rx
LOADER    JMP/      X'FC00'        ; Jump to bootstrap ROM
          END       ENTRY          ; Set the entry point