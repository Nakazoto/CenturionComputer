          TITLE     'HELLORLD'
ZHELLORLD BEGIN     X'0100'
ENTRY     JSR       PRINTNULL      ; Jump relative to PC (within 128, so ok)
          DW        X'8D8A'
          DC        'HELLORLD!'
          DB        0
          HLT
PRINTNULL LDAB=     B'00000010'    ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
PNLOOP    LDBB+     X+             ; Load the next byte
          BZ        PNEND          ; If 0, we are done
PNWAIT    LDAB/     X'F200'        ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        PNWAIT         ; If not empty, loop
          STBB/     X'F201'        ; Store the character to the MUX data
          JMP       PNLOOP         ; Go to the next character
PNEND     RSR
          END       ENTRY          ; Set the entry point
7B 0D
8D 8A
C8 C5 CC CC CF D2 CC C4 A1
00
00
80 02
4C
C5 41
14 0C
81 F2 00
42 71
14 F9
E1 F2 01
73 F0
09