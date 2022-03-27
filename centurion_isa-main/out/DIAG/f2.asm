
TEST_0:
8800:    00 49        (0x49)
8802:    "CPU INSTRUCTION TEST\r\n\0"

TEST_1:
8819:    05 bb        (0x5bb)
881b:    "CPU-6 MAPPING RAM TEST\r\n\0"

TEST_2:
8834:    07 5f        (0x75f)
8836:    "ROM SELF TEST\r\n\n\0"

TEST_3:
8847:    00 00        (0x0)

Entry_CPU_INSTRUCTION_TEST:
8849:    90 07 cc     mov AX, 0x07cc
884c:    50 80        add AX, r4
884e:    7d 00        call A + 0x00
8850:    "\x1b\x1c\x0cCPU INSTRUCTION TEST, CONTROL-C TO EXIT\r\n\0"
887d:    6d a2        unknown
887f:    55 80        mov AX, r4
8881:    b5 a2        mov [--SP], BX
8883:    60 00 20     60 0x0020 ; This is a testing that the 60 3 byte instruction is working.
                                ; Which it will use later to test other multi-byte insturctions
                                ; If the operand isn't consuemed, then a HALT instruction will be executed
8886:    90 05 a1     mov AX, 0x05a1
8889:    50 80        add AX, r4
888b:    5c           xor BX, AX ; This might be installing an exception handler?
888c:    90 00 10     mov AX, 0x0010

L_888f:
888f:    c5 61        mov AL, [r3++]
8891:    e5 01        mov [--AX], AL
8893:    3f           rotate_left AX, AX
8894:    15 f9        b_nz L_888f ; clearing all regsiters?
8896:    03           flag3
8897:    07           clear_carry
8898:    c0 01        mov BL, 0x01 ; if A is empty. This would set the overflow flag
889a:    11 01        b1 L_889d ; Some tests for all the branch instructions
889c:    00           HALT

L_889d:
889d:    13 01        b3 L_88a0
889f:    00           HALT

L_88a0:
88a0:    17 01        b7 L_88a3
88a2:    00           HALT

L_88a3:
88a3:    15 01        b_nz L_88a6
88a5:    00           HALT

L_88a6:
88a6:    18 01        b_gt L_88a9
88a8:    00           HALT

L_88a9:
88a9:    10 02        b0 L_88ad ; branch 10 is expected to not branch here
88ab:    11 01        b1 L_88ae ; The author could have used any branch here, but using 11 here
                                ; implies 11 is the opposite of 10

L_88ad:
88ad:    00           HALT

L_88ae:
88ae:    12 02        b2 L_88b2
88b0:    13 01        b3 L_88b3 ; likewise, 13 is the opposite of 12 (and so on, below)

L_88b2:
88b2:    00           HALT

L_88b3:
88b3:    14 02        b_z L_88b7
88b5:    15 01        b_nz L_88b8

L_88b7:
88b7:    00           HALT

L_88b8:
88b8:    16 02        b_lt L_88bc
88ba:    17 01        b7 L_88bd

L_88bc:
88bc:    00           HALT

L_88bd:
88bd:    19 02        b_le L_88c1
88bf:    18 0a        b_gt L_88cb

L_88c1:
88c1:    00           HALT

L_88c2:
88c2:    18 04        b_gt L_88c8
88c4:    00           HALT

L_88c5:
88c5:    18 07        b_gt L_88ce
88c7:    00           HALT

L_88c8:
88c8:    18 fb        b_gt L_88c5
88ca:    00           HALT

L_88cb:
88cb:    18 f5        b_gt L_88c2
88cd:    00           HALT

L_88ce:
88ce:    08           flag8
88cf:    10 01        b0 L_88d2
88d1:    00           HALT

L_88d2:
88d2:    07           clear_carry
88d3:    11 01        b1 L_88d6
88d5:    00           HALT

L_88d6:
88d6:    06           set_carry
88d7:    10 01        b0 L_88da
88d9:    00           HALT

L_88da:
88da:    08           flag8
88db:    11 01        b1 L_88de
88dd:    00           HALT

L_88de:
88de:    02           flag2
88df:    12 01        b2 L_88e2
88e1:    00           HALT

L_88e2:
88e2:    03           flag3
88e3:    13 01        b3 L_88e6
88e5:    00           HALT

L_88e6:
88e6:    01           nop
88e7:    11 01        b1 L_88ea
88e9:    00           HALT

L_88ea:
88ea:    13 01        b3 L_88ed
88ec:    00           HALT

L_88ed:
88ed:    18 01        b_gt L_88f0
88ef:    00           HALT

L_88f0:
88f0:    02           flag2
88f1:    06           set_carry
88f2:    01           nop
88f3:    10 01        b0 L_88f6
88f5:    00           HALT

L_88f6:
88f6:    12 01        b2 L_88f9
88f8:    00           HALT

L_88f9:
88f9:    2a           clear AL, AL ; This is potentially increment, 
88fa:    11 01        b1 L_88fd
88fc:    00           HALT

L_88fd:
88fd:    13 01        b3 L_8900
88ff:    00           HALT

L_8900:
8900:    14 01        b_z L_8903
8902:    00           HALT

L_8903:
8903:    17 01        b7 L_8906
8905:    00           HALT

L_8906:
8906:    19 01        b_le L_8909
8908:    00           HALT

L_8909:
8909:    2b           neg? AL, AL
890a:    13 01        b3 L_890d
890c:    00           HALT

L_890d:
890d:    11 01        b1 L_8910
890f:    00           HALT

L_8910:
8910:    16 01        b_lt L_8913
8912:    00           HALT

L_8913:
8913:    19 01        b_le L_8916
8915:    00           HALT

L_8916:
8916:    06           set_carry
8917:    02           flag2
8918:    22 70        clear AH, r3_low
891a:    11 01        b1 L_891d
891c:    00           HALT

L_891d:
891d:    13 01        b3 L_8920
891f:    00           HALT

L_8920:
8920:    14 01        b_z L_8923
8922:    00           HALT

L_8923:
8923:    20 70        inc? AH, r3_low
8925:    11 01        b1 L_8928
8927:    00           HALT

