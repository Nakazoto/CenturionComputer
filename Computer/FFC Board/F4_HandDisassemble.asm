
TEST_0:
9800:    02 ce        (0x2ce)
9802:    "01133 CMD AUX MEMORY TEST\r\n\0"

TEST_1:
981e:    03 d9        (0x3d9)
9820:    "01133 CMD SEEK TEST\r\n\0"

TEST_2:
9836:    04 9d        (0x49d)
9838:    "01133 CMD READ TEST\r\n\0"

TEST_3:
984e:    02 d9        (0x2d9)
9850:    "FINCH AUX MEMORY TEST\r\n\0"

TEST_4:
9868:    05 3c        (0x53c)
986a:    "FINCH SEEK TEST\r\n\0"

TEST_5:
987c:    05 ff        (0x5ff)
987e:    "FINCH READ TEST\r\n\0"

TEST_6:
9890:    06 9e        (0x69e)
9892:    "ROM SELF TEST\r\n\n\0"

TEST_7:
98a3:    00 00        (0x0)

WriteString:
98a5:    85 41        ld AL, (RT)+
98a7:    15 01        bnz L_98aa
98a9:    09           ret

L_98aa:
98aa:    7b 02        call (PC+0x02) L_98ae
98ac:    73 f7        jump (PC-0x09) WriteString

L_98ae:
98ae:    c1 f2 00     ld BL, (0xf200)
98b1:    24 30        srl BL
98b3:    24 30        srl BL
98b5:    11 f7        bnc L_98ae
98b7:    a1 f2 01     st AL, (0xf201)
98ba:    09           ret

ReadChar:
98bb:    81 f2 00     ld AL, (0xf200)
98be:    2c           srl! AL
98bf:    11 fa        bnc ReadChar
98c1:    81 f2 01     ld AL, (0xf201)
98c4:    09           ret

Fn_0c5:
98c5:    a5 a2        st AL, -(SP)
98c7:    45 01        mov AL, AH
98c9:    7b 05        call (PC+0x05) Fn_0d0
98cb:    85 a1        ld AL, (SP)+
98cd:    7b 01        call (PC+0x01) Fn_0d0
98cf:    09           ret

Fn_0d0:
98d0:    a5 a2        st AL, -(SP)
98d2:    c0 f0        ld BL, #0xf0
98d4:    42 31        and AL, BL
98d6:    07           fcc
98d7:    26 10        rrc AL
98d9:    2c           srl! AL
98da:    2c           srl! AL
98db:    2c           srl! AL
98dc:    c0 b0        ld BL, #0xb0
98de:    40 31        add AL, BL
98e0:    c0 b9        ld BL, #0xb9
98e2:    49           sub! BL, AL
98e3:    19 04        ble L_98e9
98e5:    c0 07        ld BL, #0x07
98e7:    40 31        add AL, BL

L_98e9:
98e9:    7b c3        call (PC-0x3d) L_98ae
98eb:    85 a1        ld AL, (SP)+
98ed:    c0 0f        ld BL, #0x0f
98ef:    42 31        and AL, BL
98f1:    c0 b0        ld BL, #0xb0
98f3:    40 31        add AL, BL
98f5:    c0 b9        ld BL, #0xb9
98f7:    49           sub! BL, AL
98f8:    19 04        ble L_98fe
98fa:    c0 07        ld BL, #0x07
98fc:    40 31        add AL, BL

L_98fe:
98fe:    7b ae        call (PC-0x52) L_98ae
9900:    09           ret

FinishTest:
9901:    a1 f1 0a     st AL, (0xf10a)
9904:    81 f2 00     ld AL, (0xf200)
9907:    2c           srl! AL
9908:    11 57        bnc L_9961
990a:    81 f2 01     ld AL, (0xf201)
990d:    c0 80        ld BL, #0x80
990f:    43 31        or AL, BL
9911:    c0 83        ld BL, #0x83
9913:    49           sub! BL, AL
9914:    15 4b        bnz L_9961
9916:    81 01 08     ld AL, (0x0108)
9919:    14 32        bz L_994d
991b:    7a 01 12     call @(0x0112)
991e:    "\r\n*** FAIL ***\0"
992d:    a1 f1 0b     st AL, (0xf10b)
9930:    a1 f1 0c     st AL, (0xf10c)

