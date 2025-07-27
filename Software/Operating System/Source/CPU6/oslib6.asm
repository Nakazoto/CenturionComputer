 TITLE 'UCSTR'
UCSTR BEGIN 0
*
*
* Function UCSTR
*
8000(9541   )UCSTR LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8004(5564   )      XFR   Y,X        ; [Transfer Y to X]
8006(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8008(6501   )      LDX+  A+         ; [Load X indexed, direct, post-incremented]
800a(5C     )      XAY              ; [Transfer A to Y]
800b(3F     )D800B DCX              ; [Decrement X]
800c(1613   )      BM    D8021      ; =+19 [Branch on minus]
800e(8B     )      LDAB+ Y          ; [Load AL from address in Y]
800f(C0FA   )      LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
8011(49     )      SABB             ; [AL - BL -> BL]
8012(1809   )      BGZ   D801D      ; =+9 [Branch if greater than zero]
8014(C0E1   )      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
8016(49     )      SABB             ; [AL - BL -> BL]
8017(1604   )      BM    D801D      ; =+4 [Branch on minus]
8019(80C1   )      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
801b(4031   )      ADDB  BL,AL      ; [BL + AL -> AL]
801d(A561   )D801D STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
801f(73EA   )      JMP   D800B      ; =-22 [Jump relative]
8021(95A1   )D8021 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8023(5C     )      XAY              ; [Transfer A to Y]
8024(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8026(09     )      RSR              ; [Return from subroutine]
*
8027:ENDPT


 TITLE 'TST'
TST BEGIN 0
*
 ENT GP
 ENT @PT
 ENT CR
 ENT TO
CH EQU X'8044'
 ENT CH
@LUN EQU X'8047'
 ENT @LUN
 ENT TI
@AB EQU X'8061'
 ENT @AB
@AA EQU X'8068'
 ENT @AA
*
*
* Function TST
*
8000(7B13   )TST   JSR   CR         ; =+19 [Jump to subroutine relative]
8002(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8004(7B23   )      JSR   F8029      ; =+35 [Jump to subroutine relative]
8006(02     )      DB    X'02'      ; =0x02 =2
8007(09     )      RSR              ; [Return from subroutine]
*
8008(80     )GP    DB    X'80'      ; =0x80 =128(-128)
8009(AF     )@PT   DC    '/'        ; hex:af dec:175(-81)
800a(1702   )      DW    X'1702'    ; =0x1702 =5890
800c(7B0E   )      DW    X'7B0E'    ; =0x7b0e =31502
800e(9541   )      DW    X'9541'    ; =0x9541 =38209(-27327)
8010(7B17   )      DW    X'7B17'    ; =0x7b17 =31511
8012(0173   )      DW    X'0173'    ; =0x0173 =371
8014(49     )      DB    X'49'      ; =0x49 =73
*
*
* Function CR
*
8015(808D   )CR    LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8017(C32B   )      LDBB  W8043+1    ; =+43 [Load BL relative]
8019(49     )      SABB             ; [AL - BL -> BL]
801a(1408   )      BZ    D8024      ; =+8 [Branch if zero]
*
* Function TO
*
801c(A309   )TO    STAB  B8027      ; =+9 [Store AL relative]
801e(908025 )      LDA=  W8025      ; =0x8025 =32805(-32731) [Load A with immediate]
8021(7B06   )      JSR   F8029      ; =+6 [Jump to subroutine relative]
8023(02     )      DB    X'02'      ; =0x02 =2
*
8024(09     )D8024 RSR              ; [Return from subroutine]
*
8025(0001   )W8025 DW    X'0001'    ; =0x0001 =1
8027(0000   )B8027 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
* Function F8029
*
8029(B321   )F8029 STA   S804C      ; =+33 [Store A relative]
802b(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
802d(A31A   )      STAB  B8049      ; =+26 [Store AL relative]
802f(D08046 )W802F LDB=  W8046      ; =0x8046 =32838(-32698) [Load B with immediate]
8032(6610   )      SVC   16         ; =0x10 [Service call SYSIO - device-independent logical I/O [all units]]
8034(6607   )D8034 SVC   7          ; =0x07 [Service call WT - unconditional wait]
8036(830E   )      LDAB  W8046      ; =+14 [Load AL relative]
8038(16FA   )      BM    D8034      ; =-6 [Branch on minus]
803a(D3F4   )      LDB   W802F+1    ; =-12 [Load B relative]
803c(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
803e(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg1]
803f(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg2]
8040(12     )      DB    X'12'      ; =0x12 =18 [TODO: arg3]
8041(8044   )      DW    W8043+1    ; =0x8044 =32836(-32700) [address to store block value]
8043(8000   )W8043 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8045(09     )      RSR              ; [Return from subroutine]
*
8046(0081   )W8046 DW    X'0081'    ; =0x0081 =129
8048(00     )      DB    X'00'      ; =0x00 =0 =NUL
8049(00     )B8049 DB    X'00'      ; =0x00 =0 =NUL
804a(0084   )W804A DW    X'0084'    ; =0x0084 =132 =NUL,EOT
804c(000000+)S804C DB    0,4        ; =0x00,0x0004
*
*
* Function TI
*
8050(908025 )TI    LDA=  W8025      ; =0x8025 =32805(-32731) [Load A with immediate]
8053(D8     )      LDB+  A          ; [Load B from address in A]
8054(F3F4   )      STB   W804A      ; =-12 [Store B relative]
8056(7BD1   )      JSR   F8029      ; =-47 [Jump to subroutine relative]
8058(01     )      DB    X'01'      ; =0x01 =1
8059(900084 )      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
805c(B3EC   )      STA   W804A      ; =-20 [Store A relative]
805e(83E4   )      LDAB  W8043+1    ; =-28 [Load AL relative]
8060(C08A   )      LDBB= X'8A'      ; =138(-118) =LF [Load BL with immediate]
8062(1409   )      BZ    D806D      ; =+9 [Branch if zero]
8064(49     )      SABB             ; [AL - BL -> BL]
8065(1506   )      BNZ   D806D      ; =+6 [Branch if not zero]
8067(900000 )      LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
806a(1401   )      BZ    D806D      ; =+1 [Branch if zero]
806c(5B     )      XAX              ; [Transfer A to X]
806d(83B8   )D806D LDAB  B8027      ; =-72 [Load AL relative]
806f(09     )      RSR              ; [Return from subroutine]
*
8070:ENDPT


 TITLE '@HEX16'
@HEX16 BEGIN 0
*
*
* Function @HEX16
*
8000(7E05   )@HEX16 STK   A,6        ; [Push A B X to the stack]
8002(B314   )      STA   W8018      ; =+20 [Store A relative]
8004(6541   )      LDX+  X+         ; [Load X indexed, direct, post-incremented]
8006(479E03+)      FIL   (4)='@',-X ; [Fill with byte, literal=0xc0(192,-64), indexed]
800b(8004   )      LDAB= X'04'      ; =4 [Load AL with immediate]
800d(46E198+)      CFB   -X(16),/W8018(2) ; =0x8018 =32792(-32744) [Convert from bignum, indexed, direct]
8013(7F05   )      POP   A,6        ; [Pop X B A from the stack]
8015(3041   )      INR   X,2        ; [Increment X by 2]
8017(09     )      RSR              ; [Return from subroutine]
*
8018(0000   )W8018 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
801a:ENDPT


 TITLE '@HEX'
@HEX BEGIN 0
*
*
* Function @HEX
*
8000(A311   )@HEX  STAB  B8013      ; =+17 [Store AL relative]
8002(90C0C0 )      LDA=  X'C0C0'    ; =0xc0c0 =49344(-16192) ='@','@' [Load A with immediate]
8005(B30D   )      STA   W8014      ; =+13 [Store A relative]
8007(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
8009(46E090+)      CFB   /W8014(16),/B8013(1) ; =0x8014 =32788(-32748),=0x8013 =32787(-32749) [Convert from bignum, direct, direct]
8010(9302   )      LDA   W8014      ; =+2 [Load A relative]
8012(09     )      RSR              ; [Return from subroutine]
*
8013(00     )B8013 DB    X'00'      ; =0x00 =0 =NUL
8014(0000   )W8014 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8016:ENDPT


 TITLE 'PSUB'
PSUB BEGIN 0
*
 ENT NDC
 ENT ACC
 ENT ANC
 ENT DEB
 ENT GSYM
 ENT INTG
 ENT CKCH
 ENT PSYM
*
 EXT ERROR
 EXT MVUSS
*
*
* Function PSUB
*
8000(5560   )PSUB  XFR   Y,A        ; [Transfer Y to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(3001   )      INR   A,2        ; [Increment A by 2]
8008(5E     )      XAZ              ; [Transfer A to Z]
8009(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800b(B329   )      STA   W8035+1    ; =+41 [Store A relative]
800d(5C     )      XAY              ; [Transfer A to Y]
800e(3A     )      CLA              ; [Clear A]
800f(B561   )      STA+  Y+         ; [Store A indexed, direct, post-incremented]
8011(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8013(8581   )D8013 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8015(150A   )      BNZ   D8021      ; =+10 [Branch if not zero]
8017(808D   )      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8019(7B19   )      JSR   F8034      ; =+25 [Jump to subroutine relative]
801b(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
801d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
801f(5C     )      XAY              ; [Transfer A to Y]
8020(09     )      RSR              ; [Return from subroutine]
*
8021(C0A3   )D8021 LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
8023(49     )      SABB             ; [AL - BL -> BL]
8024(1404   )      BZ    D802A      ; =+4 [Branch if zero]
8026(7B0C   )D8026 JSR   F8034      ; =+12 [Jump to subroutine relative]
8028(73E9   )      JMP   D8013      ; =-23 [Jump relative]
802a(8581   )D802A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
802c(1516   )      BNZ   D8044      ; =+22 [Branch if not zero]
802e(3180   )D802E DCR   Z          ; [Decrement Z by 1]
8030(80A3   )      LDAB= X'A3'      ; =163(-93) ='#' [Load AL with immediate]
8032(73F2   )      JMP   D8026      ; =-14 [Jump relative]
*
* Function F8034
*
8034(AB     )F8034 STAB+ Y          ; [Store AL to address in Y]
8035(910000 )W8035 LDA/  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A direct]
8038(38     )      INA              ; [Increment A]
8039(D00084 )      LDB=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load B with immediate]
803c(59     )      SAB              ; [A - B -> B]
803d(1804   )      BGZ   D8043      ; =+4 [Branch if greater than zero]
803f(B4F5   )      STA*  W8035+1    ; =-11 [Store A relative indirect]
8041(3060   )      INR   Y          ; [Increment Y by 1]
8043(09     )D8043 RSR              ; [Return from subroutine]
*
8044(7980FF )D8044 JSR/  NDC        ; =0x80ff =33023(-32513) [Jump to subroutine direct]
8047(1626   )      BM    D806F      ; =+38 [Branch on minus]
8049(3A     )      CLA              ; [Clear A]
804a(4531   )      XFRB  BL,AL      ; [Transfer BL to AL]
804c(A302   )      STAB  B8050      ; =+2 [Store AL relative]
804e(665F   )      SVC   95         ; =0x5F [Service call GPRM - get general parameter]
8050(FF     )B8050 DB    X'FF'      ; =0xff =255(-1) [TODO: arg1]
8051(80E0   )      DW    S80E0      ; =0x80e0 =32992(-32544) [TODO: arg2]
*
8053(5582   )D8053 XFR   Z,B        ; [Transfer Z to B]
8055(F5A2   )      STB-  S-         ; [Store B indexed, pre-decremented, direct]
8057(559880+)      XFR=  S80E0,Z    ; =0x80e0 =32992(-32544) [Transfer immediate to Z]
805b(60000A )      LDX=  X'000A'    ; =0x000a =10 [Load X with immediate]
805e(8581   )D805E LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8060(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8062(49     )      SABB             ; [AL - BL -> BL]
8063(1402   )      BZ    D8067      ; =+2 [Branch if zero]
8065(7BCD   )      JSR   F8034      ; =-51 [Jump to subroutine relative]
8067(3F     )D8067 DCX              ; [Decrement X]
8068(18F4   )      BGZ   D805E      ; =-12 [Branch if greater than zero]
806a(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
806c(5E     )      XAZ              ; [Transfer A to Z]
806d(73A4   )      JMP   D8013      ; =-92 [Jump relative]
806f(4510   )D806F XFRB  AL,AU      ; [Transfer AL to AU]
8071(479C09+)      FIL   (10)=' ',/S80E0 ; =0x80e0 =32992(-32544) [Fill with byte, literal=0xa0(160,-96), direct]
8077(D080E9 )      LDB=  S80E9      ; =0x80e9 =33001(-32535) [Load B with immediate]
807a(8521   )D807A LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
807c(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
807e(14AE   )      BZ    D802E      ; =-82 [Branch if zero]
8080(4101   )      SUBB  AU,AL      ; [AU - AL -> AL]
8082(15F6   )      BNZ   D807A      ; =-10 [Branch if not zero]
8084(89     )      LDAB+ B          ; [Load AL from address in B]
8085(1612   )      BM    D8099      ; =+18 [Branch on minus]
8087(A304   )      STAB  B808D      ; =+4 [Store AL relative]
8089(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
808b(00     )      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
808c(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg2]
808d(FF     )B808D DB    X'FF'      ; =0xff =255(-1) [TODO: arg3]
808e(8092   )      DW    W8091+1    ; =0x8092 =32914(-32622) [address to store block value]
*
8090(3A     )D8090 CLA              ; [Clear A]
8091(8000   )W8091 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8093(662E   )      SVC   46         ; =0x2E [Service call CVR16 - 16-bit convert to decimal from A register]
8095(80E5   )      DW    S80E5      ; =0x80e5 =32997(-32539) [address of end of string]
8097(73BA   )      JMP   D8053      ; =-70 [Jump relative]
8099(80D3   )D8099 LDAB= X'D3'      ; =211(-45) ='S' [Load AL with immediate]
809b(4110   )      SUBB  AL,AU      ; [AL - AU -> AU]
809d(1509   )      BNZ   D80A8      ; =+9 [Branch if not zero]
809f(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
80a1(02     )      DB    X'02'      ; =0x02 =2 [TODO: arg1]
80a2(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg2]
80a3(05     )      DB    X'05'      ; =0x05 =5 [TODO: arg3]
80a4(8092   )      DW    W8091+1    ; =0x8092 =32914(-32622) [address to store block value]
80a6(73E8   )      JMP   D8090      ; =-24 [Jump relative]
80a8(665C   )D80A8 SVC   92         ; =0x5C [Service call GBKV - get OS block value]
80aa(00     )      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
80ab(02     )      DB    X'02'      ; =0x02 =2 [TODO: arg2]
80ac(0A     )      DB    X'0A'      ; =0x0a =10 [TODO: arg3]
80ad(80B7   )      DW    W80B6+1    ; =0x80b7 =32951(-32585) [address to store block value]
80af(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
80b1(00     )      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
80b2(02     )      DB    X'02'      ; =0x02 =2 [TODO: arg2]
80b3(0C     )      DB    X'0C'      ; =0x0c =12 [TODO: arg3]
80b4(80BA   )      DW    W80B9+1    ; =0x80ba =32954(-32582) [address to store block value]
80b6(900000 )W80B6 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
80b9(D00000 )W80B9 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
80bc(5120   )      SUB   B,A        ; [B - A -> A]
80be(1401   )      BZ    D80C1      ; =+1 [Branch if zero]
80c0(38     )      INA              ; [Increment A]
80c1(3240   )D80C1 CLR   X          ; [Clear X]
80c3(5D     )      XAB              ; [Transfer A to B]
80c4(1709   )      BP    D80CF      ; =+9 [Branch on plus]
80c6(90D8F0 )      LDA=  X'D8F0'    ; =0xd8f0 =55536(-10000) ='X','p' [Load A with immediate]
80c9(3E     )D80C9 INX              ; [Increment X]
80ca(58     )      AAB              ; [A + B -> B]
80cb(16FC   )      BM    D80C9      ; =-4 [Branch on minus]
80cd(5520   )      XFR   B,A        ; [Transfer B to A]
80cf(662E   )D80CF SVC   46         ; =0x2E [Service call CVR16 - 16-bit convert to decimal from A register]
80d1(80E5   )      DW    S80E5      ; =0x80e5 =32997(-32539) [address of end of string]
80d3(830C   )      LDAB  S80E1      ; =+12 [Load AL relative]
80d5(7301   )      JMP   D80D8      ; =+1 [Jump relative]
80d7(28     )D80D7 INAB             ; [Increment AL]
80d8(3F     )D80D8 DCX              ; [Decrement X]
80d9(17FC   )      BP    D80D7      ; =-4 [Branch on plus]
80db(A304   )      STAB  S80E1      ; =+4 [Store AL relative]
80dd(718053 )      JMP/  D8053      ; =0x8053 =32851(-32685) [Jump direct]
*
80e0(A0     )S80E0 DC    ' '        ; hex:a0 dec:160(-96)
80e1(A0A0A0+)S80E1 DC    ' ',4     
80e5(A0A0A0+)S80E5 DC    ' ',4     
80e9(A0C9   )S80E9 DC    ' I'       ; hex:a0c9 dec:41161(-55)
80eb(01     )      DB    X'01'      ; =0x01 =1
80ec(C3     )      DC    'C'        ; hex:c3 dec:195(-61)
80ed(14     )      DB    X'14'      ; =0x14 =20
80ee(D5     )      DC    'U'        ; hex:d5 dec:213(-43)
80ef(15     )      DB    X'15'      ; =0x15 =21
80f0(D6     )      DC    'V'        ; hex:d6 dec:214(-42)
80f1(28     )      DB    X'28'      ; =0x28 =40
80f2(C4     )      DC    'D'        ; hex:c4 dec:196(-60)
80f3(31     )      DB    X'31'      ; =0x31 =49
80f4(D4     )      DC    'T'        ; hex:d4 dec:212(-44)
80f5(5E     )      DB    X'5E'      ; =0x5e =94
80f6(CC     )      DC    'L'        ; hex:cc dec:204(-52)
80f7(5F     )      DB    X'5F'      ; =0x5f =95
80f8(D7     )      DC    'W'        ; hex:d7 dec:215(-41)
80f9(60     )      DB    X'60'      ; =0x60 =96
80fa(CD     )      DC    'M'        ; hex:cd dec:205(-51)
80fb(FF     )      DB    X'FF'      ; =0xff =255(-1)
80fc(D3     )      DC    'S'        ; hex:d3 dec:211(-45)
80fd(FF00   )      DW    X'FF00'    ; =0xff00 =65280(-256)
*
*
* Function NDC
*
80ff(C0B9   )NDC   LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
8101(49     )      SABB             ; [AL - BL -> BL]
8102(1903   )      BLE   D8107      ; =+3 [Branch if less than or equal to zero]
8104(C0FF   )      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8106(09     )      RSR              ; [Return from subroutine]
*
8107(C0B0   )D8107 LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8109(49     )      SABB             ; [AL - BL -> BL]
810a(09     )      RSR              ; [Return from subroutine]
*
* Function ACC
*
810b(C0DA   )ACC   LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
810d(49     )      SABB             ; [AL - BL -> BL]
810e(1903   )      BLE   D8113      ; =+3 [Branch if less than or equal to zero]
8110(C0FF   )      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8112(09     )      RSR              ; [Return from subroutine]
*
8113(C0BE   )D8113 LDBB= X'BE'      ; =190(-66) ='>' [Load BL with immediate]
8115(49     )      SABB             ; [AL - BL -> BL]
8116(09     )      RSR              ; [Return from subroutine]
*
* Function ANC
*
8117(7BF2   )ANC   JSR   ACC        ; =-14 [Jump to subroutine relative]
8119(1702   )      BP    D811D      ; =+2 [Branch on plus]
811b(7BE2   )      JSR   NDC        ; =-30 [Jump to subroutine relative]
811d(09     )D811D RSR              ; [Return from subroutine]
*
* Function DEB
*
811e(80A0   )DEB   LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8120(C581   )D8120 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8122(49     )      SABB             ; [AL - BL -> BL]
8123(14FB   )      BZ    D8120      ; =-5 [Branch if zero]
8125(3180   )      DCR   Z          ; [Decrement Z by 1]
8127(09     )      RSR              ; [Return from subroutine]
*
* Function GSYM
*
8128(5580   )GSYM  XFR   Z,A        ; [Transfer Z to A]
812a(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
812c(8581   )D812C LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
812e(7BE7   )      JSR   ANC        ; =-25 [Jump to subroutine relative]
8130(17FA   )      BP    D812C      ; =-6 [Branch on plus]
8132(3180   )      DCR   Z          ; [Decrement Z by 1]
8134(9D     )      LDA+  S          ; [Load A from address in S]
8135(5180   )      SUB   Z,A        ; [Z - A -> A]
8137(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8139(7BE3   )      JSR   DEB        ; =-29 [Jump to subroutine relative]
813b(D5A1   )      LDB+  S+         ; [Load B indexed, direct, post-incremented]
813d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
813f(09     )      RSR              ; [Return from subroutine]
*
* Function INTG
*
8140(8C     )INTG  LDAB+ Z          ; [Load AL from address in Z]
8141(7BBC   )      JSR   NDC        ; =-68 [Jump to subroutine relative]
8143(1705   )      BP    D814A      ; =+5 [Branch on plus]
8145(79EEEE )      JSR/  ERROR      ; [external symbol] [Jump to subroutine direct]
8148(81A3   )      DW    W81A3      ; =0x81a3 =33187(-32349)
*
814a(3A     )D814A CLA              ; [Clear A]
814b(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
814d(8581   )D814D LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
814f(7BAE   )      JSR   NDC        ; =-82 [Jump to subroutine relative]
8151(1707   )      BP    D815A      ; =+7 [Branch on plus]
8153(3180   )      DCR   Z          ; [Decrement Z by 1]
8155(7BC7   )      JSR   DEB        ; =-57 [Jump to subroutine relative]
8157(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8159(09     )      RSR              ; [Return from subroutine]
*
815a(9D     )D815A LDA+  S          ; [Load A from address in S]
815b(ED     )      STBB+ S          ; [Store BL to address in S]
815c(3D     )      SLA              ; [Left shift A]
815d(5D     )      XAB              ; [Transfer A to B]
815e(3501   )      SLR   A,2        ; [Left shift A by 2]
8160(58     )      AAB              ; [A + B -> B]
8161(3A     )      CLA              ; [Clear A]
8162(8D     )      LDAB+ S          ; [Load AL from address in S]
8163(58     )      AAB              ; [A + B -> B]
8164(FD     )      STB+  S          ; [Store B to address in S]
8165(73E6   )      JMP   D814D      ; =-26 [Jump relative]
*
* Function CKCH
*
8167(5580   )CKCH  XFR   Z,A        ; [Transfer Z to A]
8169(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
816b(2A     )      CLAB             ; [Clear AL]
816c(C541   )D816C LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
816e(170E   )      BP    D817E      ; =+14 [Branch on plus]
8170(8581   )      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8172(49     )      SABB             ; [AL - BL -> BL]
8173(14F7   )      BZ    D816C      ; =-9 [Branch if zero]
8175(8541   )D8175 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8177(16FC   )      BM    D8175      ; =-4 [Branch on minus]
8179(95A1   )D8179 LDA+  S+         ; [Load A indexed, direct, post-incremented]
817b(5E     )      XAZ              ; [Transfer A to Z]
817c(3A     )      CLA              ; [Clear A]
817d(09     )      RSR              ; [Return from subroutine]
*
817e(7B97   )D817E JSR   ANC        ; =-105 [Jump to subroutine relative]
8180(1605   )      BM    D8187      ; =+5 [Branch on minus]
8182(8C     )      LDAB+ Z          ; [Load AL from address in Z]
8183(7B92   )      JSR   ANC        ; =-110 [Jump to subroutine relative]
8185(17F2   )      BP    D8179      ; =-14 [Branch on plus]
8187(7B95   )D8187 JSR   DEB        ; =-107 [Jump to subroutine relative]
8189(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
818b(3A     )      CLA              ; [Clear A]
818c(8548FF )      LDAB+ X,-1       ; [Load AL indexed, displaced, direct]
818f(09     )      RSR              ; [Return from subroutine]
*
* Function PSYM
*
8190(9541   )PSYM  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8192(B30A   )      STA   W819E      ; =+10 [Store A relative]
8194(7B92   )      JSR   GSYM       ; =-110 [Jump to subroutine relative]
8196(B308   )      STA   W81A0      ; =+8 [Store A relative]
8198(90000A )      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
819b(79EEEE )      JSR/  MVUSS      ; [external symbol] [Jump to subroutine direct]
819e(0000   )W819E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
81a0(0000   )W81A0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
81a2(09     )      RSR              ; [Return from subroutine]
*
81a3(0018   )W81A3 DW    X'0018'    ; =0x0018 =24
81a5(C3CFCE+)      DC    'CONTROL STATEMENT ERROR'
81bc(8D     )      DB    X'8D'      ; =0x8d =141(-115) =CR
81bd:ENDPT


 TITLE 'CVD16'
CVD16 BEGIN 0
*
*
* Function CVD16
*
8000(9541   )CVD16 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8004(E5A2   )      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
8006(5500   )      XFR   A,A        ; [Transfer A to A]
8008(1432   )      BZ    D803C      ; =+50 [Branch if zero]
800a(1705   )      BP    D8011      ; =+5 [Branch on plus]
800c(3B     )      IVA              ; [Invert A]
800d(38     )      INA              ; [Increment A]
800e(C0AD   )      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8010(ED     )      STBB+ S          ; [Store BL to address in S]
8011(D541   )D8011 LDB+  X+         ; [Load B indexed, direct, post-incremented]
8013(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8015(5524   )      XFR   B,X        ; [Transfer B to X]
8017(3E     )      INX              ; [Increment X]
8018(D0000A )D8018 LDB=  X'000A'    ; =0x000a =10 [Load B with immediate]
801b(7820   )      DIV   B,A        ; [A / B -> B, A % B -> A]
801d(F5A2   )      STB-  S-         ; [Store B indexed, pre-decremented, direct]
801f(1409   )      BZ    D802A      ; =+9 [Branch if zero]
8021(C0B0   )      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8023(48     )      AABB             ; [AL + BL -> BL]
8024(E542   )      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8026(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8028(73EE   )      JMP   D8018      ; =-18 [Jump relative]
802a(4D     )D802A XABB             ; [Transfer AL to BL]
802b(1405   )      BZ    D8032      ; =+5 [Branch if zero]
802d(80B0   )      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
802f(48     )      AABB             ; [AL + BL -> BL]
8030(E542   )      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8032(D5A1   )D8032 LDB+  S+         ; [Load B indexed, direct, post-incremented]
8034(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8036(C5A1   )      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
8038(E542   )      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
803a(5B     )      XAX              ; [Transfer A to X]
803b(09     )      RSR              ; [Return from subroutine]
*
803c(80B0   )D803C LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
803e(A544   )      STAB+ *X         ; [Store AL indexed, indirect]
8040(3041   )      INR   X,2        ; [Increment X by 2]
8042(C5A1   )      LDBB+ S+         ; [Load BL indexed, direct, post-incremented]
8044(09     )      RSR              ; [Return from subroutine]
*
8045:ENDPT


 TITLE 'DIV16'
DIV16 BEGIN 0
*
*
* Function DIV16
*
8000(7820   )DIV16 DIV   B,A        ; [A / B -> B, A % B -> A]
8002(09     )      RSR              ; [Return from subroutine]
*
8003:ENDPT


 TITLE 'MUL16'
MUL16 BEGIN 0
*
*
* Function MUL16
*
8000(7720   )MUL16 MUL   B,A        ; [B * A -> A,B]
8002(09     )      RSR              ; [Return from subroutine]
*
8003:ENDPT


 TITLE 'LIOCB'
LIOCB BEGIN 0
*
8000(0B     )      DB    X'0B'      ; =0x0b =11
8001(8095   )      DW    W8095      ; =0x8095 =32917(-32619)
8003(80E7   )      DW    W80E7      ; =0x80e7 =32999(-32537)
8005(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8007(8017   )      DW    ENTRY      ; =0x8017 =32791(-32745)
8009(000000+)      DB    0,12       ; =0x00,0x000c
8015(816A   )      DW    W816A      ; =0x816a =33130(-32406)
*
* Function ENTRY
*
8017(6DA2   )ENTRY STX-  S-         ; [Store X indexed, pre-decremented, direct]
8019(7B2B   )      JSR   F8046      ; =+43 [Jump to subroutine relative]
801b(02     )      DB    X'02'      ; =0x02 =2
801c(1426   )      BZ    D8044      ; =+38 [Branch if zero]
801e(3A     )      CLA              ; [Clear A]
801f(B58812 )      STA+  Z,18       ; [Store A indexed, displaced, direct]
8022(B58816 )      STA+  Z,22       ; [Store A indexed, displaced, direct]
8025(F58814 )      STB+  Z,20       ; [Store B indexed, displaced, direct]
8028(F58818 )      STB+  Z,24       ; [Store B indexed, displaced, direct]
802b(7B19   )      JSR   F8046      ; =+25 [Jump to subroutine relative]
802d(05     )      DB    X'05'      ; =0x05 =5
802e(C00F   )      LDBB= X'0F'      ; =15 [Load BL with immediate]
8030(4223   )      ANDB  BU,BL      ; [BU & BL -> BL]
8032(85880D )      LDAB+ Z,13       ; [Load AL indexed, displaced, direct]
8035(1606   )      BM    D803D      ; =+6 [Branch on minus]
8037(49     )      SABB             ; [AL - BL -> BL]
8038(1403   )      BZ    D803D      ; =+3 [Branch if zero]
803a(6609   )      SVC   9          ; =0x09 [Service call ABRT - abort task]
803c(12     )      DB    X'12'      ; =0x12 =18 [abort code]
*
803d(958806 )D803D LDA+  Z,6        ; [Load A indexed, displaced, direct]
8040(1402   )      BZ    D8044      ; =+2 [Branch if zero]
8042(7B19   )      JSR   F805D      ; =+25 [Jump to subroutine relative]
8044(7375   )D8044 JMP   D80BB      ; =+117 [Jump relative]
*
* Function F8046
*
8046(8541   )F8046 LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8048(A306   )      STAB  B8050      ; =+6 [Store AL relative]
804a(5582   )      XFR   Z,B        ; [Transfer Z to B]
804c(6652   )      SVC   82         ; =0x52 [Service call GIOB - unprotected GIOB]
804e(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg1]
804f(02     )      DB    X'02'      ; =0x02 =2 [TODO: arg2]
8050(00     )B8050 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
8051(8058   )      DW    L8057+1    ; =0x8058 =32856(-32680) [TODO: address]
8053(5522   )      XFR   B,B        ; [Transfer B to B]
8055(1405   )      BZ    D805C      ; =+5 [Branch if zero]
8057(D00000 )L8057 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
805a(5500   )      XFR   A,A        ; [Transfer A to A]
805c(09     )D805C RSR              ; [Return from subroutine]
*
* Function F805D
*
805d(7BE7   )F805D JSR   F8046      ; =-25 [Jump to subroutine relative]
805f(02     )      DB    X'02'      ; =0x02 =2
8060(958816 )      LDA+  Z,22       ; [Load A indexed, displaced, direct]
8063(5120   )      SUB   B,A        ; [B - A -> A]
8065(1004   )      BL    D806B      ; =+4 [Branch on link]
8067(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
8069(7314   )      JMP   D807F      ; =+20 [Jump relative]
806b(958816 )D806B LDA+  Z,22       ; [Load A indexed, displaced, direct]
806e(B58812 )      STA+  Z,18       ; [Store A indexed, displaced, direct]
8071(B58808 )      STA+  Z,8        ; [Store A indexed, displaced, direct]
8074(7B13   )      JSR   F8089      ; =+19 [Jump to subroutine relative]
8076(01     )      DB    X'01'      ; =0x01 =1
8077(D58812 )      LDB+  Z,18       ; [Load B indexed, displaced, direct]
807a(3020   )      INR   B          ; [Increment B by 1]
807c(F58816 )      STB+  Z,22       ; [Store B indexed, displaced, direct]
807f(AC     )D807F STAB+ Z          ; [Store AL to address in Z]
8080(09     )      RSR              ; [Return from subroutine]
*
* Function F8081
*
8081(8C     )F8081 LDAB+ Z          ; [Load AL from address in Z]
8082(1704   )      BP    D8088      ; =+4 [Branch on plus]
8084(6607   )      SVC   7          ; =0x07 [Service call WT - unconditional wait]
8086(73F9   )      JMP   F8081      ; =-7 [Jump relative]
8088(09     )D8088 RSR              ; [Return from subroutine]
*
* Function F8089
*
8089(5582   )F8089 XFR   Z,B        ; [Transfer Z to B]
808b(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
808d(A58803 )      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
8090(6600   )      SVC   0          ; =0x00 [Service call PIOC - physical i/o control]
8092(7BED   )      JSR   F8081      ; =-19 [Jump to subroutine relative]
8094(09     )      RSR              ; [Return from subroutine]
*
8095(6DA2   )W8095 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8097(958806 )D8097 LDA+  Z,6        ; [Load A indexed, displaced, direct]
809a(3001   )      INR   A,2        ; [Increment A by 2]
809c(D58818 )      LDB+  Z,24       ; [Load B indexed, displaced, direct]
809f(F58814 )      STB+  Z,20       ; [Store B indexed, displaced, direct]
80a2(5020   )      ADD   B,A        ; [B + A -> A]
80a4(5C     )      XAY              ; [Transfer A to Y]
80a5(9B     )      LDA+  Y          ; [Load A from address in Y]
80a6(C084   )      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
80a8(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
80aa(4103   )      SUBB  AU,BL      ; [AU - BL -> BL]
80ac(140C   )      BZ    D80BA      ; =+12 [Branch if zero]
80ae(2100   )      DCRB  AU         ; [Decrement AU by 1]
80b0(130D   )      BNF   D80BF      ; =+13 [Branch on no fault]
80b2(7BA9   )      JSR   F805D      ; =-87 [Jump to subroutine relative]
80b4(3A     )      CLA              ; [Clear A]
80b5(B58818 )      STA+  Z,24       ; [Store A indexed, displaced, direct]
80b8(73DD   )      JMP   D8097      ; =-35 [Jump relative]
80ba(AC     )D80BA STAB+ Z          ; [Store AL to address in Z]
80bb(D5A1   )D80BB LDB+  S+         ; [Load B indexed, direct, post-incremented]
80bd(6668   )      SVC   104        ; =0x68 [Service call RLSR - return from LSR]
80bf(9B     )D80BF LDA+  Y          ; [Load A from address in Y]
80c0(2200   )      CLRB  AU         ; [Clear AU]
80c2(D00005 )      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
80c5(5020   )      ADD   B,A        ; [B + A -> A]
80c7(D58818 )      LDB+  Z,24       ; [Load B indexed, displaced, direct]
80ca(58     )      AAB              ; [A + B -> B]
80cb(F58818 )      STB+  Z,24       ; [Store B indexed, displaced, direct]
80ce(D58810 )      LDB+  Z,16       ; [Load B indexed, displaced, direct]
80d1(5B     )      XAX              ; [Transfer A to X]
80d2(3A     )      CLA              ; [Clear A]
80d3(3F     )D80D3 DCX              ; [Decrement X]
80d4(1908   )      BLE   D80DE      ; =+8 [Branch if less than or equal to zero]
80d6(8561   )      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
80d8(A521   )      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
80da(4010   )      ADDB  AL,AU      ; [AL + AU -> AU]
80dc(73F5   )      JMP   D80D3      ; =-11 [Jump relative]
80de(8B     )D80DE LDAB+ Y          ; [Load AL from address in Y]
80df(4001   )      ADDB  AU,AL      ; [AU + AL -> AL]
80e1(14D7   )      BZ    D80BA      ; =-41 [Branch if zero]
80e3(8004   )      LDAB= X'04'      ; =4 [Load AL with immediate]
80e5(73D3   )      JMP   D80BA      ; =-45 [Jump relative]
80e7(6DA2   )W80E7 STX-  S-         ; [Store X indexed, pre-decremented, direct]
80e9(958806 )D80E9 LDA+  Z,6        ; [Load A indexed, displaced, direct]
80ec(3001   )      INR   A,2        ; [Increment A by 2]
80ee(5C     )      XAY              ; [Transfer A to Y]
80ef(958818 )      LDA+  Z,24       ; [Load A indexed, displaced, direct]
80f2(B58814 )      STA+  Z,20       ; [Store A indexed, displaced, direct]
80f5(5006   )      ADD   A,Y        ; [A + Y -> Y]
80f7(658810 )      LDX+  Z,16       ; [Load X indexed, displaced, direct]
80fa(DA     )      LDB+  X          ; [Load B from address in X]
80fb(C084   )      LDBB= X'84'      ; =132(-124) =EOT [Load BL with immediate]
80fd(4132   )      SUBB  BL,BU      ; [BL - BU -> BU]
80ff(1503   )      BNZ   D8104      ; =+3 [Branch if not zero]
8101(EB     )      STBB+ Y          ; [Store BL to address in Y]
8102(7331   )      JMP   D8135      ; =+49 [Jump relative]
8104(DA     )D8104 LDB+  X          ; [Load B from address in X]
8105(2220   )      CLRB  BU         ; [Clear BU]
8107(58     )      AAB              ; [A + B -> B]
8108(900005 )      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
810b(58     )      AAB              ; [A + B -> B]
810c(F58818 )      STB+  Z,24       ; [Store B indexed, displaced, direct]
810f(90018A )      LDA=  X'018A'    ; =0x018a =394 [Load A with immediate]
8112(59     )      SAB              ; [A - B -> B]
8113(1706   )      BP    D811B      ; =+6 [Branch on plus]
8115(7B30   )      JSR   F8147      ; =+48 [Jump to subroutine relative]
8117(14D0   )      BZ    D80E9      ; =-48 [Branch if zero]
8119(739F   )      JMP   D80BA      ; =-97 [Jump relative]
811b(9541   )D811B LDA+  X+         ; [Load A indexed, direct, post-incremented]
811d(5D     )      XAB              ; [Transfer A to B]
811e(2200   )      CLRB  AU         ; [Clear AU]
8120(F561   )      STB+  Y+         ; [Store B indexed, direct, post-incremented]
8122(4032   )      ADDB  BL,BU      ; [BL + BU -> BU]
8124(38     )      INA              ; [Increment A]
8125(C541   )D8125 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8127(E561   )      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
8129(4032   )      ADDB  BL,BU      ; [BL + BU -> BU]
812b(39     )      DCA              ; [Decrement A]
812c(17F7   )      BP    D8125      ; =-9 [Branch on plus]
812e(C080   )      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
8130(2320   )      IVRB  BU         ; [Invert BU]
8132(2020   )      INRB  BU         ; [Increment BU by 1]
8134(FB     )      STB+  Y          ; [Store B to address in Y]
8135(2A     )D8135 CLAB             ; [Clear AL]
8136(7382   )D8136 JMP   D80BA      ; =-126 [Jump relative]
*
* Function F8138
*
8138(3A     )F8138 CLA              ; [Clear A]
8139(B58818 )      STA+  Z,24       ; [Store A indexed, displaced, direct]
813c(958812 )      LDA+  Z,18       ; [Load A indexed, displaced, direct]
813f(B58808 )      STA+  Z,8        ; [Store A indexed, displaced, direct]
8142(798089 )      JSR/  F8089      ; =0x8089 =32905(-32631) [Jump to subroutine direct]
8145(02     )      DB    X'02'      ; =0x02 =2
8146(09     )      RSR              ; [Return from subroutine]
*
* Function F8147
*
8147(7BEF   )F8147 JSR   F8138      ; =-17 [Jump to subroutine relative]
8149(151B   )      BNZ   D8166      ; =+27 [Branch if not zero]
814b(798046 )      JSR/  F8046      ; =0x8046 =32838(-32698) [Jump to subroutine direct]
814e(02     )      DB    X'02'      ; =0x02 =2
814f(958816 )      LDA+  Z,22       ; [Load A indexed, displaced, direct]
8152(B58812 )      STA+  Z,18       ; [Store A indexed, displaced, direct]
8155(38     )      INA              ; [Increment A]
8156(B58816 )      STA+  Z,22       ; [Store A indexed, displaced, direct]
8159(39     )      DCA              ; [Decrement A]
815a(5120   )      SUB   B,A        ; [B - A -> A]
815c(1007   )      BL    D8165      ; =+7 [Branch on link]
815e(5582   )      XFR   Z,B        ; [Transfer Z to B]
8160(6619   )      SVC   25         ; =0x19 [Service call EXP - file expand]
8162(5D     )      XAB              ; [Transfer A to B]
8163(1502   )      BNZ   D8167      ; =+2 [Branch if not zero]
8165(3A     )D8165 CLA              ; [Clear A]
8166(09     )D8166 RSR              ; [Return from subroutine]
*
8167(8002   )D8167 LDAB= X'02'      ; =2 [Load AL with immediate]
8169(09     )      RSR              ; [Return from subroutine]
*
816a(6DA2   )W816A STX-  S-         ; [Store X indexed, pre-decremented, direct]
816c(7BCA   )      JSR   F8138      ; =-54 [Jump to subroutine relative]
816e(73C6   )      JMP   D8136      ; =-58 [Jump relative]
8170:ENDPT


 TITLE 'LIOCC'
LIOCC BEGIN 0
*
 EXT MVSSF
 EXT @LMX
 EXT @LI
 EXT @LL
*
8000(01     )      DB    X'01'      ; =0x01 =1
8001(8003   )      DW    ENTRY      ; =0x8003 =32771(-32765)
*
* Function ENTRY
*
8003(8000   )ENTRY LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8005(1573   )      BNZ   D807A      ; =+115 [Branch if not zero]
8007(29     )      DCAB             ; [Decrement AL]
8008(A3FA   )      STAB  ENTRY+1    ; =-6 [Store AL relative]
800a(A9     )      STAB+ B          ; [Store AL to address in B]
800b(952804 )      LDA+  B,4        ; [Load A indexed, displaced, direct]
800e(D52806 )      LDB+  B,6        ; [Load B indexed, displaced, direct]
8011(79EEEE )      JSR/  MVSSF      ; [external symbol] [Jump to subroutine direct]
8014(00     )      DB    X'00'      ; =0x00 =0 =NUL
8015(5582   )      XFR   Z,B        ; [Transfer Z to B]
8017(7A005A )      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
801a(0C     )      DB    X'0C'      ; =0x0c =12 [Service call GIOB - get I/O block]
801b(B00000 )      STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
801e(D50815 )      LDB+  A,21       ; [Load B indexed, displaced, direct]
8021(F303   )      STB   W8025+1    ; =+3 [Store B relative]
8023(7B58   )      JSR   F807D      ; =+88 [Jump to subroutine relative]
8025(90F201 )W8025 LDA=  X'F201'    ; =0xf201 =61953(-3583) [Load A with immediate]
8028(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
802a(88     )      LDAB+ A          ; [Load AL from address in A]
802b(4A     )      NABB             ; [AL & BL -> BL]
802c(1506   )      BNZ   D8034      ; =+6 [Branch if not zero]
802e(7A005A )      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
8031(07     )      DB    X'07'      ; =0x07 =7 [Service call WT - unconditional wait]
8032(73F1   )      JMP   W8025      ; =-15 [Jump relative]
8034(93F0   )D8034 LDA   W8025+1    ; =-16 [Load A relative]
8036(C091   )      LDBB= X'91'      ; =145(-111) [Load BL with immediate]
8038(E50801 )      STBB+ A,1        ; [Store BL indexed, displaced, direct]
803b(90012C )      LDA=  X'012C'    ; =0x012c =300 [Load A with immediate]
803e(B304   )      STA   W8043+1    ; =+4 [Store A relative]
8040(8C     )D8040 LDAB+ Z          ; [Load AL from address in Z]
8041(1727   )      BP    D806A      ; =+39 [Branch on plus]
8043(900000 )W8043 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8046(39     )      DCA              ; [Decrement A]
8047(B3FB   )      STA   W8043+1    ; =-5 [Store A relative]
8049(1406   )      BZ    D8051      ; =+6 [Branch if zero]
804b(7A005A )      JSR$  X'005A'    ; =0x005a =90 [Jump to OPSYS (SVC)]
804e(07     )      DB    X'07'      ; =0x07 =7 [Service call WT - unconditional wait]
804f(73EF   )      JMP   D8040      ; =-17 [Jump relative]
8051(3A     )D8051 CLA              ; [Clear A]
8052(A3B0   )      STAB  ENTRY+1    ; =-80 [Store AL relative]
8054(A5680D )      STAB+ Y,13       ; [Store AL indexed, displaced, direct]
8057(B5681B )      STA+  Y,27       ; [Store A indexed, displaced, direct]
805a(A56C03 )      STAB+ *Y,3       ; [Store AL indexed, displaced, indirect]
805d(AC     )      STAB+ Z          ; [Store AL to address in Z]
805e(D58806 )      LDB+  Z,6        ; [Load B indexed, displaced, direct]
8061(99     )      LDA+  B          ; [Load A from address in B]
8062(38     )      INA              ; [Increment A]
8063(B521   )      STA+  B+         ; [Store A indexed, direct, post-incremented]
8065(39     )      DCA              ; [Decrement A]
8066(58     )      AAB              ; [A + B -> B]
8067(80A0   )      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8069(A9     )      STAB+ B          ; [Store AL to address in B]
806a(CC     )D806A LDBB+ Z          ; [Load BL from address in Z]
806b(1403   )      BZ    D8070      ; =+3 [Branch if zero]
806d(718167 )      JMP/  J8167      ; =0x8167 =33127(-32409) [Jump direct]
8070(D58806 )D8070 LDB+  Z,6        ; [Load B indexed, displaced, direct]
8073(3020   )      INR   B          ; [Increment B by 1]
8075(3020   )      INR   B          ; [Increment B by 1]
8077(F58818 )      STB+  Z,24       ; [Store B indexed, displaced, direct]
807a(718115 )D807A JMP/  J8115      ; =0x8115 =33045(-32491) [Jump direct]
*
* Function F807D
*
807d(5C     )F807D XAY              ; [Transfer A to Y]
807e(D080A9 )      LDB=  W80A9      ; =0x80a9 =32937(-32599) [Load B with immediate]
8081(F5081B )      STB+  A,27       ; [Store B indexed, displaced, direct]
8084(2A     )      CLAB             ; [Clear AL]
8085(A56C05 )      STAB+ *Y,5       ; [Store AL indexed, displaced, indirect]
8088(7B16   )      JSR   F80A0      ; =+22 [Jump to subroutine relative]
808a(E50808 )      STBB+ A,8        ; [Store BL indexed, displaced, direct]
808d(5580   )      XFR   Z,A        ; [Transfer Z to A]
808f(B56810 )      STA+  Y,16       ; [Store A indexed, displaced, direct]
8092(3A     )      CLA              ; [Clear A]
8093(B58C06 )      STA+  *Z,6       ; [Store A indexed, displaced, indirect]
8096(28     )      INAB             ; [Increment AL]
8097(A5680D )      STAB+ Y,13       ; [Store AL indexed, displaced, direct]
809a(7B04   )      JSR   F80A0      ; =+4 [Jump to subroutine relative]
809c(E50808 )      STBB+ A,8        ; [Store BL indexed, displaced, direct]
809f(09     )      RSR              ; [Return from subroutine]
*
* Function F80A0
*
80a0(956815 )F80A0 LDA+  Y,21       ; [Load A indexed, displaced, direct]
80a3(C006   )      LDBB= X'06'      ; =6 [Load BL with immediate]
80a5(4A     )      NABB             ; [AL & BL -> BL]
80a6(4431   )      OREB  BL,AL      ; [BL ^ AL -> AL]
80a8(09     )      RSR              ; [Return from subroutine]
*
80a9(8001   )W80A9 LDAB= X'01'      ; =1 [Load AL with immediate]
80ab(4291   )      ANDB  ZL,AL      ; [ZL & AL -> AL]
80ad(150B   )      BNZ   D80BA      ; =+11 [Branch if not zero]
80af(9C     )      LDA+  Z          ; [Load A from address in Z]
80b0(C080   )      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
80b2(4331   )      ORIB  BL,AL      ; [BL | AL -> AL]
80b4(C01C   )      LDBB= X'1C'      ; =28 [Load BL with immediate]
80b6(4203   )      ANDB  AU,BL      ; [AU & BL -> BL]
80b8(1401   )      BZ    D80BB      ; =+1 [Branch if zero]
80ba(09     )D80BA RSR              ; [Return from subroutine]
*
80bb(C5680D )D80BB LDBB+ Y,13       ; [Load BL indexed, displaced, direct]
80be(19FA   )      BLE   D80BA      ; =-6 [Branch if less than or equal to zero]
80c0(4D     )      XABB             ; [Transfer AL to BL]
80c1(17F7   )      BP    D80BA      ; =-9 [Branch on plus]
80c3(7980CD )      JSR/  F80CD      ; =0x80cd =32973(-32563) [Jump to subroutine direct]
80c6(90012C )      LDA=  X'012C'    ; =0x012c =300 [Load A with immediate]
80c9(B18044 )      STA/  W8043+1    ; =0x8044 =32836(-32700) [Store A direct]
80cc(09     )      RSR              ; [Return from subroutine]
*
* Function F80CD
*
80cd(D56810 )F80CD LDB+  Y,16       ; [Load B indexed, displaced, direct]
80d0(5528   )      XFR   B,Z        ; [Transfer B to Z]
80d2(C09D   )      LDBB= X'9D'      ; =157(-99) [Load BL with immediate]
80d4(49     )      SABB             ; [AL - BL -> BL]
80d5(151B   )      BNZ   D80F2      ; =+27 [Branch if not zero]
80d7(A5680E )      STAB+ Y,14       ; [Store AL indexed, displaced, direct]
80da(D58806 )D80DA LDB+  Z,6        ; [Load B indexed, displaced, direct]
80dd(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
80df(58     )      AAB              ; [A + B -> B]
80e0(809D   )      LDAB= X'9D'      ; =157(-99) [Load AL with immediate]
80e2(A9     )      STAB+ B          ; [Store AL to address in B]
80e3(3A     )      CLA              ; [Clear A]
80e4(A5680D )      STAB+ Y,13       ; [Store AL indexed, displaced, direct]
80e7(A56C03 )      STAB+ *Y,3       ; [Store AL indexed, displaced, indirect]
80ea(B5681B )      STA+  Y,27       ; [Store A indexed, displaced, direct]
80ed(CC     )      LDBB+ Z          ; [Load BL from address in Z]
80ee(17CA   )      BP    D80BA      ; =-54 [Branch on plus]
80f0(AC     )      STAB+ Z          ; [Store AL to address in Z]
80f1(09     )      RSR              ; [Return from subroutine]
*
80f2(6DA2   )D80F2 STX-  S-         ; [Store X indexed, pre-decremented, direct]
80f4(658806 )      LDX+  Z,6        ; [Load X indexed, displaced, direct]
80f7(4D     )      XABB             ; [Transfer AL to BL]
80f8(9A     )      LDA+  X          ; [Load A from address in X]
80f9(38     )      INA              ; [Increment A]
80fa(B541   )      STA+  X+         ; [Store A indexed, direct, post-incremented]
80fc(5004   )      ADD   A,X        ; [A + X -> X]
80fe(E542   )      STBB- X-         ; [Store BL indexed, pre-decremented, direct]
8100(D58804 )      LDB+  Z,4        ; [Load B indexed, displaced, direct]
8103(59     )      SAB              ; [A - B -> B]
8104(160C   )      BM    D8112      ; =+12 [Branch on minus]
8106(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8108(809D   )      LDAB= X'9D'      ; =157(-99) [Load AL with immediate]
810a(A5680E )      STAB+ Y,14       ; [Store AL indexed, displaced, direct]
810d(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
810f(EC     )      STBB+ Z          ; [Store BL to address in Z]
8110(73C8   )      JMP   D80DA      ; =-56 [Jump relative]
8112(65A1   )D8112 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8114(09     )      RSR              ; [Return from subroutine]
*
8115(91EEEE )J8115 LDA/  @LMX       ; [external symbol] [Load A direct]
8118(B328   )      STA   W8141+1    ; =+40 [Store A relative]
811a(91EEEE )      LDA/  @LMX       ; [external symbol] [Load A direct]
811d(B323   )      STA   W8141+1    ; =+35 [Store A relative]
811f(D58818 )      LDB+  Z,24       ; [Load B indexed, displaced, direct]
8122(F58814 )      STB+  Z,20       ; [Store B indexed, displaced, direct]
8125(5524   )      XFR   B,X        ; [Transfer B to X]
8127(D0EEEE )      LDB=  @LI        ; [external symbol] [Load B with immediate]
812a(5526   )      XFR   B,Y        ; [Transfer B to Y]
812c(8541   )D812C LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
812e(1420   )      BZ    D8150      ; =+32 [Branch if zero]
8130(C09D   )      LDBB= X'9D'      ; =157(-99) [Load BL with immediate]
8132(49     )      SABB             ; [AL - BL -> BL]
8133(141D   )      BZ    D8152      ; =+29 [Branch if zero]
8135(C09E   )      LDBB= X'9E'      ; =158(-98) [Load BL with immediate]
8137(49     )      SABB             ; [AL - BL -> BL]
8138(141D   )      BZ    D8157      ; =+29 [Branch if zero]
813a(C09F   )      LDBB= X'9F'      ; =159(-97) [Load BL with immediate]
813c(49     )      SABB             ; [AL - BL -> BL]
813d(1418   )      BZ    D8157      ; =+24 [Branch if zero]
813f(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8141(900000 )W8141 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8144(39     )      DCA              ; [Decrement A]
8145(B3FB   )      STA   W8141+1    ; =-5 [Store A relative]
8147(15E3   )      BNZ   D812C      ; =-29 [Branch if not zero]
8149(80AA   )      LDAB= X'AA'      ; =170(-86) ='*' [Load AL with immediate]
814b(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
814d(EC     )      STBB+ Z          ; [Store BL to address in Z]
814e(7307   )      JMP   D8157      ; =+7 [Jump relative]
8150(80A0   )D8150 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8152(2230   )D8152 CLRB  BL         ; [Clear BL]
8154(E18004 )      STBB/ ENTRY+1    ; =0x8004 =32772(-32764) [Store BL direct]
8157(6D8818 )D8157 STX+  Z,24       ; [Store X indexed, displaced, direct]
815a(A1EEEE )      STAB/ @LI        ; [external symbol] [Store AL direct]
815d(2A     )      CLAB             ; [Clear AL]
815e(AB     )      STAB+ Y          ; [Store AL to address in Y]
815f(958814 )      LDA+  Z,20       ; [Load A indexed, displaced, direct]
8162(5140   )      SUB   X,A        ; [X - A -> A]
8164(B1EEEE )      STA/  @LL        ; [external symbol] [Store A direct]
8167(95A1   )J8167 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8169(5E     )      XAZ              ; [Transfer A to Z]
816a(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
816c(5C     )      XAY              ; [Transfer A to Y]
816d(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
816f(09     )      RSR              ; [Return from subroutine]
*
8170:ENDPT


 TITLE 'EDIT'
EDIT BEGIN 0
*
 EXT ZERO
*
*
* Function EDIT
*
8000(9541   )EDIT  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B31E   )      STA   W8022      ; =+30 [Store A relative]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B368   )      STA   W8070      ; =+104 [Store A relative]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(B366   )      STA   W8072      ; =+102 [Store A relative]
800c(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800e(C0B0   )      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
8010(90000A )      LDA=  X'000A'    ; =0x000a =10 [Load A with immediate]
8013(608075 )      LDX=  W8075      ; =0x8075 =32885(-32651) [Load X with immediate]
8016(E541   )D8016 STBB+ X+         ; [Store BL indexed, direct, post-incremented]
8018(39     )      DCA              ; [Decrement A]
8019(15FB   )      BNZ   D8016      ; =-5 [Branch if not zero]
801b(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
801d(33     )      DB    X'33'      ; =0x33 =51 [Service call NC - CPL encode]
801e(8074   )      DW    S8074      ; =0x8074 =32884(-32652) [address of string]
8020(806C   )      DW    L806C      ; =0x806c =32876(-32660) [address of format]
8022(EEEE   )W8022 DW    ZERO       ; [external symbol] [address of argument]
8024(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8026(934A   )      LDA   W8072      ; =+74 [Load A relative]
8028(5C     )      XAY              ; [Transfer A to Y]
8029(7B1C   )      JSR   F8047      ; =+28 [Jump to subroutine relative]
802b(A353   )      STAB  B8080      ; =+83 [Store AL relative]
802d(7B18   )      JSR   F8047      ; =+24 [Jump to subroutine relative]
802f(A350   )      STAB  B8081      ; =+80 [Store AL relative]
8031(3A     )      CLA              ; [Clear A]
8032(A34E   )      STAB  B8082      ; =+78 [Store AL relative]
8034(A34D   )      STAB  B8083      ; =+77 [Store AL relative]
8036(90807F )      LDA=  W807F      ; =0x807f =32895(-32641) [Load A with immediate]
8039(5E     )      XAZ              ; [Transfer A to Z]
803a(80A3   )      LDAB= X'A3'      ; =163(-93) ='#' [Load AL with immediate]
803c(C561   )D803C LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
803e(1445   )      BZ    D8085      ; =+69 [Branch if zero]
8040(49     )      SABB             ; [AL - BL -> BL]
8041(15F9   )      BNZ   D803C      ; =-7 [Branch if not zero]
8043(3180   )      DCR   Z          ; [Decrement Z by 1]
8045(73F5   )      JMP   D803C      ; =-11 [Jump relative]
*
* Function F8047
*
8047(8561   )F8047 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
8049(1508   )      BNZ   D8053      ; =+8 [Branch if not zero]
804b(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
804d(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
804f(91005A )      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8052(5E     )      XAZ              ; [Transfer A to Z]
8053(09     )D8053 RSR              ; [Return from subroutine]
*
* Function F8054
*
8054(8581   )F8054 LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8056(D08076 )      LDB=  W8076      ; =0x8076 =32886(-32650) [Load B with immediate]
8059(5182   )      SUB   Z,B        ; [Z - B -> B]
805b(1702   )      BP    D805F      ; =+2 [Branch on plus]
805d(80B0   )      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
805f(4511   )D805F XFRB  AL,AL      ; [Transfer AL to AL]
8061(1508   )      BNZ   D806B      ; =+8 [Branch if not zero]
8063(94BD   )      LDA*  W8022      ; =-67 [Load A relative indirect]
8065(1604   )      BM    D806B      ; =+4 [Branch on minus]
8067(8000   )      LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8069(A317   )      STAB  B8082      ; =+23 [Store AL relative]
806b(09     )D806B RSR              ; [Return from subroutine]
*
806c(0300   )L806C DW    X'0300'    ; =0x0300 =768
806e(0B00   )      DW    X'0B00'    ; =0x0b00 =2816
8070(       )W8070 DS    2          ; =0x0002 [Uninitialized memory]
8072(       )W8072 DS    2          ; =0x0002 [Uninitialized memory]
8074(       )S8074 DS    1          ; =0x0001 [Uninitialized memory]
8075(       )W8075 DS    1          ; =0x0001 [Uninitialized memory]
8076(       )W8076 DS    9          ; =0x0009 [Uninitialized memory]
807f(00     )W807F DB    X'00'      ; =0x00 =0 =NUL
8080(       )B8080 DS    1          ; =0x0001 [Uninitialized memory]
8081(       )B8081 DS    1          ; =0x0001 [Uninitialized memory]
8082(       )B8082 DS    1          ; =0x0001 [Uninitialized memory]
8083(       )B8083 DS    1          ; =0x0001 [Uninitialized memory]
8084(       )B8084 DS    1          ; =0x0001 [Uninitialized memory]
*
8085(93EB   )D8085 LDA   W8072      ; =-21 [Load A relative]
8087(38     )      INA              ; [Increment A]
8088(38     )      INA              ; [Increment A]
8089(5C     )      XAY              ; [Transfer A to Y]
808a(63E4   )      LDX   W8070      ; =-28 [Load X relative]
808c(83F2   )      LDAB  B8080      ; =-14 [Load AL relative]
808e(A541   )      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
8090(7BC2   )D8090 JSR   F8054      ; =-62 [Jump to subroutine relative]
8092(A3F0   )      STAB  B8084      ; =-16 [Store AL relative]
8094(7BB1   )D8094 JSR   F8047      ; =-79 [Jump to subroutine relative]
8096(C0A3   )      LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
8098(49     )      SABB             ; [AL - BL -> BL]
8099(1425   )      BZ    D80C0      ; =+37 [Branch if zero]
809b(C0C0   )      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
809d(49     )      SABB             ; [AL - BL -> BL]
809e(140F   )      BZ    D80AF      ; =+15 [Branch if zero]
80a0(C0BF   )      LDBB= X'BF'      ; =191(-65) ='?' [Load BL with immediate]
80a2(49     )      SABB             ; [AL - BL -> BL]
80a3(1412   )      BZ    D80B7      ; =+18 [Branch if zero]
80a5(C3DB   )      LDBB  B8082      ; =-37 [Load BL relative]
80a7(1502   )      BNZ   D80AB      ; =+2 [Branch if not zero]
80a9(83D5   )      LDAB  B8080      ; =-43 [Load AL relative]
80ab(A541   )D80AB STAB+ X+         ; [Store AL indexed, direct, post-incremented]
80ad(73E5   )      JMP   D8094      ; =-27 [Jump relative]
80af(80FF   )D80AF LDAB= X'FF'      ; =255(-1) [Load AL with immediate]
80b1(A3CF   )      STAB  B8082      ; =-49 [Store AL relative]
80b3(7B26   )      JSR   F80DB      ; =+38 [Jump to subroutine relative]
80b5(73DD   )      JMP   D8094      ; =-35 [Jump relative]
80b7(83C9   )D80B7 LDAB  B8082      ; =-55 [Load AL relative]
80b9(2B     )      IVAB             ; [Invert AL]
80ba(A3C6   )      STAB  B8082      ; =-58 [Store AL relative]
80bc(7B1D   )      JSR   F80DB      ; =+29 [Jump to subroutine relative]
80be(73D4   )      JMP   D8094      ; =-44 [Jump relative]
80c0(83C2   )D80C0 LDAB  B8084      ; =-62 [Load AL relative]
80c2(C0B0   )      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
80c4(49     )      SABB             ; [AL - BL -> BL]
80c5(140A   )      BZ    D80D1      ; =+10 [Branch if zero]
80c7(C0FF   )      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
80c9(E3B7   )      STBB  B8082      ; =-73 [Store BL relative]
80cb(7B0E   )      JSR   F80DB      ; =+14 [Jump to subroutine relative]
80cd(A541   )D80CD STAB+ X+         ; [Store AL indexed, direct, post-incremented]
80cf(73BF   )      JMP   D8090      ; =-65 [Jump relative]
80d1(83AD   )D80D1 LDAB  B8080      ; =-83 [Load AL relative]
80d3(C3AD   )      LDBB  B8082      ; =-83 [Load BL relative]
80d5(14F6   )      BZ    D80CD      ; =-10 [Branch if zero]
80d7(80B0   )      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
80d9(73F2   )      JMP   D80CD      ; =-14 [Jump relative]
*
* Function F80DB
*
80db(C3A6   )F80DB LDBB  B8083      ; =-90 [Load BL relative]
80dd(1510   )      BNZ   D80EF      ; =+16 [Branch if not zero]
80df(C0FF   )      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
80e1(E3A0   )      STBB  B8083      ; =-96 [Store BL relative]
80e3(C39C   )      LDBB  B8081      ; =-100 [Load BL relative]
80e5(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
80e7(654802 )      LDX+  X,2        ; [Load X indexed, displaced, direct]
80ea(E548FF )      STBB+ X,-1       ; [Store BL indexed, displaced, direct]
80ed(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
80ef(09     )D80EF RSR              ; [Return from subroutine]
*
80f0(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
80f2:ENDPT


 TITLE '@CUR'
@CUR BEGIN 0
*
*
* Function @CUR
*
8000(9541   )@CUR  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B30D   )      STA   W8011      ; =+13 [Store A relative]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8008(1403   )      BZ    D800D      ; =+3 [Branch if zero]
800a(950802 )      LDA+  A,2        ; [Load A indexed, displaced, direct]
800d(B306   )D800D STA   W8015      ; =+6 [Store A relative]
800f(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
8011(0000   )W8011 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of FCB]
8013(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
8015(0000   )W8015 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [row address or value]
8017(09     )      RSR              ; [Return from subroutine]
*
8018:ENDPT


 TITLE '@ENF'
@ENF BEGIN 0
*
*
* Function @ENF
*
8000(9541   )@ENF  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B30B   )      STA   W800F      ; =+11 [Store A relative]
8004(B310   )      STA   W8016      ; =+16 [Store A relative]
8006(D5080A )      LDB+  A,10       ; [Load B indexed, displaced, direct]
8009(3127   )      DCR   B,8        ; [Decrement B by 8]
800b(1406   )      BZ    D8013      ; =+6 [Branch if zero]
800d(6638   )      SVC   56         ; =0x38 [Service call WB - CPL binary write]
800f(0000   )W800F DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of FCB]
8011(8019   )      DW    L8019      ; =0x8019 =32793(-32743) [address of record]
*
8013(663A   )D8013 SVC   58         ; =0x3A [Service call CT - CPL control function]
8015(0B     )      DB    X'0B'      ; =0x0b =11 [Selector: endfile]
8016(0000   )W8016 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of FCB]
8018(09     )      RSR              ; [Return from subroutine]
*
8019(0002   )L8019 DW    X'0002'    ; =0x0002 =2
801b(00     )      DB    X'00'      ; =0x00 =0 =NUL
801c(0284   )      DW    X'0284'    ; =0x0284 =644
801e(8D     )      DB    X'8D'      ; =0x8d =141(-115) =CR
801f:ENDPT


 TITLE '@NTP'
@NTP BEGIN 0
*
*
* Function @NTP
*
8000(8541   )@NTP  LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8002(A30B   )      STAB  B800F      ; =+11 [Store AL relative]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B308   )      STA   W8010      ; =+8 [Store A relative]
8008(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800a(F50808 )      STB+  A,8        ; [Store B indexed, displaced, direct]
800d(663A   )      SVC   58         ; =0x3A [Service call CT - CPL control function]
800f(00     )B800F DB    X'00'      ; =0x00 =0 =NUL [Selector: unknown]
8010(0000   )W8010 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of FCB]
8012(09     )      RSR              ; [Return from subroutine]
*
8013:ENDPT


 TITLE 'PST'
PST BEGIN 0
*
@PV EQU X'80E3'
 ENT @PV
*
*
* Function PST
*
8000(81F0E1 )PST   LDAB/ X'F0E1'    ; =0xf0e1 =61665(-3871) ='p','a' [Load AL direct]
8003(2C     )      SRAB             ; [Arithmetic right shift AL]
8004(2C     )      SRAB             ; [Arithmetic right shift AL]
8005(11F9   )      BNL   PST        ; =-7 [Branch on no link]
8007(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8009(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800b(5582   )      XFR   Z,B        ; [Transfer Z to B]
800d(F5A2   )      STB-  S-         ; [Store B indexed, pre-decremented, direct]
800f(6501   )      LDX+  A+         ; [Load X indexed, direct, post-incremented]
8011(5E     )      XAZ              ; [Transfer A to Z]
8012(D08CC0 )      LDB=  X'8CC0'    ; =0x8cc0 =36032(-29504) =FF,'@' [Load B with immediate]
8015(9C     )      LDA+  Z          ; [Load A from address in Z]
8016(59     )      SAB              ; [A - B -> B]
8017(150E   )      BNZ   D8027      ; =+14 [Branch if not zero]
8019(4503   )      XFRB  AU,BL      ; [Transfer AU to BL]
801b(E1F0E0 )      STBB/ X'F0E0'    ; =0xf0e0 =61664(-3872) ='p','`' [Store BL direct]
801e(A1F0E0 )      STAB/ X'F0E0'    ; =0xf0e0 =61664(-3872) ='p','`' [Store AL direct]
8021(95A1   )D8021 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8023(5E     )      XAZ              ; [Transfer A to Z]
8024(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8026(09     )      RSR              ; [Return from subroutine]
*
8027(A1F0E2 )D8027 STAB/ X'F0E2'    ; =0xf0e2 =61666(-3870) ='p','b' [Store AL direct]
802a(8581   )D802A LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
802c(A1F0E0 )      STAB/ X'F0E0'    ; =0xf0e0 =61664(-3872) ='p','`' [Store AL direct]
802f(3F     )      DCX              ; [Decrement X]
8030(18F8   )      BGZ   D802A      ; =-8 [Branch if greater than zero]
8032(80A0   )      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8034(A1F0E0 )      STAB/ X'F0E0'    ; =0xf0e0 =61664(-3872) ='p','`' [Store AL direct]
8037(808D   )      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8039(A1F0E0 )      STAB/ X'F0E0'    ; =0xf0e0 =61664(-3872) ='p','`' [Store AL direct]
803c(73E3   )      JMP   D8021      ; =-29 [Jump relative]
*
803e(C4D0   )      DC    'DP'       ; hex:c4d0 dec:50384(-48)
8040:ENDPT


 TITLE 'CARDR'
CARDR BEGIN 0
*
*
* Function CARDR
*
8000(A1F044 )CARDR STAB/ X'F044'    ; =0xf044 =61508(-4028) [Store AL direct]
8003(A1F042 )      STAB/ X'F042'    ; =0xf042 =61506(-4030) [Store AL direct]
8006(91F040 )      LDA/  X'F040'    ; =0xf040 =61504(-4032) [Load A direct]
8009(81F042 )      LDAB/ X'F042'    ; =0xf042 =61506(-4030) [Load AL direct]
800c(C010   )      LDBB= X'10'      ; =16 [Load BL with immediate]
800e(4A     )      NABB             ; [AL & BL -> BL]
800f(1404   )      BZ    D8015      ; =+4 [Branch if zero]
8011(06     )      SL               ; [Set link]
8012(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8014(09     )      RSR              ; [Return from subroutine]
*
8015(81F042 )D8015 LDAB/ X'F042'    ; =0xf042 =61506(-4030) [Load AL direct]
8018(C020   )      LDBB= X'20'      ; =32 [Load BL with immediate]
801a(4A     )      NABB             ; [AL & BL -> BL]
801b(14F8   )      BZ    D8015      ; =-8 [Branch if zero]
801d(9080E9 )      LDA=  W80E9      ; =0x80e9 =33001(-32535) [Load A with immediate]
8020(5C     )      XAY              ; [Transfer A to Y]
8021(8050   )      LDAB= X'50'      ; =80 [Load AL with immediate]
8023(4E     )      XAZB             ; [Transfer AL to ZL]
8024(A1F043 )      STAB/ X'F043'    ; =0xf043 =61507(-4029) [Store AL direct]
8027(81F042 )D8027 LDAB/ X'F042'    ; =0xf042 =61506(-4030) [Load AL direct]
802a(C010   )      LDBB= X'10'      ; =16 [Load BL with immediate]
802c(4A     )      NABB             ; [AL & BL -> BL]
802d(15E6   )      BNZ   D8015      ; =-26 [Branch if not zero]
802f(4D     )      XABB             ; [Transfer AL to BL]
8030(17F5   )      BP    D8027      ; =-11 [Branch on plus]
8032(A1F044 )      STAB/ X'F044'    ; =0xf044 =61508(-4028) [Store AL direct]
8035(91F040 )      LDA/  X'F040'    ; =0xf040 =61504(-4032) [Load A direct]
8038(B561   )      STA+  Y+         ; [Store A indexed, direct, post-incremented]
803a(2190   )      DCRB  ZL         ; [Decrement ZL by 1]
803c(18E9   )      BGZ   D8027      ; =-23 [Branch if greater than zero]
803e(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8040(5C     )      XAY              ; [Transfer A to Y]
8041(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8043(5560   )      XFR   Y,A        ; [Transfer Y to A]
8045(39     )      DCA              ; [Decrement A]
8046(39     )      DCA              ; [Decrement A]
8047(B180DF )      STA/  W80DE+1    ; =0x80df =32991(-32545) [Store A direct]
804a(900050 )      LDA=  X'0050'    ; =0x0050 =80 [Load A with immediate]
804d(4E     )      XAZB             ; [Transfer AL to ZL]
804e(9080E9 )      LDA=  W80E9      ; =0x80e9 =33001(-32535) [Load A with immediate]
8051(B180E7 )      STA/  W80E7      ; =0x80e7 =32999(-32537) [Store A direct]
8054(7311   )      JMP   D8067      ; =+17 [Jump relative]
8056(9180E7 )D8056 LDA/  W80E7      ; =0x80e7 =32999(-32537) [Load A direct]
8059(38     )      INA              ; [Increment A]
805a(B180E7 )      STA/  W80E7      ; =0x80e7 =32999(-32537) [Store A direct]
805d(80DF   )D805D LDAB= X'DF'      ; =223(-33) =DEL [Load AL with immediate]
805f(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8061(2190   )      DCRB  ZL         ; [Decrement ZL by 1]
8063(1802   )      BGZ   D8067      ; =+2 [Branch if greater than zero]
8065(7365   )      JMP   D80CC      ; =+101 [Jump relative]
8067(9180E7 )D8067 LDA/  W80E7      ; =0x80e7 =32999(-32537) [Load A direct]
806a(C501   )      LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
806c(B379   )      STA   W80E7      ; =+121 [Store A relative]
806e(800F   )      LDAB= X'0F'      ; =15 [Load AL with immediate]
8070(4A     )      NABB             ; [AL & BL -> BL]
8071(8006   )      LDAB= X'06'      ; =6 [Load AL with immediate]
8073(4131   )      SUBB  BL,AL      ; [BL - AL -> AL]
8075(14DF   )      BZ    D8056      ; =-33 [Branch if zero]
8077(8007   )      LDAB= X'07'      ; =7 [Load AL with immediate]
8079(4131   )      SUBB  BL,AL      ; [BL - AL -> AL]
807b(14D9   )      BZ    D8056      ; =-39 [Branch if zero]
807d(8008   )      LDAB= X'08'      ; =8 [Load AL with immediate]
807f(4231   )      ANDB  BL,AL      ; [BL & AL -> AL]
8081(1404   )      BZ    D8087      ; =+4 [Branch if zero]
8083(2130   )      DCRB  BL         ; [Decrement BL by 1]
8085(2130   )      DCRB  BL         ; [Decrement BL by 1]
8087(8008   )D8087 LDAB= X'08'      ; =8 [Load AL with immediate]
8089(4231   )      ANDB  BL,AL      ; [BL & AL -> AL]
808b(15C9   )      BNZ   D8056      ; =-55 [Branch if not zero]
808d(E356   )      STBB  B80E5      ; =+86 [Store BL relative]
808f(608189 )      LDX=  W8189      ; =0x8189 =33161(-32375) [Load X with immediate]
8092(D353   )      LDB   W80E7      ; =+83 [Load B relative]
8094(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
8096(F34F   )      STB   W80E7      ; =+79 [Store B relative]
8098(A5480F )      STAB+ X,15       ; [Store AL indexed, displaced, direct]
809b(C541   )D809B LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
809d(49     )      SABB             ; [AL - BL -> BL]
809e(15FB   )      BNZ   D809B      ; =-5 [Branch if not zero]
80a0(90818A )      LDA=  W818A      ; =0x818a =33162(-32374) [Load A with immediate]
80a3(5140   )      SUB   X,A        ; [X - A -> A]
80a5(A33F   )      STAB  B80E6      ; =+63 [Store AL relative]
80a7(C00F   )      LDBB= X'0F'      ; =15 [Load BL with immediate]
80a9(49     )      SABB             ; [AL - BL -> BL]
80aa(14B1   )      BZ    D805D      ; =-79 [Branch if zero]
80ac(C338   )      LDBB  B80E6      ; =+56 [Load BL relative]
80ae(8335   )      LDAB  B80E5      ; =+53 [Load AL relative]
80b0(2C     )      SRAB             ; [Arithmetic right shift AL]
80b1(1106   )      BNL   D80B9      ; =+6 [Branch on no link]
80b3(C331   )      LDBB  B80E6      ; =+49 [Load BL relative]
80b5(15A6   )      BNZ   D805D      ; =-90 [Branch if not zero]
80b7(C00F   )      LDBB= X'0F'      ; =15 [Load BL with immediate]
80b9(2D     )D80B9 SLAB             ; [Left shift AL]
80ba(2D     )      SLAB             ; [Left shift AL]
80bb(2D     )      SLAB             ; [Left shift AL]
80bc(2D     )      SLAB             ; [Left shift AL]
80bd(4313   )      ORIB  AL,BL      ; [AL | BL -> BL]
80bf(2220   )      CLRB  BU         ; [Clear BU]
80c1(908199 )      LDA=  S8199      ; =0x8199 =33177(-32359) [Load A with immediate]
80c4(58     )      AAB              ; [A + B -> B]
80c5(89     )      LDAB+ B          ; [Load AL from address in B]
80c6(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
80c8(2190   )      DCRB  ZL         ; [Decrement ZL by 1]
80ca(189B   )      BGZ   D8067      ; =-101 [Branch if greater than zero]
80cc(900050 )D80CC LDA=  X'0050'    ; =0x0050 =80 [Load A with immediate]
80cf(5E     )      XAZ              ; [Transfer A to Z]
80d0(80A0   )      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
80d2(C562   )D80D2 LDBB- Y-         ; [Load BL indexed, pre-decremented, direct]
80d4(3180   )      DCR   Z          ; [Decrement Z by 1]
80d6(1403   )      BZ    D80DB      ; =+3 [Branch if zero]
80d8(49     )      SABB             ; [AL - BL -> BL]
80d9(14F7   )      BZ    D80D2      ; =-9 [Branch if zero]
80db(5580   )D80DB XFR   Z,A        ; [Transfer Z to A]
80dd(38     )      INA              ; [Increment A]
80de(B10000 )W80DE STA/  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A direct]
80e1(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
80e3(07     )      RL               ; [Reset link]
80e4(09     )      RSR              ; [Return from subroutine]
*
80e5(       )B80E5 DS    1          ; =0x0001 [Uninitialized memory]
80e6(       )B80E6 DS    1          ; =0x0001 [Uninitialized memory]
80e7(       )W80E7 DS    2          ; =0x0002 [Uninitialized memory]
80e9(       )W80E9 DS    160        ; =0x00a0 [Uninitialized memory]
8189(00     )W8189 DB    X'00'      ; =0x00 =0 =NUL
818a(0102   )W818A DW    X'0102'    ; =0x0102 =258
818c(0406   )      DW    X'0406'    ; =0x0406 =1030
818e(080A   )      DW    X'080A'    ; =0x080a =2058
8190(1012   )      DW    X'1012'    ; =0x1012 =4114
8192(2022   )      DW    X'2022'    ; =0x2022 =8226
8194(4042   )      DW    X'4042'    ; =0x4042 =16450
8196(8082   )      DW    X'8082'    ; =0x8082 =32898(-32638)
8198(00     )      DB    X'00'      ; =0x00 =0 =NUL
8199(A0B9B8+)S8199 DC    ' 987"6=5' ; hex:a0b9b8b7a2b6bdb5
81a1(A7     )      DB    X'A7'      ; =0xa7 =167(-89) ='
81a2(B4C0B3+)      DC    '4@3#2:10ZYX?W>V'
81b1(DF     )      DB    X'DF'      ; =0xdf =223(-33) =DEL
81b2(D5A5D4+)      DC    'U%T,S^/-RQP]O;N)M*L$K!J&IHG\F+E(D<C.B[A'
81d9:ENDPT


 TITLE 'TINT'
TINT BEGIN 0
*
 ENT TRED
 ENT TBKS
 ENT TWRT
 ENT TWFM
 ENT TREW
*
 EXT MVSSF
 EXT TRIM
 EXT TST
*
*
* Function TINT
*
8000(A1F200 )TINT  STAB/ X'F200'    ; =0xf200 =61952(-3584) ='r',NUL [Store AL direct]
8003(2A     )      CLAB             ; [Clear AL]
8004(09     )      RSR              ; [Return from subroutine]
*
* Function TRED
*
8005(8010   )TRED  LDAB= X'10'      ; =16 [Load AL with immediate]
8007(A335   )      STAB  B803D+1    ; =+53 [Store AL relative]
8009(7B71   )D8009 JSR   D807C      ; =+113 [Jump to subroutine relative]
800b(DA     )      LDB+  X          ; [Load B from address in X]
800c(F319   )      STB   W8027      ; =+25 [Store B relative]
800e(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8010(3B     )      IVA              ; [Invert A]
8011(B1F208 )      STA/  X'F208'    ; =0xf208 =61960(-3576) [Store A direct]
8014(3B     )      IVA              ; [Invert A]
8015(F1F20A )      STB/  X'F20A'    ; =0xf20a =61962(-3574) [Store B direct]
8018(79EEEE )      JSR/  MVSSF      ; [external symbol] [Jump to subroutine direct]
801b(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
801c(2A     )      CLAB             ; [Clear AL]
801d(A1F201 )      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
8020(7B5A   )      JSR   D807C      ; =+90 [Jump to subroutine relative]
8022(A5A2   )      STAB- S-         ; [Store AL indexed, pre-decremented, direct]
8024(79EEEE )      JSR/  TRIM       ; [external symbol] [Jump to subroutine direct]
8027(0000   )W8027 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8029(DA     )      LDB+  X          ; [Load B from address in X]
802a(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
802c(58     )      AAB              ; [A + B -> B]
802d(2A     )      CLAB             ; [Clear AL]
802e(A9     )      STAB+ B          ; [Store AL to address in B]
802f(85A1   )      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8031(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
8033(4A     )      NABB             ; [AL & BL -> BL]
8034(1507   )      BNZ   B803D      ; =+7 [Branch if not zero]
8036(C040   )      LDBB= X'40'      ; =64 [Load BL with immediate]
8038(4A     )      NABB             ; [AL & BL -> BL]
8039(140E   )      BZ    D8049      ; =+14 [Branch if zero]
803b(7B20   )      JSR   TBKS       ; =+32 [Jump to subroutine relative]
803d(8000   )B803D LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
803f(29     )      DCAB             ; [Decrement AL]
8040(A3FC   )      STAB  B803D+1    ; =-4 [Store AL relative]
8042(18C5   )      BGZ   D8009      ; =-59 [Branch if greater than zero]
8044(3E     )      INX              ; [Increment X]
8045(3E     )      INX              ; [Increment X]
8046(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
8048(09     )      RSR              ; [Return from subroutine]
*
8049(3E     )D8049 INX              ; [Increment X]
804a(3E     )      INX              ; [Increment X]
804b(C004   )      LDBB= X'04'      ; =4 [Load BL with immediate]
804d(4A     )      NABB             ; [AL & BL -> BL]
804e(1403   )      BZ    D8053      ; =+3 [Branch if zero]
8050(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
8052(09     )      RSR              ; [Return from subroutine]
*
8053(C020   )D8053 LDBB= X'20'      ; =32 [Load BL with immediate]
8055(4A     )      NABB             ; [AL & BL -> BL]
8056(1403   )      BZ    D805B      ; =+3 [Branch if zero]
8058(8003   )      LDAB= X'03'      ; =3 [Load AL with immediate]
805a(09     )      RSR              ; [Return from subroutine]
*
805b(2A     )D805B CLAB             ; [Clear AL]
805c(09     )      RSR              ; [Return from subroutine]
*
* Function TBKS
*
805d(7B1D   )TBKS  JSR   D807C      ; =+29 [Jump to subroutine relative]
805f(C010   )      LDBB= X'10'      ; =16 [Load BL with immediate]
8061(4A     )      NABB             ; [AL & BL -> BL]
8062(1513   )      BNZ   D8077      ; =+19 [Branch if not zero]
8064(908079 )      LDA=  W8079      ; =0x8079 =32889(-32647) [Load A with immediate]
8067(B1F20A )      STA/  X'F20A'    ; =0xf20a =61962(-3574) [Store A direct]
806a(3A     )      CLA              ; [Clear A]
806b(38     )      INA              ; [Increment A]
806c(3B     )      IVA              ; [Invert A]
806d(B1F208 )      STA/  X'F208'    ; =0xf208 =61960(-3576) [Store A direct]
8070(8003   )      LDAB= X'03'      ; =3 [Load AL with immediate]
8072(A1F201 )      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
8075(7B05   )      JSR   D807C      ; =+5 [Jump to subroutine relative]
8077(2A     )D8077 CLAB             ; [Clear AL]
8078(09     )      RSR              ; [Return from subroutine]
*
8079(       )W8079 DS    3          ; =0x0003 [Uninitialized memory]
*
807c(81F201 )D807C LDAB/ X'F201'    ; =0xf201 =61953(-3583) [Load AL direct]
807f(16FB   )      BM    D807C      ; =-5 [Branch on minus]
8081(2C     )      SRAB             ; [Arithmetic right shift AL]
8082(11F8   )      BNL   D807C      ; =-8 [Branch on no link]
8084(2D     )      SLAB             ; [Left shift AL]
8085(09     )      RSR              ; [Return from subroutine]
*
* Function TWRT
*
8086(7BF4   )TWRT  JSR   D807C      ; =-12 [Jump to subroutine relative]
8088(7B24   )      JSR   F80AE      ; =+36 [Jump to subroutine relative]
808a(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
808c(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
808e(3B     )      IVA              ; [Invert A]
808f(B1F208 )      STA/  X'F208'    ; =0xf208 =61960(-3576) [Store A direct]
8092(F1F20A )      STB/  X'F20A'    ; =0xf20a =61962(-3574) [Store B direct]
8095(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
8097(A1F201 )      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
809a(7BE0   )D809A JSR   D807C      ; =-32 [Jump to subroutine relative]
809c(C020   )      LDBB= X'20'      ; =32 [Load BL with immediate]
809e(4A     )      NABB             ; [AL & BL -> BL]
809f(1403   )      BZ    D80A4      ; =+3 [Branch if zero]
80a1(8003   )      LDAB= X'03'      ; =3 [Load AL with immediate]
80a3(09     )      RSR              ; [Return from subroutine]
*
80a4(C040   )D80A4 LDBB= X'40'      ; =64 [Load BL with immediate]
80a6(4A     )      NABB             ; [AL & BL -> BL]
80a7(1403   )      BZ    D80AC      ; =+3 [Branch if zero]
80a9(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
80ab(09     )      RSR              ; [Return from subroutine]
*
80ac(2A     )D80AC CLAB             ; [Clear AL]
80ad(09     )      RSR              ; [Return from subroutine]
*
* Function F80AE
*
80ae(C008   )F80AE LDBB= X'08'      ; =8 [Load BL with immediate]
80b0(4A     )      NABB             ; [AL & BL -> BL]
80b1(140C   )      BZ    D80BF      ; =+12 [Branch if zero]
80b3(79EEEE )      JSR/  TST        ; [external symbol] [Jump to subroutine direct]
80b6(80C0   )      DW    W80C0      ; =0x80c0 =32960(-32576)
80b8(0500   )      DW    X'0500'    ; =0x0500 =1280
80ba(04     )      DB    X'04'      ; =0x04 =4
80bb(7BBF   )      JSR   D807C      ; =-65 [Jump to subroutine relative]
80bd(73EF   )      JMP   F80AE      ; =-17 [Jump relative]
80bf(09     )D80BF RSR              ; [Return from subroutine]
*
80c0(0012   )W80C0 DW    X'0012'    ; =0x0012 =18
80c2(CDC1C7+)      DC    'MAG TAPE PROTECTED'
*
*
* Function TWFM
*
80d4(7BA6   )TWFM  JSR   D807C      ; =-90 [Jump to subroutine relative]
80d6(7BD6   )      JSR   F80AE      ; =-42 [Jump to subroutine relative]
80d8(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
80da(A1F201 )      STAB/ X'F201'    ; =0xf201 =61953(-3583) [Store AL direct]
80dd(73BB   )      JMP   D809A      ; =-69 [Jump relative]
*
* Function TREW
*
80df(7B9B   )TREW  JSR   D807C      ; =-101 [Jump to subroutine relative]
80e1(A1F202 )      STAB/ X'F202'    ; =0xf202 =61954(-3582) [Store AL direct]
80e4(7B96   )      JSR   D807C      ; =-106 [Jump to subroutine relative]
80e6(2A     )      CLAB             ; [Clear AL]
80e7(09     )      RSR              ; [Return from subroutine]
*
80e8:ENDPT


 TITLE 'ATOE'
ATOE BEGIN 0
*
 EXT CODTBL
*
*
* Function ATOE
*
8000(5580   )ATOE  XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800c(5C     )      XAY              ; [Transfer A to Y]
800d(6561   )      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
800f(3F     )D800F DCX              ; [Decrement X]
8010(1615   )      BM    D8027      ; =+21 [Branch on minus]
8012(90EEEE )      LDA=  CODTBL     ; [external symbol] [Load A with immediate]
8015(5E     )      XAZ              ; [Transfer A to Z]
8016(8B     )      LDAB+ Y          ; [Load AL from address in Y]
8017(D581   )D8017 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
8019(1506   )      BNZ   D8021      ; =+6 [Branch if not zero]
801b(C06D   )      LDBB= X'6D'      ; =109 [Load BL with immediate]
801d(E561   )D801D STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
801f(73EE   )      JMP   D800F      ; =-18 [Jump relative]
8021(4112   )D8021 SUBB  AL,BU      ; [AL - BU -> BU]
8023(15F2   )      BNZ   D8017      ; =-14 [Branch if not zero]
8025(73F6   )      JMP   D801D      ; =-10 [Jump relative]
8027(65A1   )D8027 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8029(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802b(5C     )      XAY              ; [Transfer A to Y]
802c(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802e(5E     )      XAZ              ; [Transfer A to Z]
802f(09     )      RSR              ; [Return from subroutine]
*
8030:ENDPT


 TITLE 'ETOA'
ETOA BEGIN 0
*
 EXT CODTBL
*
*
* Function ETOA
*
8000(5580   )ETOA  XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800c(5C     )      XAY              ; [Transfer A to Y]
800d(6561   )      LDX+  Y+         ; [Load X indexed, direct, post-incremented]
800f(3F     )D800F DCX              ; [Decrement X]
8010(1616   )      BM    D8028      ; =+22 [Branch on minus]
8012(90EEEE )      LDA=  CODTBL     ; [external symbol] [Load A with immediate]
8015(5E     )      XAZ              ; [Transfer A to Z]
8016(8B     )      LDAB+ Y          ; [Load AL from address in Y]
8017(D581   )D8017 LDB+  Z+         ; [Load B indexed, direct, post-incremented]
8019(1506   )      BNZ   D8021      ; =+6 [Branch if not zero]
801b(C0DF   )      LDBB= X'DF'      ; =223(-33) =DEL [Load BL with immediate]
801d(E561   )D801D STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
801f(73EE   )      JMP   D800F      ; =-18 [Jump relative]
8021(49     )D8021 SABB             ; [AL - BL -> BL]
8022(15F3   )      BNZ   D8017      ; =-13 [Branch if not zero]
8024(4523   )      XFRB  BU,BL      ; [Transfer BU to BL]
8026(73F5   )      JMP   D801D      ; =-11 [Jump relative]
8028(65A1   )D8028 LDX+  S+         ; [Load X indexed, direct, post-incremented]
802a(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802c(5C     )      XAY              ; [Transfer A to Y]
802d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802f(5E     )      XAZ              ; [Transfer A to Z]
8030(09     )      RSR              ; [Return from subroutine]
*
8031:ENDPT


 TITLE 'CODTBL'
CODTBL BEGIN 0
*
8000(8816   )CODTBL DW    X'8816'    ; =0x8816 =34838(-30698)
8002(8905   )      DW    X'8905'    ; =0x8905 =35077(-30459)
8004(8A25   )      DW    X'8A25'    ; =0x8a25 =35365(-30171)
8006(8D15   )      DW    X'8D15'    ; =0x8d15 =36117(-29419)
8008(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
8009(40     )      DB    X'40'      ; =0x40 =64
800a(A1     )      DC    '!'        ; hex:a1 dec:161(-95)
800b(26     )      DB    X'26'      ; =0x26 =38
800c(A2     )      DC    '"'        ; hex:a2 dec:162(-94)
800d(7F     )      DB    X'7F'      ; =0x7f =127
800e(A3     )      DC    '#'        ; hex:a3 dec:163(-93)
800f(7B     )      DB    X'7B'      ; =0x7b =123
8010(A4     )      DC    '$'        ; hex:a4 dec:164(-92)
8011(5B     )      DB    X'5B'      ; =0x5b =91
8012(A5     )      DC    '%'        ; hex:a5 dec:165(-91)
8013(6C     )      DB    X'6C'      ; =0x6c =108
8014(A6     )      DC    '&'        ; hex:a6 dec:166(-90)
8015(50A7   )      DW    X'50A7'    ; =0x50a7 =20647
8017(7D     )      DB    X'7D'      ; =0x7d =125
8018(A8     )      DC    '('        ; hex:a8 dec:168(-88)
8019(4D     )      DB    X'4D'      ; =0x4d =77
801a(A9     )      DC    ')'        ; hex:a9 dec:169(-87)
801b(5D     )      DB    X'5D'      ; =0x5d =93
801c(AA     )      DC    '*'        ; hex:aa dec:170(-86)
801d(5C     )      DB    X'5C'      ; =0x5c =92
801e(AB     )      DC    '+'        ; hex:ab dec:171(-85)
801f(4E     )      DB    X'4E'      ; =0x4e =78
8020(AC     )      DC    ','        ; hex:ac dec:172(-84)
8021(6B     )      DB    X'6B'      ; =0x6b =107
8022(AD     )      DC    '-'        ; hex:ad dec:173(-83)
8023(60     )      DB    X'60'      ; =0x60 =96
8024(AE     )      DC    '.'        ; hex:ae dec:174(-82)
8025(4B     )      DB    X'4B'      ; =0x4b =75
8026(AF     )      DC    '/'        ; hex:af dec:175(-81)
8027(61     )      DB    X'61'      ; =0x61 =97
8028(B0F0B1+)      DC    '0p1q2r3s4t5u6v7w8x9y:'
803d(7A     )      DB    X'7A'      ; =0x7a =122
803e(BB     )      DC    ';'        ; hex:bb dec:187(-69)
803f(5E     )      DB    X'5E'      ; =0x5e =94
8040(BC     )      DC    '<'        ; hex:bc dec:188(-68)
8041(66     )      DB    X'66'      ; =0x66 =102
8042(BD     )      DC    '='        ; hex:bd dec:189(-67)
8043(7E     )      DB    X'7E'      ; =0x7e =126
8044(BEFEBF )      DC    '>~?'      ; hex:befebf
8047(6F     )      DB    X'6F'      ; =0x6f =111
8048(C0     )      DC    '@'        ; hex:c0 dec:192(-64)
8049(7C     )      DB    X'7C'      ; =0x7c =124
804a(C1C1C2+)      DC    'AABBCCDDEEFFGGHHIIJQKRLSMTNUOVPWQXRYSbTcUdVeWfXgYhZi]a'
8080(DF6D   )      DW    X'DF6D'    ; =0xdf6d =57197(-8339)
8082(E1     )      DC    'a'        ; hex:e1 dec:225(-31)
8083(81     )      DB    X'81'      ; =0x81 =129(-127)
8084(E2     )      DC    'b'        ; hex:e2 dec:226(-30)
8085(82     )      DB    X'82'      ; =0x82 =130(-126)
8086(E3     )      DC    'c'        ; hex:e3 dec:227(-29)
8087(83     )      DB    X'83'      ; =0x83 =131(-125)
8088(E4     )      DC    'd'        ; hex:e4 dec:228(-28)
8089(84     )      DB    X'84'      ; =0x84 =132(-124) =EOT
808a(E5     )      DC    'e'        ; hex:e5 dec:229(-27)
808b(85     )      DB    X'85'      ; =0x85 =133(-123)
808c(E6     )      DC    'f'        ; hex:e6 dec:230(-26)
808d(86     )      DB    X'86'      ; =0x86 =134(-122)
808e(E7     )      DC    'g'        ; hex:e7 dec:231(-25)
808f(87     )      DB    X'87'      ; =0x87 =135(-121) =BEL
8090(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8091(88     )      DB    X'88'      ; =0x88 =136(-120)
8092(E9     )      DC    'i'        ; hex:e9 dec:233(-23)
8093(89     )      DB    X'89'      ; =0x89 =137(-119)
8094(EA     )      DC    'j'        ; hex:ea dec:234(-22)
8095(91     )      DB    X'91'      ; =0x91 =145(-111)
8096(EB     )      DC    'k'        ; hex:eb dec:235(-21)
8097(92     )      DB    X'92'      ; =0x92 =146(-110)
8098(EC     )      DC    'l'        ; hex:ec dec:236(-20)
8099(93     )      DB    X'93'      ; =0x93 =147(-109)
809a(ED     )      DC    'm'        ; hex:ed dec:237(-19)
809b(94     )      DB    X'94'      ; =0x94 =148(-108)
809c(EE     )      DC    'n'        ; hex:ee dec:238(-18)
809d(95     )      DB    X'95'      ; =0x95 =149(-107)
809e(EF     )      DC    'o'        ; hex:ef dec:239(-17)
809f(96     )      DB    X'96'      ; =0x96 =150(-106)
80a0(F0     )      DC    'p'        ; hex:f0 dec:240(-16)
80a1(97     )      DB    X'97'      ; =0x97 =151(-105)
80a2(F1     )      DC    'q'        ; hex:f1 dec:241(-15)
80a3(98     )      DB    X'98'      ; =0x98 =152(-104)
80a4(F2     )      DC    'r'        ; hex:f2 dec:242(-14)
80a5(99     )      DB    X'99'      ; =0x99 =153(-103)
80a6(F3A2F4+)      DC    's"t#u$v%w&x'
80b1(A7     )      DB    X'A7'      ; =0xa7 =167(-89) ='
80b2(F9A8FA+)      DC    'y(z)0@IP' ; hex:f9a8faa9b0c0c9d0
80ba(00     )      DB    X'00'      ; =0x00 =0 =NUL
80bb(00     )      DB    X'00'      ; =0x00 =0 =NUL
80bc:ENDPT


 TITLE 'SCOMP'
SCOMP BEGIN 0
*
 EXT COMP
*
*
* Function SCOMP
*
8000(D541   )SCOMP LDB+  X+         ; [Load B indexed, direct, post-incremented]
8002(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8004(F31E   )      STB   W8024      ; =+30 [Store B relative]
8006(4510   )      XFRB  AL,AU      ; [Transfer AL to AU]
8008(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800a(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
800c(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
800e(F316   )      STB   W8026      ; =+22 [Store B relative]
8010(5D     )      XAB              ; [Transfer A to B]
8011(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8013(4101   )      SUBB  AU,AL      ; [AU - AL -> AL]
8015(1602   )      BM    D8019      ; =+2 [Branch on minus]
8017(4530   )      XFRB  BL,AU      ; [Transfer BL to AU]
8019(4501   )D8019 XFRB  AU,AL      ; [Transfer AU to AL]
801b(2200   )      CLRB  AU         ; [Clear AU]
801d(B303   )      STA   W8022      ; =+3 [Store A relative]
801f(79EEEE )      JSR/  COMP       ; [external symbol] [Jump to subroutine direct]
8022(0000   )W8022 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8024(0000   )W8024 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8026(0000   )W8026 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8028(4533   )      XFRB  BL,BL      ; [Transfer BL to BL]
802a(1505   )      BNZ   D8031      ; =+5 [Branch if not zero]
802c(D5A1   )      LDB+  S+         ; [Load B indexed, direct, post-incremented]
802e(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
8030(09     )      RSR              ; [Return from subroutine]
*
8031(95A1   )D8031 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8033(4533   )      XFRB  BL,BL      ; [Transfer BL to BL]
8035(09     )      RSR              ; [Return from subroutine]
*
8036:ENDPT


 TITLE 'COMP'
COMP BEGIN 0
*
*
* Function COMP
*
8000(7E61   )COMP  STK   Y,2        ; [Push Y to the stack]
8002(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8004(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8006(5526   )      XFR   B,Y        ; [Transfer B to Y]
8008(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800a(39     )      DCA              ; [Decrement A]
800b(678A62 )      CPFR  -Y,-B      ; [Compare fixed-length (len-1 in AL), indexed, indexed]
800e(1407   )      BZ    D8017      ; =+7 [Branch if zero]
8010(170A   )      BP    D801C      ; =+10 [Branch on plus]
8012(7F61   )      POP   Y,2        ; [Pop Y from the stack]
8014(C001   )      LDBB= X'01'      ; =1 [Load BL with immediate]
8016(09     )      RSR              ; [Return from subroutine]
*
8017(7F61   )D8017 POP   Y,2        ; [Pop Y from the stack]
8019(2230   )      CLRB  BL         ; [Clear BL]
801b(09     )      RSR              ; [Return from subroutine]
*
801c(7F61   )D801C POP   Y,2        ; [Pop Y from the stack]
801e(C0FF   )      LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
8020(09     )      RSR              ; [Return from subroutine]
*
8021:ENDPT


 TITLE 'MOVE'
MOVE BEGIN 0
*
*
* Function MOVE
*
8000(7E61   )MOVE  STK   Y,2        ; [Push Y to the stack]
8002(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8004(39     )      DCA              ; [Decrement A]
8005(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8007(5526   )      XFR   B,Y        ; [Transfer B to Y]
8009(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800b(F7     )      MVL              ; [Move long (len-1 in A, src in B, dst in Y)]
800c(7F61   )      POP   Y,2        ; [Pop Y from the stack]
800e(09     )      RSR              ; [Return from subroutine]
*
800f:ENDPT


 TITLE 'MVUSS'
MVUSS BEGIN 0
*
*
* Function MVUSS
*
8000(7E61   )MVUSS STK   Y,2        ; [Push Y to the stack]
8002(555700+)      XFR-  X,0,Y      ; [Transfer indexed-displaced to Y]
8006(3041   )      INR   X,2        ; [Increment X by 2]
8008(39     )      DCA              ; [Decrement A]
8009(1704   )      BP    D800F      ; =+4 [Branch on plus]
800b(3041   )      INR   X,2        ; [Increment X by 2]
800d(7313   )      JMP   D8022      ; =+19 [Jump relative]
800f(679EA0+)D800F FILR  =' ',-Y    ; [Fill with byte (len-1 in AL), literal=0xa0(160,-96), indexed]
8013(38     )      INA              ; [Increment A]
8014(59     )      SAB              ; [A - B -> B]
8015(1903   )      BLE   D801A      ; =+3 [Branch if less than or equal to zero]
8017(59     )      SAB              ; [A - B -> B]
8018(5520   )      XFR   B,A        ; [Transfer B to A]
801a(D541   )D801A LDB+  X+         ; [Load B indexed, direct, post-incremented]
801c(39     )      DCA              ; [Decrement A]
801d(1603   )      BM    D8022      ; =+3 [Branch on minus]
801f(674A26 )      MVFR  -B,-Y      ; [Move fixed-length (len-1 in AL), indexed, indexed]
8022(7F61   )D8022 POP   Y,2        ; [Pop Y from the stack]
8024(09     )      RSR              ; [Return from subroutine]
*
8025:ENDPT


 TITLE 'MVSSF'
MVSSF BEGIN 0
*
*
* Function MVSSF
*
8000(7E61   )MVSSF STK   Y,2        ; [Push Y to the stack]
8002(39     )      DCA              ; [Decrement A]
8003(1610   )      BM    D8015      ; =+16 [Branch on minus]
8005(5C     )      XAY              ; [Transfer A to Y]
8006(2200   )      CLRB  AU         ; [Clear AU]
8008(679A42 )D8008 FILR  -X,-B      ; [Fill with byte (len-1 in AL), indexed, indexed]
800b(38     )      INA              ; [Increment A]
800c(58     )      AAB              ; [A + B -> B]
800d(9000FF )      LDA=  X'00FF'    ; =0x00ff =255 [Load A with immediate]
8010(2160   )      DCRB  YU         ; [Decrement YU by 1]
8012(17F4   )      BP    D8008      ; =-12 [Branch on plus]
8014(3E     )      INX              ; [Increment X]
8015(7F61   )D8015 POP   Y,2        ; [Pop Y from the stack]
8017(09     )      RSR              ; [Return from subroutine]
*
8018:ENDPT


 TITLE 'TRIM'
TRIM BEGIN 0
*
*
* Function TRIM
*
8000(9541   )TRIM  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8004(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8006(6501   )      LDX+  A+         ; [Load X indexed, direct, post-incremented]
8008(190E   )      BLE   D8018      ; =+14 [Branch if less than or equal to zero]
800a(5040   )      ADD   X,A        ; [X + A -> A]
800c(D0A0A0 )      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
800f(C502   )D800F LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
8011(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
8013(1503   )      BNZ   D8018      ; =+3 [Branch if not zero]
8015(3F     )      DCX              ; [Decrement X]
8016(18F7   )      BGZ   D800F      ; =-9 [Branch if greater than zero]
8018(95A1   )D8018 LDA+  S+         ; [Load A indexed, direct, post-incremented]
801a(6D00   )      STX+  A          ; [Store X indexed, direct]
801c(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
801e(09     )      RSR              ; [Return from subroutine]
*
801f:ENDPT


 TITLE 'CALLP'
CALLP BEGIN 0
*
*
* Function CALLP
*
8000(9541   )CALLP LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B30D   )      STA   W8011      ; =+13 [Store A relative]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B307   )      STA   W800F      ; =+7 [Store A relative]
8008(7A004A )      JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
800b(8016   )      DW    W8016      ; =0x8016 =32790(-32746)
800d(0501   )      DW    X'0501'    ; =0x0501 =1281
800f(0000   )W800F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8011(0000   )W8011 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8013(FF     )      DB    X'FF'      ; =0xff =255(-1)
8014(0000   )P8014 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8016(4D     )W8016 XABB             ; [Transfer AL to BL]
8017(1403   )      BZ    D801C      ; =+3 [Branch if zero]
8019(72002A )      JMP$  X'002A'    ; =0x002a =42 [Jump indirect]
801c(74F6   )D801C JMP*  P8014      ; =-10 [Jump relative]
801e:ENDPT


 TITLE 'LCSTR'
LCSTR BEGIN 0
*
*
* Function LCSTR
*
8000(9541   )LCSTR LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8004(5564   )      XFR   Y,X        ; [Transfer Y to X]
8006(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8008(6501   )      LDX+  A+         ; [Load X indexed, direct, post-incremented]
800a(5C     )      XAY              ; [Transfer A to Y]
800b(3F     )D800B DCX              ; [Decrement X]
800c(1613   )      BM    D8021      ; =+19 [Branch on minus]
800e(8B     )      LDAB+ Y          ; [Load AL from address in Y]
800f(C0C1   )      LDBB= X'C1'      ; =193(-63) ='A' [Load BL with immediate]
8011(49     )      SABB             ; [AL - BL -> BL]
8012(1609   )      BM    D801D      ; =+9 [Branch on minus]
8014(C0DA   )      LDBB= X'DA'      ; =218(-38) ='Z' [Load BL with immediate]
8016(49     )      SABB             ; [AL - BL -> BL]
8017(1804   )      BGZ   D801D      ; =+4 [Branch if greater than zero]
8019(C020   )      LDBB= X'20'      ; =32 [Load BL with immediate]
801b(4331   )      ORIB  BL,AL      ; [BL | AL -> AL]
801d(A561   )D801D STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
801f(73EA   )      JMP   D800B      ; =-22 [Jump relative]
8021(95A1   )D8021 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8023(5C     )      XAY              ; [Transfer A to Y]
8024(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8026(09     )      RSR              ; [Return from subroutine]
*
8027:ENDPT


 TITLE 'QUITD'
QUITD BEGIN 0
*
*
* Function QUITD
*
8000(7A004A )QUITD JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
8003(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8005(0600   )      DW    X'0600'    ; =0x0600 =1536
8007(00     )      DB    X'00'      ; =0x00 =0 =NUL
8008:ENDPT


 TITLE 'SYSREL'
SYSREL BEGIN 0
*
 EXT TST
*
*
* Function SYSREL
*
8000(7A004A )SYSREL JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
8003(800B   )      DW    W800B      ; =0x800b =32779(-32757)
8005(0701   )      DW    X'0701'    ; =0x0701 =1793
8007(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8009(0000   )W8009 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
800b(D3FC   )W800B LDB   W8009      ; =-4 [Load B relative]
800d(95281E )      LDA+  B,30       ; [Load A indexed, displaced, direct]
8010(B322   )      STA   W8034      ; =+34 [Store A relative]
8012(79EEEE )      JSR/  TST        ; [external symbol] [Jump to subroutine direct]
8015(8023   )      DW    W8023      ; =0x8023 =32803(-32733)
8017(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8019(B303   )      STA   W801E      ; =+3 [Store A relative]
801b(79EEEE )      JSR/  TST        ; [external symbol] [Jump to subroutine direct]
801e(0000   )W801E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8020(9312   )      LDA   W8034      ; =+18 [Load A relative]
8022(09     )      RSR              ; [Return from subroutine]
*
8023(0011   )W8023 DW    X'0011'    ; =0x0011 =17
8025(C4C9D3+)      DC    'DISKOS RELEASE '
8034(0000   )W8034 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8036:ENDPT


 TITLE 'LODREC'
LODREC BEGIN 0
*
ORIGIN EQU X'8067'
 ENT ORIGIN
*
8000(       )      DS    72         ; =0x0048 [Uninitialized memory]
*
* Function LODREC
*
8048(00     )LODREC HLT              ; [Halt]
8049(7400   )      JMP*  P804B      ; =+0 [Jump relative]
804b(4C     )P804B XAYB             ; [Transfer AL to YL]
804c(7B59   )D804C JSR   D80A7      ; =+89 [Jump to subroutine relative]
804e(A5C803 )      STAB+ C,3        ; [Store AL indexed, displaced, direct]
8051(3A     )D8051 CLA              ; [Clear A]
8052(A367   )      STAB  B80BA+1    ; =+103 [Store AL relative]
8054(7B58   )      JSR   D80AE      ; =+88 [Jump to subroutine relative]
8056(4D     )      XABB             ; [Transfer AL to BL]
8057(16F3   )      BM    D804C      ; =-13 [Branch on minus]
8059(142A   )      BZ    D8085      ; =+42 [Branch if zero]
805b(7B51   )      JSR   D80AE      ; =+81 [Jump to subroutine relative]
805d(3C     )      SRA              ; [Arithmetic right shift A]
805e(5B     )      XAX              ; [Transfer A to X]
805f(7B4D   )      JSR   D80AE      ; =+77 [Jump to subroutine relative]
8061(4516   )      XFRB  AL,YU      ; [Transfer AL to YU]
8063(7B49   )      JSR   D80AE      ; =+73 [Jump to subroutine relative]
8065(4C     )      XAYB             ; [Transfer AL to YL]
8066(900000 )W8066 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8069(5E     )      XAZ              ; [Transfer A to Z]
806a(5006   )      ADD   A,Y        ; [A + Y -> Y]
806c(7B40   )D806C JSR   D80AE      ; =+64 [Jump to subroutine relative]
806e(4512   )      XFRB  AL,BU      ; [Transfer AL to BU]
8070(7B3C   )      JSR   D80AE      ; =+60 [Jump to subroutine relative]
8072(4D     )      XABB             ; [Transfer AL to BL]
8073(5082   )      ADD   Z,B        ; [Z + B -> B]
8075(99     )      LDA+  B          ; [Load A from address in B]
8076(5060   )      ADD   Y,A        ; [Y + A -> A]
8078(B9     )      STA+  B          ; [Store A to address in B]
8079(3F     )      DCX              ; [Decrement X]
807a(15F0   )      BNZ   D806C      ; =-16 [Branch if not zero]
807c(7B30   )D807C JSR   D80AE      ; =+48 [Jump to subroutine relative]
807e(C33B   )      LDBB  B80BA+1    ; =+59 [Load BL relative]
8080(14CF   )      BZ    D8051      ; =-49 [Branch if zero]
8082(00     )D8082 HLT              ; [Halt]
8083(73C7   )      JMP   D804C      ; =-57 [Jump relative]
8085(7B27   )D8085 JSR   D80AE      ; =+39 [Jump to subroutine relative]
8087(5B     )      XAX              ; [Transfer A to X]
8088(7B24   )      JSR   D80AE      ; =+36 [Jump to subroutine relative]
808a(4510   )      XFRB  AL,AU      ; [Transfer AL to AU]
808c(7B20   )      JSR   D80AE      ; =+32 [Jump to subroutine relative]
808e(5C     )      XAY              ; [Transfer A to Y]
808f(93D6   )      LDA   W8066+1    ; =-42 [Load A relative]
8091(5006   )      ADD   A,Y        ; [A + Y -> Y]
8093(5544   )      XFR   X,X        ; [Transfer X to X]
8095(1409   )      BZ    D80A0      ; =+9 [Branch if zero]
8097(7B15   )D8097 JSR   D80AE      ; =+21 [Jump to subroutine relative]
8099(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
809b(3F     )      DCX              ; [Decrement X]
809c(15F9   )      BNZ   D8097      ; =-7 [Branch if not zero]
809e(73DC   )      JMP   D807C      ; =-36 [Jump relative]
80a0(7B05   )D80A0 JSR   D80A7      ; =+5 [Jump to subroutine relative]
80a2(A5C80A )      STAB+ C,10       ; [Store AL indexed, displaced, direct]
80a5(7560   )      JMP+  Y          ; [Jump indexed, direct]
80a7(85C801 )D80A7 LDAB+ C,1        ; [Load AL indexed, displaced, direct]
80aa(2C     )      SRAB             ; [Arithmetic right shift AL]
80ab(11FA   )      BNL   D80A7      ; =-6 [Branch on no link]
80ad(09     )      RSR              ; [Return from subroutine]
*
80ae(85C801 )D80AE LDAB+ C,1        ; [Load AL indexed, displaced, direct]
80b1(16CF   )      BM    D8082      ; =-49 [Branch on minus]
80b3(2C     )      SRAB             ; [Arithmetic right shift AL]
80b4(10CC   )      BL    D8082      ; =-52 [Branch on link]
80b6(2C     )      SRAB             ; [Arithmetic right shift AL]
80b7(11F5   )      BNL   D80AE      ; =-11 [Branch on no link]
80b9(8E     )      LDAB+ C          ; [Load AL from address in C]
80ba(C000   )B80BA LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
80bc(48     )      AABB             ; [AL + BL -> BL]
80bd(E3FC   )      STBB  B80BA+1    ; =-4 [Store BL relative]
80bf(09     )      RSR              ; [Return from subroutine]
*
80c0:ENDPT


 TITLE 'HILOAD'
HILOAD BEGIN 0
*
*
* Function HILOAD
*
8000(8541   )HILOAD LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8002(A30E   )      STAB  B8012      ; =+14 [Store AL relative]
8004(A33B   )      STAB  B8041      ; =+59 [Store AL relative]
8006(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8008(B309   )      STA   W8013      ; =+9 [Store A relative]
800a(B336   )      STA   W8042      ; =+54 [Store A relative]
800c(7A004A )      JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
800f(801A   )      DW    W801A      ; =0x801a =32794(-32742)
8011(05     )      DB    X'05'      ; =0x05 =5
8012(00     )B8012 DB    X'00'      ; =0x00 =0 =NUL
8013(0000   )W8013 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8015(804F   )      DW    ENDPT      ; =0x804f =32847(-32689)
8017(0100   )      DW    X'0100'    ; =0x0100 =256
8019(00     )      DB    X'00'      ; =0x00 =0 =NUL
801a(C006   )W801A LDBB= X'06'      ; =6 [Load BL with immediate]
801c(49     )      SABB             ; [AL - BL -> BL]
801d(1428   )      BZ    W8047      ; =+40 [Branch if zero]
801f(7A004A )      JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
8022(802A   )      DW    W802A      ; =0x802a =32810(-32726)
8024(0701   )      DW    X'0701'    ; =0x0701 =1793
8026(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8028(0000   )W8028 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
802a(D3FC   )W802A LDB   W8028      ; =-4 [Load B relative]
802c(95280D )      LDA+  B,13       ; [Load A indexed, displaced, direct]
802f(D0804F )      LDB=  ENDPT      ; =0x804f =32847(-32689) [Load B with immediate]
8032(59     )      SAB              ; [A - B -> B]
8033(93F3   )      LDA   W8028      ; =-13 [Load A relative]
8035(950805 )      LDA+  A,5        ; [Load A indexed, displaced, direct]
8038(59     )      SAB              ; [A - B -> B]
8039(F309   )      STB   S8044      ; =+9 [Store B relative]
803b(7A004A )      JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
803e(8047   )      DW    W8047      ; =0x8047 =32839(-32697)
8040(05     )      DB    X'05'      ; =0x05 =5
8041(00     )B8041 DB    X'00'      ; =0x00 =0 =NUL
8042(0000   )W8042 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8044(000000 )S8044 DB    0,3        ; =0x00,0x0003
*
8047(7A004A )W8047 JSR$  X'004A'    ; =0x004a =74 [Jump to subroutine indirect]
804a(804F   )      DW    ENDPT      ; =0x804f =32847(-32689)
804c(06     )      DB    X'06'      ; =0x06 =6
804d(804D   )W804D DW    W804D      ; =0x804d =32845(-32691)
804f:ENDPT


 TITLE 'TBLGET'
TBLGET BEGIN 0
*
 EXT @TBL
*
*
* Function TBLGET
*
8000(79EEEE )TBLGET JSR/  @TBL       ; [external symbol] [Jump to subroutine direct]
8003(674A62 )      MVFR  -Y,-B      ; [Move fixed-length (len-1 in AL), indexed, indexed]
8006(09     )      RSR              ; [Return from subroutine]
*
8007:ENDPT


 TITLE 'TBLPUT'
TBLPUT BEGIN 0
*
 EXT @TBL
*
*
* Function TBLPUT
*
8000(79EEEE )TBLPUT JSR/  @TBL       ; [external symbol] [Jump to subroutine direct]
8003(674A26 )      MVFR  -B,-Y      ; [Move fixed-length (len-1 in AL), indexed, indexed]
8006(09     )      RSR              ; [Return from subroutine]
*
8007:ENDPT


 TITLE '@TBL'
@TBL BEGIN 0
*
*
* Function @TBL
*
8000(6B3D   )@TBL  STX   W803E+1    ; =+61 [Store X relative]
8002(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(5C     )      XAY              ; [Transfer A to Y]
8007(3A     )      CLA              ; [Clear A]
8008(8568FF )      LDAB+ Y,-1       ; [Load AL indexed, displaced, direct]
800b(B313   )      STA   W801F+1    ; =+19 [Store A relative]
800d(B332   )      STA   W8041      ; =+50 [Store A relative]
800f(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8011(1506   )      BNZ   D8019      ; =+6 [Branch if not zero]
8013(5540   )      XFR   X,A        ; [Transfer X to A]
8015(3101   )      DCR   A,2        ; [Decrement A by 2]
8017(3041   )      INR   X,2        ; [Increment X by 2]
8019(463158+)D8019 M     -A(4),/W801F+1(2) ; =0x8020 =32800(-32736) [Multiply bignums, indexed, direct]
801f(900000 )W801F LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8022(38     )      INA              ; [Increment A]
8023(5006   )      ADD   A,Y        ; [A + Y -> Y]
8025(5160   )      SUB   Y,A        ; [Y - A -> A]
8027(C541   )      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8029(140F   )      BZ    D803A      ; =+15 [Branch if zero]
802b(5540   )      XFR   X,A        ; [Transfer X to A]
802d(2130   )      DCRB  BL         ; [Decrement BL by 1]
802f(1504   )      BNZ   D8035      ; =+4 [Branch if not zero]
8031(3043   )      INR   X,4        ; [Increment X by 4]
8033(7305   )      JMP   D803A      ; =+5 [Jump relative]
8035(39     )D8035 DCA              ; [Decrement A]
8036(C541   )D8036 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8038(15FC   )      BNZ   D8036      ; =-4 [Branch if not zero]
803a(5D     )D803A XAB              ; [Transfer A to B]
803b(9304   )      LDA   W8041      ; =+4 [Load A relative]
803d(39     )      DCA              ; [Decrement A]
803e(710000 )W803E JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
*
8041(0000   )W8041 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8043:ENDPT


 TITLE '@FRM'
@FRM BEGIN 0
*
 EXT STATUS
*
*
* Function @FRM
*
8000(3A     )@FRM  CLA              ; [Clear A]
8001(B1EEEE )      STA/  STATUS     ; [external symbol] [Store A direct]
8004(DA     )      LDB+  X          ; [Load B from address in X]
8005(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
8007(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg1]
8008(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg2]
8009(01     )      DB    X'01'      ; =0x01 =1 [TODO: arg3]
800a(800D   )      DW    W800C+1    ; =0x800d =32781(-32755) [address to store block value]
800c(8000   )W800C LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
800e(C009   )      LDBB= X'09'      ; =9 [Load BL with immediate]
8010(49     )      SABB             ; [AL - BL -> BL]
8011(1407   )      BZ    D801A      ; =+7 [Branch if zero]
8013(3044   )      INR   X,5        ; [Increment X by 5]
8015(3212EE+)      CAD/  STATUS,2   ; [Set word at address to 2]
8019(09     )      RSR              ; [Return from subroutine]
*
801a(D541   )D801A LDB+  X+         ; [Load B indexed, direct, post-incremented]
801c(7E21   )      STK   B,2        ; [Push B to the stack]
801e(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8020(3D     )      SLA              ; [Left shift A]
8021(1106   )      BNL   D8029      ; =+6 [Branch on no link]
8023(3600   )      RRR   A          ; [Right rotate A by 1]
8025(950802 )      LDA+  A,2        ; [Load A indexed, displaced, direct]
8028(3D     )      SLA              ; [Left shift A]
8029(CA     )D8029 LDBB+ X          ; [Load BL from address in X]
802a(2430   )      SRRB  BL         ; [Arithmetic right shift BL by 1]
802c(3600   )      RRR   A          ; [Right rotate A by 1]
802e(7F21   )      POP   B,2        ; [Pop B from the stack]
8030(B52808 )      STA+  B,8        ; [Store A indexed, displaced, direct]
8033(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8035(2C     )      SRAB             ; [Arithmetic right shift AL]
8036(2D     )      SLAB             ; [Left shift AL]
8037(533100+)      ORI-  B,1,A      ; [*(B+1) | A -> A]
803b(A52802 )      STAB+ B,2        ; [Store AL indexed, displaced, direct]
803e(908001 )      LDA=  X'8001'    ; =0x8001 =32769(-32767) [Load A with immediate]
8041(A52803 )      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8044(B52806 )      STA+  B,6        ; [Store A indexed, displaced, direct]
8047(6600   )      SVC   0          ; =0x00 [Service call PIOC - physical i/o control]
8049(09     )      RSR              ; [Return from subroutine]
*
804a(3E     )      DB    X'3E'      ; =0x3e =62
804b:ENDPT


 TITLE 'ALDATE'
ALDATE BEGIN 0
*
 EXT STATUS
 EXT ZERO
*
*
* Function ALDATE
*
8000(9541   )ALDATE LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8004(1403   )      BZ    D8009      ; =+3 [Branch if zero]
8006(950802 )      LDA+  A,2        ; [Load A indexed, displaced, direct]
8009(B18110 )D8009 STA/  S8110      ; =0x8110 =33040(-32496) [Store A direct]
800c(D00004 )      LDB=  X'0004'    ; =0x0004 =4 [Load B with immediate]
800f(59     )      SAB              ; [A - B -> B]
8010(140C   )      BZ    D801E      ; =+12 [Branch if zero]
8012(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8014(D8     )      LDB+  A          ; [Load B from address in A]
8015(F180F1 )      STB/  I80F1      ; =0x80f1 =33009(-32527) [Store B direct]
8018(D50802 )      LDB+  A,2        ; [Load B indexed, displaced, direct]
801b(F180F3 )      STB/  W80F3      ; =0x80f3 =33011(-32525) [Store B direct]
801e(9541   )D801E LDA+  X+         ; [Load A indexed, direct, post-incremented]
8020(B180B4 )      STA/  W80B4      ; =0x80b4 =32948(-32588) [Store A direct]
8023(01     )      NOP              ; [No operation]
8024(6628   )      SVC   40         ; =0x28 [Service call CG - CPL 32-bit computed goto]
8026(0004   )      DW    X'0004'    ; =0x0004 =4 [goto count]
8028(803D   )      DW    G803D      ; =0x803d =32829(-32707) [address of goto]
802a(8046   )      DW    G8046      ; =0x8046 =32838(-32698) [address of goto]
802c(804C   )      DW    G804C      ; =0x804c =32844(-32692) [address of goto]
802e(8052   )      DW    G8052      ; =0x8052 =32850(-32686) [address of goto]
8030(810E   )      DW    W810E      ; =0x810e =33038(-32498)
*
8032(01     )W8032 NOP              ; [No operation]
8033(661E   )      SVC   30         ; =0x1E [Service call LD - CPL 32-bit load]
8035(0001   )      DW    X'0001'    ; =0x0001 =1 [address of integer]
8037(01     )      NOP              ; [No operation]
8038(661F   )      SVC   31         ; =0x1F [Service call ST - CPL 32-bit store]
803a(EEEE   )      DW    STATUS     ; [external symbol] [address of integer]
803c(09     )      RSR              ; [Return from subroutine]
*
803d(01     )G803D NOP              ; [No operation]
803e(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
8040(0B     )      DB    X'0B'      ; =0x0b =11 [Selector: integer date from GRIN date]
8041(80F1   )      DW    I80F1      ; =0x80f1 =33009(-32527) [address of date]
8043(718055 )      JMP/  J8055      ; =0x8055 =32853(-32683) [Jump direct]
8046(9180F3 )G8046 LDA/  W80F3      ; =0x80f3 =33011(-32525) [Load A direct]
8049(718055 )      JMP/  J8055      ; =0x8055 =32853(-32683) [Jump direct]
804c(9180F1 )G804C LDA/  I80F1      ; =0x80f1 =33009(-32527) [Load A direct]
804f(718055 )      JMP/  J8055      ; =0x8055 =32853(-32683) [Jump direct]
8052(01     )G8052 NOP              ; [No operation]
8053(660B   )      SVC   11         ; =0x0B [Service call DT - get binary date]
8055(B5A2   )J8055 STA-  S-         ; [Store A indexed, pre-decremented, direct]
8057(01     )      NOP              ; [No operation]
8058(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
805a(0A     )      DB    X'0A'      ; =0x0a =10 [Selector: integer date]
805b(80F1   )      DW    I80F1      ; =0x80f1 =33009(-32527) [address of integer date]
805d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
805f(01     )      NOP              ; [No operation]
8060(6626   )      SVC   38         ; =0x26 [Service call CN - CPL 32-bit numeric compare]
8062(EEEE   )      DW    STATUS     ; [external symbol] [address of integer]
8064(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8066(8032   )      DW    W8032      ; =0x8032 =32818(-32718) [TODO: arg3]
8068(06     )      SL               ; [Set link]
8069(01     )      NOP              ; [No operation]
806a(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
806c(8153   )      DW    S8153      ; =0x8153 =33107(-32429) [address of string]
806e(811A   )      DW    S811A      ; =0x811a =33050(-32486) [address of string]
8070(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8072(01     )      NOP              ; [No operation]
8073(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
8075(8153   )      DW    S8153      ; =0x8153 =33107(-32429) [address of string]
8077(8145   )      DW    L8145      ; =0x8145 =33093(-32443) [address of format]
8079(80F1   )      DW    I80F1      ; =0x80f1 =33009(-32527) [address of argument]
807b(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
807d(01     )      NOP              ; [No operation]
807e(6632   )      SVC   50         ; =0x32 [Service call DC - CPL decode]
8080(8153   )      DW    S8153      ; =0x8153 =33107(-32429) [address of string]
8082(8149   )      DW    L8149      ; =0x8149 =33097(-32439) [address of format]
8084(80E7   )      DW    L80E7      ; =0x80e7 =32999(-32537) [address of argument]
8086(80F9   )      DW    S80F9      ; =0x80f9 =33017(-32519) [address of argument]
8088(80FC   )      DW    S80FC      ; =0x80fc =33020(-32516) [address of argument]
808a(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
808c(01     )      NOP              ; [No operation]
808d(661E   )      SVC   30         ; =0x1E [Service call LD - CPL 32-bit load]
808f(80E7   )      DW    L80E7      ; =0x80e7 =32999(-32537) [address of integer]
8091(01     )      NOP              ; [No operation]
8092(6624   )      SVC   36         ; =0x24 [Service call MU - CPL 32-bit multiply]
8094(000A   )      DW    X'000A'    ; =0x000a =10 [address of integer]
8096(01     )      NOP              ; [No operation]
8097(661F   )      SVC   31         ; =0x1F [Service call ST - CPL 32-bit store]
8099(80E7   )      DW    L80E7      ; =0x80e7 =32999(-32537) [address of integer]
809b(D080C3 )      LDB=  W80C3      ; =0x80c3 =32963(-32573) [Load B with immediate]
809e(9349   )      LDA   W80E9      ; =+73 [Load A relative]
80a0(58     )      AAB              ; [A + B -> B]
80a1(F313   )      STB   W80B6      ; =+19 [Store B relative]
80a3(8354   )      LDAB  S80F9      ; =+84 [Load AL relative]
80a5(C0B0   )      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
80a7(49     )      SABB             ; [AL - BL -> BL]
80a8(1507   )      BNZ   D80B1      ; =+7 [Branch if not zero]
80aa(834E   )      LDAB  S80FA      ; =+78 [Load AL relative]
80ac(A34B   )      STAB  S80F9      ; =+75 [Store AL relative]
80ae(2A     )      CLAB             ; [Clear AL]
80af(A349   )      STAB  S80FA      ; =+73 [Store AL relative]
80b1(01     )D80B1 NOP              ; [No operation]
80b2(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
80b4(EEEE   )W80B4 DW    ZERO       ; [external symbol]
80b6(EEEE   )W80B6 DW    ZERO       ; [external symbol]
80b8(80D5   )      DW    S80D5      ; =0x80d5 =32981(-32555)
80ba(80F9   )      DW    S80F9      ; =0x80f9 =33017(-32519)
80bc(8104   )      DW    S8104      ; =0x8104 =33028(-32508)
80be(80FC   )      DW    S80FC      ; =0x80fc =33020(-32516)
80c0(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80c2(01     )      NOP              ; [No operation]
80c3(661E   )W80C3 SVC   30         ; =0x1E [Service call LD - CPL 32-bit load]
80c5(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
80c7(01     )      NOP              ; [No operation]
80c8(661F   )      SVC   31         ; =0x1F [Service call ST - CPL 32-bit store]
80ca(EEEE   )      DW    STATUS     ; [external symbol] [address of integer]
80cc(09     )      RSR              ; [Return from subroutine]
*
80cd(CAC1CE+)      DC    'JANUARY'  ; hex:cac1ced5c1d2d9
80d4(00     )      DB    X'00'      ; =0x00 =0 =NUL
80d5(A0     )S80D5 DC    ' '        ; hex:a0 dec:160(-96)
80d6(00     )      DB    X'00'      ; =0x00 =0 =NUL
80d7(C6C5C2+)      DC    'FEBRUARY' ; hex:c6c5c2d2d5c1d2d9
80df(00     )      DB    X'00'      ; =0x00 =0 =NUL
80e0(00     )      DB    X'00'      ; =0x00 =0 =NUL
80e1(CDC1D2+)      DC    'MARCH'    ; hex:cdc1d2c3c8
80e6(00     )      DB    X'00'      ; =0x00 =0 =NUL
80e7(0000   )L80E7 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80e9(0000   )W80E9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80eb(C1D0D2+)      DC    'APRIL'    ; hex:c1d0d2c9cc
80f0(00     )      DB    X'00'      ; =0x00 =0 =NUL
80f1(0000   )I80F1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80f3(0000   )W80F3 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80f5(CDC1D9 )      DC    'MAY'      ; hex:cdc1d9
80f8(00     )      DB    X'00'      ; =0x00 =0 =NUL
80f9(A0     )S80F9 DC    ' '        ; hex:a0 dec:160(-96)
80fa(A0     )S80FA DC    ' '        ; hex:a0 dec:160(-96)
80fb(00     )      DB    X'00'      ; =0x00 =0 =NUL
80fc(A0A0   )S80FC DC    '  '       ; hex:a0a0 dec:41120(-96)
80fe(00     )      DB    X'00'      ; =0x00 =0 =NUL
80ff(CAD5CE+)      DC    'JUNE'     ; hex:cad5cec5
8103(00     )      DB    X'00'      ; =0x00 =0 =NUL
8104(ACA0B1+)S8104 DC    ', 19'     ; hex:aca0b1b9
8108(00     )      DB    X'00'      ; =0x00 =0 =NUL
8109(CAD5CC+)      DC    'JULY'     ; hex:cad5ccd9
810d(00     )      DB    X'00'      ; =0x00 =0 =NUL
810e(0000   )W810E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8110(000000 )S8110 DB    0,3        ; =0x00,0x0003
8113(C1D5C7+)      DC    'AUGUST'   ; hex:c1d5c7d5d3d4
8119(00     )      DB    X'00'      ; =0x00 =0 =NUL
811a(B0     )S811A DC    '0'        ; hex:b0 dec:176(-80)
811b(00     )      DB    X'00'      ; =0x00 =0 =NUL
811c(00     )      DB    X'00'      ; =0x00 =0 =NUL
811d(D3C5D0+)      DC    'SEPTEMBER' ; hex:d3c5d0d4c5cdc2c5d2
8126(00     )      DB    X'00'      ; =0x00 =0 =NUL
8127(CFC3D4+)      DC    'OCTOBER'  ; hex:cfc3d4cfc2c5d2
812e(00     )      DB    X'00'      ; =0x00 =0 =NUL
812f(       )      DS    1          ; =0x0001 [Uninitialized memory]
8130(00     )      DB    X'00'      ; =0x00 =0 =NUL
8131(CECFD6+)      DC    'NOVEMBER' ; hex:cecfd6c5cdc2c5d2
8139(00     )      DB    X'00'      ; =0x00 =0 =NUL
813a(00     )      DB    X'00'      ; =0x00 =0 =NUL
813b(C4C5C3+)      DC    'DECEMBER' ; hex:c4c5c3c5cdc2c5d2
8143(00     )      DB    X'00'      ; =0x00 =0 =NUL
8144(00     )      DB    X'00'      ; =0x00 =0 =NUL
8145(0300   )L8145 DW    X'0300'    ; =0x0300 =768
8147(0600   )      DW    X'0600'    ; =0x0600 =1536
8149(0300   )L8149 DW    X'0300'    ; =0x0300 =768
814b(0202   )      DW    X'0202'    ; =0x0202 =514
814d(00     )      DB    X'00'      ; =0x00 =0 =NUL
814e(0202   )      DW    X'0202'    ; =0x0202 =514
8150(00     )      DB    X'00'      ; =0x00 =0 =NUL
8151(0200   )      DW    X'0200'    ; =0x0200 =512
8153(A0A0A0+)S8153 DC    ' ',6     
8159(00     )      DB    X'00'      ; =0x00 =0 =NUL
815a(6656   )      DW    X'6656'    ; =0x6656 =26198
815c(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
815e(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8160:ENDPT


 TITLE 'INTRC'
INTRC BEGIN 0
*
 EXT EXP40
 EXT INTRS
*
*
* Function INTRC
*
8000(9541   )INTRC LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B303   )      STA   W8007      ; =+3 [Store A relative]
8004(79EEEE )      JSR/  EXP40      ; [external symbol] [Jump to subroutine direct]
8007(0000   )W8007 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8009(8022   )      DW    S8022      ; =0x8022 =32802(-32734)
800b(8315   )      LDAB  S8022      ; =+21 [Load AL relative]
800d(29     )      DCAB             ; [Decrement AL]
800e(A312   )      STAB  S8022      ; =+18 [Store AL relative]
8010(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8012(B309   )      STA   W801D      ; =+9 [Store A relative]
8014(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8016(B307   )      STA   W801F      ; =+7 [Store A relative]
8018(79EEEE )      JSR/  INTRS      ; [external symbol] [Jump to subroutine direct]
801b(8022   )      DW    S8022      ; =0x8022 =32802(-32734)
801d(0000   )W801D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
801f(0000   )W801F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8021(09     )      RSR              ; [Return from subroutine]
*
8022(000000+)S8022 DB    0,6        ; =0x00,0x0006
8028:ENDPT


 TITLE 'INTRS'
INTRS BEGIN 0
*
 EXT MUL48
*
*
* Function INTRS
*
8000(9541   )INTRS LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B307   )      STA   W800B      ; =+7 [Store A relative]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B305   )      STA   W800D      ; =+5 [Store A relative]
8008(79EEEE )      JSR/  MUL48      ; [external symbol] [Jump to subroutine direct]
800b(0000   )W800B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
800d(0000   )W800D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
800f(8038   )      DW    ENDPT      ; =0x8038 =32824(-32712)
8011(832C   )      LDAB  B803F      ; =+44 [Load AL relative]
8013(2D     )      SLAB             ; [Left shift AL]
8014(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8016(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8018(6323   )      LDX   W803D      ; =+35 [Load X relative]
801a(1104   )      BNL   D8020      ; =+4 [Branch on no link]
801c(3E     )      INX              ; [Increment X]
801d(1401   )      BZ    D8020      ; =+1 [Branch if zero]
801f(07     )      RL               ; [Reset link]
8020(6D0804 )D8020 STX+  A,4        ; [Store X indexed, displaced, direct]
8023(6316   )      LDX   W803B      ; =+22 [Load X relative]
8025(1104   )      BNL   D802B      ; =+4 [Branch on no link]
8027(3E     )      INX              ; [Increment X]
8028(1401   )      BZ    D802B      ; =+1 [Branch if zero]
802a(07     )      RL               ; [Reset link]
802b(6D0802 )D802B STX+  A,2        ; [Store X indexed, displaced, direct]
802e(6309   )      LDX   W8039      ; =+9 [Load X relative]
8030(1101   )      BNL   D8033      ; =+1 [Branch on no link]
8032(3E     )      INX              ; [Increment X]
8033(6D00   )D8033 STX+  A          ; [Store X indexed, direct]
8035(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8037(09     )      RSR              ; [Return from subroutine]
*
8038:ENDPT


 TITLE 'LOGIN'
LOGIN BEGIN 0
*
 EXT LOG40
*
*
* Function LOGIN
*
8000(9541   )LOGIN LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8004(2020   )      INRB  BU         ; [Increment BU by 1]
8006(F313   )      STB   W801B      ; =+19 [Store B relative]
8008(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
800a(F311   )      STB   W801D      ; =+17 [Store B relative]
800c(D8     )      LDB+  A          ; [Load B from address in A]
800d(F310   )      STB   W801F      ; =+16 [Store B relative]
800f(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8011(B305   )      STA   W8018      ; =+5 [Store A relative]
8013(79EEEE )      JSR/  LOG40      ; [external symbol] [Jump to subroutine direct]
8016(801B   )      DW    W801B      ; =0x801b =32795(-32741)
8018(0000   )W8018 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
801a(09     )      RSR              ; [Return from subroutine]
*
801b(0000   )W801B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
801d(0000   )W801D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
801f(0000   )W801F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8021:ENDPT


 TITLE 'EXP40'
EXP40 BEGIN 0
*
 EXT MUL48
*
*
* Function EXP40
*
8000(5580   )EXP40 XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(B316   )      STA   W8022      ; =+22 [Store A relative]
800c(98     )      LDA+  A          ; [Load A from address in A]
800d(D004C0 )      LDB=  X'04C0'    ; =0x04c0 =1216 [Load B with immediate]
8010(59     )      SAB              ; [A - B -> B]
8011(125D   )      BF    D8070      ; =+93 [Branch on fault]
8013(1758   )      BP    D806D      ; =+88 [Branch on plus]
8015(D01C00 )      LDB=  X'1C00'    ; =0x1c00 =7168 [Load B with immediate]
8018(58     )      AAB              ; [A + B -> B]
8019(1252   )      BF    D806D      ; =+82 [Branch on fault]
801b(1653   )      BM    D8070      ; =+83 [Branch on minus]
801d(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
801f(79EEEE )      JSR/  MUL48      ; [external symbol] [Jump to subroutine direct]
8022(0000   )W8022 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8024(8128   )      DW    W8128      ; =0x8128 =33064(-32472)
8026(8082   )      DW    W8082      ; =0x8082 =32898(-32638)
8028(93F8   )      LDA   W8022      ; =-8 [Load A relative]
802a(D00006 )      LDB=  X'0006'    ; =0x0006 =6 [Load B with immediate]
802d(58     )      AAB              ; [A + B -> B]
802e(5526   )      XFR   B,Y        ; [Transfer B to Y]
8030(8356   )      LDAB  W8088      ; =+86 [Load AL relative]
8032(A34D   )      STAB  B8081      ; =+77 [Store AL relative]
8034(9350   )      LDA   W8086      ; =+80 [Load A relative]
8036(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
8038(58     )      AAB              ; [A + B -> B]
8039(F344   )      STB   W807F      ; =+68 [Store B relative]
803b(9347   )      LDA   W8084      ; =+71 [Load A relative]
803d(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
803f(1103   )      BNL   D8044      ; =+3 [Branch on no link]
8041(38     )      INA              ; [Increment A]
8042(1401   )      BZ    D8045      ; =+1 [Branch if zero]
8044(58     )D8044 AAB              ; [A + B -> B]
8045(F336   )D8045 STB   W807D      ; =+54 [Store B relative]
8047(9339   )      LDA   W8082      ; =+57 [Load A relative]
8049(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
804b(1101   )      BNL   D804E      ; =+1 [Branch on no link]
804d(38     )      INA              ; [Increment A]
804e(58     )D804E AAB              ; [A + B -> B]
804f(E32B   )      STBB  W807C      ; =+43 [Store BL relative]
8051(F00000 )B8051 STB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store B immediate]
8054(3A     )      CLA              ; [Clear A]
8055(8325   )      LDAB  W807C      ; =+37 [Load AL relative]
8057(C00F   )      LDBB= X'0F'      ; =15 [Load BL with immediate]
8059(4A     )      NABB             ; [AL & BL -> BL]
805a(E320   )      STBB  W807C      ; =+32 [Store BL relative]
805c(C0F0   )      LDBB= X'F0'      ; =240(-16) ='p' [Load BL with immediate]
805e(4231   )      ANDB  BL,AL      ; [BL & AL -> AL]
8060(3C     )      SRA              ; [Arithmetic right shift A]
8061(2C     )      SRAB             ; [Arithmetic right shift AL]
8062(5D     )      XAB              ; [Transfer A to B]
8063(2C     )      SRAB             ; [Arithmetic right shift AL]
8064(48     )      AABB             ; [AL + BL -> BL]
8065(908158 )      LDA=  W8158      ; =0x8158 =33112(-32424) [Load A with immediate]
8068(58     )      AAB              ; [A + B -> B]
8069(F36A   )      STB   W80D5      ; =+106 [Store B relative]
806b(7321   )      JMP   D808E      ; =+33 [Jump relative]
806d(02     )D806D SF               ; [Set fault]
806e(7301   )      JMP   D8071      ; =+1 [Jump relative]
8070(03     )D8070 RF               ; [Reset fault]
8071(3A     )D8071 CLA              ; [Clear A]
8072(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8074(B521   )      STA+  B+         ; [Store A indexed, direct, post-incremented]
8076(B521   )      STA+  B+         ; [Store A indexed, direct, post-incremented]
8078(B9     )      STA+  B          ; [Store A to address in B]
8079(718121 )      JMP/  J8121      ; =0x8121 =33057(-32479) [Jump direct]
*
807c(00     )W807C DB    X'00'      ; =0x00 =0 =NUL
807d(0000   )W807D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
807f(0000   )W807F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8081(00     )B8081 DB    X'00'      ; =0x00 =0 =NUL
8082(0000   )W8082 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8084(0000   )W8084 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8086(0000   )W8086 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8088(0000   )W8088 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
808a(0000   )W808A DW    X'0000'    ; =0x0000 =0 =NUL,NUL
808c(0000   )W808C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
808e(908158 )D808E LDA=  W8158      ; =0x8158 =33112(-32424) [Load A with immediate]
8091(5C     )      XAY              ; [Transfer A to Y]
8092(600006 )      LDX=  X'0006'    ; =0x0006 =6 [Load X with immediate]
8095(9562   )      LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
8097(B3F3   )      STA   W808C      ; =-13 [Store A relative]
8099(9562   )      LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
809b(B3ED   )      STA   W808A      ; =-19 [Store A relative]
809d(9562   )      LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
809f(B3E7   )      STA   W8088      ; =-25 [Store A relative]
80a1(79EEEE )D80A1 JSR/  MUL48      ; [external symbol] [Jump to subroutine direct]
80a4(807C   )      DW    W807C      ; =0x807c =32892(-32644)
80a6(8088   )      DW    W8088      ; =0x8088 =32904(-32632)
80a8(8082   )      DW    W8082      ; =0x8082 =32898(-32638)
80aa(83DC   )      LDAB  W8088      ; =-36 [Load AL relative]
80ac(2D     )      SLAB             ; [Left shift AL]
80ad(93D7   )      LDA   W8086      ; =-41 [Load A relative]
80af(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
80b1(1103   )      BNL   D80B6      ; =+3 [Branch on no link]
80b3(38     )      INA              ; [Increment A]
80b4(1401   )      BZ    D80B7      ; =+1 [Branch if zero]
80b6(58     )D80B6 AAB              ; [A + B -> B]
80b7(F3D3   )D80B7 STB   W808C      ; =-45 [Store B relative]
80b9(93C9   )      LDA   W8084      ; =-55 [Load A relative]
80bb(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
80bd(1103   )      BNL   D80C2      ; =+3 [Branch on no link]
80bf(38     )      INA              ; [Increment A]
80c0(1401   )      BZ    D80C3      ; =+1 [Branch if zero]
80c2(58     )D80C2 AAB              ; [A + B -> B]
80c3(F3C5   )D80C3 STB   W808A      ; =-59 [Store B relative]
80c5(93BB   )      LDA   W8082      ; =-69 [Load A relative]
80c7(D562   )      LDB-  Y-         ; [Load B indexed, pre-decremented, direct]
80c9(1101   )      BNL   D80CC      ; =+1 [Branch on no link]
80cb(38     )      INA              ; [Increment A]
80cc(58     )D80CC AAB              ; [A + B -> B]
80cd(F3B9   )      STB   W8088      ; =-71 [Store B relative]
80cf(3F     )      DCX              ; [Decrement X]
80d0(18CF   )      BGZ   D80A1      ; =-49 [Branch if greater than zero]
80d2(79EEEE )      JSR/  MUL48      ; [external symbol] [Jump to subroutine direct]
80d5(0000   )W80D5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80d7(8088   )      DW    W8088      ; =0x8088 =32904(-32632)
80d9(8082   )      DW    W8082      ; =0x8082 =32898(-32638)
80db(D3A5   )      LDB   W8082      ; =-91 [Load B relative]
80dd(63A5   )      LDX   W8084      ; =-91 [Load X relative]
80df(93A5   )      LDA   W8086      ; =-91 [Load A relative]
80e1(5C     )      XAY              ; [Transfer A to Y]
80e2(93A4   )      LDA   W8088      ; =-92 [Load A relative]
80e4(5E     )      XAZ              ; [Transfer A to Z]
80e5(818052 )      LDAB/ B8051+1    ; =0x8052 =32850(-32686) [Load AL direct]
80e8(141C   )      BZ    D8106      ; =+28 [Branch if zero]
80ea(160E   )      BM    D80FA      ; =+14 [Branch on minus]
80ec(07     )D80EC RL               ; [Reset link]
80ed(3780   )      RLR   Z          ; [Left rotate Z by 1]
80ef(3760   )      RLR   Y          ; [Left rotate Y by 1]
80f1(3740   )      RLR   X          ; [Left rotate X by 1]
80f3(3720   )      RLR   B          ; [Left rotate B by 1]
80f5(29     )      DCAB             ; [Decrement AL]
80f6(18F4   )      BGZ   D80EC      ; =-12 [Branch if greater than zero]
80f8(730C   )      JMP   D8106      ; =+12 [Jump relative]
80fa(07     )D80FA RL               ; [Reset link]
80fb(3620   )      RRR   B          ; [Right rotate B by 1]
80fd(3640   )      RRR   X          ; [Right rotate X by 1]
80ff(3660   )      RRR   Y          ; [Right rotate Y by 1]
8101(2690   )      RRRB  ZL         ; [Right rotate ZL by 1]
8103(28     )      INAB             ; [Increment AL]
8104(16F4   )      BM    D80FA      ; =-12 [Branch on minus]
8106(4588   )D8106 XFRB  ZU,ZU      ; [Transfer ZU to ZU]
8108(1709   )      BP    D8113      ; =+9 [Branch on plus]
810a(3060   )      INR   Y          ; [Increment Y by 1]
810c(1505   )      BNZ   D8113      ; =+5 [Branch if not zero]
810e(3E     )      INX              ; [Increment X]
810f(1502   )      BNZ   D8113      ; =+2 [Branch if not zero]
8111(3020   )      INR   B          ; [Increment B by 1]
8113(95A4   )D8113 LDA+  *S         ; [Load A indexed, indirect]
8115(F501   )      STB+  A+         ; [Store B indexed, direct, post-incremented]
8117(6D01   )      STX+  A+         ; [Store X indexed, direct, post-incremented]
8119(5562   )      XFR   Y,B        ; [Transfer Y to B]
811b(F8     )      STB+  A          ; [Store B to address in A]
811c(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
811e(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8120(03     )      RF               ; [Reset fault]
8121(95A1   )J8121 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8123(5C     )      XAY              ; [Transfer A to Y]
8124(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8126(5E     )      XAZ              ; [Transfer A to Z]
8127(09     )      RSR              ; [Return from subroutine]
*
8128(7154   )W8128 DW    X'7154'    ; =0x7154 =29012
812a(7652   )      DW    X'7652'    ; =0x7652 =30290
812c(B8     )      DC    '8'        ; hex:b8 dec:184(-72)
812d(2F10   )      DW    X'2F10'    ; =0x2f10 =12048
812f(000000+)      DB    0,5        ; =0x00,0x0005
8134(0B17   )      DW    X'0B17'    ; =0x0b17 =2839
8136(217F   )      DW    X'217F'    ; =0x217f =8575
8138(7D1D   )      DW    X'7D1D'    ; =0x7d1d =32029
813a(03     )      DB    X'03'      ; =0x03 =3
813b(D7F7BF+)      DC    'Ww?p'     ; hex:d7f7bff0
813f(5900   )      DW    X'5900'    ; =0x5900 =22784
8141(E3     )      DC    'c'        ; hex:e3 dec:227(-29)
8142(5846   )      DW    X'5846'    ; =0x5846 =22598
8144(B8     )      DC    '8'        ; hex:b8 dec:184(-72)
8145(2500   )      DW    X'2500'    ; =0x2500 =9472
8147(2765   )      DW    X'2765'    ; =0x2765 =10085
8149(56DF   )      DW    X'56DF'    ; =0x56df =22239
814b(7500   )      DW    X'7500'    ; =0x7500 =29952
814d(0576   )      DW    X'0576'    ; =0x0576 =1398
814f(1F     )      DB    X'1F'      ; =0x1f =31
8150(F9E3   )      DC    'yc'       ; hex:f9e3 dec:63971(-29)
8152(00     )      DB    X'00'      ; =0x00 =0 =NUL
8153(00     )      DB    X'00'      ; =0x00 =0 =NUL
8154(A1     )      DC    '!'        ; hex:a1 dec:161(-95)
8155(8489   )      DW    X'8489'    ; =0x8489 =33929(-31607)
8157(7C     )      DB    X'7C'      ; =0x7c =124
8158(1000   )W8158 DW    X'1000'    ; =0x1000 =4096
815a(000000+)      DB    0,4        ; =0x00,0x0004
815e(10     )      DB    X'10'      ; =0x10 =16
815f(B5     )      DC    '5'        ; hex:b5 dec:181(-75)
8160(586C   )      DW    X'586C'    ; =0x586c =22636
8162(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
8163(8911   )      DW    X'8911'    ; =0x8911 =35089(-30447)
8165(72     )      DB    X'72'      ; =0x72 =114
8166(B8     )      DC    '8'        ; hex:b8 dec:184(-72)
8167(3C7D   )      DW    X'3C7D'    ; =0x3c7d =15485
8169(5212   )      DW    X'5212'    ; =0x5212 =21010
816b(387A   )      DW    X'387A'    ; =0x387a =14458
816d(6E75   )      DW    X'6E75'    ; =0x6e75 =28277
816f(6213   )      DW    X'6213'    ; =0x6213 =25107
8171(06     )      DB    X'06'      ; =0x06 =6
8172(FE     )      DC    '~'        ; hex:fe dec:254(-2)
8173(0A31   )      DW    X'0A31'    ; =0x0a31 =2609
8175(B7     )      DC    '7'        ; hex:b7 dec:183(-73)
8176(13     )      DB    X'13'      ; =0x13 =19
8177(DEA6   )      DC    '^&'       ; hex:dea6 dec:56998(-90)
8179(4C12   )      DW    X'4C12'    ; =0x4c12 =19474
817b(3414   )      DW    X'3414'    ; =0x3414 =13332
817d(BFDAD5 )      DC    '?ZU'      ; hex:bfdad5
8180(362A   )      DW    X'362A'    ; =0x362a =13866
8182(15     )      DB    X'15'      ; =0x15 =21
8183(AB     )      DC    '+'        ; hex:ab dec:171(-85)
8184(07     )      DB    X'07'      ; =0x07 =7
8185(DD     )      DC    ']'        ; hex:dd dec:221(-35)
8186(4854   )      DW    X'4854'    ; =0x4854 =18516
8188(16     )      DB    X'16'      ; =0x16 =22
8189(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
818a(9E66   )      DW    X'9E66'    ; =0x9e66 =40550(-24986)
818c(7F3C   )      DW    X'7F3C'    ; =0x7f3c =32572
818e(17     )      DB    X'17'      ; =0x17 =23
818f(A1     )      DC    '!'        ; hex:a1 dec:161(-95)
8190(1473   )      DW    X'1473'    ; =0x1473 =5235
8192(EB     )      DC    'k'        ; hex:eb dec:235(-21)
8193(0218   )      DW    X'0218'    ; =0x0218 =536
8195(ACE5   )      DC    ',e'       ; hex:ace5 dec:44261(-27)
8197(422A   )      DW    X'422A'    ; =0x422a =16938
8199(A1     )      DC    '!'        ; hex:a1 dec:161(-95)
819a(19     )      DB    X'19'      ; =0x19 =25
819b(C4     )      DC    'D'        ; hex:c4 dec:196(-60)
819c(9182   )      DW    X'9182'    ; =0x9182 =37250(-28286)
819e(A3F1   )      DC    '#q'       ; hex:a3f1 dec:41969(-15)
81a0(1A     )      DB    X'1A'      ; =0x1a =26
81a1(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
81a2(9F99   )      DW    X'9F99'    ; =0x9f99 =40857(-24679)
81a4(5A     )      DB    X'5A'      ; =0x5a =90
81a5(D4     )      DC    'T'        ; hex:d4 dec:212(-44)
81a6(1C19   )      DW    X'1C19'    ; =0x1c19 =7193
81a8(9B     )      DB    X'9B'      ; =0x9b =155(-101)
81a9(DD     )      DC    ']'        ; hex:dd dec:221(-35)
81aa(8553   )      DW    X'8553'    ; =0x8553 =34131(-31405)
81ac(1D58   )      DW    X'1D58'    ; =0x1d58 =7512
81ae(18     )      DB    X'18'      ; =0x18 =24
81af(DCFBA5 )      DC    '\{%'      ; hex:dcfba5
81b2(1E     )      DB    X'1E'      ; =0x1e =30
81b3(A4AFA2+)      DC    '$/"$'     ; hex:a4afa2a4
81b7(91     )      DB    X'91'      ; =0x91 =145(-111)
81b8:ENDPT


 TITLE 'LOG40'
LOG40 BEGIN 0
*
 EXT MUL48
*
*
* Function LOG40
*
8000(5580   )LOG40 XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
800a(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
800c(6521   )      LDX+  B+         ; [Load X indexed, direct, post-incremented]
800e(1612   )      BM    D8022      ; =+18 [Branch on minus]
8010(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8012(5C     )      XAY              ; [Transfer A to Y]
8013(D9     )      LDB+  B          ; [Load B from address in B]
8014(8008   )      LDAB= X'08'      ; =8 [Load AL with immediate]
8016(5528   )      XFR   B,Z        ; [Transfer B to Z]
8018(152C   )      BNZ   D8046      ; =+44 [Branch if not zero]
801a(5566   )      XFR   Y,Y        ; [Transfer Y to Y]
801c(1528   )      BNZ   D8046      ; =+40 [Branch if not zero]
801e(5544   )      XFR   X,X        ; [Transfer X to X]
8020(1524   )      BNZ   D8046      ; =+36 [Branch if not zero]
8022(03     )D8022 RF               ; [Reset fault]
8023(65A1   )J8023 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8025(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8027(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8029(5C     )      XAY              ; [Transfer A to Y]
802a(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802c(5E     )      XAZ              ; [Transfer A to Z]
802d(09     )      RSR              ; [Return from subroutine]
*
802e(0000   )W802E DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8030(0000   )W8030 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8032(0000   )W8032 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8034(0000   )W8034 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8036(0000   )W8036 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8038(0000   )W8038 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
803a(00     )W803A DB    X'00'      ; =0x00 =0 =NUL
803b(00     )W803B DB    X'00'      ; =0x00 =0 =NUL
803c(00     )W803C DB    X'00'      ; =0x00 =0 =NUL
803d(00     )W803D DB    X'00'      ; =0x00 =0 =NUL
803e(00     )W803E DB    X'00'      ; =0x00 =0 =NUL
803f(000000+)S803F DB    0,7        ; =0x00,0x0007
*
8046(29     )D8046 DCAB             ; [Decrement AL]
8047(07     )      RL               ; [Reset link]
8048(3780   )      RLR   Z          ; [Left rotate Z by 1]
804a(3760   )      RLR   Y          ; [Left rotate Y by 1]
804c(3740   )      RLR   X          ; [Left rotate X by 1]
804e(11F6   )      BNL   D8046      ; =-10 [Branch on no link]
8050(A1814B )      STAB/ B814A+1    ; =0x814b =33099(-32437) [Store AL direct]
8053(6BDF   )      STX   W8034      ; =-33 [Store X relative]
8055(5560   )      XFR   Y,A        ; [Transfer Y to A]
8057(B3DD   )      STA   W8036      ; =-35 [Store A relative]
8059(5580   )      XFR   Z,A        ; [Transfer Z to A]
805b(B3DB   )      STA   W8038      ; =-37 [Store A relative]
805d(3A     )      CLA              ; [Clear A]
805e(B3CE   )      STA   W802E      ; =-50 [Store A relative]
8060(B3CE   )      STA   W8030      ; =-50 [Store A relative]
8062(B3CE   )      STA   W8032      ; =-50 [Store A relative]
8064(93D2   )D8064 LDA   W8038      ; =-46 [Load A relative]
8066(5E     )      XAZ              ; [Transfer A to Z]
8067(93CD   )      LDA   W8036      ; =-51 [Load A relative]
8069(5C     )      XAY              ; [Transfer A to Y]
806a(63C8   )      LDX   W8034      ; =-56 [Load X relative]
806c(90FF00 )      LDA=  X'FF00'    ; =0xff00 =65280(-256) [Load A with immediate]
806f(83C3   )      LDAB  W8034      ; =-61 [Load AL relative]
8071(146C   )      BZ    D80DF      ; =+108 [Branch if zero]
8073(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
8075(4331   )      ORIB  BL,AL      ; [BL | AL -> AL]
8077(06     )      SL               ; [Set link]
8078(3640   )      RRR   X          ; [Right rotate X by 1]
807a(3660   )      RRR   Y          ; [Right rotate Y by 1]
807c(3680   )      RRR   Z          ; [Right rotate Z by 1]
807e(2000   )D807E INRB  AU         ; [Increment AU by 1]
8080(07     )      RL               ; [Reset link]
8081(3640   )      RRR   X          ; [Right rotate X by 1]
8083(3660   )      RRR   Y          ; [Right rotate Y by 1]
8085(3680   )      RRR   Z          ; [Right rotate Z by 1]
8087(2D     )      SLAB             ; [Left shift AL]
8088(11F4   )      BNL   D807E      ; =-12 [Branch on no link]
808a(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
808c(4501   )      XFRB  AU,AL      ; [Transfer AU to AL]
808e(2200   )      CLRB  AU         ; [Clear AU]
8090(3D     )      SLA              ; [Left shift A]
8091(5D     )      XAB              ; [Transfer A to B]
8092(3D     )      SLA              ; [Left shift A]
8093(58     )      AAB              ; [A + B -> B]
8094(6081B4 )      LDX=  W81B4      ; =0x81b4 =33204(-32332) [Load X with immediate]
8097(5024   )      ADD   B,X        ; [B + X -> X]
8099(9542   )      LDA-  X-         ; [Load A indexed, pre-decremented, direct]
809b(D395   )      LDB   W8032      ; =-107 [Load B relative]
809d(58     )      AAB              ; [A + B -> B]
809e(F392   )      STB   W8032      ; =-110 [Store B relative]
80a0(9542   )      LDA-  X-         ; [Load A indexed, pre-decremented, direct]
80a2(D38C   )      LDB   W8030      ; =-116 [Load B relative]
80a4(1101   )      BNL   D80A7      ; =+1 [Branch on no link]
80a6(38     )      INA              ; [Increment A]
80a7(58     )D80A7 AAB              ; [A + B -> B]
80a8(F386   )      STB   W8030      ; =-122 [Store B relative]
80aa(9542   )      LDA-  X-         ; [Load A indexed, pre-decremented, direct]
80ac(D380   )      LDB   W802E      ; =-128 [Load B relative]
80ae(1101   )      BNL   D80B1      ; =+1 [Branch on no link]
80b0(38     )      INA              ; [Increment A]
80b1(58     )D80B1 AAB              ; [A + B -> B]
80b2(F1802E )      STB/  W802E      ; =0x802e =32814(-32722) [Store B direct]
80b5(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
80b7(918038 )      LDA/  W8038      ; =0x8038 =32824(-32712) [Load A direct]
80ba(5582   )      XFR   Z,B        ; [Transfer Z to B]
80bc(59     )      SAB              ; [A - B -> B]
80bd(F18038 )      STB/  W8038      ; =0x8038 =32824(-32712) [Store B direct]
80c0(918036 )      LDA/  W8036      ; =0x8036 =32822(-32714) [Load A direct]
80c3(5562   )      XFR   Y,B        ; [Transfer Y to B]
80c5(1007   )      BL    D80CE      ; =+7 [Branch on link]
80c7(3020   )      INR   B          ; [Increment B by 1]
80c9(1503   )      BNZ   D80CE      ; =+3 [Branch if not zero]
80cb(5D     )      XAB              ; [Transfer A to B]
80cc(7301   )      JMP   D80CF      ; =+1 [Jump relative]
80ce(59     )D80CE SAB              ; [A - B -> B]
80cf(F18036 )D80CF STB/  W8036      ; =0x8036 =32822(-32714) [Store B direct]
80d2(918034 )      LDA/  W8034      ; =0x8034 =32820(-32716) [Load A direct]
80d5(1001   )      BL    D80D8      ; =+1 [Branch on link]
80d7(3E     )      INX              ; [Increment X]
80d8(5104   )D80D8 SUB   A,X        ; [A - X -> X]
80da(698034 )      STX/  W8034      ; =0x8034 =32820(-32716) [Store X direct]
80dd(1085   )      BL    D8064      ; =-123 [Branch on link]
80df(9081F2 )D80DF LDA=  ENDPT      ; =0x81f2 =33266(-32270) [Load A with immediate]
80e2(5E     )      XAZ              ; [Transfer A to Z]
80e3(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
80e5(B1803E )      STA/  W803E      ; =0x803e =32830(-32706) [Store A direct]
80e8(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
80ea(B1803C )      STA/  W803C      ; =0x803c =32828(-32708) [Store A direct]
80ed(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
80ef(B1803A )      STA/  W803A      ; =0x803a =32826(-32710) [Store A direct]
80f2(79EEEE )D80F2 JSR/  MUL48      ; [external symbol] [Jump to subroutine direct]
80f5(8034   )      DW    W8034      ; =0x8034 =32820(-32716)
80f7(803A   )      DW    W803A      ; =0x803a =32826(-32710)
80f9(803A   )      DW    W803A      ; =0x803a =32826(-32710)
80fb(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
80fd(1627   )      BM    D8126      ; =+39 [Branch on minus]
80ff(D1803E )      LDB/  W803E      ; =0x803e =32830(-32706) [Load B direct]
8102(59     )      SAB              ; [A - B -> B]
8103(F1803E )      STB/  W803E      ; =0x803e =32830(-32706) [Store B direct]
8106(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
8108(D1803C )      LDB/  W803C      ; =0x803c =32828(-32708) [Load B direct]
810b(1007   )      BL    D8114      ; =+7 [Branch on link]
810d(3020   )      INR   B          ; [Increment B by 1]
810f(1503   )      BNZ   D8114      ; =+3 [Branch if not zero]
8111(5D     )      XAB              ; [Transfer A to B]
8112(7301   )      JMP   D8115      ; =+1 [Jump relative]
8114(59     )D8114 SAB              ; [A - B -> B]
8115(F1803C )D8115 STB/  W803C      ; =0x803c =32828(-32708) [Store B direct]
8118(9582   )      LDA-  Z-         ; [Load A indexed, pre-decremented, direct]
811a(D1803A )      LDB/  W803A      ; =0x803a =32826(-32710) [Load B direct]
811d(1001   )      BL    D8120      ; =+1 [Branch on link]
811f(39     )      DCA              ; [Decrement A]
8120(59     )D8120 SAB              ; [A - B -> B]
8121(F1803A )      STB/  W803A      ; =0x803a =32826(-32710) [Store B direct]
8124(73CC   )      JMP   D80F2      ; =-52 [Jump relative]
8126(91803F )D8126 LDA/  S803F      ; =0x803f =32831(-32705) [Load A direct]
8129(D18032 )      LDB/  W8032      ; =0x8032 =32818(-32718) [Load B direct]
812c(58     )      AAB              ; [A + B -> B]
812d(5528   )      XFR   B,Z        ; [Transfer B to Z]
812f(91803D )      LDA/  W803D      ; =0x803d =32829(-32707) [Load A direct]
8132(D18030 )      LDB/  W8030      ; =0x8030 =32816(-32720) [Load B direct]
8135(1103   )      BNL   D813A      ; =+3 [Branch on no link]
8137(38     )      INA              ; [Increment A]
8138(1401   )      BZ    D813B      ; =+1 [Branch if zero]
813a(58     )D813A AAB              ; [A + B -> B]
813b(5526   )D813B XFR   B,Y        ; [Transfer B to Y]
813d(91803B )      LDA/  W803B      ; =0x803b =32827(-32709) [Load A direct]
8140(61802E )      LDX/  W802E      ; =0x802e =32814(-32722) [Load X direct]
8143(1101   )      BNL   D8146      ; =+1 [Branch on no link]
8145(38     )      INA              ; [Increment A]
8146(5004   )D8146 ADD   A,X        ; [A + X -> X]
8148(2230   )      CLRB  BL         ; [Clear BL]
814a(8000   )B814A LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
814c(143E   )      BZ    D818C      ; =+62 [Branch if zero]
814e(161E   )      BM    D816E      ; =+30 [Branch on minus]
8150(29     )      DCAB             ; [Decrement AL]
8151(A3F8   )      STAB  B814A+1    ; =-8 [Store AL relative]
8153(90D1D0 )      LDA=  X'D1D0'    ; =0xd1d0 =53712(-11824) ='Q','P' [Load A with immediate]
8156(5008   )      ADD   A,Z        ; [A + Z -> Z]
8158(9017F7 )      LDA=  X'17F7'    ; =0x17f7 =6135 [Load A with immediate]
815b(1101   )      BNL   D815E      ; =+1 [Branch on no link]
815d(38     )      INA              ; [Increment A]
815e(5006   )D815E ADD   A,Y        ; [A + Y -> Y]
8160(90B172 )      LDA=  X'B172'    ; =0xb172 =45426(-20110) [Load A with immediate]
8163(1101   )      BNL   D8166      ; =+1 [Branch on no link]
8165(38     )      INA              ; [Increment A]
8166(5004   )D8166 ADD   A,X        ; [A + X -> X]
8168(1102   )      BNL   D816C      ; =+2 [Branch on no link]
816a(2030   )      INRB  BL         ; [Increment BL by 1]
816c(73DC   )D816C JMP   B814A      ; =-36 [Jump relative]
816e(28     )D816E INAB             ; [Increment AL]
816f(A3DA   )      STAB  B814A+1    ; =-38 [Store AL relative]
8171(902E30 )      LDA=  X'2E30'    ; =0x2e30 =11824 [Load A with immediate]
8174(5008   )      ADD   A,Z        ; [A + Z -> Z]
8176(90E808 )      LDA=  X'E808'    ; =0xe808 =59400(-6136) [Load A with immediate]
8179(1101   )      BNL   D817C      ; =+1 [Branch on no link]
817b(38     )      INA              ; [Increment A]
817c(5006   )D817C ADD   A,Y        ; [A + Y -> Y]
817e(904E8D )      LDA=  X'4E8D'    ; =0x4e8d =20109 [Load A with immediate]
8181(1101   )      BNL   D8184      ; =+1 [Branch on no link]
8183(38     )      INA              ; [Increment A]
8184(5004   )D8184 ADD   A,X        ; [A + X -> X]
8186(1002   )      BL    D818A      ; =+2 [Branch on link]
8188(2130   )      DCRB  BL         ; [Decrement BL by 1]
818a(73BE   )D818A JMP   B814A      ; =-66 [Jump relative]
818c(4599   )D818C XFRB  ZL,ZL      ; [Transfer ZL to ZL]
818e(170D   )      BP    D819D      ; =+13 [Branch on plus]
8190(2080   )      INRB  ZU         ; [Increment ZU by 1]
8192(1509   )      BNZ   D819D      ; =+9 [Branch if not zero]
8194(3060   )      INR   Y          ; [Increment Y by 1]
8196(1505   )      BNZ   D819D      ; =+5 [Branch if not zero]
8198(3E     )      INX              ; [Increment X]
8199(1502   )      BNZ   D819D      ; =+2 [Branch if not zero]
819b(2030   )      INRB  BL         ; [Increment BL by 1]
819d(95A4   )D819D LDA+  *S         ; [Load A indexed, indirect]
819f(E501   )      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
81a1(6D01   )      STX+  A+         ; [Store X indexed, direct, post-incremented]
81a3(5562   )      XFR   Y,B        ; [Transfer Y to B]
81a5(F501   )      STB+  A+         ; [Store B indexed, direct, post-incremented]
81a7(4583   )      XFRB  ZU,BL      ; [Transfer ZU to BL]
81a9(E8     )      STBB+ A          ; [Store BL to address in A]
81aa(03     )      RF               ; [Reset fault]
81ab(718023 )      JMP/  J8023      ; =0x8023 =32803(-32733) [Jump direct]
*
81ae(49     )      DB    X'49'      ; =0x49 =73
81af(A5     )      DC    '%'        ; hex:a5 dec:165(-91)
81b0(8844   )      DW    X'8844'    ; =0x8844 =34884(-30652)
81b2(D3     )      DC    'S'        ; hex:d3 dec:211(-45)
81b3(6E     )      DB    X'6E'      ; =0x6e =110
81b4(222F   )W81B4 DW    X'222F'    ; =0x222f =8751
81b6(1D04   )      DW    X'1D04'    ; =0x1d04 =7428
81b8(4F     )      DB    X'4F'      ; =0x4f =79
81b9(C8     )      DC    'H'        ; hex:c8 dec:200(-56)
81ba(1085   )      DW    X'1085'    ; =0x1085 =4229
81bc(98     )      DB    X'98'      ; =0x98 =152(-104)
81bd(B5     )      DC    '5'        ; hex:b5 dec:181(-75)
81be(9E3A   )      DW    X'9E3A'    ; =0x9e3a =40506(-25030)
81c0(0820   )      DW    X'0820'    ; =0x0820 =2080
81c2(AEC4F3+)      DC    '.Ds"'     ; hex:aec4f3a2
81c6(0408   )      DW    X'0408'    ; =0x0408 =1032
81c8(1596   )      DW    X'1596'    ; =0x1596 =5526
81ca(24     )      DB    X'24'      ; =0x24 =36
81cb(D5     )      DC    'U'        ; hex:d5 dec:213(-43)
81cc(0202   )      DW    X'0202'    ; =0x0202 =514
81ce(02     )      DB    X'02'      ; =0x02 =2
81cf(AEB1   )      DC    '.1'       ; hex:aeb1 dec:44721(-79)
81d1(1B01   )      DW    X'1B01'    ; =0x1b01 =6913
81d3(00     )      DB    X'00'      ; =0x00 =0 =NUL
81d4(8055   )      DW    X'8055'    ; =0x8055 =32853(-32683)
81d6(9588   )      DW    X'9588'    ; =0x9588 =38280(-27256)
81d8(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1)
81da(0100   )      DW    X'0100'    ; =0x0100 =256
81dc(000000+)      DB    0,5        ; =0x00,0x0005
81e1(8000   )      DW    X'8000'    ; =0x8000 =32768(-32768)
81e3(000000+)      DB    0,4        ; =0x00,0x0004
81e7(5555   )      DW    X'5555'    ; =0x5555 =21845
81e9(5555   )      DW    X'5555'    ; =0x5555 =21845
81eb(5500   )      DW    X'5500'    ; =0x5500 =21760
81ed(4000   )      DW    X'4000'    ; =0x4000 =16384
81ef(000000 )      DB    0,3        ; =0x00,0x0003
81f2:ENDPT


 TITLE 'MUL48'
MUL48 BEGIN 0
*
*
* Function MUL48
*
8000(5580   )MUL48 XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(3A     )      CLA              ; [Clear A]
8009(B341   )      STA   W804C      ; =+65 [Store A relative]
800b(B341   )      STA   W804E      ; =+65 [Store A relative]
800d(B341   )      STA   W8050      ; =+65 [Store A relative]
800f(B349   )      STA   W8059+1    ; =+73 [Store A relative]
8011(B180D1 )      STA/  W80D0+1    ; =0x80d1 =32977(-32559) [Store A direct]
8014(B180DD )      STA/  W80DC+1    ; =0x80dd =32989(-32547) [Store A direct]
8017(A373   )      STAB  B808B+1    ; =+115 [Store AL relative]
8019(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
801b(D00006 )      LDB=  X'0006'    ; =0x0006 =6 [Load B with immediate]
801e(58     )      AAB              ; [A + B -> B]
801f(5526   )      XFR   B,Y        ; [Transfer B to Y]
8021(C8     )      LDBB+ A          ; [Load BL from address in A]
8022(E180CC )      STBB/ B80CB+1    ; =0x80cc =32972(-32564) [Store BL direct]
8025(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8027(89     )      LDAB+ B          ; [Load AL from address in B]
8028(A35E   )      STAB  B8087+1    ; =+94 [Store AL relative]
802a(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
802c(B318   )      STA   W8046      ; =+24 [Store A relative]
802e(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8030(B316   )      STA   W8048      ; =+22 [Store A relative]
8032(99     )      LDA+  B          ; [Load A from address in B]
8033(B315   )      STA   W804A      ; =+21 [Store A relative]
8035(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8037(D0000C )      LDB=  X'000C'    ; =0x000c =12 [Load B with immediate]
803a(58     )      AAB              ; [A + B -> B]
803b(5528   )      XFR   B,Z        ; [Transfer B to Z]
803d(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
803f(8003   )      LDAB= X'03'      ; =3 [Load AL with immediate]
8041(A36B   )      STAB  B80AD+1    ; =+107 [Store AL relative]
8043(3A     )      CLA              ; [Clear A]
8044(730C   )      JMP   D8052      ; =+12 [Jump relative]
*
8046(       )W8046 DS    2          ; =0x0002 [Uninitialized memory]
8048(       )W8048 DS    2          ; =0x0002 [Uninitialized memory]
804a(       )W804A DS    2          ; =0x0002 [Uninitialized memory]
804c(       )W804C DS    2          ; =0x0002 [Uninitialized memory]
804e(       )W804E DS    2          ; =0x0002 [Uninitialized memory]
8050(       )W8050 DS    2          ; =0x0002 [Uninitialized memory]
*
8052(9562   )D8052 LDA-  Y-         ; [Load A indexed, pre-decremented, direct]
8054(C376   )      LDBB  B80CB+1    ; =+118 [Load BL relative]
8056(1709   )      BP    D8061      ; =+9 [Branch on plus]
8058(3B     )      IVA              ; [Invert A]
8059(D00000 )W8059 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
805c(1503   )      BNZ   D8061      ; =+3 [Branch if not zero]
805e(38     )      INA              ; [Increment A]
805f(B3F9   )      STA   W8059+1    ; =-7 [Store A relative]
8061(3600   )D8061 RRR   A          ; [Right rotate A by 1]
8063(B33D   )      STA   W80A1+1    ; =+61 [Store A relative]
8065(600010 )      LDX=  X'0010'    ; =0x0010 =16 [Load X with immediate]
8068(1121   )D8068 BNL   B808B      ; =+33 [Branch on no link]
806a(93DE   )      LDA   W804A      ; =-34 [Load A relative]
806c(D3E2   )      LDB   W8050      ; =-30 [Load B relative]
806e(58     )      AAB              ; [A + B -> B]
806f(F3DF   )      STB   W8050      ; =-33 [Store B relative]
8071(93D5   )      LDA   W8048      ; =-43 [Load A relative]
8073(D3D9   )      LDB   W804E      ; =-39 [Load B relative]
8075(1103   )      BNL   D807A      ; =+3 [Branch on no link]
8077(38     )      INA              ; [Increment A]
8078(1401   )      BZ    D807B      ; =+1 [Branch if zero]
807a(58     )D807A AAB              ; [A + B -> B]
807b(F3D1   )D807B STB   W804E      ; =-47 [Store B relative]
807d(93C7   )      LDA   W8046      ; =-57 [Load A relative]
807f(D3CB   )      LDB   W804C      ; =-53 [Load B relative]
8081(1101   )      BNL   D8084      ; =+1 [Branch on no link]
8083(38     )      INA              ; [Increment A]
8084(58     )D8084 AAB              ; [A + B -> B]
8085(F3C5   )      STB   W804C      ; =-59 [Store B relative]
8087(8000   )B8087 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8089(A301   )      STAB  B808B+1    ; =+1 [Store AL relative]
808b(8000   )B808B LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
808d(2710   )      RLRB  AL         ; [Left rotate AL by 1]
808f(93BB   )      LDA   W804C      ; =-69 [Load A relative]
8091(3600   )      RRR   A          ; [Right rotate A by 1]
8093(B3B7   )      STA   W804C      ; =-73 [Store A relative]
8095(93B7   )      LDA   W804E      ; =-73 [Load A relative]
8097(3600   )      RRR   A          ; [Right rotate A by 1]
8099(B3B3   )      STA   W804E      ; =-77 [Store A relative]
809b(93B3   )      LDA   W8050      ; =-77 [Load A relative]
809d(3600   )      RRR   A          ; [Right rotate A by 1]
809f(B3AF   )      STA   W8050      ; =-81 [Store A relative]
80a1(900000 )W80A1 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
80a4(3600   )      RRR   A          ; [Right rotate A by 1]
80a6(B3FA   )      STA   W80A1+1    ; =-6 [Store A relative]
80a8(3F     )      DCX              ; [Decrement X]
80a9(18BD   )      BGZ   D8068      ; =-67 [Branch if greater than zero]
80ab(7B1E   )      JSR   B80CB      ; =+30 [Jump to subroutine relative]
80ad(8000   )B80AD LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
80af(29     )      DCAB             ; [Decrement AL]
80b0(A3FC   )      STAB  B80AD+1    ; =-4 [Store AL relative]
80b2(189E   )      BGZ   D8052      ; =-98 [Branch if greater than zero]
80b4(939A   )      LDA   W8050      ; =-102 [Load A relative]
80b6(7B13   )      JSR   B80CB      ; =+19 [Jump to subroutine relative]
80b8(9394   )      LDA   W804E      ; =-108 [Load A relative]
80ba(7B0F   )      JSR   B80CB      ; =+15 [Jump to subroutine relative]
80bc(938E   )      LDA   W804C      ; =-114 [Load A relative]
80be(7B0B   )      JSR   B80CB      ; =+11 [Jump to subroutine relative]
80c0(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
80c2(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
80c4(5C     )      XAY              ; [Transfer A to Y]
80c5(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
80c7(5E     )      XAZ              ; [Transfer A to Z]
80c8(9313   )      LDA   W80DC+1    ; =+19 [Load A relative]
80ca(09     )      RSR              ; [Return from subroutine]
*
80cb(C000   )B80CB LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
80cd(1709   )      BP    D80D8      ; =+9 [Branch on plus]
80cf(3B     )      IVA              ; [Invert A]
80d0(D00000 )W80D0 LDB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load B with immediate]
80d3(1503   )      BNZ   D80D8      ; =+3 [Branch if not zero]
80d5(38     )      INA              ; [Increment A]
80d6(B3F9   )      STA   W80D0+1    ; =-7 [Store A relative]
80d8(B582   )D80D8 STA-  Z-         ; [Store A indexed, pre-decremented, direct]
80da(1403   )      BZ    D80DF      ; =+3 [Branch if zero]
80dc(B00000 )W80DC STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
80df(09     )D80DF RSR              ; [Return from subroutine]
*
80e0:ENDPT


***Address 0x87D7 for variable ADLST not defined.
 TITLE 'SCREEN'
SCREEN BEGIN 0
*
 ENT SCREDT
ADLST EQU X'87D7'
 ENT ADLST
 ENT FIELD
 ENT FTYPE
 ENT FLEN
 ENT FDEC
 ENT FV
 ENT FH
 ENT FMIN
 ENT FMAX
 ENT XSTAT
 ENT FSCR
 ENT ?DATA
*
 EXT ZERO
 EXT CRT
 EXT MSGN
 EXT @IF
 EXT @LI
 EXT @LL
 EXT CSD03
*
*
* Function SCREEN
*
8000(9541   )SCREEN LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8004(150D   )      BNZ   D8013      ; =+13 [Branch if not zero]
8006(479003+)      FIL   (4)/ZERO,/FSCR ; [external symbol],=0x88f2 =35058(-30478) [Fill with byte, direct, direct]
800d(B188F4 )      STA/  W88F4      ; =0x88f4 =35060(-30476) [Store A direct]
8010(718019 )      JMP/  J8019      ; =0x8019 =32793(-32743) [Jump direct]
8013(463338+)D8013 ZAD   -A(4),/FSCR(4) ; =0x88f2 =35058(-30478) [Zero-add bignum, indexed, direct]
8019(9541   )J8019 LDA+  X+         ; [Load A indexed, direct, post-incremented]
801b(B18152 )      STA/  W8151+1    ; =0x8152 =33106(-32430) [Store A direct]
801e(8000   )W801E LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8020(150A   )      BNZ   D802C      ; =+10 [Branch if not zero]
8022(301080+)      INC/  W801E      ; =0x801e =32798(-32738) [Increment word at address by 1]
8026(6639   )      SVC   57         ; =0x39 [Service call OP - CPL open]
8028(01     )      DB    X'01'      ; =0x01 =1 [Mode: input]
8029(894D   )      DW    L894D      ; =0x894d =35149(-30387) [address of FCB]
802b(00     )      DB    X'00'      ; =0x00 =0 =NUL [argument list terminator]
*
802c(321083+)D802C CAD/  W83DC      ; [Clear word at address]
8030(474C01+)      MVF   (2)=X'0101',/W83DE ; =0x83de =33758(-31778) [Move fixed-length, literal=257, direct]
8037(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
8039(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
803b(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
803d(89C9   )      DW    L89C9      ; =0x89c9 =35273(-30263) [address of argument]
803f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8041(3A     )      CLA              ; [Clear A]
8042(B188D2 )      STA/  FV         ; =0x88d2 =35026(-30510) [Store A direct]
8045(B188D4 )      STA/  W88D4      ; =0x88d4 =35028(-30508) [Store A direct]
8048(79813D )D8048 JSR/  F813D      ; =0x813d =33085(-32451) [Jump to subroutine direct]
804b(301088+)      INC/  W88D4      ; =0x88d4 =35028(-30508) [Increment word at address by 1]
804f(46002C+)      C     =21,/N88D5(1) ; =0x88d5 =35029(-30507) [Compare bignums, literal=0x15, direct]
8055(19F1   )      BLE   D8048      ; =-15 [Branch if less than or equal to zero]
8057(09     )      RSR              ; [Return from subroutine]
*
8058(90     )      DB    X'90'      ; =0x90 =144(-112)
8059(89C7   )      DW    W89C7      ; =0x89c7 =35271(-30265)
*
*
* Function SCREDT
*
805b(B183DC )SCREDT STA/  W83DC      ; =0x83dc =33756(-31780) [Store A direct]
805e(321083+)      CAD/  W83DE      ; [Clear word at address]
8062(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8064(B187AD )      STA/  F87AC+1    ; =0x87ad =34733(-30803) =BEL,'-' [Store A direct]
8067(B18152 )      STA/  W8151+1    ; =0x8152 =33106(-32430) [Store A direct]
806a(798462 )J806A JSR/  F8462      ; =0x8462 =33890(-31646) [Jump to subroutine direct]
806d(463023+)      C     /XSTAT(4),=0 ; =0x88ee =35054(-30482), [Compare bignums, direct, literal=0x00]
8073(1503   )      BNZ   D8078      ; =+3 [Branch if not zero]
8075(718079 )      JMP/  J8079      ; =0x8079 =32889(-32647) [Jump direct]
8078(09     )D8078 RSR              ; [Return from subroutine]
*
8079(798801 )J8079 JSR/  F8801      ; =0x8801 =34817(-30719) [Jump to subroutine direct]
807c(7A89E5 )      JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
807f(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
8081(0001   )      DW    X'0001'    ; =0x0001 =1
8083(80A9   )      DW    W80A9      ; =0x80a9 =32937(-32599)
*
8085(7987AC )      JSR/  F87AC      ; =0x87ac =34732(-30804) =BEL,',' [Jump to subroutine direct]
8088(7A89E5 )      JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
808b(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
808d(0001   )      DW    X'0001'    ; =0x0001 =1
808f(80A9   )      DW    W80A9      ; =0x80a9 =32937(-32599)
8091(798406 )      JSR/  F8406      ; =0x8406 =33798(-31738) [Jump to subroutine direct]
8094(798499 )      JSR/  F8499      ; =0x8499 =33945(-31591) [Jump to subroutine direct]
8097(7A89E5 )      JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
809a(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
809c(0001   )      DW    X'0001'    ; =0x0001 =1
809e(80B9   )      DW    W80B9      ; =0x80b9 =32953(-32583)
*
80a0(7980E4 )      JSR/  F80E4      ; =0x80e4 =32996(-32540) [Jump to subroutine direct]
80a3(79813D )      JSR/  F813D      ; =0x813d =33085(-32451) [Jump to subroutine direct]
80a6(71806A )      JMP/  J806A      ; =0x806a =32874(-32662) [Jump direct]
80a9(662A   )W80A9 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80ab(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80ad(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
80af(0018   )      DW    X'0018'    ; =0x0018 =24 [row address or value]
*
80b1(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80b4(89F9   )      DW    W89F9      ; =0x89f9 =35321(-30215)
80b6(7180C6 )      JMP/  J80C6      ; =0x80c6 =32966(-32570) [Jump direct]
80b9(662A   )W80B9 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80bb(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80bd(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
80bf(0018   )      DW    X'0018'    ; =0x0018 =24 [row address or value]
*
80c1(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80c4(8A0A   )      DW    W8A0A      ; =0x8a0a =35338(-30198)
*
80c6(79EEEE )J80C6 JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80c9(8A19   )      DW    W8A19      ; =0x8a19 =35353(-30183)
80cb(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80cd(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80cf(004F   )      DW    X'004F'    ; =0x004f =79 [column address or value]
80d1(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
80d3(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
80d5(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80d7(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
80d9(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
80db(662F   )      SVC   47         ; =0x2F [Service call CB - CPL cursor blanking]
80dd(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80df(004F   )      DW    X'004F'    ; =0x004f =79 [count]
80e1(71806A )      JMP/  J806A      ; =0x806a =32874(-32662) [Jump direct]
*
* Function F80E4
*
80e4(7A89E5 )F80E4 JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
80e7(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
80e9(0008   )      DW    X'0008'    ; =0x0008 =8
80eb(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80ed(8116   )      DW    W8116      ; =0x8116 =33046(-32490)
80ef(812B   )      DW    W812B      ; =0x812b =33067(-32469)
80f1(8134   )      DW    W8134      ; =0x8134 =33076(-32460)
80f3(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80f5(812B   )      DW    W812B      ; =0x812b =33067(-32469)
80f7(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80f9(8116   )      DW    W8116      ; =0x8116 =33046(-32490)
80fb(918900 )      LDA/  W8900      ; =0x8900 =35072(-30464) [Load A direct]
80fe(B409   )      STA*  P8106+3    ; =+9 [Store A relative indirect]
8100(09     )      RSR              ; [Return from subroutine]
*
8101(56     )W8101 EAO              ; [Enable abort on overflow]
8102(2A     )      CLAB             ; [Clear AL]
8103(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8106(465730+)P8106 ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
810d(467330+)      ZAD   /N89CF(8),/ZERO(4) ; =0x89cf =35279(-30257),[external symbol] [Zero-add bignum, direct, direct]
8114(57     )      DAO              ; [Disable abort on overflow]
8115(09     )      RSR              ; [Return from subroutine]
*
8116(56     )W8116 EAO              ; [Enable abort on overflow]
8117(2A     )      CLAB             ; [Clear AL]
8118(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
811b(465730+)W811B ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8122(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8129(57     )      DAO              ; [Disable abort on overflow]
812a(09     )      RSR              ; [Return from subroutine]
*
812b(472083+)W812B MVV   (132,0)/?DATA,/ZERO ; =0x88fc =35068(-30468),[external symbol] [Move variable-length, direct, direct]
8133(09     )      RSR              ; [Return from subroutine]
*
8134(6605   )W8134 SVC   5          ; =0x05 [Service call TS - load transient module]
8136(0B     )      DB    X'0B'      ; =0x0b =11 [Selector: integer date from GRIN date]
8137(88FE   )      DW    I88FE      ; =0x88fe =35070(-30466) [address of date]
8139(B1EEEE )W8139 STA/  ZERO       ; [external symbol] [Store A direct]
813c(09     )      RSR              ; [Return from subroutine]
*
* Function F813D
*
813d(D188F4 )F813D LDB/  W88F4      ; =0x88f4 =35060(-30476) [Load B direct]
8140(773200+)      MUL=  X'0016',B  ; =0x0016 =22 [22 * B -> B]
8144(502388+)      ADD/  W88D4,B    ; =0x88d4 =35028(-30508) [*Direct + B -> B]
8148(F188F8 )      STB/  W88F8      ; =0x88f8 =35064(-30472) [Store B direct]
814b(6637   )      SVC   55         ; =0x37 [Service call RB - CPL binary read]
814d(894D   )      DW    L894D      ; =0x894d =35149(-30387) [address of FCB]
814f(896B   )      DW    L896B      ; =0x896b =35179(-30357) [address of record]
8151(900000 )W8151 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8154(B187D2 )P8154 STA/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Store A direct]
8157(94FC   )J8157 LDA*  P8154+1    ; =-4 [Load A relative indirect]
8159(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
815b(1503   )      BNZ   D8160      ; =+3 [Branch if not zero]
815d(7183B9 )      JMP/  J83B9      ; =0x83b9 =33721(-31815) [Jump direct]
8160(B4F3   )D8160 STA*  P8154+1    ; =-13 [Store A relative indirect]
8162(D50808 )      LDB+  A,8        ; [Load B indexed, displaced, direct]
8165(798445 )      JSR/  F8445      ; =0x8445 =33861(-31675) [Jump to subroutine direct]
8168(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494)
816a(9188E4 )      LDA/  W88E4      ; =0x88e4 =35044(-30492) [Load A direct]
816d(D188D4 )      LDB/  W88D4      ; =0x88d4 =35028(-30508) [Load B direct]
8170(59     )      SAB              ; [A - B -> B]
8171(140A   )      BZ    D817D      ; =+10 [Branch if zero]
8173(D00012 )      LDB=  X'0012'    ; =0x0012 =18 [Load B with immediate]
8176(94DD   )      LDA*  P8154+1    ; =-35 [Load A relative indirect]
8178(58     )      AAB              ; [A + B -> B]
8179(F4DA   )      STB*  P8154+1    ; =-38 [Store B relative indirect]
817b(73DA   )      JMP   J8157      ; =-38 [Jump relative]
817d(94D6   )D817D LDA*  P8154+1    ; =-42 [Load A relative indirect]
817f(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8181(B4D2   )      STA*  P8154+1    ; =-46 [Store A relative indirect]
8183(F34E   )      STB   W81D2+1    ; =+78 [Store B relative]
8185(F18220 )      STB/  W821F+1    ; =0x8220 =33312(-32224) [Store B direct]
8188(F18227 )      STB/  W8226+1    ; =0x8227 =33319(-32217) [Store B direct]
818b(F18238 )      STB/  W8237+1    ; =0x8238 =33336(-32200) [Store B direct]
818e(F182E3 )      STB/  W82E2+1    ; =0x82e3 =33507(-32029) [Store B direct]
8191(798406 )      JSR/  F8406      ; =0x8406 =33798(-31738) [Jump to subroutine direct]
8194(9188D8 )      LDA/  W88D8      ; =0x88d8 =35032(-30504) [Load A direct]
8197(38     )      INA              ; [Increment A]
8198(B1887B )      STA/  W887B      ; =0x887b =34939(-30597) [Store A direct]
819b(B18888 )      STA/  W8888      ; =0x8888 =34952(-30584) [Store A direct]
819e(B18898 )      STA/  W8898      ; =0x8898 =34968(-30568) [Store A direct]
81a1(B188B5 )      STA/  W88B5      ; =0x88b5 =34997(-30539) [Store A direct]
81a4(B188AB )      STA/  W88AB      ; =0x88ab =34987(-30549) [Store A direct]
81a7(9188CC )      LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
81aa(B188B8 )      STA/  W88B8      ; =0x88b8 =35000(-30536) [Store A direct]
81ad(B188AE )      STA/  W88AE      ; =0x88ae =34990(-30546) [Store A direct]
81b0(7A89E5 )      JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
81b3(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
81b5(0008   )      DW    X'0008'    ; =0x0008 =8
81b7(81D2   )      DW    W81D2      ; =0x81d2 =33234(-32302)
81b9(81DE   )      DW    W81DE      ; =0x81de =33246(-32290)
81bb(8219   )      DW    W8219      ; =0x8219 =33305(-32231)
81bd(8226   )      DW    W8226      ; =0x8226 =33318(-32218)
81bf(8235   )      DW    W8235      ; =0x8235 =33333(-32203)
81c1(82C3   )      DW    W82C3      ; =0x82c3 =33475(-32061)
81c3(82C7   )      DW    W82C7      ; =0x82c7 =33479(-32057)
81c5(82E0   )      DW    W82E0      ; =0x82e0 =33504(-32032)
81c7(930A   )      LDA   W81D2+1    ; =+10 [Load A relative]
81c9(5C     )      XAY              ; [Transfer A to Y]
81ca(3A     )      CLA              ; [Clear A]
81cb(DB     )      LDB+  Y          ; [Load B from address in Y]
81cc(1701   )      BP    D81CF      ; =+1 [Branch on plus]
81ce(3B     )      IVA              ; [Invert A]
81cf(5D     )D81CF XAB              ; [Transfer A to B]
81d0(7313   )      JMP   D81E5      ; =+19 [Jump relative]
81d2(900000 )W81D2 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
81d5(5C     )      XAY              ; [Transfer A to Y]
81d6(3A     )      CLA              ; [Clear A]
81d7(D561   )      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
81d9(1701   )      BP    D81DC      ; =+1 [Branch on plus]
81db(3B     )      IVA              ; [Invert A]
81dc(7307   )D81DC JMP   D81E5      ; =+7 [Jump relative]
81de(93F3   )W81DE LDA   W81D2+1    ; =-13 [Load A relative]
81e0(5C     )      XAY              ; [Transfer A to Y]
81e1(9561   )      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
81e3(D561   )      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
81e5(B188FC )D81E5 STA/  ?DATA      ; =0x88fc =35068(-30468) [Store A direct]
81e8(F188FE )      STB/  I88FE      ; =0x88fe =35070(-30466) [Store B direct]
81eb(9B     )      LDA+  Y          ; [Load A from address in Y]
81ec(B18900 )      STA/  W8900      ; =0x8900 =35072(-30464) [Store A direct]
81ef(9188CC )      LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
81f2(5D     )      XAB              ; [Transfer A to B]
81f3(2111   )      DCRB  AL,2       ; [Decrement AL by 2]
81f5(1606   )      BM    D81FD      ; =+6 [Branch on minus]
81f7(9188D0 )      LDA/  W88D0      ; =0x88d0 =35024(-30512) [Load A direct]
81fa(59     )      SAB              ; [A - B -> B]
81fb(1603   )      BM    D8200      ; =+3 [Branch on minus]
81fd(718418 )D81FD JMP/  D8418      ; =0x8418 =33816(-31720) [Jump direct]
8200(C0FA   )D8200 LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
8202(2513   )      SLRB  AL,4       ; [Left shift AL by 4]
8204(1402   )      BZ    D8208      ; =+2 [Branch if zero]
8206(C00A   )      LDBB= X'0A'      ; =10 [Load BL with immediate]
8208(48     )D8208 AABB             ; [AL + BL -> BL]
8209(E188AD )      STBB/ S88AD      ; =0x88ad =34989(-30547) [Store BL direct]
820c(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
820e(8974   )      DW    S8974      ; =0x8974 =35188(-30348) [address of string]
8210(88AA   )      DW    L88AA      ; =0x88aa =34986(-30550) [address of format]
8212(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
8214(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8216(718157 )      JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
8219(6633   )W8219 SVC   51         ; =0x33 [Service call NC - CPL encode]
821b(8974   )      DW    S8974      ; =0x8974 =35188(-30348) [address of string]
821d(88B4   )      DW    L88B4      ; =0x88b4 =34996(-30540) [address of format]
821f(EEEE   )W821F DW    ZERO       ; [external symbol] [address of argument]
8221(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8223(718157 )      JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
8226(91EEEE )W8226 LDA/  ZERO       ; [external symbol] [Load A direct]
8229(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
822b(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
822d(0A     )      DB    X'0A'      ; =0x0a =10 [Selector: integer date]
822e(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of integer date]
8230(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8232(718249 )      JMP/  J8249      ; =0x8249 =33353(-32183) [Jump direct]
8235(56     )W8235 EAO              ; [Enable abort on overflow]
8236(2A     )      CLAB             ; [Clear AL]
8237(A1EEEE )W8237 STAB/ @IF        ; [external symbol] [Store AL direct]
823a(463730+)      ZAD   /ZERO(4),/N89CF(8) ; [external symbol],=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8241(467330+)      ZAD   /N89CF(8),/W88E2(4) ; =0x89cf =35279(-30257),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8248(57     )      DAO              ; [Disable abort on overflow]
8249(56     )J8249 EAO              ; [Enable abort on overflow]
824a(2A     )      CLAB             ; [Clear AL]
824b(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
824e(463730+)      ZAD   /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8255(46270C+)      A     =1000000,/N89CF(8) ; =0x89cf =35279(-30257) [Add bignums, literal=0x0f4240, direct]
825d(467330+)      ZAD   /N89CF(8),/W88E2(4) ; =0x89cf =35279(-30257),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8264(57     )      DAO              ; [Disable abort on overflow]
8265(56     )      EAO              ; [Enable abort on overflow]
8266(2A     )      CLAB             ; [Clear AL]
8267(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
826a(463730+)      ZAD   /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8271(46153C+)      ZAD   =10000,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x2710, direct]
8278(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
827b(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
8282(467330+)      ZAD   /N89CF(8),/S88E6(4) ; =0x89cf =35279(-30257),=0x88e6 =35046(-30490) [Zero-add bignum, direct, direct]
8289(57     )      DAO              ; [Disable abort on overflow]
828a(56     )      EAO              ; [Enable abort on overflow]
828b(2A     )      CLAB             ; [Clear AL]
828c(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
828f(463730+)      ZAD   /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8296(46053C+)      ZAD   =100,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x64, direct]
829c(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
829f(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
82a6(467330+)      ZAD   /N89CF(8),/S88EA(4) ; =0x89cf =35279(-30257),=0x88ea =35050(-30486) [Zero-add bignum, direct, direct]
82ad(57     )      DAO              ; [Disable abort on overflow]
82ae(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
82b0(8974   )      DW    S8974      ; =0x8974 =35188(-30348) [address of string]
82b2(8897   )      DW    L8897      ; =0x8897 =34967(-30569) [address of format]
82b4(88E6   )      DW    S88E6      ; =0x88e6 =35046(-30490) [address of argument]
82b6(8A3D   )      DW    S8A3D      ; =0x8a3d =35389(-30147) [address of argument]
82b8(88EA   )      DW    S88EA      ; =0x88ea =35050(-30486) [address of argument]
82ba(8A3D   )      DW    S8A3D      ; =0x8a3d =35389(-30147) [address of argument]
82bc(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of argument]
82be(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
*
82c0(718157 )D82C0 JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
82c3(841E   )W82C3 LDAB* W82E2+1    ; =+30 [Load AL relative indirect]
82c5(730B   )      JMP   D82D2      ; =+11 [Jump relative]
82c7(80CE   )W82C7 LDAB= X'CE'      ; =206(-50) ='N' [Load AL with immediate]
82c9(D318   )      LDB   W82E2+1    ; =+24 [Load B relative]
82cb(D52802 )      LDB+  B,2        ; [Load B indexed, displaced, direct]
82ce(1402   )      BZ    D82D2      ; =+2 [Branch if zero]
82d0(80D9   )      LDAB= X'D9'      ; =217(-39) ='Y' [Load AL with immediate]
82d2(A5A2   )D82D2 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
82d4(9188D8 )      LDA/  W88D8      ; =0x88d8 =35032(-30504) [Load A direct]
82d7(D08975 )      LDB=  L8975      ; =0x8975 =35189(-30347) [Load B with immediate]
82da(58     )      AAB              ; [A + B -> B]
82db(85A1   )      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
82dd(A9     )      STAB+ B          ; [Store AL to address in B]
82de(73E0   )      JMP   D82C0      ; =-32 [Jump relative]
82e0(56     )W82E0 EAO              ; [Enable abort on overflow]
82e1(2A     )      CLAB             ; [Clear AL]
82e2(A1EEEE )W82E2 STAB/ @IF        ; [external symbol] [Store AL direct]
82e5(465730+)      ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
82ec(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
82f3(57     )      DAO              ; [Disable abort on overflow]
82f4(56     )      EAO              ; [Enable abort on overflow]
82f5(2A     )      CLAB             ; [Clear AL]
82f6(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
82f9(465730+)      ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8300(46353C+)      ZAD   =10000000,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x00989680, direct]
8309(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
830c(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
8313(467330+)      ZAD   /N89CF(8),/W88E2(4) ; =0x89cf =35279(-30257),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
831a(57     )      DAO              ; [Disable abort on overflow]
831b(56     )      EAO              ; [Enable abort on overflow]
831c(2A     )      CLAB             ; [Clear AL]
831d(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8320(465730+)      ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8327(463730+)      ZAD   /W88E2(4),/N89D7(8) ; =0x88e2 =35042(-30494),=0x89d7 =35287(-30249) [Zero-add bignum, direct, direct]
832e(46375C+)      M     =10000000,/N89D7(8) ; =0x89d7 =35287(-30249) [Multiply bignums, literal=0x00989680, direct]
8337(467710+)      S     /N89D7(8),/N89CF(8) ; =0x89d7 =35287(-30249),=0x89cf =35279(-30257) [Subtract bignums, direct, direct]
833e(46370C+)      A     =10000000,/N89CF(8) ; =0x89cf =35279(-30257) [Add bignums, literal=0x00989680, direct]
8347(467330+)      ZAD   /N89CF(8),/S88EA(4) ; =0x89cf =35279(-30257),=0x88ea =35050(-30486) [Zero-add bignum, direct, direct]
834e(57     )      DAO              ; [Disable abort on overflow]
834f(56     )      EAO              ; [Enable abort on overflow]
8350(2A     )      CLAB             ; [Clear AL]
8351(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8354(463730+)      ZAD   /S88EA(4),/N89CF(8) ; =0x88ea =35050(-30486),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
835b(46153C+)      ZAD   =10000,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x2710, direct]
8362(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
8365(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
836c(467330+)      ZAD   /N89CF(8),/S88E6(4) ; =0x89cf =35279(-30257),=0x88e6 =35046(-30490) [Zero-add bignum, direct, direct]
8373(57     )      DAO              ; [Disable abort on overflow]
8374(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
8376(8974   )      DW    S8974      ; =0x8974 =35188(-30348) [address of string]
8378(8887   )      DW    L8887      ; =0x8887 =34951(-30585) [address of format]
837a(88E6   )      DW    S88E6      ; =0x88e6 =35046(-30490) [address of argument]
837c(8A43   )      DW    S8A43      ; =0x8a43 =35395(-30141) [address of argument]
837e(88EA   )      DW    S88EA      ; =0x88ea =35050(-30486) [address of argument]
8380(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8382(463023+)      C     /W88E2(4),=0 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x00]
8388(1503   )      BNZ   D838D      ; =+3 [Branch if not zero]
838a(7183B6 )      JMP/  J83B6      ; =0x83b6 =33718(-31818) [Jump direct]
838d(56     )D838D EAO              ; [Enable abort on overflow]
838e(2A     )      CLAB             ; [Clear AL]
838f(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8392(463730+)      ZAD   /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8399(46170C+)      A     =1000,/N89CF(8) ; =0x89cf =35279(-30257) [Add bignums, literal=0x03e8, direct]
83a0(467530+)      ZAD   /N89CF(8),/L89DF(6) ; =0x89cf =35279(-30257),=0x89df =35295(-30241) [Zero-add bignum, direct, direct]
83a7(57     )      DAO              ; [Disable abort on overflow]
83a8(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
83aa(8974   )      DW    S8974      ; =0x8974 =35188(-30348) [address of string]
83ac(887A   )      DW    L887A      ; =0x887a =34938(-30598) [address of format]
83ae(8A45   )      DW    S8A45      ; =0x8a45 =35397(-30139) [address of argument]
83b0(89DF   )      DW    L89DF      ; =0x89df =35295(-30241) [address of argument]
83b2(8A4B   )      DW    S8A4B      ; =0x8a4b =35403(-30133) [address of argument]
83b4(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
*
83b6(718157 )J83B6 JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
83b9(6607   )J83B9 SVC   7          ; =0x07 [Service call WT - unconditional wait]
83bb(81EEEE )      LDAB/ CRT        ; [external symbol] [Load AL direct]
83be(16F9   )      BM    J83B9      ; =-7 [Branch on minus]
83c0(9188D4 )      LDA/  W88D4      ; =0x88d4 =35028(-30508) [Load A direct]
83c3(38     )      INA              ; [Increment A]
83c4(B306   )      STA   W83CC      ; =+6 [Store A relative]
83c6(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
83c8(EEEE   )W83C8 DW    CRT        ; [external symbol] [address of FCB]
83ca(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
83cc(0000   )W83CC DW    X'0000'    ; =0x0000 =0 =NUL,NUL [row address or value]
83ce(479C50+)      FIL   (81)=' ',/@LI ; [external symbol] [Fill with byte, literal=0xa0(160,-96), direct]
83d4(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
83d6(EEEE   )      DW    @LI        ; [external symbol] [address of string]
83d8(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
83da(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of argument]
83dc(89C7   )W83DC DW    W89C7      ; =0x89c7 =35271(-30265) [address of argument]
83de(0000   )W83DE DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
83e0(90EEEE )      LDA=  @LI        ; [external symbol] [Load A with immediate]
83e3(D0A0A0 )      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
83e6(557600+)      XFR=  X'0050',Y  ; =0x0050 =80 [Transfer immediate to Y]
83ea(3160   )D83EA DCR   Y          ; [Decrement Y by 1]
83ec(1606   )      BM    D83F4      ; =+6 [Branch on minus]
83ee(C502   )      LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
83f0(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
83f2(14F6   )      BZ    D83EA      ; =-10 [Branch if zero]
83f4(D0EEEE )D83F4 LDB=  @LI        ; [external symbol] [Load B with immediate]
83f7(59     )      SAB              ; [A - B -> B]
83f8(F1EEEE )      STB/  @LL        ; [external symbol] [Store B direct]
83fb(D3CB   )      LDB   W83C8      ; =-53 [Load B relative]
83fd(90EEEE )      LDA=  @LL        ; [external symbol] [Load A with immediate]
8400(B52806 )      STA+  B,6        ; [Store A indexed, displaced, direct]
8403(6618   )      SVC   24         ; =0x18 [Service call LIOC - logical I/O control]
8405(09     )      RSR              ; [Return from subroutine]
*
* Function F8406
*
8406(7B36   )F8406 JSR   F843E      ; =+54 [Jump to subroutine relative]
8408(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
840a(9188C6 )      LDA/  FTYPE      ; =0x88c6 =35014(-30522) [Load A direct]
840d(1509   )      BNZ   D8418      ; =+9 [Branch if not zero]
840f(9188C8 )      LDA/  W88C8      ; =0x88c8 =35016(-30520) [Load A direct]
8412(D00008 )      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
8415(59     )      SAB              ; [A - B -> B]
8416(1903   )      BLE   D841B      ; =+3 [Branch if less than or equal to zero]
8418(6609   )D8418 SVC   9          ; =0x09 [Service call ABRT - abort task]
841a(79     )      DB    X'79'      ; =0x79 =121 [abort code]
*
841b(7B21   )D841B JSR   F843E      ; =+33 [Jump to subroutine relative]
841d(88CA   )      DW    FLEN       ; =0x88ca =35018(-30518)
*
841f(7B1D   )      JSR   F843E      ; =+29 [Jump to subroutine relative]
8421(88CE   )      DW    FDEC       ; =0x88ce =35022(-30514)
*
8423(7B19   )      JSR   F843E      ; =+25 [Jump to subroutine relative]
8425(88D2   )      DW    FV         ; =0x88d2 =35026(-30510)
*
8427(7B15   )      JSR   F843E      ; =+21 [Jump to subroutine relative]
8429(88D6   )      DW    FH         ; =0x88d6 =35030(-30506)
*
842b(7B11   )      JSR   F843E      ; =+17 [Jump to subroutine relative]
842d(88DA   )      DW    FMIN       ; =0x88da =35034(-30502)
*
842f(7B0D   )      JSR   F843E      ; =+13 [Jump to subroutine relative]
8431(88DE   )      DW    FMAX       ; =0x88de =35038(-30498)
8433(D187D2 )P8433 LDB/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Load B direct]
8436(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8438(F4FA   )      STB*  P8433+1    ; =-6 [Store B relative indirect]
843a(B185A6 )      STA/  W85A5+1    ; =0x85a6 =34214(-31322) [Store A direct]
843d(09     )      RSR              ; [Return from subroutine]
*
* Function F843E
*
843e(9187D2 )F843E LDA/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Load A direct]
8441(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8443(B4FA   )      STA*  F843E+1    ; =-6 [Store A relative indirect]
*
* Function F8445
*
8445(4521   )F8445 XFRB  BU,AL      ; [Transfer BU to AL]
8447(140D   )      BZ    D8456      ; =+13 [Branch if zero]
8449(2B     )      IVAB             ; [Invert AL]
844a(140A   )      BZ    D8456      ; =+10 [Branch if zero]
844c(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
844e(5C     )      XAY              ; [Transfer A to Y]
844f(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8451(B561   )      STA+  Y+         ; [Store A indexed, direct, post-incremented]
8453(99     )      LDA+  B          ; [Load A from address in B]
8454(BB     )      STA+  Y          ; [Store A to address in Y]
8455(09     )      RSR              ; [Return from subroutine]
*
8456(9541   )D8456 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8458(5C     )      XAY              ; [Transfer A to Y]
8459(3A     )      CLA              ; [Clear A]
845a(F56802 )      STB+  Y,2        ; [Store B indexed, displaced, direct]
845d(1701   )      BP    D8460      ; =+1 [Branch on plus]
845f(3B     )      IVA              ; [Invert A]
8460(BB     )D8460 STA+  Y          ; [Store A to address in Y]
8461(09     )      RSR              ; [Return from subroutine]
*
* Function F8462
*
8462(662A   )F8462 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
8464(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8466(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
8468(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
846a(662F   )      SVC   47         ; =0x2F [Service call CB - CPL cursor blanking]
846c(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
846e(004F   )      DW    X'004F'    ; =0x004f =79 [count]
8470(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
8472(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8474(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
8476(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
*
8478(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
847b(8A4D   )      DW    S8A4D      ; =0x8a4d =35405(-30131)
847d(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
847f(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8481(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
8483(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of argument]
8485(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8487(471000+)      CPV   (0)/L8975,/ZERO ; =0x8975 =35189(-30347),[external symbol] [Compare variable-length, direct, direct]
848e(1403   )      BZ    D8493      ; =+3 [Branch if zero]
8490(718496 )      JMP/  J8496      ; =0x8496 =33942(-31594) [Jump direct]
8493(7187ED )D8493 JMP/  J87ED      ; =0x87ed =34797(-30739) =BEL,'m' [Jump direct]
8496(7187D9 )J8496 JMP/  F87D9      ; =0x87d9 =34777(-30759) =BEL,'Y' [Jump direct]
*
* Function F8499
*
8499(7A89E5 )F8499 JSR$  P89E5      ; =0x89e5 =35301(-30235) [Jump to subroutine indirect]
849c(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
849e(00     )      DB    X'00'      ; =0x00 =0 =NUL
849f(0800   )      DW    X'0800'    ; =0x0800 =2048
84a1(000000 )      DB    0,3        ; =0x00,0x0003
84a4(85A9   )      DW    W85A9      ; =0x85a9 =34217(-31319)
84a6(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84a8(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84aa(873E   )      DW    W873E      ; =0x873e =34622(-30914)
84ac(873E   )      DW    W873E      ; =0x873e =34622(-30914)
84ae(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84b0(818975 )      LDAB/ L8975      ; =0x8975 =35189(-30347) [Load AL direct]
84b3(1503   )      BNZ   D84B8      ; =+3 [Branch if not zero]
84b5(7187A9 )D84B5 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
84b8(3A     )D84B8 CLA              ; [Clear A]
84b9(B188FC )      STA/  ?DATA      ; =0x88fc =35068(-30468) [Store A direct]
84bc(B188FE )      STA/  I88FE      ; =0x88fe =35070(-30466) [Store A direct]
84bf(B18900 )      STA/  W8900      ; =0x8900 =35072(-30464) [Store A direct]
84c2(A33E   )      STAB  B8501+1    ; =+62 [Store AL relative]
84c4(B18544 )      STA/  W8541+3    ; =0x8544 =34116(-31420) [Store A direct]
84c7(9188D0 )      LDA/  W88D0      ; =0x88d0 =35024(-30512) [Load A direct]
84ca(A35A   )      STAB  B8525+1    ; =+90 [Store AL relative]
84cc(6627   )D84CC SVC   39         ; =0x27 [Service call CS - CPL string compare]
84ce(8975   )P84CE DW    L8975      ; =0x8975 =35189(-30347) [address of string]
84d0(EEEE   )      DW    ZERO       ; [external symbol] [address of string]
84d2(852E   )      DW    W852E      ; =0x852e =34094(-31442) [TODO: arg3]
84d4(01     )      NOP              ; [No operation]
84d5(84F7   )      LDAB* P84CE      ; =-9 [Load AL relative indirect]
84d7(A188FA )P84D7 STAB/ L88FA      ; =0x88fa =35066(-30470) [Store AL direct]
84da(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
84dc(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
84de(8976   )      DW    S8976      ; =0x8976 =35190(-30346) [address of string]
84e0(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
84e2(84F4   )      LDAB* P84D7+1    ; =-12 [Load AL relative indirect]
84e4(C0AD   )      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
84e6(49     )      SABB             ; [AL - BL -> BL]
84e7(150A   )      BNZ   D84F3      ; =+10 [Branch if not zero]
84e9(3A     )      CLA              ; [Clear A]
84ea(39     )      DCA              ; [Decrement A]
84eb(D357   )D84EB LDB   W8541+3    ; =+87 [Load B relative]
84ed(15C6   )      BNZ   D84B5      ; =-58 [Branch if not zero]
84ef(B353   )      STA   W8541+3    ; =+83 [Store A relative]
84f1(73D9   )D84F1 JMP   D84CC      ; =-39 [Jump relative]
84f3(C0AB   )D84F3 LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
84f5(49     )      SABB             ; [AL - BL -> BL]
84f6(1504   )      BNZ   D84FC      ; =+4 [Branch if not zero]
84f8(3A     )      CLA              ; [Clear A]
84f9(38     )      INA              ; [Increment A]
84fa(73EF   )      JMP   D84EB      ; =-17 [Jump relative]
84fc(C0AE   )D84FC LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
84fe(49     )      SABB             ; [AL - BL -> BL]
84ff(1508   )      BNZ   D8509      ; =+8 [Branch if not zero]
8501(C000   )B8501 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8503(15B0   )D8503 BNZ   D84B5      ; =-80 [Branch if not zero]
8505(A3FB   )      STAB  B8501+1    ; =-5 [Store AL relative]
8507(73C3   )      JMP   D84CC      ; =-61 [Jump relative]
8509(D0B9B0 )D8509 LDB=  X'B9B0'    ; =0xb9b0 =47536(-18000) ='9','0' [Load B with immediate]
850c(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
850e(18F3   )      BGZ   D8503      ; =-13 [Branch if greater than zero]
8510(49     )      SABB             ; [AL - BL -> BL]
8511(16F0   )      BM    D8503      ; =-16 [Branch on minus]
8513(E309   )      STBB  B851B+3    ; =+9 [Store BL relative]
8515(46055C+)      M     =10,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0a, direct]
851b(46050C+)B851B A     =0,/?DATA(6) ; =0x88fc =35068(-30468) [Add bignums, literal=0x00, direct]
8521(83DF   )      LDAB  B8501+1    ; =-33 [Load AL relative]
8523(14CC   )      BZ    D84F1      ; =-52 [Branch if zero]
8525(8000   )B8525 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8527(29     )      DCAB             ; [Decrement AL]
8528(A3FC   )      STAB  B8525+1    ; =-4 [Store AL relative]
852a(17C5   )      BP    D84F1      ; =-59 [Branch on plus]
852c(73D5   )      JMP   D8503      ; =-43 [Jump relative]
852e(83F6   )W852E LDAB  B8525+1    ; =-10 [Load AL relative]
8530(190B   )      BLE   D853D      ; =+11 [Branch if less than or equal to zero]
8532(29     )      DCAB             ; [Decrement AL]
8533(A3F1   )      STAB  B8525+1    ; =-15 [Store AL relative]
8535(46055C+)      M     =10,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0a, direct]
853b(73F1   )      JMP   W852E      ; =-15 [Jump relative]
853d(9305   )D853D LDA   W8541+3    ; =+5 [Load A relative]
853f(1707   )      BP    D8548      ; =+7 [Branch on plus]
8541(46155C+)W8541 M     =257,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0101, direct]
8548(463320+)D8548 C     /FMIN(4),/FMAX(4) ; =0x88da =35034(-30502),=0x88de =35038(-30498) [Compare bignums, direct, direct]
854f(1603   )      BM    D8554      ; =+3 [Branch on minus]
8551(718557 )      JMP/  J8557      ; =0x8557 =34135(-31401) [Jump direct]
8554(71859D )D8554 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8557(56     )J8557 EAO              ; [Enable abort on overflow]
8558(2A     )      CLAB             ; [Clear AL]
8559(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
855c(463730+)      ZAD   /FMIN(4),/N89CF(8) ; =0x88da =35034(-30502),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8563(467530+)      ZAD   /N89CF(8),/L89DF(6) ; =0x89cf =35279(-30257),=0x89df =35295(-30241) [Zero-add bignum, direct, direct]
856a(57     )      DAO              ; [Disable abort on overflow]
856b(465520+)      C     /?DATA(6),/L89DF(6) ; =0x88fc =35068(-30468),=0x89df =35295(-30241) [Compare bignums, direct, direct]
8572(1803   )      BGZ   D8577      ; =+3 [Branch if greater than zero]
8574(71857A )      JMP/  J857A      ; =0x857a =34170(-31366) [Jump direct]
8577(7187A9 )D8577 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
857a(56     )J857A EAO              ; [Enable abort on overflow]
857b(2A     )      CLAB             ; [Clear AL]
857c(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
857f(463730+)      ZAD   /FMAX(4),/N89CF(8) ; =0x88de =35038(-30498),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8586(467530+)      ZAD   /N89CF(8),/L89DF(6) ; =0x89cf =35279(-30257),=0x89df =35295(-30241) [Zero-add bignum, direct, direct]
858d(57     )      DAO              ; [Disable abort on overflow]
858e(465520+)      C     /?DATA(6),/L89DF(6) ; =0x88fc =35068(-30468),=0x89df =35295(-30241) [Compare bignums, direct, direct]
8595(1603   )      BM    D859A      ; =+3 [Branch on minus]
8597(71859D )      JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
859a(7187A9 )D859A JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
859d(7987D9 )J859D JSR/  F87D9      ; =0x87d9 =34777(-30759) =BEL,'Y' [Jump to subroutine direct]
85a0(9304   )      LDA   W85A5+1    ; =+4 [Load A relative]
85a2(1501   )      BNZ   W85A5      ; =+1 [Branch if not zero]
85a4(09     )      RSR              ; [Return from subroutine]
*
85a5(79EEEE )W85A5 JSR/  ZERO       ; [external symbol] [Jump to subroutine direct]
85a8(09     )      DB    X'09'      ; =0x09 =9
*
85a9(9188CC )W85A9 LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
85ac(B188BF )      STA/  W88BF      ; =0x88bf =35007(-30529) [Store A direct]
85af(6632   )      SVC   50         ; =0x32 [Service call DC - CPL decode]
85b1(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
85b3(88BE   )      DW    L88BE      ; =0x88be =35006(-30530) [address of format]
85b5(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
85b7(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
85b9(71859D )      JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
85bc(471000+)W85BC CPV   (0)/L8975,/ZERO ; =0x8975 =35189(-30347),[external symbol] [Compare variable-length, direct, direct]
85c3(1403   )      BZ    D85C8      ; =+3 [Branch if zero]
85c5(7185CB )      JMP/  J85CB      ; =0x85cb =34251(-31285) [Jump direct]
85c8(7187A9 )D85C8 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
85cb(56     )J85CB EAO              ; [Enable abort on overflow]
85cc(2A     )      CLAB             ; [Clear AL]
85cd(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
85d0(46073C+)      ZAD   =0,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x00, direct]
85d6(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
85dd(57     )      DAO              ; [Disable abort on overflow]
85de(471000+)J85DE CPV   (0)/L8975,/ZERO ; =0x8975 =35189(-30347),[external symbol] [Compare variable-length, direct, direct]
85e5(1403   )      BZ    D85EA      ; =+3 [Branch if zero]
85e7(7185ED )      JMP/  J85ED      ; =0x85ed =34285(-31251) [Jump direct]
85ea(718645 )D85EA JMP/  J8645      ; =0x8645 =34373(-31163) [Jump direct]
85ed(6632   )J85ED SVC   50         ; =0x32 [Service call DC - CPL decode]
85ef(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
85f1(886B   )      DW    L886B      ; =0x886b =34923(-30613) [address of format]
85f3(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of argument]
85f5(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of argument]
85f7(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
85f9(471000+)      CPV   (0)/L88FA,/S8A66 ; =0x88fa =35066(-30470),=0x8a66 =35430(-30106) [Compare variable-length, direct, direct]
8600(1803   )      BGZ   D8605      ; =+3 [Branch if greater than zero]
8602(718608 )      JMP/  J8608      ; =0x8608 =34312(-31224) [Jump direct]
8605(7185DE )D8605 JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8608(471000+)J8608 CPV   (0)/L88FA,/S8A68 ; =0x88fa =35066(-30470),=0x8a68 =35432(-30104) [Compare variable-length, direct, direct]
860f(1603   )      BM    D8614      ; =+3 [Branch on minus]
8611(718617 )      JMP/  J8617      ; =0x8617 =34327(-31209) [Jump direct]
8614(7185DE )D8614 JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8617(6632   )J8617 SVC   50         ; =0x32 [Service call DC - CPL decode]
8619(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of string]
861b(8872   )      DW    S8872      ; =0x8872 =34930(-30606) [address of format]
861d(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of argument]
861f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8621(56     )      EAO              ; [Enable abort on overflow]
8622(2A     )      CLAB             ; [Clear AL]
8623(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8626(46073C+)      ZAD   =10,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x0a, direct]
862c(465750+)      M     /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Multiply bignums, direct, direct]
8633(463700+)      A     /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Add bignums, direct, direct]
863a(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8641(57     )      DAO              ; [Disable abort on overflow]
8642(7185DE )      JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8645(56     )J8645 EAO              ; [Enable abort on overflow]
8646(2A     )      CLAB             ; [Clear AL]
8647(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
864a(46073C+)      ZAD   =0,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x00, direct]
8650(467530+)      ZAD   /N89CF(8),/L89DF(6) ; =0x89cf =35279(-30257),=0x89df =35295(-30241) [Zero-add bignum, direct, direct]
8657(57     )      DAO              ; [Disable abort on overflow]
8658(465520+)      C     /?DATA(6),/L89DF(6) ; =0x88fc =35068(-30468),=0x89df =35295(-30241) [Compare bignums, direct, direct]
865f(1403   )      BZ    D8664      ; =+3 [Branch if zero]
8661(718667 )      JMP/  J8667      ; =0x8667 =34407(-31129) [Jump direct]
8664(71859D )D8664 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8667(463023+)J8667 C     /FTYPE(4),=8 ; =0x88c6 =35014(-30522), [Compare bignums, direct, literal=0x08]
866d(1403   )      BZ    D8672      ; =+3 [Branch if zero]
866f(718675 )      JMP/  J8675      ; =0x8675 =34421(-31115) [Jump direct]
8672(718707 )D8672 JMP/  J8707      ; =0x8707 =34567(-30969) [Jump direct]
8675(56     )J8675 EAO              ; [Enable abort on overflow]
8676(2A     )      CLAB             ; [Clear AL]
8677(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
867a(465730+)      ZAD   /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
8681(46153C+)      ZAD   =10000,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x2710, direct]
8688(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
868b(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
8692(467330+)      ZAD   /N89CF(8),/W88E2(4) ; =0x89cf =35279(-30257),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8699(57     )      DAO              ; [Disable abort on overflow]
869a(463023+)      C     /W88E2(4),=1 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x01]
86a0(1803   )      BGZ   D86A5      ; =+3 [Branch if greater than zero]
86a2(7186A8 )      JMP/  J86A8      ; =0x86a8 =34472(-31064) [Jump direct]
86a5(7187A9 )D86A5 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86a8(463023+)J86A8 C     /W88E2(4),=12 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x0c]
86ae(1603   )      BM    D86B3      ; =+3 [Branch on minus]
86b0(7186B6 )      JMP/  J86B6      ; =0x86b6 =34486(-31050) [Jump direct]
86b3(7187A9 )D86B3 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86b6(56     )J86B6 EAO              ; [Enable abort on overflow]
86b7(2A     )      CLAB             ; [Clear AL]
86b8(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
86bb(463730+)      ZAD   /W88E2(4),/N89CF(8) ; =0x88e2 =35042(-30494),=0x89cf =35279(-30257) [Zero-add bignum, direct, direct]
86c2(46175C+)      M     =-10000,/N89CF(8) ; =0x89cf =35279(-30257) [Multiply bignums, literal=0xd8f0, direct]
86c9(465700+)      A     /?DATA(6),/N89CF(8) ; =0x88fc =35068(-30468),=0x89cf =35279(-30257) [Add bignums, direct, direct]
86d0(46053C+)      ZAD   =100,/N89F3(6) ; =0x89f3 =35315(-30221) [Zero-add bignum, literal=0x64, direct]
86d6(9089EB )      LDA=  W89EB      ; =0x89eb =35307(-30229) [Load A with immediate]
86d9(465770+)      DRM   /N89F3(6),/N89CF(8) ; =0x89f3 =35315(-30221),=0x89cf =35279(-30257) [Divide bignums with remainder, direct, direct]
86e0(467330+)      ZAD   /N89CF(8),/W88E2(4) ; =0x89cf =35279(-30257),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
86e7(57     )      DAO              ; [Disable abort on overflow]
86e8(463023+)      C     /W88E2(4),=1 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x01]
86ee(1803   )      BGZ   D86F3      ; =+3 [Branch if greater than zero]
86f0(7186F6 )      JMP/  J86F6      ; =0x86f6 =34550(-30986) [Jump direct]
86f3(7187A9 )D86F3 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86f6(463023+)J86F6 C     /W88E2(4),=31 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x1f]
86fc(1603   )      BM    D8701      ; =+3 [Branch on minus]
86fe(718704 )      JMP/  J8704      ; =0x8704 =34564(-30972) [Jump direct]
8701(7187A9 )D8701 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
8704(71859D )J8704 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8707(465423+)J8707 C     /?DATA(6),=9999999999 ; =0x88fc =35068(-30468), [Compare bignums, direct, literal=0x02540be3ff]
8711(1603   )      BM    D8716      ; =+3 [Branch on minus]
8713(718719 )      JMP/  J8719      ; =0x8719 =34585(-30951) [Jump direct]
8716(7187A9 )D8716 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
8719(56     )J8719 EAO              ; [Enable abort on overflow]
871a(2A     )      CLAB             ; [Clear AL]
871b(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
871e(46073C+)      ZAD   =0,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x00, direct]
8724(467530+)      ZAD   /N89CF(8),/L89DF(6) ; =0x89cf =35279(-30257),=0x89df =35295(-30241) [Zero-add bignum, direct, direct]
872b(57     )      DAO              ; [Disable abort on overflow]
872c(465520+)      C     /?DATA(6),/L89DF(6) ; =0x88fc =35068(-30468),=0x89df =35295(-30241) [Compare bignums, direct, direct]
8733(1803   )      BGZ   D8738      ; =+3 [Branch if greater than zero]
8735(71873B )      JMP/  J873B      ; =0x873b =34619(-30917) [Jump direct]
8738(7187A9 )D8738 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
873b(71859D )J873B JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
873e(471000+)W873E CPV   (0)/L8975,/S8A74 ; =0x8975 =35189(-30347),=0x8a74 =35444(-30092) [Compare variable-length, direct, direct]
8745(1403   )      BZ    D874A      ; =+3 [Branch if zero]
8747(71874D )      JMP/  J874D      ; =0x874d =34637(-30899) [Jump direct]
874a(71875C )D874A JMP/  J875C      ; =0x875c =34652(-30884) [Jump direct]
874d(471000+)J874D CPV   (0)/L8975,/S8A76 ; =0x8975 =35189(-30347),=0x8a76 =35446(-30090) [Compare variable-length, direct, direct]
8754(1503   )      BNZ   D8759      ; =+3 [Branch if not zero]
8756(71875C )      JMP/  J875C      ; =0x875c =34652(-30884) [Jump direct]
8759(7187A9 )D8759 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
875c(6632   )J875C SVC   50         ; =0x32 [Service call DC - CPL decode]
875e(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
8760(8876   )      DW    L8876      ; =0x8876 =34934(-30602) [address of format]
8762(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
8764(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8766(463023+)      C     /FTYPE(4),=6 ; =0x88c6 =35014(-30522), [Compare bignums, direct, literal=0x06]
876c(1403   )      BZ    D8771      ; =+3 [Branch if zero]
876e(718774 )      JMP/  J8774      ; =0x8774 =34676(-30860) [Jump direct]
8771(71859D )D8771 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8774(56     )J8774 EAO              ; [Enable abort on overflow]
8775(2A     )      CLAB             ; [Clear AL]
8776(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8779(46073C+)      ZAD   =0,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x00, direct]
877f(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8786(57     )      DAO              ; [Disable abort on overflow]
8787(471000+)      CPV   (0)/L8975,/S8A74 ; =0x8975 =35189(-30347),=0x8a74 =35444(-30092) [Compare variable-length, direct, direct]
878e(1403   )      BZ    D8793      ; =+3 [Branch if zero]
8790(7187A6 )      JMP/  J87A6      ; =0x87a6 =34726(-30810) =BEL,'&' [Jump direct]
8793(56     )D8793 EAO              ; [Enable abort on overflow]
8794(2A     )      CLAB             ; [Clear AL]
8795(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8798(46073C+)      ZAD   =1,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x01, direct]
879e(467530+)      ZAD   /N89CF(8),/?DATA(6) ; =0x89cf =35279(-30257),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
87a5(57     )      DAO              ; [Disable abort on overflow]
87a6(71859D )J87A6 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
87a9(7187ED )J87A9 JMP/  J87ED      ; =0x87ed =34797(-30739) =BEL,'m' [Jump direct]
*
* Function F87AC
*
87ac(900000 )F87AC LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
87af(5C     )      XAY              ; [Transfer A to Y]
87b0(9561   )D87B0 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
87b2(1439   )      BZ    J87ED      ; =+57 [Branch if zero]
87b4(D188C4 )      LDB/  W88C4      ; =0x88c4 =35012(-30524) [Load B direct]
87b7(59     )      SAB              ; [A - B -> B]
87b8(1407   )      BZ    D87C1      ; =+7 [Branch if zero]
87ba(900012 )      LDA=  X'0012'    ; =0x0012 =18 [Load A with immediate]
87bd(5006   )      ADD   A,Y        ; [A + Y -> Y]
87bf(73EF   )      JMP   D87B0      ; =-17 [Jump relative]
87c1(9561   )D87C1 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
87c3(B18109 )      STA/  P8106+3    ; =0x8109 =33033(-32503) [Store A direct]
87c6(B1811E )      STA/  W811B+3    ; =0x811e =33054(-32482) [Store A direct]
87c9(B1812E )      STA/  W812B+3    ; =0x812e =33070(-32466) [Store A direct]
87cc(B1813A )      STA/  W8139+1    ; =0x813a =33082(-32454) [Store A direct]
87cf(5560   )      XFR   Y,A        ; [Transfer Y to A]
87d1(B00000 )W87D1 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
87d4(3103   )      DCR   A,4        ; [Decrement A by 4]
87d6(B00000 )      STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
*
* Function F87D9
*
87d9(56     )F87D9 EAO              ; [Enable abort on overflow]
87da(2A     )      CLAB             ; [Clear AL]
87db(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
87de(46073C+)      ZAD   =0,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x00, direct]
87e4(467330+)      ZAD   /N89CF(8),/XSTAT(4) ; =0x89cf =35279(-30257),=0x88ee =35054(-30482) [Zero-add bignum, direct, direct]
87eb(57     )      DAO              ; [Disable abort on overflow]
87ec(09     )      RSR              ; [Return from subroutine]
*
87ed(56     )J87ED EAO              ; [Enable abort on overflow]
87ee(2A     )      CLAB             ; [Clear AL]
87ef(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
87f2(46073C+)      ZAD   =1,/N89CF(8) ; =0x89cf =35279(-30257) [Zero-add bignum, literal=0x01, direct]
87f8(467330+)      ZAD   /N89CF(8),/XSTAT(4) ; =0x89cf =35279(-30257),=0x88ee =35054(-30482) [Zero-add bignum, direct, direct]
87ff(57     )      DAO              ; [Disable abort on overflow]
8800(09     )      RSR              ; [Return from subroutine]
*
* Function F8801
*
8801(3A     )F8801 CLA              ; [Clear A]
8802(B188C2 )      STA/  FIELD      ; =0x88c2 =35010(-30526) [Store A direct]
8805(B188C4 )P8805 STA/  W88C4      ; =0x88c4 =35012(-30524) [Store A direct]
8808(7B4A   )D8808 JSR   F8854      ; =+74 [Jump to subroutine relative]
880a(D0B9B0 )      LDB=  X'B9B0'    ; =0xb9b0 =47536(-18000) ='9','0' [Load B with immediate]
880d(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
880f(1814   )      BGZ   D8825      ; =+20 [Branch if greater than zero]
8811(49     )      SABB             ; [AL - BL -> BL]
8812(1611   )      BM    D8825      ; =+17 [Branch on minus]
8814(E5A2   )      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
8816(94EE   )      LDA*  P8805+1    ; =-18 [Load A relative indirect]
8818(3D     )      SLA              ; [Left shift A]
8819(5D     )      XAB              ; [Transfer A to B]
881a(3501   )      SLR   A,2        ; [Left shift A by 2]
881c(58     )      AAB              ; [A + B -> B]
881d(3A     )      CLA              ; [Clear A]
881e(85A1   )      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8820(58     )      AAB              ; [A + B -> B]
8821(F4E3   )      STB*  P8805+1    ; =-29 [Store B relative indirect]
8823(73E3   )      JMP   D8808      ; =-29 [Jump relative]
8825(C0AC   )D8825 LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8827(49     )      SABB             ; [AL - BL -> BL]
8828(1424   )      BZ    W884E      ; =+36 [Branch if zero]
882a(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
882c(49     )      SABB             ; [AL - BL -> BL]
882d(150D   )      BNZ   D883C      ; =+13 [Branch if not zero]
882f(6627   )      SVC   39         ; =0x27 [Service call CS - CPL string compare]
8831(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
8833(EEEE   )      DW    ZERO       ; [external symbol] [address of string]
8835(884E   )      DW    W884E      ; =0x884e =34894(-30642) [TODO: arg3]
8837(01     )      NOP              ; [No operation]
8838(7B1A   )      JSR   F8854      ; =+26 [Jump to subroutine relative]
883a(73E9   )      JMP   D8825      ; =-23 [Jump relative]
883c(6629   )D883C SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
883e(EEEE   )      DW    @LI        ; [external symbol] [address of string]
8840(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of string]
8842(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
8844(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8846(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
8848(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
884a(EEEE   )      DW    @LI        ; [external symbol] [address of string]
884c(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
884e(9374   )W884E LDA   W88C4      ; =+116 [Load A relative]
8850(149B   )      BZ    J87ED      ; =-101 [Branch if zero]
8852(7385   )      JMP   F87D9      ; =-123 [Jump relative]
*
* Function F8854
*
8854(6632   )F8854 SVC   50         ; =0x32 [Service call DC - CPL decode]
8856(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of string]
8858(886B   )      DW    L886B      ; =0x886b =34923(-30613) [address of format]
885a(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of argument]
885c(8975   )      DW    L8975      ; =0x8975 =35189(-30347) [address of argument]
885e(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8860(8188FA )      LDAB/ L88FA      ; =0x88fa =35066(-30470) [Load AL direct]
8863(09     )      RSR              ; [Return from subroutine]
*
8864(0200   )L8864 DW    X'0200'    ; =0x0200 =512
8866(5002   )      DW    X'5002'    ; =0x5002 =20482
8868(00     )      DB    X'00'      ; =0x00 =0 =NUL
8869(0100   )      DW    X'0100'    ; =0x0100 =256
886b(0200   )L886B DW    X'0200'    ; =0x0200 =512
886d(0102   )      DW    X'0102'    ; =0x0102 =258
886f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8870(5000   )      DW    X'5000'    ; =0x5000 =20480
8872(F9     )S8872 DC    'y'        ; hex:f9 dec:249(-7)
8873(00     )      DB    X'00'      ; =0x00 =0 =NUL
8874(0100   )      DW    X'0100'    ; =0x0100 =256
8876(0200   )L8876 DW    X'0200'    ; =0x0200 =512
8878(0100   )      DW    X'0100'    ; =0x0100 =256
887a(01     )L887A DB    X'01'      ; =0x01 =1
887b(0000   )W887B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
887d(0200   )      DW    X'0200'    ; =0x0200 =512
887f(01     )      DB    X'01'      ; =0x01 =1
8880(F8     )      DC    'x'        ; hex:f8 dec:248(-8)
8881(00     )      DB    X'00'      ; =0x00 =0 =NUL
8882(0302   )      DW    X'0302'    ; =0x0302 =770
8884(00     )      DB    X'00'      ; =0x00 =0 =NUL
8885(0100   )      DW    X'0100'    ; =0x0100 =256
8887(01     )L8887 DB    X'01'      ; =0x01 =1
8888(0000   )W8888 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
888a(0100   )      DW    X'0100'    ; =0x0100 =256
888c(05     )      DB    X'05'      ; =0x05 =5
888d(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
888e(00     )      DB    X'00'      ; =0x00 =0 =NUL
888f(0302   )      DW    X'0302'    ; =0x0302 =770
8891(00     )      DB    X'00'      ; =0x00 =0 =NUL
8892(01     )      DB    X'01'      ; =0x01 =1
8893(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
8894(00     )      DB    X'00'      ; =0x00 =0 =NUL
8895(0400   )      DW    X'0400'    ; =0x0400 =1024
8897(01     )L8897 DB    X'01'      ; =0x01 =1
8898(0000   )W8898 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
889a(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
889b(00     )      DB    X'00'      ; =0x00 =0 =NUL
889c(0202   )      DW    X'0202'    ; =0x0202 =514
889e(00     )      DB    X'00'      ; =0x00 =0 =NUL
889f(01     )      DB    X'01'      ; =0x01 =1
88a0(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
88a1(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a2(0202   )      DW    X'0202'    ; =0x0202 =514
88a4(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a5(01     )      DB    X'01'      ; =0x01 =1
88a6(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
88a7(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a8(0200   )      DW    X'0200'    ; =0x0200 =512
88aa(01     )L88AA DB    X'01'      ; =0x01 =1
88ab(0000   )W88AB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ad(F8     )S88AD DC    'x'        ; hex:f8 dec:248(-8)
88ae(0063   )W88AE DW    X'0063'    ; =0x0063 =99
88b0(0200   )      DW    X'0200'    ; =0x0200 =512
88b2(0100   )      DW    X'0100'    ; =0x0100 =256
88b4(01     )L88B4 DB    X'01'      ; =0x01 =1
88b5(0000   )W88B5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88b7(02     )      DB    X'02'      ; =0x02 =2
88b8(0050   )W88B8 DW    X'0050'    ; =0x0050 =80
88ba(0200   )      DW    X'0200'    ; =0x0200 =512
88bc(0100   )      DW    X'0100'    ; =0x0100 =256
88be(02     )L88BE DB    X'02'      ; =0x02 =2
88bf(0050   )W88BF DW    X'0050'    ; =0x0050 =80
88c1(00     )      DB    X'00'      ; =0x00 =0 =NUL
88c2(0000   )FIELD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c4(0000   )W88C4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c6(0000   )FTYPE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c8(0000   )W88C8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ca(0000   )FLEN  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88cc(0000   )W88CC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ce(0000   )FDEC  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d0(0000   )W88D0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d2(0000   )FV    DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d4(00     )W88D4 DB    X'00'      ; =0x00 =0 =NUL
88d5(00     )N88D5 DB    X'00'      ; =0x00 =0 =NUL
88d6(0000   )FH    DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d8(0000   )W88D8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88da(000000+)FMIN  DB    0,4        ; =0x00,0x0004
88de(000000+)FMAX  DB    0,4        ; =0x00,0x0004
88e2(0000   )W88E2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e4(0000   )W88E4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e6(000000+)S88E6 DB    0,4        ; =0x00,0x0004
88ea(000000+)S88EA DB    0,4        ; =0x00,0x0004
88ee(000000+)XSTAT DB    0,4        ; =0x00,0x0004
88f2(0000   )FSCR  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f4(0000   )W88F4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f6(0000   )W88F6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f8(0000   )W88F8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88fa(       )L88FA DS    1          ; =0x0001 [Uninitialized memory]
88fb(00     )      DB    X'00'      ; =0x00 =0 =NUL
88fc(       )?DATA DS    2          ; =0x0002 [Uninitialized memory]
88fe(       )I88FE DS    2          ; =0x0002 [Uninitialized memory]
8900(       )W8900 DS    76         ; =0x004c [Uninitialized memory]
894c(00     )      DB    X'00'      ; =0x00 =0 =NUL
894d(000F   )L894D DW    X'000F'    ; =0x000f =15
894f(000000+)      DB    0,9        ; =0x00,0x0009
8958(0202   )      DW    X'0202'    ; =0x0202 =514
895a(0300   )      DW    X'0300'    ; =0x0300 =768
895c(000000+)      DB    0,11       ; =0x00,0x000b
8967(88F6   )      DW    W88F6      ; =0x88f6 =35062(-30474)
8969(0057   )      DW    X'0057'    ; =0x0057 =87
896b(0057   )L896B DW    X'0057'    ; =0x0057 =87
896d(0057   )      DW    X'0057'    ; =0x0057 =87
896f(       )      DS    5          ; =0x0005 [Uninitialized memory]
8974(00     )S8974 DB    X'00'      ; =0x00 =0 =NUL
8975(       )L8975 DS    1          ; =0x0001 [Uninitialized memory]
8976(       )S8976 DS    79         ; =0x004f [Uninitialized memory]
89c5(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
89c7(8200   )W89C7 DW    X'8200'    ; =0x8200 =33280(-32256)
89c9(8C00   )L89C9 DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
89cb(8700   )      DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
89cd(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
89cf(       )N89CF DS    8          ; =0x0008 [Uninitialized memory]
89d7(       )N89D7 DS    8          ; =0x0008 [Uninitialized memory]
89df(       )L89DF DS    6          ; =0x0006 [Uninitialized memory]
89e5(EEEE   )P89E5 DW    CSD03      ; [external symbol]
89e7(       )      DS    4          ; =0x0004 [Uninitialized memory]
89eb(       )W89EB DS    8          ; =0x0008 [Uninitialized memory]
89f3(       )N89F3 DS    6          ; =0x0006 [Uninitialized memory]
89f9(87     )W89F9 DB    X'87'      ; =0x87 =135(-121) =BEL
89fa(C9CED6+)      DC    'INVALID FIELD#!'
8a09(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a0a(87     )W8A0A DB    X'87'      ; =0x87 =135(-121) =BEL
8a0b(C9CED6+)      DC    'INVALID DATA!'
8a18(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a19(87     )W8A19 DB    X'87'      ; =0x87 =135(-121) =BEL
8a1a(A0C8C9+)      DC    ' HIT NEW LINE TO CONTINUE.'
8a34(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a35(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a36(0F42   )      DW    X'0F42'    ; =0x0f42 =3906
8a38(4000   )      DW    X'4000'    ; =0x4000 =16384
8a3a(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a3b(2710   )      DW    X'2710'    ; =0x2710 =10000
8a3d(AF     )S8A3D DC    '/'        ; hex:af dec:175(-81)
8a3e(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a3f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a40(9896   )      DW    X'9896'    ; =0x9896 =39062(-26474)
8a42(80     )      DB    X'80'      ; =0x80 =128(-128)
8a43(AD     )S8A43 DC    '-'        ; hex:ad dec:173(-83)
8a44(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a45(A8     )S8A45 DC    '('        ; hex:a8 dec:168(-88)
8a46(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a47(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8a49(03     )      DB    X'03'      ; =0x03 =3
8a4a(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8a4b(A9     )S8A4B DC    ')'        ; hex:a9 dec:169(-87)
8a4c(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a4d(C5CED4+)S8A4D DC    'ENTER FIELD#,DATA OR CR:'
8a65(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a66(B0     )S8A66 DC    '0'        ; hex:b0 dec:176(-80)
8a67(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a68(B9     )S8A68 DC    '9'        ; hex:b9 dec:185(-71)
8a69(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a6a(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1)
8a6c(D8F0   )      DC    'Xp'       ; hex:d8f0 dec:55536(-16)
8a6e(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a6f(0254   )      DW    X'0254'    ; =0x0254 =596
8a71(0B     )      DB    X'0B'      ; =0x0b =11
8a72(E3     )      DC    'c'        ; hex:e3 dec:227(-29)
8a73(FF     )      DB    X'FF'      ; =0xff =255(-1)
8a74(D9     )S8A74 DC    'Y'        ; hex:d9 dec:217(-39)
8a75(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a76(CE     )S8A76 DC    'N'        ; hex:ce dec:206(-50)
8a77(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a78:ENDPT


***Address 0x87D7 for variable ADLST not defined.
 TITLE 'BSCREE'
BSCREE BEGIN 0
*
 ENT SCREDT
ADLST EQU X'87D7'
 ENT ADLST
 ENT FIELD
 ENT FTYPE
 ENT FLEN
 ENT FDEC
 ENT FV
 ENT FH
 ENT FMIN
 ENT FMAX
 ENT XSTAT
 ENT FSCR
 ENT ?DATA
*
 EXT ZERO
 EXT CRT
 EXT MSGN
 EXT @IF
 EXT @LI
 EXT @LL
 EXT CSD03
*
*
* Function BSCREE
*
8000(9541   )BSCREE LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8004(150D   )      BNZ   D8013      ; =+13 [Branch if not zero]
8006(479003+)      FIL   (4)/ZERO,/FSCR ; [external symbol],=0x88f2 =35058(-30478) [Fill with byte, direct, direct]
800d(B188F4 )      STA/  W88F4      ; =0x88f4 =35060(-30476) [Store A direct]
8010(718019 )      JMP/  J8019      ; =0x8019 =32793(-32743) [Jump direct]
8013(463338+)D8013 ZAD   -A(4),/FSCR(4) ; =0x88f2 =35058(-30478) [Zero-add bignum, indexed, direct]
8019(9541   )J8019 LDA+  X+         ; [Load A indexed, direct, post-incremented]
801b(B18152 )      STA/  W8151+1    ; =0x8152 =33106(-32430) [Store A direct]
801e(8000   )W801E LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8020(150A   )      BNZ   D802C      ; =+10 [Branch if not zero]
8022(301080+)      INC/  W801E      ; =0x801e =32798(-32738) [Increment word at address by 1]
8026(6639   )      SVC   57         ; =0x39 [Service call OP - CPL open]
8028(01     )      DB    X'01'      ; =0x01 =1 [Mode: input]
8029(894D   )      DW    L894D      ; =0x894d =35149(-30387) [address of FCB]
802b(00     )      DB    X'00'      ; =0x00 =0 =NUL [argument list terminator]
*
802c(321083+)D802C CAD/  W83DC      ; [Clear word at address]
8030(474C01+)      MVF   (2)=X'0101',/W83DE ; =0x83de =33758(-31778) [Move fixed-length, literal=257, direct]
8037(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
8039(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
803b(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
803d(8B5C   )      DW    L8B5C      ; =0x8b5c =35676(-29860) [address of argument]
803f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8041(3A     )      CLA              ; [Clear A]
8042(B188D2 )      STA/  FV         ; =0x88d2 =35026(-30510) [Store A direct]
8045(B188D4 )      STA/  W88D4      ; =0x88d4 =35028(-30508) [Store A direct]
8048(79813D )D8048 JSR/  F813D      ; =0x813d =33085(-32451) [Jump to subroutine direct]
804b(301088+)      INC/  W88D4      ; =0x88d4 =35028(-30508) [Increment word at address by 1]
804f(46002C+)      C     =21,/N88D5(1) ; =0x88d5 =35029(-30507) [Compare bignums, literal=0x15, direct]
8055(19F1   )      BLE   D8048      ; =-15 [Branch if less than or equal to zero]
8057(09     )      RSR              ; [Return from subroutine]
*
* Function SCREDT
*
8058(908B5A )SCREDT LDA=  L8B5A      ; =0x8b5a =35674(-29862) [Load A with immediate]
805b(B183DC )      STA/  W83DC      ; =0x83dc =33756(-31780) [Store A direct]
805e(321083+)      CAD/  W83DE      ; [Clear word at address]
8062(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8064(B187AD )      STA/  F87AC+1    ; =0x87ad =34733(-30803) =BEL,'-' [Store A direct]
8067(B18152 )      STA/  W8151+1    ; =0x8152 =33106(-32430) [Store A direct]
806a(798462 )J806A JSR/  F8462      ; =0x8462 =33890(-31646) [Jump to subroutine direct]
806d(463023+)      C     /XSTAT(4),=0 ; =0x88ee =35054(-30482), [Compare bignums, direct, literal=0x00]
8073(1503   )      BNZ   D8078      ; =+3 [Branch if not zero]
8075(718079 )      JMP/  J8079      ; =0x8079 =32889(-32647) [Jump direct]
8078(09     )D8078 RSR              ; [Return from subroutine]
*
8079(798801 )J8079 JSR/  F8801      ; =0x8801 =34817(-30719) [Jump to subroutine direct]
807c(7A8B78 )      JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
807f(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
8081(0001   )      DW    X'0001'    ; =0x0001 =1
8083(80A9   )      DW    W80A9      ; =0x80a9 =32937(-32599)
*
8085(7987AC )      JSR/  F87AC      ; =0x87ac =34732(-30804) =BEL,',' [Jump to subroutine direct]
8088(7A8B78 )      JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
808b(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
808d(0001   )      DW    X'0001'    ; =0x0001 =1
808f(80A9   )      DW    W80A9      ; =0x80a9 =32937(-32599)
8091(798406 )      JSR/  F8406      ; =0x8406 =33798(-31738) [Jump to subroutine direct]
8094(798499 )      JSR/  F8499      ; =0x8499 =33945(-31591) [Jump to subroutine direct]
8097(7A8B78 )      JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
809a(88EE   )      DW    XSTAT      ; =0x88ee =35054(-30482)
809c(0001   )      DW    X'0001'    ; =0x0001 =1
809e(80B9   )      DW    W80B9      ; =0x80b9 =32953(-32583)
*
80a0(7980E4 )      JSR/  F80E4      ; =0x80e4 =32996(-32540) [Jump to subroutine direct]
80a3(79813D )      JSR/  F813D      ; =0x813d =33085(-32451) [Jump to subroutine direct]
80a6(71806A )      JMP/  J806A      ; =0x806a =32874(-32662) [Jump direct]
80a9(662A   )W80A9 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80ab(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80ad(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
80af(0018   )      DW    X'0018'    ; =0x0018 =24 [row address or value]
*
80b1(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80b4(8B8C   )      DW    W8B8C      ; =0x8b8c =35724(-29812) =VT,FF
80b6(7180C6 )      JMP/  J80C6      ; =0x80c6 =32966(-32570) [Jump direct]
80b9(662A   )W80B9 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80bb(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80bd(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
80bf(0018   )      DW    X'0018'    ; =0x0018 =24 [row address or value]
*
80c1(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80c4(8B9D   )      DW    W8B9D      ; =0x8b9d =35741(-29795)
*
80c6(79EEEE )J80C6 JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
80c9(8BAC   )      DW    W8BAC      ; =0x8bac =35756(-29780) =VT,','
80cb(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
80cd(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80cf(004F   )      DW    X'004F'    ; =0x004f =79 [column address or value]
80d1(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
80d3(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
80d5(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80d7(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
80d9(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
80db(662F   )      SVC   47         ; =0x2F [Service call CB - CPL cursor blanking]
80dd(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
80df(004F   )      DW    X'004F'    ; =0x004f =79 [count]
80e1(71806A )      JMP/  J806A      ; =0x806a =32874(-32662) [Jump direct]
*
* Function F80E4
*
80e4(7A8B78 )F80E4 JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
80e7(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
80e9(0008   )      DW    X'0008'    ; =0x0008 =8
80eb(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80ed(8116   )      DW    W8116      ; =0x8116 =33046(-32490)
80ef(812B   )      DW    W812B      ; =0x812b =33067(-32469)
80f1(8134   )      DW    W8134      ; =0x8134 =33076(-32460)
80f3(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80f5(812B   )      DW    W812B      ; =0x812b =33067(-32469)
80f7(8101   )      DW    W8101      ; =0x8101 =33025(-32511)
80f9(8116   )      DW    W8116      ; =0x8116 =33046(-32490)
80fb(918900 )      LDA/  W8900      ; =0x8900 =35072(-30464) [Load A direct]
80fe(B409   )      STA*  P8106+3    ; =+9 [Store A relative indirect]
8100(09     )      RSR              ; [Return from subroutine]
*
8101(56     )W8101 EAO              ; [Enable abort on overflow]
8102(2A     )      CLAB             ; [Clear AL]
8103(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8106(465730+)P8106 ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
810d(467330+)      ZAD   /N8B62(8),/ZERO(4) ; =0x8b62 =35682(-29854),[external symbol] [Zero-add bignum, direct, direct]
8114(57     )      DAO              ; [Disable abort on overflow]
8115(09     )      RSR              ; [Return from subroutine]
*
8116(56     )W8116 EAO              ; [Enable abort on overflow]
8117(2A     )      CLAB             ; [Clear AL]
8118(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
811b(465730+)W811B ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8122(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8129(57     )      DAO              ; [Disable abort on overflow]
812a(09     )      RSR              ; [Return from subroutine]
*
812b(472083+)W812B MVV   (132,0)/?DATA,/ZERO ; =0x88fc =35068(-30468),[external symbol] [Move variable-length, direct, direct]
8133(09     )      RSR              ; [Return from subroutine]
*
8134(6605   )W8134 SVC   5          ; =0x05 [Service call TS - load transient module]
8136(0B     )      DB    X'0B'      ; =0x0b =11 [Selector: integer date from GRIN date]
8137(88FE   )      DW    I88FE      ; =0x88fe =35070(-30466) [address of date]
8139(B1EEEE )W8139 STA/  ZERO       ; [external symbol] [Store A direct]
813c(09     )      RSR              ; [Return from subroutine]
*
* Function F813D
*
813d(D188F4 )F813D LDB/  W88F4      ; =0x88f4 =35060(-30476) [Load B direct]
8140(773200+)      MUL=  X'0016',B  ; =0x0016 =22 [22 * B -> B]
8144(502388+)      ADD/  W88D4,B    ; =0x88d4 =35028(-30508) [*Direct + B -> B]
8148(F188F8 )      STB/  W88F8      ; =0x88f8 =35064(-30472) [Store B direct]
814b(6637   )      SVC   55         ; =0x37 [Service call RB - CPL binary read]
814d(894D   )      DW    L894D      ; =0x894d =35149(-30387) [address of FCB]
814f(8AFE   )      DW    L8AFE      ; =0x8afe =35582(-29954) =LF,'~' [address of record]
8151(900000 )W8151 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
8154(B187D2 )P8154 STA/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Store A direct]
8157(94FC   )J8157 LDA*  P8154+1    ; =-4 [Load A relative indirect]
8159(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
815b(1503   )      BNZ   D8160      ; =+3 [Branch if not zero]
815d(7183B9 )      JMP/  J83B9      ; =0x83b9 =33721(-31815) [Jump direct]
8160(B4F3   )D8160 STA*  P8154+1    ; =-13 [Store A relative indirect]
8162(D50808 )      LDB+  A,8        ; [Load B indexed, displaced, direct]
8165(798445 )      JSR/  F8445      ; =0x8445 =33861(-31675) [Jump to subroutine direct]
8168(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494)
816a(9188E4 )      LDA/  W88E4      ; =0x88e4 =35044(-30492) [Load A direct]
816d(D188D4 )      LDB/  W88D4      ; =0x88d4 =35028(-30508) [Load B direct]
8170(59     )      SAB              ; [A - B -> B]
8171(140A   )      BZ    D817D      ; =+10 [Branch if zero]
8173(D00012 )      LDB=  X'0012'    ; =0x0012 =18 [Load B with immediate]
8176(94DD   )      LDA*  P8154+1    ; =-35 [Load A relative indirect]
8178(58     )      AAB              ; [A + B -> B]
8179(F4DA   )      STB*  P8154+1    ; =-38 [Store B relative indirect]
817b(73DA   )      JMP   J8157      ; =-38 [Jump relative]
817d(94D6   )D817D LDA*  P8154+1    ; =-42 [Load A relative indirect]
817f(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8181(B4D2   )      STA*  P8154+1    ; =-46 [Store A relative indirect]
8183(F34E   )      STB   W81D2+1    ; =+78 [Store B relative]
8185(F18220 )      STB/  W821F+1    ; =0x8220 =33312(-32224) [Store B direct]
8188(F18227 )      STB/  W8226+1    ; =0x8227 =33319(-32217) [Store B direct]
818b(F18238 )      STB/  W8237+1    ; =0x8238 =33336(-32200) [Store B direct]
818e(F182E3 )      STB/  W82E2+1    ; =0x82e3 =33507(-32029) [Store B direct]
8191(798406 )      JSR/  F8406      ; =0x8406 =33798(-31738) [Jump to subroutine direct]
8194(9188D8 )      LDA/  W88D8      ; =0x88d8 =35032(-30504) [Load A direct]
8197(38     )      INA              ; [Increment A]
8198(B1887B )      STA/  W887B      ; =0x887b =34939(-30597) [Store A direct]
819b(B18888 )      STA/  W8888      ; =0x8888 =34952(-30584) [Store A direct]
819e(B18898 )      STA/  W8898      ; =0x8898 =34968(-30568) [Store A direct]
81a1(B188B5 )      STA/  W88B5      ; =0x88b5 =34997(-30539) [Store A direct]
81a4(B188AB )      STA/  W88AB      ; =0x88ab =34987(-30549) [Store A direct]
81a7(9188CC )      LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
81aa(B188B8 )      STA/  W88B8      ; =0x88b8 =35000(-30536) [Store A direct]
81ad(B188AE )      STA/  W88AE      ; =0x88ae =34990(-30546) [Store A direct]
81b0(7A8B78 )      JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
81b3(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
81b5(0008   )      DW    X'0008'    ; =0x0008 =8
81b7(81D2   )      DW    W81D2      ; =0x81d2 =33234(-32302)
81b9(81DE   )      DW    W81DE      ; =0x81de =33246(-32290)
81bb(8219   )      DW    W8219      ; =0x8219 =33305(-32231)
81bd(8226   )      DW    W8226      ; =0x8226 =33318(-32218)
81bf(8235   )      DW    W8235      ; =0x8235 =33333(-32203)
81c1(82C3   )      DW    W82C3      ; =0x82c3 =33475(-32061)
81c3(82C7   )      DW    W82C7      ; =0x82c7 =33479(-32057)
81c5(82E0   )      DW    W82E0      ; =0x82e0 =33504(-32032)
81c7(930A   )      LDA   W81D2+1    ; =+10 [Load A relative]
81c9(5C     )      XAY              ; [Transfer A to Y]
81ca(3A     )      CLA              ; [Clear A]
81cb(DB     )      LDB+  Y          ; [Load B from address in Y]
81cc(1701   )      BP    D81CF      ; =+1 [Branch on plus]
81ce(3B     )      IVA              ; [Invert A]
81cf(5D     )D81CF XAB              ; [Transfer A to B]
81d0(7313   )      JMP   D81E5      ; =+19 [Jump relative]
81d2(900000 )W81D2 LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
81d5(5C     )      XAY              ; [Transfer A to Y]
81d6(3A     )      CLA              ; [Clear A]
81d7(D561   )      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
81d9(1701   )      BP    D81DC      ; =+1 [Branch on plus]
81db(3B     )      IVA              ; [Invert A]
81dc(7307   )D81DC JMP   D81E5      ; =+7 [Jump relative]
81de(93F3   )W81DE LDA   W81D2+1    ; =-13 [Load A relative]
81e0(5C     )      XAY              ; [Transfer A to Y]
81e1(9561   )      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
81e3(D561   )      LDB+  Y+         ; [Load B indexed, direct, post-incremented]
81e5(B188FC )D81E5 STA/  ?DATA      ; =0x88fc =35068(-30468) [Store A direct]
81e8(F188FE )      STB/  I88FE      ; =0x88fe =35070(-30466) [Store B direct]
81eb(9B     )      LDA+  Y          ; [Load A from address in Y]
81ec(B18900 )      STA/  W8900      ; =0x8900 =35072(-30464) [Store A direct]
81ef(9188CC )      LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
81f2(5D     )      XAB              ; [Transfer A to B]
81f3(2111   )      DCRB  AL,2       ; [Decrement AL by 2]
81f5(1606   )      BM    D81FD      ; =+6 [Branch on minus]
81f7(9188D0 )      LDA/  W88D0      ; =0x88d0 =35024(-30512) [Load A direct]
81fa(59     )      SAB              ; [A - B -> B]
81fb(1603   )      BM    D8200      ; =+3 [Branch on minus]
81fd(718418 )D81FD JMP/  D8418      ; =0x8418 =33816(-31720) [Jump direct]
8200(C0FA   )D8200 LDBB= X'FA'      ; =250(-6) ='z' [Load BL with immediate]
8202(2513   )      SLRB  AL,4       ; [Left shift AL by 4]
8204(1402   )      BZ    D8208      ; =+2 [Branch if zero]
8206(C00A   )      LDBB= X'0A'      ; =10 [Load BL with immediate]
8208(48     )D8208 AABB             ; [AL + BL -> BL]
8209(E188AD )      STBB/ S88AD      ; =0x88ad =34989(-30547) [Store BL direct]
820c(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
820e(8B07   )      DW    S8B07      ; =0x8b07 =35591(-29945) [address of string]
8210(88AA   )      DW    L88AA      ; =0x88aa =34986(-30550) [address of format]
8212(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
8214(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8216(718157 )      JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
8219(6633   )W8219 SVC   51         ; =0x33 [Service call NC - CPL encode]
821b(8B07   )      DW    S8B07      ; =0x8b07 =35591(-29945) [address of string]
821d(88B4   )      DW    L88B4      ; =0x88b4 =34996(-30540) [address of format]
821f(EEEE   )W821F DW    ZERO       ; [external symbol] [address of argument]
8221(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8223(718157 )      JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
8226(91EEEE )W8226 LDA/  ZERO       ; [external symbol] [Load A direct]
8229(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
822b(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
822d(0A     )      DB    X'0A'      ; =0x0a =10 [Selector: integer date]
822e(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of integer date]
8230(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8232(718249 )      JMP/  J8249      ; =0x8249 =33353(-32183) [Jump direct]
8235(56     )W8235 EAO              ; [Enable abort on overflow]
8236(2A     )      CLAB             ; [Clear AL]
8237(A1EEEE )W8237 STAB/ @IF        ; [external symbol] [Store AL direct]
823a(463730+)      ZAD   /ZERO(4),/N8B62(8) ; [external symbol],=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8241(467330+)      ZAD   /N8B62(8),/W88E2(4) ; =0x8b62 =35682(-29854),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8248(57     )      DAO              ; [Disable abort on overflow]
8249(56     )J8249 EAO              ; [Enable abort on overflow]
824a(2A     )      CLAB             ; [Clear AL]
824b(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
824e(463730+)      ZAD   /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8255(46270C+)      A     =1000000,/N8B62(8) ; =0x8b62 =35682(-29854) [Add bignums, literal=0x0f4240, direct]
825d(467330+)      ZAD   /N8B62(8),/W88E2(4) ; =0x8b62 =35682(-29854),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8264(57     )      DAO              ; [Disable abort on overflow]
8265(56     )      EAO              ; [Enable abort on overflow]
8266(2A     )      CLAB             ; [Clear AL]
8267(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
826a(463730+)      ZAD   /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8271(46153C+)      ZAD   =10000,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x2710, direct]
8278(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
827b(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
8282(467330+)      ZAD   /N8B62(8),/S88E6(4) ; =0x8b62 =35682(-29854),=0x88e6 =35046(-30490) [Zero-add bignum, direct, direct]
8289(57     )      DAO              ; [Disable abort on overflow]
828a(56     )      EAO              ; [Enable abort on overflow]
828b(2A     )      CLAB             ; [Clear AL]
828c(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
828f(463730+)      ZAD   /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8296(46053C+)      ZAD   =100,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x64, direct]
829c(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
829f(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
82a6(467330+)      ZAD   /N8B62(8),/S88EA(4) ; =0x8b62 =35682(-29854),=0x88ea =35050(-30486) [Zero-add bignum, direct, direct]
82ad(57     )      DAO              ; [Disable abort on overflow]
82ae(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
82b0(8B07   )      DW    S8B07      ; =0x8b07 =35591(-29945) [address of string]
82b2(8897   )      DW    L8897      ; =0x8897 =34967(-30569) [address of format]
82b4(88E6   )      DW    S88E6      ; =0x88e6 =35046(-30490) [address of argument]
82b6(8BD0   )      DW    S8BD0      ; =0x8bd0 =35792(-29744) =VT,'P' [address of argument]
82b8(88EA   )      DW    S88EA      ; =0x88ea =35050(-30486) [address of argument]
82ba(8BD0   )      DW    S8BD0      ; =0x8bd0 =35792(-29744) =VT,'P' [address of argument]
82bc(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of argument]
82be(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
*
82c0(718157 )D82C0 JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
82c3(841E   )W82C3 LDAB* W82E2+1    ; =+30 [Load AL relative indirect]
82c5(730B   )      JMP   D82D2      ; =+11 [Jump relative]
82c7(80CE   )W82C7 LDAB= X'CE'      ; =206(-50) ='N' [Load AL with immediate]
82c9(D318   )      LDB   W82E2+1    ; =+24 [Load B relative]
82cb(D52802 )      LDB+  B,2        ; [Load B indexed, displaced, direct]
82ce(1402   )      BZ    D82D2      ; =+2 [Branch if zero]
82d0(80D9   )      LDAB= X'D9'      ; =217(-39) ='Y' [Load AL with immediate]
82d2(A5A2   )D82D2 STAB- S-         ; [Store AL indexed, pre-decremented, direct]
82d4(9188D8 )      LDA/  W88D8      ; =0x88d8 =35032(-30504) [Load A direct]
82d7(D08B08 )      LDB=  L8B08      ; =0x8b08 =35592(-29944) [Load B with immediate]
82da(58     )      AAB              ; [A + B -> B]
82db(85A1   )      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
82dd(A9     )      STAB+ B          ; [Store AL to address in B]
82de(73E0   )      JMP   D82C0      ; =-32 [Jump relative]
82e0(56     )W82E0 EAO              ; [Enable abort on overflow]
82e1(2A     )      CLAB             ; [Clear AL]
82e2(A1EEEE )W82E2 STAB/ @IF        ; [external symbol] [Store AL direct]
82e5(465730+)      ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
82ec(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
82f3(57     )      DAO              ; [Disable abort on overflow]
82f4(56     )      EAO              ; [Enable abort on overflow]
82f5(2A     )      CLAB             ; [Clear AL]
82f6(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
82f9(465730+)      ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8300(46353C+)      ZAD   =10000000,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x00989680, direct]
8309(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
830c(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
8313(467330+)      ZAD   /N8B62(8),/W88E2(4) ; =0x8b62 =35682(-29854),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
831a(57     )      DAO              ; [Disable abort on overflow]
831b(56     )      EAO              ; [Enable abort on overflow]
831c(2A     )      CLAB             ; [Clear AL]
831d(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8320(465730+)      ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8327(463730+)      ZAD   /W88E2(4),/N8B6A(8) ; =0x88e2 =35042(-30494),=0x8b6a =35690(-29846) [Zero-add bignum, direct, direct]
832e(46375C+)      M     =10000000,/N8B6A(8) ; =0x8b6a =35690(-29846) [Multiply bignums, literal=0x00989680, direct]
8337(467710+)      S     /N8B6A(8),/N8B62(8) ; =0x8b6a =35690(-29846),=0x8b62 =35682(-29854) [Subtract bignums, direct, direct]
833e(46370C+)      A     =10000000,/N8B62(8) ; =0x8b62 =35682(-29854) [Add bignums, literal=0x00989680, direct]
8347(467330+)      ZAD   /N8B62(8),/S88EA(4) ; =0x8b62 =35682(-29854),=0x88ea =35050(-30486) [Zero-add bignum, direct, direct]
834e(57     )      DAO              ; [Disable abort on overflow]
834f(56     )      EAO              ; [Enable abort on overflow]
8350(2A     )      CLAB             ; [Clear AL]
8351(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8354(463730+)      ZAD   /S88EA(4),/N8B62(8) ; =0x88ea =35050(-30486),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
835b(46153C+)      ZAD   =10000,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x2710, direct]
8362(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
8365(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
836c(467330+)      ZAD   /N8B62(8),/S88E6(4) ; =0x8b62 =35682(-29854),=0x88e6 =35046(-30490) [Zero-add bignum, direct, direct]
8373(57     )      DAO              ; [Disable abort on overflow]
8374(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
8376(8B07   )      DW    S8B07      ; =0x8b07 =35591(-29945) [address of string]
8378(8887   )      DW    L8887      ; =0x8887 =34951(-30585) [address of format]
837a(88E6   )      DW    S88E6      ; =0x88e6 =35046(-30490) [address of argument]
837c(8BD6   )      DW    S8BD6      ; =0x8bd6 =35798(-29738) =VT,'V' [address of argument]
837e(88EA   )      DW    S88EA      ; =0x88ea =35050(-30486) [address of argument]
8380(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8382(463023+)      C     /W88E2(4),=0 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x00]
8388(1503   )      BNZ   D838D      ; =+3 [Branch if not zero]
838a(7183B6 )      JMP/  J83B6      ; =0x83b6 =33718(-31818) [Jump direct]
838d(56     )D838D EAO              ; [Enable abort on overflow]
838e(2A     )      CLAB             ; [Clear AL]
838f(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8392(463730+)      ZAD   /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8399(46170C+)      A     =1000,/N8B62(8) ; =0x8b62 =35682(-29854) [Add bignums, literal=0x03e8, direct]
83a0(467530+)      ZAD   /N8B62(8),/L8B72(6) ; =0x8b62 =35682(-29854),=0x8b72 =35698(-29838) [Zero-add bignum, direct, direct]
83a7(57     )      DAO              ; [Disable abort on overflow]
83a8(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
83aa(8B07   )      DW    S8B07      ; =0x8b07 =35591(-29945) [address of string]
83ac(887A   )      DW    L887A      ; =0x887a =34938(-30598) [address of format]
83ae(8BD8   )      DW    S8BD8      ; =0x8bd8 =35800(-29736) =VT,'X' [address of argument]
83b0(8B72   )      DW    L8B72      ; =0x8b72 =35698(-29838) [address of argument]
83b2(8BDE   )      DW    S8BDE      ; =0x8bde =35806(-29730) =VT,'^' [address of argument]
83b4(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
*
83b6(718157 )J83B6 JMP/  J8157      ; =0x8157 =33111(-32425) [Jump direct]
83b9(6607   )J83B9 SVC   7          ; =0x07 [Service call WT - unconditional wait]
83bb(81EEEE )      LDAB/ CRT        ; [external symbol] [Load AL direct]
83be(16F9   )      BM    J83B9      ; =-7 [Branch on minus]
83c0(9188D4 )      LDA/  W88D4      ; =0x88d4 =35028(-30508) [Load A direct]
83c3(38     )      INA              ; [Increment A]
83c4(B306   )      STA   W83CC      ; =+6 [Store A relative]
83c6(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
83c8(EEEE   )W83C8 DW    CRT        ; [external symbol] [address of FCB]
83ca(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
83cc(0000   )W83CC DW    X'0000'    ; =0x0000 =0 =NUL,NUL [row address or value]
83ce(479C50+)      FIL   (81)=' ',/@LI ; [external symbol] [Fill with byte, literal=0xa0(160,-96), direct]
83d4(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
83d6(EEEE   )      DW    @LI        ; [external symbol] [address of string]
83d8(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
83da(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of argument]
83dc(8B5A   )W83DC DW    L8B5A      ; =0x8b5a =35674(-29862) [address of argument]
83de(0000   )W83DE DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
83e0(90EEEE )      LDA=  @LI        ; [external symbol] [Load A with immediate]
83e3(D0A0A0 )      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
83e6(557600+)      XFR=  X'0050',Y  ; =0x0050 =80 [Transfer immediate to Y]
83ea(3160   )D83EA DCR   Y          ; [Decrement Y by 1]
83ec(1606   )      BM    D83F4      ; =+6 [Branch on minus]
83ee(C502   )      LDBB- A-         ; [Load BL indexed, pre-decremented, direct]
83f0(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
83f2(14F6   )      BZ    D83EA      ; =-10 [Branch if zero]
83f4(D0EEEE )D83F4 LDB=  @LI        ; [external symbol] [Load B with immediate]
83f7(59     )      SAB              ; [A - B -> B]
83f8(F1EEEE )      STB/  @LL        ; [external symbol] [Store B direct]
83fb(D3CB   )      LDB   W83C8      ; =-53 [Load B relative]
83fd(90EEEE )      LDA=  @LL        ; [external symbol] [Load A with immediate]
8400(B52806 )      STA+  B,6        ; [Store A indexed, displaced, direct]
8403(6618   )      SVC   24         ; =0x18 [Service call LIOC - logical I/O control]
8405(09     )      RSR              ; [Return from subroutine]
*
* Function F8406
*
8406(7B36   )F8406 JSR   F843E      ; =+54 [Jump to subroutine relative]
8408(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
840a(9188C6 )      LDA/  FTYPE      ; =0x88c6 =35014(-30522) [Load A direct]
840d(1509   )      BNZ   D8418      ; =+9 [Branch if not zero]
840f(9188C8 )      LDA/  W88C8      ; =0x88c8 =35016(-30520) [Load A direct]
8412(D00008 )      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
8415(59     )      SAB              ; [A - B -> B]
8416(1903   )      BLE   D841B      ; =+3 [Branch if less than or equal to zero]
8418(6609   )D8418 SVC   9          ; =0x09 [Service call ABRT - abort task]
841a(79     )      DB    X'79'      ; =0x79 =121 [abort code]
*
841b(7B21   )D841B JSR   F843E      ; =+33 [Jump to subroutine relative]
841d(88CA   )      DW    FLEN       ; =0x88ca =35018(-30518)
*
841f(7B1D   )      JSR   F843E      ; =+29 [Jump to subroutine relative]
8421(88CE   )      DW    FDEC       ; =0x88ce =35022(-30514)
*
8423(7B19   )      JSR   F843E      ; =+25 [Jump to subroutine relative]
8425(88D2   )      DW    FV         ; =0x88d2 =35026(-30510)
*
8427(7B15   )      JSR   F843E      ; =+21 [Jump to subroutine relative]
8429(88D6   )      DW    FH         ; =0x88d6 =35030(-30506)
*
842b(7B11   )      JSR   F843E      ; =+17 [Jump to subroutine relative]
842d(88DA   )      DW    FMIN       ; =0x88da =35034(-30502)
*
842f(7B0D   )      JSR   F843E      ; =+13 [Jump to subroutine relative]
8431(88DE   )      DW    FMAX       ; =0x88de =35038(-30498)
8433(D187D2 )P8433 LDB/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Load B direct]
8436(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8438(F4FA   )      STB*  P8433+1    ; =-6 [Store B relative indirect]
843a(B185A6 )      STA/  W85A5+1    ; =0x85a6 =34214(-31322) [Store A direct]
843d(09     )      RSR              ; [Return from subroutine]
*
* Function F843E
*
843e(9187D2 )F843E LDA/  W87D1+1    ; =0x87d2 =34770(-30766) =BEL,'R' [Load A direct]
8441(D501   )      LDB+  A+         ; [Load B indexed, direct, post-incremented]
8443(B4FA   )      STA*  F843E+1    ; =-6 [Store A relative indirect]
*
* Function F8445
*
8445(4521   )F8445 XFRB  BU,AL      ; [Transfer BU to AL]
8447(140D   )      BZ    D8456      ; =+13 [Branch if zero]
8449(2B     )      IVAB             ; [Invert AL]
844a(140A   )      BZ    D8456      ; =+10 [Branch if zero]
844c(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
844e(5C     )      XAY              ; [Transfer A to Y]
844f(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
8451(B561   )      STA+  Y+         ; [Store A indexed, direct, post-incremented]
8453(99     )      LDA+  B          ; [Load A from address in B]
8454(BB     )      STA+  Y          ; [Store A to address in Y]
8455(09     )      RSR              ; [Return from subroutine]
*
8456(9541   )D8456 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8458(5C     )      XAY              ; [Transfer A to Y]
8459(3A     )      CLA              ; [Clear A]
845a(F56802 )      STB+  Y,2        ; [Store B indexed, displaced, direct]
845d(1701   )      BP    D8460      ; =+1 [Branch on plus]
845f(3B     )      IVA              ; [Invert A]
8460(BB     )D8460 STA+  Y          ; [Store A to address in Y]
8461(09     )      RSR              ; [Return from subroutine]
*
* Function F8462
*
8462(662A   )F8462 SVC   42         ; =0x2A [Service call CP - CPL cursor position]
8464(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8466(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
8468(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
846a(662F   )      SVC   47         ; =0x2F [Service call CB - CPL cursor blanking]
846c(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
846e(004F   )      DW    X'004F'    ; =0x004f =79 [count]
8470(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
8472(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8474(0001   )      DW    X'0001'    ; =0x0001 =1 [column address or value]
8476(0017   )      DW    X'0017'    ; =0x0017 =23 [row address or value]
*
8478(79EEEE )      JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
847b(8BE0   )      DW    S8BE0      ; =0x8be0 =35808(-29728) =VT,'`'
847d(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
847f(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
8481(8864   )      DW    L8864      ; =0x8864 =34916(-30620) [address of format]
8483(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of argument]
8485(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8487(471000+)      CPV   (0)/L8B08,/ZERO ; =0x8b08 =35592(-29944),[external symbol] [Compare variable-length, direct, direct]
848e(1403   )      BZ    D8493      ; =+3 [Branch if zero]
8490(718496 )      JMP/  J8496      ; =0x8496 =33942(-31594) [Jump direct]
8493(7187ED )D8493 JMP/  J87ED      ; =0x87ed =34797(-30739) =BEL,'m' [Jump direct]
8496(7187D9 )J8496 JMP/  F87D9      ; =0x87d9 =34777(-30759) =BEL,'Y' [Jump direct]
*
* Function F8499
*
8499(7A8B78 )F8499 JSR$  P8B78      ; =0x8b78 =35704(-29832) [Jump to subroutine indirect]
849c(88C6   )      DW    FTYPE      ; =0x88c6 =35014(-30522)
849e(00     )      DB    X'00'      ; =0x00 =0 =NUL
849f(0800   )      DW    X'0800'    ; =0x0800 =2048
84a1(000000 )      DB    0,3        ; =0x00,0x0003
84a4(85A9   )      DW    W85A9      ; =0x85a9 =34217(-31319)
84a6(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84a8(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84aa(873E   )      DW    W873E      ; =0x873e =34622(-30914)
84ac(873E   )      DW    W873E      ; =0x873e =34622(-30914)
84ae(85BC   )      DW    W85BC      ; =0x85bc =34236(-31300)
84b0(818B08 )      LDAB/ L8B08      ; =0x8b08 =35592(-29944) [Load AL direct]
84b3(1503   )      BNZ   D84B8      ; =+3 [Branch if not zero]
84b5(7187A9 )D84B5 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
84b8(3A     )D84B8 CLA              ; [Clear A]
84b9(B188FC )      STA/  ?DATA      ; =0x88fc =35068(-30468) [Store A direct]
84bc(B188FE )      STA/  I88FE      ; =0x88fe =35070(-30466) [Store A direct]
84bf(B18900 )      STA/  W8900      ; =0x8900 =35072(-30464) [Store A direct]
84c2(A33E   )      STAB  B8501+1    ; =+62 [Store AL relative]
84c4(B18544 )      STA/  W8541+3    ; =0x8544 =34116(-31420) [Store A direct]
84c7(9188D0 )      LDA/  W88D0      ; =0x88d0 =35024(-30512) [Load A direct]
84ca(A35A   )      STAB  B8525+1    ; =+90 [Store AL relative]
84cc(6627   )D84CC SVC   39         ; =0x27 [Service call CS - CPL string compare]
84ce(8B08   )P84CE DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
84d0(EEEE   )      DW    ZERO       ; [external symbol] [address of string]
84d2(852E   )      DW    W852E      ; =0x852e =34094(-31442) [TODO: arg3]
84d4(01     )      NOP              ; [No operation]
84d5(84F7   )      LDAB* P84CE      ; =-9 [Load AL relative indirect]
84d7(A188FA )P84D7 STAB/ L88FA      ; =0x88fa =35066(-30470) [Store AL direct]
84da(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
84dc(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
84de(8B09   )      DW    S8B09      ; =0x8b09 =35593(-29943) [address of string]
84e0(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
84e2(84F4   )      LDAB* P84D7+1    ; =-12 [Load AL relative indirect]
84e4(C0AD   )      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
84e6(49     )      SABB             ; [AL - BL -> BL]
84e7(150A   )      BNZ   D84F3      ; =+10 [Branch if not zero]
84e9(3A     )      CLA              ; [Clear A]
84ea(39     )      DCA              ; [Decrement A]
84eb(D357   )D84EB LDB   W8541+3    ; =+87 [Load B relative]
84ed(15C6   )      BNZ   D84B5      ; =-58 [Branch if not zero]
84ef(B353   )      STA   W8541+3    ; =+83 [Store A relative]
84f1(73D9   )D84F1 JMP   D84CC      ; =-39 [Jump relative]
84f3(C0AB   )D84F3 LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
84f5(49     )      SABB             ; [AL - BL -> BL]
84f6(1504   )      BNZ   D84FC      ; =+4 [Branch if not zero]
84f8(3A     )      CLA              ; [Clear A]
84f9(38     )      INA              ; [Increment A]
84fa(73EF   )      JMP   D84EB      ; =-17 [Jump relative]
84fc(C0AE   )D84FC LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
84fe(49     )      SABB             ; [AL - BL -> BL]
84ff(1508   )      BNZ   D8509      ; =+8 [Branch if not zero]
8501(C000   )B8501 LDBB= X'00'      ; =0 =NUL [Load BL with immediate]
8503(15B0   )D8503 BNZ   D84B5      ; =-80 [Branch if not zero]
8505(A3FB   )      STAB  B8501+1    ; =-5 [Store AL relative]
8507(73C3   )      JMP   D84CC      ; =-61 [Jump relative]
8509(D0B9B0 )D8509 LDB=  X'B9B0'    ; =0xb9b0 =47536(-18000) ='9','0' [Load B with immediate]
850c(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
850e(18F3   )      BGZ   D8503      ; =-13 [Branch if greater than zero]
8510(49     )      SABB             ; [AL - BL -> BL]
8511(16F0   )      BM    D8503      ; =-16 [Branch on minus]
8513(E309   )      STBB  B851B+3    ; =+9 [Store BL relative]
8515(46055C+)      M     =10,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0a, direct]
851b(46050C+)B851B A     =0,/?DATA(6) ; =0x88fc =35068(-30468) [Add bignums, literal=0x00, direct]
8521(83DF   )      LDAB  B8501+1    ; =-33 [Load AL relative]
8523(14CC   )      BZ    D84F1      ; =-52 [Branch if zero]
8525(8000   )B8525 LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
8527(29     )      DCAB             ; [Decrement AL]
8528(A3FC   )      STAB  B8525+1    ; =-4 [Store AL relative]
852a(17C5   )      BP    D84F1      ; =-59 [Branch on plus]
852c(73D5   )      JMP   D8503      ; =-43 [Jump relative]
852e(83F6   )W852E LDAB  B8525+1    ; =-10 [Load AL relative]
8530(190B   )      BLE   D853D      ; =+11 [Branch if less than or equal to zero]
8532(29     )      DCAB             ; [Decrement AL]
8533(A3F1   )      STAB  B8525+1    ; =-15 [Store AL relative]
8535(46055C+)      M     =10,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0a, direct]
853b(73F1   )      JMP   W852E      ; =-15 [Jump relative]
853d(9305   )D853D LDA   W8541+3    ; =+5 [Load A relative]
853f(1707   )      BP    D8548      ; =+7 [Branch on plus]
8541(46155C+)W8541 M     =257,/?DATA(6) ; =0x88fc =35068(-30468) [Multiply bignums, literal=0x0101, direct]
8548(463320+)D8548 C     /FMIN(4),/FMAX(4) ; =0x88da =35034(-30502),=0x88de =35038(-30498) [Compare bignums, direct, direct]
854f(1603   )      BM    D8554      ; =+3 [Branch on minus]
8551(718557 )      JMP/  J8557      ; =0x8557 =34135(-31401) [Jump direct]
8554(71859D )D8554 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8557(56     )J8557 EAO              ; [Enable abort on overflow]
8558(2A     )      CLAB             ; [Clear AL]
8559(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
855c(463730+)      ZAD   /FMIN(4),/N8B62(8) ; =0x88da =35034(-30502),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8563(467530+)      ZAD   /N8B62(8),/L8B72(6) ; =0x8b62 =35682(-29854),=0x8b72 =35698(-29838) [Zero-add bignum, direct, direct]
856a(57     )      DAO              ; [Disable abort on overflow]
856b(465520+)      C     /?DATA(6),/L8B72(6) ; =0x88fc =35068(-30468),=0x8b72 =35698(-29838) [Compare bignums, direct, direct]
8572(1803   )      BGZ   D8577      ; =+3 [Branch if greater than zero]
8574(71857A )      JMP/  J857A      ; =0x857a =34170(-31366) [Jump direct]
8577(7187A9 )D8577 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
857a(56     )J857A EAO              ; [Enable abort on overflow]
857b(2A     )      CLAB             ; [Clear AL]
857c(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
857f(463730+)      ZAD   /FMAX(4),/N8B62(8) ; =0x88de =35038(-30498),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8586(467530+)      ZAD   /N8B62(8),/L8B72(6) ; =0x8b62 =35682(-29854),=0x8b72 =35698(-29838) [Zero-add bignum, direct, direct]
858d(57     )      DAO              ; [Disable abort on overflow]
858e(465520+)      C     /?DATA(6),/L8B72(6) ; =0x88fc =35068(-30468),=0x8b72 =35698(-29838) [Compare bignums, direct, direct]
8595(1603   )      BM    D859A      ; =+3 [Branch on minus]
8597(71859D )      JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
859a(7187A9 )D859A JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
859d(7987D9 )J859D JSR/  F87D9      ; =0x87d9 =34777(-30759) =BEL,'Y' [Jump to subroutine direct]
85a0(9304   )      LDA   W85A5+1    ; =+4 [Load A relative]
85a2(1501   )      BNZ   W85A5      ; =+1 [Branch if not zero]
85a4(09     )      RSR              ; [Return from subroutine]
*
85a5(79EEEE )W85A5 JSR/  ZERO       ; [external symbol] [Jump to subroutine direct]
85a8(09     )      DB    X'09'      ; =0x09 =9
*
85a9(9188CC )W85A9 LDA/  W88CC      ; =0x88cc =35020(-30516) [Load A direct]
85ac(B188BF )      STA/  W88BF      ; =0x88bf =35007(-30529) [Store A direct]
85af(6632   )      SVC   50         ; =0x32 [Service call DC - CPL decode]
85b1(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
85b3(88BE   )      DW    L88BE      ; =0x88be =35006(-30530) [address of format]
85b5(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
85b7(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
85b9(71859D )      JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
85bc(471000+)W85BC CPV   (0)/L8B08,/ZERO ; =0x8b08 =35592(-29944),[external symbol] [Compare variable-length, direct, direct]
85c3(1403   )      BZ    D85C8      ; =+3 [Branch if zero]
85c5(7185CB )      JMP/  J85CB      ; =0x85cb =34251(-31285) [Jump direct]
85c8(7187A9 )D85C8 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
85cb(56     )J85CB EAO              ; [Enable abort on overflow]
85cc(2A     )      CLAB             ; [Clear AL]
85cd(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
85d0(46073C+)      ZAD   =0,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x00, direct]
85d6(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
85dd(57     )      DAO              ; [Disable abort on overflow]
85de(471000+)J85DE CPV   (0)/L8B08,/ZERO ; =0x8b08 =35592(-29944),[external symbol] [Compare variable-length, direct, direct]
85e5(1403   )      BZ    D85EA      ; =+3 [Branch if zero]
85e7(7185ED )      JMP/  J85ED      ; =0x85ed =34285(-31251) [Jump direct]
85ea(718645 )D85EA JMP/  J8645      ; =0x8645 =34373(-31163) [Jump direct]
85ed(6632   )J85ED SVC   50         ; =0x32 [Service call DC - CPL decode]
85ef(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
85f1(886B   )      DW    L886B      ; =0x886b =34923(-30613) [address of format]
85f3(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of argument]
85f5(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of argument]
85f7(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
85f9(471000+)      CPV   (0)/L88FA,/S8BF9 ; =0x88fa =35066(-30470),=0x8bf9 =35833(-29703) =VT,'y' [Compare variable-length, direct, direct]
8600(1803   )      BGZ   D8605      ; =+3 [Branch if greater than zero]
8602(718608 )      JMP/  J8608      ; =0x8608 =34312(-31224) [Jump direct]
8605(7185DE )D8605 JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8608(471000+)J8608 CPV   (0)/L88FA,/S8BFB ; =0x88fa =35066(-30470),=0x8bfb =35835(-29701) =VT,'{' [Compare variable-length, direct, direct]
860f(1603   )      BM    D8614      ; =+3 [Branch on minus]
8611(718617 )      JMP/  J8617      ; =0x8617 =34327(-31209) [Jump direct]
8614(7185DE )D8614 JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8617(6632   )J8617 SVC   50         ; =0x32 [Service call DC - CPL decode]
8619(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of string]
861b(8872   )      DW    S8872      ; =0x8872 =34930(-30606) [address of format]
861d(88E2   )      DW    W88E2      ; =0x88e2 =35042(-30494) [address of argument]
861f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8621(56     )      EAO              ; [Enable abort on overflow]
8622(2A     )      CLAB             ; [Clear AL]
8623(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8626(46073C+)      ZAD   =10,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x0a, direct]
862c(465750+)      M     /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Multiply bignums, direct, direct]
8633(463700+)      A     /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Add bignums, direct, direct]
863a(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8641(57     )      DAO              ; [Disable abort on overflow]
8642(7185DE )      JMP/  J85DE      ; =0x85de =34270(-31266) [Jump direct]
8645(56     )J8645 EAO              ; [Enable abort on overflow]
8646(2A     )      CLAB             ; [Clear AL]
8647(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
864a(46073C+)      ZAD   =0,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x00, direct]
8650(467530+)      ZAD   /N8B62(8),/L8B72(6) ; =0x8b62 =35682(-29854),=0x8b72 =35698(-29838) [Zero-add bignum, direct, direct]
8657(57     )      DAO              ; [Disable abort on overflow]
8658(465520+)      C     /?DATA(6),/L8B72(6) ; =0x88fc =35068(-30468),=0x8b72 =35698(-29838) [Compare bignums, direct, direct]
865f(1403   )      BZ    D8664      ; =+3 [Branch if zero]
8661(718667 )      JMP/  J8667      ; =0x8667 =34407(-31129) [Jump direct]
8664(71859D )D8664 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8667(463023+)J8667 C     /FTYPE(4),=8 ; =0x88c6 =35014(-30522), [Compare bignums, direct, literal=0x08]
866d(1403   )      BZ    D8672      ; =+3 [Branch if zero]
866f(718675 )      JMP/  J8675      ; =0x8675 =34421(-31115) [Jump direct]
8672(718707 )D8672 JMP/  J8707      ; =0x8707 =34567(-30969) [Jump direct]
8675(56     )J8675 EAO              ; [Enable abort on overflow]
8676(2A     )      CLAB             ; [Clear AL]
8677(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
867a(465730+)      ZAD   /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
8681(46153C+)      ZAD   =10000,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x2710, direct]
8688(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
868b(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
8692(467330+)      ZAD   /N8B62(8),/W88E2(4) ; =0x8b62 =35682(-29854),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
8699(57     )      DAO              ; [Disable abort on overflow]
869a(463023+)      C     /W88E2(4),=1 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x01]
86a0(1803   )      BGZ   D86A5      ; =+3 [Branch if greater than zero]
86a2(7186A8 )      JMP/  J86A8      ; =0x86a8 =34472(-31064) [Jump direct]
86a5(7187A9 )D86A5 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86a8(463023+)J86A8 C     /W88E2(4),=12 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x0c]
86ae(1603   )      BM    D86B3      ; =+3 [Branch on minus]
86b0(7186B6 )      JMP/  J86B6      ; =0x86b6 =34486(-31050) [Jump direct]
86b3(7187A9 )D86B3 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86b6(56     )J86B6 EAO              ; [Enable abort on overflow]
86b7(2A     )      CLAB             ; [Clear AL]
86b8(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
86bb(463730+)      ZAD   /W88E2(4),/N8B62(8) ; =0x88e2 =35042(-30494),=0x8b62 =35682(-29854) [Zero-add bignum, direct, direct]
86c2(46175C+)      M     =-10000,/N8B62(8) ; =0x8b62 =35682(-29854) [Multiply bignums, literal=0xd8f0, direct]
86c9(465700+)      A     /?DATA(6),/N8B62(8) ; =0x88fc =35068(-30468),=0x8b62 =35682(-29854) [Add bignums, direct, direct]
86d0(46053C+)      ZAD   =100,/N8B86(6) ; =0x8b86 =35718(-29818) [Zero-add bignum, literal=0x64, direct]
86d6(908B7E )      LDA=  W8B7E      ; =0x8b7e =35710(-29826) [Load A with immediate]
86d9(465770+)      DRM   /N8B86(6),/N8B62(8) ; =0x8b86 =35718(-29818),=0x8b62 =35682(-29854) [Divide bignums with remainder, direct, direct]
86e0(467330+)      ZAD   /N8B62(8),/W88E2(4) ; =0x8b62 =35682(-29854),=0x88e2 =35042(-30494) [Zero-add bignum, direct, direct]
86e7(57     )      DAO              ; [Disable abort on overflow]
86e8(463023+)      C     /W88E2(4),=1 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x01]
86ee(1803   )      BGZ   D86F3      ; =+3 [Branch if greater than zero]
86f0(7186F6 )      JMP/  J86F6      ; =0x86f6 =34550(-30986) [Jump direct]
86f3(7187A9 )D86F3 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
86f6(463023+)J86F6 C     /W88E2(4),=31 ; =0x88e2 =35042(-30494), [Compare bignums, direct, literal=0x1f]
86fc(1603   )      BM    D8701      ; =+3 [Branch on minus]
86fe(718704 )      JMP/  J8704      ; =0x8704 =34564(-30972) [Jump direct]
8701(7187A9 )D8701 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
8704(71859D )J8704 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8707(465423+)J8707 C     /?DATA(6),=9999999999 ; =0x88fc =35068(-30468), [Compare bignums, direct, literal=0x02540be3ff]
8711(1603   )      BM    D8716      ; =+3 [Branch on minus]
8713(718719 )      JMP/  J8719      ; =0x8719 =34585(-30951) [Jump direct]
8716(7187A9 )D8716 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
8719(56     )J8719 EAO              ; [Enable abort on overflow]
871a(2A     )      CLAB             ; [Clear AL]
871b(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
871e(46073C+)      ZAD   =0,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x00, direct]
8724(467530+)      ZAD   /N8B62(8),/L8B72(6) ; =0x8b62 =35682(-29854),=0x8b72 =35698(-29838) [Zero-add bignum, direct, direct]
872b(57     )      DAO              ; [Disable abort on overflow]
872c(465520+)      C     /?DATA(6),/L8B72(6) ; =0x88fc =35068(-30468),=0x8b72 =35698(-29838) [Compare bignums, direct, direct]
8733(1803   )      BGZ   D8738      ; =+3 [Branch if greater than zero]
8735(71873B )      JMP/  J873B      ; =0x873b =34619(-30917) [Jump direct]
8738(7187A9 )D8738 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
873b(71859D )J873B JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
873e(471000+)W873E CPV   (0)/L8B08,/S8C07 ; =0x8b08 =35592(-29944),=0x8c07 =35847(-29689) [Compare variable-length, direct, direct]
8745(1403   )      BZ    D874A      ; =+3 [Branch if zero]
8747(71874D )      JMP/  J874D      ; =0x874d =34637(-30899) [Jump direct]
874a(71875C )D874A JMP/  J875C      ; =0x875c =34652(-30884) [Jump direct]
874d(471000+)J874D CPV   (0)/L8B08,/S8C09 ; =0x8b08 =35592(-29944),=0x8c09 =35849(-29687) [Compare variable-length, direct, direct]
8754(1503   )      BNZ   D8759      ; =+3 [Branch if not zero]
8756(71875C )      JMP/  J875C      ; =0x875c =34652(-30884) [Jump direct]
8759(7187A9 )D8759 JMP/  J87A9      ; =0x87a9 =34729(-30807) =BEL,')' [Jump direct]
875c(6632   )J875C SVC   50         ; =0x32 [Service call DC - CPL decode]
875e(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
8760(8876   )      DW    L8876      ; =0x8876 =34934(-30602) [address of format]
8762(88FC   )      DW    ?DATA      ; =0x88fc =35068(-30468) [address of argument]
8764(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8766(463023+)      C     /FTYPE(4),=6 ; =0x88c6 =35014(-30522), [Compare bignums, direct, literal=0x06]
876c(1403   )      BZ    D8771      ; =+3 [Branch if zero]
876e(718774 )      JMP/  J8774      ; =0x8774 =34676(-30860) [Jump direct]
8771(71859D )D8771 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
8774(56     )J8774 EAO              ; [Enable abort on overflow]
8775(2A     )      CLAB             ; [Clear AL]
8776(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8779(46073C+)      ZAD   =0,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x00, direct]
877f(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
8786(57     )      DAO              ; [Disable abort on overflow]
8787(471000+)      CPV   (0)/L8B08,/S8C07 ; =0x8b08 =35592(-29944),=0x8c07 =35847(-29689) [Compare variable-length, direct, direct]
878e(1403   )      BZ    D8793      ; =+3 [Branch if zero]
8790(7187A6 )      JMP/  J87A6      ; =0x87a6 =34726(-30810) =BEL,'&' [Jump direct]
8793(56     )D8793 EAO              ; [Enable abort on overflow]
8794(2A     )      CLAB             ; [Clear AL]
8795(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8798(46073C+)      ZAD   =1,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x01, direct]
879e(467530+)      ZAD   /N8B62(8),/?DATA(6) ; =0x8b62 =35682(-29854),=0x88fc =35068(-30468) [Zero-add bignum, direct, direct]
87a5(57     )      DAO              ; [Disable abort on overflow]
87a6(71859D )J87A6 JMP/  J859D      ; =0x859d =34205(-31331) [Jump direct]
87a9(7187ED )J87A9 JMP/  J87ED      ; =0x87ed =34797(-30739) =BEL,'m' [Jump direct]
*
* Function F87AC
*
87ac(900000 )F87AC LDA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load A with immediate]
87af(5C     )      XAY              ; [Transfer A to Y]
87b0(9561   )D87B0 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
87b2(1439   )      BZ    J87ED      ; =+57 [Branch if zero]
87b4(D188C4 )      LDB/  W88C4      ; =0x88c4 =35012(-30524) [Load B direct]
87b7(59     )      SAB              ; [A - B -> B]
87b8(1407   )      BZ    D87C1      ; =+7 [Branch if zero]
87ba(900012 )      LDA=  X'0012'    ; =0x0012 =18 [Load A with immediate]
87bd(5006   )      ADD   A,Y        ; [A + Y -> Y]
87bf(73EF   )      JMP   D87B0      ; =-17 [Jump relative]
87c1(9561   )D87C1 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
87c3(B18109 )      STA/  P8106+3    ; =0x8109 =33033(-32503) [Store A direct]
87c6(B1811E )      STA/  W811B+3    ; =0x811e =33054(-32482) [Store A direct]
87c9(B1812E )      STA/  W812B+3    ; =0x812e =33070(-32466) [Store A direct]
87cc(B1813A )      STA/  W8139+1    ; =0x813a =33082(-32454) [Store A direct]
87cf(5560   )      XFR   Y,A        ; [Transfer Y to A]
87d1(B00000 )W87D1 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
87d4(3103   )      DCR   A,4        ; [Decrement A by 4]
87d6(B00000 )      STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
*
* Function F87D9
*
87d9(56     )F87D9 EAO              ; [Enable abort on overflow]
87da(2A     )      CLAB             ; [Clear AL]
87db(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
87de(46073C+)      ZAD   =0,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x00, direct]
87e4(467330+)      ZAD   /N8B62(8),/XSTAT(4) ; =0x8b62 =35682(-29854),=0x88ee =35054(-30482) [Zero-add bignum, direct, direct]
87eb(57     )      DAO              ; [Disable abort on overflow]
87ec(09     )      RSR              ; [Return from subroutine]
*
87ed(56     )J87ED EAO              ; [Enable abort on overflow]
87ee(2A     )      CLAB             ; [Clear AL]
87ef(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
87f2(46073C+)      ZAD   =1,/N8B62(8) ; =0x8b62 =35682(-29854) [Zero-add bignum, literal=0x01, direct]
87f8(467330+)      ZAD   /N8B62(8),/XSTAT(4) ; =0x8b62 =35682(-29854),=0x88ee =35054(-30482) [Zero-add bignum, direct, direct]
87ff(57     )      DAO              ; [Disable abort on overflow]
8800(09     )      RSR              ; [Return from subroutine]
*
* Function F8801
*
8801(3A     )F8801 CLA              ; [Clear A]
8802(B188C2 )      STA/  FIELD      ; =0x88c2 =35010(-30526) [Store A direct]
8805(B188C4 )P8805 STA/  W88C4      ; =0x88c4 =35012(-30524) [Store A direct]
8808(7B4A   )D8808 JSR   F8854      ; =+74 [Jump to subroutine relative]
880a(D0B9B0 )      LDB=  X'B9B0'    ; =0xb9b0 =47536(-18000) ='9','0' [Load B with immediate]
880d(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
880f(1814   )      BGZ   D8825      ; =+20 [Branch if greater than zero]
8811(49     )      SABB             ; [AL - BL -> BL]
8812(1611   )      BM    D8825      ; =+17 [Branch on minus]
8814(E5A2   )      STBB- S-         ; [Store BL indexed, pre-decremented, direct]
8816(94EE   )      LDA*  P8805+1    ; =-18 [Load A relative indirect]
8818(3D     )      SLA              ; [Left shift A]
8819(5D     )      XAB              ; [Transfer A to B]
881a(3501   )      SLR   A,2        ; [Left shift A by 2]
881c(58     )      AAB              ; [A + B -> B]
881d(3A     )      CLA              ; [Clear A]
881e(85A1   )      LDAB+ S+         ; [Load AL indexed, direct, post-incremented]
8820(58     )      AAB              ; [A + B -> B]
8821(F4E3   )      STB*  P8805+1    ; =-29 [Store B relative indirect]
8823(73E3   )      JMP   D8808      ; =-29 [Jump relative]
8825(C0AC   )D8825 LDBB= X'AC'      ; =172(-84) =',' [Load BL with immediate]
8827(49     )      SABB             ; [AL - BL -> BL]
8828(1424   )      BZ    W884E      ; =+36 [Branch if zero]
882a(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
882c(49     )      SABB             ; [AL - BL -> BL]
882d(150D   )      BNZ   D883C      ; =+13 [Branch if not zero]
882f(6627   )      SVC   39         ; =0x27 [Service call CS - CPL string compare]
8831(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
8833(EEEE   )      DW    ZERO       ; [external symbol] [address of string]
8835(884E   )      DW    W884E      ; =0x884e =34894(-30642) [TODO: arg3]
8837(01     )      NOP              ; [No operation]
8838(7B1A   )      JSR   F8854      ; =+26 [Jump to subroutine relative]
883a(73E9   )      JMP   D8825      ; =-23 [Jump relative]
883c(6629   )D883C SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
883e(EEEE   )      DW    @LI        ; [external symbol] [address of string]
8840(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of string]
8842(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
8844(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8846(6629   )      SVC   41         ; =0x29 [Service call MV - CPL 32-bit string move]
8848(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
884a(EEEE   )      DW    @LI        ; [external symbol] [address of string]
884c(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
884e(9374   )W884E LDA   W88C4      ; =+116 [Load A relative]
8850(149B   )      BZ    J87ED      ; =-101 [Branch if zero]
8852(7385   )      JMP   F87D9      ; =-123 [Jump relative]
*
* Function F8854
*
8854(6632   )F8854 SVC   50         ; =0x32 [Service call DC - CPL decode]
8856(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of string]
8858(886B   )      DW    L886B      ; =0x886b =34923(-30613) [address of format]
885a(88FA   )      DW    L88FA      ; =0x88fa =35066(-30470) [address of argument]
885c(8B08   )      DW    L8B08      ; =0x8b08 =35592(-29944) [address of argument]
885e(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8860(8188FA )      LDAB/ L88FA      ; =0x88fa =35066(-30470) [Load AL direct]
8863(09     )      RSR              ; [Return from subroutine]
*
8864(0200   )L8864 DW    X'0200'    ; =0x0200 =512
8866(5002   )      DW    X'5002'    ; =0x5002 =20482
8868(00     )      DB    X'00'      ; =0x00 =0 =NUL
8869(0100   )      DW    X'0100'    ; =0x0100 =256
886b(0200   )L886B DW    X'0200'    ; =0x0200 =512
886d(0102   )      DW    X'0102'    ; =0x0102 =258
886f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8870(5000   )      DW    X'5000'    ; =0x5000 =20480
8872(F9     )S8872 DC    'y'        ; hex:f9 dec:249(-7)
8873(00     )      DB    X'00'      ; =0x00 =0 =NUL
8874(0100   )      DW    X'0100'    ; =0x0100 =256
8876(0200   )L8876 DW    X'0200'    ; =0x0200 =512
8878(0100   )      DW    X'0100'    ; =0x0100 =256
887a(01     )L887A DB    X'01'      ; =0x01 =1
887b(0000   )W887B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
887d(0200   )      DW    X'0200'    ; =0x0200 =512
887f(01     )      DB    X'01'      ; =0x01 =1
8880(F8     )      DC    'x'        ; hex:f8 dec:248(-8)
8881(00     )      DB    X'00'      ; =0x00 =0 =NUL
8882(0302   )      DW    X'0302'    ; =0x0302 =770
8884(00     )      DB    X'00'      ; =0x00 =0 =NUL
8885(0100   )      DW    X'0100'    ; =0x0100 =256
8887(01     )L8887 DB    X'01'      ; =0x01 =1
8888(0000   )W8888 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
888a(0100   )      DW    X'0100'    ; =0x0100 =256
888c(05     )      DB    X'05'      ; =0x05 =5
888d(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
888e(00     )      DB    X'00'      ; =0x00 =0 =NUL
888f(0302   )      DW    X'0302'    ; =0x0302 =770
8891(00     )      DB    X'00'      ; =0x00 =0 =NUL
8892(01     )      DB    X'01'      ; =0x01 =1
8893(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
8894(00     )      DB    X'00'      ; =0x00 =0 =NUL
8895(0400   )      DW    X'0400'    ; =0x0400 =1024
8897(01     )L8897 DB    X'01'      ; =0x01 =1
8898(0000   )W8898 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
889a(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
889b(00     )      DB    X'00'      ; =0x00 =0 =NUL
889c(0202   )      DW    X'0202'    ; =0x0202 =514
889e(00     )      DB    X'00'      ; =0x00 =0 =NUL
889f(01     )      DB    X'01'      ; =0x01 =1
88a0(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
88a1(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a2(0202   )      DW    X'0202'    ; =0x0202 =514
88a4(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a5(01     )      DB    X'01'      ; =0x01 =1
88a6(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
88a7(00     )      DB    X'00'      ; =0x00 =0 =NUL
88a8(0200   )      DW    X'0200'    ; =0x0200 =512
88aa(01     )L88AA DB    X'01'      ; =0x01 =1
88ab(0000   )W88AB DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ad(F8     )S88AD DC    'x'        ; hex:f8 dec:248(-8)
88ae(0063   )W88AE DW    X'0063'    ; =0x0063 =99
88b0(0200   )      DW    X'0200'    ; =0x0200 =512
88b2(0100   )      DW    X'0100'    ; =0x0100 =256
88b4(01     )L88B4 DB    X'01'      ; =0x01 =1
88b5(0000   )W88B5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88b7(02     )      DB    X'02'      ; =0x02 =2
88b8(0050   )W88B8 DW    X'0050'    ; =0x0050 =80
88ba(0200   )      DW    X'0200'    ; =0x0200 =512
88bc(0100   )      DW    X'0100'    ; =0x0100 =256
88be(02     )L88BE DB    X'02'      ; =0x02 =2
88bf(0050   )W88BF DW    X'0050'    ; =0x0050 =80
88c1(00     )      DB    X'00'      ; =0x00 =0 =NUL
88c2(0000   )FIELD DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c4(0000   )W88C4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c6(0000   )FTYPE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88c8(0000   )W88C8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ca(0000   )FLEN  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88cc(0000   )W88CC DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88ce(0000   )FDEC  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d0(0000   )W88D0 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d2(0000   )FV    DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d4(00     )W88D4 DB    X'00'      ; =0x00 =0 =NUL
88d5(00     )N88D5 DB    X'00'      ; =0x00 =0 =NUL
88d6(0000   )FH    DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88d8(0000   )W88D8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88da(000000+)FMIN  DB    0,4        ; =0x00,0x0004
88de(000000+)FMAX  DB    0,4        ; =0x00,0x0004
88e2(0000   )W88E2 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e4(0000   )W88E4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88e6(000000+)S88E6 DB    0,4        ; =0x00,0x0004
88ea(000000+)S88EA DB    0,4        ; =0x00,0x0004
88ee(000000+)XSTAT DB    0,4        ; =0x00,0x0004
88f2(0000   )FSCR  DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f4(0000   )W88F4 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f6(0000   )W88F6 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88f8(0000   )W88F8 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
88fa(       )L88FA DS    1          ; =0x0001 [Uninitialized memory]
88fb(00     )      DB    X'00'      ; =0x00 =0 =NUL
88fc(       )?DATA DS    2          ; =0x0002 [Uninitialized memory]
88fe(       )I88FE DS    2          ; =0x0002 [Uninitialized memory]
8900(       )W8900 DS    76         ; =0x004c [Uninitialized memory]
894c(00     )      DB    X'00'      ; =0x00 =0 =NUL
894d(000F   )L894D DW    X'000F'    ; =0x000f =15
894f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8951(0190   )      DW    X'0190'    ; =0x0190 =400
8953(896B   )      DW    W896B      ; =0x896b =35179(-30357)
8955(000000 )      DB    0,3        ; =0x00,0x0003
8958(0302   )      DW    X'0302'    ; =0x0302 =770
895a(0300   )      DW    X'0300'    ; =0x0300 =768
895c(000000+)      DB    0,11       ; =0x00,0x000b
8967(88F6   )      DW    W88F6      ; =0x88f6 =35062(-30474)
8969(0057   )      DW    X'0057'    ; =0x0057 =87
896b(       )W896B DS    402        ; =0x0192 [Uninitialized memory]
8afd(00     )      DB    X'00'      ; =0x00 =0 =NUL
8afe(0057   )L8AFE DW    X'0057'    ; =0x0057 =87
8b00(0057   )      DW    X'0057'    ; =0x0057 =87
8b02(       )      DS    5          ; =0x0005 [Uninitialized memory]
8b07(00     )S8B07 DB    X'00'      ; =0x00 =0 =NUL
8b08(       )L8B08 DS    1          ; =0x0001 [Uninitialized memory]
8b09(       )S8B09 DS    79         ; =0x004f [Uninitialized memory]
8b58(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8b5a(8200   )L8B5A DW    X'8200'    ; =0x8200 =33280(-32256)
8b5c(8C00   )L8B5C DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8b5e(8700   )      DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
8b60(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8b62(       )N8B62 DS    8          ; =0x0008 [Uninitialized memory]
8b6a(       )N8B6A DS    8          ; =0x0008 [Uninitialized memory]
8b72(       )L8B72 DS    6          ; =0x0006 [Uninitialized memory]
8b78(EEEE   )P8B78 DW    CSD03      ; [external symbol]
8b7a(       )      DS    4          ; =0x0004 [Uninitialized memory]
8b7e(       )W8B7E DS    8          ; =0x0008 [Uninitialized memory]
8b86(       )N8B86 DS    6          ; =0x0006 [Uninitialized memory]
8b8c(87     )W8B8C DB    X'87'      ; =0x87 =135(-121) =BEL
8b8d(C9CED6+)      DC    'INVALID FIELD#!'
8b9c(00     )      DB    X'00'      ; =0x00 =0 =NUL
8b9d(87     )W8B9D DB    X'87'      ; =0x87 =135(-121) =BEL
8b9e(C9CED6+)      DC    'INVALID DATA!'
8bab(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bac(87     )W8BAC DB    X'87'      ; =0x87 =135(-121) =BEL
8bad(A0C8C9+)      DC    ' HIT NEW LINE TO CONTINUE.'
8bc7(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bc8(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bc9(0F42   )      DW    X'0F42'    ; =0x0f42 =3906
8bcb(4000   )      DW    X'4000'    ; =0x4000 =16384
8bcd(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bce(2710   )      DW    X'2710'    ; =0x2710 =10000
8bd0(AF     )S8BD0 DC    '/'        ; hex:af dec:175(-81)
8bd1(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bd2(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bd3(9896   )      DW    X'9896'    ; =0x9896 =39062(-26474)
8bd5(80     )      DB    X'80'      ; =0x80 =128(-128)
8bd6(AD     )S8BD6 DC    '-'        ; hex:ad dec:173(-83)
8bd7(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bd8(A8     )S8BD8 DC    '('        ; hex:a8 dec:168(-88)
8bd9(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bda(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8bdc(03     )      DB    X'03'      ; =0x03 =3
8bdd(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8bde(A9     )S8BDE DC    ')'        ; hex:a9 dec:169(-87)
8bdf(00     )      DB    X'00'      ; =0x00 =0 =NUL
8be0(C5CED4+)S8BE0 DC    'ENTER FIELD#,DATA OR CR:'
8bf8(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bf9(B0     )S8BF9 DC    '0'        ; hex:b0 dec:176(-80)
8bfa(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bfb(B9     )S8BFB DC    '9'        ; hex:b9 dec:185(-71)
8bfc(00     )      DB    X'00'      ; =0x00 =0 =NUL
8bfd(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1)
8bff(D8F0   )      DC    'Xp'       ; hex:d8f0 dec:55536(-16)
8c01(00     )      DB    X'00'      ; =0x00 =0 =NUL
8c02(0254   )      DW    X'0254'    ; =0x0254 =596
8c04(0B     )      DB    X'0B'      ; =0x0b =11
8c05(E3     )      DC    'c'        ; hex:e3 dec:227(-29)
8c06(FF     )      DB    X'FF'      ; =0xff =255(-1)
8c07(D9     )S8C07 DC    'Y'        ; hex:d9 dec:217(-39)
8c08(00     )      DB    X'00'      ; =0x00 =0 =NUL
8c09(CE     )S8C09 DC    'N'        ; hex:ce dec:206(-50)
8c0a(00     )      DB    X'00'      ; =0x00 =0 =NUL
8c0b:ENDPT


 TITLE 'YN'
YN BEGIN 0
*
 EXT MSGN
 EXT CRT
 EXT @LI
 EXT STATUS
*
*
* Function YN
*
818d(9541   )YN    LDA+  X+         ; [Load A indexed, direct, post-incremented]
818f(B303   )      STA   W8194      ; =+3 [Store A relative]
8191(79EEEE )P8191 JSR/  MSGN       ; [external symbol] [Jump to subroutine direct]
8194(0000   )W8194 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8196(7CFA   )      JSR*  P8191+1    ; =-6 [Jump to subroutine relative indirect]
8198(81D0   )      DW    S81D0      ; =0x81d0 =33232(-32304)
819a(9081E6 )      LDA=  W81E6      ; =0x81e6 =33254(-32282) [Load A with immediate]
819d(5E     )      XAZ              ; [Transfer A to Z]
819e(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
81a0(34     )      DB    X'34'      ; =0x34 =52 [Service call RF - CPL formatted read]
81a1(EEEE   )      DW    CRT        ; [external symbol] [address of FCB]
81a3(81CA   )      DW    L81CA      ; =0x81ca =33226(-32310) [address of format]
81a5(81CE   )      DW    L81CE      ; =0x81ce =33230(-32306) [address of argument]
81a7(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
81a9(C1EEEE )      LDBB/ @LI        ; [external symbol] [Load BL direct]
81ac(140E   )      BZ    D81BC      ; =+14 [Branch if zero]
81ae(9081D8 )      LDA=  S81D8      ; =0x81d8 =33240(-32296) [Load A with immediate]
81b1(5C     )      XAY              ; [Transfer A to Y]
81b2(831A   )      LDAB  L81CE      ; =+26 [Load AL relative]
81b4(D561   )D81B4 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
81b6(1408   )      BZ    D81C0      ; =+8 [Branch if zero]
81b8(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
81ba(15F8   )      BNZ   D81B4      ; =-8 [Branch if not zero]
81bc(E1EEEE )D81BC STBB/ STATUS     ; [external symbol] [Store BL direct]
81bf(09     )      RSR              ; [Return from subroutine]
*
81c0(7CD0   )D81C0 JSR*  P8191+1    ; =-48 [Jump to subroutine relative indirect]
81c2(81D5   )      DW    W81D5      ; =0x81d5 =33237(-32299)
81c4(73CB   )      JMP   P8191      ; =-53 [Jump relative]
*
81c6(0200   )      DW    X'0200'    ; =0x0200 =512
81c8(4C00   )      DW    X'4C00'    ; =0x4c00 =19456
81ca(0200   )L81CA DW    X'0200'    ; =0x0200 =512
81cc(0100   )      DW    X'0100'    ; =0x0100 =256
81ce(0000   )L81CE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
81d0(A0AFAA )S81D0 DC    ' /*'      ; hex:a0afaa
81d3(8800   )      DW    X'8800'    ; =0x8800 =34816(-30720)
81d5(879A   )W81D5 DW    X'879A'    ; =0x879a =34714(-30822)
81d7(00     )      DB    X'00'      ; =0x00 =0 =NUL
81d8(AD     )S81D8 DC    '-'        ; hex:ad dec:173(-83)
81d9(00     )      DB    X'00'      ; =0x00 =0 =NUL
81da(CE     )      DC    'N'        ; hex:ce dec:206(-50)
81db(00     )      DB    X'00'      ; =0x00 =0 =NUL
81dc(EE     )      DC    'n'        ; hex:ee dec:238(-18)
81dd(00     )      DB    X'00'      ; =0x00 =0 =NUL
81de(AB     )      DC    '+'        ; hex:ab dec:171(-85)
81df(01     )      DB    X'01'      ; =0x01 =1
81e0(D9     )      DC    'Y'        ; hex:d9 dec:217(-39)
81e1(01     )      DB    X'01'      ; =0x01 =1
81e2(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
81e3(0100   )      DW    X'0100'    ; =0x0100 =256
81e5(00     )      DB    X'00'      ; =0x00 =0 =NUL
*
81e6(6656   )W81E6 SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
81e8:ENDPT


 TITLE 'PHONE'
PHONE BEGIN 0
*
 EXT @IF
 EXT EDIT
 EXT ZERO
*
*
* Function PHONE
*
8000(9541   )PHONE LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(465538+)      ZAD   -A(6),/N80CE(6) ; =0x80ce =32974(-32562) [Zero-add bignum, indexed, direct]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(B180C1 )      STA/  W80BE+3    ; =0x80c1 =32961(-32575) [Store A direct]
800d(56     )      EAO              ; [Enable abort on overflow]
800e(2A     )      CLAB             ; [Clear AL]
800f(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8012(465730+)      ZAD   /N80CE(6),/N8100(8) ; =0x80ce =32974(-32562),=0x8100 =33024(-32512) [Zero-add bignum, direct, direct]
8019(46353C+)      ZAD   =10000000,/N811A(6) ; =0x811a =33050(-32486) [Zero-add bignum, literal=0x00989680, direct]
8022(908112 )      LDA=  W8112      ; =0x8112 =33042(-32494) [Load A with immediate]
8025(465770+)      DRM   /N811A(6),/N8100(8) ; =0x811a =33050(-32486),=0x8100 =33024(-32512) [Divide bignums with remainder, direct, direct]
802c(467330+)      ZAD   /N8100(8),/N80D4(4) ; =0x8100 =33024(-32512),=0x80d4 =32980(-32556) [Zero-add bignum, direct, direct]
8033(57     )      DAO              ; [Disable abort on overflow]
8034(56     )      EAO              ; [Enable abort on overflow]
8035(2A     )      CLAB             ; [Clear AL]
8036(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8039(463730+)      ZAD   /N80D4(4),/N8100(8) ; =0x80d4 =32980(-32556),=0x8100 =33024(-32512) [Zero-add bignum, direct, direct]
8040(46375C+)      M     =-10000000,/N8100(8) ; =0x8100 =33024(-32512) [Multiply bignums, literal=0xff676980, direct]
8049(465700+)      A     /N80CE(6),/N8100(8) ; =0x80ce =32974(-32562),=0x8100 =33024(-32512) [Add bignums, direct, direct]
8050(467330+)      ZAD   /N8100(8),/W80D8(4) ; =0x8100 =33024(-32512),=0x80d8 =32984(-32552) [Zero-add bignum, direct, direct]
8057(57     )      DAO              ; [Disable abort on overflow]
8058(79EEEE )      JSR/  EDIT       ; [external symbol] [Jump to subroutine direct]
805b(80D8   )      DW    W80D8      ; =0x80d8 =32984(-32552)
805d(80DC   )      DW    W80DC      ; =0x80dc =32988(-32548)
805f(8128   )      DW    S8128      ; =0x8128 =33064(-32472)
8061(472083+)      MVV   (132,0)/S8134,/S80E6 ; =0x8134 =33076(-32460),=0x80e6 =32998(-32538) [Move variable-length, direct, direct]
8069(463023+)      C     /N80D4(4),=0 ; =0x80d4 =32980(-32556), [Compare bignums, direct, literal=0x00]
806f(1403   )      BZ    D8074      ; =+3 [Branch if zero]
8071(718077 )      JMP/  J8077      ; =0x8077 =32887(-32649) [Jump direct]
8074(7180BE )D8074 JMP/  W80BE      ; =0x80be =32958(-32578) [Jump direct]
8077(463023+)J8077 C     /N80D4(4),=1 ; =0x80d4 =32980(-32556), [Compare bignums, direct, literal=0x01]
807d(1403   )      BZ    D8082      ; =+3 [Branch if zero]
807f(71808D )      JMP/  J808D      ; =0x808d =32909(-32627) [Jump direct]
8082(472083+)D8082 MVV   (132,0)/S813A,/S80E6 ; =0x813a =33082(-32454),=0x80e6 =32998(-32538) [Move variable-length, direct, direct]
808a(7180BE )      JMP/  W80BE      ; =0x80be =32958(-32578) [Jump direct]
808d(56     )J808D EAO              ; [Enable abort on overflow]
808e(2A     )      CLAB             ; [Clear AL]
808f(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8092(463730+)      ZAD   /N80D4(4),/N8100(8) ; =0x80d4 =32980(-32556),=0x8100 =33024(-32512) [Zero-add bignum, direct, direct]
8099(46170C+)      A     =1000,/N8100(8) ; =0x8100 =33024(-32512) [Add bignums, literal=0x03e8, direct]
80a0(467530+)      ZAD   /N8100(8),/L8108(6) ; =0x8100 =33024(-32512),=0x8108 =33032(-32504) [Zero-add bignum, direct, direct]
80a7(57     )      DAO              ; [Disable abort on overflow]
80a8(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
80aa(80E6   )      DW    S80E6      ; =0x80e6 =32998(-32538) [address of string]
80ac(80EC   )      DW    S80EC      ; =0x80ec =33004(-32532) [address of format]
80ae(8108   )      DW    L8108      ; =0x8108 =33032(-32504) [address of argument]
80b0(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
80b2(6633   )      SVC   51         ; =0x33 [Service call NC - CPL encode]
80b4(80E6   )      DW    S80E6      ; =0x80e6 =32998(-32538) [address of string]
80b6(80F0   )      DW    L80F0      ; =0x80f0 =33008(-32528) [address of format]
80b8(8144   )      DW    S8144      ; =0x8144 =33092(-32444) [address of argument]
80ba(8146   )      DW    S8146      ; =0x8146 =33094(-32442) [address of argument]
80bc(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
80be(472083+)W80BE MVV   (132,0)/S80E6,/ZERO ; =0x80e6 =32998(-32538),[external symbol] [Move variable-length, direct, direct]
80c6(472283+)      MVV   (132,0)/W80DD,-Z ; =0x80dd =32989(-32547), [Move variable-length, direct, indexed]
80cd(09     )      RSR              ; [Return from subroutine]
*
80ce(       )N80CE DS    6          ; =0x0006 [Uninitialized memory]
80d4(       )N80D4 DS    4          ; =0x0004 [Uninitialized memory]
80d8(       )W80D8 DS    4          ; =0x0004 [Uninitialized memory]
80dc(       )W80DC DS    1          ; =0x0001 [Uninitialized memory]
80dd(       )W80DD DS    8          ; =0x0008 [Uninitialized memory]
80e5(00     )      DB    X'00'      ; =0x00 =0 =NUL
80e6(       )S80E6 DS    5          ; =0x0005 [Uninitialized memory]
80eb(00     )      DB    X'00'      ; =0x00 =0 =NUL
80ec(F8     )S80EC DC    'x'        ; hex:f8 dec:248(-8)
80ed(00     )      DB    X'00'      ; =0x00 =0 =NUL
80ee(0400   )      DW    X'0400'    ; =0x0400 =1024
80f0(0200   )L80F0 DW    X'0200'    ; =0x0200 =512
80f2(0101   )      DW    X'0101'    ; =0x0101 =257
80f4(00     )      DB    X'00'      ; =0x00 =0 =NUL
80f5(0302   )      DW    X'0302'    ; =0x0302 =770
80f7(00     )      DB    X'00'      ; =0x00 =0 =NUL
80f8(0100   )      DW    X'0100'    ; =0x0100 =256
80fa(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
80fc(8700   )      DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
80fe(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8100(       )N8100 DS    8          ; =0x0008 [Uninitialized memory]
8108(       )L8108 DS    10         ; =0x000a [Uninitialized memory]
8112(       )W8112 DS    8          ; =0x0008 [Uninitialized memory]
811a(       )N811A DS    6          ; =0x0006 [Uninitialized memory]
8120(00     )      DB    X'00'      ; =0x00 =0 =NUL
8121(9896   )      DW    X'9896'    ; =0x9896 =39062(-26474)
8123(80FF   )      DW    X'80FF'    ; =0x80ff =33023(-32513)
8125(6769   )      DW    X'6769'    ; =0x6769 =26473
8127(80     )      DB    X'80'      ; =0x80 =128(-128)
8128(B0B0C0+)S8128 DC    '00@###-####'
8133(00     )      DB    X'00'      ; =0x00 =0 =NUL
8134(A0A0A0+)S8134 DC    ' ',5     
8139(00     )      DB    X'00'      ; =0x00 =0 =NUL
813a(A0A0A0 )S813A DC    ' ',3     
813d(B1AD   )      DC    '1-'       ; hex:b1ad dec:45485(-83)
813f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8140(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8142(03     )      DB    X'03'      ; =0x03 =3
8143(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8144(A8     )S8144 DC    '('        ; hex:a8 dec:168(-88)
8145(00     )      DB    X'00'      ; =0x00 =0 =NUL
8146(A9     )S8146 DC    ')'        ; hex:a9 dec:169(-87)
8147(00     )      DB    X'00'      ; =0x00 =0 =NUL
8148:ENDPT


 TITLE 'SETX'
SETX BEGIN 0
*
 ENT DEBST
 ENT CKETX
 ENT TXP
 ENT ING32
 ENT NVAL32
 ENT CKST
 ENT VAL32
*
 EXT @IF
 EXT ZERO
 EXT STATUS
*
*
* Function SETX
*
8000(9541   )SETX  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B32B   )      STA   TXP        ; =+43 [Store A relative]
8004(5C     )      XAY              ; [Transfer A to Y]
8005(8B     )D8005 LDAB+ Y          ; [Load AL from address in Y]
8006(140D   )      BZ    D8015      ; =+13 [Branch if zero]
8008(C0E1   )      LDBB= X'E1'      ; =225(-31) ='a' [Load BL with immediate]
800a(49     )      SABB             ; [AL - BL -> BL]
800b(1604   )      BM    D8011      ; =+4 [Branch on minus]
800d(80C1   )      LDAB= X'C1'      ; =193(-63) ='A' [Load AL with immediate]
800f(4031   )      ADDB  BL,AL      ; [BL + AL -> AL]
8011(A561   )D8011 STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8013(73F0   )      JMP   D8005      ; =-16 [Jump relative]
8015(7B01   )D8015 JSR   DEBST      ; =+1 [Jump to subroutine relative]
8017(09     )      RSR              ; [Return from subroutine]
*
* Function DEBST
*
8018(9315   )DEBST LDA   TXP        ; =+21 [Load A relative]
801a(D0A0A0 )      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
801d(C501   )D801D LDBB+ A+         ; [Load BL indexed, direct, post-incremented]
801f(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
8021(14FA   )      BZ    D801D      ; =-6 [Branch if zero]
8023(39     )      DCA              ; [Decrement A]
8024(B309   )      STA   TXP        ; =+9 [Store A relative]
8026(09     )      RSR              ; [Return from subroutine]
*
* Function CKETX
*
8027(8406   )CKETX LDAB* TXP        ; =+6 [Load AL relative indirect]
8029(144B   )      BZ    D8076      ; =+75 [Branch if zero]
802b(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
802d(7347   )      JMP   D8076      ; =+71 [Jump relative]
*
802f(0000   )TXP   DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
*
* Function ING32
*
8031(6DA2   )ING32 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8033(63FA   )      LDX   TXP        ; =-6 [Load X relative]
8035(3A     )      CLA              ; [Clear A]
8036(B34B   )      STA   NVAL32     ; =+75 [Store A relative]
8038(B34B   )      STA   W8085      ; =+75 [Store A relative]
803a(A000   )B803A STAB= X'00'      ; =0 =NUL [Store AL immediate]
803c(A30F   )      STAB  B804C+1    ; =+15 [Store AL relative]
803e(8541   )D803E LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8040(C0AB   )      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
8042(49     )      SABB             ; [AL - BL -> BL]
8043(1407   )      BZ    B804C      ; =+7 [Branch if zero]
8045(C0AD   )      LDBB= X'AD'      ; =173(-83) ='-' [Load BL with immediate]
8047(49     )      SABB             ; [AL - BL -> BL]
8048(153D   )      BNZ   D8087      ; =+61 [Branch if not zero]
804a(A3EF   )      STAB  B803A+1    ; =-17 [Store AL relative]
804c(8000   )B804C LDAB= X'00'      ; =0 =NUL [Load AL with immediate]
804e(14EE   )      BZ    D803E      ; =-18 [Branch if zero]
8050(83E9   )D8050 LDAB  B803A+1    ; =-23 [Load AL relative]
8052(141B   )      BZ    D806F      ; =+27 [Branch if zero]
8054(56     )      EAO              ; [Enable abort on overflow]
8055(2A     )      CLAB             ; [Clear AL]
8056(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8059(463730+)      ZAD   /ZERO(4),/ENDPT(8) ; [external symbol],=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
8060(463710+)      S     /NVAL32(4),/ENDPT(8) ; =0x8083 =32899(-32637),=0x823d =33341(-32195) [Subtract bignums, direct, direct]
8067(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
806e(57     )      DAO              ; [Disable abort on overflow]
806f(6BBE   )D806F STX   TXP        ; =-66 [Store X relative]
8071(7BA5   )      JSR   DEBST      ; =-91 [Jump to subroutine relative]
8073(2A     )      CLAB             ; [Clear AL]
8074(65A1   )D8074 LDX+  S+         ; [Load X indexed, direct, post-incremented]
8076(A1EEEE )D8076 STAB/ STATUS     ; [external symbol] [Store AL direct]
8079(09     )      RSR              ; [Return from subroutine]
*
807a(3F     )D807A DCX              ; [Decrement X]
807b(83D0   )      LDAB  B804C+1    ; =-48 [Load AL relative]
807d(15D1   )      BNZ   D8050      ; =-47 [Branch if not zero]
807f(8001   )D807F LDAB= X'01'      ; =1 [Load AL with immediate]
8081(73F1   )      JMP   D8074      ; =-15 [Jump relative]
*
8083(0000   )NVAL32 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8085(0000   )W8085 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8087(C0B9   )D8087 LDBB= X'B9'      ; =185(-71) ='9' [Load BL with immediate]
8089(49     )      SABB             ; [AL - BL -> BL]
808a(18EE   )      BGZ   D807A      ; =-18 [Branch if greater than zero]
808c(C0B0   )      LDBB= X'B0'      ; =176(-80) ='0' [Load BL with immediate]
808e(49     )      SABB             ; [AL - BL -> BL]
808f(16E9   )      BM    D807A      ; =-23 [Branch on minus]
8091(A3BA   )      STAB  B804C+1    ; =-70 [Store AL relative]
8093(E326   )      STBB  B80BB      ; =+38 [Store BL relative]
8095(56     )      EAO              ; [Enable abort on overflow]
8096(2A     )      CLAB             ; [Clear AL]
8097(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
809a(463730+)      ZAD   /NVAL32(4),/ENDPT(8) ; =0x8083 =32899(-32637),=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
80a1(46075C+)      M     =10,/ENDPT(8) ; =0x823d =33341(-32195) [Multiply bignums, literal=0x0a, direct]
80a7(463700+)      A     /N80B8(4),/ENDPT(8) ; =0x80b8 =32952(-32584),=0x823d =33341(-32195) [Add bignums, direct, direct]
80ae(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
80b5(57     )      DAO              ; [Disable abort on overflow]
80b6(7386   )      JMP   D803E      ; =-122 [Jump relative]
*
80b8(000000 )N80B8 DB    0,3        ; =0x00,0x0003
80bb(00     )B80BB DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function CKST
*
80bc(9541   )CKST  LDA+  X+         ; [Load A indexed, direct, post-incremented]
80be(5C     )      XAY              ; [Transfer A to Y]
80bf(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
80c1(61802F )      LDX/  TXP        ; =0x802f =32815(-32721) [Load X direct]
80c4(8561   )D80C4 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
80c6(14A7   )      BZ    D806F      ; =-89 [Branch if zero]
80c8(C541   )      LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
80ca(49     )      SABB             ; [AL - BL -> BL]
80cb(15B2   )      BNZ   D807F      ; =-78 [Branch if not zero]
80cd(73F5   )      JMP   D80C4      ; =-11 [Jump relative]
*
* Function VAL32
*
80cf(56     )VAL32 EAO              ; [Enable abort on overflow]
80d0(2A     )      CLAB             ; [Clear AL]
80d1(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
80d4(463730+)      ZAD   /ZERO(4),/ENDPT(8) ; [external symbol],=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
80db(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
80e2(467330+)      ZAD   /ENDPT(8),/N822F(4) ; =0x823d =33341(-32195),=0x822f =33327(-32209) [Zero-add bignum, direct, direct]
80e9(57     )      DAO              ; [Disable abort on overflow]
80ea(56     )      EAO              ; [Enable abort on overflow]
80eb(2A     )      CLAB             ; [Clear AL]
80ec(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
80ef(46073C+)      ZAD   =-1,/ENDPT(8) ; =0x823d =33341(-32195) [Zero-add bignum, literal=0xff, direct]
80f5(467330+)      ZAD   /ENDPT(8),/N8233(4) ; =0x823d =33341(-32195),=0x8233 =33331(-32205) [Zero-add bignum, direct, direct]
80fc(57     )      DAO              ; [Disable abort on overflow]
80fd(D1802F )P80FD LDB/  TXP        ; =0x802f =32815(-32721) [Load B direct]
8100(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
8102(F4FA   )      STB*  P80FD+1    ; =-6 [Store B relative indirect]
8104(4D     )      XABB             ; [Transfer AL to BL]
8105(144E   )      BZ    D8155      ; =+78 [Branch if zero]
8107(D0ADAB )      LDB=  X'ADAB'    ; =0xadab =44459(-21077) ='-','+' [Load B with immediate]
810a(49     )      SABB             ; [AL - BL -> BL]
810b(142F   )      BZ    D813C      ; =+47 [Branch if zero]
810d(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
810f(1430   )      BZ    D8141      ; =+48 [Branch if zero]
8111(C0AE   )      LDBB= X'AE'      ; =174(-82) ='.' [Load BL with immediate]
8113(49     )      SABB             ; [AL - BL -> BL]
8114(1417   )      BZ    D812D      ; =+23 [Branch if zero]
8116(D0B9B0 )      LDB=  X'B9B0'    ; =0xb9b0 =47536(-18000) ='9','0' [Load B with immediate]
8119(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
811b(1838   )      BGZ   D8155      ; =+56 [Branch if greater than zero]
811d(49     )      SABB             ; [AL - BL -> BL]
811e(1635   )      BM    D8155      ; =+53 [Branch on minus]
8120(798087 )      JSR/  D8087      ; =0x8087 =32903(-32633) [Jump to subroutine direct]
8123(918235 )P8123 LDA/  W8235      ; =0x8235 =33333(-32203) [Load A direct]
8126(16D5   )      BM    P80FD      ; =-43 [Branch on minus]
8128(38     )      INA              ; [Increment A]
8129(B4F9   )      STA*  P8123+1    ; =-7 [Store A relative indirect]
812b(73D0   )      JMP   P80FD      ; =-48 [Jump relative]
812d(94F5   )D812D LDA*  P8123+1    ; =-11 [Load A relative indirect]
812f(1603   )      BM    D8134      ; =+3 [Branch on minus]
8131(71820C )      JMP/  J820C      ; =0x820c =33292(-32244) [Jump direct]
8134(3A     )D8134 CLA              ; [Clear A]
8135(B18233 )      STA/  N8233      ; =0x8233 =33331(-32205) [Store A direct]
8138(B4EA   )      STA*  P8123+1    ; =-22 [Store A relative indirect]
813a(73C1   )      JMP   P80FD      ; =-63 [Jump relative]
813c(900001 )D813C LDA=  X'0001'    ; =0x0001 =1 [Load A with immediate]
813f(7303   )      JMP   D8144      ; =+3 [Jump relative]
8141(90FFFF )D8141 LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
8144(D18231 )D8144 LDB/  W8231      ; =0x8231 =33329(-32207) [Load B direct]
8147(1403   )      BZ    D814C      ; =+3 [Branch if zero]
8149(71820C )      JMP/  J820C      ; =0x820c =33292(-32244) [Jump direct]
814c(B18231 )D814C STA/  W8231      ; =0x8231 =33329(-32207) [Store A direct]
814f(3C     )      SRA              ; [Arithmetic right shift A]
8150(B1822F )      STA/  N822F      ; =0x822f =33327(-32209) [Store A direct]
8153(73A8   )      JMP   P80FD      ; =-88 [Jump relative]
8155(D0A0AC )D8155 LDB=  X'A0AC'    ; =0xa0ac =41132(-24404) =' ',',' [Load B with immediate]
8158(49     )      SABB             ; [AL - BL -> BL]
8159(1404   )      BZ    D815F      ; =+4 [Branch if zero]
815b(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
815d(1509   )      BNZ   D8168      ; =+9 [Branch if not zero]
815f(D1802F )D815F LDB/  TXP        ; =0x802f =32815(-32721) [Load B direct]
8162(8521   )      LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
8164(F4FA   )      STB*  D815F+1    ; =-6 [Store B relative indirect]
8166(73ED   )      JMP   D8155      ; =-19 [Jump relative]
8168(94F6   )D8168 LDA*  D815F+1    ; =-10 [Load A relative indirect]
816a(39     )      DCA              ; [Decrement A]
816b(B4F3   )      STA*  D815F+1    ; =-13 [Store A relative indirect]
816d(463320+)      C     /N8233(4),/ZERO(4) ; =0x8233 =33331(-32205),[external symbol] [Compare bignums, direct, direct]
8174(1803   )      BGZ   D8179      ; =+3 [Branch if greater than zero]
8176(71818D )      JMP/  J818D      ; =0x818d =33165(-32371) [Jump direct]
8179(56     )D8179 EAO              ; [Enable abort on overflow]
817a(2A     )      CLAB             ; [Clear AL]
817b(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
817e(463730+)      ZAD   /ZERO(4),/ENDPT(8) ; [external symbol],=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
8185(467330+)      ZAD   /ENDPT(8),/N8233(4) ; =0x823d =33341(-32195),=0x8233 =33331(-32205) [Zero-add bignum, direct, direct]
818c(57     )      DAO              ; [Disable abort on overflow]
818d(9541   )J818D LDA+  X+         ; [Load A indexed, direct, post-incremented]
818f(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8191(150D   )      BNZ   D81A0      ; =+13 [Branch if not zero]
8193(479003+)      FIL   (4)/ZERO,/W822B ; [external symbol],=0x822b =33323(-32213) [Fill with byte, direct, direct]
819a(B1822D )      STA/  W822D      ; =0x822d =33325(-32211) [Store A direct]
819d(7181A6 )      JMP/  J81A6      ; =0x81a6 =33190(-32346) [Jump direct]
81a0(463338+)D81A0 ZAD   -A(4),/W822B(4) ; =0x822b =33323(-32213) [Zero-add bignum, indexed, direct]
81a6(463320+)J81A6 C     /W822B(4),/N8233(4) ; =0x822b =33323(-32213),=0x8233 =33331(-32205) [Compare bignums, direct, direct]
81ad(1803   )      BGZ   D81B2      ; =+3 [Branch if greater than zero]
81af(7181B5 )      JMP/  J81B5      ; =0x81b5 =33205(-32331) [Jump direct]
81b2(718211 )D81B2 JMP/  J8211      ; =0x8211 =33297(-32239) [Jump direct]
81b5(463320+)J81B5 C     /W822B(4),/N8233(4) ; =0x822b =33323(-32213),=0x8233 =33331(-32205) [Compare bignums, direct, direct]
81bc(1603   )      BM    D81C1      ; =+3 [Branch on minus]
81be(7181E4 )      JMP/  J81E4      ; =0x81e4 =33252(-32284) [Jump direct]
81c1(56     )D81C1 EAO              ; [Enable abort on overflow]
81c2(2A     )      CLAB             ; [Clear AL]
81c3(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
81c6(463730+)      ZAD   /NVAL32(4),/ENDPT(8) ; =0x8083 =32899(-32637),=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
81cd(46075C+)      M     =10,/ENDPT(8) ; =0x823d =33341(-32195) [Multiply bignums, literal=0x0a, direct]
81d3(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
81da(57     )      DAO              ; [Disable abort on overflow]
81db(46030C+)      A     =1,/N8233(4) ; =0x8233 =33331(-32205) [Add bignums, literal=0x01, direct]
81e1(7181B5 )      JMP/  J81B5      ; =0x81b5 =33205(-32331) [Jump direct]
81e4(463320+)J81E4 C     /N822F(4),/ZERO(4) ; =0x822f =33327(-32209),[external symbol] [Compare bignums, direct, direct]
81eb(1503   )      BNZ   D81F0      ; =+3 [Branch if not zero]
81ed(71820B )      JMP/  J820B      ; =0x820b =33291(-32245) [Jump direct]
81f0(56     )D81F0 EAO              ; [Enable abort on overflow]
81f1(2A     )      CLAB             ; [Clear AL]
81f2(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
81f5(463730+)      ZAD   /N822F(4),/ENDPT(8) ; =0x822f =33327(-32209),=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
81fc(463750+)      M     /NVAL32(4),/ENDPT(8) ; =0x8083 =32899(-32637),=0x823d =33341(-32195) [Multiply bignums, direct, direct]
8203(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
820a(57     )      DAO              ; [Disable abort on overflow]
820b(09     )J820B RSR              ; [Return from subroutine]
*
820c(9541   )J820C LDA+  X+         ; [Load A indexed, direct, post-incremented]
820e(B18231 )      STA/  W8231      ; =0x8231 =33329(-32207) [Store A direct]
8211(56     )J8211 EAO              ; [Enable abort on overflow]
8212(2A     )      CLAB             ; [Clear AL]
8213(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8216(463730+)      ZAD   /ZERO(4),/ENDPT(8) ; [external symbol],=0x823d =33341(-32195) [Zero-add bignum, direct, direct]
821d(467330+)      ZAD   /ENDPT(8),/NVAL32(4) ; =0x823d =33341(-32195),=0x8083 =32899(-32637) [Zero-add bignum, direct, direct]
8224(57     )      DAO              ; [Disable abort on overflow]
8225(8001   )      LDAB= X'01'      ; =1 [Load AL with immediate]
8227(A1EEEE )      STAB/ STATUS     ; [external symbol] [Store AL direct]
822a(09     )      RSR              ; [Return from subroutine]
*
822b(0000   )W822B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
822d(0000   )W822D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
822f(0000   )N822F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8231(0000   )W8231 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8233(0000   )N8233 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8235(0000   )W8235 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8237(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8239(8700   )      DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
823b(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
823d:ENDPT


 TITLE 'CSD00'
CSD00 BEGIN 0
*
 EXT ZERO
 EXT @IF
*
*
* Function CSD00
*
8000(9541   )CSD00 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B1806D )      STA/  W806D      ; =0x806d =32877(-32659) [Store A direct]
8005(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8007(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8009(150D   )      BNZ   D8018      ; =+13 [Branch if not zero]
800b(479003+)      FIL   (4)/ZERO,/W8074 ; [external symbol],=0x8074 =32884(-32652) [Fill with byte, direct, direct]
8012(B18076 )      STA/  W8076      ; =0x8076 =32886(-32650) [Store A direct]
8015(71801E )      JMP/  J801E      ; =0x801e =32798(-32738) [Jump direct]
8018(463338+)D8018 ZAD   -A(4),/W8074(4) ; =0x8074 =32884(-32652) [Zero-add bignum, indexed, direct]
801e(9541   )J801E LDA+  X+         ; [Load A indexed, direct, post-incremented]
8020(4500   )      XFRB  AU,AU      ; [Transfer AU to AU]
8022(150D   )      BNZ   D8031      ; =+13 [Branch if not zero]
8024(479003+)      FIL   (4)/ZERO,/W8078 ; [external symbol],=0x8078 =32888(-32648) [Fill with byte, direct, direct]
802b(B1807A )      STA/  W807A      ; =0x807a =32890(-32646) [Store A direct]
802e(718037 )      JMP/  J8037      ; =0x8037 =32823(-32713) [Jump direct]
8031(463338+)D8031 ZAD   -A(4),/W8078(4) ; =0x8078 =32888(-32648) [Zero-add bignum, indexed, direct]
8037(56     )J8037 EAO              ; [Enable abort on overflow]
8038(2A     )      CLAB             ; [Clear AL]
8039(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
803c(463730+)      ZAD   /W8074(4),/ENDPT(8) ; =0x8074 =32884(-32652),=0x8082 =32898(-32638) [Zero-add bignum, direct, direct]
8043(46070C+)      A     =1,/ENDPT(8) ; =0x8082 =32898(-32638) [Add bignums, literal=0x01, direct]
8049(467330+)      ZAD   /ENDPT(8),/W8074(4) ; =0x8082 =32898(-32638),=0x8074 =32884(-32652) [Zero-add bignum, direct, direct]
8050(57     )      DAO              ; [Disable abort on overflow]
8051(56     )      EAO              ; [Enable abort on overflow]
8052(2A     )      CLAB             ; [Clear AL]
8053(A1EEEE )      STAB/ @IF        ; [external symbol] [Store AL direct]
8056(463730+)      ZAD   /W8078(4),/ENDPT(8) ; =0x8078 =32888(-32648),=0x8082 =32898(-32638) [Zero-add bignum, direct, direct]
805d(46070C+)      A     =1,/ENDPT(8) ; =0x8082 =32898(-32638) [Add bignums, literal=0x01, direct]
8063(467330+)      ZAD   /ENDPT(8),/W8078(4) ; =0x8082 =32898(-32638),=0x8078 =32888(-32648) [Zero-add bignum, direct, direct]
806a(57     )      DAO              ; [Disable abort on overflow]
806b(662A   )      SVC   42         ; =0x2A [Service call CP - CPL cursor position]
806d(EEEE   )W806D DW    ZERO       ; [external symbol] [address of FCB]
806f(8078   )      DW    W8078      ; =0x8078 =32888(-32648) [column address or value]
8071(8074   )      DW    W8074      ; =0x8074 =32884(-32652) [row address or value]
8073(09     )      RSR              ; [Return from subroutine]
*
8074(       )W8074 DS    2          ; =0x0002 [Uninitialized memory]
8076(       )W8076 DS    2          ; =0x0002 [Uninitialized memory]
8078(       )W8078 DS    2          ; =0x0002 [Uninitialized memory]
807a(       )W807A DS    2          ; =0x0002 [Uninitialized memory]
807c(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
807e(8700   )      DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
8080(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8082:ENDPT


 TITLE 'CSD01'
CSD01 BEGIN 0
*
*
* Function CSD01
*
8000(9541   )CSD01 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(B33B   )      STA   W803F      ; =+59 [Store A relative]
8004(B340   )      STA   W8046      ; =+64 [Store A relative]
8006(B348   )      STA   W8050      ; =+72 [Store A relative]
8008(B34B   )      STA   W8055      ; =+75 [Store A relative]
800a(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800c(B32C   )      STA   W803A      ; =+44 [Store A relative]
800e(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8010(B345   )      STA   W8057      ; =+69 [Store A relative]
8012(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8014(B335   )      STA   W804B      ; =+53 [Store A relative]
8016(B30C   )      STA   W8024      ; =+12 [Store A relative]
8018(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
801a(B342   )      STA   W805D+1    ; =+66 [Store A relative]
801c(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
801e(A33B   )      STAB  B805B      ; =+59 [Store AL relative]
8020(1521   )      BNZ   D8043      ; =+33 [Branch if not zero]
8022(661E   )      SVC   30         ; =0x1E [Service call LD - CPL 32-bit load]
8024(0000   )W8024 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8026(661F   )      SVC   31         ; =0x1F [Service call ST - CPL 32-bit store]
8028(8061   )      DW    S8061      ; =0x8061 =32865(-32671) [address of integer]
802a(C004   )      LDBB= X'04'      ; =4 [Load BL with immediate]
802c(8333   )      LDAB  S8061      ; =+51 [Load AL relative]
802e(1702   )      BP    D8032      ; =+2 [Branch on plus]
8030(C002   )      LDBB= X'02'      ; =2 [Load BL with immediate]
8032(E327   )D8032 STBB  B805B      ; =+39 [Store BL relative]
8034(E548FF )      STBB+ X,-1       ; [Store BL indexed, displaced, direct]
8037(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8039(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
803a(0000   )W803A DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
803c(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
803e(1F     )      DB    X'1F'      ; =0x1f =31 [Service call ST - CPL 32-bit store]
803f(0000   )W803F DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8041(730F   )      JMP   D8052      ; =+15 [Jump relative]
8043(7D80   )D8043 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8045(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
8046(0000   )W8046 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8048(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
804a(20     )      DB    X'20'      ; =0x20 =32 [Service call AD - CPL 32-bit add]
804b(0000   )W804B DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
804d(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
804f(1F     )      DB    X'1F'      ; =0x1f =31 [Service call ST - CPL 32-bit store]
8050(0000   )W8050 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
*
8052(7D80   )D8052 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8054(26     )      DB    X'26'      ; =0x26 =38 [Service call CN - CPL 32-bit numeric compare]
8055(0000   )W8055 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8057(0000   )W8057 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8059(805D   )      DW    W805D      ; =0x805d =32861(-32675) [TODO: arg3]
805b(00     )B805B HLT              ; [Halt]
805c(09     )      RSR              ; [Return from subroutine]
*
805d(600000 )W805D LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
8060(09     )      RSR              ; [Return from subroutine]
*
8061(000000+)S8061 DB    0,4        ; =0x00,0x0004
*
8065(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8067(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8069(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
806b:ENDPT


 TITLE 'CSD01B'
CSD01B BEGIN 0
*
*
* Function CSD01B
*
8000(479C13+)CSD01B FIL   (20)=X'00',/W8071 ; =0x8071 =32881(-32655) [Fill with byte, literal=0, direct]
8006(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8008(B367   )      STA   W8071      ; =+103 [Store A relative]
800a(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800c(7B47   )      JSR   F8055      ; =+71 [Jump to subroutine relative]
800e(8073   )      DW    W8073      ; =0x8073 =32883(-32653)
8010(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8012(7B41   )      JSR   F8055      ; =+65 [Jump to subroutine relative]
8014(8079   )      DW    W8079      ; =0x8079 =32889(-32647)
8016(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8018(7B3B   )      JSR   F8055      ; =+59 [Jump to subroutine relative]
801a(807F   )      DW    W807F      ; =0x807f =32895(-32641)
801c(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
801e(B332   )      STA   W8051+1    ; =+50 [Store A relative]
8020(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8022(A32A   )      STAB  B804E      ; =+42 [Store AL relative]
8024(151A   )      BNZ   D8040      ; =+26 [Branch if not zero]
8026(934B   )      LDA   W8073      ; =+75 [Load A relative]
8028(D347   )      LDB   W8071      ; =+71 [Load B relative]
802a(46333A+)      ZAD   -A(4),-B(4) ; [Zero-add bignum, indexed, indexed]
802e(8016   )      LDAB= X'16'      ; =22 [Load AL with immediate]
8030(C2807F )      LDBB$ W807F      ; =0x807f =32895(-32641) [Load BL indirect]
8033(1702   )      BP    D8037      ; =+2 [Branch on plus]
8035(8018   )      LDAB= X'18'      ; =24 [Load AL with immediate]
8037(A315   )D8037 STAB  B804E      ; =+21 [Store AL relative]
8039(A548FF )      STAB+ X,-1       ; [Store AL indexed, displaced, direct]
803c(9333   )      LDA   W8071      ; =+51 [Load A relative]
803e(7308   )      JMP   D8048      ; =+8 [Jump relative]
8040(932F   )D8040 LDA   W8071      ; =+47 [Load A relative]
8042(D33B   )      LDB   W807F      ; =+59 [Load B relative]
8044(46330A+)      A     -B(4),-A(4) ; [Add bignums, indexed, indexed]
8048(D32F   )D8048 LDB   W8079      ; =+47 [Load B relative]
804a(46332A+)      C     -A(4),-B(4) ; [Compare bignums, indexed, indexed]
804e(1601   )B804E BM    W8051      ; =+1 [Branch on minus]
8050(09     )      RSR              ; [Return from subroutine]
*
8051(600000 )W8051 LDX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Load X with immediate]
8054(09     )      RSR              ; [Return from subroutine]
*
* Function F8055
*
8055(4500   )F8055 XFRB  AU,AU      ; [Transfer AU to AU]
8057(140F   )      BZ    D8068      ; =+15 [Branch if zero]
8059(D0FF01 )      LDB=  X'FF01'    ; =0xff01 =65281(-255) [Load B with immediate]
805c(59     )      SAB              ; [A - B -> B]
805d(160F   )      BM    D806E      ; =+15 [Branch on minus]
805f(DA     )      LDB+  X          ; [Load B from address in X]
8060(3021   )      INR   B,2        ; [Increment B by 2]
8062(474E01+)      MVF   (2)=X'FFFF',-B ; [Move fixed-length, literal=65535(-1), indexed]
8068(DA     )D8068 LDB+  X          ; [Load B from address in X]
8069(B52904 )      STA+  B+,4       ; [Store A indexed, displaced, direct, post-incremented]
806c(5520   )      XFR   B,A        ; [Transfer B to A]
806e(B545   )D806E STA+  *X+        ; [Store A indexed, indirect, post-incremented]
8070(09     )      RSR              ; [Return from subroutine]
*
8071(0000   )W8071 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8073(0000   )W8073 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8075(       )      DS    4          ; =0x0004 [Uninitialized memory]
8079(0000   )W8079 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
807b(       )      DS    4          ; =0x0004 [Uninitialized memory]
807f(0000   )W807F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8081(       )      DS    4          ; =0x0004 [Uninitialized memory]
*
8085(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8087(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8089(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
808b:ENDPT


 TITLE 'CSD03'
CSD03 BEGIN 0
*
*
* Function CSD03
*
8000(9541   )CSD03 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(5D     )      XAB              ; [Transfer A to B]
8003(4501   )      XFRB  AU,AL      ; [Transfer AU to AL]
8005(140C   )      BZ    D8013      ; =+12 [Branch if zero]
8007(3B     )      IVA              ; [Invert A]
8008(1409   )      BZ    D8013      ; =+9 [Branch if zero]
800a(9521   )      LDA+  B+         ; [Load A indexed, direct, post-incremented]
800c(B327   )      STA   W8035      ; =+39 [Store A relative]
800e(99     )      LDA+  B          ; [Load A from address in B]
800f(B326   )      STA   W8037      ; =+38 [Store A relative]
8011(7304   )      JMP   D8017      ; =+4 [Jump relative]
8013(B320   )D8013 STA   W8035      ; =+32 [Store A relative]
8015(F320   )      STB   W8037      ; =+32 [Store B relative]
8017(931C   )D8017 LDA   W8035      ; =+28 [Load A relative]
8019(1614   )      BM    D802F      ; =+20 [Branch on minus]
801b(1804   )      BGZ   D8021      ; =+4 [Branch if greater than zero]
801d(9318   )      LDA   W8037      ; =+24 [Load A relative]
801f(140E   )      BZ    D802F      ; =+14 [Branch if zero]
8021(9314   )D8021 LDA   W8037      ; =+20 [Load A relative]
8023(DA     )      LDB+  X          ; [Load B from address in X]
8024(59     )      SAB              ; [A - B -> B]
8025(1808   )      BGZ   D802F      ; =+8 [Branch if greater than zero]
8027(3D     )      SLA              ; [Left shift A]
8028(5040   )      ADD   X,A        ; [X + A -> A]
802a(98     )      LDA+  A          ; [Load A from address in A]
802b(1402   )      BZ    D802F      ; =+2 [Branch if zero]
802d(5B     )      XAX              ; [Transfer A to X]
802e(09     )      RSR              ; [Return from subroutine]
*
802f(9A     )D802F LDA+  X          ; [Load A from address in X]
8030(38     )      INA              ; [Increment A]
8031(3D     )      SLA              ; [Left shift A]
8032(5004   )      ADD   A,X        ; [A + X -> X]
8034(09     )      RSR              ; [Return from subroutine]
*
8035(0000   )W8035 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8037(0000   )W8037 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8039(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
803b(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
803d(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
803f:ENDPT


 TITLE 'CSD04'
CSD04 BEGIN 0
*
 ENT CSD04A
*
*
* Function CSD04
*
8000(7B31   )CSD04 JSR   F8033      ; =+49 [Jump to subroutine relative]
8002(D339   )      LDB   W803C+1    ; =+57 [Load B relative]
8004(6DA2   )D8004 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8006(633C   )      LDX   W8043+1    ; =+60 [Load X relative]
8008(8561   )D8008 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
800a(A521   )      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
800c(3F     )      DCX              ; [Decrement X]
800d(15F9   )      BNZ   D8008      ; =-7 [Branch if not zero]
800f(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8011(09     )      RSR              ; [Return from subroutine]
*
* Function CSD04A
*
8012(7B1F   )CSD04A JSR   F8033      ; =+31 [Jump to subroutine relative]
8014(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8016(1613   )      BM    D802B      ; =+19 [Branch on minus]
8018(1507   )      BNZ   D8021      ; =+7 [Branch if not zero]
801a(5562   )      XFR   Y,B        ; [Transfer Y to B]
801c(931F   )      LDA   W803C+1    ; =+31 [Load A relative]
801e(5C     )      XAY              ; [Transfer A to Y]
801f(73E3   )      JMP   D8004      ; =-29 [Jump relative]
8021(9321   )D8021 LDA   W8043+1    ; =+33 [Load A relative]
8023(C541   )D8023 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8025(E561   )      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
8027(39     )      DCA              ; [Decrement A]
8028(15F9   )      BNZ   D8023      ; =-7 [Branch if not zero]
802a(09     )      RSR              ; [Return from subroutine]
*
802b(3F     )D802B DCX              ; [Decrement X]
802c(8541   )D802C LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
802e(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8030(15FA   )      BNZ   D802C      ; =-6 [Branch if not zero]
8032(09     )      RSR              ; [Return from subroutine]
*
* Function F8033
*
8033(6B2C   )F8033 STX   W8060+1    ; =+44 [Store X relative]
8035(65A0   )      LDX+  S          ; [Load X indexed, direct]
8037(5580   )      XFR   Z,A        ; [Transfer Z to A]
8039(BD     )      STA+  S          ; [Store A to address in S]
803a(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
803c(F00000 )W803C STB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store B immediate]
803f(3A     )      CLA              ; [Clear A]
8040(8528FF )      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
8043(B00000 )W8043 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8046(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8048(5D     )      XAB              ; [Transfer A to B]
8049(4501   )      XFRB  AU,AL      ; [Transfer AU to AL]
804b(1406   )      BZ    D8053      ; =+6 [Branch if zero]
804d(3B     )      IVA              ; [Invert A]
804e(1403   )      BZ    D8053      ; =+3 [Branch if zero]
8050(D52802 )      LDB+  B,2        ; [Load B indexed, displaced, direct]
8053(93EF   )D8053 LDA   W8043+1    ; =-17 [Load A relative]
8055(662B   )      SVC   43         ; =0x2B [Service call MUL16 - 16-bit multiply]
8057(93E4   )      LDA   W803C+1    ; =-28 [Load A relative]
8059(38     )      INA              ; [Increment A]
805a(58     )      AAB              ; [A + B -> B]
805b(5526   )      XFR   B,Y        ; [Transfer B to Y]
805d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
805f(5E     )      XAZ              ; [Transfer A to Z]
8060(710000 )W8060 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
8063(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8065(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8067(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8069:ENDPT


 TITLE 'CSD04B'
CSD04B BEGIN 0
*
 ENT CSD04A
*
*
* Function CSD04B
*
8000(7B31   )CSD04B JSR   F8033      ; =+49 [Jump to subroutine relative]
8002(D339   )      LDB   W803C+1    ; =+57 [Load B relative]
8004(6DA2   )D8004 STX-  S-         ; [Store X indexed, pre-decremented, direct]
8006(633C   )      LDX   W8043+1    ; =+60 [Load X relative]
8008(8561   )D8008 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
800a(A521   )      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
800c(3F     )      DCX              ; [Decrement X]
800d(15F9   )      BNZ   D8008      ; =-7 [Branch if not zero]
800f(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8011(09     )      RSR              ; [Return from subroutine]
*
* Function CSD04A
*
8012(7B1F   )CSD04A JSR   F8033      ; =+31 [Jump to subroutine relative]
8014(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8016(1613   )      BM    D802B      ; =+19 [Branch on minus]
8018(1507   )      BNZ   D8021      ; =+7 [Branch if not zero]
801a(5562   )      XFR   Y,B        ; [Transfer Y to B]
801c(931F   )      LDA   W803C+1    ; =+31 [Load A relative]
801e(5C     )      XAY              ; [Transfer A to Y]
801f(73E3   )      JMP   D8004      ; =-29 [Jump relative]
8021(9321   )D8021 LDA   W8043+1    ; =+33 [Load A relative]
8023(C541   )D8023 LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8025(E561   )      STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
8027(39     )      DCA              ; [Decrement A]
8028(15F9   )      BNZ   D8023      ; =-7 [Branch if not zero]
802a(09     )      RSR              ; [Return from subroutine]
*
802b(3F     )D802B DCX              ; [Decrement X]
802c(8541   )D802C LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
802e(A561   )      STAB+ Y+         ; [Store AL indexed, direct, post-incremented]
8030(15FA   )      BNZ   D802C      ; =-6 [Branch if not zero]
8032(09     )      RSR              ; [Return from subroutine]
*
* Function F8033
*
8033(6B2C   )F8033 STX   W8060+1    ; =+44 [Store X relative]
8035(65A0   )      LDX+  S          ; [Load X indexed, direct]
8037(5580   )      XFR   Z,A        ; [Transfer Z to A]
8039(BD     )      STA+  S          ; [Store A to address in S]
803a(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
803c(F00000 )W803C STB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store B immediate]
803f(3A     )      CLA              ; [Clear A]
8040(8528FF )      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
8043(B00000 )W8043 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8046(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8048(5D     )      XAB              ; [Transfer A to B]
8049(4501   )      XFRB  AU,AL      ; [Transfer AU to AL]
804b(1406   )      BZ    D8053      ; =+6 [Branch if zero]
804d(3B     )      IVA              ; [Invert A]
804e(1403   )      BZ    D8053      ; =+3 [Branch if zero]
8050(D52802 )      LDB+  B,2        ; [Load B indexed, displaced, direct]
8053(93EF   )D8053 LDA   W8043+1    ; =-17 [Load A relative]
8055(7720   )      MUL   B,A        ; [B * A -> A,B]
8057(93E4   )      LDA   W803C+1    ; =-28 [Load A relative]
8059(38     )      INA              ; [Increment A]
805a(58     )      AAB              ; [A + B -> B]
805b(5526   )      XFR   B,Y        ; [Transfer B to Y]
805d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
805f(5E     )      XAZ              ; [Transfer A to Z]
8060(710000 )W8060 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
8063(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8065(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8067(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8069:ENDPT


 TITLE 'CSD05'
CSD05 BEGIN 0
*
*
* Function CSD05
*
8000(7D80   )CSD05 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8002(46     )      DB    X'46'      ; =0x46 =70 [Service call ST64 - CPL 64-bit store]
8003(801A   )      DW    B801A      ; =0x801a =32794(-32742) [address of integer]
8005(8313   )      LDAB  B801A      ; =+19 [Load AL relative]
8007(1606   )      BM    D800F      ; =+6 [Branch on minus]
8009(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
800b(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
800c(801A   )      DW    B801A      ; =0x801a =32794(-32742) [address of integer]
800e(09     )      RSR              ; [Return from subroutine]
*
800f(7D80   )D800F JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8011(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
8012(801A   )      DW    B801A      ; =0x801a =32794(-32742) [address of integer]
8014(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8016(24     )      DB    X'24'      ; =0x24 =36 [Service call MU - CPL 32-bit multiply]
8017(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1) [address of integer]
8019(09     )      RSR              ; [Return from subroutine]
*
801a(       )B801A DS    8          ; =0x0008 [Uninitialized memory]
*
8022(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8024(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8026(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8028:ENDPT


 TITLE 'CSD05B'
CSD05B BEGIN 0
*
*
* Function CSD05B
*
8000(9541   )CSD05B LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(46072E+)      C     =0,-A(8)   ; [Compare bignums, literal=0x00, indexed]
8007(1705   )      BP    D800E      ; =+5 [Branch on plus]
8009(46075E+)      M     =-1,-A(8)  ; [Multiply bignums, literal=0xff, indexed]
800e(09     )D800E RSR              ; [Return from subroutine]
*
800f(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8011(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8013(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8015:ENDPT


 TITLE 'CSD06'
CSD06 BEGIN 0
*
*
* Function CSD06
*
8000(7D80   )CSD06 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8002(46     )      DB    X'46'      ; =0x46 =70 [Service call ST64 - CPL 64-bit store]
8003(8029   )      DW    B8029      ; =0x8029 =32809(-32727) [address of integer]
8005(9322   )      LDA   B8029      ; =+34 [Load A relative]
8007(161A   )      BM    D8023      ; =+26 [Branch on minus]
8009(1512   )      BNZ   D801D      ; =+18 [Branch if not zero]
800b(931E   )      LDA   W802B      ; =+30 [Load A relative]
800d(150E   )      BNZ   D801D      ; =+14 [Branch if not zero]
800f(931C   )      LDA   W802D      ; =+28 [Load A relative]
8011(150A   )      BNZ   D801D      ; =+10 [Branch if not zero]
8013(931A   )      LDA   W802F      ; =+26 [Load A relative]
8015(1506   )      BNZ   D801D      ; =+6 [Branch if not zero]
8017(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8019(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
801a(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
801c(09     )      RSR              ; [Return from subroutine]
*
801d(7D80   )D801D JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
801f(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
8020(0001   )      DW    X'0001'    ; =0x0001 =1 [address of integer]
8022(09     )      RSR              ; [Return from subroutine]
*
8023(7D80   )D8023 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8025(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
8026(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1) [address of integer]
8028(09     )      RSR              ; [Return from subroutine]
*
8029(       )B8029 DS    2          ; =0x0002 [Uninitialized memory]
802b(       )W802B DS    2          ; =0x0002 [Uninitialized memory]
802d(       )W802D DS    2          ; =0x0002 [Uninitialized memory]
802f(       )W802F DS    2          ; =0x0002 [Uninitialized memory]
*
8031(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8033(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8035(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8037:ENDPT


 TITLE 'CSD06B'
CSD06B BEGIN 0
*
*
* Function CSD06B
*
8000(9541   )CSD06B LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(46072E+)      C     =0,-A(8)   ; [Compare bignums, literal=0x00, indexed]
8007(1808   )      BGZ   D8011      ; =+8 [Branch if greater than zero]
8009(160C   )      BM    D8017      ; =+12 [Branch on minus]
800b(46073E+)      ZAD   =0,-A(8)   ; [Zero-add bignum, literal=0x00, indexed]
8010(09     )      RSR              ; [Return from subroutine]
*
8011(46073E+)D8011 ZAD   =1,-A(8)   ; [Zero-add bignum, literal=0x01, indexed]
8016(09     )      RSR              ; [Return from subroutine]
*
8017(46073E+)D8017 ZAD   =-1,-A(8)  ; [Zero-add bignum, literal=0xff, indexed]
801c(09     )      RSR              ; [Return from subroutine]
*
801d(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
801f(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8021(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8023:ENDPT


 TITLE 'CSD07'
CSD07 BEGIN 0
*
*
* Function CSD07
*
8000(7D80   )CSD07 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8002(22     )      DB    X'22'      ; =0x22 =34 [Service call SU - CPL 32-bit subtract]
8003(0001   )      DW    X'0001'    ; =0x0001 =1 [address of integer]
8005(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8007(1F     )      DB    X'1F'      ; =0x1f =31 [Service call ST - CPL 32-bit store]
8008(806E   )      DW    B806E      ; =0x806e =32878(-32658) [address of integer]
800a(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800c(B303   )      STA   W8011      ; =+3 [Store A relative]
800e(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8010(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
8011(0000   )W8011 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8013(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8015(46     )      DB    X'46'      ; =0x46 =70 [Service call ST64 - CPL 64-bit store]
8016(8072   )      DW    B8072      ; =0x8072 =32882(-32654) [address of integer]
8018(9356   )      LDA   W8070      ; =+86 [Load A relative]
801a(1706   )      BP    D8022      ; =+6 [Branch on plus]
801c(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
801e(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
801f(8072   )      DW    B8072      ; =0x8072 =32882(-32654) [address of integer]
8021(09     )      RSR              ; [Return from subroutine]
*
8022(934C   )D8022 LDA   W8070      ; =+76 [Load A relative]
8024(142C   )      BZ    D8052      ; =+44 [Branch if zero]
8026(D00005 )      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
8029(59     )      SAB              ; [A - B -> B]
802a(1903   )      BLE   D802F      ; =+3 [Branch if less than or equal to zero]
802c(900005 )      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
802f(B5A2   )D802F STA-  S-         ; [Store A indexed, pre-decremented, direct]
8031(D33D   )      LDB   W8070      ; =+61 [Load B relative]
8033(5120   )      SUB   B,A        ; [B - A -> A]
8035(B339   )      STA   W8070      ; =+57 [Store A relative]
8037(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8039(3501   )      SLR   A,2        ; [Left shift A by 2]
803b(D08076 )      LDB=  W8076      ; =0x8076 =32886(-32650) [Load B with immediate]
803e(58     )      AAB              ; [A + B -> B]
803f(F308   )      STB   W8049      ; =+8 [Store B relative]
8041(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8043(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
8044(8072   )      DW    B8072      ; =0x8072 =32882(-32654) [address of integer]
8046(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8048(25     )      DB    X'25'      ; =0x25 =37 [Service call DV - CPL 32-bit divide]
8049(0000   )W8049 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
804b(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
804d(46     )      DB    X'46'      ; =0x46 =70 [Service call ST64 - CPL 64-bit store]
804e(8072   )      DW    B8072      ; =0x8072 =32882(-32654) [address of integer]
8050(73D0   )      JMP   D8022      ; =-48 [Jump relative]
8052(D00005 )D8052 LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
8055(831B   )      LDAB  B8072      ; =+27 [Load AL relative]
8057(1703   )      BP    D805C      ; =+3 [Branch on plus]
8059(D0FFFB )      LDB=  X'FFFB'    ; =0xfffb =65531(-5) [Load B with immediate]
805c(F308   )D805C STB   W8066      ; =+8 [Store B relative]
805e(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8060(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
8061(8072   )      DW    B8072      ; =0x8072 =32882(-32654) [address of integer]
8063(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8065(20     )      DB    X'20'      ; =0x20 =32 [Service call AD - CPL 32-bit add]
8066(0000   )W8066 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8068(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
806a(25     )      DB    X'25'      ; =0x25 =37 [Service call DV - CPL 32-bit divide]
806b(000A   )      DW    X'000A'    ; =0x000a =10 [address of integer]
806d(09     )      RSR              ; [Return from subroutine]
*
806e(       )B806E DS    2          ; =0x0002 [Uninitialized memory]
8070(       )W8070 DS    2          ; =0x0002 [Uninitialized memory]
8072(       )B8072 DS    4          ; =0x0004 [Uninitialized memory]
8076(       )W8076 DS    4          ; =0x0004 [Uninitialized memory]
807a(000000 )      DB    0,3        ; =0x00,0x0003
807d(0A00   )      DW    X'0A00'    ; =0x0a00 =2560
807f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8081(6400   )      DW    X'6400'    ; =0x6400 =25600
8083(00     )      DB    X'00'      ; =0x00 =0 =NUL
8084(03     )      DB    X'03'      ; =0x03 =3
8085(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8086(00     )      DB    X'00'      ; =0x00 =0 =NUL
8087(00     )      DB    X'00'      ; =0x00 =0 =NUL
8088(2710   )      DW    X'2710'    ; =0x2710 =10000
808a(00     )      DB    X'00'      ; =0x00 =0 =NUL
808b(0186   )      DW    X'0186'    ; =0x0186 =390
808d(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
*
808e(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8090(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8092(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8094:ENDPT


 TITLE 'CSD07B'
CSD07B BEGIN 0
*
*
* Function CSD07B
*
8000(9541   )CSD07B LDA+  X+         ; [Load A indexed, direct, post-incremented]
8002(467138+)      ZAD   -A(8),/N8060(2) ; =0x8060 =32864(-32672) [Zero-add bignum, indexed, direct]
8008(3107   )      DCR   A,8        ; [Decrement A by 8]
800a(B352   )      STA   W805E      ; =+82 [Store A relative]
800c(467738+)      ZAD   -A(8),/N8062(8) ; =0x8062 =32866(-32670) [Zero-add bignum, indexed, direct]
8012(311080+)      DEC/  N8060      ; =0x8060 =32864(-32672) [Decrement word at address by 1]
8016(163D   )      BM    D8055      ; =+61 [Branch on minus]
8018(9346   )D8018 LDA   N8060      ; =+70 [Load A relative]
801a(1421   )      BZ    D803D      ; =+33 [Branch if zero]
801c(D00005 )      LDB=  X'0005'    ; =0x0005 =5 [Load B with immediate]
801f(59     )      SAB              ; [A - B -> B]
8020(1903   )      BLE   D8025      ; =+3 [Branch if less than or equal to zero]
8022(900005 )      LDA=  X'0005'    ; =0x0005 =5 [Load A with immediate]
8025(B5A2   )D8025 STA-  S-         ; [Store A indexed, pre-decremented, direct]
8027(D337   )      LDB   N8060      ; =+55 [Load B relative]
8029(5120   )      SUB   B,A        ; [B - A -> A]
802b(B333   )      STA   N8060      ; =+51 [Store A relative]
802d(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
802f(3501   )      SLR   A,2        ; [Left shift A by 2]
8031(D08066 )      LDB=  W8066      ; =0x8066 =32870(-32666) [Load B with immediate]
8034(58     )      AAB              ; [A + B -> B]
8035(463768+)      D     -B(4),/N8062(8) ; =0x8062 =32866(-32670) [Divide bignums, indexed, direct]
803b(73DB   )      JMP   D8018      ; =-37 [Jump relative]
803d(8323   )D803D LDAB  N8062      ; =+35 [Load AL relative]
803f(1708   )      BP    D8049      ; =+8 [Branch on plus]
8041(46071C+)      S     =5,/N8062(8) ; =0x8062 =32866(-32670) [Subtract bignums, literal=0x05, direct]
8047(7306   )      JMP   D804F      ; =+6 [Jump relative]
8049(46070C+)D8049 A     =5,/N8062(8) ; =0x8062 =32866(-32670) [Add bignums, literal=0x05, direct]
804f(46076C+)D804F D     =10,/N8062(8) ; =0x8062 =32866(-32670) [Divide bignums, literal=0x0a, direct]
8055(9307   )D8055 LDA   W805E      ; =+7 [Load A relative]
8057(467732+)      ZAD   /N8062(8),-A(8) ; =0x8062 =32866(-32670), [Zero-add bignum, direct, indexed]
805d(09     )      RSR              ; [Return from subroutine]
*
805e(       )W805E DS    2          ; =0x0002 [Uninitialized memory]
8060(       )N8060 DS    2          ; =0x0002 [Uninitialized memory]
8062(       )N8062 DS    4          ; =0x0004 [Uninitialized memory]
8066(       )W8066 DS    4          ; =0x0004 [Uninitialized memory]
806a(000000 )      DB    0,3        ; =0x00,0x0003
806d(0A00   )      DW    X'0A00'    ; =0x0a00 =2560
806f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8071(6400   )      DW    X'6400'    ; =0x6400 =25600
8073(00     )      DB    X'00'      ; =0x00 =0 =NUL
8074(03     )      DB    X'03'      ; =0x03 =3
8075(E8     )      DC    'h'        ; hex:e8 dec:232(-24)
8076(00     )      DB    X'00'      ; =0x00 =0 =NUL
8077(00     )      DB    X'00'      ; =0x00 =0 =NUL
8078(2710   )      DW    X'2710'    ; =0x2710 =10000
807a(00     )      DB    X'00'      ; =0x00 =0 =NUL
807b(0186   )      DW    X'0186'    ; =0x0186 =390
807d(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
*
807e(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8080(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8082(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8084:ENDPT


 TITLE 'CSD08'
CSD08 BEGIN 0
*
 ENT CSD08A
*
*
* Function CSD08
*
8000(7B40   )CSD08 JSR   F8042      ; =+64 [Jump to subroutine relative]
8002(F30C   )      STB   W8010      ; =+12 [Store B relative]
8004(F310   )      STB   W8016      ; =+16 [Store B relative]
8006(9350   )      LDA   W8057+1    ; =+80 [Load A relative]
8008(3C     )      SRA              ; [Arithmetic right shift A]
8009(3101   )      DCR   A,2        ; [Decrement A by 2]
800b(1506   )      BNZ   D8013      ; =+6 [Branch if not zero]
800d(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
800f(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
8010(0000   )W8010 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8012(09     )      RSR              ; [Return from subroutine]
*
8013(7D80   )D8013 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8015(3B     )      DB    X'3B'      ; =0x3b =59 [Service call LD48 - CPL 48-bit load]
8016(0000   )W8016 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8018(09     )      RSR              ; [Return from subroutine]
*
* Function CSD08A
*
8019(7B27   )CSD08A JSR   F8042      ; =+39 [Jump to subroutine relative]
801b(F317   )      STB   W8034      ; =+23 [Store B relative]
801d(F320   )      STB   W803F      ; =+32 [Store B relative]
801f(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8021(B30C   )      STA   W802F      ; =+12 [Store A relative]
8023(B315   )      STA   W803A      ; =+21 [Store A relative]
8025(9331   )      LDA   W8057+1    ; =+49 [Load A relative]
8027(3C     )      SRA              ; [Arithmetic right shift A]
8028(3101   )      DCR   A,2        ; [Decrement A by 2]
802a(150B   )      BNZ   D8037      ; =+11 [Branch if not zero]
802c(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
802e(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
802f(0000   )W802F DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8031(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8033(1F     )      DB    X'1F'      ; =0x1f =31 [Service call ST - CPL 32-bit store]
8034(0000   )W8034 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8036(09     )      RSR              ; [Return from subroutine]
*
8037(7D80   )D8037 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8039(45     )      DB    X'45'      ; =0x45 =69 [Service call LD64 - CPL 64-bit load]
803a(0000   )W803A DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
803c(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
803e(3C     )      DB    X'3C'      ; =0x3c =60 [Service call ST48 - CPL 48-bit store]
803f(0000   )W803F DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8041(09     )      RSR              ; [Return from subroutine]
*
* Function F8042
*
8042(7D80   )F8042 JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
8044(1F     )      DB    X'1F'      ; =0x1f =31 [Service call ST - CPL 32-bit store]
8045(8069   )      DW    B8069      ; =0x8069 =32873(-32663) [address of integer]
8047(6B1E   )      STX   W8066+1    ; =+30 [Store X relative]
8049(65A0   )      LDX+  S          ; [Load X indexed, direct]
804b(5580   )      XFR   Z,A        ; [Transfer Z to A]
804d(BD     )      STA+  S          ; [Store A to address in S]
804e(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
8050(F00000 )W8050 STB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store B immediate]
8053(3A     )      CLA              ; [Clear A]
8054(8528FF )      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
8057(B00000 )W8057 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
805a(D30F   )      LDB   W806B      ; =+15 [Load B relative]
805c(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
805e(2B     )      DB    X'2B'      ; =0x2b =43 [Service call MUL16 - 16-bit multiply]
805f(93F0   )      LDA   W8050+1    ; =-16 [Load A relative]
8061(38     )      INA              ; [Increment A]
8062(58     )      AAB              ; [A + B -> B]
8063(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8065(5E     )      XAZ              ; [Transfer A to Z]
8066(710000 )W8066 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
*
8069(       )B8069 DS    2          ; =0x0002 [Uninitialized memory]
806b(       )W806B DS    2          ; =0x0002 [Uninitialized memory]
*
806d(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
806f(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8071(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8073:ENDPT


 TITLE 'CSD08B'
CSD08B BEGIN 0
*
 ENT CSD08A
*
*
* Function CSD08B
*
8000(D541   )CSD08B LDB+  X+         ; [Load B indexed, direct, post-incremented]
8002(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8004(79802A )      JSR/  F802A      ; =0x802a =32810(-32726) [Jump to subroutine direct]
8007(1505   )      BNZ   D800E      ; =+5 [Branch if not zero]
8009(46373A+)      ZAD   -B(4),-Y(8) ; [Zero-add bignum, indexed, indexed]
800d(09     )      RSR              ; [Return from subroutine]
*
800e(46573A+)D800E ZAD   -B(6),-Y(8) ; [Zero-add bignum, indexed, indexed]
8012(09     )      RSR              ; [Return from subroutine]
*
* Function CSD08A
*
8013(D541   )CSD08A LDB+  X+         ; [Load B indexed, direct, post-incremented]
8015(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8017(79802A )      JSR/  F802A      ; =0x802a =32810(-32726) [Jump to subroutine direct]
801a(1507   )      BNZ   D8023      ; =+7 [Branch if not zero]
801c(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
801e(46733A+)      ZAD   -A(8),-B(4) ; [Zero-add bignum, indexed, indexed]
8022(09     )      RSR              ; [Return from subroutine]
*
8023(9541   )D8023 LDA+  X+         ; [Load A indexed, direct, post-incremented]
8025(46753A+)      ZAD   -A(8),-B(6) ; [Zero-add bignum, indexed, indexed]
8029(09     )      RSR              ; [Return from subroutine]
*
* Function F802A
*
802a(5C     )F802A XAY              ; [Transfer A to Y]
802b(F00000 )W802B STB=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store B immediate]
802e(3A     )      CLA              ; [Clear A]
802f(8528FF )      LDAB+ B,-1       ; [Load AL indexed, displaced, direct]
8032(B00000 )W8032 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
8035(D56806 )      LDB+  Y,6        ; [Load B indexed, displaced, direct]
8038(7702   )      MUL   A,B        ; [A * B -> B]
803a(93F0   )      LDA   W802B+1    ; =-16 [Load A relative]
803c(38     )      INA              ; [Increment A]
803d(58     )      AAB              ; [A + B -> B]
803e(93F3   )      LDA   W8032+1    ; =-13 [Load A relative]
8040(3C     )      SRA              ; [Arithmetic right shift A]
8041(3101   )      DCR   A,2        ; [Decrement A by 2]
8043(09     )      RSR              ; [Return from subroutine]
*
8044(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8046(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8048(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
804a:ENDPT


 TITLE 'CSD09'
CSD09 BEGIN 0
*
*
* Function CSD09
*
8000(5580   )CSD09 XFR   Z,A        ; [Transfer Z to A]
8002(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8004(5560   )      XFR   Y,A        ; [Transfer Y to A]
8006(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
8008(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800a(5C     )      XAY              ; [Transfer A to Y]
800b(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
800d(5E     )      XAZ              ; [Transfer A to Z]
800e(8B     )      LDAB+ Y          ; [Load AL from address in Y]
800f(7980B3 )      JSR/  F80B3      ; =0x80b3 =32947(-32589) [Jump to subroutine direct]
8012(174B   )      BP    D805F      ; =+75 [Branch on plus]
8014(8C     )      LDAB+ Z          ; [Load AL from address in Z]
8015(7980B3 )      JSR/  F80B3      ; =0x80b3 =32947(-32589) [Jump to subroutine direct]
8018(1728   )      BP    D8042      ; =+40 [Branch on plus]
801a(8561   )J801A LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
801c(141E   )      BZ    D803C      ; =+30 [Branch if zero]
801e(C581   )      LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8020(1420   )      BZ    D8042      ; =+32 [Branch if zero]
8022(49     )      SABB             ; [AL - BL -> BL]
8023(1621   )      BM    D8046      ; =+33 [Branch on minus]
8025(181B   )      BGZ   D8042      ; =+27 [Branch if greater than zero]
8027(8B     )      LDAB+ Y          ; [Load AL from address in Y]
8028(7980B3 )      JSR/  F80B3      ; =0x80b3 =32947(-32589) [Jump to subroutine direct]
802b(1708   )      BP    D8035      ; =+8 [Branch on plus]
802d(8C     )      LDAB+ Z          ; [Load AL from address in Z]
802e(7980B3 )      JSR/  F80B3      ; =0x80b3 =32947(-32589) [Jump to subroutine direct]
8031(170F   )      BP    D8042      ; =+15 [Branch on plus]
8033(73E5   )      JMP   J801A      ; =-27 [Jump relative]
8035(8C     )D8035 LDAB+ Z          ; [Load AL from address in Z]
8036(7B7B   )      JSR   F80B3      ; =+123 [Jump to subroutine relative]
8038(172A   )      BP    D8064      ; =+42 [Branch on plus]
803a(730A   )      JMP   D8046      ; =+10 [Jump relative]
803c(C581   )D803C LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
803e(140A   )      BZ    D804A      ; =+10 [Branch if zero]
8040(7304   )      JMP   D8046      ; =+4 [Jump relative]
8042(C004   )D8042 LDBB= X'04'      ; =4 [Load BL with immediate]
8044(7306   )      JMP   D804C      ; =+6 [Jump relative]
8046(C002   )D8046 LDBB= X'02'      ; =2 [Load BL with immediate]
8048(7302   )      JMP   D804C      ; =+2 [Jump relative]
804a(C001   )D804A LDBB= X'01'      ; =1 [Load BL with immediate]
804c(95A1   )D804C LDA+  S+         ; [Load A indexed, direct, post-incremented]
804e(5C     )      XAY              ; [Transfer A to Y]
804f(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8051(5E     )      XAZ              ; [Transfer A to Z]
8052(854802 )      LDAB+ X,2        ; [Load AL indexed, displaced, direct]
8055(4231   )      ANDB  BL,AL      ; [BL & AL -> AL]
8057(1403   )      BZ    D805C      ; =+3 [Branch if zero]
8059(6540   )      LDX+  X          ; [Load X indexed, direct]
805b(09     )      RSR              ; [Return from subroutine]
*
805c(3042   )D805C INR   X,3        ; [Increment X by 3]
805e(09     )      RSR              ; [Return from subroutine]
*
805f(8C     )D805F LDAB+ Z          ; [Load AL from address in Z]
8060(7B51   )      JSR   F80B3      ; =+81 [Jump to subroutine relative]
8062(16E2   )      BM    D8046      ; =-30 [Branch on minus]
8064(2A     )D8064 CLAB             ; [Clear AL]
8065(A34B   )      STAB  B80B2      ; =+75 [Store AL relative]
8067(80B0   )      LDAB= X'B0'      ; =176(-80) ='0' [Load AL with immediate]
8069(C561   )D8069 LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
806b(49     )      SABB             ; [AL - BL -> BL]
806c(14FB   )      BZ    D8069      ; =-5 [Branch if zero]
806e(3160   )      DCR   Y          ; [Decrement Y by 1]
8070(C581   )D8070 LDBB+ Z+         ; [Load BL indexed, direct, post-incremented]
8072(49     )      SABB             ; [AL - BL -> BL]
8073(14FB   )      BZ    D8070      ; =-5 [Branch if zero]
8075(3180   )      DCR   Z          ; [Decrement Z by 1]
8077(8B     )      LDAB+ Y          ; [Load AL from address in Y]
8078(7B39   )      JSR   F80B3      ; =+57 [Jump to subroutine relative]
807a(1707   )      BP    D8083      ; =+7 [Branch on plus]
807c(8C     )      LDAB+ Z          ; [Load AL from address in Z]
807d(7B34   )      JSR   F80B3      ; =+52 [Jump to subroutine relative]
807f(1699   )      BM    J801A      ; =-103 [Branch on minus]
8081(73C3   )      JMP   D8046      ; =-61 [Jump relative]
8083(8C     )D8083 LDAB+ Z          ; [Load AL from address in Z]
8084(7B2D   )      JSR   F80B3      ; =+45 [Jump to subroutine relative]
8086(1702   )      BP    D808A      ; =+2 [Branch on plus]
8088(73B8   )      JMP   D8042      ; =-72 [Jump relative]
808a(8561   )D808A LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
808c(7B25   )      JSR   F80B3      ; =+37 [Jump to subroutine relative]
808e(1612   )      BM    D80A2      ; =+18 [Branch on minus]
8090(8581   )      LDAB+ Z+         ; [Load AL indexed, direct, post-incremented]
8092(7B1F   )      JSR   F80B3      ; =+31 [Jump to subroutine relative]
8094(16AC   )      BM    D8042      ; =-84 [Branch on minus]
8096(C568FF )      LDBB+ Y,-1       ; [Load BL indexed, displaced, direct]
8099(49     )      SABB             ; [AL - BL -> BL]
809a(8316   )      LDAB  B80B2      ; =+22 [Load AL relative]
809c(15EC   )      BNZ   D808A      ; =-20 [Branch if not zero]
809e(E312   )      STBB  B80B2      ; =+18 [Store BL relative]
80a0(73E8   )      JMP   D808A      ; =-24 [Jump relative]
80a2(3160   )D80A2 DCR   Y          ; [Decrement Y by 1]
80a4(8C     )      LDAB+ Z          ; [Load AL from address in Z]
80a5(7B0C   )      JSR   F80B3      ; =+12 [Jump to subroutine relative]
80a7(179D   )      BP    D8046      ; =-99 [Branch on plus]
80a9(8307   )      LDAB  B80B2      ; =+7 [Load AL relative]
80ab(1695   )      BM    D8042      ; =-107 [Branch on minus]
80ad(1897   )      BGZ   D8046      ; =-105 [Branch if greater than zero]
80af(71801A )      JMP/  J801A      ; =0x801a =32794(-32742) [Jump direct]
*
80b2(00     )B80B2 DB    X'00'      ; =0x00 =0 =NUL
*
*
* Function F80B3
*
80b3(D0B0B9 )F80B3 LDB=  X'B0B9'    ; =0xb0b9 =45241(-20295) ='0','9' [Load B with immediate]
80b6(49     )      SABB             ; [AL - BL -> BL]
80b7(1807   )      BGZ   D80C0      ; =+7 [Branch if greater than zero]
80b9(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
80bb(1603   )      BM    D80C0      ; =+3 [Branch on minus]
80bd(2230   )      CLRB  BL         ; [Clear BL]
80bf(09     )      RSR              ; [Return from subroutine]
*
80c0(C0FF   )D80C0 LDBB= X'FF'      ; =255(-1) [Load BL with immediate]
80c2(09     )      RSR              ; [Return from subroutine]
*
80c3:ENDPT


 TITLE 'CSD10'
CSD10 BEGIN 0
*
*
* Function CSD10
*
8000(9548FB )CSD10 LDA+  X,-5       ; [Load A indexed, displaced, direct]
8003(5C     )      XAY              ; [Transfer A to Y]
8004(C561   )D8004 LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
8006(15FC   )      BNZ   D8004      ; =-4 [Branch if not zero]
8008(5160   )      SUB   Y,A        ; [Y - A -> A]
800a(39     )      DCA              ; [Decrement A]
800b(B308   )      STA   W8015      ; =+8 [Store A relative]
800d(7D80   )      JSR+  Z          ; [Jump to subroutine indexed, direct] [Jump to OPSYS (SVC)]
800f(1E     )      DB    X'1E'      ; =0x1e =30 [Service call LD - CPL 32-bit load]
8010(8013   )      DW    B8013      ; =0x8013 =32787(-32749) [address of integer]
8012(09     )      RSR              ; [Return from subroutine]
*
8013(0000   )B8013 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8015(0000   )W8015 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8017(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8019(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
801b(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
801d:ENDPT


 TITLE 'CSD10B'
CSD10B BEGIN 0
*
*
* Function CSD10B
*
8000(9548F9 )CSD10B LDA+  X,-7       ; [Load A indexed, displaced, direct]
8003(5C     )      XAY              ; [Transfer A to Y]
8004(C561   )D8004 LDBB+ Y+         ; [Load BL indexed, direct, post-incremented]
8006(15FC   )      BNZ   D8004      ; =-4 [Branch if not zero]
8008(5160   )      SUB   Y,A        ; [Y - A -> A]
800a(39     )      DCA              ; [Decrement A]
800b(B30A   )      STA   W8017      ; =+10 [Store A relative]
800d(9548FB )      LDA+  X,-5       ; [Load A indexed, displaced, direct]
8010(461732+)      ZAD   /W8017(2),-A(8) ; =0x8017 =32791(-32745), [Zero-add bignum, direct, indexed]
8016(09     )      RSR              ; [Return from subroutine]
*
8017(0000   )W8017 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
8019(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
801b(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
801d(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
801f:ENDPT


 TITLE 'CSD11'
CSD11 BEGIN 0
*
*
* Function CSD11
*
8000(6646   )CSD11 SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8002(801F   )      DW    B801F      ; =0x801f =32799(-32737) [address of integer]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B314   )      STA   W801C      ; =+20 [Store A relative]
8008(B302   )      STA   W800C      ; =+2 [Store A relative]
800a(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
800c(0000   )W800C DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
800e(664A   )      SVC   74         ; =0x4A [Service call DV64 - CPL 64-bit divide]
8010(801F   )      DW    B801F      ; =0x801f =32799(-32737) [address of integer]
8012(6624   )      SVC   36         ; =0x24 [Service call MU - CPL 32-bit multiply]
8014(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1) [address of integer]
8016(6649   )      SVC   73         ; =0x49 [Service call MU64 - CPL 64-bit multiply]
8018(801F   )      DW    B801F      ; =0x801f =32799(-32737) [address of integer]
801a(6647   )      SVC   71         ; =0x47 [Service call AD64 - CPL 64-bit add]
801c(0000   )W801C DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
801e(09     )      RSR              ; [Return from subroutine]
*
801f(       )B801F DS    8          ; =0x0008 [Uninitialized memory]
*
8027(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8029(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
802b(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
802d:ENDPT


 TITLE 'CSD11B'
CSD11B BEGIN 0
*
*
* Function CSD11B
*
8000(D541   )CSD11B LDB+  X+         ; [Load B indexed, direct, post-incremented]
8002(5526   )      XFR   B,Y        ; [Transfer B to Y]
8004(3167   )      DCR   Y,8        ; [Decrement Y by 8]
8006(908014 )      LDA=  W8014      ; =0x8014 =32788(-32748) [Load A with immediate]
8009(46777A+)      DRM   -B(8),-Y(8) ; [Divide bignums with remainder, indexed, indexed]
800d(467732+)      ZAD   /W8014(8),-Y(8) ; =0x8014 =32788(-32748), [Zero-add bignum, direct, indexed]
8013(09     )      RSR              ; [Return from subroutine]
*
8014(       )W8014 DS    8          ; =0x0008 [Uninitialized memory]
*
801c(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
801e(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8020(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8022:ENDPT


 TITLE 'CSD12'
CSD12 BEGIN 0
*
*
* Function CSD12
*
8000(6646   )CSD12 SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8002(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B309   )      STA   W8011      ; =+9 [Store A relative]
8008(B317   )      STA   W8021      ; =+23 [Store A relative]
800a(3A     )      CLA              ; [Clear A]
800b(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
800d(B5A2   )D800D STA-  S-         ; [Store A indexed, pre-decremented, direct]
800f(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8011(0000   )W8011 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8013(6648   )      SVC   72         ; =0x48 [Service call SU64 - CPL 64-bit subtract]
8015(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
8017(6646   )      SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8019(8043   )P8019 DW    B8043      ; =0x8043 =32835(-32701) [address of integer]
801b(84FC   )      LDAB* P8019      ; =-4 [Load AL relative indirect]
801d(1708   )      BP    D8027      ; =+8 [Branch on plus]
801f(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8021(0000   )W8021 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8023(6646   )      SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8025(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
*
8027(93E8   )D8027 LDA   W8011      ; =-24 [Load A relative]
8029(D00008 )      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
802c(59     )      SAB              ; [A - B -> B]
802d(F3E2   )      STB   W8011      ; =-30 [Store B relative]
802f(F3F0   )      STB   W8021      ; =-16 [Store B relative]
8031(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8033(39     )      DCA              ; [Decrement A]
8034(15D7   )      BNZ   D800D      ; =-41 [Branch if not zero]
8036(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8038(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
803a(09     )      RSR              ; [Return from subroutine]
*
803b(       )B803B DS    8          ; =0x0008 [Uninitialized memory]
8043(       )B8043 DS    8          ; =0x0008 [Uninitialized memory]
*
804b(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
804d(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
804f(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8051:ENDPT


 TITLE 'CSD12B'
CSD12B BEGIN 0
*
*
* Function CSD12B
*
8000(D541   )CSD12B LDB+  X+         ; [Load B indexed, direct, post-incremented]
8002(467738+)      ZAD   -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Zero-add bignum, indexed, direct]
8008(3A     )      CLA              ; [Clear A]
8009(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
800b(B5A2   )D800B STA-  S-         ; [Store A indexed, pre-decremented, direct]
800d(3127   )      DCR   B,8        ; [Decrement B by 8]
800f(467728+)      C     -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Compare bignums, indexed, direct]
8015(1906   )      BLE   D801D      ; =+6 [Branch if less than or equal to zero]
8017(467738+)      ZAD   -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Zero-add bignum, indexed, direct]
801d(95A1   )D801D LDA+  S+         ; [Load A indexed, direct, post-incremented]
801f(29     )      DCAB             ; [Decrement AL]
8020(15E9   )      BNZ   D800B      ; =-23 [Branch if not zero]
8022(467732+)      ZAD   /N8029(8),-B(8) ; =0x8029 =32809(-32727), [Zero-add bignum, direct, indexed]
8028(09     )      RSR              ; [Return from subroutine]
*
8029(       )N8029 DS    8          ; =0x0008 [Uninitialized memory]
*
8031(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8033(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8035(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8037:ENDPT


 TITLE 'CSD13'
CSD13 BEGIN 0
*
*
* Function CSD13
*
8000(6646   )CSD13 SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8002(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
8004(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8006(B309   )      STA   W8011      ; =+9 [Store A relative]
8008(B317   )      STA   W8021      ; =+23 [Store A relative]
800a(3A     )      CLA              ; [Clear A]
800b(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
800d(B5A2   )D800D STA-  S-         ; [Store A indexed, pre-decremented, direct]
800f(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8011(0000   )W8011 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8013(6648   )      SVC   72         ; =0x48 [Service call SU64 - CPL 64-bit subtract]
8015(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
8017(6646   )      SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8019(8043   )P8019 DW    B8043      ; =0x8043 =32835(-32701) [address of integer]
801b(84FC   )      LDAB* P8019      ; =-4 [Load AL relative indirect]
801d(1608   )      BM    D8027      ; =+8 [Branch on minus]
801f(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8021(0000   )W8021 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of integer]
8023(6646   )      SVC   70         ; =0x46 [Service call ST64 - CPL 64-bit store]
8025(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
*
8027(93E8   )D8027 LDA   W8011      ; =-24 [Load A relative]
8029(D00008 )      LDB=  X'0008'    ; =0x0008 =8 [Load B with immediate]
802c(59     )      SAB              ; [A - B -> B]
802d(F3E2   )      STB   W8011      ; =-30 [Store B relative]
802f(F3F0   )      STB   W8021      ; =-16 [Store B relative]
8031(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8033(39     )      DCA              ; [Decrement A]
8034(15D7   )      BNZ   D800D      ; =-41 [Branch if not zero]
8036(6645   )      SVC   69         ; =0x45 [Service call LD64 - CPL 64-bit load]
8038(803B   )      DW    B803B      ; =0x803b =32827(-32709) [address of integer]
803a(09     )      RSR              ; [Return from subroutine]
*
803b(       )B803B DS    8          ; =0x0008 [Uninitialized memory]
8043(       )B8043 DS    8          ; =0x0008 [Uninitialized memory]
*
804b(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
804d(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
804f(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8051:ENDPT


 TITLE 'CSD13B'
CSD13B BEGIN 0
*
*
* Function CSD13B
*
8000(D541   )CSD13B LDB+  X+         ; [Load B indexed, direct, post-incremented]
8002(467738+)      ZAD   -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Zero-add bignum, indexed, direct]
8008(3A     )      CLA              ; [Clear A]
8009(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
800b(B5A2   )D800B STA-  S-         ; [Store A indexed, pre-decremented, direct]
800d(3127   )      DCR   B,8        ; [Decrement B by 8]
800f(467728+)      C     -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Compare bignums, indexed, direct]
8015(1706   )      BP    D801D      ; =+6 [Branch on plus]
8017(467738+)      ZAD   -B(8),/N8029(8) ; =0x8029 =32809(-32727) [Zero-add bignum, indexed, direct]
801d(95A1   )D801D LDA+  S+         ; [Load A indexed, direct, post-incremented]
801f(29     )      DCAB             ; [Decrement AL]
8020(15E9   )      BNZ   D800B      ; =-23 [Branch if not zero]
8022(467732+)      ZAD   /N8029(8),-B(8) ; =0x8029 =32809(-32727), [Zero-add bignum, direct, indexed]
8028(09     )      RSR              ; [Return from subroutine]
*
8029(       )N8029 DS    8          ; =0x0008 [Uninitialized memory]
*
8031(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8033(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8035(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8037:ENDPT


 TITLE 'CSD14'
CSD14 BEGIN 0
*
 ENT CSD14A
*
 EXT @LI
*
*
* Function CSD14
*
8000(3141   )CSD14 DCR   X,2        ; [Decrement X by 2]
8002(7B4A   )      JSR   F804E      ; =+74 [Jump to subroutine relative]
8004(32     )      DB    X'32'      ; =0x32 =50
8005(D0EEEE )      LDB=  @LI        ; [external symbol] [Load B with immediate]
8008(8521   )D8008 LDAB+ B+         ; [Load AL indexed, direct, post-incremented]
800a(15FC   )      BNZ   D8008      ; =-4 [Branch if not zero]
800c(3120   )      DCR   B          ; [Decrement B by 1]
800e(7E21   )      STK   B,2        ; [Push B to the stack]
8010(908D00 )      LDA=  X'8D00'    ; =0x8d00 =36096(-29440) =CR,NUL [Load A with immediate]
8013(B521   )      STA+  B+         ; [Store A indexed, direct, post-incremented]
8015(7D40   )      JSR+  X          ; [Jump to subroutine indexed, direct]
8017(7F21   )      POP   B,2        ; [Pop B from the stack]
8019(2A     )      CLAB             ; [Clear AL]
801a(A9     )      STAB+ B          ; [Store AL to address in B]
801b(735D   )      JMP   D807A      ; =+93 [Jump relative]
*
* Function CSD14A
*
801d(3141   )CSD14A DCR   X,2        ; [Decrement X by 2]
801f(7B2D   )      JSR   F804E      ; =+45 [Jump to subroutine relative]
8021(33     )      DB    X'33'      ; =0x33 =51
8022(90EEEE )      LDA=  @LI        ; [external symbol] [Load A with immediate]
8025(5C     )      XAY              ; [Transfer A to Y]
8026(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8028(900084 )      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
802b(E561   )D802B STBB+ Y+         ; [Store BL indexed, direct, post-incremented]
802d(39     )      DCA              ; [Decrement A]
802e(15FB   )      BNZ   D802B      ; =-5 [Branch if not zero]
8030(AB     )      STAB+ Y          ; [Store AL to address in Y]
8031(7E61   )      STK   Y,2        ; [Push Y to the stack]
8033(7D40   )      JSR+  X          ; [Jump to subroutine indexed, direct]
8035(7F61   )      POP   Y,2        ; [Pop Y from the stack]
8037(900084 )      LDA=  X'0084'    ; =0x0084 =132 =NUL,EOT [Load A with immediate]
803a(D0A0A0 )      LDB=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load B with immediate]
803d(C562   )D803D LDBB- Y-         ; [Load BL indexed, pre-decremented, direct]
803f(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
8041(1505   )      BNZ   D8048      ; =+5 [Branch if not zero]
8043(39     )      DCA              ; [Decrement A]
8044(15F7   )      BNZ   D803D      ; =-9 [Branch if not zero]
8046(3160   )      DCR   Y          ; [Decrement Y by 1]
8048(2A     )D8048 CLAB             ; [Clear AL]
8049(A56801 )      STAB+ Y,1        ; [Store AL indexed, displaced, direct]
804c(732C   )      JMP   D807A      ; =+44 [Jump relative]
*
* Function F804E
*
804e(C541   )F804E LDBB+ X+         ; [Load BL indexed, direct, post-incremented]
8050(6B26   )      STX   W8077+1    ; =+38 [Store X relative]
8052(65A1   )      LDX+  S+         ; [Load X indexed, direct, post-incremented]
8054(680000 )W8054 STX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store X immediate]
8057(9A     )      LDA+  X          ; [Load A from address in X]
8058(B00000 )W8058 STA=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store A immediate]
805b(8066   )      LDAB= X'66'      ; =102 [Load AL with immediate]
805d(A541   )      STAB+ X+         ; [Store AL indexed, direct, post-incremented]
805f(E541   )      STBB+ X+         ; [Store BL indexed, direct, post-incremented]
8061(90EEEE )      LDA=  @LI        ; [external symbol] [Load A with immediate]
8064(B541   )      STA+  X+         ; [Store A indexed, direct, post-incremented]
8066(3041   )      INR   X,2        ; [Increment X by 2]
8068(9541   )D8068 LDA+  X+         ; [Load A indexed, direct, post-incremented]
806a(15FC   )      BNZ   D8068      ; =-4 [Branch if not zero]
806c(8A     )      LDAB+ X          ; [Load AL from address in X]
806d(A000   )B806D STAB= X'00'      ; =0 =NUL [Store AL immediate]
806f(8009   )      LDAB= X'09'      ; =9 [Load AL with immediate]
8071(AA     )      STAB+ X          ; [Store AL to address in X]
8072(680000 )W8072 STX=  X'0000'    ; =0x0000 =0 =NUL,NUL [Store X immediate]
8075(63DE   )      LDX   W8054+1    ; =-34 [Load X relative]
8077(710000 )W8077 JMP/  X'0000'    ; =0x0000 =0 =NUL,NUL [Jump direct]
807a(63D9   )D807A LDX   W8054+1    ; =-39 [Load X relative]
807c(93DB   )      LDA   W8058+1    ; =-37 [Load A relative]
807e(BA     )      STA+  X          ; [Store A to address in X]
807f(63F2   )      LDX   W8072+1    ; =-14 [Load X relative]
8081(83EB   )      LDAB  B806D+1    ; =-21 [Load AL relative]
8083(AA     )      STAB+ X          ; [Store AL to address in X]
8084(09     )      RSR              ; [Return from subroutine]
*
8085(6656   )      SVC   86         ; =0x56 [Service call FSVC - fake SVC call]
8087(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8089(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
808b:ENDPT
