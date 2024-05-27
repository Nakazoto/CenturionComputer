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
fc00:      BS1   DFC04      ; =+2 [Branch if Sense Switch 1 set]
fc02:      JMP   DFC07      ; =+3 [Jump relative]
fc04:DFC04 JMP/  X'8001'    ; =0x8001 =32769(-32767) [Jump direct]
fc07:DFC07 LDAB= X'C5'      ; =197(-59) ='E' [Load AL with immediate]
fc09:      STAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Store AL direct]
fc0c:      LDAB= X'8C'      ; =140(-116) =FF [Load AL with immediate]
fc0e:      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
fc11:      DLY              ; [Delay 4.55 ms]
fc12:      DLY              ; [Delay 4.55 ms]
fc13:DFC13 LDA=  X'1000'    ; =0x1000 =4096 [Load A with immediate]
fc16:      XAS              ; [Transfer A to S]
fc17:      JSR   FFC92      ; =+121 [Jump to subroutine relative]
fc19:      DC    'D='       ; hex:c4bd dec:50365(-67)
fc1b:      DB    X'00'      ; =0x00 =0 =NUL
*
fc1c:      JSR   FFC90      ; =+114 [Jump to subroutine relative]
fc1e:      LDBB= X'C6'      ; =198(-58) ='F' [Load BL with immediate]
fc20:      SABB             ; [AL - BL -> BL]
fc21:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
fc23:      BZ    DFC2F      ; =+10 [Branch if zero]
fc25:      LDBB= X'C3'      ; =195(-61) ='C' [Load BL with immediate]
fc27:      SABB             ; [AL - BL -> BL]
fc28:      BZ    DFC2F      ; =+5 [Branch if zero]
fc2a:      LDBB= X'C8'      ; =200(-56) ='H' [Load BL with immediate]
fc2c:      SABB             ; [AL - BL -> BL]
fc2d:      BNZ   DFC7F      ; =+80 [Branch if not zero]
fc2f:DFC2F JSR   DFCA3      ; =+114 [Jump to subroutine relative]
fc31:      LDBB= X'50'      ; =80 [Load BL with immediate]
fc33:      ADDB  BL,AL      ; [BL + AL -> AL]
fc35:      BM    DFC7F      ; =+72 [Branch on minus]
fc37:      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
fc39:      BM    DFCBA      ; =+127 [Branch on minus]
fc3b:      BGZ   DFCBC      ; =+127 [Branch if greater than zero]
fc3d:      LDBB= X'03'      ; =3 [Load BL with immediate]
fc3f:      SABB             ; [AL - BL -> BL]
fc40:      BGZ   DFC7F      ; =+61 [Branch if greater than zero]
fc42:      LDB=  X'0F00'    ; =0x0f00 =3840 [Load B with immediate]
fc45:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fc47:      CLR   B          ; [Clear B]
fc49:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fc4b:      LDBB= X'88'      ; =136(-120) [Load BL with immediate]
fc4d:      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
fc4f:      LDB=  X'8300'    ; =0x8300 =33536(-32000) [Load B with immediate]
fc52:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fc54:      LDB=  X'8100'    ; =0x8100 =33024(-32512) [Load B with immediate]
fc57:      SL               ; [Set link]
fc58:DFC58 RLRB  BL         ; [Left rotate BL by 1]
fc5a:      DCAB             ; [Decrement AL]
fc5b:      BP    DFC58      ; =-5 [Branch on plus]
fc5d:      STB-  S-         ; [Store B indexed, pre-decremented, direct]
fc5f:      DMA   SDV,1      ; [Set DMA mode]
fc61:      DMA   EAB        ; [Enable DMA]
fc63:      DMA   SAD,S      ; [Store S register to DMA address register]
fc65:      LDA=  X'FFF6'    ; =0xfff6 =65526(-10) [Load A with immediate]
fc68:      DMA   SCT,A      ; [Store A register to DMA count register]
fc6a:      JSR   FFC8E      ; =+34 [Jump to subroutine relative]
fc6c:      DB    X'43'      ; =0x43 =67
fc6d:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fc70:      DMA   SAD,A      ; [Store A register to DMA address register]
fc72:      LDA=  X'F0FF'    ; =0xf0ff =61695(-3841) [Load A with immediate]
fc75:      DMA   SCT,A      ; [Store A register to DMA count register]
fc77:      JSR   FFC8E      ; =+21 [Jump to subroutine relative]
fc79:      DB    X'45'      ; =0x45 =69
fc7a:      BNZ   DFC7F      ; =+3 [Branch if not zero]
fc7c:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
fc7f:DFC7F JSR   FFC92      ; =+17 [Jump to subroutine relative]
fc81:      DW    X'8D8A'    ; =0x8d8a =36234(-29302) =CR,LF
fc83:      DC    'ERROR'    ; hex:c5d2d2cfd2
fc88:      DB    X'8D'      ; =0x8d =141(-115) =CR
fc89:      DW    X'8A00'    ; =0x8a00 =35328(-30208) =LF,NUL
fc8b:      RL               ; [Reset link]
fc8c:      JMP   DFC13      ; =-123 [Jump relative]
*
* Function FFC8E
*
fc8e:FFC8E JMP   DFD03      ; =+115 [Jump relative]
*
* Function FFC90
*
fc90:FFC90 JMP   DFCA3      ; =+17 [Jump relative]
*
* Function FFC92
*
fc92:FFC92 LDAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
fc95:      SRAB             ; [Right shift AL]
fc96:      SRAB             ; [Right shift AL]
fc97:      BNL   FFC92      ; =-7 [Branch on no link]
fc99:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fc9b:      BNZ   PFC9E      ; =+1 [Branch if not zero]
fc9d:      RSR              ; [Return from subroutine]
*
fc9e:PFC9E STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
fca1:      JMP   FFC92      ; =-17 [Jump relative]
fca3:DFCA3 LDAB* FFC92+1    ; =-18 [Load AL relative indirect]
fca5:      SRAB             ; [Right shift AL]
fca6:      BNL   DFCA3      ; =-5 [Branch on no link]
fca8:      LDAB* PFC9E+1    ; =-11 [Load AL relative indirect]
fcaa:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
fcac:      ORIB  BL,AL      ; [BL | AL -> AL]
fcae:      LDBB= X'E0'      ; =224(-32) ='`' [Load BL with immediate]
fcb0:      SABB             ; [AL - BL -> BL]
fcb1:      BM    DFCB7      ; =+4 [Branch on minus]
fcb3:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
fcb5:      ANDB  BL,AL      ; [BL & AL -> AL]
fcb7:DFCB7 STAB* PFC9E+1    ; =-26 [Store AL relative indirect]
fcb9:      RSR              ; [Return from subroutine]
*
fcba:DFCBA JMP   DFD1E      ; =+98 [Jump relative]
fcbc:DFCBC JMP   DFCC0      ; =+2 [Jump relative]
fcbe:DFCBE JMP   DFC7F      ; =-65 [Jump relative]
fcc0:DFCC0 LDBB= X'07'      ; =7 [Load BL with immediate]
fcc2:      SABB             ; [AL - BL -> BL]
fcc3:      BGZ   DFC7F      ; =-70 [Branch if greater than zero]
fcc5:      STAB/ X'F140'    ; =0xf140 =61760(-3776) [Store AL direct]
fcc8:      LDA*  PFCF6+1    ; =+45 [Load A relative indirect]
fcca:      LDB=  X'0010'    ; =0x0010 =16 [Load B with immediate]
fccd:      NAB              ; [A & B -> B]
fcce:      BZ    DFC7F      ; =-81 [Branch if zero]
fcd0:      CLA              ; [Clear A]
fcd1:      STA/  X'F141'    ; =0xf141 =61761(-3775) [Store A direct]
fcd4:      JSR   FFD11      ; =+59 [Jump to subroutine relative]
fcd6:      DB    X'03'      ; =0x03 =3
*
fcd7:DFCD7 LDA*  PFCF6+1    ; =+30 [Load A relative indirect]
fcd9:      LDB=  X'0400'    ; =0x0400 =1024 [Load B with immediate]
fcdc:      NAB              ; [A & B -> B]
fcdd:      BNZ   DFC7F      ; =-96 [Branch if not zero]
fcdf:      LDB=  X'0020'    ; =0x0020 =32 [Load B with immediate]
fce2:      NAB              ; [A & B -> B]
fce3:      BZ    DFCD7      ; =-14 [Branch if zero]
fce5:      DMA   SDV,0      ; [Set DMA mode]
fce7:      DMA   EAB        ; [Enable DMA]
fce9:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fcec:      DMA   SAD,A      ; [Store A register to DMA address register]
fcee:      LDA=  X'EA1F'    ; =0xea1f =59935(-5601) [Load A with immediate]
fcf1:      DMA   SCT,A      ; [Store A register to DMA count register]
fcf3:      JSR   FFD11      ; =+28 [Jump to subroutine relative]
fcf5:      DB    X'00'      ; =0x00 =0 =NUL
fcf6:PFCF6 LDAB/ X'F144'    ; =0xf144 =61764(-3772) [Load AL direct]
fcf9:      BNZ   DFC7F      ; =-124 [Branch if not zero]
fcfb:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
fcfe:      JSR   FFD2F      ; =+47 [Jump to subroutine relative]
*
* Function ENTRY
*
fd00:ENTRY JMP/  X'FC00'    ; =0xfc00 =64512(-1024) ='|',NUL [Jump direct]
fd03:DFD03 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fd05:PFD05 STAB/ X'F800'    ; =0xf800 =63488(-2048) ='x',NUL [Store AL direct]
fd08:DFD08 LDAB/ X'F801'    ; =0xf801 =63489(-2047) [Load AL direct]
fd0b:      DCAB             ; [Decrement AL]
fd0c:      BNZ   DFD08      ; =-6 [Branch if not zero]
fd0e:      LDAB* PFD05+1    ; =-10 [Load AL relative indirect]
fd10:      RSR              ; [Return from subroutine]
*
* Function FFD11
*
fd11:FFD11 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
fd13:      STAB/ X'F148'    ; =0xf148 =61768(-3768) [Store AL direct]
fd16:DFD16 LDAB* PFCF6+1    ; =-33 [Load AL relative indirect]
fd18:      SRAB             ; [Right shift AL]
fd19:      BL    DFD16      ; =-5 [Branch on link]
fd1b:      RSR              ; [Return from subroutine]
*
fd1c:DFD1C JMP   DFCBE      ; =-96 [Jump relative]
fd1e:DFD1E STAB- S-         ; [Store AL indexed, pre-decremented, direct]
fd20:      LDA=  X'1F40'    ; =0x1f40 =8000 [Load A with immediate]
fd23:      XAZ              ; [Transfer A to Z]
fd24:      LDA=  X'8100'    ; =0x8100 =33024(-32512) [Load A with immediate]
fd27:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
fd29:      LDAB= X'84'      ; =132(-124) =EOT [Load AL with immediate]
fd2b:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd2d:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
*
* Function FFD2F
*
fd2f:FFD2F BZ    DFD35      ; =+4 [Branch if zero]
fd31:      LDBB= X'0F'      ; =15 [Load BL with immediate]
fd33:      ADDB  BL,AL      ; [BL + AL -> AL]
fd35:DFD35 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd37:      LDAB= X'83'      ; =131(-125) [Load AL with immediate]
fd39:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd3b:      CLA              ; [Clear A]
fd3c:      STA+  Z+         ; [Store A indexed, direct, post-incremented]
fd3e:      LDAB= X'85'      ; =133(-123) [Load AL with immediate]
fd40:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd42:      CLAB             ; [Clear AL]
fd43:DFD43 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd45:      LDB=  X'0190'    ; =0x0190 =400 [Load B with immediate]
fd48:      STB+  Z+         ; [Store B indexed, direct, post-incremented]
fd4a:      INAB             ; [Increment AL]
fd4b:      LDBB= X'0E'      ; =14 [Load BL with immediate]
fd4d:      SABB             ; [AL - BL -> BL]
fd4e:      BNZ   DFD43      ; =-13 [Branch if not zero]
fd50:      LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
fd52:      STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
fd54:      LDAB= X'08'      ; =8 [Load AL with immediate]
fd56:      JSR   FFDA6      ; =+78 [Jump to subroutine relative]
fd58:      LDAB= X'41'      ; =65 [Load AL with immediate]
fd5a:      STAB/ X'F808'    ; =0xf808 =63496(-2040) [Store AL direct]
fd5d:      DLY              ; [Delay 4.55 ms]
fd5e:      CLAB             ; [Clear AL]
fd5f:      STAB/ X'F808'    ; =0xf808 =63496(-2040) [Store AL direct]
fd62:      DLY              ; [Delay 4.55 ms]
fd63:      STAB/ X'F808'    ; =0xf808 =63496(-2040) [Store AL direct]
fd66:      DLY              ; [Delay 4.55 ms]
fd67:      LDA=  X'1F40'    ; =0x1f40 =8000 [Load A with immediate]
fd6a:      DMA   SAD,A      ; [Store A register to DMA address register]
fd6c:      SUB   Z,A        ; [Z - A -> A]
fd6e:      IVA              ; [Invert A]
fd6f:      DMA   SCT,A      ; [Store A register to DMA count register]
fd71:      DMA   SDV,3      ; [Set DMA mode]
fd73:      DMA   EAB        ; [Enable DMA]
fd75:      LDAB= X'43'      ; =67 [Load AL with immediate]
fd77:      STAB/ X'F808'    ; =0xf808 =63496(-2040) [Store AL direct]
fd7a:      DLY              ; [Delay 4.55 ms]
fd7b:      DLY              ; [Delay 4.55 ms]
fd7c:      JSR   FFD9E      ; =+32 [Jump to subroutine relative]
fd7e:      JMP   DFD82      ; =+2 [Jump relative]
fd80:DFD80 JMP   DFD1C      ; =-102 [Jump relative]
fd82:DFD82 LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
fd85:      DMA   SAD,A      ; [Store A register to DMA address register]
fd87:      LDA=  X'EA1F'    ; =0xea1f =59935(-5601) [Load A with immediate]
fd8a:      DMA   SCT,A      ; [Store A register to DMA count register]
fd8c:      DMA   SDV,3      ; [Set DMA mode]
fd8e:      DMA   EAB        ; [Enable DMA]
fd90:      LDAB= X'45'      ; =69 [Load AL with immediate]
fd92:      STAB/ X'F808'    ; =0xf808 =63496(-2040) [Store AL direct]
fd95:      LDAB= X'08'      ; =8 [Load AL with immediate]
fd97:      JSR   FFDA6      ; =+13 [Jump to subroutine relative]
fd99:      JSR   FFD9E      ; =+3 [Jump to subroutine relative]
fd9b:      JMP/  X'0103'    ; =0x0103 =259 [Jump direct]
*
* Function FFD9E
*
fd9e:FFD9E LDAB/ X'F808'    ; =0xf808 =63496(-2040) [Load AL direct]
fda1:      BNZ   DFDA4      ; =+1 [Branch if not zero]
fda3:      RSR              ; [Return from subroutine]
*
fda4:DFDA4 JMP   DFD80      ; =-38 [Jump relative]
*
* Function FFDA6
*
fda6:FFDA6 LDBB/ X'F809'    ; =0xf809 =63497(-2039) [Load BL direct]
fda9:      NABB             ; [AL & BL -> BL]
fdaa:      BNZ   FFDA6      ; =-6 [Branch if not zero]
fdac:      RSR              ; [Return from subroutine]
*
fdad:      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
fdaf:      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
*
fdb1:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
fdb3:      STA   WFDB8      ; =+3 [Store A relative]
fdb5:DFDB5 JSR/  X'4C93'    ; =0x4c93 =19603 [Jump to subroutine direct]
fdb8:WFDB8 DB    X'47'      ; =0x47 =71
fdb9:      DC    '>'        ; hex:be dec:190(-66)
fdba:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
fdbc:      CLR   X          ; [Clear X]
fdbe:DFDBE JSR/  X'4CE7'    ; =0x4ce7 =19687 [Jump to subroutine direct]
fdc1:      XABB             ; [Transfer AL to BL]
fdc2:      BZ    DFDEE      ; =+42 [Branch if zero]
fdc4:      LDBB= X'8D'      ; =141(-115) =CR [Load BL with immediate]
fdc6:      SABB             ; [AL - BL -> BL]
fdc7:      BZ    DFDEE      ; =+37 [Branch if zero]
fdc9:      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
fdcb:      SABB             ; [AL - BL -> BL]
fdcc:      BM    DFDF3      ; =+37 [Branch on minus]
fdce:      LDAB= X'09'      ; =9 [Load AL with immediate]
fdd0:      SUBB  BL,AL      ; [BL - AL -> AL]
fdd2:      BLE   DFDE2      ; =+14 [Branch if less than or equal to zero]
fdd4:      LDAB= X'11'      ; =17 [Load AL with immediate]
fdd6:      SUBB  BL,AL      ; [BL - AL -> AL]
fdd8:      BM    DFDF3      ; =+25 [Branch on minus]
fdda:      LDBB= X'05'      ; =5 [Load BL with immediate]
fddc:      SABB             ; [AL - BL -> BL]
fddd:      BGZ   DFDF3      ; =+20 [Branch if greater than zero]
fddf:      LDBB= X'0A'      ; =10 [Load BL with immediate]
fde1:      AABB             ; [AL + BL -> BL]
fde2:DFDE2 LDAB= X'04'      ; =4 [Load AL with immediate]
fde4:DFDE4 RL               ; [Reset link]
fde5:      RLR   X          ; [Left rotate X by 1]
fde7:      DCAB             ; [Decrement AL]
fde8:      BGZ   DFDE4      ; =-6 [Branch if greater than zero]
fdea:      ADDB  BL,XL      ; [BL + XL -> XL]
fdec:      JMP   DFDBE      ; =-48 [Jump relative]
fdee:DFDEE XFR   X,A        ; [Transfer X to A]
fdf0:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
fdf2:      RSR              ; [Return from subroutine]
*
fdf3:DFDF3 LDX+  S+         ; [Load X indexed, direct, post-incremented]
fdf5:      JMP   DFDB5      ; =-66 [Jump relative]
*
fdf7:      DC    'U'        ; hex:d5 dec:213(-43)
fdf8:      DW    X'417D'    ; =0x417d =16765
fdfa:      DW    X'800C'    ; =0x800c =32780(-32756)
fdfc:      DC    'P'        ; hex:d0 dec:208(-48)
fdfd:      DW    X'4B65'    ; =0x4b65 =19301
fdff:      DC    'u'        ; hex:f5 dec:245(-11)
fe00:ENDPT
