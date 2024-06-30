* Centurion Snake (CPU6) by ren14500. Public domain.
* Adapted for Usagi banner by Bob Flanders. Also public domain.
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
*
* Additionally, GOS sets up interrupt handlers for the MUX, timer, and abort
* levels. All other interrupts are defaulted to simply return. Up to two MUX
* cards are supported, meaning up to 8 CRTs can be supported. Row/column
* absolute positions are encoded in words to allow up to 12 80-column CRT
* widths, though the 8 CRT limit due to MUX card support takes precedence. The
* encoding is 0RRRRRCCCCCCCCCC.
*
* Start of source.
          TITLE     'USAGI1'
ZCNAKE6   BEGIN     X'0100'
*
* MUX Status byte laytout
MXRXDI    EQU       B'00000001' ; .... ...1 Recieve data available
MXTXEM    EQU       B'00000010' ; .... ..1. Transmit buffer empty
MXPER     EQU       B'00000100' ; .... .1.. Parity misatch error
MXFRER    EQU       B'00001000' ; .... 1... Framing error
MXOVRE    EQU       B'00100000' ; ...1 .... Receive overrun
MXCTS     EQU       B'00100000' ; ..1. .... Clear to send 

******************************************************************
** Uncommeont the appropriate line for real machine or Emulator **
******************************************************************
*TRMRDY    EQU       MXTXEM    ; Use this for real machine (Transmit Buffer Empty
TRMRDY    EQU       MXCTS     ; Use this for Emulator (Clear To Send) 
*
* Entry point.
ENTRY     XFR=      X'F000',S ; Set the stack pointer to just below MMIO.
          JSR       INITINT   ; Initialize interrupts.
REENTRY   JSR/      WELALL    ; Print the welcome screen(s).
          JSR/      WELMENU   ; Handle the welcome screen menu.
          JMP       REENTRY   ; Restart.
*
* Simple linear congruential random number generator. Returns the next random
* number in B.
RANDA     EQU       30303
RANDSEED  DW        0         ; Current seed value.
RAND      LDB       RANDSEED  ; B = current seed value.
          MUL=      RANDA,B   ; B = B * random multiplier.
          INR       B         ; B = B + 1.
          STB       RANDSEED  ; Store the new seed value.
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
          XFR=      MUXBUFF,Y ; Y = address of MUX buffer.
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
INITINT   STK       X,2       ; Push X to the stack.
          CLA                 ; A = 0 (page map 0).
          LDB=      DEFINT    ; B = address of default interrupt handler.
          LDX=      X'001C'   ; X = interrupt level 1 C register.
          XFR=      X'010C',Y ; Y = one set of registers past the end.
II1       STA+      X+        ; Store A to C register, move X to P register.
          STB+      X+        ; Store B to P register, move X to next level A.
          INR       X,12      ; Move X to C register.
          XFR       X,Z       ; X -> Z.
          SUB       Y,Z       ; Z = Y - Z.
          BNZ       II1       ; Loop if not equal.
          LDA=      MUXINT    ; A = address of MUX interrupt handler.
          SAR       MUXLVL,P  ; A -> MUX level P register.
          CLR       A,MUXLVL  ; A = MUX interrupt level.
          STAB/     X'F20A'   ; Set interrupt level in MUX0.
          STAB/     X'F21A'   ; Set interrupt level in MUX1.
          STAB/     X'F20E'   ; Enable MUX0 interrupts (value of AL irrelevant).
          STAB/     X'F21E'   ; Enable MUX1 interrupts (value of AL irrelevant).
          LDA=      TIMERINT  ; A = address of timer interrupt handler.
          SAR       TIMERLVL,P ; A -> timer level P register.
          LDA=      ABORTINT  ; A = address of abort interrupt handler.
          SAR       ABORTLVL,P ; A -> abort level P register.
          POP       X,2       ; Pop X from the stack.
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
SELECT    STK       B,2       ; Push B to the stack.
          DI                  ; Disable interrupts.
          DCK                 ; Disable clock.
          SAR       TIMERLVL,Z ; A -> timer level Z (the time until interrupt).
          LDA=      SELTIMINT ; A = timer interrupt handler.
          SAR       TIMERLVL,P ; A -> timer level P register.
          SAR       TIMERLVL,A ; A -> timer level A (some non-0 value).
          ECK                 ; Enable clock.
          EI                  ; Enable interrupts.
          LDA=      MUXBUFF   ; A = MUX buffer.
          LDB       CURRCRT   ; B = Current CRT#.
          AAB                 ; B = A + B. B = address of curr CRT MUX buffer.
SELLOOP   LDAB+     B         ; AL = curr CRT character.
          BNZ       SELCHAR   ; If not 0, there is a character pending.
          LAR       TIMERLVL,A ; Timer level A -> A.
          XFR       A,A       ; A -> A.
          BNZ       SELLOOP   ; Loop if timer not expired.
          JMP       SELDONE   ; If expired, A = 0 and we are done.
SELCHAR   XFRB      AL,AU     ; AL -> AU.
          CLAB                ; AL = 0.
          SAR       TIMERLVL,Z ; Zero the timer level ZL - back to normal.
          XFRB      AU,AL     ; AU -> AL.
SELDONE   FIL       (MAXCRTS)=0,/MUXBUFF ; Clear all pending key presses.
          POP       B,2       ; Pop B from the stack.
          RSR                 ; Return.
*
* Current CRT information.
CURRCRT   DW        0         ; Current CRT number.
CURRCOFF  DW        0         ; Offset into termcap function tables.
CURRMUX   DW        MUX0      ; MMIO base for current MUX.
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
BEEP      STK       A,2       ; Push A to the stack.
          LDA=      TCBEEP    ; A = address of beep function table.
          ADD/      CURRCOFF,A ; A = address of beep function pointer.
          JSR+      *A        ; Call the handler.
          POP       A,2       ; Pop A from the stack.
          RSR                 ; Return.
*
* Clear the screen of the current CRT.
* A = function table pointer.
CLRS      STK       A,2       ; Push A to the stack.
          LDA=      TCCLRS    ; A = address of clear screen function table.
          ADD/      CURRCOFF,A ; A = address of clear screen function pointer.
          JSR+      *A        ; Call the handler.
          POP       A,2       ; Pop A from the stack.
          RSR                 ; Return.
*
* Position the cursor of the current CRT. The row/col must be in BU/BL.
* A = function table pointer.
POSRC     STK       A,2       ; Push A to the stack.
          LDA=      TCPOSRC   ; A = address of position function table.
          ADD/      CURRCOFF,A ; A = address of position function pointer.
          JSR+      *A        ; Call the handler.
          POP       A,2       ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the character in AL to the current CRT.
* A = Character.
* B = MUX status.
* Y = MUX status mask.
* Z = MUX base address.
PRINTONE  STK       B,2       ; Push B to the stack.
          STK       Y,4       ; Push Y,Z to the stack.
          XFR=      TRMRDY,Y  ; Set mask to check for transmit buffer empty.
          XFR/      CURRMUX,Z ; Z = MMIO base address of MUX port.
POWAIT    LDBB+     Z,MUXSTCT ; BL = MUX status byte.
          ANDB      YL,BL     ; Check if transmit buffer empty.
          BZ        POWAIT    ; If not empty, loop.
          STAB+     Z,MUXDATA ; Store the character to the MUX data.
          POP       Y,4       ; Pop Z,Y from the stack.
          POP       B,2       ; Pop B from the stack.
          RSR                 ; Return.
*
* Print the null-terminated string at X to the current CRT.
* A = MUX status.
* B = Next character.
* X = RSR target.
* Y = MUX status mask.
* Z = MUX base address.
PRINTNULL STK       A,4       ; Push A,B to the stack.
          STK       Y,4       ; Push Y,Z to the stack.
          XFR=      TRMRDY,Y  ; Set mask to check for transmit buffer empty.
          XFR/      CURRMUX,Z ; Z = MMIO base address of MUX port.
PNLOOP    LDBB+     X+        ; Load the next byte.
          BZ        PNEND     ; If 0, we are done.
PNWAIT    LDAB+     Z,MUXSTCT ; AL = MUX status byte.
          ANDB      YL,AL     ; Check if transmit buffer empty.
          BZ        PNWAIT    ; If not empty, loop.
          STBB+     Z,MUXDATA ; Store the character to the MUX data.
          JMP       PNLOOP    ; Go to the next character.
PNEND     POP       Y,4       ; Pop Z,Y from the stack.
          POP       A,4       ; Pop B,A from the stack.
          RSR                 ; Return.
*
* Wait for a keypress from the current CRT after clearing any pending key
* presses from all CRTs. The keycode (with high bit set) is returned in AL. It
* is also echoed back to the CRT.
GKCURR    STK       B,2       ; Push B to the stack.
          FIL       (MAXCRTS)=0,/MUXBUFF ; Clear the pending key presses.
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
          POP       B,2       ; Pop B from the stack.
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
GKANY     STK       B,8       ; Push B,X,Y,Z to the stack.
          FIL       (MAXCRTS)=0,/MUXBUFF ; Clear the pending key presses.
          XFR=      MAXCRTS,Y ; Y = CRT count.
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
          POP       B,8       ; Pop Z,Y,X,B from the stack.
          RSR                 ; Return.
*
* Given the CRT number in A, update A to the MUX port MMIO base address.
MUXADDR   STK       B,4       ; Push B,X to the stack.
          XAB                 ; A -> B.
          XAX                 ; A -> X.
          SRR       B,2       ; B = B / 4 = which MUX card.
          SLR       B,4       ; B = B * 16 = address offset from MUX0.
          AND=      B'11',X   ; X = X % 4 = which port on the card.
          SLR       X         ; X = X * 2 = address offset from port 0.
          LDA=      MUX0      ; A = first MUX card address.
          ADD       X,A       ; A = address of CRT MUX card.
          ADD       B,A       ; A = base address of CRT port on MUX card.
          POP       B,4       ; Pop X,B from the stack.
          RSR
*
* ADDS/ADM/VT100 beep implementation.
ADDSBEEP
ADMBEEP
VT1BEEP   STK       A,2       ; Push A.
          LDAB=     X'87'     ; Bell.
          JSR/      PRINTONE  ; Print the character.
          POP       A,2       ; Pop A.
          RSR                 ; Return.
*
* ADDS clear screen implementation.
ADDSCLRS  STK       A,2       ; Push A.
          LDAB=     X'8C'     ; Form feed.
          JSR/      PRINTONE  ; Print the character.
          POP       A,2       ; Pop A.
          RSR                 ; Return.
*
* ADM clear screen implementation.
ADMCLRS   STK       A,2       ; Push A.
          LDAB=     X'9A'     ; SUB (Control-Z).
          JSR/      PRINTONE  ; Print the character.
          POP       A,2       ; Pop A.
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
ADDSPOSRC STK       B,2       ; Push B to the stack.
          ADD=      ADDSRC,B  ; Create the characters for the row/col.
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
          POP       B,2       ; Pop B from the stack.
          DLY                 ; Delay to let the terminal process the request.
          RSR                 ; Return.
*
* ADM position row/col implementation.
ADMRC     EQU       '  '      ; 0,0 is at ASCII space,space.
ADMPOSRC  STK       B,2       ; Push B to the stack.
          ADD=      ADMRC,B   ; Create the characters for the row/col.
          STBB      ADMPCOL   ; Store BL as the column.
          XFRB      BU,BL     ; Move the row to BL.
          STBB      ADMPROW   ; Store BL as the row.
          JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        '='
ADMPROW   DB        0         ; Row.
ADMPCOL   DB        0         ; Column.
          DB        0         ; Null terminator.
          POP       B,2       ; Pop B from the stack.
          DLY                 ; Delay to let the terminal process the request.
          DLY                 ; Delay to let the terminal process the request.
          RSR                 ; Return.
*
* VT100 position row/col implementation.
VT1POSRC  STK       A,4       ; Push A,B to the stack.
          MVF       (2)='#@',/VT1PROW ; Set row template.
          MVF       (2)='#@',/VT1PCOL ; Set column template.
          ADD=      X'0101',B ; Make row/column 1-based.
VT1PRC    STB=      0         ; Save the row and column.
          CLRB      AL,2      ; AL = 2 (length of string).
          LDBB=     '0'       ; BL = ASCII zero (padding byte).
          CFB       /VT1PROW(10),/VT1PRC+1(1) ; Convert row to decimal.
          CLRB      AL,2      ; AL = 2 (length of string).
          LDBB=     '0'       ; BL = ASCII zero (padding byte).
          CFB       /VT1PCOL(10),/VT1PRC+2(1) ; Convert column to decimal.
          JSR/      PRINTNULL ; Print the following string.
          DB        X'9B'     ; Escape.
          DC        '['       ; CSI.
VT1PROW   DW        0         ; Row.
          DC        ';'
VT1PCOL   DW        0         ; Column.
          DC        'H'
          DB        0         ; Null terminator.
          POP       A,4       ; Pop B,A from the stack.
          RSR                 ; Return.
*
* Set the current CRT information for the CRT number in A.
SETCRT    STK       A,2       ; Push A to the stack.
          STA/      CURRCRT   ; Store the CRT number.
          SLA                 ; A << 1, the offset into the function table.
          STA/      CURRCOFF  ; Store the CRT function table offset.
          ADD=      TCMMIO,A  ; Offset into the MUX table.
          LDA+      A         ; Get the MUX address.
          STA/      CURRMUX   ; Store the MUX address.
          LDA=      KEYLEFT   ; A = left key table.
          ADD-      S,0,A     ; Add the offset for this CRT number.
          LDAB+     A         ; A = left key for this CRT.
          STAB/     CKLEFT    ; A -> current left key.
          LDA=      KEYRIGHT  ; A = right key table.
          ADD-      S,0,A     ; Add the offset for this CRT number.
          LDAB+     A         ; A = right key for this CRT.
          STAB/     CKRIGHT   ; A -> current right key.
          LDA=      KEYUP     ; A = up key table.
          ADD-      S,0,A     ; Add the offset for this CRT number.
          LDAB+     A         ; A = up key for this CRT.
          STAB/     CKUP      ; A -> current up key.
          LDA=      KEYDOWN   ; A = down key table.
          ADD-      S,0,A     ; Add the offset for this CRT number.
          LDAB+     A         ; A = down key for this CRT.
          STAB/     CKDOWN    ; A -> current down key.
          POP       A,2       ; Pop A from the stack.
          RSR                 ; Return.
*
* Adjust the absolute position in B to a CRT-relative row in BU and column in
* BL. Sets the apprpriate CRT as active based on the absolute column number.
* A = CRT number.
* B = row/column.
* X = column on CRT.
* Y = CRT index.
ADJPOSCRT STK       A,2       ; Push A to the stack.
          STK       X,4       ; Push X,Y to the stack.
          AND=      COLMASK,B,X ; Mask out row leaving only column in X.
          DIV=      80,X      ; X = X % 80; Y = X / 80.
          SRRB      BU,RSHFTB ; BU = row.
          XFRB      XL,BL     ; XL -> BL; BL = column on CRT.
          LDX=      ACTVCRTS  ; X = active CRT table.
          ADD       Y,X       ; X = X + Y; X = pointer to active CRT number.
          CLA                 ; A = 0.
          LDAB+     X         ; AL = active CRT number.
          JSR       SETCRT    ; Set the CRT as active.
          POP       X,4       ; Pop Y,X from the stack.
          POP       A,2       ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the welcome screen on all configured CRTs.
* A = CRT number.
* B = Table pointer.
* X = Table value.
* Y = CRT count.
* Z = Temporary.
WELALL    STK       A,10      ; Push A,B,X,Y,Z to the stack.
          CLA                 ; A = first CRT number.
          LDB=      TCMMIO    ; B = pointer to configured MUX table.
          XFR=      MAXCRTS,Y ; Y = CRT count.
WALOOP    LDX+      B+        ; X = MUX address; B = pointer to next.
          BZ        WANEXT    ; If 0 (not configured), skip to the next CRT.
          JSR       WELCOME   ; Print on the current CRT.
WANEXT    INA                 ; A = next CRT number.
          XAZ                 ; A -> Z.
          SUB       Y,Z       ; Y - Z -> Z. Check if we hit the max CRT.
          BNZ       WALOOP    ; If not at the max, try the next.
          POP       A,10      ; Pop Z,Y,X,B,A from the stack.
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
 DC '(S)PEED'
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
WELMENU   STK       A,4       ; Push A,B to the stack.
WMGK      JSR/      GKANY     ; Wait for a keypress from any CRT.
          AND=      .NOT.X'2020',A ; Ensure uppercase.
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
          LAR       TIMERLVL,Y ; Get the low order time word.
          STA/      RANDSEED  ; Set the random number seed.
          JSR/      RNUSAGI   ; Start the game.
          JMP       WMDONE    ; And we are done.
WMBEEP    JSR/      BEEP      ; Beep the CRT.
          JMP       WMGK      ; Get another key.
WMDONE    POP       A,4       ; Pop B,A from the stack.
          RSR                 ; Return.
*
* CRT configuration.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
* Y = baud/type.
CRTCONFIG STK       A,8       ; Push A,B,X,Y to the stack.
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
          ORI=      B'101',Y,B ; Set 7E1. B now has the MUX control byte.
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
CCDONE    POP       A,8       ; Pop Y,X,B,A from the stack.
          RSR                 ; Return.
*
* Layout CRTs.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
LAYOUTCRT STK       A,6       ; Push A,B,X to the stack.
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
          CLRB      AL,MAXCRTS ; Load max CRT count to
          SUBB      BL,AL     ; compare against the max.
          BL        LCDONE    ; If max or more entered, done.
          LDA=      ACTVCRTS  ; A = pointer to active CRT table.
          ADD       X,A       ; A = pointer to current table entry.
          STBB+     A         ; BL -> current table entry.
          INX                 ; X = X + 1.
          CLRB      AL,MAXCRTS ; Load max CRT count to
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
          FIL       (MAXCRTS+1)=1,-X ; NOP the show string.
LCCOPY    LDBB+     A+        ; BL = next entry; A = A + 1.
          BM        LCSHOW    ; If negative, that is it.
          ADD=      '0',B     ; BL = ASCII CRT number.
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
          MUL       A,B       ; B = B * A.
          STB/      SCRNWIDTH ; B -> screen width.
          POP       A,6       ; Pop X,B,A from the stack.
          RSR                 ; Return.
*
* Key configuration.
* A = keycode.
* B = comparison/tmp.
* X = CRT number.
KEYCONFIG STK       A,6       ; Push A,B,X to the stack.
KCPRINT   JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF
          DC        'ENTER CRT NUMBER> '
          DB        0
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          LDBB=     '0'       ; Load ASCII 0 to
          SABB                ; convert the ASCII to the CRT number.
          BM        KCPRINT   ; If less than 0 entered, loop around.
          CLR       X         ; 0 -> X.
          XFRB      BL,XL     ; BL -> XL. Copy the CRT number.
          LDAB=     MAXCRTS-1 ; AL = max CRT number.
          SABB                ; AL - BL -> BL.
          BM        KCPRINT   ; If too big digit or non-digit, loop around.
          XFRB      XL,AL     ; XL -> AL. The CRT number.
          ORI=      X'B0',A   ; Convert it to the digit in ASCII.
          STAB      KEYSCRT   ; Store it in the string.
KPRINT    JSR/      PRINTNULL ; Print the prompt.
          DW        CRLF,2
          DC        'CRT'
KEYSCRT   DC        'X KEYS:'
          DW        CRLF,4
          DB        0
          LDB=      (20*256)+40 ; Row 20, column 40.
          JSR/      POSRC     ; Set cursor position.
          ADD=      KEYUP,X,A ; A = pointer to up character.
          LDAB+     A         ; AL = up character.
          ORI=      X'80',A   ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (21*256)+38 ; Row 21, column 38.
          JSR/      POSRC     ; Set cursor position.
          ADD=      KEYLEFT,X,A ; A = pointer to left character.
          LDAB+     A         ; AL = left character.
          ORI=      X'80',A   ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (21*256)+42 ; Row 21, column 42.
          JSR/      POSRC     ; Set cursor position.
          ADD=      KEYRIGHT,X,A ; A = pointer to right character.
          LDAB+     A         ; AL = right character.
          ORI=      X'80',A   ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (22*256)+40 ; Row 22, column 40.
          JSR/      POSRC     ; Set cursor position.
          ADD=      KEYDOWN,X,A ; A = pointer to down character.
          LDAB+     A         ; AL = down character.
          ORI=      X'80',A   ; Set high bit on character.
          JSR/      PRINTONE  ; Print the character.
          LDB=      (23*256)+0 ; Row 23, column 0.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'ENTER    UP KEY'
          DB        0
          LDB=      (20*256)+40 ; Row 20, column 40.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          AND=      X'7F',A   ; Clear high bit on character.
          ADD=      KEYUP,X,B ; B = pointer to up character.
          STAB+     B         ; Store the up keycode.
          LDB=      (23*256)+7 ; Row 23, column 7.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'LEFT'
          DB        0
          LDB=      (21*256)+38 ; Row 21, column 38.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          AND=      X'7F',A   ; Clear high bit on character.
          ADD=      KEYLEFT,X,B ; B = pointer to left character.
          STAB+     B         ; Store the left character.
          LDB=      (23*256)+6 ; Row 23, column 6.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        'RIGHT'
          DB        0
          LDB=      (21*256)+42 ; Row 21, column 42.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          AND=      X'7F',A   ; Clear high bit on character.
          ADD=      KEYRIGHT,X,B ; B = pointer to right character.
          STAB+     B         ; Store the right character.
          LDB=      (23*256)+6 ; Row 23, column 6.
          JSR/      POSRC     ; Set cursor position.
          JSR/      PRINTNULL ; Print the prompt.
          DC        ' DOWN'
          DB        0
          LDB=      (22*256)+40 ; Row 22, column 40.
          JSR/      POSRC     ; Set cursor position.
          JSR/      GKCURR    ; Wait for a keypress from the current CRT.
          AND=      X'7F',A   ; Clear high bit on character.
          ADD=      KEYDOWN,X,B ; B = pointer to down character.
          STAB+     B         ; Store the down character.
          POP       A,6       ; Pop X,B,A from the stack.
          RSR                 ; Return.
*
* Speed configuration.
* A = keycode/tmp.
* B = comparison/tmp.
SPDCONFIG STK       A,4       ; Push A,B to the stack.
          LDAB=     10        ; AL = base speed.
          LDBB/     GAMESPEED ; BL = delay ticks.
          SABB                ; BL = AL - BL, the speed.
          ADD=      '0',B     ; BL = speed character.
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
          CLRB      AL,10     ; Load 10 to
          SUBB      BL,AL     ; compare against the max.
          BL        SCPRINT   ; If max or more entered, loop.
          CLRB      AL,10     ; AL = base speed.
          SABB                ; BL = AL - BL, the delay ticks.
          STBB/     GAMESPEED ; BL -> game speed.
          POP       A,4       ; Pop B,A from the stack.
          RSR                 ; Return.
*
* Start USAGI1.
*
* Print the banner
* Print the game name.
GAMENAME  JSR/      PRINTNULL ; Print.
 DC 'Enjoy'
 DW CRLF
 DB 0
          RSR                 ; Return.
*
* Run the game. Clobbers all except X.
RNUSAGI EQU     *
        STK     X,2             ; Save the X register
        JSR/    CLRS            ; Clear the screen
DONEXT  EQU     *
        LDX     NEXT1           ; X => first entry
        LDB+    X+              ; B = Row/Column, X-> Character
        JSR/    POSRC           ; ... position the cursor
        LDAB+   X+              ; AL = Chart to print; X->Done byte
        JSR/    PRINTONE        ; ... print the Character
        LDAB=   1               ; A = 1
        STAB+   X+              ; DoneByte = 1
        STX     NEXT1           ; ... NEXT1 => Next Entry
        XFR     X,A             ; A -> Next Entry
        LDB/    ELAYOUT         ; E -> Byte after layout
        SUB     B,A             ; Q. Next at end of table?
        BNZ     DONEXT          ; A. No .. process next
        POP     X,2             ; Restore X register
        RSR                     ; Return from this routine
        
NEXT1   Dw      LAYOUT          ; NEXT1 = the next entry to display
*
LAYOUT  EQU     *
        DB      3
        DB      6
        DB      '*'
        DB      0
*
        DB      3
        DB      7
        DB      '*'
        DB      0
*
        DB      3
        DB      8
        DB      '*'
        DB      0
*
        DB      3
        DB      9
        DB      '*'
        DB      0
*
        DB      3
        DB      10
        DB      '*'
        DB      0
*
        DB      3
        DB      11
        DB      '*'
        DB      0
*
        DB      3
        DB      12
        DB      '*'
        DB      0
*
        DB      3
        DB      13
        DB      '*'
        DB      0
*
        DB      3
        DB      14
        DB      '*'
        DB      0
*
        DB      3
        DB      15
        DB      '*'
        DB      0
*
        DB      3
        DB      16
        DB      '*'
        DB      0
*
        DB      3
        DB      17
        DB      '*'
        DB      0
*
        DB      3
        DB      18
        DB      '*'
        DB      0
*
        DB      3
        DB      19
        DB      '*'
        DB      0
*
        DB      3
        DB      20
        DB      '*'
        DB      0
*
        DB      3
        DB      21
        DB      '*'
        DB      0
*
        DB      3
        DB      22
        DB      '*'
        DB      0
*
        DB      3
        DB      23
        DB      '*'
        DB      0
*
        DB      3
        DB      24
        DB      '*'
        DB      0
*
        DB      3
        DB      25
        DB      '*'
        DB      0
*
        DB      3
        DB      26
        DB      '*'
        DB      0
*
        DB      3
        DB      27
        DB      '*'
        DB      0
*
        DB      3
        DB      28
        DB      '*'
        DB      0
*
        DB      3
        DB      29
        DB      '*'
        DB      0
*
        DB      3
        DB      30
        DB      '*'
        DB      0
*
        DB      3
        DB      31
        DB      '*'
        DB      0
*
        DB      3
        DB      32
        DB      '*'
        DB      0
*
        DB      3
        DB      33
        DB      '*'
        DB      0
*
        DB      3
        DB      34
        DB      '*'
        DB      0
*
        DB      3
        DB      35
        DB      '*'
        DB      0
*
        DB      3
        DB      36
        DB      '*'
        DB      0
*
        DB      3
        DB      37
        DB      '*'
        DB      0
*
        DB      3
        DB      38
        DB      '*'
        DB      0
*
        DB      3
        DB      39
        DB      '*'
        DB      0
*
        DB      3
        DB      40
        DB      '*'
        DB      0
*
        DB      3
        DB      41
        DB      '*'
        DB      0
*
        DB      3
        DB      42
        DB      '*'
        DB      0
*
        DB      3
        DB      43
        DB      '*'
        DB      0
*
        DB      3
        DB      44
        DB      '*'
        DB      0
*
        DB      3
        DB      45
        DB      '*'
        DB      0
*
        DB      3
        DB      46
        DB      '*'
        DB      0
*
        DB      3
        DB      47
        DB      '*'
        DB      0
*
        DB      3
        DB      48
        DB      '*'
        DB      0
*
        DB      3
        DB      49
        DB      '*'
        DB      0
*
        DB      3
        DB      50
        DB      '*'
        DB      0
*
        DB      3
        DB      51
        DB      '*'
        DB      0
*
        DB      3
        DB      52
        DB      '*'
        DB      0
*
        DB      3
        DB      53
        DB      '*'
        DB      0
*
        DB      3
        DB      54
        DB      '*'
        DB      0
*
        DB      3
        DB      55
        DB      '*'
        DB      0
*
        DB      3
        DB      56
        DB      '*'
        DB      0
*
        DB      3
        DB      57
        DB      '*'
        DB      0
*
        DB      3
        DB      58
        DB      '*'
        DB      0
*
        DB      3
        DB      59
        DB      '*'
        DB      0
*
        DB      3
        DB      60
        DB      '*'
        DB      0
*
        DB      3
        DB      61
        DB      '*'
        DB      0
*
        DB      3
        DB      62
        DB      '*'
        DB      0
*
        DB      3
        DB      63
        DB      '*'
        DB      0
*
        DB      3
        DB      64
        DB      '*'
        DB      0
*
        DB      3
        DB      65
        DB      '*'
        DB      0
*
        DB      3
        DB      66
        DB      '*'
        DB      0
*
        DB      3
        DB      67
        DB      '*'
        DB      0
*
        DB      3
        DB      68
        DB      '*'
        DB      0
*
        DB      3
        DB      69
        DB      '*'
        DB      0
*
        DB      3
        DB      70
        DB      '*'
        DB      0
*
        DB      4
        DB      6
        DB      '*'
        DB      0
*
        DB      4
        DB      70
        DB      '*'
        DB      0
*
        DB      5
        DB      6
        DB      '*'
        DB      0
*
        DB      5
        DB      8
        DB      'U'
        DB      0
*
        DB      5
        DB      9
        DB      'U'
        DB      0
*
        DB      5
        DB      21
        DB      'U'
        DB      0
*
        DB      5
        DB      22
        DB      'U'
        DB      0
*
        DB      5
        DB      70
        DB      '*'
        DB      0
*
        DB      6
        DB      6
        DB      '*'
        DB      0
*
        DB      6
        DB      8
        DB      'U'
        DB      0
*
        DB      6
        DB      9
        DB      'U'
        DB      0
*
        DB      6
        DB      21
        DB      'U'
        DB      0
*
        DB      6
        DB      22
        DB      'U'
        DB      0
*
        DB      6
        DB      38
        DB      'H'
        DB      0
*
        DB      6
        DB      39
        DB      'E'
        DB      0
*
        DB      6
        DB      40
        DB      'L'
        DB      0
*
        DB      6
        DB      41
        DB      'L'
        DB      0
*
        DB      6
        DB      42
        DB      'O'
        DB      0
*
        DB      6
        DB      43
        DB      'R'
        DB      0
*
        DB      6
        DB      44
        DB      'L'
        DB      0
*
        DB      6
        DB      45
        DB      'D'
        DB      0
*
        DB      6
        DB      46
        DB      '!'
        DB      0
*
        DB      6
        DB      65
        DB      'i'
        DB      0
*
        DB      6
        DB      66
        DB      'i'
        DB      0
*
        DB      6
        DB      67
        DB      'i'
        DB      0
*
        DB      6
        DB      70
        DB      '*'
        DB      0
*
        DB      7
        DB      6
        DB      '*'
        DB      0
*
        DB      7
        DB      8
        DB      'U'
        DB      0
*
        DB      7
        DB      9
        DB      'U'
        DB      0
*
        DB      7
        DB      21
        DB      'U'
        DB      0
*
        DB      7
        DB      22
        DB      'U'
        DB      0
*
        DB      7
        DB      65
        DB      'i'
        DB      0
*
        DB      7
        DB      66
        DB      'i'
        DB      0
*
        DB      7
        DB      67
        DB      'i'
        DB      0
*
        DB      7
        DB      70
        DB      '*'
        DB      0
*
        DB      8
        DB      6
        DB      '*'
        DB      0
*
        DB      8
        DB      8
        DB      'U'
        DB      0
*
        DB      8
        DB      9
        DB      'U'
        DB      0
*
        DB      8
        DB      21
        DB      'U'
        DB      0
*
        DB      8
        DB      22
        DB      'U'
        DB      0
*
        DB      8
        DB      26
        DB      '='
        DB      0
*
        DB      8
        DB      27
        DB      '='
        DB      0
*
        DB      8
        DB      28
        DB      '='
        DB      0
*
        DB      8
        DB      29
        DB      '='
        DB      0
*
        DB      8
        DB      30
        DB      '='
        DB      0
*
        DB      8
        DB      31
        DB      '='
        DB      0
*
        DB      8
        DB      32
        DB      '='
        DB      0
*
        DB      8
        DB      33
        DB      '='
        DB      0
*
        DB      8
        DB      34
        DB      '='
        DB      0
*
        DB      8
        DB      35
        DB      '='
        DB      0
*
        DB      8
        DB      36
        DB      '='
        DB      0
*
        DB      8
        DB      37
        DB      '='
        DB      0
*
        DB      8
        DB      38
        DB      '='
        DB      0
*
        DB      8
        DB      39
        DB      '='
        DB      0
*
        DB      8
        DB      40
        DB      '='
        DB      0
*
        DB      8
        DB      41
        DB      '='
        DB      0
*
        DB      8
        DB      42
        DB      '='
        DB      0
*
        DB      8
        DB      43
        DB      '='
        DB      0
*
        DB      8
        DB      44
        DB      '='
        DB      0
*
        DB      8
        DB      45
        DB      '='
        DB      0
*
        DB      8
        DB      46
        DB      '='
        DB      0
*
        DB      8
        DB      47
        DB      '='
        DB      0
*
        DB      8
        DB      48
        DB      '='
        DB      0
*
        DB      8
        DB      49
        DB      '='
        DB      0
*
        DB      8
        DB      50
        DB      '='
        DB      0
*
        DB      8
        DB      51
        DB      '='
        DB      0
*
        DB      8
        DB      52
        DB      '='
        DB      0
*
        DB      8
        DB      53
        DB      '='
        DB      0
*
        DB      8
        DB      54
        DB      '='
        DB      0
*
        DB      8
        DB      55
        DB      '='
        DB      0
*
        DB      8
        DB      56
        DB      '='
        DB      0
*
        DB      8
        DB      57
        DB      '='
        DB      0
*
        DB      8
        DB      58
        DB      '='
        DB      0
*
        DB      8
        DB      59
        DB      '='
        DB      0
*
        DB      8
        DB      60
        DB      '='
        DB      0
*
        DB      8
        DB      61
        DB      '='
        DB      0
*
        DB      8
        DB      62
        DB      '='
        DB      0
*
        DB      8
        DB      63
        DB      '='
        DB      0
*
        DB      8
        DB      70
        DB      '*'
        DB      0
*
        DB      9
        DB      6
        DB      '*'
        DB      0
*
        DB      9
        DB      8
        DB      'U'
        DB      0
*
        DB      9
        DB      9
        DB      'U'
        DB      0
*
        DB      9
        DB      21
        DB      'U'
        DB      0
*
        DB      9
        DB      22
        DB      'U'
        DB      0
*
        DB      9
        DB      27
        DB      's'
        DB      0
*
        DB      9
        DB      28
        DB      's'
        DB      0
*
        DB      9
        DB      29
        DB      's'
        DB      0
*
        DB      9
        DB      30
        DB      's'
        DB      0
*
        DB      9
        DB      31
        DB      's'
        DB      0
*
        DB      9
        DB      32
        DB      's'
        DB      0
*
        DB      9
        DB      33
        DB      's'
        DB      0
*
        DB      9
        DB      34
        DB      's'
        DB      0
*
        DB      9
        DB      35
        DB      's'
        DB      0
*
        DB      9
        DB      40
        DB      'a'
        DB      0
*
        DB      9
        DB      41
        DB      'a'
        DB      0
*
        DB      9
        DB      42
        DB      'a'
        DB      0
*
        DB      9
        DB      43
        DB      'a'
        DB      0
*
        DB      9
        DB      44
        DB      'a'
        DB      0
*
        DB      9
        DB      45
        DB      'a'
        DB      0
*
        DB      9
        DB      46
        DB      'a'
        DB      0
*
        DB      9
        DB      47
        DB      'a'
        DB      0
*
        DB      9
        DB      48
        DB      'a'
        DB      0
*
        DB      9
        DB      53
        DB      'g'
        DB      0
*
        DB      9
        DB      54
        DB      'g'
        DB      0
*
        DB      9
        DB      55
        DB      'g'
        DB      0
*
        DB      9
        DB      56
        DB      'g'
        DB      0
*
        DB      9
        DB      57
        DB      'g'
        DB      0
*
        DB      9
        DB      58
        DB      'g'
        DB      0
*
        DB      9
        DB      59
        DB      'g'
        DB      0
*
        DB      9
        DB      60
        DB      'g'
        DB      0
*
        DB      9
        DB      61
        DB      'g'
        DB      0
*
        DB      9
        DB      65
        DB      'i'
        DB      0
*
        DB      9
        DB      66
        DB      'i'
        DB      0
*
        DB      9
        DB      67
        DB      'i'
        DB      0
*
        DB      9
        DB      70
        DB      '*'
        DB      0
*
        DB      10
        DB      6
        DB      '*'
        DB      0
*
        DB      10
        DB      8
        DB      'U'
        DB      0
*
        DB      10
        DB      9
        DB      'U'
        DB      0
*
        DB      10
        DB      21
        DB      'U'
        DB      0
*
        DB      10
        DB      22
        DB      'U'
        DB      0
*
        DB      10
        DB      26
        DB      's'
        DB      0
*
        DB      10
        DB      27
        DB      's'
        DB      0
*
        DB      10
        DB      28
        DB      's'
        DB      0
*
        DB      10
        DB      29
        DB      's'
        DB      0
*
        DB      10
        DB      30
        DB      's'
        DB      0
*
        DB      10
        DB      31
        DB      's'
        DB      0
*
        DB      10
        DB      32
        DB      's'
        DB      0
*
        DB      10
        DB      33
        DB      's'
        DB      0
*
        DB      10
        DB      34
        DB      's'
        DB      0
*
        DB      10
        DB      35
        DB      's'
        DB      0
*
        DB      10
        DB      36
        DB      's'
        DB      0
*
        DB      10
        DB      39
        DB      'a'
        DB      0
*
        DB      10
        DB      40
        DB      'a'
        DB      0
*
        DB      10
        DB      41
        DB      'a'
        DB      0
*
        DB      10
        DB      42
        DB      'a'
        DB      0
*
        DB      10
        DB      43
        DB      'a'
        DB      0
*
        DB      10
        DB      44
        DB      'a'
        DB      0
*
        DB      10
        DB      45
        DB      'a'
        DB      0
*
        DB      10
        DB      46
        DB      'a'
        DB      0
*
        DB      10
        DB      47
        DB      'a'
        DB      0
*
        DB      10
        DB      48
        DB      'a'
        DB      0
*
        DB      10
        DB      49
        DB      'a'
        DB      0
*
        DB      10
        DB      52
        DB      'g'
        DB      0
*
        DB      10
        DB      53
        DB      'g'
        DB      0
*
        DB      10
        DB      54
        DB      'g'
        DB      0
*
        DB      10
        DB      55
        DB      'g'
        DB      0
*
        DB      10
        DB      56
        DB      'g'
        DB      0
*
        DB      10
        DB      57
        DB      'g'
        DB      0
*
        DB      10
        DB      58
        DB      'g'
        DB      0
*
        DB      10
        DB      59
        DB      'g'
        DB      0
*
        DB      10
        DB      60
        DB      'g'
        DB      0
*
        DB      10
        DB      61
        DB      'g'
        DB      0
*
        DB      10
        DB      62
        DB      'g'
        DB      0
*
        DB      10
        DB      65
        DB      'i'
        DB      0
*
        DB      10
        DB      66
        DB      'i'
        DB      0
*
        DB      10
        DB      67
        DB      'i'
        DB      0
*
        DB      10
        DB      70
        DB      '*'
        DB      0
*
        DB      11
        DB      6
        DB      '*'
        DB      0
*
        DB      11
        DB      8
        DB      'U'
        DB      0
*
        DB      11
        DB      9
        DB      'U'
        DB      0
*
        DB      11
        DB      21
        DB      'U'
        DB      0
*
        DB      11
        DB      22
        DB      'U'
        DB      0
*
        DB      11
        DB      26
        DB      's'
        DB      0
*
        DB      11
        DB      27
        DB      's'
        DB      0
*
        DB      11
        DB      39
        DB      'a'
        DB      0
*
        DB      11
        DB      40
        DB      'a'
        DB      0
*
        DB      11
        DB      48
        DB      'a'
        DB      0
*
        DB      11
        DB      49
        DB      'a'
        DB      0
*
        DB      11
        DB      52
        DB      'g'
        DB      0
*
        DB      11
        DB      53
        DB      'g'
        DB      0
*
        DB      11
        DB      61
        DB      'g'
        DB      0
*
        DB      11
        DB      62
        DB      'g'
        DB      0
*
        DB      11
        DB      65
        DB      'i'
        DB      0
*
        DB      11
        DB      66
        DB      'i'
        DB      0
*
        DB      11
        DB      67
        DB      'i'
        DB      0
*
        DB      11
        DB      70
        DB      '*'
        DB      0
*
        DB      12
        DB      6
        DB      '*'
        DB      0
*
        DB      12
        DB      8
        DB      'U'
        DB      0
*
        DB      12
        DB      9
        DB      'U'
        DB      0
*
        DB      12
        DB      21
        DB      'U'
        DB      0
*
        DB      12
        DB      22
        DB      'U'
        DB      0
*
        DB      12
        DB      26
        DB      'z'
        DB      0
*
        DB      12
        DB      27
        DB      'z'
        DB      0
*
        DB      12
        DB      48
        DB      'a'
        DB      0
*
        DB      12
        DB      49
        DB      'a'
        DB      0
*
        DB      12
        DB      52
        DB      'g'
        DB      0
*
        DB      12
        DB      53
        DB      'g'
        DB      0
*
        DB      12
        DB      61
        DB      'g'
        DB      0
*
        DB      12
        DB      62
        DB      'g'
        DB      0
*
        DB      12
        DB      65
        DB      'i'
        DB      0
*
        DB      12
        DB      66
        DB      'i'
        DB      0
*
        DB      12
        DB      67
        DB      'i'
        DB      0
*
        DB      12
        DB      70
        DB      '*'
        DB      0
*
        DB      13
        DB      6
        DB      '*'
        DB      0
*
        DB      13
        DB      8
        DB      'U'
        DB      0
*
        DB      13
        DB      9
        DB      'U'
        DB      0
*
        DB      13
        DB      21
        DB      'U'
        DB      0
*
        DB      13
        DB      22
        DB      'U'
        DB      0
*
        DB      13
        DB      27
        DB      's'
        DB      0
*
        DB      13
        DB      28
        DB      's'
        DB      0
*
        DB      13
        DB      29
        DB      's'
        DB      0
*
        DB      13
        DB      30
        DB      's'
        DB      0
*
        DB      13
        DB      31
        DB      's'
        DB      0
*
        DB      13
        DB      32
        DB      's'
        DB      0
*
        DB      13
        DB      33
        DB      's'
        DB      0
*
        DB      13
        DB      34
        DB      's'
        DB      0
*
        DB      13
        DB      35
        DB      's'
        DB      0
*
        DB      13
        DB      36
        DB      's'
        DB      0
*
        DB      13
        DB      40
        DB      'a'
        DB      0
*
        DB      13
        DB      41
        DB      'a'
        DB      0
*
        DB      13
        DB      42
        DB      'a'
        DB      0
*
        DB      13
        DB      43
        DB      'a'
        DB      0
*
        DB      13
        DB      44
        DB      'a'
        DB      0
*
        DB      13
        DB      45
        DB      'a'
        DB      0
*
        DB      13
        DB      46
        DB      'a'
        DB      0
*
        DB      13
        DB      47
        DB      'a'
        DB      0
*
        DB      13
        DB      48
        DB      'a'
        DB      0
*
        DB      13
        DB      49
        DB      'a'
        DB      0
*
        DB      13
        DB      52
        DB      'g'
        DB      0
*
        DB      13
        DB      53
        DB      'g'
        DB      0
*
        DB      13
        DB      61
        DB      'g'
        DB      0
*
        DB      13
        DB      62
        DB      'g'
        DB      0
*
        DB      13
        DB      65
        DB      'i'
        DB      0
*
        DB      13
        DB      66
        DB      'i'
        DB      0
*
        DB      13
        DB      67
        DB      'i'
        DB      0
*
        DB      13
        DB      70
        DB      '*'
        DB      0
*
        DB      14
        DB      6
        DB      '*'
        DB      0
*
        DB      14
        DB      8
        DB      'U'
        DB      0
*
        DB      14
        DB      9
        DB      'U'
        DB      0
*
        DB      14
        DB      21
        DB      'U'
        DB      0
*
        DB      14
        DB      22
        DB      'U'
        DB      0
*
        DB      14
        DB      27
        DB      's'
        DB      0
*
        DB      14
        DB      28
        DB      's'
        DB      0
*
        DB      14
        DB      29
        DB      's'
        DB      0
*
        DB      14
        DB      30
        DB      's'
        DB      0
*
        DB      14
        DB      31
        DB      's'
        DB      0
*
        DB      14
        DB      32
        DB      's'
        DB      0
*
        DB      14
        DB      33
        DB      's'
        DB      0
*
        DB      14
        DB      34
        DB      's'
        DB      0
*
        DB      14
        DB      35
        DB      's'
        DB      0
*
        DB      14
        DB      36
        DB      's'
        DB      0
*
        DB      14
        DB      37
        DB      's'
        DB      0
*
        DB      14
        DB      39
        DB      'a'
        DB      0
*
        DB      14
        DB      40
        DB      'a'
        DB      0
*
        DB      14
        DB      41
        DB      'a'
        DB      0
*
        DB      14
        DB      42
        DB      'a'
        DB      0
*
        DB      14
        DB      43
        DB      'a'
        DB      0
*
        DB      14
        DB      44
        DB      'a'
        DB      0
*
        DB      14
        DB      45
        DB      'a'
        DB      0
*
        DB      14
        DB      46
        DB      'a'
        DB      0
*
        DB      14
        DB      47
        DB      'a'
        DB      0
*
        DB      14
        DB      48
        DB      'a'
        DB      0
*
        DB      14
        DB      49
        DB      'a'
        DB      0
*
        DB      14
        DB      52
        DB      'g'
        DB      0
*
        DB      14
        DB      53
        DB      'g'
        DB      0
*
        DB      14
        DB      54
        DB      'q'
        DB      0
*
        DB      14
        DB      55
        DB      'q'
        DB      0
*
        DB      14
        DB      56
        DB      'q'
        DB      0
*
        DB      14
        DB      57
        DB      'q'
        DB      0
*
        DB      14
        DB      58
        DB      'q'
        DB      0
*
        DB      14
        DB      59
        DB      'q'
        DB      0
*
        DB      14
        DB      60
        DB      'q'
        DB      0
*
        DB      14
        DB      61
        DB      'g'
        DB      0
*
        DB      14
        DB      62
        DB      'g'
        DB      0
*
        DB      14
        DB      65
        DB      'i'
        DB      0
*
        DB      14
        DB      66
        DB      'i'
        DB      0
*
        DB      14
        DB      67
        DB      'i'
        DB      0
*
        DB      14
        DB      70
        DB      '*'
        DB      0
*
        DB      15
        DB      6
        DB      '*'
        DB      0
*
        DB      15
        DB      8
        DB      'U'
        DB      0
*
        DB      15
        DB      9
        DB      'U'
        DB      0
*
        DB      15
        DB      21
        DB      'U'
        DB      0
*
        DB      15
        DB      22
        DB      'U'
        DB      0
*
        DB      15
        DB      36
        DB      's'
        DB      0
*
        DB      15
        DB      37
        DB      's'
        DB      0
*
        DB      15
        DB      39
        DB      'a'
        DB      0
*
        DB      15
        DB      40
        DB      'a'
        DB      0
*
        DB      15
        DB      48
        DB      'a'
        DB      0
*
        DB      15
        DB      49
        DB      'a'
        DB      0
*
        DB      15
        DB      53
        DB      'g'
        DB      0
*
        DB      15
        DB      54
        DB      'g'
        DB      0
*
        DB      15
        DB      55
        DB      'g'
        DB      0
*
        DB      15
        DB      56
        DB      'g'
        DB      0
*
        DB      15
        DB      57
        DB      'g'
        DB      0
*
        DB      15
        DB      58
        DB      'g'
        DB      0
*
        DB      15
        DB      59
        DB      'g'
        DB      0
*
        DB      15
        DB      60
        DB      'g'
        DB      0
*
        DB      15
        DB      61
        DB      'g'
        DB      0
*
        DB      15
        DB      62
        DB      'g'
        DB      0
*
        DB      15
        DB      65
        DB      'i'
        DB      0
*
        DB      15
        DB      66
        DB      'i'
        DB      0
*
        DB      15
        DB      67
        DB      'i'
        DB      0
*
        DB      15
        DB      70
        DB      '*'
        DB      0
*
        DB      16
        DB      6
        DB      '*'
        DB      0
*
        DB      16
        DB      9
        DB      'U'
        DB      0
*
        DB      16
        DB      10
        DB      'U'
        DB      0
*
        DB      16
        DB      11
        DB      'U'
        DB      0
*
        DB      16
        DB      12
        DB      'U'
        DB      0
*
        DB      16
        DB      13
        DB      'U'
        DB      0
*
        DB      16
        DB      14
        DB      'U'
        DB      0
*
        DB      16
        DB      15
        DB      'U'
        DB      0
*
        DB      16
        DB      16
        DB      'U'
        DB      0
*
        DB      16
        DB      17
        DB      'U'
        DB      0
*
        DB      16
        DB      18
        DB      'U'
        DB      0
*
        DB      16
        DB      19
        DB      'U'
        DB      0
*
        DB      16
        DB      20
        DB      'U'
        DB      0
*
        DB      16
        DB      21
        DB      'U'
        DB      0
*
        DB      16
        DB      26
        DB      's'
        DB      0
*
        DB      16
        DB      27
        DB      's'
        DB      0
*
        DB      16
        DB      28
        DB      's'
        DB      0
*
        DB      16
        DB      29
        DB      's'
        DB      0
*
        DB      16
        DB      30
        DB      's'
        DB      0
*
        DB      16
        DB      31
        DB      's'
        DB      0
*
        DB      16
        DB      32
        DB      's'
        DB      0
*
        DB      16
        DB      33
        DB      's'
        DB      0
*
        DB      16
        DB      34
        DB      's'
        DB      0
*
        DB      16
        DB      35
        DB      's'
        DB      0
*
        DB      16
        DB      36
        DB      's'
        DB      0
*
        DB      16
        DB      37
        DB      's'
        DB      0
*
        DB      16
        DB      39
        DB      'a'
        DB      0
*
        DB      16
        DB      40
        DB      'a'
        DB      0
*
        DB      16
        DB      41
        DB      'a'
        DB      0
*
        DB      16
        DB      42
        DB      'a'
        DB      0
*
        DB      16
        DB      43
        DB      'a'
        DB      0
*
        DB      16
        DB      44
        DB      'a'
        DB      0
*
        DB      16
        DB      45
        DB      'a'
        DB      0
*
        DB      16
        DB      46
        DB      'a'
        DB      0
*
        DB      16
        DB      47
        DB      'a'
        DB      0
*
        DB      16
        DB      48
        DB      'a'
        DB      0
*
        DB      16
        DB      49
        DB      'a'
        DB      0
*
        DB      16
        DB      61
        DB      'g'
        DB      0
*
        DB      16
        DB      62
        DB      'g'
        DB      0
*
        DB      16
        DB      65
        DB      'i'
        DB      0
*
        DB      16
        DB      66
        DB      'i'
        DB      0
*
        DB      16
        DB      67
        DB      'i'
        DB      0
*
        DB      16
        DB      70
        DB      '*'
        DB      0
*
        DB      17
        DB      6
        DB      '*'
        DB      0
*
        DB      17
        DB      10
        DB      'U'
        DB      0
*
        DB      17
        DB      11
        DB      'U'
        DB      0
*
        DB      17
        DB      12
        DB      'U'
        DB      0
*
        DB      17
        DB      13
        DB      'U'
        DB      0
*
        DB      17
        DB      14
        DB      'U'
        DB      0
*
        DB      17
        DB      15
        DB      'U'
        DB      0
*
        DB      17
        DB      16
        DB      'U'
        DB      0
*
        DB      17
        DB      17
        DB      'U'
        DB      0
*
        DB      17
        DB      18
        DB      'U'
        DB      0
*
        DB      17
        DB      19
        DB      'U'
        DB      0
*
        DB      17
        DB      20
        DB      'U'
        DB      0
*
        DB      17
        DB      27
        DB      's'
        DB      0
*
        DB      17
        DB      28
        DB      's'
        DB      0
*
        DB      17
        DB      29
        DB      's'
        DB      0
*
        DB      17
        DB      30
        DB      's'
        DB      0
*
        DB      17
        DB      31
        DB      's'
        DB      0
*
        DB      17
        DB      32
        DB      's'
        DB      0
*
        DB      17
        DB      33
        DB      's'
        DB      0
*
        DB      17
        DB      34
        DB      's'
        DB      0
*
        DB      17
        DB      35
        DB      's'
        DB      0
*
        DB      17
        DB      36
        DB      's'
        DB      0
*
        DB      17
        DB      40
        DB      'a'
        DB      0
*
        DB      17
        DB      41
        DB      'a'
        DB      0
*
        DB      17
        DB      42
        DB      'a'
        DB      0
*
        DB      17
        DB      43
        DB      'a'
        DB      0
*
        DB      17
        DB      44
        DB      'a'
        DB      0
*
        DB      17
        DB      45
        DB      'a'
        DB      0
*
        DB      17
        DB      46
        DB      'a'
        DB      0
*
        DB      17
        DB      47
        DB      'a'
        DB      0
*
        DB      17
        DB      61
        DB      'g'
        DB      0
*
        DB      17
        DB      62
        DB      'g'
        DB      0
*
        DB      17
        DB      65
        DB      'i'
        DB      0
*
        DB      17
        DB      66
        DB      'i'
        DB      0
*
        DB      17
        DB      67
        DB      'i'
        DB      0
*
        DB      17
        DB      70
        DB      '*'
        DB      0
*
        DB      18
        DB      6
        DB      '*'
        DB      0
*
        DB      18
        DB      8
        DB      '='
        DB      0
*
        DB      18
        DB      9
        DB      '='
        DB      0
*
        DB      18
        DB      10
        DB      '='
        DB      0
*
        DB      18
        DB      11
        DB      '='
        DB      0
*
        DB      18
        DB      12
        DB      '='
        DB      0
*
        DB      18
        DB      13
        DB      '='
        DB      0
*
        DB      18
        DB      14
        DB      '='
        DB      0
*
        DB      18
        DB      15
        DB      '='
        DB      0
*
        DB      18
        DB      16
        DB      '='
        DB      0
*
        DB      18
        DB      17
        DB      '='
        DB      0
*
        DB      18
        DB      18
        DB      '='
        DB      0
*
        DB      18
        DB      19
        DB      '='
        DB      0
*
        DB      18
        DB      20
        DB      '='
        DB      0
*
        DB      18
        DB      21
        DB      '='
        DB      0
*
        DB      18
        DB      22
        DB      '='
        DB      0
*
        DB      18
        DB      23
        DB      '='
        DB      0
*
        DB      18
        DB      24
        DB      '='
        DB      0
*
        DB      18
        DB      25
        DB      '='
        DB      0
*
        DB      18
        DB      26
        DB      '='
        DB      0
*
        DB      18
        DB      27
        DB      '='
        DB      0
*
        DB      18
        DB      28
        DB      '='
        DB      0
*
        DB      18
        DB      29
        DB      '='
        DB      0
*
        DB      18
        DB      30
        DB      '='
        DB      0
*
        DB      18
        DB      31
        DB      '='
        DB      0
*
        DB      18
        DB      32
        DB      '='
        DB      0
*
        DB      18
        DB      33
        DB      '='
        DB      0
*
        DB      18
        DB      34
        DB      '='
        DB      0
*
        DB      18
        DB      35
        DB      '='
        DB      0
*
        DB      18
        DB      36
        DB      '='
        DB      0
*
        DB      18
        DB      37
        DB      '='
        DB      0
*
        DB      18
        DB      38
        DB      '='
        DB      0
*
        DB      18
        DB      39
        DB      '='
        DB      0
*
        DB      18
        DB      40
        DB      '='
        DB      0
*
        DB      18
        DB      41
        DB      '='
        DB      0
*
        DB      18
        DB      42
        DB      '='
        DB      0
*
        DB      18
        DB      43
        DB      '='
        DB      0
*
        DB      18
        DB      44
        DB      '='
        DB      0
*
        DB      18
        DB      45
        DB      '='
        DB      0
*
        DB      18
        DB      46
        DB      '='
        DB      0
*
        DB      18
        DB      47
        DB      '='
        DB      0
*
        DB      18
        DB      48
        DB      '='
        DB      0
*
        DB      18
        DB      49
        DB      '='
        DB      0
*
        DB      18
        DB      52
        DB      'g'
        DB      0
*
        DB      18
        DB      53
        DB      'g'
        DB      0
*
        DB      18
        DB      61
        DB      'g'
        DB      0
*
        DB      18
        DB      62
        DB      'g'
        DB      0
*
        DB      18
        DB      70
        DB      '*'
        DB      0
*
        DB      19
        DB      6
        DB      '*'
        DB      0
*
        DB      19
        DB      53
        DB      'g'
        DB      0
*
        DB      19
        DB      54
        DB      'g'
        DB      0
*
        DB      19
        DB      55
        DB      'g'
        DB      0
*
        DB      19
        DB      56
        DB      'g'
        DB      0
*
        DB      19
        DB      57
        DB      'g'
        DB      0
*
        DB      19
        DB      58
        DB      'g'
        DB      0
*
        DB      19
        DB      59
        DB      'g'
        DB      0
*
        DB      19
        DB      60
        DB      'g'
        DB      0
*
        DB      19
        DB      61
        DB      'g'
        DB      0
*
        DB      19
        DB      70
        DB      '*'
        DB      0
*
        DB      20
        DB      6
        DB      '*'
        DB      0
*
        DB      20
        DB      70
        DB      '*'
        DB      0
*
        DB      21
        DB      6
        DB      '*'
        DB      0
*
        DB      21
        DB      7
        DB      '*'
        DB      0
*
        DB      21
        DB      8
        DB      '*'
        DB      0
*
        DB      21
        DB      9
        DB      '*'
        DB      0
*
        DB      21
        DB      10
        DB      '*'
        DB      0
*
        DB      21
        DB      11
        DB      '*'
        DB      0
*
        DB      21
        DB      12
        DB      '*'
        DB      0
*
        DB      21
        DB      13
        DB      '*'
        DB      0
*
        DB      21
        DB      14
        DB      '*'
        DB      0
*
        DB      21
        DB      15
        DB      '*'
        DB      0
*
        DB      21
        DB      16
        DB      '*'
        DB      0
*
        DB      21
        DB      17
        DB      '*'
        DB      0
*
        DB      21
        DB      18
        DB      '*'
        DB      0
*
        DB      21
        DB      19
        DB      '*'
        DB      0
*
        DB      21
        DB      20
        DB      '*'
        DB      0
*
        DB      21
        DB      21
        DB      '*'
        DB      0
*
        DB      21
        DB      22
        DB      '*'
        DB      0
*
        DB      21
        DB      23
        DB      '*'
        DB      0
*
        DB      21
        DB      24
        DB      '*'
        DB      0
*
        DB      21
        DB      25
        DB      '*'
        DB      0
*
        DB      21
        DB      26
        DB      '*'
        DB      0
*
        DB      21
        DB      27
        DB      '*'
        DB      0
*
        DB      21
        DB      28
        DB      '*'
        DB      0
*
        DB      21
        DB      29
        DB      '*'
        DB      0
*
        DB      21
        DB      30
        DB      '*'
        DB      0
*
        DB      21
        DB      31
        DB      '*'
        DB      0
*
        DB      21
        DB      32
        DB      '*'
        DB      0
*
        DB      21
        DB      33
        DB      '*'
        DB      0
*
        DB      21
        DB      34
        DB      '*'
        DB      0
*
        DB      21
        DB      35
        DB      '*'
        DB      0
*
        DB      21
        DB      36
        DB      '*'
        DB      0
*
        DB      21
        DB      37
        DB      '*'
        DB      0
*
        DB      21
        DB      38
        DB      '*'
        DB      0
*
        DB      21
        DB      39
        DB      '*'
        DB      0
*
        DB      21
        DB      40
        DB      '*'
        DB      0
*
        DB      21
        DB      41
        DB      '*'
        DB      0
*
        DB      21
        DB      42
        DB      '*'
        DB      0
*
        DB      21
        DB      43
        DB      '*'
        DB      0
*
        DB      21
        DB      44
        DB      '*'
        DB      0
*
        DB      21
        DB      45
        DB      '*'
        DB      0
*
        DB      21
        DB      46
        DB      '*'
        DB      0
*
        DB      21
        DB      47
        DB      '*'
        DB      0
*
        DB      21
        DB      48
        DB      '*'
        DB      0
*
        DB      21
        DB      49
        DB      '*'
        DB      0
*
        DB      21
        DB      50
        DB      '*'
        DB      0
*
        DB      21
        DB      51
        DB      '*'
        DB      0
*
        DB      21
        DB      52
        DB      '*'
        DB      0
*
        DB      21
        DB      53
        DB      '*'
        DB      0
*
        DB      21
        DB      54
        DB      '*'
        DB      0
*
        DB      21
        DB      55
        DB      '*'
        DB      0
*
        DB      21
        DB      56
        DB      '*'
        DB      0
*
        DB      21
        DB      57
        DB      '*'
        DB      0
*
        DB      21
        DB      58
        DB      '*'
        DB      0
*
        DB      21
        DB      59
        DB      '*'
        DB      0
*
        DB      21
        DB      60
        DB      '*'
        DB      0
*
        DB      21
        DB      61
        DB      '*'
        DB      0
*
        DB      21
        DB      62
        DB      '*'
        DB      0
*
        DB      21
        DB      63
        DB      '*'
        DB      0
*
        DB      21
        DB      64
        DB      '*'
        DB      0
*
        DB      21
        DB      65
        DB      '*'
        DB      0
*
        DB      21
        DB      66
        DB      '*'
        DB      0
*
        DB      21
        DB      67
        DB      '*'
        DB      0
*
        DB      21
        DB      68
        DB      '*'
        DB      0
*
        DB      21
        DB      69
        DB      '*'
        DB      0
*
        DB      21
        DB      70
        DB      '*'
        DB      0
*
ELAYOUT EQU     *
LOLEN   EQU     (*-LAYOUT)/4
*
        END     ENTRY
