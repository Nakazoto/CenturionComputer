********************************************************************************
*                               TOS BOOTSTRAP                                  *
********************************************************************************
*
* This assembly should be compatible with both CPU5 and CPU6 processors. 
* Theoretically, it should be able to be assembled, then the raw hex can
* be written to a ROM that will sit on the backplane and bootstrap the 
* system. The user can type H# to boot from the Hawk, or type T0 to go to
* the TOS memory monitor.
*
          TITLE     'TSTR'
ZTSTR     BEGIN     X'2000'         ; Actual bootstrap location is FC00
*
********************************************************************************
*                                  CONSTANTS                                   *
********************************************************************************
* 
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1
*
********************************************************************************
*                                  BOOTSTRAP                                   *
********************************************************************************
*
ENTRY     BS1       DIAGBD         ; If sense switch one is set, start DIAG
          JMP       BOOTSTR        ; Skip down to start bootstrapping
DIAGBD    JMP/      X'8001'        ; The DIAG card lives at X'8001'
BOOTSTR   LDAB=     MUX0CB         ; Load MUX settings into A
          STAB/     MUX0CTRL       ; Stab that into the MUX card
BOOTSTR1  JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'D='
          DB        0
PICKDR    JSR/      CHKBYTE        ; Check if we received an input
          XAYB                     ; AL -> YL
          LDBB=     'H'-X'80'      ; Load B with ASCII for "H", asm does trans.
          SUBB      YL,BL          ; YL-BL and store in BL
          BZ        PICKPLT        ; If it is a match, move to next step of boot
          LDBB=     'T'-X'80'      ; Load B with ASCII for "T", asm does trans.
          SUBB      YL,BL          ; YL-BL and store in BL
          BZ        STARTTOS       ; If it is a match, jump to starting TOS
          JMP/      BOOTSTR1       ; You didn't pick one I had, so start again
*
********************************************************************************
*                               HAWK BOOTING                                   *
********************************************************************************
*
NUBYTE    EQU       X'EA1F'        ; How many bytes the WIPL is (FFFF-????)
REDATA    EQU       X'0100'        ; Where the WIPL is stored in memory
PICKPLT   JSR/      CHKBYTE        ; Check if we received an input
          XAYB                     ; AL -> YL
          LDAB=     X'0F'          ; Load A with 0000 1111
          ANDB      YL,AL          ; And with 0000 1111, looking at low nibble
          STAB/     X'F140'        ; Stab it into F140, the MMIO register
HWKRTZ    LDAB=     X'03'          ; Load in the RTZ command byte
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
DMAREAD   JSR/      CHKREADY
          CLA
          STA/      X'F141'        ; Stab it into F141, the MMIO register
          LDAB=     X'02'          ; Load seek command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          JSR/      CHKREADY
          DMA       SDV,0          ; Set DMA device to 0
          DMA       EAB            ; Enable DMA
          LDA=      REDATA         ; Load location where to put bytes
          DMA       SAD,A          ; Where to put the bytes (X'0100')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'????')
          LDAB=     X'00'          ; Load read command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          LDB=      X'FFFF'        ; Load B with all 1's
CHKDMA    DMA       RCT,A          ; Load the DMA count register into A
          SUB       B,A            ; Add B and A and store in A
          BNZ       CHKDMA         ; If it aint zero, DMA aint done
          JSR/      CHKREADY       ; Make sure we're doing alright
          JMP/      REDATA+3       ; Jump to beginning of WIPL and go
          END       ENTRY
CHKREADY  LDAB=     B'00110000'    ; Load AL with '0011 0000'
          XAYB                     ; AL -> YL
CHKONCYL  LDAB/     X'F145'        ; Load the drive status
          ANDB      YL,AL          ; Clear all the other bits
          OREB      YL,AL          ; Desired bits will both be zero when ready
          BNZ       CHKONCYL       ; Loop back, waiting for drive to be ready
          RSR
*
********************************************************************************
*                                    TOS                                       *
********************************************************************************
*
INSTRING  DW        X'0000'        ; This is the area where we store
          DW        X'0000'        ; the incoming ASCII bytes
