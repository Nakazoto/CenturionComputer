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
8000:ENTRY JMP/  J8DFF      ; =0x8dff =36351(-29185) [Jump direct]
*
8003:      DB    0,100      ; =0x00,0x0064
8067:W8067 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8069:W8069 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
806b:W806B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
806d:W806D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
806f:S806F DB    0,392      ; =0x00,0x0188
81f7:S81F7 DB    0,400      ; =0x00,0x0190
8387:W8387 DB    X'00'      ; =0x00 =0 =NUL
8388:B8388 DB    X'00'      ; =0x00 =0 =NUL
8389:W8389 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
838b:N838B DB    X'00'      ; =0x00 =0 =NUL
838c:S838C DB    0,3        ; =0x00,0x0003
838f:S838F DB    0,3        ; =0x00,0x0003
8392:B8392 DB    X'00'      ; =0x00 =0 =NUL
8393:W8393 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8395:W8395 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8397:W8397 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8399:W8399 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
839b:W839B DW    X'0000'    ; =0x0000 =0 =NUL,NUL
839d:B839D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
839f:W839F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83a1:W83A1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83a3:W83A3 DB    X'00'      ; =0x00 =0 =NUL
83a4:W83A4 DB    X'00'      ; =0x00 =0 =NUL
83a5:W83A5 DB    X'00'      ; =0x00 =0 =NUL
83a6:W83A6 DB    X'00'      ; =0x00 =0 =NUL
83a7:W83A7 DB    X'00'      ; =0x00 =0 =NUL
83a8:W83A8 DB    X'00'      ; =0x00 =0 =NUL
83a9:W83A9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83ab:N83AB DB    0,4        ; =0x00,0x0004
83af:W83AF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83b1:W83B1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
83b3:W83B3 DB    X'00'      ; =0x00 =0 =NUL
83b4:W83B4 DW    X'0051'    ; =0x0051 =81
83b6:S83B6 DB    0,80       ; =0x00,0x0050
8406:      DB    X'8D'      ; =0x8d =141(-115) =CR
8407:W8407 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8409:S8409 DB    0,6        ; =0x00,0x0006
840f:N840F DB    0,6        ; =0x00,0x0006
8415:S8415 DB    0,8        ; =0x00,0x0008
841d:W841D DW    X'0000'    ; =0x0000 =0 =NUL,NUL
841f:W841F DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8421:W8421 DW    X'0190'    ; =0x0190 =400
8423:      DB    0,401      ; =0x00,0x0191
85b4:W85B4 DW    X'0060'    ; =0x0060 =96
85b6:      DC    'FLOPPY-SSDD '
85c2:      DB    X'00'      ; =0x00 =0 =NUL
85c3:      DC    '@FLOPPY-DSDD '
85d0:      DW    X'032A'    ; =0x032a =810
85d2:      DC    'HAWK/PERTEC '
85de:      DW    X'0803'    ; =0x0803 =2051
85e0:      DC    'CMD-I  2051T'
85ec:      DB    X'08'      ; =0x08 =8
85ed:      DC    'QCMDIII 2257T'
85fa:      DB    X'0C'      ; =0x0c =12
85fb:      DC    'RFINCH - 24MB'
8608:      DW    X'1118'    ; =0x1118 =4376
860a:      DC    'FINCH - 32MB'
8616:      DW    X'155E'    ; =0x155e =5470
8618:      DC    'FINCH - 40MB'
8624:      DW    X'FFFF'    ; =0xffff =65535(-1)
8626:      DC    'CMD-I  2051T'
8632:      DB    X'00'      ; =0x00 =0 =NUL
8633:      DB    X'00'      ; =0x00 =0 =NUL
8634:W8634 DW    X'0730'    ; =0x0730 =1840
8636:      DB    X'0C'      ; =0x0c =12
8637:S8637 DC    'STATUS DISPLAY REV 7.13    SYSTEM DATE: '
865f:S865F DC    '              TOTAL SYSTEM RAM '
867e:S867E DC    '@#@K          MAXIMUM TRANSIENT SIZE '
86a3:S86A3 DC    '@#@K                            OPSYS SIZE '
86ce:S86CE DC    '@#@K                  TRANSIENT USED '
86f3:S86F3 DC    '@#@.@@@K                   PARTITION SIZES '
871e:S871E DC    '@#@K                  TRANSIENT USED '
8743:S8743 DC    '@#@.@@@%               TRANSIENT ALLOCATED '
876e:S876E DC    '@#@K     ' ; hex:c0a3c0cba0a0a0a0a0
8777:S8777 DC    '     BASIC MONITOR LOADED                             MEMORY'
87b3:      DC    ' AVAILABLE '
87be:S87BE DC    '@#@K                                                        '
87fa:      DC    '                                  V O L U M E             D '
8836:      DC    'I S K          P A R T I T I O N        J O B     # NAME    '
8872:      DC    '     DATE   TYPE / SIZE / FLAGS  NUM DEVICE BUF PRI SIZ NAME'
88ae:      DC    '    FLAGS                                                   '
88ea:      DC    '                             '
8907:S8907 DC    ' '        ; hex:a0 dec:160(-96)
8908:S8908 DC    '                                                            '
8944:      DC    '                                                            '
8980:      DC    '                                                            '
89bc:      DC    '                                                            '
89f8:      DC    '                                                            '
8a34:      DC    '                                                            '
8a70:      DC    '                                                            '
8aac:      DC    '                                                            '
8ae8:      DC    '                                                            '
8b24:      DC    '                                                            '
8b60:      DC    '                                                            '
8b9c:      DC    '                                                            '
8bd8:      DC    '                                                            '
8c14:      DC    '                                                            '
8c50:      DC    '                                                            '
8c8c:      DC    '                                                            '
8cc8:      DC    '                                                            '
8d04:      DC    '                   '
8d17:S8D17 DC    '                              (NEWLINE TO CONTINUE)'
8d4a:      DB    X'8D'      ; =0x8d =141(-115) =CR
8d4b:W8D4B DW    W8D53      ; =0x8d53 =36179(-29357)
8d4d:      DB    0,6        ; =0x00,0x0006
8d53:W8D53 DW    X'0100'    ; =0x0100 =256
8d55:      DW    X'FFFF'    ; =0xffff =65535(-1)
8d57:      DW    X'0F00'    ; =0x0f00 =3840
8d59:      DB    0,37       ; =0x00,0x0025
8d7e:      DW    W8D80      ; =0x8d80 =36224(-29312)
8d80:W8D80 DB    X'00'      ; =0x00 =0 =NUL
8d81:W8D81 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8d83:W8D83 DW    X'0082'    ; =0x0082 =130
8d85:      DW    X'2202'    ; =0x2202 =8706
8d87:      DW    X'0780'    ; =0x0780 =1920
8d89:      DW    W8634      ; =0x8634 =34356(-31180)
8d8b:      DB    0,4        ; =0x00,0x0004
8d8f:W8D8F DW    X'0081'    ; =0x0081 =129
8d91:      DB    X'00'      ; =0x00 =0 =NUL
8d92:      DW    X'0100'    ; =0x0100 =256
8d94:      DB    X'01'      ; =0x01 =1
8d95:      DW    S8409      ; =0x8409 =33801(-31735)
8d97:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8d99:W8D99 DW    X'0082'    ; =0x0082 =130
8d9b:      DW    X'2202'    ; =0x2202 =8706
8d9d:      DW    X'0190'    ; =0x0190 =400
8d9f:      DW    W8421      ; =0x8421 =33825(-31711)
8da1:      DB    0,3        ; =0x00,0x0003
8da4:      DW    X'0102'    ; =0x0102 =258
8da6:      DW    X'0200'    ; =0x0200 =512
8da8:      DB    X'51'      ; =0x51 =81
8da9:      DW    W83B4      ; =0x83b4 =33716(-31820)
8dab:      DB    0,12       ; =0x00,0x000c
8db7:W8DB7 DW    X'0082'    ; =0x0082 =130
8db9:      DW    X'2202'    ; =0x2202 =8706
8dbb:      DB    0,8        ; =0x00,0x0008
8dc3:      DW    X'0102'    ; =0x0102 =258
8dc5:      DW    X'0051'    ; =0x0051 =81
8dc7:      DW    W83B4      ; =0x83b4 =33716(-31820)
8dc9:      DB    0,14       ; =0x00,0x000e
8dd7:      DW    X'0E81'    ; =0x0e81 =3713
8dd9:      DB    X'00'      ; =0x00 =0 =NUL
8dda:      DW    X'8300'    ; =0x8300 =33536(-32000)
8ddc:      DW    X'8F0E'    ; =0x8f0e =36622(-28914)
8dde:      DB    X'00'      ; =0x00 =0 =NUL
8ddf:      DW    X'0190'    ; =0x0190 =400
8de1:      DW    X'920F'    ; =0x920f =37391(-28145)
8de3:      DB    X'00'      ; =0x00 =0 =NUL
8de4:      DW    X'0190'    ; =0x0190 =400
8de6:      DW    W8067      ; =0x8067 =32871(-32665)
8de8:      DW    X'0320'    ; =0x0320 =800
8dea:      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8dec:      DW    X'0E81'    ; =0x0e81 =3713
8dee:      DB    X'00'      ; =0x00 =0 =NUL
8def:      DW    X'8300'    ; =0x8300 =33536(-32000)
8df1:      DW    X'8E0E'    ; =0x8e0e =36366(-29170)
8df3:      DB    X'00'      ; =0x00 =0 =NUL
8df4:      DW    X'0190'    ; =0x0190 =400
8df6:      DW    X'8E0F'    ; =0x8e0f =36367(-29169)
8df8:      DB    X'00'      ; =0x00 =0 =NUL
8df9:      DW    X'0190'    ; =0x0190 =400
8dfb:      DW    W8067      ; =0x8067 =32871(-32665)
8dfd:      DW    X'0320'    ; =0x0320 =800
*
8dff:J8DFF XFR=  W8067,S    ; =0x8067 =32871(-32665) [Transfer immediate to S]
8e03:      SVC   X'0D'      ; =13 [Service call JXM - protected change to JX map]
8e05:      SVC   X'0B'      ; =11 [Service call DT - get binary date]
8e07:      SVC   X'05'      ; =5 [Service call TS - load transient module]
8e09:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8e0a:      DW    S865F      ; =0x865f =34399(-31137) [address of string date]
8e0c:      MVF   (8)/S865F,/X'0128' ; =0x865f =34399(-31137),=0x0128 =296 [Move fixed-length, direct, direct]
8e13:      MVF   (8)/X'0128',/S865F ; =0x0128 =296,=0x865f =34399(-31137) [Move fixed-length, direct, direct]
8e1a:      LDA/  X'0103'    ; =0x0103 =259 [Load A direct]
8e1d:      STA/  W8397      ; =0x8397 =33687(-31849) [Store A direct]
8e20:      XAY              ; [Transfer A to Y]
8e21:      LDA+  Y,8        ; [Load A indexed, displaced, direct]
8e24:      LDAB+ A,24       ; [Load AL indexed, displaced, direct]
8e27:      STAB/ B8392      ; =0x8392 =33682(-31854) [Store AL direct]
8e2a:      LDB=  W8D83      ; =0x8d83 =36227(-29309) [Load B with immediate]
8e2d:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
8e2f:      DB    X'01'      ; =0x01 =1 [TODO: arg1]
8e30:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
8e31:      DB    X'01'      ; =0x01 =1 [TODO: arg3]
8e32:      DW    W83B3      ; =0x83b3 =33715(-31821) [address to store block value]
8e34:      CAD/  W8407      ; [Clear word at address]
8e38:      LDA=  W8DB7      ; =0x8db7 =36279(-29257) =CR,'7' [Load A with immediate]
8e3b:      STA/  W841F      ; =0x841f =33823(-31713) [Store A direct]
8e3e:      LDAB/ W83B3      ; =0x83b3 =33715(-31821) [Load AL direct]
8e41:      DCRB  AL,4       ; [Decrement AL by 4]
8e43:      BNZ   D8E58      ; =+19 [Branch if not zero]
8e45:      XFR/  X'0103',Y  ; =0x0103 =259 [Transfer direct to Y]
8e49:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
8e4c:      LDA+  A,7        ; [Load A indexed, displaced, direct]
8e4f:      STA/  W841D      ; =0x841d =33821(-31715) [Store A direct]
8e52:      LDA=  W8D99      ; =0x8d99 =36249(-29287) [Load A with immediate]
8e55:      STA/  W841F      ; =0x841f =33823(-31713) [Store A direct]
8e58:D8E58 JSR/  F8EF4      ; =0x8ef4 =36596(-28940) [Jump to subroutine direct]
8e5b:      CAD/  S838F      ; [Clear word at address]
8e5f:      CAD/  W8387      ; [Clear word at address]
8e63:      CAD/  W8389      ; [Clear word at address]
8e67:      CAD/  W8399      ; [Clear word at address]
8e6b:J8E6B JSR/  F905A      ; =0x905a =36954(-28582) [Jump to subroutine direct]
8e6e:      JSR/  F92D7      ; =0x92d7 =37591(-27945) [Jump to subroutine direct]
8e71:      LDA/  W8399      ; =0x8399 =33689(-31847) [Load A direct]
8e74:      BZ    D8E9D      ; =+39 [Branch if zero]
8e76:      JSR/  F9422      ; =0x9422 =37922(-27614) [Jump to subroutine direct]
8e79:      LDAB/ W83B3      ; =0x83b3 =33715(-31821) [Load AL direct]
8e7c:      DCRB  AL,2       ; [Decrement AL by 2]
8e7e:      BNZ   D8E8F      ; =+15 [Branch if not zero]
8e80:      LDA/  W8397      ; =0x8397 =33687(-31849) [Load A direct]
8e83:      LDA+  A,8        ; [Load A indexed, displaced, direct]
8e86:      LDB=  W8D8F      ; =0x8d8f =36239(-29297) [Load B with immediate]
8e89:      SVC   X'0F'      ; =15 [Service call CONIO - console I/O]
8e8b:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
8e8d:      DW    W8D8F      ; =0x8d8f =36239(-29297) [TODO: arg 1]
*
8e8f:D8E8F JSR/  F8EE3      ; =0x8ee3 =36579(-28957) [Jump to subroutine direct]
8e92:      CAD/  W8399      ; [Clear word at address]
8e96:      CAD/  S838F      ; [Clear word at address]
8e9a:      JMP/  J8E6B      ; =0x8e6b =36459(-29077) [Jump direct]
8e9d:D8E9D MVF   (2)/W83A1,/S838F ; =0x83a1 =33697(-31839),=0x838f =33679(-31857) [Move fixed-length, direct, direct]
8ea4:      C     /W839F(2),/W83A1(2) ; =0x839f =33695(-31841),=0x83a1 =33697(-31839) [Compare bignums, direct, direct]
8eab:      BGZ   D8EB4      ; =+7 [Branch if greater than zero]
8ead:      MVF   (2)/W839F,/S838F ; =0x839f =33695(-31841),=0x838f =33679(-31857) [Move fixed-length, direct, direct]
8eb4:D8EB4 JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
8eb7:      LDAB= X'8D'      ; =141(-115) =CR [Load AL with immediate]
8eb9:      STAB+ Z          ; [Store AL to address in Z]
8eba:      JSR/  F9422      ; =0x9422 =37922(-27614) [Jump to subroutine direct]
8ebd:      XFR/  W841D,Y    ; =0x841d =33821(-31715) [Transfer direct to Y]
8ec1:      BZ    D8EE0      ; =+29 [Branch if zero]
8ec3:      LDAB= X'0B'      ; =11 [Load AL with immediate]
8ec5:      LDB/  W841F      ; =0x841f =33823(-31713) [Load B direct]
8ec8:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
8ecb:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
8ecd:      XFR/  W841D,Y    ; =0x841d =33821(-31715) [Transfer direct to Y]
8ed1:      XFR/  W841F,Z    ; =0x841f =33823(-31713) [Transfer direct to Z]
8ed5:      CLA              ; [Clear A]
8ed6:      STA+  Y,6        ; [Store A indexed, displaced, direct]
8ed9:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
8edc:      INA              ; [Increment A]
8edd:      STA+  Y,4        ; [Store A indexed, displaced, direct]
8ee0:D8EE0 SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
8ee2:      DB    X'FF'      ; =0xff =255(-1) [completion code]
*
* Function F8EE3
*
8ee3:F8EE3 LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
8ee5:      STAB/ S8907      ; =0x8907 =35079(-30457) [Store AL direct]
8ee8:      LDB=  S8907      ; =0x8907 =35079(-30457) [Load B with immediate]
8eeb:      XFR=  S8908,Y    ; =0x8908 =35080(-30456) [Transfer immediate to Y]
8eef:      LDA=  X'040E'    ; =0x040e =1038 [Load A with immediate]
8ef2:      MVL              ; [Move long (len in A, src in B, dst in Y)]
8ef3:      RSR              ; [Return from subroutine]
*
* Function F8EF4
*
8ef4:F8EF4 CAD/  W839B      ; [Clear word at address]
8ef8:      XFR=  X'0010',Z  ; =0x0010 =16 [Transfer immediate to Z]
8efc:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
8eff:      ADD=  X'0044',A,Y ; =0x0044 =68 [68 + A -> Y]
8f03:D8F03 LDA+  Y+         ; [Load A indexed, direct, post-incremented]
8f05:      LDB=  X'0010'    ; =0x0010 =16 [Load B with immediate]
8f08:D8F08 SLA              ; [Left shift A]
8f09:      BL    D8F0F      ; =+4 [Branch on link]
8f0b:      INC/  W839B      ; =0x839b =33691(-31845) [Increment word at address by 1]
8f0f:D8F0F DCR   B          ; [Decrement B by 1]
8f11:      BGZ   D8F08      ; =-11 [Branch if greater than zero]
8f13:      DCR   Z          ; [Decrement Z by 1]
8f15:      BGZ   D8F03      ; =-20 [Branch if greater than zero]
8f17:      LDA/  W839B      ; =0x839b =33691(-31845) [Load A direct]
8f1a:      SLA              ; [Left shift A]
8f1b:      STA/  W839B      ; =0x839b =33691(-31845) [Store A direct]
8f1e:      LDAB= X'04'      ; =4 [Load AL with immediate]
8f20:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8f22:      CFB   /S87BE(10),/W839B(2) ; =0x87be =34750(-30786) =BEL,'>',=0x839b =33691(-31845) [Convert from bignum, direct, direct]
8f29:      LDA/  X'017D'    ; =0x017d =381 [Load A direct]
8f2c:      JSR/  F9051      ; =0x9051 =36945(-28591) [Jump to subroutine direct]
8f2f:      CFB   /S867E(10),/S8409(2) ; =0x867e =34430(-31106),=0x8409 =33801(-31735) [Convert from bignum, direct, direct]
8f36:      ZAD   /S8409(2),/N83AB(4) ; =0x8409 =33801(-31735),=0x83ab =33707(-31829) [Zero-add bignum, direct, direct]
8f3d:      S     /W839B(2),/N83AB(4) ; =0x839b =33691(-31845),=0x83ab =33707(-31829) [Subtract bignums, direct, direct]
8f44:      LDA/  X'017F'    ; =0x017f =383 [Load A direct]
8f47:      JSR/  F9051      ; =0x9051 =36945(-28591) [Jump to subroutine direct]
8f4a:      CFB   /S86A3(10),/S8409(2) ; =0x86a3 =34467(-31069),=0x8409 =33801(-31735) [Convert from bignum, direct, direct]
8f51:      LDA/  X'0181'    ; =0x0181 =385 [Load A direct]
8f54:      JSR/  F9051      ; =0x9051 =36945(-28591) [Jump to subroutine direct]
8f57:      CFB   /S876E(10),/S8409(2) ; =0x876e =34670(-30866),=0x8409 =33801(-31735) [Convert from bignum, direct, direct]
8f5e:      S     /S8409(2),/N83AB(4) ; =0x8409 =33801(-31735),=0x83ab =33707(-31829) [Subtract bignums, direct, direct]
8f65:      CLR   Z          ; [Clear Z]
8f67:      LDA$  X'0183'    ; =0x0183 =387 [Load A indirect]
8f6a:D8F6A LDBB+ A,4        ; [Load BL indexed, displaced, direct]
8f6d:      BM    D8F74      ; =+5 [Branch on minus]
8f6f:      LDB+  A,2        ; [Load B indexed, displaced, direct]
8f72:      ADD   B,Z        ; [B + Z -> Z]
8f74:D8F74 LDB+  A          ; [Load B from address in A]
8f75:      BZ    D8F7B      ; =+4 [Branch if zero]
8f77:      XFR   B,A        ; [Transfer B to A]
8f79:      JMP   D8F6A      ; =-17 [Jump relative]
8f7b:D8F7B ADD=  X'006F',Z  ; =0x006f =111 [111 + Z -> Z]
8f7f:      STR/  W83AF,Z    ; =0x83af =33711(-31825) [Store Z direct]
8f83:      ZAD   /W83AF(2),/S8409(4) ; =0x83af =33711(-31825),=0x8409 =33801(-31735) [Zero-add bignum, direct, direct]
8f8a:      M     =10000,/S8409(4) ; =0x8409 =33801(-31735) [Multiply bignums, literal=0x2710, direct]
8f91:      D     =1024,/S8409(4) ; =0x8409 =33801(-31735) [Divide bignums, literal=0x0400, direct]
8f98:      A     =5,/S8409(4) ; =0x8409 =33801(-31735) [Add bignums, literal=0x05, direct]
8f9e:      D     =10,/S8409(4) ; =0x8409 =33801(-31735) [Divide bignums, literal=0x0a, direct]
8fa4:      LDAB= X'07'      ; =7 [Load AL with immediate]
8fa6:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8fa8:      CFB   /S86F3(10),/S8409(4) ; =0x86f3 =34547(-30989),=0x8409 =33801(-31735) [Convert from bignum, direct, direct]
8faf:      ZAD   /X'0181'(2),/S8409(4) ; =0x0181 =385,=0x8409 =33801(-31735) [Zero-add bignum, direct, direct]
8fb6:      M     =2048,/S8409(4) ; =0x8409 =33801(-31735) [Multiply bignums, literal=0x0800, direct]
8fbd:      ZAD   /W83AF(2),/N840F(6) ; =0x83af =33711(-31825),=0x840f =33807(-31729) [Zero-add bignum, direct, direct]
8fc4:      M     =1000000,/N840F(6) ; =0x840f =33807(-31729) [Multiply bignums, literal=0x0f4240, direct]
8fcc:      D     /S8409(4),/N840F(6) ; =0x8409 =33801(-31735),=0x840f =33807(-31729) [Divide bignums, direct, direct]
8fd3:      A     =5,/N840F(6) ; =0x840f =33807(-31729) [Add bignums, literal=0x05, direct]
8fd9:      D     =10,/N840F(6) ; =0x840f =33807(-31729) [Divide bignums, literal=0x0a, direct]
8fdf:      LDAB= X'07'      ; =7 [Load AL with immediate]
8fe1:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
8fe3:      CFB   /S8743(10),/N840F(6) ; =0x8743 =34627(-30909),=0x840f =33807(-31729) [Convert from bignum, direct, direct]
8fea:      ZAD   =0,/S8409(4) ; =0x8409 =33801(-31735) [Zero-add bignum, literal=0x00, direct]
8ff0:      MVF   (2)/X'0107',/W8395 ; =0x0107 =263,=0x8395 =33685(-31851) [Move fixed-length, direct, direct]
8ff7:D8FF7 LDA$  W8395      ; =0x8395 =33685(-31851) [Load A indirect]
8ffa:      BZ    D9026      ; =+42 [Branch if zero]
8ffc:      ZAD   -A,12(2),/N840F(4) ; =0x840f =33807(-31729) [Zero-add bignum, displaced indexed, direct]
9003:      BP    D9020      ; =+27 [Branch on plus]
9005:      S     -A,10(2),/N840F(4) ; =0x840f =33807(-31729) [Subtract bignums, displaced indexed, direct]
900c:      A     =1,/N840F(4) ; =0x840f =33807(-31729) [Add bignums, literal=0x01, direct]
9012:      D     =1024,/N840F(4) ; =0x840f =33807(-31729) [Divide bignums, literal=0x0400, direct]
9019:      A     /N840F(4),/S8409(4) ; =0x840f =33807(-31729),=0x8409 =33801(-31735) [Add bignums, direct, direct]
9020:D9020 INC/  W8395,2    ; =0x8395 =33685(-31851) [Increment word at address by 2]
9024:      JMP   D8FF7      ; =-47 [Jump relative]
9026:D9026 LDAB= X'03'      ; =3 [Load AL with immediate]
9028:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
902a:      CFB   /S871E(10),/S8409(4) ; =0x871e =34590(-30946),=0x8409 =33801(-31735) [Convert from bignum, direct, direct]
9031:      S     /S8409(4),/N83AB(4) ; =0x8409 =33801(-31735),=0x83ab =33707(-31829) [Subtract bignums, direct, direct]
9038:      JSR   F9055      ; =+27 [Jump to subroutine relative]
903a:      CFB   /S86CE(10),/N83AB(4) ; =0x86ce =34510(-31026),=0x83ab =33707(-31829) [Convert from bignum, direct, direct]
9041:      CPF   (2)=X'0000',/X'0139' ; =0x0139 =313 [Compare fixed-length, literal=0, direct]
9048:      BNZ   D9050      ; =+6 [Branch if not zero]
904a:      FIL   (40)=' ',/S8777 ; =0x8777 =34679(-30857) [Fill with byte, literal=0xa0(160,-96), direct]
9050:D9050 RSR              ; [Return from subroutine]
*
* Function F9051
*
9051:F9051 SLA              ; [Left shift A]
9052:      STA/  S8409      ; =0x8409 =33801(-31735) [Store A direct]
*
* Function F9055
*
9055:F9055 LDAB= X'03'      ; =3 [Load AL with immediate]
9057:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9059:      RSR              ; [Return from subroutine]
*
* Function F905A
*
905a:F905A STK   X,2        ; [Push X to the stack]
905c:      CAD/  W839F      ; [Clear word at address]
9060:      MVF   (1)/X'0106',/S838C ; =0x0106 =262,=0x838c =33676(-31860) [Move fixed-length, direct, direct]
9067:J9067 C     /W8387(2),/N838B(2) ; =0x8387 =33671(-31865),=0x838b =33675(-31861) [Compare bignums, direct, direct]
906e:      BM    D907C      ; =+12 [Branch on minus]
9070:      C     =13,/W839F(2) ; =0x839f =33695(-31841) [Compare bignums, literal=0x0d, direct]
9076:      BM    D907F      ; =+7 [Branch on minus]
9078:      CAD/  W8399,1    ; [Set word at address to 1]
907c:D907C POP   X,2        ; [Pop X from the stack]
907e:      RSR              ; [Return from subroutine]
*
907f:D907F LDA/  X'0109'    ; =0x0109 =265 [Load A direct]
9082:      XAY              ; [Transfer A to Y]
9083:      LDA=  X'0004'    ; =0x0004 =4 [Load A with immediate]
9086:      XFRB  AL,AU      ; [Transfer AL to AU]
9088:      LDAB/ B8388      ; =0x8388 =33672(-31864) [Load AL direct]
908b:D908B LDX+  Y+         ; [Load X indexed, direct, post-incremented]
908d:      BNZ   D9096      ; =+7 [Branch if not zero]
908f:      INC/  W8387      ; =0x8387 =33671(-31865) [Increment word at address by 1]
9093:      JMP/  J9067      ; =0x9067 =36967(-28569) [Jump direct]
9096:D9096 LDBB+ X          ; [Load BL from address in X]
9097:      BZ    D908B      ; =-14 [Branch if zero]
9099:      LDB+  X,1        ; [Load B indexed, displaced, direct]
909c:      SAB              ; [A - B -> B]
909d:      BNZ   D908B      ; =-20 [Branch if not zero]
909f:      STX/  W8393      ; =0x8393 =33683(-31853) [Store X direct]
90a2:      LDA/  W8387      ; =0x8387 =33671(-31865) [Load A direct]
90a5:      SVC   X'14'      ; =20 [Service call DRDY - disk ready check]
90a7:      FIL   (8)=' ',/W83A3 ; =0x83a3 =33699(-31837) [Fill with byte, literal=0xa0(160,-96), direct]
90ad:      XFRB  BU,BU      ; [Transfer BU to BU]
90af:      BZ    D90B8      ; =+7 [Branch if zero]
90b1:      MVF   (2)='WP',/W83A9 ; =0x83a9 =33705(-31831) [Move fixed-length, literal=0xd7d0(55248,-48), direct]
90b8:D90B8 XFRB  BL,BL      ; [Transfer BL to BL]
90ba:      BNZ   D90D6      ; =+26 [Branch if not zero]
90bc:      JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
90bf:      MVF   (10)=' <OFFLINE>',-Z,3 ; [Move fixed-length, literal=0xa0bccfc6c6ccc9cec5be(759061597017594731087294,-66), displaced indexed]
90ce:      CLR   A,1        ; [Set A to 1]
90d0:      STAB/ B839D      ; =0x839d =33693(-31843) [Store AL direct]
90d3:      JMP/  J911F      ; =0x911f =37151(-28385) [Jump direct]
90d6:D90D6 LDB=  X'000E'    ; =0x000e =14 [Load B with immediate]
90d9:      CLA              ; [Clear A]
90da:      STAB/ B839D      ; =0x839d =33693(-31843) [Store AL direct]
90dd:      JSR/  F923E      ; =0x923e =37438(-28098) [Jump to subroutine direct]
90e0:      BZ    D90FB      ; =+25 [Branch if zero]
90e2:      JSR/  F9272      ; =0x9272 =37490(-28046) [Jump to subroutine direct]
90e5:      STAB/ B839D      ; =0x839d =33693(-31843) [Store AL direct]
90e8:      BZ    D90FB      ; =+17 [Branch if zero]
90ea:      JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
90ed:      FIL   (10)='*',-Z,3 ; [Fill with byte, literal=0xaa(170,-86), displaced indexed]
90f3:      FIL   (8)='*',-Z,14 ; [Fill with byte, literal=0xaa(170,-86), displaced indexed]
90f9:      JMP   D911C      ; =+33 [Jump relative]
90fb:D90FB LDA/  W8067      ; =0x8067 =32871(-32665) [Load A direct]
90fe:      SVC   X'05'      ; =5 [Service call TS - load transient module]
9100:      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
9101:      DW    S8415      ; =0x8415 =33813(-31723) [address of string date]
9103:      JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
9106:      MVF   (8)/S8415,-Z,14 ; =0x8415 =33813(-31723), [Move fixed-length, direct, displaced indexed]
910d:      CPF   (2)=X'4321',/W8069 ; =0x8069 =32873(-32663) [Compare fixed-length, literal=17185, direct]
9114:      BNZ   D911C      ; =+6 [Branch if not zero]
9116:      MVF   (1)='U',/W83A8 ; =0x83a8 =33704(-31832) [Move fixed-length, literal=0xd5(213,-43), direct]
911c:D911C JSR/  F9400      ; =0x9400 =37888(-27648) [Jump to subroutine direct]
911f:J911F LDA/  X'005A'    ; =0x005a =90 [Load A direct]
9122:      CPF   (1)-A,5,/B8388 ; =0x8388 =33672(-31864) [Compare fixed-length, displaced indexed, direct]
9129:      BNZ   D9131      ; =+6 [Branch if not zero]
912b:      MVF   (1)='S',/W83A3 ; =0x83a3 =33699(-31837) [Move fixed-length, literal=0xd3(211,-45), direct]
9131:D9131 LDA/  W8397      ; =0x8397 =33687(-31849) [Load A direct]
9134:      CPF   (1)-A,94,/B8388 ; =0x8388 =33672(-31864) [Compare fixed-length, displaced indexed, direct]
913b:      BNZ   D9143      ; =+6 [Branch if not zero]
913d:      MVF   (1)='T',/W83A4 ; =0x83a4 =33700(-31836) [Move fixed-length, literal=0xd4(212,-44), direct]
9143:D9143 CPF   (1)-A,95,/B8388 ; =0x8388 =33672(-31864) [Compare fixed-length, displaced indexed, direct]
914a:      BNZ   D9152      ; =+6 [Branch if not zero]
914c:      MVF   (1)='L',/W83A5 ; =0x83a5 =33701(-31835) [Move fixed-length, literal=0xcc(204,-52), direct]
9152:D9152 CPF   (1)-A,96,/B8388 ; =0x8388 =33672(-31864) [Compare fixed-length, displaced indexed, direct]
9159:      BNZ   D9161      ; =+6 [Branch if not zero]
915b:      MVF   (1)='W',/W83A6 ; =0x83a6 =33702(-31834) [Move fixed-length, literal=0xd7(215,-41), direct]
9161:D9161 CPF   (1)-A,49,/B8388 ; =0x8388 =33672(-31864) [Compare fixed-length, displaced indexed, direct]
9168:      BNZ   D9170      ; =+6 [Branch if not zero]
916a:      MVF   (1)='D',/W83A7 ; =0x83a7 =33703(-31833) [Move fixed-length, literal=0xc4(196,-60), direct]
9170:D9170 JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
9173:      MVF   (2)='#@',-Z,0 ; [Move fixed-length, literal=0xa3c0(41920,-64), displaced indexed]
917a:      LDAB= X'02'      ; =2 [Load AL with immediate]
917c:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
917e:      CFB   -Z,0(10),/W8387(2) ; =0x8387 =33671(-31865) [Convert from bignum, displaced indexed, direct]
9185:      MVF   (8)/W83A3,-Z,36 ; =0x83a3 =33699(-31837), [Move fixed-length, direct, displaced indexed]
918c:      LDAB/ B839D      ; =0x839d =33693(-31843) [Load AL direct]
918f:      BZ    D9194      ; =+3 [Branch if zero]
9191:      JMP/  J922F      ; =0x922f =37423(-28113) [Jump direct]
9194:D9194 JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
9197:      LDAB/ S806F      ; =0x806f =32879(-32657) [Load AL direct]
919a:      INAB             ; [Increment AL]
919b:      BZ    D91D9      ; =+60 [Branch if zero]
919d:      INAB             ; [Increment AL]
919e:      BNZ   D91B2      ; =+18 [Branch if not zero]
91a0:      MVF   (10)='< REORG > ',-Z,3 ; [Move fixed-length, literal=0xbca0d2c5cfd2c7a0bea0(890771565605109404581536,-96), displaced indexed]
91af:      JMP/  J922F      ; =0x922f =37423(-28113) [Jump direct]
91b2:D91B2 INAB             ; [Increment AL]
91b3:      BNZ   D91C7      ; =+18 [Branch if not zero]
91b5:      MVF   (10)='<< INIT >>',-Z,3 ; [Move fixed-length, literal=0xbcbca0c9cec9d4a0bebe(891284472684233334243006,-66), displaced indexed]
91c4:      JMP/  J922F      ; =0x922f =37423(-28113) [Jump direct]
91c7:D91C7 MVF   (10)='<<< 5 >>> ',-Z,3 ; [Move fixed-length, literal=0xbcbcbca0b5a0bebebea0(891286478728728099602080,-96), displaced indexed]
91d6:      JMP/  J922F      ; =0x922f =37423(-28113) [Jump direct]
91d9:D91D9 LDA/  W806D      ; =0x806d =32877(-32659) [Load A direct]
91dc:      IVA              ; [Invert A]
91dd:      LDBB= X'80'      ; =128(-128) [Load BL with immediate]
91df:      RL               ; [Reset link]
91e0:      RRR   A          ; [Right rotate A by 1]
91e2:      BNL   D91E6      ; =+2 [Branch on no link]
91e4:      ORIB  BL,AU      ; [BL | AU -> AU]
91e6:D91E6 LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
91e9:      OREB  BL,BU      ; [BL ^ BU -> BU]
91eb:      ORE   A,B        ; [A ^ B -> B]
91ed:      LDA/  W8393      ; =0x8393 =33683(-31853) [Load A direct]
91f0:      LDA+  A,23       ; [Load A indexed, displaced, direct]
91f3:      SAB              ; [A - B -> B]
91f4:      BZ    D9207      ; =+17 [Branch if zero]
91f6:      MVF   (10)='< SECURE >',-Z,3 ; [Move fixed-length, literal=0xbca0d3c5c3d5d2c5a0be(890771637649522374844606,-66), displaced indexed]
9205:      JMP   J922F      ; =+40 [Jump relative]
9207:D9207 LDA/  W806B      ; =0x806b =32875(-32661) [Load A direct]
920a:      OREB  AL,AU      ; [AL ^ AU -> AU]
920c:      LDB=  X'3CB1'    ; =0x3cb1 =15537 [Load B with immediate]
920f:      ORE   A,B        ; [A ^ B -> B]
9211:      LDA/  W8393      ; =0x8393 =33683(-31853) [Load A direct]
9214:      LDA+  A,23       ; [Load A indexed, displaced, direct]
9217:      AAB              ; [A + B -> B]
9218:      LDA=  X'0400'    ; =0x0400 =1024 [Load A with immediate]
921b:D921B SLR   B          ; [Left shift B by 1]
921d:      RLRB  AL         ; [Left rotate AL by 1]
921f:      DCRB  AU         ; [Decrement AU by 1]
9221:      BGZ   D921B      ; =-8 [Branch if greater than zero]
9223:      JSR/  F923E      ; =0x923e =37438(-28098) [Jump to subroutine direct]
9226:      BNZ   J922F      ; =+7 [Branch if not zero]
9228:      MVF   (10)/W8067,-Z,3 ; =0x8067 =32871(-32665), [Move fixed-length, direct, displaced indexed]
922f:J922F INC/  W8387      ; =0x8387 =33671(-31865) [Increment word at address by 1]
9233:      INC/  S838F      ; =0x838f =33679(-31857) [Increment word at address by 1]
9237:      INC/  W839F      ; =0x839f =33695(-31841) [Increment word at address by 1]
923b:      JMP/  J9067      ; =0x9067 =36967(-28569) [Jump direct]
*
* Function F923E
*
923e:F923E STX-  S-         ; [Store X indexed, pre-decremented, direct]
9240:      LDX=  X'0005'    ; =0x0005 =5 [Load X with immediate]
9243:      STAB/ W8D80      ; =0x8d80 =36224(-29312) [Store AL direct]
9246:      STB/  W8D81      ; =0x8d81 =36225(-29311) [Store B direct]
9249:      MVF   (1)/B8388,/W9256 ; =0x8388 =33672(-31864),=0x9256 =37462(-28074) [Move fixed-length, direct, direct]
9250:D9250 SVC   X'4C'      ; =76 [Service call DIO - disk I/O]
9252:      DW    X'0014'    ; =0x0014 =20 [TODO: arg 1]
9254:      DW    W8D4B      ; =0x8d4b =36171(-29365) [TODO: arg 2]
9256:W9256 DB    X'00'      ; =0x00 =0 =NUL [TODO: arg3]
9257:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg4]
9258:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg5]
9259:W9259 DW    W8067      ; =0x8067 =32871(-32665)
925b:      LDAB/ X'1403'    ; =0x1403 =5123 [Load AL direct]
925e:      DCX              ; [Decrement X]
925f:      BP    D9250      ; =-17 [Branch on plus]
9261:      LDX+  S+         ; [Load X indexed, direct, post-incremented]
9263:      XFR   A,A        ; [Transfer A to A]
9265:      RSR              ; [Return from subroutine]
*
* Function F9266
*
9266:F9266 LDA=  X'0050'    ; =0x0050 =80 [Load A with immediate]
9269:      MUL/  S838F,A    ; =0x838f =33679(-31857) [Direct * A -> A]
926d:      ADD=  S8907,B,Z  ; =0x8907 =35079(-30457) [35079 + B -> Z]
9271:      RSR              ; [Return from subroutine]
*
* Function F9272
*
9272:F9272 LDA/  W8393      ; =0x8393 =33683(-31853) [Load A direct]
9275:      LDB+  A,17       ; [Load B indexed, displaced, direct]
9278:      CAD/  W8D80      ; [Clear word at address]
927c:      STB/  W8D81      ; =0x8d81 =36225(-29311) [Store B direct]
927f:      M     =16,/W8D80(3) ; =0x8d80 =36224(-29312) [Multiply bignums, literal=0x10, direct]
9285:      CLR   B          ; [Clear B]
9287:      LDBB+ A,22       ; [Load BL indexed, displaced, direct]
928a:      DIV=  X'0003',B  ; =0x0003 =3 [B / 3 -> B]
928e:      STB/  S8409      ; =0x8409 =33801(-31735) [Store B direct]
9291:      A     /S8409(2),/W8D80(3) ; =0x8409 =33801(-31735),=0x8d80 =36224(-29312) [Add bignums, direct, direct]
9298:      LDB/  W8D81      ; =0x8d81 =36225(-29311) [Load B direct]
929b:      LDAB/ W8D80      ; =0x8d80 =36224(-29312) [Load AL direct]
929e:      JSR/  F923E      ; =0x923e =37438(-28098) [Jump to subroutine direct]
92a1:      BZ    D92A4      ; =+1 [Branch if zero]
92a3:      RSR              ; [Return from subroutine]
*
92a4:D92A4 LDA/  S806F      ; =0x806f =32879(-32657) [Load A direct]
92a7:      INA              ; [Increment A]
92a8:      BNZ   D92C5      ; =+27 [Branch if not zero]
92aa:      A     =1,/W8D80(3) ; =0x8d80 =36224(-29312) [Add bignums, literal=0x01, direct]
92b0:      LDA=  S81F7      ; =0x81f7 =33271(-32265) [Load A with immediate]
92b3:      STA/  W9259      ; =0x9259 =37465(-28071) [Store A direct]
92b6:      LDB/  W8D81      ; =0x8d81 =36225(-29311) [Load B direct]
92b9:      LDAB/ W8D80      ; =0x8d80 =36224(-29312) [Load AL direct]
92bc:      JSR/  F923E      ; =0x923e =37438(-28098) [Jump to subroutine direct]
92bf:      LDA/  W8393      ; =0x8393 =33683(-31853) [Load A direct]
92c2:      LDB+  A,17       ; [Load B indexed, displaced, direct]
92c5:D92C5 LDA=  W8067      ; =0x8067 =32871(-32665) [Load A with immediate]
92c8:      STA/  W9259      ; =0x9259 =37465(-28071) [Store A direct]
92cb:      CLR   A,1        ; [Set A to 1]
92cd:      RSR              ; [Return from subroutine]
*
92ce:      LDA=  X'0064'    ; =0x0064 =100 [Load A with immediate]
92d1:D92D1 SVC   X'07'      ; =7 [Service call WT - unconditional wait]
92d3:      DCA              ; [Decrement A]
92d4:      BP    D92D1      ; =-5 [Branch on plus]
92d6:      RSR              ; [Return from subroutine]
*
* Function F92D7
*
92d7:F92D7 CAD/  S838F      ; [Clear word at address]
92db:      CAD/  W83A1      ; [Clear word at address]
92df:      CPF   (2)=X'0001',/W8389 ; =0x8389 =33673(-31863) [Compare fixed-length, literal=1, direct]
92e6:      BZ    D92F5      ; =+13 [Branch if zero]
92e8:      CAD/  W8389,1    ; [Set word at address to 1]
92ec:      LDA/  X'005A'    ; =0x005a =90 [Load A direct]
92ef:      LDA+  A,7        ; [Load A indexed, displaced, direct]
92f2:      STA/  W8395      ; =0x8395 =33685(-31851) [Store A direct]
92f5:D92F5 LDA$  W8395      ; =0x8395 =33685(-31851) [Load A indirect]
92f8:      BNZ   D92FB      ; =+1 [Branch if not zero]
92fa:      RSR              ; [Return from subroutine]
*
92fb:D92FB C     =13,/W83A1(2) ; =0x83a1 =33697(-31839) [Compare bignums, literal=0x0d, direct]
9301:      BM    D9308      ; =+5 [Branch on minus]
9303:      CAD/  W8399,1    ; [Set word at address to 1]
9307:      RSR              ; [Return from subroutine]
*
9308:D9308 XAY              ; [Transfer A to Y]
9309:      JSR/  F9266      ; =0x9266 =37478(-28058) [Jump to subroutine direct]
930c:      LDA/  W8397      ; =0x8397 =33687(-31849) [Load A direct]
930f:      SUB   Y,A        ; [Y - A -> A]
9311:      BNZ   D9319      ; =+6 [Branch if not zero]
9313:      MVF   (1)='*',-Z,44 ; [Move fixed-length, literal=0xaa(170,-86), displaced indexed]
9319:D9319 MVF   (2)='#@',-Z,45 ; [Move fixed-length, literal=0xa3c0(41920,-64), displaced indexed]
9320:      MVF   (4)='@@#@',-Z,54 ; [Move fixed-length, literal=0xc0c0a3c0(3233850304,-64), displaced indexed]
9329:      MVF   (3)-Z,54,-Z,59 ; [Move fixed-length, displaced indexed, displaced indexed]
9330:      MVF   (3)='#@K',-Z,63 ; [Move fixed-length, literal=0xa3c0cb(10731723,-53), displaced indexed]
9338:      LDAB= X'02'      ; =2 [Load AL with immediate]
933a:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
933c:      CFB   -Z,45(10),-Y,1(1) ; [Convert from bignum, displaced indexed, displaced indexed]
9343:      LDAB= X'03'      ; =3 [Load AL with immediate]
9345:      CFB   -Z,59(10),-Y,3(1) ; [Convert from bignum, displaced indexed, displaced indexed]
934c:      LDA$  W8395      ; =0x8395 =33685(-31851) [Load A indirect]
934f:      LDA+  A,8        ; [Load A indexed, displaced, direct]
9352:      MVF   (6)-A,7,-Z,48 ; [Move fixed-length, displaced indexed, displaced indexed]
9359:      LDBB+ A,1        ; [Load BL indexed, displaced, direct]
935c:      BNZ   D9366      ; =+8 [Branch if not zero]
935e:      FIL   (4)=' ',-Z,54 ; [Fill with byte, literal=0xa0(160,-96), displaced indexed]
9364:      JMP   D9377      ; =+17 [Jump relative]
9366:D9366 LDA+  A,47       ; [Load A indexed, displaced, direct]
9369:      STA/  S8409      ; =0x8409 =33801(-31735) [Store A direct]
936c:      LDAB= X'04'      ; =4 [Load AL with immediate]
936e:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
9370:      CFB   -Z,54(10),/S8409(2) ; =0x8409 =33801(-31735) [Convert from bignum, displaced indexed, direct]
9377:D9377 LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
937a:      LDBB= X'04'      ; =4 [Load BL with immediate]
937c:      NABB             ; [AL & BL -> BL]
937d:      BZ    D93AA      ; =+43 [Branch if zero]
937f:      LDA+  Y,23       ; [Load A indexed, displaced, direct]
9382:      DCR   A,10       ; [Decrement A by 10]
9384:      MVF   (10)-A,-Z,67 ; [Move fixed-length, indexed, displaced indexed]
938a:      CPF   (10)='          ',-Z,67 ; [Compare fixed-length, literal=0xa0a0a0a0a0a0a0a0a0a0(758541690738590854717600,-96), displaced indexed]
9399:      BNZ   D93AA      ; =+15 [Branch if not zero]
939b:      MVF   (10)=' (NO NAME)',-Z,67 ; [Move fixed-length, literal=0xa0a8cecfa0cec1cdc5a9(758692592570028306318761,-87), displaced indexed]
93aa:D93AA LDAB+ Y          ; [Load AL from address in Y]
93ab:      BZ    D93B3      ; =+6 [Branch if zero]
93ad:      MVF   (1)='R',-Z,78 ; [Move fixed-length, literal=0xd2(210,-46), displaced indexed]
93b3:D93B3 LDAB+ Y,18       ; [Load AL indexed, displaced, direct]
93b6:      LDBB= X'08'      ; =8 [Load BL with immediate]
93b8:      NABB             ; [AL & BL -> BL]
93b9:      BZ    D93C1      ; =+6 [Branch if zero]
93bb:      MVF   (1)='S',-Z,79 ; [Move fixed-length, literal=0xd3(211,-45), displaced indexed]
93c1:D93C1 ZAD   -Y,12(2),/S8409(4) ; =0x8409 =33801(-31735) [Zero-add bignum, displaced indexed, direct]
93c8:      BP    D93EB      ; =+33 [Branch on plus]
93ca:      S     -Y,10(2),/S8409(4) ; =0x8409 =33801(-31735) [Subtract bignums, displaced indexed, direct]
93d1:      A     =1,/S8409(4) ; =0x8409 =33801(-31735) [Add bignums, literal=0x01, direct]
93d7:      D     =1024,/S8409(4) ; =0x8409 =33801(-31735) [Divide bignums, literal=0x0400, direct]
93de:      LDAB= X'02'      ; =2 [Load AL with immediate]
93e0:      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
93e2:      CFB   -Z,63(10),/S8409(4) ; =0x8409 =33801(-31735) [Convert from bignum, displaced indexed, direct]
93e9:      JMP   D93F1      ; =+6 [Jump relative]
93eb:D93EB FIL   (3)=' ',-Z,63 ; [Fill with byte, literal=0xa0(160,-96), displaced indexed]
93f1:D93F1 INC/  S838F      ; =0x838f =33679(-31857) [Increment word at address by 1]
93f5:      INC/  W83A1      ; =0x83a1 =33697(-31839) [Increment word at address by 1]
93f9:      INC/  W8395,2    ; =0x8395 =33685(-31851) [Increment word at address by 2]
93fd:      JMP/  D92F5      ; =0x92f5 =37621(-27915) [Jump direct]
*
* Function F9400
*
9400:F9400 XFR=  W85B4,Y    ; =0x85b4 =34228(-31308) [Transfer immediate to Y]
9404:      LDB/  W8393      ; =0x8393 =33683(-31853) [Load B direct]
9407:D9407 CPF   (2)-Y,-B,17 ; [Compare fixed-length, indexed, displaced indexed]
940d:      BZ    D941A      ; =+11 [Branch if zero]
940f:      INR   Y,14       ; [Increment Y by 14]
9411:      CPF   (2)=X'0000',-Y ; [Compare fixed-length, literal=0, indexed]
9417:      BNZ   D9407      ; =-18 [Branch if not zero]
9419:      RSR              ; [Return from subroutine]
*
941a:D941A MVF   (12)-Y,2,-Z,23 ; [Move fixed-length, displaced indexed, displaced indexed]
9421:      RSR              ; [Return from subroutine]
*
* Function F9422
*
9422:F9422 LDAB/ W83B3      ; =0x83b3 =33715(-31821) [Load AL direct]
9425:      DCRB  AL,2       ; [Decrement AL by 2]
9427:      BNZ   D9433      ; =+10 [Branch if not zero]
9429:      LDB=  W8D83      ; =0x8d83 =36227(-29309) [Load B with immediate]
942c:      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
942e:      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
9430:      DW    W8D83      ; =0x8d83 =36227(-29309) [TODO: arg 1]
9432:      RSR              ; [Return from subroutine]
*
9433:D9433 XFR/  W841D,Y    ; =0x841d =33821(-31715) [Transfer direct to Y]
9437:      BZ    D945C      ; =+35 [Branch if zero]
9439:      XFR/  W841F,Z    ; =0x841f =33823(-31713) [Transfer direct to Z]
943d:      LDA+  Y,6        ; [Load A indexed, displaced, direct]
9440:      STA+  Z,20       ; [Store A indexed, displaced, direct]
9443:      STA+  Z,24       ; [Store A indexed, displaced, direct]
9446:      LDA+  Y,4        ; [Load A indexed, displaced, direct]
9449:      STA+  Z,18       ; [Store A indexed, displaced, direct]
944c:      STA+  Z,8        ; [Store A indexed, displaced, direct]
944f:      INA              ; [Increment A]
9450:      STA+  Z,22       ; [Store A indexed, displaced, direct]
9453:      LDAB= X'01'      ; =1 [Load AL with immediate]
9455:      STAB+ Z,3        ; [Store AL indexed, displaced, direct]
9458:      XFR   Z,B        ; [Transfer Z to B]
945a:      SVC   X'00'      ; =0 [Service call PIOC - physical i/o control]
945c:D945C MVF   (1)=X'8D',/S8D17 ; =0x8d17 =36119(-29417) [Move fixed-length, literal=141(-115), direct]
9462:      LDA/  W8407      ; =0x8407 =33799(-31737) [Load A direct]
9465:      BZ    D9470      ; =+9 [Branch if zero]
9467:      DEC/  S838F      ; =0x838f =33679(-31857) [Decrement word at address by 1]
946b:      LDA=  S8907      ; =0x8907 =35079(-30457) [Load A with immediate]
946e:      JMP   D947B      ; =+11 [Jump relative]
9470:D9470 INC/  W8407      ; =0x8407 =33799(-31737) [Increment word at address by 1]
9474:      LDA=  S8637      ; =0x8637 =34359(-31177) [Load A with immediate]
9477:      INC/  S838F,8    ; =0x838f =33679(-31857) [Increment word at address by 8]
947b:D947B STA/  W83B1      ; =0x83b1 =33713(-31823) [Store A direct]
947e:      MVF   (80)-A,/S83B6 ; =0x83b6 =33718(-31818) [Move fixed-length, indexed, direct]
9484:      LDAB= X'02'      ; =2 [Load AL with immediate]
9486:      LDB/  W841F      ; =0x841f =33823(-31713) [Load B direct]
9489:      STAB+ B,3        ; [Store AL indexed, displaced, direct]
948c:      SVC   X'18'      ; =24 [Service call LIOC - logical I/O control]
948e:      DEC/  S838F      ; =0x838f =33679(-31857) [Decrement word at address by 1]
9492:      BM    D949D      ; =+9 [Branch on minus]
9494:      LDA=  X'0050'    ; =0x0050 =80 [Load A with immediate]
9497:      ADD/  W83B1,A    ; =0x83b1 =33713(-31823) [Direct + A -> A]
949b:      JMP   D947B      ; =-34 [Jump relative]
949d:D949D XFR/  W841D,Y    ; =0x841d =33821(-31715) [Transfer direct to Y]
94a1:      BZ    D94B3      ; =+16 [Branch if zero]
94a3:      XFR/  W841F,Z    ; =0x841f =33823(-31713) [Transfer direct to Z]
94a7:      LDA+  Z,24       ; [Load A indexed, displaced, direct]
94aa:      STA+  Y,6        ; [Store A indexed, displaced, direct]
94ad:      LDA+  Z,18       ; [Load A indexed, displaced, direct]
94b0:      STA+  Y,4        ; [Store A indexed, displaced, direct]
94b3:D94B3 RSR              ; [Return from subroutine]
*
94b4:ENDPT
