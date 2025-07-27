 TITLE 'SMCB'
SMCB BEGIN 0
*
8000(000000+)      DB    0,100      ; =0x00,0x0064
*
* Function ENTRY
*
8064(55BA80+)ENTRY XFR=  ENTRY,S    ; =0x8064 =32868(-32668) [Transfer immediate to S]
8068(665C   )      SVC   92         ; =0x5C [Service call GBKV - get OS block value]
806a(00     )      DB    X'00'      ; =0x00 =0 =NUL [block=TIB]
806b(01     )      DB    X'01'      ; =0x01 =1 [length]
806c(15     )      DB    X'15'      ; =0x15 =21 [offset=TBUPS: utility program switches]
806d(806D   )P806D DW    P806D      ; =0x806d =32877(-32659) [address to store block value]
806f(D0807C )      LDB=  W807C      ; =0x807c =32892(-32644) [Load B with immediate]
8072(665D   )      SVC   93         ; =0x5D [Service call PBKV - set OS block value]
8074(01     )      DB    X'01'      ; =0x01 =1 [block=PUB (RCB/FCB in B)]
8075(01     )      DB    X'01'      ; =0x01 =1 [length]
8076(19     )      DB    X'19'      ; =0x19 =25 [offset=PBMCB: mux control byte]
8077(806D   )      DW    P806D      ; =0x806d =32877(-32659) [address to read block value]
8079(660A   )      SVC   10         ; =0x0A [Service call EXIT - exit to OJX00]
807b(FF     )      DB    X'FF'      ; =0xff =255(-1) [completion code]
807c(0000   )W807C DW    X'0000'    ; =0x0000 =0 =NUL,NUL
807e:ENDPT
