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
825f:F825F DS    31         ; =0x001f [Uninitialized memory]
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
82ea:F82EA DS    67         ; =0x0043 [Uninitialized memory]
*
*
* Function F832D
*
832d:F832D DS    2525       ; =0x09dd [Uninitialized memory]
*
*
* Function F8D0A
*
8d0a:F8D0A DS    37         ; =0x0025 [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d36:      BNZ   D8D3A      ; =+2 [Branch if not zero]
8d38:      JMP   D8D3E      ; =+4 [Jump relative]
8d3a:D8D3A JSR   F8D8B      ; =+79 [Jump to subroutine relative]
8d3c:      JMP   D8D88      ; =+74 [Jump relative]
8d3e:D8D3E CAD/  W8D67+1    ; [Clear word at address]
8d42:      LDB+  Y,23       ; [Load B indexed, displaced, direct]
8d45:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8d48:      SUB   B,A        ; [B - A -> A]
8d4a:      STA   W8D4F      ; =+3 [Store A relative]
8d4c:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8d4f:W8D4F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8d51:      XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d55:      LDA+  Y,10       ; [Load A indexed, displaced, direct]
8d58:      STA+  Y,14       ; [Store A indexed, displaced, direct]
8d5b:      JSR   F8D8B      ; =+46 [Jump to subroutine relative]
8d5d:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8d60:      LDBB= X'04'      ; =4 [Load BL with immediate]
8d62:      ORIB  AL,BL      ; [AL | BL -> BL]
8d64:      STBB+ Y,18       ; [Store BL indexed, displaced, direct]
8d67:W8D67 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8d6a:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8d6d:      LDA+  A,66       ; [Load A indexed, displaced, direct]
8d70:      INA              ; [Increment A]
8d71:      BNZ   D8D77      ; =+4 [Branch if not zero]
8d73:      XFR   B,B        ; [Transfer B to B]
8d75:      BZ    D8D88      ; =+17 [Branch if zero]
8d77:D8D77 DCA              ; [Decrement A]
8d78:      SUB   B,A        ; [B - A -> A]
8d7a:      BL    D8D82      ; =+6 [Branch on link]
8d7c:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8d7f:      LDB+  A,66       ; [Load B indexed, displaced, direct]
8d82:D8D82 LDA/  W80B1      ; =0x80b1 =32945(-32591) [Load A direct]
8d85:      STB+  A,52       ; [Store B indexed, displaced, direct]
8d88:D8D88 JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8D8B
*
8d8b:F8D8B STX-  S-         ; [Store X indexed, pre-decremented, direct]
8d8d:      CLR   X          ; [Clear X]
8d8f:D8D8F LDAB+ Z          ; [Load AL from address in Z]
8d90:      BNZ   D8D95      ; =+3 [Branch if not zero]
8d92:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8d94:      RSR              ; [Return from subroutine]
*
8d95:D8D95 JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8d98:      BP    D8D9D      ; =+3 [Branch on plus]
8d9a:      JMP/  J8E20      ; =0x8e20 =36384(-29152) [Jump direct]
8d9d:D8D9D XFR   Z,A        ; [Transfer Z to A]
8d9f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8da1:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8da4:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8da6:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8da9:      DC    '='        ; hex:bd dec:189(-67)
8daa:      DB    X'01'      ; =0x01 =1
8dab:      BNZ   D8DB4      ; =+7 [Branch if not zero]
8dad:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8daf:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8db1:      XAZ              ; [Transfer A to Z]
8db2:      JMP   D8DB8      ; =+4 [Jump relative]
8db4:D8DB4 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8db6:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8db8:D8DB8 XFR   X,A        ; [Transfer X to A]
8dba:      INX              ; [Increment X]
8dbb:      CLRB  AU         ; [Clear AU]
8dbd:      XABB             ; [Transfer AL to BL]
8dbe:      BM    D8DC6      ; =+6 [Branch on minus]
8dc0:      LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8dc3:      SABB             ; [AL - BL -> BL]
8dc4:      BM    D8DCB      ; =+5 [Branch on minus]
8dc6:D8DC6 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8dc9:      DW    X'001C'    ; =0x001c =28
*
8dcb:D8DCB SLA              ; [Left shift A]
8dcc:      XAB              ; [Transfer A to B]
8dcd:      SLA              ; [Left shift A]
8dce:      SLA              ; [Left shift A]
8dcf:      AAB              ; [A + B -> B]
8dd0:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8dd3:      AAB              ; [A + B -> B]
8dd4:      STB   W8DEF      ; =+25 [Store B relative]
8dd6:      STB   W8E10      ; =+56 [Store B relative]
8dd8:      LDAB+ Z          ; [Load AL from address in Z]
8dd9:      BZ    D8DF1      ; =+22 [Branch if zero]
8ddb:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
8ddd:      SABB             ; [AL - BL -> BL]
8dde:      BZ    D8DF8      ; =+24 [Branch if zero]
8de0:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8de2:      SABB             ; [AL - BL -> BL]
8de3:      BZ    D8DF8      ; =+19 [Branch if zero]
8de5:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8de8:      DC    ','        ; hex:ac dec:172(-84)
8de9:      DB    X'01'      ; =0x01 =1
8dea:      BNZ   D8DF6      ; =+10 [Branch if not zero]
8dec:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8def:W8DEF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8df1:D8DF1 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8df4:      DC    ','        ; hex:ac dec:172(-84)
8df5:      DB    X'01'      ; =0x01 =1
*
8df6:D8DF6 JMP   D8D8F      ; =-105 [Jump relative]
8df8:D8DF8 INR   Z          ; [Increment Z by 1]
8dfa:      XFR   Z,B        ; [Transfer Z to B]
8dfc:      STB   W8E12      ; =+20 [Store B relative]
8dfe:D8DFE LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8e00:      BNZ   D8E19      ; =+23 [Branch if not zero]
8e02:      DCR   Z          ; [Decrement Z by 1]
8e04:      CLA              ; [Clear A]
8e05:D8E05 LDB   W8E12      ; =+11 [Load B relative]
8e07:      AAB              ; [A + B -> B]
8e08:      SUB   Z,B        ; [Z - B -> B]
8e0a:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8e0d:      JSR/  F8D0A      ; =0x8d0a =36106(-29430) [Jump to subroutine direct]
8e10:W8E10 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e12:W8E12 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e14:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8e17:      JMP   D8DF1      ; =-40 [Jump relative]
8e19:D8E19 SABB             ; [AL - BL -> BL]
8e1a:      BNZ   D8DFE      ; =-30 [Branch if not zero]
8e1c:      CLA              ; [Clear A]
8e1d:      INA              ; [Increment A]
8e1e:      JMP   D8E05      ; =-27 [Jump relative]
8e20:J8E20 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e23:      DC    'TIME='    ; hex:d4c9cdc5bd
8e28:      DB    X'01'      ; =0x01 =1
8e29:      BNZ   D8E59      ; =+46 [Branch if not zero]
8e2b:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e2e:      DC    'MEMORY='  ; hex:cdc5cdcfd2d9bd
8e35:      DB    X'01'      ; =0x01 =1
8e36:      BZ    D8E87      ; =+79 [Branch if zero]
8e38:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e3b:      DC    'WAIT'     ; hex:d7c1c9d4
8e3f:      DB    X'01'      ; =0x01 =1
8e40:      BNZ   D8E51      ; =+15 [Branch if not zero]
8e42:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e45:      DC    'CANCEL'   ; hex:c3c1cec3c5cc
8e4b:      DB    X'01'      ; =0x01 =1
8e4c:      BNZ   D8DF1      ; =-93 [Branch if not zero]
8e4e:D8E4E JMP/  D8DC6      ; =0x8dc6 =36294(-29242) =CR,'F' [Jump direct]
8e51:D8E51 LDAB+ Y          ; [Load AL from address in Y]
8e52:      LDBB= X'10'      ; =16 [Load BL with immediate]
8e54:      ORIB  AL,BL      ; [AL | BL -> BL]
8e56:      STBB+ Y          ; [Store BL to address in Y]
8e57:      JMP   D8DF1      ; =-104 [Jump relative]
8e59:D8E59 LDAB+ Z          ; [Load AL from address in Z]
8e5a:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8e5d:      BM    D8E4E      ; =-17 [Branch on minus]
8e5f:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8e62:      STA/  W8D67+1    ; =0x8d68 =36200(-29336) [Store A direct]
8e65:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e68:      DC    'MIN'      ; hex:cdc9ce
8e6b:      DB    X'01'      ; =0x01 =1
8e6c:      BNZ   D8E7A      ; =+12 [Branch if not zero]
8e6e:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e71:      DC    'SEC'      ; hex:d3c5c3
8e74:      DB    X'01'      ; =0x01 =1
8e75:      BZ    D8E4E      ; =-41 [Branch if zero]
8e77:      JMP/  D8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Jump direct]
8e7a:D8E7A LDB/  W8D67+1    ; =0x8d68 =36200(-29336) [Load B direct]
8e7d:      MUL=  X'003C',B  ; =0x003c =60 [60 * B -> B]
8e81:      STB/  W8D67+1    ; =0x8d68 =36200(-29336) [Store B direct]
8e84:      JMP/  D8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Jump direct]
8e87:D8E87 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e8a:      DC    'ABORT='   ; hex:c1c2cfd2d4bd
8e90:      DB    X'01'      ; =0x01 =1
8e91:      BZ    D8EBB      ; =+40 [Branch if zero]
8e93:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e96:      DC    'ASK'      ; hex:c1d3cb
8e99:      DB    X'01'      ; =0x01 =1
8e9a:      BZ    D8E9F      ; =+3 [Branch if zero]
8e9c:      JMP/  D8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Jump direct]
8e9f:D8E9F JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ea2:      DC    'CANCEL'   ; hex:c3c1cec3c5cc
8ea8:      DB    X'01'      ; =0x01 =1
8ea9:      BNZ   D8EAE      ; =+3 [Branch if not zero]
8eab:D8EAB JMP/  D8DC6      ; =0x8dc6 =36294(-29242) =CR,'F' [Jump direct]
8eae:D8EAE LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8eb1:      LDBB= X'40'      ; =64 [Load BL with immediate]
8eb3:      ORIB  AL,BL      ; [AL | BL -> BL]
8eb5:      STBB+ Y,18       ; [Store BL indexed, displaced, direct]
8eb8:      JMP/  D8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Jump direct]
8ebb:D8EBB JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ebe:      DC    'FORM='    ; hex:c6cfd2cdbd
8ec3:      DB    X'01'      ; =0x01 =1
8ec4:      BZ    D8EEE      ; =+40 [Branch if zero]
8ec6:      LDAB+ Z          ; [Load AL from address in Z]
8ec7:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8eca:      BM    D8EAB      ; =-33 [Branch on minus]
8ecc:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8ecf:      STA   W8EE5+1    ; =+21 [Store A relative]
8ed1:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ed4:      DC    ',HOLD'    ; hex:acc8cfccc4
8ed9:      DB    X'01'      ; =0x01 =1
8eda:      BZ    W8EE5      ; =+9 [Branch if zero]
8edc:      LDB   W8EE5+1    ; =+8 [Load B relative]
8ede:      LDA=  X'8000'    ; =0x8000 =32768(-32768) [Load A with immediate]
8ee1:      ORI   A,B        ; [A | B -> B]
8ee3:      STB   W8EE5+1    ; =+1 [Store B relative]
8ee5:W8EE5 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8ee8:      STA+  Y,87       ; [Store A indexed, displaced, direct]
8eeb:      JMP/  D8DF1      ; =0x8df1 =36337(-29199) =CR,'q' [Jump direct]
8eee:D8EEE JMP/  D8DB8      ; =0x8db8 =36280(-29256) =CR,'8' [Jump direct]
8ef1:ENDPT
