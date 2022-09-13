
ReadChar:
0102:    <null bytes>


FinishTest:
0104:    <null bytes>


PrintCtrlCToExit:
0106:    <null bytes>


WriteHexByte:
010a:    <null bytes>


Fn_286:
010c:    <null bytes>


PressSpaceThenExit:
010e:    <null bytes>


WriteHexWord:
0110:    <null bytes>


WriteString:
0112:    <null bytes>


Fn_1e3:
0118:    <null bytes>


TEST_0:
9000:    03 6d                  (0x36d)
9002:    "CMD AUX MEMORY TEST\r\n\0"

TEST_1:
9018:    04 6d                  (0x46d)
901a:    "CMD SEEK TEST\r\n\0"

TEST_2:
902a:    05 31                  (0x531)
902c:    "CMD READ TEST\r\n\0"

TEST_3:
903c:    02 ce                  (0x2ce)
903e:    "FLOPPY COMMAND BUFFER TEST\r\n\0"

TEST_4:
905b:    05 e8                  (0x5e8)
905d:    "FLOPPY SEEK TEST\r\n\0"

TEST_5:
9070:    06 9b                  (0x69b)
9072:    "FLOPPY READ TEST\r\n\0"

TEST_6:
9085:    07 47                  (0x747)
9087:    "ROM SELF TEST\r\n\n\0"

TEST_7:
9098:    00 00                  (0x0)

WriteString:
909a:    85 41                  ld AL, [X++]
909c:    15 01                  bnz L_909f
909e:    09                     ret

L_909f:
909f:    7b 02                  call WriteByte
90a1:    73 f7                  jmp WriteString

WriteByte:
90a3:    c1 f2 00               ld BL, [0xf200]
90a6:    24 30                  srl BL, #1
90a8:    24 30                  srl BL, #1
90aa:    11 f7                  bnc WriteByte
90ac:    a1 f2 01               st AL, [0xf201]
90af:    09                     ret

ReadChar:
90b0:    81 f2 00               ld AL, [0xf200]
90b3:    2c                     srl AL, #1
90b4:    11 fa                  bnc ReadChar
90b6:    81 f2 01               ld AL, [0xf201]
90b9:    09                     ret

WriteHexWord:
90ba:    a5 a2                  st AL, [--S]
90bc:    45 01                  mov AL, AH
90be:    7b 05                  call WriteHexByte
90c0:    85 a1                  ld AL, [S++]
90c2:    7b 01                  call WriteHexByte
90c4:    09                     ret

WriteHexByte:
90c5:    a5 a2                  st AL, [--S]
90c7:    c0 f0                  ld BL, 0xf0
90c9:    42 31                  and AL, BL
90cb:    07                     rl
90cc:    26 10                  rrc AL, #1
90ce:    2c                     srl AL, #1
90cf:    2c                     srl AL, #1
90d0:    2c                     srl AL, #1
90d1:    c0 b0                  ld BL, 0xb0
90d3:    40 31                  add AL, BL
90d5:    c0 b9                  ld BL, 0xb9
90d7:    49                     sub BL, AL
90d8:    19 04                  ble L_90de
90da:    c0 07                  ld BL, 0x07
90dc:    40 31                  add AL, BL

L_90de:
90de:    7b c3                  call WriteByte
90e0:    85 a1                  ld AL, [S++]
90e2:    c0 0f                  ld BL, 0x0f
90e4:    42 31                  and AL, BL
90e6:    c0 b0                  ld BL, 0xb0
90e8:    40 31                  add AL, BL
90ea:    c0 b9                  ld BL, 0xb9
90ec:    49                     sub BL, AL
90ed:    19 04                  ble L_90f3
90ef:    c0 07                  ld BL, 0x07
90f1:    40 31                  add AL, BL

L_90f3:
90f3:    7b ae                  call WriteByte
90f5:    09                     ret

FinishTest:
90f6:    a1 f1 0a               st AL, [0xf10a]
90f9:    81 f2 00               ld AL, [0xf200]
90fc:    2c                     srl AL, #1
90fd:    11 57                  bnc L_9156
90ff:    81 f2 01               ld AL, [0xf201]
9102:    c0 80                  ld BL, 0x80
9104:    43 31                  or AL, BL
9106:    c0 83                  ld BL, 0x83
9108:    49                     sub BL, AL
9109:    15 4b                  bnz L_9156
910b:    81 01 08               ld AL, [0x0108]
910e:    14 32                  bz L_9142
9110:    7a 01 12               call @[WriteString|0x0112]
9113:    "\r\n*** FAIL ***\0"
9122:    a1 f1 0b               st AL, [0xf10b]
9125:    a1 f1 0c               st AL, [0xf10c]

