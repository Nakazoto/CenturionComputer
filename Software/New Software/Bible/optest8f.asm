* Centurion Opcode Tester (80-FF) by ren14500. Public domain.
*
* Assemble with P.ASM, hit SELECT to get to LOS and enter the executable name.
*
* Each instruction (in each addressing mode if applicable) has an example
* snippet. The special instructions may not do anything sensible, so run at
* your own risk. The snippets do not necessarily show a meaningful normal way
* to use the instruction, though most attempt to. Some (especially the extended
* addressing modes in BIGNUM and MEMBLOCK) make almost no sense at all, like
* literal->literal, but the ISA allows it, and it is classic Centurion style
* with self-modifying code.
*
* Notation in comments uses * instead of () to dereference to avoid confusion
* with parentheses used for grouping. This notation is also somewhat used in
* the assembly for indirect addressing. So "*WORD3" means the value found at the
* address labeled "WORD3". "*B" means the value found at the address held in the
* B register. "*(B+3)" means the value found at three plus the address held in
* the B register. "**B" means the value found at the address found at the
* address held in the B register. And so on - there are a lot of modes.
*
* Note that the term "string" in any comments does not mean ASCII strings that
* are human readable unless noted. It generally means any array of bytes.
*
* The CPU6-only instructions are noted when you see "CPU5 illegal start" and
* "CPU5 illegal end". Removing the instructions between those pairs will allow
* assembly with P.ASM5 (or S.ASM on a CPU5). In some cases the "CPU5 illegal
* start" includes a "JMP/ TESTILL", in which case the lines between the start/
* end should be replaced with that instruction instead for proper operation.
* All of the support code before and after the instruction snippets is CPU5-
* compatible. Thus, it is not necessarily the best way to do the same
* functionality on a CPU6 and should not be used as such.
*
* You will generally need to read the test code and then review the output
* after running the test to see what is happening as the output is generally
* terse - usually just the flags, registers, and/or memory after the operation.
* Note that the display of the P register is missing for most tests because it
* takes extra work to capture it. Wherever its value is important, it is being
* printed properly. On CPU5 it is not possible to capture it without changing
* flags, so it is not done there at all. See PRINTREGS for details.
*
* Instruction count notes:
*
* 1. Encodings that differ only in arguments beyond the opcode itself are not
*    counted as separate instructions. Most Centurion instructions are almost
*    perfectly orthogonal, so any register can be used with them, so it does
*    not make sense to count each one as a separate instruction.
* 2. Each addressing mode is counted as a separate instruction. This is in line
*    with ARM.
* 3. A CPU6 extension that does not add an addressing mode does not count as a
*    separate instruction. E.g., INRB added the ability to increment by 1-16
*    instead of just by 1. That is a single functionality still.
* 4. Conversely, adding addressing modes does count as separate instructions.
*    E.g., XFR added three addressing modes to the previous functionality of
*    register-to-register transfers, so it counts as four instructions.
* 5. Encodings that the assembler will never generate are still counted as
*    separate instructions. E.g., the indirect addressing mode with no offset
*    will always be encoded using the implicit register opcode, which is
*    shorter, instead of the indexed direct encoding.
* 6. Instruction encodings that assemble but do not actually work are noted in
*    comments but are not counted.
*
* Start of source.
          TITLE     'OPTEST8F'
ZOPTEST8F BEGIN     X'0100'
*
* Definitions.
CR        EQU       X'8D'     ; Carriage return.
CRLF      EQU       X'8D8A'   ; Carriage return and line feed.
LFNULL    EQU       X'8A00'   ; Line feed and null terminator.
*
* Entry point.
ENTRY     LDX=      32*1024   ; 32KB -> X.
          XFR       X,S       ; Set the stack pointer to 32KB.
          JSR/      PRINTNULL ; Print the welcome screen.
          DW        CRLF,2
          DC        'OPTEST CPU'
          DB        0
          JSR/      INITINT   ; Initialize interrupts.
          JSR/      CPUTYPE   ; Determine the CPU type.
          JSR/      PRINTNULL ; Print the rest of the string.
          DC        ' DETECTED'
          DW        CRLF
          DB        0
          JSR/      PRINTMENU ; Print the menu.
          JSR/      GET2HEX   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS   ; Test function table -> B.
          AAB                 ; A + B -> B.
          JSR+      *B        ; Jump to the selected function.
          JSR/      PRINTNULL ; Print the reset prompt.
          DC        'PRESS ANY KEY TO RESET> '
          DB        0
          JSR/      GETONE    ; Wait for the key press.
          JMP       ENTRY     ; Restart fresh.
*
* Values for opcode test use.
WORD0     DW        X'0102'
WORD1     DW        X'0304'
WORD2     DW        X'0506'
WORD3     DW        X'0708'
WORD4     DW        X'090A'
WORD5     DW        X'0B0C'
WORD6     DW        X'0D0E'
WORD7     DW        X'0F10'
WORD8     DW        X'1112'
WORD9     DW        X'1314'
WORDA     DW        X'1516'
WORDB     DW        X'1718'
WORD3ADDR DW        WORD3
WORD4ADDR DW        WORD4
WORD5ADDR DW        WORD5
WORD9ADDR DW        WORD9
WORDAADDR DW        WORDA
WORDBADDR DW        WORDB
BYTE0     EQU       WORD0
BYTE1     EQU       WORD0+1
BYTE2     EQU       WORD1
BYTE3     EQU       WORD1+1
BYTE4     EQU       WORD2
BYTE5     EQU       WORD2+1
BYTE6     EQU       WORD3
BYTE7     EQU       WORD3+1
BYTE8     EQU       WORD4
BYTE9     EQU       WORD4+1
BYTEA     EQU       WORD5
BYTEB     EQU       WORD5+1
BYTE3ADDR DW        BYTE3
BYTE4ADDR DW        BYTE4
BYTE5ADDR DW        BYTE5
BYTE9ADDR DW        BYTE9
BYTEAADDR DW        BYTEA
BYTEBADDR DW        BYTEB
*
* Buffer for opcode test use.
TBUFF     DB        X'FF',16  ; Initialize to all bits set.
TBUFFADDR DW        TBUFF
*
* Hex dump the first byte of the test buffer. Clobbers A and B.
HEXT1     LDAB      TBUFF     ; AL = first byte of TBUFF.
          JSR/      HEXBYTE   ; Print it.
          JSR/      PRINTNULL ; Get to a newline.
          DW        CRLF
          DB        0
          RSR                 ; Return.
*
* Hex dump the first 2 bytes of the test buffer. Clobbers A and B.
HEXT2     LDA=      TBUFF     ; A = TBUFF.
          LDB=      2/2       ; B = 1 word.
          JMP/      HBCRLF    ; Dump.
*
* Hex dump the first 16 bytes of the test buffer. Clobbers A and B.
HEXT16    LDA=      TBUFF     ; A = TBUFF.
          LDB=      16/2      ; B = 8 words.
          JMP/      HBCRLF    ; Dump.
*
* Default interrupt handler that just ignores the interrupt.
RIDEF     RI                  ; Return from interrupt.
DEFINT    JMP       RIDEF     ; Jump to the return.
*
* Abort interrupt handler.
ILL5      EQU       X'F7'     ; MVL, illegal on CPU5 but not CPU6.
ILL56     EQU       X'E7'     ; Illegal on CPU5 and CPU6.
ABORTFLAG DB        0         ; Flag set if abort occurs.
L0FLAGS   DB        0         ; Level 0 flags (VMFL) in high nibble.
AISETFLGS DB        0         ; Non-0: L0FLAGS->flags; 0: flags->L0FLAGS.
RIABORT   RI                  ; Return from interrupt.
ABORTINT  CLAB                ; AL = 0.
          INAB                ; AL = 1.
          STAB      ABORTFLAG ; Set the aborted flag.
          LDAB      AISETFLGS ; AL = AISETFLGS
          BZ        ABORTGET  ; If set not requested, done.
          LDAB      L0FLAGS   ; AL = L0FLAGS.
          STAB/     X'000C'+1 ; AL -> level 0 C register low byte high nibble.
          CLAB                ; AL = 0.
          STAB      AISETFLGS ; AL -> AISETFLGS
          STAB      ABORTFLAG ; Reset the aborted flag since we were setting.
          JMP       ABORTEND  ; Done.
ABORTGET  LDAB/     X'000C'+1 ; C register low byte -> AL.
          STAB      L0FLAGS   ; AL -> L0FLAGS.
ABORTEND  JMP       RIABORT   ; Jump to the return.
*
* Set the current CPU flags to the value in the upper nibble of AL. AL is set
* to the value at SFSAVE+1.
SETFLAGS  STAB      L0FLAGS   ; AL -> flags storage.
          LDAB=     1         ; AL = 1.
          STAB      AISETFLGS ; AL -> set flags flag.
SFSAVE    LDAB=     0         ; Load AL with saved value.
          DB        ILL56     ; Abort.
          RSR                 ; Return.
*
* Set the current CPU flags to 0.
SETFLAGS0 STAB      SFSAVE+1  ; Save AL to be restored.
          CLAB                ; AL = 0.
          JMP       SETFLAGS  ; Set the flags.
*
*                                                         CPU5 illegal start
* JMP here instead of JSR PRINTREGS to capture P properly.
PRINTREGP STK       X,2       ; Push X to the stack as if JSR did.
          STK       P,2       ; Push P to the stack before it gets changed.
*                                                         CPU5 illegal end
*
* Print all registers. Note that P is clobbered by JSR so if printing P is
* desired, a JMP instead of JSR to this subroutine must be performed. Set the
* word at PRX to the desired return address and JMP to PRINTREGP and it will
* simulate you JSRing here instead, minus the P clobber.
PRINTREGS DB        ILL56     ; Abort.
          STA-      S-        ; Push A to the stack.
*                                                         CPU5 illegal start
          LDA/      PRX       ; *PRX -> A.
          BZ        PRV       ; If P not required, go to print flags.
          LDA+      S,2       ; Get the pushed P into A.
          STA/      PRP       ; Save it for later printing..
          LDA+      S         ; Get the pushed A into A.
          STA+      S+,2      ; Move it over the pushed P and adjust stack ptr.
*                                                         CPU5 illegal end
PRV       LDAB      L0FLAGS   ; AL = flags.
          XFRB      AL,AU     ; AL -> AU.
          JSR/      PRINTNULL
          DC        'V:'
          DB        0
          SLA                 ; A <<= 1.
          BL        PRV1      ; Branch if V set.
          LDAB=     '0'       ; AL = ASCII 0.
          JSR/      PRINTONE  ; Print it.
          JMP       PRM       ; Jump to minus flag.
PRV1      LDAB=     '1'       ; AL = ASCII 1.
          JSR/      PRINTONE  ; Print it.
PRM       JSR/      PRINTNULL
          DC        ' M:'
          DB        0
          SLA                 ; A <<= 1.
          BL        PRM1      ; Branch if M set.
          LDAB=     '0'       ; AL = ASCII 0.
          JSR/      PRINTONE  ; Print it.
          JMP       PRF       ; Jump to fault flag.
PRM1      LDAB=     '1'       ; AL = ASCII 1.
          JSR/      PRINTONE  ; Print it.
PRF       JSR/      PRINTNULL
          DC        ' F:'
          DB        0
          SLA                 ; A <<= 1.
          BL        PRF1      ; Branch if F set.
          LDAB=     '0'       ; AL = ASCII 0.
          JSR/      PRINTONE  ; Print it.
          JMP       PRL       ; Jump to link flag.
PRF1      LDAB=     '1'       ; AL = ASCII 1.
          JSR/      PRINTONE  ; Print it.
PRL       JSR/      PRINTNULL
          DC        ' L:'
          DB        0
          SLA                 ; A <<= 1.
          BL        PRL1      ; Branch if L set.
          LDAB=     '0'       ; AL = ASCII 0.
          JSR/      PRINTONE  ; Print it.
          JMP       PRA       ; Jump to A.
PRL1      LDAB=     '1'       ; AL = ASCII 1.
          JSR/      PRINTONE  ; Print it.
PRA       JSR/      PRINTNULL
          DC        ' A:'
          DB        0
          LDA+      S         ; Get A back from the stack.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' B:'
          DB        0
          XFR       B,A       ; B -> A.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' X:'
          DB        0
          LDA+      S,2       ; Parent X (JSR pushed, we pushed A) -> A.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' Y:'
          DB        0
          XFR       Y,A       ; Y -> A.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' Z:'
          DB        0
          XFR       Z,A       ; Z -> A.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' S:'
          DB        0
          XFR       S,A       ; S -> A.
          INA                 ; Increment A twice for the JSR which pushed X
          INA                 ; to the stack.
          INA                 ; Increment A twice more since we pushed A at the
          INA                 ; beginning. That gives the parent S.
          JSR/      HEXWORD   ; Print it.
          JSR/      PRINTNULL
          DC        ' C:'
          DB        0
          XFR       C,A       ; C -> A.
          JSR/      HEXWORD   ; Print it.
