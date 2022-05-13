8000:    00           HALT

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
8014:    22 32        CLR 	BL, 2		; Clear byte of BL and replace with constant (0000 0010??)  


; I'm pretty sure that from here to TOS entry is not strictly needed on a custom TOS only board
8016:    14 0b        BZ 	0b			; Branch 0b bytes ahead (to L_8023) if equal to zero (If what is equal to zero??)
8018:    90 80 77     LDAW	#0x8077		; Load literal address 0x8077 into word of AW register (This address is the FAIL subroutine in F1, maybe not needed here)
801b:    b1 00 fe     STAW	(0x00fe) 	; Store word of AW register into direct address 0xb800 (Write pointer directly into register??)
801e:    3a           CLAW				; Clear full word of implicit AW register
801f:    b1 00 fc     STAW	(0x00fc) 	; Store word of AW register into direct address 0x00fc
8022:    76           SYSCALL			; Call interrupt level 15

L_8023:
8023:    3a           CLAW				; Clear full word of implicit AW register
8024:    a1 f1 09     STAL 	(0xf109) 	; Store byte of AL register into direct address 0xf109 (Turn Decimal Point 1 off)
8027:    a1 f1 0b     STAL 	(0xf10b) 	; Store byte of AL register into direct address 0xf10b (Turn Decimal Point 2 off)
802a:    a1 f1 0d     STAL 	(0xf10d) 	; Store byte of AL register into direct address 0xf10d (Turn Decimal Point 3 off)
802d:    a1 f1 0f     STAL 	(0xf10f) 	; Store byte of AL register into direct address 0xf10f (Turn Decimal Point 4 off)
8030:    81 f1 10     LDAL	(0xf110) 	; Load direct address (0xf110) into byte of AL register (Load Dip swiches value into AL)
8033:    c0 0f        LDBL	#0x0f		; Load literal address #0x0F into byte of BL register
8035:    42 31        AND	3, 1 		; AND BL with AL and store in AL (A = A & 0x0f)
8037:    a1 f1 10     STAL	(0xf110) 	; Store byte of AL register into direct address 0xf110 (Write A to hex displays)
803a:    a1 f1 06     STAL	(0xf106) 	; Store byte of AL register into direct address 0xf106 (Unblank the hex displys)


