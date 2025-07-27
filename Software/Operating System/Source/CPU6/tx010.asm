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
8000:ENTRY XFR   A,A        ; [Transfer A to A]
8002:      BNZ   D801D      ; =+25 [Branch if not zero]
8004:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8007:      LDA+  A,3        ; [Load A indexed, displaced, direct]
800a:      LDA+  A,25       ; [Load A indexed, displaced, direct]
800d:      BZ    D8014      ; =+5 [Branch if zero]
800f:      LDBB= X'02'      ; =2 [Load BL with immediate]
8011:      STBB+ A,6        ; [Store BL indexed, displaced, direct]
8014:D8014 JSR   F807C      ; =+102 [Jump to subroutine relative]
8016:      FIL   (4)=X'00',-A ; [Fill with byte, literal=0, indexed]
801b:      JMP   D8078      ; =+91 [Jump relative]
801d:D801D DCA              ; [Decrement A]
801e:      LDB=  X'FA4B'    ; =0xfa4b =64075(-1461) [Load B with immediate]
8021:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8023:      LDX=  X'FFFF'    ; =0xffff =65535(-1) [Load X with immediate]
8026:D8026 INX              ; [Increment X]
8027:      ADD   B,A        ; [B + A -> A]
8029:      BL    D8026      ; =-5 [Branch on link]
802b:      SAB              ; [A - B -> B]
802c:      SLR   X,2        ; [Left shift X by 2]
802e:      LDAB= X'E3'      ; =227(-29) ='c' [Load AL with immediate]
8030:      STAB/ S80B8      ; =0x80b8 =32952(-32584) [Store AL direct]
8033:      LDA=  X'FE93'    ; =0xfe93 =65171(-365) [Load A with immediate]
8036:      AAB              ; [A + B -> B]
8037:      BLE   D8045      ; =+12 [Branch if less than or equal to zero]
8039:      LDAB= X'E4'      ; =228(-28) ='d' [Load AL with immediate]
803b:      STAB  S80B8      ; =+123 [Store AL relative]
803d:      LDAB= X'93'      ; =147(-109) [Load AL with immediate]
803f:      DCR   B          ; [Decrement B by 1]
8041:D8041 INX              ; [Increment X]
8042:      AAB              ; [A + B -> B]
8043:      BP    D8041      ; =-4 [Branch on plus]
8045:D8045 SUB   B,A        ; [B - A -> A]
8047:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8049:      STX   W8068+1    ; =+30 [Store X relative]
804b:      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
804e:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8050:      LDX=  S80B7      ; =0x80b7 =32951(-32585) [Load X with immediate]
8053:D8053 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8055:      AAB              ; [A + B -> B]
8056:      BL    D8053      ; =-5 [Branch on link]
8058:      SUB   B,A        ; [B - A -> A]
805a:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
805c:      LDA=  S80B7      ; =0x80b7 =32951(-32585) [Load A with immediate]
805f:      SUB   X,A        ; [X - A -> A]
8061:      CLR   B          ; [Clear B]
8063:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8065:      INX              ; [Increment X]
8066:      JSR   F809B      ; =+51 [Jump to subroutine relative]
8068:W8068 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
806b:      JSR   F809B      ; =+46 [Jump to subroutine relative]
806d:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
806f:      STK   A,2        ; [Push A to the stack]
8071:      JSR   F807C      ; =+9 [Jump to subroutine relative]
8073:      STB+  A+         ; [Store B indexed, direct, post-incremented]
8075:      POP   B,2        ; [Pop B from the stack]
8077:      STB+  A          ; [Store B to address in A]
8078:D8078 SVC   X'01'      ; =1 [Service call TRTN - transient return]
807a:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
* Function F807C
*
807c:F807C STX   W8098+1    ; =+27 [Store X relative]
807e:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8080:      STK   B,2        ; [Push B to the stack]
8082:      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8084:      SUB=  X'7FFF',X,B ; =0x7fff =32767 [32767 - X -> B]
8088:      BL    D8096      ; =+12 [Branch on link]
808a:      SUB=  X'7FFF',A,B ; =0x7fff =32767 [32767 - A -> B]
808e:      BNL   D8096      ; =+6 [Branch on no link]
8090:      XAB              ; [Transfer A to B]
8091:      XFR   X,A        ; [Transfer X to A]
8093:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8095:      DB    X'17'      ; =0x17 =23 [abort code]
*
8096:D8096 POP   B,2        ; [Pop B from the stack]
8098:W8098 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
*
* Function F809B
*
809b:F809B STX-  S-         ; [Store X indexed, pre-decremented, direct]
809d:      XAX              ; [Transfer A to X]
809e:      SLR   A,3        ; [Left shift A by 3]
80a0:      ADD   A,X        ; [A + X -> X]
80a2:      SLA              ; [Left shift A]
80a3:      ADD   X,A        ; [X + A -> A]
80a5:      SLA              ; [Left shift A]
80a6:      RLR   B          ; [Left rotate B by 1]
80a8:      SLA              ; [Left shift A]
80a9:      RLR   B          ; [Left rotate B by 1]
80ab:      LDX+  S,2        ; [Load X indexed, displaced, direct]
80ae:      ADD   X,A        ; [X + A -> A]
80b0:      BNL   D80B4      ; =+2 [Branch on no link]
80b2:      INR   B          ; [Increment B by 1]
80b4:D80B4 LDX+  S+         ; [Load X indexed, direct, post-incremented]
80b6:      RSR              ; [Return from subroutine]
*
80b7:S80B7 DC    'a'        ; hex:e1 dec:225(-31)
80b8:S80B8 DC    'dababaababa'
80c3:ENDPT