L_8928:
8928:    13 01        b3 L_892b
892a:    00           HALT

L_892b:
892b:    18 01        b_gt L_892e
892d:    00           HALT

L_892e:
892e:    21 70        dec? AH, r3_low
8930:    13 01        b3 L_8933
8932:    00           HALT

L_8933:
8933:    11 01        b1 L_8936
8935:    00           HALT

L_8936:
8936:    14 01        b_z L_8939
8938:    00           HALT

L_8939:
8939:    21 70        dec? AH, r3_low
893b:    13 01        b3 L_893e
893d:    00           HALT

L_893e:
893e:    11 01        b1 L_8941
8940:    00           HALT

L_8941:
8941:    16 01        b_lt L_8944
8943:    00           HALT

L_8944:
8944:    20 70        inc? AH, r3_low
8946:    13 01        b3 L_8949
8948:    00           HALT

L_8949:
8949:    11 01        b1 L_894c
894b:    00           HALT

L_894c:
894c:    14 01        b_z L_894f
894e:    00           HALT

L_894f:
894f:    06           set_carry
8950:    02           flag2
8951:    22 60        clear AH, r3_high ; Using 60 in the operand means the following branch will be skipped
                                        ; if 22 doesn't consume it's operand
8953:    11 01        b1 L_8956
8955:    00           HALT

L_8956:
8956:    13 01        b3 L_8959
8958:    00           HALT

L_8959:
8959:    14 01        b_z L_895c
895b:    00           HALT

L_895c:
895c:    20 60        inc? AH, r3_high
895e:    11 01        b1 L_8961
8960:    00           HALT

L_8961:
8961:    13 01        b3 L_8964
8963:    00           HALT

L_8964:
8964:    18 01        b_gt L_8967
8966:    00           HALT

L_8967:
8967:    21 60        dec? AH, r3_high
8969:    13 01        b3 L_896c
896b:    00           HALT

L_896c:
896c:    11 01        b1 L_896f
896e:    00           HALT

L_896f:
896f:    14 01        b_z L_8972
8971:    00           HALT

L_8972:
8972:    21 60        dec? AH, r3_high
8974:    13 01        b3 L_8977
8976:    00           HALT

L_8977:
8977:    11 01        b1 L_897a
8979:    00           HALT

L_897a:
897a:    16 01        b_lt L_897d
897c:    00           HALT

L_897d:
897d:    20 60        inc? AH, r3_high
897f:    13 01        b3 L_8982
8981:    00           HALT

L_8982:
8982:    11 01        b1 L_8985
8984:    00           HALT

L_8985:
8985:    14 01        b_z L_8988
8987:    00           HALT

L_8988:
8988:    06           set_carry
8989:    02           flag2
898a:    32 20        clear AX, BX
898c:    11 01        b1 L_898f
898e:    00           HALT

L_898f:
898f:    13 01        b3 L_8992
8991:    00           HALT

L_8992:
8992:    14 01        b_z L_8995
8994:    00           HALT

L_8995:
8995:    30 20        inc? AX, BX
8997:    11 01        b1 L_899a
8999:    00           HALT

L_899a:
899a:    13 01        b3 L_899d
899c:    00           HALT

L_899d:
899d:    18 01        b_gt L_89a0
899f:    00           HALT

L_89a0:
89a0:    21 30        dec? AH, BL
89a2:    13 01        b3 L_89a5
89a4:    00           HALT

L_89a5:
89a5:    11 01        b1 L_89a8
89a7:    00           HALT

L_89a8:
89a8:    14 01        b_z L_89ab
89aa:    00           HALT

L_89ab:
89ab:    31 20        dec? AX, BX
89ad:    13 01        b3 L_89b0
89af:    00           HALT

L_89b0:
89b0:    11 01        b1 L_89b3
89b2:    00           HALT

L_89b3:
89b3:    16 01        b_lt L_89b6
89b5:    00           HALT

L_89b6:
89b6:    30 20        inc? AX, BX
89b8:    13 01        b3 L_89bb
89ba:    00           HALT

L_89bb:
89bb:    11 01        b1 L_89be
89bd:    00           HALT

L_89be:
89be:    14 01        b_z L_89c1
89c0:    00           HALT

L_89c1:
89c1:    22 b0        clear AH, r5_low ; Is B0 a two byte instrution that we haven't encountered yet?
89c3:    23 b0        neg? AH, r5_low
89c5:    11 01        b1 L_89c8
89c7:    00           HALT

L_89c8:
89c8:    13 01        b3 L_89cb
89ca:    00           HALT

L_89cb:
89cb:    16 01        b_lt L_89ce
89cd:    00           HALT

L_89ce:
89ce:    26 b0        rotate_right AH, r5_low
89d0:    10 01        b0 L_89d3
89d2:    00           HALT

L_89d3:
89d3:    17 01        b7 L_89d6
89d5:    00           HALT

L_89d6:
89d6:    13 01        b3 L_89d9
89d8:    00           HALT

L_89d9:
89d9:    25 b0        shift_left AH, r5_low
89db:    12 01        b2 L_89de
89dd:    00           HALT

L_89de:
89de:    11 01        b1 L_89e1
89e0:    00           HALT

L_89e1:
89e1:    16 01        b_lt L_89e4
89e3:    00           HALT

L_89e4:
89e4:    20 b0        inc? AH, r5_low
89e6:    13 01        b3 L_89e9
89e8:    00           HALT

L_89e9:
89e9:    23 b0        neg? AH, r5_low
89eb:    13 01        b3 L_89ee
89ed:    00           HALT

L_89ee:
89ee:    11 01        b1 L_89f1
89f0:    00           HALT

L_89f1:
89f1:    14 01        b_z L_89f4
89f3:    00           HALT

L_89f4:
89f4:    23 b0        neg? AH, r5_low
89f6:    24 b0        shift_right AH, r5_low
89f8:    10 01        b0 L_89fb
89fa:    00           HALT

L_89fb:
89fb:    13 01        b3 L_89fe
89fd:    00           HALT

L_89fe:
89fe:    16 01        b_lt L_8a01
8a00:    00           HALT

