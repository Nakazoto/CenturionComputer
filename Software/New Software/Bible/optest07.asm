* Centurion Opcode Tester (00-7F) by ren14500. Public domain.
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
          TITLE     'OPTEST07'
ZOPTEST07 BEGIN     X'0100'
*
* Service call handler, which must be at 0x0100. Our SVC handler simply jumps
* to the address in A.
X0100     JMP+      A         ; Jump to the address in A.
*
* Address of the PRINTNULL subroutine. This must be at 0x0102 for use by tests.
X0102     DW        PRINTNULL
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
*
* Buffer for opcode test use.
TBUFF     DB        X'FF',48  ; Initialize to all bits set.
BN1       EQU       TBUFF
BN2       EQU       BN1+16
BN3       EQU       BN2+16
MB1       EQU       TBUFF
MB2       EQU       MB1+16
TBUFFADDR DW        TBUFF
*                                                         CPU5 illegal start
*
* Hex dump the first B words of the test buffer. Clobbers A and B.
HEXTBUFF  LDA=      TBUFF     ; A = TBUFF.
          JMP/      HEXBUFF   ; Print the buffer.
*
* Hex dump the first byte of the test buffer. Clobbers A and B.
HEXT1     LDAB      TBUFF     ; AL = first byte of TBUFF.
          JSR/      HEXBYTE   ; Print it.
          JSR/      PRINTNULL ; Get to a newline.
          DW        CRLF
          DB        0
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Hex dump the first 2 bytes of the test buffer. Clobbers A and B.
HEXT2     LDA=      TBUFF     ; A = TBUFF.
          LDB=      2/2       ; B = 1 word.
          JMP/      HBCRLF    ; Dump.
*                                                         CPU5 illegal start
*
* Hex dump the first 16 bytes of the test buffer. Clobbers A and B.
HEXT16    LDA=      TBUFF     ; A = TBUFF.
          LDB=      16/2      ; B = 8 words.
          JMP/      HBCRLF    ; Dump.
*
* Hex dump the first 32 bytes of the test buffer. Clobbers A and B.
HEXT32    LDB=      32/2      ; B = 16 words.
          JMP       HEXTBUFF  ; Dump.
*
* Hex dump the first 48 bytes of the test buffer. Clobbers A and B.
HEXT48    JSR       HEXT32    ; Dump the first 16 words.
          JMP       HEXT16    ; And the last 8.
*
* Print the string.
PSBYTES   EQU       16        ; Length of the print string buffer.
PRINTSTR  JSR/      PRINTNULL ; Print the string.
PSSTR     DB        0,PSBYTES ; The buffer.
PSCRLF    DW        CRLF      ; Carriage return and line feed.
          DB        0         ; Null terminator.
          RSR                 ; Return.
*                                                         CPU5 illegal end
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
* Convert a decimal character to integer value. The character is in AL and the
* value is returned in AL. AL is set to negative on error.
DEC2INT   STB-      S-        ; Push B to the stack.
          LDBB=     '0'       ; Load 0 to
          SABB                ; convert the ASCII to the value.
          XFRB      BL,BU     ; BL -> BU.
          BM        D2IERROR  ; If less than 0, error.
          LDBB=     ':'       ; Load : to
          SABB                ; compare against decimal digits.
          BP        D2IERROR  ; If not less than 9, error.
          JMP       D2IEND    ; Successful end.
D2IERROR  LDB=      -1        ; Signal an error.
D2IEND    XFRB      BU,AL     ; BU -> AL.
          LDB+      S+        ; Pop B from the stack.
          RSR                 ; Return.
*
* Get a one-digit decimal value, converted to integer, returned in A. Print a
* CRLF to get to a new line.
GET1DEC   STBB-     S-        ; Push BL to the stack.
G1D0      CLA                 ; A = 0.
          JSR/      GETONE    ; Get a character.
          JSR       DEC2INT   ; Convert to integer.
          XFRB      AL,AL     ; AL = AL.
          BP        G1D1      ; If no error, continue.
          JSR/      PRINTNULL ; Print.
          DW        X'8788'   ; Beep and (ADDS) backspace.
          DB        0         ; Null terminator.
          JMP       G1D0      ; Get another character.
G1D1      LDBB+     S+        ; Pop BL from the stack.
          JSR/      PRINTNULL ; Get to a newline.
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
 DC '00:HLT 01:NOP 02:SF 03:RF 04:EI 05:DI 06:SL 07:RL 08:CL'
 DW CRLF
 DC '09:RSR 0A:RI 0C:SYN(6) 0D:PCX 0E:DLY 0F:RSV(6)'
 DW CRLF
 DC '10:BL 11:BNL 12:BF 13:BNF 14:BZ 15:BNZ 16:BM 17:BP 18:BGZ 19:BLE'
 DW CRLF
 DC '1A:BS1 1B:BS2 1C:BS3 1D:BS4 1E:BI(6) 1F:BCK(6)'
 DW CRLF
 DC '20:INRB 21:DCRB 22:CLRB 23:IVRB 24:SRRB 25:SLRB 26:RRRB 27:RLRB'
 DW CRLF
 DC '28:INAB 29:DCAB 2A:CLAB 2B:IVAB 2C:SRAB 2D:SLAB'
 DW CRLF
 DC '2E:PAGETABLE(6) 2F:DMA'
 DW CRLF
 DC '30:INR(*)/INC(6) 31:DCR(*)/DEC(6) 32:CLR(*)/CAD(6) 33:IVR(*)/IAD(6)'
 DW CRLF
 DC '34:SRR(*)/SHR(6) 35:SLR(*)/SHL(6) 36:RRR(*)/RTR(6) 37:RLR(*)/RTL(6)'
 DW CRLF
 DC '38:INA 39:DCA 3A:CLA 3B:IVA 3C:SRA 3D:SLA 3E:INX 3F:DCX'
 DW CRLF
 DC '40:ADDB 41:SUBB 42:ANDB 43:ORIB 44:OREB 45:XFRB'
 DW CRLF
 DC '46:BIGNUM(6) 47:MEMBLOCK(6)'
 DW CRLF
 DC '48:AABB 49:SABB 4A:NABB 4B:XAXB 4C:XAYB 4D:XABB 4E:XAZB 4F:XASB'
 DW CRLF
 DC '50:ADD 51:SUB 52:AND 53:ORI 54:ORE 55:XFR 56:EAO(6) 57:DAO(6)'
 DW CRLF
 DC '58:AAB 59:SAB 5A:NAB 5B:XAX 5C:XAY 5D:XAB 5E:XAZ 5F:XAS'
 DW CRLF
 DC '60:LDX= 61:LDX/ 62:LDX$ 63:LDX 64:LDX* 65:LDX+/LDX-'
 DW CRLF
 DC '66:SVC(6) 67:MEMBLOCKR(6)'
 DW CRLF
 DC '68:STX= 69:STX/ 6A:STX$ 6B:STX 6C:STX* 6D:STX+/STX-'
 DW CRLF
 DC '6E:LST(6) 6F:SST(6)'
 DW CRLF
 DC '71:JMP/ 72:JMP$ 73:JMP 74:JMP* 75:JMP+/JMP- 76:EPE(6) 77:MUL(6) 78:DIV(6)'
 DW CRLF
 DC '79:JSR/ 7A:JSR$ 7B:JSR 7C:JSR* 7D:JSR+/JSR- 7E:STK(6) 7F:POP(6)'
 DW CRLF
 DC 'ENTER SELECTION> '
 DB 0
          RSR                 ; Return.
*
* The table of opcode tests.
OPTESTS   DW        TEST00
          DW        TEST01
          DW        TEST02
          DW        TEST03
          DW        TEST04
          DW        TEST05
          DW        TEST06
          DW        TEST07
          DW        TEST08
          DW        TEST09
          DW        TEST0A
          DW        TESTILL
          DW        TEST0C
          DW        TEST0D
          DW        TEST0E
          DW        TEST0F
          DW        TEST10
          DW        TEST11
          DW        TEST12
          DW        TEST13
          DW        TEST14
          DW        TEST15
          DW        TEST16
          DW        TEST17
          DW        TEST18
          DW        TEST19
          DW        TEST1A
          DW        TEST1B
          DW        TEST1C
          DW        TEST1D
          DW        TEST1E
          DW        TEST1F
          DW        TEST20
          DW        TEST21
          DW        TEST22
          DW        TEST23
          DW        TEST24
          DW        TEST25
          DW        TEST26
          DW        TEST27
          DW        TEST28
          DW        TEST29
          DW        TEST2A
          DW        TEST2B
          DW        TEST2C
          DW        TEST2D
          DW        TEST2E
          DW        TEST2F
          DW        TEST30
          DW        TEST31
          DW        TEST32
          DW        TEST33
          DW        TEST34
          DW        TEST35
          DW        TEST36
          DW        TEST37
          DW        TEST38
          DW        TEST39
          DW        TEST3A
          DW        TEST3B
          DW        TEST3C
          DW        TEST3D
          DW        TEST3E
          DW        TEST3F
          DW        TEST40
          DW        TEST41
          DW        TEST42
          DW        TEST43
          DW        TEST44
          DW        TEST45
          DW        TEST46
          DW        TEST47
          DW        TEST48
          DW        TEST49
          DW        TEST4A
          DW        TEST4B
          DW        TEST4C
          DW        TEST4D
          DW        TEST4E
          DW        TEST4F
          DW        TEST50
          DW        TEST51
          DW        TEST52
          DW        TEST53
          DW        TEST54
          DW        TEST55
          DW        TEST56
          DW        TEST57
          DW        TEST58
          DW        TEST59
          DW        TEST5A
          DW        TEST5B
          DW        TEST5C
          DW        TEST5D
          DW        TEST5E
          DW        TEST5F
          DW        TEST60
          DW        TEST61
          DW        TEST62
          DW        TEST63
          DW        TEST64
          DW        TEST65
          DW        TEST66
          DW        TEST67
          DW        TEST68
          DW        TEST69
          DW        TEST6A
          DW        TEST6B
          DW        TEST6C
          DW        TEST6D
          DW        TEST6E
          DW        TEST6F
          DW        TESTILL
          DW        TEST71
          DW        TEST72
          DW        TEST73
          DW        TEST74
          DW        TEST75
          DW        TEST76
          DW        TEST77
          DW        TEST78
          DW        TEST79
          DW        TEST7A
          DW        TEST7B
          DW        TEST7C
          DW        TEST7D
          DW        TEST7E
          DW        TEST7F
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
          DW        TESTILL
*
* Illegal opcode function.
TESTILL   JSR/      PRINTNULL
          DC        'ILLEGAL OPCODE'
          DW        CRLF
          DB        0
          RSR                 ; Return.
*
* Test HLT.
* The processor is halted. The P register is set to the next instruction. The
* processor resumes when an interrupt is received or the RUN switch is
* activated.
TEST00    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   1
*                                                         CPU6 instruction #   1
          HLT                 ; Halt.
*                                                         CPU5 instruction #   1
*                                                         CPU6 instruction #   1
          LDAB/     ABORTFLAG ; Get aborted flag.
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTNULL ; Print result.
          DC        'ABORT: '
          DB        0
          JSR/      HEXNIBBLE ; Print the abort flag value.
T00END    RSR                 ; Return.
*
* Test NOP.
* No operation.
TEST01    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   2
*                                                         CPU6 instruction #   2
          NOP                 ; No operation.
*                                                         CPU5 instruction #   2
*                                                         CPU6 instruction #   2
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SF.
* Sets the fault flag.
TEST02    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   3
*                                                         CPU6 instruction #   3
          SF                  ; Set the fault flag.
*                                                         CPU5 instruction #   3
*                                                         CPU6 instruction #   3
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test RF.
* Resets the fault flag.
TEST03    LDAB=     X'F0'     ; All flags set.
          JSR/      SETFLAGS  ; Set flags.
*                                                         CPU5 instruction #   4
*                                                         CPU6 instruction #   4
          RF                  ; Reset the fault flag.
*                                                         CPU5 instruction #   4
*                                                         CPU6 instruction #   4
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test EI.
* Enables the interrupt system.
TEST04    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   5
*                                                         CPU6 instruction #   5
          EI                  ; Enable interrupt system.
*                                                         CPU5 instruction #   5
*                                                         CPU6 instruction #   5
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DI.
* Disables the interrupt system.
TEST05    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   6
*                                                         CPU6 instruction #   6
          DI                  ; Disable interrupt system.
*                                                         CPU5 instruction #   6
*                                                         CPU6 instruction #   6
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SL.
* Sets the link flag.
TEST06    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   7
*                                                         CPU6 instruction #   7
          SL                  ; Set the link flag.
*                                                         CPU5 instruction #   7
*                                                         CPU6 instruction #   7
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test RL.
* Resets the link flag.
TEST07    LDAB=     X'F0'     ; All flags set.
          JSR/      SETFLAGS  ; Set flags.
*                                                         CPU5 instruction #   8
*                                                         CPU6 instruction #   8
          RL                  ; Reset the link flag.
*                                                         CPU5 instruction #   8
*                                                         CPU6 instruction #   8
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test CL.
* Complements the link flag.
TEST08    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #   9
*                                                         CPU6 instruction #   9
          CL                  ; Complement the link flag.
*                                                         CPU5 instruction #   9
*                                                         CPU6 instruction #   9
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     X'F0'     ; All flags set.
          JSR/      SETFLAGS  ; Set flags.
*                                                         CPU5 instruction #   9
*                                                         CPU6 instruction #   9
          CL                  ; Complement the link flag.
*                                                         CPU5 instruction #   9
*                                                         CPU6 instruction #   9
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test RSR.
* Returns from a subroutine. Performs the following actions to unwind a jump to
* subroutine and return execution to the next instruction after the JSR:
* - Sets PC to X.
* - Pops X from the stack.
* See the JSR suite.
TEST09    JSR/      SETFLAGS0 ; Reset flags.
          JSR       T09RSR    ; Jump to an RSR.
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     X'F0'     ; All flags set.
          JSR/      SETFLAGS  ; Set flags.
          JSR       T09RSR    ; Jump to an RSR.
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 instruction #  10
*                                                         CPU6 instruction #  10
T09RSR    RSR                 ; Return.
*                                                         CPU5 instruction #  10
*                                                         CPU6 instruction #  10
*
* Test RI.
* Returns from an interrupt. Performs the following actions to unwind an
* interrupt and return execution to the instruction that would have executed
* next if not for the interrupt:
* - Sets P to PC (in the interrupt level).
* - Captures C to get previous interrupt level).
* - Sets C to context (in the interrupt level).
* - Switches to the previous interrupt level.
* - Restores the previous interrupt level context from C.
* - Restores the previous interrupt level PC from P.
TEST0A    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  11
*                                                         CPU6 instruction #  11
          RI                  ; Return from interrupt (NOP at level 0).
*                                                         CPU5 instruction #  11
*                                                         CPU6 instruction #  11
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SYN.
* Flash the abort light (for 200 nanoseconds).
TEST0C
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  12
          SYN                 ; Flash abort.
*                                                         CPU6 instruction #  12
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test PCX.
* Transfer PC to X.
TEST0D    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  12
*                                                         CPU6 instruction #  13
          PCX                 ; PC -> X.
*                                                         CPU5 instruction #  12
*                                                         CPU6 instruction #  13
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test DLY.
* Delay 4.55 milliseconds.
TEST0E    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  13
*                                                         CPU6 instruction #  14
          DLY                 ; Delay 4.55 ms.
*                                                         CPU5 instruction #  13
*                                                         CPU6 instruction #  14
          RSR                 ; Return.
*
* Test RSV.
* Return from service call. Performs the following actions to unwind a service
* call and return execution to the next instruction after the SVC:
* - Set P to PC.
* - Increments the stack pointer to skip the SVC argument pushed there.
* - Sets PC to X.
* - Pops X from the stack.
* - Pops the context from the stack.
* See SVC.
TEST0F
*         JMP/      TESTILL                               CPU5 illegal start
          LDA=      T0FRSV    ; A = location for SVC to jump.
          JSR/      SETFLAGS0 ; Reset flags.
          SVC       X'FE'     ; Service call which will jump to our RSV.
          JMP       T0FDONE   ; Upon return from SVC, jump to done.
T0FRSV    CLA                 ; A = 0.
          LDAB+     S         ; AL = top byte on stack, the service call number.
          XAY                 ; A -> Y.
          LDA+      S,1       ; A = word after SVC# = previous X.
          LDB+      S,3       ; B = word after previous X = CPU registers.
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU6 instruction #  15
          RSV                 ; Return from service call.
*                                                         CPU6 instruction #  15
T0FDONE   JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test BL.
* Branches if the Link flag is set.
* The Link flag is reset by RL, set by SL, and complemented by CL.
* The Link flag is reset by all clear instructions.
* The Link flag is set or reset by the shift and rotate instructions.
* The Link flag is cleared and set if an arithmetic (except increment and
* decrement) instruction carries out.
TEST10    LDA=      X'FFFF'   ; A = 65535.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  14
*                                                         CPU6 instruction #  16
          BL        T10PASS   ; Branch if link set.
*                                                         CPU5 instruction #  14
*                                                         CPU6 instruction #  16
          JMP       T10DONE   ; Skip printing on failure.
T10PASS   JSR/      PRINTREGS ; Print the registers.
T10DONE   RSR                 ; Return.
*
* Test BNL.
* Branches if the Link flag is not set.
TEST11    LDA=      2         ; A = 2.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  15
*                                                         CPU6 instruction #  17
          BNL       T11PASS   ; Branch if link not set.
*                                                         CPU5 instruction #  15
*                                                         CPU6 instruction #  17
          JMP       T11DONE   ; Skip printing on failure.
T11PASS   JSR/      PRINTREGS ; Print the registers.
T11DONE   RSR                 ; Return.
*
* Test BF.
* Branches if the Fault flag is set.
* The Fault flag is reset by RF and set by SF.
* The Fault flag is reset by all clear instructions.
* The Fault flag is set or reset by the shift, rotate, and arithmetic
* instructions depending on the msb changing.
TEST12    LDA=      X'7FFF'   ; A = 32767.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  16
*                                                         CPU6 instruction #  18
          BF        T12PASS   ; Branch if fault set.
*                                                         CPU5 instruction #  16
*                                                         CPU6 instruction #  18
          JMP       T12DONE   ; Skip printing on failure.
T12PASS   JSR/      PRINTREGS ; Print the registers.
T12DONE   RSR                 ; Return.
*
* Test BNF.
* Branches if the Fault flag is not set.
TEST13    LDA=      2         ; A = 2.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  17
*                                                         CPU6 instruction #  19
          BNF       T13PASS   ; Branch if fault not set.
*                                                         CPU5 instruction #  17
*                                                         CPU6 instruction #  19
          JMP       T13DONE   ; Skip printing on failure.
T13PASS   JSR/      PRINTREGS ; Print the registers.
T13DONE   RSR                 ; Return.
*
* Test BZ.
* Branches if the Value flag is set.
* The Value flag is set by all clear instructions.
* The Value flag is set or reset by the shift, rotate, arithmetic, logical,
* transfer, and memory instructions if the result is zero or not.
TEST14    LDA=      2         ; A = 2.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          SAB                 ; A - B -> B.
*                                                         CPU5 instruction #  18
*                                                         CPU6 instruction #  20
          BZ        T14PASS   ; Branch if value set.
*                                                         CPU5 instruction #  18
*                                                         CPU6 instruction #  20
          JMP       T14DONE   ; Skip printing on failure.
T14PASS   JSR/      PRINTREGS ; Print the registers.
T14DONE   RSR                 ; Return.
*
* Test BNZ.
* Branches if the Value flag is not set.
TEST15    LDA=      2         ; A = 2.
          LDB=      1         ; B = 1.
          JSR/      SETFLAGS0 ; Reset flags.
          SAB                 ; A - B -> B.
*                                                         CPU5 instruction #  19
*                                                         CPU6 instruction #  21
          BNZ       T15PASS   ; Branch if value not set.
*                                                         CPU5 instruction #  19
*                                                         CPU6 instruction #  21
          JMP       T15DONE   ; Skip printing on failure.
T15PASS   JSR/      PRINTREGS ; Print the registers.
T15DONE   RSR                 ; Return.
*
* Test BM.
* Branches if the Minus flag is set.
* The Minus flag is reset by all clear instructions.
* The Minus flag is set or reset by the shift, rotate, arithmetic, logical,
* transfer, and memory instructions if the result has the msb set or not.
TEST16    LDA=      -2        ; A = -2.
          LDB=      -1        ; B = -1.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  20
*                                                         CPU6 instruction #  22
          BM        T16PASS   ; Branch if minus set.
*                                                         CPU5 instruction #  20
*                                                         CPU6 instruction #  22
          JMP       T16DONE   ; Skip printing on failure.
T16PASS   JSR/      PRINTREGS ; Print the registers.
T16DONE   RSR                 ; Return.
*
* Test BP.
* Branches if the Minus flag is not set.
TEST17    LDA=      2         ; A = 2.
          LDB=      1         ; B = 1.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  21
*                                                         CPU6 instruction #  23
          BP        T17PASS   ; Branch if minus not set.
*                                                         CPU5 instruction #  21
*                                                         CPU6 instruction #  23
          JMP       T17DONE   ; Skip printing on failure.
T17PASS   JSR/      PRINTREGS ; Print the registers.
T17DONE   RSR                 ; Return.
*
* Test BGZ.
* Branches if the Minus and Value flags are not set.
TEST18    LDA=      2         ; A = 2.
          LDB=      1         ; B = 1.
          JSR/      SETFLAGS0 ; Reset flags.
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  22
*                                                         CPU6 instruction #  24
          BGZ       T18PASS   ; Branch if minus and value not set.
*                                                         CPU5 instruction #  22
*                                                         CPU6 instruction #  24
          JMP       T18DONE   ; Skip printing on failure.
T18PASS   JSR/      PRINTREGS ; Print the registers.
T18DONE   RSR                 ; Return.
*
* Test BLE.
* Branches if the Minus or Value flag is set.
TEST19    LDA=      2         ; A = 2.
          LDB=      2         ; B = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          SAB                 ; A - B -> B.
*                                                         CPU5 instruction #  23
*                                                         CPU6 instruction #  25
          BLE       T19PASS   ; Branch if minus or value set.
*                                                         CPU5 instruction #  23
*                                                         CPU6 instruction #  25
          JMP       T19DONE   ; Skip printing on failure.
T19PASS   JSR/      PRINTREGS ; Print the registers.
T19DONE   RSR                 ; Return.
*
* Test BS1.
* Branch if Sense Switch 1 is set.
TEST1A    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  24
*                                                         CPU6 instruction #  26
          BS1       T1APASS   ; Branch if sense switch 1 set.
*                                                         CPU5 instruction #  24
*                                                         CPU6 instruction #  26
          JMP       T1ADONE   ; Skip printing on failure.
T1APASS   JSR/      PRINTREGS ; Print the registers.
T1ADONE   RSR                 ; Return.
*
* Test BS2.
* Branch if Sense Switch 2 is set.
TEST1B    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  25
*                                                         CPU6 instruction #  27
          BS2       T1BPASS   ; Branch if sense switch 2 set.
*                                                         CPU5 instruction #  25
*                                                         CPU6 instruction #  27
          JMP       T1BDONE   ; Skip printing on failure.
T1BPASS   JSR/      PRINTREGS ; Print the registers.
T1BDONE   RSR                 ; Return.
*
* Test BS3.
* Branch if Sense Switch 3 is set.
TEST1C    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  26
*                                                         CPU6 instruction #  28
          BS3       T1CPASS   ; Branch if sense switch 3 set.
*                                                         CPU5 instruction #  26
*                                                         CPU6 instruction #  28
          JMP       T1CDONE   ; Skip printing on failure.
T1CPASS   JSR/      PRINTREGS ; Print the registers.
T1CDONE   RSR                 ; Return.
*
* Test BS4.
* Branch if Sense Switch 4 is set.
TEST1D    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  27
*                                                         CPU6 instruction #  29
          BS4       T1DPASS   ; Branch if sense switch 4 set.
*                                                         CPU5 instruction #  27
*                                                         CPU6 instruction #  29
          JMP       T1DDONE   ; Skip printing on failure.
