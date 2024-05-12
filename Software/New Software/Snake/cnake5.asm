* Centurion Snake (CPU5) by ren14500. Public domain.
*
* Assemble with P.ASM, hit SELECT to get to LOS and enter the executable name.
*
* Everything before GAMENAME is part of GOS (Game Operating System). GOS
* requires you to define GAMENAME to print up to 5 lines in the splash screen
* specific to your game. GOS also requires you to define RUNGAME, which runs
* the game. When RUNGAME returns, GOS is restarted.
*
* GOS has termcap-like functionality and abstracts terminal types. Functions
* are provided to control terminals abstractly. GOS provides a menu system to
* configure the MUX for each terminal.
*
* GOS provides additional menus to configure gameplay keys, game speed, and
* the layout of CRTs to be used for the game.
*
* GOS Services:
*
* RAND: a random number generator, automatically seeded from the time.
* SELECT: waits for input on the current CRT or timeout, whichever comes first.
* BEEP: causes the current CRT to beep.
* CLRS: causes the current CRT to clear the screen.
* POSRC: causes the cursor on the current CRT to be positioned where desired.
* PRINTONE: print a single character to the current CRT.
* PRINTNULL: print a null-terminated string to the current CRT.
* GKCURR: gets a key from the current CRT.
* GKANY: gets a key from any configured CRT.
* SETCRT: selects a CRT as the current CRT.
* ADJPOSCRT: adjusts an absolute row/column position to CRT-relative.
* DEC16: converts a word to ASCII in decimal.
* MVFR: MVFR instruction implementation.
*
* Additionally, GOS sets up interrupt handlers for the MUX, timer, and abort
* levels. All other interrupts are defaulted to simply return. Up to two MUX
* cards are supported, meaning up to 8 CRTs can be supported. Row/column
* absolute positions are encoded in words to allow up to 12 80-column CRT
* widths, though the 8 CRT limit due to MUX card support takes precedence. The
* encoding is 0RRRRRCCCCCCCCCC.
*
* External symbols used by GOS.
          EXT       DIV16     ; DIV instruction implementation (OSLIB).
          EXT       MUL16     ; MUL instruction implementation (OSLIB).
          EXT       MVSSF     ; FILR instruction implementation (OSLIB).
*
* Start of source.
          TITLE     'CNAKE5'
ZCNAKE5   BEGIN     X'0100'
*
* Entry point.
ENTRY     LDA=      X'8000'   ; Set the stack pointer
          XAS                 ; to the top of 32k RAM.
          JSR       INITINT   ; Initialize interrupts.
REENTRY   JSR/      WELALL    ; Print the welcome screen(s).
          JSR/      WELMENU   ; Handle the welcome screen menu.
          JMP       REENTRY   ; Restart.
*
* Simple linear congruential random number generator. Returns the next random
* number in B.
RANDA     EQU       30303
RANDSEED  DW        0         ; Current seed value.
RAND      STA-      S-        ; Push A to the stack.
          LDA=      RANDA     ; A = random multiplier.
          LDB       RANDSEED  ; B = current seed value.
          JSR/      MUL16     ; B = B * seed.
          INR       B         ; B = B + 1.
          STB       RANDSEED  ; Store the new seed value.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* MUX constants.
MUX0      EQU       X'F200'   ; First MUX card MMIO address.
MUXSTCT   EQU       0         ; Offset of MUX status/control byte.
MUXDATA   EQU       1         ; Offset of MUX data byte.
*
* Default interrupt handler that just ignores the interrupt.
RIDEF     RI                  ; Return from interrupt.
DEFINT    JMP       RIDEF     ; Jump to the return.
*
* Default MUX interrupt handler to just reset the interrupts on the MUX cards.
MUXLVL    EQU       6         ; Interrupt level of the MUX interrupt.
MAXCRTS   EQU       2*4       ; Number of possible CRTs (2 cards x 4 ports).
MUXBUFF   DB        0,MAXCRTS ; Buffer to hold the last byte received.
RIMUX     RI                  ; Return from interrupt.
MUXINT    CLA                 ; A = 0.
          LDX=      MUX0      ; X = address of first MUX.
          LDB=      MUXBUFF   ; B = address of MUX buffer.
          XFR       B,Y       ; B -> Y.
          LDAB/     X'F20F'   ; Get MUX interrupt info (clears the interrupt).
          SRAB                ; AL >> 1.
          BL        RIMUX     ; If transmit interrupt, return.
          LDB=      B'11'     ; B = CRT# mask.
          NABB                ; BL = AL & BL. BL = CRT#.
          ADD       B,Y       ; Y = B + Y.
          SLRB      BL        ; BL = BL << 1. BL = offset of CRT#.
          SRR       A,3       ; A = A >> 3. A = MUX#.
          SLR       A,2       ; A = A << 2. A = offset in MUX buffer.
          ADD       A,Y       ; Y = A + Y. Y = address of MUX buffer byte.
          SLR       A,2       ; A = A << 2. A = offset of MUX#.
          ADD       A,X       ; X = address of interrupting MUX.
          ADD       B,X       ; X = address of CRT on MUX.
          LDAB+     X+        ; AL = status of CRT on MUX. X = data address.
          LDAB+     X         ; AL = data of CRT on MUX.
          STAB+     Y         ; Store data byte in buffer.
          JMP       RIMUX     ; Jump to the return.
*
* Default timer interrupt handler to increment X:Y as fast as possible.
TIMERLVL  EQU       10        ; Interrupt level of the timer interrupt.
RSTTIMER  CLRB      ZL        ; 0 -> ZL.
          RI                  ; Return from interrupt.
TIMERINT  INR       Y         ; Increment Y.
          BNZ       RSTTIMER  ; Branch if no overflow.
          INR       X         ; Increment X.
          JMP       RSTTIMER  ; Jump to the return.
*
* Abort interrupt handler.
ABORTLVL  EQU       15        ; Interrupt level of the abort interrupt.
ABORTINT  HLT                 ; Halt the system.
*
* Initialize interrupts. The default ISR is set for all levels other than the
* MUX, timer, and abort levels, which each have their own ISRs.
* Clobbers all except X.
INITINT   STX-      S-        ; Push X to the stack.
          LDB=      DEFINT    ; B = address of default interrupt handler.
          LDX=      X'001C'   ; X = interrupt level 1 C register.
          LDA=      X'010C'   ; A = one set of registers past the end.
          XAY                 ; A -> Y.
          CLA                 ; A = 0 (page map 0).
II1       STA+      X+        ; Store A to C register, move X to P register.
          STB+      X+        ; Store B to P register, move X to next level A.
          INR       X,12      ; Move X to C register.
          XFR       X,Z       ; X -> Z.
          SUB       Y,Z       ; Z = Y - Z.
          BNZ       II1       ; Loop if not equal.
          LDA=      MUXINT    ; A = address of MUX interrupt handler.
          STA/      (MUXLVL*16)+14 ; A -> MUX level P register.
          LDA=      MUXLVL    ; A = MUX interrupt level.
          STAB/     X'F20A'   ; Set interrupt level in MUX0.
          STAB/     X'F21A'   ; Set interrupt level in MUX1.
          STAB/     X'F20E'   ; Enable MUX0 interrupts (value of AL irrelevant).
          STAB/     X'F21E'   ; Enable MUX1 interrupts (value of AL irrelevant).
          LDA=      TIMERINT  ; A = address of timer interrupt handler.
          STA/      (TIMERLVL*16)+14 ; A -> timer level P register.
          LDA=      ABORTINT  ; A = address of abort interrupt handler.
          STA/      (ABORTLVL*16)+14 ; A -> abort level P register.
          LDX+      S+        ; Pop X from the stack.
          ECK                 ; Enable clock.
          EI                  ; Enable interrupts.
          RSR                 ; Return.
*
* Timer interrupt handler for SELECT. If hit, sets register A in the timer
* interrupt level to 0 and restores the default ISR for itself.
SELTIMINT CLA                 ; A = 0.
          JMP       TIMERINT  ; Jump to the default timer ISR.
