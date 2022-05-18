8000:    00           HLT

DiagEntryPoint:
8001:    3a           CLAW				; Clear full word of implicit AW register
8002:    b1 b8 00     STAW 	(0xb800) 	; Store word of AW register into direct address 0xb800 (Stores 00 into address)
8005:    05           DI				; Disable interrupt system
8006:    0e           DLY 				; Delays for 4.5ms
8007:    a1 f1 4f     STAL 	(0xf14f)	; Store byte of AL register into direct address 0xf14f (Stores 0 into address)
800a:    a1 f2 0d     STAL 	(0xf20d)	; Store byte of AL register into direct address 0xf20d (Stores 0 into address)
800d:    a1 f2 0f     STAL 	(0xf20f)	; Store byte of AL register into direct address 0xf20f (Stores 0 into address)
8010:    90 c0 00     LDAW 	#0xc000		; Load literal address 0xc000 into word of AW register 
8013:    5f           XASW 				; Transfer byte of implicit AW into SW (Sets stack pointer to A register value)
8014:    22 32        CLR 	BL, 2		; Clear byte of BL and replace with constant (0010??)  

; This is the true start to TOS
TOS_Entry:
8016:    b5 a2        STAW	SW, 2		; Store word from register SW into AW and decrement and index (I blieve this is moving the stack pointer to AW)
8018:    b1 00 10     STAW	(0x0010)	; Store word of AW register into direct address 0x0010 (This is one of the interrupt levels?)
801b:    90 00 12     LDAW	#0x0012		; Load literal address 0x0012 into word of AW register
801e:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8020:    6d 01        STXW	AW, 1		; Use register AW as address and store in XW, then increment AW after
8022:    55 62        XFR	YW, BW		; Copy register BW into register YW
8024:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8026:    55 82        XFR	ZW, BW		; Copy register BW into register ZW
8028:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
802a:    55 a2        XFR	SW, BW 		; Copy register BW into register SW
802c:    30 20        INR	BW, 1+0		; Increment BW by 1+0
802e:    30 20        INR	BW, 1+0		; Increment BW by 1+0
8030:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8032:    55 c2        XFR	CW, BW		; Copy register BW into register CW
8034:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8036:    55 e2        XFR	PW, BW		; Copy register BW into register PW
8038:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
803a:    80 c5        LDAL	#0xc5		; Load literal address byte 0xc5 into AL register
803c:    a1 f2 00     STAL	(0xf200) 	; Store byte of AL register into direct adress of 0xf200 (0xf200 = UART MMIO -> Configure UART)
803f:    7b ??        JSR	(PC+0x??) 	; Jump to subroutine that is 0x?? bytes ahead of PC (WriteString)
8041:    c3	d5 c5 cf d3 dc 00			; ASCII for "CUEOS\"	

;803f:    85 a1        LDAL	SW, 1		; Use register SW as address and load into AL, then increment SW after
;8041:    7b 7a        JSR	(PC+0x7a) 	; Jump to subroutine that is 0x7a bytes ahead of PC (WriteHexByte) (I think this is writing "86"?)
;8043:    85 a1        LDAL	SW, 1		; Use register SW as address and load into AL, then increment SW after
;8044:    7b 76        JSR	(PC+0x76) 	; Jump to subroutine that is 0x76 bytes ahead of PC (WriteHexByte) (I think this is writing "4F"?)

; This is the main loop that shows the prompt and looks for a keypress of M, G, or Q
TOS_PromptLoop:
8048:    c0 5c        LDBL	#0x5c 		; Load literal address byte 0xc5 into BL register (Load " " into BL?)
804a:    7b ??        JSR	(PC+0x??)	; Jump to subroutine at PC+0x?? (WriteByte)
804c:    7b ??        JSR	(PC+0x??) 	; Jump to subroutine at PC+0x?? (ReadByteWithEcho)
804e:    45 31        XFR	BL, AL		; Copy byte AL into byte BL (Backwards?)
8050:    c0 4d        LDBL	#0x4d 		; Load literal address byte 0x4d into BL register (Load "M" into BL?)
8052:    49           SABL				; Subtract bytes AL minus BL and store in AL
8053:    14 ??        BZ	(PC+0x??)	; If equal to 0 branch 0x?? bytes ahead of current PC (M_Command) 
8055:    c0 47        LDBL	#0x47 		; Load literal address byte 0x47 into BL register (Load "G" into BL?)
8057:    49           SABL				; Subtract bytes AL minus BL and store in AL
8058:    14 ??        BZ	(PC+0x??)	; If equal to 0 branch 0x?? bytes ahead of current PC (G_Command)
805a:    c0 51        LDBL	#0x51 		; Load literal address byte 0x51 into BL register (Load "Q" into BL?)
805c:    49           SABL				; Subtract bytes AL minus BL and store in AL
805d:    15 ??        BNZ	(PC-0x??)	; If not equal to zero, branch to 0x?? bytes behind current PC (TOS_PromptLoop)
805f:    90 80 01     LDAW	#0x8001 	; Load literal address word 0x8001 into AW (8001 = Start of ROM)
8062:    73 ??        JMP	(PC+0x??)	; Jump to PC+0x?? bytes ahead (Q_Command)

