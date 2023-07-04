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
8000:ENTRY JMP   D8012      ; =+16 [Jump relative]
*
8002:      DW    X'0288'    ; =0x0288 =648
8004:      DW    X'02FF'    ; =0x02ff =767
8006:      DW    X'02DF'    ; =0x02df =735
8008:      DW    X'DF9F'    ; =0xdf9f =57247(-8289)
800a:      DW    X'0386'    ; =0x0386 =902
800c:      DW    X'049A'    ; =0x049a =1178
800e:      DW    X'0181'    ; =0x0181 =385
8010:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8012:D8012 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8014:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
8017:      INR   X,2        ; [Increment X by 2]
8019:      LDA+  X          ; [Load A from address in X]
801a:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
801d:      SAB              ; [A - B -> B]
801e:      BNZ   D8069      ; =+73 [Branch if not zero]
8020:      STK   X,6        ; [Push X Y Z to the stack]
8022:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8025:      LDA+  A,110      ; [Load A indexed, displaced, direct]
8028:      DCA              ; [Decrement A]
8029:      XAZ              ; [Transfer A to Z]
802a:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
802d:D802D INR   Z          ; [Increment Z by 1]
802f:      DCX              ; [Decrement X]
8030:      BZ    D8044      ; =+18 [Branch if zero]
8032:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
8034:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
8037:      SAB              ; [A - B -> B]
8038:      BNZ   D802D      ; =-13 [Branch if not zero]
803a:D803A LDAB+ Z          ; [Load AL from address in Z]
803b:      BZ    D8041      ; =+4 [Branch if zero]
803d:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
803f:      JMP   D803A      ; =-7 [Jump relative]
8041:D8041 CLA              ; [Clear A]
8042:      DCA              ; [Decrement A]
8043:      STAB+ Z          ; [Store AL to address in Z]
8044:D8044 POP   X,6        ; [Pop Z Y X from the stack]
8046:      LDAB+ X,3        ; [Load AL indexed, displaced, direct]
8049:      LDBB= X'BF'      ; =191(-65) ='?' [Load BL with immediate]
804b:      AABB             ; [AL + BL -> BL]
804c:      STBB  B806F      ; =+33 [Store BL relative]
804e:      CLA              ; [Clear A]
804f:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
8052:      DCA              ; [Decrement A]
8053:      LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
8056:      DIV   B,A        ; [A / B -> B, A % B -> A]
8058:      LDX=  X'00B0'    ; =0x00b0 =176 =NUL,'0' [Load X with immediate]
805b:      ORIB  XL,AL      ; [XL | AL -> AL]
805d:      ORIB  XL,BL      ; [XL | BL -> BL]
805f:      STBB  B8073      ; =+18 [Store BL relative]
8061:      STAB  B8074      ; =+17 [Store AL relative]
8063:      LDA=  W806C      ; =0x806c =32876(-32660) [Load A with immediate]
8066:      STA+  Z,6        ; [Store A indexed, displaced, direct]
8069:D8069 LDX+  S+         ; [Load X indexed, direct, post-incremented]
806b:      RSR              ; [Return from subroutine]
*
806c:W806C DW    X'0008'    ; =0x0008 =8
806e:      DB    X'8B'      ; =0x8b =139(-117) =VT
806f:B806F DW    X'00FF'    ; =0x00ff =255
8071:      DW    X'9B85'    ; =0x9b85 =39813(-25723)
8073:B8073 DB    X'00'      ; =0x00 =0 =NUL
8074:B8074 DW    X'00FF'    ; =0x00ff =255
8076:ENDPT