*
* Wait for the current MUX to have input pending up to the the given timeout
* (in AL) in 1/60ths of a second (US, max 0x7F = ~2.1 sec) or 1/50ths of a
* second (non-US, max 0x7F = ~2.5 sec). Returns the character pressed (without
* high bit set) in AL unless the timeout was hit, in which case 0 is returned
* in AL. All pending key presses from all CRTs are cleared regardless of the
* return.
SELECT    STB-      S-        ; Push B to the stack.
          DI                  ; Disable interrupts.
          DCK                 ; Disable clock.
          STA/ (TIMERLVL*16)+8 ; A -> timer level Z (the time until interrupt).
          LDA=      SELTIMINT ; A = timer interrupt handler.
          STA/ (TIMERLVL*16)+14 ; A -> timer level P register.
          STA/ (TIMERLVL*16)+0 ; A -> timer level A (some non-0 value).
          ECK                 ; Enable clock.
          EI                  ; Enable interrupts.
          LDA=      MUXBUFF   ; A = MUX buffer.
          LDB       CURRCRT   ; B = Current CRT#.
          AAB                 ; B = A + B. B = address of curr CRT MUX buffer.
SELLOOP   LDAB+     B         ; AL = curr CRT character.
          BNZ       SELCHAR   ; If not 0, there is a character pending.
          LDA/      (TIMERLVL*16)+0 ; Timer level A -> A.
          XFR       A,A       ; A -> A.
          BNZ       SELLOOP   ; Loop if timer not expired.
          JMP       SELDONE   ; If expired, A = 0 and we are done.
SELCHAR   XFRB      AL,AU     ; AL -> AU.
          CLAB                ; AL = 0.
          STAB/     (TIMERLVL*16)+9 ; Zero the timer level ZL - back to normal.
          XFRB      AU,AL     ; AU -> AL.
SELDONE   STA-      S-        ; Push A to the stack.
          LDA=      MAXCRTS   ; A = length of buffer.
          LDB=      MUXBUFF   ; B = buffer.
          JSR/      MVSSF     ; Fill buffer
          DB        0         ; with zeros.
          LDA+      S+        ; Pop A from the stack.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Current CRT information.
CURRCRT   DW        0         ; Current CRT number.
CURRCOFF  DW        0         ; Offset into termcap function tables.
CURRMUX   DW        MUX0      ; MMIO base address for current MUX.
CKLEFT    DB        '1'-X'80' ; Key to use for left.
CKRIGHT   DB        '3'-X'80' ; Key to use for right.
CKUP      DB        '5'-X'80' ; Key to use for up.
CKDOWN    DB        '2'-X'80' ; Key to use for down.
*
* Row/column encoding.
COLMASK   EQU       B'0000001111111111' ; Mask to leave only column in word.
RCMASK    EQU       B'0111111111111111' ; Mask to leave row and column.
RSHFTB    EQU       2         ; Amount to shift row in a byte.
RSHFTW    EQU       RSHFTB+8  ; Amount to shift row in a word.
RMULW     EQU       COLMASK+1 ; Amount to multiply row in a word.
RNEG1     EQU       -1.AND..NOT.COLMASK ; Add -1 to row.
*
* Termcap. Default everything to a single ADDS terminal at CRT0.
BOTLEFT   EQU       (23*256)+0  ; Bottom left: row 23, column 0.
BOTRGHT   EQU       (23*256)+79 ; Bottom right: row 23, column 79.
CRLF      EQU       X'8D8A'     ; Carriage return and line feed.
TCMMIO    DW        MUX0        ; Table of MMIO addresses configured.
          DW        0,MAXCRTS-1 ; Invalid until configured other than ^.
TCBEEP    DW        ADDSBEEP    ; Pointers to beep functions.
          DW        0,MAXCRTS-1 ; Invalid until configured other than ^.
TCCLRS    DW        ADDSCLRS    ; Pointers to clear screen functions.
          DW        0,MAXCRTS-1 ; Invalid until configured other than ^.
TCPOSRC   DW        ADDSPOSRC   ; Pointers to row/col position functions.
          DW        0,MAXCRTS-1 ; Invalid until configured other than ^.
ACTVCRTS  DB        0           ; Table of active CRTs from left to right.
          DB        -1,MAXCRTS  ; Invalid until configured other than ^.
NUMACTV   DB        1           ; Number of active CRTs.
SCRNWIDTH DW        80          ; Screen width.
*
* Key configuration. See above for the current CRT's keys.
KEYLEFT   DB        '1'-X'80',MAXCRTS ; Key to use for left.
KEYRIGHT  DB        '3'-X'80',MAXCRTS ; Key to use for right.
KEYUP     DB        '5'-X'80',MAXCRTS ; Key to use for up.
KEYDOWN   DB        '2'-X'80',MAXCRTS ; Key to use for down.
*
* Common game parameters.
GAMESPEED DB        3         ; 3/60 of a second delay.
GAMESCORE DW        0         ; Game score.
*
* Beep the current CRT.
* A = function table pointer.
BEEP      STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDA=      TCBEEP    ; A = address of beep function table.
          LDB/      CURRCOFF  ; B = offset into function table.
          ADD       B,A       ; A = address of beep function pointer.
          JSR+      *A        ; Call the handler.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Clear the screen of the current CRT.
* A = function table pointer.
CLRS      STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDA=      TCCLRS    ; A = address of clear screen function table.
          LDB/      CURRCOFF  ; B = offset into function table.
          ADD       B,A       ; A = address of clear screen function pointer.
          JSR+      *A        ; Call the handler.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Position the cursor of the current CRT. The row/col must be in BU/BL.
* A = function table pointer.
POSRC     STA-      S-        ; Push A to the stack.
          STX-      S-        ; Push X to the stack.
          LDA=      TCPOSRC   ; A = address of position function table.
          LDX/      CURRCOFF  ; X = offset into function table.
          ADD       X,A       ; A = address of position function pointer.
          JSR+      *A        ; Call the handler.
          LDX+      S+        ; Pop X from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the character in AL to the current CRT.
* A = Character.
* B = MUX status.
* Y = MUX status mask.
* Z = MUX base address.
PRINTONE  STB-      S-        ; Push B to the stack.
          XFRB      YL,BL     ; Push YL
          STBB-     S-        ; to the stack.
          XFR       Z,B       ; Push Z
          STB-      S-        ; to the stack.
          LDBB=     B'10'     ; Set mask
          XFRB      BL,YL     ; to check for transmit buffer empty.
          LDB/      CURRMUX   ; B = MMIO base address of MUX port.
          XFR       B,Z       ; B -> Z
POWAIT    LDBB+     Z,MUXSTCT ; BL = MUX status byte.
          ANDB      YL,BL     ; Check if transmit buffer empty.
          BZ        POWAIT    ; If not empty, loop.
          STAB+     Z,MUXDATA ; Store the character to the MUX data.
          LDB+      S+        ; Pop
          XFR       B,Z       ; Z from the stack.
          LDBB+     S+        ; Pop
          XFRB      BL,YL     ; YL from the stack.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Print the null-terminated string at X to the current CRT.
* A = MUX status.
* B = Next character.
* X = RSR target.
* Y = MUX status mask.
* Z = MUX base address.
PRINTNULL STA-      S-        ; Push A to the stack.
          STBB-     S-        ; Push BL to the stack.
          XFRB      YL,AL     ; Push YL
          STAB-     S-        ; to the stack.
          XFR       Z,A       ; Push Z
          STA-      S-        ; to the stack.
          LDAB=     B'10'     ; Set mask
          XAYB                ; in YL to check for transmit buffer empty.
          LDA/      CURRMUX   ; A = MMIO base address of MUX port.
          XAZ                 ; A -> Z.
PNLOOP    LDBB+     X+        ; Load the next byte.
          BZ        PNEND     ; If 0, we are done.
PNWAIT    LDAB+     Z,MUXSTCT ; AL = MUX status byte.
          ANDB      YL,AL     ; Check if transmit buffer empty.
          BZ        PNWAIT    ; If not empty, loop.
          STBB+     Z,MUXDATA ; Store the character to the MUX data.
          JMP       PNLOOP    ; Go to the next character.
