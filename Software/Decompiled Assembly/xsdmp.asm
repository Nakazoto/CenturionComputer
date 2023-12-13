 TITLE 'SDMP'
SDMP BEGIN 0
*
8000(       )      DS    140        ; =0x008c [Uninitialized memory]
808c(8093   )LMXPTR DW    @LMX       ; =0x8093 =32915(-32621)
808e(00     )ZERO  DB    X'00'      ; =0x00 =0 =NUL
808f(000000 )STATUS DB    0,3        ; =0x00,0x0003
8092(00     )@IF   DB    X'00'      ; =0x00 =0 =NUL
8093(0084   )@LMX  DW    X'0084'    ; =0x0084 =132 =NUL,EOT
8095(0000   )@LL   DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8097(       )@LI   DS    132        ; =0x0084 [Uninitialized memory]
811b(0000   )LINULL DW    X'0000'    ; =0x0000 =0 =NUL,NUL
811d(00     )SYS0  DB    X'00'      ; =0x00 =0 =NUL [RBSTA: status of i-o event]
811e(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBLUN: logical unit number] (SYS000)
811f(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBF0: flag 0]
8120(00     )B8120 DB    X'00'      ; =0x00 =0 =NUL [RBFCN: function]
8121(0190   )      DW    X'0190'    ; =0x0190 =400 [RBBLN: max buffer length]
8123(8740   )      DW    SECDATA    ; =0x8740 =34624(-30912) [RBBUF: buffer address]
8125(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCTL: control word]
8127(0005   )      DW    X'0005'    ; =0x0005 =5 [RBLSR: address of logical io routine] (Relative sector I/O)
8129(02     )      DB    X'02'      ; =0x02 =2 [RBDVC: device class] (buffered disk file only)
812a(FF     )      DB    X'FF'      ; =0xff =255(-1) [RBDFT: disc file type] (Type ?)
812b(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRLN: max record length]
812d(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBREC: address of record area]
812f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCDA: current disc address]
8131(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCBP: current buffer pointer]
8133(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNDA: next disc address]
8135(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNBP: next buffer pointer]
8137(813B   )      DW    SYS0KEY    ; =0x813b =33083(-32453) [RBKEY: address of 32-bit record key]
8139(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRSZ: record size for random access calculation]
813b(FFFF   )SYS0KEY DW    X'FFFF'    ; =0xffff =65535(-1)
813d(FFFF   )      DW    X'FFFF'    ; =0xffff =65535(-1)
813f(00     )CRT   DB    X'00'      ; =0x00 =0 =NUL [RBSTA: status of i-o event]
8140(81     )      DB    X'81'      ; =0x81 =129(-127) [RBLUN: logical unit number] (SYSIPT)
8141(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBF0: flag 0]
8142(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBFCN: function]
8143(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBBLN: max buffer length]
8145(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBBUF: buffer address]
8147(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCTL: control word]
8149(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBLSR: address of logical io routine] (Type "A" unbuffered device or file)
814b(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBDVC: device class] (console device only)
814c(02     )      DB    X'02'      ; =0x02 =2 [RBDFT: disc file type] (Type A)
814d(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRLN: max record length]
814f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBREC: address of record area]
8151(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCDA: current disc address]
8153(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCBP: current buffer pointer]
8155(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNDA: next disc address]
8157(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNBP: next buffer pointer]
8159(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBKEY: address of 32-bit record key]
815b(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRSZ: record size for random access calculation]
815d(00     )LST   DB    X'00'      ; =0x00 =0 =NUL [RBSTA: status of i-o event]
815e(83     )      DB    X'83'      ; =0x83 =131(-125) [RBLUN: logical unit number] (SYSLST)
815f(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBF0: flag 0]
8160(00     )      DB    X'00'      ; =0x00 =0 =NUL [RBFCN: function]
8161(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBBLN: max buffer length]
8163(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBBUF: buffer address]
8165(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCTL: control word]
8167(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBLSR: address of logical io routine] (Type "A" unbuffered device or file)
8169(01     )      DB    X'01'      ; =0x01 =1 [RBDVC: device class] (device independent, unbuffered)
816a(02     )      DB    X'02'      ; =0x02 =2 [RBDFT: disc file type] (Type A)
816b(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRLN: max record length]
816d(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBREC: address of record area]
816f(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCDA: current disc address]
8171(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBCBP: current buffer pointer]
8173(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNDA: next disc address]
8175(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBNBP: next buffer pointer]
8177(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBKEY: address of 32-bit record key]
8179(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [RBRSZ: record size for random access calculation]
817b(808C   )P817B DW    LMXPTR     ; =0x808c =32908(-32628)
*
* Function ENTRY
*
817d(55BA80+)ENTRY XFR=  LMXPTR,S   ; =0x808c =32908(-32628) [Transfer immediate to S]
8181(665D   )      SVC   93         ; =0x5D [Service call PBKV - set OS block value]
8183(00     )      DB    X'00'      ; =0x00 =0 =NUL [block=TIB]
8184(02     )      DB    X'02'      ; =0x02 =2 [length]
8185(19     )      DB    X'19'      ; =0x19 =25 [offset=TBUW0: utility word 0 (first word of cpl program)]
8186(817B   )      DW    P817B      ; =0x817b =33147(-32389) [address to read block value]
8188(660B   )      SVC   11         ; =0x0B [Service call DT - get binary date]
818a(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
818c(0A     )      DB    X'0A'      ; =0x0a =10 [Selector: integer date]
818d(8979   )      DW    DATEI      ; =0x8979 =35193(-30343) [address of integer date]
818f(660B   )      SVC   11         ; =0x0B [Service call DT - get binary date]
8191(6605   )      SVC   5          ; =0x05 [Service call TS - load transient module]
8193(04     )      DB    X'04'      ; =0x04 =4 [Selector: string date from date in A]
8194(897D   )      DW    DATES      ; =0x897d =35197(-30339) [address of string date]
8196(6639   )      SVC   57         ; =0x39 [Service call OP - CPL open]
8198(03     )      DB    X'03'      ; =0x03 =3 [Mode: input/output]
8199(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
819b(00     )      DB    X'00'      ; =0x00 =0 =NUL [argument list terminator]
819c(6639   )      SVC   57         ; =0x39 [Service call OP - CPL open]
819e(02     )      DB    X'02'      ; =0x02 =2 [Mode: output]
819f(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
81a1(00     )      DB    X'00'      ; =0x00 =0 =NUL [argument list terminator]
81a2(6639   )      SVC   57         ; =0x39 [Service call OP - CPL open]
81a4(03     )      DB    X'03'      ; =0x03 =3 [Mode: input/output]
81a5(811D   )      DW    SYS0       ; =0x811d =33053(-32483) [address of RCB]
81a7(00     )      DB    X'00'      ; =0x00 =0 =NUL [argument list terminator]
81a8(D0811D )      LDB=  SYS0       ; =0x811d =33053(-32483) [Load B with immediate]
81ab(6652   )      SVC   82         ; =0x52 [Service call GIOB - unprotected GIOB]
81ad(01     )      DB    X'01'      ; =0x01 =1 [fcb segment (RCB in B)]
81ae(15     )      DB    X'15'      ; =0x15 =21 [length]
81af(09     )      DB    X'09'      ; =0x09 =9 [offset=FBCNM: complete file name]
81b0(890E   )      DW    FULLNAME   ; =0x890e =35086(-30450) [TODO: address]
81b2(D0811D )      LDB=  SYS0       ; =0x811d =33053(-32483) [Load B with immediate]
81b5(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
81b7(01     )      DB    X'01'      ; =0x01 =1 [block=PUB (RCB/FCB in B)]
81b8(01     )      DB    X'01'      ; =0x01 =1 [length]
81b9(02     )      DB    X'02'      ; =0x02 =2 [offset=PBUNT: unit number]
81ba(86C2   )      DW    P86C2      ; =0x86c2 =34498(-31038) [address to store block value]
81bc(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
81be(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
81c0(8924   )      DW    FMT1       ; =0x8924 =35108(-30428) [address of format]
81c2(8539   )      DW    STR1       ; =0x8539 =34105(-31431) [address of argument]
81c4(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
81c6(798A2D )      JSR/  YNGET      ; =0x8a2d =35373(-30163) [Jump to subroutine direct]
81c9(863E   )      DW    STR2       ; =0x863e =34366(-31170)
81cb(463023+)      C     /STATUS(4),=0 ; =0x808f =32911(-32625), [Compare bignums, direct, literal=0x00]
81d1(1403   )      BZ    D81D6      ; =+3 [Branch if zero]
81d3(7181D9 )      JMP/  J81D9      ; =0x81d9 =33241(-32295) [Jump direct]
81d6(7181ED )D81D6 JMP/  J81ED      ; =0x81ed =33261(-32275) [Jump direct]
81d9(56     )J81D9 EAO              ; [Enable abort on overflow]
81da(2A     )      CLAB             ; [Clear AL]
81db(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
81de(463730+)      ZAD   /FLAG2(4),/X@W64A(8) ; =0x86b7 =34487(-31049),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
81e5(467330+)      ZAD   /X@W64A(8),/FLAG1(4) ; =0x8971 =35185(-30351),=0x86bb =34491(-31045) [Zero-add bignum, direct, direct]
81ec(57     )      DAO              ; [Disable abort on overflow]
81ed(798986 )J81ED JSR/  CGET       ; =0x8986 =35206(-30330) [Jump to subroutine direct]
81f0(8555   )      DW    STR3       ; =0x8555 =34133(-31403)
81f2(8932   )      DW    FMT2       ; =0x8932 =35122(-30414)
81f4(8906   )      DW    INBUFF     ; =0x8906 =35078(-30458)
81f6(471000+)      CPV   (0)/INBUFF,/EMPTYSTR ; =0x8906 =35078(-30458),=0x890d =35085(-30451) [Compare variable-length, direct, direct]
81fd(1403   )      BZ    D8202      ; =+3 [Branch if zero]
81ff(718205 )      JMP/  J8205      ; =0x8205 =33285(-32251) [Jump direct]
8202(718439 )D8202 JMP/  J8439      ; =0x8439 =33849(-31687) [Jump direct]
8205(60890B )J8205 LDX=  W890B      ; =0x890b =35083(-30453) [Load X with immediate]
8208(80A0   )      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
820a(C542   )D820A LDBB- X-         ; [Load BL indexed, pre-decremented, direct]
820c(49     )      SABB             ; [AL - BL -> BL]
820d(14FB   )      BZ    D820A      ; =-5 [Branch if zero]
820f(2A     )      CLAB             ; [Clear AL]
8210(3E     )      INX              ; [Increment X]
8211(AA     )      STAB+ X          ; [Store AL to address in X]
8212(471000+)      CPV   (0)/INBUFF,/NSTR ; =0x8906 =35078(-30458),=0x8660 =34400(-31136) [Compare variable-length, direct, direct]
8219(1503   )      BNZ   D821E      ; =+3 [Branch if not zero]
821b(718221 )      JMP/  J8221      ; =0x8221 =33313(-32223) [Jump direct]
821e(71822A )D821E JMP/  J822A      ; =0x822a =33322(-32214) [Jump direct]
8221(46030C+)J8221 A     =1,/SYS0KEY(4) ; =0x813b =33083(-32453) [Add bignums, literal=0x01, direct]
8227(71828F )      JMP/  J828F      ; =0x828f =33423(-32113) [Jump direct]
822a(471000+)J822A CPV   (0)/INBUFF,/PSTR ; =0x8906 =35078(-30458),=0x8662 =34402(-31134) [Compare variable-length, direct, direct]
8231(1503   )      BNZ   D8236      ; =+3 [Branch if not zero]
8233(718239 )      JMP/  J8239      ; =0x8239 =33337(-32199) [Jump direct]
8236(718263 )D8236 JMP/  J8263      ; =0x8263 =33379(-32157) [Jump direct]
8239(46031C+)J8239 S     =1,/SYS0KEY(4) ; =0x813b =33083(-32453) [Subtract bignums, literal=0x01, direct]
823f(463023+)      C     /SYS0KEY(4),=0 ; =0x813b =33083(-32453), [Compare bignums, direct, literal=0x00]
8245(1903   )      BLE   D824A      ; =+3 [Branch if less than or equal to zero]
8247(71824D )      JMP/  J824D      ; =0x824d =33357(-32179) [Jump direct]
824a(71828F )D824A JMP/  J828F      ; =0x828f =33423(-32113) [Jump direct]
824d(56     )J824D EAO              ; [Enable abort on overflow]
824e(2A     )      CLAB             ; [Clear AL]
824f(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8252(46073C+)      ZAD   =0,/X@W64A(8) ; =0x8971 =35185(-30351) [Zero-add bignum, literal=0x00, direct]
8258(467330+)      ZAD   /X@W64A(8),/SYS0KEY(4) ; =0x8971 =35185(-30351),=0x813b =33083(-32453) [Zero-add bignum, direct, direct]
825f(57     )      DAO              ; [Disable abort on overflow]
8260(71828F )      JMP/  J828F      ; =0x828f =33423(-32113) [Jump direct]
8263(6632   )J8263 SVC   50         ; =0x32 [Service call DC - CPL decode]
8265(8906   )      DW    INBUFF     ; =0x8906 =35078(-30458) [address of string]
8267(894B   )      DW    FMT3       ; =0x894b =35147(-30389) [address of format]
8269(813B   )      DW    SYS0KEY    ; =0x813b =33083(-32453) [address of argument]
826b(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
826d(463320+)      C     /SYS0KEY(4),/ZERO(4) ; =0x813b =33083(-32453),=0x808e =32910(-32626) [Compare bignums, direct, direct]
8274(1903   )      BLE   D8279      ; =+3 [Branch if less than or equal to zero]
8276(71827C )      JMP/  J827C      ; =0x827c =33404(-32132) [Jump direct]
8279(71828F )D8279 JMP/  J828F      ; =0x828f =33423(-32113) [Jump direct]
827c(56     )J827C EAO              ; [Enable abort on overflow]
827d(2A     )      CLAB             ; [Clear AL]
827e(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8281(46073C+)      ZAD   =0,/X@W64A(8) ; =0x8971 =35185(-30351) [Zero-add bignum, literal=0x00, direct]
8287(467330+)      ZAD   /X@W64A(8),/SYS0KEY(4) ; =0x8971 =35185(-30351),=0x813b =33083(-32453) [Zero-add bignum, direct, direct]
828e(57     )      DAO              ; [Disable abort on overflow]
828f(8001   )J828F LDAB= X'01'      ; =1 [Load AL with immediate]
8291(A18120 )      STAB/ B8120      ; =0x8120 =33056(-32480) [Store AL direct]
8294(D0811D )      LDB=  SYS0       ; =0x811d =33053(-32483) [Load B with immediate]
8297(6618   )      SVC   24         ; =0x18 [Service call LIOC - logical I/O control]
8299(81811D )      LDAB/ SYS0       ; =0x811d =33053(-32483) [Load AL direct]
829c(1408   )      BZ    D82A6      ; =+8 [Branch if zero]
829e(7989EF )      JSR/  MSG        ; =0x89ef =35311(-30225) [Jump to subroutine direct]
82a1(85EA   )      DW    STR4       ; =0x85ea =34282(-31254)
82a3(7181ED )      JMP/  J81ED      ; =0x81ed =33261(-32275) [Jump direct]
82a6(798446 )D82A6 JSR/  PRINTSEC   ; =0x8446 =33862(-31674) [Jump to subroutine direct]
82a9(56     )      EAO              ; [Enable abort on overflow]
82aa(2A     )      CLAB             ; [Clear AL]
82ab(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
82ae(46073C+)      ZAD   =0,/X@W64A(8) ; =0x8971 =35185(-30351) [Zero-add bignum, literal=0x00, direct]
82b4(467330+)      ZAD   /X@W64A(8),/FLAG3(4) ; =0x8971 =35185(-30351),=0x86d7 =34519(-31017) [Zero-add bignum, direct, direct]
82bb(57     )      DAO              ; [Disable abort on overflow]
82bc(6635   )J82BC SVC   53         ; =0x35 [Service call WF - CPL formatted write]
82be(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
82c0(8924   )      DW    FMT1       ; =0x8924 =35108(-30428) [address of format]
82c2(858C   )      DW    STR5       ; =0x858c =34188(-31348) [address of argument]
82c4(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
82c6(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
82c8(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
82ca(8936   )      DW    FMT6       ; =0x8936 =35126(-30410) [address of format]
82cc(86CB   )      DW    LINE       ; =0x86cb =34507(-31029) [address of argument]
82ce(86CF   )      DW    COL        ; =0x86cf =34511(-31025) [address of argument]
82d0(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
82d2(463320+)      C     /STATUS(4),/ZERO(4) ; =0x808f =32911(-32625),=0x808e =32910(-32626) [Compare bignums, direct, direct]
82d9(1503   )      BNZ   D82DE      ; =+3 [Branch if not zero]
82db(7182E1 )      JMP/  J82E1      ; =0x82e1 =33505(-32031) [Jump direct]
82de(7182BC )D82DE JMP/  J82BC      ; =0x82bc =33468(-32068) [Jump direct]
82e1(463320+)J82E1 C     /LINE(4),/ZERO(4) ; =0x86cb =34507(-31029),=0x808e =32910(-32626) [Compare bignums, direct, direct]
82e8(1503   )      BNZ   D82ED      ; =+3 [Branch if not zero]
82ea(7182F0 )      JMP/  J82F0      ; =0x82f0 =33520(-32016) [Jump direct]
82ed(7182FF )D82ED JMP/  J82FF      ; =0x82ff =33535(-32001) [Jump direct]
82f0(463320+)J82F0 C     /COL(4),/ZERO(4) ; =0x86cf =34511(-31025),=0x808e =32910(-32626) [Compare bignums, direct, direct]
82f7(1403   )      BZ    D82FC      ; =+3 [Branch if zero]
82f9(7182FF )      JMP/  J82FF      ; =0x82ff =33535(-32001) [Jump direct]
82fc(71840B )D82FC JMP/  J840B      ; =0x840b =33803(-31733) [Jump direct]
82ff(463320+)J82FF C     /COL(4),/ZERO(4) ; =0x86cf =34511(-31025),=0x808e =32910(-32626) [Compare bignums, direct, direct]
8306(1703   )      BP    D830B      ; =+3 [Branch on plus]
8308(71830E )      JMP/  J830E      ; =0x830e =33550(-31986) [Jump direct]
830b(7182BC )D830B JMP/  J82BC      ; =0x82bc =33468(-32068) [Jump direct]
830e(463320+)J830E C     /LINE(4),/ZERO(4) ; =0x86cb =34507(-31029),=0x808e =32910(-32626) [Compare bignums, direct, direct]
8315(1803   )      BGZ   D831A      ; =+3 [Branch if greater than zero]
8317(71831D )      JMP/  J831D      ; =0x831d =33565(-31971) [Jump direct]
831a(7182BC )D831A JMP/  J82BC      ; =0x82bc =33468(-32068) [Jump direct]
831d(56     )J831D EAO              ; [Enable abort on overflow]
831e(2A     )      CLAB             ; [Clear AL]
831f(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8322(46073C+)      ZAD   =1,/X@W64A(8) ; =0x8971 =35185(-30351) [Zero-add bignum, literal=0x01, direct]
8328(467330+)      ZAD   /X@W64A(8),/FLAG3(4) ; =0x8971 =35185(-30351),=0x86d7 =34519(-31017) [Zero-add bignum, direct, direct]
832f(57     )      DAO              ; [Disable abort on overflow]
8330(56     )      EAO              ; [Enable abort on overflow]
8331(2A     )      CLAB             ; [Clear AL]
8332(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8335(463730+)      ZAD   /LINE(4),/X@W64A(8) ; =0x86cb =34507(-31029),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
833c(463710+)      S     /FLAG2(4),/X@W64A(8) ; =0x86b7 =34487(-31049),=0x8971 =35185(-30351) [Subtract bignums, direct, direct]
8343(467330+)      ZAD   /X@W64A(8),/LINE(4) ; =0x8971 =35185(-30351),=0x86cb =34507(-31029) [Zero-add bignum, direct, direct]
834a(57     )      DAO              ; [Disable abort on overflow]
834b(56     )      EAO              ; [Enable abort on overflow]
834c(2A     )      CLAB             ; [Clear AL]
834d(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8350(463730+)      ZAD   /COL(4),/X@W64A(8) ; =0x86cf =34511(-31025),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
8357(463710+)      S     /FLAG2(4),/X@W64A(8) ; =0x86b7 =34487(-31049),=0x8971 =35185(-30351) [Subtract bignums, direct, direct]
835e(467330+)      ZAD   /X@W64A(8),/COL(4) ; =0x8971 =35185(-30351),=0x86cf =34511(-31025) [Zero-add bignum, direct, direct]
8365(57     )      DAO              ; [Disable abort on overflow]
8366(56     )      EAO              ; [Enable abort on overflow]
8367(2A     )      CLAB             ; [Clear AL]
8368(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
836b(463730+)      ZAD   /LINE(4),/X@W64A(8) ; =0x86cb =34507(-31029),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
8372(463750+)      M     /FLAG4(4),/X@W64A(8) ; =0x86b3 =34483(-31053),=0x8971 =35185(-30351) [Multiply bignums, direct, direct]
8379(463700+)      A     /COL(4),/X@W64A(8) ; =0x86cf =34511(-31025),=0x8971 =35185(-30351) [Add bignums, direct, direct]
8380(467330+)      ZAD   /X@W64A(8),/SECOFF(4) ; =0x8971 =35185(-30351),=0x86d3 =34515(-31021) [Zero-add bignum, direct, direct]
8387(57     )      DAO              ; [Disable abort on overflow]
8388(463320+)      C     /SECOFF(4),/SECSIZE(4) ; =0x86d3 =34515(-31021),=0x86af =34479(-31057) [Compare bignums, direct, direct]
838f(1903   )      BLE   D8394      ; =+3 [Branch if less than or equal to zero]
8391(718397 )      JMP/  J8397      ; =0x8397 =33687(-31849) [Jump direct]
8394(7182BC )D8394 JMP/  J82BC      ; =0x82bc =33468(-32068) [Jump direct]
8397(56     )J8397 EAO              ; [Enable abort on overflow]
8398(2A     )      CLAB             ; [Clear AL]
8399(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
839c(463730+)      ZAD   /SECSIZE(4),/X@W64A(8) ; =0x86af =34479(-31057),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
83a3(463710+)      S     /SECOFF(4),/X@W64A(8) ; =0x86d3 =34515(-31021),=0x8971 =35185(-30351) [Subtract bignums, direct, direct]
83aa(467330+)      ZAD   /X@W64A(8),/SECREM(4) ; =0x8971 =35185(-30351),=0x86c7 =34503(-31033) [Zero-add bignum, direct, direct]
83b1(57     )      DAO              ; [Disable abort on overflow]
83b2(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
83b4(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
83b6(8924   )      DW    FMT1       ; =0x8924 =35108(-30428) [address of format]
83b8(85CA   )      DW    STR6       ; =0x85ca =34250(-31286) [address of argument]
83ba(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
83bc(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
83be(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
83c0(8947   )      DW    FMT7       ; =0x8947 =35143(-30393) [address of format]
83c2(88D3   )      DW    DBUFF      ; =0x88d3 =35027(-30509) =BS,'S' [address of argument]
83c4(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
83c6(908742 )      LDA=  W8742      ; =0x8742 =34626(-30910) [Load A with immediate]
83c9(D186D5 )      LDB/  W86D5      ; =0x86d5 =34517(-31019) [Load B direct]
83cc(58     )      AAB              ; [A + B -> B]
83cd(F18536 )      STB/  CURRADDR   ; =0x8536 =34102(-31434) [Store B direct]
83d0(9088D3 )      LDA=  DBUFF      ; =0x88d3 =35027(-30509) =BS,'S' [Load A with immediate]
83d3(5C     )      XAY              ; [Transfer A to Y]
83d4(8561   )D83D4 LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
83d6(1430   )      BZ    D8408      ; =+48 [Branch if zero]
83d8(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
83da(49     )      SABB             ; [AL - BL -> BL]
83db(142B   )      BZ    D8408      ; =+43 [Branch if zero]
83dd(798527 )      JSR/  UNHEXNIB   ; =0x8527 =34087(-31449) [Jump to subroutine direct]
83e0(2533   )      SLRB  BL,4       ; [Left shift BL by 4]
83e2(E18538 )      STBB/ CURRBYTE   ; =0x8538 =34104(-31432) [Store BL direct]
83e5(8561   )      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
83e7(141F   )      BZ    D8408      ; =+31 [Branch if zero]
83e9(C0A0   )      LDBB= X'A0'      ; =160(-96) =' ' [Load BL with immediate]
83eb(49     )      SABB             ; [AL - BL -> BL]
83ec(141A   )      BZ    D8408      ; =+26 [Branch if zero]
83ee(798527 )      JSR/  UNHEXNIB   ; =0x8527 =34087(-31449) [Jump to subroutine direct]
83f1(818538 )      LDAB/ CURRBYTE   ; =0x8538 =34104(-31432) [Load AL direct]
83f4(48     )      AABB             ; [AL + BL -> BL]
83f5(918536 )      LDA/  CURRADDR   ; =0x8536 =34102(-31434) [Load A direct]
83f8(E501   )      STBB+ A+         ; [Store BL indexed, direct, post-incremented]
83fa(B18536 )      STA/  CURRADDR   ; =0x8536 =34102(-31434) [Store A direct]
83fd(9186C9 )      LDA/  W86C9      ; =0x86c9 =34505(-31031) [Load A direct]
8400(39     )      DCA              ; [Decrement A]
8401(1405   )      BZ    D8408      ; =+5 [Branch if zero]
8403(B186C9 )      STA/  W86C9      ; =0x86c9 =34505(-31031) [Store A direct]
8406(73CC   )      JMP   D83D4      ; =-52 [Jump relative]
8408(798446 )D8408 JSR/  PRINTSEC   ; =0x8446 =33862(-31674) [Jump to subroutine direct]
840b(463023+)J840B C     /FLAG3(4),=0 ; =0x86d7 =34519(-31017), [Compare bignums, direct, literal=0x00]
8411(1403   )      BZ    D8416      ; =+3 [Branch if zero]
8413(718419 )      JMP/  J8419      ; =0x8419 =33817(-31719) [Jump direct]
8416(7181ED )D8416 JMP/  J81ED      ; =0x81ed =33261(-32275) [Jump direct]
8419(798A2D )J8419 JSR/  YNGET      ; =0x8a2d =35373(-30163) [Jump to subroutine direct]
841c(8611   )      DW    STR7       ; =0x8611 =34321(-31215)
841e(463023+)      C     /STATUS(4),=0 ; =0x808f =32911(-32625), [Compare bignums, direct, literal=0x00]
8424(1403   )      BZ    D8429      ; =+3 [Branch if zero]
8426(71842C )      JMP/  J842C      ; =0x842c =33836(-31700) [Jump direct]
8429(7182BC )D8429 JMP/  J82BC      ; =0x82bc =33468(-32068) [Jump direct]
842c(8002   )J842C LDAB= X'02'      ; =2 [Load AL with immediate]
842e(A18120 )      STAB/ B8120      ; =0x8120 =33056(-32480) [Store AL direct]
8431(D0811D )      LDB=  SYS0       ; =0x811d =33053(-32483) [Load B with immediate]
8434(6618   )      SVC   24         ; =0x18 [Service call LIOC - logical I/O control]
8436(7181ED )      JMP/  J81ED      ; =0x81ed =33261(-32275) [Jump direct]
8439(6635   )J8439 SVC   53         ; =0x35 [Service call WF - CPL formatted write]
843b(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
843d(8924   )      DW    FMT1       ; =0x8924 =35108(-30428) [address of format]
843f(857F   )      DW    STR8       ; =0x857f =34175(-31361) [address of argument]
8441(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8443(660A   )      SVC   10         ; =0x0A [Service call EXIT - exit to OJX00]
8445(FF     )      DB    X'FF'      ; =0xff =255(-1) [completion code]
*
* Function PRINTSEC
*
8446(6635   )PRINTSEC SVC   53         ; =0x35 [Service call WF - CPL formatted write]
8448(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
844a(8928   )      DW    FMT4       ; =0x8928 =35112(-30424) [address of format]
844c(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
844e(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
8450(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
8452(894F   )      DW    FMT5       ; =0x894f =35151(-30385) [address of format]
8454(861C   )      DW    STR9       ; =0x861c =34332(-31204) [address of argument]
8456(890E   )      DW    FULLNAME   ; =0x890e =35086(-30450) [address of argument]
8458(8627   )      DW    STR10      ; =0x8627 =34343(-31193) [address of argument]
845a(86BF   )      DW    UNITNUM    ; =0x86bf =34495(-31041) [address of argument]
845c(862D   )      DW    STR11      ; =0x862d =34349(-31187) [address of argument]
845e(813B   )      DW    SYS0KEY    ; =0x813b =33083(-32453) [address of argument]
8460(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8462(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
8464(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
8466(8928   )      DW    FMT4       ; =0x8928 =35112(-30424) [address of format]
8468(8664   )      DW    STR12      ; =0x8664 =34404(-31132) [address of argument]
846a(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
846c(56     )      EAO              ; [Enable abort on overflow]
846d(2A     )      CLAB             ; [Clear AL]
846e(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
8471(463730+)      ZAD   /ZERO(4),/X@W64A(8) ; =0x808e =32910(-32626),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
8478(467330+)      ZAD   /X@W64A(8),/COUNTER(4) ; =0x8971 =35185(-30351),=0x86c3 =34499(-31037) [Zero-add bignum, direct, direct]
847f(57     )      DAO              ; [Disable abort on overflow]
8480(8010   )      LDAB= X'10'      ; =16 [Load AL with immediate]
8482(A000   )B8482 STAB= X'00'      ; =0 =NUL [Store AL immediate]
8484(908742 )      LDA=  W8742      ; =0x8742 =34626(-30910) [Load A with immediate]
8487(5C     )      XAY              ; [Transfer A to Y]
8488(8019   )J8488 LDAB= X'19'      ; =25 [Load AL with immediate]
848a(A000   )B848A STAB= X'00'      ; =0 =NUL [Store AL immediate]
848c(8049   )      LDAB= X'49'      ; =73 [Load AL with immediate]
848e(A320   )      STAB  B84AE+2    ; =+32 [Store AL relative]
8490(D086DB )      LDB=  HBUFF      ; =0x86db =34523(-31013) [Load B with immediate]
8493(8B     )D8493 LDAB+ Y          ; [Load AL from address in Y]
8494(798A9B )      JSR/  @HEX       ; =0x8a9b =35483(-30053) [Jump to subroutine direct]
8497(B521   )      STA+  B+         ; [Store A indexed, direct, post-incremented]
8499(90FFFF )      LDA=  X'FFFF'    ; =0xffff =65535(-1) [Load A with immediate]
849c(8561   )      LDAB+ Y+         ; [Load AL indexed, direct, post-incremented]
849e(4110   )      SUBB  AL,AU      ; [AL - AU -> AU]
84a0(140A   )      BZ    D84AC      ; =+10 [Branch if zero]
84a2(90A0A0 )      LDA=  X'A0A0'    ; =0xa0a0 =41120(-24416) =' ',' ' [Load A with immediate]
84a5(8568FF )      LDAB+ Y,-1       ; [Load AL indexed, displaced, direct]
84a8(4110   )      SUBB  AL,AU      ; [AL - AU -> AU]
84aa(1002   )      BL    B84AE      ; =+2 [Branch on link]
84ac(80AE   )D84AC LDAB= X'AE'      ; =174(-82) ='.' [Load AL with immediate]
84ae(A52849 )B84AE STAB+ B,73       ; [Store AL indexed, displaced, direct]
84b1(83FD   )      LDAB  B84AE+2    ; =-3 [Load AL relative]
84b3(29     )      DCAB             ; [Decrement AL]
84b4(29     )      DCAB             ; [Decrement AL]
84b5(A3F9   )      STAB  B84AE+2    ; =-7 [Store AL relative]
84b7(80A0   )      LDAB= X'A0'      ; =160(-96) =' ' [Load AL with immediate]
84b9(A521   )      STAB+ B+         ; [Store AL indexed, direct, post-incremented]
84bb(83CE   )      LDAB  B848A+1    ; =-50 [Load AL relative]
84bd(29     )      DCAB             ; [Decrement AL]
84be(1404   )      BZ    D84C4      ; =+4 [Branch if zero]
84c0(A3C9   )      STAB  B848A+1    ; =-55 [Store AL relative]
84c2(73CF   )      JMP   D8493      ; =-49 [Jump relative]
84c4(5560   )D84C4 XFR   Y,A        ; [Transfer Y to A]
84c6(B5A2   )      STA-  S-         ; [Store A indexed, pre-decremented, direct]
84c8(56     )      EAO              ; [Enable abort on overflow]
84c9(2A     )      CLAB             ; [Clear AL]
84ca(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
84cd(463730+)      ZAD   /COUNTER(4),/X@W64A(8) ; =0x86c3 =34499(-31037),=0x8971 =35185(-30351) [Zero-add bignum, direct, direct]
84d4(463700+)      A     /FLAG2(4),/X@W64A(8) ; =0x86b7 =34487(-31049),=0x8971 =35185(-30351) [Add bignums, direct, direct]
84db(467330+)      ZAD   /X@W64A(8),/COUNTER(4) ; =0x8971 =35185(-30351),=0x86c3 =34499(-31037) [Zero-add bignum, direct, direct]
84e2(57     )      DAO              ; [Disable abort on overflow]
84e3(463320+)      C     /FLAG1(4),/FLAG2(4) ; =0x86bb =34491(-31045),=0x86b7 =34487(-31049) [Compare bignums, direct, direct]
84ea(1403   )      BZ    D84EF      ; =+3 [Branch if zero]
84ec(7184F2 )      JMP/  J84F2      ; =0x84f2 =34034(-31502) =EOT,'r' [Jump direct]
84ef(718509 )D84EF JMP/  J8509      ; =0x8509 =34057(-31479) [Jump direct]
84f2(6635   )J84F2 SVC   53         ; =0x35 [Service call WF - CPL formatted write]
84f4(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
84f6(8928   )      DW    FMT4       ; =0x8928 =35112(-30424) [address of format]
84f8(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
84fa(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
84fc(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
84fe(8928   )      DW    FMT4       ; =0x8928 =35112(-30424) [address of format]
8500(86DB   )      DW    HBUFF      ; =0x86db =34523(-31013) [address of argument]
8502(86C3   )      DW    COUNTER    ; =0x86c3 =34499(-31037) [address of argument]
8504(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8506(718515 )      JMP/  J8515      ; =0x8515 =34069(-31467) [Jump direct]
8509(6635   )J8509 SVC   53         ; =0x35 [Service call WF - CPL formatted write]
850b(815D   )      DW    LST        ; =0x815d =33117(-32419) [address of RCB]
850d(893D   )      DW    FMT8       ; =0x893d =35133(-30403) [address of format]
850f(86DB   )      DW    HBUFF      ; =0x86db =34523(-31013) [address of argument]
8511(86C3   )      DW    COUNTER    ; =0x86c3 =34499(-31037) [address of argument]
8513(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
*
8515(818483 )J8515 LDAB/ B8482+1    ; =0x8483 =33923(-31613) [Load AL direct]
8518(29     )      DCAB             ; [Decrement AL]
8519(1409   )      BZ    D8524      ; =+9 [Branch if zero]
851b(A18483 )      STAB/ B8482+1    ; =0x8483 =33923(-31613) [Store AL direct]
851e(95A1   )      LDA+  S+         ; [Load A indexed, direct, post-incremented]
8520(5C     )      XAY              ; [Transfer A to Y]
8521(718488 )      JMP/  J8488      ; =0x8488 =33928(-31608) =EOT,BS [Jump direct]
8524(95A1   )D8524 LDA+  S+         ; [Load A indexed, direct, post-incremented]
8526(09     )      RSR              ; [Return from subroutine]
*
* Function UNHEXNIB
*
8527(4512   )UNHEXNIB XFRB  AL,BU      ; [Transfer AL to BU]
8529(3521   )      SLR   B,2        ; [Left shift B by 2]
852b(1105   )      BNL   D8532      ; =+5 [Branch on no link]
852d(C009   )      LDBB= X'09'      ; =9 [Load BL with immediate]
852f(48     )      AABB             ; [AL + BL -> BL]
8530(4531   )      XFRB  BL,AL      ; [Transfer BL to AL]
8532(C00F   )D8532 LDBB= X'0F'      ; =15 [Load BL with immediate]
8534(4A     )      NABB             ; [AL & BL -> BL]
8535(09     )      RSR              ; [Return from subroutine]
*
8536(0000   )CURRADDR DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8538(00     )CURRBYTE DB    X'00'      ; =0x00 =0 =NUL
8539(C4C9D3+)STR1  DC    'DISK TO PRINTER SECTOR DUMP'
8554(00     )      DB    X'00'      ; =0x00 =0 =NUL
8555(C5CED4+)STR3  DC    'ENTER "N", "P", OR RELATIVE SECTOR NUMBER'
857e(00     )      DB    X'00'      ; =0x00 =0 =NUL
857f(C5CEC4+)STR8  DC    'END JOB SDMP'
858b(00     )      DB    X'00'      ; =0x00 =0 =NUL
858c(C5CED4+)STR5  DC    'ENTER LINE#(01-16) & COLUMN#(01-25) FOR CHANGE OR LEAVE BLANK'
85c9(00     )      DB    X'00'      ; =0x00 =0 =NUL
85ca(C5CED4+)STR6  DC    'ENTER DATA (50 DIGITS OR LESS).'
85e9(00     )      DB    X'00'      ; =0x00 =0 =NUL
85ea(AAAAA0+)STR4  DC    '** EOM ENCOUNTERED, INVALID COMMAND **'
8610(00     )      DB    X'00'      ; =0x00 =0 =NUL
8611(C4C1D4+)STR7  DC    'DATA OK???' ; hex:c4c1d4c1a0cfcbbfbfbf
861b(00     )      DB    X'00'      ; =0x00 =0 =NUL
861c(C6C9CC+)STR9  DC    'FILE NAME:' ; hex:c6c9ccc5a0cec1cdc5ba
8626(00     )      DB    X'00'      ; =0x00 =0 =NUL
8627(C4C9D3+)STR10 DC    'DISK:'    ; hex:c4c9d3cbba
862c(00     )      DB    X'00'      ; =0x00 =0 =NUL
862d(D2C5CC+)STR11 DC    'RELATIVE SECTOR:'
863d(00     )      DB    X'00'      ; =0x00 =0 =NUL
863e(C9D3A0+)STR2  DC    'IS OUTPUT GOING TO VIDEO? Y/N'
865b(00     )      DB    X'00'      ; =0x00 =0 =NUL
865c(D9     )      DC    'Y'        ; hex:d9 dec:217(-39)
865d(00     )      DB    X'00'      ; =0x00 =0 =NUL
865e(A0     )      DC    ' '        ; hex:a0 dec:160(-96)
865f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8660(CE     )NSTR  DC    'N'        ; hex:ce dec:206(-50)
8661(00     )      DB    X'00'      ; =0x00 =0 =NUL
8662(D0     )PSTR  DC    'P'        ; hex:d0 dec:208(-48)
8663(00     )      DB    X'00'      ; =0x00 =0 =NUL
8664(A0A0A0+)STR12 DC    ' ',13    
8671(B5     )      DC    '5'        ; hex:b5 dec:181(-75)
8672(A0A0A0+)      DC    ' ',13    
867f(B1B0   )      DC    '10'       ; hex:b1b0 dec:45488(-80)
8681(A0A0A0+)      DC    ' ',13    
868e(B1B5   )      DC    '15'       ; hex:b1b5 dec:45493(-75)
8690(A0A0A0+)      DC    ' ',13    
869d(B2B0   )      DC    '20'       ; hex:b2b0 dec:45744(-80)
869f(A0A0A0+)      DC    ' ',13    
86ac(B2B5   )      DC    '25'       ; hex:b2b5 dec:45749(-75)
86ae(00     )      DB    X'00'      ; =0x00 =0 =NUL
86af(0000   )SECSIZE DW    X'0000'    ; =0x0000 =0 =NUL,NUL
86b1(0190   )      DW    X'0190'    ; =0x0190 =400
86b3(000000 )FLAG4 DB    0,3        ; =0x00,0x0003
86b6(19     )      DB    X'19'      ; =0x19 =25
86b7(000000 )FLAG2 DB    0,3        ; =0x00,0x0003
86ba(01     )      DB    X'01'      ; =0x01 =1
86bb(000000+)FLAG1 DB    0,4        ; =0x00,0x0004
86bf(000000 )UNITNUM DB    0,3        ; =0x00,0x0003
86c2(00     )P86C2 DB    X'00'      ; =0x00 =0 =NUL
86c3(       )COUNTER DS    4          ; =0x0004 [Uninitialized memory]
86c7(       )SECREM DS    2          ; =0x0002 [Uninitialized memory]
86c9(       )W86C9 DS    2          ; =0x0002 [Uninitialized memory]
86cb(       )LINE  DS    4          ; =0x0004 [Uninitialized memory]
86cf(       )COL   DS    4          ; =0x0004 [Uninitialized memory]
86d3(       )SECOFF DS    2          ; =0x0002 [Uninitialized memory]
86d5(       )W86D5 DS    2          ; =0x0002 [Uninitialized memory]
86d7(       )FLAG3 DS    4          ; =0x0004 [Uninitialized memory]
86db(       )HBUFF DS    100        ; =0x0064 [Uninitialized memory]
873f(00     )      DB    X'00'      ; =0x00 =0 =NUL
8740(0190   )SECDATA DW    X'0190'    ; =0x0190 =400
8742(       )W8742 DS    401        ; =0x0191 [Uninitialized memory]
*
88d3(       )DBUFF DS    50         ; =0x0032 [Uninitialized memory]
8905(00     )      DB    X'00'      ; =0x00 =0 =NUL
8906(       )INBUFF DS    5          ; =0x0005 [Uninitialized memory]
890b(       )W890B DS    1          ; =0x0001 [Uninitialized memory]
890c(00     )      DB    X'00'      ; =0x00 =0 =NUL
890d(00     )EMPTYSTR DB    X'00'      ; =0x00 =0 =NUL
890e(       )FULLNAME DS    21         ; =0x0015 [Uninitialized memory]
8923(00     )      DB    X'00'      ; =0x00 =0 =NUL
8924(02     )FMT1  DB    X'02'      ; =0x02 =2 [data type] C
8925(0050   )      DW    X'0050'    ; =0x0050 =80 [length]
8927(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
8928(02     )FMT4  DB    X'02'      ; =0x02 =2 [data type] C
8929(0064   )      DW    X'0064'    ; =0x0064 =100 [length]
892b(01     )      DB    X'01'      ; =0x01 =1 [data type] X
892c(0001   )      DW    X'0001'    ; =0x0001 =1 [length]
892e(F9     )      DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
892f(0002   )      DW    X'0002'    ; =0x0002 =2 [length]
8931(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
8932(02     )FMT2  DB    X'02'      ; =0x02 =2 [data type] C
8933(0005   )      DW    X'0005'    ; =0x0005 =5 [length]
8935(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
8936(F9     )FMT6  DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
8937(0002   )      DW    X'0002'    ; =0x0002 =2 [length]
8939(F9     )      DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
893a(0002   )      DW    X'0002'    ; =0x0002 =2 [length]
893c(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
893d(02     )FMT8  DB    X'02'      ; =0x02 =2 [data type] C
893e(004B   )      DW    X'004B'    ; =0x004b =75 [length]
8940(01     )      DB    X'01'      ; =0x01 =1 [data type] X
8941(0001   )      DW    X'0001'    ; =0x0001 =1 [length]
8943(F9     )      DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
8944(0002   )      DW    X'0002'    ; =0x0002 =2 [length]
8946(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
8947(02     )FMT7  DB    X'02'      ; =0x02 =2 [data type] C
8948(0032   )      DW    X'0032'    ; =0x0032 =50 [length]
894a(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
894b(F9     )FMT3  DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
894c(0005   )      DW    X'0005'    ; =0x0005 =5 [length]
894e(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
894f(02     )FMT5  DB    X'02'      ; =0x02 =2 [data type] C
8950(000A   )      DW    X'000A'    ; =0x000a =10 [length]
8952(01     )      DB    X'01'      ; =0x01 =1 [data type] X
8953(0001   )      DW    X'0001'    ; =0x0001 =1 [length]
8955(02     )      DB    X'02'      ; =0x02 =2 [data type] C
8956(0015   )      DW    X'0015'    ; =0x0015 =21 [length]
8958(01     )      DB    X'01'      ; =0x01 =1 [data type] X
8959(0004   )      DW    X'0004'    ; =0x0004 =4 [length]
895b(02     )      DB    X'02'      ; =0x02 =2 [data type] C
895c(0005   )      DW    X'0005'    ; =0x0005 =5 [length]
895e(F9     )      DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
895f(0002   )      DW    X'0002'    ; =0x0002 =2 [length]
8961(01     )      DB    X'01'      ; =0x01 =1 [data type] X
8962(0004   )      DW    X'0004'    ; =0x0004 =4 [length]
8964(02     )      DB    X'02'      ; =0x02 =2 [data type] C
8965(0010   )      DW    X'0010'    ; =0x0010 =16 [length]
8967(F9     )      DB    X'F9'      ; =0xf9 =249(-7) ='y' [data type] N
8968(0004   )      DW    X'0004'    ; =0x0004 =4 [length]
896a(00     )      DB    X'00'      ; =0x00 =0 =NUL [null terminator]
896b(8C00   )EJECT DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
896d(8700   )BEEP  DW    X'8700'    ; =0x8700 =34560(-30976) =BEL,NUL
896f(8B00   )VTAB  DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8971(       )X@W64A DS    8          ; =0x0008 [Uninitialized memory]
*
8979(000000+)DATEI DB    0,4        ; =0x00,0x0004
*
897d(000000+)DATES DB    0,9        ; =0x00,0x0009
*
* Function CGET (P.APLIB6)
* ASM: JSR/ CGET
*      DW MSGADDR ; address of null-terminated message string
*      DW FMTADDR ; address of CPL format
*      DW VARADDR ; address of string or integer result
* CPL: CALL CGET(strname, fmtname, varname)
*
8986(9541   )CGET  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8988(B31B   )      STA   W89A5      ; =+27 [Store A relative]
898a(D541   )      LDB+  X+         ; [Load B indexed, direct, post-incremented]
898c(F32C   )      STB   W89BA      ; =+44 [Store B relative]
898e(952801 )      LDA+  B,1        ; [Load A indexed, displaced, direct]
8991(B31E   )      STA   W89B1      ; =+30 [Store A relative]
8993(89     )      LDAB+ B          ; [Load AL from address in B]
8994(C0C0   )      LDBB= X'C0'      ; =192(-64) ='@' [Load BL with immediate]
8996(2111   )      DCRB  AL,2       ; [Decrement AL by 2]
8998(1402   )      BZ    D899C      ; =+2 [Branch if zero]
899a(C0A3   )      LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
899c(E347   )D899C STBB  W89E5      ; =+71 [Store BL relative]
899e(9541   )      LDA+  X+         ; [Load A indexed, direct, post-incremented]
89a0(B31A   )      STA   W89BC      ; =+26 [Store A relative]
89a2(798A0E )      JSR/  MSGN       ; =0x8a0e =35342(-30194) [Jump to subroutine direct]
89a5(0000   )W89A5 DW    X'0000'    ; =0x0000 =0 =NUL,NUL
*
89a7(798A0E )      JSR/  MSGN       ; =0x8a0e =35342(-30194) [Jump to subroutine direct]
89aa(89E6   )      DW    S89E6      ; =0x89e6 =35302(-30234)
89ac(01     )      NOP              ; [No operation]
89ad(6630   )      SVC   48         ; =0x30 [Service call CC - CPL cursor blanking with specified string]
89af(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB] [address of string]
89b1(0000   )W89B1 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [count]
89b3(89E5   )      DW    W89E5      ; =0x89e5 =35301(-30235)
89b5(01     )      NOP              ; [No operation]
89b6(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
89b8(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
89ba(0000   )W89BA DW    X'0000'    ; =0x0000 =0 =NUL,NUL [address of format]
89bc(0000   )W89BC DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
89be(00     )      HLT              ; [Halt]
89bf(00     )      HLT              ; [Halt]
89c0(908095 )      LDA=  @LL        ; =0x8095 =32917(-32619) [Load A with immediate]
89c3(5C     )      XAY              ; [Transfer A to Y]
89c4(9561   )      LDA+  Y+         ; [Load A indexed, direct, post-incremented]
89c6(D31D   )      LDB   W89E5      ; =+29 [Load B relative]
89c8(C0A3   )      LDBB= X'A3'      ; =163(-93) ='#' [Load BL with immediate]
89ca(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
89cc(150C   )      BNZ   D89DA      ; =+12 [Branch if not zero]
89ce(5006   )      ADD   A,Y        ; [A + Y -> Y]
89d0(D568FF )      LDB+  Y,-1       ; [Load B indexed, displaced, direct]
89d3(C0AB   )      LDBB= X'AB'      ; =171(-85) ='+' [Load BL with immediate]
89d5(4123   )      SUBB  BU,BL      ; [BU - BL -> BL]
89d7(1501   )      BNZ   D89DA      ; =+1 [Branch if not zero]
89d9(39     )      DCA              ; [Decrement A]
89da(D3D5   )D89DA LDB   W89B1      ; =-43 [Load B relative]
89dc(59     )      SAB              ; [A - B -> B]
89dd(1905   )      BLE   D89E4      ; =+5 [Branch if less than or equal to zero]
89df(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
89e1(A18092 )      STAB/ @IF        ; =0x8092 =32914(-32622) [Store AL direct]
89e4(09     )D89E4 RSR              ; [Return from subroutine]
*
89e5(00     )W89E5 DB    X'00'      ; =0x00 =0 =NUL
89e6(A0AF   )S89E6 DC    ' /'       ; hex:a0af dec:41135(-81)
89e8(00     )      DB    X'00'      ; =0x00 =0 =NUL
89e9(6656   )      DW    X'6656'    ; =0x6656 =26198
89eb(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
89ed(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
*
* Function MSG (P.APLIB6)
* ASM: JSR/ MSG
*      DW MSGADDR ; address of null-terminated message string
* CPL: CALL MSG(strname)
*
89ef(9541   )MSG   LDA+  X+         ; [Load A indexed, direct, post-incremented]
89f1(B306   )      STA   W89F9      ; =+6 [Store A relative]
89f3(6635   )      SVC   53         ; =0x35 [Service call WF - CPL formatted write]
89f5(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
89f7(89FE   )      DW    L89FE      ; =0x89fe =35326(-30210) [address of format]
89f9(0000   )W89F9 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
89fb(00     )      HLT              ; [Halt]
89fc(00     )      HLT              ; [Halt]
89fd(09     )      RSR              ; [Return from subroutine]
*
89fe(0200   )L89FE DW    X'0200'    ; =0x0200 =512
8a00(4F00   )      DW    X'4F00'    ; =0x4f00 =20224
8a02(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8a04(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8a06(       )      DS    8          ; =0x0008 [Uninitialized memory]
*
* Function MSGN (P.APLIB6)
* ASM: JSR/ MSG
*      DW MSGADDR ; address of null-terminated message string
* CPL: CALL MSGN(strname)
*
8a0e(9541   )MSGN  LDA+  X+         ; [Load A indexed, direct, post-incremented]
8a10(B306   )      STA   W8A18      ; =+6 [Store A relative]
8a12(6631   )      SVC   49         ; =0x31 [Service call WN - CPL formatted write without CR]
8a14(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
8a16(8A1D   )      DW    L8A1D      ; =0x8a1d =35357(-30179) [address of format]
8a18(0000   )W8A18 DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8a1a(00     )      HLT              ; [Halt]
8a1b(00     )      HLT              ; [Halt]
8a1c(09     )      RSR              ; [Return from subroutine]
*
8a1d(0200   )L8A1D DW    X'0200'    ; =0x0200 =512
8a1f(4F00   )      DW    X'4F00'    ; =0x4f00 =20224
8a21(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8a23(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8a25(       )      DS    8          ; =0x0008 [Uninitialized memory]
*
*
* Function YNGET (P.APLIB6)
* ASM: JSR/ YNGET
*      DW STRADDR ; address of null-terminated message string
* CPL: CALL YNGET(strname)
*
8a2d(9541   )YNGET LDA+  X+         ; [Load A indexed, direct, post-incremented]
8a2f(B306   )      STA   W8A37      ; =+6 [Store A relative]
8a31(6631   )J8A31 SVC   49         ; =0x31 [Service call WN - CPL formatted write without CR]
8a33(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
8a35(8A6E   )      DW    L8A6E      ; =0x8a6e =35438(-30098) [address of format]
8a37(8A79   )W8A37 DW    S8A79      ; =0x8a79 =35449(-30087) [address of argument]
8a39(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8a3b(6631   )      SVC   49         ; =0x31 [Service call WN - CPL formatted write without CR]
8a3d(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
8a3f(8A6E   )      DW    L8A6E      ; =0x8a6e =35438(-30098) [address of format]
8a41(8A79   )      DW    S8A79      ; =0x8a79 =35449(-30087) [address of argument]
8a43(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8a45(6634   )      SVC   52         ; =0x34 [Service call RF - CPL formatted read]
8a47(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
8a49(8A72   )      DW    L8A72      ; =0x8a72 =35442(-30094) [address of format]
8a4b(8A76   )      DW    L8A76      ; =0x8a76 =35446(-30090) [address of argument]
8a4d(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8a4f(908A81 )      LDA=  S8A81      ; =0x8a81 =35457(-30079) [Load A with immediate]
8a52(5C     )      XAY              ; [Transfer A to Y]
8a53(8321   )      LDAB  L8A76      ; =+33 [Load AL relative]
8a55(D561   )D8A55 LDB+  Y+         ; [Load B indexed, direct, post-incremented]
8a57(1408   )      BZ    D8A61      ; =+8 [Branch if zero]
8a59(4112   )      SUBB  AL,BU      ; [AL - BU -> BU]
8a5b(15F8   )      BNZ   D8A55      ; =-8 [Branch if not zero]
8a5d(E18092 )      STBB/ @IF        ; =0x8092 =32914(-32622) [Store BL direct]
8a60(09     )      RSR              ; [Return from subroutine]
*
8a61(6631   )D8A61 SVC   49         ; =0x31 [Service call WN - CPL formatted write without CR]
8a63(813F   )      DW    CRT        ; =0x813f =33087(-32449) [address of RCB]
8a65(8A6E   )      DW    L8A6E      ; =0x8a6e =35438(-30098) [address of format]
8a67(8A7E   )      DW    L8A7E      ; =0x8a7e =35454(-30082) [address of argument]
8a69(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL [argument list terminator]
8a6b(718A31 )      JMP/  J8A31      ; =0x8a31 =35377(-30159) [Jump direct]
*
8a6e(0200   )L8A6E DW    X'0200'    ; =0x0200 =512
8a70(4C00   )      DW    X'4C00'    ; =0x4c00 =19456
8a72(0200   )L8A72 DW    X'0200'    ; =0x0200 =512
8a74(0100   )      DW    X'0100'    ; =0x0100 =256
8a76(       )L8A76 DS    2          ; =0x0002 [Uninitialized memory]
8a78(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a79(A0AFAA )S8A79 DC    ' /*'      ; hex:a0afaa
8a7c(8800   )      DW    X'8800'    ; =0x8800 =34816(-30720) =BS,NUL
8a7e(879A   )L8A7E DW    X'879A'    ; =0x879a =34714(-30822)
8a80(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a81(AD     )S8A81 DC    '-'        ; hex:ad dec:173(-83)
8a82(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a83(CE     )      DC    'N'        ; hex:ce dec:206(-50)
8a84(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a85(EE     )      DC    'n'        ; hex:ee dec:238(-18)
8a86(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a87(AB     )      DC    '+'        ; hex:ab dec:171(-85)
8a88(01     )      DB    X'01'      ; =0x01 =1
8a89(D9     )      DC    'Y'        ; hex:d9 dec:217(-39)
8a8a(01     )      DB    X'01'      ; =0x01 =1
8a8b(F9     )      DC    'y'        ; hex:f9 dec:249(-7)
8a8c(0100   )      DW    X'0100'    ; =0x0100 =256
8a8e(00     )      DB    X'00'      ; =0x00 =0 =NUL
8a8f(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
8a91(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
8a93(       )      DS    8          ; =0x0008 [Uninitialized memory]
*
*
* Function @HEX (P.OSLIB6)
* ASM: JSR/ @HEX ; AL contains byte to hex, A will get address of ASCII
*
8a9b(A311   )@HEX  STAB  B8AAE      ; =+17 [Store AL relative]
8a9d(90C0C0 )      LDA=  X'C0C0'    ; =0xc0c0 =49344(-16192) ='@','@' [Load A with immediate]
8aa0(B30D   )      STA   W8AAF      ; =+13 [Store A relative]
8aa2(8002   )      LDAB= X'02'      ; =2 [Load AL with immediate]
8aa4(46E090+)      CFB   /W8AAF(16),/B8AAE(1) ; =0x8aaf =35503(-30033) =LF,'/',=0x8aae =35502(-30034) =LF,'.' [Convert from bignum, direct, direct]
8aab(9302   )      LDA   W8AAF      ; =+2 [Load A relative]
8aad(09     )      RSR              ; [Return from subroutine]
*
8aae(00     )B8AAE DB    X'00'      ; =0x00 =0 =NUL
8aaf(0000   )W8AAF DW    X'0000'    ; =0x0000 =0 =NUL,NUL
8ab1:ENDPT
