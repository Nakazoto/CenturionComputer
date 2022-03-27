
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
98a5:    85 41        mov AL, [r2++]
98a7:    15 01        b_nz L_98aa
98a9:    09           ret

L_98aa:
98aa:    7b 02        call L_98ae
98ac:    73 f7        jump WriteString

L_98ae:
98ae:    c1 f2 00     mov BL, [0xf200]
98b1:    24 30        shift_right AH, BL
98b3:    24 30        shift_right AH, BL
98b5:    11 f7        b1 L_98ae
98b7:    a1 f2 01     mov [0xf201], AL
98ba:    09           ret

ReadChar:
98bb:    81 f2 00     mov AL, [0xf200]
98be:    2c           shift_right AL, AL
98bf:    11 fa        b1 ReadChar
98c1:    81 f2 01     mov AL, [0xf201]
98c4:    09           ret

Fn_0c5:
98c5:    a5 a2        mov [--SP], BH
98c7:    45 01        mov AL, AH
98c9:    7b 05        call Fn_0d0
98cb:    85 a1        mov AL, [SP++]
98cd:    7b 01        call Fn_0d0
98cf:    09           ret

Fn_0d0:
98d0:    a5 a2        mov [--SP], BH
98d2:    c0 f0        mov BL, 0xf0
98d4:    42 31        and AL, BL
98d6:    07           clear_carry
98d7:    26 10        rotate_right AH, AL
98d9:    2c           shift_right AL, AL
98da:    2c           shift_right AL, AL
98db:    2c           shift_right AL, AL
98dc:    c0 b0        mov BL, 0xb0
98de:    40 31        add AL, BL
98e0:    c0 b9        mov BL, 0xb9
98e2:    49           sub BL, AL
98e3:    19 04        b_le L_98e9
98e5:    c0 07        mov BL, 0x07
98e7:    40 31        add AL, BL

L_98e9:
98e9:    7b c3        call L_98ae
98eb:    85 a1        mov AL, [SP++]
98ed:    c0 0f        mov BL, 0x0f
98ef:    42 31        and AL, BL
98f1:    c0 b0        mov BL, 0xb0
98f3:    40 31        add AL, BL
98f5:    c0 b9        mov BL, 0xb9
98f7:    49           sub BL, AL
98f8:    19 04        b_le L_98fe
98fa:    c0 07        mov BL, 0x07
98fc:    40 31        add AL, BL

L_98fe:
98fe:    7b ae        call L_98ae
9900:    09           ret

FinishTest:
9901:    a1 f1 0a     mov [0xf10a], AL
9904:    81 f2 00     mov AL, [0xf200]
9907:    2c           shift_right AL, AL
9908:    11 57        b1 L_9961
990a:    81 f2 01     mov AL, [0xf201]
990d:    c0 80        mov BL, 0x80
990f:    43 31        or AL, BL
9911:    c0 83        mov BL, 0x83
9913:    49           sub BL, AL
9914:    15 4b        b_nz L_9961
9916:    81 01 08     mov AL, [0x0108]
9919:    14 32        b_z L_994d
991b:    7a 01 12     call [0x0112]
991e:    "\r\n*** FAIL ***\0"
992d:    a1 f1 0b     mov [0xf10b], AL
9930:    a1 f1 0c     mov [0xf10c], AL

PressSpaceThenExit:
9933:    7a 01 12     call [0x0112]
9936:    "\r\nPRESS SPACE\x07\r\n\0"
9947:    7a 01 02     call [0x0102]
994a:    72 01 00     jump [0x0100] ;

L_994d:
994d:    7a 01 12     call [0x0112]
9950:    "\r\n*** PASS ***\0"
995f:    73 d2        jump PressSpaceThenExit

L_9961:
9961:    90 c0 00     mov AX, 0xc000
9964:    5f           mov SP, AX
9965:    91 01 1a     mov AX, [0x011a]
9968:    5e           mov r4, AX
9969:    95 41        mov AX, [r2++]
996b:    50 80        add AX, r4
996d:    75 00        jump A + 0x00

PrintCtrlCToExit:
996f:    7a 01 12     call [0x0112]
9972:    "\r\n(CONTROL-C TO EXIT)\r\n\0"
998a:    09           ret

