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
8000:      DB    0,100      ; =0x00,0x0064
*
* Function ENTRY
*
8064:ENTRY XFR=  ENTRY,S    ; =0x8064 =32868(-32668) [Transfer immediate to S]
8068:      SVC   X'5C'      ; =92 [Service call GBKV - get OS block value]
806a:      DB    X'00'      ; =0x00 =0 =NUL [TODO: arg1]
806b:      DB    X'01'      ; =0x01 =1 [TODO: arg2]
806c:      DB    X'15'      ; =0x15 =21 [TODO: arg3]
806d:W806D DW    W806D      ; =0x806d =32877(-32659) [address to store block value]
806f:      LDB=  W807C      ; =0x807c =32892(-32644) [Load B with immediate]
8072:      SVC   X'5D'      ; =93 [Service call PBKV - set OS block value]
8074:      DW    X'0101'    ; =0x0101 =257 [TODO: arg1]
8076:      DB    X'19'      ; =0x19 =25 [TODO: arg2]
8077:      DW    W806D      ; =0x806d =32877(-32659) [address to read block value]
8079:      SVC   X'0A'      ; =10 [Service call EXIT - exit to OJX00]
807b:      DB    X'FF'      ; =0xff =255(-1) [completion code]
*
807c:W807C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
807e:ENDPT
