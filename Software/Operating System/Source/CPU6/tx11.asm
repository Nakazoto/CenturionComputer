 TITLE '@TX011'
@TX011 BEGIN 0
*
*
* Function ENTRY
*
8000(8000   )ENTRY LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8002(1404   )      BZ    D8008      ; =+4 [Branch if zero]
8004(6607   )      SVC   7          ; =0x07 [Service call WT - unconditional wait]
8006(73F8   )      JMP   ENTRY      ; =-8 [Jump relative]
8008(28     )D8008 INAB             ; [Increment AL]
8009(A3F6   )      STAB  ENTRY+1    ; =-10 [Store AL relative]
800b(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800d(474803+)      MVF   (4)-B,/W80AA ; =0x80aa =32938(-32598) [Move fixed-length, indexed, direct]
8013(90802D )      LDA=  W802B+2    ; =0x802d =32813(-32723) [Load A with immediate]
8016(46037C+)      DRM   =100,/W80AA(4) ; =0x80aa =32938(-32598) [Divide bignums with remainder, literal=0x64, direct]
801c(908068 )      LDA=  W8066+2    ; =0x8068 =32872(-32664) [Load A with immediate]
801f(46037C+)      DRM   =100,/W80AA(4) ; =0x80aa =32938(-32598) [Divide bignums with remainder, literal=0x64, direct]
8025(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8027(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8029(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
802b(900000 )W802B LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
802e(C01C   )      LDBB= X'1C'      ; =28 [Load BL with immediate]
8030(E36D   )      STBB  B809F      ; =+109 [Store BL relative]
8032(C003   )      LDBB= X'03'      ; =3 [Load BL with immediate]
8034(4A     )      NABB             ; [AL & BL -> BL]
8035(1504   )      BNZ   D803B      ; =+4 [Branch if not zero]
8037(C01D   )      LDBB= X'1D'      ; =29 [Load BL with immediate]
8039(E364   )      STBB  B809F      ; =+100 [Store BL relative]
803b(5D     )D803B XAB              ; [Transfer A to B]
803c(39     )      DCA              ; [Decrement A]
803d(3401   )      SRR   A,2        ; [Arithmetic right shift A by 2]
803f(38     )      INA              ; [Increment A]
8040(773201+)      MUL=  X'016D',B  ; =0x016d =365 [365 * B -> B]
8044(58     )      AAB              ; [A + B -> B]
8045(FD     )      STB+  S          ; [Store B to address in S]
8046(9362   )      LDA   W80AA      ; =+98 [Load A relative]
8048(154C   )      BNZ   D8096      ; =+76 [Branch if not zero]
804a(9360   )      LDA   W80AC      ; =+96 [Load A relative]
804c(39     )      DCA              ; [Decrement A]
804d(D0000C )      LDB=  X'000C'    ; =0x000c =12 [Load B with immediate]
8050(59     )      SAB              ; [A - B -> B]
8051(1043   )      BL    D8096      ; =+67 [Branch on link]
8053(60809E )      LDX=  W809E      ; =0x809e =32926(-32610) [Load X with immediate]
8056(5004   )      ADD   A,X        ; [A + X -> X]
8058(3A     )      CLA              ; [Clear A]
8059(8A     )      LDAB+ X          ; [Load AL from address in X]
805a(B5A802 )      STA+  S,2        ; [Store A indexed, displaced, direct]
805d(DD     )      LDB+  S          ; [Load B from address in S]
805e(8542   )D805E LDAB- X-         ; [Load AL indexed, pre-decremented, direct]
8060(1403   )      BZ    D8065      ; =+3 [Branch if zero]
8062(58     )      AAB              ; [A + B -> B]
8063(73F9   )      JMP   D805E      ; =-7 [Jump relative]
8065(FD     )D8065 STB+  S          ; [Store B to address in S]
8066(900000 )W8066 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8069(39     )      DCA              ; [Decrement A]
806a(D5A802 )      LDB+  S,2        ; [Load B indexed, displaced, direct]
806d(59     )      SAB              ; [A - B -> B]
806e(1026   )      BL    D8096      ; =+38 [Branch on link]
8070(38     )      INA              ; [Increment A]
8071(D5A1   )      LDB+  S+         ; [Load B indexed, direct, post-incremented]
8073(5020   )      ADD   B,A        ; [B + A -> A]
8075(C000   )      LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8077(65A1   )D8077 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8079(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
807b(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
807d(91005A )      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8080(950803 )      LDA+  A,3        ; [Load A indexed, displaced, direct]
8083(950819 )      LDA+  A,25       ; [Load A indexed, displaced, direct]
8086(1403   )      BZ    D808B      ; =+3 [Branch if zero]
8088(E50806 )      STBB+ A,6        ; [Store BL indexed, displaced, direct]
808b(95A1   )D808B LDA+  S+         ; [Load A indexed, direct, post-incremented]
808d(2230   )      CLRB  BL         ; [Clear BL]
808f(E18001 )      STBB/ ENTRY+1    ; =0x8001 =32769(-32767) [Store BL direct]
8092(6601   )      SVC   1          ; =0x01 [Service call TRTN - transient return]
8094(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
*
8096(C002   )D8096 LDBB= X'02'      ; =2 [Load BL with immediate]
8098(3A     )      CLA              ; [Clear A]
8099(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
809b(73DA   )      JMP   D8077      ; =-38 [Jump relative]
*
809d(00     )      DB    X'00'      ; =0x00 =0 =NUL
809e(1F     )W809E DB    X'1F'      ; =0x1f =31
809f(1C1F   )B809F DW    X'1C1F'    ; =0x1c1f =7199
80a1(1E1F   )      DW    X'1E1F'    ; =0x1e1f =7711
80a3(1E1F   )      DW    X'1E1F'    ; =0x1e1f =7711
80a5(1F1E   )      DW    X'1F1E'    ; =0x1f1e =7966
80a7(1F1E   )      DW    X'1F1E'    ; =0x1f1e =7966
80a9(1F     )      DB    X'1F'      ; =0x1f =31
80aa(0000   )W80AA DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80ac(0000   )W80AC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80ae:ENDPT
