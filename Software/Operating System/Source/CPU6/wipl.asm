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
0112:      LDA=  X'0506'    ; =0x0506 =1286 [Load A with immediate]
0115:      STA/  X'00FE'    ; =0x00fe =254 =NUL,'~' [Store A direct]
0118:      LDAB  S0107      ; =-19 [Load AL relative]
011a:      STAB/ X'043D'    ; =0x043d =1085 [Store AL direct]
011d:      STAB/ X'056E'    ; =0x056e =1390 [Store AL direct]
0120:      LDA=  X'00F0'    ; =0x00f0 =240 =NUL,'p' [Load A with immediate]
0123:      XAS              ; [Transfer A to S]
0124:      LDAB= X'F1'      ; =241(-15) ='q' [Load AL with immediate]
0126:      JSR   F0141      ; =+25 [Jump to subroutine relative]
0128:      LDAB= X'F5'      ; =245(-11) ='u' [Load AL with immediate]
012a:      JSR   F0141      ; =+21 [Jump to subroutine relative]
012c:      LDAB= X'F9'      ; =249(-7) ='y' [Load AL with immediate]
012e:      JSR   F0141      ; =+17 [Jump to subroutine relative]
0130:      LDAB= X'FD'      ; =253(-3) ='}' [Load AL with immediate]
0132:      JSR   F0141      ; =+13 [Jump to subroutine relative]
0134:      BS1   D0138      ; =+2 [Branch if Sense Switch 1 set]
0136:      JMP   D016F      ; =+55 [Jump relative]
0138:D0138 LDX/  X'001A'    ; =0x001a =26 [Load X direct]
013b:      ADD=  X'FFEC',X  ; =0xffec =65516(-20) [65516 + X -> X]
013f:      JMP   D0185      ; =+68 [Jump relative]
*
* Function F0141
*
0141:F0141 STAB  B014B+1    ; =+9 [Store AL relative]
0143:      STAB  B0151+1    ; =+13 [Store AL relative]
0145:      STAB  B015C+1    ; =+22 [Store AL relative]
0147:      STAB  B0162+1    ; =+26 [Store AL relative]
0149:      LDAB= X'07'      ; =7 [Load AL with immediate]
014b:B014B STAB/ X'F140'    ; =0xf140 =61760(-3776) [Store AL direct]
014e:      LDB=  X'3000'    ; =0x3000 =12288 [Load B with immediate]
0151:B0151 LDBB/ X'F145'    ; =0xf145 =61765(-3771) [Load BL direct]
0154:      ANDB  BU,BL      ; [BU & BL -> BL]
0156:      SUBB  BU,BL      ; [BU - BL -> BL]
0158:      BNZ   D016B      ; =+17 [Branch if not zero]
015a:      LDBB= X'03'      ; =3 [Load BL with immediate]
015c:B015C STBB/ X'F148'    ; =0xf148 =61768(-3768) [Store BL direct]
015f:      LDB=  X'3000'    ; =0x3000 =12288 [Load B with immediate]
0162:B0162 LDBB/ X'F145'    ; =0xf145 =61765(-3771) [Load BL direct]
0165:      ANDB  BU,BL      ; [BU & BL -> BL]
0167:      SUBB  BU,BL      ; [BU - BL -> BL]
0169:      BNZ   B0162      ; =-9 [Branch if not zero]
016b:D016B DCAB             ; [Decrement AL]
016c:      BP    B014B      ; =-35 [Branch on plus]
016e:      RSR              ; [Return from subroutine]
*
016f:D016F LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
0172:      XAX              ; [Transfer A to X]
0173:      XAY              ; [Transfer A to Y]
0174:D0174 LDAB+ X          ; [Load AL from address in X]
0175:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
0177:      STBB+ X          ; [Store BL to address in X]
0178:      LDBB+ X          ; [Load BL from address in X]
0179:      BZ    D0185      ; =+10 [Branch if zero]
017b:      STAB+ X          ; [Store AL to address in X]
017c:      ADD   Y,X        ; [Y + X -> X]
017e:      LDA=  X'F000'    ; =0xf000 =61440(-4096) ='p',NUL [Load A with immediate]
0181:      SUB   X,A        ; [X - A -> A]
0183:      BNZ   D0174      ; =-17 [Branch if not zero]
0185:D0185 STX/  X'033D'    ; =0x033d =829 [Store X direct]
0188:      XFR   X,B        ; [Transfer X to B]
018a:      ADD=  X'FD55',B  ; =0xfd55 =64853(-683) [64853 + B -> B]
018e:      STB/  X'04A0'    ; =0x04a0 =1184 [Store B direct]
0191:      ADD=  X'FE70',B  ; =0xfe70 =65136(-400) [65136 + B -> B]
0195:      STB/  X'04A2'    ; =0x04a2 =1186 [Store B direct]
0198:      ADD=  X'FE70',B  ; =0xfe70 =65136(-400) [65136 + B -> B]
019c:      XFR   B,S        ; [Transfer B to S]
019e:      LDB=  X'FEE5'    ; =0xfee5 =65253(-283) ='~','e' [Load B with immediate]
01a1:      ADD   X,B        ; [X + B -> B]
01a3:      STB/  X'02B6'    ; =0x02b6 =694 [Store B direct]
01a6:      LDAB= X'BD'      ; =189(-67) ='=' [Load AL with immediate]
01a8:      STAB/ X'0618'    ; =0x0618 =1560 [Store AL direct]
01ab:      LDA=  X'01BB'    ; =0x01bb =443 [Load A with immediate]
01ae:      STA/  X'0600'    ; =0x0600 =1536 [Store A direct]
01b1:      LDAB= X'B1'      ; =177(-79) ='1' [Load AL with immediate]
01b3:      BS4   D01B6      ; =+1 [Branch if Sense Switch 4 set]
01b5:      DCAB             ; [Decrement AL]
01b6:D01B6 STAB/ X'0377'    ; =0x0377 =887 [Store AL direct]
01b9:      JMP   D01FD      ; =+66 [Jump relative]
01bb:      EI               ; [Enable interrupt system]
01bc:      MVF   (1)=X'FF',/X'0265' ; =0x0265 =613 [Move fixed-length, literal=255(-1), direct]
01c2:      FIL   (10)=' ',/X'0365' ; =0x0365 =869 [Fill with byte, literal=0xa0(160,-96), direct]
01c8:      JSR/  X'055A'    ; =0x055a =1370 [Jump to subroutine direct]
01cb:P01CB JSR/  X'0536'    ; =0x0536 =1334 [Jump to subroutine direct]
01ce:      DW    X'0342'    ; =0x0342 =834
01d0:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
01d2:      STAB/ X'0344'    ; =0x0344 =836 [Store AL direct]
01d5:      JSR*  P01CB+1    ; =-11 [Jump to subroutine relative indirect]
01d7:      DW    X'034E'    ; =0x034e =846
01d9:      JSR/  X'0609'    ; =0x0609 =1545 [Jump to subroutine direct]
01dc:      DW    X'0363'    ; =0x0363 =867
01de:      JSR/  X'0536'    ; =0x0536 =1334 [Jump to subroutine direct]
01e1:      DW    X'0354'    ; =0x0354 =852
01e3:      JSR/  X'0609'    ; =0x0609 =1545 [Jump to subroutine direct]
01e6:      DW    X'0374'    ; =0x0374 =884
01e8:      JSR/  X'0536'    ; =0x0536 =1334 [Jump to subroutine direct]
01eb:      DW    X'035A'    ; =0x035a =858
01ed:      LDAB= X'01'      ; =1 [Load AL with immediate]
01ef:      STAB/ X'05EA'    ; =0x05ea =1514 [Store AL direct]
01f2:      JSR/  X'0609'    ; =0x0609 =1545 [Jump to subroutine direct]
01f5:      DW    X'0378'    ; =0x0378 =888
01f7:      JSR/  X'0536'    ; =0x0536 =1334 [Jump to subroutine direct]
01fa:      DW    X'0360'    ; =0x0360 =864
01fc:      DI               ; [Disable interrupt system]
01fd:D01FD JSR/  X'0678'    ; =0x0678 =1656 [Jump to subroutine direct]
0200:      DW    X'0363'    ; =0x0363 =867
0202:      LDA=  X'0374'    ; =0x0374 =884 [Load A with immediate]
0205:      XAZ              ; [Transfer A to Z]
0206:      LDB+  Z+         ; [Load B indexed, direct, post-incremented]
0208:      DCR   B          ; [Decrement B by 1]
020a:      BZ    D021C      ; =+16 [Branch if zero]
020c:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
020e:      LDBB+ Z,1        ; [Load BL indexed, displaced, direct]
0211:      SABB             ; [AL - BL -> BL]
0212:      BZ    D021C      ; =+8 [Branch if zero]
0214:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
0216:      SABB             ; [AL - BL -> BL]
0217:      BZ    D021C      ; =+3 [Branch if zero]
0219:      LDAB= X'F0'      ; =240(-16) ='p' [Load AL with immediate]
021b:      SABB             ; [AL - BL -> BL]
021c:D021C XFRB  BL,AL      ; [Transfer BL to AL]
021e:      SLRB  AL,2       ; [Left shift AL by 2]
0220:      LDB=  X'F140'    ; =0xf140 =61760(-3776) [Load B with immediate]
0223:      ORIB  AL,BU      ; [AL | BU -> BU]
0225:      STB/  X'04B1'    ; =0x04b1 =1201 [Store B direct]
0228:      SLRB  AL,2       ; [Left shift AL by 2]
022a:      LDBB= X'04'      ; =4 [Load BL with immediate]
022c:      AABB             ; [AL + BL -> BL]
022d:      STBB/ X'04AC'    ; =0x04ac =1196 [Store BL direct]
0230:      LDAB+ Z          ; [Load AL from address in Z]
0231:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
0233:      SABB             ; [AL - BL -> BL]
0234:      BM    D023C      ; =+6 [Branch on minus]
0236:      LDAB= X'07'      ; =7 [Load AL with immediate]
0238:      SUBB  BL,AL      ; [BL - AL -> AL]
023a:      BLE   D023F      ; =+3 [Branch if less than or equal to zero]
023c:D023C JMP/  X'01BB'    ; =0x01bb =443 [Jump direct]
023f:D023F STBB$ X'04B1'    ; =0x04b1 =1201 [Store BL indirect]
0242:      LDA=  X'0378'    ; =0x0378 =888 [Load A with immediate]
0245:      XAZ              ; [Transfer A to Z]
0246:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
0248:      BZ    D0250      ; =+6 [Branch if zero]
024a:      JSR/  F03C9      ; =0x03c9 =969 [Jump to subroutine direct]
024d:      STA/  X'0105'    ; =0x0105 =261 [Store A direct]
0250:D0250 LDX=  X'000E'    ; =0x000e =14 [Load X with immediate]
0253:      JSR/  F04B0      ; =0x04b0 =1200 [Jump to subroutine direct]
0256:      DB    X'00'      ; =0x00 =0 =NUL
0257:      LDAB+ Z,8        ; [Load AL indexed, displaced, direct]
025a:      INAB             ; [Increment AL]
025b:      BZ    D0266      ; =+9 [Branch if zero]
025d:      EI               ; [Enable interrupt system]
025e:      JSR/  F0536      ; =0x0536 =1334 [Jump to subroutine direct]
0261:      DW    X'037F'    ; =0x037f =895
0263:      JMP   D023C      ; =-41 [Jump relative]
*
0265:      DB    X'00'      ; =0x00 =0 =NUL
*
0266:D0266 LDA+  Z,6        ; [Load A indexed, displaced, direct]
0269:      IVA              ; [Invert A]
026a:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
026c:      RL               ; [Reset link]
026d:      RRR   A          ; [Right rotate A by 1]
026f:      BNL   D0273      ; =+2 [Branch on no link]
0271:      ORIB  BL,AU      ; [BL | AU -> AU]
0273:D0273 LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
0276:      OREB  BL,BU      ; [BL ^ BU -> BU]
0278:      ORE   A,B        ; [A ^ B -> B]
027a:      LDAB/ X'0265'    ; =0x0265 =613 [Load AL direct]
027d:      BNZ   D0284      ; =+5 [Branch if not zero]
027f:      STB/  X'0105'    ; =0x0105 =261 [Store B direct]
0282:      JMP   D0293      ; =+15 [Jump relative]
0284:D0284 LDA/  X'0105'    ; =0x0105 =261 [Load A direct]
0287:      SAB              ; [A - B -> B]
0288:      BZ    D0293      ; =+9 [Branch if zero]
028a:      EI               ; [Enable interrupt system]
028b:      JSR/  F0536      ; =0x0536 =1334 [Jump to subroutine direct]
028e:      DW    X'039F'    ; =0x039f =927
0290:      JMP/  X'049D'    ; =0x049d =1181 [Jump direct]
0293:D0293 LDA+  Z,4        ; [Load A indexed, displaced, direct]
0296:      OREB  AL,AU      ; [AL ^ AU -> AU]
0298:      LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
029b:      ORE   A,B        ; [A ^ B -> B]
029d:      LDA/  X'0105'    ; =0x0105 =261 [Load A direct]
02a0:      ADD   B,A        ; [B + A -> A]
02a2:      SLR   A,4        ; [Left shift A by 4]
02a4:      XAX              ; [Transfer A to X]
02a5:      JSR/  F04B0      ; =0x04b0 =1200 [Jump to subroutine direct]
02a8:      DB    X'00'      ; =0x00 =0 =NUL
02a9:      LDA+  Z,14       ; [Load A indexed, displaced, direct]
02ac:      STA/  X'048A'    ; =0x048a =1162 [Store A direct]
02af:      INR   Z,16       ; [Increment Z by 16]
02b1:      JSR/  F0507      ; =0x0507 =1287 [Jump to subroutine direct]
02b4:      DW    X'011B'    ; =0x011b =283
02b6:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
02b8:      DB    X'03'      ; =0x03 =3
02b9:      DC    'l'        ; hex:ec dec:236(-20)
*
02ba:D02BA LDA+  Z          ; [Load A from address in Z]
02bb:      LDB=  X'848D'    ; =0x848d =33933(-31603) =EOT,CR [Load B with immediate]
02be:      SAB              ; [A - B -> B]
02bf:      BNZ   D02C4      ; =+3 [Branch if not zero]
02c1:      JMP/  X'023C'    ; =0x023c =572 [Jump direct]
02c4:D02C4 LDA=  X'0365'    ; =0x0365 =869 [Load A with immediate]
02c7:      XAY              ; [Transfer A to Y]
02c8:      LDA=  X'0A00'    ; =0x0a00 =2560 [Load A with immediate]
02cb:D02CB LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
02cd:      DCRB  AU         ; [Decrement AU by 1]
02cf:      BM    D02F4      ; =+35 [Branch on minus]
02d1:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
02d3:      SABB             ; [AL - BL -> BL]
02d4:      BZ    D02CB      ; =-11 [Branch if zero]
02d6:      XFRB  AU,AL      ; [Transfer AU to AL]
02d8:      CLRB  AU         ; [Clear AU]
02da:      ADD   A,Z        ; [A + Z -> Z]
02dc:      ADD=  X'0006',Z  ; =0x0006 =6 [6 + Z -> Z]
02e0:      LDB/  X'04A0'    ; =0x04a0 =1184 [Load B direct]
02e3:      ADD=  X'0190',B  ; =0x0190 =400 [400 + B -> B]
02e7:      SUB   Z,B        ; [Z - B -> B]
02e9:      BNZ   D02BA      ; =-49 [Branch if not zero]
02eb:      INX              ; [Increment X]
02ec:      LDA=  X'FFA9'    ; =0xffa9 =65449(-87) [Load A with immediate]
02ef:      JSR   F033C      ; =+75 [Jump to subroutine relative]
02f1:      DB    X'00'      ; =0x00 =0 =NUL
02f2:      JMP   D02BA      ; =-58 [Jump relative]
02f4:D02F4 CLA              ; [Clear A]
02f5:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
02f7:      XAB              ; [Transfer A to B]
02f8:      SLA              ; [Left shift A]
02f9:      AAB              ; [A + B -> B]
02fa:      LDA/  X'04A2'    ; =0x04a2 =1186 [Load A direct]
02fd:      AAB              ; [A + B -> B]
02fe:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
0300:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
0302:      LDX/  X'048A'    ; =0x048a =1162 [Load X direct]
0305:      ADD   A,X        ; [A + X -> X]
0307:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0309:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
030b:      LDA=  X'FFA9'    ; =0xffa9 =65449(-87) [Load A with immediate]
030e:      JSR   F033C      ; =+44 [Jump to subroutine relative]
0310:      DB    X'01'      ; =0x01 =1
0311:      LDB+  S,2        ; [Load B indexed, displaced, direct]
0314:      CLA              ; [Clear A]
0315:      LDAB+ B,4        ; [Load AL indexed, displaced, direct]
0318:      XAX              ; [Transfer A to X]
0319:      CLA              ; [Clear A]
031a:      INA              ; [Increment A]
031b:D031B DCX              ; [Decrement X]
031c:      BM    D0321      ; =+3 [Branch on minus]
031e:      SLA              ; [Left shift A]
031f:      JMP   D031B      ; =-6 [Jump relative]
0321:D0321 LDB+  S          ; [Load B from address in S]
0322:      STA+  S          ; [Store A to address in S]
0323:      LDAB= X'0F'      ; =15 [Load AL with immediate]
0325:      NABB             ; [AL & BL -> BL]
0326:      LDAB= X'04'      ; =4 [Load AL with immediate]
0328:      SABB             ; [AL - BL -> BL]
0329:      BNZ   D0339      ; =+14 [Branch if not zero]
032b:      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
032e:      LDB   F033C+1    ; =+13 [Load B relative]
0330:      AAB              ; [A + B -> B]
0331:      STB/  X'00FE'    ; =0x00fe =254 =NUL,'~' [Store B direct]
0334:      LDA=  X'FEE5'    ; =0xfee5 =65253(-283) ='~','e' [Load A with immediate]
0337:      JSR   F033C      ; =+3 [Jump to subroutine relative]
0339:D0339 JMP/  X'01BB'    ; =0x01bb =443 [Jump direct]
*
* Function F033C
*
033c:F033C LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
033f:      AAB              ; [A + B -> B]
0340:      JMP+  B          ; [Jump indexed, direct]
*
0342:      DB    X'00'      ; =0x00 =0 =NUL
0343:      DW    X'0A8C'    ; =0x0a8c =2700
0345:      DC    'HDIPL 6.2' ; hex:c8c4c9d0cca0b6aeb2
034e:      DB    X'00'      ; =0x00 =0 =NUL
034f:      DB    X'04'      ; =0x04 =4
0350:      DC    'NAME'     ; hex:cec1cdc5
0354:      DB    X'00'      ; =0x00 =0 =NUL
0355:      DB    X'04'      ; =0x04 =4
0356:      DC    'DISK'     ; hex:c4c9d3cb
035a:      DB    X'00'      ; =0x00 =0 =NUL
035b:      DB    X'04'      ; =0x04 =4
035c:      DC    'CODE'     ; hex:c3cfc4c5
0360:      DB    X'00'      ; =0x00 =0 =NUL
0361:      DW    X'018C'    ; =0x018c =396
0363:      DB    X'00'      ; =0x00 =0 =NUL
0364:      DB    X'0F'      ; =0x0f =15
0365:      DC    '@LOAD          '
0374:      DB    X'00'      ; =0x00 =0 =NUL
0375:      DB    X'02'      ; =0x02 =2
0376:      DC    '00'       ; hex:b0b0 dec:45232(-80)
0378:      DB    X'00'      ; =0x00 =0 =NUL
0379:      DB    X'00'      ; =0x00 =0 =NUL
037a:      DC    '     '    ; hex:a0a0a0a0a0
037f:      DB    X'00'      ; =0x00 =0 =NUL
0380:      DB    X'1E'      ; =0x1e =30
0381:      DC    'AB 47 - INCORRECT DISK FORMAT'
039e:      DB    X'8D'      ; =0x8d =141(-115) =CR
039f:      DB    X'00'      ; =0x00 =0 =NUL
03a0:      DB    X'1C'      ; =0x1c =28
03a1:      DC    'AB 48 - INCORRECT DISK CODE'
03bc:      DB    X'8D'      ; =0x8d =141(-115) =CR
*
*
* Function F03BD
*
03bd:F03BD LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
03bf:      SABB             ; [AL - BL -> BL]
03c0:      BLE   D03C5      ; =+3 [Branch if less than or equal to zero]
03c2:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
03c4:      RSR              ; [Return from subroutine]
*
03c5:D03C5 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
03c7:      SABB             ; [AL - BL -> BL]
03c8:      RSR              ; [Return from subroutine]
*
* Function F03C9
*
03c9:F03C9 LDAB+ Z          ; [Load AL from address in Z]
03ca:      JSR   F03BD      ; =-15 [Jump to subroutine relative]
03cc:      BP    D03D1      ; =+3 [Branch on plus]
03ce:      JMP/  X'01BB'    ; =0x01bb =443 [Jump direct]
03d1:D03D1 CLA              ; [Clear A]
03d2:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
03d4:D03D4 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
03d6:      JSR   F03BD      ; =-27 [Jump to subroutine relative]
03d8:      BP    D03DF      ; =+5 [Branch on plus]
03da:      DCR   Z          ; [Decrement Z by 1]
03dc:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
03de:      RSR              ; [Return from subroutine]
*
03df:D03DF LDA+  S          ; [Load A from address in S]
03e0:      STBB+ S          ; [Store BL to address in S]
03e1:      SLA              ; [Left shift A]
03e2:      XAB              ; [Transfer A to B]
03e3:      SLR   A,2        ; [Left shift A by 2]
03e5:      AAB              ; [A + B -> B]
03e6:      CLA              ; [Clear A]
03e7:      LDAB+ S          ; [Load AL from address in S]
03e8:      AAB              ; [A + B -> B]
03e9:      STB+  S          ; [Store B to address in S]
03ea:      JMP   D03D4      ; =-24 [Jump relative]
03ec:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
03ee:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
03f0:      STA   W0428      ; =+54 [Store A relative]
03f2:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
03f4:      INR   A,6        ; [Increment A by 6]
03f6:      STA   W0453+1    ; =+92 [Store A relative]
03f8:      CLA              ; [Clear A]
03f9:      DCA              ; [Decrement A]
03fa:      STA   W0459+1    ; =+94 [Store A relative]
03fc:      JSR   F0451      ; =+83 [Jump to subroutine relative]
03fe:      LDB=  X'004C'    ; =0x004c =76 [Load B with immediate]
0401:      SAB              ; [A - B -> B]
0402:      BNZ   D042A      ; =+38 [Branch if not zero]
0404:      LDA+  Z,27       ; [Load A indexed, displaced, direct]
0407:      STA   W0448+1    ; =+64 [Store A relative]
0409:      ADD   X,Z        ; [X + Z -> Z]
040b:      INR   Z          ; [Increment Z by 1]
040d:      JSR   D0440      ; =+49 [Jump to subroutine relative]
040f:      INR   Z          ; [Increment Z by 1]
0411:D0411 JSR   D0440      ; =+45 [Jump to subroutine relative]
0413:      XFRB  BL,BL      ; [Transfer BL to BL]
0415:      BZ    D042A      ; =+19 [Branch if zero]
0417:D0417 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
0419:      LDA   W0448+1    ; =+46 [Load A relative]
041b:      AAB              ; [A + B -> B]
041c:      LDA+  B          ; [Load A from address in B]
041d:      ADD   Y,A        ; [Y + A -> A]
041f:      STA+  B          ; [Store A to address in B]
0420:      DCR   X,2        ; [Decrement X by 2]
0422:      BGZ   D0417      ; =-13 [Branch if greater than zero]
0424:D0424 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0426:      JMP   D0411      ; =-23 [Jump relative]
*
0428:W0428 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
042a:D042A XFR   X,X        ; [Transfer X to X]
042c:      BZ    D043A      ; =+12 [Branch if zero]
042e:      XFR   X,A        ; [Transfer X to A]
0430:      DCA              ; [Decrement A]
0431:      MVFR  -Z,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
0434:      ADD   X,Y        ; [X + Y -> Y]
0436:      ADD   X,Z        ; [X + Z -> Z]
0438:      JMP   D0424      ; =-22 [Jump relative]
043a:D043A CLR   Z          ; [Clear Z]
043c:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
043e:      JMP+  Y          ; [Jump indexed, direct]
0440:D0440 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
0442:      BM    F0451      ; =+13 [Branch on minus]
0444:      CLA              ; [Clear A]
0445:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0447:      STA+  S          ; [Store A to address in S]
0448:W0448 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
044b:      XAY              ; [Transfer A to Y]
044c:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
044e:      ADD   A,Y        ; [A + Y -> Y]
0450:      RSR              ; [Return from subroutine]
*
* Function F0451
*
0451:F0451 STX-  S-         ; [Store X indexed, pre-decremented, direct]
0453:W0453 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
0456:      LDX+  A,1        ; [Load X indexed, displaced, direct]
0459:W0459 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
045c:      INA              ; [Increment A]
045d:      STA   W0459+1    ; =-5 [Store A relative]
045f:      ADD   A,X        ; [A + X -> X]
0461:      LDB   W0428      ; =-59 [Load B relative]
0463:      SAB              ; [A - B -> B]
0464:      BNL   D0496      ; =+48 [Branch on no link]
0466:      CLA              ; [Clear A]
0467:      STA   W0459+1    ; =-15 [Store A relative]
0469:      LDA   W0453+1    ; =-23 [Load A relative]
046b:      INR   A,3        ; [Increment A by 3]
046d:      STA   W0453+1    ; =-27 [Store A relative]
046f:      LDX+  A,1        ; [Load X indexed, displaced, direct]
0472:      XAB              ; [Transfer A to B]
0473:      LDA+  A          ; [Load A from address in A]
0474:      BP    D0496      ; =+32 [Branch on plus]
0476:      CLA              ; [Clear A]
0477:      LDAB+ B,2        ; [Load AL indexed, displaced, direct]
047a:      INAB             ; [Increment AL]
047b:      BZ    D049D      ; =+32 [Branch if zero]
047d:      DCAB             ; [Decrement AL]
047e:      XAB              ; [Transfer A to B]
047f:      SLA              ; [Left shift A]
0480:      AAB              ; [A + B -> B]
0481:      LDA   W04A2      ; =+31 [Load A relative]
0483:      AAB              ; [A + B -> B]
0484:      LDA*  W0453+1    ; =-50 [Load A relative indirect]
0486:      STB   W0453+1    ; =-52 [Store B relative]
0488:      IVA              ; [Invert A]
0489:      LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
048c:      ADD   A,X        ; [A + X -> X]
048e:      JSR   F04B0      ; =+32 [Jump to subroutine relative]
0490:      DB    X'01'      ; =0x01 =1
0491:      LDX   W0453+1    ; =-63 [Load X relative]
0493:      LDX+  X,1        ; [Load X indexed, displaced, direct]
0496:D0496 JSR   F04B0      ; =+24 [Jump to subroutine relative]
0498:      DB    X'00'      ; =0x00 =0 =NUL
0499:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
049b:      JMP   D0440      ; =-93 [Jump relative]
049d:D049D HLT              ; [Halt]
049e:      JMP   D049D      ; =-3 [Jump relative]
*
04a0:W04A0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
04a2:W04A2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F04A4
*
04a4:F04A4 DMA   SAD,A      ; [Store A register to DMA address register]
04a6:      LDA=  X'FE6F'    ; =0xfe6f =65135(-401) [Load A with immediate]
04a9:      DMA   SCT,A      ; [Store A register to DMA count register]
04ab:      DMA   SDV,0      ; [Set DMA mode]
04ad:      DMA   EAB        ; [Enable DMA]
04af:      RSR              ; [Return from subroutine]
*
* Function F04B0
*
04b0:F04B0 LDA=  X'F140'    ; =0xf140 =61760(-3776) [Load A with immediate]
04b3:      XAZ              ; [Transfer A to Z]
04b4:      LDA   W04A0      ; =-22 [Load A relative]
04b6:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
04b8:      BZ    D04BC      ; =+2 [Branch if zero]
04ba:      LDA   W04A2      ; =-26 [Load A relative]
04bc:D04BC STA   W04CD+1    ; =+16 [Store A relative]
04be:      JSR   F04A4      ; =-28 [Jump to subroutine relative]
04c0:      JSR   F04E1      ; =+31 [Jump to subroutine relative]
04c2:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
04c4:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
04c7:      JSR   F04F5      ; =+44 [Jump to subroutine relative]
04c9:      SRRB  AU         ; [Right shift AU by 1]
04cb:      BNZ   D04D2      ; =+5 [Branch if not zero]
04cd:W04CD LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
04d0:      XAZ              ; [Transfer A to Z]
04d1:      RSR              ; [Return from subroutine]
*
04d2:D04D2 LDAB= X'03'      ; =3 [Load AL with immediate]
04d4:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
04d7:      JSR   F04FB      ; =+34 [Jump to subroutine relative]
04d9:      LDAB+ Z          ; [Load AL from address in Z]
04da:      STAB+ Z,11       ; [Store AL indexed, displaced, direct]
04dd:      LDA   W04CD+1    ; =-17 [Load A relative]
04df:      JMP   D04BC      ; =-37 [Jump relative]
*
* Function F04E1
*
04e1:F04E1 JSR   F04FB      ; =+24 [Jump to subroutine relative]
04e3:      LDA+  S,2        ; [Load A indexed, displaced, direct]
04e6:      LDB=  X'3FFF'    ; =0x3fff =16383 [Load B with immediate]
04e9:      NAB              ; [A & B -> B]
04ea:      STB+  Z,1        ; [Store B indexed, displaced, direct]
04ed:      LDAB= X'02'      ; =2 [Load AL with immediate]
04ef:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
04f2:      JSR   F04FB      ; =+7 [Jump to subroutine relative]
04f4:      RSR              ; [Return from subroutine]
*
* Function F04F5
*
04f5:F04F5 LDAB+ Z,4        ; [Load AL indexed, displaced, direct]
04f8:      SRAB             ; [Right shift AL]
04f9:      BL    F04F5      ; =-6 [Branch on link]
*
* Function F04FB
*
04fb:F04FB LDA+  Z,4        ; [Load A indexed, displaced, direct]
04fe:      LDBB= X'30'      ; =48 [Load BL with immediate]
0500:      ANDB  BL,AL      ; [BL & AL -> AL]
0502:      SABB             ; [AL - BL -> BL]
0503:      BNZ   F04FB      ; =-10 [Branch if not zero]
0505:      RSR              ; [Return from subroutine]
*
0506:      DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F0507
*
0507:F0507 LDA+  X+         ; [Load A indexed, direct, post-incremented]
0509:      XAB              ; [Transfer A to B]
050a:      JMP/  X'050D'    ; =0x050d =1293 [Jump direct]
050d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
050f:      SAB              ; [A - B -> B]
0510:      BLE   D0533      ; =+33 [Branch if less than or equal to zero]
0512:      LDB+  X          ; [Load B from address in X]
0513:      JSR/  F069A      ; =0x069a =1690 [Jump to subroutine direct]
0516:      DC    ' '        ; hex:a0 dec:160(-96)
*
0517:D0517 LDB+  S          ; [Load B from address in S]
0518:      XFR   Y,A        ; [Transfer Y to A]
051a:      STA+  S          ; [Store A to address in S]
051b:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
051d:      XAY              ; [Transfer A to Y]
051e:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
0520:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0522:      XFR   B,X        ; [Transfer B to X]
0524:D0524 DCX              ; [Decrement X]
0525:      BP    D052D      ; =+6 [Branch on plus]
0527:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0529:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
052b:      XAY              ; [Transfer A to Y]
052c:      RSR              ; [Return from subroutine]
*
052d:D052D LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
052f:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
0531:      JMP   D0524      ; =-15 [Jump relative]
0533:D0533 STA+  S          ; [Store A to address in S]
0534:      JMP   D0517      ; =-31 [Jump relative]
*
* Function F0536
*
0536:F0536 JSR   F055A      ; =+34 [Jump to subroutine relative]
0538:      STK   X,6        ; [Push X Y Z to the stack]
053a:      LDA+  X          ; [Load A from address in X]
053b:      XAY              ; [Transfer A to Y]
053c:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
0540:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
0542:      BLE   D0555      ; =+17 [Branch if less than or equal to zero]
0544:D0544 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
0546:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
0548:      SABB             ; [AL - BL -> BL]
0549:      BM    D0550      ; =+5 [Branch on minus]
054b:      LDBB= X'20'      ; =32 [Load BL with immediate]
054d:      SABB             ; [AL - BL -> BL]
054e:      XFRB  BL,AL      ; [Transfer BL to AL]
0550:D0550 JSR   F0564      ; =+18 [Jump to subroutine relative]
0552:      DCX              ; [Decrement X]
0553:      BGZ   D0544      ; =-17 [Branch if greater than zero]
0555:D0555 POP   X,6        ; [Pop Z Y X from the stack]
0557:      INR   X,2        ; [Increment X by 2]
0559:      RSR              ; [Return from subroutine]
*
* Function F055A
*
055a:F055A LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
055c:      LDBB  B059F+1    ; =+66 [Load BL relative]
055e:      SABB             ; [AL - BL -> BL]
055f:      BZ    D0563      ; =+2 [Branch if zero]
0561:      JSR   F0564      ; =+1 [Jump to subroutine relative]
0563:D0563 RSR              ; [Return from subroutine]
*
* Function F0564
*
0564:F0564 STK   Z,2        ; [Push Z to the stack]
0566:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
056a:      SIOB  A,Z,13     ; [Store AL to MMIO address Z+13]
056d:B056D LDBB= X'C5'      ; =197(-59) ='E' [Load BL with immediate]
056f:      SIOB  B,Z        ; [Store BL to MMIO address in Z]
0572:      LDBB= X'8C'      ; =140(-116) =FF [Load BL with immediate]
0574:      SABB             ; [AL - BL -> BL]
0575:      BZ    D058A      ; =+19 [Branch if zero]
0577:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
0579:      SABB             ; [AL - BL -> BL]
057a:      BNZ   D0590      ; =+20 [Branch if not zero]
057c:      JSR   F0595      ; =+23 [Jump to subroutine relative]
057e:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
0580:      JSR   F0595      ; =+19 [Jump to subroutine relative]
0582:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
0584:      STAB  B059F+1    ; =+26 [Store AL relative]
0586:      DLY              ; [Delay 4.55 ms]
0587:      POP   Z,2        ; [Pop Z from the stack]
0589:      RSR              ; [Return from subroutine]
*
058a:D058A JSR   F0595      ; =+9 [Jump to subroutine relative]
058c:      DLY              ; [Delay 4.55 ms]
058d:      POP   Z,2        ; [Pop Z from the stack]
058f:      RSR              ; [Return from subroutine]
*
0590:D0590 JSR   F0595      ; =+3 [Jump to subroutine relative]
0592:      POP   Z,2        ; [Pop Z from the stack]
0594:      RSR              ; [Return from subroutine]
*
* Function F0595
*
0595:F0595 LIOB  B,Z        ; [Load BL from MMIO address in Z]
0598:      SRRB  BL,2       ; [Right shift BL by 2]
059a:      BNL   F0595      ; =-7 [Branch on no link]
059c:      SIOB  A,Z,1      ; [Store AL to MMIO address Z+1]
059f:B059F STAB= X'00'      ; =0 =NUL [Store AL immediate]
05a1:      RSR              ; [Return from subroutine]
*
05a2:D05A2 LIOB  B,Z,15     ; [Load BL from MMIO address Z+15]
05a5:      RI               ; [Return from interrupt]
*
05a6:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
05aa:      LIOB  A,Z        ; [Load AL from MMIO address in Z]
05ad:      SRAB             ; [Right shift AL]
05ae:      BL    D05BF      ; =+15 [Branch on link]
05b0:      LIOB  A,Z,1      ; [Load AL from MMIO address Z+1]
05b3:      LIOB  A,Z,3      ; [Load AL from MMIO address Z+3]
05b6:      LIOB  A,Z,5      ; [Load AL from MMIO address Z+5]
05b9:      LIOB  A,Z,7      ; [Load AL from MMIO address Z+7]
05bc:      CLAB             ; [Clear AL]
05bd:      JMP   D05A2      ; =-29 [Jump relative]
05bf:D05BF LIOB  A,Z,1      ; [Load AL from MMIO address Z+1]
05c2:      JMP   D05A2      ; =-34 [Jump relative]
*
* Function F05C4
*
05c4:F05C4 STK   Z,2        ; [Push Z to the stack]
05c6:      XFR=  X'F200',Z  ; =0xf200 =61952(-3584) ='r',NUL [Transfer immediate to Z]
05ca:      LDAB  B056D+1    ; =-94 [Load AL relative]
05cc:      SIOB  A,Z        ; [Store AL to MMIO address in Z]
05cf:      LDA=  X'05A6'    ; =0x05a6 =1446 [Load A with immediate]
05d2:      SAR   6,P        ; [Store A to P at interrupt level 6]
05d4:      CLA              ; [Clear A]
05d5:      SAR   6,A        ; [Store A to A at interrupt level 6]
05d7:      LDAB= X'06'      ; =6 [Load AL with immediate]
05d9:      SIOB  A,Z,10     ; [Store AL to MMIO address Z+10]
05dc:      SIOB  A,Z,14     ; [Store AL to MMIO address Z+14]
05df:D05DF LAR   6,A        ; [Load A from A at interrupt level 6]
05e1:      XFRB  AL,AU      ; [Transfer AL to AU]
05e3:      BZ    D05DF      ; =-6 [Branch if zero]
05e5:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
05e7:      ORIB  BL,AL      ; [BL | AL -> AL]
05e9:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
05eb:      BNZ   D05F0      ; =+3 [Branch if not zero]
05ed:      JSR/  F0564      ; =0x0564 =1380 [Jump to subroutine direct]
05f0:D05F0 LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
05f2:      SABB             ; [AL - BL -> BL]
05f3:      BM    D05FA      ; =+5 [Branch on minus]
05f5:      LDBB= X'20'      ; =32 [Load BL with immediate]
05f7:      SABB             ; [AL - BL -> BL]
05f8:      XFRB  BL,AL      ; [Transfer BL to AL]
05fa:D05FA LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
05fc:      SABB             ; [AL - BL -> BL]
05fd:      BNZ   D0606      ; =+7 [Branch if not zero]
05ff:W05FF LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
0602:      BZ    D0606      ; =+2 [Branch if zero]
0604:      XFR   B,X        ; [Transfer B to X]
0606:D0606 POP   Z,2        ; [Pop Z from the stack]
0608:      RSR              ; [Return from subroutine]
*
0609:      LDA   W05FF+1    ; =-11 [Load A relative]
060b:      STA   W0664+1    ; =+88 [Store A relative]
060d:      LDA=  X'066F'    ; =0x066f =1647 [Load A with immediate]
0610:      STA   W05FF+1    ; =-18 [Store A relative]
0612:      LDA+  X          ; [Load A from address in X]
0613:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0615:      INA              ; [Increment A]
0616:      XAX              ; [Transfer A to X]
0617:      LDAB= X'AF'      ; =175(-81) ='/' [Load AL with immediate]
0619:      JSR/  F0564      ; =0x0564 =1380 [Jump to subroutine direct]
061c:D061C JSR   F05C4      ; =-90 [Jump to subroutine relative]
061e:      LDBB= X'88'      ; =136(-120) [Load BL with immediate]
0620:      SABB             ; [AL - BL -> BL]
0621:      BZ    D0628      ; =+5 [Branch if zero]
0623:      LDBB= X'95'      ; =149(-107) [Load BL with immediate]
0625:      SABB             ; [AL - BL -> BL]
0626:      BNZ   D0644      ; =+28 [Branch if not zero]
0628:D0628 LDB+  *S         ; [Load B indexed, indirect]
062a:      STAB  B0637+1    ; =+12 [Store AL relative]
062c:      INR   B          ; [Increment B by 1]
062e:      SUB   X,B        ; [X - B -> B]
0630:      BZ    D063E      ; =+12 [Branch if zero]
0632:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
0634:P0634 JSR/  F0564      ; =0x0564 =1380 [Jump to subroutine direct]
0637:B0637 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
0639:      JSR*  P0634+1    ; =-6 [Jump to subroutine relative indirect]
063b:      DCX              ; [Decrement X]
063c:      JMP   D061C      ; =-34 [Jump relative]
063e:D063E LDAB= X'86'      ; =134(-122) [Load AL with immediate]
0640:      JSR*  P0634+1    ; =-13 [Jump to subroutine relative indirect]
0642:      JMP   D061C      ; =-40 [Jump relative]
0644:D0644 LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
0646:      SABB             ; [AL - BL -> BL]
0647:      BZ    D065B      ; =+18 [Branch if zero]
0649:      STAB  B0656+1    ; =+12 [Store AL relative]
064b:      LDA+  *S         ; [Load A indexed, indirect]
064d:      LDB=  X'0085'    ; =0x0085 =133 [Load B with immediate]
0650:      AAB              ; [A + B -> B]
0651:      SUB   X,B        ; [X - B -> B]
0653:      BP    D065B      ; =+6 [Branch on plus]
0655:      INX              ; [Increment X]
0656:B0656 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
0658:      STAB+ X          ; [Store AL to address in X]
0659:      JMP   D061C      ; =-63 [Jump relative]
065b:D065B LDA+  *S         ; [Load A indexed, indirect]
065d:      INA              ; [Increment A]
065e:      SUB   X,A        ; [X - A -> A]
0660:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0662:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
0664:W0664 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
0667:      STB   W05FF+1    ; =-105 [Store B relative]
0669:      CLRB  BL         ; [Clear BL]
066b:      STBB/ X'05EA'    ; =0x05ea =1514 [Store BL direct]
066e:      RSR              ; [Return from subroutine]
*
066f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0671:      CLA              ; [Clear A]
0672:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
0674:      LDX   W0664+1    ; =-17 [Load X relative]
0676:      JMP   W0664      ; =-20 [Jump relative]
0678:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
067a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
067c:      XFR   Y,X        ; [Transfer Y to X]
067e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0680:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
0682:      XAY              ; [Transfer A to Y]
0683:D0683 DCX              ; [Decrement X]
0684:      BM    D0694      ; =+14 [Branch on minus]
0686:      LDAB+ Y          ; [Load AL from address in Y]
0687:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
0689:      SABB             ; [AL - BL -> BL]
068a:      BM    D0690      ; =+4 [Branch on minus]
068c:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
068e:      ADDB  BL,AL      ; [BL + AL -> AL]
0690:D0690 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
0692:      JMP   D0683      ; =-17 [Jump relative]
0694:D0694 LDA+  S+         ; [Load A indexed, direct, post-incremented]
0696:      XAY              ; [Transfer A to Y]
0697:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0699:      RSR              ; [Return from subroutine]
*
* Function F069A
*
069a:F069A STX-  S-         ; [Store X indexed, pre-decremented, direct]
069c:      XAX              ; [Transfer A to X]
069d:      LDAB+ *S         ; [Load AL indexed, indirect]
069f:D069F DCX              ; [Decrement X]
06a0:      BP    D06A6      ; =+4 [Branch on plus]
06a2:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
06a4:      INX              ; [Increment X]
06a5:      RSR              ; [Return from subroutine]
*
06a6:D06A6 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
06a8:      JMP   D069F      ; =-11 [Jump relative]
*
06aa:      DB    0,2950     ; =0x00,0x0b86
1230:      DB    X'8C'      ; =0x8c =140(-116) =FF
1231:      DC    '$'        ; hex:a4 dec:164(-92)
1232:      DB    X'8C'      ; =0x8c =140(-116) =FF
1233:      DC    '%'        ; hex:a5 dec:165(-91)
1234:      DB    X'8C'      ; =0x8c =140(-116) =FF
1235:      DC    '&'        ; hex:a6 dec:166(-90)
1236:      DW    X'8CA7'    ; =0x8ca7 =36007(-29529) =FF,'
1238:      DB    X'8C'      ; =0x8c =140(-116) =FF
1239:      DC    '('        ; hex:a8 dec:168(-88)
123a:      DB    X'8C'      ; =0x8c =140(-116) =FF
123b:      DC    ')'        ; hex:a9 dec:169(-87)
123c:      DB    X'8C'      ; =0x8c =140(-116) =FF
123d:      DC    '*'        ; hex:aa dec:170(-86)
123e:      DB    X'8C'      ; =0x8c =140(-116) =FF
123f:      DC    '+'        ; hex:ab dec:171(-85)
1240:      DB    X'8C'      ; =0x8c =140(-116) =FF
1241:      DC    ','        ; hex:ac dec:172(-84)
1242:      DB    X'8C'      ; =0x8c =140(-116) =FF
1243:      DC    '-'        ; hex:ad dec:173(-83)
1244:      DB    X'8C'      ; =0x8c =140(-116) =FF
1245:      DC    '.'        ; hex:ae dec:174(-82)
1246:      DB    X'8C'      ; =0x8c =140(-116) =FF
1247:      DC    '/'        ; hex:af dec:175(-81)
1248:      DB    X'8C'      ; =0x8c =140(-116) =FF
1249:      DC    '0'        ; hex:b0 dec:176(-80)
124a:      DB    X'8C'      ; =0x8c =140(-116) =FF
124b:      DC    '1'        ; hex:b1 dec:177(-79)
124c:      DB    X'8C'      ; =0x8c =140(-116) =FF
124d:      DC    '2'        ; hex:b2 dec:178(-78)
124e:      DB    X'8C'      ; =0x8c =140(-116) =FF
124f:      DC    '3'        ; hex:b3 dec:179(-77)
1250:      DB    X'8C'      ; =0x8c =140(-116) =FF
1251:      DC    '4'        ; hex:b4 dec:180(-76)
1252:      DB    X'8C'      ; =0x8c =140(-116) =FF
1253:      DC    '5'        ; hex:b5 dec:181(-75)
1254:      DB    X'8C'      ; =0x8c =140(-116) =FF
1255:      DC    '6'        ; hex:b6 dec:182(-74)
1256:      DB    X'8C'      ; =0x8c =140(-116) =FF
1257:      DC    '7'        ; hex:b7 dec:183(-73)
1258:      DB    X'8C'      ; =0x8c =140(-116) =FF
1259:      DC    '8'        ; hex:b8 dec:184(-72)
125a:      DB    X'8C'      ; =0x8c =140(-116) =FF
125b:      DC    '9'        ; hex:b9 dec:185(-71)
125c:      DB    X'8C'      ; =0x8c =140(-116) =FF
125d:      DC    ':'        ; hex:ba dec:186(-70)
125e:      DB    X'8C'      ; =0x8c =140(-116) =FF
125f:      DC    ';'        ; hex:bb dec:187(-69)
1260:      DB    X'8C'      ; =0x8c =140(-116) =FF
1261:      DC    '<'        ; hex:bc dec:188(-68)
1262:      DB    X'8C'      ; =0x8c =140(-116) =FF
1263:      DC    '='        ; hex:bd dec:189(-67)
1264:      DB    X'8C'      ; =0x8c =140(-116) =FF
1265:      DC    '>'        ; hex:be dec:190(-66)
1266:      DB    X'8C'      ; =0x8c =140(-116) =FF
1267:      DC    '?'        ; hex:bf dec:191(-65)
1268:      DB    X'8C'      ; =0x8c =140(-116) =FF
1269:      DC    '@'        ; hex:c0 dec:192(-64)
126a:      DB    X'8C'      ; =0x8c =140(-116) =FF
126b:      DC    'A'        ; hex:c1 dec:193(-63)
126c:      DB    X'8C'      ; =0x8c =140(-116) =FF
126d:      DC    'B'        ; hex:c2 dec:194(-62)
126e:      DB    X'8C'      ; =0x8c =140(-116) =FF
126f:      DC    'C'        ; hex:c3 dec:195(-61)
1270:      DB    X'8C'      ; =0x8c =140(-116) =FF
1271:      DC    'D'        ; hex:c4 dec:196(-60)
1272:      DB    X'8C'      ; =0x8c =140(-116) =FF
1273:      DC    'E'        ; hex:c5 dec:197(-59)
1274:      DB    X'8C'      ; =0x8c =140(-116) =FF
1275:      DC    'F'        ; hex:c6 dec:198(-58)
1276:      DB    X'8C'      ; =0x8c =140(-116) =FF
1277:      DC    'G'        ; hex:c7 dec:199(-57)
1278:      DB    X'8C'      ; =0x8c =140(-116) =FF
1279:      DC    'H'        ; hex:c8 dec:200(-56)
127a:      DB    X'8C'      ; =0x8c =140(-116) =FF
127b:      DC    'I'        ; hex:c9 dec:201(-55)
127c:      DB    X'8C'      ; =0x8c =140(-116) =FF
127d:      DC    'J'        ; hex:ca dec:202(-54)
127e:      DB    X'8C'      ; =0x8c =140(-116) =FF
127f:      DC    'K'        ; hex:cb dec:203(-53)
1280:      DB    X'8C'      ; =0x8c =140(-116) =FF
1281:      DC    'L'        ; hex:cc dec:204(-52)
1282:      DB    X'8C'      ; =0x8c =140(-116) =FF
1283:      DC    'M'        ; hex:cd dec:205(-51)
1284:      DB    X'8C'      ; =0x8c =140(-116) =FF
1285:      DC    'N'        ; hex:ce dec:206(-50)
1286:      DB    X'8C'      ; =0x8c =140(-116) =FF
1287:      DC    'O'        ; hex:cf dec:207(-49)
1288:      DB    X'8C'      ; =0x8c =140(-116) =FF
1289:      DC    'P'        ; hex:d0 dec:208(-48)
128a:      DB    X'8C'      ; =0x8c =140(-116) =FF
128b:      DC    'Q'        ; hex:d1 dec:209(-47)
128c:      DB    X'8C'      ; =0x8c =140(-116) =FF
128d:      DC    'R'        ; hex:d2 dec:210(-46)
128e:      DB    X'8C'      ; =0x8c =140(-116) =FF
128f:      DC    'S'        ; hex:d3 dec:211(-45)
1290:      DB    X'8C'      ; =0x8c =140(-116) =FF
1291:      DC    'T'        ; hex:d4 dec:212(-44)
1292:      DB    X'8C'      ; =0x8c =140(-116) =FF
1293:      DC    'U'        ; hex:d5 dec:213(-43)
1294:      DB    X'8C'      ; =0x8c =140(-116) =FF
1295:      DC    'V'        ; hex:d6 dec:214(-42)
1296:      DB    X'8C'      ; =0x8c =140(-116) =FF
1297:      DC    'W'        ; hex:d7 dec:215(-41)
1298:      DB    X'8C'      ; =0x8c =140(-116) =FF
1299:      DC    'X'        ; hex:d8 dec:216(-40)
129a:      DB    X'8C'      ; =0x8c =140(-116) =FF
129b:      DC    'Y'        ; hex:d9 dec:217(-39)
129c:      DB    X'8C'      ; =0x8c =140(-116) =FF
129d:      DC    'Z'        ; hex:da dec:218(-38)
129e:      DB    X'8C'      ; =0x8c =140(-116) =FF
129f:      DC    '['        ; hex:db dec:219(-37)
12a0:      DB    X'8C'      ; =0x8c =140(-116) =FF
12a1:      DC    '\'        ; hex:dc dec:220(-36)
12a2:      DB    X'8C'      ; =0x8c =140(-116) =FF
12a3:      DC    ']'        ; hex:dd dec:221(-35)
12a4:      DB    X'8C'      ; =0x8c =140(-116) =FF
12a5:      DC    '^'        ; hex:de dec:222(-34)
12a6:      DW    X'8CDF'    ; =0x8cdf =36063(-29473) =FF,DEL
12a8:      DB    X'8C'      ; =0x8c =140(-116) =FF
12a9:      DC    '`'        ; hex:e0 dec:224(-32)
12aa:      DB    X'8C'      ; =0x8c =140(-116) =FF
12ab:      DC    'a'        ; hex:e1 dec:225(-31)
12ac:      DB    X'8C'      ; =0x8c =140(-116) =FF
12ad:      DC    'b'        ; hex:e2 dec:226(-30)
12ae:      DB    X'8C'      ; =0x8c =140(-116) =FF
12af:      DC    'c'        ; hex:e3 dec:227(-29)
12b0:      DB    X'8C'      ; =0x8c =140(-116) =FF
12b1:      DC    'd'        ; hex:e4 dec:228(-28)
12b2:      DB    X'8C'      ; =0x8c =140(-116) =FF
12b3:      DC    'e'        ; hex:e5 dec:229(-27)
12b4:      DB    X'8C'      ; =0x8c =140(-116) =FF
12b5:      DC    'f'        ; hex:e6 dec:230(-26)
12b6:      DB    X'8C'      ; =0x8c =140(-116) =FF
12b7:      DC    'g'        ; hex:e7 dec:231(-25)
12b8:      DB    X'8C'      ; =0x8c =140(-116) =FF
12b9:      DC    'h'        ; hex:e8 dec:232(-24)
12ba:      DB    X'8C'      ; =0x8c =140(-116) =FF
12bb:      DC    'i'        ; hex:e9 dec:233(-23)
12bc:      DB    X'8C'      ; =0x8c =140(-116) =FF
12bd:      DC    'j'        ; hex:ea dec:234(-22)
12be:      DB    X'8C'      ; =0x8c =140(-116) =FF
12bf:      DC    'k'        ; hex:eb dec:235(-21)
12c0:      DB    X'8C'      ; =0x8c =140(-116) =FF
12c1:      DC    'l'        ; hex:ec dec:236(-20)
12c2:      DB    X'8C'      ; =0x8c =140(-116) =FF
12c3:      DC    'm'        ; hex:ed dec:237(-19)
12c4:      DB    X'8C'      ; =0x8c =140(-116) =FF
12c5:      DC    'n'        ; hex:ee dec:238(-18)
12c6:      DB    X'8C'      ; =0x8c =140(-116) =FF
12c7:      DC    'o'        ; hex:ef dec:239(-17)
12c8:      DB    X'8C'      ; =0x8c =140(-116) =FF
12c9:      DC    'p'        ; hex:f0 dec:240(-16)
12ca:      DB    X'8C'      ; =0x8c =140(-116) =FF
12cb:      DC    'q'        ; hex:f1 dec:241(-15)
12cc:      DB    X'8C'      ; =0x8c =140(-116) =FF
12cd:      DC    'r'        ; hex:f2 dec:242(-14)
12ce:      DB    X'8C'      ; =0x8c =140(-116) =FF
12cf:      DC    's'        ; hex:f3 dec:243(-13)
12d0:      DB    X'8C'      ; =0x8c =140(-116) =FF
12d1:      DC    't'        ; hex:f4 dec:244(-12)
12d2:      DB    X'8C'      ; =0x8c =140(-116) =FF
12d3:      DC    'u'        ; hex:f5 dec:245(-11)
12d4:      DB    X'8C'      ; =0x8c =140(-116) =FF
12d5:      DC    'v'        ; hex:f6 dec:246(-10)
12d6:      DB    X'8C'      ; =0x8c =140(-116) =FF
12d7:      DC    'w'        ; hex:f7 dec:247(-9)
12d8:      DB    X'8C'      ; =0x8c =140(-116) =FF
12d9:      DC    'x'        ; hex:f8 dec:248(-8)
12da:      DB    X'8C'      ; =0x8c =140(-116) =FF
12db:      DC    'y'        ; hex:f9 dec:249(-7)
12dc:      DB    X'8C'      ; =0x8c =140(-116) =FF
12dd:      DC    'z'        ; hex:fa dec:250(-6)
12de:      DB    X'8C'      ; =0x8c =140(-116) =FF
12df:      DC    '{'        ; hex:fb dec:251(-5)
12e0:      DB    X'8C'      ; =0x8c =140(-116) =FF
12e1:      DC    '|'        ; hex:fc dec:252(-4)
12e2:      DB    X'8C'      ; =0x8c =140(-116) =FF
12e3:      DC    '}'        ; hex:fd dec:253(-3)
12e4:      DB    X'8C'      ; =0x8c =140(-116) =FF
12e5:      DC    '~'        ; hex:fe dec:254(-2)
12e6:      DW    X'8CFF'    ; =0x8cff =36095(-29441)
12e8:      DW    X'8D00'    ; =0x8d00 =36096(-29440) =CR,NUL
12ea:      DW    X'8D01'    ; =0x8d01 =36097(-29439)
12ec:      DW    X'8D02'    ; =0x8d02 =36098(-29438)
12ee:      DW    X'8D03'    ; =0x8d03 =36099(-29437)
12f0:      DW    X'8D04'    ; =0x8d04 =36100(-29436)
12f2:      DW    X'8D05'    ; =0x8d05 =36101(-29435)
12f4:      DW    X'8D06'    ; =0x8d06 =36102(-29434)
12f6:      DW    X'8D07'    ; =0x8d07 =36103(-29433)
12f8:      DW    X'8D08'    ; =0x8d08 =36104(-29432)
12fa:      DW    X'8D09'    ; =0x8d09 =36105(-29431)
12fc:      DW    X'8D0A'    ; =0x8d0a =36106(-29430)
12fe:      DW    X'8D0B'    ; =0x8d0b =36107(-29429)
1300:      DW    X'8D0C'    ; =0x8d0c =36108(-29428)
1302:      DW    X'8D0D'    ; =0x8d0d =36109(-29427)
1304:      DW    X'8D0E'    ; =0x8d0e =36110(-29426)
1306:      DW    X'8D0F'    ; =0x8d0f =36111(-29425)
1308:      DW    X'8D10'    ; =0x8d10 =36112(-29424)
130a:      DW    X'8D11'    ; =0x8d11 =36113(-29423)
130c:      DW    X'8D12'    ; =0x8d12 =36114(-29422)
130e:      DW    X'8D13'    ; =0x8d13 =36115(-29421)
1310:      DW    X'8D14'    ; =0x8d14 =36116(-29420)
1312:      DW    X'8D15'    ; =0x8d15 =36117(-29419)
1314:      DW    X'8D16'    ; =0x8d16 =36118(-29418)
1316:      DW    X'8D17'    ; =0x8d17 =36119(-29417)
1318:      DW    X'8D18'    ; =0x8d18 =36120(-29416)
131a:      DW    X'8D19'    ; =0x8d19 =36121(-29415)
131c:      DW    X'8D1A'    ; =0x8d1a =36122(-29414)
131e:      DW    X'8D1B'    ; =0x8d1b =36123(-29413)
1320:      DW    X'8D1C'    ; =0x8d1c =36124(-29412)
1322:      DW    X'8D1D'    ; =0x8d1d =36125(-29411)
1324:      DW    X'8D1E'    ; =0x8d1e =36126(-29410)
1326:      DW    X'8D1F'    ; =0x8d1f =36127(-29409)
1328:      DW    X'8D20'    ; =0x8d20 =36128(-29408)
132a:      DW    X'8D21'    ; =0x8d21 =36129(-29407)
132c:      DW    X'8D22'    ; =0x8d22 =36130(-29406)
132e:      DW    X'8D23'    ; =0x8d23 =36131(-29405)
1330:      DW    X'8D24'    ; =0x8d24 =36132(-29404)
1332:      DW    X'8D25'    ; =0x8d25 =36133(-29403)
1334:      DW    X'8D26'    ; =0x8d26 =36134(-29402)
1336:      DW    X'8D27'    ; =0x8d27 =36135(-29401)
1338:      DW    X'8D28'    ; =0x8d28 =36136(-29400)
133a:      DW    X'8D29'    ; =0x8d29 =36137(-29399)
133c:      DW    X'8D2A'    ; =0x8d2a =36138(-29398)
133e:      DW    X'8D2B'    ; =0x8d2b =36139(-29397)
1340:      DW    X'8D2C'    ; =0x8d2c =36140(-29396)
1342:      DW    X'8D2D'    ; =0x8d2d =36141(-29395)
1344:      DW    X'8D2E'    ; =0x8d2e =36142(-29394)
1346:      DW    X'8D2F'    ; =0x8d2f =36143(-29393)
1348:      DW    X'8D30'    ; =0x8d30 =36144(-29392)
134a:      DW    X'8D31'    ; =0x8d31 =36145(-29391)
134c:      DW    X'8D32'    ; =0x8d32 =36146(-29390)
134e:      DW    X'8D33'    ; =0x8d33 =36147(-29389)
1350:      DW    X'8D34'    ; =0x8d34 =36148(-29388)
1352:      DW    X'8D35'    ; =0x8d35 =36149(-29387)
1354:      DW    X'8D36'    ; =0x8d36 =36150(-29386)
1356:      DW    X'8D37'    ; =0x8d37 =36151(-29385)
1358:      DW    X'8D38'    ; =0x8d38 =36152(-29384)
135a:      DW    X'8D39'    ; =0x8d39 =36153(-29383)
135c:      DW    X'8D3A'    ; =0x8d3a =36154(-29382)
135e:      DW    X'8D3B'    ; =0x8d3b =36155(-29381)
1360:      DW    X'8D3C'    ; =0x8d3c =36156(-29380)
1362:      DW    X'8D3D'    ; =0x8d3d =36157(-29379)
1364:      DW    X'8D3E'    ; =0x8d3e =36158(-29378)
1366:      DW    X'8D3F'    ; =0x8d3f =36159(-29377)
1368:      DW    X'8D40'    ; =0x8d40 =36160(-29376)
136a:      DW    X'8D41'    ; =0x8d41 =36161(-29375)
136c:      DW    X'8D42'    ; =0x8d42 =36162(-29374)
136e:      DW    X'8D43'    ; =0x8d43 =36163(-29373)
1370:      DW    X'8D44'    ; =0x8d44 =36164(-29372)
1372:      DW    X'8D45'    ; =0x8d45 =36165(-29371)
1374:      DW    X'8D46'    ; =0x8d46 =36166(-29370)
1376:      DW    X'8D47'    ; =0x8d47 =36167(-29369)
1378:      DW    X'8D48'    ; =0x8d48 =36168(-29368)
137a:      DW    X'8D49'    ; =0x8d49 =36169(-29367)
137c:      DW    X'8D4A'    ; =0x8d4a =36170(-29366)
137e:      DW    X'8D4B'    ; =0x8d4b =36171(-29365)
1380:      DW    X'8D4C'    ; =0x8d4c =36172(-29364)
1382:      DW    X'8D4D'    ; =0x8d4d =36173(-29363)
1384:      DW    X'8D4E'    ; =0x8d4e =36174(-29362)
1386:      DW    X'8D4F'    ; =0x8d4f =36175(-29361)
1388:      DW    X'8D50'    ; =0x8d50 =36176(-29360)
138a:      DW    X'8D51'    ; =0x8d51 =36177(-29359)
138c:      DW    X'8D52'    ; =0x8d52 =36178(-29358)
138e:      DW    X'8D53'    ; =0x8d53 =36179(-29357)
1390:      DW    X'8D54'    ; =0x8d54 =36180(-29356)
1392:      DW    X'8D55'    ; =0x8d55 =36181(-29355)
1394:      DW    X'8D56'    ; =0x8d56 =36182(-29354)
1396:      DW    X'8D57'    ; =0x8d57 =36183(-29353)
1398:      DW    X'8D58'    ; =0x8d58 =36184(-29352)
139a:      DW    X'8D59'    ; =0x8d59 =36185(-29351)
139c:      DW    X'8D5A'    ; =0x8d5a =36186(-29350)
139e:      DW    X'8D5B'    ; =0x8d5b =36187(-29349)
13a0:      DW    X'8D5C'    ; =0x8d5c =36188(-29348)
13a2:      DW    X'8D5D'    ; =0x8d5d =36189(-29347)
13a4:      DW    X'8D5E'    ; =0x8d5e =36190(-29346)
13a6:      DW    X'8D5F'    ; =0x8d5f =36191(-29345)
13a8:      DW    X'8D60'    ; =0x8d60 =36192(-29344)
13aa:      DW    X'8D61'    ; =0x8d61 =36193(-29343)
13ac:      DW    X'8D62'    ; =0x8d62 =36194(-29342)
13ae:      DW    X'8D63'    ; =0x8d63 =36195(-29341)
13b0:      DW    X'8D64'    ; =0x8d64 =36196(-29340)
13b2:      DW    X'8D65'    ; =0x8d65 =36197(-29339)
13b4:      DW    X'8D66'    ; =0x8d66 =36198(-29338)
13b6:      DW    X'8D67'    ; =0x8d67 =36199(-29337)
13b8:      DW    X'8D68'    ; =0x8d68 =36200(-29336)
13ba:      DW    X'8D69'    ; =0x8d69 =36201(-29335)
13bc:      DW    X'8D6A'    ; =0x8d6a =36202(-29334)
13be:      DW    X'8D6B'    ; =0x8d6b =36203(-29333)
13c0:      DW    X'8D6C'    ; =0x8d6c =36204(-29332)
13c2:      DW    X'8D6D'    ; =0x8d6d =36205(-29331)
13c4:      DW    X'8D6E'    ; =0x8d6e =36206(-29330)
13c6:      DW    X'8D6F'    ; =0x8d6f =36207(-29329)
13c8:      DW    X'8D70'    ; =0x8d70 =36208(-29328)
13ca:      DW    X'8D71'    ; =0x8d71 =36209(-29327)
13cc:      DW    X'8D72'    ; =0x8d72 =36210(-29326)
13ce:      DW    X'8D73'    ; =0x8d73 =36211(-29325)
13d0:      DW    X'8D74'    ; =0x8d74 =36212(-29324)
13d2:      DW    X'8D75'    ; =0x8d75 =36213(-29323)
13d4:      DW    X'8D76'    ; =0x8d76 =36214(-29322)
13d6:      DW    X'8D77'    ; =0x8d77 =36215(-29321)
13d8:      DW    X'8D78'    ; =0x8d78 =36216(-29320)
13da:      DW    X'8D79'    ; =0x8d79 =36217(-29319)
13dc:      DW    X'8D7A'    ; =0x8d7a =36218(-29318)
13de:      DW    X'8D7B'    ; =0x8d7b =36219(-29317)
13e0:      DW    X'8D7C'    ; =0x8d7c =36220(-29316)
13e2:      DW    X'8D7D'    ; =0x8d7d =36221(-29315)
13e4:      DW    X'8D7E'    ; =0x8d7e =36222(-29314)
13e6:      DW    X'8D7F'    ; =0x8d7f =36223(-29313)
13e8:      DW    X'8D80'    ; =0x8d80 =36224(-29312)
13ea:      DW    X'8D81'    ; =0x8d81 =36225(-29311)
13ec:      DW    X'8D82'    ; =0x8d82 =36226(-29310)
13ee:      DW    X'8D83'    ; =0x8d83 =36227(-29309)
13f0:      DW    X'8D84'    ; =0x8d84 =36228(-29308) =CR,EOT
13f2:      DW    X'8D85'    ; =0x8d85 =36229(-29307)
13f4:      DW    X'8D86'    ; =0x8d86 =36230(-29306)
13f6:      DW    X'8D87'    ; =0x8d87 =36231(-29305) =CR,BEL
13f8:      DW    X'8D88'    ; =0x8d88 =36232(-29304)
13fa:      DW    X'8D89'    ; =0x8d89 =36233(-29303)
13fc:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
13fe:      DW    X'8D8B'    ; =0x8d8b =36235(-29301) =CR,VT
1400:      DW    X'8D8C'    ; =0x8d8c =36236(-29300) =CR,FF
1402:      DW    X'8D8D'    ; =0x8d8d =36237(-29299) =CR,CR
1404:      DW    X'8D8E'    ; =0x8d8e =36238(-29298)
1406:      DW    X'8D8F'    ; =0x8d8f =36239(-29297)
1408:      DW    X'8D90'    ; =0x8d90 =36240(-29296)
140a:      DW    X'8D91'    ; =0x8d91 =36241(-29295)
140c:      DW    X'8D92'    ; =0x8d92 =36242(-29294)
140e:      DW    X'8D93'    ; =0x8d93 =36243(-29293)
1410:      DW    X'8D94'    ; =0x8d94 =36244(-29292)
1412:      DW    X'8D95'    ; =0x8d95 =36245(-29291)
1414:      DW    X'8D96'    ; =0x8d96 =36246(-29290)
1416:      DW    X'8D97'    ; =0x8d97 =36247(-29289)
1418:      DW    X'8D98'    ; =0x8d98 =36248(-29288)
141a:      DW    X'8D99'    ; =0x8d99 =36249(-29287)
141c:      DW    X'8D9A'    ; =0x8d9a =36250(-29286)
141e:      DW    X'8D9B'    ; =0x8d9b =36251(-29285)
1420:      DW    X'8D9C'    ; =0x8d9c =36252(-29284)
1422:      DW    X'8D9D'    ; =0x8d9d =36253(-29283)
1424:      DW    X'8D9E'    ; =0x8d9e =36254(-29282)
1426:      DW    X'8D9F'    ; =0x8d9f =36255(-29281)
1428:      DB    X'8D'      ; =0x8d =141(-115) =CR
1429:      DC    ' '        ; hex:a0 dec:160(-96)
142a:      DB    X'8D'      ; =0x8d =141(-115) =CR
142b:      DC    '!'        ; hex:a1 dec:161(-95)
142c:      DB    X'8D'      ; =0x8d =141(-115) =CR
142d:      DC    '"'        ; hex:a2 dec:162(-94)
142e:      DB    X'8D'      ; =0x8d =141(-115) =CR
142f:      DC    '#'        ; hex:a3 dec:163(-93)
1430:      DB    X'8D'      ; =0x8d =141(-115) =CR
1431:      DC    '$'        ; hex:a4 dec:164(-92)
1432:      DB    X'8D'      ; =0x8d =141(-115) =CR
1433:      DC    '%'        ; hex:a5 dec:165(-91)
1434:      DB    X'8D'      ; =0x8d =141(-115) =CR
1435:      DC    '&'        ; hex:a6 dec:166(-90)
1436:      DB    X'8D'      ; =0x8d =141(-115) =CR
1437:      DW    X'A78D'    ; =0xa78d =42893(-22643) =',CR
1439:      DC    '('        ; hex:a8 dec:168(-88)
143a:      DB    X'8D'      ; =0x8d =141(-115) =CR
143b:      DC    ')'        ; hex:a9 dec:169(-87)
143c:      DB    X'8D'      ; =0x8d =141(-115) =CR
143d:      DC    '*'        ; hex:aa dec:170(-86)
143e:      DB    X'8D'      ; =0x8d =141(-115) =CR
143f:      DC    '+'        ; hex:ab dec:171(-85)
1440:      DB    X'8D'      ; =0x8d =141(-115) =CR
1441:      DC    ','        ; hex:ac dec:172(-84)
1442:      DB    X'8D'      ; =0x8d =141(-115) =CR
1443:      DC    '-'        ; hex:ad dec:173(-83)
1444:      DB    X'8D'      ; =0x8d =141(-115) =CR
1445:      DC    '.'        ; hex:ae dec:174(-82)
1446:      DB    X'8D'      ; =0x8d =141(-115) =CR
1447:      DC    '/'        ; hex:af dec:175(-81)
1448:      DB    X'8D'      ; =0x8d =141(-115) =CR
1449:      DC    '0'        ; hex:b0 dec:176(-80)
144a:      DB    X'8D'      ; =0x8d =141(-115) =CR
144b:      DC    '1'        ; hex:b1 dec:177(-79)
144c:      DB    X'8D'      ; =0x8d =141(-115) =CR
144d:      DC    '2'        ; hex:b2 dec:178(-78)
144e:      DB    X'8D'      ; =0x8d =141(-115) =CR
144f:      DC    '3'        ; hex:b3 dec:179(-77)
1450:      DB    X'8D'      ; =0x8d =141(-115) =CR
1451:      DC    '4'        ; hex:b4 dec:180(-76)
1452:      DB    X'8D'      ; =0x8d =141(-115) =CR
1453:      DC    '5'        ; hex:b5 dec:181(-75)
1454:      DB    X'8D'      ; =0x8d =141(-115) =CR
1455:      DC    '6'        ; hex:b6 dec:182(-74)
1456:      DB    X'8D'      ; =0x8d =141(-115) =CR
1457:      DC    '7'        ; hex:b7 dec:183(-73)
1458:      DB    X'8D'      ; =0x8d =141(-115) =CR
1459:      DC    '8'        ; hex:b8 dec:184(-72)
145a:      DB    X'8D'      ; =0x8d =141(-115) =CR
145b:      DC    '9'        ; hex:b9 dec:185(-71)
145c:      DB    X'8D'      ; =0x8d =141(-115) =CR
145d:      DC    ':'        ; hex:ba dec:186(-70)
145e:      DB    X'8D'      ; =0x8d =141(-115) =CR
145f:      DC    ';'        ; hex:bb dec:187(-69)
1460:      DB    X'8D'      ; =0x8d =141(-115) =CR
1461:      DC    '<'        ; hex:bc dec:188(-68)
1462:      DB    X'8D'      ; =0x8d =141(-115) =CR
1463:      DC    '='        ; hex:bd dec:189(-67)
1464:      DB    X'8D'      ; =0x8d =141(-115) =CR
1465:      DC    '>'        ; hex:be dec:190(-66)
1466:      DB    X'8D'      ; =0x8d =141(-115) =CR
1467:      DC    '?'        ; hex:bf dec:191(-65)
1468:      DB    X'8D'      ; =0x8d =141(-115) =CR
1469:      DC    '@'        ; hex:c0 dec:192(-64)
146a:      DB    X'8D'      ; =0x8d =141(-115) =CR
146b:      DC    'A'        ; hex:c1 dec:193(-63)
146c:      DB    X'8D'      ; =0x8d =141(-115) =CR
146d:      DC    'B'        ; hex:c2 dec:194(-62)
146e:      DB    X'8D'      ; =0x8d =141(-115) =CR
146f:      DC    'C'        ; hex:c3 dec:195(-61)
1470:      DB    X'8D'      ; =0x8d =141(-115) =CR
1471:      DC    'D'        ; hex:c4 dec:196(-60)
1472:      DB    X'8D'      ; =0x8d =141(-115) =CR
1473:      DC    'E'        ; hex:c5 dec:197(-59)
1474:      DB    X'8D'      ; =0x8d =141(-115) =CR
1475:      DC    'F'        ; hex:c6 dec:198(-58)
1476:      DB    X'8D'      ; =0x8d =141(-115) =CR
1477:      DC    'G'        ; hex:c7 dec:199(-57)
1478:      DB    X'8D'      ; =0x8d =141(-115) =CR
1479:      DC    'H'        ; hex:c8 dec:200(-56)
147a:      DB    X'8D'      ; =0x8d =141(-115) =CR
147b:      DC    'I'        ; hex:c9 dec:201(-55)
147c:      DB    X'8D'      ; =0x8d =141(-115) =CR
147d:      DC    'J'        ; hex:ca dec:202(-54)
147e:      DB    X'8D'      ; =0x8d =141(-115) =CR
147f:      DC    'K'        ; hex:cb dec:203(-53)
1480:      DB    X'8D'      ; =0x8d =141(-115) =CR
1481:      DC    'L'        ; hex:cc dec:204(-52)
1482:      DB    X'8D'      ; =0x8d =141(-115) =CR
1483:      DC    'M'        ; hex:cd dec:205(-51)
1484:      DB    X'8D'      ; =0x8d =141(-115) =CR
1485:      DC    'N'        ; hex:ce dec:206(-50)
1486:      DB    X'8D'      ; =0x8d =141(-115) =CR
1487:      DC    'O'        ; hex:cf dec:207(-49)
1488:      DB    X'8D'      ; =0x8d =141(-115) =CR
1489:      DC    'P'        ; hex:d0 dec:208(-48)
148a:      DB    X'8D'      ; =0x8d =141(-115) =CR
148b:      DC    'Q'        ; hex:d1 dec:209(-47)
148c:      DB    X'8D'      ; =0x8d =141(-115) =CR
148d:      DC    'R'        ; hex:d2 dec:210(-46)
148e:      DB    X'8D'      ; =0x8d =141(-115) =CR
148f:      DC    'S'        ; hex:d3 dec:211(-45)
1490:      DB    X'8D'      ; =0x8d =141(-115) =CR
1491:      DC    'T'        ; hex:d4 dec:212(-44)
1492:      DB    X'8D'      ; =0x8d =141(-115) =CR
1493:      DC    'U'        ; hex:d5 dec:213(-43)
1494:      DB    X'8D'      ; =0x8d =141(-115) =CR
1495:      DC    'V'        ; hex:d6 dec:214(-42)
1496:      DB    X'8D'      ; =0x8d =141(-115) =CR
1497:      DC    'W'        ; hex:d7 dec:215(-41)
1498:      DB    X'8D'      ; =0x8d =141(-115) =CR
1499:      DC    'X'        ; hex:d8 dec:216(-40)
149a:      DB    X'8D'      ; =0x8d =141(-115) =CR
149b:      DC    'Y'        ; hex:d9 dec:217(-39)
149c:      DB    X'8D'      ; =0x8d =141(-115) =CR
149d:      DC    'Z'        ; hex:da dec:218(-38)
149e:      DB    X'8D'      ; =0x8d =141(-115) =CR
149f:      DC    '['        ; hex:db dec:219(-37)
14a0:      DB    X'8D'      ; =0x8d =141(-115) =CR
14a1:      DC    '\'        ; hex:dc dec:220(-36)
14a2:      DB    X'8D'      ; =0x8d =141(-115) =CR
14a3:      DC    ']'        ; hex:dd dec:221(-35)
14a4:      DB    X'8D'      ; =0x8d =141(-115) =CR
14a5:      DC    '^'        ; hex:de dec:222(-34)
14a6:      DB    X'8D'      ; =0x8d =141(-115) =CR
14a7:      DW    X'DF8D'    ; =0xdf8d =57229(-8307) =DEL,CR
14a9:      DC    '`'        ; hex:e0 dec:224(-32)
14aa:      DB    X'8D'      ; =0x8d =141(-115) =CR
14ab:      DC    'a'        ; hex:e1 dec:225(-31)
14ac:      DB    X'8D'      ; =0x8d =141(-115) =CR
14ad:      DC    'b'        ; hex:e2 dec:226(-30)
14ae:      DB    X'8D'      ; =0x8d =141(-115) =CR
14af:      DC    'c'        ; hex:e3 dec:227(-29)
14b0:      DB    X'8D'      ; =0x8d =141(-115) =CR
14b1:      DC    'd'        ; hex:e4 dec:228(-28)
14b2:      DB    X'8D'      ; =0x8d =141(-115) =CR
14b3:      DC    'e'        ; hex:e5 dec:229(-27)
14b4:      DB    X'8D'      ; =0x8d =141(-115) =CR
14b5:      DC    'f'        ; hex:e6 dec:230(-26)
14b6:      DB    X'8D'      ; =0x8d =141(-115) =CR
14b7:      DC    'g'        ; hex:e7 dec:231(-25)
14b8:      DB    X'8D'      ; =0x8d =141(-115) =CR
14b9:      DC    'h'        ; hex:e8 dec:232(-24)
14ba:      DB    X'8D'      ; =0x8d =141(-115) =CR
14bb:      DC    'i'        ; hex:e9 dec:233(-23)
14bc:      DB    X'8D'      ; =0x8d =141(-115) =CR
14bd:      DC    'j'        ; hex:ea dec:234(-22)
14be:      DB    X'8D'      ; =0x8d =141(-115) =CR
14bf:      DC    'k'        ; hex:eb dec:235(-21)
14c0:      DB    X'8D'      ; =0x8d =141(-115) =CR
14c1:      DC    'l'        ; hex:ec dec:236(-20)
14c2:      DB    X'8D'      ; =0x8d =141(-115) =CR
14c3:      DC    'm'        ; hex:ed dec:237(-19)
14c4:      DB    X'8D'      ; =0x8d =141(-115) =CR
14c5:      DC    'n'        ; hex:ee dec:238(-18)
14c6:      DB    X'8D'      ; =0x8d =141(-115) =CR
14c7:      DC    'o'        ; hex:ef dec:239(-17)
14c8:      DB    X'8D'      ; =0x8d =141(-115) =CR
14c9:      DC    'p'        ; hex:f0 dec:240(-16)
14ca:      DB    X'8D'      ; =0x8d =141(-115) =CR
14cb:      DC    'q'        ; hex:f1 dec:241(-15)
14cc:      DB    X'8D'      ; =0x8d =141(-115) =CR
14cd:      DC    'r'        ; hex:f2 dec:242(-14)
14ce:      DB    X'8D'      ; =0x8d =141(-115) =CR
14cf:      DC    's'        ; hex:f3 dec:243(-13)
14d0:      DB    X'8D'      ; =0x8d =141(-115) =CR
14d1:      DC    't'        ; hex:f4 dec:244(-12)
14d2:      DB    X'8D'      ; =0x8d =141(-115) =CR
14d3:      DC    'u'        ; hex:f5 dec:245(-11)
14d4:      DB    X'8D'      ; =0x8d =141(-115) =CR
14d5:      DC    'v'        ; hex:f6 dec:246(-10)
14d6:      DB    X'8D'      ; =0x8d =141(-115) =CR
14d7:      DC    'w'        ; hex:f7 dec:247(-9)
14d8:      DB    X'8D'      ; =0x8d =141(-115) =CR
14d9:      DC    'x'        ; hex:f8 dec:248(-8)
14da:      DB    X'8D'      ; =0x8d =141(-115) =CR
14db:      DC    'y'        ; hex:f9 dec:249(-7)
14dc:      DB    X'8D'      ; =0x8d =141(-115) =CR
14dd:      DC    'z'        ; hex:fa dec:250(-6)
14de:      DB    X'8D'      ; =0x8d =141(-115) =CR
14df:      DC    '{'        ; hex:fb dec:251(-5)
14e0:      DB    X'8D'      ; =0x8d =141(-115) =CR
14e1:      DC    '|'        ; hex:fc dec:252(-4)
14e2:      DB    X'8D'      ; =0x8d =141(-115) =CR
14e3:      DC    '}'        ; hex:fd dec:253(-3)
14e4:      DB    X'8D'      ; =0x8d =141(-115) =CR
14e5:      DC    '~'        ; hex:fe dec:254(-2)
14e6:      DB    X'8D'      ; =0x8d =141(-115) =CR
14e7:      DW    X'FF8E'    ; =0xff8e =65422(-114)
14e9:      DB    X'00'      ; =0x00 =0 =NUL
14ea:      DW    X'8E01'    ; =0x8e01 =36353(-29183)
14ec:      DW    X'8E02'    ; =0x8e02 =36354(-29182)
14ee:      DW    X'8E03'    ; =0x8e03 =36355(-29181)
14f0:      DW    X'8E04'    ; =0x8e04 =36356(-29180)
14f2:      DW    X'8E05'    ; =0x8e05 =36357(-29179)
14f4:      DW    X'8E06'    ; =0x8e06 =36358(-29178)
14f6:      DW    X'8E07'    ; =0x8e07 =36359(-29177)
14f8:      DW    X'8E08'    ; =0x8e08 =36360(-29176)
14fa:      DW    X'8E09'    ; =0x8e09 =36361(-29175)
14fc:      DW    X'8E0A'    ; =0x8e0a =36362(-29174)
14fe:      DW    X'8E0B'    ; =0x8e0b =36363(-29173)
1500:      DW    X'8E0C'    ; =0x8e0c =36364(-29172)
1502:      DW    X'8E0D'    ; =0x8e0d =36365(-29171)
1504:      DW    X'8E0E'    ; =0x8e0e =36366(-29170)
1506:      DW    X'8E0F'    ; =0x8e0f =36367(-29169)
1508:      DW    X'8E10'    ; =0x8e10 =36368(-29168)
150a:      DW    X'8E11'    ; =0x8e11 =36369(-29167)
150c:      DW    X'8E12'    ; =0x8e12 =36370(-29166)
150e:      DW    X'8E13'    ; =0x8e13 =36371(-29165)
1510:      DW    X'8E14'    ; =0x8e14 =36372(-29164)
1512:      DW    X'8E15'    ; =0x8e15 =36373(-29163)
1514:      DW    X'8E16'    ; =0x8e16 =36374(-29162)
1516:      DW    X'8E17'    ; =0x8e17 =36375(-29161)
1518:      DW    X'8E18'    ; =0x8e18 =36376(-29160)
151a:      DW    X'8E19'    ; =0x8e19 =36377(-29159)
151c:      DW    X'8E1A'    ; =0x8e1a =36378(-29158)
151e:      DW    X'8E1B'    ; =0x8e1b =36379(-29157)
1520:      DW    X'8E1C'    ; =0x8e1c =36380(-29156)
1522:      DW    X'8E1D'    ; =0x8e1d =36381(-29155)
1524:      DW    X'8E1E'    ; =0x8e1e =36382(-29154)
1526:      DW    X'8E1F'    ; =0x8e1f =36383(-29153)
1528:      DW    X'8E20'    ; =0x8e20 =36384(-29152)
152a:      DW    X'8E21'    ; =0x8e21 =36385(-29151)
152c:      DW    X'8E22'    ; =0x8e22 =36386(-29150)
152e:      DW    X'8E23'    ; =0x8e23 =36387(-29149)
1530:      DW    X'8E24'    ; =0x8e24 =36388(-29148)
1532:      DW    X'8E25'    ; =0x8e25 =36389(-29147)
1534:      DW    X'8E26'    ; =0x8e26 =36390(-29146)
1536:      DW    X'8E27'    ; =0x8e27 =36391(-29145)
1538:      DW    X'8E28'    ; =0x8e28 =36392(-29144)
153a:      DW    X'8E29'    ; =0x8e29 =36393(-29143)
153c:      DW    X'8E2A'    ; =0x8e2a =36394(-29142)
153e:      DW    X'8E2B'    ; =0x8e2b =36395(-29141)
1540:      DW    X'8E2C'    ; =0x8e2c =36396(-29140)
1542:      DW    X'8E2D'    ; =0x8e2d =36397(-29139)
1544:      DW    X'8E2E'    ; =0x8e2e =36398(-29138)
1546:      DW    X'8E2F'    ; =0x8e2f =36399(-29137)
1548:      DW    X'8E30'    ; =0x8e30 =36400(-29136)
154a:      DW    X'8E31'    ; =0x8e31 =36401(-29135)
154c:      DW    X'8E32'    ; =0x8e32 =36402(-29134)
154e:      DW    X'8E33'    ; =0x8e33 =36403(-29133)
1550:      DW    X'8E34'    ; =0x8e34 =36404(-29132)
1552:      DW    X'8E35'    ; =0x8e35 =36405(-29131)
1554:      DW    X'8E36'    ; =0x8e36 =36406(-29130)
1556:      DW    X'8E37'    ; =0x8e37 =36407(-29129)
1558:      DW    X'8E38'    ; =0x8e38 =36408(-29128)
155a:      DW    X'8E39'    ; =0x8e39 =36409(-29127)
155c:      DW    X'8E3A'    ; =0x8e3a =36410(-29126)
155e:      DW    X'8E3B'    ; =0x8e3b =36411(-29125)
1560:      DW    X'8E3C'    ; =0x8e3c =36412(-29124)
1562:      DW    X'8E3D'    ; =0x8e3d =36413(-29123)
1564:      DW    X'8E3E'    ; =0x8e3e =36414(-29122)
1566:      DW    X'8E3F'    ; =0x8e3f =36415(-29121)
1568:      DW    X'8E40'    ; =0x8e40 =36416(-29120)
156a:      DW    X'8E41'    ; =0x8e41 =36417(-29119)
156c:      DW    X'8E42'    ; =0x8e42 =36418(-29118)
156e:      DW    X'8E43'    ; =0x8e43 =36419(-29117)
1570:      DW    X'8E44'    ; =0x8e44 =36420(-29116)
1572:      DW    X'8E45'    ; =0x8e45 =36421(-29115)
1574:      DW    X'8E46'    ; =0x8e46 =36422(-29114)
1576:      DW    X'8E47'    ; =0x8e47 =36423(-29113)
1578:      DW    X'8E48'    ; =0x8e48 =36424(-29112)
157a:      DW    X'8E49'    ; =0x8e49 =36425(-29111)
157c:      DW    X'8E4A'    ; =0x8e4a =36426(-29110)
157e:      DW    X'8E4B'    ; =0x8e4b =36427(-29109)
1580:      DW    X'8E4C'    ; =0x8e4c =36428(-29108)
1582:      DW    X'8E4D'    ; =0x8e4d =36429(-29107)
1584:      DW    X'8E4E'    ; =0x8e4e =36430(-29106)
1586:      DW    X'8E4F'    ; =0x8e4f =36431(-29105)
1588:      DW    X'8E50'    ; =0x8e50 =36432(-29104)
158a:      DW    X'8E51'    ; =0x8e51 =36433(-29103)
158c:      DW    X'8E52'    ; =0x8e52 =36434(-29102)
158e:      DW    X'8E53'    ; =0x8e53 =36435(-29101)
1590:      DW    X'8E54'    ; =0x8e54 =36436(-29100)
1592:      DW    X'8E55'    ; =0x8e55 =36437(-29099)
1594:      DW    X'8E56'    ; =0x8e56 =36438(-29098)
1596:      DW    X'8E57'    ; =0x8e57 =36439(-29097)
1598:      DW    X'8E58'    ; =0x8e58 =36440(-29096)
159a:      DW    X'8E59'    ; =0x8e59 =36441(-29095)
159c:      DW    X'8E5A'    ; =0x8e5a =36442(-29094)
159e:      DW    X'8E5B'    ; =0x8e5b =36443(-29093)
15a0:      DW    X'8E5C'    ; =0x8e5c =36444(-29092)
15a2:      DW    X'8E5D'    ; =0x8e5d =36445(-29091)
15a4:      DW    X'8E5E'    ; =0x8e5e =36446(-29090)
15a6:      DW    X'8E5F'    ; =0x8e5f =36447(-29089)
15a8:      DW    X'8E60'    ; =0x8e60 =36448(-29088)
15aa:      DW    X'8E61'    ; =0x8e61 =36449(-29087)
15ac:      DW    X'8E62'    ; =0x8e62 =36450(-29086)
15ae:      DW    X'8E63'    ; =0x8e63 =36451(-29085)
15b0:      DW    X'8E64'    ; =0x8e64 =36452(-29084)
15b2:      DW    X'8E65'    ; =0x8e65 =36453(-29083)
15b4:      DW    X'8E66'    ; =0x8e66 =36454(-29082)
15b6:      DW    X'8E67'    ; =0x8e67 =36455(-29081)
15b8:      DW    X'8E68'    ; =0x8e68 =36456(-29080)
15ba:      DW    X'8E69'    ; =0x8e69 =36457(-29079)
15bc:      DW    X'8E6A'    ; =0x8e6a =36458(-29078)
15be:      DW    X'8E6B'    ; =0x8e6b =36459(-29077)
15c0:      DW    X'8E6C'    ; =0x8e6c =36460(-29076)
15c2:      DW    X'8E6D'    ; =0x8e6d =36461(-29075)
15c4:      DW    X'8E6E'    ; =0x8e6e =36462(-29074)
15c6:      DW    X'8E6F'    ; =0x8e6f =36463(-29073)
15c8:      DW    X'8E70'    ; =0x8e70 =36464(-29072)
15ca:      DW    X'8E71'    ; =0x8e71 =36465(-29071)
15cc:      DW    X'8E72'    ; =0x8e72 =36466(-29070)
15ce:      DW    X'8E73'    ; =0x8e73 =36467(-29069)
15d0:      DW    X'8E74'    ; =0x8e74 =36468(-29068)
15d2:      DW    X'8E75'    ; =0x8e75 =36469(-29067)
15d4:      DW    X'8E76'    ; =0x8e76 =36470(-29066)
15d6:      DW    X'8E77'    ; =0x8e77 =36471(-29065)
15d8:      DW    X'8E78'    ; =0x8e78 =36472(-29064)
15da:      DW    X'8E79'    ; =0x8e79 =36473(-29063)
15dc:      DW    X'8E7A'    ; =0x8e7a =36474(-29062)
15de:      DW    X'8E7B'    ; =0x8e7b =36475(-29061)
15e0:      DW    X'8E7C'    ; =0x8e7c =36476(-29060)
15e2:      DW    X'8E7D'    ; =0x8e7d =36477(-29059)
15e4:      DW    X'8E7E'    ; =0x8e7e =36478(-29058)
15e6:      DW    X'8E7F'    ; =0x8e7f =36479(-29057)
15e8:      DW    X'8E80'    ; =0x8e80 =36480(-29056)
15ea:      DW    X'8E81'    ; =0x8e81 =36481(-29055)
15ec:      DW    X'8E82'    ; =0x8e82 =36482(-29054)
15ee:      DW    X'8E83'    ; =0x8e83 =36483(-29053)
15f0:      DW    X'8E84'    ; =0x8e84 =36484(-29052)
15f2:      DW    X'8E85'    ; =0x8e85 =36485(-29051)
15f4:      DW    X'8E86'    ; =0x8e86 =36486(-29050)
15f6:      DW    X'8E87'    ; =0x8e87 =36487(-29049)
15f8:      DW    X'8E88'    ; =0x8e88 =36488(-29048)
15fa:      DW    X'8E89'    ; =0x8e89 =36489(-29047)
15fc:      DW    X'8E8A'    ; =0x8e8a =36490(-29046)
15fe:      DW    X'8E8B'    ; =0x8e8b =36491(-29045)
1600:      DW    X'8E8C'    ; =0x8e8c =36492(-29044)
1602:      DW    X'8E8D'    ; =0x8e8d =36493(-29043)
1604:      DW    X'8E8E'    ; =0x8e8e =36494(-29042)
1606:      DW    X'8E8F'    ; =0x8e8f =36495(-29041)
1608:      DW    X'8E90'    ; =0x8e90 =36496(-29040)
160a:      DW    X'8E91'    ; =0x8e91 =36497(-29039)
160c:      DW    X'8E92'    ; =0x8e92 =36498(-29038)
160e:      DW    X'8E93'    ; =0x8e93 =36499(-29037)
1610:      DW    X'8E94'    ; =0x8e94 =36500(-29036)
1612:      DW    X'8E95'    ; =0x8e95 =36501(-29035)
1614:      DW    X'8E96'    ; =0x8e96 =36502(-29034)
1616:      DW    X'8E97'    ; =0x8e97 =36503(-29033)
1618:      DW    X'8E98'    ; =0x8e98 =36504(-29032)
161a:      DW    X'8E99'    ; =0x8e99 =36505(-29031)
161c:      DW    X'8E9A'    ; =0x8e9a =36506(-29030)
161e:      DW    X'8E9B'    ; =0x8e9b =36507(-29029)
1620:      DW    X'8E9C'    ; =0x8e9c =36508(-29028)
1622:      DW    X'8E9D'    ; =0x8e9d =36509(-29027)
1624:      DW    X'8E9E'    ; =0x8e9e =36510(-29026)
1626:      DW    X'8E9F'    ; =0x8e9f =36511(-29025)
1628:      DB    X'8E'      ; =0x8e =142(-114)
1629:      DC    ' '        ; hex:a0 dec:160(-96)
162a:      DB    X'8E'      ; =0x8e =142(-114)
162b:      DC    '!'        ; hex:a1 dec:161(-95)
162c:      DB    X'8E'      ; =0x8e =142(-114)
162d:      DC    '"'        ; hex:a2 dec:162(-94)
162e:      DB    X'8E'      ; =0x8e =142(-114)
162f:      DC    '#'        ; hex:a3 dec:163(-93)
1630:      DB    X'8E'      ; =0x8e =142(-114)
1631:      DC    '$'        ; hex:a4 dec:164(-92)
1632:      DB    X'8E'      ; =0x8e =142(-114)
1633:      DC    '%'        ; hex:a5 dec:165(-91)
1634:      DB    X'8E'      ; =0x8e =142(-114)
1635:      DC    '&'        ; hex:a6 dec:166(-90)
1636:      DW    X'8EA7'    ; =0x8ea7 =36519(-29017)
1638:      DB    X'8E'      ; =0x8e =142(-114)
1639:      DC    '('        ; hex:a8 dec:168(-88)
163a:      DB    X'8E'      ; =0x8e =142(-114)
163b:      DC    ')'        ; hex:a9 dec:169(-87)
163c:      DB    X'8E'      ; =0x8e =142(-114)
163d:      DC    '*'        ; hex:aa dec:170(-86)
163e:      DB    X'8E'      ; =0x8e =142(-114)
163f:      DC    '+'        ; hex:ab dec:171(-85)
1640:      DB    X'8E'      ; =0x8e =142(-114)
1641:      DC    ','        ; hex:ac dec:172(-84)
1642:      DB    X'8E'      ; =0x8e =142(-114)
1643:      DC    '-'        ; hex:ad dec:173(-83)
1644:      DB    X'8E'      ; =0x8e =142(-114)
1645:      DC    '.'        ; hex:ae dec:174(-82)
1646:      DB    X'8E'      ; =0x8e =142(-114)
1647:      DC    '/'        ; hex:af dec:175(-81)
1648:      DB    X'8E'      ; =0x8e =142(-114)
1649:      DC    '0'        ; hex:b0 dec:176(-80)
164a:      DB    X'8E'      ; =0x8e =142(-114)
164b:      DC    '1'        ; hex:b1 dec:177(-79)
164c:      DB    X'8E'      ; =0x8e =142(-114)
164d:      DC    '2'        ; hex:b2 dec:178(-78)
164e:      DB    X'8E'      ; =0x8e =142(-114)
164f:      DC    '3'        ; hex:b3 dec:179(-77)
1650:      DB    X'8E'      ; =0x8e =142(-114)
1651:      DC    '4'        ; hex:b4 dec:180(-76)
1652:      DB    X'8E'      ; =0x8e =142(-114)
1653:      DC    '5'        ; hex:b5 dec:181(-75)
1654:      DB    X'8E'      ; =0x8e =142(-114)
1655:      DC    '6'        ; hex:b6 dec:182(-74)
1656:      DB    X'8E'      ; =0x8e =142(-114)
1657:      DC    '7'        ; hex:b7 dec:183(-73)
1658:      DB    X'8E'      ; =0x8e =142(-114)
1659:      DC    '8'        ; hex:b8 dec:184(-72)
165a:      DB    X'8E'      ; =0x8e =142(-114)
165b:      DC    '9'        ; hex:b9 dec:185(-71)
165c:      DB    X'8E'      ; =0x8e =142(-114)
165d:      DC    ':'        ; hex:ba dec:186(-70)
165e:      DB    X'8E'      ; =0x8e =142(-114)
165f:      DC    ';'        ; hex:bb dec:187(-69)
1660:      DB    X'8E'      ; =0x8e =142(-114)
1661:      DC    '<'        ; hex:bc dec:188(-68)
1662:      DB    X'8E'      ; =0x8e =142(-114)
1663:      DC    '='        ; hex:bd dec:189(-67)
1664:      DB    X'8E'      ; =0x8e =142(-114)
1665:      DC    '>'        ; hex:be dec:190(-66)
1666:      DB    X'8E'      ; =0x8e =142(-114)
1667:      DC    '?'        ; hex:bf dec:191(-65)
1668:      DB    X'8E'      ; =0x8e =142(-114)
1669:      DC    '@'        ; hex:c0 dec:192(-64)
166a:      DB    X'8E'      ; =0x8e =142(-114)
166b:      DC    'A'        ; hex:c1 dec:193(-63)
166c:      DB    X'8E'      ; =0x8e =142(-114)
166d:      DC    'B'        ; hex:c2 dec:194(-62)
166e:      DB    X'8E'      ; =0x8e =142(-114)
166f:      DC    'C'        ; hex:c3 dec:195(-61)
1670:      DB    X'8E'      ; =0x8e =142(-114)
1671:      DC    'D'        ; hex:c4 dec:196(-60)
1672:      DB    X'8E'      ; =0x8e =142(-114)
1673:      DC    'E'        ; hex:c5 dec:197(-59)
1674:      DB    X'8E'      ; =0x8e =142(-114)
1675:      DC    'F'        ; hex:c6 dec:198(-58)
1676:      DB    X'8E'      ; =0x8e =142(-114)
1677:      DC    'G'        ; hex:c7 dec:199(-57)
1678:      DB    X'8E'      ; =0x8e =142(-114)
1679:      DC    'H'        ; hex:c8 dec:200(-56)
167a:      DB    X'8E'      ; =0x8e =142(-114)
167b:      DC    'I'        ; hex:c9 dec:201(-55)
167c:      DB    X'8E'      ; =0x8e =142(-114)
167d:      DC    'J'        ; hex:ca dec:202(-54)
167e:      DB    X'8E'      ; =0x8e =142(-114)
167f:      DC    'K'        ; hex:cb dec:203(-53)
1680:      DB    X'8E'      ; =0x8e =142(-114)
1681:      DC    'L'        ; hex:cc dec:204(-52)
1682:      DB    X'8E'      ; =0x8e =142(-114)
1683:      DC    'M'        ; hex:cd dec:205(-51)
1684:      DB    X'8E'      ; =0x8e =142(-114)
1685:      DC    'N'        ; hex:ce dec:206(-50)
1686:      DB    X'8E'      ; =0x8e =142(-114)
1687:      DC    'O'        ; hex:cf dec:207(-49)
1688:      DB    X'8E'      ; =0x8e =142(-114)
1689:      DC    'P'        ; hex:d0 dec:208(-48)
168a:      DB    X'8E'      ; =0x8e =142(-114)
168b:      DC    'Q'        ; hex:d1 dec:209(-47)
168c:      DB    X'8E'      ; =0x8e =142(-114)
168d:      DC    'R'        ; hex:d2 dec:210(-46)
168e:      DB    X'8E'      ; =0x8e =142(-114)
168f:      DC    'S'        ; hex:d3 dec:211(-45)
1690:      DB    X'8E'      ; =0x8e =142(-114)
1691:      DC    'T'        ; hex:d4 dec:212(-44)
1692:      DB    X'8E'      ; =0x8e =142(-114)
1693:      DC    'U'        ; hex:d5 dec:213(-43)
1694:      DB    X'8E'      ; =0x8e =142(-114)
1695:      DC    'V'        ; hex:d6 dec:214(-42)
1696:      DB    X'8E'      ; =0x8e =142(-114)
1697:      DC    'W'        ; hex:d7 dec:215(-41)
1698:      DB    X'8E'      ; =0x8e =142(-114)
1699:      DC    'X'        ; hex:d8 dec:216(-40)
169a:      DB    X'8E'      ; =0x8e =142(-114)
169b:      DC    'Y'        ; hex:d9 dec:217(-39)
169c:      DB    X'8E'      ; =0x8e =142(-114)
169d:      DC    'Z'        ; hex:da dec:218(-38)
169e:      DB    X'8E'      ; =0x8e =142(-114)
169f:      DC    '['        ; hex:db dec:219(-37)
16a0:      DB    X'8E'      ; =0x8e =142(-114)
16a1:      DC    '\'        ; hex:dc dec:220(-36)
16a2:      DB    X'8E'      ; =0x8e =142(-114)
16a3:      DC    ']'        ; hex:dd dec:221(-35)
16a4:      DB    X'8E'      ; =0x8e =142(-114)
16a5:      DC    '^'        ; hex:de dec:222(-34)
16a6:      DW    X'8EDF'    ; =0x8edf =36575(-28961)
16a8:      DB    X'8E'      ; =0x8e =142(-114)
16a9:      DC    '`'        ; hex:e0 dec:224(-32)
16aa:      DB    X'8E'      ; =0x8e =142(-114)
16ab:      DC    'a'        ; hex:e1 dec:225(-31)
16ac:      DB    X'8E'      ; =0x8e =142(-114)
16ad:      DC    'b'        ; hex:e2 dec:226(-30)
16ae:      DB    X'8E'      ; =0x8e =142(-114)
16af:      DC    'c'        ; hex:e3 dec:227(-29)
16b0:      DB    X'8E'      ; =0x8e =142(-114)
16b1:      DC    'd'        ; hex:e4 dec:228(-28)
16b2:      DB    X'8E'      ; =0x8e =142(-114)
16b3:      DC    'e'        ; hex:e5 dec:229(-27)
16b4:      DB    X'8E'      ; =0x8e =142(-114)
16b5:      DC    'f'        ; hex:e6 dec:230(-26)
16b6:      DB    X'8E'      ; =0x8e =142(-114)
16b7:      DC    'g'        ; hex:e7 dec:231(-25)
16b8:      DB    X'8E'      ; =0x8e =142(-114)
16b9:      DC    'h'        ; hex:e8 dec:232(-24)
16ba:      DB    X'8E'      ; =0x8e =142(-114)
16bb:      DC    'i'        ; hex:e9 dec:233(-23)
16bc:      DB    X'8E'      ; =0x8e =142(-114)
16bd:      DC    'j'        ; hex:ea dec:234(-22)
16be:      DB    X'8E'      ; =0x8e =142(-114)
16bf:      DC    'k'        ; hex:eb dec:235(-21)
16c0:      DB    X'8E'      ; =0x8e =142(-114)
16c1:      DC    'l'        ; hex:ec dec:236(-20)
16c2:      DB    X'8E'      ; =0x8e =142(-114)
16c3:      DC    'm'        ; hex:ed dec:237(-19)
16c4:      DB    X'8E'      ; =0x8e =142(-114)
16c5:      DC    'n'        ; hex:ee dec:238(-18)
16c6:      DB    X'8E'      ; =0x8e =142(-114)
16c7:      DC    'o'        ; hex:ef dec:239(-17)
16c8:      DB    X'8E'      ; =0x8e =142(-114)
16c9:      DC    'p'        ; hex:f0 dec:240(-16)
16ca:      DB    X'8E'      ; =0x8e =142(-114)
16cb:      DC    'q'        ; hex:f1 dec:241(-15)
16cc:      DB    X'8E'      ; =0x8e =142(-114)
16cd:      DC    'r'        ; hex:f2 dec:242(-14)
16ce:      DB    X'8E'      ; =0x8e =142(-114)
16cf:      DC    's'        ; hex:f3 dec:243(-13)
16d0:      DB    X'8E'      ; =0x8e =142(-114)
16d1:      DC    't'        ; hex:f4 dec:244(-12)
16d2:      DB    X'8E'      ; =0x8e =142(-114)
16d3:      DC    'u'        ; hex:f5 dec:245(-11)
16d4:      DB    X'8E'      ; =0x8e =142(-114)
16d5:      DC    'v'        ; hex:f6 dec:246(-10)
16d6:      DB    X'8E'      ; =0x8e =142(-114)
16d7:      DC    'w'        ; hex:f7 dec:247(-9)
16d8:      DB    X'8E'      ; =0x8e =142(-114)
16d9:      DC    'x'        ; hex:f8 dec:248(-8)
16da:      DB    X'8E'      ; =0x8e =142(-114)
16db:      DC    'y'        ; hex:f9 dec:249(-7)
16dc:      DB    X'8E'      ; =0x8e =142(-114)
16dd:      DC    'z'        ; hex:fa dec:250(-6)
16de:      DB    X'8E'      ; =0x8e =142(-114)
16df:      DC    '{'        ; hex:fb dec:251(-5)
16e0:      DB    X'7D'      ; =0x7d =125
16e1:      DC    'D'        ; hex:c4 dec:196(-60)
16e2:      DB    X'00'      ; =0x00 =0 =NUL
16e3:      DB    X'00'      ; =0x00 =0 =NUL
16e4:      DC    'o'        ; hex:ef dec:239(-17)
16e5:      DB    X'2C'      ; =0x2c =44
16e6:      DC    'd'        ; hex:e4 dec:228(-28)
16e7:      DW    X'54FF'    ; =0x54ff =21759
16e9:      DW    X'FF8F'    ; =0xff8f =65423(-113)
16eb:      DW    X'018F'    ; =0x018f =399
16ed:      DW    X'028F'    ; =0x028f =655
16ef:      DW    X'038F'    ; =0x038f =911
16f1:      DW    X'048F'    ; =0x048f =1167
16f3:      DW    X'058F'    ; =0x058f =1423
16f5:      DW    X'068F'    ; =0x068f =1679
16f7:      DW    X'078F'    ; =0x078f =1935
16f9:      DW    X'088F'    ; =0x088f =2191
16fb:      DW    X'098F'    ; =0x098f =2447
16fd:      DW    X'0A8F'    ; =0x0a8f =2703
16ff:      DW    X'0B8F'    ; =0x0b8f =2959
1701:      DW    X'0C8F'    ; =0x0c8f =3215
1703:      DW    X'0D8F'    ; =0x0d8f =3471
1705:      DW    X'0E8F'    ; =0x0e8f =3727
1707:      DW    X'0F8F'    ; =0x0f8f =3983
1709:      DW    X'108F'    ; =0x108f =4239
170b:      DW    X'118F'    ; =0x118f =4495
170d:      DW    X'128F'    ; =0x128f =4751
170f:      DW    X'138F'    ; =0x138f =5007
1711:      DW    X'148F'    ; =0x148f =5263
1713:      DW    X'158F'    ; =0x158f =5519
1715:      DW    X'168F'    ; =0x168f =5775
1717:      DW    X'178F'    ; =0x178f =6031
1719:      DW    X'188F'    ; =0x188f =6287
171b:      DW    X'198F'    ; =0x198f =6543
171d:      DW    X'1A8F'    ; =0x1a8f =6799
171f:      DW    X'1B8F'    ; =0x1b8f =7055
1721:      DW    X'1C8F'    ; =0x1c8f =7311
1723:      DW    X'1D8F'    ; =0x1d8f =7567
1725:      DW    X'1E8F'    ; =0x1e8f =7823
1727:      DW    X'1F8F'    ; =0x1f8f =8079
1729:      DW    X'208F'    ; =0x208f =8335
172b:      DW    X'218F'    ; =0x218f =8591
172d:      DW    X'228F'    ; =0x228f =8847
172f:      DW    X'238F'    ; =0x238f =9103
1731:      DW    X'248F'    ; =0x248f =9359
1733:      DW    X'258F'    ; =0x258f =9615
1735:      DW    X'268F'    ; =0x268f =9871
1737:      DW    X'278F'    ; =0x278f =10127
1739:      DW    X'288F'    ; =0x288f =10383
173b:      DW    X'298F'    ; =0x298f =10639
173d:      DW    X'2A8F'    ; =0x2a8f =10895
173f:      DW    X'2B8F'    ; =0x2b8f =11151
1741:      DW    X'2C8F'    ; =0x2c8f =11407
1743:      DW    X'2D8F'    ; =0x2d8f =11663
1745:      DW    X'2E8F'    ; =0x2e8f =11919
1747:      DW    X'2F8F'    ; =0x2f8f =12175
1749:      DW    X'308F'    ; =0x308f =12431
174b:      DW    X'318F'    ; =0x318f =12687
174d:      DW    X'328F'    ; =0x328f =12943
174f:      DW    X'338F'    ; =0x338f =13199
1751:      DW    X'348F'    ; =0x348f =13455
1753:      DW    X'358F'    ; =0x358f =13711
1755:      DW    X'368F'    ; =0x368f =13967
1757:      DW    X'378F'    ; =0x378f =14223
1759:      DW    X'388F'    ; =0x388f =14479
175b:      DW    X'398F'    ; =0x398f =14735
175d:      DW    X'3A8F'    ; =0x3a8f =14991
175f:      DW    X'3B8F'    ; =0x3b8f =15247
1761:      DW    X'3C8F'    ; =0x3c8f =15503
1763:      DW    X'3D8F'    ; =0x3d8f =15759
1765:      DW    X'3E8F'    ; =0x3e8f =16015
1767:      DW    X'3F8F'    ; =0x3f8f =16271
1769:      DW    X'408F'    ; =0x408f =16527
176b:      DW    X'418F'    ; =0x418f =16783
176d:      DW    X'428F'    ; =0x428f =17039
176f:      DW    X'438F'    ; =0x438f =17295
1771:      DW    X'448F'    ; =0x448f =17551
1773:      DW    X'458F'    ; =0x458f =17807
1775:      DW    X'468F'    ; =0x468f =18063
1777:      DW    X'478F'    ; =0x478f =18319
1779:      DW    X'488F'    ; =0x488f =18575
177b:      DW    X'498F'    ; =0x498f =18831
177d:      DW    X'4A8F'    ; =0x4a8f =19087
177f:      DW    X'4B8F'    ; =0x4b8f =19343
1781:      DW    X'4C8F'    ; =0x4c8f =19599
1783:      DW    X'4D8F'    ; =0x4d8f =19855
1785:      DW    X'4E8F'    ; =0x4e8f =20111
1787:      DW    X'4F8F'    ; =0x4f8f =20367
1789:      DW    X'508F'    ; =0x508f =20623
178b:      DW    X'518F'    ; =0x518f =20879
178d:      DW    X'528F'    ; =0x528f =21135
178f:      DW    X'538F'    ; =0x538f =21391
1791:      DW    X'548F'    ; =0x548f =21647
1793:      DW    X'558F'    ; =0x558f =21903
1795:      DW    X'568F'    ; =0x568f =22159
1797:      DW    X'578F'    ; =0x578f =22415
1799:      DW    X'588F'    ; =0x588f =22671
179b:      DW    X'598F'    ; =0x598f =22927
179d:      DW    X'5A8F'    ; =0x5a8f =23183
179f:      DW    X'5B8F'    ; =0x5b8f =23439
17a1:      DW    X'5C8F'    ; =0x5c8f =23695
17a3:      DW    X'5D8F'    ; =0x5d8f =23951
17a5:      DW    X'5E8F'    ; =0x5e8f =24207
17a7:      DW    X'5F8F'    ; =0x5f8f =24463
17a9:      DW    X'608F'    ; =0x608f =24719
17ab:      DW    X'618F'    ; =0x618f =24975
17ad:      DW    X'628F'    ; =0x628f =25231
17af:      DW    X'638F'    ; =0x638f =25487
17b1:      DW    X'648F'    ; =0x648f =25743
17b3:      DW    X'658F'    ; =0x658f =25999
17b5:      DW    X'668F'    ; =0x668f =26255
17b7:      DW    X'678F'    ; =0x678f =26511
17b9:      DW    X'688F'    ; =0x688f =26767
17bb:      DW    X'698F'    ; =0x698f =27023
17bd:      DW    X'6A8F'    ; =0x6a8f =27279
17bf:      DW    X'6B8F'    ; =0x6b8f =27535
17c1:      DW    X'6C8F'    ; =0x6c8f =27791
17c3:      DW    X'6D8F'    ; =0x6d8f =28047
17c5:      DW    X'6E8F'    ; =0x6e8f =28303
17c7:      DW    X'6F8F'    ; =0x6f8f =28559
17c9:      DW    X'708F'    ; =0x708f =28815
17cb:      DW    X'718F'    ; =0x718f =29071
17cd:      DW    X'728F'    ; =0x728f =29327
17cf:      DW    X'738F'    ; =0x738f =29583
17d1:      DW    X'748F'    ; =0x748f =29839
17d3:      DW    X'758F'    ; =0x758f =30095
17d5:      DW    X'768F'    ; =0x768f =30351
17d7:      DW    X'778F'    ; =0x778f =30607
17d9:      DW    X'788F'    ; =0x788f =30863
17db:      DW    X'798F'    ; =0x798f =31119
17dd:      DW    X'7A8F'    ; =0x7a8f =31375
17df:      DW    X'7B8F'    ; =0x7b8f =31631
17e1:      DW    X'7C8F'    ; =0x7c8f =31887
17e3:      DW    X'7D8F'    ; =0x7d8f =32143
17e5:      DW    X'7E8F'    ; =0x7e8f =32399
17e7:      DW    X'7F8F'    ; =0x7f8f =32655
17e9:      DW    X'808F'    ; =0x808f =32911(-32625)
17eb:      DW    X'818F'    ; =0x818f =33167(-32369)
17ed:      DW    X'828F'    ; =0x828f =33423(-32113)
17ef:      DW    X'838F'    ; =0x838f =33679(-31857)
17f1:      DW    X'848F'    ; =0x848f =33935(-31601)
17f3:      DW    X'858F'    ; =0x858f =34191(-31345)
17f5:      DW    X'868F'    ; =0x868f =34447(-31089)
17f7:      DW    X'878F'    ; =0x878f =34703(-30833)
17f9:      DW    X'888F'    ; =0x888f =34959(-30577)
17fb:      DW    X'898F'    ; =0x898f =35215(-30321)
17fd:      DW    X'8A8F'    ; =0x8a8f =35471(-30065)
17ff:      DW    X'8B8F'    ; =0x8b8f =35727(-29809)
1801:      DW    X'8C8F'    ; =0x8c8f =35983(-29553)
1803:      DW    X'8D8F'    ; =0x8d8f =36239(-29297)
1805:      DW    X'8E8F'    ; =0x8e8f =36495(-29041)
1807:      DW    X'8F8F'    ; =0x8f8f =36751(-28785)
1809:      DW    X'908F'    ; =0x908f =37007(-28529)
180b:      DW    X'918F'    ; =0x918f =37263(-28273)
180d:      DW    X'928F'    ; =0x928f =37519(-28017)
180f:      DW    X'938F'    ; =0x938f =37775(-27761)
1811:      DW    X'948F'    ; =0x948f =38031(-27505)
1813:      DW    X'958F'    ; =0x958f =38287(-27249)
1815:      DW    X'968F'    ; =0x968f =38543(-26993)
1817:      DW    X'978F'    ; =0x978f =38799(-26737)
1819:      DW    X'988F'    ; =0x988f =39055(-26481)
181b:      DW    X'998F'    ; =0x998f =39311(-26225)
181d:      DW    X'9A8F'    ; =0x9a8f =39567(-25969)
181f:      DW    X'9B8F'    ; =0x9b8f =39823(-25713)
1821:      DW    X'9C8F'    ; =0x9c8f =40079(-25457)
1823:      DW    X'9D8F'    ; =0x9d8f =40335(-25201)
1825:      DW    X'9E8F'    ; =0x9e8f =40591(-24945)
1827:      DW    X'9F8F'    ; =0x9f8f =40847(-24689)
1829:      DC    ' '        ; hex:a0 dec:160(-96)
182a:      DB    X'8F'      ; =0x8f =143(-113)
182b:      DC    '!'        ; hex:a1 dec:161(-95)
182c:      DB    X'8F'      ; =0x8f =143(-113)
182d:      DC    '"'        ; hex:a2 dec:162(-94)
182e:      DB    X'8F'      ; =0x8f =143(-113)
182f:      DC    '#'        ; hex:a3 dec:163(-93)
1830:      DB    X'8F'      ; =0x8f =143(-113)
1831:      DC    '$'        ; hex:a4 dec:164(-92)
1832:      DB    X'8F'      ; =0x8f =143(-113)
1833:      DC    '%'        ; hex:a5 dec:165(-91)
1834:      DB    X'8F'      ; =0x8f =143(-113)
1835:      DC    '&'        ; hex:a6 dec:166(-90)
1836:      DW    X'8FA7'    ; =0x8fa7 =36775(-28761)
1838:      DB    X'8F'      ; =0x8f =143(-113)
1839:      DC    '('        ; hex:a8 dec:168(-88)
183a:      DB    X'8F'      ; =0x8f =143(-113)
183b:      DC    ')'        ; hex:a9 dec:169(-87)
183c:      DB    X'8F'      ; =0x8f =143(-113)
183d:      DC    '*'        ; hex:aa dec:170(-86)
183e:      DB    X'8F'      ; =0x8f =143(-113)
183f:      DC    '+'        ; hex:ab dec:171(-85)
1840:      DB    X'8F'      ; =0x8f =143(-113)
1841:      DC    ','        ; hex:ac dec:172(-84)
1842:      DB    X'8F'      ; =0x8f =143(-113)
1843:      DC    '-'        ; hex:ad dec:173(-83)
1844:      DB    X'8F'      ; =0x8f =143(-113)
1845:      DC    '.'        ; hex:ae dec:174(-82)
1846:      DB    X'8F'      ; =0x8f =143(-113)
1847:      DC    '/'        ; hex:af dec:175(-81)
1848:      DB    X'8F'      ; =0x8f =143(-113)
1849:      DC    '0'        ; hex:b0 dec:176(-80)
184a:      DB    X'8F'      ; =0x8f =143(-113)
184b:      DC    '1'        ; hex:b1 dec:177(-79)
184c:      DB    X'8F'      ; =0x8f =143(-113)
184d:      DC    '2'        ; hex:b2 dec:178(-78)
184e:      DB    X'8F'      ; =0x8f =143(-113)
184f:      DC    '3'        ; hex:b3 dec:179(-77)
1850:      DB    X'8F'      ; =0x8f =143(-113)
1851:      DC    '4'        ; hex:b4 dec:180(-76)
1852:      DB    X'8F'      ; =0x8f =143(-113)
1853:      DC    '5'        ; hex:b5 dec:181(-75)
1854:      DB    X'8F'      ; =0x8f =143(-113)
1855:      DC    '6'        ; hex:b6 dec:182(-74)
1856:      DB    X'8F'      ; =0x8f =143(-113)
1857:      DC    '7'        ; hex:b7 dec:183(-73)
1858:      DB    X'8F'      ; =0x8f =143(-113)
1859:      DC    '8'        ; hex:b8 dec:184(-72)
185a:      DB    X'8F'      ; =0x8f =143(-113)
185b:      DC    '9'        ; hex:b9 dec:185(-71)
185c:      DB    X'8F'      ; =0x8f =143(-113)
185d:      DC    ':'        ; hex:ba dec:186(-70)
185e:      DB    X'8F'      ; =0x8f =143(-113)
185f:      DC    ';'        ; hex:bb dec:187(-69)
1860:      DB    X'8F'      ; =0x8f =143(-113)
1861:      DC    '<'        ; hex:bc dec:188(-68)
1862:      DB    X'8F'      ; =0x8f =143(-113)
1863:      DC    '='        ; hex:bd dec:189(-67)
1864:      DB    X'8F'      ; =0x8f =143(-113)
1865:      DC    '>'        ; hex:be dec:190(-66)
1866:      DB    X'8F'      ; =0x8f =143(-113)
1867:      DC    '?'        ; hex:bf dec:191(-65)
1868:      DB    X'8F'      ; =0x8f =143(-113)
1869:      DC    '@'        ; hex:c0 dec:192(-64)
186a:      DB    X'8F'      ; =0x8f =143(-113)
186b:      DC    'A'        ; hex:c1 dec:193(-63)
186c:      DB    X'8F'      ; =0x8f =143(-113)
186d:      DC    'B'        ; hex:c2 dec:194(-62)
186e:      DB    X'8F'      ; =0x8f =143(-113)
186f:      DC    'C'        ; hex:c3 dec:195(-61)
1870:      DW    X'FFFF'    ; =0xffff =65535(-1)
1872:      DW    X'FFFF'    ; =0xffff =65535(-1)
1874:      DW    X'FFFF'    ; =0xffff =65535(-1)
1876:      DW    X'FFFF'    ; =0xffff =65535(-1)
1878:      DW    X'FFFF'    ; =0xffff =65535(-1)
187a:      DW    X'FFFF'    ; =0xffff =65535(-1)
187c:      DW    X'FFFF'    ; =0xffff =65535(-1)
187e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1880:      DW    X'FFFF'    ; =0xffff =65535(-1)
1882:      DW    X'FFFF'    ; =0xffff =65535(-1)
1884:      DW    X'FFFF'    ; =0xffff =65535(-1)
1886:      DW    X'FFFF'    ; =0xffff =65535(-1)
1888:      DW    X'FFFF'    ; =0xffff =65535(-1)
188a:      DW    X'FFFF'    ; =0xffff =65535(-1)
188c:      DW    X'FFFF'    ; =0xffff =65535(-1)
188e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1890:      DW    X'FFFF'    ; =0xffff =65535(-1)
1892:      DW    X'FFFF'    ; =0xffff =65535(-1)
1894:      DW    X'FFFF'    ; =0xffff =65535(-1)
1896:      DW    X'FFFF'    ; =0xffff =65535(-1)
1898:      DW    X'FFFF'    ; =0xffff =65535(-1)
189a:      DW    X'FFFF'    ; =0xffff =65535(-1)
189c:      DW    X'FFFF'    ; =0xffff =65535(-1)
189e:      DW    X'FFFF'    ; =0xffff =65535(-1)
18a0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18a2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18a4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18a6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18a8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18aa:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ac:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ae:      DW    X'FFFF'    ; =0xffff =65535(-1)
18b0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18b2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18b4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18b6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18b8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ba:      DW    X'FFFF'    ; =0xffff =65535(-1)
18bc:      DW    X'FFFF'    ; =0xffff =65535(-1)
18be:      DW    X'FFFF'    ; =0xffff =65535(-1)
18c0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18c2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18c4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18c6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18c8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ca:      DW    X'FFFF'    ; =0xffff =65535(-1)
18cc:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ce:      DW    X'FFFF'    ; =0xffff =65535(-1)
18d0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18d2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18d4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18d6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18d8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18da:      DW    X'FFFF'    ; =0xffff =65535(-1)
18dc:      DW    X'FFFF'    ; =0xffff =65535(-1)
18de:      DW    X'FFFF'    ; =0xffff =65535(-1)
18e0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18e2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18e4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18e6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18e8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ea:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ec:      DW    X'FFFF'    ; =0xffff =65535(-1)
18ee:      DW    X'FFFF'    ; =0xffff =65535(-1)
18f0:      DW    X'FFFF'    ; =0xffff =65535(-1)
18f2:      DW    X'FFFF'    ; =0xffff =65535(-1)
18f4:      DW    X'FFFF'    ; =0xffff =65535(-1)
18f6:      DW    X'FFFF'    ; =0xffff =65535(-1)
18f8:      DW    X'FFFF'    ; =0xffff =65535(-1)
18fa:      DW    X'FFFF'    ; =0xffff =65535(-1)
18fc:      DW    X'FFFF'    ; =0xffff =65535(-1)
18fe:      DW    X'FFFF'    ; =0xffff =65535(-1)
1900:      DW    X'FFFF'    ; =0xffff =65535(-1)
1902:      DW    X'FFFF'    ; =0xffff =65535(-1)
1904:      DW    X'FFFF'    ; =0xffff =65535(-1)
1906:      DW    X'FFFF'    ; =0xffff =65535(-1)
1908:      DW    X'FFFF'    ; =0xffff =65535(-1)
190a:      DW    X'FFFF'    ; =0xffff =65535(-1)
190c:      DW    X'FFFF'    ; =0xffff =65535(-1)
190e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1910:      DW    X'FFFF'    ; =0xffff =65535(-1)
1912:      DW    X'FFFF'    ; =0xffff =65535(-1)
1914:      DW    X'FFFF'    ; =0xffff =65535(-1)
1916:      DW    X'FFFF'    ; =0xffff =65535(-1)
1918:      DW    X'FFFF'    ; =0xffff =65535(-1)
191a:      DW    X'FFFF'    ; =0xffff =65535(-1)
191c:      DW    X'FFFF'    ; =0xffff =65535(-1)
191e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1920:      DW    X'FFFF'    ; =0xffff =65535(-1)
1922:      DW    X'FFFF'    ; =0xffff =65535(-1)
1924:      DW    X'FFFF'    ; =0xffff =65535(-1)
1926:      DW    X'FFFF'    ; =0xffff =65535(-1)
1928:      DW    X'FFFF'    ; =0xffff =65535(-1)
192a:      DW    X'FFFF'    ; =0xffff =65535(-1)
192c:      DW    X'FFFF'    ; =0xffff =65535(-1)
192e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1930:      DW    X'FFFF'    ; =0xffff =65535(-1)
1932:      DW    X'FFFF'    ; =0xffff =65535(-1)
1934:      DW    X'FFFF'    ; =0xffff =65535(-1)
1936:      DW    X'FFFF'    ; =0xffff =65535(-1)
1938:      DW    X'FFFF'    ; =0xffff =65535(-1)
193a:      DW    X'FFFF'    ; =0xffff =65535(-1)
193c:      DW    X'FFFF'    ; =0xffff =65535(-1)
193e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1940:      DW    X'FFFF'    ; =0xffff =65535(-1)
1942:      DW    X'FFFF'    ; =0xffff =65535(-1)
1944:      DW    X'FFFF'    ; =0xffff =65535(-1)
1946:      DW    X'FFFF'    ; =0xffff =65535(-1)
1948:      DW    X'FFFF'    ; =0xffff =65535(-1)
194a:      DW    X'FFFF'    ; =0xffff =65535(-1)
194c:      DW    X'FFFF'    ; =0xffff =65535(-1)
194e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1950:      DW    X'FFFF'    ; =0xffff =65535(-1)
1952:      DW    X'FFFF'    ; =0xffff =65535(-1)
1954:      DW    X'FFFF'    ; =0xffff =65535(-1)
1956:      DW    X'FFFF'    ; =0xffff =65535(-1)
1958:      DW    X'FFFF'    ; =0xffff =65535(-1)
195a:      DW    X'FFFF'    ; =0xffff =65535(-1)
195c:      DW    X'FFFF'    ; =0xffff =65535(-1)
195e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1960:      DW    X'FFFF'    ; =0xffff =65535(-1)
1962:      DW    X'FFFF'    ; =0xffff =65535(-1)
1964:      DW    X'FFFF'    ; =0xffff =65535(-1)
1966:      DW    X'FFFF'    ; =0xffff =65535(-1)
1968:      DW    X'FFFF'    ; =0xffff =65535(-1)
196a:      DW    X'FFFF'    ; =0xffff =65535(-1)
196c:      DW    X'FFFF'    ; =0xffff =65535(-1)
196e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1970:      DW    X'FFFF'    ; =0xffff =65535(-1)
1972:      DW    X'FFFF'    ; =0xffff =65535(-1)
1974:      DW    X'FFFF'    ; =0xffff =65535(-1)
1976:      DW    X'FFFF'    ; =0xffff =65535(-1)
1978:      DW    X'FFFF'    ; =0xffff =65535(-1)
197a:      DW    X'FFFF'    ; =0xffff =65535(-1)
197c:      DW    X'FFFF'    ; =0xffff =65535(-1)
197e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1980:      DW    X'FFFF'    ; =0xffff =65535(-1)
1982:      DW    X'FFFF'    ; =0xffff =65535(-1)
1984:      DW    X'FFFF'    ; =0xffff =65535(-1)
1986:      DW    X'FFFF'    ; =0xffff =65535(-1)
1988:      DW    X'FFFF'    ; =0xffff =65535(-1)
198a:      DW    X'FFFF'    ; =0xffff =65535(-1)
198c:      DW    X'FFFF'    ; =0xffff =65535(-1)
198e:      DW    X'FFFF'    ; =0xffff =65535(-1)
1990:      DW    X'FFFF'    ; =0xffff =65535(-1)
1992:      DW    X'FFFF'    ; =0xffff =65535(-1)
1994:      DW    X'FFFF'    ; =0xffff =65535(-1)
1996:      DW    X'FFFF'    ; =0xffff =65535(-1)
1998:      DW    X'FFFF'    ; =0xffff =65535(-1)
199a:      DW    X'FFFF'    ; =0xffff =65535(-1)
199c:      DW    X'FFFF'    ; =0xffff =65535(-1)
199e:      DW    X'FFFF'    ; =0xffff =65535(-1)
19a0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19a2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19a4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19a6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19a8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19aa:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ac:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ae:      DW    X'FFFF'    ; =0xffff =65535(-1)
19b0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19b2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19b4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19b6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19b8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ba:      DW    X'FFFF'    ; =0xffff =65535(-1)
19bc:      DW    X'FFFF'    ; =0xffff =65535(-1)
19be:      DW    X'FFFF'    ; =0xffff =65535(-1)
19c0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19c2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19c4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19c6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19c8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ca:      DW    X'FFFF'    ; =0xffff =65535(-1)
19cc:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ce:      DW    X'FFFF'    ; =0xffff =65535(-1)
19d0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19d2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19d4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19d6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19d8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19da:      DW    X'FFFF'    ; =0xffff =65535(-1)
19dc:      DW    X'FFFF'    ; =0xffff =65535(-1)
19de:      DW    X'FFFF'    ; =0xffff =65535(-1)
19e0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19e2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19e4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19e6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19e8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ea:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ec:      DW    X'FFFF'    ; =0xffff =65535(-1)
19ee:      DW    X'FFFF'    ; =0xffff =65535(-1)
19f0:      DW    X'FFFF'    ; =0xffff =65535(-1)
19f2:      DW    X'FFFF'    ; =0xffff =65535(-1)
19f4:      DW    X'FFFF'    ; =0xffff =65535(-1)
19f6:      DW    X'FFFF'    ; =0xffff =65535(-1)
19f8:      DW    X'FFFF'    ; =0xffff =65535(-1)
19fa:      DW    X'FFFF'    ; =0xffff =65535(-1)
19fc:      DW    X'FFFF'    ; =0xffff =65535(-1)
19fe:      DW    X'FFFF'    ; =0xffff =65535(-1)
1a00:ENDPT
