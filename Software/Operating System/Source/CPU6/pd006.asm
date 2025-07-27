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
800c:      DW    X'019B'    ; =0x019b =411
800e:      DW    X'0189'    ; =0x0189 =393
8010:      DW    X'049A'    ; =0x049a =1178
8012:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8014:D8014 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8016:      LDX+  Z,6        ; [Load X indexed, displaced, direct]
8019:      INR   X,2        ; [Increment X by 2]
801b:      LDA+  X          ; [Load A from address in X]
801c:      LDB=  X'9BB1'    ; =0x9bb1 =39857(-25679) [Load B with immediate]
801f:      SAB              ; [A - B -> B]
8020:      BNZ   D803A      ; =+24 [Branch if not zero]
8022:      JSR   F8047      ; =+35 [Jump to subroutine relative]
8024:      LDAB+ X,3        ; [Load AL indexed, displaced, direct]
8027:      DCAB             ; [Decrement AL]
8028:      STAB/ B80C7      ; =0x80c7 =32967(-32569) [Store AL direct]
802b:      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
802e:      DCAB             ; [Decrement AL]
802f:      STAB/ B80C6      ; =0x80c6 =32966(-32570) [Store AL direct]
8032:      LDA=  W80C2      ; =0x80c2 =32962(-32574) [Load A with immediate]
8035:D8035 STA+  Z,6        ; [Store A indexed, displaced, direct]
8038:      JMP   D806E      ; =+52 [Jump relative]
803a:D803A LDAB= X'8C'      ; =140(-116) =FF [Load AL with immediate]
803c:      SUBB  AL,AU      ; [AL - AU -> AU]
803e:      BNZ   D806E      ; =+46 [Branch if not zero]
8040:      JSR   F8047      ; =+5 [Jump to subroutine relative]
8042:      LDA=  W80C9      ; =0x80c9 =32969(-32567) [Load A with immediate]
8045:      JMP   D8035      ; =-18 [Jump relative]
*
* Function F8047
*
8047:F8047 STK   X,6        ; [Push X Y Z to the stack]
8049:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
804c:      LDA+  A,110      ; [Load A indexed, displaced, direct]
804f:      DCA              ; [Decrement A]
8050:      XAZ              ; [Transfer A to Z]
8051:      LDX=  X'0008'    ; =0x0008 =8 [Load X with immediate]
8054:D8054 INR   Z          ; [Increment Z by 1]
8056:      DCX              ; [Decrement X]
8057:      BZ    D806B      ; =+18 [Branch if zero]
8059:      LDA+  Z+         ; [Load A indexed, direct, post-incremented]
805b:      LDB+  Y,29       ; [Load B indexed, displaced, direct]
805e:      SAB              ; [A - B -> B]
805f:      BNZ   D8054      ; =-13 [Branch if not zero]
8061:D8061 LDAB+ Z          ; [Load AL from address in Z]
8062:      BZ    D8068      ; =+4 [Branch if zero]
8064:      SVC   X'07'      ; =7 [Service call WT - unconditional wait]
8066:      JMP   D8061      ; =-7 [Jump relative]
8068:D8068 CLA              ; [Clear A]
8069:      DCA              ; [Decrement A]
806a:      STAB+ Z          ; [Store AL to address in Z]
806b:D806B POP   X,6        ; [Pop Z Y X from the stack]
806d:      RSR              ; [Return from subroutine]
*
806e:D806E XFR   Y,A        ; [Transfer Y to A]
8070:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8072:      XFR   Z,A        ; [Transfer Z to A]
8074:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8076:      LDB+  Z,6        ; [Load B indexed, displaced, direct]
8079:      XFR   B,Y        ; [Transfer B to Y]
807b:      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
807d:      INR   X,3        ; [Increment X by 3]
807f:      LDA=  X'9BB0'    ; =0x9bb0 =39856(-25680) [Load A with immediate]
8082:D8082 LDB+  Y          ; [Load B from address in Y]
8083:      INR   Y          ; [Increment Y by 1]
8085:      SAB              ; [A - B -> B]
8086:      BNZ   D80B3      ; =+43 [Branch if not zero]
8088:      INR   Y          ; [Increment Y by 1]
808a:      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
808c:      DCX              ; [Decrement X]
808d:      LDB=  W80D6      ; =0x80d6 =32982(-32554) [Load B with immediate]
8090:      XFR   B,Z        ; [Transfer B to Z]
8092:D8092 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
8094:      BZ    D80A8      ; =+18 [Branch if zero]
8096:      SABB             ; [AL - BL -> BL]
8097:      BZ    D809B      ; =+2 [Branch if zero]
8099:      JMP   D8092      ; =-9 [Jump relative]
809b:D809B XFRB  BU,BL      ; [Transfer BU to BL]
809d:      CLRB  BU         ; [Clear BU]
809f:      DCR   B          ; [Decrement B by 1]
80a1:      SLR   B          ; [Left shift B by 1]
80a3:      ADD=  W80CD,B    ; =0x80cd =32973(-32563) [32973 + B -> B]
80a7:      LDA+  B          ; [Load A from address in B]
80a8:D80A8 STA+  Y,-3       ; [Store A indexed, displaced, direct]
80ab:      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
80ad:      STAB+ Y,-1       ; [Store AL indexed, displaced, direct]
80b0:      LDA=  X'9BB0'    ; =0x9bb0 =39856(-25680) [Load A with immediate]
80b3:D80B3 DCX              ; [Decrement X]
80b4:      BM    D80B8      ; =+2 [Branch on minus]
80b6:      JMP   D8082      ; =-54 [Jump relative]
80b8:D80B8 LDA+  S+         ; [Load A indexed, direct, post-incremented]
80ba:      XAZ              ; [Transfer A to Z]
80bb:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
80bd:      XAY              ; [Transfer A to Y]
80be:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
80c0:      XAX              ; [Transfer A to X]
80c1:      RSR              ; [Return from subroutine]
*
80c2:W80C2 DW    X'0005'    ; =0x0005 =5
80c4:      DW    X'9B91'    ; =0x9b91 =39825(-25711)
80c6:B80C6 DB    X'00'      ; =0x00 =0 =NUL
80c7:B80C7 DW    X'00FF'    ; =0x00ff =255
80c9:W80C9 DW    X'0002'    ; =0x0002 =2
80cb:      DW    X'9B9C'    ; =0x9b9c =39836(-25700)
80cd:W80CD DW    X'9B99'    ; =0x9b99 =39833(-25703)
80cf:      DW    X'9B9F'    ; =0x9b9f =39839(-25697)
80d1:      DW    X'9B91'    ; =0x9b91 =39825(-25711)
80d3:      DW    X'9B82'    ; =0x9b82 =39810(-25726)
80d5:      DB    X'00'      ; =0x00 =0 =NUL
80d6:W80D6 DB    X'01'      ; =0x01 =1
80d7:      DC    '@'        ; hex:c0 dec:192(-64)
80d8:      DB    X'02'      ; =0x02 =2
80d9:      DC    '`'        ; hex:e0 dec:224(-32)
80da:      DB    X'02'      ; =0x02 =2
80db:      DC    'P'        ; hex:d0 dec:208(-48)
80dc:      DB    X'02'      ; =0x02 =2
80dd:      DC    'p'        ; hex:f0 dec:240(-16)
80de:      DB    X'03'      ; =0x03 =3
80df:      DC    'R'        ; hex:d2 dec:210(-46)
80e0:      DB    X'03'      ; =0x03 =3
80e1:      DC    'r'        ; hex:f2 dec:242(-14)
80e2:      DB    X'03'      ; =0x03 =3
80e3:      DC    'B'        ; hex:c2 dec:194(-62)
80e4:      DB    X'03'      ; =0x03 =3
80e5:      DC    'b'        ; hex:e2 dec:226(-30)
80e6:      DB    X'01'      ; =0x01 =1
80e7:      DC    'A'        ; hex:c1 dec:193(-63)
80e8:      DB    X'03'      ; =0x03 =3
80e9:      DC    'C'        ; hex:c3 dec:195(-61)
80ea:      DB    X'01'      ; =0x01 =1
80eb:      DC    'Q'        ; hex:d1 dec:209(-47)
80ec:      DB    X'03'      ; =0x03 =3
80ed:      DC    'S'        ; hex:d3 dec:211(-45)
80ee:      DB    X'01'      ; =0x01 =1
80ef:      DC    'q'        ; hex:f1 dec:241(-15)
80f0:      DB    X'03'      ; =0x03 =3
80f1:      DC    's'        ; hex:f3 dec:243(-13)
80f2:      DB    X'01'      ; =0x01 =1
80f3:      DC    'a'        ; hex:e1 dec:225(-31)
80f4:      DB    X'03'      ; =0x03 =3
80f5:      DC    'c'        ; hex:e3 dec:227(-29)
80f6:      DB    X'04'      ; =0x04 =4
80f7:      DC    'D'        ; hex:c4 dec:196(-60)
80f8:      DB    X'04'      ; =0x04 =4
80f9:      DC    'T'        ; hex:d4 dec:212(-44)
80fa:      DB    X'00'      ; =0x00 =0 =NUL
80fb:      DB    X'00'      ; =0x00 =0 =NUL
80fc:ENDPT
