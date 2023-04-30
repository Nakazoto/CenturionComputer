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
8000:ENTRY STK   X,6        ; [Push X Y Z to the stack]
8002:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8004:      STB   W8047+1    ; =+66 [Store B relative]
8006:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8008:      STB/  W80AF      ; =0x80af =32943(-32593) [Store B direct]
800b:      BZ    D801D      ; =+16 [Branch if zero]
800d:      SUB=  X'7FFF',B  ; =0x7fff =32767 [32767 - B -> B]
8011:      BNL   D801D      ; =+10 [Branch on no link]
8013:      LDB/  W80AF      ; =0x80af =32943(-32593) [Load B direct]
8016:      XFR   X,A        ; [Transfer X to A]
8018:      DCR   A,2        ; [Decrement A by 2]
801a:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
801c:      DB    X'17'      ; =0x17 =23 [abort code]
*
801d:D801D LDB+  X+         ; [Load B indexed, direct, post-incremented]
801f:      XFRB  BU,AL      ; [Transfer BU to AL]
8021:      BZ    D8029      ; =+6 [Branch if zero]
8023:      INAB             ; [Increment AL]
8024:      BZ    D8029      ; =+3 [Branch if zero]
8026:      LDB+  B,2        ; [Load B indexed, displaced, direct]
8029:D8029 STB/  W80B3      ; =0x80b3 =32947(-32589) [Store B direct]
802c:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
802f:      LDA+  A,3        ; [Load A indexed, displaced, direct]
8032:      LDBB+ A,27       ; [Load BL indexed, displaced, direct]
8035:      STBB  B8077+1    ; =+65 [Store BL relative]
8037:      LDB+  A,28       ; [Load B indexed, displaced, direct]
803a:      STB   W8079+1    ; =+62 [Store B relative]
803c:      MVF   (10)-A,30,/W80DA ; =0x80da =32986(-32550) [Move fixed-length, displaced indexed, direct]
8043:      XFR=  W80DA,Z    ; =0x80da =32986(-32550) [Transfer immediate to Z]
8047:W8047 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
804a:      XAY              ; [Transfer A to Y]
804b:      LDX=  X'000A'    ; =0x000a =10 [Load X with immediate]
804e:D804E LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8050:      BZ    D805F      ; =+13 [Branch if zero]
8052:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8054:      SABB             ; [AL - BL -> BL]
8055:      BNZ   D8058      ; =+1 [Branch if not zero]
8057:      LDAB+ Z          ; [Load AL from address in Z]
8058:D8058 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
805a:      DCX              ; [Decrement X]
805b:      BGZ   D804E      ; =-15 [Branch if greater than zero]
805d:      JMP   D8066      ; =+7 [Jump relative]
805f:D805F LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8061:D8061 STAB+ Z+         ; [Store AL indexed, direct, post-incremented]
8063:      DCX              ; [Decrement X]
8064:      BGZ   D8061      ; =-5 [Branch if greater than zero]
8066:D8066 JSR/  F8118      ; =0x8118 =33048(-32488) [Jump to subroutine direct]
8069:      DW    W80DA      ; =0x80da =32986(-32550)
806b:      XFR/  X'005A',Z  ; =0x005a =90 [Transfer direct to Z]
806f:      SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
8071:      DB    X'3B'      ; =0x3b =59 [TODO: arg 1]
8072:      LDA+  Z,29       ; [Load A indexed, displaced, direct]
8075:      STA   W8080      ; =+9 [Store A relative]
8077:B8077 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8079:W8079 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
807c:      SVC   X'64'      ; =100 [Service call DIRLF - create FCB for file in private library]
807e:      DW    W80DA      ; =0x80da =32986(-32550) [TODO: arg1]
8080:W8080 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg2]
8082:      BNZ   D80A1      ; =+29 [Branch if not zero]
8084:      JSR   F80D4      ; =+78 [Jump to subroutine relative]
8086:      LDB+  Z,3        ; [Load B indexed, displaced, direct]
8089:      LDB+  B,25       ; [Load B indexed, displaced, direct]
808c:      BZ    D8093      ; =+5 [Branch if zero]
808e:      LDAB= X'04'      ; =4 [Load AL with immediate]
8090:      STAB+ B,6        ; [Store AL indexed, displaced, direct]
8093:D8093 POP   X,6        ; [Pop Z Y X from the stack]
8095:      INR   X,6        ; [Increment X by 6]
8097:      CLA              ; [Clear A]
8098:      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
809a:      SLA              ; [Left shift A]
809b:      ADD   A,X        ; [A + X -> X]
809d:D809D SVC   X'01'      ; =1 [Service call TRTN - transient return]
809f:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
80a1:D80A1 LDB   W80B3      ; =+16 [Load B relative]
80a3:      BNZ   D80A9      ; =+4 [Branch if not zero]
80a5:      XFR=  F8118,S    ; =0x8118 =33048(-32488) [Transfer immediate to S]
80a9:D80A9 JSR   F80D4      ; =+41 [Jump to subroutine relative]
80ab:      LDBB  B8077+1    ; =-53 [Load BL relative]
80ad:      SVC   X'03'      ; =3 [Service call LODF - load FCB specified]
80af:W80AF DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
80b1:      DW    X'0190'    ; =0x0190 =400 [TODO: arg2]
80b3:W80B3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg3]
80b5:      BZ    D80CA      ; =+19 [Branch if zero]
80b7:      DCA              ; [Decrement A]
80b8:      BZ    D80C0      ; =+6 [Branch if zero]
80ba:      POP   X,6        ; [Pop Z Y X from the stack]
80bc:      INR   X,7        ; [Increment X by 7]
80be:      JMP   D809D      ; =-35 [Jump relative]
80c0:D80C0 POP   X,6        ; [Pop Z Y X from the stack]
80c2:      INR   X,7        ; [Increment X by 7]
80c4:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
80c6:      XFR   B,X        ; [Transfer B to X]
80c8:      JMP   D809D      ; =-45 [Jump relative]
80ca:D80CA LDA=  X'800B'    ; =0x800b =32779(-32757) [Load A with immediate]
80cd:      XAS              ; [Transfer A to S]
80ce:      CLA              ; [Clear A]
80cf:      STA+  S          ; [Store A to address in S]
80d0:      XFR   B,X        ; [Transfer B to X]
80d2:      JMP   D809D      ; =-55 [Jump relative]
*
* Function F80D4
*
80d4:F80D4 LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
80d6:      STBB+ Z,59       ; [Store BL indexed, displaced, direct]
80d9:      RSR              ; [Return from subroutine]
*
80da:W80DA DS    10         ; =0x000a [Uninitialized memory]
80e4:      DB    X'00'      ; =0x00 =0 =NUL
80e5:      DS    50         ; =0x0032 [Uninitialized memory]
8117:      DB    X'00'      ; =0x00 =0 =NUL
*
* Function F8118
*
8118:F8118 LDA+  X+         ; [Load A indexed, direct, post-incremented]
811a:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
811c:      XAX              ; [Transfer A to X]
811d:D811D LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
811f:      BZ    D8134      ; =+19 [Branch if zero]
8121:      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
8123:      SABB             ; [AL - BL -> BL]
8124:      BM    D811D      ; =-9 [Branch on minus]
8126:      LDBB= X'FB'      ; =251(-5) ='{' [Load BL with immediate]
8128:      SABB             ; [AL - BL -> BL]
8129:      BP    D811D      ; =-14 [Branch on plus]
812b:      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
812d:      ANDB  BL,AL      ; [BL & AL -> AL]
812f:      STAB+ X,-1       ; [Store AL indexed, displaced, direct]
8132:      JMP   D811D      ; =-23 [Jump relative]
8134:D8134 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8136:      RSR              ; [Return from subroutine]
*
8137:ENDPT
