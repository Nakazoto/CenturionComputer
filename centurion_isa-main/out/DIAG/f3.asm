
TEST_0:
9000:    03 6d        (0x36d)
9002:    "CMD AUX MEMORY TEST\r\n\0"

TEST_1:
9018:    04 6d        (0x46d)
901a:    "CMD SEEK TEST\r\n\0"

TEST_2:
902a:    05 31        (0x531)
902c:    "CMD READ TEST\r\n\0"

TEST_3:
903c:    02 ce        (0x2ce)
903e:    "FLOPPY COMMAND BUFFER TEST\r\n\0"

TEST_4:
905b:    05 e8        (0x5e8)
905d:    "FLOPPY SEEK TEST\r\n\0"

TEST_5:
9070:    06 9b        (0x69b)
9072:    "FLOPPY READ TEST\r\n\0"

TEST_6:
9085:    07 47        (0x747)
9087:    "ROM SELF TEST\r\n\n\0"

TEST_7:
9098:    00 00        (0x0)

WriteString:
909a:    85 41        mov AL, [r2++]
909c:    15 01        b_nz L_909f
909e:    09           ret

L_909f:
909f:    7b 02        call WriteByte
90a1:    73 f7        jump WriteString

WriteByte:
90a3:    c1 f2 00     mov BL, [0xf200]
90a6:    24 30        shift_right AH, BL
90a8:    24 30        shift_right AH, BL
90aa:    11 f7        b1 WriteByte
90ac:    a1 f2 01     mov [0xf201], AL
90af:    09           ret

ReadChar:
90b0:    81 f2 00     mov AL, [0xf200]
90b3:    2c           shift_right AL, AL
90b4:    11 fa        b1 ReadChar
90b6:    81 f2 01     mov AL, [0xf201]
90b9:    09           ret

WriteHexWord:
90ba:    a5 a2        mov [--SP], BH
90bc:    45 01        mov AL, AH
90be:    7b 05        call WriteHexByte
90c0:    85 a1        mov AL, [SP++]
90c2:    7b 01        call WriteHexByte
90c4:    09           ret

WriteHexByte:
90c5:    a5 a2        mov [--SP], BH
90c7:    c0 f0        mov BL, 0xf0
90c9:    42 31        and AL, BL
90cb:    07           clear_carry
90cc:    26 10        rotate_right AH, AL
90ce:    2c           shift_right AL, AL
90cf:    2c           shift_right AL, AL
90d0:    2c           shift_right AL, AL
90d1:    c0 b0        mov BL, 0xb0
90d3:    40 31        add AL, BL
90d5:    c0 b9        mov BL, 0xb9
90d7:    49           sub BL, AL
90d8:    19 04        b_le L_90de
90da:    c0 07        mov BL, 0x07
90dc:    40 31        add AL, BL

L_90de:
90de:    7b c3        call WriteByte
90e0:    85 a1        mov AL, [SP++]
90e2:    c0 0f        mov BL, 0x0f
90e4:    42 31        and AL, BL
90e6:    c0 b0        mov BL, 0xb0
90e8:    40 31        add AL, BL
90ea:    c0 b9        mov BL, 0xb9
90ec:    49           sub BL, AL
90ed:    19 04        b_le L_90f3
90ef:    c0 07        mov BL, 0x07
90f1:    40 31        add AL, BL

L_90f3:
90f3:    7b ae        call WriteByte
90f5:    09           ret

FinishTest:
90f6:    a1 f1 0a     mov [0xf10a], AL
90f9:    81 f2 00     mov AL, [0xf200]
90fc:    2c           shift_right AL, AL
90fd:    11 57        b1 L_9156
90ff:    81 f2 01     mov AL, [0xf201]
9102:    c0 80        mov BL, 0x80
9104:    43 31        or AL, BL
9106:    c0 83        mov BL, 0x83
9108:    49           sub BL, AL
9109:    15 4b        b_nz L_9156
910b:    81 01 08     mov AL, [0x0108]
910e:    14 32        b_z L_9142
9110:    7a 01 12     call [0x0112]
9113:    "\r\n*** FAIL ***\0"
9122:    a1 f1 0b     mov [0xf10b], AL
9125:    a1 f1 0c     mov [0xf10c], AL

PressSpaceThenExit:
9128:    7a 01 12     call [0x0112]
912b:    "\r\nPRESS SPACE\x07\r\n\0"
913c:    7a 01 02     call [0x0102]
913f:    72 01 00     jump [0x0100] ;

