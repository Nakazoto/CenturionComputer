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
8000:      DS    177        ; =0x00b1 [Uninitialized memory]
80b1:W80B1 DS    151        ; =0x0097 [Uninitialized memory]
*
8148:J8148 DS    238        ; =0x00ee [Uninitialized memory]
8236:W8236 DS    41         ; =0x0029 [Uninitialized memory]
*
*
* Function F825F
*
825f:F825F DS    12         ; =0x000c [Uninitialized memory]
*
*
* Function F826B
*
826b:F826B DS    19         ; =0x0013 [Uninitialized memory]
*
*
* Function F827E
*
827e:F827E DS    32         ; =0x0020 [Uninitialized memory]
*
*
* Function F829E
*
829e:F829E DS    38         ; =0x0026 [Uninitialized memory]
*
*
* Function F82C4
*
82c4:F82C4 DS    38         ; =0x0026 [Uninitialized memory]
*
*
* Function F82EA
*
82ea:F82EA DS    87         ; =0x0057 [Uninitialized memory]
*
*
* Function F8341
*
8341:F8341 DS    2542       ; =0x09ee [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d36:      BZ    D8D3B      ; =+3 [Branch if zero]
8d38:      JMP/  J8F52      ; =0x8f52 =36690(-28846) [Jump direct]
8d3b:D8D3B FIL   (21)=' ',/S904D ; =0x904d =36941(-28595) [Fill with byte, literal=0xa0(160,-96), direct]
8d41:      FIL   (21)=X'00',/W9066 ; =0x9066 =36966(-28570) [Fill with byte, literal=0, direct]
8d47:      LDAB+ Z          ; [Load AL from address in Z]
8d48:      JSR/  F826B      ; =0x826b =33387(-32149) [Jump to subroutine direct]
8d4b:      BP    D8D52      ; =+5 [Branch on plus]
8d4d:D8D4D JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d50:      DW    X'000A'    ; =0x000a =10
*
8d52:D8D52 JSR/  F901D      ; =0x901d =36893(-28643) [Jump to subroutine direct]
8d55:      DW    S904D      ; =0x904d =36941(-28595)
8d57:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d5a:      DC    'ON'       ; hex:cfce dec:53198(-50)
8d5c:      DB    X'01'      ; =0x01 =1
8d5d:      BNZ   D8D64      ; =+5 [Branch if not zero]
8d5f:J8D5F JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d62:      DW    X'001C'    ; =0x001c =28
*
8d64:D8D64 JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8d67:      STBB/ B8F20+1    ; =0x8f21 =36641(-28895) [Store BL direct]
8d6a:      LDBB+ A,2        ; [Load BL indexed, displaced, direct]
8d6d:      STBB  B8D75+1    ; =+7 [Store BL relative]
8d6f:      LDAB+ A          ; [Load AL from address in A]
8d70:      LDBB= X'10'      ; =16 [Load BL with immediate]
8d72:      NABB             ; [AL & BL -> BL]
8d73:      BZ    D8D4D      ; =-40 [Branch if zero]
8d75:B8D75 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8d77:      LDB=  S904D      ; =0x904d =36941(-28595) [Load B with immediate]
8d7a:      SVC   X'0E'      ; =14 [Service call DIRNM - search directory for file name specified]
8d7c:      DW    W907B      ; =0x907b =36987(-28549) [TODO: arg 1]
8d7e:      BNZ   D8D82      ; =+2 [Branch if not zero]
8d80:      JMP   J8DCE      ; =+76 [Jump relative]
8d82:D8D82 XAX              ; [Transfer A to X]
8d83:      LDB+  X          ; [Load B from address in X]
8d84:      LDA+  B,2        ; [Load A indexed, displaced, direct]
8d87:      STA/  W906B      ; =0x906b =36971(-28565) [Store A direct]
8d8a:      A     =1,/N906A(3) ; =0x906a =36970(-28566) [Add bignums, literal=0x01, direct]
8d90:      LDAB+ B,5        ; [Load AL indexed, displaced, direct]
8d93:      LDBB= X'0F'      ; =15 [Load BL with immediate]
8d95:      NABB             ; [AL & BL -> BL]
8d96:      CLRB  BU         ; [Clear BU]
8d98:      ADD=  S9044,B    ; =0x9044 =36932(-28604) [36932 + B -> B]
8d9c:      LDAB+ B          ; [Load AL from address in B]
8d9d:      STAB/ S9063      ; =0x9063 =36963(-28573) [Store AL direct]
8da0:      LDB+  X          ; [Load B from address in X]
8da1:      LDAB+ B,40       ; [Load AL indexed, displaced, direct]
8da4:      STAB/ W9066      ; =0x9066 =36966(-28570) [Store AL direct]
8da7:      LDBB+ B,4        ; [Load BL indexed, displaced, direct]
8daa:      CLA              ; [Clear A]
8dab:      INA              ; [Increment A]
8dac:D8DAC DCRB  BL         ; [Decrement BL by 1]
8dae:      BM    D8DB3      ; =+3 [Branch on minus]
8db0:      SLA              ; [Left shift A]
8db1:      JMP   D8DAC      ; =-7 [Jump relative]
8db3:D8DB3 STA/  W9079      ; =0x9079 =36985(-28551) [Store A direct]
8db6:      LDA+  X          ; [Load A from address in X]
8db7:      LDA+  A,41       ; [Load A indexed, displaced, direct]
8dba:      STA/  W906E      ; =0x906e =36974(-28562) [Store A direct]
8dbd:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8dbf:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8dc0:      DW    S9070      ; =0x9070 =36976(-28560) [address of string date]
*
8dc2:      JSR/  F8F09      ; =0x8f09 =36617(-28919) [Jump to subroutine direct]
8dc5:      STAB/ B9069      ; =0x9069 =36969(-28567) [Store AL direct]
8dc8:      STX   W8DCC      ; =+2 [Store X relative]
8dca:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8dcc:W8DCC DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8dce:J8DCE XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8dd2:      LDAB+ Z          ; [Load AL from address in Z]
8dd3:      BNZ   D8DD8      ; =+3 [Branch if not zero]
8dd5:D8DD5 JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8dd8:D8DD8 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ddb:      DC    '*'        ; hex:aa dec:170(-86)
8ddc:      DB    X'01'      ; =0x01 =1
8ddd:      BNZ   D8DD5      ; =-10 [Branch if not zero]
8ddf:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8de2:      DC    ','        ; hex:ac dec:172(-84)
8de3:      DB    X'01'      ; =0x01 =1
8de4:      LDAB+ Z          ; [Load AL from address in Z]
8de5:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8de8:      BP    D8DED      ; =+3 [Branch on plus]
8dea:      JMP/  J8EAA      ; =0x8eaa =36522(-29014) [Jump direct]
8ded:D8DED JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8df0:      XABB             ; [Transfer AL to BL]
8df1:      BP    D8DF6      ; =+3 [Branch on plus]
8df3:D8DF3 JMP/  J8D5F      ; =0x8d5f =36191(-29345) [Jump direct]
8df6:D8DF6 LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8df9:      SABB             ; [AL - BL -> BL]
8dfa:      BP    D8DF3      ; =-9 [Branch on plus]
8dfc:      CLRB  AU         ; [Clear AU]
8dfe:      SLA              ; [Left shift A]
8dff:      XAB              ; [Transfer A to B]
8e00:      SLA              ; [Left shift A]
8e01:      SLA              ; [Left shift A]
8e02:      AAB              ; [A + B -> B]
8e03:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8e06:      AAB              ; [A + B -> B]
8e07:      STB   W8E61+2    ; =+90 [Store B relative]
8e09:      FIL   (10)=' ',-B ; [Fill with byte, literal=0xa0(160,-96), indexed]
8e0e:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e11:      DC    '='        ; hex:bd dec:189(-67)
8e12:      DB    X'01'      ; =0x01 =1
8e13:      BZ    D8DF3      ; =-34 [Branch if zero]
8e15:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e18:      DC    'CLASS'    ; hex:c3ccc1d3d3
8e1d:      DB    X'01'      ; =0x01 =1
8e1e:      BZ    D8E25      ; =+5 [Branch if zero]
8e20:      LDA=  W9064      ; =0x9064 =36964(-28572) [Load A with immediate]
8e23:      JMP   D8E5E      ; =+57 [Jump relative]
8e25:D8E25 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e28:      DC    'USE'      ; hex:d5d3c5
8e2b:      DB    X'01'      ; =0x01 =1
8e2c:      BZ    D8E33      ; =+5 [Branch if zero]
8e2e:      LDA=  W9067      ; =0x9067 =36967(-28569) [Load A with immediate]
8e31:      JMP   D8E5E      ; =+43 [Jump relative]
8e33:D8E33 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e36:      DC    'IDATE'    ; hex:c9c4c1d4c5
8e3b:      DB    X'01'      ; =0x01 =1
8e3c:      BZ    D8E43      ; =+5 [Branch if zero]
8e3e:      LDA=  W906D      ; =0x906d =36973(-28563) [Load A with immediate]
8e41:      JMP   D8E5E      ; =+27 [Jump relative]
8e43:D8E43 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e46:      DC    'FSI'      ; hex:c6d3c9
8e49:      DB    X'01'      ; =0x01 =1
8e4a:      BZ    D8E51      ; =+5 [Branch if zero]
8e4c:      LDA=  W9078      ; =0x9078 =36984(-28552) [Load A with immediate]
8e4f:      JMP   D8E5E      ; =+13 [Jump relative]
8e51:D8E51 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e54:      DC    'SIZE'     ; hex:d3c9dac5
8e58:      DB    X'01'      ; =0x01 =1
8e59:      BZ    D8E82      ; =+39 [Branch if zero]
8e5b:      LDA=  N906A      ; =0x906a =36970(-28566) [Load A with immediate]
8e5e:D8E5E STK   Y,4        ; [Push Y Z to the stack]
8e60:      XAY              ; [Transfer A to Y]
8e61:W8E61 XFR=  X'0000',Z  ; =0x0000 =0 =NUL,NUL [Transfer immediate to Z]
8e65:      MVF   (10)/S8E78,-Z ; =0x8e78 =36472(-29064), [Move fixed-length, direct, indexed]
8e6b:      CLR   A,10       ; [Set A to 10]
8e6d:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8e6f:      CFB   -Z(10),-Y(3) ; [Convert from bignum, indexed, indexed]
8e73:      POP   Y,4        ; [Pop Z Y from the stack]
8e75:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
*
8e78:S8E78 DC    '@@@@@@@@#@' ; hex:c0c0c0c0c0c0c0c0a3c0
*
8e82:D8E82 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e85:      DC    'DATE'     ; hex:c4c1d4c5
8e89:      DB    X'01'      ; =0x01 =1
8e8a:      BZ    D8E97      ; =+11 [Branch if zero]
8e8c:      LDA   W8E61+2    ; =-43 [Load A relative]
8e8e:      MVF   (8)/S9070,-A ; =0x9070 =36976(-28560), [Move fixed-length, direct, indexed]
8e94:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
8e97:D8E97 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e9a:      DC    'TYPE'     ; hex:d4d9d0c5
8e9e:      DB    X'01'      ; =0x01 =1
8e9f:      BZ    D8EBC      ; =+27 [Branch if zero]
8ea1:      LDAB/ S9063      ; =0x9063 =36963(-28573) [Load AL direct]
8ea4:      LDB   W8E61+2    ; =-67 [Load B relative]
8ea6:      STAB+ B          ; [Store AL to address in B]
8ea7:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
8eaa:J8EAA JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ead:      DC    'UPSI'     ; hex:d5d0d3c9
8eb1:      DB    X'15'      ; =0x15 =21
8eb2:      BNZ   D8EBF      ; =+11 [Branch if not zero]
8eb4:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8eb7:      DC    'CC'       ; hex:c3c3 dec:50115(-61)
8eb9:      DB    X'14'      ; =0x14 =20
8eba:      BNZ   D8EBF      ; =+3 [Branch if not zero]
8ebc:D8EBC JMP/  D8DF3      ; =0x8df3 =36339(-29197) =CR,'s' [Jump direct]
8ebf:D8EBF ADD   A,Y        ; [A + Y -> Y]
8ec1:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ec4:      DC    '='        ; hex:bd dec:189(-67)
8ec5:      DB    X'01'      ; =0x01 =1
8ec6:      BZ    D8EBC      ; =-12 [Branch if zero]
8ec8:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ecb:      DC    'SIZE'     ; hex:d3c9dac5
8ecf:      DB    X'01'      ; =0x01 =1
8ed0:      BZ    D8EE7      ; =+21 [Branch if zero]
8ed2:      LDA/  W906B      ; =0x906b =36971(-28565) [Load A direct]
8ed5:      LDBB/ N906A      ; =0x906a =36970(-28566) [Load BL direct]
8ed8:      BZ    D8EDE      ; =+4 [Branch if zero]
8eda:      XFRB  AU,AU      ; [Transfer AU to AU]
8edc:      BZ    D8EE3      ; =+5 [Branch if zero]
8ede:D8EDE JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8ee1:      DW    X'0009'    ; =0x0009 =9
*
8ee3:D8EE3 STAB+ Y          ; [Store AL to address in Y]
8ee4:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
8ee7:D8EE7 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8eea:      DC    'USE'      ; hex:d5d3c5
8eed:      DB    X'01'      ; =0x01 =1
8eee:      BZ    D8EF7      ; =+7 [Branch if zero]
8ef0:      LDAB/ B9069      ; =0x9069 =36969(-28567) [Load AL direct]
8ef3:      STAB+ Y          ; [Store AL to address in Y]
8ef4:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
8ef7:D8EF7 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8efa:      DC    'CLASS'    ; hex:c3ccc1d3d3
8eff:      DB    X'01'      ; =0x01 =1
8f00:      BZ    D8EBC      ; =-70 [Branch if zero]
8f02:      LDAB/ W9066      ; =0x9066 =36966(-28570) [Load AL direct]
8f05:      STAB+ Y          ; [Store AL to address in Y]
8f06:      JMP/  J8DCE      ; =0x8dce =36302(-29234) =CR,'N' [Jump direct]
*
* Function F8F09
*
8f09:F8F09 LDA+  S          ; [Load A from address in S]
8f0a:      LDA+  A          ; [Load A from address in A]
8f0b:      STA   W8F27+1    ; =+27 [Store A relative]
8f0d:      XFR   Z,A        ; [Transfer Z to A]
8f0f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f11:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8f14:      LDA+  B,17       ; [Load A indexed, displaced, direct]
8f17:      XAY              ; [Transfer A to Y]
8f18:      LDA+  B,13       ; [Load A indexed, displaced, direct]
8f1b:      XAZ              ; [Transfer A to Z]
8f1c:D8F1C LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f1e:      BM    D8F45      ; =+37 [Branch on minus]
8f20:B8F20 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8f22:      SABB             ; [AL - BL -> BL]
8f23:      BNZ   D8F45      ; =+32 [Branch if not zero]
8f25:      LDB+  Z          ; [Load B from address in Z]
8f26:      LDB+  B          ; [Load B from address in B]
8f27:W8F27 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8f2a:      CPF   (21)-A,9,-B,9 ; [Compare fixed-length, displaced indexed, displaced indexed]
8f31:      BNZ   D8F45      ; =+18 [Branch if not zero]
8f33:      LDA+  Z          ; [Load A from address in Z]
8f34:      LDB=  X'0200'    ; =0x0200 =512 [Load B with immediate]
8f37:      LDAB+ A,3        ; [Load AL indexed, displaced, direct]
8f3a:      LDBB= X'04'      ; =4 [Load BL with immediate]
8f3c:      NABB             ; [AL & BL -> BL]
8f3d:      BNZ   D8F41      ; =+2 [Branch if not zero]
8f3f:      INRB  BU         ; [Increment BU by 1]
8f41:D8F41 XFRB  BU,AL      ; [Transfer BU to AL]
8f43:      JMP   D8F4D      ; =+8 [Jump relative]
8f45:D8F45 LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8f47:      DCR   Y          ; [Decrement Y by 1]
8f49:      BP    D8F1C      ; =-47 [Branch on plus]
8f4b:      LDAB= X'01'      ; =1 [Load AL with immediate]
8f4d:D8F4D LDB+  S+         ; [Load B indexed, direct, post-incremented]
8f4f:      XFR   B,Z        ; [Transfer B to Z]
8f51:      RSR              ; [Return from subroutine]
*
8f52:J8F52 JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8f55:      LDB=  X'2000'    ; =0x2000 =8192 [Load B with immediate]
8f58:      LDBB+ A          ; [Load BL from address in A]
8f59:      ANDB  BU,BL      ; [BU & BL -> BL]
8f5b:      STBB/ B9005+1    ; =0x9006 =36870(-28666) [Store BL direct]
8f5e:      LDBB+ A,1        ; [Load BL indexed, displaced, direct]
8f61:      STBB/ B9019+1    ; =0x901a =36890(-28646) [Store BL direct]
8f64:J8F64 LDA/  W80B1      ; =0x80b1 =32945(-32591) [Load A direct]
8f67:      XAY              ; [Transfer A to Y]
8f68:      LDAB+ Z          ; [Load AL from address in Z]
8f69:      BNZ   D8F6E      ; =+3 [Branch if not zero]
8f6b:D8F6B JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8f6e:D8F6E JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f71:      DC    '*'        ; hex:aa dec:170(-86)
8f72:      DB    X'01'      ; =0x01 =1
8f73:      BNZ   D8F6B      ; =-10 [Branch if not zero]
8f75:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f78:      DC    ','        ; hex:ac dec:172(-84)
8f79:      DB    X'01'      ; =0x01 =1
8f7a:      LDAB+ Z          ; [Load AL from address in Z]
8f7b:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f7e:      BP    D8F83      ; =+3 [Branch on plus]
8f80:      JMP/  J8FDB      ; =0x8fdb =36827(-28709) [Jump direct]
8f83:D8F83 JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8f86:      XABB             ; [Transfer AL to BL]
8f87:      BP    D8F8C      ; =+3 [Branch on plus]
8f89:D8F89 JMP/  J8D5F      ; =0x8d5f =36191(-29345) [Jump direct]
8f8c:D8F8C LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8f8f:      SABB             ; [AL - BL -> BL]
8f90:      BP    D8F89      ; =-9 [Branch on plus]
8f92:      CLRB  AU         ; [Clear AU]
8f94:      MUL=  X'000A',A  ; =0x000a =10 [10 * A -> A,B]
8f98:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8f9b:      AAB              ; [A + B -> B]
8f9c:      FIL   (10)=' ',-B ; [Fill with byte, literal=0xa0(160,-96), indexed]
8fa1:      INR   B,9        ; [Increment B by 9]
8fa3:      STB   W8FD4+1    ; =+48 [Store B relative]
8fa5:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fa8:      DC    '='        ; hex:bd dec:189(-67)
8fa9:      DB    X'01'      ; =0x01 =1
8faa:      BZ    D8F89      ; =-35 [Branch if zero]
8fac:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8faf:      DC    'STATUS'   ; hex:d3d4c1d4d5d3
8fb5:      DB    X'01'      ; =0x01 =1
8fb6:      BZ    D8FCA      ; =+18 [Branch if zero]
8fb8:      LDA   W8FD4+1    ; =+27 [Load A relative]
8fba:      LDBB  B9005+1    ; =+74 [Load BL relative]
8fbc:      BZ    D8FC2      ; =+4 [Branch if zero]
8fbe:      CLR   B          ; [Clear B]
8fc0:      INR   B          ; [Increment B by 1]
8fc2:D8FC2 ORI=  X'00B0',B  ; =0x00b0 =176 =NUL,'0' [176 | B -> B]
8fc6:      STBB+ A          ; [Store BL to address in A]
8fc7:      JMP/  J8F64      ; =0x8f64 =36708(-28828) [Jump direct]
8fca:D8FCA JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fcd:      DC    'TYPE'     ; hex:d4d9d0c5
8fd1:      DB    X'01'      ; =0x01 =1
8fd2:      BZ    D8F89      ; =-75 [Branch if zero]
8fd4:W8FD4 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8fd7:      LDBB  B9019+1    ; =+65 [Load BL relative]
8fd9:      JMP   D8FC2      ; =-25 [Jump relative]
8fdb:J8FDB JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fde:      DC    'UPSI'     ; hex:d5d0d3c9
8fe2:      DB    X'15'      ; =0x15 =21
8fe3:      BNZ   D8FF0      ; =+11 [Branch if not zero]
8fe5:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fe8:      DC    'CC'       ; hex:c3c3 dec:50115(-61)
8fea:      DB    X'14'      ; =0x14 =20
8feb:      BNZ   D8FF0      ; =+3 [Branch if not zero]
8fed:D8FED JMP/  J8D5F      ; =0x8d5f =36191(-29345) [Jump direct]
8ff0:D8FF0 ADD   A,Y        ; [A + Y -> Y]
8ff2:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ff5:      DC    '='        ; hex:bd dec:189(-67)
8ff6:      DB    X'01'      ; =0x01 =1
8ff7:      BZ    D8FED      ; =-12 [Branch if zero]
8ff9:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ffc:      DC    'STATUS'   ; hex:d3d4c1d4d5d3
9002:      DB    X'01'      ; =0x01 =1
9003:      BZ    D900F      ; =+10 [Branch if zero]
9005:B9005 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
9007:      BZ    D900B      ; =+2 [Branch if zero]
9009:      CLA              ; [Clear A]
900a:      INA              ; [Increment A]
900b:D900B STAB+ Y          ; [Store AL to address in Y]
900c:      JMP/  J8F64      ; =0x8f64 =36708(-28828) [Jump direct]
900f:D900F JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9012:      DC    'TYPE'     ; hex:d4d9d0c5
9016:      DB    X'01'      ; =0x01 =1
9017:      BZ    D8FED      ; =-44 [Branch if zero]
9019:B9019 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
901b:      JMP   D900B      ; =-18 [Jump relative]
*
* Function F901D
*
901d:F901D LDA+  X+         ; [Load A indexed, direct, post-incremented]
901f:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9021:      XAX              ; [Transfer A to X]
9022:D9022 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
9024:      BZ    D903C      ; =+22 [Branch if zero]
9026:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9028:      SABB             ; [AL - BL -> BL]
9029:      BZ    D903C      ; =+17 [Branch if zero]
902b:      LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
902d:      SABB             ; [AL - BL -> BL]
902e:      BZ    D903E      ; =+14 [Branch if zero]
9030:      LDBB+ X          ; [Load BL from address in X]
9031:      BNZ   D9038      ; =+5 [Branch if not zero]
9033:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
9036:      DW    X'000B'    ; =0x000b =11
*
9038:D9038 STAB+ X+         ; [Store AL indexed, direct, post-incremented]
903a:      JMP   D9022      ; =-26 [Jump relative]
903c:D903C DCR   Z          ; [Decrement Z by 1]
903e:D903E JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
9041:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9043:      RSR              ; [Return from subroutine]
*
9044:S9044 DC    'DBACELISQ' ; hex:c4c2c1c3c5ccc9d3d1
904d:S904D DC    '                     '
9062:      DB    X'00'      ; =0x00 =0 =NUL
9063:S9063 DC    ' '        ; hex:a0 dec:160(-96)
9064:W9064 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9066:W9066 DS    1          ; =0x0001 [Uninitialized memory]
9067:W9067 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9069:B9069 DS    1          ; =0x0001 [Uninitialized memory]
906a:N906A DS    1          ; =0x0001 [Uninitialized memory]
906b:W906B DS    2          ; =0x0002 [Uninitialized memory]
906d:W906D DB    X'00'      ; =0x00 =0 =NUL
906e:W906E DS    2          ; =0x0002 [Uninitialized memory]
9070:S9070 DS    8          ; =0x0008 [Uninitialized memory]
9078:W9078 DB    X'00'      ; =0x00 =0 =NUL
9079:W9079 DS    2          ; =0x0002 [Uninitialized memory]
907b:W907B DS    402        ; =0x0192 [Uninitialized memory]
920d:      DB    X'00'      ; =0x00 =0 =NUL
920e:ENDPT