PressSpaceThenExit:
9933:    7a 01 12     call @(0x0112)
9936:    "\r\nPRESS SPACE\x07\r\n\0"
9947:    7a 01 02     call @(0x0102)
994a:    72 01 00     jump @(0x0100) ;

L_994d:
994d:    7a 01 12     call @(0x0112)
9950:    "\r\n*** PASS ***\0"
995f:    73 d2        jump (PC-0x2e) PressSpaceThenExit

L_9961:
9961:    90 c0 00     ld AX, #0xc000
9964:    5f           mov SP, AX
9965:    91 01 1a     ld AX, (0x011a)
9968:    5e           mov EX, AX
9969:    95 41        ld AX, (RT)+
996b:    50 80        add AX, EX
996d:    75 00        jump (A + 0x00)

PrintCtrlCToExit:
996f:    7a 01 12     call @(0x0112)
9972:    "\r\n(CONTROL-C TO EXIT)\r\n\0"
998a:    09           ret

Init:
998b:    3a           clr! AX
998c:    b1 01 08     st AX, (0x0108)
998f:    90 01 ee     ld AX, #0x01ee
9992:    50 80        add AX, EX
9994:    b1 01 18     st AX, (0x0118)
9997:    90 00 d0     ld AX, #0x00d0
999a:    50 80        add AX, EX
999c:    b1 01 0a     st AX, (0x010a)
999f:    90 02 91     ld AX, #0x0291
99a2:    50 80        add AX, EX
99a4:    b1 01 0c     st AX, (0x010c)
99a7:    90 01 6f     ld AX, #0x016f
99aa:    50 80        add AX, EX
99ac:    b1 01 06     st AX, (0x0106)
99af:    90 00 bb     ld AX, #0x00bb
99b2:    50 80        add AX, EX
99b4:    b1 01 02     st AX, (0x0102)
99b7:    90 00 a5     ld AX, #0x00a5
99ba:    50 80        add AX, EX
99bc:    b1 01 12     st AX, (0x0112)
99bf:    90 00 c5     ld AX, #0x00c5
99c2:    50 80        add AX, EX
99c4:    b1 01 10     st AX, (0x0110)
99c7:    90 01 01     ld AX, #0x0101
99ca:    50 80        add AX, EX
99cc:    b1 01 04     st AX, (0x0104)
99cf:    90 01 33     ld AX, #0x0133
99d2:    50 80        add AX, EX
99d4:    b1 01 0e     st AX, (0x010e)
99d7:    55 80        mov AX, EX
99d9:    b1 01 1a     st AX, (0x011a)
99dc:    95 41        ld AX, (RT)+
99de:    b1 01 14     st AX, (0x0114)
99e1:    38           inc! AX
99e2:    b1 01 16     st AX, (0x0116)
99e5:    55 40        mov AX, RT
99e7:    65 a1        ld RT, (SP)+
99e9:    69 01 00     st RT, (0x0100)
99ec:    75 00        jump (A + 0x00)

Fn_1ee:
99ee:    7a 01 0c     call @(0x010c)
99f1:    6d a2        st RT, -(SP)
99f3:    60 03 e8     ld RT, #0x03e8

L_99f6:
99f6:    82 01 16     ld AL, @(0x0116)
99f9:    c0 08        ld BL, #0x08
99fb:    4a           and! BL, AL
99fc:    14 2b        bz L_9a29
99fe:    0e           delay 4.5ms
99ff:    3f           dec RT
9a00:    15 f4        bnz L_99f6
9a02:    7a 01 12     call @(0x0112)
9a05:    "*** BUSY DID NOT CLEAR ***\0"
9a20:    a1 f1 0b     st AL, (0xf10b)
9a23:    a1 f1 0c     st AL, (0xf10c)
9a26:    72 01 0e     jump @(0x010e) ;

L_9a29:
9a29:    60 03 e8     ld RT, #0x03e8

