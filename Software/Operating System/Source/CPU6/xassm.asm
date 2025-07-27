* Label naming:
* ENTRY = Entry point
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
      TITLE 'ASSM'
ZASSM BEGIN 0
      DB    0,200      ; =0x00,0x00C8
W80C8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W80CA DW    X'0001'    ; =0x0001 =1
      DW    X'0109'    ; =0x0109 =265
      DW    X'0190'    ; =0x0190 =400
      DW    W839B      ; =0x839B =33691(-31845)
      DB    0,3        ; =0x00,0x0003
      DW    X'0102'    ; =0x0102 =258
      DW    X'0200'    ; =0x0200 =512
      DB    X'84'      ; =0x84 =132(-124) =EOT
      DW    W8314      ; =0x8314 =33556(-31980)
      DB    0,11       ; =0x00,0x000B
      DB    X'84'      ; =0x84 =132(-124) =EOT
W80E8 DW    X'0002'    ; =0x0002 =2
      DW    X'0209'    ; =0x0209 =521
      DW    X'0190'    ; =0x0190 =400
      DW    ENTRY      ; =0x852E =34094(-31442)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    WA16B      ; =0xA16B =41323(-24213)
      DW    X'0204'    ; =0x0204 =516
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'84'      ; =0x84 =132(-124) =EOT
S80F8 DB    0,13       ; =0x00,0x000D
      DB    X'84'      ; =0x84 =132(-124) =EOT
W8106 DW    X'0003'    ; =0x0003 =3
      DW    X'0209'    ; =0x0209 =521
      DW    X'0190'    ; =0x0190 =400
S810C DB    0,4        ; =0x00,0x0004
W8110 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    X'0102'    ; =0x0102 =258
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'84'      ; =0x84 =132(-124) =EOT
S8116 DB    0,13       ; =0x00,0x000D
      DB    X'84'      ; =0x84 =132(-124) =EOT
W8124 DW    X'0004'    ; =0x0004 =4
B8126 DW    X'0209'    ; =0x0209 =521
      DW    X'0190'    ; =0x0190 =400
S812A DB    0,5        ; =0x00,0x0005
      DW    X'0402'    ; =0x0402 =1026
      DW    X'0100'    ; =0x0100 =256
      DB    X'04'      ; =0x04 =4
      DW    W86C1      ; =0x86C1 =34497(-31039)
      DB    0,11       ; =0x00,0x000B
      DB    X'04'      ; =0x04 =4
*
* Function F8142
*
F8142 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      LDB+  X          ; [Load B from address in X]
      STAB+ B,3        ; [Store AL indexed, displaced, direct]
      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      LDAB+ B          ; [Load AL from address in B]
      RSR              ; [Return from subroutine]
*
* Function F814E
*
F814E JSR   F8142      ; =-14 [Jump to subroutine relative]
      DB    X'01'      ; =0x01 =1
      DW    W80CA      ; =0x80CA =32970(-32566)
      BNZ   D815E      ; =+9 [Branch if not zero]
      JSR/  FA144      ; =0xA144 =41284(-24252) [Jump to subroutine direct]
      DW    W8314      ; =0x8314 =33556(-31980)
      LDA=  W8316      ; =0x8316 =33558(-31978) [Load A with immediate]
      RSR              ; [Return from subroutine]
*
D815E JSR   F8142      ; =-30 [Jump to subroutine relative]
      DB    X'04'      ; =0x04 =4
      DW    W80CA      ; =0x80CA =32970(-32566)
      CLA              ; [Clear A]
D8164 RSR              ; [Return from subroutine]
*
J8165 LDA   S812A      ; =-61 [Load A relative]
      BNZ   D816E      ; =+5 [Branch if not zero]
      LDB=  X'C0B0'    ; =0xC0B0 =49328(-16208) ='@','0' [Load B with immediate]
      JMP   D8193      ; =+37 [Jump relative]
D816E LDA=  X'FFFF'    ; =0xFFFF =65535(-1) [Load A with immediate]
      STA/  W86C3      ; =0x86C3 =34499(-31037) [Store A direct]
      STA/  W86C5      ; =0x86C5 =34501(-31035) [Store A direct]
      JSR   F81CD      ; =+84 [Jump to subroutine relative]
      LDAB= X'84'      ; =132(-124) =EOT [Load AL with immediate]
      STAB/ W86C3      ; =0x86C3 =34499(-31037) [Store AL direct]
      CLR   A,1        ; [Set A to 1]
      JSR   F81CF      ; =+77 [Jump to subroutine relative]
      JSR   F8142      ; =-66 [Jump to subroutine relative]
      DB    X'0B'      ; =0x0B =11
      DW    W8124      ; =0x8124 =33060(-32476)
      LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB  B8126      ; =-101 [Store AL relative]
      JSR   F8142      ; =-75 [Jump to subroutine relative]
      DB    X'09'      ; =0x09 =9
      DW    W8124      ; =0x8124 =33060(-32476)
      LDB=  X'C0B1'    ; =0xC0B1 =49329(-16207) ='@','1' [Load B with immediate]
D8193 STB   S81BC      ; =+39 [Store B relative]
      SVC   X'05'      ; =5 [Service call TS - load transient module]
      DB    X'09'      ; =0x09 =9 [Selector: load private library?]
      DW    S81B8      ; =0x81B8 =33208(-32328) [address of TODO]
      DW    J8843      ; =0x8843 =34883(-30653) [jump address TODO]
      DW    X'0001'    ; =0x0001 =1 [TODO: arg 3]
      DB    X'0B'      ; =0x0B =11 [word argument count]
      DW    F822D      ; =0x822D =33325(-32211) [Function argument]
      DW    F81F6      ; =0x81F6 =33270(-32266) [Function argument]
      DW    F87C8      ; =0x87C8 =34760(-30776) =BEL,'H' [Function argument]
      DW    W80CA      ; =0x80CA =32970(-32566) [Address argument]
      DW    W80E8      ; =0x80E8 =33000(-32536) [Address argument]
      DW    W8106      ; =0x8106 =33030(-32506) [Address argument]
      DW    W826D      ; =0x826D =33389(-32147) [Address argument]
      DW    F81E0      ; =0x81E0 =33248(-32288) [Function argument]
      DW    W8124      ; =0x8124 =33060(-32476) [Address argument]
      DW    W86C3      ; =0x86C3 =34499(-31037) [Address argument]
      DW    F81ED      ; =0x81ED =33261(-32275) [Function argument]
      SVC   X'09'      ; =9 [Service call ABRT - abort task]
      DB    X'03'      ; =0x03 =3 [abort code]
*
S81B8 DC    '    '     ; hex:A0A0A0A0
S81BC DC    '  '       ; hex:A0A0 dec:41120(-96)
      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F81BF
*
F81BF STA/  S80F8      ; =0x80F8 =33016(-32520) [Store A direct]
      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
      DB    X'02'      ; =0x02 =2
      DW    W80E8      ; =0x80E8 =33000(-32536)
      BZ    D8164      ; =-102 [Branch if zero]
D81CA SVC   X'09'      ; =9 [Service call ABRT - abort task]
      DB    X'34'      ; =0x34 =52 [abort code]
*
* Function F81CD
*
F81CD CLR   A,4        ; [Set A to 4]
*
* Function F81CF
*
F81CF LDB/  S812A      ; =0x812A =33066(-32470) [Load B direct]
      BZ    D81DF      ; =+11 [Branch if zero]
      STA/  W86C1      ; =0x86C1 =34497(-31039) [Store A direct]
      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
      DB    X'02'      ; =0x02 =2
      DW    W8124      ; =0x8124 =33060(-32476)
      BNZ   D81CA      ; =-21 [Branch if not zero]
D81DF RSR              ; [Return from subroutine]
*
* Function F81E0
*
F81E0 JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
      DB    X'01'      ; =0x01 =1
      DW    W8124      ; =0x8124 =33060(-32476)
      BZ    D81EC      ; =+4 [Branch if zero]
      JSR   F81ED      ; =+3 [Jump to subroutine relative]
      LDAB= X'01'      ; =1 [Load AL with immediate]
D81EC RSR              ; [Return from subroutine]
*
* Function F81ED
*
F81ED JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
      DB    X'04'      ; =0x04 =4
      DW    W8124      ; =0x8124 =33060(-32476)
      RSR              ; [Return from subroutine]
*
D81F4 JSR   F822D      ; =+55 [Jump to subroutine relative]
*
* Function F81F6
*
F81F6 LDA   W826B      ; =+115 [Load A relative]
      DCA              ; [Decrement A]
      STA   W826B      ; =+112 [Store A relative]
      BLE   D81F4      ; =-9 [Branch if less than or equal to zero]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
*
* Function F81FF
*
F81FF STA   W8204      ; =+3 [Store A relative]
      JSR/  FA357      ; =0xA357 =41815(-23721) [Jump to subroutine direct]
W8204 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      LDB   W8204      ; =-4 [Load B relative]
D8208 STB/  S8116      ; =0x8116 =33046(-32490) [Store B direct]
      LDA+  B          ; [Load A from address in B]
      BLE   D8227      ; =+25 [Branch if less than or equal to zero]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      STB-  S-         ; [Store B indexed, pre-decremented, direct]
      INA              ; [Increment A]
      STA+  B+         ; [Store A indexed, direct, post-incremented]
      AAB              ; [A + B -> B]
      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
      JSR/  F8142      ; =0x8142 =33090(-32446) [Jump to subroutine direct]
      DB    X'02'      ; =0x02 =2
      DW    W8106      ; =0x8106 =33030(-32506)
      BNZ   D81CA      ; =-88 [Branch if not zero]
      LDB+  S+         ; [Load B indexed, direct, post-incremented]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      STA+  B          ; [Store A to address in B]
D8227 RSR              ; [Return from subroutine]
*
* Function F8228
*
F8228 LDB=  W8263      ; =0x8263 =33379(-32157) [Load B with immediate]
      JMP   D8208      ; =-37 [Jump relative]
*
* Function F822D
*
F822D LDA=  W8267      ; =0x8267 =33383(-32153) [Load A with immediate]
      JSR   F81FF      ; =-51 [Jump to subroutine relative]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
D8237 JSR   F8228      ; =-17 [Jump to subroutine relative]
      DCX              ; [Decrement X]
      BGZ   D8237      ; =-5 [Branch if greater than zero]
      LDA=  X'A0A0'    ; =0xA0A0 =41120(-24416) =' ',' ' [Load A with immediate]
      STA   S8289      ; =+72 [Store A relative]
      STA   S8296      ; =+83 [Store A relative]
      LDA   W826F      ; =+42 [Load A relative]
      INA              ; [Increment A]
      STA   W826F      ; =+39 [Store A relative]
      JSR   F8273      ; =+41 [Jump to subroutine relative]
      DW    S828B      ; =0x828B =33419(-32117)
      LDA   W826D      ; =+31 [Load A relative]
      JSR   F8273      ; =+35 [Jump to subroutine relative]
      DW    S8298      ; =0x8298 =33432(-32104)
      LDA=  W8282      ; =0x8282 =33410(-32126) [Load A with immediate]
      JSR   F81FF      ; =-88 [Jump to subroutine relative]
      JSR   F8228      ; =-49 [Jump to subroutine relative]
      JSR   F8228      ; =-51 [Jump to subroutine relative]
      LDA=  X'0034'    ; =0x0034 =52 [Load A with immediate]
      STA   W826B      ; =+11 [Store A relative]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W8263 DW    X'0001'    ; =0x0001 =1
      DC    ' '        ; hex:A0 dec:160(-96)
      DB    X'00'      ; =0x00 =0 =NUL
W8267 DW    X'0001'    ; =0x0001 =1
      DW    X'8C00'    ; =0x8C00 =35840(-29696) =FF,NUL
W826B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W826D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W826F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    X'9541'    ; =0x9541 =38209(-27327)
*
* Function F8273
*
F8273 LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STB   W8279      ; =+2 [Store B relative]
      SVC   X'2E'      ; =46 [Service call CVR16 - 16-bit convert to decimal from A register]
W8279 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of end of string]
      RSR              ; [Return from subroutine]
*
* Function F827C
*
F827C SVC   X'2B'      ; =43 [Service call MUL16 - 16-bit multiply]
      RSR              ; [Return from subroutine]
*
      SVC   X'2C'      ; =44 [Service call DIV16 - 16-bit divide]
      RSR              ; [Return from subroutine]
*
W8282 DW    X'0084'    ; =0x0084 =132 =NUL,EOT
S8284 DC    'PAGE '    ; hex:D0C1C7C5A0
S8289 DC    '  '       ; hex:A0A0 dec:41120(-96)
S828B DC    '    ERRORS '
S8296 DC    '  '       ; hex:A0A0 dec:41120(-96)
S8298 DC    '    '     ; hex:A0A0A0A0
S829C DC    '                     '
S82B1 DC    '           '
S82BC DC    '                                                            '
      DC    '                           '
      DB    X'00'      ; =0x00 =0 =NUL
W8314 DS    2          ; =0x0002 [Uninitialized memory]
W8316 DS    133        ; =0x0085 [Uninitialized memory]
W839B DS    403        ; =0x0193 [Uninitialized memory]
*
* Function ENTRY
*
ENTRY JMP/  JA376      ; =0xA376 =41846(-23690) [Jump direct]
      DW    W86C8      ; =0x86C8 =34504(-31032)
      DS    398        ; =0x018E [Uninitialized memory]
W86C1 DS    2          ; =0x0002 [Uninitialized memory]
W86C3 DS    2          ; =0x0002 [Uninitialized memory]
W86C5 DS    3          ; =0x0003 [Uninitialized memory]
W86C8 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STA   W86ED      ; =+33 [Store A relative]
      LDB=  X'003C'    ; =0x003C =60 [Load B with immediate]
      AAB              ; [A + B -> B]
      STB   W86EB      ; =+25 [Store B relative]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STB   W86E9      ; =+19 [Store B relative]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STB   W86EF      ; =+21 [Store B relative]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX=  X'001E'    ; =0x001E =30 [Load X with immediate]
      CLR   B          ; [Clear B]
D86E1 STB+  A+         ; [Store B indexed, direct, post-incremented]
      DCX              ; [Decrement X]
      BNZ   D86E1      ; =-5 [Branch if not zero]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W86E9 DS    2          ; =0x0002 [Uninitialized memory]
W86EB DS    2          ; =0x0002 [Uninitialized memory]
W86ED DS    2          ; =0x0002 [Uninitialized memory]
W86EF DS    2          ; =0x0002 [Uninitialized memory]
*
* Function F86F1
*
F86F1 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      LDB   W86EB      ; =-10 [Load B relative]
      STB+  X+         ; [Store B indexed, direct, post-incremented]
      AAB              ; [A + B -> B]
      LDA   W86E9      ; =-17 [Load A relative]
      SUB   B,A        ; [B - A -> A]
      BL    D8701      ; =+3 [Branch on link]
      STB   W86EB      ; =-21 [Store B relative]
      RSR              ; [Return from subroutine]
*
D8701 SVC   X'59'      ; =89 [Service call ASEG - add next free mem segment to CURTB [wait for comp]]
      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
      LDB   W86E9      ; =-30 [Load B relative]
      CLR   A,8        ; [Set A to 8]
D8709 FIL   (256)=X'00',-B ; [Fill with byte, literal=0, indexed]
      ADD=  X'0100',B  ; =0x0100 =256 [256 - B -> B]
      DCA              ; [Decrement A]
      BGZ   D8709      ; =-12 [Branch if greater than zero]
      STB   W86E9      ; =-46 [Store B relative]
      DCR   X,4        ; [Decrement X by 4]
      JMP   F86F1      ; =-42 [Jump relative]
*
* Function F871B
*
F871B LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BM    D8726      ; =+6 [Branch on minus]
      LDAB= X'1D'      ; =29 [Load AL with immediate]
      SUBB  BL,AL      ; [BL - AL -> AL]
      BLE   D8728      ; =+2 [Branch if less than or equal to zero]
D8726 LDBB= X'1D'      ; =29 [Load BL with immediate]
D8728 CLRB  BU         ; [Clear BU]
      SLR   B          ; [Left shift B by 1]
      LDA   W86ED      ; =-65 [Load A relative]
      AAB              ; [A + B -> B]
      RSR              ; [Return from subroutine]
*
W8730 LDAB+ *X         ; [Load AL indexed, indirect]
      JSR   F871B      ; =-25 [Jump to subroutine relative]
      LDA+  X,2        ; [Load A indexed, displaced, direct]
      STA   W8766+1    ; =+46 [Store A relative]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   B,X        ; [Transfer B to X]
      LDB   W86EF      ; =-80 [Load B relative]
      INA              ; [Increment A]
      INA              ; [Increment A]
      INA              ; [Increment A]
      AAB              ; [A + B -> B]
      STB   W8747      ; =+2 [Store B relative]
      JSR   F86F1      ; =-86 [Jump to subroutine relative]
W8747 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W8749 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      LDA   W8749      ; =-4 [Load A relative]
      BZ    D877D      ; =+46 [Branch if zero]
      LDB+  X          ; [Load B from address in X]
      STA+  X          ; [Store A to address in X]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      LDB   W86EF      ; =-102 [Load B relative]
      INA              ; [Increment A]
      AAB              ; [A + B -> B]
      STB   W8763+1    ; =+11 [Store B relative]
      LDA   W8766+1    ; =+12 [Load A relative]
      STA-  B-         ; [Store A indexed, pre-decremented, direct]
      LDX+  S          ; [Load X indexed, direct]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STX+  S          ; [Store X indexed, direct]
