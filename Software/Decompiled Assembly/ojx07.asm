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
8148:J8148 DS    380        ; =0x017c [Uninitialized memory]
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
82fd:F82FD DS    455        ; =0x01c7 [Uninitialized memory]
*
*
* Function F84C4
*
84c4:F84C4 DS    35         ; =0x0023 [Uninitialized memory]
*
*
* Function F84E7
*
84e7:F84E7 DS    123        ; =0x007b [Uninitialized memory]
*
*
* Function F8562
*
8562:F8562 DS    14         ; =0x000e [Uninitialized memory]
8570:W8570 DS    94         ; =0x005e [Uninitialized memory]
85ce:W85CE DS    1889       ; =0x0761 [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8d36:      LDAB+ A,24       ; [Load AL indexed, displaced, direct]
8d39:      DCAB             ; [Decrement AL]
8d3a:      STAB/ B8EB7+1    ; =0x8eb8 =36536(-29000) [Store AL direct]
8d3d:      STAB/ B8EBE+1    ; =0x8ebf =36543(-28993) [Store AL direct]
8d40:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d43:      DC    'ALL'      ; hex:c1cccc
8d46:      DB    X'01'      ; =0x01 =1
8d47:      BZ    D8D6F      ; =+38 [Branch if zero]
8d49:      XFR=  W8EF2,Z    ; =0x8ef2 =36594(-28942) [Transfer immediate to Z]
8d4d:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8d50:      LDX+  A,7        ; [Load X indexed, displaced, direct]
8d53:D8D53 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8d55:      BZ    D8D87      ; =+48 [Branch if zero]
8d57:      XAY              ; [Transfer A to Y]
8d58:      JSR   F8DAF      ; =+85 [Jump to subroutine relative]
8d5a:      JSR   F8DC6      ; =+106 [Jump to subroutine relative]
8d5c:      DC    'ASSIGNMENTS'
8d67:      DB    X'00'      ; =0x00 =0 =NUL
*
8d68:      JSR/  F8E85      ; =0x8e85 =36485(-29051) [Jump to subroutine direct]
8d6b:      JSR   F8D8A      ; =+29 [Jump to subroutine relative]
8d6d:      JMP   D8D53      ; =-28 [Jump relative]
8d6f:D8D6F JSR/  F82FD      ; =0x82fd =33533(-32003) [Jump to subroutine direct]
8d72:      LDA+  A          ; [Load A from address in A]
8d73:      XAY              ; [Transfer A to Y]
8d74:      LDAB+ Z          ; [Load AL from address in Z]
8d75:      BZ    D8D81      ; =+10 [Branch if zero]
8d77:      LDBB= X'AA'      ; =170(-86) ='*' [Load BL with immediate]
8d79:      SABB             ; [AL - BL -> BL]
8d7a:      BZ    D8D81      ; =+5 [Branch if zero]
8d7c:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d7f:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8d81:D8D81 XFR=  W8EF2,Z    ; =0x8ef2 =36594(-28942) [Transfer immediate to Z]
8d85:      JSR   F8D8A      ; =+3 [Jump to subroutine relative]
8d87:D8D87 JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8D8A
*
8d8a:F8D8A CLA              ; [Clear A]
8d8b:D8D8B LDBB+ Y,7        ; [Load BL indexed, displaced, direct]
8d8e:      SABB             ; [AL - BL -> BL]
8d8f:      BGZ   D8DAE      ; =+29 [Branch if greater than zero]
8d91:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8d93:      XAB              ; [Transfer A to B]
8d94:      SLA              ; [Left shift A]
8d95:      AAB              ; [A + B -> B]
8d96:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
8d99:      AAB              ; [A + B -> B]
8d9a:      LDAB+ B          ; [Load AL from address in B]
8d9b:      BM    D8DA9      ; =+12 [Branch on minus]
8d9d:      LDA+  S          ; [Load A from address in S]
8d9e:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8da0:      JSR   F8DCF      ; =+45 [Jump to subroutine relative]
8da2:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8da4:      JSR   F8E1E      ; =+120 [Jump to subroutine relative]
8da6:      JSR/  F8E85      ; =0x8e85 =36485(-29051) [Jump to subroutine direct]
8da9:D8DA9 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8dab:      INA              ; [Increment A]
8dac:      JMP   D8D8B      ; =-35 [Jump relative]
8dae:D8DAE RSR              ; [Return from subroutine]
*
* Function F8DAF
*
8daf:F8DAF MVF   (4)='P@# ',-Z ; [Move fixed-length, literal=0xd0c0a3a0(3502285728,-96), indexed]
8db7:      INR   Z          ; [Increment Z by 1]
8db9:      CLRB  AL,2       ; [Set AL to 2]
8dbb:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8dbd:      CFB   -Z(10),-Y,1(1) ; [Convert from bignum, indexed, displaced indexed]
8dc3:      INR   Z,3        ; [Increment Z by 3]
8dc5:      RSR              ; [Return from subroutine]
*
* Function F8DC6
*
8dc6:F8DC6 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8dc8:      BZ    D8DCE      ; =+4 [Branch if zero]
8dca:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
8dcc:      JMP   F8DC6      ; =-8 [Jump relative]
8dce:D8DCE RSR              ; [Return from subroutine]
*
* Function F8DCF
*
8dcf:F8DCF LDBB+ Y,6        ; [Load BL indexed, displaced, direct]
8dd2:      SABB             ; [AL - BL -> BL]
8dd3:      BP    D8DDD      ; =+8 [Branch on plus]
8dd5:      LDB=  S8E0E      ; =0x8e0e =36366(-29170) [Load B with immediate]
8dd8:      SLR   A,2        ; [Left shift A by 2]
8dda:      AAB              ; [A + B -> B]
8ddb:      JMP   D8DEF      ; =+18 [Jump relative]
8ddd:D8DDD LDBB+ Y,6        ; [Load BL indexed, displaced, direct]
8de0:      SABB             ; [AL - BL -> BL]
8de1:      XFRB  BL,AL      ; [Transfer BL to AL]
8de3:      ADD=  X'03E8',A  ; =0x03e8 =1000 [1000 + A -> A]
8de7:      JSR/  F8F79      ; =0x8f79 =36729(-28807) [Jump to subroutine direct]
8dea:      DW    S8E0C      ; =0x8e0c =36364(-29172)
8dec:      LDB=  S8E0A      ; =0x8e0a =36362(-29174) [Load B with immediate]
8def:D8DEF LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
8df2:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8df4:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8df6:      LDA=  X'D3D9'    ; =0xd3d9 =54233(-11303) ='S','Y' [Load A with immediate]
8df9:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8dfb:      LDAB= X'D3'      ; =211(-45) ='S' [Load AL with immediate]
8dfd:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
8dff:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8e01:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8e03:      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8e05:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8e07:      RSR              ; [Return from subroutine]
*
8e08:      DC    ' 1'       ; hex:a0b1 dec:41137(-79)
8e0a:S8E0A DC    '00'       ; hex:b0b0 dec:45232(-80)
8e0c:S8E0C DC    '0 '       ; hex:b0a0 dec:45216(-96)
8e0e:S8E0E DC    'RDR IPT LOG LST '
*
*
* Function F8E1E
*
8e1e:F8E1E CLA              ; [Clear A]
8e1f:      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
8e21:      LDB+  B          ; [Load B from address in B]
8e22:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8e24:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8e27:      LDB+  B,9        ; [Load B indexed, displaced, direct]
8e2a:      SLA              ; [Left shift A]
8e2b:      AAB              ; [A + B -> B]
8e2c:      LDB+  B          ; [Load B from address in B]
8e2d:      MVF   (6)-B,7,-Z ; [Move fixed-length, displaced indexed, indexed]
8e33:      INR   Z,6        ; [Increment Z by 6]
8e35:      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
8e38:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8e3a:      LDAB+ B          ; [Load AL from address in B]
8e3b:      LDBB= X'10'      ; =16 [Load BL with immediate]
8e3d:      NABB             ; [AL & BL -> BL]
8e3e:      BNZ   D8E43      ; =+3 [Branch if not zero]
8e40:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8e42:      RSR              ; [Return from subroutine]
*
8e43:D8E43 LDB+  S+         ; [Load B indexed, direct, post-incremented]
8e45:      BM    D8E84      ; =+61 [Branch on minus]
8e47:      LDA+  B          ; [Load A from address in B]
8e48:      MVF   (21)-A,9,-Z ; [Move fixed-length, displaced indexed, indexed]
8e4e:      ADD=  X'0015',Z  ; =0x0015 =21 [21 + Z -> Z]
8e52:      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
8e55:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
8e57:      LDA+  B,3        ; [Load A indexed, displaced, direct]
8e5a:      LDAB= X'04'      ; =4 [Load AL with immediate]
8e5c:      ANDB  AU,AL      ; [AU & AL -> AL]
8e5e:      BZ    D8E6D      ; =+13 [Branch if zero]
8e60:      MVF   (7)='SHARED ',-Z ; [Move fixed-length, literal=0xd3c8c1d2c5c4a0(59611954876368032,-96), indexed]
8e6b:      INR   Z,7        ; [Increment Z by 7]
8e6d:D8E6D LDAB= X'10'      ; =16 [Load AL with immediate]
8e6f:      ANDB  AU,AL      ; [AU & AL -> AL]
8e71:      BZ    D8E80      ; =+13 [Branch if zero]
8e73:      MVF   (7)='PASSED ',-Z ; [Move fixed-length, literal=0xd0c1d3d3c5c4a0(58759910691030176,-96), indexed]
8e7e:      INR   Z,7        ; [Increment Z by 7]
8e80:D8E80 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8e82:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
8e84:D8E84 RSR              ; [Return from subroutine]
*
* Function F8E85
*
8e85:F8E85 LDA=  W8EF2      ; =0x8ef2 =36594(-28942) [Load A with immediate]
8e88:      XAB              ; [Transfer A to B]
8e89:      SUB   Z,B        ; [Z - B -> B]
8e8b:      XAZ              ; [Transfer A to Z]
8e8c:      STB*  P8E91      ; =+3 [Store B relative indirect]
8e8e:      JSR/  F8FBC      ; =0x8fbc =36796(-28740) [Jump to subroutine direct]
8e91:P8E91 DW    W8EF0      ; =0x8ef0 =36592(-28944)
8e93:      LDB   P8E91      ; =-4 [Load B relative]
8e95:      LDA+  B          ; [Load A from address in B]
8e96:      INA              ; [Increment A]
8e97:      STA+  B+         ; [Store A indexed, direct, post-incremented]
8e99:      AAB              ; [A + B -> B]
8e9a:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8e9c:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
8e9e:      JSR/  F84C4      ; =0x84c4 =33988(-31548) =EOT,'D' [Jump to subroutine direct]
8ea1:      DW    W8EF0      ; =0x8ef0 =36592(-28944)
8ea3:      DB    X'02'      ; =0x02 =2
8ea4:      LDB=  W8570      ; =0x8570 =34160(-31376) [Load B with immediate]
8ea7:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
8ea9:      LDB/  W80B1      ; =0x80b1 =32945(-32591) [Load B direct]
8eac:      LDB+  B,8        ; [Load B indexed, displaced, direct]
8eaf:      SAB              ; [A - B -> B]
8eb0:      BZ    B8EB7      ; =+5 [Branch if zero]
8eb2:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8eb5:      DW    W8EF0      ; =0x8ef0 =36592(-28944)
8eb7:B8EB7 LDAB= X'17'      ; =23 [Load AL with immediate]
8eb9:      DCAB             ; [Decrement AL]
8eba:      STAB  B8EB7+1    ; =-4 [Store AL relative]
8ebc:      BGZ   D8EDE      ; =+32 [Branch if greater than zero]
8ebe:B8EBE LDAB= X'17'      ; =23 [Load AL with immediate]
8ec0:      STAB  B8EB7+1    ; =-10 [Store AL relative]
8ec2:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8ec5:      DW    W8EDF      ; =0x8edf =36575(-28961)
8ec7:      LDA/  W85CE      ; =0x85ce =34254(-31282) [Load A direct]
8eca:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8ecc:      CLR   A,1        ; [Set A to 1]
8ece:      STA/  W85CE      ; =0x85ce =34254(-31282) [Store A direct]
8ed1:      JSR/  F84E7      ; =0x84e7 =34023(-31513) =EOT,'g' [Jump to subroutine direct]
8ed4:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8ed6:      STA/  W85CE      ; =0x85ce =34254(-31282) [Store A direct]
8ed9:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8edc:      DW    W8EED      ; =0x8eed =36589(-28947)
*
8ede:D8EDE RSR              ; [Return from subroutine]
*
8edf:W8EDF DW    X'000C'    ; =0x000c =12
8ee1:      DC    '      (MORE)'
8eed:W8EED DW    X'0001'    ; =0x0001 =1
8eef:      DB    X'8D'      ; =0x8d =141(-115) =CR
8ef0:W8EF0 DW    W8F77      ; =0x8f77 =36727(-28809)
8ef2:W8EF2 DS    133        ; =0x0085 [Uninitialized memory]
8f77:W8F77 DW    X'9541'    ; =0x9541 =38209(-27327)
*
* Function F8F79
*
8f79:F8F79 LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8f7b:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
8f7d:      XFR   A,A        ; [Transfer A to A]
8f7f:      BZ    D8FB3      ; =+50 [Branch if zero]
8f81:      BP    D8F88      ; =+5 [Branch on plus]
8f83:      IVA              ; [Invert A]
8f84:      INA              ; [Increment A]
8f85:      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8f87:      STBB+ S          ; [Store BL to address in S]
8f88:D8F88 LDB+  X+         ; [Load B indexed, direct, post-incremented]
8f8a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8f8c:      XFR   B,X        ; [Transfer B to X]
8f8e:      INX              ; [Increment X]
8f8f:D8F8F LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
8f92:      DIV   B,A        ; [A / B -> A,B]
8f94:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8f96:      BZ    D8FA1      ; =+9 [Branch if zero]
8f98:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8f9a:      AABB             ; [AL + BL -> BL]
8f9b:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8f9d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f9f:      JMP   D8F8F      ; =-18 [Jump relative]
8fa1:D8FA1 XABB             ; [Transfer AL to BL]
8fa2:      BZ    D8FA9      ; =+5 [Branch if zero]
8fa4:      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
8fa6:      AABB             ; [AL + BL -> BL]
8fa7:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8fa9:D8FA9 LDB+  S+         ; [Load B indexed, direct, post-incremented]
8fab:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8fad:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
8faf:      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8fb1:      XAX              ; [Transfer A to X]
8fb2:      RSR              ; [Return from subroutine]
*
8fb3:D8FB3 LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
8fb5:      STAB+ *X         ; [Store AL indexed, indirect]
8fb7:      INR   X,2        ; [Increment X by 2]
8fb9:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
8fbb:      RSR              ; [Return from subroutine]
*
* Function F8FBC
*
8fbc:F8FBC LDA+  X+         ; [Load A indexed, direct, post-incremented]
8fbe:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8fc0:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8fc2:      LDX+  A+         ; [Load X indexed, direct, post-incremented]
8fc4:      BLE   D8FD4      ; =+14 [Branch if less than or equal to zero]
8fc6:      ADD   X,A        ; [X + A -> A]
8fc8:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
8fcb:D8FCB LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
8fcd:      SUBB  BU,BL      ; [BU - BL -> BL]
8fcf:      BNZ   D8FD4      ; =+3 [Branch if not zero]
8fd1:      DCX              ; [Decrement X]
8fd2:      BGZ   D8FCB      ; =-9 [Branch if greater than zero]
8fd4:D8FD4 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8fd6:      STX+  A          ; [Store X indexed, direct]
8fd8:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8fda:      RSR              ; [Return from subroutine]
*
8fdb:ENDPT
