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
825f:F825F DS    41         ; =0x0029 [Uninitialized memory]
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
832d:F832D DS    116        ; =0x0074 [Uninitialized memory]
*
*
* Function F83A1
*
83a1:F83A1 DS    291        ; =0x0123 [Uninitialized memory]
*
*
* Function F84C4
*
84c4:F84C4 DS    14         ; =0x000e [Uninitialized memory]
*
*
* Function F84D2
*
84d2:F84D2 DS    364        ; =0x016c [Uninitialized memory]
863e:W863E DS    2          ; =0x0002 [Uninitialized memory]
8640:W8640 DS    110        ; =0x006e [Uninitialized memory]
86ae:W86AE DS    1589       ; =0x0635 [Uninitialized memory]
*
*
* Function F8CE3
*
8ce3:F8CE3 DS    76         ; =0x004c [Uninitialized memory]
*
* Function ENTRY
*
8d2f:ENTRY XFR/  W80B1,Y    ; =0x80b1 =32945(-32591) [Transfer direct to Y]
8d33:      LDA=  W8E14      ; =0x8e14 =36372(-29164) [Load A with immediate]
8d36:      STA   W8D54+1    ; =+29 [Store A relative]
8d38:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d3b:      DC    'TO'       ; hex:d4cf dec:54479(-49)
8d3d:      DB    X'01'      ; =0x01 =1
8d3e:      BZ    D8D4C      ; =+12 [Branch if zero]
8d40:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8d43:      DW    W8E00      ; =0x8e00 =36352(-29184)
8d45:      LDA=  W8E28      ; =0x8e28 =36392(-29144) [Load A with immediate]
8d48:      STA   W8D54+1    ; =+11 [Store A relative]
8d4a:      JMP   D8D51      ; =+5 [Jump relative]
8d4c:D8D4C JSR/  F829E      ; =0x829e =33438(-32098) [Jump to subroutine direct]
8d4f:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8d51:D8D51 LDAB+ Z          ; [Load AL from address in Z]
8d52:      BNZ   D8D57      ; =+3 [Branch if not zero]
8d54:W8D54 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
8d57:D8D57 JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8d5a:      DC    'IF'       ; hex:c9c6 dec:51654(-58)
8d5c:      DB    X'01'      ; =0x01 =1
8d5d:      BNZ   D8D64      ; =+5 [Branch if not zero]
8d5f:D8D5F JSR/  F82EA      ; =0x82ea =33514(-32022) [Jump to subroutine direct]
8d62:      DW    X'001E'    ; =0x001e =30
*
8d64:D8D64 JSR/  F8E67      ; =0x8e67 =36455(-29081) [Jump to subroutine direct]
8d67:      DW    S8DDC      ; =0x8ddc =36316(-29220) =CR,'\'
8d69:      JSR*  D8D57+1    ; =-19 [Jump to subroutine relative indirect]
8d6b:      DC    '<>'       ; hex:bcbe dec:48318(-66)
8d6d:      DB    X'06'      ; =0x06 =6
8d6e:      BNZ   D8DA5      ; =+53 [Branch if not zero]
8d70:      JSR*  D8D57+1    ; =-26 [Jump to subroutine relative indirect]
8d72:      DC    '>='       ; hex:bebd dec:48829(-67)
8d74:      DB    X'05'      ; =0x05 =5
8d75:      BNZ   D8DA5      ; =+46 [Branch if not zero]
8d77:      JSR*  D8D57+1    ; =-33 [Jump to subroutine relative indirect]
8d79:      DC    '<='       ; hex:bcbd dec:48317(-67)
8d7b:      DB    X'03'      ; =0x03 =3
8d7c:      BNZ   D8DA5      ; =+39 [Branch if not zero]
8d7e:      JSR*  D8D57+1    ; =-40 [Jump to subroutine relative indirect]
8d80:      DC    '>'        ; hex:be dec:190(-66)
8d81:      DB    X'04'      ; =0x04 =4
8d82:      BNZ   D8DA5      ; =+33 [Branch if not zero]
8d84:      JSR*  D8D57+1    ; =-46 [Jump to subroutine relative indirect]
8d86:      DC    '<'        ; hex:bc dec:188(-68)
8d87:      DB    X'02'      ; =0x02 =2
8d88:      BNZ   D8DA5      ; =+27 [Branch if not zero]
8d8a:      JSR*  D8D57+1    ; =-52 [Jump to subroutine relative indirect]
8d8c:      DC    '='        ; hex:bd dec:189(-67)
8d8d:      DB    X'01'      ; =0x01 =1
8d8e:      BNZ   D8DA5      ; =+21 [Branch if not zero]
8d90:      JSR/  F8288      ; =0x8288 =33416(-32120) [Jump to subroutine direct]
8d93:      DCR   B,2        ; [Decrement B by 2]
8d95:      BNZ   D8D5F      ; =-56 [Branch if not zero]
8d97:      LDX=  W8ECE      ; =0x8ece =36558(-28978) [Load X with immediate]
8d9a:      LDA+  A          ; [Load A from address in A]
8d9b:D8D9B LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8d9d:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8d9f:      BZ    D8D5F      ; =-66 [Branch if zero]
8da1:      SAB              ; [A - B -> B]
8da2:      BNZ   D8D9B      ; =-9 [Branch if not zero]
8da4:      LDAB+ X          ; [Load AL from address in X]
8da5:D8DA5 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8da7:      JSR/  F8E67      ; =0x8e67 =36455(-29081) [Jump to subroutine direct]
8daa:      DW    S8DEE      ; =0x8dee =36334(-29202) =CR,'n'
8dac:      LDAB  B8DE7      ; =+57 [Load AL relative]
8dae:      LDBB  B8DF9      ; =+73 [Load BL relative]
8db0:      AABB             ; [AL + BL -> BL]
8db1:      BNZ   D8DBC      ; =+9 [Branch if not zero]
8db3:      C     /N8DFA(6),/N8DE8(6) ; =0x8dfa =36346(-29190) =CR,'z',=0x8de8 =36328(-29208) =CR,'h' [Compare bignums, direct, direct]
8dba:      JMP   D8DC3      ; =+7 [Jump relative]
8dbc:D8DBC CPF   (10)/S8DEE,/S8DDC ; =0x8dee =36334(-29202) =CR,'n',=0x8ddc =36316(-29220) =CR,'\' [Compare fixed-length, direct, direct]
8dc3:D8DC3 BM    D8DCB      ; =+6 [Branch on minus]
8dc5:      BGZ   D8DCF      ; =+8 [Branch if greater than zero]
8dc7:      LDAB= X'01'      ; =1 [Load AL with immediate]
8dc9:      JMP   D8DD1      ; =+6 [Jump relative]
8dcb:D8DCB LDAB= X'02'      ; =2 [Load AL with immediate]
8dcd:      JMP   D8DD1      ; =+2 [Jump relative]
8dcf:D8DCF LDAB= X'04'      ; =4 [Load AL with immediate]
8dd1:D8DD1 LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
8dd3:      NABB             ; [AL & BL -> BL]
8dd4:      BZ    D8DD9      ; =+3 [Branch if zero]
8dd6:      JMP$  W8D54+1    ; =0x8d55 =36181(-29355) [Jump indirect]
8dd9:D8DD9 JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
8ddc:S8DDC DC    '-          '
8de7:B8DE7 DB    X'01'      ; =0x01 =1
8de8:N8DE8 DB    0,6        ; =0x00,0x0006
8dee:S8DEE DC    '-          '
8df9:B8DF9 DB    X'01'      ; =0x01 =1
8dfa:N8DFA DB    0,6        ; =0x00,0x0006
8e00:W8E00 DS    10         ; =0x000a [Uninitialized memory]
8e0a:W8E0A DS    10         ; =0x000a [Uninitialized memory]
8e14:W8E14 LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8e17:      BZ    D8E1D      ; =+4 [Branch if zero]
8e19:      JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8e1c:      DB    X'04'      ; =0x04 =4
*
8e1d:D8E1D LDX+  S+         ; [Load X indexed, direct, post-incremented]
8e1f:D8E1F DCX              ; [Decrement X]
8e20:      BM    D8DD9      ; =-73 [Branch on minus]
8e22:      JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8e25:      DB    X'01'      ; =0x01 =1
8e26:      JMP   D8E1F      ; =-9 [Jump relative]
8e28:W8E28 LDA/  W8236      ; =0x8236 =33334(-32202) [Load A direct]
8e2b:      BZ    D8E31      ; =+4 [Branch if zero]
8e2d:      JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8e30:      DB    X'04'      ; =0x04 =4
*
8e31:D8E31 JSR/  F84D2      ; =0x84d2 =34002(-31534) =EOT,'R' [Jump to subroutine direct]
8e34:      DB    X'01'      ; =0x01 =1
8e35:      JSR/  F8CE3      ; =0x8ce3 =36067(-29469) =FF,'c' [Jump to subroutine direct]
8e38:      DW    W86AE      ; =0x86ae =34478(-31058)
8e3a:      JSR/  F83A1      ; =0x83a1 =33697(-31839) [Jump to subroutine direct]
8e3d:      XFR=  W8640,Z    ; =0x8640 =34368(-31168) [Transfer immediate to Z]
8e41:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e44:      DC    '='        ; hex:bd dec:189(-67)
8e45:      DB    X'01'      ; =0x01 =1
8e46:      BZ    D8E31      ; =-23 [Branch if zero]
8e48:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8e4b:      DW    W8E0A      ; =0x8e0a =36362(-29174)
8e4d:      CPF   (6)/W8E00,/W8E0A ; =0x8e00 =36352(-29184),=0x8e0a =36362(-29174) [Compare fixed-length, direct, direct]
8e54:      BNZ   D8E31      ; =-37 [Branch if not zero]
8e56:      LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
8e59:      LDBB= X'01'      ; =1 [Load BL with immediate]
8e5b:      NABB             ; [AL & BL -> BL]
8e5c:      BZ    D8E64      ; =+6 [Branch if zero]
8e5e:      JSR/  F84C4      ; =0x84c4 =33988(-31548) =EOT,'D' [Jump to subroutine direct]
8e61:      DW    W863E      ; =0x863e =34366(-31170)
8e63:      DB    X'02'      ; =0x02 =2
*
8e64:D8E64 JMP/  J8148      ; =0x8148 =33096(-32440) [Jump direct]
*
* Function F8E67
*
8e67:F8E67 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8e69:      STK   X,4        ; [Push X Y to the stack]
8e6b:      XAX              ; [Transfer A to X]
8e6c:      FIL   (9)=' ',-X,1 ; [Fill with byte, literal=0xa0(160,-96), displaced indexed]
8e72:      LDAB= X'AD'      ; =173(-83) ='-' [Load AL with immediate]
8e74:      STAB+ X          ; [Store AL to address in X]
8e75:      XFR   X,Y        ; [Transfer X to Y]
8e77:      ADD=  X'000C',Y  ; =0x000c =12 [12 + Y -> Y]
8e7b:      ZAD   =0,-Y(6)   ; [Zero-add bignum, literal=0x00, indexed]
8e80:      LDAB= X'01'      ; =1 [Load AL with immediate]
8e82:      STAB+ X,11       ; [Store AL indexed, displaced, direct]
8e85:      JSR/  F82C4      ; =0x82c4 =33476(-32060) [Jump to subroutine direct]
8e88:      DC    '-'        ; hex:ad dec:173(-83)
8e89:      DB    X'01'      ; =0x01 =1
8e8a:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8e8c:      BZ    D8E8F      ; =+1 [Branch if zero]
8e8e:      INX              ; [Increment X]
8e8f:D8E8F STX   W8E94      ; =+3 [Store X relative]
8e91:      JSR/  F832D      ; =0x832d =33581(-31955) [Jump to subroutine direct]
8e94:W8E94 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8e96:      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
8e99:D8E99 XFRB  BU,BL      ; [Transfer BU to BL]
8e9b:      LDAB+ X          ; [Load AL from address in X]
8e9c:      SABB             ; [AL - BL -> BL]
8e9d:      BZ    D8EBE      ; =+31 [Branch if zero]
8e9f:      DCAB             ; [Decrement AL]
8ea0:      BZ    D8EBE      ; =+28 [Branch if zero]
8ea2:      INAB             ; [Increment AL]
8ea3:      JSR/  F825F      ; =0x825f =33375(-32161) [Jump to subroutine direct]
8ea6:      BM    D8ECA      ; =+34 [Branch on minus]
8ea8:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8eaa:      AND=  X'000F',A  ; =0x000f =15 [15 & A -> A]
8eae:      STAB  B8EBD      ; =+13 [Store AL relative]
8eb0:      M     =10,-Y(6)  ; [Multiply bignums, literal=0x0a, indexed]
8eb5:      A     /B8EBD(1),-Y(6) ; =0x8ebd =36541(-28995), [Add bignums, direct, indexed]
8ebb:      JMP   D8E99      ; =-36 [Jump relative]
*
8ebd:B8EBD DB    X'00'      ; =0x00 =0 =NUL
*
8ebe:D8EBE CLA              ; [Clear A]
8ebf:      STAB+ Y,-1       ; [Store AL indexed, displaced, direct]
8ec2:      LDAB+ S          ; [Load AL from address in S]
8ec3:      BZ    D8ECA      ; =+5 [Branch if zero]
8ec5:      M     =-1,-Y(6)  ; [Multiply bignums, literal=0xff, indexed]
8eca:D8ECA INR   S          ; [Increment S by 1]
8ecc:      POP   X,4        ; [Pop Y X from the stack]
8ece:W8ECE RSR              ; [Return from subroutine]
*
8ecf:      DC    'EQ'       ; hex:c5d1 dec:50641(-47)
8ed1:      DB    X'01'      ; =0x01 =1
8ed2:      DC    'NE'       ; hex:cec5 dec:52933(-59)
8ed4:      DB    X'06'      ; =0x06 =6
8ed5:      DC    'LT'       ; hex:ccd4 dec:52436(-44)
8ed7:      DB    X'02'      ; =0x02 =2
8ed8:      DC    'GT'       ; hex:c7d4 dec:51156(-44)
8eda:      DB    X'04'      ; =0x04 =4
8edb:      DC    'LE'       ; hex:ccc5 dec:52421(-59)
8edd:      DB    X'03'      ; =0x03 =3
8ede:      DC    'GE'       ; hex:c7c5 dec:51141(-59)
8ee0:      DW    X'0500'    ; =0x0500 =1280
8ee2:      DB    X'00'      ; =0x00 =0 =NUL
8ee3:ENDPT