L_9142:
9142:    7a 01 12     call [0x0112]
9145:    "\r\n*** PASS ***\0"
9154:    73 d2        jump PressSpaceThenExit

L_9156:
9156:    90 c0 00     mov AX, 0xc000
9159:    5f           mov SP, AX
915a:    91 01 1a     mov AX, [0x011a]
915d:    5e           mov r4, AX
915e:    95 41        mov AX, [r2++]
9160:    50 80        add AX, r4
9162:    75 00        jump A + 0x00

PrintCtrlCToExit:
9164:    7a 01 12     call [0x0112]
9167:    "\r\n(CONTROL-C TO EXIT)\r\n\0"
917f:    09           ret

Init:
9180:    3a           clear AX, AX
9181:    b1 01 08     mov [0x0108], AX
9184:    90 01 e3     mov AX, 0x01e3
9187:    50 80        add AX, r4
9189:    b1 01 18     mov [0x0118], AX
918c:    90 00 c5     mov AX, 0x00c5
918f:    50 80        add AX, r4
9191:    b1 01 0a     mov [0x010a], AX
9194:    90 02 86     mov AX, 0x0286
9197:    50 80        add AX, r4
9199:    b1 01 0c     mov [0x010c], AX
919c:    90 01 64     mov AX, 0x0164
919f:    50 80        add AX, r4
91a1:    b1 01 06     mov [0x0106], AX
91a4:    90 00 b0     mov AX, 0x00b0
91a7:    50 80        add AX, r4
91a9:    b1 01 02     mov [0x0102], AX
91ac:    90 00 9a     mov AX, 0x009a

L_91af:
91af:    50 80        add AX, r4
91b1:    b1 01 12     mov [0x0112], AX
91b4:    90 00 ba     mov AX, 0x00ba
91b7:    50 80        add AX, r4
91b9:    b1 01 10     mov [0x0110], AX
91bc:    90 00 f6     mov AX, 0x00f6
91bf:    50 80        add AX, r4
91c1:    b1 01 04     mov [0x0104], AX
91c4:    90 01 28     mov AX, 0x0128
91c7:    50 80        add AX, r4
91c9:    b1 01 0e     mov [0x010e], AX
91cc:    55 80        mov AX, r4
91ce:    b1 01 1a     mov [0x011a], AX
91d1:    95 41        mov AX, [r2++]
91d3:    b1 01 14     mov [0x0114], AX
91d6:    38           inc? AX, AX
91d7:    b1 01 16     mov [0x0116], AX
91da:    55 40        mov AX, r2
91dc:    65 a1        unknown
91de:    69 01 00     69 A, 0x0100
91e1:    75 00        jump A + 0x00

Fn_1e3:
91e3:    7a 01 0c     call [0x010c]
91e6:    6d a2        unknown
91e8:    60 03 e8     60 0x03e8

L_91eb:
91eb:    82 01        unknown
91ed:    16 c0        b_lt L_91af
91ef:    08           flag8
91f0:    4a           and BL, AL
91f1:    14 2b        b_z L_921e
91f3:    0e           delay 4.5ms
91f4:    3f           rotate_left AX, AX
91f5:    15 f4        b_nz L_91eb
91f7:    7a 01 12     call [0x0112]
91fa:    "*** BUSY DID NOT CLEAR ***\0"
9215:    a1 f1 0b     mov [0xf10b], AL
9218:    a1 f1 0c     mov [0xf10c], AL
921b:    72 01 0e     jump [0x010e] ;

L_921e:
921e:    60 03 e8     60 0x03e8

L_9221:
9221:    2c           shift_right AL, AL
9222:    10 2b        b0 L_924f
9224:    0e           delay 4.5ms
9225:    3f           rotate_left AX, AX
9226:    15 f9        b_nz L_9221
9228:    7a 01 12     call [0x0112]
922b:    "*** FOUT NEVER CAME ON ***\0"
9246:    a1 f1 0b     mov [0xf10b], AL
9249:    a1 f1 0c     mov [0xf10c], AL
924c:    72 01 0e     jump [0x010e] ;

L_924f:
924f:    03           flag3
9250:    82 01        unknown
9252:    14 15        b_z L_9269
9254:    03           flag3
9255:    65 a1        unknown
9257:    09           ret
9258:    a5
9259:    a2
925a:    7a
925b:    01
925c:    12
925d:    "*** \0"
9262:    85 a1        mov AL, [SP++]
9264:    7a 01 0a     call [0x010a]
9267:    7a
9268:    01

