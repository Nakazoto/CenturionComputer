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
8002:W8002 DS    2          ; =0x0002 [Uninitialized memory]
8004:W8004 DS    173        ; =0x00ad [Uninitialized memory]
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
8341:F8341 DS    390        ; =0x0186 [Uninitialized memory]
84c7:W84C7 DS    2152       ; =0x0868 [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8d36:      SLA              ; [Left shift A]
8d37:      ADD=  W8D3D,A    ; =0x8d3d =36157(-29379) [36157 + A -> A]
8d3b:      JMP+  *A         ; [Jump indexed, indirect]
*
8d3d:W8D3D DW    W8D45      ; =0x8d45 =36165(-29371)
8d3f:      DW    W8D65      ; =0x8d65 =36197(-29339)
8d41:      DW    W8DA9      ; =0x8da9 =36265(-29271) =CR,')'
8d43:      DW    W8DE5      ; =0x8de5 =36325(-29211) =CR,'e'
*
8d45:W8D45 CAD/  W8002      ; [Clear word at address]
8d49:D8D49 LDB/  W84C7      ; =0x84c7 =33991(-31545) =EOT,'G' [Load B direct]
8d4c:      LDAB= X'0B'      ; =11 [Load AL with immediate]
8d4e:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8d51:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8d53:      XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d57:      ORC   (1)=X'02',-Y,0 ; [OR bytes, literal=2, displaced indexed]
8d5d:      LDA=  X'0028'    ; =0x0028 =40 [Load A with immediate]
8d60:      SVC   X'04'      ; =4 [Service call LODJX - load JX module specified]
8d62:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
8d64:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg2]
*
8d65:W8D65 LDAB+ Z          ; [Load AL from address in Z]
8d66:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8d69:      BM    D8D91      ; =+38 [Branch on minus]
8d6b:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8d6e:      XABB             ; [Transfer AL to BL]
8d6f:      BM    D8D8C      ; =+27 [Branch on minus]
8d71:      LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8d74:      SABB             ; [AL - BL -> BL]
8d75:      BP    D8D8C      ; =+21 [Branch on plus]
8d77:      CLRB  AU         ; [Clear AU]
8d79:      SLA              ; [Left shift A]
8d7a:      XAB              ; [Transfer A to B]
8d7b:      SLA              ; [Left shift A]
8d7c:      SLA              ; [Left shift A]
8d7d:      AAB              ; [A + B -> B]
8d7e:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8d81:      AAB              ; [A + B -> B]
8d82:      STB/  W8004      ; =0x8004 =32772(-32764) [Store B direct]
8d85:D8D85 CLR   A,1        ; [Set A to 1]
8d87:      STA/  W8002      ; =0x8002 =32770(-32766) [Store A direct]
8d8a:      JMP   D8D49      ; =-67 [Jump relative]
8d8c:D8D8C JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d8f:      DW    X'001C'    ; =0x001c =28
*
8d91:D8D91 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d94:      DC    'CC'       ; hex:c3c3 dec:50115(-61)
8d96:      DB    X'01'      ; =0x01 =1
8d97:      BNZ   D8DA3      ; =+10 [Branch if not zero]
8d99:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d9c:      DC    'UPSI'     ; hex:d5d0d3c9
8da0:      DB    X'02'      ; =0x02 =2
8da1:      BZ    D8D8C      ; =-23 [Branch if zero]
8da3:D8DA3 DCA              ; [Decrement A]
8da4:      STA/  W8004      ; =0x8004 =32772(-32764) [Store A direct]
8da7:      JMP   D8D85      ; =-36 [Jump relative]
8da9:W8DA9 SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
8dab:      DB    X'1C'      ; =0x1c =28 [TODO: arg 1]
8dac:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8daf:      XAY              ; [Transfer A to Y]
8db0:      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
8db3:      STAB  B8E11      ; =+92 [Store AL relative]
8db5:      JSR   F8E07      ; =+80 [Jump to subroutine relative]
8db7:      DB    X'01'      ; =0x01 =1
8db8:      CAD/  W8E52      ; [Clear word at address]
8dbc:      JMP   D8DF9      ; =+59 [Jump relative]
8dbe:      LDAB/ B8E58      ; =0x8e58 =36440(-29096) [Load AL direct]
8dc1:      INAB             ; [Increment AL]
8dc2:      BNZ   D8DE4      ; =+32 [Branch if not zero]
8dc4:      LDA/  W8E56      ; =0x8e56 =36438(-29098) [Load A direct]
8dc7:      IVA              ; [Invert A]
8dc8:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
8dca:      RL               ; [Reset link]
8dcb:      RRR   A          ; [Right rotate A by 1]
8dcd:      BNL   D8DD1      ; =+2 [Branch on no link]
8dcf:      ORIB  BL,AU      ; [BL | AU -> AU]
8dd1:D8DD1 LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
8dd4:      OREB  BL,BU      ; [BL ^ BU -> BU]
8dd6:      ORE   A,B        ; [A ^ B -> B]
8dd8:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8ddb:      SAB              ; [A - B -> B]
8ddc:      BZ    D8DE4      ; =+6 [Branch if zero]
8dde:      CLA              ; [Clear A]
8ddf:      DCA              ; [Decrement A]
8de0:      XAB              ; [Transfer A to B]
8de1:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8de3:      DB    X'30'      ; =0x30 =48 [abort code]
*
8de4:D8DE4 RSR              ; [Return from subroutine]
*
8de5:W8DE5 SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
8de7:      DB    X'1C'      ; =0x1c =28 [TODO: arg 1]
8de8:      JSR/  F8341      ; =0x8341 =33601(-31935) [Jump to subroutine direct]
8deb:      XAY              ; [Transfer A to Y]
8dec:      LDAB+ Y,2        ; [Load AL indexed, displaced, direct]
8def:      STAB  B8E11      ; =+32 [Store AL relative]
8df1:      JSR   F8E07      ; =+20 [Jump to subroutine relative]
8df3:      DB    X'01'      ; =0x01 =1
8df4:      LDA=  X'4321'    ; =0x4321 =17185 [Load A with immediate]
8df7:      STA   W8E52      ; =+89 [Store A relative]
8df9:D8DF9 JSR   F8E07      ; =+12 [Jump to subroutine relative]
8dfb:      DB    X'02'      ; =0x02 =2
8dfc:      CLAB             ; [Clear AL]
8dfd:      DCAB             ; [Decrement AL]
8dfe:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8e01:      STAB+ B,28       ; [Store AL indexed, displaced, direct]
8e04:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8E07
*
8e07:F8E07 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8e09:      STAB  B8E16      ; =+11 [Store AL relative]
8e0b:      SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
8e0d:      DW    X'0190'    ; =0x0190 =400
8e0f:      DW    W8E18      ; =0x8e18 =36376(-29160) [TODO: arg1]
8e11:B8E11 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg2]
8e13:      DB    X'0E'      ; =0x0e =14 [TODO: arg3]
8e14:      DW    W8E50      ; =0x8e50 =36432(-29104) [TODO: arg4]
8e16:B8E16 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg5]
8e17:      RSR              ; [Return from subroutine]
*
8e18:W8E18 DW    W8E20      ; =0x8e20 =36384(-29152)
8e1a:      DB    0,6        ; =0x00,0x0006
8e20:W8E20 DW    X'0100'    ; =0x0100 =256
8e22:      DW    X'FFFF'    ; =0xffff =65535(-1)
8e24:      DW    X'0F00'    ; =0x0f00 =3840
8e26:      DB    0,37       ; =0x00,0x0025
8e4b:      DW    S8E4D      ; =0x8e4d =36429(-29107)
8e4d:S8E4D DB    0,3        ; =0x00,0x0003
8e50:W8E50 DS    2          ; =0x0002 [Uninitialized memory]
8e52:W8E52 DS    4          ; =0x0004 [Uninitialized memory]
8e56:W8E56 DS    2          ; =0x0002 [Uninitialized memory]
8e58:B8E58 DS    394        ; =0x018a [Uninitialized memory]
8fe2:      DB    X'00'      ; =0x00 =0 =NUL
8fe3:ENDPT
