* Label naming:
* ENTRY = Main entry point
* ENTnn = Additional entry point
* B = Byte
* D = Displaced branch/jump target
* F = Function JSR target
* I = 32-bit integer
* J = Jump target
* L = Label (generic)
* N = Bignum
* P = Pointer
* S = String
* W = Word
*
0100:      NOP              ; [No operation]
0101:      NOP              ; [No operation]
0102:      NOP              ; [No operation]
*
* Function ENTRY
*
0103:ENTRY JMP   D0108      ; =+3 [Jump relative]
*
0105:      DW    X'0064'    ; =0x0064 =100
0107:S0107 DC    'E'        ; hex:c5 dec:197(-59)
*
0108:D0108 CLA              ; [Clear A]
0109:      STA/  X'006C'    ; =0x006c =108 [Store A direct]
010c:      STA/  X'00FC'    ; =0x00fc =252 =NUL,'|' [Store A direct]
010f:      STA/  X'00AE'    ; =0x00ae =174 =NUL,'.' [Store A direct]
0112:      LDA=  X'04AF'    ; =0x04af =1199 [Load A with immediate]
0115:      STA/  X'00FE'    ; =0x00fe =254 =NUL,'~' [Store A direct]
0118:      LDAB  S0107      ; =-19 [Load AL relative]
011a:      STAB/ X'03E6'    ; =0x03e6 =998 [Store AL direct]
011d:      STAB/ X'0517'    ; =0x0517 =1303 [Store AL direct]
0120:      LDA=  X'00F0'    ; =0x00f0 =240 =NUL,'p' [Load A with immediate]
0123:      XAS              ; [Transfer A to S]
0124:      BS1   D0128      ; =+2 [Branch if Sense Switch 1 set]
0126:      JMP   D0131      ; =+9 [Jump relative]
0128:D0128 LDX/  X'001A'    ; =0x001a =26 [Load X direct]
012b:      ADD=  X'FFEC',X  ; =0xffec =65516(-20) [65516 + X -> X]
012f:      JMP   D014A      ; =+25 [Jump relative]
0131:D0131 LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
0134:      XAX              ; [Transfer A to X]
0135:      XAY              ; [Transfer A to Y]
0136:D0136 LDAB+ X          ; [Load AL from address in X]
0137:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
0139:      STBB+ X          ; [Store BL to address in X]
013a:      LDBB+ X          ; [Load BL from address in X]
013b:      BZ    D014A      ; =+13 [Branch if zero]
013d:      STAB+ X          ; [Store AL to address in X]
013e:      ADD   Y,X        ; [Y + X -> X]
0140:      LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
0143:      LDA=  X'F000'    ; =0xf000 =61440(-4096) ='p',NUL [Load A with immediate]
0146:      SUB   X,A        ; [X - A -> A]
0148:      BNZ   D0136      ; =-20 [Branch if not zero]
014a:D014A STX/  X'02E0'    ; =0x02e0 =736 [Store X direct]
014d:      XFR   X,B        ; [Transfer X to B]
014f:      ADD=  X'FD53',B  ; =0xfd53 =64851(-685) [64851 + B -> B]
0153:      STB/  X'0449'    ; =0x0449 =1097 [Store B direct]
0156:      ADD=  X'FE70',B  ; =0xfe70 =65136(-400) [65136 + B -> B]
015a:      STB/  X'044B'    ; =0x044b =1099 [Store B direct]
015d:      ADD=  X'FE70',B  ; =0xfe70 =65136(-400) [65136 + B -> B]
0161:      XFR   B,S        ; [Transfer B to S]
0163:      LDB=  X'FEE3'    ; =0xfee3 =65251(-285) ='~','c' [Load B with immediate]
0166:      ADD   X,B        ; [X + B -> B]
0168:      STB/  X'0259'    ; =0x0259 =601 [Store B direct]
016b:      LDAB= X'BD'      ; =189(-67) ='=' [Load AL with immediate]
016d:      STAB/ X'05C1'    ; =0x05c1 =1473 [Store AL direct]
0170:      LDA=  X'0180'    ; =0x0180 =384 [Load A with immediate]
0173:      STA/  X'05A9'    ; =0x05a9 =1449 [Store A direct]
0176:      LDAB= X'B1'      ; =177(-79) ='1' [Load AL with immediate]
0178:      BS4   D017B      ; =+1 [Branch if Sense Switch 4 set]
017a:      DCAB             ; [Decrement AL]
017b:D017B STAB/ X'031D'    ; =0x031d =797 [Store AL direct]
017e:      JMP   D01C2      ; =+66 [Jump relative]
0180:D0180 EI               ; [Enable interrupt system]
0181:      MVF   (1)=X'FF',/X'0208' ; =0x0208 =520 [Move fixed-length, literal=255(-1), direct]
0187:      FIL   (10)=' ',/X'0308' ; =0x0308 =776 [Fill with byte, literal=0xa0(160,-96), direct]
018d:      JSR/  X'0503'    ; =0x0503 =1283 [Jump to subroutine direct]
0190:P0190 JSR/  X'04DF'    ; =0x04df =1247 [Jump to subroutine direct]
0193:      DB    X'02'      ; =0x02 =2
0194:      DC    'e'        ; hex:e5 dec:229(-27)
0195:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
0197:      STAB/ X'02E7'    ; =0x02e7 =743 [Store AL direct]
019a:      JSR*  P0190+1    ; =-11 [Jump to subroutine relative indirect]
019c:      DB    X'02'      ; =0x02 =2
019d:      DC    'q'        ; hex:f1 dec:241(-15)
019e:      JSR/  X'05B2'    ; =0x05b2 =1458 [Jump to subroutine direct]
01a1:      DW    X'0306'    ; =0x0306 =774
01a3:      JSR/  X'04DF'    ; =0x04df =1247 [Jump to subroutine direct]
01a6:      DB    X'02'      ; =0x02 =2
01a7:      DC    'w'        ; hex:f7 dec:247(-9)
01a8:      JSR/  X'05B2'    ; =0x05b2 =1458 [Jump to subroutine direct]
01ab:      DW    X'031B'    ; =0x031b =795
01ad:      JSR/  X'04DF'    ; =0x04df =1247 [Jump to subroutine direct]
01b0:      DB    X'02'      ; =0x02 =2
01b1:      DC    '}'        ; hex:fd dec:253(-3)
01b2:      LDAB= X'01'      ; =1 [Load AL with immediate]
01b4:      STAB/ X'0593'    ; =0x0593 =1427 [Store AL direct]
01b7:      JSR/  X'05B2'    ; =0x05b2 =1458 [Jump to subroutine direct]
01ba:      DW    X'031F'    ; =0x031f =799
01bc:      JSR/  X'04DF'    ; =0x04df =1247 [Jump to subroutine direct]
01bf:      DW    X'0303'    ; =0x0303 =771
01c1:      DI               ; [Disable interrupt system]
01c2:D01C2 JSR/  X'0621'    ; =0x0621 =1569 [Jump to subroutine direct]
01c5:      DW    X'0306'    ; =0x0306 =774
01c7:      LDAB/ X'031D'    ; =0x031d =797 [Load AL direct]
01ca:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
01cc:      SABB             ; [AL - BL -> BL]
01cd:      BM    D0180      ; =-79 [Branch on minus]
01cf:      LDAB= X'03'      ; =3 [Load AL with immediate]
01d1:      SUBB  BL,AL      ; [BL - AL -> AL]
01d3:      BGZ   D0180      ; =-85 [Branch if greater than zero]
01d5:      LDAB= X'01'      ; =1 [Load AL with immediate]
01d7:D01D7 DCRB  BL         ; [Decrement BL by 1]
01d9:      BM    D01DE      ; =+3 [Branch on minus]
01db:      SLAB             ; [Left shift AL]
01dc:      JMP   D01D7      ; =-7 [Jump relative]
01de:D01DE STAB/ X'04A7'    ; =0x04a7 =1191 [Store AL direct]
01e1:      JMP   D01E5      ; =+2 [Jump relative]
01e3:D01E3 JMP   D0180      ; =-101 [Jump relative]
01e5:D01E5 LDA=  X'031F'    ; =0x031f =799 [Load A with immediate]
01e8:      XAZ              ; [Transfer A to Z]
01e9:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
01eb:      BZ    D01F3      ; =+6 [Branch if zero]
01ed:      JSR/  X'0370'    ; =0x0370 =880 [Jump to subroutine direct]
01f0:      STA/  X'0105'    ; =0x0105 =261 [Store A direct]
01f3:D01F3 LDX=  X'000E'    ; =0x000e =14 [Load X with immediate]
01f6:      JSR/  X'044D'    ; =0x044d =1101 [Jump to subroutine direct]
01f9:      DB    X'00'      ; =0x00 =0 =NUL
01fa:      LDAB+ Z,8        ; [Load AL indexed, displaced, direct]
01fd:      INAB             ; [Increment AL]
01fe:      BZ    D0209      ; =+9 [Branch if zero]
0200:      EI               ; [Enable interrupt system]
0201:      JSR/  F04DF      ; =0x04df =1247 [Jump to subroutine direct]
0204:      DW    X'0326'    ; =0x0326 =806
0206:      JMP   D01E3      ; =-37 [Jump relative]
*
0208:      DB    X'00'      ; =0x00 =0 =NUL
*
0209:D0209 LDA+  Z,6        ; [Load A indexed, displaced, direct]
020c:      IVA              ; [Invert A]
020d:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
020f:      RL               ; [Reset link]
0210:      RRR   A          ; [Right rotate A by 1]
0212:      BNL   D0216      ; =+2 [Branch on no link]
0214:      ORIB  BL,AU      ; [BL | AU -> AU]
0216:D0216 LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
0219:      OREB  BL,BU      ; [BL ^ BU -> BU]
021b:      ORE   A,B        ; [A ^ B -> B]
021d:      LDAB/ X'0208'    ; =0x0208 =520 [Load AL direct]
0220:      BNZ   D0227      ; =+5 [Branch if not zero]
0222:      STB/  X'0105'    ; =0x0105 =261 [Store B direct]
0225:      JMP   D0236      ; =+15 [Jump relative]
0227:D0227 LDA/  X'0105'    ; =0x0105 =261 [Load A direct]
022a:      SAB              ; [A - B -> B]
022b:      BZ    D0236      ; =+9 [Branch if zero]
022d:      EI               ; [Enable interrupt system]
022e:      JSR/  F04DF      ; =0x04df =1247 [Jump to subroutine direct]
0231:      DW    X'0346'    ; =0x0346 =838
0233:      JMP/  X'0446'    ; =0x0446 =1094 [Jump direct]
0236:D0236 LDA+  Z,4        ; [Load A indexed, displaced, direct]
0239:      OREB  AL,AU      ; [AL ^ AU -> AU]
023b:      LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
023e:      ORE   A,B        ; [A ^ B -> B]
0240:      LDA/  X'0105'    ; =0x0105 =261 [Load A direct]
0243:      ADD   B,A        ; [B + A -> A]
0245:      SLR   A,4        ; [Left shift A by 4]
0247:      XAX              ; [Transfer A to X]
0248:      JSR/  F044D      ; =0x044d =1101 [Jump to subroutine direct]
024b:      DB    X'00'      ; =0x00 =0 =NUL
024c:      LDA+  Z,14       ; [Load A indexed, displaced, direct]
024f:      STA/  X'0433'    ; =0x0433 =1075 [Store A direct]
0252:      INR   Z,16       ; [Increment Z by 16]
0254:      JSR/  F04B0      ; =0x04b0 =1200 [Jump to subroutine direct]
0257:      DW    X'011D'    ; =0x011d =285
0259:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
025b:      DW    X'0393'    ; =0x0393 =915
*
025d:D025D LDA+  Z          ; [Load A from address in Z]
025e:      LDB=  X'848D'    ; =0x848d =33933(-31603) =EOT,CR [Load B with immediate]
0261:      SAB              ; [A - B -> B]
0262:      BNZ   D0267      ; =+3 [Branch if not zero]
0264:      JMP/  X'01E3'    ; =0x01e3 =483 [Jump direct]
0267:D0267 LDA=  X'0308'    ; =0x0308 =776 [Load A with immediate]
026a:      XAY              ; [Transfer A to Y]
026b:      LDA=  X'0A00'    ; =0x0a00 =2560 [Load A with immediate]
026e:D026E LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
0270:      DCRB  AU         ; [Decrement AU by 1]
0272:      BM    D0297      ; =+35 [Branch on minus]
0274:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
0276:      SABB             ; [AL - BL -> BL]
0277:      BZ    D026E      ; =-11 [Branch if zero]
0279:      XFRB  AU,AL      ; [Transfer AU to AL]
027b:      CLRB  AU         ; [Clear AU]
027d:      ADD   A,Z        ; [A + Z -> Z]
027f:      ADD=  X'0006',Z  ; =0x0006 =6 [6 + Z -> Z]
0283:      LDB/  X'0449'    ; =0x0449 =1097 [Load B direct]
0286:      ADD=  X'0190',B  ; =0x0190 =400 [400 + B -> B]
028a:      SUB   Z,B        ; [Z - B -> B]
028c:      BNZ   D025D      ; =-49 [Branch if not zero]
028e:      INX              ; [Increment X]
028f:      LDA=  X'FF9D'    ; =0xff9d =65437(-99) [Load A with immediate]
0292:      JSR   F02DF      ; =+75 [Jump to subroutine relative]
0294:      DB    X'00'      ; =0x00 =0 =NUL
0295:      JMP   D025D      ; =-58 [Jump relative]
0297:D0297 CLA              ; [Clear A]
0298:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
029a:      XAB              ; [Transfer A to B]
029b:      SLA              ; [Left shift A]
029c:      AAB              ; [A + B -> B]
029d:      LDA/  X'044B'    ; =0x044b =1099 [Load A direct]
02a0:      AAB              ; [A + B -> B]
02a1:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
02a3:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
02a5:      LDX/  X'0433'    ; =0x0433 =1075 [Load X direct]
02a8:      ADD   A,X        ; [A + X -> X]
02aa:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
02ac:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
02ae:      LDA=  X'FF9D'    ; =0xff9d =65437(-99) [Load A with immediate]
02b1:      JSR   F02DF      ; =+44 [Jump to subroutine relative]
02b3:      DB    X'01'      ; =0x01 =1
02b4:      LDB+  S,2        ; [Load B indexed, displaced, direct]
02b7:      CLA              ; [Clear A]
02b8:      LDAB+ B,4        ; [Load AL indexed, displaced, direct]
02bb:      XAX              ; [Transfer A to X]
02bc:      CLA              ; [Clear A]
02bd:      INA              ; [Increment A]
02be:D02BE DCX              ; [Decrement X]
02bf:      BM    D02C4      ; =+3 [Branch on minus]
02c1:      SLA              ; [Left shift A]
02c2:      JMP   D02BE      ; =-6 [Jump relative]
02c4:D02C4 LDB+  S          ; [Load B from address in S]
02c5:      STA+  S          ; [Store A to address in S]
02c6:      LDAB= X'0F'      ; =15 [Load AL with immediate]
02c8:      NABB             ; [AL & BL -> BL]
02c9:      LDAB= X'04'      ; =4 [Load AL with immediate]
02cb:      SABB             ; [AL - BL -> BL]
02cc:      BNZ   D02DC      ; =+14 [Branch if not zero]
02ce:      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
02d1:      LDB   F02DF+1    ; =+13 [Load B relative]
02d3:      AAB              ; [A + B -> B]
02d4:      STB/  X'00FE'    ; =0x00fe =254 =NUL,'~' [Store B direct]
02d7:      LDA=  X'FEE3'    ; =0xfee3 =65251(-285) ='~','c' [Load A with immediate]
02da:      JSR   F02DF      ; =+3 [Jump to subroutine relative]
02dc:D02DC JMP/  X'0180'    ; =0x0180 =384 [Jump direct]
*
* Function F02DF
*
02df:F02DF LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
02e2:      AAB              ; [A + B -> B]
02e3:      JMP+  B          ; [Jump indexed, direct]
*
02e5:      DB    X'00'      ; =0x00 =0 =NUL
02e6:      DW    X'0A8C'    ; =0x0a8c =2700
02e8:      DC    'FDIPL 6.2' ; hex:c6c4c9d0cca0b6aeb2
02f1:      DB    X'00'      ; =0x00 =0 =NUL
02f2:      DB    X'04'      ; =0x04 =4
02f3:      DC    'NAME'     ; hex:cec1cdc5
02f7:      DB    X'00'      ; =0x00 =0 =NUL
02f8:      DB    X'04'      ; =0x04 =4
02f9:      DC    'DISK'     ; hex:c4c9d3cb
02fd:      DB    X'00'      ; =0x00 =0 =NUL
02fe:      DB    X'04'      ; =0x04 =4
02ff:      DC    'CODE'     ; hex:c3cfc4c5
0303:      DB    X'00'      ; =0x00 =0 =NUL
0304:      DW    X'018C'    ; =0x018c =396
0306:      DB    X'00'      ; =0x00 =0 =NUL
0307:      DB    X'13'      ; =0x13 =19
0308:      DC    '@LOAD              '
031b:      DB    X'00'      ; =0x00 =0 =NUL
031c:      DB    X'02'      ; =0x02 =2
031d:      DC    '00'       ; hex:b0b0 dec:45232(-80)
031f:      DB    X'00'      ; =0x00 =0 =NUL
0320:      DB    X'00'      ; =0x00 =0 =NUL
0321:      DC    '     '    ; hex:a0a0a0a0a0
0326:      DB    X'00'      ; =0x00 =0 =NUL
0327:      DB    X'1E'      ; =0x1e =30
0328:      DC    'AB 47 - INCORRECT DISK FORMAT'
0345:      DB    X'8D'      ; =0x8d =141(-115) =CR
0346:      DB    X'00'      ; =0x00 =0 =NUL
0347:      DB    X'1C'      ; =0x1c =28
0348:      DC    'AB 48 - INCORRECT DISK CODE'
0363:      DB    X'8D'      ; =0x8d =141(-115) =CR
*
*
* Function F0364
*
0364:F0364 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
0366:      SABB             ; [AL - BL -> BL]
0367:      BLE   D036C      ; =+3 [Branch if less than or equal to zero]
0369:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
036b:      RSR              ; [Return from subroutine]
*
036c:D036C LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
036e:      SABB             ; [AL - BL -> BL]
036f:      RSR              ; [Return from subroutine]
*
0370:      LDAB+ Z          ; [Load AL from address in Z]
0371:      JSR   F0364      ; =-15 [Jump to subroutine relative]
0373:      BP    D0378      ; =+3 [Branch on plus]
0375:      JMP/  X'0180'    ; =0x0180 =384 [Jump direct]
0378:D0378 CLA              ; [Clear A]
0379:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
037b:D037B LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
037d:      JSR   F0364      ; =-27 [Jump to subroutine relative]
037f:      BP    D0386      ; =+5 [Branch on plus]
0381:      DCR   Z          ; [Decrement Z by 1]
0383:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
0385:      RSR              ; [Return from subroutine]
*
0386:D0386 LDA+  S          ; [Load A from address in S]
0387:      STBB+ S          ; [Store BL to address in S]
0388:      SLA              ; [Left shift A]
0389:      XAB              ; [Transfer A to B]
038a:      SLR   A,2        ; [Left shift A by 2]
038c:      AAB              ; [A + B -> B]
038d:      CLA              ; [Clear A]
038e:      LDAB+ S          ; [Load AL from address in S]
038f:      AAB              ; [A + B -> B]
0390:      STB+  S          ; [Store B to address in S]
0391:      JMP   D037B      ; =-24 [Jump relative]
0393:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
0395:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
0397:      STA   W03CF      ; =+54 [Store A relative]
0399:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
039b:      INR   A,6        ; [Increment A by 6]
039d:      STA   W03FC+1    ; =+94 [Store A relative]
039f:      CLA              ; [Clear A]
03a0:      DCA              ; [Decrement A]
03a1:      STA   W0402+1    ; =+96 [Store A relative]
03a3:      JSR   F03FA      ; =+85 [Jump to subroutine relative]
03a5:      LDB=  X'004C'    ; =0x004c =76 [Load B with immediate]
03a8:      SAB              ; [A - B -> B]
03a9:      BNZ   D03D1      ; =+38 [Branch if not zero]
03ab:      LDA+  Z,27       ; [Load A indexed, displaced, direct]
03ae:      STA   W03F1+1    ; =+66 [Store A relative]
03b0:      ADD   X,Z        ; [X + Z -> Z]
03b2:      INR   Z          ; [Increment Z by 1]
03b4:      JSR   D03E9      ; =+51 [Jump to subroutine relative]
03b6:      INR   Z          ; [Increment Z by 1]
03b8:D03B8 JSR   D03E9      ; =+47 [Jump to subroutine relative]
03ba:      XFRB  BL,BL      ; [Transfer BL to BL]
03bc:      BZ    D03D1      ; =+19 [Branch if zero]
03be:D03BE LDB+  Z+         ; [Load B indexed, direct, post-incremented]
03c0:      LDA   W03F1+1    ; =+48 [Load A relative]
03c2:      AAB              ; [A + B -> B]
03c3:      LDA+  B          ; [Load A from address in B]
03c4:      ADD   Y,A        ; [Y + A -> A]
03c6:      STA+  B          ; [Store A to address in B]
03c7:      DCR   X,2        ; [Decrement X by 2]
03c9:      BGZ   D03BE      ; =-13 [Branch if greater than zero]
03cb:D03CB LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
03cd:      JMP   D03B8      ; =-23 [Jump relative]
*
03cf:W03CF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
03d1:D03D1 XFR   X,X        ; [Transfer X to X]
03d3:      BZ    D03E1      ; =+12 [Branch if zero]
03d5:      XFR   X,A        ; [Transfer X to A]
03d7:      DCA              ; [Decrement A]
03d8:      MVFR  -Z,-Y      ; [Move fixed-length (len-1 in AL), indexed, indexed]
03db:      ADD   X,Y        ; [X + Y -> Y]
03dd:      ADD   X,Z        ; [X + Z -> Z]
03df:      JMP   D03CB      ; =-22 [Jump relative]
03e1:D03E1 XFR=  X'0002',Z  ; =0x0002 =2 [Transfer immediate to Z]
03e5:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
03e7:      JMP+  Y          ; [Jump indexed, direct]
03e9:D03E9 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
03eb:      BM    F03FA      ; =+13 [Branch on minus]
03ed:      CLA              ; [Clear A]
03ee:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
03f0:      STA+  S          ; [Store A to address in S]
03f1:W03F1 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
03f4:      XAY              ; [Transfer A to Y]
03f5:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
03f7:      ADD   A,Y        ; [A + Y -> Y]
03f9:      RSR              ; [Return from subroutine]
*
* Function F03FA
*
03fa:F03FA STX-  S-         ; [Store X indexed, pre-decremented, direct]
03fc:W03FC LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
03ff:      LDX+  A,1        ; [Load X indexed, displaced, direct]
0402:W0402 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
0405:      INA              ; [Increment A]
0406:      STA   W0402+1    ; =-5 [Store A relative]
0408:      ADD   A,X        ; [A + X -> X]
040a:      LDB   W03CF      ; =-61 [Load B relative]
040c:      SAB              ; [A - B -> B]
040d:      BNL   D043F      ; =+48 [Branch on no link]
040f:      CLA              ; [Clear A]
0410:      STA   W0402+1    ; =-15 [Store A relative]
0412:      LDA   W03FC+1    ; =-23 [Load A relative]
0414:      INR   A,3        ; [Increment A by 3]
0416:      STA   W03FC+1    ; =-27 [Store A relative]
0418:      LDX+  A,1        ; [Load X indexed, displaced, direct]
041b:      XAB              ; [Transfer A to B]
041c:      LDA+  A          ; [Load A from address in A]
041d:      BP    D043F      ; =+32 [Branch on plus]
041f:      CLA              ; [Clear A]
0420:      LDAB+ B,2        ; [Load AL indexed, displaced, direct]
0423:      INAB             ; [Increment AL]
0424:      BZ    D0446      ; =+32 [Branch if zero]
0426:      DCAB             ; [Decrement AL]
0427:      XAB              ; [Transfer A to B]
0428:      SLA              ; [Left shift A]
0429:      AAB              ; [A + B -> B]
042a:      LDA   W044B      ; =+31 [Load A relative]
042c:      AAB              ; [A + B -> B]
042d:      LDA*  W03FC+1    ; =-50 [Load A relative indirect]
042f:      STB   W03FC+1    ; =-52 [Store B relative]
0431:      IVA              ; [Invert A]
0432:      LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
0435:      ADD   A,X        ; [A + X -> X]
0437:      JSR   F044D      ; =+20 [Jump to subroutine relative]
0439:      DB    X'01'      ; =0x01 =1
043a:      LDX   W03FC+1    ; =-63 [Load X relative]
043c:      LDX+  X,1        ; [Load X indexed, displaced, direct]
043f:D043F JSR   F044D      ; =+12 [Jump to subroutine relative]
0441:      DB    X'00'      ; =0x00 =0 =NUL
0442:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0444:      JMP   D03E9      ; =-93 [Jump relative]
0446:D0446 HLT              ; [Halt]
0447:      JMP   D0446      ; =-3 [Jump relative]
*
0449:W0449 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
044b:W044B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F044D
*
044d:F044D LDA   W0449      ; =-6 [Load A relative]
044f:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
0451:      BZ    D0455      ; =+2 [Branch if zero]
0453:      LDA   W044B      ; =-10 [Load A relative]
0455:D0455 STA   W047B+1    ; =+37 [Store A relative]
0457:D0457 LDA=  X'FFEC'    ; =0xffec =65516(-20) [Load A with immediate]
045a:      LDB+  S          ; [Load B from address in S]
045b:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
045d:      LDX=  X'82FF'    ; =0x82ff =33535(-32001) [Load X with immediate]
0460:D0460 INX              ; [Increment X]
0461:      AAB              ; [A + B -> B]
0462:      BP    D0460      ; =-4 [Branch on plus]
0464:      SUB   B,A        ; [B - A -> A]
0466:      STAB  B04AB      ; =+67 [Store AL relative]
0468:      STX   W04A8      ; =+62 [Store X relative]
046a:      PCX              ; [Transfer PC to X]
046b:      LDA=  X'003B'    ; =0x003b =59 [Load A with immediate]
046e:      ADD   X,A        ; [X + A -> A]
0470:      LDB=  X'FFF6'    ; =0xfff6 =65526(-10) [Load B with immediate]
0473:      JSR   F049D      ; =+40 [Jump to subroutine relative]
0475:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0477:      LDAB= X'43'      ; =67 [Load AL with immediate]
0479:      JSR   F0486      ; =+11 [Jump to subroutine relative]
047b:W047B LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
047e:      XAZ              ; [Transfer A to Z]
047f:      LDB=  X'FE6F'    ; =0xfe6f =65135(-401) [Load B with immediate]
0482:      JSR   F049D      ; =+25 [Jump to subroutine relative]
0484:      LDAB= X'45'      ; =69 [Load AL with immediate]
*
* Function F0486
*
0486:F0486 STAB/ X'F800'    ; =0xf800 =63488(-2048) ='x',NUL [Store AL direct]
0489:D0489 LDAB/ X'F801'    ; =0xf801 =63489(-2047) [Load AL direct]
048c:      LDBB= X'01'      ; =1 [Load BL with immediate]
048e:      NABB             ; [AL & BL -> BL]
048f:      BZ    D0489      ; =-8 [Branch if zero]
0491:      LDAB* F0486+1    ; =-12 [Load AL relative indirect]
0493:      BNZ   D0496      ; =+1 [Branch if not zero]
0495:      RSR              ; [Return from subroutine]
*
0496:D0496 STA*  F0486+1    ; =-17 [Store A relative indirect]
0498:D0498 DCAB             ; [Decrement AL]
0499:      BNF   D0498      ; =-3 [Branch on no fault]
049b:      JMP   D0457      ; =-70 [Jump relative]
*
* Function F049D
*
049d:F049D DMA   SAD,A      ; [Store A register to DMA address register]
049f:      DMA   SCT,B      ; [Store B register to DMA count register]
04a1:      DMA   SDV,3      ; [Set DMA device]
04a3:      DMA   EAB        ; [Enable DMA]
04a5:      RSR              ; [Return from subroutine]
*
04a6:      DW    X'8100'    ; =0x8100 =33024(-32512)
04a8:W04A8 DW    X'8300'    ; =0x8300 =33536(-32000)
04aa:      DB    X'88'      ; =0x88 =136(-120)
04ab:B04AB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
04ad:      DW    X'0190'    ; =0x0190 =400
04af:      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F04B0
*
04b0:F04B0 LDA+  X+         ; [Load A indexed, direct, post-incremented]
04b2:      XAB              ; [Transfer A to B]
04b3:      JMP/  X'04B6'    ; =0x04b6 =1206 [Jump direct]
04b6:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
04b8:      SAB              ; [A - B -> B]
04b9:      BLE   D04DC      ; =+33 [Branch if less than or equal to zero]
04bb:      LDB+  X          ; [Load B from address in X]
04bc:      JSR/  F0643      ; =0x0643 =1603 [Jump to subroutine direct]
04bf:      DC    ' '        ; hex:a0 dec:160(-96)
*
04c0:D04C0 LDB+  S          ; [Load B from address in S]
04c1:      XFR   Y,A        ; [Transfer Y to A]
04c3:      STA+  S          ; [Store A to address in S]
04c4:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
04c6:      XAY              ; [Transfer A to Y]
04c7:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
04c9:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
04cb:      XFR   B,X        ; [Transfer B to X]
04cd:D04CD DCX              ; [Decrement X]
04ce:      BP    D04D6      ; =+6 [Branch on plus]
04d0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
04d2:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
04d4:      XAY              ; [Transfer A to Y]
04d5:      RSR              ; [Return from subroutine]
*
04d6:D04D6 LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
04d8:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
04da:      JMP   D04CD      ; =-15 [Jump relative]
04dc:D04DC STA+  S          ; [Store A to address in S]
04dd:      JMP   D04C0      ; =-31 [Jump relative]
*
* Function F04DF
*
04df:F04DF JSR   F0503      ; =+34 [Jump to subroutine relative]
04e1:      STK   X,6        ; [Push X Y Z to the stack]
04e3:      LDA+  X          ; [Load A from address in X]
04e4:      XAY              ; [Transfer A to Y]
04e5:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
04e9:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
04eb:      BLE   D04FE      ; =+17 [Branch if less than or equal to zero]
04ed:D04ED LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
04ef:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
04f1:      SABB             ; [AL - BL -> BL]
04f2:      BM    D04F9      ; =+5 [Branch on minus]
04f4:      LDBB= X'20'      ; =32 [Load BL with immediate]
04f6:      SABB             ; [AL - BL -> BL]
04f7:      XFRB  BL,AL      ; [Transfer BL to AL]
04f9:D04F9 JSR   F050D      ; =+18 [Jump to subroutine relative]
04fb:      DCX              ; [Decrement X]
04fc:      BGZ   D04ED      ; =-17 [Branch if greater than zero]
04fe:D04FE POP   X,6        ; [Pop Z Y X from the stack]
0500:      INR   X,2        ; [Increment X by 2]
0502:      RSR              ; [Return from subroutine]
*
* Function F0503
*
0503:F0503 LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
0505:      LDBB  B0548+1    ; =+66 [Load BL relative]
0507:      SABB             ; [AL - BL -> BL]
0508:      BZ    D050C      ; =+2 [Branch if zero]
050a:      JSR   F050D      ; =+1 [Jump to subroutine relative]
050c:D050C RSR              ; [Return from subroutine]
*
* Function F050D
*
050d:F050D STK   Z,2        ; [Push Z to the stack]
050f:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
0513:      SIOB  A,Z,13     ; [Store AL to MMIO address Z+13]
0516:B0516 LDBB= X'C5'      ; =197(-59) ='E' [Load BL with immediate]
0518:      SIOB  B,Z        ; [Store BL to MMIO address in Z]
051b:      LDBB= X'8C'      ; =140(-116) =FF [Load BL with immediate]
051d:      SABB             ; [AL - BL -> BL]
051e:      BZ    D0533      ; =+19 [Branch if zero]
0520:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
0522:      SABB             ; [AL - BL -> BL]
0523:      BNZ   D0539      ; =+20 [Branch if not zero]
0525:      JSR   F053E      ; =+23 [Jump to subroutine relative]
0527:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
0529:      JSR   F053E      ; =+19 [Jump to subroutine relative]
052b:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
052d:      STAB  B0548+1    ; =+26 [Store AL relative]
052f:      DLY              ; [Delay 4.55 ms]
0530:      POP   Z,2        ; [Pop Z from the stack]
0532:      RSR              ; [Return from subroutine]
*
0533:D0533 JSR   F053E      ; =+9 [Jump to subroutine relative]
0535:      DLY              ; [Delay 4.55 ms]
0536:      POP   Z,2        ; [Pop Z from the stack]
0538:      RSR              ; [Return from subroutine]
*
0539:D0539 JSR   F053E      ; =+3 [Jump to subroutine relative]
053b:      POP   Z,2        ; [Pop Z from the stack]
053d:      RSR              ; [Return from subroutine]
*
* Function F053E
*
053e:F053E LIOB  B,Z        ; [Load BL from MMIO address in Z]
0541:      SRRB  BL,2       ; [Right shift BL by 2]
0543:      BNL   F053E      ; =-7 [Branch on no link]
0545:      SIOB  A,Z,1      ; [Store AL to MMIO address Z+1]
0548:B0548 STAB= X'00'      ; =0 =NUL [Store AL immediate]
054a:      RSR              ; [Return from subroutine]
*
054b:D054B LIOB  B,Z,15     ; [Load BL from MMIO address Z+15]
054e:      RI               ; [Return from interrupt]
*
054f:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
0553:      LIOB  A,Z        ; [Load AL from MMIO address in Z]
0556:      SRAB             ; [Right shift AL]
0557:      BL    D0568      ; =+15 [Branch on link]
0559:      LIOB  A,Z,1      ; [Load AL from MMIO address Z+1]
055c:      LIOB  A,Z,3      ; [Load AL from MMIO address Z+3]
055f:      LIOB  A,Z,5      ; [Load AL from MMIO address Z+5]
0562:      LIOB  A,Z,7      ; [Load AL from MMIO address Z+7]
0565:      CLAB             ; [Clear AL]
0566:      JMP   D054B      ; =-29 [Jump relative]
0568:D0568 LIOB  A,Z,1      ; [Load AL from MMIO address Z+1]
056b:      JMP   D054B      ; =-34 [Jump relative]
*
* Function F056D
*
056d:F056D STK   Z,2        ; [Push Z to the stack]
056f:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
0573:      LDAB  B0516+1    ; =-94 [Load AL relative]
0575:      SIOB  A,Z        ; [Store AL to MMIO address in Z]
0578:      LDA=  X'054F'    ; =0x054f =1359 [Load A with immediate]
057b:      SAR   6,P        ; [Store A to P at interrupt level 6]
057d:      CLA              ; [Clear A]
057e:      SAR   6,A        ; [Store A to A at interrupt level 6]
0580:      LDAB= X'06'      ; =6 [Load AL with immediate]
0582:      SIOB  A,Z,10     ; [Store AL to MMIO address Z+10]
0585:      SIOB  A,Z,14     ; [Store AL to MMIO address Z+14]
0588:D0588 LAR   6,A        ; [Load A from A at interrupt level 6]
058a:      XFRB  AL,AU      ; [Transfer AL to AU]
058c:      BZ    D0588      ; =-6 [Branch if zero]
058e:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
0590:      ORIB  BL,AL      ; [BL | AL -> AL]
0592:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
0594:      BNZ   D0599      ; =+3 [Branch if not zero]
0596:      JSR/  F050D      ; =0x050d =1293 [Jump to subroutine direct]
0599:D0599 LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
059b:      SABB             ; [AL - BL -> BL]
059c:      BM    D05A3      ; =+5 [Branch on minus]
059e:      LDBB= X'20'      ; =32 [Load BL with immediate]
05a0:      SABB             ; [AL - BL -> BL]
05a1:      XFRB  BL,AL      ; [Transfer BL to AL]
05a3:D05A3 LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
05a5:      SABB             ; [AL - BL -> BL]
05a6:      BNZ   D05AF      ; =+7 [Branch if not zero]
05a8:W05A8 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
05ab:      BZ    D05AF      ; =+2 [Branch if zero]
05ad:      XFR   B,X        ; [Transfer B to X]
05af:D05AF POP   Z,2        ; [Pop Z from the stack]
05b1:      RSR              ; [Return from subroutine]
*
05b2:      LDA   W05A8+1    ; =-11 [Load A relative]
05b4:      STA   W060D+1    ; =+88 [Store A relative]
05b6:      LDA=  X'0618'    ; =0x0618 =1560 [Load A with immediate]
05b9:      STA   W05A8+1    ; =-18 [Store A relative]
05bb:      LDA+  X          ; [Load A from address in X]
05bc:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
05be:      INA              ; [Increment A]
05bf:      XAX              ; [Transfer A to X]
05c0:      LDAB= X'AF'      ; =175(-81) ='/' [Load AL with immediate]
05c2:      JSR/  F050D      ; =0x050d =1293 [Jump to subroutine direct]
05c5:D05C5 JSR   F056D      ; =-90 [Jump to subroutine relative]
05c7:      LDBB= X'88'      ; =136(-120) [Load BL with immediate]
05c9:      SABB             ; [AL - BL -> BL]
05ca:      BZ    D05D1      ; =+5 [Branch if zero]
05cc:      LDBB= X'95'      ; =149(-107) [Load BL with immediate]
05ce:      SABB             ; [AL - BL -> BL]
05cf:      BNZ   D05ED      ; =+28 [Branch if not zero]
05d1:D05D1 LDB+  *S         ; [Load B indexed, indirect]
05d3:      STAB  B05E0+1    ; =+12 [Store AL relative]
05d5:      INR   B          ; [Increment B by 1]
05d7:      SUB   X,B        ; [X - B -> B]
05d9:      BZ    D05E7      ; =+12 [Branch if zero]
05db:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
05dd:P05DD JSR/  F050D      ; =0x050d =1293 [Jump to subroutine direct]
05e0:B05E0 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
05e2:      JSR*  P05DD+1    ; =-6 [Jump to subroutine relative indirect]
05e4:      DCX              ; [Decrement X]
05e5:      JMP   D05C5      ; =-34 [Jump relative]
05e7:D05E7 LDAB= X'86'      ; =134(-122) [Load AL with immediate]
05e9:      JSR*  P05DD+1    ; =-13 [Jump to subroutine relative indirect]
05eb:      JMP   D05C5      ; =-40 [Jump relative]
05ed:D05ED LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
05ef:      SABB             ; [AL - BL -> BL]
05f0:      BZ    D0604      ; =+18 [Branch if zero]
05f2:      STAB  B05FF+1    ; =+12 [Store AL relative]
05f4:      LDA+  *S         ; [Load A indexed, indirect]
05f6:      LDB=  X'0085'    ; =0x0085 =133 [Load B with immediate]
05f9:      AAB              ; [A + B -> B]
05fa:      SUB   X,B        ; [X - B -> B]
05fc:      BP    D0604      ; =+6 [Branch on plus]
05fe:      INX              ; [Increment X]
05ff:B05FF LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
0601:      STAB+ X          ; [Store AL to address in X]
0602:      JMP   D05C5      ; =-63 [Jump relative]
0604:D0604 LDA+  *S         ; [Load A indexed, indirect]
0606:      INA              ; [Increment A]
0607:      SUB   X,A        ; [X - A -> A]
0609:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
060b:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
060d:W060D LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
0610:      STB   W05A8+1    ; =-105 [Store B relative]
0612:      CLRB  BL         ; [Clear BL]
0614:      STBB/ X'0593'    ; =0x0593 =1427 [Store BL direct]
0617:      RSR              ; [Return from subroutine]
*
0618:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
061a:      CLA              ; [Clear A]
061b:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
061d:      LDX   W060D+1    ; =-17 [Load X relative]
061f:      JMP   W060D      ; =-20 [Jump relative]
0621:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
0623:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0625:      XFR   Y,X        ; [Transfer Y to X]
0627:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0629:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
062b:      XAY              ; [Transfer A to Y]
062c:D062C DCX              ; [Decrement X]
062d:      BM    D063D      ; =+14 [Branch on minus]
062f:      LDAB+ Y          ; [Load AL from address in Y]
0630:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
0632:      SABB             ; [AL - BL -> BL]
0633:      BM    D0639      ; =+4 [Branch on minus]
0635:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
0637:      ADDB  BL,AL      ; [BL + AL -> AL]
0639:D0639 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
063b:      JMP   D062C      ; =-17 [Jump relative]
063d:D063D LDA+  S+         ; [Load A indexed, direct, post-incremented]
063f:      XAY              ; [Transfer A to Y]
0640:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0642:      RSR              ; [Return from subroutine]
*
* Function F0643
*
0643:F0643 STX-  S-         ; [Store X indexed, pre-decremented, direct]
0645:      XAX              ; [Transfer A to X]
0646:      LDAB+ *S         ; [Load AL indexed, indirect]
0648:D0648 DCX              ; [Decrement X]
0649:      BP    D064F      ; =+4 [Branch on plus]
064b:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
064d:      INX              ; [Increment X]
064e:      RSR              ; [Return from subroutine]
*
064f:D064F STAB+ B+         ; [Store AL indexed, direct, post-incremented]
0651:      JMP   D0648      ; =-11 [Jump relative]
*
0653:      DB    0,2732     ; =0x00,0x0aac
10ff:ENDPT
