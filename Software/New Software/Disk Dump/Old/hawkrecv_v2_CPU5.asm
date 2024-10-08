********************************************************************************
*                                  HAWK RECV                                   *
********************************************************************************
*
* The assembly in this Hawk Receive program was heavily inspired by GOS and
* Ren14500's excellent guidance. Additionally, Gecho and Meisaka provided a 
* a massive amount of help with figuring out assembly, DMA and other drive
* shenanigans. And of course, Ken Romaine is an absolute legend for remembering
* so much about the Centurion and the Hawk.
* Notably, this program has been modified to work on CPU5 systems. Therefore,
* it should work on just about any Centurion under the sun.
* Thank you everyone so much for walking me through this!
*
          TITLE     'HWKRCV'
ZHKDUMP   BEGIN     X'0100'
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
NUBYTE    EQU       X'FE6F'        ; How many bytes to write X'FFFF'-X'0190'
REDATA    EQU       X'1000'        ; Location in memory where our bytes are at
ETRACK    EQU       X'3300'        ; Total number of sectors
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address
MUX3CTRL  EQU       X'F206'        ; Fourth MUX port data MMIO address
MUX3DATA  EQU       X'F207'        ; Fourth MUX port control MMIO address
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1
MUX3CB    EQU       X'D6'          ; Third MUX port at 19,200 8N1 (F6)
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
          DC        'HAWK RECEIVE PROGRAM'
          DW        X'8D8A'
          DC        'PC SIDE TRANSMIT PROGRAM MUST BE RUNNING!'
          DW        X'8D8A'
          DC        'PRESS SELECT ON FRONT PANEL TO RETURN TO LOADER'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'CAUTION! THIS PROGRAM HAS NO ERROR HANDLING'
          DW        X'8D8A'
          DC        'INPUT SANE VALUES ARE YOU WILL GET GARBAGE'
          DW        X'8D8A'
          DC        'ALL DATA ON SELECTED PLATTER WILL BE OVERWRITTEN!'
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
          DW        X'8D8A'
          DC        'ONE MORE TIME, ALL DATA ON PLATTER WILL BE OVERWRITTEN!'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'YOU HAVE BEEN WARNED TWICE, DON'T COME CRYING TO ME'
          DW        X'8D8A'
          DC        'WHEN YOU BLITZ ALL YOUR DATA.'
          DW        X'8D8A'
          DW        X'8D8A'
          DC        'PRESS SELECT BUTTON ON FRONT PANEL TO RUN AWAY,'
          DW        X'8D8A'
          DC        'OR PRESS ANY KEY ON THE TERMINAL TO DO SOME WILD STUFF.'
          DB        0
          JSR/      CHKBYTE        ; Check for any key pressed
          JSR/      HWKRTZ         ; RTZ the Hawk
LOOP      JSR/      CHKPCRDY       ; Check for Ready byte from PC
          JSR/      RCVSECT        ; Receive a sector worth from PC
          JSR/      CRCOKNG        ; Calculate CRC and compare to received
          JSR/      SENDHWK        ; Copy the contents of memory to the Hawk
          JSR/      CHKESC         ; Check if user pressed escape sequence
          JMP/      LOOP           ; What it says on the tin
*
********************************************************************************
*                         UNIVERSAL SUBROUTINES                                *
********************************************************************************
*
CHKBYTE   LDAB/     MUX0CTRL       ; Load MUX status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKBYTE        ; Loop back to top if Link is not set
          LDAB/     MUX0DATA       ; Read in the receive byte
          STAB/     MUX0DATA       ; Echo that digit back
          RSR
CHKRXB    LDAB/     MUX3CTRL       ; Load MUX status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKRXB         ; Loop back to top if Link is not set
          LDAB/     MUX3DATA       ; Read in the receive byte
          RSR
BFORPC    LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
DWAIT     LDAB/     MUX3CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        DWAIT          ; If not empty, loop
          STBB/     MUX3DATA       ; Store the character to the MUX data
          RSR
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
********************************************************************************
*                               UNIT SETUP                                     *
********************************************************************************
*
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
*
********************************************************************************
*                              RECEIVE SECTOR                                  *
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
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'PC READY!'
          DB        0
          RSR
* CENTURION SHOULD SEND FF TO PC TO CONFIRM IT'S GO TIME
RCVSECT   LDBB=     X'FF'          ; Load X'FF' into B
          JSR/      BFORPC         ; Transmit that out MUX port 3
          LDA=      REDATA         ; Load the temporary memory location into A
          XAY                      ; Transfer it to Y for counting
LETSGO    JSR/      CHKRXB         ; Check if we've received a byte from PC
          STAB+     Y+             ; Store the byte into memory
* Check if we have a full Sector
CHKFULL   XFR       Y,A            ; Transfer Y register into A register
          LDB=      REDATA+X'0192' ; Load B with max value (400b Data + 2b CRC)
          SUB       B,A            ; Subtract max minus current
          BNZ       LETSGO         ; If not zero, time for next byte
          RSR                      ; If it is zero, jump back to main loop
*
********************************************************************************
*                                CRC SUBROUTINE                                *
********************************************************************************
*
CRCINT    DW        0              ; Define CRCINT as 0
CRCDATA   DS        2              ; 2 byte CRC
CRCOKNG   JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'SECTOR RECEIVED, CHECKING CRC'
          DB        0
          STX-      S-             ; Push return address (X reg) onto stack
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
          LDA/      CRCINT         ; Load calculated CRC into A
          STA/      CRCDATA        ; Store it into memory for transfer out
