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
0103:ENTRY CLA              ; [Clear A]
0104:      STA/  X'000C'    ; =0x000c =12 [Store A direct]
0107:      STA/  X'002C'    ; =0x002c =44 [Store A direct]
010a:      STA/  X'006C'    ; =0x006c =108 [Store A direct]
010d:      STA/  X'00AC'    ; =0x00ac =172 =NUL,',' [Store A direct]
0110:      STA/  X'00FC'    ; =0x00fc =252 =NUL,'|' [Store A direct]
0113:      LDAB= X'55'      ; =85 [Load AL with immediate]
0115:P0115 STAB/ X'FFF1'    ; =0xfff1 =65521(-15) [Store AL direct]
0118:      LDBB* P0115+1    ; =-4 [Load BL relative indirect]
011a:      SABB             ; [AL - BL -> BL]
011b:      STBB/ X'039D'    ; =0x039d =925 [Store BL direct]
011e:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
0121:      XAS              ; [Transfer A to S]
0122:      LDAB= X'F1'      ; =241(-15) ='q' [Load AL with immediate]
0124:      JSR   F0140      ; =+26 [Jump to subroutine relative]
0126:      LDAB= X'F5'      ; =245(-11) ='u' [Load AL with immediate]
0128:      JSR   F0140      ; =+22 [Jump to subroutine relative]
012a:      LDAB= X'F9'      ; =249(-7) ='y' [Load AL with immediate]
012c:      JSR   F0140      ; =+18 [Jump to subroutine relative]
012e:      LDAB= X'FD'      ; =253(-3) ='}' [Load AL with immediate]
0130:      JSR   F0140      ; =+14 [Jump to subroutine relative]
0132:      BS1   D0136      ; =+2 [Branch if Sense Switch 1 set]
0134:      JMP   D016E      ; =+56 [Jump relative]
0136:D0136 LDX/  X'001A'    ; =0x001a =26 [Load X direct]
0139:      LDA=  X'FFEC'    ; =0xffec =65516(-20) [Load A with immediate]
013c:      ADD   A,X        ; [A + X -> X]
013e:      JMP   D0184      ; =+68 [Jump relative]
*
* Function F0140
*
0140:F0140 STAB  B014A+1    ; =+9 [Store AL relative]
0142:      STAB  B0150+1    ; =+13 [Store AL relative]
0144:      STAB  B015B+1    ; =+22 [Store AL relative]
0146:      STAB  B0161+1    ; =+26 [Store AL relative]
0148:      LDAB= X'07'      ; =7 [Load AL with immediate]
014a:B014A STAB/ X'F140'    ; =0xf140 =61760(-3776) [Store AL direct]
014d:      LDB=  X'3000'    ; =0x3000 =12288 [Load B with immediate]
0150:B0150 LDBB/ X'F145'    ; =0xf145 =61765(-3771) [Load BL direct]
0153:      ANDB  BU,BL      ; [BU & BL -> BL]
0155:      SUBB  BU,BL      ; [BU - BL -> BL]
0157:      BNZ   D016A      ; =+17 [Branch if not zero]
0159:      LDBB= X'03'      ; =3 [Load BL with immediate]
015b:B015B STBB/ X'F148'    ; =0xf148 =61768(-3768) [Store BL direct]
015e:      LDB=  X'3000'    ; =0x3000 =12288 [Load B with immediate]
0161:B0161 LDBB/ X'F145'    ; =0xf145 =61765(-3771) [Load BL direct]
0164:      ANDB  BU,BL      ; [BU & BL -> BL]
0166:      SUBB  BU,BL      ; [BU - BL -> BL]
0168:      BNZ   B0161      ; =-9 [Branch if not zero]
016a:D016A DCAB             ; [Decrement AL]
016b:      BP    B014A      ; =-35 [Branch on plus]
016d:      RSR              ; [Return from subroutine]
*
016e:D016E LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
0171:      XAX              ; [Transfer A to X]
0172:      XAY              ; [Transfer A to Y]
0173:D0173 LDAB+ X          ; [Load AL from address in X]
0174:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
0176:      STBB+ X          ; [Store BL to address in X]
0177:      LDBB+ X          ; [Load BL from address in X]
0178:      BZ    D0184      ; =+10 [Branch if zero]
017a:      STAB+ X          ; [Store AL to address in X]
017b:      ADD   Y,X        ; [Y + X -> X]
017d:      LDA=  X'E000'    ; =0xe000 =57344(-8192) ='`',NUL [Load A with immediate]
0180:      SUB   X,A        ; [X - A -> A]
0182:      BNZ   D0173      ; =-17 [Branch if not zero]
0184:D0184 STX/  X'02B0'    ; =0x02b0 =688 [Store X direct]
0187:      XFR   X,A        ; [Transfer X to A]
0189:      LDB=  X'FD7A'    ; =0xfd7a =64890(-646) [Load B with immediate]
018c:      AAB              ; [A + B -> B]
018d:      STB/  X'0376'    ; =0x0376 =886 [Store B direct]
0190:      LDB=  X'FF0A'    ; =0xff0a =65290(-246) [Load B with immediate]
0193:      AAB              ; [A + B -> B]
0194:      STB/  X'0228'    ; =0x0228 =552 [Store B direct]
0197:      EI               ; [Enable interrupt system]
0198:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
019b:      XAS              ; [Transfer A to S]
019c:      LDAB= X'BD'      ; =189(-67) ='=' [Load AL with immediate]
019e:      STAB/ X'04DB'    ; =0x04db =1243 [Store AL direct]
01a1:      LDA=  X'0197'    ; =0x0197 =407 [Load A with immediate]
01a4:      STA/  X'04C5'    ; =0x04c5 =1221 [Store A direct]
01a7:      LDAB= X'B1'      ; =177(-79) ='1' [Load AL with immediate]
01a9:      BS4   D01AC      ; =+1 [Branch if Sense Switch 4 set]
01ab:      DCAB             ; [Decrement AL]
01ac:D01AC STAB/ X'02EE'    ; =0x02ee =750 [Store AL direct]
01af:      BS2   D01D8      ; =+39 [Branch if Sense Switch 2 set]
01b1:      LDB=  X'02CD'    ; =0x02cd =717 [Load B with immediate]
01b4:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
01b6:      STB   D0231+1    ; =+122 [Store B relative]
01b8:      JSR/  X'055A'    ; =0x055a =1370 [Jump to subroutine direct]
01bb:      DC    ' '        ; hex:a0 dec:160(-96)
01bc:      JSR/  X'043A'    ; =0x043a =1082 [Jump to subroutine direct]
01bf:      JSR/  X'0414'    ; =0x0414 =1044 [Jump to subroutine direct]
01c2:      DB    X'02'      ; =0x02 =2
01c3:      DC    '5'        ; hex:b5 dec:181(-75)
01c4:      JSR/  X'0414'    ; =0x0414 =1044 [Jump to subroutine direct]
01c7:      DB    X'02'      ; =0x02 =2
01c8:      DC    'A'        ; hex:c1 dec:193(-63)
01c9:      JSR/  X'04CC'    ; =0x04cc =1228 [Jump to subroutine direct]
01cc:      DB    X'02'      ; =0x02 =2
01cd:      DC    'M'        ; hex:cd dec:205(-51)
01ce:      JSR/  X'0414'    ; =0x0414 =1044 [Jump to subroutine direct]
01d1:      DB    X'02'      ; =0x02 =2
01d2:      DC    'G'        ; hex:c7 dec:199(-57)
01d3:      JSR/  X'04CC'    ; =0x04cc =1228 [Jump to subroutine direct]
01d6:      DB    X'02'      ; =0x02 =2
01d7:      DC    'k'        ; hex:eb dec:235(-21)
*
01d8:D01D8 DI               ; [Disable interrupt system]
01d9:      JSR/  X'0538'    ; =0x0538 =1336 [Jump to subroutine direct]
01dc:      DB    X'02'      ; =0x02 =2
01dd:      DC    'M'        ; hex:cd dec:205(-51)
01de:      LDA=  X'02EB'    ; =0x02eb =747 [Load A with immediate]
01e1:      XAZ              ; [Transfer A to Z]
01e2:      LDB+  Z+         ; [Load B indexed, direct, post-incremented]
01e4:      DCR   B          ; [Decrement B by 1]
01e6:      BZ    D01F8      ; =+16 [Branch if zero]
01e8:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
01ea:      LDBB+ Z,1        ; [Load BL indexed, displaced, direct]
01ed:      SABB             ; [AL - BL -> BL]
01ee:      BZ    D01F8      ; =+8 [Branch if zero]
01f0:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
01f2:      SABB             ; [AL - BL -> BL]
01f3:      BZ    D01F8      ; =+3 [Branch if zero]
01f5:      LDAB= X'F0'      ; =240(-16) ='p' [Load AL with immediate]
01f7:      SABB             ; [AL - BL -> BL]
01f8:D01F8 STBB/ X'0382'    ; =0x0382 =898 [Store BL direct]
01fb:      XFRB  BL,AL      ; [Transfer BL to AL]
01fd:      SLAB             ; [Left shift AL]
01fe:      SLAB             ; [Left shift AL]
01ff:      LDB=  X'F140'    ; =0xf140 =61760(-3776) [Load B with immediate]
0202:      ORIB  AL,BU      ; [AL | BU -> BU]
0204:      STB/  X'0399'    ; =0x0399 =921 [Store B direct]
0207:      SLAB             ; [Left shift AL]
0208:      SLAB             ; [Left shift AL]
0209:      LDBB= X'04'      ; =4 [Load BL with immediate]
020b:      AABB             ; [AL + BL -> BL]
020c:      STBB/ X'0394'    ; =0x0394 =916 [Store BL direct]
020f:      LDAB+ Z          ; [Load AL from address in Z]
0210:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
0212:      SABB             ; [AL - BL -> BL]
0213:      BM    D022E      ; =+25 [Branch on minus]
0215:      LDAB= X'07'      ; =7 [Load AL with immediate]
0217:      SUBB  BL,AL      ; [BL - AL -> AL]
0219:      BGZ   D022E      ; =+19 [Branch if greater than zero]
021b:      STBB$ X'0399'    ; =0x0399 =921 [Store BL indirect]
021e:      LDA=  X'0014'    ; =0x0014 =20 [Load A with immediate]
0221:      STA   W0260+1    ; =+62 [Store A relative]
0223:      JSR/  F03E5      ; =0x03e5 =997 [Jump to subroutine direct]
0226:      DB    X'00'      ; =0x00 =0 =NUL
0227:      DC    'v'        ; hex:f6 dec:246(-10)
0228:      DB    X'00'      ; =0x00 =0 =NUL
0229:      DB    X'00'      ; =0x00 =0 =NUL
022a:      DB    X'02'      ; =0x02 =2
022b:      DC    'o'        ; hex:ef dec:239(-17)
022c:      JMP   W0260      ; =+50 [Jump relative]
022e:D022E JMP/  X'0197'    ; =0x0197 =407 [Jump direct]
0231:D0231 LDA=  X'02CF'    ; =0x02cf =719 [Load A with immediate]
0234:      XAY              ; [Transfer A to Y]
0235:      LDA=  X'0600'    ; =0x0600 =1536 [Load A with immediate]
0238:D0238 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
023a:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
023c:      SABB             ; [AL - BL -> BL]
023d:      BNZ   D0249      ; =+10 [Branch if not zero]
023f:      XFRB  AU,AU      ; [Transfer AU to AU]
0241:      BZ    D027D      ; =+58 [Branch if zero]
0243:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
0245:      LDBB+ Z          ; [Load BL from address in Z]
0246:      SABB             ; [AL - BL -> BL]
0247:      BZ    D027D      ; =+52 [Branch if zero]
0249:D0249 DCRB  AU         ; [Decrement AU by 1]
024b:      BM    D029A      ; =+77 [Branch on minus]
024d:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
024f:      SABB             ; [AL - BL -> BL]
0250:      BZ    D0238      ; =-26 [Branch if zero]
0252:      XFRB  AU,AL      ; [Transfer AU to AL]
0254:      CLRB  AU         ; [Clear AU]
0256:      ADD   A,Z        ; [A + Z -> Z]
0258:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
025b:      ADD   A,Z        ; [A + Z -> Z]
025d:      DCX              ; [Decrement X]
025e:      BGZ   D0231      ; =-47 [Branch if greater than zero]
0260:W0260 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
0263:      BM    D022E      ; =-55 [Branch on minus]
0265:      LDA=  X'FFB3'    ; =0xffb3 =65459(-77) [Load A with immediate]
0268:      JSR   F02AF      ; =+69 [Jump to subroutine relative]
026a:      LDA+  Z,1        ; [Load A indexed, displaced, direct]
026d:      STA   W0260+1    ; =-14 [Store A relative]
026f:      CLA              ; [Clear A]
0270:      LDAB+ Z,5        ; [Load AL indexed, displaced, direct]
0273:      BM    D022E      ; =-71 [Branch on minus]
0275:      XAX              ; [Transfer A to X]
0276:      LDA=  X'0010'    ; =0x0010 =16 [Load A with immediate]
0279:      ADD   A,Z        ; [A + Z -> Z]
027b:      JMP   D0231      ; =-76 [Jump relative]
027d:D027D XFRB  AU,AL      ; [Transfer AU to AL]
027f:      CLRB  AU         ; [Clear AU]
0281:      ADD   A,Z        ; [A + Z -> Z]
0283:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0285:      SRAB             ; [Right shift AL]
0286:      SRAB             ; [Right shift AL]
0287:      SRAB             ; [Right shift AL]
0288:      LDBB= X'03'      ; =3 [Load BL with immediate]
028a:      NABB             ; [AL & BL -> BL]
028b:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
028d:      SABB             ; [AL - BL -> BL]
028e:      BNZ   D022E      ; =-98 [Branch if not zero]
0290:      XFR   Y,A        ; [Transfer Y to A]
0292:      STA   D0231+1    ; =-98 [Store A relative]
0294:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
0296:      STA   W0260+1    ; =-55 [Store A relative]
0298:      JMP   W0260      ; =-58 [Jump relative]
029a:D029A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
029c:      SRAB             ; [Right shift AL]
029d:      SRAB             ; [Right shift AL]
029e:      SRAB             ; [Right shift AL]
029f:      LDBB= X'03'      ; =3 [Load BL with immediate]
02a1:      ANDB  BL,AL      ; [BL & AL -> AL]
02a3:      LDBB= X'01'      ; =1 [Load BL with immediate]
02a5:      SABB             ; [AL - BL -> BL]
02a6:      BNZ   D022E      ; =-122 [Branch if not zero]
02a8:      LDX+  Z+         ; [Load X indexed, direct, post-incremented]
02aa:      LDA=  X'FF0A'    ; =0xff0a =65290(-246) [Load A with immediate]
02ad:      JSR   F02AF      ; =+0 [Jump to subroutine relative]
*
* Function F02AF
*
02af:F02AF LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
02b2:      AAB              ; [A + B -> B]
02b3:      JMP+  B          ; [Jump indexed, direct]
*
02b5:      DB    X'00'      ; =0x00 =0 =NUL
02b6:      DW    X'0A8C'    ; =0x0a8c =2700
02b8:      DC    'HDIPL 5.8' ; hex:c8c4c9d0cca0b5aeb8
02c1:      DB    X'00'      ; =0x00 =0 =NUL
02c2:      DB    X'04'      ; =0x04 =4
02c3:      DC    'NAME'     ; hex:cec1cdc5
02c7:      DB    X'00'      ; =0x00 =0 =NUL
02c8:      DB    X'04'      ; =0x04 =4
02c9:      DC    'DISK'     ; hex:c4c9d3cb
02cd:      DB    X'00'      ; =0x00 =0 =NUL
02ce:      DB    X'1C'      ; =0x1c =28
02cf:      DC    '@OSN                        '
02eb:      DB    X'00'      ; =0x00 =0 =NUL
02ec:      DB    X'02'      ; =0x02 =2
02ed:      DC    '00'       ; hex:b0b0 dec:45232(-80)
*
02ef:      LDA+  S          ; [Load A from address in S]
02f0:      STA   W035F+1    ; =+110 [Store A relative]
02f2:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
02f5:      STA   W0354+1    ; =+94 [Store A relative]
02f7:      LDA   W0375+1    ; =+125 [Load A relative]
02f9:      XAS              ; [Transfer A to S]
02fa:      JSR   F035D      ; =+97 [Jump to subroutine relative]
02fc:      LDB=  X'004C'    ; =0x004c =76 [Load B with immediate]
02ff:      SAB              ; [A - B -> B]
0300:      BNZ   D0326      ; =+36 [Branch if not zero]
0302:      LDA+  Z,27       ; [Load A indexed, displaced, direct]
0305:      STA   W0354+1    ; =+78 [Store A relative]
0307:      ADD   X,Z        ; [X + Z -> Z]
0309:      INR   Z          ; [Increment Z by 1]
030b:      JSR   D034C      ; =+63 [Jump to subroutine relative]
030d:      INR   Z          ; [Increment Z by 1]
030f:D030F JSR   D034C      ; =+59 [Jump to subroutine relative]
0311:      XFRB  BL,BL      ; [Transfer BL to BL]
0313:      BZ    D0326      ; =+17 [Branch if zero]
0315:D0315 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
0317:      LDA   W0354+1    ; =+60 [Load A relative]
0319:      AAB              ; [A + B -> B]
031a:      LDA+  B          ; [Load A from address in B]
031b:      ADD   Y,A        ; [Y + A -> A]
031d:      STA+  B          ; [Store A to address in B]
031e:      DCX              ; [Decrement X]
031f:      DCX              ; [Decrement X]
0320:      BGZ   D0315      ; =-13 [Branch if greater than zero]
0322:D0322 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0324:      JMP   D030F      ; =-23 [Jump relative]
0326:D0326 XFR   X,X        ; [Transfer X to X]
0328:      BZ    D0333      ; =+9 [Branch if zero]
032a:D032A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
032c:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
032e:      DCX              ; [Decrement X]
032f:      BGZ   D032A      ; =-7 [Branch if greater than zero]
0331:      JMP   D0322      ; =-17 [Jump relative]
0333:D0333 BS1   D0337      ; =+2 [Branch if Sense Switch 1 set]
0335:D0335 JMP+  Y          ; [Jump indexed, direct]
0337:D0337 LDAB$ X'001A'    ; =0x001a =26 [Load AL indirect]
033a:      LDBB= X'73'      ; =115 [Load BL with immediate]
033c:      SABB             ; [AL - BL -> BL]
033d:      BNZ   D0335      ; =-10 [Branch if not zero]
033f:      LDA/  X'001A'    ; =0x001a =26 [Load A direct]
0342:      INA              ; [Increment A]
0343:      INA              ; [Increment A]
0344:      XFR   Y,B        ; [Transfer Y to B]
0346:      STB+  A+         ; [Store B indexed, direct, post-incremented]
0348:      INA              ; [Increment A]
0349:      INA              ; [Increment A]
034a:      JMP+  A          ; [Jump indexed, direct]
034c:D034C LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
034e:      BM    F035D      ; =+13 [Branch on minus]
0350:      CLA              ; [Clear A]
0351:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
0353:      STA+  S          ; [Store A to address in S]
0354:W0354 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
0357:      XAY              ; [Transfer A to Y]
0358:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
035a:      ADD   A,Y        ; [A + Y -> Y]
035c:      RSR              ; [Return from subroutine]
*
* Function F035D
*
035d:F035D STX-  S-         ; [Store X indexed, pre-decremented, direct]
035f:W035F LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
0362:      BM    D0372      ; =+14 [Branch on minus]
0364:      JSR   F0398      ; =+50 [Jump to subroutine relative]
0366:      INR   Z          ; [Increment Z by 1]
0368:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
036a:      STA   W035F+1    ; =-12 [Store A relative]
036c:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
036e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0370:      JMP   D034C      ; =-38 [Jump relative]
0372:D0372 HLT              ; [Halt]
0373:      JMP   D0372      ; =-3 [Jump relative]
0375:W0375 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
0378:      STA/  X'FFF0'    ; =0xfff0 =65520(-16) [Store A direct]
037b:      LDA=  X'FE6F'    ; =0xfe6f =65135(-401) [Load A with immediate]
037e:      STA/  X'FFF2'    ; =0xfff2 =65522(-14) [Store A direct]
0381:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
0383:      STAB/ X'FFF4'    ; =0xfff4 =65524(-12) [Store AL direct]
0386:      STAB/ X'FFF7'    ; =0xfff7 =65527(-9) [Store AL direct]
0389:      RSR              ; [Return from subroutine]
*
* Function F038A
*
038a:F038A LDA   W0375+1    ; =-22 [Load A relative]
038c:      DMA   SAD,A      ; [Store A register to DMA address register]
038e:      LDA=  X'FE6F'    ; =0xfe6f =65135(-401) [Load A with immediate]
0391:      DMA   SCT,A      ; [Store A register to DMA count register]
0393:      DMA   SDV,0      ; [Set DMA mode]
0395:      DMA   EAB        ; [Enable DMA]
0397:      RSR              ; [Return from subroutine]
*
* Function F0398
*
0398:F0398 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
039b:      XAZ              ; [Transfer A to Z]
039c:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
039e:      BZ    D03A4      ; =+4 [Branch if zero]
03a0:      JSR   F038A      ; =-24 [Jump to subroutine relative]
03a2:      JMP   D03A6      ; =+2 [Jump relative]
03a4:D03A4 JSR   W0375      ; =-49 [Jump to subroutine relative]
03a6:D03A6 JSR   F03C4      ; =+28 [Jump to subroutine relative]
03a8:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
03aa:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
03ad:      JSR   D03D4      ; =+37 [Jump to subroutine relative]
03af:      SRRB  AU         ; [Right shift AU by 1]
03b1:      BNZ   D03B7      ; =+4 [Branch if not zero]
03b3:      LDA   W0375+1    ; =-63 [Load A relative]
03b5:      XAZ              ; [Transfer A to Z]
03b6:      RSR              ; [Return from subroutine]
*
03b7:D03B7 LDAB= X'03'      ; =3 [Load AL with immediate]
03b9:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
03bc:      JSR   D03DA      ; =+28 [Jump to subroutine relative]
03be:      LDAB+ Z          ; [Load AL from address in Z]
03bf:      STAB+ Z,11       ; [Store AL indexed, displaced, direct]
03c2:      JMP   F0398      ; =-44 [Jump relative]
*
* Function F03C4
*
03c4:F03C4 JSR   D03DA      ; =+20 [Jump to subroutine relative]
03c6:      LDB+  S,2        ; [Load B indexed, displaced, direct]
03c9:      STB+  Z,1        ; [Store B indexed, displaced, direct]
03cc:      LDAB= X'02'      ; =2 [Load AL with immediate]
03ce:      STAB+ Z,8        ; [Store AL indexed, displaced, direct]
03d1:      JSR   D03DA      ; =+7 [Jump to subroutine relative]
03d3:      RSR              ; [Return from subroutine]
*
03d4:D03D4 LDAB+ Z,4        ; [Load AL indexed, displaced, direct]
03d7:      SRAB             ; [Right shift AL]
03d8:      BL    D03D4      ; =-6 [Branch on link]
03da:D03DA LDA+  Z,4        ; [Load A indexed, displaced, direct]
03dd:      LDBB= X'30'      ; =48 [Load BL with immediate]
03df:      ANDB  BL,AL      ; [BL & AL -> AL]
03e1:      SABB             ; [AL - BL -> BL]
03e2:      BNZ   D03DA      ; =-10 [Branch if not zero]
03e4:      RSR              ; [Return from subroutine]
*
* Function F03E5
*
03e5:F03E5 LDA+  X+         ; [Load A indexed, direct, post-incremented]
03e7:      XAB              ; [Transfer A to B]
03e8:      JMP/  X'03EB'    ; =0x03eb =1003 [Jump direct]
03eb:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
03ed:      SAB              ; [A - B -> B]
03ee:      BLE   D0411      ; =+33 [Branch if less than or equal to zero]
03f0:      LDB+  X          ; [Load B from address in X]
03f1:      JSR/  F055A      ; =0x055a =1370 [Jump to subroutine direct]
03f4:      DC    ' '        ; hex:a0 dec:160(-96)
*
03f5:D03F5 LDB+  S          ; [Load B from address in S]
03f6:      XFR   Y,A        ; [Transfer Y to A]
03f8:      STA+  S          ; [Store A to address in S]
03f9:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
03fb:      XAY              ; [Transfer A to Y]
03fc:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
03fe:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0400:      XFR   B,X        ; [Transfer B to X]
0402:D0402 DCX              ; [Decrement X]
0403:      BP    D040B      ; =+6 [Branch on plus]
0405:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0407:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
0409:      XAY              ; [Transfer A to Y]
040a:      RSR              ; [Return from subroutine]
*
040b:D040B LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
040d:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
040f:      JMP   D0402      ; =-15 [Jump relative]
0411:D0411 STA+  S          ; [Store A to address in S]
0412:      JMP   D03F5      ; =-31 [Jump relative]
0414:      JSR   F043A      ; =+36 [Jump to subroutine relative]
0416:      XFR   Y,A        ; [Transfer Y to A]
0418:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
041a:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
041c:      XAY              ; [Transfer A to Y]
041d:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
041f:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
0421:      BLE   D0434      ; =+17 [Branch if less than or equal to zero]
0423:D0423 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
0425:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
0427:      SABB             ; [AL - BL -> BL]
0428:      BM    D042F      ; =+5 [Branch on minus]
042a:      LDBB= X'20'      ; =32 [Load BL with immediate]
042c:      SABB             ; [AL - BL -> BL]
042d:      XFRB  BL,AL      ; [Transfer BL to AL]
042f:D042F JSR   F0444      ; =+19 [Jump to subroutine relative]
0431:      DCX              ; [Decrement X]
0432:      BGZ   D0423      ; =-17 [Branch if greater than zero]
0434:D0434 LDX+  S+         ; [Load X indexed, direct, post-incremented]
0436:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
0438:      XAY              ; [Transfer A to Y]
0439:      RSR              ; [Return from subroutine]
*
* Function F043A
*
043a:F043A LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
043c:      LDBB  B0472+1    ; =+53 [Load BL relative]
043e:      SABB             ; [AL - BL -> BL]
043f:      BZ    D0443      ; =+2 [Branch if zero]
0441:      JSR   F0444      ; =+1 [Jump to subroutine relative]
0443:D0443 RSR              ; [Return from subroutine]
*
* Function F0444
*
0444:F0444 STAB/ X'F20D'    ; =0xf20d =61965(-3571) [Store AL direct]
0447:      LDBB= X'C5'      ; =197(-59) ='E' [Load BL with immediate]
0449:      STBB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Store BL direct]
044c:      LDBB= X'8C'      ; =140(-116) =FF [Load BL with immediate]
044e:      SABB             ; [AL - BL -> BL]
044f:      BZ    D0462      ; =+17 [Branch if zero]
0451:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
0453:      SABB             ; [AL - BL -> BL]
0454:      BNZ   D0466      ; =+16 [Branch if not zero]
0456:      JSR   D0466      ; =+14 [Jump to subroutine relative]
0458:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
045a:      JSR   D0466      ; =+10 [Jump to subroutine relative]
045c:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
045e:      STAB  B0472+1    ; =+19 [Store AL relative]
0460:      DLY              ; [Delay 4.55 ms]
0461:      RSR              ; [Return from subroutine]
*
0462:D0462 JSR   D0466      ; =+2 [Jump to subroutine relative]
0464:      DLY              ; [Delay 4.55 ms]
0465:      RSR              ; [Return from subroutine]
*
0466:D0466 LDBB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load BL direct]
0469:      SRRB  BL         ; [Right shift BL by 1]
046b:      SRRB  BL         ; [Right shift BL by 1]
046d:      BNL   D0466      ; =-9 [Branch on no link]
046f:      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
0472:B0472 STAB= X'00'      ; =0 =NUL [Store AL immediate]
0474:      RSR              ; [Return from subroutine]
*
0475:D0475 LDBB/ X'F20F'    ; =0xf20f =61967(-3569) [Load BL direct]
0478:      RI               ; [Return from interrupt]
*
0479:      LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
047c:      SRAB             ; [Right shift AL]
047d:      BL    D048E      ; =+15 [Branch on link]
047f:      LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
0482:      LDAB/ X'F203'    ; =0xf203 =61955(-3581) [Load AL direct]
0485:      LDAB/ X'F205'    ; =0xf205 =61957(-3579) [Load AL direct]
0488:      LDAB/ X'F207'    ; =0xf207 =61959(-3577) [Load AL direct]
048b:      CLAB             ; [Clear AL]
048c:      JMP   D0475      ; =-25 [Jump relative]
048e:D048E LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
0491:      JMP   D0475      ; =-30 [Jump relative]
*
* Function F0493
*
0493:F0493 LDAB= X'C5'      ; =197(-59) ='E' [Load AL with immediate]
0495:      STAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Store AL direct]
0498:      LDA=  X'0479'    ; =0x0479 =1145 [Load A with immediate]
049b:      STA/  X'006E'    ; =0x006e =110 [Store A direct]
049e:      CLAB             ; [Clear AL]
049f:      STAB/ X'0061'    ; =0x0061 =97 [Store AL direct]
04a2:      LDAB= X'06'      ; =6 [Load AL with immediate]
04a4:      STAB/ X'F20A'    ; =0xf20a =61962(-3574) [Store AL direct]
04a7:      STAB/ X'F20E'    ; =0xf20e =61966(-3570) [Store AL direct]
04aa:D04AA LDAB/ X'0061'    ; =0x0061 =97 [Load AL direct]
04ad:      BZ    D04AA      ; =-5 [Branch if zero]
04af:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
04b1:      ORIB  BL,AL      ; [BL | AL -> AL]
04b3:      JSR   F0444      ; =-113 [Jump to subroutine relative]
04b5:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
04b7:      SABB             ; [AL - BL -> BL]
04b8:      BM    D04BF      ; =+5 [Branch on minus]
04ba:      LDBB= X'20'      ; =32 [Load BL with immediate]
04bc:      SABB             ; [AL - BL -> BL]
04bd:      XFRB  BL,AL      ; [Transfer BL to AL]
04bf:D04BF LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
04c1:      SABB             ; [AL - BL -> BL]
04c2:      BNZ   D04CB      ; =+7 [Branch if not zero]
04c4:W04C4 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
04c7:      BZ    D04CB      ; =+2 [Branch if zero]
04c9:      XFR   B,X        ; [Transfer B to X]
04cb:D04CB RSR              ; [Return from subroutine]
*
04cc:      LDA   W04C4+1    ; =-9 [Load A relative]
04ce:      STA   W0529+1    ; =+90 [Store A relative]
04d0:      LDA=  X'052F'    ; =0x052f =1327 [Load A with immediate]
04d3:      STA   W04C4+1    ; =-16 [Store A relative]
04d5:      LDA+  X          ; [Load A from address in X]
04d6:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
04d8:      INA              ; [Increment A]
04d9:      XAX              ; [Transfer A to X]
04da:      LDAB= X'AF'      ; =175(-81) ='/' [Load AL with immediate]
04dc:      JSR/  F0444      ; =0x0444 =1092 [Jump to subroutine direct]
04df:D04DF JSR   F0493      ; =-78 [Jump to subroutine relative]
04e1:      LDBB= X'88'      ; =136(-120) [Load BL with immediate]
04e3:      SABB             ; [AL - BL -> BL]
04e4:      BZ    D04EB      ; =+5 [Branch if zero]
04e6:      LDBB= X'95'      ; =149(-107) [Load BL with immediate]
04e8:      SABB             ; [AL - BL -> BL]
04e9:      BNZ   D0509      ; =+30 [Branch if not zero]
04eb:D04EB LDB+  *S         ; [Load B indexed, indirect]
04ed:      INR   B          ; [Increment B by 1]
04ef:      SUB   X,B        ; [X - B -> B]
04f1:      BZ    D0503      ; =+16 [Branch if zero]
04f3:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
04f5:P04F5 JSR/  F0444      ; =0x0444 =1092 [Jump to subroutine direct]
04f8:      LDAB= X'95'      ; =149(-107) [Load AL with immediate]
04fa:      JSR*  P04F5+1    ; =-6 [Jump to subroutine relative indirect]
04fc:      LDAB= X'88'      ; =136(-120) [Load AL with immediate]
04fe:      JSR*  P04F5+1    ; =-10 [Jump to subroutine relative indirect]
0500:      DCX              ; [Decrement X]
0501:      JMP   D04DF      ; =-36 [Jump relative]
0503:D0503 LDAB= X'86'      ; =134(-122) [Load AL with immediate]
0505:      JSR*  P04F5+1    ; =-17 [Jump to subroutine relative indirect]
0507:      JMP   D04DF      ; =-42 [Jump relative]
0509:D0509 LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
050b:      SABB             ; [AL - BL -> BL]
050c:      BZ    D0520      ; =+18 [Branch if zero]
050e:      STAB  B051B+1    ; =+12 [Store AL relative]
0510:      LDA+  *S         ; [Load A indexed, indirect]
0512:      LDB=  X'0085'    ; =0x0085 =133 [Load B with immediate]
0515:      AAB              ; [A + B -> B]
0516:      SUB   X,B        ; [X - B -> B]
0518:      BP    D0520      ; =+6 [Branch on plus]
051a:      INX              ; [Increment X]
051b:B051B LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
051d:      STAB+ X          ; [Store AL to address in X]
051e:      JMP   D04DF      ; =-65 [Jump relative]
0520:D0520 LDA+  *S         ; [Load A indexed, indirect]
0522:      INA              ; [Increment A]
0523:      SUB   X,A        ; [X - A -> A]
0525:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0527:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
0529:W0529 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
052c:      STB   W04C4+1    ; =-105 [Store B relative]
052e:      RSR              ; [Return from subroutine]
*
052f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0531:      CLA              ; [Clear A]
0532:      STA+  *X+        ; [Store A indexed, indirect, post-incremented]
0534:      LDX   W0529+1    ; =-12 [Load X relative]
0536:      JMP   W0529      ; =-15 [Jump relative]
0538:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
053a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
053c:      XFR   Y,X        ; [Transfer Y to X]
053e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
0540:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
0542:      XAY              ; [Transfer A to Y]
0543:D0543 DCX              ; [Decrement X]
0544:      BM    D0554      ; =+14 [Branch on minus]
0546:      LDAB+ Y          ; [Load AL from address in Y]
0547:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
0549:      SABB             ; [AL - BL -> BL]
054a:      BM    D0550      ; =+4 [Branch on minus]
054c:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
054e:      ADDB  BL,AL      ; [BL + AL -> AL]
0550:D0550 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
0552:      JMP   D0543      ; =-17 [Jump relative]
0554:D0554 LDA+  S+         ; [Load A indexed, direct, post-incremented]
0556:      XAY              ; [Transfer A to Y]
0557:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0559:      RSR              ; [Return from subroutine]
*
* Function F055A
*
055a:F055A STX-  S-         ; [Store X indexed, pre-decremented, direct]
055c:      XAX              ; [Transfer A to X]
055d:      LDAB+ *S         ; [Load AL indexed, indirect]
055f:D055F DCX              ; [Decrement X]
0560:      BP    D0566      ; =+4 [Branch on plus]
0562:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
0564:      INX              ; [Increment X]
0565:      RSR              ; [Return from subroutine]
*
0566:D0566 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
0568:      JMP   D055F      ; =-11 [Jump relative]
*
056a:      DB    0,4470     ; =0x00,0x1176
16e0:      DB    X'7F'      ; =0x7f =127
16e1:      DC    'h'        ; hex:e8 dec:232(-24)
16e2:      DW    X'4321'    ; =0x4321 =17185
16e4:      DB    0,396      ; =0x00,0x018c
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
