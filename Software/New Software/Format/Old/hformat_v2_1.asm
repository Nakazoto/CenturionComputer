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
ZHFMT     BEGIN     X'0100'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1
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
          JSR/      PICKDR         ; Pick your drive and platter
          JSR/      HWKRTZ         ; RTZ the Hawk
          JMP/      FORMAT         ; Format the Hawk
*
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
PICKDR    JSR/      CHKBYTE        ; Check to see if we received input
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load A with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          STAB/     X'F140'        ; Stab it into F140, the MMIO register
          JSR/      CHKRDY         ; Check if the drive is ready
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
HWKRTZ    LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'HAWK RTZ INITIATED'
          DW        X'8D8A'
          DB        0
          RSR
* Main format loop. 
* Y is a constant needs to be protected. A and B are also blitzed.
FORMAT    CLA                      ; Set A register to all zeros
          XFR       A,Y            ; Move A over to Y
          JSR/      CHKSEEK        ; Check to make sure that the RTZ is finished
FLOOP     JSR/      CHKRDY         ; Check if DSK2 is ready
          XFR       Y,A            ; Transfer Y into A (cylinder count)
          STA/      X'F141'        ; Store cylinder count in sector address reg.
          JSR/      CHKRDY         ; Check if DSK2 is ready
          LDAB=     X'02'          ; Load 02 into A reg. byte
          STAB/     X'F148'        ; Seek to cylinder sector address
          JSR/      CHKSEEK        ; Check that seek has completed succesfully
          JSR/      CHKRDY         ; Check if DSK2 is ready
          LDAB=     X'06'          ; Load 06 into A reg. byte
          STAB/     X'F148'        ; Store 06 in F148 -> Format write step 1
          JSR/      CHKRDY         ; Check if DSK2 is ready
          LDAB=     X'05'          ; Load 05 into A reg. byte
          STAB/     X'F148'        ; Store 05 in F148 -> Format write step 2
          JSR/      CHKOKNG        ; Jump to a subroutine that checks error
NEXTADD   INR       Y              ; Increment Y (sector address)
          XFR       Y,A            ; Copy Y into A for testing
          LDB=      X'3200'        ; Load B with max cylinder count
          SUB       B,A            ; Subtract B from A and store in A
          BZ        DONEZO         ; If it's zero, we're finished
          JMP/      FLOOP          ; Loop back around
* Check if the Drive is ready. 
* Blasts A and B registers.
CHKRDY    LDAB/     X'F144'        ; Load Hawk status, flag set if status is 00
          LDBB=     X'0F'          ; Load A with X'0F' => Just the lower nibble
          ANDB      BL,AL          ; AND BL with AL, store in AL
          BNZ       CHKRDY         ; If A not zero, status reg. has some bits
          LDAB/     X'F145'        ; Load the status register of the Hawk
          LDBB=     X'30'          ; Load A with X'30' => On Cyl, Drive Rdy
          ANDB      BL,AL          ; AND BL with AL, store in AL
          SUBB      BL,AL          ; Subtract BL-AL, store in AL
          BNZ       CHKRDY         ; If not zero, we aren't ready yet
          RSR
CHKSEEK   LDAB/     X'F145'        ; Load the status register of the Hawk
          LDBB=     X'0F'          ; Load A with X'0F' => Any seek complete
          ANDB      BL,AL          ; AND BL with AL, store in AL
          BZ        CHKSEEK        ; If zero, seek not complete, so loop
          RSR
* Check if the format actually worked
* Blasts A and B registers.
CHKOKNG   JSR/      CHKRDY         ; Check if the drive is ready
          LDAB=     X'00'          ; Load 00 into A reg. byte
          STAB/     X'F148'        ; Read the sector that we just formatted
          JSR/      CHKRDY         ; Check if the drive is ready
          LDBB/     X'F144'        ; Read the Hawk status register
          BNZ       BADRD1         ; If not zero, something is up
          JSR/      PRINTNULL      ; Good job, you get a dot
          DC        '.'
          DB        0
          RSR                      ; If it is zero, we're good to go
BADRD1    LDAB=     X'10'          ; Load A with X'10' which is format error
          ANDB      BL,AL          ; AND AL and BL
          BZ        BADRD2         ; If zero, then different error
          JSR/      PRINTNULL
          DC        'F'
          DB        0
          RSR
BADRD2    LDAB=     X'20'          ; Load A with X'20' which is sector add error
          ANDB      BL,AL          ; AND AL and BL
          BZ        BADRD3         ; If zero, then different error
          JSR/      PRINTNULL
          DC        'A'
          DB        0
          RSR
BADRD3    LDAB=     X'40'          ; Load A with X'40' which is CRC error
          ANDB      BL,AL          ; AND AL and BL
          BZ        BADRD4         ; If zero, then different error
          JSR/      PRINTNULL
          DC        'C'
          DB        0
          RSR
BADRD4    LDAB=     X'80'          ; Load A with X'80' which is timeout error
          ANDB      BL,AL          ; AND AL and BL
          BZ        BADRD5         ; If zero, then different error
          JSR/      PRINTNULL
          DC        'T'
          DB        0
          RSR
BADRD5    JSR/      PRINTNULL      ; Something went wrong, print a ? to tell
          DC        '?'            ; the programmer that his code sucks.
          DB        0
          RSR
*End of the line brother.
DONEZO    JSR/      PRINTNULL
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