L_8a01:
8a01:    27 b0        rotate_left AH, r5_low
8a03:    13 01        b3 L_8a06
8a05:    00           HALT

L_8a06:
8a06:    10 01        b0 L_8a09
8a08:    00           HALT

L_8a09:
8a09:    16 01        b_lt L_8a0c
8a0b:    00           HALT

L_8a0c:
8a0c:    23 b0        neg? AH, r5_low
8a0e:    14 01        b_z L_8a11
8a10:    00           HALT

L_8a11:
8a11:    13 01        b3 L_8a14
8a13:    00           HALT

L_8a14:
8a14:    32 60        clear AX, r3
8a16:    33 60        neg? AX, r3
8a18:    13 01        b3 L_8a1b
8a1a:    00           HALT

L_8a1b:
8a1b:    11 01        b1 L_8a1e
8a1d:    00           HALT

L_8a1e:
8a1e:    16 01        b_lt L_8a21
8a20:    00           HALT

L_8a21:
8a21:    36 60        rotate_right AX, r3
8a23:    10 01        b0 L_8a26
8a25:    00           HALT

L_8a26:
8a26:    17 01        b7 L_8a29
8a28:    00           HALT

L_8a29:
8a29:    13 01        b3 L_8a2c
8a2b:    00           HALT

L_8a2c:
8a2c:    35 60        shift_left AX, r3
8a2e:    12 01        b2 L_8a31
8a30:    00           HALT

L_8a31:
8a31:    11 01        b1 L_8a34
8a33:    00           HALT

L_8a34:
8a34:    16 01        b_lt L_8a37
8a36:    00           HALT

L_8a37:
8a37:    30 60        inc? AX, r3
8a39:    13 01        b3 L_8a3c
8a3b:    00           HALT

L_8a3c:
8a3c:    33 60        neg? AX, r3
8a3e:    13 01        b3 L_8a41
8a40:    00           HALT

L_8a41:
8a41:    11 01        b1 L_8a44
8a43:    00           HALT

L_8a44:
8a44:    14 01        b_z L_8a47
8a46:    00           HALT

L_8a47:
8a47:    33 60        neg? AX, r3
8a49:    34 60        shift_right AX, r3
8a4b:    10 01        b0 L_8a4e
8a4d:    00           HALT

L_8a4e:
8a4e:    13 01        b3 L_8a51
8a50:    00           HALT

L_8a51:
8a51:    16 01        b_lt L_8a54
8a53:    00           HALT

L_8a54:
8a54:    37 60        rotate_left AX, r3
8a56:    13 01        b3 L_8a59
8a58:    00           HALT

L_8a59:
8a59:    10 01        b0 L_8a5c
8a5b:    00           HALT

L_8a5c:
8a5c:    16 01        b_lt L_8a5f
8a5e:    00           HALT

L_8a5f:
8a5f:    33 60        neg? AX, r3
8a61:    14 01        b_z L_8a64
8a63:    00           HALT

L_8a64:
8a64:    13 01        b3 L_8a67
8a66:    00           HALT

L_8a67:
8a67:    32 40        clear AX, r2
8a69:    14 01        b_z L_8a6c
8a6b:    00           HALT

L_8a6c:
8a6c:    3e           rotate_right AX, AX
8a6d:    18 01        b_gt L_8a70
8a6f:    00           HALT

L_8a70:
8a70:    3f           rotate_left AX, AX
8a71:    14 01        b_z L_8a74
8a73:    00           HALT

L_8a74:
8a74:    3f           rotate_left AX, AX
8a75:    16 01        b_lt L_8a78
8a77:    00           HALT

L_8a78:
8a78:    3e           rotate_right AX, AX
8a79:    14 01        b_z L_8a7c
8a7b:    00           HALT

L_8a7c:
8a7c:    3a           clear AX, AX
8a7d:    3b           neg? AX, AX
8a7e:    3c           shift_right AX, AX
8a7f:    39           dec? AX, AX
8a80:    3d           shift_left AX, AX
8a81:    38           inc? AX, AX
8a82:    38           inc? AX, AX
8a83:    38           inc? AX, AX
8a84:    38           inc? AX, AX
8a85:    14 01        b_z L_8a88
8a87:    00           HALT

L_8a88:
8a88:    10 01        b0 L_8a8b
8a8a:    00           HALT

L_8a8b:
8a8b:    13 01        b3 L_8a8e
8a8d:    00           HALT

L_8a8e:
8a8e:    3a           clear AX, AX
8a8f:    80 aa        mov AL, 0xaa
8a91:    11 01        b1 L_8a94
8a93:    00           HALT

L_8a94:
8a94:    13 01        b3 L_8a97
8a96:    00           HALT

L_8a97:
8a97:    16 01        b_lt L_8a9a
8a99:    00           HALT

L_8a9a:
8a9a:    25 10        shift_left AH, AL
8a9c:    10 01        b0 L_8a9f
8a9e:    00           HALT

L_8a9f:
8a9f:    12 01        b2 L_8aa2
8aa1:    00           HALT

L_8aa2:
8aa2:    18 01        b_gt L_8aa5
8aa4:    00           HALT

L_8aa5:
8aa5:    80 00        mov AL, 0x00
8aa7:    14 01        b_z L_8aaa
8aa9:    00           HALT

L_8aaa:
8aaa:    c0 80        mov BL, 0x80
8aac:    10 01        b0 L_8aaf
8aae:    00           HALT

L_8aaf:
8aaf:    12 01        b2 L_8ab2
8ab1:    00           HALT

L_8ab2:
8ab2:    16 01        b_lt L_8ab5
8ab4:    00           HALT

L_8ab5:
8ab5:    25 30        shift_left AH, BL
8ab7:    14 01        b_z L_8aba
8ab9:    00           HALT

L_8aba:
8aba:    3a           clear AX, AX
8abb:    90 aa aa     mov AX, 0xaaaa
8abe:    11 01        b1 L_8ac1
8ac0:    00           HALT

L_8ac1:
8ac1:    13 01        b3 L_8ac4
8ac3:    00           HALT

L_8ac4:
8ac4:    16 01        b_lt L_8ac7
8ac6:    00           HALT