; This is the true start to TOS
TOS_Entry:
846f:    b5 a2        STAW	SW, 2		; Store word from register SW into AW and decrement and index (I blieve this is moving the stack pointer to AW)
8471:    a1 f1 0a     STAL	(0xf10a)	; Store byte of AL register into direct address 0xf10a (This moves part of the stack pointer to f10a which is DIAG MMIO)
8474:    b1 00 10     STAW	(0x0010)	; Store word of AW register into direct address 0x0010 (No clue what's at 0010)
8477:    90 00 12     LDAW	#0x0012		; Load literall address 0x0012 into word of AW register
847a:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
847c:    6d 01        STXW	AW, 1		; Use register AW as address and store in XW, then increment AW after
847e:    55 62        XFR	YW, BW		; Copy register BW into register YW
8480:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8482:    55 82        XFR	ZW, BW		; Copy register BW into register ZW
8484:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8486:    55 a2        XFR	SW, BW 		; Copy register BW into register SW
8488:    30 20        INR	BW, 1+0		; Increment BW by 1+0
848a:    30 20        INR	BW, 1+0		; Increment BW by 1+0
848c:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
848e:    55 c2        XFR	CW, BW		; Copy register BW into register CW
8490:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8492:    55 e2        XFR	PW, BW		; Copy register BW into register PW
8494:    f5 01        STBW	AW, 1		; Use register AW as address and store in BW, then increment AW after
8496:    80 c5        LDAL	#0xc5		; Load literal address byte 0xc5 into AL register
8498:    a1 f2 00     STAL	(0xf200) 	; Store byte of AL register into direct adress of 0xf200 (0xf200 = UART MMIO -> Configure UART)
849b:    85 a1        LDAL	SW, 1		; Use register AW as address and load into SW, then increment AW after
849d:    7b 7a        JSR	(PC+0x7a) 	; Jump to subroutine that is 0x7a bytes ahead of PC (WriteHexByte) (I think this is writing "86"?)
849f:    85 a1        LDAL	SW, 1		; Use register AW as address and load into SW, then increment AW after (I think this is writing "4F"?)
84a1:    7b 76        JSR	(PC+0x76) 	; Jump to subroutine that is 0x76 bytes ahead of PC (WriteHexByte)

; This is the main loop that shows the prompt and looks for a keypress of M, G, or Q
TOS_PromptLoop:
84a3:    c0 5c        LDBL	#0x5c 		; Load literal address byte 0xc5 into BL register (Load " " into BL?)
84a5:    7b 67        JSR	(PC+0x67)	; Jump to subroutine at PC+0x67 (WriteByte)
84a7:    7b 57        JSR	(PC+0x57) 	; Jump to subroutine at PC+0x67 (ReadByteWithEcho)
84a9:    45 31        XFR	BL, AL		; Copy byte AL into byte BL (Backwards?)
84ab:    c0 4d        LDBL	#0x4d 		; Load literal address byte 0x4d into BL register (Load "M" into BL?)
84ad:    49           SABL				; Subtract bytes AL minus BL and store in AL
84ae:    14 33        BZ	33			; If equal to 0 branch 33 bytes ahead of current PC (M_Command) 
84b0:    c0 47        LDBL	#0x47 		; Load literal address byte 0x47 into BL register (Load "G" into BL?)
84b2:    49           SABL				; Subtract bytes AL minus BL and store in AL
84b3:    14 0a        BZ	0a			; If equal to 0 branch 0a bytes ahead of current PC (G_Command)
84b5:    c0 51        LDBL	#0x51 		; Load literal address byte 0x51 into BL register (Load "Q" into BL?)
84b7:    49           SABL				; Subtract bytes AL minus BL and store in AL
84b8:    15 e9        BNZ	e9			; If not equal to zero, branch to ???? bytes behind current PC (TOS_PromptLoop)
84ba:    90 80 01     LDAW	#0x8001 	; Load literal address word 0x8001 into AW (8001 = Start of ROM)
84bd:    73 04        JMP	(PC+0x04)	; Jump to PC+0x04 bytes ahead (Q_Command)

; This is the GO command (type G followed by addres to execute code)
G_Command: 
84bf:    7b 79        JSR	(PC+0x79)	; Jump to subroutine at PC+0x79 (ReadHexWord)
84c1:    55 80        XFR	ZW, AW		; Copy word AW into word ZW (Backwards?)

; I don't actually know what this command does yet (Copies a bunch of registers among each other and then jumps to start? Q = Quit?)
Q_Command:
84c3:    b1 00 20     STAW	(0x0020)	; Store word of AW register into direct address 0x0020 (I believe this stores 0x8001 at 0x0020?)
84c6:    d0 00 1e     LDBW	#0x001e		; Load literal address 0x001e into word of BW register
84c9:    99           LDAW	[BW]		; Load word from memory addres stored in BW into AW register (one byte instruction)
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
84e3:    7b 55        JSR	(PC+0x55)	; Jump to subroutine at PC+0x79 (ReadHexWord)
84e5:    55 86        XFR	ZW, YW		; Copy word YW into word ZW (Backwards?)mov.w EF, HL

L_84e7:
84e7:    8b           ld.b A, (EF)
84e8:    7b 2f        call (PC+0x2f) WriteHexByte

L_84ea:
84ea:    7b 4e        call (PC+0x4e) ReadHexWord
84ec:    45 91        mov.b A, L
84ee:    c1 bf 92     ld.b C, (0xbf92)
84f1:    14 01        bz L_84f4
84f3:    ab           st.b A, (EF)

L_84f4:
84f4:    13 04        bnn L_84fa
84f6:    30 60        inc.w EF
84f8:    73 f0        jump (PC-0x10) L_84ea

L_84fa:
84fa:    11 a7        bnc TOS_PromptLoop
84fc:    30 60        inc.w EF
84fe:    73 e7        jump (PC-0x19) L_84e7

ReadByteWithEcho:
8500:    7b 55        call (PC+0x55) CheckForReset ; Jumps back to the start of F1 if some condition is met
8502:    81 f2 00     ld.b A, (0xf200)
8505:    2c           srl.b A
8506:    11 f8        bnc ReadByteWithEcho
8508:    81 f2 01     ld.b A, (0xf201)
850b:    c0 7f        ld.b C, #0x7f
850d:    4a           and.b C, A

WriteByte:
850e:    81 f2 00     ld.b A, (0xf200)
8511:    2c           srl.b A
8512:    2c           srl.b A
8513:    11 f9        bnc WriteByte
8515:    e1 f2 01     st.b C, (0xf201)
8518:    09           ret

WriteHexByte:
8519:    7b 05        call (PC+0x05) WriteHexNibble
851b:    45 01        mov.b A, B
851d:    7b 01        call (PC+0x01) WriteHexNibble
851f:    09           ret

WriteHexNibble:
8520:    22 00        clr.b B
8522:    36 00        rrc.w BA
8524:    36 00        rrc.w BA
8526:    36 00        rrc.w BA
8528:    36 00        rrc.w BA
852a:    26 00        rrc.b B
852c:    c0 0a        ld.b C, #0x0a
852e:    49           sub.b C, A
852f:    16 05        blt L_8536
8531:    c0 37        ld.b C, #0x37

L_8533:
8533:    48           add.b C, A
8534:    73 d8        jump (PC-0x28) WriteByte

L_8536:
8536:    c0 30        ld.b C, #0x30
8538:    73 f9        jump (PC-0x07) L_8533

ReadHexWord:
853a:    3a           CLAW				; Clear full word of AW register
853b:    5e           XAZW				; Copy implicit AW into implicit ZW
853c:    a1 bf 92     STAL	(0xbf92)	; Store byte of AL register directly into address 0xbf92 (Diag SRAM?)

L_853f:
853f:    7b bf        JSR	(PC-0x41)	; Jump to subroutine 41 bytes behind current PC (ReadByteWithEcho:)
8541:    7b 25        JSR 	(PC+0x25) 	; Jump to subroutine 25 bytes ahead current PC (AsciiToHexNibble:)
8543:    17 01        BP	(PC+0x01)	; Branch on positive to 1 byte ahead of current PC (L_8546:)
8545:    09           RSR				; Return from subroutine

L_8546:
8546:    35 80        sll.w HL
8548:    35 80        sll.w HL
854a:    35 80        sll.w HL
854c:    35 80        sll.w HL
854e:    43 19        or.b L, A
8550:    80 01        ld.b A, #0x01
8552:    a1 bf 92     st.b A, (0xbf92)
8555:    73 e8        jump (PC-0x18) L_853f

CheckForReset:
8557:    80 0f        ld.b A, #0x0f
8559:    c1 f1 10     ld.b C, (0xf110)
855c:    4a           and.b C, A
855d:    80 0a        ld.b A, #0x0a
855f:    49           sub.b C, A
8560:    15 01        bnz L_8563
8562:    09           ret

L_8563:
8563:    71 80 01     jump #0x8001 DiagEntryPoint

WriteByteTramp:
8566:    73 a6        jump (PC-0x5a) WriteByte

AsciiToHexNibble:
8568:    45 31        mov.b A, C
856a:    c0 30        ld.b C, #0x30
856c:    49           sub.b C, A
856d:    16 13        blt L_8582
856f:    c0 47        ld.b C, #0x47
8571:    49           sub.b C, A
8572:    17 1e        ble L_8592
8574:    c0 40        ld.b C, #0x40
8576:    4a           and.b C, A
8577:    14 04        bz L_857d
8579:    c0 09        ld.b C, #0x09
857b:    40 31        add.b A, C

L_857d:
857d:    c0 0f        ld.b C, #0x0f
857f:    42 31        and.b A, C
8581:    09           ret

L_8582:
8582:    c0 20        ld.b C, #0x20
8584:    49           sub.b C, A
8585:    15 02        bnz L_8589
8587:    2b           not.b A
8588:    09           ret

L_8589:
8589:    c0 2c        ld.b C, #0x2c
858b:    49           sub.b C, A
858c:    15 04        bnz L_8592
858e:    02           fsn
858f:    07           fcc
8590:    2b           not.b A
8591:    09           ret

L_8592:
8592:    c0 0a        ld.b C, #0x0a ; '\n'
8594:    7b d0        call (PC-0x30) WriteByteTramp
8596:    c0 7f        ld.b C, #0x7f ; This is the ascii DEL charater
8598:    7b cc        call (PC-0x34) WriteByteTramp
859a:    2a           clr.b A
859b:    2b           not.b A
859c:    09           ret

Test_0b:
859d:    a1 f2 0d     st.b A, (0xf20d)
85a0:    a1 f1 4d     st.b A, (0xf14d)
85a3:    a1 f1 0a     st.b A, (0xf10a)
85a6:    80 c5        ld.b A, #0xc5
85a8:    a4 7a        st.b A, @(PC+0x7a)
85aa:    80 8c        ld.b A, #0x8c
85ac:    a1 f2 01     st.b A, (0xf201)
85af:    0e           delay 4.5ms
85b0:    0e           delay 4.5ms

L_85b1:
85b1:    7b 70        call (PC+0x70) WriteString
85b3:    "D=\0"
85b6:    7b 7c        call (PC+0x7c) ReadChar
85b8:    c0 c8        ld.b C, #0xc8
85ba:    49           sub.b C, A
85bb:    e5 a2        st.b C, -(SP)
85bd:    14 05        bz L_85c4
85bf:    c0 c6        ld.b C, #0xc6
85c1:    49           sub.b C, A
85c2:    15 4e        bnz L_8612

L_85c4:
85c4:    7b 6e        call (PC+0x6e) ReadChar
85c6:    c0 50        ld.b C, #0x50
85c8:    40 31        add.b A, C
85ca:    16 46        blt L_8612
85cc:    c5 a1        ld.b C, (SP)+
85ce:    14 7d        bz L_864d
85d0:    c0 03        ld.b C, #0x03
85d2:    49           sub.b C, A
85d3:    18 3d        bgt L_8612
85d5:    d0 0f 00     ld.w DC, #0x0f00
85d8:    f5 a2        st.w DC, -(SP)
85da:    32 20        clr.w DC
85dc:    f5 a2        st.w DC, -(SP)
85de:    c0 88        ld.b C, #0x88
85e0:    e5 a2        st.b C, -(SP)
85e2:    d0 83 00     ld.w DC, #0x8300
85e5:    f5 a2        st.w DC, -(SP)
85e7:    d0 81 00     ld.w DC, #0x8100
85ea:    06           fsc

L_85eb:
85eb:    27 30        rlc.b C
85ed:    29           dec.b A
85ee:    17 fb        ble L_85eb
85f0:    f5 a2        st.w DC, -(SP)
85f2:    2f 14        DMA load 1, 4
85f4:    2f 06        DMA load 0, 6
85f6:    2f a0        DMA load 10, 0
85f8:    90 ff f6     ld.w BA, #0xfff6
85fb:    2f 02        DMA load 0, 2
85fd:    7b 22        call (PC+0x22) L_8621
85ff:    43 90        or.b B, L
8601:    01           nop
8602:    00           HALT
8603:    2f 00        DMA load 0, 0
8605:    90 f0 ff     ld.w BA, #0xf0ff
8608:    2f 02        DMA load 0, 2
860a:    7b 7e        call (PC+0x7e) L_868a
860c:    45 15        mov.b T, A
860e:    03           fcn

L_860f:
860f:    71 01 03     jump #0x0103 L_0103

L_8612:
8612:    7b 0f        call (PC+0x0f) WriteString
8614:    "\r\nERROR\r\n\0"
861e:    07           fcc
861f:    73 90        jump (PC-0x70) L_85b1

L_8621:
8621:    73 67        jump (PC+0x67) L_868a

WriteString:
8623:    81 f2 00     ld.b A, (0xf200)
8626:    2c           srl.b A
8627:    2c           srl.b A
8628:    11 f9        bnc WriteString
862a:    85 41        ld.b A, (RT)+
862c:    15 01        bnz L_862f
862e:    09           ret

L_862f:
862f:    a1 f2 01     st.b A, (0xf201)
8632:    73 ef        jump (PC-0x11) WriteString

ReadChar:
8634:    7b 6d        call (PC+0x6d) L_86a3
8636:    84 ec        ld.b A, @(PC-0x14)
8638:    2c           srl.b A
8639:    11 f9        bnc ReadChar
863b:    84 f3        ld.b A, @(PC-0xd)
863d:    c0 80        ld.b C, #0x80
863f:    43 31        or.b A, C
8641:    c0 e0        ld.b C, #0xe0
8643:    49           sub.b C, A
8644:    16 04        blt L_864a
8646:    c0 df        ld.b C, #0xdf
8648:    42 31        and.b A, C

L_864a:
864a:    a4 e4        st.b A, @(PC-0x1c)
864c:    09           ret

L_864d:
864d:    c0 07        ld.b C, #0x07
864f:    49           sub.b C, A
8650:    18 c0        bgt L_8612
8652:    a1 f1 40     st.b A, (0xf140)
8655:    94 2d        ld.w BA, @(PC+0x2d)
8657:    d0 00 10     ld.w DC, #0x0010
865a:    5a           and.w DC, BA
865b:    14 b5        bz L_8612
865d:    3a           clr.w BA
865e:    b1 f1 41     st.w BA, (0xf141)
8661:    7b 35        call (PC+0x35) L_8698
8663:    03           fcn

L_8664:
8664:    94 1e        ld.w BA, @(PC+0x1e)
8666:    d0 04 00     ld.w DC, #0x0400
8669:    5a           and.w DC, BA
866a:    15 a6        bnz L_8612
866c:    d0 00 20     ld.w DC, #0x0020
866f:    5a           and.w DC, BA
8670:    14 f2        bz L_8664
8672:    2f 04        DMA load 0, 4
8674:    2f 06        DMA load 0, 6
8676:    90 01 00     ld.w BA, #0x0100
8679:    2f 00        DMA load 0, 0
867b:    90 ea 1f     ld.w BA, #0xea1f
867e:    2f 02        DMA load 0, 2
8680:    7b 16        call (PC+0x16) L_8698
8682:    00           HALT
8683:    81 f1 44     ld.b A, (0xf144)
8686:    15 8a        bnz L_8612
8688:    73 85        jump (PC-0x7b) L_860f

L_868a:
868a:    85 41        ld.b A, (RT)+
868c:    a1 f8 00     st.b A, (0xf800)

L_868f:
868f:    81 f8 01     ld.b A, (0xf801)
8692:    29           dec.b A
8693:    15 fa        bnz L_868f
8695:    84 f6        ld.b A, @(PC-0xa)
8697:    09           ret

L_8698:
8698:    85 41        ld.b A, (RT)+
869a:    a1 f1 48     st.b A, (0xf148)

L_869d:
869d:    84 e5        ld.b A, @(PC-0x1b)
869f:    2c           srl.b A
86a0:    10 fb        bc L_869d
86a2:    09           ret

L_86a3:
86a3:    80 0f        ld.b A, #0x0f
86a5:    c1 f1 10     ld.b C, (0xf110)
86a8:    4a           and.b C, A
86a9:    80 0b        ld.b A, #0x0b
86ab:    49           sub.b C, A
86ac:    15 01        bnz L_86af
86ae:    09           ret

L_86af:
86af:    71 80 01     jump #0x8001 DiagEntryPoint

Test_0c:
86b2:    d0 0f 0c     ld.w DC, #0x0f0c
86b5:    81 f1 10     ld.b A, (0xf110)
86b8:    42 21        and.b A, D
86ba:    49           sub.b C, A
86bb:    14 03        bz L_86c0
86bd:    71 80 01     jump #0x8001 DiagEntryPoint

L_86c0:
86c0:    60 80 00     ld.w RT, #0x8000
86c3:    3a           clr.w BA

L_86c4:
86c4:    85 41        ld.b A, (RT)+
86c6:    40 10        add.b B, A
86c8:    d0 87 f9     ld.w DC, #0x87f9
86cb:    51 42        sub.w DC, RT
86cd:    15 f5        bnz L_86c4
86cf:    8a           ld.b A, (RT)
86d0:    41 01        sub.b A, B
86d2:    15 49        bnz L_871d
86d4:    90 b8 00     ld.w BA, #0xb800
86d7:    5b           or.w DC, BA
86d8:    5c           mov EF, BA
86d9:    d0 04 00     ld.w DC, #0x0400

L_86dc:
86dc:    a8           st.b A, (BA)
86dd:    38           inc.w BA
86de:    31 20        dec.w DC
86e0:    15 fa        bnz L_86dc
86e2:    d0 04 00     ld.w DC, #0x0400

L_86e5:
86e5:    8a           ld.b A, (RT)
86e6:    41 51        sub.b A, T
86e8:    15 3a        bnz L_8724
86ea:    3e           inc RT
86eb:    31 20        dec.w DC
86ed:    15 f6        bnz L_86e5
86ef:    d0 04 00     ld.w DC, #0x0400
86f2:    55 64        mov.w RT, EF

L_86f4:
86f4:    45 51        mov.b A, T
86f6:    2b           not.b A
86f7:    a5 41        st.b A, (RT)+
86f9:    31 20        dec.w DC
86fb:    15 f7        bnz L_86f4
86fd:    d0 04 00     ld.w DC, #0x0400
8700:    55 64        mov.w RT, EF

L_8702:
8702:    8a           ld.b A, (RT)
8703:    2b           not.b A
8704:    41 51        sub.b A, T
8706:    15 1c        bnz L_8724
8708:    3e           inc RT
8709:    31 20        dec.w DC
870b:    15 f5        bnz L_8702
870d:    a1 f1 0c     st.b A, (0xf10c)
8710:    a1 f1 0a     st.b A, (0xf10a)
8713:    a1 f1 0e     st.b A, (0xf10e)
8716:    80 88        ld.b A, #0x88
8718:    a1 f1 10     st.b A, (0xf110)
871b:    73 95        jump (PC-0x6b) Test_0c

L_871d:
871d:    c0 1c        ld.b C, #0x1c

L_871f:
871f:    79 80 e3     call #0x80e3 L_80e3
8722:    73 8e        jump (PC-0x72) Test_0c

L_8724:
8724:    c0 2c        ld.b C, #0x2c
8726:    73 f7        jump (PC-0x09) L_871f