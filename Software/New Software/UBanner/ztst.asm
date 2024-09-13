* Hellorld! Assembly Program
        TITLE   'HELLO'
ZHELLO  BEGIN   X'0100'
*
* MUX constants. 
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address.
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address.
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1.
*
* Entry point.
MSG       DB        X'8C'
          DB        X'1B'
          DC        'Y'
          DB        X'2A'
          DB        X'32'
          DC        'HELLORLD!'
          DW        X'8D8A'
          DB        0              ; Null terminator

ENTRY     EQU       *
*         HLT
          XFR=      X'F000',S      ; Set the stack pointer to just below MMIO.
* Initialize MUX ports
          LDAB=     MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX
AGAIN     LDAB=     B'01'          ; A = 'Byte recieved?' mask
          XAYB                     ; AL -> YL
LOOPY     EQU       *
          LDAB/     MUX0CTRL       ; al = MUX 0 control register
          ANDB      YL,AL          ; q. byte received?
          BZ        LOOPY          ; a. no .. loop until we get one.
          LDAB/     MUX0DATA       ; AL = received data (who cares?) :D
* Print "Hellorld!"
* 8D = CR, 8A = LF, 8C = Clear screen
          LDB=      MSG
          XFR       B,Z
          JSR/      PRTNULL
          JMP/      AGAIN
* Print the null-terminated string at Z to the CRT
PRTNULL   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
PNLOOP    LDBB+     Z+             ; Load the next byte
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
* End of source
          END       ENTRY         ; Set the entry point