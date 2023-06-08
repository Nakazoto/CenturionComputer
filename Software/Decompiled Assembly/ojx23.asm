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
825f:F825F DS    63         ; =0x003f [Uninitialized memory]
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
82ea:F82EA DS    67         ; =0x0043 [Uninitialized memory]
*
*
* Function F832D
*
832d:F832D DS    20         ; =0x0014 [Uninitialized memory]
*
*
* Function F8341
*
8341:F8341 DS    2542       ; =0x09ee [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  X'005A',Y  ; =0x005a =90 [Transfer direct to Y]
8d33:      LDA=  W9108      ; =0x9108 =37128(-28408) [Load A with immediate]
8d36:      STA/  W90FE      ; =0x90fe =37118(-28418) [Store A direct]
8d39:      CAD/  W8F4C      ; [Clear word at address]
8d3d:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8d40:      STA/  W8F29+1    ; =0x8f2a =36650(-28886) [Store A direct]
8d43:      LDBB+ A,2        ; [Load BL indexed, displaced, direct]
8d46:      STBB/ B9100      ; =0x9100 =37120(-28416) [Store BL direct]
8d49:      LDB+  A,17       ; [Load B indexed, displaced, direct]
8d4c:      STB/  W8F00+1    ; =0x8f01 =36609(-28927) [Store B direct]
8d4f:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
8d52:      LDBB= X'04'      ; =4 [Load BL with immediate]
8d54:      SABB             ; [AL - BL -> BL]
8d55:      BZ    D8D5C      ; =+5 [Branch if zero]
8d57:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d5a:      DW    X'0006'    ; =0x0006 =6
*
8d5c:D8D5C LDAB/ B9100      ; =0x9100 =37120(-28416) [Load AL direct]
8d5f:      SVC   X'14'      ; =20 [Service call DRDY - disk ready check]
8d61:      STBB/ B8E4E+1    ; =0x8e4f =36431(-29105) [Store BL direct]
8d64:      BNZ   D8D6E      ; =+8 [Branch if not zero]
8d66:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d69:      BZ    D8D6E      ; =+3 [Branch if zero]
8d6b:      JMP/  J8E2E      ; =0x8e2e =36398(-29138) [Jump direct]
8d6e:D8D6E CAD/  W913D      ; [Clear word at address]
8d72:      CAD/  W9179      ; [Clear word at address]
8d76:      LDAB= X'0E'      ; =14 [Load AL with immediate]
8d78:      STAB/ B913F      ; =0x913f =37183(-28353) [Store AL direct]
8d7b:      JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8d7e:      DB    X'81'      ; =0x81 =129(-127)
8d7f:      LDAB/ W9179      ; =0x9179 =37241(-28295) [Load AL direct]
8d82:      INAB             ; [Increment AL]
8d83:      BZ    D8D93      ; =+14 [Branch if zero]
8d85:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d88:      BZ    D8D8D      ; =+3 [Branch if zero]
8d8a:      JMP/  J8E2E      ; =0x8e2e =36398(-29138) [Jump direct]
8d8d:D8D8D CLA              ; [Clear A]
8d8e:      DCA              ; [Decrement A]
8d8f:      XAB              ; [Transfer A to B]
8d90:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8d92:      DB    X'2F'      ; =0x2f =47 [abort code]
*
8d93:D8D93 LDA/  W9177      ; =0x9177 =37239(-28297) [Load A direct]
8d96:      IVA              ; [Invert A]
8d97:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
8d99:      RL               ; [Reset link]
8d9a:      RRR   A          ; [Right rotate A by 1]
8d9c:      BNL   D8DA0      ; =+2 [Branch on no link]
8d9e:      ORIB  BL,AU      ; [BL | AU -> AU]
8da0:D8DA0 LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
8da3:      OREB  BL,BU      ; [BL ^ BU -> BU]
8da5:      ORE   A,B        ; [A ^ B -> B]
8da7:      LDA/  W8F29+1    ; =0x8f2a =36650(-28886) [Load A direct]
8daa:      LDA+  A,23       ; [Load A indexed, displaced, direct]
8dad:      SAB              ; [A - B -> B]
8dae:      BZ    D8DB6      ; =+6 [Branch if zero]
8db0:      CLA              ; [Clear A]
8db1:      DCA              ; [Decrement A]
8db2:      XAB              ; [Transfer A to B]
8db3:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8db5:      DB    X'30'      ; =0x30 =48 [abort code]
*
8db6:D8DB6 LDA/  W9175      ; =0x9175 =37237(-28299) [Load A direct]
8db9:      OREB  AL,AU      ; [AL ^ AU -> AU]
8dbb:      ORE=  X'3CB1',A  ; =0x3cb1 =15537 [15537 ^ A -> A]
8dbf:      LDB/  W8F29+1    ; =0x8f2a =36650(-28886) [Load B direct]
8dc2:      LDB+  B,23       ; [Load B indexed, displaced, direct]
8dc5:      AAB              ; [A + B -> B]
8dc6:      LDA=  X'0400'    ; =0x0400 =1024 [Load A with immediate]
8dc9:D8DC9 SLR   B          ; [Left shift B by 1]
8dcb:      RLRB  AL         ; [Left rotate AL by 1]
8dcd:      DCRB  AU         ; [Decrement AU by 1]
8dcf:      BGZ   D8DC9      ; =-8 [Branch if greater than zero]
8dd1:      STAB/ W913D      ; =0x913d =37181(-28355) [Store AL direct]
8dd4:      STB/  W913E      ; =0x913e =37182(-28354) [Store B direct]
8dd7:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8dda:      BNZ   J8E2E      ; =+82 [Branch if not zero]
8ddc:      JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8ddf:      DB    X'01'      ; =0x01 =1
8de0:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8de3:      DC    ','        ; hex:ac dec:172(-84)
8de4:      DB    X'01'      ; =0x01 =1
8de5:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8de8:      DC    '='        ; hex:bd dec:189(-67)
8de9:      DB    X'01'      ; =0x01 =1
8dea:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8ded:      DW    W9140      ; =0x9140 =37184(-28352)
8def:      LDAB/ W9140      ; =0x9140 =37184(-28352) [Load AL direct]
8df2:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8df4:      SABB             ; [AL - BL -> BL]
8df5:      BZ    D8E01      ; =+10 [Branch if zero]
8df7:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8dfa:      DC    '*'        ; hex:aa dec:170(-86)
8dfb:      DB    X'01'      ; =0x01 =1
8dfc:      BNZ   D8E06      ; =+8 [Branch if not zero]
8dfe:      LDAB+ Z          ; [Load AL from address in Z]
8dff:      BZ    D8E06      ; =+5 [Branch if zero]
8e01:D8E01 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e04:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8e06:D8E06 LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8e09:      LDAB+ B,28       ; [Load AL indexed, displaced, direct]
8e0c:      BM    D8E12      ; =+4 [Branch on minus]
8e0e:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8e10:      JMP   D8E06      ; =-12 [Jump relative]
8e12:D8E12 LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8e15:      STAB+ B,28       ; [Store AL indexed, displaced, direct]
8e18:      MVF   (10)/W9140,/W9171 ; =0x9140 =37184(-28352),=0x9171 =37233(-28303) [Move fixed-length, direct, direct]
8e1f:      JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8e22:      DB    X'02'      ; =0x02 =2
8e23:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8e26:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
8e28:      STAB+ B,28       ; [Store AL indexed, displaced, direct]
8e2b:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8e2e:J8E2E LDAB/ X'0106'    ; =0x0106 =262 [Load AL direct]
8e31:      STAB/ B915D      ; =0x915d =37213(-28323) [Store AL direct]
8e34:      XFR   Z,A        ; [Transfer Z to A]
8e36:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8e38:      FIL   (9)=X'00',/S915E ; =0x915e =37214(-28322) [Fill with byte, literal=0, direct]
8e3e:      CLA              ; [Clear A]
8e3f:      STA/  W9152      ; =0x9152 =37202(-28334) [Store A direct]
8e42:      STAB/ B9041+1    ; =0x9042 =36930(-28606) [Store AL direct]
8e45:      STAB/ B9052+1    ; =0x9053 =36947(-28589) [Store AL direct]
8e48:      FIL   (18)=' ',/W9140 ; =0x9140 =37184(-28352) [Fill with byte, literal=0xa0(160,-96), direct]
8e4e:B8E4E LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8e50:      BNZ   D8E55      ; =+3 [Branch if not zero]
8e52:      JMP/  D8F13      ; =0x8f13 =36627(-28909) [Jump direct]
8e55:D8E55 FIL   (9)=X'FF',/S915E ; =0x915e =37214(-28322) [Fill with byte, literal=255(-1), direct]
8e5b:      FIL   (18)='*',/W9140 ; =0x9140 =37184(-28352) [Fill with byte, literal=0xaa(170,-86), direct]
8e61:      JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8e64:      DB    X'81'      ; =0x81 =129(-127)
8e65:      BNZ   D8EA2      ; =+59 [Branch if not zero]
8e67:      MVF   (10)/W9171,/W9140 ; =0x9171 =37233(-28303),=0x9140 =37184(-28352) [Move fixed-length, direct, direct]
8e6e:      CAD/  W913D      ; [Clear word at address]
8e72:      FIL   (10)=X'00',/W9171 ; =0x9171 =37233(-28303) [Fill with byte, literal=0, direct]
8e78:      LDAB= X'0E'      ; =14 [Load AL with immediate]
8e7a:      STAB/ B913F      ; =0x913f =37183(-28353) [Store AL direct]
8e7d:      JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8e80:      DB    X'81'      ; =0x81 =129(-127)
8e81:      BNZ   D8EA2      ; =+31 [Branch if not zero]
8e83:      LDA/  W9173      ; =0x9173 =37235(-28301) [Load A direct]
8e86:      LDB=  X'4321'    ; =0x4321 =17185 [Load B with immediate]
8e89:      SAB              ; [A - B -> B]
8e8a:      BZ    D8E8E      ; =+2 [Branch if zero]
8e8c:      LDBB= X'01'      ; =1 [Load BL with immediate]
8e8e:D8E8E STBB/ B9041+1    ; =0x9042 =36930(-28606) [Store BL direct]
8e91:      LDA/  W9171      ; =0x9171 =37233(-28303) [Load A direct]
8e94:      STA/  W9152      ; =0x9152 =37202(-28334) [Store A direct]
8e97:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8e99:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8e9a:      DW    S914A      ; =0x914a =37194(-28342) [address of string date]
8e9c:      LDAB/ W9179      ; =0x9179 =37241(-28295) [Load AL direct]
8e9f:      INAB             ; [Increment AL]
8ea0:      BZ    D8EAA      ; =+8 [Branch if zero]
8ea2:D8EA2 FIL   (10)='*',/W9140 ; =0x9140 =37184(-28352) [Fill with byte, literal=0xaa(170,-86), direct]
8ea8:      JMP   D8F13      ; =+105 [Jump relative]
8eaa:D8EAA LDAB/ B9100      ; =0x9100 =37120(-28416) [Load AL direct]
8ead:      LDB=  S9154      ; =0x9154 =37204(-28332) [Load B with immediate]
8eb0:      SVC   X'0E'      ; =14 [Service call DIRNM - search directory for file name specified]
8eb2:      DW    W9171      ; =0x9171 =37233(-28303) [TODO: arg 1]
8eb4:      STA/  W90FE      ; =0x90fe =37118(-28418) [Store A direct]
8eb7:      STA/  W8F4C      ; =0x8f4c =36684(-28852) [Store A direct]
8eba:      FIL   (9)=X'00',/S915E ; =0x915e =37214(-28322) [Fill with byte, literal=0, direct]
8ec0:      JMP   D8ED4      ; =+18 [Jump relative]
8ec2:D8EC2 LDA/  B9100+1    ; =0x9101 =37121(-28415) [Load A direct]
8ec5:      INA              ; [Increment A]
8ec6:      STA/  B9100+1    ; =0x9101 =37121(-28415) [Store A direct]
8ec9:      LDB$  W90FE      ; =0x90fe =37118(-28418) [Load B indirect]
8ecc:      SAB              ; [A - B -> B]
8ecd:      BNL   D8ED4      ; =+5 [Branch on no link]
8ecf:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8ed2:      DW    X'002A'    ; =0x002a =42
*
8ed4:D8ED4 JSR/  F90F6      ; =0x90f6 =37110(-28426) [Jump to subroutine direct]
8ed7:      DB    X'01'      ; =0x01 =1
8ed8:      LDX=  W9171      ; =0x9171 =37233(-28303) [Load X with immediate]
8edb:      JMP   D8EE6      ; =+9 [Jump relative]
8edd:D8EDD INR   X,6        ; [Increment X by 6]
8edf:      LDA=  W92FD      ; =0x92fd =37629(-27907) [Load A with immediate]
8ee2:      SUB   X,A        ; [X - A -> A]
8ee4:      BZ    D8EC2      ; =-36 [Branch if zero]
8ee6:D8EE6 LDA+  X          ; [Load A from address in X]
8ee7:      INA              ; [Increment A]
8ee8:      BZ    W8F00      ; =+22 [Branch if zero]
8eea:      A     -X(3),/S9164(3) ; =0x9164 =37220(-28316) [Add bignums, indexed, direct]
8ef0:      CPF   (3)-X,/S915E ; =0x915e =37214(-28322) [Compare fixed-length, indexed, direct]
8ef6:      BP    D8EDD      ; =-27 [Branch on plus]
8ef8:      MVF   (3)-X,/S915E ; =0x915e =37214(-28322) [Move fixed-length, indexed, direct]
8efe:      JMP   D8EDD      ; =-35 [Jump relative]
8f00:W8F00 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8f03:      STB/  W9162      ; =0x9162 =37218(-28318) [Store B direct]
8f06:      M     =16,/W9161(3) ; =0x9161 =37217(-28319) [Multiply bignums, literal=0x10, direct]
8f0c:      S     /S9164(3),/W9161(3) ; =0x9164 =37220(-28316),=0x9161 =37217(-28319) [Subtract bignums, direct, direct]
8f13:D8F13 XFR/  X'005A',Z  ; =0x005a =90 [Transfer direct to Z]
8f17:      LDX+  Z,17       ; [Load X indexed, displaced, direct]
8f1a:      LDA+  Z,13       ; [Load A indexed, displaced, direct]
8f1d:      XAY              ; [Transfer A to Y]
8f1e:D8F1E CLA              ; [Clear A]
8f1f:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8f21:      BM    D8F33      ; =+16 [Branch on minus]
8f23:      SLA              ; [Left shift A]
8f24:      LDB+  Z,9        ; [Load B indexed, displaced, direct]
8f27:      AAB              ; [A + B -> B]
8f28:      LDB+  B          ; [Load B from address in B]
8f29:W8F29 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8f2c:      SAB              ; [A - B -> B]
8f2d:      BNZ   D8F33      ; =+4 [Branch if not zero]
8f2f:      LDAB= X'01'      ; =1 [Load AL with immediate]
8f31:      JMP   D8F39      ; =+6 [Jump relative]
8f33:D8F33 INR   Y          ; [Increment Y by 1]
8f35:      DCX              ; [Decrement X]
8f36:      BP    D8F1E      ; =-26 [Branch on plus]
8f38:      CLAB             ; [Clear AL]
8f39:D8F39 STAB/ B9052+1    ; =0x9053 =36947(-28589) [Store AL direct]
8f3c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f3e:      XAZ              ; [Transfer A to Z]
8f3f:      XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8f43:D8F43 LDAB+ Z          ; [Load AL from address in Z]
8f44:      BNZ   D8F51      ; =+11 [Branch if not zero]
8f46:D8F46 LDA   W8F4C      ; =+4 [Load A relative]
8f48:      BZ    D8F4E      ; =+4 [Branch if zero]
8f4a:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8f4c:W8F4C DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8f4e:D8F4E JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8f51:D8F51 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f54:      DC    '*'        ; hex:aa dec:170(-86)
8f55:      DB    X'01'      ; =0x01 =1
8f56:      BNZ   D8F46      ; =-18 [Branch if not zero]
8f58:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f5b:      DC    ','        ; hex:ac dec:172(-84)
8f5c:      DB    X'01'      ; =0x01 =1
8f5d:      LDAB+ Z          ; [Load AL from address in Z]
8f5e:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f61:      BP    D8F66      ; =+3 [Branch on plus]
8f63:      JMP/  J9093      ; =0x9093 =37011(-28525) [Jump direct]
8f66:D8F66 JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8f69:      XABB             ; [Transfer AL to BL]
8f6a:      BP    D8F71      ; =+5 [Branch on plus]
8f6c:D8F6C JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f6f:      DW    X'001C'    ; =0x001c =28
*
8f71:D8F71 LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8f74:      SABB             ; [AL - BL -> BL]
8f75:      BP    D8F6C      ; =-11 [Branch on plus]
8f77:      CLRB  AU         ; [Clear AU]
8f79:      SLA              ; [Left shift A]
8f7a:      XAB              ; [Transfer A to B]
8f7b:      SLA              ; [Left shift A]
8f7c:      SLA              ; [Left shift A]
8f7d:      AAB              ; [A + B -> B]
8f7e:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8f81:      AAB              ; [A + B -> B]
8f82:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8f84:      FIL   (10)=' ',-B ; [Fill with byte, literal=0xa0(160,-96), indexed]
8f89:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f8c:      DC    '='        ; hex:bd dec:189(-67)
8f8d:      DB    X'01'      ; =0x01 =1
8f8e:      BZ    D8F6C      ; =-36 [Branch if zero]
8f90:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f93:      DC    'VOL'      ; hex:d6cfcc
8f96:      DB    X'01'      ; =0x01 =1
8f97:      BZ    D8FA3      ; =+10 [Branch if zero]
8f99:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f9b:      MVF   (10)/W9140,-A ; =0x9140 =37184(-28352), [Move fixed-length, direct, indexed]
8fa1:      JMP   D8F43      ; =-96 [Jump relative]
8fa3:D8FA3 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fa6:      DC    'AVAIL'    ; hex:c1d6c1c9cc
8fab:      DB    X'01'      ; =0x01 =1
8fac:      BZ    D8FE4      ; =+54 [Branch if zero]
8fae:      LDB=  S9164      ; =0x9164 =37220(-28316) [Load B with immediate]
8fb1:D8FB1 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8fb3:      STK   X,4        ; [Push X Y to the stack]
8fb5:      C     =-1,-B(3)  ; [Compare bignums, literal=0xff, indexed]
8fba:      BZ    D8FD2      ; =+22 [Branch if zero]
8fbc:      MVF   (10)/S9167,-A ; =0x9167 =37223(-28313), [Move fixed-length, direct, indexed]
8fc2:      XAX              ; [Transfer A to X]
8fc3:      XFR   B,Y        ; [Transfer B to Y]
8fc5:      CLR   A,10       ; [Set A to 10]
8fc7:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8fc9:      CFB   -X(10),-Y(3) ; [Convert from bignum, indexed, indexed]
8fcd:D8FCD POP   X,4        ; [Pop Y X from the stack]
8fcf:      JMP/  D8F43      ; =0x8f43 =36675(-28861) [Jump direct]
8fd2:D8FD2 MVF   (10)/S8FDA,-A ; =0x8fda =36826(-28710), [Move fixed-length, direct, indexed]
8fd8:      JMP   D8FCD      ; =-13 [Jump relative]
*
8fda:S8FDA DC    '        -1' ; hex:a0a0a0a0a0a0a0a0adb1
*
8fe4:D8FE4 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fe7:      DC    'MAXDISK'  ; hex:cdc1d8c4c9d3cb
8fee:      DB    X'01'      ; =0x01 =1
8fef:      BZ    D8FF6      ; =+5 [Branch if zero]
8ff1:      LDB=  W915B      ; =0x915b =37211(-28325) [Load B with immediate]
8ff4:      JMP   D8FB1      ; =-69 [Jump relative]
8ff6:D8FF6 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ff9:      DC    'USED'     ; hex:d5d3c5c4
8ffd:      DB    X'01'      ; =0x01 =1
8ffe:      BZ    D9005      ; =+5 [Branch if zero]
9000:      LDB=  W9161      ; =0x9161 =37217(-28319) [Load B with immediate]
9003:      JMP   D8FB1      ; =-84 [Jump relative]
9005:D9005 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9008:      DC    'CONTIG'   ; hex:c3cfced4c9c7
900e:      DB    X'01'      ; =0x01 =1
900f:      BZ    D9016      ; =+5 [Branch if zero]
9011:      LDB=  S915E      ; =0x915e =37214(-28322) [Load B with immediate]
9014:      JMP   D8FB1      ; =-101 [Jump relative]
9016:D9016 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9019:      DC    'STATUS'   ; hex:d3d4c1d4d5d3
901f:      DB    X'01'      ; =0x01 =1
9020:      BZ    D9034      ; =+18 [Branch if zero]
9022:      CLA              ; [Clear A]
9023:      LDAB  B9041+1    ; =+29 [Load AL relative]
9025:      LDBB  B9052+1    ; =+44 [Load BL relative]
9027:      SLAB             ; [Left shift AL]
9028:      AABB             ; [AL + BL -> BL]
9029:D9029 LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
902b:      AABB             ; [AL + BL -> BL]
902c:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
902e:      STBB+ A,5        ; [Store BL indexed, displaced, direct]
9031:      JMP/  D8F43      ; =0x8f43 =36675(-28861) [Jump direct]
9034:D9034 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9037:      DC    'GSTATUS'  ; hex:c7d3d4c1d4d5d3
903e:      DB    X'01'      ; =0x01 =1
903f:      BZ    D9045      ; =+4 [Branch if zero]
9041:B9041 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
9043:      JMP   D9029      ; =-28 [Jump relative]
9045:D9045 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9048:      DC    'ASTATUS'  ; hex:c1d3d4c1d4d5d3
904f:      DB    X'01'      ; =0x01 =1
9050:      BZ    D9056      ; =+4 [Branch if zero]
9052:B9052 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
9054:      JMP   D9029      ; =-45 [Jump relative]
9056:D9056 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9059:      DC    'DATE'     ; hex:c4c1d4c5
905d:      DB    X'01'      ; =0x01 =1
905e:      BZ    D906B      ; =+11 [Branch if zero]
9060:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
9062:      MVF   (8)/S914A,-A ; =0x914a =37194(-28342), [Move fixed-length, direct, indexed]
9068:      JMP/  D8F43      ; =0x8f43 =36675(-28861) [Jump direct]
906b:D906B JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
906e:      DC    'IDATE'    ; hex:c9c4c1d4c5
9073:      DB    X'01'      ; =0x01 =1
9074:      BNZ   D9079      ; =+3 [Branch if not zero]
9076:      JMP/  D8F6C      ; =0x8f6c =36716(-28820) [Jump direct]
9079:D9079 LDA+  S+         ; [Load A indexed, direct, post-incremented]
907b:      STK   Y,2        ; [Push Y to the stack]
907d:      XAY              ; [Transfer A to Y]
907e:      MVF   (10)/S9167,-Y ; =0x9167 =37223(-28313), [Move fixed-length, direct, indexed]
9084:      CLR   A,10       ; [Set A to 10]
9086:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9088:      CFB   -Y(10),/W9152(2) ; =0x9152 =37202(-28334) [Convert from bignum, indexed, direct]
908e:      POP   Y,2        ; [Pop Y from the stack]
9090:      JMP/  D8F43      ; =0x8f43 =36675(-28861) [Jump direct]
9093:J9093 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
9096:      DC    'UPSI'     ; hex:d5d0d3c9
909a:      DB    X'15'      ; =0x15 =21
909b:      BZ    D909F      ; =+2 [Branch if zero]
909d:      JMP   D90A7      ; =+8 [Jump relative]
909f:D909F JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
90a2:      DC    'CC'       ; hex:c3c3 dec:50115(-61)
90a4:      DB    X'14'      ; =0x14 =20
90a5:      BZ    D9056      ; =-81 [Branch if zero]
90a7:D90A7 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
90a9:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
90ac:      DC    '='        ; hex:bd dec:189(-67)
90ad:      DB    X'01'      ; =0x01 =1
90ae:      BZ    D9056      ; =-90 [Branch if zero]
90b0:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
90b3:      DC    'STATUS'   ; hex:d3d4c1d4d5d3
90b9:      DB    X'01'      ; =0x01 =1
90ba:      BZ    D90CF      ; =+19 [Branch if zero]
90bc:      LDAB  B9041+1    ; =-124 [Load AL relative]
90be:      LDBB  B9052+1    ; =-109 [Load BL relative]
90c0:      SLAB             ; [Left shift AL]
90c1:      AABB             ; [AL + BL -> BL]
90c2:D90C2 LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
90c4:      STAB  B90C9+2    ; =+5 [Store AL relative]
90c6:      LDA/  W80B1      ; =0x80b1 =32945(-32591) [Load A direct]
90c9:B90C9 STBB+ A,21       ; [Store BL indexed, displaced, direct]
90cc:      JMP/  D8F43      ; =0x8f43 =36675(-28861) [Jump direct]
90cf:D90CF JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
90d2:      DC    'ASTATUS'  ; hex:c1d3d4c1d4d5d3
90d9:      DB    X'01'      ; =0x01 =1
90da:      BZ    D90E1      ; =+5 [Branch if zero]
90dc:      LDBB/ B9052+1    ; =0x9053 =36947(-28589) [Load BL direct]
90df:      JMP   D90C2      ; =-31 [Jump relative]
90e1:D90E1 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
90e4:      DC    'GSTATUS'  ; hex:c7d3d4c1d4d5d3
90eb:      DB    X'01'      ; =0x01 =1
90ec:      BZ    D90F3      ; =+5 [Branch if zero]
90ee:      LDBB/ B9041+1    ; =0x9042 =36930(-28606) [Load BL direct]
90f1:      JMP   D90C2      ; =-49 [Jump relative]
90f3:D90F3 JMP/  D8F6C      ; =0x8f6c =36716(-28820) [Jump direct]
*
* Function F90F6
*
90f6:F90F6 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
90f8:      STAB  B9105      ; =+11 [Store AL relative]
90fa:      SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
90fc:      DW    X'0190'    ; =0x0190 =400
90fe:W90FE DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
9100:B9100 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg2]
9102:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
9103:      DW    W9171      ; =0x9171 =37233(-28303) [TODO: arg4]
9105:B9105 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg5]
9106:      XAB              ; [Transfer A to B]
9107:      RSR              ; [Return from subroutine]
*
9108:W9108 DW    W9110      ; =0x9110 =37136(-28400)
910a:      DB    0,6        ; =0x00,0x0006
9110:W9110 DW    X'0100'    ; =0x0100 =256
9112:      DW    X'FFFF'    ; =0xffff =65535(-1)
9114:      DW    X'0F00'    ; =0x0f00 =3840
9116:      DB    0,37       ; =0x00,0x0025
913b:      DW    W913D      ; =0x913d =37181(-28355)
913d:W913D DB    X'00'      ; =0x00 =0 =NUL
913e:W913E DB    X'00'      ; =0x00 =0 =NUL
913f:B913F DB    X'00'      ; =0x00 =0 =NUL
9140:W9140 DS    10         ; =0x000a [Uninitialized memory]
914a:S914A DS    8          ; =0x0008 [Uninitialized memory]
9152:W9152 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9154:S9154 DC    '@SFAL0'   ; hex:c0d3c6c1ccb0
915a:      DB    X'00'      ; =0x00 =0 =NUL
915b:W915B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
915d:B915D DB    X'00'      ; =0x00 =0 =NUL
915e:S915E DB    0,3        ; =0x00,0x0003
9161:W9161 DB    X'00'      ; =0x00 =0 =NUL
9162:W9162 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9164:S9164 DB    0,3        ; =0x00,0x0003
9167:S9167 DC    '@@@@@@@@#@' ; hex:c0c0c0c0c0c0c0c0a3c0
9171:W9171 DS    2          ; =0x0002 [Uninitialized memory]
9173:W9173 DS    2          ; =0x0002 [Uninitialized memory]
9175:W9175 DS    2          ; =0x0002 [Uninitialized memory]
9177:W9177 DS    2          ; =0x0002 [Uninitialized memory]
9179:W9179 DS    388        ; =0x0184 [Uninitialized memory]
92fd:W92FD DS    4          ; =0x0004 [Uninitialized memory]
9301:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
9303:ENDPT
