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
*
* Function ENTRY
*
ef00:ENTRY BS3   DEF05      ; =+3 [Branch if Sense Switch 3 set]
ef02:      JMP/  X'EFC0'    ; =0xefc0 =61376(-4160) ='o','@' [Jump direct]
ef05:DEF05 LDAB= X'01'      ; =1 [Load AL with immediate]
ef07:      BS4   DEF0A      ; =+1 [Branch if Sense Switch 4 set]
ef09:      CLAB             ; [Clear AL]
ef0a:DEF0A STAB/ X'F14B'    ; =0xf14b =61771(-3765) [Store AL direct]
ef0d:      LDA=  X'0100'    ; =0x0100 =256 [Load A with immediate]
ef10:      STA/  X'FFF0'    ; =0xfff0 =65520(-16) [Store A direct]
ef13:      STAB/ X'FFF4'    ; =0xfff4 =65524(-12) [Store AL direct]
ef16:      STAB/ X'FFF7'    ; =0xfff7 =65527(-9) [Store AL direct]
ef19:      XAS              ; [Transfer A to S]
ef1a:      LDA=  X'E88F'    ; =0xe88f =59535(-6001) [Load A with immediate]
ef1d:      STA/  X'FFF2'    ; =0xfff2 =65522(-14) [Store A direct]
ef20:      LDAB= X'03'      ; =3 [Load AL with immediate]
ef22:      JSR   FEF2A      ; =+6 [Jump to subroutine relative]
ef24:      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
ef26:      JSR   FEF2A      ; =+2 [Jump to subroutine relative]
ef28:      JMP+  S          ; [Jump indexed, direct]
*
* Function FEF2A
*
ef2a:FEF2A STAB/ X'F148'    ; =0xf148 =61768(-3768) [Store AL direct]
ef2d:DEF2D LDAB/ X'F144'    ; =0xf144 =61764(-3772) [Load AL direct]
ef30:      SRAB             ; [Right shift AL]
ef31:      BNZ   ENTRY      ; =-51 [Branch if not zero]
ef33:      BL    DEF2D      ; =-8 [Branch on link]
ef35:      LDAB/ X'F145'    ; =0xf145 =61765(-3771) [Load AL direct]
ef38:      LDBB= X'30'      ; =48 [Load BL with immediate]
ef3a:      ANDB  BL,AL      ; [BL & AL -> AL]
ef3c:      SABB             ; [AL - BL -> BL]
ef3d:      BNZ   DEF2D      ; =-18 [Branch if not zero]
ef3f:      RSR              ; [Return from subroutine]
*
ef40:      DB    0,128      ; =0x00,0x0080
efc0:      LDA=  X'F0B0'    ; =0xf0b0 =61616(-3920) ='p','0' [Load A with immediate]
efc3:      BS4   DEFC8      ; =+3 [Branch if Sense Switch 4 set]
efc5:      LDA=  X'F0A0'    ; =0xf0a0 =61600(-3936) ='p',' ' [Load A with immediate]
efc8:DEFC8 XFR   A,C        ; [Transfer A to C]
efca:DEFCA LDA=  X'00F0'    ; =0x00f0 =240 =NUL,'p' [Load A with immediate]
efcd:      XAS              ; [Transfer A to S]
efce:DEFCE JSR   FEFEF      ; =+31 [Jump to subroutine relative]
efd0:      XABB             ; [Transfer AL to BL]
efd1:      JSR   FEFEF      ; =+28 [Jump to subroutine relative]
efd3:      XAX              ; [Transfer A to X]
efd4:      XAZB             ; [Transfer AL to ZL]
efd5:      JSR   FEFEF      ; =+24 [Jump to subroutine relative]
efd7:      XFRB  AL,YU      ; [Transfer AL to YU]
efd9:      JSR   FEFEF      ; =+20 [Jump to subroutine relative]
efdb:      XAYB             ; [Transfer AL to YL]
efdc:DEFDC DCX              ; [Decrement X]
efdd:      BM    DEFE5      ; =+6 [Branch on minus]
efdf:      JSR   FEFEF      ; =+14 [Jump to subroutine relative]
efe1:      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
efe3:      JMP   DEFDC      ; =-9 [Jump relative]
efe5:DEFE5 JSR   FEFEF      ; =+8 [Jump to subroutine relative]
efe7:      BNZ   DEFCA+1    ; =-30 [Branch if not zero]
efe9:      XFRB  ZL,ZL      ; [Transfer ZL to ZL]
efeb:      BNZ   DEFCE      ; =-31 [Branch if not zero]
efed:      JMP+  Y          ; [Jump indexed, direct]
*
* Function FEFEF
*
efef:FEFEF LDAB+ C,1        ; [Load AL indexed, displaced, direct]
eff2:      BM    DEFCA+1    ; =-41 [Branch on minus]
eff4:      SRAB             ; [Right shift AL]
eff5:      BNL   DEFFA      ; =+3 [Branch on no link]
eff7:      STAB+ C,3        ; [Store AL indexed, displaced, direct]
effa:DEFFA SRAB             ; [Right shift AL]
effb:      BNL   FEFEF      ; =-14 [Branch on no link]
effd:      LDAB+ C          ; [Load AL from address in C]
effe:      AABB             ; [AL + BL -> BL]
efff:      RSR              ; [Return from subroutine]
*
f000:ENDPT