Init:
998b:    3a           clear AX, AX
998c:    b1 01 08     mov [0x0108], AX
998f:    90 01 ee     mov AX, 0x01ee
9992:    50 80        add AX, r4
9994:    b1 01 18     mov [0x0118], AX
9997:    90 00 d0     mov AX, 0x00d0
999a:    50 80        add AX, r4
999c:    b1 01 0a     mov [0x010a], AX
999f:    90 02 91     mov AX, 0x0291
99a2:    50 80        add AX, r4
99a4:    b1 01 0c     mov [0x010c], AX
99a7:    90 01 6f     mov AX, 0x016f
99aa:    50 80        add AX, r4
99ac:    b1 01 06     mov [0x0106], AX
99af:    90 00 bb     mov AX, 0x00bb
99b2:    50 80        add AX, r4
99b4:    b1 01 02     mov [0x0102], AX
99b7:    90 00 a5     mov AX, 0x00a5

L_99ba:
99ba:    50 80        add AX, r4
99bc:    b1 01 12     mov [0x0112], AX
99bf:    90 00 c5     mov AX, 0x00c5
99c2:    50 80        add AX, r4
99c4:    b1 01 10     mov [0x0110], AX
99c7:    90 01 01     mov AX, 0x0101
99ca:    50 80        add AX, r4
99cc:    b1 01 04     mov [0x0104], AX
99cf:    90 01 33     mov AX, 0x0133
99d2:    50 80        add AX, r4
99d4:    b1 01 0e     mov [0x010e], AX
99d7:    55 80        mov AX, r4
99d9:    b1 01 1a     mov [0x011a], AX
99dc:    95 41        mov AX, [r2++]
99de:    b1 01 14     mov [0x0114], AX
99e1:    38           inc? AX, AX
99e2:    b1 01 16     mov [0x0116], AX
99e5:    55 40        mov AX, r2
99e7:    65 a1        unknown
99e9:    69 01 00     69 A, 0x0100
99ec:    75 00        jump A + 0x00

Fn_1ee:
99ee:    7a 01 0c     call [0x010c]
99f1:    6d a2        unknown
99f3:    60 03 e8     60 0x03e8

L_99f6:
99f6:    82 01        unknown
99f8:    16 c0        b_lt L_99ba
99fa:    08           flag8
99fb:    4a           and BL, AL
99fc:    14 2b        b_z L_9a29
99fe:    0e           delay 4.5ms
99ff:    3f           rotate_left AX, AX
9a00:    15 f4        b_nz L_99f6
9a02:    7a 01 12     call [0x0112]
9a05:    "*** BUSY DID NOT CLEAR ***\0"
9a20:    a1 f1 0b     mov [0xf10b], AL
9a23:    a1 f1 0c     mov [0xf10c], AL
9a26:    72 01 0e     jump [0x010e] ;

L_9a29:
9a29:    60 03 e8     60 0x03e8

L_9a2c:
9a2c:    2c           shift_right AL, AL
9a2d:    10 2b        b0 L_9a5a
9a2f:    0e           delay 4.5ms
9a30:    3f           rotate_left AX, AX
9a31:    15 f9        b_nz L_9a2c
9a33:    7a 01 12     call [0x0112]
9a36:    "*** FOUT NEVER CAME ON ***\0"
9a51:    a1 f1 0b     mov [0xf10b], AL
9a54:    a1 f1 0c     mov [0xf10c], AL
9a57:    72 01 0e     jump [0x010e] ;

L_9a5a:
9a5a:    03           flag3
9a5b:    82 01        unknown
9a5d:    14 15        b_z L_9a74
9a5f:    03           flag3
9a60:    65 a1        unknown
9a62:    09           ret
9a63:    a5
9a64:    a2
9a65:    7a
9a66:    01
9a67:    12
9a68:    "*** \0"
9a6d:    85 a1        mov AL, [SP++]
9a6f:    7a 01 0a     call [0x010a]
9a72:    7a
9a73:    01

L_9a74:
9a74:    12
9a75:    " ERROR ***\r\n\0"
9a82:    80 01        mov AL, 0x01
9a84:    a1 01 08     mov [0x0108], AL
9a87:    a1 f1 0b     mov [0xf10b], AL
9a8a:    a1 f1 0c     mov [0xf10c], AL
9a8d:    65 a1        unknown
9a8f:    02           flag2
9a90:    09           ret