PressSpaceThenExit:
9128:    7a 01 12               call @[WriteString|0x0112]
912b:    "\r\nPRESS SPACE\x07\r\n\0"
913c:    7a 01 02               call @[ReadChar|0x0102]
913f:    72 01 00               jmp @[0x0100]

L_9142:
9142:    7a 01 12               call @[WriteString|0x0112]
9145:    "\r\n*** PASS ***\0"
9154:    73 d2                  jmp PressSpaceThenExit

L_9156:
9156:    90 c0 00               ld A, 0xc000
9159:    5f                     mov S, A
915a:    91 01 1a               ld A, [0x011a]
915d:    5e                     mov Z, A
915e:    95 41                  ld A, [X++]
9160:    50 80                  add A, Z
9162:    75 00                  jmp [A]

PrintCtrlCToExit:
9164:    7a 01 12               call @[WriteString|0x0112]
9167:    "\r\n(CONTROL-C TO EXIT)\r\n\0"
917f:    09                     ret

Init:
9180:    3a                     clr A, #0
9181:    b1 01 08               st A, [0x0108]
9184:    90 01 e3               ld A, 0x01e3
9187:    50 80                  add A, Z
9189:    b1 01 18               st A, [Fn_1e3|0x0118]
918c:    90 00 c5               ld A, 0x00c5
918f:    50 80                  add A, Z
9191:    b1 01 0a               st A, [WriteHexByte|0x010a]
9194:    90 02 86               ld A, 0x0286
9197:    50 80                  add A, Z
9199:    b1 01 0c               st A, [Fn_286|0x010c]
919c:    90 01 64               ld A, 0x0164
919f:    50 80                  add A, Z
91a1:    b1 01 06               st A, [PrintCtrlCToExit|0x0106]
91a4:    90 00 b0               ld A, 0x00b0
91a7:    50 80                  add A, Z
91a9:    b1 01 02               st A, [ReadChar|0x0102]
91ac:    90 00 9a               ld A, 0x009a
91af:    50 80                  add A, Z
91b1:    b1 01 12               st A, [WriteString|0x0112]
91b4:    90 00 ba               ld A, 0x00ba
91b7:    50 80                  add A, Z
91b9:    b1 01 10               st A, [WriteHexWord|0x0110]
91bc:    90 00 f6               ld A, 0x00f6
91bf:    50 80                  add A, Z
91c1:    b1 01 04               st A, [FinishTest|0x0104]
91c4:    90 01 28               ld A, 0x0128
91c7:    50 80                  add A, Z
91c9:    b1 01 0e               st A, [PressSpaceThenExit|0x010e]
91cc:    55 80                  mov A, Z
91ce:    b1 01 1a               st A, [0x011a]
91d1:    95 41                  ld A, [X++]
91d3:    b1 01 14               st A, [0x0114]
91d6:    38                     inc A, #1
91d7:    b1 01 16               st A, [0x0116]
91da:    55 40                  mov A, X
91dc:    65 a1                  ld X, [S++]
91de:    69 01 00               st X, [0x0100]
91e1:    75 00                  jmp [A]

Fn_1e3:
91e3:    7a 01 0c               call @[Fn_286|0x010c]
91e6:    6d a2                  st X, [--S]
91e8:    60 03 e8               ld X, 0x03e8

L_91eb:
91eb:    82 01 16               ld AL, @[0x0116]
91ee:    c0 08                  ld BL, 0x08
91f0:    4a                     and BL, AL
91f1:    14 2b                  bz L_921e
91f3:    0e                     dly
91f4:    3f                     dec X
91f5:    15 f4                  bnz L_91eb
91f7:    7a 01 12               call @[WriteString|0x0112]
91fa:    "*** BUSY DID NOT CLEAR ***\0"
9215:    a1 f1 0b               st AL, [0xf10b]
9218:    a1 f1 0c               st AL, [0xf10c]
921b:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_921e:
921e:    60 03 e8               ld X, 0x03e8

L_9221:
9221:    2c                     srl AL, #1
9222:    10 2b                  bc L_924f
9224:    0e                     dly
9225:    3f                     dec X
9226:    15 f9                  bnz L_9221
9228:    7a 01 12               call @[WriteString|0x0112]
922b:    "*** FOUT NEVER CAME ON ***\0"
9246:    a1 f1 0b               st AL, [0xf10b]
9249:    a1 f1 0c               st AL, [0xf10c]
924c:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_924f:
924f:    03                     rf
9250:    82 01 14               ld AL, @[0x0114]
9253:    15 03                  bnz L_9258
9255:    65 a1                  ld X, [S++]
9257:    09                     ret