PNEND     LDA+      S+        ; Pop Z
          XAZ                 ; from the stack.
          LDAB+     S+        ; Pop YL
          XAYB                ; from the stack.
          LDBB+     S+        ; Pop BL from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Wait for a keypress from the current CRT after clearing any pending key
* presses from all CRTs. The keycode (with high bit set) is returned in AL. It
* is also echoed back to the CRT.
GKCURR    STB-      S-        ; Push B to the stack.
          LDA=      MAXCRTS   ; A = length of buffer.
          LDB=      MUXBUFF   ; B = buffer.
          JSR/      MVSSF     ; Fill buffer
          DB        0         ; with zeros.
          LDA=      MUXBUFF   ; A = MUX buffer.
          LDB/      CURRCRT   ; B = Current CRT#.
          AAB                 ; B = A + B. B = address of curr CRT MUX buffer.
GKCWAIT   LDAB+     B         ; AL = curr CRT character.
          BZ        GKCWAIT   ; If not set, loop to check again.
          XFRB      AL,AU     ; AL -> AU.
          CLAB                ; AL = 0.
          STAB+     B         ; Zero the character read from the buffer.
          LDAB=     X'80'     ; AL = high bit set.
          ORIB      AU,AL     ; Convert it to the character in ASCII.
          JSR       PRINTONE  ; Echo.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Wait for a keypress from any configured CRT after clearing any pending key
* presses from all CRTs. The keycode (with high bit set) is returned in AL. It
* is also echoed back to the CRT. The CRT that had the keypress is set as the
* current CRT. The raw keycode is returned in AU.
* A = CRT number, character.
* B = Table pointer.
* X = Table value.
* Y = CRT count.
* Z = Temporary.
GKANY     STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,X       ; Push Y
          STX-      S-        ; to the stack.
          XFR       Z,X       ; Push Z
          STX-      S-        ; to the stack.
          LDA=      MAXCRTS   ; A = length of buffer.
          LDB=      MUXBUFF   ; B = buffer.
          JSR/      MVSSF     ; Fill buffer
          DB        0         ; with zeros.
          LDA=      MAXCRTS   ; A = CRT count.
          XAY                 ; Y = CRT count.
GKASTART  CLA                 ; A = first CRT number.
          LDB=      TCMMIO    ; B = pointer to configured MUX table.
GKALOOP   LDX+      B+        ; X = MUX address; B = pointer to next.
          BZ        GKA2      ; If 0 (not configured), skip to the next CRT.
GKACRT    STA/      CURRCRT   ; Save A (the CRT number).
          LDX=      MUXBUFF   ; X = pointer to MUX buffer.
          ADD       A,X       ; X = A + X. X = address of curr CRT MUX buffer.
          LDAB+     X         ; AL = curr CRT character.
          BZ        GKA1      ; If not set, go to the next CRT.
          XFRB      AL,BL     ; AL -> BL.
          CLAB                ; AL = 0.
          STAB+     X         ; Zero the character read from the buffer.
          LDA/      CURRCRT   ; Restore A (the CRT number).
          JSR/      SETCRT    ; Set the CRT with the keypress as current.
          LDAB=     X'80'     ; AL = high bit set.
          ORIB      BL,AL     ; Convert keycode to the character in ASCII.
          XFRB      BL,AU     ; Raw keycode.
          JMP       GKADONE   ; Got a key so we are done.
GKA1      LDA/      CURRCRT   ; Restore A (the CRT number).
GKA2      INA                 ; A = next CRT number.
          XAZ                 ; A -> Z.
          SUB       Y,Z       ; Y - Z -> Z. Check if we hit the max CRT.
          BNZ       GKALOOP   ; If not at the max, try the next.
          JMP       GKASTART  ; Loop back to the first CRT.
GKADONE   JSR/      PRINTONE  ; Echo.
          LDX+      S+        ; Pop Z
          XFR       X,Z       ; from the stack.
          LDX+      S+        ; Pop Y
          XFR       X,Y       ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Given the CRT number in A, update A to the MUX port MMIO base address.
MUXADDR   STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XAB                 ; A -> B.
          XAX                 ; A -> X.
          SRR       B,2       ; B = B / 4 = which MUX card.
          SLR       B,4       ; B = B * 16 = address offset from MUX0.
          LDA=      B'11'     ; A = port on card mask.
          AND       A,X       ; X = X % 4 = which port on the card.
          SLR       X         ; X = X * 2 = address offset from port 0.
          LDA=      MUX0      ; A = first MUX card address.
          ADD       X,A       ; A = address of CRT MUX card.
          ADD       B,A       ; A = base address of CRT port on MUX card.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          RSR
*
* ADDS/ADM/VT100 beep implementation.
ADDSBEEP
ADMBEEP
VT1BEEP   STAB-     S-        ; Push AL.
          LDAB=     X'87'     ; Bell.
          JSR/      PRINTONE  ; Print the character.
          LDAB+     S+        ; Pop AL.
          RSR                 ; Return.
*
* ADDS clear screen implementation.
ADDSCLRS  STAB-     S-        ; Push AL.
          LDAB=     X'8C'     ; Form feed.
          JSR/      PRINTONE  ; Print the character.
          LDAB+     S+        ; Pop AL.
          RSR                 ; Return.
*
* ADM clear screen implementation.
ADMCLRS   STAB-     S-        ; Push AL.
          LDAB=     X'9A'     ; SUB (Control-Z).
          JSR/      PRINTONE  ; Print the character.
          LDAB+     S+        ; Pop AL.
          RSR                 ; Return.
*
* VT100 clear screen implementation.
VT1CLRS   JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        '[2J'
          DB        0         ; Null terminator.
          RSR                 ; Return.
*
* ADDS position row/col implementation.
ADDSRC    EQU       '  '      ; 0,0 is at ASCII space,space.
ADDSPOSRC STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDA=      ADDSRC    ; A = 0,0 offset.
          ADD       A,B       ; Create the characters for the row/col.
          STBB      APCOL     ; Store BL as the column.
          XFRB      BU,BL     ; Move the row to BL.
          STBB      APROW     ; Store BL as the row.
          JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        'Y'
APROW     DB        0         ; Row.
APCOL     DB        0         ; Column.
          DB        X'80'     ; Null for the terminal.
          DB        0         ; Null terminator.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          DLY                 ; Delay to let the terminal process the request.
          RSR                 ; Return.
*
* ADM position row/col implementation.
ADMRC     EQU       '  '      ; 0,0 is at ASCII space,space.
ADMPOSRC  STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDA=      ADMRC     ; A = 0,0 offset.
          ADD       A,B       ; Create the characters for the row/col.
          STBB      ADMPCOL   ; Store BL as the column.
          XFRB      BU,BL     ; Move the row to BL.
          STBB      ADMPROW   ; Store BL as the row.
          JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        '='
ADMPROW   DB        0         ; Row.
ADMPCOL   DB        0         ; Column.
          DB        0         ; Null terminator.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          DLY                 ; Delay to let the terminal process the request.
          DLY                 ; Delay to let the terminal process the request.
          RSR                 ; Return.
*
* VT100 position row/col implementation.
VT1POSRC  STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDA=      X'0101'   ; A = one in each byte.
          AAB                 ; Make row/column 1-based.
          CLA                 ; A = 0.
          XFRB      BU,AL     ; A = row.
          JSR/      DEC16     ; Convert row to decimal.
          DB        '0'       ; Pad with zeros.
          DW        2         ; String length = 2.
          DW        VT1PROW   ; String address.
          XFRB      BL,AL     ; A = column.
          JSR/      DEC16     ; Convert column to decimal.
          DB        '0'       ; Pad with zeros.
          DW        2         ; String length = 2.
          DW        VT1PCOL   ; String address.
          JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        '['       ; CSI.
VT1PROW   DW        0         ; Row.
          DC        ';'
VT1PCOL   DW        0         ; Column.
          DC        'H'
          DB        0         ; Null terminator.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Set the current CRT information for the CRT number in A.
