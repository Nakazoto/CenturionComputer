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
8000:W8000 DW    W8002      ; =0x8002 =32770(-32766)
8002:W8002 DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8004:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8006:W8006 DS    135        ; =0x0087 [Uninitialized memory]
808d:W808D DS    1          ; =0x0001 [Uninitialized memory]
808e:B808E DS    1          ; =0x0001 [Uninitialized memory]
808f:B808F DS    2          ; =0x0002 [Uninitialized memory]
8091:W8091 DS    131        ; =0x0083 [Uninitialized memory]
*
* Function ENTRY
*
8114:ENTRY XFR   S,A        ; [Transfer S to A]
8116:      STA/  W8400+1    ; =0x8401 =33793(-31743) [Store A direct]
8119:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
811c:      LDA+  A,3        ; [Load A indexed, displaced, direct]
811f:W811F STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8122:      LDB=  W8000      ; =0x8000 =32768(-32768) [Load B with immediate]
8125:      STB+  A,25       ; [Store B indexed, displaced, direct]
8128:      LDAB+ A,21       ; [Load AL indexed, displaced, direct]
812b:      BZ    D8133      ; =+6 [Branch if zero]
812d:      LDA=  X'0081'    ; =0x0081 =129 [Load A with immediate]
8130:      STAB/ B8433      ; =0x8433 =33843(-31693) [Store AL direct]
8133:D8133 JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
8136:      DW    W848C      ; =0x848c =33932(-31604) =EOT,FF
8138:      LDB=  W846E      ; =0x846e =33902(-31634) [Load B with immediate]
813b:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
813e:      DB    X'0C'      ; =0x0c =12 [Service call PGIOB - protected get I/O block]
813f:      XAX              ; [Transfer A to X]
8140:      XFR   B,Y        ; [Transfer B to Y]
8142:      LDAB+ Y,14       ; [Load AL indexed, displaced, direct]
8145:      LDBB= X'40'      ; =64 [Load BL with immediate]
8147:      NABB             ; [AL & BL -> BL]
8148:      BZ    D8161      ; =+23 [Branch if zero]
814a:      LDA+  Y,12       ; [Load A indexed, displaced, direct]
814d:      LDB=  X'18B0'    ; =0x18b0 =6320 [Load B with immediate]
8150:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8153:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
8154:      XFR   A,A        ; [Transfer A to A]
8156:      BZ    D815D      ; =+5 [Branch if zero]
8158:D8158 JSR/  F83D1      ; =0x83d1 =33745(-31791) [Jump to subroutine direct]
815b:      DW    W84D7      ; =0x84d7 =34007(-31529) =EOT,'W'
*
815d:D815D XFR   B,A        ; [Transfer B to A]
815f:      JMP   D8164      ; =+3 [Jump relative]
8161:D8161 LDA+  Y,12       ; [Load A indexed, displaced, direct]
8164:D8164 STA/  W93F9      ; =0x93f9 =37881(-27655) [Store A direct]
8167:      SLA              ; [Left shift A]
8168:      SLA              ; [Left shift A]
8169:      SLA              ; [Left shift A]
816a:      SLA              ; [Left shift A]
816b:      LDB+  Y,8        ; [Load B indexed, displaced, direct]
816e:      STB/  W8D00      ; =0x8d00 =36096(-29440) =CR,NUL [Store B direct]
8171:      AAB              ; [A + B -> B]
8172:      STB/  W8DBB+1    ; =0x8dbc =36284(-29252) =CR,'<' [Store B direct]
8175:      LDAB+ Y,7        ; [Load AL indexed, displaced, direct]
8178:      LDBB= X'03'      ; =3 [Load BL with immediate]
817a:      NABB             ; [AL & BL -> BL]
817b:      BNZ   D8158      ; =-37 [Branch if not zero]
817d:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
8180:      STAB/ B82AE+1    ; =0x82af =33455(-32081) [Store AL direct]
8183:      LDB+  Y,15       ; [Load B indexed, displaced, direct]
8186:      STB   W8191      ; =+9 [Store B relative]
8188:      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
818b:      ADD   Y,B        ; [Y + B -> B]
818d:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8190:      DB    X'0D'      ; =0x0d =13 [Service call JXM - protected change to JX map]
8191:W8191 HLT              ; [Halt]
8192:      HLT              ; [Halt]
8193:      DW    W86C8      ; =0x86c8 =34504(-31032)
*
8195:      BZ    D81A0      ; =+9 [Branch if zero]
8197:      STA/  W836C+1    ; =0x836d =33645(-31891) [Store A direct]
819a:      LDA+  A,14       ; [Load A indexed, displaced, direct]
819d:      STA/  W898A+1    ; =0x898b =35211(-30325) [Store A direct]
81a0:D81A0 LDA/  X'005A'    ; =0x005a =90 [Load A direct]
81a3:      XAZ              ; [Transfer A to Z]
81a4:      CLA              ; [Clear A]
81a5:      LDAB+ Z,19       ; [Load AL indexed, displaced, direct]
81a8:      BP    D81AF      ; =+5 [Branch on plus]
81aa:      JSR/  F83D1      ; =0x83d1 =33745(-31791) [Jump to subroutine direct]
81ad:      DW    W84F0      ; =0x84f0 =34032(-31504) =EOT,'p'
*
81af:D81AF LDB+  Z,15       ; [Load B indexed, displaced, direct]
81b2:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
81b4:      SLA              ; [Left shift A]
81b5:      AAB              ; [A + B -> B]
81b6:      LDB+  B          ; [Load B from address in B]
81b7:      LDAB+ B          ; [Load AL from address in B]
81b8:      STAB+ Z,19       ; [Store AL indexed, displaced, direct]
81bb:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
81bd:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
81bf:      LDA=  X'0010'    ; =0x0010 =16 [Load A with immediate]
81c2:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
81c5:      DB    X'00'      ; =0x00 =0 =NUL
81c6:      LDA=  S8533      ; =0x8533 =34099(-31437) [Load A with immediate]
81c9:      XAZ              ; [Transfer A to Z]
81ca:      JSR/  F96E2      ; =0x96e2 =38626(-26910) [Jump to subroutine direct]
81cd:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
81cf:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
81d2:      XAZ              ; [Transfer A to Z]
81d3:      LDA+  Z,3        ; [Load A indexed, displaced, direct]
81d6:      XAY              ; [Transfer A to Y]
81d7:      CLA              ; [Clear A]
81d8:      LDAB+ Y,6        ; [Load AL indexed, displaced, direct]
81db:      LDBB/ B8DF7      ; =0x8df7 =36343(-29193) =CR,'w' [Load BL direct]
81de:      ADDB  BL,AL      ; [BL + AL -> AL]
81e0:      SLA              ; [Left shift A]
81e1:      LDB+  Y,4        ; [Load B indexed, displaced, direct]
81e4:      AAB              ; [A + B -> B]
81e5:      LDAB+ B          ; [Load AL from address in B]
81e6:      BM    D81ED      ; =+5 [Branch on minus]
81e8:      JSR/  F83D1      ; =0x83d1 =33745(-31791) [Jump to subroutine direct]
81eb:      DW    W8506      ; =0x8506 =34054(-31482)
*
81ed:D81ED LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
81ef:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
81f1:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
81f3:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
81f5:J81F5 JSR/  F8407      ; =0x8407 =33799(-31737) [Jump to subroutine direct]
81f8:      JSR/  F991E      ; =0x991e =39198(-26338) [Jump to subroutine direct]
81fb:      DW    W808D      ; =0x808d =32909(-32627)
*
81fd:      JSR/  F94FD      ; =0x94fd =38141(-27395) [Jump to subroutine direct]
8200:      DW    W808D      ; =0x808d =32909(-32627)
8202:      DW    W8006      ; =0x8006 =32774(-32762)
8204:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
8207:      DW    W8006      ; =0x8006 =32774(-32762)
8209:      LDB=  W8006      ; =0x8006 =32774(-32762) [Load B with immediate]
820c:      LDA+  B          ; [Load A from address in B]
820d:      DCA              ; [Decrement A]
820e:      STA+  B+         ; [Store A indexed, direct, post-incremented]
8210:      XFR   B,Z        ; [Transfer B to Z]
8212:      AAB              ; [A + B -> B]
8213:      CLAB             ; [Clear AL]
8214:      STAB+ B          ; [Store AL to address in B]
8215:      JSR/  F962B      ; =0x962b =38443(-27093) [Jump to subroutine direct]
8218:      LDAB+ Z          ; [Load AL from address in Z]
8219:      BZ    J81F5      ; =-38 [Branch if zero]
821b:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
821d:      SABB             ; [AL - BL -> BL]
821e:      BZ    J81F5      ; =-43 [Branch if zero]
8220:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
8223:      BP    D822A      ; =+5 [Branch on plus]
8225:D8225 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8228:      DW    W849C      ; =0x849c =33948(-31588)
*
822a:D822A JSR/  F9635      ; =0x9635 =38453(-27083) [Jump to subroutine direct]
822d:      STA   W824E      ; =+31 [Store A relative]
822f:      STB   W824C      ; =+27 [Store B relative]
8231:      LDA=  W885E      ; =0x885e =34910(-30626) [Load A with immediate]
8234:      XAY              ; [Transfer A to Y]
8235:D8235 INR   Y          ; [Increment Y by 1]
8237:      INR   Y          ; [Increment Y by 1]
8239:      CLA              ; [Clear A]
823a:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
823c:      BM    D8225      ; =-25 [Branch on minus]
823e:      XFR   Y,B        ; [Transfer Y to B]
8240:      STB   W8250      ; =+14 [Store B relative]
8242:      ADD   A,Y        ; [A + Y -> Y]
8244:      LDB   W824C      ; =+6 [Load B relative]
8246:      SAB              ; [A - B -> B]
8247:      BNZ   D8235      ; =-20 [Branch if not zero]
8249:      JSR/  F98EF      ; =0x98ef =39151(-26385) [Jump to subroutine direct]
824c:W824C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
824e:W824E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8250:W8250 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8252:      XFRB  BL,BL      ; [Transfer BL to BL]
8254:      BNZ   D8235      ; =-33 [Branch if not zero]
8256:      JMP+  *Y         ; [Jump indexed, indirect]
8258:W8258 LDA=  X'18BB'    ; =0x18bb =6331 [Load A with immediate]
825b:      STA/  S852C      ; =0x852c =34092(-31444) [Store A direct]
825e:      CLA              ; [Clear A]
825f:      STA/  W8313+1    ; =0x8314 =33556(-31980) [Store A direct]
8262:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8265:      DC    ','        ; hex:ac dec:172(-84)
8266:      NOP              ; [No operation]
8267:      LDAB+ Z          ; [Load AL from address in Z]
8268:      BZ    D82A7      ; =+61 [Branch if zero]
826a:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
826d:      DC    'DSIZE='   ; hex:c4d3c9dac5bd
8273:      DB    X'01'      ; =0x01 =1
8274:      BNZ   D827B      ; =+5 [Branch if not zero]
8276:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8279:      DW    W849C      ; =0x849c =33948(-31588)
*
827b:D827B JSR/  F8388      ; =0x8388 =33672(-31864) [Jump to subroutine direct]
827e:      LDA/  S852C      ; =0x852c =34092(-31444) [Load A direct]
8281:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
8284:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8287:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
8288:      XFR   A,A        ; [Transfer A to A]
828a:      BZ    D828E      ; =+2 [Branch if zero]
828c:      INR   B          ; [Increment B by 1]
828e:D828E LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
8291:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8294:      DB    X'2B'      ; =0x2b =43 [Service call MUL16 - 16-bit multiply]
8295:      XFR   A,A        ; [Transfer A to A]
8297:      BZ    D829C      ; =+3 [Branch if zero]
8299:D8299 JMP/  J83C8      ; =0x83c8 =33736(-31800) [Jump direct]
829c:D829C LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
829f:      AAB              ; [A + B -> B]
82a0:      STB/  S852C      ; =0x852c =34092(-31444) [Store B direct]
82a3:      BM    D8299      ; =-12 [Branch on minus]
82a5:      BL    D8299      ; =-14 [Branch on link]
82a7:D82A7 JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
82aa:      DB    X'0B'      ; =0x0b =11 [Service call DT - get binary date]
82ab:      STA/  W8531      ; =0x8531 =34097(-31439) [Store A direct]
82ae:B82AE LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
82b0:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
82b3:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
82b5:      STBB/ B8529      ; =0x8529 =34089(-31447) [Store BL direct]
82b8:      LDA/  W8D00      ; =0x8d00 =36096(-29440) =CR,NUL [Load A direct]
82bb:      STA/  W83ED      ; =0x83ed =33773(-31763) [Store A direct]
82be:      STA/  W852A      ; =0x852a =34090(-31446) [Store A direct]
82c1:      CLA              ; [Clear A]
82c2:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
82c5:      LDX=  X'00C8'    ; =0x00c8 =200 =NUL,'H' [Load X with immediate]
82c8:D82C8 STA+  B+         ; [Store A indexed, direct, post-incremented]
82ca:      DCX              ; [Decrement X]
82cb:      BGZ   D82C8      ; =-5 [Branch if greater than zero]
82cd:      JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
82d0:      DW    X'001B'    ; =0x001b =27
82d2:      DW    W86CD      ; =0x86cd =34509(-31027)
82d4:      DW    W8518      ; =0x8518 =34072(-31464)
*
82d6:D82D6 LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
82d9:      STA/  W83EA      ; =0x83ea =33770(-31766) [Store A direct]
82dc:      LDB=  W885B      ; =0x885b =34907(-30629) [Load B with immediate]
82df:      JSR/  F83E0      ; =0x83e0 =33760(-31776) [Jump to subroutine direct]
82e2:      DB    X'01'      ; =0x01 =1
82e3:      LDA/  W885C      ; =0x885c =34908(-30628) [Load A direct]
82e6:      STA/  W86C9      ; =0x86c9 =34505(-31031) [Store A direct]
82e9:      LDA/  W885E      ; =0x885e =34910(-30626) [Load A direct]
82ec:      STA/  W86CB      ; =0x86cb =34507(-31029) [Store A direct]
82ef:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
82f2:      STA/  W83EA      ; =0x83ea =33770(-31766) [Store A direct]
82f5:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
82f8:      JSR/  F83E0      ; =0x83e0 =33760(-31776) [Jump to subroutine direct]
82fb:      DB    X'02'      ; =0x02 =2
82fc:      LDA/  W86C9      ; =0x86c9 =34505(-31031) [Load A direct]
82ff:      STA/  W83ED      ; =0x83ed =33773(-31763) [Store A direct]
8302:      BP    D8306      ; =+2 [Branch on plus]
8304:      JMP   D8299      ; =-109 [Jump relative]
8306:D8306 CLA              ; [Clear A]
8307:      STAB/ W86CD      ; =0x86cd =34509(-31027) [Store AL direct]
830a:      STA/  W86D8      ; =0x86d8 =34520(-31016) [Store A direct]
830d:      STA/  W86DF      ; =0x86df =34527(-31009) [Store A direct]
8310:      STA/  W86E1      ; =0x86e1 =34529(-31007) [Store A direct]
8313:W8313 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8316:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
8319:      AAB              ; [A + B -> B]
831a:      STB   W8313+1    ; =-8 [Store B relative]
831c:      LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
831f:      AAB              ; [A + B -> B]
8320:      LDA/  S852C      ; =0x852c =34092(-31444) [Load A direct]
8323:      SAB              ; [A - B -> B]
8324:      BGZ   D82D6      ; =-80 [Branch if greater than zero]
8326:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
8328:      STAB/ W86CD      ; =0x86cd =34509(-31027) [Store AL direct]
832b:      LDB=  W885B      ; =0x885b =34907(-30629) [Load B with immediate]
832e:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
8331:      STA/  W83EA      ; =0x83ea =33770(-31766) [Store A direct]
8334:      JSR/  F83E0      ; =0x83e0 =33760(-31776) [Jump to subroutine direct]
8337:      DB    X'01'      ; =0x01 =1
8338:      LDA/  W885C      ; =0x885c =34908(-30628) [Load A direct]
833b:      STA/  W86C9      ; =0x86c9 =34505(-31031) [Store A direct]
833e:      LDA/  W885E      ; =0x885e =34910(-30626) [Load A direct]
8341:      STA/  W86CB      ; =0x86cb =34507(-31029) [Store A direct]
8344:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
8347:      STA/  W83EA      ; =0x83ea =33770(-31766) [Store A direct]
834a:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
834d:      JSR/  F83E0      ; =0x83e0 =33760(-31776) [Jump to subroutine direct]
8350:      DB    X'02'      ; =0x02 =2
8351:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
8354:W8354 LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
8357:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
835a:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
835d:      DB    X'06'      ; =0x06 =6 [Service call FLWT - wait for flag to go positive]
835e:      DB    X'1C'      ; =0x1c =28 [TODO: arg 1]
835f:      LDA/  W8191      ; =0x8191 =33169(-32367) [Load A direct]
8362:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
8365:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8368:      DB    X'01'      ; =0x01 =1
8369:      LDA/  W898A+1    ; =0x898b =35211(-30325) [Load A direct]
836c:W836C LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
836f:      STA+  B,14       ; [Store A indexed, displaced, direct]
8372:      JSR/  F83E2      ; =0x83e2 =33762(-31774) [Jump to subroutine direct]
8375:      DB    X'02'      ; =0x02 =2
8376:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8379:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
837b:      STBB+ A,28       ; [Store BL indexed, displaced, direct]
837e:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
8381:      DW    W84B6      ; =0x84b6 =33974(-31562) =EOT,'6'
8383:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8386:      DB    X'0A'      ; =0x0a =10 [Service call EXIT - exit to OJX00]
8387:B8387 DB    X'00'      ; =0x00 =0 =NUL [completion code]
*
*
* Function F8388
*
8388:F8388 JSR/  F964D      ; =0x964d =38477(-27059) [Jump to subroutine direct]
838b:      STA/  S852C      ; =0x852c =34092(-31444) [Store A direct]
838e:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8391:      DC    'T'        ; hex:d4 dec:212(-44)
8392:      DB    X'01'      ; =0x01 =1
8393:      BZ    D839A      ; =+5 [Branch if zero]
8395:D8395 LDA=  X'18B0'    ; =0x18b0 =6320 [Load A with immediate]
8398:      JMP   D83BC      ; =+34 [Jump relative]
839a:D839A JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
839d:      DC    'S'        ; hex:d3 dec:211(-45)
839e:      DB    X'01'      ; =0x01 =1
839f:      BZ    D83A6      ; =+5 [Branch if zero]
83a1:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
83a4:      JMP   D83BC      ; =+22 [Jump relative]
83a6:D83A6 JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
83a9:      DC    'E'        ; hex:c5 dec:197(-59)
83aa:      DB    X'01'      ; =0x01 =1
83ab:      BZ    D83B2      ; =+5 [Branch if zero]
83ad:      LDA=  X'0010'    ; =0x0010 =16 [Load A with immediate]
83b0:      JMP   D83BC      ; =+10 [Jump relative]
83b2:D83B2 JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
83b5:      DC    'B'        ; hex:c2 dec:194(-62)
83b6:      DB    X'01'      ; =0x01 =1
83b7:      BZ    D8395      ; =-36 [Branch if zero]
83b9:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
83bc:D83BC LDB/  S852C      ; =0x852c =34092(-31444) [Load B direct]
83bf:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
83c2:      DB    X'2B'      ; =0x2b =43 [Service call MUL16 - 16-bit multiply]
83c3:      STB/  S852C      ; =0x852c =34092(-31444) [Store B direct]
83c6:      BP    D83CC      ; =+4 [Branch on plus]
83c8:J83C8 JSR   W83F3      ; =+41 [Jump to subroutine relative]
83ca:      DW    W84C1      ; =0x84c1 =33985(-31551) =EOT,'A'
*
83cc:D83CC XFR   A,A        ; [Transfer A to A]
83ce:      BNZ   J83C8      ; =-8 [Branch if not zero]
83d0:      RSR              ; [Return from subroutine]
*
* Function F83D1
*
83d1:F83D1 LDA+  X+         ; [Load A indexed, direct, post-incremented]
83d3:      STA   W83D7      ; =+2 [Store A relative]
83d5:      JSR   F8414      ; =+61 [Jump to subroutine relative]
83d7:W83D7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83d9:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
83dc:      DB    X'0A'      ; =0x0a =10 [Service call EXIT - exit to OJX00]
83dd:      DB    X'64'      ; =0x64 =100 [completion code]
*
*
* Function F83DE
*
83de:F83DE STA   W83ED      ; =+13 [Store A relative]
*
* Function F83E0
*
83e0:F83E0 STB   W83EF      ; =+13 [Store B relative]
*
* Function F83E2
*
83e2:F83E2 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
83e4:      STAB  B83F1      ; =+11 [Store AL relative]
83e6:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
83e9:      DB    X'15'      ; =0x15 =21 [Service call GBR - get binary time into A and B registers]
83ea:W83EA DW    X'0190'    ; =0x0190 =400 [TODO: arg1]
83ec:B83EC DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
83ed:W83ED DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg3]
83ef:W83EF DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg4]
83f1:B83F1 DW    X'0009'    ; =0x0009 =9 [TODO: arg5]
83f3:W83F3 LDA+  X+         ; [Load A indexed, direct, post-incremented]
83f5:      STA   W83F9      ; =+2 [Store A relative]
83f7:      JSR   F8414      ; =+27 [Jump to subroutine relative]
83f9:W83F9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83fb:      LDAB= X'64'      ; =100 [Load AL with immediate]
83fd:      STAB/ B8387      ; =0x8387 =33671(-31865) [Store AL direct]
8400:W8400 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8403:      XAS              ; [Transfer A to S]
8404:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
*
* Function F8407
*
8407:F8407 JSR   F8424      ; =+27 [Jump to subroutine relative]
8409:      DB    X'01'      ; =0x01 =1
840a:      DW    W8432      ; =0x8432 =33842(-31694)
840c:      BZ    D8413      ; =+5 [Branch if zero]
840e:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8411:      DB    X'09'      ; =0x09 =9 [Service call ABRT - abort task]
8412:      DB    X'12'      ; =0x12 =18 [abort code]
*
8413:D8413 RSR              ; [Return from subroutine]
*
* Function F8414
*
8414:F8414 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8416:      STA   W8460      ; =+72 [Store A relative]
8418:      JSR   F8424      ; =+10 [Jump to subroutine relative]
841a:      DB    X'02'      ; =0x02 =2
841b:      DW    W8450      ; =0x8450 =33872(-31664)
841d:      BZ    D8413      ; =-12 [Branch if zero]
841f:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8422:      DB    X'09'      ; =0x09 =9 [Service call ABRT - abort task]
8423:      DB    X'13'      ; =0x13 =19 [abort code]
*
*
* Function F8424
*
8424:F8424 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8426:      LDB+  X          ; [Load B from address in X]
8427:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
842a:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
842d:      DB    X'18'      ; =0x18 =24 [Service call LIOC - logical I/O control]
842e:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8430:      LDAB+ B          ; [Load AL from address in B]
8431:      RSR              ; [Return from subroutine]
*
8432:W8432 DB    X'00'      ; =0x00 =0 =NUL
8433:B8433 DW    X'8021'    ; =0x8021 =32801(-32735)
8435:      DW    X'0100'    ; =0x0100 =256
8437:      DB    X'84'      ; =0x84 =132(-124) =EOT
8438:W8438 DW    W808D      ; =0x808d =32909(-32627)
843a:      DB    0,4        ; =0x00,0x0004
843e:      DW    X'0102'    ; =0x0102 =258
8440:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8442:      DW    W808D      ; =0x808d =32909(-32627)
8444:      DB    0,12       ; =0x00,0x000c
8450:W8450 DW    X'0082'    ; =0x0082 =130
8452:      DW    X'2202'    ; =0x2202 =8706
8454:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8456:      DW    W8006      ; =0x8006 =32774(-32762)
8458:      DB    0,5        ; =0x00,0x0005
845d:      DW    X'0200'    ; =0x0200 =512
845f:      DB    X'84'      ; =0x84 =132(-124) =EOT
8460:W8460 DW    W8006      ; =0x8006 =32774(-32762)
8462:      DB    0,12       ; =0x00,0x000c
846e:W846E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8470:      DW    X'2302'    ; =0x2302 =8962
8472:      DW    X'0190'    ; =0x0190 =400
8474:      DW    W8535      ; =0x8535 =34101(-31435)
8476:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8478:W8478 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
847a:      DW    X'01FF'    ; =0x01ff =511
847c:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
847e:      DW    W808D      ; =0x808d =32909(-32627)
8480:W8480 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8482:W8482 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8484:W8484 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8486:S8486 DB    0,6        ; =0x00,0x0006
848c:W848C DW    X'000E'    ; =0x000e =14
848e:      DC    'PDIR - MOD AE'
849b:      DB    X'8D'      ; =0x8d =141(-115) =CR
849c:W849C DW    X'0018'    ; =0x0018 =24
849e:      DC    'CONTROL STATEMENT ERROR'
84b5:      DB    X'8D'      ; =0x8d =141(-115) =CR
84b6:W84B6 DW    X'0009'    ; =0x0009 =9
84b8:      DC    'END PDIR' ; hex:c5cec4a0d0c4c9d2
84c0:      DB    X'8D'      ; =0x8d =141(-115) =CR
84c1:W84C1 DW    X'0014'    ; =0x0014 =20
84c3:      DC    'FILE SIZE TOO LARGE'
84d6:      DB    X'8D'      ; =0x8d =141(-115) =CR
84d7:W84D7 DW    X'0017'    ; =0x0017 =23
84d9:      DC    'ILLEGAL DIRECTORY FILE'
84ef:      DB    X'8D'      ; =0x8d =141(-115) =CR
84f0:W84F0 DW    X'0014'    ; =0x0014 =20
84f2:      DC    'NO MORE FILE BLOCKS'
8505:      DB    X'8D'      ; =0x8d =141(-115) =CR
8506:W8506 DW    X'0010'    ; =0x0010 =16
8508:      DC    'SYS001 ASSIGNED'
8517:      DB    X'8D'      ; =0x8d =141(-115) =CR
8518:W8518 DB    X'01'      ; =0x01 =1
8519:      DC    '@@@@00'   ; hex:c0c0c0c0b0b0
851f:      DB    X'00'      ; =0x00 =0 =NUL
8520:      DB    0,3        ; =0x00,0x0003
8523:      DC    '@PDIR0'   ; hex:c0d0c4c9d2b0
8529:B8529 DB    X'00'      ; =0x00 =0 =NUL
852a:W852A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
852c:S852C DB    0,5        ; =0x00,0x0005
8531:W8531 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8533:S8533 DC    '0 '       ; hex:b0a0 dec:45216(-96)
8535:W8535 DS    1          ; =0x0001 [Uninitialized memory]
8536:W8536 DS    1          ; =0x0001 [Uninitialized memory]
8537:W8537 DS    1          ; =0x0001 [Uninitialized memory]
8538:W8538 DS    7          ; =0x0007 [Uninitialized memory]
853f:W853F DS    390        ; =0x0186 [Uninitialized memory]
86c5:      DW    X'8D8D'    ; =0x8d8d =36237(-29299) =CR,CR
86c7:      DB    X'FF'      ; =0xff =255(-1)
86c8:W86C8 DS    1          ; =0x0001 [Uninitialized memory]
86c9:W86C9 DS    2          ; =0x0002 [Uninitialized memory]
86cb:W86CB DS    2          ; =0x0002 [Uninitialized memory]
86cd:W86CD DS    1          ; =0x0001 [Uninitialized memory]
86ce:W86CE DS    4          ; =0x0004 [Uninitialized memory]
86d2:W86D2 DS    6          ; =0x0006 [Uninitialized memory]
86d8:W86D8 DS    7          ; =0x0007 [Uninitialized memory]
86df:W86DF DS    2          ; =0x0002 [Uninitialized memory]
86e1:W86E1 DS    375        ; =0x0177 [Uninitialized memory]
8858:      DW    X'8D8D'    ; =0x8d8d =36237(-29299) =CR,CR
885a:      DB    X'FF'      ; =0xff =255(-1)
885b:W885B DS    1          ; =0x0001 [Uninitialized memory]
885c:W885C DS    2          ; =0x0002 [Uninitialized memory]
885e:W885E DS    2          ; =0x0002 [Uninitialized memory]
8860:      DB    X'03'      ; =0x03 =3
8861:      DC    'CLR'      ; hex:c3ccd2
8864:      DW    W8258      ; =0x8258 =33368(-32168)
8866:      DB    X'03'      ; =0x03 =3
8867:      DC    'DIR'      ; hex:c4c9d2
886a:      DW    W9057      ; =0x9057 =36951(-28585)
886c:      DB    X'03'      ; =0x03 =3
886d:      DC    'NAM'      ; hex:cec1cd
8870:      DW    W93A0      ; =0x93a0 =37792(-27744)
8872:      DB    X'03'      ; =0x03 =3
8873:      DC    'DEL'      ; hex:c4c5cc
8876:      DW    W933B      ; =0x933b =37691(-27845)
8878:      DB    X'04'      ; =0x04 =4
8879:      DC    'COPY'     ; hex:c3cfd0d9
887d:      DW    W88DA      ; =0x88da =35034(-30502)
887f:      DB    X'03'      ; =0x03 =3
8880:      DC    'NEW'      ; hex:cec5d7
8883:      DW    W8891      ; =0x8891 =34961(-30575)
8885:      DB    X'03'      ; =0x03 =3
8886:      DC    'END'      ; hex:c5cec4
8889:      DW    W8354      ; =0x8354 =33620(-31916)
888b:      DB    X'02'      ; =0x02 =2
888c:      DC    '/*'       ; hex:afaa dec:44970(-86)
888e:      DW    W8354      ; =0x8354 =33620(-31916)
8890:      DB    X'FF'      ; =0xff =255(-1)
*
8891:W8891 LDAB+ Z          ; [Load AL from address in Z]
8892:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
8895:      BP    D889C      ; =+5 [Branch on plus]
8897:J8897 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
889a:      DW    W849C      ; =0x849c =33948(-31588)
*
889c:D889C JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
889f:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
88a1:      JSR/  F8CAB      ; =0x8cab =36011(-29525) =FF,'+' [Jump to subroutine direct]
88a4:      JSR/  F8388      ; =0x8388 =33672(-31864) [Jump to subroutine direct]
88a7:      LDA/  S852C      ; =0x852c =34092(-31444) [Load A direct]
88aa:      STA/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Store A direct]
88ad:      LDAB+ Z          ; [Load AL from address in Z]
88ae:      BNZ   J8897      ; =-25 [Branch if not zero]
88b0:      LDB=  S8DE6      ; =0x8de6 =36326(-29210) =CR,'f' [Load B with immediate]
88b3:      JSR/  F8CF9      ; =0x8cf9 =36089(-29447) =FF,'y' [Jump to subroutine direct]
88b6:      BZ    D88BD      ; =+5 [Branch if zero]
88b8:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
88bb:      DW    W8FA6      ; =0x8fa6 =36774(-28762)
*
88bd:D88BD CLA              ; [Clear A]
88be:      STA/  W8DF4      ; =0x8df4 =36340(-29196) =CR,'t' [Store A direct]
88c1:      JSR/  F8D05      ; =0x8d05 =36101(-29435) [Jump to subroutine direct]
88c4:      JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
88c7:      DW    X'0010'    ; =0x0010 =16
88c9:W88C9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88cb:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
88cd:W88CD LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
88d0:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
88d3:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
88d6:      DB    X'02'      ; =0x02 =2
88d7:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
88da:W88DA LDAB+ Z          ; [Load AL from address in Z]
88db:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
88de:      BM    D8907      ; =+39 [Branch on minus]
88e0:      XFR   Z,A        ; [Transfer Z to A]
88e2:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
88e4:D88E4 JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
88e7:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
*
88e9:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
88ec:      DC    '.'        ; hex:ae dec:174(-82)
88ed:      DB    X'01'      ; =0x01 =1
88ee:      BNZ   D88E4      ; =-12 [Branch if not zero]
88f0:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
88f3:      DC    'ON'       ; hex:cfce dec:53198(-50)
88f5:      DB    X'01'      ; =0x01 =1
88f6:      JSR/  F96E2      ; =0x96e2 =38626(-26910) [Jump to subroutine direct]
88f9:      STBB/ B89F7+1    ; =0x89f8 =35320(-30216) [Store BL direct]
88fc:      LDBB+ A,2        ; [Load BL indexed, displaced, direct]
88ff:      STBB  B8946+1    ; =+70 [Store BL relative]
8901:      LDBB= X'10'      ; =16 [Load BL with immediate]
8903:      LDAB+ A          ; [Load AL from address in A]
8904:      NABB             ; [AL & BL -> BL]
8905:      BNZ   D890C      ; =+5 [Branch if not zero]
8907:D8907 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
890a:      DW    W8FD3      ; =0x8fd3 =36819(-28717)
*
890c:D890C CLA              ; [Clear A]
890d:      STAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Store AL direct]
8910:      STA/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Store A direct]
8913:      STA/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store A direct]
8916:      LDAB+ Z          ; [Load AL from address in Z]
8917:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8919:      SABB             ; [AL - BL -> BL]
891a:      BNZ   D891F      ; =+3 [Branch if not zero]
891c:      JSR/  F8CAB      ; =0x8cab =36011(-29525) =FF,'+' [Jump to subroutine direct]
891f:D891F LDAB+ Z          ; [Load AL from address in Z]
8920:      JSR/  F960C      ; =0x960c =38412(-27124) [Jump to subroutine direct]
8923:      BM    D892E      ; =+9 [Branch on minus]
8925:      JSR/  F8388      ; =0x8388 =33672(-31864) [Jump to subroutine direct]
8928:      LDA/  S852C      ; =0x852c =34092(-31444) [Load A direct]
892b:      STA/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Store A direct]
892e:D892E JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8931:      DC    'TO'       ; hex:d4cf dec:54479(-49)
8933:      DB    X'01'      ; =0x01 =1
8934:      BZ    D893B      ; =+5 [Branch if zero]
8936:      JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
8939:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
*
893b:D893B LDAB+ Z          ; [Load AL from address in Z]
893c:      BNZ   D8907      ; =-55 [Branch if not zero]
893e:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8940:      XAZ              ; [Transfer A to Z]
8941:      JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
8944:      DW    W8E14      ; =0x8e14 =36372(-29164)
8946:B8946 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8948:      LDB=  W8E14      ; =0x8e14 =36372(-29164) [Load B with immediate]
894b:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
894e:      DB    X'0E'      ; =0x0e =14 [Service call DIRNM - search directory for file name specified]
894f:      DW    W86C8      ; =0x86c8 =34504(-31032) [TODO: arg 1]
8951:      BNZ   D8958      ; =+5 [Branch if not zero]
8953:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8956:      DW    W8FE9      ; =0x8fe9 =36841(-28695)
*
8958:D8958 XAX              ; [Transfer A to X]
8959:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
895c:      DC    '.'        ; hex:ae dec:174(-82)
895d:      DB    X'01'      ; =0x01 =1
895e:      BZ    D8984      ; =+36 [Branch if zero]
8960:      LDAB+ X,6        ; [Load AL indexed, displaced, direct]
8963:      JSR/  F8C95      ; =0x8c95 =35989(-29547) [Jump to subroutine direct]
8966:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8968:      SABB             ; [AL - BL -> BL]
8969:      BNZ   D8907      ; =-100 [Branch if not zero]
896b:      JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
896e:      DW    W8E14      ; =0x8e14 =36372(-29164)
8970:      LDA+  X,7        ; [Load A indexed, displaced, direct]
8973:      STA   W897E      ; =+9 [Store A relative]
8975:      LDAB  B8946+1    ; =-48 [Load AL relative]
8977:      LDB=  W8E14      ; =0x8e14 =36372(-29164) [Load B with immediate]
897a:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
897d:      DB    X'0D'      ; =0x0d =13 [Service call JXM - protected change to JX map]
897e:W897E HLT              ; [Halt]
897f:      HLT              ; [Halt]
8980:      DW    W86C8      ; =0x86c8 =34504(-31032)
8982:      DB    X'73'      ; =0x73 =115
8983:      DC    'M'        ; hex:cd dec:205(-51)
*
8984:D8984 LDA+  X,14       ; [Load A indexed, displaced, direct]
8987:      STA/  W8DF4      ; =0x8df4 =36340(-29196) =CR,'t' [Store A direct]
898a:W898A LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
898d:      SAB              ; [A - B -> B]
898e:      BLE   D8992      ; =+2 [Branch if less than or equal to zero]
8990:      STA   W898A+1    ; =-7 [Store A relative]
8992:D8992 LDAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Load AL direct]
8995:      BNZ   D89B4      ; =+29 [Branch if not zero]
8997:      LDAB+ X,6        ; [Load AL indexed, displaced, direct]
899a:      LDBB= X'F8'      ; =248(-8) ='x' [Load BL with immediate]
899c:      NABB             ; [AL & BL -> BL]
899d:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
899f:      JSR/  F8C95      ; =0x8c95 =35989(-29547) [Jump to subroutine direct]
89a2:      LDAB= X'01'      ; =1 [Load AL with immediate]
89a4:      SABB             ; [AL - BL -> BL]
89a5:      BZ    D89C7      ; =+32 [Branch if zero]
89a7:      LDAB+ X,6        ; [Load AL indexed, displaced, direct]
89aa:      JSR/  F8C95      ; =0x8c95 =35989(-29547) [Jump to subroutine direct]
89ad:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
89af:      ORIB  AL,BL      ; [AL | BL -> BL]
89b1:      STBB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Store BL direct]
89b4:D89B4 LDAB+ X,6        ; [Load AL indexed, displaced, direct]
89b7:      JSR/  F8C95      ; =0x8c95 =35989(-29547) [Jump to subroutine direct]
89ba:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
89bc:      LDAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Load AL direct]
89bf:      JSR/  F8C95      ; =0x8c95 =35989(-29547) [Jump to subroutine direct]
89c2:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
89c4:      SABB             ; [AL - BL -> BL]
89c5:      BZ    D89CC      ; =+5 [Branch if zero]
89c7:D89C7 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
89ca:      DW    W8FFA      ; =0x8ffa =36858(-28678)
*
89cc:D89CC LDAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Load AL direct]
89cf:      JSR/  F8C90      ; =0x8c90 =35984(-29552) [Jump to subroutine direct]
89d2:      LDA=  W8C8B      ; =0x8c8b =35979(-29557) =FF,VT [Load A with immediate]
89d5:      AAB              ; [A + B -> B]
89d6:      LDAB+ B          ; [Load AL from address in B]
89d7:      STAB/ B8D85+1    ; =0x8d86 =36230(-29306) [Store AL direct]
89da:      LDA+  X,11       ; [Load A indexed, displaced, direct]
89dd:      STA/  W8E0A      ; =0x8e0a =36362(-29174) [Store A direct]
89e0:      STA/  S8E0E      ; =0x8e0e =36366(-29170) [Store A direct]
89e3:      LDA+  X,7        ; [Load A indexed, displaced, direct]
89e6:      STA/  W8E08      ; =0x8e08 =36360(-29176) [Store A direct]
89e9:      LDA/  W811F+1    ; =0x8120 =33056(-32480) [Load A direct]
89ec:      XAY              ; [Transfer A to Y]
89ed:      LDB+  Y,4        ; [Load B indexed, displaced, direct]
89f0:      CLA              ; [Clear A]
89f1:      LDAB+ Y,6        ; [Load AL indexed, displaced, direct]
89f4:      INA              ; [Increment A]
89f5:      SLA              ; [Left shift A]
89f6:      AAB              ; [A + B -> B]
89f7:B89F7 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
89f9:      STAB+ B          ; [Store AL to address in B]
89fa:      LDB=  S8DE6      ; =0x8de6 =36326(-29210) =CR,'f' [Load B with immediate]
89fd:      JSR/  F8CF9      ; =0x8cf9 =36089(-29447) =FF,'y' [Jump to subroutine direct]
8a00:      BNZ   D8A39      ; =+55 [Branch if not zero]
8a02:      JSR/  F8D05      ; =0x8d05 =36101(-29435) [Jump to subroutine direct]
8a05:      LDA/  W8DBB+1    ; =0x8dbc =36284(-29252) =CR,'<' [Load A direct]
8a08:      LDB/  W8DED      ; =0x8ded =36333(-29203) =CR,'m' [Load B direct]
8a0b:      SAB              ; [A - B -> B]
8a0c:      BGZ   D8A13      ; =+5 [Branch if greater than zero]
8a0e:D8A0E JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8a11:      DW    W8FC9      ; =0x8fc9 =36809(-28727)
*
8a13:D8A13 LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
8a16:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8a19:      DB    X'2B'      ; =0x2b =43 [Service call MUL16 - 16-bit multiply]
8a1a:      XFR   A,A        ; [Transfer A to A]
8a1c:      BZ    D8A26      ; =+8 [Branch if zero]
8a1e:D8A1E LDA=  X'FFFB'    ; =0xfffb =65531(-5) [Load A with immediate]
8a21:      STA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Store A direct]
8a24:      JMP   D8A5E      ; =+56 [Jump relative]
8a26:D8A26 XFR   B,B        ; [Transfer B to B]
8a28:      BM    D8A1E      ; =-12 [Branch on minus]
8a2a:      LDA/  S8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Load A direct]
8a2d:      INA              ; [Increment A]
8a2e:      INA              ; [Increment A]
8a2f:      INA              ; [Increment A]
8a30:      SUB   B,A        ; [B - A -> A]
8a32:      BM    D8A0E      ; =-38 [Branch on minus]
8a34:      STA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Store A direct]
8a37:      JMP   D8A5E      ; =+37 [Jump relative]
8a39:D8A39 STA/  W88C9      ; =0x88c9 =35017(-30519) [Store A direct]
8a3c:      STA   W8A54      ; =+22 [Store A relative]
8a3e:      STB/  W88CD+1    ; =0x88ce =35022(-30514) [Store B direct]
8a41:      LDBB+ A,6        ; [Load BL indexed, displaced, direct]
8a44:      LDAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Load AL direct]
8a47:      SABB             ; [AL - BL -> BL]
8a48:      BZ    D8A4D      ; =+3 [Branch if zero]
8a4a:      JMP/  D89C7      ; =0x89c7 =35271(-30265) [Jump direct]
8a4d:D8A4D JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
8a50:      DW    X'000E'    ; =0x000e =14
8a52:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
8a54:W8A54 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a56:      LDA/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Load A direct]
8a59:      DCA              ; [Decrement A]
8a5a:      DCA              ; [Decrement A]
8a5b:      DCA              ; [Decrement A]
8a5c:      STA   W8AC9+1    ; =+108 [Store A relative]
8a5e:D8A5E LDA/  S8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Load A direct]
8a61:      STA/  W8482      ; =0x8482 =33922(-31614) [Store A direct]
8a64:      STA/  S8486      ; =0x8486 =33926(-31610) [Store A direct]
8a67:      LDA/  W8DED      ; =0x8ded =36333(-29203) =CR,'m' [Load A direct]
8a6a:      STA/  W8480      ; =0x8480 =33920(-31616) [Store A direct]
8a6d:      LDBB/ B82AE+1    ; =0x82af =33455(-32081) [Load BL direct]
8a70:      STBB/ B83EC      ; =0x83ec =33772(-31764) [Store BL direct]
8a73:      LDB=  W8537      ; =0x8537 =34103(-31433) [Load B with immediate]
8a76:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8a79:      DB    X'01'      ; =0x01 =1
8a7a:      LDA/  W8538      ; =0x8538 =34104(-31432) [Load A direct]
8a7d:      STA/  W8484      ; =0x8484 =33924(-31612) =EOT,EOT [Store A direct]
8a80:      LDA/  W8E08      ; =0x8e08 =36360(-29176) [Load A direct]
8a83:      LDBB/ B8946+1    ; =0x8947 =35143(-30393) [Load BL direct]
8a86:      STBB/ B83EC      ; =0x83ec =33772(-31764) [Store BL direct]
8a89:      LDB=  W8E16      ; =0x8e16 =36374(-29162) [Load B with immediate]
8a8c:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8a8f:      DB    X'01'      ; =0x01 =1
8a90:      LDA/  W8E17      ; =0x8e17 =36375(-29161) [Load A direct]
8a93:      STA/  W8E0C      ; =0x8e0c =36364(-29172) [Store A direct]
8a96:      LDAB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Load AL direct]
8a99:      JSR/  F8C90      ; =0x8c90 =35984(-29552) [Jump to subroutine direct]
8a9c:      SLR   B          ; [Left shift B by 1]
8a9e:      LDA=  W8C81      ; =0x8c81 =35969(-29567) [Load A with immediate]
8aa1:      AAB              ; [A + B -> B]
8aa2:      JMP+  *B         ; [Jump indexed, indirect]
8aa4:W8AA4 LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
8aa7:      STA/  W8E00      ; =0x8e00 =36352(-29184) [Store A direct]
8aaa:      STA/  W8478      ; =0x8478 =33912(-31624) [Store A direct]
8aad:D8AAD JSR/  F8C9D      ; =0x8c9d =35997(-29539) [Jump to subroutine direct]
8ab0:      BNZ   D8AE0      ; =+46 [Branch if not zero]
8ab2:      LDX=  W808D      ; =0x808d =32909(-32627) [Load X with immediate]
8ab5:      LDA+  X          ; [Load A from address in X]
8ab6:      INA              ; [Increment A]
8ab7:W8AB7 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8aba:      JSR/  F8C14      ; =0x8c14 =35860(-29676) [Jump to subroutine direct]
8abd:      STB   W8AB7+1    ; =-7 [Store B relative]
8abf:      BM    J8AD1      ; =+16 [Branch on minus]
8ac1:      STA+  X+         ; [Store A indexed, direct, post-incremented]
8ac3:      DCA              ; [Decrement A]
8ac4:      ADD   A,X        ; [A + X -> X]
8ac6:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8ac8:      STAB+ X          ; [Store AL to address in X]
8ac9:W8AC9 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8acc:      BM    D8AD6      ; =+8 [Branch on minus]
8ace:      SAB              ; [A - B -> B]
8acf:      BP    D8AD6      ; =+5 [Branch on plus]
8ad1:J8AD1 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8ad4:      DW    W9026      ; =0x9026 =36902(-28634)
*
8ad6:D8AD6 JSR/  F8CA4      ; =0x8ca4 =36004(-29532) =FF,'$' [Jump to subroutine direct]
8ad9:      BZ    D8AAD      ; =-46 [Branch if zero]
8adb:J8ADB JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8ade:      DW    W9010      ; =0x9010 =36880(-28656)
*
8ae0:D8AE0 DCAB             ; [Decrement AL]
8ae1:      BNZ   J8ADB      ; =-8 [Branch if not zero]
8ae3:W8AE3 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8ae6:      LDB   W8AB7+1    ; =-48 [Load B relative]
8ae8:      JSR/  F8C14      ; =0x8c14 =35860(-29676) [Jump to subroutine direct]
8aeb:      STB   W8AB7+1    ; =-53 [Store B relative]
8aed:      LDA=  X'848D'    ; =0x848d =33933(-31603) =EOT,CR [Load A with immediate]
8af0:      STA/  B808F      ; =0x808f =32911(-32625) [Store A direct]
8af3:      LDA=  X'8D8D'    ; =0x8d8d =36237(-29299) =CR,CR [Load A with immediate]
8af6:      STA/  W8091      ; =0x8091 =32913(-32623) [Store A direct]
8af9:      LDA   W8AC9+1    ; =-49 [Load A relative]
8afb:      DCA              ; [Decrement A]
8afc:      DCA              ; [Decrement A]
8afd:      SAB              ; [A - B -> B]
8afe:      BP    D8B05      ; =+5 [Branch on plus]
8b00:      LDA/  W8AE3+1    ; =0x8ae4 =35556(-29980) =LF,'d' [Load A direct]
8b03:      JMP   D8B08      ; =+3 [Jump relative]
8b05:D8B05 LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
8b08:D8B08 STA/  W808D      ; =0x808d =32909(-32627) [Store A direct]
8b0b:J8B0B JSR/  F8CA4      ; =0x8ca4 =36004(-29532) =FF,'$' [Jump to subroutine direct]
8b0e:      JSR/  F8424      ; =0x8424 =33828(-31708) [Jump to subroutine direct]
8b11:      DB    X'0B'      ; =0x0b =11
8b12:      DW    W846E      ; =0x846e =33902(-31634)
*
8b14:J8B14 LDA   W8AB7+1    ; =-94 [Load A relative]
8b16:      INA              ; [Increment A]
8b17:      LDB/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Load B direct]
8b1a:      SAB              ; [A - B -> B]
8b1b:      BM    D8B20      ; =+3 [Branch on minus]
8b1d:      STA/  W8DEF      ; =0x8def =36335(-29201) =CR,'o' [Store A direct]
8b20:D8B20 LDA/  W88C9      ; =0x88c9 =35017(-30519) [Load A direct]
8b23:      STA/  W8B2B      ; =0x8b2b =35627(-29909) [Store A direct]
8b26:      JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
8b29:      DW    X'0010'    ; =0x0010 =16
8b2b:W8B2B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8b2d:      DW    S8DE6      ; =0x8de6 =36326(-29210) =CR,'f'
8b2f:      LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
8b32:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
8b35:      LDA/  W88CD+1    ; =0x88ce =35022(-30514) [Load A direct]
8b38:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
8b3b:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8b3e:      DB    X'02'      ; =0x02 =2
8b3f:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
8b42:W8B42 LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
8b45:      STA/  W8E00      ; =0x8e00 =36352(-29184) [Store A direct]
8b48:      STA/  W8478      ; =0x8478 =33912(-31624) [Store A direct]
8b4b:D8B4B JSR/  F8C9D      ; =0x8c9d =35997(-29539) [Jump to subroutine direct]
8b4e:      BZ    D8B52      ; =+2 [Branch if zero]
8b50:      JMP   D8AE0      ; =-114 [Jump relative]
8b52:D8B52 LDB/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Load B direct]
8b55:      LDA/  W808D      ; =0x808d =32909(-32627) [Load A direct]
8b58:      JSR/  F8C14      ; =0x8c14 =35860(-29676) [Jump to subroutine direct]
8b5b:      STB/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store B direct]
8b5e:      BM    D8B68      ; =+8 [Branch on minus]
8b60:      LDA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Load A direct]
8b63:      BM    D8B6B      ; =+6 [Branch on minus]
8b65:      SAB              ; [A - B -> B]
8b66:      BP    D8B6B      ; =+3 [Branch on plus]
8b68:D8B68 JMP/  J8AD1      ; =0x8ad1 =35537(-29999) =LF,'Q' [Jump direct]
8b6b:D8B6B JSR/  F8CA4      ; =0x8ca4 =36004(-29532) =FF,'$' [Jump to subroutine direct]
8b6e:      BZ    D8B4B      ; =-37 [Branch if zero]
8b70:      JMP/  J8ADB      ; =0x8adb =35547(-29989) =LF,'[' [Jump direct]
8b73:W8B73 LDA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Load A direct]
8b76:      INA              ; [Increment A]
8b77:      INA              ; [Increment A]
8b78:      STA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Store A direct]
8b7b:      LDA=  W9793      ; =0x9793 =38803(-26733) [Load A with immediate]
8b7e:      STA/  W8E00      ; =0x8e00 =36352(-29184) [Store A direct]
8b81:      STA/  W8478      ; =0x8478 =33912(-31624) [Store A direct]
8b84:D8B84 JSR/  F8C9D      ; =0x8c9d =35997(-29539) [Jump to subroutine direct]
8b87:      BNZ   D8BB0      ; =+39 [Branch if not zero]
8b89:      CLA              ; [Clear A]
8b8a:      LDAB/ B808E      ; =0x808e =32910(-32626) [Load AL direct]
8b8d:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
8b90:      ADD   B,A        ; [B + A -> A]
8b92:      LDB/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Load B direct]
8b95:      JSR/  F8C14      ; =0x8c14 =35860(-29676) [Jump to subroutine direct]
8b98:      STB/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store B direct]
8b9b:      BM    D8BA5      ; =+8 [Branch on minus]
8b9d:      LDA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Load A direct]
8ba0:      BM    D8BA8      ; =+6 [Branch on minus]
8ba2:      SAB              ; [A - B -> B]
8ba3:      BP    D8BA8      ; =+3 [Branch on plus]
8ba5:D8BA5 JMP/  J8AD1      ; =0x8ad1 =35537(-29999) =LF,'Q' [Jump direct]
8ba8:D8BA8 JSR/  F8CA4      ; =0x8ca4 =36004(-29532) =FF,'$' [Jump to subroutine direct]
8bab:      BZ    D8B84      ; =-41 [Branch if zero]
8bad:D8BAD JMP/  J8ADB      ; =0x8adb =35547(-29989) =LF,'[' [Jump direct]
8bb0:D8BB0 DCAB             ; [Decrement AL]
8bb1:      BNZ   D8BAD      ; =-6 [Branch if not zero]
8bb3:      LDAB= X'84'      ; =132(-124) =EOT [Load AL with immediate]
8bb5:      STAB/ W808D      ; =0x808d =32909(-32627) [Store AL direct]
8bb8:      JMP/  J8B0B      ; =0x8b0b =35595(-29941) [Jump direct]
8bbb:W8BBB LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8bbe:      STA/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store A direct]
8bc1:      LDA/  W8480      ; =0x8480 =33920(-31616) [Load A direct]
8bc4:      STA/  W8536      ; =0x8536 =34102(-31434) [Store A direct]
8bc7:      LDB/  W8E08      ; =0x8e08 =36360(-29176) [Load B direct]
8bca:      SAB              ; [A - B -> B]
8bcb:      LDA/  W8E08      ; =0x8e08 =36360(-29176) [Load A direct]
8bce:      STB   W8BE8+1    ; =+25 [Store B relative]
8bd0:D8BD0 JSR   F8C2F      ; =+93 [Jump to subroutine relative]
8bd2:      CLA              ; [Clear A]
8bd3:      LDAB/ B8E19      ; =0x8e19 =36377(-29159) [Load AL direct]
8bd6:      BM    D8BF8      ; =+32 [Branch on minus]
8bd8:      XAX              ; [Transfer A to X]
8bd9:      LDA=  W8E14      ; =0x8e14 =36372(-29164) [Load A with immediate]
8bdc:      XAY              ; [Transfer A to Y]
8bdd:D8BDD DCX              ; [Decrement X]
8bde:      BM    D8BF1      ; =+17 [Branch on minus]
8be0:      LDA=  X'0010'    ; =0x0010 =16 [Load A with immediate]
8be3:      ADD   A,Y        ; [A + Y -> Y]
8be5:      LDA+  Y,7        ; [Load A indexed, displaced, direct]
8be8:W8BE8 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8beb:      AAB              ; [A + B -> B]
8bec:      STB+  Y,7        ; [Store B indexed, displaced, direct]
8bef:      JMP   D8BDD      ; =-20 [Jump relative]
8bf1:D8BF1 JSR   F8C54      ; =+97 [Jump to subroutine relative]
8bf3:      BP    D8BD0      ; =-37 [Branch on plus]
8bf5:      JMP/  J8B14      ; =0x8b14 =35604(-29932) [Jump direct]
8bf8:D8BF8 JSR   F8C54      ; =+90 [Jump to subroutine relative]
8bfa:      BP    D8BFF      ; =+3 [Branch on plus]
8bfc:      JMP/  J8B14      ; =0x8b14 =35604(-29932) [Jump direct]
8bff:D8BFF JSR   F8C2F      ; =+46 [Jump to subroutine relative]
8c01:      JMP   D8BF8      ; =-11 [Jump relative]
8c03:W8C03 LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8c06:      STA/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store A direct]
8c09:      LDA/  W8D00      ; =0x8d00 =36096(-29440) =CR,NUL [Load A direct]
8c0c:      STA/  W8536      ; =0x8536 =34102(-31434) [Store A direct]
8c0f:      LDA/  W8E08      ; =0x8e08 =36360(-29176) [Load A direct]
8c12:      JMP   D8BFF      ; =-21 [Jump relative]
*
* Function F8C14
*
8c14:F8C14 AAB              ; [A + B -> B]
8c15:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8c17:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8c19:P8C19 LDB/  S8486      ; =0x8486 =33926(-31610) [Load B direct]
8c1c:      AAB              ; [A + B -> B]
8c1d:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
8c20:      SAB              ; [A - B -> B]
8c21:      BP    D8C2A      ; =+7 [Branch on plus]
8c23:      INA              ; [Increment A]
8c24:      LDB*  P8C19+1    ; =-12 [Load B relative indirect]
8c26:      SAB              ; [A - B -> B]
8c27:      LDA+  S          ; [Load A from address in S]
8c28:      AAB              ; [A + B -> B]
8c29:      STB+  S          ; [Store B to address in S]
8c2a:D8C2A LDB+  S+         ; [Load B indexed, direct, post-incremented]
8c2c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8c2e:      RSR              ; [Return from subroutine]
*
* Function F8C2F
*
8c2f:F8C2F LDBB/ B8946+1    ; =0x8947 =35143(-30393) [Load BL direct]
8c32:      STBB/ B83EC      ; =0x83ec =33772(-31764) [Store BL direct]
8c35:      LDB=  W8E14      ; =0x8e14 =36372(-29164) [Load B with immediate]
8c38:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8c3b:      DB    X'01'      ; =0x01 =1
8c3c:      LDA/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Load A direct]
8c3f:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
8c42:      AAB              ; [A + B -> B]
8c43:      STB/  W8AB7+1    ; =0x8ab8 =35512(-30024) =LF,'8' [Store B direct]
8c46:      BM    D8C50      ; =+8 [Branch on minus]
8c48:      LDA/  W8AC9+1    ; =0x8aca =35530(-30006) =LF,'J' [Load A direct]
8c4b:      BM    D8C53      ; =+6 [Branch on minus]
8c4d:      SAB              ; [A - B -> B]
8c4e:      BP    D8C53      ; =+3 [Branch on plus]
8c50:D8C50 JMP/  J8AD1      ; =0x8ad1 =35537(-29999) =LF,'Q' [Jump direct]
8c53:D8C53 RSR              ; [Return from subroutine]
*
* Function F8C54
*
8c54:F8C54 LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
8c57:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
8c5a:      LDA/  W8536      ; =0x8536 =34102(-31434) [Load A direct]
8c5d:      BM    D8C50      ; =-15 [Branch on minus]
8c5f:      LDB=  W8535      ; =0x8535 =34101(-31435) [Load B with immediate]
8c62:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8c65:      DB    X'01'      ; =0x01 =1
8c66:      LDA/  W8E15      ; =0x8e15 =36373(-29163) [Load A direct]
8c69:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8c6b:      LDA/  W8536      ; =0x8536 =34102(-31434) [Load A direct]
8c6e:      STA/  W8E15      ; =0x8e15 =36373(-29163) [Store A direct]
8c71:      LDA/  W8538      ; =0x8538 =34104(-31432) [Load A direct]
8c74:      STA/  W8E17      ; =0x8e17 =36375(-29161) [Store A direct]
8c77:      LDB=  W8E14      ; =0x8e14 =36372(-29164) [Load B with immediate]
8c7a:      JSR/  F83E0      ; =0x83e0 =33760(-31776) [Jump to subroutine direct]
8c7d:      DB    X'02'      ; =0x02 =2
8c7e:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8c80:      RSR              ; [Return from subroutine]
*
8c81:W8C81 DW    W8BBB      ; =0x8bbb =35771(-29765) =VT,';'
8c83:      DW    W8B42      ; =0x8b42 =35650(-29886)
8c85:      DW    W8AA4      ; =0x8aa4 =35492(-30044) =LF,'$'
8c87:      DW    W8C03      ; =0x8c03 =35843(-29693)
8c89:      DW    W8B73      ; =0x8b73 =35699(-29837)
8c8b:W8C8B DW    X'0100'    ; =0x0100 =256
8c8d:      DB    X'00'      ; =0x00 =0 =NUL
8c8e:      DW    X'0101'    ; =0x0101 =257
*
*
* Function F8C90
*
8c90:F8C90 LDB=  X'0007'    ; =0x0007 =7 [Load B with immediate]
8c93:      NAB              ; [A & B -> B]
8c94:      RSR              ; [Return from subroutine]
*
* Function F8C95
*
8c95:F8C95 SRAB             ; [Right shift AL]
8c96:      SRAB             ; [Right shift AL]
8c97:      SRAB             ; [Right shift AL]
8c98:      LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
8c9b:      NAB              ; [A & B -> B]
8c9c:      RSR              ; [Return from subroutine]
*
* Function F8C9D
*
8c9d:F8C9D JSR/  F8424      ; =0x8424 =33828(-31708) [Jump to subroutine direct]
8ca0:      DB    X'01'      ; =0x01 =1
8ca1:      DW    W8DF6      ; =0x8df6 =36342(-29194) =CR,'v'
8ca3:      RSR              ; [Return from subroutine]
*
* Function F8CA4
*
8ca4:F8CA4 JSR/  F8424      ; =0x8424 =33828(-31708) [Jump to subroutine direct]
8ca7:      DB    X'02'      ; =0x02 =2
8ca8:      DW    W846E      ; =0x846e =33902(-31634)
8caa:      RSR              ; [Return from subroutine]
*
* Function F8CAB
*
8cab:F8CAB CLAB             ; [Clear AL]
8cac:      STAB/ B8D85+1    ; =0x8d86 =36230(-29306) [Store AL direct]
8caf:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cb2:      DC    ','        ; hex:ac dec:172(-84)
8cb3:      DB    X'01'      ; =0x01 =1
*
8cb4:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cb7:      DW    X'A701'    ; =0xa701 =42753(-22783)
8cb9:      BZ    D8CDE      ; =+35 [Branch if zero]
8cbb:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cbe:      DC    'D'        ; hex:c4 dec:196(-60)
8cbf:      DB    X'01'      ; =0x01 =1
8cc0:      BNZ   D8CE1      ; =+31 [Branch if not zero]
8cc2:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cc5:      DC    'B'        ; hex:c2 dec:194(-62)
8cc6:      DB    X'09'      ; =0x09 =9
8cc7:      BNZ   D8CE5      ; =+28 [Branch if not zero]
8cc9:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8ccc:      DC    'A'        ; hex:c1 dec:193(-63)
8ccd:      DB    X'12'      ; =0x12 =18
8cce:      BNZ   D8CE5      ; =+21 [Branch if not zero]
8cd0:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cd3:      DC    'C'        ; hex:c3 dec:195(-61)
8cd4:      DB    X'1C'      ; =0x1c =28
8cd5:      BNZ   D8CE1      ; =+10 [Branch if not zero]
8cd7:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cda:      DC    'E'        ; hex:c5 dec:197(-59)
8cdb:      DB    X'0D'      ; =0x0d =13
8cdc:      BNZ   D8CE1      ; =+3 [Branch if not zero]
8cde:D8CDE JMP/  J8897      ; =0x8897 =34967(-30569) [Jump direct]
8ce1:D8CE1 STAB/ B8D85+1    ; =0x8d86 =36230(-29306) [Store AL direct]
8ce4:      DCAB             ; [Decrement AL]
8ce5:D8CE5 LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8ce7:      ORIB  AL,BL      ; [AL | BL -> BL]
8ce9:      STBB/ B8DEC      ; =0x8dec =36332(-29204) =CR,'l' [Store BL direct]
8cec:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cef:      DW    X'A701'    ; =0xa701 =42753(-22783)
8cf1:      BZ    D8CDE      ; =-21 [Branch if zero]
8cf3:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
8cf6:      DC    ','        ; hex:ac dec:172(-84)
8cf7:      DB    X'01'      ; =0x01 =1
8cf8:      RSR              ; [Return from subroutine]
*
* Function F8CF9
*
8cf9:F8CF9 LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
8cfc:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8cff:      DB    X'0D'      ; =0x0d =13 [Service call JXM - protected change to JX map]
8d00:W8D00 HLT              ; [Halt]
8d01:      HLT              ; [Halt]
8d02:      DW    W86C8      ; =0x86c8 =34504(-31032)
8d04:      DB    X'09'      ; =0x09 =9
*
*
* Function F8D05
*
8d05:F8D05 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8d07:      LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
8d0a:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
8d0d:      LDA   W8D00      ; =-15 [Load A relative]
8d0f:D8D0F STA/  W88CD+1    ; =0x88ce =35022(-30514) [Store A direct]
8d12:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
8d15:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8d18:      DB    X'01'      ; =0x01 =1
8d19:      LDA/  W86CE      ; =0x86ce =34510(-31026) [Load A direct]
8d1c:      BNZ   D8D23      ; =+5 [Branch if not zero]
8d1e:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8d21:      DW    W9036      ; =0x9036 =36918(-28618)
*
8d23:D8D23 CLA              ; [Clear A]
8d24:      LDAB/ W86CD      ; =0x86cd =34509(-31027) [Load AL direct]
8d27:      BP    D8D2E      ; =+5 [Branch on plus]
8d29:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8d2c:      DW    W8FB8      ; =0x8fb8 =36792(-28744)
*
8d2e:D8D2E LDBB= X'18'      ; =24 [Load BL with immediate]
8d30:      SABB             ; [AL - BL -> BL]
8d31:      BM    D8D38      ; =+5 [Branch on minus]
8d33:      LDA/  W86C9      ; =0x86c9 =34505(-31031) [Load A direct]
8d36:      JMP   D8D0F      ; =-41 [Jump relative]
8d38:D8D38 INAB             ; [Increment AL]
8d39:      STAB/ W86CD      ; =0x86cd =34509(-31027) [Store AL direct]
8d3c:      SLA              ; [Left shift A]
8d3d:      SLA              ; [Left shift A]
8d3e:      SLA              ; [Left shift A]
8d3f:      SLA              ; [Left shift A]
8d40:      LDX=  W86C8      ; =0x86c8 =34504(-31032) [Load X with immediate]
8d43:      ADD   X,A        ; [X + A -> A]
8d45:      STA/  W88C9      ; =0x88c9 =35017(-30519) [Store A direct]
8d48:      XAX              ; [Transfer A to X]
8d49:      XAY              ; [Transfer A to Y]
8d4a:      LDAB/ W86CD      ; =0x86cd =34509(-31027) [Load AL direct]
8d4d:      DCAB             ; [Decrement AL]
8d4e:      BNZ   D8D69      ; =+25 [Branch if not zero]
8d50:      LDA/  W86CB      ; =0x86cb =34507(-31029) [Load A direct]
8d53:      LDB=  W8E14      ; =0x8e14 =36372(-29164) [Load B with immediate]
8d56:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8d59:      DB    X'01'      ; =0x01 =1
8d5a:      LDA=  W8E14      ; =0x8e14 =36372(-29164) [Load A with immediate]
8d5d:      XAY              ; [Transfer A to Y]
8d5e:      CLA              ; [Clear A]
8d5f:      LDAB/ B8E19      ; =0x8e19 =36377(-29159) [Load AL direct]
8d62:      INA              ; [Increment A]
8d63:      SLA              ; [Left shift A]
8d64:      SLA              ; [Left shift A]
8d65:      SLA              ; [Left shift A]
8d66:      SLA              ; [Left shift A]
8d67:      ADD   A,Y        ; [A + Y -> Y]
8d69:D8D69 LDA=  X'FFF0'    ; =0xfff0 =65520(-16) [Load A with immediate]
8d6c:      ADD   A,Y        ; [A + Y -> Y]
8d6e:      LDA+  Y,9        ; [Load A indexed, displaced, direct]
8d71:      LDB+  Y,11       ; [Load B indexed, displaced, direct]
8d74:      ADD   B,A        ; [B + A -> A]
8d76:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
8d79:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8d7c:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
8d7d:      STA   S8DF1      ; =+114 [Store A relative]
8d7f:      LDA+  Y,7        ; [Load A indexed, displaced, direct]
8d82:      AAB              ; [A + B -> B]
8d83:      STB   W8DED      ; =+104 [Store B relative]
8d85:B8D85 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8d87:      BZ    D8DAA      ; =+33 [Branch if zero]
8d89:      LDB   S8DF1      ; =+102 [Load B relative]
8d8b:      BZ    D8DAA      ; =+29 [Branch if zero]
8d8d:      LDA=  X'018B'    ; =0x018b =395 [Load A with immediate]
8d90:      SAB              ; [A - B -> B]
8d91:      LDA+  Y,9        ; [Load A indexed, displaced, direct]
8d94:      AAB              ; [A + B -> B]
8d95:      STB+  Y,9        ; [Store B indexed, displaced, direct]
8d98:      CLA              ; [Clear A]
8d99:      STA   S8DF1      ; =+86 [Store A relative]
8d9b:      LDA   W8DED      ; =+80 [Load A relative]
8d9d:      INA              ; [Increment A]
8d9e:      STA   W8DED      ; =+77 [Store A relative]
8da0:      LDAB/ W86CD      ; =0x86cd =34509(-31027) [Load AL direct]
8da3:      DCAB             ; [Decrement AL]
8da4:      BNZ   D8DAA      ; =+4 [Branch if not zero]
8da6:      JSR/  F83E2      ; =0x83e2 =33762(-31774) [Jump to subroutine direct]
8da9:      DB    X'02'      ; =0x02 =2
*
8daa:D8DAA LDA   S8DF1      ; =+69 [Load A relative]
8dac:      LDB   W8DEF      ; =+65 [Load B relative]
8dae:      ADD   B,A        ; [B + A -> A]
8db0:      DCA              ; [Decrement A]
8db1:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
8db4:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8db7:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
8db8:      LDA   W8DED      ; =+51 [Load A relative]
8dba:      AAB              ; [A + B -> B]
8dbb:W8DBB LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8dbe:      SAB              ; [A - B -> B]
8dbf:      BGZ   D8DC6      ; =+5 [Branch if greater than zero]
8dc1:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
8dc4:      DW    W8FC9      ; =0x8fc9 =36809(-28727)
*
8dc6:D8DC6 LDA/  W8DED      ; =0x8ded =36333(-29203) =CR,'m' [Load A direct]
8dc9:      LDB=  W8535      ; =0x8535 =34101(-31435) [Load B with immediate]
8dcc:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
8dcf:      DB    X'01'      ; =0x01 =1
8dd0:      LDA=  W8535      ; =0x8535 =34101(-31435) [Load A with immediate]
8dd3:      LDB/  S8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Load B direct]
8dd6:      AAB              ; [A + B -> B]
8dd7:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
8dda:      AAB              ; [A + B -> B]
8ddb:      LDA=  X'8D8D'    ; =0x8d8d =36237(-29299) =CR,CR [Load A with immediate]
8dde:      STA+  B          ; [Store A to address in B]
8ddf:      JSR/  F83E2      ; =0x83e2 =33762(-31774) [Jump to subroutine direct]
8de2:      DB    X'02'      ; =0x02 =2
8de3:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8de5:      RSR              ; [Return from subroutine]
*
8de6:S8DE6 DB    0,6        ; =0x00,0x0006
8dec:B8DEC DB    X'00'      ; =0x00 =0 =NUL
8ded:W8DED DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8def:W8DEF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8df1:S8DF1 DB    0,3        ; =0x00,0x0003
8df4:W8DF4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8df6:W8DF6 DB    X'00'      ; =0x00 =0 =NUL
8df7:B8DF7 DW    X'0123'    ; =0x0123 =291
8df9:      DB    X'00'      ; =0x00 =0 =NUL
8dfa:      DW    X'0190'    ; =0x0190 =400
8dfc:      DW    W8E14      ; =0x8e14 =36372(-29164)
8dfe:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e00:W8E00 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e02:      DW    X'01FF'    ; =0x01ff =511
8e04:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8e06:      DW    W808D      ; =0x808d =32909(-32627)
8e08:W8E08 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e0a:W8E0A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e0c:W8E0C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e0e:S8E0E DB    0,6        ; =0x00,0x0006
8e14:W8E14 DS    1          ; =0x0001 [Uninitialized memory]
8e15:W8E15 DS    1          ; =0x0001 [Uninitialized memory]
8e16:W8E16 DS    1          ; =0x0001 [Uninitialized memory]
8e17:W8E17 DS    2          ; =0x0002 [Uninitialized memory]
8e19:B8E19 DS    397        ; =0x018d [Uninitialized memory]
8fa6:W8FA6 DW    X'0010'    ; =0x0010 =16
8fa8:      DC    'DUPLICATE ENTRY'
8fb7:      DB    X'8D'      ; =0x8d =141(-115) =CR
8fb8:W8FB8 DW    X'000F'    ; =0x000f =15
8fba:      DC    'DIRECTORY FULL'
8fc8:      DB    X'8D'      ; =0x8d =141(-115) =CR
8fc9:W8FC9 DW    X'0008'    ; =0x0008 =8
8fcb:      DC    'NO ROOM'  ; hex:cecfa0d2cfcfcd
8fd2:      DB    X'8D'      ; =0x8d =141(-115) =CR
8fd3:W8FD3 DW    X'0014'    ; =0x0014 =20
8fd5:      DC    'ILLEGAL DEVICE FILE'
8fe8:      DB    X'8D'      ; =0x8d =141(-115) =CR
8fe9:W8FE9 DW    X'000F'    ; =0x000f =15
8feb:      DC    'FILE NOT FOUND'
8ff9:      DB    X'8D'      ; =0x8d =141(-115) =CR
8ffa:W8FFA DW    X'0014'    ; =0x0014 =20
8ffc:      DC    'FILE TYPE MIS-MATCH'
900f:      DB    X'8D'      ; =0x8d =141(-115) =CR
9010:W9010 DW    X'0014'    ; =0x0014 =20
9012:      DC    'I/O ERROR ON OUTPUT'
9025:      DB    X'8D'      ; =0x8d =141(-115) =CR
9026:W9026 DW    X'000E'    ; =0x000e =14
9028:      DC    'EOM ON OUTPUT'
9035:      DB    X'8D'      ; =0x8d =141(-115) =CR
9036:W9036 DW    X'001F'    ; =0x001f =31
9038:      DC    'DIRECTORY HAS NOT BEEN CLEARED'
9056:      DB    X'8D'      ; =0x8d =141(-115) =CR
*
9057:W9057 CLA              ; [Clear A]
9058:      STA/  W93FB      ; =0x93fb =37883(-27653) [Store A direct]
905b:      STA/  W93FD      ; =0x93fd =37885(-27651) [Store A direct]
905e:      STAB/ B922F+1    ; =0x9230 =37424(-28112) [Store AL direct]
9061:      STAB/ B9224+1    ; =0x9225 =37413(-28123) [Store AL direct]
9064:      STAB/ B9236+1    ; =0x9237 =37431(-28105) [Store AL direct]
9067:      STA/  W94F3      ; =0x94f3 =38131(-27405) [Store A direct]
906a:      STA/  W94F5      ; =0x94f5 =38133(-27403) [Store A direct]
906d:      STAB/ B94F7      ; =0x94f7 =38135(-27401) [Store AL direct]
9070:      DCAB             ; [Decrement AL]
9071:      STAB/ B927B+1    ; =0x927c =37500(-28036) [Store AL direct]
9074:      LDA/  W811F+1    ; =0x8120 =33056(-32480) [Load A direct]
9077:      XAY              ; [Transfer A to Y]
9078:      LDB+  Y,8        ; [Load B indexed, displaced, direct]
907b:      CLA              ; [Clear A]
907c:      LDAB+ B,20       ; [Load AL indexed, displaced, direct]
907f:      DCA              ; [Decrement A]
9080:      STA/  W92DA+1    ; =0x92db =37595(-27941) [Store A direct]
9083:      DCA              ; [Decrement A]
9084:      DCA              ; [Decrement A]
9085:      DCA              ; [Decrement A]
9086:      DCA              ; [Decrement A]
9087:      STA/  W92E2+1    ; =0x92e3 =37603(-27933) [Store A direct]
908a:D908A JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
908d:      DC    ','        ; hex:ac dec:172(-84)
908e:      DB    X'01'      ; =0x01 =1
908f:      LDAB+ Z          ; [Load AL from address in Z]
9090:      BNZ   D9095      ; =+3 [Branch if not zero]
9092:      JMP/  J9123      ; =0x9123 =37155(-28381) [Jump direct]
9095:D9095 JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
9098:      DC    'ALL'      ; hex:c1cccc
909b:      DB    X'01'      ; =0x01 =1
909c:      BNZ   D908A      ; =-20 [Branch if not zero]
909e:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
90a1:      DC    'TEMP'     ; hex:d4c5cdd0
90a5:      DB    X'01'      ; =0x01 =1
90a6:      BZ    D90AD      ; =+5 [Branch if zero]
90a8:      STAB/ B922F+1    ; =0x9230 =37424(-28112) [Store AL direct]
90ab:      JMP   D908A      ; =-35 [Jump relative]
90ad:D90AD JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
90b0:      DC    'PERM'     ; hex:d0c5d2cd
90b4:      DB    X'01'      ; =0x01 =1
90b5:      BZ    D90BC      ; =+5 [Branch if zero]
90b7:      STAB/ B9224+1    ; =0x9225 =37413(-28123) [Store AL direct]
90ba:      JMP   D908A      ; =-50 [Jump relative]
90bc:D90BC JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
90bf:      DW    X'A701'    ; =0xa701 =42753(-22783)
90c1:      BNZ   D90EC      ; =+41 [Branch if not zero]
90c3:      LDAB+ Z          ; [Load AL from address in Z]
90c4:      LDBB= X'A8'      ; =168(-88) ='(' [Load BL with immediate]
90c6:      SABB             ; [AL - BL -> BL]
90c7:      BNZ   D90E7      ; =+30 [Branch if not zero]
90c9:      LDAB= X'01'      ; =1 [Load AL with immediate]
90cb:      XFR   Z,B        ; [Transfer Z to B]
90cd:      INR   B          ; [Increment B by 1]
90cf:      STB/  W923C+1    ; =0x923d =37437(-28099) [Store B direct]
90d2:      STAB/ B9236+1    ; =0x9237 =37431(-28105) [Store AL direct]
90d5:      LDAB= X'A9'      ; =169(-87) =')' [Load AL with immediate]
90d7:D90D7 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
90d9:      BZ    D90E0      ; =+5 [Branch if zero]
90db:      SABB             ; [AL - BL -> BL]
90dc:      BNZ   D90D7      ; =-7 [Branch if not zero]
90de:      JMP   D90E2      ; =+2 [Jump relative]
90e0:D90E0 DCR   Z          ; [Decrement Z by 1]
90e2:D90E2 JSR/  F962B      ; =0x962b =38443(-27093) [Jump to subroutine direct]
90e5:      JMP   D908A      ; =-93 [Jump relative]
90e7:D90E7 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
90ea:      DW    W849C      ; =0x849c =33948(-31588)
*
90ec:D90EC CLAB             ; [Clear AL]
90ed:      STAB/ B927B+1    ; =0x927c =37500(-28036) [Store AL direct]
90f0:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
90f3:      DC    'D'        ; hex:c4 dec:196(-60)
90f4:      DB    X'01'      ; =0x01 =1
90f5:      BNZ   D9113      ; =+28 [Branch if not zero]
90f7:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
90fa:      DC    'B'        ; hex:c2 dec:194(-62)
90fb:      DB    X'02'      ; =0x02 =2
90fc:      BNZ   D9113      ; =+21 [Branch if not zero]
90fe:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
9101:      DC    'A'        ; hex:c1 dec:193(-63)
9102:      DB    X'03'      ; =0x03 =3
9103:      BNZ   D9113      ; =+14 [Branch if not zero]
9105:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
9108:      DC    'C'        ; hex:c3 dec:195(-61)
9109:      DB    X'04'      ; =0x04 =4
910a:      BNZ   D9113      ; =+7 [Branch if not zero]
910c:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
910f:      DC    'E'        ; hex:c5 dec:197(-59)
9110:      DB    X'05'      ; =0x05 =5
9111:      BZ    D90E7      ; =-44 [Branch if zero]
9113:D9113 DCA              ; [Decrement A]
9114:      LDB=  W94F3      ; =0x94f3 =38131(-27405) [Load B with immediate]
9117:      AAB              ; [A + B -> B]
9118:      LDAB= X'01'      ; =1 [Load AL with immediate]
911a:      STAB+ B          ; [Store AL to address in B]
911b:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
911e:      DW    X'A701'    ; =0xa701 =42753(-22783)
9120:      JMP/  D908A      ; =0x908a =37002(-28534) [Jump direct]
9123:J9123 CLA              ; [Clear A]
9124:      LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
9127:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
912a:      LDB=  X'B0B0'    ; =0xb0b0 =45232(-20304) ='0','0' [Load B with immediate]
912d:      STB/  S9440      ; =0x9440 =37952(-27584) [Store B direct]
9130:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
9133:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
9134:      DW    S9441      ; =0x9441 =37953(-27583) [address of end of string]
9136:      LDB=  W846E      ; =0x846e =33902(-31634) [Load B with immediate]
9139:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
913c:      DB    X'0C'      ; =0x0c =12 [Service call PGIOB - protected get I/O block]
913d:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9140:      AAB              ; [A + B -> B]
9141:      STB   W9154      ; =+17 [Store B relative]
9143:      LDA/  W8D00      ; =0x8d00 =36096(-29440) =CR,NUL [Load A direct]
9146:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
9149:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
914c:      DB    X'01'      ; =0x01 =1
*
914d:      JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
9150:      DW    X'0006'    ; =0x0006 =6
9152:      DW    S9431      ; =0x9431 =37937(-27599)
9154:W9154 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9156:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
9159:      DW    W9407      ; =0x9407 =37895(-27641)
915b:      JSR/  W92DA      ; =0x92da =37594(-27942) [Jump to subroutine direct]
915e:      DW    W941F      ; =0x941f =37919(-27617)
9160:      JSR/  W92DA      ; =0x92da =37594(-27942) [Jump to subroutine direct]
9163:      DW    W9443      ; =0x9443 =37955(-27581)
9165:      JSR/  W92DA      ; =0x92da =37594(-27942) [Jump to subroutine direct]
9168:      DW    W9467      ; =0x9467 =37991(-27545)
*
916a:D916A LDA=  W86C8      ; =0x86c8 =34504(-31032) [Load A with immediate]
916d:      XAZ              ; [Transfer A to Z]
916e:      CLA              ; [Clear A]
916f:      LDAB/ W86CD      ; =0x86cd =34509(-31027) [Load AL direct]
9172:      BM    D9186      ; =+18 [Branch on minus]
9174:      XAX              ; [Transfer A to X]
9175:J9175 DCX              ; [Decrement X]
9176:      BP    D9189      ; =+17 [Branch on plus]
9178:      LDB/  W86C9      ; =0x86c9 =34505(-31031) [Load B direct]
917b:      BM    D9186      ; =+9 [Branch on minus]
917d:      STB/  W83ED      ; =0x83ed =33773(-31763) [Store B direct]
9180:      JSR/  F83E2      ; =0x83e2 =33762(-31774) [Jump to subroutine direct]
9183:      DB    X'01'      ; =0x01 =1
9184:      JMP   D916A      ; =-28 [Jump relative]
9186:D9186 JMP/  J928C      ; =0x928c =37516(-28020) [Jump direct]
9189:D9189 LDA=  X'0030'    ; =0x0030 =48 [Load A with immediate]
918c:      LDB=  W949A      ; =0x949a =38042(-27494) [Load B with immediate]
918f:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
9192:      DC    ' '        ; hex:a0 dec:160(-96)
9193:      LDA=  X'0010'    ; =0x0010 =16 [Load A with immediate]
9196:      ADD   Z,A        ; [Z + A -> A]
9198:      XAZ              ; [Transfer A to Z]
9199:      STA   W91A2      ; =+7 [Store A relative]
919b:      JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
919e:      DW    X'0006'    ; =0x0006 =6
91a0:      DW    W949A      ; =0x949a =38042(-27494)
91a2:W91A2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
91a4:      LDA+  Z,7        ; [Load A indexed, displaced, direct]
91a7:      XAB              ; [Transfer A to B]
91a8:      JSR/  F9979      ; =0x9979 =39289(-26247) [Jump to subroutine direct]
91ab:      STA/  W94A7      ; =0x94a7 =38055(-27481) [Store A direct]
91ae:      XFRB  BU,AL      ; [Transfer BU to AL]
91b0:      JSR/  F9979      ; =0x9979 =39289(-26247) [Jump to subroutine direct]
91b3:      STA/  W94A5      ; =0x94a5 =38053(-27483) [Store A direct]
91b6:      LDA+  Z,11       ; [Load A indexed, displaced, direct]
91b9:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91bc:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
91bd:      DW    S94AC      ; =0x94ac =38060(-27476) [address of end of string]
91bf:      LDA+  Z,9        ; [Load A indexed, displaced, direct]
91c2:      LDB=  X'18B0'    ; =0x18b0 =6320 [Load B with immediate]
91c5:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91c8:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
91c9:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
91cb:      XFR   B,A        ; [Transfer B to A]
91cd:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91d0:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
91d1:      DW    S94B0      ; =0x94b0 =38064(-27472) [address of end of string]
91d3:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
91d5:      LDB=  X'018B'    ; =0x018b =395 [Load B with immediate]
91d8:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91db:      DB    X'2C'      ; =0x2c =44 [Service call DIV16 - 16-bit divide]
91dc:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
91de:      XFR   B,A        ; [Transfer B to A]
91e0:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91e3:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
91e4:      DW    S94B5      ; =0x94b5 =38069(-27467) [address of end of string]
91e6:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
91e8:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
91eb:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
91ec:      DW    S94BA      ; =0x94ba =38074(-27462) [address of end of string]
91ee:      LDA+  Z,9        ; [Load A indexed, displaced, direct]
91f1:      LDB/  W93FD      ; =0x93fd =37885(-27651) [Load B direct]
91f4:      AAB              ; [A + B -> B]
91f5:      STB/  W93FD      ; =0x93fd =37885(-27651) [Store B direct]
91f8:      LDA/  W93FB      ; =0x93fb =37883(-27653) [Load A direct]
91fb:      BNL   D91FE      ; =+1 [Branch on no link]
91fd:      INA              ; [Increment A]
91fe:D91FE STA/  W93FB      ; =0x93fb =37883(-27653) [Store A direct]
9201:      LDA=  X'0008'    ; =0x0008 =8 [Load A with immediate]
9204:      LDB=  S94C2      ; =0x94c2 =38082(-27454) [Load B with immediate]
9207:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
920a:      DC    ' '        ; hex:a0 dec:160(-96)
920b:      LDA+  Z,14       ; [Load A indexed, displaced, direct]
920e:      BZ    D9217      ; =+7 [Branch if zero]
9210:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
9213:      DB    X'05'      ; =0x05 =5 [Service call TS - load transient module]
9214:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
9215:      DW    S94C2      ; =0x94c2 =38082(-27454) [address of string date]
*
9217:D9217 LDAB+ Z          ; [Load AL from address in Z]
9218:      BZ    D9233      ; =+25 [Branch if zero]
921a:      LDAB= X'D4'      ; =212(-44) ='T' [Load AL with immediate]
921c:      STAB/ B94BF      ; =0x94bf =38079(-27457) [Store AL direct]
921f:      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
9222:      BNZ   D922A      ; =+6 [Branch if not zero]
9224:B9224 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9226:      BNZ   D9233      ; =+11 [Branch if not zero]
9228:      JMP   B9236      ; =+12 [Jump relative]
922a:D922A LDAB= X'D0'      ; =208(-48) ='P' [Load AL with immediate]
922c:      STAB/ B94BF      ; =0x94bf =38079(-27457) [Store AL direct]
922f:B922F LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9231:      BZ    B9236      ; =+3 [Branch if zero]
9233:D9233 JMP/  J9175      ; =0x9175 =37237(-28299) [Jump direct]
9236:B9236 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9238:      BZ    D926B      ; =+49 [Branch if zero]
923a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
923c:W923C LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
923f:      XFR   Z,A        ; [Transfer Z to A]
9241:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9243:      LDA=  X'0600'    ; =0x0600 =1536 [Load A with immediate]
9246:D9246 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
9248:      LDBB= X'A9'      ; =169(-87) =')' [Load BL with immediate]
924a:      SABB             ; [AL - BL -> BL]
924b:      BZ    D9266      ; =+25 [Branch if zero]
924d:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
924f:      SABB             ; [AL - BL -> BL]
9250:      BNZ   D9256      ; =+4 [Branch if not zero]
9252:      INR   Z          ; [Increment Z by 1]
9254:      JMP   D9262      ; =+12 [Jump relative]
9256:D9256 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
9258:      SABB             ; [AL - BL -> BL]
9259:      BZ    D9262      ; =+7 [Branch if zero]
925b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
925d:      XAZ              ; [Transfer A to Z]
925e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9260:      JMP   D9233      ; =-47 [Jump relative]
9262:D9262 DCRB  AU         ; [Decrement AU by 1]
9264:      BGZ   D9246      ; =-32 [Branch if greater than zero]
9266:D9266 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9268:      XAZ              ; [Transfer A to Z]
9269:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
926b:D926B LDAB+ Z,6        ; [Load AL indexed, displaced, direct]
926e:      LDB=  X'0007'    ; =0x0007 =7 [Load B with immediate]
9271:      AND   B,A        ; [B & A -> A]
9273:      LDB=  S94F8      ; =0x94f8 =38136(-27400) [Load B with immediate]
9276:      AAB              ; [A + B -> B]
9277:      LDBB+ B          ; [Load BL from address in B]
9278:      STBB/ B94A2      ; =0x94a2 =38050(-27486) [Store BL direct]
927b:B927B LDBB= X'01'      ; =1 [Load BL with immediate]
927d:      BNZ   D9286      ; =+7 [Branch if not zero]
927f:      LDB=  W94F3      ; =0x94f3 =38131(-27405) [Load B with immediate]
9282:      AAB              ; [A + B -> B]
9283:      LDBB+ B          ; [Load BL from address in B]
9284:      BZ    D9233      ; =-83 [Branch if zero]
9286:D9286 JSR   W92DA      ; =+82 [Jump to subroutine relative]
9288:      DW    W9498      ; =0x9498 =38040(-27496)
928a:      JMP   D9233      ; =-89 [Jump relative]
928c:J928C LDA=  X'0007'    ; =0x0007 =7 [Load A with immediate]
928f:      LDB=  S94CD      ; =0x94cd =38093(-27443) [Load B with immediate]
9292:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
9295:      DC    ' '        ; hex:a0 dec:160(-96)
9296:      LDA=  X'0007'    ; =0x0007 =7 [Load A with immediate]
9299:      LDB=  S94E1      ; =0x94e1 =38113(-27423) [Load B with immediate]
929c:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
929f:      DC    ' '        ; hex:a0 dec:160(-96)
92a0:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
92a3:      XAZ              ; [Transfer A to Z]
92a4:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92a6:      DB    X'33'      ; =0x33 =51
92a7:      DW    S94CD      ; =0x94cd =38093(-27443)
92a9:      DW    W9403      ; =0x9403 =37891(-27645)
92ab:      DW    W93FB      ; =0x93fb =37883(-27653)
92ad:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
92af:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92b1:      DB    X'1E'      ; =0x1e =30
92b2:      DW    W93F7      ; =0x93f7 =37879(-27657)
*
92b4:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92b6:      DB    X'24'      ; =0x24 =36
92b7:      DW    W93FF      ; =0x93ff =37887(-27649)
*
92b9:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92bb:      DW    X'2400'    ; =0x2400 =9216
92bd:      DB    X'10'      ; =0x10 =16
*
92be:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92c0:      DB    X'22'      ; =0x22 =34
92c1:      DW    W93FB      ; =0x93fb =37883(-27653)
*
92c3:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92c5:      DB    X'1F'      ; =0x1f =31
92c6:      DW    W93FB      ; =0x93fb =37883(-27653)
*
92c8:      JSR+  Z          ; [Jump to subroutine indexed, direct]
92ca:      DB    X'33'      ; =0x33 =51
92cb:      DW    S94E1      ; =0x94e1 =38113(-27423)
92cd:      DW    W9403      ; =0x9403 =37891(-27645)
92cf:      DW    W93FB      ; =0x93fb =37883(-27653)
92d1:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92d3:      JSR   W92DA      ; =+5 [Jump to subroutine relative]
92d5:      DW    W94CB      ; =0x94cb =38091(-27445)
92d7:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
92da:W92DA LDA=  X'0016'    ; =0x0016 =22 [Load A with immediate]
92dd:      DCA              ; [Decrement A]
92de:      STA   W92DA+1    ; =-5 [Store A relative]
92e0:      BP    D9338      ; =+86 [Branch on plus]
92e2:W92E2 LDA=  X'0016'    ; =0x0016 =22 [Load A with immediate]
92e5:      STA   W92DA+1    ; =-12 [Store A relative]
92e7:      LDB=  W8450      ; =0x8450 =33872(-31664) [Load B with immediate]
92ea:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
92ed:      DB    X'0C'      ; =0x0c =12 [Service call PGIOB - protected get I/O block]
92ee:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
92f1:      LDBB= X'02'      ; =2 [Load BL with immediate]
92f3:      SABB             ; [AL - BL -> BL]
92f4:      BNZ   D9338      ; =+66 [Branch if not zero]
92f6:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
92f9:      DW    W940A      ; =0x940a =37898(-27638)
92fb:      LDA=  W808D      ; =0x808d =32909(-32627) [Load A with immediate]
92fe:      STA/  W8438      ; =0x8438 =33848(-31688) [Store A direct]
9301:      LDA/  W811F+1    ; =0x8120 =33056(-32480) [Load A direct]
9304:      LDA+  A,8        ; [Load A indexed, displaced, direct]
9307:      LDB=  W8432      ; =0x8432 =33842(-31694) [Load B with immediate]
930a:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
930d:      DB    X'0F'      ; =0x0f =15 [Service call CONIO - console I/O]
*
930e:D930E JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
9311:      DB    X'07'      ; =0x07 =7 [Service call WT - unconditional wait]
9312:      LDAB/ W8432      ; =0x8432 =33842(-31694) [Load AL direct]
9315:      BM    D930E      ; =-9 [Branch on minus]
9317:      LDAB/ B808F      ; =0x808f =32911(-32625) [Load AL direct]
931a:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
931c:      NABB             ; [AL & BL -> BL]
931d:      LDAB= X'D1'      ; =209(-47) ='Q' [Load AL with immediate]
931f:      SABB             ; [AL - BL -> BL]
9320:      BNZ   D9329      ; =+7 [Branch if not zero]
9322:      LDA/  W8400+1    ; =0x8401 =33793(-31743) [Load A direct]
9325:      XAS              ; [Transfer A to S]
9326:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
9329:D9329 JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
932c:      DW    W9407      ; =0x9407 =37895(-27641)
932e:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
9331:      DW    W9443      ; =0x9443 =37955(-27581)
9333:      JSR/  F8414      ; =0x8414 =33812(-31724) [Jump to subroutine direct]
9336:      DW    W9467      ; =0x9467 =37991(-27545)
*
9338:D9338 JMP/  F8414      ; =0x8414 =33812(-31724) [Jump direct]
933b:W933B LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
933e:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
9341:      LDAB+ Z          ; [Load AL from address in Z]
9342:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
9345:      BP    D934C      ; =+5 [Branch on plus]
9347:D9347 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
934a:      DW    W8FD3      ; =0x8fd3 =36819(-28717)
*
934c:D934C JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
934f:      DW    W949A      ; =0x949a =38042(-27494)
9351:      LDB=  W949A      ; =0x949a =38042(-27494) [Load B with immediate]
9354:      JSR/  F8CF9      ; =0x8cf9 =36089(-29447) =FF,'y' [Jump to subroutine direct]
9357:      BNZ   D935E      ; =+5 [Branch if not zero]
9359:D9359 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
935c:      DW    W8FE9      ; =0x8fe9 =36841(-28695)
*
935e:D935E STB-  S-         ; [Store B indexed, pre-decremented, direct]
9360:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9362:      LDA/  W8D00      ; =0x8d00 =36096(-29440) =CR,NUL [Load A direct]
9365:      LDB=  W8535      ; =0x8535 =34101(-31435) [Load B with immediate]
9368:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
936b:      DB    X'01'      ; =0x01 =1
936c:      LDA/  W853F      ; =0x853f =34111(-31425) [Load A direct]
936f:      INA              ; [Increment A]
9370:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
9372:      SABB             ; [AL - BL -> BL]
9373:      BLE   D937A      ; =+5 [Branch if less than or equal to zero]
9375:      LDB=  X'00F6'    ; =0x00f6 =246 =NUL,'v' [Load B with immediate]
9378:      ADD   B,A        ; [B + A -> A]
937a:D937A STA/  W853F      ; =0x853f =34111(-31425) [Store A direct]
937d:      STA/  W86D2      ; =0x86d2 =34514(-31022) [Store A direct]
9380:      STA   W938F+1    ; =+14 [Store A relative]
9382:      JSR/  F83E2      ; =0x83e2 =33762(-31774) [Jump to subroutine direct]
9385:      DB    X'02'      ; =0x02 =2
9386:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9388:      LDB=  X'C0C0'    ; =0xc0c0 =49344(-16192) ='@','@' [Load B with immediate]
938b:      STB+  A+         ; [Store B indexed, direct, post-incremented]
938d:      STB+  A+         ; [Store B indexed, direct, post-incremented]
938f:W938F LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
9392:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9394:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9396:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
9399:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
939c:      DB    X'02'      ; =0x02 =2
939d:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
93a0:W93A0 LDAB/ B82AE+1    ; =0x82af =33455(-32081) [Load AL direct]
93a3:      STAB/ B83EC      ; =0x83ec =33772(-31764) [Store AL direct]
93a6:      LDAB+ Z          ; [Load AL from address in Z]
93a7:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
93aa:      BM    D9347      ; =-101 [Branch on minus]
93ac:      JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
93af:      DW    W949A      ; =0x949a =38042(-27494)
*
93b1:      JSR/  F9674      ; =0x9674 =38516(-27020) [Jump to subroutine direct]
93b4:      DC    'TO'       ; hex:d4cf dec:54479(-49)
93b6:      DB    X'01'      ; =0x01 =1
93b7:      LDAB+ Z          ; [Load AL from address in Z]
93b8:      JSR/  F9618      ; =0x9618 =38424(-27112) [Jump to subroutine direct]
93bb:      BM    D9347      ; =-118 [Branch on minus]
93bd:      JSR/  F96CE      ; =0x96ce =38606(-26930) [Jump to subroutine direct]
93c0:      DW    S9431      ; =0x9431 =37937(-27599)
93c2:      LDB=  S9431      ; =0x9431 =37937(-27599) [Load B with immediate]
93c5:      JSR/  F8CF9      ; =0x8cf9 =36089(-29447) =FF,'y' [Jump to subroutine direct]
93c8:      BZ    D93CF      ; =+5 [Branch if zero]
93ca:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
93cd:      DW    W8FA6      ; =0x8fa6 =36774(-28762)
*
93cf:D93CF LDB=  W949A      ; =0x949a =38042(-27494) [Load B with immediate]
93d2:      JSR/  F8CF9      ; =0x8cf9 =36089(-29447) =FF,'y' [Jump to subroutine direct]
93d5:      BZ    D9359      ; =-126 [Branch if zero]
93d7:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
93d9:      LDB/  S9431      ; =0x9431 =37937(-27599) [Load B direct]
93dc:      STB+  A+         ; [Store B indexed, direct, post-incremented]
93de:      LDB/  S9433      ; =0x9433 =37939(-27597) [Load B direct]
93e1:      STB+  A+         ; [Store B indexed, direct, post-incremented]
93e3:      LDB/  S9435      ; =0x9435 =37941(-27595) [Load B direct]
93e6:      STB+  A          ; [Store B to address in A]
93e7:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
93e9:      LDB=  W86C8      ; =0x86c8 =34504(-31032) [Load B with immediate]
93ec:      JSR/  F83DE      ; =0x83de =33758(-31778) [Jump to subroutine direct]
93ef:      DB    X'02'      ; =0x02 =2
93f0:      JMP/  J81F5      ; =0x81f5 =33269(-32267) [Jump direct]
*
93f3:      DS    4          ; =0x0004 [Uninitialized memory]
93f7:W93F7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93f9:W93F9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93fb:W93FB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93fd:W93FD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93ff:W93FF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9401:      DW    X'018B'    ; =0x018b =395
9403:W9403 DW    X'0300'    ; =0x0300 =768
9405:      DW    X'0700'    ; =0x0700 =1792
9407:W9407 DW    X'0001'    ; =0x0001 =1
9409:      DB    X'8C'      ; =0x8c =140(-116) =FF
940a:W940A DW    X'0013'    ; =0x0013 =19
940c:      DC    '(MORE DATA FOLLOWS)'
941f:W941F DW    X'0022'    ; =0x0022 =34
9421:      DC    'DIRECTORY NAME= '
9431:S9431 DC    'XX'       ; hex:d8d8 dec:55512(-40)
9433:S9433 DC    'XX'       ; hex:d8d8 dec:55512(-40)
9435:S9435 DC    'XX ON DISK '
9440:S9440 DC    '0'        ; hex:b0 dec:176(-80)
9441:S9441 DC    '0'        ; hex:b0 dec:176(-80)
9442:      DB    X'8D'      ; =0x8d =141(-115) =CR
9443:W9443 DW    X'0022'    ; =0x0022 =34
9445:      DC    '           **ADDR**  ****SIZE****'
9466:      DB    X'8D'      ; =0x8d =141(-115) =CR
9467:W9467 DW    X'002F'    ; =0x002f =47
9469:      DC    'NAME   TYP BDA  BBP  TRK SEC BYTE   STA   DATE'
9497:      DB    X'8D'      ; =0x8d =141(-115) =CR
9498:W9498 DW    X'0031'    ; =0x0031 =49
949a:W949A DS    8          ; =0x0008 [Uninitialized memory]
94a2:B94A2 DS    3          ; =0x0003 [Uninitialized memory]
94a5:W94A5 DS    2          ; =0x0002 [Uninitialized memory]
94a7:W94A7 DS    5          ; =0x0005 [Uninitialized memory]
94ac:S94AC DS    4          ; =0x0004 [Uninitialized memory]
94b0:S94B0 DS    5          ; =0x0005 [Uninitialized memory]
94b5:S94B5 DS    5          ; =0x0005 [Uninitialized memory]
94ba:S94BA DS    5          ; =0x0005 [Uninitialized memory]
94bf:B94BF DS    3          ; =0x0003 [Uninitialized memory]
94c2:S94C2 DS    8          ; =0x0008 [Uninitialized memory]
94ca:      DB    X'8D'      ; =0x8d =141(-115) =CR
94cb:W94CB DW    X'0026'    ; =0x0026 =38
94cd:S94CD DC    '        BYTES USED, '
94e1:S94E1 DC    '        AVAILABLE'
94f2:      DB    X'8D'      ; =0x8d =141(-115) =CR
94f3:W94F3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
94f5:W94F5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
94f7:B94F7 DB    X'00'      ; =0x00 =0 =NUL
94f8:S94F8 DC    'DBACE'    ; hex:c4c2c1c3c5
*
* Function F94FD
*
94fd:F94FD XFR   Y,A        ; [Transfer Y to A]
94ff:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9501:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
9504:      LDA+  A,3        ; [Load A indexed, displaced, direct]
9507:W9507 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
950a:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
950c:      INA              ; [Increment A]
950d:      INA              ; [Increment A]
950e:      XAZ              ; [Transfer A to Z]
950f:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9511:      STA   W953B+1    ; =+41 [Store A relative]
9513:      XAY              ; [Transfer A to Y]
9514:      CLA              ; [Clear A]
9515:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
9517:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9519:D9519 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
951b:      BNZ   D9527      ; =+10 [Branch if not zero]
951d:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
951f:      JSR   F953A      ; =+25 [Jump to subroutine relative]
9521:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9523:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9525:      XAY              ; [Transfer A to Y]
9526:      RSR              ; [Return from subroutine]
*
9527:D9527 LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
9529:      SABB             ; [AL - BL -> BL]
952a:      BZ    D9530      ; =+4 [Branch if zero]
952c:D952C JSR   F953A      ; =+12 [Jump to subroutine relative]
952e:      JMP   D9519      ; =-23 [Jump relative]
9530:D9530 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9532:      BNZ   D954A      ; =+22 [Branch if not zero]
9534:D9534 DCR   Z          ; [Decrement Z by 1]
9536:      LDAB= X'A3'      ; =163(-93) ='#' [Load AL with immediate]
9538:      JMP   D952C      ; =-14 [Jump relative]
*
* Function F953A
*
953a:F953A STAB+ Y          ; [Store AL to address in Y]
953b:W953B LDA/  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A direct]
953e:      INA              ; [Increment A]
953f:      LDB=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load B with immediate]
9542:      SAB              ; [A - B -> B]
9543:      BGZ   D9549      ; =+4 [Branch if greater than zero]
9545:      STA*  W953B+1    ; =-11 [Store A relative indirect]
9547:      INR   Y          ; [Increment Y by 1]
9549:D9549 RSR              ; [Return from subroutine]
*
954a:D954A LDX   W9507+1    ; =-68 [Load X relative]
954c:      JSR/  F960C      ; =0x960c =38412(-27124) [Jump to subroutine direct]
954f:      BM    D957C      ; =+43 [Branch on minus]
9551:      CLA              ; [Clear A]
9552:      XFRB  BL,AL      ; [Transfer BL to AL]
9554:      LDBB+ X,22       ; [Load BL indexed, displaced, direct]
9557:      SABB             ; [AL - BL -> BL]
9558:      BP    D9534      ; =-38 [Branch on plus]
955a:      SLA              ; [Left shift A]
955b:      XAB              ; [Transfer A to B]
955c:      SLA              ; [Left shift A]
955d:      AAB              ; [A + B -> B]
955e:      LDA+  X,23       ; [Load A indexed, displaced, direct]
9561:      ADD   B,A        ; [B + A -> A]
9563:D9563 XFR   Z,B        ; [Transfer Z to B]
9565:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9567:      XAZ              ; [Transfer A to Z]
9568:      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
956b:D956B LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
956d:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
956f:      SABB             ; [AL - BL -> BL]
9570:      BZ    D9574      ; =+2 [Branch if zero]
9572:      JSR   F953A      ; =-58 [Jump to subroutine relative]
9574:D9574 DCX              ; [Decrement X]
9575:      BGZ   D956B      ; =-12 [Branch if greater than zero]
9577:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9579:      XAZ              ; [Transfer A to Z]
957a:      JMP   D9519      ; =-99 [Jump relative]
957c:D957C XFRB  AL,AU      ; [Transfer AL to AU]
957e:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
9581:      STB   S95F8      ; =+117 [Store B relative]
9583:      STB   S95FA      ; =+117 [Store B relative]
9585:      LDB=  S95FC      ; =0x95fc =38396(-27140) [Load B with immediate]
9588:D9588 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
958a:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
958c:      BNZ   D9590      ; =+2 [Branch if not zero]
958e:      JMP   D9534      ; =-92 [Jump relative]
9590:D9590 SUBB  AU,AL      ; [AU - AL -> AL]
9592:      BNZ   D9588      ; =-12 [Branch if not zero]
9594:      CLA              ; [Clear A]
9595:      LDAB+ B          ; [Load AL from address in B]
9596:      BM    D95A8      ; =+16 [Branch on minus]
9598:      CLRB  AU         ; [Clear AU]
959a:      ADD   A,X        ; [A + X -> X]
959c:      LDAB+ X          ; [Load AL from address in X]
959d:D959D JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
95a0:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
95a1:      DW    S95FC      ; =0x95fc =38396(-27140) [address of end of string]
*
95a3:D95A3 LDA=  S95F7      ; =0x95f7 =38391(-27145) [Load A with immediate]
95a6:      JMP   D9563      ; =-69 [Jump relative]
95a8:D95A8 INAB             ; [Increment AL]
95a9:      BNZ   D95B3      ; =+8 [Branch if not zero]
95ab:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
95ae:      LDAB+ B,5        ; [Load AL indexed, displaced, direct]
95b1:      JMP   D959D      ; =-22 [Jump relative]
95b3:D95B3 LDAB+ Z          ; [Load AL from address in Z]
95b4:      JSR/  F960C      ; =0x960c =38412(-27124) [Jump to subroutine direct]
95b7:      BM    D95CC      ; =+19 [Branch on minus]
95b9:      LDX/  X'005A'    ; =0x005a =90 [Load X direct]
95bc:      LDA+  X,7        ; [Load A indexed, displaced, direct]
95bf:D95BF LDX+  A+         ; [Load X indexed, direct, post-incremented]
95c1:      BNZ   D95C6      ; =+3 [Branch if not zero]
95c3:      JMP/  D9534      ; =0x9534 =38196(-27340) [Jump direct]
95c6:D95C6 DCRB  BL         ; [Decrement BL by 1]
95c8:      BP    D95BF      ; =-11 [Branch on plus]
95ca:      INR   Z          ; [Increment Z by 1]
95cc:D95CC LDA+  X,10       ; [Load A indexed, displaced, direct]
95cf:      LDB+  X,12       ; [Load B indexed, displaced, direct]
95d2:      SUB   B,A        ; [B - A -> A]
95d4:      BZ    D95D7      ; =+1 [Branch if zero]
95d6:      INA              ; [Increment A]
95d7:D95D7 CLR   X          ; [Clear X]
95d9:      XAB              ; [Transfer A to B]
95da:      BP    D95E5      ; =+9 [Branch on plus]
95dc:      LDA=  X'D8F0'    ; =0xd8f0 =55536(-10000) ='X','p' [Load A with immediate]
95df:D95DF INX              ; [Increment X]
95e0:      AAB              ; [A + B -> B]
95e1:      BM    D95DF      ; =-4 [Branch on minus]
95e3:      XFR   B,A        ; [Transfer B to A]
95e5:D95E5 JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
95e8:      DB    X'2E'      ; =0x2e =46 [Service call CVR16 - 16-bit convert to decimal from A register]
95e9:      DW    S95FC      ; =0x95fc =38396(-27140) [address of end of string]
95eb:      LDAB  S95F8      ; =+11 [Load AL relative]
95ed:      JMP   D95F0      ; =+1 [Jump relative]
95ef:D95EF INAB             ; [Increment AL]
95f0:D95F0 DCX              ; [Decrement X]
95f1:      BP    D95EF      ; =-4 [Branch on plus]
95f3:      STAB  S95F8      ; =+3 [Store AL relative]
95f5:      JMP   D95A3      ; =-84 [Jump relative]
*
95f7:S95F7 DC    ' '        ; hex:a0 dec:160(-96)
95f8:S95F8 DC    '  '       ; hex:a0a0 dec:41120(-96)
95fa:S95FA DC    '  '       ; hex:a0a0 dec:41120(-96)
95fc:S95FC DC    ' I'       ; hex:a0c9 dec:41161(-55)
95fe:      DB    X'01'      ; =0x01 =1
95ff:      DC    'C'        ; hex:c3 dec:195(-61)
9600:      DB    X'14'      ; =0x14 =20
9601:      DC    'U'        ; hex:d5 dec:213(-43)
9602:      DB    X'15'      ; =0x15 =21
9603:      DC    'V'        ; hex:d6 dec:214(-42)
9604:      DB    X'24'      ; =0x24 =36
9605:      DC    'D'        ; hex:c4 dec:196(-60)
9606:      DB    X'2D'      ; =0x2d =45
9607:      DC    'M~S'      ; hex:cdfed3
960a:      DW    X'FF00'    ; =0xff00 =65280(-256)
*
*
* Function F960C
*
960c:F960C LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
960e:      SABB             ; [AL - BL -> BL]
960f:      BLE   D9614      ; =+3 [Branch if less than or equal to zero]
9611:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
9613:      RSR              ; [Return from subroutine]
*
9614:D9614 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
9616:      SABB             ; [AL - BL -> BL]
9617:      RSR              ; [Return from subroutine]
*
* Function F9618
*
9618:F9618 LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
961a:      SABB             ; [AL - BL -> BL]
961b:      BLE   D9620      ; =+3 [Branch if less than or equal to zero]
961d:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
961f:      RSR              ; [Return from subroutine]
*
9620:D9620 LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
9622:      SABB             ; [AL - BL -> BL]
9623:      RSR              ; [Return from subroutine]
*
* Function F9624
*
9624:F9624 JSR   F9618      ; =-14 [Jump to subroutine relative]
9626:      BP    D962A      ; =+2 [Branch on plus]
9628:      JSR   F960C      ; =-30 [Jump to subroutine relative]
962a:D962A RSR              ; [Return from subroutine]
*
* Function F962B
*
962b:F962B LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
962d:D962D LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
962f:      SABB             ; [AL - BL -> BL]
9630:      BZ    D962D      ; =-5 [Branch if zero]
9632:      DCR   Z          ; [Decrement Z by 1]
9634:      RSR              ; [Return from subroutine]
*
* Function F9635
*
9635:F9635 XFR   Z,A        ; [Transfer Z to A]
9637:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9639:D9639 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
963b:      JSR   F9624      ; =-25 [Jump to subroutine relative]
963d:      BP    D9639      ; =-6 [Branch on plus]
963f:      DCR   Z          ; [Decrement Z by 1]
9641:      LDA+  S          ; [Load A from address in S]
9642:      SUB   Z,A        ; [Z - A -> A]
9644:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9646:      JSR   F962B      ; =-29 [Jump to subroutine relative]
9648:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
964a:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
964c:      RSR              ; [Return from subroutine]
*
* Function F964D
*
964d:F964D LDAB+ Z          ; [Load AL from address in Z]
964e:      JSR   F960C      ; =-68 [Jump to subroutine relative]
9650:      BP    D9657      ; =+5 [Branch on plus]
9652:      JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
9655:      DW    W974D      ; =0x974d =38733(-26803)
*
9657:D9657 CLA              ; [Clear A]
9658:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
965a:D965A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
965c:      JSR   F960C      ; =-82 [Jump to subroutine relative]
965e:      BP    D9667      ; =+7 [Branch on plus]
9660:      DCR   Z          ; [Decrement Z by 1]
9662:      JSR   F962B      ; =-57 [Jump to subroutine relative]
9664:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9666:      RSR              ; [Return from subroutine]
*
9667:D9667 LDA+  S          ; [Load A from address in S]
9668:      STBB+ S          ; [Store BL to address in S]
9669:      SLA              ; [Left shift A]
966a:      XAB              ; [Transfer A to B]
966b:      SLA              ; [Left shift A]
966c:      SLA              ; [Left shift A]
966d:      AAB              ; [A + B -> B]
966e:      CLA              ; [Clear A]
966f:      LDAB+ S          ; [Load AL from address in S]
9670:      AAB              ; [A + B -> B]
9671:      STB+  S          ; [Store B to address in S]
9672:      JMP   D965A      ; =-26 [Jump relative]
*
* Function F9674
*
9674:F9674 XFR   Z,A        ; [Transfer Z to A]
9676:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9678:      CLAB             ; [Clear AL]
9679:D9679 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
967b:      BP    D968B      ; =+14 [Branch on plus]
967d:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
967f:      SABB             ; [AL - BL -> BL]
9680:      BZ    D9679      ; =-9 [Branch if zero]
9682:D9682 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
9684:      BM    D9682      ; =-4 [Branch on minus]
9686:D9686 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9688:      XAZ              ; [Transfer A to Z]
9689:      CLA              ; [Clear A]
968a:      RSR              ; [Return from subroutine]
*
968b:D968B JSR   F9624      ; =-105 [Jump to subroutine relative]
968d:      BM    D9694      ; =+5 [Branch on minus]
968f:      LDAB+ Z          ; [Load AL from address in Z]
9690:      JSR   F9624      ; =-110 [Jump to subroutine relative]
9692:      BP    D9686      ; =-14 [Branch on plus]
9694:D9694 JSR   F962B      ; =-107 [Jump to subroutine relative]
9696:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9698:      CLA              ; [Clear A]
9699:      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
969c:      RSR              ; [Return from subroutine]
*
969d:      DW    X'8581'    ; =0x8581 =34177(-31359)
969f:      DC    '@P'       ; hex:c0d0 dec:49360(-48)
96a1:      DW    X'4914'    ; =0x4914 =18708
96a3:      DW    X'0A31'    ; =0x0a31 =2609
96a5:      DW    X'8091'    ; =0x8091 =32913(-32623)
96a7:      DW    W9507+1    ; =0x9508 =38152(-27384)
96a9:      DW    X'8508'    ; =0x8508 =34056(-31480)
96ab:      DW    X'0173'    ; =0x0173 =371
96ad:      DW    X'027B'    ; =0x027b =635
96af:      DW    X'9D6D'    ; =0x9d6d =40301(-25235)
96b1:      DC    '"Q'       ; hex:a2d1 dec:41681(-47)
96b3:      DB    X'00'      ; =0x00 =0 =NUL
96b4:      DW    X'5A65'    ; =0x5a65 =23141
96b6:      DW    X'2807'    ; =0x2807 =10247
96b8:      DC    'U'        ; hex:d5 dec:213(-43)
96b9:      DW    X'4114'    ; =0x4114 =16660
96bb:      DB    X'0D'      ; =0x0d =13
96bc:      DC    'E'        ; hex:c5 dec:197(-59)
96bd:      DW    X'2801'    ; =0x2801 =10241
96bf:      DW    X'4915'    ; =0x4915 =18709
96c1:      DC    'v'        ; hex:f6 dec:246(-10)
96c2:      DW    X'5540'    ; =0x5540 =21824
96c4:      DW    X'3939'    ; =0x3939 =14649
96c6:      DB    X'65'      ; =0x65 =101
96c7:      DC    '!'        ; hex:a1 dec:161(-95)
96c8:      DW    X'0979'    ; =0x0979 =2425
96ca:      DW    W83F3      ; =0x83f3 =33779(-31757)
96cc:      DW    W9767      ; =0x9767 =38759(-26777)
*
* Function F96CE
*
96ce:F96CE LDA+  X+         ; [Load A indexed, direct, post-incremented]
96d0:      STA   W96DD      ; =+11 [Store A relative]
96d2:      JSR/  F9635      ; =0x9635 =38453(-27083) [Jump to subroutine direct]
96d5:      STA   W96DF      ; =+8 [Store A relative]
96d7:      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
96da:      JSR/  J9940      ; =0x9940 =39232(-26304) [Jump to subroutine direct]
96dd:W96DD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
96df:W96DF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
96e1:      RSR              ; [Return from subroutine]
*
* Function F96E2
*
96e2:F96E2 STX-  S-         ; [Store X indexed, pre-decremented, direct]
96e4:      XFR   Y,A        ; [Transfer Y to A]
96e6:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
96e8:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
96eb:      LDA+  A,9        ; [Load A indexed, displaced, direct]
96ee:      XAY              ; [Transfer A to Y]
96ef:      LDAB+ Z          ; [Load AL from address in Z]
96f0:      JSR/  F960C      ; =0x960c =38412(-27124) [Jump to subroutine direct]
96f3:      BM    D9726      ; =+49 [Branch on minus]
96f5:      JSR/  F964D      ; =0x964d =38477(-27059) [Jump to subroutine direct]
96f8:D96F8 LDX+  Y+         ; [Load X indexed, direct, post-incremented]
96fa:      BZ    D9721      ; =+37 [Branch if zero]
96fc:      LDBB+ X          ; [Load BL from address in X]
96fd:      BZ    D96F8      ; =-7 [Branch if zero]
96ff:      LDB+  X,1        ; [Load B indexed, displaced, direct]
9702:      LDBB= X'04'      ; =4 [Load BL with immediate]
9704:      SUBB  BU,BL      ; [BU - BL -> BL]
9706:      BNZ   D96F8      ; =-16 [Branch if not zero]
9708:      LDBB+ X,2        ; [Load BL indexed, displaced, direct]
970b:      SABB             ; [AL - BL -> BL]
970c:      BNZ   D96F8      ; =-22 [Branch if not zero]
970e:D970E LDA/  X'005A'    ; =0x005a =90 [Load A direct]
9711:      LDA+  A,9        ; [Load A indexed, displaced, direct]
9714:      SUB   Y,A        ; [Y - A -> A]
9716:      SRA              ; [Right shift A]
9717:      DCA              ; [Decrement A]
9718:      XAB              ; [Transfer A to B]
9719:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
971b:      XAY              ; [Transfer A to Y]
971c:      XFR   X,A        ; [Transfer X to A]
971e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9720:      RSR              ; [Return from subroutine]
*
9721:D9721 JSR/  W83F3      ; =0x83f3 =33779(-31757) [Jump to subroutine direct]
9724:      DW    W977B      ; =0x977b =38779(-26757)
*
9726:D9726 JSR   F96CE      ; =-90 [Jump to subroutine relative]
9728:      DW    W9747      ; =0x9747 =38727(-26809)
*
972a:D972A LDX+  Y+         ; [Load X indexed, direct, post-incremented]
972c:      BZ    D9721      ; =-13 [Branch if zero]
972e:      LDBB+ X          ; [Load BL from address in X]
972f:      BZ    D972A      ; =-7 [Branch if zero]
9731:      LDA=  X'0007'    ; =0x0007 =7 [Load A with immediate]
9734:      ADD   X,A        ; [X + A -> A]
9736:      STA   W973F      ; =+7 [Store A relative]
9738:      JSR/  F98EF      ; =0x98ef =39151(-26385) [Jump to subroutine direct]
973b:      DW    X'0006'    ; =0x0006 =6
973d:      DW    W9747      ; =0x9747 =38727(-26809)
973f:W973F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9741:      XFRB  BL,BL      ; [Transfer BL to BL]
9743:      BZ    D970E      ; =-55 [Branch if zero]
9745:      JMP   D972A      ; =-29 [Jump relative]
*
9747:W9747 DS    6          ; =0x0006 [Uninitialized memory]
974d:W974D DW    X'0018'    ; =0x0018 =24
974f:      DC    'CONTROL STATEMENT ERROR'
9766:      DB    X'8D'      ; =0x8d =141(-115) =CR
9767:W9767 DW    X'0012'    ; =0x0012 =18
9769:      DC    'ILLEGAL PARTITION'
977a:      DB    X'8D'      ; =0x8d =141(-115) =CR
977b:W977B DW    X'0016'    ; =0x0016 =22
977d:      DC    'ILLEGAL PHYSICAL UNIT'
9792:      DB    X'8D'      ; =0x8d =141(-115) =CR
9793:W9793 DB    X'0B'      ; =0x0b =11
9794:      DW    W9818      ; =0x9818 =38936(-26600)
9796:      DW    W985D      ; =0x985d =39005(-26531)
9798:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
979a:      DW    W97AA      ; =0x97aa =38826(-26710)
979c:      DB    0,12       ; =0x00,0x000c
97a8:      DW    W98EB      ; =0x98eb =39147(-26389)
*
97aa:W97AA XFR   Z,B        ; [Transfer Z to B]
97ac:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
97af:      DB    X'0C'      ; =0x0c =12 [Service call PGIOB - protected get I/O block]
97b0:      XFR   B,Y        ; [Transfer B to Y]
97b2:      BZ    D97DD      ; =+41 [Branch if zero]
97b4:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
97b7:      STA+  Z,18       ; [Store A indexed, displaced, direct]
97ba:      STA+  Z,22       ; [Store A indexed, displaced, direct]
97bd:      LDA+  Y,10       ; [Load A indexed, displaced, direct]
97c0:      STA+  Z,20       ; [Store A indexed, displaced, direct]
97c3:      STA+  Z,24       ; [Store A indexed, displaced, direct]
97c6:      LDAB+ Y,7        ; [Load AL indexed, displaced, direct]
97c9:      LDBB+ Z,13       ; [Load BL indexed, displaced, direct]
97cc:      BM    D97D6      ; =+8 [Branch on minus]
97ce:      SABB             ; [AL - BL -> BL]
97cf:      BZ    D97D6      ; =+5 [Branch if zero]
97d1:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
97d4:      DB    X'09'      ; =0x09 =9 [Service call ABRT - abort task]
97d5:      DB    X'12'      ; =0x12 =18 [abort code]
*
97d6:D97D6 LDA+  Z,6        ; [Load A indexed, displaced, direct]
97d9:      BZ    D97DD      ; =+2 [Branch if zero]
97db:      JSR   F97DF      ; =+2 [Jump to subroutine relative]
97dd:D97DD JMP   D9838      ; =+89 [Jump relative]
*
* Function F97DF
*
97df:F97DF LDA+  Z,22       ; [Load A indexed, displaced, direct]
97e2:      BP    D97E8      ; =+4 [Branch on plus]
97e4:      LDAB= X'01'      ; =1 [Load AL with immediate]
97e6:      JMP   D97FA      ; =+18 [Jump relative]
97e8:D97E8 STA+  Z,18       ; [Store A indexed, displaced, direct]
97eb:      STA+  Z,8        ; [Store A indexed, displaced, direct]
97ee:      JSR   F9806      ; =+22 [Jump to subroutine relative]
97f0:      DB    X'01'      ; =0x01 =1
97f1:      LDB+  Z,6        ; [Load B indexed, displaced, direct]
97f4:      LDB+  B,3        ; [Load B indexed, displaced, direct]
97f7:      STB+  Z,22       ; [Store B indexed, displaced, direct]
97fa:D97FA STAB+ Z          ; [Store AL to address in Z]
97fb:      RSR              ; [Return from subroutine]
*
* Function F97FC
*
97fc:F97FC LDAB+ Z          ; [Load AL from address in Z]
97fd:      BP    D9805      ; =+6 [Branch on plus]
97ff:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
9802:      DB    X'07'      ; =0x07 =7 [Service call WT - unconditional wait]
9803:      JMP   F97FC      ; =-9 [Jump relative]
9805:D9805 RSR              ; [Return from subroutine]
*
* Function F9806
*
9806:F9806 XFR   Z,B        ; [Transfer Z to B]
9808:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
980a:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
980d:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
9810:      DB    X'00'      ; =0x00 =0 =NUL [Service call PIOC - physical i/o control]
*
9811:      JSR   F97FC      ; =-23 [Jump to subroutine relative]
9813:      RSR              ; [Return from subroutine]
*
9814:D9814 CLA              ; [Clear A]
9815:      STA+  Z,24       ; [Store A indexed, displaced, direct]
9818:W9818 LDA+  Z,6        ; [Load A indexed, displaced, direct]
981b:W981B LDB=  X'0007'    ; =0x0007 =7 [Load B with immediate]
981e:      AAB              ; [A + B -> B]
981f:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
9822:      STA+  Z,20       ; [Store A indexed, displaced, direct]
9825:      ADD   B,A        ; [B + A -> A]
9827:      XAY              ; [Transfer A to Y]
9828:      LDA+  Y          ; [Load A from address in Y]
9829:      BP    D9841      ; =+22 [Branch on plus]
982b:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
982d:      LDAB= X'01'      ; =1 [Load AL with immediate]
982f:      SUBB  AU,BL      ; [AU - BL -> BL]
9831:      BZ    D9837      ; =+4 [Branch if zero]
9833:      JSR   F97DF      ; =-86 [Jump to subroutine relative]
9835:      BZ    D9814      ; =-35 [Branch if zero]
9837:D9837 STAB+ Z          ; [Store AL to address in Z]
9838:D9838 LDA+  S+         ; [Load A indexed, direct, post-incremented]
983a:      XAZ              ; [Transfer A to Z]
983b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
983d:      XAY              ; [Transfer A to Y]
983e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9840:      RSR              ; [Return from subroutine]
*
9841:D9841 CLRB  AU         ; [Clear AU]
9843:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
9846:      ADD   B,A        ; [B + A -> A]
9848:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
984b:      AAB              ; [A + B -> B]
984c:      STB+  Z,24       ; [Store B indexed, displaced, direct]
984f:      LDB+  Z,16       ; [Load B indexed, displaced, direct]
9852:      XAX              ; [Transfer A to X]
9853:D9853 CLAB             ; [Clear AL]
9854:      DCX              ; [Decrement X]
9855:      BLE   D9837      ; =-32 [Branch if less than or equal to zero]
9857:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9859:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
985b:      JMP   D9853      ; =-10 [Jump relative]
985d:W985D LDA+  Z,6        ; [Load A indexed, displaced, direct]
9860:      XAY              ; [Transfer A to Y]
9861:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
9864:      STA+  Z,20       ; [Store A indexed, displaced, direct]
9867:      LDB   W981B+1    ; =-77 [Load B relative]
9869:      AAB              ; [A + B -> B]
986a:      ADD   B,Y        ; [B + Y -> Y]
986c:      LDX+  Z,16       ; [Load X indexed, displaced, direct]
986f:      LDB+  X          ; [Load B from address in X]
9870:      BP    D9877      ; =+5 [Branch on plus]
9872:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
9874:      STBB+ Y          ; [Store BL to address in Y]
9875:      JMP   D98A6      ; =+47 [Jump relative]
9877:D9877 CLRB  BU         ; [Clear BU]
9879:      AAB              ; [A + B -> B]
987a:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
987d:      AAB              ; [A + B -> B]
987e:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9881:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
9884:      SAB              ; [A - B -> B]
9885:      BP    D988D      ; =+6 [Branch on plus]
9887:      JSR   F98B8      ; =+47 [Jump to subroutine relative]
9889:      BZ    W985D      ; =-46 [Branch if zero]
988b:      JMP   D9837      ; =-86 [Jump relative]
988d:D988D LDA+  X+         ; [Load A indexed, direct, post-incremented]
988f:      XAB              ; [Transfer A to B]
9890:      CLRB  AU         ; [Clear AU]
9892:      STB+  Y+         ; [Store B indexed, direct, post-incremented]
9894:      ADDB  BL,BU      ; [BL + BU -> BU]
9896:      INA              ; [Increment A]
9897:D9897 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
9899:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
989b:      ADDB  BL,BU      ; [BL + BU -> BU]
989d:      DCA              ; [Decrement A]
989e:      BP    D9897      ; =-9 [Branch on plus]
98a0:      XABB             ; [Transfer AL to BL]
98a1:      IVRB  BU         ; [Invert BU]
98a3:      INRB  BU         ; [Increment BU by 1]
98a5:      STB+  Y          ; [Store B to address in Y]
98a6:D98A6 CLAB             ; [Clear AL]
98a7:D98A7 JMP   D9837      ; =-114 [Jump relative]
*
* Function F98A9
*
98a9:F98A9 CLA              ; [Clear A]
98aa:      STA+  Z,24       ; [Store A indexed, displaced, direct]
98ad:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
98b0:      STA+  Z,8        ; [Store A indexed, displaced, direct]
98b3:      JSR/  F9806      ; =0x9806 =38918(-26618) [Jump to subroutine direct]
98b6:      DB    X'02'      ; =0x02 =2
98b7:      RSR              ; [Return from subroutine]
*
* Function F98B8
*
98b8:F98B8 JSR   F98A9      ; =-17 [Jump to subroutine relative]
98ba:      BNZ   D98E7      ; =+43 [Branch if not zero]
98bc:D98BC JSR/  F97DF      ; =0x97df =38879(-26657) [Jump to subroutine direct]
98bf:      BZ    D98E7      ; =+38 [Branch if zero]
98c1:      LDBB= X'01'      ; =1 [Load BL with immediate]
98c3:      SABB             ; [AL - BL -> BL]
98c4:      BNZ   D98E7      ; =+33 [Branch if not zero]
98c6:      LDB+  Z,18       ; [Load B indexed, displaced, direct]
98c9:      STB   W98DC      ; =+17 [Store B relative]
98cb:      XFR   Z,B        ; [Transfer Z to B]
98cd:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
98d0:      DB    X'0C'      ; =0x0c =12 [Service call PGIOB - protected get I/O block]
98d1:      XFR   B,B        ; [Transfer B to B]
98d3:      BZ    D98E8      ; =+19 [Branch if zero]
98d5:      LDAB+ A,2        ; [Load AL indexed, displaced, direct]
98d8:      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
98db:      DB    X'19'      ; =0x19 =25 [Service call EXP - file expand]
98dc:W98DC HLT              ; [Halt]
98dd:      HLT              ; [Halt]
98de:      XFR   B,B        ; [Transfer B to B]
98e0:      BM    D98E8      ; =+6 [Branch on minus]
98e2:      STB+  Z,22       ; [Store B indexed, displaced, direct]
98e5:      JMP   D98BC      ; =-43 [Jump relative]
98e7:D98E7 RSR              ; [Return from subroutine]
*
98e8:D98E8 LDAB= X'02'      ; =2 [Load AL with immediate]
98ea:      RSR              ; [Return from subroutine]
*
98eb:W98EB JSR   F98A9      ; =-68 [Jump to subroutine relative]
98ed:      JMP   D98A7      ; =-72 [Jump relative]
*
* Function F98EF
*
98ef:F98EF LDB+  X+         ; [Load B indexed, direct, post-incremented]
98f1:      XFR   Z,A        ; [Transfer Z to A]
98f3:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
98f5:      XFR   Y,A        ; [Transfer Y to A]
98f7:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
98f9:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
98fb:      XAZ              ; [Transfer A to Z]
98fc:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
98fe:      XAY              ; [Transfer A to Y]
98ff:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9901:      XFR   B,X        ; [Transfer B to X]
9903:      BZ    D990F      ; =+10 [Branch if zero]
9905:D9905 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9907:      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
9909:      SABB             ; [AL - BL -> BL]
990a:      BNZ   D990F      ; =+3 [Branch if not zero]
990c:      DCX              ; [Decrement X]
990d:      BNZ   D9905      ; =-10 [Branch if not zero]
990f:D990F LDX+  S+         ; [Load X indexed, direct, post-incremented]
9911:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9913:      XAY              ; [Transfer A to Y]
9914:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9916:      XAZ              ; [Transfer A to Z]
9917:      RSR              ; [Return from subroutine]
*
* Function F9918
*
9918:F9918 LDA+  X+         ; [Load A indexed, direct, post-incremented]
991a:      XAB              ; [Transfer A to B]
991b:      JMP/  J9940      ; =0x9940 =39232(-26304) [Jump direct]
*
* Function F991E
*
991e:F991E LDA+  X+         ; [Load A indexed, direct, post-incremented]
9920:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9922:      XFR   Y,X        ; [Transfer Y to X]
9924:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9926:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
9928:      XAY              ; [Transfer A to Y]
9929:D9929 DCX              ; [Decrement X]
992a:      BM    D993A      ; =+14 [Branch on minus]
992c:      LDAB+ Y          ; [Load AL from address in Y]
992d:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
992f:      SABB             ; [AL - BL -> BL]
9930:      BM    D9936      ; =+4 [Branch on minus]
9932:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
9934:      ADDB  BL,AL      ; [BL + AL -> AL]
9936:D9936 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9938:      JMP   D9929      ; =-17 [Jump relative]
993a:D993A LDA+  S+         ; [Load A indexed, direct, post-incremented]
993c:      XAY              ; [Transfer A to Y]
993d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
993f:      RSR              ; [Return from subroutine]
*
9940:J9940 STB-  S-         ; [Store B indexed, pre-decremented, direct]
9942:      SAB              ; [A - B -> B]
9943:      BLE   D9966      ; =+33 [Branch if less than or equal to zero]
9945:      LDB+  X          ; [Load B from address in X]
9946:      JSR/  F9969      ; =0x9969 =39273(-26263) [Jump to subroutine direct]
9949:      DC    ' '        ; hex:a0 dec:160(-96)
*
994a:D994A LDB+  S          ; [Load B from address in S]
994b:      XFR   Y,A        ; [Transfer Y to A]
994d:      STA+  S          ; [Store A to address in S]
994e:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9950:      XAY              ; [Transfer A to Y]
9951:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9953:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9955:      XFR   B,X        ; [Transfer B to X]
9957:D9957 DCX              ; [Decrement X]
9958:      BP    D9960      ; =+6 [Branch on plus]
995a:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
995c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
995e:      XAY              ; [Transfer A to Y]
995f:      RSR              ; [Return from subroutine]
*
9960:D9960 LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
9962:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9964:      JMP   D9957      ; =-15 [Jump relative]
9966:D9966 STA+  S          ; [Store A to address in S]
9967:      JMP   D994A      ; =-31 [Jump relative]
*
* Function F9969
*
9969:F9969 STX-  S-         ; [Store X indexed, pre-decremented, direct]
996b:      XAX              ; [Transfer A to X]
996c:      LDAB+ *S         ; [Load AL indexed, indirect]
996e:D996E DCX              ; [Decrement X]
996f:      BP    D9975      ; =+4 [Branch on plus]
9971:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9973:      INX              ; [Increment X]
9974:      RSR              ; [Return from subroutine]
*
9975:D9975 STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9977:      JMP   D996E      ; =-11 [Jump relative]
*
* Function F9979
*
9979:F9979 STB-  S-         ; [Store B indexed, pre-decremented, direct]
997b:      XFRB  AL,AU      ; [Transfer AL to AU]
997d:      SRAB             ; [Right shift AL]
997e:      SRAB             ; [Right shift AL]
997f:      SRAB             ; [Right shift AL]
9980:      SRAB             ; [Right shift AL]
9981:      LDB=  X'0F0F'    ; =0x0f0f =3855 [Load B with immediate]
9984:      NAB              ; [A & B -> B]
9985:      XFRB  BL,AL      ; [Transfer BL to AL]
9987:      JSR   F9994      ; =+11 [Jump to subroutine relative]
9989:      XFRB  BL,AU      ; [Transfer BL to AU]
998b:      XFRB  BU,AL      ; [Transfer BU to AL]
998d:      JSR   F9994      ; =+5 [Jump to subroutine relative]
998f:      XFRB  BL,AL      ; [Transfer BL to AL]
9991:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
9993:      RSR              ; [Return from subroutine]
*
* Function F9994
*
9994:F9994 LDBB= X'0A'      ; =10 [Load BL with immediate]
9996:      SABB             ; [AL - BL -> BL]
9997:      BM    D999D      ; =+4 [Branch on minus]
9999:      LDBB= X'07'      ; =7 [Load BL with immediate]
999b:      ADDB  BL,AL      ; [BL + AL -> AL]
999d:D999D LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
999f:      AABB             ; [AL + BL -> BL]
99a0:      RSR              ; [Return from subroutine]
*
99a1:ENDPT