TEMPA     DW        X'0000'        ; Temp storage location for converted bytes
MODSTR    DW        X'0000'        ; Incoming mod ASCII stored here
TEMPB     DB        X'00'          ; Temp storage location for modified bytes
ASCIIB    DW        X'0000'        ; Temp store of ASCII to print
STARTTOS  JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'TOS> '
          DB        0
          JSR/      CHKBYTE        ; Check if we received an input
          XAYB                     ; AL -> YL
          LDBB=     'M'-X'80'      ; Load B with ASCII for "M", asm does trans.
          SUBB      YL,BL          ; YL-BL and store in BL
          BZ        MODTOS         ; If it is a match, move to next step of boot
          LDBB=     'G'-X'80'      ; Load B with ASCII for "G", asm does trans.
          SUBB      YL,BL          ; YL-BL and store in BL
          BZ        GOTOS          ; If it is a match, jump to starting TOS
          JMP/      STARTTOS       ; You typed the wrong thing, start over
MODTOS    JSR/      GETADDR        ; Jump to a routine to get an address
MODLOP    LDAB/     TEMPA          ; Load the value at input address into AL
          JSR/      INT2HEX        ; Convert the byte in AL to ASCII word in A
          STA/      ASCIIB
          JSR/      PRINTNULL
          !! HOW DO I PRINT A VALUE IN A REGISTER OR MEMORY? !!
          DB        0          
          JSR/      CHKBYTE        ; Grab the 1st incoming ASCII byte
          XAYB                     ; AL -> YL
          * Check if Enter was pressed
          LDBB=     X'0D'          ; Load B with ASCII for "CR"/"ENTER"
          SUBB      YL,BL          ; YL-BL and store in BL
          BZ        STARTTOS       ; If it is a match, newline and TOS prompt
          * Start modifying the byte
          STAB/     MODSTR         ; Drop it into location 0 of MODSTR
          JSR/      CHKBYTE        ; Grab the 2nd incoming ASCII byte
          STAB/     MODSTR+1       ; Drop it into location 1 of MODSTR
          LDAB/     MODSTR         ; Grab ASCII value from loc. 0 of MODSTR
          JSR/      HEX2INT        ; Convert that to a nibble
          SLRB      AL,4           ; Shift that nibble to the upper half
          STAB/     TEMPB          ; Stab it into TEMPB
          LDAB/     MODSTR+1       ; Grab ASCII value from loc. 1 of MODSTR
          JSR/      HEX2INT        ; Convert to nibble
          LDBB/     TEMPB          ; Load the first nibble into BL
          ORIB      BL,AL          ; OR AL and BL and store in AL
          STAB/     TEMPA          ; New byte into loc. pointed at by TEMPA
          JSR/      PRINTNULL
          DC        ' '
          DB        00
          LDA=      TEMPA          ; Load TEMPA address into A
          INR       A              ; Increment that address by 1
          STA/      TEMPA          ; Store it back into TEMPA
          JMP/      MODLOP         ; Jump back to top for next byte
* Jumpt to Address and start executing
GOTOS     JSR/      GETADDR        ; Jump to a routine to get an address
          JMP/      TEMPA          ; Jump to the user input address
*
********************************************************************************
*                    SUBROUTINES USED IN MULTIPLE PLACES                       *
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
* Check if we received a byte
CHKBYTE   LDAB/     MUX0CTRL       ; Load MUX status byte in to AL
          SRAB                     ; Shift AL to the right by 1
          BNL       CHKBYTE        ; Loop back to top if Link is not set
          LDAB/     MUX0DATA       ; Read in the receive byte
          STAB/     MUX0DATA       ; Echo that digit back
          RSR
* Get an address from the user
GETADDR   JSR/      CHKBYTE        ; Grab the 1st incoming ASCII byte
          STAB/     INSTRING       ; Drop it into location 0 of INSTRING
          JSR/      CHKBYTE        ; Grab the 2nd incoming ASCII byte
          STAB/     INSTRING+1     ; Drop it into location 1 of INSTRING
          JSR/      CHKBYTE        ; Grab the 3rd incoming ASCII byte
          STAB/     INSTRING+2     ; Drop it into location 2 of INSTRING
          JSR/      CHKBYTE        ; Grab the 4th incoming ASCII byte
          STAB/     INSTRING+3     ; Drop it into location 3 of INSTRING
          JSR/      CONVERTB       ; Jump to subroutine to convert byte
          RSR
* Convert stuff to a byte
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
* Convert a raw binary value to ASCII to be printed out. The binary byte is in
* AL and the ASCII is returned as a word in A.
INT2HEX

!! THIS STILL NEEDS TO BE DONE !!