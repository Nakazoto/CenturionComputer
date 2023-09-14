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
ENTRY     XFR=      X'F000',S      ; Set the stack pointer to just below MMIO.
* Initialize MUX ports
          LDAB=     MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX0
* Print "Hellorld!"
* 8D = CR, 8A = LF, 8C = Clear screen
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'HELLORLD!'
          DW        X'8D8A'
          DB        0              ; Null terminator
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
* End of source
          END       ENTRY         ; Set the entry point