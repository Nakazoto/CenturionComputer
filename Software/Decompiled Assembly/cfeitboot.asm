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
fc00:      DB    0,24       ; =0x00,0x0018
fc18:      DW    X'0404'    ; =0x0404 =1028
fc1a:      DW    X'0404'    ; =0x0404 =1028
fc1c:      DW    X'1414'    ; =0x1414 =5140
fc1e:      DW    X'1414'    ; =0x1414 =5140
fc20:      DB    0,8        ; =0x00,0x0008
fc28:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc2a:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc2c:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc2e:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc30:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc32:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc34:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc36:      DW    X'8080'    ; =0x8080 =32896(-32640)
fc38:      DC    '""""""""' ; hex:a2a2a2a2a2a2a2a2
fc40:      DB    X'00'      ; =0x00 =0 =NUL
fc41:      DB    0,21       ; =0x00,0x0015
fc56:      DW    X'0101'    ; =0x0101 =257
fc58:      DW    X'0101'    ; =0x0101 =257
fc5a:      DW    X'0101'    ; =0x0101 =257
fc5c:      DW    X'0101'    ; =0x0101 =257
fc5e:      DW    X'0101'    ; =0x0101 =257
fc60:      DB    0,25       ; =0x00,0x0019
fc79:      DW    X'4143'    ; =0x4143 =16707
fc7b:      DW    X'4373'    ; =0x4373 =17267
fc7d:      DW    X'7373'    ; =0x7373 =29555
fc7f:      DW    X'7300'    ; =0x7300 =29440
fc81:      DB    0,18       ; =0x00,0x0012
fc93:      DW    X'4040'    ; =0x4040 =16448
fc95:      DW    X'4040'    ; =0x4040 =16448
fc97:      DW    X'4041'    ; =0x4041 =16449
fc99:      DW    X'4141'    ; =0x4141 =16705
fc9b:      DW    X'4949'    ; =0x4949 =18761
fc9d:      DW    X'4949'    ; =0x4949 =18761
fc9f:      DW    X'4900'    ; =0x4900 =18688
fca1:      DB    0,7        ; =0x00,0x0007
fca8:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcaa:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcac:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcae:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcb0:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcb2:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcb4:      DW    X'8080'    ; =0x8080 =32896(-32640)
fcb6:      DW    X'8084'    ; =0x8084 =32900(-32636)
fcb8:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fcba:      DW    X'8494'    ; =0x8494 =33940(-31596)
fcbc:      DW    X'9494'    ; =0x9494 =38036(-27500)
fcbe:      DW    X'9494'    ; =0x9494 =38036(-27500)
fcc0:      DB    0,23       ; =0x00,0x0017
fcd7:      DW    X'0404'    ; =0x0404 =1028
fcd9:      DW    X'0606'    ; =0x0606 =1542
fcdb:      DW    X'0606'    ; =0x0606 =1542
fcdd:      DW    X'0606'    ; =0x0606 =1542
fcdf:      DW    X'0600'    ; =0x0600 =1536
fce1:      DB    0,19       ; =0x00,0x0013
fcf4:      DW    X'0101'    ; =0x0101 =257
fcf6:      DW    X'0101'    ; =0x0101 =257
fcf8:      DW    X'0101'    ; =0x0101 =257
fcfa:      DW    X'0909'    ; =0x0909 =2313
fcfc:      DW    X'0909'    ; =0x0909 =2313
fcfe:      DW    X'0909'    ; =0x0909 =2313
*
* Function ENTRY
*
fd00:ENTRY LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
fd03:      XAS              ; [Transfer A to S]
fd04:      LDAB= X'C5'      ; =197(-59) ='E' [Load AL with immediate]
fd06:      STAB* PFD81+1    ; =+122 [Store AL relative indirect]
fd08:      LDAB= X'01'      ; =1 [Load AL with immediate]
fd0a:      BS4   DFD0D      ; =+1 [Branch if Sense Switch 4 set]
fd0c:      DCAB             ; [Decrement AL]
fd0d:DFD0D JMP   DFD7F      ; =+112 [Jump relative]
fd0f:      JSR   PFD81      ; =+112 [Jump to subroutine relative]
fd11:      DW    X'8CFF'    ; =0x8cff =36095(-29441)
fd13:      DW    X'FFFF'    ; =0xffff =65535(-1)
fd15:      DC    'D='       ; hex:c4bd dec:50365(-67)
fd17:      DB    X'00'      ; =0x00 =0 =NUL
fd18:      JSR   DFD92      ; =+120 [Jump to subroutine relative]
fd1a:      LDBB= X'C8'      ; =200(-56) ='H' [Load BL with immediate]
fd1c:      SABB             ; [AL - BL -> BL]
fd1d:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
fd1f:      BZ    DFD26      ; =+5 [Branch if zero]
fd21:      LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
fd23:      SABB             ; [AL - BL -> BL]
fd24:      BNZ   ENTRY      ; =-38 [Branch if not zero]
fd26:DFD26 JSR   DFD92      ; =+106 [Jump to subroutine relative]
fd28:      LDBB= X'50'      ; =80 [Load BL with immediate]
fd2a:      ADDB  BL,AL      ; [BL + AL -> AL]
fd2c:      BM    ENTRY      ; =-46 [Branch on minus]
fd2e:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
fd30:      BZ    DFD7F      ; =+77 [Branch if zero]
fd32:      LDBB= X'03'      ; =3 [Load BL with immediate]
fd34:      SABB             ; [AL - BL -> BL]
fd35:      BGZ   ENTRY      ; =-55 [Branch if greater than zero]
fd37:      LDB=  X'0F00'    ; =0x0f00 =3840 [Load B with immediate]
fd3a:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd3c:      CLR   B          ; [Clear B]
fd3e:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd40:      LDB=  X'8288'    ; =0x8288 =33416(-32120) [Load B with immediate]
fd43:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd45:      LDB=  X'8100'    ; =0x8100 =33024(-32512) [Load B with immediate]
fd48:      SL               ; [Set link]
fd49:DFD49 RLRB  BL         ; [Left rotate BL by 1]
fd4b:      DCAB             ; [Decrement AL]
fd4c:      BP    DFD49      ; =-5 [Branch on plus]
fd4e:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd50:      DMA   SDV,1      ; [Set DMA mode]
fd52:      DMA   EAB        ; [Enable DMA]
fd54:      DMA   SAD,S      ; [Store S register to DMA address register]
fd56:      LDA=  X'FFF7'    ; =0xfff7 =65527(-9) [Load A with immediate]
fd59:      DMA   SCT,A      ; [Store A register to DMA count register]
fd5b:      JSR   FFDA9      ; =+76 [Jump to subroutine relative]
fd5d:      DB    X'43'      ; =0x43 =67
fd5e:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fd61:      DMA   SAD,A      ; [Store A register to DMA address register]
fd63:      LDA=  X'F0FF'    ; =0xf0ff =61695(-3841) [Load A with immediate]
fd66:      DMA   SCT,A      ; [Store A register to DMA count register]
fd68:      JSR   FFDA9      ; =+63 [Jump to subroutine relative]
fd6a:      DB    X'45'      ; =0x45 =69
fd6b:      BNZ   DFD70      ; =+3 [Branch if not zero]
fd6d:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
fd70:DFD70 JSR   PFD81      ; =+15 [Jump to subroutine relative]
fd72:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
fd74:      DC    'ERROR'    ; hex:c5d2d2cfd2
fd79:      DB    X'00'      ; =0x00 =0 =NUL
*
fd7a:DFD7A HLT              ; [Halt]
fd7b:      JMP   DFD7A      ; =-3 [Jump relative]
fd7d:DFD7D JMP   ENTRY      ; =-127 [Jump relative]
fd7f:DFD7F JMP   DFDB7      ; =+54 [Jump relative]
fd81:PFD81 LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
fd84:      SRAB             ; [Right shift AL]
fd85:      SRAB             ; [Right shift AL]
fd86:      BNL   PFD81      ; =-7 [Branch on no link]
fd88:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fd8a:      BNZ   PFD8D      ; =+1 [Branch if not zero]
fd8c:      RSR              ; [Return from subroutine]
*
fd8d:PFD8D STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
fd90:      JMP   PFD81      ; =-17 [Jump relative]
fd92:DFD92 LDAB* PFD81+1    ; =-18 [Load AL relative indirect]
fd94:      SRAB             ; [Right shift AL]
fd95:      BNL   DFD92      ; =-5 [Branch on no link]
fd97:      LDAB* PFD8D+1    ; =-11 [Load AL relative indirect]
fd99:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
fd9b:      ORIB  BL,AL      ; [BL | AL -> AL]
fd9d:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
fd9f:      SABB             ; [AL - BL -> BL]
fda0:      BM    DFDA6      ; =+4 [Branch on minus]
fda2:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
fda4:      ANDB  BL,AL      ; [BL & AL -> AL]
fda6:DFDA6 STAB* PFD8D+1    ; =-26 [Store AL relative indirect]
fda8:      RSR              ; [Return from subroutine]
*
* Function FFDA9
*
fda9:FFDA9 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fdab:PFDAB STAB/ X'F800'    ; =0xf800 =63488(-2048) ='x',NUL [Store AL direct]
fdae:DFDAE LDAB/ X'F801'    ; =0xf801 =63489(-2047) [Load AL direct]
fdb1:      DCAB             ; [Decrement AL]
fdb2:      BNZ   DFDAE      ; =-6 [Branch if not zero]
fdb4:      LDAB* PFDAB+1    ; =-10 [Load AL relative indirect]
fdb6:      RSR              ; [Return from subroutine]
*
fdb7:DFDB7 LDBB= X'07'      ; =7 [Load BL with immediate]
fdb9:      SABB             ; [AL - BL -> BL]
fdba:      BGZ   DFD7D      ; =-63 [Branch if greater than zero]
fdbc:      STAB/ X'F140'    ; =0xf140 =61760(-3776) [Store AL direct]
fdbf:      LDA*  PFDED+1    ; =+45 [Load A relative indirect]
fdc1:      LDB=  X'0010'    ; =0x0010 =16 [Load B with immediate]
fdc4:      NAB              ; [A & B -> B]
fdc5:      BZ    DFD70      ; =-87 [Branch if zero]
fdc7:      CLA              ; [Clear A]
fdc8:      STA/  X'F141'    ; =0xf141 =61761(-3775) [Store A direct]
fdcb:      JSR   FFDF5      ; =+40 [Jump to subroutine relative]
fdcd:      DB    X'03'      ; =0x03 =3
*
fdce:DFDCE LDA*  PFDED+1    ; =+30 [Load A relative indirect]
fdd0:      LDB=  X'0400'    ; =0x0400 =1024 [Load B with immediate]
fdd3:      NAB              ; [A & B -> B]
fdd4:DFDD4 BNZ   DFD70      ; =-102 [Branch if not zero]
fdd6:      LDB=  X'0020'    ; =0x0020 =32 [Load B with immediate]
fdd9:      NAB              ; [A & B -> B]
fdda:      BZ    DFDCE      ; =-14 [Branch if zero]
fddc:      DMA   SDV,0      ; [Set DMA mode]
fdde:      DMA   EAB        ; [Enable DMA]
fde0:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fde3:      DMA   SAD,A      ; [Store A register to DMA address register]
fde5:      LDA=  X'EA1F'    ; =0xea1f =59935(-5601) [Load A with immediate]
fde8:      DMA   SCT,A      ; [Store A register to DMA count register]
fdea:      JSR   FFDF5      ; =+9 [Jump to subroutine relative]
fdec:      DB    X'00'      ; =0x00 =0 =NUL
fded:PFDED LDAB/ X'F144'    ; =0xf144 =61764(-3772) [Load AL direct]
fdf0:      BNZ   DFDD4      ; =-30 [Branch if not zero]
fdf2:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
*
* Function FFDF5
*
fdf5:FFDF5 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fdf7:      STAB/ X'F148'    ; =0xf148 =61768(-3768) [Store AL direct]
fdfa:DFDFA LDAB* PFDED+1    ; =-14 [Load AL relative indirect]
fdfc:      SRAB             ; [Right shift AL]
fdfd:      BL    DFDFA      ; =-5 [Branch on link]
fdff:      RSR              ; [Return from subroutine]
*
fe00:ENDPT