L_8ac7:
8ac7:    35 00        shift_left AX, AX
8ac9:    10 01        b0 L_8acc
8acb:    00           HALT

L_8acc:
8acc:    12 01        b2 L_8acf
8ace:    00           HALT

L_8acf:
8acf:    18 01        b_gt L_8ad2
8ad1:    00           HALT

L_8ad2:
8ad2:    90 00 00     mov AX, 0x0000
8ad5:    14 01        b_z L_8ad8
8ad7:    00           HALT

L_8ad8:
8ad8:    60 80 00     60 0x8000
8adb:    10 01        b0 L_8ade
8add:    00           HALT

L_8ade:
8ade:    12 01        b2 L_8ae1
8ae0:    00           HALT

L_8ae1:
8ae1:    16 01        b_lt L_8ae4
8ae3:    00           HALT

L_8ae4:
8ae4:    35 40        shift_left AX, r2
8ae6:    14 01        b_z L_8ae9
8ae8:    00           HALT

L_8ae9:
8ae9:    80 aa        mov AL, 0xaa
8aeb:    c0 aa        mov BL, 0xaa
8aed:    41 13        sub BL, AL
8aef:    14 01        b_z L_8af2
8af1:    00           HALT

L_8af2:
8af2:    10 01        b0 L_8af5
8af4:    00           HALT

L_8af5:
8af5:    13 01        b3 L_8af8
8af7:    00           HALT

L_8af8:
8af8:    c0 55        mov BL, 0x55
8afa:    40 31        add AL, BL
8afc:    11 01        b1 L_8aff
8afe:    00           HALT

L_8aff:
8aff:    13 01        b3 L_8b02
8b01:    00           HALT

L_8b02:
8b02:    2b           neg? AL, AL
8b03:    14 01        b_z L_8b06
8b05:    00           HALT

L_8b06:
8b06:    80 aa        mov AL, 0xaa
8b08:    43 31        or AL, BL
8b0a:    11 01        b1 L_8b0d
8b0c:    00           HALT

L_8b0d:
8b0d:    13 01        b3 L_8b10
8b0f:    00           HALT

L_8b10:
8b10:    2b           neg? AL, AL
8b11:    14 01        b_z L_8b14
8b13:    00           HALT

L_8b14:
8b14:    80 55        mov AL, 0x55
8b16:    02           flag2
8b17:    06           set_carry
8b18:    44 31        xor AL, BL
8b1a:    10 01        b0 L_8b1d
8b1c:    00           HALT

L_8b1d:
8b1d:    12 01        b2 L_8b20
8b1f:    00           HALT

L_8b20:
8b20:    14 01        b_z L_8b23
8b22:    00           HALT

L_8b23:
8b23:    90 55 55     mov AX, 0x5555
8b26:    d0 55 55     mov BX, 0x5555
8b29:    51 02        sub BX, AX
8b2b:    14 01        b_z L_8b2e
8b2d:    00           HALT

L_8b2e:
8b2e:    10 01        b0 L_8b31
8b30:    00           HALT

L_8b31:
8b31:    13 01        b3 L_8b34
8b33:    00           HALT

L_8b34:
8b34:    d0 aa aa     mov BX, 0xaaaa
8b37:    50 20        add AX, BX
8b39:    11 01        b1 L_8b3c
8b3b:    00           HALT

L_8b3c:
8b3c:    13 01        b3 L_8b3f
8b3e:    00           HALT

L_8b3f:
8b3f:    16 01        b_lt L_8b42
8b41:    00           HALT

L_8b42:
8b42:    3b           neg? AX, AX
8b43:    14 01        b_z L_8b46
8b45:    00           HALT

L_8b46:
8b46:    90 55 55     mov AX, 0x5555
8b49:    53 20        or AX, BX
8b4b:    11 01        b1 L_8b4e
8b4d:    00           HALT

L_8b4e:
8b4e:    13 01        b3 L_8b51
8b50:    00           HALT

L_8b51:
8b51:    3b           neg? AX, AX
8b52:    14 01        b_z L_8b55
8b54:    00           HALT

L_8b55:
8b55:    90 aa aa     mov AX, 0xaaaa
8b58:    06           set_carry
8b59:    02           flag2
8b5a:    54 20        xor AX, BX
8b5c:    10 01        b0 L_8b5f
8b5e:    00           HALT

L_8b5f:
8b5f:    12 01        b2 L_8b62
8b61:    00           HALT

L_8b62:
8b62:    14 01        b_z L_8b65
8b64:    00           HALT

L_8b65:
8b65:    90 aa 55     mov AX, 0xaa55
8b68:    55 02        mov BX, AX
8b6a:    55 04        mov r2, AX
8b6c:    55 06        mov r3, AX
8b6e:    55 08        mov r4, AX
8b70:    55 8a        mov SP, r4
8b72:    55 8c        mov r6, r4
8b74:    55 80        mov AX, r4
8b76:    50 20        add AX, BX
8b78:    50 40        add AX, r2
8b7a:    50 60        add AX, r3
8b7c:    51 08        sub r4, AX
8b7e:    51 8a        sub SP, r4
8b80:    51 ac        sub r6, SP
8b82:    51 c2        sub BX, r6
8b84:    14 01        b_z L_8b87
8b86:    00           HALT

L_8b87:
8b87:    d0 55 aa     mov BX, 0x55aa
8b8a:    44 67        xor r3_low, r3_high
8b8c:    44 76        xor r3_high, r3_low
8b8e:    44 67        xor r3_low, r3_high
8b90:    54 62        xor BX, r3
8b92:    14 01        b_z L_8b95
8b94:    00           HALT

L_8b95:
8b95:    45 69        mov SP_low, r3_high
8b97:    45 78        mov SP_high, r3_low
8b99:    44 c8        xor SP_high, r6_high
8b9b:    44 d9        xor SP_low, r6_low
8b9d:    55 88        mov r4, r4
8b9f:    14 01        b_z L_8ba2
8ba1:    00           HALT

L_8ba2:
8ba2:    90 80 00     mov AX, 0x8000
8ba5:    d0 00 01     mov BX, 0x0001
8ba8:    59           sub BX, AX
8ba9:    12 01        b2 L_8bac
8bab:    00           HALT