T1DPASS   JSR/      PRINTREGS ; Print the registers.
T1DDONE   RSR                 ; Return.
*
* Test BI.
* Branch if interrupts are enabled. See EI/DI.
TEST1E
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  30
          BI        T1EPASS   ; Branch if interrupts enabled.
*                                                         CPU6 instruction #  30
          JMP       T1EDONE   ; Skip printing on failure.
T1EPASS   JSR/      PRINTREGS ; Print the registers.
T1EDONE   RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test BCK.
* Branch if the clock interrupt is enabled. See ECK/DCK.
TEST1F
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  31
          BCK       T1FDONE   ; Branch if clock interrupt enabled.
*                                                         CPU6 instruction #  31
          JSR/      PRINTREGS ; Print the registers.
T1FDONE   RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test INRB.
* Increment a byte register. Any upper or lower register can be specified. The
* assembler will rewrite "INRB AL" as "INAB". On CPU6, an optional amount up to
* 16 is allowed.
TEST20    LDB=      0         ; BU = 0, BL = 0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  28
*                                                         CPU6 instruction #  32
          INRB      BU        ; Increment BU.
*                                                         CPU5 instruction #  28
*                                                         CPU6 instruction #  32
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  32
          INRB      BL,2      ; Increment BL by 2.
*                                                         CPU6 instruction #  32
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test DCRB.
* Decrement a byte register. Any upper or lower register can be specified. The
* assembler will rewrite "DCRB AL" as "DCAB". On CPU6, an optional amount up to
* 16 is allowed.
TEST21    LDB=      X'0404'   ; BU = 4, BL = 4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  29
*                                                         CPU6 instruction #  33
          DCRB      BU        ; Decrement BU.
*                                                         CPU5 instruction #  29
*                                                         CPU6 instruction #  33
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  33
          DCRB      BL,2      ; Decrement BL by 2.
*                                                         CPU6 instruction #  33
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test CLRB.
* Clear (or set on CPU6) a byte register. Any upper or lower register can be
* specified. The assembler will rewrite "CLRB AL" as "CLAB". On CPU6, an
* optional value up to 15 is allowed to set instead of the default 0.
TEST22    LDB=      X'0404'   ; BU = 4, BL = 4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  30
*                                                         CPU6 instruction #  34
          CLRB      BU        ; BU = 0.
*                                                         CPU5 instruction #  30
*                                                         CPU6 instruction #  34
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  34
          CLRB      BL,2      ; BL = 2.
*                                                         CPU6 instruction #  34
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test IVRB.
* Invert (and add on CPU6) a byte register. Any upper or lower register can be
* specified. The assembler will rewrite "IVRB AL" as "IVAB". On CPU6, an
* optional value up to 15 is allowed and will be added after inverting. That
* means while "IVRB BL" performs a one's complement, "IVRB BL,1" performs a
* two's complement in a single instruction.
TEST23    LDB=      X'0101'   ; BU = 1, BL = 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  31
*                                                         CPU6 instruction #  35
          IVRB      BU        ; BU = ~BU.
*                                                         CPU5 instruction #  31
*                                                         CPU6 instruction #  35
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  35
          IVRB      BL,1      ; BL = -BL.
*                                                         CPU6 instruction #  35
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test SRRB.
* Arithmetic shift right a byte register. Any upper or lower register can be
* specified. The assembler will rewrite "SRRB AL" as "SRAB". On CPU6, an
* optional value in the range [1, 16] is allowed to shift by that many bits.
* To perform a logical shift right, use "RL" and "RRRB" to shift right once
* and then SRRB to shift the rest.
TEST24    LDB=      X'0404'   ; BU = 4, BL = 4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  32
*                                                         CPU6 instruction #  36
          SRRB      BU        ; BU >>= 1 (arithmetic).
*                                                         CPU5 instruction #  32
*                                                         CPU6 instruction #  36
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  36
          SRRB      BL,2      ; BL >>= 2 (arithmetic).
*                                                         CPU6 instruction #  36
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          LDB=      X'FCFC'   ; BU = -4, BL = -4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  32
*                                                         CPU6 instruction #  36
          SRRB      BU        ; BU >>= 1 (arithmetic).
*                                                         CPU5 instruction #  32
*                                                         CPU6 instruction #  36
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  36
          SRRB      BL,2      ; BL >>= 2 (arithmetic).
*                                                         CPU6 instruction #  36
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test SLRB.
* Logical shift left a byte register. Any upper or lower register can be
* specified. The assembler will rewrite "SLRB AL" as "SLAB". On CPU6, an
* optional value in the range [1, 16] is allowed to shift by that many bits.
TEST25    LDB=      X'0404'   ; BU = 4, BL = 4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  33
*                                                         CPU6 instruction #  37
          SLRB      BU        ; BU <<= 1.
*                                                         CPU5 instruction #  33
*                                                         CPU6 instruction #  37
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  37
          SLRB      BL,2      ; BL <<= 2.
*                                                         CPU6 instruction #  37
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          LDB=      X'FCFC'   ; BU = -4, BL = -4.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  33
*                                                         CPU6 instruction #  37
          SLRB      BU        ; BU <<= 1.
*                                                         CPU5 instruction #  33
*                                                         CPU6 instruction #  37
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  37
          SLRB      BL,2      ; BL <<= 2.
*                                                         CPU6 instruction #  37
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test RRRB.
* Rotate right a byte register with link flag. The link flag becomes bit 7,
* bits 7-1 shift down to 6-0, and bit 0 goes into the link flag. Any upper or
* lower register can be specified. On CPU6, an optional value in the range [1,
* 16] is allowed to rotate that many times. When the link flag is reset first,
* a single rotate right is the same as a logical shift right. When the link
* flag is a copy of the lowest bit, it is a normal rotate.
TEST26    LDB=      X'0102'   ; BU = 1, BL = 2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  34
*                                                         CPU6 instruction #  38
          RRRB      BU        ; BU >>= 1 (logical).
*                                                         CPU5 instruction #  34
*                                                         CPU6 instruction #  38
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  38
          RRRB      BL,2      ; Rotate two zeros in.
*                                                         CPU6 instruction #  38
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          LDB=      X'0102'   ; BU = 1, BL = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU5 instruction #  34
*                                                         CPU6 instruction #  38
          RRRB      BU        ; Rotate a one in.
*                                                         CPU5 instruction #  34
*                                                         CPU6 instruction #  38
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction #  38
          RRRB      BL,2      ; Rotate a one then zero in.
*                                                         CPU6 instruction #  38
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test RLRB.
* Rotate left a byte register with link flag. The link flag becomes bit 0, bits
* 6-0 shift up to 7-1, and bit 7 goes into the link flag. Any upper or lower
* register can be specified. On CPU6, an optional value in the range [1, 16] is
* allowed to rotate that many times. When the link flag is reset first, a
* single rotate left is the same as a logical shift left. When the link flag is
* set first, a single rotate left is the same as multiply by two and add one.
* When the link flag is a copy of the highest bit, it is a normal rotate.
TEST27    LDB=      X'8040'   ; BU = 128, BL = 64.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  35
*                                                         CPU6 instruction #  39
          RLRB      BU        ; BU <<= 1.
*                                                         CPU5 instruction #  35
*                                                         CPU6 instruction #  39
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  39
          RLRB      BL,2      ; Rotate two zeros in.
*                                                         CPU6 instruction #  39
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          LDB=      X'0102'   ; BU = 1, BL = 2.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU5 instruction #  35
*                                                         CPU6 instruction #  39
          RLRB      BU        ; (BU * 2) + 1 -> BU.
*                                                         CPU5 instruction #  35
*                                                         CPU6 instruction #  39
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction #  39
          RLRB      BL,2      ; ((BU * 2) + 1) * 2 -> BU.
*                                                         CPU6 instruction #  39
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test INAB.
* Increment AL.
TEST28    LDAB=     0         ; AL = 0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  36
*                                                         CPU6 instruction #  40
          INAB                ; Increment AL.
*                                                         CPU5 instruction #  36
*                                                         CPU6 instruction #  40
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DCAB.
* Decrement AL.
TEST29    LDAB=     1         ; AL = 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  37
*                                                         CPU6 instruction #  41
          DCAB                ; Decrement AL.
*                                                         CPU5 instruction #  37
*                                                         CPU6 instruction #  41
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test CLAB.
* Clear AL.
TEST2A    LDAB=     123       ; AL = 123.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  38
*                                                         CPU6 instruction #  42
          CLAB                ; Clear AL.
*                                                         CPU5 instruction #  38
*                                                         CPU6 instruction #  42
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test IVAB.
* Invert AL.
TEST2B    LDAB=     X'55'     ; AL = 0x55.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  39
*                                                         CPU6 instruction #  43
          IVAB                ; Invert AL.
*                                                         CPU5 instruction #  39
*                                                         CPU6 instruction #  43
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SRAB.
* Arithmetic shift right AL.
TEST2C    LDAB=     X'55'     ; AL = 0x55.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  40
*                                                         CPU6 instruction #  44
          SRAB                ; AL >>= 1.
*                                                         CPU5 instruction #  40
*                                                         CPU6 instruction #  44
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SLAB.
* Logical shift left AL.
TEST2D    LDAB=     X'55'     ; AL = 0x55.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  41
*                                                         CPU6 instruction #  45
          SLAB                ; AL <<= 1.
*                                                         CPU5 instruction #  41
*                                                         CPU6 instruction #  45
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test PAGETABLE.
*
* All page table instructions take two arguments. There are five addressing
* modes possible for the first argument and four for the second argument:
* - Direct uses a / prefix and provides the address in memory directly.
* - Indexed-displaced uses a - prefix before a word register, comma, and signed
*   byte or unsigned word displacement amount.
* - Double-indexed-displaced uses a - prefix before a word register, an
*   asterisk, another word register, comma, and an optional signed byte or
*   unsigned word displacement amount. The second register cannot be the A
*   register. Despite the use of the asterisk, the behavior is to add the two
*   registers and the displacement to form the address.
* - Indexed uses a - prefix before a word register.
* - Literal uses an = prefix before the literal value. This cannot be used for
*   the second argument.
TEST2E
*         JMP/      TESTILL                               CPU5 illegal start
          LDAB=     ((32-1)*8)+0 ; All of map 0.
T2ELOOP   STAB      T2ESTM+2  ; Store in STM literal.
T2ESTM    STM       =0,/TBUFF ; Store map.
          JSR/      HEXT32    ; Print the test buffer.
          LDAB      T2ESTM+2  ; Get current value from STM literal.
          INAB                ; AL += 1.
          BNZ       T2ELOOP   ; If not rolled over to 0, loop.
          STM       =((32-1)*8)+0,/TBUFF ; Store map 0 so the LDM test works.
          JSR/      PRINTNULL ; Print menu items.
          DC '0:LDM 1:STM 2:LSM 3:SSM 4:FLM'
          DW CRLF
          DC 'ENTER SELECTION> '
          DB 0
          JSR/      GET1DEC   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS2E ; Test function table -> B.
          AAB                 ; A + B -> B.
          JMP+      *B        ; Jump to the selected function.
OPTESTS2E DW        TEST2E0
          DW        TEST2E1
          DW        TEST2E2
          DW        TEST2E3
          DW        TEST2E4
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
          DW        TESTILL
*
* Test PAGETABLE LDM.
* Load page table mappings from memory. The first argument encodes (in a byte)
* the number of mappings to load (minus 1) in the upper 5 bits and which map
* in the lower 3 bits. E.g., to load the first 16 mappings for map 7, the first
* argument must evaluate to ((16-1)*8)+7 = 0x7F. The second argument must point
* at the memory buffer to load the mappings from.
*
* Note: this instruction can be thought of as "load the first n mappings" and
* FLM is the converse: "load the last n mappings".
*
* The examples all perform exactly the same behavior on the same inputs and
* outputs.
LDM1      DB        ((16-1)*8)+7
TEST2E0   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  46
          LDM       /LDM1,/TBUFF ; Direct, direct.
*                                                         CPU6 instruction #  46
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  47
          LDM       /LDM1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction #  47
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  48
          LDM       /LDM1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction #  48
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  49
          LDM       /LDM1,-A  ; Direct, indexed.
*                                                         CPU6 instruction #  49
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1-2    ; X = 2 bytes before the count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  50
          LDM       -X,2,/TBUFF ; Indexed-displaced, direct.