*                                                         CPU5 illegal start
          LDA       PRX       ; *PRX -> A.
          BZ        PRDONE    ; Skip P if PRX not set.
          JSR/      PRINTNULL
          DC        ' P:'
          DB        0
          LDA       PRP       ; Saved P -> A.
          JSR/      HEXWORD   ; Print it.
          LDX       PRX       ; *PRX -> X. RSR will "return" there.
          CLA                 ; A = 0.
          STA       PRX       ; A -> *PRX.
*                                                         CPU5 illegal end
PRDONE    JSR/      PRINTNULL ; End the line.
          DW        CRLF
          DB        0
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*                                                         CPU5 illegal start
PRP       DW        0         ; Saved P.
PRX       DW        0         ; X to load for RSR or 0 for normal RSR.
*                                                         CPU5 illegal end
*
* Initialize interrupts. The default ISR is set for all levels other than the
* abort level.
INITINT   STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          STX-      S-        ; Push X to the stack.
          XFR       Y,A       ; Y -> A.
          STA-      S-        ; Push Y to the stack.
          XFR       Z,A       ; Z -> A.
          STA-      S-        ; Push Z to the stack.
          CLA                 ; A = 0 (page map 0).
          LDB=      DEFINT    ; B = address of default interrupt handler.
          LDX=      X'010C'   ; X = one set of registers past the end.
          XFR       X,Y       ; X -> Y.
          LDX=      X'001C'   ; X = interrupt level 1 C register.
II1       STA+      X+        ; Store A to C register, move X to P register.
          STB+      X         ; Store B to P register.
          XFR       X,Z       ; X -> Z.
          LDX=      14        ; X = 14.
          ADD       Z,X       ; Move X to next interrupt level C register.
          XFR       X,Z       ; X -> Z.
          SUB       Y,Z       ; Z = Y - Z.
          BNZ       II1       ; Loop if not equal.
          LDA=      ABORTINT  ; A = address of abort interrupt handler.
          STA/      X'00FE'   ; A -> abort level P register.
          LDA+      S+        ; Pop Z from the stack.
          XAZ                 ; A -> Z.
          LDA+      S+        ; Pop Y from the stack.
          XAY                 ; A -> Y.
          LDX+      S+        ; Pop X from the stack.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          EI                  ; Enable interrupts.
          RSR                 ; Return.
*
* Determine the CPU type. Attempts to use MVL to copy the ISCPU5 flag to itself
* by setting A = 0 (length 1), B = Y = ISCPU5. On CPU6 this will work and do
* nothing noticeable. On CPU5 it will trigger an abort interrupt.
ISCPU5    DB        0         ; Zero if CPU6, non-zero if CPU5.
CPUTYPE   STA-      S-        ; Push A to the stack.
          STB-      S-        ; Push B to the stack.
          XFR       Y,A       ; Y -> A.
          STA-      S-        ; Push Y to the stack.
          CLA                 ; A = 0 (MVL length = 1).
          STAB/     ABORTFLAG ; AL -> abort flag.
          LDB=      ISCPU5    ; B = address of flag (MVL from address).
          XFR       B,Y       ; B -> Y (MVL to address).
          DB        ILL5      ; An illegal opcode for CPU5 (MVL).
          LDAB/     ABORTFLAG ; Abort flag -> AL.
          STAB      ISCPU5    ; AL -> CPU5 flag.
          LDBB=     '6'       ; ASCII 6 -> BL.
          SUBB      BL,AL     ; BL - AL -> AL.
          JSR/      PRINTONE  ; Print the CPU type.
CTDONE    LDA+      S+        ; Pop Y from the stack.
          XAY                 ; A -> Y.
          LDB+      S+        ; Pop B from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Print the null-terminated string at X to the CRT.
PRINTNULL STAB-     S-        ; Push AL to the stack.
          STBB-     S-        ; Push BL to the stack.
          XFRB      YL,AL     ; YL -> AL.
          STAB-     S-        ; Push YL to the stack.
          LDAB=     B'10'     ; Set mask to check for transmit buffer empty.
          XAYB                ; AL -> YL.
PNLOOP    LDBB+     X+        ; Load the next byte.
          BZ        PNEND     ; If 0, we are done.
PNWAIT    LDAB/     X'F200'   ; AL = MUX status byte.
          ANDB      YL,AL     ; Check if transmit buffer empty.
          BZ        PNWAIT    ; If not empty, loop.
          STBB/     X'F201'   ; Store the character to the MUX data.
          JMP       PNLOOP    ; Go to the next character.
PNEND     LDAB+     S+        ; Pop YL from the stack.
          XAYB                ; AL -> YL.
          LDBB+     S+        ; Pop BL from the stack.
          LDAB+     S+        ; Pop AL from the stack.
          RSR                 ; Return.
*
* Print the buffer at A of word length B in hex. Clobbers A and B.
HEXBUFF   STX-      S-        ; Push X to the stack.
          XAX                 ; A -> X.
HBLOOP    LDA+      X+        ; (X) -> A, ++X.
          JSR       HEXWORD   ; Dump A in hex.
          LDAB=     ' '       ; AL = ASCII space.
          JSR       PRINTONE  ; Print space.
          DCR       B         ; --B.
          BNZ       HBLOOP    ; 
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Print the buffer at A of word length B in hex followed by CRLF. Clobbers A
* and B.
HBCRLF    JSR       HEXBUFF   ; Print the buffer.
HBCRLF2   JSR/      PRINTNULL ; Print the CRLF.
          DW        CRLF
          DB        0
          RSR                 ; Return.
*
* Print A in hex followed by CRLF.
HACRLF    JSR       HEXWORD   ; Print the word.
          JMP       HBCRLF2   ; Print the CRLF and return.
*
* Print AL in hex followed by CRLF.
HALCRLF   JSR       HEXBYTE   ; Print the byte.
          JMP       HBCRLF2   ; Print the CRLF and return.
*
* Print A in hex.
HEXWORD   STA-      S-        ; Push A to the stack.
          XFRB      AU,AL     ; AU -> AL.
          JSR       HEXBYTE   ; Print upper byte.
          LDA+      S+        ; Pop A from the stack.
          JMP       HEXBYTE   ; Print lower byte.
*
* Print AL in hex.
HEXBYTE   STA-      S-        ; Push A to the stack.
          STBB-     S-        ; Push BL to the stack.
          XABB                ; AL -> BL.
          CLA                 ; A = 0.
          XFRB      BL,AL     ; BL -> AL.
          SRA       ,4        ; A >>= 4.
          JSR       HEXNIBBLE ; Print the highest nibble.
          LDAB=     X'0F'     ; AL = mask for low nibble.
          ANDB      BL,AL     ; BL & AL -> AL.
          JSR       HEXNIBBLE ; Print the lowest nibble.
          LDBB+     S+        ; Pop BL from the stack.
          LDA+      S+        ; Pop A from the stack.
          RSR                 ; Return.
*
* Print AL in hex. It must be a value in the range [0,15]. Clobbers AL.
HEXNIBBLE STBB-     S-        ; Push BL to the stack.
          LDBB=     9         ; BL = 9.
          SABB                ; AL - BL -> BL.
          BGZ       HNLETTER  ; If greater than 9, branch to print a letter.
          LDBB=     '0'       ; BL = ASCII 0.
          JMP       HNPRINT   ; Jump to print.
HNLETTER  LDAB=     'A'-1     ; AL = ASCII A minus 1.
HNPRINT   ADDB      BL,AL     ; BL + AL -> AL.
          JSR       PRINTONE  ; Print it.
          LDBB+     S+        ; Pop BL from the stack.
          RSR                 ; Return.
*
* Print the character in AL to the CRT.
PRINTONE  STBB-     S-        ; Push BL to the stack.
          XFRB      YL,BL     ; YL -> BL.
          STBB-     S-        ; Push YL to the stack.
          LDBB=     B'10'     ; Set mask to check for transmit buffer empty.
          XFRB      BL,YL     ; BL -> YL.
POWAIT    LDBB/     X'F200'   ; BL = MUX status byte.
          ANDB      YL,BL     ; Check if transmit buffer empty.
          BZ        POWAIT    ; If not empty, loop.
          STAB/     X'F201'   ; Store the character to the MUX data.
          LDBB+     S+        ; Pop YL from the stack.
          XFRB      BL,YL     ; BL -> YL.
          LDBB+     S+        ; Pop BL from the stack.
          RSR                 ; Return.
*
* Get a character from the CRT. Echo it and return it in AL.
GETONE    STBB-     S-        ; Push BL to the stack.
GOWAIT    LDBB/     X'F200'   ; BL = MUX status byte.
          SRRB      BL        ; BL = BL >> 1.
          BNL       GOWAIT    ; If no character available, loop.
          LDAB/     X'F201'   ; AL = MUX data.
          LDBB=     X'80'     ; BL = high bit set.
          ORIB      BL,AL     ; AL = AL | BL.
          JSR       PRINTONE  ; Echo the character.
          LDBB+     S+        ; Pop BL from the stack.
          RSR                 ; Return.
*
* Convert a hex character to integer value. The character is in AL and the value
* is returned in AL. AL is set to negative on error.
HEX2INT   STB-      S-        ; Push B to the stack.
          LDBB=     '0'       ; Load 0 to
          SABB                ; convert the ASCII to the value.
          XFRB      BL,BU     ; BL -> BU.
          BM        H2IERROR  ; If less than 0, error.
          LDBB=     ':'       ; Load : to
          SABB                ; compare against decimal digits.
          BM        H2IEND    ; If 0-9, done.
          LDBB=     'A'       ; Load A to
          SABB                ; convert the ASCII to a hex digit > 9.
          XFRB      BL,BU     ; BL -> BU.
          BM        H2IERROR  ; If less than 0, error.
          LDBB=     'G'       ; Load G to
          SABB                ; compare against hex digits A-F.
          BP        H2IERROR  ; If G or more, error.
          LDBB=     10        ; BL = 10.
          ADDB      BL,BU     ; BL + BU -> BU.
          JMP       H2IEND    ; Successful end.
H2IERROR  LDB=      -1        ; Signal an error.
H2IEND    XFRB      BU,AL     ; BU -> AL.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Get a two-digit hex value, converted to integer, returned in A. Print a CRLF
* to get to a new line.
GET2HEX   STBB-     S-        ; Push BL to the stack.
G2H0      JSR       GETONE    ; Get a character.
          JSR       HEX2INT   ; Convert to integer.
          XFRB      AL,AL     ; AL = AL.
          BP        G2H1      ; If no error, continue.
          JSR/      PRINTNULL ; Print.
          DW        X'8788'   ; Beep and (ADDS) backspace.
          DB        0         ; Null terminator.
          JMP       G2H0      ; Get another character.
G2H1      SLAB      ,4        ; AL <<= 4.
          XFRB      AL,BL     ; AL -> BL.
G2H2      JSR       GETONE    ; Get a character.
          JSR       HEX2INT   ; Convert to integer.
          XFRB      AL,AL     ; AL = AL.
          BP        G2H3      ; If no error, continue.
          JSR/      PRINTNULL ; Print.
          DW        X'8788'   ; Beep and backspace.
          DB        0         ; Null terminator.
          JMP       G2H2      ; Get another character.
G2H3      ORIB      AL,BL     ; AL | BL -> BL.
          CLA                 ; A = 0.
          XFRB      BL,AL     ; BL -> AL.
          LDBB+     S+        ; Pop BL from the stack.
          JSR/      PRINTNULL ; Print.
          DW        CRLF
          DB        0
          RSR                 ; Return.
*
* Prompt and wait for input to continue after printing AL blank lines. Clobbers
* AL.
MORE      XFRB      AL,AL     ; AL -> AL.
          BZ        MPROMPT   ; If zero, go to print the prompt.
          JSR/      PRINTNULL ; Print a newline.
          DW        LFNULL    ; LF, null terminator.
          DCAB                ; AL = AL - 1.
          JMP       MORE      ; Loop.
MPROMPT   JSR/      PRINTNULL ; Print a prompt.
          DB        CR        ; CR only in case we are not at the beginning.
          DC        '(MORE)'
          DB        0
          JSR/      GETONE    ; Wait for keypress.
          LDAB=     CR        ; CR only to overwrite the prompt line.
          JMP/      PRINTONE  ; Print the CR.