L_9a2c:
9a2c:    2c           srl! AL
9a2d:    10 2b        bc L_9a5a
9a2f:    0e           delay 4.5ms
9a30:    3f           dec RT
9a31:    15 f9        bnz L_9a2c
9a33:    7a 01 12     call @(0x0112)
9a36:    "*** FOUT NEVER CAME ON ***\0"
9a51:    a1 f1 0b     st AL, (0xf10b)
9a54:    a1 f1 0c     st AL, (0xf10c)
9a57:    72 01 0e     jump @(0x010e) ;

L_9a5a:
9a5a:    03           fcn
9a5b:    82 01 14     ld AL, @(0x0114)
9a5e:    15 03        bnz L_9a63
9a60:    65 a1        ld RT, (SP)+
9a62:    09           ret

L_9a63:
9a63:    a5 a2        st AL, -(SP)
9a65:    7a 01 12     call @(0x0112)
9a68:    "*** \0"
9a6d:    85 a1        ld AL, (SP)+
9a6f:    7a 01 0a     call @(0x010a)
9a72:    7a 01 12     call @(0x0112)
9a75:    " ERROR ***\r\n\0"
9a82:    80 01        ld AL, #0x01
9a84:    a1 01 08     st AL, (0x0108)
9a87:    a1 f1 0b     st AL, (0xf10b)
9a8a:    a1 f1 0c     st AL, (0xf10c)
9a8d:    65 a1        ld RT, (SP)+
9a8f:    02           fsn
9a90:    09           ret

Fn_291:
9a91:    6d a2        st RT, -(SP)
9a93:    0e           delay 4.5ms
9a94:    60 03 e8     ld RT, #0x03e8

L_9a97:
9a97:    82 01 16     ld AL, @(0x0116)
9a9a:    2c           srl! AL
9a9b:    2c           srl! AL
9a9c:    11 2d        bnc L_9acb
9a9e:    0e           delay 4.5ms
9a9f:    3f           dec RT
9aa0:    15 f5        bnz L_9a97
9aa2:    7a 01 12     call @(0x0112)
9aa5:    "*** FIN DID NOT GO OFF ***\r\n\0"
9ac2:    a1 f1 0b     st AL, (0xf10b)
9ac5:    a1 f1 0c     st AL, (0xf10c)
9ac8:    72 01 0e     jump @(0x010e) ;

L_9acb:
9acb:    65 a1        ld RT, (SP)+
9acd:    09           ret

Entry_01133_CMD_AUX_MEMORY_TEST:
9ace:    90 01 8b     ld AX, #0x018b
9ad1:    50 80        add AX, EX
9ad3:    7d 00        call (A + 0x00)
9ad5:    f8 08 73     stb? A, [0x00873]
9ad8:    09           ret

Entry_FINCH_AUX_MEMORY_TEST:
9ad9:    90 01 8b     ld AX, #0x018b
9adc:    50 80        add AX, EX
9ade:    7d 00        call (A + 0x00)
9ae0:    f8 00 7a     stb? A, [0x0007a]
9ae3:    01           nop
9ae4:    06           fsc
9ae5:    32 60        clr DX
9ae7:    60 0f 00     ld RT, #0x0f00
9aea:    55 60        mov AX, DX
9aec:    d0 01 1c     ld BX, #0x011c

L_9aef:
9aef:    a5 21        st AL, (BX)+
9af1:    28           inc! AL
9af2:    28           inc! AL
9af3:    28           inc! AL
9af4:    3f           dec RT
9af5:    15 f8        bnz L_9aef
9af7:    90 f0 ff     ld AX, #0xf0ff
9afa:    2f 02        dma_load_count WX
9afc:    90 01 1c     ld AX, #0x011c
9aff:    2f 00        dma_load_addr WX
9b01:    2f 34        dma_set_mode 3
9b03:    2f 06        dma_enable
9b05:    80 46        ld AL, #0x46
9b07:    a2 01 14     st AL, @(0x0114)
9b0a:    7a 01 0c     call @(0x010c)
9b0d:    80 01        ld AL, #0x01
9b0f:    a2 01 14     st AL, @(0x0114)
9b12:    7a 01 0c     call @(0x010c)
9b15:    2a           clr! AL
9b16:    a2 01 14     st AL, @(0x0114)
9b19:    7a 01 0c     call @(0x010c)
9b1c:    80 0f        ld AL, #0x0f
9b1e:    a2 01 14     st AL, @(0x0114)
9b21:    7a 01 0c     call @(0x010c)
9b24:    2a           clr! AL
9b25:    a2 01 14     st AL, @(0x0114)
9b28:    7a 01 18     call @(0x0118)
9b2b:    60 0f 00     ld RT, #0x0f00
9b2e:    3a           clr! AX
9b2f:    d0 01 1c     ld BX, #0x011c

