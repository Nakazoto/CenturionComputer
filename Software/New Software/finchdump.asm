********************************************************************************
*                                  FINCH DUMP                                  *
********************************************************************************
*
* The assembly in this Finch Dump program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, all the DMA and drive/FFC related
* control was learned from Gecho, who was extra patient with me.
* Thank you both so much for walking me through this!
*
          TITLE     'FIDUMP'
ZFIDUMP   BEGIN     X'0300'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
RTZCMDST  EQU       X'0100'        ; Where the RTZ command string lives
SRDCMDST  EQU       X'0200'        ; Where the Seek and Read command string live
READDATA  EQU       X'1000'        ; Where the Read data will go
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
          DC        'FINCH DUMP PROGRAM'
          DW        X'8D8A'
          DC        'PRESS CONTROL + C TO QUIT'
          DW        X'8D8A'
          DB        0              ; Null terminator
* Initiliaze the Command Strings
          JSR/      RTZCMND
* Start Doing Productive Stuff
          JSR/      DMARTZ
LOOP      JSR/      DMARED
          JSR/      DMPDATA
          JSR/      INCRMNT1
          JSR/      CHKESC
          JMP/      LOOP
*
********************************************************************************
*                        COMAND STRING INITIAL SETUP                           *
********************************************************************************
*
RTZCMND   LDA=      RTZCMDST       ; Location of bytes to read for DMA
          XAY                      ; Transfer A to Y
          LDA=      X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'8400'        ; 84 = Disk Select, 00 = Disk 0
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'82FF'        ; 82 = RTZ
          STA+      Y+             ; Store AL indexed, direct, post-incremented
READCMD   LDA=      SRDCMDST       ; Location of bytes to read for DMA
          XAY
          LDA=      X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'8400'        ; 84 = Disk Select, 00 = Disk 0
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDAB=     X'83'          ; 83 = Seek
          STAB+     Y+             ; Store AL indexed, direct, post-incremented
          LDA=      X'0000'        ; 0000 = Track 0000
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDAB=     X'8A'          ; 8A = Read
          STAB+     Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'1000'        ; 1000 = I don't know, it's what DIAG does
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'0190'        ; 0190 = I don't know, it's what DIAG does
          STA+      Y+             ; Store A indexed, direct, post-incremented
          JSR/      PRPROG         ; Print Disk 0, Track 0, Sector 0
          RSR
*
********************************************************************************
*                             DMA SUBROUTINES                                  *
********************************************************************************
*
DMARTZ    LDA=      X'0000'        ; Since it's an RTZ, no bytes will be read
          STA-      S-             ; Push A to the stack
          LDA=      RTZCMDST       ; Where the RTZ command string is
          STA-      S-             ; Push A to the stack
          LDA=      X'FFFF'-6      ; How many bytes to read in command string
          STA-      S-             ; Push A to the stack
          JMP       DMAIT          ; Jump ahead skipping the next section
DMARED    LDA=      X'0190'        ; Should read back 400 bytes/1 sector
          STA-      S-             ; Push A to the stack
          LDA=      SRDCMDST       ; Where the RTZ command string is
          STA-      S-             ; Push A to the stack
          LDA=      X'FFFF'-12     ; How many bytes to read in command string
          STA-      S-             ; Push A to the stack
DMAIT     JSR/      CHKSTAT        ; Check that FFC is ready
          LDA+      S+             ; Pop A from the stack (FFFX or FFFX)
          DMA       SCT,A          ; Load DMA Count from A word register
          LDA+      S+             ; Pop A from the stack(RTZCMDST or SRDCMDST)
          DMA       SAD,A          ; Tell FFC where the command bytes are
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'43'          ; 43 = Transfer command to FFC
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          JSR/      CHKSTAT        ; Check that FFC is ready
          LDA+      S+             ; Pop A from the stack (0000 or 0190)
          DMA       SCT,A          ; Load DMA Count from A word register
          LDA=      READDATA       ; Store all read bytes to this address
          DMA       SAD,A          ; FFC and CPU on same page about # of bytes
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'45'          ; 43 = Execute
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          RSR
* Status register is at F801 -> if 0000 then all good?
CHKSTAT   LDAB/     X'F801'        ; Load A register with F801 status byte
          BNZ       CHKSTAT        ; Loop back to CHKSTAT is status is not 00
          RSR                      ; I HAVE NO IDEA IF THIS IS RIGHT!!!
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* X'0200': 81 02 84 00 83 00 00 8A 10 00 01 90
* 81 = Unit Select, 02 = Unit 2 (Finch 0), 84 = Disk Select, 00 = Disk 0
* 83 = Seek, 0000 = Track 0000, 8A = Read, 1000 = ??, 0190 = 400 bytes of what?
* Finch has 4 Disks, 605 Tracks per Disk, 29 Sectors per Track
INCRMNT1  LDA/      SRDCMDST+8     ; Load the sector count? into A
          XFR       A,Y            ; Transfer it over to Y
          LDA=      X'101F'        ; Load max sector count? into A
          SUB       Y,A            ; Subtract A from Y
          BNZ       SECTINC        ; Branch if not Zero to Sector Increment
          LDA=      X'1000'        ; Reset sector count to 0
          STA/      SRDCMDST+8     ; Store back into command string
          JMP/      INCRMNT2       ; Jump to Increment 2
SECTINC   LDA/      SRDCMDST+8     ; Load the sector count? into A
          INR       A              ; Increment by one
          STA/      SRDCMDST+8     ; Store back into command string
          JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR                      ; Return to main loop
INCRMNT2  LDA/      SRDCMDST+5     ; Load the track count into A
          XFR       A,Y            ; Transfer it over to Y
          LDA=      X'025D'        ; Load max track count into A
          SUB       Y,A            ; Subtract A from Y
          BNZ       TRACKINC       ; Branch if not Zero to Track Increment
          LDA=      X'0000'        ; Reset sector count to 0
          STA/      SRDCMDST+5     ; Store back into command string
          JMP/      INCRMNT3       ; Jump to Increment 3
TRACKINC  LDA/      SRDCMDST+5     ; Load the track count into A
          INR       A              ; Increment by one
          STA/      SRDCMDST+5     ; Store back into command string
          JMP/      PRPROG         ; Jump to print progress
INCRMNT3  LDAB/     SRDCMDST+3     ; Load the disk count into AL
          XFRB      AL,YL          ; Transfer it over to YL
          LDAB=     X'03'          ; Load max disk count into AL
          SUBB      YL,AL          ; Subtract AL from YL
          BNZ       DISKINC        ; Branch if not Zero to Disk Increment
          JMP/      THEEND
DISKINC   LDAB/     SRDCMDST+3     ; Load the disk count into AL
          INRB      AL             ; Increment the disk number
          STAB/     SRDCMDST+3     ; Store back into command string
          JMP/      PRPROG         ; Jump to print progress
PRPROG    JSR/      PRINTNULL
          DW        X'8D8A'        ; Carriage return and line feed        
          DC        'DISK: '
<!>       DB        SRDCMDST+3
          DC        ', TRACK: '
<!>       DW        SRDCMDST+5
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
          JSR/      PRINTNULL
          DC        '.'            ; Print a '.' to denote a completed sector
          DB        0
          RSR                      ; Return
*          
* Dump data out CRT3
DMPDATA   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDX=      READDATA       ; Start of 400 bytes of DMA'd data
          XFR       X+X'0190',Z    ; Add X'0190' to X and store in Z
          LDX=      READDATA       ; Start of 400 bytes of DMA'd data
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
          DB        0
          END       ENTRY          ; Set the entry point