*
* Print the main menu.
PRINTMENU JSR/      PRINTNULL ; Print menu items.
 DC '80:LDAB= 81:LDAB/ 82:LDAB$ 83:LDAB 84:LDAB* 85:LDAB+/LDAB- 86:DPE(6)'
 DW CRLF
 DC '88:A     89:B     8A:X     8B:Y    8C:Z     8D:S           8E:C      8F:P'
 DW CRLF
 DC '90:LDA=  91:LDA/  92:LDA$  93:LDA  94:LDA*  95:LDA+/LDA-   96:SOP(6)'
 DW CRLF
 DC '98:A     99:B     9A:X     9B:Y    9C:Z     9D:S           9E:C      9F:P'
 DW CRLF
 DC 'A0:STAB= A1:STAB/ A2:STAB$ A3:STAB A4:STAB* A5:STAB+/STAB- A6:SEP(6)'
 DW CRLF
 DC 'A8:A     A9:B     AA:X     AB:Y    AC:Z     AD:S           AE:C      AF:P'
 DW CRLF
 DC 'B0:STA=  B1:STA/  B2:STA$  B3:STA  B4:STA*  B5:STA+/STA-   B6:ECK(6)'
 DW CRLF
 DC 'B8:A     B9:B     BA:X     BB:Y    BC:Z     BD:S           BE:C      BF:P'
 DW CRLF
 DC 'C0:LDBB= C1:LDBB/ C2:LDBB$ C3:LDBB C4:LDBB* C5:LDBB+/LDBB- C6:DCK(6)'
 DW CRLF
 DC 'C8:A     C9:B     CA:X     CB:Y    CC:Z     CD:S           CE:C      CF:P'
 DW CRLF
 DC 'D0:LDB=  D1:LDB/  D2:LDB$  D3:LDB  D4:LDB*  D5:LDB+/LDB-   D6:STR(6) D7:SAR(6)'
 DW CRLF
 DC 'D8:A     D9:B     DA:X     DB:Y    DC:Z     DD:S           DE:C      DF:P'
 DW CRLF
 DC 'E0:STBB= E1:STBB/ E2:STBB$ E3:STBB E4:STBB* E5:STBB+/STBB- E6:LAR(6)'
 DW CRLF
 DC 'E8:A     E9:B     EA:X     EB:Y    EC:Z     ED:S           EE:C      EF:P'
 DW CRLF
 DC 'F0:STB=  F1:STB/  F2:STB$  F3:STB  F4:STB*  F5:STB+/STB-   F6:MMIO(6) F7:MVL(6) '
 DC 'F8:A     F9:B     FA:X     FB:Y    FC:Z     FD:S           FE:C      FF:P'
 DW CRLF
 DC 'ENTER SELECTION> '
 DB 0
          RSR                 ; Return.
*
* The table of opcode tests.
OPTESTS   DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TEST80
          DW        TEST81
          DW        TEST82
          DW        TEST83
          DW        TEST84
          DW        TEST85
          DW        TEST86
          DW        TESTILL
          DW        TEST88
          DW        TEST89
          DW        TEST8A
          DW        TEST8B
          DW        TEST8C
          DW        TEST8D
          DW        TEST8E
          DW        TEST8F
          DW        TEST90
          DW        TEST91
          DW        TEST92
          DW        TEST93
          DW        TEST94
          DW        TEST95
          DW        TEST96
          DW        TESTILL
          DW        TEST98
          DW        TEST99
          DW        TEST9A
          DW        TEST9B
          DW        TEST9C
          DW        TEST9D
          DW        TEST9E
          DW        TEST9F
          DW        TESTA0
          DW        TESTA1
          DW        TESTA2
          DW        TESTA3
          DW        TESTA4
          DW        TESTA5
          DW        TESTA6
          DW        TESTILL
          DW        TESTA8
          DW        TESTA9
          DW        TESTAA
          DW        TESTAB
          DW        TESTAC
          DW        TESTAD
          DW        TESTAE
          DW        TESTAF
          DW        TESTB0
          DW        TESTB1
          DW        TESTB2
          DW        TESTB3
          DW        TESTB4
          DW        TESTB5
          DW        TESTB6
          DW        TESTILL
          DW        TESTB8
          DW        TESTB9
          DW        TESTBA
          DW        TESTBB
          DW        TESTBC
          DW        TESTBD
          DW        TESTBE
          DW        TESTBF
          DW        TESTC0
          DW        TESTC1
          DW        TESTC2
          DW        TESTC3
          DW        TESTC4
          DW        TESTC5
          DW        TESTC6
          DW        TESTILL
          DW        TESTC8
          DW        TESTC9
          DW        TESTCA
          DW        TESTCB
          DW        TESTCC
          DW        TESTCD
          DW        TESTCE
          DW        TESTCF
          DW        TESTD0
          DW        TESTD1
          DW        TESTD2
          DW        TESTD3
          DW        TESTD4
          DW        TESTD5
          DW        TESTD6
          DW        TESTD7
          DW        TESTD8
          DW        TESTD9
          DW        TESTDA
          DW        TESTDB
          DW        TESTDC
          DW        TESTDD
          DW        TESTDE
          DW        TESTDF
          DW        TESTE0
          DW        TESTE1
          DW        TESTE2
          DW        TESTE3
          DW        TESTE4
          DW        TESTE5
          DW        TESTE6
          DW        TESTILL
          DW        TESTE8
          DW        TESTE9
          DW        TESTEA
          DW        TESTEB
          DW        TESTEC
          DW        TESTED
          DW        TESTEE
          DW        TESTEF
          DW        TESTF0
          DW        TESTF1
          DW        TESTF2
          DW        TESTF3
          DW        TESTF4
          DW        TESTF5
          DW        TESTF6
          DW        TESTF7
          DW        TESTF8
          DW        TESTF9
          DW        TESTFA
          DW        TESTFB
          DW        TESTFC
          DW        TESTFD
          DW        TESTFE
          DW        TESTFF
*
* Illegal opcode function.
TESTILL   JSR/      PRINTNULL
          DC        'ILLEGAL OPCODE'
          DW        CRLF
          DB        0
          RSR                 ; Return.
*
* Test LDAB=.
* Load AL with the immediate byte argument. Flags are set according to the value
* loaded.
TEST80    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 160
*                                                         CPU6 instruction # 924
T80       LDAB=     -1        ; -1 -> AL.
*                                                         CPU5 instruction # 160
*                                                         CPU6 instruction # 924
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB/.
* Load AL with the direct-addressed byte at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST81    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 161
*                                                         CPU6 instruction # 925
T81       LDAB/     BYTE0     ; *BYTE0 -> AL.
*                                                         CPU5 instruction # 161
*                                                         CPU6 instruction # 925
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB$.
* Load AL with the indirect-addressed byte at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST82    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 162
*                                                         CPU6 instruction # 926
          LDAB$     BYTE3ADDR ; **BYTE3ADDR -> AL.
*                                                         CPU5 instruction # 162
*                                                         CPU6 instruction # 926
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB.
* Load AL with the relative-addressed byte at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value loaded.
TEST83    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 163
*                                                         CPU6 instruction # 927
          LDAB      T80+1     ; *(T80+1) -> AL.
*                                                         CPU5 instruction # 163
*                                                         CPU6 instruction # 927
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB*.
* Load AL with the relative-indirect-addressed byte at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value loaded.
TEST84    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 164
*                                                         CPU6 instruction # 928
          LDAB*     T81+1     ; **(T81+1) -> AL.
*                                                         CPU5 instruction # 164
*                                                         CPU6 instruction # 928
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB-.
* Load AL using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the byte to load.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by one after using it as the address of the
*   byte to load.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by one before using it as the address of the
*   byte to load.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   byte to load.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This loads the byte just as for indexed-indirect
*   (II), then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then loads the
*   byte just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the byte to load.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This loads the
*   byte just as for indexed-displaced (ID), then increments the register by
*   one.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by one, then loads the byte just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   byte to load.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This loads the byte just as for indexed-displaced-indirect
*   (IDI), then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then loads the byte just
*   as for indexed-displaced-indirect (IDI).
*
* The indexed (I) mode will always get encoded as one of the implicit register
* LDABs (88-8F) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register LDABs (88-8F) for actual syntax.
TEST85    LDB=      BYTE0     ; B = BYTE0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 165
*                                                         CPU6 instruction # 929
          DW        X'8520'    ; *B -> AL (I). [alternate encoding of LDAB+ B]
*                                                         CPU5 instruction # 165
*                                                         CPU6 instruction # 929
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE1     ; B = BYTE1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 166
*                                                         CPU6 instruction # 930
          LDAB+     B+        ; *B -> AL; B+1 -> B (IPI).
*                                                         CPU5 instruction # 166
*                                                         CPU6 instruction # 930
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE2+1   ; B = one past BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 167
*                                                         CPU6 instruction # 931
          LDAB-     B-        ; B-1 -> B; *B -> AL (IPD).
*                                                         CPU5 instruction # 167
*                                                         CPU6 instruction # 931
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE3ADDR ; B = BYTE3ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 168
*                                                         CPU6 instruction # 932
          LDAB+     *B        ; **B -> AL (II).
*                                                         CPU5 instruction # 168
*                                                         CPU6 instruction # 932
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE4ADDR ; B = BYTE4ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 169
*                                                         CPU6 instruction # 933
          LDAB+     *B+       ; **B -> AL; B+2 -> B (IIPI).
*                                                         CPU5 instruction # 169
*                                                         CPU6 instruction # 933
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE5ADDR+2 ; B = two past BYTE5ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 170
*                                                         CPU6 instruction # 934
          LDAB-     *B-       ; B-2 -> B; **B -> AL (IIPD).
*                                                         CPU5 instruction # 170
*                                                         CPU6 instruction # 934
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE6-3   ; B = three before BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 171
*                                                         CPU6 instruction # 935
          LDAB+     B,3       ; *(B+3) -> AL (ID).
*                                                         CPU5 instruction # 171
*                                                         CPU6 instruction # 935
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE7-5   ; B = five before BYTE7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 172
*                                                         CPU6 instruction # 936
          LDAB+     B+,5      ; *(B+5) -> AL; B+1 -> B (IDPI).
*                                                         CPU5 instruction # 172
*                                                         CPU6 instruction # 936
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE8-3   ; B = three before BYTE8.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 173
*                                                         CPU6 instruction # 937
          LDAB-     B-,4      ; B-1 -> B; *(B+4) -> AL (IDPD).
*                                                         CPU5 instruction # 173
*                                                         CPU6 instruction # 937
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTE9ADDR-3 ; B = three before BYTE9ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 174
*                                                         CPU6 instruction # 938
          LDAB+     *B,3      ; **(B+3) -> AL (IDI).
*                                                         CPU5 instruction # 174
*                                                         CPU6 instruction # 938
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTEAADDR+1 ; B = one past BYTEAADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 175
*                                                         CPU6 instruction # 939
          LDAB+     *B+,-1    ; **(B-1) -> AL; B+2 -> B (IDIPI).
*                                                         CPU5 instruction # 175
*                                                         CPU6 instruction # 939
          JSR/      PRINTREGS ; Print the registers.
          LDB=      BYTEBADDR-1 ; B = one before BYTEBADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 176
*                                                         CPU6 instruction # 940
          LDAB-     *B-,3     ; B-2 -> B; **(B+3) -> AL (IDIPD).
*                                                         CPU5 instruction # 176
*                                                         CPU6 instruction # 940
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DPE.
* Disable parity error.
TEST86
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 941
          DPE                 ; Disable parity error.
*                                                         CPU6 instruction # 941
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test LDAB+/LDAB- implicit A.
* Load AL using register A whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST88    LDA=      BYTE0     ; A = BYTE0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 177
*                                                         CPU6 instruction # 942
          LDAB+     A         ; *A -> AL.
*                                                         CPU5 instruction # 177
*                                                         CPU6 instruction # 942
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit B.
* Load AL using register B whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST89    LDB=      BYTE1     ; B = BYTE1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 178
*                                                         CPU6 instruction # 943
          LDAB+     B         ; *B -> AL.
*                                                         CPU5 instruction # 178
*                                                         CPU6 instruction # 943
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit X.
* Load AL using register X whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8A    STX-      S-        ; Push X to the stack.
          LDX=      BYTE2     ; X = BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 179
*                                                         CPU6 instruction # 944
          LDAB+     X         ; *X -> AL.
*                                                         CPU5 instruction # 179
*                                                         CPU6 instruction # 944
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit Y.
* Load AL using register Y whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8B    LDA=      BYTE3     ; A = BYTE3.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 180
*                                                         CPU6 instruction # 945
          LDAB+     Y         ; *Y -> AL.
*                                                         CPU5 instruction # 180
*                                                         CPU6 instruction # 945
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit Z.
* Load AL using register Z whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8C    LDA=      BYTE4     ; A = BYTE4.
          XAZ                 ; A -> Z.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 181
*                                                         CPU6 instruction # 946
          LDAB+     Z         ; *Z -> AL.
*                                                         CPU5 instruction # 181
*                                                         CPU6 instruction # 946
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit S.
* Load AL using register S whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8D    XFR       S,Z       ; S -> Z.
          LDA=      BYTE5     ; A = BYTE5.
          JSR/      SETFLAGS0 ; Reset flags.
          XAS                 ; A -> S.
*                                                         CPU5 instruction # 182
*                                                         CPU6 instruction # 947
          LDAB+     S         ; *S -> AL.
*                                                         CPU5 instruction # 182
*                                                         CPU6 instruction # 947
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit C.
* Load AL using register C whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8E    XFR       C,Z       ; C -> Z.
          LDA=      BYTE6     ; A = BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 183
*                                                         CPU6 instruction # 948
          LDAB+     C         ; *C -> AL.
*                                                         CPU5 instruction # 183
*                                                         CPU6 instruction # 948
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDAB+/LDAB- implicit P.
* Load AL using register P whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST8F    LDA=      BYTE7     ; A = BYTE7.
*                                                         CPU5 illegal start
          LDB=      T8FDONE   ; B = T8FDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 184
*                                                         CPU6 instruction # 949
          LDAB+     P         ; *P -> AL.