W8763 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
W8766 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
      DCA              ; [Decrement A]
      MVFR  -B,-X      ; [Move fixed-length (len in AL), indexed, indexed]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      LDA   W8763+1    ; =-13 [Load A relative]
      DCA              ; [Decrement A]
      DCA              ; [Decrement A]
      DCA              ; [Decrement A]
      LDB/  W86EF      ; =0x86EF =34543(-30993) [Load B direct]
      SAB              ; [A - B -> B]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STB+  X+         ; [Store B indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
D877D LDX+  S+         ; [Load X indexed, direct, post-incremented]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STA+  X+         ; [Store A indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W8786 LDAB+ *X         ; [Load AL indexed, indirect]
      JSR   F871B      ; =-111 [Jump to subroutine relative]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STA   W87B1      ; =+35 [Store A relative]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STA   W87AF      ; =+29 [Store A relative]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   B,X        ; [Transfer B to X]
D8796 LDA+  X          ; [Load A from address in X]
      BZ    D87C3      ; =+42 [Branch if zero]
      XAX              ; [Transfer A to X]
      INA              ; [Increment A]
      INA              ; [Increment A]
      INA              ; [Increment A]
W879D LDB/  W86EF      ; =0x86EF =34543(-30993) [Load B direct]
      AAB              ; [A + B -> B]
      STB   W87B3      ; =+16 [Store B relative]
      CLA              ; [Clear A]
      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
      LDB   W87AF      ; =+6 [Load B relative]
      SAB              ; [A - B -> B]
      BNZ   D8796      ; =-22 [Branch if not zero]
      JSR/  FA311      ; =0xA311 =41745(-23791) [Jump to subroutine direct]
W87AF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W87B1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W87B3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      XFRB  BL,BL      ; [Transfer BL to BL]
      BNZ   D8796      ; =-35 [Branch if not zero]
      LDA   W87B3      ; =-8 [Load A relative]
      DCA              ; [Decrement A]
      DCA              ; [Decrement A]
      DCA              ; [Decrement A]
      LDB*  W879D+1    ; =-34 [Load B relative indirect]
      SAB              ; [A - B -> B]
      XFR   B,A        ; [Transfer B to A]
D87C3 LDX+  S+         ; [Load X indexed, direct, post-incremented]
      STA+  X+         ; [Store A indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F87C8
*
F87C8 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      STB   W87EA      ; =+28 [Store B relative]
      STB   W8807      ; =+55 [Store B relative]
      LDA+  B+         ; [Load A indexed, direct, post-incremented]
      LDAB+ B          ; [Load AL from address in B]
      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
D87D5 JSR/  F871B      ; =0x871B =34587(-30949) [Jump to subroutine direct]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   B,X        ; [Transfer B to X]
D87DC LDA+  X          ; [Load A from address in X]
      BZ    D8833      ; =+84 [Branch if zero]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      INA              ; [Increment A]
      LDB*  W879D+1    ; =-70 [Load B relative indirect]
      AAB              ; [A + B -> B]
      STB   W87EC      ; =+5 [Store B relative]
*
* Function F87E7
*
F87E7 JSR/  FA2DB      ; =0xA2DB =41691(-23845) ='"','[' [Jump to subroutine direct]
W87EA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W87EC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      BM    D87F4      ; =+4 [Branch on minus]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JMP   D87DC      ; =-24 [Jump relative]
D87F4 LDA   W87EC      ; =-10 [Load A relative]
      STA   W8817      ; =+31 [Store A relative]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
D87FA LDA+  X          ; [Load A from address in X]
      BZ    D8825      ; =+40 [Branch if zero]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      INA              ; [Increment A]
      LDB*  W879D+1    ; =-100 [Load B relative indirect]
      AAB              ; [A + B -> B]
      STB   W8809      ; =+4 [Store B relative]
      JSR*  F87E7+1    ; =-31 [Jump to subroutine relative indirect]
W8807 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W8809 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      BM    D8811      ; =+4 [Branch on minus]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JMP   D87FA      ; =-23 [Jump relative]
D8811 LDA   W8809      ; =-10 [Load A relative]
      STA   W8819      ; =+4 [Store A relative]
      JSR*  F87E7+1    ; =-47 [Jump to subroutine relative indirect]
W8817 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W8819 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      BM    D8821      ; =+4 [Branch on minus]
      LDA   W8819      ; =-6 [Load A relative]
      STA   W8817      ; =-10 [Store A relative]
D8821 LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JMP   D87FA      ; =-43 [Jump relative]
D8825 LDA   W8817      ; =-16 [Load A relative]
      LDB/  W86EF      ; =0x86EF =34543(-30993) [Load B direct]
      DCA              ; [Decrement A]
      SAB              ; [A - B -> B]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
      STB+  X+         ; [Store B indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
D8833 LDX+  S+         ; [Load X indexed, direct, post-incremented]
      LDAB+ S          ; [Load AL from address in S]
      INAB             ; [Increment AL]
      STAB+ S          ; [Store AL to address in S]
      LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BLE   D87D5      ; =-104 [Branch if less than or equal to zero]
      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
      CLA              ; [Clear A]
      STA+  X+         ; [Store A indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
J8843 LDA=  WA143      ; =0xA143 =41283(-24253) [Load A with immediate]
      XAY              ; [Transfer A to Y]
      JSR/  W86C8      ; =0x86C8 =34504(-31032) [Jump to subroutine direct]
W884A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
S884C DB    0,3        ; =0x00,0x0003
      DB    X'03'      ; =0x03 =3
      JSR   F8876      ; =+36 [Jump to subroutine relative]
      JSR   F88B1      ; =+93 [Jump to subroutine relative]
      LDA   W889E      ; =+72 [Load A relative]
      STA/  W9AAE      ; =0x9AAE =39598(-25938) [Store A direct]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB  B8890      ; =+51 [Store AL relative]
      JSR   F8876      ; =+23 [Jump to subroutine relative]
      JSR   F88B1      ; =+80 [Jump to subroutine relative]
      JSR/  F9B09      ; =0x9B09 =39689(-25847) [Jump to subroutine direct]
      DW    W9B92      ; =0x9B92 =39826(-25710)
      JSR/  F9B09      ; =0x9B09 =39689(-25847) [Jump to subroutine direct]
      DW    W9B16      ; =0x9B16 =39702(-25834)
      JSR/  F9A0B      ; =0x9A0B =39435(-26101) [Jump to subroutine direct]
      JSR/  F9A9D      ; =0x9A9D =39581(-25955) [Jump to subroutine direct]
      DW    W888C      ; =0x888C =34956(-30580)
      JMP/  J8165      ; =0x8165 =33125(-32411) [Jump direct]
*
* Function F8876
*
F8876 CLA              ; [Clear A]
      STAB/ S9B17      ; =0x9B17 =39703(-25833) [Store AL direct]
      STAB/ S9B93      ; =0x9B93 =39827(-25709) [Store AL direct]
      STA   W889E      ; =+31 [Store A relative]
      STAB/ B9A22      ; =0x9A22 =39458(-26078) [Store AL direct]
      STA   W888E      ; =+10 [Store A relative]
      STA/  W826D      ; =0x826D =33389(-32147) [Store A direct]
      LDA=  WA143      ; =0xA143 =41283(-24253) [Load A with immediate]
      XAY              ; [Transfer A to Y]
      RSR              ; [Return from subroutine]
*
W888C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W888E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
B8890 DB    X'00'      ; =0x00 =0 =NUL
B8891 DB    X'00'      ; =0x00 =0 =NUL
B8892 DB    X'01'      ; =0x01 =1
B8893 DB    X'01'      ; =0x01 =1
W8894 DS    5          ; =0x0005 [Uninitialized memory]
B8899 DB    X'00'      ; =0x00 =0 =NUL
B889A DB    X'00'      ; =0x00 =0 =NUL
W889B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
B889D DB    X'00'      ; =0x00 =0 =NUL
W889E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
B88A0 DB    X'00'      ; =0x00 =0 =NUL
W88A1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88A3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88A5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88A7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88A9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88AB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88AD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W88AF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F88B1
*
F88B1 JSR/  F814E      ; =0x814E =33102(-32434) [Jump to subroutine direct]
      XAZ              ; [Transfer A to Z]
      BNZ   D88B8      ; =+1 [Branch if not zero]
      RSR              ; [Return from subroutine]
*
D88B8 LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D88C2      ; =+4 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      JMP   F88B1      ; =-17 [Jump relative]
D88C2 LDA=  WA143      ; =0xA143 =41283(-24253) [Load A with immediate]
      XAY              ; [Transfer A to Y]
      LDAB= X'04'      ; =4 [Load AL with immediate]
      STAB  B889A      ; =-48 [Store AL relative]
      CLA              ; [Clear A]
      STA   W88A1      ; =-44 [Store A relative]
      STA   W88A5      ; =-42 [Store A relative]
      STA   W88A9      ; =-40 [Store A relative]
      STA   W88AD      ; =-38 [Store A relative]
      STAB/ B985F      ; =0x985F =39007(-26529) [Store AL direct]
      STAB  B8899      ; =-63 [Store AL relative]
      STA   W889B      ; =-63 [Store A relative]
      STAB  B889D      ; =-63 [Store AL relative]
      STAB  B88A0      ; =-62 [Store AL relative]
      JSR/  F9C2A      ; =0x9C2A =39978(-25558) [Jump to subroutine direct]
      JSR   F88E8      ; =+5 [Jump to subroutine relative]
      JSR/  F9860      ; =0x9860 =39008(-26528) [Jump to subroutine direct]
      JMP   F88B1      ; =-55 [Jump relative]
*
* Function F88E8
*
F88E8 LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8904      ; =+22 [Branch if not zero]
      XFR   Z,A        ; [Transfer Z to A]
      STA   W88A1      ; =-81 [Store A relative]
      JSR   F8915      ; =+33 [Jump to subroutine relative]
      LDA   W88AF      ; =-71 [Load A relative]
      STA   W88A3      ; =-85 [Store A relative]
      CLA              ; [Clear A]
      STA   W88AD      ; =-78 [Store A relative]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8904 JSR   F8926      ; =+32 [Jump to subroutine relative]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8914      ; =+4 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      JSR   F8915      ; =+1 [Jump to subroutine relative]
D8914 RSR              ; [Return from subroutine]
*
* Function F8915
*
F8915 XFR   Z,A        ; [Transfer Z to A]
      STA   W88AD      ; =-108 [Store A relative]
      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
D891B LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
      SABB             ; [AL - BL -> BL]
      BNZ   D891B      ; =-5 [Branch if not zero]
      XFR   Z,A        ; [Transfer Z to A]
      DCA              ; [Decrement A]
      STA   W88AF      ; =-118 [Store A relative]
      RSR              ; [Return from subroutine]
*
* Function F8926
*
F8926 LDAB+ Z          ; [Load AL from address in Z]
      JSR/  F97E3      ; =0x97E3 =38883(-26653) [Jump to subroutine direct]
      BM    D8932      ; =+6 [Branch on minus]
      JSR   F8943      ; =+21 [Jump to subroutine relative]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      JMP   D8934      ; =+2 [Jump relative]
D8932 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
D8934 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JSR   F897A      ; =+61 [Jump to subroutine relative]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88AB      ; =0x88AB =34987(-30549) [Store A direct]
      RSR              ; [Return from subroutine]
*
* Function F8943
*
F8943 XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A1      ; =0x88A1 =34977(-30559) [Store A direct]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB/ B8891      ; =0x8891 =34961(-30575) [Store AL direct]
      JSR/  F965F      ; =0x965F =38495(-27041) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STAB/ B8891      ; =0x8891 =34961(-30575) [Store AL direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A3      ; =0x88A3 =34979(-30557) [Store A direct]
      LDA+  Y          ; [Load A from address in Y]
      LDB+  A,2        ; [Load B indexed, displaced, direct]
      LDBB= X'02'      ; =2 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BNZ   D8979      ; =+22 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BZ    D8972      ; =+9 [Branch if zero]
      LDBB/ B8890      ; =0x8890 =34960(-30576) [Load BL direct]
      BNZ   D8972      ; =+4 [Branch if not zero]
      JSR/  F982E      ; =0x982E =38958(-26578) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D8972 LDBB= X'01'      ; =1 [Load BL with immediate]
      ORIB  BU,BL      ; [BU | BL -> BL]
      STBB+ A,2        ; [Store BL indexed, displaced, direct]
D8979 RSR              ; [Return from subroutine]
*
* Function F897A
*
F897A JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8989      ; =+6 [Branch if not zero]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8989 XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A5      ; =0x88A5 =34981(-30555) [Store A direct]
      JSR/  F9C59      ; =0x9C59 =40025(-25511) [Jump to subroutine direct]
      LDAB+ Y          ; [Load AL from address in Y]
      INAB             ; [Increment AL]
      BZ    D89A2      ; =+13 [Branch if zero]
      DCAB             ; [Decrement AL]
      SRAB             ; [Right shift AL]
      BL    D899E      ; =+5 [Branch on link]
      JSR/  F8BB0      ; =0x8BB0 =35760(-29776) =VT,'0' [Jump to subroutine direct]
      JMP   D89B2      ; =+20 [Jump relative]
D899E JSR   F89C7      ; =+39 [Jump to subroutine relative]
      DW    X'7310'    ; =0x7310 =29456
D89A2 JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A7      ; =0x88A7 =34983(-30553) [Store A direct]
      CLA              ; [Clear A]
      STA+  Y          ; [Store A to address in Y]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F9834      ; =0x9834 =38964(-26572) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D89B2 LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D89BC      ; =+4 [Branch if zero]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D89BC INR   Z          ; [Increment Z by 1]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88AB      ; =0x88AB =34987(-30549) [Store A direct]
      RSR              ; [Return from subroutine]
*
* Function F89C7
*
F89C7 JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A7      ; =0x88A7 =34983(-30553) [Store A direct]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      CLRB  AU         ; [Clear AU]
      SLA              ; [Left shift A]
      LDB=  W89E4      ; =0x89E4 =35300(-30236) [Load B with immediate]
      AAB              ; [A + B -> B]
      JMP+  *B         ; [Jump indexed, indirect]
W89E4 DW    W8A00      ; =0x8A00 =35328(-30208)
      DW    W8A04      ; =0x8A04 =35332(-30204)
      DW    W8A2A      ; =0x8A2A =35370(-30166)
      DW    W8A47      ; =0x8A47 =35399(-30137)
      DW    W8A53      ; =0x8A53 =35411(-30125)
      DW    W8A5B      ; =0x8A5B =35419(-30117)
      DW    W8A5F      ; =0x8A5F =35423(-30113)
      DW    W8A77      ; =0x8A77 =35447(-30089)
      DW    W8AA2      ; =0x8AA2 =35490(-30046)
      DW    W8AB0      ; =0x8AB0 =35504(-30032)
      DW    W8AB4      ; =0x8AB4 =35508(-30028)
      DW    W8ABA      ; =0x8ABA =35514(-30022)
      DW    W8AF7      ; =0x8AF7 =35575(-29961)
      DW    W8B1F      ; =0x8B1F =35615(-29921)
W8A00 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      JMP   D8A18      ; =+20 [Jump relative]
W8A04 LDAB= X'02'      ; =2 [Load AL with immediate]
      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
      LDBB+ Y          ; [Load BL from address in Y]
      BZ    D8A18      ; =+13 [Branch if zero]
      LDB+  Y,1        ; [Load B indexed, displaced, direct]
      XFRB  AL,AU      ; [Transfer AL to AU]
      LDAB+ B,2        ; [Load AL indexed, displaced, direct]
      ORIB  AU,AL      ; [AU | AL -> AL]
      STAB+ B,2        ; [Store AL indexed, displaced, direct]
D8A18 JSR*  F8A62+1    ; =+73 [Jump to subroutine relative indirect]
      JSR*  F8A65+1    ; =+74 [Jump to subroutine relative indirect]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JSR   F8A3E      ; =+29 [Jump to subroutine relative]
B8A21 LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      BNZ   D8A29      ; =+3 [Branch if not zero]
      STAB/ B889A      ; =0x889A =34970(-30566) [Store AL direct]
D8A29 RSR              ; [Return from subroutine]
*
W8A2A LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      JSR*  F8A62+1    ; =+53 [Jump to subroutine relative indirect]
      LDA+  Y          ; [Load A from address in Y]
      STA/  W889E      ; =0x889E =34974(-30562) [Store A direct]
      LDAB* B8A21+1    ; =-18 [Load AL relative indirect]
      BNZ   D8A38      ; =+2 [Branch if not zero]
      JSR*  F8A43+1    ; =+12 [Jump to subroutine relative indirect]
D8A38 JSR   F8A3E      ; =+4 [Jump to subroutine relative]
D8A3A CLA              ; [Clear A]
D8A3B STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
* Function F8A3E
*
F8A3E LDA/  W889B      ; =0x889B =34971(-30565) [Load A direct]
      BZ    D8A46      ; =+3 [Branch if zero]
*
* Function F8A43
*
F8A43 JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
D8A46 RSR              ; [Return from subroutine]
*
W8A47 LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB/ B889D      ; =0x889D =34973(-30563) [Store AL direct]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      CLA              ; [Clear A]
      INA              ; [Increment A]
      JMP   D8A3B      ; =-24 [Jump relative]
W8A53 JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      JMP   D8A3B      ; =-32 [Jump relative]
W8A5B JSR/  F8B6F      ; =0x8B6F =35695(-29841) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
W8A5F JSR/  F996A      ; =0x996A =39274(-26262) [Jump to subroutine direct]
*
* Function F8A62
*
F8A62 JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
*
* Function F8A65
*
F8A65 JSR/  F995E      ; =0x995E =39262(-26274) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDB/  W889E      ; =0x889E =34974(-30562) [Load B direct]
      AAB              ; [A + B -> B]
      STB/  W889E      ; =0x889E =34974(-30562) [Store B direct]
      LDAB* B8A21+1    ; =-81 [Load AL relative indirect]
      BZ    D8A38      ; =-61 [Branch if zero]
      JSR*  F8A43+1    ; =-51 [Jump to subroutine relative indirect]
W8A77 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDAB+ Y          ; [Load AL from address in Y]
      BZ    D8A8E      ; =+18 [Branch if zero]
      LDA+  Y,1        ; [Load A indexed, displaced, direct]
      LDB+  A,2        ; [Load B indexed, displaced, direct]
      LDBB= X'08'      ; =8 [Load BL with immediate]
      ORIB  BU,BL      ; [BU | BL -> BL]
      STBB+ A,2        ; [Store BL indexed, displaced, direct]
      JSR/  F99A4      ; =0x99A4 =39332(-26204) [Jump to subroutine direct]
      DW    W9AB1      ; =0x9AB1 =39601(-25935)
D8A8E JSR*  F8A62+1    ; =-45 [Jump to subroutine relative indirect]
      LDA+  Y          ; [Load A from address in Y]
      STA/  W889E      ; =0x889E =34974(-30562) [Store A direct]
      STA/  W9AAC      ; =0x9AAC =39596(-25940) [Store A direct]
      LDAB= X'05'      ; =5 [Load AL with immediate]
      JSR/  F9AB9      ; =0x9AB9 =39609(-25927) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STA/  W9AAE      ; =0x9AAE =39598(-25938) [Store A direct]
      JMP   D8A38      ; =-106 [Jump relative]
W8AA2 JSR/  F996A      ; =0x996A =39274(-26262) [Jump to subroutine direct]
      JSR*  F8A62+1    ; =-68 [Jump to subroutine relative indirect]
      JSR*  F8A65+1    ; =-67 [Jump to subroutine relative indirect]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      STA/  W888E      ; =0x888E =34958(-30578) [Store A direct]
      JMP   D8A38      ; =-120 [Jump relative]
W8AB0 LDAB= X'08'      ; =8 [Load AL with immediate]
      JMP   D8AB6      ; =+2 [Jump relative]
W8AB4 LDAB= X'11'      ; =17 [Load AL with immediate]
D8AB6 JSR   F8B2A      ; =+114 [Jump to subroutine relative]
      JMP   D8A3A      ; =-128 [Jump relative]
W8ABA LDA+  Z          ; [Load A from address in Z]
      LDB=  X'CFCE'    ; =0xCFCE =53198(-12338) ='O','N' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D8AC5      ; =+4 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      JMP   D8ACB      ; =+6 [Jump relative]
D8AC5 LDB=  X'CFC6'    ; =0xCFC6 =53190(-12346) ='O','F' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D8AD0      ; =+5 [Branch if not zero]
D8ACB STBB/ B8892      ; =0x8892 =34962(-30574) [Store BL direct]
      JMP   D8AE7      ; =+23 [Jump relative]
D8AD0 LDB=  X'C3CF'    ; =0xC3CF =50127(-15409) ='C','O' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D8ADA      ; =+4 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      JMP   D8AE4      ; =+10 [Jump relative]
D8ADA LDB=  X'CECF'    ; =0xCECF =52943(-12593) ='N','O' [Load B with immediate]
      SAB              ; [A - B -> B]
      BZ    D8AE4      ; =+4 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D8AE4 STBB/ B8893      ; =0x8893 =34963(-30573) [Store BL direct]
D8AE7 JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    W8ABA      ; =-55 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
W8AF7 JSR   F8B6F      ; =+118 [Jump to subroutine relative]
      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
      ADD   X,Y        ; [X + Y -> Y]
      XFR   Y,A        ; [Transfer Y to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDB=  X'0057'    ; =0x0057 =87 [Load B with immediate]
      SUB   X,B        ; [X - B -> B]
      BLE   W8B0B      ; =+3 [Branch if less than or equal to zero]
      LDX=  X'0057'    ; =0x0057 =87 [Load X with immediate]
W8B0B LDA=  S82BC      ; =0x82BC =33468(-32068) [Load A with immediate]
D8B0E LDBB- Y-         ; [Load BL indexed, pre-decremented, direct]
      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
      DCX              ; [Decrement X]
      BGZ   D8B0E      ; =-7 [Branch if greater than zero]
      LDB=  S8284      ; =0x8284 =33412(-32124) [Load B with immediate]
      SAB              ; [A - B -> B]
      STB/  W8282      ; =0x8282 =33410(-32126) [Store B direct]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
W8B1F CLA              ; [Clear A]
      STA/  W826B      ; =0x826B =33387(-32149) [Store A direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F8B2A
*
F8B2A STAB- S-         ; [Store AL indexed, pre-decremented, direct]
D8B2C LDAB+ Z          ; [Load AL from address in Z]
      JSR/  F97E3      ; =0x97E3 =38883(-26653) [Jump to subroutine direct]
      BM    D8B6C      ; =+58 [Branch on minus]
      JSR/  F965F      ; =0x965F =38495(-27041) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDB+  A,2        ; [Load B indexed, displaced, direct]
      LDBB+ S          ; [Load BL from address in S]
      ORIB  BU,BL      ; [BU | BL -> BL]
      STBB+ A,2        ; [Store BL indexed, displaced, direct]
      XFRB  BL,BU      ; [Transfer BL to BU]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BNZ   D8B4D      ; =+5 [Branch if not zero]
      JSR/  F984E      ; =0x984E =38990(-26546) [Jump to subroutine direct]
      JMP   D8B63      ; =+22 [Jump relative]
D8B4D LDBB= X'08'      ; =8 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BZ    D8B63      ; =+16 [Branch if zero]
      JSR/  F99A4      ; =0x99A4 =39332(-26204) [Jump to subroutine direct]
      DW    W9AB1      ; =0x9AB1 =39601(-25935)
      LDB+  A,3        ; [Load B indexed, displaced, direct]
      STB/  W9AAC      ; =0x9AAC =39596(-25940) [Store B direct]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      JSR/  F9AB9      ; =0x9AB9 =39609(-25927) [Jump to subroutine direct]
D8B63 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8B2C      ; =-62 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
D8B6C LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F8B6F
*
F8B6F XFR   Z,A        ; [Transfer Z to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'C3'      ; =195(-61) ='C' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8B7C      ; =+2 [Branch if not zero]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
D8B7C LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8B8B      ; =+10 [Branch if zero]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAZ              ; [Transfer A to Z]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D8B8B STX+  S          ; [Store X indexed, direct]
      CLA              ; [Clear A]
      XAX              ; [Transfer A to X]
D8B8F LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8BA6      ; =+16 [Branch if zero]
      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8BA1      ; =+6 [Branch if not zero]
      LDBB+ Z          ; [Load BL from address in Z]
      SABB             ; [AL - BL -> BL]
      BNZ   D8BAB      ; =+12 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
D8BA1 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      INX              ; [Increment X]
      JMP   D8B8F      ; =-23 [Jump relative]
D8BA6 DCR   Z          ; [Decrement Z by 1]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D8BAB STX-  Y-         ; [Store X indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F8BB0
*
F8BB0 LDAB+ Y          ; [Load AL from address in Y]
      LDBB= X'02'      ; =2 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      BZ    D8BCF      ; =+25 [Branch if zero]
      LDB+  Z          ; [Load B from address in Z]
      LDBB= X'C2'      ; =194(-62) ='B' [Load BL with immediate]
      SUBB  BU,BL      ; [BU - BL -> BL]
      BNZ   D8BCF      ; =+18 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      STBB/ B889D      ; =0x889D =34973(-30563) [Store BL direct]
      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
      LDBB+ Y,1        ; [Load BL indexed, displaced, direct]
      OREB  BU,BL      ; [BU ^ BL -> BL]
      STBB+ Y,1        ; [Store BL indexed, displaced, direct]
D8BCF XFR   Z,B        ; [Transfer Z to B]
      STB/  W88A7      ; =0x88A7 =34983(-30553) [Store B direct]
      RL               ; [Reset link]
      RRRB  AL         ; [Right rotate AL by 1]
      SRRB  AL,3       ; [Right shift AL by 3]
      SLAB             ; [Left shift AL]
      CLRB  AU         ; [Clear AU]
      LDB=  W8BEB      ; =0x8BEB =35819(-29717) =VT,'k' [Load B with immediate]
      AAB              ; [A + B -> B]
      JSR+  *B         ; [Jump to subroutine indexed, indirect]
      LDA+  Y          ; [Load A from address in Y]
      DCA              ; [Decrement A]
      DCA              ; [Decrement A]
      BNZ   D8BEA      ; =+3 [Branch if not zero]
      JSR/  F9F10      ; =0x9F10 =40720(-24816) [Jump to subroutine direct]
D8BEA RSR              ; [Return from subroutine]
*
W8BEB DW    W8C09      ; =0x8C09 =35849(-29687)
      DW    W8C53      ; =0x8C53 =35923(-29613)
      DW    W8C8E      ; =0x8C8E =35982(-29554)
      DW    W8D3F      ; =0x8D3F =36159(-29377)
      DW    W8D52      ; =0x8D52 =36178(-29358)
      DW    W8E0D      ; =0x8E0D =36365(-29171)
      DW    W8E82      ; =0x8E82 =36482(-29054)
      DW    W8ECD      ; =0x8ECD =36557(-28979)
      DW    W8F39      ; =0x8F39 =36665(-28871)
      DW    W9023      ; =0x9023 =36899(-28637)
      DW    W903E      ; =0x903E =36926(-28610)
      DW    W9057      ; =0x9057 =36951(-28585)
      DW    W9084      ; =0x9084 =36996(-28540)
      DW    W9092      ; =0x9092 =37010(-28526)
      DW    W90BF      ; =0x90BF =37055(-28481)
W8C09 JSR/  F9246      ; =0x9246 =37446(-28090) [Jump to subroutine direct]
      CLA              ; [Clear A]
      INA              ; [Increment A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8C20      ; =+4 [Branch if zero]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAZ              ; [Transfer A to Z]
      RSR              ; [Return from subroutine]
*
D8C20 XFR   Z,A        ; [Transfer Z to A]
      DCA              ; [Decrement A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      STX+  S          ; [Store X indexed, direct]
B8C28 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      BZ    D8C35      ; =+9 [Branch if zero]
      LDX=  W9F51      ; =0x9F51 =40785(-24751) [Load X with immediate]
      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
D8C32 LDBB+ X          ; [Load BL from address in X]
      BNZ   D8C3A      ; =+5 [Branch if not zero]
D8C35 DCR   Z          ; [Decrement Z by 1]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
D8C3A SABB             ; [AL - BL -> BL]
      BZ    D8C41      ; =+4 [Branch if zero]
      INR   X,3        ; [Increment X by 3]
      JMP   D8C32      ; =-15 [Jump relative]
D8C41 LDA+  X,-2       ; [Load A indexed, displaced, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      XFRB  AU,BL      ; [Transfer AU to BL]
      STBB+ Y+,2       ; [Store BL indexed, displaced, direct, post-incremented]
      STAB+ Y          ; [Store AL to address in Y]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JMP   D8C6B      ; =+24 [Jump relative]
W8C53 JSR/  F9246      ; =0x9246 =37446(-28090) [Jump to subroutine direct]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y          ; [Load AL from address in Y]
      SLRB  AL,4       ; [Left shift AL by 4]
      STAB+ Y          ; [Store AL to address in Y]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
J8C65 JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8C6B      ; =+1 [Branch if zero]
      RSR              ; [Return from subroutine]
*
D8C6B JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
W8C70 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
      ADD   B,A        ; [B + A -> A]
      BP    D8C7B      ; =+4 [Branch on plus]
D8C77 JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
      CLA              ; [Clear A]
D8C7B LDB=  X'000F'    ; =0x000F =15 [Load B with immediate]
      SAB              ; [A - B -> B]
      BGZ   D8C77      ; =-10 [Branch if greater than zero]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX+  Y          ; [Load X indexed, direct]
      ADD   Y,X        ; [Y + X -> X]
      LDBB+ X          ; [Load BL from address in X]
      ORIB  AL,BL      ; [AL | BL -> BL]
      STBB+ X          ; [Store BL to address in X]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W8C8E LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB  B8CF5+1    ; =+98 [Store AL relative]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8CB9      ; =+30 [Branch if not zero]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8CA9      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D8CA9 JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
      LDAB+ Y          ; [Load AL from address in Y]
      SLRB  AL,4       ; [Left shift AL by 4]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8CB9 LDBB/ B889D      ; =0x889D =34973(-30563) [Load BL direct]
      BZ    D8CC1      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D8CC1 LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8CCF      ; =+9 [Branch if zero]
      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8D03      ; =+56 [Branch if not zero]
      LDAB= X'10'      ; =16 [Load AL with immediate]
      STAB  B8CF5+1    ; =+39 [Store AL relative]
D8CCF JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8CE1      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D8CE1 JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8CEC      ; =+3 [Branch if zero]
      LDBB+ Y          ; [Load BL from address in Y]
      JMP   D8CF1      ; =+5 [Jump relative]
D8CEC JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
D8CF1 LDAB+ Y          ; [Load AL from address in Y]
      SLRB  AL,4       ; [Left shift AL by 4]
      AABB             ; [AL + BL -> BL]
B8CF5 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8D03 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8D1C      ; =+20 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      INR   A,4        ; [Increment A by 4]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      DCR   Z          ; [Decrement Z by 1]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A7      ; =0x88A7 =34983(-30553) [Store A direct]
      RSR              ; [Return from subroutine]
*
D8D1C LDAB= X'11'      ; =17 [Load AL with immediate]
      STAB  B8CF5+1    ; =-42 [Store AL relative]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8D2E      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D8D2E JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8CEC      ; =-78 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D8CEC      ; =-83 [Jump relative]
W8D3F INR   Y          ; [Increment Y by 1]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      JSR/  F9350      ; =0x9350 =37712(-27824) [Jump to subroutine direct]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
W8D52 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      CLA              ; [Clear A]
      STAB  B8DB3      ; =+92 [Store AL relative]
      XAX              ; [Transfer A to X]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SRRB  AL,3       ; [Right shift AL by 3]
      BNL   D8D6B      ; =+13 [Branch on no link]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8D6D      ; =+8 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      STBB  B8DB3      ; =+74 [Store BL relative]
      JMP   D8D9A      ; =+47 [Jump relative]
D8D6B LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
D8D6D LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      STBB/ B889D      ; =0x889D =34973(-30563) [Store BL direct]
      INX              ; [Increment X]
      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8D9A      ; =+34 [Branch if zero]
      INX              ; [Increment X]
      LDBB= X'A4'      ; =164(-92) ='$' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8D9A      ; =+28 [Branch if zero]
      INX              ; [Increment X]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8DB4      ; =+48 [Branch if zero]
      INX              ; [Increment X]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8DB4      ; =+42 [Branch if zero]
      INX              ; [Increment X]
      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8DC3      ; =+51 [Branch if zero]
      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8DC3      ; =+46 [Branch if zero]
      JSR/  F9834      ; =0x9834 =38964(-26572) [Jump to subroutine direct]
      CLA              ; [Clear A]
      XAX              ; [Transfer A to X]
D8D9A STX-  Y-         ; [Store X indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JSR   F8DCD      ; =+45 [Jump to subroutine relative]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      LDAB/ B889D      ; =0x889D =34973(-30563) [Load AL direct]
      BNZ   D8DBD      ; =+21 [Branch if not zero]
      LDAB  B8DB3      ; =+9 [Load AL relative]
      BNZ   D8DAE      ; =+2 [Branch if not zero]
      JSR   F8DE1      ; =+51 [Jump to subroutine relative]
D8DAE LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
      JMP   D8DC0      ; =+13 [Jump relative]
*
B8DB3 DB    X'00'      ; =0x00 =0 =NUL
D8DB4 STX-  Y-         ; [Store X indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JSR   F8DCD      ; =+19 [Jump to subroutine relative]
      JSR/  F9350      ; =0x9350 =37712(-27824) [Jump to subroutine direct]
D8DBD LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
D8DC0 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8DC3 STX-  Y-         ; [Store X indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      JSR   F8DCD      ; =+4 [Jump to subroutine relative]
      JSR/  F92C5      ; =0x92C5 =37573(-27963) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
* Function F8DCD
*
F8DCD LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDBB+ Y          ; [Load BL from address in Y]
      ORIB  AL,BL      ; [AL | BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A7      ; =0x88A7 =34983(-30553) [Store A direct]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      RSR              ; [Return from subroutine]
*
* Function F8DE1
*
F8DE1 LDBB+ Y          ; [Load BL from address in Y]
      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
      XFRB  AL,BU      ; [Transfer AL to BU]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      INR   A,3        ; [Increment A by 3]
      SUB   B,A        ; [B - A -> A]
      LDB=  X'007F'    ; =0x007F =127 [Load B with immediate]
      SAB              ; [A - B -> B]
      BGZ   D8E0C      ; =+24 [Branch if greater than zero]
      LDB=  X'FF80'    ; =0xFF80 =65408(-128) [Load B with immediate]
      SAB              ; [A - B -> B]
      BM    D8E0C      ; =+18 [Branch on minus]
      LDAB/ B9FD4      ; =0x9FD4 =40916(-24620) [Load AL direct]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8E0C      ; =+10 [Branch if not zero]
      LDA/  W889B      ; =0x889B =34971(-30565) [Load A direct]
      BNZ   D8E0C      ; =+5 [Branch if not zero]
      LDBB= X'C9'      ; =201(-55) ='I' [Load BL with immediate]
      STBB/ B9FD4      ; =0x9FD4 =40916(-24620) [Store BL direct]
D8E0C RSR              ; [Return from subroutine]
*
W8E0D STX-  S-         ; [Store X indexed, pre-decremented, direct]
      INR   Y          ; [Increment Y by 1]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      LDX=  W9279+1    ; =0x927A =37498(-28038) [Load X with immediate]
      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
D8E1E INR   X,3        ; [Increment X by 3]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      BZ    D8E30      ; =+12 [Branch if zero]
      SAB              ; [A - B -> B]
      BNZ   D8E1E      ; =-9 [Branch if not zero]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
      SABB             ; [AL - BL -> BL]
      BZ    D8E37      ; =+9 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
D8E30 JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLRB  BL         ; [Clear BL]
      JMP   D8E78      ; =+65 [Jump relative]
D8E37 CLA              ; [Clear A]
      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      LDB=  W9277      ; =0x9277 =37495(-28041) [Load B with immediate]
      AAB              ; [A + B -> B]
      CLA              ; [Clear A]
      JMP+  *B         ; [Jump indexed, indirect]
W8E41 JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8E4C      ; =+6 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLA              ; [Clear A]
      JMP   D8E57      ; =+11 [Jump relative]
D8E4C JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      BP    D8E57      ; =+4 [Branch on plus]
D8E53 JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
      CLA              ; [Clear A]
D8E57 LDB=  X'0003'    ; =0x0003 =3 [Load B with immediate]
      SAB              ; [A - B -> B]
      BGZ   D8E53      ; =-10 [Branch if greater than zero]
      SLR   A,4        ; [Left shift A by 4]
      JMP   W8E76      ; =+21 [Jump relative]
W8E61 JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8E6C      ; =+6 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLA              ; [Clear A]
      JMP   W8E76      ; =+10 [Jump relative]
D8E6C JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SLRB  AL,4       ; [Left shift AL by 4]
W8E76 LDBB+ X          ; [Load BL from address in X]
      AABB             ; [AL + BL -> BL]
D8E78 STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W8E82 JSR/  F9246      ; =0x9246 =37446(-28090) [Jump to subroutine direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8E98      ; =+12 [Branch if not zero]
      LDAB= X'10'      ; =16 [Load AL with immediate]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      JMP   D8EC5      ; =+45 [Jump relative]
D8E98 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D8EA7      ; =+10 [Branch if zero]
      JSR/  F9834      ; =0x9834 =38964(-26572) [Jump to subroutine direct]
      DCR   Z          ; [Decrement Z by 1]
      CLA              ; [Clear A]
      INA              ; [Increment A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D8EA7 JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y          ; [Load AL from address in Y]
      BNZ   D8EB4      ; =+4 [Branch if not zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLAB             ; [Clear AL]
D8EB4 INAB             ; [Increment AL]
      SLRB  AL,4       ; [Left shift AL by 4]
      STAB+ Y          ; [Store AL to address in Y]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D8EC2      ; =+5 [Branch if zero]
      CLA              ; [Clear A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JMP   D8EC5      ; =+3 [Jump relative]
D8EC2 JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
D8EC5 LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JMP/  J8C65      ; =0x8C65 =35941(-29595) [Jump direct]
W8ECD CLA              ; [Clear A]
      DCA              ; [Decrement A]
      LDBB+ Y          ; [Load BL from address in Y]
      SRRB  BL,4       ; [Right shift BL by 4]
      BNL   D8ED5      ; =+1 [Branch on no link]
      DCA              ; [Decrement A]
D8ED5 STA   W8EF2+1    ; =+28 [Store A relative]
      LDAB= X'46'      ; =70 [Load AL with immediate]
      LDBB+ Y,1        ; [Load BL indexed, displaced, direct]
      STAB+ Y,1        ; [Store AL indexed, displaced, direct]
      CLAB             ; [Clear AL]
      STAB+ Y          ; [Store AL to address in Y]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   Y,X        ; [Transfer Y to X]
      STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      CLA              ; [Clear A]
      DCA              ; [Decrement A]
      XAB              ; [Transfer A to B]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      STBB  B8EFD+1    ; =+12 [Store BL relative]
W8EF2 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
      AAB              ; [A + B -> B]
      BM    D8F2A      ; =+50 [Branch on minus]
      STBB+ X          ; [Store BL to address in X]
      DCRB  BL,15      ; [Decrement BL by 15]
      BGZ   D8F6D      ; =+112 [Branch if greater than zero]
B8EFD LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      SLRB  AL,2       ; [Left shift AL by 2]
      LDBB+ X,-1       ; [Load BL indexed, displaced, direct]
      AABB             ; [AL + BL -> BL]
      STBB+ X,-1       ; [Store BL indexed, displaced, direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D8F6D      ; =+96 [Branch if not zero]
      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
      LDB=  X'FFFF'    ; =0xFFFF =65535(-1) [Load B with immediate]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
      AABB             ; [AL + BL -> BL]
      STBB+ X,-1       ; [Store BL indexed, displaced, direct]
      XFR   Y,A        ; [Transfer Y to A]
      SUB   X,A        ; [X - A -> A]
      INR   A,2        ; [Increment A by 2]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
D8F2A BM    D8F6D      ; =+65 [Branch on minus]
      XAB              ; [Transfer A to B]
      DCR   A,15       ; [Decrement A by 15]
      BGZ   D8F6D      ; =+60 [Branch if greater than zero]
      LDAB+ X          ; [Load AL from address in X]
      SLRB  AL,4       ; [Left shift AL by 4]
      AABB             ; [AL + BL -> BL]
      STBB+ X          ; [Store BL to address in X]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
W8F39 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDAB+ Y          ; [Load AL from address in Y]
      LDBB= X'04'      ; =4 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      STBB  B8F69+1    ; =+41 [Store BL relative]
      LDAB= X'47'      ; =71 [Load AL with immediate]
      LDBB+ Y,1        ; [Load BL indexed, displaced, direct]
      STAB+ Y,1        ; [Store AL indexed, displaced, direct]
      STBB+ Y          ; [Store BL to address in Y]
      XFR   Y,X        ; [Transfer Y to X]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'D2'      ; =210(-46) ='R' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D8F9A      ; =+72 [Branch if not zero]
      LDAB= X'67'      ; =103 [Load AL with immediate]
      STAB+ X,1        ; [Store AL indexed, displaced, direct]
      INR   Z          ; [Increment Z by 1]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
D8F5C CLA              ; [Clear A]
      XAB              ; [Transfer A to B]
      DCAB             ; [Decrement AL]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      DCRB  BL,3       ; [Decrement BL by 3]
      BNZ   D8F74      ; =+14 [Branch if not zero]
      INA              ; [Increment A]
      BZ    D8F6D      ; =+4 [Branch if zero]
B8F69 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      BNZ   D8F77      ; =+10 [Branch if not zero]
D8F6D JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      DCR   Z          ; [Decrement Z by 1]
      JMP   D8F8F      ; =+27 [Jump relative]
D8F74 INA              ; [Increment A]
      BNZ   D8F6D      ; =-10 [Branch if not zero]
D8F77 INRB  BL,3       ; [Increment BL by 3]
D8F79 SLRB  BL,2       ; [Left shift BL by 2]
      LDAB+ X          ; [Load AL from address in X]
      AABB             ; [AL + BL -> BL]
      STBB+ X          ; [Store BL to address in X]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D8F6D      ; =-22 [Branch if not zero]
      LDAB+ X          ; [Load AL from address in X]
      CLR   B          ; [Clear B]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      INA              ; [Increment A]
      BNZ   D8F6D      ; =-31 [Branch if not zero]
      LDAB+ X          ; [Load AL from address in X]
      AABB             ; [AL + BL -> BL]
      STBB+ X          ; [Store BL to address in X]
D8F8F XFR   Y,A        ; [Transfer Y to A]
      SUB   X,A        ; [X - A -> A]
      INR   A,2        ; [Increment A by 2]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
D8F9A JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      CLA              ; [Clear A]
      LDAB+ Y          ; [Load AL from address in Y]
      RRR   A          ; [Right rotate A by 1]
      SRR   A,2        ; [Right shift A by 2]
      LDB=  W92B1      ; =0x92B1 =37553(-27983) [Load B with immediate]
      AAB              ; [A + B -> B]
      JMP+  *B         ; [Jump indexed, indirect]
W8FA9 JMP   D8F5C      ; =-79 [Jump relative]
W8FAB JSR/  F9265      ; =0x9265 =37477(-28059) [Jump to subroutine direct]
D8FAE BNZ   D8F6D      ; =-67 [Branch if not zero]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
J8FB6 JSR/  F901B      ; =0x901B =36891(-28645) [Jump to subroutine direct]
      BNZ   D8FAE      ; =-13 [Branch if not zero]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDAB= X'A9'      ; =169(-87) =')' [Load AL with immediate]
      JSR/  D925C      ; =0x925C =37468(-28068) [Jump to subroutine direct]
      BNZ   D8FAE      ; =-22 [Branch if not zero]
      CLA              ; [Clear A]
      XAB              ; [Transfer A to B]
      DCAB             ; [Decrement AL]
      LDBB+ Y          ; [Load BL from address in Y]
      INR   B          ; [Increment B by 1]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
D8FCD JMP   D8F79      ; =-86 [Jump relative]
W8FCF JSR/  F9265      ; =0x9265 =37477(-28059) [Jump to subroutine direct]
      BNZ   D8FAE      ; =-38 [Branch if not zero]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      JSR   F901B      ; =+63 [Jump to subroutine relative]
      BNZ   D8FAE      ; =-48 [Branch if not zero]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDAB= X'A9'      ; =169(-87) =')' [Load AL with immediate]
      JSR/  D925C      ; =0x925C =37468(-28068) [Jump to subroutine direct]
      BNZ   D8FAE      ; =-57 [Branch if not zero]
      CLAB             ; [Clear AL]
      DCAB             ; [Decrement AL]
      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      JMP   D8FCD      ; =-36 [Jump relative]
W8FF1 JSR/  F9265      ; =0x9265 =37477(-28059) [Jump to subroutine direct]
      BNZ   D8FAE      ; =-72 [Branch if not zero]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      JMP   J8FB6      ; =-71 [Jump relative]
W8FFD JSR/  F9265      ; =0x9265 =37477(-28059) [Jump to subroutine direct]
D9000 BNZ   D8FAE      ; =-84 [Branch if not zero]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      JSR   F901B      ; =+17 [Jump to subroutine relative]
      BNZ   D9000      ; =-12 [Branch if not zero]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D9000      ; =-19 [Branch if not zero]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      JMP/  J8FB6      ; =0x8FB6 =36790(-28746) [Jump direct]
*
* Function F901B
*
F901B XFRB  AU,AU      ; [Transfer AU to AU]
      BZ    D9022      ; =+3 [Branch if zero]
      LDBB/ B8890      ; =0x8890 =34960(-30576) [Load BL direct]
D9022 RSR              ; [Return from subroutine]
*
W9023 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDAB= X'2E'      ; =46 [Load AL with immediate]
      LDBB+ Y,1        ; [Load BL indexed, displaced, direct]
      STAB+ Y,1        ; [Store AL indexed, displaced, direct]
      STBB+ Y          ; [Store BL to address in Y]
      XFR   Y,X        ; [Transfer Y to X]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      CLAB             ; [Clear AL]
      DCAB             ; [Decrement AL]
      LDB=  X'0001'    ; =0x0001 =1 [Load B with immediate]
      JSR/  F9124      ; =0x9124 =37156(-28380) [Jump to subroutine direct]
      JMP/  D8F79      ; =0x8F79 =36729(-28807) [Jump direct]
W903E LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      XFRB  AU,AU      ; [Transfer AU to AU]
      BZ    D9051      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D9051 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
W9057 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y          ; [Load AL from address in Y]
      SLRB  AL,4       ; [Left shift AL by 4]
      STAB+ Y          ; [Store AL to address in Y]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D906D      ; =+5 [Branch if zero]
D9068 JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D907E      ; =+17 [Jump relative]
D906D JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      BM    D9068      ; =-13 [Branch on minus]
      LDB=  X'000F'    ; =0x000F =15 [Load B with immediate]
      SAB              ; [A - B -> B]
      BGZ   D9068      ; =-19 [Branch if greater than zero]
      LDBB+ Y          ; [Load BL from address in Y]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
D907E LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
W9084 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
W9092 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y          ; [Load A from address in Y]
      BP    D90A6      ; =+9 [Branch on plus]
D909D CLAB             ; [Clear AL]
      INR   Y          ; [Increment Y by 1]
      STAB+ Y          ; [Store AL to address in Y]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D907E      ; =-40 [Jump relative]
D90A6 LDB=  X'000F'    ; =0x000F =15 [Load B with immediate]
      SAB              ; [A - B -> B]
      BGZ   D909D      ; =-15 [Branch if greater than zero]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D909D      ; =-20 [Branch if not zero]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      SLRB  AL,4       ; [Left shift AL by 4]
      AABB             ; [AL + BL -> BL]
      STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
      JMP   D907E      ; =-65 [Jump relative]
W90BF LDAB+ Y          ; [Load AL from address in Y]
      SRRB  AL,2       ; [Right shift AL by 2]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'C2'      ; =194(-62) ='B' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D90D3      ; =+7 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      LDAB= X'10'      ; =16 [Load AL with immediate]
      LDBB+ Y          ; [Load BL from address in Y]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
D90D3 JSR/  F9269      ; =0x9269 =37481(-28055) [Jump to subroutine direct]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SRAB             ; [Right shift AL]
      BL    D90E8      ; =+10 [Branch on link]
      SLRB  AL,5       ; [Left shift AL by 5]
      LDBB+ Y          ; [Load BL from address in Y]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D90F3      ; =+11 [Branch if zero]
D90E8 DCR   Z          ; [Decrement Z by 1]
      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
D90ED STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D90F3 JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SRAB             ; [Right shift AL]
      BL    D90E8      ; =-19 [Branch on link]
      SLAB             ; [Left shift AL]
      LDBB+ Y          ; [Load BL from address in Y]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BZ    D9109      ; =+5 [Branch if zero]
      CLAB             ; [Clear AL]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JMP   D911E      ; =+21 [Jump relative]
D9109 JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      SLA              ; [Left shift A]
      XFRB  AU,AU      ; [Transfer AU to AU]
      BZ    D911E      ; =+9 [Branch if zero]
      INRB  AU         ; [Increment AU by 1]
      BZ    D911E      ; =+5 [Branch if zero]
      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
      JMP   D90ED      ; =-49 [Jump relative]
D911E LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
* Function F9124
*
F9124 STB/  W922C+1    ; =0x922D =37421(-28115) [Store B direct]
      STAB/ B9200+1    ; =0x9201 =37377(-28159) [Store AL direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9164      ; =+51 [Branch if not zero]
      JSR/  F9334      ; =0x9334 =37684(-27852) [Jump to subroutine direct]
      XFR   Y,B        ; [Transfer Y to B]
      LDA+  S          ; [Load A from address in S]
      SAB              ; [A - B -> B]
      JSR/  F9AC0      ; =0x9AC0 =39616(-25920) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STA/  W889B      ; =0x889B =34971(-30565) [Store A direct]
      STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
J9142 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
      JSR/  F9265      ; =0x9265 =37477(-28059) [Jump to subroutine direct]
      BZ    D914D      ; =+4 [Branch if zero]
      CLA              ; [Clear A]
      DCA              ; [Decrement A]
      JMP   D9161      ; =+20 [Jump relative]
D914D JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDAB= X'A9'      ; =169(-87) =')' [Load AL with immediate]
      JSR/  D925C      ; =0x925C =37468(-28068) [Jump to subroutine direct]
      BZ    D915F      ; =+8 [Branch if zero]
      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
J9159 JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      CLA              ; [Clear A]
      XAB              ; [Transfer A to B]
      RSR              ; [Return from subroutine]
*
D915F LDA+  Y+         ; [Load A indexed, direct, post-incremented]
D9161 LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
D9164 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D916C      ; =+3 [Branch if zero]
      JMP/  J9222      ; =0x9222 =37410(-28126) [Jump direct]
D916C JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y          ; [Load AL from address in Y]
      SRAB             ; [Right shift AL]
      BL    J9159      ; =-26 [Branch on link]
      SLRB  AL,5       ; [Left shift AL by 5]
      STAB+ Y          ; [Store AL to address in Y]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      STBB  B91C4+1    ; =+73 [Store BL relative]
      BZ    D9185      ; =+7 [Branch if zero]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D91C6      ; =+67 [Branch if not zero]
      JMP   D919A      ; =+21 [Jump relative]
D9185 INR   Z          ; [Increment Z by 1]
      JSR/  F9398      ; =0x9398 =37784(-27752) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      BZ    J9159      ; =-53 [Branch if zero]
      SRAB             ; [Right shift AL]
      BL    J9159      ; =-56 [Branch on link]
      SLAB             ; [Left shift AL]
      LDBB+ Y          ; [Load BL from address in Y]
      AABB             ; [AL + BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      JSR/  F925A      ; =0x925A =37466(-28070) [Jump to subroutine direct]
      BNZ   D91C8      ; =+46 [Branch if not zero]
D919A LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D91A5      ; =+5 [Branch if zero]
      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D91A8      ; =+3 [Branch if not zero]
D91A5 LDAB+ Z,1        ; [Load AL indexed, displaced, direct]
D91A8 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BM    D91B2      ; =+5 [Branch on minus]
      LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BLE   D91CD      ; =+27 [Branch if less than or equal to zero]
D91B2 LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D91C2      ; =+10 [Branch if zero]
      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D91C2      ; =+5 [Branch if zero]
      LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D91CD      ; =+11 [Branch if not zero]
D91C2 DCR   Z          ; [Decrement Z by 1]
B91C4 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
D91C6 BNZ   D91FE      ; =+54 [Branch if not zero]
D91C8 CLAB             ; [Clear AL]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JMP   D91D7      ; =+10 [Jump relative]
D91CD CLA              ; [Clear A]
      DCA              ; [Decrement A]
      JSR/  F93FC      ; =0x93FC =37884(-27652) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      DCAB             ; [Decrement AL]
      BNZ   D91DC      ; =+5 [Branch if not zero]
D91D7 LDAB= X'01'      ; =1 [Load AL with immediate]
      JMP/  J9142      ; =0x9142 =37186(-28350) [Jump direct]
D91DC DCAB             ; [Decrement AL]
      BZ    D91E2      ; =+3 [Branch if zero]
      JMP/  J9159      ; =0x9159 =37209(-28327) [Jump direct]
D91E2 LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
      LDBB= X'10'      ; =16 [Load BL with immediate]
      AABB             ; [AL + BL -> BL]
      STBB+ Y,2        ; [Store BL indexed, displaced, direct]
      XFR   Y,B        ; [Transfer Y to B]
      LDA+  S          ; [Load A from address in S]
      SAB              ; [A - B -> B]
      JSR/  F9AC0      ; =0x9AC0 =39616(-25920) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STA/  W889B      ; =0x889B =34971(-30565) [Store A direct]
      STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      JMP/  J9142      ; =0x9142 =37186(-28350) [Jump direct]
D91FE CLA              ; [Clear A]
      LDAB+ Y          ; [Load AL from address in Y]
B9200 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      INRB  BL         ; [Increment BL by 1]
      BZ    D921C      ; =+22 [Branch if zero]
      SRR   A,4        ; [Right shift A by 4]
      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
      LDAB  B9200+1    ; =-11 [Load AL relative]
      LDBB= X'0C'      ; =12 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      LDAB= X'08'      ; =8 [Load AL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D921A      ; =+6 [Branch if not zero]
      INR   Y          ; [Increment Y by 1]
      LDAB+ Y          ; [Load AL from address in Y]
      LDBB+ S          ; [Load BL from address in S]
      AABB             ; [AL + BL -> BL]
      STBB+ S          ; [Store BL to address in S]
D921A LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
D921C STAB+ Y          ; [Store AL to address in Y]
      LDAB= X'02'      ; =2 [Load AL with immediate]
      JMP/  J9142      ; =0x9142 =37186(-28350) [Jump direct]
J9222 LDBB= X'BD'      ; =189(-67) ='=' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    W922C      ; =+5 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      JMP/  J9159      ; =0x9159 =37209(-28327) [Jump direct]
W922C LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
      JSR/  F93FC      ; =0x93FC =37884(-27652) [Jump to subroutine direct]
      XFR   Y,B        ; [Transfer Y to B]
      LDA+  S          ; [Load A from address in S]
      DCA              ; [Decrement A]
      SAB              ; [A - B -> B]
      JSR/  F9AC0      ; =0x9AC0 =39616(-25920) [Jump to subroutine direct]
      CLA              ; [Clear A]
      STA/  W889B      ; =0x889B =34971(-30565) [Store A direct]
      STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'03'      ; =3 [Load BL with immediate]
      RSR              ; [Return from subroutine]
*
* Function F9246
*
F9246 CLR   B          ; [Clear B]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SRRB  AL,3       ; [Right shift AL by 3]
      BL    D9250      ; =+2 [Branch on link]
      DCR   B          ; [Decrement B by 1]
D9250 STB/  W8C70+1    ; =0x8C71 =35953(-29583) [Store B direct]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      STBB/ B8C28+1    ; =0x8C29 =35881(-29655) [Store BL direct]
      RSR              ; [Return from subroutine]
*
* Function F925A
*
F925A LDAB= X'AC'      ; =172(-84) =',' [Load AL with immediate]
D925C LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
      SABB             ; [AL - BL -> BL]
      BNZ   D9262      ; =+1 [Branch if not zero]
      RSR              ; [Return from subroutine]
*
D9262 DCR   Z          ; [Decrement Z by 1]
      RSR              ; [Return from subroutine]
*
* Function F9265
*
F9265 LDAB= X'A8'      ; =168(-88) ='(' [Load AL with immediate]
      JMP   D925C      ; =-13 [Jump relative]
*
* Function F9269
*
F9269 XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A7      ; =0x88A7 =34983(-30553) [Store A direct]
      JSR/  F9810      ; =0x9810 =38928(-26608) [Jump to subroutine direct]
      XFR   Z,A        ; [Transfer Z to A]
      STA/  W88A9      ; =0x88A9 =34985(-30551) [Store A direct]
      RSR              ; [Return from subroutine]
*
W9277 DW    W8E41      ; =0x8E41 =36417(-29119)
W9279 DW    W8E61      ; =0x8E61 =36449(-29087)
      DW    W8E76      ; =0x8E76 =36470(-29066)
      DC    'SAD'      ; hex:D3C1C4
      DW    X'0200'    ; =0x0200 =512
      DC    'RAD'      ; hex:D2C1C4
      DW    X'0201'    ; =0x0201 =513
      DC    'SCT'      ; hex:D3C3D4
      DW    X'0202'    ; =0x0202 =514
      DC    'RCT'      ; hex:D2C3D4
      DW    X'0203'    ; =0x0203 =515
      DC    'SDV'      ; hex:D3C4D6
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'04'      ; =0x04 =4
      DC    'RDV'      ; hex:D2C4D6
      DW    X'0205'    ; =0x0205 =517
      DC    'EAB'      ; hex:C5C1C2
      DW    X'0406'    ; =0x0406 =1030
      DC    'DAB'      ; hex:C4C1C2
      DW    X'0407'    ; =0x0407 =1031
      DC    'SMN'      ; hex:D3CDCE
      DW    X'0208'    ; =0x0208 =520
      DC    'RMN'      ; hex:D2CDCE
      DW    X'0209'    ; =0x0209 =521
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W92B1 DW    W8FA9      ; =0x8FA9 =36777(-28759)
      DW    W8FF1      ; =0x8FF1 =36849(-28687)
      DW    W8FFD      ; =0x8FFD =36861(-28675)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FAB      ; =0x8FAB =36779(-28757)
      DW    W8FCF      ; =0x8FCF =36815(-28721)
*
* Function F92C5
*
F92C5 CLAB             ; [Clear AL]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D92D3      ; =+5 [Branch if not zero]
      LDAB= X'04'      ; =4 [Load AL with immediate]
      STAB+ Y          ; [Store AL to address in Y]
      INR   Z          ; [Increment Z by 1]
D92D3 JSR/  F93BB      ; =0x93BB =37819(-27717) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      SLRB  AL,4       ; [Left shift AL by 4]
      JSR   F932F      ; =+83 [Jump to subroutine relative]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D92E7      ; =+4 [Branch if not zero]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      JMP   D92EE      ; =+7 [Jump relative]
D92E7 LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D92F2      ; =+6 [Branch if not zero]
      LDAB= X'02'      ; =2 [Load AL with immediate]
D92EE JSR   F932F      ; =+63 [Jump to subroutine relative]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
D92F2 LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D92FF      ; =+8 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
D92F9 LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D92FF JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDBB* B9353+1    ; =+78 [Load BL relative indirect]
      BNZ   D9323      ; =+27 [Branch if not zero]
      LDB*  W9358+1    ; =+79 [Load B relative indirect]
      BNZ   D9323      ; =+23 [Branch if not zero]
      XAB              ; [Transfer A to B]
      BZ    D92F9      ; =-22 [Branch if zero]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDAB= X'08'      ; =8 [Load AL with immediate]
      JSR   F932F      ; =+26 [Jump to subroutine relative]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      LDB=  X'FF80'    ; =0xFF80 =65408(-128) [Load B with immediate]
      AAB              ; [A + B -> B]
      BNL   D9327      ; =+10 [Branch on no link]
      LDB=  X'0080'    ; =0x0080 =128 [Load B with immediate]
      AAB              ; [A + B -> B]
      BL    D9327      ; =+4 [Branch on link]
D9323 JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
      CLA              ; [Clear A]
D9327 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDA=  X'0003'    ; =0x0003 =3 [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
* Function F932F
*
F932F LDBB+ Y          ; [Load BL from address in Y]
      ORIB  AL,BL      ; [AL | BL -> BL]
      STBB+ Y          ; [Store BL to address in Y]
      RSR              ; [Return from subroutine]
*
* Function F9334
*
F9334 LDBB/ B889D      ; =0x889D =34973(-30563) [Load BL direct]
      BNZ   D9341      ; =+8 [Branch if not zero]
      CLR   A,2        ; [Set A to 2]
      JSR/  F93FC      ; =0x93FC =37884(-27652) [Jump to subroutine direct]
      INR   Y          ; [Increment Y by 1]
      RSR              ; [Return from subroutine]
*
D9341 CLA              ; [Clear A]
      JSR/  F93FC      ; =0x93FC =37884(-27652) [Jump to subroutine direct]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      DCAB             ; [Decrement AL]
      BZ    D934F      ; =+5 [Branch if zero]
      JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
      INR   Y          ; [Increment Y by 1]
D934F RSR              ; [Return from subroutine]
*
* Function F9350
*
F9350 JSR/  F93E5      ; =0x93E5 =37861(-27675) [Jump to subroutine direct]
B9353 LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      BZ    D935D      ; =+5 [Branch if zero]
W9358 LDA/  W889B      ; =0x889B =34971(-30565) [Load A direct]
      BZ    D9369      ; =+12 [Branch if zero]
D935D JSR/  F981A      ; =0x981A =38938(-26598) [Jump to subroutine direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      CLA              ; [Clear A]
      STAB* B9353+1    ; =-17 [Store AL relative indirect]
      STA*  W9358+1    ; =-14 [Store A relative indirect]
      JMP   D9395      ; =+44 [Jump relative]
D9369 STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
      LDAB+ Y          ; [Load AL from address in Y]
      JSR/  F9984      ; =0x9984 =39300(-26236) [Jump to subroutine direct]
      STB/  W9FCF      ; =0x9FCF =40911(-24625) [Store B direct]
      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
      JSR/  F9984      ; =0x9984 =39300(-26236) [Jump to subroutine direct]
      STB/  W9FD1      ; =0x9FD1 =40913(-24623) [Store B direct]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      INA              ; [Increment A]
      INA              ; [Increment A]
      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
      SUB   B,A        ; [B - A -> A]
      LDB=  X'FF80'    ; =0xFF80 =65408(-128) [Load B with immediate]
      AAB              ; [A + B -> B]
      BNL   D9395      ; =+10 [Branch on no link]
      LDB=  X'0080'    ; =0x0080 =128 [Load B with immediate]
      AAB              ; [A + B -> B]
      BL    D9395      ; =+4 [Branch on link]
      JSR/  F983A      ; =0x983A =38970(-26566) [Jump to subroutine direct]
      CLAB             ; [Clear AL]
D9395 STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
* Function F9398
*
F9398 JSR   F93BB      ; =+33 [Jump to subroutine relative]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'D5'      ; =213(-43) ='U' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D93BA      ; =+25 [Branch if zero]
      LDBB= X'CC'      ; =204(-52) ='L' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D93AF      ; =+9 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      LDAB/ B889D      ; =0x889D =34973(-30563) [Load AL direct]
      BZ    D93BA      ; =+13 [Branch if zero]
      JMP   D93B7      ; =+8 [Jump relative]
D93AF LDAB/ B889D      ; =0x889D =34973(-30563) [Load AL direct]
      BNZ   D93B7      ; =+3 [Branch if not zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D93B7 LDAB+ Y          ; [Load AL from address in Y]
      INAB             ; [Increment AL]
      STAB+ Y          ; [Store AL to address in Y]
D93BA RSR              ; [Return from subroutine]
*
* Function F93BB
*
F93BB LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
      XFRB  BL,BU      ; [Transfer BL to BU]
      LDA=  S93DC      ; =0x93DC =37852(-27684) [Load A with immediate]
D93C2 LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
      BNZ   D93CF      ; =+9 [Branch if not zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      DCR   Z          ; [Decrement Z by 1]
      CLR   B          ; [Clear B]
      JMP   D93D9      ; =+10 [Jump relative]
D93CF SUBB  BU,BL      ; [BU - BL -> BL]
      BNZ   D93C2      ; =-17 [Branch if not zero]
      LDB=  S93DD      ; =0x93DD =37853(-27683) [Load B with immediate]
      SAB              ; [A - B -> B]
      SLR   B          ; [Left shift B by 1]
D93D9 STBB- Y-         ; [Store BL indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
S93DC DC    'A'        ; hex:C1 dec:193(-63)
S93DD DC    'BXYZSCP'  ; hex:C2D8D9DAD3C3D0
      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F93E5
*
F93E5 JSR/  F94BA      ; =0x94BA =38074(-27462) [Jump to subroutine direct]
      ZAD   -Y(16),-Y,14(2) ; [Zero-add bignum, indexed, displaced indexed]
      BNF   D93F9      ; =+9 [Branch on no fault]
      MVF   (14)-Y,-Y  ; [Move fixed-length, indexed, indexed]
      BZ    D93F9      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D93F9 INR   Y,14       ; [Increment Y by 14]
      RSR              ; [Return from subroutine]
*
* Function F93FC
*
F93FC STK   X,2        ; [Push X to the stack]
      XFRB  AU,BL      ; [Transfer AU to BL]
      SRRB  BL,2       ; [Right shift BL by 2]
      STBB  B9476+1    ; =+115 [Store BL relative]
      INA              ; [Increment A]
      BZ    D9408      ; =+1 [Branch if zero]
      DCA              ; [Decrement A]
D9408 XAX              ; [Transfer A to X]
      BZ    D9457      ; =+76 [Branch if zero]
      LDB=  X'0010'    ; =0x0010 =16 [Load B with immediate]
      SAB              ; [A - B -> B]
      BLE   D9417      ; =+6 [Branch if less than or equal to zero]
      JSR/  F976C      ; =0x976C =38764(-26772) [Jump to subroutine direct]
      POP   X,2        ; [Pop X from the stack]
      RSR              ; [Return from subroutine]
*
D9417 DCAB             ; [Decrement AL]
      LDBB= X'F0'      ; =240(-16) ='p' [Load BL with immediate]
      AABB             ; [AL + BL -> BL]
      STBB  B9423+1    ; =+7 [Store BL relative]
      JSR/  F94BA      ; =0x94BA =38074(-27462) [Jump to subroutine direct]
      LDB=  W9FAC      ; =0x9FAC =40876(-24660) [Load B with immediate]
B9423 ZAD   -Y(16),-B(2) ; [Zero-add bignum, indexed, indexed]
      BNF   D943F      ; =+22 [Branch on no fault]
      SUB=  X'0010',X,A ; =0x0010 =16 [16 - X -> A]
      DCA              ; [Decrement A]
      BM    D943F      ; =+15 [Branch on minus]
      MVFR  -Y,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
      BZ    D943F      ; =+10 [Branch if zero]
      CPFR  /W951C,-Y  ; =0x951C =38172(-27364), [Compare fixed-length (len in AL), direct, indexed]
      BZ    D943F      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D943F INR   Y,16       ; [Increment Y by 16]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   Y,A        ; [Transfer Y to A]
      DCA              ; [Decrement A]
      BNZ   D94AC      ; =+100 [Branch if not zero]
      LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      BNZ   D9452      ; =+5 [Branch if not zero]
      LDAB/ W889B      ; =0x889B =34971(-30565) [Load AL direct]
      BZ    D94AC      ; =+90 [Branch if zero]
D9452 JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D94AC      ; =+85 [Jump relative]
D9457 JSR/  F94BA      ; =0x94BA =38074(-27462) [Jump to subroutine direct]
      MVF   (16)-Y,/W9FAC ; =0x9FAC =40876(-24660) [Move fixed-length, indexed, direct]
      INR   Y,16       ; [Increment Y by 16]
      LDB=  W9FAC      ; =0x9FAC =40876(-24660) [Load B with immediate]
      LDX=  X'0010'    ; =0x0010 =16 [Load X with immediate]
      LDAB+ B          ; [Load AL from address in B]
      BP    D9482      ; =+23 [Branch on plus]
D946B LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      INAB             ; [Increment AL]
      BNZ   D9474      ; =+4 [Branch if not zero]
      DCX              ; [Decrement X]
      BGZ   D946B      ; =-8 [Branch if greater than zero]
      INX              ; [Increment X]
D9474 DCR   B          ; [Decrement B by 1]
B9476 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      BZ    D9496      ; =+28 [Branch if zero]
      LDAB+ B          ; [Load AL from address in B]
      BM    D9496      ; =+25 [Branch on minus]
      INX              ; [Increment X]
      DCR   B          ; [Decrement B by 1]
      JMP   D9496      ; =+20 [Jump relative]
D9482 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      BNZ   D948A      ; =+4 [Branch if not zero]
      DCX              ; [Decrement X]
      BGZ   D9482      ; =-7 [Branch if greater than zero]
      INX              ; [Increment X]
D948A DCR   B          ; [Decrement B by 1]
      LDAB  B9476+1    ; =-23 [Load AL relative]
      BZ    D9496      ; =+6 [Branch if zero]
      LDAB+ B          ; [Load AL from address in B]
      BP    D9496      ; =+3 [Branch on plus]
      INX              ; [Increment X]
      DCR   B          ; [Decrement B by 1]
D9496 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   X,A        ; [Transfer X to A]
      DCA              ; [Decrement A]
      BNZ   D94AC      ; =+15 [Branch if not zero]
      LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      BNZ   D94A7      ; =+5 [Branch if not zero]
      LDAB/ W889B      ; =0x889B =34971(-30565) [Load AL direct]
      BZ    D94AC      ; =+5 [Branch if zero]
D94A7 INX              ; [Increment X]
      DCR   B          ; [Decrement B by 1]
      STX+  S          ; [Store X indexed, direct]
D94AC LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      DCX              ; [Decrement X]
      BGZ   D94AC      ; =-7 [Branch if greater than zero]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      POP   X,2        ; [Pop X from the stack]
      RSR              ; [Return from subroutine]
*
* Function F94BA
*
F94BA JSR   F94E9      ; =+45 [Jump to subroutine relative]
D94BC LDA+  Z          ; [Load A from address in Z]
      LDB=  X'AECF'    ; =0xAECF =44751(-20785) ='.','O' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D94CF      ; =+12 [Branch if not zero]
      JSR   F94E1      ; =+28 [Jump to subroutine relative]
      ORC   (16)-Y,-Y,16 ; [OR bytes, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D94BC      ; =-19 [Jump relative]
D94CF LDB=  X'AED8'    ; =0xAED8 =44760(-20776) ='.','X' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D94E8      ; =+19 [Branch if not zero]
      JSR   F94E1      ; =+10 [Jump to subroutine relative]
      XRC   (16)-Y,-Y,16 ; [XOR bytes, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D94BC      ; =-37 [Jump relative]
*
* Function F94E1
*
F94E1 INR   Z          ; [Increment Z by 1]
      JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      JSR   F94E9      ; =+1 [Jump to subroutine relative]
D94E8 RSR              ; [Return from subroutine]
*
* Function F94E9
*
F94E9 JSR   F9504      ; =+25 [Jump to subroutine relative]
D94EB LDA+  Z          ; [Load A from address in Z]
      LDB=  X'AEC1'    ; =0xAEC1 =44737(-20799) ='.','A' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D9503      ; =+17 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      JSR   F9504      ; =+11 [Jump to subroutine relative]
      ANC   (16)-Y,-Y,16 ; [AND bytes, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D94EB      ; =-24 [Jump relative]
D9503 RSR              ; [Return from subroutine]
*
* Function F9504
*
F9504 LDA+  Z          ; [Load A from address in Z]
      LDB=  X'AECE'    ; =0xAECE =44750(-20786) ='.','N' [Load B with immediate]
      SAB              ; [A - B -> B]
      BNZ   D9519      ; =+14 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      JSR   F952C      ; =+26 [Jump to subroutine relative]
      XRC   (16)/W951C,-Y ; =0x951C =38172(-27364), [XOR bytes, direct, indexed]
      RSR              ; [Return from subroutine]
*
D9519 JSR   F952C      ; =+17 [Jump to subroutine relative]
      RSR              ; [Return from subroutine]
*
W951C DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
      DW    X'FFFF'    ; =0xFFFF =65535(-1)
*
* Function F952C
*
F952C LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D953B      ; =+8 [Branch if not zero]
      JSR   F956B      ; =+54 [Jump to subroutine relative]
      ZSU   -Y(16),-Y(16) ; [Zero-subtract bignum, indexed, indexed]
      JMP   D9544      ; =+9 [Jump relative]
D953B LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D9542      ; =+2 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
D9542 JSR   F956B      ; =+39 [Jump to subroutine relative]
D9544 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9557      ; =+12 [Branch if not zero]
      JSR   F956B      ; =+30 [Jump to subroutine relative]
      S     -Y(16),-Y,16(16) ; [Subtract bignums, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D9544      ; =-19 [Jump relative]
D9557 LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9568      ; =+12 [Branch if not zero]
      JSR   F956B      ; =+13 [Jump to subroutine relative]
      A     -Y(16),-Y,16(16) ; [Add bignums, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D9544      ; =-36 [Jump relative]
D9568 DCR   Z          ; [Decrement Z by 1]
      RSR              ; [Return from subroutine]
*
* Function F956B
*
F956B JSR   F95B7      ; =+74 [Jump to subroutine relative]
D956D LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9580      ; =+12 [Branch if not zero]
      JSR   F95B7      ; =+65 [Jump to subroutine relative]
      M     -Y(16),-Y,16(16) ; [Multiply bignums, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D956D      ; =-19 [Jump relative]
D9580 LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9591      ; =+12 [Branch if not zero]
      JSR   F95B7      ; =+48 [Jump to subroutine relative]
      D     -Y(16),-Y,16(16) ; [Divide bignums, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      JMP   D956D      ; =-36 [Jump relative]
D9591 LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D95B4      ; =+30 [Branch if not zero]
      LDAB+ Z          ; [Load AL from address in Z]
      LDBB= X'CD'      ; =205(-51) ='M' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D95B4      ; =+24 [Branch if not zero]
      JSR/  F9802      ; =0x9802 =38914(-26622) [Jump to subroutine direct]
      JSR   F95B7      ; =+22 [Jump to subroutine relative]
      LDA=  W9FAC      ; =0x9FAC =40876(-24660) [Load A with immediate]
      DRM   -Y(16),-Y,16(16) ; [Divide bignums with remainder, indexed, displaced indexed]
      INR   Y,16       ; [Increment Y by 16]
      MVF   (16)/W9FAC,-Y ; =0x9FAC =40876(-24660), [Move fixed-length, direct, indexed]
      JMP   D956D      ; =-71 [Jump relative]
D95B4 DCR   Z          ; [Decrement Z by 1]
      RSR              ; [Return from subroutine]
*
* Function F95B7
*
F95B7 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'A8'      ; =168(-88) ='(' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D95C6      ; =+8 [Branch if not zero]
      JSR/  F94BA      ; =0x94BA =38074(-27462) [Jump to subroutine direct]
      JSR/  F97F6      ; =0x97F6 =38902(-26634) [Jump to subroutine direct]
      DC    ')'        ; hex:A9 dec:169(-87)
      RSR              ; [Return from subroutine]
*
D95C6 DCR   Y,16       ; [Decrement Y by 16]
      FIL   (16)=X'00',-Y ; [Fill with byte, literal=0, indexed]
      JSR/  F97D7      ; =0x97D7 =38871(-26665) [Jump to subroutine direct]
      BM    D95D8      ; =+6 [Branch on minus]
      DCR   Z          ; [Decrement Z by 1]
      JSR/  F970E      ; =0x970E =38670(-26866) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D95D8 LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      XFRB  BL,BU      ; [Transfer BL to BU]
      SABB             ; [AL - BL -> BL]
      BZ    D9602      ; =+35 [Branch if zero]
      LDBB+ Z          ; [Load BL from address in Z]
      SUBB  BU,BL      ; [BU - BL -> BL]
      BNZ   D960A      ; =+38 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
      LDBB= X'D8'      ; =216(-40) ='X' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D95F0      ; =+5 [Branch if not zero]
      JSR/  F96EA      ; =0x96EA =38634(-26902) [Jump to subroutine direct]
      JMP   D9605      ; =+21 [Jump relative]
D95F0 LDBB= X'C2'      ; =194(-62) ='B' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D95FA      ; =+5 [Branch if not zero]
      JSR/  F96CC      ; =0x96CC =38604(-26932) [Jump to subroutine direct]
      JMP   D9605      ; =+11 [Jump relative]
D95FA LDBB= X'C3'      ; =195(-61) ='C' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D9602      ; =+3 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D9602 JSR/  F9728      ; =0x9728 =38696(-26840) [Jump to subroutine direct]
D9605 JSR/  F97F6      ; =0x97F6 =38902(-26634) [Jump to subroutine direct]
      DB    X'A7'      ; =0xA7 =167(-89) ='
      RSR              ; [Return from subroutine]
*
D960A DCR   Z          ; [Decrement Z by 1]
      JSR   F960F      ; =+1 [Jump to subroutine relative]
      RSR              ; [Return from subroutine]
*
* Function F960F
*
F960F LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D961E      ; =+8 [Branch if not zero]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      STA+  Y,14       ; [Store A indexed, displaced, direct]
      JMP   D9657      ; =+57 [Jump relative]
D961E DCR   Z          ; [Decrement Z by 1]
      JSR/  F97E3      ; =0x97E3 =38883(-26653) [Jump to subroutine direct]
      BP    D9629      ; =+4 [Branch on plus]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D9629 JSR   F965F      ; =+52 [Jump to subroutine relative]
      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
      LDA+  B,3        ; [Load A indexed, displaced, direct]
      STA+  Y,14       ; [Store A indexed, displaced, direct]
      LDA+  B,2        ; [Load A indexed, displaced, direct]
      LDAB= X'20'      ; =32 [Load AL with immediate]
      ORIB  AU,AL      ; [AU | AL -> AL]
      STAB+ B,2        ; [Store AL indexed, displaced, direct]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      ANDB  AU,AL      ; [AU & AL -> AL]
      BNZ   D9647      ; =+4 [Branch if not zero]
      JSR/  F984E      ; =0x984E =38990(-26546) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
D9647 LDAB= X'10'      ; =16 [Load AL with immediate]
      ANDB  AU,AL      ; [AU & AL -> AL]
      BZ    D9650      ; =+3 [Branch if zero]
      STB/  W889B      ; =0x889B =34971(-30565) [Store B direct]
D9650 LDAB= X'04'      ; =4 [Load AL with immediate]
      ANDB  AU,AL      ; [AU & AL -> AL]
      BNZ   D9657      ; =+1 [Branch if not zero]
      RSR              ; [Return from subroutine]
*
D9657 LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      IVAB             ; [Invert AL]
      STAB/ B8899      ; =0x8899 =34969(-30567) [Store AL direct]
      RSR              ; [Return from subroutine]
*
* Function F965F
*
F965F XFR   Z,A        ; [Transfer Z to A]
      STA   W96C5      ; =+98 [Store A relative]
D9663 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F97EF      ; =0x97EF =38895(-26641) [Jump to subroutine direct]
      BP    D9663      ; =-7 [Branch on plus]
      DCR   Z          ; [Decrement Z by 1]
      LDA   W96C5      ; =+87 [Load A relative]
      SUB   Z,A        ; [Z - A -> A]
      STA   W96C7      ; =+85 [Store A relative]
      JSR   F96C1      ; =+77 [Jump to subroutine relative]
      DW    W8786      ; =0x8786 =34694(-30842)
      LDA   W96C9      ; =+81 [Load A relative]
      BNZ   D9690      ; =+22 [Branch if not zero]
      JSR   F96C1      ; =+69 [Jump to subroutine relative]
      DW    W8730      ; =0x8730 =34608(-30928)
      LDA   W96C9      ; =+73 [Load A relative]
      BNZ   D9688      ; =+6 [Branch if not zero]
      JSR/  F9828      ; =0x9828 =38952(-26584) [Jump to subroutine direct]
      LDA=  W8894      ; =0x8894 =34964(-30572) [Load A with immediate]
D9688 CLR   B          ; [Clear B]
      STB+  A,3        ; [Store B indexed, displaced, direct]
      STBB+ A,2        ; [Store BL indexed, displaced, direct]
D9690 STA-  Y-         ; [Store A indexed, pre-decremented, direct]
      LDAB/ B8891      ; =0x8891 =34961(-30575) [Load AL direct]
      BNZ   D969C      ; =+5 [Branch if not zero]
      LDAB/ B8890      ; =0x8890 =34960(-30576) [Load AL direct]
      BNZ   D969D      ; =+1 [Branch if not zero]
D969C RSR              ; [Return from subroutine]
*
D969D STA   W96BB      ; =+28 [Store A relative]
      STB   W96BD      ; =+28 [Store B relative]
      XFR   Y,A        ; [Transfer Y to A]
      STA   W96BF      ; =+26 [Store A relative]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      LDB=  W86C3      ; =0x86C3 =34499(-31037) [Load B with immediate]
      STA+  B+         ; [Store A indexed, direct, post-incremented]
      LDA   W96C9      ; =+26 [Load A relative]
      STA+  B          ; [Store A to address in B]
      JSR/  F81CD      ; =0x81CD =33229(-32307) [Jump to subroutine direct]
      LDA   W96BF      ; =+10 [Load A relative]
      XAY              ; [Transfer A to Y]
      LDA   W96BB      ; =+3 [Load A relative]
      LDB   W96BD      ; =+3 [Load B relative]
      RSR              ; [Return from subroutine]
*
W96BB DS    2          ; =0x0002 [Uninitialized memory]
W96BD DS    2          ; =0x0002 [Uninitialized memory]
W96BF DS    2          ; =0x0002 [Uninitialized memory]
*
* Function F96C1
*
F96C1 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      JSR+  A          ; [Jump to subroutine indexed, direct]
W96C5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W96C7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W96C9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      RSR              ; [Return from subroutine]
*
* Function F96CC
*
F96CC STK   Z,2        ; [Push Z to the stack]
D96CE LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D96CE      ; =-7 [Branch if zero]
      DCRB  BL         ; [Decrement BL by 1]
      BZ    D96CE      ; =-11 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      LDA+  S          ; [Load A from address in S]
      SUB   Z,A        ; [Z - A -> A]
      LDB+  S+         ; [Load B indexed, direct, post-incremented]
      CTB   -B(2),-Y(16) ; [Convert to bignum, indexed, indexed]
      BNF   D96E9      ; =+3 [Branch on no fault]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D96E9 RSR              ; [Return from subroutine]
*
* Function F96EA
*
F96EA STK   Z,2        ; [Push Z to the stack]
D96EC LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F97D7      ; =0x97D7 =38871(-26665) [Jump to subroutine direct]
      BP    D96EC      ; =-7 [Branch on plus]
      LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BGZ   D96FD      ; =+5 [Branch if greater than zero]
      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BP    D96EC      ; =-17 [Branch on plus]
D96FD DCR   Z          ; [Decrement Z by 1]
      LDA+  S          ; [Load A from address in S]
      SUB   Z,A        ; [Z - A -> A]
      LDB+  S+         ; [Load B indexed, direct, post-incremented]
      CTB   -B(16),-Y(16) ; [Convert to bignum, indexed, indexed]
      BNF   D970D      ; =+3 [Branch on no fault]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D970D RSR              ; [Return from subroutine]
*
* Function F970E
*
F970E STK   Z,2        ; [Push Z to the stack]
D9710 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F97D7      ; =0x97D7 =38871(-26665) [Jump to subroutine direct]
      BP    D9710      ; =-7 [Branch on plus]
      DCR   Z          ; [Decrement Z by 1]
      LDA+  S          ; [Load A from address in S]
      SUB   Z,A        ; [Z - A -> A]
      LDB+  S+         ; [Load B indexed, direct, post-incremented]
      CTB   -B(10),-Y(16) ; [Convert to bignum, indexed, indexed]
      BNF   D9727      ; =+3 [Branch on no fault]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
D9727 RSR              ; [Return from subroutine]
*
* Function F9728
*
F9728 STK   X,2        ; [Push X to the stack]
      LDX=  W9FAC      ; =0x9FAC =40876(-24660) [Load X with immediate]
      FIL   (16)=X'00',-X ; [Fill with byte, literal=0, indexed]
      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
      STAB/ B9FBC      ; =0x9FBC =40892(-24644) [Store AL direct]
D9737 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9744      ; =+6 [Branch if not zero]
      LDBB+ Z          ; [Load BL from address in Z]
      SABB             ; [AL - BL -> BL]
      BNZ   D9755      ; =+19 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
D9744 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D9755      ; =+12 [Branch if zero]
      LDBB+ X          ; [Load BL from address in X]
      BZ    D9751      ; =+5 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D9755      ; =+4 [Jump relative]
D9751 STAB+ X+         ; [Store AL indexed, direct, post-incremented]
      JMP   D9737      ; =-30 [Jump relative]
D9755 DCR   Z          ; [Decrement Z by 1]
      LDA=  W9FAC      ; =0x9FAC =40876(-24660) [Load A with immediate]
      SUB   X,A        ; [X - A -> A]
      DCA              ; [Decrement A]
      XAB              ; [Transfer A to B]
      DCR   B,16       ; [Decrement B by 16]
      IVR   B          ; [Invert B]
      ADD   Y,B        ; [Y + B -> B]
      MVFR  /W9FAC,-B  ; =0x9FAC =40876(-24660), [Move fixed-length (len in AL), direct, indexed]
      POP   X,2        ; [Pop X from the stack]
      RSR              ; [Return from subroutine]
*
* Function F976C
*
F976C STAB- S-         ; [Store AL indexed, pre-decremented, direct]
      STK   Y,2        ; [Push Y to the stack]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D978A      ; =+19 [Branch if zero]
      XFRB  AL,AU      ; [Transfer AL to AU]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDB=  X'C3A7'    ; =0xC3A7 =50087(-15449) ='C',' [Load B with immediate]
      SAB              ; [A - B -> B]
      BZ    D978A      ; =+9 [Branch if zero]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      INR   S,3        ; [Increment S by 3]
      CLAB             ; [Clear AL]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
D978A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9797      ; =+6 [Branch if not zero]
      LDBB+ Z          ; [Load BL from address in Z]
      SABB             ; [AL - BL -> BL]
      BNZ   D97A0      ; =+11 [Branch if not zero]
      INR   Z          ; [Increment Z by 1]
D9797 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D97A0      ; =+4 [Branch if zero]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JMP   D978A      ; =-22 [Jump relative]
D97A0 LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XFR   Y,B        ; [Transfer Y to B]
      SAB              ; [A - B -> B]
      CLA              ; [Clear A]
      LDAB+ S          ; [Load AL from address in S]
      SUB   B,A        ; [B - A -> A]
      BZ    D97D2      ; =+39 [Branch if zero]
      BM    D97B4      ; =+7 [Branch on minus]
      ADD   A,Y        ; [A + Y -> Y]
      JSR/  F9848      ; =0x9848 =38984(-26552) [Jump to subroutine direct]
      JMP   D97D2      ; =+30 [Jump relative]
D97B4 STK   X,2        ; [Push X to the stack]
      XFR   Y,X        ; [Transfer Y to X]
      ADD   A,X        ; [A + X -> X]
      STK   X,2        ; [Push X to the stack]
      IVAB             ; [Invert AL]
      XFRB  BL,AU      ; [Transfer BL to AU]
D97BF LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
      STBB+ X+         ; [Store BL indexed, direct, post-incremented]
      DCRB  AU         ; [Decrement AU by 1]
      BGZ   D97BF      ; =-8 [Branch if greater than zero]
      CLRB  BL         ; [Clear BL]
D97C9 STBB+ X+         ; [Store BL indexed, direct, post-incremented]
      DCAB             ; [Decrement AL]
      BP    D97C9      ; =-5 [Branch on plus]
      POP   Y,2        ; [Pop Y from the stack]
      POP   X,2        ; [Pop X from the stack]
D97D2 LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      RSR              ; [Return from subroutine]
*
* Function F97D7
*
F97D7 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BLE   D97DF      ; =+3 [Branch if less than or equal to zero]
      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
      RSR              ; [Return from subroutine]
*
D97DF LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      RSR              ; [Return from subroutine]
*
* Function F97E3
*
F97E3 LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BLE   D97EB      ; =+3 [Branch if less than or equal to zero]
      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
      RSR              ; [Return from subroutine]
*
D97EB LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      RSR              ; [Return from subroutine]
*
* Function F97EF
*
F97EF JSR   F97E3      ; =-14 [Jump to subroutine relative]
      BP    D97F5      ; =+2 [Branch on plus]
      JSR   F97D7      ; =-30 [Jump to subroutine relative]
D97F5 RSR              ; [Return from subroutine]
*
* Function F97F6
*
F97F6 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
      SABB             ; [AL - BL -> BL]
      BZ    D9801      ; =+4 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      JSR   F9848      ; =+71 [Jump to subroutine relative]
D9801 RSR              ; [Return from subroutine]
*
* Function F9802
*
F9802 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BZ    D980F      ; =+6 [Branch if zero]
      JSR   F97E3      ; =-40 [Jump to subroutine relative]
      BP    F9802      ; =-11 [Branch on plus]
      DCR   Z          ; [Decrement Z by 1]
D980F RSR              ; [Return from subroutine]
*
* Function F9810
*
F9810 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
D9812 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
      SABB             ; [AL - BL -> BL]
      BZ    D9812      ; =-5 [Branch if zero]
      DCR   Z          ; [Decrement Z by 1]
      RSR              ; [Return from subroutine]
*
* Function F981A
*
F981A LDAB/ B9FD4      ; =0x9FD4 =40916(-24620) [Load AL direct]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D985E      ; =+60 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
      JMP   D9852      ; =+42 [Jump relative]
*
* Function F9828
*
F9828 LDBB= X'02'      ; =2 [Load BL with immediate]
      LDAB= X'C6'      ; =198(-58) ='F' [Load AL with immediate]
      JMP   D9852      ; =+36 [Jump relative]
*
* Function F982E
*
F982E LDBB= X'02'      ; =2 [Load BL with immediate]
      LDAB= X'CD'      ; =205(-51) ='M' [Load AL with immediate]
      JMP   D9852      ; =+30 [Jump relative]
*
* Function F9834
*
F9834 LDBB= X'02'      ; =2 [Load BL with immediate]
      LDAB= X'CF'      ; =207(-49) ='O' [Load AL with immediate]
      JMP   D9852      ; =+24 [Jump relative]
*
* Function F983A
*
F983A LDAB/ B9FD4      ; =0x9FD4 =40916(-24620) [Load AL direct]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D985E      ; =+28 [Branch if not zero]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      LDAB= X'D2'      ; =210(-46) ='R' [Load AL with immediate]
      JMP   D9852      ; =+10 [Jump relative]
*
* Function F9848
*
F9848 LDBB= X'01'      ; =1 [Load BL with immediate]
      LDAB= X'D3'      ; =211(-45) ='S' [Load AL with immediate]
      JMP   D9852      ; =+4 [Jump relative]
*
* Function F984E
*
F984E LDBB= X'01'      ; =1 [Load BL with immediate]
      LDAB= X'D5'      ; =213(-43) ='U' [Load AL with immediate]
D9852 STAB/ B9FD4      ; =0x9FD4 =40916(-24620) [Store AL direct]
      STBB  B985F      ; =+8 [Store BL relative]
      LDA/  W826D      ; =0x826D =33389(-32147) [Load A direct]
      INA              ; [Increment A]
      STA/  W826D      ; =0x826D =33389(-32147) [Store A direct]
D985E RSR              ; [Return from subroutine]
*
B985F DB    X'00'      ; =0x00 =0 =NUL
*
* Function F9860
*
F9860 JSR/  F9918      ; =0x9918 =39192(-26344) [Jump to subroutine direct]
      LDAB  B985F      ; =-6 [Load AL relative]
      DCAB             ; [Decrement AL]
      BGZ   D9880      ; =+24 [Branch if greater than zero]
      LDAB/ B8890      ; =0x8890 =34960(-30576) [Load AL direct]
      BNZ   D9880      ; =+19 [Branch if not zero]
      LDB+  Y,2        ; [Load B indexed, displaced, direct]
      BZ    D987F      ; =+13 [Branch if zero]
      LDA+  Y          ; [Load A from address in Y]
      BLE   D9878      ; =+3 [Branch if less than or equal to zero]
      JSR/  F827C      ; =0x827C =33404(-32132) [Jump to subroutine direct]
D9878 LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      AAB              ; [A + B -> B]
      STB/  W889E      ; =0x889E =34974(-30562) [Store B direct]
D987F RSR              ; [Return from subroutine]
*
D9880 JSR   F9892      ; =+16 [Jump to subroutine relative]
      JSR/  F99C1      ; =0x99C1 =39361(-26175) [Jump to subroutine direct]
      LDA+  Y,2        ; [Load A indexed, displaced, direct]
      DCA              ; [Decrement A]
      BLE   D987F      ; =-12 [Branch if less than or equal to zero]
      LDB=  X'FFFE'    ; =0xFFFE =65534(-2) [Load B with immediate]
      JSR/  F9AC0      ; =0x9AC0 =39616(-25920) [Jump to subroutine direct]
      RSR              ; [Return from subroutine]
*
* Function F9892
*
F9892 XFR   Z,A        ; [Transfer Z to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      XFR   Y,A        ; [Transfer Y to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDAB/ B88A0      ; =0x88A0 =34976(-30560) [Load AL direct]
      BNZ   D98A4      ; =+3 [Branch if not zero]
      JSR/  F996A      ; =0x996A =39274(-26262) [Jump to subroutine direct]
D98A4 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      BLE   D98AA      ; =+2 [Branch if less than or equal to zero]
      JSR   F98C9      ; =+31 [Jump to subroutine relative]
D98AA LDX+  Y+         ; [Load X indexed, direct, post-incremented]
      ADD   X,Y        ; [X + Y -> Y]
W98AE LDB=  X'0007'    ; =0x0007 =7 [Load B with immediate]
      SUB   X,B        ; [X - B -> B]
      BLE   D98B9      ; =+4 [Branch if less than or equal to zero]
      JSR   F98C9      ; =+18 [Jump to subroutine relative]
      LDX   W98AE+1    ; =-10 [Load X relative]
D98B9 LDA=  W9FC4      ; =0x9FC4 =40900(-24636) [Load A with immediate]
      XAZ              ; [Transfer A to Z]
D98BD DCX              ; [Decrement X]
      BM    D98CF      ; =+15 [Branch on minus]
      LDAB- Y-         ; [Load AL indexed, pre-decremented, direct]
      JSR/  F9984      ; =0x9984 =39300(-26236) [Jump to subroutine direct]
      STB+  Z+         ; [Store B indexed, direct, post-incremented]
      JMP   D98BD      ; =-12 [Jump relative]
*
* Function F98C9
*
F98C9 LDAB= X'AB'      ; =171(-85) ='+' [Load AL with immediate]
      STAB/ B9FD2      ; =0x9FD2 =40914(-24622) [Store AL direct]
      RSR              ; [Return from subroutine]
*
D98CF LDA=  W990E      ; =0x990E =39182(-26354) [Load A with immediate]
      XAY              ; [Transfer A to Y]
      LDA=  F88B1      ; =0x88B1 =34993(-30543) [Load A with immediate]
      XAZ              ; [Transfer A to Z]
D98D7 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
      BZ    D9902      ; =+39 [Branch if zero]
      STB   W98F8      ; =+27 [Store B relative]
      LDA=  WA044      ; =0xA044 =41028(-24508) [Load A with immediate]
      SAB              ; [A - B -> B]
      STB-  S-         ; [Store B indexed, pre-decremented, direct]
      LDB-  Z-         ; [Load B indexed, pre-decremented, direct]
      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
      BZ    D98FE      ; =+21 [Branch if zero]
      STA   W98FA      ; =+15 [Store A relative]
      SUB   B,A        ; [B - A -> A]
      LDB+  S          ; [Load B from address in S]
      SAB              ; [A - B -> B]
      BGZ   D98F2      ; =+1 [Branch if greater than zero]
      STA+  S          ; [Store A to address in S]
D98F2 LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAB              ; [Transfer A to B]
      JSR/  FA332      ; =0xA332 =41778(-23758) [Jump to subroutine direct]
W98F8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W98FA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      JMP   D98D7      ; =-39 [Jump relative]
D98FE LDA+  S+         ; [Load A indexed, direct, post-incremented]
      JMP   D98D7      ; =-43 [Jump relative]
D9902 JSR/  F9C0E      ; =0x9C0E =39950(-25586) [Jump to subroutine direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAZ              ; [Transfer A to Z]
      RSR              ; [Return from subroutine]
*
W990E DW    WA002      ; =0xA002 =40962(-24574)
      DW    W9FE6      ; =0x9FE6 =40934(-24602)
      DW    W9FDF      ; =0x9FDF =40927(-24609)
      DW    W9FD6      ; =0x9FD6 =40918(-24618)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F9918
*
F9918 XFR   Y,A        ; [Transfer Y to A]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      ADD   A,Y        ; [A + Y -> Y]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
      BZ    D995A      ; =+50 [Branch if zero]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XAX              ; [Transfer A to X]
      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDB+  A,2        ; [Load B indexed, displaced, direct]
      LDBB= X'10'      ; =16 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BNZ   D9945      ; =+15 [Branch if not zero]
      LDBB= X'02'      ; =2 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      BNZ   D994A      ; =+14 [Branch if not zero]
      LDB+  A,3        ; [Load B indexed, displaced, direct]
      BZ    D994A      ; =+9 [Branch if zero]
      SUB   X,B        ; [X - B -> B]
      BZ    D994A      ; =+5 [Branch if zero]
D9945 JSR/  F982E      ; =0x982E =38958(-26578) [Jump to subroutine direct]
      JMP   D9958      ; =+14 [Jump relative]
D994A STX+  A,3        ; [Store X indexed, displaced, direct]
      LDB+  A,2        ; [Load B indexed, displaced, direct]
      LDBB/ B889A      ; =0x889A =34970(-30566) [Load BL direct]
      ORIB  BU,BL      ; [BU | BL -> BL]
      STBB+ A,2        ; [Store BL indexed, displaced, direct]
D9958 LDX+  S+         ; [Load X indexed, direct, post-incremented]
D995A LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
      RSR              ; [Return from subroutine]
*
* Function F995E
*
F995E LDA+  Y          ; [Load A from address in Y]
      LDB=  W9FCF      ; =0x9FCF =40911(-24625) [Load B with immediate]
      JSR   F9973      ; =+15 [Jump to subroutine relative]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      STAB/ B88A0      ; =0x88A0 =34976(-30560) [Store AL direct]
      RSR              ; [Return from subroutine]
*
* Function F996A
*
F996A LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      LDB=  W9FBF      ; =0x9FBF =40895(-24641) [Load B with immediate]
      JSR   F9973      ; =+1 [Jump to subroutine relative]
      RSR              ; [Return from subroutine]
*
* Function F9973
*
F9973 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   B,X        ; [Transfer B to X]
      JSR   F9984      ; =+11 [Jump to subroutine relative]
      STB+  X,2        ; [Store B indexed, displaced, direct]
      XFRB  AU,AL      ; [Transfer AU to AL]
      JSR   F9984      ; =+4 [Jump to subroutine relative]
      STB+  X          ; [Store B to address in X]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F9984
*
F9984 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
      SRRB  AL,4       ; [Right shift AL by 4]
      JSR   F998E      ; =+4 [Jump to subroutine relative]
      XFRB  BL,BU      ; [Transfer BL to BU]
      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
*
* Function F998E
*
F998E LDBB= X'0F'      ; =15 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
      LDAB= X'09'      ; =9 [Load AL with immediate]
      SUBB  BL,AL      ; [BL - AL -> AL]
      BLE   D999D      ; =+4 [Branch if less than or equal to zero]
      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
      JMP   D999F      ; =+2 [Jump relative]
D999D LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
D999F ORIB  AL,BL      ; [AL | BL -> BL]
      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F99A4
*
F99A4 STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
      AAB              ; [A + B -> B]
      CLA              ; [Clear A]
      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      STB   W99BC      ; =+13 [Store B relative]
      XAB              ; [Transfer A to B]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STA   W99BA      ; =+6 [Store A relative]
      LDA=  X'0006'    ; =0x0006 =6 [Load A with immediate]
      JSR/  FA332      ; =0xA332 =41778(-23758) [Jump to subroutine direct]
W99BA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W99BC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      LDA+  S+         ; [Load A indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F99C1
*
F99C1 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   Y,X        ; [Transfer Y to X]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
D99C9 JSR   F99D0      ; =+5 [Jump to subroutine relative]
      DCX              ; [Decrement X]
      BGZ   D99C9      ; =-5 [Branch if greater than zero]
      JMP   D9A05      ; =+53 [Jump relative]
*
* Function F99D0
*
F99D0 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   Y,X        ; [Transfer Y to X]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
      ADD   X,Y        ; [X + Y -> Y]
D99DA DCX              ; [Decrement X]
      BM    D9A05      ; =+40 [Branch on minus]
      CLA              ; [Clear A]
      LDAB  B9A22      ; =+66 [Load AL relative]
      LDB=  X'0078'    ; =0x0078 =120 [Load B with immediate]
      SAB              ; [A - B -> B]
      BM    D99E8      ; =+2 [Branch on minus]
D99E6 JSR   F9A0B      ; =+35 [Jump to subroutine relative]
D99E8 LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      LDB   W9A1F      ; =+50 [Load B relative]
      SAB              ; [A - B -> B]
      BNZ   D99E6      ; =-10 [Branch if not zero]
      INA              ; [Increment A]
      STA/  W889E      ; =0x889E =34974(-30562) [Store A direct]
      STA   W9A1F      ; =+41 [Store A relative]
      CLA              ; [Clear A]
      LDAB  B9A22      ; =+41 [Load AL relative]
      INA              ; [Increment A]
      STAB  B9A22      ; =+38 [Store AL relative]
      LDB=  W9A24      ; =0x9A24 =39460(-26076) [Load B with immediate]
      AAB              ; [A + B -> B]
      LDAB- Y-         ; [Load AL indexed, pre-decremented, direct]
      STAB+ B          ; [Store AL to address in B]
      JMP   D99DA      ; =-43 [Jump relative]
D9A05 LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
* Function F9A0B
*
F9A0B LDAB  B9A22      ; =+21 [Load AL relative]
      BZ    D9A14      ; =+5 [Branch if zero]
      JSR/  F9A9D      ; =0x9A9D =39581(-25955) [Jump to subroutine direct]
      DW    W9A21      ; =0x9A21 =39457(-26079)
D9A14 LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      STA   W9A1F      ; =+6 [Store A relative]
      STA   W9A23      ; =+8 [Store A relative]
      CLAB             ; [Clear AL]
      STAB  B9A22      ; =+4 [Store AL relative]
      RSR              ; [Return from subroutine]
*
W9A1F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W9A21 DB    X'00'      ; =0x00 =0 =NUL
B9A22 DB    X'00'      ; =0x00 =0 =NUL
W9A23 DB    X'00'      ; =0x00 =0 =NUL
W9A24 DB    X'00'      ; =0x00 =0 =NUL
      DS    120        ; =0x0078 [Uninitialized memory]
*
* Function F9A9D
*
F9A9D LDA+  X+         ; [Load A indexed, direct, post-incremented]
      LDBB/ B8890      ; =0x8890 =34960(-30576) [Load BL direct]
      BZ    D9AA7      ; =+3 [Branch if zero]
      JSR/  F81BF      ; =0x81BF =33215(-32321) [Jump to subroutine direct]
D9AA7 RSR              ; [Return from subroutine]
*
W9AA8 DW    X'020D'    ; =0x020D =525
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W9AAC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
W9AAE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
B9AB0 DB    X'00'      ; =0x00 =0 =NUL
W9AB1 DS    6          ; =0x0006 [Uninitialized memory]
W9AB7 DS    2          ; =0x0002 [Uninitialized memory]
*
* Function F9AB9
*
F9AB9 STAB  B9AB0      ; =-11 [Store AL relative]
      JSR   F9A9D      ; =-32 [Jump to subroutine relative]
      DW    W9AA8      ; =0x9AA8 =39592(-25944)
      RSR              ; [Return from subroutine]
*
* Function F9AC0
*
F9AC0 STB   W9AEF+1    ; =+46 [Store B relative]
      LDA/  W889B      ; =0x889B =34971(-30565) [Load A direct]
      BNZ   D9AF7      ; =+48 [Branch if not zero]
      LDAB/ B8899      ; =0x8899 =34969(-30567) [Load AL direct]
      BZ    D9AF6      ; =+42 [Branch if zero]
      CLA              ; [Clear A]
      LDAB  S9B17      ; =+72 [Load AL relative]
      LDB=  X'0076'    ; =0x0076 =118 [Load B with immediate]
      SAB              ; [A - B -> B]
      BLE   D9AE1      ; =+12 [Branch if less than or equal to zero]
      JSR   F9B09      ; =+50 [Jump to subroutine relative]
      DW    W9B92      ; =0x9B92 =39826(-25710)
      MVF   (124)/W9B16,/W9B92 ; =0x9B16 =39702(-25834),=0x9B92 =39826(-25710) [Move fixed-length, direct, direct]
      CLA              ; [Clear A]
D9AE1 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX=  W9B1A      ; =0x9B1A =39706(-25830) [Load X with immediate]
      ADD   A,X        ; [A + X -> X]
      INR   A,2        ; [Increment A by 2]
      STAB  S9B17      ; =+43 [Store AL relative]
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
W9AEF LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
      AAB              ; [A + B -> B]
      STB+  X          ; [Store B to address in X]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
D9AF6 RSR              ; [Return from subroutine]
*
D9AF7 JSR/  F99A4      ; =0x99A4 =39332(-26204) [Jump to subroutine direct]
      DW    W9AB1      ; =0x9AB1 =39601(-25935)
      LDA/  W889E      ; =0x889E =34974(-30562) [Load A direct]
      LDB   W9AEF+1    ; =-17 [Load B relative]
      AAB              ; [A + B -> B]
      STB   W9AAC      ; =-88 [Store B relative]
      LDAB= X'02'      ; =2 [Load AL with immediate]
      JSR   F9AB9      ; =-79 [Jump to subroutine relative]
      RSR              ; [Return from subroutine]
*
* Function F9B09
*
F9B09 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STA   W9B13      ; =+6 [Store A relative]
      INA              ; [Increment A]
      LDBB+ A          ; [Load BL from address in A]
      BZ    D9B15      ; =+4 [Branch if zero]
      JSR   F9A9D      ; =-118 [Jump to subroutine relative]
W9B13 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
D9B15 RSR              ; [Return from subroutine]
*
W9B16 DB    X'01'      ; =0x01 =1
S9B17 DB    0,3        ; =0x00,0x0003
W9B1A DS    120        ; =0x0078 [Uninitialized memory]
W9B92 DB    X'01'      ; =0x01 =1
S9B93 DB    0,3        ; =0x00,0x0003
      DS    120        ; =0x0078 [Uninitialized memory]
*
* Function F9C0E
*
F9C0E LDAB/ B985F      ; =0x985F =39007(-26529) [Load AL direct]
      BNZ   D9C38      ; =+37 [Branch if not zero]
      LDAB/ B8892      ; =0x8892 =34962(-30574) [Load AL direct]
      BNZ   D9C25      ; =+13 [Branch if not zero]
      LDAB/ B8893      ; =0x8893 =34963(-30573) [Load AL direct]
      BZ    D9C37      ; =+26 [Branch if zero]
      LDAB/ W9FD6      ; =0x9FD6 =40918(-24618) [Load AL direct]
      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BNZ   D9C37      ; =+18 [Branch if not zero]
D9C25 JSR/  F81F6      ; =0x81F6 =33270(-32266) [Jump to subroutine direct]
      DW    W9FBD      ; =0x9FBD =40893(-24643)
*
* Function F9C2A
*
F9C2A LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
      LDB=  W9FBD      ; =0x9FBD =40893(-24643) [Load B with immediate]
      STA+  B+         ; [Store A indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      FILR  =' ',-B    ; [Fill with byte (len in AL), literal=0xA0(160,-96), indexed]
D9C37 RSR              ; [Return from subroutine]
*
D9C38 MVF   (1)=X'50',/W9FBE ; =0x9FBE =40894(-24642) [Move fixed-length, literal=80, direct]
      LDB=  W9C4F      ; =0x9C4F =40015(-25521) [Load B with immediate]
      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
      DW    W9C4F      ; =0x9C4F =40015(-25521) [TODO: arg 1]
      MVF   (1)=X'84',/W9FBE ; =0x9FBE =40894(-24642) [Move fixed-length, literal=132(-124), direct]
      JMP   D9C25      ; =-42 [Jump relative]
W9C4F DW    X'0082'    ; =0x0082 =130
      DB    X'00'      ; =0x00 =0 =NUL
      DW    X'0200'    ; =0x0200 =512
      DB    X'50'      ; =0x50 =80
      DW    W9FBD      ; =0x9FBD =40893(-24643)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F9C59
*
F9C59 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F97E3      ; =0x97E3 =38883(-26653) [Jump to subroutine direct]
      BM    D9C93      ; =+49 [Branch on minus]
      CLRB  BU         ; [Clear BU]
      SLR   B          ; [Left shift B by 1]
      LDA=  S9C9B      ; =0x9C9B =40091(-25445) [Load A with immediate]
      AAB              ; [A + B -> B]
      LDA+  B          ; [Load A from address in B]
      BZ    D9C93      ; =+38 [Branch if zero]
      XAX              ; [Transfer A to X]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      XFRB  AL,AU      ; [Transfer AL to AU]
      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
      JSR/  F97EF      ; =0x97EF =38895(-26641) [Jump to subroutine direct]
      BP    D9C7D      ; =+4 [Branch on plus]
      DCR   Z          ; [Decrement Z by 1]
      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
D9C7D LDBB+ X          ; [Load BL from address in X]
      BZ    D9C93      ; =+19 [Branch if zero]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      SAB              ; [A - B -> B]
      BZ    D9C89      ; =+4 [Branch if zero]
      INX              ; [Increment X]
      INX              ; [Increment X]
      JMP   D9C7D      ; =-12 [Jump relative]
D9C89 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      STAB- Y-         ; [Store AL indexed, pre-decremented, direct]
      JMP   D9C98      ; =+5 [Jump relative]
D9C93 LDA=  X'FFFF'    ; =0xFFFF =65535(-1) [Load A with immediate]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
D9C98 LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
S9C9B DB    0,6        ; =0x00,0x0006
      DW    S9CD5      ; =0x9CD5 =40149(-25387)
      DW    S9CEA      ; =0x9CEA =40170(-25366)
      DW    S9D2F      ; =0x9D2F =40239(-25297)
      DW    S9D58      ; =0x9D58 =40280(-25256)
      DW    S9D9D      ; =0x9D9D =40349(-25187)
      DW    S9DC2      ; =0x9DC2 =40386(-25150)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    S9DCB      ; =0x9DCB =40395(-25141)
      DW    S9DD0      ; =0x9DD0 =40400(-25136)
      DW    S9DED      ; =0x9DED =40429(-25107)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    S9DF6      ; =0x9DF6 =40438(-25098)
      DW    S9E17      ; =0x9E17 =40471(-25065)
      DW    S9E2C      ; =0x9E2C =40492(-25044)
      DW    S9E35      ; =0x9E35 =40501(-25035)
      DW    S9E46      ; =0x9E46 =40518(-25018)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    S9E53      ; =0x9E53 =40531(-25005)
      DW    S9E78      ; =0x9E78 =40568(-24968)
      DW    S9EE5      ; =0x9EE5 =40677(-24859)
      DB    0,6        ; =0x00,0x0006
      DW    S9EEA      ; =0x9EEA =40682(-24854)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    S9F07      ; =0x9F07 =40711(-24825)
S9CD5 DC    '  '       ; hex:A0A0 dec:41120(-96)
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'74'      ; =0x74 =116
      DC    'NC'       ; hex:CEC3 dec:52931(-61)
      DW    X'5084'    ; =0x5084 =20612
      DC    'AB'       ; hex:C1C2 dec:49602(-62)
      DW    X'5802'    ; =0x5802 =22530
      DC    'ND'       ; hex:CEC4 dec:52932(-60)
      DW    X'5222'    ; =0x5222 =21026
      DC    'DD'       ; hex:C4C4 dec:50372(-60)
      DW    X'5022'    ; =0x5022 =20514
      DB    X'00'      ; =0x00 =0 =NUL
S9CEA DC    'Z '       ; hex:DAA0 dec:55968(-96)
      DW    X'1430'    ; =0x1430 =5168
      DC    'NZ'       ; hex:CEDA dec:52954(-38)
      DW    X'1530'    ; =0x1530 =5424
      DC    'L '       ; hex:CCA0 dec:52384(-96)
      DW    X'1030'    ; =0x1030 =4144
      DC    'NL'       ; hex:CECC dec:52940(-52)
      DW    X'1130'    ; =0x1130 =4400
      DC    'M '       ; hex:CDA0 dec:52640(-96)
      DW    X'1630'    ; =0x1630 =5680
      DC    'P '       ; hex:D0A0 dec:53408(-96)
      DW    X'1730'    ; =0x1730 =5936
      DC    'GZ'       ; hex:C7DA dec:51162(-38)
      DW    X'1830'    ; =0x1830 =6192
      DC    'LE'       ; hex:CCC5 dec:52421(-59)
      DW    X'1930'    ; =0x1930 =6448
      DC    'S1'       ; hex:D3B1 dec:54193(-79)
      DW    X'1A30'    ; =0x1A30 =6704
      DC    'S2'       ; hex:D3B2 dec:54194(-78)
      DW    X'1B30'    ; =0x1B30 =6960
      DC    'S3'       ; hex:D3B3 dec:54195(-77)
      DW    X'1C30'    ; =0x1C30 =7216
      DC    'S4'       ; hex:D3B4 dec:54196(-76)
      DW    X'1D30'    ; =0x1D30 =7472
      DC    'F '       ; hex:C6A0 dec:50848(-96)
      DW    X'1230'    ; =0x1230 =4656
      DC    'NF'       ; hex:CEC6 dec:52934(-58)
      DW    X'1330'    ; =0x1330 =4912
      DC    'I '       ; hex:C9A0 dec:51616(-96)
      DW    X'1E30'    ; =0x1E30 =7728
      DC    'CK'       ; hex:C3CB dec:50123(-53)
      DW    X'1F30'    ; =0x1F30 =7984
      DC    'EG'       ; hex:C5C7 dec:50631(-57)
      DW    X'0701'    ; =0x0701 =1793
      DB    X'00'      ; =0x00 =0 =NUL
S9D2F DC    '  '       ; hex:A0A0 dec:41120(-96)
      DW    X'2074'    ; =0x2074 =8308
      DC    'TB'       ; hex:D4C2 dec:54466(-62)
      DW    X'807C'    ; =0x807C =32892(-32644)
      DC    'FB'       ; hex:C6C2 dec:50882(-62)
      DW    X'907C'    ; =0x907C =36988(-28548)
      DC    'PF'       ; hex:D0C6 dec:53446(-58)
      DW    X'8084'    ; =0x8084 =32900(-32636)
      DC    'PV'       ; hex:D0D6 dec:53462(-42)
      DW    X'1080'    ; =0x1080 =4224
      DC    'VX'       ; hex:D6D8 dec:55000(-40)
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'80'      ; =0x80 =128(-128)
      DC    'LA'       ; hex:CCC1 dec:52417(-63)
      DW    X'3A0E'    ; =0x3A0E =14862
      DC    'LR'       ; hex:CCD2 dec:52434(-46)
      DW    X'321E'    ; =0x321E =12830
      DC    'L '       ; hex:CCA0 dec:52384(-96)
      DW    X'0800'    ; =0x0800 =2048
      DC    'AD'       ; hex:C1C4 dec:49604(-60)
      DW    X'326C'    ; =0x326C =12908
      DB    X'00'      ; =0x00 =0 =NUL
S9D58 DC    '  '       ; hex:A0A0 dec:41120(-96)
      DW    X'6074'    ; =0x6074 =24692
      DC    'RM'       ; hex:D2CD dec:53965(-51)
      DW    X'7074'    ; =0x7074 =28788
      DC    'IV'       ; hex:C9D6 dec:51670(-42)
      DW    X'7820'    ; =0x7820 =30752
      DC    'CX'       ; hex:C3D8 dec:50136(-40)
      DW    X'3F08'    ; =0x3F08 =16136
      DC    'CA'       ; hex:C3C1 dec:50113(-63)
      DW    X'390A'    ; =0x390A =14602
      DC    'CR'       ; hex:C3D2 dec:50130(-46)
      DW    X'311A'    ; =0x311A =12570
      DC    'EC'       ; hex:C5C3 dec:50627(-61)
      DW    X'3168'    ; =0x3168 =12648
      DC    'W '       ; hex:D7A0 dec:55200(-96)
      DW    X'0401'    ; =0x0401 =1025
      DC    'B '       ; hex:C2A0 dec:49824(-96)
      DW    X'0301'    ; =0x0301 =769
      DC    'C '       ; hex:C3A0 dec:50080(-96)
      DW    X'0501'    ; =0x0501 =1281
      DC    'S '       ; hex:D3A0 dec:54176(-96)
      DW    X'0601'    ; =0x0601 =1537
      DC    'LY'       ; hex:CCD9 dec:52441(-39)
      DW    X'0E00'    ; =0x0E00 =3584
      DC    'I '       ; hex:C9A0 dec:51616(-96)
      DW    X'0500'    ; =0x0500 =1280
      DC    'MA'       ; hex:CDC1 dec:52673(-63)
      DW    X'2F50'    ; =0x2F50 =12112
      DC    'CKF'      ; hex:C3CBC6
      DB    X'00'      ; =0x00 =0 =NUL
      DC    'AO'       ; hex:C1CF dec:49615(-49)
      DW    X'5700'    ; =0x5700 =22272
      DC    'PE'       ; hex:D0C5 dec:53445(-59)
      DW    X'8600'    ; =0x8600 =34304(-31232)
      DB    X'00'      ; =0x00 =0 =NUL
S9D9D DC    'QU'       ; hex:D1D5 dec:53717(-43)
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'01'      ; =0x01 =1
      DC    'XT'       ; hex:D8D4 dec:55508(-44)
      DW    X'0A01'    ; =0x0A01 =2561
      DC    'NT'       ; hex:CED4 dec:52948(-44)
      DW    X'0901'    ; =0x0901 =2305
      DC    'I '       ; hex:C9A0 dec:51616(-96)
      DW    X'0400'    ; =0x0400 =1024
      DC    'ND'       ; hex:CEC4 dec:52932(-60)
      DW    X'0801'    ; =0x0801 =2049
      DC    'JE'       ; hex:CAC5 dec:51909(-59)
      DW    X'0D01'    ; =0x0D01 =3329
      DC    'CK6'      ; hex:C3CBB6
      DB    X'00'      ; =0x00 =0 =NUL
      DC    'AO'       ; hex:C1CF dec:49615(-49)
      DW    X'5600'    ; =0x5600 =22016
      DC    'PE'       ; hex:D0C5 dec:53445(-59)
      DW    X'7600'    ; =0x7600 =30208
      DB    X'00'      ; =0x00 =0 =NUL
S9DC2 DC    'IL'       ; hex:C9CC dec:51660(-52)
      DW    X'9084'    ; =0x9084 =36996(-28540)
      DC    'LM'       ; hex:CCCD dec:52429(-51)
      DW    X'4090'    ; =0x4090 =16528
      DB    X'00'      ; =0x00 =0 =NUL
S9DCB DC    'LT'       ; hex:CCD4 dec:52436(-44)
      DB    X'00'      ; =0x00 =0 =NUL
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
S9DD0 DC    'NX'       ; hex:CED8 dec:52952(-40)
      DW    X'3E08'    ; =0x3E08 =15880
      DC    'NA'       ; hex:CEC1 dec:52929(-63)
      DW    X'380A'    ; =0x380A =14346
      DC    'VA'       ; hex:D6C1 dec:54977(-63)
      DW    X'3B0E'    ; =0x3B0E =15118
      DC    'NR'       ; hex:CED2 dec:52946(-46)
      DW    X'301A'    ; =0x301A =12314
      DC    'VR'       ; hex:D6D2 dec:54994(-46)
      DW    X'331E'    ; =0x331E =13086
      DC    'NC'       ; hex:CEC3 dec:52931(-61)
      DW    X'3068'    ; =0x3068 =12392
      DC    'AD'       ; hex:C1C4 dec:49604(-60)
      DW    X'336C'    ; =0x336C =13164
      DB    X'00'      ; =0x00 =0 =NUL
S9DED DC    'MP'       ; hex:CDD0 dec:52688(-48)
      DW    X'7040'    ; =0x7040 =28736
      DC    'SR'       ; hex:D3D2 dec:54226(-46)
      DW    X'7840'    ; =0x7840 =30784
      DB    X'00'      ; =0x00 =0 =NUL
S9DF6 DC    'IO'       ; hex:C9CF dec:51663(-49)
      DB    X'F6'      ; =0xF6 =246(-10) ='v'
      DC    '`ST'      ; hex:E0D3D4
      DB    X'6E'      ; =0x6E =110
      DC    '@AR'      ; hex:C0C1D2
      DB    X'E6'      ; =0xE6 =230(-26) ='f'
      DC    'PDM'      ; hex:D0C4CD
      DB    X'00'      ; =0x00 =0 =NUL
      DB    X'90'      ; =0x90 =144(-112)
      DC    'SM'       ; hex:D3CD dec:54221(-51)
      DW    X'2090'    ; =0x2090 =8336
      DC    'DA'       ; hex:C4C1 dec:50369(-63)
      DW    X'9046'    ; =0x9046 =36934(-28602)
      DC    'DBP'      ; hex:C4C2D0
      DB    X'46'      ; =0x46 =70
      DC    'DX'       ; hex:C4D8 dec:50392(-40)
      DW    X'6044'    ; =0x6044 =24644
      DB    X'00'      ; =0x00 =0 =NUL
S9E17 DC    '  '       ; hex:A0A0 dec:41120(-96)
      DW    X'5074'    ; =0x5074 =20596
      DC    'VF'       ; hex:D6C6 dec:54982(-58)
      DW    X'4084'    ; =0x4084 =16516
      DC    'VV'       ; hex:D6D6 dec:54998(-42)
      DW    X'2080'    ; =0x2080 =8320
      DC    'VL'       ; hex:D6CC dec:54988(-52)
      DW    X'F700'    ; =0xF700 =63232(-2304) ='w',NUL
      DC    'UL'       ; hex:D5CC dec:54732(-52)
      DW    X'7720'    ; =0x7720 =30496
      DB    X'00'      ; =0x00 =0 =NUL
S9E2C DC    'AB'       ; hex:C1C2 dec:49602(-62)
      DW    X'5A02'    ; =0x5A02 =23042
      DC    'OP'       ; hex:CFD0 dec:53200(-48)
      DW    X'0100'    ; =0x0100 =256
      DB    X'00'      ; =0x00 =0 =NUL
S9E35 DC    'RC'       ; hex:D2C3 dec:53955(-61)
      DW    X'6084'    ; =0x6084 =24708
      DC    'RI'       ; hex:D2C9 dec:53961(-55)
      DW    X'5322'    ; =0x5322 =21282
      DC    'RE'       ; hex:D2C5 dec:53957(-59)
      DW    X'5422'    ; =0x5422 =21538
      DC    'RG'       ; hex:D2C7 dec:53959(-57)
      DW    X'0201'    ; =0x0201 =513
      DB    X'00'      ; =0x00 =0 =NUL
S9E46 DC    'OP'       ; hex:CFD0 dec:53200(-48)
      DB    X'7F'      ; =0x7F =127
      DC    '0RI'      ; hex:B0D2C9
      DW    X'0B01'    ; =0x0B01 =2817
      DC    'CX'       ; hex:C3D8 dec:50136(-40)
      DW    X'0D00'    ; =0x0D00 =3328
      DB    X'00'      ; =0x00 =0 =NUL
S9E53 DC    'SR'       ; hex:D3D2 dec:54226(-46)
      DW    X'0900'    ; =0x0900 =2304
      DC    'SV'       ; hex:D3D6 dec:54230(-42)
      DW    X'0F00'    ; =0x0F00 =3840
      DC    'L '       ; hex:CCA0 dec:52384(-96)
      DW    X'0700'    ; =0x0700 =1792
      DC    'I '       ; hex:C9A0 dec:51616(-96)
      DW    X'0A00'    ; =0x0A00 =2560
      DC    'RR'       ; hex:D2D2 dec:53970(-46)
      DW    X'361A'    ; =0x361A =13850
      DC    'LR'       ; hex:CCD2 dec:52434(-46)
      DW    X'371A'    ; =0x371A =14106
      DC    'TR'       ; hex:D4D2 dec:54482(-46)
      DW    X'3668'    ; =0x3668 =13928
      DC    'TL'       ; hex:D4CC dec:54476(-52)
      DW    X'3768'    ; =0x3768 =14184
      DC    'F '       ; hex:C6A0 dec:50848(-96)
      DW    X'0300'    ; =0x0300 =768
      DB    X'00'      ; =0x00 =0 =NUL
S9E78 DC    'IO'       ; hex:C9CF dec:51663(-49)
      DW    X'F6E4'    ; =0xF6E4 =63204(-2332) ='v','d'
      DC    '  '       ; hex:A0A0 dec:41120(-96)
      DW    X'1074'    ; =0x1074 =4212
      DC    'VC'       ; hex:D6C3 dec:54979(-61)
      DB    X'66'      ; =0x66 =102
      DC    ' TK'      ; hex:A0D4CB
      DB    X'7E'      ; =0x7E =126
      DC    '0ST'      ; hex:B0D3D4
      DB    X'6F'      ; =0x6F =111
      DC    '@ARWPTM'  ; hex:C0C1D2D7D0D4CD
      DW    X'1090'    ; =0x1090 =4240
      DC    'SM'       ; hex:D3CD dec:54221(-51)
      DW    X'3090'    ; =0x3090 =12432
      DC    'TRV'      ; hex:D4D2D6
      DB    X'20'      ; =0x20 =32
      DC    'TA0'      ; hex:D4C1B0
      DB    X'46'      ; =0x46 =70
      DC    'TB'       ; hex:D4C2 dec:54466(-62)
      DW    X'F046'    ; =0xF046 =61510(-4026)
      DC    'AB'       ; hex:C1C2 dec:49602(-62)
      DW    X'5902'    ; =0x5902 =22786
      DC    'TX'       ; hex:D4D8 dec:54488(-40)
      DW    X'6844'    ; =0x6844 =26692
      DC    'UB'       ; hex:D5C2 dec:54722(-62)
      DW    X'5122'    ; =0x5122 =20770
      DC    'LA'       ; hex:CCC1 dec:52417(-63)
      DW    X'3D0A'    ; =0x3D0A =15626
      DC    'RA'       ; hex:D2C1 dec:53953(-63)
      DW    X'3C0A'    ; =0x3C0A =15370
      DC    'RR'       ; hex:D2D2 dec:53970(-46)
      DW    X'341A'    ; =0x341A =13338
      DC    'LR'       ; hex:CCD2 dec:52434(-46)
      DW    X'351A'    ; =0x351A =13594
      DC    'HR'       ; hex:C8D2 dec:51410(-46)
      DW    X'3468'    ; =0x3468 =13416
      DC    'HL'       ; hex:C8CC dec:51404(-52)
      DW    X'3568'    ; =0x3568 =13672
      DC    'L '       ; hex:CCA0 dec:52384(-96)
      DW    X'0600'    ; =0x0600 =1536
      DC    'F '       ; hex:C6A0 dec:50848(-96)
      DW    X'0200'    ; =0x0200 =512
      DC    'EP&'      ; hex:C5D0A6
      DB    X'00'      ; =0x00 =0 =NUL
      DC    'OP'       ; hex:CFD0 dec:53200(-48)
      DW    X'9600'    ; =0x9600 =38400(-27136)
      DC    'YN'       ; hex:D9CE dec:55758(-50)
      DW    X'0C00'    ; =0x0C00 =3072
      DC    'CN'       ; hex:C3CE dec:50126(-50)
      DW    X'3080'    ; =0x3080 =12416
      DC    'ET'       ; hex:C5D4 dec:50644(-44)
      DW    X'0101'    ; =0x0101 =257
      DB    X'00'      ; =0x00 =0 =NUL
S9EE5 DC    'IT'       ; hex:C9D4 dec:51668(-44)
      DW    X'0C01'    ; =0x0C01 =3073
      DB    X'00'      ; =0x00 =0 =NUL
S9EEA DC    'RC'       ; hex:D2C3 dec:53955(-61)
      DW    X'7084'    ; =0x7084 =28804
      DC    'AX'       ; hex:C1D8 dec:49624(-40)
      DW    X'5B02'    ; =0x5B02 =23298
      DC    'AY'       ; hex:C1D9 dec:49625(-39)
      DW    X'5C02'    ; =0x5C02 =23554
      DC    'AZ'       ; hex:C1DA dec:49626(-38)
      DW    X'5E02'    ; =0x5E02 =24066
      DC    'AB'       ; hex:C1C2 dec:49602(-62)
      DW    X'5D02'    ; =0x5D02 =23810
      DC    'AS'       ; hex:C1D3 dec:49619(-45)
      DW    X'5F02'    ; =0x5F02 =24322
      DC    'FR'       ; hex:C6D2 dec:50898(-46)
      DW    X'5522'    ; =0x5522 =21794
      DB    X'00'      ; =0x00 =0 =NUL
S9F07 DC    'AD'       ; hex:C1C4 dec:49604(-60)
      DW    X'3074'    ; =0x3074 =12404
      DC    'SU'       ; hex:D3D5 dec:54229(-43)
      DW    X'4074'    ; =0x4074 =16500
      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F9F10
*
F9F10 LDAB+ Y,3        ; [Load AL indexed, displaced, direct]
      XFRB  AL,AU      ; [Transfer AL to AU]
      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX=  W9F4E      ; =0x9F4E =40782(-24754) [Load X with immediate]
      LDB=  X'858F'    ; =0x858F =34191(-31345) [Load B with immediate]
      ANDB  AU,BL      ; [AU & BL -> BL]
      SUBB  BU,BL      ; [BU - BL -> BL]
      BNZ   D9F3A      ; =+20 [Branch if not zero]
      LDBB= X'0F'      ; =15 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      BNZ   D9F4C      ; =+33 [Branch if not zero]
      RL               ; [Reset link]
      RRRB  AL         ; [Right rotate AL by 1]
      SRRB  AL,4       ; [Right shift AL by 4]
      LDBB= X'08'      ; =8 [Load BL with immediate]
      AABB             ; [AL + BL -> BL]
      LDAB= X'F0'      ; =240(-16) ='p' [Load AL with immediate]
      ANDB  AU,AL      ; [AU & AL -> AL]
      AABB             ; [AL + BL -> BL]
      JMP   D9F43      ; =+9 [Jump relative]
D9F3A INX              ; [Increment X]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      BZ    D9F4C      ; =+13 [Branch if zero]
      SAB              ; [A - B -> B]
      BNZ   D9F3A      ; =-8 [Branch if not zero]
      LDBB+ X          ; [Load BL from address in X]
D9F43 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      STBB+ Y          ; [Store BL to address in Y]
      CLA              ; [Clear A]
      INA              ; [Increment A]
      STA-  Y-         ; [Store A indexed, pre-decremented, direct]
D9F4C LDX+  S+         ; [Load X indexed, direct, post-incremented]
W9F4E RSR              ; [Return from subroutine]
*
      DW    X'3000'    ; =0x3000 =12288
W9F51 DW    X'3820'    ; =0x3820 =14368
      DW    X'1028'    ; =0x1028 =4136
      DW    X'3100'    ; =0x3100 =12544
      DW    X'3921'    ; =0x3921 =14625
      DW    X'1029'    ; =0x1029 =4137
      DW    X'3200'    ; =0x3200 =12800
      DW    X'3A22'    ; =0x3A22 =14882
      DW    X'102A'    ; =0x102A =4138
      DW    X'3300'    ; =0x3300 =13056
      DW    X'3B23'    ; =0x3B23 =15139
      DW    X'102B'    ; =0x102B =4139
      DW    X'3400'    ; =0x3400 =13312
      DW    X'3C24'    ; =0x3C24 =15396
      DW    X'102C'    ; =0x102C =4140
      DW    X'3500'    ; =0x3500 =13568
      DW    X'3D25'    ; =0x3D25 =15653
      DW    X'102D'    ; =0x102D =4141
      DW    X'3040'    ; =0x3040 =12352
      DW    X'3E31'    ; =0x3E31 =15921
      DW    X'403F'    ; =0x403F =16447
      DW    X'5002'    ; =0x5002 =20482
      DW    X'5840'    ; =0x5840 =22592
      DW    X'1348'    ; =0x1348 =4936
      DW    X'5102'    ; =0x5102 =20738
      DW    X'5941'    ; =0x5941 =22849
      DW    X'1349'    ; =0x1349 =4937
      DW    X'5202'    ; =0x5202 =20994
      DW    X'5A42'    ; =0x5A42 =23106
      DW    X'134A'    ; =0x134A =4938
      DW    X'5504'    ; =0x5504 =21764
      DW    X'5B45'    ; =0x5B45 =23365
      DW    X'154B'    ; =0x154B =5451
      DW    X'5506'    ; =0x5506 =21766
      DW    X'5C45'    ; =0x5C45 =23621
      DW    X'174C'    ; =0x174C =5964
      DW    X'5502'    ; =0x5502 =21762
      DW    X'5D45'    ; =0x5D45 =23877
      DW    X'134D'    ; =0x134D =4941
      DW    X'5508'    ; =0x5508 =21768
      DW    X'5E45'    ; =0x5E45 =24133
      DW    X'194E'    ; =0x194E =6478
      DW    X'550A'    ; =0x550A =21770
      DW    X'5F45'    ; =0x5F45 =24389
      DW    X'1B4F'    ; =0x1B4F =6991
      DB    0,3        ; =0x00,0x0003
W9FAC DS    16         ; =0x0010 [Uninitialized memory]
B9FBC DS    1          ; =0x0001 [Uninitialized memory]
W9FBD DS    1          ; =0x0001 [Uninitialized memory]
W9FBE DS    1          ; =0x0001 [Uninitialized memory]
W9FBF DS    5          ; =0x0005 [Uninitialized memory]
W9FC4 DS    11         ; =0x000B [Uninitialized memory]
W9FCF DS    2          ; =0x0002 [Uninitialized memory]
W9FD1 DS    1          ; =0x0001 [Uninitialized memory]
B9FD2 DS    2          ; =0x0002 [Uninitialized memory]
B9FD4 DS    2          ; =0x0002 [Uninitialized memory]
W9FD6 DS    9          ; =0x0009 [Uninitialized memory]
W9FDF DS    7          ; =0x0007 [Uninitialized memory]
W9FE6 DS    28         ; =0x001C [Uninitialized memory]
WA002 DS    66         ; =0x0042 [Uninitialized memory]
WA044 DS    255        ; =0x00FF [Uninitialized memory]
WA143 DS    1          ; =0x0001 [Uninitialized memory]
*
* Function FA144
*
FA144 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      XFR   Y,X        ; [Transfer Y to X]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      LDX+  A+         ; [Load X indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
DA14F DCX              ; [Decrement X]
      BM    DA165      ; =+19 [Branch on minus]
      LDAB+ Y          ; [Load AL from address in Y]
      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BGZ   DA161      ; =+9 [Branch if greater than zero]
      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
      SABB             ; [AL - BL -> BL]
      BM    DA161      ; =+4 [Branch on minus]
      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
      ADDB  BL,AL      ; [BL + AL -> AL]
DA161 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
      JMP   DA14F      ; =-22 [Jump relative]
DA165 LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XAY              ; [Transfer A to Y]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
WA16B DB    X'0B'      ; =0x0B =11
      DW    WA200      ; =0xA200 =41472(-24064) ='"',NUL
      DW    WA252      ; =0xA252 =41554(-23982)
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      DW    WA182      ; =0xA182 =41346(-24190)
      DB    0,12       ; =0x00,0x000C
      DW    WA2D5      ; =0xA2D5 =41685(-23851) ='"','U'
WA182 STX-  S-         ; [Store X indexed, pre-decremented, direct]
      JSR   FA1B1      ; =+43 [Jump to subroutine relative]
      DB    X'02'      ; =0x02 =2
      BZ    DA1AF      ; =+38 [Branch if zero]
      CLA              ; [Clear A]
      STA+  Z,18       ; [Store A indexed, displaced, direct]
      STA+  Z,22       ; [Store A indexed, displaced, direct]
      STB+  Z,20       ; [Store B indexed, displaced, direct]
      STB+  Z,24       ; [Store B indexed, displaced, direct]
      JSR   FA1B1      ; =+25 [Jump to subroutine relative]
      DB    X'05'      ; =0x05 =5
      LDBB= X'0F'      ; =15 [Load BL with immediate]
      ANDB  BU,BL      ; [BU & BL -> BL]
      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
      BM    DA1A8      ; =+6 [Branch on minus]
      SABB             ; [AL - BL -> BL]
      BZ    DA1A8      ; =+3 [Branch if zero]
      SVC   X'09'      ; =9 [Service call ABRT - abort task]
      DB    X'12'      ; =0x12 =18 [abort code]
*
DA1A8 LDA+  Z,6        ; [Load A indexed, displaced, direct]
      BZ    DA1AF      ; =+2 [Branch if zero]
      JSR   FA1C8      ; =+25 [Jump to subroutine relative]
DA1AF JMP   DA226      ; =+117 [Jump relative]
*
* Function FA1B1
*
FA1B1 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      STAB  BA1BB      ; =+6 [Store AL relative]
      XFR   Z,B        ; [Transfer Z to B]
      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
      DB    X'01'      ; =0x01 =1 [TODO: arg1]
      DB    X'02'      ; =0x02 =2 [TODO: arg2]
BA1BB DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
      DW    LA1C2+1    ; =0xA1C3 =41411(-24125) ='!','C' [TODO: address]
      XFR   B,B        ; [Transfer B to B]
      BZ    DA1C7      ; =+5 [Branch if zero]
LA1C2 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
      XFR   A,A        ; [Transfer A to A]
DA1C7 RSR              ; [Return from subroutine]
*
* Function FA1C8
*
FA1C8 JSR   FA1B1      ; =-25 [Jump to subroutine relative]
      DB    X'02'      ; =0x02 =2
      LDA+  Z,22       ; [Load A indexed, displaced, direct]
      SUB   B,A        ; [B - A -> A]
      BL    DA1D6      ; =+4 [Branch on link]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      JMP   DA1EA      ; =+20 [Jump relative]
DA1D6 LDA+  Z,22       ; [Load A indexed, displaced, direct]
      STA+  Z,18       ; [Store A indexed, displaced, direct]
      STA+  Z,8        ; [Store A indexed, displaced, direct]
      JSR   FA1F4      ; =+19 [Jump to subroutine relative]
      DB    X'01'      ; =0x01 =1
      LDB+  Z,18       ; [Load B indexed, displaced, direct]
      INR   B          ; [Increment B by 1]
      STB+  Z,22       ; [Store B indexed, displaced, direct]
DA1EA STAB+ Z          ; [Store AL to address in Z]
      RSR              ; [Return from subroutine]
*
* Function FA1EC
*
FA1EC LDAB+ Z          ; [Load AL from address in Z]
      BP    DA1F3      ; =+4 [Branch on plus]
      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
      JMP   FA1EC      ; =-7 [Jump relative]
DA1F3 RSR              ; [Return from subroutine]
*
* Function FA1F4
*
FA1F4 XFR   Z,B        ; [Transfer Z to B]
      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
      JSR   FA1EC      ; =-19 [Jump to subroutine relative]
      RSR              ; [Return from subroutine]
*
WA200 STX-  S-         ; [Store X indexed, pre-decremented, direct]
DA202 LDA+  Z,6        ; [Load A indexed, displaced, direct]
      INR   A,2        ; [Increment A by 2]
      LDB+  Z,24       ; [Load B indexed, displaced, direct]
      STB+  Z,20       ; [Store B indexed, displaced, direct]
      ADD   B,A        ; [B + A -> A]
      XAY              ; [Transfer A to Y]
      LDA+  Y          ; [Load A from address in Y]
      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
      LDAB= X'01'      ; =1 [Load AL with immediate]
      SUBB  AU,BL      ; [AU - BL -> BL]
      BZ    DA225      ; =+12 [Branch if zero]
      DCRB  AU         ; [Decrement AU by 1]
      BNF   DA22A      ; =+13 [Branch on no fault]
      JSR   FA1C8      ; =-87 [Jump to subroutine relative]
      CLA              ; [Clear A]
      STA+  Z,24       ; [Store A indexed, displaced, direct]
      JMP   DA202      ; =-35 [Jump relative]
DA225 STAB+ Z          ; [Store AL to address in Z]
DA226 LDB+  S+         ; [Load B indexed, direct, post-incremented]
      SVC   X'68'      ; =104 [Service call RLSR - return from LSR]
DA22A LDA+  Y          ; [Load A from address in Y]
      CLRB  AU         ; [Clear AU]
      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
      ADD   B,A        ; [B + A -> A]
      LDB+  Z,24       ; [Load B indexed, displaced, direct]
      AAB              ; [A + B -> B]
      STB+  Z,24       ; [Store B indexed, displaced, direct]
      LDB+  Z,16       ; [Load B indexed, displaced, direct]
      XAX              ; [Transfer A to X]
      CLA              ; [Clear A]
DA23E DCX              ; [Decrement X]
      BLE   DA249      ; =+8 [Branch if less than or equal to zero]
      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
      ADDB  AL,AU      ; [AL + AU -> AU]
      JMP   DA23E      ; =-11 [Jump relative]
DA249 LDAB+ Y          ; [Load AL from address in Y]
      ADDB  AU,AL      ; [AU + AL -> AL]
      BZ    DA225      ; =-41 [Branch if zero]
      LDAB= X'04'      ; =4 [Load AL with immediate]
      JMP   DA225      ; =-45 [Jump relative]
WA252 STX-  S-         ; [Store X indexed, pre-decremented, direct]
DA254 LDA+  Z,6        ; [Load A indexed, displaced, direct]
      INR   A,2        ; [Increment A by 2]
      XAY              ; [Transfer A to Y]
      LDA+  Z,24       ; [Load A indexed, displaced, direct]
      STA+  Z,20       ; [Store A indexed, displaced, direct]
      ADD   A,Y        ; [A + Y -> Y]
      LDX+  Z,16       ; [Load X indexed, displaced, direct]
      LDB+  X          ; [Load B from address in X]
      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
      SUBB  BL,BU      ; [BL - BU -> BU]
      BNZ   DA26F      ; =+3 [Branch if not zero]
      STBB+ Y          ; [Store BL to address in Y]
      JMP   DA2A0      ; =+49 [Jump relative]
DA26F LDB+  X          ; [Load B from address in X]
      CLRB  BU         ; [Clear BU]
      AAB              ; [A + B -> B]
      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
      AAB              ; [A + B -> B]
      STB+  Z,24       ; [Store B indexed, displaced, direct]
      LDA=  X'018A'    ; =0x018A =394 [Load A with immediate]
      SAB              ; [A - B -> B]
      BP    DA286      ; =+6 [Branch on plus]
      JSR   FA2B2      ; =+48 [Jump to subroutine relative]
      BZ    DA254      ; =-48 [Branch if zero]
      JMP   DA225      ; =-97 [Jump relative]
DA286 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      XAB              ; [Transfer A to B]
      CLRB  AU         ; [Clear AU]
      STB+  Y+         ; [Store B indexed, direct, post-incremented]
      ADDB  BL,BU      ; [BL + BU -> BU]
      INA              ; [Increment A]
DA290 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
      ADDB  BL,BU      ; [BL + BU -> BU]
      DCA              ; [Decrement A]
      BP    DA290      ; =-9 [Branch on plus]
      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
      IVRB  BU         ; [Invert BU]
      INRB  BU         ; [Increment BU by 1]
      STB+  Y          ; [Store B to address in Y]
DA2A0 CLAB             ; [Clear AL]
      JMP   DA225      ; =-126 [Jump relative]
*
* Function FA2A3
*
FA2A3 CLA              ; [Clear A]
      STA+  Z,24       ; [Store A indexed, displaced, direct]
      LDA+  Z,18       ; [Load A indexed, displaced, direct]
      STA+  Z,8        ; [Store A indexed, displaced, direct]
      JSR/  FA1F4      ; =0xA1F4 =41460(-24076) ='!','t' [Jump to subroutine direct]
      DB    X'02'      ; =0x02 =2
      RSR              ; [Return from subroutine]
*
* Function FA2B2
*
FA2B2 JSR   FA2A3      ; =-17 [Jump to subroutine relative]
      BNZ   DA2D1      ; =+27 [Branch if not zero]
      JSR/  FA1B1      ; =0xA1B1 =41393(-24143) ='!','1' [Jump to subroutine direct]
      DB    X'02'      ; =0x02 =2
      LDA+  Z,22       ; [Load A indexed, displaced, direct]
      STA+  Z,18       ; [Store A indexed, displaced, direct]
      INA              ; [Increment A]
      STA+  Z,22       ; [Store A indexed, displaced, direct]
      DCA              ; [Decrement A]
      SUB   B,A        ; [B - A -> A]
      BL    DA2D0      ; =+7 [Branch on link]
      XFR   Z,B        ; [Transfer Z to B]
      SVC   X'19'      ; =25 [Service call EXP - file expand]
      XAB              ; [Transfer A to B]
      BNZ   DA2D2      ; =+2 [Branch if not zero]
DA2D0 CLA              ; [Clear A]
DA2D1 RSR              ; [Return from subroutine]
*
DA2D2 LDAB= X'02'      ; =2 [Load AL with immediate]
      RSR              ; [Return from subroutine]
*
WA2D5 DB    X'6D'      ; =0x6D =109
      DC    '"'        ; hex:A2 dec:162(-94)
      DB    X'7B'      ; =0x7B =123
      DC    'J'        ; hex:CA dec:202(-54)
      DB    X'73'      ; =0x73 =115
      DC    'F'        ; hex:C6 dec:198(-58)
*
* Function FA2DB
*
FA2DB LDB+  X+         ; [Load B indexed, direct, post-incremented]
      LDA+  B+         ; [Load A indexed, direct, post-incremented]
      STB   WA2FF      ; =+30 [Store B relative]
      XFRB  AL,AU      ; [Transfer AL to AU]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
      STB   WA301      ; =+22 [Store B relative]
      XAB              ; [Transfer A to B]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      SUBB  AU,AL      ; [AU - AL -> AL]
      BM    DA2F4      ; =+2 [Branch on minus]
      XFRB  BL,AU      ; [Transfer BL to AU]
DA2F4 XFRB  AU,AL      ; [Transfer AU to AL]
      CLRB  AU         ; [Clear AU]
      STA   WA2FD      ; =+3 [Store A relative]
      JSR/  FA311      ; =0xA311 =41745(-23791) [Jump to subroutine direct]
WA2FD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
WA2FF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
WA301 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
      XFRB  BL,BL      ; [Transfer BL to BL]
      BNZ   DA30C      ; =+5 [Branch if not zero]
      LDB+  S+         ; [Load B indexed, direct, post-incremented]
      SUBB  BU,BL      ; [BU - BL -> BL]
      RSR              ; [Return from subroutine]
*
DA30C LDA+  S+         ; [Load A indexed, direct, post-incremented]
      XFRB  BL,BL      ; [Transfer BL to BL]
      RSR              ; [Return from subroutine]
*
* Function FA311
*
FA311 STK   Y,2        ; [Push Y to the stack]
      LDA+  X+         ; [Load A indexed, direct, post-incremented]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      XFR   B,Y        ; [Transfer B to Y]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      CPFR  -Y,-B      ; [Compare fixed-length (len in AL), indexed, indexed]
      BZ    DA328      ; =+7 [Branch if zero]
      BP    DA32D      ; =+10 [Branch on plus]
      POP   Y,2        ; [Pop Y from the stack]
      LDBB= X'01'      ; =1 [Load BL with immediate]
      RSR              ; [Return from subroutine]
*
DA328 POP   Y,2        ; [Pop Y from the stack]
      CLRB  BL         ; [Clear BL]
      RSR              ; [Return from subroutine]
*
DA32D POP   Y,2        ; [Pop Y from the stack]
      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
      RSR              ; [Return from subroutine]
*
* Function FA332
*
FA332 STK   Y,2        ; [Push Y to the stack]
      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
      INR   X,2        ; [Increment X by 2]
      DCA              ; [Decrement A]
      BP    DA341      ; =+4 [Branch on plus]
      INR   X,2        ; [Increment X by 2]
      JMP   DA354      ; =+19 [Jump relative]
DA341 FILR  =' ',-Y    ; [Fill with byte (len in AL), literal=0xA0(160,-96), indexed]
      INA              ; [Increment A]
      SAB              ; [A - B -> B]
      BLE   DA34C      ; =+3 [Branch if less than or equal to zero]
      SAB              ; [A - B -> B]
      XFR   B,A        ; [Transfer B to A]
DA34C LDB+  X+         ; [Load B indexed, direct, post-incremented]
      DCA              ; [Decrement A]
      BM    DA354      ; =+3 [Branch on minus]
      MVFR  -B,-Y      ; [Move fixed-length (len in AL), indexed, indexed]
DA354 POP   Y,2        ; [Pop Y from the stack]
      RSR              ; [Return from subroutine]
*
* Function FA357
*
FA357 LDA+  X+         ; [Load A indexed, direct, post-incremented]
      STX-  S-         ; [Store X indexed, pre-decremented, direct]
      STA-  S-         ; [Store A indexed, pre-decremented, direct]
      LDX+  A+         ; [Load X indexed, direct, post-incremented]
      BLE   DA36F      ; =+14 [Branch if less than or equal to zero]
      ADD   X,A        ; [X + A -> A]
      LDB=  X'A0A0'    ; =0xA0A0 =41120(-24416) =' ',' ' [Load B with immediate]
DA366 LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
      SUBB  BU,BL      ; [BU - BL -> BL]
      BNZ   DA36F      ; =+3 [Branch if not zero]
      DCX              ; [Decrement X]
      BGZ   DA366      ; =-9 [Branch if greater than zero]
DA36F LDA+  S+         ; [Load A indexed, direct, post-incremented]
      STX+  A          ; [Store X indexed, direct]
      LDX+  S+         ; [Load X indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
JA376 JMP/  JA69C      ; =0xA69C =42652(-22884) [Jump direct]
*
      DS    400        ; =0x0190 [Uninitialized memory]
WA509 DS    403        ; =0x0193 [Uninitialized memory]
JA69C XFR=  W80C8,S    ; =0x80C8 =32968(-32568) [Transfer immediate to S]
      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
      DB    X'02'      ; =0x02 =2 [TODO: arg2]
      DB    X'0C'      ; =0x0C =12 [TODO: arg3]
      DW    S884C      ; =0x884C =34892(-30644) [address to store block value]
      JSR/  FA73F      ; =0xA73F =42815(-22721) [Jump to subroutine direct]
      DW    WA7BF      ; =0xA7BF =42943(-22593) =','?'
      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
      DB    X'01'      ; =0x01 =1 [TODO: arg2]
      DB    X'12'      ; =0x12 =18 [TODO: arg3]
      DW    WA6D5+1    ; =0xA6D6 =42710(-22826) ='&','V' [address to store block value]
      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
      DB    X'01'      ; =0x01 =1 [TODO: arg2]
      DB    X'15'      ; =0x15 =21 [TODO: arg3]
WA6B8 DW    WA6B8      ; =0xA6B8 =42680(-22856) ='&','8' [address to store block value]
      LDAB  WA6B8      ; =-4 [Load AL relative]
      SRAB             ; [Right shift AL]
      BL    DA6C4      ; =+5 [Branch on link]
      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
      STBB/ BA7B6      ; =0xA7B6 =42934(-22602) =','6' [Store BL direct]
DA6C4 SRAB             ; [Right shift AL]
      BNL   DA6F7      ; =+48 [Branch on no link]
      LDA=  WA7D7      ; =0xA7D7 =42967(-22569) =','W' [Load A with immediate]
      STA/  WA7C5      ; =0xA7C5 =42949(-22587) =','E' [Store A direct]
      JSR   FA73F      ; =+112 [Jump to subroutine relative]
      DW    WA7BF      ; =0xA7BF =42943(-22593) =','?'
      JSR   FA73F      ; =+108 [Jump to subroutine relative]
      DW    WA7B5      ; =0xA7B5 =42933(-22603) =','5'
WA6D5 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
      LDBB= X'20'      ; =32 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      BNZ   DA6E1      ; =+5 [Branch if not zero]
      LDA=  S82B1      ; =0x82B1 =33457(-32079) [Load A with immediate]
      STA   WA6F3      ; =+18 [Store A relative]
DA6E1 LDA=  S8284      ; =0x8284 =33412(-32124) [Load A with immediate]
      LDB   WA6F3      ; =+13 [Load B relative]
      SUB   B,A        ; [B - A -> A]
      LDB/  WA7E5      ; =0xA7E5 =42981(-22555) =','e' [Load B direct]
      ADD   B,A        ; [B + A -> A]
      STA/  W8282      ; =0x8282 =33410(-32126) [Store A direct]
      JSR/  FA332      ; =0xA332 =41778(-23758) [Jump to subroutine direct]
WA6F3 DW    S82BC      ; =0x82BC =33468(-32068)
      DW    ENDPT      ; =0xA7E7 =42983(-22553) =','g'
DA6F7 LDA=  S829C      ; =0x829C =33436(-32100) [Load A with immediate]
      LDB/  SA7CB      ; =0xA7CB =42955(-22581) =','K' [Load B direct]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      LDB/  SA7CD      ; =0xA7CD =42957(-22579) =','M' [Load B direct]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
      LDB/  SA7D2      ; =0xA7D2 =42962(-22574) =','R' [Load B direct]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      LDB/  SA7D4      ; =0xA7D4 =42964(-22572) =','T' [Load B direct]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      INR   A,2        ; [Increment A by 2]
      STA   WA71B      ; =+5 [Store A relative]
      SVC   X'0B'      ; =11 [Service call DT - get binary date]
      SVC   X'05'      ; =5 [Service call TS - load transient module]
      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
WA71B DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of string date]
      LDA   WA71B      ; =-4 [Load A relative]
      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
      ADD   B,A        ; [B + A -> A]
      LDB=  X'A0A0'    ; =0xA0A0 =41120(-24416) =' ',' ' [Load B with immediate]
      STB+  A+         ; [Store B indexed, direct, post-incremented]
      STA   WA734      ; =+9 [Store A relative]
      LDAB  WA6D5+1    ; =-87 [Load AL relative]
      LDBB= X'20'      ; =32 [Load BL with immediate]
      NABB             ; [AL & BL -> BL]
      BZ    DA74B      ; =+25 [Branch if zero]
      SVC   X'1C'      ; =28 [Service call GC - get character time]
WA734 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address to put time]
      LDA   WA734      ; =-4 [Load A relative]
      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
      STBB+ A,8        ; [Store BL indexed, displaced, direct]
      JMP   DA751      ; =+18 [Jump relative]
*
* Function FA73F
*
FA73F LDB+  X          ; [Load B from address in X]
      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
DA742 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
      LDB+  X          ; [Load B from address in X]
      LDAB+ B          ; [Load AL from address in B]
      BM    DA742      ; =-6 [Branch on minus]
      LDB+  X+         ; [Load B indexed, direct, post-incremented]
      RSR              ; [Return from subroutine]
*
DA74B LDA=  S82B1      ; =0x82B1 =33457(-32079) [Load A with immediate]
      STA/  W8B0B+1    ; =0x8B0C =35596(-29940) [Store A direct]
DA751 LDA=  JA376      ; =0xA376 =41846(-23690) [Load A with immediate]
      XAY              ; [Transfer A to Y]
      LDB=  W8106      ; =0x8106 =33030(-32506) [Load B with immediate]
      SVC   X'52'      ; =82 [Service call GIOB - unprotected GIOB]
      DB    X'01'      ; =0x01 =1 [TODO: arg1]
      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: address]
      XFR   B,B        ; [Transfer B to B]
      BZ    DA775      ; =+18 [Branch if zero]
      LDA=  JA376      ; =0xA376 =41846(-23690) [Load A with immediate]
      STA/  S810C      ; =0x810C =33036(-32500) [Store A direct]
      ADD=  X'0193',Y  ; =0x0193 =403 [403 - Y -> Y]
      LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
      STA/  W8110      ; =0x8110 =33040(-32496) [Store A direct]
      JMP   DA77A      ; =+5 [Jump relative]
DA775 LDA=  JA376      ; =0xA376 =41846(-23690) [Load A with immediate]
      STA   WA788+1    ; =+15 [Store A relative]
DA77A LDB=  W8124      ; =0x8124 =33060(-32476) [Load B with immediate]
      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
      DB    X'01'      ; =0x01 =1 [TODO: arg1]
      DB    X'01'      ; =0x01 =1 [TODO: arg2]
      DB    X'01'      ; =0x01 =1 [TODO: arg3]
WA782 DW    WA782      ; =0xA782 =42882(-22654) [address to store block value]
      LDBB  WA782      ; =-4 [Load BL relative]
      BZ    DA797      ; =+15 [Branch if zero]
WA788 LDA=  WA509      ; =0xA509 =42249(-23287) [Load A with immediate]
      STA/  S812A      ; =0x812A =33066(-32470) [Store A direct]
      ADD=  X'0193',Y  ; =0x0193 =403 [403 - Y -> Y]
      LDB=  W8124      ; =0x8124 =33060(-32476) [Load B with immediate]
      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
DA797 LDB=  W80CA      ; =0x80CA =32970(-32566) [Load B with immediate]
      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
      SVC   X'05'      ; =5 [Service call TS - load transient module]
      DB    X'0C'      ; =0x0C =12 [Selector: TODO]
      DW    W80CA      ; =0x80CA =32970(-32566) [address of TODO]
      STA/  W9AB7      ; =0x9AB7 =39607(-25929) [Store A direct]
      LDB=  W80E8      ; =0x80E8 =33000(-32536) [Load B with immediate]
      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
      LDB=  W8106      ; =0x8106 =33030(-32506) [Load B with immediate]
      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
      STR/  W884A,Y    ; =0x884A =34890(-30646) [Store Y direct]
      JMP/  J8843      ; =0x8843 =34883(-30653) [Jump direct]
*
WA7B5 DB    X'00'      ; =0x00 =0 =NUL
BA7B6 DW    X'8100'    ; =0x8100 =33024(-32512)
      DW    X'0100'    ; =0x0100 =256
      DB    X'57'      ; =0x57 =87
      DW    WA7E5      ; =0xA7E5 =42981(-22555) =','e'
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
WA7BF DW    X'0082'    ; =0x0082 =130
      DB    X'00'      ; =0x00 =0 =NUL
      DW    X'0200'    ; =0x0200 =512
      DB    X'50'      ; =0x50 =80
WA7C5 DW    WA7C9      ; =0xA7C9 =42953(-22583) =','I'
      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
WA7C9 DW    X'000C'    ; =0x000C =12
SA7CB DC    'AS'       ; hex:C1D3 dec:49619(-45)
SA7CD DC    'SM - '    ; hex:D3CDA0ADA0
SA7D2 DC    '6.'       ; hex:B6AE dec:46766(-82)
SA7D4 DC    '05'       ; hex:B0B5 dec:45237(-75)
      DB    X'8D'      ; =0x8D =141(-115) =CR
WA7D7 DW    X'000C'    ; =0x000C =12
      DC    'ENTER TITLE'
      DB    X'8D'      ; =0x8D =141(-115) =CR
WA7E5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
ENDPT END   ENTRY