L_9258:
9258:    a5 a2                  st AL, [--S]
925a:    7a 01 12               call @[WriteString|0x0112]
925d:    "*** \0"
9262:    85 a1                  ld AL, [S++]
9264:    7a 01 0a               call @[WriteHexByte|0x010a]
9267:    7a 01 12               call @[WriteString|0x0112]
926a:    " ERROR ***\r\n\0"
9277:    80 01                  ld AL, 0x01
9279:    a1 01 08               st AL, [0x0108]
927c:    a1 f1 0b               st AL, [0xf10b]
927f:    a1 f1 0c               st AL, [0xf10c]
9282:    65 a1                  ld X, [S++]
9284:    02                     sf
9285:    09                     ret

Fn_286:
9286:    6d a2                  st X, [--S]
9288:    0e                     dly
9289:    60 03 e8               ld X, 0x03e8

L_928c:
928c:    82 01 16               ld AL, @[0x0116]
928f:    2c                     srl AL, #1
9290:    2c                     srl AL, #1
9291:    11 2d                  bnc L_92c0
9293:    0e                     dly
9294:    3f                     dec X
9295:    15 f5                  bnz L_928c
9297:    7a 01 12               call @[WriteString|0x0112]
929a:    "*** FIN DID NOT GO OFF ***\r\n\0"
92b7:    a1 f1 0b               st AL, [0xf10b]
92ba:    a1 f1 0c               st AL, [0xf10c]
92bd:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_92c0:
92c0:    65 a1                  ld X, [S++]
92c2:    09                     ret
92c3:    90
92c4:    01
92c5:    80
92c6:    50
92c7:    80
92c8:    7d
92c9:    00
92ca:    f8 08                  (0xf808)
92cc:    73 09                  jmp L_92d7

Entry_FLOPPY_COMMAND_BUFFER_TEST:
92ce:    90 01 80               ld A, 0x0180
92d1:    50 80                  add A, Z
92d3:    7d 00                  call [A]
92d5:    f8 00                  (0xf800)

L_92d7:
92d7:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
92da:    32 60                  clr Y, #0
92dc:    60 00 c8               ld X, 0x00c8
92df:    55 60                  mov A, Y
92e1:    d0 01 1c               ld B, 0x011c

L_92e4:
92e4:    a5 21                  st AL, [B++]
92e6:    28                     inc AL, #1
92e7:    28                     inc AL, #1
92e8:    28                     inc AL, #1
92e9:    3f                     dec X
92ea:    15 f8                  bnz L_92e4
92ec:    90 ff 37               ld A, 0xff37
92ef:    2f 02                  ld_dma_count A
92f1:    90 01 1c               ld A, 0x011c
92f4:    2f 00                  ld_dma_addr A
92f6:    2f 34                  dma_mode #3
92f8:    2f 06                  enable_dma
92fa:    80 43                  ld AL, 0x43
92fc:    a2 01 14               st AL, @[0x0114]
92ff:    7a 01 18               call @[Fn_1e3|0x0118]
9302:    60 00 e6               ld X, 0x00e6
9305:    3a                     clr A, #0
9306:    d0 01 1c               ld B, 0x011c

L_9309:
9309:    a5 21                  st AL, [B++]
930b:    3f                     dec X
930c:    15 fb                  bnz L_9309
930e:    90 ff 37               ld A, 0xff37
9311:    2f 02                  ld_dma_count A
9313:    90 01 1c               ld A, 0x011c
9316:    2f 00                  ld_dma_addr A
9318:    2f 34                  dma_mode #3
931a:    2f 06                  enable_dma
931c:    80 44                  ld AL, 0x44
931e:    a2 01 14               st AL, @[0x0114]
9321:    7a 01 18               call @[Fn_1e3|0x0118]
9324:    60 00 c8               ld X, 0x00c8
9327:    d0 01 1c               ld B, 0x011c
932a:    55 60                  mov A, Y
932c:    45 10                  mov AH, AL

L_932e:
932e:    85 21                  ld AL, [B++]
9330:    41 01                  sub AL, AH
9332:    15 10                  bnz L_9344
9334:    20 00                  inc AH, #1
9336:    20 00                  inc AH, #1
9338:    20 00                  inc AH, #1
933a:    3f                     dec X
933b:    15 f1                  bnz L_932e
933d:    20 70                  inc YL, #1
933f:    7a 01 04               call @[FinishTest|0x0104]
9342:    02 da                  (0x2da)

