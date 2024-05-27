********************************************************************************
*                                 HAWK FORMAT                                  *
********************************************************************************
*
* This assembly should be compatible with both CPU5 and CPU6 processors. It 
* will need to be compiled, and then executed from a functioning disk at the
* NAME= prompt, or input directly into TOS in raw hexadecimal. As such, both
* the assembly and raw HEX will be provided.
*
          TITLE     'HFMT'
ZHFMT     BEGIN     X'0200'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1
REDATA    EQU       X'0500'        ; Location in memory where our bytes are at
NUBYTE    EQU       X'FE6F'        ; How many bytes to read X'FFFF'-X'0190'
ETRACK    EQU       X'3300'        ; Total number of sectors
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
* Print Welcome Screen
* 8D = CR, 8A = LF, 8C = Clear
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'HAWK FORMAT PROGRAM'
          DW        X'8D8A'
          DC        'CENTURION COUNTS TOP DOWN'
          DW        X'8D8A'
          DC   'PLATTER 0 = DRIVE 0 REMOVABLE, PLATTER 1 = DRIVE 0 FIXED, ETC.'
          DW        X'8D8A'
          DC        'ENTER PLATTER NUMBER (0 ~ 7): '
          DB        0              ; Null terminator
* Start Doing Productive Stuff
          JSR/      FILL00         ; Fill a chunk of memory with data
          JSR/      PICKDR         ; Pick your drive and platter
          JSR/      HWKRTZ         ; RTZ the Hawk
THELOOP   JSR/      FORMAT         ; Format a sector
          JSR/      INCRMENT       ; Incrememnt to next sector
          JMP/      THELOOP        ; If we made it here, there's more work to do
*
********************************************************************************
*                               MEMORY FILL                                    *
********************************************************************************
*
* This fills a chunk of memory with X'00' so the DMA has something to put on
* the disk. Blasts A and B registers. Also, Gecho is a legend.
FILL00    LDA=      X'0190'        ; Load A with how many bytes we want to write
          XAY                      ; Move A over to Y
          LDB=      REDATA         ; Load X with where we want to put the data
          LDAB=     X'00'          ; Load A with the value we want to fill
GECHO     STAB+     B+             ; Store A register into location marked by B
          DCR       Y              ; Decrement Y
          BNZ       GECHO          ; If not zero, we're not done
          RSR
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
* This code prompts the user for which platter is getting formatted, and sets
* up the write bitmask. Blasts A, B, and Y registers.
PICKDR    JSR/      CHKBYTE        ; Check to see if we received input
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load A with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          STAB/     X'F140'        ; Stab it into F140, the MMIO register
          JSR/      CHKREADY       ; Check if the drive is ready
          LDAB/     X'F140'        ; Read back the drive select byte
          LDBB=     X'01'          ; Slap a 1 into B (for later use)
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load A with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          BZ        WBITM          ; If AL is zero, jump to writing bitmask
MLOOP     SLRB      BL             ; Shift BL left one bit
          DCRB      AL             ; Decrement AL
          BZ        WBITM          ; If AL is zero, jump to writing bitmask
          JMP       MLOOP          ; Loop back around and repeat until 0
WBITM     STBB/     X'F143'        ; Setup format write bitmask
          RSR                      ; Back to main loop
CHKBYTE   LDAB/     MUX0CTRL       ; Load MUX status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKBYTE        ; Loop back to top if Link is not set
          LDAB/     MUX0DATA       ; Read in the receive byte
          STAB/     MUX0DATA       ; Echo that digit back
          RSR
*
********************************************************************************
*                            HAWK SUBROUTINES                                  *
********************************************************************************
*
* The meat and potatoes. This routine should DMA 400 bytes of X'00' into every
* sector (all X'3200' of them). Dumps all over A, B, and Y registers.
HWKSCT    DW        X'0000'        ; Sector address
HWKRTZ    LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'HAWK RTZ INITIATED'
          DB        0
          RSR
FORMAT    JSR/      CHKREADY
          LDA/      HWKSCT         ; Load sector count into A
          STA/      X'F141'        ; Stab it into F141, the MMIO register
          LDAB=     X'02'          ; Load seek command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      CHKREADY
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          LDA=      REDATA         ; Load location where the bytes in memory are
          DMA       SAD,A          ; Where the bytes are (X'0500')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'0190')
          LDAB=     X'01'          ; Load write command into A
          STAB/     X'F148'        ; Stab it into F148, starting the DMA madness
          LDB=      X'FFFF'        ; Load B with all 1's
CHKDMA    DMA       RCT,A          ; Load the DMA count register into A
          SUB       B,A            ; Add B and A and store in A
          BNZ       CHKDMA         ; If the link bit isn't set, DMA aint done
CHKRED    JSR/      CHKREADY
          LDAB/     X'F144'        ; Load the status register of the Hawk
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
          RSR
CHKREADY  LDAB=     B'00110000'    ; Load AL w/ Drive Ready and On Cylinder bits
          XAYB                     ; AL -> YL
CHKONCYL  LDAB/     X'F145'        ; Load the drive status
          ANDB      YL,AL          ; Clear all the other bits
          OREB      YL,AL          ; Desired bits will both be zero when ready
          BNZ       CHKONCYL       ; Loop back, waiting for drive to be ready
          RSR
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* Hawk has X'0190' cylinders, 2 tracks per cyl., 16 sectors per track.
* Layout is 00CC CCCC CCCH SSSS, which makes max count X'3200'. 
* This increments up through the sectors. Shabloinks A, B, and Z regsiters.
INCRMENT  LDA=      ETRACK         ; Load max cylinder (ETRACK) count into A
          XFR       A,Z            ; Transfer A over to Z
          LDA/      HWKSCT         ; Load current sector into A
          INR       A              ; Increment it by one
          STA/      HWKSCT         ; Store it back in memory
          SUB       Z,A            ; Subtract A from Z
          BNZ       INCRMNT2       ; If we haven't reached ETRACK yet, proceed
          JMP/      THEEND         ; If we have reached ETRACK, all done
INCRMNT2  RSR                      ; Return to main loop
*End of the line brother.
THEEND    JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'EITHER IT WENT PERFECTLY, OR IT FAILED DRAMATICALLY.'
          DW        X'8D8A'
          DC        'REGARDLESS, I QUIT. -I--I- L(O-O)L'
          DB        0
          HLT
          END       ENTRY          ; Set the entry point
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