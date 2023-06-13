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
8000:      DB    0,160      ; =0x00,0x00a0
80a0:W80A0 DB    X'00'      ; =0x00 =0 =NUL
80a1:S80A1 DB    0,3        ; =0x00,0x0003
80a4:W80A4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80a6:W80A6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80a8:W80A8 DW    W8F01      ; =0x8f01 =36609(-28927)
80aa:W80AA DW    W9F01      ; =0x9f01 =40705(-24831)
80ac:W80AC DW    ENTRY      ; =0xb8c9 =47305(-18231) ='8','I'
80ae:W80AE DW    X'0085'    ; =0x0085 =133
80b0:S80B0 DC    '     '    ; hex:a0a0a0a0a0
80b5:S80B5 DC    ' '        ; hex:a0 dec:160(-96)
80b6:S80B6 DC    '     '    ; hex:a0a0a0a0a0
80bb:S80BB DC    '  '       ; hex:a0a0 dec:41120(-96)
80bd:S80BD DC    ' '        ; hex:a0 dec:160(-96)
80be:S80BE DC    ' '        ; hex:a0 dec:160(-96)
80bf:S80BF DC    '     '    ; hex:a0a0a0a0a0
80c4:S80C4 DC    '  '       ; hex:a0a0 dec:41120(-96)
80c6:S80C6 DC    '        ' ; hex:a0a0a0a0a0a0a0a0
80ce:S80CE DC    '                                                            '
810a:      DC    '                                           '
8135:S8135 DC    '      '   ; hex:a0a0a0a0a0a0
813b:W813B DS    6          ; =0x0006 [Uninitialized memory]
8141:W8141 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8143:W8143 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8145:W8145 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8147:J8147 XFR=  W80A0,S    ; =0x80a0 =32928(-32608) [Transfer immediate to S]
814b:      XFR=  W8F00,Y    ; =0x8f00 =36608(-28928) [Transfer immediate to Y]
814f:      JSR/  F89D5      ; =0x89d5 =35285(-30251) [Jump to subroutine direct]
8152:      JSR/  F8412      ; =0x8412 =33810(-31726) [Jump to subroutine direct]
8155:      DW    W813B      ; =0x813b =33083(-32453)
8157:      JSR/  F8408      ; =0x8408 =33800(-31736) [Jump to subroutine direct]
815a:      CLA              ; [Clear A]
815b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
815d:      STAB/ B867C+1    ; =0x867d =34429(-31107) [Store AL direct]
8160:D8160 SLA              ; [Left shift A]
8161:      LDB+  S          ; [Load B from address in S]
8162:      AAB              ; [A + B -> B]
8163:      LDA=  S8182      ; =0x8182 =33154(-32382) [Load A with immediate]
8166:      AAB              ; [A + B -> B]
8167:      LDAB+ B          ; [Load AL from address in B]
8168:      BNZ   D816D      ; =+3 [Branch if not zero]
816a:      JMP/  J843D      ; =0x843d =33853(-31683) [Jump direct]
816d:D816D LDA+  S          ; [Load A from address in S]
816e:      INA              ; [Increment A]
816f:      STA+  S          ; [Store A to address in S]
8170:      CPF   (3)/W813B,-B ; =0x813b =33083(-32453), [Compare fixed-length, direct, indexed]
8176:      BNZ   D8160      ; =-24 [Branch if not zero]
8178:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
817a:      DCA              ; [Decrement A]
817b:      SLA              ; [Left shift A]
817c:      LDB=  W81A7      ; =0x81a7 =33191(-32345) [Load B with immediate]
817f:      AAB              ; [A + B -> B]
8180:      JMP+  *B         ; [Jump indexed, indirect]
*
8182:S8182 DC    'INPDINORGINCENTLOGGO ENDSTACOPQUITAP'
81a6:      DB    X'00'      ; =0x00 =0 =NUL
81a7:W81A7 DW    W81BF      ; =0x81bf =33215(-32321)
81a9:      DW    W81E9      ; =0x81e9 =33257(-32279)
81ab:      DW    W81D8      ; =0x81d8 =33240(-32296)
81ad:      DW    W81EE      ; =0x81ee =33262(-32274)
81af:      DW    W81FE      ; =0x81fe =33278(-32258)
81b1:      DW    W8233      ; =0x8233 =33331(-32205)
81b3:      DW    W8256      ; =0x8256 =33366(-32170)
81b5:      DW    W8259      ; =0x8259 =33369(-32167)
81b7:      DW    W828C      ; =0x828c =33420(-32116)
81b9:      DW    W82C2      ; =0x82c2 =33474(-32062)
81bb:      DW    W8259      ; =0x8259 =33369(-32167)
81bd:      DW    W834B      ; =0x834b =33611(-31925)
*
81bf:W81BF JSR/  F8373      ; =0x8373 =33651(-31885) [Jump to subroutine direct]
81c2:      LDAB/ B8A39      ; =0x8a39 =35385(-30151) [Load AL direct]
81c5:      LDBB= X'20'      ; =32 [Load BL with immediate]
81c7:      NABB             ; [AL & BL -> BL]
81c8:      BZ    D81D0      ; =+6 [Branch if zero]
81ca:      JSR/  F899E      ; =0x899e =35230(-30306) [Jump to subroutine direct]
81cd:      DB    X'0A'      ; =0x0a =10
81ce:      DW    W8A37      ; =0x8a37 =35383(-30153)
*
81d0:D81D0 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
81d2:      STAB/ B8A38      ; =0x8a38 =35384(-30152) [Store AL direct]
81d5:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
81d8:W81D8 JSR/  F8373      ; =0x8373 =33651(-31885) [Jump to subroutine direct]
81db:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
81dd:      STA/  W8141      ; =0x8141 =33089(-32447) [Store A direct]
81e0:      STA/  WBEF4+1    ; =0xbef5 =48885(-16651) ='>','u' [Store A direct]
81e3:      STA/  W80A4      ; =0x80a4 =32932(-32604) [Store A direct]
81e6:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
81e9:W81E9 LDAB= X'01'      ; =1 [Load AL with immediate]
81eb:      STAB/ B867C+1    ; =0x867d =34429(-31107) [Store AL direct]
81ee:W81EE JSR/  F8412      ; =0x8412 =33810(-31726) [Jump to subroutine direct]
81f1:      DW    W813B      ; =0x813b =33083(-32453)
81f3:      JSR/  D860D      ; =0x860d =34317(-31219) [Jump to subroutine direct]
81f6:      DW    W813B      ; =0x813b =33083(-32453)
81f8:      JSR/  F8640      ; =0x8640 =34368(-31168) [Jump to subroutine direct]
81fb:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
81fe:W81FE LDA+  Z          ; [Load A from address in Z]
81ff:      LDB=  X'D8A7'    ; =0xd8a7 =55463(-10073) ='X',' [Load B with immediate]
8202:      SAB              ; [A - B -> B]
8203:      BZ    D8223      ; =+30 [Branch if zero]
8205:      LDAB+ Z          ; [Load AL from address in Z]
8206:      JSR/  F83D0      ; =0x83d0 =33744(-31792) [Jump to subroutine direct]
8209:      XFRB  BL,BL      ; [Transfer BL to BL]
820b:      BP    D8223      ; =+22 [Branch on plus]
820d:      JSR/  F8412      ; =0x8412 =33810(-31726) [Jump to subroutine direct]
8210:      DW    W813B      ; =0x813b =33083(-32453)
8212:      JSR/  F8829      ; =0x8829 =34857(-30679) [Jump to subroutine direct]
8215:      DW    W813B      ; =0x813b =33083(-32453)
8217:W8217 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8219:      LDB   W8217      ; =-4 [Load B relative]
821b:      BNZ   D8220      ; =+3 [Branch if not zero]
821d:      JMP/  J843D      ; =0x843d =33853(-31683) [Jump direct]
8220:D8220 LDA+  B          ; [Load A from address in B]
8221:      JMP   D8228      ; =+5 [Jump relative]
8223:D8223 JSR/  F8373      ; =0x8373 =33651(-31885) [Jump to subroutine direct]
8226:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8228:D8228 STA/  W8145      ; =0x8145 =33093(-32443) [Store A direct]
822b:      LDAB= X'01'      ; =1 [Load AL with immediate]
822d:      STAB/ S80A1      ; =0x80a1 =32929(-32607) [Store AL direct]
8230:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8233:W8233 LDA+  Z          ; [Load A from address in Z]
8234:      LDB=  X'C9CE'    ; =0xc9ce =51662(-13874) ='I','N' [Load B with immediate]
8237:      SAB              ; [A - B -> B]
8238:      BNZ   D8240      ; =+6 [Branch if not zero]
823a:      JSR/  D8500      ; =0x8500 =34048(-31488) [Jump to subroutine direct]
823d:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8240:D8240 CLA              ; [Clear A]
8241:      STAB/ B84D9+1    ; =0x84da =34010(-31526) =EOT,'Z' [Store AL direct]
8244:      LDA+  Z          ; [Load A from address in Z]
8245:      LDB=  X'D5CE'    ; =0xd5ce =54734(-10802) ='U','N' [Load B with immediate]
8248:      SAB              ; [A - B -> B]
8249:      BZ    D8250      ; =+5 [Branch if zero]
824b:      LDBB= X'01'      ; =1 [Load BL with immediate]
824d:      STBB/ B84D9+1    ; =0x84da =34010(-31526) =EOT,'Z' [Store BL direct]
8250:D8250 JSR/  F844B      ; =0x844b =33867(-31669) [Jump to subroutine direct]
8253:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8256:W8256 JMP/  J85CF      ; =0x85cf =34255(-31281) [Jump direct]
8259:W8259 LDAB/ W80A0      ; =0x80a0 =32928(-32608) [Load AL direct]
825c:      BZ    D8269      ; =+11 [Branch if zero]
825e:      JSR/  F88B4      ; =0x88b4 =34996(-30540) [Jump to subroutine direct]
8261:      XAB              ; [Transfer A to B]
8262:      BNZ   W8259      ; =-11 [Branch if not zero]
8264:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8267:      DW    W8143      ; =0x8143 =33091(-32445)
*
8269:D8269 LDAB/ B8A57      ; =0x8a57 =35415(-30121) [Load AL direct]
826c:      LDBB= X'20'      ; =32 [Load BL with immediate]
826e:      NABB             ; [AL & BL -> BL]
826f:      BZ    D8284      ; =+19 [Branch if zero]
8271:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8274:      DW    W8B40      ; =0x8b40 =35648(-29888)
*
8276:      JSR/  F899E      ; =0x899e =35230(-30306) [Jump to subroutine direct]
8279:      DB    X'0B'      ; =0x0b =11
827a:      DW    W8A55      ; =0x8a55 =35413(-30123)
827c:      LDA/  W8EEF      ; =0x8eef =36591(-28945) [Load A direct]
827f:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8281:      DB    X'0D'      ; =0x0d =13 [Selector: set file date from A register]
8282:      DW    W8A55      ; =0x8a55 =35413(-30123) [address of RCB]
*
8284:D8284 JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
8287:      DW    W8B35      ; =0x8b35 =35637(-29899)
8289:      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
828b:N828B DB    X'00'      ; =0x00 =0 =NUL [completion code]
*
828c:W828C LDA/  W8141      ; =0x8141 =33089(-32447) [Load A direct]
828f:      LDB=  S82B4      ; =0x82b4 =33460(-32076) [Load B with immediate]
8292:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
8295:      LDA/  W8145      ; =0x8145 =33093(-32443) [Load A direct]
8298:      LDB/  W8141      ; =0x8141 =33089(-32447) [Load B direct]
829b:      ADD   B,A        ; [B + A -> A]
829d:      LDB=  S82BD      ; =0x82bd =33469(-32067) [Load B with immediate]
82a0:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
82a3:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
82a6:      DW    W82AE      ; =0x82ae =33454(-32082)
82a8:      JSR/  F857A      ; =0x857a =34170(-31366) [Jump to subroutine direct]
82ab:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
*
82ae:W82AE DW    X'0012'    ; =0x0012 =18
82b0:      DC    'ORG='     ; hex:cfd2c7bd
82b4:S82B4 DC    'XXXX ENT=' ; hex:d8d8d8d8a0c5ced4bd
82bd:S82BD DC    'XXXX'     ; hex:d8d8d8d8
82c1:      DB    X'8D'      ; =0x8d =141(-115) =CR
*
82c2:W82C2 LDAB+ Z          ; [Load AL from address in Z]
82c3:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
82c5:      SABB             ; [AL - BL -> BL]
82c6:      BNZ   D82D0      ; =+8 [Branch if not zero]
82c8:D82C8 JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
82cb:      JSR/  F8353      ; =0x8353 =33619(-31917) [Jump to subroutine direct]
82ce:      JMP   D82C8      ; =-8 [Jump relative]
82d0:D82D0 LDA+  Z          ; [Load A from address in Z]
82d1:      LDB=  X'D4CF'    ; =0xd4cf =54479(-11057) ='T','O' [Load B with immediate]
82d4:      SAB              ; [A - B -> B]
82d5:      BNZ   D82FF      ; =+40 [Branch if not zero]
82d7:      LDAB+ Z,2        ; [Load AL indexed, displaced, direct]
82da:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
82dc:      SABB             ; [AL - BL -> BL]
82dd:      BNZ   D82FF      ; =+32 [Branch if not zero]
82df:      JSR/  F83FD      ; =0x83fd =33789(-31747) [Jump to subroutine direct]
82e2:      JSR/  F8408      ; =0x8408 =33800(-31736) [Jump to subroutine direct]
82e5:      JSR/  F8412      ; =0x8412 =33810(-31726) [Jump to subroutine direct]
82e8:      DW    W813B      ; =0x813b =33083(-32453)
*
82ea:D82EA JSR/  D860D      ; =0x860d =34317(-31219) [Jump to subroutine direct]
82ed:      DW    S8135      ; =0x8135 =33077(-32459)
82ef:      CPF   (6)/W8E70,/W813B ; =0x8e70 =36464(-29072),=0x813b =33083(-32453) [Compare fixed-length, direct, direct]
82f6:      BNZ   D82FB      ; =+3 [Branch if not zero]
82f8:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
82fb:D82FB JSR   F8353      ; =+86 [Jump to subroutine relative]
82fd:      JMP   D82EA      ; =-21 [Jump relative]
82ff:D82FF LDA=  W9F01      ; =0x9f01 =40705(-24831) [Load A with immediate]
8302:      STA/  W80AA      ; =0x80aa =32938(-32598) [Store A direct]
8305:D8305 JSR/  F8412      ; =0x8412 =33810(-31726) [Jump to subroutine direct]
8308:      DW    W813B      ; =0x813b =33083(-32453)
830a:      JSR/  F8846      ; =0x8846 =34886(-30650) [Jump to subroutine direct]
830d:      DW    W813B      ; =0x813b =33083(-32453)
830f:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8311:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8313:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8315:      SABB             ; [AL - BL -> BL]
8316:      BNZ   D8326      ; =+14 [Branch if not zero]
8318:D8318 JSR/  F8408      ; =0x8408 =33800(-31736) [Jump to subroutine direct]
831b:      LDAB+ Z          ; [Load AL from address in Z]
831c:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
831e:      SABB             ; [AL - BL -> BL]
831f:      BNZ   D8305      ; =-28 [Branch if not zero]
8321:      JSR/  F89D5      ; =0x89d5 =35285(-30251) [Jump to subroutine direct]
8324:      JMP   D8318      ; =-14 [Jump relative]
8326:D8326 JSR/  D860D      ; =0x860d =34317(-31219) [Jump to subroutine direct]
8329:      DW    S8135      ; =0x8135 =33077(-32459)
832b:      JSR/  F8829      ; =0x8829 =34857(-30679) [Jump to subroutine direct]
832e:      DW    W8E70      ; =0x8e70 =36464(-29072)
8330:W8330 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8332:      LDA   W8330      ; =-4 [Load A relative]
8334:      BZ    D8326      ; =-16 [Branch if zero]
8336:      JSR/  F833D      ; =0x833d =33597(-31939) [Jump to subroutine direct]
8339:      JSR   F8353      ; =+24 [Jump to subroutine relative]
833b:      JMP   D8326      ; =-23 [Jump relative]
*
* Function F833D
*
833d:F833D LDBB/ B8E68      ; =0x8e68 =36456(-29080) [Load BL direct]
8340:      DCRB  BL,13      ; [Decrement BL by 13]
8342:      BNZ   D834A      ; =+6 [Branch if not zero]
8344:      LDB/  W8E76      ; =0x8e76 =36470(-29066) [Load B direct]
8347:      STB+  A,9        ; [Store B indexed, displaced, direct]
834a:D834A RSR              ; [Return from subroutine]
*
834b:W834B LDAB= X'01'      ; =1 [Load AL with immediate]
834d:      STAB/ B85AE+1    ; =0x85af =34223(-31313) [Store AL direct]
8350:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
*
* Function F8353
*
8353:F8353 JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8356:      DW    W8E67      ; =0x8e67 =36455(-29081)
8358:      LDA/  W8E67      ; =0x8e67 =36455(-29081) [Load A direct]
835b:      BZ    D8362      ; =+5 [Branch if zero]
835d:      JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
8360:      JMP   F8353      ; =-15 [Jump relative]
8362:D8362 C     /W8EED(2),/W8EEF(2) ; =0x8eed =36589(-28947),=0x8eef =36591(-28945) [Compare bignums, direct, direct]
8369:      BP    D8372      ; =+7 [Branch on plus]
836b:      MVF   (2)/W8EED,/W8EEF ; =0x8eed =36589(-28947),=0x8eef =36591(-28945) [Move fixed-length, direct, direct]
8372:D8372 RSR              ; [Return from subroutine]
*
* Function F8373
*
8373:F8373 CLA              ; [Clear A]
8374:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8376:      LDAB+ Z          ; [Load AL from address in Z]
8377:      JSR   F83D0      ; =+87 [Jump to subroutine relative]
8379:      XFRB  BL,BL      ; [Transfer BL to BL]
837b:      BM    D8380      ; =+3 [Branch on minus]
837d:      JSR   F83B5      ; =+54 [Jump to subroutine relative]
837f:      RSR              ; [Return from subroutine]
*
8380:D8380 LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8382:      LDB=  X'D8A7'    ; =0xd8a7 =55463(-10073) ='X',' [Load B with immediate]
8385:      SAB              ; [A - B -> B]
8386:      BNZ   D838E      ; =+6 [Branch if not zero]
8388:      JSR   F8391      ; =+7 [Jump to subroutine relative]
838a:      JSR   F83F1      ; =+101 [Jump to subroutine relative]
838c:      DB    X'A7'      ; =0xa7 =167(-89) ='
838d:      RSR              ; [Return from subroutine]
*
838e:D838E JMP/  J843D      ; =0x843d =33853(-31683) [Jump direct]
*
* Function F8391
*
8391:F8391 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8393:      JSR   F83D0      ; =+59 [Jump to subroutine relative]
8395:      XFRB  BL,BU      ; [Transfer BL to BU]
8397:      BM    D83A3      ; =+10 [Branch on minus]
8399:D8399 LDA+  Y          ; [Load A from address in Y]
839a:      SLA              ; [Left shift A]
839b:      SLA              ; [Left shift A]
839c:      SLA              ; [Left shift A]
839d:      SLA              ; [Left shift A]
839e:      ORIB  BL,AL      ; [BL | AL -> AL]
83a0:      STA+  Y          ; [Store A to address in Y]
83a1:      JMP   F8391      ; =-18 [Jump relative]
83a3:D83A3 LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
83a5:      SABB             ; [AL - BL -> BL]
83a6:      BGZ   D83B2      ; =+10 [Branch if greater than zero]
83a8:      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
83aa:      SABB             ; [AL - BL -> BL]
83ab:      BM    D83B2      ; =+5 [Branch on minus]
83ad:      LDAB= X'0A'      ; =10 [Load AL with immediate]
83af:      AABB             ; [AL + BL -> BL]
83b0:      JMP   D8399      ; =-25 [Jump relative]
83b2:D83B2 DCR   Z          ; [Decrement Z by 1]
83b4:      RSR              ; [Return from subroutine]
*
* Function F83B5
*
83b5:F83B5 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
83b7:      JSR   F83D0      ; =+23 [Jump to subroutine relative]
83b9:      XFRB  BL,BU      ; [Transfer BL to BU]
83bb:      BM    D83CD      ; =+16 [Branch on minus]
83bd:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
83bf:      LDA+  Y          ; [Load A from address in Y]
83c0:      SLA              ; [Left shift A]
83c1:      SLA              ; [Left shift A]
83c2:      LDB+  Y          ; [Load B from address in Y]
83c3:      AAB              ; [A + B -> B]
83c4:      SLR   B          ; [Left shift B by 1]
83c6:      CLA              ; [Clear A]
83c7:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
83c9:      AAB              ; [A + B -> B]
83ca:      STB+  Y          ; [Store B to address in Y]
83cb:      JMP   F83B5      ; =-24 [Jump relative]
83cd:D83CD DCR   Z          ; [Decrement Z by 1]
83cf:      RSR              ; [Return from subroutine]
*
* Function F83D0
*
83d0:F83D0 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
83d2:      SABB             ; [AL - BL -> BL]
83d3:      BLE   D83D8      ; =+3 [Branch if less than or equal to zero]
83d5:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
83d7:      RSR              ; [Return from subroutine]
*
83d8:D83D8 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
83da:      SABB             ; [AL - BL -> BL]
83db:      RSR              ; [Return from subroutine]
*
* Function F83DC
*
83dc:F83DC LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
83de:      SABB             ; [AL - BL -> BL]
83df:      BLE   D83E4      ; =+3 [Branch if less than or equal to zero]
83e1:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
83e3:      RSR              ; [Return from subroutine]
*
83e4:D83E4 LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
83e6:      SABB             ; [AL - BL -> BL]
83e7:      RSR              ; [Return from subroutine]
*
* Function F83E8
*
83e8:F83E8 JSR   F83DC      ; =-14 [Jump to subroutine relative]
83ea:      XFRB  BL,BU      ; [Transfer BL to BU]
83ec:      BP    D83F0      ; =+2 [Branch on plus]
83ee:      JSR   F83D0      ; =-32 [Jump to subroutine relative]
83f0:D83F0 RSR              ; [Return from subroutine]
*
* Function F83F1
*
83f1:F83F1 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
83f3:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
83f5:      SABB             ; [AL - BL -> BL]
83f6:      BZ    D83FC      ; =+4 [Branch if zero]
83f8:      DCR   Z          ; [Decrement Z by 1]
83fa:      JMP   J843D      ; =+65 [Jump relative]
83fc:D83FC RSR              ; [Return from subroutine]
*
* Function F83FD
*
83fd:F83FD LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
83ff:      JSR   F83E8      ; =-25 [Jump to subroutine relative]
8401:      XFRB  BL,BU      ; [Transfer BL to BU]
8403:      BP    F83FD      ; =-8 [Branch on plus]
8405:      DCR   Z          ; [Decrement Z by 1]
8407:      RSR              ; [Return from subroutine]
*
* Function F8408
*
8408:F8408 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
840a:D840A LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
840c:      SABB             ; [AL - BL -> BL]
840d:      BZ    D840A      ; =-5 [Branch if zero]
840f:      DCR   Z          ; [Decrement Z by 1]
8411:      RSR              ; [Return from subroutine]
*
* Function F8412
*
8412:F8412 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8414:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8416:      XFR   Y,X        ; [Transfer Y to X]
8418:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
841a:      XAY              ; [Transfer A to Y]
841b:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
841e:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8420:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8422:      STB+  A          ; [Store B to address in A]
8423:      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
8426:D8426 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8428:      JSR   F83E8      ; =-66 [Jump to subroutine relative]
842a:      XFRB  BL,BL      ; [Transfer BL to BL]
842c:      BM    D8435      ; =+7 [Branch on minus]
842e:      DCX              ; [Decrement X]
842f:      BM    D8426      ; =-11 [Branch on minus]
8431:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8433:      JMP   D8426      ; =-15 [Jump relative]
8435:D8435 DCR   Z          ; [Decrement Z by 1]
8437:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8439:      XAY              ; [Transfer A to Y]
843a:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
843c:      RSR              ; [Return from subroutine]
*
843d:J843D JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
8440:      DW    W8A73      ; =0x8a73 =35443(-30093)
8442:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
8448:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
*
* Function F844B
*
844b:F844B JSR/  F891B      ; =0x891b =35099(-30437) [Jump to subroutine direct]
844e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8450:      LDX=  W9EF6      ; =0x9ef6 =40694(-24842) [Load X with immediate]
8453:D8453 LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
8456:      ADD   A,X        ; [A + X -> X]
8458:      LDA/  W80AA      ; =0x80aa =32938(-32598) [Load A direct]
845b:      SUB   X,A        ; [X - A -> A]
845d:      BNL   D8465      ; =+6 [Branch on no link]
845f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8461:      JSR/  F857A      ; =0x857a =34170(-31366) [Jump to subroutine direct]
8464:      RSR              ; [Return from subroutine]
*
8465:D8465 XFR   X,A        ; [Transfer X to A]
8467:      JSR   F846B      ; =+2 [Jump to subroutine relative]
8469:      JMP   D8453      ; =-24 [Jump relative]
*
* Function F846B
*
846b:F846B STX-  S-         ; [Store X indexed, pre-decremented, direct]
846d:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
846f:      LDB=  W80AE      ; =0x80ae =32942(-32594) [Load B with immediate]
8472:      LDX=  X'0013'    ; =0x0013 =19 [Load X with immediate]
8475:      STX+  B+         ; [Store X indexed, direct, post-incremented]
8477:      LDX=  X'001C'    ; =0x001c =28 [Load X with immediate]
847a:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
847c:D847C STAB+ B+         ; [Store AL indexed, direct, post-incremented]
847e:      DCX              ; [Decrement X]
847f:      BGZ   D847C      ; =-5 [Branch if greater than zero]
8481:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8483:      LDA+  X          ; [Load A from address in X]
8484:      LDB=  S80BF      ; =0x80bf =32959(-32577) [Load B with immediate]
8487:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
848a:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
848d:      LDBB= X'02'      ; =2 [Load BL with immediate]
848f:      NABB             ; [AL & BL -> BL]
8490:      BNZ   D8497      ; =+5 [Branch if not zero]
8492:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8494:      STBB/ S80BD      ; =0x80bd =32957(-32579) [Store BL direct]
8497:D8497 LDBB= X'01'      ; =1 [Load BL with immediate]
8499:      NABB             ; [AL & BL -> BL]
849a:      BNZ   D84A9      ; =+13 [Branch if not zero]
849c:      LDBB= X'D5'      ; =213(-43) ='U' [Load BL with immediate]
849e:      STBB/ S80BD      ; =0x80bd =32957(-32579) [Store BL direct]
84a1:      LDA+  *X         ; [Load A indexed, indirect]
84a3:      LDB=  S80BF      ; =0x80bf =32959(-32577) [Load B with immediate]
84a6:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
84a9:D84A9 LDBB= X'04'      ; =4 [Load BL with immediate]
84ab:      NABB             ; [AL & BL -> BL]
84ac:      BNZ   D84B3      ; =+5 [Branch if not zero]
84ae:      LDB=  S80B5      ; =0x80b5 =32949(-32587) [Load B with immediate]
84b1:      JMP   D84CB      ; =+24 [Jump relative]
84b3:D84B3 LDA+  X,9        ; [Load A indexed, displaced, direct]
84b6:      BZ    D84C8      ; =+16 [Branch if zero]
84b8:      LDB=  S80C4      ; =0x80c4 =32964(-32572) [Load B with immediate]
84bb:      STB   W84C0      ; =+3 [Store B relative]
84bd:      SVC   X'05'      ; =5 [Service call TS - load transient module]
84bf:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
84c0:W84C0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of string date]
84c2:      LDA=  X'001C'    ; =0x001c =28 [Load A with immediate]
84c5:      STA/  W80AE      ; =0x80ae =32942(-32594) [Store A direct]
84c8:D84C8 LDB=  S80B0      ; =0x80b0 =32944(-32592) [Load B with immediate]
84cb:D84CB LDA+  X,3        ; [Load A indexed, displaced, direct]
84ce:      STA+  B+         ; [Store A indexed, direct, post-incremented]
84d0:      LDA+  X,5        ; [Load A indexed, displaced, direct]
84d3:      STA+  B+         ; [Store A indexed, direct, post-incremented]
84d5:      LDA+  X,7        ; [Load A indexed, displaced, direct]
84d8:      STA+  B          ; [Store A to address in B]
84d9:B84D9 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
84db:      BNZ   D84E5      ; =+8 [Branch if not zero]
84dd:      LDAB/ S80BD      ; =0x80bd =32957(-32579) [Load AL direct]
84e0:      LDBB= X'D5'      ; =213(-43) ='U' [Load BL with immediate]
84e2:      SABB             ; [AL - BL -> BL]
84e3:      BNZ   D84EC      ; =+7 [Branch if not zero]
84e5:D84E5 JSR   F84EF      ; =+8 [Jump to subroutine relative]
84e7:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
84ea:      DW    W80AE      ; =0x80ae =32942(-32594)
*
84ec:D84EC LDX+  S+         ; [Load X indexed, direct, post-incremented]
84ee:      RSR              ; [Return from subroutine]
*
* Function F84EF
*
84ef:F84EF JSR/  FBE6F      ; =0xbe6f =48751(-16785) [Jump to subroutine direct]
84f2:W84F2 DW    W80AE      ; =0x80ae =32942(-32594)
84f4:      LDB   W84F2      ; =-4 [Load B relative]
84f6:      LDA+  B          ; [Load A from address in B]
84f7:      INA              ; [Increment A]
84f8:      STA+  B+         ; [Store A indexed, direct, post-incremented]
84fa:      AAB              ; [A + B -> B]
84fb:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
84fd:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
84ff:      RSR              ; [Return from subroutine]
*
8500:D8500 JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
8503:      LDAB/ W8E67      ; =0x8e67 =36455(-29081) [Load AL direct]
8506:      LDBB= X'02'      ; =2 [Load BL with immediate]
8508:      SABB             ; [AL - BL -> BL]
8509:      BNZ   D8500      ; =-11 [Branch if not zero]
850b:      LDA=  X'001F'    ; =0x001f =31 [Load A with immediate]
850e:      FILR  =' ',/S80B0 ; =0x80b0 =32944(-32592) [Fill with byte (len-1 in AL), literal=0xa0(160,-96), direct]
8513:      STA/  W80AE      ; =0x80ae =32942(-32594) [Store A direct]
8516:      LDAB/ B8E6F      ; =0x8e6f =36463(-29073) [Load AL direct]
8519:      LDBB= X'01'      ; =1 [Load BL with immediate]
851b:      NABB             ; [AL & BL -> BL]
851c:      BZ    D8559      ; =+59 [Branch if zero]
851e:      LDBB= X'04'      ; =4 [Load BL with immediate]
8520:      NABB             ; [AL & BL -> BL]
8521:      BZ    D8546      ; =+35 [Branch if zero]
8523:      MVF   (6)/W8E70,/S80B0 ; =0x8e70 =36464(-29072),=0x80b0 =32944(-32592) [Move fixed-length, direct, direct]
852a:      MVF   (6)='HEADER',/S80BB ; =0x80bb =32955(-32581) [Move fixed-length, literal=0xc8c5c1c4c5d2(220751685010898,-46), direct]
8535:      LDAB/ B8E68      ; =0x8e68 =36456(-29080) [Load AL direct]
8538:      DCRB  AL,13      ; [Decrement AL by 13]
853a:      BNZ   D856D      ; =+49 [Branch if not zero]
853c:      LDA/  W8E76      ; =0x8e76 =36470(-29066) [Load A direct]
853f:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8541:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8542:      DW    S80C6      ; =0x80c6 =32966(-32570) [address of string date]
8544:      JMP   D856D      ; =+39 [Jump relative]
8546:D8546 MVF   (6)/W8E70,/S80B6 ; =0x8e70 =36464(-29072),=0x80b6 =32950(-32586) [Move fixed-length, direct, direct]
854d:      MVF   (5)='ENTRY',/S80BE ; =0x80be =32958(-32578) [Move fixed-length, literal=0xc5ced4d2d9(849578611417,-39), direct]
8557:      JMP   D856D      ; =+20 [Jump relative]
8559:D8559 MVF   (6)/W8E70,/S80B6 ; =0x8e70 =36464(-29072),=0x80b6 =32950(-32586) [Move fixed-length, direct, direct]
8560:      MVF   (8)='EXTERNAL',/S80BE ; =0x80be =32958(-32578) [Move fixed-length, literal=0xc5d8d4c5d2cec1cc(14256378566551716300,-52), direct]
856d:D856D LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
856f:      STAB/ S80CE      ; =0x80ce =32974(-32562) [Store AL direct]
8572:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
8575:      DW    W80AE      ; =0x80ae =32942(-32594)
8577:      JMP/  D8500      ; =0x8500 =34048(-31488) [Jump direct]
*
* Function F857A
*
857a:F857A JSR/  F86F8      ; =0x86f8 =34552(-30984) [Jump to subroutine direct]
857d:W857D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
857f:      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
8582:      STA/  S8B0B      ; =0x8b0b =35595(-29941) [Store A direct]
8585:      STA/  S8B0D      ; =0x8b0d =35597(-29939) [Store A direct]
8588:      STA/  S8B0F      ; =0x8b0f =35599(-29937) [Store A direct]
858b:      LDA   W857D      ; =-16 [Load A relative]
858d:      C     =0,/W857D(2) ; =0x857d =34173(-31363) [Compare bignums, literal=0x00, direct]
8593:      BZ    D859B      ; =+6 [Branch if zero]
8595:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
859b:D859B SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
859d:      DW    S8B10      ; =0x8b10 =35600(-29936) [address of end of string]
*
859f:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
85a2:      DW    W8B08      ; =0x8b08 =35592(-29944)
85a4:      RSR              ; [Return from subroutine]
*
* Function F85A5
*
85a5:F85A5 LDAB/ W80A0      ; =0x80a0 =32928(-32608) [Load AL direct]
85a8:      BNZ   D85CE      ; =+36 [Branch if not zero]
85aa:      INAB             ; [Increment AL]
85ab:      STAB/ W80A0      ; =0x80a0 =32928(-32608) [Store AL direct]
85ae:B85AE LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
85b0:      BZ    D85CE      ; =+28 [Branch if zero]
85b2:      JSR   F85C9      ; =+21 [Jump to subroutine relative]
85b4:      LDB   W85CC      ; =+22 [Load B relative]
85b6:      LDA+  B          ; [Load A from address in B]
85b7:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
85b9:      CLA              ; [Clear A]
85ba:      STA+  B          ; [Store A to address in B]
85bb:      JSR   F85C9      ; =+12 [Jump to subroutine relative]
85bd:      LDB   W85CC      ; =+13 [Load B relative]
85bf:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
85c1:      STA+  B          ; [Store A to address in B]
85c2:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
85c5:      STA/  S8A6D      ; =0x8a6d =35437(-30099) [Store A direct]
85c8:      RSR              ; [Return from subroutine]
*
* Function F85C9
*
85c9:F85C9 JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
85cc:W85CC DW    WBED6      ; =0xbed6 =48854(-16682) ='>','V'
*
85ce:D85CE RSR              ; [Return from subroutine]
*
85cf:J85CF JSR/  F86F8      ; =0x86f8 =34552(-30984) [Jump to subroutine direct]
85d2:W85D2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
85d4:      LDA   W85D2      ; =-4 [Load A relative]
85d6:      BNZ   D85E0      ; =+8 [Branch if not zero]
85d8:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
85db:      DW    W8AEA      ; =0x8aea =35562(-29974) =LF,'j'
85dd:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
85e0:D85E0 JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
85e3:      LDAB/ W8E67      ; =0x8e67 =36455(-29081) [Load AL direct]
85e6:      LDBB= X'02'      ; =2 [Load BL with immediate]
85e8:      SABB             ; [AL - BL -> BL]
85e9:      BNZ   D85E0      ; =-11 [Branch if not zero]
85eb:      LDAB/ B8E6F      ; =0x8e6f =36463(-29073) [Load AL direct]
85ee:      LDBB= X'04'      ; =4 [Load BL with immediate]
85f0:      NABB             ; [AL & BL -> BL]
85f1:      BZ    D85E0      ; =-19 [Branch if zero]
85f3:      JSR/  F8829      ; =0x8829 =34857(-30679) [Jump to subroutine direct]
85f6:      DW    W8E70      ; =0x8e70 =36464(-29072)
85f8:W85F8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
85fa:      LDA   W85F8      ; =-4 [Load A relative]
85fc:      BZ    D85E0      ; =-30 [Branch if zero]
85fe:      JSR/  F833D      ; =0x833d =33597(-31939) [Jump to subroutine direct]
8601:      LDBB+ A,2        ; [Load BL indexed, displaced, direct]
8604:      LDAB= X'01'      ; =1 [Load AL with immediate]
8606:      NABB             ; [AL & BL -> BL]
8607:      BNZ   D85E0      ; =-41 [Branch if not zero]
8609:      JSR   F8640      ; =+53 [Jump to subroutine relative]
860b:      JMP   J85CF      ; =-62 [Jump relative]
860d:D860D JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
8610:      LDAB/ W8E67      ; =0x8e67 =36455(-29081) [Load AL direct]
8613:      LDBB= X'02'      ; =2 [Load BL with immediate]
8615:      SABB             ; [AL - BL -> BL]
8616:      BNZ   D860D      ; =-11 [Branch if not zero]
8618:      LDAB/ B8E6F      ; =0x8e6f =36463(-29073) [Load AL direct]
861b:      LDBB= X'05'      ; =5 [Load BL with immediate]
861d:      OREB  AL,BL      ; [AL ^ BL -> BL]
861f:      BNZ   D860D      ; =-20 [Branch if not zero]
8621:      LDA+  X          ; [Load A from address in X]
8622:      STA   W862A+1    ; =+7 [Store A relative]
8624:      LDAB+ A          ; [Load AL from address in A]
8625:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8627:      SABB             ; [AL - BL -> BL]
8628:      BZ    D8637      ; =+13 [Branch if zero]
862a:W862A LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
862d:      CPF   (6)/W8E70,-B ; =0x8e70 =36464(-29072), [Compare fixed-length, direct, indexed]
8633:      BNZ   D860D      ; =-40 [Branch if not zero]
8635:      JMP   D863D      ; =+6 [Jump relative]
8637:D8637 LDA/  W8EED      ; =0x8eed =36589(-28947) [Load A direct]
863a:      STA/  W8EEF      ; =0x8eef =36591(-28945) [Store A direct]
863d:D863D INR   X,2        ; [Increment X by 2]
863f:      RSR              ; [Return from subroutine]
*
* Function F8640
*
8640:F8640 JSR/  F85A5      ; =0x85a5 =34213(-31323) [Jump to subroutine direct]
8643:      LDAB/ W8E67      ; =0x8e67 =36455(-29081) [Load AL direct]
8646:      LDBB= X'02'      ; =2 [Load BL with immediate]
8648:      SABB             ; [AL - BL -> BL]
8649:      BZ    D8659      ; =+14 [Branch if zero]
864b:D864B JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
864e:      DW    W8ACE      ; =0x8ace =35534(-30002) =LF,'N'
8650:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
8656:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8659:D8659 LDAB/ B8E6F      ; =0x8e6f =36463(-29073) [Load AL direct]
865c:      LDBB= X'05'      ; =5 [Load BL with immediate]
865e:      OREB  AL,BL      ; [AL ^ BL -> BL]
8660:      BNZ   D864B      ; =-23 [Branch if not zero]
8662:      LDA/  W80A4      ; =0x80a4 =32932(-32604) [Load A direct]
8665:      STA/  W80A6      ; =0x80a6 =32934(-32602) [Store A direct]
8668:      LDB/  W8E6D      ; =0x8e6d =36461(-29075) [Load B direct]
866b:      AAB              ; [A + B -> B]
866c:      STB/  W80A4      ; =0x80a4 =32932(-32604) [Store B direct]
866f:      JMP   D86A9      ; =+56 [Jump relative]
8671:D8671 JSR/  F8969      ; =0x8969 =35177(-30359) [Jump to subroutine direct]
8674:      LDAB/ W8E67      ; =0x8e67 =36455(-29081) [Load AL direct]
8677:      LDBB= X'02'      ; =2 [Load BL with immediate]
8679:      SABB             ; [AL - BL -> BL]
867a:      BZ    D8698      ; =+28 [Branch if zero]
867c:B867C LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
867e:      BNZ   D8692      ; =+18 [Branch if not zero]
8680:      LDBB= X'01'      ; =1 [Load BL with immediate]
8682:      SABB             ; [AL - BL -> BL]
8683:      BZ    D86D0      ; =+75 [Branch if zero]
8685:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8687:      SABB             ; [AL - BL -> BL]
8688:      BZ    D86AD      ; =+35 [Branch if zero]
868a:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
868d:      DW    W8ADB      ; =0x8adb =35547(-29989) =LF,'['
868f:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8692:D8692 LDAB/ B8E68      ; =0x8e68 =36456(-29080) [Load AL direct]
8695:      BNZ   D8671      ; =-38 [Branch if not zero]
8697:      RSR              ; [Return from subroutine]
*
8698:D8698 LDAB/ B8E6F      ; =0x8e6f =36463(-29073) [Load AL direct]
869b:      LDBB= X'02'      ; =2 [Load BL with immediate]
869d:      NABB             ; [AL & BL -> BL]
869e:      BZ    D86A9      ; =+9 [Branch if zero]
86a0:      LDAB  B867C+1    ; =-37 [Load AL relative]
86a2:      BNZ   D8671      ; =-51 [Branch if not zero]
86a4:      JSR/  F87A4      ; =0x87a4 =34724(-30812) =BEL,'$' [Jump to subroutine direct]
86a7:      JMP   D8671      ; =-56 [Jump relative]
86a9:D86A9 JSR   F871B      ; =+112 [Jump to subroutine relative]
86ab:      JMP   D8671      ; =-60 [Jump relative]
86ad:D86AD LDA/  W80A6      ; =0x80a6 =32934(-32602) [Load A direct]
86b0:      LDB/  W8E69      ; =0x8e69 =36457(-29079) [Load B direct]
86b3:      AAB              ; [A + B -> B]
86b4:      STB/  W8E69      ; =0x8e69 =36457(-29079) [Store B direct]
86b7:      LDAB/ B8E68      ; =0x8e68 =36456(-29080) [Load AL direct]
86ba:      BNZ   D86C9      ; =+13 [Branch if not zero]
86bc:      LDAB/ S80A1      ; =0x80a1 =32929(-32607) [Load AL direct]
86bf:      BNZ   D86C8      ; =+7 [Branch if not zero]
86c1:      STB/  W8145      ; =0x8145 =33093(-32443) [Store B direct]
86c4:      INAB             ; [Increment AL]
86c5:      STAB/ S80A1      ; =0x80a1 =32929(-32607) [Store AL direct]
86c8:D86C8 RSR              ; [Return from subroutine]
*
86c9:D86C9 JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
86cc:      DW    W8E67      ; =0x8e67 =36455(-29081)
86ce:      JMP   D8671      ; =-95 [Jump relative]
86d0:D86D0 STX-  S-         ; [Store X indexed, pre-decremented, direct]
86d2:      XFR   Y,X        ; [Transfer Y to X]
86d4:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
86d6:      LDA=  B8E68      ; =0x8e68 =36456(-29080) [Load A with immediate]
86d9:      XAY              ; [Transfer A to Y]
86da:      CLA              ; [Clear A]
86db:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
86dd:      SRA              ; [Right shift A]
86de:      XAX              ; [Transfer A to X]
86df:      LDA/  W80A6      ; =0x80a6 =32934(-32602) [Load A direct]
86e2:      STA+  Y+         ; [Store A indexed, direct, post-incremented]
86e4:D86E4 LDB+  Y          ; [Load B from address in Y]
86e5:      AAB              ; [A + B -> B]
86e6:      STB+  Y+         ; [Store B indexed, direct, post-incremented]
86e8:      DCX              ; [Decrement X]
86e9:      BGZ   D86E4      ; =-7 [Branch if greater than zero]
86eb:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
86ed:      XAY              ; [Transfer A to Y]
86ee:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
86f0:      JSR/  F887D      ; =0x887d =34941(-30595) [Jump to subroutine direct]
86f3:      DW    W8E67      ; =0x8e67 =36455(-29081)
*
86f5:      JMP/  D8671      ; =0x8671 =34417(-31119) [Jump direct]
*
* Function F86F8
*
86f8:F86F8 CLA              ; [Clear A]
86f9:      STA+  X          ; [Store A to address in X]
86fa:      LDB=  W9EF6      ; =0x9ef6 =40694(-24842) [Load B with immediate]
86fd:D86FD LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
8700:      AAB              ; [A + B -> B]
8701:      LDA/  W80AA      ; =0x80aa =32938(-32598) [Load A direct]
8704:      SUB   B,A        ; [B - A -> A]
8706:      BNL   D870B      ; =+3 [Branch on no link]
8708:      INR   X,2        ; [Increment X by 2]
870a:      RSR              ; [Return from subroutine]
*
870b:D870B LDAB+ B,2        ; [Load AL indexed, displaced, direct]
870e:      XFRB  AL,AU      ; [Transfer AL to AU]
8710:      LDAB= X'01'      ; =1 [Load AL with immediate]
8712:      ANDB  AU,AL      ; [AU & AL -> AL]
8714:      BNZ   D86FD      ; =-25 [Branch if not zero]
8716:      LDA+  X          ; [Load A from address in X]
8717:      INA              ; [Increment A]
8718:      STA+  X          ; [Store A to address in X]
8719:      JMP   D86FD      ; =-30 [Jump relative]
*
* Function F871B
*
871b:F871B LDA/  W80A6      ; =0x80a6 =32934(-32602) [Load A direct]
871e:      LDB/  W8E6B      ; =0x8e6b =36459(-29077) [Load B direct]
8721:      AAB              ; [A + B -> B]
8722:      STB/  W8E6B      ; =0x8e6b =36459(-29077) [Store B direct]
8725:      JSR/  F8829      ; =0x8829 =34857(-30679) [Jump to subroutine direct]
8728:      DW    W8E70      ; =0x8e70 =36464(-29072)
872a:W872A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
872c:      LDA   W872A      ; =-4 [Load A relative]
872e:      BNZ   D874E      ; =+30 [Branch if not zero]
8730:      JSR/  F8846      ; =0x8846 =34886(-30650) [Jump to subroutine direct]
8733:      DW    W8E70      ; =0x8e70 =36464(-29072)
8735:W8735 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8737:      LDA   W8735      ; =-4 [Load A relative]
8739:      JSR/  F833D      ; =0x833d =33597(-31939) [Jump to subroutine direct]
873c:D873C LDB/  W8E6B      ; =0x8e6b =36459(-29077) [Load B direct]
873f:      STB+  A          ; [Store B to address in A]
8740:      LDBB+ A,2        ; [Load BL indexed, displaced, direct]
8743:      XFRB  BL,BU      ; [Transfer BL to BU]
8745:      LDBB/ B8E6F      ; =0x8e6f =36463(-29073) [Load BL direct]
8748:      ORIB  BU,BL      ; [BU | BL -> BL]
874a:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
874d:      RSR              ; [Return from subroutine]
*
874e:D874E LDBB+ A,2        ; [Load BL indexed, displaced, direct]
8751:      XFRB  BL,BU      ; [Transfer BL to BU]
8753:      LDBB= X'01'      ; =1 [Load BL with immediate]
8755:      ANDB  BU,BL      ; [BU & BL -> BL]
8757:      BZ    D8780      ; =+39 [Branch if zero]
8759:      MVF   (6)/W8E70,/S8AA4 ; =0x8e70 =36464(-29072),=0x8aa4 =35492(-30044) =LF,'$' [Move fixed-length, direct, direct]
8760:      LDA   W872A      ; =-56 [Load A relative]
8762:      LDA+  A          ; [Load A from address in A]
8763:      LDB=  S8AAF      ; =0x8aaf =35503(-30033) =LF,'/' [Load B with immediate]
8766:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
8769:      LDA/  W8E6B      ; =0x8e6b =36459(-29077) [Load A direct]
876c:      LDB=  S8AB8      ; =0x8ab8 =35512(-30024) =LF,'8' [Load B with immediate]
876f:      JSR/  F88EA      ; =0x88ea =35050(-30486) [Jump to subroutine direct]
8772:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
8775:      DW    W8A96      ; =0x8a96 =35478(-30058)
8777:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
877d:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8780:D8780 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8782:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8784:      LDX+  A          ; [Load X indexed, direct]
8786:      LDA/  W8E6B      ; =0x8e6b =36459(-29077) [Load A direct]
8789:      STA   W87A0      ; =+21 [Store A relative]
878b:D878B LDA+  X+         ; [Load A indexed, direct, post-incremented]
878d:      STA   W87A2      ; =+19 [Store A relative]
878f:      JSR/  F887D      ; =0x887d =34941(-30595) [Jump to subroutine direct]
8792:      DW    W879E      ; =0x879e =34718(-30818)
8794:      LDX+  X          ; [Load X indexed, direct]
8796:      BNZ   D878B      ; =-13 [Branch if not zero]
8798:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
879a:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
879c:      JMP   D873C      ; =-98 [Jump relative]
*
879e:W879E DW    X'0102'    ; =0x0102 =258
87a0:W87A0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87a2:W87A2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F87A4
*
87a4:F87A4 LDA/  W80A6      ; =0x80a6 =32934(-32602) [Load A direct]
87a7:      LDB/  W8E6B      ; =0x8e6b =36459(-29077) [Load B direct]
87aa:      AAB              ; [A + B -> B]
87ab:      STB/  W8E6B      ; =0x8e6b =36459(-29077) [Store B direct]
87ae:      JSR   F8829      ; =+121 [Jump to subroutine relative]
87b0:      DW    W8E70      ; =0x8e70 =36464(-29072)
87b2:W87B2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87b4:      LDA   W87B2      ; =-4 [Load A relative]
87b6:      BNZ   D87D4      ; =+28 [Branch if not zero]
87b8:      JSR/  F8846      ; =0x8846 =34886(-30650) [Jump to subroutine direct]
87bb:      DW    W8E70      ; =0x8e70 =36464(-29072)
87bd:W87BD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87bf:      LDA   W87BD      ; =-4 [Load A relative]
87c1:      LDBB= X'02'      ; =2 [Load BL with immediate]
87c3:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
87c6:      LDB/  W80A8      ; =0x80a8 =32936(-32600) [Load B direct]
87c9:      STB+  A          ; [Store B to address in A]
87ca:      LDA/  W8E6B      ; =0x8e6b =36459(-29077) [Load A direct]
87cd:      STA+  B+         ; [Store A indexed, direct, post-incremented]
87cf:      CLA              ; [Clear A]
87d0:      STA+  B          ; [Store A to address in B]
87d1:      JSR   F880C      ; =+57 [Jump to subroutine relative]
87d3:      RSR              ; [Return from subroutine]
*
87d4:D87D4 LDBB+ A,2        ; [Load BL indexed, displaced, direct]
87d7:      XFRB  BL,BU      ; [Transfer BL to BU]
87d9:      LDBB= X'01'      ; =1 [Load BL with immediate]
87db:      ANDB  BU,BL      ; [BU & BL -> BL]
87dd:      BZ    D87F4      ; =+21 [Branch if zero]
87df:      LDBB= X'02'      ; =2 [Load BL with immediate]
87e1:      ORIB  BU,BL      ; [BU | BL -> BL]
87e3:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
87e6:      LDB+  A          ; [Load B from address in A]
87e7:      STB   W87A0      ; =-73 [Store B relative]
87e9:      LDB/  W8E6B      ; =0x8e6b =36459(-29077) [Load B direct]
87ec:      STB   W87A2      ; =-76 [Store B relative]
87ee:      JSR/  F887D      ; =0x887d =34941(-30595) [Jump to subroutine direct]
87f1:      DW    W879E      ; =0x879e =34718(-30818)
87f3:      RSR              ; [Return from subroutine]
*
87f4:D87F4 LDA+  A          ; [Load A from address in A]
87f5:D87F5 XAB              ; [Transfer A to B]
87f6:      LDA+  A,2        ; [Load A indexed, displaced, direct]
87f9:      BNZ   D87F5      ; =-6 [Branch if not zero]
87fb:      LDA/  W80A8      ; =0x80a8 =32936(-32600) [Load A direct]
87fe:      STA+  B,2        ; [Store A indexed, displaced, direct]
8801:      LDB/  W8E6B      ; =0x8e6b =36459(-29077) [Load B direct]
8804:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8806:      CLR   B          ; [Clear B]
8808:      STB+  A          ; [Store B to address in A]
8809:      JSR   F880C      ; =+1 [Jump to subroutine relative]
880b:      DB    X'09'      ; =0x09 =9
*
* Function F880C
*
880c:F880C LDA/  W80A8      ; =0x80a8 =32936(-32600) [Load A direct]
880f:      INR   A,4        ; [Increment A by 4]
8811:      LDB=  W9EFD      ; =0x9efd =40701(-24835) [Load B with immediate]
8814:      SAB              ; [A - B -> B]
8815:      BNL   D8825      ; =+14 [Branch on no link]
8817:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
881a:      DW    W8ABD      ; =0x8abd =35517(-30019) =LF,'='
881c:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
8822:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
8825:D8825 STA/  W80A8      ; =0x80a8 =32936(-32600) [Store A direct]
8828:      RSR              ; [Return from subroutine]
*
* Function F8829
*
8829:F8829 LDB+  X+         ; [Load B indexed, direct, post-incremented]
882b:      LDA=  W9EF9      ; =0x9ef9 =40697(-24839) [Load A with immediate]
882e:D882E INR   A,11       ; [Increment A by 11]
8830:      XFR/  W80AA,Y    ; =0x80aa =32938(-32598) [Transfer direct to Y]
8834:      SUB   A,Y        ; [A - Y -> Y]
8836:      BNL   D883B      ; =+3 [Branch on no link]
8838:      CLA              ; [Clear A]
8839:      JMP   D8843      ; =+8 [Jump relative]
883b:D883B CPF   (6)-A,-B   ; [Compare fixed-length, indexed, indexed]
883f:      BNZ   D882E      ; =-19 [Branch if not zero]
8841:      DCR   A,3        ; [Decrement A by 3]
8843:D8843 STA+  X+         ; [Store A indexed, direct, post-incremented]
8845:      RSR              ; [Return from subroutine]
*
* Function F8846
*
8846:F8846 LDA/  W80AA      ; =0x80aa =32938(-32598) [Load A direct]
8849:      LDB=  ENTRY      ; =0xb8c9 =47305(-18231) ='8','I' [Load B with immediate]
884c:      SAB              ; [A - B -> B]
884d:      BNL   D885D      ; =+14 [Branch on no link]
884f:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
8852:      DW    W8A85      ; =0x8a85 =35461(-30075)
8854:      ZAD   =100,/N828B(1) ; =0x828b =33419(-32117) [Zero-add bignum, literal=0x64, direct]
885a:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
885d:D885D LDB+  X+         ; [Load B indexed, direct, post-incremented]
885f:      STB   W8873+1    ; =+19 [Store B relative]
8861:      STA+  X+         ; [Store A indexed, direct, post-incremented]
8863:      LDB=  X'000B'    ; =0x000b =11 [Load B with immediate]
8866:      AAB              ; [A + B -> B]
8867:      STB/  W80AA      ; =0x80aa =32938(-32598) [Store B direct]
886a:      CLR   B          ; [Clear B]
886c:      STB+  A          ; [Store B to address in A]
886d:      STB+  A,9        ; [Store B indexed, displaced, direct]
8870:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
8873:W8873 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8876:      MVF   (6)-B,-A,3 ; [Move fixed-length, indexed, displaced indexed]
887c:      RSR              ; [Return from subroutine]
*
* Function F887D
*
887d:F887D LDB+  X+         ; [Load B indexed, direct, post-incremented]
887f:      STB   W88AB+1    ; =+43 [Store B relative]
8881:      CLA              ; [Clear A]
8882:      LDAB+ B,1        ; [Load AL indexed, displaced, direct]
8885:      INR   A,4        ; [Increment A by 4]
8887:      STA   W88A2+1    ; =+26 [Store A relative]
8889:D8889 LDA=  WBCC9      ; =0xbcc9 =48329(-17207) ='<','I' [Load A with immediate]
888c:      LDB/  W80AC      ; =0x80ac =32940(-32596) [Load B direct]
888f:      STB   W88A6+1    ; =+22 [Store B relative]
8891:      SAB              ; [A - B -> B]
8892:      LDA   W88A2+1    ; =+15 [Load A relative]
8894:      SAB              ; [A - B -> B]
8895:      BLE   D889B      ; =+4 [Branch if less than or equal to zero]
8897:      JSR   F88B4      ; =+27 [Jump to subroutine relative]
8899:      JMP   D8889      ; =-18 [Jump relative]
889b:D889B LDB/  W80AC      ; =0x80ac =32940(-32596) [Load B direct]
889e:      AAB              ; [A + B -> B]
889f:      STB/  W80AC      ; =0x80ac =32940(-32596) [Store B direct]
88a2:W88A2 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
88a5:      DCA              ; [Decrement A]
88a6:W88A6 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
88a9:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
88ab:W88AB LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
88ae:      MVFR  -X,-B      ; [Move fixed-length (len-1 in AL), indexed, indexed]
88b1:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
88b3:      RSR              ; [Return from subroutine]
*
* Function F88B4
*
88b4:F88B4 LDA   W88E3      ; =+45 [Load A relative]
88b6:      LDB/  W80AC      ; =0x80ac =32940(-32596) [Load B direct]
88b9:      SAB              ; [A - B -> B]
88ba:      BNL   D88BE      ; =+2 [Branch on no link]
88bc:      CLA              ; [Clear A]
88bd:      RSR              ; [Return from subroutine]
*
88be:D88BE JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
88c1:      DW    ENTRY      ; =0xb8c9 =47305(-18231) ='8','I'
88c3:      CLA              ; [Clear A]
88c4:      LDAB/ ENTRY+1    ; =0xb8ca =47306(-18230) ='8','J' [Load AL direct]
88c7:      INR   A,4        ; [Increment A by 4]
88c9:      LDB   W88E3      ; =+24 [Load B relative]
88cb:      AAB              ; [A + B -> B]
88cc:      STB   W88E5      ; =+23 [Store B relative]
88ce:      LDB/  W80AC      ; =0x80ac =32940(-32596) [Load B direct]
88d1:      SUB   B,A        ; [B - A -> A]
88d3:      STA/  W80AC      ; =0x80ac =32940(-32596) [Store A direct]
88d6:      LDA=  WBCC9      ; =0xbcc9 =48329(-17207) ='<','I' [Load A with immediate]
88d9:      LDB   W88E5      ; =+10 [Load B relative]
88db:      SAB              ; [A - B -> B]
88dc:      STB   W88E1      ; =+3 [Store B relative]
88de:      JSR/  FBE60      ; =0xbe60 =48736(-16800) [Jump to subroutine direct]
88e1:W88E1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e3:W88E3 DW    ENTRY      ; =0xb8c9 =47305(-18231) ='8','I'
88e5:W88E5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e7:      LDAB= X'01'      ; =1 [Load AL with immediate]
88e9:      RSR              ; [Return from subroutine]
*
* Function F88EA
*
88ea:F88EA STX-  S-         ; [Store X indexed, pre-decremented, direct]
88ec:      XFR   B,X        ; [Transfer B to X]
88ee:      JSR   F88FB      ; =+11 [Jump to subroutine relative]
88f0:      STB+  X,2        ; [Store B indexed, displaced, direct]
88f3:      XFRB  AU,AL      ; [Transfer AU to AL]
88f5:      JSR   F88FB      ; =+4 [Jump to subroutine relative]
88f7:      STB+  X          ; [Store B to address in X]
88f8:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
88fa:      RSR              ; [Return from subroutine]
*
* Function F88FB
*
88fb:F88FB STAB- S-         ; [Store AL indexed, pre-decremented, direct]
88fd:      SRRB  AL,4       ; [Right shift AL by 4]
88ff:      JSR   F8905      ; =+4 [Jump to subroutine relative]
8901:      XFRB  BL,BU      ; [Transfer BL to BU]
8903:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
*
* Function F8905
*
8905:F8905 LDBB= X'0F'      ; =15 [Load BL with immediate]
8907:      NABB             ; [AL & BL -> BL]
8908:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
890a:      LDAB= X'09'      ; =9 [Load AL with immediate]
890c:      SUBB  BL,AL      ; [BL - AL -> AL]
890e:      BLE   D8914      ; =+4 [Branch if less than or equal to zero]
8910:      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
8912:      JMP   D8916      ; =+2 [Jump relative]
8914:D8914 LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
8916:D8916 ORIB  AL,BL      ; [AL | BL -> BL]
8918:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
891a:      RSR              ; [Return from subroutine]
*
* Function F891B
*
891b:F891B STK   X,6        ; [Push X Y Z to the stack]
891d:      XFR=  W9EF6,Y    ; =0x9ef6 =40694(-24842) [Transfer immediate to Y]
8921:D8921 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8923:      LDB=  X'000B'    ; =0x000b =11 [Load B with immediate]
8926:      ADD   B,Y        ; [B + Y -> Y]
8928:      LDA/  W80AA      ; =0x80aa =32938(-32598) [Load A direct]
892b:      SAB              ; [A - B -> B]
892c:      SUB   Y,B        ; [Y - B -> B]
892e:      BNL   D8933      ; =+3 [Branch on no link]
8930:      POP   X,6        ; [Pop Z Y X from the stack]
8932:      RSR              ; [Return from subroutine]
*
8933:D8933 XFR   Y,Z        ; [Transfer Y to Z]
8935:D8935 LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
8938:      ADD   A,Z        ; [A + Z -> Z]
893a:D893A LDA/  W80AA      ; =0x80aa =32938(-32598) [Load A direct]
893d:      SUB   Z,A        ; [Z - A -> A]
893f:      BL    D8921      ; =-32 [Branch on link]
8941:      C     -Z,0(2),-Y,0(2) ; [Compare bignums, displaced indexed, displaced indexed]
8948:      BNL   D8935      ; =-21 [Branch on no link]
894a:      MVF   (11)-Y,/W895E ; =0x895e =35166(-30370) [Move fixed-length, indexed, direct]
8950:      MVF   (11)-Z,-Y  ; [Move fixed-length, indexed, indexed]
8954:      MVF   (11)/W895E,-Z ; =0x895e =35166(-30370), [Move fixed-length, direct, indexed]
895a:      INR   Z,11       ; [Increment Z by 11]
895c:      JMP   D893A      ; =-36 [Jump relative]
*
895e:W895E DS    11         ; =0x000b [Uninitialized memory]
*
*
* Function F8969
*
8969:F8969 LDAB/ B8A39      ; =0x8a39 =35385(-30151) [Load AL direct]
896c:      LDBB= X'20'      ; =32 [Load BL with immediate]
896e:      NABB             ; [AL & BL -> BL]
896f:      BNZ   D897E      ; =+13 [Branch if not zero]
8971:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8973:      DB    X'0C'      ; =0x0c =12 [Selector: get file date to A register]
8974:      DW    W8A37      ; =0x8a37 =35383(-30153) [address of RCB]
8976:      STA/  W8EED      ; =0x8eed =36589(-28947) [Store A direct]
8979:      JSR   F899E      ; =+35 [Jump to subroutine relative]
897b:      DB    X'09'      ; =0x09 =9
897c:      DW    W8A37      ; =0x8a37 =35383(-30153)
*
897e:D897E JSR   F899E      ; =+30 [Jump to subroutine relative]
8980:      DB    X'01'      ; =0x01 =1
8981:      DW    W8A37      ; =0x8a37 =35383(-30153)
8983:      BNZ   D8986      ; =+1 [Branch if not zero]
8985:      RSR              ; [Return from subroutine]
*
8986:D8986 DCAB             ; [Decrement AL]
8987:      BZ    D898C      ; =+3 [Branch if zero]
8989:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
898b:      DB    X'33'      ; =0x33 =51 [abort code]
*
898c:D898C JSR   F899E      ; =+16 [Jump to subroutine relative]
898e:      DB    X'0A'      ; =0x0a =10
898f:      DW    W8A37      ; =0x8a37 =35383(-30153)
*
8991:      JSR   F89C7      ; =+52 [Jump to subroutine relative]
8993:      DW    W8AF9      ; =0x8af9 =35577(-29959) =LF,'y'
8995:P8995 LDAB/ B8A38      ; =0x8a38 =35384(-30152) [Load AL direct]
8998:      INAB             ; [Increment AL]
8999:      STAB* P8995+1    ; =-5 [Store AL relative indirect]
899b:      JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
*
* Function F899E
*
899e:F899E LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
89a0:      LDB+  X          ; [Load B from address in X]
89a1:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
89a4:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
89a6:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
89a8:      LDAB+ B          ; [Load AL from address in B]
89a9:      RSR              ; [Return from subroutine]
*
* Function F89AA
*
89aa:F89AA LDAB/ B8A57      ; =0x8a57 =35415(-30121) [Load AL direct]
89ad:      LDBB= X'20'      ; =32 [Load BL with immediate]
89af:      NABB             ; [AL & BL -> BL]
89b0:      BNZ   D89B7      ; =+5 [Branch if not zero]
89b2:      JSR   F899E      ; =-22 [Jump to subroutine relative]
89b4:      DB    X'09'      ; =0x09 =9
89b5:      DW    W8A55      ; =0x8a55 =35413(-30123)
*
89b7:D89B7 LDA+  X+         ; [Load A indexed, direct, post-incremented]
89b9:      STA/  S8A65      ; =0x8a65 =35429(-30107) [Store A direct]
89bc:      JSR   F899E      ; =-32 [Jump to subroutine relative]
89be:      DB    X'02'      ; =0x02 =2
89bf:      DW    W8A55      ; =0x8a55 =35413(-30123)
89c1:      BNZ   D89C4      ; =+1 [Branch if not zero]
89c3:      RSR              ; [Return from subroutine]
*
89c4:D89C4 SVC   X'09'      ; =9 [Service call ABRT - abort task]
89c6:      DB    X'34'      ; =0x34 =52 [abort code]
*
* Function F89C7
*
89c7:F89C7 LDA+  X+         ; [Load A indexed, direct, post-incremented]
89c9:      STA   S8A33      ; =+104 [Store A relative]
89cb:      LDB=  W8A2D      ; =0x8a2d =35373(-30163) [Load B with immediate]
89ce:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
89d0:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
89d2:      DW    W8A2D      ; =0x8a2d =35373(-30163) [TODO: arg 1]
89d4:      RSR              ; [Return from subroutine]
*
* Function F89D5
*
89d5:F89D5 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
89d7:      BZ    D89DE      ; =+5 [Branch if zero]
89d9:      JSR   F8A11      ; =+54 [Jump to subroutine relative]
89db:      DB    X'02'      ; =0x02 =2
89dc:      DW    W8B23      ; =0x8b23 =35619(-29917)
*
89de:D89DE JSR   F8A11      ; =+49 [Jump to subroutine relative]
89e0:      DB    X'01'      ; =0x01 =1
89e1:      DW    W80AE      ; =0x80ae =32942(-32594)
89e3:      BZ    D89EC      ; =+7 [Branch if zero]
89e5:D89E5 JSR   F89C7      ; =-32 [Jump to subroutine relative]
89e7:      DW    W8B26      ; =0x8b26 =35622(-29914)
89e9:      JMP/  W8259      ; =0x8259 =33369(-32167) [Jump direct]
89ec:D89EC JSR/  F84EF      ; =0x84ef =34031(-31505) =EOT,'o' [Jump to subroutine direct]
89ef:B89EF LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
89f1:      BNZ   D89F7      ; =+4 [Branch if not zero]
89f3:      JSR   F89C7      ; =-46 [Jump to subroutine relative]
89f5:      DW    W80AE      ; =0x80ae =32942(-32594)
*
89f7:D89F7 JSR/  WBCC9      ; =0xbcc9 =48329(-17207) ='<','I' [Jump to subroutine direct]
89fa:      DW    W80AE      ; =0x80ae =32942(-32594)
89fc:      LDA=  S80B0      ; =0x80b0 =32944(-32592) [Load A with immediate]
89ff:      XAZ              ; [Transfer A to Z]
8a00:      JSR/  F8408      ; =0x8408 =33800(-31736) [Jump to subroutine direct]
8a03:      LDA+  Z          ; [Load A from address in Z]
8a04:      LDB=  X'AFAA'    ; =0xafaa =44970(-20566) ='/','*' [Load B with immediate]
8a07:      SAB              ; [A - B -> B]
8a08:      BZ    D89E5      ; =-37 [Branch if zero]
8a0a:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
8a0c:      SUBB  AU,BL      ; [AU - BL -> BL]
8a0e:      BZ    F89D5      ; =-59 [Branch if zero]
8a10:      RSR              ; [Return from subroutine]
*
* Function F8A11
*
8a11:F8A11 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8a13:      STAB  B8A26      ; =+17 [Store AL relative]
8a15:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8a17:      STA   W8A29      ; =+16 [Store A relative]
8a19:      LDB=  W8A23      ; =0x8a23 =35363(-30173) [Load B with immediate]
8a1c:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
8a1e:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
8a20:      DW    W8A23      ; =0x8a23 =35363(-30173) [TODO: arg 1]
8a22:      RSR              ; [Return from subroutine]
*
8a23:W8A23 DB    X'00'      ; =0x00 =0 =NUL
8a24:B8A24 DW    X'8100'    ; =0x8100 =33024(-32512)
8a26:B8A26 DW    X'0100'    ; =0x0100 =256
8a28:      DB    X'84'      ; =0x84 =132(-124) =EOT
8a29:W8A29 DW    W80AE      ; =0x80ae =32942(-32594)
8a2b:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a2d:W8A2D DW    X'0082'    ; =0x0082 =130
8a2f:      DB    X'00'      ; =0x00 =0 =NUL
8a30:      DW    X'0200'    ; =0x0200 =512
8a32:      DB    X'84'      ; =0x84 =132(-124) =EOT
8a33:S8A33 DB    0,4        ; =0x00,0x0004
8a37:W8A37 DB    X'00'      ; =0x00 =0 =NUL
8a38:B8A38 DB    X'02'      ; =0x02 =2
8a39:B8A39 DW    X'0100'    ; =0x0100 =256
8a3b:      DW    X'0190'    ; =0x0190 =400
8a3d:      DW    W8B41      ; =0x8b41 =35649(-29887)
8a3f:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a41:      DW    WBCF0      ; =0xbcf0 =48368(-17168) ='<','p'
8a43:      DW    X'0204'    ; =0x0204 =516
8a45:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8a47:      DW    W8E67      ; =0x8e67 =36455(-29081)
8a49:      DB    0,11       ; =0x00,0x000b
8a54:      DB    X'84'      ; =0x84 =132(-124) =EOT
8a55:W8A55 DW    X'0001'    ; =0x0001 =1
8a57:B8A57 DW    X'0200'    ; =0x0200 =512
8a59:      DW    X'0190'    ; =0x0190 =400
8a5b:      DW    W8CD4      ; =0x8cd4 =36052(-29484) =FF,'T'
8a5d:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a5f:      DW    WBCF0      ; =0xbcf0 =48368(-17168) ='<','p'
8a61:      DW    X'0204'    ; =0x0204 =516
8a63:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8a65:S8A65 DB    0,8        ; =0x00,0x0008
8a6d:S8A6D DB    0,5        ; =0x00,0x0005
8a72:      DB    X'84'      ; =0x84 =132(-124) =EOT
8a73:W8A73 DW    X'0010'    ; =0x0010 =16
8a75:      DC    'STATEMENT ERROR'
8a84:      DB    X'8D'      ; =0x8d =141(-115) =CR
8a85:W8A85 DW    X'000F'    ; =0x000f =15
8a87:      DC    'ESD TABLE FULL'
8a95:      DB    X'8D'      ; =0x8d =141(-115) =CR
8a96:W8A96 DW    X'0025'    ; =0x0025 =37
8a98:      DC    'DUPE ENTRY "'
8aa4:S8AA4 DC    '      " AT '
8aaf:S8AAF DC    '     AND ' ; hex:a0a0a0a0a0c1cec4a0
8ab8:S8AB8 DC    '    '     ; hex:a0a0a0a0
8abc:      DB    X'8D'      ; =0x8d =141(-115) =CR
8abd:W8ABD DW    X'000F'    ; =0x000f =15
8abf:      DC    'XTRN LIST FULL'
8acd:      DB    X'8D'      ; =0x8d =141(-115) =CR
8ace:W8ACE DW    X'000B'    ; =0x000b =11
8ad0:      DC    'NO ESD/HDR' ; hex:cecfa0c5d3c4afc8c4d2
8ada:      DB    X'8D'      ; =0x8d =141(-115) =CR
8adb:W8ADB DW    X'000D'    ; =0x000d =13
8add:      DC    'ERROR RECORD'
8ae9:      DB    X'8D'      ; =0x8d =141(-115) =CR
8aea:W8AEA DW    X'000D'    ; =0x000d =13
8aec:      DC    'ALL RESOLVED'
8af8:      DB    X'8D'      ; =0x8d =141(-115) =CR
8af9:W8AF9 DW    X'000D'    ; =0x000d =13
8afb:      DC    'EOF ON INPUT'
8b07:      DB    X'8D'      ; =0x8d =141(-115) =CR
8b08:W8B08 DW    X'0019'    ; =0x0019 =25
8b0a:      DC    ' '        ; hex:a0 dec:160(-96)
8b0b:S8B0B DC    '  '       ; hex:a0a0 dec:41120(-96)
8b0d:S8B0D DC    '  '       ; hex:a0a0 dec:41120(-96)
8b0f:S8B0F DC    ' '        ; hex:a0 dec:160(-96)
8b10:S8B10 DC    '  UNRESOLVED XTRNS'
8b22:      DB    X'8D'      ; =0x8d =141(-115) =CR
8b23:W8B23 DW    X'0001'    ; =0x0001 =1
8b25:      DC    '/'        ; hex:af dec:175(-81)
8b26:W8B26 DW    X'000D'    ; =0x000d =13
8b28:      DC    'END OF CMNDS'
8b34:      DB    X'8D'      ; =0x8d =141(-115) =CR
8b35:W8B35 DW    X'0009'    ; =0x0009 =9
8b37:      DC    'END LINK' ; hex:c5cec4a0ccc9cecb
8b3f:      DB    X'8D'      ; =0x8d =141(-115) =CR
8b40:W8B40 DB    X'84'      ; =0x84 =132(-124) =EOT
8b41:W8B41 DS    403        ; =0x0193 [Uninitialized memory]
8cd4:W8CD4 DS    403        ; =0x0193 [Uninitialized memory]
8e67:W8E67 DS    1          ; =0x0001 [Uninitialized memory]
8e68:B8E68 DS    1          ; =0x0001 [Uninitialized memory]
8e69:W8E69 DS    2          ; =0x0002 [Uninitialized memory]
8e6b:W8E6B DS    2          ; =0x0002 [Uninitialized memory]
8e6d:W8E6D DS    2          ; =0x0002 [Uninitialized memory]
8e6f:B8E6F DS    1          ; =0x0001 [Uninitialized memory]
8e70:W8E70 DS    6          ; =0x0006 [Uninitialized memory]
8e76:W8E76 DS    119        ; =0x0077 [Uninitialized memory]
8eed:W8EED DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8eef:W8EEF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8ef1:      DS    15         ; =0x000f [Uninitialized memory]
8f00:W8F00 DS    1          ; =0x0001 [Uninitialized memory]
8f01:W8F01 DS    4085       ; =0x0ff5 [Uninitialized memory]
9ef6:W9EF6 DS    3          ; =0x0003 [Uninitialized memory]
9ef9:W9EF9 DS    4          ; =0x0004 [Uninitialized memory]
9efd:W9EFD DS    4          ; =0x0004 [Uninitialized memory]
9f01:W9F01 DS    6600       ; =0x19c8 [Uninitialized memory]
*
* Function ENTRY
*
b8c9:ENTRY XFR=  W80A0,S    ; =0x80a0 =32928(-32608) [Transfer immediate to S]
b8cd:      XFR=  W8F00,Y    ; =0x8f00 =36608(-28928) [Transfer immediate to Y]
b8d1:      CAD/  WBEF4+1    ; [Clear word at address]
b8d5:      JSR/  F89C7      ; =0x89c7 =35271(-30265) [Jump to subroutine direct]
b8d8:      DW    WB924      ; =0xb924 =47396(-18140)
b8da:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
b8dc:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
b8dd:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
b8de:      DB    X'15'      ; =0x15 =21 [TODO: arg3]
b8df:WB8DF DW    WB8DF      ; =0xb8df =47327(-18209) ='8',DEL [address to store block value]
b8e1:      LDAB  WB8DF      ; =-4 [Load AL relative]
b8e3:      SRAB             ; [Right shift AL]
b8e4:      BL    DB8EB      ; =+5 [Branch on link]
b8e6:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
b8e8:      STBB/ B8A24      ; =0x8a24 =35364(-30172) [Store BL direct]
b8eb:DB8EB LDB=  W8A23      ; =0x8a23 =35363(-30173) [Load B with immediate]
b8ee:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
b8f0:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
b8f1:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
b8f2:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
b8f3:WB8F3 DW    WB8F3      ; =0xb8f3 =47347(-18189) ='8','s' [address to store block value]
b8f5:      LDB=  W8A23      ; =0x8a23 =35363(-30173) [Load B with immediate]
b8f8:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
b8fa:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
b8fb:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
b8fc:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
b8fd:WB8FD DW    WB8FD      ; =0xb8fd =47357(-18179) ='8','}' [address to store block value]
b8ff:      LDAB  WB8FD      ; =-4 [Load AL relative]
b901:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
b903:      NABB             ; [AL & BL -> BL]
b904:      BZ    DB921      ; =+27 [Branch if zero]
b906:      LDAB= X'01'      ; =1 [Load AL with immediate]
b908:      STAB/ F89D5+1    ; =0x89d6 =35286(-30250) [Store AL direct]
b90b:      LDB=  W8A2D      ; =0x8a2d =35373(-30163) [Load B with immediate]
b90e:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
b910:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
b911:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
b912:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
b913:WB913 DW    WB913      ; =0xb913 =47379(-18157) [address to store block value]
b915:      LDB   WB8F3      ; =-36 [Load B relative]
b917:      LDA   WB913      ; =-6 [Load A relative]
b919:      SAB              ; [A - B -> B]
b91a:      BNZ   DB921      ; =+5 [Branch if not zero]
b91c:      LDAB= X'01'      ; =1 [Load AL with immediate]
b91e:      STAB/ B89EF+1    ; =0x89f0 =35312(-30224) [Store AL direct]
b921:DB921 JMP/  J8147      ; =0x8147 =33095(-32441) [Jump direct]
*
b924:WB924 DW    X'000A'    ; =0x000a =10
b926:      DC    'LINK 7.01' ; hex:ccc9cecba0b7aeb0b1
b92f:      DB    X'8D'      ; =0x8d =141(-115) =CR
b930:      DS    921        ; =0x0399 [Uninitialized memory]
bcc9:WBCC9 LDA+  X+         ; [Load A indexed, direct, post-incremented]
bccb:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
bccd:      XFR   Y,X        ; [Transfer Y to X]
bccf:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
bcd1:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
bcd3:      XAY              ; [Transfer A to Y]
bcd4:DBCD4 DCX              ; [Decrement X]
bcd5:      BM    DBCEA      ; =+19 [Branch on minus]
bcd7:      LDAB+ Y          ; [Load AL from address in Y]
bcd8:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
bcda:      SABB             ; [AL - BL -> BL]
bcdb:      BGZ   DBCE6      ; =+9 [Branch if greater than zero]
bcdd:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
bcdf:      SABB             ; [AL - BL -> BL]
bce0:      BM    DBCE6      ; =+4 [Branch on minus]
bce2:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
bce4:      ADDB  BL,AL      ; [BL + AL -> AL]
bce6:DBCE6 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
bce8:      JMP   DBCD4      ; =-22 [Jump relative]
bcea:DBCEA LDA+  S+         ; [Load A indexed, direct, post-incremented]
bcec:      XAY              ; [Transfer A to Y]
bced:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
bcef:      RSR              ; [Return from subroutine]
*
bcf0:WBCF0 DB    X'0B'      ; =0x0b =11
bcf1:      DW    WBD85      ; =0xbd85 =48517(-17019)
bcf3:      DW    WBDD7      ; =0xbdd7 =48599(-16937) ='=','W'
bcf5:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
bcf7:      DW    WBD07      ; =0xbd07 =48391(-17145)
bcf9:      DB    0,12       ; =0x00,0x000c
bd05:      DW    WBE5A      ; =0xbe5a =48730(-16806)
*
bd07:WBD07 STX-  S-         ; [Store X indexed, pre-decremented, direct]
bd09:      JSR   FBD36      ; =+43 [Jump to subroutine relative]
bd0b:      DB    X'02'      ; =0x02 =2
bd0c:      BZ    DBD34      ; =+38 [Branch if zero]
bd0e:      CLA              ; [Clear A]
bd0f:      STA+  Z,18       ; [Store A indexed, displaced, direct]
bd12:      STA+  Z,22       ; [Store A indexed, displaced, direct]
bd15:      STB+  Z,20       ; [Store B indexed, displaced, direct]
bd18:      STB+  Z,24       ; [Store B indexed, displaced, direct]
bd1b:      JSR   FBD36      ; =+25 [Jump to subroutine relative]
bd1d:      DB    X'05'      ; =0x05 =5
bd1e:      LDBB= X'0F'      ; =15 [Load BL with immediate]
bd20:      ANDB  BU,BL      ; [BU & BL -> BL]
bd22:      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
bd25:      BM    DBD2D      ; =+6 [Branch on minus]
bd27:      SABB             ; [AL - BL -> BL]
bd28:      BZ    DBD2D      ; =+3 [Branch if zero]
bd2a:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
bd2c:      DB    X'12'      ; =0x12 =18 [abort code]
*
bd2d:DBD2D LDA+  Z,6        ; [Load A indexed, displaced, direct]
bd30:      BZ    DBD34      ; =+2 [Branch if zero]
bd32:      JSR   FBD4D      ; =+25 [Jump to subroutine relative]
bd34:DBD34 JMP   DBDAB      ; =+117 [Jump relative]
*
* Function FBD36
*
bd36:FBD36 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
bd38:      STAB  BBD40      ; =+6 [Store AL relative]
bd3a:      XFR   Z,B        ; [Transfer Z to B]
bd3c:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
bd3e:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
bd3f:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
bd40:BBD40 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
bd41:      DW    LBD47+1    ; =0xbd48 =48456(-17080) [TODO: address]
bd43:      XFR   B,B        ; [Transfer B to B]
bd45:      BZ    DBD4C      ; =+5 [Branch if zero]
bd47:LBD47 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
bd4a:      XFR   A,A        ; [Transfer A to A]
bd4c:DBD4C RSR              ; [Return from subroutine]
*
* Function FBD4D
*
bd4d:FBD4D JSR   FBD36      ; =-25 [Jump to subroutine relative]
bd4f:      DB    X'02'      ; =0x02 =2
bd50:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
bd53:      SUB   B,A        ; [B - A -> A]
bd55:      BL    DBD5B      ; =+4 [Branch on link]
bd57:      LDAB= X'01'      ; =1 [Load AL with immediate]
bd59:      JMP   DBD6F      ; =+20 [Jump relative]
bd5b:DBD5B LDA+  Z,22       ; [Load A indexed, displaced, direct]
bd5e:      STA+  Z,18       ; [Store A indexed, displaced, direct]
bd61:      STA+  Z,8        ; [Store A indexed, displaced, direct]
bd64:      JSR   FBD79      ; =+19 [Jump to subroutine relative]
bd66:      DB    X'01'      ; =0x01 =1
bd67:      LDB+  Z,18       ; [Load B indexed, displaced, direct]
bd6a:      INR   B          ; [Increment B by 1]
bd6c:      STB+  Z,22       ; [Store B indexed, displaced, direct]
bd6f:DBD6F STAB+ Z          ; [Store AL to address in Z]
bd70:      RSR              ; [Return from subroutine]
*
* Function FBD71
*
bd71:FBD71 LDAB+ Z          ; [Load AL from address in Z]
bd72:      BP    DBD78      ; =+4 [Branch on plus]
bd74:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
bd76:      JMP   FBD71      ; =-7 [Jump relative]
bd78:DBD78 RSR              ; [Return from subroutine]
*
* Function FBD79
*
bd79:FBD79 XFR   Z,B        ; [Transfer Z to B]
bd7b:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
bd7d:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
bd80:      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
bd82:      JSR   FBD71      ; =-19 [Jump to subroutine relative]
bd84:      RSR              ; [Return from subroutine]
*
bd85:WBD85 STX-  S-         ; [Store X indexed, pre-decremented, direct]
bd87:DBD87 LDA+  Z,6        ; [Load A indexed, displaced, direct]
bd8a:      INR   A,2        ; [Increment A by 2]
bd8c:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
bd8f:      STB+  Z,20       ; [Store B indexed, displaced, direct]
bd92:      ADD   B,A        ; [B + A -> A]
bd94:      XAY              ; [Transfer A to Y]
bd95:      LDA+  Y          ; [Load A from address in Y]
bd96:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
bd98:      LDAB= X'01'      ; =1 [Load AL with immediate]
bd9a:      SUBB  AU,BL      ; [AU - BL -> BL]
bd9c:      BZ    DBDAA      ; =+12 [Branch if zero]
bd9e:      DCRB  AU         ; [Decrement AU by 1]
bda0:      BNF   DBDAF      ; =+13 [Branch on no fault]
bda2:      JSR   FBD4D      ; =-87 [Jump to subroutine relative]
bda4:      CLA              ; [Clear A]
bda5:      STA+  Z,24       ; [Store A indexed, displaced, direct]
bda8:      JMP   DBD87      ; =-35 [Jump relative]
bdaa:DBDAA STAB+ Z          ; [Store AL to address in Z]
bdab:DBDAB LDB+  S+         ; [Load B indexed, direct, post-incremented]
bdad:      SVC   X'68'      ; =104 [Service call RLSR - return from LSR]
bdaf:DBDAF LDA+  Y          ; [Load A from address in Y]
bdb0:      CLRB  AU         ; [Clear AU]
bdb2:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
bdb5:      ADD   B,A        ; [B + A -> A]
bdb7:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
bdba:      AAB              ; [A + B -> B]
bdbb:      STB+  Z,24       ; [Store B indexed, displaced, direct]
bdbe:      LDB+  Z,16       ; [Load B indexed, displaced, direct]
bdc1:      XAX              ; [Transfer A to X]
bdc2:      CLA              ; [Clear A]
bdc3:DBDC3 DCX              ; [Decrement X]
bdc4:      BLE   DBDCE      ; =+8 [Branch if less than or equal to zero]
bdc6:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
bdc8:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
bdca:      ADDB  AL,AU      ; [AL + AU -> AU]
bdcc:      JMP   DBDC3      ; =-11 [Jump relative]
bdce:DBDCE LDAB+ Y          ; [Load AL from address in Y]
bdcf:      ADDB  AU,AL      ; [AU + AL -> AL]
bdd1:      BZ    DBDAA      ; =-41 [Branch if zero]
bdd3:      LDAB= X'04'      ; =4 [Load AL with immediate]
bdd5:      JMP   DBDAA      ; =-45 [Jump relative]
bdd7:WBDD7 STX-  S-         ; [Store X indexed, pre-decremented, direct]
bdd9:DBDD9 LDA+  Z,6        ; [Load A indexed, displaced, direct]
bddc:      INR   A,2        ; [Increment A by 2]
bdde:      XAY              ; [Transfer A to Y]
bddf:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
bde2:      STA+  Z,20       ; [Store A indexed, displaced, direct]
bde5:      ADD   A,Y        ; [A + Y -> Y]
bde7:      LDX+  Z,16       ; [Load X indexed, displaced, direct]
bdea:      LDB+  X          ; [Load B from address in X]
bdeb:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
bded:      SUBB  BL,BU      ; [BL - BU -> BU]
bdef:      BNZ   DBDF4      ; =+3 [Branch if not zero]
bdf1:      STBB+ Y          ; [Store BL to address in Y]
bdf2:      JMP   DBE25      ; =+49 [Jump relative]
bdf4:DBDF4 LDB+  X          ; [Load B from address in X]
bdf5:      CLRB  BU         ; [Clear BU]
bdf7:      AAB              ; [A + B -> B]
bdf8:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
bdfb:      AAB              ; [A + B -> B]
bdfc:      STB+  Z,24       ; [Store B indexed, displaced, direct]
bdff:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
be02:      SAB              ; [A - B -> B]
be03:      BP    DBE0B      ; =+6 [Branch on plus]
be05:      JSR   FBE37      ; =+48 [Jump to subroutine relative]
be07:      BZ    DBDD9      ; =-48 [Branch if zero]
be09:      JMP   DBDAA      ; =-97 [Jump relative]
be0b:DBE0B LDA+  X+         ; [Load A indexed, direct, post-incremented]
be0d:      XAB              ; [Transfer A to B]
be0e:      CLRB  AU         ; [Clear AU]
be10:      STB+  Y+         ; [Store B indexed, direct, post-incremented]
be12:      ADDB  BL,BU      ; [BL + BU -> BU]
be14:      INA              ; [Increment A]
be15:DBE15 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
be17:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
be19:      ADDB  BL,BU      ; [BL + BU -> BU]
be1b:      DCA              ; [Decrement A]
be1c:      BP    DBE15      ; =-9 [Branch on plus]
be1e:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
be20:      IVRB  BU         ; [Invert BU]
be22:      INRB  BU         ; [Increment BU by 1]
be24:      STB+  Y          ; [Store B to address in Y]
be25:DBE25 CLAB             ; [Clear AL]
be26:DBE26 JMP   DBDAA      ; =-126 [Jump relative]
*
* Function FBE28
*
be28:FBE28 CLA              ; [Clear A]
be29:      STA+  Z,24       ; [Store A indexed, displaced, direct]
be2c:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
be2f:      STA+  Z,8        ; [Store A indexed, displaced, direct]
be32:      JSR/  FBD79      ; =0xbd79 =48505(-17031) [Jump to subroutine direct]
be35:      DB    X'02'      ; =0x02 =2
be36:      RSR              ; [Return from subroutine]
*
* Function FBE37
*
be37:FBE37 JSR   FBE28      ; =-17 [Jump to subroutine relative]
be39:      BNZ   DBE56      ; =+27 [Branch if not zero]
be3b:      JSR/  FBD36      ; =0xbd36 =48438(-17098) [Jump to subroutine direct]
be3e:      DB    X'02'      ; =0x02 =2
be3f:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
be42:      STA+  Z,18       ; [Store A indexed, displaced, direct]
be45:      INA              ; [Increment A]
be46:      STA+  Z,22       ; [Store A indexed, displaced, direct]
be49:      DCA              ; [Decrement A]
be4a:      SUB   B,A        ; [B - A -> A]
be4c:      BL    DBE55      ; =+7 [Branch on link]
be4e:      XFR   Z,B        ; [Transfer Z to B]
be50:      SVC   X'19'      ; =25 [Service call EXP - file expand]
be52:      XAB              ; [Transfer A to B]
be53:      BNZ   DBE57      ; =+2 [Branch if not zero]
be55:DBE55 CLA              ; [Clear A]
be56:DBE56 RSR              ; [Return from subroutine]
*
be57:DBE57 LDAB= X'02'      ; =2 [Load AL with immediate]
be59:      RSR              ; [Return from subroutine]
*
be5a:WBE5A STX-  S-         ; [Store X indexed, pre-decremented, direct]
be5c:      JSR   FBE28      ; =-54 [Jump to subroutine relative]
be5e:      JMP   DBE26      ; =-58 [Jump relative]
*
* Function FBE60
*
be60:FBE60 STK   Y,2        ; [Push Y to the stack]
be62:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
be64:      DCA              ; [Decrement A]
be65:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
be67:      XFR   B,Y        ; [Transfer B to Y]
be69:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
be6b:      MVL              ; [Move long (len in A, src in B, dst in Y)]
be6c:      POP   Y,2        ; [Pop Y from the stack]
be6e:      RSR              ; [Return from subroutine]
*
* Function FBE6F
*
be6f:FBE6F LDA+  X+         ; [Load A indexed, direct, post-incremented]
be71:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
be73:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
be75:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
be77:      BLE   DBE87      ; =+14 [Branch if less than or equal to zero]
be79:      ADD   X,A        ; [X + A -> A]
be7b:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
be7e:DBE7E LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
be80:      SUBB  BU,BL      ; [BU - BL -> BL]
be82:      BNZ   DBE87      ; =+3 [Branch if not zero]
be84:      DCX              ; [Decrement X]
be85:      BGZ   DBE7E      ; =-9 [Branch if greater than zero]
be87:DBE87 LDA+  S+         ; [Load A indexed, direct, post-incremented]
be89:      STX+  A          ; [Store X indexed, direct]
be8b:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
be8d:      RSR              ; [Return from subroutine]
*
be8e:      DS    72         ; =0x0048 [Uninitialized memory]
bed6:WBED6 DW    X'0074'    ; =0x0074 =116
bed8:      DW    X'004C'    ; =0x004c =76
*
beda:DBEDA JSR   DBF35      ; =+89 [Jump to subroutine relative]
bedc:      STAB+ C,3        ; [Store AL indexed, displaced, direct]
bedf:DBEDF CLA              ; [Clear A]
bee0:      STAB  BBF48+1    ; =+103 [Store AL relative]
bee2:      JSR   DBF3C      ; =+88 [Jump to subroutine relative]
bee4:      XABB             ; [Transfer AL to BL]
bee5:      BM    DBEDA      ; =-13 [Branch on minus]
bee7:      BZ    DBF13      ; =+42 [Branch if zero]
bee9:      JSR   DBF3C      ; =+81 [Jump to subroutine relative]
beeb:      SRA              ; [Right shift A]
beec:      XAX              ; [Transfer A to X]
beed:      JSR   DBF3C      ; =+77 [Jump to subroutine relative]
beef:      XFRB  AL,YU      ; [Transfer AL to YU]
bef1:      JSR   DBF3C      ; =+73 [Jump to subroutine relative]
bef3:      XAYB             ; [Transfer AL to YL]
bef4:WBEF4 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
bef7:      XAZ              ; [Transfer A to Z]
bef8:      ADD   A,Y        ; [A + Y -> Y]
befa:DBEFA JSR   DBF3C      ; =+64 [Jump to subroutine relative]
befc:      XFRB  AL,BU      ; [Transfer AL to BU]
befe:      JSR   DBF3C      ; =+60 [Jump to subroutine relative]
bf00:      XABB             ; [Transfer AL to BL]
bf01:      ADD   Z,B        ; [Z + B -> B]
bf03:      LDA+  B          ; [Load A from address in B]
bf04:      ADD   Y,A        ; [Y + A -> A]
bf06:      STA+  B          ; [Store A to address in B]
bf07:      DCX              ; [Decrement X]
bf08:      BNZ   DBEFA      ; =-16 [Branch if not zero]
bf0a:DBF0A JSR   DBF3C      ; =+48 [Jump to subroutine relative]
bf0c:      LDBB  BBF48+1    ; =+59 [Load BL relative]
bf0e:      BZ    DBEDF      ; =-49 [Branch if zero]
bf10:DBF10 HLT              ; [Halt]
bf11:      JMP   DBEDA      ; =-57 [Jump relative]
bf13:DBF13 JSR   DBF3C      ; =+39 [Jump to subroutine relative]
bf15:      XAX              ; [Transfer A to X]
bf16:      JSR   DBF3C      ; =+36 [Jump to subroutine relative]
bf18:      XFRB  AL,AU      ; [Transfer AL to AU]
bf1a:      JSR   DBF3C      ; =+32 [Jump to subroutine relative]
bf1c:      XAY              ; [Transfer A to Y]
bf1d:      LDA   WBEF4+1    ; =-42 [Load A relative]
bf1f:      ADD   A,Y        ; [A + Y -> Y]
bf21:      XFR   X,X        ; [Transfer X to X]
bf23:      BZ    DBF2E      ; =+9 [Branch if zero]
bf25:DBF25 JSR   DBF3C      ; =+21 [Jump to subroutine relative]
bf27:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
bf29:      DCX              ; [Decrement X]
bf2a:      BNZ   DBF25      ; =-7 [Branch if not zero]
bf2c:      JMP   DBF0A      ; =-36 [Jump relative]
bf2e:DBF2E JSR   DBF35      ; =+5 [Jump to subroutine relative]
bf30:      STAB+ C,10       ; [Store AL indexed, displaced, direct]
bf33:      JMP+  Y          ; [Jump indexed, direct]
bf35:DBF35 LDAB+ C,1        ; [Load AL indexed, displaced, direct]
bf38:      SRAB             ; [Right shift AL]
bf39:      BNL   DBF35      ; =-6 [Branch on no link]
bf3b:      RSR              ; [Return from subroutine]
*
bf3c:DBF3C LDAB+ C,1        ; [Load AL indexed, displaced, direct]
bf3f:      BM    DBF10      ; =-49 [Branch on minus]
bf41:      SRAB             ; [Right shift AL]
bf42:      BL    DBF10      ; =-52 [Branch on link]
bf44:      SRAB             ; [Right shift AL]
bf45:      BNL   DBF3C      ; =-11 [Branch on no link]
bf47:      LDAB+ C          ; [Load AL from address in C]
bf48:BBF48 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
bf4a:      AABB             ; [AL + BL -> BL]
bf4b:      STBB  BBF48+1    ; =-4 [Store BL relative]
bf4d:      RSR              ; [Return from subroutine]
*
bf4e:ENDPT