; This is the GO command (type G followed by addres to execute code)
G_Command: 
8064:    7b ??        JSR	(PC+0x??)	; Jump to subroutine at PC+0x?? (ReadHexWord)
8066:    55 80        XFR	ZW, AW		; Copy word AW into word ZW (Backwards?)

; I don't actually know what this command does yet (Copies a bunch of registers among each other and then jumps to start? Q = Quit?)
Q_Command:
84c3:    b1 00 20     STAW	(0x0020)	; Store word of AW register into direct address 0x0020 (I believe this stores 0x8001 at 0x0020?)
84c6:    d0 00 1e     LDBW	#0x001e		; Load literal address 0x001e into word of BW register
84c9:    99           LAWB				; Load word from memory addres stored in implicit BW into AW register (one byte instruction)
84ca:    55 0e        XFR	AW, P		; Copy word P into word AW (Backwards?)
84cc:    95 22        LDAW	BW, 2		; Use register BW as address and load into AW, then decrement BW after
84ce:    55 0c        XFR	AW, CW		; Copy word CW into word AW (Backwards?)
84d0:    95 22        LDAW	BW, 2		; Use register BW as address and load into AW, then decrement BW after
84d2:    5f           XASW				; Copy implicit AW into implicit SW
84d3:    95 22        LDAW	BW, 2		; Use register BW as address and load into AW, then decrement BW after
84d5:    5e           XAZW				; Copy implicit AW into implicit ZW
84d6:    95 22        LDAW	BW, 2		; Use register BW as address and load into AW, then decrement BW after
84d8:    5c           XAYW				; Copy implicit AW into implicit YW
84d9:    65 22        LDXW	BW, 2		; Use register BW as address and load into XW, then decrement BW after
84db:    d5 22        LDBW	BW, 2		; Use register BW as address and load into BW, then decrement BW after
84dd:    91 00 10     LDAW	(0x0010)	; Load direct address 0x0010 into word AW
84e0:    72 00 20     JMP	[0x0020]	; Jump to indrect address stored at 0x0020 (I believe this jumps to 0x8001 which was stored at 0x0020?)

; This is the Modify command (type M followed by an address and it shows the value and you can change it)
M_Command:
84e3:    7b 55        JSR	(PC+0x55)	; Jump to subroutine at 0x55 bytes ahead of current PC (ReadHexWord)
84e5:    55 86        XFR	ZW, YW		; Copy word YW into word ZW (Backwards?)

L_84e7:
84e7:    8b           LALY				; Load byte from memory address in implicit YW into AL
84e8:    7b 2f        JSR	(PC+0x2f)	; Jump to subroutine at 0x2f bytes ahead of current PC (WriteHexByte:)

L_84ea:
84ea:    7b 4e        JSR	(PC+0x4e) 	; Jump to subroutine at 0x4e bytes ahead of current PC (ReadHexWord:)
84ec:    45 91        XFR	ZL, AL		; Copy word AL into word ZL (Backwards?)
84ee:    c1 bf 92     LDBL	(0xbf92)	; Load direct address 0xbf92 into byte of BL register 
84f1:    14 01        BZ	(PC+0x01)	; Branch if equal to zero to 1 byte ahead of current PC (L_84f4:)
84f3:    ab           SALY				; Store byte from memory address stored in YW into AL register

L_84f4:
84f4:    13 04        BNF	(PC+0x04)	; Branch if fault not set to 0x04 bytes ahead of current PC (L_84fa:)
84f6:    30 60        INR	YW, 0		; Increment full word of YW register by 1+0 bytes
84f8:    73 f0        JMP	(PC-0x10)	; Jump direct to 10 bytes behind curent PC (L_84ea:)

L_84fa:
84fa:    11 a7        BNL	(PC-0x57)	; Branch if link/carry not set to 0x57 bytes behind current PC (TOS_PromptLoop:)
84fc:    30 60        INR	YW, 0		; Increment full word of YW register by 1+0 bytes
84fe:    73 e7        JMP (PC-0x19) 	; Jump to 0x19 bytes behind current PC (L_84e7:)

