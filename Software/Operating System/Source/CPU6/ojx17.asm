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
827e:F827E DS    10         ; =0x000a [Uninitialized memory]
*
*
* Function F8288
*
8288:F8288 DS    22         ; =0x0016 [Uninitialized memory]
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
8d36:      BZ    D8D3B      ; =+3 [Branch if zero]
8d38:      JMP/  J8F4A      ; =0x8f4a =36682(-28854) [Jump direct]
8d3b:D8D3B JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d3e:      DC    ','        ; hex:ac dec:172(-84)
8d3f:      DB    X'01'      ; =0x01 =1
8d40:      LDAB+ Z          ; [Load AL from address in Z]
8d41:      BNZ   D8D46      ; =+3 [Branch if not zero]
8d43:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
8d46:D8D46 XFR   Z,A        ; [Transfer Z to A]
8d48:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8d4a:      JSR/  F8288      ; =0x8288 =33416(-32120) [Jump to subroutine direct]
8d4d:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d50:      DC    '='        ; hex:bd dec:189(-67)
8d51:      DB    X'01'      ; =0x01 =1
8d52:      BNZ   D8D6C      ; =+24 [Branch if not zero]
8d54:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d57:      DC    'EQ'       ; hex:c5d1 dec:50641(-47)
8d59:      DB    X'01'      ; =0x01 =1
8d5a:      BNZ   D8D6C      ; =+16 [Branch if not zero]
8d5c:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d5f:      DW    X'001B'    ; =0x001b =27
8d61:S8D61 DC    '        ' ; hex:a0a0a0a0a0a0a0a0
8d69:S8D69 DC    '  '       ; hex:a0a0 dec:41120(-96)
8d6b:      DB    X'00'      ; =0x00 =0 =NUL
*
8d6c:D8D6C XFR=  W907F,Y    ; =0x907f =36991(-28545) [Transfer immediate to Y]
8d70:      JSR/  F8E36      ; =0x8e36 =36406(-29130) [Jump to subroutine direct]
8d73:      LDX/  W80B1      ; =0x80b1 =32945(-32591) [Load X direct]
8d76:      LDA+  S          ; [Load A from address in S]
8d77:      XFR   Z,B        ; [Transfer Z to B]
8d79:      STB+  S          ; [Store B to address in S]
8d7a:      XAZ              ; [Transfer A to Z]
8d7b:      LDAB+ Z          ; [Load AL from address in Z]
8d7c:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8d7f:      BM    P8DE4      ; =+99 [Branch on minus]
8d81:      LDA+  Y          ; [Load A from address in Y]
8d82:      BP    D8D8E      ; =+10 [Branch on plus]
8d84:      M     =-1,-Y(6)  ; [Multiply bignums, literal=0xff, indexed]
8d89:      CLRB  AL,1       ; [Set AL to 1]
8d8b:      STAB/ W907F      ; =0x907f =36991(-28545) [Store AL direct]
8d8e:D8D8E STK   Y,4        ; [Push Y Z to the stack]
8d90:      FIL   (10)='@',/S8D61 ; =0x8d61 =36193(-29343) [Fill with byte, literal=0xc0(192,-64), direct]
8d96:      LDAB= X'A3'      ; =163(-93) ='#' [Load AL with immediate]
8d98:      STAB/ S8D69      ; =0x8d69 =36201(-29335) [Store AL direct]
8d9b:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8d9e:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8da0:      CFB   /S8D61(10),-Y(6) ; =0x8d61 =36193(-29343), [Convert from bignum, direct, indexed]
8da6:      LDAB/ W907F      ; =0x907f =36991(-28545) [Load AL direct]
8da9:      BZ    D8DB4      ; =+9 [Branch if zero]
8dab:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
8dad:      STAB/ S8D61      ; =0x8d61 =36193(-29343) [Store AL direct]
8db0:      CLAB             ; [Clear AL]
8db1:      STAB/ W907F      ; =0x907f =36991(-28545) [Store AL direct]
8db4:D8DB4 POP   Y,4        ; [Pop Z Y from the stack]
8db6:      XFR=  S8D61,Y    ; =0x8d61 =36193(-29343) [Transfer immediate to Y]
8dba:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8dbd:      XABB             ; [Transfer AL to BL]
8dbe:      BM    D8DD9      ; =+25 [Branch on minus]
8dc0:      LDBB+ X,22       ; [Load BL indexed, displaced, direct]
8dc3:      SABB             ; [AL - BL -> BL]
8dc4:      BP    D8DD9      ; =+19 [Branch on plus]
8dc6:      CLRB  AU         ; [Clear AU]
8dc8:      SLA              ; [Left shift A]
8dc9:      XAB              ; [Transfer A to B]
8dca:      SLA              ; [Left shift A]
8dcb:      SLA              ; [Left shift A]
8dcc:      AAB              ; [A + B -> B]
8dcd:      LDA+  X,23       ; [Load A indexed, displaced, direct]
8dd0:      AAB              ; [A + B -> B]
8dd1:D8DD1 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8dd3:      BZ    D8DDE      ; =+9 [Branch if zero]
8dd5:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
8dd7:      JMP   D8DD1      ; =-8 [Jump relative]
8dd9:D8DD9 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8ddc:      DW    X'001C'    ; =0x001c =28
*
8dde:D8DDE LDA+  S+         ; [Load A indexed, direct, post-incremented]
8de0:      XAZ              ; [Transfer A to Z]
8de1:      JMP/  D8D3B      ; =0x8d3b =36155(-29381) [Jump direct]
8de4:P8DE4 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8de7:      DC    'UPSI'     ; hex:d5d0d3c9
8deb:      DB    X'15'      ; =0x15 =21
8dec:      BNZ   D8E1E      ; =+48 [Branch if not zero]
8dee:      JSR*  P8DE4+1    ; =-11 [Jump to subroutine relative indirect]
8df0:      DC    'CC'       ; hex:c3c3 dec:50115(-61)
8df2:      DB    X'14'      ; =0x14 =20
8df3:      BNZ   D8E1E      ; =+41 [Branch if not zero]
8df5:      JSR*  P8DE4+1    ; =-18 [Jump to subroutine relative indirect]
8df7:      DC    'DD'       ; hex:c4c4 dec:50372(-60)
8df9:      DB    X'31'      ; =0x31 =49
8dfa:      BNZ   D8E11      ; =+21 [Branch if not zero]
8dfc:      JSR*  P8DE4+1    ; =-25 [Jump to subroutine relative indirect]
8dfe:      DC    'DT'       ; hex:c4d4 dec:50388(-44)
8e00:      DB    X'5E'      ; =0x5e =94
8e01:      BNZ   D8E11      ; =+14 [Branch if not zero]
8e03:      JSR*  P8DE4+1    ; =-32 [Jump to subroutine relative indirect]
8e05:      DC    'DL'       ; hex:c4cc dec:50380(-52)
8e07:      DB    X'5F'      ; =0x5f =95
8e08:      BNZ   D8E11      ; =+7 [Branch if not zero]
8e0a:      JSR*  P8DE4+1    ; =-39 [Jump to subroutine relative indirect]
8e0c:      DC    'DW'       ; hex:c4d7 dec:50391(-41)
8e0e:      DB    X'60'      ; =0x60 =96
8e0f:      BZ    D8DD9      ; =-56 [Branch if zero]
8e11:D8E11 LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8e14:      LDB+  B,6        ; [Load B indexed, displaced, direct]
8e17:      LDBB+ Y,5        ; [Load BL indexed, displaced, direct]
8e1a:      SUBB  BL,BU      ; [BL - BU -> BU]
8e1c:      BGZ   D8E31      ; =+19 [Branch if greater than zero]
8e1e:D8E1E ADD   A,X        ; [A + X -> X]
8e20:      CPF   (5)=X'0000000000',-Y ; [Compare fixed-length, literal=0, indexed]
8e29:      BNZ   D8E31      ; =+6 [Branch if not zero]
8e2b:      LDAB+ Y,5        ; [Load AL indexed, displaced, direct]
8e2e:      STAB+ X          ; [Store AL to address in X]
8e2f:      JMP   D8DDE      ; =-83 [Jump relative]
8e31:D8E31 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8e34:      DW    X'0009'    ; =0x0009 =9
*
*
* Function F8E36
*
8e36:F8E36 JSR*  P8DE4+1    ; =-83 [Jump to subroutine relative indirect]
8e38:      DC    '-'        ; hex:ad dec:173(-83)
8e39:      DB    X'01'      ; =0x01 =1
8e3a:      BZ    D8E45      ; =+9 [Branch if zero]
8e3c:      JSR   F8E8B      ; =+77 [Jump to subroutine relative]
8e3e:      M     =-1,-Y(6)  ; [Multiply bignums, literal=0xff, indexed]
8e43:      JMP   D8E4B      ; =+6 [Jump relative]
8e45:D8E45 JSR*  P8DE4+1    ; =-98 [Jump to subroutine relative indirect]
8e47:      DC    '+'        ; hex:ab dec:171(-85)
8e48:      DB    X'01'      ; =0x01 =1
*
8e49:      JSR   F8E8B      ; =+64 [Jump to subroutine relative]
8e4b:D8E4B JSR*  P8DE4+1    ; =-104 [Jump to subroutine relative indirect]
8e4d:      DC    '-'        ; hex:ad dec:173(-83)
8e4e:      DB    X'01'      ; =0x01 =1
8e4f:      BZ    D8E62      ; =+17 [Branch if zero]
8e51:      JSR   F8E7A      ; =+39 [Jump to subroutine relative]
8e53:      S     /N9096(6),/N9090(6) ; =0x9096 =37014(-28522),=0x9090 =37008(-28528) [Subtract bignums, direct, direct]
8e5a:      MVF   (6)/N9090,-Y ; =0x9090 =37008(-28528), [Move fixed-length, direct, indexed]
8e60:      JMP   D8E4B      ; =-23 [Jump relative]
8e62:D8E62 JSR*  P8DE4+1    ; =-127 [Jump to subroutine relative indirect]
8e64:      DC    '+'        ; hex:ab dec:171(-85)
8e65:      DB    X'01'      ; =0x01 =1
8e66:      BNZ   D8E69      ; =+1 [Branch if not zero]
8e68:      RSR              ; [Return from subroutine]
*
8e69:D8E69 JSR   F8E7A      ; =+15 [Jump to subroutine relative]
8e6b:      A     /N9096(6),/N9090(6) ; =0x9096 =37014(-28522),=0x9090 =37008(-28528) [Add bignums, direct, direct]
8e72:      MVF   (6)/N9090,-Y ; =0x9090 =37008(-28528), [Move fixed-length, direct, indexed]
8e78:      JMP   D8E4B      ; =-47 [Jump relative]
*
* Function F8E7A
*
8e7a:F8E7A JSR   F8E8B      ; =+15 [Jump to subroutine relative]
8e7c:      MVF   (6)-Y,/N9096 ; =0x9096 =37014(-28522) [Move fixed-length, indexed, direct]
8e82:      INR   Y,6        ; [Increment Y by 6]
8e84:      MVF   (6)-Y,/N9090 ; =0x9090 =37008(-28528) [Move fixed-length, indexed, direct]
8e8a:      RSR              ; [Return from subroutine]
*
* Function F8E8B
*
8e8b:F8E8B JSR   F8EE4      ; =+87 [Jump to subroutine relative]
8e8d:D8E8D JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e90:      DC    '*'        ; hex:aa dec:170(-86)
8e91:      DB    X'01'      ; =0x01 =1
8e92:      BZ    D8EA5      ; =+17 [Branch if zero]
8e94:      JSR   F8ED3      ; =+61 [Jump to subroutine relative]
8e96:      M     /N9090(6),/N9096(6) ; =0x9090 =37008(-28528),=0x9096 =37014(-28522) [Multiply bignums, direct, direct]
8e9d:      MVF   (6)/N9096,-Y ; =0x9096 =37014(-28522), [Move fixed-length, direct, indexed]
8ea3:      JMP   D8E8D      ; =-24 [Jump relative]
8ea5:D8EA5 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ea8:      DC    '/'        ; hex:af dec:175(-81)
8ea9:      DB    X'01'      ; =0x01 =1
8eaa:      BZ    D8EBD      ; =+17 [Branch if zero]
8eac:      JSR   F8ED3      ; =+37 [Jump to subroutine relative]
8eae:      D     /N9096(6),/N9090(6) ; =0x9096 =37014(-28522),=0x9090 =37008(-28528) [Divide bignums, direct, direct]
8eb5:      MVF   (6)/N9090,-Y ; =0x9090 =37008(-28528), [Move fixed-length, direct, indexed]
8ebb:      JMP   D8E8D      ; =-48 [Jump relative]
8ebd:D8EBD JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ec0:      DC    'MOD'      ; hex:cdcfc4
8ec3:      DB    X'01'      ; =0x01 =1
8ec4:      BZ    D8EE3      ; =+29 [Branch if zero]
8ec6:      JSR   F8ED3      ; =+11 [Jump to subroutine relative]
8ec8:      XFR   Y,A        ; [Transfer Y to A]
8eca:      DRM   /N9096(6),/N9090(6) ; =0x9096 =37014(-28522),=0x9090 =37008(-28528) [Divide bignums with remainder, direct, direct]
8ed1:      JMP   D8E8D      ; =-70 [Jump relative]
*
* Function F8ED3
*
8ed3:F8ED3 JSR   F8EE4      ; =+15 [Jump to subroutine relative]
8ed5:      MVF   (6)-Y,/N9096 ; =0x9096 =37014(-28522) [Move fixed-length, indexed, direct]
8edb:      INR   Y,6        ; [Increment Y by 6]
8edd:      MVF   (6)-Y,/N9090 ; =0x9090 =37008(-28528) [Move fixed-length, indexed, direct]
8ee3:D8EE3 RSR              ; [Return from subroutine]
*
* Function F8EE4
*
8ee4:F8EE4 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8ee7:      DC    '('        ; hex:a8 dec:168(-88)
8ee8:      DB    X'01'      ; =0x01 =1
8ee9:      BZ    D8EF9      ; =+14 [Branch if zero]
8eeb:      JSR/  F8E36      ; =0x8e36 =36406(-29130) [Jump to subroutine direct]
8eee:      JSR*  F8EE4+1    ; =-11 [Jump to subroutine relative indirect]
8ef0:      DC    ')'        ; hex:a9 dec:169(-87)
8ef1:      DB    X'01'      ; =0x01 =1
8ef2:      BNZ   D8F04      ; =+16 [Branch if not zero]
8ef4:      JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8ef7:      DW    X'001D'    ; =0x001d =29
*
8ef9:D8EF9 JSR/  F8F05      ; =0x8f05 =36613(-28923) [Jump to subroutine direct]
8efc:      DCR   Y,6        ; [Decrement Y by 6]
8efe:      MVF   (6)/N908A,-Y ; =0x908a =37002(-28534), [Move fixed-length, direct, indexed]
8f04:D8F04 RSR              ; [Return from subroutine]
*
* Function F8F05
*
8f05:F8F05 FIL   (10)=' ',/S9080 ; =0x9080 =36992(-28544) [Fill with byte, literal=0xa0(160,-96), direct]
8f0b:      LDAB+ Z          ; [Load AL from address in Z]
8f0c:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f0f:      BP    D8F17      ; =+6 [Branch on plus]
8f11:D8F11 JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f14:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8f16:      DB    X'09'      ; =0x09 =9
*
8f17:D8F17 LDB=  S9080      ; =0x9080 =36992(-28544) [Load B with immediate]
8f1a:D8F1A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8f1c:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8f1e:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f21:      BM    D8F29      ; =+6 [Branch on minus]
8f23:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8f25:      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
8f27:      JMP   D8F1A      ; =-15 [Jump relative]
8f29:D8F29 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f2b:      SUB=  S9080,A    ; =0x9080 =36992(-28544) [36992 - A -> A]
8f2f:      IVA              ; [Invert A]
8f30:      INA              ; [Increment A]
8f31:      STK   Y,4        ; [Push Y Z to the stack]
8f33:      CTB   /S9080(10),/N908A(6) ; =0x9080 =36992(-28544),=0x908a =37002(-28534) [Convert to bignum, direct, direct]
8f3a:      SST   W909C      ; =0x909c =37020(-28516) [Store status direct]
8f3d:      POP   Y,4        ; [Pop Z Y from the stack]
8f3f:      LST   W909C      ; =0x909c =37020(-28516) [Load status direct]
8f42:      BF    D8F11      ; =-51 [Branch on fault]
8f44:      DCR   Z          ; [Decrement Z by 1]
8f46:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8f49:      RSR              ; [Return from subroutine]
*
8f4a:J8F4A JSR   F8F4F      ; =+3 [Jump to subroutine relative]
8f4c:      JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8F4F
*
8f4f:F8F4F STX-  S-         ; [Store X indexed, pre-decremented, direct]
8f51:      CLR   X          ; [Clear X]
8f53:D8F53 LDAB+ Z          ; [Load AL from address in Z]
8f54:      BNZ   D8F59      ; =+3 [Branch if not zero]
8f56:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8f58:      RSR              ; [Return from subroutine]
*
8f59:D8F59 JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8f5c:      BM    D8F81      ; =+35 [Branch on minus]
8f5e:      XFR   Z,A        ; [Transfer Z to A]
8f60:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f62:      JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8f65:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8f67:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f6a:      DC    '='        ; hex:bd dec:189(-67)
8f6b:      DB    X'01'      ; =0x01 =1
8f6c:      BNZ   D8F7D      ; =+15 [Branch if not zero]
8f6e:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8f71:      DC    'EQ'       ; hex:c5d1 dec:50641(-47)
8f73:      DB    X'01'      ; =0x01 =1
8f74:      BNZ   D8F7D      ; =+7 [Branch if not zero]
8f76:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f78:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f7a:      XAZ              ; [Transfer A to Z]
8f7b:      JMP   D8F81      ; =+4 [Jump relative]
8f7d:D8F7D LDX+  S+         ; [Load X indexed, direct, post-incremented]
8f7f:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8f81:D8F81 XFR   X,A        ; [Transfer X to A]
8f83:      INX              ; [Increment X]
8f84:      CLRB  AU         ; [Clear AU]
8f86:      XABB             ; [Transfer AL to BL]
8f87:      BM    D8F8F      ; =+6 [Branch on minus]
8f89:      LDBB+ Y,22       ; [Load BL indexed, displaced, direct]
8f8c:      SABB             ; [AL - BL -> BL]
8f8d:      BM    D8F94      ; =+5 [Branch on minus]
8f8f:D8F8F JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8f92:      DW    X'001C'    ; =0x001c =28
*
8f94:D8F94 SLA              ; [Left shift A]
8f95:      XAB              ; [Transfer A to B]
8f96:      SLA              ; [Left shift A]
8f97:      SLA              ; [Left shift A]
8f98:      AAB              ; [A + B -> B]
8f99:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
8f9c:      AAB              ; [A + B -> B]
8f9d:      STB   W8FB8      ; =+25 [Store B relative]
8f9f:      STB   W8FD9      ; =+56 [Store B relative]
8fa1:      LDAB+ Z          ; [Load AL from address in Z]
8fa2:      BZ    D8FBA      ; =+22 [Branch if zero]
8fa4:      LDBB= X'A2'      ; =162(-94) ='"' [Load BL with immediate]
8fa6:      SABB             ; [AL - BL -> BL]
8fa7:      BZ    D8FC1      ; =+24 [Branch if zero]
8fa9:      LDBB= X'A7'      ; =167(-89) =' [Load BL with immediate]
8fab:      SABB             ; [AL - BL -> BL]
8fac:      BZ    D8FC1      ; =+19 [Branch if zero]
8fae:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fb1:      DC    ','        ; hex:ac dec:172(-84)
8fb2:      DB    X'01'      ; =0x01 =1
8fb3:      BNZ   D8FBF      ; =+10 [Branch if not zero]
8fb5:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8fb8:W8FB8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8fba:D8FBA JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8fbd:      DC    ','        ; hex:ac dec:172(-84)
8fbe:      DB    X'01'      ; =0x01 =1
*
8fbf:D8FBF JMP   D8F53      ; =-110 [Jump relative]
8fc1:D8FC1 INR   Z          ; [Increment Z by 1]
8fc3:      XFR   Z,B        ; [Transfer Z to B]
8fc5:      STB   W8FDB      ; =+20 [Store B relative]
8fc7:D8FC7 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8fc9:      BNZ   D8FE2      ; =+23 [Branch if not zero]
8fcb:      DCR   Z          ; [Decrement Z by 1]
8fcd:      CLA              ; [Clear A]
8fce:D8FCE LDB   W8FDB      ; =+11 [Load B relative]
8fd0:      AAB              ; [A + B -> B]
8fd1:      SUB   Z,B        ; [Z - B -> B]
8fd3:      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8fd6:      JSR/  F8D0A      ; =0x8d0a =36106(-29430) [Jump to subroutine direct]
8fd9:W8FD9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8fdb:W8FDB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8fdd:      JSR/  F827E      ; =0x827e =33406(-32130) [Jump to subroutine direct]
8fe0:      JMP   D8FBA      ; =-40 [Jump relative]
8fe2:D8FE2 SABB             ; [AL - BL -> BL]
8fe3:      BNZ   D8FC7      ; =-30 [Branch if not zero]
8fe5:      CLA              ; [Clear A]
8fe6:      INA              ; [Increment A]
8fe7:      JMP   D8FCE      ; =-27 [Jump relative]
*
8fe9:      DB    0,150      ; =0x00,0x0096
907f:W907F DB    X'00'      ; =0x00 =0 =NUL
9080:S9080 DB    0,10       ; =0x00,0x000a
908a:N908A DB    0,6        ; =0x00,0x0006
9090:N9090 DB    0,6        ; =0x00,0x0006
9096:N9096 DB    0,6        ; =0x00,0x0006
909c:W909C                 
909d:ENDPT