Fn_291:
9a91:    6d a2        unknown
9a93:    0e           delay 4.5ms
9a94:    60 03 e8     60 0x03e8

L_9a97:
9a97:    82 01        unknown
9a99:    16 2c        b_lt L_9ac7
9a9b:    2c           shift_right AL, AL
9a9c:    11 2d        b1 L_9acb
9a9e:    0e           delay 4.5ms
9a9f:    3f           rotate_left AX, AX
9aa0:    15 f5        b_nz L_9a97
9aa2:    7a 01 12     call [0x0112]
9aa5:    "*** FIN DID NOT GO OFF ***\r\n\0"
9ac2:    a1 f1 0b     mov [0xf10b], AL
9ac5:    a1
9ac6:    f1

L_9ac7:
9ac7:    0c           unknown
9ac8:    72 01 0e     jump [0x010e] ;

L_9acb:
9acb:    65 a1        unknown
9acd:    09           ret

Entry_01133_CMD_AUX_MEMORY_TEST:
9ace:    90 01 8b     mov AX, 0x018b
9ad1:    50 80        add AX, r4
9ad3:    7d 00        call A + 0x00
9ad5:    f8           mov [None], BX
9ad6:    08           flag8
9ad7:    73 09        jump L_9ae2

Entry_FINCH_AUX_MEMORY_TEST:
9ad9:    90 01 8b     mov AX, 0x018b
9adc:    50 80        add AX, r4
9ade:    7d 00        call A + 0x00
9ae0:    f8           mov [None], BX
9ae1:    00           HALT

L_9ae2:
9ae2:    7a 01 06     call [0x0106]
9ae5:    32 60        clear AX, r3
9ae7:    60 0f 00     60 0x0f00
9aea:    55 60        mov AX, r3
9aec:    d0 01 1c     mov BX, 0x011c

L_9aef:
9aef:    a5 21        mov [--BX], AL
9af1:    28           inc? AL, AL
9af2:    28           inc? AL, AL
9af3:    28           inc? AL, AL
9af4:    3f           rotate_left AX, AX
9af5:    15 f8        b_nz L_9aef
9af7:    90 f0 ff     mov AX, 0xf0ff
9afa:    2f 02        DMA load 0, 2
9afc:    90 01 1c     mov AX, 0x011c
9aff:    2f 00        DMA load 0, 0
9b01:    2f 34        DMA load 3, 4
9b03:    2f 06        DMA load 0, 6
9b05:    80 46        mov AL, 0x46
9b07:    a2 01        unknown
9b09:    14 7a        b_z L_9b85
9b0b:    01           nop
9b0c:    0c           unknown
9b0d:    80 01        mov AL, 0x01
9b0f:    a2 01        unknown
9b11:    14 7a        b_z L_9b8d
9b13:    01           nop
9b14:    0c           unknown
9b15:    2a           clear AL, AL
9b16:    a2 01        unknown
9b18:    14 7a        b_z L_9b94
9b1a:    01           nop
9b1b:    0c           unknown
9b1c:    80 0f        mov AL, 0x0f
9b1e:    a2 01        unknown
9b20:    14 7a        b_z L_9b9c
9b22:    01           nop
9b23:    0c           unknown
9b24:    2a           clear AL, AL
9b25:    a2 01        unknown
9b27:    14 7a        b_z L_9ba3
9b29:    01           nop
9b2a:    18 60        b_gt L_9b8c
9b2c:    0f           unknown
9b2d:    00           HALT
9b2e:    3a           clear AX, AX
9b2f:    d0 01 1c     mov BX, 0x011c

