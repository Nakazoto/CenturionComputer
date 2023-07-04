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
8000:ENTRY JMP   D801E      ; =+28 [Jump relative]
*
8002:      DW    X'9688'    ; =0x9688 =38536(-27000)
8004:      DW    X'9695'    ; =0x9695 =38549(-26987)
8006:      DW    X'0181'    ; =0x0181 =385
8008:      DW    X'0198'    ; =0x0198 =408
800a:      DW    X'0199'    ; =0x0199 =409
800c:      DW    X'059B'    ; =0x059b =1435
800e:      DW    X'0386'    ; =0x0386 =902
8010:      DW    X'049A'    ; =0x049a =1178
8012:      DW    X'96FF'    ; =0x96ff =38655(-26881)
8014:      DW    X'96DF'    ; =0x96df =38623(-26913)
8016:      DW    X'DF9F'    ; =0xdf9f =57247(-8289)
8018:      DW    X'8D9D'    ; =0x8d9d =36253(-29283)
801a:      DW    X'9790'    ; =0x9790 =38800(-26736)
801c:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
801e:D801E STX-  S-         ; [Store X indexed, pre-decremented, direct]
8020:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
8023:      INR   X,2        ; [Increment X by 2]
8025:      LDA+  X          ; [Load A from address in X]
8026:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
8029:      SAB              ; [A - B -> B]
802a:      BNZ   D8068      ; =+60 [Branch if not zero]
802c:      STK   X,6        ; [Push X Y Z to the stack]
802e:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8031:      LDA+  A,110      ; [Load A indexed, displaced, direct]
8034:      DCA              ; [Decrement A]
8035:      XAZ              ; [Transfer A to Z]
8036:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
8039:D8039 INR   Z          ; [Increment Z by 1]
803b:      DCX              ; [Decrement X]
803c:      BZ    D8050      ; =+18 [Branch if zero]
803e:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8040:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
8043:      SAB              ; [A - B -> B]
8044:      BNZ   D8039      ; =-13 [Branch if not zero]
8046:D8046 LDAB+ Z          ; [Load AL from address in Z]
8047:      BZ    D804D      ; =+4 [Branch if zero]
8049:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
804b:      JMP   D8046      ; =-7 [Jump relative]
804d:D804D CLA              ; [Clear A]
804e:      DCA              ; [Decrement A]
804f:      STAB+ Z          ; [Store AL to address in Z]
8050:D8050 POP   X,6        ; [Pop Z Y X from the stack]
8052:      LDAB+ X,3        ; [Load AL indexed, displaced, direct]
8055:      LDBB= X'9F'      ; =159(-97) [Load BL with immediate]
8057:      AABB             ; [AL + BL -> BL]
8058:      STBB  B806F      ; =+21 [Store BL relative]
805a:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
805d:      LDBB= X'9F'      ; =159(-97) [Load BL with immediate]
805f:      AABB             ; [AL + BL -> BL]
8060:      STBB  B8070      ; =+14 [Store BL relative]
8062:      LDA=  W806B      ; =0x806b =32875(-32661) [Load A with immediate]
8065:      STA+  Z,6        ; [Store A indexed, displaced, direct]
8068:D8068 LDX+  S+         ; [Load X indexed, direct, post-incremented]
806a:      RSR              ; [Return from subroutine]
*
806b:W806B DW    X'0005'    ; =0x0005 =5
806d:      DB    X'9B'      ; =0x9b =155(-101)
806e:      DC    'Y'        ; hex:d9 dec:217(-39)
806f:B806F DB    X'00'      ; =0x00 =0 =NUL
8070:B8070 DW    X'00FF'    ; =0x00ff =255
8072:ENDPT