SETCRT    STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STA/      CURRCRT   ; Store the CRT number.
          SLA                 ; A << 1, the offset into the function table.
          STA/      CURRCOFF  ; Store the CRT function table offset.
          LDB=      TCMMIO    ; B = MUX table address.
          AAB                 ; Offset into the MUX table.
          LDA+      B         ; Get the MUX address.
          STA/      CURRMUX   ; Store the MUX address.
          LDB+      S,2       ; B = CRT number.
          LDA=      KEYLEFT   ; A = left key table.
          ADD       B,A       ; Add the offset for this CRT number.
          LDAB+     A         ; A = left key for this CRT.
          STAB/     CKLEFT    ; A -> current left key.
          LDA=      KEYRIGHT  ; A = right key table.
          ADD       B,A       ; Add the offset for this CRT number.
          LDAB+     A         ; A = right key for this CRT.
          STAB/     CKRIGHT   ; A -> current right key.
          LDA=      KEYUP     ; A = up key table.
          ADD       B,A       ; Add the offset for this CRT number.
          LDAB+     A         ; A = up key for this CRT.
          STAB/     CKUP      ; A -> current up key.
          LDA=      KEYDOWN   ; A = down key table.
          ADD       B,A       ; Add the offset for this CRT number.
          LDAB+     A         ; A = down key for this CRT.
          STAB/     CKDOWN    ; A -> current down key.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Adjust the absolute position in B to a CRT-relative row in BU and column in
* BL. Sets the apprpriate CRT as active based on the absolute column number.
* A = CRT number.
* B = row/column.
* X = column on CRT.
* Y = CRT index.
ADJPOSCRT STA-      S-        ; Push A to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
          LDX=      COLMASK   ; X = column mask.
          AND       B,X       ; Mask out row leaving only column in X.
          STB-      S-        ; Push B to the stack.
          LDB=      80        ; B = columns per CRT (divisor).
          XFR       X,A       ; A = column (dividend).
          JSR/      DIV16     ; A = A % 80; B = A / 80.
          XAX                 ; A -> X.
          XFR       B,Y       ; B -> Y.
          LDB+      S+        ; Pop B from the stack.
          SRRB      BU,RSHFTB ; BU = row.
          XFRB      XL,BL     ; XL -> BL; BL = column on CRT.
          LDX=      ACTVCRTS  ; X = active CRT table.
          ADD       Y,X       ; X = X + Y; X = pointer to active CRT number.
          CLA                 ; A = 0.
          LDAB+     X         ; AL = active CRT number.
          JSR       SETCRT    ; Set the CRT as active.
          LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Convert A to ASCII in decimal. The arguments that must follow are the
* padding byte, the string length word, and the address of the string. It is
* assumed that the string is big enough to hold the value.
DEC16     STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
          XFR       Z,A       ; Push Z
          STA-      S-        ; to the stack.
          LDAB+     X+        ; AL = padding byte.
          STAB      D16PAD    ; Save padding byte for FIL routine.
          LDA+      X+        ; A = string length.
          LDB+      X+        ; B = string address.
          JSR/      MVSSF     ; Fill the string with the padding byte.
D16PAD    DB        0
          LDA+      X,-4      ; A = string length.
          LDB+      X,-2      ; B = address of string.
          AAB                 ; B = one past end of string.
          XFR       B,Z       ; B -> Z.
          LDA+      S,6       ; A = word value.
          XAY                 ; A -> Y.
D16LOOP   LDB=      10        ; B = 10, the divisor.
          JSR/      DIV16     ; A = A % B (the digit), B = A / B (remaining).
          XFR       B,Y       ; B -> Y, the next dividend.
          LDBB=     '0'       ; ASCII digit base.
          AAB                 ; BL = ASCII digit.
          STBB-     Z-        ; Store the digit in the string.
          XFR       Y,A       ; Move dividend back to A.
          BNZ       D16LOOP   ; Loop if more digits.
          LDA+      S+        ; Pop Z
          XAZ                 ; from the stack.
          LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Move memory from the second argument to the first. The length is in A and must
* be greater than zero. The strings can overlap.
MVFR      STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          XFR       Y,B       ; Push Y
          STB-      S-        ; to the stack.
          XFR       Z,B       ; Push Z
          STB-      S-        ; to the stack.
          LDB+      X+        ; B = target string pointer.
          XFR       B,Y       ; Y = target string pointer.
          LDB+      X+        ; B = source string pointer.
          XFR       B,Z       ; Z = source string pointer.
MVFRLOOP  LDBB+     Z+        ; BL = next source byte, Z = next source ptr.
          STBB+     Y+        ; Store to target string, Y = next target ptr.
          DCA                 ; A = A - 1.
          BNZ       MVFRLOOP  ; If more bytes, loop.
          LDA+      S+        ; Pop Z
          XAZ                 ; from the stack.
          LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the welcome screen on all configured CRTs.
* A = CRT number.
* B = Table pointer.
* X = Table value.
* Y = CRT count.
* Z = Temporary.
WELALL    STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
          XFR       Z,A       ; Push Z
          STA-      S-        ; to the stack.
          CLA                 ; A = first CRT number.
          LDB=      TCMMIO    ; B = pointer to configured MUX table.
          LDX=      MAXCRTS   ; X = CRT count.
          XFR       X,Y       ; Y = CRT count.
WALOOP    LDX+      B+        ; X = MUX address; B = pointer to next.
          BZ        WANEXT    ; If 0 (not configured), skip to the next CRT.
          JSR       WELCOME   ; Print on the current CRT.
WANEXT    INA                 ; A = next CRT number.
          XAZ                 ; A -> Z.
          SUB       Y,Z       ; Y - Z -> Z. Check if we hit the max CRT.
          BNZ       WALOOP    ; If not at the max, try the next.
          LDA+      S+        ; Pop Z
          XAZ                 ; from the stack.
          LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the welcome screen in A.
WELCOME   JSR/      SETCRT    ; Set the CRT in A as current.
          JSR/      CLRS      ; Clear the screen.
          JSR/      PRINTNULL ; Print the top part of the screen.
 DC '          CCCCC'
 DW CRLF
 DC '       CC C'
 DW CRLF
 DC '     CC   CCCCC   C'
 DW CRLF
 DC '     C  CCCCCCCCCCCC'
 DW CRLF
 DC '     C  CCCCC      CC'
 DW CRLF
 DC '       CCCC    CCC CC    EE            T                 I'
 DW CRLF
 DC '        CCCC   CCCCCC   E  E   NNNNN  TTTT  U   U   R R'
 DW CRLF
 DC '         CCC    CCCCCC  E E    NN  NN  TT   U   U  RRR   II  OOOOO  NNNNNN'
 DW CRLF
 DC '          CCCC      C   EE  E   N   N   T   UU  UU  RR    I  OO  OO  N   N'
 DW CRLF
 DC '          CCCCCCCCCCCC   EEE    N   N    TT  UUUUU  RR    II  OOOOO  NN  N'
 DW CRLF
 DC '          CC CCCCCC'
 DW CRLF
 DC '              CCCCCC'
 DW CRLF,2
 DB 0
          JSR/      GAMENAME  ; Print the game name.
          JSR/      PRINTNULL ; Print the bottom part of the screen.
 DW CRLF
 DC '(C)RT CONFIGURATION AND (L)AYOUT'
 DW CRLF
 DC '(K)EY CONFIGURATION     (S)PEED'
 DW CRLF
 DC '(B)EGIN GAME'
 DW CRLF
 DC 'SELECTION> '
 DB 0
          RSR                 ; Return.
*
* Handle the welcome screen menu.
* A = keycode.
* B = comparison.
WELMENU   STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
WMGK      JSR/      GKANY     ; Wait for a keypress from any CRT.
          LDB=      .NOT.X'2020' ; Mask out lowercase to uppercase.
          AND       B,A       ; Ensure uppercase.
          LDBB=     'C'       ; Load C to
          SABB                ; compare and
          BNZ       WML       ; if no match, try another character.
          JSR       CRTCONFIG ; Do CRT configuration.
          JMP       WMDONE    ; And we are done.
WML       LDBB=     'L'       ; Load L to
          SABB                ; compare and
          BNZ       WMK       ; if no match, try another character.
          JSR/      LAYOUTCRT ; Do layout of CRTs configuration.
          JMP       WMDONE    ; And we are done.
