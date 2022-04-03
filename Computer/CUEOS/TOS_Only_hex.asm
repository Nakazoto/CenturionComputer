00 3a b1 b8 00 05 0e a1
f1 4f a1 f2 0d a1 f2 0f
90 c0 00 5f 22 32 14 0b
90 80 77 b1 00 fe 3a b1
00 fc 76 b5 a2 a1 f1 0a
b1 00 10 90 00 12 f5 01
6d 01 55 62 f5 01 55 82
f5 01 55 a2 30 20 30 20
f5 01 55 c2 f5 01 55 e2
f5 01 80 c5 a1 f2 00 85
a1 7b 7a 85 a1 7b 76 c0
5c 7b 67 7b 57 45 31 c0
4d 49 14 33 c0 47 49 14
0a c0 51 49 15 e9 90 80
01 73 04 7b 79        call ReadHexWord
84c1:    55 80        mov AX, r4

Q_Command:
84c3:    b1 00 20     mov [0x0020], AX
84c6:    d0 00 1e     mov BX, 0x001e
84c9:    99           mov AX, single_byte[BX]
84ca:    55 0e        mov r7, AX
84cc:    95 22        mov AX, [BX++]
84ce:    55 0c        mov r6, AX
84d0:    95 22        mov AX, [BX++]
84d2:    5f           mov SP, AX
84d3:    95 22        mov AX, [BX++]
84d5:    5e           mov r4, AX
84d6:    95 22        mov AX, [BX++]
84d8:    5c           xor BX, AX
84d9:    65 22        mov r2, [BX++]
84db:    d5 22        mov BX, [BX++]
84dd:    91 00 10     mov AX, [0x0010]
84e0:    72 00 20     jump [0x0020] ;

M_Command:
84e3:    7b 55        call ReadHexWord
84e5:    55 86        mov r3, r4

L_84e7:
84e7:    8b           mov AL, single_byte[r3]
84e8:    7b 2f        call WriteHexByte

L_84ea:
84ea:    7b 4e        call ReadHexWord
84ec:    45 91        mov AL, r4_low
84ee:    c1 bf 92     mov BL, [0xbf92]
84f1:    14 01        b_z L_84f4
84f3:    ab           mov single_byte[r3], AL

L_84f4:
84f4:    13 04        b3 L_84fa
84f6:    30 60        inc? AX
84f8:    73 f0        jump L_84ea

L_84fa:
84fa:    11 a7        b1 TOS_PromptLoop
84fc:    30 60        inc? AX
84fe:    73 e7        jump L_84e7

ReadByteWithEcho:
8500:    7b 55        call CheckForReset ; Jumps back to the start of F1 if some condition is met
8502:    81 f2 00     mov AL, [0xf200]
8505:    2c           shift_right AL
8506:    11 f8        b1 ReadByteWithEcho
8508:    81 f2 01     mov AL, [0xf201]
850b:    c0 7f        mov BL, 0x7f
850d:    4a           and BL, AL

WriteByte:
850e:    81 f2 00     mov AL, [0xf200]
8511:    2c           shift_right AL
8512:    2c           shift_right AL
8513:    11 f9        b1 WriteByte
8515:    e1 f2 01     mov [0xf201], BL
8518:    09           ret

WriteHexByte:
8519:    7b 05        call WriteHexNibble
851b:    45 01        mov AL, AH
851d:    7b 01        call WriteHexNibble
851f:    09           ret

WriteHexNibble:
8520:    22 00        clear AH
8522:    36 00        rotate_right AX
8524:    36 00        rotate_right AX
8526:    36 00        rotate_right AX
8528:    36 00        rotate_right AX
852a:    26 00        rotate_right AH
852c:    c0 0a        mov BL, 0x0a
852e:    49           sub BL, AL
852f:    16 05        b_lt L_8536
8531:    c0 37        mov BL, 0x37

L_8533:
8533:    48           add BL, AL
8534:    73 d8        jump WriteByte

L_8536:
8536:    c0 30        mov BL, 0x30
8538:    73 f9        jump L_8533

ReadHexWord:
853a:    3a           clear AX
853b:    5e           mov r4, AX
853c:    a1 bf 92     mov [0xbf92], AL ; Diag SRAM

L_853f:
853f:    7b bf        call ReadByteWithEcho
8541:    7b 25        call AsciiToHexNibble
8543:    17 01        b7 L_8546
8545:    09           ret

L_8546:
8546:    35 80        shift_left AX
8548:    35 80        shift_left AX
854a:    35 80        shift_left AX
854c:    35 80        shift_left AX
854e:    43 19        or r4_low, AL
8550:    80 01        mov AL, 0x01
8552:    a1 bf 92     mov [0xbf92], AL
8555:    73 e8        jump L_853f

CheckForReset:
8557:    80 0f        mov AL, 0x0f
8559:    c1 f1 10     mov BL, [0xf110]
855c:    4a           and BL, AL
855d:    80 0a        mov AL, 0x0a
855f:    49           sub BL, AL
8560:    15 01        b_nz L_8563
8562:    09           ret

L_8563:
8563:    71 80 01     jump 0x8001 DiagEntryPoint

WriteByteTramp:
8566:    73 a6        jump WriteByte

AsciiToHexNibble:
8568:    45 31        mov AL, BL
856a:    c0 30        mov BL, 0x30
856c:    49           sub BL, AL
856d:    16 13        b_lt L_8582
856f:    c0 47        mov BL, 0x47
8571:    49           sub BL, AL
8572:    17 1e        b7 L_8592
8574:    c0 40        mov BL, 0x40
8576:    4a           and BL, AL
8577:    14 04        b_z L_857d
8579:    c0 09        mov BL, 0x09
857b:    40 31        add AL, BL

L_857d:
857d:    c0 0f        mov BL, 0x0f
857f:    42 31        and AL, BL
8581:    09           ret

L_8582:
8582:    c0 20        mov BL, 0x20
8584:    49           sub BL, AL
8585:    15 02        b_nz L_8589
8587:    2b           neg? AL
8588:    09           ret

L_8589:
8589:    c0 2c        mov BL, 0x2c
858b:    49           sub BL, AL
858c:    15 04        b_nz L_8592
858e:    02           flag2
858f:    07           clear_carry
8590:    2b           neg? AL
8591:    09           ret

L_8592:
8592:    c0 0a        mov BL, 0x0a ; '\n'
8594:    7b d0        call WriteByteTramp
8596:    c0 7f        mov BL, 0x7f ; This is the ascii DEL charater
8598:    7b cc        call WriteByteTramp
859a:    2a           clear AL
859b:    2b           neg? AL
859c:    09           ret