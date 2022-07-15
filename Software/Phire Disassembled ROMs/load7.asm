
SyscallVector:
0100:    71 80 00               jmp R_8000

CurrentProcess:
0103:    02 44                  R_0244
0105:    01                     nop
0106:    34 02                  srl A, #3
0108:    0a                     reti

DevicesPtr:
0109:    02 0e                  R_020e
010b:    02                     sf
010c:    3e                     inc X
010d:    04                     ei
010e:    f9                     st B, [B]
010f:    8a                     ld AL, [X]
0110:    21 00                  dec AH, #1
0112:    13 00                  bnn L_0114

L_0114:
0114:    00                     HALT
0115:    3c                     srl A, #1
0116:    02                     sf
0117:    44 00                  xor AH, AH
0119:    00                     HALT
011a:    00                     HALT
011b:    00                     HALT
011c:    ff                     st B, [P]
011d:    05 0f                  R_050f
011f:    ff
0120:    04
0121:    f7 'w'
0122:    00
0123:    00
0124:    00
0125:    01

EarlyInitDevicesPtr:
0126:    04 f2                  EarlyInitDevices
0128:    <null bytes>


ClockHours:
0130:    <null bytes>


ClockMinutes:
0133:    "\x00\x00"
0135:    00

ClockSeconds:
0136:    "\x00\x00"
0138:    00
0139:    00
013a:    00
013b:    ff
013c:    ff
013d:    ff
013e:    00

ActiveDiskDevice:
013f:    00 00                  (0x0)

Timeout:
0141:    00                     (0x0)
0142:    ff
0143:    ff
0144:    <null bytes>


PageTableOne:
0161:    00
0162:    00
0163:    00
0164:    02
0165:    3c
0166:    00
0167:    00
0168:    02
0169:    3e
016a:    00
016b:    00
016c:    00
016d:    00
016e:    01
016f:    f5 'u'
0170:    3c
0171:    01
0172:    85
0173:    01
0174:    a5 '%'
0175:    01
0176:    b5 '5'
0177:    01
0178:    c5 'E'
0179:    01
017a:    d5 'U'
017b:    01
017c:    e5 'e'
017d:    00
017e:    00
017f:    00
0180:    00

PageTableTwo:
0181:    00
0182:    00
0183:    00
0184:    00

R_0185:
0185:    1f 01                  branch_unlocked L_0188
0187:    02                     sf

L_0188:
0188:    03                     rf
0189:    04                     ei
018a:    05                     di
018b:    06                     sl
018c:    07                     rl
018d:    08                     cl
018e:    09                     ret
018f:    0a
0190:    0b
0191:    0c
0192:    0d
0193:    0e
0194:    0f
0195:    10
0196:    11
0197:    12
0198:    13
0199:    14
019a:    15
019b:    16
019c:    17
019d:    18
019e:    19
019f:    1a
01a0:    1b
01a1:    1c
01a2:    1d
01a3:    7e
01a4:    7f

R_01a5:
01a5:    <null bytes>


R_01b5:
01b5:    <null bytes>


Devices:
01ba:    <null bytes>


R_01c5:
01c5:    1f 01                  branch_unlocked L_01c8
01c7:    02                     sf

L_01c8:
01c8:    03                     rf
01c9:    04                     ei
01ca:    05                     di
01cb:    06                     sl
01cc:    07                     rl
01cd:    08                     cl
01ce:    09                     ret
01cf:    0a
01d0:    0b
01d1:    0c
01d2:    0d
01d3:    0e
01d4:    0f

R_01d5:
01d5:    10 11                  bc L_01e8
01d7:    12 13                  bn L_01ec
01d9:    14 15                  bz L_01f0
01db:    16 17                  blt L_01f4
01dd:    18 19                  bgt L_01f8
01df:    1a 1b                  bs1 L_01fc
01e1:    1c 1d                  bs3 L_0200
01e3:    7e 7f                  unknown_push

R_01e5:
01e5:    <null bytes>


L_01e8:
01e8:    <null bytes>


L_01ec:
01ec:    <null bytes>


L_01f0:
01f0:    <null bytes>


L_01f4:
01f4:    <null bytes>


R_01f5:
01f5:    00                     HALT
01f6:    00                     HALT
01f7:    00                     HALT

L_01f8:
01f8:    00                     HALT
01f9:    00                     HALT
01fa:    00                     HALT
01fb:    00                     HALT

L_01fc:
01fc:    00                     HALT
01fd:    00                     HALT
01fe:    a6                     unknown
01ff:    85 00                  ld AL, [A]
0201:    00                     HALT
0202:    00                     HALT
0203:    00                     HALT
0204:    00                     HALT
0205:    00                     HALT
0206:    00                     HALT
0207:    00                     HALT
0208:    00                     HALT
0209:    00                     HALT

R_020a:
020a:    02                     sf
020b:    44 00                  xor AH, AH
020d:    00                     HALT

R_020e:
020e:    02 a2                  Device_CRT0
0210:    02 da                  Device_DISK0
0212:    02 f3                  Device_DISK1
0214:    03 0c                  Device_DISK2
0216:    03 25                  Device_DISK3
0218:    03 3e                  Device_DISK4
021a:    03 57                  Device_DISK5
021c:    03 70                  Device_DISK10
021e:    03 89                  Device_DISK11
0220:    03 a2                  Device_DISK12
0222:    03 bb                  Device_DISK13
0224:    03 d4                  Device_DISK20
0226:    03 ed                  Device_DISK21
0228:    04 06                  Device_DISK22
022a:    04 1f                  Device_DISK23
022c:    04 38                  Device_DISK24
022e:    04 51                  Device_DISK40
0230:    04 6a                  Device_DISK41
0232:    04 83                  Device_DISK42
0234:    04 9c                  Device_DISK50
0236:    04 b5                  Device_DISK51
0238:    04 ce                  Device_DISK52

DevicesEnd:
023a:    00 00                  (0x0)

R_023c:
023c:    ff                     st B, [P]
023d:    ff                     st B, [P]

R_023e:
023e:    00                     HALT
023f:    02                     sf
0240:    02                     sf
0241:    a2 00 00               st AL, @[0x0000]

R_0244:
0244:    01                     nop
0245:    00                     HALT
0246:    00                     HALT
0247:    00                     HALT
0248:    04                     ei
0249:    f9                     st B, [B]
024a:    04                     ei
024b:    13 02                  bnn L_024f
024d:    a2 '"'
024e:    00

L_024f:
024f:    00                     HALT
0250:    ef                     st BL, [P]
0251:    ff                     st B, [P]
0252:    ef                     st BL, [P]
0253:    ff                     st B, [P]
0254:    00                     HALT
0255:    00                     HALT
0256:    01                     nop
0257:    00                     HALT
0258:    00                     HALT
0259:    00                     HALT
025a:    0a                     reti
025b:    05                     di
025c:    0f                     rsys
025d:    <null bytes>

0276:    ff
0277:    ff
0278:    00
0279:    00
027a:    1f
027b:    01
027c:    02
027d:    03
027e:    04
027f:    05
0280:    06
0281:    07
0282:    08
0283:    09
0284:    0a
0285:    0b
0286:    0c
0287:    0d
0288:    0e
0289:    0f
028a:    10
028b:    11
028c:    12
028d:    13
028e:    14
028f:    15
0290:    16
0291:    17
0292:    18
0293:    19
0294:    1a
0295:    1b
0296:    1c
0297:    1d
0298:    7e
0299:    7f
029a:    fd '}'
029b:    00
029c:    00
029d:    00
029e:    00
029f:    00
02a0:    00
02a1:    00

Device_CRT0:
02a2:    c7                     (0xc7)
02a3:    02                     (0x2)

Device_CRT0_number:
02a4:    01                     (0x1)
02a5:    04 e7                  R_04e7
02a7:    b2 6c                  CRTDeviceFunctions
02a9:    "CRT0  "
02af:    00
02b0:    00
02b1:    f2 00                  L_f200
02b3:    00
02b4:    00
02b5:    00
02b6:    00
02b7:    00
02b8:    00
02b9:    83
02ba:    18
02bb:    c5 'E'
02bc:    00
02bd:    00
02be:    00
02bf:    a6 85                  CrtDeviceHooks
02c1:    00                     HALT
02c2:    00                     HALT
02c3:    00                     HALT
02c4:    00                     HALT
02c5:    00                     HALT
02c6:    00                     HALT
02c7:    ff                     st B, [P]
02c8:    ff                     st B, [P]
02c9:    ff                     st B, [P]
02ca:    ff                     st B, [P]
02cb:    ff                     st B, [P]
02cc:    ff                     st B, [P]
02cd:    03                     rf
02ce:    <null bytes>

02d1:    00                     HALT
02d2:    00                     HALT
02d3:    00                     HALT
02d4:    00                     HALT
02d5:    00                     HALT
02d6:    00                     HALT
02d7:    00                     HALT
02d8:    00                     HALT
02d9:    00                     HALT

Device_DISK0:
02da:    57                     (0x57)
02db:    04                     (0x4)

Device_DISK0_number:
02dc:    00                     (0x0)
02dd:    04 e8                  R_04e8
02df:    a6 f5                  WeirdExtra_HawkDeviceObj
02e1:    "DISK0 "
02e7:    00
02e8:    00
02e9:    f1 'q'
02ea:    40

Device_DISK0_TotalTracks:
02eb:    03 2a                  (0x32a)
02ed:    00                     (0x0)
02ee:    06 a6                  R_06a6
02f0:    5a
02f1:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK1:
02f3:    57                     (0x57)
02f4:    04                     (0x4)

Device_DISK1_number:
02f5:    01                     (0x1)
02f6:    04 e8                  R_04e8
02f8:    a6 f7                  HawkDeviceFunctions
02fa:    "DISK1 "
0300:    00
0301:    00
0302:    f1 'q'
0303:    40

Device_DISK1_TotalTracks:
0304:    03 2a                  (0x32a)
0306:    01                     (0x1)
0307:    06 a6                  R_06a6
0309:    5a
030a:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK2:
030c:    57                     (0x57)
030d:    04                     (0x4)

Device_DISK2_number:
030e:    02                     (0x2)
030f:    04 e9                  R_04e9
0311:    a6 f7                  HawkDeviceFunctions
0313:    "DISK2 "
0319:    00
031a:    00
031b:    f1 'q'
031c:    40

Device_DISK2_TotalTracks:
031d:    03 2a                  (0x32a)
031f:    02                     (0x2)
0320:    06 a6                  R_06a6
0322:    5a
0323:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK3:
0325:    57                     (0x57)
0326:    04                     (0x4)

Device_DISK3_number:
0327:    03                     (0x3)
0328:    04 e9                  R_04e9
032a:    a6 f7                  HawkDeviceFunctions
032c:    "DISK3 "
0332:    00
0333:    00
0334:    f1 'q'
0335:    40

Device_DISK3_TotalTracks:
0336:    03 2a                  (0x32a)
0338:    03                     (0x3)
0339:    06 a6                  R_06a6
033b:    5a
033c:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK4:
033e:    57                     (0x57)
033f:    04                     (0x4)

Device_DISK4_number:
0340:    04                     (0x4)
0341:    04 ea                  R_04ea
0343:    a6 f7                  HawkDeviceFunctions
0345:    "DISK4 "
034b:    00
034c:    00
034d:    f1 'q'
034e:    40

Device_DISK4_TotalTracks:
034f:    03 2a                  (0x32a)
0351:    04                     (0x4)
0352:    06 a6                  R_06a6
0354:    5a
0355:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK5:
0357:    57                     (0x57)
0358:    04                     (0x4)

Device_DISK5_number:
0359:    05                     (0x5)
035a:    04 ea                  R_04ea
035c:    a6 f7                  HawkDeviceFunctions
035e:    "DISK5 "
0364:    00
0365:    00
0366:    f1 'q'
0367:    40

Device_DISK5_TotalTracks:
0368:    03 2a                  (0x32a)
036a:    05                     (0x5)
036b:    06 a6                  R_06a6
036d:    5a
036e:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK10:
0370:    57                     (0x57)
0371:    04                     (0x4)

Device_DISK10_number:
0372:    0a                     (0xa)
0373:    04 eb                  R_04eb
0375:    ac a7                  FDCDeviceObj
0377:    "DISK10"
037d:    00
037e:    00
037f:    f8 'x'
0380:    00

Device_DISK10_TotalTracks:
0381:    00 60                  (0x60)
0383:    01                     (0x1)
0384:    06 a6                  R_06a6
0386:    06
0387:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK11:
0389:    57                     (0x57)
038a:    04                     (0x4)

Device_DISK11_number:
038b:    0b                     (0xb)
038c:    04 ec                  R_04ec
038e:    ac a7                  FDCDeviceObj
0390:    "DISK11"
0396:    00
0397:    00
0398:    f8 'x'
0399:    00

Device_DISK11_TotalTracks:
039a:    00 60                  (0x60)
039c:    02                     (0x2)
039d:    06 a6                  R_06a6
039f:    06
03a0:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK12:
03a2:    57                     (0x57)
03a3:    04                     (0x4)

Device_DISK12_number:
03a4:    0c                     (0xc)
03a5:    04 ed                  R_04ed
03a7:    ac a7                  FDCDeviceObj
03a9:    "DISK12"
03af:    00
03b0:    00
03b1:    f8 'x'
03b2:    00

Device_DISK12_TotalTracks:
03b3:    00 60                  (0x60)
03b5:    04                     (0x4)
03b6:    06 a6                  R_06a6
03b8:    06
03b9:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK13:
03bb:    57                     (0x57)
03bc:    04                     (0x4)

Device_DISK13_number:
03bd:    0d                     (0xd)
03be:    04 ee                  R_04ee
03c0:    ac a7                  FDCDeviceObj
03c2:    "DISK13"
03c8:    00
03c9:    00
03ca:    f8 'x'
03cb:    00

Device_DISK13_TotalTracks:
03cc:    00 60                  (0x60)
03ce:    08                     (0x8)
03cf:    06 a6                  R_06a6
03d1:    06
03d2:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK20:
03d4:    57                     (0x57)
03d5:    04                     (0x4)

Device_DISK20_number:
03d6:    14                     (0x14)
03d7:    04 ef                  R_04ef
03d9:    b8 4f                  WDCDeviceObj
03db:    "DISK20"
03e1:    00
03e2:    00
03e3:    f8 'x'
03e4:    08

Device_DISK20_TotalTracks:
03e5:    08 03                  (0x803)
03e7:    00                     (0x0)
03e8:    06 a6                  R_06a6
03ea:    ff
03eb:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK21:
03ed:    57                     (0x57)
03ee:    04                     (0x4)

Device_DISK21_number:
03ef:    15                     (0x15)
03f0:    04 ef                  R_04ef
03f2:    b8 4f                  WDCDeviceObj
03f4:    "DISK21"
03fa:    00
03fb:    00
03fc:    f8 'x'
03fd:    08

Device_DISK21_TotalTracks:
03fe:    08 03                  (0x803)
0400:    01                     (0x1)
0401:    06 a6                  R_06a6
0403:    ff
0404:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK22:
0406:    57                     (0x57)
0407:    04                     (0x4)

Device_DISK22_number:
0408:    16                     (0x16)
0409:    04 ef                  R_04ef
040b:    b8 4f                  WDCDeviceObj
040d:    "DISK22"
0413:    00
0414:    00
0415:    f8 'x'
0416:    08

Device_DISK22_TotalTracks:
0417:    08 03                  (0x803)
0419:    02                     (0x2)
041a:    06 a6                  R_06a6
041c:    ff
041d:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK23:
041f:    57                     (0x57)
0420:    04                     (0x4)

Device_DISK23_number:
0421:    17                     (0x17)
0422:    04 ef                  R_04ef
0424:    b8 4f                  WDCDeviceObj
0426:    "DISK23"
042c:    00
042d:    00
042e:    f8 'x'
042f:    08

Device_DISK23_TotalTracks:
0430:    08 03                  (0x803)
0432:    03                     (0x3)
0433:    06 a6                  R_06a6
0435:    ff
0436:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK24:
0438:    57                     (0x57)
0439:    04                     (0x4)

Device_DISK24_number:
043a:    18                     (0x18)
043b:    04 ef                  R_04ef
043d:    b8 4f                  WDCDeviceObj
043f:    "DISK24"
0445:    00
0446:    00
0447:    f8 'x'
0448:    08

Device_DISK24_TotalTracks:
0449:    08 03                  (0x803)
044b:    04                     (0x4)
044c:    06 a6                  R_06a6
044e:    ff
044f:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK40:
0451:    57                     (0x57)
0452:    04                     (0x4)

Device_DISK40_number:
0453:    28                     (0x28)
0454:    04 f0                  R_04f0
0456:    bf 08                  Unk40DeviceObj
0458:    "DISK40"
045e:    00
045f:    00
0460:    f8 'x'
0461:    00

Device_DISK40_TotalTracks:
0462:    15 5e                  (0x155e)
0464:    02                     (0x2)
0465:    06 a6                  R_06a6
0467:    ff
0468:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK41:
046a:    57                     (0x57)
046b:    04                     (0x4)

Device_DISK41_number:
046c:    29                     (0x29)
046d:    04 f0                  R_04f0
046f:    bf 08                  Unk40DeviceObj
0471:    "DISK41"
0477:    00
0478:    00
0479:    f8 'x'
047a:    00

Device_DISK41_TotalTracks:
047b:    15 5e                  (0x155e)
047d:    04                     (0x4)
047e:    06 a6                  R_06a6
0480:    ff
0481:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK42:
0483:    57                     (0x57)
0484:    04                     (0x4)

Device_DISK42_number:
0485:    2a                     (0x2a)
0486:    04 f0                  R_04f0
0488:    bf 08                  Unk40DeviceObj
048a:    "DISK42"
0490:    00
0491:    00
0492:    f8 'x'
0493:    00

Device_DISK42_TotalTracks:
0494:    15 5e                  (0x155e)
0496:    08                     (0x8)
0497:    06 a6                  R_06a6
0499:    ff
049a:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK50:
049c:    57                     (0x57)
049d:    04                     (0x4)

Device_DISK50_number:
049e:    32                     (0x32)
049f:    04 f1                  R_04f1
04a1:    c6 40                  Unk50DeviceObj
04a3:    "DISK50"
04a9:    00
04aa:    00
04ab:    f8 'x'
04ac:    00

Device_DISK50_TotalTracks:
04ad:    11 d0                  (0x11d0)
04af:    02                     (0x2)
04b0:    06 a6                  R_06a6
04b2:    ff
04b3:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK51:
04b5:    57                     (0x57)
04b6:    04                     (0x4)

Device_DISK51_number:
04b7:    33                     (0x33)
04b8:    04 f1                  R_04f1
04ba:    c6 40                  Unk50DeviceObj
04bc:    "DISK51"
04c2:    00
04c3:    00
04c4:    f8 'x'
04c5:    00

Device_DISK51_TotalTracks:
04c6:    11 d0                  (0x11d0)
04c8:    04                     (0x4)
04c9:    06 a6                  R_06a6
04cb:    ff
04cc:    00 64                  (0x64)	 ; Set to the user supplied boot Code

Device_DISK52:
04ce:    57                     (0x57)
04cf:    04                     (0x4)

Device_DISK52_number:
04d0:    34                     (0x34)
04d1:    04 f1                  R_04f1
04d3:    c6 40                  Unk50DeviceObj
04d5:    "DISK52"
04db:    00
04dc:    00
04dd:    f8 'x'
04de:    00

Device_DISK52_TotalTracks:
04df:    11 d0                  (0x11d0)
04e1:    08                     (0x8)
04e2:    06 a6                  R_06a6
04e4:    ff
04e5:    00 64                  (0x64)	 ; Set to the user supplied boot Code

R_04e7:
04e7:    <null bytes>


R_04e8:
04e8:    <null bytes>


R_04e9:
04e9:    00

R_04ea:
04ea:    00

R_04eb:
04eb:    00

R_04ec:
04ec:    00

R_04ed:
04ed:    00

R_04ee:
04ee:    00

R_04ef:
04ef:    00

R_04f0:
04f0:    00

R_04f1:
04f1:    00

EarlyInitDevices:
04f2:    b2 6c                  CRTDeviceFunctions
04f4:    00                     HALT
04f5:    00                     HALT
04f6:    ff                     st B, [P]

R_04f7:
04f7:    ff                     st B, [P]
04f8:    00                     HALT

R_04f9:
04f9:    00                     HALT
04fa:    ff                     st B, [P]
04fb:    ff                     st B, [P]
04fc:    00                     HALT
04fd:    ff                     st B, [P]
04fe:    ff                     st B, [P]
04ff:    00                     HALT
0500:    ff                     st B, [P]
0501:    ff                     st B, [P]
0502:    00                     HALT
0503:    ff                     st B, [P]
0504:    ff                     st B, [P]
0505:    a0 a0                  st AL, 0xa0
0507:    a0 a0                  st AL, 0xa0
0509:    a0 a0                  st AL, 0xa0
050b:    a0 a0                  st AL, 0xa0
050d:    a0 a0                  st AL, 0xa0

R_050f:
050f:    71 cf 46               jmp Start
0512:    ff
0513:    ff
0514:    ff
0515:    ff
0516:    ff
0517:    ff
0518:    ff
0519:    ff
051a:    ff
051b:    ff
051c:    ff
051d:    ff
051e:    ff
051f:    ff
0520:    ff
0521:    ff
0522:    ff
0523:    ff
0524:    ff
0525:    ff
0526:    ff
0527:    ff
0528:    ff
0529:    ff
052a:    <null bytes>

06a3:    8d
06a4:    8d
06a5:    ff

R_06a6:
06a6:    ff                     st B, [P]
06a7:    ff                     st B, [P]
06a8:    ff                     st B, [P]
06a9:    ff                     st B, [P]
06aa:    ff                     st B, [P]
06ab:    ff                     st B, [P]
06ac:    ff                     st B, [P]
06ad:    ff                     st B, [P]
06ae:    ff                     st B, [P]
06af:    ff                     st B, [P]
06b0:    ff                     st B, [P]
06b1:    ff                     st B, [P]
06b2:    ff                     st B, [P]
06b3:    ff                     st B, [P]
06b4:    ff                     st B, [P]
06b5:    ff                     st B, [P]
06b6:    ff                     st B, [P]
06b7:    ff                     st B, [P]
06b8:    ff                     st B, [P]
06b9:    ff                     st B, [P]
06ba:    ff                     st B, [P]
06bb:    ff                     st B, [P]
06bc:    ff                     st B, [P]
06bd:    ff                     st B, [P]
06be:    ff                     st B, [P]
06bf:    ff                     st B, [P]
06c0:    ff                     st B, [P]
06c1:    ff                     st B, [P]
06c2:    ff                     st B, [P]
06c3:    ff                     st B, [P]
06c4:    ff                     st B, [P]
06c5:    ff                     st B, [P]
06c6:    ff                     st B, [P]
06c7:    ff                     st B, [P]
06c8:    ff                     st B, [P]
06c9:    ff                     st B, [P]
06ca:    ff                     st B, [P]
06cb:    ff                     st B, [P]
06cc:    ff                     st B, [P]
06cd:    ff                     st B, [P]
06ce:    ff                     st B, [P]
06cf:    ff                     st B, [P]
06d0:    ff                     st B, [P]
06d1:    ff                     st B, [P]
06d2:    ff                     st B, [P]
06d3:    ff                     st B, [P]
06d4:    ff                     st B, [P]
06d5:    ff                     st B, [P]
06d6:    ff                     st B, [P]
06d7:    ff                     st B, [P]
06d8:    ff                     st B, [P]
06d9:    ff                     st B, [P]
06da:    ff                     st B, [P]
06db:    ff                     st B, [P]
06dc:    ff                     st B, [P]
06dd:    ff                     st B, [P]
06de:    ff                     st B, [P]
06df:    ff                     st B, [P]
06e0:    ff                     st B, [P]
06e1:    ff                     st B, [P]
06e2:    ff                     st B, [P]
06e3:    ff                     st B, [P]
06e4:    ff                     st B, [P]
06e5:    ff                     st B, [P]
06e6:    ff                     st B, [P]
06e7:    ff                     st B, [P]
06e8:    ff                     st B, [P]
06e9:    ff                     st B, [P]
06ea:    ff                     st B, [P]
06eb:    ff                     st B, [P]
06ec:    ff                     st B, [P]
06ed:    ff                     st B, [P]
06ee:    ff                     st B, [P]
06ef:    ff                     st B, [P]
06f0:    ff                     st B, [P]
06f1:    ff                     st B, [P]
06f2:    ff                     st B, [P]
06f3:    ff                     st B, [P]
06f4:    ff                     st B, [P]
06f5:    ff                     st B, [P]
06f6:    ff                     st B, [P]
06f7:    ff                     st B, [P]
06f8:    ff                     st B, [P]
06f9:    ff                     st B, [P]
06fa:    ff                     st B, [P]
06fb:    ff                     st B, [P]
06fc:    ff                     st B, [P]
06fd:    ff                     st B, [P]
06fe:    ff                     st B, [P]
06ff:    ff                     st B, [P]
0700:    ff                     st B, [P]
0701:    ff                     st B, [P]
0702:    ff                     st B, [P]
0703:    ff                     st B, [P]
0704:    ff                     st B, [P]
0705:    ff                     st B, [P]
0706:    ff                     st B, [P]
0707:    ff                     st B, [P]
0708:    ff                     st B, [P]
0709:    ff                     st B, [P]
070a:    ff                     st B, [P]
070b:    ff                     st B, [P]
070c:    ff                     st B, [P]
070d:    ff                     st B, [P]
070e:    ff                     st B, [P]
070f:    ff                     st B, [P]
0710:    ff                     st B, [P]
0711:    ff                     st B, [P]
0712:    ff                     st B, [P]
0713:    ff                     st B, [P]
0714:    ff                     st B, [P]
0715:    ff                     st B, [P]
0716:    ff                     st B, [P]
0717:    ff                     st B, [P]
0718:    ff                     st B, [P]
0719:    ff                     st B, [P]
071a:    ff                     st B, [P]
071b:    ff                     st B, [P]
071c:    ff                     st B, [P]
071d:    ff                     st B, [P]
071e:    ff                     st B, [P]
071f:    ff                     st B, [P]
0720:    ff                     st B, [P]
0721:    ff                     st B, [P]
0722:    ff                     st B, [P]
0723:    ff                     st B, [P]
0724:    ff                     st B, [P]
0725:    ff                     st B, [P]
0726:    ff                     st B, [P]
0727:    ff                     st B, [P]
0728:    ff                     st B, [P]
0729:    ff                     st B, [P]
072a:    ff                     st B, [P]
072b:    ff                     st B, [P]
072c:    ff                     st B, [P]
072d:    ff                     st B, [P]
072e:    ff                     st B, [P]
072f:    ff                     st B, [P]
0730:    ff                     st B, [P]
0731:    ff                     st B, [P]
0732:    ff                     st B, [P]
0733:    ff                     st B, [P]
0734:    ff                     st B, [P]
0735:    ff                     st B, [P]
0736:    ff                     st B, [P]
0737:    ff                     st B, [P]
0738:    ff                     st B, [P]
0739:    ff                     st B, [P]
073a:    ff                     st B, [P]
073b:    ff                     st B, [P]
073c:    ff                     st B, [P]
073d:    ff                     st B, [P]
073e:    ff                     st B, [P]
073f:    ff                     st B, [P]
0740:    ff                     st B, [P]
0741:    ff                     st B, [P]
0742:    ff                     st B, [P]
0743:    ff                     st B, [P]
0744:    ff                     st B, [P]
0745:    ff                     st B, [P]
0746:    ff                     st B, [P]
0747:    ff                     st B, [P]
0748:    ff                     st B, [P]
0749:    ff                     st B, [P]
074a:    ff                     st B, [P]
074b:    ff                     st B, [P]
074c:    ff                     st B, [P]
074d:    ff                     st B, [P]
074e:    ff                     st B, [P]
074f:    ff                     st B, [P]
0750:    ff                     st B, [P]
0751:    ff                     st B, [P]
0752:    ff                     st B, [P]
0753:    ff                     st B, [P]
0754:    ff                     st B, [P]
0755:    ff                     st B, [P]
0756:    ff                     st B, [P]
0757:    ff                     st B, [P]
0758:    ff                     st B, [P]
0759:    ff                     st B, [P]
075a:    ff                     st B, [P]
075b:    ff                     st B, [P]
075c:    ff                     st B, [P]
075d:    ff                     st B, [P]
075e:    ff                     st B, [P]
075f:    ff                     st B, [P]
0760:    ff                     st B, [P]
0761:    ff                     st B, [P]
0762:    ff                     st B, [P]
0763:    ff                     st B, [P]
0764:    ff                     st B, [P]
0765:    ff                     st B, [P]
0766:    ff                     st B, [P]
0767:    ff                     st B, [P]
0768:    ff                     st B, [P]
0769:    ff                     st B, [P]
076a:    ff                     st B, [P]
076b:    ff                     st B, [P]
076c:    ff                     st B, [P]
076d:    ff                     st B, [P]
076e:    ff                     st B, [P]
076f:    ff                     st B, [P]
0770:    ff                     st B, [P]
0771:    ff                     st B, [P]
0772:    ff                     st B, [P]
0773:    ff                     st B, [P]
0774:    ff                     st B, [P]
0775:    ff                     st B, [P]
0776:    ff                     st B, [P]
0777:    ff                     st B, [P]
0778:    ff                     st B, [P]
0779:    ff                     st B, [P]
077a:    ff                     st B, [P]
077b:    ff                     st B, [P]
077c:    ff                     st B, [P]
077d:    ff                     st B, [P]
077e:    ff                     st B, [P]
077f:    ff                     st B, [P]
0780:    ff                     st B, [P]
0781:    ff                     st B, [P]
0782:    ff                     st B, [P]
0783:    ff                     st B, [P]
0784:    ff                     st B, [P]
0785:    ff                     st B, [P]
0786:    ff                     st B, [P]
0787:    ff                     st B, [P]
0788:    ff                     st B, [P]
0789:    ff                     st B, [P]
078a:    ff                     st B, [P]
078b:    ff                     st B, [P]
078c:    ff                     st B, [P]
078d:    ff                     st B, [P]
078e:    ff                     st B, [P]
078f:    ff                     st B, [P]
0790:    ff                     st B, [P]
0791:    ff                     st B, [P]
0792:    ff                     st B, [P]
0793:    ff                     st B, [P]
0794:    ff                     st B, [P]
0795:    ff                     st B, [P]
0796:    ff                     st B, [P]
0797:    ff                     st B, [P]
0798:    ff                     st B, [P]
0799:    ff                     st B, [P]
079a:    ff                     st B, [P]
079b:    ff                     st B, [P]
079c:    ff                     st B, [P]
079d:    ff                     st B, [P]
079e:    ff                     st B, [P]
079f:    ff                     st B, [P]
07a0:    ff                     st B, [P]
07a1:    ff                     st B, [P]
07a2:    ff                     st B, [P]
07a3:    ff                     st B, [P]
07a4:    ff                     st B, [P]
07a5:    ff                     st B, [P]
07a6:    ff                     st B, [P]
07a7:    <null bytes>


R_8000:
8000:    71 85 0a               jmp R_850a
8003:    71
8004:    80
8005:    68
8006:    71
8007:    00
8008:    00
8009:    00
800a:    00
800b:    8a
800c:    21
800d:    a0 ' '
800e:    7f

R_800f:
800f:    7b 44                  call L_8055
8011:    f7                     memcpy16
8012:    7b 4d                  call L_8061
8014:    09                     ret

R_8015:
8015:    7b 3e                  call L_8055
8017:    dd                     ld B, [S]
8018:    a5 2c 05               st AL, @[B + 0x05]
801b:    73 44                  jmp L_8061

R_801d:
801d:    7b 36                  call L_8055
801f:    dd                     ld B, [S]
8020:    85 2c 05               ld AL, @[B + 0x05]
8023:    73 3c                  jmp L_8061

FindDeviceFunction:
    ; This routine finds a function pointer in device's function table
    ; Function table
    ; and returns it in B.
    ; On input X holds device object and A is function number (number of entry in device's function table)
8025:    45 11                  mov AL, AL
8027:    16 15                  blt L_803e	 ; if A < 0, the function is not found
8029:    7b 2a                  call L_8055
802b:    dd                     ld B, [S]	 ; B = device object
802c:    d5 2c 05               ld B, @[B + 0x05]	 ; First word of functions table. Number of entries
802f:    49                     sub BL, AL
8030:    18 0c                  bgt L_803e
8032:    38                     inc A, #1	 ; The first entry doesn't count
8033:    3d                     sll A, #1	 ; offset =  A * 2 - size of a pointer
8034:    dd                     ld B, [S]	 ; When we were called, this was in X
8035:    d5 28 05               ld B, [B + 0x05]	 ; Device function table
8038:    58                     add B, A	 ; Add offfset
8039:    d9                     ld B, [B]	 ; B = function pointer
803a:    22 00                  clr AH, #0	 ; AH = 0 and Set Z flag
803c:    73 23                  jmp L_8061	 ; Found

L_803e:
803e:    22 00                  clr AH, #0	 ; AH = -1, this also resets Z flag
8040:    21 00                  dec AH, #1	 ; Not found
8042:    73 1d                  jmp L_8061

CallDeviceFunctionInternal:
    ; This also calls a device function by a (number + 1) in A,
    ; It's used for internal needs, so it does no validation unlike FindDeviceFunction
8044:    3d                     sll A, #1	 ; Offset = A * 2 - size of pointer
8045:    50 71 00 05            add A, [Y + 0x0005], A	 ; device_obj.functions + offset
8049:    14 15                  bz L_8060	 ; I wonder how it can be zero...

R_804b:
804b:    7b 34                  call MapCurrentProcess	 ; Map current process ?
804d:    7d 04                  call @[A]	 ; Call the I/O function
804f:    73 17                  jmp R_8068

ExecuteDeviceFunction:
8051:    7b 2e                  call MapCurrentProcess	 ; Map current process ?
8053:    75 20                  jmp [B]	 ; Call the I/O function

L_8055:
8055:    c6                     acquire_semaphore
8056:    2e 1c 78 80 d3         rpf 0x78, [R_80d3|0x80d3]
805b:    2e 0c 78 01 c5         wpf 0x78, [R_01c5|0x01c5]

L_8060:
8060:    09                     ret

L_8061:
8061:    2e 0c 78 80 d3         wpf 0x78, [R_80d3|0x80d3]
8066:    b6                     release_semaphore
8067:    09                     ret

R_8068:
8068:    b3 14                  st A, [Entry_0x807d+1|0x807e]
806a:    91 01 03               ld A, [CurrentProcess|0x0103]
806d:    2e 0d f8 00 36         wpf 0xf8, [A + 0x36]
8072:    3a                     clr A, #0
8073:    7e 01                  push {A}
8075:    7e 41                  push {X}
8077:    31 a0                  dec S, #1
8079:    60 80 7d               ld X, Entry_0x807d|0x807d
807c:    0f                     rsys

Entry_0x807d:
807d:    90 00 00               ld A, 0x0000
8080:    09                     ret

MapCurrentProcess:
    ; It looks like this function makes sure CurrentProcess' page table is active
8081:    b3 1b                  st A, [Entry_0x809d+1|0x809e]
8083:    91 01 03               ld A, [CurrentProcess|0x0103]
8086:    2e 0d fb 00 36         wpf 0xfb, [A + 0x36]
808b:    2e 0c 7b 01 c5         wpf 0x7b, [R_01c5|0x01c5]
8090:    90 00 03               ld A, 0x0003
8093:    7e 01                  push {A}
8095:    7e 41                  push {X}
8097:    31 a0                  dec S, #1
8099:    60 80 9d               ld X, Entry_0x809d|0x809d
809c:    0f                     rsys

Entry_0x809d:
809d:    90 00 00               ld A, 0x0000
80a0:    09                     ret

R_80a1:
80a1:    ff                     st B, [P]
80a2:    ff                     st B, [P]
80a3:    00                     HALT
80a4:    00                     HALT
80a5:    0f                     rsys
80a6:    <null bytes>


R_80bc:
80bc:    00

R_80bd:
80bd:    00

R_80be:
80be:    00

R_80bf:
80bf:    00
80c0:    82
80c1:    00
80c2:    02
80c3:    00
80c4:    50

R_80c5:
80c5:    80 e3                  ld AL, 0xe3
80c7:    00                     HALT
80c8:    00                     HALT

R_80c9:
80c9:    00                     HALT
80ca:    81 00 02               ld AL, [0x0002]
80cd:    00                     HALT
80ce:    0f                     rsys
80cf:    81
80d0:    66
80d1:    <null bytes>


R_80d3:
80d3:    <null bytes>


R_80e3:
80e3:    9, "STAND BY\r"

R_80ee:
80ee:    29, "ABORT XXX @ XXXX, XXXX, XXXX\r"
810d:    44, "CD:XX, LVL:XX, MAP:XX, IAD:XXXX, EAD:XXXXXX\r"
813b:    14, "OPSYS ABORTED\r"
814b:    25, "ATTEMPTING AUTO-RECOVERY\r"

R_8166:
8166:    13, "MEMORY LOCK\x07\r"
8175:    00
8176:    82
8177:    00
8178:    02
8179:    00
817a:    50
817b:    00
817c:    00
817d:    00
817e:    00
817f:    00
8180:    80
8181:    00
8182:    01
8183:    00
8184:    50
8185:    81
8186:    a7 '''
8187:    00
8188:    00
8189:    ff
818a:    ff
818b:    00
818c:    00
818d:    0f
818e:    <null bytes>


R_81a7:
81a7:    <null bytes>


R_820b:
820b:    <null bytes>


R_8283:
8283:    <null bytes>


R_82fb:
82fb:    <null bytes>


R_8387:
8387:    <null bytes>


R_83ff:
83ff:    00
8400:    01
8401:    8c
8402:    37, "MAX DISK# (M)=XX, SYSTEM DISK (S)=XX\r"
8429:    37, "ENTER NEW SYSTEM DATE: MMDDYY \x08\x08\x08\x08\x08\x08\x08"
8450:    18, "ILLEGAL SET STMNT\r"
8464:    22, "ILLOGICAL SYSTEM DISK\r"
847c:    31, "PREVIOUS SYSTEM DATE: \x00\x00/\x00\x00/\x00\x00\r"
849d:    29, "PARITY CIRCUITRY INOPERATIVE\r"
84bc:    33, "ENTER SYSTEM TIME: HHMMSS \x08\x08\x08\x08\x08\x08\x08"
84df:    14, "DOS 7.1 - A\n\r\n"
84ef:    00
84f0:    01
84f1:    8d
84f2:    c0 '@'
84f3:    d3 'S'
84f4:    d9 'Y'
84f5:    d3 'S'
84f6:    00
84f7:    c0 '@'
84f8:    d4 'T'
84f9:    d8 'X'
84fa:    b0 '0'
84fb:    b0 '0'
84fc:    b0 '0'
84fd:    00
84fe:    c0 '@'
84ff:    d3 'S'
8500:    d9 'Y'
8501:    d3 'S'
8502:    00

R_8503:
8503:    c0 cf                  ld BL, 0xcf
8505:    ca                     ld BL, [X]
8506:    d8                     ld B, [A]
8507:    b0 b0 00               st A, 0xb000

R_850a:
850a:    7e 03                  push {A, B}
850c:    2a                     clr AL, #0
850d:    a1 01 41               st AL, [Timeout|0x0141]
8510:    b6                     release_semaphore
8511:    85 a8 04               ld AL, [S + 0x04]
8514:    a3 71                  st AL, [L_8585+2|0x8587]
8516:    16 6d                  blt L_8585
8518:    c0 4c                  ld BL, 0x4c
851a:    49                     sub BL, AL
851b:    14 39                  bz L_8556
851d:    c0 56                  ld BL, 0x56
851f:    49                     sub BL, AL
8520:    14 34                  bz L_8556
8522:    29                     dec AL, #1
8523:    14 31                  bz L_8556
8525:    85 a8 08               ld AL, [S + 0x08]
8528:    c0 07                  ld BL, 0x07
852a:    4a                     and BL, AL
852b:    21 33                  dec BL, #4
852d:    16 27                  blt L_8556
852f:    d1 01 03               ld B, [CurrentProcess|0x0103]
8532:    c5 28 59               ld BL, [B + 0x59]
8535:    e6 a8                  mov A, IL10(Z)
8537:    49                     sub BL, AL
8538:    17 04                  bp L_853e
853a:    20 39                  inc BL, #10
853c:    18 18                  bgt L_8556

L_853e:
853e:    d4 f0                  ld B, [CurrentProcess (via 0x852f+1)]
8540:    85 28 02               ld AL, [B + 0x02]
8543:    17 0d                  bp L_8552
8545:    79 87 3a               call R_873a
8548:    e6 a8                  mov A, IL10(Z)
854a:    d4 e4                  ld B, [CurrentProcess (via 0x852f+1)]
854c:    a5 28 59               st AL, [B + 0x59]
854f:    85 28 03               ld AL, [B + 0x03]

L_8552:
8552:    29                     dec AL, #1
8553:    a5 28 02               st AL, [B + 0x02]

L_8556:
8556:    3a                     clr A, #0
8557:    85 a8 04               ld AL, [S + 0x04]
855a:    c1 8a d5               ld BL, [R_8ad5|0x8ad5]
855d:    49                     sub BL, AL
855e:    18 25                  bgt L_8585
8560:    3d                     sll A, #1
8561:    d0 8a 21               ld B, R_8a21|0x8a21
8564:    f1 01 0f               st B, [0x010f]
8567:    58                     add B, A
8568:    99                     ld A, [B]
8569:    14 1a                  bz L_8585
856b:    b3 03                  st A, [0x8570]
856d:    7f 03                  pop {A, B}
856f:    71 80 00               jmp R_8000

R_8572:
8572:    7e 03                  push {A, B}
8574:    79 89 82               call R_8982
8577:    89                     ld AL, [B]
8578:    21 11                  dec AL, #2
857a:    15 03                  bnz L_857f
857c:    7f 03                  pop {A, B}
857e:    09                     ret

L_857f:
857f:    7f 03                  pop {A, B}
8581:    65 a1                  ld X, [S++]
8583:    73 00                  jmp L_8585

L_8585:
8585:    90 00 00               ld A, 0x0000
8588:    55 42                  mov B, X
858a:    79 86 12               call R_8612
858d:    09                     ret

R_858e:
858e:    3a                     clr A, #0
858f:    b5 88 19               st A, [Z + 0x19]
8592:    55 80                  mov A, Z
8594:    b5 a2                  st A, [--S]
8596:    6d a2                  st X, [--S]
8598:    61 01 20               ld X, [0x0120]
859b:    dc                     ld B, [Z]

L_859c:
859c:    9a                     ld A, [X]
859d:    16 0b                  blt L_85aa
859f:    41 30                  sub AH, BL
85a1:    15 03                  bnz L_85a6
85a3:    3a                     clr A, #0
85a4:    39                     dec A, #1
85a5:    ba                     st A, [X]

L_85a6:
85a6:    30 44                  inc X, #5
85a8:    73 f2                  jmp L_859c

L_85aa:
85aa:    3b                     not A, #0
85ab:    14 f9                  bz L_85a6
85ad:    20 30                  inc BL, #1
85af:    e5 a2                  st BL, [--S]
85b1:    85 88 07               ld AL, [Z + 0x07]
85b4:    5b                     mov X, A
85b5:    3e                     inc X
85b6:    95 88 04               ld A, [Z + 0x04]
85b9:    5c                     mov Y, A
85ba:    50 46                  add Y, X
85bc:    50 46                  add Y, X
85be:    50 46                  add Y, X

L_85c0:
85c0:    3f                     dec X
85c1:    16 26                  blt L_85e9
85c3:    90 ff fd               ld A, 0xfffd
85c6:    50 06                  add Y, A
85c8:    3a                     clr A, #0
85c9:    8b                     ld AL, [Y]
85ca:    16 f4                  blt L_85c0
85cc:    3d                     sll A, #1
85cd:    d1 01 09               ld B, [DevicesPtr|0x0109]
85d0:    58                     add B, A
85d1:    99                     ld A, [B]
85d2:    5e                     mov Z, A
85d3:    8c                     ld AL, [Z]
85d4:    14 ea                  bz L_85c0
85d6:    95 88 05               ld A, [Z + 0x05]
85d9:    14 e5                  bz L_85c0
85db:    32 01                  clr A, #1
85dd:    cd                     ld BL, [S]
85de:    7e 63                  push {Y, Z}
85e0:    55 86                  mov Y, Z
85e2:    79 80 44               call CallDeviceFunctionInternal
85e5:    7f 63                  pop {Y, Z}
85e7:    73 d7                  jmp L_85c0

L_85e9:
85e9:    85 a1                  ld AL, [S++]
85eb:    65 a1                  ld X, [S++]
85ed:    95 a1                  ld A, [S++]
85ef:    5e                     mov Z, A
85f0:    9c                     ld A, [Z]
85f1:    c1 01 1f               ld BL, [0x011f]
85f4:    49                     sub BL, AL
85f5:    15 03                  bnz L_85fa
85f7:    79 a6 67               call R_a667

L_85fa:
85fa:    90 86 d5               ld A, R_86d5|0x86d5
85fd:    5c                     mov Y, A
85fe:    9c                     ld A, [Z]
85ff:    d5 61                  ld B, [Y++]

L_8601:
8601:    c9                     ld BL, [B]
8602:    49                     sub BL, AL
8603:    15 05                  bnz L_860a
8605:    c0 ff                  ld BL, 0xff
8607:    e5 6c fe               st BL, @[Y + -0x2]

L_860a:
860a:    d5 61                  ld B, [Y++]
860c:    15 f3                  bnz L_8601
860e:    79 9f 58               call R_9f58
8611:    09                     ret

R_8612:
8612:    55 ba 83 ff            mov S, R_83ff|0x83ff
8616:    7e 09                  push {A, B, X, Y, Z}
8618:    8a                     ld AL, [X]
8619:    22 00                  clr AH, #0
861b:    a3 79                  st AL, [L_8695+1|0x8696]
861d:    d0 a0 a0               ld B, 0xa0a0
8620:    f1 80 f6               st B, [R_80ee+8|0x80f6]
8623:    79 ce d6               call R_ced6
8626:    80 f8                  ld AL, 0xf8
8628:    91 01 03               ld A, [CurrentProcess|0x0103]
862b:    5e                     mov Z, A
862c:    3a                     clr A, #0
862d:    a1 01 25               st AL, [0x0125]
8630:    79 85 8e               call R_858e
8633:    95 88 04               ld A, [Z + 0x04]
8636:    85 08 06               ld AL, [A + 0x06]
8639:    16 5a                  blt L_8695
863b:    9d                     ld A, [S]
863c:    79 ce b3               call R_ceb3
863f:    81 02 95               ld AL, [0x0295]
8642:    a8                     st AL, [A]
8643:    02                     sf
8644:    79 ce b3               call R_ceb3
8647:    81 08 55               ld AL, [0x0855]
864a:    40 79                  add ZL, YL
864c:    ce                     ld BL, [C]
864d:    b3 80                  st A, [0x85cf]
864f:    fc                     st B, [Z]
8650:    90 80 ee               ld A, R_80ee|0x80ee
8653:    b1 80 c5               st A, [R_80c5|0x80c5]
8656:    d0 80 bf               ld B, R_80bf|0x80bf
8659:    79 8c 63               call R_8c63

L_865c:
865c:    81 80 bf               ld AL, [R_80bf|0x80bf]
865f:    16 fb                  blt L_865c
8661:    91 01 01               ld A, [SyscallVector+1|0x0101]

L_8664:
8664:    16 fe                  blt L_8664
8666:    61 01 03               ld X, [CurrentProcess|0x0103]
8669:    14 2a                  bz L_8695
866b:    79 89 82               call R_8982
866e:    89                     ld AL, [B]
866f:    14 07                  bz L_8678
8671:    90 80 00               ld A, 0x8000
8674:    51 40                  sub A, X
8676:    10 1d                  bc L_8695

L_8678:
8678:    85 48 12               ld AL, [X + 0x12]
867b:    c0 80                  ld BL, 0x80
867d:    4a                     and BL, AL
867e:    14 15                  bz L_8695
8680:    95 48 0a               ld A, [X + 0x0a]
8683:    b3 0c                  st A, [0x8691]
8685:    95 48 0e               ld A, [X + 0x0e]
8688:    b3 09                  st A, [0x8693]
868a:    7f 09                  pop {A, B, X, Y, Z}
868c:    65 a1                  ld X, [S++]
868e:    66 05                  jsys Syscall_05
8690:    06                         arg1 = (0x6)
8691:    00                     HALT
8692:    00                     HALT
8693:    00                     HALT
8694:    00                     HALT

L_8695:
8695:    c0 00                  ld BL, 0x00
8697:    7b 03                  call L_869c
8699:    ff                     st B, [P]

R_869a:
869a:    c0 00                  ld BL, 0x00

L_869c:
869c:    91 01 03               ld A, [CurrentProcess|0x0103]
869f:    5e                     mov Z, A
86a0:    8a                     ld AL, [X]
86a1:    28                     inc AL, #1
86a2:    14 04                  bz L_86a8
86a4:    29                     dec AL, #1
86a5:    a5 88 14               st AL, [Z + 0x14]

L_86a8:
86a8:    e5 88 13               st BL, [Z + 0x13]
86ab:    2a                     clr AL, #0
86ac:    a1 01 25               st AL, [0x0125]
86af:    47 5d 00 fb 80 00      unkblk5 0x01, 0xfb, [Z + 0x00]
86b5:    d5 88 08               ld B, [Z + 0x08]
86b8:    85 28 13               ld AL, [B + 0x13]
86bb:    2d                     sll AL, #1
86bc:    2c                     srl AL, #1
86bd:    a5 28 13               st AL, [B + 0x13]
86c0:    2e 0d f8 80 36         wpf 0xf8, [Z + 0x36]
86c5:    55 ba 82 0b            mov S, R_820b|0x820b
86c9:    79 85 8e               call R_858e
86cc:    8c                     ld AL, [Z]
86cd:    14 03                  bz L_86d2
86cf:    71 89 8e               jmp R_898e

L_86d2:
86d2:    71 87 57               jmp R_8757

R_86d5:
86d5:    01                     nop
86d6:    1c 01                  bs3 L_86d9
86d8:    1f

L_86d9:
86d9:    01                     nop
86da:    3b                     not A, #0

L_86db:
86db:    01                     nop
86dc:    3c                     srl A, #1
86dd:    01                     nop
86de:    3d                     sll A, #1
86df:    00                     HALT
86e0:    00                     HALT

R_86e1:
86e1:    3a                     clr A, #0
86e2:    85 41                  ld AL, [X++]

L_86e4:
86e4:    d0 01 00               ld B, 0x0100
86e7:    58                     add B, A
86e8:    f5 a2                  st B, [--S]
86ea:    d1 01 03               ld B, [CurrentProcess|0x0103]
86ed:    c5 28 01               ld BL, [B + 0x01]
86f0:    85 a4                  ld AL, @[S]
86f2:    49                     sub BL, AL
86f3:    15 05                  bnz L_86fa
86f5:    d5 a1                  ld B, [S++]
86f7:    09                     ret

L_86f8:
86f8:    7b 40                  call R_873a

L_86fa:
86fa:    85 a4                  ld AL, @[S]
86fc:    17 fa                  bp L_86f8
86fe:    91 01 03               ld A, [CurrentProcess|0x0103]
8701:    85 08 01               ld AL, [A + 0x01]
8704:    d5 a1                  ld B, [S++]
8706:    a9                     st AL, [B]
8707:    09                     ret

Syscall_06:
8708:    85 41                  ld AL, [X++]

Syscall_12:
870a:    a3 0d                  st AL, [L_8717+2|0x8719]
870c:    55 40                  mov A, X
870e:    51 10 7f ff            sub A, A, 0x7fff
8712:    17 03                  bp L_8717
8714:    79 85 72               call R_8572

L_8717:
8717:    90 00 00               ld A, 0x0000
871a:    7b c8                  call L_86e4
871c:    0f                     rsys

Syscall_Flush:
871d:    95 41                  ld A, [X++]
871f:    7b 03                  call L_8724
8721:    0f                     rsys

R_8722:
8722:    95 41                  ld A, [X++]

L_8724:
8724:    7e 01                  push {A}

L_8726:
8726:    85 a4                  ld AL, @[S]
8728:    17 0c                  bp L_8736
872a:    91 01 03               ld A, [CurrentProcess|0x0103]
872d:    95 08 32               ld A, [A + 0x32]
8730:    14 04                  bz L_8736
8732:    7b 06                  call R_873a
8734:    73 f0                  jmp L_8726

L_8736:
8736:    30 a1                  inc S, #2
8738:    4d                     mov BL, AL
8739:    09                     ret

R_873a:
873a:    2a                     clr AL, #0
873b:    a1 01 41               st AL, [Timeout|0x0141]
873e:    81 01 25               ld AL, [0x0125]
8741:    15 0e                  bnz L_8751
8743:    7b 12                  call R_8757
8745:    09                     ret
8746:    7e
8747:    81
8748:    55
8749:    89
874a:    01
874b:    03
874c:    79
874d:    88
874e:    6a
874f:    7f
8750:    81

L_8751:
8751:    09                     ret

Syscall_Yield:
8752:    7b e6                  call R_873a
8754:    0f                     rsys

UptimeDays:
8755:    00
8756:    00

R_8757:
8757:    d1 01 03               ld B, [CurrentProcess|0x0103]
875a:    f1 87 9b               st B, [R_879b|0x879b]
875d:    7e 45                  push {X, Y, Z}
875f:    55 a0                  mov A, S
8761:    b5 28 10               st A, [B + 0x10]
8764:    3a                     clr A, #0
8765:    b4 f1                  st A, [CurrentProcess (via R_8757+1)]
8767:    55 ba 82 83            mov S, R_8283|0x8283

R_876b:
876b:    60 89 a2               ld X, R_89a2|0x89a2

L_876e:
876e:    95 41                  ld A, [X++]
8770:    15 63                  bnz L_87d5
8772:    a1 01 41               st AL, [Timeout|0x0141]
8775:    7e 45                  push {X, Y, Z}
8777:    61 01 09               ld X, [DevicesPtr|0x0109]

L_877a:
877a:    d5 41                  ld B, [X++]
877c:    14 2a                  bz L_87a8
877e:    85 28 01               ld AL, [B + 0x01]
8781:    45 10                  mov AH, AL
8783:    80 02                  ld AL, 0x02
8785:    41 01                  sub AL, AH
8787:    14 06                  bz L_878f
8789:    80 05                  ld AL, 0x05
878b:    41 01                  sub AL, AH
878d:    15 eb                  bnz L_877a

L_878f:
878f:    95 28 0d               ld A, [B + 0x0d]
8792:    14 03                  bz L_8797
8794:    b1 87 9b               st A, [R_879b|0x879b]

L_8797:
8797:    85 28 34               ld AL, [B + 0x34]
879a:    90 00 00               ld A, 0x0000
879d:    b1 01 03               st A, [CurrentProcess|0x0103]
87a0:    7b 15                  call L_87b7
87a2:    3a                     clr A, #0
87a3:    b1 01 03               st A, [CurrentProcess|0x0103]
87a6:    73 d2                  jmp L_877a

L_87a8:
87a8:    7f 45                  pop {X, Y, Z}
87aa:    61 01 07               ld X, [0x0107]
87ad:    6b bd                  st X, [R_876b+1|0x876c]
87af:    82 01 6c               ld AL, @[0x016c]
87b2:    16 1a                  blt R_87ce
87b4:    71 88 a6               jmp R_88a6

L_87b7:
87b7:    55 26                  mov Y, B
87b9:    90 00 05               ld A, 0x0005	 ; Function #5
87bc:    7e 41                  push {X}
87be:    55 64                  mov X, Y	 ; X = device_obj
87c0:    79 80 25               call FindDeviceFunction
87c3:    7f 41                  pop {X}
87c5:    85 68 34               ld AL, [Y + 0x34]
87c8:    14 03                  bz L_87cd
87ca:    79 80 51               call ExecuteDeviceFunction

L_87cd:
87cd:    09                     ret

R_87ce:
87ce:    81 01 3e               ld AL, [0x013e]
87d1:    14 98                  bz R_876b
87d3:    73 1f                  jmp R_87f4

L_87d5:
87d5:    6b 95                  st X, [R_876b+1|0x876c]
87d7:    5e                     mov Z, A
87d8:    d0 04 00               ld B, 0x0400
87db:    cc                     ld BL, [Z]
87dc:    14 90                  bz L_876e
87de:    42 23                  and BL, BH
87e0:    15 8c                  bnz L_876e
87e2:    b1 01 03               st A, [CurrentProcess|0x0103]
87e5:    79 88 6a               call R_886a
87e8:    95 88 10               ld A, [Z + 0x10]
87eb:    15 03                  bnz L_87f0
87ed:    71 88 66               jmp R_8866

L_87f0:
87f0:    5f                     mov S, A
87f1:    7f 45                  pop {X, Y, Z}
87f3:    09                     ret

R_87f4:
87f4:    90 82 fb               ld A, R_82fb|0x82fb
87f7:    5f                     mov S, A
87f8:    61 01 09               ld X, [DevicesPtr|0x0109]
87fb:    2a                     clr AL, #0
87fc:    4c                     mov YL, AL
87fd:    80 c1                  ld AL, 0xc1
87ff:    45 10                  mov AH, AL

L_8801:
8801:    d5 41                  ld B, [X++]
8803:    15 03                  bnz L_8808
8805:    71 88 9a               jmp R_889a

L_8808:
8808:    20 70                  inc YL, #1
880a:    89                     ld AL, [B]
880b:    42 01                  and AL, AH
880d:    44 01                  xor AL, AH
880f:    15 f0                  bnz L_8801
8811:    85 28 13               ld AL, [B + 0x13]
8814:    19 eb                  ble L_8801
8816:    46 00 1c 01 01 3e      subbig(0, 0) 0x01, [0x013e]
881c:    2a                     clr AL, #0
881d:    a5 28 13               st AL, [B + 0x13]

R_8820:
8820:    f1 89 73               st B, [R_8973|0x8973]
8823:    45 71                  mov AL, YL
8825:    29                     dec AL, #1
8826:    a0 00                  st AL, 0x00
8828:    61 01 07               ld X, [0x0107]

L_882b:
882b:    95 41                  ld A, [X++]
882d:    15 03                  bnz L_8832
882f:    71 88 b2               jmp R_88b2

L_8832:
8832:    5e                     mov Z, A
8833:    95 88 08               ld A, [Z + 0x08]
8836:    51 20                  sub A, B
8838:    15 f1                  bnz L_882b
883a:    8c                     ld AL, [Z]
883b:    c0 40                  ld BL, 0x40
883d:    4a                     and BL, AL
883e:    15 b4                  bnz R_87f4

R_8840:
8840:    55 80                  mov A, Z
8842:    b1 01 03               st A, [CurrentProcess|0x0103]
8845:    7b 23                  call R_886a
8847:    80 01                  ld AL, 0x01
8849:    cc                     ld BL, [Z]
884a:    43 13                  or BL, AL
884c:    80 ef                  ld AL, 0xef
884e:    4a                     and BL, AL
884f:    ec                     st BL, [Z]
8850:    80 02                  ld AL, 0x02
8852:    c5 88 12               ld BL, [Z + 0x12]
8855:    43 13                  or BL, AL
8857:    e5 88 12               st BL, [Z + 0x12]
885a:    91 01 42               ld A, [0x0142]
885d:    b5 88 34               st A, [Z + 0x34]
8860:    90 ff ff               ld A, 0xffff
8863:    b5 88 32               st A, [Z + 0x32]

R_8866:
8866:    79 86 9a               call R_869a
8869:    ff                     st B, [P]

R_886a:
886a:    47 41 0f 01 85 80 36   memcpy 0x10, [R_0185|0x0185], [Z + 0x36]
8871:    2e 0d f8 80 36         wpf 0xf8, [Z + 0x36]
8876:    2e 0d fb 80 36         wpf 0xfb, [Z + 0x36]
887b:    2e 0c 7b 01 c5         wpf 0x7b, [R_01c5|0x01c5]
8880:    2e 0d fd 80 36         wpf 0xfd, [Z + 0x36]
8885:    2e 4d 84 80 46         wpf32 0x84, [Z + 0x46]
888a:    91 01 39               ld A, [0x0139]
888d:    14 0a                  bz L_8899
888f:    2e 4d 86 80 46         wpf32 0x86, [Z + 0x46]
8894:    2e 0c 7e 01 d5         wpf 0x7e, [R_01d5|0x01d5]

L_8899:
8899:    09                     ret

R_889a:
889a:    3a                     clr A, #0
889b:    a1 01 41               st AL, [Timeout|0x0141]
889e:    82 01 6c               ld AL, @[0x016c]
88a1:    17 03                  bp R_88a6
88a3:    71 87 6b               jmp R_876b

R_88a6:
88a6:    5c                     mov Y, A
88a7:    30 60                  inc Y, #1
88a9:    d1 01 09               ld B, [DevicesPtr|0x0109]
88ac:    3d                     sll A, #1
88ad:    58                     add B, A
88ae:    d9                     ld B, [B]
88af:    71 88 20               jmp R_8820

R_88b2:
88b2:    91 01 07               ld A, [0x0107]
88b5:    5c                     mov Y, A

L_88b6:
88b6:    95 61                  ld A, [Y++]
88b8:    15 03                  bnz L_88bd
88ba:    71 89 54               jmp R_8954

L_88bd:
88bd:    c8                     ld BL, [A]
88be:    15 f6                  bnz L_88b6
88c0:    5e                     mov Z, A
88c1:    95 88 0c               ld A, [Z + 0x0c]
88c4:    38                     inc A, #1
88c5:    d5 88 0a               ld B, [Z + 0x0a]
88c8:    59                     sub B, A
88c9:    34 2a                  srl B, #11
88cb:    31 20                  dec B, #1
88cd:    14 09                  bz L_88d8
88cf:    17 0e                  bp L_88df
88d1:    55 82                  mov B, Z
88d3:    79 a2 55               call R_a255
88d6:    16 7c                  blt R_8954

L_88d8:
88d8:    55 82                  mov B, Z
88da:    79 a2 55               call R_a255
88dd:    16 75                  blt R_8954

L_88df:
88df:    55 82                  mov B, Z
88e1:    79 a2 55               call R_a255
88e4:    16 6e                  blt R_8954
88e6:    79 88 6a               call R_886a
88e9:    d1 01 6c               ld B, [0x016c]
88ec:    30 20                  inc B, #1

L_88ee:
88ee:    89                     ld AL, [B]
88ef:    31 20                  dec B, #1
88f1:    a5 21                  st AL, [B++]
88f3:    16 04                  blt L_88f9
88f5:    30 20                  inc B, #1
88f7:    73 f5                  jmp L_88ee

L_88f9:
88f9:    d3 78                  ld B, [R_8973|0x8973]
88fb:    f5 88 08               st B, [Z + 0x08]
88fe:    85 28 1a               ld AL, [B + 0x1a]
8901:    a5 88 28               st AL, [Z + 0x28]
8904:    95 28 1f               ld A, [B + 0x1f]
8907:    14 06                  bz L_890f
8909:    8c                     ld AL, [Z]
890a:    c0 40                  ld BL, 0x40
890c:    43 13                  or BL, AL
890e:    ec                     st BL, [Z]

L_890f:
890f:    85 88 12               ld AL, [Z + 0x12]
8912:    c0 21                  ld BL, 0x21
8914:    53 02                  or B, A
8916:    e5 88 12               st BL, [Z + 0x12]
8919:    3a                     clr A, #0
891a:    b5 88 02               st A, [Z + 0x02]
891d:    b5 88 14               st A, [Z + 0x14]
8920:    32 20                  clr B, #0
8922:    c5 88 16               ld BL, [Z + 0x16]
8925:    77 32 00 0a            div B, B, 0x000a
8929:    55 20                  mov A, B
892b:    39                     dec A, #1
892c:    d5 88 17               ld B, [Z + 0x17]
892f:    67 9e a0 02            memset AL, 0xa0, [B]
8933:    95 88 04               ld A, [Z + 0x04]
8936:    5c                     mov Y, A
8937:    c1 88 27               ld BL, [R_8827|0x8827]
893a:    3a                     clr A, #0
893b:    3b                     not A, #0
893c:    e5 61                  st BL, [Y++]
893e:    b5 61                  st A, [Y++]
8940:    e5 61                  st BL, [Y++]
8942:    b5 61                  st A, [Y++]
8944:    e5 61                  st BL, [Y++]
8946:    b5 61                  st A, [Y++]
8948:    e5 61                  st BL, [Y++]
894a:    b5 61                  st A, [Y++]
894c:    55 80                  mov A, Z
894e:    b1 01 03               st A, [CurrentProcess|0x0103]
8951:    71 88 40               jmp R_8840

R_8954:
8954:    d1 01 6c               ld B, [0x016c]
8957:    81 88 27               ld AL, [R_8827|0x8827]
895a:    5c                     mov Y, A
895b:    89                     ld AL, [B]

L_895c:
895c:    41 71                  sub AL, YL
895e:    15 03                  bnz L_8963
8960:    71 87 ce               jmp R_87ce

L_8963:
8963:    85 21                  ld AL, [B++]
8965:    17 f5                  bp L_895c
8967:    31 20                  dec B, #1
8969:    45 71                  mov AL, YL
896b:    a9                     st AL, [B]
896c:    90 80 e3               ld A, R_80e3|0x80e3
896f:    b1 80 c5               st A, [R_80c5|0x80c5]
8972:    90 00 00               ld A, 0x0000
8975:    d0 80 bf               ld B, R_80bf|0x80bf
8978:    79 8c 30               call R_8c30

L_897b:
897b:    84 f9                  ld AL, @[0x8976]
897d:    16 fc                  blt L_897b
897f:    71 87 f4               jmp R_87f4

R_8982:
8982:    d1 01 03               ld B, [CurrentProcess|0x0103]
8985:    3a                     clr A, #0
8986:    85 28 01               ld AL, [B + 0x01]
8989:    d0 89 c7               ld B, R_89c7|0x89c7
898c:    58                     add B, A
898d:    09                     ret

R_898e:
898e:    55 ba 8a 21            mov S, R_8a21|0x8a21
8992:    79 86 e1               call R_86e1
8995:    3b                     not A, #0
8996:    55 ba 83 87            mov S, R_8387|0x8387
899a:    7b e6                  call R_8982
899c:    80 02                  ld AL, 0x02
899e:    a9                     st AL, [B]
899f:    3a                     clr A, #0
89a0:    66 04                  jsys Syscall_04

R_89a2:
89a2:    00 00                      arg1 = L_0000
89a4:    00 a0                      arg2 = L_00a0
89a6:    7f                         arg3 = (0x7f)
89a7:    fd                     st B, [S]
89a8:    fd                     st B, [S]
89a9:    fd                     st B, [S]
89aa:    fd                     st B, [S]
89ab:    fd                     st B, [S]
89ac:    fd                     st B, [S]
89ad:    fd                     st B, [S]
89ae:    fd                     st B, [S]
89af:    fd                     st B, [S]
89b0:    fd                     st B, [S]
89b1:    fd                     st B, [S]
89b2:    fd                     st B, [S]
89b3:    fd                     st B, [S]
89b4:    fd                     st B, [S]
89b5:    fd                     st B, [S]
89b6:    fd                     st B, [S]
89b7:    fd                     st B, [S]
89b8:    fd                     st B, [S]
89b9:    fd                     st B, [S]
89ba:    fd                     st B, [S]
89bb:    fd                     st B, [S]
89bc:    fd                     st B, [S]
89bd:    fd                     st B, [S]
89be:    fd                     st B, [S]
89bf:    fd                     st B, [S]
89c0:    fd                     st B, [S]
89c1:    fd                     st B, [S]
89c2:    fd                     st B, [S]
89c3:    fd                     st B, [S]
89c4:    fd                     st B, [S]
89c5:    fd                     st B, [S]
89c6:    fd                     st B, [S]

R_89c7:
89c7:    02                     sf
89c8:    02                     sf
89c9:    02                     sf
89ca:    02                     sf
89cb:    02                     sf
89cc:    02                     sf
89cd:    02                     sf
89ce:    02                     sf
89cf:    02                     sf
89d0:    02                     sf
89d1:    02                     sf
89d2:    02                     sf
89d3:    02                     sf
89d4:    02                     sf
89d5:    02                     sf
89d6:    02                     sf
89d7:    02                     sf
89d8:    02                     sf
89d9:    02                     sf
89da:    02                     sf
89db:    02                     sf
89dc:    02                     sf
89dd:    02                     sf
89de:    02                     sf
89df:    02                     sf
89e0:    02                     sf
89e1:    02                     sf
89e2:    02                     sf
89e3:    02                     sf
89e4:    02                     sf
89e5:    02                     sf
89e6:    02                     sf
89e7:    02                     sf
89e8:    02                     sf
89e9:    02                     sf
89ea:    02                     sf
89eb:    02                     sf
89ec:    02                     sf
89ed:    02                     sf
89ee:    02                     sf
89ef:    02                     sf
89f0:    02                     sf
89f1:    02                     sf
89f2:    02                     sf
89f3:    02                     sf
89f4:    02                     sf
89f5:    02                     sf
89f6:    02                     sf
89f7:    02                     sf
89f8:    02                     sf
89f9:    <null bytes>


R_8a21:
8a21:    8b 64                  Syscall_00
8a23:    00 00                  (0x0)
8a25:    8e 09                  Syscall_02
8a27:    00 00                  (0x0)
8a29:    8d d3                  Syscall_04
8a2b:    9c 54                  Syscall_05
8a2d:    87 08                  Syscall_06
8a2f:    87 52                  Syscall_Yield
8a31:    87 1d                  Syscall_Flush
8a33:    <null bytes>

8a35:    00 00                  (0x0)
8a37:    00 00                  (0x0)
8a39:    00 00                  (0x0)
8a3b:    00 00                  (0x0)
8a3d:    90 38                  Syscall_OpenFile?
8a3f:    00 00                  (0x0)
8a41:    8c 56                  Syscall_DoFileOp
8a43:    00 00                  (0x0)
8a45:    87 0a                  Syscall_12
8a47:    00 00                  (0x0)
8a49:    a5 df                  Syscall_CheckDiskStatus
8a4b:    00 00                  (0x0)
8a4d:    9d 60                  Syscall_16
8a4f:    9d c1                  Syscall_17
8a51:    93 ec                  Syscall_18
8a53:    8a d6                  Syscall_19
8a55:    00 00                  (0x0)
8a57:    a3 f3                  Syscall_GetUptimePtr
8ab1:    00 00                  (0x0)
8ab3:    00 00                  (0x0)
8ab5:    00 00                  (0x0)
8ab7:    00 00                  (0x0)
8ab9:    a5 b6                  Syscall_4c
8abb:    00 00                  (0x0)
8abd:    00 00                  (0x0)
8abf:    90 4b                  Syscall_OpenFileInDir
8acb:    00 00                  (0x0)
8acd:    00 00                  (0x0)
8acf:    00 00                  (0x0)
8ad1:    00 00                  (0x0)
8ad3:    a2 4d                  Syscall_59

R_8ad5:
8ad5:    59                     sub B, A

Syscall_19:
8ad6:    3a                     clr A, #0
8ad7:    39                     dec A, #1
8ad8:    7e 03                  push {A, B}
8ada:    79 86 e1               call R_86e1
8add:    1c 3a                  bs3 L_8b19
8adf:    71 9c 5b               jmp R_9c5b
8ae2:    7b
8ae3:    01
8ae4:    0f

R_8ae5:
8ae5:    7e 03                  push {A, B}
8ae7:    79 8b dc               call R_8bdc
8aea:    99                     ld A, [B]
8aeb:    dd                     ld B, [S]
8aec:    59                     sub B, A
8aed:    11 04                  bnc L_8af3

L_8aef:
8aef:    7f 03                  pop {A, B}
8af1:    3a                     clr A, #0
8af2:    09                     ret

L_8af3:
8af3:    d5 a8 02               ld B, [S + 0x02]
8af6:    b5 a2                  st A, [--S]
8af8:    3a                     clr A, #0
8af9:    39                     dec A, #1
8afa:    66 65                  jsys 0x65
8afc:    00                     HALT
8afd:    00                     HALT
8afe:    55 22                  mov B, B
8b00:    15 0e                  bnz L_8b10
8b02:    30 a1                  inc S, #2

L_8b04:
8b04:    30 a1                  inc S, #2
8b06:    95 a1                  ld A, [S++]
8b08:    98                     ld A, [A]

L_8b09:
8b09:    d0 ff ff               ld B, 0xffff
8b0c:    79 86 12               call R_8612
8b0f:    0a                     reti

L_8b10:
8b10:    d5 a1                  ld B, [S++]
8b12:    59                     sub B, A
8b13:    14 4a                  bz L_8b5f
8b15:    3a                     clr A, #0
8b16:    d5 a8 02               ld B, [S + 0x02]

L_8b19:
8b19:    66 65                  jsys 0x65
8b1b:    00                     HALT
8b1c:    00                     HALT
8b1d:    5d                     mov B, A
8b1e:    14 e4                  bz L_8b04
8b20:    d5 a8 02               ld B, [S + 0x02]
8b23:    b5 a2                  st A, [--S]
8b25:    3a                     clr A, #0
8b26:    85 28 01               ld AL, [B + 0x01]
8b29:    d1 01 03               ld B, [CurrentProcess|0x0103]
8b2c:    c5 28 06               ld BL, [B + 0x06]
8b2f:    2d                     sll AL, #1
8b30:    2c                     srl AL, #1
8b31:    10 02                  bc L_8b35
8b33:    40 31                  add AL, BL

L_8b35:
8b35:    77 10 00 03            div A, A, 0x0003
8b39:    94 ef                  ld A, [CurrentProcess (via 0x8b29+1)]
8b3b:    95 08 04               ld A, [A + 0x04]
8b3e:    38                     inc A, #1
8b3f:    58                     add B, A
8b40:    99                     ld A, [B]
8b41:    b3 13                  st A, [0x8b56]
8b43:    9d                     ld A, [S]
8b44:    b9                     st A, [B]
8b45:    d3 0f                  ld B, [0x8b56]
8b47:    47 45 18 20 02 00 02   memcpy 0x19, [B + 0x02], [A + 0x02]
8b4e:    47 9d 00 7e 00 ff      memset 0x01, 0x7e, [A + -0x1]
8b54:    66 17                  jsys Syscall_17
8b56:    00 00                      arg1 = (0x0)
8b58:    95 a1                  ld A, [S++]
8b5a:    98                     ld A, [A]
8b5b:    dd                     ld B, [S]
8b5c:    59                     sub B, A
8b5d:    10 90                  bc L_8aef

L_8b5f:
8b5f:    7f 03                  pop {A, B}
8b61:    3a                     clr A, #0
8b62:    39                     dec A, #1
8b63:    09                     ret

Syscall_00:
8b64:    55 20                  mov A, B
8b66:    79 a3 b2               call R_a3b2
8b69:    95 28 06               ld A, [B + 0x06]
8b6c:    7c f9                  call R_a3b2 (via 0x8b66+1)
8b6e:    7b 01                  call R_8b71
8b70:    0f                     rsys

R_8b71:
8b71:    7e 45                  push {X, Y, Z}
8b73:    55 28                  mov Z, B
8b75:    7b 65                  call R_8bdc
8b77:    5b                     mov X, A
8b78:    55 26                  mov Y, B
8b7a:    95 48 05               ld A, [X + 0x05]
8b7d:    15 04                  bnz R_8b83
8b7f:    79 86 12               call R_8612
8b82:    14

R_8b83:
8b83:    85 88 03               ld AL, [Z + 0x03]
8b86:    14 0f                  bz L_8b97
8b88:    79 80 1d               call R_801d
8b8b:    15 05                  bnz L_8b92
8b8d:    85 4c 03               ld AL, @[X + 0x03]
8b90:    14 19                  bz L_8bab

L_8b92:
8b92:    79 87 3a               call R_873a
8b95:    73 ec                  jmp R_8b83

L_8b97:
8b97:    55 46                  mov Y, X
8b99:    55 48                  mov Z, X
8b9b:    d1 01 03               ld B, [CurrentProcess|0x0103]
8b9e:    c5 28 01               ld BL, [B + 0x01]
8ba1:    20 30                  inc BL, #1
8ba3:    32 01                  clr A, #1
8ba5:    79 80 44               call CallDeviceFunctionInternal
8ba8:    7f 45                  pop {X, Y, Z}
8baa:    09                     ret

L_8bab:
8bab:    3a                     clr A, #0
8bac:    85 88 03               ld AL, [Z + 0x03]	 ; AL = function number
8baf:    a3 26                  st AL, [0x8bd7]	 ; Preserve function number
8bb1:    19 21                  ble L_8bd4
8bb3:    79 80 25               call FindDeviceFunction
8bb6:    15 1c                  bnz L_8bd4
8bb8:    f3 15                  st B, [0x8bcf]	 ; Preserve pointer to a function address
8bba:    14 18                  bz L_8bd4
8bbc:    91 01 03               ld A, [CurrentProcess|0x0103]
8bbf:    85 08 01               ld AL, [A + 0x01]
8bc2:    28                     inc AL, #1
8bc3:    79 80 15               call R_8015
8bc6:    a5 4c 03               st AL, @[X + 0x03]
8bc9:    80 80                  ld AL, 0x80
8bcb:    ac                     st AL, [Z]
8bcc:    55 40                  mov A, X
8bce:    d0 00 00               ld B, 0x0000	 ; B = pointer to a function address
8bd1:    71 80 51               jmp ExecuteDeviceFunction	 ; Make sure the current process is mapped and jump to [B]

L_8bd4:
8bd4:    9c                     ld A, [Z]
8bd5:    d0 00 00               ld B, 0x0000	 ; BL = preserved function number
8bd8:    79 86 12               call R_8612
8bdb:    23

R_8bdc:
8bdc:    6d a2                  st X, [--S]
8bde:    61 01 03               ld X, [CurrentProcess|0x0103]
8be1:    99                     ld A, [B]
8be2:    b3 0f                  st A, [R_8bf2+1|0x8bf3]
8be4:    3a                     clr A, #0
8be5:    85 28 01               ld AL, [B + 0x01]
8be8:    17 12                  bp L_8bfc
8bea:    2d                     sll AL, #1
8beb:    2c                     srl AL, #1
8bec:    c5 48 06               ld BL, [X + 0x06]
8bef:    49                     sub BL, AL
8bf0:    16 0f                  blt L_8c01

R_8bf2:
8bf2:    90 00 00               ld A, 0x0000
8bf5:    d0 ff ff               ld B, 0xffff
8bf8:    79 86 12               call R_8612
8bfb:    0a                     reti

L_8bfc:
8bfc:    c5 48 06               ld BL, [X + 0x06]
8bff:    40 31                  add AL, BL

L_8c01:
8c01:    c5 48 07               ld BL, [X + 0x07]
8c04:    49                     sub BL, AL
8c05:    18 eb                  bgt R_8bf2
8c07:    5d                     mov B, A
8c08:    3d                     sll A, #1
8c09:    58                     add B, A
8c0a:    65 48 04               ld X, [X + 0x04]
8c0d:    50 24                  add X, B
8c0f:    3a                     clr A, #0
8c10:    85 41                  ld AL, [X++]
8c12:    16 de                  blt R_8bf2
8c14:    3d                     sll A, #1
8c15:    d1 01 09               ld B, [DevicesPtr|0x0109]
8c18:    58                     add B, A
8c19:    d9                     ld B, [B]
8c1a:    f5 a2                  st B, [--S]
8c1c:    89                     ld AL, [B]
8c1d:    14 d3                  bz R_8bf2
8c1f:    d0 00 10               ld B, 0x0010
8c22:    4a                     and BL, AL
8c23:    14 06                  bz L_8c2b
8c25:    9a                     ld A, [X]
8c26:    5d                     mov B, A
8c27:    38                     inc A, #1
8c28:    15 01                  bnz L_8c2b
8c2a:    5d                     mov B, A

L_8c2b:
8c2b:    95 a1                  ld A, [S++]
8c2d:    65 a1                  ld X, [S++]
8c2f:    09                     ret

R_8c30:
8c30:    7e 45                  push {X, Y, Z}
8c32:    5b                     mov X, A
8c33:    55 28                  mov Z, B
8c35:    8a                     ld AL, [X]
8c36:    c0 80                  ld BL, 0x80
8c38:    4a                     and BL, AL
8c39:    15 09                  bnz L_8c44
8c3b:    55 40                  mov A, X
8c3d:    d0 ff ff               ld B, 0xffff
8c40:    79 86 12               call R_8612
8c43:    0b                     rim

L_8c44:
8c44:    85 48 11               ld AL, [X + 0x11]
8c47:    14 0a                  bz L_8c53
8c49:    2a                     clr AL, #0
8c4a:    a5 48 11               st AL, [X + 0x11]
8c4d:    a5 4c 03               st AL, @[X + 0x03]
8c50:    a5 4c 14               st AL, @[X + 0x14]

L_8c53:
8c53:    71 8b 83               jmp R_8b83

Syscall_DoFileOp:
8c56:    55 20                  mov A, B
8c58:    79 a3 b2               call R_a3b2
8c5b:    95 28 06               ld A, [B + 0x06]
8c5e:    7c f9                  call R_a3b2 (via 0x8c58+1)
8c60:    7b 01                  call R_8c63
8c62:    0f                     rsys

R_8c63:
8c63:    f5 a2                  st B, [--S]
8c65:    99                     ld A, [B]
8c66:    b1 8b f3               st A, [R_8bf2+1|0x8bf3]
8c69:    79 8b dc               call R_8bdc
8c6c:    f5 a2                  st B, [--S]
8c6e:    d5 08 01               ld B, [A + 0x01]
8c71:    c0 04                  ld BL, 0x04
8c73:    41 23                  sub BL, BH
8c75:    14 07                  bz L_8c7e
8c77:    d5 a1                  ld B, [S++]
8c79:    d5 a1                  ld B, [S++]
8c7b:    71 8b 71               jmp R_8b71

L_8c7e:
8c7e:    79 8e 90               call R_8e90
8c81:    c5 08 02               ld BL, [A + 0x02]
8c84:    e1 8d 43               st BL, [R_8d43|0x8d43]
8c87:    9d                     ld A, [S]
8c88:    15 03                  bnz L_8c8d
8c8a:    71 8b f2               jmp R_8bf2

L_8c8d:
8c8d:    b1 8d 3f               st A, [R_8d3f|0x8d3f]
8c90:    85 08 06               ld AL, [A + 0x06]
8c93:    d0 00 0f               ld B, 0x000f
8c96:    5a                     and B, A
8c97:    f3 2c                  st B, [0x8cc5]
8c99:    80 02                  ld AL, 0x02
8c9b:    49                     sub BL, AL
8c9c:    15 25                  bnz L_8cc3
8c9e:    95 a1                  ld A, [S++]
8ca0:    dd                     ld B, [S]
8ca1:    6d a0                  st X, [S]
8ca3:    5b                     mov X, A
8ca4:    55 60                  mov A, Y
8ca6:    b5 a2                  st A, [--S]
8ca8:    55 80                  mov A, Z
8caa:    b5 a2                  st A, [--S]
8cac:    55 28                  mov Z, B
8cae:    95 88 06               ld A, [Z + 0x06]
8cb1:    5c                     mov Y, A
8cb2:    90 01 00               ld A, 0x0100
8cb5:    85 88 03               ld AL, [Z + 0x03]
8cb8:    b3 0b                  st A, [0x8cc5]
8cba:    29                     dec AL, #1
8cbb:    14 0e                  bz L_8ccb
8cbd:    29                     dec AL, #1
8cbe:    15 03                  bnz L_8cc3
8cc0:    71 8d 67               jmp R_8d67

L_8cc3:
8cc3:    9c                     ld A, [Z]
8cc4:    d0 00 00               ld B, 0x0000
8cc7:    79 86 12               call R_8612
8cca:    0c                     unknown_0c

L_8ccb:
8ccb:    7b 7d                  call L_8d4a
8ccd:    14 04                  bz L_8cd3

L_8ccf:
8ccf:    80 01                  ld AL, 0x01
8cd1:    73 51                  jmp R_8d24

L_8cd3:
8cd3:    7b 5e                  call L_8d33
8cd5:    01                     nop
8cd6:    91 01 1d               ld A, [0x011d]
8cd9:    d5 48 0b               ld B, [X + 0x0b]
8cdc:    58                     add B, A
8cdd:    99                     ld A, [B]
8cde:    80 84                  ld AL, 0x84
8ce0:    41 01                  sub AL, AH
8ce2:    14 eb                  bz L_8ccf
8ce4:    f5 a2                  st B, [--S]
8ce6:    90 8d 00               ld A, 0x8d00
8ce9:    85 21                  ld AL, [B++]
8ceb:    41 01                  sub AL, AH
8ced:    15 0e                  bnz L_8cfd
8cef:    95 a1                  ld A, [S++]
8cf1:    93 51                  ld A, [0x8d44]
8cf3:    38                     inc A, #1
8cf4:    b5 48 09               st A, [X + 0x09]
8cf7:    3a                     clr A, #0
8cf8:    b5 48 0b               st A, [X + 0x0b]
8cfb:    73 ce                  jmp L_8ccb

L_8cfd:
8cfd:    85 21                  ld AL, [B++]
8cff:    41 01                  sub AL, AH
8d01:    15 fa                  bnz L_8cfd
8d03:    91 01 1d               ld A, [0x011d]
8d06:    51 20                  sub A, B
8d08:    b5 48 0b               st A, [X + 0x0b]
8d0b:    95 a1                  ld A, [S++]
8d0d:    5b                     mov X, A
8d0e:    51 20                  sub A, B
8d10:    39                     dec A, #1
8d11:    d5 88 04               ld B, [Z + 0x04]
8d14:    59                     sub B, A
8d15:    19 03                  ble L_8d1a
8d17:    95 88 04               ld A, [Z + 0x04]

L_8d1a:
8d1a:    b5 61                  st A, [Y++]

L_8d1c:
8d1c:    c5 41                  ld BL, [X++]
8d1e:    e5 61                  st BL, [Y++]
8d20:    39                     dec A, #1
8d21:    18 f9                  bgt L_8d1c
8d23:    ab                     st AL, [Y]

R_8d24:
8d24:    c0 ff                  ld BL, 0xff
8d26:    e1 01 3b               st BL, [0x013b]

R_8d29:
8d29:    ac                     st AL, [Z]
8d2a:    95 a1                  ld A, [S++]
8d2c:    5e                     mov Z, A
8d2d:    95 a1                  ld A, [S++]
8d2f:    5c                     mov Y, A
8d30:    65 a1                  ld X, [S++]
8d32:    09                     ret

L_8d33:
8d33:    85 41                  ld AL, [X++]
8d35:    a3 11                  st AL, [0x8d48]
8d37:    91 01 1d               ld A, [0x011d]
8d3a:    b3 0a                  st A, [0x8d46]
8d3c:    79 a6 0d               call R_a60d

R_8d3f:
8d3f:    00                     HALT
8d40:    00                     HALT
8d41:    01                     nop
8d42:    90 00 00               ld A, 0x0000
8d45:    00                     HALT
8d46:    00                     HALT
8d47:    00                     HALT
8d48:    00                     HALT
8d49:    09                     ret

L_8d4a:
8d4a:    9d                     ld A, [S]
8d4b:    95 08 09               ld A, [A + 0x09]
8d4e:    b3 f4                  st A, [0x8d44]
8d50:    d5 88 06               ld B, [Z + 0x06]
8d53:    f5 a2                  st B, [--S]
8d55:    d1 01 1d               ld B, [0x011d]
8d58:    f5 88 06               st B, [Z + 0x06]
8d5b:    55 82                  mov B, Z
8d5d:    79 8a e5               call R_8ae5
8d60:    d5 a1                  ld B, [S++]
8d62:    f5 88 06               st B, [Z + 0x06]
8d65:    5d                     mov B, A
8d66:    09                     ret

R_8d67:
8d67:    2a                     clr AL, #0
8d68:    db                     ld B, [Y]
8d69:    14 b9                  bz R_8d24
8d6b:    31 20                  dec B, #1
8d6d:    45 22                  mov BH, BH
8d6f:    14 04                  bz L_8d75
8d71:    32 02                  clr A, #2
8d73:    73 af                  jmp R_8d24

L_8d75:
8d75:    7b d3                  call L_8d4a
8d77:    15 3a                  bnz L_8db3
8d79:    7b b8                  call L_8d33
8d7b:    01                     nop
8d7c:    95 48 0b               ld A, [X + 0x0b]
8d7f:    d1 01 1d               ld B, [0x011d]
8d82:    58                     add B, A
8d83:    f5 a2                  st B, [--S]
8d85:    db                     ld B, [Y]
8d86:    58                     add B, A
8d87:    f5 48 0b               st B, [X + 0x0b]
8d8a:    90 01 8f               ld A, 0x018f
8d8d:    59                     sub B, A
8d8e:    17 0e                  bp L_8d9e
8d90:    95 a1                  ld A, [S++]
8d92:    3a                     clr A, #0
8d93:    b5 48 0b               st A, [X + 0x0b]
8d96:    93 ac                  ld A, [0x8d44]
8d98:    38                     inc A, #1
8d99:    b5 48 09               st A, [X + 0x09]
8d9c:    73 c9                  jmp R_8d67

L_8d9e:
8d9e:    65 a1                  ld X, [S++]
8da0:    95 61                  ld A, [Y++]
8da2:    39                     dec A, #1
8da3:    67 4a 64               memcpy AL, [Y], [X]
8da6:    38                     inc A, #1
8da7:    50 04                  add X, A
8da9:    c0 8d                  ld BL, 0x8d
8dab:    ea                     st BL, [X]
8dac:    7b 85                  call L_8d33
8dae:    02                     sf
8daf:    2a                     clr AL, #0
8db0:    71 8d 24               jmp R_8d24

L_8db3:
8db3:    80 ff                  ld AL, 0xff
8db5:    a1 01 3b               st AL, [0x013b]
8db8:    55 82                  mov B, Z
8dba:    66 19                  jsys Syscall_19
8dbc:    5d                     mov B, A
8dbd:    14 05                  bz L_8dc4
8dbf:    80 02                  ld AL, 0x02
8dc1:    71 8d 29               jmp R_8d29

L_8dc4:
8dc4:    79 8e 90               call R_8e90
8dc7:    55 82                  mov B, Z
8dc9:    79 8b dc               call R_8bdc
8dcc:    55 24                  mov X, B
8dce:    f1 8d 3f               st B, [R_8d3f|0x8d3f]
8dd1:    73 94                  jmp R_8d67

Syscall_04:
8dd3:    b3 0c                  st A, [L_8de0+1|0x8de1]
8dd5:    93 65                  ld A, [0x8e3c]
8dd7:    15 03                  bnz L_8ddc
8dd9:    79 8e 57               call R_8e57

L_8ddc:
8ddc:    93 03                  ld A, [L_8de0+1|0x8de1]
8dde:    17 0a                  bp L_8dea

L_8de0:
8de0:    90 00 00               ld A, 0x0000
8de3:    d0 ff ff               ld B, 0xffff
8de6:    79 86 12               call R_8612
8de9:    07                     rl

L_8dea:
8dea:    d1 01 14               ld B, [L_0114|0x0114]
8ded:    59                     sub B, A
8dee:    18 f0                  bgt L_8de0
8df0:    d1 01 18               ld B, [0x0118]
8df3:    f5 a2                  st B, [--S]
8df5:    3d                     sll A, #1
8df6:    d1 01 16               ld B, [0x0116]
8df9:    50 20                  add A, B
8dfb:    98                     ld A, [A]
8dfc:    14 e2                  bz L_8de0
8dfe:    32 20                  clr B, #0
8e00:    c1 01 05               ld BL, [0x0105]
8e03:    79 8e 90               call R_8e90
8e06:    71 8e 62               jmp R_8e62

Syscall_02:
8e09:    93 31                  ld A, [0x8e3c]
8e0b:    15 02                  bnz L_8e0f
8e0d:    7b 48                  call R_8e57

L_8e0f:
8e0f:    79 8e 90               call R_8e90
8e12:    79 89 82               call R_8982
8e15:    89                     ld AL, [B]
8e16:    a3 37                  st AL, [0x8e4f]
8e18:    80 02                  ld AL, 0x02
8e1a:    a9                     st AL, [B]
8e1b:    85 41                  ld AL, [X++]
8e1d:    a3 35                  st AL, [0x8e54]
8e1f:    17 17                  bp L_8e38
8e21:    91 01 03               ld A, [CurrentProcess|0x0103]
8e24:    d5 41                  ld B, [X++]
8e26:    f3 0a                  st B, [0x8e32]
8e28:    d5 08 1c               ld B, [A + 0x1c]
8e2b:    85 08 1b               ld AL, [A + 0x1b]
8e2e:    a3 24                  st AL, [0x8e54]
8e30:    66 64                  jsys 0x64
8e32:    00                     HALT
8e33:    00                     HALT
8e34:    00                     HALT
8e35:    00                     HALT
8e36:    73 06                  jmp L_8e3e

L_8e38:
8e38:    d5 41                  ld B, [X++]
8e3a:    66 0e                  jsys Syscall_OpenFile?
8e3c:    00 00                      arg1 = L_0000

L_8e3e:
8e3e:    15 09                  bnz L_8e49
8e40:    79 89 82               call R_8982
8e43:    83 0a                  ld AL, [0x8e4f]
8e45:    a9                     st AL, [B]
8e46:    71 8e 99               jmp R_8e99

L_8e49:
8e49:    b5 a2                  st A, [--S]
8e4b:    79 89 82               call R_8982
8e4e:    80 00                  ld AL, 0x00
8e50:    a9                     st AL, [B]
8e51:    3a                     clr A, #0
8e52:    5d                     mov B, A
8e53:    c0 00                  ld BL, 0x00
8e55:    73 0e                  jmp L_8e65

R_8e57:
8e57:    91 01 1d               ld A, [0x011d]
8e5a:    b3 d8                  st A, [0x8e34]
8e5c:    b3 de                  st A, [0x8e3c]
8e5e:    b1 8e cf               st A, [R_8ecf|0x8ecf]
8e61:    09                     ret

R_8e62:
8e62:    79 85 72               call R_8572

L_8e65:
8e65:    b3 66                  st A, [R_8ecd|0x8ecd]
8e67:    95 a1                  ld A, [S++]
8e69:    b3 5d                  st A, [R_8ec8|0x8ec8]
8e6b:    b1 8f 24               st A, [R_8f24|0x8f24]
8e6e:    e3 5c                  st BL, [R_8ecc|0x8ecc]
8e70:    f0 00 00               st B, 0x0000
8e73:    7e 63                  push {Y, Z}
8e75:    91 01 03               ld A, [CurrentProcess|0x0103]
8e78:    5c                     mov Y, A
8e79:    95 68 0c               ld A, [Y + 0x0c]
8e7c:    c3 f3                  ld BL, [R_8e71|0x8e71]
8e7e:    14 02                  bz L_8e82
8e80:    95 41                  ld A, [X++]

L_8e82:
8e82:    b1 8e fb               st A, [R_8ef9+2|0x8efb]
8e85:    c5 48 02               ld BL, [X + 0x02]
8e88:    15 16                  bnz L_8ea0
8e8a:    55 ba 85 03            mov S, R_8503|0x8503
8e8e:    73 10                  jmp L_8ea0

R_8e90:
8e90:    7e 03                  push {A, B}
8e92:    79 86 e1               call R_86e1
8e95:    3b                     not A, #0
8e96:    7f 03                  pop {A, B}
8e98:    09                     ret

R_8e99:
8e99:    3a                     clr A, #0
8e9a:    39                     dec A, #1
8e9b:    5d                     mov B, A
8e9c:    79 86 12               call R_8612
8e9f:    03                     rf

L_8ea0:
8ea0:    d5 68 0a               ld B, [Y + 0x0a]
8ea3:    83 cc                  ld AL, [R_8e71|0x8e71]
8ea5:    14 01                  bz L_8ea8
8ea7:    da                     ld B, [X]

L_8ea8:
8ea8:    95 41                  ld A, [X++]
8eaa:    14 08                  bz L_8eb4
8eac:    59                     sub B, A
8ead:    10 04                  bc L_8eb3

R_8eaf:
8eaf:    79 86 12               call R_8612
8eb2:    04                     ei

L_8eb3:
8eb3:    5d                     mov B, A

L_8eb4:
8eb4:    85 41                  ld AL, [X++]
8eb6:    6d a2                  st X, [--S]
8eb8:    a5 a2                  st AL, [--S]
8eba:    f3 58                  st B, [R_8f14|0x8f14]
8ebc:    f3 43                  st B, [R_8f01|0x8f01]

L_8ebe:
8ebe:    d3 0d                  ld B, [R_8ecd|0x8ecd]
8ec0:    94 06                  ld A, @[R_8ec8|0x8ec8]
8ec2:    59                     sub B, A
8ec3:    11 d4                  bnc R_8e99
8ec5:    79 a6 0d               call R_a60d

R_8ec8:
8ec8:    00                     HALT
8ec9:    00                     HALT
8eca:    01                     nop
8ecb:    90 00 00               ld A, 0x0000
8ece:    00                     HALT

R_8ecf:
8ecf:    00                     HALT
8ed0:    00                     HALT
8ed1:    01                     nop
8ed2:    30 10 8e cd            inc [R_8ecd|0x8ecd], #1
8ed6:    93 f7                  ld A, [R_8ecf|0x8ecf]
8ed8:    5e                     mov Z, A

R_8ed9:
8ed9:    3a                     clr A, #0
8eda:    8c                     ld AL, [Z]
8edb:    15 2a                  bnz L_8f07
8edd:    85 88 01               ld AL, [Z + 0x01]
8ee0:    14 25                  bz L_8f07
8ee2:    39                     dec A, #1
8ee3:    d5 88 02               ld B, [Z + 0x02]
8ee6:    58                     add B, A
8ee7:    f1 90 36               st B, [R_9036|0x9036]
8eea:    46 22 00 8f 13 90 35   addbig(2, 2) [R_8f13|0x8f13], [R_9035|0x9035]
8ef1:    c1 90 35               ld BL, [R_9035|0x9035]
8ef4:    15 6c                  bnz L_8f62
8ef6:    d1 90 36               ld B, [R_9036|0x9036]

R_8ef9:
8ef9:    51 3e 00 00            sub P, B, 0x0000
8efd:    11 4a                  bnc L_8f49
8eff:    51 3e 00 00            sub P, B, 0x0000
8f03:    17 02                  bp L_8f07
8f05:    f3 fa                  st B, [R_8f01|0x8f01]

L_8f07:
8f07:    47 02 8f 14 08         unkblk0 [R_8f14|0x8f14], [Z]
8f0c:    15 cb                  bnz R_8ed9
8f0e:    13 06                  bnn L_8f16
8f10:    66 09                  jsys 0x09
8f12:    03                     rf

R_8f13:
8f13:    00                     HALT

R_8f14:
8f14:    00                     HALT
8f15:    00                     HALT

L_8f16:
8f16:    10 a6                  bc L_8ebe

L_8f18:
8f18:    b5 a2                  st A, [--S]
8f1a:    91 9c 7c               ld A, [R_9c7c|0x9c7c]
8f1d:    d3 05                  ld B, [R_8f24|0x8f24]
8f1f:    59                     sub B, A
8f20:    18 04                  bgt L_8f26
8f22:    66 17                  jsys Syscall_17

R_8f24:
8f24:    00 00                      arg1 = (0x0)

L_8f26:
8f26:    93 d9                  ld A, [R_8f01|0x8f01]
8f28:    d5 68 0e               ld B, [Y + 0x0e]
8f2b:    59                     sub B, A
8f2c:    11 03                  bnc L_8f31
8f2e:    b5 68 0e               st A, [Y + 0x0e]

L_8f31:
8f31:    d5 a1                  ld B, [S++]
8f33:    80 ff                  ld AL, 0xff
8f35:    a1 01 3b               st AL, [0x013b]
8f38:    85 a1                  ld AL, [S++]
8f3a:    14 07                  bz L_8f43
8f3c:    65 a1                  ld X, [S++]
8f3e:    7f 63                  pop {Y, Z}
8f40:    93 bf                  ld A, [R_8f01|0x8f01]
8f42:    0f                     rsys

L_8f43:
8f43:    32 40                  clr X, #0
8f45:    93 ba                  ld A, [R_8f01|0x8f01]
8f47:    66 1a                  jsys 0x1a

L_8f49:
8f49:    81 8e 71               ld AL, [R_8e71|0x8e71]
8f4c:    14 03                  bz L_8f51
8f4e:    3a                     clr A, #0
8f4f:    73 c7                  jmp L_8f18

L_8f51:
8f51:    93 a8                  ld A, [R_8ef9+2|0x8efb]
8f53:    b1 90 36               st A, [R_9036|0x9036]
8f56:    46 12 0c 08 00 90      addbig(1, 2) 0x08, [0x0090]
8f5c:    35 81                  sll Z, #2
8f5e:    90 35 14               ld A, 0x3514
8f61:    07                     rl

L_8f62:
8f62:    32 10 90 35            clr [R_9035|0x9035], #0
8f66:    71 8e af               jmp R_8eaf
8f69:    91
8f6a:    90
8f6b:    36
8f6c:    b3 '3'
8f6d:    8d
8f6e:    7e
8f6f:    21
8f70:    91
8f71:    01
8f72:    03
8f73:    d0 'P'
8f74:    10
8f75:    00
8f76:    c8 'H'
8f77:    42
8f78:    23
8f79:    15
8f7a:    07
8f7b:    66
8f7c:    59
8f7d:    7f
8f7e:    21
8f7f:    71
8f80:    8e
8f81:    f9 'y'
8f82:    66
8f83:    5e
8f84:    5d
8f85:    16
8f86:    05
8f87:    7f
8f88:    21
8f89:    71
8f8a:    8e
8f8b:    f9 'y'
8f8c:    66
8f8d:    16
8f8e:    00
8f8f:    6e
8f90:    00
8f91:    00
8f92:    55
8f93:    a2 '"'
8f94:    93
8f95:    fa 'z'
8f96:    5f
8f97:    50
8f98:    ba ':'
8f99:    00
8f9a:    5a
8f9b:    47
8f9c:    4a
8f9d:    13
8f9e:    2a
8f9f:    7e
8fa0:    03
8fa1:    d1 'Q'
8fa2:    8f
8fa3:    14
8fa4:    f5 'u'
8fa5:    a2 '"'
8fa6:    d1 'Q'
8fa7:    8f
8fa8:    01
8fa9:    f5 'u'
8faa:    a2 '"'
8fab:    d1 'Q'
8fac:    8e
8fad:    c8 'H'
8fae:    f5 'u'
8faf:    a2 '"'
8fb0:    c1 'A'
8fb1:    8e
8fb2:    cc 'L'
8fb3:    e5 'e'
8fb4:    a2 '"'
8fb5:    d1 'Q'
8fb6:    8e
8fb7:    cd 'M'
8fb8:    f5 'u'
8fb9:    a2 '"'
8fba:    d1 'Q'
8fbb:    8e
8fbc:    cf 'O'
8fbd:    f5 'u'
8fbe:    a2 '"'
8fbf:    d3 'S'
8fc0:    74
8fc1:    f5 'u'
8fc2:    a2 '"'
8fc3:    c3 'C'
8fc4:    72
8fc5:    e5 'e'
8fc6:    a2 '"'
8fc7:    d1 'Q'
8fc8:    8e
8fc9:    fb '{'
8fca:    f5 'u'
8fcb:    a2 '"'
8fcc:    7e
8fcd:    81
8fce:    2a
8fcf:    29
8fd0:    a1 '!'
8fd1:    01
8fd2:    3b
8fd3:    66
8fd4:    59
8fd5:    79
8fd6:    86
8fd7:    e1 'a'
8fd8:    3b
8fd9:    7f
8fda:    81
8fdb:    d5 'U'
8fdc:    a1 '!'
8fdd:    f1 'q'
8fde:    8e
8fdf:    fb '{'
8fe0:    c5 'E'
8fe1:    a1 '!'
8fe2:    e3 'c'
8fe3:    53
8fe4:    d5 'U'
8fe5:    a1 '!'
8fe6:    f3 's'
8fe7:    4d
8fe8:    d5 'U'
8fe9:    a1 '!'
8fea:    f1 'q'
8feb:    8e
8fec:    cf 'O'
8fed:    f3 's'
8fee:    3e
8fef:    d5 'U'
8ff0:    a1 '!'
8ff1:    f1 'q'
8ff2:    8e
8ff3:    cd 'M'
8ff4:    f3 's'
8ff5:    35
8ff6:    c5 'E'
8ff7:    a1 '!'
8ff8:    e1 'a'
8ff9:    8e
8ffa:    cc 'L'
8ffb:    e3 'c'
8ffc:    2d
8ffd:    d5 'U'
8ffe:    a1 '!'
8fff:    f1 'q'
9000:    8e
9001:    c8 'H'
9002:    f1 'q'
9003:    8f
9004:    24
9005:    f3 's'
9006:    1f
9007:    d5 'U'
9008:    a1 '!'
9009:    f1 'q'
900a:    8f
900b:    01
900c:    d5 'U'
900d:    a1 '!'
900e:    f1 'q'
900f:    8f
9010:    14
9011:    7f
9012:    03
9013:    47
9014:    4a
9015:    13
9016:    a2 '"'
9017:    55
9018:    2a
9019:    b3 '3'
901a:    02
901b:    66
901c:    17
901d:    00
901e:    00
901f:    31
9020:    10
9021:    90
9022:    2b
9023:    79
9024:    a6 '&'
9025:    0d
9026:    00
9027:    00
9028:    01
9029:    90
902a:    00

R_902b:
902b:    00
902c:    00
902d:    00
902e:    00
902f:    01
9030:    7f
9031:    21
9032:    71
9033:    8e
9034:    d9 'Y'

R_9035:
9035:    00

R_9036:
9036:    00
9037:    00

Syscall_OpenFile?:
9038:    f5 a2                  st B, [--S]
903a:    a5 a2                  st AL, [--S]
903c:    79 86 e1               call R_86e1
903f:    3c                     srl A, #1
9040:    79 85 72               call R_8572
9043:    3a                     clr A, #0
9044:    a1 92 6a               st AL, [L_9269+1|0x926a]
9047:    5d                     mov B, A
9048:    71 90 61               jmp R_9061

Syscall_OpenFileInDir:
904b:    f5 a2                  st B, [--S]
904d:    a5 a2                  st AL, [--S]
904f:    79 86 e1               call R_86e1
9052:    3c                     srl A, #1
9053:    3a                     clr A, #0
9054:    b4 0c                  st A, [R_9237+1 (via R_9061+1)]
9056:    7c e9                  call R_8572 (via 0x9040+1)
9058:    32 20                  clr B, #0
905a:    e1 92 6a               st BL, [L_9269+1|0x926a]
905d:    95 41                  ld A, [X++]
905f:    73 03                  jmp L_9064

R_9061:
9061:    b1 92 38               st A, [R_9237+1|0x9238]

L_9064:
9064:    31 20                  dec B, #1
9066:    f1 91 59               st B, [R_9159|0x9159]
9069:    c0 0f                  ld BL, 0x0f
906b:    e1 92 c0               st BL, [R_92c0|0x92c0]
906e:    32 20                  clr B, #0
9070:    f1 93 3b               st B, [R_933b|0x933b]
9073:    b3 6f                  st A, [R_90e4|0x90e4]
9075:    b1 91 e1               st A, [L_91e0+1|0x91e1]
9078:    22 30                  clr BL, #0
907a:    85 a1                  ld AL, [S++]
907c:    17 02                  bp L_9080
907e:    4d                     mov BL, AL
907f:    2b                     not AL, #0

L_9080:
9080:    a1 92 2d               st AL, [R_922d|0x922d]
9083:    e1 92 5b               st BL, [L_925a+1|0x925b]
9086:    d5 a1                  ld B, [S++]
9088:    f1 91 9c               st B, [L_919b+1|0x919c]
908b:    d6 67 92 b7            st Y, [R_92b7|0x92b7]
908f:    d6 89 92 bb            st Z, [R_92bb|0x92bb]
9093:    79 cf 1d               call FindDiskDevice
9096:    3a                     clr A, #0
9097:    b1 92 9e               st A, [R_929e|0x929e]
909a:    95 41                  ld A, [X++]
909c:    15 0b                  bnz L_90a9
909e:    66 16                  jsys Syscall_16
90a0:    01 90                      arg1 = (0x190)
90a2:    00 00                      out = (0x0)
90a4:    93 fc                  ld A, [0x90a2]
90a6:    b1 92 9e               st A, [R_929e|0x929e]

L_90a9:
90a9:    b1 92 30               st A, [R_9230|0x9230]
90ac:    3a                     clr A, #0
90ad:    b1 92 7e               st A, [L_927d+1|0x927e]
90b0:    b1 80 bc               st A, [R_80bc|0x80bc]
90b3:    a1 80 be               st AL, [R_80be|0x80be]
90b6:    a1 91 48               st AL, [R_9148|0x9148]
90b9:    28                     inc AL, #1
90ba:    a1 92 32               st AL, [R_9232|0x9232]
90bd:    90 80 a1               ld A, R_80a1|0x80a1
90c0:    b1 92 29               st A, [R_9229|0x9229]
90c3:    90 00 0f               ld A, 0x000f
90c6:    b1 92 2e               st A, [R_922e|0x922e]
90c9:    79 92 26               call R_9226
90cc:    95 68 17               ld A, [Y + 0x17]
90cf:    b3 5d                  st A, [0x912e]
90d1:    69 92 b3               st X, [R_92b3|0x92b3]
90d4:    3a                     clr A, #0
90d5:    85 68 16               ld AL, [Y + 0x16]
90d8:    29                     dec AL, #1
90d9:    d1 92 30               ld B, [R_9230|0x9230]
90dc:    55 77 00 14            mov Y, [Y + 0x0014]
90e0:    79 80 0f               call R_800f
90e3:    90 00 00               ld A, 0x0000
90e6:    14 05                  bz L_90ed
90e8:    b1 92 29               st A, [R_9229|0x9229]
90eb:    73 53                  jmp R_9140

L_90ed:
90ed:    80 0e                  ld AL, 0x0e
90ef:    a1 92 2f               st AL, [R_922f|0x922f]
90f2:    79 92 26               call R_9226
90f5:    91 92 30               ld A, [R_9230|0x9230]
90f8:    5c                     mov Y, A
90f9:    85 68 08               ld AL, [Y + 0x08]
90fc:    28                     inc AL, #1
90fd:    14 04                  bz L_9103
90ff:    79 86 12               call R_8612
9102:    2f

L_9103:
9103:    95 68 06               ld A, [Y + 0x06]
9106:    3b                     not A, #0
9107:    c0 80                  ld BL, 0x80
9109:    07                     rl
910a:    36 00                  rrc A, #1
910c:    11 02                  bnc L_9110
910e:    43 30                  or AH, BL

L_9110:
9110:    d0 3c b1               ld B, 0x3cb1
9113:    44 32                  xor BH, BL
9115:    54 02                  xor B, A
9117:    93 15                  ld A, [0x912e]
9119:    59                     sub B, A
911a:    14 07                  bz L_9123
911c:    3a                     clr A, #0
911d:    39                     dec A, #1
911e:    5d                     mov B, A
911f:    79 86 12               call R_8612
9122:    30

L_9123:
9123:    95 68 04               ld A, [Y + 0x04]
9126:    44 10                  xor AH, AL
9128:    d0 3c b1               ld B, 0x3cb1
912b:    54 02                  xor B, A
912d:    90 00 00               ld A, 0x0000
9130:    58                     add B, A
9131:    90 10 00               ld A, 0x1000

L_9134:
9134:    35 20                  sll B, #1
9136:    37 00                  rlc A, #1
9138:    11 fa                  bnc L_9134
913a:    a1 80 bc               st AL, [R_80bc|0x80bc]
913d:    f1 80 bd               st B, [R_80bd|0x80bd]

R_9140:
9140:    3a                     clr A, #0
9141:    b1 92 2e               st A, [R_922e|0x922e]
9144:    79 92 26               call R_9226
9147:    80 00                  ld AL, 0x00
9149:    14 03                  bz L_914e
914b:    71 92 c1               jmp R_92c1

L_914e:
914e:    61 92 30               ld X, [R_9230|0x9230]
9151:    47 44 02 40 0d 92 34   memcpy 0x03, [X + 0x0d], [R_9234|0x9234]
9158:    90 00 00               ld A, 0x0000
915b:    16 1f                  blt L_917c
915d:    b1 92 2e               st A, [R_922e|0x922e]
9160:    3a                     clr A, #0
9161:    39                     dec A, #1
9162:    b3 f5                  st A, [R_9159|0x9159]
9164:    90 00 00               ld A, 0x0000
9167:    d1 92 30               ld B, [R_9230|0x9230]
916a:    58                     add B, A
916b:    55 24                  mov X, B
916d:    79 92 26               call R_9226
9170:    9a                     ld A, [X]

L_9171:
9171:    14 20                  bz L_9193
9173:    55 67 91 9c            mov Y, [L_919b+1|0x919c]
9177:    15 58                  bnz L_91d1
9179:    71 92 37               jmp R_9237

L_917c:
917c:    71 92 11               jmp R_9211

R_917f:
917f:    91 92 2e               ld A, [R_922e|0x922e]
9182:    38                     inc A, #1
9183:    b1 92 2e               st A, [R_922e|0x922e]
9186:    61 92 30               ld X, [R_9230|0x9230]
9189:    79 92 26               call R_9226

R_918c:
918c:    9a                     ld A, [X]
918d:    d0 84 8d               ld B, 0x848d
9190:    59                     sub B, A
9191:    15 08                  bnz L_919b

L_9193:
9193:    3a                     clr A, #0
9194:    b1 93 3b               st A, [R_933b|0x933b]
9197:    5d                     mov B, A
9198:    71 92 80               jmp R_9280

L_919b:
919b:    90 00 00               ld A, 0x0000
919e:    5c                     mov Y, A
919f:    55 48                  mov Z, X
91a1:    90 0a 00               ld A, 0x0a00

L_91a4:
91a4:    21 00                  dec AH, #1
91a6:    17 0b                  bp L_91b3
91a8:    85 61                  ld AL, [Y++]
91aa:    14 12                  bz L_91be
91ac:    c0 ae                  ld BL, 0xae
91ae:    49                     sub BL, AL
91af:    14 20                  bz L_91d1
91b1:    73 0b                  jmp L_91be

L_91b3:
91b3:    85 61                  ld AL, [Y++]
91b5:    15 09                  bnz L_91c0
91b7:    80 a0                  ld AL, 0xa0
91b9:    c5 81                  ld BL, [Z++]
91bb:    49                     sub BL, AL
91bc:    15 be                  bnz L_917c

L_91be:
91be:    73 77                  jmp R_9237

L_91c0:
91c0:    c5 81                  ld BL, [Z++]
91c2:    49                     sub BL, AL
91c3:    14 df                  bz L_91a4
91c5:    c0 ae                  ld BL, 0xae
91c7:    49                     sub BL, AL
91c8:    15 b2                  bnz L_917c
91ca:    80 a0                  ld AL, 0xa0
91cc:    c5 82                  ld BL, [--Z]
91ce:    49                     sub BL, AL
91cf:    15 40                  bnz R_9211

L_91d1:
91d1:    85 48 0d               ld AL, [X + 0x0d]
91d4:    c0 0f                  ld BL, 0x0f
91d6:    4a                     and BL, AL
91d7:    80 05                  ld AL, 0x05
91d9:    49                     sub BL, AL
91da:    14 04                  bz L_91e0

L_91dc:
91dc:    79 86 12               call R_8612
91df:    12

L_91e0:
91e0:    90 00 00               ld A, 0x0000
91e3:    15 f7                  bnz L_91dc
91e5:    93 47                  ld A, [R_922e|0x922e]
91e7:    77 10 00 19            div A, A, 0x0019
91eb:    93 43                  ld A, [R_9230|0x9230]
91ed:    51 40                  sub A, X
91ef:    34 03                  srl A, #4
91f1:    39                     dec A, #1
91f2:    58                     add B, A
91f3:    f1 92 7e               st B, [L_927d+1|0x927e]
91f6:    55 60                  mov A, Y
91f8:    b3 a2                  st A, [L_919b+1|0x919c]
91fa:    91 93 3b               ld A, [R_933b|0x933b]
91fd:    b5 a2                  st A, [--S]
91ff:    79 93 01               call R_9301
9202:    91 93 3b               ld A, [R_933b|0x933b]
9205:    b3 22                  st A, [R_9229|0x9229]
9207:    b3 d8                  st A, [L_91e0+1|0x91e1]
9209:    95 a1                  ld A, [S++]
920b:    b1 93 3b               st A, [R_933b|0x933b]
920e:    71 91 40               jmp R_9140

R_9211:
9211:    90 00 10               ld A, 0x0010
9214:    50 04                  add X, A
9216:    93 18                  ld A, [R_9230|0x9230]
9218:    d0 01 90               ld B, 0x0190
921b:    58                     add B, A
921c:    51 42                  sub B, X
921e:    16 03                  blt L_9223
9220:    71 91 7f               jmp R_917f

L_9223:
9223:    71 91 8c               jmp R_918c

R_9226:
9226:    79 a6 0d               call R_a60d

R_9229:
9229:    00                     HALT
922a:    00                     HALT
922b:    01                     nop
922c:    90 00 00               ld A, 0x0000

R_922f:
922f:    00                     HALT

R_9230:
9230:    00                     HALT
9231:    00                     HALT

R_9232:
9232:    01                     nop
9233:    09                     ret

R_9234:
9234:    00
9235:    00
9236:    00

R_9237:
9237:    90 00 00               ld A, 0x0000
923a:    14 1e                  bz L_925a
923c:    38                     inc A, #1
923d:    15 0a                  bnz L_9249
923f:    d3 72                  ld B, [R_92b3|0x92b3]
9241:    95 48 0e               ld A, [X + 0x0e]
9244:    b5 28 fa               st A, [B + -0x6]
9247:    73 0a                  jmp L_9253

L_9249:
9249:    39                     dec A, #1
924a:    b5 48 0e               st A, [X + 0x0e]
924d:    80 02                  ld AL, 0x02
924f:    a3 e1                  st AL, [R_9232|0x9232]
9251:    7b d3                  call R_9226

L_9253:
9253:    3a                     clr A, #0
9254:    39                     dec A, #1
9255:    b1 93 3b               st A, [R_933b|0x933b]
9258:    73 23                  jmp L_927d

L_925a:
925a:    80 00                  ld AL, 0x00
925c:    14 0b                  bz L_9269
925e:    93 ce                  ld A, [R_922e|0x922e]
9260:    b1 93 3b               st A, [R_933b|0x933b]
9263:    55 42                  mov B, X
9265:    f5 a2                  st B, [--S]
9267:    73 2f                  jmp L_9298

L_9269:
9269:    80 00                  ld AL, 0x00
926b:    14 0d                  bz L_927a
926d:    79 92 dd               call R_92dd
9270:    9b                     ld A, [Y]
9271:    b1 93 3b               st A, [R_933b|0x933b]
9274:    3a                     clr A, #0
9275:    39                     dec A, #1
9276:    b5 a2                  st A, [--S]
9278:    73 0d                  jmp L_9287

L_927a:
927a:    79 93 01               call R_9301

L_927d:
927d:    d0 00 00               ld B, 0x0000

R_9280:
9280:    f5 a2                  st B, [--S]
9282:    91 90 e4               ld A, [R_90e4|0x90e4]
9285:    15 11                  bnz L_9298

L_9287:
9287:    91 91 e1               ld A, [L_91e0+1|0x91e1]
928a:    14 0c                  bz L_9298
928c:    d1 93 3b               ld B, [R_933b|0x933b]
928f:    59                     sub B, A
9290:    14 06                  bz L_9298
9292:    b3 02                  st A, [0x9296]
9294:    66 17                  jsys Syscall_17
9296:    00 00                      arg1 = (0x0)

L_9298:
9298:    93 04                  ld A, [R_929e|0x929e]
929a:    14 04                  bz L_92a0
929c:    66 17                  jsys Syscall_17

R_929e:
929e:    00 00                      arg1 = (0x0)

L_92a0:
92a0:    3a                     clr A, #0
92a1:    39                     dec A, #1
92a2:    a1 01 3c               st AL, [0x013c]
92a5:    d3 91                  ld B, [R_9237+1|0x9238]
92a7:    14 07                  bz L_92b0
92a9:    30 20                  inc B, #1
92ab:    14 03                  bz L_92b0
92ad:    a1 01 1c               st AL, [0x011c]

L_92b0:
92b0:    d5 a1                  ld B, [S++]
92b2:    60 00 00               ld X, 0x0000
92b5:    55 76 00 00            mov Y, 0x0000
92b9:    55 98 00 00            mov Z, 0x0000
92bd:    91 93 3b               ld A, [R_933b|0x933b]

R_92c0:
92c0:    0f                     rsys

R_92c1:
92c1:    3a                     clr A, #0
92c2:    a1 91 48               st AL, [R_9148|0x9148]
92c5:    90 00 00               ld A, 0x0000
92c8:    d1 92 30               ld B, [R_9230|0x9230]
92cb:    47 4a 09 20            memcpy 0x0a, [B], [A]
92cf:    66 17                  jsys Syscall_17
92d1:    00 00                      arg1 = (0x0)
92d3:    3a                     clr A, #0
92d4:    39                     dec A, #1
92d5:    a1 01 3c               st AL, [0x013c]
92d8:    7f 45                  pop {X, Y, Z}
92da:    30 41                  inc X, #2
92dc:    0f                     rsys

R_92dd:
92dd:    6b 20                  st X, [0x92ff]
92df:    65 a1                  ld X, [S++]
92e1:    95 48 0b               ld A, [X + 0x0b]
92e4:    b1 92 2e               st A, [R_922e|0x922e]
92e7:    47 40 02 92 34 80 bc   memcpy 0x03, [R_9234|0x9234], [R_80bc|0x80bc]
92ee:    3a                     clr A, #0
92ef:    85 48 0a               ld AL, [X + 0x0a]
92f2:    5d                     mov B, A
92f3:    3d                     sll A, #1
92f4:    58                     add B, A
92f5:    91 92 30               ld A, [R_9230|0x9230]
92f8:    58                     add B, A
92f9:    55 26                  mov Y, B
92fb:    79 92 26               call R_9226
92fe:    71 00 00               jmp L_0000

R_9301:
9301:    69 93 e0               st X, [R_93e0|0x93e0]
9304:    65 a1                  ld X, [S++]
9306:    d5 48 0e               ld B, [X + 0x0e]
9309:    f3 6c                  st B, [0x9377]
930b:    47 48 09 40 93 e2      memcpy 0x0a, [X], [R_93e2|0x93e2]
9311:    85 48 0d               ld AL, [X + 0x0d]
9314:    a3 46                  st AL, [0x935c]
9316:    7b c5                  call R_92dd
9318:    93 21                  ld A, [R_933b|0x933b]
931a:    15 21                  bnz L_933d
931c:    c5 68 04               ld BL, [Y + 0x04]
931f:    9b                     ld A, [Y]
9320:    50 10 00 01            add A, A, 0x0001

L_9324:
9324:    21 30                  dec BL, #1
9326:    16 05                  blt L_932d
9328:    36 00                  rrc A, #1
932a:    07                     rl
932b:    73 f7                  jmp L_9324

L_932d:
932d:    38                     inc A, #1
932e:    5d                     mov B, A
932f:    3d                     sll A, #1
9330:    58                     add B, A
9331:    90 00 1b               ld A, 0x001b
9334:    58                     add B, A
9335:    f3 02                  st B, [0x9339]
9337:    66 16                  jsys Syscall_16
9339:    00 00                      arg1 = (0x0)

R_933b:
933b:    00 00                      out = (0x0)

L_933d:
933d:    63 fc                  ld X, [R_933b|0x933b]
933f:    93 f8                  ld A, [0x9339]
9341:    31 02                  dec A, #3
9343:    50 40                  add A, X
9345:    b3 6c                  st A, [L_93b2+1|0x93b3]
9347:    9b                     ld A, [Y]
9348:    b5 41                  st A, [X++]
934a:    95 68 02               ld A, [Y + 0x02]
934d:    3d                     sll A, #1
934e:    07                     rl
934f:    36 00                  rrc A, #1
9351:    b5 41                  st A, [X++]
9353:    85 68 04               ld AL, [Y + 0x04]
9356:    a5 41                  st AL, [X++]
9358:    2a                     clr AL, #0
9359:    a5 41                  st AL, [X++]
935b:    80 00                  ld AL, 0x00
935d:    a5 41                  st AL, [X++]
935f:    91 92 7e               ld A, [L_927d+1|0x927e]
9362:    b5 41                  st A, [X++]
9364:    3a                     clr A, #0
9365:    b5 41                  st A, [X++]
9367:    b5 41                  st A, [X++]
9369:    47 42 09 93 e2 04      memcpy 0x0a, [R_93e2|0x93e2], [X]
936f:    30 49                  inc X, #10
9371:    85 68 05               ld AL, [Y + 0x05]
9374:    a5 41                  st AL, [X++]
9376:    d0 00 00               ld B, 0x0000
9379:    f5 41                  st B, [X++]
937b:    3a                     clr A, #0
937c:    a5 41                  st AL, [X++]
937e:    90 00 03               ld A, 0x0003
9381:    50 06                  add Y, A
9383:    95 68 04               ld A, [Y + 0x04]
9386:    b0 00 00               st A, 0x0000

L_9389:
9389:    90 00 03               ld A, 0x0003
938c:    50 06                  add Y, A

L_938e:
938e:    9b                     ld A, [Y]
938f:    17 21                  bp L_93b2
9391:    3a                     clr A, #0
9392:    85 68 02               ld AL, [Y + 0x02]
9395:    28                     inc AL, #1
9396:    14 3e                  bz L_93d6
9398:    29                     dec AL, #1
9399:    5d                     mov B, A
939a:    3d                     sll A, #1
939b:    58                     add B, A
939c:    91 92 30               ld A, [R_9230|0x9230]
939f:    58                     add B, A
93a0:    9b                     ld A, [Y]
93a1:    55 26                  mov Y, B
93a3:    3b                     not A, #0
93a4:    d1 92 2e               ld B, [R_922e|0x922e]
93a7:    59                     sub B, A
93a8:    14 e4                  bz L_938e
93aa:    b1 92 2e               st A, [R_922e|0x922e]
93ad:    79 92 26               call R_9226
93b0:    73 dc                  jmp L_938e

L_93b2:
93b2:    d0 00 00               ld B, 0x0000
93b5:    51 42                  sub B, X
93b7:    14 1d                  bz L_93d6
93b9:    d1 91 e1               ld B, [L_91e0+1|0x91e1]
93bc:    15 09                  bnz L_93c7
93be:    b5 41                  st A, [X++]
93c0:    c5 68 02               ld BL, [Y + 0x02]
93c3:    e5 41                  st BL, [X++]
93c5:    73 c2                  jmp L_9389

L_93c7:
93c7:    95 68 01               ld A, [Y + 0x01]
93ca:    d1 91 e1               ld B, [L_91e0+1|0x91e1]
93cd:    79 cd 33               call R_cd33
93d0:    a5 41                  st AL, [X++]
93d2:    f5 41                  st B, [X++]
93d4:    73 b3                  jmp L_9389

L_93d6:
93d6:    3a                     clr A, #0
93d7:    39                     dec A, #1
93d8:    b5 41                  st A, [X++]
93da:    a5 41                  st AL, [X++]
93dc:    68 00 00               st X, 0x0000
93df:    71 00 00               jmp L_0000

R_93e2:
93e2:    <null bytes>


Syscall_18:
93ec:    7b 01                  call L_93ef
93ee:    0f                     rsys

L_93ef:
93ef:    7e 45                  push {X, Y, Z}
93f1:    55 28                  mov Z, B
93f3:    55 80                  mov A, Z
93f5:    79 9b 3d               call R_9b3d
93f8:    90 01 00               ld A, 0x0100
93fb:    b1 94 c7               st A, [R_94c7|0x94c7]
93fe:    95 88 0a               ld A, [Z + 0x0a]
9401:    45 02                  mov BH, AH
9403:    14 0b                  bz L_9410
9405:    79 9b 3d               call R_9b3d
9408:    5b                     mov X, A
9409:    22 11                  clr AL, #1
940b:    a1 94 8a               st AL, [L_9489+1|0x948a]
940e:    73 1e                  jmp L_942e

L_9410:
9410:    b1 94 c7               st A, [R_94c7|0x94c7]
9413:    c0 06                  ld BL, 0x06
9415:    59                     sub B, A
9416:    19 08                  ble L_9420

L_9418:
9418:    9c                     ld A, [Z]
9419:    d1 94 c7               ld B, [R_94c7|0x94c7]
941c:    79 86 12               call R_8612
941f:    0f                     rsys

L_9420:
9420:    30 10 94 c6            inc [R_94c6|0x94c6], #1
9424:    3d                     sll A, #1
9425:    d0 9b af               ld B, R_9baf|0x9baf
9428:    58                     add B, A
9429:    99                     ld A, [B]
942a:    5b                     mov X, A
942b:    2a                     clr AL, #0
942c:    a3 5c                  st AL, [L_9489+1|0x948a]

L_942e:
942e:    3a                     clr A, #0
942f:    85 88 03               ld AL, [Z + 0x03]
9432:    a1 94 c8               st AL, [R_94c8|0x94c8]
9435:    19 e1                  ble L_9418
9437:    c5 41                  ld BL, [X++]
9439:    49                     sub BL, AL
943a:    19 0f                  ble L_944b
943c:    c0 09                  ld BL, 0x09
943e:    49                     sub BL, AL
943f:    15 03                  bnz L_9444
9441:    71 94 ce               jmp R_94ce

L_9444:
9444:    c0 0a                  ld BL, 0x0a
9446:    49                     sub BL, AL
9447:    14 52                  bz R_949b
9449:    73

L_944a:
944a:    cd                     ld BL, [S]

L_944b:
944b:    5d                     mov B, A
944c:    39                     dec A, #1
944d:    3d                     sll A, #1
944e:    50 04                  add X, A
9450:    9a                     ld A, [X]
9451:    15 0a                  bnz L_945d
9453:    31 28                  dec B, #9
9455:    14 77                  bz R_94ce
9457:    31 20                  dec B, #1
9459:    14 40                  bz R_949b
945b:    73 bb                  jmp L_9418

L_945d:
945d:    30 10 94 c6            inc [R_94c6|0x94c6], #1
9461:    31 20                  dec B, #1
9463:    14 04                  bz L_9469
9465:    31 20                  dec B, #1
9467:    15 0c                  bnz L_9475

L_9469:
9469:    d5 88 03               ld B, [Z + 0x03]
946c:    c5 88 02               ld BL, [Z + 0x02]
946f:    42 23                  and BL, BH
9471:    14 a5                  bz L_9418
9473:    73 04                  jmp L_9479

L_9475:
9475:    31 26                  dec B, #7
9477:    14 10                  bz L_9489

L_9479:
9479:    d5 88 02               ld B, [Z + 0x02]
947c:    c0 20                  ld BL, 0x20
947e:    42 23                  and BL, BH
9480:    15 07                  bnz L_9489
9482:    9c                     ld A, [Z]
9483:    d5 a8 06               ld B, [S + 0x06]
9486:    7c 95                  call R_8612 (via 0x941c+1)
9488:    10

L_9489:
9489:    c0 00                  ld BL, 0x00
948b:    15 04                  bnz L_9491
948d:    55 82                  mov B, Z
948f:    75 00                  jmp [A]

L_9491:
9491:    5d                     mov B, A
9492:    7b 05                  call L_9499
9494:    30 a1                  inc S, #2
9496:    7f 45                  pop {X, Y, Z}
9498:    09                     ret

L_9499:
9499:    66 1a                  jsys 0x1a

R_949b:
949b:    55 82                  mov B, Z
949d:    79 8b dc               call R_8bdc
94a0:    95 08 01               ld A, [A + 0x01]
94a3:    80 09                  ld AL, 0x09
94a5:    41 01                  sub AL, AH
94a7:    15 05                  bnz L_94ae
94a9:    55 82                  mov B, Z
94ab:    79 8b 71               call R_8b71

L_94ae:
94ae:    85 88 02               ld AL, [Z + 0x02]
94b1:    c0 df                  ld BL, 0xdf
94b3:    4a                     and BL, AL
94b4:    e5 88 02               st BL, [Z + 0x02]

R_94b7:
94b7:    2a                     clr AL, #0
94b8:    71 96 b1               jmp R_96b1

L_94bb:
94bb:    c5 41                  ld BL, [X++]
94bd:    4a                     and BL, AL
94be:    14 06                  bz R_94c6
94c0:    42 23                  and BL, BH
94c2:    15 02                  bnz R_94c6
94c4:    73 5a                  jmp L_9520

R_94c6:
94c6:    09                     ret

R_94c7:
94c7:    00

R_94c8:
94c8:    00
94c9:    00

R_94ca:
94ca:    80 01                  ld AL, 0x01
94cc:    73 01                  jmp L_94cf

R_94ce:
94ce:    2a                     clr AL, #0

L_94cf:
94cf:    a3 6a                  st AL, [0x953b]
94d1:    55 82                  mov B, Z
94d3:    7c c9                  call R_8bdc (via 0x949d+1)
94d5:    5b                     mov X, A
94d6:    55 26                  mov Y, B
94d8:    32 10 94 c7            clr [R_94c7|0x94c7], #0
94dc:    85 88 02               ld AL, [Z + 0x02]
94df:    c0 20                  ld BL, 0x20
94e1:    43 13                  or BL, AL
94e3:    e5 88 02               st BL, [Z + 0x02]
94e6:    da                     ld B, [X]
94e7:    55 66                  mov Y, Y
94e9:    14 03                  bz L_94ee
94eb:    d5 68 05               ld B, [Y + 0x05]

L_94ee:
94ee:    f3 d8                  st B, [R_94c8|0x94c8]
94f0:    7b c9                  call L_94bb
94f2:    01                     nop
94f3:    7b c6                  call L_94bb
94f5:    02                     sf
94f6:    30 10 94 c6            inc [R_94c6|0x94c6], #1
94fa:    3a                     clr A, #0
94fb:    85 88 0c               ld AL, [Z + 0x0c]
94fe:    a3 c8                  st AL, [R_94c8|0x94c8]
9500:    16 1e                  blt L_9520
9502:    c0 02                  ld BL, 0x02
9504:    49                     sub BL, AL
9505:    18 19                  bgt L_9520
9507:    30 10 94 c6            inc [R_94c6|0x94c6], #1
950b:    3d                     sll A, #1
950c:    d0 9b 96               ld B, R_9b96|0x9b96
950f:    58                     add B, A
9510:    d9                     ld B, [B]
9511:    95 48 01               ld A, [X + 0x01]
9514:    b3 b2                  st A, [R_94c8|0x94c8]

L_9516:
9516:    85 21                  ld AL, [B++]
9518:    16 06                  blt L_9520
951a:    41 01                  sub AL, AH
951c:    14 09                  bz L_9527
951e:    73 f6                  jmp L_9516

L_9520:
9520:    9c                     ld A, [Z]
9521:    d3 a4                  ld B, [R_94c7|0x94c7]
9523:    79 86 12               call R_8612
9526:    11 80                  bnc L_94a8
9528:    09                     ret
9529:    41
952a:    01
952b:    15
952c:    08
952d:    55
952e:    82
952f:    79
9530:    8b
9531:    71
9532:    71
9533:    95
9534:    ee 'n'
9535:    90
9536:    03
9537:    00
9538:    b3 '3'
9539:    8d
953a:    80
953b:    00
953c:    14
953d:    4c
953e:    7b
953f:    6f
9540:    85
9541:    88
9542:    0d
9543:    c0 '@'
9544:    06
9545:    49
9546:    15
9547:    2c
9548:    95
9549:    88
954a:    06
954b:    79
954c:    9b
954d:    6f
954e:    47
954f:    45
9550:    05
9551:    00
9552:    02
9553:    80
9554:    1e
9555:    c5 'E'
9556:    08
9557:    02
9558:    15
9559:    11
955a:    46
955b:    22
955c:    34
955d:    00
955e:    02
955f:    95
9560:    ac ','
9561:    46
9562:    22
9563:    04
9564:    00
9565:    0b
9566:    95
9567:    ac ','
9568:    c1 'A'
9569:    95
956a:    ac ','
956b:    e5 'e'
956c:    88
956d:    31
956e:    95
956f:    08
9570:    05
9571:    b5 '5'
9572:    88
9573:    1c
9574:    95
9575:    88
9576:    1c
9577:    39
9578:    78

L_9579:
9579:    12 01                  bn L_957c
957b:    90

L_957c:
957c:    30 21                  inc B, #2
957e:    77 32 01 90            div B, B, 0x0190
9582:    95 88 04               ld A, [Z + 0x04]
9585:    59                     sub B, A
9586:    15 98                  bnz L_9520
9588:    73 64                  jmp R_95ee
958a:    85
958b:    88
958c:    01
958d:    17
958e:    19
958f:    55
9590:    82
9591:    79
9592:    8b
9593:    dc '\'
9594:    55
9595:    26
9596:    14
9597:    56
9598:    95
9599:    68
959a:    09
959b:    b5 '5'
959c:    88
959d:    12
959e:    b5 '5'
959f:    88
95a0:    16
95a1:    95
95a2:    68
95a3:    0b
95a4:    7b
95a5:    21
95a6:    73
95a7:    46
95a8:    7b
95a9:    05
95aa:    73
95ab:    42

R_95ac:
95ac:    00
95ad:    00
95ae:    00

R_95af:
95af:    55 82                  mov B, Z
95b1:    7c df                  call @[0x9592]
95b3:    55 26                  mov Y, B
95b5:    14 36                  bz L_95ed
95b7:    3a                     clr A, #0
95b8:    b5 68 09               st A, [Y + 0x09]
95bb:    b5 88 12               st A, [Z + 0x12]
95be:    b5 88 16               st A, [Z + 0x16]
95c1:    95 68 02               ld A, [Y + 0x02]
95c4:    b5 68 0b               st A, [Y + 0x0b]
95c7:    b5 88 14               st A, [Z + 0x14]
95ca:    b5 88 18               st A, [Z + 0x18]
95cd:    85 68 06               ld AL, [Y + 0x06]
95d0:    c0 0f                  ld BL, 0x0f
95d2:    4a                     and BL, AL
95d3:    85 88 0d               ld AL, [Z + 0x0d]
95d6:    16 0b                  blt L_95e3
95d8:    49                     sub BL, AL
95d9:    14 08                  bz L_95e3
95db:    49                     sub BL, AL
95dc:    45 12                  mov BH, AL
95de:    9c                     ld A, [Z]
95df:    79 86 12               call R_8612
95e2:    12

L_95e3:
95e3:    95 88 06               ld A, [Z + 0x06]
95e6:    14 05                  bz L_95ed
95e8:    79 9b 6f               call R_9b6f
95eb:    7b 04                  call R_95f1

L_95ed:
95ed:    09                     ret

R_95ee:
95ee:    7f 45                  pop {X, Y, Z}
95f0:    09                     ret

R_95f1:
95f1:    55 82                  mov B, Z
95f3:    95 88 16               ld A, [Z + 0x16]
95f6:    79 8a e5               call R_8ae5
95f9:    14 04                  bz L_95ff
95fb:    80 01                  ld AL, 0x01
95fd:    73 14                  jmp L_9613

L_95ff:
95ff:    95 88 16               ld A, [Z + 0x16]
9602:    b5 88 12               st A, [Z + 0x12]
9605:    b5 88 08               st A, [Z + 0x08]
9608:    7b 15                  call R_961f
960a:    01                     nop
960b:    d5 88 12               ld B, [Z + 0x12]
960e:    30 20                  inc B, #1
9610:    f5 88 16               st B, [Z + 0x16]

L_9613:
9613:    ac                     st AL, [Z]
9614:    09                     ret

L_9615:
9615:    d6 89 96 1c            st Z, [R_961c|0x961c]
9619:    79 87 22               call R_8722

R_961c:
961c:    00                     HALT
961d:    00                     HALT
961e:    09                     ret

R_961f:
961f:    85 41                  ld AL, [X++]
9621:    a5 88 03               st AL, [Z + 0x03]

R_9624:
9624:    55 82                  mov B, Z
9626:    79 8b 71               call R_8b71
9629:    7b ea                  call L_9615
962b:    09                     ret

R_962c:
962c:    80 01                  ld AL, 0x01
962e:    73 02                  jmp L_9632

R_9630:
9630:    80 02                  ld AL, 0x02

L_9632:
9632:    a5 88 03               st AL, [Z + 0x03]
9635:    95 88 0e               ld A, [Z + 0x0e]
9638:    b5 88 04               st A, [Z + 0x04]
963b:    95 88 10               ld A, [Z + 0x10]
963e:    79 9b 5e               call R_9b5e
9641:    b5 88 06               st A, [Z + 0x06]
9644:    55 82                  mov B, Z
9646:    7f 45                  pop {X, Y, Z}
9648:    f5 a2                  st B, [--S]
964a:    79 8c 63               call R_8c63
964d:    d5 a1                  ld B, [S++]
964f:    7e 81                  push {Z}
9651:    55 28                  mov Z, B
9653:    7b c0                  call L_9615
9655:    3a                     clr A, #0
9656:    b5 88 06               st A, [Z + 0x06]
9659:    7f 81                  pop {Z}
965b:    09                     ret

R_965c:
965c:    79 9a a3               call R_9aa3
965f:    5b                     mov X, A
9660:    47 8e 00 84 06         memcmp 0x01, 0x84, [Y]
9665:    14 12                  bz L_9679
9667:    47 8e 00 8d 06         memcmp 0x01, 0x8d, [Y]
966c:    15 0f                  bnz L_967d
966e:    79 95 f1               call R_95f1
9671:    15 3e                  bnz R_96b1
9673:    3a                     clr A, #0
9674:    b5 88 18               st A, [Z + 0x18]
9677:    73 e3                  jmp R_965c

L_9679:
9679:    80 01                  ld AL, 0x01
967b:    73 34                  jmp R_96b1

L_967d:
967d:    7e 81                  push {Z}
967f:    47 2a ff 8d 66         memchr 0x100, 0x8d, [Y], [Y]
9684:    7f 81                  pop {Z}
9686:    55 40                  mov A, X
9688:    51 64                  sub X, Y
968a:    5c                     mov Y, A
968b:    95 88 18               ld A, [Z + 0x18]
968e:    50 40                  add A, X
9690:    38                     inc A, #1
9691:    b5 88 18               st A, [Z + 0x18]

R_9694:
9694:    95 88 0e               ld A, [Z + 0x0e]
9697:    5d                     mov B, A
9698:    51 42                  sub B, X
969a:    19 01                  ble L_969d
969c:    5b                     mov X, A

L_969d:
969d:    55 62                  mov B, Y
969f:    95 88 10               ld A, [Z + 0x10]
96a2:    79 9b 5e               call R_9b5e
96a5:    5c                     mov Y, A
96a6:    6d 61                  st X, [Y++]
96a8:    55 40                  mov A, X
96aa:    39                     dec A, #1
96ab:    f7                     memcpy16
96ac:    38                     inc A, #1
96ad:    50 06                  add Y, A
96af:    2a                     clr AL, #0
96b0:    ab                     st AL, [Y]

R_96b1:
96b1:    ac                     st AL, [Z]
96b2:    71 95 ee               jmp R_95ee

R_96b5:
96b5:    95 88 10               ld A, [Z + 0x10]
96b8:    79 9b 5e               call R_9b5e
96bb:    5b                     mov X, A
96bc:    3a                     clr A, #0
96bd:    da                     ld B, [X]
96be:    14 f1                  bz R_96b1
96c0:    31 20                  dec B, #1
96c2:    45 22                  mov BH, BH
96c4:    14 04                  bz L_96ca
96c6:    32 02                  clr A, #2
96c8:    73 e7                  jmp R_96b1

L_96ca:
96ca:    79 9a b5               call R_9ab5
96cd:    da                     ld B, [X]
96ce:    58                     add B, A
96cf:    f5 88 18               st B, [Z + 0x18]
96d2:    51 32 01 8f            sub B, B, 0x018f
96d6:    17 0a                  bp L_96e2
96d8:    80 8d                  ld AL, 0x8d
96da:    ab                     st AL, [Y]
96db:    79 9a dc               call R_9adc
96de:    14 d5                  bz R_96b5
96e0:    73 cf                  jmp R_96b1

L_96e2:
96e2:    95 41                  ld A, [X++]
96e4:    39                     dec A, #1
96e5:    67 4a 46               memcpy AL, [X], [Y]
96e8:    38                     inc A, #1
96e9:    50 06                  add Y, A
96eb:    80 8d                  ld AL, 0x8d
96ed:    ab                     st AL, [Y]
96ee:    2a                     clr AL, #0
96ef:    73 c0                  jmp R_96b1

R_96f1:
96f1:    95 88 10               ld A, [Z + 0x10]
96f4:    79 9b 5e               call R_9b5e
96f7:    5b                     mov X, A
96f8:    95 88 06               ld A, [Z + 0x06]
96fb:    79 9b 6f               call R_9b6f
96fe:    30 01                  inc A, #2
9700:    5c                     mov Y, A
9701:    d5 88 14               ld B, [Z + 0x14]
9704:    50 26                  add Y, B
9706:    d0 8d 00               ld B, 0x8d00
9709:    95 41                  ld A, [X++]

L_970b:
970b:    cb                     ld BL, [Y]
970c:    41 23                  sub BL, BH
970e:    14 17                  bz L_9727
9710:    39                     dec A, #1
9711:    16 0b                  blt L_971e
9713:    ca                     ld BL, [X]
9714:    41 23                  sub BL, BH
9716:    14 06                  bz L_971e
9718:    c5 41                  ld BL, [X++]
971a:    e5 61                  st BL, [Y++]
971c:    73 ed                  jmp L_970b

L_971e:
971e:    80 a0                  ld AL, 0xa0
9720:    a5 61                  st AL, [Y++]
9722:    cb                     ld BL, [Y]
9723:    41 23                  sub BL, BH
9725:    15 f7                  bnz L_971e

L_9727:
9727:    95 88 12               ld A, [Z + 0x12]
972a:    b5 88 08               st A, [Z + 0x08]
972d:    79 96 1f               call R_961f
9730:    02                     sf
9731:    71 96 b1               jmp R_96b1

R_9734:
9734:    2a                     clr AL, #0
9735:    a5 a2                  st AL, [--S]
9737:    79 98 12               call R_9812
973a:    73 26                  jmp L_9762

R_973c:
973c:    80 01                  ld AL, 0x01
973e:    a5 a2                  st AL, [--S]
9740:    55 82                  mov B, Z
9742:    79 8b dc               call R_8bdc
9745:    95 88 06               ld A, [Z + 0x06]
9748:    79 9b 6f               call R_9b6f
974b:    79 98 6b               call R_986b
974e:    15 14                  bnz R_9764
9750:    95 88 16               ld A, [Z + 0x16]
9753:    b5 88 08               st A, [Z + 0x08]
9756:    79 98 3d               call R_983d
9759:    73 07                  jmp L_9762

R_975b:
975b:    80 01                  ld AL, 0x01
975d:    a5 a2                  st AL, [--S]
975f:    79 98 27               call R_9827

L_9762:
9762:    14 11                  bz L_9775

R_9764:
9764:    c5 a1                  ld BL, [S++]
9766:    15 0a                  bnz L_9772
9768:    c0 ff                  ld BL, 0xff
976a:    e1 01 3b               st BL, [0x013b]
976d:    32 20                  clr B, #0
976f:    f5 88 06               st B, [Z + 0x06]

L_9772:
9772:    71 96 b1               jmp R_96b1

L_9775:
9775:    95 88 0e               ld A, [Z + 0x0e]
9778:    b5 61                  st A, [Y++]
977a:    39                     dec A, #1
977b:    f7                     memcpy16
977c:    38                     inc A, #1
977d:    50 06                  add Y, A
977f:    2a                     clr AL, #0
9780:    ab                     st AL, [Y]
9781:    73 e1                  jmp R_9764

R_9783:
9783:    2a                     clr AL, #0
9784:    a5 a2                  st AL, [--S]
9786:    79 98 12               call R_9812
9789:    73 2c                  jmp L_97b7

R_978b:
978b:    80 01                  ld AL, 0x01
978d:    a5 a2                  st AL, [--S]
978f:    55 82                  mov B, Z
9791:    7c b0                  call R_8bdc (via 0x9742+1)
9793:    85 28 05               ld AL, [B + 0x05]
9796:    c0 04                  ld BL, 0x04
9798:    4a                     and BL, AL
9799:    14 1a                  bz L_97b5
979b:    95 88 06               ld A, [Z + 0x06]
979e:    79 9b 6f               call R_9b6f
97a1:    79 98 6b               call R_986b
97a4:    15 13                  bnz L_97b9
97a6:    95 88 16               ld A, [Z + 0x16]
97a9:    b5 88 08               st A, [Z + 0x08]
97ac:    79 98 3d               call R_983d
97af:    73 06                  jmp L_97b7

R_97b1:
97b1:    80 01                  ld AL, 0x01
97b3:    a5 a2                  st AL, [--S]

L_97b5:
97b5:    7b 70                  call R_9827

L_97b7:
97b7:    14 17                  bz L_97d0

L_97b9:
97b9:    8d                     ld AL, [S]
97ba:    15 05                  bnz L_97c1
97bc:    80 ff                  ld AL, 0xff
97be:    a1 01 3b               st AL, [0x013b]

L_97c1:
97c1:    7b 26                  call R_97e9
97c3:    15 9f                  bnz R_9764
97c5:    8d                     ld AL, [S]
97c6:    14 04                  bz L_97cc
97c8:    7b 5d                  call R_9827
97ca:    73 eb                  jmp L_97b7

L_97cc:
97cc:    7b 44                  call R_9812
97ce:    73 e7                  jmp L_97b7

L_97d0:
97d0:    55 60                  mov A, Y
97d2:    55 26                  mov Y, B
97d4:    5d                     mov B, A
97d5:    95 21                  ld A, [B++]
97d7:    95 88 0e               ld A, [Z + 0x0e]
97da:    18 04                  bgt L_97e0
97dc:    80 05                  ld AL, 0x05
97de:    73 84                  jmp R_9764

L_97e0:
97e0:    39                     dec A, #1
97e1:    f7                     memcpy16
97e2:    79 96 1f               call R_961f
97e5:    02                     sf
97e6:    71 97 64               jmp R_9764

R_97e9:
97e9:    55 82                  mov B, Z
97eb:    79 8b dc               call R_8bdc
97ee:    f5 a2                  st B, [--S]
97f0:    3a                     clr A, #0
97f1:    85 28 04               ld AL, [B + 0x04]
97f4:    d0 00 01               ld B, 0x0001

L_97f7:
97f7:    39                     dec A, #1
97f8:    16 04                  blt L_97fe
97fa:    35 20                  sll B, #1
97fc:    73 f9                  jmp L_97f7

L_97fe:
97fe:    95 a5                  ld A, @[S++]
9800:    50 20                  add A, B
9802:    d5 88 16               ld B, [Z + 0x16]
9805:    59                     sub B, A
9806:    11 07                  bnc L_980f
9808:    55 82                  mov B, Z
980a:    66 19                  jsys Syscall_19
980c:    5d                     mov B, A
980d:    14 02                  bz L_9811

L_980f:
980f:    80 02                  ld AL, 0x02

L_9811:
9811:    09                     ret

R_9812:
9812:    91 01 1d               ld A, [0x011d]
9815:    b5 88 06               st A, [Z + 0x06]
9818:    90 01 90               ld A, 0x0190
981b:    b5 88 04               st A, [Z + 0x04]
981e:    79 8e 90               call R_8e90
9821:    7b 48                  call R_986b
9823:    15 3d                  bnz L_9862
9825:    73 16                  jmp R_983d

R_9827:
9827:    95 88 06               ld A, [Z + 0x06]
982a:    79 9b 6f               call R_9b6f
982d:    7b 3c                  call R_986b
982f:    15 31                  bnz L_9862
9831:    95 88 12               ld A, [Z + 0x12]
9834:    d5 88 16               ld B, [Z + 0x16]
9837:    f5 88 08               st B, [Z + 0x08]
983a:    59                     sub B, A
983b:    14 05                  bz L_9842

R_983d:
983d:    79 95 f1               call R_95f1
9840:    15 20                  bnz L_9862

L_9842:
9842:    95 88 10               ld A, [Z + 0x10]
9845:    79 9b 5e               call R_9b5e
9848:    5c                     mov Y, A
9849:    95 88 1c               ld A, [Z + 0x1c]
984c:    d5 88 0e               ld B, [Z + 0x0e]
984f:    59                     sub B, A
9850:    10 03                  bc L_9855
9852:    b5 88 0e               st A, [Z + 0x0e]

L_9855:
9855:    d5 88 06               ld B, [Z + 0x06]
9858:    95 88 18               ld A, [Z + 0x18]
985b:    b5 88 14               st A, [Z + 0x14]
985e:    30 01                  inc A, #2
9860:    58                     add B, A
9861:    3a                     clr A, #0

L_9862:
9862:    09                     ret

R_9863:
9863:    00
9864:    00

R_9865:
9865:    00
9866:    00
9867:    00
9868:    00

R_9869:
9869:    00
986a:    00

R_986b:
986b:    95 88 0a               ld A, [Z + 0x0a]
986e:    31 05                  dec A, #6
9870:    15 20                  bnz L_9892
9872:    95 88 1a               ld A, [Z + 0x1a]
9875:    46 35 38 00 98 63      unkbig3(3, 5) [A], [R_9863|0x9863]
987b:    16 67                  blt L_98e4
987d:    46 15 54 80 1c 98 63   unkbig5(1, 5) [Z + 0x1c], [R_9863|0x9863]
9884:    12 5e                  bn L_98e4
9886:    90 98 69               ld A, R_9869|0x9869
9889:    46 15 7c 01 90 98      unkbig7(1, 5) 0x01, [0x9098]
988f:    63 73                  ld X, [0x9904]
9891:    2b                     not AL, #0

L_9892:
9892:    d0 01 90               ld B, 0x0190
9895:    78 93 00 1c            mul B, [Z + 0x001c], B
9899:    12 49                  bn L_98e4
989b:    f3 cc                  st B, [R_9869|0x9869]
989d:    14 45                  bz L_98e4
989f:    95 88 1a               ld A, [Z + 0x1a]
98a2:    46 35 38 00 98 63      unkbig3(3, 5) [A], [R_9863|0x9863]
98a8:    16 3a                  blt L_98e4
98aa:    90 98 69               ld A, R_9869|0x9869
98ad:    46 15 70 98 69 98 63   unkbig7(1, 5) [R_9869|0x9869], [R_9863|0x9863]
98b4:    46 11 54 80 1c 98 69   unkbig5(1, 1) [Z + 0x1c], [R_9869|0x9869]
98bb:    12 27                  bn L_98e4
98bd:    d3 aa                  ld B, [R_9869|0x9869]
98bf:    f5 88 18               st B, [Z + 0x18]
98c2:    91 98 63               ld A, [R_9863|0x9863]
98c5:    15 1d                  bnz L_98e4
98c7:    91 98 65               ld A, [R_9865|0x9865]
98ca:    15 18                  bnz L_98e4
98cc:    d3 99                  ld B, [0x9867]

L_98ce:
98ce:    7b 1a                  call L_98ea
98d0:    b5 a2                  st A, [--S]
98d2:    79 8a e5               call R_8ae5
98d5:    14 06                  bz L_98dd

L_98d7:
98d7:    80 01                  ld AL, 0x01
98d9:    dd                     ld B, [S]
98da:    f5 88 12               st B, [Z + 0x12]

L_98dd:
98dd:    d5 a1                  ld B, [S++]
98df:    f5 88 08               st B, [Z + 0x08]
98e2:    4d                     mov BL, AL
98e3:    09                     ret

L_98e4:
98e4:    3a                     clr A, #0
98e5:    39                     dec A, #1
98e6:    b5 a2                  st A, [--S]
98e8:    73 ed                  jmp L_98d7

L_98ea:
98ea:    f5 88 16               st B, [Z + 0x16]
98ed:    d5 88 04               ld B, [Z + 0x04]
98f0:    14 06                  bz L_98f8
98f2:    31 20                  dec B, #1
98f4:    78 32 01 90            mul B, B, 0x0190

L_98f8:
98f8:    95 88 16               ld A, [Z + 0x16]
98fb:    50 20                  add A, B
98fd:    55 82                  mov B, Z
98ff:    09                     ret

L_9900:
9900:    d5 88 1a               ld B, [Z + 0x1a]
9903:    95 21                  ld A, [B++]
9905:    d9                     ld B, [B]
9906:    09                     ret

R_9907:
9907:    7b f7                  call L_9900
9909:    73 c3                  jmp L_98ce

R_990b:
990b:    46 11 2d 01 90 80 04   unkbig2(1, 1) 0x01, [Z + 0x8004]
9912:    11 06                  bnc L_991a
9914:    85 88 03               ld AL, [Z + 0x03]
9917:    29                     dec AL, #1
9918:    14 40                  bz L_995a

L_991a:
991a:    7b e4                  call L_9900
991c:    7b cc                  call L_98ea
991e:    b5 a2                  st A, [--S]
9920:    79 8b dc               call R_8bdc
9923:    99                     ld A, [B]
9924:    d5 a1                  ld B, [S++]
9926:    59                     sub B, A
9927:    10 35                  bc L_995e
9929:    59                     sub B, A
992a:    f5 a2                  st B, [--S]
992c:    79 86 e1               call R_86e1
992f:    3b                     not A, #0
9930:    d5 88 06               ld B, [Z + 0x06]
9933:    9d                     ld A, [S]
9934:    fd                     st B, [S]
9935:    d1 01 1d               ld B, [0x011d]
9938:    f5 88 06               st B, [Z + 0x06]
993b:    55 82                  mov B, Z
993d:    79 8a e5               call R_8ae5
9940:    c0 ff                  ld BL, 0xff
9942:    e1 01 3b               st BL, [0x013b]
9945:    d5 a1                  ld B, [S++]
9947:    f5 88 06               st B, [Z + 0x06]
994a:    5d                     mov B, A
994b:    14 11                  bz L_995e
994d:    85 88 03               ld AL, [Z + 0x03]
9950:    29                     dec AL, #1
9951:    14 1c                  bz L_996f
9953:    79 97 e9               call R_97e9
9956:    14 b3                  bz R_990b
9958:    73 15                  jmp L_996f

L_995a:
995a:    7b ab                  call R_9907
995c:    15 11                  bnz L_996f

L_995e:
995e:    95 88 16               ld A, [Z + 0x16]
9961:    b5 88 12               st A, [Z + 0x12]
9964:    b5 88 08               st A, [Z + 0x08]
9967:    79 96 24               call R_9624
996a:    15 03                  bnz L_996f
996c:    71 96 b1               jmp R_96b1

L_996f:
996f:    80 01                  ld AL, 0x01
9971:    c5 88 03               ld BL, [Z + 0x03]
9974:    21 30                  dec BL, #1
9976:    14 02                  bz L_997a
9978:    80 02                  ld AL, 0x02

L_997a:
997a:    71 96 b1               jmp R_96b1

R_997d:
997d:    79 98 6b               call R_986b
9980:    c0 4d                  ld BL, 0x4d
9982:    73 05                  jmp L_9989

R_9984:
9984:    79 98 6b               call R_986b
9987:    c0 4e                  ld BL, 0x4e

L_9989:
9989:    e1 9a 32               st BL, [R_9a32|0x9a32]
998c:    4d                     mov BL, AL
998d:    15 3e                  bnz L_99cd
998f:    95 88 16               ld A, [Z + 0x16]
9992:    b5 a2                  st A, [--S]

L_9994:
9994:    79 9a 1d               call R_9a1d
9997:    4d                     mov BL, AL
9998:    14 1c                  bz L_99b6
999a:    ac                     st AL, [Z]
999b:    95 88 16               ld A, [Z + 0x16]
999e:    dd                     ld B, [S]
999f:    59                     sub B, A
99a0:    15 05                  bnz L_99a7
99a2:    30 a1                  inc S, #2
99a4:    71 95 ee               jmp R_95ee

L_99a7:
99a7:    95 a1                  ld A, [S++]
99a9:    b5 88 16               st A, [Z + 0x16]
99ac:    c0 4e                  ld BL, 0x4e
99ae:    e1 9a 32               st BL, [R_9a32|0x9a32]
99b1:    7b 6a                  call R_9a1d
99b3:    71 95 ee               jmp R_95ee

L_99b6:
99b6:    95 88 16               ld A, [Z + 0x16]
99b9:    d5 88 08               ld B, [Z + 0x08]
99bc:    59                     sub B, A
99bd:    14 08                  bz L_99c7
99bf:    95 88 08               ld A, [Z + 0x08]
99c2:    b5 88 16               st A, [Z + 0x16]
99c5:    73 cd                  jmp L_9994

L_99c7:
99c7:    30 a1                  inc S, #2
99c9:    2a                     clr AL, #0

L_99ca:
99ca:    71 96 b1               jmp R_96b1

L_99cd:
99cd:    21 30                  dec BL, #1
99cf:    15 01                  bnz L_99d2
99d1:    28                     inc AL, #1

L_99d2:
99d2:    d0 4d 00               ld B, 0x4d00
99d5:    c3 5b                  ld BL, [R_9a32|0x9a32]
99d7:    41 23                  sub BL, BH
99d9:    14 ef                  bz L_99ca
99db:    95 a8 09               ld A, [S + 0x09]
99de:    d5 48 0c               ld B, [X + 0x0c]
99e1:    66 09                  jsys 0x09
99e3:    0e                     dly

R_99e4:
99e4:    79 98 6b               call R_986b
99e7:    73 08                  jmp L_99f1

R_99e9:
99e9:    79 98 6b               call R_986b
99ec:    73 10                  jmp L_99fe

R_99ee:
99ee:    79 99 07               call R_9907

L_99f1:
99f1:    c0 4d                  ld BL, 0x4d
99f3:    31 a1                  dec S, #2
99f5:    7b 1b                  call L_9a12
99f7:    30 a1                  inc S, #2
99f9:    73 cf                  jmp L_99ca

R_99fb:
99fb:    79 99 07               call R_9907

L_99fe:
99fe:    c0 4e                  ld BL, 0x4e
9a00:    31 a1                  dec S, #2
9a02:    7b 0e                  call L_9a12
9a04:    30 a1                  inc S, #2
9a06:    4d                     mov BL, AL
9a07:    14 c1                  bz L_99ca
9a09:    95 a8 0d               ld A, [S + 0x0d]
9a0c:    d5 a8 10               ld B, [S + 0x10]
9a0f:    66 09                  jsys 0x09
9a11:    0e                     dly

L_9a12:
9a12:    e3 1e                  st BL, [R_9a32|0x9a32]
9a14:    4d                     mov BL, AL
9a15:    14 06                  bz R_9a1d
9a17:    21 30                  dec BL, #1
9a19:    15 01                  bnz L_9a1c
9a1b:    28                     inc AL, #1

L_9a1c:
9a1c:    09                     ret

R_9a1d:
9a1d:    55 82                  mov B, Z
9a1f:    79 8b dc               call R_8bdc
9a22:    85 08 02               ld AL, [A + 0x02]
9a25:    a5 a2                  st AL, [--S]
9a27:    95 88 16               ld A, [Z + 0x16]
9a2a:    79 cd 33               call R_cd33
9a2d:    45 10                  mov AH, AL
9a2f:    85 a1                  ld AL, [S++]
9a31:    66 ff                  jsys 0xff
9a33:    09                     ret

L_9a34:
9a34:    3a                     clr A, #0
9a35:    b5 88 18               st A, [Z + 0x18]

R_9a38:
9a38:    7b 69                  call R_9aa3
9a3a:    c0 84                  ld BL, 0x84
9a3c:    95 61                  ld A, [Y++]
9a3e:    17 0e                  bp L_9a4e
9a40:    41 03                  sub BL, AH
9a42:    14 05                  bz L_9a49
9a44:    79 95 f1               call R_95f1
9a47:    14 eb                  bz L_9a34

L_9a49:
9a49:    80 01                  ld AL, 0x01

L_9a4b:
9a4b:    71 96 b1               jmp R_96b1

L_9a4e:
9a4e:    5b                     mov X, A
9a4f:    31 01                  dec A, #2
9a51:    18 04                  bgt L_9a57
9a53:    8b                     ld AL, [Y]
9a54:    49                     sub BL, AL
9a55:    14 f2                  bz L_9a49

L_9a57:
9a57:    95 88 18               ld A, [Z + 0x18]
9a5a:    30 01                  inc A, #2
9a5c:    50 40                  add A, X
9a5e:    b5 88 18               st A, [Z + 0x18]
9a61:    71 96 94               jmp R_9694

R_9a64:
9a64:    95 88 10               ld A, [Z + 0x10]
9a67:    79 9b 5e               call R_9b5e
9a6a:    5b                     mov X, A
9a6b:    9a                     ld A, [X]
9a6c:    19 06                  ble L_9a74
9a6e:    d0 01 8d               ld B, 0x018d
9a71:    59                     sub B, A
9a72:    19 04                  ble L_9a78

L_9a74:
9a74:    80 05                  ld AL, 0x05

L_9a76:
9a76:    73 d3                  jmp L_9a4b

L_9a78:
9a78:    7b 3b                  call R_9ab5
9a7a:    da                     ld B, [X]
9a7b:    30 01                  inc A, #2
9a7d:    58                     add B, A
9a7e:    f5 88 18               st B, [Z + 0x18]
9a81:    90 01 8f               ld A, 0x018f
9a84:    59                     sub B, A
9a85:    17 09                  bp L_9a90
9a87:    80 ff                  ld AL, 0xff
9a89:    ab                     st AL, [Y]
9a8a:    7b 50                  call R_9adc
9a8c:    14 d6                  bz R_9a64
9a8e:    73 e6                  jmp L_9a76

L_9a90:
9a90:    55 42                  mov B, X
9a92:    95 21                  ld A, [B++]
9a94:    b5 61                  st A, [Y++]
9a96:    19 05                  ble L_9a9d
9a98:    39                     dec A, #1
9a99:    f7                     memcpy16
9a9a:    38                     inc A, #1
9a9b:    50 06                  add Y, A

L_9a9d:
9a9d:    2a                     clr AL, #0
9a9e:    29                     dec AL, #1
9a9f:    ab                     st AL, [Y]
9aa0:    2a                     clr AL, #0
9aa1:    73 d3                  jmp L_9a76

R_9aa3:
9aa3:    95 88 06               ld A, [Z + 0x06]
9aa6:    79 9b 6f               call R_9b6f
9aa9:    30 01                  inc A, #2
9aab:    d5 88 18               ld B, [Z + 0x18]
9aae:    f5 88 14               st B, [Z + 0x14]
9ab1:    50 20                  add A, B
9ab3:    5c                     mov Y, A
9ab4:    09                     ret

R_9ab5:
9ab5:    95 88 06               ld A, [Z + 0x06]
9ab8:    79 9b 6f               call R_9b6f
9abb:    30 01                  inc A, #2
9abd:    5c                     mov Y, A
9abe:    95 88 18               ld A, [Z + 0x18]
9ac1:    b5 88 14               st A, [Z + 0x14]
9ac4:    50 06                  add Y, A
9ac6:    09                     ret

L_9ac7:
9ac7:    95 88 06               ld A, [Z + 0x06]
9aca:    79 9b 6f               call R_9b6f
9acd:    3a                     clr A, #0
9ace:    b5 88 18               st A, [Z + 0x18]
9ad1:    95 88 12               ld A, [Z + 0x12]
9ad4:    b5 88 08               st A, [Z + 0x08]
9ad7:    79 96 1f               call R_961f
9ada:    02                     sf
9adb:    09                     ret

R_9adc:
9adc:    7b e9                  call L_9ac7
9ade:    15 18                  bnz L_9af8
9ae0:    95 88 16               ld A, [Z + 0x16]
9ae3:    b5 88 12               st A, [Z + 0x12]
9ae6:    38                     inc A, #1
9ae7:    b5 '5'
9ae8:    88

L_9ae9:
9ae9:    16 55                  blt L_9b40
9aeb:    82 79 8a               ld AL, @[0x798a]
9aee:    e5 14                  st BL, @[A]
9af0:    07                     rl
9af1:    55 82                  mov B, Z
9af3:    66 19                  jsys Syscall_19
9af5:    5d                     mov B, A
9af6:    15 01                  bnz L_9af9

L_9af8:
9af8:    09                     ret

L_9af9:
9af9:    80 02                  ld AL, 0x02
9afb:    09                     ret

R_9afc:
9afc:    7b c9                  call L_9ac7
9afe:    71 96 b1               jmp R_96b1

R_9b01:
9b01:    79 8b dc               call R_8bdc
9b04:    55 22                  mov B, B
9b06:    14 06                  bz L_9b0e

R_9b08:
9b08:    79 95 af               call R_95af

L_9b0b:
9b0b:    71 95 ee               jmp R_95ee

L_9b0e:
9b0e:    95 88 06               ld A, [Z + 0x06]
9b11:    7b 5c                  call R_9b6f
9b13:    79 96 1f               call R_961f
9b16:    04                     ei
9b17:    73 f2                  jmp L_9b0b

R_9b19:
9b19:    d5 88 08               ld B, [Z + 0x08]
9b1c:    95 88 12               ld A, [Z + 0x12]
9b1f:    b5 21                  st A, [B++]
9b21:    95 88 14               ld A, [Z + 0x14]
9b24:    b9                     st A, [B]
9b25:    73 e4                  jmp L_9b0b

R_9b27:
9b27:    d5 88 08               ld B, [Z + 0x08]
9b2a:    95 21                  ld A, [B++]
9b2c:    b5 88 16               st A, [Z + 0x16]
9b2f:    99                     ld A, [B]
9b30:    b5 88 18               st A, [Z + 0x18]
9b33:    95 88 06               ld A, [Z + 0x06]
9b36:    7b 37                  call R_9b6f
9b38:    79 95 f1               call R_95f1
9b3b:    73 ce                  jmp L_9b0b

R_9b3d:
9b3d:    f5 a2                  st B, [--S]
9b3f:    b3 18                  st A, [L_9b58+1|0x9b59]
9b41:    51 10 7f ff            sub A, A, 0x7fff
9b45:    11 11                  bnc L_9b58
9b47:    79 89 82               call R_8982
9b4a:    89                     ld AL, [B]
9b4b:    21 11                  dec AL, #2
9b4d:    14 09                  bz L_9b58
9b4f:    d3 08                  ld B, [L_9b58+1|0x9b59]
9b51:    95 a8 02               ld A, [S + 0x02]
9b54:    79 86 12               call R_8612
9b57:    17

L_9b58:
9b58:    90 00 00               ld A, 0x0000
9b5b:    d5 a1                  ld B, [S++]
9b5d:    09                     ret

R_9b5e:
9b5e:    7e 03                  push {A, B}
9b60:    95 88 10               ld A, [Z + 0x10]
9b63:    7b 1b                  call L_9b80
9b65:    d5 88 0e               ld B, [Z + 0x0e]
9b68:    50 20                  add A, B
9b6a:    7b 14                  call L_9b80
9b6c:    7f 03                  pop {A, B}
9b6e:    09                     ret

R_9b6f:
9b6f:    7e 03                  push {A, B}
9b71:    95 88 06               ld A, [Z + 0x06]
9b74:    7b 0a                  call L_9b80
9b76:    d5 88 04               ld B, [Z + 0x04]
9b79:    50 20                  add A, B
9b7b:    7b 03                  call L_9b80
9b7d:    7f 03                  pop {A, B}
9b7f:    09                     ret

L_9b80:
9b80:    51 12 7f ff            sub B, A, 0x7fff
9b84:    11 0f                  bnc L_9b95
9b86:    79 89 82               call R_8982
9b89:    c9                     ld BL, [B]
9b8a:    21 31                  dec BL, #2
9b8c:    14 07                  bz L_9b95
9b8e:    5d                     mov B, A
9b8f:    55 80                  mov A, Z
9b91:    79
9b92:    86

L_9b93:
9b93:    12 17                  bn L_9bac

L_9b95:
9b95:    09                     ret

R_9b96:
9b96:    9b                     ld A, [Y]
9b97:    9c                     ld A, [Z]
9b98:    9b                     ld A, [Y]
9b99:    a1 9b ad               st AL, [R_9bad|0x9bad]

R_9b9c:
9b9c:    0a                     reti
9b9d:    00                     HALT
9b9e:    01                     nop
9b9f:    02                     sf
9ba0:    ff                     st B, [P]

R_9ba1:
9ba1:    09                     ret
9ba2:    0a
9ba3:    00
9ba4:    01
9ba5:    02
9ba6:    03
9ba7:    04
9ba8:    06
9ba9:    07
9baa:    05
9bab:    08

L_9bac:
9bac:    ff                     st B, [P]

R_9bad:
9bad:    04                     ei
9bae:    ff                     st B, [P]

R_9baf:
9baf:    9b                     ld A, [Y]
9bb0:    bd                     st A, [S]
9bb1:    9b                     ld A, [Y]
9bb2:    d4 9b                  ld B, @[0x9b4f]
9bb4:    eb                     st BL, [Y]
9bb5:    9b                     ld A, [Y]
9bb6:    fc                     st B, [Z]
9bb7:    9c                     ld A, [Z]
9bb8:    0d                     mov_pc X
9bb9:    9c                     ld A, [Z]
9bba:    24 9c                  srl ZL, #13
9bbc:    35 0b                  sll A, #12
9bbe:    96                     unknown
9bbf:    2c                     srl AL, #1
9bc0:    96                     unknown
9bc1:    30 00                  inc A, #1
9bc3:    00                     HALT
9bc4:    9b                     ld A, [Y]
9bc5:    01                     nop
9bc6:    00                     HALT
9bc7:    00                     HALT
9bc8:    00                     HALT
9bc9:    00                     HALT
9bca:    00                     HALT
9bcb:    00                     HALT
9bcc:    00                     HALT
9bcd:    00                     HALT
9bce:    94 ce                  ld A, @[0x9b9e]
9bd0:    94 9b                  ld A, @[0x9b6d]
9bd2:    94 b7                  ld A, @[0x9b8b]

R_9bd4:
9bd4:    0b                     rim
9bd5:    96
9bd6:    5c
9bd7:    96
9bd8:    b5 '5'
9bd9:    96
9bda:    f1 'q'
9bdb:    9b
9bdc:    08
9bdd:    9b
9bde:    19
9bdf:    9b
9be0:    27
9be1:    00
9be2:    00
9be3:    00
9be4:    00
9be5:    94
9be6:    ce 'N'
9be7:    94
9be8:    9b
9be9:    9a
9bea:    fc '|'

R_9beb:
9beb:    08                     cl
9bec:    97                     unknown
9bed:    34 97 83 00            srl [Z + 0x8300], #8
9bf1:    00                     HALT
9bf2:    00                     HALT
9bf3:    00                     HALT
9bf4:    00                     HALT
9bf5:    00                     HALT
9bf6:    00                     HALT
9bf7:    00                     HALT
9bf8:    99                     ld A, [B]
9bf9:    e4 99                  st BL, @[L_9b93+1|0x9b94]
9bfb:    e9                     st BL, [B]

R_9bfc:
9bfc:    08                     cl
9bfd:    97                     unknown
9bfe:    5b                     mov X, A
9bff:    97                     unknown
9c00:    b1 00 00               st A, [L_0000|0x0000]
9c03:    00                     HALT
9c04:    00                     HALT
9c05:    00                     HALT
9c06:    00                     HALT
9c07:    00                     HALT
9c08:    00                     HALT
9c09:    99                     ld A, [B]
9c0a:    e4 99                  st BL, @[0x9ba5]
9c0c:    e9                     st BL, [B]

R_9c0d:
9c0d:    0b                     rim
9c0e:    9a
9c0f:    38
9c10:    9a
9c11:    64
9c12:    00
9c13:    00
9c14:    9b
9c15:    08
9c16:    9b
9c17:    19
9c18:    9b
9c19:    27
9c1a:    00
9c1b:    00
9c1c:    00
9c1d:    00
9c1e:    94
9c1f:    ce 'N'
9c20:    94
9c21:    9b
9c22:    9a
9c23:    fc '|'

R_9c24:
9c24:    08                     cl
9c25:    99                     ld A, [B]
9c26:    0b                     rim
9c27:    99
9c28:    0b
9c29:    00
9c2a:    00
9c2b:    00
9c2c:    00
9c2d:    00
9c2e:    00
9c2f:    00
9c30:    00
9c31:    99
9c32:    ee 'n'
9c33:    99
9c34:    fb '{'

R_9c35:
9c35:    0f                     rsys
9c36:    97
9c37:    3c
9c38:    97
9c39:    8b
9c3a:    00
9c3b:    00
9c3c:    00
9c3d:    00
9c3e:    00
9c3f:    00
9c40:    00
9c41:    00
9c42:    99
9c43:    7d
9c44:    99
9c45:    84
9c46:    94
9c47:    ca 'J'
9c48:    94
9c49:    9b
9c4a:    <null bytes>


Syscall_05:
9c54:    7e 03                  push {A, B}
9c56:    3a                     clr A, #0
9c57:    85 41                  ld AL, [X++]
9c59:    73 00                  jmp R_9c5b

R_9c5b:
9c5b:    31 a1                  dec S, #2
9c5d:    47 46 08 a0 02 0a      memcpy 0x09, [S + 0x02], [S]
9c63:    d5 a8 05               ld B, [S + 0x05]
9c66:    f5 a8 09               st B, [S + 0x09]
9c69:    6d a8 05               st X, [S + 0x05]
9c6c:    d1 01 03               ld B, [CurrentProcess|0x0103]
9c6f:    47 45 00 a0 08 20 29   memcpy 0x01, [S + 0x08], [B + 0x29]
9c76:    c0 00                  ld BL, 0x00
9c78:    e5 a8 08               st BL, [S + 0x08]
9c7b:    c1 a6 f5               ld BL, [WeirdExtra_HawkDeviceObj|0xa6f5]
9c7e:    49                     sub BL, AL
9c7f:    11 04                  bnc L_9c85
9c81:    79 86 12               call R_8612
9c84:    1e

L_9c85:
9c85:    21 18                  dec AL, #9
9c87:    15 09                  bnz L_9c92
9c89:    79 9d 46               call R_9d46
9c8c:    7f 03                  pop {A, B}
9c8e:    60 9f 98               ld X, Entry_0x9f98|0x9f98
9c91:    0f                     rsys

L_9c92:
9c92:    20 18                  inc AL, #9
9c94:    3d                     sll A, #1
9c95:    38                     inc A, #1
9c96:    d3 e4                  ld B, [R_9c7c|0x9c7c]
9c98:    58                     add B, A
9c99:    99                     ld A, [B]
9c9a:    b5 a2                  st A, [--S]
9c9c:    79 86 e1               call R_86e1
9c9f:    3d                     sll A, #1
9ca0:    9d                     ld A, [S]
9ca1:    d0 00 00               ld B, 0x0000
9ca4:    59                     sub B, A
9ca5:    15 03                  bnz L_9caa

L_9ca7:
9ca7:    71 9d 35               jmp R_9d35

L_9caa:
9caa:    79 86 e1               call R_86e1
9cad:    3b                     not A, #0
9cae:    79 9d 56               call R_9d56
9cb1:    d1 01 03               ld B, [CurrentProcess|0x0103]
9cb4:    c5 28 01               ld BL, [B + 0x01]
9cb7:    e1 9d 57               st BL, [R_9d56+1|0x9d57]
9cba:    d0 9f 96               ld B, R_9f96|0x9f96

L_9cbd:
9cbd:    f1 9d a6               st B, [R_9da6|0x9da6]
9cc0:    d9                     ld B, [B]
9cc1:    14 11                  bz L_9cd4
9cc3:    85 28 04               ld AL, [B + 0x04]
9cc6:    16 f5                  blt L_9cbd
9cc8:    28                     inc AL, #1
9cc9:    13 f2                  bnn L_9cbd
9ccb:    3a                     clr A, #0
9ccc:    39                     dec A, #1
9ccd:    b3 d3                  st A, [R_9ca2|0x9ca2]
9ccf:    79 9e 9f               call R_9e9f
9cd2:    7b 72                  call R_9d46

L_9cd4:
9cd4:    90 9f 96               ld A, R_9f96|0x9f96

L_9cd7:
9cd7:    b1 9d a6               st A, [R_9da6|0x9da6]
9cda:    98                     ld A, [A]
9cdb:    14 2d                  bz L_9d0a
9cdd:    c5 08 04               ld BL, [A + 0x04]
9ce0:    20 30                  inc BL, #1
9ce2:    15 f3                  bnz L_9cd7
9ce4:    c0 7f                  ld BL, 0x7f
9ce6:    e5 08 04               st BL, [A + 0x04]
9ce9:    d5 08 02               ld B, [A + 0x02]
9cec:    39                     dec A, #1
9ced:    58                     add B, A
9cee:    f3 09                  st B, [0x9cf9]
9cf0:    d0 00 06               ld B, 0x0006
9cf3:    58                     add B, A
9cf4:    f3 05                  st B, [0x9cfb]
9cf6:    9d                     ld A, [S]
9cf7:    66 57                  jsys 0x57
9cf9:    00                     HALT
9cfa:    00                     HALT
9cfb:    00                     HALT
9cfc:    00                     HALT
9cfd:    01                     nop
9cfe:    f3 43                  st B, [0x9d43]
9d00:    15 24                  bnz L_9d26
9d02:    92 9d a6               ld A, @[R_9da6|0x9da6]
9d05:    c0 ff                  ld BL, 0xff
9d07:    e5 08 04               st BL, [A + 0x04]

L_9d0a:
9d0a:    79 9e 4b               call R_9e4b
9d0d:    14 c5                  bz L_9cd4
9d0f:    2a                     clr AL, #0
9d10:    29                     dec AL, #1
9d11:    a3 44                  st AL, [R_9d56+1|0x9d57]
9d13:    79 87 3a               call R_873a
9d16:    79 86 e1               call R_86e1
9d19:    3b                     not A, #0
9d1a:    7b 3a                  call R_9d56
9d1c:    d1 01 03               ld B, [CurrentProcess|0x0103]
9d1f:    c5 28 01               ld BL, [B + 0x01]
9d22:    e3 33                  st BL, [R_9d56+1|0x9d57]
9d24:    73 ae                  jmp L_9cd4

L_9d26:
9d26:    d2 9d a6               ld B, @[R_9da6|0x9da6]
9d29:    38                     inc A, #1
9d2a:    59                     sub B, A
9d2b:    79 9e f6               call R_9ef6
9d2e:    95 a1                  ld A, [S++]
9d30:    b1 9c a2               st A, [R_9ca2|0x9ca2]
9d33:    73 07                  jmp L_9d3c

R_9d35:
9d35:    95 a1                  ld A, [S++]
9d37:    b1 9c a2               st A, [R_9ca2|0x9ca2]
9d3a:    7b 0a                  call R_9d46

L_9d3c:
9d3c:    2a                     clr AL, #0
9d3d:    29                     dec AL, #1
9d3e:    a3 17                  st AL, [R_9d56+1|0x9d57]
9d40:    7f 03                  pop {A, B}
9d42:    60 00 00               ld X, 0x0000
9d45:    0f                     rsys

R_9d46:
9d46:    79 89 82               call R_8982
9d49:    89                     ld AL, [B]
9d4a:    47 4e 00 02 02         memcpy 0x01, 0x02, [B]
9d4f:    d1 01 03               ld B, [CurrentProcess|0x0103]
9d52:    a5 28 2a               st AL, [B + 0x2a]
9d55:    09                     ret

R_9d56:
9d56:    80 ff                  ld AL, 0xff
9d58:    17 01                  bp L_9d5b
9d5a:    09                     ret

L_9d5b:
9d5b:    79 87 3a               call R_873a
9d5e:    73 f6                  jmp R_9d56

Syscall_16:
9d60:    79 9d 56               call R_9d56
9d63:    3a                     clr A, #0
9d64:    b3 2c                  st A, [R_9d91+1|0x9d92]
9d66:    6d a2                  st X, [--S]

L_9d68:
9d68:    95 a4                  ld A, @[S]
9d6a:    30 04                  inc A, #5
9d6c:    60 9f 96               ld X, R_9f96|0x9f96
9d6f:    6d a2                  st X, [--S]
9d71:    65 40                  ld X, [X]
9d73:    15 04                  bnz L_9d79
9d75:    65 a1                  ld X, [S++]
9d77:    73 1d                  jmp L_9d96

L_9d79:
9d79:    c5 48 04               ld BL, [X + 0x04]
9d7c:    17 0b                  bp L_9d89
9d7e:    d5 48 02               ld B, [X + 0x02]
9d81:    59                     sub B, A
9d82:    14 02                  bz L_9d86
9d84:    10 09                  bc L_9d8f

L_9d86:
9d86:    dd                     ld B, [S]
9d87:    f3 09                  st B, [R_9d91+1|0x9d92]

L_9d89:
9d89:    6d a0                  st X, [S]
9d8b:    65 40                  ld X, [X]
9d8d:    15 ea                  bnz L_9d79

L_9d8f:
9d8f:    65 a1                  ld X, [S++]

R_9d91:
9d91:    d0 9d 91               ld B, R_9d91|0x9d91
9d94:    15 0c                  bnz L_9da2

L_9d96:
9d96:    79 9e 4b               call R_9e4b
9d99:    14 cd                  bz L_9d68
9d9b:    65 a1                  ld X, [S++]
9d9d:    79 87 3a               call R_873a
9da0:    73 be                  jmp Syscall_16

L_9da2:
9da2:    5d                     mov B, A
9da3:    93 ed                  ld A, [R_9d91+1|0x9d92]
9da5:    b0 9f 96               st A, R_9f96|0x9f96
9da8:    98                     ld A, [A]
9da9:    5b                     mov X, A
9daa:    79 9e f6               call R_9ef6
9dad:    55 40                  mov A, X
9daf:    65 a1                  ld X, [S++]
9db1:    d1 01 03               ld B, [CurrentProcess|0x0103]
9db4:    c5 28 01               ld BL, [B + 0x01]
9db7:    e5 08 04               st BL, [A + 0x04]
9dba:    30 04                  inc A, #5
9dbc:    30 41                  inc X, #2
9dbe:    b5 41                  st A, [X++]
9dc0:    0f                     rsys

Syscall_17:
9dc1:    79 9d 56               call R_9d56
9dc4:    95 41                  ld A, [X++]
9dc6:    31 04                  dec A, #5
9dc8:    7e 45                  push {X, Y, Z}
9dca:    60 9f 96               ld X, R_9f96|0x9f96

L_9dcd:
9dcd:    6b d7                  st X, [R_9da6|0x9da6]
9dcf:    65 40                  ld X, [X]
9dd1:    14 74                  bz L_9e47
9dd3:    5d                     mov B, A
9dd4:    51 42                  sub B, X
9dd6:    15 f5                  bnz L_9dcd
9dd8:    79 9e 9f               call R_9e9f

L_9ddb:
9ddb:    47 20 0f fd 01 85 01 85 memchr 0x10, 0xfd, [R_0185|0x0185], [R_0185|0x0185]
9de3:    31 80                  dec Z, #1
9de5:    51 90 01 85            sub A, Z, 0x0185
9de9:    33 02                  not A, #2
9deb:    35 0a                  sll A, #11
9ded:    b5 a2                  st A, [--S]
9def:    60 9f 96               ld X, R_9f96|0x9f96

L_9df2:
9df2:    6b b2                  st X, [R_9da6|0x9da6]
9df4:    65 40                  ld X, [X]
9df6:    14 3c                  bz L_9e34
9df8:    9d                     ld A, [S]
9df9:    d5 48 02               ld B, [X + 0x02]
9dfc:    50 42                  add B, X
9dfe:    59                     sub B, A
9dff:    15 f1                  bnz L_9df2
9e01:    85 48 04               ld AL, [X + 0x04]
9e04:    28                     inc AL, #1
9e05:    15 2d                  bnz L_9e34
9e07:    95 48 02               ld A, [X + 0x02]
9e0a:    50 10 f8 00            add A, A, 0xf800
9e0e:    15 0a                  bnz L_9e1a
9e10:    95 a1                  ld A, [S++]
9e12:    7b 25                  call L_9e39
9e14:    9a                     ld A, [X]
9e15:    b2 9d a6               st A, @[R_9da6|0x9da6]
9e18:    73 c1                  jmp L_9ddb

L_9e1a:
9e1a:    31 04                  dec A, #5
9e1c:    16 16                  blt L_9e34
9e1e:    30 04                  inc A, #5
9e20:    bd                     st A, [S]
9e21:    7b 16                  call L_9e39
9e23:    95 a1                  ld A, [S++]
9e25:    b5 48 02               st A, [X + 0x02]
9e28:    9a                     ld A, [X]
9e29:    b2 9d a6               st A, @[R_9da6|0x9da6]
9e2c:    69 9e e3               st X, [R_9ee3|0x9ee3]
9e2f:    79 9f 35               call R_9f35
9e32:    73 a7                  jmp L_9ddb

L_9e34:
9e34:    95 a1                  ld A, [S++]
9e36:    7f 45                  pop {X, Y, Z}
9e38:    0f                     rsys

L_9e39:
9e39:    8c                     ld AL, [Z]
9e3a:    79 a2 c7               call R_a2c7
9e3d:    80 fd                  ld AL, 0xfd
9e3f:    ac                     st AL, [Z]
9e40:    a5 88 20               st AL, [Z + 0x20]
9e43:    a5 88 40               st AL, [Z + 0x40]
9e46:    09                     ret

L_9e47:
9e47:    79 86 12               call R_8612
9e4a:    20 7e                  inc YL, #15
9e4c:    45 55                  mov XL, XL
9e4e:    76                     enable_parity_trap
9e4f:    01                     nop
9e50:    85 32                  ld AL, [--B]
9e52:    40 3f                  add PL, BL

L_9e54:
9e54:    3e                     inc X
9e55:    51 52 00 10            sub B, X, 0x0010
9e59:    18 09                  bgt L_9e64

L_9e5b:
9e5b:    79 a2 ea               call R_a2ea
9e5e:    7f 45                  pop {X, Y, Z}
9e60:    90 00 01               ld A, 0x0001
9e63:    09                     ret

L_9e64:
9e64:    c5 61                  ld BL, [Y++]
9e66:    17 ec                  bp L_9e54
9e68:    c5 68 1f               ld BL, [Y + 0x1f]
9e6b:    17 e7                  bp L_9e54
9e6d:    c5 68 3f               ld BL, [Y + 0x3f]
9e70:    17 e2                  bp L_9e54
9e72:    31 60                  dec Y, #1
9e74:    3a                     clr A, #0
9e75:    79 a2 8b               call R_a28b
9e78:    16 e1                  blt L_9e5b
9e7a:    ab                     st AL, [Y]
9e7b:    a5 68 20               st AL, [Y + 0x20]
9e7e:    a5 68 40               st AL, [Y + 0x40]
9e81:    55 89 01 03            mov Z, [CurrentProcess|0x0103]
9e85:    79 88 6a               call R_886a
9e88:    35 4a                  sll X, #11
9e8a:    90 08 00               ld A, 0x0800
9e8d:    b5 48 02               st A, [X + 0x02]
9e90:    29                     dec AL, #1
9e91:    a5 48 04               st AL, [X + 0x04]
9e94:    6b 4d                  st X, [R_9ee3|0x9ee3]
9e96:    79 9f 35               call R_9f35
9e99:    7b 04                  call R_9e9f
9e9b:    7f 45                  pop {X, Y, Z}
9e9d:    3a                     clr A, #0
9e9e:    09                     ret

R_9e9f:
9e9f:    92 9d a6               ld A, @[R_9da6|0x9da6]
9ea2:    b3 3f                  st A, [R_9ee3|0x9ee3]
9ea4:    d5 08 02               ld B, [A + 0x02]
9ea7:    f3 71                  st B, [0x9f1a]
9ea9:    98                     ld A, [A]
9eaa:    b2 9d a6               st A, @[R_9da6|0x9da6]
9ead:    6d a2                  st X, [--S]
9eaf:    6d a2                  st X, [--S]

L_9eb1:
9eb1:    60 9f 96               ld X, R_9f96|0x9f96

L_9eb4:
9eb4:    6d a0                  st X, [S]
9eb6:    65 40                  ld X, [X]
9eb8:    14 2d                  bz L_9ee7
9eba:    85 48 04               ld AL, [X + 0x04]
9ebd:    17 f5                  bp L_9eb4
9ebf:    93 22                  ld A, [R_9ee3|0x9ee3]
9ec1:    51 40                  sub A, X
9ec3:    16 17                  blt L_9edc
9ec5:    d3 53                  ld B, [0x9f1a]
9ec7:    59                     sub B, A
9ec8:    15 ea                  bnz L_9eb4

L_9eca:
9eca:    95 48 02               ld A, [X + 0x02]
9ecd:    d3 4b                  ld B, [0x9f1a]
9ecf:    58                     add B, A
9ed0:    f3 48                  st B, [0x9f1a]
9ed2:    93 0f                  ld A, [R_9ee3|0x9ee3]
9ed4:    f5 08 02               st B, [A + 0x02]
9ed7:    9a                     ld A, [X]
9ed8:    b5 a4                  st A, @[S]
9eda:    73 d5                  jmp L_9eb1

L_9edc:
9edc:    d5 48 02               ld B, [X + 0x02]
9edf:    58                     add B, A
9ee0:    15 d2                  bnz L_9eb4
9ee2:    68 00 00               st X, 0x0000
9ee5:    73 e3                  jmp L_9eca

L_9ee7:
9ee7:    65 a1                  ld X, [S++]
9ee9:    65 a1                  ld X, [S++]
9eeb:    7b 48                  call R_9f35
9eed:    92 9d a6               ld A, @[R_9da6|0x9da6]
9ef0:    c0 ff                  ld BL, 0xff
9ef2:    e5 08 04               st BL, [A + 0x04]
9ef5:    09                     ret

R_9ef6:
9ef6:    90 00 05               ld A, 0x0005
9ef9:    51 20                  sub A, B
9efb:    10 01                  bc L_9efe
9efd:    09                     ret

L_9efe:
9efe:    f3 1a                  st B, [0x9f1a]
9f00:    6d a2                  st X, [--S]
9f02:    62 9d a6               ld X, @[R_9da6|0x9da6]
9f05:    95 48 02               ld A, [X + 0x02]
9f08:    59                     sub B, A
9f09:    16 27                  blt L_9f32
9f0b:    f3 19                  st B, [0x9f26]
9f0d:    90 00 05               ld A, 0x0005
9f10:    59                     sub B, A
9f11:    17 1f                  bp L_9f32
9f13:    6b ce                  st X, [R_9ee3|0x9ee3]
9f15:    9a                     ld A, [X]
9f16:    b2 9d a6               st A, @[R_9da6|0x9da6]
9f19:    90 00 00               ld A, 0x0000
9f1c:    b5 48 02               st A, [X + 0x02]
9f1f:    50 04                  add X, A
9f21:    7b 12                  call R_9f35
9f23:    6b be                  st X, [R_9ee3|0x9ee3]
9f25:    90 00 00               ld A, 0x0000
9f28:    b5 48 02               st A, [X + 0x02]
9f2b:    80 ff                  ld AL, 0xff
9f2d:    a5 48 04               st AL, [X + 0x04]
9f30:    7b 03                  call R_9f35

L_9f32:
9f32:    65 a1                  ld X, [S++]
9f34:    09                     ret

R_9f35:
9f35:    6d a2                  st X, [--S]
9f37:    60 9f 96               ld X, R_9f96|0x9f96
9f3a:    93 a7                  ld A, [R_9ee3|0x9ee3]
9f3c:    95 08 02               ld A, [A + 0x02]

L_9f3f:
9f3f:    da                     ld B, [X]
9f40:    14 0a                  bz L_9f4c
9f42:    d5 28 02               ld B, [B + 0x02]
9f45:    59                     sub B, A
9f46:    10 04                  bc L_9f4c
9f48:    65 40                  ld X, [X]
9f4a:    73 f3                  jmp L_9f3f

L_9f4c:
9f4c:    9a                     ld A, [X]
9f4d:    b4 94                  st A, @[R_9ee3|0x9ee3]
9f4f:    93 92                  ld A, [R_9ee3|0x9ee3]
9f51:    ba                     st A, [X]
9f52:    69 9d a6               st X, [R_9da6|0x9da6]
9f55:    65 a1                  ld X, [S++]
9f57:    09                     ret

R_9f58:
9f58:    6d a2                  st X, [--S]
9f5a:    a5 a2                  st AL, [--S]
9f5c:    c1 9d 57               ld BL, [R_9d56+1|0x9d57]
9f5f:    49                     sub BL, AL
9f60:    e3 24                  st BL, [0x9f86]
9f62:    15 05                  bnz L_9f69
9f64:    2a                     clr AL, #0
9f65:    29                     dec AL, #1
9f66:    a1 9d 57               st AL, [R_9d56+1|0x9d57]

L_9f69:
9f69:    79 9d 56               call R_9d56

L_9f6c:
9f6c:    60 9f 96               ld X, R_9f96|0x9f96

L_9f6f:
9f6f:    69 9d a6               st X, [R_9da6|0x9da6]
9f72:    65 40                  ld X, [X]
9f74:    15 05                  bnz L_9f7b
9f76:    85 a1                  ld AL, [S++]
9f78:    65 a1                  ld X, [S++]
9f7a:    09                     ret

L_9f7b:
9f7b:    85 48 04               ld AL, [X + 0x04]
9f7e:    cd                     ld BL, [S]
9f7f:    49                     sub BL, AL
9f80:    14 0f                  bz L_9f91
9f82:    28                     inc AL, #1
9f83:    13 ea                  bnn L_9f6f
9f85:    c0 00                  ld BL, 0x00
9f87:    15 e6                  bnz L_9f6f
9f89:    d0 00 05               ld B, 0x0005
9f8c:    79 9e f6               call R_9ef6
9f8f:    73 de                  jmp L_9f6f

L_9f91:
9f91:    79 9e 9f               call R_9e9f
9f94:    73 d6                  jmp L_9f6c

R_9f96:
9f96:    00
9f97:    00

Entry_0x9f98:
9f98:    7e 45                  push {X, Y, Z}
9f9a:    66 06                  jsys Syscall_06
9f9c:    3b                         arg1 = (0x3b)
9f9d:    d5 41                  ld B, [X++]
9f9f:    f3 42                  st B, [0x9fe3]
9fa1:    d5 41                  ld B, [X++]
9fa3:    f1 a0 4a               st B, [R_a04a|0xa04a]
9fa6:    14 10                  bz L_9fb8
9fa8:    51 32 7f ff            sub B, B, 0x7fff
9fac:    11 0a                  bnc L_9fb8
9fae:    d1 a0 4a               ld B, [R_a04a|0xa04a]
9fb1:    55 40                  mov A, X
9fb3:    31 01                  dec A, #2
9fb5:    66 09                  jsys 0x09
9fb7:    17

L_9fb8:
9fb8:    d5 41                  ld B, [X++]
9fba:    45 21                  mov AL, BH
9fbc:    14 06                  bz L_9fc4
9fbe:    28                     inc AL, #1
9fbf:    14 03                  bz L_9fc4
9fc1:    d5 28 02               ld B, [B + 0x02]

L_9fc4:
9fc4:    f1 a0 3a               st B, [L_a039+1|0xa03a]
9fc7:    91 00 5a               ld A, [0x005a]
9fca:    95 08 03               ld A, [A + 0x03]
9fcd:    c5 08 1b               ld BL, [A + 0x1b]
9fd0:    e3 3e                  st BL, [0xa010]
9fd2:    d5 08 1c               ld B, [A + 0x1c]
9fd5:    f3 3b                  st B, [0xa012]
9fd7:    47 44 09 00 1e a0 74   memcpy 0x0a, [A + 0x1e], [R_a074|0xa074]
9fde:    55 98 a0 74            mov Z, R_a074|0xa074
9fe2:    90 00 00               ld A, 0x0000
9fe5:    5c                     mov Y, A
9fe6:    60 00 0a               ld X, 0x000a

L_9fe9:
9fe9:    85 61                  ld AL, [Y++]
9feb:    14 0d                  bz L_9ffa
9fed:    c0 a0                  ld BL, 0xa0
9fef:    49                     sub BL, AL
9ff0:    15 01                  bnz L_9ff3
9ff2:    8c                     ld AL, [Z]

L_9ff3:
9ff3:    a5 81                  st AL, [Z++]
9ff5:    3f                     dec X
9ff6:    18 f1                  bgt L_9fe9
9ff8:    73 07                  jmp L_a001

L_9ffa:
9ffa:    80 a0                  ld AL, 0xa0

L_9ffc:
9ffc:    a5 81                  st AL, [Z++]
9ffe:    3f                     dec X
9fff:    18 fb                  bgt L_9ffc

L_a001:
a001:    79 a5 97               call R_a597
a004:    a0 74                  st AL, 0x74
a006:    55 89 00 5a            mov Z, [0x005a]
a00a:    95 88 1d               ld A, [Z + 0x1d]
a00d:    b3 09                  st A, [0xa018]
a00f:    80 00                  ld AL, 0x00
a011:    d0 00 00               ld B, 0x0000
a014:    66 64                  jsys 0x64
a016:    a0 74                  st AL, 0x74
a018:    00                     HALT
a019:    00                     HALT
a01a:    15 1d                  bnz L_a039
a01c:    7b 50                  call L_a06e
a01e:    d5 88 03               ld B, [Z + 0x03]
a021:    d5 28 19               ld B, [B + 0x19]
a024:    14 05                  bz L_a02b
a026:    80 04                  ld AL, 0x04
a028:    a5 28 06               st AL, [B + 0x06]

L_a02b:
a02b:    7f 45                  pop {X, Y, Z}
a02d:    30 45                  inc X, #6
a02f:    3a                     clr A, #0
a030:    85 41                  ld AL, [X++]
a032:    3d                     sll A, #1
a033:    50 04                  add X, A

L_a035:
a035:    66 01                  jsys 0x01
a037:    ff                     st B, [P]
a038:    ff                     st B, [P]

L_a039:
a039:    d0 00 00               ld B, 0x0000
a03c:    15 04                  bnz L_a042
a03e:    55 ba 85 03            mov S, R_8503|0x8503

L_a042:
a042:    f5 a2                  st B, [--S]
a044:    7b 28                  call L_a06e
a046:    c3 c8                  ld BL, [0xa010]
a048:    66 03                  jsys 0x03

R_a04a:
a04a:    00                     HALT
a04b:    00                     HALT
a04c:    01                     nop
a04d:    95 a1                  ld A, [S++]
a04f:    14 13                  bz L_a064
a051:    39                     dec A, #1
a052:    14 06                  bz L_a05a
a054:    7f 45                  pop {X, Y, Z}
a056:    30 46                  inc X, #7
a058:    73 db                  jmp L_a035

L_a05a:
a05a:    7f 45                  pop {X, Y, Z}
a05c:    30 46                  inc X, #7
a05e:    6d a2                  st X, [--S]
a060:    55 24                  mov X, B
a062:    73 d1                  jmp L_a035

L_a064:
a064:    90 80 0b               ld A, 0x800b
a067:    5f                     mov S, A
a068:    3a                     clr A, #0
a069:    bd                     st A, [S]
a06a:    55 24                  mov X, B
a06c:    73 c7                  jmp L_a035

L_a06e:
a06e:    c0 ff                  ld BL, 0xff
a070:    e5 88 3b               st BL, [Z + 0x3b]
a073:    09                     ret

R_a074:
a074:    <null bytes>


level15HandlerA:
a07f:    55 ba a2 4d            mov S, Syscall_59|0xa24d
a083:    55 82                  mov B, Z
a085:    32 80                  clr Z, #0
a087:    7b 03                  call R_a08c
a089:    0a                     reti
a08a:    73 f3                  jmp level15HandlerA

R_a08c:
a08c:    2e 2c 00 a2 3a         wpf1 0x00, [R_a23a|0xa23a]
a091:    7e 41                  push {X}
a093:    f1 a1 fa               st B, [R_a1fa|0xa1fa]
a096:    a1 a1 f5               st AL, [R_a1f5|0xa1f5]
a099:    21 14                  dec AL, #5
a09b:    15 12                  bnz L_a0af
a09d:    91 01 03               ld A, [CurrentProcess|0x0103]
a0a0:    14 0d                  bz L_a0af
a0a2:    d5 08 19               ld B, [A + 0x19]
a0a5:    14 08                  bz L_a0af
a0a7:    22 12                  clr AL, #2
a0a9:    a5 28 06               st AL, [B + 0x06]
a0ac:    71 a1 9b               jmp R_a19b

L_a0af:
a0af:    2a                     clr AL, #0
a0b0:    a1 a1 f9               st AL, [R_a1f9|0xa1f9]
a0b3:    07                     rl
a0b4:    55 c0                  mov A, C
a0b6:    36 00                  rrc A, #1
a0b8:    34 0a                  srl A, #11
a0ba:    a1 a1 f4               st AL, [R_a1f4|0xa1f4]
a0bd:    25 13                  sll AL, #4
a0bf:    20 1b                  inc AL, #12
a0c1:    a3 05                  st AL, [0xa0c8]
a0c3:    20 11                  inc AL, #2
a0c5:    a3 09                  st AL, [0xa0d0]
a0c7:    e6 0c                  mov A, IL0(C)
a0c9:    c0 07                  ld BL, 0x07
a0cb:    4a                     and BL, AL
a0cc:    e1 a1 f6               st BL, [R_a1f6|0xa1f6]
a0cf:    e6 0e                  mov A, IL0(P)
a0d1:    b1 a1 f7               st A, [R_a1f7|0xa1f7]
a0d4:    81 a1 f5               ld AL, [R_a1f5|0xa1f5]
a0d7:    21 13                  dec AL, #4
a0d9:    15 27                  bnz L_a102
a0db:    91 a1 fa               ld A, [R_a1fa|0xa1fa]
a0de:    d0 07 ff               ld B, 0x07ff
a0e1:    5a                     and B, A
a0e2:    e1 a1 fb               st BL, [R_a1fb|0xa1fb]
a0e5:    45 23                  mov BL, BH
a0e7:    22 20                  clr BH, #0
a0e9:    07                     rl
a0ea:    36 00                  rrc A, #1
a0ec:    34 09                  srl A, #10
a0ee:    35 02                  sll A, #3
a0f0:    a1 a1 fc               st AL, [R_a1fc|0xa1fc]
a0f3:    2e 30 a1 fc a0 fb      rpf1 [R_a1fc|0xa1fc], [R_a0fb|0xa0fb]
a0f9:    3a                     clr A, #0
a0fa:    80 00                  ld AL, 0x00
a0fc:    35 02                  sll A, #3
a0fe:    58                     add B, A
a0ff:    f1 a1 f9               st B, [R_a1f9|0xa1f9]

L_a102:
a102:    47 9c 01 c0 a2 02      memset 0x02, 0xc0, [R_a1fd+5|0xa202]
a108:    47 9c 01 c0 a2 0a      memset 0x02, 0xc0, [R_a1fd+13|0xa20a]
a10e:    47 9c 01 c0 a2 12      memset 0x02, 0xc0, [R_a1fd+21|0xa212]
a114:    47 9c 03 c0 a2 1a      memset 0x04, 0xc0, [R_a1fd+29|0xa21a]
a11a:    47 9c 05 c0 a2 24      memset 0x06, 0xc0, [R_a1fd+39|0xa224]
a120:    80 06                  ld AL, 0x06
a122:    46 e2 90 a2 24 a1 f9   baseconv(e, 2) [R_a1fd+39|0xa224], [R_a1f9|0xa1f9]
a129:    80 04                  ld AL, 0x04
a12b:    46 e1 90 a2 1a a1 f7   baseconv(e, 1) [R_a1fd+29|0xa21a], [R_a1f7|0xa1f7]
a132:    80 02                  ld AL, 0x02
a134:    46 e0 90 a2 12 a1 f6   baseconv(e, 0) [R_a1fd+21|0xa212], [R_a1f6|0xa1f6]
a13b:    80 02                  ld AL, 0x02
a13d:    46 80 90 a2 0a a1 f4   baseconv(8, 0) [R_a1fd+13|0xa20a], [R_a1f4|0xa1f4]
a144:    80 02                  ld AL, 0x02
a146:    46 80 90 a2 02 a1 f5   baseconv(8, 0) [R_a1fd+5|0xa202], [R_a1f5|0xa1f5]
a14d:    81 a1 f4               ld AL, [R_a1f4|0xa1f4]
a150:    15 05                  bnz L_a157
a152:    61 01 03               ld X, [CurrentProcess|0x0103]
a155:    15 1a                  bnz L_a171

L_a157:
a157:    3a                     clr A, #0
a158:    81 01 3b               ld AL, [0x013b]
a15b:    3d                     sll A, #1
a15c:    d1 01 07               ld B, [0x0107]
a15f:    58                     add B, A
a160:    65 20                  ld X, [B]
a162:    91 a1 f7               ld A, [R_a1f7|0xa1f7]
a165:    d1 01 1d               ld B, [0x011d]
a168:    59                     sub B, A
a169:    11 33                  bnc L_a19e
a16b:    90 01 97               ld A, 0x0197
a16e:    59                     sub B, A
a16f:    19 2d                  ble L_a19e

L_a171:
a171:    d1 01 03               ld B, [CurrentProcess|0x0103]
a174:    51 42                  sub B, X
a176:    14 17                  bz L_a18f
a178:    95 48 10               ld A, [X + 0x10]
a17b:    d5 48 0c               ld B, [X + 0x0c]
a17e:    59                     sub B, A
a17f:    17 06                  bp L_a187
a181:    d0 a1 a4               ld B, Entry_0xa1a4|0xa1a4
a184:    f8                     st B, [A]
a185:    73 12                  jmp L_a199

L_a187:
a187:    83 6c                  ld AL, [R_a1f5|0xa1f5]
a189:    21 13                  dec AL, #4
a18b:    14 11                  bz L_a19e
a18d:    73 0a                  jmp L_a199

L_a18f:
a18f:    90 a1 a4               ld A, Entry_0xa1a4|0xa1a4

L_a192:
a192:    32 c0                  clr C, #0
a194:    d7 0e                  mov IL0(P), A
a196:    3a                     clr A, #0
a197:    d7 0c                  mov IL0(C), A

L_a199:
a199:    6b 33                  st X, [L_a1cd+1|0xa1ce]

R_a19b:
a19b:    7f 41                  pop {X}
a19d:    09                     ret

L_a19e:
a19e:    c6                     acquire_semaphore
a19f:    90 a1 ba               ld A, R_a1ba|0xa1ba
a1a2:    73 ee                  jmp L_a192

Entry_0xa1a4:
a1a4:    91 01 03               ld A, [CurrentProcess|0x0103]
a1a7:    95 08 0c               ld A, [A + 0x0c]
a1aa:    14 01                  bz L_a1ad
a1ac:    5f                     mov S, A

L_a1ad:
a1ad:    80 01                  ld AL, 0x01
a1af:    a1 01 25               st AL, [0x0125]
a1b2:    7b 19                  call L_a1cd
a1b4:    3a                     clr A, #0
a1b5:    39                     dec A, #1
a1b6:    5d                     mov B, A
a1b7:    66 09                  jsys 0x09
a1b9:    21 55                  dec XL, #6
a1bb:    ba                     st A, [X]
a1bc:    a2 4d 80               st AL, @[0x4d80]
a1bf:    01                     nop
a1c0:    a1 01 25               st AL, [0x0125]
a1c3:    7b 08                  call L_a1cd
a1c5:    79 a5 50               call R_a550
a1c8:    a2 2b 05               st AL, @[0x2b05]

L_a1cb:
a1cb:    73 fe                  jmp L_a1cb

L_a1cd:
a1cd:    d0 00 00               ld B, 0x0000
a1d0:    80 80                  ld AL, 0x80
a1d2:    a3 16                  st AL, [R_a1ea|0xa1ea]
a1d4:    7e 81                  push {Z}
a1d6:    7e 61                  push {Y}
a1d8:    7e 41                  push {X}
a1da:    55 98 a1 ea            mov Z, R_a1ea|0xa1ea
a1de:    95 28 08               ld A, [B + 0x08]
a1e1:    5b                     mov X, A
a1e2:    95 48 05               ld A, [X + 0x05]
a1e5:    95 08 0a               ld A, [A + 0x0a]
a1e8:    75 00                  jmp [A]

R_a1ea:
a1ea:    00
a1eb:    82
a1ec:    00
a1ed:    02
a1ee:    00
a1ef:    00
a1f0:    a1 '!'
a1f1:    fd '}'
a1f2:    <null bytes>


R_a1f4:
a1f4:    <null bytes>


R_a1f5:
a1f5:    00

R_a1f6:
a1f6:    00

R_a1f7:
a1f7:    00
a1f8:    00

R_a1f9:
a1f9:    00

R_a1fa:
a1fa:    00

R_a1fb:
a1fb:    00

R_a1fc:
a1fc:    00

R_a1fd:
a1fd:    44, "CD:XX, LVL:XX, MAP:XX, IAD:XXXX, EAD:XXXXXX\r"

R_a22b:
a22b:    13, "OPSYS ABORTED"

R_a23a:
a23a:    0f                     rsys
a23b:    <null bytes>


Syscall_59:
a24d:    80 01                  ld AL, 0x01
a24f:    d1 01 03               ld B, [CurrentProcess|0x0103]
a252:    7b 01                  call R_a255
a254:    0f                     rsys

R_a255:
a255:    7e 63                  push {Y, Z}
a257:    55 26                  mov Y, B
a259:    f5 a2                  st B, [--S]
a25b:    7b 2e                  call R_a28b
a25d:    16 26                  blt L_a285
a25f:    47 25 0f fd 60 46 60 46 memchr 0x10, 0xfd, [Y + 0x46], [Y + 0x46]
a267:    13 07                  bnn L_a270
a269:    79 a2 c7               call R_a2c7

R_a26c:
a26c:    79 86 12               call R_8612
a26f:    2c                     srl AL, #1

L_a270:
a270:    ac                     st AL, [Z]
a271:    9d                     ld A, [S]
a272:    d0 df ff               ld B, 0xdfff
a275:    c8                     ld BL, [A]
a276:    42 23                  and BL, BH
a278:    e8                     st BL, [A]
a279:    46 11 0d 08 00 00      addbig(1, 1) 0x08, [A + 0x00]
a27f:    0c                     unknown_0c
a280:    5e                     mov Z, A
a281:    79 88 6a               call R_886a
a284:    3a                     clr A, #0

L_a285:
a285:    30 a1                  inc S, #2
a287:    7f 63                  pop {Y, Z}
a289:    5d                     mov B, A
a28a:    09                     ret

R_a28b:
a28b:    7e 63                  push {Y, Z}
a28d:    a5 a2                  st AL, [--S]

L_a28f:
a28f:    90 01 44               ld A, 0x0144
a292:    47 12 00 a3 9b 00      unkblk1 0x01, [R_a39b|0xa39b], [A]
a298:    31 80                  dec Z, #1
a29a:    51 80                  sub A, Z
a29c:    51 12 00 10            sub B, A, 0x0010
a2a0:    18 0c                  bgt L_a2ae
a2a2:    8d                     ld AL, [S]
a2a3:    14 05                  bz L_a2aa
a2a5:    79 a2 ea               call R_a2ea
a2a8:    73 e5                  jmp L_a28f

L_a2aa:
a2aa:    3a                     clr A, #0
a2ab:    3b                     not A, #0
a2ac:    73 13                  jmp L_a2c1

L_a2ae:
a2ae:    cc                     ld BL, [Z]
a2af:    25 12                  sll AL, #3
a2b1:    29                     dec AL, #1

L_a2b2:
a2b2:    28                     inc AL, #1
a2b3:    20 00                  inc AH, #1
a2b5:    25 30                  sll BL, #1
a2b7:    10 f9                  bc L_a2b2

L_a2b9:
a2b9:    06                     sl
a2ba:    26 30                  rrc BL, #1
a2bc:    21 00                  dec AH, #1
a2be:    18 f9                  bgt L_a2b9
a2c0:    ec                     st BL, [Z]

L_a2c1:
a2c1:    30 a0                  inc S, #1
a2c3:    7f 63                  pop {Y, Z}
a2c5:    5d                     mov B, A
a2c6:    09                     ret

R_a2c7:
a2c7:    22 00                  clr AH, #0
a2c9:    6d a2                  st X, [--S]
a2cb:    78 10 00 08            mul A, A, 0x0008
a2cf:    a3 04                  st AL, [0xa2d5]
a2d1:    90 01 00               ld A, 0x0100
a2d4:    36 01                  rrc A, #2
a2d6:    45 10                  mov AH, AL
a2d8:    2b                     not AL, #0
a2d9:    50 34 01 44            add X, B, 0x0144
a2dd:    ca                     ld BL, [X]
a2de:    42 30                  and AH, BL
a2e0:    15 03                  bnz L_a2e5
a2e2:    71 a2 6c               jmp R_a26c

L_a2e5:
a2e5:    4a                     and BL, AL
a2e6:    ea                     st BL, [X]
a2e7:    65 a1                  ld X, [S++]
a2e9:    09                     ret

R_a2ea:
a2ea:    7e 63                  push {Y, Z}
a2ec:    55 67 01 03            mov Y, [CurrentProcess|0x0103]
a2f0:    8b                     ld AL, [Y]
a2f1:    c0 10                  ld BL, 0x10
a2f3:    4a                     and BL, AL
a2f4:    15 06                  bnz L_a2fc
a2f6:    55 42                  mov B, X
a2f8:    79 86 12               call R_8612
a2fb:    2e

L_a2fc:
a2fc:    c0 ff                  ld BL, 0xff
a2fe:    e3 60                  st BL, [L_a35f+1|0xa360]
a300:    c0 20                  ld BL, 0x20
a302:    43 13                  or BL, AL
a304:    eb                     st BL, [Y]
a305:    55 67 01 07            mov Y, [0x0107]
a309:    83 61                  ld AL, [0xa36c]
a30b:    14 03                  bz L_a310
a30d:    2a                     clr AL, #0
a30e:    a3 66                  st AL, [L_a375+1|0xa376]

L_a310:
a310:    95 61                  ld A, [Y++]
a312:    14 4b                  bz L_a35f
a314:    5e                     mov Z, A
a315:    8c                     ld AL, [Z]
a316:    c0 01                  ld BL, 0x01
a318:    4a                     and BL, AL
a319:    14 f5                  bz L_a310
a31b:    85 88 1e               ld AL, [Z + 0x1e]
a31e:    28                     inc AL, #1
a31f:    14 ef                  bz L_a310
a321:    95 88 08               ld A, [Z + 0x08]
a324:    c5 08 13               ld BL, [A + 0x13]
a327:    80 80                  ld AL, 0x80
a329:    4a                     and BL, AL
a32a:    15 22                  bnz L_a34e
a32c:    d0 0c 00               ld B, 0x0c00
a32f:    c5 88 12               ld BL, [Z + 0x12]
a332:    42 23                  and BL, BH
a334:    15 15                  bnz L_a34b
a336:    8c                     ld AL, [Z]
a337:    c0 80                  ld BL, 0x80
a339:    4a                     and BL, AL
a33a:    15 04                  bnz L_a340
a33c:    32 90 00 10            clr [Z + 0x0010], #0

L_a340:
a340:    8c                     ld AL, [Z]
a341:    c0 80                  ld BL, 0x80
a343:    43 13                  or BL, AL
a345:    80 fb                  ld AL, 0xfb
a347:    4a                     and BL, AL
a348:    ec                     st BL, [Z]
a349:    73 46                  jmp L_a391

L_a34b:
a34b:    2a                     clr AL, #0
a34c:    a3 12                  st AL, [L_a35f+1|0xa360]

L_a34e:
a34e:    8c                     ld AL, [Z]
a34f:    c0 20                  ld BL, 0x20
a351:    4a                     and BL, AL
a352:    14 3d                  bz L_a391
a354:    83 16                  ld AL, [0xa36c]
a356:    14 b8                  bz L_a310
a358:    83 1c                  ld AL, [L_a375+1|0xa376]
a35a:    28                     inc AL, #1
a35b:    a3 19                  st AL, [L_a375+1|0xa376]
a35d:    73 b1                  jmp L_a310

L_a35f:
a35f:    80 ff                  ld AL, 0xff
a361:    14 04                  bz L_a367
a363:    79 86 12               call R_8612
a366:    31

L_a367:
a367:    55 67 01 03            mov Y, [CurrentProcess|0x0103]
a36b:    80 ff                  ld AL, 0xff
a36d:    15 06                  bnz L_a375
a36f:    80 00                  ld AL, 0x00
a371:    15 06                  bnz L_a379
a373:    73 1c                  jmp L_a391

L_a375:
a375:    80 00                  ld AL, 0x00
a377:    a3 f7                  st AL, [0xa370]

L_a379:
a379:    2a                     clr AL, #0
a37a:    a3 f0                  st AL, [0xa36c]
a37c:    95 68 08               ld A, [Y + 0x08]
a37f:    d0 80 c9               ld B, R_80c9|0x80c9
a382:    79 8c 30               call R_8c30
a385:    79 87 22               call R_8722
a388:    80 c9                  ld AL, 0xc9
a38a:    83 e4                  ld AL, [0xa370]
a38c:    29                     dec AL, #1
a38d:    a3 e1                  st AL, [0xa370]
a38f:    73 07                  jmp L_a398

L_a391:
a391:    2a                     clr AL, #0
a392:    29                     dec AL, #1
a393:    a3 d7                  st AL, [0xa36c]
a395:    79 87 3a               call R_873a

L_a398:
a398:    7f 63                  pop {Y, Z}
a39a:    09                     ret

R_a39b:
a39b:    ff                     st B, [P]
a39c:    ff                     st B, [P]
a39d:    ff                     st B, [P]
a39e:    ff                     st B, [P]
a39f:    ff                     st B, [P]
a3a0:    ff                     st B, [P]
a3a1:    ff                     st B, [P]
a3a2:    ff                     st B, [P]
a3a3:    ff                     st B, [P]
a3a4:    ff                     st B, [P]
a3a5:    ff                     st B, [P]
a3a6:    ff                     st B, [P]
a3a7:    ff                     st B, [P]
a3a8:    ff                     st B, [P]
a3a9:    ff                     st B, [P]
a3aa:    ff                     st B, [P]
a3ab:    00                     HALT

R_a3ac:
a3ac:    95 a4                  ld A, @[S]
a3ae:    30 b1 00 00            inc [S + 0x0000], #2

R_a3b2:
a3b2:    f3 1d                  st B, [0xa3d1]
a3b4:    51 12 7f ff            sub B, A, 0x7fff
a3b8:    11 0d                  bnc L_a3c7

L_a3ba:
a3ba:    dd                     ld B, [S]
a3bb:    51 32 7f ff            sub B, B, 0x7fff
a3bf:    17 06                  bp L_a3c7
a3c1:    5d                     mov B, A
a3c2:    9d                     ld A, [S]
a3c3:    79 86 12               call R_8612
a3c6:    17

L_a3c7:
a3c7:    d1 01 03               ld B, [CurrentProcess|0x0103]
a3ca:    d5 28 0c               ld B, [B + 0x0c]
a3cd:    59                     sub B, A
a3ce:    10 ea                  bc L_a3ba
a3d0:    d0 00 00               ld B, 0x0000
a3d3:    09                     ret
a3d4:    42
a3d5:    f9 'y'
a3d6:    ff
a3d7:    83
a3d8:    ff
a3d9:    ff
a3da:    ff
a3db:    ff
a3dc:    8f
a3dd:    ff
a3de:    33
a3df:    2c
a3e0:    00
a3e1:    d0 'P'
a3e2:    00
a3e3:    00
a3e4:    7f
a3e5:    bf '?'
a3e6:    33
a3e7:    6f
a3e8:    ff
a3e9:    f3 's'
a3ea:    9f
a3eb:    ff
a3ec:    ff
a3ed:    bf '?'
a3ee:    1d
a3ef:    7f
a3f0:    ff
a3f1:    fe '~'
a3f2:    bf '?'

Syscall_GetUptimePtr:
a3f3:    7b 1d                  call L_a412
a3f5:    79 89 82               call R_8982
a3f8:    89                     ld AL, [B]
a3f9:    21 11                  dec AL, #2
a3fb:    14 05                  bz L_a402
a3fd:    79 a3 ac               call R_a3ac
a400:    73 02                  jmp L_a404

L_a402:
a402:    95 41                  ld A, [X++]

L_a404:
a404:    47 42 03 a4 5d 00      memcpy 0x04, [R_a45d|0xa45d], [A]
a40a:    0f                     rsys
a40b:    7b
a40c:    05
a40d:    93
a40e:    4e
a40f:    d3 'S'
a410:    4e
a411:    0f

L_a412:
a412:    c6                     acquire_semaphore
a413:    e6 a4                  mov A, IL10(X)
a415:    b3 46                  st A, [R_a45d|0xa45d]
a417:    e6 a6                  mov A, IL10(Y)
a419:    b3 44                  st A, [0xa45f]
a41b:    e6 a8                  mov A, IL10(Z)
a41d:    b6                     release_semaphore
a41e:    a3 0a                  st AL, [0xa42a]
a420:    81 01 70               ld AL, [0x0170]
a423:    22 00                  clr AH, #0
a425:    b3 3a                  st A, [R_a461|0xa461]
a427:    46 01 1c 00 a4 61      subbig(0, 1) 0x00, [R_a461|0xa461]
a42d:    46 01 6c 06 a4 61      unkbig6(0, 1) 0x06, [R_a461|0xa461]
a433:    46 13 00 a4 61 a4 5d   addbig(1, 3) [R_a461|0xa461], [R_a45d|0xa45d]
a43a:    09                     ret

DeletedSyscall_GetClock:
a43b:    55 60                  mov A, Y
a43d:    b5 a2                  st A, [--S]
a43f:    95 41                  ld A, [X++]
a441:    5c                     mov Y, A
a442:    79 89 82               call R_8982
a445:    89                     ld AL, [B]
a446:    21 11                  dec AL, #2
a448:    14 05                  bz L_a44f
a44a:    55 60                  mov A, Y
a44c:    79 a3 b2               call R_a3b2

L_a44f:
a44f:    47 42 07 01 30 06      memcpy 0x08, [ClockHours|0x0130], [Y]
a455:    2a                     clr AL, #0
a456:    a5 68 08               st AL, [Y + 0x08]
a459:    95 a1                  ld A, [S++]
a45b:    5c                     mov Y, A
a45c:    0f                     rsys

R_a45d:
a45d:    00
a45e:    00
a45f:    00
a460:    00

R_a461:
a461:    00
a462:    00

DeletedSyscall_1d:
a463:    85 41                  ld AL, [X++]
a465:    a5 a2                  st AL, [--S]
a467:    95 41                  ld A, [X++]
a469:    7b 16                  call L_a481
a46b:    85 a1                  ld AL, [S++]
a46d:    14 01                  bz L_a470
a46f:    0f                     rsys

L_a470:
a470:    91 01 03               ld A, [CurrentProcess|0x0103]
a473:    d0 04 00               ld B, 0x0400
a476:    c8                     ld BL, [A]
a477:    43 23                  or BL, BH
a479:    e8                     st BL, [A]
a47a:    79 87 3a               call R_873a
a47d:    0f                     rsys
a47e:    7b
a47f:    08
a480:    0f

L_a481:
a481:    d1 01 03               ld B, [CurrentProcess|0x0103]
a484:    b5 28 32               st A, [B + 0x32]
a487:    09                     ret
a488:    91
a489:    01
a48a:    03
a48b:    95
a48c:    08
a48d:    32
a48e:    09

R_a48f:
a48f:    90 a4 a7               ld A, level10Handler|0xa4a7
a492:    d7 ae                  mov IL10(P), A
a494:    90 a4 9f               ld A, R_a49f|0xa49f
a497:    d7 aa                  mov IL10(S), A
a499:    90 00 ff               ld A, 0x00ff
a49c:    d7 a8                  mov IL10(Z), A
a49e:    09                     ret

R_a49f:
a49f:    81 01 70               ld AL, [0x0170]
a4a2:    40 19                  add ZL, AL
a4a4:    16 16                  blt L_a4bc
a4a6:    0a                     reti

level10Handler:
a4a7:    81 01 41               ld AL, [Timeout|0x0141]
a4aa:    14 0d                  bz L_a4b9
a4ac:    80 f0                  ld AL, 0xf0
a4ae:    42 c1                  and AL, CH
a4b0:    15 0a                  bnz L_a4bc
a4b2:    32 20                  clr B, #0
a4b4:    80 08                  ld AL, 0x08
a4b6:    79 a0 8c               call R_a08c

L_a4b9:
a4b9:    29                     dec AL, #1
a4ba:    a4 ec                  st AL, [Timeout (via level10Handler+1)]

L_a4bc:
a4bc:    50 76 00 0a            add Y, Y, 0x000a
a4c0:    11 01                  bnc L_a4c3
a4c2:    3e                     inc X

L_a4c3:
a4c3:    30 10 01 36            inc [ClockSeconds|0x0136], #1
a4c7:    90 b9 00               ld A, 0xb900
a4ca:    d0 b6 b0               ld B, 0xb6b0
a4cd:    81 01 37               ld AL, [0x0137]	 ; SecondsOnes
a4d0:    41 01                  sub AL, AH
a4d2:    17 58                  bp L_a52c
a4d4:    e1 01 37               st BL, [0x0137]	 ; SecondsOnes
a4d7:    30 10 01 35            inc [0x0135], #1
a4db:    81 01 36               ld AL, [ClockSeconds|0x0136]
a4de:    41 21                  sub AL, BH
a4e0:    18 4a                  bgt L_a52c
a4e2:    e1 01 36               st BL, [ClockSeconds|0x0136]
a4e5:    30 10 01 33            inc [ClockMinutes|0x0133], #1
a4e9:    81 01 34               ld AL, [0x0134]	 ; MinutesOnes
a4ec:    41 01                  sub AL, AH
a4ee:    17 3c                  bp L_a52c
a4f0:    e1 01 34               st BL, [0x0134]	 ; MinutesOnes
a4f3:    30 10 01 32            inc [0x0132], #1
a4f7:    81 01 33               ld AL, [ClockMinutes|0x0133]
a4fa:    41 21                  sub AL, BH
a4fc:    18 2e                  bgt L_a52c
a4fe:    e1 01 33               st BL, [ClockMinutes|0x0133]
a501:    30 10 01 30            inc [ClockHours|0x0130], #1
a505:    91 01 30               ld A, [ClockHours|0x0130]
a508:    d0 b2 b4               ld B, 0xb2b4
a50b:    59                     sub B, A
a50c:    14 10                  bz L_a51e
a50e:    d0 b9 b0               ld B, 0xb9b0
a511:    41 21                  sub AL, BH
a513:    17 17                  bp L_a52c
a515:    e1 01 31               st BL, [0x0131]	 ; HoursOnes
a518:    30 10 01 2f            inc [0x012f], #1
a51c:    73 0e                  jmp L_a52c

L_a51e:
a51e:    90 b0 b0               ld A, 0xb0b0
a521:    b1 01 30               st A, [ClockHours|0x0130]
a524:    32 40                  clr X, #0
a526:    32 60                  clr Y, #0
a528:    30 10 87 55            inc [UptimeDays|0x8755], #1

L_a52c:
a52c:    6b 1d                  st X, [L_a54a+1|0xa54b]	 ; Stored X
a52e:    61 01 07               ld X, [0x0107]

L_a531:
a531:    95 41                  ld A, [X++]
a533:    14 15                  bz L_a54a
a535:    d5 08 32               ld B, [A + 0x32]
a538:    14 f7                  bz L_a531
a53a:    31 20                  dec B, #1
a53c:    f5 08 32               st B, [A + 0x32]
a53f:    15 f0                  bnz L_a531
a541:    d0 fb ff               ld B, 0xfbff
a544:    c8                     ld BL, [A]
a545:    42 23                  and BL, BH
a547:    e8                     st BL, [A]
a548:    73 e7                  jmp L_a531

L_a54a:
a54a:    60 00 00               ld X, 0x0000	 ; Stored X
a54d:    71 a4 9f               jmp R_a49f

R_a550:
a550:    91 01 03               ld A, [CurrentProcess|0x0103]
a553:    15 03                  bnz R_a558
a555:    92 01 07               ld A, @[0x0107]

R_a558:
a558:    95 08 08               ld A, [A + 0x08]
a55b:    d5 41                  ld B, [X++]
a55d:    7e 45                  push {X, Y, Z}
a55f:    65 21                  ld X, [B++]
a561:    55 17 00 0f            mov Y, [A + 0x000f]

L_a565:
a565:    55 98 01 f4            mov Z, 0x01f4
a569:    3f                     dec X
a56a:    16 28                  blt L_a594

L_a56c:
a56c:    31 80                  dec Z, #1
a56e:    14 24                  bz L_a594
a570:    f6 16 00               mov AL, Device[Y + 0x00]
a573:    52 10 00 02            and A, A, 0x0002
a577:    54 10 00 02            xor A, A, 0x0002
a57b:    15 ef                  bnz L_a56c
a57d:    80 8d                  ld AL, 0x8d
a57f:    45 10                  mov AH, AL
a581:    85 21                  ld AL, [B++]
a583:    41 10                  sub AH, AL
a585:    15 08                  bnz L_a58f
a587:    80 8a                  ld AL, 0x8a
a589:    f6 17 01               mov Device[Y + 0x01], AL
a58c:    0e                     dly
a58d:    80 8d                  ld AL, 0x8d

L_a58f:
a58f:    f6 17 01               mov Device[Y + 0x01], AL
a592:    73 d1                  jmp L_a565

L_a594:
a594:    7f 45                  pop {X, Y, Z}
a596:    09                     ret

R_a597:
a597:    95 41                  ld A, [X++]
a599:    6d a2                  st X, [--S]
a59b:    5b                     mov X, A

L_a59c:
a59c:    85 41                  ld AL, [X++]
a59e:    14 13                  bz L_a5b3
a5a0:    c0 e1                  ld BL, 0xe1
a5a2:    49                     sub BL, AL
a5a3:    16 f7                  blt L_a59c
a5a5:    c0 fb                  ld BL, 0xfb
a5a7:    49                     sub BL, AL
a5a8:    17 f2                  bp L_a59c
a5aa:    c0 df                  ld BL, 0xdf
a5ac:    42 31                  and AL, BL
a5ae:    a5 48 ff               st AL, [X + -0x1]
a5b1:    73 e9                  jmp L_a59c

L_a5b3:
a5b3:    65 a1                  ld X, [S++]
a5b5:    09                     ret

Syscall_4c:
a5b6:    55 40                  mov A, X
a5b8:    51 10 7f ff            sub A, A, 0x7fff
a5bc:    17 03                  bp L_a5c1
a5be:    79 85 72               call R_8572

L_a5c1:
a5c1:    d5 41                  ld B, [X++]
a5c3:    95 41                  ld A, [X++]
a5c5:    b3 0d                  st A, [0xa5d4]
a5c7:    f3 0d                  st B, [0xa5d6]
a5c9:    47 48 05 40 a5 d8      memcpy 0x06, [X], [R_a5d8|0xa5d8]
a5cf:    30 45                  inc X, #6
a5d1:    79 a6 0d               call R_a60d
a5d4:    00                     HALT
a5d5:    00                     HALT
a5d6:    00                     HALT
a5d7:    00                     HALT

R_a5d8:
a5d8:    ff                     st B, [P]
a5d9:    00                     HALT
a5da:    00                     HALT
a5db:    00                     HALT
a5dc:    00                     HALT
a5dd:    00                     HALT
a5de:    0f                     rsys

Syscall_CheckDiskStatus:
a5df:    79 a6 5c               call CheckDiskDeviceStatus
a5e2:    0f                     rsys
a5e3:    7e
a5e4:    63
a5e5:    55
a5e6:    00
a5e7:    15
a5e8:    03
a5e9:    79
a5ea:    8b
a5eb:    dc '\'
a5ec:    d5 'U'
a5ed:    41
a5ee:    55
a5ef:    28
a5f0:    79
a5f1:    a6 '&'
a5f2:    57
a5f3:    7f
a5f4:    63
a5f5:    0f
a5f6:    79
a5f7:    cf 'O'
a5f8:    1d
a5f9:    0f
a5fa:    79
a5fb:    85
a5fc:    72
a5fd:    79
a5fe:    86
a5ff:    e1 'a'
a600:    1f
a601:    9a
a602:    95
a603:    08
a604:    05
a605:    50
a606:    10
a607:    00
a608:    0e
a609:    79
a60a:    80
a60b:    4b
a60c:    0f

R_a60d:
a60d:    7e 61                  push {Y}
a60f:    95 41                  ld A, [X++]
a611:    d5 41                  ld B, [X++]
a613:    f5 a2                  st B, [--S]
a615:    b5 a2                  st A, [--S]
a617:    85 41                  ld AL, [X++]
a619:    79 cf 1d               call FindDiskDevice
a61c:    15 03                  bnz L_a621
a61e:    66 09                  jsys 0x09
a620:    06                     sl

L_a621:
a621:    85 68 13               ld AL, [Y + 0x13]
a624:    a5 a2                  st AL, [--S]
a626:    95 41                  ld A, [X++]
a628:    b5 a2                  st A, [--S]
a62a:    95 41                  ld A, [X++]
a62c:    b5 a2                  st A, [--S]
a62e:    85 41                  ld AL, [X++]
a630:    c0 80                  ld BL, 0x80
a632:    4a                     and BL, AL
a633:    14 02                  bz L_a637
a635:    c0 01                  ld BL, 0x01

L_a637:
a637:    e5 a2                  st BL, [--S]
a639:    c0 7f                  ld BL, 0x7f
a63b:    42 31                  and AL, BL
a63d:    a5 a2                  st AL, [--S]
a63f:    21 11                  dec AL, #2
a641:    19 03                  ble L_a646
a643:    66 09                  jsys 0x09
a645:    08                     cl

L_a646:
a646:    80 04                  ld AL, 0x04	 ; Function 3 = Write

CallDiskDeviceFunctionInternal:
    ; This calls a (private) disk driver function by number, bypassing publicity checks
    ; AL = function number + 1 (includes number of public funcs)
a648:    a5 a2                  st AL, [--S]
a64a:    66 06                  jsys Syscall_06
a64c:    1f                         arg1 = (0x1f)
a64d:    d6 67 01 3f            st Y, [ActiveDiskDevice|0x013f]
a651:    3a                     clr A, #0
a652:    85 a1                  ld AL, [S++]
a654:    71 80 44               jmp CallDeviceFunctionInternal

InitDiskDevice:
    ; Nothing jumps here directly, i can't find any references
a657:    5c                     mov Y, A
a658:    80 07                  ld AL, 0x07	 ; Init
a65a:    73 ec                  jmp CallDiskDeviceFunctionInternal

CheckDiskDeviceStatus:
    ; CheckDiskDeviceStatus syscall implementation
a65c:    79 cf 1d               call FindDiskDevice
a65f:    15 02                  bnz L_a663
a661:    5d                     mov B, A
a662:    09                     ret

L_a663:
a663:    80 05                  ld AL, 0x05	 ; Function 4 - CheckStatus
a665:    73 e1                  jmp CallDiskDeviceFunctionInternal

R_a667:
a667:    91 01 3f               ld A, [ActiveDiskDevice|0x013f]
a66a:    5c                     mov Y, A
a66b:    7e 21                  push {B}
a66d:    c0 07                  ld BL, 0x07
a66f:    85 68 01               ld AL, [Y + 0x01]
a672:    49                     sub BL, AL
a673:    14 08                  bz L_a67d
a675:    7f 21                  pop {B}
a677:    90 00 06               ld A, 0x0006	 ; Function 5
a67a:    71 80 44               jmp CallDeviceFunctionInternal

L_a67d:
a67d:    7f 21                  pop {B}
a67f:    90 00 0f               ld A, 0x000f
a682:    71 80 44               jmp CallDeviceFunctionInternal

CrtDeviceHooks:
a685:    73 1a                  L_731a
a687:    02
a688:    88
a689:    02
a68a:    95
a68b:    01
a68c:    81
a68d:    01
a68e:    98
a68f:    01
a690:    99
a691:    05
a692:    9b
a693:    03
a694:    86
a695:    04
a696:    9a
a697:    02
a698:    ff
a699:    02
a69a:    df '_'
a69b:    df '_'
a69c:    9f
a69d:    8d
a69e:    9d
a69f:    00
a6a0:    00
a6a1:    6d
a6a2:    a2 '"'
a6a3:    65
a6a4:    88
a6a5:    06
a6a6:    30
a6a7:    41
a6a8:    9a
a6a9:    d0 'P'
a6aa:    9b
a6ab:    b1 '1'
a6ac:    59
a6ad:    15
a6ae:    3c
a6af:    7e
a6b0:    45
a6b1:    91
a6b2:    00
a6b3:    5a
a6b4:    95
a6b5:    08
a6b6:    6e
a6b7:    39
a6b8:    5e
a6b9:    60
a6ba:    00
a6bb:    08
a6bc:    30
a6bd:    80
a6be:    3f
a6bf:    14
a6c0:    12
a6c1:    95
a6c2:    81
a6c3:    d5 'U'
a6c4:    68
a6c5:    1d
a6c6:    59
a6c7:    15
a6c8:    f3 's'
a6c9:    8c
a6ca:    14
a6cb:    04
a6cc:    66
a6cd:    07
a6ce:    73
a6cf:    f9 'y'
a6d0:    3a
a6d1:    39
a6d2:    ac ','
a6d3:    7f
a6d4:    45
a6d5:    85
a6d6:    48
a6d7:    03
a6d8:    c0 '@'
a6d9:    9f
a6da:    48
a6db:    e3 'c'
a6dc:    15
a6dd:    85
a6de:    48
a6df:    02
a6e0:    c0 '@'
a6e1:    9f
a6e2:    48
a6e3:    e3 'c'
a6e4:    0e
a6e5:    90
a6e6:    a6 '&'
a6e7:    ee 'n'
a6e8:    b5 '5'
a6e9:    88
a6ea:    06
a6eb:    65
a6ec:    a1 '!'
a6ed:    09

R_a6ee:
a6ee:    00
a6ef:    05
a6f0:    9b
a6f1:    d9 'Y'
a6f2:    00
a6f3:    00
a6f4:    00

WeirdExtra_HawkDeviceObj:
a6f5:    00 00                  (0x0)

HawkDeviceFunctions:
a6f7:    00 06                  (0x6)
a6f9:    ce 9e                  DiskDevice_Abort
a6fb:    cd f3                  DiskDevice_Read
a6fd:    ce 23                  DiskDevice_Write
a6ff:    a7 0b                  HawkDevice_BlockIO
a701:    a8 ae                  HawkDevice_CheckStatus
a703:    a8 c6                  R_a8c6
a705:    a8 d6                  HawkDevice_Init
a707:    cd 74                  DiskDevice_BlockIO_Special
a709:    ce cd                  R_cecd

HawkDevice_BlockIO:
a70b:    7f 01                  pop {A}
a70d:    b1 a8 a6               st A, [L_a8a5+1|0xa8a6]
a710:    85 a1                  ld AL, [S++]
a712:    a1 a7 e5               st AL, [R_a7e5|0xa7e5]
a715:    85 a1                  ld AL, [S++]
a717:    a1 a8 18               st AL, [R_a817+1|0xa818]
a71a:    d5 a1                  ld B, [S++]
a71c:    f1 a7 ec               st B, [R_a7ec|0xa7ec]
a71f:    d5 a1                  ld B, [S++]
a721:    f1 a7 e6               st B, [R_a7e6|0xa7e6]
a724:    85 a1                  ld AL, [S++]
a726:    a1 a7 e4               st AL, [R_a7e4|0xa7e4]
a729:    85 68 02               ld AL, [Y + 0x02]
a72c:    a1 a7 f4               st AL, [R_a7f4|0xa7f4]
a72f:    95 a1                  ld A, [S++]
a731:    b1 a7 e2               st A, [R_a7e2|0xa7e2]
a734:    95 68 0f               ld A, [Y + 0x0f]
a737:    d7 28                  mov IL2(Z), A
a739:    f6 31 0f               mov Device[A + 0x0f], BL
a73c:    95 a1                  ld A, [S++]
a73e:    b1 a7 e8               st A, [R_a7e8|0xa7e8]
a741:    91 01 03               ld A, [CurrentProcess|0x0103]
a744:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
a749:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
a74e:    c0 02                  ld BL, 0x02
a750:    2f 28                  ld_isr B
a752:    6d a2                  st X, [--S]

R_a754:
a754:    91 a7 e6               ld A, [R_a7e6|0xa7e6]
a757:    b1 a7 ea               st A, [R_a7ea|0xa7ea]
a75a:    d1 a7 e2               ld B, [R_a7e2|0xa7e2]
a75d:    79 cd 33               call R_cd33
a760:    55 20                  mov A, B
a762:    39                     dec A, #1
a763:    b3 17                  st A, [0xa77c]
a765:    90 00 1f               ld A, 0x001f
a768:    5a                     and B, A
a769:    38                     inc A, #1
a76a:    59                     sub B, A
a76b:    55 24                  mov X, B
a76d:    93 79                  ld A, [R_a7e8|0xa7e8]
a76f:    b3 7d                  st A, [R_a7ee|0xa7ee]

L_a771:
a771:    93 77                  ld A, [R_a7ea|0xa7ea]
a773:    d3 6d                  ld B, [R_a7e2|0xa7e2]
a775:    79 cd 33               call R_cd33
a778:    79 cc e8               call R_cce8
a77b:    90 00 00               ld A, 0x0000
a77e:    38                     inc A, #1
a77f:    b3 fb                  st A, [0xa77c]
a781:    51 20                  sub A, B
a783:    15 70                  bnz L_a7f5
a785:    f3 6b                  st B, [R_a7f2|0xa7f2]
a787:    93 61                  ld A, [R_a7ea|0xa7ea]
a789:    38                     inc A, #1
a78a:    b3 5e                  st A, [R_a7ea|0xa7ea]
a78c:    93 60                  ld A, [R_a7ee|0xa7ee]
a78e:    d0 01 90               ld B, 0x0190
a791:    59                     sub B, A
a792:    f3 5a                  st B, [R_a7ee|0xa7ee]
a794:    14 06                  bz L_a79c
a796:    11 04                  bnc L_a79c
a798:    3f                     dec X
a799:    18 d6                  bgt L_a771

L_a79b:
a79b:    06                     sl

L_a79c:
a79c:    93 4a                  ld A, [R_a7e8|0xa7e8]
a79e:    d3 4e                  ld B, [R_a7ee|0xa7ee]
a7a0:    10 02                  bc L_a7a4
a7a2:    32 20                  clr B, #0

L_a7a4:
a7a4:    59                     sub B, A
a7a5:    f3 47                  st B, [R_a7ee|0xa7ee]
a7a7:    93 41                  ld A, [R_a7ea|0xa7ea]
a7a9:    d3 3b                  ld B, [R_a7e6|0xa7e6]
a7ab:    59                     sub B, A
a7ac:    f3 42                  st B, [R_a7f0|0xa7f0]
a7ae:    93 36                  ld A, [R_a7e6|0xa7e6]
a7b0:    d3 30                  ld B, [R_a7e2|0xa7e2]
a7b2:    79 cd 33               call R_cd33
a7b5:    f3 33                  st B, [R_a7ea|0xa7ea]
a7b7:    16 20                  blt L_a7d9
a7b9:    2a                     clr AL, #0
a7ba:    a1 a8 49               st AL, [R_a849|0xa849]
a7bd:    95 68 11               ld A, [Y + 0x11]
a7c0:    35 03                  sll A, #4
a7c2:    32 20                  clr B, #0
a7c4:    c5 68 16               ld BL, [Y + 0x16]
a7c7:    78 32 00 03            mul B, B, 0x0003
a7cb:    58                     add B, A
a7cc:    30 21                  inc B, #2
a7ce:    55 20                  mov A, B
a7d0:    d3 18                  ld B, [R_a7ea|0xa7ea]
a7d2:    50 23 a7 f0            add B, B, [R_a7f0|0xa7f0]
a7d6:    59                     sub B, A
a7d7:    10 3e                  bc R_a817

L_a7d9:
a7d9:    93 0f                  ld A, [R_a7ea|0xa7ea]
a7db:    d0 ff ff               ld B, 0xffff
a7de:    c0 05                  ld BL, 0x05
a7e0:    66 6b                  jsys 0x6b

R_a7e2:
a7e2:    <null bytes>


R_a7e4:
a7e4:    <null bytes>


R_a7e5:
a7e5:    <null bytes>


R_a7e6:
a7e6:    <null bytes>


R_a7e8:
a7e8:    <null bytes>


R_a7ea:
a7ea:    <null bytes>


R_a7ec:
a7ec:    00
a7ed:    00

R_a7ee:
a7ee:    00
a7ef:    00

R_a7f0:
a7f0:    00
a7f1:    00

R_a7f2:
a7f2:    00
a7f3:    00

R_a7f4:
a7f4:    00

L_a7f5:
a7f5:    f3 08                  st B, [0xa7ff]
a7f7:    93 f1                  ld A, [R_a7ea|0xa7ea]
a7f9:    d3 eb                  ld B, [R_a7e6|0xa7e6]
a7fb:    59                     sub B, A
a7fc:    15 9d                  bnz L_a79b
a7fe:    90 00 00               ld A, 0x0000
a801:    b3 e7                  st A, [R_a7ea|0xa7ea]
a803:    b3 ed                  st A, [R_a7f2|0xa7f2]
a805:    90 00 01               ld A, 0x0001
a808:    b3 e6                  st A, [R_a7f0|0xa7f0]
a80a:    93 dc                  ld A, [R_a7e8|0xa7e8]
a80c:    d0 01 90               ld B, 0x0190
a80f:    59                     sub B, A
a810:    11 05                  bnc R_a817
a812:    90 01 90               ld A, 0x0190
a815:    b3 d7                  st A, [R_a7ee|0xa7ee]

R_a817:
a817:    80 00                  ld AL, 0x00
a819:    15 02                  bnz L_a81d
a81b:    80 0d                  ld AL, 0x0d

L_a81d:
a81d:    a1 a9 94               st AL, [R_a994|0xa994]
a820:    a3 23                  st AL, [L_a844+1|0xa845]
a822:    90 a9 87               ld A, level2Handler|0xa987
a825:    d7 2e                  mov IL2(P), A
a827:    85 68 0f               ld AL, [Y + 0x0f]
a82a:    c0 0c                  ld BL, 0x0c
a82c:    42 31                  and AL, BL
a82e:    25 11                  sll AL, #2
a830:    c0 04                  ld BL, 0x04
a832:    48                     add BL, AL
a833:    e3 01                  st BL, [0xa836]
a835:    2f 04                  dma_mode #0
a837:    2f 06                  enable_dma
a839:    e6 28                  mov A, IL2(Z)
a83b:    f6 11 0e               mov Device[A + 0x0e], AL
a83e:    f6 11 0c               mov Device[A + 0x0c], AL
a841:    79 ce 2a               call SetTimeout8

L_a844:
a844:    c0 00                  ld BL, 0x00
a846:    16 23                  blt L_a86b
a848:    80 00                  ld AL, 0x00
a84a:    14 07                  bz L_a853
a84c:    83 ca                  ld AL, [R_a817+1|0xa818]
a84e:    15 40                  bnz L_a890
a850:    71 ab 9a               jmp R_ab9a

L_a853:
a853:    79 ce 33               call CheckTimeout
a856:    14 ec                  bz L_a844
a858:    83 be                  ld AL, [R_a817+1|0xa818]
a85a:    14 06                  bz L_a862
a85c:    22 11                  clr AL, #1
a85e:    a3 e9                  st AL, [R_a849|0xa849]
a860:    73 2e                  jmp L_a890

L_a862:
a862:    3a                     clr A, #0
a863:    83 8f                  ld AL, [R_a7f4|0xa7f4]
a865:    d3 83                  ld B, [R_a7ea|0xa7ea]
a867:    c0 1d                  ld BL, 0x1d
a869:    66 6b                  jsys 0x6b

L_a86b:
a86b:    79 ce 41               call SetTimeout256
a86e:    93 80                  ld A, [R_a7f0|0xa7f0]
a870:    d1 a7 e6               ld B, [R_a7e6|0xa7e6]
a873:    58                     add B, A
a874:    f1 a7 e6               st B, [R_a7e6|0xa7e6]
a877:    91 a7 ee               ld A, [R_a7ee|0xa7ee]
a87a:    d1 a7 ec               ld B, [R_a7ec|0xa7ec]
a87d:    58                     add B, A
a87e:    f1 a7 ec               st B, [R_a7ec|0xa7ec]
a881:    d1 a7 e8               ld B, [R_a7e8|0xa7e8]
a884:    51 20                  sub A, B
a886:    b1 a7 e8               st A, [R_a7e8|0xa7e8]
a889:    14 05                  bz L_a890
a88b:    11 03                  bnc L_a890
a88d:    71 a7 54               jmp R_a754

L_a890:
a890:    79 ce 41               call SetTimeout256
a893:    c0 ff                  ld BL, 0xff
a895:    e1 01 1f               st BL, [0x011f]
a898:    65 a1                  ld X, [S++]
a89a:    95 a1                  ld A, [S++]
a89c:    5c                     mov Y, A
a89d:    3a                     clr A, #0
a89e:    c3 a9                  ld BL, [R_a849|0xa849]
a8a0:    14 03                  bz L_a8a5
a8a2:    91 aa b9               ld A, [R_aab9|0xaab9]

L_a8a5:
a8a5:    d0 00 00               ld B, 0x0000
a8a8:    7e 21                  push {B}
a8aa:    d1 aa b3               ld B, [R_aab3|0xaab3]
a8ad:    09                     ret

HawkDevice_CheckStatus:
a8ae:    2a                     clr AL, #0
a8af:    29                     dec AL, #1
a8b0:    a1 01 1f               st AL, [0x011f]
a8b3:    d5 68 0f               ld B, [Y + 0x0f]
a8b6:    85 68 13               ld AL, [Y + 0x13]
a8b9:    f6 13 00               mov Device[B + 0x00], AL
a8bc:    f6 02 04               mov A, Device[B + 0x04]
a8bf:    d0 00 90               ld B, 0x0090
a8c2:    5a                     and B, A
a8c3:    35 20                  sll B, #1
a8c5:    09                     ret

R_a8c6:
a8c6:    2a                     clr AL, #0
a8c7:    29                     dec AL, #1
a8c8:    a4 e7                  st AL, [0x011f (via 0xa8b0+1)]
a8ca:    c1 a8 45               ld BL, [L_a844+1|0xa845]
a8cd:    16 06                  blt L_a8d5
a8cf:    95 68 0f               ld A, [Y + 0x0f]
a8d2:    f6 31 0b               mov Device[A + 0x0b], BL

L_a8d5:
a8d5:    09                     ret

HawkDevice_Init:
a8d6:    7e 45                  push {X, Y, Z}
a8d8:    65 a8 08               ld X, [S + 0x08]
a8db:    91 01 03               ld A, [CurrentProcess|0x0103]
a8de:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
a8e3:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
a8e8:    c0 02                  ld BL, 0x02
a8ea:    2f 28                  ld_isr B
a8ec:    95 41                  ld A, [X++]
a8ee:    5c                     mov Y, A
a8ef:    b1 01 3f               st A, [ActiveDiskDevice|0x013f]
a8f2:    95 68 0f               ld A, [Y + 0x0f]
a8f5:    d7 28                  mov IL2(Z), A
a8f7:    f6 11 0f               mov Device[A + 0x0f], AL
a8fa:    95 41                  ld A, [X++]
a8fc:    b1 a7 ea               st A, [R_a7ea|0xa7ea]
a8ff:    b1 a7 e6               st A, [R_a7e6|0xa7e6]
a902:    95 41                  ld A, [X++]
a904:    b1 a7 ee               st A, [R_a7ee|0xa7ee]
a907:    b1 a7 e8               st A, [R_a7e8|0xa7e8]
a90a:    78 10 01 90            mul A, A, 0x0190
a90e:    55 00                  mov A, A
a910:    14 02                  bz L_a914
a912:    30 20                  inc B, #1

L_a914:
a914:    f1 a7 f0               st B, [R_a7f0|0xa7f0]
a917:    91 a7 ea               ld A, [R_a7ea|0xa7ea]
a91a:    39                     dec A, #1
a91b:    58                     add B, A
a91c:    f1 a7 f2               st B, [R_a7f2|0xa7f2]
a91f:    95 41                  ld A, [X++]
a921:    b1 a7 ec               st A, [R_a7ec|0xa7ec]
a924:    85 68 02               ld AL, [Y + 0x02]
a927:    a1 a7 f4               st AL, [R_a7f4|0xa7f4]
a92a:    85 68 13               ld AL, [Y + 0x13]
a92d:    a1 a7 e4               st AL, [R_a7e4|0xa7e4]
a930:    85 41                  ld AL, [X++]
a932:    6b 30                  st X, [0xa964]
a934:    20 12                  inc AL, #3
a936:    a1 a7 e5               st AL, [R_a7e5|0xa7e5]
a939:    21 12                  dec AL, #3
a93b:    15 05                  bnz L_a942
a93d:    32 01                  clr A, #1
a93f:    a1 a8 18               st AL, [R_a817+1|0xa818]

L_a942:
a942:    3a                     clr A, #0
a943:    a1 a8 49               st AL, [R_a849|0xa849]
a946:    55 60                  mov A, Y
a948:    b5 a2                  st A, [--S]
a94a:    b5 a2                  st A, [--S]
a94c:    90 a9 54               ld A, R_a954|0xa954
a94f:    b5 a2                  st A, [--S]
a951:    71 a8 17               jmp R_a817

R_a954:
a954:    b5 a2                  st A, [--S]
a956:    52 10 a0 00            and A, A, 0xa000
a95a:    14 03                  bz L_a95f
a95c:    71 ab 9a               jmp R_ab9a

L_a95f:
a95f:    95 a1                  ld A, [S++]
a961:    30 a1                  inc S, #2
a963:    60 00 00               ld X, 0x0000
a966:    ba                     st A, [X]
a967:    7f 45                  pop {X, Y, Z}
a969:    30 ba 00 02            inc [S + 0x0002], #11
a96d:    09                     ret

L_a96e:
a96e:    79 ab 8a               call R_ab8a
a971:    ac                     st AL, [Z]
a972:    2e 80 ff a1 a8 45      unk2e_9 [0xffa1], [L_a844+1|0xa845]

R_a978:
a978:    2a                     clr AL, #0
a979:    f6 19 03               mov Device[Z + 0x03], AL
a97c:    f6 19 0d               mov Device[Z + 0x0d], AL
a97f:    2f 07                  disable_dma
a981:    f6 19 0f               mov Device[Z + 0x0f], AL
a984:    0a                     reti
a985:    73 f1                  jmp R_a978

level2Handler:
a987:    f6 19 0f               mov Device[Z + 0x0f], AL
a98a:    f6 19 0e               mov Device[Z + 0x0e], AL
a98d:    32 40                  clr X, #0
a98f:    90 ac a7               ld A, FDCDeviceObj|0xaca7
a992:    5f                     mov S, A
a993:    80 00                  ld AL, 0x00
a995:    29                     dec AL, #1
a996:    a3 fc                  st AL, [R_a994|0xa994]
a998:    16 d4                  blt L_a96e
a99a:    81 a7 e4               ld AL, [R_a7e4|0xa7e4]
a99d:    f6 19 00               mov Device[Z + 0x00], AL
a9a0:    91 a7 ea               ld A, [R_a7ea|0xa7ea]
a9a3:    f6 09 01               mov Device[Z + 0x01], A
a9a6:    79 aa a0               call R_aaa0
a9a9:    79 aa 8d               call R_aa8d
a9ac:    d0 04 00               ld B, 0x0400
a9af:    5a                     and B, A
a9b0:    14 03                  bz L_a9b5

L_a9b2:
a9b2:    71 aa 5c               jmp R_aa5c

L_a9b5:
a9b5:    d0 00 20               ld B, 0x0020
a9b8:    5a                     and B, A
a9b9:    15 03                  bnz L_a9be
a9bb:    79 aa 6a               call R_aa6a

L_a9be:
a9be:    80 02                  ld AL, 0x02
a9c0:    f6 19 08               mov Device[Z + 0x08], AL
a9c3:    79 aa 6a               call R_aa6a
a9c6:    79 aa 8d               call R_aa8d
a9c9:    d0 04 00               ld B, 0x0400
a9cc:    5a                     and B, A
a9cd:    15 e3                  bnz L_a9b2
a9cf:    d0 00 20               ld B, 0x0020
a9d2:    5a                     and B, A
a9d3:    14 dd                  bz L_a9b2
a9d5:    81 a7 e5               ld AL, [R_a7e5|0xa7e5]
a9d8:    14 78                  bz L_aa52
a9da:    29                     dec AL, #1
a9db:    14 55                  bz L_aa32
a9dd:    29                     dec AL, #1
a9de:    14 05                  bz L_a9e5
a9e0:    29                     dec AL, #1
a9e1:    14 5e                  bz L_aa41
a9e3:    73 31                  jmp L_aa16

L_a9e5:
a9e5:    81 a7 e4               ld AL, [R_a7e4|0xa7e4]
a9e8:    79 aa 82               call R_aa82
a9eb:    e0 00                  st BL, 0x00
a9ed:    23 30                  not BL, #0
a9ef:    f6 39 03               mov Device[Z + 0x03], BL
a9f2:    79 aa 8d               call R_aa8d
a9f5:    d0 00 40               ld B, 0x0040
a9f8:    5a                     and B, A
a9f9:    15 5a                  bnz L_aa55
a9fb:    83 ef                  ld AL, [0xa9ec]
a9fd:    f6 19 03               mov Device[Z + 0x03], AL
aa00:    79 aa 8d               call R_aa8d
aa03:    d0 00 40               ld B, 0x0040
aa06:    5a                     and B, A
aa07:    14 4c                  bz L_aa55
aa09:    d0 00 80               ld B, 0x0080
aa0c:    5a                     and B, A
aa0d:    14 03                  bz L_aa12
aa0f:    71 ab 20               jmp R_ab20

L_aa12:
aa12:    80 01                  ld AL, 0x01
aa14:    73 1c                  jmp L_aa32

L_aa16:
aa16:    7b 75                  call R_aa8d
aa18:    d0 00 80               ld B, 0x0080
aa1b:    5a                     and B, A
aa1c:    14 03                  bz L_aa21
aa1e:    71 ab 20               jmp R_ab20

L_aa21:
aa21:    7b 7d                  call R_aaa0
aa23:    81 a7 e4               ld AL, [R_a7e4|0xa7e4]
aa26:    7b 5a                  call R_aa82
aa28:    f6 39 03               mov Device[Z + 0x03], BL
aa2b:    80 06                  ld AL, 0x06
aa2d:    f6 19 08               mov Device[Z + 0x08], AL
aa30:    80 05                  ld AL, 0x05

L_aa32:
aa32:    f6 19 08               mov Device[Z + 0x08], AL
aa35:    79 aa be               call R_aabe
aa38:    81 a7 e5               ld AL, [R_a7e5|0xa7e5]
aa3b:    29                     dec AL, #1
aa3c:    14 14                  bz L_aa52
aa3e:    29                     dec AL, #1
aa3f:    15 11                  bnz L_aa52

L_aa41:
aa41:    7b 5d                  call R_aaa0
aa43:    7b 48                  call R_aa8d
aa45:    91 a7 ea               ld A, [R_a7ea|0xa7ea]
aa48:    f6 09 01               mov Device[Z + 0x01], A
aa4b:    80 04                  ld AL, 0x04
aa4d:    f6 19 08               mov Device[Z + 0x08], AL
aa50:    7b 6c                  call R_aabe

L_aa52:
aa52:    71 a9 73               jmp R_a973

L_aa55:
aa55:    7b 58                  call L_aaaf
aa57:    79 ab 8a               call R_ab8a
aa5a:    ac                     st AL, [Z]
aa5b:    34 7b 51 7b            srl [Y + 0x517b], #12
aa5f:    2d                     sll AL, #1
aa60:    80 03                  ld AL, 0x03
aa62:    f6 19 08               mov Device[Z + 0x08], AL
aa65:    7b 03                  call R_aa6a
aa67:    71 ab 18               jmp R_ab18

R_aa6a:
aa6a:    55 46                  mov Y, X
aa6c:    65 a1                  ld X, [S++]

L_aa6e:
aa6e:    0a                     reti
aa6f:    f6 19 0f               mov Device[Z + 0x0f], AL
aa72:    7b 19                  call R_aa8d
aa74:    81 a7 e4               ld AL, [R_a7e4|0xa7e4]
aa77:    2c                     srl AL, #1
aa78:    7b 08                  call R_aa82
aa7a:    f6 08 04               mov A, Device[Z + 0x04]
aa7d:    4a                     and BL, AL
aa7e:    14 ee                  bz L_aa6e
aa80:    75 60                  jmp [Y]

R_aa82:
aa82:    c0 01                  ld BL, 0x01
aa84:    73 03                  jmp L_aa89

L_aa86:
aa86:    07                     rl
aa87:    27 30                  rlc BL, #1

L_aa89:
aa89:    29                     dec AL, #1
aa8a:    17 fa                  bp L_aa86
aa8c:    09                     ret

R_aa8d:
aa8d:    f6 08 04               mov A, Device[Z + 0x04]
aa90:    d0 02 00               ld B, 0x0200
aa93:    5a                     and B, A
aa94:    15 26                  bnz L_aabc
aa96:    d0 00 10               ld B, 0x0010
aa99:    5a                     and B, A
aa9a:    15 03                  bnz L_aa9f
aa9c:    71 ab 72               jmp R_ab72

L_aa9f:
aa9f:    09                     ret

R_aaa0:
aaa0:    91 a7 ee               ld A, [R_a7ee|0xa7ee]
aaa3:    3b                     not A, #0
aaa4:    2f 02                  ld_dma_count A
aaa6:    d1 a7 ec               ld B, [R_a7ec|0xa7ec]
aaa9:    2f 20                  ld_dma_addr B
aaab:    59                     sub B, A
aaac:    f3 51                  st B, [L_aafe+1|0xaaff]
aaae:    09                     ret

L_aaaf:
aaaf:    f6 28 01               mov B, Device[Z + 0x01]
aab2:    f0 00 00               st B, 0x0000
aab5:    f6 28 04               mov B, Device[Z + 0x04]
aab8:    f0 00 00               st B, 0x0000
aabb:    09                     ret

L_aabc:
aabc:    73 7e                  jmp L_ab3c

R_aabe:
aabe:    55 46                  mov Y, X
aac0:    65 a1                  ld X, [S++]

L_aac2:
aac2:    3a                     clr A, #0
aac3:    d7 12                  mov IL1(B), A
aac5:    0a                     reti
aac6:    f6 19 0f               mov Device[Z + 0x0f], AL
aac9:    e6 12                  mov A, IL1(B)
aacb:    5d                     mov B, A
aacc:    14 09                  bz L_aad7
aace:    7b df                  call L_aaaf
aad0:    b3 e7                  st A, [R_aab9|0xaab9]
aad2:    79 ab 8a               call R_ab8a
aad5:    ac                     st AL, [Z]
aad6:    75                     unknown

L_aad7:
aad7:    7b b4                  call R_aa8d
aad9:    d0 01 00               ld B, 0x0100
aadc:    5a                     and B, A
aadd:    15 e3                  bnz L_aac2
aadf:    d0 f0 00               ld B, 0xf000
aae2:    5a                     and B, A
aae3:    14 09                  bz L_aaee
aae5:    d0 20 00               ld B, 0x2000
aae8:    5a                     and B, A
aae9:    14 2b                  bz L_ab16
aaeb:    71 aa 5c               jmp R_aa5c

L_aaee:
aaee:    f6 08 01               mov A, Device[Z + 0x01]
aaf1:    d1 a7 f2               ld B, [R_a7f2|0xa7f2]
aaf4:    59                     sub B, A
aaf5:    14 07                  bz L_aafe
aaf7:    7b b6                  call L_aaaf
aaf9:    79 ab 8a               call R_ab8a
aafc:    ac                     st AL, [Z]
aafd:    6c

L_aafe:
aafe:    90 00 00               ld A, 0x0000
ab01:    2f 21                  st_dma_addr B
ab03:    58                     add B, A
ab04:    2f 03                  st_dma_count A
ab06:    59                     sub B, A
ab07:    14 06                  bz L_ab0f

L_ab09:
ab09:    7b a4                  call L_aaaf
ab0b:    7b 7d                  call R_ab8a
ab0d:    ac                     st AL, [Z]
ab0e:    29                     dec AL, #1

L_ab0f:
ab0f:    38                     inc A, #1
ab10:    18 f7                  bgt L_ab09
ab12:    16 02                  blt L_ab16
ab14:    75 60                  jmp [Y]

L_ab16:
ab16:    7b 97                  call L_aaaf

R_ab18:
ab18:    f6 19 0b               mov Device[Z + 0x0b], AL
ab1b:    7b 4d                  call R_ab6a
ab1d:    71 a9 87               jmp level2Handler

R_ab20:
ab20:    7b 55                  call L_ab77
ab22:    b1 ac 3d               st A, [R_ac38+5|0xac3d]

L_ab25:
ab25:    79 ab d6               call R_abd6
ab28:    ac                     st AL, [Z]
ab29:    38                     inc A, #1
ab2a:    d0 00 80               ld B, 0x0080
ab2d:    5a                     and B, A
ab2e:    15 f5                  bnz L_ab25
ab30:    7b 38                  call R_ab6a
ab32:    81 a9 94               ld AL, [R_a994|0xa994]
ab35:    28                     inc AL, #1
ab36:    a1 a9 94               st AL, [R_a994|0xa994]
ab39:    71 a9 87               jmp level2Handler

L_ab3c:
ab3c:    80 03                  ld AL, 0x03
ab3e:    f6 19 08               mov Device[Z + 0x08], AL
ab41:    90 ac 41               ld A, R_ac41|0xac41

L_ab44:
ab44:    b3 0a                  st A, [0xab50]
ab46:    7b 2f                  call L_ab77
ab48:    d3 06                  ld B, [0xab50]
ab4a:    b5 28 06               st A, [B + 0x06]

L_ab4d:
ab4d:    79 ab d6               call R_abd6
ab50:    00                     HALT
ab51:    00                     HALT
ab52:    d0 02 00               ld B, 0x0200
ab55:    5a                     and B, A
ab56:    15 f5                  bnz L_ab4d
ab58:    d0 00 10               ld B, 0x0010
ab5b:    5a                     and B, A
ab5c:    14 ef                  bz L_ab4d
ab5e:    7b 0a                  call R_ab6a
ab60:    81 a9 94               ld AL, [R_a994|0xa994]
ab63:    28                     inc AL, #1
ab64:    a1 a9 94               st AL, [R_a994|0xa994]
ab67:    71 a9 87               jmp level2Handler

R_ab6a:
ab6a:    7b 5f                  call L_abcb
ab6c:    32 25                  clr B, #5
ab6e:    f5 08 32               st B, [A + 0x32]
ab71:    09                     ret

R_ab72:
ab72:    90 ac 4b               ld A, R_ac4b|0xac4b
ab75:    73 cd                  jmp L_ab44

L_ab77:
ab77:    80 a0                  ld AL, 0xa0
ab79:    a3 0d                  st AL, [0xab88]
ab7b:    3a                     clr A, #0
ab7c:    81 a7 f4               ld AL, [R_a7f4|0xa7f4]
ab7f:    79 ce d6               call R_ced6
ab82:    ab                     st AL, [Y]
ab83:    89                     ld AL, [B]
ab84:    93 02                  ld A, [0xab88]
ab86:    09                     ret
ab87:    00
ab88:    a0 ' '

R_ab89:
ab89:    a0 ' '

R_ab8a:
ab8a:    95 41                  ld A, [X++]
ab8c:    b3 1a                  st A, [0xaba8]
ab8e:    80 01                  ld AL, 0x01
ab90:    a1 a8 49               st AL, [R_a849|0xa849]

L_ab93:
ab93:    65 a1                  ld X, [S++]
ab95:    15 fc                  bnz L_ab93
ab97:    71 a9 78               jmp R_a978

R_ab9a:
ab9a:    93 0c                  ld A, [0xaba8]
ab9c:    15 07                  bnz L_aba5
ab9e:    3a                     clr A, #0
ab9f:    39                     dec A, #1
aba0:    5d                     mov B, A
aba1:    c0 1c                  ld BL, 0x1c
aba3:    66 6b                  jsys 0x6b

L_aba5:
aba5:    79 a5 50               call R_a550
aba8:    00                     HALT
aba9:    00                     HALT
abaa:    91 aa b9               ld A, [R_aab9|0xaab9]
abad:    79 ce b3               call R_ceb3
abb0:    ac                     st AL, [Z]
abb1:    66 7b                  jsys 0x7b
abb3:    c3 b1                  ld BL, [0xab66]
abb5:    ac                     st AL, [Z]
abb6:    5e                     mov Z, A
abb7:    91 aa b3               ld A, [R_aab3|0xaab3]
abba:    79 ce b3               call R_ceb3
abbd:    ac                     st AL, [Z]
abbe:    61 79 a5               ld X, [0x79a5]
abc1:    50 ac                  add C, S
abc3:    55 3a 39 5d            mov S, 0x395d
abc7:    c0 0d                  ld BL, 0x0d
abc9:    66 6b                  jsys 0x6b

L_abcb:
abcb:    3a                     clr A, #0
abcc:    81 01 1f               ld AL, [0x011f]
abcf:    3d                     sll A, #1
abd0:    d1 01 07               ld B, [0x0107]
abd3:    58                     add B, A
abd4:    99                     ld A, [B]
abd5:    09                     ret

R_abd6:
abd6:    95 41                  ld A, [X++]
abd8:    b3 0f                  st A, [0xabe9]
abda:    81 01 25               ld AL, [0x0125]
abdd:    a5 a2                  st AL, [--S]
abdf:    32 01                  clr A, #1
abe1:    a1 01 25               st AL, [0x0125]
abe4:    7b e5                  call L_abcb
abe6:    79 a5 58               call R_a558
abe9:    00                     HALT
abea:    00                     HALT
abeb:    79 ab 6a               call R_ab6a
abee:    85 a1                  ld AL, [S++]
abf0:    a1 01 25               st AL, [0x0125]

L_abf3:
abf3:    22 30                  clr BL, #0
abf5:    e1 01 41               st BL, [Timeout|0x0141]
abf8:    7b d1                  call L_abcb
abfa:    95 08 32               ld A, [A + 0x32]
abfd:    18 f4                  bgt L_abf3
abff:    7b ca                  call L_abcb
ac01:    d5 08 08               ld B, [A + 0x08]
ac04:    85 28 13               ld AL, [B + 0x13]
ac07:    2d                     sll AL, #1
ac08:    14 1b                  bz L_ac25
ac0a:    10 19                  bc L_ac25
ac0c:    2a                     clr AL, #0
ac0d:    a5 28 13               st AL, [B + 0x13]
ac10:    81 01 3e               ld AL, [0x013e]
ac13:    29                     dec AL, #1
ac14:    a1 01 3e               st AL, [0x013e]
ac17:    7b b2                  call L_abcb
ac19:    32 20                  clr B, #0
ac1b:    31 20                  dec B, #1
ac1d:    f5 08 32               st B, [A + 0x32]
ac20:    79 ab 8a               call R_ab8a
ac23:    00                     HALT
ac24:    00                     HALT

L_ac25:
ac25:    f6 08 04               mov A, Device[Z + 0x04]
ac28:    09                     ret

R_ac29:
ac29:    3, "DMA"

R_ac2e:
ac2e:    4, "DISK"

R_ac34:
ac34:    2, "WE"

R_ac38:
ac38:    7, "WP   \x07\r"

R_ac41:
ac41:    8, "FLT NN\x07\r"

R_ac4b:
ac4b:    8, "ATN NN\x07\r"

R_ac55:
ac55:    21, " FAIL:  X XXXX XXXX\x07\r"

R_ac6c:
ac6c:    7, "DMA LAG"

R_ac75:
ac75:    8, "DMA STAT"
ac7f:    <null bytes>


FDCDeviceObj:
aca7:    00 06                  (0x6)
aca9:    ce 9e                  DiskDevice_Abort
acab:    cd f3                  DiskDevice_Read
acad:    ce 23                  DiskDevice_Write
acaf:    ac b9                  R_acb9
acb1:    ae 6e                  R_ae6e
acb3:    ae eb                  R_aeeb
acb5:    af 05                  R_af05
acb7:    cd 74                  DiskDevice_BlockIO_Special

R_acb9:
acb9:    7f 01                  pop {A}
acbb:    b1 ad e0               st A, [R_ade0|0xade0]
acbe:    79 ae 57               call R_ae57
acc1:    85 a8 06               ld AL, [S + 0x06]
acc4:    a1 ad ec               st AL, [R_adec|0xadec]
acc7:    55 80                  mov A, Z
acc9:    b5 a2                  st A, [--S]
accb:    7b 02                  call R_accf
accd:    73 32                  jmp R_ad01

R_accf:
accf:    79 af fe               call R_affe
acd2:    95 68 0f               ld A, [Y + 0x0f]
acd5:    5e                     mov Z, A
acd6:    80 60                  ld AL, 0x60
acd8:    f6 19 00               mov Device[Z + 0x00], AL
acdb:    79 af bb               call R_afbb
acde:    85 68 13               ld AL, [Y + 0x13]
ace1:    c0 80                  ld BL, 0x80
ace3:    48                     add BL, AL
ace4:    f6 39 00               mov Device[Z + 0x00], BL
ace7:    79 af fe               call R_affe
acea:    80 55                  ld AL, 0x55
acec:    f6 19 00               mov Device[Z + 0x00], AL
acef:    79 af e3               call R_afe3
acf2:    01                     nop
acf3:    d0 00 c0               ld B, 0x00c0
acf6:    f6 18 00               mov AL, Device[Z + 0x00]
acf9:    16 02                  blt L_acfd
acfb:    34 20                  srl B, #1

L_acfd:
acfd:    f5 68 11               st B, [Y + 0x11]
ad00:    09                     ret

R_ad01:
ad01:    90 ad ef               ld A, R_adef|0xadef
ad04:    5e                     mov Z, A
ad05:    95 a8 04               ld A, [S + 0x04]
ad08:    b3 78                  st A, [L_ad81+1|0xad82]
ad0a:    3a                     clr A, #0
ad0b:    b3 63                  st A, [0xad70]
ad0d:    85 a8 02               ld AL, [S + 0x02]
ad10:    14 11                  bz L_ad23
ad12:    c0 88                  ld BL, 0x88
ad14:    29                     dec AL, #1
ad15:    14 02                  bz L_ad19
ad17:    c0 91                  ld BL, 0x91

L_ad19:
ad19:    e3 0e                  st BL, [L_ad28+1|0xad29]
ad1b:    95 a8 0b               ld A, [S + 0x0b]
ad1e:    15 03                  bnz L_ad23
ad20:    71 ad c2               jmp R_adc2

L_ad23:
ad23:    80 ff                  ld AL, 0xff
ad25:    a1 ad ee               st AL, [R_aded+1|0xadee]

L_ad28:
ad28:    80 00                  ld AL, 0x00
ad2a:    a5 81                  st AL, [Z++]
ad2c:    95 a8 06               ld A, [S + 0x06]
ad2f:    d5 a8 09               ld B, [S + 0x09]
ad32:    79 cd 33               call R_cd33
ad35:    78 30 00 14            mul A, B, 0x0014
ad39:    a5 81                  st AL, [Z++]
ad3b:    22 00                  clr AH, #0
ad3d:    81 ad ee               ld AL, [R_aded+1|0xadee]
ad40:    28                     inc AL, #1
ad41:    14 05                  bz L_ad48
ad43:    29                     dec AL, #1
ad44:    51 20                  sub A, B
ad46:    15 39                  bnz L_ad81

L_ad48:
ad48:    e1 ad ee               st BL, [R_aded+1|0xadee]
ad4b:    85 a8 02               ld AL, [S + 0x02]
ad4e:    14 31                  bz L_ad81
ad50:    d5 a8 0b               ld B, [S + 0x0b]
ad53:    95 a8 06               ld A, [S + 0x06]
ad56:    38                     inc A, #1
ad57:    b5 a8 06               st A, [S + 0x06]
ad5a:    2a                     clr AL, #0
ad5b:    a5 81                  st AL, [Z++]
ad5d:    90 01 90               ld A, 0x0190
ad60:    59                     sub B, A
ad61:    11 03                  bnc L_ad66
ad63:    95 a8 0b               ld A, [S + 0x0b]

L_ad66:
ad66:    b5 81                  st A, [Z++]
ad68:    d5 a8 04               ld B, [S + 0x04]
ad6b:    58                     add B, A
ad6c:    f5 a8 04               st B, [S + 0x04]
ad6f:    d0 00 00               ld B, 0x0000
ad72:    58                     add B, A
ad73:    f3 fb                  st B, [0xad70]
ad75:    d5 a8 0b               ld B, [S + 0x0b]
ad78:    51 20                  sub A, B
ad7a:    b5 a8 0b               st A, [S + 0x0b]
ad7d:    15 a9                  bnz L_ad28
ad7f:    95 81                  ld A, [Z++]

L_ad81:
ad81:    90 00 00               ld A, 0x0000
ad84:    b5 88 fe               st A, [Z + -0x2]
ad87:    93 e7                  ld A, [0xad70]
ad89:    bc                     st A, [Z]
ad8a:    90 ad ed               ld A, R_aded|0xaded
ad8d:    51 80                  sub A, Z
ad8f:    a3 59                  st AL, [0xadea]
ad91:    85 a8 03               ld AL, [S + 0x03]
ad94:    a1 af 46               st AL, [R_af45+1|0xaf46]

L_ad97:
ad97:    79 af 45               call R_af45
ad9a:    ad                     st AL, [S]
ad9b:    e8                     st BL, [A]
ad9c:    4d                     mov BL, AL
ad9d:    15 23                  bnz R_adc2
ad9f:    85 a8 02               ld AL, [S + 0x02]
ada2:    14 1e                  bz R_adc2
ada4:    83 49                  ld AL, [R_adef|0xadef]
ada6:    c0 91                  ld BL, 0x91
ada8:    49                     sub BL, AL
ada9:    14 03                  bz L_adae
adab:    71 ad 01               jmp R_ad01

L_adae:
adae:    90 ad ef               ld A, R_adef|0xadef
adb1:    31 81                  dec Z, #2

L_adb3:
adb3:    55 82                  mov B, Z
adb5:    59                     sub B, A
adb6:    10 df                  bc L_ad97
adb8:    c0 8e                  ld BL, 0x8e
adba:    e8                     st BL, [A]
adbb:    d0 00 05               ld B, 0x0005
adbe:    50 20                  add A, B
adc0:    73 f1                  jmp L_adb3

R_adc2:
adc2:    a3 22                  st AL, [0xade6]
adc4:    95 a8 09               ld A, [S + 0x09]
adc7:    95 a1                  ld A, [S++]
adc9:    5e                     mov Z, A
adca:    d5 a8 04               ld B, [S + 0x04]
adcd:    31 20                  dec B, #1
adcf:    90 00 0b               ld A, 0x000b
add2:    50 0a                  add S, A
add4:    95 a1                  ld A, [S++]
add6:    5c                     mov Y, A
add7:    80 ff                  ld AL, 0xff
add9:    a1 01 1f               st AL, [0x011f]
addc:    2a                     clr AL, #0
addd:    a3 7c                  st AL, [L_ae5a+1|0xae5b]
addf:    90 00 00               ld A, 0x0000
ade2:    7e 01                  push {A}
ade4:    90 00 00               ld A, 0x0000
ade7:    09                     ret

R_ade8:
ade8:    00
ade9:    00
adea:    00
adeb:    81

R_adec:
adec:    00

R_aded:
aded:    83 00                  ld AL, [R_adef|0xadef]

R_adef:
adef:    <null bytes>


R_ae57:
ae57:    79 ce 2a               call SetTimeout8

L_ae5a:
ae5a:    80 00                  ld AL, 0x00
ae5c:    14 08                  bz L_ae66
ae5e:    79 ce 33               call CheckTimeout
ae61:    14 f7                  bz L_ae5a
ae63:    71 b0 12               jmp R_b012

L_ae66:
ae66:    79 ce 41               call SetTimeout256
ae69:    80 01                  ld AL, 0x01
ae6b:    a3 ee                  st AL, [L_ae5a+1|0xae5b]
ae6d:    09                     ret

R_ae6e:
ae6e:    7b e7                  call R_ae57
ae70:    7e 41                  push {X}
ae72:    65 68 0f               ld X, [Y + 0x0f]

L_ae75:
ae75:    79 af fe               call R_affe
ae78:    80 ff                  ld AL, 0xff
ae7a:    f6 15 00               mov Device[X + 0x00], AL
ae7d:    79 af fe               call R_affe
ae80:    45 11                  mov AL, AL
ae82:    15 0b                  bnz L_ae8f
ae84:    7f 41                  pop {X}
ae86:    a3 d3                  st AL, [L_ae5a+1|0xae5b]
ae88:    29                     dec AL, #1
ae89:    a1 01 1f               st AL, [0x011f]
ae8c:    32 20                  clr B, #0
ae8e:    09                     ret

L_ae8f:
ae8f:    80 60                  ld AL, 0x60
ae91:    f6 15 00               mov Device[X + 0x00], AL
ae94:    79 af bb               call R_afbb
ae97:    85 68 13               ld AL, [Y + 0x13]
ae9a:    c0 80                  ld BL, 0x80
ae9c:    48                     add BL, AL
ae9d:    f6 35 00               mov Device[X + 0x00], BL
aea0:    79 af e3               call R_afe3
aea3:    01                     nop
aea4:    f6 14 00               mov AL, Device[X + 0x00]
aea7:    14 05                  bz L_aeae
aea9:    f6 15 01               mov Device[X + 0x01], AL
aeac:    73 c7                  jmp L_ae75

L_aeae:
aeae:    80 52                  ld AL, 0x52
aeb0:    f6 15 00               mov Device[X + 0x00], AL
aeb3:    79 af e3               call R_afe3
aeb6:    01                     nop
aeb7:    f6 14 00               mov AL, Device[X + 0x00]
aeba:    a5 a2                  st AL, [--S]
aebc:    79 af e3               call R_afe3
aebf:    01                     nop
aec0:    8d                     ld AL, [S]
aec1:    f6 34 00               mov BL, Device[X + 0x00]
aec4:    14 05                  bz L_aecb
aec6:    55 20                  mov A, B
aec8:    71 b0 21               jmp R_b021

L_aecb:
aecb:    80 60                  ld AL, 0x60
aecd:    f6 15 00               mov Device[X + 0x00], AL
aed0:    79 af bb               call R_afbb
aed3:    2a                     clr AL, #0
aed4:    f6 15 00               mov Device[X + 0x00], AL
aed7:    85 a1                  ld AL, [S++]
aed9:    7f 41                  pop {X}
aedb:    d0 00 ff               ld B, 0x00ff
aede:    e1 01 1f               st BL, [0x011f]
aee1:    22 30                  clr BL, #0
aee3:    e1 ae 5b               st BL, [L_ae5a+1|0xae5b]
aee6:    c5 68 13               ld BL, [Y + 0x13]
aee9:    4a                     and BL, AL
aeea:    09                     ret

R_aeeb:
aeeb:    79 af fe               call R_affe
aeee:    80 ff                  ld AL, 0xff
aef0:    a1 01 1f               st AL, [0x011f]
aef3:    d5 68 0f               ld B, [Y + 0x0f]
aef6:    f6 12 01               mov AL, Device[B + 0x01]
aef9:    24 13                  srl AL, #4
aefb:    11 03                  bnc L_af00
aefd:    f6 13 01               mov Device[B + 0x01], AL

L_af00:
af00:    2a                     clr AL, #0
af01:    a1 ae 5b               st AL, [L_ae5a+1|0xae5b]
af04:    09                     ret

R_af05:
af05:    7e 63                  push {Y, Z}
af07:    79 ae 57               call R_ae57
af0a:    79 ac cf               call R_accf
af0d:    7f 63                  pop {Y, Z}
af0f:    d6 89 af 1e            st Z, [R_af1e|0xaf1e]
af13:    c5 68 13               ld BL, [Y + 0x13]
af16:    e5 88 04               st BL, [Z + 0x04]
af19:    2a                     clr AL, #0
af1a:    a3 2a                  st AL, [R_af45+1|0xaf46]
af1c:    7b 27                  call R_af45

R_af1e:
af1e:    00                     HALT
af1f:    00                     HALT
af20:    b5 a2                  st A, [--S]
af22:    80 ff                  ld AL, 0xff
af24:    a1 01 1f               st AL, [0x011f]
af27:    80 17                  ld AL, 0x17
af29:    d5 68 0f               ld B, [Y + 0x0f]
af2c:    f6 13 00               mov Device[B + 0x00], AL
af2f:    79 af e3               call R_afe3
af32:    09                     ret
af33:    d5 'U'
af34:    68
af35:    0f
af36:    f6 'v'
af37:    12
af38:    00
af39:    15
af3a:    ec 'l'
af3b:    2a
af3c:    a1 '!'
af3d:    ae '.'
af3e:    5b
af3f:    f6 'v'
af40:    12
af41:    00
af42:    95
af43:    a1 '!'
af44:    09

R_af45:
af45:    80 00                  ld AL, 0x00
af47:    15 02                  bnz L_af4b
af49:    22 1d                  clr AL, #13

L_af4b:
af4b:    a1 b0 9f               st AL, [R_b09f|0xb09f]
af4e:    22 12                  clr AL, #2
af50:    a1 b0 27               st AL, [R_b027|0xb027]
af53:    7e 45                  push {X, Y, Z}
af55:    95 68 0f               ld A, [Y + 0x0f]
af58:    5e                     mov Z, A
af59:    2a                     clr AL, #0
af5a:    a1 b0 88               st AL, [R_b088|0xb088]
af5d:    91 01 03               ld A, [CurrentProcess|0x0103]
af60:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
af65:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
af6a:    c0 02                  ld BL, 0x02
af6c:    2f 28                  ld_isr B

R_af6e:
af6e:    65 a4                  ld X, @[S]
af70:    79 af fe               call R_affe
af73:    80 41                  ld AL, 0x41
af75:    f6 19 00               mov Device[Z + 0x00], AL
af78:    7b 41                  call R_afbb
af7a:    85 41                  ld AL, [X++]
af7c:    f6 19 00               mov Device[Z + 0x00], AL
af7f:    7b 3a                  call R_afbb
af81:    85 41                  ld AL, [X++]
af83:    f6 19 00               mov Device[Z + 0x00], AL
af86:    3a                     clr A, #0
af87:    85 41                  ld AL, [X++]
af89:    14 2b                  bz R_afb6
af8b:    55 42                  mov B, X
af8d:    50 04                  add X, A
af8f:    79 b1 51               call R_b151
af92:    7b 6a                  call R_affe
af94:    15 1e                  bnz L_afb4
af96:    80 43                  ld AL, 0x43
af98:    f6 19 00               mov Device[Z + 0x00], AL
af9b:    7b 61                  call R_affe
af9d:    14 05                  bz L_afa4
af9f:    79 b1 79               call R_b179
afa2:    b1 '1'
afa3:    bf '?'

L_afa4:
afa4:    79 b1 5f               call R_b15f
afa7:    d5 41                  ld B, [X++]
afa9:    9a                     ld A, [X]
afaa:    79 b1 51               call R_b151
afad:    80 45                  ld AL, 0x45
afaf:    f6 19 00               mov Device[Z + 0x00], AL
afb2:    7b 4a                  call R_affe

L_afb4:
afb4:    15 6b                  bnz R_b021

R_afb6:
afb6:    7f 45                  pop {X, Y, Z}
afb8:    d5 41                  ld B, [X++]
afba:    09                     ret

R_afbb:
afbb:    79 ce 2a               call SetTimeout8
afbe:    3a                     clr A, #0
afbf:    d7 12                  mov IL1(B), A

L_afc1:
afc1:    d5 68 0f               ld B, [Y + 0x0f]
afc4:    f6 32 01               mov BL, Device[B + 0x01]
afc7:    80 08                  ld AL, 0x08
afc9:    49                     sub BL, AL
afca:    14 07                  bz L_afd3
afcc:    79 ce 33               call CheckTimeout
afcf:    14 f0                  bz L_afc1
afd1:    73 3f                  jmp R_b012

L_afd3:
afd3:    79 ce 41               call SetTimeout256
afd6:    e6 12                  mov A, IL1(B)
afd8:    5d                     mov B, A
afd9:    14 07                  bz L_afe2
afdb:    79 b1 79               call R_b179
afde:    b2 5d 80               st A, @[0x5d80]
afe1:    ff                     st B, [P]

L_afe2:
afe2:    09                     ret

R_afe3:
afe3:    85 41                  ld AL, [X++]
afe5:    a3 0c                  st AL, [0xaff3]
afe7:    7c d3                  call SetTimeout8 (via R_afbb+1)
afe9:    3a                     clr A, #0
afea:    d7 12                  mov IL1(B), A

L_afec:
afec:    d5 68 0f               ld B, [Y + 0x0f]
afef:    f6 32 01               mov BL, Device[B + 0x01]
aff2:    80 00                  ld AL, 0x00
aff4:    4a                     and BL, AL
aff5:    49                     sub BL, AL
aff6:    14 db                  bz L_afd3
aff8:    7c d3                  call CheckTimeout (via 0xafcc+1)
affa:    14 f0                  bz L_afec
affc:    73 14                  jmp R_b012

R_affe:
affe:    7c bc                  call SetTimeout8 (via R_afbb+1)
b000:    3a                     clr A, #0
b001:    d7 12                  mov IL1(B), A

L_b003:
b003:    d5 68 0f               ld B, [Y + 0x0f]
b006:    f6 32 01               mov BL, Device[B + 0x01]
b009:    80 08                  ld AL, 0x08
b00b:    4a                     and BL, AL
b00c:    14 09                  bz L_b017
b00e:    7c bd                  call CheckTimeout (via 0xafcc+1)
b010:    14 f1                  bz L_b003

R_b012:
b012:    79 b1 79               call R_b179
b015:    b1 '1'
b016:    d9 'Y'

L_b017:
b017:    79 ce 41               call SetTimeout256
b01a:    95 68 0f               ld A, [Y + 0x0f]
b01d:    f6 10 00               mov AL, Device[A + 0x00]
b020:    09                     ret

R_b021:
b021:    c0 21                  ld BL, 0x21
b023:    49                     sub BL, AL
b024:    15 12                  bnz L_b038
b026:    c0 02                  ld BL, 0x02
b028:    14 46                  bz L_b070
b02a:    21 30                  dec BL, #1
b02c:    e3 f9                  st BL, [R_b027|0xb027]
b02e:    c1 b0 9f               ld BL, [R_b09f|0xb09f]
b031:    21 30                  dec BL, #1
b033:    e1 b0 9f               st BL, [R_b09f|0xb09f]
b036:    73 31                  jmp L_b069

L_b038:
b038:    c0 41                  ld BL, 0x41
b03a:    49                     sub BL, AL
b03b:    15 05                  bnz L_b042
b03d:    90 ce d2               ld A, 0xced2
b040:    73 08                  jmp L_b04a

L_b042:
b042:    c0 42                  ld BL, 0x42
b044:    49                     sub BL, AL
b045:    15 29                  bnz L_b070
b047:    90 d7 d0               ld A, 0xd7d0

L_b04a:
b04a:    b1 b1 e9               st A, [R_b1e6+3|0xb1e9]
b04d:    90 c0 c0               ld A, 0xc0c0
b050:    b1 b1 ec               st A, [R_b1e6+6|0xb1ec]
b053:    80 02                  ld AL, 0x02
b055:    46 80 91 b1 ec 60 02   baseconv(8, 0) [R_b1e6+6|0xb1ec], [Y + 0x02]
b05c:    79 b1 8f               call R_b18f
b05f:    b1 e6 60               st A, [0xe660]
b062:    13 88                  bnn L_afec

L_b064:
b064:    66 07                  jsys Syscall_Yield
b066:    3f                     dec X
b067:    18 fb                  bgt L_b064

L_b069:
b069:    95 68 0f               ld A, [Y + 0x0f]
b06c:    5e                     mov Z, A
b06d:    71 af 6e               jmp R_af6e

L_b070:
b070:    a5 a2                  st AL, [--S]
b072:    90 c0 c0               ld A, 0xc0c0
b075:    b1 b2 23               st A, [R_b218+11|0xb223]
b078:    b1 b2 1d               st A, [R_b218+5|0xb21d]
b07b:    80 18                  ld AL, 0x18
b07d:    f6 19 00               mov Device[Z + 0x00], AL
b080:    79 af e3               call R_afe3
b083:    09                     ret
b084:    f6 'v'
b085:    18
b086:    00
b087:    a0 ' '

R_b088:
b088:    00
b089:    80
b08a:    02
b08b:    46
b08c:    e0 '`'
b08d:    90
b08e:    b2 '2'
b08f:    23
b090:    b0 '0'
b091:    88
b092:    7b
b093:    6f
b094:    80
b095:    02
b096:    46
b097:    e0 '`'
b098:    92
b099:    b2 '2'
b09a:    1d
b09b:    0a
b09c:    85
b09d:    a1 '!'
b09e:    c0 '@'

R_b09f:
b09f:    00
b0a0:    21
b0a1:    30
b0a2:    e3 'c'
b0a3:    fb '{'
b0a4:    18
b0a5:    c3 'C'
b0a6:    c0 '@'
b0a7:    30
b0a8:    49
b0a9:    16
b0aa:    05
b0ab:    d0 'P'
b0ac:    b1 '1'
b0ad:    ee 'n'
b0ae:    73
b0af:    0d
b0b0:    c0 '@'
b0b1:    20
b0b2:    49
b0b3:    16
b0b4:    05
b0b5:    d0 'P'
b0b6:    b2 '2'
b0b7:    51
b0b8:    73
b0b9:    03
b0ba:    d0 'P'
b0bb:    b2 '2'
b0bc:    04
b0bd:    f3 's'
b0be:    0e
b0bf:    c1 'A'
b0c0:    af '/'
b0c1:    46
b0c2:    14
b0c3:    03
b0c4:    71
b0c5:    af '/'
b0c6:    b6 '6'
b0c7:    7c
b0c8:    07
b0c9:    b1 '1'
b0ca:    a1 '!'
b0cb:    7c
b0cc:    03
b0cd:    00
b0ce:    00
b0cf:    79
b0d0:    a5 '%'
b0d1:    50
b0d2:    b2 '2'
b0d3:    18
b0d4:    95
b0d5:    a4 '$'
b0d6:    5c
b0d7:    3a
b0d8:    85
b0d9:    68
b0da:    02
b0db:    30
b0dc:    02
b0dd:    5b
b0de:    90
b0df:    c0 '@'
b0e0:    c0 '@'
b0e1:    b1 '1'
b0e2:    b2 '2'
b0e3:    2e
b0e4:    80
b0e5:    02
b0e6:    46
b0e7:    e0 '`'
b0e8:    92
b0e9:    b2 '2'
b0ea:    2e
b0eb:    06
b0ec:    30
b0ed:    60
b0ee:    7c
b0ef:    e0 '`'
b0f0:    b2 '2'
b0f1:    2c
b0f2:    3f
b0f3:    18
b0f4:    e9 'i'
b0f5:    7c
b0f6:    d9 'Y'
b0f7:    b1 '1'
b0f8:    a1 '!'
b0f9:    3a
b0fa:    a1 '!'
b0fb:    ae '.'
b0fc:    5b
b0fd:    39
b0fe:    5d
b0ff:    c0 '@'
b100:    0d
b101:    66
b102:    6b
b103:    83
b104:    9a
b105:    21
b106:    11
b107:    18
b108:    06
b109:    32
b10a:    02
b10b:    f6 'v'
b10c:    09
b10d:    00
b10e:    09
b10f:    95
b110:    a8 '('
b111:    03
b112:    98
b113:    c5 'E'
b114:    08
b115:    04
b116:    e3 'c'
b117:    36
b118:    85
b119:    08
b11a:    06
b11b:    14
b11c:    0f
b11d:    c5 'E'
b11e:    68
b11f:    12
b120:    21
b121:    30
b122:    49
b123:    14
b124:    09
b125:    c1 'A'
b126:    b0 '0'
b127:    9f
b128:    24
b129:    30
b12a:    10
b12b:    02
b12c:    20
b12d:    11
b12e:    29
b12f:    a3 '#'
b130:    1f
b131:    32
b132:    04
b133:    d0 'P'
b134:    b1 '1'
b135:    4d
b136:    7b
b137:    19
b138:    80
b139:    43
b13a:    f6 'v'
b13b:    19
b13c:    00
b13d:    79
b13e:    af '/'
b13f:    fe '~'
b140:    7b
b141:    1d
b142:    80
b143:    45
b144:    f6 'v'
b145:    19
b146:    00
b147:    79
b148:    af '/'
b149:    fe '~'
b14a:    15
b14b:    bd '='
b14c:    09

R_b14d:
b14d:    81 00 83               ld AL, [0x0083]
b150:    00                     HALT

R_b151:
b151:    2f 34                  dma_mode #3
b153:    2f 06                  enable_dma
b155:    2f 20                  ld_dma_addr B
b157:    3b                     not A, #0
b158:    2f 02                  ld_dma_count A
b15a:    59                     sub B, A
b15b:    f0 00 00               st B, 0x0000
b15e:    09                     ret

R_b15f:
b15f:    2f 07                  disable_dma
b161:    2f 03                  st_dma_count A
b163:    38                     inc A, #1
b164:    14 04                  bz L_b16a
b166:    7b 11                  call R_b179
b168:    b2 '2'
b169:    31

L_b16a:
b16a:    2f 03                  st_dma_count A
b16c:    2f 21                  st_dma_addr B
b16e:    59                     sub B, A
b16f:    93 eb                  ld A, [0xb15c]
b171:    59                     sub B, A
b172:    15 01                  bnz L_b175
b174:    09                     ret

L_b175:
b175:    7b 02                  call R_b179
b177:    b2 '2'
b178:    44

R_b179:
b179:    95 68 0f               ld A, [Y + 0x0f]
b17c:    f6 11 01               mov Device[A + 0x01], AL
b17f:    95 41                  ld A, [X++]
b181:    b3 02                  st A, [0xb185]
b183:    7b 0a                  call R_b18f
b185:    00                     HALT
b186:    00                     HALT
b187:    2a                     clr AL, #0
b188:    a1 ae 5b               st AL, [L_ae5a+1|0xae5b]
b18b:    c0 0d                  ld BL, 0x0d
b18d:    66 6b                  jsys 0x6b

R_b18f:
b18f:    95 41                  ld A, [X++]
b191:    b3 07                  st A, [0xb19a]
b193:    7c 03                  call @[0xb198]
b195:    b1 a1 79               st A, [0xa179]
b198:    a5 50                  st AL, [X]
b19a:    00                     HALT
b19b:    00                     HALT
b19c:    7c fa                  call @[0xb198]
b19e:    b1 a1 09               st A, [0xa109]

R_b1a1:
b1a1:    1, "\r"
b1a4:    25, "ILLEGAL FDC SECTOR NUMBER"

R_b1bf:
b1bf:    24, "FDC COMMAND LOAD FAILURE"

R_b1d9:
b1d9:    11, "FDC FAILURE"

R_b1e6:
b1e6:    6, "\x07ID NN"

R_b1ee:
b1ee:    20, "FDC COMMAND FAILURE\r"

R_b204:
b204:    18, "FDC COMMAND ERROR\r"

R_b218:
b218:    18, "EC:XX CP:XX CMDS: "

R_b22c:
b22c:    3, "XX "

R_b231:
b231:    17, "DMA NOT COMPLETED"

R_b244:
b244:    11, "DMA FAILURE"

R_b251:
b251:    10, "FDC ERROR\r"

R_b25d:
b25d:    13, "DMA STAT FAIL"

CRTDeviceFunctions:
b26c:    00 05                  (0x5)
b26e:    ce 4a                  R_ce4a
b270:    b2 7c                  R_b27c
b272:    b2 c3                  CrtDevice_Write
b274:    b5 55                  R_b555
b276:    b2 cb                  CrtDevice_UrgentWrite
b278:    b4 fb                  R_b4fb
b27a:    b8 05                  CrtDevice_Init

R_b27c:
b27c:    55 46                  mov Y, X
b27e:    2a                     clr AL, #0
b27f:    a5 6c 05               st AL, @[Y + 0x05]
b282:    7b 35                  call CrtDevice_WaitForIdle
b284:    55 80                  mov A, Z
b286:    b5 68 14               st A, [Y + 0x14]
b289:    3a                     clr A, #0
b28a:    b5 8c 06               st A, @[Z + 0x06]
b28d:    28                     inc AL, #1
b28e:    a5 68 11               st AL, [Y + 0x11]
b291:    91 01 03               ld A, [CurrentProcess|0x0103]
b294:    b5 68 0d               st A, [Y + 0x0d]
b297:    d0 08 00               ld B, 0x0800
b29a:    c8                     ld BL, [A]
b29b:    42 23                  and BL, BH
b29d:    15 06                  bnz L_b2a5
b29f:    47 6d 00 04 00 00      unkblk6 0x01, 0x04, [A + 0x00]

L_b2a5:
b2a5:    79 b3 66               call GetMUXBaseAndOffset
b2a8:    f6 31 08               mov Device[A + 0x08], BL

R_b2ab:
b2ab:    65 a1                  ld X, [S++]
b2ad:    95 a1                  ld A, [S++]
b2af:    5c                     mov Y, A
b2b0:    95 a1                  ld A, [S++]
b2b2:    5e                     mov Z, A

R_b2b3:
b2b3:    91 01 01               ld A, [SyscallVector+1|0x0101]
b2b6:    75 08 03               jmp [A + 0x03]

CrtDevice_WaitForIdle:
    ; This function waits until device.state == 0
b2b9:    85 68 11               ld AL, [Y + 0x11]	 ; device_obj.state
b2bc:    15 01                  bnz L_b2bf
b2be:    09                     ret

L_b2bf:
b2bf:    66 07                  jsys Syscall_Yield
b2c1:    73 f6                  jmp CrtDevice_WaitForIdle

CrtDevice_Write:
b2c3:    55 46                  mov Y, X
b2c5:    3a                     clr A, #0
b2c6:    a5 6c 05               st AL, @[Y + 0x05]
b2c9:    7b ee                  call CrtDevice_WaitForIdle

CrtDevice_UrgentWrite:
b2cb:    3a                     clr A, #0
b2cc:    29                     dec AL, #1
b2cd:    a5 68 11               st AL, [Y + 0x11]
b2d0:    95 68 1d               ld A, [Y + 0x1d]
b2d3:    14 02                  bz L_b2d7
b2d5:    7d 00                  call [A]

L_b2d7:
b2d7:    55 80                  mov A, Z
b2d9:    b5 68 14               st A, [Y + 0x14]
b2dc:    3a                     clr A, #0
b2dd:    b5 88 08               st A, [Z + 0x08]
b2e0:    79 b3 66               call GetMUXBaseAndOffset
b2e3:    20 30                  inc BL, #1
b2e5:    f6 31 08               mov Device[A + 0x08], BL
b2e8:    79 ce 2a               call SetTimeout8

L_b2eb:
b2eb:    d5 68 0f               ld B, [Y + 0x0f]	 ; Serial port base
b2ee:    f6 32 00               mov BL, Device[B + 0x00]	 ; Wait for TX_READY
b2f1:    24 31                  srl BL, #2
b2f3:    10 07                  bc L_b2fc
b2f5:    79 ce 33               call CheckTimeout
b2f8:    15 2e                  bnz AttnPrint
b2fa:    73 ef                  jmp L_b2eb

L_b2fc:
b2fc:    79 ce 2a               call SetTimeout8
b2ff:    91 01 03               ld A, [CurrentProcess|0x0103]
b302:    b5 68 0d               st A, [Y + 0x0d]

L_b305:
b305:    80 80                  ld AL, 0x80
b307:    ac                     st AL, [Z]
b308:    7b 5c                  call GetMUXBaseAndOffset
b30a:    c5 68 02               ld BL, [Y + 0x02]
b30d:    f6 31 0c               mov Device[A + 0x0c], BL

L_b310:
b310:    85 68 11               ld AL, [Y + 0x11]
b313:    14 28                  bz L_b33d
b315:    29                     dec AL, #1
b316:    14 25                  bz L_b33d
b318:    8c                     ld AL, [Z]
b319:    2d                     sll AL, #1
b31a:    15 07                  bnz L_b323
b31c:    66 07                  jsys Syscall_Yield
b31e:    79 ce 2a               call SetTimeout8
b321:    73 ed                  jmp L_b310

L_b323:
b323:    79 ce 33               call CheckTimeout
b326:    14 dd                  bz L_b305

AttnPrint:
b328:    79 a5 50               call R_a550
b32b:    b3 2f                  st A, [0xb35c]
b32d:    73 cd                  jmp L_b2fc

R_b32f:
b32f:    12, "ATTN PRINT\n\r"

L_b33d:
b33d:    3a                     clr A, #0
b33e:    a5 6c 03               st AL, @[Y + 0x03]
b341:    8c                     ld AL, [Z]
b342:    52 10 00 7f            and A, A, 0x007f
b346:    ac                     st AL, [Z]
b347:    79 ce 41               call SetTimeout256
b34a:    91 00 5a               ld A, [0x005a]
b34d:    95 08 6e               ld A, [A + 0x6e]
b350:    39                     dec A, #1
b351:    5e                     mov Z, A
b352:    60 00 08               ld X, 0x0008

L_b355:
b355:    30 80                  inc Z, #1
b357:    3f                     dec X
b358:    14 09                  bz L_b363
b35a:    95 81                  ld A, [Z++]
b35c:    d5 68 1d               ld B, [Y + 0x1d]
b35f:    59                     sub B, A
b360:    15 f3                  bnz L_b355
b362:    ec                     st BL, [Z]

L_b363:
b363:    71 b2 ab               jmp R_b2ab

GetMUXBaseAndOffset:
b366:    95 68 0f               ld A, [Y + 0x0f]
b369:    c0 06                  ld BL, 0x06
b36b:    4a                     and BL, AL
b36c:    44 31                  xor AL, BL
b36e:    09                     ret

level6Handler:
b36f:    90 f2 0f               ld A, 0xf20f
b372:    f6 10 00               mov AL, Device[A + 0x00]
b375:    5e                     mov Z, A
b376:    90 06 f0               ld A, 0x06f0
b379:    42 90                  and AH, ZL
b37b:    42 91                  and AL, ZL
b37d:    2c                     srl AL, #1
b37e:    43 01                  or AL, AH
b380:    22 00                  clr AH, #0
b382:    d1 01 0b               ld B, [0x010b]
b385:    65 21                  ld X, [B++]
b387:    51 04                  sub X, A
b389:    16 05                  blt L_b390

L_b38b:
b38b:    f6 08 00               mov A, Device[Z + 0x00]
b38e:    73 0e                  jmp CrtDevice_InterruptHandler_Exit

L_b390:
b390:    58                     add B, A
b391:    99                     ld A, [B]
b392:    14 f7                  bz L_b38b
b394:    5c                     mov Y, A
b395:    8b                     ld AL, [Y]
b396:    15 09                  bnz L_b3a1
b398:    d5 68 0f               ld B, [Y + 0x0f]
b39b:    f6 12 01               mov AL, Device[B + 0x01]

CrtDevice_InterruptHandler_Exit:
b39e:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b3a1:
b3a1:    95 68 0d               ld A, [Y + 0x0d]
b3a4:    14 13                  bz L_b3b9
b3a6:    47 40 0f 01 c5 b3 cc   memcpy 0x10, [R_01c5|0x01c5], [R_b3cc|0xb3cc]
b3ad:    47 44 0f 00 46 b3 dc   memcpy 0x10, [A + 0x46], [R_b3dc|0xb3dc]
b3b4:    2e 0c f9 b3 cc         wpf 0xf9, [R_b3cc|0xb3cc]

L_b3b9:
b3b9:    95 68 1b               ld A, [Y + 0x1b]
b3bc:    14 05                  bz L_b3c3
b3be:    7d 00                  call [A]
b3c0:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b3c3:
b3c3:    80 01                  ld AL, 0x01
b3c5:    42 91                  and AL, ZL
b3c7:    14 43                  bz CrtDevice_RxDoneInterrupt
b3c9:    71 b7 03               jmp R_b703

R_b3cc:
b3cc:    <null bytes>


R_b3dc:
b3dc:    <null bytes>


R_b3ec:
b3ec:    <null bytes>


CrtDevice_RxDoneInterrupt:
b40c:    f6 08 00               mov A, Device[Z + 0x00]	 ; DISASSEMBLER BUG! Should be ld A, +0(Z) - read both status and character
b40f:    d0 0a 00               ld B, 0x0a00
b412:    c5 68 01               ld BL, [Y + 0x01]	 ; if [device_obj + 1] == 0x0a....
b415:    41 23                  sub BL, BH	 ; Is this a "Communication" Device type (modem?)
b417:    15 03                  bnz L_b41c
b419:    71 b6 a0               jmp R_b6a0	 ; .. then we go do some memory moves

L_b41c:
b41c:    c5 68 01               ld BL, [Y + 0x01]	 ; if [device_obj + 1] == 3, silently drop the output and leave the interrupt
b41f:    21 32                  dec BL, #3	 ; Is this a "Printer" device type
b421:    15 03                  bnz L_b426
b423:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b426:
b426:    c0 80                  ld BL, 0x80	 ; Make sure bit 7 of the character is set
b428:    43 31                  or AL, BL
b42a:    c0 1c                  ld BL, 0x1c	 ; Check bits 4 - 2 of status register, we don't know what they are
b42c:    42 03                  and BL, AH
b42e:    15 02                  bnz L_b432
b430:    73 0e                  jmp L_b440	 ; If zero, proceed with handling the input

L_b432:
b432:    c0 04                  ld BL, 0x04	 ; Check bit 2
b434:    42 03                  and BL, AH
b436:    14 05                  bz L_b43d	 ; If zero, beep and discard the input
b438:    c0 80                  ld BL, 0x80	 ; Otherwise check if the character is NUL
b43a:    49                     sub BL, AL	 ; I think this checks for BREAK on the serial port
b43b:    14 03                  bz L_b440	 ; If yes, proceed to TOS check

L_b43d:
b43d:    71 b4 f3               jmp BeepAndDropInput

L_b440:
b440:    45 10                  mov AH, AL	 ; Run the character through the translation table
b442:    79 b5 ae               call TranslateChar	 ; AL = translated character
b445:    c5 68 17               ld BL, [Y + 0x17]	 ; Check for Break (Ctrl-C)
b448:    49                     sub BL, AL
b449:    15 1b                  bnz CheckForTOSMagic	 ; If not, check for TOS entry request
b44b:    d5 68 2f               ld B, [Y + 0x2f]
b44e:    14 03                  bz L_b453	 ; if ([device_obj + 0x2f]) call R_b541
b450:    79 b5 41               call R_b541	 ; This is v7 feature, there are no these checks in LOAD v6

L_b453:
b453:    c5 68 13               ld BL, [Y + 0x13]	 ; device_obj.break_state
b456:    15 0b                  bnz CrtDevice_InterruptHandler_Exit2	 ; Exit if already registered
b458:    c0 01                  ld BL, 0x01	 ; Set device_obj.break_state
b45a:    e5 68 13               st BL, [Y + 0x13]
b45d:    46 00 0c 01 01 3e      addbig(0, 0) 0x01, [0x013e]	 ; Increment global break counter

CrtDevice_InterruptHandler_Exit2:
b463:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

CheckForTOSMagic:
b466:    c0 87                  ld BL, 0x87
b468:    49                     sub BL, AL	 ; The translated character has to be Ctrl-G (BELL)
b469:    15 3b                  bnz L_b4a6	 ; Note that default CrtHooks table doesn't translate 0x80 to 0x87,
                                          	 ; so we cannot enter this advanced TOS in LOAD v7.
                                          	 ; Probably this is even a bug, i don't know. Would've been way more logical
                                          	 ; to have a sequence BREAK then Ctrl-G
b46b:    d5 68 0f               ld B, [Y + 0x0f]	 ; Serial port base
b46e:    52 32 0d ff            and B, B, 0x0dff	 ; Allowed addresses: 0x?000, 0x?100, 0x?200, 0x?300
b472:    15 32                  bnz L_b4a6
b474:    d5 68 2f               ld B, [Y + 0x2f]	 ; if ([device_obj + 0x2f]) call R_b541
b477:    14 03                  bz L_b47c
b479:    79 b5 41               call R_b541

L_b47c:
b47c:    7e 01                  push {A}
b47e:    82 00 1a               ld AL, @[0x001a]
b481:    c0 73                  ld BL, 0x73	 ; Check for jmp instruction in the beginning
b483:    49                     sub BL, AL
b484:    14 04                  bz CallTOS
b486:    7f 01                  pop {A}
b488:    73 1c                  jmp L_b4a6

CallTOS:
b48a:    7f 01                  pop {A}
b48c:    d0 00 fe               ld B, 0x00fe
b48f:    80 0e                  ld AL, 0x0e
b491:    43 c1                  or AL, CH
b493:    4a                     and BL, AL
b494:    f5 a2                  st B, [--S]
b496:    91 00 1a               ld A, [0x001a]
b499:    30 01                  inc A, #2
b49b:    d5 a4                  ld B, @[S]
b49d:    f5 01                  st B, [A++]
b49f:    b5 a4                  st A, @[S]
b4a1:    95 a1                  ld A, [S++]
b4a3:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b4a6:
b4a6:    45 01                  mov AL, AH
b4a8:    d5 68 2f               ld B, [Y + 0x2f]
b4ab:    15 08                  bnz L_b4b5
b4ad:    6d a2                  st X, [--S]
b4af:    a1 b6 45               st AL, [R_b645|0xb645]
b4b2:    71 b5 96               jmp R_b596

L_b4b5:
b4b5:    c0 9b                  ld BL, 0x9b
b4b7:    49                     sub BL, AL
b4b8:    15 03                  bnz L_b4bd
b4ba:    79 b5 41               call R_b541

L_b4bd:
b4bd:    47 85 01 60 2f 60 35   memcmp 0x02, [Y + 0x2f], [Y + 0x35]
b4c4:    16 02                  blt L_b4c8
b4c6:    73 2b                  jmp BeepAndDropInput

L_b4c8:
b4c8:    6d a2                  st X, [--S]
b4ca:    65 68 2b               ld X, [Y + 0x2b]
b4cd:    d5 68 33               ld B, [Y + 0x33]
b4d0:    51 42                  sub B, X
b4d2:    19 03                  ble L_b4d7
b4d4:    65 68 31               ld X, [Y + 0x31]

L_b4d7:
b4d7:    2e 0c f9 01 c5         wpf 0xf9, [R_01c5|0x01c5]
b4dc:    a5 41                  st AL, [X++]
b4de:    6d 68 2b               st X, [Y + 0x2b]
b4e1:    30 70 00 35            inc [Y + 0x0035], #1
b4e5:    65 a1                  ld X, [S++]
b4e7:    91 00 5a               ld A, [0x005a]
b4ea:    c0 01                  ld BL, 0x01
b4ec:    e5 08 6b               st BL, [A + 0x6b]

CrtDevice_InterruptHandler_End:
b4ef:    0a                     reti
b4f0:    71 b3 6f               jmp level6Handler

BeepAndDropInput:
b4f3:    80 87                  ld AL, 0x87
b4f5:    79 b6 ea               call PrintEcho
b4f8:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

R_b4fb:
b4fb:    d5 68 2f               ld B, [Y + 0x2f]
b4fe:    15 03                  bnz L_b503
b500:    71 b2 b3               jmp R_b2b3

L_b503:
b503:    c5 68 11               ld BL, [Y + 0x11]
b506:    18 03                  bgt L_b50b
b508:    71 b6 53               jmp R_b653

L_b50b:
b50b:    6d a2                  st X, [--S]
b50d:    b3 01                  st A, [R_b50f+1|0xb510]

R_b50f:
b50f:    90 00 01               ld A, 0x0001
b512:    15 56                  bnz L_b56a
b514:    71 b6 53               jmp R_b653

R_b517:
b517:    7e 21                  push {B}
b519:    d0 00 00               ld B, 0x0000
b51c:    46 11 21 b5 10 60 35   unkbig2(1, 1) [R_b50f+1|0xb510], [Y + 0x35]
b523:    16 17                  blt L_b53c
b525:    f5 68 2d               st B, [Y + 0x2d]
b528:    31 70 00 35            dec [Y + 0x0035], #1
b52c:    d5 68 35               ld B, [Y + 0x35]
b52f:    17 04                  bp L_b535
b531:    7b 0e                  call R_b541
b533:    73 07                  jmp L_b53c

L_b535:
b535:    31 10 b5 10            dec [R_b50f+1|0xb510], #1
b539:    7f 21                  pop {B}
b53b:    09                     ret

L_b53c:
b53c:    30 a3                  inc S, #4
b53e:    71 b6 53               jmp R_b653

R_b541:
b541:    7e 21                  push {B}
b543:    d0 00 00               ld B, 0x0000
b546:    f5 68 35               st B, [Y + 0x35]
b549:    d5 68 31               ld B, [Y + 0x31]
b54c:    f5 68 2b               st B, [Y + 0x2b]
b54f:    f5 68 2d               st B, [Y + 0x2d]
b552:    7f 21                  pop {B}
b554:    09                     ret

R_b555:
b555:    55 46                  mov Y, X
b557:    7b e8                  call R_b541
b559:    3a                     clr A, #0
b55a:    a1 b2 6c               st AL, [CRTDeviceFunctions|0xb26c]
b55d:    b3 b1                  st A, [R_b50f+1|0xb510]
b55f:    d5 68 14               ld B, [Y + 0x14]
b562:    55 28                  mov Z, B
b564:    79 b7 9b               call R_b79b
b567:    71 b2 ab               jmp R_b2ab

L_b56a:
b56a:    d5 68 35               ld B, [Y + 0x35]
b56d:    59                     sub B, A
b56e:    19 03                  ble L_b573
b570:    71 b6 53               jmp R_b653

L_b573:
b573:    65 68 2d               ld X, [Y + 0x2d]
b576:    d5 68 33               ld B, [Y + 0x33]
b579:    51 42                  sub B, X
b57b:    19 03                  ble L_b580
b57d:    65 68 31               ld X, [Y + 0x31]

L_b580:
b580:    2e 1c fb b3 ec         rpf 0xfb, [R_b3ec|0xb3ec]
b585:    2e 0c fb 01 c5         wpf 0xfb, [R_01c5|0x01c5]
b58a:    85 41                  ld AL, [X++]
b58c:    2e 0c fb b3 ec         wpf 0xfb, [R_b3ec|0xb3ec]
b591:    6b 87                  st X, [0xb51a]
b593:    a1 b6 44               st AL, [R_b644|0xb644]

R_b596:
b596:    c5 68 11               ld BL, [Y + 0x11]
b599:    18 0b                  bgt L_b5a6
b59b:    d5 68 2f               ld B, [Y + 0x2f]
b59e:    15 03                  bnz L_b5a3
b5a0:    71 b6 46               jmp R_b646

L_b5a3:
b5a3:    71 b6 53               jmp R_b653

L_b5a6:
b5a6:    7b 1b                  call R_b5c3
b5a8:    7b 04                  call TranslateChar
b5aa:    7b 25                  call L_b5d1
b5ac:    73 30                  jmp L_b5de

TranslateChar:
    ; Translate a character according to a table in CrtDeviceHooks
    ; The table consists of words. First word is an write hook, called
    ; from within CrtDevice_Write. Other words are 2-byte entries
    ; in format: TO FROM. The table is terminated with a zero word.
    ; A character to translate is placed in AL, on return it will be either
    ; translated according to the hooks table or left as it is.
b5ae:    7e 41                  push {X}
b5b0:    65 68 1d               ld X, [Y + 0x1d]	 ; CrtDeviceHooks
b5b3:    14 0b                  bz L_b5c0	 ; If not set, do nothing
b5b5:    30 41                  inc X, #2	 ; Skip write hook address

L_b5b7:
b5b7:    d5 41                  ld B, [X++]	 ; BH, BL = [table++]
b5b9:    14 05                  bz L_b5c0	 ; If a terminator reached, nothing found
b5bb:    49                     sub BL, AL	 ; if AL != BL
b5bc:    15 f9                  bnz L_b5b7	 ; check the next entry
b5be:    45 21                  mov AL, BH	 ; return BH

L_b5c0:
b5c0:    7f 41                  pop {X}
b5c2:    09                     ret

R_b5c3:
b5c3:    95 68 2f               ld A, [Y + 0x2f]
b5c6:    14 05                  bz L_b5cd
b5c8:    81 b6 44               ld AL, [R_b644|0xb644]
b5cb:    73 03                  jmp L_b5d0

L_b5cd:
b5cd:    81 b6 45               ld AL, [R_b645|0xb645]

L_b5d0:
b5d0:    09                     ret

L_b5d1:
b5d1:    d5 68 2f               ld B, [Y + 0x2f]
b5d4:    14 05                  bz L_b5db
b5d6:    a1 b6 44               st AL, [R_b644|0xb644]
b5d9:    73 02                  jmp L_b5dd

L_b5db:
b5db:    a3 68                  st AL, [R_b645|0xb645]

L_b5dd:
b5dd:    09                     ret

L_b5de:
b5de:    d5 68 2f               ld B, [Y + 0x2f]
b5e1:    14 03                  bz L_b5e6
b5e3:    79 b5 17               call R_b517

L_b5e6:
b5e6:    95 68 14               ld A, [Y + 0x14]
b5e9:    85 08 02               ld AL, [A + 0x02]
b5ec:    c0 08                  ld BL, 0x08
b5ee:    4a                     and BL, AL
b5ef:    14 17                  bz L_b608
b5f1:    7b d0                  call R_b5c3
b5f3:    21 11                  dec AL, #2
b5f5:    14 04                  bz L_b5fb
b5f7:    20 11                  inc AL, #2
b5f9:    73 79                  jmp L_b674

L_b5fb:
b5fb:    d5 68 1d               ld B, [Y + 0x1d]	 ; CrtDeviceHooks table
b5fe:    85 28 03               ld AL, [B + 0x03]	 ; Get the first FROM character from the translation table
b601:    79 b6 ea               call PrintEcho
b604:    7b bd                  call R_b5c3
b606:    73 6e                  jmp L_b676

L_b608:
b608:    7b b9                  call R_b5c3
b60a:    16 68                  blt L_b674
b60c:    29                     dec AL, #1
b60d:    14 3c                  bz L_b64b
b60f:    29                     dec AL, #1
b610:    15 20                  bnz L_b632
b612:    d5 68 1d               ld B, [Y + 0x1d]	 ; CrtDeviceHooks table
b615:    85 28 03               ld AL, [B + 0x03]	 ; Get the first FROM character from the translation table
b618:    a3 11                  st AL, [0xb62b]
b61a:    d5 68 14               ld B, [Y + 0x14]
b61d:    d5 2c 06               ld B, @[B + 0x06]
b620:    14 29                  bz L_b64b
b622:    79 b6 ea               call PrintEcho
b625:    80 a0                  ld AL, 0xa0
b627:    79 b6 ea               call PrintEcho
b62a:    80 88                  ld AL, 0x88
b62c:    79 b6 ea               call PrintEcho
b62f:    2a                     clr AL, #0
b630:    73 44                  jmp L_b676

L_b632:
b632:    29                     dec AL, #1
b633:    15 04                  bnz L_b639
b635:    80 ab                  ld AL, 0xab
b637:    73 34                  jmp L_b66d

L_b639:
b639:    29                     dec AL, #1
b63a:    14 2f                  bz L_b66b
b63c:    29                     dec AL, #1
b63d:    15 0c                  bnz L_b64b
b63f:    79 b5 c3               call R_b5c3
b642:    73 04                  jmp L_b648

R_b644:
b644:    00

R_b645:
b645:    00

R_b646:
b646:    80 87                  ld AL, 0x87

L_b648:
b648:    79 b6 ea               call PrintEcho

L_b64b:
b64b:    d5 68 2f               ld B, [Y + 0x2f]
b64e:    14 03                  bz R_b653
b650:    71 b5 0f               jmp R_b50f

R_b653:
b653:    65 a1                  ld X, [S++]
b655:    d5 68 2f               ld B, [Y + 0x2f]
b658:    14 0e                  bz L_b668
b65a:    d5 68 35               ld B, [Y + 0x35]
b65d:    14 06                  bz L_b665
b65f:    91 00 5a               ld A, [0x005a]
b662:    e5 08 6b               st BL, [A + 0x6b]

L_b665:
b665:    71 b2 b3               jmp R_b2b3

L_b668:
b668:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b66b:
b66b:    80 ad                  ld AL, 0xad

L_b66d:
b66d:    7b 7b                  call PrintEcho
b66f:    79 b7 b0               call R_b7b0
b672:    80 8d                  ld AL, 0x8d

L_b674:
b674:    7b 74                  call PrintEcho

L_b676:
b676:    79 b7 b0               call R_b7b0
b679:    15 d0                  bnz L_b64b
b67b:    c5 68 12               ld BL, [Y + 0x12]
b67e:    14 0d                  bz L_b68d
b680:    80 8a                  ld AL, 0x8a
b682:    49                     sub BL, AL
b683:    14 04                  bz L_b689
b685:    7b 63                  call PrintEcho
b687:    73 04                  jmp L_b68d

L_b689:
b689:    80 8d                  ld AL, 0x8d
b68b:    7b 5d                  call PrintEcho

L_b68d:
b68d:    8b                     ld AL, [Y]
b68e:    c0 f7                  ld BL, 0xf7
b690:    4a                     and BL, AL
b691:    eb                     st BL, [Y]
b692:    95 68 0d               ld A, [Y + 0x0d]
b695:    14 bc                  bz R_b653
b697:    d0 fb ff               ld B, 0xfbff
b69a:    c8                     ld BL, [A]
b69b:    42 23                  and BL, BH
b69d:    e8                     st BL, [A]
b69e:    73 b3                  jmp R_b653

R_b6a0:
b6a0:    c5 68 11               ld BL, [Y + 0x11]
b6a3:    19 20                  ble L_b6c5
b6a5:    a3 0f                  st AL, [0xb6b6]
b6a7:    55 79 00 14            mov Z, [Y + 0x0014]
b6ab:    d5 88 06               ld B, [Z + 0x06]
b6ae:    99                     ld A, [B]
b6af:    38                     inc A, #1
b6b0:    b5 21                  st A, [B++]
b6b2:    58                     add B, A
b6b3:    47 4d 00 00 20 ff      memcpy 0x01, 0x00, [B + -0x1]
b6b9:    51 91 00 04            sub A, [Z + 0x0004], A
b6bd:    18 06                  bgt L_b6c5

L_b6bf:
b6bf:    79 b7 9b               call R_b79b
b6c2:    71 b7 77               jmp R_b777

L_b6c5:
b6c5:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b6c8:
b6c8:    7e 41                  push {X}
b6ca:    55 79 00 14            mov Z, [Y + 0x0014]
b6ce:    95 88 08               ld A, [Z + 0x08]
b6d1:    65 88 06               ld X, [Z + 0x06]
b6d4:    d5 41                  ld B, [X++]
b6d6:    50 04                  add X, A
b6d8:    38                     inc A, #1
b6d9:    59                     sub B, A
b6da:    19 04                  ble L_b6e0
b6dc:    7f 41                  pop {X}
b6de:    73 df                  jmp L_b6bf

L_b6e0:
b6e0:    b5 88 08               st A, [Z + 0x08]
b6e3:    8a                     ld AL, [X]
b6e4:    7f 41                  pop {X}
b6e6:    7b 0a                  call L_b6f2
b6e8:    73 db                  jmp L_b6c5

PrintEcho:
b6ea:    db                     ld B, [Y]
b6eb:    c0 08                  ld BL, 0x08
b6ed:    42 23                  and BL, BH
b6ef:    14 01                  bz L_b6f2
b6f1:    09                     ret

L_b6f2:
b6f2:    d5 68 0f               ld B, [Y + 0x0f]
b6f5:    f6 32 00               mov BL, Device[B + 0x00]
b6f8:    24 31                  srl BL, #2
b6fa:    11 f6                  bnc L_b6f2
b6fc:    d5 68 0f               ld B, [Y + 0x0f]
b6ff:    f6 13 01               mov Device[B + 0x01], AL
b702:    09                     ret

R_b703:
b703:    c5 68 11               ld BL, [Y + 0x11]
b706:    17 39                  bp L_b741
b708:    95 68 14               ld A, [Y + 0x14]
b70b:    5e                     mov Z, A
b70c:    d5 68 0f               ld B, [Y + 0x0f]
b70f:    f6 12 00               mov AL, Device[B + 0x00]
b712:    24 11                  srl AL, #2
b714:    11 2b                  bnc L_b741
b716:    24 13                  srl AL, #4
b718:    10 05                  bc L_b71f

L_b71a:
b71a:    80 86                  ld AL, 0x86
b71c:    ac                     st AL, [Z]
b71d:    73 58                  jmp R_b777

L_b71f:
b71f:    d0 0a 00               ld B, 0x0a00
b722:    c5 68 01               ld BL, [Y + 0x01]
b725:    41 23                  sub BL, BH
b727:    15 02                  bnz L_b72b
b729:    73 9d                  jmp L_b6c8

L_b72b:
b72b:    95 88 08               ld A, [Z + 0x08]
b72e:    16 2d                  blt L_b75d
b730:    7b 53                  call L_b785
b732:    14 43                  bz R_b777
b734:    7b bc                  call L_b6f2
b736:    a5 68 12               st AL, [Y + 0x12]
b739:    c0 8c                  ld BL, 0x8c
b73b:    49                     sub BL, AL
b73c:    14 2e                  bz L_b76c
b73e:    28                     inc AL, #1
b73f:    15 03                  bnz L_b744

L_b741:
b741:    71 b4 ef               jmp CrtDevice_InterruptHandler_End

L_b744:
b744:    c0 8e                  ld BL, 0x8e
b746:    49                     sub BL, AL
b747:    15 f8                  bnz L_b741
b749:    d5 68 0f               ld B, [Y + 0x0f]
b74c:    f6 32 00               mov BL, Device[B + 0x00]
b74f:    24 35                  srl BL, #6
b751:    10 0e                  bc L_b761
b753:    3a                     clr A, #0
b754:    39                     dec A, #1
b755:    b5 88 08               st A, [Z + 0x08]
b758:    a5 68 11               st AL, [Y + 0x11]
b75b:    73 bd                  jmp L_b71a

L_b75d:
b75d:    2a                     clr AL, #0
b75e:    a5 68 11               st AL, [Y + 0x11]

L_b761:
b761:    85 68 01               ld AL, [Y + 0x01]
b764:    21 11                  dec AL, #2
b766:    15 04                  bnz L_b76c
b768:    80 8a                  ld AL, 0x8a
b76a:    7b 86                  call L_b6f2

L_b76c:
b76c:    80 8d                  ld AL, 0x8d
b76e:    a5 68 12               st AL, [Y + 0x12]
b771:    90 0f a0               ld A, 0x0fa0
b774:    b5 88 08               st A, [Z + 0x08]

R_b777:
b777:    95 68 0d               ld A, [Y + 0x0d]
b77a:    14 c5                  bz L_b741
b77c:    d0 fb ff               ld B, 0xfbff
b77f:    c8                     ld BL, [A]
b780:    42 23                  and BL, BH
b782:    e8                     st BL, [A]
b783:    73 bc                  jmp L_b741

L_b785:
b785:    95 68 14               ld A, [Y + 0x14]
b788:    5e                     mov Z, A
b789:    6d a2                  st X, [--S]
b78b:    95 88 08               ld A, [Z + 0x08]
b78e:    65 88 06               ld X, [Z + 0x06]
b791:    d5 41                  ld B, [X++]
b793:    50 04                  add X, A
b795:    38                     inc A, #1
b796:    59                     sub B, A
b797:    19 0b                  ble L_b7a4
b799:    65 a1                  ld X, [S++]

R_b79b:
b79b:    2a                     clr AL, #0
b79c:    a5 68 11               st AL, [Y + 0x11]
b79f:    a5 6c 03               st AL, @[Y + 0x03]
b7a2:    ac                     st AL, [Z]
b7a3:    09                     ret

L_b7a4:
b7a4:    b5 88 08               st A, [Z + 0x08]
b7a7:    8a                     ld AL, [X]
b7a8:    65 a1                  ld X, [S++]
b7aa:    c0 84                  ld BL, 0x84
b7ac:    49                     sub BL, AL
b7ad:    14 ec                  bz R_b79b
b7af:    09                     ret

R_b7b0:
b7b0:    d5 68 14               ld B, [Y + 0x14]
b7b3:    55 28                  mov Z, B
b7b5:    c5 88 02               ld BL, [Z + 0x02]
b7b8:    45 32                  mov BH, BL
b7ba:    c0 08                  ld BL, 0x08
b7bc:    42 32                  and BH, BL
b7be:    14 07                  bz L_b7c7
b7c0:    6d a2                  st X, [--S]
b7c2:    65 88 06               ld X, [Z + 0x06]
b7c5:    73 27                  jmp L_b7ee

L_b7c7:
b7c7:    c0 8d                  ld BL, 0x8d
b7c9:    49                     sub BL, AL
b7ca:    14 05                  bz L_b7d1
b7cc:    c0 8a                  ld BL, 0x8a
b7ce:    49                     sub BL, AL
b7cf:    15 0d                  bnz L_b7de

L_b7d1:
b7d1:    a5 68 12               st AL, [Y + 0x12]

L_b7d4:
b7d4:    d5 88 06               ld B, [Z + 0x06]
b7d7:    95 21                  ld A, [B++]
b7d9:    58                     add B, A
b7da:    2a                     clr AL, #0
b7db:    a9                     st AL, [B]
b7dc:    73 bd                  jmp R_b79b

L_b7de:
b7de:    6d a2                  st X, [--S]
b7e0:    65 88 06               ld X, [Z + 0x06]
b7e3:    4d                     mov BL, AL
b7e4:    16 08                  blt L_b7ee
b7e6:    9a                     ld A, [X]
b7e7:    19 02                  ble L_b7eb
b7e9:    39                     dec A, #1
b7ea:    ba                     st A, [X]

L_b7eb:
b7eb:    65 a1                  ld X, [S++]
b7ed:    09                     ret

L_b7ee:
b7ee:    4d                     mov BL, AL
b7ef:    9a                     ld A, [X]
b7f0:    38                     inc A, #1
b7f1:    b5 41                  st A, [X++]
b7f3:    50 04                  add X, A
b7f5:    e5 42                  st BL, [--X]
b7f7:    d5 88 04               ld B, [Z + 0x04]
b7fa:    59                     sub B, A
b7fb:    16 ee                  blt L_b7eb
b7fd:    65 a1                  ld X, [S++]
b7ff:    2a                     clr AL, #0
b800:    a5 68 12               st AL, [Y + 0x12]
b803:    73 cf                  jmp L_b7d4

CrtDevice_Init:
b805:    90 b8 4f               ld A, WDCDeviceObj|0xb84f
b808:    d7 6a                  mov IL6(S), A
b80a:    90 b3 6f               ld A, level6Handler|0xb36f
b80d:    d7 6e                  mov IL6(P), A
b80f:    55 60                  mov A, Y
b811:    b5 a2                  st A, [--S]
b813:    6d a2                  st X, [--S]
b815:    91 01 0b               ld A, [0x010b]
b818:    65 01                  ld X, [A++]
b81a:    34 40                  srl X, #1
b81c:    5c                     mov Y, A

L_b81d:
b81d:    95 61                  ld A, [Y++]	 ; A = device_obj
b81f:    14 25                  bz L_b846	 ; Skip if nullptr
b821:    c8                     ld BL, [A]	 ; If [device_obj + 1] is zero, the device is disabled
b822:    14 22                  bz L_b846
b824:    c5 08 19               ld BL, [A + 0x19]	 ; BL = baud rate
b827:    e5 0c 0f               st BL, @[A + 0x0f]	 ; Why setting twice ?
b82a:    95 08 0f               ld A, [A + 0x0f]	 ; A = serial port base
b82d:    f6 31 00               mov Device[A + 0x00], BL	 ; Set baud rate
b830:    c0 94                  ld BL, 0x94
b832:    f6 31 01               mov Device[A + 0x01], BL	 ; Write '\x14'
b835:    c0 f0                  ld BL, 0xf0
b837:    42 31                  and AL, BL	 ; Convert from port base to MUX card base
b839:    c0 06                  ld BL, 0x06
b83b:    f6 31 0a               mov Device[A + 0x0a], BL	 ; Read IRQ level 6
b83e:    f6 31 0e               mov Device[A + 0x0e], BL	 ; Write IRQ level 6
b841:    c0 e0                  ld BL, 0xe0
b843:    f6 31 0b               mov Device[A + 0x0b], BL	 ; We don't know what this does

L_b846:
b846:    3f                     dec X
b847:    18 d4                  bgt L_b81d
b849:    65 a1                  ld X, [S++]
b84b:    95 a1                  ld A, [S++]
b84d:    5c                     mov Y, A
b84e:    09                     ret

WDCDeviceObj:
b84f:    00 06                  (0x6)
b851:    ce 9e                  DiskDevice_Abort
b853:    cd f3                  DiskDevice_Read
b855:    ce 23                  DiskDevice_Write
b857:    b8 61                  R_b861
b859:    ba 25                  R_ba25
b85b:    bb 02                  R_bb02	 ; '	 ; '	 ; '	 ; '	 ; '
b85d:    bb 1d                  R_bb1d	 ; '	 ; '	 ; '	 ; '	 ; '
b85f:    cd 74                  DiskDevice_BlockIO_Special

R_b861:
b861:    7f 01                  pop {A}
b863:    b1 b9 6c               st A, [R_b96c|0xb96c]
b866:    85 a8 06               ld AL, [S + 0x06]
b869:    79 ba 0a               call R_ba0a
b86c:    a1 b9 7b               st AL, [R_b97b|0xb97b]
b86f:    e1 b9 7d               st BL, [R_b97c+1|0xb97d]
b872:    55 80                  mov A, Z
b874:    b5 a2                  st A, [--S]

R_b876:
b876:    90 b9 81               ld A, R_b981|0xb981
b879:    5e                     mov Z, A
b87a:    95 a8 04               ld A, [S + 0x04]
b87d:    b1 b9 21               st A, [R_b921|0xb921]
b880:    3a                     clr A, #0
b881:    b1 b9 06               st A, [R_b906|0xb906]
b884:    85 a8 02               ld AL, [S + 0x02]
b887:    14 13                  bz L_b89c
b889:    c0 85                  ld BL, 0x85
b88b:    29                     dec AL, #1
b88c:    14 02                  bz L_b890
b88e:    c0 8a                  ld BL, 0x8a

L_b890:
b890:    e5 81                  st BL, [Z++]
b892:    e0 00                  st BL, 0x00
b894:    95 a8 0b               ld A, [S + 0x0b]
b897:    15 03                  bnz L_b89c
b899:    71 b9 54               jmp R_b954

L_b89c:
b89c:    90 ff ff               ld A, 0xffff
b89f:    b1 b9 7f               st A, [R_b97f|0xb97f]

L_b8a2:
b8a2:    95 a8 06               ld A, [S + 0x06]
b8a5:    d5 a8 09               ld B, [S + 0x09]
b8a8:    79 cd 33               call R_cd33
b8ab:    79 cc e8               call R_cce8
b8ae:    7e 01                  push {A}
b8b0:    79 bd 6c               call R_bd6c
b8b3:    b3 04                  st A, [0xb8b9]
b8b5:    7f 01                  pop {A}
b8b7:    78 30 00 28            mul A, B, 0x0028
b8bb:    a5 81                  st AL, [Z++]
b8bd:    7e 21                  push {B}
b8bf:    90 03 37               ld A, 0x0337
b8c2:    59                     sub B, A
b8c3:    10 06                  bc L_b8cb

L_b8c5:
b8c5:    7f 21                  pop {B}
b8c7:    c0 05                  ld BL, 0x05
b8c9:    66 6b                  jsys 0x6b

L_b8cb:
b8cb:    14 f8                  bz L_b8c5
b8cd:    7f 21                  pop {B}
b8cf:    91 b9 7f               ld A, [R_b97f|0xb97f]
b8d2:    38                     inc A, #1
b8d3:    14 05                  bz L_b8da
b8d5:    39                     dec A, #1
b8d6:    51 20                  sub A, B
b8d8:    15 40                  bnz L_b91a

L_b8da:
b8da:    f1 b9 7f               st B, [R_b97f|0xb97f]
b8dd:    85 a8 02               ld AL, [S + 0x02]
b8e0:    14 38                  bz L_b91a
b8e2:    d5 a8 0b               ld B, [S + 0x0b]
b8e5:    30 b0 00 06            inc [S + 0x0006], #1
b8e9:    90 01 90               ld A, 0x0190
b8ec:    59                     sub B, A
b8ed:    11 03                  bnc L_b8f2
b8ef:    95 a8 0b               ld A, [S + 0x0b]

L_b8f2:
b8f2:    c5 a8 02               ld BL, [S + 0x02]
b8f5:    21 31                  dec BL, #2
b8f7:    15 03                  bnz L_b8fc
b8f9:    90 01 90               ld A, 0x0190

L_b8fc:
b8fc:    b5 81                  st A, [Z++]
b8fe:    d5 a8 04               ld B, [S + 0x04]
b901:    58                     add B, A
b902:    f5 a8 04               st B, [S + 0x04]
b905:    d0 00 00               ld B, 0x0000
b908:    58                     add B, A
b909:    f3 fb                  st B, [R_b906|0xb906]
b90b:    d5 a8 0b               ld B, [S + 0x0b]
b90e:    51 20                  sub A, B
b910:    17 01                  bp L_b913
b912:    3a                     clr A, #0

L_b913:
b913:    b5 a8 0b               st A, [S + 0x0b]
b916:    15 8a                  bnz L_b8a2
b918:    73 02                  jmp L_b91c

L_b91a:
b91a:    31 80                  dec Z, #1

L_b91c:
b91c:    80 ff                  ld AL, 0xff
b91e:    a5 81                  st AL, [Z++]
b920:    90 00 00               ld A, 0x0000
b923:    b5 81                  st A, [Z++]
b925:    93 df                  ld A, [R_b906|0xb906]
b927:    bc                     st A, [Z]
b928:    90 b9 7c               ld A, R_b97c|0xb97c
b92b:    51 80                  sub A, Z
b92d:    a3 4a                  st AL, [R_b979|0xb979]
b92f:    85 a8 03               ld AL, [S + 0x03]
b932:    a1 bb 4c               st AL, [R_bb4b+1|0xbb4c]

L_b935:
b935:    79 bb 4b               call R_bb4b
b938:    b9                     st A, [B]
b939:    77 4d 15 17            div C, X, [0x1517]
b93d:    85 a8 02               ld AL, [S + 0x02]
b940:    14 12                  bz R_b954
b942:    83 3d                  ld AL, [R_b981|0xb981]
b944:    c0 8a                  ld BL, 0x8a
b946:    49                     sub BL, AL
b947:    14 03                  bz L_b94c
b949:    71 b8 76               jmp R_b876

L_b94c:
b94c:    80 88                  ld AL, 0x88
b94e:    a3 31                  st AL, [R_b981|0xb981]
b950:    31 82                  dec Z, #3
b952:    73 e1                  jmp L_b935

R_b954:
b954:    a3 1f                  st AL, [0xb975]
b956:    95 a1                  ld A, [S++]
b958:    5e                     mov Z, A
b959:    d5 a8 04               ld B, [S + 0x04]
b95c:    31 20                  dec B, #1
b95e:    90 00 0b               ld A, 0x000b
b961:    50 0a                  add S, A
b963:    95 a1                  ld A, [S++]
b965:    5c                     mov Y, A
b966:    80 ff                  ld AL, 0xff
b968:    a1 01 1f               st AL, [0x011f]
b96b:    90 00 00               ld A, 0x0000
b96e:    7e 01                  push {A}
b970:    d1 bd 66               ld B, [R_bd66|0xbd66]
b973:    90 00 00               ld A, 0x0000
b976:    09                     ret

R_b977:
b977:    00
b978:    00

R_b979:
b979:    00
b97a:    81

R_b97b:
b97b:    00

R_b97c:
b97c:    84 00                  ld AL, @[0xb97e]
b97e:    83 00                  ld AL, [0xb980]
b980:    <null bytes>


R_b981:
b981:    <null bytes>


R_b983:
b983:    <null bytes>


R_b985:
b985:    <null bytes>


R_ba0a:
ba0a:    22 00                  clr AH, #0
ba0c:    21 00                  dec AH, #1

L_ba0e:
ba0e:    20 00                  inc AH, #1
ba10:    21 15                  dec AL, #6
ba12:    17 fa                  bp L_ba0e
ba14:    20 15                  inc AL, #6
ba16:    45 12                  mov BH, AL
ba18:    c0 0f                  ld BL, 0x0f
ba1a:    42 32                  and BH, BL
ba1c:    15 02                  bnz L_ba20
ba1e:    22 30                  clr BL, #0

L_ba20:
ba20:    40 23                  add BL, BH
ba22:    45 01                  mov AL, AH
ba24:    09                     ret

R_ba25:
ba25:    7e 45                  push {X, Y, Z}
ba27:    d6 ab ba fc            st S, [L_bafa+2|0xbafc]
ba2b:    80 ff                  ld AL, 0xff
ba2d:    a1 bb 4c               st AL, [R_bb4b+1|0xbb4c]
ba30:    79 bc 36               call R_bc36
ba33:    08                     cl
ba34:    95 68 0f               ld A, [Y + 0x0f]
ba37:    5e                     mov Z, A
ba38:    90 ff ff               ld A, 0xffff
ba3b:    f6 19 00               mov Device[Z + 0x00], AL
ba3e:    79 bc 36               call R_bc36
ba41:    08                     cl
ba42:    14 03                  bz L_ba47
ba44:    79 bb 0b               call R_bb0b

L_ba47:
ba47:    f6 18 00               mov AL, Device[Z + 0x00]
ba4a:    c0 12                  ld BL, 0x12
ba4c:    49                     sub BL, AL
ba4d:    14 03                  bz L_ba52
ba4f:    71 ba e6               jmp R_bae6

L_ba52:
ba52:    85 68 13               ld AL, [Y + 0x13]
ba55:    7b b3                  call R_ba0a
ba57:    e1 b9 7d               st BL, [R_b97c+1|0xb97d]
ba5a:    e1 bd 88               st BL, [R_bd88|0xbd88]
ba5d:    a1 b9 7b               st AL, [R_b97b|0xb97b]
ba60:    a1 bd 86               st AL, [R_bd86|0xbd86]
ba63:    2a                     clr AL, #0
ba64:    a1 b9 7f               st AL, [R_b97f|0xb97f]
ba67:    80 09                  ld AL, 0x09
ba69:    a1 b9 79               st AL, [R_b979|0xb979]
ba6c:    90 8c ff               ld A, 0x8cff
ba6f:    b1 b9 81               st A, [R_b981|0xb981]
ba72:    90 bb 01               ld A, R_bb01|0xbb01
ba75:    b1 b9 83               st A, [R_b983|0xb983]
ba78:    3a                     clr A, #0
ba79:    b1 b9 85               st A, [R_b985|0xb985]
ba7c:    90 00 4a               ld A, 0x004a
ba7f:    f6 19 00               mov Device[Z + 0x00], AL
ba82:    66 07                  jsys Syscall_Yield
ba84:    79 bc 36               call R_bc36
ba87:    02                     sf
ba88:    f6 18 00               mov AL, Device[Z + 0x00]
ba8b:    c0 12                  ld BL, 0x12
ba8d:    49                     sub BL, AL
ba8e:    14 2d                  bz L_babd
ba90:    90 08 d1               ld A, 0x08d1
ba93:    b5 68 11               st A, [Y + 0x11]
ba96:    90 00 01               ld A, 0x0001
ba99:    f6 19 00               mov Device[Z + 0x00], AL
ba9c:    66 07                  jsys Syscall_Yield
ba9e:    79 bc 36               call R_bc36
baa1:    02                     sf
baa2:    90 00 90               ld A, 0x0090
baa5:    f6 19 00               mov Device[Z + 0x00], AL
baa8:    66 07                  jsys Syscall_Yield
baaa:    79 bc 36               call R_bc36
baad:    02                     sf
baae:    79 bc 36               call R_bc36
bab1:    08                     cl
bab2:    79 bb 4b               call R_bb4b
bab5:    bd                     st A, [S]
bab6:    82 45 11               ld AL, @[0x4511]
bab9:    14 1e                  bz L_bad9
babb:    73 0e                  jmp L_bacb

L_babd:
babd:    79 bb 4b               call R_bb4b
bac0:    bd                     st A, [S]
bac1:    82 45 11               ld AL, @[0x4511]
bac4:    14 0d                  bz L_bad3
bac6:    f6 19 01               mov Device[Z + 0x01], AL
bac9:    73 08                  jmp L_bad3

L_bacb:
bacb:    d0 ff ff               ld B, 0xffff
bace:    f5 68 11               st B, [Y + 0x11]
bad1:    73 06                  jmp L_bad9

L_bad3:
bad3:    d0 08 03               ld B, 0x0803
bad6:    f5 68 11               st B, [Y + 0x11]

L_bad9:
bad9:    7b 70                  call R_bb4b
badb:    b9                     st A, [B]
badc:    77 45 11 14            div X, X, [0x1114]
bae0:    09                     ret
bae1:    c0 '@'
bae2:    42
bae3:    49
bae4:    14
bae5:    09

R_bae6:
bae6:    32 20                  clr B, #0
bae8:    73 08                  jmp L_baf2
baea:    d0 'P'
baeb:    00
baec:    ff
baed:    73
baee:    03
baef:    d0 'P'
baf0:    ff
baf1:    ff

L_baf2:
baf2:    80 ff                  ld AL, 0xff
baf4:    a1 01 1f               st AL, [0x011f]
baf7:    f6 19 01               mov Device[Z + 0x01], AL

L_bafa:
bafa:    55 ba 00 00            mov S, 0x0000
bafe:    7f 45                  pop {X, Y, Z}
bb00:    09                     ret

R_bb01:
bb01:    00

R_bb02:
bb02:    79 bc 36               call R_bc36
bb05:    08                     cl
bb06:    80 ff                  ld AL, 0xff
bb08:    a1 01 1f               st AL, [0x011f]

R_bb0b:
bb0b:    95 68 0f               ld A, [Y + 0x0f]
bb0e:    f6 11 01               mov Device[A + 0x01], AL
bb11:    79 bc 36               call R_bc36
bb14:    08                     cl
bb15:    15 01                  bnz L_bb18
bb17:    09                     ret

L_bb18:
bb18:    79 be 01               call R_be01
bb1b:    be                     st A, [C]
bb1c:    5c                     mov Y, A

R_bb1d:
bb1d:    7e 45                  push {X, Y, Z}
bb1f:    d6 ab ba fc            st S, [L_bafa+2|0xbafc]
bb23:    d6 89 bb 3f            st Z, [R_bb3f|0xbb3f]
bb27:    85 68 13               ld AL, [Y + 0x13]
bb2a:    79 ba 0a               call R_ba0a
bb2d:    45 30                  mov AH, BL
bb2f:    d3 0e                  ld B, [R_bb3f|0xbb3f]
bb31:    a5 28 04               st AL, [B + 0x04]
bb34:    45 01                  mov AL, AH
bb36:    a5 28 06               st AL, [B + 0x06]
bb39:    80 01                  ld AL, 0x01
bb3b:    a3 0f                  st AL, [R_bb4b+1|0xbb4c]
bb3d:    7b 0c                  call R_bb4b

R_bb3f:
bb3f:    00                     HALT
bb40:    00                     HALT
bb41:    47 4c 00 ff 01 1f      memcpy 0x01, 0xff, [0x011f]
bb47:    45 11                  mov AL, AL
bb49:    73 af                  jmp L_bafa

R_bb4b:
bb4b:    80 00                  ld AL, 0x00
bb4d:    15 02                  bnz L_bb51
bb4f:    80 0d                  ld AL, 0x0d

L_bb51:
bb51:    a1 bc ce               st AL, [R_bcce|0xbcce]
bb54:    7e 45                  push {X, Y, Z}
bb56:    55 a0                  mov A, S
bb58:    b1 bb ee               st A, [R_bbed+1|0xbbee]
bb5b:    95 68 0f               ld A, [Y + 0x0f]
bb5e:    5e                     mov Z, A
bb5f:    91 01 03               ld A, [CurrentProcess|0x0103]
bb62:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
bb67:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
bb6c:    c0 02                  ld BL, 0x02
bb6e:    2f 28                  ld_isr B

R_bb70:
bb70:    65 a4                  ld X, @[S]
bb72:    69 bd 37               st X, [R_bd37|0xbd37]
bb75:    79 bc 36               call R_bc36
bb78:    08                     cl
bb79:    15 36                  bnz L_bbb1
bb7b:    f6 18 00               mov AL, Device[Z + 0x00]
bb7e:    80 41                  ld AL, 0x41
bb80:    f6 19 00               mov Device[Z + 0x00], AL
bb83:    79 bc 0d               call R_bc0d
bb86:    08                     cl
bb87:    15 28                  bnz L_bbb1
bb89:    85 41                  ld AL, [X++]
bb8b:    f6 19 00               mov Device[Z + 0x00], AL
bb8e:    79 bc 36               call R_bc36
bb91:    02                     sf
bb92:    15 1d                  bnz L_bbb1
bb94:    85 41                  ld AL, [X++]
bb96:    f6 19 00               mov Device[Z + 0x00], AL
bb99:    d5 48 06               ld B, [X + 0x06]
bb9c:    79 bd 6c               call R_bd6c
bb9f:    b3 02                  st A, [0xbba3]
bba1:    77 32 00 28            div B, B, 0x0028
bba5:    3a                     clr A, #0
bba6:    85 48 09               ld AL, [X + 0x09]
bba9:    58                     add B, A
bbaa:    f1 bd 66               st B, [R_bd66|0xbd66]
bbad:    7b 50                  call R_bbff
bbaf:    14 03                  bz L_bbb4

L_bbb1:
bbb1:    71 bc 4e               jmp R_bc4e

L_bbb4:
bbb4:    3a                     clr A, #0
bbb5:    85 41                  ld AL, [X++]
bbb7:    14 34                  bz R_bbed
bbb9:    c5 68 02               ld BL, [Y + 0x02]
bbbc:    e1 bd 64               st BL, [R_bd64|0xbd64]
bbbf:    55 42                  mov B, X
bbc1:    50 04                  add X, A
bbc3:    79 bd d6               call R_bdd6
bbc6:    80 43                  ld AL, 0x43
bbc8:    f6 19 00               mov Device[Z + 0x00], AL
bbcb:    7b 32                  call R_bbff
bbcd:    14 05                  bz L_bbd4
bbcf:    79 be 01               call R_be01
bbd2:    be                     st A, [C]
bbd3:    41

L_bbd4:
bbd4:    79 bd e7               call R_bde7
bbd7:    d5 41                  ld B, [X++]
bbd9:    9a                     ld A, [X]
bbda:    79 bd d6               call R_bdd6
bbdd:    80 45                  ld AL, 0x45
bbdf:    f6 19 00               mov Device[Z + 0x00], AL
bbe2:    7b 1b                  call R_bbff
bbe4:    15 68                  bnz R_bc4e
bbe6:    7e 01                  push {A}
bbe8:    79 bd e7               call R_bde7
bbeb:    7f 01                  pop {A}

R_bbed:
bbed:    60 00 00               ld X, 0x0000
bbf0:    55 4a                  mov S, X
bbf2:    7f 45                  pop {X, Y, Z}
bbf4:    32 20                  clr B, #0
bbf6:    e1 bc 56               st BL, [R_bc56|0xbc56]
bbf9:    d1 bd 66               ld B, [R_bd66|0xbd66]
bbfc:    30 41                  inc X, #2
bbfe:    09                     ret

R_bbff:
bbff:    7b 35                  call R_bc36
bc01:    08                     cl
bc02:    15 08                  bnz L_bc0c
bc04:    7b 07                  call R_bc0d
bc06:    01                     nop
bc07:    15 03                  bnz L_bc0c
bc09:    f6 18 00               mov AL, Device[Z + 0x00]

L_bc0c:
bc0c:    09                     ret

R_bc0d:
bc0d:    85 41                  ld AL, [X++]
bc0f:    a5 a2                  st AL, [--S]
bc11:    79 ce 2a               call SetTimeout8

L_bc14:
bc14:    d5 68 0f               ld B, [Y + 0x0f]
bc17:    f6 32 01               mov BL, Device[B + 0x01]
bc1a:    8d                     ld AL, [S]
bc1b:    4a                     and BL, AL
bc1c:    49                     sub BL, AL
bc1d:    14 0d                  bz L_bc2c
bc1f:    79 ce 33               call CheckTimeout
bc22:    14 f0                  bz L_bc14

L_bc24:
bc24:    85 a1                  ld AL, [S++]
bc26:    3a                     clr A, #0
bc27:    39                     dec A, #1
bc28:    a1 bc 52               st AL, [R_bc52|0xbc52]
bc2b:    09                     ret

L_bc2c:
bc2c:    85 a1                  ld AL, [S++]
bc2e:    79 ce 41               call SetTimeout256
bc31:    3a                     clr A, #0
bc32:    a1 bc 52               st AL, [R_bc52|0xbc52]
bc35:    09                     ret

R_bc36:
bc36:    85 41                  ld AL, [X++]
bc38:    a5 a2                  st AL, [--S]
bc3a:    79 ce 2a               call SetTimeout8

L_bc3d:
bc3d:    d5 68 0f               ld B, [Y + 0x0f]
bc40:    f6 32 01               mov BL, Device[B + 0x01]
bc43:    8d                     ld AL, [S]
bc44:    4a                     and BL, AL
bc45:    14 e5                  bz L_bc2c
bc47:    79 ce 33               call CheckTimeout
bc4a:    14 f1                  bz L_bc3d
bc4c:    73 d6                  jmp L_bc24

R_bc4e:
bc4e:    f6 19 01               mov Device[Z + 0x01], AL
bc51:    c0 00                  ld BL, 0x00
bc53:    14 11                  bz L_bc66
bc55:    c0 00                  ld BL, 0x00
bc57:    20 30                  inc BL, #1
bc59:    e3 fb                  st BL, [R_bc56|0xbc56]
bc5b:    21 32                  dec BL, #3
bc5d:    16 49                  blt L_bca8
bc5f:    e3 f5                  st BL, [R_bc56|0xbc56]
bc61:    79 be 01               call R_be01
bc64:    be                     st A, [C]
bc65:    5c                     mov Y, A

L_bc66:
bc66:    c1 bb 4c               ld BL, [R_bb4b+1|0xbb4c]
bc69:    17 02                  bp L_bc6d
bc6b:    73 80                  jmp R_bbed

L_bc6d:
bc6d:    c0 41                  ld BL, 0x41
bc6f:    49                     sub BL, AL
bc70:    15 05                  bnz L_bc77
bc72:    90 ce d2               ld A, 0xced2
bc75:    73 12                  jmp L_bc89

L_bc77:
bc77:    c0 24                  ld BL, 0x24
bc79:    49                     sub BL, AL
bc7a:    15 05                  bnz L_bc81
bc7c:    90 c6 cc               ld A, 0xc6cc
bc7f:    73 08                  jmp L_bc89

L_bc81:
bc81:    c0 42                  ld BL, 0x42
bc83:    49                     sub BL, AL
bc84:    15 29                  bnz L_bcaf
bc86:    90 d7 d0               ld A, 0xd7d0

L_bc89:
bc89:    b1 be 78               st A, [R_be75+3|0xbe78]
bc8c:    90 c0 c0               ld A, 0xc0c0
bc8f:    b1 be 7b               st A, [R_be75+6|0xbe7b]
bc92:    80 02                  ld AL, 0x02
bc94:    46 80 91 be 7b 60 02   baseconv(8, 0) [R_be75+6|0xbe7b], [Y + 0x02]
bc9b:    79 a5 50               call R_a550
bc9e:    be                     st A, [C]
bc9f:    75 60                  jmp [Y]
bca1:    13
bca2:    88
bca3:    66
bca4:    07
bca5:    3f
bca6:    18
bca7:    fb '{'

L_bca8:
bca8:    95 68 0f               ld A, [Y + 0x0f]
bcab:    5e                     mov Z, A
bcac:    71 bb 70               jmp R_bb70

L_bcaf:
bcaf:    c0 2a                  ld BL, 0x2a
bcb1:    49                     sub BL, AL
bcb2:    14 04                  bz L_bcb8
bcb4:    21 30                  dec BL, #1
bcb6:    15 03                  bnz L_bcbb

L_bcb8:
bcb8:    79 bd 97               call R_bd97

L_bcbb:
bcbb:    a5 a2                  st AL, [--S]
bcbd:    90 c0 c0               ld A, 0xc0c0
bcc0:    b1 be b8               st A, [R_beb8|0xbeb8]
bcc3:    80 02                  ld AL, 0x02
bcc5:    46 e0 92 be b8 0a      baseconv(e, 0) [R_beb8|0xbeb8], [S]
bccb:    85 a1                  ld AL, [S++]
bccd:    c0 00                  ld BL, 0x00
bccf:    21 30                  dec BL, #1
bcd1:    e3 fb                  st BL, [R_bcce|0xbcce]
bcd3:    19 30                  ble L_bd05
bcd5:    95 a4                  ld A, @[S]
bcd7:    50 10 00 0a            add A, A, 0x000a

L_bcdb:
bcdb:    c8                     ld BL, [A]
bcdc:    20 30                  inc BL, #1
bcde:    14 c8                  bz L_bca8
bce0:    21 30                  dec BL, #1
bce2:    45 32                  mov BH, BL
bce4:    c0 85                  ld BL, 0x85
bce6:    41 23                  sub BL, BH
bce8:    15 04                  bnz L_bcee
bcea:    c0 86                  ld BL, 0x86
bcec:    73 12                  jmp L_bd00

L_bcee:
bcee:    c0 86                  ld BL, 0x86
bcf0:    41 23                  sub BL, BH
bcf2:    15

L_bcf3:
bcf3:    04                     ei
bcf4:    c0 87                  ld BL, 0x87
bcf6:    73 08                  jmp L_bd00

L_bcf8:
bcf8:    c0 87                  ld BL, 0x87
bcfa:    41 23                  sub BL, BH
bcfc:    15 03                  bnz L_bd01
bcfe:    c0 85                  ld BL, 0x85

L_bd00:
bd00:    e8                     st BL, [A]

L_bd01:
bd01:    30 03                  inc A, #4
bd03:    73 d6                  jmp L_bcdb

L_bd05:
bd05:    79 bd 97               call R_bd97
bd08:    c0 30                  ld BL, 0x30
bd0a:    49                     sub BL, AL
bd0b:    16 05                  blt L_bd12
bd0d:    d0 be 7e               ld B, R_be7e|0xbe7e
bd10:    73 0d                  jmp L_bd1f

L_bd12:
bd12:    c0 20                  ld BL, 0x20
bd14:    49                     sub BL, AL
bd15:    16 05                  blt L_bd1c
bd17:    d0 be e8               ld B, R_bee8|0xbee8
bd1a:    73 03                  jmp L_bd1f

L_bd1c:
bd1c:    d0 be 8e               ld B, R_be8e|0xbe8e

L_bd1f:
bd1f:    f3 0e                  st B, [R_bd2f|0xbd2f]
bd21:    c1 bb 4c               ld BL, [R_bb4b+1|0xbb4c]
bd24:    14 03                  bz R_bd29
bd26:    71 bb ed               jmp R_bbed

R_bd29:
bd29:    7c 07                  call R_a550 (via 0xbd31+1)
bd2b:    be                     st A, [C]
bd2c:    21 7c                  dec YL, #13
bd2e:    03                     rf

R_bd2f:
bd2f:    00                     HALT
bd30:    00                     HALT
bd31:    79 a5 50               call R_a550
bd34:    be                     st A, [C]
bd35:    b3 90                  st A, [0xbcc7]

R_bd37:
bd37:    b9                     st A, [B]
bd38:    77 5c 3a 85            div C, X, 0x3a85
bd3c:    68 02 30               st X, 0x0230
bd3f:    02                     sf
bd40:    5b                     mov X, A
bd41:    90 c0 c0               ld A, 0xc0c0
bd44:    b1 be c3               st A, [R_bec3|0xbec3]
bd47:    80 02                  ld AL, 0x02
bd49:    46 e0 92 be c3 06      baseconv(e, 0) [R_bec3|0xbec3], [Y]
bd4f:    30 60                  inc Y, #1
bd51:    7c df                  call R_a550 (via 0xbd31+1)
bd53:    be                     st A, [C]
bd54:    c1 3f 18               ld BL, [0x3f18]
bd57:    e9                     st BL, [B]
bd58:    7c d8                  call R_a550 (via 0xbd31+1)
bd5a:    be                     st A, [C]
bd5b:    21 47                  dec XH, #8
bd5d:    4c                     mov YL, AL
bd5e:    00                     HALT
bd5f:    ff                     st B, [P]
bd60:    01                     nop
bd61:    1f 90                  branch_unlocked L_bcf3
bd63:    00                     HALT

R_bd64:
bd64:    00                     HALT
bd65:    d0 00 00               ld B, 0x0000
bd68:    c0 0d                  ld BL, 0x0d
bd6a:    66 6b                  jsys 0x6b

R_bd6c:
bd6c:    7e 21                  push {B}
bd6e:    95 68 11               ld A, [Y + 0x11]
bd71:    d0 08 d1               ld B, 0x08d1
bd74:    59                     sub B, A
bd75:    14 05                  bz L_bd7c
bd77:    90 00 28               ld A, 0x0028
bd7a:    73 03                  jmp L_bd7f

L_bd7c:
bd7c:    90 00 2c               ld A, 0x002c

L_bd7f:
bd7f:    7f 21                  pop {B}
bd81:    09                     ret

R_bd82:
bd82:    00
bd83:    00
bd84:    0c
bd85:    81

R_bd86:
bd86:    00
bd87:    84

R_bd88:
bd88:    00
bd89:    83
bd8a:    00
bd8b:    00
bd8c:    85
bd8d:    00
bd8e:    00
bd8f:    02
bd90:    ff
bd91:    bd '='
bd92:    95
bd93:    00
bd94:    02

R_bd95:
bd95:    00
bd96:    00

R_bd97:
bd97:    a3 37                  st AL, [L_bdcf+1|0xbdd0]
bd99:    85 68 13               ld AL, [Y + 0x13]
bd9c:    79 ba 0a               call R_ba0a
bd9f:    a3 32                  st AL, [R_bdd2+1|0xbdd3]
bda1:    79 bc 36               call R_bc36
bda4:    08                     cl
bda5:    15 24                  bnz L_bdcb
bda7:    d0 bd d2               ld B, R_bdd2|0xbdd2
bdaa:    90 00 04               ld A, 0x0004
bdad:    7b 27                  call R_bdd6
bdaf:    80 43                  ld AL, 0x43
bdb1:    f6 19 00               mov Device[Z + 0x00], AL
bdb4:    79 bb ff               call R_bbff
bdb7:    15 12                  bnz L_bdcb
bdb9:    d0 bb 01               ld B, R_bb01|0xbb01
bdbc:    90 00 01               ld A, 0x0001
bdbf:    7b 15                  call R_bdd6
bdc1:    80 45                  ld AL, 0x45
bdc3:    f6 19 00               mov Device[Z + 0x00], AL
bdc6:    79 bb ff               call R_bbff
bdc9:    14 04                  bz L_bdcf

L_bdcb:
bdcb:    7b 34                  call R_be01
bdcd:    be                     st A, [C]
bdce:    fa                     st B, [X]

L_bdcf:
bdcf:    80 00                  ld AL, 0x00
bdd1:    09                     ret

R_bdd2:
bdd2:    81 00 82               ld AL, [0x0082]
bdd5:    ff                     st B, [P]

R_bdd6:
bdd6:    2f 34                  dma_mode #3
bdd8:    2f 20                  ld_dma_addr B
bdda:    3b                     not A, #0
bddb:    2f 02                  ld_dma_count A
bddd:    2f 06                  enable_dma
bddf:    59                     sub B, A
bde0:    f0 00 00               st B, 0x0000
bde3:    3a                     clr A, #0
bde4:    d7 12                  mov IL1(B), A
bde6:    09                     ret

R_bde7:
bde7:    2f 07                  disable_dma
bde9:    2f 03                  st_dma_count A
bdeb:    38                     inc A, #1
bdec:    14 04                  bz L_bdf2
bdee:    7b 11                  call R_be01
bdf0:    be                     st A, [C]
bdf1:    c6                     acquire_semaphore

L_bdf2:
bdf2:    2f 03                  st_dma_count A
bdf4:    2f 21                  st_dma_addr B
bdf6:    59                     sub B, A
bdf7:    93 e8                  ld A, [0xbde1]
bdf9:    59                     sub B, A
bdfa:    15 01                  bnz L_bdfd
bdfc:    09                     ret

L_bdfd:
bdfd:    7b 02                  call R_be01
bdff:    be                     st A, [C]
be00:    da                     ld B, [X]

R_be01:
be01:    f6 19 01               mov Device[Z + 0x01], AL
be04:    81 bb 4c               ld AL, [R_bb4b+1|0xbb4c]
be07:    17 03                  bp L_be0c
be09:    71 ba e6               jmp R_bae6

L_be0c:
be0c:    14 05                  bz L_be13
be0e:    80 ff                  ld AL, 0xff
be10:    71 bb ed               jmp R_bbed

L_be13:
be13:    95 41                  ld A, [X++]
be15:    b1 bd 2f               st A, [R_bd2f|0xbd2f]
be18:    90 d8 d8               ld A, 0xd8d8
be1b:    b1 be b8               st A, [R_beb8|0xbeb8]
be1e:    71 bd 29               jmp R_bd29

R_be21:
be21:    1, "\r"
be24:    27, "WDC CONTROL SIGNAL FAILURE\r"

R_be41:
be41:    25, "WDC COMMAND LOAD FAILURE\r"

R_be5c:
be5c:    23, "WDC CONTROL SIGNAL LAG\r"

R_be75:
be75:    7, "\x07ID NN\r"

R_be7e:
be7e:    14, "WDC I/O ERROR\r"

R_be8e:
be8e:    00
be8f:    23
be90:    d7 'W'
be91:    c4 'D'
be92:    c3 'C'
be93:    a0 ' '
be94:    c5 'E'
be95:    d2 'R'
be96:    d2 'R'
be97:    cf 'O'
be98:    d2 'R'
be99:    a0 ' '
be9a:    ad '-'
be9b:    a0 ' '
be9c:    c9 'I'
be9d:    cc 'L'
be9e:    cc 'L'
be9f:    c5 'E'
bea0:    c7 'G'
bea1:    c1 'A'
bea2:    cc 'L'
bea3:    a0 ' '
bea4:    c3 'C'
bea5:    cf 'O'
bea6:    cd 'M'
bea7:    cd 'M'
bea8:    c1 'A'
bea9:    ce 'N'
beaa:    c4 'D'
beab:    a0 ' '
beac:    d3 'S'
bead:    d4 'T'
beae:    d2 'R'
beaf:    c9 'I'
beb0:    ce 'N'
beb1:    c7 'G'
beb2:    8d

R_beb3:
beb3:    00
beb4:    0c
beb5:    c5 'E'
beb6:    c3 'C'
beb7:    ba ':'

R_beb8:
beb8:    d8                     ld B, [A]
beb9:    d8                     ld B, [A]
beba:    a0 c3                  st AL, 0xc3
bebc:    cd                     ld BL, [S]
bebd:    c4 d3                  ld BL, @[0xbe92]
bebf:    ba                     st A, [X]
bec0:    a0 00                  st AL, 0x00

L_bec2:
bec2:    03                     rf

R_bec3:
bec3:    d8                     ld B, [A]
bec4:    d8                     ld B, [A]
bec5:    a0 00                  st AL, 0x00
bec7:    12 c4                  bn R_be7e+15
bec9:    cd                     ld BL, [S]
beca:    c1 a0 ce               ld BL, [0xa0ce]
becd:    cf                     ld BL, [P]
bece:    d4 a0                  ld B, @[R_be5c+20|0xbe70]
bed0:    c3 cf                  ld BL, [0xbea1]
bed2:    cd                     ld BL, [S]
bed3:    d0 cc c5               ld B, 0xccc5
bed6:    d4 c5                  ld B, @[0xbe9d]
bed8:    c4 8d                  ld BL, @[R_be5c+11|0xbe67]

R_beda:
beda:    00                     HALT
bedb:    0c                     unknown_0c
bedc:    c4 cd                  ld BL, @[0xbeab]
bede:    c1 a0 c6               ld BL, [0xa0c6]
bee1:    c1 c9 cc               ld BL, [0xc9cc]
bee4:    d5 d2                  ld B, [--C]
bee6:    c5 8d 00               ld BL, @[Z++ + 0x00]
bee9:    10 d7                  bc L_bec2
beeb:    c4 c3                  ld BL, @[0xbeb0]
beed:    a0 c9                  st AL, 0xc9
beef:    af                     st AL, [P]
bef0:    cf                     ld BL, [P]
bef1:    a0 c6                  st AL, 0xc6
bef3:    c1 c9 cc               ld BL, [0xc9cc]
bef6:    d5 d2                  ld B, [--C]
bef8:    c5 8d 00               ld BL, @[Z++ + 0x00]
befb:    0c                     unknown_0c
befc:    d2 d4 da               ld B, @[0xd4da]
beff:    a0 c6                  st AL, 0xc6
bf01:    c1 c9 cc               ld BL, [0xc9cc]
bf04:    d5 d2                  ld B, [--C]
bf06:    c5 'E'
bf07:    8d

Unk40DeviceObj:
bf08:    00 06                  (0x6)
bf0a:    ce 9e                  DiskDevice_Abort
bf0c:    cd f3                  DiskDevice_Read
bf0e:    ce 23                  DiskDevice_Write
bf10:    bf 1a                  R_bf1a
bf12:    c0 cc                  R_c0cc
bf14:    c1 1d                  R_c11d
bf16:    c1 32                  R_c132
bf18:    cd 74                  DiskDevice_BlockIO_Special

R_bf1a:
bf1a:    7f 01                  pop {A}
bf1c:    b1 c0 54               st A, [R_c054|0xc054]
bf1f:    85 a8 06               ld AL, [S + 0x06]
bf22:    a1 c0 61               st AL, [R_c061|0xc061]
bf25:    55 80                  mov A, Z
bf27:    b5 a2                  st A, [--S]

R_bf29:
bf29:    90 c0 67               ld A, R_c067|0xc067
bf2c:    5e                     mov Z, A
bf2d:    95 a8 04               ld A, [S + 0x04]
bf30:    b1 c0 09               st A, [R_c009|0xc009]
bf33:    3a                     clr A, #0
bf34:    b1 bf ed               st A, [R_bfed|0xbfed]
bf37:    85 a8 02               ld AL, [S + 0x02]
bf3a:    14 13                  bz L_bf4f
bf3c:    c0 8a                  ld BL, 0x8a
bf3e:    29                     dec AL, #1
bf3f:    14 02                  bz L_bf43
bf41:    c0 8b                  ld BL, 0x8b

L_bf43:
bf43:    e5 81                  st BL, [Z++]
bf45:    e0 00                  st BL, 0x00
bf47:    95 a8 0b               ld A, [S + 0x0b]
bf4a:    15 03                  bnz L_bf4f
bf4c:    71 c0 3c               jmp R_c03c

L_bf4f:
bf4f:    90 ff ff               ld A, 0xffff
bf52:    b1 c0 65               st A, [R_c065|0xc065]

R_bf55:
bf55:    95 a8 06               ld A, [S + 0x06]
bf58:    d5 a8 09               ld B, [S + 0x09]
bf5b:    79 cd 33               call R_cd33
bf5e:    79 cc e8               call R_cce8
bf61:    a1 c6 3d               st AL, [R_c63d|0xc63d]
bf64:    f1 c6 3e               st B, [R_c63e|0xc63e]
bf67:    90 c6 3c               ld A, R_c63c|0xc63c
bf6a:    46 02 7c 1d c6 3d      unkbig7(0, 2) 0x1d, [R_c63d|0xc63d]
bf70:    81 c6 3c               ld AL, [R_c63c|0xc63c]
bf73:    a5 81                  st AL, [Z++]
bf75:    d1 c6 3e               ld B, [R_c63e|0xc63e]
bf78:    79 c2 8f               call R_c28f
bf7b:    95 68 11               ld A, [Y + 0x11]
bf7e:    f5 a2                  st B, [--S]
bf80:    5d                     mov B, A
bf81:    78 32 04 46            mul B, B, 0x0446
bf85:    77 32 02 5d            div B, B, 0x025d
bf89:    55 20                  mov A, B
bf8b:    30 01                  inc A, #2
bf8d:    d5 a1                  ld B, [S++]
bf8f:    51 20                  sub A, B
bf91:    11 04                  bnc L_bf97
bf93:    c0 05                  ld BL, 0x05
bf95:    66 6b                  jsys 0x6b

L_bf97:
bf97:    78 21 c2 8d            mul A, B, [R_c28d|0xc28d]
bf9b:    f5 a2                  st B, [--S]
bf9d:    30 10 c0 65            inc [R_c065|0xc065], #1
bfa1:    15 07                  bnz L_bfaa
bfa3:    a1 c0 63               st AL, [R_c062+1|0xc063]
bfa6:    d5 a1                  ld B, [S++]
bfa8:    73 17                  jmp L_bfc1

L_bfaa:
bfaa:    31 10 c0 65            dec [R_c065|0xc065], #1
bfae:    c1 c0 63               ld BL, [R_c062+1|0xc063]
bfb1:    49                     sub BL, AL
bfb2:    14 04                  bz L_bfb8
bfb4:    30 a1                  inc S, #2
bfb6:    73 4a                  jmp L_c002

L_bfb8:
bfb8:    d5 a1                  ld B, [S++]
bfba:    91 c0 65               ld A, [R_c065|0xc065]
bfbd:    51 20                  sub A, B
bfbf:    15 41                  bnz L_c002

L_bfc1:
bfc1:    f1 c0 65               st B, [R_c065|0xc065]
bfc4:    85 a8 02               ld AL, [S + 0x02]
bfc7:    14 39                  bz L_c002
bfc9:    d5 a8 0b               ld B, [S + 0x0b]
bfcc:    30 b0 00 06            inc [S + 0x0006], #1
bfd0:    90 01 90               ld A, 0x0190
bfd3:    59                     sub B, A
bfd4:    11 03                  bnc L_bfd9
bfd6:    95 a8 0b               ld A, [S + 0x0b]

L_bfd9:
bfd9:    c5 a8 02               ld BL, [S + 0x02]
bfdc:    21 31                  dec BL, #2
bfde:    15 03                  bnz L_bfe3
bfe0:    90 01 90               ld A, 0x0190

L_bfe3:
bfe3:    b5 81                  st A, [Z++]
bfe5:    d5 a8 04               ld B, [S + 0x04]
bfe8:    58                     add B, A
bfe9:    f5 a8 04               st B, [S + 0x04]
bfec:    d0 00 00               ld B, 0x0000
bfef:    58                     add B, A
bff0:    f3 fb                  st B, [R_bfed|0xbfed]
bff2:    d5 a8 0b               ld B, [S + 0x0b]
bff5:    51 20                  sub A, B
bff7:    17 01                  bp L_bffa
bff9:    3a                     clr A, #0

L_bffa:
bffa:    b5 a8 0b               st A, [S + 0x0b]
bffd:    14 05                  bz L_c004
bfff:    71 bf 55               jmp R_bf55

L_c002:
c002:    31 80                  dec Z, #1

L_c004:
c004:    80 ff                  ld AL, 0xff
c006:    a5 81                  st AL, [Z++]
c008:    90 00 00               ld A, 0x0000
c00b:    b5 81                  st A, [Z++]
c00d:    93 de                  ld A, [R_bfed|0xbfed]
c00f:    bc                     st A, [Z]
c010:    90 c0 62               ld A, R_c062|0xc062
c013:    51 80                  sub A, Z
c015:    a3 48                  st AL, [R_c05f|0xc05f]
c017:    85 a8 03               ld AL, [S + 0x03]
c01a:    a1 c1 6e               st AL, [R_c16e|0xc16e]

L_c01d:
c01d:    79 c1 6c               call R_c16c
c020:    c0 5f                  ld BL, 0x5f
c022:    4d                     mov BL, AL
c023:    15 17                  bnz R_c03c
c025:    85 a8 02               ld AL, [S + 0x02]
c028:    14 12                  bz R_c03c
c02a:    83 3b                  ld AL, [R_c067|0xc067]
c02c:    c0 8b                  ld BL, 0x8b
c02e:    49                     sub BL, AL
c02f:    14 03                  bz L_c034
c031:    71 bf 29               jmp R_bf29

L_c034:
c034:    80 8c                  ld AL, 0x8c
c036:    a3 2f                  st AL, [R_c067|0xc067]
c038:    31 82                  dec Z, #3
c03a:    73 e1                  jmp L_c01d

R_c03c:
c03c:    a3 1f                  st AL, [0xc05d]
c03e:    95 a1                  ld A, [S++]
c040:    5e                     mov Z, A
c041:    d5 a8 04               ld B, [S + 0x04]
c044:    31 20                  dec B, #1
c046:    90 00 0b               ld A, 0x000b
c049:    50 0a                  add S, A
c04b:    95 a1                  ld A, [S++]
c04d:    5c                     mov Y, A
c04e:    80 ff                  ld AL, 0xff
c050:    a1 01 1f               st AL, [0x011f]
c053:    90 00 00               ld A, 0x0000
c056:    7e 01                  push {A}
c058:    d1 c3 ce               ld B, [R_c3ce|0xc3ce]
c05b:    90 00 00               ld A, 0x0000
c05e:    09                     ret

R_c05f:
c05f:    00
c060:    81

R_c061:
c061:    00

R_c062:
c062:    84 00                  ld AL, @[0xc064]
c064:    83 00                  ld AL, [0xc066]
c066:    <null bytes>


R_c067:
c067:    <null bytes>


R_c0c3:
c0c3:    08                     cl

R_c0c4:
c0c4:    81 00 84               ld AL, [0x0084]

R_c0c7:
c0c7:    00                     HALT
c0c8:    83 00                  ld AL, [0xc0ca]
c0ca:    00                     HALT
c0cb:    ff                     st B, [P]

R_c0cc:
c0cc:    6d a2                  st X, [--S]
c0ce:    7e 09                  push {A, B, X, Y, Z}
c0d0:    79 c4 5b               call R_c45b
c0d3:    7f 09                  pop {A, B, X, Y, Z}
c0d5:    65 68 0f               ld X, [Y + 0x0f]
c0d8:    f6 14 00               mov AL, Device[X + 0x00]
c0db:    79 c2 9d               call R_c29d
c0de:    ff                     st B, [P]
c0df:    79 c2 b3               call R_c2b3
c0e2:    00                     HALT
c0e3:    83 fd                  ld AL, [0xc0e2]
c0e5:    c0 12                  ld BL, 0x12
c0e7:    41 31                  sub AL, BL
c0e9:    14 04                  bz L_c0ef
c0eb:    32 20                  clr B, #0
c0ed:    73 28                  jmp L_c117

L_c0ef:
c0ef:    79 c2 9d               call R_c29d
c0f2:    52 79 c2 c6            and Z, [Y + R_c2c6|0xc2c6], Z
c0f6:    01                     nop
c0f7:    f6 34 00               mov BL, Device[X + 0x00]
c0fa:    f5 a2                  st B, [--S]
c0fc:    79 c2 c6               call R_c2c6
c0ff:    01                     nop
c100:    f6 34 00               mov BL, Device[X + 0x00]
c103:    d5 a1                  ld B, [S++]
c105:    85 68 13               ld AL, [Y + 0x13]
c108:    4a                     and BL, AL
c109:    14 08                  bz R_c113
c10b:    79 c2 37               call R_c237
c10e:    d0 00 ff               ld B, 0x00ff
c111:    73 04                  jmp L_c117

R_c113:
c113:    32 20                  clr B, #0
c115:    73 00                  jmp L_c117

L_c117:
c117:    79 c3 0d               call R_c30d
c11a:    65 a1                  ld X, [S++]
c11c:    09                     ret

R_c11d:
c11d:    7e 09                  push {A, B, X, Y, Z}
c11f:    79 c4 5b               call R_c45b
c122:    7f 09                  pop {A, B, X, Y, Z}
c124:    95 68 0f               ld A, [Y + 0x0f]
c127:    f6 11 01               mov Device[A + 0x01], AL
c12a:    79 c2 ea               call R_c2ea
c12d:    08                     cl
c12e:    79 c3 0d               call R_c30d
c131:    09                     ret

R_c132:
c132:    7e 45                  push {X, Y, Z}
c134:    d6 89 c1 5d            st Z, [R_c15d|0xc15d]
c138:    7e 09                  push {A, B, X, Y, Z}
c13a:    79 c4 5b               call R_c45b
c13d:    7f 09                  pop {A, B, X, Y, Z}
c13f:    85 68 13               ld AL, [Y + 0x13]
c142:    a5 88 02               st AL, [Z + 0x02]
c145:    95 88 06               ld A, [Z + 0x06]
c148:    b5 a2                  st A, [--S]
c14a:    79 c2 8f               call R_c28f
c14d:    78 01 c2 8d            mul A, A, [R_c28d|0xc28d]
c151:    f5 88 06               st B, [Z + 0x06]
c154:    a5 88 04               st AL, [Z + 0x04]
c157:    80 01                  ld AL, 0x01
c159:    a3 13                  st AL, [R_c16e|0xc16e]
c15b:    7b 0f                  call R_c16c

R_c15d:
c15d:    00                     HALT
c15e:    00                     HALT
c15f:    79 c3 0d               call R_c30d
c162:    d5 a1                  ld B, [S++]
c164:    f5 88 06               st B, [Z + 0x06]
c167:    45 11                  mov AL, AL
c169:    7f 45                  pop {X, Y, Z}
c16b:    09                     ret

R_c16c:
c16c:    3a                     clr A, #0
c16d:    c0 00                  ld BL, 0x00
c16f:    15 03                  bnz L_c174
c171:    90 00 0d               ld A, 0x000d

L_c174:
c174:    b1 c3 e0               st A, [R_c3e0|0xc3e0]
c177:    7e 45                  push {X, Y, Z}
c179:    55 a0                  mov A, S
c17b:    b1 c1 d9               st A, [R_c1d8+1|0xc1d9]
c17e:    95 68 0f               ld A, [Y + 0x0f]
c181:    5e                     mov Z, A
c182:    79 c2 21               call R_c221

R_c185:
c185:    65 a4                  ld X, @[S]
c187:    69 c3 a2               st X, [R_c3a2|0xc3a2]
c18a:    d5 48 06               ld B, [X + 0x06]
c18d:    77 32 00 1d            div B, B, 0x001d
c191:    3a                     clr A, #0
c192:    85 48 09               ld AL, [X + 0x09]
c195:    58                     add B, A
c196:    f1 c3 ce               st B, [R_c3ce|0xc3ce]
c199:    3a                     clr A, #0
c19a:    85 41                  ld AL, [X++]
c19c:    14 3a                  bz R_c1d8
c19e:    c5 68 02               ld BL, [Y + 0x02]
c1a1:    e1 c3 cc               st BL, [R_c3cc|0xc3cc]
c1a4:    55 42                  mov B, X
c1a6:    50 04                  add X, A
c1a8:    79 c4 64               call R_c464
c1ab:    79 c2 9d               call R_c29d
c1ae:    43 79                  or ZL, YL
c1b0:    c2 b3 00               ld BL, @[0xb300]
c1b3:    83 fd                  ld AL, [0xc1b2]
c1b5:    14 05                  bz L_c1bc
c1b7:    79 c4 8f               call R_c48f
c1ba:    c4 df                  ld BL, @[0xc19b]

L_c1bc:
c1bc:    79 c4 75               call R_c475
c1bf:    d5 41                  ld B, [X++]
c1c1:    9a                     ld A, [X]
c1c2:    79 c4 64               call R_c464
c1c5:    79 c2 9d               call R_c29d
c1c8:    45 79                  mov ZL, YL
c1ca:    c2 b3 00               ld BL, @[0xb300]
c1cd:    83 fd                  ld AL, [0xc1cc]
c1cf:    14 03                  bz L_c1d4
c1d1:    71 c3 14               jmp R_c314

L_c1d4:
c1d4:    79 c4 75               call R_c475
c1d7:    2a                     clr AL, #0

R_c1d8:
c1d8:    60 00 00               ld X, 0x0000
c1db:    55 4a                  mov S, X
c1dd:    7f 45                  pop {X, Y, Z}
c1df:    d1 c3 ce               ld B, [R_c3ce|0xc3ce]
c1e2:    30 41                  inc X, #2
c1e4:    09                     ret

R_c1e5:
c1e5:    81 c0 61               ld AL, [R_c061|0xc061]
c1e8:    a1 c2 1c               st AL, [R_c21c|0xc21c]
c1eb:    81 c0 63               ld AL, [R_c062+1|0xc063]
c1ee:    a1 c2 1e               st AL, [R_c21e|0xc21e]
c1f1:    d0 c2 1a               ld B, R_c21a|0xc21a
c1f4:    3a                     clr A, #0
c1f5:    81 c2 1a               ld AL, [R_c21a|0xc21a]
c1f8:    38                     inc A, #1
c1f9:    79 c4 64               call R_c464
c1fc:    79 c2 9d               call R_c29d
c1ff:    43 79                  or ZL, YL
c201:    c2 b3 00               ld BL, @[0xb300]
c204:    83 fd                  ld AL, [0xc203]
c206:    15 0c                  bnz L_c214
c208:    79 c2 9d               call R_c29d
c20b:    45 79                  mov ZL, YL
c20d:    c2 b3 00               ld BL, @[0xb300]
c210:    79 c4 75               call R_c475
c213:    09                     ret

L_c214:
c214:    79 c4 8f               call R_c48f
c217:    c5 98 09               ld BL, [Z + 0x09]

R_c21a:
c21a:    06                     sl
c21b:    81 00 84               ld AL, [0x0084]

R_c21e:
c21e:    00                     HALT
c21f:    82
c220:    ff

R_c221:
c221:    7e 03                  push {A, B}
c223:    91 01 03               ld A, [CurrentProcess|0x0103]
c226:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
c22b:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
c230:    c0 02                  ld BL, 0x02
c232:    2f 28                  ld_isr B
c234:    7f 03                  pop {A, B}
c236:    09                     ret

R_c237:
c237:    7e 09                  push {A, B, X, Y, Z}
c239:    79 c2 21               call R_c221
c23c:    90 c0 c3               ld A, R_c0c3|0xc0c3
c23f:    b1 c3 a2               st A, [R_c3a2|0xc3a2]
c242:    85 68 13               ld AL, [Y + 0x13]
c245:    a1 c0 c5               st AL, [R_c0c4+1|0xc0c5]
c248:    32 18 c2 8d            clr [R_c28d|0xc28d], #8

L_c24c:
c24c:    31 10 c2 8d            dec [R_c28d|0xc28d], #1
c250:    93 3b                  ld A, [R_c28d|0xc28d]
c252:    a1 c0 c7               st AL, [R_c0c7|0xc0c7]
c255:    3a                     clr A, #0
c256:    81 c0 c3               ld AL, [R_c0c3|0xc0c3]
c259:    d0 c0 c4               ld B, R_c0c4|0xc0c4
c25c:    79 c4 64               call R_c464
c25f:    79 c2 9d               call R_c29d
c262:    43 79                  or ZL, YL
c264:    c2 9d 45               ld BL, @[0x9d45]
c267:    79 c2 b3               call R_c2b3
c26a:    00                     HALT
c26b:    83 fd                  ld AL, [0xc26a]
c26d:    14 05                  bz L_c274
c26f:    c0 19                  ld BL, 0x19
c271:    49                     sub BL, AL
c272:    14 d8                  bz L_c24c

L_c274:
c274:    30 10 c2 8d            inc [R_c28d|0xc28d], #1
c278:    d3 13                  ld B, [R_c28d|0xc28d]
c27a:    77 32 04 46            div B, B, 0x0446
c27e:    f5 68 11               st B, [Y + 0x11]
c281:    d3 0a                  ld B, [R_c28d|0xc28d]
c283:    77 32 00 14            div B, B, 0x0014
c287:    e5 68 16               st BL, [Y + 0x16]
c28a:    7f 09                  pop {A, B, X, Y, Z}
c28c:    09                     ret

R_c28d:
c28d:    00
c28e:    00

R_c28f:
c28f:    f5 a2                  st B, [--S]
c291:    d5 68 11               ld B, [Y + 0x11]
c294:    78 32 04 46            mul B, B, 0x0446
c298:    f3 f3                  st B, [R_c28d|0xc28d]
c29a:    d5 a1                  ld B, [S++]
c29c:    09                     ret

R_c29d:
c29d:    7e 03                  push {A, B}
c29f:    7b 49                  call R_c2ea
c2a1:    08                     cl
c2a2:    7b 46                  call R_c2ea
c2a4:    02                     sf
c2a5:    95 68 0f               ld A, [Y + 0x0f]
c2a8:    c5 41                  ld BL, [X++]
c2aa:    f6 31 00               mov Device[A + 0x00], BL
c2ad:    7b 3b                  call R_c2ea
c2af:    02                     sf
c2b0:    7f 03                  pop {A, B}
c2b2:    09                     ret

R_c2b3:
c2b3:    7e 03                  push {A, B}
c2b5:    7b 33                  call R_c2ea
c2b7:    08                     cl
c2b8:    7b 0c                  call R_c2c6
c2ba:    01                     nop
c2bb:    95 68 0f               ld A, [Y + 0x0f]
c2be:    f6 30 00               mov BL, Device[A + 0x00]
c2c1:    e5 41                  st BL, [X++]
c2c3:    7f 03                  pop {A, B}
c2c5:    09                     ret

R_c2c6:
c2c6:    85 41                  ld AL, [X++]
c2c8:    a5 a2                  st AL, [--S]
c2ca:    79 ce 2a               call SetTimeout8

L_c2cd:
c2cd:    d5 68 0f               ld B, [Y + 0x0f]
c2d0:    f6 32 01               mov BL, Device[B + 0x01]
c2d3:    8d                     ld AL, [S]
c2d4:    4a                     and BL, AL
c2d5:    49                     sub BL, AL
c2d6:    14 0c                  bz L_c2e4
c2d8:    79 ce 33               call CheckTimeout
c2db:    14 f0                  bz L_c2cd
c2dd:    85 a1                  ld AL, [S++]
c2df:    79 c4 8f               call R_c48f
c2e2:    c4 fa                  ld BL, @[0xc2de]

L_c2e4:
c2e4:    85 a1                  ld AL, [S++]
c2e6:    79 ce 41               call SetTimeout256
c2e9:    09                     ret

R_c2ea:
c2ea:    85 41                  ld AL, [X++]
c2ec:    a5 a2                  st AL, [--S]
c2ee:    79 ce 2a               call SetTimeout8

L_c2f1:
c2f1:    d5 68 0f               ld B, [Y + 0x0f]
c2f4:    f6 32 01               mov BL, Device[B + 0x01]
c2f7:    8d                     ld AL, [S]
c2f8:    4a                     and BL, AL
c2f9:    14 0c                  bz L_c307
c2fb:    79 ce 33               call CheckTimeout
c2fe:    14 f1                  bz L_c2f1
c300:    85 a1                  ld AL, [S++]
c302:    79 c4 8f               call R_c48f
c305:    c4 fa                  ld BL, @[0xc301]

L_c307:
c307:    85 a1                  ld AL, [S++]
c309:    79 ce 41               call SetTimeout256
c30c:    09                     ret

R_c30d:
c30d:    47 4c 00 ff 01 1f      memcpy 0x01, 0xff, [0x011f]
c313:    09                     ret

R_c314:
c314:    a3 0e                  st AL, [R_c324|0xc324]
c316:    c0 11                  ld BL, 0x11
c318:    49                     sub BL, AL
c319:    22 20                  clr BH, #0
c31b:    35 20                  sll B, #1
c31d:    90 c3 25               ld A, Unk40jumptable|0xc325
c320:    58                     add B, A
c321:    99                     ld A, [B]
c322:    75 00                  jmp [A]

R_c324:
c324:    00

Unk40jumptable:
c325:    c3 ff                  R_c3ff
c327:    c4 03                  R_c403
c329:    c4 03                  R_c403
c32b:    c4 03                  R_c403
c32d:    c3 f7                  R_c3f7
c32f:    c3 fb                  R_c3fb
c331:    c4 07                  R_c407
c333:    c4 0b                  R_c40b
c335:    c4 0f                  R_c40f
c337:    c4 13                  R_c413
c339:    c3 f7                  R_c3f7
c33b:    c3 f7                  R_c3f7
c33d:    c4 17                  R_c417
c33f:    c3 fb                  R_c3fb
c341:    c3 fb                  R_c3fb
c343:    c3 fb                  R_c3fb
c345:    c3 f7                  R_c3f7
c347:    c3 f7                  R_c3f7
c349:    c4 2b                  R_c42b
c34b:    c4 32                  R_c432
c34d:    c3 fb                  R_c3fb
c34f:    c3 fb                  R_c3fb
c351:    c3 fb                  R_c3fb
c353:    c3 fb                  R_c3fb
c355:    c3 fb                  R_c3fb
c357:    c3 fb                  R_c3fb
c359:    c3 fb                  R_c3fb
c35b:    c3 fb                  R_c3fb
c35d:    c3 fb                  R_c3fb
c35f:    c3 fb                  R_c3fb
c361:    c3 fb                  R_c3fb
c363:    c3 fb                  R_c3fb
c365:    c3 f7                  R_c3f7
c367:    c3 f7                  R_c3f7
c369:    c4 32                  R_c432
c36b:    c4 32                  R_c432
c36d:    c4 32                  R_c432
c36f:    c4 2b                  R_c42b
c371:    c3 fb                  R_c3fb
c373:    c4 2b                  R_c42b
c375:    c4 2b                  R_c42b
c377:    c4 2b                  R_c42b
c379:    c4 2b                  R_c42b
c37b:    c4 32                  R_c432
c37d:    c3 fb                  R_c3fb
c37f:    c3 fb                  R_c3fb
c381:    c3 fb                  R_c3fb
c383:    c3 fb                  R_c3fb
c385:    c4 17                  R_c417
c387:    c3 fb                  R_c3fb

R_c389:
c389:    7c 12                  call R_a550 (via 0xc39c+1)
c38b:    c4 bf                  ld BL, @[0xc34c]
c38d:    7c 0e                  call R_a550 (via 0xc39c+1)

R_c38f:
c38f:    00                     HALT
c390:    00                     HALT
c391:    32 02                  clr A, #2
c393:    c0 b0                  ld BL, 0xb0
c395:    46 e0 90 c5 56 c3 24   baseconv(e, 0) [R_c551+5|0xc556], [R_c324|0xc324]
c39c:    79 a5 50               call R_a550
c39f:    c5 51                  ld BL, [X++]
c3a1:    90 c0 5f               ld A, R_c05f|0xc05f
c3a4:    5c                     mov Y, A
c3a5:    3a                     clr A, #0
c3a6:    8b                     ld AL, [Y]
c3a7:    38                     inc A, #1
c3a8:    5b                     mov X, A

L_c3a9:
c3a9:    90 c0 c0               ld A, 0xc0c0
c3ac:    b1 c5 61               st A, [R_c55f+2|0xc561]
c3af:    80 02                  ld AL, 0x02
c3b1:    46 e0 92 c5 61 06      baseconv(e, 0) [R_c55f+2|0xc561], [Y]
c3b7:    30 60                  inc Y, #1
c3b9:    7c e2                  call R_a550 (via 0xc39c+1)
c3bb:    c5                     unknown
c3bc:    5f                     mov S, A
c3bd:    3f                     dec X
c3be:    18 e9                  bgt L_c3a9
c3c0:    7c db                  call R_a550 (via 0xc39c+1)
c3c2:    c4 bf                  ld BL, @[0xc383]
c3c4:    47 4c 00 ff 01 1f      memcpy 0x01, 0xff, [0x011f]
c3ca:    90 00 00               ld A, 0x0000
c3cd:    d0 00 00               ld B, 0x0000
c3d0:    c0 0d                  ld BL, 0x0d
c3d2:    66 6b                  jsys 0x6b

R_c3d4:
c3d4:    31 10 c3 e0            dec [R_c3e0|0xc3e0], #1
c3d8:    16 05                  blt L_c3df
c3da:    30 a1                  inc S, #2
c3dc:    71 c1 85               jmp R_c185

L_c3df:
c3df:    09                     ret

R_c3e0:
c3e0:    00
c3e1:    00

L_c3e2:
c3e2:    90 c0 c0               ld A, 0xc0c0
c3e5:    b1 c5 56               st A, [R_c551+5|0xc556]
c3e8:    95 41                  ld A, [X++]
c3ea:    b3 a3                  st A, [R_c38f|0xc38f]
c3ec:    81 c3 24               ld AL, [R_c324|0xc324]
c3ef:    c1 c1 6e               ld BL, [R_c16e|0xc16e]
c3f2:    14 95                  bz R_c389
c3f4:    71 c1 d8               jmp R_c1d8

R_c3f7:
c3f7:    7b e9                  call L_c3e2
c3f9:    c5 a6                  ld BL, @[--S]

R_c3fb:
c3fb:    7b e5                  call L_c3e2
c3fd:    c5 b8 7b               ld BL, [S + 0x7b]
c400:    e1 c4 df               st BL, [R_c4df|0xc4df]

R_c403:
c403:    7b dd                  call L_c3e2
c405:    c5 2c 7b               ld BL, @[B + 0x7b]
c408:    d9                     ld B, [B]
c409:    c5 ce 7b               ld BL, @[--C + 0x7b]
c40c:    d5 c5                  ld B, @[C++]
c40e:    e4 7b                  st BL, @[L_c48b|0xc48b]
c410:    d1 c5 f6               ld B, [R_c5f6|0xc5f6]

R_c413:
c413:    7b cd                  call L_c3e2
c415:    c6                     acquire_semaphore
c416:    0c                     unknown_0c

R_c417:
c417:    47 44 05 60 07 c4 b8   memcpy 0x06, [Y + 0x07], [R_c4b2+6|0xc4b8]
c41e:    79 a5 50               call R_a550
c421:    c4 b2                  ld BL, @[R_c3d4+1|0xc3d5]
c423:    79 c4 4e               call R_c44e
c426:    79 c3 d4               call R_c3d4
c429:    73 ec                  jmp R_c417

R_c42b:
c42b:    79 c3 d4               call R_c3d4
c42e:    7b b2                  call L_c3e2
c430:    c5 1c 79               ld BL, @[A + 0x79]
c433:    c4 3f                  ld BL, @[0xc474]
c435:    79 c1 e5               call R_c1e5
c438:    79 c3 d4               call R_c3d4
c43b:    7b a5                  call L_c3e2
c43d:    c5 86                  ld BL, @[--Z]

R_c43f:
c43f:    7e 09                  push {A, B, X, Y, Z}
c441:    95 68 0f               ld A, [Y + 0x0f]
c444:    f6 11 01               mov Device[A + 0x01], AL
c447:    79 c2 ea               call R_c2ea
c44a:    08                     cl
c44b:    7f 09                  pop {A, B, X, Y, Z}
c44d:    09                     ret

R_c44e:
c44e:    7e 09                  push {A, B, X, Y, Z}
c450:    60 13 88               ld X, 0x1388

L_c453:
c453:    66 07                  jsys Syscall_Yield
c455:    3f                     dec X
c456:    15 fb                  bnz L_c453
c458:    7f 09                  pop {A, B, X, Y, Z}
c45a:    09                     ret

R_c45b:
c45b:    80 1f                  ld AL, 0x1f
c45d:    66 12                  jsys Syscall_12
c45f:    d6 67 01 3f            st Y, [ActiveDiskDevice|0x013f]
c463:    09                     ret

R_c464:
c464:    2f 34                  dma_mode #3
c466:    2f 20                  ld_dma_addr B
c468:    3b                     not A, #0
c469:    2f 02                  ld_dma_count A
c46b:    2f 06                  enable_dma
c46d:    59                     sub B, A
c46e:    f0 00 00               st B, 0x0000
c471:    3a                     clr A, #0
c472:    d7 12                  mov IL1(B), A
c474:    09                     ret

R_c475:
c475:    2f 07                  disable_dma
c477:    2f 03                  st_dma_count A
c479:    38                     inc A, #1
c47a:    14 04                  bz L_c480
c47c:    7b 11                  call R_c48f
c47e:    c5 64                  ld BL, @[Y]

L_c480:
c480:    2f 03                  st_dma_count A
c482:    2f 21                  st_dma_addr B
c484:    59                     sub B, A
c485:    93 e8                  ld A, [0xc46f]
c487:    59                     sub B, A
c488:    15 01                  bnz L_c48b
c48a:    09                     ret

L_c48b:
c48b:    7b 02                  call R_c48f
c48d:    c5 'E'
c48e:    78

R_c48f:
c48f:    d5 68 0f               ld B, [Y + 0x0f]
c492:    f6 33 01               mov Device[B + 0x01], BL
c495:    c1 c1 6e               ld BL, [R_c16e|0xc16e]
c498:    17 05                  bp L_c49f
c49a:    30 a3                  inc S, #4
c49c:    71 c1 13               jmp R_c113

L_c49f:
c49f:    14 03                  bz L_c4a4
c4a1:    71 c1 d8               jmp R_c1d8

L_c4a4:
c4a4:    95 41                  ld A, [X++]
c4a6:    b1 c3 8f               st A, [R_c38f|0xc38f]
c4a9:    90 c0 c0               ld A, 0xc0c0
c4ac:    b1 c5 56               st A, [R_c551+5|0xc556]
c4af:    71 c3 89               jmp R_c389

R_c4b2:
c4b2:    11, "\x07NR XXXXXX\r"

R_c4bf:
c4bf:    00
c4c0:    01
c4c1:    8d
c4c2:    27, "FNC CONTROL SIGNAL FAILURE\r"

R_c4df:
c4df:    25, "FNC COMMAND LOAD FAILURE\r"

R_c4fa:
c4fa:    23, "FNC CONTROL SIGNAL LAG\r"
c513:    7, "\x07ID NN\r"

R_c51c:
c51c:    14, "FNC I/O ERROR\r"

R_c52c:
c52c:    35, "FNC ERROR - ILLEGAL COMMAND STRING\r"

R_c551:
c551:    12, "EC:@@ CMDS: "

R_c55f:
c55f:    3, "XX "

R_c564:
c564:    18, "DMA NOT COMPLETED\r"

R_c578:
c578:    12, "DMA FAILURE\r"

R_c586:
c586:    16, "FNC I/O FAILURE\r"

R_c598:
c598:    12, "RTZ FAILURE\r"

R_c5a6:
c5a6:    16, "UNDEFINED ERROR\r"

R_c5b8:
c5b8:    20, "UNDOCUMENTED ERROR\x07\r"

R_c5ce:
c5ce:    20, "ILLEGAL UNIT SELECT\r"

R_c5e4:
c5e4:    16, "ILLEGAL TRACK #\r"

R_c5f6:
c5f6:    20, "INVALID HEAD SELECT\r"

R_c60c:
c60c:    22, "AUX BUFFER ADDR ERROR\r"
c624:    22, "SECTOR ACCESS TIMEOUT\r"

R_c63c:
c63c:    00

R_c63d:
c63d:    00

R_c63e:
c63e:    00
c63f:    00

Unk50DeviceObj:
c640:    00 06                  (0x6)
c642:    ce 9e                  DiskDevice_Abort
c644:    cd f3                  DiskDevice_Read
c646:    ce 23                  DiskDevice_Write
c648:    c6 52                  R_c652
c64a:    c7 ec                  R_c7ec
c64c:    c8 3d                  R_c83d
c64e:    c8 52                  R_c852
c650:    cd 74                  DiskDevice_BlockIO_Special

R_c652:
c652:    7f 01                  pop {A}
c654:    b1 c7 8c               st A, [R_c78c|0xc78c]
c657:    85 a8 06               ld AL, [S + 0x06]
c65a:    a1 c7 99               st AL, [R_c799|0xc799]
c65d:    55 80                  mov A, Z
c65f:    b5 a2                  st A, [--S]

R_c661:
c661:    90 c7 9f               ld A, R_c79f|0xc79f
c664:    5e                     mov Z, A
c665:    95 a8 04               ld A, [S + 0x04]
c668:    b1 c7 41               st A, [R_c741|0xc741]
c66b:    3a                     clr A, #0
c66c:    b1 c7 25               st A, [R_c725|0xc725]
c66f:    85 a8 02               ld AL, [S + 0x02]
c672:    14 13                  bz L_c687
c674:    c0 8a                  ld BL, 0x8a
c676:    29                     dec AL, #1
c677:    14 02                  bz L_c67b
c679:    c0 8b                  ld BL, 0x8b

L_c67b:
c67b:    e5 81                  st BL, [Z++]
c67d:    e0 00                  st BL, 0x00
c67f:    95 a8 0b               ld A, [S + 0x0b]
c682:    15 03                  bnz L_c687
c684:    71 c7 74               jmp R_c774

L_c687:
c687:    90 ff ff               ld A, 0xffff
c68a:    b1 c7 9d               st A, [R_c79d|0xc79d]

R_c68d:
c68d:    95 a8 06               ld A, [S + 0x06]
c690:    d5 a8 09               ld B, [S + 0x09]
c693:    79 cd 33               call R_cd33
c696:    79 cc e8               call R_cce8
c699:    a1 cc e5               st AL, [R_cce5|0xcce5]
c69c:    f1 cc e6               st B, [R_cce6|0xcce6]
c69f:    90 cc e4               ld A, R_cce4|0xcce4
c6a2:    46 02 7c 15 cc e5      unkbig7(0, 2) 0x15, [R_cce5|0xcce5]
c6a8:    81 cc e4               ld AL, [R_cce4|0xcce4]
c6ab:    a5 81                  st AL, [Z++]
c6ad:    d1 cc e6               ld B, [R_cce6|0xcce6]
c6b0:    79 c9 73               call R_c973
c6b3:    95 68 11               ld A, [Y + 0x11]
c6b6:    f5 a2                  st B, [--S]
c6b8:    5d                     mov B, A
c6b9:    78 32 03 90            mul B, B, 0x0390
c6bd:    77 32 02 b9            div B, B, 0x02b9
c6c1:    55 20                  mov A, B
c6c3:    30 01                  inc A, #2
c6c5:    d5 a1                  ld B, [S++]
c6c7:    51 20                  sub A, B
c6c9:    11 04                  bnc L_c6cf
c6cb:    c0 05                  ld BL, 0x05
c6cd:    66 6b                  jsys 0x6b

L_c6cf:
c6cf:    78 21 c9 71            mul A, B, [R_c971|0xc971]
c6d3:    f5 a2                  st B, [--S]
c6d5:    30 10 c7 9d            inc [R_c79d|0xc79d], #1
c6d9:    15 07                  bnz L_c6e2
c6db:    a1 c7 9b               st AL, [R_c79a+1|0xc79b]
c6de:    d5 a1                  ld B, [S++]
c6e0:    73 17                  jmp L_c6f9

L_c6e2:
c6e2:    31 10 c7 9d            dec [R_c79d|0xc79d], #1
c6e6:    c1 c7 9b               ld BL, [R_c79a+1|0xc79b]
c6e9:    49                     sub BL, AL
c6ea:    14 04                  bz L_c6f0
c6ec:    30 a1                  inc S, #2
c6ee:    73 4a                  jmp L_c73a

L_c6f0:
c6f0:    d5 a1                  ld B, [S++]
c6f2:    91 c7 9d               ld A, [R_c79d|0xc79d]
c6f5:    51 20                  sub A, B
c6f7:    15 41                  bnz L_c73a

L_c6f9:
c6f9:    f1 c7 9d               st B, [R_c79d|0xc79d]
c6fc:    85 a8 02               ld AL, [S + 0x02]
c6ff:    14 39                  bz L_c73a
c701:    d5 a8 0b               ld B, [S + 0x0b]
c704:    30 b0 00 06            inc [S + 0x0006], #1
c708:    90 01 90               ld A, 0x0190
c70b:    59                     sub B, A
c70c:    11 03                  bnc L_c711
c70e:    95 a8 0b               ld A, [S + 0x0b]

L_c711:
c711:    c5 a8 02               ld BL, [S + 0x02]
c714:    21 31                  dec BL, #2
c716:    15 03                  bnz L_c71b
c718:    90 01 90               ld A, 0x0190

L_c71b:
c71b:    b5 81                  st A, [Z++]
c71d:    d5 a8 04               ld B, [S + 0x04]
c720:    58                     add B, A
c721:    f5 a8 04               st B, [S + 0x04]
c724:    d0 00 00               ld B, 0x0000
c727:    58                     add B, A
c728:    f3 fb                  st B, [R_c725|0xc725]
c72a:    d5 a8 0b               ld B, [S + 0x0b]
c72d:    51 20                  sub A, B
c72f:    17 01                  bp L_c732
c731:    3a                     clr A, #0

L_c732:
c732:    b5 a8 0b               st A, [S + 0x0b]
c735:    14 05                  bz L_c73c
c737:    71 c6 8d               jmp R_c68d

L_c73a:
c73a:    31 80                  dec Z, #1

L_c73c:
c73c:    80 ff                  ld AL, 0xff
c73e:    a5 81                  st AL, [Z++]
c740:    90 00 00               ld A, 0x0000
c743:    b5 81                  st A, [Z++]
c745:    93 de                  ld A, [R_c725|0xc725]
c747:    bc                     st A, [Z]
c748:    90 c7 9a               ld A, R_c79a|0xc79a
c74b:    51 80                  sub A, Z
c74d:    a3 48                  st AL, [R_c797|0xc797]
c74f:    85 a8 03               ld AL, [S + 0x03]
c752:    a1 c8 8e               st AL, [R_c88e|0xc88e]

L_c755:
c755:    79 c8 8c               call R_c88c
c758:    c7                     unknown
c759:    97                     unknown
c75a:    4d                     mov BL, AL
c75b:    15 17                  bnz R_c774
c75d:    85 a8 02               ld AL, [S + 0x02]
c760:    14 12                  bz R_c774
c762:    83 3b                  ld AL, [R_c79f|0xc79f]
c764:    c0 8b                  ld BL, 0x8b
c766:    49                     sub BL, AL
c767:    14 03                  bz L_c76c
c769:    71 c6 61               jmp R_c661

L_c76c:
c76c:    80 8c                  ld AL, 0x8c
c76e:    a3 2f                  st AL, [R_c79f|0xc79f]
c770:    31 82                  dec Z, #3
c772:    73 e1                  jmp L_c755

R_c774:
c774:    a3 1f                  st AL, [0xc795]
c776:    95 a1                  ld A, [S++]
c778:    5e                     mov Z, A
c779:    d5 a8 04               ld B, [S + 0x04]
c77c:    31 20                  dec B, #1
c77e:    90 00 0b               ld A, 0x000b
c781:    50 0a                  add S, A
c783:    95 a1                  ld A, [S++]
c785:    5c                     mov Y, A
c786:    80 ff                  ld AL, 0xff
c788:    a1 01 1f               st AL, [0x011f]
c78b:    90 00 00               ld A, 0x0000
c78e:    7e 01                  push {A}
c790:    d1 ca b2               ld B, [R_cab2|0xcab2]
c793:    90 00 00               ld A, 0x0000
c796:    09                     ret

R_c797:
c797:    00
c798:    81

R_c799:
c799:    00

R_c79a:
c79a:    84 00                  ld AL, @[0xc79c]
c79c:    83 00                  ld AL, [0xc79e]
c79e:    <null bytes>


R_c79f:
c79f:    <null bytes>


R_c7e3:
c7e3:    08                     cl

R_c7e4:
c7e4:    81 00 84               ld AL, [0x0084]

R_c7e7:
c7e7:    00                     HALT
c7e8:    83 00                  ld AL, [0xc7ea]
c7ea:    00                     HALT
c7eb:    ff                     st B, [P]

R_c7ec:
c7ec:    6d a2                  st X, [--S]
c7ee:    7e 09                  push {A, B, X, Y, Z}
c7f0:    79 cb 10               call R_cb10
c7f3:    7f 09                  pop {A, B, X, Y, Z}
c7f5:    65 68 0f               ld X, [Y + 0x0f]
c7f8:    f6 14 00               mov AL, Device[X + 0x00]
c7fb:    79 c9 81               call R_c981
c7fe:    ff                     st B, [P]
c7ff:    79 c9 97               call R_c997
c802:    00                     HALT
c803:    83 fd                  ld AL, [0xc802]
c805:    c0 12                  ld BL, 0x12
c807:    41 31                  sub AL, BL
c809:    14 04                  bz L_c80f
c80b:    32 20                  clr B, #0
c80d:    73 28                  jmp L_c837

L_c80f:
c80f:    79 c9 81               call R_c981
c812:    52 79 c9 aa            and Z, [Y + R_c9aa|0xc9aa], Z
c816:    01                     nop
c817:    f6 34 00               mov BL, Device[X + 0x00]
c81a:    f5 a2                  st B, [--S]
c81c:    79 c9 aa               call R_c9aa
c81f:    01                     nop
c820:    f6 34 00               mov BL, Device[X + 0x00]
c823:    d5 a1                  ld B, [S++]
c825:    85 68 13               ld AL, [Y + 0x13]
c828:    4a                     and BL, AL
c829:    14 08                  bz R_c833
c82b:    79 c9 1b               call R_c91b
c82e:    d0 00 ff               ld B, 0x00ff
c831:    73 04                  jmp L_c837

R_c833:
c833:    32 20                  clr B, #0
c835:    73 00                  jmp L_c837

L_c837:
c837:    79 c9 f1               call R_c9f1
c83a:    65 a1                  ld X, [S++]
c83c:    09                     ret

R_c83d:
c83d:    7e 09                  push {A, B, X, Y, Z}
c83f:    79 cb 10               call R_cb10
c842:    7f 09                  pop {A, B, X, Y, Z}
c844:    79 c9 f1               call R_c9f1
c847:    95 68 0f               ld A, [Y + 0x0f]
c84a:    f6 11 01               mov Device[A + 0x01], AL
c84d:    79 c9 ce               call R_c9ce
c850:    08                     cl
c851:    09                     ret

R_c852:
c852:    7e 45                  push {X, Y, Z}
c854:    d6 89 c8 7d            st Z, [R_c87d|0xc87d]
c858:    7e 09                  push {A, B, X, Y, Z}
c85a:    79 cb 10               call R_cb10
c85d:    7f 09                  pop {A, B, X, Y, Z}
c85f:    85 68 13               ld AL, [Y + 0x13]
c862:    a5 88 02               st AL, [Z + 0x02]
c865:    95 88 06               ld A, [Z + 0x06]
c868:    b5 a2                  st A, [--S]
c86a:    79 c9 73               call R_c973
c86d:    78 01 c9 71            mul A, A, [R_c971|0xc971]
c871:    f5 88 06               st B, [Z + 0x06]
c874:    a5 88 04               st AL, [Z + 0x04]
c877:    80 01                  ld AL, 0x01
c879:    a3 13                  st AL, [R_c88e|0xc88e]
c87b:    7b 0f                  call R_c88c

R_c87d:
c87d:    00                     HALT
c87e:    00                     HALT
c87f:    79 c9 f1               call R_c9f1
c882:    d5 a1                  ld B, [S++]
c884:    f5 88 06               st B, [Z + 0x06]
c887:    45 11                  mov AL, AL
c889:    7f 45                  pop {X, Y, Z}
c88b:    09                     ret

R_c88c:
c88c:    3a                     clr A, #0
c88d:    c0 00                  ld BL, 0x00
c88f:    15 03                  bnz L_c894
c891:    90 00 0d               ld A, 0x000d

L_c894:
c894:    b1 ca c4               st A, [R_cac4|0xcac4]
c897:    7e 45                  push {X, Y, Z}
c899:    55 a0                  mov A, S
c89b:    b1 c8 f9               st A, [R_c8f8+1|0xc8f9]
c89e:    95 68 0f               ld A, [Y + 0x0f]
c8a1:    5e                     mov Z, A
c8a2:    79 c9 05               call R_c905

R_c8a5:
c8a5:    65 a4                  ld X, @[S]
c8a7:    69 ca 86               st X, [R_ca86|0xca86]
c8aa:    d5 48 06               ld B, [X + 0x06]
c8ad:    77 32 00 15            div B, B, 0x0015
c8b1:    3a                     clr A, #0
c8b2:    85 48 09               ld AL, [X + 0x09]
c8b5:    58                     add B, A
c8b6:    f1 ca b2               st B, [R_cab2|0xcab2]
c8b9:    3a                     clr A, #0
c8ba:    85 41                  ld AL, [X++]
c8bc:    14 3a                  bz R_c8f8
c8be:    c5 68 02               ld BL, [Y + 0x02]
c8c1:    e1 ca b0               st BL, [R_cab0|0xcab0]
c8c4:    55 42                  mov B, X
c8c6:    50 04                  add X, A
c8c8:    79 cb 19               call R_cb19
c8cb:    79 c9 81               call R_c981
c8ce:    43 79                  or ZL, YL
c8d0:    c9                     ld BL, [B]
c8d1:    97                     unknown
c8d2:    00                     HALT
c8d3:    83 fd                  ld AL, [0xc8d2]
c8d5:    14 05                  bz L_c8dc
c8d7:    79 cb 44               call R_cb44
c8da:    cb                     ld BL, [Y]
c8db:    87                     unknown

L_c8dc:
c8dc:    79 cb 2a               call R_cb2a
c8df:    d5 41                  ld B, [X++]
c8e1:    9a                     ld A, [X]
c8e2:    79 cb 19               call R_cb19
c8e5:    79 c9 81               call R_c981
c8e8:    45 79                  mov ZL, YL
c8ea:    c9                     ld BL, [B]
c8eb:    97                     unknown
c8ec:    00                     HALT
c8ed:    83 fd                  ld AL, [0xc8ec]
c8ef:    14 03                  bz L_c8f4
c8f1:    71 c9 f8               jmp R_c9f8

L_c8f4:
c8f4:    79 cb 2a               call R_cb2a
c8f7:    2a                     clr AL, #0

R_c8f8:
c8f8:    60 00 00               ld X, 0x0000
c8fb:    55 4a                  mov S, X
c8fd:    7f 45                  pop {X, Y, Z}
c8ff:    d1 ca b2               ld B, [R_cab2|0xcab2]
c902:    30 41                  inc X, #2
c904:    09                     ret

R_c905:
c905:    7e 03                  push {A, B}
c907:    91 01 03               ld A, [CurrentProcess|0x0103]
c90a:    2e 0d fa 00 36         wpf 0xfa, [A + 0x36]
c90f:    2e 0c 7a 01 c5         wpf 0x7a, [R_01c5|0x01c5]
c914:    c0 02                  ld BL, 0x02
c916:    2f 28                  ld_isr B
c918:    7f 03                  pop {A, B}
c91a:    09                     ret

R_c91b:
c91b:    7e 09                  push {A, B, X, Y, Z}
c91d:    79 c9 05               call R_c905
c920:    90 c7 e3               ld A, R_c7e3|0xc7e3
c923:    b1 ca 86               st A, [R_ca86|0xca86]
c926:    85 68 13               ld AL, [Y + 0x13]
c929:    a1 c7 e5               st AL, [R_c7e4+1|0xc7e5]
c92c:    32 15 c9 71            clr [R_c971|0xc971], #5

L_c930:
c930:    31 10 c9 71            dec [R_c971|0xc971], #1
c934:    93 3b                  ld A, [R_c971|0xc971]
c936:    a1 c7 e7               st AL, [R_c7e7|0xc7e7]
c939:    3a                     clr A, #0
c93a:    81 c7 e3               ld AL, [R_c7e3|0xc7e3]
c93d:    d0 c7 e4               ld B, R_c7e4|0xc7e4
c940:    79 cb 19               call R_cb19
c943:    79 c9 81               call R_c981
c946:    43 79                  or ZL, YL
c948:    c9                     ld BL, [B]
c949:    81 45 79               ld AL, [0x4579]
c94c:    c9                     ld BL, [B]
c94d:    97                     unknown
c94e:    00                     HALT
c94f:    83 fd                  ld AL, [0xc94e]
c951:    14 05                  bz L_c958
c953:    c0 19                  ld BL, 0x19
c955:    49                     sub BL, AL
c956:    14 d8                  bz L_c930

L_c958:
c958:    30 10 c9 71            inc [R_c971|0xc971], #1
c95c:    d3 13                  ld B, [R_c971|0xc971]
c95e:    77 32 03 90            div B, B, 0x0390
c962:    f5 68 11               st B, [Y + 0x11]
c965:    d3 0a                  ld B, [R_c971|0xc971]
c967:    77 32 00 14            div B, B, 0x0014
c96b:    e5 68 16               st BL, [Y + 0x16]
c96e:    7f 09                  pop {A, B, X, Y, Z}
c970:    09                     ret

R_c971:
c971:    00
c972:    00

R_c973:
c973:    f5 a2                  st B, [--S]
c975:    d5 68 11               ld B, [Y + 0x11]
c978:    78 32 03 90            mul B, B, 0x0390
c97c:    f3 f3                  st B, [R_c971|0xc971]
c97e:    d5 a1                  ld B, [S++]
c980:    09                     ret

R_c981:
c981:    7e 03                  push {A, B}
c983:    7b 49                  call R_c9ce
c985:    08                     cl
c986:    7b 46                  call R_c9ce
c988:    02                     sf
c989:    95 68 0f               ld A, [Y + 0x0f]
c98c:    c5 41                  ld BL, [X++]
c98e:    f6 31 00               mov Device[A + 0x00], BL
c991:    7b 3b                  call R_c9ce
c993:    02                     sf
c994:    7f 03                  pop {A, B}
c996:    09                     ret

R_c997:
c997:    7e 03                  push {A, B}
c999:    7b 33                  call R_c9ce
c99b:    08                     cl
c99c:    7b 0c                  call R_c9aa
c99e:    01                     nop
c99f:    95 68 0f               ld A, [Y + 0x0f]
c9a2:    f6 30 00               mov BL, Device[A + 0x00]
c9a5:    e5 41                  st BL, [X++]
c9a7:    7f 03                  pop {A, B}
c9a9:    09                     ret

R_c9aa:
c9aa:    85 41                  ld AL, [X++]
c9ac:    a5 a2                  st AL, [--S]
c9ae:    79 ce 2a               call SetTimeout8

L_c9b1:
c9b1:    d5 68 0f               ld B, [Y + 0x0f]
c9b4:    f6 32 01               mov BL, Device[B + 0x01]
c9b7:    8d                     ld AL, [S]
c9b8:    4a                     and BL, AL
c9b9:    49                     sub BL, AL
c9ba:    14 0c                  bz L_c9c8
c9bc:    79 ce 33               call CheckTimeout
c9bf:    14 f0                  bz L_c9b1
c9c1:    85 a1                  ld AL, [S++]
c9c3:    79 cb 44               call R_cb44
c9c6:    cb                     ld BL, [Y]
c9c7:    a2 '"'

L_c9c8:
c9c8:    85 a1                  ld AL, [S++]
c9ca:    79 ce 41               call SetTimeout256
c9cd:    09                     ret

R_c9ce:
c9ce:    85 41                  ld AL, [X++]
c9d0:    a5 a2                  st AL, [--S]
c9d2:    79 ce 2a               call SetTimeout8

L_c9d5:
c9d5:    d5 68 0f               ld B, [Y + 0x0f]
c9d8:    f6 32 01               mov BL, Device[B + 0x01]
c9db:    8d                     ld AL, [S]
c9dc:    4a                     and BL, AL
c9dd:    14 0c                  bz L_c9eb
c9df:    79 ce 33               call CheckTimeout
c9e2:    14 f1                  bz L_c9d5
c9e4:    85 a1                  ld AL, [S++]
c9e6:    79 cb 44               call R_cb44
c9e9:    cb                     ld BL, [Y]
c9ea:    a2 '"'

L_c9eb:
c9eb:    85 a1                  ld AL, [S++]
c9ed:    79 ce 41               call SetTimeout256
c9f0:    09                     ret

R_c9f1:
c9f1:    47 4c 00 ff 01 1f      memcpy 0x01, 0xff, [0x011f]
c9f7:    09                     ret

R_c9f8:
c9f8:    a3 0e                  st AL, [R_ca08|0xca08]
c9fa:    c0 11                  ld BL, 0x11
c9fc:    49                     sub BL, AL
c9fd:    22 20                  clr BH, #0
c9ff:    35 20                  sll B, #1
ca01:    90 ca 09               ld A, R_ca09|0xca09
ca04:    58                     add B, A
ca05:    99                     ld A, [B]
ca06:    75 00                  jmp [A]

R_ca08:
ca08:    00

R_ca09:
ca09:    ca                     ld BL, [X]
ca0a:    e3 ca                  st BL, [L_c9d5+1|0xc9d6]
ca0c:    e7                     unknown
ca0d:    ca                     ld BL, [X]
ca0e:    e7                     unknown
ca0f:    ca                     ld BL, [X]
ca10:    e7                     unknown
ca11:    ca                     ld BL, [X]
ca12:    db                     ld B, [Y]
ca13:    ca                     ld BL, [X]
ca14:    df                     ld B, [P]
ca15:    ca                     ld BL, [X]
ca16:    eb                     st BL, [Y]
ca17:    ca                     ld BL, [X]
ca18:    ef                     st BL, [P]
ca19:    ca                     ld BL, [X]
ca1a:    f3 ca                  st B, [0xc9e6]
ca1c:    f7                     memcpy16
ca1d:    ca                     ld BL, [X]
ca1e:    db                     ld B, [Y]
ca1f:    ca                     ld BL, [X]
ca20:    db                     ld B, [Y]
ca21:    ca                     ld BL, [X]
ca22:    fb                     st B, [Y]
ca23:    ca                     ld BL, [X]
ca24:    df                     ld B, [P]
ca25:    ca                     ld BL, [X]
ca26:    df                     ld B, [P]
ca27:    ca                     ld BL, [X]
ca28:    df                     ld B, [P]
ca29:    ca                     ld BL, [X]
ca2a:    db                     ld B, [Y]
ca2b:    ca                     ld BL, [X]
ca2c:    db                     ld B, [Y]
ca2d:    cb                     ld BL, [Y]
ca2e:    02                     sf
ca2f:    cb                     ld BL, [Y]
ca30:    09                     ret
ca31:    ca 'J'
ca32:    df '_'
ca33:    ca 'J'
ca34:    df '_'
ca35:    ca 'J'
ca36:    df '_'
ca37:    ca 'J'
ca38:    df '_'
ca39:    ca 'J'
ca3a:    df '_'
ca3b:    ca 'J'
ca3c:    df '_'
ca3d:    ca 'J'
ca3e:    df '_'

L_ca3f:
ca3f:    ca                     ld BL, [X]
ca40:    df                     ld B, [P]
ca41:    ca                     ld BL, [X]
ca42:    df                     ld B, [P]
ca43:    ca                     ld BL, [X]
ca44:    df                     ld B, [P]
ca45:    ca                     ld BL, [X]
ca46:    df                     ld B, [P]
ca47:    ca                     ld BL, [X]
ca48:    df                     ld B, [P]
ca49:    ca                     ld BL, [X]
ca4a:    db                     ld B, [Y]
ca4b:    ca                     ld BL, [X]
ca4c:    db                     ld B, [Y]
ca4d:    cb                     ld BL, [Y]
ca4e:    09                     ret
ca4f:    cb 'K'
ca50:    09
ca51:    cb 'K'
ca52:    09
ca53:    cb 'K'
ca54:    02
ca55:    ca 'J'
ca56:    df '_'
ca57:    cb 'K'
ca58:    02
ca59:    cb 'K'
ca5a:    02
ca5b:    cb 'K'
ca5c:    02
ca5d:    cb 'K'
ca5e:    02
ca5f:    cb 'K'
ca60:    09
ca61:    ca 'J'
ca62:    df '_'
ca63:    ca 'J'
ca64:    df '_'
ca65:    ca 'J'
ca66:    df '_'
ca67:    ca 'J'
ca68:    df '_'
ca69:    ca 'J'
ca6a:    fb '{'
ca6b:    ca 'J'
ca6c:    df '_'

R_ca6d:
ca6d:    7c 12                  call R_a550 (via 0xca80+1)
ca6f:    cb                     ld BL, [Y]
ca70:    67 7c 0e 00 00         unkblk7 AL, 0x0e, [L_0000|0x0000]
ca75:    32 02                  clr A, #2
ca77:    c0 b0                  ld BL, 0xb0
ca79:    46 e0 90 cb fe ca 08   baseconv(e, 0) [R_cbf9+5|0xcbfe], [R_ca08|0xca08]
ca80:    79 a5 50               call R_a550
ca83:    cb                     ld BL, [Y]
ca84:    f9                     st B, [B]
ca85:    90 c7 97               ld A, R_c797|0xc797
ca88:    5c                     mov Y, A
ca89:    3a                     clr A, #0
ca8a:    8b                     ld AL, [Y]
ca8b:    38                     inc A, #1
ca8c:    5b                     mov X, A

L_ca8d:
ca8d:    90 c0 c0               ld A, 0xc0c0
ca90:    b1 cc 09               st A, [R_cc07+2|0xcc09]
ca93:    80 02                  ld AL, 0x02
ca95:    46 e0 92 cc 09 06      baseconv(e, 0) [R_cc07+2|0xcc09], [Y]
ca9b:    30 60                  inc Y, #1
ca9d:    7c e2                  call R_a550 (via 0xca80+1)
ca9f:    cc                     ld BL, [Z]
caa0:    07                     rl
caa1:    3f                     dec X
caa2:    18 e9                  bgt L_ca8d
caa4:    7c db                  call R_a550 (via 0xca80+1)
caa6:    cb                     ld BL, [Y]
caa7:    67 47 4c 00 ff         memcpy AL, [X + C + 0x00], 0xff
caac:    01                     nop
caad:    1f 90                  branch_unlocked L_ca3f
caaf:    00                     HALT

R_cab0:
cab0:    00                     HALT
cab1:    d0 00 00               ld B, 0x0000
cab4:    c0 0d                  ld BL, 0x0d
cab6:    66 6b                  jsys 0x6b

R_cab8:
cab8:    31 10 ca c4            dec [R_cac4|0xcac4], #1
cabc:    16 05                  blt L_cac3
cabe:    30 a1                  inc S, #2
cac0:    71 c8 a5               jmp R_c8a5

L_cac3:
cac3:    09                     ret

R_cac4:
cac4:    00
cac5:    00

L_cac6:
cac6:    90 c0 c0               ld A, 0xc0c0
cac9:    b1 cb fe               st A, [R_cbf9+5|0xcbfe]
cacc:    95 41                  ld A, [X++]
cace:    b3 a3                  st A, [R_ca73|0xca73]
cad0:    81 ca 08               ld AL, [R_ca08|0xca08]
cad3:    c1 c8 8e               ld BL, [R_c88e|0xc88e]
cad6:    14 95                  bz R_ca6d
cad8:    71 c8 f8               jmp R_c8f8

R_cadb:
cadb:    7b e9                  call L_cac6
cadd:    cc                     ld BL, [Z]
cade:    4e                     mov ZL, AL

R_cadf:
cadf:    7b e5                  call L_cac6
cae1:    cc                     ld BL, [Z]
cae2:    60 7b e1               ld X, 0x7be1
cae5:    cb                     ld BL, [Y]
cae6:    87                     unknown

R_cae7:
cae7:    7b dd                  call L_cac6
cae9:    cb                     ld BL, [Y]
caea:    d4 7b                  ld B, @[R_cb67|0xcb67]
caec:    d9                     ld B, [B]
caed:    cc                     ld BL, [Z]
caee:    76                     enable_parity_trap

R_caef:
caef:    7b d5                  call L_cac6
caf1:    cc                     ld BL, [Z]
caf2:    8c                     ld AL, [Z]

R_caf3:
caf3:    7b d1                  call L_cac6
caf5:    cc                     ld BL, [Z]
caf6:    9e                     ld A, [C]

R_caf7:
caf7:    7b cd                  call L_cac6
caf9:    cc                     ld BL, [Z]
cafa:    b4 79                  st A, @[0xcb75]
cafc:    ca                     ld BL, [X]
cafd:    b8                     st A, [A]
cafe:    7b c6                  call L_cac6
cb00:    cc                     ld BL, [Z]
cb01:    cc                     ld BL, [Z]

R_cb02:
cb02:    79 ca b8               call R_cab8
cb05:    7b bf                  call L_cac6
cb07:    cb                     ld BL, [Y]
cb08:    c4 79                  ld BL, @[0xcb83]
cb0a:    ca                     ld BL, [X]
cb0b:    b8                     st A, [A]
cb0c:    7b b8                  call L_cac6
cb0e:    cc                     ld BL, [Z]
cb0f:    2e

R_cb10:
cb10:    80 1f                  ld AL, 0x1f
cb12:    66 12                  jsys Syscall_12
cb14:    d6 67 01 3f            st Y, [ActiveDiskDevice|0x013f]
cb18:    09                     ret

R_cb19:
cb19:    2f 34                  dma_mode #3
cb1b:    2f 20                  ld_dma_addr B
cb1d:    3b                     not A, #0
cb1e:    2f 02                  ld_dma_count A
cb20:    2f 06                  enable_dma
cb22:    59                     sub B, A
cb23:    f0 00 00               st B, 0x0000
cb26:    3a                     clr A, #0
cb27:    d7 12                  mov IL1(B), A
cb29:    09                     ret

R_cb2a:
cb2a:    2f 07                  disable_dma
cb2c:    2f 03                  st_dma_count A
cb2e:    38                     inc A, #1
cb2f:    14 04                  bz L_cb35
cb31:    7b 11                  call R_cb44
cb33:    cc                     ld BL, [Z]
cb34:    0c                     unknown_0c

L_cb35:
cb35:    2f 03                  st_dma_count A
cb37:    2f 21                  st_dma_addr B
cb39:    59                     sub B, A
cb3a:    93 e8                  ld A, [0xcb24]
cb3c:    59                     sub B, A
cb3d:    15 01                  bnz L_cb40
cb3f:    09                     ret

L_cb40:
cb40:    7b 02                  call R_cb44
cb42:    cc                     ld BL, [Z]
cb43:    20

R_cb44:
cb44:    d5 68 0f               ld B, [Y + 0x0f]
cb47:    f6 33 01               mov Device[B + 0x01], BL
cb4a:    c1 c8 8e               ld BL, [R_c88e|0xc88e]
cb4d:    17 05                  bp L_cb54
cb4f:    30 a3                  inc S, #4
cb51:    71 c8 33               jmp R_c833

L_cb54:
cb54:    14 03                  bz L_cb59
cb56:    71 c8 f8               jmp R_c8f8

L_cb59:
cb59:    95 41                  ld A, [X++]
cb5b:    b1 ca 73               st A, [R_ca73|0xca73]
cb5e:    90 c0 c0               ld A, 0xc0c0
cb61:    b1 cb fe               st A, [R_cbf9+5|0xcbfe]
cb64:    71 ca 6d               jmp R_ca6d

R_cb67:
cb67:    1, "\r"
cb6a:    27, "WNC CONTROL SIGNAL FAILURE\r"

R_cb87:
cb87:    25, "WNC COMMAND LOAD FAILURE\r"

R_cba2:
cba2:    23, "WNC CONTROL SIGNAL LAG\r"
cbbb:    7, "\x07ID NN\r"

R_cbc4:
cbc4:    14, "WNC I/O ERROR\r"

R_cbd4:
cbd4:    35, "WNC ERROR - ILLEGAL COMMAND STRING\r"

R_cbf9:
cbf9:    12, "EC:@@ CMDS: "

R_cc07:
cc07:    3, "XX "

R_cc0c:
cc0c:    18, "DMA NOT COMPLETED\r"

R_cc20:
cc20:    12, "DMA FAILURE\r"

R_cc2e:
cc2e:    16, "WNC I/O FAILURE\r"
cc40:    12, "RTZ FAILURE\r"

R_cc4e:
cc4e:    16, "UNDEFINED ERROR\r"

R_cc60:
cc60:    20, "UNDOCUMENTED ERROR\x07\r"

R_cc76:
cc76:    20, "ILLEGAL UNIT SELECT\r"

R_cc8c:
cc8c:    16, "ILLEGAL TRACK #\r"

R_cc9e:
cc9e:    20, "INVALID HEAD SELECT\r"

R_ccb4:
ccb4:    22, "AUX BUFFER ADDR ERROR\r"

R_cccc:
cccc:    22, "SECTOR ACCESS TIMEOUT\r"

R_cce4:
cce4:    00

R_cce5:
cce5:    00

R_cce6:
cce6:    00
cce7:    00

R_cce8:
cce8:    6d a2                  st X, [--S]
ccea:    f5 a2                  st B, [--S]
ccec:    55 62                  mov B, Y
ccee:    f5 a2                  st B, [--S]
ccf0:    a5 a2                  st AL, [--S]
ccf2:    3a                     clr A, #0
ccf3:    39                     dec A, #1
ccf4:    5c                     mov Y, A
ccf5:    65 28 14               ld X, [B + 0x14]
ccf8:    31 41                  dec X, #2

L_ccfa:
ccfa:    30 41                  inc X, #2
ccfc:    30 60                  inc Y, #1
ccfe:    8d                     ld AL, [S]
ccff:    c5 41                  ld BL, [X++]
cd01:    16 24                  blt L_cd27
cd03:    49                     sub BL, AL
cd04:    15 f4                  bnz L_ccfa
cd06:    95 a8 03               ld A, [S + 0x03]
cd09:    da                     ld B, [X]
cd0a:    59                     sub B, A
cd0b:    15 ed                  bnz L_ccfa
cd0d:    95 a8 01               ld A, [S + 0x01]
cd10:    d5 08 11               ld B, [A + 0x11]
cd13:    3a                     clr A, #0
cd14:    60 00 04               ld X, 0x0004

L_cd17:
cd17:    35 20                  sll B, #1
cd19:    37 00                  rlc A, #1
cd1b:    3f                     dec X
cd1c:    18 f9                  bgt L_cd17
cd1e:    50 62                  add B, Y
cd20:    11 01                  bnc L_cd23
cd22:    38                     inc A, #1

L_cd23:
cd23:    ad                     st AL, [S]
cd24:    f5 a8 03               st B, [S + 0x03]

L_cd27:
cd27:    3a                     clr A, #0
cd28:    85 a1                  ld AL, [S++]
cd2a:    d5 a1                  ld B, [S++]
cd2c:    55 26                  mov Y, B
cd2e:    d5 a1                  ld B, [S++]
cd30:    65 a1                  ld X, [S++]
cd32:    09                     ret

R_cd33:
cd33:    6d a2                  st X, [--S]
cd35:    32 40                  clr X, #0
cd37:    7e 03                  push {A, B}
cd39:    d9                     ld B, [B]
cd3a:    51 20                  sub A, B
cd3c:    10 06                  bc L_cd44
cd3e:    7f 01                  pop {A}
cd40:    c0 24                  ld BL, 0x24
cd42:    66 6b                  jsys 0x6b

L_cd44:
cd44:    7f 01                  pop {A}
cd46:    dd                     ld B, [S]
cd47:    d5 28 04               ld B, [B + 0x04]
cd4a:    c0 10                  ld BL, 0x10
cd4c:    07                     rl

L_cd4d:
cd4d:    21 20                  dec BH, #1
cd4f:    16 07                  blt L_cd58
cd51:    21 30                  dec BL, #1
cd53:    3c                     srl A, #1
cd54:    36 40                  rrc X, #1
cd56:    73 f5                  jmp L_cd4d

L_cd58:
cd58:    36 40                  rrc X, #1
cd5a:    07                     rl
cd5b:    21 30                  dec BL, #1
cd5d:    18 f9                  bgt L_cd58
cd5f:    5d                     mov B, A
cd60:    3d                     sll A, #1
cd61:    58                     add B, A
cd62:    95 a1                  ld A, [S++]
cd64:    58                     add B, A
cd65:    3a                     clr A, #0
cd66:    85 29 1b               ld AL, [B++ + 0x1b]
cd69:    d5 28 1b               ld B, [B + 0x1b]
cd6c:    50 42                  add B, X
cd6e:    11 01                  bnc L_cd71
cd70:    38                     inc A, #1

L_cd71:
cd71:    65 a1                  ld X, [S++]
cd73:    09                     ret

DiskDevice_BlockIO_Special:
cd74:    7e 61                  push {Y}
cd76:    95 41                  ld A, [X++]
cd78:    d5 41                  ld B, [X++]
cd7a:    f5 a2                  st B, [--S]
cd7c:    b5 a2                  st A, [--S]
cd7e:    85 41                  ld AL, [X++]
cd80:    79 cf 1d               call FindDiskDevice
cd83:    15 04                  bnz L_cd89

L_cd85:
cd85:    c0 06                  ld BL, 0x06
cd87:    66 6b                  jsys 0x6b

L_cd89:
cd89:    85 68 13               ld AL, [Y + 0x13]
cd8c:    a5 a2                  st AL, [--S]
cd8e:    95 41                  ld A, [X++]
cd90:    b5 a2                  st A, [--S]
cd92:    95 41                  ld A, [X++]

L_cd94:
cd94:    b5 a2                  st A, [--S]
cd96:    85 41                  ld AL, [X++]
cd98:    c0 80                  ld BL, 0x80
cd9a:    4a                     and BL, AL
cd9b:    14 02                  bz L_cd9f
cd9d:    c0 01                  ld BL, 0x01

L_cd9f:
cd9f:    e5 a2                  st BL, [--S]
cda1:    c0 7f                  ld BL, 0x7f
cda3:    42 31                  and AL, BL
cda5:    a5 a2                  st AL, [--S]
cda7:    21 11                  dec AL, #2
cda9:    19 04                  ble DiskDevice_CallBlockIO
cdab:    c0 08                  ld BL, 0x08
cdad:    66 6b                  jsys 0x6b

DiskDevice_CallBlockIO:
cdaf:    80 04                  ld AL, 0x04
cdb1:    a5 a2                  st AL, [--S]
cdb3:    80 1f                  ld AL, 0x1f
cdb5:    66 12                  jsys Syscall_12
cdb7:    d6 67 01 3f            st Y, [ActiveDiskDevice|0x013f]
cdbb:    3a                     clr A, #0
cdbc:    85 a1                  ld AL, [S++]
cdbe:    3d                     sll A, #1
cdbf:    50 71 00 05            add A, [Y + 0x0005], A
cdc3:    7d 04                  call @[A]
cdc5:    09                     ret

L_cdc6:
cdc6:    7e 61                  push {Y}
cdc8:    95 88 04               ld A, [Z + 0x04]
cdcb:    b5 a2                  st A, [--S]
cdcd:    55 82                  mov B, Z
cdcf:    66 0c                  jsys 0x0c
cdd1:    95 88 06               ld A, [Z + 0x06]
cdd4:    30 01                  inc A, #2
cdd6:    b3 17                  st A, [0xcdef]
cdd8:    f5 a2                  st B, [--S]
cdda:    85 68 02               ld AL, [Y + 0x02]
cddd:    79 cf 1d               call FindDiskDevice
cde0:    15 02                  bnz L_cde4
cde2:    73 a1                  jmp L_cd85

L_cde4:
cde4:    85 68 13               ld AL, [Y + 0x13]
cde7:    a5 a2                  st AL, [--S]
cde9:    95 88 08               ld A, [Z + 0x08]
cdec:    b5 a2                  st A, [--S]
cdee:    90 00 00               ld A, 0x0000
cdf1:    73 a1                  jmp L_cd94

DiskDevice_Read:
cdf3:    5c                     mov Y, A
cdf4:    d0 01 90               ld B, 0x0190
cdf7:    95 88 04               ld A, [Z + 0x04]
cdfa:    59                     sub B, A
cdfb:    17 18                  bp L_ce15
cdfd:    80 05                  ld AL, 0x05

L_cdff:
cdff:    ac                     st AL, [Z]
ce00:    2a                     clr AL, #0
ce01:    a5 6c 03               st AL, @[Y + 0x03]
ce04:    a5 6c 05               st AL, @[Y + 0x05]
ce07:    65 a1                  ld X, [S++]
ce09:    95 a1                  ld A, [S++]
ce0b:    5c                     mov Y, A
ce0c:    95 a1                  ld A, [S++]
ce0e:    5e                     mov Z, A
ce0f:    91 01 01               ld A, [SyscallVector+1|0x0101]
ce12:    75 08 03               jmp [A + 0x03]

L_ce15:
ce15:    d5 88 06               ld B, [Z + 0x06]
ce18:    b5 21                  st A, [B++]
ce1a:    58                     add B, A
ce1b:    2a                     clr AL, #0
ce1c:    a9                     st AL, [B]
ce1d:    7b a7                  call L_cdc6
ce1f:    01                     nop
ce20:    2a                     clr AL, #0
ce21:    73 dc                  jmp L_cdff

DiskDevice_Write:
ce23:    5c                     mov Y, A
ce24:    7b a0                  call L_cdc6
ce26:    02                     sf
ce27:    2a                     clr AL, #0
ce28:    73 d5                  jmp L_cdff

SetTimeout8:
ce2a:    32 08                  clr A, #8
ce2c:    d1 01 03               ld B, [CurrentProcess|0x0103]
ce2f:    b5 28 32               st A, [B + 0x32]
ce32:    09                     ret

CheckTimeout:
ce33:    66 07                  jsys Syscall_Yield
ce35:    d1 01 03               ld B, [CurrentProcess|0x0103]
ce38:    95 28 32               ld A, [B + 0x32]
ce3b:    14 02                  bz L_ce3f
ce3d:    3a                     clr A, #0
ce3e:    09                     ret

L_ce3f:
ce3f:    38                     inc A, #1
ce40:    09                     ret

SetTimeout256:
ce41:    d1 01 03               ld B, [CurrentProcess|0x0103]
ce44:    3a                     clr A, #0
ce45:    39                     dec A, #1
ce46:    b5 28 32               st A, [B + 0x32]
ce49:    09                     ret

R_ce4a:
ce4a:    79 ce a6               call R_cea6
ce4d:    91 01 0b               ld A, [0x010b]
ce50:    7e 41                  push {X}
ce52:    65 00                  ld X, [A]
ce54:    30 01                  inc A, #2

L_ce56:
ce56:    31 41                  dec X, #2
ce58:    16 12                  blt L_ce6c
ce5a:    d5 01                  ld B, [A++]
ce5c:    14 f8                  bz L_ce56
ce5e:    51 82                  sub B, Z
ce60:    15 f4                  bnz L_ce56
ce62:    3a                     clr A, #0
ce63:    95 88 0f               ld A, [Z + 0x0f]
ce66:    c5 88 19               ld BL, [Z + 0x19]
ce69:    f6 31 00               mov Device[A + 0x00], BL

L_ce6c:
ce6c:    7f 41                  pop {X}
ce6e:    85 88 11               ld AL, [Z + 0x11]
ce71:    14 07                  bz L_ce7a
ce73:    2a                     clr AL, #0
ce74:    a5 88 11               st AL, [Z + 0x11]
ce77:    a5 8c 14               st AL, @[Z + 0x14]

L_ce7a:
ce7a:    91 00 5a               ld A, [0x005a]
ce7d:    d5 08 6e               ld B, [A + 0x6e]
ce80:    3a                     clr A, #0
ce81:    a5 28 02               st AL, [B + 0x02]
ce84:    a5 28 05               st AL, [B + 0x05]
ce87:    a5 28 08               st AL, [B + 0x08]
ce8a:    a5 28 0b               st AL, [B + 0x0b]
ce8d:    a5 28 0e               st AL, [B + 0x0e]
ce90:    a5 28 11               st AL, [B + 0x11]
ce93:    a5 28 14               st AL, [B + 0x14]
ce96:    91 01 01               ld A, [SyscallVector+1|0x0101]
ce99:    75 08 03               jmp [A + 0x03]
ce9c:    ce 'N'
ce9d:    9e

DiskDevice_Abort:
ce9e:    7b 06                  call R_cea6
cea0:    91 01 01               ld A, [SyscallVector+1|0x0101]
cea3:    75 08 03               jmp [A + 0x03]

R_cea6:
cea6:    85 8c 03               ld AL, @[Z + 0x03]
cea9:    49                     sub BL, AL
ceaa:    15 06                  bnz L_ceb2
ceac:    e5 8c 03               st BL, @[Z + 0x03]
ceaf:    e5 8c 05               st BL, @[Z + 0x05]

L_ceb2:
ceb2:    09                     ret

R_ceb3:
ceb3:    7e 05                  push {A, B, X}
ceb5:    b3 14                  st A, [R_cecb|0xcecb]
ceb7:    65 41                  ld X, [X++]
ceb9:    47 9e 03 c0 04         memset 0x04, 0xc0, [X]
cebe:    80 04                  ld AL, 0x04
cec0:    46 e1 98 40 ce cb      baseconv(e, 1) [X], [R_cecb|0xcecb]
cec6:    7f 05                  pop {A, B, X}
cec8:    30 41                  inc X, #2
ceca:    09                     ret

R_cecb:
cecb:    00
cecc:    00

R_cecd:
cecd:    95 41                  ld A, [X++]
cecf:    d5 41                  ld B, [X++]
ced1:    7b 05                  call L_ced8
ced3:    0f                     rsys
ced4:    95
ced5:    41

R_ced6:
ced6:    d5 41                  ld B, [X++]

L_ced8:
ced8:    30 20                  inc B, #1
ceda:    7e 43                  push {X, Y}
cedc:    55 24                  mov X, B
cede:    47 9c 05 c0 cf 15      memset 0x06, 0xc0, [R_cf15|0xcf15]
cee4:    c0 a3                  ld BL, 0xa3
cee6:    e3 31                  st BL, [0xcf19]
cee8:    c0 a0                  ld BL, 0xa0
ceea:    b3 2f                  st A, [R_cf1b|0xcf1b]
ceec:    17 06                  bp L_cef4
ceee:    33 11 cf 1b            not [R_cf1b|0xcf1b], #1
cef2:    c0 ad                  ld BL, 0xad

L_cef4:
cef4:    e5 a2                  st BL, [--S]
cef6:    80 06                  ld AL, 0x06
cef8:    46 81 90 cf 15 cf 1b   baseconv(8, 1) [R_cf15|0xcf15], [R_cf1b|0xcf1b]
ceff:    22 30                  clr BL, #0
cf01:    e8                     st BL, [A]
cf02:    55 76 cf 1b            mov Y, R_cf1b|0xcf1b

L_cf06:
cf06:    85 62                  ld AL, [--Y]
cf08:    14 04                  bz L_cf0e
cf0a:    a5 42                  st AL, [--X]
cf0c:    73 f8                  jmp L_cf06

L_cf0e:
cf0e:    c5 a1                  ld BL, [S++]
cf10:    e5 42                  st BL, [--X]
cf12:    7f 43                  pop {X, Y}
cf14:    09                     ret

R_cf15:
cf15:    00
cf16:    00
cf17:    00
cf18:    00
cf19:    00
cf1a:    00

R_cf1b:
cf1b:    00
cf1c:    00

FindDiskDevice:
cf1d:    c1 01 06               ld BL, [0x0106]
cf20:    49                     sub BL, AL
cf21:    18 0d                  bgt L_cf30
cf23:    6d a2                  st X, [--S]
cf25:    61 01 09               ld X, [DevicesPtr|0x0109]

L_cf28:
cf28:    d5 41                  ld B, [X++]
cf2a:    55 26                  mov Y, B
cf2c:    15 04                  bnz L_cf32
cf2e:    65 a1                  ld X, [S++]

L_cf30:
cf30:    3a                     clr A, #0
cf31:    09                     ret

L_cf32:
cf32:    cb                     ld BL, [Y]
cf33:    14 f3                  bz L_cf28
cf35:    46 00 2d 04 60 01      unkbig2(0, 0) 0x04, [Y + 0x01]
cf3b:    15 eb                  bnz L_cf28
cf3d:    c5 68 02               ld BL, [Y + 0x02]
cf40:    49                     sub BL, AL
cf41:    15 e5                  bnz L_cf28
cf43:    65 a1                  ld X, [S++]
cf45:    09                     ret

Start:
cf46:    32 c0                  clr C, #0
cf48:    47 9c ef 00 00 10      memset 0xf0, 0x00, [0x0010]
cf4e:    55 ba d0 79            mov S, R_d079|0xd079
cf52:    b1 e1 8c               st A, [R_e18c|0xe18c]
cf55:    55 88                  mov Z, Z
cf57:    15 04                  bnz L_cf5d
cf59:    c0 01                  ld BL, 0x01
cf5b:    73 20                  jmp L_cf7d

L_cf5d:
cf5d:    31 80                  dec Z, #1
cf5f:    15 04                  bnz L_cf65
cf61:    c0 15                  ld BL, 0x15
cf63:    73 18                  jmp L_cf7d

L_cf65:
cf65:    31 80                  dec Z, #1
cf67:    15 04                  bnz L_cf6d
cf69:    c0 0b                  ld BL, 0x0b
cf6b:    73 10                  jmp L_cf7d

L_cf6d:
cf6d:    31 80                  dec Z, #1
cf6f:    15 04                  bnz L_cf75
cf71:    c0 28                  ld BL, 0x28
cf73:    73 0c                  jmp L_cf81

L_cf75:
cf75:    31 80                  dec Z, #1
cf77:    15 04                  bnz L_cf7d
cf79:    c0 32                  ld BL, 0x32
cf7b:    73 00                  jmp L_cf7d

L_cf7d:
cf7d:    1d 02                  bs4 L_cf81
cf7f:    21 30                  dec BL, #1

L_cf81:
cf81:    e1 d2 7c               st BL, [LOS_DiskNum|0xd27c]
cf84:    1b 06                  bs2 L_cf8c
cf86:    47 4c 00 00 e1 fd      memcpy 0x01, 0x00, [LOS_Autoboot|0xe1fd]

L_cf8c:
cf8c:    a1 e1 98               st AL, [R_e198|0xe198]
cf8f:    21 39                  dec BL, #10
cf91:    16 05                  blt L_cf98
cf93:    90 a6 f7               ld A, HawkDeviceFunctions|0xa6f7
cf96:    73 03                  jmp L_cf9b

L_cf98:
cf98:    90 ac a7               ld A, FDCDeviceObj|0xaca7

L_cf9b:
cf9b:    b1 e1 8f               st A, [R_e18e+1|0xe18f]
cf9e:    50 10 01 90            add A, A, 0x0190
cfa2:    b1 e1 91               st A, [R_e191|0xe191]
cfa5:    b1 d6 5b               st A, [R_d65b|0xd65b]
cfa8:    b1 d6 7b               st A, [R_d67b|0xd67b]
cfab:    b1 d6 87               st A, [R_d687|0xd687]
cfae:    b1 d6 c9               st A, [R_d6c9|0xd6c9]
cfb1:    b1 e1 a5               st A, [R_e1a5|0xe1a5]
cfb4:    50 10 01 90            add A, A, 0x0190
cfb8:    b1 e1 93               st A, [R_e193|0xe193]
cfbb:    d2 01 09               ld B, @[DevicesPtr|0x0109]
cfbe:    81 e1 98               ld AL, [R_e198|0xe198]
cfc1:    a5 28 19               st AL, [B + 0x19]
cfc4:    90 a0 7f               ld A, level15HandlerA|0xa07f
cfc7:    d7 fe                  mov IL15(P), A
cfc9:    3a                     clr A, #0
cfca:    d7 ac                  mov IL10(C), A
cfcc:    90 01 00               ld A, 0x0100
cfcf:    b1 00 5a               st A, [0x005a]
cfd2:    2e 2c 78 d4 cd         wpf1 0x78, [R_d4cd|0xd4cd]
cfd7:    d0 78 00               ld B, 0x7800
cfda:    55 26                  mov Y, B
cfdc:    32 20                  clr B, #0
cfde:    90 07 ff               ld A, 0x07ff
cfe1:    f7                     memcpy16
cfe2:    2e 2c 78 d4 cc         wpf1 0x78, [R_d4cc|0xd4cc]
cfe7:    d0 01 00               ld B, 0x0100
cfea:    55 26                  mov Y, B
cfec:    90 ee ff               ld A, 0xeeff
cfef:    f7                     memcpy16
cff0:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
cff5:    90 78 05               ld A, 0x7805
cff8:    b1 9f 96               st A, [R_9f96|0x9f96]
cffb:    47 4c 04 00 00 00 05 7f 78 00 memcpy 0x05, 0x000000057f, [0x7800]
d005:    47 4c 04 78 00 07 f0 ff 78 05 memcpy 0x05, 0x780007f0ff, [0x7805]
d00f:    92 01 07               ld A, @[0x0107]
d012:    2e 0d f9 00 36         wpf 0xf9, [A + 0x36]
d017:    2e 0d fb 00 36         wpf 0xfb, [A + 0x36]
d01c:    47 44 0f 00 36 01 c5   memcpy 0x10, [A + 0x36], [R_01c5|0x01c5]
d023:    90 00 01               ld A, 0x0001
d026:    d7 6c                  mov IL6(C), A
d028:    90 d0 7c               ld A, level15HandlerB|0xd07c
d02b:    d7 fe                  mov IL15(P), A
d02d:    60 ff ff               ld X, 0xffff

L_d030:
d030:    2e 2c f8 d4 d5         wpf1 0xf8, [R_d4d5|0xd4d5]
d035:    3a                     clr A, #0
d036:    aa                     st AL, [X]
d037:    8a                     ld AL, [X]
d038:    41 01                  sub AL, AH
d03a:    15 33                  bnz L_d06f
d03c:    55 40                  mov A, X
d03e:    aa                     st AL, [X]
d03f:    8a                     ld AL, [X]
d040:    41 01                  sub AL, AH
d042:    15 2b                  bnz L_d06f
d044:    d0 f8 00               ld B, 0xf800
d047:    55 26                  mov Y, B
d049:    90 07 ff               ld A, 0x07ff
d04c:    f7                     memcpy16

L_d04d:
d04d:    47 8c 01 00 00 d0 8a   memcmp 0x02, 0x0000, [R_d08a|0xd08a]
d054:    15 19                  bnz L_d06f
d056:    30 10 d4 d4            inc [R_d4d4|0xd4d4], #1
d05a:    91 d4 d4               ld A, [R_d4d4|0xd4d4]
d05d:    51 12 00 7d            sub B, A, 0x007d
d061:    17 cd                  bp L_d030
d063:    51 12 00 80            sub B, A, 0x0080
d067:    17 e4                  bp L_d04d
d069:    51 12 00 fd            sub B, A, 0x00fd
d06d:    17 c1                  bp L_d030

L_d06f:
d06f:    2e 2c f8 e1 8e         wpf1 0xf8, [R_e18e|0xe18e]
d074:    90 a0 7f               ld A, level15HandlerA|0xa07f
d077:    d7 fe                  mov IL15(P), A

R_d079:
d079:    71 d5 23               jmp R_d523

level15HandlerB:
d07c:    21 11                  dec AL, #2
d07e:    14 03                  bz L_d083
d080:    29                     dec AL, #1
d081:    15 04                  bnz L_d087

L_d083:
d083:    30 10 d0 8a            inc [R_d08a|0xd08a], #1

L_d087:
d087:    0a                     reti
d088:    73 f2                  jmp level15HandlerB

R_d08a:
d08a:    00
d08b:    00

R_d08c:
d08c:    d6 89 01 73            st Z, [0x0173]
d090:    d6 89 01 77            st Z, [0x0177]
d094:    34 0a                  srl A, #11
d096:    b1 d4 d0               st A, [R_d4d0|0xd4d0]
d099:    47 4d 00 1e 10 01 c5   memcpy 0x01, 0x1e, [A + 0x01c5]
d0a0:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d0a5:    47 4d 00 1e 10 01 c5   memcpy 0x01, 0x1e, [A + 0x01c5]
d0ac:    47 4d 00 1e 10 01 85   memcpy 0x01, 0x1e, [A + 0x0185]
d0b3:    d2 01 07               ld B, @[0x0107]
d0b6:    47 41 1f 01 85 20 36   memcpy 0x20, [R_0185|0x0185], [B + 0x36]
d0bd:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d0c2:    5d                     mov B, A
d0c3:    51 10 00 1c            sub A, A, 0x001c
d0c7:    67 9d fd 30 01 c6      memset AL, 0xfd, [B + 0x01c6]
d0cd:    28                     inc AL, #1
d0ce:    67 9d fd 30 01 a5      memset AL, 0xfd, [B + 0x01a5]
d0d4:    95 a1                  ld A, [S++]
d0d6:    5d                     mov B, A
d0d7:    51 10 00 1c            sub A, A, 0x001c
d0db:    67 9d fd 30 01 86      memset AL, 0xfd, [B + 0x0186]
d0e1:    47 4c 02 c9 cf c4 d2 96 memcpy 0x03, 0xc9cfc4, [R_d296|0xd296]
d0e9:    91 01 09               ld A, [DevicesPtr|0x0109]

L_d0ec:
d0ec:    d5 01                  ld B, [A++]
d0ee:    15 03                  bnz L_d0f3
d0f0:    71 d1 94               jmp R_d194

L_d0f3:
d0f3:    7e 01                  push {A}
d0f5:    55 37 00 05            mov Y, [B + 0x0005]
d0f9:    14 1a                  bz L_d115
d0fb:    16 2b                  blt L_d128
d0fd:    51 70 00 19            sub A, Y, 0x0019
d101:    16 25                  blt L_d128
d103:    35 60                  sll Y, #1
d105:    50 74 d1 5e            add X, Y, R_d15e|0xd15e
d109:    55 55 00 00            mov X, [X + 0x0000]
d10d:    14 06                  bz L_d115
d10f:    d6 35 00 05            st B, [X + 0x0005]
d113:    73 13                  jmp L_d128

L_d115:
d115:    d6 39 00 05            st B, [Z + 0x0005]
d119:    50 74 d1 5e            add X, Y, R_d15e|0xd15e
d11d:    d6 59 00 00            st X, [Z + 0x0000]
d121:    50 76 d1 2c            add Y, Y, R_d12c|0xd12c
d125:    79 d2 69               call R_d269

L_d128:
d128:    7f 01                  pop {A}
d12a:    73 c0                  jmp L_d0ec

R_d12c:
d12c:    d1 a0 b1               ld B, [0xa0b1]
d12f:    a0 b6                  st AL, 0xb6
d131:    a0 b2                  st AL, 0xb2
d133:    a0 cd                  st AL, 0xcd
d135:    a0 b3                  st AL, 0xb3
d137:    a0 c4                  st AL, 0xc4
d139:    a0 c5                  st AL, 0xc5
d13b:    a0 c6                  st AL, 0xc6
d13d:    a0 c8                  st AL, 0xc8
d13f:    c8                     ld BL, [A]
d140:    c8                     ld BL, [A]
d141:    a0 c9                  st AL, 0xc9
d143:    a0 c1                  st AL, 0xc1
d145:    a0 cb                  st AL, 0xcb
d147:    a0 b0                  st AL, 0xb0
d149:    a0 b7                  st AL, 0xb7
d14b:    a0 b8                  st AL, 0xb8
d14d:    a0 b9                  st AL, 0xb9
d14f:    a0 d2                  st AL, 0xd2
d151:    c4 c2                  ld BL, @[L_d115|0xd115]
d153:    a0 b1                  st AL, 0xb1
d155:    b0 cd d4               st A, 0xcdd4
d158:    d3 d4                  ld B, [R_d12c+2|0xd12e]
d15a:    c3 a0                  ld BL, [0xd0fc]
d15c:    c7                     unknown
d15d:    ce                     ld BL, [C]

R_d15e:
d15e:    <null bytes>


R_d194:
d194:    47 4c 02 c9 d3 d2 d2 96 memcpy 0x03, 0xc9d3d2, [R_d296|0xd296]
d19c:    91 01 0b               ld A, [0x010b]
d19f:    30 01                  inc A, #2

R_d1a1:
d1a1:    d1 d5 21               ld B, [R_d521|0xd521]
d1a4:    30 21                  inc B, #2
d1a6:    59                     sub B, A
d1a7:    19 03                  ble L_d1ac
d1a9:    71 d1 e5               jmp R_d1e5

L_d1ac:
d1ac:    d5 01                  ld B, [A++]
d1ae:    14 f1                  bz R_d1a1
d1b0:    7e 01                  push {A}
d1b2:    47 8d 01 79 a0 20 1b   memcmp 0x02, 0x79a0, [B + 0x1b]
d1b9:    14 23                  bz L_d1de
d1bb:    47 8d 01 00 a0 20 1b   memcmp 0x02, 0x00a0, [B + 0x1b]
d1c2:    15 08                  bnz L_d1cc
d1c4:    90 00 00               ld A, 0x0000
d1c7:    b5 28 1b               st A, [B + 0x1b]
d1ca:    73 12                  jmp L_d1de

L_d1cc:
d1cc:    85 28 1b               ld AL, [B + 0x1b]
d1cf:    14 0d                  bz L_d1de
d1d1:    a3 10                  st AL, [R_d1e3|0xd1e3]
d1d3:    d6 39 00 1b            st B, [Z + 0x001b]
d1d7:    55 76 d1 e3            mov Y, R_d1e3|0xd1e3
d1db:    79 d2 69               call R_d269

L_d1de:
d1de:    7f 01                  pop {A}
d1e0:    71 d1 a1               jmp R_d1a1

R_d1e3:
d1e3:    a0 a0                  st AL, 0xa0

R_d1e5:
d1e5:    47 4c 02 d0 c4 b0 d2 96 memcpy 0x03, 0xd0c4b0, [R_d296|0xd296]
d1ed:    91 01 0b               ld A, [0x010b]
d1f0:    30 01                  inc A, #2

L_d1f2:
d1f2:    d1 d5 21               ld B, [R_d521|0xd521]
d1f5:    30 21                  inc B, #2
d1f7:    59                     sub B, A
d1f8:    19 03                  ble L_d1fd
d1fa:    71 d3 89               jmp R_d389

L_d1fd:
d1fd:    d5 01                  ld B, [A++]
d1ff:    14 f1                  bz L_d1f2
d201:    7e 01                  push {A}
d203:    55 37 00 1d            mov Y, [B + 0x001d]
d207:    52 70 ff f0            and A, Y, 0xfff0
d20b:    15 2a                  bnz L_d237
d20d:    77 76 00 03            div Y, Y, 0x0003
d211:    50 74 d2 54            add X, Y, R_d254|0xd254
d215:    55 55 00 00            mov X, [X + 0x0000]
d219:    14 06                  bz L_d221
d21b:    d6 35 00 1d            st B, [X + 0x001d]
d21f:    73 12                  jmp L_d233

L_d221:
d221:    d6 39 00 1d            st B, [Z + 0x001d]
d225:    50 74 d2 54            add X, Y, R_d254|0xd254
d229:    d6 59 00 00            st X, [Z + 0x0000]
d22d:    50 76 d2 3f            add Y, Y, R_d23f|0xd23f
d231:    7b 36                  call R_d269

L_d233:
d233:    7f 01                  pop {A}
d235:    73 bb                  jmp L_d1f2

L_d237:
d237:    47 9d 01 00 20 1d      memset 0x02, 0x00, [B + 0x1d]
d23d:    73 f4                  jmp L_d233

R_d23f:
d23f:    b0 b0 a0               st A, 0xb0a0
d242:    b0 b1 a0               st A, 0xb1a0
d245:    b0 b2 a0               st A, 0xb2a0
d248:    b0 b3 a0               st A, 0xb3a0
d24b:    b0 b4 a0               st A, 0xb4a0
d24e:    b0 b5 a0               st A, 0xb5a0
d251:    b0 b6 a0               st A, 0xb6a0

R_d254:
d254:    <null bytes>


R_d269:
d269:    d6 89 d2 7f            st Z, [R_d27f|0xd27f]
d26d:    47 48 01 60 d2 99      memcpy 0x02, [Y], [R_d299|0xd299]
d273:    7b 30                  call L_d2a5
d275:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d27a:    66 02                  jsys Syscall_02

LOS_DiskNum:
d27c:    01                         DiskNum = (0x1)
d27d:    d2 90                      Filename = R_d290

R_d27f:
d27f:    00 00                      Buffer = (0x0)
d281:    01                         arg4 = (0x1)
d282:    5e                     mov Z, A
d283:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d288:    2e 0c 70 01 85         wpf 0x70, [R_0185|0x0185]
d28d:    30 80                  inc Z, #1
d28f:    09                     ret

R_d290:
d290:    c0 d3                  ld BL, 0xd3
d292:    d9                     ld B, [B]
d293:    d3 ae                  ld B, [0xd243]
d295:    c0 a0                  ld BL, 0xa0
d297:    a0 a0                  st AL, 0xa0

R_d299:
d299:    a0 a0                  st AL, 0xa0
d29b:    a0 a0                  st AL, 0xa0
d29d:    a0 a0                  st AL, 0xa0
d29f:    a0 a0                  st AL, 0xa0
d2a1:    a0 a0                  st AL, 0xa0
d2a3:    a0 a0                  st AL, 0xa0

L_d2a5:
d2a5:    7e 27                  push {B, X, Y, Z}
d2a7:    51 90 78 00            sub A, Z, 0x7800
d2ab:    16 28                  blt R_d2d5
d2ad:    3a                     clr A, #0
d2ae:    45 81                  mov AL, ZH
d2b0:    07                     rl
d2b1:    34 02                  srl A, #3
d2b3:    71 d3 37               jmp R_d337

R_d2b6:
d2b6:    b5 a2                  st A, [--S]
d2b8:    50 12 01 c5            add B, A, 0x01c5
d2bc:    3a                     clr A, #0
d2bd:    89                     ld AL, [B]
d2be:    51 10 00 fd            sub A, A, 0x00fd
d2c2:    15 69                  bnz L_d32d
d2c4:    f5 a2                  st B, [--S]
d2c6:    60 00 1e               ld X, 0x001e
d2c9:    55 76 01 44            mov Y, 0x0144

L_d2cd:
d2cd:    85 61                  ld AL, [Y++]
d2cf:    28                     inc AL, #1
d2d0:    15 17                  bnz L_d2e9
d2d2:    3f                     dec X
d2d3:    17 f8                  bp L_d2cd

R_d2d5:
d2d5:    47 4c 01 d4 f5 d4 f1   memcpy 0x02, R_d4f5|0xd4f5, [R_d4f1|0xd4f1]
d2dc:    d0 d4 eb               ld B, R_d4eb|0xd4eb
d2df:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d2e4:    66 10                  jsys Syscall_DoFileOp
d2e6:    05                     di

L_d2e7:
d2e7:    73 fe                  jmp L_d2e7

L_d2e9:
d2e9:    31 60                  dec Y, #1
d2eb:    29                     dec AL, #1
d2ec:    55 64                  mov X, Y
d2ee:    d0 01 44               ld B, 0x0144
d2f1:    51 42                  sub B, X
d2f3:    32 40                  clr X, #0

L_d2f5:
d2f5:    2d                     sll AL, #1
d2f6:    11 03                  bnc L_d2fb
d2f8:    3e                     inc X
d2f9:    73 fa                  jmp L_d2f5

L_d2fb:
d2fb:    35 22                  sll B, #3
d2fd:    50 42                  add B, X
d2ff:    95 a1                  ld A, [S++]
d301:    e8                     st BL, [A]
d302:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d307:    e8                     st BL, [A]
d308:    e5 08 c0               st BL, [A + -0x40]
d30b:    92 01 07               ld A, @[0x0107]
d30e:    47 41 1f 01 85 00 36   memcpy 0x20, [R_0185|0x0185], [A + 0x36]
d315:    80 80                  ld AL, 0x80
d317:    07                     rl

L_d318:
d318:    3f                     dec X
d319:    16 04                  blt L_d31f
d31b:    26 10                  rrc AL, #1
d31d:    73 f9                  jmp L_d318

L_d31f:
d31f:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d324:    cb                     ld BL, [Y]
d325:    43 13                  or BL, AL
d327:    eb                     st BL, [Y]
d328:    2e 0c 70 01 c5         wpf 0x70, [R_01c5|0x01c5]

L_d32d:
d32d:    95 a1                  ld A, [S++]
d32f:    c0 00                  ld BL, 0x00
d331:    15 11                  bnz L_d344
d333:    20 30                  inc BL, #1
d335:    e3 f9                  st BL, [0xd330]

R_d337:
d337:    38                     inc A, #1
d338:    5d                     mov B, A
d339:    35 2a                  sll B, #11
d33b:    51 32 78 00            sub B, B, 0x7800
d33f:    19 03                  ble L_d344
d341:    71 d2 b6               jmp R_d2b6

L_d344:
d344:    2a                     clr AL, #0
d345:    a3 e9                  st AL, [0xd330]
d347:    7f 27                  pop {B, X, Y, Z}
d349:    09                     ret

R_d34a:
d34a:    7e 41                  push {X}
d34c:    60 00 1e               ld X, 0x001e
d34f:    55 76 01 44            mov Y, 0x0144

L_d353:
d353:    85 61                  ld AL, [Y++]
d355:    28                     inc AL, #1
d356:    15 06                  bnz L_d35e
d358:    3f                     dec X
d359:    17 f8                  bp L_d353
d35b:    71 d2 d5               jmp R_d2d5

L_d35e:
d35e:    31 60                  dec Y, #1
d360:    29                     dec AL, #1
d361:    55 64                  mov X, Y
d363:    d0 01 44               ld B, 0x0144
d366:    51 42                  sub B, X
d368:    32 40                  clr X, #0

L_d36a:
d36a:    2d                     sll AL, #1
d36b:    11 03                  bnc L_d370
d36d:    3e                     inc X
d36e:    73 fa                  jmp L_d36a

L_d370:
d370:    35 22                  sll B, #3
d372:    50 42                  add B, X
d374:    7e 21                  push {B}
d376:    80 80                  ld AL, 0x80
d378:    07                     rl

L_d379:
d379:    3f                     dec X
d37a:    16 04                  blt L_d380
d37c:    26 10                  rrc AL, #1
d37e:    73 f9                  jmp L_d379

L_d380:
d380:    cb                     ld BL, [Y]
d381:    43 13                  or BL, AL
d383:    eb                     st BL, [Y]
d384:    7f 21                  pop {B}
d386:    7f 41                  pop {X}
d388:    09                     ret

R_d389:
d389:    91 01 03               ld A, [CurrentProcess|0x0103]
d38c:    95 08 08               ld A, [A + 0x08]
d38f:    95 08 05               ld A, [A + 0x05]
d392:    b2 01 26               st A, @[EarlyInitDevicesPtr|0x0126]
d395:    91 01 6e               ld A, [0x016e]
d398:    47 42 14 d2 54 00      memcpy 0x15, [R_d254|0xd254], [A]
d39e:    2e 2c 02 d4 cb         wpf1 0x02, [R_d4cb|0xd4cb]
d3a3:    2e 2c 03 d4 cb         wpf1 0x03, [R_d4cb|0xd4cb]
d3a8:    91 d4 c6               ld A, [L_d4c5+1|0xd4c6]
d3ab:    95 08 ff               ld A, [A + -0x1]
d3ae:    55 82                  mov B, Z
d3b0:    f1 d4 d2               st B, [R_d4d2|0xd4d2]
d3b3:    59                     sub B, A
d3b4:    10 02                  bc L_d3b8
d3b6:    55 80                  mov A, Z

L_d3b8:
d3b8:    d1 01 73               ld B, [0x0173]
d3bb:    50 32 1f ff            add B, B, 0x1fff
d3bf:    59                     sub B, A
d3c0:    17 07                  bp L_d3c9
d3c2:    91 01 73               ld A, [0x0173]
d3c5:    50 10 1f ff            add A, A, 0x1fff

L_d3c9:
d3c9:    52 10 f8 00            and A, A, 0xf800
d3cd:    50 10 08 00            add A, A, 0x0800
d3d1:    b1 01 1a               st A, [0x011a]
d3d4:    d0 80 00               ld B, 0x8000
d3d7:    51 20                  sub A, B
d3d9:    17 03                  bp L_d3de
d3db:    71 d2 d5               jmp R_d2d5

L_d3de:
d3de:    78 10 08 00            mul A, A, 0x0800
d3e2:    f1 01 7f               st B, [0x017f]
d3e5:    05                     di
d3e6:    e1 f2 0f               st BL, [0xf20f]
d3e9:    04                     ei
d3ea:    3a                     clr A, #0
d3eb:    45 81                  mov AL, ZH
d3ed:    34 02                  srl A, #3
d3ef:    28                     inc AL, #1
d3f0:    50 12 01 c5            add B, A, 0x01c5

L_d3f4:
d3f4:    f5 a2                  st B, [--S]
d3f6:    3a                     clr A, #0
d3f7:    89                     ld AL, [B]
d3f8:    51 10 00 fd            sub A, A, 0x00fd
d3fc:    14 22                  bz L_d420
d3fe:    89                     ld AL, [B]
d3ff:    a5 a2                  st AL, [--S]
d401:    80 fd                  ld AL, 0xfd
d403:    a9                     st AL, [B]
d404:    3a                     clr A, #0
d405:    85 a1                  ld AL, [S++]
d407:    5c                     mov Y, A
d408:    5b                     mov X, A
d409:    52 54 00 07            and X, X, 0x0007
d40d:    34 62                  srl Y, #3
d40f:    50 76 01 44            add Y, Y, 0x0144
d413:    80 7f                  ld AL, 0x7f
d415:    06                     sl

L_d416:
d416:    3f                     dec X
d417:    16 04                  blt L_d41d
d419:    26 10                  rrc AL, #1
d41b:    73 f9                  jmp L_d416

L_d41d:
d41d:    cb                     ld BL, [Y]
d41e:    4a                     and BL, AL
d41f:    eb                     st BL, [Y]

L_d420:
d420:    80 00                  ld AL, 0x00
d422:    15 09                  bnz L_d42d
d424:    28                     inc AL, #1
d425:    a3 fa                  st AL, [L_d420+1|0xd421]
d427:    d5 a1                  ld B, [S++]
d429:    30 20                  inc B, #1
d42b:    73 c7                  jmp L_d3f4

L_d42d:
d42d:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d432:    61 d4 d0               ld X, [R_d4d0|0xd4d0]
d435:    50 54 01 a5            add X, X, 0x01a5
d439:    79 d3 4a               call R_d34a
d43c:    e5 41                  st BL, [X++]
d43e:    79 d3 4a               call R_d34a
d441:    e5 41                  st BL, [X++]
d443:    79 d3 4a               call R_d34a
d446:    e5 41                  st BL, [X++]
d448:    79 d3 4a               call R_d34a
d44b:    ea                     st BL, [X]
d44c:    2e 0c 70 01 a5         wpf 0x70, [R_01a5|0x01a5]
d451:    91 01 73               ld A, [0x0173]
d454:    b3 23                  st A, [0xd479]
d456:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
d459:    a3 1b                  st AL, [0xd476]
d45b:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d460:    2e 1c 70 01 85         rpf 0x70, [R_0185|0x0185]
d465:    2e 1c 70 01 c5         rpf 0x70, [R_01c5|0x01c5]
d46a:    92 01 07               ld A, @[0x0107]
d46d:    47 41 1f 01 85 00 36   memcpy 0x20, [R_0185|0x0185], [A + 0x36]
d474:    66 02                  jsys Syscall_02
d476:    00                         DiskNum = (0x0)
d477:    d4 d6                      Filename = R_d4d5+1
d479:    00 00                      Buffer = (0x0)
d47b:    01                         arg4 = (0x1)
d47c:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d481:    91 01 44               ld A, [0x0144]
d484:    52 10 ff fe            and A, A, 0xfffe
d488:    b1 01 44               st A, [0x0144]
d48b:    91 01 46               ld A, [0x0146]
d48e:    d1 d4 ce               ld B, [R_d4cd+1|0xd4ce]
d491:    52 20                  and A, B
d493:    b1 01 46               st A, [0x0146]
d496:    2e 0c 78 01 85         wpf 0x78, [R_0185|0x0185]
d49b:    47 8c 01 00 fc d4 d4   memcmp 0x02, 0x00fc, [R_d4d4|0xd4d4]
d4a2:    17 11                  bp L_d4b5
d4a4:    47 8c 01 00 81 d4 d4   memcmp 0x02, 0x0081, [R_d4d4|0xd4d4]
d4ab:    14 11                  bz L_d4be
d4ad:    91 d4 d4               ld A, [R_d4d4|0xd4d4]
d4b0:    b1 01 7d               st A, [0x017d]
d4b3:    73 10                  jmp L_d4c5

L_d4b5:
d4b5:    47 4c 01 01 00 01 7d   memcpy 0x02, 0x0100, [0x017d]
d4bc:    73 07                  jmp L_d4c5

L_d4be:
d4be:    47 4c 01 00 80 01 7d   memcpy 0x02, 0x0080, [0x017d]

L_d4c5:
d4c5:    90 00 00               ld A, 0x0000
d4c8:    75 08 fe               jmp [A + -0x2]

R_d4cb:
d4cb:    00

R_d4cc:
d4cc:    0f                     rsys

R_d4cd:
d4cd:    1f 00                  branch_unlocked L_d4cf

L_d4cf:
d4cf:    00                     HALT

R_d4d0:
d4d0:    00                     HALT
d4d1:    00                     HALT

R_d4d2:
d4d2:    00                     HALT
d4d3:    00                     HALT

R_d4d4:
d4d4:    00                     HALT

R_d4d5:
d4d5:    1e c0                  unknown_branch L_d497
d4d7:    d3 d9                  ld B, [0xd4b2]
d4d9:    d3 ae                  ld B, [0xd489]
d4db:    cf                     ld BL, [P]
d4dc:    d3 c5                  ld B, [0xd4a3]
d4de:    c7                     unknown
d4df:    b1 a0 a0               st A, [0xa0a0]
d4e2:    a0 a0                  st AL, 0xa0
d4e4:    a0 a0                  st AL, 0xa0
d4e6:    a0 a0                  st AL, 0xa0
d4e8:    a0 a0                  st AL, 0xa0
d4ea:    a0 00                  st AL, 0x00
d4ec:    81 00 02               ld AL, [0x0002]
d4ef:    00                     HALT
d4f0:    51 e1 91 00            sub A, P, [0x9100]
d4f4:    00                     HALT

R_d4f5:
d4f5:    42, "OPSYS OVERSIZE-LOAD PROCESS DISCONTINUED\r\n"

R_d521:
d521:    00
d522:    00

R_d523:
d523:    79 a4 8f               call R_a48f
d526:    61 01 26               ld X, [EarlyInitDevicesPtr|0x0126]

L_d529:
d529:    95 41                  ld A, [X++]
d52b:    14 09                  bz L_d536
d52d:    95 08 0e               ld A, [A + 0x0e]
d530:    14 f7                  bz L_d529
d532:    7d 00                  call [A]
d534:    73 f3                  jmp L_d529

L_d536:
d536:    04                     ei
d537:    d0 e1 e2               ld B, R_e1e2|0xe1e2	 ; LOS 7.1 - E
d53a:    7b 12                  call LOS_WriteCRT
d53c:    81 e1 fd               ld AL, [LOS_Autoboot|0xe1fd]
d53f:    14 19                  bz LOS_Prompt
d541:    71 d6 12               jmp R_d612

LOS_ReadCRT:
    ; Small wrapper around the syscalls
d544:    d0 e1 9f               ld B, R_e19f|0xe19f
d547:    66 10                  jsys Syscall_DoFileOp
d549:    66 08                  jsys Syscall_Flush
d54b:    e1 9f                      op_struct = R_e19f
d54d:    09                     ret

LOS_WriteCRT:
    ; Small wrapper around the syscalls
d54e:    f3 a1                  st B, [R_d4f1|0xd4f1]
d550:    d0 d4 eb               ld B, R_d4eb|0xd4eb
d553:    66 10                  jsys Syscall_DoFileOp
d555:    66 08                  jsys Syscall_Flush
d557:    d4 eb                      op_struct = R_d4eb
d559:    09                     ret

LOS_Prompt:
d55a:    d0 e1 b0               ld B, R_e1b0|0xe1b0	 ; "\r\nNAME="
d55d:    7b ef                  call LOS_WriteCRT
d55f:    7b e3                  call LOS_ReadCRT
d561:    d1 e1 91               ld B, [R_e191|0xe191]
d564:    47 48 16 20 e2 14      memcpy 0x17, [B], [LOS_FilePath|0xe214]
d56a:    55 76 e2 16            mov Y, LOS_FilePath+2|0xe216
d56e:    d0 00 15               ld B, 0x0015

L_d571:
d571:    55 98 00 e1            mov Z, 0x00e1
d575:    3a                     clr A, #0
d576:    85 61                  ld AL, [Y++]
d578:    51 08                  sub Z, A
d57a:    16 0f                  blt L_d58b
d57c:    55 98 00 fa            mov Z, 0x00fa
d580:    51 08                  sub Z, A
d582:    18 07                  bgt L_d58b
d584:    52 10 00 df            and A, A, 0x00df
d588:    a5 68 ff               st AL, [Y + -0x1]

L_d58b:
d58b:    21 30                  dec BL, #1
d58d:    18 e2                  bgt L_d571
d58f:    d0 e1 b9               ld B, R_e1b9|0xe1b9	 ; "DISK="
d592:    7b ba                  call LOS_WriteCRT
d594:    7b ae                  call LOS_ReadCRT
d596:    d1 e1 91               ld B, [R_e191|0xe191]
d599:    99                     ld A, [B]
d59a:    46 81 84 20 02 e1 fb   unkbig8(8, 1) [B + 0x02], [R_e1fb|0xe1fb]
d5a1:    12 b7                  bn LOS_Prompt
d5a3:    46 00 2c 32 d2 7c      unkbig2(0, 0) 0x32, [LOS_DiskNum|0xd27c]
d5a9:    16 05                  blt L_d5b0
d5ab:    90 00 32               ld A, 0x0032
d5ae:    73 2a                  jmp L_d5da

L_d5b0:
d5b0:    46 00 2c 28 d2 7c      unkbig2(0, 0) 0x28, [LOS_DiskNum|0xd27c]
d5b6:    16 05                  blt L_d5bd
d5b8:    90 00 28               ld A, 0x0028
d5bb:    73 1d                  jmp L_d5da

L_d5bd:
d5bd:    46 00 2c 14 d2 7c      unkbig2(0, 0) 0x14, [LOS_DiskNum|0xd27c]
d5c3:    16 05                  blt L_d5ca
d5c5:    90 00 14               ld A, 0x0014
d5c8:    73 10                  jmp L_d5da

L_d5ca:
d5ca:    46 00 2c 0a d2 7c      unkbig2(0, 0) 0x0a, [LOS_DiskNum|0xd27c]
d5d0:    16 05                  blt L_d5d7
d5d2:    90 00 0a               ld A, 0x000a
d5d5:    73 03                  jmp L_d5da

L_d5d7:
d5d7:    90 00 00               ld A, 0x0000

L_d5da:
d5da:    50 01 e1 fb            add A, A, [R_e1fb|0xe1fb]
d5de:    a1 d2 7c               st AL, [LOS_DiskNum|0xd27c]
d5e1:    d0 e1 a9               ld B, R_e1a9|0xe1a9	 ; "CODE="
d5e4:    79 d5 4e               call LOS_WriteCRT
d5e7:    92 01 09               ld A, @[DevicesPtr|0x0109]
d5ea:    c8                     ld BL, [A]
d5eb:    55 26                  mov Y, B
d5ed:    c0 08                  ld BL, 0x08
d5ef:    43 73                  or BL, YL
d5f1:    e8                     st BL, [A]
d5f2:    79 d5 44               call LOS_ReadCRT
d5f5:    92 01 09               ld A, @[DevicesPtr|0x0109]
d5f8:    c8                     ld BL, [A]
d5f9:    55 26                  mov Y, B
d5fb:    c0 f7                  ld BL, 0xf7
d5fd:    42 73                  and BL, YL
d5ff:    e8                     st BL, [A]
d600:    d1 e1 91               ld B, [R_e191|0xe191]
d603:    99                     ld A, [B]
d604:    14 0c                  bz R_d612
d606:    46 81 84 20 02 e1 f9   unkbig8(8, 1) [B + 0x02], [LOS_DiskCode|0xe1f9]
d60d:    13 03                  bnn R_d612
d60f:    71 d5 5a               jmp LOS_Prompt

R_d612:
    ; Find our user-supplied DISK= in the devices table
d612:    55 89 01 09            mov Z, [DevicesPtr|0x0109]	 ; table of all devices
d616:    30 81                  inc Z, #2	 ; Skip over CRT0 entry
d618:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
d61b:    a1 d6 c6               st AL, [LOS_DiskNum2|0xd6c6]
d61e:    66 14                  jsys Syscall_CheckDiskStatus	 ; Returns status in B, but we drop it

LOS_FindDiskDevice:
d620:    95 81                  ld A, [Z++]	 ; Fetch device_obj from the table
d622:    15 03                  bnz L_d627	 ; If hit the terminator, go back to prompt
d624:    71 d5 5a               jmp LOS_Prompt

L_d627:
d627:    c5 08 02               ld BL, [A + 0x02]	 ; device_obj.disk_number
d62a:    45 32                  mov BH, BL
d62c:    c1 d2 7c               ld BL, [LOS_DiskNum|0xd27c]	 ; Compare with the user-supplied number
d62f:    41 32                  sub BH, BL
d631:    15 ed                  bnz LOS_FindDiskDevice	 ; If not found, check the next pointer
d633:    d1 e1 f9               ld B, [LOS_DiskCode|0xe1f9]
d636:    f5 08 17               st B, [A + 0x17]
d639:    91 e2 14               ld A, [LOS_FilePath|0xe214]
d63c:    a3 02                  st AL, [0xd640]
d63e:    47 20 00 ae e2 16 e2 09 memchr 0x01, 0xae, [LOS_FilePath+2|0xe216], [LOS_FileName|0xe209]	 ; Look for '.' - directory separator
d646:    12 37                  bn L_d67f	 ; If not found, just open the file
d648:    80 a0                  ld AL, 0xa0
d64a:    ac                     st AL, [Z]
d64b:    30 60                  inc Y, #1
d64d:    47 48 09 60 e1 fe      memcpy 0x0a, [Y], [LOS_FilePart|0xe1fe]
d653:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
d656:    d0 e2 09               ld B, LOS_FileName|0xe209
d659:    66 0e                  jsys Syscall_OpenFile?

R_d65b:
d65b:    00 00                      arg1 = L_0000
d65d:    15 03                  bnz L_d662
d65f:    71 d5 5a               jmp LOS_Prompt

L_d662:
d662:    b3 15                  st A, [LOS_DirHandle|0xd679]
d664:    85 08 06               ld AL, [A + 0x06]	 ; File type
d667:    c0 0f                  ld BL, 0x0f
d669:    4a                     and BL, AL
d66a:    21 34                  dec BL, #5	 ; 5 is a directory
d66c:    14 03                  bz L_d671
d66e:    71 d5 5a               jmp LOS_Prompt

L_d671:
d671:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
d674:    d0 e1 fe               ld B, LOS_FilePart|0xe1fe
d677:    66 4f                  jsys Syscall_OpenFileInDir

LOS_DirHandle:
d679:    00 00                      arg1 = (0x0)

R_d67b:
d67b:    00 00                      arg2 = L_0000
d67d:    73 0f                  jmp L_d68e

L_d67f:
d67f:    d0 e2 09               ld B, LOS_FileName|0xe209
d682:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
d685:    66 0e                  jsys Syscall_OpenFile?

R_d687:
d687:    00 00                      arg1 = L_0000
d689:    15 03                  bnz L_d68e
d68b:    71 d5 5a               jmp LOS_Prompt

L_d68e:
    ; File is open here
d68e:    b3 34                  st A, [LOS_FileHandle|0xd6c4]
d690:    85 08 06               ld AL, [A + 0x06]
d693:    c0 0f                  ld BL, 0x0f
d695:    4a                     and BL, AL
d696:    21 32                  dec BL, #3
d698:    15 03                  bnz L_d69d
d69a:    71 d7 1e               jmp R_d71e

L_d69d:
d69d:    21 30                  dec BL, #1
d69f:    14 03                  bz L_d6a4
d6a1:    71 d5 5a               jmp LOS_Prompt

L_d6a4:
d6a4:    7b 15                  call R_d6bb
d6a6:    55 89 e1 91            mov Z, [R_e191|0xe191]
d6aa:    95 88 02               ld A, [Z + 0x02]
d6ad:    d0 00 4c               ld B, 0x004c
d6b0:    59                     sub B, A
d6b1:    15 1f                  bnz L_d6d2
d6b3:    95 88 1f               ld A, [Z + 0x1f]
d6b6:    b1 e1 8a               st A, [R_e18a|0xe18a]
d6b9:    73 31                  jmp L_d6ec

R_d6bb:
d6bb:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d6c0:    66 4c                  jsys Syscall_4c
d6c2:    01 90                      size = (0x190)

LOS_FileHandle:
d6c4:    00 00                      fileHandle = (0x0)

LOS_DiskNum2:
d6c6:    00                         disknum = (0x0)

R_d6c7:
d6c7:    00 00                      SectorNum = (0x0)

R_d6c9:
d6c9:    00 00                      Buffer = L_0000
d6cb:    01                         arg6 = (0x1)
d6cc:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d6d1:    09                     ret

L_d6d2:
d6d2:    47 02 e1 8a 08         unkblk0 [R_e18a|0xe18a], [Z]
d6d7:    13 03                  bnn L_d6dc
d6d9:    71 cf 46               jmp Start

L_d6dc:
d6dc:    10 0e                  bc L_d6ec
d6de:    47 8e 00 84 08         memcmp 0x01, 0x84, [Z]
d6e3:    14 0d                  bz L_d6f2
d6e5:    47 8e 00 80 08         memcmp 0x01, 0x80, [Z]
d6ea:    15 e6                  bnz L_d6d2

L_d6ec:
d6ec:    30 10 d6 c7            inc [R_d6c7|0xd6c7], #1
d6f0:    73 b2                  jmp L_d6a4

L_d6f2:
d6f2:    05                     di
d6f3:    c6                     acquire_semaphore
d6f4:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d6f9:    2e 2c 78 d4 cd         wpf1 0x78, [R_d4cd|0xd4cd]
d6fe:    32 20                  clr B, #0
d700:    2f 28                  ld_isr B
d702:    2f 04                  dma_mode #0
d704:    f1 00 6c               st B, [0x006c]
d707:    f1 00 fc               st B, [0x00fc]
d70a:    f1 00 ae               st B, [0x00ae]
d70d:    e1 f2 0a               st BL, [0xf20a]
d710:    e1 f2 0f               st BL, [0xf20f]
d713:    31 20                  dec B, #1
d715:    e1 f2 0d               st BL, [0xf20d]
d718:    5c                     mov Y, A
d719:    91 e1 8c               ld A, [R_e18c|0xe18c]
d71c:    75 60                  jmp [Y]

R_d71e:
d71e:    d0 e1 f4               ld B, R_e1f4|0xe1f4	 ; Clear terminal
d721:    79 d5 4e               call LOS_WriteCRT
d724:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
d729:    79 d8 21               call R_d821
d72c:    91 e1 93               ld A, [R_e193|0xe193]
d72f:    47 4a 63 60            memcpy 0x64, [Y], [A]
d733:    47 8d 01 01 00 60 00   memcmp 0x02, 0x0100, [Y + 0x00]
d73a:    14 0e                  bz L_d74a
d73c:    d0 e1 c0               ld B, R_e1c0|0xe1c0
d73f:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
d744:    79 d5 4e               call LOS_WriteCRT
d747:    71 d5 5a               jmp LOS_Prompt

L_d74a:
d74a:    47 9c c7 00 01 00      memset 0xc8, 0x00, [SyscallVector|0x0100]
d750:    47 9c 5a 00 01 c8      memset 0x5b, 0x00, [L_01c8|0x01c8]
d756:    80 71                  ld AL, 0x71
d758:    a1 01 00               st AL, [SyscallVector|0x0100]
d75b:    80 ff                  ld AL, 0xff
d75d:    a1 01 1c               st AL, [0x011c]
d760:    a1 01 1f               st AL, [0x011f]
d763:    a1 01 3b               st AL, [0x013b]
d766:    a1 01 3c               st AL, [0x013c]
d769:    a1 01 3d               st AL, [0x013d]
d76c:    90 01 f6               ld A, 0x01f6
d76f:    b1 01 07               st A, [0x0107]
d772:    80 01                  ld AL, 0x01
d774:    a1 01 25               st AL, [0x0125]
d777:    95 68 06               ld A, [Y + 0x06]
d77a:    b1 01 42               st A, [0x0142]
d77d:    85 68 02               ld AL, [Y + 0x02]
d780:    a1 01 05               st AL, [0x0105]
d783:    85 68 04               ld AL, [Y + 0x04]
d786:    a1 01 70               st AL, [0x0170]
d789:    80 3c                  ld AL, 0x3c
d78b:    a1 01 15               st AL, [0x0115]
d78e:    47 9c 6f fd 01 85      memset 0x70, 0xfd, [R_0185|0x0185]
d794:    2e 4c 06 01 e5         wpf32 0x06, [R_01e5|0x01e5]
d799:    2e 4c 07 01 e5         wpf32 0x07, [R_01e5|0x01e5]
d79e:    95 68 0a               ld A, [Y + 0x0a]
d7a1:    38                     inc A, #1
d7a2:    3d                     sll A, #1
d7a3:    50 01 01 07            add A, A, [0x0107]
d7a7:    b1 01 09               st A, [DevicesPtr|0x0109]
d7aa:    32 20                  clr B, #0
d7ac:    95 68 0c               ld A, [Y + 0x0c]
d7af:    58                     add B, A
d7b0:    95 68 0e               ld A, [Y + 0x0e]
d7b3:    58                     add B, A
d7b4:    95 68 12               ld A, [Y + 0x12]
d7b7:    58                     add B, A
d7b8:    95 68 18               ld A, [Y + 0x18]
d7bb:    58                     add B, A
d7bc:    95 68 1a               ld A, [Y + 0x1a]
d7bf:    58                     add B, A
d7c0:    95 68 1c               ld A, [Y + 0x1c]
d7c3:    58                     add B, A
d7c4:    95 68 22               ld A, [Y + 0x22]
d7c7:    58                     add B, A
d7c8:    95 68 20               ld A, [Y + 0x20]
d7cb:    58                     add B, A
d7cc:    30 21                  inc B, #2
d7ce:    35 20                  sll B, #1
d7d0:    91 01 09               ld A, [DevicesPtr|0x0109]
d7d3:    58                     add B, A
d7d4:    55 28                  mov Z, B
d7d6:    30 81                  inc Z, #2
d7d8:    d6 89 01 64            st Z, [0x0164]
d7dc:    47 9e 27 00 08         memset 0x28, 0x00, [Z]
d7e1:    50 98 00 28            add Z, Z, 0x0028
d7e5:    47 4e 01 ff ff 08      memcpy 0x02, 0xffff, [Z]
d7eb:    30 81                  inc Z, #2
d7ed:    d6 89 01 0b            st Z, [0x010b]
d7f1:    90 00 4a               ld A, 0x004a
d7f4:    b5 81                  st A, [Z++]
d7f6:    31 01                  dec A, #2
d7f8:    67 9e 00 08            memset AL, 0x00, [Z]
d7fc:    50 08                  add Z, A
d7fe:    d6 89 01 16            st Z, [0x0116]
d802:    47 9e 79 00 08         memset 0x7a, 0x00, [Z]
d807:    50 98 00 7a            add Z, Z, 0x007a
d80b:    d6 89 01 68            st Z, [0x0168]
d80f:    95 68 10               ld A, [Y + 0x10]
d812:    38                     inc A, #1
d813:    3d                     sll A, #1
d814:    67 9e 00 08            memset AL, 0x00, [Z]
d818:    50 08                  add Z, A
d81a:    50 76 00 44            add Y, Y, 0x0044
d81e:    71 d8 c4               jmp R_d8c4

R_d821:
d821:    2a                     clr AL, #0
d822:    a1 01 41               st AL, [Timeout|0x0141]
d825:    55 67 e1 91            mov Y, [R_e191|0xe191]
d829:    79 d6 bb               call R_d6bb

L_d82c:
d82c:    91 d6 c4               ld A, [LOS_FileHandle|0xd6c4]
d82f:    47 82 01 d6 c7 00      memcmp 0x02, [R_d6c7|0xd6c7], [A]
d835:    19 35                  ble L_d86c
d837:    91 e1 91               ld A, [R_e191|0xe191]
d83a:    d1 e1 8f               ld B, [R_e18e+1|0xe18f]
d83d:    47 4a c7 02            memcpy 0xc8, [A], [B]
d841:    47 45 c7 10 00 c8 30 00 c8 memcpy 0xc8, [A + 0x00c8], [B + 0x00c8]
d84a:    d6 67 e1 9d            st Y, [R_e19d|0xe19d]
d84e:    46 22 10 e1 99 e1 9c   subbig(2, 2) [R_e199|0xe199], [R_e19c|0xe19c]
d855:    55 67 e1 9d            mov Y, [R_e19d|0xe19d]
d859:    30 10 d6 c7            inc [R_d6c7|0xd6c7], #1
d85d:    79 d6 bb               call R_d6bb
d860:    09                     ret

R_d861:
d861:    2a                     clr AL, #0
d862:    a1 01 41               st AL, [Timeout|0x0141]
d865:    91 e1 91               ld A, [R_e191|0xe191]
d868:    51 60                  sub A, Y
d86a:    18 c0                  bgt L_d82c

L_d86c:
d86c:    09                     ret

R_d86d:
d86d:    90 e3 49               ld A, R_e349|0xe349

L_d870:
d870:    47 8e 01 ff ff 00      memcmp 0x02, 0xffff, [A]
d876:    15 03                  bnz L_d87b
d878:    3a                     clr A, #0
d879:    73 0c                  jmp L_d887

L_d87b:
d87b:    47 86 03 60 02 00      memcmp 0x04, [Y + 0x02], [A]
d881:    14 04                  bz L_d887
d883:    30 05                  inc A, #6
d885:    73 e9                  jmp L_d870

L_d887:
d887:    55 00                  mov A, A
d889:    09                     ret

R_d88a:
d88a:    90 e3 2b               ld A, R_e32b|0xe32b

L_d88d:
d88d:    47 8e 01 ff ff 00      memcmp 0x02, 0xffff, [A]
d893:    15 03                  bnz L_d898
d895:    3a                     clr A, #0
d896:    73 0c                  jmp L_d8a4

L_d898:
d898:    47 86 03 60 1b 00      memcmp 0x04, [Y + 0x1b], [A]
d89e:    14 04                  bz L_d8a4
d8a0:    30 06                  inc A, #7
d8a2:    73 e9                  jmp L_d88d

L_d8a4:
d8a4:    55 00                  mov A, A
d8a6:    09                     ret

R_d8a7:
d8a7:    90 e2 73               ld A, R_e273|0xe273

L_d8aa:
d8aa:    47 8e 01 ff ff 00      memcmp 0x02, 0xffff, [A]
d8b0:    15 03                  bnz L_d8b5
d8b2:    3a                     clr A, #0
d8b3:    73 0c                  jmp L_d8c1

L_d8b5:
d8b5:    47 86 03 60 02 00      memcmp 0x04, [Y + 0x02], [A]
d8bb:    14 04                  bz L_d8c1
d8bd:    30 0c                  inc A, #13
d8bf:    73 e9                  jmp L_d8aa

L_d8c1:
d8c1:    55 00                  mov A, A
d8c3:    09                     ret

R_d8c4:
d8c4:    7b 9b                  call R_d861
d8c6:    91 e1 93               ld A, [R_e193|0xe193]
d8c9:    46 01 1d 01 00 26      subbig(0, 1) 0x01, [A + 0x26]
d8cf:    17 03                  bp L_d8d4
d8d1:    71 d9 69               jmp R_d969

L_d8d4:
d8d4:    47 8d 01 02 00 60 00   memcmp 0x02, 0x0200, [Y + 0x00]
d8db:    14 06                  bz L_d8e3

R_d8dd:
d8dd:    50 76 00 0a            add Y, Y, 0x000a
d8e1:    73 e1                  jmp R_d8c4

L_d8e3:
d8e3:    91 e2 4f               ld A, [R_e24f|0xe24f]
d8e6:    3d                     sll A, #1
d8e7:    50 01 01 07            add A, A, [0x0107]
d8eb:    d6 19 00 00            st A, [Z + 0x0000]
d8ef:    32 20                  clr B, #0
d8f1:    30 01                  inc A, #2
d8f3:    f8                     st B, [A]
d8f4:    47 9e 60 00 08         memset 0x61, 0x00, [Z]
d8f9:    85 68 02               ld AL, [Y + 0x02]
d8fc:    a5 88 01               st AL, [Z + 0x01]
d8ff:    85 68 03               ld AL, [Y + 0x03]
d902:    a5 88 03               st AL, [Z + 0x03]
d905:    80 04                  ld AL, 0x04
d907:    a5 88 06               st AL, [Z + 0x06]
d90a:    85 68 09               ld AL, [Y + 0x09]
d90d:    20 13                  inc AL, #4
d90f:    a5 88 07               st AL, [Z + 0x07]
d912:    28                     inc AL, #1
d913:    22 00                  clr AH, #0
d915:    50 01 e1 86            add A, A, [R_e186|0xe186]
d919:    b1 e1 86               st A, [R_e186|0xe186]
d91c:    80 01                  ld AL, 0x01
d91e:    a5 88 12               st AL, [Z + 0x12]
d921:    85 68 08               ld AL, [Y + 0x08]
d924:    a5 88 16               st AL, [Z + 0x16]
d927:    22 00                  clr AH, #0
d929:    50 01 e1 80            add A, A, [R_e180|0xe180]
d92d:    38                     inc A, #1
d92e:    b1 e1 80               st A, [R_e180|0xe180]
d931:    85 68 04               ld AL, [Y + 0x04]
d934:    a5 88 31               st AL, [Z + 0x31]
d937:    85 68 06               ld AL, [Y + 0x06]
d93a:    a5 88 5e               st AL, [Z + 0x5e]
d93d:    85 68 05               ld AL, [Y + 0x05]
d940:    a5 88 5f               st AL, [Z + 0x5f]
d943:    85 68 07               ld AL, [Y + 0x07]
d946:    a5 88 60               st AL, [Z + 0x60]
d949:    90 ff ff               ld A, 0xffff
d94c:    b5 88 32               st A, [Z + 0x32]
d94f:    91 01 42               ld A, [0x0142]
d952:    b5 88 34               st A, [Z + 0x34]
d955:    80 fd                  ld AL, 0xfd
d957:    a5 88 56               st AL, [Z + 0x56]
d95a:    50 98 00 61            add Z, Z, 0x0061
d95e:    30 10 e2 4f            inc [R_e24f|0xe24f], #1
d962:    30 10 e1 7e            inc [R_e17e|0xe17e], #1
d966:    71 d8 dd               jmp R_d8dd

R_d969:
d969:    d1 e1 93               ld B, [R_e193|0xe193]
d96c:    c5 28 05               ld BL, [B + 0x05]
d96f:    22 20                  clr BH, #0
d971:    91 e1 7e               ld A, [R_e17e|0xe17e]
d974:    77 02                  div B, A
d976:    77 32 00 05            div B, B, 0x0005
d97a:    f1 e1 7e               st B, [R_e17e|0xe17e]
d97d:    91 e1 80               ld A, [R_e180|0xe180]
d980:    77 10 00 0a            div A, A, 0x000a
d984:    f1 e1 80               st B, [R_e180|0xe180]
d987:    91 e1 86               ld A, [R_e186|0xe186]
d98a:    77 10 00 03            div A, A, 0x0003
d98e:    f1 e1 86               st B, [R_e186|0xe186]

L_d991:
d991:    79 d8 61               call R_d861
d994:    91 e1 93               ld A, [R_e193|0xe193]
d997:    46 01 1d 01 00 28      subbig(0, 1) 0x01, [A + 0x28]
d99d:    17 03                  bp L_d9a2
d99f:    71 db d2               jmp R_dbd2

L_d9a2:
d9a2:    47 8d 01 03 00 60 00   memcmp 0x02, 0x0300, [Y + 0x00]
d9a9:    14 06                  bz L_d9b1

R_d9ab:
d9ab:    50 76 00 25            add Y, Y, 0x0025
d9af:    73 e0                  jmp L_d991

L_d9b1:
d9b1:    79 d8 6d               call R_d86d
d9b4:    15 02                  bnz L_d9b8
d9b6:    73 f3                  jmp R_d9ab

L_d9b8:
d9b8:    47 8d 00 cc 60 02      memcmp 0x01, 0xcc, [Y + 0x02]
d9be:    14 05                  bz L_d9c5
d9c0:    18 61                  bgt L_da23
d9c2:    71 da 98               jmp R_da98

L_d9c5:
d9c5:    47 9e 37 00 08         memset 0x38, 0x00, [Z]
d9ca:    30 03                  inc A, #4
d9cc:    c8                     ld BL, [A]
d9cd:    e5 88 06               st BL, [Z + 0x06]
d9d0:    79 df ba               call R_dfba
d9d3:    d5 68 0e               ld B, [Y + 0x0e]
d9d6:    f5 88 0f               st B, [Z + 0x0f]
d9d9:    79 db b3               call R_dbb3
d9dc:    d0 c7 0a               ld B, 0xc70a
d9df:    fc                     st B, [Z]
d9e0:    c5 68 10               ld BL, [Y + 0x10]
d9e3:    e5 88 02               st BL, [Z + 0x02]
d9e6:    30 10 e2 57            inc [R_e257|0xe257], #1
d9ea:    d1 e2 57               ld B, [R_e257|0xe257]
d9ed:    f5 88 03               st B, [Z + 0x03]
d9f0:    47 45 05 60 07 80 07   memcpy 0x06, [Y + 0x07], [Z + 0x07]
d9f7:    c5 68 11               ld BL, [Y + 0x11]
d9fa:    e5 88 19               st BL, [Z + 0x19]
d9fd:    d0 ff ff               ld B, 0xffff
da00:    f5 88 1d               st B, [Z + 0x1d]
da03:    d0 00 a0               ld B, 0x00a0
da06:    f5 88 1b               st B, [Z + 0x1b]
da09:    47 84 05 60 15 e2 5d   memcmp 0x06, [Y + 0x15], [R_e25d|0xe25d]
da10:    14 07                  bz L_da19
da12:    47 45 05 60 15 80 1f   memcpy 0x06, [Y + 0x15], [Z + 0x1f]

L_da19:
da19:    50 98 00 38            add Z, Z, 0x0038
da1d:    30 10 e2 51            inc [R_e251|0xe251], #1
da21:    73 88                  jmp R_d9ab

L_da23:
da23:    47 8d 03 d0 b7 a0 a0 60 02 memcmp 0x04, 0xd0b7a0a0, [Y + 0x02]
da2c:    15 07                  bnz L_da35
da2e:    c0 04                  ld BL, 0x04
da30:    e5 68 06               st BL, [Y + 0x06]
da33:    73 63                  jmp R_da98

L_da35:
da35:    47 9e 37 00 08         memset 0x38, 0x00, [Z]
da3a:    30 03                  inc A, #4
da3c:    c5 01                  ld BL, [A++]
da3e:    e5 88 06               st BL, [Z + 0x06]
da41:    c5 01                  ld BL, [A++]
da43:    e5 88 37               st BL, [Z + 0x37]
da46:    79 df ba               call R_dfba
da49:    90 c2 03               ld A, 0xc203
da4c:    bc                     st A, [Z]
da4d:    85 68 10               ld AL, [Y + 0x10]
da50:    a5 88 02               st AL, [Z + 0x02]
da53:    30 10 e2 57            inc [R_e257|0xe257], #1
da57:    91 e2 57               ld A, [R_e257|0xe257]
da5a:    b5 88 03               st A, [Z + 0x03]
da5d:    47 45 05 60 07 80 07   memcpy 0x06, [Y + 0x07], [Z + 0x07]
da64:    d5 68 0e               ld B, [Y + 0x0e]
da67:    f5 88 0f               st B, [Z + 0x0f]
da6a:    79 db b3               call R_dbb3
da6d:    80 42                  ld AL, 0x42
da6f:    a5 88 18               st AL, [Z + 0x18]
da72:    85 68 11               ld AL, [Y + 0x11]
da75:    a5 88 19               st AL, [Z + 0x19]
da78:    85 68 12               ld AL, [Y + 0x12]
da7b:    a5 88 1c               st AL, [Z + 0x1c]
da7e:    90 ff ff               ld A, 0xffff
da81:    b5 88 1d               st A, [Z + 0x1d]
da84:    b5 88 25               st A, [Z + 0x25]
da87:    b5 88 27               st A, [Z + 0x27]
da8a:    b5 88 29               st A, [Z + 0x29]
da8d:    50 98 00 38            add Z, Z, 0x0038
da91:    30 10 e2 51            inc [R_e251|0xe251], #1
da95:    71 d9 ab               jmp R_d9ab

R_da98:
da98:    47 9e 37 00 08         memset 0x38, 0x00, [Z]
da9d:    30 03                  inc A, #4
da9f:    c5 01                  ld BL, [A++]
daa1:    e5 88 06               st BL, [Z + 0x06]
daa4:    c5 01                  ld BL, [A++]
daa6:    e5 88 37               st BL, [Z + 0x37]
daa9:    e1 e1 97               st BL, [R_e197|0xe197]
daac:    d6 89 e1 95            st Z, [R_e195|0xe195]
dab0:    79 df ba               call R_dfba
dab3:    d5 68 0e               ld B, [Y + 0x0e]
dab6:    f5 88 0f               st B, [Z + 0x0f]
dab9:    79 db b3               call R_dbb3
dabc:    90 c7 02               ld A, 0xc702
dabf:    bc                     st A, [Z]
dac0:    85 68 10               ld AL, [Y + 0x10]
dac3:    a5 88 02               st AL, [Z + 0x02]
dac6:    30 10 e2 57            inc [R_e257|0xe257], #1
daca:    91 e2 57               ld A, [R_e257|0xe257]
dacd:    b5 88 03               st A, [Z + 0x03]
dad0:    47 45 05 60 07 80 07   memcpy 0x06, [Y + 0x07], [Z + 0x07]
dad7:    80 83                  ld AL, 0x83
dad9:    a5 88 17               st AL, [Z + 0x17]
dadc:    80 18                  ld AL, 0x18
dade:    a5 88 18               st AL, [Z + 0x18]
dae1:    85 68 11               ld AL, [Y + 0x11]
dae4:    a5 88 19               st AL, [Z + 0x19]
dae7:    85 68 0d               ld AL, [Y + 0x0d]
daea:    a5 88 1a               st AL, [Z + 0x1a]
daed:    85 68 12               ld AL, [Y + 0x12]
daf0:    a5 88 1c               st AL, [Z + 0x1c]
daf3:    85 68 06               ld AL, [Y + 0x06]
daf6:    a5 88 1e               st AL, [Z + 0x1e]
daf9:    95 68 13               ld A, [Y + 0x13]
dafc:    b5 88 2f               st A, [Z + 0x2f]
daff:    47 84 05 60 15 e2 5d   memcmp 0x06, [Y + 0x15], [R_e25d|0xe25d]
db06:    14 07                  bz L_db0f
db08:    47 45 05 60 15 80 1f   memcpy 0x06, [Y + 0x15], [Z + 0x1f]

L_db0f:
db0f:    90 ff ff               ld A, 0xffff
db12:    b5 88 25               st A, [Z + 0x25]
db15:    b5 88 27               st A, [Z + 0x27]
db18:    b5 88 29               st A, [Z + 0x29]
db1b:    95 88 2f               ld A, [Z + 0x2f]
db1e:    15 03                  bnz L_db23
db20:    71 db ac               jmp R_dbac

L_db23:
db23:    79 df c7               call R_dfc7
db26:    30 10 e2 53            inc [R_e253|0xe253], #1
db2a:    50 01 e1 82            add A, A, [R_e182|0xe182]
db2e:    b1 e1 82               st A, [R_e182|0xe182]
db31:    50 98 00 38            add Z, Z, 0x0038

R_db35:
db35:    30 10 e2 51            inc [R_e251|0xe251], #1
db39:    47 81 03 e2 5d 60 1b   memcmp 0x04, [R_e25d|0xe25d], [Y + 0x1b]
db40:    15 03                  bnz L_db45
db42:    71 db a9               jmp R_dba9

L_db45:
db45:    79 d8 8a               call R_d88a
db48:    15 03                  bnz L_db4d
db4a:    71 d9 ab               jmp R_d9ab

L_db4d:
db4d:    47 9e 37 00 08         memset 0x38, 0x00, [Z]
db52:    30 03                  inc A, #4
db54:    c1 e1 97               ld BL, [R_e197|0xe197]
db57:    21 30                  dec BL, #1
db59:    14 04                  bz L_db5f
db5b:    21 31                  dec BL, #2
db5d:    19 05                  ble L_db64

L_db5f:
db5f:    c5 08 01               ld BL, [A + 0x01]
db62:    73 01                  jmp L_db65

L_db64:
db64:    c8                     ld BL, [A]

L_db65:
db65:    e5 88 06               st BL, [Z + 0x06]
db68:    c5 08 02               ld BL, [A + 0x02]
db6b:    e5 88 37               st BL, [Z + 0x37]
db6e:    79 df ba               call R_dfba
db71:    47 4d 01 42 03 80 00   memcpy 0x02, 0x4203, [Z + 0x00]
db78:    47 45 00 60 0d 80 02   memcpy 0x01, [Y + 0x0d], [Z + 0x02]
db7f:    30 10 e2 57            inc [R_e257|0xe257], #1
db83:    91 e2 57               ld A, [R_e257|0xe257]
db86:    b5 88 03               st A, [Z + 0x03]
db89:    47 45 05 60 1f 80 07   memcpy 0x06, [Y + 0x1f], [Z + 0x07]
db90:    91 e1 95               ld A, [R_e195|0xe195]
db93:    b5 88 0f               st A, [Z + 0x0f]
db96:    80 42                  ld AL, 0x42
db98:    a5 88 18               st AL, [Z + 0x18]
db9b:    90 79 a0               ld A, 0x79a0
db9e:    b5 88 1b               st A, [Z + 0x1b]
dba1:    50 98 00 38            add Z, Z, 0x0038
dba5:    30 10 e2 51            inc [R_e251|0xe251], #1

R_dba9:
dba9:    71 d9 ab               jmp R_d9ab

R_dbac:
dbac:    50 98 00 38            add Z, Z, 0x0038
dbb0:    71 db 35               jmp R_db35

R_dbb3:
dbb3:    90 06 f0               ld A, 0x06f0
dbb6:    42 30                  and AH, BL
dbb8:    42 31                  and AL, BL
dbba:    2c                     srl AL, #1
dbbb:    43 01                  or AL, AH
dbbd:    22 00                  clr AH, #0
dbbf:    d1 01 0b               ld B, [0x010b]
dbc2:    58                     add B, A
dbc3:    d6 39 00 02            st B, [Z + 0x0002]
dbc7:    91 d5 21               ld A, [R_d521|0xd521]
dbca:    51 20                  sub A, B
dbcc:    19 03                  ble L_dbd1
dbce:    f1 d5 21               st B, [R_d521|0xd521]

L_dbd1:
dbd1:    09                     ret

R_dbd2:
dbd2:    79 d8 61               call R_d861
dbd5:    91 e1 93               ld A, [R_e193|0xe193]
dbd8:    46 01 1d 01 00 2a      subbig(0, 1) 0x01, [A + 0x2a]
dbde:    17 03                  bp L_dbe3
dbe0:    71 dc bb               jmp R_dcbb

L_dbe3:
dbe3:    47 8d 01 04 00 60 00   memcmp 0x02, 0x0400, [Y + 0x00]
dbea:    14 06                  bz L_dbf2

R_dbec:
dbec:    50 76 00 12            add Y, Y, 0x0012
dbf0:    73 e0                  jmp R_dbd2

L_dbf2:
dbf2:    47 81 03 e2 5d 60 02   memcmp 0x04, [R_e25d|0xe25d], [Y + 0x02]
dbf9:    15 03                  bnz L_dbfe
dbfb:    71 dc 9b               jmp R_dc9b

L_dbfe:
dbfe:    79 d8 a7               call R_d8a7
dc01:    15 02                  bnz L_dc05
dc03:    73 e7                  jmp R_dbec

L_dc05:
dc05:    47 44 03 60 02 e2 43   memcpy 0x04, [Y + 0x02], [R_e243|0xe243]
dc0c:    d6 89 e2 47            st Z, [R_e247|0xe247]
dc10:    47 81 03 e2 49 60 02   memcmp 0x04, [R_e249|0xe249], [Y + 0x02]
dc17:    15 06                  bnz L_dc1f
dc19:    90 00 02               ld A, 0x0002
dc1c:    b1 e2 55               st A, [R_e255|0xe255]

L_dc1f:
dc1f:    47 9e 1b 00 08         memset 0x1c, 0x00, [Z]
dc24:    30 03                  inc A, #4
dc26:    c5 01                  ld BL, [A++]
dc28:    e5 88 06               st BL, [Z + 0x06]
dc2b:    c5 01                  ld BL, [A++]
dc2d:    e5 88 1b               st BL, [Z + 0x1b]
dc30:    d5 01                  ld B, [A++]
dc32:    f5 88 11               st B, [Z + 0x11]
dc35:    c5 01                  ld BL, [A++]
dc37:    e5 88 16               st BL, [Z + 0x16]
dc3a:    d5 01                  ld B, [A++]
dc3c:    f5 88 19               st B, [Z + 0x19]
dc3f:    d5 01                  ld B, [A++]
dc41:    f1 e2 4d               st B, [R_e24d|0xe24d]
dc44:    79 df ba               call R_dfba
dc47:    90 57 04               ld A, 0x5704
dc4a:    bc                     st A, [Z]
dc4b:    30 10 e2 57            inc [R_e257|0xe257], #1
dc4f:    91 e2 57               ld A, [R_e257|0xe257]
dc52:    b5 88 03               st A, [Z + 0x03]
dc55:    95 68 0d               ld A, [Y + 0x0d]
dc58:    b5 88 0f               st A, [Z + 0x0f]

R_dc5b:
dc5b:    85 68 0c               ld AL, [Y + 0x0c]
dc5e:    a5 88 02               st AL, [Z + 0x02]
dc61:    47 84 00 60 0c 01 06   memcmp 0x01, [Y + 0x0c], [0x0106]
dc68:    18 03                  bgt L_dc6d
dc6a:    a1 01 06               st AL, [0x0106]

L_dc6d:
dc6d:    47 45 05 60 06 80 07   memcpy 0x06, [Y + 0x06], [Z + 0x07]
dc74:    85 68 0f               ld AL, [Y + 0x0f]
dc77:    a5 88 13               st AL, [Z + 0x13]
dc7a:    95 68 10               ld A, [Y + 0x10]
dc7d:    b5 88 17               st A, [Z + 0x17]
dc80:    30 10 e2 51            inc [R_e251|0xe251], #1
dc84:    85 88 16               ld AL, [Z + 0x16]
dc87:    22 00                  clr AH, #0
dc89:    50 01 e1 84            add A, A, [R_e184|0xe184]
dc8d:    50 10 00 0b            add A, A, 0x000b
dc91:    b1 e1 84               st A, [R_e184|0xe184]
dc94:    50 98 00 1c            add Z, Z, 0x001c
dc98:    71 db ec               jmp R_dbec

R_dc9b:
dc9b:    91 e2 47               ld A, [R_e247|0xe247]
dc9e:    47 4a 1b 08            memcpy 0x1c, [A], [Z]
dca2:    31 10 e2 55            dec [R_e255|0xe255], #1
dca6:    15 07                  bnz L_dcaf
dca8:    95 88 11               ld A, [Z + 0x11]
dcab:    3d                     sll A, #1
dcac:    b5 88 11               st A, [Z + 0x11]

L_dcaf:
dcaf:    91 e2 4d               ld A, [R_e24d|0xe24d]
dcb2:    b5 88 19               st A, [Z + 0x19]
dcb5:    79 df ba               call R_dfba
dcb8:    71 dc 5b               jmp R_dc5b

R_dcbb:
dcbb:    79 d8 61               call R_d861
dcbe:    91 e1 93               ld A, [R_e193|0xe193]
dcc1:    46 01 1d 01 00 2c      subbig(0, 1) 0x01, [A + 0x2c]
dcc7:    17 03                  bp L_dccc
dcc9:    71 dd 22               jmp R_dd22

L_dccc:
dccc:    47 8d 01 05 00 60 00   memcmp 0x02, 0x0500, [Y + 0x00]
dcd3:    14 06                  bz L_dcdb

R_dcd5:
dcd5:    50 76 00 10            add Y, Y, 0x0010
dcd9:    73 e0                  jmp R_dcbb

L_dcdb:
dcdb:    79 d8 6d               call R_d86d
dcde:    15 02                  bnz L_dce2
dce0:    73 f3                  jmp R_dcd5

L_dce2:
dce2:    47 9e 37 00 08         memset 0x38, 0x00, [Z]
dce7:    30 03                  inc A, #4
dce9:    c5 01                  ld BL, [A++]
dceb:    e5 88 06               st BL, [Z + 0x06]
dcee:    c5 01                  ld BL, [A++]
dcf0:    e5 88 37               st BL, [Z + 0x37]
dcf3:    79 df ba               call R_dfba
dcf6:    90 42 03               ld A, 0x4203
dcf9:    bc                     st A, [Z]
dcfa:    85 68 0e               ld AL, [Y + 0x0e]
dcfd:    a5 88 02               st AL, [Z + 0x02]
dd00:    30 10 e2 57            inc [R_e257|0xe257], #1
dd04:    91 e2 57               ld A, [R_e257|0xe257]
dd07:    b5 88 03               st A, [Z + 0x03]
dd0a:    47 45 05 60 06 80 07   memcpy 0x06, [Y + 0x06], [Z + 0x07]
dd11:    95 68 0c               ld A, [Y + 0x0c]
dd14:    b5 88 0f               st A, [Z + 0x0f]
dd17:    50 98 00 38            add Z, Z, 0x0038
dd1b:    30 10 e2 51            inc [R_e251|0xe251], #1
dd1f:    71 dc d5               jmp R_dcd5

R_dd22:
dd22:    79 d8 61               call R_d861
dd25:    91 e1 93               ld A, [R_e193|0xe193]
dd28:    46 01 1d 01 00 2e      subbig(0, 1) 0x01, [A + 0x2e]
dd2e:    17 03                  bp L_dd33
dd30:    71 dd 76               jmp R_dd76

L_dd33:
dd33:    47 8d 01 06 00 60 00   memcmp 0x02, 0x0600, [Y + 0x00]
dd3a:    14 06                  bz L_dd42

L_dd3c:
dd3c:    50 76 00 1e            add Y, Y, 0x001e
dd40:    73 e0                  jmp R_dd22

L_dd42:
dd42:    47 9e 27 00 08         memset 0x28, 0x00, [Z]
dd47:    79 df ba               call R_dfba
dd4a:    90 06 09               ld A, 0x0609
dd4d:    bc                     st A, [Z]
dd4e:    30 10 e2 57            inc [R_e257|0xe257], #1
dd52:    91 e2 57               ld A, [R_e257|0xe257]
dd55:    b5 88 03               st A, [Z + 0x03]
dd58:    47 45 05 60 02 80 07   memcpy 0x06, [Y + 0x02], [Z + 0x07]
dd5f:    47 45 14 60 08 80 11   memcpy 0x15, [Y + 0x08], [Z + 0x11]
dd66:    85 68 1d               ld AL, [Y + 0x1d]
dd69:    a5 88 26               st AL, [Z + 0x26]
dd6c:    50 98 00 27            add Z, Z, 0x0027
dd70:    30 10 e2 51            inc [R_e251|0xe251], #1
dd74:    73 c6                  jmp L_dd3c

R_dd76:
dd76:    79 d8 61               call R_d861
dd79:    91 e1 93               ld A, [R_e193|0xe193]
dd7c:    46 01 1d 01 00 30      subbig(0, 1) 0x01, [A + 0x30]
dd82:    17 03                  bp L_dd87
dd84:    71 dd d7               jmp R_ddd7

L_dd87:
dd87:    47 8d 01 07 00 60 00   memcmp 0x02, 0x0700, [Y + 0x00]
dd8e:    14 06                  bz L_dd96

L_dd90:
dd90:    50 76 00 10            add Y, Y, 0x0010
dd94:    73 e0                  jmp R_dd76

L_dd96:
dd96:    79 d8 6d               call R_d86d
dd99:    15 02                  bnz L_dd9d
dd9b:    73 f3                  jmp L_dd90

L_dd9d:
dd9d:    47 9e 14 00 08         memset 0x15, 0x00, [Z]
dda2:    30 03                  inc A, #4
dda4:    c5 01                  ld BL, [A++]
dda6:    e5 88 06               st BL, [Z + 0x06]
dda9:    79 df ba               call R_dfba
ddac:    90 03 07               ld A, 0x0307
ddaf:    bc                     st A, [Z]
ddb0:    85 68 0f               ld AL, [Y + 0x0f]
ddb3:    a5 88 02               st AL, [Z + 0x02]
ddb6:    30 10 e2 57            inc [R_e257|0xe257], #1
ddba:    91 e2 57               ld A, [R_e257|0xe257]
ddbd:    b5 88 03               st A, [Z + 0x03]
ddc0:    47 45 05 60 06 80 07   memcpy 0x06, [Y + 0x06], [Z + 0x07]
ddc7:    95 68 0d               ld A, [Y + 0x0d]
ddca:    b5 88 0f               st A, [Z + 0x0f]
ddcd:    50 98 00 15            add Z, Z, 0x0015
ddd1:    30 10 e2 51            inc [R_e251|0xe251], #1
ddd5:    73 b9                  jmp L_dd90

R_ddd7:
ddd7:    79 d8 61               call R_d861
ddda:    91 e1 93               ld A, [R_e193|0xe193]
dddd:    46 01 1d 01 00 32      subbig(0, 1) 0x01, [A + 0x32]
dde3:    17 03                  bp L_dde8
dde5:    71 de 38               jmp R_de38

L_dde8:
dde8:    47 8d 01 08 00 60 00   memcmp 0x02, 0x0800, [Y + 0x00]
ddef:    14 06                  bz L_ddf7

L_ddf1:
ddf1:    50 76 00 10            add Y, Y, 0x0010
ddf5:    73 e0                  jmp R_ddd7

L_ddf7:
ddf7:    79 d8 6d               call R_d86d
ddfa:    15 02                  bnz L_ddfe
ddfc:    73 f3                  jmp L_ddf1

L_ddfe:
ddfe:    47 9e 10 00 08         memset 0x11, 0x00, [Z]
de03:    30 03                  inc A, #4
de05:    c5 01                  ld BL, [A++]
de07:    e5 88 06               st BL, [Z + 0x06]
de0a:    79 df ba               call R_dfba
de0d:    90 03 0b               ld A, 0x030b
de10:    bc                     st A, [Z]
de11:    85 68 0f               ld AL, [Y + 0x0f]
de14:    a5 88 02               st AL, [Z + 0x02]
de17:    30 10 e2 57            inc [R_e257|0xe257], #1
de1b:    91 e2 57               ld A, [R_e257|0xe257]
de1e:    b5 88 03               st A, [Z + 0x03]
de21:    47 45 05 60 06 80 07   memcpy 0x06, [Y + 0x06], [Z + 0x07]
de28:    95 68 0d               ld A, [Y + 0x0d]
de2b:    b5 88 0f               st A, [Z + 0x0f]
de2e:    50 98 00 11            add Z, Z, 0x0011
de32:    30 10 e2 51            inc [R_e251|0xe251], #1
de36:    73 b9                  jmp L_ddf1

R_de38:
de38:    79 d8 61               call R_d861
de3b:    91 e1 93               ld A, [R_e193|0xe193]
de3e:    46 01 1d 01 00 34      subbig(0, 1) 0x01, [A + 0x34]
de44:    17 03                  bp L_de49
de46:    71 df 13               jmp R_df13

L_de49:
de49:    47 8d 01 09 00 60 00   memcmp 0x02, 0x0900, [Y + 0x00]
de50:    14 06                  bz L_de58

R_de52:
de52:    50 76 00 37            add Y, Y, 0x0037
de56:    73 e0                  jmp R_de38

L_de58:
de58:    85 68 36               ld AL, [Y + 0x36]
de5b:    67 9e 00 08            memset AL, 0x00, [Z]
de5f:    c5 01                  ld BL, [A++]
de61:    e5 88 06               st BL, [Z + 0x06]
de64:    79 df ba               call R_dfba
de67:    90 08 00               ld A, 0x0800
de6a:    51 80                  sub A, Z
de6c:    17 04                  bp L_de72
de6e:    55 98 08 00            mov Z, 0x0800

L_de72:
de72:    7e 63                  push {Y, Z}
de74:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
de77:    a3 11                  st AL, [0xde8a]
de79:    50 70 00 0c            add A, Y, 0x000c
de7d:    b3 0c                  st A, [0xde8b]
de7f:    d6 89 de 8d            st Z, [R_de8d|0xde8d]
de83:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
de88:    66 02                  jsys Syscall_02
de8a:    00                         DiskNum = (0x0)
de8b:    00 00                      Filename = L_0000

R_de8d:
de8d:    00 00                      Buffer = (0x0)
de8f:    01                         arg4 = (0x1)
de90:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
de95:    7f 63                  pop {Y, Z}
de97:    38                     inc A, #1
de98:    5e                     mov Z, A
de99:    b5 88 05               st A, [Z + 0x05]
de9c:    47 81 14 e2 5d 60 21   memcmp 0x15, [R_e25d|0xe25d], [Y + 0x21]
dea3:    14 33                  bz L_ded8
dea5:    7e 63                  push {Y, Z}
dea7:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
deaa:    a3 11                  st AL, [0xdebd]
deac:    50 70 00 21            add A, Y, 0x0021
deb0:    b3 0c                  st A, [0xdebe]
deb2:    d6 89 de c0            st Z, [R_dec0|0xdec0]
deb6:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
debb:    66 02                  jsys Syscall_02
debd:    00                         DiskNum = (0x0)
debe:    00 00                      Filename = L_0000

R_dec0:
dec0:    00 00                      Buffer = (0x0)
dec2:    01                         arg4 = (0x1)
dec3:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
dec8:    7f 63                  pop {Y, Z}
deca:    38                     inc A, #1
decb:    5e                     mov Z, A
decc:    90 df 0b               ld A, R_df0b|0xdf0b
decf:    50 01 df 09            add A, A, [R_df09|0xdf09]
ded3:    f8                     st B, [A]
ded4:    30 11 df 09            inc [R_df09|0xdf09], #2

L_ded8:
ded8:    79 df ba               call R_dfba
dedb:    30 10 e2 57            inc [R_e257|0xe257], #1
dedf:    91 00 03               ld A, [0x0003]
dee2:    b5 88 03               st A, [Z + 0x03]
dee5:    90 57 0c               ld A, 0x570c
dee8:    bc                     st A, [Z]
dee9:    47 45 05 60 02 80 07   memcpy 0x06, [Y + 0x02], [Z + 0x07]
def0:    95 68 09               ld A, [Y + 0x09]
def3:    b5 88 0f               st A, [Z + 0x0f]
def6:    85 68 0b               ld AL, [Y + 0x0b]
def9:    a5 88 1a               st AL, [Z + 0x1a]
defc:    3a                     clr A, #0
defd:    85 68 36               ld AL, [Y + 0x36]
df00:    50 08                  add Z, A
df02:    30 10 e2 51            inc [R_e251|0xe251], #1
df06:    71 de 52               jmp R_de52

R_df09:
df09:    <null bytes>


R_df0b:
df0b:    00
df0c:    00
df0d:    00
df0e:    00
df0f:    00
df10:    00
df11:    00
df12:    00

R_df13:
df13:    91 e2 51               ld A, [R_e251|0xe251]
df16:    b1 e2 5b               st A, [R_e25b|0xe25b]
df19:    79 df ba               call R_dfba
df1c:    47 9e 3b 00 08         memset 0x3c, 0x00, [Z]
df21:    47 4d 01 47 00 80 00   memcpy 0x02, 0x4700, [Z + 0x00]
df28:    7b 7d                  call L_dfa7
df2a:    47 4d 05 c4 d5 cd cd d9 a0 80 07 memcpy 0x06, 0xc4d5cdcdd9a0, [Z + 0x07]
df35:    50 98 00 11            add Z, Z, 0x0011
df39:    30 01                  inc A, #2
df3b:    d6 19 00 00            st A, [Z + 0x0000]
df3f:    47 4d 01 00 00 00 02   memcpy 0x02, 0x0000, [A + 0x02]
df46:    47 4d 01 c7 00 80 00   memcpy 0x02, 0xc700, [Z + 0x00]
df4d:    7b 58                  call L_dfa7
df4f:    30 10 e2 57            inc [R_e257|0xe257], #1
df53:    47 4d 05 c2 cc c9 ce c4 a0 80 07 memcpy 0x06, 0xc2ccc9cec4a0, [Z + 0x07]
df5e:    47 4d 00 ff 80 1a      memcpy 0x01, 0xff, [Z + 0x1a]
df64:    47 9d 05 ff 80 25      memset 0x06, 0xff, [Z + 0x25]
df6a:    50 98 00 2b            add Z, Z, 0x002b
df6e:    30 11 e2 51            inc [R_e251|0xe251], #2

L_df72:
df72:    79 d8 61               call R_d861
df75:    91 e1 93               ld A, [R_e193|0xe193]
df78:    46 01 1d 01 00 36      subbig(0, 1) 0x01, [A + 0x36]
df7e:    17 03                  bp L_df83
df80:    71 df df               jmp R_dfdf

L_df83:
df83:    47 8d 01 0a 00 60 00   memcmp 0x02, 0x0a00, [Y + 0x00]
df8a:    14 06                  bz L_df92

L_df8c:
df8c:    50 76 00 52            add Y, Y, 0x0052
df90:    73 e0                  jmp L_df72

L_df92:
df92:    55 62                  mov B, Y
df94:    90 00 50               ld A, 0x0050
df97:    b9                     st A, [B]
df98:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
df9d:    79 d5 4e               call LOS_WriteCRT
dfa0:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
dfa5:    73 e5                  jmp L_df8c

L_dfa7:
dfa7:    30 10 e2 57            inc [R_e257|0xe257], #1
dfab:    47 41 01 e2 57 80 03   memcpy 0x02, [R_e257|0xe257], [Z + 0x03]
dfb2:    47 4d 01 00 03 80 05   memcpy 0x02, 0x0003, [Z + 0x05]
dfb9:    09                     ret

R_dfba:
dfba:    91 e2 51               ld A, [R_e251|0xe251]
dfbd:    3d                     sll A, #1
dfbe:    50 01 01 09            add A, A, [DevicesPtr|0x0109]
dfc2:    d6 19 00 00            st A, [Z + 0x0000]
dfc6:    09                     ret

R_dfc7:
dfc7:    7e 03                  push {A, B}
dfc9:    91 e2 53               ld A, [R_e253|0xe253]
dfcc:    3d                     sll A, #1
dfcd:    50 01 01 68            add A, A, [0x0168]
dfd1:    d6 19 00 00            st A, [Z + 0x0000]
dfd5:    d0 00 00               ld B, 0x0000
dfd8:    d6 13 00 02            st A, [B + 0x0002]
dfdc:    7f 03                  pop {A, B}
dfde:    09                     ret

R_dfdf:
dfdf:    91 e2 57               ld A, [R_e257|0xe257]
dfe2:    b3 20                  st A, [L_e002+2|0xe004]
dfe4:    39                     dec A, #1
dfe5:    67 9e 00 08            memset AL, 0x00, [Z]
dfe9:    91 01 09               ld A, [DevicesPtr|0x0109]

L_dfec:
dfec:    55 13 00 00            mov B, [A + 0x0000]
dff0:    14 10                  bz L_e002
dff2:    30 01                  inc A, #2
dff4:    30 22                  inc B, #3
dff6:    55 37 00 00            mov Y, [B + 0x0000]
dffa:    50 86                  add Y, Z
dffc:    d6 37 00 00            st B, [Y + 0x0000]
e000:    73 ea                  jmp L_dfec

L_e002:
e002:    50 98 00 00            add Z, Z, 0x0000
e006:    d6 89 01 26            st Z, [EarlyInitDevicesPtr|0x0126]
e00a:    91 df 09               ld A, [R_df09|0xdf09]
e00d:    14 08                  bz L_e017
e00f:    67 41 df 0b 80 02      memcpy AL, [R_df0b|0xdf0b], [Z + 0x02]
e015:    50 08                  add Z, A

L_e017:
e017:    47 9e 03 00 08         memset 0x04, 0x00, [Z]
e01c:    30 83                  inc Z, #4
e01e:    d6 89 01 6c            st Z, [0x016c]
e022:    d1 e1 93               ld B, [R_e193|0xe193]
e025:    95 28 0a               ld A, [B + 0x0a]
e028:    39                     dec A, #1
e029:    67 9e ff 08            memset AL, 0xff, [Z]
e02d:    38                     inc A, #1
e02e:    50 08                  add Z, A
e030:    d6 89 01 1d            st Z, [0x011d]
e034:    47 4e 01 00 00 08      memcpy 0x02, 0x0000, [Z]
e03a:    50 98 01 92            add Z, Z, 0x0192
e03e:    47 4e 03 00 8d 8d ff 08 memcpy 0x04, 0x008d8dff, [Z]
e046:    30 83                  inc Z, #4
e048:    91 01 0b               ld A, [0x010b]
e04b:    31 01                  dec A, #2
e04d:    d1 d5 21               ld B, [R_d521|0xd521]
e050:    51 20                  sub A, B
e052:    b2 01 0b               st A, @[0x010b]
e055:    92 01 07               ld A, @[0x0107]
e058:    b1 01 03               st A, [CurrentProcess|0x0103]
e05b:    91 01 07               ld A, [0x0107]

L_e05e:
e05e:    d1 e2 59               ld B, [R_e259|0xe259]
e061:    35 20                  sll B, #1
e063:    50 23 01 09            add B, B, [DevicesPtr|0x0109]
e067:    55 37 00 00            mov Y, [B + 0x0000]
e06b:    d5 01                  ld B, [A++]
e06d:    14 0b                  bz L_e07a
e06f:    d6 37 00 08            st B, [Y + 0x0008]
e073:    d0 e2 5b               ld B, R_e25b|0xe25b
e076:    f3 e7                  st B, [L_e05e+1|0xe05f]
e078:    73 e4                  jmp L_e05e

L_e07a:
e07a:    d6 89 01 6e            st Z, [0x016e]
e07e:    50 98 00 15            add Z, Z, 0x0015
e082:    91 e2 5b               ld A, [R_e25b|0xe25b]
e085:    a1 e1 7c               st AL, [R_e17c|0xe17c]
e088:    91 e2 59               ld A, [R_e259|0xe259]
e08b:    a1 e1 7d               st AL, [R_e17d|0xe17d]
e08e:    90 08 00               ld A, 0x0800
e091:    51 80                  sub A, Z
e093:    17 04                  bp L_e099
e095:    55 98 08 00            mov Z, 0x0800

L_e099:
e099:    90 cb 06               ld A, 0xcb06
e09c:    50 80                  add A, Z
e09e:    16 03                  blt L_e0a3
e0a0:    71 d2 d5               jmp R_d2d5

L_e0a3:
e0a3:    d6 89 01 01            st Z, [SyscallVector+1|0x0101]
e0a7:    2e 2c 00 d4 cd         wpf1 0x00, [R_d4cd|0xd4cd]
e0ac:    81 d2 7c               ld AL, [LOS_DiskNum|0xd27c]
e0af:    a3 06                  st AL, [0xe0b7]
e0b1:    55 80                  mov A, Z
e0b3:    b3 05                  st A, [0xe0ba]
e0b5:    66 02                  jsys Syscall_02
e0b7:    00                         DiskNum = (0x0)
e0b8:    e2 2e                      Filename = R_e22e
e0ba:    00 00                      Buffer = (0x0)
e0bc:    01                         arg4 = (0x1)
e0bd:    b1 d4 c6               st A, [L_d4c5+1|0xd4c6]
e0c0:    47 41 0b e1 7c 00 f2   memcpy 0x0c, [R_e17c|0xe17c], [A + -0xe]
e0c7:    2e 2c 00 d4 cb         wpf1 0x00, [R_d4cb|0xd4cb]
e0cc:    2e 1c f8 01 85         rpf 0xf8, [R_0185|0x0185]
e0d1:    2e 1c f8 01 c5         rpf 0xf8, [R_01c5|0x01c5]
e0d6:    2e 1c f8 01 a5         rpf 0xf8, [R_01a5|0x01a5]
e0db:    47 9c 1b ff 01 48      memset 0x1c, 0xff, [0x0148]
e0e1:    91 d4 d4               ld A, [R_d4d4|0xd4d4]
e0e4:    34 02                  srl A, #3
e0e6:    39                     dec A, #1
e0e7:    67 9c 00 01 44         memset AL, 0x00, [0x0144]
e0ec:    91 d4 d4               ld A, [R_d4d4|0xd4d4]
e0ef:    52 10 00 07            and A, A, 0x0007
e0f3:    14 14                  bz L_e109
e0f5:    5b                     mov X, A
e0f6:    91 d4 d4               ld A, [R_d4d4|0xd4d4]
e0f9:    34 02                  srl A, #3
e0fb:    50 10 01 44            add A, A, 0x0144
e0ff:    5c                     mov Y, A
e100:    2a                     clr AL, #0
e101:    29                     dec AL, #1

L_e102:
e102:    07                     rl
e103:    26 10                  rrc AL, #1
e105:    3f                     dec X
e106:    15 fa                  bnz L_e102
e108:    ab                     st AL, [Y]

L_e109:
e109:    91 d4 c6               ld A, [L_d4c5+1|0xd4c6]
e10c:    78 10 08 00            mul A, A, 0x0800
e110:    f5 a2                  st B, [--S]
e112:    3a                     clr A, #0

L_e113:
e113:    06                     sl
e114:    36 00                  rrc A, #1
e116:    31 20                  dec B, #1
e118:    17 f9                  bp L_e113
e11a:    53 10 00 01            or A, A, 0x0001
e11e:    b1 01 44               st A, [0x0144]
e121:    90 d5 23               ld A, R_d523|0xd523
e124:    52 10 7f ff            and A, A, 0x7fff
e128:    78 10 08 00            mul A, A, 0x0800
e12c:    3a                     clr A, #0

L_e12d:
e12d:    06                     sl
e12e:    36 00                  rrc A, #1
e130:    31 20                  dec B, #1
e132:    17 f9                  bp L_e12d
e134:    53 10 00 01            or A, A, 0x0001
e138:    d0 ff ff               ld B, 0xffff
e13b:    54 02                  xor B, A
e13d:    f1 d4 ce               st B, [R_d4cd+1|0xd4ce]
e140:    53 10 00 02            or A, A, 0x0002
e144:    d1 01 46               ld B, [0x0146]
e147:    53 02                  or B, A
e149:    f1 01 46               st B, [0x0146]
e14c:    91 01 01               ld A, [SyscallVector+1|0x0101]
e14f:    95 08 01               ld A, [A + 0x01]
e152:    52 10 f8 00            and A, A, 0xf800
e156:    50 10 08 00            add A, A, 0x0800
e15a:    5e                     mov Z, A
e15b:    d1 01 52               ld B, [0x0152]
e15e:    53 32 00 03            or B, B, 0x0003
e162:    f1 01 52               st B, [0x0152]
e165:    d1 01 54               ld B, [0x0154]
e168:    53 32 80 00            or B, B, 0x8000
e16c:    f1 01 54               st B, [0x0154]
e16f:    d1 01 62               ld B, [0x0162]
e172:    53 32 00 07            or B, B, 0x0007
e176:    f1 01 62               st B, [0x0162]
e179:    71 d0 8c               jmp R_d08c

R_e17c:
e17c:    <null bytes>


R_e17d:
e17d:    <null bytes>


R_e17e:
e17e:    <null bytes>


R_e180:
e180:    <null bytes>


R_e182:
e182:    <null bytes>


R_e184:
e184:    <null bytes>


R_e186:
e186:    00
e187:    00
e188:    00
e189:    00

R_e18a:
e18a:    00
e18b:    00

R_e18c:
e18c:    00
e18d:    00

R_e18e:
e18e:    7f 00                  pop {AH}
e190:    <null bytes>


R_e191:
e191:    00                     HALT
e192:    00                     HALT

R_e193:
e193:    00                     HALT
e194:    00                     HALT

R_e195:
e195:    00                     HALT
e196:    00                     HALT

R_e197:
e197:    00                     HALT

R_e198:
e198:    00                     HALT

R_e199:
e199:    00                     HALT
e19a:    01                     nop
e19b:    90 00 00               ld A, 0x0000
e19e:    00                     HALT

R_e19f:
e19f:    00                     HALT
e1a0:    81 00 01               ld AL, [0x0001]
e1a3:    00                     HALT
e1a4:    50 00                  add A, A
e1a6:    00                     HALT
e1a7:    00                     HALT
e1a8:    00                     HALT

R_e1a9:
e1a9:    5, "CODE="

R_e1b0:
e1b0:    7, "\r\nNAME="

R_e1b9:
e1b9:    5, "DISK="

R_e1c0:
e1c0:    32, "INVALID CONFIGURATION DATA SET\r\n"

R_e1e2:
e1e2:    16, "\x0c\x1b\x1cLOS 7.1 - E\r\n"

R_e1f4:
e1f4:    3, "\x1b\x1c\x0c"

LOS_DiskCode:
e1f9:    00 64                  (0x6400)

R_e1fb:
e1fb:    00
e1fc:    01

LOS_Autoboot:
e1fd:    ff                     st B, [P]

LOS_FilePart:
e1fe:    a0 a0                  st AL, 0xa0
e200:    a0 a0                  st AL, 0xa0
e202:    a0 a0                  st AL, 0xa0
e204:    a0 a0                  st AL, 0xa0
e206:    a0 a0                  st AL, 0xa0
e208:    00                     HALT

LOS_FileName:
e209:    a0 a0                  st AL, 0xa0
e20b:    a0 a0                  st AL, 0xa0
e20d:    a0 a0                  st AL, 0xa0
e20f:    a0 a0                  st AL, 0xa0
e211:    a0 a0                  st AL, 0xa0
e213:    00                     HALT

LOS_FilePath:
e214:    4, "@OSN"
e21a:    a0 ' '
e21b:    a0 ' '
e21c:    a0 ' '
e21d:    a0 ' '
e21e:    a0 ' '
e21f:    a0 ' '
e220:    a0 ' '
e221:    a0 ' '
e222:    a0 ' '
e223:    a0 ' '
e224:    a0 ' '
e225:    a0 ' '
e226:    a0 ' '
e227:    a0 ' '
e228:    a0 ' '
e229:    a0 ' '
e22a:    a0 ' '
e22b:    a0 ' '
e22c:    a0 ' '
e22d:    00

R_e22e:
e22e:    c0 d3                  ld BL, 0xd3
e230:    d9                     ld B, [B]
e231:    d3 ae                  ld B, [R_e1c0+33|0xe1e1]
e233:    cf                     ld BL, [P]
e234:    d3 c5                  ld B, [R_e1fb|0xe1fb]
e236:    c7                     unknown
e237:    b0 a0 a0               st A, 0xa0a0
e23a:    a0 a0                  st AL, 0xa0
e23c:    a0 a0                  st AL, 0xa0
e23e:    a0 a0                  st AL, 0xa0
e240:    a0 a0                  st AL, 0xa0
e242:    a0 a0                  st AL, 0xa0
e244:    a0 a0                  st AL, 0xa0
e246:    a0 00                  st AL, 0x00
e248:    00                     HALT

R_e249:
e249:    c4 b3                  ld BL, @[LOS_FilePart|0xe1fe]
e24b:    a0 a0                  st AL, 0xa0

R_e24d:
e24d:    <null bytes>


R_e24f:
e24f:    <null bytes>


R_e251:
e251:    <null bytes>


R_e253:
e253:    <null bytes>


R_e255:
e255:    00
e256:    00

R_e257:
e257:    00
e258:    00

R_e259:
e259:    00
e25a:    00

R_e25b:
e25b:    00
e25c:    00

R_e25d:
e25d:    a0 a0                  st AL, 0xa0
e25f:    a0 a0                  st AL, 0xa0
e261:    a0 a0                  st AL, 0xa0
e263:    a0 a0                  st AL, 0xa0
e265:    a0 a0                  st AL, 0xa0
e267:    a0 a0                  st AL, 0xa0
e269:    a0 a0                  st AL, 0xa0
e26b:    a0 a0                  st AL, 0xa0
e26d:    a0 a0                  st AL, 0xa0
e26f:    a0 a0                  st AL, 0xa0
e271:    a0 a0                  st AL, 0xa0

R_e273:
e273:    c4 b1                  ld BL, @[0xe226]
e275:    a0 a0                  st AL, 0xa0
e277:    01                     nop
e278:    01                     nop
e279:    03                     rf
e27a:    2a                     clr AL, #0
e27b:    5a                     and B, A
e27c:    01                     nop
e27d:    01                     nop
e27e:    00                     HALT
e27f:    01                     nop
e280:    c4 b2                  ld BL, @[0xe234]
e282:    a0 a0                  st AL, 0xa0
e284:    01                     nop
e285:    02                     sf
e286:    03                     rf
e287:    2a                     clr AL, #0
e288:    5a                     and B, A
e289:    01                     nop
e28a:    01                     nop
e28b:    00                     HALT
e28c:    01                     nop
e28d:    c4 b3                  ld BL, @[0xe242]
e28f:    a0 a0                  st AL, 0xa0
e291:    01                     nop
e292:    03                     rf
e293:    03                     rf
e294:    2a                     clr AL, #0
e295:    5a                     and B, A
e296:    01                     nop
e297:    01                     nop
e298:    00                     HALT
e299:    01                     nop
e29a:    c4 b4                  ld BL, @[0xe250]
e29c:    a0 a0                  st AL, 0xa0
e29e:    01                     nop
e29f:    04                     ei
e2a0:    03                     rf
e2a1:    2a                     clr AL, #0
e2a2:    5a                     and B, A
e2a3:    00                     HALT
e2a4:    01                     nop
e2a5:    00                     HALT
e2a6:    01                     nop
e2a7:    c4 b5                  ld BL, @[R_e25d+1|0xe25e]
e2a9:    a0 a0                  st AL, 0xa0
e2ab:    01                     nop
e2ac:    05                     di
e2ad:    03                     rf
e2ae:    2a                     clr AL, #0
e2af:    5a                     and B, A
e2b0:    00                     HALT
e2b1:    01                     nop
e2b2:    00                     HALT
e2b3:    01                     nop
e2b4:    c4 b6                  ld BL, @[0xe26c]
e2b6:    a0 a0                  st AL, 0xa0
e2b8:    0c                     unknown_0c
e2b9:    06                     sl
e2ba:    00                     HALT
e2bb:    60 06 ff               ld X, 0x06ff
e2be:    01                     nop
e2bf:    ff                     st B, [P]
e2c0:    01                     nop
e2c1:    c4 b7                  ld BL, @[0xe27a]
e2c3:    a0 a0                  st AL, 0xa0
e2c5:    0c                     unknown_0c
e2c6:    07                     rl
e2c7:    00                     HALT
e2c8:    c0 06                  ld BL, 0x06
e2ca:    ff                     st B, [P]
e2cb:    01                     nop
e2cc:    ff                     st B, [P]
e2cd:    01                     nop
e2ce:    c4 b8                  ld BL, @[0xe288]
e2d0:    a0 a0                  st AL, 0xa0
e2d2:    0e                     dly
e2d3:    08                     cl
e2d4:    08                     cl
e2d5:    d1 ff 01               ld B, [0xff01]
e2d8:    01                     nop
e2d9:    00                     HALT
e2da:    01                     nop
e2db:    c4 b9                  ld BL, @[0xe296]
e2dd:    a0 a0                  st AL, 0xa0
e2df:    0e                     dly
e2e0:    09                     ret
e2e1:    08
e2e2:    d1 'Q'
e2e3:    ff
e2e4:    01
e2e5:    01
e2e6:    00
e2e7:    01
e2e8:    c4 'D'
e2e9:    b1 '1'
e2ea:    b0 '0'
e2eb:    a0 ' '
e2ec:    0e
e2ed:    0a
e2ee:    08
e2ef:    d1 'Q'
e2f0:    ff
e2f1:    01
e2f2:    01
e2f3:    00
e2f4:    01
e2f5:    c4 'D'
e2f6:    b1 '1'
e2f7:    b1 '1'
e2f8:    a0 ' '
e2f9:    13
e2fa:    0b
e2fb:    04
e2fc:    46
e2fd:    ff
e2fe:    00
e2ff:    01
e300:    00
e301:    01
e302:    c4 'D'
e303:    b1 '1'
e304:    b2 '2'
e305:    a0 ' '
e306:    17
e307:    0c
e308:    03
e309:    90
e30a:    ff
e30b:    00
e30c:    01
e30d:    00
e30e:    01
e30f:    c4 'D'
e310:    b1 '1'
e311:    b3 '3'
e312:    a0 ' '
e313:    0c
e314:    0d
e315:    00
e316:    60
e317:    06
e318:    ff
e319:    01
e31a:    ff
e31b:    01
e31c:    c4 'D'
e31d:    b1 '1'
e31e:    b4 '4'
e31f:    a0 ' '
e320:    0c
e321:    0e
e322:    00
e323:    c4 'D'
e324:    06
e325:    ff
e326:    01
e327:    ff
e328:    01
e329:    ff
e32a:    ff

R_e32b:
e32b:    c1 b3 a0               ld BL, [CrtDevice_InterruptHandler_Exit+2|0xb3a0]
e32e:    a0 09                  st AL, 0x09
e330:    0a                     reti
e331:    03                     rf
e332:    c1 b4 a0               ld BL, [0xb4a0]
e335:    a0 12                  st AL, 0x12
e337:    12 04                  bn L_e33d
e339:    c1 b5 a0               ld BL, [0xb5a0]
e33c:    a0 ' '

L_e33d:
e33d:    09                     ret
e33e:    0a
e33f:    05
e340:    c1 'A'
e341:    b6 '6'
e342:    a0 ' '
e343:    a0 ' '
e344:    09
e345:    0a
e346:    06
e347:    ff
e348:    ff

R_e349:
e349:    cc                     ld BL, [Z]
e34a:    b1 a0 a0               st A, [0xa0a0]
e34d:    08                     cl
e34e:    01                     nop
e34f:    c3 b1                  ld BL, [0xe302]
e351:    a0 a0                  st AL, 0xa0
e353:    08                     cl
e354:    01                     nop
e355:    c3 b2                  ld BL, [0xe309]
e357:    a0 a0                  st AL, 0xa0
e359:    08                     cl
e35a:    02                     sf
e35b:    c3 b3                  ld BL, [0xe310]
e35d:    a0 a0                  st AL, 0xa0
e35f:    08                     cl
e360:    03                     rf
e361:    c3 b4                  ld BL, [0xe317]
e363:    a0 a0                  st AL, 0xa0
e365:    08                     cl
e366:    04                     ei
e367:    c3 b5                  ld BL, [0xe31e]
e369:    a0 a0                  st AL, 0xa0
e36b:    08                     cl
e36c:    05                     di
e36d:    c3 b6                  ld BL, [0xe325]
e36f:    a0 a0                  st AL, 0xa0
e371:    08                     cl
e372:    06                     sl
e373:    c3 b7                  ld BL, [R_e32b+1|0xe32c]
e375:    a0 a0                  st AL, 0xa0
e377:    08                     cl
e378:    07                     rl
e379:    c3 b8                  ld BL, [0xe333]
e37b:    a0 a0                  st AL, 0xa0
e37d:    08                     cl
e37e:    08                     cl
e37f:    c3 b9                  ld BL, [0xe33a]
e381:    a0 a0                  st AL, 0xa0
e383:    08                     cl
e384:    09                     ret
e385:    c3 'C'
e386:    b1 '1'
e387:    b0 '0'
e388:    a0 ' '
e389:    08
e38a:    0a
e38b:    c3 'C'
e38c:    b1 '1'
e38d:    b1 '1'
e38e:    a0 ' '
e38f:    08
e390:    0b
e391:    c3 'C'
e392:    b1 '1'
e393:    b2 '2'
e394:    a0 ' '
e395:    08
e396:    0c
e397:    d0 'P'
e398:    b3 '3'
e399:    a0 ' '
e39a:    a0 ' '
e39b:    04
e39c:    03
e39d:    d0 'P'
e39e:    b4 '4'
e39f:    a0 ' '
e3a0:    a0 ' '
e3a1:    11
e3a2:    04
e3a3:    d0 'P'
e3a4:    b5 '5'
e3a5:    a0 ' '
e3a6:    a0 ' '
e3a7:    14
e3a8:    05
e3a9:    d0 'P'
e3aa:    b6 '6'
e3ab:    a0 ' '
e3ac:    a0 ' '
e3ad:    04
e3ae:    06
e3af:    d0 'P'
e3b0:    b7 '7'
e3b1:    a0 ' '
e3b2:    a0 ' '
e3b3:    08
e3b4:    07
e3b5:    d0 'P'
e3b6:    b1 '1'
e3b7:    b0 '0'
e3b8:    a0 ' '
e3b9:    02
e3ba:    0a
e3bb:    d0 'P'
e3bc:    b1 '1'
e3bd:    b1 '1'
e3be:    a0 ' '
e3bf:    05
e3c0:    0b
e3c1:    d0 'P'
e3c2:    b1 '1'
e3c3:    b2 '2'
e3c4:    a0 ' '
e3c5:    06
e3c6:    0c
e3c7:    d0 'P'
e3c8:    b1 '1'
e3c9:    b3 '3'
e3ca:    a0 ' '
e3cb:    0b
e3cc:    0d
e3cd:    d0 'P'
e3ce:    b1 '1'
e3cf:    b4 '4'
e3d0:    a0 ' '
e3d1:    0f
e3d2:    0e
e3d3:    d0 'P'
e3d4:    b1 '1'
e3d5:    b5 '5'
e3d6:    a0 ' '
e3d7:    10
e3d8:    0f
e3d9:    d0 'P'
e3da:    b1 '1'
e3db:    b6 '6'
e3dc:    a0 ' '
e3dd:    07
e3de:    10
e3df:    d0 'P'
e3e0:    b1 '1'
e3e1:    b7 '7'
e3e2:    a0 ' '
e3e3:    0d
e3e4:    11
e3e5:    d4 'T'
e3e6:    b1 '1'
e3e7:    a0 ' '
e3e8:    a0 ' '
e3e9:    16
e3ea:    01
e3eb:    d4 'T'
e3ec:    b2 '2'
e3ed:    a0 ' '
e3ee:    a0 ' '
e3ef:    15
e3f0:    02
e3f1:    c2 'B'
e3f2:    a0 ' '
e3f3:    a0 ' '
e3f4:    a0 ' '
e3f5:    18
e3f6:    01
e3f7:    ff
e3f8:    ff
e3f9:    <null bytes>


L_f200:
f200:    <null bytes>