L_9269:
9269:    12
926a:    " ERROR ***\r\n\0"
9277:    80 01        mov AL, 0x01
9279:    a1 01 08     mov [0x0108], AL
927c:    a1 f1 0b     mov [0xf10b], AL
927f:    a1 f1 0c     mov [0xf10c], AL
9282:    65 a1        unknown
9284:    02           flag2
9285:    09           ret

Fn_286:
9286:    6d a2        unknown
9288:    0e           delay 4.5ms
9289:    60 03 e8     60 0x03e8

L_928c:
928c:    82 01        unknown
928e:    16 2c        b_lt L_92bc
9290:    2c           shift_right AL, AL
9291:    11 2d        b1 L_92c0
9293:    0e           delay 4.5ms
9294:    3f           rotate_left AX, AX
9295:    15 f5        b_nz L_928c
9297:    7a 01 12     call [0x0112]
929a:    "*** FIN DID NOT GO OFF ***\r\n\0"
92b7:    a1 f1 0b     mov [0xf10b], AL
92ba:    a1
92bb:    f1

L_92bc:
92bc:    0c           unknown
92bd:    72 01 0e     jump [0x010e] ;

L_92c0:
92c0:    65 a1        unknown
92c2:    09           ret
92c3:    90
92c4:    01
92c5:    80
92c6:    50
92c7:    80
92c8:    7d
92c9:    00
92ca:    f8
92cb:    08
92cc:    73
92cd:    09

Entry_FLOPPY_COMMAND_BUFFER_TEST:
92ce:    90 01 80     mov AX, 0x0180
92d1:    50 80        add AX, r4
92d3:    7d 00        call A + 0x00
92d5:    f8           mov [None], BX
92d6:    00           HALT
92d7:    7a 01 06     call [0x0106]
92da:    32 60        clear AX, r3
92dc:    60 00 c8     60 0x00c8
92df:    55 60        mov AX, r3
92e1:    d0 01 1c     mov BX, 0x011c

L_92e4:
92e4:    a5 21        mov [--BX], AL
92e6:    28           inc? AL, AL
92e7:    28           inc? AL, AL
92e8:    28           inc? AL, AL
92e9:    3f           rotate_left AX, AX
92ea:    15 f8        b_nz L_92e4
92ec:    90 ff 37     mov AX, 0xff37
92ef:    2f 02        DMA load 0, 2
92f1:    90 01 1c     mov AX, 0x011c
92f4:    2f 00        DMA load 0, 0
92f6:    2f 34        DMA load 3, 4
92f8:    2f 06        DMA load 0, 6
92fa:    80 43        mov AL, 0x43
92fc:    a2 01        unknown
92fe:    14 7a        b_z L_937a
9300:    01           nop
9301:    18 60        b_gt L_9363
9303:    00           HALT
9304:    e6 3a        unknown
9306:    d0 01 1c     mov BX, 0x011c

L_9309:
9309:    a5 21        mov [--BX], AL
930b:    3f           rotate_left AX, AX
930c:    15 fb        b_nz L_9309
930e:    90 ff 37     mov AX, 0xff37
9311:    2f 02        DMA load 0, 2
9313:    90 01 1c     mov AX, 0x011c
9316:    2f 00        DMA load 0, 0
9318:    2f 34        DMA load 3, 4
931a:    2f 06        DMA load 0, 6
931c:    80 44        mov AL, 0x44
931e:    a2 01        unknown
9320:    14 7a        b_z L_939c
9322:    01           nop
9323:    18 60        b_gt L_9385
9325:    00           HALT
9326:    c8           mov BL, [None]
9327:    d0 01 1c     mov BX, 0x011c
932a:    55 60        mov AX, r3
932c:    45 10        mov AH, AL

L_932e:
932e:    85 21        mov AL, [BX++]
9330:    41 01        sub AL, AH
9332:    15 10        b_nz L_9344
9334:    20 00        inc? AH, AH
9336:    20 00        inc? AH, AH
9338:    20 00        inc? AH, AH
933a:    3f           rotate_left AX, AX
933b:    15 f1        b_nz L_932e
933d:    20 70        inc? AH, r3_low
933f:    7a 01 04     call [0x0104]
9342:    02           flag2
9343:    da           mov BX, [None]

L_9344:
9344:    7a 01 12     call [0x0112]
9347:    "*** COMMAND BUFFER ERROR ***\0"
9364:    a1 f1 0b     mov [0xf10b], AL
9367:    a1 f1 0c     mov [0xf10c], AL
936a:    72 01 0e     jump [0x010e] ;

