8000:    00           HALT

DiagEntryPoint:
8001:    3a           clear AX
8002:    b1 b8 00     mov [0xb800], AX ; This is the first word in Diag's 1KB of RAM
8005:    05           DI
8006:    0e           delay 4.5ms
8007:    a1 f1 4f     mov [0xf14f], AL
800a:    a1 f2 0d     mov [0xf20d], AL
800d:    a1 f2 0f     mov [0xf20f], AL
8010:    90 c0 00     mov AX, 0xc000
8013:    5f           mov SP, AX ; Set stack pointer just beyond top of Diag's 1KB of RAM
8014:    22 32        cpu_id
8016:    14 0b        b_z L_8023
8018:    90 80 77     mov AX, 0x8077
801b:    b1 00 fe     mov [0x00fe], AX ; This is writing a pointer directly into registers.
801e:    3a           clear AX
801f:    b1 00 fc     mov [0x00fc], AX ; Something really funky is going on here.
8022:    76           syscall ; I assume this is calling or jumpting to that function


L_8023:
8023:    3a           clear AX
8024:    a1 f1 09     mov [0xf109], AL ; Turn Decimal Point 1 off
8027:    a1 f1 0b     mov [0xf10b], AL ; Turn Decimal Point 2 off
802a:    a1 f1 0d     mov [0xf10d], AL ; Turn Decimal Point 3 off
802d:    a1 f1 0f     mov [0xf10f], AL ; Turn Decimal Point 4 off
8030:    81 f1 10     mov AL, [0xf110] ; A = Dip swiches value
8033:    c0 0f        mov BL, 0x0f
8035:    42 31        and AL, BL ; A = A & 0x0f
8037:    a1 f1 10     mov [0xf110], AL ; Write A to hex displays
803a:    a1 f1 06     mov [0xf106], AL ; Unblank the hex displys
803d:    c0 0d        mov BL, 0x0d
803f:    49           sub BL, AL ; Compare with 0b1011
8040:    15 03        b_nz L_8045
8042:    71 87 28     jump 0x8728 AuxiliaryTestMenu ; If dipswitches == 0xb111: 
                                                    ;     Display Auxiliary Test Menu

													
8069:    84 6f        (0x846f) ; TOS_Entry: TestOS: This is a Monitor that operates over serial console



TOS_Entry:
    ; TestOS: This is a Monitor that operates over serial console
846f:    b5 a2        mov [--SP], AX
8471:    a1 f1 0a     mov [0xf10a], AL
8474:    b1 00 10     mov [0x0010], AX
8477:    90 00 12     mov AX, 0x0012
847a:    f5 01        mov [--AX], BX
847c:    6d 01        mov [--AX], r2
847e:    55 62        mov BX, r3
8480:    f5 01        mov [--AX], BX
8482:    55 82        mov BX, r4
8484:    f5 01        mov [--AX], BX
8486:    55 a2        mov BX, SP
8488:    30 20        inc? AX
848a:    30 20        inc? AX
848c:    f5 01        mov [--AX], BX
848e:    55 c2        mov BX, r6
8490:    f5 01        mov [--AX], BX
8492:    55 e2        mov BX, r7
8494:    f5 01        mov [--AX], BX
8496:    80 c5        mov AL, 0xc5
8498:    a1 f2 00     mov [0xf200], AL ; Configure UART
849b:    85 a1        mov AL, [SP++]
849d:    7b 7a        call WriteHexByte
849f:    85 a1        mov AL, [SP++]
84a1:    7b 76        call WriteHexByte

TOS_PromptLoop:
84a3:    c0 5c        mov BL, 0x5c ; ''
84a5:    7b 67        call WriteByte
84a7:    7b 57        call ReadByteWithEcho
84a9:    45 31        mov AL, BL
84ab:    c0 4d        mov BL, 0x4d ; 'M'
84ad:    49           sub BL, AL
84ae:    14 33        b_z M_Command
84b0:    c0 47        mov BL, 0x47 ; 'G'
84b2:    49           sub BL, AL
84b3:    14 0a        b_z G_Command
84b5:    c0 51        mov BL, 0x51 ; 'Q'
84b7:    49           sub BL, AL
84b8:    15 e9        b_nz TOS_PromptLoop
84ba:    90 80 01     mov AX, 0x8001 ; Start of ROM
84bd:    73 04        jump Q_Command

G_Command:
    ; Go: Takes a 
84bf:    7b 79        call ReadHexWord
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