L_8bac:
8bac:    10 01        b0 L_8baf
8bae:    00           HALT

L_8baf:
8baf:    18 01        b_gt L_8bb2
8bb1:    00           HALT

L_8bb2:
8bb2:    03           flag3
8bb3:    06           set_carry
8bb4:    58           add BX, AX
8bb5:    13 01        b3 L_8bb8
8bb7:    00           HALT

L_8bb8:
8bb8:    11 01        b1 L_8bbb
8bba:    00           HALT

L_8bbb:
8bbb:    33 20        neg? AX, BX
8bbd:    14 01        b_z L_8bc0
8bbf:    00           HALT

L_8bc0:
8bc0:    90 aa aa     mov AX, 0xaaaa
8bc3:    d0 55 55     mov BX, 0x5555
8bc6:    5e           mov r4, AX
8bc7:    5b           or BX, AX
8bc8:    5a           and BX, AX
8bc9:    14 01        b_z L_8bcc
8bcb:    00           HALT

L_8bcc:
8bcc:    5a           and BX, AX
8bcd:    14 01        b_z L_8bd0
8bcf:    00           HALT

L_8bd0:
8bd0:    55 82        mov BX, r4
8bd2:    55 40        mov AX, r2
8bd4:    5a           and BX, AX
8bd5:    51 40        sub AX, r2
8bd7:    14 01        b_z L_8bda
8bd9:    00           HALT

L_8bda:
8bda:    91 bf fc     mov AX, [0xbffc]
8bdd:    5e           mov r4, AX
8bde:    91 00 26     mov AX, [0x0026]
8be1:    14 01        b_z L_8be4
8be3:    00           HALT

L_8be4:
8be4:    d1 00 24     mov BX, [0x0024]
8be7:    16 01        b_lt L_8bea
8be9:    00           HALT

L_8bea:
8bea:    61 00 22     61 0x0022
8bed:    18 01        b_gt L_8bf0
8bef:    00           HALT

L_8bf0:
8bf0:    b1 00 2c     mov [0x002c], AX
8bf3:    14 01        b_z L_8bf6
8bf5:    00           HALT

L_8bf6:
8bf6:    91 00 2c     mov AX, [0x002c]
8bf9:    f1 00 2c     mov [0x002c], BX
8bfc:    16 01        b_lt L_8bff
8bfe:    00           HALT

L_8bff:
8bff:    d1 00 2c     mov BX, [0x002c]
8c02:    69 00 2c     69 A, 0x002c
8c05:    18 01        b_gt L_8c08
8c07:    00           HALT

L_8c08:
8c08:    61 00 2c     61 0x002c
8c0b:    54 42        xor BX, r2
8c0d:    58           add BX, AX
8c0e:    33 20        neg? AX, BX
8c10:    14 01        b_z L_8c13
8c12:    00           HALT

L_8c13:
8c13:    91 bf fc     mov AX, [0xbffc]
8c16:    5e           mov r4, AX
8c17:    91 00 10     mov AX, [0x0010]
8c1a:    50 80        add AX, r4
8c1c:    b1 00 10     mov [0x0010], AX
8c1f:    91 00 12     mov AX, [0x0012]
8c22:    50 80        add AX, r4
8c24:    b1 00 12     mov [0x0012], AX
8c27:    91 00 14     mov AX, [0x0014]
8c2a:    50 80        add AX, r4
8c2c:    b1 00 14     mov [0x0014], AX
8c2f:    91 00 16     mov AX, [0x0016]
8c32:    50 80        add AX, r4
8c34:    b1 00 16     mov [0x0016], AX
8c37:    91 00 18     mov AX, [0x0018]
8c3a:    50 80        add AX, r4
8c3c:    b1 00 18     mov [0x0018], AX
8c3f:    92 00        unknown
8c41:    12 18        b2 L_8c5b
8c43:    01           nop
8c44:    00           HALT
8c45:    d2 00        unknown
8c47:    14 16        b_z L_8c5f
8c49:    01           nop
8c4a:    00           HALT
8c4b:    54 20        xor AX, BX
8c4d:    3b           neg? AX, AX
8c4e:    14 01        b_z L_8c51
8c50:    00           HALT

L_8c51:
8c51:    94 1c        mov AX, [pc0x1c]
8c53:    18 01        b_gt L_8c56
8c55:    00           HALT

L_8c56:
8c56:    d4 19        mov BX, [pc0x19]
8c58:    16 01        b_lt L_8c5b
8c5a:    00           HALT

L_8c5b:
8c5b:    54 20        xor AX, BX
8c5d:    3b           neg? AX, AX
8c5e:    14 01        b_z L_8c61
8c60:    00           HALT

L_8c61:
8c61:    93 0c        unknown
8c63:    d3 0c        unknown
8c65:    58           add BX, AX
8c66:    90 ff ba     mov AX, 0xffba
8c69:    58           add BX, AX
8c6a:    14 01        b_z L_8c6d
8c6c:    00           HALT

L_8c6d:
8c6d:    73 04        jump L_8c73
8c6f:    00
8c70:    22
8c71:    00
8c72:    24

L_8c73:
8c73:    60 00 20     60 0x0020
8c76:    9a           mov AX, [None]
8c77:    d0 ff ff     mov BX, 0xffff
8c7a:    59           sub BX, AX
8c7b:    14 01        b_z L_8c7e
8c7d:    00           HALT

L_8c7e:
8c7e:    95 41        mov AX, [r2++]
8c80:    3b           neg? AX, AX
8c81:    14 01        b_z L_8c84
8c83:    00           HALT

L_8c84:
8c84:    95 41        mov AX, [r2++]
8c86:    d5 41        mov AX, [r2++]
8c88:    54 20        xor AX, BX
8c8a:    3b           neg? AX, AX
8c8b:    14 01        b_z L_8c8e
8c8d:    00           HALT

L_8c8e:
8c8e:    9a           mov AX, [None]
8c8f:    14 01        b_z L_8c92
8c91:    00           HALT

