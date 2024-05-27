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
ZTSTR     BEGIN     X'0400'         ; Actual bootstrap location is FC00
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
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        'D='
          DB        0
PICKDR    JSR/      CHKBYTE        ; Check if we received an input
          XAYB                     ; AL -> YL
          LDAB/     X'C8'          ; Load A with ASCII for "H"
          ANDB      YL,AL          ; AND YL and AL and store in AL
          OREB      YL,AL          ; Exclusive OR should be zero if a match
          BZ        PICKPLT        ; If it is a match, move to next step of boot
          LDAB/     X'D4'          ; Load A with ASCII for "T"
          ANDB      YL,AL          ; AND YL and AL and store in AL
          OREB      YL,AL          ; Exclusive OR should be zero if a match
          BZ        STARTTOS       ; If it is a match, jump to starting TOS
          JMP/      BOOTSTR        ; You didn't pick one I had, so start again
*
********************************************************************************
*                               HAWK BOOTING                                   *
********************************************************************************
*
NUBYTE    EQU       X'E5FF'        ; How many bytes the WIPL is (FFFF-1A00)
REDATA    EQU       X'0100'        ; Where the WIPL is stored in memory
          JSR/      PRINTNULL
          DW        X'8D8A'
          DC        '#='
          DB        0
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
          DMA       SAD,A          ; Where to put the bytes (X'1000')
          LDA=      NUBYTE         ; Load how many bytes to drop down
          DMA       SCT,A          ; How many bytes to read (X'0190')
          LDAB=     X'00'          ; Load read command into A
          STAB/     X'F148'        ; Stab it into F148, the MMIO cmd register
          LDB=      X'FFFF'        ; Load B with all 1's
CHKDMA    DMA       RCT,A          ; Load the DMA count register into A
          SUB       B,A            ; Add B and A and store in A
          BNZ       CHKDMA         ; If the link bit isn't set, DMA aint done
          JMP/      REDATA         ; Jump to beginning of WIPL and go
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
STARTTOS  JMP/      BOOTSTR        ; Nothing here yet, so just start over
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
*