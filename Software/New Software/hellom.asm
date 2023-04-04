* HELLORLD using MMIO peek/poke by ren14500. Public domain.
*
* To use, you must have installed the MMIO transient as @TX019.
*
* Constants for services.
SVCTS     EQU       5         ; Load transient module.
SVCEXIT   EQU       10        ; Exit to OJX00.
TSMMIO    EQU       19        ; Our MMIO transient module named @SYS.@TX019.
PEEKBYTE  EQU       X'0000'   ; B value for peeking a byte.
POKEBYTE  EQU       X'0100'   ; B value for poking a byte.
*
* MUX info.
* See https://github.com/Nakazoto/CenturionComputer/wiki/MUX-Board#mux-mmio
CRT0STAT  EQU       X'F200'   ; CRT0 status register.
CRT0DATA  EQU       X'F201'   ; CRT0 data register.
*
* Set the program title and begin.
          TITLE     'HELLOM'
ZHELLOM   BEGIN     0
* Constants.
STR       DB        X'8D'
          DW        X'8A8A'
          DC        'HELLORLD!'
          DW        X'8D8A'
          DB        0
*
* Reserve space for the stack.
          DS        100
STKTOP    EQU       *
*
* Entrypoint. Set the stack pointer.
ENTRY     XFR=      STKTOP,S  ; Literal STKTOP -> S.
*
* Print the string.
          LDX=      STR       ; Load immediate STR to X.
PRLOOP    LDAB+     X+        ; Load AL from (X), increment X.
          BZ        DONE      ; When null terminator found, we're done.
          XAY                 ; A -> Y.
TXCHECK   LDA=      CRT0STAT  ; Load A with status register address.
          LDB=      PEEKBYTE  ; Load B with value for peeking a byte.
          SVC       SVCTS     ; Load transient module.
          DB        TSMMIO    ; MMIO transient.
          CLR       B,2       ; Set B to 2 to check if transmit clear.
          ANDB      BL,AL     ; Test if transmit clear.
          BZ        TXCHECK   ; Loop to check again if not clear (bit not set).
          LDA=      CRT0DATA  ; Load A with data register address.
          LDB=      POKEBYTE  ; Load B with value for poking a byte.
          SVC       SVCTS     ; Load transient module.
          DB        TSMMIO    ; MMIO transient.
          JMP       PRLOOP    ; Loop to print the next character.
*
* Exit.
DONE      SVC       SVCEXIT   ; Exit to OJX00.
          DB        0         ; Completion code.
*
* End of source.
          END       ENTRY     ; Specify the entrypoint.