L_9b32:
9b32:    a5 21        mov [--BX], AL
9b34:    3f           rotate_left AX, AX
9b35:    15 fb        b_nz L_9b32
9b37:    90 f0 ff     mov AX, 0xf0ff
9b3a:    2f 02        DMA load 0, 2
9b3c:    90 01 1c     mov AX, 0x011c
9b3f:    2f 00        DMA load 0, 0
9b41:    2f 34        DMA load 3, 4
9b43:    2f 06        DMA load 0, 6
9b45:    80 47        mov AL, 0x47
9b47:    a2 01        unknown
9b49:    14 7a        b_z L_9bc5
9b4b:    01           nop
9b4c:    0c           unknown
9b4d:    80 01        mov AL, 0x01
9b4f:    a2 01        unknown
9b51:    14 7a        b_z L_9bcd
9b53:    01           nop
9b54:    0c           unknown
9b55:    2a           clear AL, AL
9b56:    a2 01        unknown
9b58:    14 7a        b_z L_9bd4
9b5a:    01           nop
9b5b:    0c           unknown
9b5c:    80 0f        mov AL, 0x0f
9b5e:    a2 01        unknown
9b60:    14 7a        b_z L_9bdc
9b62:    01           nop
9b63:    0c           unknown
9b64:    2a           clear AL, AL
9b65:    a2 01        unknown
9b67:    14 7a        b_z L_9be3
9b69:    01           nop
9b6a:    18 b5        b_gt L_9b21
9b6c:    a2 60        unknown
9b6e:    0f           unknown
9b6f:    00           HALT
9b70:    d0 01 1c     mov BX, 0x011c
9b73:    55 60        mov AX, r3
9b75:    45 10        mov AH, AL

L_9b77:
9b77:    85 21        mov AL, [BX++]
9b79:    bd           mov [None], AX
9b7a:    41 01        sub AL, AH
9b7c:    15 12        b_nz L_9b90
9b7e:    20 00        inc? AH, AH
9b80:    20 00        inc? AH, AH
9b82:    20 00        inc? AH, AH
9b84:    3f           rotate_left AX, AX

L_9b85:
9b85:    15 f0        b_nz L_9b77
9b87:    95 a1        mov AX, [SP++]
9b89:    20 70        inc? AH, r3_low
9b8b:    7a 01 04     call [0x0104]
9b8e:    02           flag2
9b8f:    e5

L_9b90:
9b90:    a1 f1 0b     mov [0xf10b], AL
9b93:    a1 f1 0c     mov [0xf10c], AL
9b96:    f5 a2        mov [--SP], BX
9b98:    7a 01 12     call [0x0112]
9b9b:    "*** ERROR, ADDR=\0"
9bac:    95 a1        mov AX, [SP++]
9bae:    39           dec? AX, AX
9baf:    7a 01 10     call [0x0110]
9bb2:    7a 01 12     call [0x0112]
9bb5:    " EXP=\0"
9bbb:    85 a1        mov AL, [SP++]
9bbd:    7a 01 0a     call [0x010a]
9bc0:    7a 01 12     call [0x0112]
9bc3:    " ACT=\0"
9bc9:    85 a1        mov AL, [SP++]
9bcb:    7a 01 0a     call [0x010a]
9bce:    7a 01 12     call [0x0112]
9bd1:    " ***\0"
9bd6:    72 01 0e     jump [0x010e] ;

Entry_01133_CMD_SEEK_TEST:
9bd9:    90 01 8b     mov AX, 0x018b

L_9bdc:
9bdc:    50 80        add AX, r4
9bde:    7d 00        call A + 0x00
9be0:    f8           mov [None], BX
9be1:    08           flag8
9be2:    7a 01 06     call [0x0106]
9be5:    d0 41 4d     mov BX, 0x414d
9be8:    90 81 00     mov AX, 0x8100
9beb:    b5 21        mov [--BX], AX
9bed:    90 82 ff     mov AX, 0x82ff
9bf0:    b9           mov [None], AX
9bf1:    90 ff fb     mov AX, 0xfffb
9bf4:    2f 02        DMA load 0, 2
9bf6:    90 41 4d     mov AX, 0x414d
9bf9:    2f 00        DMA load 0, 0
9bfb:    2f 34        DMA load 3, 4
9bfd:    2f 06        DMA load 0, 6
9bff:    80 43        mov AL, 0x43
9c01:    a2 01        unknown
9c03:    14 7a        b_z L_9c7f
9c05:    01           nop
9c06:    18 13        b_gt L_9c1b
9c08:    09           ret
9c09:    a1
9c0a:    f1
9c0b:    0b
9c0c:    a1
9c0d:    f1
9c0e:    0c
9c0f:    72
9c10:    01
9c11:    0e
9c12:    80
9c13:    45
9c14:    a2
9c15:    01
9c16:    14
9c17:    7a
9c18:    01
9c19:    18
9c1a:    12