L_9344:
9344:    7a 01 12               call @[WriteString|0x0112]
9347:    "*** COMMAND BUFFER ERROR ***\0"
9364:    a1 f1 0b               st AL, [0xf10b]
9367:    a1 f1 0c               st AL, [0xf10c]
936a:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

Entry_CMD_AUX_MEMORY_TEST:
936d:    90 01 80               ld A, 0x0180
9370:    50 80                  add A, Z
9372:    7d 00                  call [A]
9374:    f8 08                  (0xf808)
9376:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
9379:    32 60                  clr Y, #0
937b:    60 3f ff               ld X, 0x3fff
937e:    55 60                  mov A, Y
9380:    d0 01 1c               ld B, 0x011c

L_9383:
9383:    a5 21                  st AL, [B++]
9385:    28                     inc AL, #1
9386:    28                     inc AL, #1
9387:    28                     inc AL, #1
9388:    3f                     dec X
9389:    15 f8                  bnz L_9383
938b:    90 c0 00               ld A, 0xc000
938e:    2f 02                  ld_dma_count A
9390:    90 01 1c               ld A, 0x011c
9393:    2f 00                  ld_dma_addr A
9395:    2f 34                  dma_mode #3
9397:    2f 06                  enable_dma
9399:    80 46                  ld AL, 0x46
939b:    a2 01 14               st AL, @[0x0114]
939e:    7a 01 0c               call @[Fn_286|0x010c]
93a1:    2a                     clr AL, #0
93a2:    a2 01 14               st AL, @[0x0114]
93a5:    7a 01 0c               call @[Fn_286|0x010c]
93a8:    2a                     clr AL, #0
93a9:    a2 01 14               st AL, @[0x0114]
93ac:    7a 01 0c               call @[Fn_286|0x010c]
93af:    80 3f                  ld AL, 0x3f
93b1:    a2 01 14               st AL, @[0x0114]
93b4:    7a 01 0c               call @[Fn_286|0x010c]
93b7:    80 ff                  ld AL, 0xff
93b9:    a2 01 14               st AL, @[0x0114]
93bc:    7a 01 18               call @[Fn_1e3|0x0118]
93bf:    60 3f ff               ld X, 0x3fff
93c2:    3a                     clr A, #0
93c3:    d0 01 1c               ld B, 0x011c

L_93c6:
93c6:    a5 21                  st AL, [B++]
93c8:    3f                     dec X
93c9:    15 fb                  bnz L_93c6
93cb:    90 c0 00               ld A, 0xc000
93ce:    2f 02                  ld_dma_count A
93d0:    90 01 1c               ld A, 0x011c
93d3:    2f 00                  ld_dma_addr A
93d5:    2f 34                  dma_mode #3
93d7:    2f 06                  enable_dma
93d9:    80 47                  ld AL, 0x47
93db:    a2 01 14               st AL, @[0x0114]
93de:    7a 01 0c               call @[Fn_286|0x010c]
93e1:    2a                     clr AL, #0
93e2:    a2 01 14               st AL, @[0x0114]
93e5:    7a 01 0c               call @[Fn_286|0x010c]
93e8:    2a                     clr AL, #0
93e9:    a2 01 14               st AL, @[0x0114]
93ec:    7a 01 0c               call @[Fn_286|0x010c]
93ef:    80 3f                  ld AL, 0x3f
93f1:    a2 01 14               st AL, @[0x0114]
93f4:    7a 01 0c               call @[Fn_286|0x010c]
93f7:    80 ff                  ld AL, 0xff
93f9:    a2 01 14               st AL, @[0x0114]
93fc:    7a 01 18               call @[Fn_1e3|0x0118]
93ff:    b5 a2                  st A, [--S]
9401:    60 3f ff               ld X, 0x3fff
9404:    d0 01 1c               ld B, 0x011c
9407:    55 60                  mov A, Y
9409:    45 10                  mov AH, AL

L_940b:
940b:    85 21                  ld AL, [B++]
940d:    bd                     st A, [S]
940e:    41 01                  sub AL, AH
9410:    15 12                  bnz L_9424
9412:    20 00                  inc AH, #1
9414:    20 00                  inc AH, #1
9416:    20 00                  inc AH, #1
9418:    3f                     dec X
9419:    15 f0                  bnz L_940b
941b:    95 a1                  ld A, [S++]
941d:    20 70                  inc YL, #1
941f:    7a 01 04               call @[FinishTest|0x0104]
9422:    03 79                  (0x379)