L_9b32:
9b32:    a5 21        st AL, (BX)+
9b34:    3f           dec RT
9b35:    15 fb        bnz L_9b32
9b37:    90 f0 ff     ld AX, #0xf0ff
9b3a:    2f 02        dma_load_count WX
9b3c:    90 01 1c     ld AX, #0x011c
9b3f:    2f 00        dma_load_addr WX
9b41:    2f 34        dma_set_mode 3
9b43:    2f 06        dma_enable
9b45:    80 47        ld AL, #0x47
9b47:    a2 01 14     st AL, @(0x0114)
9b4a:    7a 01 0c     call @(0x010c)
9b4d:    80 01        ld AL, #0x01
9b4f:    a2 01 14     st AL, @(0x0114)
9b52:    7a 01 0c     call @(0x010c)
9b55:    2a           clr! AL
9b56:    a2 01 14     st AL, @(0x0114)
9b59:    7a 01 0c     call @(0x010c)
9b5c:    80 0f        ld AL, #0x0f
9b5e:    a2 01 14     st AL, @(0x0114)
9b61:    7a 01 0c     call @(0x010c)
9b64:    2a           clr! AL
9b65:    a2 01 14     st AL, @(0x0114)
9b68:    7a 01 18     call @(0x0118)
9b6b:    b5 a2        st AX, -(SP)
9b6d:    60 0f 00     ld RT, #0x0f00
9b70:    d0 01 1c     ld BX, #0x011c
9b73:    55 60        mov AX, DX
9b75:    45 10        mov AH, AL

L_9b77:
9b77:    85 21        ld AL, (BX)+
9b79:    bd           st AX, (SP)
9b7a:    41 01        sub AL, AH
9b7c:    15 12        bnz L_9b90
9b7e:    20 00        inc AH
9b80:    20 00        inc AH
9b82:    20 00        inc AH
9b84:    3f           dec RT
9b85:    15 f0        bnz L_9b77
9b87:    95 a1        ld AX, (SP)+
9b89:    20 70        inc DL
9b8b:    7a 01 04     call @(0x0104)
9b8e:    02           fsn
9b8f:    e5

L_9b90:
9b90:    a1 f1 0b     st AL, (0xf10b)
9b93:    a1 f1 0c     st AL, (0xf10c)
9b96:    f5 a2        st BX, -(SP)
9b98:    7a 01 12     call @(0x0112)
9b9b:    "*** ERROR, ADDR=\0"
9bac:    95 a1        ld AX, (SP)+
9bae:    39           dec! AX
9baf:    7a 01 10     call @(0x0110)
9bb2:    7a 01 12     call @(0x0112)
9bb5:    " EXP=\0"
9bbb:    85 a1        ld AL, (SP)+
9bbd:    7a 01 0a     call @(0x010a)
9bc0:    7a 01 12     call @(0x0112)
9bc3:    " ACT=\0"
9bc9:    85 a1        ld AL, (SP)+
9bcb:    7a 01 0a     call @(0x010a)
9bce:    7a 01 12     call @(0x0112)
9bd1:    " ***\0"
9bd6:    72 01 0e     jump @(0x010e) ;

Entry_01133_CMD_SEEK_TEST:
9bd9:    90 01 8b     ld AX, #0x018b
9bdc:    50 80        add AX, EX
9bde:    7d 00        call (A + 0x00)
9be0:    f8 08 7a     stb? A, [0x0087a]
9be3:    01           nop
9be4:    06           fsc
9be5:    d0 41 4d     ld BX, #0x414d
9be8:    90 81 00     ld AX, #0x8100
9beb:    b5 21        st AX, (BX)+
9bed:    90 82 ff     ld AX, #0x82ff
9bf0:    b9           st AX, (BX)
9bf1:    90 ff fb     ld AX, #0xfffb
9bf4:    2f 02        dma_load_count WX
9bf6:    90 41 4d     ld AX, #0x414d
9bf9:    2f 00        dma_load_addr WX
9bfb:    2f 34        dma_set_mode 3
9bfd:    2f 06        dma_enable
9bff:    80 43        ld AL, #0x43
9c01:    a2 01 14     st AL, @(0x0114)
9c04:    7a 01 18     call @(0x0118)
9c07:    13 09        bnn L_9c12