*                                                         CPU6 instruction #  50
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  51
          LDM       -X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  51
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  52
          LDM       -X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  52
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  53
          LDM       -X,2,-A   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction #  53
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LDM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LDM1-(LDM1/2)-5 ; X = rest of way to count/map minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  54
          LDM       -X*Y,5,/TBUFF ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction #  54
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LDM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LDM1-(LDM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  55
          LDM       -X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  55
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LDM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LDM1-(LDM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  56
         LDM -X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  56
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LDM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LDM1-(LDM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  57
          LDM       -X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction #  57
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1      ; X = count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  58
          LDM       -X,/TBUFF ; Indexed, direct.
*                                                         CPU6 instruction #  58
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1      ; X = count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  59
          LDM       -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction #  59
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1      ; X = count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  60
          LDM       -X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction #  60
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LDM1      ; X = count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  61
          LDM       -X,-A     ; Indexed, indexed.
*                                                         CPU6 instruction #  61
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  62
          LDM       =((32-1)*8)+0,/TBUFF ; Literal, direct.
*                                                         CPU6 instruction #  62
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  63
          LDM       =((32-1)*8)+0,-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction #  63
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  64
          LDM       =((32-1)*8)+0,-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction #  64
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  65
          LDM       =((32-1)*8)+0,-A ; Literal, indexed.
*                                                         CPU6 instruction #  65
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test PAGETABLE STM.
* Store page table mappings to memory. The first argument encodes (in a byte)
* the number of mappings to store (minus 1) in the upper 5 bits and which map in
* the lower 3 bits. E.g., to store all 32 mappings from map 0, the first
* argument must evaluate to ((32-1)*8)+0 = 0xF8. The second argument must point
* at the memory buffer where the mapping should be stored.
*
* Note: this instruction can be thought of as "store the first n mappings" and
* the unnamed instruction is the converse: "store the last n mappings". The
* unnamed instruction (selector 5) does not seem to actually work though.
*
* The examples all perform exactly the same behavior on the same inputs and
* outputs. The result buffer is just displayed once at the end.
STM1      DB        ((32-1)*8)+0
TEST2E1   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  66
          STM       /STM1,/TBUFF ; Direct, direct.
*                                                         CPU6 instruction #  66
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  67
          STM       /STM1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction #  67
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  68
          STM       /STM1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction #  68
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  69
          STM       /STM1,-A  ; Direct, indexed.
*                                                         CPU6 instruction #  69
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1-2    ; X = 2 bytes before the count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  70
          STM       -X,2,/TBUFF ; Indexed-displaced, direct.
*                                                         CPU6 instruction #  70
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  71
          STM       -X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  71
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  72
          STM       -X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  72
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  73
          STM       -X,2,-A   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction #  73
          JSR/      PRINTREGS ; Print the registers.
          LDA=      STM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      STM1-(STM1/2)-5 ; X = rest of way to count/map minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  74
          STM       -X*Y,5,/TBUFF ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction #  74
          JSR/      PRINTREGS ; Print the registers.
          LDA=      STM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      STM1-(STM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  75
          STM       -X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  75
          JSR/      PRINTREGS ; Print the registers.
          LDA=      STM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      STM1-(STM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  76
         STM -X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  76
          JSR/      PRINTREGS ; Print the registers.
          LDA=      STM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      STM1-(STM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  77
          STM       -X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction #  77
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1      ; X = count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  78
          STM       -X,/TBUFF ; Indexed, direct.
*                                                         CPU6 instruction #  78
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1      ; X = count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  79
          STM       -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction #  79
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1      ; X = count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  80
          STM       -X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction #  80
          JSR/      PRINTREGS ; Print the registers.
          LDX=      STM1      ; X = count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  81
          STM       -X,-A     ; Indexed, indexed.
*                                                         CPU6 instruction #  81
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  82
          STM       =((32-1)*8)+0,/TBUFF ; Literal, direct.
*                                                         CPU6 instruction #  82
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  83
          STM       =((32-1)*8)+0,-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction #  83
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  84
          STM       =((32-1)*8)+0,-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction #  84
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  85
          STM       =((32-1)*8)+0,-A ; Literal, indexed.
*                                                         CPU6 instruction #  85
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test PAGETABLE LSM.
* Load a single page table mapping from memory. The first argument encodes (in
* a byte) the index of the mapping to load in the upper 5 bits and which map
* in the lower 3 bits. E.g., to load mapping 3 for map 6, the first argument
* must evaluate to (3*8)+6 = 0x1E. The second argument must point at the memory
* buffer to load the mapping from.
*
* The examples all perform exactly the same behavior on the same inputs and
* outputs.
LSM1      DB        (3*8)+6
TEST2E2   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  86
          LSM       /LSM1,/TBUFF ; Direct, direct.
*                                                         CPU6 instruction #  86
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  87
          LSM       /LSM1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction #  87
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  88
          LSM       /LSM1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction #  88
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  89
          LSM       /LSM1,-A  ; Direct, indexed.
*                                                         CPU6 instruction #  89
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1-2    ; X = 2 bytes before the count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  90
          LSM       -X,2,/TBUFF ; Indexed-displaced, direct.
*                                                         CPU6 instruction #  90
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  91
          LSM       -X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  91
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  92
          LSM       -X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  92
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  93
          LSM       -X,2,-A   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction #  93
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LSM1-(LSM1/2)-5 ; X = rest of way to count/map minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  94
          LSM       -X*Y,5,/TBUFF ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction #  94
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LSM1-(LSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  95
          LSM       -X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction #  95
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LSM1-(LSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  96
         LSM -X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction #  96
          JSR/      PRINTREGS ; Print the registers.
          LDA=      LSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      LSM1-(LSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  97
          LSM       -X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction #  97
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1      ; X = count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  98
          LSM       -X,/TBUFF ; Indexed, direct.
*                                                         CPU6 instruction #  98
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1      ; X = count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction #  99
          LSM       -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction #  99
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1      ; X = count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 100
          LSM       -X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 100
          JSR/      PRINTREGS ; Print the registers.
          LDX=      LSM1      ; X = count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 101
          LSM       -X,-A     ; Indexed, indexed.
*                                                         CPU6 instruction # 101
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 102
          LSM       =(3*8)+6,/TBUFF ; Literal, direct.
*                                                         CPU6 instruction # 102
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 103
          LSM       =(3*8)+6,-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 103
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 104
          LSM       =(3*8)+6,-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 104
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 105
          LSM       =(3*8)+6,-A ; Literal, indexed.
*                                                         CPU6 instruction # 105
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test PAGETABLE SSM.
* Store a single table mapping to memory. The first argument encodes (in a byte)
* the index of the mapping to store in the upper 5 bits and which map in the
* lower 3 bits. E.g., to store mapping 1 from map 0, the first argument must
* evaluate to (1*8)+0 = 0x08. The second argument must point at the memory
* buffer where the mapping should be stored.
*
* The examples all perform exactly the same behavior on the same inputs and
* outputs. The result buffer is just displayed once at the end.
SSM1      DB        (1*8)+0
TEST2E3   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 106
          SSM       /SSM1,/TBUFF ; Direct, direct.
*                                                         CPU6 instruction # 106
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 107
          SSM       /SSM1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 107
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 108
          SSM       /SSM1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 108
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 109
          SSM       /SSM1,-A  ; Direct, indexed.
*                                                         CPU6 instruction # 109
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1-2    ; X = 2 bytes before the count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 110
          SSM       -X,2,/TBUFF ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 110
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 111
          SSM       -X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 111
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 112
          SSM       -X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 112
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 113
          SSM       -X,2,-A   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 113
          JSR/      PRINTREGS ; Print the registers.
          LDA=      SSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      SSM1-(SSM1/2)-5 ; X = rest of way to count/map minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 114
          SSM       -X*Y,5,/TBUFF ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 114
          JSR/      PRINTREGS ; Print the registers.
          LDA=      SSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      SSM1-(SSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 115
          SSM       -X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 115
          JSR/      PRINTREGS ; Print the registers.
          LDA=      SSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      SSM1-(SSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 116
         SSM -X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 116
          JSR/      PRINTREGS ; Print the registers.
          LDA=      SSM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      SSM1-(SSM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 117
          SSM       -X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 117
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1      ; X = count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 118
          SSM       -X,/TBUFF ; Indexed, direct.
*                                                         CPU6 instruction # 118
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1      ; X = count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 119
          SSM       -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 119
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1      ; X = count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 120
          SSM       -X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 120
          JSR/      PRINTREGS ; Print the registers.
          LDX=      SSM1      ; X = count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 121
          SSM       -X,-A     ; Indexed, indexed.
*                                                         CPU6 instruction # 121
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 122
          SSM       =(1*8)+0,/TBUFF ; Literal, direct.
*                                                         CPU6 instruction # 122
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 123
          SSM       =(1*8)+0,-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 123
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 124
          SSM       =(1*8)+0,-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 124
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 125
          SSM       =(1*8)+0,-A ; Literal, indexed.
*                                                         CPU6 instruction # 125
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of the test buffer.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test PAGETABLE FLM.
* Load page table mappings from memory. The first argument encodes (in a byte)
* the index of the first mapping to load in the upper 5 bits and which map
* in the lower 3 bits. The number of mappings loaded is 32 minus the index of
* the first. E.g., to load starting at mapping 9 (the last 23 mappings) for map
* 5, the first argument must evaluate to (9*8)+5 = 0x4D. The second argument
* must point at the memory buffer to load the mappings from.
*
* The examples all perform exactly the same behavior on the same inputs and
* outputs.
FLM1      DB        (9*8)+5
TEST2E4   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 126
          FLM       /FLM1,/TBUFF ; Direct, direct.
*                                                         CPU6 instruction # 126
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 127
          FLM       /FLM1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 127
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 128
          FLM       /FLM1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 128
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 129
          FLM       /FLM1,-A  ; Direct, indexed.
*                                                         CPU6 instruction # 129
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1-2    ; X = 2 bytes before the count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 130
          FLM       -X,2,/TBUFF ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 130
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 131
          FLM       -X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 131
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 132
          FLM       -X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 132
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1-2    ; X = 2 bytes before the count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 133
          FLM       -X,2,-A   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 133
          JSR/      PRINTREGS ; Print the registers.
          LDA=      FLM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      FLM1-(FLM1/2)-5 ; X = rest of way to count/map minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 134
          FLM       -X*Y,5,/TBUFF ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 134
          JSR/      PRINTREGS ; Print the registers.
          LDA=      FLM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      FLM1-(FLM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 135
          FLM       -X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 135
          JSR/      PRINTREGS ; Print the registers.
          LDA=      FLM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      FLM1-(FLM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 136
         FLM -X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 136
          JSR/      PRINTREGS ; Print the registers.
          LDA=      FLM1/2    ; A = half way to count/map in memory.
          XAY                 ; A -> Y.
          LDX=      FLM1-(FLM1/2)-5 ; X = rest of way to count/map minus 5.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 137
          FLM       -X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 137
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1      ; X = count/map in memory.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 138
          FLM       -X,/TBUFF ; Indexed, direct.
*                                                         CPU6 instruction # 138
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1      ; X = count/map in memory.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 139
          FLM       -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 139
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1      ; X = count/map in memory.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 140
          FLM       -X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 140
          JSR/      PRINTREGS ; Print the registers.
          LDX=      FLM1      ; X = count/map in memory.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 141
          FLM       -X,-A     ; Indexed, indexed.
*                                                         CPU6 instruction # 141
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 142
          FLM       =(9*8)+5,/TBUFF ; Literal, direct.
*                                                         CPU6 instruction # 142
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF-3   ; A = 3 bytes before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 143
          FLM       =(9*8)+5,-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 143
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF/2   ; A = half way to TBUFF.
          LDB=      TBUFF-(TBUFF/2)-1 ; B = Rest of the way to TBUFF minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 144
          FLM       =(9*8)+5,-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 144
          JSR/      PRINTREGS ; Print the registers.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 145
          FLM       =(9*8)+5,-A ; Literal, indexed.
*                                                         CPU6 instruction # 145
          JSR/      PRINTREGS ; Print the registers.
          STM       =((32-1)*8)+5,/TBUFF ; Store the map we filled.
          JSR/      HEXT32    ; Print it.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test DMA.
*
* All DMA instructions are formatted specially. The first argument is the DMA
* sub-instruction mnemonic. All sub-instructions other than EAB/DAB take a
* second argument which is a word register, even if a byte is expected (the low
* byte of the word register is used).
TEST2F    JSR/      PRINTNULL ; Print menu items.
          DC '0:SAD 1:RAD 2:SCT 3:RCT 4:SDV 5:RDV 6:EAB 7:DAB 8:SMN(6) 9:RMN(6)'
          DW CRLF
          DC 'ENTER SELECTION> '
          DB 0
          JSR/      GET1DEC   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS2F ; Test function table -> B.
          AAB                 ; A + B -> B.
          JMP+      *B        ; Jump to the selected function.
OPTESTS2F DW        TEST2F0
          DW        TEST2F1
          DW        TEST2F2
          DW        TEST2F3
          DW        TEST2F4
          DW        TEST2F5
          DW        TEST2F6
          DW        TEST2F7
          DW        TEST2F8
          DW        TEST2F9
*
* Test DMA SAD.
* Store register to DMA address register.
TEST2F0   LDA=      TBUFF     ; A = address of test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  42
*                                                         CPU6 instruction # 146
          DMA       SAD,A     ; A -> DMA address.
*                                                         CPU5 instruction #  42
*                                                         CPU6 instruction # 146
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA RAD.
* Read DMA address register to a register.
TEST2F1   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  43
*                                                         CPU6 instruction # 147
          DMA       RAD,B     ; DMA address -> B.
*                                                         CPU5 instruction #  43
*                                                         CPU6 instruction # 147
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA SCT.
* Store register to DMA count register.
TEST2F2   LDA=      400       ; A = 400.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  44
*                                                         CPU6 instruction # 148
          DMA       SCT,A     ; A -> DMA count.
*                                                         CPU5 instruction #  44
*                                                         CPU6 instruction # 148
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA RCT.
* Read DMA count register to a register.
TEST2F3   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  45
*                                                         CPU6 instruction # 149
          DMA       RCT,B     ; DMA count -> B.
*                                                         CPU5 instruction #  45
*                                                         CPU6 instruction # 149
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA SDV.
* Set DMA device.
TEST2F4   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  46
*                                                         CPU6 instruction # 150
          DMA       SDV,3     ; Set DMA device #3.
*                                                         CPU5 instruction #  46
*                                                         CPU6 instruction # 150
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA RDV.
* Read DMA mode to register.
TEST2F5   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  47
*                                                         CPU6 instruction # 151
          DMA       RDV,B     ; DMA mode -> BL.
*                                                         CPU5 instruction #  47
*                                                         CPU6 instruction # 151
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA EAB.
* Enable DMA.
TEST2F6   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  48
*                                                         CPU6 instruction # 152
          DMA       EAB       ; Enable DMA.
*                                                         CPU5 instruction #  48
*                                                         CPU6 instruction # 152
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA DAB.
* Disable DMA.
TEST2F7   JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  49
*                                                         CPU6 instruction # 153
          DMA       DAB       ; Disable DMA.
*                                                         CPU5 instruction #  49
*                                                         CPU6 instruction # 153
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DMA SMN.
* Store DMA map number.
TEST2F8
*         JMP/      TESTILL                               CPU5 illegal start
          LDAB=     2         ; AL = 2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 154
          DMA       SMN,A     ; Use page map in AL for DMA.
*                                                         CPU6 instruction # 154
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test DMA RMN.
* Read DMA map number.
TEST2F9
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 155
          DMA       RMN,B     ; Read DMA page map to BL.
*                                                         CPU6 instruction # 155
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test INR/INC.
* Increment a word register or memory. Any word register can be specified for
* INR. Direct and indexed addressing modes are available for INC. The index
* register cannot be the A register. The assembler will rewrite "INR A" as
* "INA" and "INR X" as "INX".
* On CPU6 for INC indexed addressing addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional amount to increment up to 16 is allowed. If an amount is
*   specified, the displacement must be specified.
* On CPU6 for INR and INC direct:
* - an optional amount to increment up to 16 is allowed.
TEST30    CLA                 ; A = 0.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  50
*                                                         CPU6 instruction # 156
          INR       Y         ; Increment Y.
*                                                         CPU5 instruction #  50
*                                                         CPU6 instruction # 156
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 156
          INR       Y,2       ; Increment Y by 2.
*                                                         CPU6 instruction # 156
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 157
          INC/      TBUFF     ; Increment *TBUFF.
*                                                         CPU6 instruction # 157
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 157
          INC/      TBUFF,2   ; Increment *TBUFF by 2.
*                                                         CPU6 instruction # 157
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 158
          INC-      B         ; Increment *B.
*                                                         CPU6 instruction # 158
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 158
          INC-      B,7       ; Increment *(B+7).
*                                                         CPU6 instruction # 158
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 158
          INC-      B,0,2     ; Increment *(B+0) by 2.
*                                                         CPU6 instruction # 158
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test DCR/DEC.
* Decrement a word register or memory. Any word register can be specified for
* DCR. Direct and indexed addressing modes are available for DEC. The index
* register cannot be the A register. The assembler will rewrite "DCR A" as
* "DCA" and "DCR X" as "DCX".
* On CPU6 for DEC indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional amount to decrement up to 16 is allowed. If an amount is
*   specified, the displacement must be specified.
* On CPU6 for DCR and DEC direct addressing:
* - an optional amount to decrement up to 16 is allowed.
TEST31    LDA=      4         ; A = 4.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  51
*                                                         CPU6 instruction # 159
          DCR       Y         ; Decrement Y.
*                                                         CPU5 instruction #  51
*                                                         CPU6 instruction # 159
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 159
          DCR       Y,2       ; Decrement Y by 2.
*                                                         CPU6 instruction # 159
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 160
          DEC/      TBUFF     ; Decrement *TBUFF.
*                                                         CPU6 instruction # 160
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 160
          DEC/      TBUFF,2   ; Decrement *TBUFF by 2.
*                                                         CPU6 instruction # 160
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 161
          DEC-      B         ; Decrement *B.
*                                                         CPU6 instruction # 161
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 161
          DEC-      B,7       ; Decrement *(B+7).
*                                                         CPU6 instruction # 161
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 161
          DEC-      B,0,2     ; Decrement *(B+0) by 2.
*                                                         CPU6 instruction # 161
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test CLR/CAD.
* Clear (or set on CPU6) a word register or memory. Any word register can be
* specified for CLR. Direct and indexed addressing modes are available for CAD.
* The index register cannot be the A register. The assembler will rewrite
* "CLR A" as "CLA".
* On CPU6 for CAD indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value up to 15 is allowed to set instead of the default 0. If a
*   value is specified, the displacement must be specified.
* On CPU6 for CLR and CAD direct addressing:
* - an optional value up to 15 is allowed to set instead of the default 0.
TEST32    LDA=      4         ; A = 4.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  52
*                                                         CPU6 instruction # 162
          CLR       Y         ; Y = 0.
*                                                         CPU5 instruction #  52
*                                                         CPU6 instruction # 162
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 162
          CLR       Y,2       ; Y = 2.
*                                                         CPU6 instruction # 162
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 163
          CAD/      TBUFF     ; *TBUFF = 0.
*                                                         CPU6 instruction # 163
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 163
          CAD/      TBUFF,2   ; *TBUFF = 2.
*                                                         CPU6 instruction # 163
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 164
          CAD-      B         ; *B = 0.
*                                                         CPU6 instruction # 164
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 164
          CAD-      B,7       ; *(B+7) = 0.
*                                                         CPU6 instruction # 164
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 164
          CAD-      B,0,2     ; *(B+0) = 2.
*                                                         CPU6 instruction # 164
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test IVR/IAD.
* Invert (and add on CPU6) a word register or memory. Any word register can be
* specified for IVR. Direct and indexed addressing modes are available for IAD.
* The index register cannot be the A register. The assembler will rewrite
* "IVR A" as "IVA".
* On CPU6 for IAD indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value up to 15 is allowed and will be added after inverting. If
*   a value is specified, the displacement must be specified.
* On CPU6 for IVR and IAD direct addressing:
* - an optional value up to 15 is allowed and will be added after inverting.
TEST33    CLA                 ; A = 0.
          INA                 ; A = 1.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  53
*                                                         CPU6 instruction # 165
          IVR       Y         ; Y = ~Y.
*                                                         CPU5 instruction #  53
*                                                         CPU6 instruction # 165
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 165
          IVR       Y,1       ; Y = -Y.
*                                                         CPU6 instruction # 165
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 166
          IAD/      TBUFF     ; *TBUFF = ~(*TBUFF).
*                                                         CPU6 instruction # 166
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 166
          IAD/      TBUFF,1   ; *TBUFF = -(*TBUFF).
*                                                         CPU6 instruction # 166
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 167
          IAD-      B         ; *B = ~(*B).
*                                                         CPU6 instruction # 167
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 167
          IAD-      B,7       ; *(B+7) = ~(*(B+7)).
*                                                         CPU6 instruction # 167
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 167
          IAD-      B,0,1     ; *(B+0) = -(*(B+0)).
*                                                         CPU6 instruction # 167
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test SRR/SHR.
* Arithmetic shift right a word register or memory. Any word register can be
* specified for SRR. Direct and indexed addressing modes are available for SHR.
* The index register cannot be the A register. The assembler will rewrite
* "SRR A" as "SRA".
* On CPU6 for SHR indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value in the range [1, 16] is allowed to shift by that many
*   bits. If a value is specified, the displacement must be specified.
* On CPU6 for SRR and SHR direct addressing:
* - an optional value in the range [1, 16] is allowed to shift by that many
*   bits.
TEST34    LDA=      256       ; A = 256.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  54
*                                                         CPU6 instruction # 168
          SRR       Y         ; Y >>= 1 (arithmetic).
*                                                         CPU5 instruction #  54
*                                                         CPU6 instruction # 168
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 168
          SRR       Y,2       ; Y >>= 2 (arithmetic).
*                                                         CPU6 instruction # 168
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 169
          SHR/      TBUFF     ; *TBUFF >>= 1 (arithmetic).
*                                                         CPU6 instruction # 169
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 169
          SHR/      TBUFF,2   ; *TBUFF >>= 2 (arithmetic).
*                                                         CPU6 instruction # 169
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 170
          SHR-      B         ; *B >>= 1 (arithmetic).
*                                                         CPU6 instruction # 170
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 170
          SHR-      B,7       ; *(B+7) >>= 1 (arithmetic).
*                                                         CPU6 instruction # 170
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 170
          SHR-      B,0,2     ; *(B+0) >>= 2 (arithmetic).
*                                                         CPU6 instruction # 170
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test SLR/SHL.
* Logical shift left a word register or memory. Any word register can be
* specified for SLR. Direct and indexed addressing modes are available for SHL.
* The index register cannot be the A register. The assembler will rewrite
* "SLR A" as "SLA".
* On CPU6 for SHL indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value in the range [1, 16] is allowed to shift by that many
*   bits. If a value is specified, the displacement must be specified.
* On CPU6 for SLR and SHL direct addressing:
* - an optional value in the range [1, 16] is allowed to shift by that many
*   bits.
TEST35    LDA=      128       ; A = 128.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  55
*                                                         CPU6 instruction # 171
          SLR       Y         ; Y <<= 1.
*                                                         CPU5 instruction #  55
*                                                         CPU6 instruction # 171
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 171
          SLR       Y,2       ; Y <<= 2.
*                                                         CPU6 instruction # 171
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 172
          SHL/      TBUFF     ; *TBUFF <<= 1.
*                                                         CPU6 instruction # 172
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 172
          SHL/      TBUFF,2   ; *TBUFF <<= 2.
*                                                         CPU6 instruction # 172
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 173
          SHL-      B         ; *B <<= 1.
*                                                         CPU6 instruction # 173
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 173
          SHL-      B,7       ; *(B+7) <<= 1.
*                                                         CPU6 instruction # 173
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 173
          SHL-      B,0,2     ; (*B+0) <<= 2.
*                                                         CPU6 instruction # 173
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test RRR/RTR.
* Rotate right a word register or memory with link flag. The link flag becomes
* bit 15, bits 15-1 shift down to 14-0, and bit 0 goes into the link flag. Any
* word register can be specified for RRR. Direct and indexed addressing modes
* are available for RTR. The index register cannot be the A register. When the
* link flag is reset first, a single rotate right is the same as a logical
* shift right. When the link flag is a copy of the lowest bit, it is a normal
* rotate.
* On CPU6 for RTR indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value in the range [1, 16] is allowed to rotate by that many
*   bits. If a value is specified, the displacement must be specified.
* On CPU6 for RRR and RTR direct addressing:
* - an optional value in the range [1, 16] is allowed to rotate by that many
*   bits.
TEST36    LDA=      2         ; A = 2.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  56
*                                                         CPU6 instruction # 174
          RRR       Y         ; Y >>= 1 (logical).
*                                                         CPU5 instruction #  56
*                                                         CPU6 instruction # 174
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 174
          RRR       Y,2       ; Rotate two zeros in to Y.
*                                                         CPU6 instruction # 174
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction # 175
          RTR/      TBUFF     ; Rotate a one in to *TBUFF.
*                                                         CPU6 instruction # 175
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction # 175
          RTR/      TBUFF,2   ; Rotate two ones in to *TBUFF.
*                                                         CPU6 instruction # 175
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 176
          RTR-      B         ; Rotate a zero in to *B.
*                                                         CPU6 instruction # 176
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 176
          RTR-      B,7       ; Rotate a zero in to *(B+7).
*                                                         CPU6 instruction # 176
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 176
          RTR-      B,0,2     ; Rotate two zeros in to *(B+0).
*                                                         CPU6 instruction # 176
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test RLR/RTL.
* Rotate left a word register or memory with link flag. The link flag becomes
* bit 0, bits 14-0 shift up to 15-1, and bit 15 goes into the link flag. Any
* word register can be specified for RLR. Direct and indexed addressing modes
* are available for RTL. The index register cannot be the A register. When the
* link flag is reset first, a single rotate left is the same as a logical
* shift left. When the link flag is set first, a single rotate left is the same
* as multiply by two and add one. When the link flag is a copy of the highest
* bit, it is a normal rotate.
* On CPU6 for RLR indexed addressing:
* - an optional displacement (16-bit) is allowed.
* - an optional value in the range [1, 16] is allowed to rotate by that many
*   bits. If a value is specified, the displacement must be specified.
* On CPU6 for RLR and RTL direct addressing:
* - an optional value in the range [1, 16] is allowed to rotate by that many
*   bits.
TEST37    LDA=      X'0040'   ; A = 64.
          STA/      TBUFF     ; A -> TBUFF.
          XAY                 ; A -> Y.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  57
*                                                         CPU6 instruction # 177
          RLR       Y         ; Y <<= 1.
*                                                         CPU5 instruction #  57
*                                                         CPU6 instruction # 177
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 177
          RLR       Y,2       ; Rotate two zeros in to Y.
*                                                         CPU6 instruction # 177
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction # 178
          RTL/      TBUFF     ; (*TBUFF * 2) + 1 -> *TBUFF.
*                                                         CPU6 instruction # 178
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          JSR/      SETFLAGS0 ; Reset flags.
          SL                  ; Set the link flag.
*                                                         CPU6 instruction # 178
          RTL/      TBUFF,2   ; ((*TBUFF * 2) + 1) * 2 -> *TBUFF.
*                                                         CPU6 instruction # 178
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 179
          RTL-      B         ; *B * 2 -> *B.
*                                                         CPU6 instruction # 179
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF-7   ; B = TBUFF minus 7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 179
          RTL-      B,7       ; *(B+7) * 2 -> *(B+7).
*                                                         CPU6 instruction # 179
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
          LDB=      TBUFF     ; B = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 179
          RTL-      B,0,2     ; *(B+0) * 4 -> *(B+0).
*                                                         CPU6 instruction # 179
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the TBUFF word.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test INA.
* Increment A.
TEST38    CLA                 ; A = 0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  58
*                                                         CPU6 instruction # 180
          INA                 ; Increment A.
*                                                         CPU5 instruction #  58
*                                                         CPU6 instruction # 180
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test DCA.
* Decrement A.
TEST39    CLA                 ; A = 0.
          INA                 ; A = 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  59
*                                                         CPU6 instruction # 181
          DCA                 ; Decrement A.
*                                                         CPU5 instruction #  59
*                                                         CPU6 instruction # 181
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test CLA.
* Clear A.
TEST3A    LDA=      123       ; A = 123.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  60
*                                                         CPU6 instruction # 182
          CLA                 ; Clear A.
*                                                         CPU5 instruction #  60
*                                                         CPU6 instruction # 182
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test IVA.
* Invert A.
TEST3B    LDA=      X'5555'   ; A = 0x5555.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  61
*                                                         CPU6 instruction # 183
          IVA                 ; Invert A.
*                                                         CPU5 instruction #  61
*                                                         CPU6 instruction # 183
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SRA.
* Arithmetic shift right A.
TEST3C    LDA=      X'5555'   ; A = 0x5555.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  62
*                                                         CPU6 instruction # 184
          SRA                 ; A >>= 1.
*                                                         CPU5 instruction #  62
*                                                         CPU6 instruction # 184
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SLA.
* Logical shift left A.
TEST3D    LDA=      X'5555'   ; A = 0x5555.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  63
*                                                         CPU6 instruction # 185
          SLA                 ; A <<= 1.
*                                                         CPU5 instruction #  63
*                                                         CPU6 instruction # 185
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test INX.
* Increment X.
TEST3E    STX-      S-        ; Push X to the stack.
          CLR       X         ; X = 0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  64
*                                                         CPU6 instruction # 186
          INX                 ; Increment X.
*                                                         CPU5 instruction #  64
*                                                         CPU6 instruction # 186
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test DCX.
* Decrement X.
TEST3F    STX-      S-        ; Push X to the stack.
          LDX=      1         ; X = 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  65
*                                                         CPU6 instruction # 187
          DCX                 ; Decrement X.
*                                                         CPU5 instruction #  65
*                                                         CPU6 instruction # 187
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test ADDB.
* Add two byte registers. Any upper or lower register can be specified for both
* arguments. The result is placed in the second argument register. The assembler
* will rewrite "ADDB AL,BL" as "AABB".
TEST40    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  66
*                                                         CPU6 instruction # 188
          ADDB      BL,AL     ; BL + AL -> AL.
*                                                         CPU5 instruction #  66
*                                                         CPU6 instruction # 188
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SUBB.
* Subtract two byte registers. Any upper or lower register can be specified for
* both arguments. The result is placed in the second argument register. The
* assembler will rewrite "SUBB AL,BL" as "SABB".
TEST41    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  67
*                                                         CPU6 instruction # 189
          SUBB      BL,AL     ; BL - AL -> AL.
*                                                         CPU5 instruction #  67
*                                                         CPU6 instruction # 189
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test ANDB.
* Bitwise-AND two byte registers. Any upper or lower register can be specified
* for both arguments. The result is placed in the second argument register. The
* assembler will rewrite "ANDB AL,BL" as "NABB".
TEST42    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  68
*                                                         CPU6 instruction # 190
          ANDB      BL,AL     ; BL & AL -> AL.
*                                                         CPU5 instruction #  68
*                                                         CPU6 instruction # 190
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test ORIB.
* Bitwise-OR two byte registers. Any upper or lower register can be specified
* for both arguments. The result is placed in the second argument register.
TEST43    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  69
*                                                         CPU6 instruction # 191
          ORIB      BL,AL     ; BL | AL -> AL.
*                                                         CPU5 instruction #  69
*                                                         CPU6 instruction # 191
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test OREB.
* Bitwise-XOR two byte registers. Any upper or lower register can be specified
* for both arguments. The result is placed in the second argument register.
TEST44    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  70
*                                                         CPU6 instruction # 192
          OREB      BL,AL     ; BL ^ AL -> AL.
*                                                         CPU5 instruction #  70
*                                                         CPU6 instruction # 192
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XFRB.
* Transfer one byte register to another. Any upper or lower register can be
* specified for both arguments. The contents of the first register is placed in
* the second register. The assembler will rewrite "XFRB AL,BL" as "XABB",
* "XFRB AL,XL" as "XAXB", "XFRB AL,YL" as "XAYB", "XFRB AL,ZL" as "XAZB", and
* "XFRB AL,SL" as "XASB".
TEST45    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  71
*                                                         CPU6 instruction # 193
          XFRB      BL,AL     ; BL -> AL.
*                                                         CPU5 instruction #  71
*                                                         CPU6 instruction # 193
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test BIGNUM.
*
* All big number instructions take two memory arguments. There are five
* addressing modes possible for each argument (except as noted in individual
* instructions):
* - Direct uses a / prefix and provides the address in memory directly.
* - Indexed-displaced uses a - prefix before a word register, comma, and signed
*   byte or unsigned word displacement amount.
* - Double-indexed-displaced uses a - prefix before a word register, an
*   asterisk, another word register, comma, and an optional signed byte or
*   unsigned word displacement amount. The second register cannot be the A
*   register. Despite the use of the asterisk, the behavior is to add the two
*   registers and the displacement to form the address.
* - Indexed uses a - prefix before a word register.
* - Literal uses an = prefix before the literal value. Literal values can be
*   128-bit, unlike most literals which are either byte or word.
* After each argument other than a literal, the length or base of the big number
* referred to by the argument must be included in parenthesis. For literals,
* the length is calculated automatically based on the size of the literal. For
* CTB and CFB, a literal first argument sets the base to the length of the
* literal. The lengths of the two big numbers do not have to be the same.
TEST46
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      PRINTNULL ; Print menu items.
          DC '0:A 1:S 2:C 3:ZAD 4:ZSU 5:M 6:D 7:DRM 8:CTB 9:CFB'
          DW CRLF
          DC 'ENTER SELECTION> '
          DB 0
          JSR/      GET1DEC   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS46 ; Test function table -> B.
          AAB                 ; A + B -> B.
          JMP+      *B        ; Jump to the selected function.
OPTESTS46 DW        TEST460
          DW        TEST461
          DW        TEST462
          DW        TEST463
          DW        TEST464
          DW        TEST465
          DW        TEST466
          DW        TEST467
          DW        TEST468
          DW        TEST469
*
* Test BIGNUM A.
* Add two bignums. The result is placed in the second argument.
TEST460   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 194
          A         /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 194
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 195
          A         /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 195
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 196
          A         /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 196
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 197
          A         /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 197
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 198
T460DL    A         /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 198
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T460DL+5  ; Location of literal.
          LDB=      2         ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 199
          A         -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 199
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 200
          A         -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 200
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 201
          A     -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 201
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 202
          A         -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 202
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 203
T460IDL   A         -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 203
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T460IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 204
          A         -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 204
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 205
          A   -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 205
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 206
     A -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 206
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 207
          A         -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 207
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 208
T460DIDL  A         -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 208
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T460DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 209
          A         -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 209
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 210
          A         -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 210
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 211
          A         -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 211
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 212
          A         -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 212
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 213
T460IL    A         -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 213
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T460IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 214
          A         =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 214
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 215
          A         =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 215
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 216
          A    =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 216
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 217
          A         =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 217
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 218
T460LL    A         =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 218
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T460LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM S.
* Subtract the first bignum from the second. The result is placed in the second
* argument.
TEST461   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 219
          S         /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 219
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 220
          S         /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 220
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 221
          S         /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 221
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 222
          S         /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 222
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 223
T461DL    S         /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 223
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T461DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 224
          S         -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 224
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 225
          S         -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 225
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 226
          S     -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 226
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 227
          S         -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 227
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 228
T461IDL   S         -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 228
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T461IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 229
          S         -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 229
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 230
          S   -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 230
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 231
     S -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 231
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 232
          S         -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 232
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 233
T461DIDL  S         -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 233
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T461DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 234
          S         -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 234
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 235
          S         -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 235
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 236
          S         -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 236
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 237
          S         -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 237
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 238
T461IL    S         -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 238
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T461IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 239
          S         =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 239
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 240
          S         =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 240
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 241
          S    =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 241
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 242
          S         =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 242
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 243
T461LL    S         =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 243
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T461LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM C.
* Compare bignums by subtracting the first bignum from the second. The result
* is discarded. Flags are set based on the result of the subtraction.
TEST462   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 244
          C         /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 244
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 245
          C         /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 245
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 246
          C         /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 246
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 247
          C         /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 247
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 248
          C         /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 248
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 249
          C         -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 249
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 250
          C         -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 250
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 251
          C     -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 251
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 252
          C         -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 252
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 253
          C         -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 253
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 254
          C         -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 254
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 255
          C   -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 255
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 256
     C -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 256
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 257
          C         -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 257
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 258
          C         -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 258
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 259
          C         -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 259
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 260
          C         -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 260
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 261
          C         -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 261
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 262
          C         -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 262
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 263
          C         -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 263
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 264
          C         =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 264
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 265
          C         =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 265
          JSR/      PRINTREGS ; Print the registers.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 266
          C    =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 266
          JSR/      PRINTREGS ; Print the registers.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 267
          C         =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 267
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 268
          C         =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 268
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM ZAD.
* Add zero to the first argument. The result is placed in the second argument.
* See also MVF, MVFR, and MVL.
TEST463   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 269
          ZAD       /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 269
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 270
          ZAD       /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 270
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 271
          ZAD       /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 271
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 272
          ZAD       /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 272
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 273
T463DL    ZAD       /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 273
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T463DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 274
          ZAD       -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 274
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 275
          ZAD       -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 275
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 276
          ZAD   -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 276
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 277
          ZAD       -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 277
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 278
T463IDL   ZAD       -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 278
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T463IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 279
          ZAD       -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 279
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 280
          ZAD -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 280
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 281
   ZAD -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 281
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 282
          ZAD       -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 282
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 283
T463DIDL  ZAD       -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 283
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T463DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 284
          ZAD       -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 284
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 285
          ZAD       -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 285
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 286
          ZAD       -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 286
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 287
          ZAD       -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 287
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 288
T463IL    ZAD       -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 288
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T463IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 289
          ZAD       =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 289
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 290
          ZAD       =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 290
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 291
          ZAD  =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 291
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 292
          ZAD       =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 292
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 293
T463LL    ZAD       =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 293
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T463LL+4  ; Location of literal.
          LDB=      2         ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM ZSU.
* Subtract the first argument from zero. The result is placed in the second
* argument.
TEST464   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 294
          ZSU       /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 294
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 295
          ZSU       /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 295
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 296
          ZSU       /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 296
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 297
          ZSU       /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 297
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 298
T464DL    ZSU       /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 298
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T464DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 299
          ZSU       -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 299
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 300
          ZSU       -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 300
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 301
          ZSU   -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 301
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 302
          ZSU       -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 302
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 303
T464IDL   ZSU       -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 303
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T464IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 304
          ZSU       -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 304
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 305
          ZSU -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 305
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 306
   ZSU -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 306
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 307
          ZSU       -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 307
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; A = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 308
T464DIDL  ZSU       -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 308
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T464DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 309
          ZSU       -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 309
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 310
          ZSU       -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 310
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 311
          ZSU       -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 311
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 312
          ZSU       -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 312
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 313
T464IL    ZSU       -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 313
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T464IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 314
          ZSU       =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 314
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 315
          ZSU       =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 315
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 316
          ZSU  =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 316
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 317
          ZSU       =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 317
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 318
T464LL    ZSU       =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 318
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T464LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM M.
* Multiply two bignums. The result is placed in the second argument.
TEST465   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 319
          M         /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 319
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 320
          M         /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 320
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 321
          M         /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 321
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 322
          M         /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 322
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 323
T465DL    M         /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 323
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T465DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 324
          M         -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 324
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 325
          M         -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 325
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 326
          M     -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 326
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 327
          M         -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 327
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 328
T465IDL   M         -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 328
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T465IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 329
          M         -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 329
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 330
          M   -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 330
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 331
     M -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 331
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 332
          M         -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 332
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 333
T465DIDL  M         -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 333
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T465DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 334
          M         -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 334
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 335
          M         -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 335
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 336
          M         -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 336
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 337
          M         -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 337
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 338
T465IL    M         -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 338
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T465IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 339
          M         =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 339
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 340
          M         =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 340
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 341
          M    =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 341
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 342
          M         =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 342
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 343
T465LL    M         =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 343
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T465LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM D.
* Divide the second bignum by the first. The result is placed in the second
* argument. See also DRM.
TEST466   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 344
          D         /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 344
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 345
          D         /BN1(16),-A,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 345
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 346
          D         /BN1(8),-A*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 346
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 347
          D         /BN1(7),-A(7) ; Direct, indexed.
*                                                         CPU6 instruction # 347
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 348
T466DL    D         /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 348
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T466DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 349
          D         -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 349
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 350
          D         -X,2(16),-A,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 350
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 351
          D     -X,2(8),-A*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 351
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 352
          D         -X,2(7),-A(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 352
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 353
T466IDL   D         -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 353
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T466IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 354
          D         -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 354
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 355
          D   -X*Y,5(16),-A,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 355
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 356
     D -X*Y,5(8),-A*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 356
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 357
          D         -X*Y,5(7),-A(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 357
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 358
T466DIDL  D         -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 358
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T466DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 359
          D         -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 359
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 360
          D         -X(16),-A,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 360
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 361
          D         -X(8),-A*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 361
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 362
          D         -X(7),-A(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 362
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 363
T466IL    D         -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 363
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T466IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 364
          D         =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 364
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDA=      BN2-3     ; A = 3 bytes before BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 365
          D         =-1,-A,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 365
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDA=      BN2/2     ; A = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 366
          D    =X'FDCBA987654322',-A*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 366
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDA=      BN2       ; A = BN2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 367
          D         =-1,-A(7) ; Literal, indexed.
*                                                         CPU6 instruction # 367
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 368
T466LL    D         =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 368
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T466LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM DRM.
* Divide the second bignum by the first. The quotient is placed in the second
* argument. The remainder is placed at the address in A. The remainder must be
* the same size as the first argument. See also D.
TEST467   STK       X,2       ; Push X to the stack.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDE',/BN2(16)
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 369
          DRM       /BN1(16),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 369
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 370
          DRM       /BN1(16),-B,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 370
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'EDCBA987654321',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 371
          DRM       /BN1(8),-Z*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 371
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          FIL       (48)=0,/TBUFF
          ZAD       =X'EDCBA987654321',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDB=      BN2       ; B = BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 372
          DRM       /BN1(7),-B(7) ; Direct, indexed.
*                                                         CPU6 instruction # 372
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =1,/BN1(4)
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 373
T467DL    DRM       /BN1(4),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 373
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T467DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'EDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 374
          DRM       -X,2(16),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 374
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 375
          DRM       -X,2(16),-B,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 375
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'EDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 376
          DRM   -X,2(8),-Z*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 376
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (48)=0,/TBUFF
          ZAD       =X'EDCBA987654323',/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDB=      BN2       ; B = BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 377
          DRM       -X,2(7),-B(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 377
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'80000001',/BN1(4)
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 378
T467IDL   DRM       -X,2(4),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 378
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T467IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDA=      BN3       ; Location of remainder.
          CLR       B,8       ; Eight words = 16 bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          XFR=      BN1/2,Z   ; Z = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 379
          DRM       -X*Y,5(16),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 379
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          XFR=      BN2-3,Z   ; Z = 3 bytes before BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 380
          DRM -X*Y,5(16),-Z,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 380
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 381
   DRM -X*Y,5(8),-Z*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 381
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          FIL       (48)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDB=      BN2       ; B = BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 382
          DRM       -X*Y,5(7),-B(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 382
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'80000002',/BN1(4)
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 383
T467DIDL  DRM       -X*Y,5(4),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 383
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T467DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDA=      BN3       ; Location of remainder.
          CLR       B,8       ; Eight words = 16 bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'FDCBA987654321',/BN1(16)
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 384
          DRM       -X(16),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 384
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =-1,/BN1(16)
          ZAD       =1,/BN2(16)
          LDX=      BN1       ; X = BN1.
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 385
          DRM       -X(16),-B,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 385
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'FDCBA987654322',/BN1(8)
          ZAD       =X'123456789ABCDE',/BN2(8)
          LDX=      BN1       ; X = BN1.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 386
          DRM       -X(8),-Z*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 386
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          FIL       (48)=0,/TBUFF
          ZAD       =-1,/BN1(7)
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDX=      BN1       ; X = BN1.
          LDB=      BN2       ; B = BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 387
          DRM       -X(7),-B(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 387
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =X'80000003',/BN1(4)
          LDX=      BN1       ; X = BN1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 388
T467IL    DRM       -X(4),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 388
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T467IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDA=      BN3       ; Location of remainder.
          CLR       B,8       ; Eight words = 16 bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          FIL       (48)=0,/TBUFF
          ZAD       =X'123456789ABCDF',/BN2(16)
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 389
          DRM       =X'FDCBA987654321',/BN2(16) ; Literal, direct.
*                                                         CPU6 instruction # 389
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          ZAD       =1,/BN2(16)
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 390
          DRM       =-1,-B,3(16) ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 390
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          ZAD       =X'123456789ABCDE',/BN2(8)
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 391
          DRM  =X'FDCBA987654322',-Z*B,1(8) ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 391
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          FIL       (48)=0,/TBUFF
          ZAD       =X'123456789ABCDE',/BN2(7)
          LDB=      BN2       ; B = BN2.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 392
          DRM       =-1,-B(7) ; Literal, indexed.
*                                                         CPU6 instruction # 392
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT48    ; Print the test buffer.
          LDA=      BN3       ; A = remainder storage.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 393
T467LL    DRM       =-2,=X'7FFFFFFF' ; Literal, literal.
*                                                         CPU6 instruction # 393
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T467LL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDA=      BN3       ; Location of remainder.
          CLR       B,8       ; Eight words = 16 bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM CTB.
* Convert a string at the first argument to a bignum at the second argument. The
* string can be in any base in the range [2, 17]. The parenthsized value for
* the first argument is the base of the number, not the length of the string.
* A literal first argument sets the base to the length of the literal. However,
* this does not actually work correctly as the microcode will read one fewer
* byte of the literal than it should and the behavior is then very wrong. The
* length of the string must be loaded in AL before the CTB. The string must
* have only digits. Negative numbers are not supported. Since literals as the
* first argument do not actually work correctly, they are not shown here.
TEST468   STK       X,2       ; Push X to the stack.
          FIL       (32)=X'FF',/TBUFF
          MVF       (13)='1001000110100',/BN1
          LDAB=     13        ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 394
          CTB       /BN1(2),/BN2(16) ; Direct, direct.
*                                                         CPU6 instruction # 394
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (8)='20101121',/BN1
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDAB=     8         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 395
          CTB       /BN1(3),-B,3(16) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 395
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (7)='1020310',/BN1
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDAB=     7         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 396
          CTB       /BN1(4),-Z*B,1(8) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 396
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (6)='122120',/BN1
          LDB=      BN2       ; B = BN2.
          LDAB=     6         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 397
          CTB       /BN1(5),-B(7) ; Direct, indexed.
*                                                         CPU6 instruction # 397
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          MVF       (5)='33324',/BN1
          LDAB=     5         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 398
T468DL    CTB       /BN1(6),=X'7FFFFFFF' ; Direct, literal.
*                                                         CPU6 instruction # 398
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T468DL+5  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          FIL       (32)=X'FF',/TBUFF
          MVF       (5)='16405',/BN1
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDAB=     5         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 399
          CTB       -X,2(7),/BN2(16) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 399
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (5)='11064',/BN1
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDAB=     5         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 400
          CTB       -X,2(8),-B,3(16) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 400
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='6347',/BN1
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 401
          CTB  -X,2(9),-Z*B,1(8) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 401
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='4660',/BN1
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDB=      BN2       ; B = BN2.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 402
          CTB       -X,2(10),-B(7) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 402
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          MVF       (4)='3557',/BN1
          LDX=      BN1-2     ; X = 2 bytes before BN1.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 403
T468IDL   CTB       -X,2(11),=X'7FFFFFFF' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 403
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T468IDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='2844',/BN1
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 404
          CTB       -X*Y,5(12),/BN2(16) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 404
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='2176',/BN1
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          XFR=      BN2-3,Z   ; Z = 3 bytes before BN2.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 405
          CTB -X*Y,5(13),-Z,3(16) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 405
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='19AC',/BN1
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 406
  CTB -X*Y,5(14),-Z*B,1(8) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 406
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (4)='15AA',/BN1
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDB=      BN2       ; B = BN2.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 407
          CTB       -X*Y,5(15),-B(7) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 407
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          MVF       (4)='1234',/BN1
          XFR=      BN1/2,Y   ; Y = half way to BN1.
          LDX=      BN1-(BN1/2)-5 ; X = rest of way to BN1 minus 5.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 408
T468DIDL  CTB       -X*Y,5(16),=X'7FFFFFFF' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 408
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T468DIDL+5 ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          FIL       (32)=X'FF',/TBUFF
          MVF       (3)='G22',/BN1
          LDX=      BN1       ; X = BN1.
          LDAB=     3         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 409
          CTB       -X(17),/BN2(16) ; Indexed, direct.
*                                                         CPU6 instruction # 409
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (2)='32',/BN1
          LDX=      BN1       ; X = BN1.
          LDB=      BN2-3     ; B = 3 bytes before BN2.
          LDAB=     2         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 410
          CTB       -X(10),-B,3(16) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 410
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (14)='10000007654322',/BN1
          LDX=      BN1       ; X = BN1.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDB=      BN2-(BN2/2)-1 ; B = Rest of the way to BN2 minus 1.
          LDAB=     14        ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 411
          CTB       -X(16),-Z*B,1(8) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 411
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          FIL       (32)=X'FF',/TBUFF
          MVF       (2)='11',/BN1
          LDX=      BN1       ; X = BN1.
          LDB=      BN2       ; B = BN2.
          LDAB=     2         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 412
          CTB       -X(8),-B(7) ; Indexed, indexed.
*                                                         CPU6 instruction # 412
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT32    ; Print the test buffer.
          MVF       (4)='0003',/BN1
          LDX=      BN1       ; X = BN1.
          LDAB=     4         ; AL = string length.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 413
T468IL    CTB       -X(16),=X'7FFFFFFF' ; Indexed, literal.
*                                                         CPU6 instruction # 413
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T468IL+4  ; Location of literal.
          CLR       B,2       ; Two words = four bytes.
          JSR/      HBCRLF    ; Print the literal + CRLF.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test BIGNUM CFB.
* Convert a bignum at the second argument to a string at the first argument. The
* string can be in any base in the range [2, 17]. The parenthsized value for
* the first argument is the base of the number, not the length of the string.
* A literal first argument sets the base to the length of the literal. However,
* this does not actually work correctly as the microcode will read one fewer
* byte of the literal than it should and the behavior is then very wrong. The
* length of the string must be loaded in AL before the CFB. The padding
* character must be loaded in BL before the CFB. The string must be preloaded
* with a format to tell CFB how to format the number. Negative numbers are not
* supported - they are interpreted as unsigned and formatted using that value.
* Since literals as the first argument do not actually work correctly, they are
* not shown here. After execution, A will contain the address of the start of
* the number ignoring any padding (i.e., the most significant digit).
*
* The format string describes how to format the digits. Formatting is done from
* right to left using the following formatting characters:
*   @ = digit placeholder.
*   . = literal decimal point.
*   , = literal comma.
*   # = padding character start location.
* The algorithm looks like this:
*   padWithZero = true
*   for each character from right to left:
*     if current character is '#':
*       padWithZero = false
*     else if current character is '.' or ',' or ':':
*       continue for loop at next character without writing a digit
*     end if
*     if all significant digits of the bignum have been written:
*       if padWithZero is true:
*         write a '0'
*       else:
*         write the value of BL.
*       end if
*     else:
*       write the current digit
*     end if
*   end for
T469F1    DC        '@@@@@@@@@@@@@@#@'
T469F2    DC        '@@@@#@@@@@@@@@@@'
T469F3    DC        '@@@@@@@@@@@@,@@@'
T469F4    DC        '@@@@@@@@#@@@@.@@'
T469F5    DC        '@@@#@@@@@@@@@.@@'
TEST469   STK       X,2       ; Push X to the stack.
          LDA=      X'1234'   ; A = 0x1234.
          STA/      BN2       ; A -> BN2.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 414
          CFB       /PSSTR(2),/BN2(2) ; Direct, direct.
*                                                         CPU6 instruction # 414
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      BN2-3     ; X = 3 bytes before BN2.
          MVF       (PSBYTES)/T469F2,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 415
          CFB       /PSSTR(3),-X,3(2) ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 415
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          LDX=      BN2-(BN2/2)-1 ; X = Rest of the way to BN2 minus 1.
          MVF       (PSBYTES)/T469F2,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     ' '       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 416
          CFB       /PSSTR(4),-Z*X,1(2) ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 416
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      BN2       ; X = BN2.
          LDAB=     6         ; AL = string length.
          MVF       (PSBYTES)/T469F3,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 417
          CFB       /PSSTR(5),-X(2) ; Direct, indexed.
*                                                         CPU6 instruction # 417
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 418
          CFB       /PSSTR(6),=X'1234' ; Direct, literal.
*                                                         CPU6 instruction # 418
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR-2   ; X = 2 bytes before PSSTR.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     ' '       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 419
          CFB       -X,2(7),/BN2(2) ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 419
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR-2   ; X = 2 bytes before PSSTR.
          XFR=      BN2-3,Y   ; Y = 3 bytes before BN2.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '*'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 420
          CFB       -X,2(8),-Y,3(2) ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 420
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR-2   ; X = 2 bytes before PSSTR.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          XFR=      BN2-(BN2/2)-1,Y ; Y = Rest of the way to BN2 minus 1.
          MVF       (PSBYTES)/T469F4,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     ' '       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 421
          CFB   -X,2(9),-Z*Y,1(2) ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 421
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR-2   ; X = 2 bytes before PSSTR.
          XFR=      BN2,Y     ; Y = BN2.
          MVF       (PSBYTES)/T469F5,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '!'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 422
          CFB       -X,2(10),-Y(2) ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 422
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR-2   ; X = 2 bytes before PSSTR.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 423
          CFB       -X,2(11),=X'1234' ; Indexed-displaced, literal.
*                                                         CPU6 instruction # 423
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDX=      PSSTR-(PSSTR/2)-5 ; X = rest of way to PSSTR minus 5.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 424
          CFB       -X*Y,5(12),/BN2(2) ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 424
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDX=      PSSTR-(PSSTR/2)-5 ; X = rest of way to PSSTR minus 5.
          XFR=      BN2-3,Z   ; Z = 3 bytes before BN2.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     'X'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 425
          CFB -X*Y,5(13),-Z,3(2) ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 425
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDX=      PSSTR-(PSSTR/2)-5 ; X = rest of way to PSSTR minus 5.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          XFR=      BN2-(BN2/2)-1,C ; C = Rest of the way to BN2 minus 1.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 426
  CFB -X*Y,5(14),-Z*C,1(2) ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 426
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDX=      PSSTR-(PSSTR/2)-5 ; X = rest of way to PSSTR minus 5.
          XFR=      BN2,Z     ; Z = BN2.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 427
          CFB       -X*Y,5(15),-Z(2) ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 427
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDX=      PSSTR-(PSSTR/2)-5 ; X = rest of way to PSSTR minus 5.
          MVF       (PSBYTES)/T469F4,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 428
          CFB       -X*Y,5(16),=X'1234' ; Double-indexed-displaced, literal.
*                                                         CPU6 instruction # 428
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR     ; X = PSSTR.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     ' '       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 429
          CFB       -X(17),/BN2(2) ; Indexed, direct.
*                                                         CPU6 instruction # 429
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      -1234     ; A = -1234
          STA/      BN2       ; A -> BN2.
          LDX=      PSSTR     ; X = PSSTR.
          XFR=      BN2-3,Y   ; Y = 3 bytes before BN2.
          MVF       (PSBYTES)/T469F1,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '0'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 430
          CFB       -X(10),-Y,3(2) ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 430
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR     ; X = PSSTR.
          XFR=      BN2/2,Z   ; Z = half way to BN2.
          XFR=      BN2-(BN2/2)-1,Y ; Y = Rest of the way to BN2 minus 1.
          MVF       (PSBYTES)/T469F2,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '~'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 431
          CFB       -X(10),-Z*Y,1(2) ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 431
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR     ; X = PSSTR.
          XFR=      BN2,Y     ; Y = BN2.
          MVF       (PSBYTES)/T469F5,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '$'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 432
          CFB       -X(10),-Y(2) ; Indexed, indexed.
*                                                         CPU6 instruction # 432
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      PSSTR     ; X = PSSTR.
          MVF       (PSBYTES)/T469F5,/PSSTR
          LDAB=     16        ; AL = string length.
          LDBB=     '^'       ; BL = padding character.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 433
          CFB       -X(10),=X'1234' ; Indexed, literal.
*                                                         CPU6 instruction # 433
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test MEMBLOCK.
*
* All memory block instructions take a length and/or terminator and two memory
* arguments. There are five addressing modes possible for each argument (except
* as noted in individual instructions):
* - Direct uses a / prefix and provides the address in memory directly.
* - Indexed-displaced uses a - prefix before a word register, comma, and signed
*   byte or unsigned word displacement amount.
* - Double-indexed-displaced uses a - prefix before a word register, an
*   asterisk, another word register, comma, and an optional signed byte or
*   unsigned word displacement amount. The second register cannot be the A
*   register. Despite the use of the asterisk, the behavior is to add the two
*   registers and the displacement to form the address.
* - Indexed uses a - prefix before a word register.
* - Literal uses an = prefix before the literal value. Literal values can be
*   up to 256 bytes (theoretically - the maximum line length for the assembly
*   text will limit that), unlike most literals which are either byte or word.
* Before the memory arguments is a parenthesized length and/or terminator,
* depending on the instruction, except as noted in individual instructions.
TEST47
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      PRINTNULL ; Print menu items.
          DC '0:CVX 1:CPV 2:MVV 3:SCN 4:MVF 5:ANC 6:ORC 7:XRC 8:CPF 9:FIL'
          DW CRLF
          DC 'ENTER SELECTION> '
          DB 0
          JSR/      GET1DEC   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS47 ; Test function table -> B.
          AAB                 ; A + B -> B.
          JMP+      *B        ; Jump to the selected function.
OPTESTS47 DW        TEST470
          DW        TEST471
          DW        TEST472
          DW        TEST473
          DW        TEST474
          DW        TEST475
          DW        TEST476
          DW        TEST477
          DW        TEST478
          DW        TEST479
HELLOCAP  DC        'HELLO'
          DB        0
HELPCAP   DC        'HELP'
          DB        0
HELLOLOW  DW        X'E8E5' ; he
          DW        X'ECEC' ; ll
          DW        X'EF00' ; 0\0
HHH       EQU       *-HELLOCAP
STR16     DC        'ABCDEFGHIJKLMNOP'
          DB        0
STR16H    DC        '0123456789ABCDEF'
          DB        0
STR18     DC        'KLMNOPQRSTUVWXYZ'
          DW        CRLF
          DB        0
STR18H    DC        'FEDCBA9876543210'
          DW        CRLF
          DB        0
*
* For the CVX tests, the following program was assembled into a Centurion
* executable. Each test will CVX the resulting executable, embedded below, then
* execute it. An actual usage of CVX would require more support - this code
* already knows there are 3 segments and just CVXs them all with no checking.
*           TITLE     'CVXTEST'
* ZCVXTEST  BEGIN     0       ; No offset from the base.
*           DB        1       ; Meaningless byte.
* ENTRY     JMP/      JUMPPN  ; Jump to a direct to force a relocation.
*           DB        123     ; Meaningless byte.
* JUMPPN    JMP$      X'0102' ; Jump indirect to PRINTNULL.
*           END       ENTRY   ; Set the entrypoint to ENTRY (base + 1).
* The machine code result should be "01 710005 7B 720102" for the DB JMP/ DB
* JMP$. After each segment, CVX finishes and sets A to the base address, Z to
* the address where it stopped reading from the source (which will be the next
* address to start the next CVX from if there are more segments), and P to the
* address of the instruction after the CVX (for unknown reasons). After the
* final segment, the V flag is set and A is set to the entry point address
* instead of the base address. The F flag is set if there is anything wrong
* with the input or any other error in the CVX process. The 0005 part of the
* JMP/ instruction will get relocated by CVX so the value output at runtime
* will reflect that. Following is the CVX executable format input and
* interpretation.
CVXTEST   DW        X'0008'   ; 00 = copy, 08 = bytes to copy.
          DW        X'0000'   ; Offset relative to base to copy to.
          DB        X'01'     ; DB 1
          DB        X'71'     ; JMP/
          DW        X'0005'   ; Offset relative to base of the direct jump.
          DB        X'7B'     ; DB 123
          DB        X'72'     ; JMP$
          DW        X'0102'   ; Absolute offset to look for indirect jump loc.
          DB        X'91'     ; Checksum for first segment.
          DW        X'0102'   ; 01 = relocate, 02 = bytes of relocation info.
          DW        X'0000'   ; Offset to add to each relocation.
          DW        X'0002'   ; First relocation is at base+2 (the JMP/ arg).
          DB        X'FB'     ; Checksum for second segment.
          DW        X'0000'   ; 0000 = no more records, specify entry point.
          DW        X'0001'   ; Entry point relative to base.
          DB        X'FF'     ; Checksum for third segment.
*
* For the SCN tests, we have to define a ctype table for each character. Our
* table will assume a mask to strip the top bit so we move down to normal
* ASCII range and only need 128 entries instead of 256.
ISDIGIT   EQU       B'00000001'
ISLOWER   EQU       B'00000010'
ISUPPER   EQU       B'00000100'
ISCNTRL   EQU       B'00001000'
ISSPACE   EQU       B'00010000'
ISXDIGIT  EQU       B'00100000'
ISPUNCT   EQU       B'01000000'
ISALPHA   EQU       ISLOWER.OR.ISUPPER
ISALNUM   EQU       ISALPHA.OR.ISDIGIT
ASCIIMASK EQU       X'7F'
DIGITMASK EQU       (ISDIGIT*256)+ASCIIMASK
LOWERMASK EQU       (ISLOWER*256)+ASCIIMASK
UPPERMASK EQU       (ISUPPER*256)+ASCIIMASK
CNTRLMASK EQU       (ISCNTRL*256)+ASCIIMASK
SPACEMASK EQU       (ISSPACE*256)+ASCIIMASK
XDIGTMASK EQU       (ISXDIGIT*256)+ASCIIMASK
PUNCTMASK EQU       (ISPUNCT*256)+ASCIIMASK
ALPHAMASK EQU       (ISALPHA*256)+ASCIIMASK
ALNUMMASK EQU       (ISALNUM*256)+ASCIIMASK
CTYPE     DB        ISCNTRL,9              ; 00-08
          DB        ISSPACE,5              ; 09-0D
          DB        ISCNTRL,18             ; 0E-1F
          DB        ISSPACE                ; 20
          DB        ISPUNCT,15             ; 21-2F
          DB        ISDIGIT.OR.ISXDIGIT,10 ; 30-39
          DB        ISPUNCT,7              ; 3A-40
          DB        ISUPPER.OR.ISXDIGIT,6  ; 41-46
          DB        ISUPPER,20             ; 47-5A
          DB        ISPUNCT,6              ; 5B-60
          DB        ISLOWER.OR.ISXDIGIT,6  ; 61-66
          DB        ISLOWER,20             ; 67-7A
          DB        ISPUNCT,4              ; 7B-7E
          DB        ISCNTRL                ; 7F
*
* Test MEMBLOCK CVX.
* Convert executable format. Reads Centurion executable format from the second
* argument and creates the relocated executable image starting at the base
* address found at the first argument address. I.e., the first argument
* evaluates to a word which is the base address - the first argument is not the
* base address itself. There is no length/terminator parenthesized expression
* for this instruction. Literal arguments are not allowed. See the comments for
* CVXTEST for more information.
TEST470   STK       X,2       ; Push X to the stack.
          LDA=      MB1       ; Base address to CVX to.
          STA/      MB2       ; Store that so it can be read with direct.
          FIL       (16)=X'FF',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 434
          CVX       /MB2,/CVXTEST ; Direct, direct.
*                                                         CPU6 instruction # 434
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      CVXTEST-1 ; X = 1 byte before the first segment.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 435
          CVX       /MB2,-X,1 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 435
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      CVXTEST/2,Y ; Y = half way to CVXTEST.
          LDX=      CVXTEST-(CVXTEST/2)-1 ; X = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 436
          CVX       /MB2,-Y*X,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 436
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      CVXTEST   ; X = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 437
          CVX       /MB2,-X   ; Direct, indexed.
*                                                         CPU6 instruction # 437
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 438
          CVX       -X,2,/CVXTEST ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 438
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST-3,Y ; Y = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 439
          CVX       -X,2,-Y,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 439
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          XFR=      CVXTEST-(CVXTEST/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 440
          CVX       -X,2,-Z*Y,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 440
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST,Y ; Y = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 441
          CVX       -X,2,-Y ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 441
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 442
          CVX       -X*Y,5,/CVXTEST ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 442
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST-3,Z   ; Z = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 443
          CVX       -X*Y,5,-Z,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 443
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          LDB=      CVXTEST-(CVXTEST/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 444
         CVX -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 444
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST,Z ; Z = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 445
          CVX       -X*Y,5,-Z ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 445
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 446
          CVX       -X,/CVXTEST ; Indexed, direct.
*                                                         CPU6 instruction # 446
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST-3,Y ; Y = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 447
          CVX       -X,-Y,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 447
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          XFR=      CVXTEST-(CVXTEST/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 448
          CVX       -X,-Z*Y,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 448
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST,Y ; Y = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 449
          CVX       -X,-Y     ; Indexed, indexed.
*                                                         CPU6 instruction # 449
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVX       /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK CPV.
* Compare variable-length strings. The comparison is case-insensitive and stops
* when the terminator is reached. The flags are set comparing the second
* argument to the first. Y is set to the address of the byte after the first
* difference in the first argument. Z is set likewise for the second argument.
* If the strings match, Y and Z will be one after each respective  terminator.
* The F flag is set if there are no differences and the terminator is not found
* within 256 bytes. Literals can only be a single byte/character. The assembler
* allows a single-byte literal as the first argument, but that aborts when run
* so is omitted here. Before the memory arguments is the parenthesized
* terminator byte value.
TEST471   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 450
          CPV       (0)/HELLOCAP,/HELLOLOW ; Direct, direct.
*                                                         CPU6 instruction # 450
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 451
          CPV       (0)/HELLOCAP,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 451
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELLOCAP/2 ; A = half way to HELLOCAP.
          LDB=      HELLOCAP-(HELLOCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 452
          CPV       (0)/HELPCAP,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 452
          JSR/      PRINTREGS ; Print the registers.
          LDA=      PRINTMENU+3 ; A = start of menu text (>256 byte length).
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 453
          CPV       (0)/PRINTMENU+3,-A ; Direct, indexed.
*                                                         CPU6 instruction # 453
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP-2 ; X = 2 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 454
          CPV       (0)-X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 454
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 455
          CPV       (0)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 455
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELLOLOW/2 ; A = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 456
          CPV      (0)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 456
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELLOLOW  ; A = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 457
          CPV       (0)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 457
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDX=      HELLOLOW-(HELLOLOW/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 458
          CPV       (0)-X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 458
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOCAP/2,Y ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW-3 ; A = 3 bytes before HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 459
          CPV      (0)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 459
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDX=      HELPCAP-(HELPCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW/2 ; A = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 460
      CPV (0)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 460
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOCAP/2,Y   ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW  ; A = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 461
          CPV       (0)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 461
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 462
          CPV       (0)-X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 462
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 463
          CPV       (0)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 463
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          LDA=      HELPCAP/2 ; A = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 464
          CPV       (0)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 464
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDA=      HELPCAP   ; A = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 465
          CPV       (0)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 465
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK MVV.
* Copies a variable-length string to another. The copy stops after the
* terminator has been copied or after the maximum length has been copied. Y is
* set to the address of the found terminator or byte after the copy stopped
* reading from the first argument. Z is set to the address of the written
* terminator or byte after the copy stopped writing to the second argument. The
* F flag is set if the terminator is not found before the maximum length is
* reached. The assembler allows a single-byte literal as the first argument, but
* that aborts when run so is omitted here. Before the memory arguments is the
* parenthesized maximum length (up to 256) followed by a comma and the
* terminator byte value.
TEST472   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 466
          MVV       (256,0)/STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 466
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     CR        ; Carriage return to
          STAB+     Z         ; overwrite the null terminator with.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 467
          MVV       (16,0)/STR16H,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 467
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 468
          MVV       (99,0)/STR18,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 468
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 469
          MVV       (99,X'8D')/STR18+1,-A ; Direct, indexed.
*                                                         CPU6 instruction # 469
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 470
          MVV       (99,X'8D')-X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 470
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 471
          MVV       (99,0)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 471
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 472
          MVV   (99,0)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 472
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 473
          MVV       (99,0)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 473
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 474
          MVV       (99,0)-X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 474
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 475
          MVV   (99,0)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 475
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 476
    MVV (8,0)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 476
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 477
          MVV       (99,0)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 477
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18     ; X = STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 478
          MVV       (99,0)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 478
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H    ; X = STR18H.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 479
          MVV       (99,0)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 479
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18     ; X = STR18.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 480
          MVV       (99,0)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 480
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H    ; X = STR18H.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 481
          MVV       (99,0)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 481
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK SCN.
* Scans a string looking for a byte that matches a pattern defined by a table.
* The first argument is the table and must be large enough to index every byte
* value possible after the input masking (e.g., if the input mask is 0x7F, the
* table must be 128 bytes long). The second argument is the string to scan. The
* parenthesized value before the first argument is the length of the string.
* Before executing the instruction, BU must be loaded with the match mask and
* BL must be loaded with the input mask. If a match is found, AL is set to the
* number of bytes remaining in the string after the match, BL is set to the
* result of masking the match, Y is set to the address of the offset in the
* table that was used for the match (Y - argument 1 = match byte & input BL),
* and Z is set to the address in the string of the matched byte. If a match is
* not found, the F flag is set, AL is set to 0, BL is set to 0, Y is set to the
* address of the offset in the table for the last character in the string, and
* Z is set to the address of the last character in the string. The assembler
* allows a literal as the first argument, but that aborts when run so is omitted
* here.
*
* The algorithm looks like this:
*   for each character in argument 2 string, up to length specified:
*     masked = character & BL
*     lookup = argument 1[masked]
*     match = lookup & BU
*     if match is not 0:
*       AL = string length - current character index - 1
*       BL = match
*       Y = argument 1 + masked
*       Z = argument 2 + current character index
*       break out of for loop
*     end if
*   end for
*   if match is 0:
*     AL = 0
*     BL = 0
*     Y = argument 1 + masked
*     Z = argument 2 + string length - 1
*   end if
TEST473   STK       X,2       ; Push X to the stack.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 482
          SCN       (16)/CTYPE,/STR16H ; Direct, direct.
*                                                         CPU6 instruction # 482
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDA=      STR16H-3  ; A = 3 bytes before STR16H.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 483
          SCN       (10)/CTYPE,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 483
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDA=      HELLOCAP/2 ; A = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-1 ; X = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 484
          SCN       (HHH)/CTYPE,-A*X,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 484
          JSR/      PRINTREGS ; Print the registers.
          LDB=      LOWERMASK ; Strip high bit, look for lowercase.
          LDA=      HELLOCAP+3 ; A = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 485
          SCN       (HHH)/CTYPE,-A ; Direct, indexed.
*                                                         CPU6 instruction # 485
          JSR/      PRINTREGS ; Print the registers.
          LDB=      PUNCTMASK ; Strip high bit, look for punctuation.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 486
          SCN       (HHH)-X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 486
          JSR/      PRINTREGS ; Print the registers.
          LDB=      CNTRLMASK ; Strip high bit, look for controls.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          LDA=      HELLOCAP-3 ; A = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 487
          SCN       (HHH)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 487
          JSR/      PRINTREGS ; Print the registers.
          LDB=      DIGITMASK ; Strip high bit, look for digits.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          LDA=      STR18H/2  ; A = half way to STR18H.
          XFR=      STR18H-(STR18H/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 488
          SCN     (18)-X,2,-A*Y,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 488
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALNUMMASK ; Strip high bit, look for alphanumerics.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          LDA=      HELPCAP   ; A = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 489
          SCN       (4)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 489
          JSR/      PRINTREGS ; Print the registers.
          LDB=      XDIGTMASK ; Strip high bit, look for hex.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 490
          SCN       (4)-X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 490
          JSR/      PRINTREGS ; Print the registers.
          LDB=      SPACEMASK ; Strip high bit, look for whitespace.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOCAP-3 ; A = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 491
          SCN    (HHH)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 491
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          LDA=      STR16H/2  ; A = half way to STR16H.
          XFR=      STR16H-(STR16H/2)-1,Z ; Z = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 492
     SCN (16)-X*Y,5,-A*Z,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 492
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          LDA=      STR16H    ; A = STR16H.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 493
          SCN       (16)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 493
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 494
          SCN       (5)-X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 494
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 495
          SCN       (4)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 495
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          LDA=      HELPCAP/2 ; A = half way to HELPCAP.
          XFR=      HELPCAP-(HELPCAP/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 496
          SCN       (4)-X,-A*Y,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 496
          JSR/      PRINTREGS ; Print the registers.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          LDA=      HELPCAP   ; A = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 497
          SCN       (4)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 497
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK MVF.
* Copies a fixed-length string to another. Y is set to the address of the byte
* after the copy stopped reading from the first argument. Z is set to the
* address of the byte after the copy stopped writing to the second argument. The
* V flag is set if all bytes copied were zero. Before the memory arguments is
* the parenthesized length (up to 256). The second argument cannot be a literal.
* For literal first arguments, if fewer bytes are provided in the literal than
* the size specified, the literal is prepended with 0 bytes to the required
* size. See also ZAD, MVFR, and MVL.
TEST474   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 498
          MVF       (16)/STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 498
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     CR        ; Carriage return to
          STAB+     Z         ; overwrite the null terminator with.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 499
          MVF       (16)/STR16H,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 499
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 500
          MVF       (18)/STR18,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 500
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 501
          MVF       (15)/STR18+1,-A ; Direct, indexed.
*                                                         CPU6 instruction # 501
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 502
          MVF       (16)-X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 502
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 503
          MVF       (16)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 503
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 504
          MVF      (5)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 504
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 505
          MVF       (16)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 505
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 506
          MVF       (7)-X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 506
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 507
          MVF      (3)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 507
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 508
      MVF (9)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 508
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 509
          MVF       (18)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 509
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18     ; X = STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 510
          MVF       (16)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 510
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H    ; X = STR18H.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 511
          MVF       (8)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 511
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18     ; X = STR18.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 512
          MVF       (16)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 512
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR18H    ; X = STR18H.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 513
          MVF       (14)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 513
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 514
          MVF       (16)='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 514
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 515
          MVF       (8)='DLROLLEH',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 515
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 516
          MVF  (16)=X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-A*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 516
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 517
          MVF       (10)=X'C3C5CED4D5D2C9CFCEA1',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 517
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK ANC.
* Performs a bitwise-AND of two strings. The result is stored in the second
* argument. Before the memory arguments is the parenthesized string length (up
* to 256). The second argument cannot be a literal. For literal first arguments,
* if fewer bytes are provided in the literal than the size specified, the
* literal is prepended with 0 bytes to the required size.
TEST475   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          FIL       (16)=X'FE',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 518
          ANC       (16)/MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 518
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FC',/MB1
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 519
          ANC       (16)/MB1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 519
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FC',/MB1
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 520
          ANC       (16)/MB1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 520
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F8',/MB1
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 521
          ANC       (16)/MB1,-A ; Direct, indexed.
*                                                         CPU6 instruction # 521
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F0',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 522
          ANC       (16)-X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 522
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'E0',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 523
          ANC       (16)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 523
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR18,/PSSTR
          FIL       (16)=X'FE',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 524
          ANC     (16)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 524
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FC',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 525
          ANC       (16)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 525
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F8',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 526
          ANC       (16)-X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 526
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F0',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 527
          ANC     (16)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 527
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'E0',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 528
     ANC (16)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 528
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          FIL       (16)=X'FE',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 529
          ANC       (16)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 529
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FC',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 530
          ANC       (16)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 530
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F8',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 531
          ANC       (16)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 531
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'F0',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 532
          ANC       (16)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 532
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'E0',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 533
          ANC       (16)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 533
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 534
          ANC       (16)='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 534
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 535
          ANC       (16)='DLROLLEHDLROLLEH',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 535
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 536
          ANC  (16)=X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-A*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 536
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 537
          ANC   (16)=X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 537
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK ORC.
* Performs a bitwise-OR of two strings. The result is stored in the second
* argument. Before the memory arguments is the parenthesized string length (up
* to 256). The second argument cannot be a literal. For literal first arguments,
* if fewer bytes are provided in the literal than the size specified, the
* literal is prepended with 0 bytes to the required size.
TEST476   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          FIL       (16)=X'01',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 538
          ORC       (16)/MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 538
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 539
          ORC       (16)/MB1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 539
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 540
          ORC       (16)/MB1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 540
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 541
          ORC       (16)/MB1,-A ; Direct, indexed.
*                                                         CPU6 instruction # 541
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 542
          ORC       (16)-X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 542
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'10',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 543
          ORC       (16)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 543
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR18,/PSSTR
          FIL       (16)=X'01',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 544
          ORC     (16)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 544
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 545
          ORC       (16)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 545
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 546
          ORC       (16)-X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 546
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 547
          ORC     (16)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 547
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'10',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 548
     ORC (16)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 548
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          FIL       (16)=X'01',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 549
          ORC       (16)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 549
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 550
          ORC       (16)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 550
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 551
          ORC       (16)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 551
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 552
          ORC       (16)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 552
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'10',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 553
          ORC       (16)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 553
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'00',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 554
          ORC       (16)='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 554
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'00',/PSSTR
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 555
          ORC       (16)='DLROLLEHDLROLLEH',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 555
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'00',/PSSTR
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 556
          ORC  (16)=X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-A*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 556
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'00',/PSSTR
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 557
          ORC   (16)=X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 557
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK XRC.
* Performs a bitwise-XOR of two strings. The result is stored in the second
* argument. Before the memory arguments is the parenthesized string length (up
* to 256). The second argument cannot be a literal. For literal first arguments,
* if fewer bytes are provided in the literal than the size specified, the
* literal is prepended with 0 bytes to the required size.
TEST477   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          FIL       (16)=X'01',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 558
          XRC       (16)/MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 558
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 559
          XRC       (16)/MB1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 559
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 560
          XRC       (16)/MB1,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 560
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 561
          XRC       (16)/MB1,-A ; Direct, indexed.
*                                                         CPU6 instruction # 561
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 562
          XRC       (16)-X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 562
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'10',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 563
          XRC       (16)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 563
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR18,/PSSTR
          FIL       (16)=X'01',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 564
          XRC     (16)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 564
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 565
          XRC       (16)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 565
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 566
          XRC       (16)-X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 566
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 567
          XRC     (16)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 567
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'10',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 568
     XRC (16)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 568
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          FIL       (16)=X'01',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 569
          XRC       (16)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 569
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'02',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 570
          XRC       (16)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 570
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'04',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 571
          XRC       (16)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 571
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'08',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 572
          XRC       (16)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 572
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'10',/MB1
          LDX=      MB1       ; X = MB1.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 573
          XRC       (16)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 573
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 574
          XRC       (16)=.NOT.'HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 574
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 575
          XRC    (16)=.NOT.'DLROLLEHDLROLLEH',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 575
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 576
      XRC (16)=.NOT.X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-A*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 576
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          FIL       (16)=X'FF',/PSSTR
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 577
       XRC (16)=.NOT.X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 577
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK CPF.
* Compare fixed-length strings. The comparison is of raw byte values and is not
* case-insensitive like CPV. The flags are set comparing the second argument
* to the first argument. Before the memory arguments is the parenthesized length
* (up to 256). The second argument cannot be a literal. For literal first
* arguments, if fewer bytes are provided in the literal than the size specified,
* the literal is prepended with 0 bytes to the required size.
TEST478   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 578
          CPF       (5)/HELLOCAP,/HELLOLOW ; Direct, direct.
*                                                         CPU6 instruction # 578
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 579
          CPF       (4)/HELLOCAP,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 579
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELLOCAP/2 ; A = half way to HELLOCAP.
          LDB=      HELLOCAP-(HELLOCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 580
          CPF       (4)/HELPCAP,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 580
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELLOCAP  ; A = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 581
          CPF       (6)/HELLOCAP,-A ; Direct, indexed.
*                                                         CPU6 instruction # 581
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP-2 ; X = 2 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 582
          CPF       (5)-X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 582
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 583
          CPF       (5)-X,2,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 583
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELLOLOW/2 ; A = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 584
          CPF      (6)-X,2,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 584
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDA=      HELLOLOW  ; A = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 585
          CPF       (3)-X,2,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 585
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDX=      HELLOLOW-(HELLOLOW/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 586
          CPF       (4)-X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 586
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOCAP/2,Y ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW-3 ; A = 3 bytes before HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 587
          CPF      (4)-X*Y,5,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 587
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDX=      HELPCAP-(HELPCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW/2 ; A = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 588
      CPF (4)-X*Y,5,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 588
          JSR/      PRINTREGS ; Print the registers.
          XFR=      HELLOCAP/2,Y   ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDA=      HELLOLOW  ; A = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 589
          CPF       (5)-X*Y,5,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 589
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 590
          CPF       (5)-X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 590
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDA=      HELPCAP-3 ; A = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 591
          CPF       (5)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 591
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          LDA=      HELPCAP/2 ; A = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 592
          CPF       (5)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 592
          JSR/      PRINTREGS ; Print the registers.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDA=      HELPCAP   ; A = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 593
          CPF       (5)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 593
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 594
          CPF       (5)='HELLO',/HELLOLOW ; Literal, direct.
*                                                         CPU6 instruction # 594
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELLOCAP-3 ; A = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 595
          CPF    (5)='HELLO'.OR.X'2020202020',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 595
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELPCAP/2 ; A = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 596
          CPF       (4)='HELP',-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 596
          JSR/      PRINTREGS ; Print the registers.
          LDA=      HELPCAP   ; A = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 597
          CPF       (4)='ELP',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 597
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCK FIL.
* Fills a buffer with a byte value. The first argument provides the byte value
* and the second argument is the start of the buffer to fill. Before the memory
* arguments is the parenthesized length (up to 256). The second argument cannot
* be a literal. See also FILR and MVL.
TEST479   STK       X,2       ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 598
          FIL       (16)/STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 598
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 599
          FIL       (16)/STR16+1,-A,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 599
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 600
          FIL       (16)/STR16+2,-A*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 600
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 601
          FIL       (16)/STR16+3,-A ; Direct, indexed.
*                                                         CPU6 instruction # 601
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16     ; X = STR16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 602
          FIL       (16)-X,4,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 602
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16     ; X = STR16.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 603
          FIL       (16)-X,5,-A,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 603
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16     ; X = STR16.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 604
          FIL     (16)-X,6,-A*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 604
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16     ; X = STR16.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 605
          FIL       (16)-X,7,-A ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 605
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 606
          FIL       (16)-X*Y,8,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 606
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 607
          FIL     (16)-X*Y,9,-A,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 607
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 608
    FIL (16)-X*Y,10,-A*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 608
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 609
          FIL       (16)-X*Y,11,-A ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 609
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16+12  ; X = STR16+12.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 610
          FIL       (16)-X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 610
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16+13  ; X = STR16+13.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 611
          FIL       (16)-X,-A,3 ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 611
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16+14  ; X = STR16+14.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 612
          FIL       (16)-X,-A*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 612
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDX=      STR16+15  ; X = STR16+15.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 613
          FIL       (16)-X,-A  ; Indexed, indexed.
*                                                         CPU6 instruction # 613
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 614
          FIL       (16)='Q',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 614
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR-3   ; A = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 615
          FIL       (16)='R',-A,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 615
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR/2   ; A = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 616
          FIL       (16)='S',-A*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 616
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      PSSTR     ; A = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 617
          FIL       (16)='T',-A  ; Literal, indexed.
*                                                         CPU6 instruction # 617
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test AABB.
* Add AL to BL. The result is placed in BL.
TEST48    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  72
*                                                         CPU6 instruction # 618
          AABB                ; AL + BL -> BL.
*                                                         CPU5 instruction #  72
*                                                         CPU6 instruction # 618
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SABB.
* Subtract BL from AL. The result is placed in BL.
TEST49    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  73
*                                                         CPU6 instruction # 619
          SABB                ; AL - BL -> BL.
*                                                         CPU5 instruction #  73
*                                                         CPU6 instruction # 619
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test NABB.
* Bitwise-AND AL and BL. The result is placed in BL.
TEST4A    LDAB=     3         ; AL = 3.
          LDBB=     5         ; BL = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  74
*                                                         CPU6 instruction # 620
          NABB                ; AL & BL -> BL.
*                                                         CPU5 instruction #  74
*                                                         CPU6 instruction # 620
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAXB.
* Transfer AL to XL.
TEST4B    STX-      S-        ; Push X to the stack.
          LDAB=     3         ; AL = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  75
*                                                         CPU6 instruction # 621
          XAXB                ; AL -> XL.
*                                                         CPU5 instruction #  75
*                                                         CPU6 instruction # 621
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test XAYB.
* Transfer AL to YL.
TEST4C    LDAB=     3         ; AL = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  76
*                                                         CPU6 instruction # 622
          XAYB                ; AL -> YL.
*                                                         CPU5 instruction #  76
*                                                         CPU6 instruction # 622
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XABB.
* Transfer AL to BL.
TEST4D    LDAB=     3         ; AL = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  77
*                                                         CPU6 instruction # 623
          XABB                ; AL -> BL.
*                                                         CPU5 instruction #  77
*                                                         CPU6 instruction # 623
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAZB.
* Transfer AL to ZL.
TEST4E    LDAB=     3         ; AL = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  78
*                                                         CPU6 instruction # 624
          XAZB                ; AL -> ZL.
*                                                         CPU5 instruction #  78
*                                                         CPU6 instruction # 624
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XASB.
* Transfer AL to SL.
TEST4F    XFR       S,A       ; S -> A.
          DCA                 ; A - 1 -> A.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  79
*                                                         CPU6 instruction # 625
          XASB                ; AL -> SL.
*                                                         CPU5 instruction #  79
*                                                         CPU6 instruction # 625
          JSR/      PRINTREGS ; Print the registers.
          INA                 ; A + 1 -> A.
          XAS                 ; A -> S.
          RSR                 ; Return.
*
* Test ADD.
* Add two word registers. Any register can be specified for both arguments. The
* result is placed in the second argument register. The assembler will rewrite
* "ADD A,B" as "AAB". On CPU6, three additional addressing modes are available
* to add an immediate word to a register, a direct-addressed word to a register,
* and an indexed-displaced word to a register. The immediate word plus register
* and direct-addressed word plus register can set a separate destination
* register. The indexed-displaced displacement is required and is a word.
TEST50    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  80
*                                                         CPU6 instruction # 626
          ADD       B,A       ; B + A -> A.
*                                                         CPU5 instruction #  80
*                                                         CPU6 instruction # 626
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 627
          ADD=      2,A       ; 2 + A -> A.
*                                                         CPU6 instruction # 627
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 627
          ADD=      3,B,A     ; 3 + B -> A.
*                                                         CPU6 instruction # 627
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 628
          ADD/      WORD3,A   ; *WORD3 + A -> A.
*                                                         CPU6 instruction # 628
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 628
          ADD/      WORD3,B,A ; *WORD3 + B -> A.
*                                                         CPU6 instruction # 628
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 629
          ADD-      B,7,A     ; *(B+7) + A -> A.
*                                                         CPU6 instruction # 629
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test SUB.
* Subtract two word registers. Any register can be specified for both arguments.
* The result is placed in the second argument register. The assembler will
* rewrite "SUB A,B" as "SAB". On CPU6, three additional addressing modes are
* available to subtract a register from an immediate word, a register from a
* direct-addressed word, and a register from an indexed-displaced word. The
* immediate word minus register and direct-addressed word minus register can set
* a separate destination register. The indexed-displaced displacement is
* required and is a word.
TEST51    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  81
*                                                         CPU6 instruction # 630
          SUB       B,A       ; B - A -> A.
*                                                         CPU5 instruction #  81
*                                                         CPU6 instruction # 630
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 631
          SUB=      2,A       ; 2 - A -> A.
*                                                         CPU6 instruction # 631
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 631
          SUB=      3,B,A     ; 3 - B -> A.
*                                                         CPU6 instruction # 631
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 632
          SUB/      WORD3,A   ; *WORD3 - A -> A.
*                                                         CPU6 instruction # 632
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 632
          SUB/      WORD3,B,A ; *WORD3 - B -> A.
*                                                         CPU6 instruction # 632
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 633
          SUB-      B,7,A     ; *(B+7) - A -> A.
*                                                         CPU6 instruction # 633
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test AND.
* Bitwise-AND two word registers. Any register can be specified for both
* arguments. The result is placed in the second argument register. The assembler
* will rewrite "AND A,B" as "NAB". On CPU6, three additional addressing modes
* are available to AND an immediate word to a register, a direct-addressed word
* to a register, and an indexed-displaced word to a register. The immediate
* word AND register and direct-addressed word AND register can set a separate
* destination register. The indexed-displaced displacement is required and is a
* word.
TEST52    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  82
*                                                         CPU6 instruction # 634
          AND       B,A       ; B & A -> A.
*                                                         CPU5 instruction #  82
*                                                         CPU6 instruction # 634
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 635
          AND=      2,A       ; 2 & A -> A.
*                                                         CPU6 instruction # 635
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 635
          AND=      3,B,A     ; 3 & B -> A.
*                                                         CPU6 instruction # 635
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 636
          AND/      WORD3,A   ; *WORD3 & A -> A.
*                                                         CPU6 instruction # 636
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 636
          AND/      WORD3,B,A ; *WORD3 & B -> A.
*                                                         CPU6 instruction # 636
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 637
          AND-      B,7,A     ; *(B+7) & A -> A.
*                                                         CPU6 instruction # 637
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test ORI.
* Bitwise-OR two word registers. Any register can be specified for both
* arguments. The result is placed in the second argument register. On CPU6,
* three additional addressing modes are available to OR an immediate word to a
* register, a direct-addressed word to a register, and an indexed-displaced
* word to a register. The immediate word OR register and direct-addressed word
* OR register can set a separate destination register. The indexed-displaced
* displacement is required and is a word.
TEST53    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  83
*                                                         CPU6 instruction # 638
          ORI       B,A       ; B | A -> A.
*                                                         CPU5 instruction #  83
*                                                         CPU6 instruction # 638
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 639
          ORI=      2,A       ; 2 | A -> A.
*                                                         CPU6 instruction # 639
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 639
          ORI=      3,B,A     ; 3 | B -> A.
*                                                         CPU6 instruction # 639
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 640
          ORI/      WORD3,A   ; *WORD3 | A -> A.
*                                                         CPU6 instruction # 640
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 640
          ORI/      WORD3,B,A ; *WORD3 | B -> A.
*                                                         CPU6 instruction # 640
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 641
          ORI-      B,7,A     ; *(B+7) | A -> A.
*                                                         CPU6 instruction # 641
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test ORE.
* Bitwise-XOR two word registers. Any register can be specified for both
* arguments. The result is placed in the second argument register. On CPU6,
* three additional addressing modes are available to XOR an immediate word to a
* register, a direct-addressed word to a register, and an indexed-displaced
* word to a register. The immediate word XOR register and direct-addressed word
* XOR register can set a separate destination register. The indexed-displaced
* displacement is required and is a word.
TEST54    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  84
*                                                         CPU6 instruction # 642
          ORE       B,A       ; B ^ A -> A.
*                                                         CPU5 instruction #  84
*                                                         CPU6 instruction # 642
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 643
          ORE=      2,A       ; 2 | A -> A.
*                                                         CPU6 instruction # 643
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 643
          ORE=      3,B,A     ; 3 | B -> A.
*                                                         CPU6 instruction # 643
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 644
          ORE/      WORD3,A   ; *WORD3 | A -> A.
*                                                         CPU6 instruction # 644
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 644
          ORE/      WORD3,B,A ; *WORD3 | B -> A.
*                                                         CPU6 instruction # 644
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 645
          ORE-      B,7,A     ; *(B+7) | A -> A.
*                                                         CPU6 instruction # 645
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test XFR.
* Transfer one word register to another. Any register can be specified for both
* arguments. The contents of the first register is placed in the second
* register. The assembler will rewrite "XFR A,B" as "XAB", "XFR A,X" as "XAX",
* "XFR A,Y" as "XAY", "XFR A,Z" as "XAZ", and "XFR A,S" as "XAS". On CPU6,
* three additional addressing modes are available to tramsfer an immediate word
* to a register, a direct-addressed word to a register, and an indexed-displaced
* word to a register. The indexed-displaced displacement is required and is a
* word. See also STR.
TEST55    LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  85
*                                                         CPU6 instruction # 646
          XFR       B,Z       ; B -> Z.
*                                                         CPU5 instruction #  85
*                                                         CPU6 instruction # 646
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 647
          XFR=      2,Y       ; 2 -> Y.
*                                                         CPU6 instruction # 647
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 648
          XFR/      WORD3,Z   ; *WORD3 -> Z.
*                                                         CPU6 instruction # 648
          JSR/      PRINTREGS ; Print the registers.
          LDB=      WORD3-7   ; B = 7 bytes before WORD3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 649
          XFR-      B,7,Y     ; *(B+7) -> Y.
*                                                         CPU6 instruction # 649
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU5 illegal end
          RSR                 ; Return.
*
* Test EAO.
* Enable abort on overflow. This feature will cause an abort if a BIGNUM
* operation causes overflow. CPL uses this opcode around every mathematical
* operation it performs. The setting is global, and this only works because it
* is paired with DAO and OPSYS is cooperative, so preemption will not occur
* inside the pairing. Unless the watchdog kills the process.
TEST56
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 650
          EAO                 ; Enable abort on overflow.
*                                                         CPU6 instruction # 650
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test DAO.
* Disable abort on overflow. See EAO.
TEST57
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 651
          DAO                 ; Disable abort on overflow.
*                                                         CPU6 instruction # 651
          JSR/      PRINTREGS ; Print the registers.
          JSR/      SETFLAGS0 ; Reset flags.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test AAB.
* Add A to B. The result is placed in B.
TEST58    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  86
*                                                         CPU6 instruction # 652
          AAB                 ; A + B -> B.
*                                                         CPU5 instruction #  86
*                                                         CPU6 instruction # 652
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test SAB.
* Subtract B from A. The result is placed in B.
TEST59    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  87
*                                                         CPU6 instruction # 653
          SAB                 ; A - B -> B.
*                                                         CPU5 instruction #  87
*                                                         CPU6 instruction # 653
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test NAB.
* Bitwise-AND A and B. The result is placed in B.
TEST5A    LDA=      3         ; A = 3.
          LDB=      5         ; B = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  88
*                                                         CPU6 instruction # 654
          NAB                 ; A & B -> B.
*                                                         CPU5 instruction #  88
*                                                         CPU6 instruction # 654
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAX.
* Transfer A to X.
TEST5B    STX-      S-        ; Push X to the stack.
          LDA=      3         ; A = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  89
*                                                         CPU6 instruction # 655
          XAX                 ; A -> X.
*                                                         CPU5 instruction #  89
*                                                         CPU6 instruction # 655
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test XAY.
* Transfer A to Y.
TEST5C    LDA=      3         ; A = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  90
*                                                         CPU6 instruction # 656
          XAY                 ; A -> Y.
*                                                         CPU5 instruction #  90
*                                                         CPU6 instruction # 656
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAB.
* Transfer A to B.
TEST5D    LDA=      3         ; A = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  91
*                                                         CPU6 instruction # 657
          XAB                 ; A -> B.
*                                                         CPU5 instruction #  91
*                                                         CPU6 instruction # 657
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAZ.
* Transfer A to Z.
TEST5E    LDA=      3         ; A = 3.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  92
*                                                         CPU6 instruction # 658
          XAZ                 ; A -> Z.
*                                                         CPU5 instruction #  92
*                                                         CPU6 instruction # 658
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test XAS.
* Transfer A to S.
TEST5F    XFR       S,A       ; S -> A.
          DCA                 ; A - 1 -> A.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  93
*                                                         CPU6 instruction # 659
          XAS                 ; A -> S.
*                                                         CPU5 instruction #  93
*                                                         CPU6 instruction # 659
          JSR/      PRINTREGS ; Print the registers.
          INA                 ; A + 1 -> A.
          XAS                 ; A -> S.
          RSR                 ; Return.
*
* Test LDX=.
* Load X with the immediate word argument. Flags are set according to the value
* loaded.
TEST60    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  94
*                                                         CPU6 instruction # 660
T60       LDX=      X'1234'   ; 0x1234 -> X.
*                                                         CPU5 instruction #  94
*                                                         CPU6 instruction # 660
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDX/.
* Load X with the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST61    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  95
*                                                         CPU6 instruction # 661
T61       LDX/      WORD0     ; *WORD0 -> X.
*                                                         CPU5 instruction #  95
*                                                         CPU6 instruction # 661
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDX$.
* Load X with the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value loaded.
TEST62    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  96
*                                                         CPU6 instruction # 662
          LDX$      WORD3ADDR ; **WORD3ADDR -> X.
*                                                         CPU5 instruction #  96
*                                                         CPU6 instruction # 662
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDX.
* Load X with the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value loaded.
TEST63    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  97
*                                                         CPU6 instruction # 663
          LDX       T60+1     ; *(T60+1) -> X.
*                                                         CPU5 instruction #  97
*                                                         CPU6 instruction # 663
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDX*.
* Load X with the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value loaded.
TEST64    STX-      S-        ; Push X to the stack.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  98
*                                                         CPU6 instruction # 664
          LDX*      T61+1     ; **(T61+1) -> X.
*                                                         CPU5 instruction #  98
*                                                         CPU6 instruction # 664
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LDX+/LDX-.
* Load X using an indexed-addressing mode. Either the + or - suffix is
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
TEST65    STX-      S-        ; Push X to the stack.
          LDA=      WORD0     ; A = WORD0.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction #  99
*                                                         CPU6 instruction # 665
          LDX+      A         ; *A -> X (I).
*                                                         CPU5 instruction #  99
*                                                         CPU6 instruction # 665
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD1     ; A = WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 100
*                                                         CPU6 instruction # 666
          LDX+      A+        ; *A -> X; A+2 -> A (IPI).
*                                                         CPU5 instruction # 100
*                                                         CPU6 instruction # 666
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD2+2   ; A = two past WORD2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 101
*                                                         CPU6 instruction # 667
          LDX-      A-        ; A-2 -> A; *A -> X (IPD).
*                                                         CPU5 instruction # 101
*                                                         CPU6 instruction # 667
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD3ADDR ; A = WORD3ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 102
*                                                         CPU6 instruction # 668
          LDX+      *A        ; **A -> X (II).
*                                                         CPU5 instruction # 102
*                                                         CPU6 instruction # 668
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD4ADDR ; A = WORD4ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 103
*                                                         CPU6 instruction # 669
          LDX+      *A+       ; **A -> X; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 103
*                                                         CPU6 instruction # 669
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD5ADDR+2 ; A = two past WORD5ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 104
*                                                         CPU6 instruction # 670
          LDX-      *A-       ; A-2 -> A; **A -> X (IIPD).
*                                                         CPU5 instruction # 104
*                                                         CPU6 instruction # 670
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD6-3   ; A = three before WORD6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 105
*                                                         CPU6 instruction # 671
          LDX+      A,3       ; *(A+3) -> X (ID).
*                                                         CPU5 instruction # 105
*                                                         CPU6 instruction # 671
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD7-5   ; A = five before WORD7.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 106
*                                                         CPU6 instruction # 672
          LDX+      A+,5      ; *(A+5) -> X; A+2 -> A (IDPI).
*                                                         CPU5 instruction # 106
*                                                         CPU6 instruction # 672
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD8-3   ; A = three before WORD8.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 107
*                                                         CPU6 instruction # 673
          LDX-      A-,5      ; A-2 -> A; *(A+5) -> X (IDPD).
*                                                         CPU5 instruction # 107
*                                                         CPU6 instruction # 673
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD9ADDR-3 ; A = three before WORD9ADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 108
*                                                         CPU6 instruction # 674
          LDX+      *A,3      ; **(A+3) -> X (IDI).
*                                                         CPU5 instruction # 108
*                                                         CPU6 instruction # 674
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORDAADDR+1 ; A = one past WORDAADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 109
*                                                         CPU6 instruction # 675
          LDX+      *A+,-1    ; **(A-1) -> X; A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 109
*                                                         CPU6 instruction # 675
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORDBADDR-1 ; A = one before WORDBADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 110
*                                                         CPU6 instruction # 676
          LDX-      *A-,3     ; A-2 -> A; **(A+3) -> X (IDIPD).
*                                                         CPU5 instruction # 110
*                                                         CPU6 instruction # 676
          JSR/      PRINTREGS ; Print the registers.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test SVC.
* Service call. The argument is the service call number (an unsigned byte).
* Performs the following actions to initiate a service call:
* - Capture the argument and increment PC by one.
* - Capture X.
* - Set X to PC.
* - Push the context to the stack.
* - Push the saved X to the stack.
* - Push the argument to the stack.
* - Set PC to 0x0100.
* - Set user map level to 0. The DMA map level is unchanged.
* See RSV.
TEST66
*         JMP/      TESTILL                               CPU5 illegal start
          LDA=      T66RSV    ; A = location for SVC to jump.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 677
          SVC       255       ; Service call which will jump to our code below.
*                                                         CPU6 instruction # 677
          DW        X'1234'   ; Word argument to the service call.
          JMP       T66DONE   ; Upon return from SVC, jump to done.
T66RSV    LDA+      X+        ; *X -> A; X+2 -> X.
          XAZ                 ; A -> Z.
          CLA                 ; A = 0.
          LDAB+     S         ; AL = top byte on stack, the service call number.
          XAY                 ; A -> Y.
          LDA+      S,1       ; A = word after SVC# = previous X.
          LDB+      S,3       ; B = word after previous X = CPU registers.
          JSR/      PRINTREGS ; Print the registers.
          RSV                 ; Return from service call.
T66DONE   JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test MEMBLOCKR.
* These instructions are identical to the MEMBLOCK instructions except the
* length minus one and/or terminator are not encoded in the instruction but
* are instead set in AL and AU respectively.
TEST67
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      PRINTNULL ; Print menu items.
 DC '0:CVXR 1:CPVR 2:MVVR 3:SCNR 4:MVFR 5:ANCR 6:ORCR 7:XRCR 8:CPFR 9:FILR'
          DW CRLF
          DC 'ENTER SELECTION> '
          DB 0
          JSR/      GET1DEC   ; Get the selection -> A.
          SLA                 ; A <<= 1.
          LDB=      OPTESTS67 ; Test function table -> B.
          AAB                 ; A + B -> B.
          JMP+      *B        ; Jump to the selected function.
OPTESTS67 DW        TEST670
          DW        TEST671
          DW        TEST672
          DW        TEST673
          DW        TEST674
          DW        TEST675
          DW        TEST676
          DW        TEST677
          DW        TEST678
          DW        TEST679
*
* Test MEMBLOCKR CVXR.
* See MEMBLOCK CVX. CVX does not use a length or terminator, so CVXR is
* identical to CVX.
TEST670   STK       X,2       ; Push X to the stack.
          LDA=      MB1       ; Base address to CVX to.
          STA/      MB2       ; Store that so it can be read with direct.
          FIL       (16)=X'FF',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 678
          CVXR      /MB2,/CVXTEST ; Direct, direct.
*                                                         CPU6 instruction # 678
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      CVXTEST-1 ; X = 1 byte before the first segment.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 679
          CVXR      /MB2,-X,1 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 679
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      CVXTEST/2,Y ; Y = half way to CVXTEST.
          LDX=      CVXTEST-(CVXTEST/2)-1 ; X = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 680
          CVXR      /MB2,-Y*X,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 680
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      CVXTEST   ; X = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 681
          CVXR      /MB2,-X   ; Direct, indexed.
*                                                         CPU6 instruction # 681
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'D,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 682
          CVXR      -X,2,/CVXTEST ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 682
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST-3,Y ; Y = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 683
          CVXR      -X,2,-Y,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 683
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          XFR=      CVXTEST-(CVXTEST/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 684
          CVXR      -X,2,-Z*Y,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 684
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2-2     ; X = 2 bytes before MB2.
          XFR=      CVXTEST,Y ; Y = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 685
          CVXR      -X,2,-Y ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 685
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'ID,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 686
          CVXR      -X*Y,5,/CVXTEST ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 686
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST-3,Z   ; Z = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 687
          CVXR      -X*Y,5,-Z,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 687
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          LDB=      CVXTEST-(CVXTEST/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 688
         CVXR-X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 688
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          XFR=      MB2/2,Y   ; Y = half way to MB2.
          LDX=      MB2-(MB2/2)-5 ; X = rest of way to MB2 minus 5.
          XFR=      CVXTEST,Z ; Z = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 689
          CVXR      -X*Y,5,-Z ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 689
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'DID,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 690
          CVXR      -X,/CVXTEST ; Indexed, direct.
*                                                         CPU6 instruction # 690
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,D->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST-3,Y ; Y = 3 bytes before CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 691
          CVXR      -X,-Y,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 691
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,ID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST/2,Z ; Z = half way to CVXTEST.
          XFR=      CVXTEST-(CVXTEST/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 692
          CVXR      -X,-Z*Y,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 692
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,DID->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          FIL       (16)=X'FF',/MB1
          LDX=      MB2       ; X = MB2.
          XFR=      CVXTEST,Y ; Y = CVXTEST.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 693
          CVXR      -X,-Y     ; Indexed, indexed.
*                                                         CPU6 instruction # 693
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          CVXR      /MB2,-Z   ; Next segment.
          JSR/      PRINTREGS ; Print the registers.
          JSR+      A         ; Execute the program at A (the entrypoint).
          DC        'I,I->'
          DB        0
          JSR/      HEXT16    ; Print the test buffer.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR CPVR.
* See MEMBLOCK CPV. The terminator must be loaded in AU instead of specified in
* the instruction.
TEST671   STK       X,2       ; Push X to the stack.
          CLA                 ; AU = 0 (the terminator).
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 694
          CPVR      /HELLOCAP,/HELLOLOW ; Direct, direct.
*                                                         CPU6 instruction # 694
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 695
          CPVR      /HELLOCAP,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 695
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP/2 ; X = half way to HELLOCAP.
          LDB=      HELLOCAP-(HELLOCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 696
          CPVR      /HELPCAP,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 696
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDB=      PRINTMENU+3 ; B = start of menu text (>256 byte length).
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 697
          CPVR      /PRINTMENU+3,-B ; Direct, indexed.
*                                                         CPU6 instruction # 697
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELPCAP-2 ; X = 2 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 698
          CPVR      -X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 698
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 699
          CPVR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 699
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 700
          CPVR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 700
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDB=      HELLOLOW  ; B = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 701
          CPVR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 701
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDX=      HELLOLOW-(HELLOLOW/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 702
          CPVR      -X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 702
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          XFR=      HELLOCAP/2,Y ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDB=      HELLOLOW-3 ; B = 3 bytes before HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 703
          CPVR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 703
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDX=      HELPCAP-(HELPCAP/2)-5 ; X = rest of way minus 5.
          XFR=      HELLOLOW/2,Z ; Z = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 704
        CPVR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 704
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          XFR=      HELLOCAP/2,Y   ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDB=      HELLOLOW  ; B = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 705
          CPVR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 705
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP  ; X = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 706
          CPVR      -X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 706
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELPCAP   ; X = HELPCAP.
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 707
          CPVR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 707
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELLOCAP  ; X = HELLOCAP.
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 708
          CPVR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 708
          JSR/      PRINTREGS ; Print the registers.
          CLA                 ; AU = 0 (the terminator).
          LDX=      HELPCAP   ; X = HELPCAP.
          LDB=      HELPCAP   ; B = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 709
          CPVR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 709
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR MVVR.
* See MEMBLOCK MVV. The terminator must be loaded in AU and the maximum length
* minus one must be loaded in AL instead of specified in the instruction.
TEST672   STK       X,2       ; Push X to the stack.
          LDA=      (0*256)+(256-1) ; Terminator = 0; max length = 256.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 710
          MVVR      /STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 710
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     CR        ; Carriage return to
          STAB+     Z         ; overwrite the null terminator with.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(16-1) ; Terminator = 0; max length = 16.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 711
          MVVR      /STR16H,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 711
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 712
          MVVR      /STR18,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 712
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (X'8D'*256)+(99-1) ; Terminator = 0x8d; max length = 99.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 713
          MVVR      /STR18+1,-B ; Direct, indexed.
*                                                         CPU6 instruction # 713
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (X'8D'*256)+(99-1) ; Terminator = 0x8d; max length = 99.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 714
          MVVR      -X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 714
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 715
          MVVR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 715
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 716
          MVVR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 716
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 717
          MVVR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 717
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 718
          MVVR      -X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 718
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 719
          MVVR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 719
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDA=      (0*256)+(8-1) ; Terminator = 0; max length = 8.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 720
        MVVR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 720
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 721
          MVVR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 721
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18     ; X = STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 722
          MVVR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 722
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18H    ; X = STR18H.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 723
          MVVR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 723
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18     ; X = STR18.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 724
          MVVR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 724
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDA=      (0*256)+(99-1) ; Terminator = 0; max length = 99.
          LDX=      STR18H    ; X = STR18H.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 725
          MVVR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 725
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR SCNR.
* See MEMBLOCK SCN. The length minus one must be loaded in AL instead of
* specified in the instruction.
TEST673   STK       X,2       ; Push X to the stack.
          LDAB=     16-1      ; Length = 16.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 726
          SCNR      /CTYPE,/STR16H ; Direct, direct.
*                                                         CPU6 instruction # 726
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     10-1      ; Length = 10.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      STR16H-3  ; X = 3 bytes before STR16H.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 727
          SCNR      /CTYPE,-X,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 727
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     HHH-1     ; Length = HHH.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          XFR=      HELLOCAP/2,Y ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-1 ; X = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 728
          SCNR      /CTYPE,-Y*X,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 728
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     HHH-1     ; Length = HHH.
          LDB=      LOWERMASK ; Strip high bit, look for lowercase.
          LDX=      HELLOCAP+3 ; X = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 729
          SCNR      /CTYPE,-X ; Direct, indexed.
*                                                         CPU6 instruction # 729
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     HHH-1     ; Length = HHH.
          LDB=      PUNCTMASK ; Strip high bit, look for punctuation.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 730
          SCNR      -X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 730
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     HHH-1     ; Length = HHH.
          LDB=      CNTRLMASK ; Strip high bit, look for controls.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          XFR=      HELLOCAP-3,Y ; Y = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 731
          SCNR      -X,2,-Y,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 731
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     18-1      ; Length = 18.
          LDB=      DIGITMASK ; Strip high bit, look for digits.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          XFR=      STR18H/2,Z ; Z = half way to STR18H.
          XFR=      STR18H-(STR18H/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 732
          SCNR      -X,2,-Z*Y,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 732
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      ALNUMMASK ; Strip high bit, look for alphanumerics.
          LDX=      CTYPE-2   ; X = 2 bytes before CTYPE.
          XFR=      HELPCAP,Y ; Y = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 733
          SCNR      -X,2,-Y   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 733
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      XDIGTMASK ; Strip high bit, look for hex.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 734
          SCNR      -X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 734
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     HHH-1     ; Length = HHH.
          LDB=      SPACEMASK ; Strip high bit, look for whitespace.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          XFR=      HELLOCAP-3,Z ; Z = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 735
          SCNR      -X*Y,5,-Z,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 735
          JSR/      PRINTREGS ; Print the registers.
          LDA=      T673P     ; A = location to RSR.
          STA/      PRX       ; Save for PRINTREGS.
          LDAB=     16-1      ; Length = 16.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          XFR=      STR16H/2,P ; P = half way to STR16H.
          XFR=      STR16H-(STR16H/2)-1,Z ; Z = Rest of the way minus 1.
          STK       P,2       ; Push P since JSR will clobber it.
          JSR/      SETFLAGS0 ; Reset flags.
          POP       P,2       ; Pop P. Does not affect flags.
*                                                         CPU6 instruction # 736
        SCNR -X*Y,5,-P*Z,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 736
          JMP/      PRINTREGP ; Print the registers including P.
T673P     LDAB=     16-1      ; Length = 16.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          XFR=      CTYPE/2,Y ; Y = half way to CTYPE.
          LDX=      CTYPE-(CTYPE/2)-5 ; X = rest of way minus 5.
          XFR=      STR16H,Z  ; Z = STR16H.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 737
          SCNR      -X*Y,5,-Z ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 737
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 738
          SCNR      -X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 738
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     16-1      ; Length = 16.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          XFR=      HELPCAP-3,Y ; Y = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 739
          SCNR      -X,-Y,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 739
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          XFR=      HELPCAP/2,Z ; Z = half way to HELPCAP.
          XFR=      HELPCAP-(HELPCAP/2)-1,Y ; Y = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 740
          SCNR      -X,-Z*Y,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 740
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      ALPHAMASK ; Strip high bit, look for alphabetics.
          LDX=      CTYPE     ; X = CTYPE.
          XFR=      HELPCAP,Y ; Y = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 741
          SCNR      -X,-Y     ; Indexed, indexed.
*                                                         CPU6 instruction # 741
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR MVFR.
* See MEMBLOCK MVF. The length minus one must be loaded in AL instead of
* specified in the instruction. See also ZAD, MVF, and MVL.
TEST674   STK       X,2       ; Push X to the stack.
          LDAB=     16-1      ; Length = 16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 742
          MVFR      /STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 742
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     CR        ; Carriage return to
          STAB+     Z         ; overwrite the null terminator with.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 743
          MVFR      /STR16H,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 743
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     18-1      ; Length = 18.
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 744
          MVFR      /STR18,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 744
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     15-1      ; Length = 15.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 745
          MVFR      /STR18+1,-B ; Direct, indexed.
*                                                         CPU6 instruction # 745
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 746
          MVFR      -X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 746
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 747
          MVFR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 747
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     5-1       ; Length = 5.
          LDX=      STR18-2   ; X = 2 bytes before STR18.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 748
          MVFR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 748
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR18H-2  ; X = 2 bytes before STR18H.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 749
          MVFR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 749
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     7-1       ; Length = 7.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 750
          MVFR      -X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 750
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3-1       ; Length = 3.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 751
          MVFR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 751
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDAB=     9-1       ; Length = 9.
          XFR=      STR18/2,Y ; Y = half way to STR18.
          LDX=      STR18-(STR18/2)-5 ; X = rest of way minus 5.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 752
        MVFR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 752
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     18-1      ; Length = 18.
          XFR=      STR18H/2,Y ; Y = half way to STR18H.
          LDX=      STR18H-(STR18H/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 753
          MVFR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 753
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR18     ; X = STR18.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 754
          MVFR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 754
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     8-1       ; Length = 8.
          LDX=      STR18H    ; X = STR18H.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 755
          MVFR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 755
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR18     ; X = STR18.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 756
          MVFR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 756
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     14-1      ; Length = 14.
          LDX=      STR18H    ; X = STR18H.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 757
          MVFR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 757
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 758
          MVFR      ='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 758
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     8-1       ; Length = 8.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 759
          MVFR      ='DLROLLEH',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 759
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 760
          MVFR     =X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-X*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 760
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     10-1      ; Length = 10.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 761
          MVFR      =X'C3C5CED4D5D2C9CFCEA1',-B  ; Literal, indexed.
*                                                         CPU6 instruction # 761
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR ANCR.
* See MEMBLOCK ANC. The length minus one must be loaded in AL instead of
* specified in the instruction.
TEST675   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FE',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 762
          ANCR      /MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 762
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FC',/MB1
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 763
          ANCR      /MB1,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 763
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FC',/MB1
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 764
          ANCR      /MB1,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 764
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F8',/MB1
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 765
          ANCR      /MB1,-B   ; Direct, indexed.
*                                                         CPU6 instruction # 765
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F0',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 766
          ANCR      -X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 766
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'E0',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 767
          ANCR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 767
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR18,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FE',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 768
          ANCR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 768
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FC',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 769
          ANCR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 769
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F8',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 770
          ANCR      -X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 770
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F0',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 771
          ANCR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 771
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'E0',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 772
        ANCR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 772
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FE',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 773
          ANCR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 773
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FC',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 774
          ANCR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 774
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F8',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 775
          ANCR      -X,-A,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 775
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'F0',/MB1
          LDX=      MB1       ; X = MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 776
          ANCR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 776
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'E0',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 777
          ANCR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 777
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 778
          ANCR      ='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 778
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 779
          ANCR      ='DLROLLEHDLROLLEH',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 779
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 780
          ANCR     =X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-X*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 780
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 781
          ANCR      =X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-B  ; Literal, indexed.
*                                                         CPU6 instruction # 781
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR ORCR.
* See MEMBLOCK ORC. The length minus one must be loaded in AL instead of
* specified in the instruction.
TEST676   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'01',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 782
          ORCR      /MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 782
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 783
          ORCR      /MB1,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 783
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 784
          ORCR      /MB1,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 784
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 785
          ORCR      /MB1,-B   ; Direct, indexed.
*                                                         CPU6 instruction # 785
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 786
          ORCR      -X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 786
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 787
          ORCR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 787
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          MVF       (16)/STR18,/PSSTR
          FIL       (16)=X'01',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 788
          ORCR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 788
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 789
          ORCR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 789
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 790
          ORCR      -X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 790
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 791
          ORCR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 791
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 792
        ORCR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 792
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'01',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 793
          ORCR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 793
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 794
          ORCR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 794
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 795
          ORCR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 795
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          LDX=      MB1       ; X = MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 796
          ORCR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 796
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 797
          ORCR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 797
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'00',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 798
          ORCR      ='HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 798
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'00',/PSSTR
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 799
          ORCR      ='DLROLLEHDLROLLEH',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 799
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'00',/PSSTR
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 800
          ORCR     =X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-X*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 800
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'00',/PSSTR
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 801
          ORCR      =X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-B  ; Literal, indexed.
*                                                         CPU6 instruction # 801
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR XRCR.
* See MEMBLOCK XRC. The length minus one must be loaded in AL instead of
* specified in the instruction.
TEST677   STK       X,2       ; Push X to the stack.
          MVF       (16)/STR16,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'01',/MB1
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 802
          XRCR      /MB1,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 802
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 803
          XRCR      /MB1,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 803
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 804
          XRCR      /MB1,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 804
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 805
          XRCR      /MB1,-B   ; Direct, indexed.
*                                                         CPU6 instruction # 805
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 806
          XRCR      -X,2,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 806
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 807
          XRCR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 807
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR18,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'01',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 808
          XRCR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 808
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      MB1-2     ; X = 2 bytes before MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 809
          XRCR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 809
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 810
          XRCR      -X*Y,5,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 810
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 811
          XRCR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 811
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 812
        XRCR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 812
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          MVF       (16)/STR16H,/PSSTR
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'01',/MB1
          XFR=      MB1/2,Y   ; Y = half way to MB1.
          LDX=      MB1-(MB1/2)-5 ; X = rest of way minus 5.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 813
          XRCR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 813
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'02',/MB1
          LDX=      MB1       ; X = MB1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 814
          XRCR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 814
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'04',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 815
          XRCR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 815
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'08',/MB1
          LDX=      MB1       ; X = MB1.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 816
          XRCR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 816
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'10',/MB1
          LDX=      MB1       ; X = MB1.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 817
          XRCR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 817
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 818
          XRCR      =.NOT.'HELLORLDHELLORLD',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 818
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 819
          XRCR      =.NOT.'DLROLLEHDLROLLEH',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 819
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 820
         XRCR =.NOT.X'C3C5CED4D5D2C9CFCEA0A0A0A0A0A0A0',-X*B,1 ; Literal, d-i-d.
*                                                         CPU6 instruction # 820
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          FIL       (16)=X'FF',/PSSTR
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 821
          XRCR =.NOT.X'A0A0A0A0A0A0C3C5CED4D5D2C9CFCEA1',-B  ; Literal, indexed.
*                                                         CPU6 instruction # 821
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR CPFR.
* See MEMBLOCK CPF. The length minus one must be loaded in AL instead of
* specified in the instruction.
TEST678   STK       X,2       ; Push X to the stack.
          LDAB=     5-1       ; Length = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 822
          CPFR      /HELLOCAP,/HELLOLOW ; Direct, direct.
*                                                         CPU6 instruction # 822
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 823
          CPFR      /HELLOCAP,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 823
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDX=      HELLOCAP/2 ; X = half way to HELLOCAP.
          LDB=      HELLOCAP-(HELLOCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 824
          CPFR      /HELPCAP,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 824
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     6-1       ; Length = 6.
          LDB=      HELLOCAP  ; B = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 825
          CPFR      /HELLOCAP,-B ; Direct, indexed.
*                                                         CPU6 instruction # 825
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELPCAP-2 ; X = 2 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 826
          CPFR      -X,2,/HELLOCAP ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 826
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 827
          CPFR      -X,2,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 827
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     6-1       ; Length = 6.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 828
          CPFR      -X,2,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 828
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     3-1       ; Length = 3.
          LDX=      HELLOCAP-2 ; X = 2 bytes before HELLOCAP.
          LDB=      HELLOLOW  ; B = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 829
          CPFR      -X,2,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 829
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          XFR=      HELLOLOW/2,Y ; Y = half way to HELLOLOW.
          LDX=      HELLOLOW-(HELLOLOW/2)-5 ; X = rest of way minus 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 830
          CPFR      -X*Y,5,/HELPCAP ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 830
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          XFR=      HELLOCAP/2,Y ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDB=      HELLOLOW-3 ; B = 3 bytes before HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 831
          CPFR      -X*Y,5,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 831
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDX=      HELPCAP-(HELPCAP/2)-5 ; X = rest of way minus 5.
          XFR=      HELLOLOW/2,Z ; Z = half way to HELLOLOW.
          LDB=      HELLOLOW-(HELLOLOW/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 832
        CPFR -X*Y,5,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 832
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          XFR=      HELLOCAP/2,Y   ; Y = half way to HELLOCAP.
          LDX=      HELLOCAP-(HELLOCAP/2)-5 ; X = rest of way minus 5.
          LDB=      HELLOLOW  ; B = HELLOLOW.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 833
          CPFR      -X*Y,5,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 833
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 834
          CPFR      -X,/HELLOLOW ; Indexed, direct.
*                                                         CPU6 instruction # 834
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDB=      HELPCAP-3 ; B = 3 bytes before HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 835
          CPFR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 835
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELLOCAP  ; X = HELLOCAP.
          XFR=      HELPCAP/2,Y ; Y = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 836
          CPFR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 836
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDX=      HELPCAP   ; X = HELPCAP.
          LDB=      HELPCAP   ; B = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 837
          CPFR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 837
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 838
          CPFR      ='HELLO',/HELLOLOW ; Literal, direct.
*                                                         CPU6 instruction # 838
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     5-1       ; Length = 5.
          LDB=      HELLOCAP-3 ; B = 3 bytes before HELLOCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 839
          CPFR      ='HELLO'.OR.X'2020202020',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 839
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDX=      HELPCAP/2 ; X = half way to HELPCAP.
          LDB=      HELPCAP-(HELPCAP/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 840
          CPFR      ='HELP',-X*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 840
          JSR/      PRINTREGS ; Print the registers.
          LDAB=     4-1       ; Length = 4.
          LDB=      HELPCAP   ; B = HELPCAP.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 841
          CPFR      ='HELP',-B ; Literal, indexed.
*                                                         CPU6 instruction # 841
          JSR/      PRINTREGS ; Print the registers.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*
* Test MEMBLOCKR FILR.
* See MEMBLOCK FIL. The length minus one must be loaded in AL instead of
* specified in the instruction. See also FIL and MVL.
TEST679   STK       X,2       ; Push X to the stack.
          LDAB=     16-1      ; Length = 16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 842
          FILR      /STR16,/PSSTR ; Direct, direct.
*                                                         CPU6 instruction # 842
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 843
          FILR      /STR16+1,-B,3 ; Direct, indexed-displaced.
*                                                         CPU6 instruction # 843
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 844
          FILR      /STR16+2,-X*B,1 ; Direct, double-indexed-displaced.
*                                                         CPU6 instruction # 844
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 845
          FILR      /STR16+3,-B ; Direct, indexed.
*                                                         CPU6 instruction # 845
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16     ; X = STR16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 846
          FILR      -X,4,/PSSTR ; Indexed-displaced, direct.
*                                                         CPU6 instruction # 846
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16     ; X = STR16.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 847
          FILR      -X,5,-B,3 ; Indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 847
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16     ; X = STR16.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 848
          FILR      -X,6,-Y*B,1 ; Indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 848
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16     ; X = STR16.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 849
          FILR      -X,7,-B   ; Indexed-displaced, indexed.
*                                                         CPU6 instruction # 849
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 850
          FILR      -X*Y,8,/PSSTR ; Double-indexed-displaced, direct.
*                                                         CPU6 instruction # 850
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 851
          FILR      -X*Y,9,-B,3 ; Double-indexed-displaced, indexed-displaced.
*                                                         CPU6 instruction # 851
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     3         ; 3 blank lines.
          JSR/      MORE      ; Pause.
          LDAB=     16-1      ; Length = 16.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          XFR=      PSSTR/2,Z ; Z = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 852
       FILR -X*Y,10,-Z*B,1 ; Double-indexed-displaced, double-indexed-displaced.
*                                                         CPU6 instruction # 852
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          XFR=      STR16/2,Y   ; Y = half way to STR16.
          LDX=      STR16-(STR16/2) ; X = rest of way.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 853
          FILR      -X*Y,11,-B ; Double-indexed-displaced, indexed.
*                                                         CPU6 instruction # 853
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16+12  ; X = STR16+12.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 854
          FILR      -X,/PSSTR ; Indexed, direct.
*                                                         CPU6 instruction # 854
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16+13  ; X = STR16+13.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 855
          FILR      -X,-B,3   ; Indexed, indexed-displaced.
*                                                         CPU6 instruction # 855
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16+14  ; X = STR16+14.
          XFR=      PSSTR/2,Y ; Y = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 856
          FILR      -X,-Y*B,1 ; Indexed, double-indexed-displaced.
*                                                         CPU6 instruction # 856
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      STR16+15  ; X = STR16+15.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 857
          FILR      -X,-B     ; Indexed, indexed.
*                                                         CPU6 instruction # 857
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 858
          FILR      ='Q',/PSSTR ; Literal, direct.
*                                                         CPU6 instruction # 858
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDB=      PSSTR-3   ; B = 3 bytes before PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 859
          FILR      ='R',-B,3 ; Literal, indexed-displaced.
*                                                         CPU6 instruction # 859
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDX=      PSSTR/2   ; X = half way to PSSTR.
          LDB=      PSSTR-(PSSTR/2)-1 ; B = Rest of the way minus 1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 860
          FILR      ='S',-X*B,1 ; Literal, double-indexed-displaced.
*                                                         CPU6 instruction # 860
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          LDAB=     16-1      ; Length = 16.
          LDB=      PSSTR     ; B = PSSTR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 861
          FILR      ='T',-B   ; Literal, indexed.
*                                                         CPU6 instruction # 861
          JSR/      PRINTREGS ; Print the registers.
          JSR/      PRINTSTR  ; Print the string.
          POP       X,2       ; Pop X from the stack.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test STX=.
* Store X into the immediate word argument. Flags are set according to the value
* stored.
TEST68    STX-      S-        ; Push X to the stack.
          LDX=      X'1234'   ; X = 0x1234.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 111
*                                                         CPU6 instruction # 862
T68       STX=      0         ; X -> literal.
*                                                         CPU5 instruction # 111
*                                                         CPU6 instruction # 862
          JSR/      PRINTREGS ; Print the registers.
          LDA       T68+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STX/.
* Store X into the direct-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TEST69    STX-      S-        ; Push X to the stack.
          LDX=      X'0102'   ; X = 0x0102.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 112
*                                                         CPU6 instruction # 863
T69       STX/      TBUFF     ; X -> *TBUFF.
*                                                         CPU5 instruction # 112
*                                                         CPU6 instruction # 863
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STX$.
* Store X into the indirect-addressed word at the argument, which is a word
* address. Flags are set according to the value stored.
TEST6A    STX-      S-        ; Push X to the stack.
          LDX=      X'0708'   ; X = 0x0708.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 113
*                                                         CPU6 instruction # 864
          STX$      TBUFFADDR ; X -> **TBUFFADDR.
*                                                         CPU5 instruction # 113
*                                                         CPU6 instruction # 864
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STX.
* Store X into the relative-addressed word at the argument, which is a signed
* byte displacement relative to the beginning of the next instruction. Flags
* are set according to the value stored.
TEST6B    STX-      S-        ; Push X to the stack.
          LDX=      X'0304'   ; X = 0x0304.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 114
*                                                         CPU6 instruction # 865
          STX       T68+1     ; X -> *(T68+1).
*                                                         CPU5 instruction # 114
*                                                         CPU6 instruction # 865
          JSR/      PRINTREGS ; Print the registers.
          LDA       T68+1     ; Literal -> A.
          JSR/      HACRLF    ; Print the literal + CRLF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STX*.
* Store X into the relative-indirect-addressed word at the argument, which is a
* signed byte displacement relative to the beginning of the next instruction.
* Flags are set according to the value stored.
TEST6C    STX-      S-        ; Push X to the stack.
          LDX=      X'0506'   ; X = 0x0506.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 115
*                                                         CPU6 instruction # 866
          STX*      T69+1     ; X -> **(T69+1).
*                                                         CPU5 instruction # 115
*                                                         CPU6 instruction # 866
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test STX+/STX-.
* Store X using an indexed-addressing mode. Either the + or - suffix is
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
TEST6D    STX-      S-        ; Push X to the stack.
          LDX/      WORD0     ; X = *WORD0.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 116
*                                                         CPU6 instruction # 867
          STX+      A         ; X -> *A (I).
*                                                         CPU5 instruction # 116
*                                                         CPU6 instruction # 867
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD1     ; X = *WORD1.
          LDA=      TBUFF     ; A = TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 117
*                                                         CPU6 instruction # 868
          STX+      A+        ; X -> *A; A+2 -> A (IPI).
*                                                         CPU5 instruction # 117
*                                                         CPU6 instruction # 868
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD2     ; X = *WORD2.
          LDA=      TBUFF+2   ; A = two past TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 118
*                                                         CPU6 instruction # 869
          STX-      A-        ; A-2 -> A; X -> *A (IPD).
*                                                         CPU5 instruction # 118
*                                                         CPU6 instruction # 869
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD3     ; X = *WORD3.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 119
*                                                         CPU6 instruction # 870
          STX+      *A        ; X -> **A (II).
*                                                         CPU5 instruction # 119
*                                                         CPU6 instruction # 870
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD4     ; X = *WORD4.
          LDA=      TBUFFADDR ; A = TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 120
*                                                         CPU6 instruction # 871
          STX+      *A+       ; X -> **A; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 120
*                                                         CPU6 instruction # 871
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD5     ; X = *WORD5.
          LDA=      TBUFFADDR+2 ; A = two past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 121
*                                                         CPU6 instruction # 872
          STX-      *A-       ; A-2 -> A; X -> **A (IIPD).
*                                                         CPU5 instruction # 121
*                                                         CPU6 instruction # 872
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDX/      WORD6     ; X = *WORD6.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 122
*                                                         CPU6 instruction # 873
          STX+      A,3       ; X -> *(A+3) (ID).
*                                                         CPU5 instruction # 122
*                                                         CPU6 instruction # 873
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD7     ; X = *WORD7.
          LDA=      TBUFF-5   ; A = five before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 123
*                                                         CPU6 instruction # 874
          STX+      A+,5      ; X -> *(A+5); A+2 -> A (IDPI).
*                                                         CPU5 instruction # 123
*                                                         CPU6 instruction # 874
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD8     ; X = *WORD8.
          LDA=      TBUFF-3   ; A = three before TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 124
*                                                         CPU6 instruction # 875
          STX-      A-,5      ; A-2 -> A; X -> *(A+5) (IDPD).
*                                                         CPU5 instruction # 124
*                                                         CPU6 instruction # 875
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORD9     ; X = *WORD9.
          LDA=      TBUFFADDR-3 ; A = three before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 125
*                                                         CPU6 instruction # 876
          STX+      *A,3      ; **(A+3) -> X (IDI).
*                                                         CPU5 instruction # 125
*                                                         CPU6 instruction # 876
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORDA     ; X = *WORDA.
          LDA=      TBUFFADDR+1 ; A = one past TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 126
*                                                         CPU6 instruction # 877
          STX+      *A+,-1    ; X -> **(A-1); A+2 -> A (IDIPI).
*                                                         CPU5 instruction # 126
*                                                         CPU6 instruction # 877
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX/      WORDB     ; X = *WORDB.
          LDA=      TBUFFADDR-1 ; A = one before TBUFFADDR.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 127
*                                                         CPU6 instruction # 878
          STX-      *A-,3     ; A-2 -> A; X -> **(A+3) (IDIPD).
*                                                         CPU5 instruction # 127
*                                                         CPU6 instruction # 878
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT2     ; Print the first word of TBUFF.
          LDX+      S+        ; Pop X from the stack.
          RSR                 ; Return.
*
* Test LST.
* Load the status register from byte at the argument, which is a word address.
TEST6E
*         JMP/      TESTILL                               CPU5 illegal start
          CLAB                ; AL = 0.
          DCAB                ; AL = 0xff.
          STAB/     TBUFF     ; AL -> *TBUFF.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 879
          LST       TBUFF     ; Load status register from *TBUFF.
*                                                         CPU6 instruction # 879
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test SST.
* Store the status register to the byte at the argument, which is a word
* address.
TEST6F
*         JMP/      TESTILL                               CPU5 illegal start
          CLA                 ; A = 0, sets V flag, clears others.
*                                                         CPU6 instruction # 880
          SST       TBUFF     ; Store status register to *TBUFF.
*                                                         CPU6 instruction # 880
          JSR/      PRINTREGS ; Print the registers.
          JSR/      HEXT1     ; Print the first byte of the test buffer.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test JMP/.
* Unconditional jump to the direct address at the argument.
TEST71    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 128
*                                                         CPU6 instruction # 881
T711      JMP/      T712      ; Jump to address T712.
*                                                         CPU5 instruction # 128
*                                                         CPU6 instruction # 881
          DB        ILL56     ; Illegal opcode to jump over.
T712      JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*
* Test JMP$.
* Unconditional jump to the indirect-addressed word at the argument, which is
* a word address.
TEST72    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 129
*                                                         CPU6 instruction # 882
          JMP$      T711+1    ; Jump to address at *(T711+1).
*                                                         CPU5 instruction # 129
*                                                         CPU6 instruction # 882
*
* Test JMP.
* Unconditional jump to the relative address at the signed byte displacement
* relative to the beginning of the next instruction.
TEST73    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 130
*                                                         CPU6 instruction # 883
          JMP       T712      ; Jump to address T712.
*                                                         CPU5 instruction # 130
*                                                         CPU6 instruction # 883
*
* Test JMP*.
* Unconditional jump to the relative-indirect-addressed word at the argument,
* which is a signed byte displacement relative to the beginning of the next
* instruction. The word at that address is the address to jump to.
TEST74    JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU5 instruction # 131
*                                                         CPU6 instruction # 884
          JMP*      T711+1    ; Jump to address at (T711+1).
*                                                         CPU5 instruction # 131
*                                                         CPU6 instruction # 884
*
* Test JMP+/JMP-.
* Unconditional jump to the indexed address. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   to jump to.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address to jump to.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address to jump
*   to.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address to jump
*   to.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This jumps just as for indexed-indirect (II), then
*   increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then jumps just
*   just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to jump to.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This jumps just as
*   for indexed-displaced (ID), then increments the register by two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then jumps just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address to jump to.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This jumps just as for indexed-displaced-indirect (IDI), then
*   increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then jumps just as for
*   indexed-displaced-indirect (IDI).
TEST75    JSR/      SETFLAGS0 ; Reset flags.
T751      LDA=      T75TGT    ; A = T75TGT.
          LDB=      T75IPI    ; B = resume point.
*                                                         CPU5 instruction # 132
*                                                         CPU6 instruction # 885
          JMP+      A         ; Jump to *A (I).
*                                                         CPU5 instruction # 132
*                                                         CPU6 instruction # 885
T75IPI    JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T75TGT    ; A = T75TGT.
          LDB=      T75IPD    ; B = resume point.
*                                                         CPU5 instruction # 133
*                                                         CPU6 instruction # 886
          JMP+      A+        ; Jump to *A; A+2 -> A (IPI).
*                                                         CPU5 instruction # 133
*                                                         CPU6 instruction # 886
T75IPD    JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T75TGT+2  ; A = two past T75TGT.
          LDB=      T75II     ; B = resume point.
*                                                         CPU5 instruction # 134
*                                                         CPU6 instruction # 887
          JMP-      A-        ; A-2 -> A; jump to *A (IPD).
*                                                         CPU5 instruction # 134
*                                                         CPU6 instruction # 887
T75II     JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751+1    ; A = T751+1.
          LDB=      T75IIPI   ; B = resume point.
*                                                         CPU5 instruction # 135
*                                                         CPU6 instruction # 888
          JMP+      *A        ; Jump to **A (II).
*                                                         CPU5 instruction # 135
*                                                         CPU6 instruction # 888
T75IIPI   JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751+1    ; A = T751+1.
          LDB=      T75IIPD   ; B = resume point.
*                                                         CPU5 instruction # 136
*                                                         CPU6 instruction # 889
          JMP+      *A+       ; Jump to **A; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 136
*                                                         CPU6 instruction # 889
T75IIPD   JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751+3    ; A = two past T751+1.
          LDB=      T75ID     ; B = resume point.
*                                                         CPU5 instruction # 137
*                                                         CPU6 instruction # 890
          JMP-      *A-       ; A-2 -> A; jump to **A (IIPD).
*                                                         CPU5 instruction # 137
*                                                         CPU6 instruction # 890
T75ID     JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T75TGT-3  ; A = three before T75TGT.
          LDB=      T75IDPI   ; B = resume point.
*                                                         CPU5 instruction # 138
*                                                         CPU6 instruction # 891
          JMP+      A,3       ; Jump to *(A+3) (ID).
*                                                         CPU5 instruction # 138
*                                                         CPU6 instruction # 891
T75IDPI   JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T75TGT-5  ; A = five before T75TGT.
          LDB=      T75IDPD   ; B = resume point.
*                                                         CPU5 instruction # 139
*                                                         CPU6 instruction # 892
          JMP+      A+,5      ; Jump to *(A+5); A+2 -> A (IDPI).
*                                                         CPU5 instruction # 139
*                                                         CPU6 instruction # 892
T75IDPD   JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T75TGT-3  ; A = three before T75TGT.
          LDB=      T75IID    ; B = resume point.
*                                                         CPU5 instruction # 140
*                                                         CPU6 instruction # 893
          JMP-      A-,5      ; A-2 -> A; jump to *(A+5) (IDPD).
*                                                         CPU5 instruction # 140
*                                                         CPU6 instruction # 893
T75IID    JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751      ; A = T751.
          LDB=      T75IIDPI  ; B = resume point.
*                                                         CPU5 instruction # 141
*                                                         CPU6 instruction # 894
          JMP+      *A,1      ; Jump to **(A+1) (IID).
*                                                         CPU5 instruction # 141
*                                                         CPU6 instruction # 894
T75IIDPI  JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751      ; A = T751.
          LDB=      T75IIDPD  ; B = resume point.
*                                                         CPU5 instruction # 142
*                                                         CPU6 instruction # 895
          JMP+      *A+,1     ; Jump to **(A+1); A+2 -> A (IIDPI).
*                                                         CPU5 instruction # 142
*                                                         CPU6 instruction # 895
T75IIDPD  JSR/      SETFLAGS0 ; Reset flags.
          LDA=      T751      ; A = T751.
          LDB=      T75DONE   ; B = resume point.
*                                                         CPU5 instruction # 143
*                                                         CPU6 instruction # 896
          JMP-      *A-,3     ; A-2 -> A; jump to **(A+3) (IIDPD).
*                                                         CPU5 instruction # 143
*                                                         CPU6 instruction # 896
T75DONE   RSR                 ; Return.
T75TGT    JSR/      PRINTREGS ; Print the registers.
          JMP+      B         ; Jump to the resume point.
*
* Test EPE.
* Enable parity error.
TEST76
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 897
          EPE                 ; Enable parity error.
*                                                         CPU6 instruction # 897
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test MUL.
* Multiply two word registers. Any register can be specified for both arguments.
* The upper 16 bits of the result are placed in the second argument register.
* Then, the lower 16 bits of the result are placed in the next register if the
* second argument register is divisible by four or in the second argument
* register if not. There are three additional addressing modes to multiply an
* immediate word to a register, a direct-addressed word to a register, and an
* indexed-displaced word to a register. The immediate word times register and
* direct-addressed word times register can set a separate destination register.
* The indexed-displaced displacement is required and is a word. The result
* placement behavior is the same for the additional three modes.
*
* Registers are A = 0, B = 2, X = 4, Y = 6, Z = 8, S = 10, C = 12, P = 14, so
* destination registers A, X, Z, and C will write to A, B; X, Y; Z, S; and C, P
* respectively, while destination registers B, Y, S, and P will write the lower
* 16 bits to B, Y, S, and P respectively, and the upper 16 bits are lost.
TEST77
*         JMP/      TESTILL                               CPU5 illegal start
          LDA=      X'3003'   ; A = 0x3003.
          CLR       B,6       ; B = 6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 898
          MUL       B,A       ; B * A -> A, B.
*                                                         CPU6 instruction # 898
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'3003'   ; A = 0x3003.
          CLR       B,6       ; B = 6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 898
          MUL       A,B       ; A * B -> B.
*                                                         CPU6 instruction # 898
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'3003'   ; A = 0x3003.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 899
          MUL=      6,A       ; 6 * A -> A, B.
*                                                         CPU6 instruction # 899
          JSR/      PRINTREGS ; Print the registers.
          CLR       A,6       ; A = 6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 899
          MUL=      X'3003',A,B ; 0x3003 * A -> B.
*                                                         CPU6 instruction # 899
          JSR/      PRINTREGS ; Print the registers.
          LDA=      256       ; A = 256.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 900
          MUL/      WORD0,A   ; *WORD0 * A -> A, B.
*                                                         CPU6 instruction # 900
          JSR/      PRINTREGS ; Print the registers.
          LDA=      256       ; A = 256.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 900
          MUL/      WORD0,A,B ; *WORD0 * A -> B.
*                                                         CPU6 instruction # 900
          JSR/      PRINTREGS ; Print the registers.
          LDA=      256       ; A = 256.
          LDB=      WORD1-7   ; B = 7 bytes before WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 901
          MUL-      B,7,A     ; *(B+7) * A -> A, B.
*                                                         CPU6 instruction # 901
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD1-7   ; A = 7 bytes before WORD1.
          LDB=      256       ; B = 256.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 901
          MUL-      A,7,B     ; *(A+7) * B -> B.
*                                                         CPU6 instruction # 901
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test DIV.
* Divide two word registers. Any register can be specified for both arguments.
* The remainder is placed in the second argument register. Then, the quotient
* is placed in the next register if the second argument register is divisible
* by four or in the second argument register if not. There are three additional
* addressing modes to divide a register by an immediate word, a register by a
* direct-addressed word, and a register by an indexed-displaced word. The
* register divided by immediate word and register divided by direct-addressed
* word set a separate destination register. The indexed-displaced displacement
* is required as is a word. The result placement behavior is the same for the
* additional three modes.
*
* Registers are A = 0, B = 2, X = 4, Y = 6, Z = 8, S = 10, C = 12, P = 14, so
* destination registers A, X, Z, and C will write to A, B; X, Y; Z, S; and C, P
* respectively, while destination registers B, Y, S, and P will write the
* quotient to B, Y, S, and P respectively, and the remainer is lost.
TEST78
*         JMP/      TESTILL                               CPU5 illegal start
          CLR       A,13      ; A = 13.
          CLR       B,6       ; B = 6.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 902
          DIV       B,A       ; A / B -> B, A % B -> A.
*                                                         CPU6 instruction # 902
          JSR/      PRINTREGS ; Print the registers.
          CLR       A,6       ; A = 6.
          CLR       B,13      ; B = 13.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 902
          DIV       A,B       ; B / A -> B.
*                                                         CPU6 instruction # 902
          JSR/      PRINTREGS ; Print the registers.
          CLR       A,13      ; A = 13.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 903
          DIV=      6,A       ; A / 6 -> B, A % 6 -> A.
*                                                         CPU6 instruction # 903
          JSR/      PRINTREGS ; Print the registers.
          CLR       A,13      ; A = 13.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 903
          DIV=      6,A,B     ; A / 6 -> B.
*                                                         CPU6 instruction # 903
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'0205'   ; A = 0x0205.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 904
          DIV/      WORD0,A   ; A / *WORD0 -> B, A % *WORD0 -> A.
*                                                         CPU6 instruction # 904
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'0205'   ; A = 0x0205.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 904
          DIV/      WORD0,A,B ; A / *WORD0 -> B.
*                                                         CPU6 instruction # 904
          JSR/      PRINTREGS ; Print the registers.
          LDA=      X'0608'   ; A = 0x0608.
          LDB=      WORD1-7   ; B = 7 bytes before WORD1.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 905
          DIV-      B,7,A     ; A / *(B+7) -> B, A % *(B+7) -> A.
*                                                         CPU6 instruction # 905
          JSR/      PRINTREGS ; Print the registers.
          LDA=      WORD1-7   ; A = 7 bytes before WORD1.
          LDB=      X'0608'   ; B = 0x0608.
          JSR/      SETFLAGS0 ; Reset flags.
*                                                         CPU6 instruction # 905
          DIV-      A,7,B     ; B / *(A+7) -> B.
*                                                         CPU6 instruction # 905
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* Test JSR/.
* Jump to a subroutine at the direct address of the argument.
TEST79
*                                                         CPU5 instruction # 144
*                                                         CPU6 instruction # 906
T79       JSR/      TEST09    ; Jump to subroutine at TEST09.
*                                                         CPU5 instruction # 144
*                                                         CPU6 instruction # 906
          RSR                 ; Return.
*
* Test JSR$.
* Jump to a subroutine at the indirect-addressed word at the argument, which is
* a word address.
TEST7A
*                                                         CPU5 instruction # 145
*                                                         CPU6 instruction # 907
          JSR$      TEST79+1  ; Jump to subroutine at *(TEST79+1).
*                                                         CPU5 instruction # 145
*                                                         CPU6 instruction # 907
          RSR                 ; Return.
*
* Test JSR.
* Jump to a subroutine at the relative address at the signed byte displacement
* relative to the beginning of the next instruction.
TEST7B
*                                                         CPU5 instruction # 146
*                                                         CPU6 instruction # 908
          JSR       TEST79    ; Jump to subroutine at TEST79.
*                                                         CPU5 instruction # 146
*                                                         CPU6 instruction # 908
          RSR                 ; Return.
*
* Test JSR*.
* Jump to a subroutine at the relative-indirect-addressed word at the argument,
* which is a signed byte displacement relative to the beginning of the next
* instruction. The word at that address is the address to jump to.
TEST7C
*                                                         CPU5 instruction # 147
*                                                         CPU6 instruction # 909
          JSR*      TEST79+1  ; Jump to subroutine at *(TEST79+1).
*                                                         CPU5 instruction # 147
*                                                         CPU6 instruction # 909
          RSR                 ; Return.
*
* Test JSR+/JSR-.
* Jump to a subroutine at the indexed address. Either the + or - suffix is
* acceptable on the mnemonic - only the prefix and suffix on the index register
* affect the behavior. Any register can be used as the index register. There
* are twelve addressing modes possible:
* - (I) Indexed specifies the index register whose value is used as the address
*   to jump to.
* - (IPI) Indexed post-incremented specifies the index register with a + suffix.
*   The register is incremented by two after using it as the address to jump to.
* - (IPD) Indexed pre-decremented specifies the index register with a - suffix.
*   The register is decremented by two before using it as the address to jump
*   to.
* - (II) Indexed-indirect specifies the index register with a * prefix. The
*   register value is used as an address at which is the word address to jump
*   to.
* - (IIPI) Indexed-indirect post-incremented specifies the index register with
*   a * prefix and + suffix. This jumps just as for indexed-indirect (II), then
*   increments the register by two.
* - (IIPD) Indexed-indirect pre-decremented specifies the index register with a
*   * prefix and - suffix. This decrements the register by two, then jumps just
*   just as for indexed-indirect (II).
* - (ID) Indexed-displaced specifies the index register followed by a comma and
*   signed byte displacement. The register plus displacement is used as the
*   address of the word to jump to.
* - (IDPI) Indexed-displaced post-incremented specifies the register with a +
*   suffix followed by a comma and signed byte displacement. This jumps just as
*   for indexed-displaced (ID), then increments the register by two.
* - (IDPD) Indexed-displaced pre-decremented specifies the register with a
*   - suffix followed by a comma and signed byte displacement. This decrements
*   the register by two, then jumps just as for indexed-displaced (ID).
* - (IDI) Indexed-displaced-indirect specifies the index register with a
*   * prefix followed by a comma and signed byte displacement. The register plus
*   displacement is used as the address at which is the word address to jump to.
* - (IDIPI) Indexed-displaced-indirect post-incremented specifies the register
*   with a * prefix and + suffix followed by a comma and signed byte
*   displacement. This jumps just as for indexed-displaced-indirect (IDI), then
*   increments the register by two.
* - (IDIPD) Indexed-displaced-indirect pre-decremented specifies the register
*   with a * prefix and - suffix followed by a comma and signed byte
*   displacement. This decrements the register by two, then jumps just as for
*   indexed-displaced-indirect (IDI).
TEST7D
          LDA=      TEST09    ; A = TEST09.
*                                                         CPU5 instruction # 148
*                                                         CPU6 instruction # 910
          JSR+      A         ; Jump to subroutine at *A (I).
*                                                         CPU5 instruction # 148
*                                                         CPU6 instruction # 910
          LDA=      TEST09    ; A = TEST09.
*                                                         CPU5 instruction # 149
*                                                         CPU6 instruction # 911
          JSR+      A+        ; Jump to subroutine at *A; A+2 -> A (IPI).
*                                                         CPU5 instruction # 149
*                                                         CPU6 instruction # 911
          LDA=      TEST09+2  ; A = two past TEST09.
*                                                         CPU5 instruction # 150
*                                                         CPU6 instruction # 912
          JSR-      A-        ; A-2 -> A; jump to subroutine at *A (IPD).
*                                                         CPU5 instruction # 150
*                                                         CPU6 instruction # 912
          LDA=      T79+1     ; A = T79+1.
*                                                         CPU5 instruction # 151
*                                                         CPU6 instruction # 913
          JSR+      *A        ; Jump to subroutine at **A (II).
*                                                         CPU5 instruction # 151
*                                                         CPU6 instruction # 913
          LDA=      T79+1     ; A = T79+1.
*                                                         CPU5 instruction # 152
*                                                         CPU6 instruction # 914
          JSR+      *A+       ; Jump to subroutine at **A; A+2 -> A (IIPI).
*                                                         CPU5 instruction # 152
*                                                         CPU6 instruction # 914
          LDA=      T79+3     ; A = two past T79+1.
*                                                         CPU5 instruction # 153
*                                                         CPU6 instruction # 915
          JSR-      *A-       ; A-2 -> A; jump to subroutine at **A (IIPD).
*                                                         CPU5 instruction # 153
*                                                         CPU6 instruction # 915
          LDAB=     11        ; 11 blank lines.
          JSR/      MORE      ; Pause.
          LDA=      TEST09-4  ; A = four before TEST09.
*                                                         CPU5 instruction # 154
*                                                         CPU6 instruction # 916
          JSR+      A,4       ; Jump to subroutine at *(A+4) (ID).
*                                                         CPU5 instruction # 154
*                                                         CPU6 instruction # 916
          LDA=      TEST09-4  ; A = four before TEST09.
*                                                         CPU5 instruction # 155
*                                                         CPU6 instruction # 917
          JSR+      A+,4      ; Jump to subroutine at *(A+4); A+2 -> A (IDPI).
*                                                         CPU5 instruction # 155
*                                                         CPU6 instruction # 917
          LDA=      TEST09+3  ; A = three past TEST09.
*                                                         CPU5 instruction # 156
*                                                         CPU6 instruction # 918
          JSR-      A-,-1     ; A-2 -> A; jump to subroutine at *(A-1) (IDPD).
*                                                         CPU5 instruction # 156
*                                                         CPU6 instruction # 918
          LDA=      T79       ; A = one before T79+1.
*                                                         CPU5 instruction # 157
*                                                         CPU6 instruction # 919
          JSR+      *A,1      ; Jump to subroutine at **(A+1) (IID).
*                                                         CPU5 instruction # 157
*                                                         CPU6 instruction # 919
          LDA=      T79       ; A = one before T79+1.
*                                                         CPU5 instruction # 158
*                                                         CPU6 instruction # 920
          JSR+      *A+,1     ; Jump to subroutine at **(A+1); A+2 -> A (IIDPI).
*                                                         CPU5 instruction # 158
*                                                         CPU6 instruction # 920
          LDA=      T79       ; A = one before T79+1.
*                                                         CPU5 instruction # 159
*                                                         CPU6 instruction # 921
          JSR-      *A-,3     ; A-2 -> A; jump to subroutine at **(A+3) (IIDPD).
*                                                         CPU5 instruction # 159
*                                                         CPU6 instruction # 921
          RSR                 ; Return.
*
* Test STK.
* Push one or more word registers to the stack without affecting flags. The
* first argument is the first register to push. The second argument is the
* number of bytes to push and must be a multiple of two. Use POP to restore
* the register value(s) from the stack.
TEST7E
*         JMP/      TESTILL                               CPU5 illegal start
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU6 instruction # 922
          STK       A,2       ; Push A to the stack.
*                                                         CPU6 instruction # 922
          JSR/      PRINTREGS ; Print the registers.
          INA                 ; A+1 -> A.
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU6 instruction # 922
          STK       Y,4       ; Push Y and Z to the stack.
*                                                         CPU6 instruction # 922
          JSR/      PRINTREGS ; Print the registers.
          ADD=      3,Y       ; Y+3 -> Y.
          ADD=      5,Z       ; Z+5 -> Z.
          JSR/      PRINTREGS ; Print the registers.
          JMP       T7F       ; Run the POP test to restore the registers/stack.
*                                                         CPU5 illegal end
*
* Test POP.
* Pop one or more word registers from the stack without affecting flags. The
* first argument is the first register that was pushed by STK. The second
* argument is the number of bytes that were pushed and must be a multiple of
* two. See STK.
TEST7F
*         JMP/      TESTILL                               CPU5 illegal start
          JMP       TEST7E    ; Run the STK test to push things to the stack.
*                                                         CPU6 instruction # 923
T7F       POP       Y,4       ; Pop Z and Y from the stack.
*                                                         CPU6 instruction # 923
          JSR/      PRINTREGS ; Print the registers.
*                                                         CPU6 instruction # 923
          POP       A,2       ; Pop A from the stack.
*                                                         CPU6 instruction # 923
          JSR/      PRINTREGS ; Print the registers.
          RSR                 ; Return.
*                                                         CPU5 illegal end
*
* End of source.
          END      ENTRY      ; Set the entry point.
