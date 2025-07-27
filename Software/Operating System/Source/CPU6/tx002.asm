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
8000:ENTRY XFRB  AL,AL      ; [Transfer AL to AL]
8002:      BM    D8045      ; =+65 [Branch on minus]
8004:      LDX/  X'005A'    ; =0x005a =90 [Load X direct]
8007:      CLRB  AU         ; [Clear AU]
8009:      ADD   A,S        ; [A + S -> S]
800b:      CLA              ; [Clear A]
800c:      DCA              ; [Decrement A]
800d:      STA   W803E+1    ; =+48 [Store A relative]
800f:      STAB+ X,28       ; [Store AL indexed, displaced, direct]
8012:      STAB+ X,59       ; [Store AL indexed, displaced, direct]
8015:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8017:      STA   W801B      ; =+2 [Store A relative]
8019:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
801b:W801B DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
801d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
801f:      STA   W8023      ; =+2 [Store A relative]
8021:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8023:W8023 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
8025:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8027:J8027 LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8029:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802b:      XAY              ; [Transfer A to Y]
802c:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
802e:      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8030:      XFR   S,A        ; [Transfer S to A]
8032:      XFR   B,S        ; [Transfer B to S]
8034:      LDB=  X'0064'    ; =0x0064 =100 [Load B with immediate]
8037:      SAB              ; [A - B -> B]
8038:      STB   W803C      ; =+2 [Store B relative]
803a:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
803c:W803C DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
803e:W803E LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8041:      SVC   X'01'      ; =1 [Service call TRTN - transient return]
8043:      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
8045:D8045 LDAB+ S,17       ; [Load AL indexed, displaced, direct]
8048:      STAB/ B80D1      ; =0x80d1 =32977(-32559) [Store AL direct]
804b:      INR   S,3        ; [Increment S by 3]
804d:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
804f:      STA   W80A1+1    ; =+81 [Store A relative]
8051:      INR   S,6        ; [Increment S by 6]
8053:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8055:      STA   W8059      ; =+2 [Store A relative]
8057:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8059:W8059 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
805b:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
805d:      STA   W8061      ; =+2 [Store A relative]
805f:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
8061:W8061 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
8063:      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8065:      STA   W80CF      ; =+104 [Store A relative]
8067:      STA   W80C6      ; =+93 [Store A relative]
8069:      LDA+  A          ; [Load A from address in A]
806a:      LDAB+ A,5        ; [Load AL indexed, displaced, direct]
806d:      LDBB= X'10'      ; =16 [Load BL with immediate]
806f:      NABB             ; [AL & BL -> BL]
8070:      BZ    D80B8      ; =+70 [Branch if zero]
8072:      SVC   X'06'      ; =6 [Service call FLWT - wait for flag to go positive]
8074:      DB    X'3B'      ; =0x3b =59 [TODO: arg 1]
8075:      LDA+  X,29       ; [Load A indexed, displaced, direct]
8078:      STA   W80D4      ; =+90 [Store A relative]
807a:      XAY              ; [Transfer A to Y]
807b:      FIL   (200)=X'00',-Y ; [Fill with byte, literal=0, indexed]
8080:      FIL   (200)=X'00',-Y,200 ; [Fill with byte, literal=0, displaced indexed]
8087:      LDB   W80C6      ; =+61 [Load B relative]
8089:      LDB+  B          ; [Load B from address in B]
808a:      LDAB+ B,5        ; [Load AL indexed, displaced, direct]
808d:      LDB=  X'000F'    ; =0x000f =15 [Load B with immediate]
8090:      AND   B,A        ; [B & A -> A]
8092:      SLA              ; [Left shift A]
8093:      LDB=  W80D8      ; =0x80d8 =32984(-32552) [Load B with immediate]
8096:      AAB              ; [A + B -> B]
8097:      LDA+  B          ; [Load A from address in B]
8098:      STA+  Y          ; [Store A to address in Y]
8099:      LDA/  W80C6      ; =0x80c6 =32966(-32570) [Load A direct]
809c:      LDA+  A          ; [Load A from address in A]
809d:      LDA+  A,2        ; [Load A indexed, displaced, direct]
80a0:      INA              ; [Increment A]
80a1:W80A1 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
80a4:      SAB              ; [A - B -> B]
80a5:      STB   B80D1+1    ; =+43 [Store B relative]
80a7:D80A7 JSR   F80CB      ; =+34 [Jump to subroutine relative]
80a9:      INC/  B80D1+1    ; =0x80d2 =32978(-32558) [Increment word at address by 1]
80ad:      DEC/  W80A1+1    ; =0x80a2 =32930(-32606) [Decrement word at address by 1]
80b1:      BNZ   D80A7      ; =-12 [Branch if not zero]
80b3:      CLAB             ; [Clear AL]
80b4:      DCAB             ; [Decrement AL]
80b5:      STAB+ X,59       ; [Store AL indexed, displaced, direct]
80b8:D80B8 CAD/  W803E+1    ; [Clear word at address]
80bc:      LDX/  X'005A'    ; =0x005a =90 [Load X direct]
80bf:      CLAB             ; [Clear AL]
80c0:      DCAB             ; [Decrement AL]
80c1:      STAB+ X,28       ; [Store AL indexed, displaced, direct]
80c4:      SVC   X'17'      ; =23 [Service call RMEM - release memory block back to transient area]
80c6:W80C6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
80c8:      JMP/  J8027      ; =0x8027 =32807(-32729) [Jump direct]
*
* Function F80CB
*
80cb:F80CB SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
80cd:      DW    X'0190'    ; =0x0190 =400
80cf:W80CF DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg1]
80d1:B80D1 DW    X'FF00'    ; =0xff00 =65280(-256) [TODO: arg2]
80d3:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
80d4:W80D4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg4]
80d6:      DB    X'02'      ; =0x02 =2 [TODO: arg5]
80d7:      RSR              ; [Return from subroutine]
*
80d8:W80D8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80da:      DW    X'848D'    ; =0x848d =33933(-31603) =EOT,CR
80dc:      DW    X'848D'    ; =0x848d =33933(-31603) =EOT,CR
80de:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80e0:      DW    X'848D'    ; =0x848d =33933(-31603) =EOT,CR
80e2:      DB    0,8        ; =0x00,0x0008
80ea:ENDPT