L_8c92:
8c92:    95 42        mov BX, [r2++]
8c94:    d5 42        mov BX, [r2++]
8c96:    54 20        xor AX, BX
8c98:    3b           neg? AX, AX
8c99:    14 01        b_z L_8c9c
8c9b:    00           HALT

L_8c9c:
8c9c:    d0 00 24     mov BX, 0x0024
8c9f:    9a           mov AX, [None]
8ca0:    65 28        unknown
8ca2:    fe           mov [None], BX
8ca3:    54 40        xor AX, r2
8ca5:    14 01        b_z L_8ca8
8ca7:    00           HALT

L_8ca8:
8ca8:    95 28        mov r4, [BX++]
8caa:    fc           mov [None], BX
8cab:    65 29        unknown
8cad:    02           flag2
8cae:    50 40        add AX, r2
8cb0:    3b           neg? AX, AX
8cb1:    14 01        b_z L_8cb4
8cb3:    00           HALT

L_8cb4:
8cb4:    99           mov AX, [None]
8cb5:    65 2a        unknown
8cb7:    fc           mov [None], BX
8cb8:    54 40        xor AX, r2
8cba:    3b           neg? AX, AX
8cbb:    14 01        b_z L_8cbe
8cbd:    00           HALT

L_8cbe:
8cbe:    60 00 10     60 0x0010
8cc1:    95 44        mov r2, [r2++]
8cc3:    d0 ff ff     mov BX, 0xffff
8cc6:    59           sub BX, AX
8cc7:    14 01        b_z L_8cca
8cc9:    00           HALT

L_8cca:
8cca:    95 45        mov r2, [r2++]
8ccc:    3b           neg? AX, AX
8ccd:    14 01        b_z L_8cd0
8ccf:    00           HALT

L_8cd0:
8cd0:    95 45        mov r2, [r2++]
8cd2:    d5 45        mov r2, [r2++]
8cd4:    54 20        xor AX, BX
8cd6:    3b           neg? AX, AX
8cd7:    14 01        b_z L_8cda
8cd9:    00           HALT

L_8cda:
8cda:    95 46        mov r3, [r2++]
8cdc:    d5 46        mov r3, [r2++]
8cde:    54 20        xor AX, BX
8ce0:    3b           neg? AX, AX
8ce1:    14 01        b_z L_8ce4
8ce3:    00           HALT

L_8ce4:
8ce4:    60 00 14     60 0x0014
8ce7:    95 44        mov r2, [r2++]
8ce9:    d5 4c        mov r6, [r2++]
8ceb:    fe           mov [None], BX
8cec:    54 20        xor AX, BX
8cee:    3b           neg? AX, AX
8cef:    14 01        b_z L_8cf2
8cf1:    00           HALT

L_8cf2:
8cf2:    95 4c        mov r6, [r2++]
8cf4:    fc           mov [None], BX
8cf5:    d5 4d        mov r6, [r2++]
8cf7:    02           flag2
8cf8:    50 20        add AX, BX
8cfa:    3b           neg? AX, AX
8cfb:    14 01        b_z L_8cfe
8cfd:    00           HALT

L_8cfe:
8cfe:    95 44        mov r2, [r2++]
8d00:    d5 4e        mov r7, [r2++]
8d02:    fc           mov [None], BX
8d03:    54 20        xor AX, BX
8d05:    3b           neg? AX, AX
8d06:    14 01        b_z L_8d09
8d08:    00           HALT

L_8d09:
8d09:    0d           unknown
8d0a:    90 05 0a     mov AX, 0x050a
8d0d:    50 80        add AX, r4
8d0f:    51 04        sub r2, AX
8d11:    14 01        b_z L_8d14
8d13:    00           HALT

L_8d14:
8d14:    90 00 3a     mov AX, 0x003a
8d17:    5f           mov SP, AX
8d18:    60 20 20     60 0x2020
8d1b:    7b 06        call L_8d23
8d1d:    01           nop
8d1e:    01           nop
8d1f:    00           HALT
8d20:    73 16        jump L_8d38
8d22:    00

L_8d23:
8d23:    95 41        mov AX, [r2++]
8d25:    d0 01 01     mov BX, 0x0101
8d28:    54 20        xor AX, BX
8d2a:    14 01        b_z L_8d2d
8d2c:    00           HALT

L_8d2d:
8d2d:    9d           mov AX, [None]
8d2e:    d0 20 20     mov BX, 0x2020
8d31:    54 20        xor AX, BX
8d33:    14 01        b_z L_8d36
8d35:    00           HALT

L_8d36:
8d36:    3e           rotate_right AX, AX
8d37:    09           ret

L_8d38:
8d38:    60 09 ef     60 0x09ef
8d3b:    90 11 ff     mov AX, 0x11ff
8d3e:    b5 41        mov [--r2], AX
8d40:    55 42        mov BX, r2
8d42:    90 09 f1     mov AX, 0x09f1
8d45:    59           sub BX, AX
8d46:    14 01        b_z L_8d49
8d48:    00           HALT

L_8d49:
8d49:    60 09 ef     60 0x09ef
8d4c:    95 41        mov AX, [r2++]
8d4e:    d0 11 ff     mov BX, 0x11ff
8d51:    41 02        sub BH, AH
8d53:    14 01        b_z L_8d56
8d55:    00           HALT

L_8d56:
8d56:    49           sub BL, AL
8d57:    14 01        b_z L_8d5a
8d59:    00           HALT

L_8d5a:
8d5a:    90 60 66     mov AX, 0x6066
8d5d:    2f 00        DMA load 0, 0
8d5f:    2f 21        DMA load 2, 1
8d61:    59           sub BX, AX
8d62:    14 01        b_z L_8d65
8d64:    00           HALT

L_8d65:
8d65:    90 46 11     mov AX, 0x4611
8d68:    2f 02        DMA load 0, 2
8d6a:    2f 23        DMA load 2, 3
8d6c:    59           sub BX, AX
8d6d:    14 01        b_z L_8d70
8d6f:    00           HALT