Entry_CMD_AUX_MEMORY_TEST:
936d:    90 01 80     mov AX, 0x0180
9370:    50 80        add AX, r4
9372:    7d 00        call A + 0x00
9374:    f8           mov [None], BX
9375:    08           flag8
9376:    7a 01 06     call [0x0106]
9379:    32

L_937a:
937a:    60 60 3f     60 0x603f
937d:    ff           mov [None], BX
937e:    55 60        mov AX, r3
9380:    d0 01 1c     mov BX, 0x011c

L_9383:
9383:    a5 21        mov [--BX], AL

L_9385:
9385:    28           inc? AL, AL
9386:    28           inc? AL, AL
9387:    28           inc? AL, AL
9388:    3f           rotate_left AX, AX
9389:    15 f8        b_nz L_9383
938b:    90 c0 00     mov AX, 0xc000
938e:    2f 02        DMA load 0, 2
9390:    90 01 1c     mov AX, 0x011c
9393:    2f 00        DMA load 0, 0
9395:    2f 34        DMA load 3, 4
9397:    2f 06        DMA load 0, 6
9399:    80 46        mov AL, 0x46
939b:    a2 01        unknown
939d:    14 7a        b_z L_9419
939f:    01           nop
93a0:    0c           unknown
93a1:    2a           clear AL, AL
93a2:    a2 01        unknown
93a4:    14 7a        b_z L_9420
93a6:    01           nop
93a7:    0c           unknown
93a8:    2a           clear AL, AL
93a9:    a2 01        unknown
93ab:    14 7a        b_z L_9427
93ad:    01           nop
93ae:    0c           unknown
93af:    80 3f        mov AL, 0x3f
93b1:    a2 01        unknown
93b3:    14 7a        b_z L_942f

L_93b5:
93b5:    01           nop
93b6:    0c           unknown
93b7:    80 ff        mov AL, 0xff
93b9:    a2 01        unknown
93bb:    14 7a        b_z L_9437
93bd:    01           nop
93be:    18 60        b_gt L_9420
93c0:    3f           rotate_left AX, AX
93c1:    ff           mov [None], BX
93c2:    3a           clear AX, AX
93c3:    d0 01 1c     mov BX, 0x011c

L_93c6:
93c6:    a5 21        mov [--BX], AL
93c8:    3f           rotate_left AX, AX
93c9:    15 fb        b_nz L_93c6
93cb:    90 c0 00     mov AX, 0xc000
93ce:    2f 02        DMA load 0, 2
93d0:    90 01 1c     mov AX, 0x011c
93d3:    2f 00        DMA load 0, 0
93d5:    2f 34        DMA load 3, 4
93d7:    2f 06        DMA load 0, 6
93d9:    80 47        mov AL, 0x47
93db:    a2 01        unknown
93dd:    14 7a        b_z L_9459
93df:    01           nop
93e0:    0c           unknown
93e1:    2a           clear AL, AL
93e2:    a2 01        unknown
93e4:    14 7a        b_z L_9460
93e6:    01           nop
93e7:    0c           unknown
93e8:    2a           clear AL, AL
93e9:    a2 01        unknown
93eb:    14 7a        b_z L_9467
93ed:    01           nop
93ee:    0c           unknown
93ef:    80 3f        mov AL, 0x3f
93f1:    a2 01        unknown
93f3:    14 7a        b_z L_946f
93f5:    01           nop
93f6:    0c           unknown
93f7:    80 ff        mov AL, 0xff
93f9:    a2 01        unknown
93fb:    14 7a        b_z L_9477
93fd:    01           nop
93fe:    18 b5        b_gt L_93b5
9400:    a2 60        unknown
9402:    3f           rotate_left AX, AX
9403:    ff           mov [None], BX
9404:    d0 01 1c     mov BX, 0x011c
9407:    55 60        mov AX, r3
9409:    45 10        mov AH, AL

L_940b:
940b:    85 21        mov AL, [BX++]
940d:    bd           mov [None], AX
940e:    41 01        sub AL, AH
9410:    15 12        b_nz L_9424
9412:    20 00        inc? AH, AH
9414:    20 00        inc? AH, AH
9416:    20 00        inc? AH, AH
9418:    3f           rotate_left AX, AX

L_9419:
9419:    15 f0        b_nz L_940b
941b:    95 a1        mov AX, [SP++]
941d:    20 70        inc? AH, r3_low
941f:    7a 01 04     call [0x0104]
9422:    03           flag3
9423:    79

L_9424:
9424:    a1 f1 0b     mov [0xf10b], AL