L_9c1b:
9c1b:    ed           mov [None], BL
9c1c:    d0 41 4f     mov BX, 0x414f
9c1f:    90 84 00     mov AX, 0x8400
9c22:    b5 21        mov [--BX], AX
9c24:    80 83        mov AL, 0x83
9c26:    a5 21        mov [--BX], AL
9c28:    3a           clear AX, AX
9c29:    b5 21        mov [--BX], AX
9c2b:    39           dec? AX, AX

L_9c2c:
9c2c:    a9           mov [None], AL
9c2d:    38           inc? AX, AX
9c2e:    38           inc? AX, AX
9c2f:    b1 41 b1     mov [0x41b1], AX

L_9c32:
9c32:    90 41 4d     mov AX, 0x414d
9c35:    2f 00        DMA load 0, 0
9c37:    90 ff f7     mov AX, 0xfff7
9c3a:    2f 02        DMA load 0, 2
9c3c:    2f 34        DMA load 3, 4
9c3e:    2f 06        DMA load 0, 6
9c40:    80 43        mov AL, 0x43
9c42:    a2 01        unknown
9c44:    14 7a        b_z L_9cc0
9c46:    01           nop
9c47:    18 12        b_gt L_9c5b
9c49:    bf           mov [None], AX
9c4a:    80 45        mov AL, 0x45
9c4c:    a2 01        unknown
9c4e:    14 7a        b_z L_9cca
9c50:    01           nop
9c51:    18 13        b_gt L_9c66
9c53:    1c 7a        b_sense2 L_9ccf
9c55:    01           nop
9c56:    12
9c57:    "TRACK=\0"
9c5e:    91 41 52     mov AX, [0x4152]
9c61:    7a 01 10     call [0x0110]
9c64:    7a 01 12     call [0x0112]
9c67:    "\r\n\0"
9c6a:    a1 f1 0b     mov [0xf10b], AL
9c6d:    a1 f1 0c     mov [0xf10c], AL
9c70:    91 41 b1     mov AX, [0x41b1]
9c73:    16 1a        b_lt L_9c8f
9c75:    d1 41 52     mov BX, [0x4152]
9c78:    50 20        add AX, BX
9c7a:    b1 41 52     mov [0x4152], AX
9c7d:    d0
9c7e:    03

L_9c7f:
9c7f:    36 59        rotate_right r4, r2
9c81:    15 af        b_nz L_9c32
9c83:    3a           clear AX, AX
9c84:    39           dec? AX, AX
9c85:    b1 41 b1     mov [0x41b1], AX
9c88:    80 10        mov AL, 0x10
9c8a:    a1 41 50     mov [0x4150], AL
9c8d:    73 a3        jump L_9c32

L_9c8f:
9c8f:    91 41 52     mov AX, [0x4152]
9c92:    39           dec? AX, AX
9c93:    b1 41 52     mov [0x4152], AX
9c96:    17 9a        b7 L_9c32
9c98:    7a 01 04     call [0x0104]
9c9b:    03           flag3
9c9c:    e5

Entry_01133_CMD_READ_TEST:
9c9d:    90 01 8b     mov AX, 0x018b
9ca0:    50 80        add AX, r4
9ca2:    7d 00        call A + 0x00
9ca4:    f8           mov [None], BX
9ca5:    08           flag8
9ca6:    7a 01 06     call [0x0106]
9ca9:    90 41 4d     mov AX, 0x414d
9cac:    5c           xor BX, AX
9cad:    90
9cae:    81

L_9caf:
9caf:    00           HALT
9cb0:    b5 61        mov [--r3], AX
9cb2:    90 84 00     mov AX, 0x8400
9cb5:    b5 61        mov [--r3], AX
9cb7:    80 83        mov AL, 0x83
9cb9:    a5 61        mov [--r3], AL
9cbb:    3a           clear AX, AX
9cbc:    b5 61        mov [--r3], AX
9cbe:    80 85        mov AL, 0x85

