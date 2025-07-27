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
8000:ENTRY JMP   D801C      ; =+26 [Jump relative]
*
8002:      DW    X'0288'    ; =0x0288 =648
8004:      DW    X'0295'    ; =0x0295 =661
8006:      DW    X'0181'    ; =0x0181 =385
8008:      DW    X'0198'    ; =0x0198 =408
800a:      DW    X'0199'    ; =0x0199 =409
800c:      DW    X'059B'    ; =0x059b =1435
800e:      DW    X'0386'    ; =0x0386 =902
8010:      DW    X'049A'    ; =0x049a =1178
8012:      DW    X'02FF'    ; =0x02ff =767
8014:      DW    X'02DF'    ; =0x02df =735
8016:      DW    X'DF9F'    ; =0xdf9f =57247(-8289)
8018:      DW    X'8D9D'    ; =0x8d9d =36253(-29283)
801a:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
801c:D801C STX-  S-         ; [Store X indexed, pre-decremented, direct]
801e:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
8021:      INR   X,2        ; [Increment X by 2]
8023:      LDA+  X          ; [Load A from address in X]
8024:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
8027:      SAB              ; [A - B -> B]
8028:      BNZ   D807C      ; =+82 [Branch if not zero]
802a:      STK   X,6        ; [Push X Y Z to the stack]
802c:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
802f:      LDA+  A,110      ; [Load A indexed, displaced, direct]
8032:      DCA              ; [Decrement A]
8033:      XAZ              ; [Transfer A to Z]
8034:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
8037:D8037 INR   Z          ; [Increment Z by 1]
8039:      DCX              ; [Decrement X]
803a:      BZ    D804E      ; =+18 [Branch if zero]
803c:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
803e:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
8041:      SAB              ; [A - B -> B]
8042:      BNZ   D8037      ; =-13 [Branch if not zero]
8044:D8044 LDAB+ Z          ; [Load AL from address in Z]
8045:      BZ    D804B      ; =+4 [Branch if zero]
8047:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8049:      JMP   D8044      ; =-7 [Jump relative]
804b:D804B CLA              ; [Clear A]
804c:      DCA              ; [Decrement A]
804d:      STAB+ Z          ; [Store AL to address in Z]
804e:D804E POP   X,6        ; [Pop Z Y X from the stack]
8050:      MVF   (2)='@@',/W8088 ; =0x8088 =32904(-32632) [Move fixed-length, literal=0xc0c0(49344,-64), direct]
8057:      MVF   (2)='@@',/W8084 ; =0x8084 =32900(-32636) [Move fixed-length, literal=0xc0c0(49344,-64), direct]
805e:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
8061:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8063:      CFB   /W8088(10),-X,3(1) ; =0x8088 =32904(-32632), [Convert from bignum, direct, displaced indexed]
806a:      LDA=  X'0002'    ; =0x0002 =2 [Load A with immediate]
806d:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
806f:      CFB   /W8084(10),-X,2(1) ; =0x8084 =32900(-32636), [Convert from bignum, direct, displaced indexed]
8076:      LDA=  W807F      ; =0x807f =32895(-32641) [Load A with immediate]
8079:      STA+  Z,6        ; [Store A indexed, displaced, direct]
807c:D807C LDX+  S+         ; [Load X indexed, direct, post-incremented]
807e:      RSR              ; [Return from subroutine]
*
807f:W807F DW    X'000A'    ; =0x000a =10
8081:      DB    X'9B'      ; =0x9b =155(-101)
8082:      DC    '[P'       ; hex:dbd0 dec:56272(-48)
8084:W8084 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8086:      DC    ':P'       ; hex:bad0 dec:47824(-48)
8088:W8088 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
808a:      DC    'H'        ; hex:c8 dec:200(-56)
808b:ENDPT