L_9427:
9427:    a1 f1 0c     mov [0xf10c], AL
942a:    f5 a2        mov [--SP], BX
942c:    7a 01 12     call [0x0112]

L_942f:
942f:    "*** ERROR, ADDR=\0"
9440:    95 a1        mov AX, [SP++]
9442:    39           dec? AX, AX
9443:    7a 01 10     call [0x0110]
9446:    7a 01 12     call [0x0112]
9449:    " EXP=\0"
944f:    85 a1        mov AL, [SP++]
9451:    7a 01 0a     call [0x010a]
9454:    7a 01 12     call [0x0112]
9457:    " ACT=\0"
945d:    85 a1        mov AL, [SP++]
945f:    7a 01 0a     call [0x010a]
9462:    7a 01 12     call [0x0112]
9465:    " ***\0"
946a:    72 01 0e     jump [0x010e] ;

Entry_CMD_SEEK_TEST:
946d:    90
946e:    01

L_946f:
946f:    80 50        mov AL, 0x50
9471:    80 7d        mov AL, 0x7d
9473:    00           HALT
9474:    f8           mov [None], BX
9475:    08           flag8
9476:    7a 01 06     call [0x0106]
9479:    d0 41 4d     mov BX, 0x414d
947c:    90 81 00     mov AX, 0x8100
947f:    b5 21        mov [--BX], AX
9481:    90 82 ff     mov AX, 0x82ff
9484:    b9           mov [None], AX
9485:    90 ff fb     mov AX, 0xfffb
9488:    2f 02        DMA load 0, 2
948a:    90 41 4d     mov AX, 0x414d
948d:    2f 00        DMA load 0, 0
948f:    2f 34        DMA load 3, 4
9491:    2f 06        DMA load 0, 6
9493:    80 43        mov AL, 0x43
9495:    a2 01        unknown
9497:    14 7a        b_z L_9513
9499:    01           nop
949a:    18 13        b_gt L_94af
949c:    09           ret
949d:    a1
949e:    f1
949f:    0b
94a0:    a1
94a1:    f1
94a2:    0c
94a3:    72
94a4:    01
94a5:    0e
94a6:    80
94a7:    45
94a8:    a2
94a9:    01
94aa:    14
94ab:    7a
94ac:    01
94ad:    18
94ae:    12

L_94af:
94af:    ed           mov [None], BL
94b0:    d0 41 4f     mov BX, 0x414f
94b3:    90 84 00     mov AX, 0x8400
94b6:    b5 21        mov [--BX], AX
94b8:    80 83        mov AL, 0x83
94ba:    a5 21        mov [--BX], AL
94bc:    3a           clear AX, AX
94bd:    b5 21        mov [--BX], AX
94bf:    39           dec? AX, AX

L_94c0:
94c0:    a9           mov [None], AL
94c1:    38           inc? AX, AX
94c2:    38           inc? AX, AX
94c3:    b1 41 b1     mov [0x41b1], AX

L_94c6:
94c6:    90 41 4d     mov AX, 0x414d
94c9:    2f 00        DMA load 0, 0
94cb:    90 ff f7     mov AX, 0xfff7
94ce:    2f 02        DMA load 0, 2
94d0:    2f 34        DMA load 3, 4
94d2:    2f 06        DMA load 0, 6
94d4:    80 43        mov AL, 0x43
94d6:    a2 01        unknown
94d8:    14 7a        b_z L_9554
94da:    01           nop
94db:    18 12        b_gt L_94ef
94dd:    bf           mov [None], AX
94de:    80 45        mov AL, 0x45
94e0:    a2 01        unknown
94e2:    14 7a        b_z L_955e
94e4:    01           nop
94e5:    18 13        b_gt L_94fa
94e7:    1c 7a        b_sense2 L_9563
94e9:    01           nop
94ea:    12
94eb:    "TRACK=\0"
94f2:    91 41 52     mov AX, [0x4152]
94f5:    7a 01 10     call [0x0110]
94f8:    7a 01 12     call [0x0112]
94fb:    "\r\n\0"
94fe:    a1 f1 0b     mov [0xf10b], AL
9501:    a1 f1 0c     mov [0xf10c], AL
9504:    91 41 b1     mov AX, [0x41b1]
9507:    16 1a        b_lt L_9523
9509:    d1 41 52     mov BX, [0x4152]
950c:    50 20        add AX, BX
950e:    b1 41 52     mov [0x4152], AX
9511:    d0
9512:    03