L_9424:
9424:    a1 f1 0b               st AL, [0xf10b]
9427:    a1 f1 0c               st AL, [0xf10c]
942a:    f5 a2                  st B, [--S]
942c:    7a 01 12               call @[WriteString|0x0112]
942f:    "*** ERROR, ADDR=\0"
9440:    95 a1                  ld A, [S++]
9442:    39                     dec A, #1
9443:    7a 01 10               call @[WriteHexWord|0x0110]
9446:    7a 01 12               call @[WriteString|0x0112]
9449:    " EXP=\0"
944f:    85 a1                  ld AL, [S++]
9451:    7a 01 0a               call @[WriteHexByte|0x010a]
9454:    7a 01 12               call @[WriteString|0x0112]
9457:    " ACT=\0"
945d:    85 a1                  ld AL, [S++]
945f:    7a 01 0a               call @[WriteHexByte|0x010a]
9462:    7a 01 12               call @[WriteString|0x0112]
9465:    " ***\0"
946a:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

Entry_CMD_SEEK_TEST:
946d:    90 01 80               ld A, 0x0180
9470:    50 80                  add A, Z
9472:    7d 00                  call [A]
9474:    f8 08                  (0xf808)
9476:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
9479:    d0 41 4d               ld B, 0x414d
947c:    90 81 00               ld A, 0x8100
947f:    b5 21                  st A, [B++]
9481:    90 82 ff               ld A, 0x82ff
9484:    b9                     st A, [B]
9485:    90 ff fb               ld A, 0xfffb
9488:    2f 02                  ld_dma_count A
948a:    90 41 4d               ld A, 0x414d
948d:    2f 00                  ld_dma_addr A
948f:    2f 34                  dma_mode #3
9491:    2f 06                  enable_dma
9493:    80 43                  ld AL, 0x43
9495:    a2 01 14               st AL, @[0x0114]
9498:    7a 01 18               call @[Fn_1e3|0x0118]
949b:    13 09                  bnn L_94a6

L_949d:
949d:    a1 f1 0b               st AL, [0xf10b]
94a0:    a1 f1 0c               st AL, [0xf10c]
94a3:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_94a6:
94a6:    80 45                  ld AL, 0x45
94a8:    a2 01 14               st AL, @[0x0114]
94ab:    7a 01 18               call @[Fn_1e3|0x0118]
94ae:    12 ed                  bn L_949d
94b0:    d0 41 4f               ld B, 0x414f
94b3:    90 84 00               ld A, 0x8400
94b6:    b5 21                  st A, [B++]
94b8:    80 83                  ld AL, 0x83
94ba:    a5 21                  st AL, [B++]
94bc:    3a                     clr A, #0
94bd:    b5 21                  st A, [B++]
94bf:    39                     dec A, #1
94c0:    a9                     st AL, [B]
94c1:    38                     inc A, #1
94c2:    38                     inc A, #1
94c3:    b1 41 b1               st A, [0x41b1]

L_94c6:
94c6:    90 41 4d               ld A, 0x414d
94c9:    2f 00                  ld_dma_addr A
94cb:    90 ff f7               ld A, 0xfff7
94ce:    2f 02                  ld_dma_count A
94d0:    2f 34                  dma_mode #3
94d2:    2f 06                  enable_dma
94d4:    80 43                  ld AL, 0x43
94d6:    a2 01 14               st AL, @[0x0114]
94d9:    7a 01 18               call @[Fn_1e3|0x0118]
94dc:    12 bf                  bn L_949d
94de:    80 45                  ld AL, 0x45
94e0:    a2 01 14               st AL, @[0x0114]
94e3:    7a 01 18               call @[Fn_1e3|0x0118]
94e6:    13 1c                  bnn L_9504
94e8:    7a 01 12               call @[WriteString|0x0112]
94eb:    "TRACK=\0"
94f2:    91 41 52               ld A, [0x4152]
94f5:    7a 01 10               call @[WriteHexWord|0x0110]
94f8:    7a 01 12               call @[WriteString|0x0112]
94fb:    "\r\n\0"
94fe:    a1 f1 0b               st AL, [0xf10b]
9501:    a1 f1 0c               st AL, [0xf10c]

L_9504:
9504:    91 41 b1               ld A, [0x41b1]
9507:    16 1a                  blt L_9523
9509:    d1 41 52               ld B, [0x4152]
950c:    50 20                  add A, B
950e:    b1 41 52               st A, [0x4152]
9511:    d0 03 36               ld B, 0x0336
9514:    59                     sub B, A
9515:    15 af                  bnz L_94c6
9517:    3a                     clr A, #0
9518:    39                     dec A, #1
9519:    b1 41 b1               st A, [0x41b1]
951c:    80 10                  ld AL, 0x10
951e:    a1 41 50               st AL, [0x4150]
9521:    73 a3                  jmp L_94c6