WMK       LDBB=     'K'       ; Load K to
          SABB                ; compare and
          BNZ       WMS       ; if no match, try another character.
          JSR/      KEYCONFIG ; Do key configuration.
          JMP       WMDONE    ; And we are done.
WMS       LDBB=     'S'       ; Load S to
          SABB                ; compare and
          BNZ       WMB       ; if no match, try another character.
          JSR/      SPDCONFIG ; Do speed configuration.
          JMP       WMDONE    ; And we are done.
WMB       LDBB=     'B'       ; Load B to
          SABB                ; compare and
          BNZ       WMBEEP    ; if no match, beep.
          LDA/      (TIMERLVL*16)+6 ; Get the low order time word.
          STA/      RANDSEED  ; Set the random number seed.
          JSR/      RUNGAME   ; Start the game.
          JMP       WMDONE    ; And we are done.
WMBEEP    JSR/      BEEP      ; Beep the CRT.
          JMP       WMGK      ; Get another key.
WMDONE    LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* CRT configuration.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
* Y = baud/type.
CRTCONFIG STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
CCPRINT   JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DC        'ENTER CRT NUMBER> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          STAB/     BAUDCRT   ; Store it in the baud string.
          STAB/     TYPECRT   ; Store it in the terminal type string.
          LDBB=     '0'       ; Load 0 to
          SABB                ; convert the ASCII to the CRT number.
          BM        CCPRINT   ; If less than 0 entered, loop around.
          CLR       X         ; 0 -> X.
          XFRB      BL,XL     ; BL -> XL. Copy the CRT number.
          LDAB=     MAXCRTS-1 ; AL = max CRT number.
          SABB                ; AL - BL -> BL.
          BM        CCPRINT   ; If too big digit or non-digit, loop around.
          XFRB      XL,AL     ; XL -> AL. The CRT number.
BPRINT    JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DW        CRLF
          DC        '0 =    75 BAUD'
          DW        CRLF
          DC        '1 =   300 BAUD'
          DW        CRLF
          DC        '2 =  1200 BAUD'
          DW        CRLF
          DC        '3 =  2400 BAUD'
          DW        CRLF
          DC        '4 =  4800 BAUD'
          DW        CRLF
          DC        '5 =  9600 BAUD'
          DW        CRLF
          DC        '6 = 19200 BAUD'
          DW        CRLF
          DC        'ENTER BAUD FOR CRT'
BAUDCRT   DC        'X> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     '0'       ; Load 0 to
          SABB                ; convert the ASCII to the baud selection.
          BP        BAUD0     ; If not less than 0 entered, continue.
          JMP/      BPRINT    ; If less than 0 entered, loop around.
BAUD0     XFRB      BL,YL     ; BL -> YL. Copy the baud rate.
          LDAB=     6         ; AL = max baud selection.
          SABB                ; AL - BL -> BL.
          BP        BAUDOK    ; Baud rate ok, continue.
          JMP/      BPRINT    ; If too big digit or non-digit, loop around.
BAUDOK    INRB      YL        ; YL + 1 -> YL. Actual value is one more.
          SLRB      YL,5      ; YL << 5 -> YL. Move baud to upper 3 bits.
          LDBB=     B'101'    ; 7E1.
          ORIB      Y,B       ; BL now has the MUX control byte.
          XFR       X,A       ; X -> A. Get the CRT number.
          JSR/      MUXADDR   ; Get the MUX address for that CRT.
          STBB+     A         ; Set the MUX control byte.
          LDB=      TCMMIO    ; B = pointer to configured MUX table.
          SLR       X         ; X << 1 -> X. Offset in table.
          ADD       X,B       ; B = pointer to CRT in MUX table.
          STA+      B         ; Store the MMIO address.
TPRINT    JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF,2
          DC        '0 = ADDS'
          DW        CRLF
          DC        '1 = ADM'
          DW        CRLF
          DC        '2 = VT100'
          DW        CRLF
          DC        'ENTER TYPE FOR CRT'
TYPECRT   DC        'X> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     '0'       ; Load 0 to
          SABB                ; compare the ASCII to the type selection.
          BNZ       CCT1      ; If not 0, go to the next check.
          LDA=      ADDSBEEP  ; A = ADDS beep function.
          LDB=      TCBEEP    ; B = pointer to beep table.
          ADD       X,B       ; B = pointer to CRT in beep table.
          STA+      B         ; Store beep function.
          LDA=      ADDSCLRS  ; A = ADDS clear screen function.
          LDB=      TCCLRS    ; B = pointer to clear screen table.
          ADD       X,B       ; B = pointer to CRT in clear screen table.
          STA+      B         ; Store clear screen function.
          LDA=      ADDSPOSRC ; A = ADDS position function.
          LDB=      TCPOSRC   ; B = pointer to position table.
          ADD       X,B       ; B = pointer to CRT in position table.
          STA+      B         ; Store position function.
          JMP       CCDONE    ; Done.
CCT1      LDBB=     '1'       ; Load 1 to
          SABB                ; compare the ASCII to the type selection.
          BNZ       CCT2      ; If not 1, go to the next check.
          LDA=      ADMBEEP   ; A = ADM beep function.
          LDB=      TCBEEP    ; B = pointer to beep table.
          ADD       X,B       ; B = pointer to CRT in beep table.
          STA+      B         ; Store beep function.
          LDA=      ADMCLRS   ; A = ADM clear screen function.
          LDB=      TCCLRS    ; B = pointer to clear screen table.
          ADD       X,B       ; B = pointer to CRT in clear screen table.
          STA+      B         ; Store clear screen function.
          LDA=      ADMPOSRC  ; A = ADM position function.
          LDB=      TCPOSRC   ; B = pointer to position table.
          ADD       X,B       ; B = pointer to CRT in position table.
          STA+      B         ; Store position function.
          JMP       CCDONE    ; Done.
CCT2      LDBB=     '2'       ; Load 2 to
          SABB                ; compare the ASCII to the type selection.
          BNZ       CCTBAD    ; If not 2, go to the next check.
          LDA=      VT1BEEP   ; A = VT100 beep function.
          LDB=      TCBEEP    ; B = pointer to beep table.
          ADD       X,B       ; B = pointer to CRT in beep table.
          STA+      B         ; Store beep function.
          LDA=      VT1CLRS   ; A = VT100 clear screen function.
          LDB=      TCCLRS    ; B = pointer to clear screen table.
          ADD       X,B       ; B = pointer to CRT in clear screen table.
          STA+      B         ; Store clear screen function.
          LDA=      VT1POSRC  ; A = VT100 position function.
          LDB=      TCPOSRC   ; B = pointer to position table.
          ADD       X,B       ; B = pointer to CRT in position table.
          STA+      B         ; Store position function.
          JMP       CCDONE    ; Done.
CCTBAD    JMP/      TPRINT    ; Invalid choice, try again.
CCDONE    LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Layout CRTs.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
LAYOUTCRT STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          CLR       X         ; X = 0.
LCPRINT   JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DC        'ENTER CRT NUMBER (LEFT-TO-RIGHT) OR '
          DB        MAXCRTS+'0'
          DC        ' WHEN DONE> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     '0'       ; Load 0 to
          SABB                ; convert the ASCII to the CRT selection.
          BM        LCDONE    ; If less than 0 entered, done.
          LDAB=     MAXCRTS   ; Load max CRT count to
          SUBB      BL,AL     ; compare against the max.
          BL        LCDONE    ; If max or more entered, done.
          LDA=      ACTVCRTS  ; A = pointer to active CRT table.
          ADD       X,A       ; A = pointer to current table entry.
          STBB+     A         ; BL -> current table entry.
          INX                 ; X = X + 1.
          LDAB=     MAXCRTS   ; Load max CRT count to
          SUBB      XL,AL     ; compare against the max.
          BM        LCPRINT   ; Loop if not at the max.
