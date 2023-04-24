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
8000:      DS    400        ; =0x0190 [Uninitialized memory]
8190:W8190 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8192:      DW    X'0300'    ; =0x0300 =768
8194:      DW    X'0190'    ; =0x0190 =400
8196:      DW    W8B5C      ; =0x8b5c =35676(-29860)
8198:      DB    0,3        ; =0x00,0x0003
819b:      DW    X'0102'    ; =0x0102 =258
819d:      DW    X'0200'    ; =0x0200 =512
819f:      DB    X'84'      ; =0x84 =132(-124) =EOT
81a0:      DW    W88AF      ; =0x88af =34991(-30545)
81a2:      DB    0,12       ; =0x00,0x000c
81ae:W81AE DW    X'0001'    ; =0x0001 =1
81b0:      DW    X'0300'    ; =0x0300 =768
81b2:      DW    X'0190'    ; =0x0190 =400
81b4:      DW    W8CEF      ; =0x8cef =36079(-29457) =FF,'o'
81b6:      DB    0,3        ; =0x00,0x0003
81b9:      DW    X'0102'    ; =0x0102 =258
81bb:      DW    X'0200'    ; =0x0200 =512
81bd:      DB    X'84'      ; =0x84 =132(-124) =EOT
81be:      DW    W88AF      ; =0x88af =34991(-30545)
81c0:      DB    0,12       ; =0x00,0x000c
81cc:W81CC DB    X'00'      ; =0x00 =0 =NUL
81cd:B81CD DW    X'0201'    ; =0x0201 =513
81cf:      DB    X'00'      ; =0x00 =0 =NUL
81d0:      DW    X'0190'    ; =0x0190 =400
81d2:      DW    W9015      ; =0x9015 =36885(-28651)
81d4:      DB    0,3        ; =0x00,0x0003
81d7:      DW    X'0102'    ; =0x0102 =258
81d9:      DW    X'0200'    ; =0x0200 =512
81db:      DB    X'84'      ; =0x84 =132(-124) =EOT
81dc:      DW    W88AF      ; =0x88af =34991(-30545)
81de:      DB    0,12       ; =0x00,0x000c
81ea:W81EA DW    X'0003'    ; =0x0003 =3
81ec:      DW    X'0100'    ; =0x0100 =256
81ee:      DW    X'0190'    ; =0x0190 =400
81f0:      DW    W8E82      ; =0x8e82 =36482(-29054)
81f2:      DB    0,3        ; =0x00,0x0003
81f5:      DW    X'0102'    ; =0x0102 =258
81f7:      DW    X'0200'    ; =0x0200 =512
81f9:      DB    X'84'      ; =0x84 =132(-124) =EOT
81fa:      DW    W88AF      ; =0x88af =34991(-30545)
81fc:      DB    0,12       ; =0x00,0x000c
8208:W8208 DW    X'0004'    ; =0x0004 =4
820a:      DW    X'0200'    ; =0x0200 =512
820c:W820C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
820e:S820E DB    0,4        ; =0x00,0x0004
8212:W8212 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8214:B8214 DW    X'0102'    ; =0x0102 =258
8216:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8218:W8218 DW    W8A44      ; =0x8a44 =35396(-30140)
821a:      DB    0,12       ; =0x00,0x000c
*
* Function ENTRY
*
8226:ENTRY LDA=  W8190      ; =0x8190 =33168(-32368) [Load A with immediate]
8229:      XAS              ; [Transfer A to S]
822a:      LDA=  W8264      ; =0x8264 =33380(-32156) [Load A with immediate]
822d:      STA/  WA296+1    ; =0xa297 =41623(-23913) [Store A direct]
8230:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8233:      DW    W873B      ; =0x873b =34619(-30917)
*
8235:      JSR   F8242      ; =+11 [Jump to subroutine relative]
8237:      DW    W8190      ; =0x8190 =33168(-32368)
8239:      STA   W8274+1    ; =+58 [Store A relative]
823b:      JSR   F8242      ; =+5 [Jump to subroutine relative]
823d:      DW    W81AE      ; =0x81ae =33198(-32338)
823f:      JMP/  W8583      ; =0x8583 =34179(-31357) [Jump direct]
*
* Function F8242
*
8242:F8242 LDB+  X          ; [Load B from address in X]
8243:      LDA+  B,6        ; [Load A indexed, displaced, direct]
8246:      BZ    D8252      ; =+10 [Branch if zero]
8248:      STB   W824D      ; =+3 [Store B relative]
824a:      SVC   X'05'      ; =5 [Service call TS - load transient module]
824c:      DB    X'0C'      ; =0x0c =12 [Selector: TODO]
824d:W824D DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of TODO]
824f:      STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8252:D8252 STA-  S-         ; [Store A indexed, pre-decremented, direct]
8254:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8256:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8258:      LDAB= X'09'      ; =9 [Load AL with immediate]
825a:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
825d:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
825f:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8261:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8263:      RSR              ; [Return from subroutine]
*
8264:W8264 LDA=  W8190      ; =0x8190 =33168(-32368) [Load A with immediate]
8267:      XAS              ; [Transfer A to S]
8268:      JSR   F82AC      ; =+66 [Jump to subroutine relative]
826a:      SLR   B          ; [Left shift B by 1]
826c:      LDA=  W887B      ; =0x887b =34939(-30597) [Load A with immediate]
826f:      AAB              ; [A + B -> B]
8270:      JMP+  *B         ; [Jump indexed, indirect]
*
* Function F8272
*
8272:F8272 SVC   X'0B'      ; =11 [Service call DT - get binary date]
8274:W8274 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8277:      RSR              ; [Return from subroutine]
*
8278:W8278 LDA/  W8803      ; =0x8803 =34819(-30717) [Load A direct]
827b:      BZ    D828A      ; =+13 [Branch if zero]
827d:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8280:      DW    W87D8      ; =0x87d8 =34776(-30760) =BEL,'X'
8282:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8285:      BNZ   D828A      ; =+3 [Branch if not zero]
8287:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
828a:D828A JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
828d:      DW    W87AD      ; =0x87ad =34733(-30803) =BEL,'-'
828f:      JSR/  FA244      ; =0xa244 =41540(-23996) [Jump to subroutine direct]
8292:      CLA              ; [Clear A]
8293:      LDAB  B829D      ; =+8 [Load AL relative]
8295:      LDB/  W9883      ; =0x9883 =39043(-26493) [Load B direct]
8298:      AAB              ; [A + B -> B]
8299:      STBB  B829D      ; =+2 [Store BL relative]
829b:      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
829d:B829D DB    X'00'      ; =0x00 =0 =NUL [completion code]
*
829e:D829E JSR   F82AC      ; =+12 [Jump to subroutine relative]
82a0:      LDBB= X'CE'      ; =206(-50) ='N' [Load BL with immediate]
82a2:      SABB             ; [AL - BL -> BL]
82a3:      BZ    D82AB      ; =+6 [Branch if zero]
82a5:      LDBB= X'D9'      ; =217(-39) ='Y' [Load BL with immediate]
82a7:      SABB             ; [AL - BL -> BL]
82a8:      BNZ   D829E      ; =-12 [Branch if not zero]
82aa:      XAB              ; [Transfer A to B]
82ab:D82AB RSR              ; [Return from subroutine]
*
* Function F82AC
*
82ac:F82AC JSR/  FA244      ; =0xa244 =41540(-23996) [Jump to subroutine direct]
82af:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
82b1:      JSR/  FA24B      ; =0xa24b =41547(-23989) [Jump to subroutine direct]
82b4:      JSR/  FA27F      ; =0xa27f =41599(-23937) [Jump to subroutine direct]
82b7:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
82b9:      ANDB  BL,AL      ; [BL & AL -> AL]
82bb:      LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
82bd:      SABB             ; [AL - BL -> BL]
82be:      BGZ   F82AC      ; =-20 [Branch if greater than zero]
82c0:      LDB=  X'00C1'    ; =0x00c1 =193 =NUL,'A' [Load B with immediate]
82c3:      SABB             ; [AL - BL -> BL]
82c4:      BM    F82AC      ; =-26 [Branch on minus]
82c6:      RSR              ; [Return from subroutine]
*
* Function F82C7
*
82c7:F82C7 LDA=  W88AF      ; =0x88af =34991(-30545) [Load A with immediate]
82ca:      XAY              ; [Transfer A to Y]
82cb:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
*
* Function F82CD
*
82cd:F82CD LDA+  X+         ; [Load A indexed, direct, post-incremented]
82cf:      XAZ              ; [Transfer A to Z]
82d0:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
82d2:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
82d4:      BZ    D8311      ; =+59 [Branch if zero]
82d6:      STA   W82F0+1    ; =+25 [Store A relative]
82d8:      SUB   B,A        ; [B - A -> A]
82da:      BM    D8311      ; =+53 [Branch on minus]
82dc:      XAX              ; [Transfer A to X]
82dd:D82DD LDAB+ Y          ; [Load AL from address in Y]
82de:      LDBB+ Z          ; [Load BL from address in Z]
82df:      OREB  AL,BL      ; [AL ^ BL -> BL]
82e1:      LDAB= X'DF'      ; =223(-33) =DEL [Load AL with immediate]
82e3:      NABB             ; [AL & BL -> BL]
82e4:      BNZ   D830C      ; =+38 [Branch if not zero]
82e6:      XFR   Y,A        ; [Transfer Y to A]
82e8:      STA   W8301+1    ; =+24 [Store A relative]
82ea:      XFR   Z,A        ; [Transfer Z to A]
82ec:      STA   W8305+1    ; =+24 [Store A relative]
82ee:      STX   W8309+1    ; =+26 [Store X relative]
82f0:W82F0 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
82f3:D82F3 DCX              ; [Decrement X]
82f4:      BM    D8315      ; =+31 [Branch on minus]
82f6:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
82f8:      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
82fa:      OREB  AL,BL      ; [AL ^ BL -> BL]
82fc:      LDAB= X'DF'      ; =223(-33) =DEL [Load AL with immediate]
82fe:      NABB             ; [AL & BL -> BL]
82ff:      BZ    D82F3      ; =-14 [Branch if zero]
8301:W8301 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8304:      XAY              ; [Transfer A to Y]
8305:W8305 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8308:      XAZ              ; [Transfer A to Z]
8309:W8309 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
830c:D830C INR   Y          ; [Increment Y by 1]
830e:      DCX              ; [Decrement X]
830f:      BP    D82DD      ; =-52 [Branch on plus]
8311:D8311 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8313:      CLA              ; [Clear A]
8314:      RSR              ; [Return from subroutine]
*
8315:D8315 LDA   W8301+1    ; =-21 [Load A relative]
8317:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8319:      RSR              ; [Return from subroutine]
*
* Function F831A
*
831a:F831A LDA+  S          ; [Load A from address in S]
831b:      XAZ              ; [Transfer A to Z]
831c:      ADD   B,A        ; [B + A -> A]
831e:      XAY              ; [Transfer A to Y]
831f:      LDB=  B88B1      ; =0x88b1 =34993(-30543) [Load B with immediate]
8322:      SUB   Y,B        ; [Y - B -> B]
8324:      LDA/  W88AF      ; =0x88af =34991(-30545) [Load A direct]
8327:      SAB              ; [A - B -> B]
8328:      JSR   F8333      ; =+9 [Jump to subroutine relative]
832a:      LDA=  B88B1      ; =0x88b1 =34993(-30543) [Load A with immediate]
832d:      SUB   Z,A        ; [Z - A -> A]
832f:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
8332:      RSR              ; [Return from subroutine]
*
* Function F8333
*
8333:F8333 DCR   B          ; [Decrement B by 1]
8335:      BM    D833D      ; =+6 [Branch on minus]
8337:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8339:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
833b:      JMP   F8333      ; =-10 [Jump relative]
833d:D833D RSR              ; [Return from subroutine]
*
* Function F833E
*
833e:F833E LDB=  W88AF      ; =0x88af =34991(-30545) [Load B with immediate]
8341:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8343:      AAB              ; [A + B -> B]
8344:      XFR   B,Z        ; [Transfer B to Z]
8346:      LDB/  W8936      ; =0x8936 =35126(-30410) [Load B direct]
8349:      ADD   B,A        ; [B + A -> A]
834b:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
834e:      ADD   Z,B        ; [Z + B -> B]
8350:D8350 LDA+  S          ; [Load A from address in S]
8351:      SUB   Z,A        ; [Z - A -> A]
8353:      BZ    D835B      ; =+6 [Branch if zero]
8355:      LDAB- Z-         ; [Load AL indexed, pre-decremented, direct]
8357:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
8359:      JMP   D8350      ; =-11 [Jump relative]
835b:D835B LDA=  W8936      ; =0x8936 =35126(-30410) [Load A with immediate]
835e:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8360:      XAY              ; [Transfer A to Y]
8361:      JSR   F8333      ; =-48 [Jump to subroutine relative]
8363:      RSR              ; [Return from subroutine]
*
8364:W8364 CLA              ; [Clear A]
8365:      JMP   D836C      ; =+5 [Jump relative]
8367:W8367 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
836a:      LDAB= X'CB'      ; =203(-53) ='K' [Load AL with immediate]
836c:D836C STAB  B8385+1    ; =+24 [Store AL relative]
836e:      CLA              ; [Clear A]
836f:B836F STAB= X'00'      ; =0 =NUL [Store AL immediate]
8371:      INA              ; [Increment A]
8372:B8372 STAB= X'00'      ; =0 =NUL [Store AL immediate]
8374:D8374 JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
8377:      DW    W8A44      ; =0x8a44 =35396(-30140)
*
8379:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
837c:      DW    W8A44      ; =0x8a44 =35396(-30140)
*
837e:J837E LDAB  B8372+1    ; =-13 [Load AL relative]
8380:      BZ    B8385      ; =+3 [Branch if zero]
8382:      JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8385:B8385 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8387:      BZ    D8390      ; =+7 [Branch if zero]
8389:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
838c:      DW    W88AF      ; =0x88af =34991(-30545)
838e:      JMP   D83A2      ; =+18 [Jump relative]
8390:D8390 JSR/  F8605      ; =0x8605 =34309(-31227) [Jump to subroutine direct]
8393:      BNL   D839C      ; =+7 [Branch on no link]
8395:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8398:      DW    W8776      ; =0x8776 =34678(-30858)
839a:      JMP   D83B8      ; =+28 [Jump relative]
839c:D839C LDAB  B836F+1    ; =-46 [Load AL relative]
839e:      BZ    D83A2      ; =+2 [Branch if zero]
83a0:      JSR   F83F9      ; =+87 [Jump to subroutine relative]
83a2:D83A2 JSR/  F82C7      ; =0x82c7 =33479(-32057) [Jump to subroutine direct]
83a5:      DW    W8A44      ; =0x8a44 =35396(-30140)
83a7:      BZ    J837E      ; =-43 [Branch if zero]
83a9:      LDAB  B836F+1    ; =-59 [Load AL relative]
83ab:      BNZ   D83B8      ; =+11 [Branch if not zero]
83ad:      LDAB  B8385+1    ; =-41 [Load AL relative]
83af:      BNZ   D83B8      ; =+7 [Branch if not zero]
83b1:      JMP   D83E7      ; =+52 [Jump relative]
83b3:W83B3 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
83b6:      DW    W8854      ; =0x8854 =34900(-30636)
*
83b8:D83B8 JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
83bb:W83BB JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
83be:      DW    W87B9      ; =0x87b9 =34745(-30791) =BEL,'9'
83c0:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
83c3:      BZ    D83D5      ; =+16 [Branch if zero]
83c5:      JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
83c8:      JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
83cb:      CLA              ; [Clear A]
83cc:      STAB/ B8372+1    ; =0x8373 =33651(-31885) [Store AL direct]
83cf:      STAB  B836F+1    ; =-97 [Store AL relative]
83d1:      STAB  B8385+1    ; =-77 [Store AL relative]
83d3:      JMP   D8374      ; =-97 [Jump relative]
83d5:D83D5 JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
83d8:W83D8 JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
83db:      DW    W8A44      ; =0x8a44 =35396(-30140)
*
83dd:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
83e0:      DW    W8A44      ; =0x8a44 =35396(-30140)
83e2:      LDA/  W8A44      ; =0x8a44 =35396(-30140) [Load A direct]
83e5:      BNZ   D83EC      ; =+5 [Branch if not zero]
83e7:D83E7 JSR   F83F9      ; =+16 [Jump to subroutine relative]
83e9:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
83ec:D83EC CLA              ; [Clear A]
83ed:      STAB  B8385+1    ; =-105 [Store AL relative]
83ef:      INA              ; [Increment A]
83f0:      STAB/ B8372+1    ; =0x8373 =33651(-31885) [Store AL direct]
83f3:      STAB/ B836F+1    ; =0x8370 =33648(-31888) [Store AL direct]
83f6:      JMP/  J837E      ; =0x837e =33662(-31874) [Jump direct]
*
* Function F83F9
*
83f9:F83F9 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
83fc:      DW    W88AF      ; =0x88af =34991(-30545)
83fe:      RSR              ; [Return from subroutine]
*
83ff:B83FF LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8401:      BNZ   D8405      ; =+2 [Branch if not zero]
8403:      INAB             ; [Increment AL]
8404:      RSR              ; [Return from subroutine]
*
8405:D8405 JSR   F83F9      ; =-14 [Jump to subroutine relative]
8407:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
840a:      DW    W8822      ; =0x8822 =34850(-30686)
840c:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
840f:      RSR              ; [Return from subroutine]
*
8410:W8410 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
8413:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
8416:      DW    W8936      ; =0x8936 =35126(-30410)
*
8418:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
841b:      DW    W89BD      ; =0x89bd =35261(-30275)
*
841d:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
8420:      DW    W89BD      ; =0x89bd =35261(-30275)
8422:      LDA/  W89BD      ; =0x89bd =35261(-30275) [Load A direct]
8425:      BZ    W83B3      ; =-116 [Branch if zero]
8427:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
842a:      DW    W8A44      ; =0x8a44 =35396(-30140)
*
842c:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
842f:      DW    W8A44      ; =0x8a44 =35396(-30140)
8431:      CLA              ; [Clear A]
8432:      STA   W8452+1    ; =+31 [Store A relative]
8434:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8437:      DW    W881B      ; =0x881b =34843(-30693)
8439:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
843c:      STBB  B83FF+1    ; =-62 [Store BL relative]
843e:D843E JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8441:      JSR/  F8605      ; =0x8605 =34309(-31227) [Jump to subroutine direct]
8444:      BL    D8489      ; =+67 [Branch on link]
8446:      JSR/  F82C7      ; =0x82c7 =33479(-32057) [Jump to subroutine direct]
8449:      DW    W89BD      ; =0x89bd =35261(-30275)
844b:      BZ    D8482      ; =+53 [Branch if zero]
844d:      XAX              ; [Transfer A to X]
844e:D844E JSR   B83FF      ; =-81 [Jump to subroutine relative]
8450:      BZ    D846B      ; =+25 [Branch if zero]
8452:W8452 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8455:      INA              ; [Increment A]
8456:      STA   W8452+1    ; =-5 [Store A relative]
8458:      LDB/  W89BD      ; =0x89bd =35261(-30275) [Load B direct]
845b:      JSR/  F831A      ; =0x831a =33562(-31974) [Jump to subroutine direct]
845e:      LDB/  W8936      ; =0x8936 =35126(-30410) [Load B direct]
8461:      BZ    D846B      ; =+8 [Branch if zero]
8463:      JSR/  F833E      ; =0x833e =33598(-31938) [Jump to subroutine direct]
8466:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
8469:      JMP   D846E      ; =+3 [Jump relative]
846b:D846B LDA/  W89BD      ; =0x89bd =35261(-30275) [Load A direct]
846e:D846E XAY              ; [Transfer A to Y]
846f:      ADD   X,Y        ; [X + Y -> Y]
8471:      LDB=  B88B1      ; =0x88b1 =34993(-30543) [Load B with immediate]
8474:      SUB   Y,B        ; [Y - B -> B]
8476:      LDA/  W88AF      ; =0x88af =34991(-30545) [Load A direct]
8479:      SAB              ; [A - B -> B]
847a:      JSR/  F82CD      ; =0x82cd =33485(-32051) [Jump to subroutine direct]
847d:      DW    W89BD      ; =0x89bd =35261(-30275)
847f:      XAX              ; [Transfer A to X]
8480:      BNZ   D844E      ; =-52 [Branch if not zero]
8482:D8482 JSR/  F82C7      ; =0x82c7 =33479(-32057) [Jump to subroutine direct]
8485:      DW    W8A44      ; =0x8a44 =35396(-30140)
8487:      BZ    D843E      ; =-75 [Branch if zero]
8489:D8489 LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
848c:      STA/  S8816      ; =0x8816 =34838(-30698) [Store A direct]
848f:      STA/  S8818      ; =0x8818 =34840(-30696) [Store A direct]
8492:      LDA   W8452+1    ; =-65 [Load A relative]
8494:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
8496:      DW    S881A      ; =0x881a =34842(-30694) [address of end of string]
*
8498:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
849b:      DW    W8805      ; =0x8805 =34821(-30715)
*
849d:      JSR/  F83F9      ; =0x83f9 =33785(-31751) [Jump to subroutine direct]
84a0:D84A0 JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
84a3:W84A3 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
84a6:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
84a9:      DW    W8936      ; =0x8936 =35126(-30410)
*
84ab:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
84ae:      DW    W8936      ; =0x8936 =35126(-30410)
84b0:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
84b3:      BNZ   D84BC      ; =+7 [Branch if not zero]
84b5:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
84b8:      DW    W88AF      ; =0x88af =34991(-30545)
84ba:      JMP   D84A0      ; =-28 [Jump relative]
84bc:D84BC JSR/  F82C7      ; =0x82c7 =33479(-32057) [Jump to subroutine direct]
84bf:      DW    W8936      ; =0x8936 =35126(-30410)
84c1:      BZ    D84FE      ; =+59 [Branch if zero]
84c3:      XAX              ; [Transfer A to X]
84c4:      LDB/  W8936      ; =0x8936 =35126(-30410) [Load B direct]
84c7:      JSR/  F831A      ; =0x831a =33562(-31974) [Jump to subroutine direct]
84ca:D84CA JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
84cd:      DW    W8936      ; =0x8936 =35126(-30410)
84cf:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
84d2:      BZ    D84A0      ; =-52 [Branch if zero]
84d4:      JSR/  F833E      ; =0x833e =33598(-31938) [Jump to subroutine direct]
84d7:      JMP   D84A0      ; =-57 [Jump relative]
84d9:W84D9 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
84dc:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
84df:      DW    W8936      ; =0x8936 =35126(-30410)
*
84e1:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
84e4:      DW    W8936      ; =0x8936 =35126(-30410)
84e6:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
84e9:      BNZ   D84F4      ; =+9 [Branch if not zero]
84eb:      LDX=  W88AF      ; =0x88af =34991(-30545) [Load X with immediate]
84ee:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
84f0:      ADD   A,X        ; [A + X -> X]
84f2:      JMP   D84CA      ; =-42 [Jump relative]
84f4:D84F4 JSR/  F82C7      ; =0x82c7 =33479(-32057) [Jump to subroutine direct]
84f7:      DW    W8936      ; =0x8936 =35126(-30410)
84f9:      BZ    D84FE      ; =+3 [Branch if zero]
84fb:      XAX              ; [Transfer A to X]
84fc:      JMP   D84CA      ; =-52 [Jump relative]
84fe:D84FE JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8501:      DW    W8867      ; =0x8867 =34919(-30617)
8503:      JMP   D8539      ; =+52 [Jump relative]
8505:W8505 JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8508:      JSR/  F8605      ; =0x8605 =34309(-31227) [Jump to subroutine direct]
850b:      BNL   D8514      ; =+7 [Branch on no link]
850d:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8510:      DW    W8776      ; =0x8776 =34678(-30858)
8512:      JMP   D8539      ; =+37 [Jump relative]
8514:D8514 JSR/  F83F9      ; =0x83f9 =33785(-31751) [Jump to subroutine direct]
8517:      JMP   D8539      ; =+32 [Jump relative]
8519:W8519 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
851c:      LDA/  W88AF      ; =0x88af =34991(-30545) [Load A direct]
851f:      STA/  W8936      ; =0x8936 =35126(-30410) [Store A direct]
8522:      JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8525:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
8528:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
852b:      JMP   D8539      ; =+12 [Jump relative]
852d:W852D JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8530:      JMP   D8539      ; =+7 [Jump relative]
8532:W8532 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
8535:      CLA              ; [Clear A]
8536:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
8539:D8539 JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
853c:W853C JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
853f:      DW    W87C9      ; =0x87c9 =34761(-30775) =BEL,'I'
8541:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8544:      BZ    D854E      ; =+8 [Branch if zero]
8546:      JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
8549:      JSR/  F85E7      ; =0x85e7 =34279(-31257) [Jump to subroutine direct]
854c:      JMP   D8539      ; =-21 [Jump relative]
854e:D854E JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
8551:W8551 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8554:      DW    W87E8      ; =0x87e8 =34792(-30744) =BEL,'h'
8556:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8559:      BZ    D854E      ; =-13 [Branch if zero]
855b:      JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
855e:      JSR   F85A0      ; =+64 [Jump to subroutine relative]
8560:      JMP   D8539      ; =-41 [Jump relative]
8562:W8562 JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8565:      JSR/  F8605      ; =0x8605 =34309(-31227) [Jump to subroutine direct]
8568:      BNL   W8562      ; =-8 [Branch on no link]
856a:      JSR/  F85E7      ; =0x85e7 =34279(-31257) [Jump to subroutine direct]
856d:      JSR   F85A0      ; =+49 [Jump to subroutine relative]
856f:W856F LDA=  W8190      ; =0x8190 =33168(-32368) [Load A with immediate]
8572:      LDB   W85D6      ; =+98 [Load B relative]
8574:      STB   W856F+1    ; =-6 [Store B relative]
8576:      STA   W85D6      ; =+94 [Store A relative]
8578:      LDAB/ B829D      ; =0x829d =33437(-32099) [Load AL direct]
857b:      RRRB  AL         ; [Right rotate AL by 1]
857d:      CL               ; [Complement link]
857e:      RLRB  AL         ; [Left rotate AL by 1]
8580:      STAB/ B829D      ; =0x829d =33437(-32099) [Store AL direct]
8583:W8583 LDB   W856F+1    ; =-21 [Load B relative]
8585:      LDAB+ B,1        ; [Load AL indexed, displaced, direct]
8588:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
858a:      AABB             ; [AL + BL -> BL]
858b:      STBB/ S878E      ; =0x878e =34702(-30834) [Store BL direct]
858e:      LDB   W85D6      ; =+70 [Load B relative]
8590:      LDAB+ B,1        ; [Load AL indexed, displaced, direct]
8593:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8595:      AABB             ; [AL + BL -> BL]
8596:      STBB/ S879A      ; =0x879a =34714(-30822) [Store BL direct]
8599:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
859c:      DW    W8784      ; =0x8784 =34692(-30844) =BEL,EOT
859e:      JMP   D8539      ; =-103 [Jump relative]
*
* Function F85A0
*
85a0:F85A0 LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
85a3:      STA/  S884F      ; =0x884f =34895(-30641) [Store A direct]
85a6:      STA/  S8851      ; =0x8851 =34897(-30639) [Store A direct]
85a9:      LDA/  W8803      ; =0x8803 =34819(-30717) [Load A direct]
85ac:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
85ae:      DW    S8853      ; =0x8853 =34899(-30637) [address of end of string]
*
85b0:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
85b3:      DW    W883C      ; =0x883c =34876(-30660)
85b5:      LDB   W85D6      ; =+31 [Load B relative]
85b7:      LDAB+ B          ; [Load AL from address in B]
85b8:      BNZ   D85D8      ; =+30 [Branch if not zero]
85ba:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
85bd:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
85c0:      LDA=  X'848D'    ; =0x848d =33933(-31603) =EOT,CR [Load A with immediate]
85c3:      STA/  B88B1      ; =0x88b1 =34993(-30543) [Store A direct]
85c6:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
85c9:      DB    X'02'      ; =0x02 =2
85ca:      LDB   W85D6      ; =+10 [Load B relative]
85cc:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
85cf:      DB    X'0B'      ; =0x0b =11
85d0:      LDA/  W8274+1    ; =0x8275 =33397(-32139) [Load A direct]
85d3:      SVC   X'05'      ; =5 [Service call TS - load transient module]
85d5:      DB    X'0D'      ; =0x0d =13 [Selector: TODO]
85d6:W85D6 DW    W81AE      ; =0x81ae =33198(-32338) [address of TODO]
*
85d8:D85D8 CLA              ; [Clear A]
85d9:      STA/  W8803      ; =0x8803 =34819(-30717) [Store A direct]
85dc:      LDB/  W85D6      ; =0x85d6 =34262(-31274) [Load B direct]
85df:D85DF JSR   F863D      ; =+92 [Jump to subroutine relative]
85e1:      DB    X'04'      ; =0x04 =4
85e2:      CLA              ; [Clear A]
85e3:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
85e6:      RSR              ; [Return from subroutine]
*
* Function F85E7
*
85e7:F85E7 LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
85ea:      STA/  S8837      ; =0x8837 =34871(-30665) [Store A direct]
85ed:      STA/  S8839      ; =0x8839 =34873(-30663) [Store A direct]
85f0:      LDA/  W8801      ; =0x8801 =34817(-30719) [Load A direct]
85f3:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
85f5:      DW    S883B      ; =0x883b =34875(-30661) [address of end of string]
*
85f7:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
85fa:      DW    W8827      ; =0x8827 =34855(-30681)
85fc:      CLA              ; [Clear A]
85fd:      STA/  W8801      ; =0x8801 =34817(-30719) [Store A direct]
8600:      LDB/  W856F+1    ; =0x8570 =34160(-31376) [Load B direct]
8603:      JMP   D85DF      ; =-38 [Jump relative]
*
* Function F8605
*
8605:F8605 LDB/  W856F+1    ; =0x8570 =34160(-31376) [Load B direct]
8608:      LDAB+ B          ; [Load AL from address in B]
8609:      BNZ   D862C      ; =+33 [Branch if not zero]
860b:      JSR   F863D      ; =+48 [Jump to subroutine relative]
860d:      DB    X'01'      ; =0x01 =1
860e:      BNZ   D862C      ; =+28 [Branch if not zero]
8610:      JSR/  FA2C4      ; =0xa2c4 =41668(-23868) ='"','D' [Jump to subroutine direct]
8613:      DW    W88AF      ; =0x88af =34991(-30545)
8615:      LDA/  W88AF      ; =0x88af =34991(-30545) [Load A direct]
8618:      BNZ   D8623      ; =+9 [Branch if not zero]
861a:      INA              ; [Increment A]
861b:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
861e:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8620:      STAB/ B88B1      ; =0x88b1 =34993(-30543) [Store AL direct]
8623:D8623 LDA/  W8801      ; =0x8801 =34817(-30719) [Load A direct]
8626:      INA              ; [Increment A]
8627:      STA/  W8801      ; =0x8801 =34817(-30719) [Store A direct]
862a:      RL               ; [Reset link]
862b:      RSR              ; [Return from subroutine]
*
862c:D862C DCAB             ; [Decrement AL]
862d:      BNZ   D8631      ; =+2 [Branch if not zero]
862f:D862F SL               ; [Set link]
8630:      RSR              ; [Return from subroutine]
*
8631:D8631 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8633:B8633 BZ    D862F      ; =-6 [Branch if zero]
8635:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8638:      DW    W874A      ; =0x874a =34634(-30902)
863a:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
*
* Function F863D
*
863d:F863D STB-  S-         ; [Store B indexed, pre-decremented, direct]
863f:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8641:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8644:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8646:D8646 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8648:      LDB+  S          ; [Load B from address in S]
8649:      LDAB+ B          ; [Load AL from address in B]
864a:      BM    D8646      ; =-6 [Branch on minus]
864c:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
864e:      XABB             ; [Transfer AL to BL]
864f:      RSR              ; [Return from subroutine]
*
* Function F8650
*
8650:F8650 LDB=  W88AF      ; =0x88af =34991(-30545) [Load B with immediate]
8653:      LDA+  B          ; [Load A from address in B]
8654:      BLE   D8670      ; =+26 [Branch if less than or equal to zero]
8656:      INA              ; [Increment A]
8657:      STA+  B+         ; [Store A indexed, direct, post-incremented]
8659:      AAB              ; [A + B -> B]
865a:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
865c:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
865e:      LDB/  W85D6      ; =0x85d6 =34262(-31274) [Load B direct]
8661:      LDAB+ B          ; [Load AL from address in B]
8662:      BNZ   J8675      ; =+17 [Branch if not zero]
8664:      JSR   F863D      ; =-41 [Jump to subroutine relative]
8666:      DB    X'02'      ; =0x02 =2
8667:      BNZ   J8675      ; =+12 [Branch if not zero]
8669:      LDA/  W8803      ; =0x8803 =34819(-30717) [Load A direct]
866c:      INA              ; [Increment A]
866d:      STA/  W8803      ; =0x8803 =34819(-30717) [Store A direct]
8670:D8670 CLA              ; [Clear A]
8671:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
8674:      RSR              ; [Return from subroutine]
*
8675:J8675 DCRB  AL,2       ; [Decrement AL by 2]
8677:      BZ    D8680      ; =+7 [Branch if zero]
8679:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
867c:      DW    W8758      ; =0x8758 =34648(-30888)
867e:      JMP   D8685      ; =+5 [Jump relative]
8680:D8680 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8683:      DW    W8767      ; =0x8767 =34663(-30873)
*
8685:D8685 JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
8688:W8688 JSR/  F8272      ; =0x8272 =33394(-32142) [Jump to subroutine direct]
868b:      JSR   F8650      ; =-61 [Jump to subroutine relative]
868d:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8690:      DW    W879B      ; =0x879b =34715(-30821)
*
8692:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
8695:      DW    W89BD      ; =0x89bd =35261(-30275)
8697:      LDA=  S89BF      ; =0x89bf =35263(-30273) [Load A with immediate]
869a:      XAY              ; [Transfer A to Y]
869b:      CLR   X          ; [Clear X]
869d:D869D LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
869f:      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
86a1:      SABB             ; [AL - BL -> BL]
86a2:      BGZ   D86B6      ; =+18 [Branch if greater than zero]
86a4:      LDB=  X'00B0'    ; =0x00b0 =176 =NUL,'0' [Load B with immediate]
86a7:      SABB             ; [AL - BL -> BL]
86a8:      BM    D86B6      ; =+12 [Branch on minus]
86aa:      XFR   X,A        ; [Transfer X to A]
86ac:      SLR   A,2        ; [Left shift A by 2]
86ae:      ADD   A,X        ; [A + X -> X]
86b0:      SLR   X          ; [Left shift X by 1]
86b2:      ADD   B,X        ; [B + X -> X]
86b4:      JMP   D869D      ; =-25 [Jump relative]
86b6:D86B6 XFR   X,A        ; [Transfer X to A]
86b8:      LDBB= X'02'      ; =2 [Load BL with immediate]
86ba:      SABB             ; [AL - BL -> BL]
86bb:      BM    W8688      ; =-53 [Branch on minus]
86bd:      STAB/ B81CD      ; =0x81cd =33229(-32307) [Store AL direct]
86c0:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
86c3:      DW    W8732      ; =0x8732 =34610(-30926)
*
86c5:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
86c8:      DW    W89BD      ; =0x89bd =35261(-30275)
*
86ca:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
86cd:      DW    W89BD      ; =0x89bd =35261(-30275)
*
86cf:      JSR/  F8242      ; =0x8242 =33346(-32190) [Jump to subroutine direct]
86d2:W86D2 DW    W81CC      ; =0x81cc =33228(-32308)
86d4:      LDA/  W89BD      ; =0x89bd =35261(-30275) [Load A direct]
86d7:      BZ    D8710      ; =+55 [Branch if zero]
86d9:      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
86dc:      LDB/  W89BD      ; =0x89bd =35261(-30275) [Load B direct]
86df:      JSR/  FA29F      ; =0xa29f =41631(-23905) [Jump to subroutine direct]
86e2:      DW    S89C5      ; =0x89c5 =35269(-30267)
86e4:      DW    S89BF      ; =0x89bf =35263(-30273)
*
86e6:D86E6 LDB   W86D2      ; =-22 [Load B relative]
86e8:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
86eb:      DB    X'01'      ; =0x01 =1
86ec:      BNZ   D8725      ; =+55 [Branch if not zero]
86ee:      LDAB/ B88B1      ; =0x88b1 =34993(-30543) [Load AL direct]
86f1:      LDBB= X'A8'      ; =168(-88) ='(' [Load BL with immediate]
86f3:      SABB             ; [AL - BL -> BL]
86f4:      BNZ   D86E6      ; =-16 [Branch if not zero]
86f6:      JSR/  FA208      ; =0xa208 =41480(-24056) [Jump to subroutine direct]
86f9:      DW    W88AF      ; =0x88af =34991(-30545)
86fb:      LDA=  S88B2      ; =0x88b2 =34994(-30542) [Load A with immediate]
86fe:      XAZ              ; [Transfer A to Z]
86ff:      LDA=  S89C5      ; =0x89c5 =35269(-30267) [Load A with immediate]
8702:      XAY              ; [Transfer A to Y]
8703:      LDX=  X'0003'    ; =0x0003 =3 [Load X with immediate]
8706:D8706 LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8708:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
870a:      SAB              ; [A - B -> B]
870b:      BNZ   D86E6      ; =-39 [Branch if not zero]
870d:      DCX              ; [Decrement X]
870e:      BGZ   D8706      ; =-10 [Branch if greater than zero]
8710:D8710 LDB   W86D2      ; =-64 [Load B relative]
8712:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
8715:      DB    X'01'      ; =0x01 =1
8716:      BNZ   D872A      ; =+18 [Branch if not zero]
8718:      LDAB/ B88B1      ; =0x88b1 =34993(-30543) [Load AL direct]
871b:      LDBB= X'A8'      ; =168(-88) ='(' [Load BL with immediate]
871d:      SABB             ; [AL - BL -> BL]
871e:      BZ    D872A      ; =+10 [Branch if zero]
8720:      JSR/  F8650      ; =0x8650 =34384(-31152) [Jump to subroutine direct]
8723:      JMP   D8710      ; =-21 [Jump relative]
8725:D8725 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
8728:      DW    W8867      ; =0x8867 =34919(-30617)
*
872a:D872A LDB   W86D2      ; =-90 [Load B relative]
872c:      JSR/  D85DF      ; =0x85df =34271(-31265) [Jump to subroutine direct]
872f:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
*
8732:W8732 DW    X'0007'    ; =0x0007 =7
8734:      DC    'SUBFILE'  ; hex:d3d5c2c6c9ccc5
873b:W873B DW    X'000D'    ; =0x000d =13
873d:      DC    'KOMPOZ - 6.03'
874a:W874A DW    X'000C'    ; =0x000c =12
874c:      DC    'ERR ON INPUT'
8758:W8758 DW    X'000D'    ; =0x000d =13
875a:      DC    'ERR ON OUTPUT'
8767:W8767 DW    X'000D'    ; =0x000d =13
8769:      DC    'EOM ON OUTPUT'
8776:W8776 DW    X'000C'    ; =0x000c =12
8778:      DC    'EOF ON INPUT'
8784:W8784 DW    X'0015'    ; =0x0015 =21
8786:      DC    'IN=SYS00' ; hex:c9cebdd3d9d3b0b0
878e:S878E DC    'X, OUT=SYS00'
879a:S879A DC    'X'        ; hex:d8 dec:216(-40)
879b:W879B DW    X'000D'    ; =0x000d =13
879d:      DB    X'A7'      ; =0xa7 =167(-89) ='
879e:      DC    'SYS'      ; hex:d3d9d3
87a1:      DB    X'A7'      ; =0xa7 =167(-89) ='
87a2:      DC    ' NUMBER?' ; hex:a0ced5cdc2c5d2bf
87aa:      DB    X'00'      ; =0x00 =0 =NUL
87ab:      DB    X'01'      ; =0x01 =1
87ac:      DC    '-'        ; hex:ad dec:173(-83)
87ad:W87AD DW    X'000A'    ; =0x000a =10
87af:      DC    'END KOMPOZ' ; hex:c5cec4a0cbcfcdd0cfda
87b9:W87B9 DW    X'000E'    ; =0x000e =14
87bb:      DC    'FIND? (Y OR N)'
87c9:W87C9 DW    X'000D'    ; =0x000d =13
87cb:      DC    'TOP? (Y OR N)'
87d8:W87D8 DW    X'000E'    ; =0x000e =14
87da:      DC    'QUIT? (Y OR N)'
87e8:W87E8 DW    X'0015'    ; =0x0015 =21
87ea:      DC    'END OF FILE? (Y OR N)  '
8801:W8801 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8803:W8803 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8805:W8805 DW    X'0014'    ; =0x0014 =20
8807:      DC    'SUBSTITUTIONS ='
8816:S8816 DC    '  '       ; hex:a0a0 dec:41120(-96)
8818:S8818 DC    '  '       ; hex:a0a0 dec:41120(-96)
881a:S881A DC    ' '        ; hex:a0 dec:160(-96)
881b:W881B DW    X'0005'    ; =0x0005 =5
881d:      DC    'WAIT?'    ; hex:d7c1c9d4bf
8822:W8822 DW    X'0003'    ; =0x0003 =3
8824:      DC    'OK?'      ; hex:cfcbbf
8827:W8827 DW    X'0013'    ; =0x0013 =19
8829:      DC    'RECORDS READ ='
8837:S8837 DC    '  '       ; hex:a0a0 dec:41120(-96)
8839:S8839 DC    '  '       ; hex:a0a0 dec:41120(-96)
883b:S883B DC    ' '        ; hex:a0 dec:160(-96)
883c:W883C DW    X'0016'    ; =0x0016 =22
883e:      DC    'RECORDS WRITTEN ='
884f:S884F DC    '  '       ; hex:a0a0 dec:41120(-96)
8851:S8851 DC    '  '       ; hex:a0a0 dec:41120(-96)
8853:S8853 DC    ' '        ; hex:a0 dec:160(-96)
8854:W8854 DW    X'0011'    ; =0x0011 =17
8856:      DC    'ILLEGAL PARAMETER'
8867:W8867 DW    X'0012'    ; =0x0012 =18
8869:      DC    'EQUALITY NOT FOUND'
887b:W887B DW    W83B3      ; =0x83b3 =33715(-31821)
887d:      DW    W83B3      ; =0x83b3 =33715(-31821)
887f:      DW    W8364      ; =0x8364 =33636(-31900)
8881:      DW    W84A3      ; =0x84a3 =33955(-31581) =EOT,'#'
8883:      DW    W8551      ; =0x8551 =34129(-31407)
8885:      DW    W83BB      ; =0x83bb =33723(-31813)
8887:      DW    W83B3      ; =0x83b3 =33715(-31821)
8889:      DW    W83B3      ; =0x83b3 =33715(-31821)
888b:      DW    W84D9      ; =0x84d9 =34009(-31527) =EOT,'Y'
888d:      DW    W8688      ; =0x8688 =34440(-31096)
888f:      DW    W8367      ; =0x8367 =33639(-31897)
8891:      DW    W83B3      ; =0x83b3 =33715(-31821)
8893:      DW    W83B3      ; =0x83b3 =33715(-31821)
8895:      DW    W8505      ; =0x8505 =34053(-31483)
8897:      DW    W9551      ; =0x9551 =38225(-27311)
8899:      DW    W83D8      ; =0x83d8 =33752(-31784)
889b:      DW    W8278      ; =0x8278 =33400(-32136)
889d:      DW    W852D      ; =0x852d =34093(-31443)
889f:      DW    W8410      ; =0x8410 =33808(-31728)
88a1:      DW    W853C      ; =0x853c =34108(-31428)
88a3:      DW    W8583      ; =0x8583 =34179(-31357)
88a5:      DW    W83B3      ; =0x83b3 =33715(-31821)
88a7:      DW    W8519      ; =0x8519 =34073(-31463)
88a9:      DW    W8562      ; =0x8562 =34146(-31390)
88ab:      DW    W83B3      ; =0x83b3 =33715(-31821)
88ad:      DW    W8532      ; =0x8532 =34098(-31438)
88af:W88AF DB    X'00'      ; =0x00 =0 =NUL
88b0:W88B0 DB    X'00'      ; =0x00 =0 =NUL
88b1:B88B1 DB    X'00'      ; =0x00 =0 =NUL
88b2:S88B2 DB    0,132      ; =0x00,0x0084
8936:W8936 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8938:W8938 DB    X'00'      ; =0x00 =0 =NUL
8939:W8939 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
893b:S893B DB    0,130      ; =0x00,0x0082
89bd:W89BD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
89bf:S89BF DB    0,6        ; =0x00,0x0006
89c5:S89C5 DB    0,127      ; =0x00,0x007f
8a44:W8A44 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a46:S8A46 DB    0,133      ; =0x00,0x0085
8acb:S8ACB DB    0,135      ; =0x00,0x0087
8b52:W8B52 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8b54:S8B54 DB    0,8        ; =0x00,0x0008
8b5c:W8B5C DS    403        ; =0x0193 [Uninitialized memory]
8cef:W8CEF DS    403        ; =0x0193 [Uninitialized memory]
8e82:W8E82 DS    403        ; =0x0193 [Uninitialized memory]
9015:W9015 DS    403        ; =0x0193 [Uninitialized memory]
91a8:S91A8 DC    'SEC'      ; hex:d3c5c3
91ab:      DW    W97AA      ; =0x97aa =38826(-26710)
91ad:      DC    'FLA'      ; hex:c6ccc1
91b0:      DW    W97EA      ; =0x97ea =38890(-26646)
91b2:      DC    'IND'      ; hex:c9cec4
91b5:      DW    W97F4      ; =0x97f4 =38900(-26636)
91b7:      DC    'TAB'      ; hex:d4c1c2
91ba:      DW    W9804      ; =0x9804 =38916(-26620)
91bc:      DC    'PAR'      ; hex:d0c1d2
91bf:      DW    W9906      ; =0x9906 =39174(-26362)
91c1:      DC    'MAR'      ; hex:cdc1d2
91c4:      DW    W9950      ; =0x9950 =39248(-26288)
91c6:      DC    'DAS'      ; hex:c4c1d3
91c9:      DW    W99AB      ; =0x99ab =39339(-26197)
91cb:      DC    'SKI'      ; hex:d3cbc9
91ce:      DW    W99B1      ; =0x99b1 =39345(-26191)
91d0:      DC    'SUB'      ; hex:d3d5c2
91d3:      DW    W9932      ; =0x9932 =39218(-26318)
91d5:      DC    'ESB'      ; hex:c5d3c2
91d8:      DW    W993D      ; =0x993d =39229(-26307)
91da:      DC    'NEW'      ; hex:cec5d7
91dd:      DW    W9982      ; =0x9982 =39298(-26238)
91df:      DC    'SPA'      ; hex:d3d0c1
91e2:      DW    W9995      ; =0x9995 =39317(-26219)
91e4:      DC    'PAG'      ; hex:d0c1c7
91e7:      DW    W99D3      ; =0x99d3 =39379(-26157)
91e9:      DC    'LIN'      ; hex:ccc9ce
91ec:      DW    W99DC      ; =0x99dc =39388(-26148)
91ee:      DC    'BOT'      ; hex:c2cfd4
91f1:      DW    W99EB      ; =0x99eb =39403(-26133)
91f3:      DC    'TOP'      ; hex:d4cfd0
91f6:      DW    W99FA      ; =0x99fa =39418(-26118)
91f8:      DC    'NUM'      ; hex:ced5cd
91fb:      DW    W9A09      ; =0x9a09 =39433(-26103)
91fd:      DC    'CEN'      ; hex:c3c5ce
9200:      DW    W9A30      ; =0x9a30 =39472(-26064)
9202:      DC    'HEA'      ; hex:c8c5c1
9205:      DW    W9A54      ; =0x9a54 =39508(-26028)
9207:      DC    'DOU'      ; hex:c4cfd5
920a:      DW    W9A81      ; =0x9a81 =39553(-25983)
920c:      DC    'SIN'      ; hex:d3c9ce
920f:      DW    W9A88      ; =0x9a88 =39560(-25976)
9211:      DC    'USA'      ; hex:d5d3c1
9214:      DW    W9A8F      ; =0x9a8f =39567(-25969)
9216:      DC    'USW'      ; hex:d5d3d7
9219:      DW    W98E4      ; =0x98e4 =39140(-26396)
921b:      DC    'EUS'      ; hex:c5d5d3
921e:      DW    W9A8F      ; =0x9a8f =39567(-25969)
9220:      DC    'JUS'      ; hex:cad5d3
9223:      DW    W9989      ; =0x9989 =39305(-26231)
9225:      DC    'NOJ'      ; hex:cecfca
9228:      DW    W998F      ; =0x998f =39311(-26225)
922a:      DC    'EOF'      ; hex:c5cfc6
922d:      DW    W9A91      ; =0x9a91 =39569(-25967)
922f:      DC    'FIL'      ; hex:c6c9cc
9232:      DW    W9A90      ; =0x9a90 =39568(-25968)
9234:      DC    'INS'      ; hex:c9ced3
9237:      DW    W9AA0      ; =0x9aa0 =39584(-25952)
9239:      DC    'UND'      ; hex:d5cec4
923c:      DW    W981E      ; =0x981e =38942(-26594)
923e:      DC    'EUN'      ; hex:c5d5ce
9241:      DW    W9885      ; =0x9885 =39045(-26491)
9243:      DC    'USW'      ; hex:d5d3d7
9246:      DW    W98E4      ; =0x98e4 =39140(-26396)
9248:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
924a:W924A DW    X'0011'    ; =0x0011 =17
924c:      DC    'CONTINUOUS FORMS?'
925d:W925D DW    X'0008'    ; =0x0008 =8
925f:      DC    'INSERTS?' ; hex:c9ced3c5d2d4d3bf
9267:W9267 DW    X'000E'    ; =0x000e =14
9269:      DC    'ENTER  COPIES'
9276:W9276 DW    X'0015'    ; =0x0015 =21
9278:      DC    'ENTER STARTING PAGE '
928c:W928C DW    X'0010'    ; =0x0010 =16
928e:      DC    'CONSOLE DISPLAY?'
929e:W929E DW    X'0005'    ; =0x0005 =5
92a0:      DC    'WAIT?'    ; hex:d7c1c9d4bf
92a5:W92A5 DW    X'0013'    ; =0x0013 =19
92a7:      DC    '(MORE DATA FOLLOWS)'
92ba:W92BA DW    X'0014'    ; =0x0014 =20
92bc:      DC    'ALIGN FORMS, TYPE CR'
92d0:W92D0 DW    X'0081'    ; =0x0081 =129
92d2:      DB    X'03'      ; =0x03 =3
92d3:      DC    '      '   ; hex:a0a0a0a0a0a0
92d9:W92D9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92db:W92DB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92dd:W92DD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92df:W92DF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92e1:W92E1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92e3:W92E3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92e5:W92E5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
92e7:W92E7 DS    2          ; =0x0002 [Uninitialized memory]
92e9:W92E9 DS    132        ; =0x0084 [Uninitialized memory]
936d:W936D DS    2          ; =0x0002 [Uninitialized memory]
936f:W936F DS    264        ; =0x0108 [Uninitialized memory]
9477:S9477 DB    0,134      ; =0x00,0x0086
94fd:W94FD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
94ff:B94FF DB    X'00'      ; =0x00 =0 =NUL
9500:B9500 DB    X'00'      ; =0x00 =0 =NUL
9501:W9501 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9503:B9503 DB    X'00'      ; =0x00 =0 =NUL
9504:B9504 DB    X'00'      ; =0x00 =0 =NUL
9505:W9505 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9507:B9507 DB    X'00'      ; =0x00 =0 =NUL
9508:B9508 DB    X'00'      ; =0x00 =0 =NUL
9509:B9509 DB    X'00'      ; =0x00 =0 =NUL
950a:W950A DB    X'00'      ; =0x00 =0 =NUL
950b:W950B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
950d:B950D DB    X'00'      ; =0x00 =0 =NUL
950e:W950E DW    W9510      ; =0x9510 =38160(-27376)
9510:W9510 DS    39         ; =0x0027 [Uninitialized memory]
9537:W9537 DS    1          ; =0x0001 [Uninitialized memory]
9538:W9538 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
953a:W953A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
953c:W953C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
953e:W953E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9540:W9540 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9542:B9542 DB    X'00'      ; =0x00 =0 =NUL
9543:B9543 DB    X'00'      ; =0x00 =0 =NUL
9544:W9544 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9546:W9546 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9548:W9548 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
954a:B954A DB    X'00'      ; =0x00 =0 =NUL
954b:W954B DW    W81EA      ; =0x81ea =33258(-32278)
954d:W954D DW    W88AF      ; =0x88af =34991(-30545)
954f:W954F DW    S9477      ; =0x9477 =38007(-27529)
*
9551:W9551 LDA/  W8803      ; =0x8803 =34819(-30717) [Load A direct]
9554:      BZ    D9559      ; =+3 [Branch if zero]
9556:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
9559:D9559 STAB/ B8633      ; =0x8633 =34355(-31181) [Store AL direct]
955c:      STAB  W950A      ; =-84 [Store AL relative]
955e:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
9561:      STA/  S9477      ; =0x9477 =38007(-27529) [Store A direct]
9564:      STA/  W92E7      ; =0x92e7 =37607(-27929) [Store A direct]
9567:      STA   W9544      ; =-37 [Store A relative]
9569:      INA              ; [Increment A]
956a:      STA   W9538      ; =-52 [Store A relative]
956c:      LDAB= X'02'      ; =2 [Load AL with immediate]
956e:      STA/  FA096+1    ; =0xa097 =41111(-24425) [Store A direct]
9571:      STA   W94FD      ; =-118 [Store A relative]
9573:      LDAB= X'01'      ; =1 [Load AL with immediate]
9575:      STAB  B9509      ; =-110 [Store AL relative]
9577:      STAB  B9504      ; =-117 [Store AL relative]
9579:      STAB  B954A      ; =-49 [Store AL relative]
957b:      STAB/ B9500      ; =0x9500 =38144(-27392) [Store AL direct]
957e:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9580:      STAB  B9542      ; =-64 [Store AL relative]
9582:      STAB  B9543      ; =-65 [Store AL relative]
9584:      STAB/ B9503      ; =0x9503 =38147(-27389) [Store AL direct]
9587:      STAB/ B9508      ; =0x9508 =38152(-27384) [Store AL direct]
958a:      LDAB= X'01'      ; =1 [Load AL with immediate]
958c:      STAB/ B950D      ; =0x950d =38157(-27379) [Store AL direct]
958f:      LDA=  X'000C'    ; =0x000c =12 [Load A with immediate]
9592:      STA/  W92DB      ; =0x92db =37595(-27941) [Store A direct]
9595:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
9598:      LDA=  X'0048'    ; =0x0048 =72 [Load A with immediate]
959b:      STA/  W92DD      ; =0x92dd =37597(-27939) [Store A direct]
959e:      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
95a1:      STA   W953A      ; =-105 [Store A relative]
95a3:      LDA=  X'0009'    ; =0x0009 =9 [Load A with immediate]
95a6:      STA   W953C      ; =-108 [Store A relative]
95a8:      LDA=  X'0042'    ; =0x0042 =66 [Load A with immediate]
95ab:      STA   W953E      ; =-111 [Store A relative]
95ad:      LDA=  W9510      ; =0x9510 =38160(-27376) [Load A with immediate]
95b0:      STA/  W950E      ; =0x950e =38158(-27378) [Store A direct]
95b3:      LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
95b6:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
95b8:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
95b9:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
95ba:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
95bb:      DW    W95BD+1    ; =0x95be =38334(-27202) [address to store block value]
95bd:W95BD LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
95bf:      DCRB  AL,4       ; [Decrement AL by 4]
95c1:      BNZ   D95D9      ; =+22 [Branch if not zero]
95c3:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
95c6:      STA/  W8212      ; =0x8212 =33298(-32238) [Store A direct]
95c9:      INA              ; [Increment A]
95ca:      STAB/ B8214      ; =0x8214 =33300(-32236) [Store AL direct]
95cd:      LDA=  W9015      ; =0x9015 =36885(-28651) [Load A with immediate]
95d0:      STA/  S820E      ; =0x820e =33294(-32242) [Store A direct]
95d3:      LDA=  X'0190'    ; =0x0190 =400 [Load A with immediate]
95d6:      STA/  W820C      ; =0x820c =33292(-32244) [Store A direct]
95d9:D95D9 JSR/  F8242      ; =0x8242 =33346(-32190) [Jump to subroutine direct]
95dc:      DW    W8208      ; =0x8208 =33288(-32248)
*
95de:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
95e1:      DW    W924A      ; =0x924a =37450(-28086)
95e3:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
95e6:      STBB/ B9507      ; =0x9507 =38151(-27385) [Store BL direct]
95e9:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
95ec:      DW    W925D      ; =0x925d =37469(-28067)
95ee:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
95f1:      STBB/ B94FF      ; =0x94ff =38143(-27393) [Store BL direct]
95f4:      BZ    D95F9      ; =+3 [Branch if zero]
95f6:      JSR/  FA114      ; =0xa114 =41236(-24300) [Jump to subroutine direct]
95f9:D95F9 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
95fc:      DW    W9267      ; =0x9267 =37479(-28057)
*
95fe:      JSR   F9655      ; =+85 [Jump to subroutine relative]
9600:      STA/  W9548      ; =0x9548 =38216(-27320) [Store A direct]
9603:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
9606:      DW    W9276      ; =0x9276 =37494(-28042)
9608:      JSR   F9655      ; =+75 [Jump to subroutine relative]
960a:      DCA              ; [Decrement A]
960b:      STA/  W9546      ; =0x9546 =38214(-27322) [Store A direct]
960e:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
9611:      DW    W928C      ; =0x928c =37516(-28020)
9613:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
9616:      STBB/ BA153+1    ; =0xa154 =41300(-24236) [Store BL direct]
9619:      BZ    D9637      ; =+28 [Branch if zero]
961b:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
961e:      DW    W929E      ; =0x929e =37534(-28002)
9620:      JSR/  D829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
9623:      STBB/ BA157+1    ; =0xa158 =41304(-24232) [Store BL direct]
9626:      LDB=  W92D0      ; =0x92d0 =37584(-27952) [Load B with immediate]
9629:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
962b:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
962c:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
962d:      DB    X'18'      ; =0x18 =24 [TODO: arg3]
962e:      DW    WA15B+1    ; =0xa15c =41308(-24228) [address to store block value]
9630:      LDAB/ WA15B+1    ; =0xa15c =41308(-24228) [Load AL direct]
9633:      DCAB             ; [Decrement AL]
9634:      STAB/ BA16A+1    ; =0xa16b =41323(-24213) [Store AL direct]
9637:D9637 JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
963a:      DW    W92BA      ; =0x92ba =37562(-27974)
*
963c:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
963f:      DW    W8A44      ; =0x8a44 =35396(-30140)
9641:      LDAB= X'8C'      ; =140(-116) =FF [Load AL with immediate]
9643:      STAB/ BA28F+1    ; =0xa290 =41616(-23920) [Store AL direct]
9646:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9649:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
964c:      LDAB= X'AE'      ; =174(-82) ='.' [Load AL with immediate]
964e:      STAB  B967F+1    ; =+48 [Store AL relative]
9650:      JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9653:      JMP   D9662      ; =+13 [Jump relative]
*
* Function F9655
*
9655:F9655 JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
9658:      DW    W8936      ; =0x8936 =35126(-30410)
*
965a:      JSR/  F9C81      ; =0x9c81 =40065(-25471) [Jump to subroutine direct]
965d:W965D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
965f:      LDA   W965D      ; =-4 [Load A relative]
9661:      RSR              ; [Return from subroutine]
*
9662:D9662 LDAB/ B9503      ; =0x9503 =38147(-27389) [Load AL direct]
9665:      BNZ   D966C      ; =+5 [Branch if not zero]
9667:      JSR/  FA01A      ; =0xa01a =40986(-24550) [Jump to subroutine direct]
966a:      JMP   D9671      ; =+5 [Jump relative]
966c:D966C LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
966e:      STAB/ B9503      ; =0x9503 =38147(-27389) [Store AL direct]
9671:D9671 LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
9674:      BZ    D96C0      ; =+74 [Branch if zero]
9676:      LDB=  X'0004'    ; =0x0004 =4 [Load B with immediate]
9679:      SAB              ; [A - B -> B]
967a:      BM    D96BC      ; =+64 [Branch on minus]
967c:      LDAB/ W8938      ; =0x8938 =35128(-30408) [Load AL direct]
967f:B967F LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
9681:      SABB             ; [AL - BL -> BL]
9682:      BNZ   D96BC      ; =+56 [Branch if not zero]
9684:      LDA=  S91A8      ; =0x91a8 =37288(-28248) [Load A with immediate]
9687:      XAY              ; [Transfer A to Y]
9688:D9688 LDA/  W8939      ; =0x8939 =35129(-30407) [Load A direct]
968b:      LDB=  X'DFDF'    ; =0xdfdf =57311(-8225) =DEL,DEL [Load B with immediate]
968e:      AND   B,A        ; [B & A -> A]
9690:D9690 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
9692:      BZ    D96BC      ; =+40 [Branch if zero]
9694:      SAB              ; [A - B -> B]
9695:      BZ    D969E      ; =+7 [Branch if zero]
9697:      LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
969a:      ADD   B,Y        ; [B + Y -> Y]
969c:      JMP   D9690      ; =-14 [Jump relative]
969e:D969E LDAB/ S893B      ; =0x893b =35131(-30405) [Load AL direct]
96a1:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
96a3:      ANDB  BL,AL      ; [BL & AL -> AL]
96a5:      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
96a7:      SABB             ; [AL - BL -> BL]
96a8:      BZ    D96B0      ; =+6 [Branch if zero]
96aa:      INR   Y          ; [Increment Y by 1]
96ac:      INR   Y          ; [Increment Y by 1]
96ae:      JMP   D9688      ; =-40 [Jump relative]
96b0:D96B0 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
96b2:      CLAB             ; [Clear AL]
96b3:      STAB/ B9803      ; =0x9803 =38915(-26621) [Store AL direct]
96b6:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
96b8:      JSR+  *Y         ; [Jump to subroutine indexed, indirect]
96ba:      JMP   D9662      ; =-90 [Jump relative]
96bc:D96BC JSR   F96E5      ; =+39 [Jump to subroutine relative]
96be:      JMP   D9662      ; =-94 [Jump relative]
96c0:D96C0 JSR/  F9C67      ; =0x9c67 =40039(-25497) [Jump to subroutine direct]
96c3:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
96c6:      LDAB/ B9500      ; =0x9500 =38144(-27392) [Load AL direct]
96c9:      BNZ   D96CE      ; =+3 [Branch if not zero]
96cb:      JSR/  F9AA8      ; =0x9aa8 =39592(-25944) [Jump to subroutine direct]
96ce:D96CE LDAB/ B94FF      ; =0x94ff =38143(-27393) [Load AL direct]
96d1:      BZ    D96D6      ; =+3 [Branch if zero]
96d3:      JSR/  FA19C      ; =0xa19c =41372(-24164) [Jump to subroutine direct]
96d6:D96D6 JSR/  FA1CA      ; =0xa1ca =41418(-24118) ='!','J' [Jump to subroutine direct]
96d9:      CLA              ; [Clear A]
96da:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
96dd:      LDAB= X'8A'      ; =138(-118) =LF [Load AL with immediate]
96df:      STAB/ BA28F+1    ; =0xa290 =41616(-23920) [Store AL direct]
96e2:      JMP/  W8264      ; =0x8264 =33380(-32156) [Jump direct]
*
* Function F96E5
*
96e5:F96E5 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
96e8:      LDAB/ B954A      ; =0x954a =38218(-27318) [Load AL direct]
96eb:      BZ    D96F4      ; =+7 [Branch if zero]
96ed:      CLAB             ; [Clear AL]
96ee:      STAB/ B954A      ; =0x954a =38218(-27318) [Store AL direct]
96f1:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
96f4:D96F4 LDA/  W950A      ; =0x950a =38154(-27382) [Load A direct]
96f7:      BZ    D96FC      ; =+3 [Branch if zero]
96f9:      JSR/  W98E4      ; =0x98e4 =39140(-26396) [Jump to subroutine direct]
96fc:D96FC JSR/  F9D04      ; =0x9d04 =40196(-25340) [Jump to subroutine direct]
96ff:      DW    W8936      ; =0x8936 =35126(-30410)
9701:      DW    W8938      ; =0x8938 =35128(-30408)
9703:      LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9706:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9709:      SAB              ; [A - B -> B]
970a:      BM    D970F      ; =+3 [Branch on minus]
970c:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
970f:D970F JSR/  F9CDC      ; =0x9cdc =40156(-25380) [Jump to subroutine direct]
9712:      LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9715:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9718:      SAB              ; [A - B -> B]
9719:      BM    D9724      ; =+9 [Branch on minus]
971b:D971B JSR/  F9DEB      ; =0x9deb =40427(-25109) [Jump to subroutine direct]
971e:      JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9721:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
9724:D9724 LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9727:W9727 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
972a:      XAZ              ; [Transfer A to Z]
972b:D972B LDAB- Z-         ; [Load AL indexed, pre-decremented, direct]
972d:      LDB/  W9501      ; =0x9501 =38145(-27391) [Load B direct]
9730:      SUB   Z,B        ; [Z - B -> B]
9732:      BP    D9736      ; =+2 [Branch on plus]
9734:      JMP   D971B      ; =-27 [Jump relative]
9736:D9736 XABB             ; [Transfer AL to BL]
9737:      BM    D9768      ; =+47 [Branch on minus]
9739:      LDBB= X'04'      ; =4 [Load BL with immediate]
973b:      SABB             ; [AL - BL -> BL]
973c:      BZ    D9753      ; =+21 [Branch if zero]
973e:      LDBB= X'02'      ; =2 [Load BL with immediate]
9740:      SABB             ; [AL - BL -> BL]
9741:      BNZ   D9784      ; =+65 [Branch if not zero]
9743:      LDA+  Z,-2       ; [Load A indexed, displaced, direct]
9746:      LDB=  X'0270'    ; =0x0270 =624 [Load B with immediate]
9749:      SAB              ; [A - B -> B]
974a:      BNZ   D977B      ; =+47 [Branch if not zero]
974c:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
974e:      STAB+ Z,-1       ; [Store AL indexed, displaced, direct]
9751:      JMP   D977B      ; =+40 [Jump relative]
9753:D9753 LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9756:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9759:      SAB              ; [A - B -> B]
975a:      BLE   D972B      ; =-49 [Branch if less than or equal to zero]
975c:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
975e:      STAB+ Z          ; [Store AL to address in Z]
975f:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9762:      INA              ; [Increment A]
9763:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9766:      JMP   D9784      ; =+28 [Jump relative]
9768:D9768 LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
976a:      SABB             ; [AL - BL -> BL]
976b:      BZ    D9784      ; =+23 [Branch if zero]
976d:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
976f:      SABB             ; [AL - BL -> BL]
9770:      BZ    D977B      ; =+9 [Branch if zero]
9772:D9772 LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9775:      DCA              ; [Decrement A]
9776:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9779:      JMP   D972B      ; =-80 [Jump relative]
977b:D977B LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
977e:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9781:      SAB              ; [A - B -> B]
9782:      BM    D9772      ; =-18 [Branch on minus]
9784:D9784 INR   Z          ; [Increment Z by 1]
9786:      XFR   Z,B        ; [Transfer Z to B]
9788:      STB/  W936D      ; =0x936d =37741(-27795) [Store B direct]
978b:      LDA   W9727+1    ; =-101 [Load A relative]
978d:      SAB              ; [A - B -> B]
978e:      BLE   D97A4      ; =+20 [Branch if less than or equal to zero]
9790:      STB/  W8936      ; =0x8936 =35126(-30410) [Store B direct]
9793:      XFR   B,X        ; [Transfer B to X]
9795:      LDA=  W8938      ; =0x8938 =35128(-30408) [Load A with immediate]
9798:D9798 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
979a:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
979c:      DCX              ; [Decrement X]
979d:      BNZ   D9798      ; =-7 [Branch if not zero]
979f:      LDAB= X'01'      ; =1 [Load AL with immediate]
97a1:      STAB/ B9503      ; =0x9503 =38147(-27389) [Store AL direct]
97a4:D97A4 JSR/  F9CDC      ; =0x9cdc =40156(-25380) [Jump to subroutine direct]
97a7:      JMP/  D971B      ; =0x971b =38683(-26853) [Jump direct]
97aa:W97AA JSR/  F9F53      ; =0x9f53 =40787(-24749) [Jump to subroutine direct]
97ad:      LDA/  W8A44      ; =0x8a44 =35396(-30140) [Load A direct]
97b0:      DCA              ; [Decrement A]
97b1:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
97b4:      CLA              ; [Clear A]
97b5:      STA/  W8B52      ; =0x8b52 =35666(-29870) [Store A direct]
97b8:      LDB=  W8A44      ; =0x8a44 =35396(-30140) [Load B with immediate]
97bb:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
97bd:      XAY              ; [Transfer A to Y]
97be:      BZ    D97E9      ; =+41 [Branch if zero]
97c0:      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
97c3:D97C3 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
97c5:      SUBB  AU,AL      ; [AU - AL -> AL]
97c7:      BNZ   D97CF      ; =+6 [Branch if not zero]
97c9:      DCR   Y          ; [Decrement Y by 1]
97cb:      BNZ   D97C3      ; =-10 [Branch if not zero]
97cd:      JMP   D97E9      ; =+26 [Jump relative]
97cf:D97CF DCR   B          ; [Decrement B by 1]
97d1:      STB   W97E7      ; =+20 [Store B relative]
97d3:      XFR   Y,A        ; [Transfer Y to A]
97d5:      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
97d8:      SAB              ; [A - B -> B]
97d9:      BLE   D97DE      ; =+3 [Branch if less than or equal to zero]
97db:      LDA=  X'0008'    ; =0x0008 =8 [Load A with immediate]
97de:D97DE XAB              ; [Transfer A to B]
97df:      STA/  W8B52      ; =0x8b52 =35666(-29870) [Store A direct]
97e2:      JSR/  FA29F      ; =0xa29f =41631(-23905) [Jump to subroutine direct]
97e5:      DW    S8B54      ; =0x8b54 =35668(-29868)
97e7:W97E7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
97e9:D97E9 RSR              ; [Return from subroutine]
*
97ea:W97EA JSR/  FA01A      ; =0xa01a =40986(-24550) [Jump to subroutine direct]
97ed:      LDAB/ W8938      ; =0x8938 =35128(-30408) [Load AL direct]
97f0:      STAB/ B967F+1    ; =0x9680 =38528(-27008) [Store AL direct]
97f3:      RSR              ; [Return from subroutine]
*
97f4:W97F4 JSR   W9804      ; =+14 [Jump to subroutine relative]
97f6:      BL    D9802      ; =+10 [Branch on link]
97f8:      LDAB= X'01'      ; =1 [Load AL with immediate]
97fa:      STAB  B9803      ; =+7 [Store AL relative]
97fc:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
97ff:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
9802:D9802 RSR              ; [Return from subroutine]
*
9803:B9803 DB    X'00'      ; =0x00 =0 =NUL
*
9804:W9804 JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
9807:      BL    D981D      ; =+20 [Branch on link]
9809:      CLR   B          ; [Clear B]
980b:      LDBB/ B9881      ; =0x9881 =39041(-26495) [Load BL direct]
980e:      AAB              ; [A + B -> B]
980f:      STB   W9814      ; =+3 [Store B relative]
9811:      JSR/  F9C39      ; =0x9c39 =39993(-25543) [Jump to subroutine direct]
9814:W9814 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9816:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9819:      STA/  W92DF      ; =0x92df =37599(-27937) [Store A direct]
981c:      RL               ; [Reset link]
981d:D981D RSR              ; [Return from subroutine]
*
981e:W981E LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9821:      INR   A,4        ; [Increment A by 4]
9823:      STA/  W92DD      ; =0x92dd =37597(-27939) [Store A direct]
9826:      LDA=  X'0064'    ; =0x0064 =100 [Load A with immediate]
9829:      STA/  W9883      ; =0x9883 =39043(-26493) [Store A direct]
982c:      LDAB/ B9881      ; =0x9881 =39041(-26495) [Load AL direct]
982f:      INRB  AL,4       ; [Increment AL by 4]
9831:      STAB/ B9881      ; =0x9881 =39041(-26495) [Store AL direct]
9834:      LDAB= X'01'      ; =1 [Load AL with immediate]
9836:      STAB  B9880      ; =+72 [Store AL relative]
9838:      LDB/  W936D      ; =0x936d =37741(-27795) [Load B direct]
983b:      DCR   B          ; [Decrement B by 1]
983d:      LDAB= X'70'      ; =112 [Load AL with immediate]
983f:      XAYB             ; [Transfer AL to YL]
9840:      LDAB= X'02'      ; =2 [Load AL with immediate]
9842:      XFRB  AL,YU      ; [Transfer AL to YU]
9844:      LDAB+ B          ; [Load AL from address in B]
9845:      SUBB  AL,YL      ; [AL - YL -> YL]
9847:      BNZ   D984F      ; =+6 [Branch if not zero]
9849:      CLRB  AL,1       ; [Set AL to 1]
984b:      STAB  B9882      ; =+53 [Store AL relative]
984d:      JMP   D9855      ; =+6 [Jump relative]
984f:D984F SUBB  AL,YU      ; [AL - YU -> YU]
9851:      BNZ   D9855      ; =+2 [Branch if not zero]
9853:      INR   B          ; [Increment B by 1]
9855:D9855 LDAB  B9882      ; =+43 [Load AL relative]
9857:      BZ    D9867      ; =+14 [Branch if zero]
9859:      CLAB             ; [Clear AL]
985a:      STAB  B9882      ; =+38 [Store AL relative]
985c:      LDAB= X'70'      ; =112 [Load AL with immediate]
985e:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9860:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9863:      INA              ; [Increment A]
9864:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9867:D9867 LDAB= X'02'      ; =2 [Load AL with immediate]
9869:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
986b:      LDA=  X'9BB0'    ; =0x9bb0 =39856(-25680) [Load A with immediate]
986e:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9870:      LDAB= X'E0'      ; =224(-32) ='`' [Load AL with immediate]
9872:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9874:      STB/  W936D      ; =0x936d =37741(-27795) [Store B direct]
9877:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
987a:      INR   A,4        ; [Increment A by 4]
987c:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
987f:      RSR              ; [Return from subroutine]
*
9880:B9880 DB    X'00'      ; =0x00 =0 =NUL
9881:B9881 DB    X'00'      ; =0x00 =0 =NUL
9882:B9882 DB    X'00'      ; =0x00 =0 =NUL
9883:W9883 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
9885:W9885 CLAB             ; [Clear AL]
9886:      STAB/ W950A      ; =0x950a =38154(-27382) [Store AL direct]
9889:      LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
988c:      INR   A,4        ; [Increment A by 4]
988e:      STA/  W92DD      ; =0x92dd =37597(-27939) [Store A direct]
9891:      LDAB/ B9881      ; =0x9881 =39041(-26495) [Load AL direct]
9894:      INRB  AL,4       ; [Increment AL by 4]
9896:      STAB/ B9881      ; =0x9881 =39041(-26495) [Store AL direct]
9899:      CLAB             ; [Clear AL]
989a:      STAB  B9880      ; =-28 [Store AL relative]
*
* Function F989C
*
989c:F989C LDB/  W936D      ; =0x936d =37741(-27795) [Load B direct]
989f:D989F DCR   B          ; [Decrement B by 1]
98a1:      LDAB= X'70'      ; =112 [Load AL with immediate]
98a3:      XAYB             ; [Transfer AL to YL]
98a4:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
98a6:      XFRB  AL,YU      ; [Transfer AL to YU]
98a8:      LDAB+ B          ; [Load AL from address in B]
98a9:      SUBB  AL,YL      ; [AL - YL -> YL]
98ab:      BNZ   D98B3      ; =+6 [Branch if not zero]
98ad:      CLRB  AL,1       ; [Set AL to 1]
98af:      STAB  B9882      ; =-47 [Store AL relative]
98b1:      JMP   D989F      ; =-20 [Jump relative]
98b3:D98B3 SUBB  AL,YU      ; [AL - YU -> YU]
98b5:      BZ    D989F      ; =-24 [Branch if zero]
98b7:      INR   B          ; [Increment B by 1]
98b9:      LDA=  X'9BB0'    ; =0x9bb0 =39856(-25680) [Load A with immediate]
98bc:      STA+  B+         ; [Store A indexed, direct, post-incremented]
98be:      LDAB= X'C0'      ; =192(-64) ='@' [Load AL with immediate]
98c0:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
98c2:      LDAB= X'02'      ; =2 [Load AL with immediate]
98c4:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
98c6:      LDAB  B9882      ; =-70 [Load AL relative]
98c8:      BZ    D98D8      ; =+14 [Branch if zero]
98ca:      CLAB             ; [Clear AL]
98cb:      STAB  B9882      ; =-75 [Store AL relative]
98cd:      LDAB= X'70'      ; =112 [Load AL with immediate]
98cf:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
98d1:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
98d4:      INA              ; [Increment A]
98d5:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
98d8:D98D8 STB/  W936D      ; =0x936d =37741(-27795) [Store B direct]
98db:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
98de:      INR   A,4        ; [Increment A by 4]
98e0:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
98e3:      RSR              ; [Return from subroutine]
*
98e4:W98E4 LDAB/ W950A      ; =0x950a =38154(-27382) [Load AL direct]
98e7:      BNZ   D98F2      ; =+9 [Branch if not zero]
98e9:      CLRB  AL,1       ; [Set AL to 1]
98eb:      STAB/ W950A      ; =0x950a =38154(-27382) [Store AL direct]
98ee:      JSR/  W981E      ; =0x981e =38942(-26594) [Jump to subroutine direct]
98f1:      RSR              ; [Return from subroutine]
*
98f2:D98F2 JSR/  W9885      ; =0x9885 =39045(-26491) [Jump to subroutine direct]
98f5:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
98f8:      DCR   A,3        ; [Decrement A by 3]
98fa:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
98fd:      CLRB  AL,1       ; [Set AL to 1]
98ff:      STAB/ W950A      ; =0x950a =38154(-27382) [Store AL direct]
9902:      JSR/  W981E      ; =0x981e =38942(-26594) [Jump to subroutine direct]
9905:      RSR              ; [Return from subroutine]
*
9906:W9906 JSR/  F9C67      ; =0x9c67 =40039(-25497) [Jump to subroutine direct]
9909:      LDA/  W92DB      ; =0x92db =37595(-27941) [Load A direct]
990c:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
990f:      JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9912:      LDAB= X'01'      ; =1 [Load AL with immediate]
9914:      STAB/ B950D      ; =0x950d =38157(-27379) [Store AL direct]
9917:      LDA/  W9538      ; =0x9538 =38200(-27336) [Load A direct]
991a:      JSR/  F9E57      ; =0x9e57 =40535(-25001) [Jump to subroutine direct]
991d:      BL    D9926      ; =+7 [Branch on link]
991f:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
9922:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
9925:      RSR              ; [Return from subroutine]
*
9926:D9926 LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9929:      LDB/  W9538      ; =0x9538 =38200(-27336) [Load B direct]
992c:      ADD   B,A        ; [B + A -> A]
992e:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
9931:      RSR              ; [Return from subroutine]
*
9932:W9932 LDAB= X'01'      ; =1 [Load AL with immediate]
9934:      STAB/ B9B74      ; =0x9b74 =39796(-25740) [Store AL direct]
9937:      JSR/  F9FE1      ; =0x9fe1 =40929(-24607) [Jump to subroutine direct]
993a:      JSR   W9950      ; =+20 [Jump to subroutine relative]
993c:      RSR              ; [Return from subroutine]
*
993d:W993D CLAB             ; [Clear AL]
993e:      STAB/ B9B74      ; =0x9b74 =39796(-25740) [Store AL direct]
9941:      JSR/  F9C67      ; =0x9c67 =40039(-25497) [Jump to subroutine direct]
9944:      JSR/  F9FC9      ; =0x9fc9 =40905(-24631) [Jump to subroutine direct]
9947:      LDA/  W92DB      ; =0x92db =37595(-27941) [Load A direct]
994a:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
994d:      JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9950:W9950 JSR/  F9C67      ; =0x9c67 =40039(-25497) [Jump to subroutine direct]
9953:      JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
9956:      BL    D997E      ; =+38 [Branch on link]
9958:      XAB              ; [Transfer A to B]
9959:      BLE   D9964      ; =+9 [Branch if less than or equal to zero]
995b:      LDB=  X'0085'    ; =0x0085 =133 [Load B with immediate]
995e:      SAB              ; [A - B -> B]
995f:      BP    D9964      ; =+3 [Branch on plus]
9961:      STA/  W92DB      ; =0x92db =37595(-27941) [Store A direct]
9964:D9964 JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
9967:      BL    D9978      ; =+15 [Branch on link]
9969:      LDB=  X'0086'    ; =0x0086 =134 [Load B with immediate]
996c:      SAB              ; [A - B -> B]
996d:      BP    D9978      ; =+9 [Branch on plus]
996f:      LDB/  W92DB      ; =0x92db =37595(-27941) [Load B direct]
9972:      SAB              ; [A - B -> B]
9973:      BLE   D9978      ; =+3 [Branch if less than or equal to zero]
9975:      STA/  W92DD      ; =0x92dd =37597(-27939) [Store A direct]
9978:D9978 LDA/  W92DB      ; =0x92db =37595(-27941) [Load A direct]
997b:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
997e:D997E JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9981:      RSR              ; [Return from subroutine]
*
9982:W9982 JSR/  F9C67      ; =0x9c67 =40039(-25497) [Jump to subroutine direct]
9985:      JSR/  F9D90      ; =0x9d90 =40336(-25200) [Jump to subroutine direct]
9988:      RSR              ; [Return from subroutine]
*
9989:W9989 LDAB= X'01'      ; =1 [Load AL with immediate]
998b:      STAB/ B9504      ; =0x9504 =38148(-27388) [Store AL direct]
998e:      RSR              ; [Return from subroutine]
*
998f:W998F LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9991:      STAB/ B9504      ; =0x9504 =38148(-27388) [Store AL direct]
9994:      RSR              ; [Return from subroutine]
*
9995:W9995 JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
9998:      BL    D99AA      ; =+16 [Branch on link]
999a:      XAB              ; [Transfer A to B]
999b:      BLE   D99AA      ; =+13 [Branch if less than or equal to zero]
999d:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
99a0:      AAB              ; [A + B -> B]
99a1:      DCR   B          ; [Decrement B by 1]
99a3:      STB   W99A8      ; =+3 [Store B relative]
99a5:      JSR/  F9C39      ; =0x9c39 =39993(-25543) [Jump to subroutine direct]
99a8:W99A8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
99aa:D99AA RSR              ; [Return from subroutine]
*
99ab:W99AB LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
99ad:      STAB/ B9509      ; =0x9509 =38153(-27383) [Store AL direct]
99b0:      RSR              ; [Return from subroutine]
*
99b1:W99B1 JSR   W9982      ; =-49 [Jump to subroutine relative]
99b3:      JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
99b6:      BL    D99D2      ; =+26 [Branch on link]
99b8:      XAB              ; [Transfer A to B]
99b9:      BLE   D99D2      ; =+23 [Branch if less than or equal to zero]
99bb:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
99bd:      JSR/  F9E57      ; =0x9e57 =40535(-25001) [Jump to subroutine direct]
99c0:      BL    D99C8      ; =+6 [Branch on link]
99c2:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
99c5:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
99c8:D99C8 LDA+  S+         ; [Load A indexed, direct, post-incremented]
99ca:      LDB/  W9540      ; =0x9540 =38208(-27328) [Load B direct]
99cd:      ADD   B,A        ; [B + A -> A]
99cf:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
99d2:D99D2 RSR              ; [Return from subroutine]
*
99d3:W99D3 JSR   W9982      ; =-83 [Jump to subroutine relative]
99d5:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
99d8:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
99db:      RSR              ; [Return from subroutine]
*
99dc:W99DC JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
99df:      BL    D99EA      ; =+9 [Branch on link]
99e1:      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
99e4:      SAB              ; [A - B -> B]
99e5:      BM    D99EA      ; =+3 [Branch on minus]
99e7:      STA/  W953E      ; =0x953e =38206(-27330) [Store A direct]
99ea:D99EA RSR              ; [Return from subroutine]
*
99eb:W99EB JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
99ee:      BL    D99F9      ; =+9 [Branch on link]
99f0:      LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
99f3:      SAB              ; [A - B -> B]
99f4:      BM    D99F9      ; =+3 [Branch on minus]
99f6:      STA/  W953C      ; =0x953c =38204(-27332) [Store A direct]
99f9:D99F9 RSR              ; [Return from subroutine]
*
99fa:W99FA JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
99fd:      BL    D9A08      ; =+9 [Branch on link]
99ff:      LDB=  X'0004'    ; =0x0004 =4 [Load B with immediate]
9a02:      SAB              ; [A - B -> B]
9a03:      BM    D9A08      ; =+3 [Branch on minus]
9a05:      STA/  W953A      ; =0x953a =38202(-27334) [Store A direct]
9a08:D9A08 RSR              ; [Return from subroutine]
*
9a09:W9A09 JSR/  F9C70      ; =0x9c70 =40048(-25488) [Jump to subroutine direct]
9a0c:      BL    D9A2F      ; =+33 [Branch on link]
9a0e:      XAB              ; [Transfer A to B]
9a0f:      BM    D9A26      ; =+21 [Branch on minus]
9a11:      BGZ   D9A1D      ; =+10 [Branch if greater than zero]
9a13:      CLA              ; [Clear A]
9a14:      STA/  W9544      ; =0x9544 =38212(-27324) [Store A direct]
9a17:      LDAB= X'01'      ; =1 [Load AL with immediate]
9a19:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
9a1b:      JMP   D9A29      ; =+12 [Jump relative]
9a1d:D9A1D DCA              ; [Decrement A]
9a1e:      STA/  W9544      ; =0x9544 =38212(-27324) [Store A direct]
9a21:      LDAB= X'01'      ; =1 [Load AL with immediate]
9a23:      XAB              ; [Transfer A to B]
9a24:      JMP   D9A29      ; =+3 [Jump relative]
9a26:D9A26 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9a28:      XABB             ; [Transfer AL to BL]
9a29:D9A29 STAB/ B9542      ; =0x9542 =38210(-27326) [Store AL direct]
9a2c:      STBB/ B9543      ; =0x9543 =38211(-27325) [Store BL direct]
9a2f:D9A2F RSR              ; [Return from subroutine]
*
9a30:W9A30 LDAB/ B954A      ; =0x954a =38218(-27318) [Load AL direct]
9a33:      BZ    D9A3C      ; =+7 [Branch if zero]
9a35:      CLAB             ; [Clear AL]
9a36:      STAB/ B954A      ; =0x954a =38218(-27318) [Store AL direct]
9a39:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
9a3c:D9A3C JSR/  W9982      ; =0x9982 =39298(-26238) [Jump to subroutine direct]
9a3f:      JSR/  F9F53      ; =0x9f53 =40787(-24749) [Jump to subroutine direct]
9a42:      STA   W9A47      ; =+3 [Store A relative]
9a44:      JSR/  F9C39      ; =0x9c39 =39993(-25543) [Jump to subroutine direct]
9a47:W9A47 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
9a49:      JSR/  F9D04      ; =0x9d04 =40196(-25340) [Jump to subroutine direct]
9a4c:      DW    W8A44      ; =0x8a44 =35396(-30140)
9a4e:      DW    S8A46      ; =0x8a46 =35398(-30138)
9a50:      JSR/  W9982      ; =0x9982 =39298(-26238) [Jump to subroutine direct]
9a53:      RSR              ; [Return from subroutine]
*
9a54:W9A54 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9a57:      JSR/  F9F53      ; =0x9f53 =40787(-24749) [Jump to subroutine direct]
9a5a:      DCA              ; [Decrement A]
9a5b:      STA/  W92E7      ; =0x92e7 =37607(-27929) [Store A direct]
9a5e:      JSR/  F9C26      ; =0x9c26 =39974(-25562) [Jump to subroutine direct]
9a61:      DW    W92E7      ; =0x92e7 =37607(-27929)
9a63:      LDA/  W8A44      ; =0x8a44 =35396(-30140) [Load A direct]
9a66:      XAX              ; [Transfer A to X]
9a67:      LDB/  W92E7      ; =0x92e7 =37607(-27929) [Load B direct]
9a6a:      ADD   B,A        ; [B + A -> A]
9a6c:      STA/  W92E7      ; =0x92e7 =37607(-27929) [Store A direct]
9a6f:      LDA=  W92E9      ; =0x92e9 =37609(-27927) [Load A with immediate]
9a72:      AAB              ; [A + B -> B]
9a73:      LDA=  S8A46      ; =0x8a46 =35398(-30138) [Load A with immediate]
9a76:      XAY              ; [Transfer A to Y]
9a77:D9A77 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9a79:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9a7b:      DCX              ; [Decrement X]
9a7c:      BGZ   D9A77      ; =-7 [Branch if greater than zero]
9a7e:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
9a81:W9A81 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
9a84:      STA/  W9538      ; =0x9538 =38200(-27336) [Store A direct]
9a87:      RSR              ; [Return from subroutine]
*
9a88:W9A88 LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9a8b:      STA/  W9538      ; =0x9538 =38200(-27336) [Store A direct]
9a8e:      RSR              ; [Return from subroutine]
*
9a8f:W9A8F RSR              ; [Return from subroutine]
*
9a90:W9A90 RSR              ; [Return from subroutine]
*
9a91:W9A91 JSR/  FA0D1      ; =0xa0d1 =41169(-24367) =' ','Q' [Jump to subroutine direct]
9a94:      BNL   D9A9F      ; =+9 [Branch on no link]
9a96:      CLA              ; [Clear A]
9a97:      STA/  W8936      ; =0x8936 =35126(-30410) [Store A direct]
9a9a:      LDAB= X'01'      ; =1 [Load AL with immediate]
9a9c:      STAB/ B9503      ; =0x9503 =38147(-27389) [Store AL direct]
9a9f:D9A9F RSR              ; [Return from subroutine]
*
9aa0:W9AA0 LDAB/ B94FF      ; =0x94ff =38143(-27393) [Load AL direct]
9aa3:      BZ    D9AA7      ; =+2 [Branch if zero]
9aa5:      JSR   F9AA8      ; =+1 [Jump to subroutine relative]
9aa7:D9AA7 RSR              ; [Return from subroutine]
*
* Function F9AA8
*
9aa8:F9AA8 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9aab:      LDBB/ B9500      ; =0x9500 =38144(-27392) [Load BL direct]
9aae:      LDAB= X'01'      ; =1 [Load AL with immediate]
9ab0:      STAB/ B9500      ; =0x9500 =38144(-27392) [Store AL direct]
9ab3:      SABB             ; [AL - BL -> BL]
9ab4:      BNZ   D9AB9      ; =+3 [Branch if not zero]
9ab6:      STBB/ B9500      ; =0x9500 =38144(-27392) [Store BL direct]
9ab9:D9AB9 LDA/  W856F+1    ; =0x8570 =34160(-31376) [Load A direct]
9abc:      LDB/  W954B      ; =0x954b =38219(-27317) [Load B direct]
9abf:      STA/  W954B      ; =0x954b =38219(-27317) [Store A direct]
9ac2:      STB/  W856F+1    ; =0x8570 =34160(-31376) [Store B direct]
9ac5:      LDA/  FA096+1    ; =0xa097 =41111(-24425) [Load A direct]
9ac8:      LDB/  W94FD      ; =0x94fd =38141(-27395) [Load B direct]
9acb:      STA/  W94FD      ; =0x94fd =38141(-27395) [Store A direct]
9ace:      STB/  FA096+1    ; =0xa097 =41111(-24425) [Store B direct]
9ad1:      LDB/  W954B      ; =0x954b =38219(-27317) [Load B direct]
9ad4:      LDA/  W954D      ; =0x954d =38221(-27315) [Load A direct]
9ad7:      LDB/  W954F      ; =0x954f =38223(-27313) [Load B direct]
9ada:      XAY              ; [Transfer A to Y]
9adb:      XFR   B,Z        ; [Transfer B to Z]
9add:      STA/  W954F      ; =0x954f =38223(-27313) [Store A direct]
9ae0:      STB/  W954D      ; =0x954d =38221(-27315) [Store B direct]
9ae3:      LDX=  X'0086'    ; =0x0086 =134 [Load X with immediate]
9ae6:D9AE6 LDAB+ Y          ; [Load AL from address in Y]
9ae7:      LDBB+ Z          ; [Load BL from address in Z]
9ae8:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9aea:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9aec:      DCX              ; [Decrement X]
9aed:      BGZ   D9AE6      ; =-9 [Branch if greater than zero]
9aef:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9AF2
*
9af2:F9AF2 LDA/  W9544      ; =0x9544 =38212(-27324) [Load A direct]
9af5:      LDB/  W9546      ; =0x9546 =38214(-27322) [Load B direct]
9af8:      SAB              ; [A - B -> B]
9af9:      BP    D9AFF      ; =+4 [Branch on plus]
9afb:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9afd:      JMP   D9B01      ; =+2 [Jump relative]
9aff:D9AFF LDAB= X'01'      ; =1 [Load AL with immediate]
9b01:D9B01 STAB/ BA198      ; =0xa198 =41368(-24168) [Store AL direct]
9b04:      LDA/  W953A      ; =0x953a =38202(-27334) [Load A direct]
9b07:      DCA              ; [Decrement A]
9b08:      DCA              ; [Decrement A]
9b09:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
9b0c:      LDA/  W92E7      ; =0x92e7 =37607(-27929) [Load A direct]
9b0f:      BZ    D9B1D      ; =+12 [Branch if zero]
9b11:      JSR/  FA11E      ; =0xa11e =41246(-24290) [Jump to subroutine direct]
9b14:      DW    W92E7      ; =0x92e7 =37607(-27929)
9b16:      LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9b19:      INA              ; [Increment A]
9b1a:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9b1d:D9B1D LDA/  W953A      ; =0x953a =38202(-27334) [Load A direct]
9b20:      INA              ; [Increment A]
9b21:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
9b24:      RSR              ; [Return from subroutine]
*
* Function F9B25
*
9b25:F9B25 LDAB/ B954A      ; =0x954a =38218(-27318) [Load AL direct]
9b28:      BZ    D9B2F      ; =+5 [Branch if zero]
9b2a:      CLAB             ; [Clear AL]
9b2b:      STAB/ B954A      ; =0x954a =38218(-27318) [Store AL direct]
9b2e:      RSR              ; [Return from subroutine]
*
9b2f:D9B2F JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9b32:      LDAB/ B9542      ; =0x9542 =38210(-27326) [Load AL direct]
9b35:      LDBB= X'01'      ; =1 [Load BL with immediate]
9b37:      SABB             ; [AL - BL -> BL]
9b38:      BZ    D9B3D      ; =+3 [Branch if zero]
9b3a:      JMP/  J9BC8      ; =0x9bc8 =39880(-25656) [Jump direct]
9b3d:D9B3D LDX/  W9544      ; =0x9544 =38212(-27324) [Load X direct]
9b40:      INX              ; [Increment X]
9b41:      STX/  W9544      ; =0x9544 =38212(-27324) [Store X direct]
9b44:      XFR   X,A        ; [Transfer X to A]
9b46:      DCA              ; [Decrement A]
9b47:      BNZ   D9B4E      ; =+5 [Branch if not zero]
9b49:      LDAB/ B9543      ; =0x9543 =38211(-27325) [Load AL direct]
9b4c:      BZ    J9BC8      ; =+122 [Branch if zero]
9b4e:D9B4E STX-  S-         ; [Store X indexed, pre-decremented, direct]
9b50:      LDA/  W953E      ; =0x953e =38206(-27330) [Load A direct]
9b53:      LDB/  W953C      ; =0x953c =38204(-27332) [Load B direct]
9b56:      SAB              ; [A - B -> B]
9b57:      XFR   B,A        ; [Transfer B to A]
9b59:      INA              ; [Increment A]
9b5a:      INA              ; [Increment A]
9b5b:      INA              ; [Increment A]
9b5c:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
9b5f:      LDAB/ B9B74      ; =0x9b74 =39796(-25740) [Load AL direct]
9b62:      DCAB             ; [Decrement AL]
9b63:      BNZ   D9B75      ; =+16 [Branch if not zero]
9b65:      LDA/  W92E3      ; =0x92e3 =37603(-27933) [Load A direct]
9b68:      LDB/  W92E5      ; =0x92e5 =37605(-27931) [Load B direct]
9b6b:      SAB              ; [A - B -> B]
9b6c:      SRR   B          ; [Right shift B by 1]
9b6e:      LDA/  W92E5      ; =0x92e5 =37605(-27931) [Load A direct]
9b71:      AAB              ; [A + B -> B]
9b72:      JMP   D9B82      ; =+14 [Jump relative]
*
9b74:B9B74 DB    X'00'      ; =0x00 =0 =NUL
*
9b75:D9B75 LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9b78:      LDB/  W92DB      ; =0x92db =37595(-27941) [Load B direct]
9b7b:      SAB              ; [A - B -> B]
9b7c:      SRR   B          ; [Right shift B by 1]
9b7e:      LDA/  W92DB      ; =0x92db =37595(-27941) [Load A direct]
9b81:      AAB              ; [A + B -> B]
9b82:D9B82 XFR   B,A        ; [Transfer B to A]
9b84:      LDB/  W8B52      ; =0x8b52 =35666(-29870) [Load B direct]
9b87:      SRR   B          ; [Right shift B by 1]
9b89:      AAB              ; [A + B -> B]
9b8a:      STB/  W8A44      ; =0x8a44 =35396(-30140) [Store B direct]
9b8d:      LDA=  W8A44      ; =0x8a44 =35396(-30140) [Load A with immediate]
9b90:      AAB              ; [A + B -> B]
9b91:      STB   W9B9C      ; =+9 [Store B relative]
9b93:      JSR/  F9C26      ; =0x9c26 =39974(-25562) [Jump to subroutine direct]
9b96:      DW    W8A44      ; =0x8a44 =35396(-30140)
9b98:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9b9a:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
9b9c:W9B9C DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of end of string]
9b9e:      LDA   W9B9C      ; =-4 [Load A relative]
9ba0:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
9ba3:D9BA3 LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
9ba5:      SUBB  BU,BL      ; [BU - BL -> BL]
9ba7:      BNZ   D9BA3      ; =-6 [Branch if not zero]
9ba9:      LDB/  W8B52      ; =0x8b52 =35666(-29870) [Load B direct]
9bac:      SAB              ; [A - B -> B]
9bad:      INR   B          ; [Increment B by 1]
9baf:      STB   W9BB8      ; =+7 [Store B relative]
9bb1:      LDA/  W8B52      ; =0x8b52 =35666(-29870) [Load A direct]
9bb4:      XAB              ; [Transfer A to B]
9bb5:      JSR/  FA29F      ; =0xa29f =41631(-23905) [Jump to subroutine direct]
9bb8:W9BB8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9bba:      DW    S8B54      ; =0x8b54 =35668(-29868)
*
9bbc:      JSR/  FA11E      ; =0xa11e =41246(-24290) [Jump to subroutine direct]
9bbf:      DW    W8A44      ; =0x8a44 =35396(-30140)
9bc1:      LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9bc4:      INA              ; [Increment A]
9bc5:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9bc8:J9BC8 LDA/  W953E      ; =0x953e =38206(-27330) [Load A direct]
9bcb:      INA              ; [Increment A]
9bcc:      INA              ; [Increment A]
9bcd:      JSR   F9BF9      ; =+42 [Jump to subroutine relative]
9bcf:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
9bd2:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9bd5:      LDAB/ B9507      ; =0x9507 =38151(-27385) [Load AL direct]
9bd8:      BZ    D9BE1      ; =+7 [Branch if zero]
9bda:      LDAB/ BA198      ; =0xa198 =41368(-24168) [Load AL direct]
9bdd:      BNZ   D9BF6      ; =+23 [Branch if not zero]
9bdf:      JMP   D9BF0      ; =+15 [Jump relative]
9be1:D9BE1 LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
9be4:      JSR   F9BF9      ; =+19 [Jump to subroutine relative]
9be6:      LDAB/ BA198      ; =0xa198 =41368(-24168) [Load AL direct]
9be9:      BZ    D9BF0      ; =+5 [Branch if zero]
9beb:      JSR/  FA237      ; =0xa237 =41527(-24009) [Jump to subroutine direct]
9bee:      DW    W8A44      ; =0x8a44 =35396(-30140)
*
9bf0:D9BF0 LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9bf3:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9bf6:D9BF6 JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9BF9
*
9bf9:F9BF9 LDB/  W9540      ; =0x9540 =38208(-27328) [Load B direct]
9bfc:      SAB              ; [A - B -> B]
9bfd:      BGZ   D9C00      ; =+1 [Branch if greater than zero]
9bff:      RSR              ; [Return from subroutine]
*
9c00:D9C00 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9c03:      LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9c06:      ADD   B,A        ; [B + A -> A]
9c08:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9c0b:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9c0d:      XFR   B,X        ; [Transfer B to X]
9c0f:D9C0F LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9c12:      STA/  W9C22      ; =0x9c22 =39970(-25566) [Store A direct]
9c15:      JSR/  FA11E      ; =0xa11e =41246(-24290) [Jump to subroutine direct]
9c18:      DW    W9C22      ; =0x9c22 =39970(-25566)
9c1a:      DCX              ; [Decrement X]
9c1b:      BGZ   D9C0F      ; =-14 [Branch if greater than zero]
9c1d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9c1f:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
9c22:W9C22 DW    X'0001'    ; =0x0001 =1
9c24:      DC    '  '       ; hex:a0a0 dec:41120(-96)
*
*
* Function F9C26
*
9c26:F9C26 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9c28:      JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9c2b:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
9c2d:      XAX              ; [Transfer A to X]
9c2e:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
9c30:D9C30 STAB+ X+         ; [Store AL indexed, direct, post-incremented]
9c32:      DCR   B          ; [Decrement B by 1]
9c34:      BNZ   D9C30      ; =-6 [Branch if not zero]
9c36:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9C39
*
9c39:F9C39 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9c3b:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9c3e:      SAB              ; [A - B -> B]
9c3f:      BGZ   D9C42      ; =+1 [Branch if greater than zero]
9c41:      RSR              ; [Return from subroutine]
*
9c42:D9C42 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9c45:      XFR   B,X        ; [Transfer B to X]
9c47:      LDB/  W92DD      ; =0x92dd =37597(-27939) [Load B direct]
9c4a:      SAB              ; [A - B -> B]
9c4b:      BP    D9C64      ; =+23 [Branch on plus]
9c4d:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9c50:      XAY              ; [Transfer A to Y]
9c51:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9c54:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9c56:D9C56 STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9c58:      INA              ; [Increment A]
9c59:      DCX              ; [Decrement X]
9c5a:      BNZ   D9C56      ; =-6 [Branch if not zero]
9c5c:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9c5f:      XFR   Y,A        ; [Transfer Y to A]
9c61:      STA/  W936D      ; =0x936d =37741(-27795) [Store A direct]
9c64:D9C64 JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9C67
*
9c67:F9C67 LDAB/ B9508      ; =0x9508 =38152(-27384) [Load AL direct]
9c6a:      BZ    D9C6F      ; =+3 [Branch if zero]
9c6c:      JSR/  F9DF7      ; =0x9df7 =40439(-25097) [Jump to subroutine direct]
9c6f:D9C6F RSR              ; [Return from subroutine]
*
* Function F9C70
*
9c70:F9C70 JSR/  FA01A      ; =0xa01a =40986(-24550) [Jump to subroutine direct]
9c73:      JSR   F9C81      ; =+12 [Jump to subroutine relative]
9c75:W9C75 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9c77:      LDA   W9C75      ; =-4 [Load A relative]
9c79:      BNL   D9C80      ; =+5 [Branch on no link]
9c7b:      LDBB= X'01'      ; =1 [Load BL with immediate]
9c7d:      STBB/ B9503      ; =0x9503 =38147(-27389) [Store BL direct]
9c80:D9C80 RSR              ; [Return from subroutine]
*
* Function F9C81
*
9c81:F9C81 CLA              ; [Clear A]
9c82:      STA+  X          ; [Store A to address in X]
9c83:      XFR   Y,A        ; [Transfer Y to A]
9c85:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9c87:      XFR   Z,A        ; [Transfer Z to A]
9c89:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9c8b:      LDA=  W8938      ; =0x8938 =35128(-30408) [Load A with immediate]
9c8e:      XAY              ; [Transfer A to Y]
9c8f:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
9c92:      XAZ              ; [Transfer A to Z]
9c93:      BLE   D9CD9      ; =+68 [Branch if less than or equal to zero]
9c95:      CLA              ; [Clear A]
9c96:B9C96 STAB= X'00'      ; =0 =NUL [Store AL immediate]
9c98:D9C98 DCR   Z          ; [Decrement Z by 1]
9c9a:      BP    D9CAE      ; =+18 [Branch on plus]
9c9c:      LDAB  B9C96+1    ; =-7 [Load AL relative]
9c9e:      BZ    D9CA4      ; =+4 [Branch if zero]
9ca0:      LDA+  X          ; [Load A from address in X]
9ca1:      IVA              ; [Invert A]
9ca2:      INA              ; [Increment A]
9ca3:      STA+  X          ; [Store A to address in X]
9ca4:D9CA4 RL               ; [Reset link]
9ca5:D9CA5 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9ca7:      XAZ              ; [Transfer A to Z]
9ca8:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9caa:      XAY              ; [Transfer A to Y]
9cab:      INX              ; [Increment X]
9cac:      INX              ; [Increment X]
9cad:      RSR              ; [Return from subroutine]
*
9cae:D9CAE LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9cb0:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
9cb2:      SABB             ; [AL - BL -> BL]
9cb3:      BZ    D9CBA      ; =+5 [Branch if zero]
9cb5:      LDBB= X'04'      ; =4 [Load BL with immediate]
9cb7:      SABB             ; [AL - BL -> BL]
9cb8:      BNZ   D9CBE      ; =+4 [Branch if not zero]
9cba:D9CBA STAB  B9C96+1    ; =-37 [Store AL relative]
9cbc:      JMP   D9C98      ; =-38 [Jump relative]
9cbe:D9CBE LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
9cc0:      SABB             ; [AL - BL -> BL]
9cc1:      BM    D9CD9      ; =+22 [Branch on minus]
9cc3:      LDAB= X'09'      ; =9 [Load AL with immediate]
9cc5:      SUBB  BL,AL      ; [BL - AL -> AL]
9cc7:      BGZ   D9CD9      ; =+16 [Branch if greater than zero]
9cc9:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
9ccb:      LDA+  X          ; [Load A from address in X]
9ccc:      SLA              ; [Left shift A]
9ccd:      SLA              ; [Left shift A]
9cce:      LDB+  X          ; [Load B from address in X]
9ccf:      AAB              ; [A + B -> B]
9cd0:      SLR   B          ; [Left shift B by 1]
9cd2:      CLA              ; [Clear A]
9cd3:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9cd5:      AAB              ; [A + B -> B]
9cd6:      STB+  X          ; [Store B to address in X]
9cd7:      JMP   D9C98      ; =-65 [Jump relative]
9cd9:D9CD9 SL               ; [Set link]
9cda:      JMP   D9CA5      ; =-55 [Jump relative]
*
* Function F9CDC
*
9cdc:F9CDC STX-  S-         ; [Store X indexed, pre-decremented, direct]
9cde:      LDX/  W936D      ; =0x936d =37741(-27795) [Load X direct]
9ce1:D9CE1 LDAB- X-         ; [Load AL indexed, pre-decremented, direct]
9ce3:      LDB/  W9501      ; =0x9501 =38145(-27391) [Load B direct]
9ce6:      SUB   X,B        ; [X - B -> B]
9ce8:      BLE   D9CFD      ; =+19 [Branch if less than or equal to zero]
9cea:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9cec:      SABB             ; [AL - BL -> BL]
9ced:      BZ    D9CF4      ; =+5 [Branch if zero]
9cef:      LDBB= X'70'      ; =112 [Load BL with immediate]
9cf1:      SABB             ; [AL - BL -> BL]
9cf2:      BNZ   D9CFD      ; =+9 [Branch if not zero]
9cf4:D9CF4 LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9cf7:      DCA              ; [Decrement A]
9cf8:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9cfb:      JMP   D9CE1      ; =-28 [Jump relative]
9cfd:D9CFD INX              ; [Increment X]
9cfe:      STX/  W936D      ; =0x936d =37741(-27795) [Store X direct]
9d01:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9d03:      RSR              ; [Return from subroutine]
*
* Function F9D04
*
9d04:F9D04 LDAB= X'01'      ; =1 [Load AL with immediate]
9d06:      STAB/ B9508      ; =0x9508 =38152(-27384) [Store AL direct]
9d09:      LDA+  *X+        ; [Load A indexed, indirect, post-incremented]
9d0b:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9d0d:      JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9d10:      XAX              ; [Transfer A to X]
9d11:      BNZ   D9D16      ; =+3 [Branch if not zero]
9d13:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
9d16:D9D16 XFR   B,Y        ; [Transfer B to Y]
9d18:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9d1b:      XAZ              ; [Transfer A to Z]
9d1c:      LDAB+ Z,-1       ; [Load AL indexed, displaced, direct]
9d1f:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
9d21:      SABB             ; [AL - BL -> BL]
9d22:      BNZ   D9D40      ; =+28 [Branch if not zero]
9d24:      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
9d27:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
9d29:      SABB             ; [AL - BL -> BL]
9d2a:      BNZ   D9D40      ; =+20 [Branch if not zero]
9d2c:      INR   Y,3        ; [Increment Y by 3]
9d2e:      DCR   X,3        ; [Decrement X by 3]
9d30:      LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9d33:      DCR   A,3        ; [Decrement A by 3]
9d35:      STA/  W92DD      ; =0x92dd =37597(-27939) [Store A direct]
9d38:      LDAB/ B9881      ; =0x9881 =39041(-26495) [Load AL direct]
9d3b:      DCRB  AL,3       ; [Decrement AL by 3]
9d3d:      STAB/ B9881      ; =0x9881 =39041(-26495) [Store AL direct]
9d40:D9D40 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9d42:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9d44:      LDBB= X'04'      ; =4 [Load BL with immediate]
9d46:      SABB             ; [AL - BL -> BL]
9d47:      BZ    D9D51      ; =+8 [Branch if zero]
9d49:      LDB/  W92D9      ; =0x92d9 =37593(-27943) [Load B direct]
9d4c:      INR   B          ; [Increment B by 1]
9d4e:      STB/  W92D9      ; =0x92d9 =37593(-27943) [Store B direct]
9d51:D9D51 DCX              ; [Decrement X]
9d52:      BGZ   D9D40      ; =-20 [Branch if greater than zero]
9d54:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
9d56:      SABB             ; [AL - BL -> BL]
9d57:      BNZ   D9D5D      ; =+4 [Branch if not zero]
9d59:      DCR   Y          ; [Decrement Y by 1]
9d5b:      LDAB- Y-         ; [Load AL indexed, pre-decremented, direct]
9d5d:D9D5D JSR/  FA005      ; =0xa005 =40965(-24571) [Jump to subroutine direct]
9d60:      DC    '.:?!'     ; hex:aebabfa1
9d64:      DB    X'00'      ; =0x00 =0 =NUL
9d65:      BNL   D9D7D      ; =+22 [Branch on no link]
9d67:      LDA/  W9505      ; =0x9505 =38149(-27387) [Load A direct]
9d6a:      BZ    D9D72      ; =+6 [Branch if zero]
9d6c:      LDB=  X'0002'    ; =0x0002 =2 [Load B with immediate]
9d6f:      SAB              ; [A - B -> B]
9d70:      BM    D9D7D      ; =+11 [Branch on minus]
9d72:D9D72 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
9d74:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9d76:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9d79:      INA              ; [Increment A]
9d7a:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9d7d:D9D7D LDAB= X'70'      ; =112 [Load AL with immediate]
9d7f:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9d81:      LDA/  W92D9      ; =0x92d9 =37593(-27943) [Load A direct]
9d84:      INA              ; [Increment A]
9d85:      STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9d88:      XFR   Z,A        ; [Transfer Z to A]
9d8a:      STA/  W936D      ; =0x936d =37741(-27795) [Store A direct]
9d8d:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9D90
*
9d90:F9D90 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9d93:      FIL   (255)=' ',/W936F ; =0x936f =37743(-27793) [Fill with byte, literal=0xa0(160,-96), direct]
9d99:      LDA=  W936F      ; =0x936f =37743(-27793) [Load A with immediate]
9d9c:      XAY              ; [Transfer A to Y]
9d9d:      LDA/  W92E1      ; =0x92e1 =37601(-27935) [Load A direct]
9da0:      LDBB/ B9803      ; =0x9803 =38915(-26621) [Load BL direct]
9da3:      BZ    D9DB0      ; =+11 [Branch if zero]
9da5:      CLR   B          ; [Clear B]
9da7:      LDBB/ B9881      ; =0x9881 =39041(-26495) [Load BL direct]
9daa:      SAB              ; [A - B -> B]
9dab:      XFR   B,A        ; [Transfer B to A]
9dad:      STA/  W92E1      ; =0x92e1 =37601(-27935) [Store A direct]
9db0:D9DB0 STA/  W92D9      ; =0x92d9 =37593(-27943) [Store A direct]
9db3:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9db5:D9DB5 DCA              ; [Decrement A]
9db6:      BLE   D9DBC      ; =+4 [Branch if less than or equal to zero]
9db8:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9dba:      JMP   D9DB5      ; =-7 [Jump relative]
9dbc:D9DBC XFR   Y,A        ; [Transfer Y to A]
9dbe:      STA/  W936D      ; =0x936d =37741(-27795) [Store A direct]
9dc1:      STA/  W9501      ; =0x9501 =38145(-27391) [Store A direct]
9dc4:      STA/  W92DF      ; =0x92df =37599(-27937) [Store A direct]
9dc7:      LDAB/ B9881      ; =0x9881 =39041(-26495) [Load AL direct]
9dca:      BNZ   D9DCF      ; =+3 [Branch if not zero]
9dcc:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
9dcf:D9DCF LDAB/ B9881      ; =0x9881 =39041(-26495) [Load AL direct]
9dd2:      LDB/  W92DD      ; =0x92dd =37597(-27939) [Load B direct]
9dd5:D9DD5 DCR   B          ; [Decrement B by 1]
9dd7:      DCAB             ; [Decrement AL]
9dd8:      BNZ   D9DD5      ; =-5 [Branch if not zero]
9dda:      STAB/ B9881      ; =0x9881 =39041(-26495) [Store AL direct]
9ddd:      STB/  W92DD      ; =0x92dd =37597(-27939) [Store B direct]
9de0:      LDAB/ B9880      ; =0x9880 =39040(-26496) [Load AL direct]
9de3:      BZ    D9DE8      ; =+3 [Branch if zero]
9de5:      JSR/  W981E      ; =0x981e =38942(-26594) [Jump to subroutine direct]
9de8:D9DE8 JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9DEB
*
9deb:F9DEB LDAB/ B9504      ; =0x9504 =38148(-27388) [Load AL direct]
9dee:      BZ    D9DF3      ; =+3 [Branch if zero]
9df0:      JSR/  F9EBC      ; =0x9ebc =40636(-24900) [Jump to subroutine direct]
9df3:D9DF3 JSR/  F9DF7      ; =0x9df7 =40439(-25097) [Jump to subroutine direct]
9df6:      DB    X'09'      ; =0x09 =9
*
* Function F9DF7
*
9df7:F9DF7 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9dfa:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9dfc:      LDAB/ B9880      ; =0x9880 =39040(-26496) [Load AL direct]
9dff:      BZ    D9E15      ; =+20 [Branch if zero]
9e01:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9e04:      LDB+  A          ; [Load B from address in A]
9e05:      LDA=  X'9BB0'    ; =0x9bb0 =39856(-25680) [Load A with immediate]
9e08:      SAB              ; [A - B -> B]
9e09:      BZ    D9E12      ; =+7 [Branch if zero]
9e0b:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9e0e:      INA              ; [Increment A]
9e0f:      STA/  W936D      ; =0x936d =37741(-27795) [Store A direct]
9e12:D9E12 JSR/  F989C      ; =0x989c =39068(-26468) [Jump to subroutine direct]
9e15:D9E15 LDB+  S+         ; [Load B indexed, direct, post-incremented]
9e17:      CLA              ; [Clear A]
9e18:      INA              ; [Increment A]
9e19:      JSR   F9E57      ; =+60 [Jump to subroutine relative]
9e1b:      BL    D9E23      ; =+6 [Branch on link]
9e1d:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
9e20:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
9e23:D9E23 LDA=  W89BD      ; =0x89bd =35261(-30275) [Load A with immediate]
9e26:      STA   W9E2D      ; =+5 [Store A relative]
9e28:      JSR   F9E70      ; =+70 [Jump to subroutine relative]
9e2a:      JSR/  FA11E      ; =0xa11e =41246(-24290) [Jump to subroutine direct]
9e2d:W9E2D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9e2f:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9e31:      STAB/ B9508      ; =0x9508 =38152(-27384) [Store AL direct]
9e34:      LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9e37:      INA              ; [Increment A]
9e38:      STA/  W9540      ; =0x9540 =38208(-27328) [Store A direct]
9e3b:      LDA/  W9538      ; =0x9538 =38200(-27336) [Load A direct]
9e3e:      DCA              ; [Decrement A]
9e3f:      BLE   D9E54      ; =+19 [Branch if less than or equal to zero]
9e41:      JSR   F9E57      ; =+20 [Jump to subroutine relative]
9e43:      BL    D9E4D      ; =+8 [Branch on link]
9e45:      JSR/  F9B25      ; =0x9b25 =39717(-25819) [Jump to subroutine direct]
9e48:      JSR/  F9AF2      ; =0x9af2 =39666(-25870) [Jump to subroutine direct]
9e4b:      JMP   D9E54      ; =+7 [Jump relative]
9e4d:D9E4D LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9e50:      INA              ; [Increment A]
9e51:      JSR/  F9BF9      ; =0x9bf9 =39929(-25607) [Jump to subroutine direct]
9e54:D9E54 JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9E57
*
9e57:F9E57 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9e59:      XAX              ; [Transfer A to X]
9e5a:      LDA/  W953E      ; =0x953e =38206(-27330) [Load A direct]
9e5d:      LDB/  W953C      ; =0x953c =38204(-27332) [Load B direct]
9e60:      SAB              ; [A - B -> B]
9e61:      LDA/  W9540      ; =0x9540 =38208(-27328) [Load A direct]
9e64:      ADD   X,A        ; [X + A -> A]
9e66:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9e68:      DCA              ; [Decrement A]
9e69:      SAB              ; [A - B -> B]
9e6a:      BLE   D9E6E      ; =+2 [Branch if less than or equal to zero]
9e6c:      RL               ; [Reset link]
9e6d:      RSR              ; [Return from subroutine]
*
9e6e:D9E6E SL               ; [Set link]
9e6f:      RSR              ; [Return from subroutine]
*
* Function F9E70
*
9e70:F9E70 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9e73:      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
9e76:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
9e79:      JSR/  F9C26      ; =0x9c26 =39974(-25562) [Jump to subroutine direct]
9e7c:      DW    W8A44      ; =0x8a44 =35396(-30140)
9e7e:      CLA              ; [Clear A]
9e7f:      STA/  W950B      ; =0x950b =38155(-27381) [Store A direct]
9e82:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
9e85:      LDA   W9E2D      ; =-90 [Load A relative]
9e87:      INA              ; [Increment A]
9e88:      INA              ; [Increment A]
9e89:      XAZ              ; [Transfer A to Z]
9e8a:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9e8d:      LDX=  W936F      ; =0x936f =37743(-27793) [Load X with immediate]
9e90:      XFR   X,Y        ; [Transfer X to Y]
9e92:      SUB   A,X        ; [A - X -> X]
9e94:D9E94 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9e96:      DCX              ; [Decrement X]
9e97:      BM    D9EAF      ; =+22 [Branch on minus]
9e99:      XABB             ; [Transfer AL to BL]
9e9a:      BP    D9EA0      ; =+4 [Branch on plus]
9e9c:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9e9e:      JMP   D9E94      ; =-12 [Jump relative]
9ea0:D9EA0 LDBB= X'70'      ; =112 [Load BL with immediate]
9ea2:      SABB             ; [AL - BL -> BL]
9ea3:      BM    D9EAD      ; =+8 [Branch on minus]
9ea5:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
9ea7:D9EA7 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
9ea9:      DCRB  BL         ; [Decrement BL by 1]
9eab:      BP    D9EA7      ; =-6 [Branch on plus]
9ead:D9EAD JMP   D9E94      ; =-27 [Jump relative]
9eaf:D9EAF LDA/  W9E2D      ; =0x9e2d =40493(-25043) [Load A direct]
9eb2:      XAX              ; [Transfer A to X]
9eb3:      INX              ; [Increment X]
9eb4:      INX              ; [Increment X]
9eb5:      SUB   Z,X        ; [Z - X -> X]
9eb7:      STX+  A          ; [Store X indexed, direct]
9eb9:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9EBC
*
9ebc:F9EBC JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9ebf:      LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9ec2:      LDX/  W92D9      ; =0x92d9 =37593(-27943) [Load X direct]
9ec5:      SUB   A,X        ; [A - X -> X]
9ec7:      BLE   D9F26      ; =+93 [Branch if less than or equal to zero]
9ec9:      LDA/  W92DF      ; =0x92df =37599(-27937) [Load A direct]
9ecc:      LDB/  W936D      ; =0x936d =37741(-27795) [Load B direct]
9ecf:      SAB              ; [A - B -> B]
9ed0:      BM    D9EDC      ; =+10 [Branch on minus]
9ed2:      BZ    D9F26      ; =+82 [Branch if zero]
9ed4:      LDB/  W936D      ; =0x936d =37741(-27795) [Load B direct]
9ed7:      XFR   B,Y        ; [Transfer B to Y]
9ed9:      XAZ              ; [Transfer A to Z]
9eda:      JMP   D9EE4      ; =+8 [Jump relative]
9edc:D9EDC LDA/  W92DF      ; =0x92df =37599(-27937) [Load A direct]
9edf:      XAY              ; [Transfer A to Y]
9ee0:      LDA/  W936D      ; =0x936d =37741(-27795) [Load A direct]
9ee3:      XAZ              ; [Transfer A to Z]
9ee4:D9EE4 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9ee6:      STAB  B9F1E+1    ; =+55 [Store AL relative]
9ee8:      XFR   Y,A        ; [Transfer Y to A]
9eea:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9eec:      XFR   Z,A        ; [Transfer Z to A]
9eee:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9ef0:      LDAB/ B950D      ; =0x950d =38157(-27379) [Load AL direct]
9ef3:      LDBB= X'01'      ; =1 [Load BL with immediate]
9ef5:      SABB             ; [AL - BL -> BL]
9ef6:      BZ    D9F29      ; =+49 [Branch if zero]
9ef8:      LDAB= X'01'      ; =1 [Load AL with immediate]
9efa:      STAB/ B950D      ; =0x950d =38157(-27379) [Store AL direct]
9efd:      LDAB= X'70'      ; =112 [Load AL with immediate]
9eff:D9EFF LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
9f01:      SABB             ; [AL - BL -> BL]
9f02:      BNZ   D9F11      ; =+13 [Branch if not zero]
9f04:      XABB             ; [Transfer AL to BL]
9f05:      INRB  BL         ; [Increment BL by 1]
9f07:      STBB+ Y,-1       ; [Store BL indexed, displaced, direct]
9f0a:      LDBB= X'01'      ; =1 [Load BL with immediate]
9f0c:      STBB  B9F1E+1    ; =+17 [Store BL relative]
9f0e:      DCX              ; [Decrement X]
9f0f:      BZ    D9F22      ; =+17 [Branch if zero]
9f11:D9F11 LDB+  S          ; [Load B from address in S]
9f12:      SUB   Y,B        ; [Y - B -> B]
9f14:      BNZ   D9EFF      ; =-23 [Branch if not zero]
9f16:      INAB             ; [Increment AL]
9f17:      BM    D9F22      ; =+9 [Branch on minus]
9f19:      LDB+  S,2        ; [Load B indexed, displaced, direct]
9f1c:      XFR   B,Y        ; [Transfer B to Y]
9f1e:B9F1E LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
9f20:      BNZ   D9EFF      ; =-35 [Branch if not zero]
9f22:D9F22 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9f24:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9f26:D9F26 JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
9f29:D9F29 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9f2b:      STAB/ B950D      ; =0x950d =38157(-27379) [Store AL direct]
9f2e:      LDAB= X'70'      ; =112 [Load AL with immediate]
9f30:D9F30 LDBB- Z-         ; [Load BL indexed, pre-decremented, direct]
9f32:      SABB             ; [AL - BL -> BL]
9f33:      BNZ   D9F40      ; =+11 [Branch if not zero]
9f35:      XABB             ; [Transfer AL to BL]
9f36:      INRB  BL         ; [Increment BL by 1]
9f38:      STBB+ Z          ; [Store BL to address in Z]
9f39:      LDBB= X'01'      ; =1 [Load BL with immediate]
9f3b:      STBB  B9F1E+1    ; =-30 [Store BL relative]
9f3d:      DCX              ; [Decrement X]
9f3e:      BZ    D9F22      ; =-30 [Branch if zero]
9f40:D9F40 LDB+  S,2        ; [Load B indexed, displaced, direct]
9f43:      SUB   Z,B        ; [Z - B -> B]
9f45:      BNZ   D9F30      ; =-23 [Branch if not zero]
9f47:      INAB             ; [Increment AL]
9f48:      BM    D9F22      ; =-40 [Branch on minus]
9f4a:      LDB+  S          ; [Load B from address in S]
9f4b:      XFR   B,Z        ; [Transfer B to Z]
9f4d:      LDBB  B9F1E+1    ; =-48 [Load BL relative]
9f4f:      BZ    D9F22      ; =-47 [Branch if zero]
9f51:      JMP   D9F30      ; =-35 [Jump relative]
*
* Function F9F53
*
9f53:F9F53 JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
9f56:      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
9f59:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
9f5c:      JSR/  F9C26      ; =0x9c26 =39974(-25562) [Jump to subroutine direct]
9f5f:      DW    W8A44      ; =0x8a44 =35396(-30140)
9f61:      JSR/  FA01A      ; =0xa01a =40986(-24550) [Jump to subroutine direct]
9f64:      LDA/  W9505      ; =0x9505 =38149(-27387) [Load A direct]
9f67:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
9f6a:      LDAB/ W8938      ; =0x8938 =35128(-30408) [Load AL direct]
9f6d:      XAZB             ; [Transfer AL to ZL]
9f6e:D9F6E JSR/  FA01A      ; =0xa01a =40986(-24550) [Jump to subroutine direct]
9f71:      LDA/  W8936      ; =0x8936 =35126(-30410) [Load A direct]
9f74:      BZ    D9FAE      ; =+56 [Branch if zero]
9f76:      XAX              ; [Transfer A to X]
9f77:      LDAB/ W8938      ; =0x8938 =35128(-30408) [Load AL direct]
9f7a:      SUBB  ZL,AL      ; [ZL - AL -> AL]
9f7c:      BZ    D9FAE      ; =+48 [Branch if zero]
9f7e:      LDA/  W8A44      ; =0x8a44 =35396(-30140) [Load A direct]
9f81:      LDB=  S8A46      ; =0x8a46 =35398(-30138) [Load B with immediate]
9f84:      AAB              ; [A + B -> B]
9f85:      XFR   B,Y        ; [Transfer B to Y]
9f87:      ADD   X,A        ; [X + A -> A]
9f89:      LDB/  W9505      ; =0x9505 =38149(-27387) [Load B direct]
9f8c:      AAB              ; [A + B -> B]
9f8d:      LDA=  X'0085'    ; =0x0085 =133 [Load A with immediate]
9f90:      SUB   B,A        ; [B - A -> A]
9f92:      BP    D9F6E      ; =-38 [Branch on plus]
9f94:      STB/  W8A44      ; =0x8a44 =35396(-30140) [Store B direct]
9f97:      LDB=  W8938      ; =0x8938 =35128(-30408) [Load B with immediate]
9f9a:D9F9A LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
9f9c:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9f9e:      LDBB= X'04'      ; =4 [Load BL with immediate]
9fa0:      SABB             ; [AL - BL -> BL]
9fa1:      BNZ   D9FA5      ; =+2 [Branch if not zero]
9fa3:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
9fa5:D9FA5 LDB+  S+         ; [Load B indexed, direct, post-incremented]
9fa7:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9fa9:      DCX              ; [Decrement X]
9faa:      BGZ   D9F9A      ; =-18 [Branch if greater than zero]
9fac:      JMP   D9F6E      ; =-64 [Jump relative]
9fae:D9FAE LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9fb1:      LDB/  W92DB      ; =0x92db =37595(-27941) [Load B direct]
9fb4:      SAB              ; [A - B -> B]
9fb5:      LDA/  W8A44      ; =0x8a44 =35396(-30140) [Load A direct]
9fb8:      SUB   B,A        ; [B - A -> A]
9fba:      BP    D9FC0      ; =+4 [Branch on plus]
9fbc:      STB/  W8A44      ; =0x8a44 =35396(-30140) [Store B direct]
9fbf:      CLA              ; [Clear A]
9fc0:D9FC0 SRA              ; [Right shift A]
9fc1:      LDB/  W92DB      ; =0x92db =37595(-27941) [Load B direct]
9fc4:      ADD   B,A        ; [B + A -> A]
9fc6:      JMP/  JA0FA      ; =0xa0fa =41210(-24326) =' ','z' [Jump direct]
*
* Function F9FC9
*
9fc9:F9FC9 LDA/  W950E      ; =0x950e =38158(-27378) [Load A direct]
9fcc:      LDB=  W9510      ; =0x9510 =38160(-27376) [Load B with immediate]
9fcf:      SAB              ; [A - B -> B]
9fd0:      BGZ   D9FD3      ; =+1 [Branch if greater than zero]
9fd2:      RSR              ; [Return from subroutine]
*
9fd3:D9FD3 LDB-  A-         ; [Load B indexed, pre-decremented, direct]
9fd5:      STB/  W92DD      ; =0x92dd =37597(-27939) [Store B direct]
9fd8:      LDB-  A-         ; [Load B indexed, pre-decremented, direct]
9fda:      STB/  W92DB      ; =0x92db =37595(-27941) [Store B direct]
9fdd:      STA/  W950E      ; =0x950e =38158(-27378) [Store A direct]
9fe0:      RSR              ; [Return from subroutine]
*
* Function F9FE1
*
9fe1:F9FE1 LDA/  W92DD      ; =0x92dd =37597(-27939) [Load A direct]
9fe4:      STA/  W92E3      ; =0x92e3 =37603(-27933) [Store A direct]
9fe7:      LDA/  W92DB      ; =0x92db =37595(-27941) [Load A direct]
9fea:      STA/  W92E5      ; =0x92e5 =37605(-27931) [Store A direct]
9fed:      LDA/  W950E      ; =0x950e =38158(-27378) [Load A direct]
9ff0:      LDB=  W9537      ; =0x9537 =38199(-27337) [Load B with immediate]
9ff3:      SAB              ; [A - B -> B]
9ff4:      BLE   D9FF7      ; =+1 [Branch if less than or equal to zero]
9ff6:      RSR              ; [Return from subroutine]
*
9ff7:D9FF7 LDB/  W92DB      ; =0x92db =37595(-27941) [Load B direct]
9ffa:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9ffc:      LDB/  W92DD      ; =0x92dd =37597(-27939) [Load B direct]
9fff:      STB+  A+         ; [Store B indexed, direct, post-incremented]
a001:      STA/  W950E      ; =0x950e =38158(-27378) [Store A direct]
a004:      RSR              ; [Return from subroutine]
*
* Function FA005
*
a005:FA005 LDBB= X'01'      ; =1 [Load BL with immediate]
a007:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
a009:DA009 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
a00b:      BZ    DA013      ; =+6 [Branch if zero]
a00d:      SABB             ; [AL - BL -> BL]
a00e:      BNZ   DA009      ; =-7 [Branch if not zero]
a010:      STBB+ S          ; [Store BL to address in S]
a011:      JMP   DA009      ; =-10 [Jump relative]
a013:DA013 LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
a015:      IVRB  BL         ; [Invert BL]
a017:      SRRB  BL         ; [Right shift BL by 1]
a019:      RSR              ; [Return from subroutine]
*
* Function FA01A
*
a01a:FA01A JSR/  FA0ED      ; =0xa0ed =41197(-24339) =' ','m' [Jump to subroutine direct]
a01d:DA01D CLA              ; [Clear A]
a01e:      STA/  W8936      ; =0x8936 =35126(-30410) [Store A direct]
a021:      STA/  W9505      ; =0x9505 =38149(-27387) [Store A direct]
a024:      STAB  BA03C+1    ; =+23 [Store AL relative]
a026:      INAB             ; [Increment AL]
a027:      STAB  BA056+1    ; =+46 [Store AL relative]
a029:      LDA=  W8938      ; =0x8938 =35128(-30408) [Load A with immediate]
a02c:      STA   WA070+1    ; =+67 [Store A relative]
a02e:DA02E JSR   FA096      ; =+102 [Jump to subroutine relative]
a030:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
a032:      SABB             ; [AL - BL -> BL]
a033:      BNZ   DA039      ; =+4 [Branch if not zero]
a035:      STAB  BA03C+1    ; =+6 [Store AL relative]
a037:      JMP   DA02E      ; =-11 [Jump relative]
a039:DA039 XABB             ; [Transfer AL to BL]
a03a:      BNZ   DA044      ; =+8 [Branch if not zero]
a03c:BA03C LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
a03e:      BNZ   DA01D      ; =-35 [Branch if not zero]
a040:      JMP   DA044      ; =+2 [Jump relative]
a042:DA042 JSR   FA096      ; =+82 [Jump to subroutine relative]
a044:DA044 XABB             ; [Transfer AL to BL]
a045:      BNZ   DA051      ; =+10 [Branch if not zero]
a047:      LDBB  BA056+1    ; =+14 [Load BL relative]
a049:      BNZ   DA08F      ; =+68 [Branch if not zero]
a04b:      INRB  BL         ; [Increment BL by 1]
a04d:      STBB  BA056+1    ; =+8 [Store BL relative]
a04f:      JMP   DA042      ; =-15 [Jump relative]
a051:DA051 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
a053:      SABB             ; [AL - BL -> BL]
a054:      BNZ   DA061      ; =+11 [Branch if not zero]
a056:BA056 STBB= X'00'      ; =0 =NUL [Store BL immediate]
a058:      LDBB/ B9509      ; =0x9509 =38153(-27383) [Load BL direct]
a05b:      BZ    DA061      ; =+4 [Branch if zero]
a05d:      LDAB= X'04'      ; =4 [Load AL with immediate]
a05f:      JMP   DA063      ; =+2 [Jump relative]
a061:DA061 STBB  BA056+1    ; =-12 [Store BL relative]
a063:DA063 LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
a065:      SABB             ; [AL - BL -> BL]
a066:      BZ    DA079      ; =+17 [Branch if zero]
a068:      LDB/  W8936      ; =0x8936 =35126(-30410) [Load B direct]
a06b:      INR   B          ; [Increment B by 1]
a06d:      STB/  W8936      ; =0x8936 =35126(-30410) [Store B direct]
a070:WA070 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
a073:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
a075:      STB   WA070+1    ; =-6 [Store B relative]
a077:      JMP   DA042      ; =-55 [Jump relative]
a079:DA079 LDA/  W9505      ; =0x9505 =38149(-27387) [Load A direct]
a07c:      INA              ; [Increment A]
a07d:      STA/  W9505      ; =0x9505 =38149(-27387) [Store A direct]
a080:      JSR   FA096      ; =+20 [Jump to subroutine relative]
a082:      XABB             ; [Transfer AL to BL]
a083:      BZ    DA08F      ; =+10 [Branch if zero]
a085:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
a087:      SABB             ; [AL - BL -> BL]
a088:      BZ    DA079      ; =-17 [Branch if zero]
a08a:      LDA   FA096+1    ; =+11 [Load A relative]
a08c:      DCA              ; [Decrement A]
a08d:      STA   FA096+1    ; =+8 [Store A relative]
a08f:DA08F LDAB= X'01'      ; =1 [Load AL with immediate]
a091:      STAB/ B9509      ; =0x9509 =38153(-27383) [Store AL direct]
a094:      JMP   JA0FA      ; =+100 [Jump relative]
*
* Function FA096
*
a096:FA096 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
a099:DA099 INA              ; [Increment A]
a09a:      STA   FA096+1    ; =-5 [Store A relative]
a09c:      LDB/  W88AF      ; =0x88af =34991(-30545) [Load B direct]
a09f:      SAB              ; [A - B -> B]
a0a0:      BLE   DA0AD      ; =+11 [Branch if less than or equal to zero]
a0a2:      DCR   B          ; [Decrement B by 1]
a0a4:      BZ    DA0AB      ; =+5 [Branch if zero]
a0a6:      JSR   FA0B3      ; =+11 [Jump to subroutine relative]
a0a8:      CLA              ; [Clear A]
a0a9:      JMP   DA099      ; =-18 [Jump relative]
a0ab:DA0AB CLA              ; [Clear A]
a0ac:      RSR              ; [Return from subroutine]
*
a0ad:DA0AD LDB=  W88B0      ; =0x88b0 =34992(-30544) [Load B with immediate]
a0b0:      AAB              ; [A + B -> B]
a0b1:      LDAB+ B          ; [Load AL from address in B]
a0b2:      RSR              ; [Return from subroutine]
*
* Function FA0B3
*
a0b3:FA0B3 JSR/  F8605      ; =0x8605 =34309(-31227) [Jump to subroutine direct]
a0b6:      BNL   DA0D0      ; =+24 [Branch on no link]
a0b8:      JSR   FA0D1      ; =+23 [Jump to subroutine relative]
a0ba:      BNL   FA0B3      ; =-9 [Branch on no link]
a0bc:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a0be:      LDX=  B88B1      ; =0x88b1 =34993(-30543) [Load X with immediate]
a0c1:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
a0c4:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
a0c6:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
a0c9:DA0C9 STBB+ X+         ; [Store BL indexed, direct, post-incremented]
a0cb:      DCAB             ; [Decrement AL]
a0cc:      BP    DA0C9      ; =-5 [Branch on plus]
a0ce:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
a0d0:DA0D0 RSR              ; [Return from subroutine]
*
* Function FA0D1
*
a0d1:FA0D1 JSR   FA0ED      ; =+26 [Jump to subroutine relative]
a0d3:      LDAB/ B9500      ; =0x9500 =38144(-27392) [Load AL direct]
a0d6:      BNZ   DA0DC      ; =+4 [Branch if not zero]
a0d8:      CLA              ; [Clear A]
a0d9:      STA/  W9548      ; =0x9548 =38216(-27320) [Store A direct]
a0dc:DA0DC JSR   FA105      ; =+39 [Jump to subroutine relative]
a0de:      LDA/  W9548      ; =0x9548 =38216(-27320) [Load A direct]
a0e1:      DCA              ; [Decrement A]
a0e2:      STA/  W9548      ; =0x9548 =38216(-27320) [Store A direct]
a0e5:      BLE   DA0EA      ; =+3 [Branch if less than or equal to zero]
a0e7:      RL               ; [Reset link]
a0e8:      JMP   DA0EB      ; =+1 [Jump relative]
a0ea:DA0EA SL               ; [Set link]
a0eb:DA0EB JMP   JA0FA      ; =+13 [Jump relative]
*
* Function FA0ED
*
a0ed:FA0ED STX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store X immediate]
a0f0:      XFR   Y,X        ; [Transfer Y to X]
a0f2:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a0f4:      XFR   Z,X        ; [Transfer Z to X]
a0f6:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a0f8:      JMP*  FA0ED+1    ; =-12 [Jump relative]
a0fa:JA0FA LDX+  S+         ; [Load X indexed, direct, post-incremented]
a0fc:      XFR   X,Z        ; [Transfer X to Z]
a0fe:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
a100:      XFR   X,Y        ; [Transfer X to Y]
a102:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
a104:      RSR              ; [Return from subroutine]
*
* Function FA105
*
a105:FA105 JSR/  FA1B2      ; =0xa1b2 =41394(-24142) ='!','2' [Jump to subroutine direct]
a108:      STB   WA10D      ; =+3 [Store B relative]
a10a:      JSR/  F8242      ; =0x8242 =33346(-32190) [Jump to subroutine direct]
a10d:WA10D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
a10f:      CLA              ; [Clear A]
a110:      STA/  W8801      ; =0x8801 =34817(-30719) [Store A direct]
a113:      RSR              ; [Return from subroutine]
*
* Function FA114
*
a114:FA114 JSR/  F8242      ; =0x8242 =33346(-32190) [Jump to subroutine direct]
a117:      DW    W81EA      ; =0x81ea =33258(-32278)
a119:      CLA              ; [Clear A]
a11a:      STA/  W88AF      ; =0x88af =34991(-30545) [Store A direct]
a11d:      RSR              ; [Return from subroutine]
*
* Function FA11E
*
a11e:FA11E STA/  WA1AC      ; =0xa1ac =41388(-24148) ='!',',' [Store A direct]
a121:      STB/  WA1AE      ; =0xa1ae =41390(-24146) ='!','.' [Store B direct]
a124:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
a126:      STA   WA171      ; =+73 [Store A relative]
a128:      STA/  W8218      ; =0x8218 =33304(-32232) [Store A direct]
a12b:      INA              ; [Increment A]
a12c:      INA              ; [Increment A]
a12d:      STX/  WA1B0      ; =0xa1b0 =41392(-24144) ='!','0' [Store X direct]
a130:      LDBB  BA198      ; =+102 [Load BL relative]
a132:      BZ    DA18F      ; =+91 [Branch if zero]
a134:      LDB$  WA171      ; =0xa171 =41329(-24207) [Load B indirect]
a137:      INR   B          ; [Increment B by 1]
a139:      STB$  WA171      ; =0xa171 =41329(-24207) [Store B indirect]
a13c:      AAB              ; [A + B -> B]
a13d:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
a13f:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
a141:      LDAB  BA153+1    ; =+17 [Load AL relative]
a143:      BZ    BA153      ; =+14 [Branch if zero]
a145:      LDA   WA171      ; =+42 [Load A relative]
a147:      MVF   (132)-A,/S8ACB ; =0x8acb =35531(-30005) =LF,'K' [Move fixed-length, indexed, direct]
a14d:      LDA=  S8ACB      ; =0x8acb =35531(-30005) =LF,'K' [Load A with immediate]
a150:      STA/  W8218      ; =0x8218 =33304(-32232) [Store A direct]
a153:BA153 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
a155:      BZ    DA173      ; =+28 [Branch if zero]
a157:BA157 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
a159:      BZ    DA16E      ; =+19 [Branch if zero]
a15b:WA15B LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
a15d:      DCAB             ; [Decrement AL]
a15e:      STAB  WA15B+1    ; =-4 [Store AL relative]
a160:      BGZ   DA16E      ; =+12 [Branch if greater than zero]
a162:      JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
a165:      DW    W92A5      ; =0x92a5 =37541(-27995)
*
a167:      JSR/  FA27F      ; =0xa27f =41599(-23937) [Jump to subroutine direct]
a16a:BA16A LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
a16c:      STAB  WA15B+1    ; =-18 [Store AL relative]
a16e:DA16E JSR/  FA22F      ; =0xa22f =41519(-24017) [Jump to subroutine direct]
a171:WA171 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
a173:DA173 LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
a176:      LDAB+ B          ; [Load AL from address in B]
a177:      BNZ   DA199      ; =+32 [Branch if not zero]
a179:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a17c:      DB    X'02'      ; =0x02 =2
a17d:      LDA=  W8A44      ; =0x8a44 =35396(-30140) [Load A with immediate]
a180:      STA/  W8218      ; =0x8218 =33304(-32232) [Store A direct]
a183:      LDA$  WA171      ; =0xa171 =41329(-24207) [Load A indirect]
a186:      DCA              ; [Decrement A]
a187:      STA$  WA171      ; =0xa171 =41329(-24207) [Store A indirect]
a18a:      LDAB/ W8208      ; =0x8208 =33288(-32248) [Load AL direct]
a18d:      BNZ   DA199      ; =+10 [Branch if not zero]
a18f:DA18F LDA/  WA1AC      ; =0xa1ac =41388(-24148) ='!',',' [Load A direct]
a192:      LDB/  WA1AE      ; =0xa1ae =41390(-24146) ='!','.' [Load B direct]
a195:      LDX   WA1B0      ; =+25 [Load X relative]
a197:      RSR              ; [Return from subroutine]
*
a198:BA198 DB    X'01'      ; =0x01 =1
*
a199:DA199 JMP/  J8675      ; =0x8675 =34421(-31115) [Jump direct]
*
* Function FA19C
*
a19c:FA19C STA   WA1AC      ; =+14 [Store A relative]
a19e:      STB   WA1AE      ; =+14 [Store B relative]
a1a0:      LDB=  W81EA      ; =0x81ea =33258(-32278) [Load B with immediate]
a1a3:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a1a6:      DB    X'04'      ; =0x04 =4
a1a7:      LDA   WA1AC      ; =+3 [Load A relative]
a1a9:      LDB   WA1AE      ; =+3 [Load B relative]
a1ab:      RSR              ; [Return from subroutine]
*
a1ac:WA1AC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
a1ae:WA1AE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
a1b0:WA1B0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function FA1B2
*
a1b2:FA1B2 STA   WA1AC      ; =-8 [Store A relative]
a1b4:      LDB=  W8190      ; =0x8190 =33168(-32368) [Load B with immediate]
a1b7:      LDAB/ B829D      ; =0x829d =33437(-32099) [Load AL direct]
a1ba:      BZ    DA1BF      ; =+3 [Branch if zero]
a1bc:      LDB=  W81AE      ; =0x81ae =33198(-32338) [Load B with immediate]
a1bf:DA1BF STB   WA1AE      ; =-19 [Store B relative]
a1c1:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a1c4:      DB    X'04'      ; =0x04 =4
a1c5:      LDA   WA1AC      ; =-27 [Load A relative]
a1c7:      LDB   WA1AE      ; =-27 [Load B relative]
a1c9:      RSR              ; [Return from subroutine]
*
* Function FA1CA
*
a1ca:FA1CA LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
a1cd:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
a1cf:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
a1d0:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
a1d1:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
a1d2:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: address]
a1d4:      XFR   B,B        ; [Transfer B to B]
a1d6:      BZ    DA200      ; =+40 [Branch if zero]
a1d8:      LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
a1db:      LDA=  X'848D'    ; =0x848d =33933(-31603) =EOT,CR [Load A with immediate]
a1de:      STA/  S8A46      ; =0x8a46 =35398(-30138) [Store A direct]
a1e1:      LDA=  W8A44      ; =0x8a44 =35396(-30140) [Load A with immediate]
a1e4:      STA/  W8218      ; =0x8218 =33304(-32232) [Store A direct]
a1e7:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
a1ea:      STA/  W8A44      ; =0x8a44 =35396(-30140) [Store A direct]
a1ed:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a1f0:      DB    X'02'      ; =0x02 =2
a1f1:      LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
a1f4:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a1f7:      DB    X'0B'      ; =0x0b =11
a1f8:      LDA/  W8274+1    ; =0x8275 =33397(-32139) [Load A direct]
a1fb:      SVC   X'05'      ; =5 [Service call TS - load transient module]
a1fd:      DB    X'0D'      ; =0x0d =13 [Selector: TODO]
a1fe:      DW    W8208      ; =0x8208 =33288(-32248) [address of TODO]
*
a200:DA200 LDB=  W8208      ; =0x8208 =33288(-32248) [Load B with immediate]
a203:      JSR/  F863D      ; =0x863d =34365(-31171) [Jump to subroutine direct]
a206:      DB    X'0A'      ; =0x0a =10
a207:      RSR              ; [Return from subroutine]
*
* Function FA208
*
a208:FA208 LDA+  X+         ; [Load A indexed, direct, post-incremented]
a20a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a20c:      XFR   Y,X        ; [Transfer Y to X]
a20e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a210:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
a212:      XAY              ; [Transfer A to Y]
a213:DA213 DCX              ; [Decrement X]
a214:      BM    DA229      ; =+19 [Branch on minus]
a216:      LDAB+ Y          ; [Load AL from address in Y]
a217:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
a219:      SABB             ; [AL - BL -> BL]
a21a:      BGZ   DA225      ; =+9 [Branch if greater than zero]
a21c:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
a21e:      SABB             ; [AL - BL -> BL]
a21f:      BM    DA225      ; =+4 [Branch on minus]
a221:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
a223:      ADDB  BL,AL      ; [BL + AL -> AL]
a225:DA225 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
a227:      JMP   DA213      ; =-22 [Jump relative]
a229:DA229 LDA+  S+         ; [Load A indexed, direct, post-incremented]
a22b:      XAY              ; [Transfer A to Y]
a22c:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
a22e:      RSR              ; [Return from subroutine]
*
* Function FA22F
*
a22f:FA22F JSR   FA244      ; =+19 [Jump to subroutine relative]
a231:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
a233:      JSR   FA258      ; =+35 [Jump to subroutine relative]
a235:      DB    X'02'      ; =0x02 =2
a236:      RSR              ; [Return from subroutine]
*
* Function FA237
*
a237:FA237 LDAB= X'AF'      ; =175(-81) ='/' [Load AL with immediate]
a239:      BP    DA23D      ; =+2 [Branch on plus]
a23b:      JSR   FA24B      ; =+14 [Jump to subroutine relative]
a23d:DA23D LDA+  X+         ; [Load A indexed, direct, post-incremented]
a23f:      JSR   FA258      ; =+23 [Jump to subroutine relative]
a241:      DB    X'01'      ; =0x01 =1
a242:      JMP   DA28D      ; =+73 [Jump relative]
*
* Function FA244
*
a244:FA244 LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
a246:      LDBB  WA272+1    ; =+43 [Load BL relative]
a248:      SABB             ; [AL - BL -> BL]
a249:      BZ    DA253      ; =+8 [Branch if zero]
*
* Function FA24B
*
a24b:FA24B STAB  BA256      ; =+9 [Store AL relative]
a24d:      LDA=  WA254      ; =0xa254 =41556(-23980) [Load A with immediate]
a250:      JSR   FA258      ; =+6 [Jump to subroutine relative]
a252:      DB    X'02'      ; =0x02 =2
*
a253:DA253 RSR              ; [Return from subroutine]
*
a254:WA254 DW    X'0001'    ; =0x0001 =1
a256:BA256 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function FA258
*
a258:FA258 STA   SA27B      ; =+33 [Store A relative]
a25a:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
a25c:      STAB  BA278      ; =+26 [Store AL relative]
a25e:WA25E LDB=  WA275      ; =0xa275 =41589(-23947) [Load B with immediate]
a261:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
a263:DA263 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
a265:      LDAB  WA275      ; =+14 [Load AL relative]
a267:      BM    DA263      ; =-6 [Branch on minus]
a269:      LDB   WA25E+1    ; =-12 [Load B relative]
a26b:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
a26d:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
a26e:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
a26f:      DB    X'12'      ; =0x12 =18 [TODO: arg3]
a270:      DW    WA272+1    ; =0xa273 =41587(-23949) [address to store block value]
a272:WA272 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
a274:      RSR              ; [Return from subroutine]
*
a275:WA275 DW    X'0081'    ; =0x0081 =129
a277:      DB    X'00'      ; =0x00 =0 =NUL
a278:BA278 DB    X'00'      ; =0x00 =0 =NUL
a279:WA279 DW    X'0084'    ; =0x0084 =132 =NUL,EOT
a27b:SA27B DB    0,4        ; =0x00,0x0004
*
*
* Function FA27F
*
a27f:FA27F LDA=  WA254      ; =0xa254 =41556(-23980) [Load A with immediate]
a282:      LDB+  A          ; [Load B from address in A]
a283:      STB   WA279      ; =-12 [Store B relative]
a285:      JSR   FA258      ; =-47 [Jump to subroutine relative]
a287:      DB    X'01'      ; =0x01 =1
a288:      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
a28b:      STA   WA279      ; =-20 [Store A relative]
a28d:DA28D LDAB  WA272+1    ; =-28 [Load AL relative]
a28f:BA28F LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
a291:      BZ    DA29C      ; =+9 [Branch if zero]
a293:      SABB             ; [AL - BL -> BL]
a294:      BNZ   DA29C      ; =+6 [Branch if not zero]
a296:WA296 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
a299:      BZ    DA29C      ; =+1 [Branch if zero]
a29b:      XAX              ; [Transfer A to X]
a29c:DA29C LDAB  BA256      ; =-72 [Load AL relative]
a29e:      RSR              ; [Return from subroutine]
*
* Function FA29F
*
a29f:FA29F STK   Y,2        ; [Push Y to the stack]
a2a1:      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
a2a5:      INR   X,2        ; [Increment X by 2]
a2a7:      DCA              ; [Decrement A]
a2a8:      BP    DA2AE      ; =+4 [Branch on plus]
a2aa:      INR   X,2        ; [Increment X by 2]
a2ac:      JMP   DA2C1      ; =+19 [Jump relative]
a2ae:DA2AE FILR  =' ',-Y    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
a2b2:      INA              ; [Increment A]
a2b3:      SAB              ; [A - B -> B]
a2b4:      BLE   DA2B9      ; =+3 [Branch if less than or equal to zero]
a2b6:      SAB              ; [A - B -> B]
a2b7:      XFR   B,A        ; [Transfer B to A]
a2b9:DA2B9 LDB+  X+         ; [Load B indexed, direct, post-incremented]
a2bb:      DCA              ; [Decrement A]
a2bc:      BM    DA2C1      ; =+3 [Branch on minus]
a2be:      MVFR  -B,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
a2c1:DA2C1 POP   Y,2        ; [Pop Y from the stack]
a2c3:      RSR              ; [Return from subroutine]
*
* Function FA2C4
*
a2c4:FA2C4 LDA+  X+         ; [Load A indexed, direct, post-incremented]
a2c6:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
a2c8:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
a2ca:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
a2cc:      BLE   DA2DC      ; =+14 [Branch if less than or equal to zero]
a2ce:      ADD   X,A        ; [X + A -> A]
a2d0:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
a2d3:DA2D3 LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
a2d5:      SUBB  BU,BL      ; [BU - BL -> BL]
a2d7:      BNZ   DA2DC      ; =+3 [Branch if not zero]
a2d9:      DCX              ; [Decrement X]
a2da:      BGZ   DA2D3      ; =-9 [Branch if greater than zero]
a2dc:DA2DC LDA+  S+         ; [Load A indexed, direct, post-incremented]
a2de:      STX+  A          ; [Store X indexed, direct]
a2e0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
a2e2:      RSR              ; [Return from subroutine]
*
a2e3:ENDPT