*                                                         CPU5 instruction # 184
*                                                         CPU6 instruction # 949
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
T8FDONE   RSR                 ; Return.
*
* Test LDA=.
* Load A with the immediate word argument. Flags are set according to the value
* loaded.
TEST90    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 185
*                                                         CPU6 instruction # 950
T90       LDA=      -1        ; -1 -> A.
*                                                         CPU5 instruction # 185
*                                                         CPU6 instruction # 950
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA/.
* Load A with the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST91    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 186
*                                                         CPU6 instruction # 951
T91       LDA/      WORD0     ; *WORD0 -> A.
*                                                         CPU5 instruction # 186
*                                                         CPU6 instruction # 951
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA$.
* Load A with the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST92    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 187
*                                                         CPU6 instruction # 952
          LDA$      WORD3ADDR ; **WORD0ADDR -> A.
*                                                         CPU5 instruction # 187
*                                                         CPU6 instruction # 952
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA.
* Load A with the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value loaded.
TEST93    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 188
*                                                         CPU6 instruction # 953
          LDA       T90+1     ; *(T90+1) -> A.
*                                                         CPU5 instruction # 188
*                                                         CPU6 instruction # 953
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA*.
* Load A with the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value loaded.
TEST94    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 189
*                                                         CPU6 instruction # 954
          LDA*      T91+1     ; **(T91+1) -> A.
*                                                         CPU5 instruction # 189
*                                                         CPU6 instruction # 954
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA-.
* Load A using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the word to load.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address of the
*   word to load.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address of the
*   word to load.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   word to load.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This loads the word just as for indexed-indirect
*   (II), then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then loads the
*   word just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to load.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This loads the
*   word just as for indexed-displaced (ID), then increments the register by
*   two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then loads the word just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   word to load.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This loads the word just as for indexed-displaced-indirect
*   (IDI), then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then loads the word just
*   as for indexed-displaced-indirect (IDI).
*
* The indexed (I) mode will always get encoded as one of the implicit register
* LDAs (98-9F) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register LDAs (98-9F) for actual syntax.
TEST95    LDB=      WORD0     ; B = WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 190
*                                                         CPU6 instruction # 955
          DW        X'9520'    ; *B -> A (I). [alternate encoding of LDA+ B]
*                                                         CPU5 instruction # 190
*                                                         CPU6 instruction # 955
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD1     ; B = WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 191
*                                                         CPU6 instruction # 956
          LDA+      B+        ; *B -> A; B+2 -> B (IPI).
*                                                         CPU5 instruction # 191
*                                                         CPU6 instruction # 956
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD2+2   ; B = two past WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 192
*                                                         CPU6 instruction # 957
          LDA-      B-        ; B-2 -> B; *B -> A (IPD).
*                                                         CPU5 instruction # 192
*                                                         CPU6 instruction # 957
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3ADDR ; B = WORD3ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 193
*                                                         CPU6 instruction # 958
          LDA+      *B        ; **B -> A (II).
*                                                         CPU5 instruction # 193
*                                                         CPU6 instruction # 958
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD4ADDR ; B = WORD4ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 194
*                                                         CPU6 instruction # 959
          LDA+      *B+       ; **B -> A; B+2 -> B (IIPI).
*                                                         CPU5 instruction # 194
*                                                         CPU6 instruction # 959
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD5ADDR+2 ; B = two past WORD5ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 195
*                                                         CPU6 instruction # 960
          LDA-      *B-       ; B-2 -> B; **B -> A (IIPD).
*                                                         CPU5 instruction # 195
*                                                         CPU6 instruction # 960
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD6-3   ; B = three before WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 196
*                                                         CPU6 instruction # 961
          LDA+      B,3       ; *(B+3) -> A (ID).
*                                                         CPU5 instruction # 196
*                                                         CPU6 instruction # 961
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD7-5   ; B = five before WORD7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 197
*                                                         CPU6 instruction # 962
          LDA+      B+,5      ; *(B+5) -> A; B+2 -> B (IDPI).
*                                                         CPU5 instruction # 197
*                                                         CPU6 instruction # 962
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD8-2   ; B = two before WORD8.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 198
*                                                         CPU6 instruction # 963
          LDA-      B-,4      ; B-2 -> B; *(B+4) -> A (IDPD).
*                                                         CPU5 instruction # 198
*                                                         CPU6 instruction # 963
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD9ADDR-3 ; B = three before WORD9ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 199
*                                                         CPU6 instruction # 964
          LDA+      *B,3      ; **(B+3) -> A (IDI).
*                                                         CPU5 instruction # 199
*                                                         CPU6 instruction # 964
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORDAADDR+1 ; B = one past WORDAADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 200
*                                                         CPU6 instruction # 965
          LDA+      *B+,-1    ; **(B-1) -> A; B+2 -> B (IDIPI).
*                                                         CPU5 instruction # 200
*                                                         CPU6 instruction # 965
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORDBADDR-1 ; B = one before WORDBADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 201
*                                                         CPU6 instruction # 966
          LDA-      *B-,3     ; B-2 -> B; **(B+3) -> A (IDIPD).
*                                                         CPU5 instruction # 201
*                                                         CPU6 instruction # 966
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SOP.
* Set odd parity.
TEST96
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 967
          SOP                 ; Set odd parity.
*                                                         CPU6 instruction # 967
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test LDA+/LDA- implicit A.
* Load A using register A whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST98    LDA=      WORD0     ; A = WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 202
*                                                         CPU6 instruction # 968
          LDA+      A         ; *A -> A.
*                                                         CPU5 instruction # 202
*                                                         CPU6 instruction # 968
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit B.
* Load A using register B whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST99    LDB=      WORD1     ; B = WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 203
*                                                         CPU6 instruction # 969
          LDA+      B         ; *B -> A.
*                                                         CPU5 instruction # 203
*                                                         CPU6 instruction # 969
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit X.
* Load A using register X whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9A    STX-      S-        ; Push X to the stack.
          LDX=      WORD2     ; X = WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 204
*                                                         CPU6 instruction # 970
          LDA+      X         ; *X -> A.
*                                                         CPU5 instruction # 204
*                                                         CPU6 instruction # 970
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit Y.
* Load A using register Y whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9B    LDA=      WORD3     ; A = WORD3.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 205
*                                                         CPU6 instruction # 971
          LDA+      Y         ; *Y -> A.
*                                                         CPU5 instruction # 205
*                                                         CPU6 instruction # 971
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit Z.
* Load A using register Z whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9C    LDA=      WORD4     ; A = WORD4.
          XAZ                 ; A -> Z.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 206
*                                                         CPU6 instruction # 972
          LDA+      Z         ; *Z -> A.
*                                                         CPU5 instruction # 206
*                                                         CPU6 instruction # 972
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit S.
* Load A using register S whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9D    XFR       S,Z       ; S -> Z.
          LDA=      WORD5     ; A = WORD5.
          JSR/      SETFLAGS0 ; Reset flags.
          XAS                 ; A -> S.
*                                                         CPU5 instruction # 207
*                                                         CPU6 instruction # 973
          LDA+      S         ; *S -> A.
*                                                         CPU5 instruction # 207
*                                                         CPU6 instruction # 973
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit C.
* Load A using register C whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9E    XFR       C,Z       ; C -> Z.
          LDA=      WORD6     ; A = WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 208
*                                                         CPU6 instruction # 974
          LDA+      C         ; *C -> A.
*                                                         CPU5 instruction # 208
*                                                         CPU6 instruction # 974
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDA+/LDA- implicit P.
* Load A using register P whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TEST9F    LDA=      WORD7     ; A = WORD7.
*                                                         CPU5 illegal start
          LDB=      T9FDONE   ; B = T9FDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 209
*                                                         CPU6 instruction # 975
          LDA+      P         ; *P -> A.
*                                                         CPU5 instruction # 209
*                                                         CPU6 instruction # 975
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
T9FDONE   RSR                 ; Return.
*
* Test STAB=.
* Store AL into the immediate byte argument. Flags are set according to the
* value stored.
TESTA0    LDAB=     X'34'     ; AL = 0x34.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 210
*                                                         CPU6 instruction # 976
TA0       STAB=     0         ; AL -> literal.
*                                                         CPU5 instruction # 210
*                                                         CPU6 instruction # 976
          JSR/      PRINTREGS ; Print the registers.
          LDAB      TA0+1     ; Literal -> AL.
          JSR/      HALCRLF   ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STAB/.
* Store AL into the direct-addressed byte at the argument, which is a word
* address. Flags are set according to the value stored.
TESTA1    LDAB=     X'01'     ; AL = 0x01.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 211
*                                                         CPU6 instruction # 977
TA1       STAB/     TBUFF     ; AL -> *TBUFF.
*                                                         CPU5 instruction # 211
*                                                         CPU6 instruction # 977
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB$.
* Store AL into the indirect-addressed byte at the argument, which is a word
* address. Flags are set according to the value stored.
TESTA2    LDAB=     X'07'     ; AL = 0x07.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 212
*                                                         CPU6 instruction # 978
          STAB$     TBUFFADDR ; AL -> **TBUFFADDR.
*                                                         CPU5 instruction # 212
*                                                         CPU6 instruction # 978
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB.
* Store AL into the relative-addressed byte at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value stored.
TESTA3    LDAB=     X'03'     ; AL = 0x03.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 213
*                                                         CPU6 instruction # 979
          STAB      TA0+1     ; AL -> *(TA0+1).
*                                                         CPU5 instruction # 213
*                                                         CPU6 instruction # 979
          JSR/      PRINTREGS ; Print the registers.
          LDAB      TA0+1     ; Literal -> A.
          JSR/      HALCRLF   ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STAB*.
* Store AL into the relative-indirect-addressed byte at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value stored.
TESTA4    LDAB=     X'05'     ; AL = 0x05.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 214
*                                                         CPU6 instruction # 980
          STAB*     TA1+1     ; AL -> **(TA1+1).