L_9cc0:
9cc0:    a5 61        mov [--r3], AL
9cc2:    d0 10 00     mov BX, 0x1000

L_9cc5:
9cc5:    e5 61        mov [--r3], AL
9cc7:    90 01 90     mov AX, 0x0190

L_9cca:
9cca:    b5 61        mov [--r3], AX
9ccc:    20 30        inc? AH, BL
9cce:    21 20        dec? AH, BH
9cd0:    15 f3        b_nz L_9cc5
9cd2:    80 ff        mov AL, 0xff
9cd4:    ab           mov [None], AL

L_9cd5:
9cd5:    90 ff c3     mov AX, 0xffc3
9cd8:    2f 02        DMA load 0, 2
9cda:    90 41 4d     mov AX, 0x414d
9cdd:    2f 00        DMA load 0, 0
9cdf:    2f 34        DMA load 3, 4
9ce1:    2f 06        DMA load 0, 6
9ce3:    80 43        mov AL, 0x43
9ce5:    a2 01        unknown
9ce7:    14 7a        b_z L_9d63
9ce9:    01           nop
9cea:    18 13        b_gt L_9cff
9cec:    09           ret
9ced:    a1
9cee:    f1
9cef:    0b
9cf0:    a1
9cf1:    f1
9cf2:    0c
9cf3:    72
9cf4:    01
9cf5:    0e
9cf6:    90
9cf7:    e6
9cf8:    ff
9cf9:    2f
9cfa:    02
9cfb:    90
9cfc:    01
9cfd:    1c
9cfe:    2f

L_9cff:
9cff:    00           HALT
9d00:    2f 34        DMA load 3, 4
9d02:    2f 06        DMA load 0, 6
9d04:    80 45        mov AL, 0x45
9d06:    a2 01        unknown
9d08:    14 7a        b_z L_9d84
9d0a:    01           nop
9d0b:    18 13        b_gt L_9d20
9d0d:    16 7a        b_lt L_9d89
9d0f:    01           nop
9d10:    12
9d11:    "TRACK=\0"
9d18:    91 41 52     mov AX, [0x4152]
9d1b:    7a 01 10     call [0x0110]
9d1e:    7a
9d1f:    01

L_9d20:
9d20:    12
9d21:    "\r\n\0"
9d24:    91 41 52     mov AX, [0x4152]
9d27:    15 01        b_nz L_9d2a
9d29:    38           inc? AX, AX

L_9d2a:
9d2a:    3d           shift_left AX, AX
9d2b:    b1 41 52     mov [0x4152], AX
9d2e:    d0 03 36     mov BX, 0x0336
9d31:    59           sub BX, AX
9d32:    19 a1        b_le L_9cd5
9d34:    a1 f1 0a     mov [0xf10a], AL
9d37:    7a 01 04     call [0x0104]
9d3a:    04           flag4
9d3b:    a9           mov [None], AL

Entry_FINCH_SEEK_TEST:
9d3c:    90 01 8b     mov AX, 0x018b
9d3f:    50 80        add AX, r4
9d41:    7d 00        call A + 0x00
9d43:    f8           mov [None], BX
9d44:    00           HALT
9d45:    7a 01 06     call [0x0106]
9d48:    d0 41 4d     mov BX, 0x414d
9d4b:    90 81 02     mov AX, 0x8102
9d4e:    b5 21        mov [--BX], AX
9d50:    90 84 00     mov AX, 0x8400
9d53:    b5 21        mov [--BX], AX
9d55:    90 82 ff     mov AX, 0x82ff
9d58:    b9           mov [None], AX
9d59:    90 ff f9     mov AX, 0xfff9
9d5c:    2f

L_9d5d:
9d5d:    02           flag2
9d5e:    90 41 4d     mov AX, 0x414d
9d61:    2f 00        DMA load 0, 0

L_9d63:
9d63:    2f 34        DMA load 3, 4
9d65:    2f 06        DMA load 0, 6
9d67:    80 43        mov AL, 0x43
9d69:    a2 01        unknown
9d6b:    14 7a        b_z L_9de7
9d6d:    01           nop
9d6e:    18 13        b_gt L_9d83
9d70:    09           ret
9d71:    a1
9d72:    f1
9d73:    0b
9d74:    a1
9d75:    f1
9d76:    0c
9d77:    72
9d78:    01
9d79:    0e
9d7a:    80
9d7b:    45
9d7c:    a2
9d7d:    01
9d7e:    14
9d7f:    7a
9d80:    01
9d81:    18
9d82:    12