L_9c09:
9c09:    a1 f1 0b     st AL, (0xf10b)
9c0c:    a1 f1 0c     st AL, (0xf10c)
9c0f:    72 01 0e     jump @(0x010e) ;

L_9c12:
9c12:    80 45        ld AL, #0x45
9c14:    a2 01 14     st AL, @(0x0114)
9c17:    7a 01 18     call @(0x0118)
9c1a:    12 ed        bn L_9c09
9c1c:    d0 41 4f     ld BX, #0x414f
9c1f:    90 84 00     ld AX, #0x8400
9c22:    b5 21        st AX, (BX)+
9c24:    80 83        ld AL, #0x83
9c26:    a5 21        st AL, (BX)+
9c28:    3a           clr! AX
9c29:    b5 21        st AX, (BX)+
9c2b:    39           dec! AX
9c2c:    a9           st AL, (BX)
9c2d:    38           inc! AX
9c2e:    38           inc! AX
9c2f:    b1 41 b1     st AX, (0x41b1)

L_9c32:
9c32:    90 41 4d     ld AX, #0x414d
9c35:    2f 00        dma_load_addr WX
9c37:    90 ff f7     ld AX, #0xfff7
9c3a:    2f 02        dma_load_count WX
9c3c:    2f 34        dma_set_mode 3
9c3e:    2f 06        dma_enable
9c40:    80 43        ld AL, #0x43
9c42:    a2 01 14     st AL, @(0x0114)
9c45:    7a 01 18     call @(0x0118)
9c48:    12 bf        bn L_9c09
9c4a:    80 45        ld AL, #0x45
9c4c:    a2 01 14     st AL, @(0x0114)
9c4f:    7a 01 18     call @(0x0118)
9c52:    13 1c        bnn L_9c70
9c54:    7a 01 12     call @(0x0112)
9c57:    "TRACK=\0"
9c5e:    91 41 52     ld AX, (0x4152)
9c61:    7a 01 10     call @(0x0110)
9c64:    7a 01 12     call @(0x0112)
9c67:    "\r\n\0"
9c6a:    a1 f1 0b     st AL, (0xf10b)
9c6d:    a1 f1 0c     st AL, (0xf10c)

L_9c70:
9c70:    91 41 b1     ld AX, (0x41b1)
9c73:    16 1a        blt L_9c8f
9c75:    d1 41 52     ld BX, (0x4152)
9c78:    50 20        add AX, BX
9c7a:    b1 41 52     st AX, (0x4152)
9c7d:    d0 03 36     ld BX, #0x0336
9c80:    59           sub! BX, AX
9c81:    15 af        bnz L_9c32
9c83:    3a           clr! AX
9c84:    39           dec! AX
9c85:    b1 41 b1     st AX, (0x41b1)
9c88:    80 10        ld AL, #0x10
9c8a:    a1 41 50     st AL, (0x4150)
9c8d:    73 a3        jump (PC-0x5d) L_9c32

L_9c8f:
9c8f:    91 41 52     ld AX, (0x4152)
9c92:    39           dec! AX
9c93:    b1 41 52     st AX, (0x4152)
9c96:    17 9a        ble L_9c32
9c98:    7a 01 04     call @(0x0104)
9c9b:    03           fcn
9c9c:    e5 90        st BL, (EX)
9c9e:    01           nop
9c9f:    8b           ld AL, (DX)
9ca0:    50 80        add AX, EX
9ca2:    7d 00        call (A + 0x00)
9ca4:    f8 08 7a     stb? A, [0x0087a]
9ca7:    01           nop
9ca8:    06           fsc
9ca9:    90 41 4d     ld AX, #0x414d
9cac:    5c           mov DX, AX
9cad:    90 81 00     ld AX, #0x8100
9cb0:    b5 61        st AX, (DX)+
9cb2:    90 84 00     ld AX, #0x8400
9cb5:    b5 61        st AX, (DX)+
9cb7:    80 83        ld AL, #0x83
9cb9:    a5 61        st AL, (DX)+
9cbb:    3a           clr! AX
9cbc:    b5 61        st AX, (DX)+
9cbe:    80 85        ld AL, #0x85
9cc0:    a5 61        st AL, (DX)+
9cc2:    d0 10 00     ld BX, #0x1000