LCDONE    LDBB=     -1        ; Load -1 terminator.
          XFRB      XL,AL     ; XL -> AL (number of active CRTs).
          STAB/     NUMACTV   ; AL -> number of active CRTs.
          LDA=      ACTVCRTS  ; A = pointer to active CRT table.
          ADD       X,A       ; A = pointer to current table entry.
          STBB+     A         ; BL -> current table entry.
          LDA=      ACTVCRTS  ; A = pointer to active CRT table.
          LDX=      LCSTR     ; X = pointer to show string.
          STA-      S-        ; Push A to the stack.
          LDA=      MAXCRTS+1 ; A = length of buffer.
          LDB=      LCSTR     ; B = buffer.
          JSR/      MVSSF     ; Fill buffer
          DB        1         ; with ones (NOP).
          LDA+      S+        ; Pop A from the stack.
          LDB=      '0'*256   ; BU = ASCII zero base.
LCCOPY    LDBB+     A+        ; BL = next entry; A = A + 1.
          BM        LCSHOW    ; If negative, that is it.
          ADDB      BU,BL     ; BL = ASCII CRT number.
          STBB+     X+        ; Store BL to the show string; X = X + 1.
          JMP       LCCOPY    ; Go to the next entry.
LCSHOW    LDBB=     0         ; BL = null terminator.
          STBB+     X         ; Store BL to terminate the show string.
          JSR/      PRINTNULL ; Print the layout.
          DW        CRLF
          DC        'LAYOUT: '
LCSTR     DB        0,MAXCRTS+1
          LDAB=     2*60      ; 2 seconds.
          JSR/      SELECT    ; Wait for timeout or console input.
          CLA                 ; A = 0.
          LDAB/     NUMACTV   ; A = number of active CRTs.
          LDB=      80        ; B = individual screen width.
          JSR/      MUL16     ; B = B * A, A = upper word of B * A.
          STB/      SCRNWIDTH ; B -> screen width.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Key configuration.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
KEYCONFIG STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
KCPRINT   JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DC        'ENTER CRT NUMBER> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDB=      (X'80'*256)+'0' ; BU = ASCII mask; load ASCII 0 in BL to
          SABB                ; convert the ASCII to the CRT number.
          BM        KCPRINT   ; If less than 0 entered, loop around.
          CLR       X         ; 0 -> X.
          XFRB      BL,XL     ; BL -> XL. Copy the CRT number.
          LDAB=     MAXCRTS-1 ; AL = max CRT number.
          SABB                ; AL - BL -> BL.
          BM        KCPRINT   ; If too big digit or non-digit, loop around.
          XFRB      XL,AL     ; XL -> AL. The CRT number.
          ORIB      BU,AL     ; Convert it to the digit in ASCII.
          STAB      KEYSCRT   ; Store it in the string.
KPRINT    JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF,2
          DC        'CRT'
KEYSCRT   DC        'X KEYS:'
          DW        CRLF,4
          DB        0
          LDB=      (20*256)+40 ; Row 20, column 40.
          JSR/      POSRC     ; Set cursor position.
          LDA=      KEYUP     ; A = up character array.
          ADD       X,A       ; A = pointer to up character.
          LDAB+     A         ; AL = up character.
          LDBB=     X'80'     ; BL = high bit.
          ORIB      BL,AL     ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (21*256)+38 ; Row 21, column 38.
          JSR/      POSRC     ; Set cursor position.
          LDA=      KEYLEFT   ; A = left character array.
          ADD       X,A       ; A = pointer to left character.
          LDAB+     A         ; AL = left character.
          LDBB=     X'80'     ; BL = high bit.
          ORIB      BL,AL     ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (21*256)+42 ; Row 21, column 42.
          JSR/      POSRC     ; Set cursor position.
          LDA=      KEYRIGHT  ; A = right character array.
          ADD       X,A       ; A = pointer to right character.
          LDAB+     A         ; AL = right character.
          LDBB=     X'80'     ; BL = high bit.
          ORIB      BL,AL     ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (22*256)+40 ; Row 22, column 40.
          JSR/      POSRC     ; Set cursor position.
          LDA=      KEYDOWN   ; A = down character array.
          ADD       X,A       ; A = pointer to down character.
          LDAB+     A         ; AL = down character.
          LDBB=     X'80'     ; BL = high bit.
          ORIB      BL,AL     ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (23*256)+0 ; Row 23, column 0.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'ENTER    UP KEY'
          DB        0
          LDB=      (20*256)+40 ; Row 20, column 40.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     X'7F'     ; BL = mask out high bit.
          ANDB      BL,AL     ; Clear high bit on character.
          LDB=      KEYUP     ; B = up character array.
          ADD       X,B       ; B = pointer to up character.
          STAB+     B         ; Store the up keycode.
          LDB=      (23*256)+7 ; Row 23, column 7.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'LEFT'
          DB        0
          LDB=      (21*256)+38 ; Row 21, column 38.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     X'7F'     ; BL = mask out high bit.
          ANDB      BL,AL     ; Clear high bit on character.
          LDB=      KEYLEFT   ; B = left character array.
          ADD       X,B       ; B = pointer to left character.
          STAB+     B         ; Store the left character.
          LDB=      (23*256)+6 ; Row 23, column 6.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'RIGHT'
          DB        0
          LDB=      (21*256)+42 ; Row 21, column 42.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     X'7F'     ; BL = mask out high bit.
          ANDB      BL,AL     ; Clear high bit on character.
          LDB=      KEYRIGHT  ; B = right character array.
          ADD       X,B       ; B = pointer to right character.
          STAB+     B         ; Store the right character.
          LDB=      (23*256)+6 ; Row 23, column 6.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        ' DOWN'
          DB        0
          LDB=      (22*256)+40 ; Row 22, column 40.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     X'7F'     ; BL = mask out high bit.
          ANDB      BL,AL     ; Clear high bit on character.
          LDB=      KEYDOWN   ; B = down character array.
          ADD       X,B       ; B = pointer to down character.
          STAB+     B         ; Store the down character.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Speed configuration.
* A = keycode/tmp.
* B = comparison/tmp.
SPDCONFIG STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          LDAB=     10        ; AL = base speed.
          LDBB/     GAMESPEED ; BL = delay ticks.
          SABB                ; BL = AL - BL, the speed.
          LDAB=     '0'       ; AL = ASCII zero base.
          AABB                ; BL = speed character.
          STBB      CURRSPD   ; BL -> speed string.
          JSR/      PRINTNULL ; Print the current speed.
          DW        CRLF
          DC        'CURRENT SPEED: '
CURRSPD   DB        0,2
SCPRINT   JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DC        'ENTER SPEED (1-9)> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDB=      '0'       ; Load 0 to
          SABB                ; convert the ASCII to the speed selection.
          BLE       SCPRINT   ; If <0 entered, loop.
          LDAB=     10        ; Load 10 to
          SUBB      BL,AL     ; compare against the max.
          BL        SCPRINT   ; If max or more entered, loop.
          LDAB=     10        ; AL = base speed.
          SABB                ; BL = AL - BL, the delay ticks.
          STBB/     GAMESPEED ; BL -> game speed.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Start CNAKE code.
*
* External symbols used by CNAKE.
          EXT       MVUSS     ; Copies a string to another string (OSLIB).
*
* Print the game name.
GAMENAME  JSR/      PRINTNULL ; Print.
 DC '                        -###             #######@'
 DW CRLF
 DC '                           #  CNAKE 1.3  #'
 DW CRLF
 DC '                           #     ON      #'
 DW CRLF
 DC '                           #  GOS-5 0.6  #'
 DW CRLF
 DC '                           ###############'
 DW CRLF
 DB 0
          RSR                 ; Return.
*
* Run the game. Clobbers all except X.
GAMEOVER  DC        'GAME OVER'
YOUWON    DC        'YOU WON!!'
RUNGAME   STX-      S-        ; Push X to the stack.
          LDA=      3         ; A = 3.
          STA/      GAMESCORE ; Start the score at 3, the initial snake length.
          JSR/      DRAWBORDR ; Clear and draw top/bottom.
          JSR/      INITBOARD ; Initialize the game board.
RGLOOP1   LDAB/     GAMESPEED ; AL = game speed delay.
          JSR/      SELECT    ; Wait for the delay or input.
          BZ        RGMOVE    ; If timeout hit, just move the snake.
          JSR/      HANDLEKEY ; If not timeout, handle the key pressed.
