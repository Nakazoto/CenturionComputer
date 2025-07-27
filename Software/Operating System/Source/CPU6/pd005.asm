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
8000:ENTRY JMP   D8014      ; =+18 [Jump relative]
*
8002:      DW    X'0288'    ; =0x0288 =648
8004:      DW    X'0295'    ; =0x0295 =661
8006:      DW    X'02FF'    ; =0x02ff =767
8008:      DW    X'9C8C'    ; =0x9c8c =40076(-25460)
800a:      DW    X'0386'    ; =0x0386 =902
800c:      DW    X'049A'    ; =0x049a =1178
800e:      DW    X'019B'    ; =0x019b =411
8010:      DW    X'0189'    ; =0x0189 =393
8012:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8014:D8014 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8016:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
8019:      INR   X,2        ; [Increment X by 2]
801b:      LDA+  X          ; [Load A from address in X]
801c:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
801f:      SAB              ; [A - B -> B]
8020:      BNZ   D8038      ; =+22 [Branch if not zero]
8022:      JSR   F8048      ; =+36 [Jump to subroutine relative]
8024:      LDAB+ X,3        ; [Load AL indexed, displaced, direct]
8027:      DCAB             ; [Decrement AL]
8028:      STAB  B8074      ; =+74 [Store AL relative]
802a:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
802d:      DCAB             ; [Decrement AL]
802e:      STAB  B8073      ; =+67 [Store AL relative]
8030:      LDA=  W806F      ; =0x806f =32879(-32657) [Load A with immediate]
8033:D8033 STA+  Z,6        ; [Store A indexed, displaced, direct]
8036:      JMP   D8045      ; =+13 [Jump relative]
8038:D8038 LDAB= X'8C'      ; =140(-116) =FF [Load AL with immediate]
803a:      SUBB  AL,AU      ; [AL - AU -> AU]
803c:      BNZ   D8045      ; =+7 [Branch if not zero]
803e:      JSR   F8048      ; =+8 [Jump to subroutine relative]
8040:      LDA=  W8076      ; =0x8076 =32886(-32650) [Load A with immediate]
8043:      JMP   D8033      ; =-18 [Jump relative]
8045:D8045 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8047:      RSR              ; [Return from subroutine]
*
* Function F8048
*
8048:F8048 STK   X,6        ; [Push X Y Z to the stack]
804a:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
804d:      LDA+  A,110      ; [Load A indexed, displaced, direct]
8050:      DCA              ; [Decrement A]
8051:      XAZ              ; [Transfer A to Z]
8052:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
8055:D8055 INR   Z          ; [Increment Z by 1]
8057:      DCX              ; [Decrement X]
8058:      BZ    D806C      ; =+18 [Branch if zero]
805a:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
805c:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
805f:      SAB              ; [A - B -> B]
8060:      BNZ   D8055      ; =-13 [Branch if not zero]
8062:D8062 LDAB+ Z          ; [Load AL from address in Z]
8063:      BZ    D8069      ; =+4 [Branch if zero]
8065:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8067:      JMP   D8062      ; =-7 [Jump relative]
8069:D8069 CLA              ; [Clear A]
806a:      DCA              ; [Decrement A]
806b:      STAB+ Z          ; [Store AL to address in Z]
806c:D806C POP   X,6        ; [Pop Z Y X from the stack]
806e:      RSR              ; [Return from subroutine]
*
806f:W806F DW    X'0005'    ; =0x0005 =5
8071:      DW    X'9B91'    ; =0x9b91 =39825(-25711)
8073:B8073 DB    X'00'      ; =0x00 =0 =NUL
8074:B8074 DW    X'00FF'    ; =0x00ff =255
8076:W8076 DW    X'0002'    ; =0x0002 =2
8078:      DW    X'9B9C'    ; =0x9b9c =39836(-25700)
807a:ENDPT