L_9d83:
9d83:    ed           mov [None], BL

L_9d84:
9d84:    d0 41 4f     mov BX, 0x414f
9d87:    90 84 00     mov AX, 0x8400
9d8a:    b5 21        mov [--BX], AX
9d8c:    80 83        mov AL, 0x83
9d8e:    a5 21        mov [--BX], AL
9d90:    3a           clear AX, AX
9d91:    b5 21        mov [--BX], AX
9d93:    39           dec? AX, AX

L_9d94:
9d94:    a9           mov [None], AL
9d95:    38           inc? AX, AX
9d96:    38           inc? AX, AX
9d97:    b1 41 b1     mov [0x41b1], AX

L_9d9a:
9d9a:    90 41 4d     mov AX, 0x414d
9d9d:    2f 00        DMA load 0, 0
9d9f:    90 ff f7     mov AX, 0xfff7
9da2:    2f 02        DMA load 0, 2
9da4:    2f 34        DMA load 3, 4
9da6:    2f 06        DMA load 0, 6
9da8:    80 43        mov AL, 0x43
9daa:    a2 01        unknown
9dac:    14 7a        b_z L_9e28
9dae:    01           nop
9daf:    18 12        b_gt L_9dc3
9db1:    bf           mov [None], AX
9db2:    80 45        mov AL, 0x45
9db4:    a2 01        unknown
9db6:    14 7a        b_z L_9e32
9db8:    01           nop
9db9:    18 13        b_gt L_9dce
9dbb:    1c 7a        b_sense2 L_9e37
9dbd:    01           nop
9dbe:    12
9dbf:    "TRACK=\0"
9dc6:    91 41 52     mov AX, [0x4152]
9dc9:    7a 01 10     call [0x0110]
9dcc:    7a 01 12     call [0x0112]
9dcf:    "\r\n\0"
9dd2:    a1 f1 0b     mov [0xf10b], AL
9dd5:    a1 f1 0c     mov [0xf10c], AL
9dd8:    91 41 b1     mov AX, [0x41b1]
9ddb:    16 14        b_lt L_9df1
9ddd:    91 41 52     mov AX, [0x4152]
9de0:    38           inc? AX, AX
9de1:    b1 41 52     mov [0x4152], AX
9de4:    d0 02 5c     mov BX, 0x025c

L_9de7:
9de7:    59           sub BX, AX
9de8:    15 b0        b_nz L_9d9a
9dea:    3a           clear AX, AX
9deb:    39           dec? AX, AX
9dec:    b1 41 b1     mov [0x41b1], AX
9def:    73 a9        jump L_9d9a

L_9df1:
9df1:    91 41 52     mov AX, [0x4152]
9df4:    39           dec? AX, AX
9df5:    b1 41 52     mov [0x4152], AX
9df8:    17 a0        b7 L_9d9a
9dfa:    7a 01 04     call [0x0104]
9dfd:    05           flag5
9dfe:    48           add BL, AL

Entry_FINCH_READ_TEST:
9dff:    90 01 8b     mov AX, 0x018b
9e02:    50 80        add AX, r4
9e04:    7d 00        call A + 0x00
9e06:    f8           mov [None], BX
9e07:    00           HALT
9e08:    7a 01 06     call [0x0106]
9e0b:    90 41 4d     mov AX, 0x414d
9e0e:    5c           xor BX, AX
9e0f:    90
9e10:    81

L_9e11:
9e11:    02           flag2
9e12:    b5 61        mov [--r3], AX
9e14:    90 84 00     mov AX, 0x8400
9e17:    b5 61        mov [--r3], AX
9e19:    80 83        mov AL, 0x83
9e1b:    a5 61        mov [--r3], AL
9e1d:    3a           clear AX, AX
9e1e:    b5 61        mov [--r3], AX
9e20:    80 8a        mov AL, 0x8a
9e22:    a5 61        mov [--r3], AL
9e24:    d0 10 00     mov BX, 0x1000