RGMOVE    JSR/      MOVESNAKE ; Move the snake.
          BL        RGLOOP1   ; Keep going until L cleared.
          LDA/      GAMESCORE ; A = score.
          LDB=      MAXSNAKE  ; B = max score.
          SAB                 ; Compare to max score.
          BZ        RGWON     ; If equal, set the you-won message.
          LDA=      9         ; A = length of target string.
          LDB=      9         ; B = length of source string.
          JSR/      MVUSS     ; Set the game-over text.
          DW        RGMSG
          DW        GAMEOVER
          JMP       RGPRINT   ; Go to printing it.
RGWON     LDA=      9         ; A = length of target string.
          LDB=      9         ; B = length of source string.
          JSR/      MVUSS     ; Set the you-won text.
          DW        RGMSG
          DW        YOUWON    
RGPRINT   LDX=      ACTVCRTS  ; X = active CRT table.
          CLA                 ; A = 0.
          LDB=      BOTLEFT   ; B = bottom left.
RGLOOP2   LDAB+     X+        ; AL = next active CRT; X = next entry.
          BM        RGDONE    ; If <0, no more active CRTs.
          JSR/      SETCRT    ; Set the CRT as active.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the game over message.
          DC        ' ',36
RGMSG     DB        0,9
          DC        ' ',23
          DB        0
          JMP       RGLOOP2   ; Loop for the next CRT.
RGDONE    LDAB=     127       ; AL = max delay.
          JSR/      SELECT    ; Wait for the delay or input.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Clear the screen and draw the borders on each CRT. Clobbers all except X.
DRAWBORDR STX-      S-        ; Push X to the stack.
          CLA                 ; A = 0.
          LDX=      ACTVCRTS  ; X = active CRT table.
          CLRB      YL        ; YL = 0.
          INRB      YL        ; YL = 1.
DBLOOP    LDAB+     X+        ; AL = next active CRT; X = next entry.
          BP        DBGOOD    ; If valid, draw the borders.
          JMP/      DBDONE    ; If <0, no more active CRTs.
DBGOOD    JSR/      SETCRT    ; Set the CRT as active.
          JSR/      CLRS      ; Clear the screen.
          JSR/      PRINTNULL ; Print the top border.
          DC        '*',80
          DB        0
          DCRB      YL        ; YL = YL - 1.
          BM        DBBOTTOM  ; If <0, do not draw the left border.
          LDBB=     22        ; BL = 22 (rows).
DBLEFT    JSR/      PRINTNULL ; Print the border.
          DC        '*'
          DW        CRLF
          DB        0
          DCRB      BL        ; BL = BL - 1.
          BGZ       DBLEFT    ; If more rows, loop.
DBBOTTOM  LDB=      BOTLEFT   ; B = bottom left.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the bottom border.
          DC        '*',68
          DC        ' SCORE:   3'
          DB        0
          JMP/      DBLOOP    ; Loop for the next CRT.
DBDONE    LDB=      (22*256)+79 ; Row 22, column 79.
          LDAB=     '*'       ; AL = border character.
DBRIGHT   JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTONE  ; Print the character.
          DCRB      BU        ; BU = BU - 1 (previous row).
          BGZ       DBRIGHT   ; Branch if more rows.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Game data.
MOVELEFT  EQU       B'0001'   ; Movement in left direction.
MOVERIGHT EQU       B'0010'   ; Movement in right direction.
MOVEUP    EQU       B'0100'   ; Movement in up direction.
MOVEDOWN  EQU       B'1000'   ; Movement in down direction.
MAXSNAKE  EQU       128       ; Maximum snake length.
SCOREPOS  EQU       (23*256)+76 ; Score position: row 23, column 76.
TAILCHARS DC        '--| |'   ; Tail characters for next seg. direction.
SNAKERC   DW        0,MAXSNAKE ; Snake segment row/column table.
SNAKEDIR  DB        0,MAXSNAKE ; Dir. of next segment; for head, movement dir.
FOODRC    DW        0         ; Food row/column.
*
* Initialize the game board with the snake and initial food. Clobbers all
* except X.
INITSNAKE DW        X'3003'
          DW        X'3004'
          DW        X'3005'
INITBOARD STX-      S-        ; Push X to the stack.
          CLA                 ; A = 0.
          LDB=      ACTVCRTS  ; B = active CRT table.
          LDAB+     B         ; AL = active CRT.
          JSR/      SETCRT    ; Set the CRT as active.
          LDA=      6         ; A = length of target string.
          LDB=      6         ; A = length of source string.
          JSR/      MVUSS     ; Set initial snake rows/cols.
          DW        SNAKERC
          DW        INITSNAKE
          LDA=      3         ; A = length.
          LDB=      SNAKEDIR  ; B = string.
          JSR/      MVSSF     ; Set initial snake directions.
          DB        MOVERIGHT
          LDB=      (12*256)+3 ; B = tail position: row 12, column 3.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the snake.
          DC        '-#@'
          DB        0
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          JSR/      NEWFOOD   ; Create new food.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Handle the keypress in AL. Clobbers all except X.
HANDLEKEY STX-      S-        ; Push X to the stack.
          LDX=      SNAKEDIR  ; X = snake direction table.
          LDB/      GAMESCORE ; B = game score = snake length.
          ADD       B,X       ; X = one past the head direction.
          LDBB/     CKLEFT    ; BL = key for left.
          SABB                ; BL = AL - BL.
          BNZ       HKRIGHT   ; If no match, try right.
          LDBB=     MOVELEFT  ; BL = left.
          JMP       HKSET     ; Set the direction.
HKRIGHT   LDBB/     CKRIGHT   ; BL = key for right.
          SABB                ; BL = AL - BL.
          BNZ       HKUP      ; If no match, try up.
          LDBB=     MOVERIGHT ; BL = right.
          JMP       HKSET     ; Set the direction.
HKUP      LDBB/     CKUP      ; BL = key for up.
          SABB                ; BL = AL - BL.
          BNZ       HKDOWN    ; If no match, try down.
          LDBB=     MOVEUP    ; BL = up.
          JMP       HKSET     ; Set the direction.
HKDOWN    LDBB/     CKDOWN    ; BL = key for down.
          SABB                ; BL = AL - BL.
          BNZ       HKDONE    ; If no match, nothing to do.
          LDBB=     MOVEDOWN  ; BL = down.
HKSET     STBB-     X-        ; Store the direction for the head.
HKDONE    LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Move the snake to the next location. Sets L if the game is still active;
* clears L if the max length is reached or the snake dies. Clobbers all
* except X.
MOVESNAKE STX-      S-        ; Push X to the stack.
          LDA=      SNAKEDIR  ; A = snake direction table.
          XAZ                 ; Z = snake direction table.
          LDA/      GAMESCORE ; A = game score = snake length.
          SLA                 ; A = A << 1. A = offset of one past head row/col.
          XAY                 ; A -> Y.
          LDX=      SNAKERC   ; X = snake row/column table.
          ADD       Y,X       ; X = one past snake head row/col pointer.
          LDB-      X-        ; X = pointer to head row/col; B = head row/col.
          SRR       Y         ; Y = Y >> 1. Y = offset of one past head dir.
          ADD       Y,Z       ; Z = one past snake head direction pointer.
          LDAB-     Z-        ; Z = pointer to head direction; AL = head dir.
          SRAB                ; A = A >> 1.
          BNL       MSRIGHT   ; If not left, try right.
          DCR       B         ; Subtract one from the column.
          JMP       MSFOOD    ; Check if food is there.
MSRIGHT   SRAB                ; A = A >> 1.
          BNL       MSUP      ; If not right, try up.
          INR       B         ; Add one to the column.
          JMP       MSFOOD    ; Check if food is there.
MSUP      SRAB                ; A = A >> 1.
          BNL       MSDOWN    ; If not up, it must be down.
          LDA=      RNEG1     ; Row-1.
          ADD       A,B       ; Subtract one from the row.
          JMP       MSFOOD    ; Check if food is there.
