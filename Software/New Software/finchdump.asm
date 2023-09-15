********************************************************************************
*                             FINCH DUMP                                       *
********************************************************************************
*
* The assembly in this Finch Dump program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, all the DMA and drive/FFC related
* control was learned from Gecho, who was extra patient with me.
* Thank you both so much for walking me through this!
*
          TITLE     'FIDUMP'
ZFIDMP    BEGIN     X'0300'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* X'0100' -> RTZ Command String
* X'0200' -> Seek and Read Command String
* X'0300' -> Where this program lives
* X'1000' -> Where the read data will go
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
          DAB=      MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX0
          LDAB=     MUX3CB         ; Load Mux 3 Control Byte into A
          STAB/     MUX3CTRL       ; Store A into MUX3CTRL, MMIO port for MUX3
* Print Welcome Screen
* 8D = CR, 8A = LF, 8C = Clear?
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'FINCH DUMP PROGRAM'
          DW        X'8D8A'
          DB        0              ; Null terminator
* Initiliaze the Command Strings
          JSR/      RTZCMND
* Start Doing Productive Stuff
          JSR/      DMARTZ
LOOP      JSR/      DMARED
          JSR/      DMPDATA
          JSR/      PRINTNULL
          DC        '.'
          JSR/      INCREMENT
          < INSERT LOPP STUFF HERE!!! >
*
********************************************************************************
*                        COMAND STRING INITIAL SETUP                           *
********************************************************************************
*
RTZCMND   LDA=      X'0100'        ; Location of bytes to read for DMA
          XAY                      ; Transfer A to Y
          LDA=      X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'8400'        ; 84 = Disk Select, 00 = Disk 0
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDAB=     X'82FF         ; 82 = RTZ
          STAB+     Y+             ; Store AL indexed, direct, post-incremented
READCMD   LDA=      X'0200'        ; Location of bytes to read for DMA
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
          LDA=      X'0190'        ; 1000 = I don't know, it's what DIAG does
          STA+      Y+             ; Store A indexed, direct, post-incremented
          RSR
*
********************************************************************************
*                             DMA SUBROUTINES                                  *
********************************************************************************
*
DMARTZ    LDA=      X'FFF9'        ; Num. bytes to count for DMA (FFFF-FFF9=06)
          LDB=      X'0000'        ; FFC and CPU on same page about # of bytes
          < NEED A THIRD ONE FOR LOCATION!!! >
          JMP       DMAIT
DMARED    LDA=      X'FFF3'        ; Num. bytes to count for DMA (FFFF-FFF9=0C)
          LDB=      X'0190'        ; FFC and CPU on same page about # of bytes
          < NEED A THIRD ONE FOR LOCATION!!! >
DMAIT     JSR/      CHKSTAT        ; Check that FFC is ready
          < LOAD PROPER VALUE HERE!!! >
          DMA       SCT,A          ; Load DMA Count from A word register
          < LOAD PROPER VALUE HERE!!! >
          DMA       SAD,A          ; Tell FFC where the command bytes are
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'43'          ; 43 = Transfer command to FFC
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          JSR/      CHKSTAT        ; Check that FFC is ready
          < LOAD PROPER VALUE HERE!!! >
          DMA       SAD,A          ; FFC and CPU on same page about # of bytes
          DMA       SDV,3          ; Set DMA device to 3 (FFC?)
          DMA       EAB            ; Enable DMA
          LDAB=     X'45'          ; 43 = Execute
          STAB/     X'F800'        ; F800 = MMIO of FFC related stuff?
          RSR
CHKSTAT   

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
          RSR                      ; Return
*          
* Dump data out CRT3
DMPDATA   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDX=      X'1000'        ; Start of 400 bytes of DMA'd data
          XFR=      X'1190',Z      ; Set max address for data into Z reg
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
* End of source
          END       ENTRY          ; Set the entry point