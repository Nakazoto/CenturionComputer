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
8000:ENTRY JMP   D800E      ; =+12 [Jump relative]
*
8002:      DW    X'0295'    ; =0x0295 =661
8004:      DW    X'02FF'    ; =0x02ff =767
8006:      DW    X'0386'    ; =0x0386 =902
8008:      DW    X'049A'    ; =0x049a =1178
800a:      DW    X'0181'    ; =0x0181 =385
800c:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
800e:D800E STX-  S-         ; [Store X indexed, pre-decremented, direct]
8010:      LDB+  Z,6        ; [Load B indexed, displaced, direct]
8013:      LDX+  B+         ; [Load X indexed, direct, post-incremented]
8015:      LDA=  X'8800'    ; =0x8800 =34816(-30720) [Load A with immediate]
8018:D8018 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
801a:      SUBB  AU,AL      ; [AU - AL -> AL]
801c:      BNZ   D8024      ; =+6 [Branch if not zero]
801e:      LDAB= X'95'      ; =149(-107) [Load AL with immediate]
8020:      STAB- B-         ; [Store AL indexed, pre-decremented, direct]
8022:      INR   B          ; [Increment B by 1]
8024:D8024 DCX              ; [Decrement X]
8025:      BGZ   D8018      ; =-15 [Branch if greater than zero]
8027:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
802a:      INR   X,2        ; [Increment X by 2]
802c:      LDA+  X          ; [Load A from address in X]
802d:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
8030:      SAB              ; [A - B -> B]
8031:      BNZ   D8074      ; =+65 [Branch if not zero]
8033:      STK   X,6        ; [Push X Y Z to the stack]
8035:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8038:      LDA+  A,110      ; [Load A indexed, displaced, direct]
803b:      DCA              ; [Decrement A]
803c:      XAZ              ; [Transfer A to Z]
803d:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
8040:D8040 INR   Z          ; [Increment Z by 1]
8042:      DCX              ; [Decrement X]
8043:      BZ    D8057      ; =+18 [Branch if zero]
8045:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8047:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
804a:      SAB              ; [A - B -> B]
804b:      BNZ   D8040      ; =-13 [Branch if not zero]
804d:D804D LDAB+ Z          ; [Load AL from address in Z]
804e:      BZ    D8054      ; =+4 [Branch if zero]
8050:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8052:      JMP   D804D      ; =-7 [Jump relative]
8054:D8054 CLA              ; [Clear A]
8055:      DCA              ; [Decrement A]
8056:      STAB+ Z          ; [Store AL to address in Z]
8057:D8057 POP   X,6        ; [Pop Z Y X from the stack]
8059:      LDAB+ X,3        ; [Load AL indexed, displaced, direct]
805c:      DCAB             ; [Decrement AL]
805d:      STAB  B807A      ; =+27 [Store AL relative]
805f:      CLA              ; [Clear A]
8060:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
8063:      DCA              ; [Decrement A]
8064:      LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
8067:      DIV   B,A        ; [A / B -> B, A % B -> A]
8069:      SLR   B,4        ; [Left shift B by 4]
806b:      AABB             ; [AL + BL -> BL]
806c:      STBB  B807D      ; =+15 [Store BL relative]
806e:      LDA=  W8077      ; =0x8077 =32887(-32649) [Load A with immediate]
8071:      STA+  Z,6        ; [Store A indexed, displaced, direct]
8074:D8074 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8076:      RSR              ; [Return from subroutine]
*
8077:W8077 DW    X'0006'    ; =0x0006 =6
8079:      DB    X'8B'      ; =0x8b =139(-117) =VT
807a:B807A DW    X'00FF'    ; =0x00ff =255
807c:      DB    X'90'      ; =0x90 =144(-112)
807d:B807D DW    X'00FF'    ; =0x00ff =255
807f:ENDPT