L_9523:
9523:    91 41 52               ld A, [0x4152]
9526:    39                     dec A, #1
9527:    b1 41 52               st A, [0x4152]
952a:    17 9a                  bp L_94c6
952c:    7a 01 04               call @[FinishTest|0x0104]
952f:    04 79                  (0x479)

Entry_CMD_READ_TEST:
9531:    90 01 80               ld A, 0x0180
9534:    50 80                  add A, Z
9536:    7d 00                  call [A]
9538:    f8 08                  (0xf808)
953a:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
953d:    80 41                  ld AL, 0x41
953f:    a2 01 14               st AL, @[0x0114]
9542:    7a 01 0c               call @[Fn_286|0x010c]
9545:    2a                     clr AL, #0
9546:    a2 01 14               st AL, @[0x0114]
9549:    7a 01 0c               call @[Fn_286|0x010c]
954c:    2a                     clr AL, #0
954d:    a2 01 14               st AL, @[0x0114]
9550:    7a 01 18               call @[Fn_1e3|0x0118]
9553:    12 44                  bn L_9599
9555:    90 41 4d               ld A, 0x414d
9558:    5c                     mov Y, A
9559:    90 81 00               ld A, 0x8100
955c:    b5 61                  st A, [Y++]
955e:    90 84 00               ld A, 0x8400
9561:    b5 61                  st A, [Y++]
9563:    80 83                  ld AL, 0x83
9565:    a5 61                  st AL, [Y++]
9567:    3a                     clr A, #0
9568:    b5 61                  st A, [Y++]
956a:    80 85                  ld AL, 0x85
956c:    a5 61                  st AL, [Y++]
956e:    d0 10 00               ld B, 0x1000

L_9571:
9571:    e5 61                  st BL, [Y++]
9573:    90 01 90               ld A, 0x0190
9576:    b5 61                  st A, [Y++]
9578:    20 30                  inc BL, #1
957a:    21 20                  dec BH, #1
957c:    15 f3                  bnz L_9571
957e:    80 ff                  ld AL, 0xff
9580:    ab                     st AL, [Y]

L_9581:
9581:    90 ff c3               ld A, 0xffc3
9584:    2f 02                  ld_dma_count A
9586:    90 41 4d               ld A, 0x414d
9589:    2f 00                  ld_dma_addr A
958b:    2f 34                  dma_mode #3
958d:    2f 06                  enable_dma
958f:    80 43                  ld AL, 0x43
9591:    a2 01 14               st AL, @[0x0114]
9594:    7a 01 18               call @[Fn_1e3|0x0118]
9597:    13 09                  bnn L_95a2

L_9599:
9599:    a1 f1 0b               st AL, [0xf10b]
959c:    a1 f1 0c               st AL, [0xf10c]
959f:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_95a2:
95a2:    90 e6 ff               ld A, 0xe6ff
95a5:    2f 02                  ld_dma_count A
95a7:    90 01 1c               ld A, 0x011c
95aa:    2f 00                  ld_dma_addr A
95ac:    2f 34                  dma_mode #3
95ae:    2f 06                  enable_dma
95b0:    80 45                  ld AL, 0x45
95b2:    a2 01 14               st AL, @[0x0114]
95b5:    7a 01 18               call @[Fn_1e3|0x0118]
95b8:    13 16                  bnn L_95d0
95ba:    7a 01 12               call @[WriteString|0x0112]
95bd:    "TRACK=\0"
95c4:    91 41 52               ld A, [0x4152]
95c7:    7a 01 10               call @[WriteHexWord|0x0110]
95ca:    7a 01 12               call @[WriteString|0x0112]
95cd:    "\r\n\0"

L_95d0:
95d0:    91 41 52               ld A, [0x4152]
95d3:    15 01                  bnz L_95d6
95d5:    38                     inc A, #1

L_95d6:
95d6:    3d                     sll A, #1
95d7:    b1 41 52               st A, [0x4152]
95da:    d0 03 36               ld B, 0x0336
95dd:    59                     sub B, A
95de:    19 a1                  ble L_9581
95e0:    a1 f1 0a               st AL, [0xf10a]
95e3:    7a 01 04               call @[FinishTest|0x0104]
95e6:    05 3d                  (0x53d)

Entry_FLOPPY_SEEK_TEST:
    ; This code is basically the same as Finch hard drive,
    ; the same board is used, so i didn't do a thorough disassembly.
    ; The only things to note here is that floppy geometry is
    ; 75 tracks, 16 sectors, 400 bytes per sector.
