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
fc00:      DC    '""""""""""""""""""""""""""""""""'
fc20:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc22:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc24:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc26:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc28:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc2a:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc2c:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc2e:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc30:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc32:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc34:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc36:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc38:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc3a:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc3c:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc3e:      DW    X'FFFF'    ; =0xffff =65535(-1)
fc40:      DC    'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
fc60:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc62:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc64:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc66:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc68:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc6a:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc6c:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc6e:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc70:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc72:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc74:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc76:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc78:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc7a:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc7c:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc7e:      DW    X'8484'    ; =0x8484 =33924(-31612) =EOT,EOT
fc80:      DC    '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
fca0:      DB    X'00'      ; =0x00 =0 =NUL
fca1:      DB    0,31       ; =0x00,0x001f
fcc0:      DC    '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
fcfc:      DC    '@@@@'     ; hex:c0c0c0c0
*
* Function ENTRY
*
fd00:ENTRY BS1   DFD04      ; =+2 [Branch if Sense Switch 1 set]
fd02:      JMP   DFD07      ; =+3 [Jump relative]
fd04:DFD04 JMP/  X'8001'    ; =0x8001 =32769(-32767) [Jump direct]
fd07:DFD07 LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
fd0a:      XAS              ; [Transfer A to S]
fd0b:      LDAB= X'C5'      ; =197(-59) ='E' [Load AL with immediate]
fd0d:      STAB* PFD69+1    ; =+91 [Store AL relative indirect]
fd0f:      LDAB= X'01'      ; =1 [Load AL with immediate]
fd11:      BS4   DFD14      ; =+1 [Branch if Sense Switch 4 set]
fd13:      DCAB             ; [Decrement AL]
fd14:DFD14 JMP   DFD67      ; =+81 [Jump relative]
fd16:      LDBB= X'03'      ; =3 [Load BL with immediate]
fd18:      SABB             ; [AL - BL -> BL]
fd19:      BGZ   DFD07      ; =-20 [Branch if greater than zero]
fd1b:      LDB=  X'0F00'    ; =0x0f00 =3840 [Load B with immediate]
fd1e:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd20:      CLR   B          ; [Clear B]
fd22:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd24:      LDBB= X'88'      ; =136(-120) [Load BL with immediate]
fd26:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
fd28:      LDB=  X'8300'    ; =0x8300 =33536(-32000) [Load B with immediate]
fd2b:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd2d:      LDB=  X'8100'    ; =0x8100 =33024(-32512) [Load B with immediate]
fd30:      SL               ; [Set link]
fd31:DFD31 RLRB  BL         ; [Left rotate BL by 1]
fd33:      DCAB             ; [Decrement AL]
fd34:      BP    DFD31      ; =-5 [Branch on plus]
fd36:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fd38:      DMA   SDV,1      ; [Set DMA mode]
fd3a:      DMA   EAB        ; [Enable DMA]
fd3c:      DMA   SAD,S      ; [Store S register to DMA address register]
fd3e:      LDA=  X'FFF6'    ; =0xfff6 =65526(-10) [Load A with immediate]
fd41:      DMA   SCT,A      ; [Store A register to DMA count register]
fd43:      JSR   FFD91      ; =+76 [Jump to subroutine relative]
fd45:      DB    X'43'      ; =0x43 =67
fd46:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fd49:      DMA   SAD,A      ; [Store A register to DMA address register]
fd4b:      LDA=  X'F0FF'    ; =0xf0ff =61695(-3841) [Load A with immediate]
fd4e:      DMA   SCT,A      ; [Store A register to DMA count register]
fd50:      JSR   FFD91      ; =+63 [Jump to subroutine relative]
fd52:      DW    X'4515'    ; =0x4515 =17685
fd54:      DW    X'0371'    ; =0x0371 =881
fd56:      DW    X'0103'    ; =0x0103 =259
*
fd58:DFD58 JSR   PFD69      ; =+15 [Jump to subroutine relative]
fd5a:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
fd5c:      DC    'ERROR'    ; hex:c5d2d2cfd2
fd61:      DB    X'00'      ; =0x00 =0 =NUL
*
fd62:DFD62 HLT              ; [Halt]
fd63:      JMP   DFD62      ; =-3 [Jump relative]
fd65:DFD65 JMP   DFD07      ; =-96 [Jump relative]
fd67:DFD67 JMP   DFD9F      ; =+54 [Jump relative]
fd69:PFD69 LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
fd6c:      SRAB             ; [Right shift AL]
fd6d:      SRAB             ; [Right shift AL]
fd6e:      BNL   PFD69      ; =-7 [Branch on no link]
fd70:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fd72:      BNZ   DFD75      ; =+1 [Branch if not zero]
fd74:      RSR              ; [Return from subroutine]
*
fd75:DFD75 STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
fd78:      JMP   PFD69      ; =-17 [Jump relative]
fd7a:DFD7A LDAB* PFD69+1    ; =-18 [Load AL relative indirect]
fd7c:      SRAB             ; [Right shift AL]
fd7d:      BNL   DFD7A      ; =-5 [Branch on no link]
fd7f:      LDAB* DFD75+1    ; =-11 [Load AL relative indirect]
fd81:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
fd83:      ORIB  BL,AL      ; [BL | AL -> AL]
fd85:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
fd87:      SABB             ; [AL - BL -> BL]
fd88:      BM    DFD8E      ; =+4 [Branch on minus]
fd8a:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
fd8c:      ANDB  BL,AL      ; [BL & AL -> AL]
fd8e:DFD8E STAB* DFD75+1    ; =-26 [Store AL relative indirect]
fd90:      RSR              ; [Return from subroutine]
*
* Function FFD91
*
fd91:FFD91 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fd93:PFD93 STAB/ X'F800'    ; =0xf800 =63488(-2048) ='x',NUL [Store AL direct]
fd96:DFD96 LDAB/ X'F801'    ; =0xf801 =63489(-2047) [Load AL direct]
fd99:      DCAB             ; [Decrement AL]
fd9a:      BNZ   DFD96      ; =-6 [Branch if not zero]
fd9c:      LDAB* PFD93+1    ; =-10 [Load AL relative indirect]
fd9e:      RSR              ; [Return from subroutine]
*
fd9f:DFD9F LDBB= X'07'      ; =7 [Load BL with immediate]
fda1:      SABB             ; [AL - BL -> BL]
fda2:      BGZ   DFD65      ; =-63 [Branch if greater than zero]
fda4:      STAB/ X'F140'    ; =0xf140 =61760(-3776) [Store AL direct]
fda7:      LDA*  PFDD5+1    ; =+45 [Load A relative indirect]
fda9:      LDB=  X'0010'    ; =0x0010 =16 [Load B with immediate]
fdac:      NAB              ; [A & B -> B]
fdad:      BZ    DFD58      ; =-87 [Branch if zero]
fdaf:      CLA              ; [Clear A]
fdb0:      STA/  X'F141'    ; =0xf141 =61761(-3775) [Store A direct]
fdb3:      JSR   FFDDD      ; =+40 [Jump to subroutine relative]
fdb5:      DB    X'03'      ; =0x03 =3
*
fdb6:DFDB6 LDA*  PFDD5+1    ; =+30 [Load A relative indirect]
fdb8:      LDB=  X'0400'    ; =0x0400 =1024 [Load B with immediate]
fdbb:      NAB              ; [A & B -> B]
fdbc:DFDBC BNZ   DFD58      ; =-102 [Branch if not zero]
fdbe:      LDB=  X'0020'    ; =0x0020 =32 [Load B with immediate]
fdc1:      NAB              ; [A & B -> B]
fdc2:      BZ    DFDB6      ; =-14 [Branch if zero]
fdc4:      DMA   SDV,0      ; [Set DMA mode]
fdc6:      DMA   EAB        ; [Enable DMA]
fdc8:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fdcb:      DMA   SAD,A      ; [Store A register to DMA address register]
fdcd:      LDA=  X'EA1F'    ; =0xea1f =59935(-5601) [Load A with immediate]
fdd0:      DMA   SCT,A      ; [Store A register to DMA count register]
fdd2:      JSR   FFDDD      ; =+9 [Jump to subroutine relative]
fdd4:      DB    X'00'      ; =0x00 =0 =NUL
fdd5:PFDD5 LDAB/ X'F144'    ; =0xf144 =61764(-3772) [Load AL direct]
fdd8:      BNZ   DFDBC      ; =-30 [Branch if not zero]
fdda:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
*
* Function FFDDD
*
fddd:FFDDD LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fddf:      STAB/ X'F148'    ; =0xf148 =61768(-3768) [Store AL direct]
fde2:DFDE2 LDAB* PFDD5+1    ; =-14 [Load AL relative indirect]
fde4:      SRAB             ; [Right shift AL]
fde5:      BL    DFDE2      ; =-5 [Branch on link]
fde7:      RSR              ; [Return from subroutine]
*
fde8:      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
fdea:      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
fdec:      DW    X'9541'    ; =0x9541 =38209(-27327)
fdee:      DC    '3'        ; hex:b3 dec:179(-77)
fdef:      DW    X'0379'    ; =0x0379 =889
fdf1:      DB    X'4B'      ; =0x4b =75
fdf2:      DC    'N'        ; hex:ce dec:206(-50)
fdf3:      DB    X'47'      ; =0x47 =71
fdf4:      DC    '>'        ; hex:be dec:190(-66)
fdf5:      DB    X'6D'      ; =0x6d =109
fdf6:      DC    '"'        ; hex:a2 dec:162(-94)
fdf7:      DW    X'3240'    ; =0x3240 =12864
fdf9:      DW    X'794C'    ; =0x794c =31052
fdfb:      DW    X'224D'    ; =0x224d =8781
fdfd:      DW    X'142A'    ; =0x142a =5162
fdff:      DC    '@'        ; hex:c0 dec:192(-64)
fe00:ENDPT
