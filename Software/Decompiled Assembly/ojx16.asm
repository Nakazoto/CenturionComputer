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
82ea:F82EA DS    87         ; =0x0057 [Uninitialized memory]
*
*
* Function F8341
*
8341:F8341 DS    422        ; =0x01a6 [Uninitialized memory]
*
*
* Function F84E7
*
84e7:F84E7 DS    123        ; =0x007b [Uninitialized memory]
*
*
* Function F8562
*
8562:F8562 DS    332        ; =0x014c [Uninitialized memory]
86ae:W86AE DS    103        ; =0x0067 [Uninitialized memory]
8715:W8715 DS    2          ; =0x0002 [Uninitialized memory]
8717:W8717 DS    1484       ; =0x05cc [Uninitialized memory]
*
*
* Function F8CE3
*
8ce3:F8CE3 DS    76         ; =0x004c [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d32:      BZ    D8D37      ; =+3 [Branch if zero]
8d34:      JMP/  J8DE4      ; =0x8de4 =36324(-29212) =CR,'d' [Jump direct]
8d37:D8D37 XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d3b:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d3e:      DC    ','        ; hex:ac dec:172(-84)
8d3f:      DB    X'01'      ; =0x01 =1
8d40:      LDAB+ Z          ; [Load AL from address in Z]
8d41:      BNZ   D8D46      ; =+3 [Branch if not zero]
8d43:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8d46:D8D46 JSR   F8D4A      ; =+2 [Jump to subroutine relative]
8d48:      JMP   D8D37      ; =-19 [Jump relative]
*
* Function F8D4A
*
8d4a:F8D4A LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8d4c:      LDB=  X'D3D9'    ; =0xd3d9 =54233(-11303) ='S','Y' [Load B with immediate]
8d4f:      SAB              ; [A - B -> B]
8d50:      BNZ   D8D58      ; =+6 [Branch if not zero]
8d52:      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8d54:      SUBB  AU,AL      ; [AU - AL -> AL]
8d56:      BZ    D8D5D      ; =+5 [Branch if zero]
8d58:D8D58 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d5b:      DW    X'000F'    ; =0x000f =15
*
8d5d:D8D5D LDAB+ Z          ; [Load AL from address in Z]
8d5e:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8d61:      BM    D8D72      ; =+15 [Branch on minus]
8d63:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8d66:      LDB/  W80B1      ; =0x80b1 =32945(-32591) [Load B direct]
8d69:      LDBB+ B,6        ; [Load BL indexed, displaced, direct]
8d6c:      CLRB  BU         ; [Clear BU]
8d6e:      ADD   B,A        ; [B + A -> A]
8d70:      JMP   D8D99      ; =+39 [Jump relative]
8d72:D8D72 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d75:      DC    'RDR'      ; hex:d2c4d2
8d78:      DB    X'01'      ; =0x01 =1
8d79:      BNZ   D8D98      ; =+29 [Branch if not zero]
8d7b:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d7e:      DC    'IPT'      ; hex:c9d0d4
8d81:      DB    X'02'      ; =0x02 =2
8d82:      BNZ   D8D98      ; =+20 [Branch if not zero]
8d84:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d87:      DC    'LOG'      ; hex:cccfc7
8d8a:      DB    X'03'      ; =0x03 =3
8d8b:      BNZ   D8D98      ; =+11 [Branch if not zero]
8d8d:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d90:      DC    'LST'      ; hex:ccd3d4
8d93:      DB    X'04'      ; =0x04 =4
8d94:      BNZ   D8D98      ; =+2 [Branch if not zero]
8d96:      JMP   D8D58      ; =-64 [Jump relative]
8d98:D8D98 DCA              ; [Decrement A]
8d99:D8D99 XFR   Z,B        ; [Transfer Z to B]
8d9b:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8d9d:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8d9f:      XFR/  X'005A',Z  ; =0x005a =90 [Transfer direct to Z]
8da3:      CLR   B          ; [Clear B]
8da5:      LDBB+ Y,7        ; [Load BL indexed, displaced, direct]
8da8:      SAB              ; [A - B -> B]
8da9:      BGZ   D8D58      ; =-83 [Branch if greater than zero]
8dab:      XAB              ; [Transfer A to B]
8dac:      SLA              ; [Left shift A]
8dad:      AAB              ; [A + B -> B]
8dae:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
8db1:      AAB              ; [A + B -> B]
8db2:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8db4:      CLA              ; [Clear A]
8db5:      LDAB+ B          ; [Load AL from address in B]
8db6:      BM    D8DCB      ; =+19 [Branch on minus]
8db8:      SLA              ; [Left shift A]
8db9:      LDB+  Z,9        ; [Load B indexed, displaced, direct]
8dbc:      AAB              ; [A + B -> B]
8dbd:      LDX+  B          ; [Load X indexed, direct]
8dbf:      LDAB+ X          ; [Load AL from address in X]
8dc0:      BZ    D8DCB      ; =+9 [Branch if zero]
8dc2:      LDBB= X'04'      ; =4 [Load BL with immediate]
8dc4:      NABB             ; [AL & BL -> BL]
8dc5:      BNZ   D8DCB      ; =+4 [Branch if not zero]
8dc7:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
8dc9:      NABB             ; [AL & BL -> BL]
8dca:      STBB+ X          ; [Store BL to address in X]
8dcb:D8DCB LDX+  S+         ; [Load X indexed, direct, post-incremented]
8dcd:      LDB=  X'FFFF'    ; =0xffff =65535(-1) [Load B with immediate]
8dd0:      STBB+ X+         ; [Store BL indexed, direct, post-incremented]
8dd2:      LDA+  X          ; [Load A from address in X]
8dd3:      INA              ; [Increment A]
8dd4:      BZ    D8DDE      ; =+8 [Branch if zero]
8dd6:      DCA              ; [Decrement A]
8dd7:      STB+  X          ; [Store B to address in X]
8dd8:      STA   W8DDC      ; =+2 [Store A relative]
8dda:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8ddc:W8DDC DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8dde:D8DDE LDX+  S+         ; [Load X indexed, direct, post-incremented]
8de0:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8de2:      XAZ              ; [Transfer A to Z]
8de3:      RSR              ; [Return from subroutine]
*
8de4:J8DE4 LDA=  W8717      ; =0x8717 =34583(-30953) [Load A with immediate]
8de7:      XAZ              ; [Transfer A to Z]
8de8:      ADD/  W8715,A    ; =0x8715 =34581(-30955) [Direct + A -> A]
8dec:      CLR   B          ; [Clear B]
8dee:      STBB+ A          ; [Store BL to address in A]
8def:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8df2:      DC    '.CODE'    ; hex:aec3cfc4c5
8df7:      DB    X'00'      ; =0x00 =0 =NUL
8df8:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8dfb:      STA   W8E4D+1    ; =+81 [Store A relative]
8dfd:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
8e00:      LDBB= X'04'      ; =4 [Load BL with immediate]
8e02:      SABB             ; [AL - BL -> BL]
8e03:      BZ    D8E0A      ; =+5 [Branch if zero]
8e05:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e08:      DW    X'0006'    ; =0x0006 =6
*
8e0a:D8E0A JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e0d:      DC    '*'        ; hex:aa dec:170(-86)
8e0e:      DB    X'01'      ; =0x01 =1
8e0f:      BNZ   D8E14      ; =+3 [Branch if not zero]
8e11:      LDAB+ Z          ; [Load AL from address in Z]
8e12:      BNZ   D8E3E      ; =+42 [Branch if not zero]
8e14:D8E14 JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8e17:      DW    W8E5B      ; =0x8e5b =36443(-29093)
8e19:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8e1c:      LDA+  A,3        ; [Load A indexed, displaced, direct]
8e1f:      LDA+  A,8        ; [Load A indexed, displaced, direct]
8e22:      LDB+  A          ; [Load B from address in A]
8e23:      LDBB= X'08'      ; =8 [Load BL with immediate]
8e25:      ORIB  BU,BL      ; [BU | BL -> BL]
8e27:      STBB+ A          ; [Store BL to address in A]
8e28:      JSR/  F84E7      ; =0x84e7 =34023(-31513) =EOT,'g' [Jump to subroutine direct]
8e2b:      JSR/  F8CE3      ; =0x8ce3 =36067(-29469) =FF,'c' [Jump to subroutine direct]
8e2e:      DW    W86AE      ; =0x86ae =34478(-31058)
8e30:      LDA=  W86AE      ; =0x86ae =34478(-31058) [Load A with immediate]
8e33:      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8e35:      XAZ              ; [Transfer A to Z]
8e36:      AAB              ; [A + B -> B]
8e37:      CLAB             ; [Clear AL]
8e38:      STAB+ B          ; [Store AL to address in B]
8e39:      JSR/  F8562      ; =0x8562 =34146(-31390) [Jump to subroutine direct]
8e3c:      DW    W8E62      ; =0x8e62 =36450(-29086)
*
8e3e:D8E3E JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e41:      DC    '#'        ; hex:a3 dec:163(-93)
8e42:      DB    X'01'      ; =0x01 =1
8e43:      BZ    D8E4A      ; =+5 [Branch if zero]
8e45:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e48:      DW    X'002C'    ; =0x002c =44
*
8e4a:D8E4A JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8e4d:W8E4D LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8e50:      STA+  B,23       ; [Store A indexed, displaced, direct]
8e53:      LDAB= X'01'      ; =1 [Load AL with immediate]
8e55:      STAB+ B,26       ; [Store AL indexed, displaced, direct]
8e58:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
8e5b:W8E5B DW    X'0005'    ; =0x0005 =5
8e5d:      DC    'CODE:'    ; hex:c3cfc4c5ba
8e62:W8E62 DW    X'0001'    ; =0x0001 =1
8e64:      DB    X'8D'      ; =0x8d =141(-115) =CR
8e65:ENDPT
