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
8000:ENTRY STA   W8077      ; =+117 [Store A relative]
8002:      STA/  W8086      ; =0x8086 =32902(-32634) [Store A direct]
8005:      BNZ   D800E      ; =+7 [Branch if not zero]
8007:D8007 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8009:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800b:      JMP/  J809C      ; =0x809c =32924(-32612) [Jump direct]
800e:D800E INA              ; [Increment A]
800f:      BZ    D8007      ; =-10 [Branch if zero]
8011:      LDB/  X'005A'    ; =0x005a =90 [Load B direct]
8014:      LDAB+ B,28       ; [Load AL indexed, displaced, direct]
8017:      BM    D801F      ; =+6 [Branch on minus]
8019:      LDA   W8077      ; =+92 [Load A relative]
801b:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
801d:      DW    X'000D'    ; =0x000d =13 [return code]
*
801f:D801F LDA+  B,3        ; [Load A indexed, displaced, direct]
8022:      LDAB+ A,1        ; [Load AL indexed, displaced, direct]
8025:      STAB+ B,28       ; [Store AL indexed, displaced, direct]
8028:      SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
802a:      DB    X'3B'      ; =0x3b =59 [TODO: arg 1]
802b:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
802d:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
802f:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
8031:      XFR   B,X        ; [Transfer B to X]
8033:      BNZ   D8038      ; =+3 [Branch if not zero]
8035:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8037:      DB    X'0A'      ; =0x0a =10 [abort code]
*
8038:D8038 LDAB+ A,2        ; [Load AL indexed, displaced, direct]
803b:      STAB  B8056+1    ; =+26 [Store AL relative]
803d:      LDX+  X          ; [Load X indexed, direct]
803f:      MVF   (10)-X,30,/S80B9 ; =0x80b9 =32953(-32583) [Move fixed-length, displaced indexed, direct]
8046:      LDB+  X,6        ; [Load B indexed, displaced, direct]
8049:      LDA/  X'011D'    ; =0x011d =285 [Load A direct]
804c:      STA   W805A      ; =+12 [Store A relative]
804e:      STA   W807B      ; =+43 [Store A relative]
8050:      STA   W808A      ; =+56 [Store A relative]
8052:      STB   W8088      ; =+52 [Store B relative]
8054:      BZ    D807F      ; =+41 [Branch if zero]
8056:B8056 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8058:      SVC   X'50'      ; =80 [Service call DIRE - locate directory entry specified]
805a:W805A DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 1]
805c:      STA   W8088      ; =+42 [Store A relative]
805e:      BZ    J809C      ; =+60 [Branch if zero]
8060:      LDA+  A          ; [Load A from address in A]
8061:      XAB              ; [Transfer A to B]
8062:      ADD=  X'001E',B  ; =0x001e =30 [30 + B -> B]
8066:      STB   W8070+1    ; =+9 [Store B relative]
8068:      LDA+  A,41       ; [Load A indexed, displaced, direct]
806b:      LDB   W8077      ; =+10 [Load B relative]
806d:      SAB              ; [A - B -> B]
806e:      BL    D807F      ; =+15 [Branch on link]
8070:W8070 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
8073:      LDAB  B8056+1    ; =-30 [Load AL relative]
8075:      SVC   X'51'      ; =81 [Service call DIRD - set date of file or subfile]
8077:W8077 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 1]
8079:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 2]
807b:W807B DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 3]
807d:      BZ    D808C      ; =+13 [Branch if zero]
807f:D807F LDAB  B8056+1    ; =-42 [Load AL relative]
8081:      LDB=  S80B9      ; =0x80b9 =32953(-32583) [Load B with immediate]
8084:      SVC   X'51'      ; =81 [Service call DIRD - set date of file or subfile]
8086:W8086 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 1]
8088:W8088 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 2]
808a:W808A DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 3]
*
808c:D808C STA-  S-         ; [Store A indexed, pre-decremented, direct]
808e:      LDA   W8088      ; =-8 [Load A relative]
8090:      BZ    D8098      ; =+6 [Branch if zero]
8092:      STA   W8096      ; =+2 [Store A relative]
8094:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8096:W8096 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8098:D8098 LDA+  S+         ; [Load A indexed, direct, post-incremented]
809a:      BNZ   D80A0      ; =+4 [Branch if not zero]
809c:J809C LDAB= X'02'      ; =2 [Load AL with immediate]
809e:      JMP   D80A1      ; =+1 [Jump relative]
80a0:D80A0 CLAB             ; [Clear AL]
80a1:D80A1 LDB/  X'0103'    ; =0x0103 =259 [Load B direct]
80a4:      LDB+  B,25       ; [Load B indexed, displaced, direct]
80a7:      BZ    D80AC      ; =+3 [Branch if zero]
80a9:      STAB+ B,6        ; [Store AL indexed, displaced, direct]
80ac:D80AC CLAB             ; [Clear AL]
80ad:      DCAB             ; [Decrement AL]
80ae:      STAB/ X'013B'    ; =0x013b =315 [Store AL direct]
80b1:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
80b3:      LDA   W8086      ; =-47 [Load A relative]
80b5:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
80b7:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
80b9:S80B9 DB    0,10       ; =0x00,0x000a
80c3:ENDPT