L_9513:
9513:    36 59        rotate_right r4, r2
9515:    15 af        b_nz L_94c6
9517:    3a           clear AX, AX
9518:    39           dec? AX, AX
9519:    b1 41 b1     mov [0x41b1], AX
951c:    80 10        mov AL, 0x10
951e:    a1 41 50     mov [0x4150], AL
9521:    73 a3        jump L_94c6

L_9523:
9523:    91 41 52     mov AX, [0x4152]
9526:    39           dec? AX, AX
9527:    b1 41 52     mov [0x4152], AX
952a:    17 9a        b7 L_94c6
952c:    7a 01 04     call [0x0104]
952f:    04           flag4
9530:    79

Entry_CMD_READ_TEST:
9531:    90 01 80     mov AX, 0x0180
9534:    50 80        add AX, r4
9536:    7d 00        call A + 0x00
9538:    f8           mov [None], BX
9539:    08           flag8
953a:    7a 01 06     call [0x0106]
953d:    80 41        mov AL, 0x41
953f:    a2 01        unknown
9541:    14 7a        b_z L_95bd
9543:    01           nop
9544:    0c           unknown
9545:    2a           clear AL, AL
9546:    a2 01        unknown
9548:    14 7a        b_z L_95c4
954a:    01           nop
954b:    0c           unknown
954c:    2a           clear AL, AL
954d:    a2 01        unknown
954f:    14 7a        b_z L_95cb
9551:    01           nop
9552:    18 12        b_gt L_9566

L_9554:
9554:    44 90        xor AH, SP_low
9556:    41 4d        sub r6_low, r2_high
9558:    5c           xor BX, AX
9559:    90 81 00     mov AX, 0x8100
955c:    b5 61        mov [--r3], AX

L_955e:
955e:    90 84 00     mov AX, 0x8400
9561:    b5 61        mov [--r3], AX

L_9563:
9563:    80 83        mov AL, 0x83
9565:    a5 61        mov [--r3], AL
9567:    3a           clear AX, AX
9568:    b5 61        mov [--r3], AX
956a:    80 85        mov AL, 0x85
956c:    a5 61        mov [--r3], AL
956e:    d0 10 00     mov BX, 0x1000

L_9571:
9571:    e5 61        mov [--r3], AL
9573:    90 01 90     mov AX, 0x0190
9576:    b5 61        mov [--r3], AX
9578:    20 30        inc? AH, BL
957a:    21 20        dec? AH, BH
957c:    15 f3        b_nz L_9571
957e:    80 ff        mov AL, 0xff
9580:    ab           mov [None], AL

L_9581:
9581:    90 ff c3     mov AX, 0xffc3
9584:    2f 02        DMA load 0, 2
9586:    90 41 4d     mov AX, 0x414d
9589:    2f 00        DMA load 0, 0
958b:    2f 34        DMA load 3, 4
958d:    2f 06        DMA load 0, 6
958f:    80 43        mov AL, 0x43
9591:    a2 01        unknown
9593:    14 7a        b_z L_960f
9595:    01           nop
9596:    18 13        b_gt L_95ab
9598:    09           ret
9599:    a1
959a:    f1
959b:    0b
959c:    a1
959d:    f1
959e:    0c
959f:    72
95a0:    01
95a1:    0e
95a2:    90
95a3:    e6
95a4:    ff
95a5:    2f
95a6:    02
95a7:    90
95a8:    01
95a9:    1c
95aa:    2f

L_95ab:
95ab:    00           HALT
95ac:    2f 34        DMA load 3, 4
95ae:    2f 06        DMA load 0, 6
95b0:    80 45        mov AL, 0x45
95b2:    a2 01        unknown
95b4:    14 7a        b_z L_9630
95b6:    01           nop
95b7:    18 13        b_gt L_95cc
95b9:    16 7a        b_lt L_9635
95bb:    01           nop
95bc:    12

L_95bd:
95bd:    "TRACK=\0"

L_95c4:
95c4:    91 41 52     mov AX, [0x4152]
95c7:    7a 01 10     call [0x0110]
95ca:    7a

L_95cb:
95cb:    01           nop

L_95cc:
95cc:    12
95cd:    "\r\n\0"
95d0:    91 41 52     mov AX, [0x4152]
95d3:    15 01        b_nz L_95d6
95d5:    38           inc? AX, AX

L_95d6:
95d6:    3d           shift_left AX, AX
95d7:    b1 41 52     mov [0x4152], AX
95da:    d0 03 36     mov BX, 0x0336
95dd:    59           sub BX, AX
95de:    19 a1        b_le L_9581
95e0:    a1 f1 0a     mov [0xf10a], AL
95e3:    7a 01 04     call [0x0104]
95e6:    05           flag5
95e7:    3d           shift_left AX, AX