ReadByteWithEcho:
8500:    7b 55        JSR	(PC+0x55)	; Jump to subroutine 55 bytes ahead current PC (CheckForReset:)
8502:    81 f2 00     LDAL	(0xf200)	; Load direct address 0xf200 into byte of AL register
8505:    2c           SRAL				; Shift byte of implicit register AL left 
8506:    11 f8        BNL	(PC-0x07)	; Branch to 7 bytes behind program counter (ReadByteWithEcho:)
8508:    81 f2 01     LDAL	(0xf201)	; Load direct address 0xf201 into byte of AL register
850b:    c0 7f        LDBL	#0x7f		; Load literal address 0x7f into byte of BL register
850d:    4a           NABL				; AND bytes AL and BL and store in AL

WriteByte:	
850e:    81 f2 00     LDAL	(0xf200)	; Load direct address 0xf200 into byte of AL register
8511:    2c           SRAL				; Shift byte of implicit register AL left 
8512:    2c           SRAL				; Shift byte of implicit register AL left 
8513:    11 f9        BNL	(PC-0x06)	; Branch to 6 bytes behind program counter (WriteByte:)
8515:    e1 f2 01     STBL	(0xf201)	; Store direct address 0xf201 into byte of BL register
8518:    09           RSR				; Return from subroutine

WriteHexByte:
8519:    7b 05        JSR	(PC+0x05) 	; Jump to subroutine 0x05 bytes ahead current PC (WriteHexNibble:)
851b:    45 01        XFR	AH, AL		; Copy AH into AL
851d:    7b 01        JSR	(PC+0x01) 	; Jump to subroutine 0x05 bytes ahead current PC (WriteHexNibble:)
851f:    09           RSR				; Return from subroutine

WriteHexNibble:
8520:    22 00        CLR	AH, 0		; Clear byte of AH to 0
8522:    36 00        RRR	AW, 0		; Rotate full word of AW right by 1 + 0
8524:    36 00        RRR	AW, 0		; Rotate full word of AW right by 1 + 0
8526:    36 00        RRR	AW, 0		; Rotate full word of AW right by 1 + 0
8528:    36 00        RRR	AW, 0		; Rotate full word of AW right by 1 + 0
852a:    26 00        RRR	AH, 0		; Rotate byte of AH right by 1 + 0
852c:    c0 0a        LDBL	#0x0a		; Load literal address byte 0x0a into BL register
852e:    49           SABL				; SUB AL minus BL and store in AL
852f:    16 05        BM	(PC+0x05)	; Branch if minus set to 0x05 bytes ahead of current PC (L_8536:)
8531:    c0 37        LDBL	#0x37		; Load literal address byte 0x37 into BL register

L_8533:
8533:    48           AABL				; ADD AL plus BL and store in AL
8534:    73 d8        JMP	(PC-0x28)	; Jump to 0x28 bytes behind current PC (WriteByte:)

L_8536:
8536:    c0 30        LDBL	#0x30		; Load literal address byte 0x30 into BL register
8538:    73 f9        JMP	(PC-0x07) 	; Jump to 0x07 bytes behind current PC (L_8533:)

ReadHexWord:
853a:    3a           CLAW				; Clear full word of AW register
853b:    5e           XAZW				; Copy implicit AW into implicit ZW
853c:    a1 bf 92     STAL	(0xbf92)	; Store byte of AL register directly into address 0xbf92 (Diag SRAM?)

L_853f:
853f:    7b bf        JSR	(PC-0x41)	; Jump to subroutine 41 bytes behind current PC (ReadByteWithEcho:)
8541:    7b 25        JSR 	(PC+0x25) 	; Jump to subroutine 25 bytes ahead current PC (AsciiToHexNibble:)
L_8543:
8543:    17 01        BP	(PC+0x01)	; Branch on positive to 1 byte ahead of current PC (L_8546:)
8545:    09           RSR				; Return from subroutine

L_8546:
8546:    35 80        SLR	ZW, 0		; Shift full word of explicit register ZW right by 1+0 bytes
8548:    35 80        SLR	ZW, 0		; Shift full word of explicit register ZW right by 1+0 bytes
854a:    35 80        SLR	ZW, 0		; Shift full word of explicit register ZW right by 1+0 bytes
854c:    35 80        SLR	ZW, 0		; Shift full word of explicit register ZW right by 1+0 bytes
854e:    43 19        ORI	AL, ZL		; Orbytes of AL and ZL and store in AL
8550:    80 01        LDAL	#0x01		; Load literal address byte 0x01 into AL register
8552:    a1 bf 92     STAL	(0xbf92)	; Store byte of AL register directly into address 0xbf92 (Diag SRAM?)
8555:    73 e8        JMP	(PC-0x18)	; Jump to 0x18 bytes behind current program counter (8543:???)

CheckForReset:
8557:    80 0f        LDAL	#0x0f		; Load literal address byte 0x0f into AL register
8559:    c1 f1 10     LDBL	(0xf110)	; Load direct address 0xF110 into byte of BL register
855c:    4a           NABL				; AND implicit bytes of AL and BL and store in AL
855d:    80 0a        LDAL	#0x0a		; Load literal address byte 0x0a into AL register
855f:    49           SABL				; SUB implicit bytes of AL and BL and store in AL
8560:    15 01        BNZ	(PC+0x01)	; Branch if not zero to 1 byte ahead of current PC (L_8563:)
8562:    09           RSR

