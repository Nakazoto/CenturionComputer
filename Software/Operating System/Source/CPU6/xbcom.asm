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
80c8:W80C8 DS    70         ; =0x0046 [Uninitialized memory]
810e:W810E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8110:      DW    X'0109'    ; =0x0109 =265
8112:      DW    X'0190'    ; =0x0190 =400
8114:      DW    ENTRY      ; =0x82b1 =33457(-32079)
8116:      DB    0,3        ; =0x00,0x0003
8119:      DW    X'0102'    ; =0x0102 =258
811b:      DW    X'0200'    ; =0x0200 =512
811d:      DB    X'84'      ; =0x84 =132(-124) =EOT
811e:      DW    W85D7      ; =0x85d7 =34263(-31273)
8120:      DB    0,11       ; =0x00,0x000b
812b:      DB    X'84'      ; =0x84 =132(-124) =EOT
812c:W812C DW    X'0001'    ; =0x0001 =1
812e:      DW    X'0209'    ; =0x0209 =521
8130:      DW    X'0190'    ; =0x0190 =400
8132:      DW    W8444      ; =0x8444 =33860(-31676)
8134:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8136:      DW    W9CB8      ; =0x9cb8 =40120(-25416)
8138:      DW    X'0204'    ; =0x0204 =516
813a:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
813c:S813C DB    0,13       ; =0x00,0x000d
8149:      DB    X'84'      ; =0x84 =132(-124) =EOT
814a:W814A DW    X'0002'    ; =0x0002 =2
814c:      DW    X'0209'    ; =0x0209 =521
814e:      DW    X'0190'    ; =0x0190 =400
8150:S8150 DB    0,4        ; =0x00,0x0004
8154:W8154 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8156:      DW    X'0102'    ; =0x0102 =258
8158:      DW    X'0084'    ; =0x0084 =132 =NUL,EOT
815a:S815A DB    0,13       ; =0x00,0x000d
8167:      DB    X'84'      ; =0x84 =132(-124) =EOT
*
8168:J8168 JSR   F81B5      ; =+75 [Jump to subroutine relative]
816a:      DW    W824A      ; =0x824a =33354(-32182)
*
816c:      JSR   F818C      ; =+30 [Jump to subroutine relative]
816e:      DB    X'0B'      ; =0x0b =11
816f:      DW    W812C      ; =0x812c =33068(-32468)
8171:      LDA=  W8248      ; =0x8248 =33352(-32184) [Load A with immediate]
8174:      JSR   F81D0      ; =+90 [Jump to subroutine relative]
8176:      JSR   F818C      ; =+20 [Jump to subroutine relative]
8178:      DB    X'0B'      ; =0x0b =11
8179:      DW    W814A      ; =0x814a =33098(-32438)
817b:      LDA/  W824D      ; =0x824d =33357(-32179) [Load A direct]
817e:      BZ    D8182      ; =+2 [Branch if zero]
8180:      LDAB= X'01'      ; =1 [Load AL with immediate]
8182:D8182 STAB  B818B      ; =+7 [Store AL relative]
8184:      JSR/  F9C48      ; =0x9c48 =40008(-25528) [Jump to subroutine direct]
8187:      DW    W82A5      ; =0x82a5 =33445(-32091)
8189:      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
818b:B818B DB    X'00'      ; =0x00 =0 =NUL [completion code]
*
* Function F818C
*
818c:F818C LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
818e:      LDB+  X          ; [Load B from address in X]
818f:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8192:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8194:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8196:      LDAB+ B          ; [Load AL from address in B]
8197:      RSR              ; [Return from subroutine]
*
* Function F8198
*
8198:F8198 JSR   F818C      ; =-14 [Jump to subroutine relative]
819a:      DB    X'01'      ; =0x01 =1
819b:      DW    W810E      ; =0x810e =33038(-32498)
819d:      BZ    D81A6      ; =+7 [Branch if zero]
819f:      MVF   (12)/W8299,/W85D7 ; =0x8299 =33433(-32103),=0x85d7 =34263(-31273) [Move fixed-length, direct, direct]
81a6:D81A6 JSR/  F9C21      ; =0x9c21 =39969(-25567) [Jump to subroutine direct]
81a9:      DW    W85D7      ; =0x85d7 =34263(-31273)
81ab:      JSR   F81C6      ; =+25 [Jump to subroutine relative]
81ad:      DW    W85D7      ; =0x85d7 =34263(-31273)
81af:      LDA=  W85D7+2    ; =0x85d9 =34265(-31271) [Load A with immediate]
81b2:      STA+  X+         ; [Store A indexed, direct, post-incremented]
81b4:D81B4 RSR              ; [Return from subroutine]
*
* Function F81B5
*
81b5:F81B5 LDA+  X+         ; [Load A indexed, direct, post-incremented]
81b7:      STA/  S813C      ; =0x813c =33084(-32452) [Store A direct]
81ba:      JSR   F818C      ; =-48 [Jump to subroutine relative]
81bc:      DB    X'02'      ; =0x02 =2
81bd:      DW    W812C      ; =0x812c =33068(-32468)
81bf:      BZ    D81B4      ; =-13 [Branch if zero]
81c1:D81C1 SVC   X'09'      ; =9 [Service call ABRT - abort task]
81c3:      DB    X'34'      ; =0x34 =52 [abort code]
*
81c4:D81C4 JSR   F8208      ; =+66 [Jump to subroutine relative]
*
* Function F81C6
*
81c6:F81C6 LDA/  W824B      ; =0x824b =33355(-32181) [Load A direct]
81c9:      DCA              ; [Decrement A]
81ca:      STA   W824B      ; =+127 [Store A relative]
81cc:      BLE   D81C4      ; =-10 [Branch if less than or equal to zero]
81ce:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
*
* Function F81D0
*
81d0:F81D0 STA   W81D5      ; =+3 [Store A relative]
81d2:      JSR/  F9E28      ; =0x9e28 =40488(-25048) [Jump to subroutine direct]
81d5:W81D5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
81d7:      LDB   W81D5      ; =-4 [Load B relative]
81d9:D81D9 STB/  S815A      ; =0x815a =33114(-32422) [Store B direct]
81dc:      LDA+  B          ; [Load A from address in B]
81dd:      BLE   D8202      ; =+35 [Branch if less than or equal to zero]
81df:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
81e1:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
81e3:      INA              ; [Increment A]
81e4:      STA+  B+         ; [Store A indexed, direct, post-incremented]
81e6:      AAB              ; [A + B -> B]
81e7:      LDAB- B-         ; [Load AL indexed, pre-decremented, direct]
81e9:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
81eb:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
81ed:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
81ef:      STAB+ B          ; [Store AL to address in B]
81f0:      JSR/  F818C      ; =0x818c =33164(-32372) [Jump to subroutine direct]
81f3:      DB    X'02'      ; =0x02 =2
81f4:      DW    W814A      ; =0x814a =33098(-32438)
81f6:      BNZ   D81C1      ; =-55 [Branch if not zero]
81f8:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
81fa:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
81fc:      STAB+ B          ; [Store AL to address in B]
81fd:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
81ff:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8201:      STA+  B          ; [Store A to address in B]
8202:D8202 RSR              ; [Return from subroutine]
*
* Function F8203
*
8203:F8203 LDB=  W8242      ; =0x8242 =33346(-32190) [Load B with immediate]
8206:      JMP   D81D9      ; =-47 [Jump relative]
*
* Function F8208
*
8208:F8208 LDA=  W8245      ; =0x8245 =33349(-32187) [Load A with immediate]
820b:      JSR   F81D0      ; =-61 [Jump to subroutine relative]
820d:      JSR   F8203      ; =-12 [Jump to subroutine relative]
820f:      JSR   F8203      ; =-14 [Jump to subroutine relative]
8211:      JSR   F8203      ; =-16 [Jump to subroutine relative]
8213:      JSR   F8203      ; =-18 [Jump to subroutine relative]
8215:      JSR   F8203      ; =-20 [Jump to subroutine relative]
8217:      JSR   F8203      ; =-22 [Jump to subroutine relative]
8219:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
821b:      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
821e:      STA   S8263      ; =+67 [Store A relative]
8220:      STA   S8270      ; =+78 [Store A relative]
8222:      LDA   W824F      ; =+43 [Load A relative]
8224:      INA              ; [Increment A]
8225:      STA   W824F      ; =+40 [Store A relative]
8227:      JSR   F8253      ; =+42 [Jump to subroutine relative]
8229:      DW    S8265      ; =0x8265 =33381(-32155)
822b:      LDA   W824D      ; =+32 [Load A relative]
822d:      JSR   F8253      ; =+36 [Jump to subroutine relative]
822f:      DW    S8272      ; =0x8272 =33394(-32142)
8231:      LDA=  W825C      ; =0x825c =33372(-32164) [Load A with immediate]
8234:      JSR   F81D0      ; =-102 [Jump to subroutine relative]
8236:      JSR   F8203      ; =-53 [Jump to subroutine relative]
8238:      JSR   F8203      ; =-55 [Jump to subroutine relative]
823a:      LDA=  X'002E'    ; =0x002e =46 [Load A with immediate]
823d:      STA   W824B      ; =+12 [Store A relative]
823f:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8241:      RSR              ; [Return from subroutine]
*
8242:W8242 DW    X'0001'    ; =0x0001 =1
8244:      DC    ' '        ; hex:a0 dec:160(-96)
8245:W8245 DW    X'0001'    ; =0x0001 =1
8247:      DB    X'8C'      ; =0x8c =140(-116) =FF
8248:W8248 DW    X'0001'    ; =0x0001 =1
824a:W824A DB    X'84'      ; =0x84 =132(-124) =EOT
824b:W824B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
824d:W824D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
824f:W824F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8251:      DW    X'9541'    ; =0x9541 =38209(-27327)
*
* Function F8253
*
8253:F8253 LDB+  X+         ; [Load B indexed, direct, post-incremented]
8255:      STB   W8259      ; =+2 [Store B relative]
8257:      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
8259:W8259 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of end of string]
825b:      RSR              ; [Return from subroutine]
*
825c:W825C DW    X'003B'    ; =0x003b =59
825e:      DC    'PAGE '    ; hex:d0c1c7c5a0
8263:S8263 DC    '  '       ; hex:a0a0 dec:41120(-96)
8265:S8265 DC    '    ERRORS '
8270:S8270 DC    '  '       ; hex:a0a0 dec:41120(-96)
8272:S8272 DC    '     BASIC '
827d:S827D DC    'XX'       ; hex:d8d8 dec:55512(-40)
827f:S827F DC    'XX  '     ; hex:d8d8a0a0
8283:S8283 DC    'XX/XX/XX  ('
828e:S828E DC    'FFFFFFFFFF)'
8299:W8299 DW    X'0009'    ; =0x0009 =9
829b:      DC    '32767 END' ; hex:b3b2b7b6b7a0c5cec4
82a4:      DB    X'00'      ; =0x00 =0 =NUL
82a5:W82A5 DW    X'000A'    ; =0x000a =10
82a7:      DC    'END BCOM ' ; hex:c5cec4a0c2c3cfcda0
82b0:      DB    X'8D'      ; =0x8d =141(-115) =CR
*
* Function ENTRY
*
82b1:ENTRY XFR=  W80C8,S    ; =0x80c8 =32968(-32568) [Transfer immediate to S]
82b5:      JSR/  F9C48      ; =0x9c48 =40008(-25528) [Jump to subroutine direct]
82b8:      DW    W8304      ; =0x8304 =33540(-31996)
82ba:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
82bc:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
82bd:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
82be:      DB    X'15'      ; =0x15 =21 [TODO: arg3]
82bf:      DW    W8AEC+1    ; =0x8aed =35565(-29971) =LF,'m' [address to store block value]
82c1:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
82c3:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
82c4:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
82c5:      DB    X'0E'      ; =0x0e =14 [TODO: arg3]
82c6:      DW    W8730+1    ; =0x8731 =34609(-30927) [address to store block value]
82c8:      INC/  W8730+1    ; =0x8731 =34609(-30927) [Increment word at address by 1]
82cc:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
82ce:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
82cf:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
82d0:      DB    X'0C'      ; =0x0c =12 [TODO: arg3]
82d1:      DW    W8736+1    ; =0x8737 =34615(-30921) [address to store block value]
82d3:      LDB=  W814A      ; =0x814a =33098(-32438) [Load B with immediate]
82d6:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
82d8:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
82d9:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
82da:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
82db:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: address]
82dd:      XFR   B,B        ; [Transfer B to B]
82df:      BZ    D82F3      ; =+18 [Branch if zero]
82e1:      LDA/  W8730+1    ; =0x8731 =34609(-30927) [Load A direct]
82e4:      STA/  S8150      ; =0x8150 =33104(-32432) [Store A direct]
82e7:      ADD=  X'0193',A  ; =0x0193 =403 [403 + A -> A]
82eb:      STA/  W8730+1    ; =0x8731 =34609(-30927) [Store A direct]
82ee:      CLR   A,1        ; [Set A to 1]
82f0:      STA/  W8154      ; =0x8154 =33108(-32428) [Store A direct]
82f3:D82F3 XFR=  W810E,Y    ; =0x810e =33038(-32498) [Transfer immediate to Y]
82f7:      LDA   S830B      ; =+18 [Load A relative]
82f9:      STA/  S827D      ; =0x827d =33405(-32131) [Store A direct]
82fc:      LDA   S830D      ; =+15 [Load A relative]
82fe:      STA/  S827F      ; =0x827f =33407(-32129) [Store A direct]
8301:      JMP/  W8444      ; =0x8444 =33860(-31676) [Jump direct]
*
8304:W8304 DW    X'000A'    ; =0x000a =10
8306:      DC    'BCOM '    ; hex:c2c3cfcda0
830b:S830B DC    '6.'       ; hex:b6ae dec:46766(-82)
830d:S830D DC    '03'       ; hex:b0b3 dec:45235(-77)
830f:      DB    X'8D'      ; =0x8d =141(-115) =CR
8310:      DS    308        ; =0x0134 [Uninitialized memory]
8444:W8444 LDB=  W810E      ; =0x810e =33038(-32498) [Load B with immediate]
8447:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8449:      LDB=  W814A      ; =0x814a =33098(-32438) [Load B with immediate]
844c:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
844e:      SVC   X'0B'      ; =11 [Service call DT - get binary date]
8450:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8452:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8453:      DW    S8283      ; =0x8283 =33411(-32125) [address of string date]
8455:      LDB=  W810E      ; =0x810e =33038(-32498) [Load B with immediate]
8458:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
845a:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
845b:      DB    X'0A'      ; =0x0a =10 [TODO: arg2]
845c:      DB    X'1E'      ; =0x1e =30 [TODO: arg3]
845d:      DW    S828E      ; =0x828e =33422(-32114) [TODO: address]
845f:      JMP/  W85D7      ; =0x85d7 =34263(-31273) [Jump direct]
*
8462:      DS    373        ; =0x0175 [Uninitialized memory]
85d7:W85D7 LDB=  W812C      ; =0x812c =33068(-32468) [Load B with immediate]
85da:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
85dc:      JMP/  J865E      ; =0x865e =34398(-31138) [Jump direct]
*
85df:      DS    127        ; =0x007f [Uninitialized memory]
*
865e:J865E JMP/  W8730      ; =0x8730 =34608(-30928) [Jump direct]
*
8661:W8661 DW    X'00CB'    ; =0x00cb =203 =NUL,'K'
8663:      DB    0,142      ; =0x00,0x008e
86f1:      DB    X'55'      ; =0x55 =85
86f2:      DC    ':'        ; hex:ba dec:186(-70)
86f3:      DW    X'808C'    ; =0x808c =32908(-32628)
86f5:      DW    X'666A'    ; =0x666a =26218
86f7:      DB    0,9        ; =0x00,0x0009
8700:W8700 DW    X'00CB'    ; =0x00cb =203 =NUL,'K'
8702:W8702 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8704:W8704 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8706:W8706 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8708:W8708 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
870a:S870A DB    0,3        ; =0x00,0x0003
870d:      DC    'K'        ; hex:cb dec:203(-53)
870e:S870E DB    0,3        ; =0x00,0x0003
8711:W8711 DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8713:S8713 DB    0,29       ; =0x00,0x001d
8730:W8730 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8733:      STA/  W8790+1    ; =0x8791 =34705(-30831) [Store A direct]
8736:W8736 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8739:      STA/  W881D+1    ; =0x881e =34846(-30690) [Store A direct]
873c:      JMP/  J8DEF      ; =0x8def =36335(-29201) =CR,'o' [Jump direct]
*
* Function F873F
*
873f:F873F STX-  S-         ; [Store X indexed, pre-decremented, direct]
8741:      LDX   W8730+1    ; =-18 [Load X relative]
8743:D8743 LDA   W8790+1    ; =+76 [Load A relative]
8745:      SUB   X,A        ; [X - A -> A]
8747:      BP    D8763      ; =+26 [Branch on plus]
8749:      LDAB+ X,4        ; [Load AL indexed, displaced, direct]
874c:      LDBB= X'02'      ; =2 [Load BL with immediate]
874e:      NABB             ; [AL & BL -> BL]
874f:      BZ    D8758      ; =+7 [Branch if zero]
8751:      LDBB= X'01'      ; =1 [Load BL with immediate]
8753:      ORIB  AL,BL      ; [AL | BL -> BL]
8755:      STBB+ X,4        ; [Store BL indexed, displaced, direct]
8758:D8758 LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
875b:      ADD   A,X        ; [A + X -> X]
875d:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
875f:      ADD   A,X        ; [A + X -> X]
8761:      JMP   D8743      ; =-32 [Jump relative]
8763:D8763 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8765:      RSR              ; [Return from subroutine]
*
* Function F8766
*
8766:F8766 LDAB+ Z          ; [Load AL from address in Z]
8767:      JSR/  F8972      ; =0x8972 =35186(-30350) [Jump to subroutine direct]
876a:      BP    D876E      ; =+2 [Branch on plus]
876c:      CLAB             ; [Clear AL]
876d:      RSR              ; [Return from subroutine]
*
876e:D876E XFR   Z,A        ; [Transfer Z to A]
8770:      STA   W87CC+2    ; =+92 [Store A relative]
8772:D8772 INR   Z          ; [Increment Z by 1]
8774:      LDAB+ Z          ; [Load AL from address in Z]
8775:      JSR/  F897B      ; =0x897b =35195(-30341) [Jump to subroutine direct]
8778:      BP    D8772      ; =-8 [Branch on plus]
877a:      LDA   W87CC+2    ; =+82 [Load A relative]
877c:      SUB   Z,A        ; [Z - A -> A]
877e:      STA   W87C8+1    ; =+73 [Store A relative]
8780:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8783:      JSR/  F89BF      ; =0x89bf =35263(-30273) [Jump to subroutine direct]
8786:      STA   W87C2+1    ; =+59 [Store A relative]
8788:      LDAB= X'01'      ; =1 [Load AL with immediate]
878a:      RSR              ; [Return from subroutine]
*
* Function F878B
*
878b:F878B LDA/  W8730+1    ; =0x8731 =34609(-30927) [Load A direct]
878e:      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
8790:W8790 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8793:      SAB              ; [A - B -> B]
8794:      BP    D87DC      ; =+70 [Branch on plus]
8796:      STA+  Y          ; [Store A to address in Y]
8797:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
879a:      AAB              ; [A + B -> B]
879b:      CLA              ; [Clear A]
879c:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
879e:      STB   W87CC+4    ; =+48 [Store B relative]
87a0:      AAB              ; [A + B -> B]
87a1:      STB   W87D7+1    ; =+53 [Store B relative]
87a3:      LDB   W87C8+1    ; =+36 [Load B relative]
87a5:      SAB              ; [A - B -> B]
87a6:      BNZ   W87D7      ; =+47 [Branch if not zero]
87a8:      LDB+  Y          ; [Load B from address in Y]
87a9:      LDAB+ B,4        ; [Load AL indexed, displaced, direct]
87ac:      LDBB= X'01'      ; =1 [Load BL with immediate]
87ae:      NABB             ; [AL & BL -> BL]
87af:      BNZ   W87D7      ; =+38 [Branch if not zero]
87b1:      LDBB= X'04'      ; =4 [Load BL with immediate]
87b3:      NABB             ; [AL & BL -> BL]
87b4:      BNZ   W87C8      ; =+18 [Branch if not zero]
87b6:      LDA+  *Y         ; [Load A indexed, indirect]
87b8:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
87bb:      NAB              ; [A & B -> B]
87bc:      BNZ   W87C8      ; =+10 [Branch if not zero]
87be:      LDB=  X'B000'    ; =0xb000 =45056(-20480) ='0',NUL [Load B with immediate]
87c1:      NAB              ; [A & B -> B]
87c2:W87C2 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
87c5:      SAB              ; [A - B -> B]
87c6:      BNZ   W87D7      ; =+15 [Branch if not zero]
87c8:W87C8 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
87cb:      DCA              ; [Decrement A]
87cc:W87CC CPFR  /X'0000',/X'0000' ; =0x0000 =0 =NUL,NUL,=0x0000 =0 =NUL,NUL [Compare fixed-length (len in AL), direct, direct]
87d2:      BNZ   W87D7      ; =+3 [Branch if not zero]
87d4:      LDAB= X'01'      ; =1 [Load AL with immediate]
87d6:      RSR              ; [Return from subroutine]
*
87d7:W87D7 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
87da:      JMP   W8790      ; =-76 [Jump relative]
87dc:D87DC STX-  S-         ; [Store X indexed, pre-decremented, direct]
87de:D87DE LDX   W8790+1    ; =-79 [Load X relative]
87e0:      XFR   X,B        ; [Transfer X to B]
87e2:      STB+  Y          ; [Store B to address in Y]
87e3:      INR   B,6        ; [Increment B by 6]
87e5:      ADD/  W87C8+1,B  ; =0x87c9 =34761(-30775) =BEL,'I' [Direct + B -> B]
87e9:      LDA   W881D+1    ; =+51 [Load A relative]
87eb:      SAB              ; [A - B -> B]
87ec:      BL    D87F2      ; =+4 [Branch on link]
87ee:      JSR   F8835      ; =+69 [Jump to subroutine relative]
87f0:      JMP   D87DE      ; =-20 [Jump relative]
87f2:D87F2 LDA   W87C2+1    ; =-49 [Load A relative]
87f4:      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
87f7:      JSR/  F89DE      ; =0x89de =35294(-30242) [Jump to subroutine direct]
87fa:      STA+  X+         ; [Store A indexed, direct, post-incremented]
87fc:      CLA              ; [Clear A]
87fd:      DCA              ; [Decrement A]
87fe:      STA+  X+         ; [Store A indexed, direct, post-incremented]
8800:      INA              ; [Increment A]
8801:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
8803:      LDA   W87C8+1    ; =-60 [Load A relative]
8805:      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
8807:      LDA   W87C8+1    ; =-64 [Load A relative]
8809:      DCA              ; [Decrement A]
880a:      LDB   W87CC+2    ; =-62 [Load B relative]
880c:      MVFR  -B,-X      ; [Move fixed-length (len in AL), indexed, indexed]
880f:      INA              ; [Increment A]
8810:      ADD   A,X        ; [A + X -> X]
8812:      STX/  W8790+1    ; =0x8791 =34705(-30831) [Store X direct]
8815:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8817:      CLAB             ; [Clear AL]
8818:      RSR              ; [Return from subroutine]
*
* Function F8819
*
8819:F8819 INC/  W8702      ; =0x8702 =34562(-30974) [Increment word at address by 1]
881d:W881D LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8820:      LDB/  W8790+1    ; =0x8791 =34705(-30831) [Load B direct]
8823:      INR   B,4        ; [Increment B by 4]
8825:      SAB              ; [A - B -> B]
8826:      BL    D882C      ; =+4 [Branch on link]
8828:      JSR   F8835      ; =+11 [Jump to subroutine relative]
882a:      JMP   W881D      ; =-15 [Jump relative]
882c:D882C LDB+  Y          ; [Load B from address in Y]
882d:      STB-  A-         ; [Store B indexed, pre-decremented, direct]
882f:      DCR   A,2        ; [Decrement A by 2]
8831:      STA+  Y          ; [Store A to address in Y]
8832:      STA   W881D+1    ; =-22 [Store A relative]
8834:      RSR              ; [Return from subroutine]
*
* Function F8835
*
8835:F8835 LDB/  W881D+1    ; =0x881e =34846(-30690) [Load B direct]
8838:      SUB/  W8736+1,B,A ; =0x8737 =34615(-30921) [Direct - B -> A]
883c:      STA/  W8870      ; =0x8870 =34928(-30608) [Store A direct]
883f:      CLR   B          ; [Clear B]
8841:D8841 SVC   X'59'      ; =89 [Service call ASEG - add next free mem segment to CURTB [wait for comp]]
8843:      ADD=  X'0800',B  ; =0x0800 =2048 [2048 + B -> B]
8847:      S     =2048,/N886F(3) ; =0x886f =34927(-30609) [Subtract bignums, literal=0x0800, direct]
884e:      BGZ   D8841      ; =-15 [Branch if greater than zero]
8850:      XFR   B,A        ; [Transfer B to A]
8852:      LDB/  W8736+1    ; =0x8737 =34615(-30921) [Load B direct]
8855:      AAB              ; [A + B -> B]
8856:      STB/  W8736+1    ; =0x8737 =34615(-30921) [Store B direct]
8859:      STK   Y,2        ; [Push Y to the stack]
885b:      LDB/  W881D+1    ; =0x881e =34846(-30690) [Load B direct]
885e:      XFR   B,Y        ; [Transfer B to Y]
8860:      ADD   A,Y        ; [A + Y -> Y]
8862:      SUB/  W8736+1,Y,A ; =0x8737 =34615(-30921) [Direct - Y -> A]
8866:      DCA              ; [Decrement A]
8867:      MVL              ; [Move long (len in A, src in B, dst in Y)]
8868:      STR/  W881D+1,Y  ; =0x881e =34846(-30690) [Store Y direct]
886c:      POP   Y,2        ; [Pop Y from the stack]
886e:      RSR              ; [Return from subroutine]
*
886f:N886F DB    X'00'      ; =0x00 =0 =NUL
8870:W8870 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function F8872
*
8872:F8872 LDAB+ Z          ; [Load AL from address in Z]
8873:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8875:      SABB             ; [AL - BL -> BL]
8876:      BZ    D887F      ; =+7 [Branch if zero]
8878:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
887a:      SABB             ; [AL - BL -> BL]
887b:      BZ    D887F      ; =+2 [Branch if zero]
887d:      CLAB             ; [Clear AL]
887e:      RSR              ; [Return from subroutine]
*
887f:D887F INR   Z          ; [Increment Z by 1]
8881:      XFR   Z,B        ; [Transfer Z to B]
8883:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8885:D8885 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8887:      BZ    D8892      ; =+9 [Branch if zero]
8889:      SABB             ; [AL - BL -> BL]
888a:      BNZ   D8885      ; =-7 [Branch if not zero]
888c:      LDA+  S          ; [Load A from address in S]
888d:      SUB   Z,A        ; [Z - A -> A]
888f:      DCA              ; [Decrement A]
8890:      JMP   D889B      ; =+9 [Jump relative]
8892:D8892 DCR   Z          ; [Decrement Z by 1]
8894:      JSR/  F8BC8      ; =0x8bc8 =35784(-29752) =VT,'H' [Jump to subroutine direct]
8897:      DB    X'09'      ; =0x09 =9
8898:      LDA+  S          ; [Load A from address in S]
8899:      SUB   Z,A        ; [Z - A -> A]
889b:D889B STA-  Y-         ; [Store A indexed, pre-decremented, direct]
889d:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
88a0:      DB    X'03'      ; =0x03 =3
88a1:      LDA+  Y          ; [Load A from address in Y]
88a2:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
88a5:      LDA+  S          ; [Load A from address in S]
88a6:      STX+  S          ; [Store X indexed, direct]
88a8:      XAX              ; [Transfer A to X]
88a9:D88A9 LDA+  Y          ; [Load A from address in Y]
88aa:      BLE   D88B5      ; =+9 [Branch if less than or equal to zero]
88ac:      DCA              ; [Decrement A]
88ad:      STA+  Y          ; [Store A to address in Y]
88ae:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
88b0:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
88b3:      JMP   D88A9      ; =-12 [Jump relative]
88b5:D88B5 LDX+  S+         ; [Load X indexed, direct, post-incremented]
88b7:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
88b9:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
88bc:      LDAB= X'01'      ; =1 [Load AL with immediate]
88be:      RSR              ; [Return from subroutine]
*
* Function F88BF
*
88bf:F88BF XFR   Z,A        ; [Transfer Z to A]
88c1:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
88c3:      LDAB+ Z          ; [Load AL from address in Z]
88c4:      JSR/  F8966      ; =0x8966 =35174(-30362) [Jump to subroutine direct]
88c7:      BP    D88D2      ; =+9 [Branch on plus]
88c9:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
88cb:      SABB             ; [AL - BL -> BL]
88cc:      BZ    D8903      ; =+53 [Branch if zero]
88ce:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
88d0:      CLA              ; [Clear A]
88d1:      RSR              ; [Return from subroutine]
*
88d2:D88D2 JSR   F8924      ; =+80 [Jump to subroutine relative]
88d4:      BP    D88D2      ; =-4 [Branch on plus]
88d6:      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
88d8:      SABB             ; [AL - BL -> BL]
88d9:      BZ    D8903      ; =+40 [Branch if zero]
88db:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
88de:      DC    '%'        ; hex:a5 dec:165(-91)
88df:      DB    X'01'      ; =0x01 =1
88e0:      BNZ   D88EA      ; =+8 [Branch if not zero]
88e2:      LDA+  S          ; [Load A from address in S]
88e3:      SUB   Z,A        ; [Z - A -> A]
88e5:      LDBB= X'04'      ; =4 [Load BL with immediate]
88e7:      SABB             ; [AL - BL -> BL]
88e8:      BGZ   D8909      ; =+31 [Branch if greater than zero]
88ea:D88EA LDA+  S          ; [Load A from address in S]
88eb:      XFR   Z,B        ; [Transfer Z to B]
88ed:      STB+  S          ; [Store B to address in S]
88ee:      XAZ              ; [Transfer A to Z]
88ef:      JSR   F892F      ; =+62 [Jump to subroutine relative]
88f1:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
88f4:      DB    X'04'      ; =0x04 =4
88f5:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
88f7:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
88fa:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
88fc:      XAZ              ; [Transfer A to Z]
88fd:D88FD JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8900:      LDAB= X'01'      ; =1 [Load AL with immediate]
8902:      RSR              ; [Return from subroutine]
*
8903:D8903 INR   Z          ; [Increment Z by 1]
8905:D8905 JSR   F8924      ; =+29 [Jump to subroutine relative]
8907:      BP    D8905      ; =-4 [Branch on plus]
8909:D8909 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
890c:      DB    X'05'      ; =0x05 =5
890d:      LDA+  S          ; [Load A from address in S]
890e:      STX+  S          ; [Store X indexed, direct]
8910:      XAX              ; [Transfer A to X]
8911:D8911 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8913:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
8916:      XFR   X,A        ; [Transfer X to A]
8918:      SUB   Z,A        ; [Z - A -> A]
891a:      BGZ   D8911      ; =-11 [Branch if greater than zero]
891c:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
891e:      CLAB             ; [Clear AL]
891f:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
8922:      JMP   D88FD      ; =-39 [Jump relative]
*
* Function F8924
*
8924:F8924 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8926:      JSR   F8966      ; =+62 [Jump to subroutine relative]
8928:      BP    D892E      ; =+4 [Branch on plus]
892a:      DCR   Z          ; [Decrement Z by 1]
892c:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
892e:D892E RSR              ; [Return from subroutine]
*
* Function F892F
*
892f:F892F JSR   F8924      ; =-13 [Jump to subroutine relative]
8931:      BP    D8935      ; =+2 [Branch on plus]
8933:      CLA              ; [Clear A]
8934:      RSR              ; [Return from subroutine]
*
8935:D8935 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8937:      CLA              ; [Clear A]
8938:      XAX              ; [Transfer A to X]
8939:D8939 XFR   X,A        ; [Transfer X to A]
893b:      SLA              ; [Left shift A]
893c:      BF    D895C      ; =+30 [Branch on fault]
893e:      SLA              ; [Left shift A]
893f:      BF    D895C      ; =+27 [Branch on fault]
8941:      ADD   X,A        ; [X + A -> A]
8943:      BF    D895C      ; =+23 [Branch on fault]
8945:      SLA              ; [Left shift A]
8946:      BF    D895C      ; =+20 [Branch on fault]
8948:      CLRB  BU         ; [Clear BU]
894a:      AAB              ; [A + B -> B]
894b:      BF    D895C      ; =+15 [Branch on fault]
894d:      XFR   B,X        ; [Transfer B to X]
894f:      JSR   F8924      ; =-45 [Jump to subroutine relative]
8951:      BP    D8939      ; =-26 [Branch on plus]
8953:D8953 JSR   F89AA      ; =+85 [Jump to subroutine relative]
8955:      STX-  Y-         ; [Store X indexed, pre-decremented, direct]
8957:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8959:      LDAB= X'01'      ; =1 [Load AL with immediate]
895b:      RSR              ; [Return from subroutine]
*
895c:D895C JSR/  F8BC8      ; =0x8bc8 =35784(-29752) =VT,'H' [Jump to subroutine direct]
895f:      DB    X'0A'      ; =0x0a =10
*
8960:D8960 JSR   F8924      ; =-62 [Jump to subroutine relative]
8962:      BP    D8960      ; =-4 [Branch on plus]
8964:      JMP   D8953      ; =-19 [Jump relative]
*
* Function F8966
*
8966:F8966 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
8968:      SABB             ; [AL - BL -> BL]
8969:      BLE   D896E      ; =+3 [Branch if less than or equal to zero]
896b:D896B LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
896d:      RSR              ; [Return from subroutine]
*
896e:D896E LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8970:      SABB             ; [AL - BL -> BL]
8971:      RSR              ; [Return from subroutine]
*
* Function F8972
*
8972:F8972 LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
8974:      SABB             ; [AL - BL -> BL]
8975:      BGZ   D896B      ; =-12 [Branch if greater than zero]
8977:      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
8979:      SABB             ; [AL - BL -> BL]
897a:D897A RSR              ; [Return from subroutine]
*
* Function F897B
*
897b:F897B JSR   F8972      ; =-11 [Jump to subroutine relative]
897d:      BP    D897A      ; =-5 [Branch on plus]
897f:      JMP   F8966      ; =-27 [Jump relative]
*
* Function F8981
*
8981:F8981 XFR   Z,A        ; [Transfer Z to A]
8983:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8985:      CLAB             ; [Clear AL]
8986:D8986 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8988:      BP    D8998      ; =+14 [Branch on plus]
898a:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
898c:      SABB             ; [AL - BL -> BL]
898d:      BZ    D8986      ; =-9 [Branch if zero]
898f:D898F LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8991:      BM    D898F      ; =-4 [Branch on minus]
8993:D8993 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8995:      XAZ              ; [Transfer A to Z]
8996:      CLA              ; [Clear A]
8997:      RSR              ; [Return from subroutine]
*
8998:D8998 JSR   F897B      ; =-31 [Jump to subroutine relative]
899a:      BM    D89A1      ; =+5 [Branch on minus]
899c:      LDAB+ Z          ; [Load AL from address in Z]
899d:      JSR   F897B      ; =-36 [Jump to subroutine relative]
899f:      BP    D8993      ; =-14 [Branch on plus]
89a1:D89A1 JSR   F89AA      ; =+7 [Jump to subroutine relative]
89a3:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
89a5:      CLA              ; [Clear A]
89a6:      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
89a9:      RSR              ; [Return from subroutine]
*
* Function F89AA
*
89aa:F89AA LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
89ac:D89AC LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
89ae:      SABB             ; [AL - BL -> BL]
89af:      BZ    D89AC      ; =-5 [Branch if zero]
89b1:      DCR   Z          ; [Decrement Z by 1]
89b3:      RSR              ; [Return from subroutine]
*
* Function F89B4
*
89b4:F89B4 JSR   F8981      ; =-53 [Jump to subroutine relative]
89b6:      DC    ')'        ; hex:a9 dec:169(-87)
89b7:      DB    X'01'      ; =0x01 =1
89b8:      BNZ   D89BE      ; =+4 [Branch if not zero]
89ba:      JSR/  F8BC8      ; =0x8bc8 =35784(-29752) =VT,'H' [Jump to subroutine direct]
89bd:      DB    X'07'      ; =0x07 =7
*
89be:D89BE RSR              ; [Return from subroutine]
*
* Function F89BF
*
89bf:F89BF JSR   F8981      ; =-64 [Jump to subroutine relative]
89c1:      DC    '%'        ; hex:a5 dec:165(-91)
89c2:      DB    X'10'      ; =0x10 =16
89c3:      BNZ   D89C9      ; =+4 [Branch if not zero]
89c5:      JSR   F8981      ; =-70 [Jump to subroutine relative]
89c7:      DC    '$'        ; hex:a4 dec:164(-92)
89c8:      DB    X'20'      ; =0x20 =32
*
89c9:D89C9 XFRB  AL,AU      ; [Transfer AL to AU]
89cb:      CLAB             ; [Clear AL]
89cc:      RSR              ; [Return from subroutine]
*
* Function F89CD
*
89cd:F89CD LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
89d0:      NAB              ; [A & B -> B]
89d1:      BZ    D89D4      ; =+1 [Branch if zero]
89d3:      RSR              ; [Return from subroutine]
*
89d4:D89D4 LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
89d7:      NAB              ; [A & B -> B]
89d8:      BNZ   D89DB      ; =+1 [Branch if not zero]
89da:      RSR              ; [Return from subroutine]
*
89db:D89DB LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
89dd:      RSR              ; [Return from subroutine]
*
* Function F89DE
*
89de:F89DE STA-  S-         ; [Store A indexed, pre-decremented, direct]
89e0:      XFR   A,A        ; [Transfer A to A]
89e2:      BP    D89EF      ; =+11 [Branch on plus]
89e4:      LDA/  S8713      ; =0x8713 =34579(-30957) [Load A direct]
89e7:      AAB              ; [A + B -> B]
89e8:      STB/  S8713      ; =0x8713 =34579(-30957) [Store B direct]
89eb:      BL    D8A23      ; =+54 [Branch on link]
89ed:      JMP   D8A18      ; =+41 [Jump relative]
89ef:D89EF STK   B,2        ; [Push B to the stack]
89f1:      JSR   F89CD      ; =-38 [Jump to subroutine relative]
89f3:      POP   B,2        ; [Pop B from the stack]
89f5:      BM    D8A04      ; =+13 [Branch on minus]
89f7:      BGZ   D8A0F      ; =+22 [Branch if greater than zero]
89f9:      LDA/  W8704      ; =0x8704 =34564(-30972) [Load A direct]
89fc:      AAB              ; [A + B -> B]
89fd:      STB/  W8704      ; =0x8704 =34564(-30972) [Store B direct]
8a00:      BL    D8A23      ; =+33 [Branch on link]
8a02:      JMP   D8A18      ; =+20 [Jump relative]
8a04:D8A04 LDA/  W8708      ; =0x8708 =34568(-30968) [Load A direct]
8a07:      AAB              ; [A + B -> B]
8a08:      STB/  W8708      ; =0x8708 =34568(-30968) [Store B direct]
8a0b:      BL    D8A23      ; =+22 [Branch on link]
8a0d:      JMP   D8A18      ; =+9 [Jump relative]
8a0f:D8A0F LDA/  W8706      ; =0x8706 =34566(-30970) [Load A direct]
8a12:      AAB              ; [A + B -> B]
8a13:      STB/  W8706      ; =0x8706 =34566(-30970) [Store B direct]
8a16:      BL    D8A23      ; =+11 [Branch on link]
8a18:D8A18 AND=  X'F000',B,P ; =0xf000 =61440(-4096) ='p',NUL [61440 & B -> P]
8a1c:      BNZ   D8A23      ; =+5 [Branch if not zero]
8a1e:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8a20:      ORI   B,A        ; [B | A -> A]
8a22:      RSR              ; [Return from subroutine]
*
8a23:D8A23 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8a26:      DB    X'10'      ; =0x10 =16
*
8a27:W8A27 LDA=  W8A4E      ; =0x8a4e =35406(-30130) [Load A with immediate]
8a2a:      LDB=  F8A5E      ; =0x8a5e =35422(-30114) [Load B with immediate]
8a2d:      SAB              ; [A - B -> B]
8a2e:      BM    D8A34      ; =+4 [Branch on minus]
8a30:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8a33:      DB    X'0D'      ; =0x0d =13
*
8a34:D8A34 LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
8a37:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8a39:      STA   W8A27+1    ; =-19 [Store A relative]
8a3b:      RSR              ; [Return from subroutine]
*
* Function F8A3C
*
8a3c:F8A3C LDB   W8A27+1    ; =-22 [Load B relative]
8a3e:      LDA=  W8A4E      ; =0x8a4e =35406(-30130) [Load A with immediate]
8a41:      SUB   B,A        ; [B - A -> A]
8a43:      BGZ   D8A49      ; =+4 [Branch if greater than zero]
8a45:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8a48:      DB    X'0C'      ; =0x0c =12
*
8a49:D8A49 LDA-  B-         ; [Load A indexed, pre-decremented, direct]
8a4b:      STB   W8A27+1    ; =-37 [Store B relative]
8a4d:      RSR              ; [Return from subroutine]
*
8a4e:W8A4E DS    16         ; =0x0010 [Uninitialized memory]
*
* Function F8A5E
*
8a5e:F8A5E XFR   Z,A        ; [Transfer Z to A]
8a60:      STA   W8A76+1    ; =+21 [Store A relative]
8a62:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8a64:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8a66:      XAX              ; [Transfer A to X]
8a67:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8a69:D8A69 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8a6b:      BZ    W8A76      ; =+9 [Branch if zero]
8a6d:      SABB             ; [AL - BL -> BL]
8a6e:      BZ    D8A81      ; =+17 [Branch if zero]
8a70:      BM    W8A76      ; =+4 [Branch on minus]
8a72:      INR   X,2        ; [Increment X by 2]
8a74:      JMP   D8A69      ; =-13 [Jump relative]
8a76:W8A76 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8a79:      XAZ              ; [Transfer A to Z]
8a7a:      CLAB             ; [Clear AL]
8a7b:D8A7B LDX+  S+         ; [Load X indexed, direct, post-incremented]
8a7d:      CLRB  AU         ; [Clear AU]
8a7f:      XAB              ; [Transfer A to B]
8a80:      RSR              ; [Return from subroutine]
*
8a81:D8A81 LDX+  X          ; [Load X indexed, direct]
8a83:D8A83 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8a85:      BZ    W8A76      ; =-17 [Branch if zero]
8a87:      BGZ   D8A99      ; =+16 [Branch if greater than zero]
8a89:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8a8b:      SABB             ; [AL - BL -> BL]
8a8c:      BZ    D8A83      ; =-11 [Branch if zero]
8a8e:      LDA   W8A76+1    ; =-25 [Load A relative]
8a90:      XAZ              ; [Transfer A to Z]
8a91:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8a93:D8A93 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8a95:      BM    D8A93      ; =-4 [Branch on minus]
8a97:      JMP   D8A83      ; =-22 [Jump relative]
8a99:D8A99 JSR/  F897B      ; =0x897b =35195(-30341) [Jump to subroutine direct]
8a9c:      BM    D8AA4      ; =+6 [Branch on minus]
8a9e:      LDAB+ Z          ; [Load AL from address in Z]
8a9f:      JSR/  F897B      ; =0x897b =35195(-30341) [Jump to subroutine direct]
8aa2:      BP    W8A76      ; =-46 [Branch on plus]
8aa4:D8AA4 JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8aa7:      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
8aaa:      JMP   D8A7B      ; =-49 [Jump relative]
*
* Function F8AAC
*
8aac:F8AAC LDAB  W8AEC+1    ; =+63 [Load AL relative]
8aae:      SRAB             ; [Right shift AL]
8aaf:      BNL   D8AB9      ; =+8 [Branch on no link]
8ab1:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8ab4:      JSR/  F8253      ; =0x8253 =33363(-32173) [Jump to subroutine direct]
8ab7:      DW    S8C17      ; =0x8c17 =35863(-29673)
*
8ab9:D8AB9 LDAB= X'80'      ; =128(-128) [Load AL with immediate]
8abb:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8abd:      ORIB  BL,AL      ; [BL | AL -> AL]
8abf:      JSR   F8ACC      ; =+11 [Jump to subroutine relative]
8ac1:      RSR              ; [Return from subroutine]
*
* Function F8AC2
*
8ac2:F8AC2 STA-  S-         ; [Store A indexed, pre-decremented, direct]
8ac4:      LDAB+ S          ; [Load AL from address in S]
8ac5:      JSR   F8ACC      ; =+5 [Jump to subroutine relative]
8ac7:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8ac9:      JSR   F8ACC      ; =+1 [Jump to subroutine relative]
8acb:      RSR              ; [Return from subroutine]
*
* Function F8ACC
*
8acc:F8ACC STAB  B8AF3+1    ; =+38 [Store AL relative]
8ace:      LDAB  B8B31      ; =+97 [Load AL relative]
8ad0:      INAB             ; [Increment AL]
8ad1:      LDBB= X'78'      ; =120 [Load BL with immediate]
8ad3:      SABB             ; [AL - BL -> BL]
8ad4:      BLE   D8ADA      ; =+4 [Branch if less than or equal to zero]
8ad6:      JSR   F8B1E      ; =+70 [Jump to subroutine relative]
8ad8:      LDAB= X'01'      ; =1 [Load AL with immediate]
8ada:D8ADA STAB  B8B31      ; =+85 [Store AL relative]
8adc:      CLRB  AU         ; [Clear AU]
8ade:      LDB=  S8B33      ; =0x8b33 =35635(-29901) [Load B with immediate]
8ae1:      AAB              ; [A + B -> B]
8ae2:      LDAB  B8AF3+1    ; =+16 [Load AL relative]
8ae4:      STAB+ B          ; [Store AL to address in B]
8ae5:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8ae8:      INA              ; [Increment A]
8ae9:      STA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Store A direct]
8aec:W8AEC LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8aee:      SRAB             ; [Right shift AL]
8aef:      BL    D8AF2      ; =+1 [Branch on link]
8af1:      RSR              ; [Return from subroutine]
*
8af2:D8AF2 CLA              ; [Clear A]
8af3:B8AF3 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8af5:      SRRB  AL,4       ; [Right shift AL by 4]
8af7:      JSR   F8B0C      ; =+19 [Jump to subroutine relative]
8af9:      STBB/ S8C19      ; =0x8c19 =35865(-29671) [Store BL direct]
8afc:      LDAB  B8AF3+1    ; =-10 [Load AL relative]
8afe:      JSR   F8B0C      ; =+12 [Jump to subroutine relative]
8b00:      STBB/ S8C1A      ; =0x8c1a =35866(-29670) [Store BL direct]
8b03:      JSR/  F81C6      ; =0x81c6 =33222(-32314) [Jump to subroutine direct]
8b06:      DW    W8C10      ; =0x8c10 =35856(-29680)
*
8b08:      JSR/  F8C03      ; =0x8c03 =35843(-29693) [Jump to subroutine direct]
8b0b:      RSR              ; [Return from subroutine]
*
* Function F8B0C
*
8b0c:F8B0C LDBB= X'0F'      ; =15 [Load BL with immediate]
8b0e:      NABB             ; [AL & BL -> BL]
8b0f:      LDAB= X'09'      ; =9 [Load AL with immediate]
8b11:      SUBB  BL,AL      ; [BL - AL -> AL]
8b13:      BLE   D8B19      ; =+4 [Branch if less than or equal to zero]
8b15:      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
8b17:      JMP   D8B1B      ; =+2 [Jump relative]
8b19:D8B19 LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
8b1b:D8B1B ORIB  AL,BL      ; [AL | BL -> BL]
8b1d:      RSR              ; [Return from subroutine]
*
* Function F8B1E
*
8b1e:F8B1E LDAB  B8B31      ; =+17 [Load AL relative]
8b20:      BZ    D8B27      ; =+5 [Branch if zero]
8b22:      JSR/  F81B5      ; =0x81b5 =33205(-32331) [Jump to subroutine direct]
8b25:      DW    W8B30      ; =0x8b30 =35632(-29904)
*
8b27:D8B27 LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8b2a:      STA   W8B32      ; =+6 [Store A relative]
8b2c:      CLAB             ; [Clear AL]
8b2d:      STAB  B8B31      ; =+2 [Store AL relative]
8b2f:      RSR              ; [Return from subroutine]
*
8b30:W8B30 DB    X'00'      ; =0x00 =0 =NUL
8b31:B8B31 DB    X'00'      ; =0x00 =0 =NUL
8b32:W8B32 DB    X'00'      ; =0x00 =0 =NUL
8b33:S8B33 DC    'K'        ; hex:cb dec:203(-53)
8b34:W8B34 DS    122        ; =0x007a [Uninitialized memory]
*
*
* Function F8BAE
*
8bae:F8BAE STB-  S-         ; [Store B indexed, pre-decremented, direct]
8bb0:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8bb2:      JSR/  F8B1E      ; =0x8b1e =35614(-29922) [Jump to subroutine direct]
8bb5:      LDAB= X'02'      ; =2 [Load AL with immediate]
8bb7:      STAB/ B8B31      ; =0x8b31 =35633(-29903) [Store AL direct]
8bba:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8bbc:      STA/  W8B32      ; =0x8b32 =35634(-29902) [Store A direct]
8bbf:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8bc1:      STA/  W8B34      ; =0x8b34 =35636(-29900) [Store A direct]
8bc4:      JSR/  F8B1E      ; =0x8b1e =35614(-29922) [Jump to subroutine direct]
8bc7:      RSR              ; [Return from subroutine]
*
* Function F8BC8
*
8bc8:F8BC8 CLA              ; [Clear A]
8bc9:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8bcb:      JSR/  F8253      ; =0x8253 =33363(-32173) [Jump to subroutine direct]
8bce:      DW    S8C19      ; =0x8c19 =35865(-29671)
8bd0:      LDA=  X'AAAA'    ; =0xaaaa =43690(-21846) ='*','*' [Load A with immediate]
8bd3:      STA   S8C15      ; =+64 [Store A relative]
8bd5:      JSR/  F81C6      ; =0x81c6 =33222(-32314) [Jump to subroutine direct]
8bd8:W8BD8 DW    W8C10      ; =0x8c10 =35856(-29680)
8bda:      JSR   F8C03      ; =+39 [Jump to subroutine relative]
8bdc:P8BDC LDA/  W824D      ; =0x824d =33357(-32179) [Load A direct]
8bdf:      INA              ; [Increment A]
8be0:      STA*  P8BDC+1    ; =-5 [Store A relative indirect]
8be2:      RSR              ; [Return from subroutine]
*
* Function F8BE3
*
8be3:F8BE3 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8be5:      STAB  B8BE9      ; =+2 [Store AL relative]
8be7:      JSR   F8BC8      ; =-33 [Jump to subroutine relative]
8be9:B8BE9 DB    X'00'      ; =0x00 =0 =NUL
8bea:      JSR/  F81C6      ; =0x81c6 =33222(-32314) [Jump to subroutine direct]
8bed:      DW    W8BF4      ; =0x8bf4 =35828(-29708) =VT,'t'
8bef:      JSR   F8C21      ; =+48 [Jump to subroutine relative]
8bf1:      JMP/  J8E13      ; =0x8e13 =36371(-29165) [Jump direct]
*
8bf4:W8BF4 DW    X'000D'    ; =0x000d =13
8bf6:      DC    '   **REJECTED'
*
*
* Function F8C03
*
8c03:F8C03 LDB   W8BD8      ; =-45 [Load B relative]
8c05:      LDA=  X'000F'    ; =0x000f =15 [Load A with immediate]
8c08:      STA+  B+         ; [Store A indexed, direct, post-incremented]
8c0a:      FIL   (15)=' ',-B ; [Fill with byte, literal=0xa0(160,-96), indexed]
8c0f:      RSR              ; [Return from subroutine]
*
8c10:W8C10 DW    X'000F'    ; =0x000f =15
8c12:      DC    '   '      ; hex:a0a0a0
8c15:S8C15 DC    '  '       ; hex:a0a0 dec:41120(-96)
8c17:S8C17 DC    '  '       ; hex:a0a0 dec:41120(-96)
8c19:S8C19 DC    ' '        ; hex:a0 dec:160(-96)
8c1a:S8C1A DC    '       '  ; hex:a0a0a0a0a0a0a0
*
*
* Function F8C21
*
8c21:F8C21 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8c23:      BNZ   D8C28      ; =+3 [Branch if not zero]
8c25:      DCR   Z          ; [Decrement Z by 1]
8c27:      RSR              ; [Return from subroutine]
*
8c28:D8C28 LDBB= X'BA'      ; =186(-70) =':' [Load BL with immediate]
8c2a:      SABB             ; [AL - BL -> BL]
8c2b:      BNZ   F8C21      ; =-12 [Branch if not zero]
8c2d:      RSR              ; [Return from subroutine]
*
8c2e:W8C2E JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8c31:      DB    X'04'      ; =0x04 =4
8c32:      CLA              ; [Clear A]
8c33:      IVA              ; [Invert A]
8c34:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
8c37:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8c3a:      DB    X'1D'      ; =0x1d =29
8c3b:      JSR/  F81B5      ; =0x81b5 =33205(-32331) [Jump to subroutine direct]
8c3e:      DW    W8661      ; =0x8661 =34401(-31135)
8c40:      CLA              ; [Clear A]
8c41:W8C41 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8c44:W8C44 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8c47:      LDAB/ S870E      ; =0x870e =34574(-30962) [Load AL direct]
8c4a:      XAX              ; [Transfer A to X]
8c4b:      LDA=  W8D2F      ; =0x8d2f =36143(-29393) [Load A with immediate]
8c4e:      XAZ              ; [Transfer A to Z]
8c4f:D8C4F DCX              ; [Decrement X]
8c50:      BM    D8C8B      ; =+57 [Branch on minus]
8c52:      CLR   B          ; [Clear B]
8c54:      LDA=  X'0400'    ; =0x0400 =1024 [Load A with immediate]
8c57:      LDAB+ Z,5        ; [Load AL indexed, displaced, direct]
8c5a:      BM    D8C66      ; =+10 [Branch on minus]
8c5c:      ANDB  AL,AU      ; [AL & AU -> AU]
8c5e:      BNZ   D8C66      ; =+6 [Branch if not zero]
8c60:      SRAB             ; [Right shift AL]
8c61:      BNL   D8C66      ; =+3 [Branch on no link]
8c63:      LDB=  X'0193'    ; =0x0193 =403 [Load B with immediate]
8c66:D8C66 LDAB+ Z,5        ; [Load AL indexed, displaced, direct]
8c69:      SRRB  AL,2       ; [Right shift AL by 2]
8c6b:      BNL   D8C72      ; =+5 [Branch on no link]
8c6d:      LDA=  X'0036'    ; =0x0036 =54 [Load A with immediate]
8c70:      JMP   D8C75      ; =+3 [Jump relative]
8c72:D8C72 LDA=  X'0022'    ; =0x0022 =34 [Load A with immediate]
8c75:D8C75 AAB              ; [A + B -> B]
8c76:      LDA   W8C41+1    ; =-54 [Load A relative]
8c78:      AAB              ; [A + B -> B]
8c79:      STB   W8C41+1    ; =-57 [Store B relative]
8c7b:      JSR   F8C81      ; =+4 [Jump to subroutine relative]
8c7d:      JSR   F8C81      ; =+2 [Jump to subroutine relative]
8c7f:      JMP   D8C4F      ; =-50 [Jump relative]
*
* Function F8C81
*
8c81:F8C81 LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8c83:P8C83 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
8c86:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8c88:      JSR*  P8C83+1    ; =-6 [Jump to subroutine relative indirect]
8c8a:      RSR              ; [Return from subroutine]
*
8c8b:D8C8B LDA=  W8DAF      ; =0x8daf =36271(-29265) =CR,'/' [Load A with immediate]
8c8e:      XAZ              ; [Transfer A to Z]
8c8f:      LDX/  S8713      ; =0x8713 =34579(-30957) [Load X direct]
8c92:D8C92 DCX              ; [Decrement X]
8c93:      BM    D8CA6      ; =+17 [Branch on minus]
8c95:      LDA+  Z          ; [Load A from address in Z]
8c96:      BP    D8CA2      ; =+10 [Branch on plus]
8c98:      LDA+  Z,2        ; [Load A indexed, displaced, direct]
8c9b:      INR   A,3        ; [Increment A by 3]
8c9d:      LDB   W8C44+1    ; =-90 [Load B relative]
8c9f:      AAB              ; [A + B -> B]
8ca0:      STB   W8C44+1    ; =-93 [Store B relative]
8ca2:D8CA2 JSR   F8C81      ; =-35 [Jump to subroutine relative]
8ca4:      JMP   D8C92      ; =-20 [Jump relative]
8ca6:D8CA6 LDA/  W8736+1    ; =0x8737 =34615(-30921) [Load A direct]
8ca9:      XAZ              ; [Transfer A to Z]
8caa:D8CAA LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
8cac:      JSR*  P8C83+1    ; =-42 [Jump to subroutine relative indirect]
8cae:      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
8cb0:      JSR*  P8C83+1    ; =-46 [Jump to subroutine relative indirect]
8cb2:      LDA/  W881D+1    ; =0x881e =34846(-30690) [Load A direct]
8cb5:      SUB   Z,A        ; [Z - A -> A]
8cb7:      BNZ   D8CAA      ; =-15 [Branch if not zero]
8cb9:      JSR/  F8B1E      ; =0x8b1e =35614(-29922) [Jump to subroutine direct]
8cbc:      CLA              ; [Clear A]
8cbd:      STAB/ B8B31      ; =0x8b31 =35633(-29903) [Store AL direct]
8cc0:      LDA=  X'008C'    ; =0x008c =140 =NUL,FF [Load A with immediate]
8cc3:      STA/  W8B32      ; =0x8b32 =35634(-29902) [Store A direct]
8cc6:      JSR/  F81B5      ; =0x81b5 =33205(-32331) [Jump to subroutine direct]
8cc9:      DW    W8B30      ; =0x8b30 =35632(-29904)
8ccb:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8ccd:      DB    X'0C'      ; =0x0c =12 [Selector: TODO]
8cce:      DW    W810E      ; =0x810e =33038(-32498) [address of TODO]
8cd0:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8cd2:      DB    X'0D'      ; =0x0d =13 [Selector: TODO]
8cd3:      DW    W812C      ; =0x812c =33068(-32468) [address of TODO]
8cd5:      LDA/  W824D      ; =0x824d =33357(-32179) [Load A direct]
8cd8:P8CD8 JSR/  F8253      ; =0x8253 =33363(-32173) [Jump to subroutine direct]
8cdb:      DW    S8D17      ; =0x8d17 =36119(-29417)
8cdd:      LDA/  W8704      ; =0x8704 =34564(-30972) [Load A direct]
8ce0:      SLA              ; [Left shift A]
8ce1:      XAB              ; [Transfer A to B]
8ce2:      SLA              ; [Left shift A]
8ce3:      AAB              ; [A + B -> B]
8ce4:      LDA/  W8706      ; =0x8706 =34566(-30970) [Load A direct]
8ce7:      SLA              ; [Left shift A]
8ce8:      AAB              ; [A + B -> B]
8ce9:      LDA/  W8708      ; =0x8708 =34568(-30968) [Load A direct]
8cec:      SLR   A,2        ; [Left shift A by 2]
8cee:      AAB              ; [A + B -> B]
8cef:      LDA/  W8C41+1    ; =0x8c42 =35906(-29630) [Load A direct]
8cf2:      AAB              ; [A + B -> B]
8cf3:      LDA/  W8C44+1    ; =0x8c45 =35909(-29627) [Load A direct]
8cf6:      AAB              ; [A + B -> B]
8cf7:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8cfa:      ADD   B,A        ; [B + A -> A]
8cfc:      JSR*  P8CD8+1    ; =-37 [Jump to subroutine relative indirect]
8cfe:      DW    S8D25      ; =0x8d25 =36133(-29403)
8d00:      JSR/  F8203      ; =0x8203 =33283(-32253) [Jump to subroutine direct]
8d03:      JSR/  F81C6      ; =0x81c6 =33222(-32314) [Jump to subroutine direct]
8d06:      DW    W8D10      ; =0x8d10 =36112(-29424)
*
8d08:      JSR/  F9C48      ; =0x9c48 =40008(-25528) [Jump to subroutine direct]
8d0b:      DW    W8D10      ; =0x8d10 =36112(-29424)
8d0d:      JMP/  J8168      ; =0x8168 =33128(-32408) [Jump direct]
*
8d10:W8D10 DW    X'001D'    ; =0x001d =29
8d12:      DC    '     '    ; hex:a0a0a0a0a0
8d17:S8D17 DC    '  ERRORS,     '
8d25:S8D25 DC    ' =PGM-SIZE' ; hex:a0bdd0c7cdadd3c9dac5
8d2f:W8D2F DW    X'FFFF'    ; =0xffff =65535(-1)
8d31:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d33:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d35:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d37:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d39:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d3b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d3d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d3f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d41:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d43:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d45:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d47:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d49:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d4b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d4d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d4f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d51:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d53:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d55:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d57:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d59:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d5b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d5d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d5f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d61:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d63:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d65:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d67:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d69:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d6b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d6d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d6f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d71:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d73:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d75:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d77:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d79:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d7b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d7d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d7f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d81:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d83:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d85:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d87:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d89:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d8b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d8d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d8f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d91:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d93:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d95:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d97:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d99:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d9b:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d9d:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d9f:      DW    X'FFFF'    ; =0xffff =65535(-1)
8da1:      DW    X'FFFF'    ; =0xffff =65535(-1)
8da3:      DW    X'FFFF'    ; =0xffff =65535(-1)
8da5:      DW    X'FFFF'    ; =0xffff =65535(-1)
8da7:      DW    X'FFFF'    ; =0xffff =65535(-1)
8da9:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dab:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dad:      DW    X'FFFF'    ; =0xffff =65535(-1)
8daf:W8DAF DW    X'FFFF'    ; =0xffff =65535(-1)
8db1:W8DB1 DW    X'FFFF'    ; =0xffff =65535(-1)
8db3:      DW    X'FFFF'    ; =0xffff =65535(-1)
8db5:      DW    X'FFFF'    ; =0xffff =65535(-1)
8db7:      DW    X'FFFF'    ; =0xffff =65535(-1)
8db9:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dbb:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dbd:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dbf:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dc1:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dc3:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dc5:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dc7:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dc9:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dcb:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dcd:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dcf:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dd1:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dd3:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dd5:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dd7:      DW    X'FFFF'    ; =0xffff =65535(-1)
8dd9:      DW    X'FFFF'    ; =0xffff =65535(-1)
8ddb:      DW    X'FFFF'    ; =0xffff =65535(-1)
8ddd:      DW    X'FFFF'    ; =0xffff =65535(-1)
8ddf:      DW    X'FFFF'    ; =0xffff =65535(-1)
8de1:      DW    X'FFFF'    ; =0xffff =65535(-1)
8de3:      DW    X'FFFF'    ; =0xffff =65535(-1)
8de5:      DW    X'FFFF'    ; =0xffff =65535(-1)
8de7:      DW    X'FFFF'    ; =0xffff =65535(-1)
8de9:      DW    X'FFFF'    ; =0xffff =65535(-1)
8deb:      DW    X'FFFF'    ; =0xffff =65535(-1)
8ded:      DW    X'FFFF'    ; =0xffff =65535(-1)
*
8def:J8DEF LDA=  S8DF5      ; =0x8df5 =36341(-29195) =CR,'u' [Load A with immediate]
8df2:      XAZ              ; [Transfer A to Z]
8df3:      JMP   D8E0F      ; =+26 [Jump relative]
*
8df5:S8DF5 DC    '0 FILE SYSIPT,SEQ'
8e06:      DB    X'00'      ; =0x00 =0 =NUL
*
8e07:W8E07 JSR/  F8198      ; =0x8198 =33176(-32360) [Jump to subroutine direct]
8e0a:W8E0A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e0c:      LDA   W8E0A      ; =-4 [Load A relative]
8e0e:      XAZ              ; [Transfer A to Z]
8e0f:D8E0F CLRB  AL,1       ; [Set AL to 1]
8e11:      STAB  B8E23+1    ; =+17 [Store AL relative]
8e13:J8E13 XFR=  W80C8,S    ; =0x80c8 =32968(-32568) [Transfer immediate to S]
8e17:      XFR=  W810E,Y    ; =0x810e =33038(-32498) [Transfer immediate to Y]
8e1b:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8e1e:      JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
8e21:      BNZ   D8E29      ; =+6 [Branch if not zero]
8e23:B8E23 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8e25:      BNZ   D8E32      ; =+11 [Branch if not zero]
8e27:      JMP   D8E41      ; =+24 [Jump relative]
8e29:D8E29 LDA+  Y          ; [Load A from address in Y]
8e2a:W8E2A LDB=  X'FFFF'    ; =0xffff =65535(-1) [Load B with immediate]
8e2d:      STA   W8E2A+1    ; =-4 [Store A relative]
8e2f:      SAB              ; [A - B -> B]
8e30:      BGZ   D8E38      ; =+6 [Branch if greater than zero]
8e32:D8E32 JSR/  F8BC8      ; =0x8bc8 =35784(-29752) =VT,'H' [Jump to subroutine direct]
8e35:      DB    X'01'      ; =0x01 =1
8e36:      JMP   D8E41      ; =+9 [Jump relative]
8e38:D8E38 JSR/  F8819      ; =0x8819 =34841(-30695) [Jump to subroutine direct]
8e3b:      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8e3d:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8e40:      STA+  B          ; [Store A to address in B]
8e41:D8E41 LDAB+ Z          ; [Load AL from address in Z]
8e42:      BZ    W8E07      ; =-61 [Branch if zero]
8e44:      LDBB= X'A1'      ; =161(-95) ='!' [Load BL with immediate]
8e46:      SABB             ; [AL - BL -> BL]
8e47:      BZ    W8E07      ; =-66 [Branch if zero]
8e49:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8e4b:      SABB             ; [AL - BL -> BL]
8e4c:      BNZ   D8E56      ; =+8 [Branch if not zero]
8e4e:      CLAB             ; [Clear AL]
8e4f:      STAB  B8E23+1    ; =-45 [Store AL relative]
8e51:      JSR/  F8C21      ; =0x8c21 =35873(-29663) [Jump to subroutine direct]
8e54:      JMP   J8E13      ; =-67 [Jump relative]
8e56:D8E56 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8e58:      BZ    D8E5D      ; =+3 [Branch if zero]
8e5a:      JMP/  J9B26      ; =0x9b26 =39718(-25818) [Jump direct]
8e5d:D8E5D JSR/  F8A5E      ; =0x8a5e =35422(-30114) [Jump to subroutine direct]
8e60:      DW    S97F2      ; =0x97f2 =38898(-26638)
8e62:      SLRB  AL,2       ; [Left shift AL by 2]
8e64:      STK   A,2        ; [Push A to the stack]
8e66:      BL    D8E70      ; =+8 [Branch on link]
8e68:      LDAB  B8E23+1    ; =-70 [Load AL relative]
8e6a:      BZ    D8E70      ; =+4 [Branch if zero]
8e6c:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8e6f:      DB    X'41'      ; =0x41 =65
*
8e70:D8E70 CLAB             ; [Clear AL]
8e71:      STAB  B8E23+1    ; =-79 [Store AL relative]
8e73:      POP   A,2        ; [Pop A from the stack]
8e75:      SRA              ; [Right shift A]
8e76:      LDB=  W8EAF      ; =0x8eaf =36527(-29009) [Load B with immediate]
8e79:      AAB              ; [A + B -> B]
8e7a:      LDA+  B          ; [Load A from address in B]
8e7b:      BNZ   D8E81      ; =+4 [Branch if not zero]
8e7d:P8E7D JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8e80:      DB    X'04'      ; =0x04 =4
*
8e81:D8E81 JMP+  A          ; [Jump indexed, direct]
8e83:J8E83 CLAB             ; [Clear AL]
8e84:B8E84 STAB= X'00'      ; =0 =NUL [Store AL immediate]
8e86:B8E86 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8e88:      BZ    D8E98      ; =+14 [Branch if zero]
8e8a:      STAB  B8E84+1    ; =-7 [Store AL relative]
8e8c:      CLAB             ; [Clear AL]
8e8d:      STAB  B8E86+1    ; =-8 [Store AL relative]
8e8f:      LDA/  W9152+1    ; =0x9153 =37203(-28333) [Load A direct]
8e92:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
8e95:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
8e98:D8E98 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8e9a:      BNZ   D8E9F      ; =+3 [Branch if not zero]
8e9c:D8E9C JMP/  W8E07      ; =0x8e07 =36359(-29177) [Jump direct]
8e9f:D8E9F LDBB= X'A1'      ; =161(-95) ='!' [Load BL with immediate]
8ea1:      SABB             ; [AL - BL -> BL]
8ea2:      BZ    D8E9C      ; =-8 [Branch if zero]
8ea4:      LDBB= X'BA'      ; =186(-70) =':' [Load BL with immediate]
8ea6:      SABB             ; [AL - BL -> BL]
8ea7:      BNZ   D8EAC      ; =+3 [Branch if not zero]
8ea9:      JMP/  J8E13      ; =0x8e13 =36371(-29165) [Jump direct]
8eac:D8EAC JSR*  P8E7D+1    ; =-48 [Jump to subroutine relative indirect]
8eae:      DB    X'0E'      ; =0x0e =14
8eaf:W8EAF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8eb1:      DW    W927E      ; =0x927e =37502(-28034)
8eb3:      DW    W9437      ; =0x9437 =37943(-27593)
8eb5:      DW    W8FE5      ; =0x8fe5 =36837(-28699)
8eb7:      DW    W9098      ; =0x9098 =37016(-28520)
8eb9:      DW    W8C2E      ; =0x8c2e =35886(-29650)
8ebb:      DW    W919D      ; =0x919d =37277(-28259)
8ebd:      DW    W9138      ; =0x9138 =37176(-28360)
8ebf:      DW    W9140      ; =0x9140 =37184(-28352)
8ec1:      DW    W9149      ; =0x9149 =37193(-28343)
8ec3:      DW    W9326      ; =0x9326 =37670(-27866)
8ec5:      DW    W92FF      ; =0x92ff =37631(-27905)
8ec7:      DW    W9255      ; =0x9255 =37461(-28075)
8ec9:      DW    W93C0      ; =0x93c0 =37824(-27712)
8ecb:      DW    W9318      ; =0x9318 =37656(-27880)
8ecd:      DW    W8E07      ; =0x8e07 =36359(-29177)
8ecf:      DW    W92C9      ; =0x92c9 =37577(-27959)
8ed1:      DW    W92DE      ; =0x92de =37598(-27938)
8ed3:      DW    W93C0      ; =0x93c0 =37824(-27712)
8ed5:      DW    W9457      ; =0x9457 =37975(-27561)
8ed7:      DW    W92C3      ; =0x92c3 =37571(-27965)
8ed9:      DW    W90E8      ; =0x90e8 =37096(-28440)
8edb:      DW    W8FAE      ; =0x8fae =36782(-28754)
8edd:      DW    W8F33      ; =0x8f33 =36659(-28877)
8edf:      DW    W8F29      ; =0x8f29 =36649(-28887)
8ee1:      DW    W9948      ; =0x9948 =39240(-26296)
8ee3:      DW    W9AC6      ; =0x9ac6 =39622(-25914)
8ee5:      DW    W96CA      ; =0x96ca =38602(-26934)
8ee7:      DW    W9690      ; =0x9690 =38544(-26992)
8ee9:      DW    W9695      ; =0x9695 =38549(-26987)
8eeb:      DW    W93BA      ; =0x93ba =37818(-27718)
8eed:      DW    W93B4      ; =0x93b4 =37812(-27724)
8eef:      DW    W9676      ; =0x9676 =38518(-27018)
8ef1:      DW    W967A      ; =0x967a =38522(-27014)
8ef3:      DW    W96BB      ; =0x96bb =38587(-26949)
8ef5:      DW    W96C0      ; =0x96c0 =38592(-26944)
8ef7:      DW    W9056      ; =0x9056 =36950(-28586)
8ef9:      DW    W9071      ; =0x9071 =36977(-28559)
8efb:      DW    W969A      ; =0x969a =38554(-26982)
8efd:      DW    W8F0D      ; =0x8f0d =36621(-28915)
8eff:      DW    W8F1F      ; =0x8f1f =36639(-28897)
8f01:      DW    W8F18      ; =0x8f18 =36632(-28904)
8f03:      DW    W916F      ; =0x916f =37231(-28305)
8f05:      DW    W96C5      ; =0x96c5 =38597(-26939)
8f07:      DW    W9469      ; =0x9469 =37993(-27543)
8f09:      DW    W96EF      ; =0x96ef =38639(-26897)
8f0b:      DW    W96FF      ; =0x96ff =38655(-26881)
*
8f0d:W8F0D JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
8f10:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8f12:      STA/  W8711      ; =0x8711 =34577(-30959) [Store A direct]
8f15:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8f18:W8F18 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8f1b:      DB    X'3B'      ; =0x3b =59
8f1c:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8f1f:W8F1F JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
8f22:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8f25:      DB    X'3A'      ; =0x3a =58
8f26:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8f29:W8F29 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
8f2c:P8F2C JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8f2f:      DB    X'2C'      ; =0x2c =44
8f30:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8f33:W8F33 JSR*  P8F2C+1    ; =-8 [Jump to subroutine relative indirect]
8f35:      DB    X'02'      ; =0x02 =2
8f36:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
8f39:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f3b:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
8f3e:D8F3E STX-  S-         ; [Store X indexed, pre-decremented, direct]
8f40:      LDX=  W8FA1+1    ; =0x8fa2 =36770(-28766) [Load X with immediate]
8f43:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f45:D8F45 INX              ; [Increment X]
8f46:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8f48:      BNZ   D8F50      ; =+6 [Branch if not zero]
8f4a:      DCR   Z          ; [Decrement Z by 1]
8f4c:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8f4f:      DB    X'14'      ; =0x14 =20
*
8f50:D8F50 SABB             ; [AL - BL -> BL]
8f51:      BNZ   D8F45      ; =-14 [Branch if not zero]
8f53:      JSR/  F89AA      ; =0x89aa =35242(-30294) [Jump to subroutine direct]
8f56:      LDAB+ X          ; [Load AL from address in X]
8f57:P8F57 JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
8f5a:      LDAB+ X          ; [Load AL from address in X]
8f5b:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8f5d:      DCAB             ; [Decrement AL]
8f5e:      BZ    D8F88      ; =+40 [Branch if zero]
8f60:      LDBB= X'04'      ; =4 [Load BL with immediate]
8f62:      SABB             ; [AL - BL -> BL]
8f63:      BNZ   D8F7A      ; =+21 [Branch if not zero]
8f65:D8F65 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
8f68:      DC    ','        ; hex:ac dec:172(-84)
8f69:      DB    X'01'      ; =0x01 =1
8f6a:      BNZ   D8F3E      ; =-46 [Branch if not zero]
8f6c:      CLAB             ; [Clear AL]
8f6d:      JSR*  P8F57+1    ; =-23 [Jump to subroutine relative indirect]
8f6f:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f71:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
8f74:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
8f77:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8f7a:D8F7A JSR   F8F7E      ; =+2 [Jump to subroutine relative]
8f7c:      JMP   D8F65      ; =-25 [Jump relative]
*
* Function F8F7E
*
8f7e:F8F7E JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
8f81:      BZ    D8F85      ; =+2 [Branch if zero]
8f83:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8f85:D8F85 JSR*  P8F57+1    ; =-47 [Jump to subroutine relative indirect]
8f87:      RSR              ; [Return from subroutine]
*
8f88:D8F88 JSR*  D8F65+1    ; =-36 [Jump to subroutine relative indirect]
8f8a:      DC    '-'        ; hex:ad dec:173(-83)
8f8b:      DB    X'01'      ; =0x01 =1
8f8c:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8f8e:      JSR   F8F7E      ; =-18 [Jump to subroutine relative]
8f90:      JSR*  D8F65+1    ; =-44 [Jump to subroutine relative indirect]
8f92:      DC    '.'        ; hex:ae dec:174(-82)
8f93:      DB    X'01'      ; =0x01 =1
8f94:      JSR   F8F7E      ; =-24 [Jump to subroutine relative]
8f96:      JSR*  D8F65+1    ; =-50 [Jump to subroutine relative indirect]
8f98:      DC    '-'        ; hex:ad dec:173(-83)
8f99:      DB    X'02'      ; =0x02 =2
8f9a:      BZ    D8F9D      ; =+1 [Branch if zero]
8f9c:      STAB+ S          ; [Store AL to address in S]
8f9d:D8F9D LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8f9f:      JSR*  P8F57+1    ; =-73 [Jump to subroutine relative indirect]
8fa1:W8FA1 JMP   D8F65      ; =-62 [Jump relative]
*
8fa3:      DC    'N'        ; hex:ce dec:206(-50)
8fa4:      DB    X'01'      ; =0x01 =1
8fa5:      DC    'C'        ; hex:c3 dec:195(-61)
8fa6:      DB    X'02'      ; =0x02 =2
8fa7:      DC    'X'        ; hex:d8 dec:216(-40)
8fa8:      DB    X'03'      ; =0x03 =3
8fa9:      DC    'T'        ; hex:d4 dec:212(-44)
8faa:      DB    X'04'      ; =0x04 =4
8fab:      DC    '/'        ; hex:af dec:175(-81)
8fac:      DW    X'0500'    ; =0x0500 =1280
*
8fae:W8FAE LDA   W8FE8+1    ; =+57 [Load A relative]
8fb0:      BZ    D8FED      ; =+59 [Branch if zero]
8fb2:      LDA*  W8FF4      ; =+64 [Load A relative indirect]
8fb4:P8FB4 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
8fb7:P8FB7 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
8fba:      DB    X'16'      ; =0x16 =22
*
8fbb:J8FBB JSR*  P8FB7+1    ; =-5 [Jump to subroutine relative indirect]
8fbd:      DB    X'1C'      ; =0x1c =28
8fbe:      LDA   W8FE8+1    ; =+41 [Load A relative]
8fc0:      INR   A,2        ; [Increment A by 2]
8fc2:      XAB              ; [Transfer A to B]
8fc3:      LDA   W8FF4      ; =+47 [Load A relative]
8fc5:      STB+  A,2        ; [Store B indexed, displaced, direct]
8fc8:      LDA   W8FE8+1    ; =+31 [Load A relative]
8fca:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
8fcd:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
8fd0:      LDA*  W8FF4      ; =+34 [Load A relative indirect]
8fd2:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
8fd5:      AAB              ; [A + B -> B]
8fd6:      LDA=  X'7000'    ; =0x7000 =28672 [Load A with immediate]
8fd9:      NAB              ; [A & B -> B]
8fda:      STB*  W8FF4      ; =+24 [Store B relative indirect]
8fdc:      JSR/  F873F      ; =0x873f =34623(-30913) [Jump to subroutine direct]
8fdf:      CLA              ; [Clear A]
8fe0:      STA   W8FE8+1    ; =+7 [Store A relative]
8fe2:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
8fe5:W8FE5 JSR*  P8FB7+1    ; =-47 [Jump to subroutine relative indirect]
8fe7:      DB    X'02'      ; =0x02 =2
8fe8:W8FE8 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8feb:      BZ    D8FF6      ; =+9 [Branch if zero]
8fed:D8FED CLA              ; [Clear A]
8fee:      STA   W8FE8+1    ; =-7 [Store A relative]
8ff0:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
8ff3:      DB    X'16'      ; =0x16 =22
8ff4:W8FF4 DS    2          ; =0x0002 [Uninitialized memory]
*
8ff6:D8FF6 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8ff8:      XAX              ; [Transfer A to X]
8ff9:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
8ffc:      STB   W8FE8+1    ; =-21 [Store B relative]
8ffe:      JSR*  P8FB4+1    ; =-75 [Jump to subroutine relative indirect]
9000:      JSR   F9025      ; =+35 [Jump to subroutine relative]
9002:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9004:      STA   W8FF4      ; =-18 [Store A relative]
9006:      LDB+  A,4        ; [Load B indexed, displaced, direct]
9009:      LDBB= X'04'      ; =4 [Load BL with immediate]
900b:      ORIB  BU,BL      ; [BU | BL -> BL]
900d:      STBB+ A,4        ; [Store BL indexed, displaced, direct]
9010:P9010 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9013:      DC    '('        ; hex:a8 dec:168(-88)
9014:      DB    X'01'      ; =0x01 =1
9015:      BZ    D902A      ; =+19 [Branch if zero]
9017:D9017 JSR   F9025      ; =+12 [Jump to subroutine relative]
9019:      INX              ; [Increment X]
901a:      JSR*  P9010+1    ; =-11 [Jump to subroutine relative indirect]
901c:      DC    ','        ; hex:ac dec:172(-84)
901d:      DB    X'01'      ; =0x01 =1
901e:      BNZ   D9017      ; =-9 [Branch if not zero]
9020:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
9023:      JMP   D902A      ; =+5 [Jump relative]
*
* Function F9025
*
9025:F9025 JSR   F908B      ; =+100 [Jump to subroutine relative]
9027:      BNZ   D8FED      ; =-60 [Branch if not zero]
9029:      RSR              ; [Return from subroutine]
*
902a:D902A XFR   X,A        ; [Transfer X to A]
902c:P902C JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
902f:D902F DCX              ; [Decrement X]
9030:      BM    D9045      ; =+19 [Branch on minus]
9032:      LDA+  *Y         ; [Load A indexed, indirect]
9034:      JSR*  P902C+1    ; =-9 [Jump to subroutine relative indirect]
9036:      LDB+  Y          ; [Load B from address in Y]
9037:      LDBB+ B,4        ; [Load BL indexed, displaced, direct]
903a:      LDAB= X'02'      ; =2 [Load AL with immediate]
903c:      ORIB  AL,BL      ; [AL | BL -> BL]
903e:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9040:      STBB+ A,4        ; [Store BL indexed, displaced, direct]
9043:      JMP   D902F      ; =-22 [Jump relative]
9045:D9045 LDX+  S+         ; [Load X indexed, direct, post-incremented]
9047:      JSR*  P9010+1    ; =-56 [Jump to subroutine relative indirect]
9049:      DC    '='        ; hex:bd dec:189(-67)
904a:      DB    X'01'      ; =0x01 =1
904b:      BNZ   D9050      ; =+3 [Branch if not zero]
904d:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9050:D9050 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9053:      JMP/  J8FBB      ; =0x8fbb =36795(-28741) [Jump direct]
9056:W9056 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9058:D9058 JSR   F908B      ; =+49 [Jump to subroutine relative]
905a:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
905c:      LDAB+ X,4        ; [Load AL indexed, displaced, direct]
905f:      LDBB= X'04'      ; =4 [Load BL with immediate]
9061:      ORIB  AL,BL      ; [AL | BL -> BL]
9063:      STBB+ X,4        ; [Store BL indexed, displaced, direct]
9066:      JSR*  P9010+1    ; =-87 [Jump to subroutine relative indirect]
9068:      DC    ','        ; hex:ac dec:172(-84)
9069:      DB    X'01'      ; =0x01 =1
906a:      BNZ   D9058      ; =-20 [Branch if not zero]
906c:D906C LDX+  S+         ; [Load X indexed, direct, post-incremented]
906e:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9071:W9071 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9073:D9073 JSR   F908B      ; =+22 [Jump to subroutine relative]
9075:      BNZ   D909C      ; =+37 [Branch if not zero]
9077:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
9079:      LDAB+ X,4        ; [Load AL indexed, displaced, direct]
907c:      LDBB= X'06'      ; =6 [Load BL with immediate]
907e:      ORIB  AL,BL      ; [AL | BL -> BL]
9080:      STBB+ X,4        ; [Store BL indexed, displaced, direct]
9083:      JSR*  P9010+1    ; =-116 [Jump to subroutine relative indirect]
9085:      DC    ','        ; hex:ac dec:172(-84)
9086:      DB    X'01'      ; =0x01 =1
9087:      BNZ   D9073      ; =-22 [Branch if not zero]
9089:      JMP   D906C      ; =-31 [Jump relative]
*
* Function F908B
*
908b:F908B JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
908e:      BNZ   D9094      ; =+4 [Branch if not zero]
9090:P9090 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9093:      DB    X'14'      ; =0x14 =20
*
9094:D9094 JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
9097:      RSR              ; [Return from subroutine]
*
9098:W9098 JSR   F908B      ; =-15 [Jump to subroutine relative]
909a:      BZ    P909F      ; =+3 [Branch if zero]
909c:D909C JSR*  P9090+1    ; =-13 [Jump to subroutine relative indirect]
909e:      DB    X'08'      ; =0x08 =8
909f:P909F JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
90a2:      DC    '('        ; hex:a8 dec:168(-88)
90a3:      DB    X'01'      ; =0x01 =1
90a4:      BZ    P9090      ; =-22 [Branch if zero]
90a6:      JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
90a9:      BZ    P9090      ; =-27 [Branch if zero]
90ab:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
90ad:      BLE   P9090      ; =-31 [Branch if less than or equal to zero]
90af:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
90b1:      LDB+  Y          ; [Load B from address in Y]
90b2:      CLA              ; [Clear A]
90b3:      STA+  B,2        ; [Store A indexed, displaced, direct]
90b6:      JSR*  P909F+1    ; =-24 [Jump to subroutine relative indirect]
90b8:      DC    ','        ; hex:ac dec:172(-84)
90b9:      DB    X'01'      ; =0x01 =1
90ba:      BZ    D90D0      ; =+20 [Branch if zero]
90bc:      JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
90bf:      BZ    P9090      ; =-49 [Branch if zero]
90c1:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
90c3:      BLE   P9090      ; =-53 [Branch if less than or equal to zero]
90c5:      LDB+  Y          ; [Load B from address in Y]
90c6:      STA+  B,2        ; [Store A indexed, displaced, direct]
90c9:      LDB+  S          ; [Load B from address in S]
90ca:      MUL   B,A        ; [B * A -> A,B]
90cc:      STB+  S          ; [Store B to address in S]
90cd:      XAB              ; [Transfer A to B]
90ce:      BNZ   P9090      ; =-64 [Branch if not zero]
90d0:D90D0 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
90d2:      LDA+  B          ; [Load A from address in B]
90d3:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
90d5:      DCR   B          ; [Decrement B by 1]
90d7:      JSR/  F89DE      ; =0x89de =35294(-30242) [Jump to subroutine direct]
90da:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
90dd:      JSR*  P909F+1    ; =-63 [Jump to subroutine relative indirect]
90df:      DC    ','        ; hex:ac dec:172(-84)
90e0:      DB    X'01'      ; =0x01 =1
90e1:      BZ    D90E5      ; =+2 [Branch if zero]
90e3:      JMP   W9098      ; =-77 [Jump relative]
90e5:D90E5 JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
90e8:W90E8 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
90eb:      JSR*  P909F+1    ; =-77 [Jump to subroutine relative indirect]
90ed:      DC    'GOSUB'    ; hex:c7cfd3d5c2
90f2:      DB    X'01'      ; =0x01 =1
90f3:      BZ    D90FB      ; =+6 [Branch if zero]
90f5:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
90f8:      DB    X'3C'      ; =0x3c =60
90f9:      JMP   D9108      ; =+13 [Jump relative]
90fb:D90FB JSR*  P909F+1    ; =-93 [Jump to subroutine relative indirect]
90fd:      DC    'GOTO'     ; hex:c7cfd4cf
9101:      DB    X'01'      ; =0x01 =1
9102:      BZ    P9090      ; =-116 [Branch if zero]
9104:P9104 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9107:      DB    X'07'      ; =0x07 =7
*
9108:D9108 STX-  S-         ; [Store X indexed, pre-decremented, direct]
910a:      CLA              ; [Clear A]
910b:      XAX              ; [Transfer A to X]
910c:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
910f:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9111:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9114:D9114 JSR   F9129      ; =+19 [Jump to subroutine relative]
9116:      INX              ; [Increment X]
9117:      JSR*  P909F+1    ; =-121 [Jump to subroutine relative indirect]
9119:      DC    ','        ; hex:ac dec:172(-84)
911a:      DB    X'01'      ; =0x01 =1
911b:      BNZ   D9114      ; =-9 [Branch if not zero]
911d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
911f:      XFR   X,B        ; [Transfer X to B]
9121:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
9124:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9126:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
*
* Function F9129
*
9129:F9129 JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
912c:      BNZ   D9132      ; =+4 [Branch if not zero]
912e:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9131:      DB    X'0B'      ; =0x0b =11
*
9132:D9132 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9134:P9134 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9137:      RSR              ; [Return from subroutine]
*
9138:W9138 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
913b:      JSR*  P9104+1    ; =-56 [Jump to subroutine relative indirect]
913d:      DB    X'1B'      ; =0x1b =27
913e:      JMP   D9146      ; =+6 [Jump relative]
9140:W9140 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9143:      JSR*  P9104+1    ; =-64 [Jump to subroutine relative indirect]
9145:      DB    X'1A'      ; =0x1a =26
*
9146:D9146 JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9149:W9149 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
914c:      JSR*  P9104+1    ; =-73 [Jump to subroutine relative indirect]
914e:      DB    X'19'      ; =0x19 =25
914f:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
9152:W9152 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
9155:      JSR*  P9134+1    ; =-34 [Jump to subroutine relative indirect]
9157:      LDAB= X'01'      ; =1 [Load AL with immediate]
9159:      STAB/ B8E86+1    ; =0x8e87 =36487(-29049) [Store AL direct]
915c:D915C LDAB+ Z          ; [Load AL from address in Z]
915d:      JSR/  F8966      ; =0x8966 =35174(-30362) [Jump to subroutine direct]
9160:      BP    W9140      ; =-34 [Branch on plus]
9162:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9165:      DC    'THEN'     ; hex:d4c8c5ce
9169:      DB    X'01'      ; =0x01 =1
916a:      BNZ   D915C      ; =-16 [Branch if not zero]
916c:      JMP/  J8E13      ; =0x8e13 =36371(-29165) [Jump direct]
916f:W916F LDAB/ B8E84+1    ; =0x8e85 =36485(-29051) [Load AL direct]
9172:      BGZ   D9178      ; =+4 [Branch if greater than zero]
9174:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9177:      DB    X'1E'      ; =0x1e =30
*
9178:D9178 LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
917b:      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
917e:      AAB              ; [A + B -> B]
917f:      LDA   W9152+1    ; =-46 [Load A relative]
9181:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
9184:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9187:      DB    X'02'      ; =0x02 =2
9188:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
918b:      STA   W9152+1    ; =-58 [Store A relative]
918d:      JSR*  P9134+1    ; =-90 [Jump to subroutine relative indirect]
918f:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
9191:      STAB/ B8E86+1    ; =0x8e87 =36487(-29049) [Store AL direct]
9194:      LDAB+ Z          ; [Load AL from address in Z]
9195:      JSR/  F8966      ; =0x8966 =35174(-30362) [Jump to subroutine direct]
9198:      BP    W9140      ; =-90 [Branch on plus]
919a:      JMP/  J8E13      ; =0x8e13 =36371(-29165) [Jump direct]
919d:W919D JSR/  F908B      ; =0x908b =37003(-28533) [Jump to subroutine direct]
91a0:      LDA+  *Y         ; [Load A indexed, indirect]
91a2:      STA+  Y          ; [Store A to address in Y]
91a3:      JSR*  P9134+1    ; =-112 [Jump to subroutine relative indirect]
91a5:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
91a8:      DC    '='        ; hex:bd dec:189(-67)
91a9:      DB    X'01'      ; =0x01 =1
91aa:      BNZ   D91B0      ; =+4 [Branch if not zero]
91ac:D91AC JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
91af:      DB    X'14'      ; =0x14 =20
*
91b0:D91B0 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
91b3:P91B3 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
91b6:      DB    X'17'      ; =0x17 =23
91b7:      LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
91ba:      LDB=  X'0002'    ; =0x0002 =2 [Load B with immediate]
91bd:      JSR/  F89DE      ; =0x89de =35294(-30242) [Jump to subroutine direct]
91c0:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
91c2:P91C2 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
91c5:P91C5 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
91c8:      DC    'TO'       ; hex:d4cf dec:54479(-49)
91ca:      DB    X'01'      ; =0x01 =1
91cb:      BZ    D91AC      ; =-33 [Branch if zero]
91cd:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
91d0:      JSR*  P91B3+1    ; =-30 [Jump to subroutine relative indirect]
91d2:      DB    X'17'      ; =0x17 =23
91d3:      LDA+  S          ; [Load A from address in S]
91d4:      INA              ; [Increment A]
91d5:      JSR*  P91C2+1    ; =-20 [Jump to subroutine relative indirect]
91d7:      JSR*  P91C5+1    ; =-19 [Jump to subroutine relative indirect]
91d9:      DC    'STEP'     ; hex:d3d4c5d0
91dd:      DB    X'01'      ; =0x01 =1
91de:      BNZ   D91EA      ; =+10 [Branch if not zero]
91e0:      JSR*  P91B3+1    ; =-46 [Jump to subroutine relative indirect]
91e2:      DB    X'04'      ; =0x04 =4
91e3:      CLA              ; [Clear A]
91e4:      INA              ; [Increment A]
91e5:P91E5 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
91e8:      JMP   D91ED      ; =+3 [Jump relative]
91ea:D91EA JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
91ed:D91ED JSR*  P91B3+1    ; =-59 [Jump to subroutine relative indirect]
91ef:      DB    X'17'      ; =0x17 =23
91f0:      LDA+  Y          ; [Load A from address in Y]
91f1:      JSR*  P91E5+1    ; =-13 [Jump to subroutine relative indirect]
91f3:      LDA+  Y          ; [Load A from address in Y]
91f4:      JSR   P9239      ; =+67 [Jump to subroutine relative]
91f6:      JSR*  P91B3+1    ; =-68 [Jump to subroutine relative indirect]
91f8:      DB    X'02'      ; =0x02 =2
91f9:      LDA=  X'000B'    ; =0x000b =11 [Load A with immediate]
91fc:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
91ff:      ADD   B,A        ; [B + A -> A]
9201:      JSR*  P91E5+1    ; =-29 [Jump to subroutine relative indirect]
9203:      JSR/  W8A27      ; =0x8a27 =35367(-30169) [Jump to subroutine direct]
9206:      LDA+  Y          ; [Load A from address in Y]
9207:      JSR*  P91E5+1    ; =-35 [Jump to subroutine relative indirect]
9209:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
920b:      JSR   P9239      ; =+44 [Jump to subroutine relative]
920d:      LDA+  S          ; [Load A from address in S]
920e:      INA              ; [Increment A]
920f:      JSR   P9239      ; =+40 [Jump to subroutine relative]
9211:      JSR*  P91B3+1    ; =-95 [Jump to subroutine relative indirect]
9213:      DB    X'0D'      ; =0x0d =13
9214:      LDA+  S          ; [Load A from address in S]
9215:      JSR   P9239      ; =+34 [Jump to subroutine relative]
9217:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9219:      INA              ; [Increment A]
921a:      JSR   P9239      ; =+29 [Jump to subroutine relative]
921c:      JSR*  P91B3+1    ; =-106 [Jump to subroutine relative indirect]
921e:      DB    X'15'      ; =0x15 =21
921f:      JSR/  W8A27      ; =0x8a27 =35367(-30169) [Jump to subroutine direct]
9222:      JSR*  P91C5+1    ; =-94 [Jump to subroutine relative indirect]
9224:      DC    'WHILE'    ; hex:d7c8c9ccc5
9229:      DB    X'01'      ; =0x01 =1
922a:      BNZ   D9240      ; =+20 [Branch if not zero]
922c:      JSR/  W8A27      ; =0x8a27 =35367(-30169) [Jump to subroutine direct]
922f:      CLA              ; [Clear A]
9230:      JSR*  P91E5+1    ; =-76 [Jump to subroutine relative indirect]
9232:P9232 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9235:      DB    X'17'      ; =0x17 =23
9236:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9239:P9239 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
923c:      JSR*  P9232+1    ; =-11 [Jump to subroutine relative indirect]
923e:      DB    X'16'      ; =0x16 =22
923f:      RSR              ; [Return from subroutine]
*
9240:D9240 CLA              ; [Clear A]
9241:      JSR*  P9239+1    ; =-9 [Jump to subroutine relative indirect]
9243:      JSR*  P9232+1    ; =-18 [Jump to subroutine relative indirect]
9245:      DB    X'0D'      ; =0x0d =13
9246:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9249:      JSR*  P9232+1    ; =-24 [Jump to subroutine relative indirect]
924b:      DB    X'19'      ; =0x19 =25
924c:      JSR/  W8A27      ; =0x8a27 =35367(-30169) [Jump to subroutine direct]
924f:      CLA              ; [Clear A]
9250:      JSR*  P9239+1    ; =-24 [Jump to subroutine relative indirect]
9252:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9255:W9255 JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
9258:P9258 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
925b:      DB    X'18'      ; =0x18 =24
*
925c:      JSR/  F8A3C      ; =0x8a3c =35388(-30148) [Jump to subroutine direct]
925f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9261:      JSR/  F8A3C      ; =0x8a3c =35388(-30148) [Jump to subroutine direct]
9264:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9266:      JSR/  F8A3C      ; =0x8a3c =35388(-30148) [Jump to subroutine direct]
9269:      JSR*  P9239+1    ; =-49 [Jump to subroutine relative indirect]
926b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
926d:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
9270:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
9273:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9275:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
9278:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
927b:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
927e:W927E JSR*  P9258+1    ; =-39 [Jump to subroutine relative indirect]
9280:      DB    X'02'      ; =0x02 =2
9281:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9283:      XFR   Z,X        ; [Transfer Z to X]
9285:      CLA              ; [Clear A]
9286:D9286 INA              ; [Increment A]
9287:      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
9289:      BNZ   D9286      ; =-5 [Branch if not zero]
928b:      XAX              ; [Transfer A to X]
928c:      INR   A,2        ; [Increment A by 2]
928e:      INR   A,2        ; [Increment A by 2]
9290:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
9293:      ADD   B,A        ; [B + A -> A]
9295:      JSR*  P9239+1    ; =-93 [Jump to subroutine relative indirect]
9297:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
929a:      LDA/  S870A      ; =0x870a =34570(-30966) [Load A direct]
929d:      BNZ   D92A4      ; =+5 [Branch if not zero]
929f:      STB/  S870A      ; =0x870a =34570(-30966) [Store B direct]
92a2:      JMP   D92AA      ; =+6 [Jump relative]
92a4:D92A4 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
92a7:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
92aa:D92AA LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
92ac:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
92af:      DCX              ; [Decrement X]
92b0:      BGZ   D92AA      ; =-8 [Branch if greater than zero]
92b2:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
92b5:      STA/  D92A4+1    ; =0x92a5 =37541(-27995) [Store A direct]
92b8:      CLA              ; [Clear A]
92b9:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
92bc:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
92be:      DCR   Z          ; [Decrement Z by 1]
92c0:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
92c3:W92C3 JSR*  P9258+1    ; =-108 [Jump to subroutine relative indirect]
92c5:      DB    X'06'      ; =0x06 =6
92c6:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
92c9:W92C9 LDA/  W8FE8+1    ; =0x8fe9 =36841(-28695) [Load A direct]
92cc:      BZ    D92D8      ; =+10 [Branch if zero]
92ce:      LDA$  W8FF4      ; =0x8ff4 =36852(-28684) [Load A indirect]
92d1:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
92d4:P92D4 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
92d7:      DB    X'16'      ; =0x16 =22
*
92d8:D92D8 JSR*  P92D4+1    ; =-5 [Jump to subroutine relative indirect]
92da:      DB    X'1C'      ; =0x1c =28
92db:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
92de:W92DE LDAB+ Z          ; [Load AL from address in Z]
92df:      BZ    D92EB      ; =+10 [Branch if zero]
92e1:      LDB=  X'BAA1'    ; =0xbaa1 =47777(-17759) =':','!' [Load B with immediate]
92e4:      SABB             ; [AL - BL -> BL]
92e5:      BZ    D92EB      ; =+4 [Branch if zero]
92e7:      SUBB  AL,BU      ; [AL - BU -> BU]
92e9:      BNZ   D92F6      ; =+11 [Branch if not zero]
92eb:D92EB JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
92ee:      DB    X'04'      ; =0x04 =4
92ef:      CLA              ; [Clear A]
92f0:      IVA              ; [Invert A]
92f1:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
92f4:      JMP   D92F9      ; =+3 [Jump relative]
92f6:D92F6 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
92f9:D92F9 JSR*  D92EB+1    ; =-15 [Jump to subroutine relative indirect]
92fb:      DB    X'1D'      ; =0x1d =29
92fc:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
92ff:W92FF JSR/  F9580      ; =0x9580 =38272(-27264) [Jump to subroutine direct]
9302:      BNZ   P9308      ; =+4 [Branch if not zero]
9304:P9304 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9307:      DB    X'02'      ; =0x02 =2
9308:P9308 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
930b:      DC    '='        ; hex:bd dec:189(-67)
930c:      DB    X'01'      ; =0x01 =1
930d:      BZ    P9304      ; =-11 [Branch if zero]
930f:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9312:      JSR*  D92EB+1    ; =-40 [Jump to subroutine relative indirect]
9314:      DB    X'17'      ; =0x17 =23
9315:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9318:W9318 JSR   F9345      ; =+43 [Jump to subroutine relative]
931a:      BZ    D932A      ; =+14 [Branch if zero]
931c:      LDAB+ Z          ; [Load AL from address in Z]
931d:      LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
931f:      SABB             ; [AL - BL -> BL]
9320:      BZ    P932D      ; =+11 [Branch if zero]
9322:      LDAB= X'29'      ; =41 [Load AL with immediate]
9324:      JMP   D9333      ; =+13 [Jump relative]
9326:W9326 JSR   F9345      ; =+29 [Jump to subroutine relative]
9328:      BNZ   P932D      ; =+3 [Branch if not zero]
932a:D932A JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
932d:P932D JSR/  F964C      ; =0x964c =38476(-27060) [Jump to subroutine direct]
9330:      DB    X'1E'      ; =0x1e =30
9331:      LDAB= X'1F'      ; =31 [Load AL with immediate]
9333:D9333 STAB  B933C      ; =+7 [Store AL relative]
9335:D9335 JSR/  F9580      ; =0x9580 =38272(-27264) [Jump to subroutine direct]
9338:      BZ    D936D      ; =+51 [Branch if zero]
933a:      JSR*  D92EB+1    ; =-80 [Jump to subroutine relative indirect]
933c:B933C DB    X'00'      ; =0x00 =0 =NUL
933d:      JSR*  P9308+1    ; =-54 [Jump to subroutine relative indirect]
933f:      DC    ','        ; hex:ac dec:172(-84)
9340:      DB    X'01'      ; =0x01 =1
9341:      BNZ   D9335      ; =-14 [Branch if not zero]
9343:      JMP   D932A      ; =-27 [Jump relative]
*
* Function F9345
*
9345:F9345 LDAB+ Z          ; [Load AL from address in Z]
9346:      LDB=  X'A2A7'    ; =0xa2a7 =41639(-23897) ='"',' [Load B with immediate]
9349:      SABB             ; [AL - BL -> BL]
934a:      BZ    D9350      ; =+4 [Branch if zero]
934c:      SUBB  AL,BU      ; [AL - BU -> BU]
934e:      BNZ   D935C      ; =+12 [Branch if not zero]
9350:D9350 JSR*  P932D+1    ; =-36 [Jump to subroutine relative indirect]
9352:      DB    X'21'      ; =0x21 =33
9353:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9356:      JSR*  D92EB+1    ; =-108 [Jump to subroutine relative indirect]
9358:      DB    X'24'      ; =0x24 =36
*
9359:      JSR*  D92EB+1    ; =-111 [Jump to subroutine relative indirect]
935b:      DB    X'26'      ; =0x26 =38
*
935c:D935C JSR*  P9308+1    ; =-85 [Jump to subroutine relative indirect]
935e:      DC    'LINE'     ; hex:ccc9cec5
9362:      DB    X'01'      ; =0x01 =1
9363:      BZ    D9376      ; =+17 [Branch if zero]
9365:      JSR*  P932D+1    ; =-57 [Jump to subroutine relative indirect]
9367:      DB    X'1E'      ; =0x1e =30
9368:      JSR/  F9580      ; =0x9580 =38272(-27264) [Jump to subroutine direct]
936b:      BNZ   D9370      ; =+3 [Branch if not zero]
936d:D936D JSR*  P9304+1    ; =-106 [Jump to subroutine relative indirect]
936f:      DB    X'14'      ; =0x14 =20
*
9370:D9370 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9373:      DB    X'20'      ; =0x20 =32
9374:      CLAB             ; [Clear AL]
9375:      RSR              ; [Return from subroutine]
*
9376:D9376 JSR*  P9308+1    ; =-111 [Jump to subroutine relative indirect]
9378:      DC    'RECORD'   ; hex:d2c5c3cfd2c4
937e:      DB    X'01'      ; =0x01 =1
937f:      BNZ   D9384      ; =+3 [Branch if not zero]
9381:      LDAB= X'01'      ; =1 [Load AL with immediate]
9383:      RSR              ; [Return from subroutine]
*
9384:D9384 LDAB= X'2D'      ; =45 [Load AL with immediate]
9386:      JSR   F938A      ; =+2 [Jump to subroutine relative]
9388:      CLAB             ; [Clear AL]
9389:      RSR              ; [Return from subroutine]
*
* Function F938A
*
938a:F938A STAB  B938E      ; =+2 [Store AL relative]
938c:      JSR*  P932D+1    ; =-96 [Jump to subroutine relative indirect]
938e:B938E DB    X'00'      ; =0x00 =0 =NUL
938f:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9392:      DC    ','        ; hex:ac dec:172(-84)
9393:      DB    X'01'      ; =0x01 =1
*
*
* Function F9394
*
9394:F9394 JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
9397:      BZ    D936D      ; =-44 [Branch if zero]
9399:P9399 LDA/  W87C2+1    ; =0x87c3 =34755(-30781) =BEL,'C' [Load A direct]
939c:      LDB=  X'8000'    ; =0x8000 =32768(-32768) [Load B with immediate]
939f:      ORI   A,B        ; [A | B -> B]
93a1:      STB*  P9399+1    ; =-9 [Store B relative indirect]
93a3:      JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
93a6:      BNZ   D93AC      ; =+4 [Branch if not zero]
93a8:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
93ab:      DB    X'1A'      ; =0x1a =26
*
93ac:D93AC LDB+  Y          ; [Load B from address in Y]
93ad:      LDA+  B,2        ; [Load A indexed, displaced, direct]
93b0:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
93b3:      RSR              ; [Return from subroutine]
*
93b4:W93B4 LDAB= X'33'      ; =51 [Load AL with immediate]
93b6:      LDBB= X'34'      ; =52 [Load BL with immediate]
93b8:      JMP   D93C4      ; =+10 [Jump relative]
93ba:W93BA LDAB= X'26'      ; =38 [Load AL with immediate]
93bc:      LDBB= X'2E'      ; =46 [Load BL with immediate]
93be:      JMP   D93C4      ; =+4 [Jump relative]
93c0:W93C0 LDAB= X'25'      ; =37 [Load AL with immediate]
93c2:      LDBB= X'2E'      ; =46 [Load BL with immediate]
93c4:D93C4 STAB  B941D      ; =+87 [Store AL relative]
93c6:      STBB  B93DE+1    ; =+23 [Store BL relative]
93c8:P93C8 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
93cb:      DC    'USING'    ; hex:d5d3c9cec7
93d0:      DB    X'01'      ; =0x01 =1
93d1:      BNZ   D9421      ; =+78 [Branch if not zero]
93d3:      JSR*  P93C8+1    ; =-12 [Jump to subroutine relative indirect]
93d5:      DC    'RECORD'   ; hex:d2c5c3cfd2c4
93db:      DB    X'01'      ; =0x01 =1
93dc:      BZ    D93E4      ; =+6 [Branch if zero]
93de:B93DE LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
93e0:      JSR   F938A      ; =-88 [Jump to subroutine relative]
93e2:      JMP   D941E      ; =+58 [Jump relative]
93e4:D93E4 CLAB             ; [Clear AL]
93e5:      STAB  B940A      ; =+35 [Store AL relative]
93e7:P93E7 JSR/  F964C      ; =0x964c =38476(-27060) [Jump to subroutine direct]
93ea:      DB    X'21'      ; =0x21 =33
*
93eb:D93EB LDAB+ Z          ; [Load AL from address in Z]
93ec:      BZ    D9416      ; =+40 [Branch if zero]
93ee:      LDB=  X'A1BA'    ; =0xa1ba =41402(-24134) ='!',':' [Load B with immediate]
93f1:      SABB             ; [AL - BL -> BL]
93f2:      BZ    D9416      ; =+34 [Branch if zero]
93f4:      SUBB  AL,BU      ; [AL - BU -> BU]
93f6:      BZ    D9416      ; =+30 [Branch if zero]
93f8:P93F8 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
93fb:      DC    ','        ; hex:ac dec:172(-84)
93fc:      DB    X'22'      ; =0x22 =34
93fd:      BNZ   D9405      ; =+6 [Branch if not zero]
93ff:      JSR*  P93F8+1    ; =-8 [Jump to subroutine relative indirect]
9401:      DC    ';'        ; hex:bb dec:187(-69)
9402:      DB    X'23'      ; =0x23 =35
9403:      BZ    D940D      ; =+8 [Branch if zero]
9405:D9405 STAB  B940A      ; =+3 [Store AL relative]
9407:P9407 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
940a:B940A DB    X'00'      ; =0x00 =0 =NUL
940b:      JMP   D93EB      ; =-34 [Jump relative]
940d:D940D STAB  B940A      ; =-5 [Store AL relative]
940f:      JSR   F9479      ; =+104 [Jump to subroutine relative]
9411:      JSR*  P9407+1    ; =-11 [Jump to subroutine relative indirect]
9413:      DB    X'24'      ; =0x24 =36
9414:      JMP   D93EB      ; =-43 [Jump relative]
9416:D9416 LDAB  B940A      ; =-14 [Load AL relative]
9418:      BNZ   D941E      ; =+4 [Branch if not zero]
941a:P941A JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
941d:B941D DB    X'25'      ; =0x25 =37
*
941e:D941E JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9421:D9421 JSR*  P941A+1    ; =-8 [Jump to subroutine relative indirect]
9423:      DB    X'2A'      ; =0x2a =42
*
9424:      JSR/  F9129      ; =0x9129 =37161(-28375) [Jump to subroutine direct]
9427:      JSR*  P93E7+1    ; =-65 [Jump to subroutine relative indirect]
9429:      DB    X'21'      ; =0x21 =33
*
942a:D942A JSR   F9479      ; =+77 [Jump to subroutine relative]
942c:      JSR*  P941A+1    ; =-19 [Jump to subroutine relative indirect]
942e:      DB    X'2B'      ; =0x2b =43
942f:      JSR*  P93F8+1    ; =-56 [Jump to subroutine relative indirect]
9431:      DC    ','        ; hex:ac dec:172(-84)
9432:      DB    X'01'      ; =0x01 =1
9433:      BNZ   D942A      ; =-11 [Branch if not zero]
9435:      JMP   P941A      ; =-29 [Jump relative]
9437:W9437 JSR*  P941A+1    ; =-30 [Jump to subroutine relative indirect]
9439:      DB    X'04'      ; =0x04 =4
*
943a:      JSR/  F8A5E      ; =0x8a5e =35422(-30114) [Jump to subroutine direct]
943d:      DW    S9873      ; =0x9873 =39027(-26509)
943f:      BNZ   D9442      ; =+1 [Branch if not zero]
9441:      INAB             ; [Increment AL]
9442:D9442 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9445:      JSR*  P93F8+1    ; =-78 [Jump to subroutine relative indirect]
9447:      DC    '#'        ; hex:a3 dec:163(-93)
9448:      DB    X'01'      ; =0x01 =1
9449:      JSR   F9479      ; =+46 [Jump to subroutine relative]
944b:      JSR*  P941A+1    ; =-50 [Jump to subroutine relative indirect]
944d:      DB    X'27'      ; =0x27 =39
944e:      JSR*  P93F8+1    ; =-87 [Jump to subroutine relative indirect]
9450:      DC    ','        ; hex:ac dec:172(-84)
9451:      DB    X'01'      ; =0x01 =1
9452:      BNZ   W9437      ; =-29 [Branch if not zero]
9454:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9457:W9457 JSR*  P93F8+1    ; =-96 [Jump to subroutine relative indirect]
9459:      DC    '#'        ; hex:a3 dec:163(-93)
945a:      DB    X'01'      ; =0x01 =1
945b:      JSR   F9479      ; =+28 [Jump to subroutine relative]
945d:      JSR*  P941A+1    ; =-68 [Jump to subroutine relative indirect]
945f:      DB    X'28'      ; =0x28 =40
9460:      JSR*  P93F8+1    ; =-105 [Jump to subroutine relative indirect]
9462:      DC    ','        ; hex:ac dec:172(-84)
9463:      DB    X'01'      ; =0x01 =1
9464:      BNZ   W9457      ; =-15 [Branch if not zero]
9466:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9469:W9469 JSR*  P941A+1    ; =-80 [Jump to subroutine relative indirect]
946b:      DB    X'40'      ; =0x40 =64
*
946c:      JSR/  F9394      ; =0x9394 =37780(-27756) [Jump to subroutine direct]
946f:      JSR*  P93F8+1    ; =-120 [Jump to subroutine relative indirect]
9471:      DC    'TO'       ; hex:d4cf dec:54479(-49)
9473:      DB    X'01'      ; =0x01 =1
9474:      JSR/  F9394      ; =0x9394 =37780(-27756) [Jump to subroutine direct]
9477:      JMP   D941E      ; =-91 [Jump relative]
*
* Function F9479
*
9479:F9479 JSR   F949B      ; =+32 [Jump to subroutine relative]
947b:D947B JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
947e:      DC    'OR'       ; hex:cfd2 dec:53202(-46)
9480:      DB    X'01'      ; =0x01 =1
9481:      BZ    D948A      ; =+7 [Branch if zero]
9483:      JSR   F949B      ; =+22 [Jump to subroutine relative]
9485:      JSR*  P941A+1    ; =-108 [Jump to subroutine relative indirect]
9487:      DB    X'13'      ; =0x13 =19
9488:      JMP   D947B      ; =-15 [Jump relative]
948a:D948A JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
948d:      DC    'XOR'      ; hex:d8cfd2
9490:      DB    X'01'      ; =0x01 =1
9491:      BZ    D949A      ; =+7 [Branch if zero]
9493:      JSR   F949B      ; =+6 [Jump to subroutine relative]
9495:      JSR*  P941A+1    ; =-124 [Jump to subroutine relative indirect]
9497:      DB    X'12'      ; =0x12 =18
9498:      JMP   D947B      ; =-31 [Jump relative]
949a:D949A RSR              ; [Return from subroutine]
*
* Function F949B
*
949b:F949B JSR   F94B3      ; =+22 [Jump to subroutine relative]
949d:D949D JSR*  D948A+1    ; =-20 [Jump to subroutine relative indirect]
949f:      DC    '&'        ; hex:a6 dec:166(-90)
94a0:      DB    X'01'      ; =0x01 =1
94a1:      BNZ   D94AB      ; =+8 [Branch if not zero]
94a3:      JSR*  D948A+1    ; =-26 [Jump to subroutine relative indirect]
94a5:      DC    'AND'      ; hex:c1cec4
94a8:      DB    X'01'      ; =0x01 =1
94a9:      BZ    D949A      ; =-17 [Branch if zero]
94ab:D94AB JSR   F94B3      ; =+6 [Jump to subroutine relative]
94ad:P94AD JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
94b0:      DB    X'11'      ; =0x11 =17
94b1:      JMP   D949D      ; =-22 [Jump relative]
*
* Function F94B3
*
94b3:F94B3 JSR*  D948A+1    ; =-42 [Jump to subroutine relative indirect]
94b5:      DC    'NOT'      ; hex:cecfd4
94b8:      DB    X'01'      ; =0x01 =1
94b9:      BNZ   D94BE      ; =+3 [Branch if not zero]
94bb:      JSR   F94C4      ; =+7 [Jump to subroutine relative]
94bd:      RSR              ; [Return from subroutine]
*
94be:D94BE JSR   F94C4      ; =+4 [Jump to subroutine relative]
94c0:      JSR*  P94AD+1    ; =-20 [Jump to subroutine relative indirect]
94c2:      DB    X'10'      ; =0x10 =16
94c3:      RSR              ; [Return from subroutine]
*
* Function F94C4
*
94c4:F94C4 JSR   F94DA      ; =+20 [Jump to subroutine relative]
94c6:      JSR/  F8A5E      ; =0x8a5e =35422(-30114) [Jump to subroutine direct]
94c9:      DW    S9848      ; =0x9848 =38984(-26552)
94cb:      BZ    D949A      ; =-51 [Branch if zero]
94cd:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
94cf:      JSR   F94DA      ; =+9 [Jump to subroutine relative]
94d1:      JSR*  P94AD+1    ; =-37 [Jump to subroutine relative indirect]
94d3:      DB    X'0F'      ; =0x0f =15
94d4:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
94d6:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
94d9:      RSR              ; [Return from subroutine]
*
* Function F94DA
*
94da:F94DA JSR   F94EA      ; =+14 [Jump to subroutine relative]
94dc:D94DC JSR*  D948A+1    ; =-83 [Jump to subroutine relative indirect]
94de:      DC    '//'       ; hex:afaf dec:44975(-81)
94e0:      DB    X'01'      ; =0x01 =1
94e1:      BZ    D949A      ; =-73 [Branch if zero]
94e3:      JSR   F94EA      ; =+5 [Jump to subroutine relative]
94e5:      JSR*  P94AD+1    ; =-57 [Jump to subroutine relative indirect]
94e7:      DB    X'0E'      ; =0x0e =14
94e8:      JMP   D94DC      ; =-14 [Jump relative]
*
* Function F94EA
*
94ea:F94EA JSR*  D948A+1    ; =-97 [Jump to subroutine relative indirect]
94ec:      DC    '-'        ; hex:ad dec:173(-83)
94ed:      DB    X'01'      ; =0x01 =1
94ee:      BZ    D94F7      ; =+7 [Branch if zero]
94f0:      JSR   F9519      ; =+39 [Jump to subroutine relative]
94f2:      JSR*  P94AD+1    ; =-70 [Jump to subroutine relative indirect]
94f4:      DB    X'0B'      ; =0x0b =11
94f5:      JMP   D94FD      ; =+6 [Jump relative]
94f7:D94F7 JSR*  D948A+1    ; =-110 [Jump to subroutine relative indirect]
94f9:      DC    '+'        ; hex:ab dec:171(-85)
94fa:      DB    X'01'      ; =0x01 =1
94fb:      JSR   F9519      ; =+28 [Jump to subroutine relative]
94fd:D94FD JSR*  D948A+1    ; =-116 [Jump to subroutine relative indirect]
94ff:      DC    '-'        ; hex:ad dec:173(-83)
9500:      DB    X'01'      ; =0x01 =1
9501:      BZ    D950A      ; =+7 [Branch if zero]
9503:      JSR   F9519      ; =+20 [Jump to subroutine relative]
9505:      JSR*  P94AD+1    ; =-89 [Jump to subroutine relative indirect]
9507:      DB    X'0C'      ; =0x0c =12
9508:      JMP   D94FD      ; =-13 [Jump relative]
950a:D950A JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
950d:      DC    '+'        ; hex:ab dec:171(-85)
950e:      DB    X'01'      ; =0x01 =1
950f:      BZ    D9518      ; =+7 [Branch if zero]
9511:      JSR   F9519      ; =+6 [Jump to subroutine relative]
9513:      JSR*  P94AD+1    ; =-103 [Jump to subroutine relative indirect]
9515:      DB    X'0D'      ; =0x0d =13
9516:      JMP   D94FD      ; =-27 [Jump relative]
9518:D9518 RSR              ; [Return from subroutine]
*
* Function F9519
*
9519:F9519 JSR   F9545      ; =+42 [Jump to subroutine relative]
951b:D951B LDA+  Z          ; [Load A from address in Z]
951c:      LDB=  X'AAAA'    ; =0xaaaa =43690(-21846) ='*','*' [Load B with immediate]
951f:      SAB              ; [A - B -> B]
9520:      BZ    D9518      ; =-10 [Branch if zero]
9522:P9522 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9525:      DC    '*'        ; hex:aa dec:170(-86)
9526:      DB    X'01'      ; =0x01 =1
9527:      BZ    D9530      ; =+7 [Branch if zero]
9529:      JSR   F9545      ; =+26 [Jump to subroutine relative]
952b:      JSR*  P94AD+1    ; =-127 [Jump to subroutine relative indirect]
952d:      DB    X'0A'      ; =0x0a =10
952e:      JMP   D951B      ; =-21 [Jump relative]
9530:D9530 LDA+  Z          ; [Load A from address in Z]
9531:      LDB=  X'AFAF'    ; =0xafaf =44975(-20561) ='/','/' [Load B with immediate]
9534:      SAB              ; [A - B -> B]
9535:      BZ    D9518      ; =-31 [Branch if zero]
9537:      JSR*  P9522+1    ; =-22 [Jump to subroutine relative indirect]
9539:      DC    '/'        ; hex:af dec:175(-81)
953a:      DB    X'01'      ; =0x01 =1
953b:      BZ    D9518      ; =-37 [Branch if zero]
953d:      JSR   F9545      ; =+6 [Jump to subroutine relative]
953f:P953F JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9542:      DB    X'09'      ; =0x09 =9
9543:      JMP   D951B      ; =-42 [Jump relative]
*
* Function F9545
*
9545:F9545 JSR   F955B      ; =+20 [Jump to subroutine relative]
9547:D9547 JSR*  P9522+1    ; =-38 [Jump to subroutine relative indirect]
9549:      DC    '**'       ; hex:aaaa dec:43690(-86)
954b:      DB    X'01'      ; =0x01 =1
954c:      BNZ   D9554      ; =+6 [Branch if not zero]
954e:      JSR*  P9522+1    ; =-45 [Jump to subroutine relative indirect]
9550:      DC    '^'        ; hex:de dec:222(-34)
9551:      DB    X'01'      ; =0x01 =1
9552:      BZ    D9518      ; =-60 [Branch if zero]
9554:D9554 JSR   F955B      ; =+5 [Jump to subroutine relative]
9556:      JSR*  P953F+1    ; =-24 [Jump to subroutine relative indirect]
9558:      DB    X'08'      ; =0x08 =8
9559:      JMP   D9547      ; =-20 [Jump relative]
*
* Function F955B
*
955b:F955B JSR*  P9522+1    ; =-58 [Jump to subroutine relative indirect]
955d:      DC    '('        ; hex:a8 dec:168(-88)
955e:      DB    X'01'      ; =0x01 =1
955f:      BZ    D9568      ; =+7 [Branch if zero]
9561:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9564:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
9567:      RSR              ; [Return from subroutine]
*
9568:D9568 JSR/  F88BF      ; =0x88bf =35007(-30529) [Jump to subroutine direct]
956b:      BZ    D956E      ; =+1 [Branch if zero]
956d:      RSR              ; [Return from subroutine]
*
956e:D956E JSR/  F8872      ; =0x8872 =34930(-30606) [Jump to subroutine direct]
9571:      BZ    D9574      ; =+1 [Branch if zero]
9573:      RSR              ; [Return from subroutine]
*
9574:D9574 JSR   F9580      ; =+10 [Jump to subroutine relative]
9576:      BZ    D957C      ; =+4 [Branch if zero]
9578:      JSR*  P953F+1    ; =-58 [Jump to subroutine relative indirect]
957a:      DB    X'16'      ; =0x16 =22
957b:      RSR              ; [Return from subroutine]
*
957c:D957C JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
957f:      DB    X'05'      ; =0x05 =5
*
*
* Function F9580
*
9580:F9580 JSR/  F8A5E      ; =0x8a5e =35422(-30114) [Jump to subroutine direct]
9583:      DW    S98FC      ; =0x98fc =39164(-26372)
9585:      BZ    D95AF      ; =+40 [Branch if zero]
9587:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
958a:      XABB             ; [Transfer AL to BL]
958b:      STB-  Y-         ; [Store B indexed, pre-decremented, direct]
958d:      LDB=  W9926      ; =0x9926 =39206(-26330) [Load B with immediate]
9590:      AAB              ; [A + B -> B]
9591:      LDAB+ B          ; [Load AL from address in B]
9592:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
9594:      JSR/  F89BF      ; =0x89bf =35263(-30273) [Jump to subroutine direct]
9597:      LDB+  Y          ; [Load B from address in Y]
9598:      ORI   A,B        ; [A | B -> B]
959a:      STB+  Y          ; [Store B to address in Y]
959b:      JSR/  F962A      ; =0x962a =38442(-27094) [Jump to subroutine direct]
959e:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
95a0:      SABB             ; [AL - BL -> BL]
95a1:      BZ    D95A7      ; =+4 [Branch if zero]
95a3:P95A3 JSR/  F8BC8      ; =0x8bc8 =35784(-29752) =VT,'H' [Jump to subroutine direct]
95a6:      DB    X'0F'      ; =0x0f =15
*
95a7:D95A7 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
95a9:P95A9 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
95ac:D95AC LDAB= X'01'      ; =1 [Load AL with immediate]
95ae:      RSR              ; [Return from subroutine]
*
95af:D95AF JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
95b2:      BNZ   D95B5      ; =+1 [Branch if not zero]
95b4:      RSR              ; [Return from subroutine]
*
95b5:D95B5 JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
95b8:      LDA+  *Y         ; [Load A indexed, indirect]
95ba:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
95bd:      NAB              ; [A & B -> B]
95be:      BZ    D95D1      ; =+17 [Branch if zero]
95c0:      JSR   F962A      ; =+104 [Jump to subroutine relative]
95c2:P95C2 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
95c5:      DB    X'04'      ; =0x04 =4
95c6:      LDB+  Y          ; [Load B from address in Y]
95c7:      LDA+  B,2        ; [Load A indexed, displaced, direct]
95ca:      JSR*  P95A9+1    ; =-34 [Jump to subroutine relative indirect]
95cc:      LDA+  *Y         ; [Load A indexed, indirect]
95ce:      STA+  Y          ; [Store A to address in Y]
95cf:      JMP   D95A7      ; =-42 [Jump relative]
95d1:D95D1 JSR*  P95A9+1    ; =-41 [Jump to subroutine relative indirect]
95d3:      LDA+  Y          ; [Load A from address in Y]
95d4:      LDB+  A,2        ; [Load B indexed, displaced, direct]
95d7:      BP    D95DD      ; =+4 [Branch on plus]
95d9:D95D9 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
95db:      JMP   D95AC      ; =-49 [Jump relative]
95dd:D95DD JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
95e0:      DC    '('        ; hex:a8 dec:168(-88)
95e1:      DB    X'01'      ; =0x01 =1
95e2:      BNZ   D95E9      ; =+5 [Branch if not zero]
95e4:D95E4 JSR*  P95A3+1    ; =-66 [Jump to subroutine relative indirect]
95e6:      DB    X'06'      ; =0x06 =6
95e7:      JMP   D95D9      ; =-16 [Jump relative]
95e9:D95E9 JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
95ec:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
95ee:      LDB+  A,2        ; [Load B indexed, displaced, direct]
95f1:      BZ    D9622      ; =+47 [Branch if zero]
95f3:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
95f5:      JSR*  P95C2+1    ; =-52 [Jump to subroutine relative indirect]
95f7:      DB    X'04'      ; =0x04 =4
95f8:      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
95fb:      JSR*  P95A9+1    ; =-83 [Jump to subroutine relative indirect]
95fd:      LDA=  X'500D'    ; =0x500d =20493 [Load A with immediate]
9600:      JSR*  P95A9+1    ; =-88 [Jump to subroutine relative indirect]
9602:      JSR*  P95C2+1    ; =-65 [Jump to subroutine relative indirect]
9604:      DB    X'16'      ; =0x16 =22
*
9605:P9605 JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9608:      DB    X'04'      ; =0x04 =4
9609:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
960b:      JSR*  P95A9+1    ; =-99 [Jump to subroutine relative indirect]
960d:      JSR*  P9605+1    ; =-9 [Jump to subroutine relative indirect]
960f:      DB    X'0A'      ; =0x0a =10
*
9610:      JSR*  P9605+1    ; =-12 [Jump to subroutine relative indirect]
9612:      DB    X'14'      ; =0x14 =20
9613:      JSR*  D95DD+1    ; =-55 [Jump to subroutine relative indirect]
9615:      DC    ')'        ; hex:a9 dec:169(-87)
9616:      DB    X'01'      ; =0x01 =1
9617:      BNZ   D95E4      ; =-53 [Branch if not zero]
9619:      JSR*  D95DD+1    ; =-61 [Jump to subroutine relative indirect]
961b:      DC    ','        ; hex:ac dec:172(-84)
961c:      DB    X'01'      ; =0x01 =1
961d:      BZ    D95E4      ; =-59 [Branch if zero]
961f:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9622:D9622 JSR*  P9605+1    ; =-30 [Jump to subroutine relative indirect]
9624:      DB    X'14'      ; =0x14 =20
9625:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
9628:      JMP   D95AC      ; =-126 [Jump relative]
*
* Function F962A
*
962a:F962A CLA              ; [Clear A]
962b:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
962d:      JSR*  D95DD+1    ; =-81 [Jump to subroutine relative indirect]
962f:      DC    '('        ; hex:a8 dec:168(-88)
9630:      DB    X'01'      ; =0x01 =1
9631:      BZ    D9642      ; =+15 [Branch if zero]
9633:D9633 LDA+  S          ; [Load A from address in S]
9634:      INA              ; [Increment A]
9635:      STA+  S          ; [Store A to address in S]
9636:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
9639:      JSR*  D95DD+1    ; =-93 [Jump to subroutine relative indirect]
963b:      DC    ','        ; hex:ac dec:172(-84)
963c:      DB    X'01'      ; =0x01 =1
963d:      BNZ   D9633      ; =-12 [Branch if not zero]
963f:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
9642:D9642 JSR*  P9605+1    ; =-62 [Jump to subroutine relative indirect]
9644:      DB    X'04'      ; =0x04 =4
9645:      LDA+  S          ; [Load A from address in S]
9646:P9646 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9649:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
964b:      RSR              ; [Return from subroutine]
*
* Function F964C
*
964c:F964C JSR*  D95DD+1    ; =-112 [Jump to subroutine relative indirect]
964e:      DC    '#'        ; hex:a3 dec:163(-93)
964f:      DB    X'01'      ; =0x01 =1
9650:      BNZ   F965A      ; =+8 [Branch if not zero]
9652:      JSR*  P9605+1    ; =-78 [Jump to subroutine relative indirect]
9654:      DB    X'04'      ; =0x04 =4
9655:      CLA              ; [Clear A]
9656:      JSR*  P9646+1    ; =-17 [Jump to subroutine relative indirect]
9658:      JMP   D965D      ; =+3 [Jump relative]
*
* Function F965A
*
965a:F965A JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
965d:D965D LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
965f:      BM    D9666      ; =+5 [Branch on minus]
9661:      STAB  B9665      ; =+2 [Store AL relative]
9663:      JSR*  P9605+1    ; =-95 [Jump to subroutine relative indirect]
9665:B9665 DB    X'00'      ; =0x00 =0 =NUL
*
9666:D9666 RSR              ; [Return from subroutine]
*
* Function F9667
*
9667:F9667 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
966a:      DC    '#'        ; hex:a3 dec:163(-93)
966b:      DB    X'01'      ; =0x01 =1
966c:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
966f:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9672:      DC    ','        ; hex:ac dec:172(-84)
9673:      DB    X'01'      ; =0x01 =1
9674:      JMP   D965D      ; =-25 [Jump relative]
9676:W9676 LDAB= X'35'      ; =53 [Load AL with immediate]
9678:      JMP   D967C      ; =+2 [Jump relative]
967a:W967A LDAB= X'36'      ; =54 [Load AL with immediate]
967c:D967C STAB  B968D      ; =+15 [Store AL relative]
967e:      JSR   F9667      ; =-25 [Jump to subroutine relative]
9680:      DB    X'FF'      ; =0xff =255(-1)
9681:      JSR/  F9580      ; =0x9580 =38272(-27264) [Jump to subroutine direct]
9684:      BNZ   P968A      ; =+4 [Branch if not zero]
9686:D9686 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9689:      DB    X'14'      ; =0x14 =20
*
968a:P968A JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
968d:B968D DB    X'00'      ; =0x00 =0 =NUL
968e:      JMP   D96EC      ; =+92 [Jump relative]
9690:W9690 JSR   F9667      ; =-43 [Jump to subroutine relative]
9692:      DB    X'2F'      ; =0x2f =47
9693:      JMP   D96EC      ; =+87 [Jump relative]
9695:W9695 JSR   F9667      ; =-48 [Jump to subroutine relative]
9697:      DB    X'30'      ; =0x30 =48
9698:      JMP   D96EC      ; =+82 [Jump relative]
969a:W969A JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
969d:      DC    '#'        ; hex:a3 dec:163(-93)
969e:      DB    X'01'      ; =0x01 =1
969f:      BZ    D9686      ; =-27 [Branch if zero]
96a1:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
96a4:      JSR*  P968A+1    ; =-27 [Jump to subroutine relative indirect]
96a6:      DB    X'39'      ; =0x39 =57
96a7:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
96aa:      DC    ','        ; hex:ac dec:172(-84)
96ab:      DB    X'01'      ; =0x01 =1
96ac:      BNZ   D96B3      ; =+5 [Branch if not zero]
96ae:      JSR*  P968A+1    ; =-37 [Jump to subroutine relative indirect]
96b0:      DB    X'3D'      ; =0x3d =61
96b1:      JMP   D96B6      ; =+3 [Jump relative]
96b3:D96B3 JSR/  F9580      ; =0x9580 =38272(-27264) [Jump to subroutine direct]
96b6:D96B6 JSR*  P968A+1    ; =-45 [Jump to subroutine relative indirect]
96b8:      DB    X'3E'      ; =0x3e =62
96b9:      JMP   D96EC      ; =+49 [Jump relative]
96bb:W96BB JSR   F9667      ; =-86 [Jump to subroutine relative]
96bd:      DB    X'37'      ; =0x37 =55
96be:      JMP   D96EC      ; =+44 [Jump relative]
96c0:W96C0 JSR   F9667      ; =-91 [Jump to subroutine relative]
96c2:      DB    X'38'      ; =0x38 =56
96c3:      JMP   D96EC      ; =+39 [Jump relative]
96c5:W96C5 JSR   F9667      ; =-96 [Jump to subroutine relative]
96c7:      DB    X'3F'      ; =0x3f =63
96c8:      JMP   D96EC      ; =+34 [Jump relative]
96ca:W96CA JSR/  F964C      ; =0x964c =38476(-27060) [Jump to subroutine direct]
96cd:      DB    X'FF'      ; =0xff =255(-1)
96ce:P96CE JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
96d1:      DC    ','        ; hex:ac dec:172(-84)
96d2:      DB    X'01'      ; =0x01 =1
96d3:      BNZ   D9686      ; =-79 [Branch if not zero]
96d5:      JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
96d8:      JSR*  P96CE+1    ; =-11 [Jump to subroutine relative indirect]
96da:      DC    ','        ; hex:ac dec:172(-84)
96db:      DB    X'01'      ; =0x01 =1
96dc:      BNZ   D96E8      ; =+10 [Branch if not zero]
96de:      CLA              ; [Clear A]
96df:      JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
96e2:      JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
96e5:      DB    X'42'      ; =0x42 =66
96e6:      JMP   D96EC      ; =+4 [Jump relative]
96e8:D96E8 JSR/  F965A      ; =0x965a =38490(-27046) [Jump to subroutine direct]
96eb:      DB    X'42'      ; =0x42 =66
*
96ec:D96EC JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
96ef:W96EF JSR/  F9479      ; =0x9479 =38009(-27527) [Jump to subroutine direct]
96f2:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
96f5:      DC    ','        ; hex:ac dec:172(-84)
96f6:      DB    X'01'      ; =0x01 =1
96f7:      BZ    D9686      ; =-115 [Branch if zero]
96f9:      JSR/  F965A      ; =0x965a =38490(-27046) [Jump to subroutine direct]
96fc:      DB    X'43'      ; =0x43 =67
96fd:      JMP   D96EC      ; =-19 [Jump relative]
96ff:W96FF JSR/  F965A      ; =0x965a =38490(-27046) [Jump to subroutine direct]
9702:      DB    X'44'      ; =0x44 =68
9703:      JMP   D96EC      ; =-25 [Jump relative]
*
9705:S9705 DC    'ALL'      ; hex:c1cccc
9708:      DB    X'18'      ; =0x18 =24
9709:      DC    'HAIN'     ; hex:c8c1c9ce
970d:      DB    X'68'      ; =0x68 =104
970e:      DC    'LOSE'     ; hex:cccfd3c5
9712:      DB    X'13'      ; =0x13 =19
9713:      DC    'URSOR'    ; hex:d5d2d3cfd2
9718:      DW    X'1B00'    ; =0x1b00 =6912
971a:S971A DC    'ATA'      ; hex:c1d4c1
971d:      DB    X'41'      ; =0x41 =65
971e:      DC    'ECLARE'   ; hex:c5c3ccc1d2c5
9724:      DB    X'64'      ; =0x64 =100
9725:      DC    'EF'       ; hex:c5c6 dec:50630(-58)
9727:      DB    X'43'      ; =0x43 =67
9728:      DC    'IM'       ; hex:c9cd dec:51661(-51)
972a:      DB    X'44'      ; =0x44 =68
972b:      DC    'LTKEY'    ; hex:ccd4cbc5d9
9730:      DW    X'2B00'    ; =0x2b00 =11008
9732:S9732 DC    'ND'       ; hex:cec4 dec:52932(-60)
9734:      DB    X'45'      ; =0x45 =69
9735:      DC    'LSE'      ; hex:ccd3c5
9738:      DW    X'2A00'    ; =0x2a00 =10752
973a:S973A DC    'ILE'      ; hex:c9ccc5
973d:      DB    X'59'      ; =0x59 =89
973e:      DC    'NEND'     ; hex:cec5cec4
9742:      DB    X'56'      ; =0x56 =86
9743:      DC    'ORMAT'    ; hex:cfd2cdc1d4
9748:      DB    X'57'      ; =0x57 =87
9749:      DC    'OR'       ; hex:cfd2 dec:53202(-46)
974b:      DB    X'06'      ; =0x06 =6
974c:      DC    'REE'      ; hex:d2c5c5
974f:      DW    X'1D00'    ; =0x1d00 =7424
9751:S9751 DC    'ETKEY'    ; hex:c5d4cbc5d9
9756:      DB    X'22'      ; =0x22 =34
9757:      DC    'OSUB'     ; hex:cfd3d5c2
975b:      DB    X'07'      ; =0x07 =7
975c:      DC    'OTO'      ; hex:cfd4cf
975f:      DW    X'0800'    ; =0x0800 =2048
9761:S9761 DC    'OLD'      ; hex:cfccc4
9764:      DW    X'1C00'    ; =0x1c00 =7168
9766:S9766 DC    'F'        ; hex:c6 dec:198(-58)
9767:      DB    X'09'      ; =0x09 =9
9768:      DC    'NPUT'     ; hex:ced0d5d4
976c:      DW    X'0A00'    ; =0x0a00 =2560
976e:S976E DC    'ET'       ; hex:c5d4 dec:50644(-44)
9770:      DB    X'0B'      ; =0x0b =11
9771:      DC    'INELENGTH' ; hex:c9cec5ccc5cec7d4c8
977a:      DB    X'27'      ; =0x27 =39
977b:      DC    'OCAL'     ; hex:cfc3c1cc
977f:      DW    X'6500'    ; =0x6500 =25856
9781:S9781 DC    'OVE'      ; hex:cfd6c5
9784:      DW    X'2C00'    ; =0x2c00 =11264
9786:S9786 DC    'EWKEY'    ; hex:c5d7cbc5d9
978b:      DB    X'23'      ; =0x23 =35
978c:      DC    'EXTKEY'   ; hex:c5d8d4cbc5d9
9792:      DB    X'26'      ; =0x26 =38
9793:      DC    'EXT'      ; hex:c5d8d4
9796:      DB    X'4C'      ; =0x4c =76
9797:      DC    'OTE'      ; hex:cfd4c5
979a:      DW    X'2000'    ; =0x2000 =8192
979c:S979C DC    'N'        ; hex:ce dec:206(-50)
979d:      DB    X'15'      ; =0x15 =21
979e:      DC    'PEN'      ; hex:d0c5ce
97a1:      DB    X'02'      ; =0x02 =2
97a2:      DC    'UTPUT'    ; hex:d5d4d0d5d4
97a7:      DW    X'1E00'    ; =0x1e00 =7680
97a9:S97A9 DC    'OINT'     ; hex:cfc9ced4
97ad:      DB    X'21'      ; =0x21 =33
97ae:      DC    'RINT'     ; hex:d2c9ced4
97b2:      DB    X'0D'      ; =0x0d =13
97b3:      DC    'JP'       ; hex:cad0 dec:51920(-48)
97b5:      DB    X'2D'      ; =0x2d =45
97b6:      DC    'UPSI'     ; hex:d5d0d3c9
97ba:      DW    X'2E00'    ; =0x2e00 =11776
97bc:S97BC DC    'ANDOMIZE' ; hex:c1cec4cfcdc9dac5
97c4:      DB    X'29'      ; =0x29 =41
97c5:      DC    'EAD'      ; hex:c5c1c4
97c8:      DB    X'0E'      ; =0x0e =14
97c9:      DC    'ECORD'    ; hex:c5c3cfd2c4
97ce:      DB    X'5A'      ; =0x5a =90
97cf:      DC    'EM'       ; hex:c5cd dec:50637(-51)
97d1:      DB    X'4F'      ; =0x4f =79
97d2:      DC    'ESTORE'   ; hex:c5d3d4cfd2c5
97d8:      DB    X'14'      ; =0x14 =20
97d9:      DC    'ETURN'    ; hex:c5d4d5d2ce
97de:      DB    X'50'      ; =0x50 =80
97df:      DC    'EWRITE'   ; hex:c5d7d2c9d4c5
97e5:      DW    X'1F00'    ; =0x1f00 =7936
97e7:S97E7 DC    'TOP'      ; hex:d4cfd0
97ea:      DW    X'5100'    ; =0x5100 =20736
97ec:S97EC DC    'RITE'     ; hex:d2c9d4c5
97f0:      DW    X'1200'    ; =0x1200 =4608
97f2:S97F2 DC    'C'        ; hex:c3 dec:195(-61)
97f3:      DW    S9705      ; =0x9705 =38661(-26875)
97f5:      DC    'D'        ; hex:c4 dec:196(-60)
97f6:      DW    S971A      ; =0x971a =38682(-26854)
97f8:      DC    'E'        ; hex:c5 dec:197(-59)
97f9:      DW    S9732      ; =0x9732 =38706(-26830)
97fb:      DC    'F'        ; hex:c6 dec:198(-58)
97fc:      DW    S973A      ; =0x973a =38714(-26822)
97fe:      DC    'G'        ; hex:c7 dec:199(-57)
97ff:      DW    S9751      ; =0x9751 =38737(-26799)
9801:      DC    'H'        ; hex:c8 dec:200(-56)
9802:      DW    S9761      ; =0x9761 =38753(-26783)
9804:      DC    'I'        ; hex:c9 dec:201(-55)
9805:      DW    S9766      ; =0x9766 =38758(-26778)
9807:      DC    'L'        ; hex:cc dec:204(-52)
9808:      DW    S976E      ; =0x976e =38766(-26770)
980a:      DC    'M'        ; hex:cd dec:205(-51)
980b:      DW    S9781      ; =0x9781 =38785(-26751)
980d:      DC    'N'        ; hex:ce dec:206(-50)
980e:      DW    S9786      ; =0x9786 =38790(-26746)
9810:      DC    'O'        ; hex:cf dec:207(-49)
9811:      DW    S979C      ; =0x979c =38812(-26724)
9813:      DC    'P'        ; hex:d0 dec:208(-48)
9814:      DW    S97A9      ; =0x97a9 =38825(-26711)
9816:      DC    'R'        ; hex:d2 dec:210(-46)
9817:      DW    S97BC      ; =0x97bc =38844(-26692)
9819:      DC    'S'        ; hex:d3 dec:211(-45)
981a:      DW    S97E7      ; =0x97e7 =38887(-26649)
981c:      DC    'W'        ; hex:d7 dec:215(-41)
981d:      DW    S97EC      ; =0x97ec =38892(-26644)
981f:      DB    X'00'      ; =0x00 =0 =NUL
9820:S9820 DC    '='        ; hex:bd dec:189(-67)
9821:      DB    X'03'      ; =0x03 =3
9822:      DC    '>'        ; hex:be dec:190(-66)
9823:      DW    X'0602'    ; =0x0602 =1538
9825:      DB    X'00'      ; =0x00 =0 =NUL
9826:W9826 DW    X'0100'    ; =0x0100 =256
9828:S9828 DC    '='        ; hex:bd dec:189(-67)
9829:      DW    X'0504'    ; =0x0504 =1284
982b:      DB    X'00'      ; =0x00 =0 =NUL
982c:S982C DC    'Q'        ; hex:d1 dec:209(-47)
982d:      DW    X'0100'    ; =0x0100 =256
982f:S982F DC    'E'        ; hex:c5 dec:197(-59)
9830:      DB    X'05'      ; =0x05 =5
9831:      DC    'T'        ; hex:d4 dec:212(-44)
9832:      DW    X'0400'    ; =0x0400 =1024
9834:S9834 DC    'E'        ; hex:c5 dec:197(-59)
9835:      DB    X'03'      ; =0x03 =3
9836:      DC    'T'        ; hex:d4 dec:212(-44)
9837:      DW    X'0200'    ; =0x0200 =512
9839:S9839 DC    'E'        ; hex:c5 dec:197(-59)
983a:      DW    X'0600'    ; =0x0600 =1536
983c:S983C DC    '='        ; hex:bd dec:189(-67)
983d:      DB    X'03'      ; =0x03 =3
983e:      DC    '>'        ; hex:be dec:190(-66)
983f:      DW    X'0602'    ; =0x0602 =1538
9841:      DB    X'00'      ; =0x00 =0 =NUL
9842:S9842 DC    '='        ; hex:bd dec:189(-67)
9843:      DB    X'05'      ; =0x05 =5
9844:      DC    '<'        ; hex:bc dec:188(-68)
9845:      DW    X'0604'    ; =0x0604 =1540
9847:      DB    X'00'      ; =0x00 =0 =NUL
9848:S9848 DC    '<'        ; hex:bc dec:188(-68)
9849:      DW    S9820      ; =0x9820 =38944(-26592)
984b:      DC    '='        ; hex:bd dec:189(-67)
984c:      DW    W9826      ; =0x9826 =38950(-26586)
984e:      DC    '>'        ; hex:be dec:190(-66)
984f:      DW    S9828      ; =0x9828 =38952(-26584)
9851:      DC    'E'        ; hex:c5 dec:197(-59)
9852:      DW    S982C      ; =0x982c =38956(-26580)
9854:      DC    'G'        ; hex:c7 dec:199(-57)
9855:      DW    S982F      ; =0x982f =38959(-26577)
9857:      DC    'L'        ; hex:cc dec:204(-52)
9858:      DW    S9834      ; =0x9834 =38964(-26572)
985a:      DC    'N'        ; hex:ce dec:206(-50)
985b:      DW    S9839      ; =0x9839 =38969(-26567)
985d:      DC    '<'        ; hex:bc dec:188(-68)
985e:      DW    S983C      ; =0x983c =38972(-26564)
9860:      DC    '>'        ; hex:be dec:190(-66)
9861:      DW    S9842      ; =0x9842 =38978(-26558)
9863:      DB    X'00'      ; =0x00 =0 =NUL
9864:S9864 DC    'NPUT'     ; hex:ced0d5d4
9868:      DB    X'01'      ; =0x01 =1
9869:      DC    'O'        ; hex:cf dec:207(-49)
986a:      DW    X'0300'    ; =0x0300 =768
986c:S986C DC    'UTPUT'    ; hex:d5d4d0d5d4
9871:      DW    X'0200'    ; =0x0200 =512
9873:S9873 DC    'I'        ; hex:c9 dec:201(-55)
9874:      DW    S9864      ; =0x9864 =39012(-26524)
9876:      DC    'O'        ; hex:cf dec:207(-49)
9877:      DW    S986C      ; =0x986c =39020(-26516)
9879:      DB    X'00'      ; =0x00 =0 =NUL
987a:S987A DC    'BS'       ; hex:c2d3 dec:49875(-45)
987c:      DB    X'0C'      ; =0x0c =12
987d:      DC    'DDR'      ; hex:c4c4d2
9880:      DB    X'16'      ; =0x16 =22
9881:      DC    'SCII'     ; hex:d3c3c9c9
9885:      DW    X'0600'    ; =0x0600 =1536
9887:S9887 DC    'HR'       ; hex:c8d2 dec:51410(-46)
9889:      DW    X'0500'    ; =0x0500 =1280
988b:S988B DC    'ATE'      ; hex:c1d4c5
988e:      DW    X'0F00'    ; =0x0f00 =3840
9890:S9890 DC    'ND'       ; hex:cec4 dec:52932(-60)
9892:      DB    X'0A'      ; =0x0a =10
9893:      DC    'RR'       ; hex:d2d2 dec:53970(-46)
9895:      DB    X'0E'      ; =0x0e =14
9896:      DC    'XP'       ; hex:d8d0 dec:55504(-48)
9898:      DW    X'2100'    ; =0x2100 =8448
989a:S989A DC    'ALSE'     ; hex:c1ccd3c5
989e:      DB    X'1A'      ; =0x1a =26
989f:      DC    'ILEID'    ; hex:c9ccc5c9c4
98a4:      DW    X'1F00'    ; =0x1f00 =7936
98a6:S98A6 DC    'NT'       ; hex:ced4 dec:52948(-44)
98a8:      DW    X'0D00'    ; =0x0d00 =3328
98aa:S98AA DC    'P'        ; hex:d0 dec:208(-48)
98ab:      DW    X'1F00'    ; =0x1f00 =7936
98ad:S98AD DC    'EYX'      ; hex:c5d9d8
98b0:      DW    X'1C00'    ; =0x1c00 =7168
98b2:S98B2 DC    'C'        ; hex:c3 dec:195(-61)
98b3:      DB    X'03'      ; =0x03 =3
98b4:      DC    'EN'       ; hex:c5ce dec:50638(-50)
98b6:      DB    X'07'      ; =0x07 =7
98b7:      DC    'OG'       ; hex:cfc7 dec:53191(-57)
98b9:      DW    X'2000'    ; =0x2000 =8192
98bb:S98BB DC    'EEK'      ; hex:c5c5cb
98be:      DB    X'14'      ; =0x14 =20
98bf:      DC    'OKE'      ; hex:cfcbc5
98c2:      DW    X'1500'    ; =0x1500 =5376
98c4:S98C4 DC    'ECLEN'    ; hex:c5c3ccc5ce
98c9:      DB    X'1B'      ; =0x1b =27
98ca:      DC    'EP'       ; hex:c5d0 dec:50640(-48)
98cc:      DB    X'04'      ; =0x04 =4
98cd:      DC    'ND'       ; hex:cec4 dec:52932(-60)
98cf:      DW    X'1700'    ; =0x1700 =5888
98d1:S98D1 DC    'GN'       ; hex:c7ce dec:51150(-50)
98d3:      DB    X'0B'      ; =0x0b =11
98d4:      DC    'HL'       ; hex:c8cc dec:51404(-52)
98d6:      DB    X'12'      ; =0x12 =18
98d7:      DC    'HR'       ; hex:c8d2 dec:51410(-46)
98d9:      DB    X'13'      ; =0x13 =19
98da:      DC    'STR'      ; hex:d3d4d2
98dd:      DB    X'01'      ; =0x01 =1
98de:      DC    'SW'       ; hex:d3d7 dec:54231(-41)
98e0:      DB    X'08'      ; =0x08 =8
98e1:      DC    'TATUS'    ; hex:d4c1d4d5d3
98e6:      DW    X'1000'    ; =0x1000 =4096
98e8:S98E8 DC    'AB'       ; hex:c1c2 dec:49602(-62)
98ea:      DB    X'09'      ; =0x09 =9
98eb:      DC    'RACE'     ; hex:d2c1c3c5
98ef:      DB    X'11'      ; =0x11 =17
98f0:      DC    'RUE'      ; hex:d2d5c5
98f3:      DW    X'1900'    ; =0x1900 =6400
98f5:S98F5 DC    'C'        ; hex:c3 dec:195(-61)
98f6:      DB    X'02'      ; =0x02 =2
98f7:      DC    'PSI'      ; hex:d0d3c9
98fa:      DW    X'1800'    ; =0x1800 =6144
98fc:S98FC DC    'A'        ; hex:c1 dec:193(-63)
98fd:      DW    S987A      ; =0x987a =39034(-26502)
98ff:      DC    'C'        ; hex:c3 dec:195(-61)
9900:      DW    S9887      ; =0x9887 =39047(-26489)
9902:      DC    'D'        ; hex:c4 dec:196(-60)
9903:      DW    S988B      ; =0x988b =39051(-26485)
9905:      DC    'E'        ; hex:c5 dec:197(-59)
9906:      DW    S9890      ; =0x9890 =39056(-26480)
9908:      DC    'F'        ; hex:c6 dec:198(-58)
9909:      DW    S989A      ; =0x989a =39066(-26470)
990b:      DC    'I'        ; hex:c9 dec:201(-55)
990c:      DW    S98A6      ; =0x98a6 =39078(-26458)
990e:      DC    'J'        ; hex:ca dec:202(-54)
990f:      DW    S98AA      ; =0x98aa =39082(-26454)
9911:      DC    'K'        ; hex:cb dec:203(-53)
9912:      DW    S98AD      ; =0x98ad =39085(-26451)
9914:      DC    'L'        ; hex:cc dec:204(-52)
9915:      DW    S98B2      ; =0x98b2 =39090(-26446)
9917:      DC    'P'        ; hex:d0 dec:208(-48)
9918:      DW    S98BB      ; =0x98bb =39099(-26437)
991a:      DC    'R'        ; hex:d2 dec:210(-46)
991b:      DW    S98C4      ; =0x98c4 =39108(-26428)
991d:      DC    'S'        ; hex:d3 dec:211(-45)
991e:      DW    S98D1      ; =0x98d1 =39121(-26415)
9920:      DC    'T'        ; hex:d4 dec:212(-44)
9921:      DW    S98E8      ; =0x98e8 =39144(-26392)
9923:      DC    'U'        ; hex:d5 dec:213(-43)
9924:      DW    S98F5      ; =0x98f5 =39157(-26379)
9926:W9926 DW    X'0003'    ; =0x0003 =3
9928:      DW    X'0101'    ; =0x0101 =257
992a:      DW    X'0201'    ; =0x0201 =513
992c:      DW    X'0101'    ; =0x0101 =257
992e:      DW    X'0101'    ; =0x0101 =257
9930:      DW    X'0101'    ; =0x0101 =257
9932:      DW    X'0101'    ; =0x0101 =257
9934:      DW    X'0100'    ; =0x0100 =256
9936:      DB    X'00'      ; =0x00 =0 =NUL
9937:      DW    X'0102'    ; =0x0102 =258
9939:      DW    X'0202'    ; =0x0202 =514
993b:      DW    X'0301'    ; =0x0301 =769
993d:      DW    X'0100'    ; =0x0100 =256
993f:      DB    0,3        ; =0x00,0x0003
9942:      DW    X'0100'    ; =0x0100 =256
9944:      DB    X'00'      ; =0x00 =0 =NUL
9945:      DW    X'0101'    ; =0x0101 =257
9947:      DB    X'01'      ; =0x01 =1
*
9948:W9948 CLA              ; [Clear A]
9949:P9949 LDAB/ S870E      ; =0x870e =34574(-30962) [Load AL direct]
994c:      LDBB= X'0F'      ; =15 [Load BL with immediate]
994e:      SABB             ; [AL - BL -> BL]
994f:      BLE   D9955      ; =+4 [Branch if less than or equal to zero]
9951:P9951 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9954:      DB    X'58'      ; =0x58 =88
*
9955:D9955 XABB             ; [Transfer AL to BL]
9956:      INRB  BL         ; [Increment BL by 1]
9958:      STBB* P9949+1    ; =-16 [Store BL relative indirect]
995a:      SLR   A,3        ; [Left shift A by 3]
995c:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
995e:      LDX=  W8D2F      ; =0x8d2f =36143(-29393) [Load X with immediate]
9961:      ADD   A,X        ; [A + X -> X]
9963:      LDA+  Z          ; [Load A from address in Z]
9964:      LDB=  X'D3D9'    ; =0xd3d9 =54233(-11303) ='S','Y' [Load B with immediate]
9967:      SAB              ; [A - B -> B]
9968:      BNZ   W9975      ; =+11 [Branch if not zero]
996a:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
996c:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
996e:      LDBB= X'D3'      ; =211(-45) ='S' [Load BL with immediate]
9970:      SABB             ; [AL - BL -> BL]
9971:      BZ    P9978      ; =+5 [Branch if zero]
9973:      DCR   Z          ; [Decrement Z by 1]
9975:W9975 JSR*  P9951+1    ; =-37 [Jump to subroutine relative indirect]
9977:      DB    X'19'      ; =0x19 =25
9978:P9978 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
997b:      DC    'RDR'      ; hex:d2c4d2
997e:      DB    X'01'      ; =0x01 =1
997f:      BNZ   D9999      ; =+24 [Branch if not zero]
9981:      JSR*  P9978+1    ; =-10 [Jump to subroutine relative indirect]
9983:      DC    'IPT'      ; hex:c9d0d4
9986:      DB    X'02'      ; =0x02 =2
9987:      BNZ   D9999      ; =+16 [Branch if not zero]
9989:      JSR*  P9978+1    ; =-18 [Jump to subroutine relative indirect]
998b:      DC    'LOG'      ; hex:cccfc7
998e:      DB    X'03'      ; =0x03 =3
998f:      BNZ   D9999      ; =+8 [Branch if not zero]
9991:      JSR*  P9978+1    ; =-26 [Jump to subroutine relative indirect]
9993:      DC    'LST'      ; hex:ccd3d4
9996:      DB    X'04'      ; =0x04 =4
9997:      BZ    D99A0      ; =+7 [Branch if zero]
9999:D9999 DCAB             ; [Decrement AL]
999a:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
999c:      ORIB  BL,AL      ; [BL | AL -> AL]
999e:      JMP   D99A7      ; =+7 [Jump relative]
99a0:D99A0 JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
99a3:      BZ    W9975      ; =-48 [Branch if zero]
99a5:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
99a7:D99A7 STAB+ X,4        ; [Store AL indexed, displaced, direct]
99aa:      JMP   D99DC      ; =+48 [Jump relative]
99ac:W99AC JSR*  P9978+1    ; =-53 [Jump to subroutine relative indirect]
99ae:      DC    'SEQ'      ; hex:d3c5d1
99b1:      DB    X'01'      ; =0x01 =1
99b2:      BNZ   D99CC      ; =+24 [Branch if not zero]
99b4:      JSR*  P9978+1    ; =-61 [Jump to subroutine relative indirect]
99b6:      DC    'RND'      ; hex:d2cec4
99b9:      DB    X'02'      ; =0x02 =2
99ba:      BNZ   D99CC      ; =+16 [Branch if not zero]
99bc:      JSR*  P9978+1    ; =-69 [Jump to subroutine relative indirect]
99be:      DC    'IND'      ; hex:c9cec4
99c1:      DB    X'03'      ; =0x03 =3
99c2:      BNZ   D99CC      ; =+8 [Branch if not zero]
99c4:      JSR*  P9978+1    ; =-77 [Jump to subroutine relative indirect]
99c6:      DC    'SPN'      ; hex:d3d0ce
99c9:      DB    X'05'      ; =0x05 =5
99ca:      BZ    D99D0      ; =+4 [Branch if zero]
99cc:D99CC DCAB             ; [Decrement AL]
99cd:      SLAB             ; [Left shift AL]
99ce:      JMP   D99F9      ; =+41 [Jump relative]
99d0:D99D0 JSR/  F8A5E      ; =0x8a5e =35422(-30114) [Jump to subroutine direct]
99d3:      DW    S9A8E      ; =0x9a8e =39566(-25970)
99d5:      SLA              ; [Left shift A]
99d6:      LDB=  W9AA1      ; =0x9aa1 =39585(-25951) [Load B with immediate]
99d9:      AAB              ; [A + B -> B]
99da:      JMP+  *B         ; [Jump indexed, indirect]
99dc:D99DC JSR*  P9978+1    ; =-101 [Jump to subroutine relative indirect]
99de:      DC    ','        ; hex:ac dec:172(-84)
99df:      DB    X'01'      ; =0x01 =1
99e0:      BNZ   W99AC      ; =-54 [Branch if not zero]
99e2:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
99e4:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
99e7:W99E7 JSR*  P9978+1    ; =-112 [Jump to subroutine relative indirect]
99e9:      DC    'NO'       ; hex:cecf dec:52943(-49)
99eb:      DB    X'01'      ; =0x01 =1
99ec:      BNZ   D99DC      ; =-18 [Branch if not zero]
99ee:      JSR*  P9978+1    ; =-119 [Jump to subroutine relative indirect]
99f0:      DC    'YES'      ; hex:d9c5d3
99f3:      DB    X'01'      ; =0x01 =1
99f4:      BNZ   D99F9      ; =+3 [Branch if not zero]
99f6:D99F6 JMP/  W9975      ; =0x9975 =39285(-26251) [Jump direct]
99f9:D99F9 LDBB+ X,5        ; [Load BL indexed, displaced, direct]
99fc:      BP    D9A00      ; =+2 [Branch on plus]
99fe:      CLRB  BL         ; [Clear BL]
9a00:D9A00 ORIB  AL,BL      ; [AL | BL -> BL]
9a02:      STBB+ X,5        ; [Store BL indexed, displaced, direct]
9a05:      JMP   D99DC      ; =-43 [Jump relative]
9a07:W9A07 JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
9a0a:      BZ    D99F6      ; =-22 [Branch if zero]
9a0c:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9a0e:      STAB+ X,6        ; [Store AL indexed, displaced, direct]
9a11:      JMP   D99DC      ; =-55 [Jump relative]
9a13:W9A13 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9a16:      DC    'A'        ; hex:c1 dec:193(-63)
9a17:      DB    X'03'      ; =0x03 =3
9a18:      BNZ   D9A3A      ; =+32 [Branch if not zero]
9a1a:      JSR*  W9A13+1    ; =-8 [Jump to subroutine relative indirect]
9a1c:      DC    'B'        ; hex:c2 dec:194(-62)
9a1d:      DB    X'02'      ; =0x02 =2
9a1e:      BNZ   D9A3A      ; =+26 [Branch if not zero]
9a20:      JSR*  W9A13+1    ; =-14 [Jump to subroutine relative indirect]
9a22:      DC    'C'        ; hex:c3 dec:195(-61)
9a23:      DB    X'04'      ; =0x04 =4
9a24:      BNZ   D9A3A      ; =+20 [Branch if not zero]
9a26:      JSR*  W9A13+1    ; =-20 [Jump to subroutine relative indirect]
9a28:      DC    'I'        ; hex:c9 dec:201(-55)
9a29:      DB    X'07'      ; =0x07 =7
9a2a:      BNZ   D9A3A      ; =+14 [Branch if not zero]
9a2c:      JSR*  W9A13+1    ; =-26 [Jump to subroutine relative indirect]
9a2e:      DC    'E'        ; hex:c5 dec:197(-59)
9a2f:      DB    X'05'      ; =0x05 =5
9a30:      BNZ   D9A3A      ; =+8 [Branch if not zero]
9a32:      JSR*  W9A13+1    ; =-32 [Jump to subroutine relative indirect]
9a34:      DC    'L'        ; hex:cc dec:204(-52)
9a35:      DB    X'06'      ; =0x06 =6
9a36:      BNZ   D9A3A      ; =+2 [Branch if not zero]
9a38:D9A38 JMP   D99F6      ; =-68 [Jump relative]
9a3a:D9A3A DCAB             ; [Decrement AL]
9a3b:      STAB+ X,7        ; [Store AL indexed, displaced, direct]
9a3e:      JMP   D99DC      ; =-100 [Jump relative]
9a40:W9A40 JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
9a43:      BZ    D9A38      ; =-13 [Branch if zero]
9a45:      JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
9a48:      LDA+  *Y         ; [Load A indexed, indirect]
9a4a:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
9a4d:      NAB              ; [A & B -> B]
9a4e:      BNZ   D9A38      ; =-24 [Branch if not zero]
9a50:      STA+  X,2        ; [Store A indexed, displaced, direct]
9a53:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9a55:      JMP   D99DC      ; =-123 [Jump relative]
9a57:W9A57 JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
9a5a:      BZ    D9A38      ; =-36 [Branch if zero]
9a5c:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9a5e:      STA+  X          ; [Store A to address in X]
9a5f:      JMP/  D99DC      ; =0x99dc =39388(-26148) [Jump direct]
*
9a62:S9A62 DC    'UFFER='   ; hex:d5c6c6c5d2bd
9a68:      DW    X'0100'    ; =0x0100 =256
9a6a:S9A6A DC    'LASS='    ; hex:ccc1d3d3bd
9a6f:      DW    X'0200'    ; =0x0200 =512
9a71:S9A71 DC    'ILTYP='   ; hex:c9ccd4d9d0bd
9a77:      DW    X'0300'    ; =0x0300 =768
9a79:S9A79 DC    'EY='      ; hex:c5d9bd
9a7c:      DW    X'0400'    ; =0x0400 =1024
9a7e:S9A7E DC    'ECSIZ='   ; hex:c5c3d3c9dabd
9a84:      DW    X'0500'    ; =0x0500 =1280
9a86:S9A86 DC    'CCESS='   ; hex:c3c3c5d3d3bd
9a8c:      DW    X'0600'    ; =0x0600 =1536
9a8e:S9A8E DC    'A'        ; hex:c1 dec:193(-63)
9a8f:      DW    S9A86      ; =0x9a86 =39558(-25978)
9a91:      DC    'B'        ; hex:c2 dec:194(-62)
9a92:      DW    S9A62      ; =0x9a62 =39522(-26014)
9a94:      DC    'C'        ; hex:c3 dec:195(-61)
9a95:      DW    S9A6A      ; =0x9a6a =39530(-26006)
9a97:      DC    'F'        ; hex:c6 dec:198(-58)
9a98:      DW    S9A71      ; =0x9a71 =39537(-25999)
9a9a:      DC    'K'        ; hex:cb dec:203(-53)
9a9b:      DW    S9A79      ; =0x9a79 =39545(-25991)
9a9d:      DC    'R'        ; hex:d2 dec:210(-46)
9a9e:      DW    S9A7E      ; =0x9a7e =39550(-25986)
9aa0:      DB    X'00'      ; =0x00 =0 =NUL
9aa1:W9AA1 DW    W9975      ; =0x9975 =39285(-26251)
9aa3:      DW    W99E7      ; =0x99e7 =39399(-26137)
9aa5:      DW    W9A07      ; =0x9a07 =39431(-26105)
9aa7:      DW    W9A13      ; =0x9a13 =39443(-26093)
9aa9:      DW    W9A40      ; =0x9a40 =39488(-26048)
9aab:      DW    W9A57      ; =0x9a57 =39511(-26025)
9aad:      DW    W99AC      ; =0x99ac =39340(-26196)
*
*
* Function F9AAF
*
9aaf:F9AAF JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
9ab2:      BNZ   D9AB8      ; =+4 [Branch if not zero]
9ab4:P9AB4 JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9ab7:      DB    X'14'      ; =0x14 =20
*
9ab8:D9AB8 LDA/  W87C2+1    ; =0x87c3 =34755(-30781) =BEL,'C' [Load A direct]
9abb:      LDB=  X'8000'    ; =0x8000 =32768(-32768) [Load B with immediate]
9abe:      ORI   A,B        ; [A | B -> B]
9ac0:      STB*  D9AB8+1    ; =-9 [Store B relative indirect]
9ac2:      JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
9ac5:      RSR              ; [Return from subroutine]
*
9ac6:W9AC6 JSR   F9AAF      ; =-25 [Jump to subroutine relative]
9ac8:      BZ    D9ACD      ; =+3 [Branch if zero]
9aca:      JSR*  P9AB4+1    ; =-23 [Jump to subroutine relative indirect]
9acc:      DB    X'08'      ; =0x08 =8
*
9acd:D9ACD JSR/  F8AAC      ; =0x8aac =35500(-30036) =LF,',' [Jump to subroutine direct]
9ad0:      DB    X'02'      ; =0x02 =2
9ad1:      CLA              ; [Clear A]
9ad2:P9AD2 JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9ad5:      LDB+  Y          ; [Load B from address in Y]
9ad6:      LDA/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load A direct]
9ad9:      STA+  B,2        ; [Store A indexed, displaced, direct]
9adc:      DCR   A,2        ; [Decrement A by 2]
9ade:      STA   W9B38+1    ; =+89 [Store A relative]
9ae0:      LDA+  B          ; [Load A from address in B]
9ae1:      LDBB= X'10'      ; =16 [Load BL with immediate]
9ae3:      SABB             ; [AL - BL -> BL]
9ae4:      BM    D9AE9      ; =+3 [Branch on minus]
9ae6:      JSR*  P9AB4+1    ; =-51 [Jump to subroutine relative indirect]
9ae8:      DB    X'15'      ; =0x15 =21
*
9ae9:D9AE9 CLRB  AU         ; [Clear AU]
9aeb:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9aed:      JSR*  P9AD2+1    ; =-28 [Jump to subroutine relative indirect]
9aef:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9af1:      SLR   A,2        ; [Left shift A by 2]
9af3:      LDB=  W8DAF      ; =0x8daf =36271(-29265) =CR,'/' [Load B with immediate]
9af6:      AAB              ; [A + B -> B]
9af7:      STB   P9B1A+1    ; =+34 [Store B relative]
9af9:      CLA              ; [Clear A]
9afa:      STA+  B,2        ; [Store A indexed, displaced, direct]
9afd:P9AFD JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9b00:      DC    'SAME'     ; hex:d3c1cdc5
9b04:      DB    X'01'      ; =0x01 =1
9b05:      BZ    D9B1E      ; =+23 [Branch if zero]
9b07:      JSR*  P9AFD+1    ; =-11 [Jump to subroutine relative indirect]
9b09:      DC    'AREA'     ; hex:c1d2c5c1
9b0d:      DB    X'01'      ; =0x01 =1
9b0e:      JSR   F9AAF      ; =-97 [Jump to subroutine relative]
9b10:      BNZ   D9B15      ; =+3 [Branch if not zero]
9b12:      JSR*  P9AB4+1    ; =-95 [Jump to subroutine relative indirect]
9b14:      DB    X'1B'      ; =0x1b =27
*
9b15:D9B15 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
9b17:      LDB+  B          ; [Load B from address in B]
9b18:      CLRB  BU         ; [Clear BU]
9b1a:P9B1A LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
9b1d:      STB+  A          ; [Store B to address in A]
9b1e:D9B1E LDAB= X'01'      ; =1 [Load AL with immediate]
9b20:P9B20 STAB/ D8E56+1    ; =0x8e57 =36439(-29097) [Store AL direct]
9b23:D9B23 JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9b26:J9B26 JSR*  P9AFD+1    ; =-42 [Jump to subroutine relative indirect]
9b28:      DC    'ENDREC'   ; hex:c5cec4d2c5c3
9b2e:      DB    X'01'      ; =0x01 =1
9b2f:      BZ    D9B58      ; =+39 [Branch if zero]
9b31:      CLAB             ; [Clear AL]
9b32:      STAB* P9B20+1    ; =-19 [Store AL relative indirect]
9b34:      DCAB             ; [Decrement AL]
9b35:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
9b38:W9B38 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
9b3b:      LDB/  W8700      ; =0x8700 =34560(-30976) =BEL,NUL [Load B direct]
9b3e:      JSR/  F8BAE      ; =0x8bae =35758(-29778) =VT,'.' [Jump to subroutine direct]
9b41:      LDA*  P9B1A+1    ; =-40 [Load A relative indirect]
9b43:      BM    D9B23      ; =-34 [Branch on minus]
9b45:      SLR   A,2        ; [Left shift A by 2]
9b47:      LDB=  W8DB1      ; =0x8db1 =36273(-29263) =CR,'1' [Load B with immediate]
9b4a:      AAB              ; [A + B -> B]
9b4b:      LDA+  B          ; [Load A from address in B]
9b4c:      LDB   P9B1A+1    ; =-51 [Load B relative]
9b4e:      LDB+  B,2        ; [Load B indexed, displaced, direct]
9b51:      SAB              ; [A - B -> B]
9b52:      BP    D9B23      ; =-49 [Branch on plus]
9b54:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9b57:      DB    X'18'      ; =0x18 =24
*
9b58:D9B58 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9b5b:      DC    '@'        ; hex:c0 dec:192(-64)
9b5c:      DB    X'01'      ; =0x01 =1
9b5d:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
9b5f:      BZ    D9B69      ; =+8 [Branch if zero]
9b61:      JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9b64:      DC    '?'        ; hex:bf dec:191(-65)
9b65:      DB    X'02'      ; =0x02 =2
9b66:      BZ    D9B69      ; =+1 [Branch if zero]
9b68:      STAB+ S          ; [Store AL to address in S]
9b69:D9B69 JSR/  F8766      ; =0x8766 =34662(-30874) [Jump to subroutine direct]
9b6c:      BNZ   D9B72      ; =+4 [Branch if not zero]
9b6e:      JSR/  F8BE3      ; =0x8be3 =35811(-29725) =VT,'c' [Jump to subroutine direct]
9b71:P9B71 DB    X'14'      ; =0x14 =20
*
9b72:D9B72 JSR/  F878B      ; =0x878b =34699(-30837) =BEL,VT [Jump to subroutine direct]
9b75:      LDA+  *Y         ; [Load A indexed, indirect]
9b77:      LDB=  X'4000'    ; =0x4000 =16384 [Load B with immediate]
9b7a:      NAB              ; [A & B -> B]
9b7b:      BZ    D9B80      ; =+3 [Branch if zero]
9b7d:D9B7D JSR*  P9B71      ; =-14 [Jump to subroutine relative indirect]
9b7f:      DB    X'17'      ; =0x17 =23
*
9b80:D9B80 LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
9b83:      NAB              ; [A & B -> B]
9b84:      BZ    D9BAE      ; =+40 [Branch if zero]
9b86:      JSR   F9BD5      ; =+77 [Jump to subroutine relative]
9b88:P9B88 JSR/  F892F      ; =0x892f =35119(-30417) [Jump to subroutine direct]
9b8b:      BZ    D9B7D      ; =-16 [Branch if zero]
9b8d:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9b8f:      LDBB+ S          ; [Load BL from address in S]
9b90:      BZ    D9B93      ; =+1 [Branch if zero]
9b92:      INA              ; [Increment A]
9b93:D9B93 XAB              ; [Transfer A to B]
9b94:      BLE   D9B7D      ; =-25 [Branch if less than or equal to zero]
9b96:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9b98:      JSR   F9C12      ; =+120 [Jump to subroutine relative]
9b9a:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9b9c:P9B9C JSR/  F8AC2      ; =0x8ac2 =35522(-30014) =LF,'B' [Jump to subroutine direct]
9b9f:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
9ba1:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
9ba4:D9BA4 JSR/  F8981      ; =0x8981 =35201(-30335) [Jump to subroutine direct]
9ba7:      DC    ','        ; hex:ac dec:172(-84)
9ba8:      DB    X'01'      ; =0x01 =1
9ba9:      BNZ   D9B58      ; =-83 [Branch if not zero]
9bab:      JMP/  J8E83      ; =0x8e83 =36483(-29053) [Jump direct]
9bae:D9BAE LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
9bb1:      NAB              ; [A & B -> B]
9bb2:      BNZ   D9BCA      ; =+22 [Branch if not zero]
9bb4:      JSR   F9BD5      ; =+31 [Jump to subroutine relative]
9bb6:      LDAB+ S          ; [Load AL from address in S]
9bb7:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
9bba:      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
9bbd:D9BBD LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
9bbf:      DCRB  BL         ; [Decrement BL by 1]
9bc1:      BNZ   D9BC6      ; =+3 [Branch if not zero]
9bc3:      LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
9bc6:D9BC6 JSR   F9C12      ; =+74 [Jump to subroutine relative]
9bc8:      JMP   D9BA4      ; =-38 [Jump relative]
9bca:D9BCA JSR   F9BD5      ; =+9 [Jump to subroutine relative]
9bcc:      LDAB+ S          ; [Load AL from address in S]
9bcd:      JSR/  F8ACC      ; =0x8acc =35532(-30004) =LF,'L' [Jump to subroutine direct]
9bd0:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
9bd3:      JMP   D9BBD      ; =-24 [Jump relative]
*
* Function F9BD5
*
9bd5:F9BD5 LDA+  Y          ; [Load A from address in Y]
9bd6:      LDB+  A,2        ; [Load B indexed, displaced, direct]
9bd9:      LDA+  A          ; [Load A from address in A]
9bda:      STA+  Y          ; [Store A to address in Y]
9bdb:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9bdd:      BM    D9C0B      ; =+44 [Branch on minus]
9bdf:      JSR*  D9BA4+1    ; =-60 [Jump to subroutine relative indirect]
9be1:      DC    '('        ; hex:a8 dec:168(-88)
9be2:      DB    X'01'      ; =0x01 =1
9be3:      BNZ   D9BE8      ; =+3 [Branch if not zero]
9be5:D9BE5 JSR*  P9B71      ; =-118 [Jump to subroutine relative indirect]
9be7:      DB    X'06'      ; =0x06 =6
*
9be8:D9BE8 JSR*  P9B88+1    ; =-97 [Jump to subroutine relative indirect]
9bea:D9BEA BZ    D9B7D      ; =-111 [Branch if zero]
9bec:      LDA+  S          ; [Load A from address in S]
9bed:      BZ    D9C03      ; =+20 [Branch if zero]
9bef:      MUL-  Y,0,A      ; [(Y+0) * A -> A]
9bf3:      STB+  Y          ; [Store B to address in Y]
9bf4:      JSR*  D9BA4+1    ; =-81 [Jump to subroutine relative indirect]
9bf6:      DC    ','        ; hex:ac dec:172(-84)
9bf7:      DB    X'01'      ; =0x01 =1
9bf8:      BZ    D9BE5      ; =-21 [Branch if zero]
9bfa:      JSR*  P9B88+1    ; =-115 [Jump to subroutine relative indirect]
9bfc:      BZ    D9BEA      ; =-20 [Branch if zero]
9bfe:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9c00:      LDB+  Y          ; [Load B from address in Y]
9c01:      AAB              ; [A + B -> B]
9c02:      STB+  Y          ; [Store B to address in Y]
9c03:D9C03 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9c05:      LDB+  Y          ; [Load B from address in Y]
9c06:      AAB              ; [A + B -> B]
9c07:      STB+  Y          ; [Store B to address in Y]
9c08:      JSR/  F89B4      ; =0x89b4 =35252(-30284) [Jump to subroutine direct]
9c0b:D9C0B LDA+  S+         ; [Load A indexed, direct, post-incremented]
9c0d:      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
9c0f:      JSR*  P9B9C+1    ; =-116 [Jump to subroutine relative indirect]
9c11:      RSR              ; [Return from subroutine]
*
* Function F9C12
*
9c12:F9C12 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9c14:      LDX/  P9B1A+1    ; =0x9b1b =39707(-25829) [Load X direct]
9c17:      LDB+  X,2        ; [Load B indexed, displaced, direct]
9c1a:      AAB              ; [A + B -> B]
9c1b:      STB+  X,2        ; [Store B indexed, displaced, direct]
9c1e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9c20:      RSR              ; [Return from subroutine]
*
* Function F9C21
*
9c21:F9C21 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9c23:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9c25:      XFR   Y,X        ; [Transfer Y to X]
9c27:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9c29:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
9c2b:      XAY              ; [Transfer A to Y]
9c2c:D9C2C DCX              ; [Decrement X]
9c2d:      BM    D9C42      ; =+19 [Branch on minus]
9c2f:      LDAB+ Y          ; [Load AL from address in Y]
9c30:      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
9c32:      SABB             ; [AL - BL -> BL]
9c33:      BGZ   D9C3E      ; =+9 [Branch if greater than zero]
9c35:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
9c37:      SABB             ; [AL - BL -> BL]
9c38:      BM    D9C3E      ; =+4 [Branch on minus]
9c3a:      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
9c3c:      ADDB  BL,AL      ; [BL + AL -> AL]
9c3e:D9C3E STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
9c40:      JMP   D9C2C      ; =-22 [Jump relative]
9c42:D9C42 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9c44:      XAY              ; [Transfer A to Y]
9c45:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9c47:      RSR              ; [Return from subroutine]
*
* Function F9C48
*
9c48:F9C48 JSR   F9C5D      ; =+19 [Jump to subroutine relative]
9c4a:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
9c4c:      JSR   F9C71      ; =+35 [Jump to subroutine relative]
9c4e:      DB    X'02'      ; =0x02 =2
9c4f:      RSR              ; [Return from subroutine]
*
9c50:      LDAB= X'AF'      ; =175(-81) ='/' [Load AL with immediate]
9c52:      BP    D9C56      ; =+2 [Branch on plus]
9c54:      JSR   F9C64      ; =+14 [Jump to subroutine relative]
9c56:D9C56 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9c58:      JSR   F9C71      ; =+23 [Jump to subroutine relative]
9c5a:      DB    X'01'      ; =0x01 =1
9c5b:      JMP   D9CA6      ; =+73 [Jump relative]
*
* Function F9C5D
*
9c5d:F9C5D LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
9c5f:      LDBB  W9C8B+1    ; =+43 [Load BL relative]
9c61:      SABB             ; [AL - BL -> BL]
9c62:      BZ    D9C6C      ; =+8 [Branch if zero]
*
* Function F9C64
*
9c64:F9C64 STAB  B9C6F      ; =+9 [Store AL relative]
9c66:      LDA=  W9C6D      ; =0x9c6d =40045(-25491) [Load A with immediate]
9c69:      JSR   F9C71      ; =+6 [Jump to subroutine relative]
9c6b:      DB    X'02'      ; =0x02 =2
*
9c6c:D9C6C RSR              ; [Return from subroutine]
*
9c6d:W9C6D DW    X'0001'    ; =0x0001 =1
9c6f:B9C6F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F9C71
*
9c71:F9C71 STA   S9C94      ; =+33 [Store A relative]
9c73:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
9c75:      STAB  B9C91      ; =+26 [Store AL relative]
9c77:W9C77 LDB=  W9C8E      ; =0x9c8e =40078(-25458) [Load B with immediate]
9c7a:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
9c7c:D9C7C SVC   X'07'      ; =7 [Service call WT - unconditional wait]
9c7e:      LDAB  W9C8E      ; =+14 [Load AL relative]
9c80:      BM    D9C7C      ; =-6 [Branch on minus]
9c82:      LDB   W9C77+1    ; =-12 [Load B relative]
9c84:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
9c86:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
9c87:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
9c88:      DB    X'12'      ; =0x12 =18 [TODO: arg3]
9c89:      DW    W9C8B+1    ; =0x9c8c =40076(-25460) [address to store block value]
9c8b:W9C8B LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9c8d:      RSR              ; [Return from subroutine]
*
9c8e:W9C8E DW    X'0081'    ; =0x0081 =129
9c90:      DB    X'00'      ; =0x00 =0 =NUL
9c91:B9C91 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9c93:      DB    X'84'      ; =0x84 =132(-124) =EOT
9c94:S9C94 DB    0,4        ; =0x00,0x0004
9c98:      DB    X'90'      ; =0x90 =144(-112)
9c99:      DW    W9C6D      ; =0x9c6d =40045(-25491)
9c9b:      DC    'Xst'      ; hex:d8f3f4
9c9e:      DB    X'7B'      ; =0x7b =123
9c9f:      DC    'Q'        ; hex:d1 dec:209(-47)
9ca0:      DW    X'0190'    ; =0x0190 =400
9ca2:      DB    X'00'      ; =0x00 =0 =NUL
9ca3:      DB    X'84'      ; =0x84 =132(-124) =EOT
9ca4:      DC    '3l'       ; hex:b3ec dec:46060(-20)
*
9ca6:D9CA6 LDAB  W9C8B+1    ; =-28 [Load AL relative]
9ca8:      LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
9caa:      BZ    D9CB5      ; =+9 [Branch if zero]
9cac:      SABB             ; [AL - BL -> BL]
9cad:      BNZ   D9CB5      ; =+6 [Branch if not zero]
9caf:      LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
9cb2:      BZ    D9CB5      ; =+1 [Branch if zero]
9cb4:      XAX              ; [Transfer A to X]
9cb5:D9CB5 LDAB  B9C6F      ; =-72 [Load AL relative]
9cb7:      RSR              ; [Return from subroutine]
*
9cb8:W9CB8 DB    X'0B'      ; =0x0b =11
9cb9:      DW    W9D4D      ; =0x9d4d =40269(-25267)
9cbb:      DW    W9D9F      ; =0x9d9f =40351(-25185)
9cbd:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9cbf:      DW    W9CCF      ; =0x9ccf =40143(-25393)
9cc1:      DB    0,12       ; =0x00,0x000c
9ccd:      DW    W9E22      ; =0x9e22 =40482(-25054)
*
9ccf:W9CCF STX-  S-         ; [Store X indexed, pre-decremented, direct]
9cd1:      JSR   F9CFE      ; =+43 [Jump to subroutine relative]
9cd3:      DB    X'02'      ; =0x02 =2
9cd4:      BZ    D9CFC      ; =+38 [Branch if zero]
9cd6:      CLA              ; [Clear A]
9cd7:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9cda:      STA+  Z,22       ; [Store A indexed, displaced, direct]
9cdd:      STB+  Z,20       ; [Store B indexed, displaced, direct]
9ce0:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9ce3:      JSR   F9CFE      ; =+25 [Jump to subroutine relative]
9ce5:      DB    X'05'      ; =0x05 =5
9ce6:      LDBB= X'0F'      ; =15 [Load BL with immediate]
9ce8:      ANDB  BU,BL      ; [BU & BL -> BL]
9cea:      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
9ced:      BM    D9CF5      ; =+6 [Branch on minus]
9cef:      SABB             ; [AL - BL -> BL]
9cf0:      BZ    D9CF5      ; =+3 [Branch if zero]
9cf2:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
9cf4:      DB    X'12'      ; =0x12 =18 [abort code]
*
9cf5:D9CF5 LDA+  Z,6        ; [Load A indexed, displaced, direct]
9cf8:      BZ    D9CFC      ; =+2 [Branch if zero]
9cfa:      JSR   F9D15      ; =+25 [Jump to subroutine relative]
9cfc:D9CFC JMP   D9D73      ; =+117 [Jump relative]
*
* Function F9CFE
*
9cfe:F9CFE LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
9d00:      STAB  B9D08      ; =+6 [Store AL relative]
9d02:      XFR   Z,B        ; [Transfer Z to B]
9d04:      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
9d06:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
9d07:      DB    X'02'      ; =0x02 =2 [TODO: arg2]
9d08:B9D08 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
9d09:      DW    L9D0F+1    ; =0x9d10 =40208(-25328) [TODO: address]
9d0b:      XFR   B,B        ; [Transfer B to B]
9d0d:      BZ    D9D14      ; =+5 [Branch if zero]
9d0f:L9D0F LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
9d12:      XFR   A,A        ; [Transfer A to A]
9d14:D9D14 RSR              ; [Return from subroutine]
*
* Function F9D15
*
9d15:F9D15 JSR   F9CFE      ; =-25 [Jump to subroutine relative]
9d17:      DB    X'02'      ; =0x02 =2
9d18:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
9d1b:      SUB   B,A        ; [B - A -> A]
9d1d:      BL    D9D23      ; =+4 [Branch on link]
9d1f:      LDAB= X'01'      ; =1 [Load AL with immediate]
9d21:      JMP   D9D37      ; =+20 [Jump relative]
9d23:D9D23 LDA+  Z,22       ; [Load A indexed, displaced, direct]
9d26:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9d29:      STA+  Z,8        ; [Store A indexed, displaced, direct]
9d2c:      JSR   F9D41      ; =+19 [Jump to subroutine relative]
9d2e:      DB    X'01'      ; =0x01 =1
9d2f:      LDB+  Z,18       ; [Load B indexed, displaced, direct]
9d32:      INR   B          ; [Increment B by 1]
9d34:      STB+  Z,22       ; [Store B indexed, displaced, direct]
9d37:D9D37 STAB+ Z          ; [Store AL to address in Z]
9d38:      RSR              ; [Return from subroutine]
*
* Function F9D39
*
9d39:F9D39 LDAB+ Z          ; [Load AL from address in Z]
9d3a:      BP    D9D40      ; =+4 [Branch on plus]
9d3c:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
9d3e:      JMP   F9D39      ; =-7 [Jump relative]
9d40:D9D40 RSR              ; [Return from subroutine]
*
* Function F9D41
*
9d41:F9D41 XFR   Z,B        ; [Transfer Z to B]
9d43:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
9d45:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
9d48:      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
9d4a:      JSR   F9D39      ; =-19 [Jump to subroutine relative]
9d4c:      RSR              ; [Return from subroutine]
*
9d4d:W9D4D STX-  S-         ; [Store X indexed, pre-decremented, direct]
9d4f:D9D4F LDA+  Z,6        ; [Load A indexed, displaced, direct]
9d52:      INR   A,2        ; [Increment A by 2]
9d54:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
9d57:      STB+  Z,20       ; [Store B indexed, displaced, direct]
9d5a:      ADD   B,A        ; [B + A -> A]
9d5c:      XAY              ; [Transfer A to Y]
9d5d:      LDA+  Y          ; [Load A from address in Y]
9d5e:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
9d60:      LDAB= X'01'      ; =1 [Load AL with immediate]
9d62:      SUBB  AU,BL      ; [AU - BL -> BL]
9d64:      BZ    D9D72      ; =+12 [Branch if zero]
9d66:      DCRB  AU         ; [Decrement AU by 1]
9d68:      BNF   D9D77      ; =+13 [Branch on no fault]
9d6a:      JSR   F9D15      ; =-87 [Jump to subroutine relative]
9d6c:      CLA              ; [Clear A]
9d6d:      STA+  Z,24       ; [Store A indexed, displaced, direct]
9d70:      JMP   D9D4F      ; =-35 [Jump relative]
9d72:D9D72 STAB+ Z          ; [Store AL to address in Z]
9d73:D9D73 LDB+  S+         ; [Load B indexed, direct, post-incremented]
9d75:      SVC   X'68'      ; =104 [Service call RLSR - return from LSR]
9d77:D9D77 LDA+  Y          ; [Load A from address in Y]
9d78:      CLRB  AU         ; [Clear AU]
9d7a:      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
9d7d:      ADD   B,A        ; [B + A -> A]
9d7f:      LDB+  Z,24       ; [Load B indexed, displaced, direct]
9d82:      AAB              ; [A + B -> B]
9d83:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9d86:      LDB+  Z,16       ; [Load B indexed, displaced, direct]
9d89:      XAX              ; [Transfer A to X]
9d8a:      CLA              ; [Clear A]
9d8b:D9D8B DCX              ; [Decrement X]
9d8c:      BLE   D9D96      ; =+8 [Branch if less than or equal to zero]
9d8e:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
9d90:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
9d92:      ADDB  AL,AU      ; [AL + AU -> AU]
9d94:      JMP   D9D8B      ; =-11 [Jump relative]
9d96:D9D96 LDAB+ Y          ; [Load AL from address in Y]
9d97:      ADDB  AU,AL      ; [AU + AL -> AL]
9d99:      BZ    D9D72      ; =-41 [Branch if zero]
9d9b:      LDAB= X'04'      ; =4 [Load AL with immediate]
9d9d:      JMP   D9D72      ; =-45 [Jump relative]
9d9f:W9D9F STX-  S-         ; [Store X indexed, pre-decremented, direct]
9da1:D9DA1 LDA+  Z,6        ; [Load A indexed, displaced, direct]
9da4:      INR   A,2        ; [Increment A by 2]
9da6:      XAY              ; [Transfer A to Y]
9da7:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
9daa:      STA+  Z,20       ; [Store A indexed, displaced, direct]
9dad:      ADD   A,Y        ; [A + Y -> Y]
9daf:      LDX+  Z,16       ; [Load X indexed, displaced, direct]
9db2:      LDB+  X          ; [Load B from address in X]
9db3:      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
9db5:      SUBB  BL,BU      ; [BL - BU -> BU]
9db7:      BNZ   D9DBC      ; =+3 [Branch if not zero]
9db9:      STBB+ Y          ; [Store BL to address in Y]
9dba:      JMP   D9DED      ; =+49 [Jump relative]
9dbc:D9DBC LDB+  X          ; [Load B from address in X]
9dbd:      CLRB  BU         ; [Clear BU]
9dbf:      AAB              ; [A + B -> B]
9dc0:      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
9dc3:      AAB              ; [A + B -> B]
9dc4:      STB+  Z,24       ; [Store B indexed, displaced, direct]
9dc7:      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
9dca:      SAB              ; [A - B -> B]
9dcb:      BP    D9DD3      ; =+6 [Branch on plus]
9dcd:      JSR   F9DFF      ; =+48 [Jump to subroutine relative]
9dcf:      BZ    D9DA1      ; =-48 [Branch if zero]
9dd1:      JMP   D9D72      ; =-97 [Jump relative]
9dd3:D9DD3 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9dd5:      XAB              ; [Transfer A to B]
9dd6:      CLRB  AU         ; [Clear AU]
9dd8:      STB+  Y+         ; [Store B indexed, direct, post-incremented]
9dda:      ADDB  BL,BU      ; [BL + BU -> BU]
9ddc:      INA              ; [Increment A]
9ddd:D9DDD LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
9ddf:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
9de1:      ADDB  BL,BU      ; [BL + BU -> BU]
9de3:      DCA              ; [Decrement A]
9de4:      BP    D9DDD      ; =-9 [Branch on plus]
9de6:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
9de8:      IVRB  BU         ; [Invert BU]
9dea:      INRB  BU         ; [Increment BU by 1]
9dec:      STB+  Y          ; [Store B to address in Y]
9ded:D9DED CLAB             ; [Clear AL]
9dee:D9DEE JMP   D9D72      ; =-126 [Jump relative]
*
* Function F9DF0
*
9df0:F9DF0 CLA              ; [Clear A]
9df1:      STA+  Z,24       ; [Store A indexed, displaced, direct]
9df4:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
9df7:      STA+  Z,8        ; [Store A indexed, displaced, direct]
9dfa:      JSR/  F9D41      ; =0x9d41 =40257(-25279) [Jump to subroutine direct]
9dfd:      DB    X'02'      ; =0x02 =2
9dfe:      RSR              ; [Return from subroutine]
*
* Function F9DFF
*
9dff:F9DFF JSR   F9DF0      ; =-17 [Jump to subroutine relative]
9e01:      BNZ   D9E1E      ; =+27 [Branch if not zero]
9e03:      JSR/  F9CFE      ; =0x9cfe =40190(-25346) [Jump to subroutine direct]
9e06:      DB    X'02'      ; =0x02 =2
9e07:      LDA+  Z,22       ; [Load A indexed, displaced, direct]
9e0a:      STA+  Z,18       ; [Store A indexed, displaced, direct]
9e0d:      INA              ; [Increment A]
9e0e:      STA+  Z,22       ; [Store A indexed, displaced, direct]
9e11:      DCA              ; [Decrement A]
9e12:      SUB   B,A        ; [B - A -> A]
9e14:      BL    D9E1D      ; =+7 [Branch on link]
9e16:      XFR   Z,B        ; [Transfer Z to B]
9e18:      SVC   X'19'      ; =25 [Service call EXP - file expand]
9e1a:      XAB              ; [Transfer A to B]
9e1b:      BNZ   D9E1F      ; =+2 [Branch if not zero]
9e1d:D9E1D CLA              ; [Clear A]
9e1e:D9E1E RSR              ; [Return from subroutine]
*
9e1f:D9E1F LDAB= X'02'      ; =2 [Load AL with immediate]
9e21:      RSR              ; [Return from subroutine]
*
9e22:W9E22 STX-  S-         ; [Store X indexed, pre-decremented, direct]
9e24:      JSR   F9DF0      ; =-54 [Jump to subroutine relative]
9e26:      JMP   D9DEE      ; =-58 [Jump relative]
*
* Function F9E28
*
9e28:F9E28 LDA+  X+         ; [Load A indexed, direct, post-incremented]
9e2a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9e2c:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9e2e:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
9e30:      BLE   D9E40      ; =+14 [Branch if less than or equal to zero]
9e32:      ADD   X,A        ; [X + A -> A]
9e34:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
9e37:D9E37 LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
9e39:      SUBB  BU,BL      ; [BU - BL -> BL]
9e3b:      BNZ   D9E40      ; =+3 [Branch if not zero]
9e3d:      DCX              ; [Decrement X]
9e3e:      BGZ   D9E37      ; =-9 [Branch if greater than zero]
9e40:D9E40 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9e42:      STX+  A          ; [Store X indexed, direct]
9e44:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9e46:      RSR              ; [Return from subroutine]
*
9e47:ENDPT
