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
ZFIDMP    BEGIN     X'0300'
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
          DB        0              ; Null terminator
* Initiliaze the Command Strings
          JSR/      RTZCMND
* Start Doing Productive Stuff
          JSR/      DMARTZ
LOOP      JSR/      DMARED
          JSR/      DMPDATA
          
          JSR/      INCRMENT
          < INSERT LOPP STUFF HERE!!! >
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
          LDAB=     X'82FF         ; 82 = RTZ
          STAB+     Y+             ; Store AL indexed, direct, post-incremented
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
          LDA+      S+             ; Pop A from the stack (RTZCMDST or SRDCMDST)
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
<!>       BNZ       CHKSTAT        ; Loop back to CHKSTAT is status is not 00
          RSR
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* X'0200': 81 02 84 00 83 00 00 8A 10 00 01 90
* 81 = Unit Select, 02 = Unit 2 (Finch 0), 84 = Disk Select, 00 = Disk 0
* 83 = Seek, 0000 = Track 0000, 8A = Read, 1000 = ??, 0190 = 400 bytes of what?
* Finch has 4 Disks, 605 Tracks per Disk, 29 Sectors per Track
INCRMENT  LDA/      X'0208'        ; Load the sector count? into A
          INR       A              ; Increase by 1
          XFR       A,Y
          LDA=      X'101E'        ; Load max sector count + 1 into B
          SUB       Y,A            ; Subtract A from B
          BNZ       SECTINC        ; Branch if not Zero to RSR
          LDA=      X'1000'        ; Reset sector count to 0
          STA/      X'0208'


SECTINC   XFR       Y,A            ; Move incremented sector back into A
          STA/      X'0208'        ; Drop A back into command string
          RSR                      ; Return back to main loop
TRAKINC   < DROP NEW VALUE BACK INTO COMMAND STRING!!! >
          JSR/      PRINTNULL
          DC        'X'0974' TRACKS TOTAL: TRACK '
          <PRINT A VARIABLE?>
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
<!>       XFR=      X+X'0190',Z    ; Set max address for data into Z reg
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