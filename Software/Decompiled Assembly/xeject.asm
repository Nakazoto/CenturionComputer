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
8000(000000+)      DB    0,140      ; =0x00,0x008c
808c(8093   )W808C DW    S8093      ; =0x8093 =32915(-32621)
808e(000000+)      DB    0,5        ; =0x00,0x0005
8093(000000+)S8093 DB    0,6        ; =0x00,0x0006
8099(0082   )W8099 DW    X'0082'    ; =0x0082 =130
809b(00     )      DB    X'00'      ; =0x00 =0 =NUL
809c(0200   )      DW    X'0200'    ; =0x0200 =512
809e(84     )      DB    X'84'      ; =0x84 =132(-124) =EOT
809f(80BC   )      DW    W80BC      ; =0x80bc =32956(-32580)
80a1(0000   )      DW    X'0000'    ; =0x0000 =0 =NUL,NUL
80a3(808C   )W80A3 DW    W808C      ; =0x808c =32908(-32628)
*
* Function ENTRY
*
80a5(55BA80+)ENTRY XFR=  W808C,S    ; =0x808c =32908(-32628) [Transfer immediate to S]
80a9(665D   )      SVC   X'5D'      ; =93 [Service call PBKV - set OS block value]
80ab(0002   )      DW    X'0002'    ; =0x0002 =2 [TODO: arg1]
80ad(19     )      DB    X'19'      ; =0x19 =25 [TODO: arg2]
80ae(80A3   )      DW    W80A3      ; =0x80a3 =32931(-32605) [address to read block value]
80b0(D08099 )      LDB=  W8099      ; =0x8099 =32921(-32615) [Load B with immediate]
80b3(6610   )      SVC   X'10'      ; =16 [Service call SYSIO - device-independent logical I/O [all units]]
80b5(6608   )      SVC   X'08'      ; =8 [Service call RBWT - wait for RCB to go ready]
80b7(8099   )      DW    W8099      ; =0x8099 =32921(-32615) [TODO: arg 1]
80b9(660A   )      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
80bb(FF     )      DB    X'FF'      ; =0xff =255(-1) [completion code]
*
80bc(0002   )W80BC DW    X'0002'    ; =0x0002 =2
80be(8C8D   )      DW    X'8C8D'    ; =0x8c8d =35981(-29555) =FF,CR
80c0(8C00   )      DW    X'8C00'    ; =0x8c00 =35840(-29696) =FF,NUL
80c2(8B00   )      DW    X'8B00'    ; =0x8b00 =35584(-29952) =VT,NUL
80c4:ENDPT