L_8d70:
8d70:    81 f2 00     mov AL, [0xf200]
8d73:    2c           shift_right AL, AL
8d74:    11 18        b1 L_8d8e
8d76:    81 f2 01     mov AL, [0xf201]
8d79:    c0 80        mov BL, 0x80
8d7b:    43 31        or AL, BL
8d7d:    c0 83        mov BL, 0x83
8d7f:    49           sub BL, AL
8d80:    15 0c        b_nz L_8d8e
8d82:    61 bf fe     61 0xbffe
8d85:    91 bf fc     mov AX, [0xbffc]
8d88:    d0 07 74     mov BX, 0x0774
8d8b:    58           add BX, AX
8d8c:    75 20        jump A + 0x20

L_8d8e:
8d8e:    a1 f1 0a     mov [0xf10a], AL
8d91:    90 bf fc     mov AX, 0xbffc
8d94:    5f           mov SP, AX
8d95:    95 a1        mov AX, [SP++]
8d97:    5e           mov r4, AX
8d98:    65 a1        unknown
8d9a:    90 00 7d     mov AX, 0x007d
8d9d:    50 80        add AX, r4
8d9f:    75 00        jump A + 0x00

Fn_5a1:
8da1:    05           flag5
8da2:    b1 05 b3     mov [0x05b3], AX
8da5:    05           flag5
8da6:    b5 05        mov [--AX], r2
8da8:    b7 05        unknown
8daa:    b9           mov [None], AX
8dab:    00           HALT
8dac:    00           HALT
8dad:    00           HALT
8dae:    00           HALT
8daf:    00           HALT
8db0:    00           HALT
8db1:    ff           mov [None], BX
8db2:    ff           mov [None], BX
8db3:    55 55        mov r2, r2
8db5:    aa           mov [None], AL
8db6:    aa           mov [None], AL
8db7:    00           HALT
8db8:    00           HALT
8db9:    80 01        mov AL, 0x01

Entry_CPU6_MAPPING_RAM_TEST:
8dbb:    90 07 cc     mov AX, 0x07cc
8dbe:    50 80        add AX, r4
8dc0:    7d 00        call A + 0x00
8dc2:    "\x1b\x1c\x0cCPU-6 MAPPING RAM TEST, CONTROL-C TO EXIT\r\n\0"
8df1:    22 32        clear BH, BL
8df3:    15 3a        b_nz L_8e2f
8df5:    90 07 cc     mov AX, 0x07cc
8df8:    50 80        add AX, r4
8dfa:    7d 00        call A + 0x00
8dfc:    "\r\n*** THIS TEST WILL NOT RUN ON CPU-5 ***\r\n\0"
8e28:    90 07 8a     mov AX, 0x078a
8e2b:    50 80        add AX, r4
8e2d:    75 00        jump A + 0x00

L_8e2f:
8e2f:    90 06 d9     mov AX, 0x06d9
8e32:    50 80        add AX, r4
8e34:    7d 00        call A + 0x00
8e36:    47           unknown
8e37:    40 ff        add r7_low, r7_low
8e39:    01           nop
8e3a:    00           HALT
8e3b:    02           flag2
8e3c:    00           HALT
8e3d:    7b 36        call L_8e75
8e3f:    01           nop
8e40:    7b 33        call L_8e75
8e42:    02           flag2
8e43:    7b 30        call L_8e75
8e45:    03           flag3
8e46:    7b 2d        call L_8e75
8e48:    04           flag4
8e49:    7b 2a        call L_8e75
8e4b:    05           flag5
8e4c:    7b 27        call L_8e75
8e4e:    06           set_carry
8e4f:    7b 24        call L_8e75
8e51:    07           clear_carry
8e52:    7b 53        call L_8ea7
8e54:    7b 1f        call L_8e75
8e56:    00           HALT
8e57:    7b 73        call L_8ecc
8e59:    a1 f1 0a     mov [0xf10a], AL
8e5c:    81 f2 00     mov AL, [0xf200]
8e5f:    2c           shift_right AL, AL
8e60:    11 cd        b1 L_8e2f
8e62:    81 f2 01     mov AL, [0xf201]
8e65:    c0 80        mov BL, 0x80
8e67:    43 31        or AL, BL
8e69:    c0 83        mov BL, 0x83
8e6b:    49           sub BL, AL
8e6c:    15 c1        b_nz L_8e2f
8e6e:    90 07 74     mov AX, 0x0774
8e71:    50 80        add AX, r4
8e73:    75 00        jump A + 0x00

L_8e75:
8e75:    3a           clear AX, AX
8e76:    85 41        mov AL, [r2++]
8e78:    35 04        shift_left r2, AX
8e7a:    20 00        inc? AH, AH
8e7c:    7e           unknown
8e7d:    45 5c        mov r6_high, r2_low
8e7f:    5e           mov r4, AX
8e80:    20 80        inc? AH, SP_high
8e82:    60 00 20     60 0x0020

L_8e85:
8e85:    d0 01 00     mov BX, 0x0100

L_8e88:
8e88:    8b           mov AL, [None]
8e89:    28           inc? AL, AL
8e8a:    ab           mov [None], AL
8e8b:    ac           mov [None], AL
8e8c:    7b 76        call L_8f04
8e8e:    7b 49        call Fn_6d9
8e90:    47           unknown
8e91:    80 ff        mov AL, 0xff
8e93:    01           nop
8e94:    00           HALT
8e95:    02           flag2
8e96:    00           HALT
8e97:    15 69        b_nz L_8f02
8e99:    31 20        dec? AX, BX
8e9b:    15 eb        b_nz L_8e88
8e9d:    30 60        inc? AX, r3
8e9f:    30 80        inc? AX, r4
8ea1:    3f           rotate_left AX, AX
8ea2:    15 e1        b_nz L_8e85
8ea4:    7f           unknown
8ea5:    45 09        mov SP_low, AH

L_8ea7:
8ea7:    2e 1c        ?? r12, r1
8ea9:    f8           mov [None], BX
8eaa:    03           flag3
8eab:    00           HALT
8eac:    2e 0c        ?? r12, r0
8eae:    f9           mov [None], BX
8eaf:    03           flag3
8eb0:    00           HALT
8eb1:    80 01        mov AL, 0x01

