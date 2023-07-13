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
8000:      DS    2          ; =0x0002 [Uninitialized memory]
8002:W8002 DS    175        ; =0x00af [Uninitialized memory]
80b1:W80B1 DS    569        ; =0x0239 [Uninitialized memory]
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
8d2f:ENTRY JMP   D8D33      ; =+2 [Jump relative]
*
8d31:W8D31 DS    2          ; =0x0002 [Uninitialized memory]
*
8d33:D8D33 JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8d36:      STBB/ B8D8F+1    ; =0x8d90 =36240(-29296) [Store BL direct]
8d39:      STA   W8D31      ; =-10 [Store A relative]
8d3b:      XAY              ; [Transfer A to Y]
8d3c:      LDAB+ Y,1        ; [Load AL indexed, displaced, direct]
8d3f:      LDBB= X'04'      ; =4 [Load BL with immediate]
8d41:      SABB             ; [AL - BL -> BL]
8d42:      BZ    D8D49      ; =+5 [Branch if zero]
8d44:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d47:      DW    X'0006'    ; =0x0006 =6
*
8d49:D8D49 LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
8d4c:      STAB  B8D63      ; =+21 [Store AL relative]
8d4e:      STAB/ B8DED      ; =0x8ded =36333(-29203) =CR,'m' [Store AL direct]
8d51:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8d54:      LDBB+ B,5        ; [Load BL indexed, displaced, direct]
8d57:      SABB             ; [AL - BL -> BL]
8d58:      BZ    D8D94      ; =+58 [Branch if zero]
8d5a:      LDX=  X'0005'    ; =0x0005 =5 [Load X with immediate]
8d5d:D8D5D SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
8d5f:      DW    X'0006'    ; =0x0006 =6
8d61:      DW    W8E5E      ; =0x8e5e =36446(-29090) [TODO: arg1]
8d63:B8D63 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg2]
8d65:      DB    X'0E'      ; =0x0e =14 [TODO: arg3]
8d66:      DW    W8E96      ; =0x8e96 =36502(-29034) [TODO: arg4]
8d68:      DW    X'815D'    ; =0x815d =33117(-32419) [TODO: arg5]
8d6a:      BZ    D8D71      ; =+5 [Branch if zero]
8d6c:      DCX              ; [Decrement X]
8d6d:      BGZ   D8D5D      ; =-18 [Branch if greater than zero]
8d6f:      JMP   D8D7F      ; =+14 [Jump relative]
8d71:D8D71 LDA/  W8E98      ; =0x8e98 =36504(-29032) [Load A direct]
8d74:      LDB=  X'4321'    ; =0x4321 =17185 [Load B with immediate]
8d77:      SAB              ; [A - B -> B]
8d78:      BZ    D8D7F      ; =+5 [Branch if zero]
8d7a:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d7d:      DW    X'0029'    ; =0x0029 =41
*
8d7f:D8D7F XFR/  X'005A',Z  ; =0x005a =90 [Transfer direct to Z]
8d83:      LDX+  Z,17       ; [Load X indexed, displaced, direct]
8d86:      LDA+  Z,13       ; [Load A indexed, displaced, direct]
8d89:      XAY              ; [Transfer A to Y]
8d8a:D8D8A CLA              ; [Clear A]
8d8b:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8d8d:      BM    D8D99      ; =+10 [Branch on minus]
8d8f:B8D8F LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8d91:      SABB             ; [AL - BL -> BL]
8d92:      BNZ   D8D99      ; =+5 [Branch if not zero]
8d94:D8D94 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d97:      DW    X'001F'    ; =0x001f =31
*
8d99:D8D99 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8d9b:      DCX              ; [Decrement X]
8d9c:      BP    D8D8A      ; =-20 [Branch on plus]
8d9e:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8da1:      LDA+  A,9        ; [Load A indexed, displaced, direct]
8da4:      XAZ              ; [Transfer A to Z]
8da5:D8DA5 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
8da7:      BZ    D8DBF      ; =+22 [Branch if zero]
8da9:      LDAB+ B,1        ; [Load AL indexed, displaced, direct]
8dac:      DCRB  AL,9       ; [Decrement AL by 9]
8dae:      BNZ   D8DA5      ; =-11 [Branch if not zero]
8db0:      LDA+  B,5        ; [Load A indexed, displaced, direct]
8db3:      BZ    D8DA5      ; =-16 [Branch if zero]
8db5:      LDAB+ B,38       ; [Load AL indexed, displaced, direct]
8db8:      LDBB  B8D63      ; =-87 [Load BL relative]
8dba:      SABB             ; [AL - BL -> BL]
8dbb:      BNZ   D8DA5      ; =-24 [Branch if not zero]
8dbd:      JMP   D8D94      ; =-43 [Jump relative]
8dbf:D8DBF LDA/  W8D31      ; =0x8d31 =36145(-29391) [Load A direct]
8dc2:      XAY              ; [Transfer A to Y]
8dc3:      LDAB= X'20'      ; =32 [Load AL with immediate]
8dc5:      LDBB+ Y          ; [Load BL from address in Y]
8dc6:      NABB             ; [AL & BL -> BL]
8dc7:      BZ    D8DCC      ; =+3 [Branch if zero]
8dc9:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8dcb:      DB    X'16'      ; =0x16 =22 [abort code]
*
8dcc:D8DCC LDBB+ Y          ; [Load BL from address in Y]
8dcd:      ORIB  AL,BL      ; [AL | BL -> BL]
8dcf:      STBB+ Y          ; [Store BL to address in Y]
8dd0:      LDA/  W80B1      ; =0x80b1 =32945(-32591) [Load A direct]
8dd3:      STA+  Y,13       ; [Store A indexed, displaced, direct]
8dd6:      XAY              ; [Transfer A to Y]
8dd7:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8dda:      LDBB= X'08'      ; =8 [Load BL with immediate]
8ddc:      ORIB  AL,BL      ; [AL | BL -> BL]
8dde:      STBB+ Y,18       ; [Store BL indexed, displaced, direct]
8de1:      LDA/  W8E96      ; =0x8e96 =36502(-29034) [Load A direct]
8de4:      STA/  W8E9C      ; =0x8e9c =36508(-29028) [Store A direct]
8de7:      SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
8de9:      DW    X'000A'    ; =0x000a =10
8deb:      DW    W8E5E      ; =0x8e5e =36446(-29090) [TODO: arg1]
8ded:B8DED DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg2]
8def:      DB    X'0E'      ; =0x0e =14 [TODO: arg3]
8df0:      DW    W8E9C      ; =0x8e9c =36508(-29028) [TODO: arg4]
8df2:      DB    X'82'      ; =0x82 =130(-126) [TODO: arg5]
8df3:      MVF   (2)/W8D31,/W8002 ; =0x8d31 =36145(-29391),=0x8002 =32770(-32766) [Move fixed-length, direct, direct]
8dfa:      LDA/  W8D31      ; =0x8d31 =36145(-29391) [Load A direct]
8dfd:      LDA+  A,17       ; [Load A indexed, displaced, direct]
8e00:      LDB=  X'FFFF'    ; =0xffff =65535(-1) [Load B with immediate]
8e03:      SAB              ; [A - B -> B]
8e04:      BNZ   D8E09      ; =+3 [Branch if not zero]
8e06:      JMP/  D8E58      ; =0x8e58 =36440(-29096) [Jump direct]
8e09:D8E09 LDB=  X'0320'    ; =0x0320 =800 [Load B with immediate]
8e0c:      SAB              ; [A - B -> B]
8e0d:      BP    D8E21      ; =+18 [Branch on plus]
8e0f:      LDA=  X'0026'    ; =0x0026 =38 [Load A with immediate]
8e12:D8E12 XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8e16:      ORC   (1)=X'02',-Y,0 ; [OR bytes, literal=2, displaced indexed]
8e1c:      SVC   X'04'      ; =4 [Service call LODJX - load JX module specified]
8e1e:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
8e20:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
*
8e21:D8E21 STA-  S-         ; [Store A indexed, pre-decremented, direct]
8e23:      LDB=  X'0446'    ; =0x0446 =1094 [Load B with immediate]
8e26:      DIV   B,A        ; [A / B -> B, A % B -> A]
8e28:      BL    D8E31      ; =+7 [Branch on link]
8e2a:      INR   S,2        ; [Increment S by 2]
8e2c:      LDA=  X'002A'    ; =0x002a =42 [Load A with immediate]
8e2f:      JMP   D8E12      ; =-31 [Jump relative]
8e31:D8E31 LDA+  S          ; [Load A from address in S]
8e32:      LDB=  X'0390'    ; =0x0390 =912 [Load B with immediate]
8e35:      DIV   B,A        ; [A / B -> B, A % B -> A]
8e37:      BL    D8E40      ; =+7 [Branch on link]
8e39:      INR   S,2        ; [Increment S by 2]
8e3b:      LDA=  X'0038'    ; =0x0038 =56 [Load A with immediate]
8e3e:      JMP   D8E12      ; =-46 [Jump relative]
8e40:D8E40 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8e42:      LDB=  X'08D1'    ; =0x08d1 =2257 [Load B with immediate]
8e45:      SAB              ; [A - B -> B]
8e46:      BZ    D8E58      ; =+16 [Branch if zero]
8e48:      LDB=  X'07D0'    ; =0x07d0 =2000 [Load B with immediate]
8e4b:      SAB              ; [A - B -> B]
8e4c:      BP    D8E53      ; =+5 [Branch on plus]
8e4e:      LDA=  X'0027'    ; =0x0027 =39 [Load A with immediate]
8e51:      JMP   D8E12      ; =-65 [Jump relative]
8e53:D8E53 LDA=  X'0029'    ; =0x0029 =41 [Load A with immediate]
8e56:      JMP   D8E12      ; =-70 [Jump relative]
8e58:D8E58 LDA=  X'0030'    ; =0x0030 =48 [Load A with immediate]
8e5b:      JMP/  D8E12      ; =0x8e12 =36370(-29166) [Jump direct]
*
8e5e:W8E5E DW    W8E66      ; =0x8e66 =36454(-29082)
8e60:      DB    0,6        ; =0x00,0x0006
8e66:W8E66 DW    X'0100'    ; =0x0100 =256
8e68:      DW    X'FFFF'    ; =0xffff =65535(-1)
8e6a:      DW    X'0F00'    ; =0x0f00 =3840
8e6c:      DB    0,37       ; =0x00,0x0025
8e91:      DW    S8E93      ; =0x8e93 =36499(-29037)
8e93:S8E93 DB    0,3        ; =0x00,0x0003
8e96:W8E96 DS    2          ; =0x0002 [Uninitialized memory]
8e98:W8E98 DS    4          ; =0x0004 [Uninitialized memory]
8e9c:W8E9C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e9e:      DW    X'4321'    ; =0x4321 =17185
8ea0:      DB    0,4        ; =0x00,0x0004
8ea4:      DC    '}}'       ; hex:fdfd dec:65021(-3)
8ea6:ENDPT