* CENTURION DOES A CHECK OF THE CRC HERE
* CENTURION SHOULD SEND X'FF' TO PC TO CONFIRM CRC IS GOOD
* OR SEND X'00' IF CRC IS BAD, AT WHICH POINT, PC REPEATS SECTOR
CHKNGOK   LDB/      REDATA+X'0191' ; Load B register with the received CRC
          SUB       B,A            ; Subtract B-A and store in A
          BNZ       NGTOG          ; If not zero, CRCs don't match
GTOG      JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'CRC GOOD, TELLING PC'
          DB        0
          LDBB=     X'FF'          ; Load X'FF' into B
          JSR/      BFORPC         ; Transmit that out MUX port 3
          RSR
NGTOG     JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'CRC BAD, TELLING PC'
          DB        0
          LDBB=     X'00'          ; Load X'00' into B
          JSR/      BFORPC         ; Transmit that out MUX port 3
          JMP/      RCVSECT        ; No good, receive that same sector again
*
********************************************************************************
*                            HAWK SUBROUTINES                                  *
********************************************************************************
*
HWKSCT    DW        X'0000'        ; Sector address
HWKRTZ    LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'HAWK RTZ INITIATED'
          DB        0
          RSR
SENDHWK   JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'DATA ALL GOOD, SENDING TO HAWK'
          DB        0
          JSR/      CHKREADY
          LDA/      HWKSCT         ; Load sector count into A
          STA/      X'F141'        ; Stab it into F141, the MMIO register
          LDAB=     X'02'          ; Load seek command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      CHKSEEK        ; Check that the seek has completed
* This is the start of the DMA operations
          JSR/      CHKREADY
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          LDA=      REDATA         ; Load location where the bytes in memory are
          DMA       SAD,A          ; Where the bytes are (X'0800')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'0190')
*          LDAB=     X'01'          ; Load 01 into A reg. byte
*          STAB/     X'F148'        ; Store 01 in F148 -> Write operation
          LDAB=     X'06'          ; Load 06 into A reg. byte
          STAB/     X'F148'        ; Store 06 in F148 -> Format write step 1
          JSR/      CHKREADY       ; Check if DSK2 is ready
          LDAB=     X'05'          ; Load 05 into A reg. byte
          STAB/     X'F148'        ; Store 05 in F148 -> Format write step 2
* This part verifies the format
          JSR/      CHKREADY
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          LDA=      REDATA         ; Load location where the bytes in memory are
          DMA       SAD,A          ; Where the bytes are (X'0500')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'0190')
          LDAB=     X'04'          ; Load verify command into A
          STAB/     X'F148'        ; Stab it into F148, starting the DMA madness
          JSR/      CHKREADY
PRINTDOT  JSR/      PRINTNULL      ; Print a '.' to denote sector progress
          DC        '.'
          DB        0
          RSR
* This checks the status first.
CHKREADY  LDAB/     X'F144'        ; Load Hawk status
          XAYB                     ; AL -> YL
          BZ        CHKONCYL       ; If it's zero, all good, next check
CHKERR    LDAB=     B'11110110'    ; Load AL with all the fault bits
          ANDB      YL,AL          ; And YL and AL together
          BZ        CHKREADY       ; If it's zero, it's just busy
WEGOTERR  JSR/      PRINTNULL      ; Print a 'X' to denote read error
          DC        'X'
          DB        0
          RSR
* If the status is good, we check that we're in place.
CHKONCYL  LDAB=     B'00110000'    ; Load AL w/ Drive Ready and On Cylinder bits
          XAYB                     ; AL -> YL
          LDAB/     X'F145'        ; Load the drive status
          ANDB      YL,AL          ; Clear all the other bits
          OREB      YL,AL          ; Desired bits will both be zero when ready
          BNZ       CHKONCYL       ; Loop back, waiting for drive to be ready
          RSR
* This subroutine is for checking that the seek is complete.
CHKSEEK   LDAB/     X'F145'        ; Load the drive status
          XAYB                     ; Move over to YL
          LDAB=     X'0F'          ; Load AL with B'0000 1111'
          ANDB      YL,AL          ; AND Yl with AL (just look at low nibble)
          BZ        CHKSEEK        ; If the low nibble is zero, seek not done
          RSR
*
********************************************************************************
*                           INCREMENT SUBROUTINE                               *
********************************************************************************
*
* Hawk has X'0190' cylinders, 2 tracks per cyl., 16 sectors per track.
* Layout is 00CC CCCC CCCH SSSS, which makes max count X'3200'. 
* This increments up through the sectors. Shabloinks A, B, and Z registers.
INCRMENT  JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'TRANSMIT FINISHED, INCREMENTING'
          DB        0
          LDA=      ETRACK         ; Load max cylinder (ETRACK) count into A
          XFR       A,Z            ; Transfer A over to Z
          LDA/      HWKSCT         ; Load current sector into A
          INR       A              ; Increment it by one
          STA/      HWKSCT         ; Store it back in memory
          SUB       Z,A            ; Subtract A from Z
          BNZ       INCRMNT2       ; If we haven't reached ETRACK yet, proceed
          JMP/      THEEND         ; If we have reached ETRACK, all done
INCRMNT2  RSR                      ; Return to main loop
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
          DW        X'8D8A'
          DC        'EITHER IT WENT PERFECTLY, OR IT FAILED DRAMATICALLY.'
          DW        X'8D8A'
          DC        'REGARDLESS, I QUIT. -I--I- L(O-O)L'
          DB        0
          HLT
          END       ENTRY          ; Set the entry point
*