95e8:    90 01 80               ld A, 0x0180
95eb:    50 80                  add A, Z
95ed:    7d 00                  call [A]	 ; Init
95ef:    f8 00                  (0xf800)	 ; FFC_BASE
95f1:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
95f4:    d0 41 4d               ld B, 0x414d
95f7:    90 81 01               ld A, 0x8101	 ; Unit number 1 ???
95fa:    b5 21                  st A, [B++]
95fc:    80 82                  ld AL, 0x82
95fe:    a9                     st AL, [B]
95ff:    90 ff fc               ld A, 0xfffc
9602:    2f 02                  ld_dma_count A
9604:    90 41 4d               ld A, 0x414d
9607:    2f 00                  ld_dma_addr A
9609:    2f 34                  dma_mode #3
960b:    2f 06                  enable_dma
960d:    80 43                  ld AL, 0x43
960f:    a2 01 14               st AL, @[0x0114]
9612:    7a 01 18               call @[Fn_1e3|0x0118]
9615:    13 09                  bnn L_9620

L_9617:
9617:    a1 f1 0b               st AL, [0xf10b]
961a:    a1 f1 0c               st AL, [0xf10c]
961d:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_9620:
9620:    80 45                  ld AL, 0x45
9622:    a2 01 14               st AL, @[0x0114]
9625:    7a 01 18               call @[Fn_1e3|0x0118]
9628:    12 ed                  bn L_9617
962a:    d0 41 4f               ld B, 0x414f
962d:    90 83 01               ld A, 0x8301
9630:    b9                     st A, [B]
9631:    80 01                  ld AL, 0x01
9633:    a1 41 b1               st AL, [0x41b1]	 ; One track per step

L_9636:
9636:    90 41 4d               ld A, 0x414d
9639:    2f 00                  ld_dma_addr A
963b:    90 ff fb               ld A, 0xfffb
963e:    2f 02                  ld_dma_count A
9640:    2f 34                  dma_mode #3
9642:    2f 06                  enable_dma
9644:    80 43                  ld AL, 0x43
9646:    a2 01 14               st AL, @[0x0114]
9649:    7a 01 18               call @[Fn_1e3|0x0118]
964c:    12 c9                  bn L_9617
964e:    80 45                  ld AL, 0x45
9650:    a2 01 14               st AL, @[0x0114]
9653:    7a 01 18               call @[Fn_1e3|0x0118]
9656:    13 1c                  bnn L_9674
9658:    7a 01 12               call @[WriteString|0x0112]
965b:    "TRACK=\0"
9662:    81 41 50               ld AL, [0x4150]
9665:    7a 01 0a               call @[WriteHexByte|0x010a]
9668:    7a 01 12               call @[WriteString|0x0112]
966b:    "\r\n\0"
966e:    a1 f1 0b               st AL, [0xf10b]
9671:    a1 f1 0c               st AL, [0xf10c]

L_9674:
9674:    81 41 b1               ld AL, [0x41b1]
9677:    16 14                  blt L_968d
9679:    c1 41 50               ld BL, [0x4150]
967c:    40 31                  add AL, BL
967e:    a1 41 50               st AL, [0x4150]
9681:    c0 4b                  ld BL, 0x4b	 ; 75 tracks
9683:    49                     sub BL, AL
9684:    15 b0                  bnz L_9636
9686:    80 ff                  ld AL, 0xff	 ; -1 track per step, going backwards
9688:    a1 41 b1               st AL, [0x41b1]
968b:    73 a9                  jmp L_9636

L_968d:
968d:    81 41 50               ld AL, [0x4150]
9690:    29                     dec AL, #1
9691:    a1 41 50               st AL, [0x4150]
9694:    17 a0                  bp L_9636
9696:    7a 01 04               call @[FinishTest|0x0104]
9699:    05 f4                  (0x5f4)

Entry_FLOPPY_READ_TEST:
    ; Floppy read test also steps in power of 2, but starts at track 1.
969b:    90 01 80               ld A, 0x0180
969e:    50 80                  add A, Z
96a0:    7d 00                  call [A]

    ; Init
96a2:    f8 00                  (0xf800)	 ; FFC_BASE

    ; Restart point is here
96a4:    7a 01 06               call @[PrintCtrlCToExit|0x0106]	 ; PrintCtrlCToExit
96a7:    80 41                  ld AL, 0x41
96a9:    a2 01 14               st AL, @[0x0114]
96ac:    7a 01 0c               call @[Fn_286|0x010c]
96af:    2a                     clr AL, #0
96b0:    a2 01 14               st AL, @[0x0114]
96b3:    7a 01 0c               call @[Fn_286|0x010c]
96b6:    2a                     clr AL, #0
96b7:    a2 01 14               st AL, @[0x0114]
96ba:    7a 01 18               call @[Fn_1e3|0x0118]
96bd:    12 3d                  bn L_96fc
96bf:    90 41 4d               ld A, 0x414d
96c2:    5c                     mov Y, A
96c3:    90 81 01               ld A, 0x8101	 ; 01 is a unit number
96c6:    b5 61                  st A, [Y++]
96c8:    90 83 01               ld A, 0x8301	 ; This includes track number, we start from 1
96cb:    b5 61                  st A, [Y++]
96cd:    d0 10 00               ld B, 0x1000	 ; 16 sectors

