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
8000:ENTRY XAB              ; [Transfer A to B]
8001:      BNZ   D801E      ; =+27 [Branch if not zero]
8003:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8006:      LDA+  A,3        ; [Load A indexed, displaced, direct]
8009:      LDA+  A,25       ; [Load A indexed, displaced, direct]
800c:      BZ    D8013      ; =+5 [Branch if zero]
800e:      LDBB= X'02'      ; =2 [Load BL with immediate]
8010:      STBB+ A,6        ; [Store BL indexed, displaced, direct]
8013:D8013 JSR   F8087      ; =+114 [Jump to subroutine relative]
8015:      FIL   (8)=' ',-A ; [Fill with byte, literal=0xa0(160,-96), indexed]
801a:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
801c:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
801e:D801E DCA              ; [Decrement A]
801f:      LDB=  X'FA4B'    ; =0xfa4b =64075(-1461) [Load B with immediate]
8022:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8024:      LDX=  X'FFFF'    ; =0xffff =65535(-1) [Load X with immediate]
8027:D8027 INX              ; [Increment X]
8028:      ADD   B,A        ; [B + A -> A]
802a:      BL    D8027      ; =-5 [Branch on link]
802c:      SAB              ; [A - B -> B]
802d:      SLR   X,2        ; [Left shift X by 2]
802f:      LDAB= X'E3'      ; =227(-29) ='c' [Load AL with immediate]
8031:      STAB/ S80B4      ; =0x80b4 =32948(-32588) [Store AL direct]
8034:      LDA=  X'FE93'    ; =0xfe93 =65171(-365) [Load A with immediate]
8037:      AAB              ; [A + B -> B]
8038:      BLE   D8046      ; =+12 [Branch if less than or equal to zero]
803a:      LDAB= X'E4'      ; =228(-28) ='d' [Load AL with immediate]
803c:      STAB  S80B4      ; =+118 [Store AL relative]
803e:      LDAB= X'93'      ; =147(-109) [Load AL with immediate]
8040:      DCR   B          ; [Decrement B by 1]
8042:D8042 INX              ; [Increment X]
8043:      AAB              ; [A + B -> B]
8044:      BP    D8042      ; =-4 [Branch on plus]
8046:D8046 SUB   B,A        ; [B - A -> A]
8048:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
804a:      JSR   F80A6      ; =+90 [Jump to subroutine relative]
804c:      LDA+  *S,2       ; [Load A indexed, displaced, indirect]
804f:      STB+  A,6        ; [Store B indexed, displaced, direct]
8052:      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8055:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8057:      LDX=  S80B3      ; =0x80b3 =32947(-32589) [Load X with immediate]
805a:D805A LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
805c:      AAB              ; [A + B -> B]
805d:      BL    D805A      ; =-5 [Branch on link]
805f:      SUBB  BL,AL      ; [BL - AL -> AL]
8061:      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8063:      LDA=  S80B3      ; =0x80b3 =32947(-32589) [Load A with immediate]
8066:      SUB   X,A        ; [X - A -> A]
8068:      XAX              ; [Transfer A to X]
8069:      JSR   F80A6      ; =+59 [Jump to subroutine relative]
806b:      LDA+  *S,1       ; [Load A indexed, displaced, indirect]
806e:      STB+  A          ; [Store B to address in A]
806f:      CLA              ; [Clear A]
8070:      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8072:      INA              ; [Increment A]
8073:      XAX              ; [Transfer A to X]
8074:      JSR   F80A6      ; =+48 [Jump to subroutine relative]
8076:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8078:      JSR   F8087      ; =+13 [Jump to subroutine relative]
807a:      STB+  A+,3       ; [Store B indexed, displaced, direct, post-incremented]
807d:      LDBB= X'AF'      ; =175(-81) ='/' [Load BL with immediate]
807f:      STBB+ A          ; [Store BL to address in A]
8080:      STBB+ A,3        ; [Store BL indexed, displaced, direct]
8083:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
8085:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
* Function F8087
*
8087:F8087 STX   W80A3+1    ; =+27 [Store X relative]
8089:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
808b:      STK   B,2        ; [Push B to the stack]
808d:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
808f:      SUB=  X'7FFF',X,B ; =0x7fff =32767 [32767 - X -> B]
8093:      BL    D80A1      ; =+12 [Branch on link]
8095:      SUB=  X'7FFF',A,B ; =0x7fff =32767 [32767 - A -> B]
8099:      BNL   D80A1      ; =+6 [Branch on no link]
809b:      XAB              ; [Transfer A to B]
809c:      XFR   X,A        ; [Transfer X to A]
809e:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
80a0:      DB    X'17'      ; =0x17 =23 [abort code]
*
80a1:D80A1 POP   B,2        ; [Pop B from the stack]
80a3:W80A3 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
*
* Function F80A6
*
80a6:F80A6 LDB+  S          ; [Load B from address in S]
80a7:      LDAB= X'F6'      ; =246(-10) ='v' [Load AL with immediate]
80a9:D80A9 INRB  BU         ; [Increment BU by 1]
80ab:      AABB             ; [AL + BL -> BL]
80ac:      BL    D80A9      ; =-5 [Branch on link]
80ae:      LDA=  X'AEBA'    ; =0xaeba =44730(-20806) ='.',':' [Load A with immediate]
80b1:      AAB              ; [A + B -> B]
80b2:      RSR              ; [Return from subroutine]
*
80b3:S80B3 DC    'a'        ; hex:e1 dec:225(-31)
80b4:S80B4 DC    'dababaababa'
80bf:ENDPT