*                                                         CPU5 instruction # 214
*                                                         CPU6 instruction # 980
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB-.
* Store AL using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the byte to store.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by one after using it as the address of the
*   byte to store.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by one before using it as the address of the
*   byte to store.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   byte to store.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This stores the byte just as for indexed-indirect,
*   then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then stores the
*   byte just as for indexed-indirect.
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the byte to store.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This stores the
*   byte just as for indexed-displaced, then increments the register by one.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by one, then stores the byte just as for indexed-displaced.
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   byte to store.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This stores the byte just as for indexed-displaced-indirect,
*   then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then stores the byte just
*   as for indexed-displaced-indirect.
*
* The indexed (I) mode will always get encoded as one of the implicit register
* STABs (A8-AF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register STABs (A8-AF) for actual syntax.
TESTA5    LDAB/     BYTE0     ; AL = *BYTE0.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 215
*                                                         CPU6 instruction # 981
          DW        X'A520'   ; AL -> *B (I). [alternate encoding of STAB+ B]
*                                                         CPU5 instruction # 215
*                                                         CPU6 instruction # 981
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE1     ; AL = *BYTE1.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 216
*                                                         CPU6 instruction # 982
          STAB+     B+        ; AL -> *B; B+1 -> B (IPI).
*                                                         CPU5 instruction # 216
*                                                         CPU6 instruction # 982
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE2     ; AL = *BYTE2.
          LDB=      TBUFF+1   ; B = one past TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 217
*                                                         CPU6 instruction # 983
          STAB-     B-        ; B-1 -> B; AL -> *B (IPD).
*                                                         CPU5 instruction # 217
*                                                         CPU6 instruction # 983
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE3     ; AL = *BYTE3.
          LDB=      TBUFFADDR ; B = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 218
*                                                         CPU6 instruction # 984
          STAB+     *B        ; AL -> **B (II).
*                                                         CPU5 instruction # 218
*                                                         CPU6 instruction # 984
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE4     ; AL = *BYTE4.
          LDB=      TBUFFADDR ; B = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 219
*                                                         CPU6 instruction # 985
          STAB+     *B+       ; AL -> **B; B+2 -> B (IIPI).
*                                                         CPU5 instruction # 219
*                                                         CPU6 instruction # 985
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE5     ; AL = *BYTE5.
          LDB=      TBUFFADDR+2 ; B = two past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 220
*                                                         CPU6 instruction # 986
          STAB-     *B-       ; B-2 -> B; AL -> **B (IIPD).
*                                                         CPU5 instruction # 220
*                                                         CPU6 instruction # 986
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDAB/     BYTE6     ; AL = *BYTE6.
          LDB=      TBUFF-3   ; B = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 221
*                                                         CPU6 instruction # 987
          STAB+     B,3       ; AL -> *(B+3) (ID).
*                                                         CPU5 instruction # 221
*                                                         CPU6 instruction # 987
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE7     ; AL = *BYTE7.
          LDB=      TBUFF-5   ; B = five before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 222
*                                                         CPU6 instruction # 988
          STAB+     B+,5      ; AL -> *(B+5); B+1 -> B (IDPI).
*                                                         CPU5 instruction # 222
*                                                         CPU6 instruction # 988
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE8     ; AL = *BYTE8.
          LDB=      TBUFF-3   ; B = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 223
*                                                         CPU6 instruction # 989
          STAB-     B-,4      ; B-1 -> B; AL -> *(B+4) (IDPD).
*                                                         CPU5 instruction # 223
*                                                         CPU6 instruction # 989
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTE9     ; AL = *BYTE9.
          LDB=      TBUFFADDR-3 ; B = three before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 224
*                                                         CPU6 instruction # 990
          STAB+     *B,3      ; **(B+3) -> AL (IDI).
*                                                         CPU5 instruction # 224
*                                                         CPU6 instruction # 990
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTEA     ; AL = *BYTEA.
          LDB=      TBUFFADDR+1 ; B = one past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 225
*                                                         CPU6 instruction # 991
          STAB+     *B+,-1    ; AL -> **(B-1); B+2 -> B (IDIPI).
*                                                         CPU5 instruction # 225
*                                                         CPU6 instruction # 991
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB/     BYTEB     ; AL = *BYTEB.
          LDB=      TBUFFADDR-1 ; B = one before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 226
*                                                         CPU6 instruction # 992
          STAB-     *B-,3     ; B-2 -> B; AL -> **(B+3) (IDIPD).
*                                                         CPU5 instruction # 226
*                                                         CPU6 instruction # 992
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test SEP.
* Set even parity.
TESTA6
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 993
          SEP                 ; Set even parity.
*                                                         CPU6 instruction # 993
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test STAB+/STAB- implicit A.
* Store AL using register A whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic. This clearly
* makes no sense to do in almost any case.
TESTA8    LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 227
*                                                         CPU6 instruction # 994
          STAB+     A         ; AL -> *A.
*                                                         CPU5 instruction # 227
*                                                         CPU6 instruction # 994
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit B.
* Store AL using register B whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTA9    LDB=      TBUFF     ; B = TBUFF.
          LDAB/     BYTE1     ; AL = *BYTE1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 228
*                                                         CPU6 instruction # 995
          STAB+     B         ; AL -> *B.
*                                                         CPU5 instruction # 228
*                                                         CPU6 instruction # 995
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit X.
* Store AL using register X whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAA    STX-      S-        ; Push X to the stack.
          LDX=      TBUFF     ; X = TBUFF.
          LDAB/     BYTE2     ; AL = *BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 229
*                                                         CPU6 instruction # 996
          STAB+     X         ; AL -> *X.
*                                                         CPU5 instruction # 229
*                                                         CPU6 instruction # 996
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit Y.
* Store AL using register Y whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAB    LDA=      TBUFF     ; A = TBUFF.
          XAY                 ; A -> Y.
          LDAB/     BYTE3     ; AL = *BYTE3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 230
*                                                         CPU6 instruction # 997
          STAB+     Y         ; AL -> *Y.
*                                                         CPU5 instruction # 230
*                                                         CPU6 instruction # 997
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit Z.
* Store AL using register Z whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAC    LDA=      TBUFF     ; A = TBUFF.
          XAZ                 ; A -> Z.
          LDAB/     BYTE4     ; AL = *BYTE4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 231
*                                                         CPU6 instruction # 998
          STAB+     Z         ; AL -> *Z.
*                                                         CPU5 instruction # 231
*                                                         CPU6 instruction # 998
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit S.
* Store AL using register S whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAD    XFR       S,Z       ; S -> Z.
          LDB=      TBUFF     ; B = TBUFF.
          LDAB/     BYTE5     ; AL = *BYTE5.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,S       ; B -> S.
*                                                         CPU5 instruction # 232
*                                                         CPU6 instruction # 999
          STAB+     S         ; AL -> *S.
*                                                         CPU5 instruction # 232
*                                                         CPU6 instruction # 999
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit C.
* Store AL using register C whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAE    XFR       C,Z       ; C -> Z.
          LDB=      TBUFF     ; B = TBUFF.
          LDAB/     BYTE6     ; AL = *BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,C       ; B -> C.
*                                                         CPU5 instruction # 233
*                                                         CPU6 instruction #1000
          STAB+     C         ; AL -> *C.
*                                                         CPU5 instruction # 233
*                                                         CPU6 instruction #1000
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STAB+/STAB- implicit P.
* Store AL using register P whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTAF
*                                                         CPU5 illegal start
          LDB=      TAFDONE   ; B = TAFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          LDB=      TBUFF     ; B = TBUFF.
          LDAB/     BYTE7     ; AL = *BYTE7.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,P       ; B -> P.
*                                                         CPU5 instruction # 234
*                                                         CPU6 instruction #1001
          STAB+     P         ; AL -> *P.
*                                                         CPU5 instruction # 234
*                                                         CPU6 instruction #1001
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TAFDONE   JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STA=.
* Store A into the immediate word argument. Flags are set according to the
* value stored.
TESTB0    LDA=      X'1234'   ; A = 0x1234.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 235
*                                                         CPU6 instruction #1002
TB0       STA=      0         ; A -> literal.
*                                                         CPU5 instruction # 235
*                                                         CPU6 instruction #1002
          JSR/      PRINTREGS ; Print the registers.
          LDA       TB0+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STA/.
* Store A into the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TESTB1    LDA=      X'0102'   ; A = 0x0102.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 236
*                                                         CPU6 instruction #1003
TB1       STA/      TBUFF     ; A -> *TBUFF.
*                                                         CPU5 instruction # 236
*                                                         CPU6 instruction #1003
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA$.
* Store A into the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TESTB2    LDA=      X'0708'   ; A = 0x0708.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 237
*                                                         CPU6 instruction #1004
          STA$      TBUFFADDR ; A -> **TBUFFADDR.
*                                                         CPU5 instruction # 237
*                                                         CPU6 instruction #1004
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA.
* Store A into the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value stored.
TESTB3    LDA=      X'0304'   ; A = 0x0304.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 238
*                                                         CPU6 instruction #1005
          STA       TB0+1     ; A -> *(TB0+1).
*                                                         CPU5 instruction # 238
*                                                         CPU6 instruction #1005
          JSR/      PRINTREGS ; Print the registers.
          LDA       TB0+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STA*.
* Store A into the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value stored.
TESTB4    LDA=      X'0506'   ; A = 0x0506.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 239
*                                                         CPU6 instruction #1006
          STA*      TB1+1     ; A -> **(TB1+1).
*                                                         CPU5 instruction # 239
*                                                         CPU6 instruction #1006
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA-.
* Store A using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the word to store.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address of the
*   word to store.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address of the
*   word to store.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   word to store.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This stores the word just as for indexed-indirect,
*   then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then stores the
*   word just as for indexed-indirect.
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to store.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This stores the
*   word just as for indexed-displaced, then increments the register by two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then stores the word just as for indexed-displaced.
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   word to store.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This stores the word just as for indexed-displaced-indirect,
*   then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then stores the word just
*   as for indexed-displaced-indirect.
*
* The indexed (I) mode will always get encoded as one of the implicit register
* STAs (B8-BF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register STAs (B8-BF) for actual syntax.
TESTB5    LDA/      WORD0     ; A = *WORD0.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 240
*                                                         CPU6 instruction #1007
          DW        X'B520'   ; A -> *B (I). [alternate encoding of STA+ B]
*                                                         CPU5 instruction # 240
*                                                         CPU6 instruction #1007
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD1     ; A = *WORD1.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 241
*                                                         CPU6 instruction #1008
          STA+      B+        ; A -> *B; B+2 -> B (IPI).
*                                                         CPU5 instruction # 241
*                                                         CPU6 instruction #1008
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD2     ; A = *WORD2.
          LDB=      TBUFF+2   ; B = two past TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 242
*                                                         CPU6 instruction #1009
          STA-      B-        ; B-2 -> B; A -> *B (IPD).
*                                                         CPU5 instruction # 242
*                                                         CPU6 instruction #1009
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD3     ; A = *WORD3.
          LDB=      TBUFFADDR ; B = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 243
*                                                         CPU6 instruction #1010
          STA+      *B        ; A -> **B (II).
*                                                         CPU5 instruction # 243
*                                                         CPU6 instruction #1010
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD4     ; A = *WORD4.
          LDB=      TBUFFADDR ; B = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 244
*                                                         CPU6 instruction #1011
          STA+      *B+       ; A -> **B; B+2 -> B (IIPI).
*                                                         CPU5 instruction # 244
*                                                         CPU6 instruction #1011
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD5     ; A = *WORD5.
          LDB=      TBUFFADDR+2 ; B = two past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 245
*                                                         CPU6 instruction #1012
          STA-      *B-       ; B-2 -> B; A -> **B (IIPD).
*                                                         CPU5 instruction # 245
*                                                         CPU6 instruction #1012
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDA/      WORD6     ; A = *WORD6.
          LDB=      TBUFF-3   ; B = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 246
*                                                         CPU6 instruction #1013
          STA+      B,3       ; A -> *(B+3) (ID).
*                                                         CPU5 instruction # 246
*                                                         CPU6 instruction #1013
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD7     ; A = *WORD7.
          LDB=      TBUFF-5   ; B = five before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 247
*                                                         CPU6 instruction #1014
          STA+      B+,5      ; A -> *(B+5); B+2 -> B (IDPI).
*                                                         CPU5 instruction # 247
*                                                         CPU6 instruction #1014
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD8     ; A = *WORD8.
          LDB=      TBUFF-3   ; B = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 248
*                                                         CPU6 instruction #1015
          STA-      B-,5      ; B-2 -> B; A -> *(B+5) (IDPD).
*                                                         CPU5 instruction # 248
*                                                         CPU6 instruction #1015
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORD9     ; A = *WORD9.
          LDB=      TBUFFADDR-3 ; B = three before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 249
*                                                         CPU6 instruction #1016
          STA+      *B,3      ; **(B+3) -> A (IDI).
*                                                         CPU5 instruction # 249
*                                                         CPU6 instruction #1016
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORDA     ; A = *WORDA.
          LDB=      TBUFFADDR+1 ; B = one past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 250
*                                                         CPU6 instruction #1017
          STA+      *B+,-1    ; A -> **(B-1); B+2 -> B (IDIPI).
*                                                         CPU5 instruction # 250
*                                                         CPU6 instruction #1017
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA/      WORDB     ; A = *WORDB.
          LDB=      TBUFFADDR-1 ; B = one before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 251
*                                                         CPU6 instruction #1018
          STA-      *B-,3     ; B-2 -> B; A -> **(B+3) (IDIPD).
*                                                         CPU5 instruction # 251
*                                                         CPU6 instruction #1018
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test ECK.
* Enable clock interrupt.
TESTB6
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1019
          ECK                 ; Enable clock interrupt.
*                                                         CPU6 instruction #1019
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test STA+/STA- implicit A.
* Store A using register A whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic. This clearly
* makes no sense to do in almost any case.
TESTB8    LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 252
*                                                         CPU6 instruction #1020
          STA+      A         ; A -> *A.
*                                                         CPU5 instruction # 252
*                                                         CPU6 instruction #1020
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit B.
* Store A using register B whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTB9    LDB=      TBUFF     ; B = TBUFF.
          LDA/      WORD1     ; A = *WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 253
*                                                         CPU6 instruction #1021
          STA+      B         ; A -> *B.
*                                                         CPU5 instruction # 253
*                                                         CPU6 instruction #1021
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit X.
* Store A using register X whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBA    STX-      S-        ; Push X to the stack.
          LDX=      TBUFF     ; X = TBUFF.
          LDA/      WORD2     ; A = *WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 254
*                                                         CPU6 instruction #1022
          STA+      X         ; A -> *X.
*                                                         CPU5 instruction # 254
*                                                         CPU6 instruction #1022
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STA+/STA- implicit Y.
* Store A using register Y whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBB    LDA=      TBUFF     ; A = TBUFF.
          XAY                 ; A -> Y.
          LDA/      WORD3     ; A = *WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 255
*                                                         CPU6 instruction #1023
          STA+      Y         ; A -> *Y.
*                                                         CPU5 instruction # 255
*                                                         CPU6 instruction #1023
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit Z.
* Store A using register Z whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBC    LDA=      TBUFF     ; A = TBUFF.
          XAZ                 ; A -> Z.
          LDA/      WORD4     ; A = *WORD4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 256
*                                                         CPU6 instruction #1024
          STA+      Z         ; A -> *Z.
*                                                         CPU5 instruction # 256
*                                                         CPU6 instruction #1024
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit S.
* Store A using register S whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBD    XFR       S,Z       ; S -> Z.
          LDB=      TBUFF     ; B = TBUFF.
          LDA/      WORD5     ; A = *WORD5.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,S       ; B -> S.
*                                                         CPU5 instruction # 257
*                                                         CPU6 instruction #1025
          STA+      S         ; A -> *S.
*                                                         CPU5 instruction # 257
*                                                         CPU6 instruction #1025
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit C.
* Store A using register C whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBE    XFR       C,Z       ; C -> Z.
          LDB=      TBUFF     ; B = TBUFF.
          LDA/      WORD6     ; A = *WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,C       ; B -> C.
*                                                         CPU5 instruction # 258
*                                                         CPU6 instruction #1026
          STA+      C         ; A -> *C.
*                                                         CPU5 instruction # 258
*                                                         CPU6 instruction #1026
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STA+/STA- implicit P.
* Store A using register P whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTBF
*                                                         CPU5 illegal start
          LDB=      TBFDONE   ; B = TBFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          LDB=      TBUFF     ; B = TBUFF.
          LDA/      WORD7     ; A = *WORD7.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       B,P       ; B -> P.
*                                                         CPU5 instruction # 259
*                                                         CPU6 instruction #1027
          STA+      P         ; A -> *P.
*                                                         CPU5 instruction # 259
*                                                         CPU6 instruction #1027
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TBFDONE   JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test LDBB=.
* Load BL with the immediate byte argument. Flags are set according to the value
* loaded.
TESTC0    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 260
*                                                         CPU6 instruction #1028
TC0       LDBB=     -1        ; -1 -> BL.
*                                                         CPU5 instruction # 260
*                                                         CPU6 instruction #1028
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB/.
* Load BL with the direct-addressed byte at the argument, which is a word
* address. Flags are set according to the value loaded.
TESTC1    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 261
*                                                         CPU6 instruction #1029
TC1       LDBB/     BYTE0     ; *BYTE0 -> BL.
*                                                         CPU5 instruction # 261
*                                                         CPU6 instruction #1029
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB$.
* Load BL with the indirect-addressed byte at the argument, which is a word
* address. Flags are set according to the value loaded.
TESTC2    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 262
*                                                         CPU6 instruction #1030
          LDBB$     BYTE3ADDR ; **BYTE3ADDR -> BL.
*                                                         CPU5 instruction # 262
*                                                         CPU6 instruction #1030
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB.
* Load BL with the relative-addressed byte at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value loaded.
TESTC3    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 263
*                                                         CPU6 instruction #1031
          LDBB      TC0+1     ; *(TC0+1) -> BL.
*                                                         CPU5 instruction # 263
*                                                         CPU6 instruction #1031
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB*.
* Load BL with the relative-indirect-addressed byte at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value loaded.
TESTC4    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 264
*                                                         CPU6 instruction #1032
          LDBB*     TC1+1     ; **(TC1+1) -> BL.
*                                                         CPU5 instruction # 264
*                                                         CPU6 instruction #1032
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB-.
* Load BL using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the byte to load.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by one after using it as the address of the
*   byte to load.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by one before using it as the address of the
*   byte to load.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   byte to load.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This loads the byte just as for indexed-indirect
*   (II), then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then loads the
*   byte just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the byte to load.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This loads the
*   byte just as for indexed-displaced (ID), then increments the register by
*   one.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by one, then loads the byte just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   byte to load.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This loads the byte just as for indexed-displaced-indirect
*   (IDI), then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then loads the byte just
*   as for indexed-displaced-indirect (IDI).
*
* The indexed (I) mode will always get encoded as one of the implicit register
* LDBBs (C8-CF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register LDBBs (C8-CF) for actual syntax.
TESTC5    LDA=      BYTE0     ; A = BYTE0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 265
*                                                         CPU6 instruction #1033
          DW        X'C500'    ; *A -> BL (I). [alternate encoding of LDBB+ A]
*                                                         CPU5 instruction # 265
*                                                         CPU6 instruction #1033
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE1     ; A = BYTE1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 266
*                                                         CPU6 instruction #1034
          LDBB+     A+        ; *A -> BL; A+1 -> A (IPI).
*                                                         CPU5 instruction # 266
*                                                         CPU6 instruction #1034
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE2+1   ; A = one past BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 267
*                                                         CPU6 instruction #1035
          LDBB-     A-        ; A-1 -> A; *A -> BL (IPD).
*                                                         CPU5 instruction # 267
*                                                         CPU6 instruction #1035
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE3ADDR ; A = BYTE3ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 268
*                                                         CPU6 instruction #1036
          LDBB+     *A        ; **A -> BL (II).
*                                                         CPU5 instruction # 268
*                                                         CPU6 instruction #1036
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE4ADDR ; A = BYTE4ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 269
*                                                         CPU6 instruction #1037
          LDBB+     *A+       ; **A -> BL; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 269
*                                                         CPU6 instruction #1037
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE5ADDR+2 ; A = two past BYTE5ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 270
*                                                         CPU6 instruction #1038
          LDBB-     *A-       ; A-2 -> A; **A -> BL (IIPD).
*                                                         CPU5 instruction # 270
*                                                         CPU6 instruction #1038
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE6-3   ; A = three before BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 271
*                                                         CPU6 instruction #1039
          LDBB+     A,3       ; *(A+3) -> BL (ID).
*                                                         CPU5 instruction # 271
*                                                         CPU6 instruction #1039
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE7-5   ; A = five before BYTE7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 272
*                                                         CPU6 instruction #1040
          LDBB+     A+,5      ; *(A+5) -> BL; A+1 -> A (IDPI).
*                                                         CPU5 instruction # 272
*                                                         CPU6 instruction #1040
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE8-3   ; A = three before BYTE8.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 273
*                                                         CPU6 instruction #1041
          LDBB-     A-,4      ; A-1 -> A; *(A+4) -> BL (IDPD).
*                                                         CPU5 instruction # 273
*                                                         CPU6 instruction #1041
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTE9ADDR-3 ; A = three before BYTE9ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 274
*                                                         CPU6 instruction #1042
          LDBB+     *A,3      ; **(A+3) -> BL (IDI).
*                                                         CPU5 instruction # 274
*                                                         CPU6 instruction #1042
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTEAADDR+1 ; A = one past BYTEAADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 275
*                                                         CPU6 instruction #1043
          LDBB+     *A+,-1    ; **(A-1) -> BL; A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 275
*                                                         CPU6 instruction #1043
          JSR/      PRINTREGS ; Print the registers.
          LDA=      BYTEBADDR-1 ; A = one before BYTEBADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 276
*                                                         CPU6 instruction #1044
          LDBB-     *A-,3     ; A-2 -> A; **(A+3) -> BL (IDIPD).
*                                                         CPU5 instruction # 276
*                                                         CPU6 instruction #1044
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DCK.
* Disable clock interrupt.
TESTC6
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1045
          DCK                 ; Disable clock interrupt.
*                                                         CPU6 instruction #1045
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test LDBB+/LDBB- implicit A.
* Load BL using register A whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTC8    LDA=      BYTE0     ; A = BYTE0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 277
*                                                         CPU6 instruction #1046
          LDBB+     A         ; *A -> BL.
*                                                         CPU5 instruction # 277
*                                                         CPU6 instruction #1046
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit B.
* Load BL using register B whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTC9    LDB=      BYTE1     ; B = BYTE1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 278
*                                                         CPU6 instruction #1047
          LDBB+     B         ; *B -> BL.
*                                                         CPU5 instruction # 278
*                                                         CPU6 instruction #1047
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit X.
* Load BL using register X whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCA    STX-      S-        ; Push X to the stack.
          LDX=      BYTE2     ; X = BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 279
*                                                         CPU6 instruction #1048
          LDBB+     X         ; *X -> BL.
*                                                         CPU5 instruction # 279
*                                                         CPU6 instruction #1048
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit Y.
* Load BL using register Y whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCB    LDA=      BYTE3     ; A = BYTE3.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 280
*                                                         CPU6 instruction #1049
          LDBB+     Y         ; *Y -> BL.
*                                                         CPU5 instruction # 280
*                                                         CPU6 instruction #1049
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit Z.
* Load BL using register Z whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCC    LDA=      BYTE4     ; A = BYTE4.
          XAZ                 ; A -> Z.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 281
*                                                         CPU6 instruction #1050
          LDBB+     Z         ; *Z -> BL.
*                                                         CPU5 instruction # 281
*                                                         CPU6 instruction #1050
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit S.
* Load BL using register S whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCD    XFR       S,Z       ; S -> Z.
          LDA=      BYTE5     ; A = BYTE5.
          JSR/      SETFLAGS0 ; Reset flags.
          XAS                 ; A -> S.
*                                                         CPU5 instruction # 282
*                                                         CPU6 instruction #1051
          LDBB+     S         ; *S -> BL.
*                                                         CPU5 instruction # 282
*                                                         CPU6 instruction #1051
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit C.
* Load BL using register C whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCE    XFR       C,Z       ; C -> Z.
          LDA=      BYTE6     ; A = BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 283
*                                                         CPU6 instruction #1052
          LDBB+     C         ; *C -> BL.
*                                                         CPU5 instruction # 283
*                                                         CPU6 instruction #1052
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDBB+/LDBB- implicit P.
* Load BL using register P whose value is used as the address of the byte to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTCF    LDA=      BYTE7     ; A = BYTE7.
*                                                         CPU5 illegal start
          LDB=      TCFDONE   ; B = TCFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 284
*                                                         CPU6 instruction #1053
          LDBB+     P         ; *P -> BL.
*                                                         CPU5 instruction # 284
*                                                         CPU6 instruction #1053
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TCFDONE   RSR                 ; Return.
*
* Test LDB=.
* Load B with the immediate word argument. Flags are set according to the value
* loaded.
TESTD0    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 285
*                                                         CPU6 instruction #1054
TD0       LDB=      -1        ; -1 -> B.
*                                                         CPU5 instruction # 285
*                                                         CPU6 instruction #1054
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB/.
* Load B with the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TESTD1    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 286
*                                                         CPU6 instruction #1055
TD1       LDB/      WORD0     ; *WORD0 -> B.
*                                                         CPU5 instruction # 286
*                                                         CPU6 instruction #1055
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB$.
* Load B with the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TESTD2    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 287
*                                                         CPU6 instruction #1056
          LDB$      WORD3ADDR ; **WORD0ADDR -> B.
*                                                         CPU5 instruction # 287
*                                                         CPU6 instruction #1056
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB.
* Load B with the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value loaded.
TESTD3    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 288
*                                                         CPU6 instruction #1057
          LDB       TD0+1     ; *(TD0+1) -> B.
*                                                         CPU5 instruction # 288
*                                                         CPU6 instruction #1057
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB*.
* Load B with the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value loaded.
TESTD4    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 289
*                                                         CPU6 instruction #1058
          LDB*      TD1+1     ; **(TD1+1) -> B.
*                                                         CPU5 instruction # 289
*                                                         CPU6 instruction #1058
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB-.
* Load B using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the word to load.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address of the
*   word to load.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address of the
*   word to load.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   word to load.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This loads the word just as for indexed-indirect
*   (II), then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then loads the
*   word just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to load.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This loads the
*   word just as for indexed-displaced (ID), then increments the register by
*   two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then loads the word just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   word to load.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This loads the word just as for indexed-displaced-indirect
*   (IDI), then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then loads the word just
*   as for indexed-displaced-indirect (IDI).
*
* The indexed (I) mode will always get encoded as one of the implicit register
* LDBs (D8-DF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register LDBs (D8-DF) for actual syntax.
TESTD5    LDA=      WORD0     ; A = WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 290
*                                                         CPU6 instruction #1059
          DW        X'D500'    ; *A -> B (I). [alternate encoding of LDB+ A]
*                                                         CPU5 instruction # 290
*                                                         CPU6 instruction #1059
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD1     ; A = WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 291
*                                                         CPU6 instruction #1060
          LDB+      A+        ; *A -> B; A+2 -> A (IPI).
*                                                         CPU5 instruction # 291
*                                                         CPU6 instruction #1060
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD2+2   ; A = two past WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 292
*                                                         CPU6 instruction #1061
          LDB-      A-        ; A-2 -> A; *A -> B (IPD).
*                                                         CPU5 instruction # 292
*                                                         CPU6 instruction #1061
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD3ADDR ; A = WORD3ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 293
*                                                         CPU6 instruction #1062
          LDB+      *A        ; **A -> B (II).
*                                                         CPU5 instruction # 293
*                                                         CPU6 instruction #1062
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD4ADDR ; A = WORD4ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 294
*                                                         CPU6 instruction #1063
          LDB+      *A+       ; **A -> B; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 294
*                                                         CPU6 instruction #1063
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD5ADDR+2 ; A = two past WORD5ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 295
*                                                         CPU6 instruction #1064
          LDB-      *A-       ; A-2 -> A; **A -> B (IIPD).
*                                                         CPU5 instruction # 295
*                                                         CPU6 instruction #1064
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD6-3   ; A = three before WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 296
*                                                         CPU6 instruction #1065
          LDB+      A,3       ; *(A+3) -> B (ID).
*                                                         CPU5 instruction # 296
*                                                         CPU6 instruction #1065
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD7-5   ; A = five before WORD7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 297
*                                                         CPU6 instruction #1066
          LDB+      A+,5      ; *(A+5) -> B; A+2 -> A (IDPI).
*                                                         CPU5 instruction # 297
*                                                         CPU6 instruction #1066
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD8-2   ; A = two before WORD8.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 298
*                                                         CPU6 instruction #1067
          LDB-      A-,4      ; A-2 -> A; *(A+4) -> B (IDPD).
*                                                         CPU5 instruction # 298
*                                                         CPU6 instruction #1067
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD9ADDR-3 ; A = three before WORD9ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 299
*                                                         CPU6 instruction #1068
          LDB+      *A,3      ; **(A+3) -> B (IDI).
*                                                         CPU5 instruction # 299
*                                                         CPU6 instruction #1068
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORDAADDR+1 ; A = one past WORDAADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 300
*                                                         CPU6 instruction #1069
          LDB+      *A+,-1    ; **(A-1) -> B; A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 300
*                                                         CPU6 instruction #1069
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORDBADDR-1 ; A = one before WORDBADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 301
*                                                         CPU6 instruction #1070
          LDB-      *A-,3     ; A-2 -> A; **(A+3) -> B (IDIPD).
*                                                         CPU5 instruction # 301
*                                                         CPU6 instruction #1070
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test STR.
* Store a word register to another word register, an immediate word, a direct-
* addressed word, or an indexed-displaced word. Unlike most instructions, the
* destination is specified as the first argument and the source as the second.
* The indexed-displaced displacement is required and is a word. See also XFR.
* Note that the first variation of STR is identical to the first variation of
* XFR.
TESTD6
*         JMP/      TESTILL                               CPU5 illegal start
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1071
          STR       Z,B       ; B -> Z.
*                                                         CPU6 instruction #1071
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1072
TD6       STR=      0,Z       ; Z -> literal.
*                                                         CPU6 instruction #1072
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TD6+2     ; Location of literal.
          CLR       B,1       ; One word = two bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1073
          STR/      TBUFF,Z   ; Z -> *TBUFF.
*                                                         CPU6 instruction #1073
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1074
          STR-      A,3,Z     ; Z -> *(A+3).
*                                                         CPU6 instruction #1074
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test SAR.
* Store A register to any word register at any interrupt level.
TESTD7
*         JMP/      TESTILL                               CPU5 illegal start
          LDA=      X'1234'   ; A = 0x1234.
          CLR       Z         ; Z = 0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1075
          SAR       1,Z       ; A -> Z in interrupt level 1.
*                                                         CPU6 instruction #1075
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'0018'   ; Location of Z in interrupt level 1.
          CLR       B,1       ; One word = two bytes.
          JSR/      HBCRLF    ; Print Z in interrupt level 1 + CRLF.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test LDB+/LDB- implicit A.
* Load B using register A whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTD8    LDA=      WORD0     ; A = WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 302
*                                                         CPU6 instruction #1071
          LDB+      A         ; *A -> B.
*                                                         CPU5 instruction # 302
*                                                         CPU6 instruction #1071
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit B.
* Load B using register B whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTD9    LDB=      WORD1     ; B = WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 303
*                                                         CPU6 instruction #1072
          LDB+      B         ; *B -> B.
*                                                         CPU5 instruction # 303
*                                                         CPU6 instruction #1072
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit X.
* Load B using register X whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDA    STX-      S-        ; Push X to the stack.
          LDX=      WORD2     ; X = WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 304
*                                                         CPU6 instruction #1073
          LDB+      X         ; *X -> B.
*                                                         CPU5 instruction # 304
*                                                         CPU6 instruction #1073
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit Y.
* Load B using register Y whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDB    LDA=      WORD3     ; A = WORD3.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 305
*                                                         CPU6 instruction #1074
          LDB+      Y         ; *Y -> B.
*                                                         CPU5 instruction # 305
*                                                         CPU6 instruction #1074
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit Z.
* Load B using register Z whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDC    LDA=      WORD4     ; A = WORD4.
          XAZ                 ; A -> Z.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 306
*                                                         CPU6 instruction #1075
          LDB+      Z         ; *Z -> B.
*                                                         CPU5 instruction # 306
*                                                         CPU6 instruction #1075
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit S.
* Load B using register S whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDD    XFR       S,Z       ; S -> Z.
          LDA=      WORD5     ; A = WORD5.
          JSR/      SETFLAGS0 ; Reset flags.
          XAS                 ; A -> S.
*                                                         CPU5 instruction # 307
*                                                         CPU6 instruction #1076
          LDB+      S         ; *S -> B.
*                                                         CPU5 instruction # 307
*                                                         CPU6 instruction #1076
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit C.
* Load B using register C whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDE    XFR       C,Z       ; C -> Z.
          LDA=      WORD6     ; A = WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 308
*                                                         CPU6 instruction #1077
          LDB+      C         ; *C -> B.
*                                                         CPU5 instruction # 308
*                                                         CPU6 instruction #1077
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test LDB+/LDB- implicit P.
* Load B using register P whose value is used as the address of the word to
* load. Either the + or - suffix is acceptable on the mnemonic.
TESTDF    LDA=      WORD7     ; A = WORD7.
*                                                         CPU5 illegal start
          LDB=      TDFDONE   ; B = TDFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 309
*                                                         CPU6 instruction #1078
          LDB+      P         ; *P -> B.
*                                                         CPU5 instruction # 309
*                                                         CPU6 instruction #1078
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TDFDONE   RSR                 ; Return.
*
* Test STBB=.
* Store BL into the immediate byte argument. Flags are set according to the
* value stored.
TESTE0    LDBB=     X'34'     ; BL = 0x34.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 310
*                                                         CPU6 instruction #1079
TE0       STBB=     0         ; BL -> literal.
*                                                         CPU5 instruction # 310
*                                                         CPU6 instruction #1079
          JSR/      PRINTREGS ; Print the registers.
          LDAB      TE0+1     ; Literal -> AL.
          JSR/      HALCRLF   ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STBB/.
* Store BL into the direct-addressed byte at the argument, which is a word
* address. Flags are set according to the value stored.
TESTE1    LDBB=     X'01'     ; BL = 0x01.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 311
*                                                         CPU6 instruction #1080
TE1       STBB/     TBUFF     ; AL -> *TBUFF.
*                                                         CPU5 instruction # 311
*                                                         CPU6 instruction #1080
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB$.
* Store BL into the indirect-addressed byte at the argument, which is a word
* address. Flags are set according to the value stored.
TESTE2    LDBB=     X'07'     ; BL = 0x07.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 312
*                                                         CPU6 instruction #1081
          STBB$     TBUFFADDR ; BL -> **TBUFFADDR.
*                                                         CPU5 instruction # 312
*                                                         CPU6 instruction #1081
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB.
* Store BL into the relative-addressed byte at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value stored.
TESTE3    LDBB=     X'03'     ; BL = 0x03.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 313
*                                                         CPU6 instruction #1082
          STBB      TE0+1     ; BL -> *(TE0+1).
*                                                         CPU5 instruction # 313
*                                                         CPU6 instruction #1082
          JSR/      PRINTREGS ; Print the registers.
          LDAB      TE0+1     ; Literal -> A.
          JSR/      HALCRLF   ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STBB*.
* Store BL into the relative-indirect-addressed byte at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value stored.
TESTE4    LDBB=     X'05'     ; BL = 0x05.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 314
*                                                         CPU6 instruction #1083
          STBB*     TE1+1     ; BL -> **(TE1+1).
*                                                         CPU5 instruction # 314
*                                                         CPU6 instruction #1083
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB-.
* Store BL using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the byte to store.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by one after using it as the address of the
*   byte to store.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by one before using it as the address of the
*   byte to store.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   byte to store.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This stores the byte just as for indexed-indirect,
*   then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then stores the
*   byte just as for indexed-indirect.
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the byte to store.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This stores the
*   byte just as for indexed-displaced, then increments the register by one.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by one, then stores the byte just as for indexed-displaced.
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   byte to store.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This stores the byte just as for indexed-displaced-indirect,
*   then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then stores the byte just
*   as for indexed-displaced-indirect.
*
* The indexed (I) mode will always get encoded as one of the implicit register
* STBBs (E8-EF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register STBBs (E8-EF) for actual syntax.
TESTE5    LDBB/     BYTE0     ; BL = *BYTE0.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 315
*                                                         CPU6 instruction #1084
          DW        X'E500'   ; BL -> *A (I). [alternate encoding of STBB+ A]
*                                                         CPU5 instruction # 315
*                                                         CPU6 instruction #1084
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE1     ; BL = *BYTE1.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 316
*                                                         CPU6 instruction #1085
          STBB+     A+        ; BL -> *A; A+1 -> A (IPI).
*                                                         CPU5 instruction # 316
*                                                         CPU6 instruction #1085
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE2     ; BL = *BYTE2.
          LDA=      TBUFF+1   ; A = one past TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 317
*                                                         CPU6 instruction #1086
          STBB-     A-        ; A-1 -> A; BL -> *A (IPD).
*                                                         CPU5 instruction # 317
*                                                         CPU6 instruction #1086
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE3     ; BL = *BYTE3.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 318
*                                                         CPU6 instruction #1087
          STBB+     *A        ; BL -> **A (II).
*                                                         CPU5 instruction # 318
*                                                         CPU6 instruction #1087
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE4     ; BL = *BYTE4.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 319
*                                                         CPU6 instruction #1088
          STBB+     *A+       ; BL -> **A; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 319
*                                                         CPU6 instruction #1088
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE5     ; BL = *BYTE5.
          LDA=      TBUFFADDR+2 ; A = two past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 320
*                                                         CPU6 instruction #1089
          STBB-     *A-       ; A-2 -> A; BL -> **A (IIPD).
*                                                         CPU5 instruction # 320
*                                                         CPU6 instruction #1089
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDBB/     BYTE6     ; BL = *BYTE6.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 321
*                                                         CPU6 instruction #1090
          STBB+     A,3       ; BL -> *(A+3) (ID).
*                                                         CPU5 instruction # 321
*                                                         CPU6 instruction #1090
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE7     ; BL = *BYTE7.
          LDA=      TBUFF-5   ; A = five before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 322
*                                                         CPU6 instruction #1091
          STBB+     A+,5      ; BL -> *(A+5); A+1 -> A (IDPI).
*                                                         CPU5 instruction # 322
*                                                         CPU6 instruction #1091
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE8     ; BL = *BYTE8.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 323
*                                                         CPU6 instruction #1092
          STBB-     A-,4      ; A-1 -> A; BL -> *(A+4) (IDPD).
*                                                         CPU5 instruction # 323
*                                                         CPU6 instruction #1092
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTE9     ; BL = *BYTE9.
          LDA=      TBUFFADDR-3 ; A = three before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 324
*                                                         CPU6 instruction #1093
          STBB+     *A,3      ; **(A+3) -> BL (IDI).
*                                                         CPU5 instruction # 324
*                                                         CPU6 instruction #1093
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTEA     ; BL = *BYTEA.
          LDA=      TBUFFADDR+1 ; A = one past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 325
*                                                         CPU6 instruction #1094
          STBB+     *A+,-1    ; BL -> **(A-1); A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 325
*                                                         CPU6 instruction #1094
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDBB/     BYTEB     ; BL = *BYTEB.
          LDA=      TBUFFADDR-1 ; A = one before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 326
*                                                         CPU6 instruction #1095
          STBB-     *A-,3     ; A-2 -> A; BL -> **(A+3) (IDIPD).
*                                                         CPU5 instruction # 326
*                                                         CPU6 instruction #1095
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test LAR.
* Load A register from any word register at any interrupt level.
TESTE6
*         JMP/      TESTILL                               CPU5 illegal start
          LDB=      X'5678'   ; B = 0x5678.
          STB/      X'0016'   ; B -> Y in interrupt level 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1096
          LAR       1,Y       ; Y in interrupt level 1 -> A.
*                                                         CPU6 instruction #1096
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test STBB+/STBB- implicit A.
* Store BL using register A whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTE8    LDA=      TBUFF     ; A = TBUFF.
          LDBB/     BYTE0     ; BL = *BYTE0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 327
*                                                         CPU6 instruction #1097
          STBB+     A         ; BL -> *A.
*                                                         CPU5 instruction # 327
*                                                         CPU6 instruction #1097
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit B.
* Store BL using register B whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic. This clearly
* makes no sense to do in almost any case.
TESTE9    LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 328
*                                                         CPU6 instruction #1098
          STBB+     B         ; BL -> *B.
*                                                         CPU5 instruction # 328
*                                                         CPU6 instruction #1098
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit X.
* Store BL using register X whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTEA    STX-      S-        ; Push X to the stack.
          LDX=      TBUFF     ; X = TBUFF.
          LDBB/     BYTE2     ; BL = *BYTE2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 329
*                                                         CPU6 instruction #1099
          STBB+     X         ; BL -> *X.
*                                                         CPU5 instruction # 329
*                                                         CPU6 instruction #1099
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit Y.
* Store BL using register Y whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTEB    LDA=      TBUFF     ; A = TBUFF.
          XAY                 ; A -> Y.
          LDBB/     BYTE3     ; BL = *BYTE3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 330
*                                                         CPU6 instruction #1100
          STBB+     Y         ; BL -> *Y.
*                                                         CPU5 instruction # 330
*                                                         CPU6 instruction #1100
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit Z.
* Store BL using register Z whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTEC    LDA=      TBUFF     ; A = TBUFF.
          XAZ                 ; A -> Z.
          LDBB/     BYTE4     ; BL = *BYTE4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 331
*                                                         CPU6 instruction #1101
          STBB+     Z         ; BL -> *Z.
*                                                         CPU5 instruction # 331
*                                                         CPU6 instruction #1101
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit S.
* Store BL using register S whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTED    XFR       S,Z       ; S -> Z.
          LDA=      TBUFF     ; A = TBUFF.
          LDBB/     BYTE5     ; BL = *BYTE5.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,S       ; A -> S.
*                                                         CPU5 instruction # 332
*                                                         CPU6 instruction #1102
          STBB+     S         ; BL -> *S.
*                                                         CPU5 instruction # 332
*                                                         CPU6 instruction #1102
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit C.
* Store BL using register C whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTEE    XFR       C,Z       ; C -> Z.
          LDA=      TBUFF     ; A = TBUFF.
          LDBB/     BYTE6     ; BL = *BYTE6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 333
*                                                         CPU6 instruction #1103
          STBB+     C         ; BL -> *C.
*                                                         CPU5 instruction # 333
*                                                         CPU6 instruction #1103
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STBB+/STBB- implicit P.
* Store BL using register P whose value is used as the address of the byte to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTEF
*                                                         CPU5 illegal start
          LDB=      TEFDONE   ; B = TAFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          LDA=      TBUFF     ; A = TBUFF.
          LDBB/     BYTE7     ; BL = *BYTE7.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 334
*                                                         CPU6 instruction #1104
          STBB+     P         ; BL -> *P.
*                                                         CPU5 instruction # 334
*                                                         CPU6 instruction #1104
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TEFDONE   JSR/      HEXT1     ; Print the first byte of TBUFF.
          RSR                 ; Return.
*
* Test STB=.
* Store B into the immediate word argument. Flags are set according to the
* value stored.
TESTF0    LDB=      X'1234'   ; B = 0x1234.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 335
*                                                         CPU6 instruction #1105
TF0       STB=      0         ; B -> literal.
*                                                         CPU5 instruction # 335
*                                                         CPU6 instruction #1105
          JSR/      PRINTREGS ; Print the registers.
          LDA       TF0+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STB/.
* Store B into the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TESTF1    LDB=      X'0102'   ; B = 0x0102.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 336
*                                                         CPU6 instruction #1106
TF1       STB/      TBUFF     ; B -> *TBUFF.
*                                                         CPU5 instruction # 336
*                                                         CPU6 instruction #1106
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB$.
* Store B into the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TESTF2    LDB=      X'0708'   ; B = 0x0708.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 337
*                                                         CPU6 instruction #1107
          STB$      TBUFFADDR ; B -> **TBUFFADDR.
*                                                         CPU5 instruction # 337
*                                                         CPU6 instruction #1107
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB.
* Store B into the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value stored.
TESTF3    LDB=      X'0304'   ; B = 0x0304.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 338
*                                                         CPU6 instruction #1108
          STB       TF0+1     ; B -> *(TF0+1).
*                                                         CPU5 instruction # 338
*                                                         CPU6 instruction #1108
          JSR/      PRINTREGS ; Print the registers.
          LDA       TF0+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          RSR                 ; Return.
*
* Test STB*.
* Store B into the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value stored.
TESTF4    LDB=      X'0506'   ; B = 0x0506.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 339
*                                                         CPU6 instruction #1109
          STB*      TF1+1     ; B -> **(TF1+1).
*                                                         CPU5 instruction # 339
*                                                         CPU6 instruction #1109
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB-.
* Store B using an indexed-addressing mode. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   of the word to store.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address of the
*   word to store.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address of the
*   word to store.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address of the
*   word to store.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This stores the word just as for indexed-indirect,
*   then increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then stores the
*   word just as for indexed-indirect.
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to store.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This stores the
*   word just as for indexed-displaced, then increments the register by two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then stores the word just as for indexed-displaced.
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address of the
*   word to store.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This stores the word just as for indexed-displaced-indirect,
*   then increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then stores the word just
*   as for indexed-displaced-indirect.
*
* The indexed (I) mode will always get encoded as one of the implicit register
* STBs (F8-FF) because those are shorter. The syntax is identical, but the
* encodings are completely different. The encoding is provided here. See the
* implicit register STBs (F8-FF) for actual syntax.
TESTF5    LDB/      WORD0     ; B = *WORD0.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 340
*                                                         CPU6 instruction #1110
          DW        X'F500'   ; B -> *A (I). [alternate encoding of STB+ A]
*                                                         CPU5 instruction # 340
*                                                         CPU6 instruction #1110
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD1     ; B = *WORD1.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 341
*                                                         CPU6 instruction #1111
          STB+      A+        ; B -> *A; A+2 -> A (IPI).
*                                                         CPU5 instruction # 341
*                                                         CPU6 instruction #1111
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD2     ; B = *WORD2.
          LDA=      TBUFF+2   ; A = two past TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 342
*                                                         CPU6 instruction #1112
          STB-      A-        ; A-2 -> A; B -> *A (IPD).
*                                                         CPU5 instruction # 342
*                                                         CPU6 instruction #1112
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD3     ; B = *WORD3.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 343
*                                                         CPU6 instruction #1113
          STB+      *A        ; B -> **A (II).
*                                                         CPU5 instruction # 343
*                                                         CPU6 instruction #1113
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD4     ; B = *WORD4.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 344
*                                                         CPU6 instruction #1114
          STB+      *A+       ; B -> **A; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 344
*                                                         CPU6 instruction #1114
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD5     ; B = *WORD5.
          LDA=      TBUFFADDR+2 ; A = two past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 345
*                                                         CPU6 instruction #1115
          STB-      *A-       ; A-2 -> A; B -> **A (IIPD).
*                                                         CPU5 instruction # 345
*                                                         CPU6 instruction #1115
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDB/      WORD6     ; B = *WORD6.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 346
*                                                         CPU6 instruction #1116
          STB+      A,3       ; B -> *(A+3) (ID).
*                                                         CPU5 instruction # 346
*                                                         CPU6 instruction #1116
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD7     ; B = *WORD7.
          LDA=      TBUFF-5   ; A = five before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 347
*                                                         CPU6 instruction #1117
          STB+      A+,5      ; B -> *(A+5); A+2 -> A (IDPI).
*                                                         CPU5 instruction # 347
*                                                         CPU6 instruction #1117
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD8     ; B = *WORD8.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 348
*                                                         CPU6 instruction #1118
          STB-      A-,5      ; A-2 -> A; B -> *(A+5) (IDPD).
*                                                         CPU5 instruction # 348
*                                                         CPU6 instruction #1118
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORD9     ; B = *WORD9.
          LDA=      TBUFFADDR-3 ; A = three before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 349
*                                                         CPU6 instruction #1119
          STB+      *A,3      ; **(A+3) -> B (IDI).
*                                                         CPU5 instruction # 349
*                                                         CPU6 instruction #1119
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORDA     ; B = *WORDA.
          LDA=      TBUFFADDR+1 ; A = one past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 350
*                                                         CPU6 instruction #11206
          STB+      *A+,-1    ; B -> **(A-1); A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 350
*                                                         CPU6 instruction #11206
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDB/      WORDB     ; B = *WORDB.
          LDA=      TBUFFADDR-1 ; A = one before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 351
*                                                         CPU6 instruction #1121
          STB-      *A-,3     ; A-2 -> A; B -> **(A+3) (IDIPD).
*                                                         CPU5 instruction # 351
*                                                         CPU6 instruction #1121
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test MMIO.
* Memory-mapped input/output instructions. There are four instructions to load
* and store word and bytes to MMIO memory addresses. This allows access to the
* MMIO addresses without them being mapped in. Note that the byte versions use
* the word register name, but the lower byte of the word is the part of the
* register actually used. The first argument is the source or destination
* register, the second argument is the index register containing the MMIO
* address, and an optional third argument allows for a signed byte displacement
* to the index register to form the MMIO address.
TESTF6
*         JMP/      TESTILL                               CPU5 illegal start
          LDA=      X'F200'   ; MUX0 control/status.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1122
          LIO       Z,A       ; Load MUX0 status in ZH, data in ZL.
*                                                         CPU6 instruction #1122
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1122
          LIO       Z,A,2     ; Load MUX1 status in ZH, data in ZL.
*                                                         CPU6 instruction #1122
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1123
          LIOB      Z,A       ; Load MUX0 status in ZL.
*                                                         CPU6 instruction #1123
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1123
          LIOB      Z,A,1     ; Load MUX0 data in ZL.
*                                                         CPU6 instruction #1123
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'C5C8'   ; 9600 baud/7E1 and ASCII H.
          XAZ                 ; A -> Z.
          LDA=      X'F202'   ; MUX1 control/status.
          LDB=      X'F203'   ; MUX1 data.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1124
          SIO       Z,A       ; Store MUX1 control and data at once from ZH/ZL.
*                                                         CPU6 instruction #1124
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1124
          SIO       Z,B,-1    ; Store MUX1 control and data at once from ZH/ZL.
*                                                         CPU6 instruction #1124
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1125
          SIOB      Z,B       ; Store MUX1 data from ZL.
*                                                         CPU6 instruction #1125
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1125
          SIOB      Z,A,1     ; Store MUX1 data from ZL.
*                                                         CPU6 instruction #1125
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test MVL.
* Copies a fixed-length string to another. Unlike ZAD, MVF, and MVFR, which have
* limited string lengths, MVL has no limit beyond addressable memory. The opcode
* takes no arguments. There are three registers which must be set up before the
* MVL call in order to work:
*   A = length to copy minus one.
*   B = address of source string.
*   Y = address of destination string.
* The strings can overlap, providing for interesting behavior like unlimited-
* length fills. See also ZAD, MVF, MVFR, and FIL.
TESTF7
*         JMP/      TESTILL                               CPU5 illegal start
          MVF       (8)=X'1122334455667788',/TBUFF+8 ; Create source string.
          LDA=      8-1       ; String length minus one.
          LDB=      TBUFF+8   ; Source address.
          XFR=      TBUFF,Y   ; Destination address.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #1126
          MVL                 ; Move long.
*                                                         CPU6 instruction #1126
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT16    ; Print the destination and source buffers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test STB+/STB- implicit A.
* Store B using register A whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTF8    LDA=      TBUFF     ; A = TBUFF.
          LDB/      WORD0     ; B = *WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 352
*                                                         CPU6 instruction #1127
          STB+      A         ; B -> *A.
*                                                         CPU5 instruction # 352
*                                                         CPU6 instruction #1127
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit B.
* Store B using register B whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic. This clearly
* makes no sense to do in almost any case.
TESTF9    LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 353
*                                                         CPU6 instruction #1128
          STB+      B         ; B -> *B.
*                                                         CPU5 instruction # 353
*                                                         CPU6 instruction #1128
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit X.
* Store B using register X whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFA    STX-      S-        ; Push X to the stack.
          LDX=      TBUFF     ; X = TBUFF.
          LDB/      WORD2     ; B = *WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 354
*                                                         CPU6 instruction #1129
          STB+      X         ; B -> *X.
*                                                         CPU5 instruction # 354
*                                                         CPU6 instruction #1129
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STB+/STB- implicit Y.
* Store B using register Y whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFB    LDA=      TBUFF     ; A = TBUFF.
          XAY                 ; A -> Y.
          LDB/      WORD3     ; B = *WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 355
*                                                         CPU6 instruction #1130
          STB+      Y         ; B -> *Y.
*                                                         CPU5 instruction # 355
*                                                         CPU6 instruction #1130
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit Z.
* Store B using register Z whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFC    LDA=      TBUFF     ; A = TBUFF.
          XAZ                 ; A -> Z.
          LDB/      WORD4     ; B = *WORD4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 356
*                                                         CPU6 instruction #1131
          STB+      Z         ; B -> *Z.
*                                                         CPU5 instruction # 356
*                                                         CPU6 instruction #1131
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit S.
* Store B using register S whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFD    XFR       S,Z       ; S -> Z.
          LDA=      TBUFF     ; A = TBUFF.
          LDB/      WORD5     ; B = *WORD5.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,S       ; A -> S.
*                                                         CPU5 instruction # 357
*                                                         CPU6 instruction #1132
          STB+      S         ; B -> *S.
*                                                         CPU5 instruction # 357
*                                                         CPU6 instruction #1132
          XFR       Z,S       ; Z -> S.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit C.
* Store B using register C whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFE    XFR       C,Z       ; C -> Z.
          LDA=      TBUFF     ; A = TBUFF.
          LDB/      WORD6     ; B = *WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,C       ; A -> C.
*                                                         CPU5 instruction # 358
*                                                         CPU6 instruction #1133
          STB+      C         ; B -> *C.
*                                                         CPU5 instruction # 358
*                                                         CPU6 instruction #1133
          XFR       Z,C       ; Z -> C.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* Test STB+/STB- implicit P.
* Store B using register P whose value is used as the address of the word to
* store. Either the + or - suffix is acceptable on the mnemonic.
TESTFF
*                                                         CPU5 illegal start
          LDB=      TFFDONE   ; B = TFFDONE.
          STB/      PRX       ; Store return address for P printing.
*                                                         CPU5 illegal end
          LDA=      TBUFF     ; A = TBUFF.
          LDB/      WORD7     ; B = *WORD7.
          JSR/      SETFLAGS0 ; Reset flags.
          XFR       A,P       ; A -> P.
*                                                         CPU5 instruction # 359
*                                                         CPU6 instruction #1134
          STB+      P         ; B -> *P.
*                                                         CPU5 instruction # 359
*                                                         CPU6 instruction #1134
*         JSR/      PRINTREGS                             CPU5 illegal start
          JMP/      PRINTREGP ; Print the registers including P.
*                                                         CPU5 illegal end
TFFDONE   JSR/      HEXT2     ; Print the first word of TBUFF.
          RSR                 ; Return.
*
* End of source.
          END      ENTRY      ; Set the entry point.
