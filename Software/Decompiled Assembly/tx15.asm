 TITLE '@TX015'
@TX015 BEGIN 0
*
*
* Function ENTRY
*
8000(59     )ENTRY SAB              ; [A - B -> B]
8001(140A   )      BZ    D800D      ; =+10 [Branch if zero]
8003(3205   )      CLR   A,5        ; [Set A to 5]
8005(5542   )      XFR   X,B        ; [Transfer X to B]
8007(6609   )      SVC   9          ; =0x09 [Service call ABRT - abort task]
8009(09     )      DB    X'09'      ; =0x09 =9 [abort code]
*
800a(6609   )D800A SVC   9          ; =0x09 [Service call ABRT - abort task]
800c(2F     )      DB    X'2F'      ; =0x2f =47 [abort code]
*
800d(8541   )D800D LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
800f(A31E   )      STAB  B802F      ; =+30 [Store AL relative]
8011(8541   )      LDAB+ X+         ; [Load AL indexed, direct, post-incremented]
8013(A31F   )      STAB  B8034      ; =+31 [Store AL relative]
8015(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
8017(B317   )      STA   B802F+1    ; =+23 [Store A relative]
8019(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
801b(B315   )      STA   W8032      ; =+21 [Store A relative]
801d(51127F+)      SUB=  X'7FFF',A,B ; =0x7fff =32767 [32767 - A -> B]
8021(1106   )      BNL   D8029      ; =+6 [Branch on no link]
8023(5D     )      XAB              ; [Transfer A to B]
8024(5540   )      XFR   X,A        ; [Transfer X to A]
8026(6609   )      SVC   9          ; =0x09 [Service call ABRT - abort task]
8028(17     )      DB    X'17'      ; =0x17 =23 [abort code]
*
8029(664C   )D8029 SVC   76         ; =0x4C [Service call DIO - disk I/O]
802b(0190   )      DW    X'0190'    ; =0x0190 =400 [Selector: TODO]
802d(8051   )      DW    W8051      ; =0x8051 =32849(-32687) [TODO: arg1]
802f(FF00   )B802F DW    X'FF00'    ; =0xff00 =65280(-256) [TODO: arg2]
8031(00     )      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
8032(0000   )W8032 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [TODO: arg4]
8034(00     )B8034 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg5]
8035(6DA2   )      STX-  S-         ; [Store X indexed, pre-decremented, direct]
8037(46012C+)      C     =16,/B802F+1(2) ; =0x8030 =32816(-32720) [Compare bignums, literal=0x10, direct]
803d(140C   )      BZ    D804B      ; =+12 [Branch if zero]
803f(63F1   )      LDX   W8032      ; =-15 [Load X relative]
8041(954801 )      LDA+  X,1        ; [Load A indexed, displaced, direct]
8044(14C4   )      BZ    D800A      ; =-60 [Branch if zero]
8046(954803 )      LDA+  X,3        ; [Load A indexed, displaced, direct]
8049(14BF   )      BZ    D800A      ; =-65 [Branch if zero]
804b(65A1   )D804B LDX+  S+         ; [Load X indexed, direct, post-incremented]
804d(6601   )      SVC   1          ; =0x01 [Service call TRTN - transient return]
804f(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1) [return code]
8051(8059   )W8051 DW    W8059      ; =0x8059 =32857(-32679)
8053(000000+)      DB    0,6        ; =0x00,0x0006
8059(0100   )W8059 DW    X'0100'    ; =0x0100 =256
805b(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1)
805d(0F00   )      DW    X'0F00'    ; =0x0f00 =3840
805f(000000+)      DB    0,37       ; =0x00,0x0025
8084(8086   )      DW    S8086      ; =0x8086 =32902(-32634)
8086(000000 )S8086 DB    0,3        ; =0x00,0x0003
8089:ENDPT