MSDOWN    LDA=      RMULW     ; Row+1.
          ADD       A,B       ; Add one to the row.
MSFOOD    LDA/      FOODRC    ; A = food row/column.
          SUB       B,A       ; A = B - A.
          BNZ       MSLBRDR   ; If not food, check if left border.
          XFR       X,Y       ; X -> Y.
          JSR/      EATFOOD   ; Eat the food.
          LDA=      MAXSNAKE  ; A = max snake size.
          LDB/      GAMESCORE ; B = score.
          SAB                 ; B = A - B.
          BNZ       MSFRET    ; Link is set, continue the game.
          RL                  ; Clear link because max score hit.
MSFRET    JMP/      MSDONE    ; Done.
MSLBRDR   LDA=      COLMASK   ; Column mask.
          XAZ                 ; Z = column mask.
          AND       B,Z       ; Z = column.
          BNZ       MSRBRDR   ; If not left border, check if right border.
          RL                  ; Clear link because left border hit.
          JMP/      MSDONE    ; Done.
MSRBRDR   LDA/      SCRNWIDTH ; A = screen width.
          DCA                 ; A = A - 1. A = right border column.
          SUB       Z,A       ; A = Z - A.
          BNZ       MSTBRDR   ; If not right border, check if top border.
          RL                  ; Clear link because right border hit.
          JMP/      MSDONE    ; Done.
MSTBRDR   XFR       B,Z       ; B -> Z.
          SRR       Z,RSHFTW  ; Z = row.
          BNZ       MSBBRDR   ; If not top border, check if bottom border.
          RL                  ; Clear link because top border hit.
          JMP       MSDONE    ; Done.
MSBBRDR   LDAB=     23        ; AL = 23, the bottom border row.
          SUBB      ZL,AL     ; AL = ZL - AL.
          BNZ       MSSELF    ; If not bottom border, check if hit self.
          RL                  ; Clear link because bottom border hit.
          JMP       MSDONE    ; Done.
MSSELF    JSR/      SNAKEHIT  ; Check if the new head loc hits self.
          BNL       MSMOVE    ; If not self, finally move.
          RL                  ; Clear link because self hit.
          JMP       MSDONE    ; Done.
MSMOVE    XFR       B,Y       ; B (new head row/col) -> Y.
          LDB/      SNAKERC   ; B = snake tail row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on tail.
          LDAB=     ' '       ; AL = space.
          JSR/      PRINTONE  ; Clear the old tail.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          LDA/      GAMESCORE ; A = game score = snake length.
          DCA                 ; A = A - 1.
          SLA                 ; A = A << 1, the length of the positions.
          JSR/      MVFR      ; Move all snake positions over one.
          DW        SNAKERC
          DW        SNAKERC+2
          SRA                 ; A = A >> 1.
          JSR/      MVFR      ; Move all snake directions over one.
          DW        SNAKEDIR
          DW        SNAKEDIR+1
          LDB/      SNAKERC   ; B = snake tail row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on tail.
          CLA                 ; A = 0.
          LDAB/     SNAKEDIR  ; A = snake tail direction to segment.
          SRA                 ; A = A >> 1.
          LDB=      TAILCHARS ; B = tail characters table.
          AAB                 ; B = A + B.
          LDAB+     B         ; AL = tail character to use.
          JSR/      PRINTONE  ; Draw the tail.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          XFR       Y,B       ; Y (new head row/col) -> B.
          STB+      X         ; Store new head row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on new head.
          LDAB=     '@'       ; AL = @.
          JSR/      PRINTONE  ; Draw the new head.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          LDB-      X-        ; X = pointer to 1st seg row/col; B = seg row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on old head.
          LDAB=     '#'       ; AL = #.
          JSR/      PRINTONE  ; Draw the new 1st segment.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          SL                  ; Keep playing.
MSDONE    LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Eat the food. B = food location, Y = current head row/col pointer, Z =
* current head direction pointer. Clobbers all except X.
EATFOOD   STX-      S-        ; Push X to the stack.
          LDAB+     Z+        ; AL = curr head dir; Z = new head dir pointer.
          STAB+     Z         ; Store the direction for the new head.
          LDX+      Y+        ; X = curr head row/col; Y = new head row/col ptr.
          STB+      Y         ; Store the new head row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on new head.
          LDAB=     '@'       ; AL = @.
          JSR/      PRINTONE  ; Draw the new head.
          XFR       X,B       ; B = old head row/col.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position cursor on new head.
          LDAB=     '#'       ; AL = #.
          JSR/      PRINTONE  ; Draw the new segment.
          LDA/      GAMESCORE ; A = game score.
          INA                 ; A = A + 1.
          STA/      GAMESCORE ; Store new score.
          JSR/      DEC16     ; Convert score to decimal.
          DB        ' '       ; Pad with spaces.
          DW        3         ; String length = 3.
          DW        EFSCORE   ; String address.
          LDB=      SCOREPOS  ; B = score row/col.
          LDX=      ACTVCRTS  ; X = active CRT table.
          CLA                 ; A = 0.
EFLOOP    LDAB+     X+        ; AL = next active CRT; X = next entry.
          BM        EFDONE    ; If <0, no more active CRTs.
          JSR/      SETCRT    ; Set the CRT as active.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the new score.
EFSCORE   DB        0,4   
          JMP       EFLOOP    ; Loop for the next CRT.
EFDONE    JSR       NEWFOOD   ; Create new food.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Detect a snake hit. The row/column in B is compared against all snake
* parts and L is set if there is a hit or cleared if not.
* A = tmp.
* B = row/column to compare.
* X = pointer to snake row/col.
* Y = offset in snake.
SNAKEHIT  STA-      S-        ; Push A to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
          LDA/      GAMESCORE ; A = game score = snake length.
          SLA                 ; A = A << 1. A = offset of one past head row/col.
          XAY                 ; A -> Y.
          LDX=      SNAKERC   ; X = snake row/column table.
          ADD       Y,X       ; X = one past snake head row/col pointer.
SHCMP     LDA-      X-        ; X = pointer to next row/col; A = next row/col.
          SUB       B,A       ; Compare food and snake position.
          BZ        SHDONE    ; If equal, signal a hit; link is set.
          DCR       Y,2       ; Y = Y - 2.
          BGZ       SHCMP     ; If >0, check the next snake position.
          RL                  ; Clear the link flag - all positions checked ok.
SHDONE    LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Create new food.
* A = tmp.
* B = tmp.
* X = tmp.
* Y = tmp.
NEWFOOD   STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Push Y
          STA-      S-        ; to the stack.
NFRAND    JSR/      RAND      ; Get a random number.
          LDX=      RCMASK    ; X = row+column mask.
          AND       B,X       ; X = random row+column.
          LDA=      COLMASK   ; A = column mask.
          AND       B,A       ; A = random column.
          LDB/      SCRNWIDTH ; B = screen width.
          DCR       B,2       ; B = B - 2, the width minus borders.
          JSR/      DIV16     ; A = column within limits.
          INA                 ; A = A + 1, the food column.
          XAB                 ; A -> B.
          SRR       X,RSHFTW  ; X = random row.
          STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          XFR       A,X       ; X -> A.
          LDB=      24-2      ; B = screen height minus borders.
          JSR/      DIV16     ; A = row within limits.
          XAX                 ; X = row within limits.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          INX                 ; X = X + 1, the food row.
          SLR       X,RSHFTW  ; X = encoded row.
          ORI       X,B       ; Mask in the column with the encoded row.
          JSR/      SNAKEHIT  ; Check if the food hits the snake.
          BL        NFRAND    ; If so, generate a new food position.
          STB/      FOODRC    ; B -> food row/column.
          JSR/      ADJPOSCRT ; Set correct CRT, BU=row, BL=column.
          JSR/      POSRC     ; Position the cursor at the food.
          LDAB=     '$'       ; The food symbol.
          JSR/      PRINTONE  ; Print the food.
          LDB=      BOTRGHT   ; Bottom right position.
          JSR/      POSRC     ; Move the cursor.
          LDA+      S+        ; Pop Y
          XAY                 ; from the stack.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* End of source.
          END      ENTRY      ; Set the entry point.
