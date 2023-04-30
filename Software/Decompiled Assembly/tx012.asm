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
8000:ENTRY CLA              ; [Clear A]
8001:      DCA              ; [Decrement A]
8002:      STA   W8041      ; =+61 [Store A relative]
8004:      SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
8006:      DB    X'3B'      ; =0x3b =59 [TODO: arg 1]
8007:      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8009:      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800b:      SVC   X'0C'      ; =12 [Service call PGIOB - protected get I/O block]
800d:      XFR   B,X        ; [Transfer B to X]
800f:      BNZ   D8014      ; =+3 [Branch if not zero]
8011:      SVC   X'09'      ; =9 [Service call ABRT - abort task]
8013:      DB    X'0A'      ; =0x0a =10 [abort code]
*
8014:D8014 LDAB+ A,2        ; [Load AL indexed, displaced, direct]
8017:      STAB  B8030+1    ; =+24 [Store AL relative]
8019:      LDX+  X          ; [Load X indexed, direct]
801b:      MVF   (10)-X,30,/S8078 ; =0x8078 =32888(-32648) [Move fixed-length, displaced indexed, direct]
8022:      LDB+  X,6        ; [Load B indexed, displaced, direct]
8025:      LDA/  X'011D'    ; =0x011d =285 [Load A direct]
8028:      STA   W8034      ; =+10 [Store A relative]
802a:      STA   W8045      ; =+25 [Store A relative]
802c:      STB   W8043      ; =+21 [Store B relative]
802e:      BZ    D803A      ; =+10 [Branch if zero]
8030:B8030 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8032:      SVC   X'50'      ; =80 [Service call DIRE - locate directory entry specified]
8034:W8034 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 1]
8036:      STA   W8043      ; =+11 [Store A relative]
8038:      BZ    D805B      ; =+33 [Branch if zero]
803a:D803A LDAB  B8030+1    ; =-11 [Load AL relative]
803c:      LDB=  S8078      ; =0x8078 =32888(-32648) [Load B with immediate]
803f:      SVC   X'51'      ; =81 [Service call DIRD - set date of file or subfile]
8041:W8041 DW    X'FFFF'    ; =0xffff =65535(-1) [TODO: arg 1]
8043:W8043 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 2]
8045:W8045 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg 3]
8047:      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8049:      LDA   W8043      ; =-8 [Load A relative]
804b:      BZ    D8053      ; =+6 [Branch if zero]
804d:      STA   W8051      ; =+2 [Store A relative]
804f:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8051:W8051 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
*
8053:D8053 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8055:      BZ    D805B      ; =+4 [Branch if zero]
8057:      LDA   W8041      ; =-24 [Load A relative]
8059:      BNZ   D805F      ; =+4 [Branch if not zero]
805b:D805B LDAB= X'02'      ; =2 [Load AL with immediate]
805d:      JMP   D8060      ; =+1 [Jump relative]
805f:D805F CLAB             ; [Clear AL]
8060:D8060 LDB/  X'0103'    ; =0x0103 =259 [Load B direct]
8063:      LDB+  B,25       ; [Load B indexed, displaced, direct]
8066:      BZ    D806B      ; =+3 [Branch if zero]
8068:      STAB+ B,6        ; [Store AL indexed, displaced, direct]
806b:D806B CLAB             ; [Clear AL]
806c:      DCAB             ; [Decrement AL]
806d:      STAB/ X'013B'    ; =0x013b =315 [Store AL direct]
8070:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8072:      LDA   W8041      ; =-51 [Load A relative]
8074:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
8076:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
8078:S8078 DB    0,10       ; =0x00,0x000a
8082:ENDPT
