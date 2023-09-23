JSR       PRINTNULL                ; Jump relative to PC (within 128, so ok)
          DC        'HELLORLD!'
          DB        0
LOOP      JMP       LOOP
PRINTNULL LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
PNLOOP    LDBB+     X+             ; Load the next byte
          BZ        PNEND          ; If 0, we are done
PNWAIT    LDAB/     X'F200'        ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        PNWAIT         ; If not empty, loop
          STBB/     X'F201'        ; Store the character to the MUX data
          JMP       PNLOOP         ; Go to the next character
PNEND     RSR

7B XX
C8 E5 EC EC EF F2 EC E4 A1 8D 8A 00
73 81
80 00 02 
4C