L_9cc5:
9cc5:    e5 61        st BL, (DX)+
9cc7:    90 01 90     ld AX, #0x0190
9cca:    b5 61        st AX, (DX)+
9ccc:    20 30        inc BL
9cce:    21 20        dec BH
9cd0:    15 f3        bnz L_9cc5
9cd2:    80 ff        ld AL, #0xff
9cd4:    ab           st AL, (DX)

L_9cd5:
9cd5:    90 ff c3     ld AX, #0xffc3
9cd8:    2f 02        dma_load_count WX
9cda:    90 41 4d     ld AX, #0x414d
9cdd:    2f 00        dma_load_addr WX
9cdf:    2f 34        dma_set_mode 3
9ce1:    2f 06        dma_enable
9ce3:    80 43        ld AL, #0x43
9ce5:    a2 01 14     st AL, @(0x0114)
9ce8:    7a 01 18     call @(0x0118)
9ceb:    13 09        bnn L_9cf6
9ced:    a1 f1 0b     st AL, (0xf10b)
9cf0:    a1 f1 0c     st AL, (0xf10c)
9cf3:    72 01 0e     jump @(0x010e) ;

L_9cf6:
9cf6:    90 e6 ff     ld AX, #0xe6ff
9cf9:    2f 02        dma_load_count WX
9cfb:    90 01 1c     ld AX, #0x011c
9cfe:    2f 00        dma_load_addr WX
9d00:    2f 34        dma_set_mode 3
9d02:    2f 06        dma_enable
9d04:    80 45        ld AL, #0x45
9d06:    a2 01 14     st AL, @(0x0114)
9d09:    7a 01 18     call @(0x0118)
9d0c:    13 16        bnn L_9d24
9d0e:    7a 01 12     call @(0x0112)
9d11:    "TRACK=\0"
9d18:    91 41 52     ld AX, (0x4152)
9d1b:    7a 01 10     call @(0x0110)
9d1e:    7a 01 12     call @(0x0112)
9d21:    "\r\n\0"

L_9d24:
9d24:    91 41 52     ld AX, (0x4152)
9d27:    15 01        bnz L_9d2a
9d29:    38           inc! AX

L_9d2a:
9d2a:    3d           sll! AX
9d2b:    b1 41 52     st AX, (0x4152)
9d2e:    d0 03 36     ld BX, #0x0336
9d31:    59           sub! BX, AX
9d32:    19 a1        ble L_9cd5
9d34:    a1 f1 0a     st AL, (0xf10a)
9d37:    7a 01 04     call @(0x0104)
9d3a:    04           fsi
9d3b:    a9           st AL, (BX)

Entry_FINCH_SEEK_TEST:
9d3c:    90 01 8b     LDAW	#0x018b			; Load literal address 0x018b into AW register
9d3f:    50 80        ADD 	ZW, AW			; Add ZW and AW and store in AW
9d41:    7d 00        JSR	AW, 0			; Jump to subroutine using AW as address
9d43:    f8 00 7a     stb? A, [0x0007a]
9d46:    01           nop
9d47:    06           fsc
9d48:    d0 41 4d     ld BX, #0x414d
9d4b:    90 81 02     ld AX, #0x8102
9d4e:    b5 21        st AX, (BX)+
9d50:    90 84 00     ld AX, #0x8400
9d53:    b5 21        st AX, (BX)+
9d55:    90 82 ff     ld AX, #0x82ff
9d58:    b9           st AX, (BX)
9d59:    90 ff f9     ld AX, #0xfff9
9d5c:    2f 02        dma_load_count WX
9d5e:    90 41 4d     ld AX, #0x414d
9d61:    2f 00        dma_load_addr WX
9d63:    2f 34        dma_set_mode 3
9d65:    2f 06        dma_enable
9d67:    80 43        ld AL, #0x43
9d69:    a2 01 14     st AL, @(0x0114)
9d6c:    7a 01 18     call @(0x0118)
9d6f:    13 09        bnn L_9d7a