Entry_FLOPPY_SEEK_TEST:
95e8:    90 01 80     mov AX, 0x0180
95eb:    50 80        add AX, r4
95ed:    7d 00        call A + 0x00
95ef:    f8           mov [None], BX
95f0:    00           HALT
95f1:    7a 01 06     call [0x0106]
95f4:    d0 41 4d     mov BX, 0x414d
95f7:    90
95f8:    81

L_95f9:
95f9:    01           nop
95fa:    b5 21        mov [--BX], AX
95fc:    80 82        mov AL, 0x82
95fe:    a9           mov [None], AL
95ff:    90 ff fc     mov AX, 0xfffc
9602:    2f 02        DMA load 0, 2
9604:    90 41 4d     mov AX, 0x414d
9607:    2f 00        DMA load 0, 0
9609:    2f 34        DMA load 3, 4
960b:    2f 06        DMA load 0, 6
960d:    80 43        mov AL, 0x43

L_960f:
960f:    a2 01        unknown
9611:    14 7a        b_z L_968d
9613:    01           nop
9614:    18 13        b_gt L_9629
9616:    09           ret
9617:    a1
9618:    f1
9619:    0b
961a:    a1
961b:    f1
961c:    0c
961d:    72
961e:    01
961f:    0e
9620:    80
9621:    45
9622:    a2
9623:    01
9624:    14
9625:    7a
9626:    01
9627:    18
9628:    12

L_9629:
9629:    ed           mov [None], BL
962a:    d0 41 4f     mov BX, 0x414f
962d:    90 83 01     mov AX, 0x8301

L_9630:
9630:    b9           mov [None], AX
9631:    80 01        mov AL, 0x01
9633:    a1 41 b1     mov [0x41b1], AL

L_9636:
9636:    90 41 4d     mov AX, 0x414d
9639:    2f 00        DMA load 0, 0
963b:    90 ff fb     mov AX, 0xfffb
963e:    2f 02        DMA load 0, 2
9640:    2f 34        DMA load 3, 4
9642:    2f 06        DMA load 0, 6
9644:    80 43        mov AL, 0x43
9646:    a2 01        unknown
9648:    14 7a        b_z L_96c4
964a:    01           nop
964b:    18 12        b_gt L_965f
964d:    c9           mov BL, [None]
964e:    80 45        mov AL, 0x45
9650:    a2 01        unknown
9652:    14 7a        b_z L_96ce
9654:    01           nop
9655:    18 13        b_gt L_966a
9657:    1c 7a        b_sense2 L_96d3
9659:    01           nop
965a:    12
965b:    "TRACK=\0"
9662:    81 41 50     mov AL, [0x4150]
9665:    7a 01 0a     call [0x010a]
9668:    7a 01 12     call [0x0112]
966b:    "\r\n\0"
966e:    a1 f1 0b     mov [0xf10b], AL
9671:    a1 f1 0c     mov [0xf10c], AL
9674:    81 41 b1     mov AL, [0x41b1]
9677:    16 14        b_lt L_968d
9679:    c1 41 50     mov BL, [0x4150]
967c:    40 31        add AL, BL
967e:    a1 41 50     mov [0x4150], AL
9681:    c0 4b        mov BL, 0x4b
9683:    49           sub BL, AL
9684:    15 b0        b_nz L_9636
9686:    80 ff        mov AL, 0xff
9688:    a1 41 b1     mov [0x41b1], AL
968b:    73 a9        jump L_9636

L_968d:
968d:    81 41 50     mov AL, [0x4150]
9690:    29           dec? AL, AL
9691:    a1 41 50     mov [0x4150], AL
9694:    17 a0        b7 L_9636
9696:    7a 01 04     call [0x0104]
9699:    05           flag5
969a:    f4 90        mov [PC-0x70], BX
969c:    01           nop
969d:    80 50        mov AL, 0x50
969f:    80 7d        mov AL, 0x7d
96a1:    00           HALT
96a2:    f8           mov [None], BX
96a3:    00           HALT
96a4:    7a 01 06     call [0x0106]
96a7:    80 41        mov AL, 0x41
96a9:    a2 01        unknown
96ab:    14 7a        b_z L_9727
96ad:    01           nop
96ae:    0c           unknown
96af:    2a           clear AL, AL
96b0:    a2 01        unknown
96b2:    14 7a        b_z L_972e
96b4:    01           nop
96b5:    0c           unknown
96b6:    2a           clear AL, AL
96b7:    a2 01        unknown
96b9:    14 7a        b_z L_9735
96bb:    01           nop
96bc:    18 12        b_gt L_96d0