L_8563:
8563:    71 80 01     JMP	#0x8001		; Jump to direct address 0x8001 (DiagEntryPoint:)

WriteByteTramp:
8566:    73 a6        JMP	(PC-0x5a)	;  Jump to 5a bytes behind current program counter (WriteByte:)

AsciiToHexNibble:
8568:    45 31        XFR	BL, AL		; Copy word AL into word BL (Backwards?)
856a:    c0 30        LDBL	#0x30		; Load literal address byte 0x30 into BL register
856c:    49           SABL				; SUB implicit bytes of AL and BL and store in AL
856d:    16 13        BM	(PC+0x13)	; Branch if minus set to 0x13 bytes ahead of current PC (L_8582:) 
856f:    c0 47        LDBL	#0x47		; Load literal address byte 0x47 into BL register
8571:    49           SABL				; SUB implicit bytes of AL and BL and store in AL
8572:    17 1e        BP	(PC+0x1e)	; Branch on positive to 0x1e bytes ahead of current PC (L_8592:)
8574:    c0 40        LDBL	#0x40		; Load literal address byte 0x40 into BL register
8576:    4a           NABL				; AND implicit bytes of AL and BL and store in AL
8577:    14 04        BZ	(PC+0x04)	; If equal to 0 branch 0a bytes ahead of current PC (G_Command)L_857d
8579:    c0 09        LDBL	#0x09		; Load literal address byte 0x09 into BL register
857b:    40 31        ADD 	BL, AL		; ADD BL plus AL and store in BL

L_857d:
857d:    c0 0f        LDBL	#0x0f		; Load literal address byte 0x0f into BL register
857f:    42 31        AND	BL, AL		; AND BL and AL and store in BL
8581:    09           RSR				; Return from subroutine

L_8582:
8582:    c0 20        LDBL	#0x20		; Load literal address byte 0x20 into BL register
8584:    49           SABL				; SUB implicit bytes of AL and BL and store in AL
8585:    15 02        BNZ	(PC+0x02)	; Branch if not equal to zero to 0x02 bytes ahead of current PC (L_8589:)
8587:    2b           IVAL				; Invert byte of implicit AL register
8588:    09           RSR				; Return from subroutine

L_8589:
8589:    c0 2c        LDBL	#0x2c		; Load literal address byte 0x2c into BL register ('\n'?)
858b:    49           SABL				; SUB implicit bytes of AL and BL and store in AL
858c:    15 04        BNZ	(PC+0x04)	; Branch if not equal to zero to 0x02 bytes ahead of current PC (L_8592:)
858e:    02           SF				; Set fault
858f:    07           RL				; Reset link/carry
8590:    2b           IVAL				; Invert byte of implicit AL register
8591:    09           RSR				; Return from subroutine

L_8592:
8592:    c0 0a        LDBL	#0x2c		; Load literal address byte 0x2c into BL register ('\n'?)
8594:    7b d0        JSR	(PC-0x30) 	; Jump to subroutine 30 bytes behind current PC (WriteByteTramp:)
8596:    c0 7f        LDBL	#0x7f		; Load literal address byte 0x7f into BL register (ascii DEL charater?)
8598:    7b cc        JSR	(PC-0x34)	; Jump to subroutine 34 bytes behind current PC (WriteByteTramp:)
859a:    2a           CLAL				; Clear byte of implicit AL register
859b:    2b           IVAL				; Invert byte of implicit AL register
859c:    09           RSR				; Return from subroutine
; This is where the ASCII Hex to Nibble Subroutine ends




; THIS IS OUR WRITE STRING SUBROUTINE! (Used by TOS?)
WriteString:
8623:    81 f2 00     LDAL	(0xf200)	; Load direct address 0xf200 into byte of AL register (MUX MMIO?)
8626:    2c           SRAL				; Shift byte of implicit register AL left
8627:    2c           SRAL				; Shift byte of implicit register AL left
8628:    11 f9        BNL	(PC-0x06)	; Branch if link not set to 6 bytes behind program counter (WriteString:)
862a:    85 41        LDAL	XW, 1		; Use register XW as address and load into AL, then increment XW after
862c:    15 01        BNZ	(PC+0x01)	; Branch if not equal to zero to 0x01 bytes ahead current PC (L_862f:)
862e:    09           RSR				; Return from subroutine

L_862f:
862f:    a1 f2 01     STAL	(0xf201)	; Store byte of AL register directly into address 0xf201 (MUX MMIO?)
8632:    73 ef        JMP	(PC-0x11) 	; Jump to 11 bytes behind current PC (WriteString:)