L_9d71:
9d71:    a1 f1 0b     st AL, (0xf10b)
9d74:    a1 f1 0c     st AL, (0xf10c)
9d77:    72 01 0e     jump @(0x010e) ;

L_9d7a:
9d7a:    80 45        ld AL, #0x45
9d7c:    a2 01 14     st AL, @(0x0114)
9d7f:    7a 01 18     call @(0x0118)
9d82:    12 ed        bn L_9d71
9d84:    d0 41 4f     ld BX, #0x414f
9d87:    90 84 00     ld AX, #0x8400
9d8a:    b5 21        st AX, (BX)+
9d8c:    80 83        ld AL, #0x83
9d8e:    a5 21        st AL, (BX)+
9d90:    3a           clr! AX
9d91:    b5 21        st AX, (BX)+
9d93:    39           dec! AX
9d94:    a9           st AL, (BX)
9d95:    38           inc! AX
9d96:    38           inc! AX
9d97:    b1 41 b1     st AX, (0x41b1)

L_9d9a:
9d9a:    90 41 4d     ld AX, #0x414d
9d9d:    2f 00        dma_load_addr WX
9d9f:    90 ff f7     ld AX, #0xfff7
9da2:    2f 02        dma_load_count WX
9da4:    2f 34        dma_set_mode 3
9da6:    2f 06        dma_enable
9da8:    80 43        ld AL, #0x43
9daa:    a2 01 14     st AL, @(0x0114)
9dad:    7a 01 18     call @(0x0118)
9db0:    12 bf        bn L_9d71
9db2:    80 45        ld AL, #0x45
9db4:    a2 01 14     st AL, @(0x0114)
9db7:    7a 01 18     call @(0x0118)
9dba:    13 1c        bnn L_9dd8
9dbc:    7a 01 12     call @(0x0112)
9dbf:    "TRACK=\0"
9dc6:    91 41 52     ld AX, (0x4152)
9dc9:    7a 01 10     call @(0x0110)
9dcc:    7a 01 12     call @(0x0112)
9dcf:    "\r\n\0"
9dd2:    a1 f1 0b     st AL, (0xf10b)
9dd5:    a1 f1 0c     st AL, (0xf10c)

L_9dd8:
9dd8:    91 41 b1     ld AX, (0x41b1)
9ddb:    16 14        blt L_9df1
9ddd:    91 41 52     ld AX, (0x4152)
9de0:    38           inc! AX
9de1:    b1 41 52     st AX, (0x4152)
9de4:    d0 02 5c     ld BX, #0x025c
9de7:    59           sub! BX, AX
9de8:    15 b0        bnz L_9d9a
9dea:    3a           clr! AX
9deb:    39           dec! AX
9dec:    b1 41 b1     st AX, (0x41b1)
9def:    73 a9        jump (PC-0x57) L_9d9a

L_9df1:
9df1:    91 41 52     ld AX, (0x4152)
9df4:    39           dec! AX
9df5:    b1 41 52     st AX, (0x4152)
9df8:    17 a0        ble L_9d9a
9dfa:    7a 01 04     call @(0x0104)
9dfd:    05           fci
9dfe:    48           add! BL, AL

Entry_FINCH_READ_TEST:
9dff:    90 01 8b     ld AX, #0x018b
9e02:    50 80        add AX, EX
9e04:    7d 00        call (A + 0x00)
9e06:    f8 00 7a     stb? A, [0x0007a]
9e09:    01           nop
9e0a:    06           fsc
9e0b:    90 41 4d     ld AX, #0x414d
9e0e:    5c           mov DX, AX
9e0f:    90 81 02     ld AX, #0x8102
9e12:    b5 61        st AX, (DX)+
9e14:    90 84 00     ld AX, #0x8400
9e17:    b5 61        st AX, (DX)+
9e19:    80 83        ld AL, #0x83
9e1b:    a5 61        st AL, (DX)+
9e1d:    3a           clr! AX
9e1e:    b5 61        st AX, (DX)+
9e20:    80 8a        ld AL, #0x8a
9e22:    a5 61        st AL, (DX)+
9e24:    d0 10 00     ld BX, #0x1000