L_96be:
96be:    3d           shift_left AX, AX
96bf:    90 41 4d     mov AX, 0x414d
96c2:    5c           xor BX, AX
96c3:    90

L_96c4:
96c4:    81 01 b5     mov AL, [0x01b5]
96c7:    61 90 83     61 0x9083
96ca:    01           nop
96cb:    b5 61        mov [--r3], AX
96cd:    d0 10 00     mov BX, 0x1000

L_96d0:
96d0:    80 88        mov AL, 0x88
96d2:    a5 61        mov [--r3], AL
96d4:    e5 61        mov [--r3], AL
96d6:    2a           clear AL, AL
96d7:    a5 61        mov [--r3], AL
96d9:    90 01 90     mov AX, 0x0190
96dc:    b5 61        mov [--r3], AX
96de:    20 30        inc? AH, BL
96e0:    21 20        dec? AH, BH
96e2:    15 ec        b_nz L_96d0

L_96e4:
96e4:    90 ff ab     mov AX, 0xffab
96e7:    2f 02        DMA load 0, 2
96e9:    90 41 4d     mov AX, 0x414d
96ec:    2f 00        DMA load 0, 0
96ee:    2f 34        DMA load 3, 4
96f0:    2f 06        DMA load 0, 6
96f2:    80 43        mov AL, 0x43
96f4:    a2 01        unknown
96f6:    14 7a        b_z L_9772
96f8:    01           nop
96f9:    18 13        b_gt L_970e
96fb:    09           ret
96fc:    a1
96fd:    f1
96fe:    0b
96ff:    a1
9700:    f1
9701:    0c
9702:    72
9703:    01
9704:    0e
9705:    90
9706:    e6
9707:    ff
9708:    2f
9709:    02
970a:    90
970b:    01
970c:    1c
970d:    2f

L_970e:
970e:    00           HALT
970f:    2f 34        DMA load 3, 4
9711:    2f 06        DMA load 0, 6
9713:    80 45        mov AL, 0x45
9715:    a2 01        unknown
9717:    14 7a        b_z L_9793
9719:    01           nop
971a:    18 13        b_gt L_972f
971c:    16 7a        b_lt L_9798
971e:    01           nop
971f:    12
9720:    "TRACK=\0"

L_9727:
9727:    81 41 50     mov AL, [0x4150]
972a:    7a 01 0a     call [0x010a]
972d:    7a

L_972e:
972e:    01           nop

L_972f:
972f:    12
9730:    "\r\n\0"
9733:    81
9734:    41

L_9735:
9735:    50 2d        add r6, BX
9737:    a1 41 50     mov [0x4150], AL
973a:    c0 4b        mov BL, 0x4b
973c:    49           sub BL, AL
973d:    19 a5        b_le L_96e4
973f:    a1 f1 0a     mov [0xf10a], AL
9742:    7a 01 04     call [0x0104]
9745:    06           set_carry
9746:    a7 90        unknown
9748:    01           nop
9749:    80 50        mov AL, 0x50
974b:    80 7d        mov AL, 0x7d
974d:    00           HALT
974e:    00           HALT
974f:    00           HALT
9750:    55 86        mov r3, r4
9752:    3a           clear AX, AX

L_9753:
9753:    85 61        mov AL, [r3++]
9755:    40 10        add AH, AL
9757:    d0 07 96     mov BX, 0x0796
975a:    50 82        add BX, r4
975c:    51 62        sub BX, r3
975e:    15 f3        b_nz L_9753
9760:    8b           mov AL, [None]
9761:    41 01        sub AL, AH
9763:    15 18        b_nz L_977d
9765:    7a 01 12     call [0x0112]
9768:    "\n\r*** PASS ***\0"
9777:    a1 f1 0a     mov [0xf10a], AL
977a:    72 01 0e     jump [0x010e] ;

L_977d:
977d:    7a 01 12     call [0x0112]
9780:    "*** FAIL ***\0"
978d:    a1 f1 0b     mov [0xf10b], AL
9790:    a1 f1 0c     mov [0xf10c], AL

L_9793:
9793:    72 01 0e     jump [0x010e] ;
9796:    8c
9797:    00

L_9798:
9798:    00           HALT
9799:    00           HALT
979a:    00           HALT
979b:    00           HALT
979c:    00           HALT
979d:    00           HALT
979e:    00           HALT
979f:    00           HALT