L_9e27:
9e27:    e5

L_9e28:
9e28:    61 90 01     61 0x9001
9e2b:    90 b5 61     mov AX, 0xb561
9e2e:    20 30        inc? AH, BL
9e30:    21 20        dec? AH, BH

L_9e32:
9e32:    15 f3        b_nz L_9e27
9e34:    80 ff        mov AL, 0xff
9e36:    ab           mov [None], AL

L_9e37:
9e37:    90 ff c3     mov AX, 0xffc3
9e3a:    2f 02        DMA load 0, 2
9e3c:    90 41 4d     mov AX, 0x414d
9e3f:    2f 00        DMA load 0, 0
9e41:    2f 34        DMA load 3, 4
9e43:    2f 06        DMA load 0, 6
9e45:    80 43        mov AL, 0x43
9e47:    a2 01        unknown
9e49:    14 7a        b_z L_9ec5
9e4b:    01           nop
9e4c:    18 13        b_gt L_9e61
9e4e:    09           ret
9e4f:    a1
9e50:    f1
9e51:    0b
9e52:    a1
9e53:    f1
9e54:    0c
9e55:    72
9e56:    01
9e57:    0e
9e58:    90
9e59:    e6
9e5a:    ff
9e5b:    2f
9e5c:    02
9e5d:    90
9e5e:    01
9e5f:    1c
9e60:    2f

L_9e61:
9e61:    00           HALT
9e62:    2f 34        DMA load 3, 4
9e64:    2f 06        DMA load 0, 6
9e66:    80 45        mov AL, 0x45
9e68:    a2 01        unknown
9e6a:    14 7a        b_z L_9ee6
9e6c:    01           nop
9e6d:    18 13        b_gt L_9e82
9e6f:    16 7a        b_lt L_9eeb
9e71:    01           nop
9e72:    12
9e73:    "TRACK=\0"
9e7a:    91 41 52     mov AX, [0x4152]
9e7d:    7a 01 10     call [0x0110]
9e80:    7a
9e81:    01

L_9e82:
9e82:    12
9e83:    "\r\n\0"
9e86:    91 41 52     mov AX, [0x4152]
9e89:    15 01        b_nz L_9e8c
9e8b:    38           inc? AX, AX

L_9e8c:
9e8c:    3d           shift_left AX, AX
9e8d:    b1 41 52     mov [0x4152], AX
9e90:    d0 02 5d     mov BX, 0x025d
9e93:    59           sub BX, AX
9e94:    19 a1        b_le L_9e37
9e96:    a1 f1 0a     mov [0xf10a], AL
9e99:    7a 01 04     call [0x0104]
9e9c:    06           set_carry
9e9d:    0b           unknown

Entry_ROM_SELF_TEST:
9e9e:    90 01 8b     mov AX, 0x018b
9ea1:    50 80        add AX, r4
9ea3:    7d 00        call A + 0x00
9ea5:    00           HALT
9ea6:    00           HALT
9ea7:    55 86        mov r3, r4
9ea9:    3a           clear AX, AX

L_9eaa:
9eaa:    85 61        mov AL, [r3++]
9eac:    40 10        add AH, AL
9eae:    d0 06 ed     mov BX, 0x06ed
9eb1:    50 82        add BX, r4
9eb3:    51 62        sub BX, r3
9eb5:    15 f3        b_nz L_9eaa
9eb7:    8b           mov AL, [None]
9eb8:    41 01        sub AL, AH
9eba:    15 18        b_nz L_9ed4
9ebc:    7a 01 12     call [0x0112]
9ebf:    "\n\r*** PASS ***\0"
9ece:    a1 f1 0a     mov [0xf10a], AL
9ed1:    72 01 0e     jump [0x010e] ;

L_9ed4:
9ed4:    7a 01 12     call [0x0112]
9ed7:    "*** FAIL ***\0"
9ee4:    a1
9ee5:    f1

L_9ee6:
9ee6:    0b           unknown
9ee7:    a1 f1 0c     mov [0xf10c], AL
9eea:    72 01 0e     jump [0x010e] ;
9eed:    c5 00        mov AH, [AX++]
9eef:    00           HALT
