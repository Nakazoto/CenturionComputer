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
8236:W8236 DS    72         ; =0x0048 [Uninitialized memory]
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
* Function F82EA
*
82ea:F82EA DS    19         ; =0x0013 [Uninitialized memory]
*
*
* Function F82FD
*
82fd:F82FD DS    48         ; =0x0030 [Uninitialized memory]
*
*
* Function F832D
*
832d:F832D DS    20         ; =0x0014 [Uninitialized memory]
*
*
* Function F8341
*
8341:F8341 DS    765        ; =0x02fd [Uninitialized memory]
863e:W863E DS    2          ; =0x0002 [Uninitialized memory]
8640:W8640 DS    110        ; =0x006e [Uninitialized memory]
86ae:S86AE DS    1          ; =0x0001 [Uninitialized memory]
86af:W86AF DS    1          ; =0x0001 [Uninitialized memory]
86b0:W86B0 DS    1          ; =0x0001 [Uninitialized memory]
86b1:W86B1 DS    1662       ; =0x067e [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d36:      BM    D8D48      ; =+16 [Branch on minus]
8d38:      LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
8d3b:      SAB              ; [A - B -> B]
8d3c:      BGZ   D8D48      ; =+10 [Branch if greater than zero]
8d3e:      LDB=  W8D4D      ; =0x8d4d =36173(-29363) [Load B with immediate]
8d41:      SLA              ; [Left shift A]
8d42:      AAB              ; [A + B -> B]
8d43:      LDA+  B          ; [Load A from address in B]
8d44:      BZ    D8D48      ; =+2 [Branch if zero]
8d46:      JMP+  A          ; [Jump indexed, direct]
8d48:D8D48 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d4b:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8d4d:W8D4D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8d4f:      DW    W8F56      ; =0x8f56 =36694(-28842)
8d51:      DW    W8DEF      ; =0x8def =36335(-29201) =CR,'o'
8d53:      DW    W8D63      ; =0x8d63 =36195(-29341)
8d55:      DW    W8D71      ; =0x8d71 =36209(-29327)
8d57:      DW    W8DD3      ; =0x8dd3 =36307(-29229) =CR,'S'
8d59:      DW    W8D82      ; =0x8d82 =36226(-29310)
8d5b:      DW    W8D9D      ; =0x8d9d =36253(-29283)
8d5d:      DW    W8DAA      ; =0x8daa =36266(-29270) =CR,'*'
8d5f:      DW    W8DB8      ; =0x8db8 =36280(-29256) =CR,'8'
8d61:      DW    W8DC5      ; =0x8dc5 =36293(-29243) =CR,'E'
*
8d63:W8D63 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8d66:      LDA+  A          ; [Load A from address in A]
8d67:      XAY              ; [Transfer A to Y]
8d68:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8d6b:      LDBB= X'01'      ; =1 [Load BL with immediate]
8d6d:      ORIB  AL,BL      ; [AL | BL -> BL]
8d6f:      JMP   D8D7C      ; =+11 [Jump relative]
8d71:W8D71 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8d74:      LDA+  A          ; [Load A from address in A]
8d75:      XAY              ; [Transfer A to Y]
8d76:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8d79:      LDBB= X'FE'      ; =254(-2) ='~' [Load BL with immediate]
8d7b:      NABB             ; [AL & BL -> BL]
8d7c:D8D7C STBB+ Y,18       ; [Store BL indexed, displaced, direct]
8d7f:D8D7F JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8d82:W8D82 SVC   X'1C'      ; =28 [Service call GC - get character time]
8d84:      DW    S86AE      ; =0x86ae =34478(-31058) [address to put time]
8d86:      LDA/  S86AE      ; =0x86ae =34478(-31058) [Load A direct]
8d89:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
8d8c:      SAB              ; [A - B -> B]
8d8d:      BZ    D8D7F      ; =-16 [Branch if zero]
8d8f:      JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8d92:      LDA+  A          ; [Load A from address in A]
8d93:      XAY              ; [Transfer A to Y]
8d94:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8d97:      LDBB= X'20'      ; =32 [Load BL with immediate]
8d99:      ORIB  AL,BL      ; [AL | BL -> BL]
8d9b:      JMP   D8D7C      ; =-33 [Jump relative]
8d9d:W8D9D JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8da0:      LDA+  A          ; [Load A from address in A]
8da1:      XAY              ; [Transfer A to Y]
8da2:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8da5:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
8da7:      NABB             ; [AL & BL -> BL]
8da8:      JMP   D8D7C      ; =-46 [Jump relative]
8daa:W8DAA JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8dad:      LDA+  A          ; [Load A from address in A]
8dae:      XAY              ; [Transfer A to Y]
8daf:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8db2:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
8db4:      ORIB  AL,BL      ; [AL | BL -> BL]
8db6:      JMP   D8D7C      ; =-60 [Jump relative]
8db8:W8DB8 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8dbb:      LDA+  A          ; [Load A from address in A]
8dbc:      XAY              ; [Transfer A to Y]
8dbd:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8dc0:      LDBB= X'7F'      ; =127 [Load BL with immediate]
8dc2:      NABB             ; [AL & BL -> BL]
8dc3:      JMP   D8D7C      ; =-73 [Jump relative]
8dc5:W8DC5 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8dc8:      LDA+  A          ; [Load A from address in A]
8dc9:      XAY              ; [Transfer A to Y]
8dca:      LDAB+ Y          ; [Load AL from address in Y]
8dcb:      LDBB= X'08'      ; =8 [Load BL with immediate]
8dcd:      ORIB  AL,BL      ; [AL | BL -> BL]
8dcf:      STBB+ Y          ; [Store BL to address in Y]
8dd0:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8dd3:W8DD3 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8dd6:      LDA+  A          ; [Load A from address in A]
8dd7:      XAY              ; [Transfer A to Y]
8dd8:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8ddb:      XAB              ; [Transfer A to B]
8ddc:      BM    D8DE4      ; =+6 [Branch on minus]
8dde:      LDB=  X'007F'    ; =0x007f =127 [Load B with immediate]
8de1:      SAB              ; [A - B -> B]
8de2:      BLE   D8DE9      ; =+5 [Branch if less than or equal to zero]
8de4:D8DE4 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8de7:      DW    X'0009'    ; =0x0009 =9
*
8de9:D8DE9 STAB+ Y,3        ; [Store AL indexed, displaced, direct]
8dec:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8def:W8DEF JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8df2:      LDA+  A          ; [Load A from address in A]
8df3:W8DF3 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8df6:      LDB/  W80B1      ; =0x80b1 =32945(-32591) [Load B direct]
8df9:      SAB              ; [A - B -> B]
8dfa:      BZ    D8E6A      ; =+110 [Branch if zero]
8dfc:      XAY              ; [Transfer A to Y]
8dfd:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8e00:      LDB+  A,31       ; [Load B indexed, displaced, direct]
8e03:      BZ    D8E47      ; =+66 [Branch if zero]
8e05:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e08:      DC    ','        ; hex:ac dec:172(-84)
8e09:      DB    X'01'      ; =0x01 =1
8e0a:      XFR   Z,A        ; [Transfer Z to A]
8e0c:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8e0e:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e11:      DC    'CODE='    ; hex:c3cfc4c5bd
8e16:      DB    X'01'      ; =0x01 =1
8e17:      BNZ   D8E1C      ; =+3 [Branch if not zero]
8e19:D8E19 JMP/  D8D48      ; =0x8d48 =36168(-29368) [Jump direct]
8e1c:D8E1C JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8e1f:      DW    S9072      ; =0x9072 =36978(-28558)
8e21:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8e24:      CPF   (6)/S9072,-A,31 ; =0x9072 =36978(-28558), [Compare fixed-length, direct, displaced indexed]
8e2b:      BNZ   D8E19      ; =-20 [Branch if not zero]
8e2d:      LDB+  S          ; [Load B from address in S]
8e2e:      XFR   Z,A        ; [Transfer Z to A]
8e30:      SAB              ; [A - B -> B]
8e31:      LDA/  W863E      ; =0x863e =34366(-31170) [Load A direct]
8e34:      SAB              ; [A - B -> B]
8e35:      STB/  W863E      ; =0x863e =34366(-31170) [Store B direct]
8e38:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8e3a:      XFR   Z,A        ; [Transfer Z to A]
8e3c:      STK   Y,2        ; [Push Y to the stack]
8e3e:      MVV   (80,0)-A,-B ; [Move variable-length, indexed, indexed]
8e43:      POP   Y,2        ; [Pop Y from the stack]
8e45:      XFR   B,Z        ; [Transfer B to Z]
8e47:D8E47 LDAB+ Y          ; [Load AL from address in Y]
8e48:      LDBB= X'01'      ; =1 [Load BL with immediate]
8e4a:      NABB             ; [AL & BL -> BL]
8e4b:      BZ    D8E65      ; =+24 [Branch if zero]
8e4d:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8e50:      LDBB+ A,19       ; [Load BL indexed, displaced, direct]
8e53:      LDAB= X'80'      ; =128(-128) [Load AL with immediate]
8e55:      NABB             ; [AL & BL -> BL]
8e56:      BNZ   D8E60      ; =+8 [Branch if not zero]
8e58:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8e5b:      LDBB= X'0C'      ; =12 [Load BL with immediate]
8e5d:      NABB             ; [AL & BL -> BL]
8e5e:      BZ    D8E6A      ; =+10 [Branch if zero]
8e60:D8E60 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e63:      DW    X'0005'    ; =0x0005 =5
*
8e65:D8E65 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e68:      DW    X'0008'    ; =0x0008 =8
*
8e6a:D8E6A LDA/  W863E      ; =0x863e =34366(-31170) [Load A direct]
8e6d:      BP    D8E74      ; =+5 [Branch on plus]
8e6f:      STAB/ B8F21+1    ; =0x8f22 =36642(-28894) [Store AL direct]
8e72:      JMP   D8EA0      ; =+44 [Jump relative]
8e74:D8E74 DCA              ; [Decrement A]
8e75:      MVFR  /W8640,/W86B1 ; =0x8640 =34368(-31168),=0x86b1 =34481(-31055) [Move fixed-length (len in AL), direct, direct]
8e7b:      INR   A,3        ; [Increment A by 3]
8e7d:      STA/  S86AE      ; =0x86ae =34478(-31058) [Store A direct]
8e80:      ADD=  W86AF,A    ; =0x86af =34479(-31057) [34479 + A -> A]
8e84:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
8e86:      STBB+ A          ; [Store BL to address in A]
8e87:      LDA=  S86AE      ; =0x86ae =34478(-31058) [Load A with immediate]
8e8a:      STA/  S9062      ; =0x9062 =36962(-28574) [Store A direct]
8e8d:      CLRB  AL,2       ; [Set AL to 2]
8e8f:      MVF   (2)='@@',/W86B0 ; =0x86b0 =34480(-31056) [Move fixed-length, literal=0xc0c0(49344,-64), direct]
8e96:      LDB/  W80B1      ; =0x80b1 =32945(-32591) [Load B direct]
8e99:      CFB   /W86B0(10),-B,1(1) ; =0x86b0 =34480(-31056), [Convert from bignum, direct, displaced indexed]
8ea0:D8EA0 LDB/  W8DF3+1    ; =0x8df4 =36340(-29196) =CR,'t' [Load B direct]
8ea3:      LDB+  B,8        ; [Load B indexed, displaced, direct]
8ea6:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8ea8:      CLA              ; [Clear A]
8ea9:      STA+  B,13       ; [Store A indexed, displaced, direct]
8eac:      XFR/  W8DF3+1,Y  ; =0x8df4 =36340(-29196) =CR,'t' [Transfer direct to Y]
8eb0:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
8eb2:      STAB  B8EBB+1    ; =+8 [Store AL relative]
8eb4:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
8eb7:      XAZ              ; [Transfer A to Z]
8eb8:D8EB8 LDAB  B8EBB+1    ; =+2 [Load AL relative]
8eba:      INAB             ; [Increment AL]
8ebb:B8EBB STAB= X'00'      ; =0 =NUL [Store AL immediate]
8ebd:      LDBB+ Y,7        ; [Load BL indexed, displaced, direct]
8ec0:      SABB             ; [AL - BL -> BL]
8ec1:      BGZ   D8F00      ; =+61 [Branch if greater than zero]
8ec3:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8ec6:      LDB+  B,9        ; [Load B indexed, displaced, direct]
8ec9:      CLA              ; [Clear A]
8eca:      LDAB+ Z          ; [Load AL from address in Z]
8ecb:      BM    D8EE9      ; =+28 [Branch on minus]
8ecd:      SLA              ; [Left shift A]
8ece:      AAB              ; [A + B -> B]
8ecf:      LDA+  B          ; [Load A from address in B]
8ed0:      LDB=  X'1000'    ; =0x1000 =4096 [Load B with immediate]
8ed3:      LDBB+ A          ; [Load BL from address in A]
8ed4:      ANDB  BL,BU      ; [BL & BU -> BU]
8ed6:      BNZ   D8EE2      ; =+10 [Branch if not zero]
8ed8:      LDB=  X'0400'    ; =0x0400 =1024 [Load B with immediate]
8edb:      LDBB+ A          ; [Load BL from address in A]
8edc:      BZ    D8EE9      ; =+11 [Branch if zero]
8ede:      ANDB  BL,BU      ; [BL & BU -> BU]
8ee0:      BNZ   D8EE9      ; =+7 [Branch if not zero]
8ee2:D8EE2 XFRB  BL,BU      ; [Transfer BL to BU]
8ee4:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
8ee6:      ANDB  BU,BL      ; [BU & BL -> BL]
8ee8:      STBB+ A          ; [Store BL to address in A]
8ee9:D8EE9 LDA+  Z,1        ; [Load A indexed, displaced, direct]
8eec:      XAB              ; [Transfer A to B]
8eed:      INA              ; [Increment A]
8eee:      BZ    D8EF6      ; =+6 [Branch if zero]
8ef0:      STB   W8EF4      ; =+2 [Store B relative]
8ef2:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8ef4:W8EF4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8ef6:D8EF6 CLA              ; [Clear A]
8ef7:      DCA              ; [Decrement A]
8ef8:      STA+  Z          ; [Store A to address in Z]
8ef9:      STAB+ Z,2        ; [Store AL indexed, displaced, direct]
8efc:      INR   Z,3        ; [Increment Z by 3]
8efe:      JMP   D8EB8      ; =-72 [Jump relative]
8f00:D8F00 XFR=  S9066,Z    ; =0x9066 =36966(-28570) [Transfer immediate to Z]
8f04:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8f07:      STA+  Y,8        ; [Store A indexed, displaced, direct]
8f0a:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
8f0d:      XFRB  BL,BU      ; [Transfer BL to BU]
8f0f:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8f11:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8f13:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
8f15:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8f17:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
8f19:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8f1b:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
8f1d:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8f1f:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
8f21:B8F21 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8f23:      BNZ   D8F2C      ; =+7 [Branch if not zero]
8f25:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f27:      JSR/  F9040      ; =0x9040 =36928(-28608) [Jump to subroutine direct]
8f2a:      DW    W905C      ; =0x905c =36956(-28580)
*
8f2c:D8F2C XFR/  W8DF3+1,Z  ; =0x8df4 =36340(-29196) =CR,'t' [Transfer direct to Z]
8f30:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8f33:      XAY              ; [Transfer A to Y]
8f34:D8F34 LDAB+ Y,31       ; [Load AL indexed, displaced, direct]
8f37:      BM    D8F3D      ; =+4 [Branch on minus]
8f39:D8F39 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8f3b:      JMP   D8F34      ; =-9 [Jump relative]
8f3d:D8F3D LDAB+ Y,59       ; [Load AL indexed, displaced, direct]
8f40:      BP    D8F39      ; =-9 [Branch on plus]
8f42:      LDAB= X'01'      ; =1 [Load AL with immediate]
8f44:      STAB+ Y,37       ; [Store AL indexed, displaced, direct]
8f47:      CLRB  AL,1       ; [Set AL to 1]
8f49:      STAB+ Z          ; [Store AL to address in Z]
8f4a:      CLAB             ; [Clear AL]
8f4b:      STAB+ Z,18       ; [Store AL indexed, displaced, direct]
8f4e:      LDA=  X'8000'    ; =0x8000 =32768(-32768) [Load A with immediate]
8f51:      SVC   X'63'      ; =99 [Service call RSEGX - release other part memory]
8f53:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8f56:W8F56 JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8f59:      LDA+  A          ; [Load A from address in A]
8f5a:      XAY              ; [Transfer A to Y]
8f5b:      STA/  W8DF3+1    ; =0x8df4 =36340(-29196) =CR,'t' [Store A direct]
8f5e:      LDAB+ Y          ; [Load AL from address in Y]
8f5f:      BZ    D8F66      ; =+5 [Branch if zero]
8f61:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f64:      DW    X'0002'    ; =0x0002 =2
*
8f66:D8F66 JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8f69:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f6c:      DC    'WITH'     ; hex:d7c9d4c8
8f70:      DB    X'01'      ; =0x01 =1
8f71:      BNZ   D8F89      ; =+22 [Branch if not zero]
8f73:      LDAB+ Z          ; [Load AL from address in Z]
8f74:      BNZ   D8F7B      ; =+5 [Branch if not zero]
8f76:D8F76 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f79:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8f7b:D8F7B XFR   Z,A        ; [Transfer Z to A]
8f7d:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f7f:      LDA=  S906C      ; =0x906c =36972(-28564) [Load A with immediate]
8f82:      JSR   F8FFB      ; =+119 [Jump to subroutine relative]
8f84:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f86:      XAZ              ; [Transfer A to Z]
8f87:      JMP   D8FB6      ; =+45 [Jump relative]
8f89:D8F89 XFR   Z,A        ; [Transfer Z to A]
8f8b:      JSR   F8FFB      ; =+110 [Jump to subroutine relative]
8f8d:      LDB+  Y,8        ; [Load B indexed, displaced, direct]
8f90:      LDA+  B,31       ; [Load A indexed, displaced, direct]
8f93:      BZ    D8FB6      ; =+33 [Branch if zero]
8f95:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f98:      DC    ','        ; hex:ac dec:172(-84)
8f99:      DB    X'01'      ; =0x01 =1
8f9a:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f9d:      DC    'CODE='    ; hex:c3cfc4c5bd
8fa2:      DB    X'01'      ; =0x01 =1
8fa3:      BZ    D8F76      ; =-47 [Branch if zero]
8fa5:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8fa8:      DW    S9072      ; =0x9072 =36978(-28558)
8faa:      LDB+  Y,8        ; [Load B indexed, displaced, direct]
8fad:      CPF   (6)/S9072,-B,31 ; =0x9072 =36978(-28558), [Compare fixed-length, direct, displaced indexed]
8fb4:      BNZ   D8F76      ; =-64 [Branch if not zero]
8fb6:D8FB6 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fb9:      DC    ','        ; hex:ac dec:172(-84)
8fba:      DB    X'01'      ; =0x01 =1
8fbb:      SVC   X'16'      ; =22 [Service call GMEM - get memory block from transient area]
8fbd:      DW    X'0078'    ; =0x0078 =120 [TODO: arg1] [TODO: arg2]
8fbf:W8FBF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8fc1:      LDA   W8FBF      ; =-4 [Load A relative]
8fc3:      STA+  Y,41       ; [Store A indexed, displaced, direct]
8fc6:      LDBB= X'7F'      ; =127 [Load BL with immediate]
8fc8:      STBB+ A,-1       ; [Store BL indexed, displaced, direct]
8fcb:      INR   A,2        ; [Increment A by 2]
8fcd:      XAY              ; [Transfer A to Y]
8fce:      CLA              ; [Clear A]
8fcf:D8FCF LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8fd1:      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
8fd3:      BZ    D8FD8      ; =+3 [Branch if zero]
8fd5:      INA              ; [Increment A]
8fd6:      JMP   D8FCF      ; =-9 [Jump relative]
8fd8:D8FD8 LDB   W8FBF      ; =-27 [Load B relative]
8fda:      STA+  B          ; [Store A to address in B]
8fdb:      LDB/  W8DF3+1    ; =0x8df4 =36340(-29196) =CR,'t' [Load B direct]
8fde:      CLA              ; [Clear A]
8fdf:      STA+  B,16       ; [Store A indexed, displaced, direct]
8fe2:      LDAB= X'01'      ; =1 [Load AL with immediate]
8fe4:      STAB+ B          ; [Store AL to address in B]
8fe5:      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8fe8:      STA+  B,52       ; [Store A indexed, displaced, direct]
8feb:      STA+  B,50       ; [Store A indexed, displaced, direct]
8fee:      LDA+  B,18       ; [Load A indexed, displaced, direct]
8ff1:      LDAB= X'40'      ; =64 [Load AL with immediate]
8ff3:      ORIB  AU,AL      ; [AU | AL -> AL]
8ff5:      STAB+ B,18       ; [Store AL indexed, displaced, direct]
8ff8:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8FFB
*
8ffb:F8FFB XAZ              ; [Transfer A to Z]
8ffc:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8fff:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
9001:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
9003:      LDAB+ A          ; [Load AL from address in A]
9004:      LDBB= X'3C'      ; =60 [Load BL with immediate]
9006:      ORIB  BL,AL      ; [BL | AL -> AL]
9008:      INAB             ; [Increment AL]
9009:      BZ    D9010      ; =+5 [Branch if zero]
900b:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
900e:      DW    X'0006'    ; =0x0006 =6
*
9010:D9010 LDA+  S+         ; [Load A indexed, direct, post-incremented]
9012:      LDBB+ A,26       ; [Load BL indexed, displaced, direct]
9015:      STBB+ Y,40       ; [Store BL indexed, displaced, direct]
9018:      XFR   Y,B        ; [Transfer Y to B]
901a:      STB+  A,13       ; [Store B indexed, displaced, direct]
901d:      STA+  Y,8        ; [Store A indexed, displaced, direct]
9020:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
9023:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
9025:      XFRB  BL,BU      ; [Transfer BL to BU]
9027:      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
9029:      STB+  A+         ; [Store B indexed, direct, post-incremented]
902b:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
902d:      STB+  A+         ; [Store B indexed, direct, post-incremented]
902f:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
9031:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9033:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
9035:      STB+  A+         ; [Store B indexed, direct, post-incremented]
9037:      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
9039:      RSR              ; [Return from subroutine]
*
* Function F903A
*
903a:F903A LDB/  W8DF3+1    ; =0x8df4 =36340(-29196) =CR,'t' [Load B direct]
903d:      LDA+  B,8        ; [Load A indexed, displaced, direct]
*
* Function F9040
*
9040:F9040 LDB+  X          ; [Load B from address in X]
9041:      SVC   X'0F'      ; =15 [Service call CONIO - console I/O]
9043:D9043 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
9045:      LDB+  X          ; [Load B from address in X]
9046:      LDAB+ B          ; [Load AL from address in B]
9047:      BM    D9043      ; =-6 [Branch on minus]
9049:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
904b:      RSR              ; [Return from subroutine]
*
904c:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
904e:      STA   W9055      ; =+5 [Store A relative]
9050:      STA   S9062      ; =+16 [Store A relative]
9052:      JSR/  F907C      ; =0x907c =36988(-28548) [Jump to subroutine direct]
9055:W9055 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
9057:      JSR   F903A      ; =-31 [Jump to subroutine relative]
9059:      DW    W905C      ; =0x905c =36956(-28580)
905b:      RSR              ; [Return from subroutine]
*
905c:W905C DW    X'0081'    ; =0x0081 =129
905e:      DB    X'00'      ; =0x00 =0 =NUL
905f:      DW    X'0200'    ; =0x0200 =512
9061:      DB    X'84'      ; =0x84 =132(-124) =EOT
9062:S9062 DB    0,4        ; =0x00,0x0004
9066:S9066 DC    'DUMMY '   ; hex:c4d5cdcdd9a0
906c:S906C DC    'BLIND '   ; hex:c2ccc9cec4a0
9072:S9072 DC    '          ' ; hex:a0a0a0a0a0a0a0a0a0a0
*
* Function F907C
*
907c:F907C LDA+  X+         ; [Load A indexed, direct, post-incremented]
907e:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9080:      XFR   Y,X        ; [Transfer Y to X]
9082:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
9084:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
9086:      XAY              ; [Transfer A to Y]
9087:D9087 DCX              ; [Decrement X]
9088:      BM    D909D      ; =+19 [Branch on minus]
908a:      LDAB+ Y          ; [Load AL from address in Y]
908b:      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
908d:      SABB             ; [AL - BL -> BL]
908e:      BM    D9099      ; =+9 [Branch on minus]
9090:      LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
9092:      SABB             ; [AL - BL -> BL]
9093:      BGZ   D9099      ; =+4 [Branch if greater than zero]
9095:      LDBB= X'20'      ; =32 [Load BL with immediate]
9097:      ORIB  BL,AL      ; [BL | AL -> AL]
9099:D9099 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
909b:      JMP   D9087      ; =-22 [Jump relative]
909d:D909D LDA+  S+         ; [Load A indexed, direct, post-incremented]
909f:      XAY              ; [Transfer A to Y]
90a0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
90a2:      RSR              ; [Return from subroutine]
*
90a3:ENDPT