L_96d0:
96d0:    80 88                  ld AL, 0x88
96d2:    a5 61                  st AL, [Y++]	 ; 0x88
96d4:    e5 61                  st BL, [Y++]	 ; Sector number
96d6:    2a                     clr AL, #0	 ; 0
96d7:    a5 61                  st AL, [Y++]
96d9:    90 01 90               ld A, 0x0190	 ; sector length = 400 bytes
96dc:    b5 61                  st A, [Y++]
96de:    20 30                  inc BL, #1
96e0:    21 20                  dec BH, #1
96e2:    15 ec                  bnz L_96d0

L_96e4:
96e4:    90 ff ab               ld A, 0xffab
96e7:    2f 02                  ld_dma_count A
96e9:    90 41 4d               ld A, 0x414d
96ec:    2f 00                  ld_dma_addr A
96ee:    2f 34                  dma_mode #3
96f0:    2f 06                  enable_dma
96f2:    80 43                  ld AL, 0x43
96f4:    a2 01 14               st AL, @[0x0114]
96f7:    7a 01 18               call @[Fn_1e3|0x0118]
96fa:    13 09                  bnn L_9705

L_96fc:
96fc:    a1 f1 0b               st AL, [0xf10b]
96ff:    a1 f1 0c               st AL, [0xf10c]
9702:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_9705:
9705:    90 e6 ff               ld A, 0xe6ff	 ; 6400 bytes = 16 sectors * 400 bytes
9708:    2f 02                  ld_dma_count A
970a:    90 01 1c               ld A, 0x011c
970d:    2f 00                  ld_dma_addr A
970f:    2f 34                  dma_mode #3
9711:    2f 06                  enable_dma
9713:    80 45                  ld AL, 0x45
9715:    a2 01 14               st AL, @[0x0114]
9718:    7a 01 18               call @[Fn_1e3|0x0118]
971b:    13 16                  bnn L_9733
971d:    7a 01 12               call @[WriteString|0x0112]
9720:    "TRACK=\0"
9727:    81 41 50               ld AL, [0x4150]	 ; track number
972a:    7a 01 0a               call @[WriteHexByte|0x010a]
972d:    7a 01 12               call @[WriteString|0x0112]
9730:    "\r\n\0"

L_9733:
9733:    81 41 50               ld AL, [0x4150]	 ; track *= 2
9736:    2d                     sll AL, #1
9737:    a1 41 50               st AL, [0x4150]
973a:    c0 4b                  ld BL, 0x4b	 ; 75 tracks ???
973c:    49                     sub BL, AL
973d:    19 a5                  ble L_96e4
973f:    a1 f1 0a               st AL, [0xf10a]
9742:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9745:    06 a7                  (0x6a7)	 ; Restart point = 0x96a7

Entry_ROM_SELF_TEST:
    ; This is self test for this ROM, the same as in F4, nothing interesting
9747:    90 01 80               ld A, 0x0180
974a:    50 80                  add A, Z
974c:    7d 00                  call [A]
974e:    00 00                  (0x0)	 ; Controller base address - not used
9750:    55 86                  mov Y, Z
9752:    3a                     clr A, #0

L_9753:
9753:    85 61                  ld AL, [Y++]
9755:    40 10                  add AH, AL
9757:    d0 07 96               ld B, 0x0796
975a:    50 82                  add B, Z
975c:    51 62                  sub B, Y
975e:    15 f3                  bnz L_9753
9760:    8b                     ld AL, [Y]
9761:    41 01                  sub AL, AH
9763:    15 18                  bnz L_977d
9765:    7a 01 12               call @[WriteString|0x0112]
9768:    "\n\r*** PASS ***\0"
9777:    a1 f1 0a               st AL, [0xf10a]
977a:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]

L_977d:
977d:    7a 01 12               call @[WriteString|0x0112]
9780:    "*** FAIL ***\0"
978d:    a1 f1 0b               st AL, [0xf10b]
9790:    a1 f1 0c               st AL, [0xf10c]
9793:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]
9796:    8c	 ; Checksum byte
9797:    <null bytes>

