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
8000:      DB    0,140      ; =0x00,0x008c
*
* Function ENTRY
*
808c:ENTRY JMP   D80A4      ; =+22 [Jump relative]
808e:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8091:      LDA+  B,3        ; [Load A indexed, displaced, direct]
8094:      STA   W80B0+1    ; =+27 [Store A relative]
8096:      XAY              ; [Transfer A to Y]
8097:      CLA              ; [Clear A]
8098:      STAB/ X'0125'    ; =0x0125 =293 [Store AL direct]
809b:      STA/  W863E      ; =0x863e =34366(-31170) [Store A direct]
809e:      JSR/  W8807      ; =0x8807 =34823(-30713) [Jump to subroutine direct]
80a1:      JMP/  F82EA      ; =0x82ea =33514(-32022) [Jump direct]
80a4:D80A4 XFR=  ENTRY,S    ; =0x808c =32908(-32628) [Transfer immediate to S]
80a8:      SVC   X'0D'      ; =13 [Service call JXM - protected change to JX map]
80aa:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
80ad:      LDA+  B,3        ; [Load A indexed, displaced, direct]
80b0:W80B0 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
80b3:      XAY              ; [Transfer A to Y]
80b4:      JSR/  W8807      ; =0x8807 =34823(-30713) [Jump to subroutine direct]
80b7:      LDAB+ Y          ; [Load AL from address in Y]
80b8:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
80ba:      NABB             ; [AL & BL -> BL]
80bb:      BZ    D80C7      ; =+10 [Branch if zero]
80bd:      MVF   (40)/W87DF,/W863E ; =0x87df =34783(-30753) =BEL,DEL,=0x863e =34366(-31170) [Move fixed-length, direct, direct]
80c4:      JMP/  D8525      ; =0x8525 =34085(-31451) [Jump direct]
80c7:D80C7 LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
80ca:      LDBB= X'08'      ; =8 [Load BL with immediate]
80cc:      NABB             ; [AL & BL -> BL]
80cd:      BZ    D80D4      ; =+5 [Branch if zero]
80cf:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
80d2:      DW    X'000F'    ; =0x000f =15
*
80d4:D80D4 LDBB+ Y,19       ; [Load BL indexed, displaced, direct]
80d7:      BZ    D80DE      ; =+5 [Branch if zero]
80d9:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
80dc:      DW    X'0008'    ; =0x0008 =8
*
80de:D80DE LDBB= X'10'      ; =16 [Load BL with immediate]
80e0:      NABB             ; [AL & BL -> BL]
80e1:      BZ    D80E8      ; =+5 [Branch if zero]
80e3:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
80e6:      DW    X'0009'    ; =0x0009 =9
*
80e8:D80E8 LDBB= X'04'      ; =4 [Load BL with immediate]
80ea:      NABB             ; [AL & BL -> BL]
80eb:      BNZ   D80FB      ; =+14 [Branch if not zero]
80ed:      LDBB= X'40'      ; =64 [Load BL with immediate]
80ef:      NABB             ; [AL & BL -> BL]
80f0:      BZ    D80FB      ; =+9 [Branch if zero]
80f2:      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
80f4:      NABB             ; [AL & BL -> BL]
80f5:      STBB+ Y,18       ; [Store BL indexed, displaced, direct]
80f8:      JMP/  J8178      ; =0x8178 =33144(-32392) [Jump direct]
80fb:D80FB LDBB= X'02'      ; =2 [Load BL with immediate]
80fd:      NABB             ; [AL & BL -> BL]
80fe:      BZ    D8148      ; =+72 [Branch if zero]
8100:      LDBB= X'FD'      ; =253(-3) ='}' [Load BL with immediate]
8102:      NABB             ; [AL & BL -> BL]
8103:      STBB+ Y,18       ; [Store BL indexed, displaced, direct]
8106:      FIL   (12)=' ',/S862C ; =0x862c =34348(-31188) [Fill with byte, literal=0xa0(160,-96), direct]
810c:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
810f:      MVF   (6)-A,7,/S862C ; =0x862c =34348(-31188) [Move fixed-length, displaced indexed, direct]
8116:      MVV   (12,160)/S862C,/S862C ; =0x862c =34348(-31188),=0x862c =34348(-31188) [Move variable-length, direct, direct]
811e:      MVF   (5)/S8639,-Y,1 ; =0x8639 =34361(-31175), [Move fixed-length, direct, displaced indexed]
8125:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8128:      DW    W862A      ; =0x862a =34346(-31190)
812a:      XFR/  W80B0+1,Y  ; =0x80b1 =32945(-32591) [Transfer direct to Y]
812e:      LDA+  Y,52       ; [Load A indexed, displaced, direct]
8131:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8133:      SUB=  X'003C',A  ; =0x003c =60 [60 - A -> A]
8137:      BNL   D813D      ; =+4 [Branch on no link]
8139:      LDA=  X'003C'    ; =0x003c =60 [Load A with immediate]
813c:      STA+  S          ; [Store A to address in S]
813d:D813D LDA+  S+         ; [Load A indexed, direct, post-incremented]
813f:      STA+  Y,50       ; [Store A indexed, displaced, direct]
8142:J8142 JSR/  F84E7      ; =0x84e7 =34023(-31513) =EOT,'g' [Jump to subroutine direct]
8145:      JMP/  J8178      ; =0x8178 =33144(-32392) [Jump direct]
8148:D8148 XFR/  W80B0+1,Y  ; =0x80b1 =32945(-32591) [Transfer direct to Y]
814c:      XFR=  ENTRY,S    ; =0x808c =32908(-32628) [Transfer immediate to S]
8150:      CLR   X          ; [Clear X]
8152:      LDB+  Y,12       ; [Load B indexed, displaced, direct]
8155:      LDA=  X'9800'    ; =0x9800 =38912(-26624) [Load A with immediate]
8158:      SAB              ; [A - B -> B]
8159:      BP    D815D      ; =+2 [Branch on plus]
815b:      SVC   X'5A'      ; =90 [Service call RSEG - release memory segment specified in AL]
815d:D815D MVF   (5)/X'01A0',-Y,81 ; =0x01a0 =416, [Move fixed-length, direct, displaced indexed]
8164:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8166:J8166 LDA+  Y,52       ; [Load A indexed, displaced, direct]
8169:      STA+  Y,50       ; [Store A indexed, displaced, direct]
816c:      LDAB+ *Y,4       ; [Load AL indexed, displaced, indirect]
816f:      BP    D8174      ; =+3 [Branch on plus]
8171:      JMP/  J8142      ; =0x8142 =33090(-32446) [Jump direct]
8174:D8174 JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8177:      DB    X'01'      ; =0x01 =1
*
8178:J8178 JSR/  F8CE3      ; =0x8ce3 =36067(-29469) =FF,'c' [Jump to subroutine direct]
817b:      DW    W86AE      ; =0x86ae =34478(-31058)
817d:      MVF   (102)/W86AE,/W8715 ; =0x86ae =34478(-31058),=0x8715 =34581(-30955) [Move fixed-length, direct, direct]
8184:      JSR/  F83A1      ; =0x83a1 =33697(-31839) [Jump to subroutine direct]
8187:      MVF   (102)/W863E,/W86AE ; =0x863e =34366(-31170),=0x86ae =34478(-31058) [Move fixed-length, direct, direct]
818e:      XFR=  W863E,Z    ; =0x863e =34366(-31170) [Transfer immediate to Z]
8192:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8194:      LDB=  X'0009'    ; =0x0009 =9 [Load B with immediate]
8197:      AAB              ; [A + B -> B]
8198:      STB/  W86A5      ; =0x86a5 =34469(-31067) [Store B direct]
819b:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
819e:      LDA=  W86AE      ; =0x86ae =34478(-31058) [Load A with immediate]
81a1:      LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
81a4:      LDBB+ Y,18       ; [Load BL indexed, displaced, direct]
81a7:      ANDB  BU,BL      ; [BU & BL -> BL]
81a9:      BZ    D81B7      ; =+12 [Branch if zero]
81ab:      SVC   X'1C'      ; =28 [Service call GC - get character time]
81ad:      DW    S86A7      ; =0x86a7 =34471(-31065) [address to put time]
81af:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
81b1:      STAB/ B86AF      ; =0x86af =34479(-31057) [Store AL direct]
81b4:      LDA=  W86A5      ; =0x86a5 =34469(-31067) [Load A with immediate]
81b7:D81B7 STA   W81DB      ; =+34 [Store A relative]
81b9:      STA   W81EA      ; =+47 [Store A relative]
81bb:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
81be:      DC    '.NOLOG'   ; hex:aececfcccfc7
81c4:      DB    X'01'      ; =0x01 =1
81c5:      BNZ   D81ED      ; =+38 [Branch if not zero]
81c7:      LDAB+ Z          ; [Load AL from address in Z]
81c8:      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
81ca:      SABB             ; [AL - BL -> BL]
81cb:      BNZ   D81DF      ; =+18 [Branch if not zero]
81cd:      LDB=  W8570      ; =0x8570 =34160(-31376) [Load B with immediate]
81d0:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
81d2:      LDB+  Y,8        ; [Load B indexed, displaced, direct]
81d5:      SAB              ; [A - B -> B]
81d6:      BZ    D81E7      ; =+15 [Branch if zero]
81d8:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
81db:W81DB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
81dd:      JMP   D81E7      ; =+8 [Jump relative]
81df:D81DF LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
81e2:      LDBB= X'01'      ; =1 [Load BL with immediate]
81e4:      NABB             ; [AL & BL -> BL]
81e5:      BZ    D81ED      ; =+6 [Branch if zero]
81e7:D81E7 JSR/  F84C4      ; =0x84c4 =33988(-31548) =EOT,'D' [Jump to subroutine direct]
81ea:W81EA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
81ec:      DB    X'02'      ; =0x02 =2
*
81ed:D81ED LDB=  W863E      ; =0x863e =34366(-31170) [Load B with immediate]
81f0:      LDA+  B          ; [Load A from address in B]
81f1:      DCA              ; [Decrement A]
81f2:      STA+  B+         ; [Store A indexed, direct, post-incremented]
81f4:      XFR   B,Z        ; [Transfer B to Z]
81f6:      AAB              ; [A + B -> B]
81f7:      CLAB             ; [Clear AL]
81f8:      STAB+ B          ; [Store AL to address in B]
81f9:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
81fc:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
81fe:      BNZ   D8203      ; =+3 [Branch if not zero]
8200:D8200 JMP/  J8166      ; =0x8166 =33126(-32410) [Jump direct]
8203:D8203 LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8205:      SABB             ; [AL - BL -> BL]
8206:      BZ    D8200      ; =-8 [Branch if zero]
8208:      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
820a:      SABB             ; [AL - BL -> BL]
820b:      BZ    D8200      ; =-13 [Branch if zero]
820d:      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
820f:      SABB             ; [AL - BL -> BL]
8210:      BZ    D8200      ; =-18 [Branch if zero]
8212:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
8214:      SABB             ; [AL - BL -> BL]
8215:      BZ    D821E      ; =+7 [Branch if zero]
8217:      LDAB- Z-         ; [Load AL indexed, pre-decremented, direct]
8219:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
821c:      DW    X'0014'    ; =0x0014 =20
*
821e:D821E JSR   F827E      ; =+94 [Jump to subroutine relative]
8220:      LDAB+ Z          ; [Load AL from address in Z]
8221:      BZ    D8200      ; =-35 [Branch if zero]
8223:      JSR   F826B      ; =+70 [Jump to subroutine relative]
8225:      BM    D825A      ; =+51 [Branch on minus]
8227:      JSR   F8288      ; =+95 [Jump to subroutine relative]
8229:      XAX              ; [Transfer A to X]
822a:      STB   W8244+1    ; =+25 [Store B relative]
822c:      XFR=  W8B7C,Y    ; =0x8b7c =35708(-29828) [Transfer immediate to Y]
8230:D8230 CLA              ; [Clear A]
8231:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8233:      BM    D825A      ; =+37 [Branch on minus]
8235:W8235 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8238:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
823a:      STA   W8258      ; =+28 [Store A relative]
823c:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
823e:      XFR   Y,B        ; [Transfer Y to B]
8240:      STB   W824A+1    ; =+9 [Store B relative]
8242:      ADD   A,Y        ; [A + Y -> Y]
8244:W8244 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8247:      SAB              ; [A - B -> B]
8248:      BNZ   D8230      ; =-26 [Branch if not zero]
824a:W824A LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
824d:      LDA   W8244+1    ; =-10 [Load A relative]
824f:      DCA              ; [Decrement A]
8250:      CPFR  -B,-X      ; [Compare fixed-length (len in AL), indexed, indexed]
8253:      BNZ   D8230      ; =-37 [Branch if not zero]
8255:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
8258:W8258 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
825a:D825A JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
825d:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F825F
*
825f:F825F LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
8261:      SABB             ; [AL - BL -> BL]
8262:      BLE   D8267      ; =+3 [Branch if less than or equal to zero]
8264:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8266:      RSR              ; [Return from subroutine]
*
8267:D8267 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8269:      SABB             ; [AL - BL -> BL]
826a:      RSR              ; [Return from subroutine]
*
* Function F826B
*
826b:F826B LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
826d:      SABB             ; [AL - BL -> BL]
826e:      BLE   D8273      ; =+3 [Branch if less than or equal to zero]
8270:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8272:      RSR              ; [Return from subroutine]
*
8273:D8273 LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
8275:      SABB             ; [AL - BL -> BL]
8276:      RSR              ; [Return from subroutine]
*
* Function F8277
*
8277:F8277 JSR   F826B      ; =-14 [Jump to subroutine relative]
8279:      BP    D827D      ; =+2 [Branch on plus]
827b:      JSR   F825F      ; =-30 [Jump to subroutine relative]
827d:D827D RSR              ; [Return from subroutine]
*
* Function F827E
*
827e:F827E LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8280:D8280 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8282:      SABB             ; [AL - BL -> BL]
8283:      BZ    D8280      ; =-5 [Branch if zero]
8285:      DCR   Z          ; [Decrement Z by 1]
8287:      RSR              ; [Return from subroutine]
*
* Function F8288
*
8288:F8288 STK   Z,2        ; [Push Z to the stack]
828a:D828A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
828c:      JSR   F8277      ; =-23 [Jump to subroutine relative]
828e:      BP    D828A      ; =-6 [Branch on plus]
8290:      DCR   Z          ; [Decrement Z by 1]
8292:      LDA+  S          ; [Load A from address in S]
8293:      SUB   Z,A        ; [Z - A -> A]
8295:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8297:      JSR   F827E      ; =-27 [Jump to subroutine relative]
8299:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
829b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
829d:      RSR              ; [Return from subroutine]
*
* Function F829E
*
829e:F829E LDAB+ Z          ; [Load AL from address in Z]
829f:      JSR   F825F      ; =-66 [Jump to subroutine relative]
82a1:      BP    D82A7      ; =+4 [Branch on plus]
82a3:      JSR   F82EA      ; =+69 [Jump to subroutine relative]
82a5:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
82a7:D82A7 CLA              ; [Clear A]
82a8:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
82aa:D82AA LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
82ac:      JSR   F825F      ; =-79 [Jump to subroutine relative]
82ae:      BP    D82B7      ; =+7 [Branch on plus]
82b0:      DCR   Z          ; [Decrement Z by 1]
82b2:      JSR   F827E      ; =-54 [Jump to subroutine relative]
82b4:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
82b6:      RSR              ; [Return from subroutine]
*
82b7:D82B7 LDA+  S          ; [Load A from address in S]
82b8:      STBB+ S          ; [Store BL to address in S]
82b9:      SLA              ; [Left shift A]
82ba:      XAB              ; [Transfer A to B]
82bb:      SLR   A,2        ; [Left shift A by 2]
82bd:      AAB              ; [A + B -> B]
82be:      CLA              ; [Clear A]
82bf:      LDAB+ S          ; [Load AL from address in S]
82c0:      AAB              ; [A + B -> B]
82c1:      STB+  S          ; [Store B to address in S]
82c2:      JMP   D82AA      ; =-26 [Jump relative]
*
* Function F82C4
*
82c4:F82C4 STK   Z,2        ; [Push Z to the stack]
82c6:      CLAB             ; [Clear AL]
82c7:D82C7 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
82c9:      BP    D82D8      ; =+13 [Branch on plus]
82cb:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
82cd:      SABB             ; [AL - BL -> BL]
82ce:      BZ    D82C7      ; =-9 [Branch if zero]
82d0:D82D0 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
82d2:      BM    D82D0      ; =-4 [Branch on minus]
82d4:D82D4 POP   Z,2        ; [Pop Z from the stack]
82d6:      CLA              ; [Clear A]
82d7:      RSR              ; [Return from subroutine]
*
82d8:D82D8 JSR   F8277      ; =-99 [Jump to subroutine relative]
82da:      BM    D82E1      ; =+5 [Branch on minus]
82dc:      LDAB+ Z          ; [Load AL from address in Z]
82dd:      JSR   F8277      ; =-104 [Jump to subroutine relative]
82df:      BP    D82D4      ; =-13 [Branch on plus]
82e1:D82E1 JSR   F827E      ; =-101 [Jump to subroutine relative]
82e3:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
82e5:      CLA              ; [Clear A]
82e6:      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
82e9:      RSR              ; [Return from subroutine]
*
* Function F82EA
*
82ea:F82EA LDA+  X          ; [Load A from address in X]
82eb:      STA/  W8235+1    ; =0x8236 =33334(-32202) [Store A direct]
82ee:      LDA/  X'0103'    ; =0x0103 =259 [Load A direct]
82f1:      MVF   (5)/X'01A0',-A,81 ; =0x01a0 =416, [Move fixed-length, direct, displaced indexed]
82f8:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
82fb:      DW    X'0001'    ; =0x0001 =1
82fd:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
82ff:      LDBB= X'D0'      ; =208(-48) ='P' [Load BL with immediate]
8301:      SABB             ; [AL - BL -> BL]
8302:      BZ    D830E      ; =+10 [Branch if zero]
8304:      DCR   Z          ; [Decrement Z by 1]
8306:      LDA/  W80B0+1    ; =0x80b1 =32945(-32591) [Load A direct]
8309:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
830c:      JMP   D8310      ; =+2 [Jump relative]
830e:D830E JSR   F829E      ; =-114 [Jump to subroutine relative]
8310:D8310 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8312:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8315:      LDX+  B,7        ; [Load X indexed, displaced, direct]
8318:D8318 LDB+  X+         ; [Load B indexed, direct, post-incremented]
831a:      BZ    D8329      ; =+13 [Branch if zero]
831c:      LDBB+ B,1        ; [Load BL indexed, displaced, direct]
831f:      SABB             ; [AL - BL -> BL]
8320:      BNZ   D8318      ; =-10 [Branch if not zero]
8322:      XFR   X,A        ; [Transfer X to A]
8324:      DCR   A,2        ; [Decrement A by 2]
8326:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8328:      RSR              ; [Return from subroutine]
*
8329:D8329 JSR   F82EA      ; =-65 [Jump to subroutine relative]
832b:      DW    X'0003'    ; =0x0003 =3
*
* Function F832D
*
832d:F832D LDA+  X+         ; [Load A indexed, direct, post-incremented]
832f:      STA   W833C      ; =+11 [Store A relative]
8331:      JSR/  F8288      ; =0x8288 =33416(-32120) [Jump to subroutine direct]
8334:      STA   W833E      ; =+8 [Store A relative]
8336:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8339:      JSR/  F8D0A      ; =0x8d0a =36106(-29430) [Jump to subroutine direct]
833c:W833C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
833e:W833E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8340:      RSR              ; [Return from subroutine]
*
* Function F8341
*
8341:F8341 STK   X,4        ; [Push X Y to the stack]
8343:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8346:      LDA+  A,9        ; [Load A indexed, displaced, direct]
8349:      XAY              ; [Transfer A to Y]
834a:      LDAB+ Z          ; [Load AL from address in Z]
834b:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
834e:      BM    D837E      ; =+46 [Branch on minus]
8350:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8353:D8353 LDX+  Y+         ; [Load X indexed, direct, post-incremented]
8355:      BZ    D8379      ; =+34 [Branch if zero]
8357:      LDBB+ X          ; [Load BL from address in X]
8358:      BZ    D8353      ; =-7 [Branch if zero]
835a:      LDB+  X,1        ; [Load B indexed, displaced, direct]
835d:      LDBB= X'04'      ; =4 [Load BL with immediate]
835f:      SUBB  BU,BL      ; [BU - BL -> BL]
8361:      BNZ   D8353      ; =-16 [Branch if not zero]
8363:      LDBB+ X,2        ; [Load BL indexed, displaced, direct]
8366:      SABB             ; [AL - BL -> BL]
8367:      BNZ   D8353      ; =-22 [Branch if not zero]
8369:D8369 LDA/  X'005A'    ; =0x005a =90 [Load A direct]
836c:      LDA+  A,9        ; [Load A indexed, displaced, direct]
836f:      SUB   Y,A        ; [Y - A -> A]
8371:      SRA              ; [Right shift A]
8372:      DCA              ; [Decrement A]
8373:      XAB              ; [Transfer A to B]
8374:      XFR   X,A        ; [Transfer X to A]
8376:      POP   X,4        ; [Pop Y X from the stack]
8378:      RSR              ; [Return from subroutine]
*
8379:D8379 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
837c:      DW    X'0006'    ; =0x0006 =6
*
837e:D837E JSR   F832D      ; =-83 [Jump to subroutine relative]
8380:      DW    W8397      ; =0x8397 =33687(-31849)
*
8382:D8382 LDX+  Y+         ; [Load X indexed, direct, post-incremented]
8384:      BZ    D8379      ; =-13 [Branch if zero]
8386:      LDBB+ X          ; [Load BL from address in X]
8387:      BZ    D8382      ; =-7 [Branch if zero]
8389:      ADD=  X'0007',X,A ; =0x0007 =7 [7 + X -> A]
838d:      CPF   (6)-A,/W8397 ; =0x8397 =33687(-31849) [Compare fixed-length, indexed, direct]
8393:      BZ    D8369      ; =-44 [Branch if zero]
8395:      JMP   D8382      ; =-21 [Jump relative]
*
8397:W8397 DS    10         ; =0x000a [Uninitialized memory]
*
*
* Function F83A1
*
83a1:F83A1 STK   X,4        ; [Push X Y to the stack]
83a3:      XFR=  W86B0,Z    ; =0x86b0 =34480(-31056) [Transfer immediate to Z]
83a7:      XFR=  W8640,Y    ; =0x8640 =34368(-31168) [Transfer immediate to Y]
83ab:      CAD/  W863E      ; [Clear word at address]
83af:D83AF LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
83b1:      BNZ   D83BA      ; =+7 [Branch if not zero]
83b3:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
83b5:      JSR   F83CD      ; =+22 [Jump to subroutine relative]
83b7:      POP   X,4        ; [Pop Y X from the stack]
83b9:      RSR              ; [Return from subroutine]
*
83ba:D83BA LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
83bc:      SABB             ; [AL - BL -> BL]
83bd:      BZ    D83C3      ; =+4 [Branch if zero]
83bf:D83BF JSR   F83CD      ; =+12 [Jump to subroutine relative]
83c1:      JMP   D83AF      ; =-20 [Jump relative]
83c3:D83C3 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
83c5:      BNZ   D83DD      ; =+22 [Branch if not zero]
83c7:D83C7 DCR   Z          ; [Decrement Z by 1]
83c9:      LDAB= X'A3'      ; =163(-93) ='#' [Load AL with immediate]
83cb:      JMP   D83BF      ; =-14 [Jump relative]
*
* Function F83CD
*
83cd:F83CD STAB+ Y          ; [Store AL to address in Y]
83ce:P83CE LDA/  W863E      ; =0x863e =34366(-31170) [Load A direct]
83d1:      INA              ; [Increment A]
83d2:      LDB=  X'0064'    ; =0x0064 =100 [Load B with immediate]
83d5:      SAB              ; [A - B -> B]
83d6:      BGZ   D83DC      ; =+4 [Branch if greater than zero]
83d8:      STA*  P83CE+1    ; =-11 [Store A relative indirect]
83da:      INR   Y          ; [Increment Y by 1]
83dc:D83DC RSR              ; [Return from subroutine]
*
83dd:D83DD LDX/  W80B0+1    ; =0x80b1 =32945(-32591) [Load X direct]
83e0:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
83e3:      BM    D8411      ; =+44 [Branch on minus]
83e5:      CLA              ; [Clear A]
83e6:      XFRB  BL,AL      ; [Transfer BL to AL]
83e8:      LDBB+ X,22       ; [Load BL indexed, displaced, direct]
83eb:      SABB             ; [AL - BL -> BL]
83ec:      BP    D83C7      ; =-39 [Branch on plus]
83ee:      XAB              ; [Transfer A to B]
83ef:      MUL=  X'000A',B  ; =0x000a =10 [10 * B -> B]
83f3:      LDA+  X,23       ; [Load A indexed, displaced, direct]
83f6:      ADD   B,A        ; [B + A -> A]
83f8:D83F8 XFR   Z,B        ; [Transfer Z to B]
83fa:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
83fc:      XAZ              ; [Transfer A to Z]
83fd:      LDX=  X'000A'    ; =0x000a =10 [Load X with immediate]
8400:D8400 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8402:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8404:      SABB             ; [AL - BL -> BL]
8405:      BZ    D8409      ; =+2 [Branch if zero]
8407:      JSR   F83CD      ; =-60 [Jump to subroutine relative]
8409:D8409 DCX              ; [Decrement X]
840a:      BGZ   D8400      ; =-12 [Branch if greater than zero]
840c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
840e:      XAZ              ; [Transfer A to Z]
840f:      JMP   D83AF      ; =-98 [Jump relative]
8411:D8411 XFRB  AL,AU      ; [Transfer AL to AU]
8413:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
8416:      STB   S8489      ; =+113 [Store B relative]
8418:      STB   S848B      ; =+113 [Store B relative]
841a:      LDB=  S8491      ; =0x8491 =33937(-31599) [Load B with immediate]
841d:D841D LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
841f:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
8421:      BZ    D83C7      ; =-92 [Branch if zero]
8423:      SUBB  AU,AL      ; [AU - AL -> AL]
8425:      BNZ   D841D      ; =-10 [Branch if not zero]
8427:      LDAB+ B          ; [Load AL from address in B]
8428:      BM    D8438      ; =+14 [Branch on minus]
842a:      CLRB  AU         ; [Clear AU]
842c:      ADD   A,X        ; [A + X -> X]
842e:      LDAB+ X          ; [Load AL from address in X]
842f:D842F SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
8431:      DW    S848D      ; =0x848d =33933(-31603) =EOT,CR [address of end of string]
*
8433:D8433 LDA=  S8488      ; =0x8488 =33928(-31608) [Load A with immediate]
8436:      JMP   D83F8      ; =-64 [Jump relative]
8438:D8438 LDAB= X'D3'      ; =211(-45) ='S' [Load AL with immediate]
843a:      SUBB  AL,AU      ; [AL - AU -> AU]
843c:      BNZ   D8446      ; =+8 [Branch if not zero]
843e:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8441:      LDAB+ B,5        ; [Load AL indexed, displaced, direct]
8444:      JMP   D842F      ; =-23 [Jump relative]
8446:D8446 LDAB+ Z          ; [Load AL from address in Z]
8447:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
844a:      BM    D845F      ; =+19 [Branch on minus]
844c:      LDX/  X'005A'    ; =0x005a =90 [Load X direct]
844f:      LDA+  X,7        ; [Load A indexed, displaced, direct]
8452:D8452 LDX+  A+         ; [Load X indexed, direct, post-incremented]
8454:      BNZ   D8459      ; =+3 [Branch if not zero]
8456:      JMP/  D83C7      ; =0x83c7 =33735(-31801) [Jump direct]
8459:D8459 DCRB  BL         ; [Decrement BL by 1]
845b:      BP    D8452      ; =-11 [Branch on plus]
845d:      INR   Z          ; [Increment Z by 1]
845f:D845F LDA+  X,10       ; [Load A indexed, displaced, direct]
8462:      LDB+  X,12       ; [Load B indexed, displaced, direct]
8465:      SUB   B,A        ; [B - A -> A]
8467:      BZ    D846A      ; =+1 [Branch if zero]
8469:      INA              ; [Increment A]
846a:D846A CLR   X          ; [Clear X]
846c:      XAB              ; [Transfer A to B]
846d:      BP    D8478      ; =+9 [Branch on plus]
846f:      LDA=  X'D8F0'    ; =0xd8f0 =55536(-10000) ='X','p' [Load A with immediate]
8472:D8472 INX              ; [Increment X]
8473:      AAB              ; [A + B -> B]
8474:      BM    D8472      ; =-4 [Branch on minus]
8476:      XFR   B,A        ; [Transfer B to A]
8478:D8478 SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
847a:      DW    S848D      ; =0x848d =33933(-31603) =EOT,CR [address of end of string]
847c:      LDAB  S8489      ; =+11 [Load AL relative]
847e:      JMP   D8481      ; =+1 [Jump relative]
8480:D8480 INAB             ; [Increment AL]
8481:D8481 DCX              ; [Decrement X]
8482:      BP    D8480      ; =-4 [Branch on plus]
8484:      STAB  S8489      ; =+3 [Store AL relative]
8486:      JMP   D8433      ; =-85 [Jump relative]
*
8488:S8488 DC    ' '        ; hex:a0 dec:160(-96)
8489:S8489 DC    '  '       ; hex:a0a0 dec:41120(-96)
848b:S848B DC    '  '       ; hex:a0a0 dec:41120(-96)
848d:S848D DC    '    '     ; hex:a0a0a0a0
8491:S8491 DC    ' I'       ; hex:a0c9 dec:41161(-55)
8493:      DB    X'01'      ; =0x01 =1
8494:      DC    'C'        ; hex:c3 dec:195(-61)
8495:      DB    X'14'      ; =0x14 =20
8496:      DC    'U'        ; hex:d5 dec:213(-43)
8497:      DB    X'15'      ; =0x15 =21
8498:      DC    'V'        ; hex:d6 dec:214(-42)
8499:      DB    X'28'      ; =0x28 =40
849a:      DC    'D'        ; hex:c4 dec:196(-60)
849b:      DB    X'31'      ; =0x31 =49
849c:      DC    'T'        ; hex:d4 dec:212(-44)
849d:      DB    X'5E'      ; =0x5e =94
849e:      DC    'L'        ; hex:cc dec:204(-52)
849f:      DB    X'5F'      ; =0x5f =95
84a0:      DC    'W'        ; hex:d7 dec:215(-41)
84a1:      DB    X'60'      ; =0x60 =96
84a2:      DC    'M'        ; hex:cd dec:205(-51)
84a3:      DB    X'FF'      ; =0xff =255(-1)
84a4:      DC    'S'        ; hex:d3 dec:211(-45)
84a5:      DW    X'FF00'    ; =0xff00 =65280(-256)
*
*
* Function F84A7
*
84a7:F84A7 STX-  S-         ; [Store X indexed, pre-decremented, direct]
84a9:      XFR   B,X        ; [Transfer B to X]
84ab:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
84ad:      XFR   B,B        ; [Transfer B to B]
84af:      BZ    D84BF      ; =+14 [Branch if zero]
84b1:      LDA+  X,24       ; [Load A indexed, displaced, direct]
84b4:      BZ    D84B9      ; =+3 [Branch if zero]
84b6:      STA+  B,6        ; [Store A indexed, displaced, direct]
84b9:D84B9 LDA+  X,18       ; [Load A indexed, displaced, direct]
84bc:      STA+  B,4        ; [Store A indexed, displaced, direct]
84bf:D84BF LDX+  S+         ; [Load X indexed, direct, post-incremented]
84c1:      RSR              ; [Return from subroutine]
*
84c2:      DC    's'        ; hex:f3 dec:243(-13)
84c3:      DB    X'03'      ; =0x03 =3
*
* Function F84C4
*
84c4:F84C4 LDA+  X+         ; [Load A indexed, direct, post-incremented]
84c6:W84C6 LDB=  W8570      ; =0x8570 =34160(-31376) [Load B with immediate]
84c9:      STA+  B,16       ; [Store A indexed, displaced, direct]
84cc:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
84ce:      JMP   D84D7      ; =+7 [Jump relative]
*
* Function F84D0
*
84d0:F84D0 STB   W84D4+1    ; =+3 [Store B relative]
*
* Function F84D2
*
84d2:F84D2 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
84d4:W84D4 LDB=  W85CA      ; =0x85ca =34250(-31286) [Load B with immediate]
84d7:D84D7 STAB+ B,3        ; [Store AL indexed, displaced, direct]
84da:      STB   W84E4      ; =+8 [Store B relative]
84dc:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
84de:      LDB   W84E4      ; =+4 [Load B relative]
84e0:      JSR   F84A7      ; =-59 [Jump to subroutine relative]
84e2:      JSR   F8506      ; =+34 [Jump to subroutine relative]
84e4:W84E4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
84e6:      RSR              ; [Return from subroutine]
*
* Function F84E7
*
84e7:F84E7 LDA=  W86AE      ; =0x86ae =34478(-31058) [Load A with immediate]
84ea:      STA/  W85D0      ; =0x85d0 =34256(-31280) [Store A direct]
84ed:      LDAB= X'01'      ; =1 [Load AL with immediate]
84ef:      STAB/ B85CD      ; =0x85cd =34253(-31283) [Store AL direct]
84f2:      JSR   F84F7      ; =+3 [Jump to subroutine relative]
84f4:      DW    W85CA      ; =0x85ca =34250(-31286)
84f6:      RSR              ; [Return from subroutine]
*
* Function F84F7
*
84f7:F84F7 LDA/  W80B0+1    ; =0x80b1 =32945(-32591) [Load A direct]
84fa:      LDA+  A,8        ; [Load A indexed, displaced, direct]
84fd:      LDB+  X          ; [Load B from address in X]
84fe:      STB   W8504      ; =+4 [Store B relative]
8500:      SVC   X'0F'      ; =15 [Service call CONIO - console I/O]
8502:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
8504:W8504 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 1]
*
* Function F8506
*
8506:F8506 LDB/  W80B0+1    ; =0x80b1 =32945(-32591) [Load B direct]
8509:      LDA+  B,50       ; [Load A indexed, displaced, direct]
850c:      BNZ   D8533      ; =+37 [Branch if not zero]
850e:      LDA=  X'4000'    ; =0x4000 =16384 [Load A with immediate]
8511:      LDAB+ B          ; [Load AL from address in B]
8512:      ANDB  AL,AU      ; [AL & AU -> AU]
8514:      BZ    D851C      ; =+6 [Branch if zero]
8516:      LDX+  B,8        ; [Load X indexed, displaced, direct]
8519:      JMP/  J888C      ; =0x888c =34956(-30580) [Jump direct]
851c:D851C MVF   (39)/W877C,/W863E ; =0x877c =34684(-30852),=0x863e =34366(-31170) [Move fixed-length, direct, direct]
8523:      JMP   D8525      ; =+0 [Jump relative]
8525:D8525 XFR=  W8B7C,Z    ; =0x8b7c =35708(-29828) [Transfer immediate to Z]
8529:      CLR   A,2        ; [Set A to 2]
852b:      STA/  W8235+1    ; =0x8236 =33334(-32202) [Store A direct]
852e:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
8531:      DW    X'0004'    ; =0x0004 =4
*
8533:D8533 LDB/  W80B0+1    ; =0x80b1 =32945(-32591) [Load B direct]
8536:      CLA              ; [Clear A]
8537:      DCA              ; [Decrement A]
8538:      STA+  B,50       ; [Store A indexed, displaced, direct]
853b:      LDB+  X          ; [Load B from address in X]
853c:      LDAB+ B          ; [Load AL from address in B]
853d:      BZ    D855F      ; =+32 [Branch if zero]
853f:      LDB=  X'0012'    ; =0x0012 =18 [Load B with immediate]
8542:      DCAB             ; [Decrement AL]
8543:      BZ    D854C      ; =+7 [Branch if zero]
8545:      INR   B          ; [Increment B by 1]
8547:      DCAB             ; [Decrement AL]
8548:      BZ    D854C      ; =+2 [Branch if zero]
854a:      INR   B          ; [Increment B by 1]
854c:D854C STB/  W8235+1    ; =0x8236 =33334(-32202) [Store B direct]
854f:      LDB/  W80B0+1    ; =0x80b1 =32945(-32591) [Load B direct]
8552:      LDB+  B,8        ; [Load B indexed, displaced, direct]
8555:      LDAB+ B,1        ; [Load AL indexed, displaced, direct]
8558:      BZ    D8525      ; =-53 [Branch if zero]
855a:      JSR/  F8B36      ; =0x8b36 =35638(-29898) [Jump to subroutine direct]
855d:      DW    X'0001'    ; =0x0001 =1
*
855f:D855F LDA+  X+         ; [Load A indexed, direct, post-incremented]
8561:      RSR              ; [Return from subroutine]
*
* Function F8562
*
8562:F8562 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8564:      STA   S8576      ; =+16 [Store A relative]
8566:      LDAB= X'02'      ; =2 [Load AL with immediate]
8568:      STAB  S8573      ; =+9 [Store AL relative]
856a:      JSR/  F84F7      ; =0x84f7 =34039(-31497) =EOT,'w' [Jump to subroutine direct]
856d:      DW    W8570      ; =0x8570 =34160(-31376)
856f:      RSR              ; [Return from subroutine]
*
8570:W8570 DW    X'0082'    ; =0x0082 =130
8572:      DB    X'22'      ; =0x22 =34
8573:S8573 DB    0,3        ; =0x00,0x0003
8576:S8576 DB    0,6        ; =0x00,0x0006
857c:      DW    X'0102'    ; =0x0102 =258
857e:      DB    X'00'      ; =0x00 =0 =NUL
857f:      DW    X'6400'    ; =0x6400 =25600
8581:      DB    0,13       ; =0x00,0x000d
858e:W858E DW    X'0082'    ; =0x0082 =130
8590:      DW    X'2202'    ; =0x2202 =8706
8592:      DW    X'0190'    ; =0x0190 =400
8594:      DW    W89A3      ; =0x89a3 =35235(-30301)
8596:      DB    0,3        ; =0x00,0x0003
8599:      DW    X'0102'    ; =0x0102 =258
859b:      DW    X'0200'    ; =0x0200 =512
859d:      DW    X'6400'    ; =0x6400 =25600
859f:      DB    0,13       ; =0x00,0x000d
85ac:W85AC DW    X'0082'    ; =0x0082 =130
85ae:      DW    X'2202'    ; =0x2202 =8706
85b0:      DB    0,7        ; =0x00,0x0007
85b7:      DW    X'0804'    ; =0x0804 =2052
85b9:      DW    X'FF00'    ; =0xff00 =65280(-256)
85bb:      DW    X'6400'    ; =0x6400 =25600
85bd:      DB    0,13       ; =0x00,0x000d
85ca:W85CA DW    X'0080'    ; =0x0080 =128
85cc:      DB    X'21'      ; =0x21 =33
85cd:B85CD DW    X'0100'    ; =0x0100 =256
85cf:      DB    X'64'      ; =0x64 =100
85d0:W85D0 DW    W86AE      ; =0x86ae =34478(-31058)
85d2:      DB    0,5        ; =0x00,0x0005
85d7:      DW    X'0200'    ; =0x0200 =512
85d9:      DB    X'64'      ; =0x64 =100
85da:      DW    W86AE      ; =0x86ae =34478(-31058)
85dc:      DB    0,12       ; =0x00,0x000c
85e8:W85E8 DW    X'0080'    ; =0x0080 =128
85ea:      DW    X'2101'    ; =0x2101 =8449
85ec:      DW    X'0190'    ; =0x0190 =400
85ee:      DW    W8807      ; =0x8807 =34823(-30713)
85f0:      DB    0,3        ; =0x00,0x0003
85f3:      DW    X'0102'    ; =0x0102 =258
85f5:      DW    X'0200'    ; =0x0200 =512
85f7:      DB    X'64'      ; =0x64 =100
85f8:      DW    W86AE      ; =0x86ae =34478(-31058)
85fa:      DB    0,12       ; =0x00,0x000c
8606:W8606 DW    X'0080'    ; =0x0080 =128
8608:      DW    X'2101'    ; =0x2101 =8449
860a:      DB    0,13       ; =0x00,0x000d
8617:      DW    X'0804'    ; =0x0804 =2052
8619:      DW    X'FF00'    ; =0xff00 =65280(-256)
861b:      DB    X'64'      ; =0x64 =100
861c:      DW    W86AE      ; =0x86ae =34478(-31058)
861e:      DB    0,12       ; =0x00,0x000c
862a:W862A DW    X'000D'    ; =0x000d =13
862c:S862C DC    'XXXXXX READY'
8638:      DB    X'8D'      ; =0x8d =141(-115) =CR
8639:S8639 DC    'READY'    ; hex:d2c5c1c4d9
863e:W863E DS    2          ; =0x0002 [Uninitialized memory]
8640:W8640 DS    101        ; =0x0065 [Uninitialized memory]
86a5:W86A5 DW    X'0009'    ; =0x0009 =9
86a7:S86A7 DC    '00:00:0'  ; hex:b0b0bab0b0bab0
86ae:W86AE DS    1          ; =0x0001 [Uninitialized memory]
86af:B86AF DS    1          ; =0x0001 [Uninitialized memory]
86b0:W86B0 DS    101        ; =0x0065 [Uninitialized memory]
8715:W8715 DS    103        ; =0x0067 [Uninitialized memory]
877c:W877C DW    X'0025'    ; =0x0025 =37
877e:      DC    '  ** TIME LOCK - PARTITION STOPPED **'
87a3:W87A3 DW    X'003A'    ; =0x003a =58
87a5:      DC    '** CRT SECURITY VIOLATION OCCURED A'
87c8:S87C8 DC    'T X'      ; hex:d4a0d8
87cb:S87CB DC    'X'        ; hex:d8 dec:216(-40)
87cc:S87CC DC    ':X'       ; hex:bad8 dec:47832(-40)
87ce:S87CE DC    'X'        ; hex:d8 dec:216(-40)
87cf:S87CF DC    ':X'       ; hex:bad8 dec:47832(-40)
87d1:S87D1 DC    'X ON '    ; hex:d8a0cfcea0
87d6:S87D6 DC    'MM/DD/YY' ; hex:cdcdafc4c4afd9d9
87de:      DB    X'8D'      ; =0x8d =141(-115) =CR
87df:W87DF DW    X'0026'    ; =0x0026 =38
87e1:      DC    '** MEMORY SHORTAGE - PARTITION STOPPED'
*
8807:W8807 LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
880a:      LDBB= X'04'      ; =4 [Load BL with immediate]
880c:      NABB             ; [AL & BL -> BL]
880d:      BZ    D8812      ; =+3 [Branch if zero]
880f:      JMP/  J8911      ; =0x8911 =35089(-30447) [Jump direct]
8812:D8812 LDBB= X'40'      ; =64 [Load BL with immediate]
8814:      NABB             ; [AL & BL -> BL]
8815:      BZ    D882F      ; =+24 [Branch if zero]
8817:      MVF   (5)/X'01A0',-Y,81 ; =0x01a0 =416, [Move fixed-length, direct, displaced indexed]
881e:      LDB+  Y,41       ; [Load B indexed, displaced, direct]
8821:      STB   W882D      ; =+10 [Store B relative]
8823:      LDA+  B          ; [Load A from address in B]
8824:      INR   A,2        ; [Increment A by 2]
8826:      MVFR  -B,/W86AE  ; =0x86ae =34478(-31058) [Move fixed-length (len in AL), indexed, direct]
882b:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
882d:W882D DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
882f:D882F LDAB+ Y          ; [Load AL from address in Y]
8830:      LDBB= X'40'      ; =64 [Load BL with immediate]
8832:      NABB             ; [AL & BL -> BL]
8833:      BNZ   D8838      ; =+3 [Branch if not zero]
8835:      JMP/  J8911      ; =0x8911 =35089(-30447) [Jump direct]
8838:D8838 FIL   (8)=' ',/W86AE ; =0x86ae =34478(-31058) [Fill with byte, literal=0xa0(160,-96), direct]
883e:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8841:      LDB=  X'0800'    ; =0x0800 =2048 [Load B with immediate]
8844:      LDBB+ A          ; [Load BL from address in A]
8845:      ORIB  BU,BL      ; [BU | BL -> BL]
8847:      STBB+ A          ; [Store BL to address in A]
8848:      LDA+  Y,52       ; [Load A indexed, displaced, direct]
884b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
884d:      SUB=  X'003C',A  ; =0x003c =60 [60 - A -> A]
8851:      BNL   D8857      ; =+4 [Branch on no link]
8853:      LDA=  X'003C'    ; =0x003c =60 [Load A with immediate]
8856:      STA+  S          ; [Store A to address in S]
8857:D8857 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8859:      STA+  Y,50       ; [Store A indexed, displaced, direct]
885c:      JSR/  F84E7      ; =0x84e7 =34023(-31513) =EOT,'g' [Jump to subroutine direct]
885f:      JSR/  F8CE3      ; =0x8ce3 =36067(-29469) =FF,'c' [Jump to subroutine direct]
8862:      DW    W86AE      ; =0x86ae =34478(-31058)
8864:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8867:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8869:      XAX              ; [Transfer A to X]
886a:      LDAB+ X          ; [Load AL from address in X]
886b:      LDBB= X'F7'      ; =247(-9) ='w' [Load BL with immediate]
886d:      NABB             ; [AL & BL -> BL]
886e:      STBB+ X          ; [Store BL to address in X]
886f:      LDA/  W86AE      ; =0x86ae =34478(-31058) [Load A direct]
8872:      BZ    J888C      ; =+24 [Branch if zero]
8874:      DCR   A,7        ; [Decrement A by 7]
8876:      BP    J888C      ; =+20 [Branch on plus]
8878:      INR   A,7        ; [Increment A by 7]
887a:      ADD=  W86B0,A    ; =0x86b0 =34480(-31056) [34480 + A -> A]
887e:      FIL   (6)=' ',-A ; [Fill with byte, literal=0xa0(160,-96), indexed]
8883:      CPF   (6)-X,31,/W86B0 ; =0x86b0 =34480(-31056) [Compare fixed-length, displaced indexed, direct]
888a:      BZ    D88A3      ; =+23 [Branch if zero]
888c:J888C ADD=  X'0025',X  ; =0x0025 =37 [37 + X -> X]
8890:      STX   W8894      ; =+2 [Store X relative]
8892:      SVC   X'1B'      ; =27 [Service call GB - get binary time]
8894:W8894 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address to put time]
8896:      SVC   X'0B'      ; =11 [Service call DT - get binary date]
8898:      STA+  X,4        ; [Store A indexed, displaced, direct]
889b:      CLA              ; [Clear A]
889c:      DCA              ; [Decrement A]
889d:      STA/  W863E      ; =0x863e =34366(-31170) [Store A direct]
88a0:      JMP/  D8525      ; =0x8525 =34085(-31451) [Jump direct]
88a3:D88A3 LDAB+ Y          ; [Load AL from address in Y]
88a4:      LDBB= X'BF'      ; =191(-65) ='?' [Load BL with immediate]
88a6:      NABB             ; [AL & BL -> BL]
88a7:      STBB+ Y          ; [Store BL to address in Y]
88a8:      LDA+  X,37       ; [Load A indexed, displaced, direct]
88ab:      INA              ; [Increment A]
88ac:      BZ    D890F      ; =+97 [Branch if zero]
88ae:      LDA+  X,41       ; [Load A indexed, displaced, direct]
88b1:      SVC   X'05'      ; =5 [Service call TS - load transient module]
88b3:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
88b4:      DW    S87D6      ; =0x87d6 =34774(-30762) =BEL,'V' [address of string date]
88b6:      MVF   (4)-X,37,/W863E ; =0x863e =34366(-31170) [Move fixed-length, displaced indexed, direct]
88bd:      FIL   (6)=X'FF',-X,37 ; [Fill with byte, literal=255(-1), displaced indexed]
88c3:      LDA=  W8894      ; =0x8894 =34964(-30572) [Load A with immediate]
88c6:      D     =10,/W863E(4) ; =0x863e =34366(-31170) [Divide bignums, literal=0x0a, direct]
88cc:      DRM   =60,/W863E(4) ; =0x863e =34366(-31170) [Divide bignums with remainder, literal=0x3c, direct]
88d2:      CLA              ; [Clear A]
88d3:      LDAB  W8894      ; =-65 [Load AL relative]
88d5:      ADD=  X'0064',A  ; =0x0064 =100 [100 + A -> A]
88d9:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
88db:      DW    S87D1      ; =0x87d1 =34769(-30767) =BEL,'Q' [address of end of string]
88dd:      LDA=  W8894      ; =0x8894 =34964(-30572) [Load A with immediate]
88e0:      DRM   =60,/W863E(4) ; =0x863e =34366(-31170) [Divide bignums with remainder, literal=0x3c, direct]
88e6:      CLA              ; [Clear A]
88e7:      LDAB  W8894      ; =-85 [Load AL relative]
88e9:      ADD=  X'0064',A  ; =0x0064 =100 [100 + A -> A]
88ed:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
88ef:      DW    S87CE      ; =0x87ce =34766(-30770) =BEL,'N' [address of end of string]
88f1:      LDA/  W8640      ; =0x8640 =34368(-31168) [Load A direct]
88f4:      ADD=  X'0064',A  ; =0x0064 =100 [100 + A -> A]
88f8:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
88fa:      DW    S87CB      ; =0x87cb =34763(-30773) =BEL,'K' [address of end of string]
88fc:      LDAB= X'BA'      ; =186(-70) =':' [Load AL with immediate]
88fe:      STAB/ S87CC      ; =0x87cc =34764(-30772) =BEL,'L' [Store AL direct]
8901:      STAB/ S87CF      ; =0x87cf =34767(-30769) =BEL,'O' [Store AL direct]
8904:      LDA=  X'D4A0'    ; =0xd4a0 =54432(-11104) ='T',' ' [Load A with immediate]
8907:      STA/  S87C8      ; =0x87c8 =34760(-30776) =BEL,'H' [Store A direct]
890a:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
890d:      DW    W87A3      ; =0x87a3 =34723(-30813) =BEL,'#'
*
890f:D890F LDX+  S+         ; [Load X indexed, direct, post-incremented]
8911:J8911 LDA+  Y,4        ; [Load A indexed, displaced, direct]
8914:      LDAB+ A,6        ; [Load AL indexed, displaced, direct]
8917:      BM    D894E      ; =+53 [Branch on minus]
8919:      LDB=  W8570      ; =0x8570 =34160(-31376) [Load B with immediate]
891c:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
891e:      XFR   B,B        ; [Transfer B to B]
8920:      BZ    D892D      ; =+11 [Branch if zero]
8922:      LDA=  W858E      ; =0x858e =34190(-31346) [Load A with immediate]
8925:      STA/  W84C6+1    ; =0x84c7 =33991(-31545) =EOT,'G' [Store A direct]
8928:      XAZ              ; [Transfer A to Z]
8929:      JSR   F8982      ; =+87 [Jump to subroutine relative]
892b:      JMP   D8944      ; =+23 [Jump relative]
892d:D892D LDB=  X'0700'    ; =0x0700 =1792 [Load B with immediate]
8930:      LDBB+ A,1        ; [Load BL indexed, displaced, direct]
8933:      SUBB  BU,BL      ; [BU - BL -> BL]
8935:      BNZ   D894E      ; =+23 [Branch if not zero]
8937:      XAB              ; [Transfer A to B]
8938:      LDA=  W85AC      ; =0x85ac =34220(-31316) [Load A with immediate]
893b:      STA/  W84C6+1    ; =0x84c7 =33991(-31545) =EOT,'G' [Store A direct]
893e:      XAZ              ; [Transfer A to Z]
893f:      JSR/  F8998      ; =0x8998 =35224(-30312) [Jump to subroutine direct]
8942:      JMP   D894E      ; =+10 [Jump relative]
8944:D8944 LDAB+ Y          ; [Load AL from address in Y]
8945:      LDBB= X'02'      ; =2 [Load BL with immediate]
8947:      NABB             ; [AL & BL -> BL]
8948:      BZ    D894E      ; =+4 [Branch if zero]
894a:      XFR   Z,B        ; [Transfer Z to B]
894c:      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
894e:D894E LDAB+ Y          ; [Load AL from address in Y]
894f:      LDBB= X'FD'      ; =253(-3) ='}' [Load BL with immediate]
8951:      NABB             ; [AL & BL -> BL]
8952:      STBB+ Y          ; [Store BL to address in Y]
8953:      LDAB+ *Y,4       ; [Load AL indexed, displaced, indirect]
8956:      BM    D899F      ; =+71 [Branch on minus]
8958:      LDB=  W85CA      ; =0x85ca =34250(-31286) [Load B with immediate]
895b:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
895d:      XFR   B,B        ; [Transfer B to B]
895f:      BZ    D896C      ; =+11 [Branch if zero]
8961:      LDA=  W85E8      ; =0x85e8 =34280(-31256) [Load A with immediate]
8964:      STA/  W84D4+1    ; =0x84d5 =34005(-31531) =EOT,'U' [Store A direct]
8967:      XAZ              ; [Transfer A to Z]
8968:      JSR   F8982      ; =+24 [Jump to subroutine relative]
896a:      JMP   D89A0      ; =+52 [Jump relative]
896c:D896C LDB=  X'0700'    ; =0x0700 =1792 [Load B with immediate]
896f:      LDBB+ A,1        ; [Load BL indexed, displaced, direct]
8972:      SUBB  BU,BL      ; [BU - BL -> BL]
8974:      BNZ   D899F      ; =+41 [Branch if not zero]
8976:      XAB              ; [Transfer A to B]
8977:      LDA=  W8606      ; =0x8606 =34310(-31226) [Load A with immediate]
897a:      STA/  W84D4+1    ; =0x84d5 =34005(-31531) =EOT,'U' [Store A direct]
897d:      XAZ              ; [Transfer A to Z]
897e:      JSR   F8998      ; =+24 [Jump to subroutine relative]
8980:      JMP   D89A0      ; =+30 [Jump relative]
*
* Function F8982
*
8982:F8982 LDA+  B,6        ; [Load A indexed, displaced, direct]
8985:      STA+  Z,20       ; [Store A indexed, displaced, direct]
8988:      STA+  Z,24       ; [Store A indexed, displaced, direct]
898b:      LDA+  B,4        ; [Load A indexed, displaced, direct]
898e:      STA+  Z,18       ; [Store A indexed, displaced, direct]
8991:      STA+  Z,8        ; [Store A indexed, displaced, direct]
8994:      INA              ; [Increment A]
8995:      STA+  Z,22       ; [Store A indexed, displaced, direct]
*
* Function F8998
*
8998:F8998 LDAB= X'01'      ; =1 [Load AL with immediate]
899a:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
899d:      XFR   Z,B        ; [Transfer Z to B]
899f:D899F RSR              ; [Return from subroutine]
*
89a0:D89A0 SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
89a2:      RSR              ; [Return from subroutine]
*
89a3:W89A3 DS    403        ; =0x0193 [Uninitialized memory]
*
*
* Function F8B36
*
8b36:F8B36 LDB+  X          ; [Load B from address in X]
8b37:      DCRB  BL,3       ; [Decrement BL by 3]
8b39:      BNZ   D8B52      ; =+23 [Branch if not zero]
8b3b:      LDB/  W84C6+1    ; =0x84c7 =33991(-31545) =EOT,'G' [Load B direct]
8b3e:      LDA=  W858E      ; =0x858e =34190(-31346) [Load A with immediate]
8b41:      SUB   B,A        ; [B - A -> A]
8b43:      BNZ   D8B52      ; =+13 [Branch if not zero]
8b45:      LDAB= X'0B'      ; =11 [Load AL with immediate]
8b47:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8b4a:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8b4c:      LDB/  W84C6+1    ; =0x84c7 =33991(-31545) =EOT,'G' [Load B direct]
8b4f:      JSR/  F84A7      ; =0x84a7 =33959(-31577) =EOT,' [Jump to subroutine direct]
8b52:D8B52 LDB+  X          ; [Load B from address in X]
8b53:      DCRB  BL,5       ; [Decrement BL by 5]
8b55:      BNZ   D8B60      ; =+9 [Branch if not zero]
8b57:      LDB/  X'0103'    ; =0x0103 =259 [Load B direct]
8b5a:      FIL   (5)='}',-B,81 ; [Fill with byte, literal=0xfd(253,-3), displaced indexed]
8b60:D8B60 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8b62:W8B62 LDB=  X'0014'    ; =0x0014 =20 [Load B with immediate]
8b65:      SAB              ; [A - B -> B]
8b66:      BZ    D8B71      ; =+9 [Branch if zero]
8b68:      STA   W8B62+1    ; =-7 [Store A relative]
8b6a:      SVC   X'04'      ; =4 [Service call LODJX - load JX module specified]
8b6c:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
8b6e:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
8b6f:      STB   D8B71+1    ; =+1 [Store B relative]
8b71:D8B71 LDB=  W8D2F      ; =0x8d2f =36143(-29393) [Load B with immediate]
8b74:      XFR=  ENTRY,S    ; =0x808c =32908(-32628) [Transfer immediate to S]
8b78:      CLR   X          ; [Clear X]
8b7a:      JMP+  B          ; [Jump indexed, direct]
*
8b7c:W8B7C DW    X'0002'    ; =0x0002 =2
8b7e:      DB    X'05'      ; =0x05 =5
8b7f:      DC    'FSPEC'    ; hex:c6d3d0c5c3
8b84:      DW    X'0102'    ; =0x0102 =258
8b86:      DB    X'05'      ; =0x05 =5
8b87:      DC    'DSPEC'    ; hex:c4d3d0c5c3
8b8c:      DB    X'00'      ; =0x00 =0 =NUL
8b8d:      DW    X'0303'    ; =0x0303 =771
8b8f:      DC    'STA'      ; hex:d3d4c1
8b92:      DW    X'0204'    ; =0x0204 =516
8b94:      DB    X'04'      ; =0x04 =4
8b95:      DC    'STOP'     ; hex:d3d4cfd0
8b99:      DW    X'0304'    ; =0x0304 =772
8b9b:      DB    X'03'      ; =0x03 =3
8b9c:      DC    'LOG'      ; hex:cccfc7
8b9f:      DW    X'0404'    ; =0x0404 =1028
8ba1:      DB    X'05'      ; =0x05 =5
8ba2:      DC    'NOLOG'    ; hex:cecfcccfc7
8ba7:      DW    X'0504'    ; =0x0504 =1284
8ba9:      DB    X'03'      ; =0x03 =3
8baa:      DC    'PRI'      ; hex:d0d2c9
8bad:      DB    X'00'      ; =0x00 =0 =NUL
8bae:      DW    X'0906'    ; =0x0906 =2310
8bb0:      DC    'CANCEL'   ; hex:c3c1cec3c5cc
8bb6:      DB    X'00'      ; =0x00 =0 =NUL
8bb7:      DW    X'0503'    ; =0x0503 =1283
8bb9:      DC    'RUN'      ; hex:d2d5ce
8bbc:      DB    X'00'      ; =0x00 =0 =NUL
8bbd:      DW    X'0603'    ; =0x0603 =1539
8bbf:      DC    'USE'      ; hex:d5d3c5
8bc2:      DB    X'00'      ; =0x00 =0 =NUL
8bc3:      DW    X'0703'    ; =0x0703 =1795
8bc5:      DC    'IOA'      ; hex:c9cfc1
8bc8:      DB    X'00'      ; =0x00 =0 =NUL
8bc9:      DW    X'0A03'    ; =0x0a03 =2563
8bcb:      DC    'NEW'      ; hex:cec5d7
8bce:      DB    X'00'      ; =0x00 =0 =NUL
8bcf:      DW    X'0C03'    ; =0x0c03 =3075
8bd1:      DC    'END'      ; hex:c5cec4
8bd4:      DB    X'00'      ; =0x00 =0 =NUL
8bd5:      DW    X'0D03'    ; =0x0d03 =3331
8bd7:      DC    'DIR'      ; hex:c4c9d2
8bda:      DB    X'00'      ; =0x00 =0 =NUL
8bdb:      DW    X'0E03'    ; =0x0e03 =3587
8bdd:      DC    'DEL'      ; hex:c4c5cc
8be0:      DB    X'00'      ; =0x00 =0 =NUL
8be1:      DW    X'1003'    ; =0x1003 =4099
8be3:      DC    'REL'      ; hex:d2c5cc
8be6:      DB    X'00'      ; =0x00 =0 =NUL
8be7:      DW    X'1104'    ; =0x1104 =4356
8be9:      DC    'SETA'     ; hex:d3c5d4c1
8bed:      DW    X'0111'    ; =0x0111 =273
8bef:      DB    X'04'      ; =0x04 =4
8bf0:      DC    'SETC'     ; hex:d3c5d4c3
8bf4:      DW    X'0112'    ; =0x0112 =274
8bf6:      DB    X'05'      ; =0x05 =5
8bf7:      DC    'SKIPR'    ; hex:d3cbc9d0d2
8bfc:      DB    X'00'      ; =0x00 =0 =NUL
8bfd:      DW    X'1204'    ; =0x1204 =4612
8bff:      DC    'SKIP'     ; hex:d3cbc9d0
8c03:      DB    X'00'      ; =0x00 =0 =NUL
8c04:      DW    X'1303'    ; =0x1303 =4867
8c06:      DC    'JOB'      ; hex:cacfc2
8c09:      DW    X'0113'    ; =0x0113 =275
8c0b:      DB    X'04'      ; =0x04 =4
8c0c:      DC    'PARM'     ; hex:d0c1d2cd
8c10:      DB    X'00'      ; =0x00 =0 =NUL
8c11:      DW    X'1503'    ; =0x1503 =5379
8c13:      DC    'NAM'      ; hex:cec1cd
8c16:      DB    X'00'      ; =0x00 =0 =NUL
8c17:      DW    X'1603'    ; =0x1603 =5635
8c19:      DC    'CLR'      ; hex:c3ccd2
8c1c:      DB    X'00'      ; =0x00 =0 =NUL
8c1d:      DW    X'1703'    ; =0x1703 =5891
8c1f:      DC    'VOL'      ; hex:d6cfcc
8c22:      DW    X'0117'    ; =0x0117 =279
8c24:      DB    X'05'      ; =0x05 =5
8c25:      DC    'VSPEC'    ; hex:d6d3d0c5c3
8c2a:      DW    X'0104'    ; =0x0104 =260
8c2c:      DB    X'05'      ; =0x05 =5
8c2d:      DC    'START'    ; hex:d3d4c1d2d4
8c32:      DW    X'0604'    ; =0x0604 =1540
8c34:      DB    X'04'      ; =0x04 =4
8c35:      DC    'TIME'     ; hex:d4c9cdc5
8c39:      DW    X'0704'    ; =0x0704 =1796
8c3b:      DB    X'06'      ; =0x06 =6
8c3c:      DC    'NOTIME'   ; hex:cecfd4c9cdc5
8c42:      DW    X'0804'    ; =0x0804 =2052
8c44:      DB    X'04'      ; =0x04 =4
8c45:      DC    'DUMP'     ; hex:c4d5cdd0
8c49:      DW    X'0904'    ; =0x0904 =2308
8c4b:      DB    X'06'      ; =0x06 =6
8c4c:      DC    'NODUMP'   ; hex:cecfc4d5cdd0
8c52:      DW    X'0A04'    ; =0x0a04 =2564
8c54:      DB    X'05'      ; =0x05 =5
8c55:      DC    'MULTP'    ; hex:cdd5ccd4d0
8c5a:      DB    X'00'      ; =0x00 =0 =NUL
8c5b:      DW    X'1805'    ; =0x1805 =6149
8c5d:      DC    'PAUSE'    ; hex:d0c1d5d3c5
8c62:      DW    X'0118'    ; =0x0118 =280
8c64:      DB    X'05'      ; =0x05 =5
8c65:      DC    'ENTER'    ; hex:c5ced4c5d2
8c6a:      DW    X'0218'    ; =0x0218 =536
8c6c:      DB    X'05'      ; =0x05 =5
8c6d:      DC    'GUARD'    ; hex:c7d5c1d2c4
8c72:      DW    X'0318'    ; =0x0318 =792
8c74:      DB    X'07'      ; =0x07 =7
8c75:      DC    'NOGUARD'  ; hex:cecfc7d5c1d2c4
8c7c:      DB    X'00'      ; =0x00 =0 =NUL
8c7d:      DW    X'1905'    ; =0x1905 =6405
8c7f:      DC    'REORG'    ; hex:d2c5cfd2c7
8c84:      DW    X'0119'    ; =0x0119 =281
8c86:      DB    X'06'      ; =0x06 =6
8c87:      DC    'BACKUP'   ; hex:c2c1c3cbd5d0
8c8d:      DW    X'0219'    ; =0x0219 =537
8c8f:      DB    X'07'      ; =0x07 =7
8c90:      DC    'RESTORE'  ; hex:d2c5d3d4cfd2c5
8c97:      DW    X'0319'    ; =0x0319 =793
8c99:      DB    X'08'      ; =0x08 =8
8c9a:      DC    'COMPRESS' ; hex:c3cfcdd0d2c5d3d3
8ca2:      DW    X'0419'    ; =0x0419 =1049
8ca4:      DB    X'06'      ; =0x06 =6
8ca5:      DC    'EXPAND'   ; hex:c5d8d0c1cec4
8cab:      DB    X'00'      ; =0x00 =0 =NUL
8cac:      DW    X'1A04'    ; =0x1a04 =6660
8cae:      DC    'LOAD'     ; hex:cccfc1c4
8cb2:      DB    X'00'      ; =0x00 =0 =NUL
8cb3:      DW    X'0B06'    ; =0x0b06 =2822
8cb5:      DC    'FORMAT'   ; hex:c6cfd2cdc1d4
8cbb:      DB    X'00'      ; =0x00 =0 =NUL
8cbc:      DW    X'1B05'    ; =0x1b05 =6917
8cbe:      DC    'WIPLT'    ; hex:d7c9d0ccd4
8cc3:      DW    X'0110'    ; =0x0110 =272
8cc5:      DB    X'04'      ; =0x04 =4
8cc6:      DC    'CODE'     ; hex:c3cfc4c5
8cca:      DB    X'00'      ; =0x00 =0 =NUL
8ccb:      DW    X'2F06'    ; =0x2f06 =12038
8ccd:      DC    'REWIND'   ; hex:d2c5d7c9cec4
8cd3:      DW    X'012F'    ; =0x012f =303
8cd5:      DB    X'04'      ; =0x04 =4
8cd6:      DC    'WEOT'     ; hex:d7c5cfd4
8cda:      DW    X'022F'    ; =0x022f =559
8cdc:      DB    X'05'      ; =0x05 =5
8cdd:      DC    'RSKIP'    ; hex:d2d3cbc9d0
8ce2:      DB    X'FF'      ; =0xff =255(-1)
*
* Function F8CE3
*
8ce3:F8CE3 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8ce5:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8ce7:      XFR   Y,X        ; [Transfer Y to X]
8ce9:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8ceb:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
8ced:      XAY              ; [Transfer A to Y]
8cee:D8CEE DCX              ; [Decrement X]
8cef:      BM    D8D04      ; =+19 [Branch on minus]
8cf1:      LDAB+ Y          ; [Load AL from address in Y]
8cf2:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
8cf4:      SABB             ; [AL - BL -> BL]
8cf5:      BGZ   D8D00      ; =+9 [Branch if greater than zero]
8cf7:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
8cf9:      SABB             ; [AL - BL -> BL]
8cfa:      BM    D8D00      ; =+4 [Branch on minus]
8cfc:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
8cfe:      ADDB  BL,AL      ; [BL + AL -> AL]
8d00:D8D00 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8d02:      JMP   D8CEE      ; =-22 [Jump relative]
8d04:D8D04 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8d06:      XAY              ; [Transfer A to Y]
8d07:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8d09:      RSR              ; [Return from subroutine]
*
* Function F8D0A
*
8d0a:F8D0A STK   Y,2        ; [Push Y to the stack]
8d0c:      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
8d10:      INR   X,2        ; [Increment X by 2]
8d12:      DCA              ; [Decrement A]
8d13:      BP    D8D19      ; =+4 [Branch on plus]
8d15:      INR   X,2        ; [Increment X by 2]
8d17:      JMP   D8D2C      ; =+19 [Jump relative]
8d19:D8D19 FILR  =' ',-Y    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
8d1d:      INA              ; [Increment A]
8d1e:      SAB              ; [A - B -> B]
8d1f:      BLE   D8D24      ; =+3 [Branch if less than or equal to zero]
8d21:      SAB              ; [A - B -> B]
8d22:      XFR   B,A        ; [Transfer B to A]
8d24:D8D24 LDB+  X+         ; [Load B indexed, direct, post-incremented]
8d26:      DCA              ; [Decrement A]
8d27:      BM    D8D2C      ; =+3 [Branch on minus]
8d29:      MVFR  -B,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
8d2c:D8D2C POP   Y,2        ; [Pop Y from the stack]
8d2e:      RSR              ; [Return from subroutine]
*
8d2f:W8D2F FIL   (21)=' ',/S8D8C ; =0x8d8c =36236(-29300) =CR,FF [Fill with byte, literal=0xa0(160,-96), direct]
8d35:      LDAB+ Z          ; [Load AL from address in Z]
8d36:      JSR/  F826B      ; =0x826b =33387(-32149) [Jump to subroutine direct]
8d39:      BM    D8D87      ; =+76 [Branch on minus]
8d3b:      JSR/  F8FA2      ; =0x8fa2 =36770(-28766) [Jump to subroutine direct]
8d3e:      DW    S8D8C      ; =0x8d8c =36236(-29300) =CR,FF
8d40:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d43:      DC    'ON'       ; hex:cfce dec:53198(-50)
8d45:      DB    X'01'      ; =0x01 =1
8d46:      BNZ   D8D6F      ; =+39 [Branch if not zero]
8d48:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8d4a:      STAB  S8D6C      ; =+32 [Store AL relative]
8d4c:      CLA              ; [Clear A]
8d4d:      LDB/  W80B0+1    ; =0x80b1 =32945(-32591) [Load B direct]
8d50:      LDAB+ B,49       ; [Load AL indexed, displaced, direct]
8d53:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
8d55:      DW    S8D6D      ; =0x8d6d =36205(-29331) [address of end of string]
8d57:      XFR   Z,A        ; [Transfer Z to A]
8d59:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8d5b:      XFR=  S8D6C,Z    ; =0x8d6c =36204(-29332) [Transfer immediate to Z]
8d5f:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8d62:P8D62 JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8d65:      XAY              ; [Transfer A to Y]
8d66:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8d68:      XAZ              ; [Transfer A to Z]
8d69:      JMP   D8D72      ; =+7 [Jump relative]
*
8d6b:      DC    ' '        ; hex:a0 dec:160(-96)
8d6c:S8D6C DC    ' '        ; hex:a0 dec:160(-96)
8d6d:S8D6D DC    ' '        ; hex:a0 dec:160(-96)
8d6e:      DB    X'00'      ; =0x00 =0 =NUL
*
8d6f:D8D6F JSR*  P8D62+1    ; =-14 [Jump to subroutine relative indirect]
8d71:      XAY              ; [Transfer A to Y]
8d72:D8D72 STBB/ B8ED6+1    ; =0x8ed7 =36567(-28969) [Store BL direct]
8d75:      XFR   Z,A        ; [Transfer Z to A]
8d77:      STA/  W8EDF+2    ; =0x8ee1 =36577(-28959) [Store A direct]
8d7a:      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8d7d:      LDBB= X'04'      ; =4 [Load BL with immediate]
8d7f:      SABB             ; [AL - BL -> BL]
8d80:      BZ    D8DBF      ; =+61 [Branch if zero]
8d82:      LDBB= X'07'      ; =7 [Load BL with immediate]
8d84:      SABB             ; [AL - BL -> BL]
8d85:      BZ    D8DB9      ; =+50 [Branch if zero]
8d87:D8D87 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d8a:      DW    X'000A'    ; =0x000a =10
8d8c:S8D8C DC    '                     '
8da1:      DB    X'00'      ; =0x00 =0 =NUL
8da2:B8DA2 DB    X'00'      ; =0x00 =0 =NUL
8da3:B8DA3 DB    X'01'      ; =0x01 =1
8da4:B8DA4 DW    X'0101'    ; =0x0101 =257
8da6:B8DA6 DB    X'01'      ; =0x01 =1
*
8da7:D8DA7 LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
8daa:      DC    'P'        ; hex:d0 dec:208(-48)
8dab:      DW    S8D8C      ; =0x8d8c =36236(-29300) =CR,FF
8dad:      DW    X'660E'    ; =0x660e =26126
8daf:      DW    W8FC9      ; =0x8fc9 =36809(-28727)
8db1:      DW    X'1458'    ; =0x1458 =5208
8db3:      DC    '1'        ; hex:b1 dec:177(-79)
8db4:      DW    W8EAB+1    ; =0x8eac =36524(-29012)
8db6:      DB    X'71'      ; =0x71 =113
8db7:      DW    W8E36      ; =0x8e36 =36406(-29130)
*
8db9:D8DB9 CLA              ; [Clear A]
8dba:      STA/  W8EAB+1    ; =0x8eac =36524(-29012) [Store A direct]
8dbd:      JMP   D8DC3      ; =+4 [Jump relative]
8dbf:D8DBF LDAB= X'02'      ; =2 [Load AL with immediate]
8dc1:      STAB  B8DA2      ; =-33 [Store AL relative]
8dc3:D8DC3 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8dc5:      XFR/  X'0111',X  ; =0x0111 =273 [Transfer direct to X]
8dc9:      XFR/  X'010D',Z  ; =0x010d =269 [Transfer direct to Z]
8dcd:D8DCD LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8dcf:      BM    D8DFF      ; =+46 [Branch on minus]
8dd1:      LDBB/ B8ED6+1    ; =0x8ed7 =36567(-28969) [Load BL direct]
8dd4:      SABB             ; [AL - BL -> BL]
8dd5:      BNZ   D8DFF      ; =+40 [Branch if not zero]
8dd7:      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8dda:      LDBB= X'07'      ; =7 [Load BL with immediate]
8ddc:      SABB             ; [AL - BL -> BL]
8ddd:      BZ    D8E06      ; =+39 [Branch if zero]
8ddf:      LDA+  Z          ; [Load A from address in Z]
8de0:      INA              ; [Increment A]
8de1:      BM    D8DFF      ; =+28 [Branch on minus]
8de3:      DCA              ; [Decrement A]
8de4:      LDA+  A          ; [Load A from address in A]
8de5:      LDB=  S8D8C      ; =0x8d8c =36236(-29300) =CR,FF [Load B with immediate]
8de8:      CPF   (21)-A,9,-B ; [Compare fixed-length, displaced indexed, indexed]
8dee:      BNZ   D8DFF      ; =+15 [Branch if not zero]
8df0:      LDA+  Z          ; [Load A from address in Z]
8df1:      LDAB+ A,3        ; [Load AL indexed, displaced, direct]
8df4:      LDBB= X'04'      ; =4 [Load BL with immediate]
8df6:      NABB             ; [AL & BL -> BL]
8df7:      BZ    D8E06      ; =+13 [Branch if zero]
8df9:      LDAB  B8DA4      ; =-87 [Load AL relative]
8dfb:      BZ    D8E06      ; =+9 [Branch if zero]
8dfd:      JMP   D8E10      ; =+17 [Jump relative]
8dff:D8DFF LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8e01:      DCX              ; [Decrement X]
8e02:      BM    D8DA7      ; =-93 [Branch on minus]
8e04:      JMP   D8DCD      ; =-57 [Jump relative]
8e06:D8E06 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e09:      DW    X'000C'    ; =0x000c =12
8e0b:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e0e:      DW    X'000D'    ; =0x000d =13
*
8e10:D8E10 SVC   X'16'      ; =22 [Service call GMEM - get memory block from transient area]
8e12:      DW    X'0008'    ; =0x0008 =8 [TODO: arg1] [TODO: arg2]
8e14:W8E14 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e16:      LDX/  W8E14      ; =0x8e14 =36372(-29164) [Load X direct]
8e19:      STX/  W8EAB+1    ; =0x8eac =36524(-29012) [Store X direct]
8e1c:      CLA              ; [Clear A]
8e1d:      STA+  X,4        ; [Store A indexed, displaced, direct]
8e20:      STA+  X,6        ; [Store A indexed, displaced, direct]
8e23:      STAB+ X,3        ; [Store AL indexed, displaced, direct]
8e26:      LDA/  X'0103'    ; =0x0103 =259 [Load A direct]
8e29:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
8e2c:      STAB+ X,2        ; [Store AL indexed, displaced, direct]
8e2f:      LDA+  Z          ; [Load A from address in Z]
8e30:      LDA+  A          ; [Load A from address in A]
8e31:      STA+  X          ; [Store A to address in X]
8e32:      LDBB+ A          ; [Load BL from address in A]
8e33:      INRB  BL         ; [Increment BL by 1]
8e35:      STBB+ A          ; [Store BL to address in A]
8e36:W8E36 LDA/  W8EAB+1    ; =0x8eac =36524(-29012) [Load A direct]
8e39:      BZ    D8E5A      ; =+31 [Branch if zero]
8e3b:      LDA+  A          ; [Load A from address in A]
8e3c:      LDAB+ A,5        ; [Load AL indexed, displaced, direct]
8e3f:      LDBB= X'0F'      ; =15 [Load BL with immediate]
8e41:      NABB             ; [AL & BL -> BL]
8e42:      LDAB/ B8DA3      ; =0x8da3 =36259(-29277) =CR,'#' [Load AL direct]
8e45:      BZ    D8E57      ; =+16 [Branch if zero]
8e47:      LDAB/ B8DA2      ; =0x8da2 =36258(-29278) =CR,'"' [Load AL direct]
8e4a:      SABB             ; [AL - BL -> BL]
8e4b:      BZ    D8E57      ; =+10 [Branch if zero]
8e4d:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e50:      DW    X'000E'    ; =0x000e =14
8e52:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e55:      DW    X'000D'    ; =0x000d =13
*
8e57:D8E57 STBB/ B8DA2      ; =0x8da2 =36258(-29278) =CR,'"' [Store BL direct]
8e5a:D8E5A LDX+  S+         ; [Load X indexed, direct, post-incremented]
8e5c:      LDA/  W80B0+1    ; =0x80b1 =32945(-32591) [Load A direct]
8e5f:      LDAB+ *A,4       ; [Load AL indexed, displaced, indirect]
8e62:      BM    D8E68      ; =+4 [Branch on minus]
8e64:      JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8e67:      DB    X'0A'      ; =0x0a =10
*
8e68:D8E68 CLA              ; [Clear A]
8e69:      XFR/  W80B0+1,Z  ; =0x80b1 =32945(-32591) [Transfer direct to Z]
8e6d:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8e6f:      LDX+  Z,4        ; [Load X indexed, displaced, direct]
8e72:      XAB              ; [Transfer A to B]
8e73:      SLA              ; [Left shift A]
8e74:      AAB              ; [A + B -> B]
8e75:      ADD   B,X        ; [B + X -> X]
8e77:      XFR/  X'005A',Z  ; =0x005a =90 [Transfer direct to Z]
8e7b:      CLA              ; [Clear A]
8e7c:      LDAB+ X          ; [Load AL from address in X]
8e7d:      BM    D8E97      ; =+24 [Branch on minus]
8e7f:      LDB+  Z,9        ; [Load B indexed, displaced, direct]
8e82:      SLA              ; [Left shift A]
8e83:      AAB              ; [A + B -> B]
8e84:      LDB+  B          ; [Load B from address in B]
8e85:      LDA+  B          ; [Load A from address in B]
8e86:      LDAB= X'10'      ; =16 [Load AL with immediate]
8e88:      ANDB  AU,AL      ; [AU & AL -> AL]
8e8a:      BNZ   D8E92      ; =+6 [Branch if not zero]
8e8c:      LDAB= X'04'      ; =4 [Load AL with immediate]
8e8e:      ANDB  AU,AL      ; [AU & AL -> AL]
8e90:      BNZ   D8E97      ; =+5 [Branch if not zero]
8e92:D8E92 LDAB= X'DF'      ; =223(-33) =DEL [Load AL with immediate]
8e94:      ANDB  AU,AL      ; [AU & AL -> AL]
8e96:      STAB+ B          ; [Store AL to address in B]
8e97:D8E97 LDA+  X,1        ; [Load A indexed, displaced, direct]
8e9a:      INA              ; [Increment A]
8e9b:      BZ    D8EA4      ; =+7 [Branch if zero]
8e9d:      DCA              ; [Decrement A]
8e9e:      STA   W8EA2      ; =+2 [Store A relative]
8ea0:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8ea2:W8EA2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8ea4:D8EA4 STX   W8ED0+1    ; =+43 [Store X relative]
8ea6:      CLA              ; [Clear A]
8ea7:      DCA              ; [Decrement A]
8ea8:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
8eaa:      STA+  X          ; [Store A to address in X]
8eab:W8EAB LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
8eae:      BZ    D8ED9      ; =+41 [Branch if zero]
8eb0:      LDAB+ Y          ; [Load AL from address in Y]
8eb1:      LDBB= X'03'      ; =3 [Load BL with immediate]
8eb3:      NABB             ; [AL & BL -> BL]
8eb4:      LDAB/ B8DA4      ; =0x8da4 =36260(-29276) =CR,'$' [Load AL direct]
8eb7:      BZ    D8EBD      ; =+4 [Branch if zero]
8eb9:      LDAB= X'04'      ; =4 [Load AL with immediate]
8ebb:      ORIB  AL,BL      ; [AL | BL -> BL]
8ebd:D8EBD LDAB/ B8DA6      ; =0x8da6 =36262(-29274) =CR,'&' [Load AL direct]
8ec0:      BZ    D8EC6      ; =+4 [Branch if zero]
8ec2:      LDAB= X'10'      ; =16 [Load AL with immediate]
8ec4:      ORIB  AL,BL      ; [AL | BL -> BL]
8ec6:D8EC6 STBB+ X,3        ; [Store BL indexed, displaced, direct]
8ec9:      LDAB= X'7E'      ; =126 [Load AL with immediate]
8ecb:      STAB+ X,-1       ; [Store AL indexed, displaced, direct]
8ece:      XFR   X,A        ; [Transfer X to A]
8ed0:W8ED0 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
8ed3:      STA+  X,1        ; [Store A indexed, displaced, direct]
8ed6:B8ED6 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8ed8:      STAB+ X          ; [Store AL to address in X]
8ed9:D8ED9 LDAB+ Y          ; [Load AL from address in Y]
8eda:      LDBB= X'20'      ; =32 [Load BL with immediate]
8edc:      ORIB  AL,BL      ; [AL | BL -> BL]
8ede:      STBB+ Y          ; [Store BL to address in Y]
8edf:W8EDF XFR=  X'0000',Z  ; =0x0000 =0 =NUL,NUL [Transfer immediate to Z]
8ee3:      XFR/  W80B0+1,Y  ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8ee7:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8eea:      LDA+  A,66       ; [Load A indexed, displaced, direct]
8eed:      STA+  Y,52       ; [Store A indexed, displaced, direct]
8ef0:      LDBB+ Y          ; [Load BL from address in Y]
8ef1:      LDAB= X'EF'      ; =239(-17) ='o' [Load AL with immediate]
8ef3:      NABB             ; [AL & BL -> BL]
8ef4:      STBB+ Y          ; [Store BL to address in Y]
8ef5:      JSR   F8F10      ; =+25 [Jump to subroutine relative]
8ef7:      LDA/  W8EAB+1    ; =0x8eac =36524(-29012) [Load A direct]
8efa:      BZ    D8F06      ; =+10 [Branch if zero]
8efc:      LDB=  W85E8      ; =0x85e8 =34280(-31256) [Load B with immediate]
8eff:      JSR/  F84D0      ; =0x84d0 =34000(-31536) =EOT,'P' [Jump to subroutine direct]
8f02:      DB    X'09'      ; =0x09 =9
8f03:      JMP/  D8148      ; =0x8148 =33096(-32440) [Jump direct]
8f06:D8F06 LDB=  W8606      ; =0x8606 =34310(-31226) [Load B with immediate]
8f09:      JSR/  F84D0      ; =0x84d0 =34000(-31536) =EOT,'P' [Jump to subroutine direct]
8f0c:      DB    X'09'      ; =0x09 =9
8f0d:      JMP/  D8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8F10
*
8f10:F8F10 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8f12:      CLR   X          ; [Clear X]
8f14:D8F14 LDAB+ Z          ; [Load AL from address in Z]
8f15:      BNZ   D8F1A      ; =+3 [Branch if not zero]
8f17:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8f19:      RSR              ; [Return from subroutine]
*
8f1a:D8F1A JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f1d:      BM    D8F3A      ; =+27 [Branch on minus]
8f1f:      XFR   Z,A        ; [Transfer Z to A]
8f21:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f23:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8f26:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f28:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f2b:      DC    '='        ; hex:bd dec:189(-67)
8f2c:      DB    X'01'      ; =0x01 =1
8f2d:      BNZ   D8F36      ; =+7 [Branch if not zero]
8f2f:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f31:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f33:      XAZ              ; [Transfer A to Z]
8f34:      JMP   D8F3A      ; =+4 [Jump relative]
8f36:D8F36 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8f38:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f3a:D8F3A XFR   X,A        ; [Transfer X to A]
8f3c:      INX              ; [Increment X]
8f3d:      CLRB  AU         ; [Clear AU]
8f3f:      XABB             ; [Transfer AL to BL]
8f40:      BM    D8F48      ; =+6 [Branch on minus]
8f42:      LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8f45:      SABB             ; [AL - BL -> BL]
8f46:      BM    D8F4D      ; =+5 [Branch on minus]
8f48:D8F48 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f4b:      DW    X'001C'    ; =0x001c =28
*
8f4d:D8F4D XAB              ; [Transfer A to B]
8f4e:      MUL=  X'000A',B  ; =0x000a =10 [10 * B -> B]
8f52:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8f55:      AAB              ; [A + B -> B]
8f56:      STB   W8F71      ; =+25 [Store B relative]
8f58:      STB   W8F92      ; =+56 [Store B relative]
8f5a:      LDAB+ Z          ; [Load AL from address in Z]
8f5b:      BZ    D8F73      ; =+22 [Branch if zero]
8f5d:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
8f5f:      SABB             ; [AL - BL -> BL]
8f60:      BZ    D8F7A      ; =+24 [Branch if zero]
8f62:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8f64:      SABB             ; [AL - BL -> BL]
8f65:      BZ    D8F7A      ; =+19 [Branch if zero]
8f67:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f6a:      DC    ','        ; hex:ac dec:172(-84)
8f6b:      DB    X'01'      ; =0x01 =1
8f6c:      BNZ   D8F78      ; =+10 [Branch if not zero]
8f6e:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8f71:W8F71 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8f73:D8F73 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f76:      DC    ','        ; hex:ac dec:172(-84)
8f77:      DB    X'01'      ; =0x01 =1
*
8f78:D8F78 JMP   D8F14      ; =-102 [Jump relative]
8f7a:D8F7A INR   Z          ; [Increment Z by 1]
8f7c:      STR/  W8F94,Z    ; =0x8f94 =36756(-28780) [Store Z direct]
8f80:D8F80 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8f82:      BNZ   D8F9B      ; =+23 [Branch if not zero]
8f84:      DCR   Z          ; [Decrement Z by 1]
8f86:      CLA              ; [Clear A]
8f87:D8F87 LDB   W8F94      ; =+11 [Load B relative]
8f89:      AAB              ; [A + B -> B]
8f8a:      SUB   Z,B        ; [Z - B -> B]
8f8c:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8f8f:      JSR/  F8D0A      ; =0x8d0a =36106(-29430) [Jump to subroutine direct]
8f92:W8F92 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8f94:W8F94 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8f96:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8f99:      JMP   D8F73      ; =-40 [Jump relative]
8f9b:D8F9B SABB             ; [AL - BL -> BL]
8f9c:      BNZ   D8F80      ; =-30 [Branch if not zero]
8f9e:      CLA              ; [Clear A]
8f9f:      INA              ; [Increment A]
8fa0:      JMP   D8F87      ; =-27 [Jump relative]
*
* Function F8FA2
*
8fa2:F8FA2 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8fa4:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8fa6:      XAX              ; [Transfer A to X]
8fa7:D8FA7 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8fa9:      BZ    D8FC1      ; =+22 [Branch if zero]
8fab:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8fad:      SABB             ; [AL - BL -> BL]
8fae:      BZ    D8FC1      ; =+17 [Branch if zero]
8fb0:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8fb2:      SABB             ; [AL - BL -> BL]
8fb3:      BZ    D8FC3      ; =+14 [Branch if zero]
8fb5:      LDBB+ X          ; [Load BL from address in X]
8fb6:      BNZ   D8FBD      ; =+5 [Branch if not zero]
8fb8:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8fbb:      DW    X'000B'    ; =0x000b =11
*
8fbd:D8FBD STAB+ X+         ; [Store AL indexed, direct, post-incremented]
8fbf:      JMP   D8FA7      ; =-26 [Jump relative]
8fc1:D8FC1 DCR   Z          ; [Decrement Z by 1]
8fc3:D8FC3 JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8fc6:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8fc8:      RSR              ; [Return from subroutine]
*
8fc9:W8FC9 DS    400        ; =0x0190 [Uninitialized memory]
9159:      DB    X'00'      ; =0x00 =0 =NUL
915a:ENDPT
