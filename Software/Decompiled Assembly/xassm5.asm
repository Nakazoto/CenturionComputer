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
8000:      DB    0,200      ; =0x00,0x00c8
80c8:W80C8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80ca:W80CA DW    X'0001'    ; =0x0001 =1
80cc:      DW    X'0109'    ; =0x0109 =265
80ce:      DW    X'0190'    ; =0x0190 =400
80d0:      DW    W839B      ; =0x839b =33691(-31845)
80d2:      DB    0,3        ; =0x00,0x0003
80d5:      DW    X'0102'    ; =0x0102 =258
80d7:      DW    X'0200'    ; =0x0200 =512
80d9:      DB    X'84'      ; =0x84 =132(-124) =EOT
80da:      DW    W8314      ; =0x8314 =33556(-31980)
80dc:      DB    0,11       ; =0x00,0x000b
80e7:      DB    X'84'      ; =0x84 =132(-124) =EOT
80e8:W80E8 DW    X'0002'    ; =0x0002 =2
80ea:      DW    X'0209'    ; =0x0209 =521
80ec:      DW    X'0190'    ; =0x0190 =400
80ee:      DW    ENTRY      ; =0x852e =34094(-31442)
80f0:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80f2:      DW    W9917      ; =0x9917 =39191(-26345)
80f4:      DW    X'0204'    ; =0x0204 =516
80f6:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
80f8:S80F8 DB    0,13       ; =0x00,0x000d
8105:      DB    X'84'      ; =0x84 =132(-124) =EOT
8106:W8106 DW    X'0003'    ; =0x0003 =3
8108:      DW    X'0209'    ; =0x0209 =521
810a:      DW    X'0190'    ; =0x0190 =400
810c:S810C DB    0,4        ; =0x00,0x0004
8110:W8110 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8112:      DW    X'0102'    ; =0x0102 =258
8114:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8116:S8116 DB    0,13       ; =0x00,0x000d
8123:      DB    X'84'      ; =0x84 =132(-124) =EOT
8124:W8124 DW    X'0004'    ; =0x0004 =4
8126:      DW    X'0209'    ; =0x0209 =521
8128:      DW    X'0190'    ; =0x0190 =400
812a:S812A DB    0,5        ; =0x00,0x0005
812f:      DW    X'0402'    ; =0x0402 =1026
8131:      DW    X'0100'    ; =0x0100 =256
8133:      DB    X'04'      ; =0x04 =4
8134:      DW    W86C1      ; =0x86c1 =34497(-31039)
8136:      DB    0,11       ; =0x00,0x000b
8141:      DB    X'04'      ; =0x04 =4
*
* Function F8142
*
8142:F8142 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8144:      LDB+  X          ; [Load B from address in X]
8145:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8148:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
814a:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
814c:      LDAB+ B          ; [Load AL from address in B]
814d:      RSR              ; [Return from subroutine]
*
* Function F814E
*
814e:F814E JSR   F8142      ; =-14 [Jump to subroutine relative]
8150:      DB    X'01'      ; =0x01 =1
8151:      DW    W80CA      ; =0x80ca =32970(-32566)
8153:      BNZ   D815E      ; =+9 [Branch if not zero]
8155:      JSR/  F98F0      ; =0x98f0 =39152(-26384) [Jump to subroutine direct]
8158:      DW    W8314      ; =0x8314 =33556(-31980)
815a:      LDA=  W8316      ; =0x8316 =33558(-31978) [Load A with immediate]
815d:      RSR              ; [Return from subroutine]
*
815e:D815E JSR   F8142      ; =-30 [Jump to subroutine relative]
8160:      DB    X'04'      ; =0x04 =4
8161:      DW    W80CA      ; =0x80ca =32970(-32566)
8163:      CLA              ; [Clear A]
8164:D8164 RSR              ; [Return from subroutine]
*
8165:J8165 LDA   S812A      ; =-61 [Load A relative]
8167:      BNZ   D816E      ; =+5 [Branch if not zero]
8169:      LDB=  X'C0B0'    ; =0xc0b0 =49328(-16208) ='@','0' [Load B with immediate]
816c:      JMP   D8193      ; =+37 [Jump relative]
816e:D816E LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8171:      STA/  W86C3      ; =0x86c3 =34499(-31037) [Store A direct]
8174:      STA/  W86C5      ; =0x86c5 =34501(-31035) [Store A direct]
8177:      JSR   F81CD      ; =+84 [Jump to subroutine relative]
8179:      LDAB= X'84'      ; =132(-124) =EOT [Load AL with immediate]
817b:      STAB/ W86C3      ; =0x86c3 =34499(-31037) [Store AL direct]
817e:      CLR   A,1        ; [Set A to 1]
8180:      JSR   F81CF      ; =+77 [Jump to subroutine relative]
8182:      DB    X'7B'      ; =0x7b =123
8183:      DC    '>'        ; hex:be dec:190(-66)
8184:      DB    X'0B'      ; =0x0b =11
8185:      DW    W8124      ; =0x8124 =33060(-32476)
8187:      DW    X'8001'    ; =0x8001 =32769(-32767)
8189:      DC    '#'        ; hex:a3 dec:163(-93)
818a:      DW    X'9B7B'    ; =0x9b7b =39803(-25733)
818c:      DC    '5'        ; hex:b5 dec:181(-75)
818d:      DB    X'09'      ; =0x09 =9
818e:      DW    W8124      ; =0x8124 =33060(-32476)
8190:      DC    'P@1'      ; hex:d0c0b1
*
8193:D8193 STB   S81BC      ; =+39 [Store B relative]
8195:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8197:      DB    X'09'      ; =0x09 =9 [Selector: load private library?]
8198:      DW    S81B8      ; =0x81b8 =33208(-32328) [address of TODO]
819a:      DW    J8843      ; =0x8843 =34883(-30653) [jump address TODO]
819c:      DW    X'0001'    ; =0x0001 =1 [TODO: arg 3]
819e:      DB    X'0B'      ; =0x0b =11 [word argument count]
819f:      DW    F822D      ; =0x822d =33325(-32211) [Function argument]
81a1:      DW    F81F6      ; =0x81f6 =33270(-32266) [Function argument]
81a3:      DW    F87C8      ; =0x87c8 =34760(-30776) =BEL,'H' [Function argument]
81a5:      DW    W80CA      ; =0x80ca =32970(-32566) [Address argument]
81a7:      DW    W80E8      ; =0x80e8 =33000(-32536) [Address argument]
81a9:      DW    W8106      ; =0x8106 =33030(-32506) [Address argument]
81ab:      DW    S826D      ; =0x826d =33389(-32147) [Address argument]
81ad:      DW    F81E0      ; =0x81e0 =33248(-32288) [Function argument]
81af:      DW    W8124      ; =0x8124 =33060(-32476) [Address argument]
81b1:      DW    W86C3      ; =0x86c3 =34499(-31037) [Address argument]
81b3:      DW    F81ED      ; =0x81ed =33261(-32275) [Function argument]
81b5:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
81b7:      DB    X'03'      ; =0x03 =3 [abort code]
*
81b8:S81B8 DC    '    '     ; hex:a0a0a0a0
81bc:S81BC DC    '  '       ; hex:a0a0 dec:41120(-96)
81be:      DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F81BF
*
81bf:F81BF STA/  S80F8      ; =0x80f8 =33016(-32520) [Store A direct]
81c2:      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
81c5:      DB    X'02'      ; =0x02 =2
81c6:      DW    W80E8      ; =0x80e8 =33000(-32536)
81c8:      BZ    D8164      ; =-102 [Branch if zero]
81ca:D81CA SVC   X'09'      ; =9 [Service call ABRT - abort task]
81cc:      DB    X'34'      ; =0x34 =52 [abort code]
*
* Function F81CD
*
81cd:F81CD CLR   A,4        ; [Set A to 4]
*
* Function F81CF
*
81cf:F81CF LDB/  S812A      ; =0x812a =33066(-32470) [Load B direct]
81d2:      BZ    D81DF      ; =+11 [Branch if zero]
81d4:      STA/  W86C1      ; =0x86c1 =34497(-31039) [Store A direct]
81d7:      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
81da:      DB    X'02'      ; =0x02 =2
81db:      DW    W8124      ; =0x8124 =33060(-32476)
81dd:      BNZ   D81CA      ; =-21 [Branch if not zero]
81df:D81DF RSR              ; [Return from subroutine]
*
* Function F81E0
*
81e0:F81E0 JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
81e3:      DB    X'01'      ; =0x01 =1
81e4:      DW    W8124      ; =0x8124 =33060(-32476)
81e6:      BZ    D81EC      ; =+4 [Branch if zero]
81e8:      JSR   F81ED      ; =+3 [Jump to subroutine relative]
81ea:      LDAB= X'01'      ; =1 [Load AL with immediate]
81ec:D81EC RSR              ; [Return from subroutine]
*
* Function F81ED
*
81ed:F81ED JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
81f0:      DB    X'04'      ; =0x04 =4
81f1:      DW    W8124      ; =0x8124 =33060(-32476)
81f3:      RSR              ; [Return from subroutine]
*
81f4:D81F4 JSR   F822D      ; =+55 [Jump to subroutine relative]
*
* Function F81F6
*
81f6:F81F6 LDA   W826B      ; =+115 [Load A relative]
81f8:      DCA              ; [Decrement A]
81f9:      STA   W826B      ; =+112 [Store A relative]
81fb:      BLE   D81F4      ; =-9 [Branch if less than or equal to zero]
81fd:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
*
* Function F81FF
*
81ff:F81FF STA   W8204      ; =+3 [Store A relative]
8201:      JSR/  F9B2A      ; =0x9b2a =39722(-25814) [Jump to subroutine direct]
8204:W8204 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8206:      LDB   W8204      ; =-4 [Load B relative]
8208:D8208 STB/  S8116      ; =0x8116 =33046(-32490) [Store B direct]
820b:      LDA+  B          ; [Load A from address in B]
820c:      BLE   D8227      ; =+25 [Branch if less than or equal to zero]
820e:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8210:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8212:      INA              ; [Increment A]
8213:      STA+  B+         ; [Store A indexed, direct, post-incremented]
8215:      AAB              ; [A + B -> B]
8216:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8218:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
821a:      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
821d:      DB    X'02'      ; =0x02 =2
821e:      DW    W8106      ; =0x8106 =33030(-32506)
8220:      BNZ   D81CA      ; =-88 [Branch if not zero]
8222:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8224:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8226:      STA+  B          ; [Store A to address in B]
8227:D8227 RSR              ; [Return from subroutine]
*
* Function F8228
*
8228:F8228 LDB=  W8263      ; =0x8263 =33379(-32157) [Load B with immediate]
822b:      JMP   D8208      ; =-37 [Jump relative]
*
* Function F822D
*
822d:F822D LDA=  W8267      ; =0x8267 =33383(-32153) [Load A with immediate]
8230:      JSR   F81FF      ; =-51 [Jump to subroutine relative]
8232:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8234:      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
8237:      JSR   F8228      ; =-17 [Jump to subroutine relative]
8239:      DW    X'3F18'    ; =0x3f18 =16152
823b:      DC    '{'        ; hex:fb dec:251(-5)
823c:      DB    X'90'      ; =0x90 =144(-112)
823d:      DC    '  3'      ; hex:a0a0b3
8240:      DB    X'48'      ; =0x48 =72
8241:      DC    '3'        ; hex:b3 dec:179(-77)
8242:      DW    X'5393'    ; =0x5393 =21395
8244:      DW    X'2A38'    ; =0x2a38 =10808
8246:      DC    '3'        ; hex:b3 dec:179(-77)
8247:      DW    X'277B'    ; =0x277b =10107
8249:      DB    X'29'      ; =0x29 =41
824a:      DW    S828B      ; =0x828b =33419(-32117)
824c:      DW    X'931F'    ; =0x931f =37663(-27873)
824e:      DW    X'7B23'    ; =0x7b23 =31523
8250:      DW    S8298      ; =0x8298 =33432(-32104)
8252:      DB    X'90'      ; =0x90 =144(-112)
8253:      DW    W8282      ; =0x8282 =33410(-32126)
8255:      DB    X'7B'      ; =0x7b =123
8256:      DC    '('        ; hex:a8 dec:168(-88)
8257:      DB    X'7B'      ; =0x7b =123
8258:      DC    'O'        ; hex:cf dec:207(-49)
8259:      DB    X'7B'      ; =0x7b =123
825a:      DC    'M'        ; hex:cd dec:205(-51)
825b:      DW    X'9000'    ; =0x9000 =36864(-28672)
825d:      DB    X'34'      ; =0x34 =52
825e:      DC    '3'        ; hex:b3 dec:179(-77)
825f:      DW    X'0B65'    ; =0x0b65 =2917
8261:      DC    '!'        ; hex:a1 dec:161(-95)
8262:      DB    X'09'      ; =0x09 =9
8263:W8263 DW    X'0001'    ; =0x0001 =1
8265:      DC    ' '        ; hex:a0 dec:160(-96)
8266:      DB    X'00'      ; =0x00 =0 =NUL
8267:W8267 DW    X'0001'    ; =0x0001 =1
8269:      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
826b:W826B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
826d:S826D DB    0,4        ; =0x00,0x0004
8271:      DW    X'9541'    ; =0x9541 =38209(-27327)
8273:      DC    'U'        ; hex:d5 dec:213(-43)
8274:      DB    X'41'      ; =0x41 =65
8275:      DC    's'        ; hex:f3 dec:243(-13)
8276:      DW    X'0266'    ; =0x0266 =614
8278:      DW    X'2E00'    ; =0x2e00 =11776
827a:      DW    X'0009'    ; =0x0009 =9
*
*
* Function F827C
*
827c:F827C SVC   X'2B'      ; =43 [Service call MUL16 - 16-bit multiply]
827e:      RSR              ; [Return from subroutine]
*
* Function F827F
*
827f:F827F SVC   X'2C'      ; =44 [Service call DIV16 - 16-bit divide]
8281:      RSR              ; [Return from subroutine]
*
8282:W8282 DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8284:S8284 DC    'PAGE   '  ; hex:d0c1c7c5a0a0a0
828b:S828B DC    '    ERRORS   '
8298:S8298 DC    '    '     ; hex:a0a0a0a0
829c:S829C DC    '                     '
82b1:S82B1 DC    '           '
82bc:S82BC DC    '                                                            '
82f8:      DC    '                           '
8313:      DB    X'00'      ; =0x00 =0 =NUL
8314:W8314 DS    2          ; =0x0002 [Uninitialized memory]
8316:W8316 DS    133        ; =0x0085 [Uninitialized memory]
839b:W839B DS    403        ; =0x0193 [Uninitialized memory]
*
* Function ENTRY
*
852e:ENTRY JMP/  J9B49      ; =0x9b49 =39753(-25783) [Jump direct]
*
8531:      DW    W86C8      ; =0x86c8 =34504(-31032)
8533:      DS    398        ; =0x018e [Uninitialized memory]
86c1:W86C1 DS    2          ; =0x0002 [Uninitialized memory]
86c3:W86C3 DS    2          ; =0x0002 [Uninitialized memory]
86c5:W86C5 DS    3          ; =0x0003 [Uninitialized memory]
86c8:W86C8 LDA+  X+         ; [Load A indexed, direct, post-incremented]
86ca:      STA   W86ED      ; =+33 [Store A relative]
86cc:      LDB=  X'003C'    ; =0x003c =60 [Load B with immediate]
86cf:      AAB              ; [A + B -> B]
86d0:      STB   W86EB      ; =+25 [Store B relative]
86d2:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
86d4:      STB   W86E9      ; =+19 [Store B relative]
86d6:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
86d8:      STB   W86EF      ; =+21 [Store B relative]
86da:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
86dc:      LDX=  X'001E'    ; =0x001e =30 [Load X with immediate]
86df:      CLR   B          ; [Clear B]
86e1:D86E1 STB+  A+         ; [Store B indexed, direct, post-incremented]
86e3:      DCX              ; [Decrement X]
86e4:      BNZ   D86E1      ; =-5 [Branch if not zero]
86e6:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
86e8:      RSR              ; [Return from subroutine]
*
86e9:W86E9 DS    2          ; =0x0002 [Uninitialized memory]
86eb:W86EB DS    2          ; =0x0002 [Uninitialized memory]
86ed:W86ED DS    2          ; =0x0002 [Uninitialized memory]
86ef:W86EF DS    2          ; =0x0002 [Uninitialized memory]
86f1:      DW    X'9541'    ; =0x9541 =38209(-27327)
86f3:      DC    'Svu'      ; hex:d3f6f5
86f6:      DW    X'4158'    ; =0x4158 =16728
86f8:      DB    X'93'      ; =0x93 =147(-109)
86f9:      DC    'o'        ; hex:ef dec:239(-17)
86fa:      DW    X'5120'    ; =0x5120 =20768
86fc:      DW    X'1003'    ; =0x1003 =4099
86fe:      DC    'sk'       ; hex:f3eb dec:62443(-21)
8700:      DW    X'0966'    ; =0x0966 =2406
8702:      DW    X'5966'    ; =0x5966 =22886
8704:      DB    X'07'      ; =0x07 =7
8705:      DC    'Sb'       ; hex:d3e2 dec:54242(-30)
8707:      DW    X'3208'    ; =0x3208 =12808
8709:      DW    X'479E'    ; =0x479e =18334
870b:      DW    X'FF00'    ; =0xff00 =65280(-256)
870d:      DW    X'0250'    ; =0x0250 =592
870f:      DW    X'3201'    ; =0x3201 =12801
8711:      DB    X'00'      ; =0x00 =0 =NUL
8712:      DW    X'3918'    ; =0x3918 =14616
8714:      DC    'tsR'      ; hex:f4f3d2
8717:      DW    X'3143'    ; =0x3143 =12611
8719:      DB    X'73'      ; =0x73 =115
871a:      DC    'V'        ; hex:d6 dec:214(-42)
*
*
* Function F871B
*
871b:F871B LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
871d:      SABB             ; [AL - BL -> BL]
871e:      BM    D8726      ; =+6 [Branch on minus]
8720:      LDAB= X'1D'      ; =29 [Load AL with immediate]
8722:      SUBB  BL,AL      ; [BL - AL -> AL]
8724:      BLE   D8728      ; =+2 [Branch if less than or equal to zero]
8726:D8726 LDBB= X'1D'      ; =29 [Load BL with immediate]
8728:D8728 CLRB  BU         ; [Clear BU]
872a:      SLR   B          ; [Left shift B by 1]
872c:      LDA   W86ED      ; =-65 [Load A relative]
872e:      AAB              ; [A + B -> B]
872f:      RSR              ; [Return from subroutine]
*
8730:W8730 DW    X'8544'    ; =0x8544 =34116(-31420)
8732:      DB    X'7B'      ; =0x7b =123
8733:      DC    'g'        ; hex:e7 dec:231(-25)
8734:      DW    X'9548'    ; =0x9548 =38216(-27320)
8736:      DB    X'02'      ; =0x02 =2
8737:      DC    '3'        ; hex:b3 dec:179(-77)
8738:      DW    X'2E6D'    ; =0x2e6d =11885
873a:      DC    '"'        ; hex:a2 dec:162(-94)
873b:      DW    X'5524'    ; =0x5524 =21796
873d:      DC    'S0'       ; hex:d3b0 dec:54192(-80)
873f:      DW    X'3838'    ; =0x3838 =14392
8741:      DW    X'3858'    ; =0x3858 =14424
8743:      DC    's'        ; hex:f3 dec:243(-13)
8744:      DW    X'027B'    ; =0x027b =635
8746:      DC    '*'        ; hex:aa dec:170(-86)
8747:      DB    X'00'      ; =0x00 =0 =NUL
8748:      DB    0,3        ; =0x00,0x0003
874b:      DB    X'93'      ; =0x93 =147(-109)
874c:      DC    '|'        ; hex:fc dec:252(-4)
874d:      DW    X'142E'    ; =0x142e =5166
874f:      DC    'Z:u'      ; hex:dabaf5
8752:      DB    X'01'      ; =0x01 =1
8753:      DC    'S'        ; hex:d3 dec:211(-45)
8754:      DW    X'9A38'    ; =0x9a38 =39480(-26056)
8756:      DB    X'58'      ; =0x58 =88
8757:      DC    's'        ; hex:f3 dec:243(-13)
8758:      DW    X'0B93'    ; =0x0b93 =2963
875a:      DB    X'0C'      ; =0x0c =12
875b:      DC    '5'        ; hex:b5 dec:181(-75)
875c:      DW    X'2265'    ; =0x2265 =8805
875e:      DC    ' U'       ; hex:a0d5 dec:41173(-43)
8760:      DW    X'416D'    ; =0x416d =16749
8762:      DC    ' '        ; hex:a0 dec:160(-96)
8763:      DW    X'6000'    ; =0x6000 =24576
8765:      DB    X'00'      ; =0x00 =0 =NUL
8766:      DW    X'9000'    ; =0x9000 =36864(-28672)
8768:      DB    X'00'      ; =0x00 =0 =NUL
8769:      DW    X'3967'    ; =0x3967 =14695
876b:      DW    X'4A24'    ; =0x4a24 =18980
876d:      DB    X'65'      ; =0x65 =101
876e:      DC    '!'        ; hex:a1 dec:161(-95)
876f:      DB    X'93'      ; =0x93 =147(-109)
8770:      DC    's'        ; hex:f3 dec:243(-13)
8771:      DW    X'3939'    ; =0x3939 =14649
8773:      DB    X'39'      ; =0x39 =57
8774:      DC    'Q'        ; hex:d1 dec:209(-47)
8775:      DW    W86EF      ; =0x86ef =34543(-30993)
8777:      DW    X'5995'    ; =0x5995 =22933
8779:      DB    X'41'      ; =0x41 =65
877a:      DC    'u'        ; hex:f5 dec:245(-11)
877b:      DW    X'4109'    ; =0x4109 =16649
877d:      DB    X'65'      ; =0x65 =101
877e:      DC    '!U'       ; hex:a1d5 dec:41429(-43)
8780:      DB    X'41'      ; =0x41 =65
8781:      DC    'U'        ; hex:d5 dec:213(-43)
8782:      DB    X'41'      ; =0x41 =65
8783:      DC    '5'        ; hex:b5 dec:181(-75)
8784:      DW    X'4109'    ; =0x4109 =16649
8786:W8786 LDAB+ *X         ; [Load AL indexed, indirect]
8788:      JSR   F871B      ; =-111 [Jump to subroutine relative]
878a:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
878c:      STA   W87B1      ; =+35 [Store A relative]
878e:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8790:      STA   W87AF      ; =+29 [Store A relative]
8792:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8794:      XFR   B,X        ; [Transfer B to X]
8796:D8796 LDA+  X          ; [Load A from address in X]
8797:      BZ    D87C3      ; =+42 [Branch if zero]
8799:      XAX              ; [Transfer A to X]
879a:      INA              ; [Increment A]
879b:      INA              ; [Increment A]
879c:      INA              ; [Increment A]
879d:P879D LDB/  W86EF      ; =0x86ef =34543(-30993) [Load B direct]
87a0:      AAB              ; [A + B -> B]
87a1:      STB   W87B3      ; =+16 [Store B relative]
87a3:      CLA              ; [Clear A]
87a4:      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
87a7:      LDB   W87AF      ; =+6 [Load B relative]
87a9:      SAB              ; [A - B -> B]
87aa:      BNZ   D8796      ; =-22 [Branch if not zero]
87ac:      JSR/  F9ABD      ; =0x9abd =39613(-25923) [Jump to subroutine direct]
87af:W87AF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87b1:W87B1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87b3:W87B3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87b5:      XFRB  BL,BL      ; [Transfer BL to BL]
87b7:      BNZ   D8796      ; =-35 [Branch if not zero]
87b9:      LDA   W87B3      ; =-8 [Load A relative]
87bb:      DCA              ; [Decrement A]
87bc:      DCA              ; [Decrement A]
87bd:      DCA              ; [Decrement A]
87be:      LDB*  P879D+1    ; =-34 [Load B relative indirect]
87c0:      SAB              ; [A - B -> B]
87c1:      XFR   B,A        ; [Transfer B to A]
87c3:D87C3 LDX+  S+         ; [Load X indexed, direct, post-incremented]
87c5:      STA+  X+         ; [Store A indexed, direct, post-incremented]
87c7:      RSR              ; [Return from subroutine]
*
* Function F87C8
*
87c8:F87C8 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
87ca:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
87cc:      STB   W87EA      ; =+28 [Store B relative]
87ce:      STB   W8807      ; =+55 [Store B relative]
87d0:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
87d2:      LDAB+ B          ; [Load AL from address in B]
87d3:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
87d5:D87D5 JSR/  F871B      ; =0x871b =34587(-30949) [Jump to subroutine direct]
87d8:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
87da:      XFR   B,X        ; [Transfer B to X]
87dc:D87DC LDA+  X          ; [Load A from address in X]
87dd:      BZ    D8833      ; =+84 [Branch if zero]
87df:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
87e1:      INA              ; [Increment A]
87e2:      LDB*  P879D+1    ; =-70 [Load B relative indirect]
87e4:      AAB              ; [A + B -> B]
87e5:      STB   W87EC      ; =+5 [Store B relative]
87e7:P87E7 JSR/  F9A87      ; =0x9a87 =39559(-25977) [Jump to subroutine direct]
87ea:W87EA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87ec:W87EC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
87ee:      BM    D87F4      ; =+4 [Branch on minus]
87f0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
87f2:      JMP   D87DC      ; =-24 [Jump relative]
87f4:D87F4 LDA   W87EC      ; =-10 [Load A relative]
87f6:      STA   W8817      ; =+31 [Store A relative]
87f8:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
87fa:D87FA LDA+  X          ; [Load A from address in X]
87fb:      BZ    D8825      ; =+40 [Branch if zero]
87fd:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
87ff:      INA              ; [Increment A]
8800:      LDB*  P879D+1    ; =-100 [Load B relative indirect]
8802:      AAB              ; [A + B -> B]
8803:      STB   W8809      ; =+4 [Store B relative]
8805:      JSR*  P87E7+1    ; =-31 [Jump to subroutine relative indirect]
8807:W8807 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8809:W8809 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
880b:      BM    D8811      ; =+4 [Branch on minus]
880d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
880f:      JMP   D87FA      ; =-23 [Jump relative]
8811:D8811 LDA   W8809      ; =-10 [Load A relative]
8813:      STA   W8819      ; =+4 [Store A relative]
8815:      JSR*  P87E7+1    ; =-47 [Jump to subroutine relative indirect]
8817:W8817 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8819:W8819 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
881b:      BM    D8821      ; =+4 [Branch on minus]
881d:      LDA   W8819      ; =-6 [Load A relative]
881f:      STA   W8817      ; =-10 [Store A relative]
8821:D8821 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8823:      JMP   D87FA      ; =-43 [Jump relative]
8825:D8825 LDA   W8817      ; =-16 [Load A relative]
8827:      LDB/  W86EF      ; =0x86ef =34543(-30993) [Load B direct]
882a:      DCA              ; [Decrement A]
882b:      SAB              ; [A - B -> B]
882c:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
882e:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8830:      STB+  X+         ; [Store B indexed, direct, post-incremented]
8832:      RSR              ; [Return from subroutine]
*
8833:D8833 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8835:      LDAB+ S          ; [Load AL from address in S]
8836:      INAB             ; [Increment AL]
8837:      STAB+ S          ; [Store AL to address in S]
8838:      LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
883a:      SABB             ; [AL - BL -> BL]
883b:      BLE   D87D5      ; =-104 [Branch if less than or equal to zero]
883d:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
883f:      CLA              ; [Clear A]
8840:      STA+  X+         ; [Store A indexed, direct, post-incremented]
8842:      RSR              ; [Return from subroutine]
*
8843:J8843 LDA=  W98EF      ; =0x98ef =39151(-26385) [Load A with immediate]
8846:      XAY              ; [Transfer A to Y]
8847:      JSR/  W86C8      ; =0x86c8 =34504(-31032) [Jump to subroutine direct]
884a:W884A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
884c:S884C DB    0,3        ; =0x00,0x0003
884f:      DB    X'03'      ; =0x03 =3
*
8850:      JSR   F8875      ; =+35 [Jump to subroutine relative]
8852:      JSR   F88B0      ; =+92 [Jump to subroutine relative]
8854:      LDA   W889D      ; =+71 [Load A relative]
8856:      STA/  W93F5      ; =0x93f5 =37877(-27659) [Store A direct]
8859:      LDAB= X'01'      ; =1 [Load AL with immediate]
885b:      STAB  B888F      ; =+50 [Store AL relative]
885d:      JSR   F8875      ; =+22 [Jump to subroutine relative]
885f:      JSR   F88B0      ; =+79 [Jump to subroutine relative]
8861:P8861 JSR/  F9446      ; =0x9446 =37958(-27578) [Jump to subroutine direct]
8864:      DW    W94D0      ; =0x94d0 =38096(-27440)
*
8866:      JSR*  P8861+1    ; =-6 [Jump to subroutine relative indirect]
8868:      DW    W9454      ; =0x9454 =37972(-27564)
*
886a:      JSR/  F9353      ; =0x9353 =37715(-27821) [Jump to subroutine direct]
886d:      JSR/  F93E4      ; =0x93e4 =37860(-27676) [Jump to subroutine direct]
8870:      DW    W888B      ; =0x888b =34955(-30581)
8872:      JMP/  J8165      ; =0x8165 =33125(-32411) [Jump direct]
*
* Function F8875
*
8875:F8875 CLA              ; [Clear A]
8876:      STAB/ S9455      ; =0x9455 =37973(-27563) [Store AL direct]
8879:      STAB/ S94D1      ; =0x94d1 =38097(-27439) [Store AL direct]
887c:      STA   W889D      ; =+31 [Store A relative]
887e:      STAB/ B9369      ; =0x9369 =37737(-27799) [Store AL direct]
8881:      STA   W888D      ; =+10 [Store A relative]
8883:      STA/  S826D      ; =0x826d =33389(-32147) [Store A direct]
8886:      LDA=  W98EF      ; =0x98ef =39151(-26385) [Load A with immediate]
8889:      XAY              ; [Transfer A to Y]
888a:      RSR              ; [Return from subroutine]
*
888b:W888B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
888d:W888D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
888f:B888F DB    X'00'      ; =0x00 =0 =NUL
8890:B8890 DB    X'00'      ; =0x00 =0 =NUL
8891:B8891 DB    X'01'      ; =0x01 =1
8892:B8892 DB    X'01'      ; =0x01 =1
8893:W8893 DS    5          ; =0x0005 [Uninitialized memory]
8898:B8898 DB    X'00'      ; =0x00 =0 =NUL
8899:B8899 DB    X'00'      ; =0x00 =0 =NUL
889a:W889A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
889c:B889C DB    X'00'      ; =0x00 =0 =NUL
889d:W889D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
889f:B889F DB    X'00'      ; =0x00 =0 =NUL
88a0:W88A0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88a2:W88A2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88a4:W88A4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88a6:W88A6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88a8:W88A8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88aa:W88AA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ac:W88AC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ae:W88AE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F88B0
*
88b0:F88B0 JSR/  F814E      ; =0x814e =33102(-32434) [Jump to subroutine direct]
88b3:      XAZ              ; [Transfer A to Z]
88b4:      BNZ   D88B7      ; =+1 [Branch if not zero]
88b6:      RSR              ; [Return from subroutine]
*
88b7:D88B7 LDAB+ Z          ; [Load AL from address in Z]
88b8:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
88ba:      SABB             ; [AL - BL -> BL]
88bb:      BNZ   D88C1      ; =+4 [Branch if not zero]
88bd:      INR   Z          ; [Increment Z by 1]
88bf:      JMP   F88B0      ; =-17 [Jump relative]
88c1:D88C1 LDA=  W98EF      ; =0x98ef =39151(-26385) [Load A with immediate]
88c4:      XAY              ; [Transfer A to Y]
88c5:      LDAB= X'04'      ; =4 [Load AL with immediate]
88c7:      STAB  B8899      ; =-48 [Store AL relative]
88c9:      CLA              ; [Clear A]
88ca:      STA   W88A0      ; =-44 [Store A relative]
88cc:      STA   W88A4      ; =-42 [Store A relative]
88ce:      STA   W88A8      ; =-40 [Store A relative]
88d0:      STA   W88AC      ; =-38 [Store A relative]
88d2:      STAB/ B91AC      ; =0x91ac =37292(-28244) [Store AL direct]
88d5:      STAB  B8898      ; =-63 [Store AL relative]
88d7:      STA   W889A      ; =-63 [Store A relative]
88d9:      STAB  B889C      ; =-63 [Store AL relative]
88db:      STAB  B889F      ; =-62 [Store AL relative]
88dd:      JSR/  F9568      ; =0x9568 =38248(-27288) [Jump to subroutine direct]
88e0:      JSR   F88E7      ; =+5 [Jump to subroutine relative]
88e2:      JSR/  F91AD      ; =0x91ad =37293(-28243) [Jump to subroutine direct]
88e5:      JMP   F88B0      ; =-55 [Jump relative]
*
* Function F88E7
*
88e7:F88E7 LDAB+ Z          ; [Load AL from address in Z]
88e8:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
88ea:      SABB             ; [AL - BL -> BL]
88eb:      BNZ   D8903      ; =+22 [Branch if not zero]
88ed:      XFR   Z,A        ; [Transfer Z to A]
88ef:      STA   W88A0      ; =-81 [Store A relative]
88f1:      JSR   F8914      ; =+33 [Jump to subroutine relative]
88f3:      LDA   W88AE      ; =-71 [Load A relative]
88f5:      STA   W88A2      ; =-85 [Store A relative]
88f7:      CLA              ; [Clear A]
88f8:      STA   W88AC      ; =-78 [Store A relative]
88fa:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
88fc:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
88fe:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8900:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8902:      RSR              ; [Return from subroutine]
*
8903:D8903 JSR   F8925      ; =+32 [Jump to subroutine relative]
8905:      JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
8908:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
890a:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
890c:      SABB             ; [AL - BL -> BL]
890d:      BZ    D8913      ; =+4 [Branch if zero]
890f:      DCR   Z          ; [Decrement Z by 1]
8911:      JSR   F8914      ; =+1 [Jump to subroutine relative]
8913:D8913 RSR              ; [Return from subroutine]
*
* Function F8914
*
8914:F8914 XFR   Z,A        ; [Transfer Z to A]
8916:      STA   W88AC      ; =-108 [Store A relative]
8918:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
891a:D891A LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
891c:      SABB             ; [AL - BL -> BL]
891d:      BNZ   D891A      ; =-5 [Branch if not zero]
891f:      XFR   Z,A        ; [Transfer Z to A]
8921:      DCA              ; [Decrement A]
8922:      STA   W88AE      ; =-118 [Store A relative]
8924:      RSR              ; [Return from subroutine]
*
* Function F8925
*
8925:F8925 LDAB+ Z          ; [Load AL from address in Z]
8926:      JSR/  F9133      ; =0x9133 =37171(-28365) [Jump to subroutine direct]
8929:      BM    D8931      ; =+6 [Branch on minus]
892b:      JSR   F8942      ; =+21 [Jump to subroutine relative]
892d:      LDAB= X'01'      ; =1 [Load AL with immediate]
892f:      JMP   D8933      ; =+2 [Jump relative]
8931:D8931 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8933:D8933 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8935:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
8938:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
893a:      JSR   F8979      ; =+61 [Jump to subroutine relative]
893c:      XFR   Z,A        ; [Transfer Z to A]
893e:      STA/  W88AA      ; =0x88aa =34986(-30550) [Store A direct]
8941:      RSR              ; [Return from subroutine]
*
* Function F8942
*
8942:F8942 XFR   Z,A        ; [Transfer Z to A]
8944:      STA/  W88A0      ; =0x88a0 =34976(-30560) [Store A direct]
8947:      LDAB= X'01'      ; =1 [Load AL with immediate]
8949:      STAB/ B8890      ; =0x8890 =34960(-30576) [Store AL direct]
894c:      JSR/  F9050      ; =0x9050 =36944(-28592) [Jump to subroutine direct]
894f:      CLA              ; [Clear A]
8950:      STAB/ B8890      ; =0x8890 =34960(-30576) [Store AL direct]
8953:      XFR   Z,A        ; [Transfer Z to A]
8955:      STA/  W88A2      ; =0x88a2 =34978(-30558) [Store A direct]
8958:      LDA+  Y          ; [Load A from address in Y]
8959:      LDB+  A,2        ; [Load B indexed, displaced, direct]
895c:      LDBB= X'02'      ; =2 [Load BL with immediate]
895e:      ANDB  BU,BL      ; [BU & BL -> BL]
8960:      BNZ   D8978      ; =+22 [Branch if not zero]
8962:      LDBB= X'01'      ; =1 [Load BL with immediate]
8964:      ANDB  BU,BL      ; [BU & BL -> BL]
8966:      BZ    D8971      ; =+9 [Branch if zero]
8968:      LDBB/ B888F      ; =0x888f =34959(-30577) [Load BL direct]
896b:      BNZ   D8971      ; =+4 [Branch if not zero]
896d:      JSR/  F917E      ; =0x917e =37246(-28290) [Jump to subroutine direct]
8970:      RSR              ; [Return from subroutine]
*
8971:D8971 LDBB= X'01'      ; =1 [Load BL with immediate]
8973:      ORIB  BU,BL      ; [BU | BL -> BL]
8975:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
8978:D8978 RSR              ; [Return from subroutine]
*
* Function F8979
*
8979:F8979 JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
897c:      LDAB+ Z          ; [Load AL from address in Z]
897d:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
897f:      SABB             ; [AL - BL -> BL]
8980:      BNZ   D8988      ; =+6 [Branch if not zero]
8982:      CLA              ; [Clear A]
8983:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8985:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8987:      RSR              ; [Return from subroutine]
*
8988:D8988 XFR   Z,A        ; [Transfer Z to A]
898a:      STA/  W88A4      ; =0x88a4 =34980(-30556) [Store A direct]
898d:      JSR/  F9575      ; =0x9575 =38261(-27275) [Jump to subroutine direct]
8990:      LDAB+ Y          ; [Load AL from address in Y]
8991:      BM    D899F      ; =+12 [Branch on minus]
8993:      SRAB             ; [Right shift AL]
8994:      BL    D899B      ; =+5 [Branch on link]
8996:      JSR/  F8BA5      ; =0x8ba5 =35749(-29787) =VT,'%' [Jump to subroutine direct]
8999:      JMP   D89AF      ; =+20 [Jump relative]
899b:D899B JSR   F89C4      ; =+39 [Jump to subroutine relative]
899d:      DW    X'7310'    ; =0x7310 =29456
*
899f:D899F JSR/  F9152      ; =0x9152 =37202(-28334) [Jump to subroutine direct]
89a2:      XFR   Z,A        ; [Transfer Z to A]
89a4:      STA/  W88A6      ; =0x88a6 =34982(-30554) [Store A direct]
89a7:      CLA              ; [Clear A]
89a8:      STA+  Y          ; [Store A to address in Y]
89a9:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
89ab:      JSR/  F9184      ; =0x9184 =37252(-28284) [Jump to subroutine direct]
89ae:      RSR              ; [Return from subroutine]
*
89af:D89AF LDAB+ Z          ; [Load AL from address in Z]
89b0:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
89b2:      SABB             ; [AL - BL -> BL]
89b3:      BZ    D89B9      ; =+4 [Branch if zero]
89b5:      CLA              ; [Clear A]
89b6:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
89b8:      RSR              ; [Return from subroutine]
*
89b9:D89B9 INR   Z          ; [Increment Z by 1]
89bb:      JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
89be:      XFR   Z,A        ; [Transfer Z to A]
89c0:      STA/  W88AA      ; =0x88aa =34986(-30550) [Store A direct]
89c3:      RSR              ; [Return from subroutine]
*
* Function F89C4
*
89c4:F89C4 JSR*  D899F+1    ; =-38 [Jump to subroutine relative indirect]
89c6:      DW    X'5580'    ; =0x5580 =21888
89c8:      DC    '1'        ; hex:b1 dec:177(-79)
89c9:      DW    W88A6      ; =0x88a6 =34982(-30554)
89cb:      DB    X'7C'      ; =0x7c =124
89cc:      DC    '-'        ; hex:ad dec:173(-83)
89cd:      DW    X'5580'    ; =0x5580 =21888
89cf:      DC    '1'        ; hex:b1 dec:177(-79)
89d0:      DW    W88A8      ; =0x88a8 =34984(-30552)
89d2:      DW    X'8561'    ; =0x8561 =34145(-31391)
89d4:      DW    X'8561'    ; =0x8561 =34145(-31391)
89d6:      DW    X'2200'    ; =0x2200 =8704
89d8:      DB    X'3D'      ; =0x3d =61
89d9:      DC    'P'        ; hex:d0 dec:208(-48)
89da:      DW    W89DF      ; =0x89df =35295(-30241)
89dc:      DW    X'5875'    ; =0x5875 =22645
89de:      DB    X'24'      ; =0x24 =36
89df:W89DF DW    W89FB      ; =0x89fb =35323(-30213)
89e1:      DW    W89FF      ; =0x89ff =35327(-30209)
89e3:      DW    W8A25      ; =0x8a25 =35365(-30171)
89e5:      DW    W8A42      ; =0x8a42 =35394(-30142)
89e7:      DW    W8A4E      ; =0x8a4e =35406(-30130)
89e9:      DW    W8A55      ; =0x8a55 =35413(-30123)
89eb:      DW    W8A59      ; =0x8a59 =35417(-30119)
89ed:      DW    W8A6F      ; =0x8a6f =35439(-30097)
89ef:      DW    W8A99      ; =0x8a99 =35481(-30055)
89f1:      DW    W8AA6      ; =0x8aa6 =35494(-30042) =LF,'&'
89f3:      DW    W8AAA      ; =0x8aaa =35498(-30038) =LF,'*'
89f5:      DW    W8AB0      ; =0x8ab0 =35504(-30032) =LF,'0'
89f7:      DW    W8AED      ; =0x8aed =35565(-29971) =LF,'m'
89f9:      DW    W8B15      ; =0x8b15 =35605(-29931)
*
89fb:W89FB LDA+  Y+         ; [Load A indexed, direct, post-incremented]
89fd:      JMP   D8A13      ; =+20 [Jump relative]
89ff:W89FF LDAB= X'02'      ; =2 [Load AL with immediate]
8a01:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8a03:      LDBB+ Y          ; [Load BL from address in Y]
8a04:      BZ    D8A13      ; =+13 [Branch if zero]
8a06:      LDB+  Y,1        ; [Load B indexed, displaced, direct]
8a09:      XFRB  AL,AU      ; [Transfer AL to AU]
8a0b:      LDAB+ B,2        ; [Load AL indexed, displaced, direct]
8a0e:      ORIB  AU,AL      ; [AU | AL -> AL]
8a10:      STAB+ B,2        ; [Store AL indexed, displaced, direct]
8a13:D8A13 JSR*  P8A5C+1    ; =+72 [Jump to subroutine relative indirect]
8a15:      JSR*  P8A5F+1    ; =+73 [Jump to subroutine relative indirect]
8a17:      CLA              ; [Clear A]
8a18:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8a1a:      JSR   F8A39      ; =+29 [Jump to subroutine relative]
8a1c:P8A1C LDAB/ B8898      ; =0x8898 =34968(-30568) [Load AL direct]
8a1f:      BNZ   D8A24      ; =+3 [Branch if not zero]
8a21:      STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
8a24:D8A24 RSR              ; [Return from subroutine]
*
8a25:W8A25 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8a27:      JSR*  P8A5C+1    ; =+52 [Jump to subroutine relative indirect]
8a29:      LDA+  Y          ; [Load A from address in Y]
8a2a:P8A2A STA/  W889D      ; =0x889d =34973(-30563) [Store A direct]
8a2d:      LDAB* P8A1C+1    ; =-18 [Load AL relative indirect]
8a2f:      BNZ   D8A33      ; =+2 [Branch if not zero]
8a31:D8A31 JSR*  P8A3E+1    ; =+12 [Jump to subroutine relative indirect]
8a33:D8A33 JSR   F8A39      ; =+4 [Jump to subroutine relative]
8a35:D8A35 CLA              ; [Clear A]
8a36:D8A36 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8a38:      RSR              ; [Return from subroutine]
*
* Function F8A39
*
8a39:F8A39 LDA/  W889A      ; =0x889a =34970(-30566) [Load A direct]
8a3c:      BZ    D8A41      ; =+3 [Branch if zero]
8a3e:P8A3E JSR/  P916A      ; =0x916a =37226(-28310) [Jump to subroutine direct]
8a41:D8A41 RSR              ; [Return from subroutine]
*
8a42:W8A42 LDAB= X'01'      ; =1 [Load AL with immediate]
8a44:      STAB/ B889C      ; =0x889c =34972(-30564) [Store AL direct]
8a47:P8A47 JSR/  F8E23      ; =0x8e23 =36387(-29149) [Jump to subroutine direct]
8a4a:      CLA              ; [Clear A]
8a4b:      INA              ; [Increment A]
8a4c:      JMP   D8A36      ; =-24 [Jump relative]
8a4e:W8A4E JSR*  P8A47+1    ; =-8 [Jump to subroutine relative indirect]
8a50:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8a53:      JMP   D8A36      ; =-31 [Jump relative]
8a55:W8A55 JSR/  F8B65      ; =0x8b65 =35685(-29851) [Jump to subroutine direct]
8a58:      RSR              ; [Return from subroutine]
*
8a59:W8A59 JSR/  F92B3      ; =0x92b3 =37555(-27981) [Jump to subroutine direct]
8a5c:P8A5C JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
8a5f:P8A5F JSR/  F92A7      ; =0x92a7 =37543(-27993) [Jump to subroutine direct]
8a62:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8a64:      LDB*  P8A2A+1    ; =-59 [Load B relative indirect]
8a66:      AAB              ; [A + B -> B]
8a67:      STB*  P8A2A+1    ; =-62 [Store B relative indirect]
8a69:      LDAB* P8A1C+1    ; =-78 [Load AL relative indirect]
8a6b:      BZ    D8A33      ; =-58 [Branch if zero]
8a6d:      JMP   D8A31      ; =-62 [Jump relative]
8a6f:W8A6F LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8a71:      LDAB+ Y          ; [Load AL from address in Y]
8a72:      BZ    D8A86      ; =+18 [Branch if zero]
8a74:      LDA+  Y,1        ; [Load A indexed, displaced, direct]
8a77:      LDB+  A,2        ; [Load B indexed, displaced, direct]
8a7a:      LDBB= X'08'      ; =8 [Load BL with immediate]
8a7c:      ORIB  BU,BL      ; [BU | BL -> BL]
8a7e:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
8a81:      JSR/  F92ED      ; =0x92ed =37613(-27923) [Jump to subroutine direct]
8a84:      DW    W93F8      ; =0x93f8 =37880(-27656)
*
8a86:D8A86 JSR*  P8A5C+1    ; =-43 [Jump to subroutine relative indirect]
8a88:      LDA+  Y          ; [Load A from address in Y]
8a89:      STA*  P8A2A+1    ; =-96 [Store A relative indirect]
8a8b:      STA/  W93F3      ; =0x93f3 =37875(-27661) [Store A direct]
8a8e:      LDAB= X'05'      ; =5 [Load AL with immediate]
8a90:      JSR/  F93FE      ; =0x93fe =37886(-27650) [Jump to subroutine direct]
8a93:      CLA              ; [Clear A]
8a94:      STA/  W93F5      ; =0x93f5 =37877(-27659) [Store A direct]
8a97:      JMP   D8A33      ; =-102 [Jump relative]
8a99:W8A99 JSR*  W8A59+1    ; =-65 [Jump to subroutine relative indirect]
8a9b:      JSR*  P8A5C+1    ; =-64 [Jump to subroutine relative indirect]
8a9d:      JSR*  P8A5F+1    ; =-63 [Jump to subroutine relative indirect]
8a9f:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8aa1:      STA/  W888D      ; =0x888d =34957(-30579) [Store A direct]
8aa4:      JMP   D8A33      ; =-115 [Jump relative]
8aa6:W8AA6 LDAB= X'08'      ; =8 [Load AL with immediate]
8aa8:      JMP   D8AAC      ; =+2 [Jump relative]
8aaa:W8AAA LDAB= X'11'      ; =17 [Load AL with immediate]
8aac:D8AAC JSR   F8B20      ; =+114 [Jump to subroutine relative]
8aae:      JMP   D8A35      ; =-123 [Jump relative]
8ab0:W8AB0 LDA+  Z          ; [Load A from address in Z]
8ab1:      LDB=  X'CFCE'    ; =0xcfce =53198(-12338) ='O','N' [Load B with immediate]
8ab4:      SAB              ; [A - B -> B]
8ab5:      BNZ   D8ABB      ; =+4 [Branch if not zero]
8ab7:      LDBB= X'01'      ; =1 [Load BL with immediate]
8ab9:      JMP   D8AC1      ; =+6 [Jump relative]
8abb:D8ABB LDB=  X'CFC6'    ; =0xcfc6 =53190(-12346) ='O','F' [Load B with immediate]
8abe:      SAB              ; [A - B -> B]
8abf:      BNZ   D8AC6      ; =+5 [Branch if not zero]
8ac1:D8AC1 STBB/ B8891      ; =0x8891 =34961(-30575) [Store BL direct]
8ac4:      JMP   D8ADD      ; =+23 [Jump relative]
8ac6:D8AC6 LDB=  X'C3CF'    ; =0xc3cf =50127(-15409) ='C','O' [Load B with immediate]
8ac9:      SAB              ; [A - B -> B]
8aca:      BNZ   D8AD0      ; =+4 [Branch if not zero]
8acc:      LDBB= X'01'      ; =1 [Load BL with immediate]
8ace:      JMP   D8ADA      ; =+10 [Jump relative]
8ad0:D8AD0 LDB=  X'CECF'    ; =0xcecf =52943(-12593) ='N','O' [Load B with immediate]
8ad3:      SAB              ; [A - B -> B]
8ad4:      BZ    D8ADA      ; =+4 [Branch if zero]
8ad6:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8ad9:      RSR              ; [Return from subroutine]
*
8ada:D8ADA STBB/ B8892      ; =0x8892 =34962(-30574) [Store BL direct]
8add:D8ADD JSR/  F9152      ; =0x9152 =37202(-28334) [Jump to subroutine direct]
8ae0:      DW    X'8581'    ; =0x8581 =34177(-31359)
8ae2:      DC    '@,'       ; hex:c0ac dec:49324(-84)
8ae4:      DW    X'4914'    ; =0x4914 =18708
8ae6:      DC    'I'        ; hex:c9 dec:201(-55)
8ae7:      DW    X'3180'    ; =0x3180 =12672
8ae9:      DB    X'3A'      ; =0x3a =58
8aea:      DC    '5'        ; hex:b5 dec:181(-75)
8aeb:      DW    X'6209'    ; =0x6209 =25097
*
8aed:W8AED JSR   F8B65      ; =+118 [Jump to subroutine relative]
8aef:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
8af1:      ADD   X,Y        ; [X + Y -> Y]
8af3:      XFR   Y,A        ; [Transfer Y to A]
8af5:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8af7:      LDB=  X'0057'    ; =0x0057 =87 [Load B with immediate]
8afa:      SUB   X,B        ; [X - B -> B]
8afc:      BLE   W8B01      ; =+3 [Branch if less than or equal to zero]
8afe:      LDX=  X'0057'    ; =0x0057 =87 [Load X with immediate]
8b01:W8B01 LDA=  S82BC      ; =0x82bc =33468(-32068) [Load A with immediate]
8b04:D8B04 LDBB- Y-         ; [Load BL indexed, pre-decremented, direct]
8b06:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
8b08:      DCX              ; [Decrement X]
8b09:      BGZ   D8B04      ; =-7 [Branch if greater than zero]
8b0b:      LDB=  S8284      ; =0x8284 =33412(-32124) [Load B with immediate]
8b0e:      SAB              ; [A - B -> B]
8b0f:      STB/  W8282      ; =0x8282 =33410(-32126) [Store B direct]
8b12:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8b14:      XAY              ; [Transfer A to Y]
8b15:W8B15 CLA              ; [Clear A]
8b16:      STA/  W826B      ; =0x826b =33387(-32149) [Store A direct]
8b19:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8b1b:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8b1d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8b1f:      RSR              ; [Return from subroutine]
*
* Function F8B20
*
8b20:F8B20 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8b22:D8B22 LDAB+ Z          ; [Load AL from address in Z]
8b23:      JSR/  F9133      ; =0x9133 =37171(-28365) [Jump to subroutine direct]
8b26:      BM    D8B62      ; =+58 [Branch on minus]
8b28:      JSR/  F9050      ; =0x9050 =36944(-28592) [Jump to subroutine direct]
8b2b:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8b2d:      LDB+  A,2        ; [Load B indexed, displaced, direct]
8b30:      LDBB+ S          ; [Load BL from address in S]
8b31:      ORIB  BU,BL      ; [BU | BL -> BL]
8b33:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
8b36:      XFRB  BL,BU      ; [Transfer BL to BU]
8b38:      LDBB= X'01'      ; =1 [Load BL with immediate]
8b3a:      ANDB  BU,BL      ; [BU & BL -> BL]
8b3c:      BNZ   D8B43      ; =+5 [Branch if not zero]
8b3e:      JSR/  F919D      ; =0x919d =37277(-28259) [Jump to subroutine direct]
8b41:      JMP   D8B59      ; =+22 [Jump relative]
8b43:D8B43 LDBB= X'08'      ; =8 [Load BL with immediate]
8b45:      ANDB  BU,BL      ; [BU & BL -> BL]
8b47:      BZ    D8B59      ; =+16 [Branch if zero]
8b49:      JSR/  F92ED      ; =0x92ed =37613(-27923) [Jump to subroutine direct]
8b4c:      DW    W93F8      ; =0x93f8 =37880(-27656)
8b4e:      LDB+  A,3        ; [Load B indexed, displaced, direct]
8b51:      STB/  W93F3      ; =0x93f3 =37875(-27661) [Store B direct]
8b54:      LDAB= X'01'      ; =1 [Load AL with immediate]
8b56:      JSR/  F93FE      ; =0x93fe =37886(-27650) [Jump to subroutine direct]
8b59:D8B59 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8b5b:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8b5d:      SABB             ; [AL - BL -> BL]
8b5e:      BZ    D8B22      ; =-62 [Branch if zero]
8b60:      DCR   Z          ; [Decrement Z by 1]
8b62:D8B62 LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8b64:      RSR              ; [Return from subroutine]
*
* Function F8B65
*
8b65:F8B65 XFR   Z,A        ; [Transfer Z to A]
8b67:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8b69:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8b6b:      LDBB= X'C3'      ; =195(-61) ='C' [Load BL with immediate]
8b6d:      SABB             ; [AL - BL -> BL]
8b6e:      BNZ   D8B72      ; =+2 [Branch if not zero]
8b70:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8b72:D8B72 LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8b74:      SABB             ; [AL - BL -> BL]
8b75:      BZ    D8B81      ; =+10 [Branch if zero]
8b77:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8b79:      XAZ              ; [Transfer A to Z]
8b7a:      CLA              ; [Clear A]
8b7b:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8b7d:P8B7D JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8b80:      RSR              ; [Return from subroutine]
*
8b81:D8B81 STX+  S          ; [Store X indexed, direct]
8b83:      CLA              ; [Clear A]
8b84:      XAX              ; [Transfer A to X]
8b85:D8B85 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8b87:      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8b89:      SABB             ; [AL - BL -> BL]
8b8a:      BZ    D8B9C      ; =+16 [Branch if zero]
8b8c:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8b8e:      SABB             ; [AL - BL -> BL]
8b8f:      BNZ   D8B97      ; =+6 [Branch if not zero]
8b91:      LDBB+ Z          ; [Load BL from address in Z]
8b92:      SABB             ; [AL - BL -> BL]
8b93:      BNZ   D8BA0      ; =+11 [Branch if not zero]
8b95:      INR   Z          ; [Increment Z by 1]
8b97:D8B97 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8b99:      INX              ; [Increment X]
8b9a:      JMP   D8B85      ; =-23 [Jump relative]
8b9c:D8B9C DCR   Z          ; [Decrement Z by 1]
8b9e:      JSR*  P8B7D+1    ; =-34 [Jump to subroutine relative indirect]
8ba0:D8BA0 STX-  Y-         ; [Store X indexed, pre-decremented, direct]
8ba2:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8ba4:      RSR              ; [Return from subroutine]
*
* Function F8BA5
*
8ba5:F8BA5 LDAB+ Y          ; [Load AL from address in Y]
8ba6:      LDBB= X'02'      ; =2 [Load BL with immediate]
8ba8:      NABB             ; [AL & BL -> BL]
8ba9:      BZ    D8BC4      ; =+25 [Branch if zero]
8bab:      LDB+  Z          ; [Load B from address in Z]
8bac:      LDBB= X'C2'      ; =194(-62) ='B' [Load BL with immediate]
8bae:      SUBB  BU,BL      ; [BU - BL -> BL]
8bb0:      BNZ   D8BC4      ; =+18 [Branch if not zero]
8bb2:      INR   Z          ; [Increment Z by 1]
8bb4:      LDBB= X'01'      ; =1 [Load BL with immediate]
8bb6:      STBB/ B889C      ; =0x889c =34972(-30564) [Store BL direct]
8bb9:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
8bbc:      LDBB+ Y,1        ; [Load BL indexed, displaced, direct]
8bbf:      OREB  BU,BL      ; [BU ^ BL -> BL]
8bc1:      STBB+ Y,1        ; [Store BL indexed, displaced, direct]
8bc4:D8BC4 XFR   Z,B        ; [Transfer Z to B]
8bc6:      STB/  W88A6      ; =0x88a6 =34982(-30554) [Store B direct]
8bc9:      SRRB  AL,4       ; [Right shift AL by 4]
8bcb:      SLAB             ; [Left shift AL]
8bcc:      CLRB  AU         ; [Clear AU]
8bce:      LDB=  W8BDD      ; =0x8bdd =35805(-29731) =VT,']' [Load B with immediate]
8bd1:      AAB              ; [A + B -> B]
8bd2:      JSR+  *B         ; [Jump to subroutine indexed, indirect]
8bd4:      LDA+  Y          ; [Load A from address in Y]
8bd5:      DCA              ; [Decrement A]
8bd6:      DCA              ; [Decrement A]
8bd7:      BNZ   D8BDC      ; =+3 [Branch if not zero]
8bd9:      JSR/  F974D      ; =0x974d =38733(-26803) [Jump to subroutine direct]
8bdc:D8BDC RSR              ; [Return from subroutine]
*
8bdd:W8BDD DW    W8BE9      ; =0x8be9 =35817(-29719) =VT,'i'
8bdf:      DW    W8C08      ; =0x8c08 =35848(-29688)
8be1:      DW    W8C1E      ; =0x8c1e =35870(-29666)
8be3:      DW    W8C3C      ; =0x8c3c =35900(-29636)
8be5:      DW    W8C4A      ; =0x8c4a =35914(-29622)
8be7:      DW    W8D04      ; =0x8d04 =36100(-29436)
*
8be9:W8BE9 INR   Y          ; [Increment Y by 1]
8beb:      CLA              ; [Clear A]
8bec:      INA              ; [Increment A]
8bed:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8bef:      XFR   Z,A        ; [Transfer Z to A]
8bf1:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8bf3:P8BF3 JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
8bf6:      LDAB+ Z          ; [Load AL from address in Z]
8bf7:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8bf9:      SABB             ; [AL - BL -> BL]
8bfa:      BZ    D8C00      ; =+4 [Branch if zero]
8bfc:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8bfe:      XAZ              ; [Transfer A to Z]
8bff:      RSR              ; [Return from subroutine]
*
8c00:D8C00 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8c02:      XFR   Z,A        ; [Transfer Z to A]
8c04:      STA/  W88A8      ; =0x88a8 =34984(-30552) [Store A direct]
8c07:      RSR              ; [Return from subroutine]
*
8c08:W8C08 INR   Y          ; [Increment Y by 1]
8c0a:      JSR*  P8BF3+1    ; =-24 [Jump to subroutine relative indirect]
8c0c:      XFR   Z,A        ; [Transfer Z to A]
8c0e:      STA/  W88A8      ; =0x88a8 =34984(-30552) [Store A direct]
8c11:      JSR/  F8E90      ; =0x8e90 =36496(-29040) [Jump to subroutine direct]
8c14:      LDAB+ Y          ; [Load AL from address in Y]
8c15:      SLRB  AL,4       ; [Left shift AL by 4]
8c17:      STAB+ Y          ; [Store AL to address in Y]
8c18:D8C18 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8c1b:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8c1d:      RSR              ; [Return from subroutine]
*
8c1e:W8C1E JSR   W8C08      ; =-24 [Jump to subroutine relative]
8c20:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8c22:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8c24:      SABB             ; [AL - BL -> BL]
8c25:      BZ    D8C2C      ; =+5 [Branch if zero]
8c27:      DCR   Z          ; [Decrement Z by 1]
8c29:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8c2c:D8C2C JSR/  F8E90      ; =0x8e90 =36496(-29040) [Jump to subroutine direct]
8c2f:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8c31:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8c33:      XFRB  AL,AU      ; [Transfer AL to AU]
8c35:      LDAB+ Y          ; [Load AL from address in Y]
8c36:      ORIB  AU,AL      ; [AU | AL -> AL]
8c38:      STAB+ Y          ; [Store AL to address in Y]
8c39:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8c3b:      RSR              ; [Return from subroutine]
*
8c3c:W8C3C INR   Y          ; [Increment Y by 1]
8c3e:      JSR*  P8BF3+1    ; =-76 [Jump to subroutine relative indirect]
8c40:      XFR   Z,A        ; [Transfer Z to A]
8c42:      STA/  W88A8      ; =0x88a8 =34984(-30552) [Store A direct]
8c45:      JSR/  F8E4C      ; =0x8e4c =36428(-29108) [Jump to subroutine direct]
8c48:      JMP   D8C18      ; =-50 [Jump relative]
8c4a:W8C4A STX-  S-         ; [Store X indexed, pre-decremented, direct]
8c4c:      CLA              ; [Clear A]
8c4d:      STAB  B8CAB      ; =+92 [Store AL relative]
8c4f:      XAX              ; [Transfer A to X]
8c50:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8c52:      SRRB  AL,3       ; [Right shift AL by 3]
8c54:      BNL   D8C63      ; =+13 [Branch on no link]
8c56:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8c58:      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
8c5a:      SABB             ; [AL - BL -> BL]
8c5b:      BNZ   D8C65      ; =+8 [Branch if not zero]
8c5d:      LDBB= X'01'      ; =1 [Load BL with immediate]
8c5f:      STBB  B8CAB      ; =+74 [Store BL relative]
8c61:      JMP   D8C92      ; =+47 [Jump relative]
8c63:D8C63 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8c65:D8C65 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8c67:      STBB/ B889C      ; =0x889c =34972(-30564) [Store BL direct]
8c6a:      INX              ; [Increment X]
8c6b:      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
8c6d:      SABB             ; [AL - BL -> BL]
8c6e:      BZ    D8C92      ; =+34 [Branch if zero]
8c70:      INX              ; [Increment X]
8c71:      LDBB= X'A4'      ; =164(-92) ='$' [Load BL with immediate]
8c73:      SABB             ; [AL - BL -> BL]
8c74:      BZ    D8C92      ; =+28 [Branch if zero]
8c76:      INX              ; [Increment X]
8c77:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8c79:      SABB             ; [AL - BL -> BL]
8c7a:      BZ    D8CAC      ; =+48 [Branch if zero]
8c7c:      INX              ; [Increment X]
8c7d:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8c7f:      SABB             ; [AL - BL -> BL]
8c80:      BZ    D8CAC      ; =+42 [Branch if zero]
8c82:      INX              ; [Increment X]
8c83:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8c85:      SABB             ; [AL - BL -> BL]
8c86:      BZ    D8CBB      ; =+51 [Branch if zero]
8c88:      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
8c8a:      SABB             ; [AL - BL -> BL]
8c8b:      BZ    D8CBB      ; =+46 [Branch if zero]
8c8d:      JSR/  F9184      ; =0x9184 =37252(-28284) [Jump to subroutine direct]
8c90:      CLA              ; [Clear A]
8c91:      XAX              ; [Transfer A to X]
8c92:D8C92 STX-  Y-         ; [Store X indexed, pre-decremented, direct]
8c94:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8c96:      JSR   F8CC5      ; =+45 [Jump to subroutine relative]
8c98:      JSR/  F8E23      ; =0x8e23 =36387(-29149) [Jump to subroutine direct]
8c9b:      LDAB/ B889C      ; =0x889c =34972(-30564) [Load AL direct]
8c9e:      BNZ   D8CB5      ; =+21 [Branch if not zero]
8ca0:      LDAB  B8CAB      ; =+9 [Load AL relative]
8ca2:      BNZ   D8CA6      ; =+2 [Branch if not zero]
8ca4:      JSR   F8CD9      ; =+51 [Jump to subroutine relative]
8ca6:D8CA6 LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
8ca9:      JMP   D8CB8      ; =+13 [Jump relative]
*
8cab:B8CAB DB    X'00'      ; =0x00 =0 =NUL
*
8cac:D8CAC STX-  Y-         ; [Store X indexed, pre-decremented, direct]
8cae:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8cb0:      JSR   F8CC5      ; =+19 [Jump to subroutine relative]
8cb2:      JSR/  F8E4C      ; =0x8e4c =36428(-29108) [Jump to subroutine direct]
8cb5:D8CB5 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8cb8:D8CB8 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8cba:      RSR              ; [Return from subroutine]
*
8cbb:D8CBB STX-  Y-         ; [Store X indexed, pre-decremented, direct]
8cbd:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8cbf:      JSR   F8CC5      ; =+4 [Jump to subroutine relative]
8cc1:      JSR/  F8DB4      ; =0x8db4 =36276(-29260) =CR,'4' [Jump to subroutine direct]
8cc4:      RSR              ; [Return from subroutine]
*
* Function F8CC5
*
8cc5:F8CC5 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8cc7:      LDBB+ Y          ; [Load BL from address in Y]
8cc8:      ORIB  AL,BL      ; [AL | BL -> BL]
8cca:      STBB+ Y          ; [Store BL to address in Y]
8ccb:      XFR   Z,A        ; [Transfer Z to A]
8ccd:      STA/  W88A6      ; =0x88a6 =34982(-30554) [Store A direct]
8cd0:      JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
8cd3:      XFR   Z,A        ; [Transfer Z to A]
8cd5:      STA/  W88A8      ; =0x88a8 =34984(-30552) [Store A direct]
8cd8:      RSR              ; [Return from subroutine]
*
* Function F8CD9
*
8cd9:F8CD9 LDBB+ Y          ; [Load BL from address in Y]
8cda:      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8cdd:      XFRB  AL,BU      ; [Transfer AL to BU]
8cdf:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
8ce2:      INR   A,3        ; [Increment A by 3]
8ce4:      SUB   B,A        ; [B - A -> A]
8ce6:      LDB=  X'007F'    ; =0x007f =127 [Load B with immediate]
8ce9:      SAB              ; [A - B -> B]
8cea:      BGZ   D8D03      ; =+23 [Branch if greater than zero]
8cec:      LDB=  X'FF80'    ; =0xff80 =65408(-128) [Load B with immediate]
8cef:      SAB              ; [A - B -> B]
8cf0:      BM    D8D03      ; =+17 [Branch on minus]
8cf2:P8CF2 LDAB/ B97FC      ; =0x97fc =38908(-26628) [Load AL direct]
8cf5:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8cf7:      SABB             ; [AL - BL -> BL]
8cf8:      BNZ   D8D03      ; =+9 [Branch if not zero]
8cfa:      LDA/  W889A      ; =0x889a =34970(-30566) [Load A direct]
8cfd:      BNZ   D8D03      ; =+4 [Branch if not zero]
8cff:      LDBB= X'C9'      ; =201(-55) ='I' [Load BL with immediate]
8d01:      STBB* P8CF2+1    ; =-16 [Store BL relative indirect]
8d03:D8D03 RSR              ; [Return from subroutine]
*
8d04:W8D04 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8d06:      INR   Y          ; [Increment Y by 1]
8d08:      JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
8d0b:      XFR   Z,A        ; [Transfer Z to A]
8d0d:      STA/  W88A8      ; =0x88a8 =34984(-30552) [Store A direct]
8d10:      LDX=  W8D7C+1    ; =0x8d7d =36221(-29315) [Load X with immediate]
8d13:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8d15:D8D15 INR   X,3        ; [Increment X by 3]
8d17:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8d19:      BZ    D8D27      ; =+12 [Branch if zero]
8d1b:      SAB              ; [A - B -> B]
8d1c:      BNZ   D8D15      ; =-9 [Branch if not zero]
8d1e:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8d20:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8d22:      SABB             ; [AL - BL -> BL]
8d23:      BZ    D8D2E      ; =+9 [Branch if zero]
8d25:      DCR   Z          ; [Decrement Z by 1]
8d27:D8D27 JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8d2a:      CLRB  BL         ; [Clear BL]
8d2c:      JMP   D8D70      ; =+66 [Jump relative]
8d2e:D8D2E CLA              ; [Clear A]
8d2f:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8d31:      LDB=  W8D7A      ; =0x8d7a =36218(-29318) [Load B with immediate]
8d34:      AAB              ; [A + B -> B]
8d35:      CLA              ; [Clear A]
8d36:      JMP+  *B         ; [Jump indexed, indirect]
8d38:W8D38 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8d3a:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8d3c:      SABB             ; [AL - BL -> BL]
8d3d:      BZ    D8D44      ; =+5 [Branch if zero]
8d3f:      DCR   Z          ; [Decrement Z by 1]
8d41:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8d44:D8D44 JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
8d47:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8d49:      BP    D8D4E      ; =+3 [Branch on plus]
8d4b:D8D4B JSR/  P916A      ; =0x916a =37226(-28310) [Jump to subroutine direct]
8d4e:D8D4E LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
8d51:      SAB              ; [A - B -> B]
8d52:      BGZ   D8D4B      ; =-9 [Branch if greater than zero]
8d54:      SLR   A,4        ; [Left shift A by 4]
8d56:      JMP   W8D6E      ; =+22 [Jump relative]
8d58:W8D58 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8d5a:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8d5c:      SABB             ; [AL - BL -> BL]
8d5d:      BZ    D8D64      ; =+5 [Branch if zero]
8d5f:      DCR   Z          ; [Decrement Z by 1]
8d61:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8d64:D8D64 JSR/  F9160      ; =0x9160 =37216(-28320) [Jump to subroutine direct]
8d67:      JSR/  F8E90      ; =0x8e90 =36496(-29040) [Jump to subroutine direct]
8d6a:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8d6c:      SLRB  AL,4       ; [Left shift AL by 4]
8d6e:W8D6E LDBB+ X          ; [Load BL from address in X]
8d6f:      AABB             ; [AL + BL -> BL]
8d70:D8D70 STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
8d72:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8d75:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8d77:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8d79:      RSR              ; [Return from subroutine]
*
8d7a:W8D7A DW    W8D38      ; =0x8d38 =36152(-29384)
8d7c:W8D7C DW    W8D58      ; =0x8d58 =36184(-29352)
8d7e:      DW    W8D6E      ; =0x8d6e =36206(-29330)
8d80:      DC    'SAD'      ; hex:d3c1c4
8d83:      DW    X'0200'    ; =0x0200 =512
8d85:      DC    'RAD'      ; hex:d2c1c4
8d88:      DW    X'0201'    ; =0x0201 =513
8d8a:      DC    'SCT'      ; hex:d3c3d4
8d8d:      DW    X'0202'    ; =0x0202 =514
8d8f:      DC    'RCT'      ; hex:d2c3d4
8d92:      DW    X'0203'    ; =0x0203 =515
8d94:      DC    'SDV'      ; hex:d3c4d6
8d97:      DB    X'00'      ; =0x00 =0 =NUL
8d98:      DB    X'04'      ; =0x04 =4
8d99:      DC    'RDV'      ; hex:d2c4d6
8d9c:      DW    X'0205'    ; =0x0205 =517
8d9e:      DC    'EAB'      ; hex:c5c1c2
8da1:      DW    X'0406'    ; =0x0406 =1030
8da3:      DC    'DAB'      ; hex:c4c1c2
8da6:      DW    X'0407'    ; =0x0407 =1031
8da8:      DC    'SMN'      ; hex:d3cdce
8dab:      DW    X'0208'    ; =0x0208 =520
8dad:      DC    'RMN'      ; hex:d2cdce
8db0:      DW    X'0209'    ; =0x0209 =521
8db2:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F8DB4
*
8db4:F8DB4 CLAB             ; [Clear AL]
8db5:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8db7:      LDAB+ Z          ; [Load AL from address in Z]
8db8:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8dba:      SABB             ; [AL - BL -> BL]
8dbb:      BNZ   D8DC2      ; =+5 [Branch if not zero]
8dbd:      LDAB= X'04'      ; =4 [Load AL with immediate]
8dbf:      STAB+ Y          ; [Store AL to address in Y]
8dc0:      INR   Z          ; [Increment Z by 1]
8dc2:D8DC2 JSR/  F8EB3      ; =0x8eb3 =36531(-29005) [Jump to subroutine direct]
8dc5:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8dc7:      SLRB  AL,4       ; [Left shift AL by 4]
8dc9:      JSR   F8E1E      ; =+83 [Jump to subroutine relative]
8dcb:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8dcd:      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
8dcf:      SABB             ; [AL - BL -> BL]
8dd0:      BNZ   D8DD6      ; =+4 [Branch if not zero]
8dd2:      LDAB= X'01'      ; =1 [Load AL with immediate]
8dd4:      JMP   D8DDD      ; =+7 [Jump relative]
8dd6:D8DD6 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8dd8:      SABB             ; [AL - BL -> BL]
8dd9:      BNZ   D8DE1      ; =+6 [Branch if not zero]
8ddb:      LDAB= X'02'      ; =2 [Load AL with immediate]
8ddd:D8DDD JSR   F8E1E      ; =+63 [Jump to subroutine relative]
8ddf:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8de1:D8DE1 LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8de3:      SABB             ; [AL - BL -> BL]
8de4:      BZ    P8DEE      ; =+8 [Branch if zero]
8de6:      DCR   Z          ; [Decrement Z by 1]
8de8:D8DE8 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8deb:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8ded:      RSR              ; [Return from subroutine]
*
8dee:P8DEE JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
8df1:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8df3:      LDBB* D8E3F+1    ; =+75 [Load BL relative indirect]
8df5:      BNZ   P8E12      ; =+27 [Branch if not zero]
8df7:      LDB*  P8E44+1    ; =+76 [Load B relative indirect]
8df9:      BNZ   P8E12      ; =+23 [Branch if not zero]
8dfb:      XAB              ; [Transfer A to B]
8dfc:      BZ    D8DE8      ; =-22 [Branch if zero]
8dfe:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8e00:      LDAB= X'08'      ; =8 [Load AL with immediate]
8e02:      JSR   F8E1E      ; =+26 [Jump to subroutine relative]
8e04:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8e06:      LDB=  X'FF80'    ; =0xff80 =65408(-128) [Load B with immediate]
8e09:      AAB              ; [A + B -> B]
8e0a:      BNL   D8E16      ; =+10 [Branch on no link]
8e0c:      LDB=  X'0080'    ; =0x0080 =128 [Load B with immediate]
8e0f:      AAB              ; [A + B -> B]
8e10:      BL    D8E16      ; =+4 [Branch on link]
8e12:P8E12 JSR/  P916A      ; =0x916a =37226(-28310) [Jump to subroutine direct]
8e15:      CLA              ; [Clear A]
8e16:D8E16 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8e18:      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
8e1b:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8e1d:      RSR              ; [Return from subroutine]
*
* Function F8E1E
*
8e1e:F8E1E LDBB+ Y          ; [Load BL from address in Y]
8e1f:      ORIB  AL,BL      ; [AL | BL -> BL]
8e21:      STBB+ Y          ; [Store BL to address in Y]
8e22:      RSR              ; [Return from subroutine]
*
* Function F8E23
*
8e23:F8E23 JSR*  P8DEE+1    ; =-54 [Jump to subroutine relative indirect]
8e25:      LDAB/ B889C      ; =0x889c =34972(-30564) [Load AL direct]
8e28:      BNZ   D8E33      ; =+9 [Branch if not zero]
8e2a:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8e2c:      XFRB  AU,BL      ; [Transfer AU to BL]
8e2e:      STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
8e30:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8e32:      RSR              ; [Return from subroutine]
*
8e33:D8E33 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8e35:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8e37:      XFRB  AU,BL      ; [Transfer AU to BL]
8e39:      BZ    D8E3F      ; =+4 [Branch if zero]
8e3b:      INRB  AU         ; [Increment AU by 1]
8e3d:      BNZ   D8E49      ; =+10 [Branch if not zero]
8e3f:D8E3F LDAB/ B8898      ; =0x8898 =34968(-30568) [Load AL direct]
8e42:      BNZ   D8E49      ; =+5 [Branch if not zero]
8e44:P8E44 LDA/  W889A      ; =0x889a =34970(-30566) [Load A direct]
8e47:      BZ    D8E4B      ; =+2 [Branch if zero]
8e49:D8E49 JSR*  P8E12+1    ; =-56 [Jump to subroutine relative indirect]
8e4b:D8E4B RSR              ; [Return from subroutine]
*
* Function F8E4C
*
8e4c:F8E4C JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
8e4f:      LDAB* D8E3F+1    ; =-17 [Load AL relative indirect]
8e51:      BZ    D8E57      ; =+4 [Branch if zero]
8e53:      LDA*  P8E44+1    ; =-16 [Load A relative indirect]
8e55:      BZ    D8E62      ; =+11 [Branch if zero]
8e57:D8E57 JSR*  P8E12+1    ; =-70 [Jump to subroutine relative indirect]
8e59:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8e5b:      CLA              ; [Clear A]
8e5c:      STAB* D8E3F+1    ; =-30 [Store AL relative indirect]
8e5e:      STA*  P8E44+1    ; =-27 [Store A relative indirect]
8e60:      JMP   D8E8D      ; =+43 [Jump relative]
8e62:D8E62 STAB/ B8898      ; =0x8898 =34968(-30568) [Store AL direct]
8e65:      LDAB+ Y          ; [Load AL from address in Y]
8e66:P8E66 JSR/  F92CD      ; =0x92cd =37581(-27955) [Jump to subroutine direct]
8e69:      STB/  W97F7      ; =0x97f7 =38903(-26633) [Store B direct]
8e6c:      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8e6f:      JSR*  P8E66+1    ; =-10 [Jump to subroutine relative indirect]
8e71:      STB/  W97F9      ; =0x97f9 =38905(-26631) [Store B direct]
8e74:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
8e77:      INA              ; [Increment A]
8e78:      INA              ; [Increment A]
8e79:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8e7b:      SUB   B,A        ; [B - A -> A]
8e7d:      LDB=  X'FF80'    ; =0xff80 =65408(-128) [Load B with immediate]
8e80:      AAB              ; [A + B -> B]
8e81:      BNL   D8E8D      ; =+10 [Branch on no link]
8e83:      LDB=  X'0080'    ; =0x0080 =128 [Load B with immediate]
8e86:      AAB              ; [A + B -> B]
8e87:      BL    D8E8D      ; =+4 [Branch on link]
8e89:      JSR/  F918A      ; =0x918a =37258(-28278) [Jump to subroutine direct]
8e8c:      CLAB             ; [Clear AL]
8e8d:D8E8D STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
8e8f:      RSR              ; [Return from subroutine]
*
* Function F8E90
*
8e90:F8E90 JSR   F8EB3      ; =+33 [Jump to subroutine relative]
8e92:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8e94:      LDBB= X'D5'      ; =213(-43) ='U' [Load BL with immediate]
8e96:      SABB             ; [AL - BL -> BL]
8e97:      BZ    D8EB2      ; =+25 [Branch if zero]
8e99:      LDBB= X'CC'      ; =204(-52) ='L' [Load BL with immediate]
8e9b:      SABB             ; [AL - BL -> BL]
8e9c:      BZ    D8EA7      ; =+9 [Branch if zero]
8e9e:      DCR   Z          ; [Decrement Z by 1]
8ea0:      LDAB/ B889C      ; =0x889c =34972(-30564) [Load AL direct]
8ea3:      BZ    D8EB2      ; =+13 [Branch if zero]
8ea5:      JMP   D8EAF      ; =+8 [Jump relative]
8ea7:D8EA7 LDAB/ B889C      ; =0x889c =34972(-30564) [Load AL direct]
8eaa:      BNZ   D8EAF      ; =+3 [Branch if not zero]
8eac:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8eaf:D8EAF LDAB+ Y          ; [Load AL from address in Y]
8eb0:      INAB             ; [Increment AL]
8eb1:      STAB+ Y          ; [Store AL to address in Y]
8eb2:D8EB2 RSR              ; [Return from subroutine]
*
* Function F8EB3
*
8eb3:F8EB3 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8eb5:      XFRB  BL,BU      ; [Transfer BL to BU]
8eb7:      LDA=  S8ED4      ; =0x8ed4 =36564(-28972) [Load A with immediate]
8eba:D8EBA LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
8ebc:      BNZ   D8EC7      ; =+9 [Branch if not zero]
8ebe:      JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8ec1:      DCR   Z          ; [Decrement Z by 1]
8ec3:      CLR   B          ; [Clear B]
8ec5:      JMP   D8ED1      ; =+10 [Jump relative]
8ec7:D8EC7 SUBB  BU,BL      ; [BU - BL -> BL]
8ec9:      BNZ   D8EBA      ; =-17 [Branch if not zero]
8ecb:      LDB=  S8ED5      ; =0x8ed5 =36565(-28971) [Load B with immediate]
8ece:      SAB              ; [A - B -> B]
8ecf:      SLR   B          ; [Left shift B by 1]
8ed1:D8ED1 STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
8ed3:      RSR              ; [Return from subroutine]
*
8ed4:S8ED4 DC    'A'        ; hex:c1 dec:193(-63)
8ed5:S8ED5 DC    'BXYZSCP'  ; hex:c2d8d9dad3c3d0
8edc:      DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F8EDD
*
8edd:F8EDD JSR   F8F08      ; =+41 [Jump to subroutine relative]
8edf:      LDA+  Z          ; [Load A from address in Z]
8ee0:      LDB=  X'AECF'    ; =0xaecf =44751(-20785) ='.','O' [Load B with immediate]
8ee3:      SAB              ; [A - B -> B]
8ee4:      BNZ   D8EEE      ; =+8 [Branch if not zero]
8ee6:      JSR   F8EFC      ; =+20 [Jump to subroutine relative]
8ee8:      DW    X'5302'    ; =0x5302 =21250
8eea:      DC    'u'        ; hex:f5 dec:245(-11)
8eeb:      DW    X'6273'    ; =0x6273 =25203
8eed:      DC    'q'        ; hex:f1 dec:241(-15)
*
8eee:D8EEE LDB=  X'AED8'    ; =0xaed8 =44760(-20776) ='.','X' [Load B with immediate]
8ef1:      SAB              ; [A - B -> B]
8ef2:      BNZ   D8F07      ; =+19 [Branch if not zero]
8ef4:      JSR   F8EFC      ; =+6 [Jump to subroutine relative]
8ef6:      DW    X'5402'    ; =0x5402 =21506
8ef8:      DC    'u'        ; hex:f5 dec:245(-11)
8ef9:      DW    X'6273'    ; =0x6273 =25203
8efb:      DC    'c'        ; hex:e3 dec:227(-29)
*
* Function F8EFC
*
8efc:F8EFC INR   Z          ; [Increment Z by 1]
8efe:P8EFE JSR/  F9152      ; =0x9152 =37202(-28334) [Jump to subroutine direct]
8f01:      DW    X'7B05'    ; =0x7b05 =31493
8f03:      DC    'U'        ; hex:d5 dec:213(-43)
8f04:      DW    X'6195'    ; =0x6195 =24981
8f06:      DB    X'61'      ; =0x61 =97
*
8f07:D8F07 RSR              ; [Return from subroutine]
*
* Function F8F08
*
8f08:F8F08 JSR   F8F21      ; =+23 [Jump to subroutine relative]
8f0a:      LDA+  Z          ; [Load A from address in Z]
8f0b:      LDB=  X'AEC1'    ; =0xaec1 =44737(-20799) ='.','A' [Load B with immediate]
8f0e:      SAB              ; [A - B -> B]
8f0f:      BNZ   D8F20      ; =+15 [Branch if not zero]
8f11:      INR   Z          ; [Increment Z by 1]
8f13:      JSR*  P8EFE+1    ; =-22 [Jump to subroutine relative indirect]
8f15:      DW    X'7B0A'    ; =0x7b0a =31498
8f17:      DC    'U'        ; hex:d5 dec:213(-43)
8f18:      DW    X'6195'    ; =0x6195 =24981
8f1a:      DW    X'615A'    ; =0x615a =24922
8f1c:      DC    'u'        ; hex:f5 dec:245(-11)
8f1d:      DW    X'6273'    ; =0x6273 =25203
8f1f:      DC    'j'        ; hex:ea dec:234(-22)
*
8f20:D8F20 RSR              ; [Return from subroutine]
*
* Function F8F21
*
8f21:F8F21 LDA+  Z          ; [Load A from address in Z]
8f22:      LDB=  X'AECE'    ; =0xaece =44750(-20786) ='.','N' [Load B with immediate]
8f25:      SAB              ; [A - B -> B]
8f26:      BNZ   D8F32      ; =+10 [Branch if not zero]
8f28:      INR   Z          ; [Increment Z by 1]
8f2a:      JSR*  P8EFE+1    ; =-45 [Jump to subroutine relative indirect]
8f2c:      DW    X'7B07'    ; =0x7b07 =31495
8f2e:      DW    X'9B3B'    ; =0x9b3b =39739(-25797)
8f30:      DC    ';'        ; hex:bb dec:187(-69)
8f31:      DB    X'09'      ; =0x09 =9
*
8f32:D8F32 JSR   F8F35      ; =+1 [Jump to subroutine relative]
8f34:      RSR              ; [Return from subroutine]
*
* Function F8F35
*
8f35:F8F35 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f37:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8f39:      SABB             ; [AL - BL -> BL]
8f3a:      BNZ   D8F44      ; =+8 [Branch if not zero]
8f3c:      JSR   F8F71      ; =+51 [Jump to subroutine relative]
8f3e:      LDA+  Y          ; [Load A from address in Y]
8f3f:      IVA              ; [Invert A]
8f40:      INA              ; [Increment A]
8f41:      STA+  Y          ; [Store A to address in Y]
8f42:      JMP   D8F4D      ; =+9 [Jump relative]
8f44:D8F44 LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
8f46:      SABB             ; [AL - BL -> BL]
8f47:      BZ    D8F4B      ; =+2 [Branch if zero]
8f49:      DCR   Z          ; [Decrement Z by 1]
8f4b:D8F4B JSR   F8F71      ; =+36 [Jump to subroutine relative]
8f4d:D8F4D LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f4f:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8f51:      SABB             ; [AL - BL -> BL]
8f52:      BNZ   D8F5B      ; =+7 [Branch if not zero]
8f54:      JSR   F8F67      ; =+17 [Jump to subroutine relative]
8f56:      SAB              ; [A - B -> B]
8f57:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8f59:      JMP   D8F4D      ; =-14 [Jump relative]
8f5b:D8F5B LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
8f5d:      SABB             ; [AL - BL -> BL]
8f5e:      BNZ   D8F6E      ; =+14 [Branch if not zero]
8f60:      JSR   F8F67      ; =+5 [Jump to subroutine relative]
8f62:      AAB              ; [A + B -> B]
8f63:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8f65:      JMP   D8F4D      ; =-26 [Jump relative]
*
* Function F8F67
*
8f67:F8F67 JSR   F8F71      ; =+8 [Jump to subroutine relative]
8f69:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8f6b:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8f6d:      RSR              ; [Return from subroutine]
*
8f6e:D8F6E DCR   Z          ; [Decrement Z by 1]
8f70:      RSR              ; [Return from subroutine]
*
* Function F8F71
*
8f71:F8F71 JSR   F8FB1      ; =+62 [Jump to subroutine relative]
8f73:D8F73 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f75:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8f77:      SABB             ; [AL - BL -> BL]
8f78:      BNZ   D8F83      ; =+9 [Branch if not zero]
8f7a:      JSR   F8FA7      ; =+43 [Jump to subroutine relative]
8f7c:      JSR/  F827C      ; =0x827c =33404(-32132) [Jump to subroutine direct]
8f7f:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8f81:      JMP   D8F73      ; =-16 [Jump relative]
8f83:D8F83 LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
8f85:      SABB             ; [AL - BL -> BL]
8f86:      BNZ   D8F91      ; =+9 [Branch if not zero]
8f88:      JSR   F8FA7      ; =+29 [Jump to subroutine relative]
8f8a:      JSR/  F827F      ; =0x827f =33407(-32129) [Jump to subroutine direct]
8f8d:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8f8f:      JMP   D8F73      ; =-30 [Jump relative]
8f91:D8F91 LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
8f93:      SABB             ; [AL - BL -> BL]
8f94:      BNZ   D8FAE      ; =+24 [Branch if not zero]
8f96:      LDAB+ Z          ; [Load AL from address in Z]
8f97:      LDBB= X'CD'      ; =205(-51) ='M' [Load BL with immediate]
8f99:      SABB             ; [AL - BL -> BL]
8f9a:      BNZ   D8FAE      ; =+18 [Branch if not zero]
8f9c:      JSR/  F9152      ; =0x9152 =37202(-28334) [Jump to subroutine direct]
8f9f:      DW    X'7B06'    ; =0x7b06 =31494
8fa1:      DB    X'7C'      ; =0x7c =124
8fa2:      DC    'h5'       ; hex:e8b5 dec:59573(-75)
8fa4:      DW    X'6273'    ; =0x6273 =25203
8fa6:      DC    'L'        ; hex:cc dec:204(-52)
*
*
* Function F8FA7
*
8fa7:F8FA7 JSR   F8FB1      ; =+8 [Jump to subroutine relative]
8fa9:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8fab:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8fad:      RSR              ; [Return from subroutine]
*
8fae:D8FAE DCR   Z          ; [Decrement Z by 1]
8fb0:      RSR              ; [Return from subroutine]
*
* Function F8FB1
*
8fb1:F8FB1 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8fb3:      LDBB= X'A8'      ; =168(-88) ='(' [Load BL with immediate]
8fb5:      SABB             ; [AL - BL -> BL]
8fb6:      BNZ   D8FC0      ; =+8 [Branch if not zero]
8fb8:      JSR/  F8EDD      ; =0x8edd =36573(-28963) [Jump to subroutine direct]
8fbb:      JSR/  F9146      ; =0x9146 =37190(-28346) [Jump to subroutine direct]
8fbe:      DC    ')'        ; hex:a9 dec:169(-87)
8fbf:      RSR              ; [Return from subroutine]
*
8fc0:D8FC0 CLR   B          ; [Clear B]
8fc2:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
8fc4:      JSR/  F9127      ; =0x9127 =37159(-28377) [Jump to subroutine direct]
8fc7:      BM    D8FCF      ; =+6 [Branch on minus]
8fc9:      DCR   Z          ; [Decrement Z by 1]
8fcb:      JSR/  F90F2      ; =0x90f2 =37106(-28430) [Jump to subroutine direct]
8fce:      RSR              ; [Return from subroutine]
*
8fcf:D8FCF LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8fd1:      XFRB  BL,BU      ; [Transfer BL to BU]
8fd3:      SABB             ; [AL - BL -> BL]
8fd4:      BZ    D8FF9      ; =+35 [Branch if zero]
8fd6:      LDBB+ Z          ; [Load BL from address in Z]
8fd7:      SUBB  BU,BL      ; [BU - BL -> BL]
8fd9:      BNZ   D9001      ; =+38 [Branch if not zero]
8fdb:      INR   Z          ; [Increment Z by 1]
8fdd:      LDBB= X'D8'      ; =216(-40) ='X' [Load BL with immediate]
8fdf:      SABB             ; [AL - BL -> BL]
8fe0:      BNZ   D8FE7      ; =+5 [Branch if not zero]
8fe2:      JSR/  F90D2      ; =0x90d2 =37074(-28462) [Jump to subroutine direct]
8fe5:      JMP   D8FFC      ; =+21 [Jump relative]
8fe7:D8FE7 LDBB= X'C2'      ; =194(-62) ='B' [Load BL with immediate]
8fe9:      SABB             ; [AL - BL -> BL]
8fea:      BNZ   D8FF1      ; =+5 [Branch if not zero]
8fec:      JSR/  F90BD      ; =0x90bd =37053(-28483) [Jump to subroutine direct]
8fef:      JMP   D8FFC      ; =+11 [Jump relative]
8ff1:D8FF1 LDBB= X'C3'      ; =195(-61) ='C' [Load BL with immediate]
8ff3:      SABB             ; [AL - BL -> BL]
8ff4:      BZ    D8FF9      ; =+3 [Branch if zero]
8ff6:P8FF6 JSR/  F9197      ; =0x9197 =37271(-28265) [Jump to subroutine direct]
8ff9:D8FF9 JSR/  F910B      ; =0x910b =37131(-28405) [Jump to subroutine direct]
8ffc:D8FFC JSR/  F9146      ; =0x9146 =37190(-28346) [Jump to subroutine direct]
8fff:      DB    X'A7'      ; =0xa7 =167(-89) ='
9000:      RSR              ; [Return from subroutine]
*
9001:D9001 DCR   Z          ; [Decrement Z by 1]
9003:      JSR   F9006      ; =+1 [Jump to subroutine relative]
9005:      RSR              ; [Return from subroutine]
*
* Function F9006
*
9006:F9006 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9008:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
900a:      SABB             ; [AL - BL -> BL]
900b:      BNZ   D9013      ; =+6 [Branch if not zero]
900d:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
9010:      STA+  Y          ; [Store A to address in Y]
9011:      JMP   D9049      ; =+54 [Jump relative]
9013:D9013 DCR   Z          ; [Decrement Z by 1]
9015:      JSR/  F9133      ; =0x9133 =37171(-28365) [Jump to subroutine direct]
9018:      BP    D901D      ; =+3 [Branch on plus]
901a:      JSR*  P8FF6+1    ; =-37 [Jump to subroutine relative indirect]
901c:      RSR              ; [Return from subroutine]
*
901d:D901D JSR   F9050      ; =+49 [Jump to subroutine relative]
901f:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
9021:      LDA+  B,3        ; [Load A indexed, displaced, direct]
9024:      STA+  Y          ; [Store A to address in Y]
9025:      LDA+  B,2        ; [Load A indexed, displaced, direct]
9028:      LDAB= X'20'      ; =32 [Load AL with immediate]
902a:      ORIB  AU,AL      ; [AU | AL -> AL]
902c:      STAB+ B,2        ; [Store AL indexed, displaced, direct]
902f:      LDAB= X'01'      ; =1 [Load AL with immediate]
9031:      ANDB  AU,AL      ; [AU & AL -> AL]
9033:      BNZ   D9039      ; =+4 [Branch if not zero]
9035:      JSR/  F919D      ; =0x919d =37277(-28259) [Jump to subroutine direct]
9038:      RSR              ; [Return from subroutine]
*
9039:D9039 LDAB= X'10'      ; =16 [Load AL with immediate]
903b:      ANDB  AU,AL      ; [AU & AL -> AL]
903d:      BZ    D9042      ; =+3 [Branch if zero]
903f:      STB/  W889A      ; =0x889a =34970(-30566) [Store B direct]
9042:D9042 LDAB= X'04'      ; =4 [Load AL with immediate]
9044:      ANDB  AU,AL      ; [AU & AL -> AL]
9046:      BNZ   D9049      ; =+1 [Branch if not zero]
9048:      RSR              ; [Return from subroutine]
*
9049:D9049 LDAB/ B8898      ; =0x8898 =34968(-30568) [Load AL direct]
904c:      IVAB             ; [Invert AL]
904d:      STAB* D9049+1    ; =-5 [Store AL relative indirect]
904f:      RSR              ; [Return from subroutine]
*
* Function F9050
*
9050:F9050 XFR   Z,A        ; [Transfer Z to A]
9052:      STA   W90B6      ; =+98 [Store A relative]
9054:D9054 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9056:      JSR/  F913F      ; =0x913f =37183(-28353) [Jump to subroutine direct]
9059:      BP    D9054      ; =-7 [Branch on plus]
905b:      DCR   Z          ; [Decrement Z by 1]
905d:      LDA   W90B6      ; =+87 [Load A relative]
905f:      SUB   Z,A        ; [Z - A -> A]
9061:      STA   W90B8      ; =+85 [Store A relative]
9063:      JSR   F90B2      ; =+77 [Jump to subroutine relative]
9065:      DW    W8786      ; =0x8786 =34694(-30842)
9067:      LDA   W90BA      ; =+81 [Load A relative]
9069:      BNZ   D9081      ; =+22 [Branch if not zero]
906b:      JSR   F90B2      ; =+69 [Jump to subroutine relative]
906d:      DW    W8730      ; =0x8730 =34608(-30928)
906f:      LDA   W90BA      ; =+73 [Load A relative]
9071:      BNZ   D9079      ; =+6 [Branch if not zero]
9073:      JSR/  F9178      ; =0x9178 =37240(-28296) [Jump to subroutine direct]
9076:      LDA=  W8893      ; =0x8893 =34963(-30573) [Load A with immediate]
9079:D9079 CLR   B          ; [Clear B]
907b:      STB+  A,3        ; [Store B indexed, displaced, direct]
907e:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
9081:D9081 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
9083:      LDAB/ B8890      ; =0x8890 =34960(-30576) [Load AL direct]
9086:      BNZ   D908D      ; =+5 [Branch if not zero]
9088:      LDAB/ B888F      ; =0x888f =34959(-30577) [Load AL direct]
908b:      BNZ   D908E      ; =+1 [Branch if not zero]
908d:D908D RSR              ; [Return from subroutine]
*
908e:D908E STA   W90AC      ; =+28 [Store A relative]
9090:      STB   W90AE      ; =+28 [Store B relative]
9092:      XFR   Y,A        ; [Transfer Y to A]
9094:      STA   W90B0      ; =+26 [Store A relative]
9096:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
9099:      LDB=  W86C3      ; =0x86c3 =34499(-31037) [Load B with immediate]
909c:      STA+  B+         ; [Store A indexed, direct, post-incremented]
909e:      LDA   W90BA      ; =+26 [Load A relative]
90a0:      STA+  B          ; [Store A to address in B]
90a1:      JSR/  F81CD      ; =0x81cd =33229(-32307) [Jump to subroutine direct]
90a4:      LDA   W90B0      ; =+10 [Load A relative]
90a6:      XAY              ; [Transfer A to Y]
90a7:      LDA   W90AC      ; =+3 [Load A relative]
90a9:      LDB   W90AE      ; =+3 [Load B relative]
90ab:      RSR              ; [Return from subroutine]
*
90ac:W90AC DS    2          ; =0x0002 [Uninitialized memory]
90ae:W90AE DS    2          ; =0x0002 [Uninitialized memory]
90b0:W90B0 DS    2          ; =0x0002 [Uninitialized memory]
*
* Function F90B2
*
90b2:F90B2 LDA+  X+         ; [Load A indexed, direct, post-incremented]
90b4:      JSR+  A          ; [Jump to subroutine indexed, direct]
90b6:W90B6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
90b8:W90B8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
90ba:W90BA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
90bc:      RSR              ; [Return from subroutine]
*
* Function F90BD
*
90bd:F90BD LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
90bf:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
90c1:      SABB             ; [AL - BL -> BL]
90c2:      BZ    D90C8      ; =+4 [Branch if zero]
90c4:      DCRB  BL         ; [Decrement BL by 1]
90c6:      BNZ   D90CF      ; =+7 [Branch if not zero]
90c8:D90C8 LDB+  Y          ; [Load B from address in Y]
90c9:      SRAB             ; [Right shift AL]
90ca:      RLR   B          ; [Left rotate B by 1]
90cc:      STB+  Y          ; [Store B to address in Y]
90cd:      JMP   F90BD      ; =-18 [Jump relative]
90cf:D90CF DCR   Z          ; [Decrement Z by 1]
90d1:      RSR              ; [Return from subroutine]
*
* Function F90D2
*
90d2:F90D2 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
90d4:      JSR   F9127      ; =+81 [Jump to subroutine relative]
90d6:      BM    D90E0      ; =+8 [Branch on minus]
90d8:D90D8 LDA+  Y          ; [Load A from address in Y]
90d9:      SLR   A,4        ; [Left shift A by 4]
90db:      ORIB  BL,AL      ; [BL | AL -> AL]
90dd:      STA+  Y          ; [Store A to address in Y]
90de:      JMP   F90D2      ; =-14 [Jump relative]
90e0:D90E0 LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
90e2:      SABB             ; [AL - BL -> BL]
90e3:      BGZ   D90EF      ; =+10 [Branch if greater than zero]
90e5:      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
90e7:      SABB             ; [AL - BL -> BL]
90e8:      BM    D90EF      ; =+5 [Branch on minus]
90ea:      LDAB= X'0A'      ; =10 [Load AL with immediate]
90ec:      AABB             ; [AL + BL -> BL]
90ed:      JMP   D90D8      ; =-23 [Jump relative]
90ef:D90EF DCR   Z          ; [Decrement Z by 1]
90f1:      RSR              ; [Return from subroutine]
*
* Function F90F2
*
90f2:F90F2 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
90f4:      JSR   F9127      ; =+49 [Jump to subroutine relative]
90f6:      BM    D9108      ; =+16 [Branch on minus]
90f8:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
90fa:      LDA+  Y          ; [Load A from address in Y]
90fb:      SLA              ; [Left shift A]
90fc:      SLA              ; [Left shift A]
90fd:      LDB+  Y          ; [Load B from address in Y]
90fe:      AAB              ; [A + B -> B]
90ff:      SLR   B          ; [Left shift B by 1]
9101:      CLA              ; [Clear A]
9102:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9104:      AAB              ; [A + B -> B]
9105:      STB+  Y          ; [Store B to address in Y]
9106:      JMP   F90F2      ; =-22 [Jump relative]
9108:D9108 DCR   Z          ; [Decrement Z by 1]
910a:      RSR              ; [Return from subroutine]
*
* Function F910B
*
910b:F910B LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
910d:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
910f:      SABB             ; [AL - BL -> BL]
9110:      BNZ   D9118      ; =+6 [Branch if not zero]
9112:      LDBB+ Z          ; [Load BL from address in Z]
9113:      SABB             ; [AL - BL -> BL]
9114:      BNZ   D9124      ; =+14 [Branch if not zero]
9116:      INR   Z          ; [Increment Z by 1]
9118:D9118 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
911a:      SABB             ; [AL - BL -> BL]
911b:      BZ    D9124      ; =+7 [Branch if zero]
911d:      LDB+  Y          ; [Load B from address in Y]
911e:      XFRB  BL,BU      ; [Transfer BL to BU]
9120:      XABB             ; [Transfer AL to BL]
9121:      STB+  Y          ; [Store B to address in Y]
9122:      JMP   F910B      ; =-25 [Jump relative]
9124:D9124 DCR   Z          ; [Decrement Z by 1]
9126:      RSR              ; [Return from subroutine]
*
* Function F9127
*
9127:F9127 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
9129:      SABB             ; [AL - BL -> BL]
912a:      BLE   D912F      ; =+3 [Branch if less than or equal to zero]
912c:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
912e:      RSR              ; [Return from subroutine]
*
912f:D912F LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
9131:      SABB             ; [AL - BL -> BL]
9132:      RSR              ; [Return from subroutine]
*
* Function F9133
*
9133:F9133 LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
9135:      SABB             ; [AL - BL -> BL]
9136:      BLE   D913B      ; =+3 [Branch if less than or equal to zero]
9138:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
913a:      RSR              ; [Return from subroutine]
*
913b:D913B LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
913d:      SABB             ; [AL - BL -> BL]
913e:      RSR              ; [Return from subroutine]
*
* Function F913F
*
913f:F913F JSR   F9133      ; =-14 [Jump to subroutine relative]
9141:      BP    D9145      ; =+2 [Branch on plus]
9143:      JSR   F9127      ; =-30 [Jump to subroutine relative]
9145:D9145 RSR              ; [Return from subroutine]
*
* Function F9146
*
9146:F9146 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9148:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
914a:      SABB             ; [AL - BL -> BL]
914b:      BZ    D9151      ; =+4 [Branch if zero]
914d:      DCR   Z          ; [Decrement Z by 1]
914f:      JSR   F9197      ; =+70 [Jump to subroutine relative]
9151:D9151 RSR              ; [Return from subroutine]
*
* Function F9152
*
9152:F9152 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9154:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
9156:      SABB             ; [AL - BL -> BL]
9157:      BZ    D915F      ; =+6 [Branch if zero]
9159:      JSR   F9133      ; =-40 [Jump to subroutine relative]
915b:      BP    F9152      ; =-11 [Branch on plus]
915d:      DCR   Z          ; [Decrement Z by 1]
915f:D915F RSR              ; [Return from subroutine]
*
* Function F9160
*
9160:F9160 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
9162:D9162 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
9164:      SABB             ; [AL - BL -> BL]
9165:      BZ    D9162      ; =-5 [Branch if zero]
9167:      DCR   Z          ; [Decrement Z by 1]
9169:      RSR              ; [Return from subroutine]
*
916a:P916A LDAB/ B97FC      ; =0x97fc =38908(-26628) [Load AL direct]
916d:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
916f:      SABB             ; [AL - BL -> BL]
9170:      BNZ   D91AB      ; =+57 [Branch if not zero]
9172:      LDBB= X'01'      ; =1 [Load BL with immediate]
9174:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
9176:      JMP   D91A1      ; =+41 [Jump relative]
*
* Function F9178
*
9178:F9178 LDBB= X'02'      ; =2 [Load BL with immediate]
917a:      LDAB= X'C6'      ; =198(-58) ='F' [Load AL with immediate]
917c:      JMP   D91A1      ; =+35 [Jump relative]
*
* Function F917E
*
917e:F917E LDBB= X'02'      ; =2 [Load BL with immediate]
9180:      LDAB= X'CD'      ; =205(-51) ='M' [Load AL with immediate]
9182:      JMP   D91A1      ; =+29 [Jump relative]
*
* Function F9184
*
9184:F9184 LDBB= X'02'      ; =2 [Load BL with immediate]
9186:      LDAB= X'CF'      ; =207(-49) ='O' [Load AL with immediate]
9188:      JMP   D91A1      ; =+23 [Jump relative]
*
* Function F918A
*
918a:F918A LDAB* P916A+1    ; =-33 [Load AL relative indirect]
918c:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
918e:      SABB             ; [AL - BL -> BL]
918f:      BNZ   D91AB      ; =+26 [Branch if not zero]
9191:      LDBB= X'01'      ; =1 [Load BL with immediate]
9193:      LDAB= X'D2'      ; =210(-46) ='R' [Load AL with immediate]
9195:      JMP   D91A1      ; =+10 [Jump relative]
*
* Function F9197
*
9197:F9197 LDBB= X'01'      ; =1 [Load BL with immediate]
9199:      LDAB= X'D3'      ; =211(-45) ='S' [Load AL with immediate]
919b:      JMP   D91A1      ; =+4 [Jump relative]
*
* Function F919D
*
919d:F919D LDBB= X'01'      ; =1 [Load BL with immediate]
919f:      LDAB= X'D5'      ; =213(-43) ='U' [Load AL with immediate]
91a1:D91A1 STAB* P916A+1    ; =-56 [Store AL relative indirect]
91a3:      STBB  B91AC      ; =+7 [Store BL relative]
91a5:P91A5 LDA/  S826D      ; =0x826d =33389(-32147) [Load A direct]
91a8:      INA              ; [Increment A]
91a9:      STA*  P91A5+1    ; =-5 [Store A relative indirect]
91ab:D91AB RSR              ; [Return from subroutine]
*
91ac:B91AC DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F91AD
*
91ad:F91AD JSR/  F9261      ; =0x9261 =37473(-28063) [Jump to subroutine direct]
91b0:      LDAB  B91AC      ; =-6 [Load AL relative]
91b2:      DCAB             ; [Decrement AL]
91b3:      BGZ   D91CC      ; =+23 [Branch if greater than zero]
91b5:      LDAB/ B888F      ; =0x888f =34959(-30577) [Load AL direct]
91b8:      BNZ   D91CC      ; =+18 [Branch if not zero]
91ba:      LDB+  Y,2        ; [Load B indexed, displaced, direct]
91bd:      BZ    D91CB      ; =+12 [Branch if zero]
91bf:      LDA+  Y          ; [Load A from address in Y]
91c0:      BLE   D91C5      ; =+3 [Branch if less than or equal to zero]
91c2:      JSR/  F827C      ; =0x827c =33404(-32132) [Jump to subroutine direct]
91c5:D91C5 LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
91c8:      AAB              ; [A + B -> B]
91c9:      STB*  D91C5+1    ; =-5 [Store B relative indirect]
91cb:D91CB RSR              ; [Return from subroutine]
*
91cc:D91CC JSR   F91DB      ; =+13 [Jump to subroutine relative]
91ce:      JSR/  F930A      ; =0x930a =37642(-27894) [Jump to subroutine direct]
91d1:      LDA+  Y,2        ; [Load A indexed, displaced, direct]
91d4:      DCA              ; [Decrement A]
91d5:      BLE   D91CB      ; =-12 [Branch if less than or equal to zero]
91d7:      JSR/  F9405      ; =0x9405 =37893(-27643) [Jump to subroutine direct]
91da:      RSR              ; [Return from subroutine]
*
* Function F91DB
*
91db:F91DB XFR   Z,A        ; [Transfer Z to A]
91dd:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
91df:      XFR   Y,A        ; [Transfer Y to A]
91e1:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
91e3:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
91e5:      LDAB/ B889F      ; =0x889f =34975(-30561) [Load AL direct]
91e8:      BNZ   D91ED      ; =+3 [Branch if not zero]
91ea:      JSR/  F92B3      ; =0x92b3 =37555(-27981) [Jump to subroutine direct]
91ed:D91ED LDA+  Y+         ; [Load A indexed, direct, post-incremented]
91ef:      BLE   D91F3      ; =+2 [Branch if less than or equal to zero]
91f1:      JSR   F9212      ; =+31 [Jump to subroutine relative]
91f3:D91F3 LDX+  Y+         ; [Load X indexed, direct, post-incremented]
91f5:      ADD   X,Y        ; [X + Y -> Y]
91f7:W91F7 LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
91fa:      SUB   X,B        ; [X - B -> B]
91fc:      BLE   D9202      ; =+4 [Branch if less than or equal to zero]
91fe:      JSR   F9212      ; =+18 [Jump to subroutine relative]
9200:      LDX   W91F7+1    ; =-10 [Load X relative]
9202:D9202 LDA=  W97F0      ; =0x97f0 =38896(-26640) [Load A with immediate]
9205:      XAZ              ; [Transfer A to Z]
9206:D9206 DCX              ; [Decrement X]
9207:      BM    D9218      ; =+15 [Branch on minus]
9209:      LDAB- Y-         ; [Load AL indexed, pre-decremented, direct]
920b:      JSR/  F92CD      ; =0x92cd =37581(-27955) [Jump to subroutine direct]
920e:      STB+  Z+         ; [Store B indexed, direct, post-incremented]
9210:      JMP   D9206      ; =-12 [Jump relative]
*
* Function F9212
*
9212:F9212 LDAB= X'AB'      ; =171(-85) ='+' [Load AL with immediate]
9214:      STAB/ B97F6      ; =0x97f6 =38902(-26634) [Store AL direct]
9217:      RSR              ; [Return from subroutine]
*
9218:D9218 LDA=  W9257      ; =0x9257 =37463(-28073) [Load A with immediate]
921b:      XAY              ; [Transfer A to Y]
921c:      LDA=  F88B0      ; =0x88b0 =34992(-30544) [Load A with immediate]
921f:      XAZ              ; [Transfer A to Z]
9220:D9220 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
9222:      BZ    D924B      ; =+39 [Branch if zero]
9224:      STB   W9241      ; =+27 [Store B relative]
9226:      LDA=  W9870      ; =0x9870 =39024(-26512) [Load A with immediate]
9229:      SAB              ; [A - B -> B]
922a:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
922c:      LDB-  Z-         ; [Load B indexed, pre-decremented, direct]
922e:      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
9230:      BZ    D9247      ; =+21 [Branch if zero]
9232:      STA   W9243      ; =+15 [Store A relative]
9234:      SUB   B,A        ; [B - A -> A]
9236:      LDB+  S          ; [Load B from address in S]
9237:      SAB              ; [A - B -> B]
9238:      BGZ   D923B      ; =+1 [Branch if greater than zero]
923a:      STA+  S          ; [Store A to address in S]
923b:D923B LDA+  S+         ; [Load A indexed, direct, post-incremented]
923d:      XAB              ; [Transfer A to B]
923e:      JSR/  F9AED      ; =0x9aed =39661(-25875) [Jump to subroutine direct]
9241:W9241 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9243:W9243 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9245:      JMP   D9220      ; =-39 [Jump relative]
9247:D9247 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9249:      JMP   D9220      ; =-43 [Jump relative]
924b:D924B JSR/  F954C      ; =0x954c =38220(-27316) [Jump to subroutine direct]
924e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9250:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9252:      XAY              ; [Transfer A to Y]
9253:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9255:      XAZ              ; [Transfer A to Z]
9256:      RSR              ; [Return from subroutine]
*
9257:W9257 DW    W9823      ; =0x9823 =38947(-26589)
9259:      DW    W980E      ; =0x980e =38926(-26610)
925b:      DW    W9807      ; =0x9807 =38919(-26617)
925d:      DW    W97FE      ; =0x97fe =38910(-26626)
925f:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F9261
*
9261:F9261 XFR   Y,A        ; [Transfer Y to A]
9263:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9265:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9267:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9269:      ADD   A,Y        ; [A + Y -> Y]
926b:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
926d:      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
926f:      BZ    D92A3      ; =+50 [Branch if zero]
9271:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9273:      XAX              ; [Transfer A to X]
9274:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9276:      LDB+  A,2        ; [Load B indexed, displaced, direct]
9279:      LDBB= X'10'      ; =16 [Load BL with immediate]
927b:      ANDB  BU,BL      ; [BU & BL -> BL]
927d:      BNZ   D928E      ; =+15 [Branch if not zero]
927f:      LDBB= X'02'      ; =2 [Load BL with immediate]
9281:      ANDB  BU,BL      ; [BU & BL -> BL]
9283:      BNZ   D9293      ; =+14 [Branch if not zero]
9285:      LDB+  A,3        ; [Load B indexed, displaced, direct]
9288:      BZ    D9293      ; =+9 [Branch if zero]
928a:      SUB   X,B        ; [X - B -> B]
928c:      BZ    D9293      ; =+5 [Branch if zero]
928e:D928E JSR/  F917E      ; =0x917e =37246(-28290) [Jump to subroutine direct]
9291:      JMP   D92A1      ; =+14 [Jump relative]
9293:D9293 STX+  A,3        ; [Store X indexed, displaced, direct]
9296:      LDB+  A,2        ; [Load B indexed, displaced, direct]
9299:      LDBB/ B8899      ; =0x8899 =34969(-30567) [Load BL direct]
929c:      ORIB  BU,BL      ; [BU | BL -> BL]
929e:      STBB+ A,2        ; [Store BL indexed, displaced, direct]
92a1:D92A1 LDX+  S+         ; [Load X indexed, direct, post-incremented]
92a3:D92A3 LDA+  S+         ; [Load A indexed, direct, post-incremented]
92a5:      XAY              ; [Transfer A to Y]
92a6:      RSR              ; [Return from subroutine]
*
* Function F92A7
*
92a7:F92A7 LDA+  Y          ; [Load A from address in Y]
92a8:      LDB=  W97F7      ; =0x97f7 =38903(-26633) [Load B with immediate]
92ab:      JSR   F92BC      ; =+15 [Jump to subroutine relative]
92ad:      LDAB= X'01'      ; =1 [Load AL with immediate]
92af:      STAB/ B889F      ; =0x889f =34975(-30561) [Store AL direct]
92b2:      RSR              ; [Return from subroutine]
*
* Function F92B3
*
92b3:F92B3 LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
92b6:      LDB=  W97EB      ; =0x97eb =38891(-26645) [Load B with immediate]
92b9:      JSR   F92BC      ; =+1 [Jump to subroutine relative]
92bb:      RSR              ; [Return from subroutine]
*
* Function F92BC
*
92bc:F92BC STX-  S-         ; [Store X indexed, pre-decremented, direct]
92be:      XFR   B,X        ; [Transfer B to X]
92c0:      JSR   F92CD      ; =+11 [Jump to subroutine relative]
92c2:      STB+  X,2        ; [Store B indexed, displaced, direct]
92c5:      XFRB  AU,AL      ; [Transfer AU to AL]
92c7:      JSR   F92CD      ; =+4 [Jump to subroutine relative]
92c9:      STB+  X          ; [Store B to address in X]
92ca:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
92cc:      RSR              ; [Return from subroutine]
*
* Function F92CD
*
92cd:F92CD STAB- S-         ; [Store AL indexed, pre-decremented, direct]
92cf:      SRRB  AL,4       ; [Right shift AL by 4]
92d1:      JSR   F92D7      ; =+4 [Jump to subroutine relative]
92d3:      XFRB  BL,BU      ; [Transfer BL to BU]
92d5:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
*
* Function F92D7
*
92d7:F92D7 LDBB= X'0F'      ; =15 [Load BL with immediate]
92d9:      NABB             ; [AL & BL -> BL]
92da:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
92dc:      LDAB= X'09'      ; =9 [Load AL with immediate]
92de:      SUBB  BL,AL      ; [BL - AL -> AL]
92e0:      BLE   D92E6      ; =+4 [Branch if less than or equal to zero]
92e2:      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
92e4:      JMP   D92E8      ; =+2 [Jump relative]
92e6:D92E6 LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
92e8:D92E8 ORIB  AL,BL      ; [AL | BL -> BL]
92ea:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
92ec:      RSR              ; [Return from subroutine]
*
* Function F92ED
*
92ed:F92ED STA-  S-         ; [Store A indexed, pre-decremented, direct]
92ef:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
92f2:      AAB              ; [A + B -> B]
92f3:      CLA              ; [Clear A]
92f4:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
92f6:      STB   W9305      ; =+13 [Store B relative]
92f8:      XAB              ; [Transfer A to B]
92f9:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
92fb:      STA   W9303      ; =+6 [Store A relative]
92fd:      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
9300:      JSR/  F9AED      ; =0x9aed =39661(-25875) [Jump to subroutine direct]
9303:W9303 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9305:W9305 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9307:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9309:      RSR              ; [Return from subroutine]
*
* Function F930A
*
930a:F930A STX-  S-         ; [Store X indexed, pre-decremented, direct]
930c:      XFR   Y,X        ; [Transfer Y to X]
930e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9310:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
9312:D9312 JSR   F9319      ; =+5 [Jump to subroutine relative]
9314:      DCX              ; [Decrement X]
9315:      BGZ   D9312      ; =-5 [Branch if greater than zero]
9317:      JMP   D934D      ; =+52 [Jump relative]
*
* Function F9319
*
9319:F9319 STX-  S-         ; [Store X indexed, pre-decremented, direct]
931b:      XFR   Y,X        ; [Transfer Y to X]
931d:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
931f:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
9321:      ADD   X,Y        ; [X + Y -> Y]
9323:D9323 DCX              ; [Decrement X]
9324:      BM    D934D      ; =+39 [Branch on minus]
9326:      CLA              ; [Clear A]
9327:      LDAB  B9369      ; =+64 [Load AL relative]
9329:      LDB=  X'0078'    ; =0x0078 =120 [Load B with immediate]
932c:      SAB              ; [A - B -> B]
932d:      BM    P9331      ; =+2 [Branch on minus]
932f:D932F JSR   F9353      ; =+34 [Jump to subroutine relative]
9331:P9331 LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
9334:      LDB   W9366      ; =+48 [Load B relative]
9336:      SAB              ; [A - B -> B]
9337:      BNZ   D932F      ; =-10 [Branch if not zero]
9339:      INA              ; [Increment A]
933a:      STA*  P9331+1    ; =-10 [Store A relative indirect]
933c:      STA   W9366      ; =+40 [Store A relative]
933e:      CLA              ; [Clear A]
933f:      LDAB  B9369      ; =+40 [Load AL relative]
9341:      INA              ; [Increment A]
9342:      STAB  B9369      ; =+37 [Store AL relative]
9344:      LDB=  W936B      ; =0x936b =37739(-27797) [Load B with immediate]
9347:      AAB              ; [A + B -> B]
9348:      LDAB- Y-         ; [Load AL indexed, pre-decremented, direct]
934a:      STAB+ B          ; [Store AL to address in B]
934b:      JMP   D9323      ; =-42 [Jump relative]
934d:D934D LDA+  S+         ; [Load A indexed, direct, post-incremented]
934f:      XAY              ; [Transfer A to Y]
9350:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9352:      RSR              ; [Return from subroutine]
*
* Function F9353
*
9353:F9353 LDAB  B9369      ; =+20 [Load AL relative]
9355:      BZ    D935C      ; =+5 [Branch if zero]
9357:      JSR/  F93E4      ; =0x93e4 =37860(-27676) [Jump to subroutine direct]
935a:      DW    W9368      ; =0x9368 =37736(-27800)
*
935c:D935C LDA*  P9331+1    ; =-44 [Load A relative indirect]
935e:      STA   W9366      ; =+6 [Store A relative]
9360:      STA   W936A      ; =+8 [Store A relative]
9362:      CLAB             ; [Clear AL]
9363:      STAB  B9369      ; =+4 [Store AL relative]
9365:      RSR              ; [Return from subroutine]
*
9366:W9366 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9368:W9368 DB    X'00'      ; =0x00 =0 =NUL
9369:B9369 DB    X'00'      ; =0x00 =0 =NUL
936a:W936A DB    X'00'      ; =0x00 =0 =NUL
936b:W936B DB    X'00'      ; =0x00 =0 =NUL
936c:      DS    120        ; =0x0078 [Uninitialized memory]
*
* Function F93E4
*
93e4:F93E4 LDA+  X+         ; [Load A indexed, direct, post-incremented]
93e6:      LDBB/ B888F      ; =0x888f =34959(-30577) [Load BL direct]
93e9:      BZ    D93EE      ; =+3 [Branch if zero]
93eb:      JSR/  F81BF      ; =0x81bf =33215(-32321) [Jump to subroutine direct]
93ee:D93EE RSR              ; [Return from subroutine]
*
93ef:W93EF DW    X'020B'    ; =0x020b =523
93f1:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93f3:W93F3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93f5:W93F5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
93f7:B93F7 DB    X'00'      ; =0x00 =0 =NUL
93f8:W93F8 DS    6          ; =0x0006 [Uninitialized memory]
*
*
* Function F93FE
*
93fe:F93FE STAB  B93F7      ; =-9 [Store AL relative]
9400:      JSR   F93E4      ; =-30 [Jump to subroutine relative]
9402:      DW    W93EF      ; =0x93ef =37871(-27665)
9404:      RSR              ; [Return from subroutine]
*
* Function F9405
*
9405:F9405 LDA/  W889A      ; =0x889a =34970(-30566) [Load A direct]
9408:      BNZ   D9435      ; =+43 [Branch if not zero]
940a:      LDAB/ B8898      ; =0x8898 =34968(-30568) [Load AL direct]
940d:      BZ    D9434      ; =+37 [Branch if zero]
940f:      CLA              ; [Clear A]
9410:      LDAB  S9455      ; =+67 [Load AL relative]
9412:      LDB=  X'0076'    ; =0x0076 =118 [Load B with immediate]
9415:      SAB              ; [A - B -> B]
9416:      BLE   D9426      ; =+14 [Branch if less than or equal to zero]
9418:      JSR   F9446      ; =+44 [Jump to subroutine relative]
941a:      DW    W94D0      ; =0x94d0 =38096(-27440)
*
941c:      JSR/  F9ADE      ; =0x9ade =39646(-25890) [Jump to subroutine direct]
941f:      DW    X'007C'    ; =0x007c =124
9421:      DW    W94D0      ; =0x94d0 =38096(-27440)
9423:      DW    W9454      ; =0x9454 =37972(-27564)
9425:      CLA              ; [Clear A]
9426:D9426 LDB=  W9458      ; =0x9458 =37976(-27560) [Load B with immediate]
9429:      AAB              ; [A + B -> B]
942a:      INR   A,2        ; [Increment A by 2]
942c:      STAB  S9455      ; =+39 [Store AL relative]
942e:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
9431:      DCR   A,2        ; [Decrement A by 2]
9433:      STA+  B          ; [Store A to address in B]
9434:D9434 RSR              ; [Return from subroutine]
*
9435:D9435 JSR/  F92ED      ; =0x92ed =37613(-27923) [Jump to subroutine direct]
9438:      DW    W93F8      ; =0x93f8 =37880(-27656)
943a:      LDA/  W889D      ; =0x889d =34973(-30563) [Load A direct]
943d:      DCR   A,2        ; [Decrement A by 2]
943f:      STA   W93F3      ; =-78 [Store A relative]
9441:      LDAB= X'02'      ; =2 [Load AL with immediate]
9443:      JSR   F93FE      ; =-71 [Jump to subroutine relative]
9445:      RSR              ; [Return from subroutine]
*
* Function F9446
*
9446:F9446 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9448:      STA   W9451      ; =+7 [Store A relative]
944a:      INA              ; [Increment A]
944b:      LDBB+ A          ; [Load BL from address in A]
944c:      BZ    D9453      ; =+5 [Branch if zero]
944e:      JSR/  F93E4      ; =0x93e4 =37860(-27676) [Jump to subroutine direct]
9451:W9451 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
9453:D9453 RSR              ; [Return from subroutine]
*
9454:W9454 DB    X'01'      ; =0x01 =1
9455:S9455 DB    0,3        ; =0x00,0x0003
9458:W9458 DS    120        ; =0x0078 [Uninitialized memory]
94d0:W94D0 DB    X'01'      ; =0x01 =1
94d1:S94D1 DB    0,3        ; =0x00,0x0003
94d4:      DS    120        ; =0x0078 [Uninitialized memory]
*
* Function F954C
*
954c:F954C LDAB/ B91AC      ; =0x91ac =37292(-28244) [Load AL direct]
954f:      BNZ   D9563      ; =+18 [Branch if not zero]
9551:      LDAB/ B8891      ; =0x8891 =34961(-30575) [Load AL direct]
9554:      BNZ   D9563      ; =+13 [Branch if not zero]
9556:      LDAB/ B8892      ; =0x8892 =34962(-30574) [Load AL direct]
9559:      BZ    D9574      ; =+25 [Branch if zero]
955b:      LDAB/ W97FE      ; =0x97fe =38910(-26626) [Load AL direct]
955e:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
9560:      SABB             ; [AL - BL -> BL]
9561:      BNZ   D9574      ; =+17 [Branch if not zero]
9563:D9563 JSR/  F81F6      ; =0x81f6 =33270(-32266) [Jump to subroutine direct]
9566:      DW    W97E9      ; =0x97e9 =38889(-26647)
*
*
* Function F9568
*
9568:F9568 LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
956b:      LDB=  W97E9      ; =0x97e9 =38889(-26647) [Load B with immediate]
956e:      STA+  B+         ; [Store A indexed, direct, post-incremented]
9570:      JSR/  F9B12      ; =0x9b12 =39698(-25838) [Jump to subroutine direct]
9573:      DC    ' '        ; hex:a0 dec:160(-96)
*
9574:D9574 RSR              ; [Return from subroutine]
*
* Function F9575
*
9575:F9575 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9577:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9579:P9579 JSR/  F9133      ; =0x9133 =37171(-28365) [Jump to subroutine direct]
957c:      BM    D95B3      ; =+53 [Branch on minus]
957e:      CLRB  BU         ; [Clear BU]
9580:      SLR   B          ; [Left shift B by 1]
9582:      LDA=  S95BB      ; =0x95bb =38331(-27205) [Load A with immediate]
9585:      AAB              ; [A + B -> B]
9586:      LDA+  B          ; [Load A from address in B]
9587:      BZ    D95B3      ; =+42 [Branch if zero]
9589:      XAX              ; [Transfer A to X]
958a:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
958c:      JSR*  P9579+1    ; =-20 [Jump to subroutine relative indirect]
958e:      BM    D95B3      ; =+35 [Branch on minus]
9590:      XFRB  AL,AU      ; [Transfer AL to AU]
9592:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9594:      JSR/  F913F      ; =0x913f =37183(-28353) [Jump to subroutine direct]
9597:      BP    D959D      ; =+4 [Branch on plus]
9599:      DCR   Z          ; [Decrement Z by 1]
959b:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
959d:D959D LDBB+ X          ; [Load BL from address in X]
959e:      BZ    D95B3      ; =+19 [Branch if zero]
95a0:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
95a2:      SAB              ; [A - B -> B]
95a3:      BZ    D95A9      ; =+4 [Branch if zero]
95a5:      INX              ; [Increment X]
95a6:      INX              ; [Increment X]
95a7:      JMP   D959D      ; =-12 [Jump relative]
95a9:D95A9 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
95ab:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
95ad:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
95af:      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
95b1:      JMP   D95B8      ; =+5 [Jump relative]
95b3:D95B3 LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
95b6:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
95b8:D95B8 LDX+  S+         ; [Load X indexed, direct, post-incremented]
95ba:      RSR              ; [Return from subroutine]
*
95bb:S95BB DB    0,6        ; =0x00,0x0006
95c1:      DW    S95F5      ; =0x95f5 =38389(-27147)
95c3:      DW    S9602      ; =0x9602 =38402(-27134)
95c5:      DW    S963F      ; =0x963f =38463(-27073)
95c7:      DW    S964C      ; =0x964c =38476(-27060)
95c9:      DW    S9679      ; =0x9679 =38521(-27015)
95cb:      DB    0,4        ; =0x00,0x0004
95cf:      DW    S9696      ; =0x9696 =38550(-26986)
95d1:      DW    S969B      ; =0x969b =38555(-26981)
95d3:      DW    S96B0      ; =0x96b0 =38576(-26960)
95d5:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
95d7:      DW    S96B9      ; =0x96b9 =38585(-26951)
95d9:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
95db:      DW    S96C6      ; =0x96c6 =38598(-26938)
95dd:      DW    S96CF      ; =0x96cf =38607(-26929)
95df:      DW    S96DC      ; =0x96dc =38620(-26916)
95e1:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
95e3:      DW    S96E5      ; =0x96e5 =38629(-26907)
95e5:      DW    S96FE      ; =0x96fe =38654(-26882)
95e7:      DW    S972F      ; =0x972f =38703(-26833)
95e9:      DB    0,6        ; =0x00,0x0006
95ef:      DW    S9734      ; =0x9734 =38708(-26828)
95f1:      DB    0,4        ; =0x00,0x0004
95f5:S95F5 DC    'AB'       ; hex:c1c2 dec:49602(-62)
95f7:      DW    X'5802'    ; =0x5802 =22530
95f9:      DC    'ND'       ; hex:cec4 dec:52932(-60)
95fb:      DW    X'5222'    ; =0x5222 =21026
95fd:      DC    'DD'       ; hex:c4c4 dec:50372(-60)
95ff:      DW    X'5022'    ; =0x5022 =20514
9601:      DB    X'00'      ; =0x00 =0 =NUL
9602:S9602 DC    'Z '       ; hex:daa0 dec:55968(-96)
9604:      DW    X'1430'    ; =0x1430 =5168
9606:      DC    'NZ'       ; hex:ceda dec:52954(-38)
9608:      DW    X'1530'    ; =0x1530 =5424
960a:      DC    'L '       ; hex:cca0 dec:52384(-96)
960c:      DW    X'1030'    ; =0x1030 =4144
960e:      DC    'NL'       ; hex:cecc dec:52940(-52)
9610:      DW    X'1130'    ; =0x1130 =4400
9612:      DC    'M '       ; hex:cda0 dec:52640(-96)
9614:      DW    X'1630'    ; =0x1630 =5680
9616:      DC    'P '       ; hex:d0a0 dec:53408(-96)
9618:      DW    X'1730'    ; =0x1730 =5936
961a:      DC    'GZ'       ; hex:c7da dec:51162(-38)
961c:      DW    X'1830'    ; =0x1830 =6192
961e:      DC    'LE'       ; hex:ccc5 dec:52421(-59)
9620:      DW    X'1930'    ; =0x1930 =6448
9622:      DC    'S1'       ; hex:d3b1 dec:54193(-79)
9624:      DW    X'1A30'    ; =0x1a30 =6704
9626:      DC    'S2'       ; hex:d3b2 dec:54194(-78)
9628:      DW    X'1B30'    ; =0x1b30 =6960
962a:      DC    'S3'       ; hex:d3b3 dec:54195(-77)
962c:      DW    X'1C30'    ; =0x1c30 =7216
962e:      DC    'S4'       ; hex:d3b4 dec:54196(-76)
9630:      DW    X'1D30'    ; =0x1d30 =7472
9632:      DC    'F '       ; hex:c6a0 dec:50848(-96)
9634:      DW    X'1230'    ; =0x1230 =4656
9636:      DC    'NF'       ; hex:cec6 dec:52934(-58)
9638:      DW    X'1330'    ; =0x1330 =4912
963a:      DC    'EG'       ; hex:c5c7 dec:50631(-57)
963c:      DW    X'0701'    ; =0x0701 =1793
963e:      DB    X'00'      ; =0x00 =0 =NUL
963f:S963F DC    'LA'       ; hex:ccc1 dec:52417(-63)
9641:      DW    X'3A02'    ; =0x3a02 =14850
9643:      DC    'LR'       ; hex:ccd2 dec:52434(-46)
9645:      DW    X'3212'    ; =0x3212 =12818
9647:      DC    'L '       ; hex:cca0 dec:52384(-96)
9649:      DW    X'0800'    ; =0x0800 =2048
964b:      DB    X'00'      ; =0x00 =0 =NUL
964c:S964C DC    'CX'       ; hex:c3d8 dec:50136(-40)
964e:      DW    X'3F00'    ; =0x3f00 =16128
9650:      DC    'CA'       ; hex:c3c1 dec:50113(-63)
9652:      DW    X'3902'    ; =0x3902 =14594
9654:      DC    'CR'       ; hex:c3d2 dec:50130(-46)
9656:      DW    X'3112'    ; =0x3112 =12562
9658:      DC    'W '       ; hex:d7a0 dec:55200(-96)
965a:      DW    X'0401'    ; =0x0401 =1025
965c:      DC    'B '       ; hex:c2a0 dec:49824(-96)
965e:      DW    X'0301'    ; =0x0301 =769
9660:      DC    'C '       ; hex:c3a0 dec:50080(-96)
9662:      DW    X'0501'    ; =0x0501 =1281
9664:      DC    'S '       ; hex:d3a0 dec:54176(-96)
9666:      DW    X'0601'    ; =0x0601 =1537
9668:      DC    'LY'       ; hex:ccd9 dec:52441(-39)
966a:      DW    X'0E00'    ; =0x0e00 =3584
966c:      DC    'I '       ; hex:c9a0 dec:51616(-96)
966e:      DW    X'0500'    ; =0x0500 =1280
9670:      DC    'MA'       ; hex:cdc1 dec:52673(-63)
9672:      DW    X'2F50'    ; =0x2f50 =12112
9674:      DC    'CKF'      ; hex:c3cbc6
9677:      DB    X'00'      ; =0x00 =0 =NUL
9678:      DB    X'00'      ; =0x00 =0 =NUL
9679:S9679 DC    'QU'       ; hex:d1d5 dec:53717(-43)
967b:      DB    X'00'      ; =0x00 =0 =NUL
967c:      DB    X'01'      ; =0x01 =1
967d:      DC    'XT'       ; hex:d8d4 dec:55508(-44)
967f:      DW    X'0A01'    ; =0x0a01 =2561
9681:      DC    'NT'       ; hex:ced4 dec:52948(-44)
9683:      DW    X'0901'    ; =0x0901 =2305
9685:      DC    'I '       ; hex:c9a0 dec:51616(-96)
9687:      DW    X'0400'    ; =0x0400 =1024
9689:      DC    'ND'       ; hex:cec4 dec:52932(-60)
968b:      DW    X'0801'    ; =0x0801 =2049
968d:      DC    'JE'       ; hex:cac5 dec:51909(-59)
968f:      DW    X'0D01'    ; =0x0d01 =3329
9691:      DC    'CK6'      ; hex:c3cbb6
9694:      DB    X'00'      ; =0x00 =0 =NUL
9695:      DB    X'00'      ; =0x00 =0 =NUL
9696:S9696 DC    'LT'       ; hex:ccd4 dec:52436(-44)
9698:      DB    X'00'      ; =0x00 =0 =NUL
9699:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
969b:S969B DC    'NX'       ; hex:ced8 dec:52952(-40)
969d:      DW    X'3E00'    ; =0x3e00 =15872
969f:      DC    'NA'       ; hex:cec1 dec:52929(-63)
96a1:      DW    X'3802'    ; =0x3802 =14338
96a3:      DC    'VA'       ; hex:d6c1 dec:54977(-63)
96a5:      DW    X'3B02'    ; =0x3b02 =15106
96a7:      DC    'NR'       ; hex:ced2 dec:52946(-46)
96a9:      DW    X'3012'    ; =0x3012 =12306
96ab:      DC    'VR'       ; hex:d6d2 dec:54994(-46)
96ad:      DW    X'3312'    ; =0x3312 =13074
96af:      DB    X'00'      ; =0x00 =0 =NUL
96b0:S96B0 DC    'MP'       ; hex:cdd0 dec:52688(-48)
96b2:      DW    X'7040'    ; =0x7040 =28736
96b4:      DC    'SR'       ; hex:d3d2 dec:54226(-46)
96b6:      DW    X'7840'    ; =0x7840 =30784
96b8:      DB    X'00'      ; =0x00 =0 =NUL
96b9:S96B9 DC    'DA'       ; hex:c4c1 dec:50369(-63)
96bb:      DW    X'9046'    ; =0x9046 =36934(-28602)
96bd:      DC    'DBP'      ; hex:c4c2d0
96c0:      DB    X'46'      ; =0x46 =70
96c1:      DC    'DX'       ; hex:c4d8 dec:50392(-40)
96c3:      DW    X'6044'    ; =0x6044 =24644
96c5:      DB    X'00'      ; =0x00 =0 =NUL
96c6:S96C6 DC    'AB'       ; hex:c1c2 dec:49602(-62)
96c8:      DW    X'5A02'    ; =0x5a02 =23042
96ca:      DC    'OP'       ; hex:cfd0 dec:53200(-48)
96cc:      DW    X'0100'    ; =0x0100 =256
96ce:      DB    X'00'      ; =0x00 =0 =NUL
96cf:S96CF DC    'RI'       ; hex:d2c9 dec:53961(-55)
96d1:      DW    X'5322'    ; =0x5322 =21282
96d3:      DC    'RE'       ; hex:d2c5 dec:53957(-59)
96d5:      DW    X'5422'    ; =0x5422 =21538
96d7:      DC    'RG'       ; hex:d2c7 dec:53959(-57)
96d9:      DW    X'0201'    ; =0x0201 =513
96db:      DB    X'00'      ; =0x00 =0 =NUL
96dc:S96DC DC    'RI'       ; hex:d2c9 dec:53961(-55)
96de:      DW    X'0B01'    ; =0x0b01 =2817
96e0:      DC    'CX'       ; hex:c3d8 dec:50136(-40)
96e2:      DW    X'0D00'    ; =0x0d00 =3328
96e4:      DB    X'00'      ; =0x00 =0 =NUL
96e5:S96E5 DC    'SR'       ; hex:d3d2 dec:54226(-46)
96e7:      DW    X'0900'    ; =0x0900 =2304
96e9:      DC    'L '       ; hex:cca0 dec:52384(-96)
96eb:      DW    X'0700'    ; =0x0700 =1792
96ed:      DC    'I '       ; hex:c9a0 dec:51616(-96)
96ef:      DW    X'0A00'    ; =0x0a00 =2560
96f1:      DC    'RR'       ; hex:d2d2 dec:53970(-46)
96f3:      DW    X'3612'    ; =0x3612 =13842
96f5:      DC    'LR'       ; hex:ccd2 dec:52434(-46)
96f7:      DW    X'3712'    ; =0x3712 =14098
96f9:      DC    'F '       ; hex:c6a0 dec:50848(-96)
96fb:      DW    X'0300'    ; =0x0300 =768
96fd:      DB    X'00'      ; =0x00 =0 =NUL
96fe:S96FE DC    'TA0'      ; hex:d4c1b0
9701:      DB    X'46'      ; =0x46 =70
9702:      DC    'TBp'      ; hex:d4c2f0
9705:      DB    X'46'      ; =0x46 =70
9706:      DC    'AB'       ; hex:c1c2 dec:49602(-62)
9708:      DW    X'5902'    ; =0x5902 =22786
970a:      DC    'TX'       ; hex:d4d8 dec:54488(-40)
970c:      DW    X'6844'    ; =0x6844 =26692
970e:      DC    'UB'       ; hex:d5c2 dec:54722(-62)
9710:      DW    X'5122'    ; =0x5122 =20770
9712:      DC    'LA'       ; hex:ccc1 dec:52417(-63)
9714:      DW    X'3D02'    ; =0x3d02 =15618
9716:      DC    'RA'       ; hex:d2c1 dec:53953(-63)
9718:      DW    X'3C02'    ; =0x3c02 =15362
971a:      DC    'RR'       ; hex:d2d2 dec:53970(-46)
971c:      DW    X'3412'    ; =0x3412 =13330
971e:      DC    'LR'       ; hex:ccd2 dec:52434(-46)
9720:      DW    X'3512'    ; =0x3512 =13586
9722:      DC    'L '       ; hex:cca0 dec:52384(-96)
9724:      DW    X'0600'    ; =0x0600 =1536
9726:      DC    'F '       ; hex:c6a0 dec:50848(-96)
9728:      DW    X'0200'    ; =0x0200 =512
972a:      DC    'ET'       ; hex:c5d4 dec:50644(-44)
972c:      DW    X'0101'    ; =0x0101 =257
972e:      DB    X'00'      ; =0x00 =0 =NUL
972f:S972F DC    'IT'       ; hex:c9d4 dec:51668(-44)
9731:      DW    X'0C01'    ; =0x0c01 =3073
9733:      DB    X'00'      ; =0x00 =0 =NUL
9734:S9734 DC    'AX'       ; hex:c1d8 dec:49624(-40)
9736:      DW    X'5B02'    ; =0x5b02 =23298
9738:      DC    'AY'       ; hex:c1d9 dec:49625(-39)
973a:      DW    X'5C02'    ; =0x5c02 =23554
973c:      DC    'AZ'       ; hex:c1da dec:49626(-38)
973e:      DW    X'5E02'    ; =0x5e02 =24066
9740:      DC    'AB'       ; hex:c1c2 dec:49602(-62)
9742:      DW    X'5D02'    ; =0x5d02 =23810
9744:      DC    'AS'       ; hex:c1d3 dec:49619(-45)
9746:      DW    X'5F02'    ; =0x5f02 =24322
9748:      DC    'FR'       ; hex:c6d2 dec:50898(-46)
974a:      DW    X'5522'    ; =0x5522 =21794
974c:      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F974D
*
974d:F974D LDAB+ Y,3        ; [Load AL indexed, displaced, direct]
9750:      XFRB  AL,AU      ; [Transfer AL to AU]
9752:      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
9755:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9757:      LDX=  W978C      ; =0x978c =38796(-26740) [Load X with immediate]
975a:      LDBB= X'85'      ; =133(-123) [Load BL with immediate]
975c:      XFRB  BL,BU      ; [Transfer BL to BU]
975e:      ANDB  AU,BL      ; [AU & BL -> BL]
9760:      SUBB  BU,BL      ; [BU - BL -> BL]
9762:      BNZ   D9778      ; =+20 [Branch if not zero]
9764:      LDBB= X'0F'      ; =15 [Load BL with immediate]
9766:      NABB             ; [AL & BL -> BL]
9767:      BNZ   D978A      ; =+33 [Branch if not zero]
9769:      RL               ; [Reset link]
976a:      RRRB  AL         ; [Right rotate AL by 1]
976c:      SRRB  AL,4       ; [Right shift AL by 4]
976e:      LDBB= X'08'      ; =8 [Load BL with immediate]
9770:      AABB             ; [AL + BL -> BL]
9771:      LDAB= X'F0'      ; =240(-16) ='p' [Load AL with immediate]
9773:      ANDB  AU,AL      ; [AU & AL -> AL]
9775:      AABB             ; [AL + BL -> BL]
9776:      JMP   D9781      ; =+9 [Jump relative]
9778:D9778 INX              ; [Increment X]
9779:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
977b:      BZ    D978A      ; =+13 [Branch if zero]
977d:      SAB              ; [A - B -> B]
977e:      BNZ   D9778      ; =-8 [Branch if not zero]
9780:      LDBB+ X          ; [Load BL from address in X]
9781:D9781 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9783:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9785:      STBB+ Y          ; [Store BL to address in Y]
9786:      CLA              ; [Clear A]
9787:      INA              ; [Increment A]
9788:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
978a:D978A LDX+  S+         ; [Load X indexed, direct, post-incremented]
978c:W978C RSR              ; [Return from subroutine]
*
978d:      DW    X'3000'    ; =0x3000 =12288
978f:      DW    X'3820'    ; =0x3820 =14368
9791:      DW    X'1028'    ; =0x1028 =4136
9793:      DW    X'3100'    ; =0x3100 =12544
9795:      DW    X'3921'    ; =0x3921 =14625
9797:      DW    X'1029'    ; =0x1029 =4137
9799:      DW    X'3200'    ; =0x3200 =12800
979b:      DW    X'3A22'    ; =0x3a22 =14882
979d:      DW    X'102A'    ; =0x102a =4138
979f:      DW    X'3300'    ; =0x3300 =13056
97a1:      DW    X'3B23'    ; =0x3b23 =15139
97a3:      DW    X'102B'    ; =0x102b =4139
97a5:      DW    X'3400'    ; =0x3400 =13312
97a7:      DW    X'3C24'    ; =0x3c24 =15396
97a9:      DW    X'102C'    ; =0x102c =4140
97ab:      DW    X'3500'    ; =0x3500 =13568
97ad:      DW    X'3D25'    ; =0x3d25 =15653
97af:      DW    X'102D'    ; =0x102d =4141
97b1:      DW    X'3040'    ; =0x3040 =12352
97b3:      DW    X'3E31'    ; =0x3e31 =15921
97b5:      DW    X'403F'    ; =0x403f =16447
97b7:      DW    X'5002'    ; =0x5002 =20482
97b9:      DW    X'5840'    ; =0x5840 =22592
97bb:      DW    X'1348'    ; =0x1348 =4936
97bd:      DW    X'5102'    ; =0x5102 =20738
97bf:      DW    X'5941'    ; =0x5941 =22849
97c1:      DW    X'1349'    ; =0x1349 =4937
97c3:      DW    X'5202'    ; =0x5202 =20994
97c5:      DW    X'5A42'    ; =0x5a42 =23106
97c7:      DW    X'134A'    ; =0x134a =4938
97c9:      DW    X'5504'    ; =0x5504 =21764
97cb:      DW    X'5B45'    ; =0x5b45 =23365
97cd:      DW    X'154B'    ; =0x154b =5451
97cf:      DW    X'5506'    ; =0x5506 =21766
97d1:      DW    X'5C45'    ; =0x5c45 =23621
97d3:      DW    X'174C'    ; =0x174c =5964
97d5:      DW    X'5502'    ; =0x5502 =21762
97d7:      DW    X'5D45'    ; =0x5d45 =23877
97d9:      DW    X'134D'    ; =0x134d =4941
97db:      DW    X'5508'    ; =0x5508 =21768
97dd:      DW    X'5E45'    ; =0x5e45 =24133
97df:      DW    X'194E'    ; =0x194e =6478
97e1:      DW    X'550A'    ; =0x550a =21770
97e3:      DW    X'5F45'    ; =0x5f45 =24389
97e5:      DW    X'1B4F'    ; =0x1b4f =6991
97e7:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
97e9:W97E9 DS    2          ; =0x0002 [Uninitialized memory]
97eb:W97EB DS    5          ; =0x0005 [Uninitialized memory]
97f0:W97F0 DS    6          ; =0x0006 [Uninitialized memory]
97f6:B97F6 DS    1          ; =0x0001 [Uninitialized memory]
97f7:W97F7 DS    2          ; =0x0002 [Uninitialized memory]
97f9:W97F9 DS    3          ; =0x0003 [Uninitialized memory]
97fc:B97FC DS    2          ; =0x0002 [Uninitialized memory]
97fe:W97FE DS    9          ; =0x0009 [Uninitialized memory]
9807:W9807 DS    7          ; =0x0007 [Uninitialized memory]
980e:W980E DS    21         ; =0x0015 [Uninitialized memory]
9823:W9823 DS    77         ; =0x004d [Uninitialized memory]
9870:W9870 DS    127        ; =0x007f [Uninitialized memory]
98ef:W98EF DS    1          ; =0x0001 [Uninitialized memory]
*
* Function F98F0
*
98f0:F98F0 LDA+  X+         ; [Load A indexed, direct, post-incremented]
98f2:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
98f4:      XFR   Y,X        ; [Transfer Y to X]
98f6:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
98f8:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
98fa:      XAY              ; [Transfer A to Y]
98fb:D98FB DCX              ; [Decrement X]
98fc:      BM    D9911      ; =+19 [Branch on minus]
98fe:      LDAB+ Y          ; [Load AL from address in Y]
98ff:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
9901:      SABB             ; [AL - BL -> BL]
9902:      BGZ   D990D      ; =+9 [Branch if greater than zero]
9904:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
9906:      SABB             ; [AL - BL -> BL]
9907:      BM    D990D      ; =+4 [Branch on minus]
9909:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
990b:      ADDB  BL,AL      ; [BL + AL -> AL]
990d:D990D STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
990f:      JMP   D98FB      ; =-22 [Jump relative]
9911:D9911 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9913:      XAY              ; [Transfer A to Y]
9914:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9916:      RSR              ; [Return from subroutine]
*
9917:W9917 DB    X'0B'      ; =0x0b =11
9918:      DW    W99AC      ; =0x99ac =39340(-26196)
991a:      DW    W99FE      ; =0x99fe =39422(-26114)
991c:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
991e:      DW    W992E      ; =0x992e =39214(-26322)
9920:      DB    0,12       ; =0x00,0x000c
992c:      DW    W9A81      ; =0x9a81 =39553(-25983)
*
992e:W992E STX-  S-         ; [Store X indexed, pre-decremented, direct]
9930:      JSR   F995D      ; =+43 [Jump to subroutine relative]
9932:      DB    X'02'      ; =0x02 =2
9933:      BZ    D995B      ; =+38 [Branch if zero]
9935:      CLA              ; [Clear A]
9936:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9939:      STA+  Z,22       ; [Store A indexed, displaced, direct]
993c:      STB+  Z,20       ; [Store B indexed, displaced, direct]
993f:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9942:      JSR   F995D      ; =+25 [Jump to subroutine relative]
9944:      DB    X'05'      ; =0x05 =5
9945:      LDBB= X'0F'      ; =15 [Load BL with immediate]
9947:      ANDB  BU,BL      ; [BU & BL -> BL]
9949:      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
994c:      BM    D9954      ; =+6 [Branch on minus]
994e:      SABB             ; [AL - BL -> BL]
994f:      BZ    D9954      ; =+3 [Branch if zero]
9951:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
9953:      DB    X'12'      ; =0x12 =18 [abort code]
*
9954:D9954 LDA+  Z,6        ; [Load A indexed, displaced, direct]
9957:      BZ    D995B      ; =+2 [Branch if zero]
9959:      JSR   F9974      ; =+25 [Jump to subroutine relative]
995b:D995B JMP   D99D2      ; =+117 [Jump relative]
*
* Function F995D
*
995d:F995D LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
995f:      STAB  B9967      ; =+6 [Store AL relative]
9961:      XFR   Z,B        ; [Transfer Z to B]
9963:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
9965:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
9966:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
9967:B9967 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
9968:      DW    L996E+1    ; =0x996f =39279(-26257) [TODO: address]
996a:      XFR   B,B        ; [Transfer B to B]
996c:      BZ    D9973      ; =+5 [Branch if zero]
996e:L996E LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
9971:      XFR   A,A        ; [Transfer A to A]
9973:D9973 RSR              ; [Return from subroutine]
*
* Function F9974
*
9974:F9974 JSR   F995D      ; =-25 [Jump to subroutine relative]
9976:      DB    X'02'      ; =0x02 =2
9977:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
997a:      SUB   B,A        ; [B - A -> A]
997c:      BL    D9982      ; =+4 [Branch on link]
997e:      LDAB= X'01'      ; =1 [Load AL with immediate]
9980:      JMP   D9996      ; =+20 [Jump relative]
9982:D9982 LDA+  Z,22       ; [Load A indexed, displaced, direct]
9985:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9988:      STA+  Z,8        ; [Store A indexed, displaced, direct]
998b:      JSR   F99A0      ; =+19 [Jump to subroutine relative]
998d:      DB    X'01'      ; =0x01 =1
998e:      LDB+  Z,18       ; [Load B indexed, displaced, direct]
9991:      INR   B          ; [Increment B by 1]
9993:      STB+  Z,22       ; [Store B indexed, displaced, direct]
9996:D9996 STAB+ Z          ; [Store AL to address in Z]
9997:      RSR              ; [Return from subroutine]
*
* Function F9998
*
9998:F9998 LDAB+ Z          ; [Load AL from address in Z]
9999:      BP    D999F      ; =+4 [Branch on plus]
999b:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
999d:      JMP   F9998      ; =-7 [Jump relative]
999f:D999F RSR              ; [Return from subroutine]
*
* Function F99A0
*
99a0:F99A0 XFR   Z,B        ; [Transfer Z to B]
99a2:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
99a4:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
99a7:      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
99a9:      JSR   F9998      ; =-19 [Jump to subroutine relative]
99ab:      RSR              ; [Return from subroutine]
*
99ac:W99AC STX-  S-         ; [Store X indexed, pre-decremented, direct]
99ae:D99AE LDA+  Z,6        ; [Load A indexed, displaced, direct]
99b1:      INR   A,2        ; [Increment A by 2]
99b3:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
99b6:      STB+  Z,20       ; [Store B indexed, displaced, direct]
99b9:      ADD   B,A        ; [B + A -> A]
99bb:      XAY              ; [Transfer A to Y]
99bc:      LDA+  Y          ; [Load A from address in Y]
99bd:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
99bf:      LDAB= X'01'      ; =1 [Load AL with immediate]
99c1:      SUBB  AU,BL      ; [AU - BL -> BL]
99c3:      BZ    D99D1      ; =+12 [Branch if zero]
99c5:      DCRB  AU         ; [Decrement AU by 1]
99c7:      BNF   D99D6      ; =+13 [Branch on no fault]
99c9:      JSR   F9974      ; =-87 [Jump to subroutine relative]
99cb:      CLA              ; [Clear A]
99cc:      STA+  Z,24       ; [Store A indexed, displaced, direct]
99cf:      JMP   D99AE      ; =-35 [Jump relative]
99d1:D99D1 STAB+ Z          ; [Store AL to address in Z]
99d2:D99D2 LDB+  S+         ; [Load B indexed, direct, post-incremented]
99d4:      SVC   X'68'      ; =104 [Service call RLSR - return from LSR]
99d6:D99D6 LDA+  Y          ; [Load A from address in Y]
99d7:      CLRB  AU         ; [Clear AU]
99d9:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
99dc:      ADD   B,A        ; [B + A -> A]
99de:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
99e1:      AAB              ; [A + B -> B]
99e2:      STB+  Z,24       ; [Store B indexed, displaced, direct]
99e5:      LDB+  Z,16       ; [Load B indexed, displaced, direct]
99e8:      XAX              ; [Transfer A to X]
99e9:      CLA              ; [Clear A]
99ea:D99EA DCX              ; [Decrement X]
99eb:      BLE   D99F5      ; =+8 [Branch if less than or equal to zero]
99ed:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
99ef:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
99f1:      ADDB  AL,AU      ; [AL + AU -> AU]
99f3:      JMP   D99EA      ; =-11 [Jump relative]
99f5:D99F5 LDAB+ Y          ; [Load AL from address in Y]
99f6:      ADDB  AU,AL      ; [AU + AL -> AL]
99f8:      BZ    D99D1      ; =-41 [Branch if zero]
99fa:      LDAB= X'04'      ; =4 [Load AL with immediate]
99fc:      JMP   D99D1      ; =-45 [Jump relative]
99fe:W99FE STX-  S-         ; [Store X indexed, pre-decremented, direct]
9a00:D9A00 LDA+  Z,6        ; [Load A indexed, displaced, direct]
9a03:      INR   A,2        ; [Increment A by 2]
9a05:      XAY              ; [Transfer A to Y]
9a06:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
9a09:      STA+  Z,20       ; [Store A indexed, displaced, direct]
9a0c:      ADD   A,Y        ; [A + Y -> Y]
9a0e:      LDX+  Z,16       ; [Load X indexed, displaced, direct]
9a11:      LDB+  X          ; [Load B from address in X]
9a12:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
9a14:      SUBB  BL,BU      ; [BL - BU -> BU]
9a16:      BNZ   D9A1B      ; =+3 [Branch if not zero]
9a18:      STBB+ Y          ; [Store BL to address in Y]
9a19:      JMP   D9A4C      ; =+49 [Jump relative]
9a1b:D9A1B LDB+  X          ; [Load B from address in X]
9a1c:      CLRB  BU         ; [Clear BU]
9a1e:      AAB              ; [A + B -> B]
9a1f:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
9a22:      AAB              ; [A + B -> B]
9a23:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9a26:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
9a29:      SAB              ; [A - B -> B]
9a2a:      BP    D9A32      ; =+6 [Branch on plus]
9a2c:      JSR   F9A5E      ; =+48 [Jump to subroutine relative]
9a2e:      BZ    D9A00      ; =-48 [Branch if zero]
9a30:      JMP   D99D1      ; =-97 [Jump relative]
9a32:D9A32 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9a34:      XAB              ; [Transfer A to B]
9a35:      CLRB  AU         ; [Clear AU]
9a37:      STB+  Y+         ; [Store B indexed, direct, post-incremented]
9a39:      ADDB  BL,BU      ; [BL + BU -> BU]
9a3b:      INA              ; [Increment A]
9a3c:D9A3C LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
9a3e:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9a40:      ADDB  BL,BU      ; [BL + BU -> BU]
9a42:      DCA              ; [Decrement A]
9a43:      BP    D9A3C      ; =-9 [Branch on plus]
9a45:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
9a47:      IVRB  BU         ; [Invert BU]
9a49:      INRB  BU         ; [Increment BU by 1]
9a4b:      STB+  Y          ; [Store B to address in Y]
9a4c:D9A4C CLAB             ; [Clear AL]
9a4d:D9A4D JMP   D99D1      ; =-126 [Jump relative]
*
* Function F9A4F
*
9a4f:F9A4F CLA              ; [Clear A]
9a50:      STA+  Z,24       ; [Store A indexed, displaced, direct]
9a53:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
9a56:      STA+  Z,8        ; [Store A indexed, displaced, direct]
9a59:      JSR/  F99A0      ; =0x99a0 =39328(-26208) [Jump to subroutine direct]
9a5c:      DB    X'02'      ; =0x02 =2
9a5d:      RSR              ; [Return from subroutine]
*
* Function F9A5E
*
9a5e:F9A5E JSR   F9A4F      ; =-17 [Jump to subroutine relative]
9a60:      BNZ   D9A7D      ; =+27 [Branch if not zero]
9a62:      JSR/  F995D      ; =0x995d =39261(-26275) [Jump to subroutine direct]
9a65:      DB    X'02'      ; =0x02 =2
9a66:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
9a69:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9a6c:      INA              ; [Increment A]
9a6d:      STA+  Z,22       ; [Store A indexed, displaced, direct]
9a70:      DCA              ; [Decrement A]
9a71:      SUB   B,A        ; [B - A -> A]
9a73:      BL    D9A7C      ; =+7 [Branch on link]
9a75:      XFR   Z,B        ; [Transfer Z to B]
9a77:      SVC   X'19'      ; =25 [Service call EXP - file expand]
9a79:      XAB              ; [Transfer A to B]
9a7a:      BNZ   D9A7E      ; =+2 [Branch if not zero]
9a7c:D9A7C CLA              ; [Clear A]
9a7d:D9A7D RSR              ; [Return from subroutine]
*
9a7e:D9A7E LDAB= X'02'      ; =2 [Load AL with immediate]
9a80:      RSR              ; [Return from subroutine]
*
9a81:W9A81 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9a83:      JSR   F9A4F      ; =-54 [Jump to subroutine relative]
9a85:      JMP   D9A4D      ; =-58 [Jump relative]
*
* Function F9A87
*
9a87:F9A87 LDB+  X+         ; [Load B indexed, direct, post-incremented]
9a89:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
9a8b:      STB   W9AAB      ; =+30 [Store B relative]
9a8d:      XFRB  AL,AU      ; [Transfer AL to AU]
9a8f:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9a91:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
9a93:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
9a95:      STB   W9AAD      ; =+22 [Store B relative]
9a97:      XAB              ; [Transfer A to B]
9a98:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9a9a:      SUBB  AU,AL      ; [AU - AL -> AL]
9a9c:      BM    D9AA0      ; =+2 [Branch on minus]
9a9e:      XFRB  BL,AU      ; [Transfer BL to AU]
9aa0:D9AA0 XFRB  AU,AL      ; [Transfer AU to AL]
9aa2:      CLRB  AU         ; [Clear AU]
9aa4:      STA   W9AA9      ; =+3 [Store A relative]
9aa6:      JSR/  F9ABD      ; =0x9abd =39613(-25923) [Jump to subroutine direct]
9aa9:W9AA9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9aab:W9AAB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9aad:W9AAD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9aaf:      XFRB  BL,BL      ; [Transfer BL to BL]
9ab1:      BNZ   D9AB8      ; =+5 [Branch if not zero]
9ab3:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
9ab5:      SUBB  BU,BL      ; [BU - BL -> BL]
9ab7:      RSR              ; [Return from subroutine]
*
9ab8:D9AB8 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9aba:      XFRB  BL,BL      ; [Transfer BL to BL]
9abc:      RSR              ; [Return from subroutine]
*
* Function F9ABD
*
9abd:F9ABD STK   Y,2        ; [Push Y to the stack]
9abf:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9ac1:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9ac3:      XFR   B,Y        ; [Transfer B to Y]
9ac5:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9ac7:      DCA              ; [Decrement A]
9ac8:      CPFR  -Y,-B      ; [Compare fixed-length (len in AL), indexed, indexed]
9acb:      BZ    D9AD4      ; =+7 [Branch if zero]
9acd:      BP    D9AD9      ; =+10 [Branch on plus]
9acf:      POP   Y,2        ; [Pop Y from the stack]
9ad1:      LDBB= X'01'      ; =1 [Load BL with immediate]
9ad3:      RSR              ; [Return from subroutine]
*
9ad4:D9AD4 POP   Y,2        ; [Pop Y from the stack]
9ad6:      CLRB  BL         ; [Clear BL]
9ad8:      RSR              ; [Return from subroutine]
*
9ad9:D9AD9 POP   Y,2        ; [Pop Y from the stack]
9adb:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
9add:      RSR              ; [Return from subroutine]
*
* Function F9ADE
*
9ade:F9ADE STK   Y,2        ; [Push Y to the stack]
9ae0:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9ae2:      DCA              ; [Decrement A]
9ae3:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9ae5:      XFR   B,Y        ; [Transfer B to Y]
9ae7:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9ae9:      MVL              ; [Move long (len in A, src in B, dst in Y)]
9aea:      POP   Y,2        ; [Pop Y from the stack]
9aec:      RSR              ; [Return from subroutine]
*
* Function F9AED
*
9aed:F9AED STK   Y,2        ; [Push Y to the stack]
9aef:      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
9af3:      INR   X,2        ; [Increment X by 2]
9af5:      DCA              ; [Decrement A]
9af6:      BP    D9AFC      ; =+4 [Branch on plus]
9af8:      INR   X,2        ; [Increment X by 2]
9afa:      JMP   D9B0F      ; =+19 [Jump relative]
9afc:D9AFC FILR  =' ',-Y    ; [Fill with byte (len in AL), literal=0xa0(160,-96), indexed]
9b00:      INA              ; [Increment A]
9b01:      SAB              ; [A - B -> B]
9b02:      BLE   D9B07      ; =+3 [Branch if less than or equal to zero]
9b04:      SAB              ; [A - B -> B]
9b05:      XFR   B,A        ; [Transfer B to A]
9b07:D9B07 LDB+  X+         ; [Load B indexed, direct, post-incremented]
9b09:      DCA              ; [Decrement A]
9b0a:      BM    D9B0F      ; =+3 [Branch on minus]
9b0c:      MVFR  -B,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
9b0f:D9B0F POP   Y,2        ; [Pop Y from the stack]
9b11:      RSR              ; [Return from subroutine]
*
* Function F9B12
*
9b12:F9B12 STK   Y,2        ; [Push Y to the stack]
9b14:      DCA              ; [Decrement A]
9b15:      BM    D9B27      ; =+16 [Branch on minus]
9b17:      XAY              ; [Transfer A to Y]
9b18:      CLRB  AU         ; [Clear AU]
9b1a:D9B1A FILR  -X,-B      ; [Fill with byte (len in AL), indexed, indexed]
9b1d:      INA              ; [Increment A]
9b1e:      AAB              ; [A + B -> B]
9b1f:      LDA=  X'00FF'    ; =0x00ff =255 [Load A with immediate]
9b22:      DCRB  YU         ; [Decrement YU by 1]
9b24:      BP    D9B1A      ; =-12 [Branch on plus]
9b26:      INX              ; [Increment X]
9b27:D9B27 POP   Y,2        ; [Pop Y from the stack]
9b29:      RSR              ; [Return from subroutine]
*
* Function F9B2A
*
9b2a:F9B2A LDA+  X+         ; [Load A indexed, direct, post-incremented]
9b2c:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9b2e:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9b30:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
9b32:      BLE   D9B42      ; =+14 [Branch if less than or equal to zero]
9b34:      ADD   X,A        ; [X + A -> A]
9b36:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
9b39:D9B39 LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
9b3b:      SUBB  BU,BL      ; [BU - BL -> BL]
9b3d:      BNZ   D9B42      ; =+3 [Branch if not zero]
9b3f:      DCX              ; [Decrement X]
9b40:      BGZ   D9B39      ; =-9 [Branch if greater than zero]
9b42:D9B42 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9b44:      STX+  A          ; [Store X indexed, direct]
9b46:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9b48:      RSR              ; [Return from subroutine]
*
9b49:J9B49 JMP/  J9E6F      ; =0x9e6f =40559(-24977) [Jump direct]
*
9b4c:      DS    400        ; =0x0190 [Uninitialized memory]
9cdc:W9CDC DS    403        ; =0x0193 [Uninitialized memory]
*
9e6f:J9E6F XFR=  W80C8,S    ; =0x80c8 =32968(-32568) [Transfer immediate to S]
9e73:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
9e75:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
9e76:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
9e77:      DB    X'0C'      ; =0x0c =12 [TODO: arg3]
9e78:      DW    S884C      ; =0x884c =34892(-30644) [address to store block value]
*
9e7a:      JSR/  F9F12      ; =0x9f12 =40722(-24814) [Jump to subroutine direct]
9e7d:      DW    W9F8A      ; =0x9f8a =40842(-24694)
9e7f:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
9e81:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
9e82:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
9e83:      DB    X'12'      ; =0x12 =18 [TODO: arg3]
9e84:      DW    W9EA8+1    ; =0x9ea9 =40617(-24919) [address to store block value]
9e86:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
9e88:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
9e89:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
9e8a:      DB    X'15'      ; =0x15 =21 [TODO: arg3]
9e8b:W9E8B DW    W9E8B      ; =0x9e8b =40587(-24949) [address to store block value]
9e8d:      LDAB  W9E8B      ; =-4 [Load AL relative]
9e8f:      SRAB             ; [Right shift AL]
9e90:      BL    D9E97      ; =+5 [Branch on link]
9e92:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
9e94:      STBB/ B9F81      ; =0x9f81 =40833(-24703) [Store BL direct]
9e97:D9E97 SRAB             ; [Right shift AL]
9e98:      BNL   D9ECA      ; =+48 [Branch on no link]
9e9a:      LDA=  W9FA2      ; =0x9fa2 =40866(-24670) [Load A with immediate]
9e9d:      STA/  W9F90      ; =0x9f90 =40848(-24688) [Store A direct]
9ea0:      JSR   F9F12      ; =+112 [Jump to subroutine relative]
9ea2:      DW    W9F8A      ; =0x9f8a =40842(-24694)
*
9ea4:      JSR   F9F12      ; =+108 [Jump to subroutine relative]
9ea6:      DW    W9F80      ; =0x9f80 =40832(-24704)
9ea8:W9EA8 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9eaa:      LDBB= X'20'      ; =32 [Load BL with immediate]
9eac:      NABB             ; [AL & BL -> BL]
9ead:      BNZ   D9EB4      ; =+5 [Branch if not zero]
9eaf:      LDA=  S82B1      ; =0x82b1 =33457(-32079) [Load A with immediate]
9eb2:      STA   W9EC6      ; =+18 [Store A relative]
9eb4:D9EB4 LDA=  S8284      ; =0x8284 =33412(-32124) [Load A with immediate]
9eb7:      LDB   W9EC6      ; =+13 [Load B relative]
9eb9:      SUB   B,A        ; [B - A -> A]
9ebb:      LDB/  W9FB0      ; =0x9fb0 =40880(-24656) [Load B direct]
9ebe:      ADD   B,A        ; [B + A -> A]
9ec0:      STA/  W8282      ; =0x8282 =33410(-32126) [Store A direct]
9ec3:      JSR/  F9AED      ; =0x9aed =39661(-25875) [Jump to subroutine direct]
9ec6:W9EC6 DW    S82BC      ; =0x82bc =33468(-32068)
9ec8:      DW    ENDPT      ; =0x9fb2 =40882(-24654)
*
9eca:D9ECA LDA=  S829C      ; =0x829c =33436(-32100) [Load A with immediate]
9ecd:      LDB/  S9F96      ; =0x9f96 =40854(-24682) [Load B direct]
9ed0:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9ed2:      LDB/  S9F98      ; =0x9f98 =40856(-24680) [Load B direct]
9ed5:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9ed7:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9ed9:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
9edb:      LDB/  S9F9D      ; =0x9f9d =40861(-24675) [Load B direct]
9ede:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9ee0:      LDB/  S9F9F      ; =0x9f9f =40863(-24673) [Load B direct]
9ee3:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9ee5:      INR   A,2        ; [Increment A by 2]
9ee7:      STA   W9EEE      ; =+5 [Store A relative]
9ee9:      SVC   X'0B'      ; =11 [Service call DT - get binary date]
9eeb:      SVC   X'05'      ; =5 [Service call TS - load transient module]
9eed:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
9eee:W9EEE DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of string date]
9ef0:      LDA   W9EEE      ; =-4 [Load A relative]
9ef2:      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
9ef5:      ADD   B,A        ; [B + A -> A]
9ef7:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
9efa:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9efc:      STA   W9F07      ; =+9 [Store A relative]
9efe:      LDAB  W9EA8+1    ; =-87 [Load AL relative]
9f00:      LDBB= X'20'      ; =32 [Load BL with immediate]
9f02:      NABB             ; [AL & BL -> BL]
9f03:      BZ    D9F1E      ; =+25 [Branch if zero]
9f05:      SVC   X'1C'      ; =28 [Service call GC - get character time]
9f07:W9F07 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address to put time]
9f09:      LDA   W9F07      ; =-4 [Load A relative]
9f0b:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9f0d:      STBB+ A,8        ; [Store BL indexed, displaced, direct]
9f10:      JMP   D9F24      ; =+18 [Jump relative]
*
* Function F9F12
*
9f12:F9F12 LDB+  X          ; [Load B from address in X]
9f13:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
9f15:D9F15 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
9f17:      LDB+  X          ; [Load B from address in X]
9f18:      LDAB+ B          ; [Load AL from address in B]
9f19:      BM    D9F15      ; =-6 [Branch on minus]
9f1b:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
9f1d:      RSR              ; [Return from subroutine]
*
9f1e:D9F1E LDA=  S82B1      ; =0x82b1 =33457(-32079) [Load A with immediate]
9f21:      STA/  W8B01+1    ; =0x8b02 =35586(-29950) [Store A direct]
9f24:D9F24 LDA=  J9B49      ; =0x9b49 =39753(-25783) [Load A with immediate]
9f27:      XAY              ; [Transfer A to Y]
9f28:      LDB=  W8106      ; =0x8106 =33030(-32506) [Load B with immediate]
9f2b:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
9f2d:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
9f2e:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
9f2f:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
9f30:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: address]
9f32:      XFR   B,B        ; [Transfer B to B]
9f34:      BZ    D9F48      ; =+18 [Branch if zero]
9f36:      LDA=  J9B49      ; =0x9b49 =39753(-25783) [Load A with immediate]
9f39:      STA/  S810C      ; =0x810c =33036(-32500) [Store A direct]
9f3c:      ADD=  X'0193',Y  ; =0x0193 =403 [403 + Y -> Y]
9f40:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
9f43:      STA/  W8110      ; =0x8110 =33040(-32496) [Store A direct]
9f46:      JMP   D9F4D      ; =+5 [Jump relative]
9f48:D9F48 LDA=  J9B49      ; =0x9b49 =39753(-25783) [Load A with immediate]
9f4b:      STA   W9F5B+1    ; =+15 [Store A relative]
9f4d:D9F4D LDB=  W8124      ; =0x8124 =33060(-32476) [Load B with immediate]
9f50:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
9f52:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
9f53:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
9f54:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
9f55:W9F55 DW    W9F55      ; =0x9f55 =40789(-24747) [address to store block value]
9f57:      LDBB  W9F55      ; =-4 [Load BL relative]
9f59:      BZ    D9F6A      ; =+15 [Branch if zero]
9f5b:W9F5B LDA=  W9CDC      ; =0x9cdc =40156(-25380) [Load A with immediate]
9f5e:      STA/  S812A      ; =0x812a =33066(-32470) [Store A direct]
9f61:      ADD=  X'0193',Y  ; =0x0193 =403 [403 + Y -> Y]
9f65:      LDB=  W8124      ; =0x8124 =33060(-32476) [Load B with immediate]
9f68:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
9f6a:D9F6A LDB=  W80CA      ; =0x80ca =32970(-32566) [Load B with immediate]
9f6d:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
9f6f:      LDB=  W80E8      ; =0x80e8 =33000(-32536) [Load B with immediate]
9f72:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
9f74:      LDB=  W8106      ; =0x8106 =33030(-32506) [Load B with immediate]
9f77:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
9f79:      STR/  W884A,Y    ; =0x884a =34890(-30646) [Store Y direct]
9f7d:      JMP/  J8843      ; =0x8843 =34883(-30653) [Jump direct]
*
9f80:W9F80 DB    X'00'      ; =0x00 =0 =NUL
9f81:B9F81 DW    X'8100'    ; =0x8100 =33024(-32512)
9f83:      DW    X'0100'    ; =0x0100 =256
9f85:      DB    X'57'      ; =0x57 =87
9f86:      DW    W9FB0      ; =0x9fb0 =40880(-24656)
9f88:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9f8a:W9F8A DW    X'0082'    ; =0x0082 =130
9f8c:      DB    X'00'      ; =0x00 =0 =NUL
9f8d:      DW    X'0200'    ; =0x0200 =512
9f8f:      DB    X'50'      ; =0x50 =80
9f90:W9F90 DW    W9F94      ; =0x9f94 =40852(-24684)
9f92:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9f94:W9F94 DW    X'000C'    ; =0x000c =12
9f96:S9F96 DC    'AS'       ; hex:c1d3 dec:49619(-45)
9f98:S9F98 DC    'SM5  '    ; hex:d3cdb5a0a0
9f9d:S9F9D DC    '6.'       ; hex:b6ae dec:46766(-82)
9f9f:S9F9F DC    '01'       ; hex:b0b1 dec:45233(-79)
9fa1:      DB    X'8D'      ; =0x8d =141(-115) =CR
9fa2:W9FA2 DW    X'000C'    ; =0x000c =12
9fa4:      DC    'ENTER TITLE'
9faf:      DB    X'8D'      ; =0x8d =141(-115) =CR
9fb0:W9FB0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9fb2:ENDPT