L_9e27:
9e27:    e5 61        st BL, (DX)+
9e29:    90 01 90     ld AX, #0x0190
9e2c:    b5 61        st AX, (DX)+
9e2e:    20 30        inc BL
9e30:    21 20        dec BH
9e32:    15 f3        bnz L_9e27
9e34:    80 ff        ld AL, #0xff
9e36:    ab           st AL, (DX)

L_9e37:
9e37:    90 ff c3     ld AX, #0xffc3
9e3a:    2f 02        dma_load_count WX
9e3c:    90 41 4d     ld AX, #0x414d
9e3f:    2f 00        dma_load_addr WX
9e41:    2f 34        dma_set_mode 3
9e43:    2f 06        dma_enable
9e45:    80 43        ld AL, #0x43
9e47:    a2 01 14     st AL, @(0x0114)
9e4a:    7a 01 18     call @(0x0118)
9e4d:    13 09        bnn L_9e58
9e4f:    a1 f1 0b     st AL, (0xf10b)
9e52:    a1 f1 0c     st AL, (0xf10c)
9e55:    72 01 0e     jump @(0x010e) ;

L_9e58:
9e58:    90 e6 ff     ld AX, #0xe6ff
9e5b:    2f 02        dma_load_count WX
9e5d:    90 01 1c     ld AX, #0x011c
9e60:    2f 00        dma_load_addr WX
9e62:    2f 34        dma_set_mode 3
9e64:    2f 06        dma_enable
9e66:    80 45        ld AL, #0x45
9e68:    a2 01 14     st AL, @(0x0114)
9e6b:    7a 01 18     call @(0x0118)
9e6e:    13 16        bnn L_9e86
9e70:    7a 01 12     call @(0x0112)
9e73:    "TRACK=\0"
9e7a:    91 41 52     ld AX, (0x4152)
9e7d:    7a 01 10     call @(0x0110)
9e80:    7a 01 12     call @(0x0112)
9e83:    "\r\n\0"

L_9e86:
9e86:    91 41 52     ld AX, (0x4152)
9e89:    15 01        bnz L_9e8c
9e8b:    38           inc! AX

L_9e8c:
9e8c:    3d           sll! AX
9e8d:    b1 41 52     st AX, (0x4152)
9e90:    d0 02 5d     ld BX, #0x025d
9e93:    59           sub! BX, AX
9e94:    19 a1        ble L_9e37
9e96:    a1 f1 0a     st AL, (0xf10a)
9e99:    7a 01 04     call @(0x0104)
9e9c:    06           fsc
9e9d:    0b           unknown

Entry_ROM_SELF_TEST:
9e9e:    90 01 8b     ld AX, #0x018b
9ea1:    50 80        add AX, EX
9ea3:    7d 00        call (A + 0x00)
9ea5:    00           HALT
9ea6:    00           HALT
9ea7:    55 86        mov DX, EX
9ea9:    3a           clr! AX

L_9eaa:
9eaa:    85 61        ld AL, (DX)+
9eac:    40 10        add AH, AL
9eae:    d0 06 ed     ld BX, #0x06ed
9eb1:    50 82        add BX, EX
9eb3:    51 62        sub BX, DX
9eb5:    15 f3        bnz L_9eaa
9eb7:    8b           ld AL, (DX)
9eb8:    41 01        sub AL, AH
9eba:    15 18        bnz L_9ed4
9ebc:    7a 01 12     call @(0x0112)
9ebf:    "\n\r*** PASS ***\0"
9ece:    a1 f1 0a     st AL, (0xf10a)
9ed1:    72 01 0e     jump @(0x010e) ;

L_9ed4:
9ed4:    7a 01 12     call @(0x0112)
9ed7:    "*** FAIL ***\0"
9ee4:    a1 f1 0b     st AL, (0xf10b)
9ee7:    a1 f1 0c     st AL, (0xf10c)
9eea:    72 01 0e     jump @(0x010e) ;
9eed:    c5
9eee:    00
9eef:    00