L_8eb3:
8eb3:    a5 a2        mov [--SP], BH
8eb5:    2a           clear AL, AL
8eb6:    a5 a2        mov [--SP], BH
8eb8:    6d a2        unknown
8eba:    a5 a2        mov [--SP], BH
8ebc:    60 06 c2     60 0x06c2
8ebf:    50 84        add r2, r4
8ec1:    0f           unknown
8ec2:    7b 15        call Fn_6d9
8ec4:    47           unknown
8ec5:    40 ff        add r7_low, r7_low
8ec7:    01           nop
8ec8:    00           HALT
8ec9:    02           flag2
8eca:    00           HALT
8ecb:    09           ret

L_8ecc:
8ecc:    2e 1c        ?? r12, r1
8ece:    f9           mov [None], BX
8ecf:    03           flag3
8ed0:    00           HALT
8ed1:    2e 0c        ?? r12, r0
8ed3:    f8           mov [None], BX
8ed4:    03           flag3
8ed5:    00           HALT
8ed6:    2a           clear AL, AL
8ed7:    73 da        jump L_8eb3

Fn_6d9:
8ed9:    2e 1c        ?? r12, r1
8edb:    f8           mov [None], BX
8edc:    01           nop
8edd:    00           HALT
8ede:    2e 1c        ?? r12, r1

L_8ee0:
8ee0:    f9           mov [None], BX
8ee1:    01           nop
8ee2:    20 2e        inc? r7_high, BH
8ee4:    1c fa        b_sense2 L_8ee0

L_8ee6:
8ee6:    01           nop
8ee7:    40 2e        add r7_high, BH
8ee9:    1c fb        b_sense2 L_8ee6
8eeb:    01           nop
8eec:    60 2e 1c     60 0x2e1c
8eef:    fc           mov [None], BX
8ef0:    01           nop
8ef1:    80 2e        mov AL, 0x2e
8ef3:    1c fd        b_sense2 L_8ef2
8ef5:    01           nop
8ef6:    a0 2e        unknown

L_8ef8:
8ef8:    1c fe        b_sense2 L_8ef8
8efa:    01           nop
8efb:    c0 2e        mov BL, 0x2e
8efd:    1c ff        b_sense2 L_8efe
8eff:    01           nop
8f00:    e0 09        unknown

L_8f02:
8f02:    73 29        jump L_8f2d

L_8f04:
8f04:    2e 0c        ?? r12, r0
8f06:    f8           mov [None], BX
8f07:    01           nop
8f08:    00           HALT
8f09:    2e 0c        ?? r12, r0
8f0b:    f9           mov [None], BX
8f0c:    01           nop
8f0d:    20 2e        inc? r7_high, BH
8f0f:    0c           unknown
8f10:    fa           mov [None], BX
8f11:    01           nop
8f12:    40 2e        add r7_high, BH
8f14:    0c           unknown
8f15:    fb           mov [None], BX
8f16:    01           nop
8f17:    60 2e 0c     60 0x2e0c
8f1a:    fc           mov [None], BX
8f1b:    01           nop
8f1c:    80 2e        mov AL, 0x2e
8f1e:    0c           unknown
8f1f:    fd           mov [None], BX
8f20:    01           nop
8f21:    a0 2e        unknown
8f23:    0c           unknown
8f24:    fe           mov [None], BX
8f25:    01           nop
8f26:    c0 2e        mov BL, 0x2e
8f28:    0c           unknown
8f29:    ff           mov [None], BX
8f2a:    01           nop
8f2b:    e0 09        unknown

L_8f2d:
8f2d:    7f           unknown
8f2e:    45 65        mov r2_low, r3_high
8f30:    a1 90 07     mov [0x9007], AL
8f33:    cc           mov BL, [None]
8f34:    50 80        add AX, r4
8f36:    7d 00        call A + 0x00
8f38:    "\r\n*** MAP RAM ERROR ***\r\n\0"
8f52:    a1 f1 0b     mov [0xf10b], AL
8f55:    a1 f1 0c     mov [0xf10c], AL
8f58:    90 07 8a     mov AX, 0x078a
8f5b:    50 80        add AX, r4
8f5d:    75 00        jump A + 0x00

Entry_ROM_SELF_TEST:
8f5f:    55 86        mov r3, r4
8f61:    3a           clear AX, AX

ChecksumLoop:
8f62:    85 61        mov AL, [r3++] ; Load Byte via base+index, post-increment index
8f64:    40 10        add AH, AL
8f66:    d0 07 dd     mov BX, 0x07dd
8f69:    50 82        add BX, r4
8f6b:    51 62        sub BX, r3
8f6d:    15 f3        b_nz ChecksumLoop
8f6f:    8b           mov AL, [None] ; Load Byte via base+index
8f70:    41 01        sub AL, AH
8f72:    15 32        b_nz ChecksumFail
8f74:    7b 56        call WriteString
8f76:    "\r\n*** PASS ***\r\n\0"
8f87:    a1 f1 0a     mov [0xf10a], AL

L_8f8a:
8f8a:    7b 40        call WriteString
8f8c:    "PRESS SPACE\x07\r\n\0"

WaitForKey:
8f9b:    81 f2 00     mov AL, [0xf200]
8f9e:    2c           shift_right AL, AL
8f9f:    11 fa        b1 WaitForKey
8fa1:    81 f2 01     mov AL, [0xf201]
8fa4:    75 40        jump A + 0x40

ChecksumFail:
8fa6:    7b 24        call WriteString
8fa8:    "\r\n*** CHECK SUM ERROR ***\r\n\0"
8fc4:    a1 f1 0b     mov [0xf10b], AL
8fc7:    a1 f1 0c     mov [0xf10c], AL
8fca:    73 be        jump L_8f8a

WriteString:
8fcc:    81 f2 00     mov AL, [0xf200]
8fcf:    2c           shift_right AL, AL
8fd0:    2c           shift_right AL, AL
8fd1:    11 f9        b1 WriteString
8fd3:    85 41        mov AL, [r2++]
8fd5:    15 01        b_nz L_8fd8
8fd7:    09           ret

L_8fd8:
8fd8:    a1 f2 01     mov [0xf201], AL
8fdb:    73 ef        jump WriteString
8fdd:    82
8fde:    00
8fdf:    00
