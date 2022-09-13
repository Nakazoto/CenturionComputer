
TEST_0:
8800:    00 49                  (0x49)
8802:    "CPU INSTRUCTION TEST\r\n\0"

TEST_1:
8819:    05 bb                  (0x5bb)
881b:    "CPU-6 MAPPING RAM TEST\r\n\0"

TEST_2:
8834:    07 5f                  (0x75f)
8836:    "ROM SELF TEST\r\n\n\0"

TEST_3:
8847:    00 00                  (0x0)

Entry_CPU_INSTRUCTION_TEST:
8849:    90 07 cc               ld A, 0x07cc
884c:    50 80                  add A, Z
884e:    7d 00                  call [A]
8850:    "\x1b\x1c\x0cCPU INSTRUCTION TEST, CONTROL-C TO EXIT\r\n\0"
887d:    6d a2                  st X, [--S]
887f:    55 80                  mov A, Z
8881:    b5 a2                  st A, [--S]
8883:    60 00 20               ld X, 0x0020	 ; This is a testing that the 60 3 byte instruction is working.
                                            	 ; Which it will use later to test other multi-byte instructions
                                            	 ; If the operand isn't consumed, then a HALT instruction will be executed
8886:    90 05 a1               ld A, 0x05a1
8889:    50 80                  add A, Z
888b:    5c                     mov Y, A	 ; This might be installing an exception handler?
888c:    90 00 10               ld A, 0x0010

L_888f:
888f:    c5 61                  ld BL, [Y++]
8891:    e5 01                  st BL, [A++]
8893:    3f                     dec X
8894:    15 f9                  bnz L_888f	 ; clearing all registers?
8896:    03                     rf
8897:    07                     rl
8898:    c0 01                  ld BL, 0x01	 ; if A is empty. This would set the overflow flag
889a:    11 01                  bnc L_889d	 ; Some tests for all the branch instructions
889c:    00                     HALT

L_889d:
889d:    13 01                  bnn L_88a0
889f:    00                     HALT

L_88a0:
88a0:    17 01                  bp L_88a3
88a2:    00                     HALT

L_88a3:
88a3:    15 01                  bnz L_88a6
88a5:    00                     HALT

L_88a6:
88a6:    18 01                  bgt L_88a9
88a8:    00                     HALT

L_88a9:
88a9:    10 02                  bc L_88ad	 ; branch 10 is expected to not branch here
88ab:    11 01                  bnc L_88ae	 ; The author could have used any branch here, but using 11 here
                                          	 ; implies 11 is the opposite of 10

L_88ad:
88ad:    00                     HALT

L_88ae:
88ae:    12 02                  bn L_88b2
88b0:    13 01                  bnn L_88b3	 ; likewise, 13 is the opposite of 12 (and so on, below)

L_88b2:
88b2:    00                     HALT

L_88b3:
88b3:    14 02                  bz L_88b7
88b5:    15 01                  bnz L_88b8

L_88b7:
88b7:    00                     HALT

L_88b8:
88b8:    16 02                  blt L_88bc
88ba:    17 01                  bp L_88bd

L_88bc:
88bc:    00                     HALT

L_88bd:
88bd:    19 02                  ble L_88c1
88bf:    18 0a                  bgt L_88cb

L_88c1:
88c1:    00                     HALT

L_88c2:
88c2:    18 04                  bgt L_88c8
88c4:    00                     HALT

L_88c5:
88c5:    18 07                  bgt L_88ce
88c7:    00                     HALT

L_88c8:
88c8:    18 fb                  bgt L_88c5
88ca:    00                     HALT

L_88cb:
88cb:    18 f5                  bgt L_88c2
88cd:    00                     HALT

L_88ce:
88ce:    08                     cl
88cf:    10 01                  bc L_88d2
88d1:    00                     HALT

L_88d2:
88d2:    07                     rl
88d3:    11 01                  bnc L_88d6
88d5:    00                     HALT

L_88d6:
88d6:    06                     sl
88d7:    10 01                  bc L_88da
88d9:    00                     HALT

L_88da:
88da:    08                     cl
88db:    11 01                  bnc L_88de
88dd:    00                     HALT

L_88de:
88de:    02                     sf
88df:    12 01                  bn L_88e2
88e1:    00                     HALT

L_88e2:
88e2:    03                     rf
88e3:    13 01                  bnn L_88e6
88e5:    00                     HALT

L_88e6:
88e6:    01                     nop
88e7:    11 01                  bnc L_88ea
88e9:    00                     HALT

L_88ea:
88ea:    13 01                  bnn L_88ed
88ec:    00                     HALT

L_88ed:
88ed:    18 01                  bgt L_88f0
88ef:    00                     HALT

L_88f0:
88f0:    02                     sf
88f1:    06                     sl
88f2:    01                     nop
88f3:    10 01                  bc L_88f6
88f5:    00                     HALT

L_88f6:
88f6:    12 01                  bn L_88f9
88f8:    00                     HALT

L_88f9:
88f9:    2a                     clr AL, #0
88fa:    11 01                  bnc L_88fd
88fc:    00                     HALT

L_88fd:
88fd:    13 01                  bnn L_8900
88ff:    00                     HALT

L_8900:
8900:    14 01                  bz L_8903
8902:    00                     HALT

L_8903:
8903:    17 01                  bp L_8906
8905:    00                     HALT

L_8906:
8906:    19 01                  ble L_8909
8908:    00                     HALT

L_8909:
8909:    2b                     not AL, #0
890a:    13 01                  bnn L_890d
890c:    00                     HALT

L_890d:
890d:    11 01                  bnc L_8910
890f:    00                     HALT

L_8910:
8910:    16 01                  blt L_8913
8912:    00                     HALT

L_8913:
8913:    19 01                  ble L_8916
8915:    00                     HALT

L_8916:
8916:    06                     sl
8917:    02                     sf
8918:    22 70                  clr YL, #0
891a:    11 01                  bnc L_891d
891c:    00                     HALT

L_891d:
891d:    13 01                  bnn L_8920
891f:    00                     HALT

L_8920:
8920:    14 01                  bz L_8923
8922:    00                     HALT

L_8923:
8923:    20 70                  inc YL, #1
8925:    11 01                  bnc L_8928
8927:    00                     HALT

L_8928:
8928:    13 01                  bnn L_892b
892a:    00                     HALT

L_892b:
892b:    18 01                  bgt L_892e
892d:    00                     HALT

L_892e:
892e:    21 70                  dec YL, #1
8930:    13 01                  bnn L_8933
8932:    00                     HALT

L_8933:
8933:    11 01                  bnc L_8936
8935:    00                     HALT

L_8936:
8936:    14 01                  bz L_8939
8938:    00                     HALT

L_8939:
8939:    21 70                  dec YL, #1
893b:    13 01                  bnn L_893e
893d:    00                     HALT

L_893e:
893e:    11 01                  bnc L_8941
8940:    00                     HALT

L_8941:
8941:    16 01                  blt L_8944
8943:    00                     HALT

L_8944:
8944:    20 70                  inc YL, #1
8946:    13 01                  bnn L_8949
8948:    00                     HALT

L_8949:
8949:    11 01                  bnc L_894c
894b:    00                     HALT

L_894c:
894c:    14 01                  bz L_894f
894e:    00                     HALT

L_894f:
894f:    06                     sl
8950:    02                     sf
8951:    22 60                  clr YH, #0	 ; Using 60 in the operand means the following branch will be skipped
                                          	 ; if 22 doesn't consume it's operand
8953:    11 01                  bnc L_8956
8955:    00                     HALT

L_8956:
8956:    13 01                  bnn L_8959
8958:    00                     HALT

L_8959:
8959:    14 01                  bz L_895c
895b:    00                     HALT

L_895c:
895c:    20 60                  inc YH, #1
895e:    11 01                  bnc L_8961
8960:    00                     HALT

L_8961:
8961:    13 01                  bnn L_8964
8963:    00                     HALT

L_8964:
8964:    18 01                  bgt L_8967
8966:    00                     HALT

L_8967:
8967:    21 60                  dec YH, #1
8969:    13 01                  bnn L_896c
896b:    00                     HALT

L_896c:
896c:    11 01                  bnc L_896f
896e:    00                     HALT

L_896f:
896f:    14 01                  bz L_8972
8971:    00                     HALT

L_8972:
8972:    21 60                  dec YH, #1
8974:    13 01                  bnn L_8977
8976:    00                     HALT

L_8977:
8977:    11 01                  bnc L_897a
8979:    00                     HALT

L_897a:
897a:    16 01                  blt L_897d
897c:    00                     HALT

L_897d:
897d:    20 60                  inc YH, #1
897f:    13 01                  bnn L_8982
8981:    00                     HALT

L_8982:
8982:    11 01                  bnc L_8985
8984:    00                     HALT

L_8985:
8985:    14 01                  bz L_8988
8987:    00                     HALT

L_8988:
8988:    06                     sl
8989:    02                     sf
898a:    32 20                  clr B, #0
898c:    11 01                  bnc L_898f
898e:    00                     HALT

L_898f:
898f:    13 01                  bnn L_8992
8991:    00                     HALT

L_8992:
8992:    14 01                  bz L_8995
8994:    00                     HALT

L_8995:
8995:    30 20                  inc B, #1
8997:    11 01                  bnc L_899a
8999:    00                     HALT

L_899a:
899a:    13 01                  bnn L_899d
899c:    00                     HALT

L_899d:
899d:    18 01                  bgt L_89a0
899f:    00                     HALT

L_89a0:
89a0:    21 30                  dec BL, #1
89a2:    13 01                  bnn L_89a5
89a4:    00                     HALT

L_89a5:
89a5:    11 01                  bnc L_89a8
89a7:    00                     HALT

L_89a8:
89a8:    14 01                  bz L_89ab
89aa:    00                     HALT

L_89ab:
89ab:    31 20                  dec B, #1
89ad:    13 01                  bnn L_89b0
89af:    00                     HALT

L_89b0:
89b0:    11 01                  bnc L_89b3
89b2:    00                     HALT

L_89b3:
89b3:    16 01                  blt L_89b6
89b5:    00                     HALT

L_89b6:
89b6:    30 20                  inc B, #1
89b8:    13 01                  bnn L_89bb
89ba:    00                     HALT

L_89bb:
89bb:    11 01                  bnc L_89be
89bd:    00                     HALT

L_89be:
89be:    14 01                  bz L_89c1
89c0:    00                     HALT

L_89c1:
89c1:    22 b0                  clr SL, #0
89c3:    23 b0                  not SL, #0
89c5:    11 01                  bnc L_89c8
89c7:    00                     HALT

L_89c8:
89c8:    13 01                  bnn L_89cb
89ca:    00                     HALT

L_89cb:
89cb:    16 01                  blt L_89ce
89cd:    00                     HALT

L_89ce:
89ce:    26 b0                  rrc SL, #1
89d0:    10 01                  bc L_89d3
89d2:    00                     HALT

L_89d3:
89d3:    17 01                  bp L_89d6
89d5:    00                     HALT

L_89d6:
89d6:    13 01                  bnn L_89d9
89d8:    00                     HALT

L_89d9:
89d9:    25 b0                  sll SL, #1
89db:    12 01                  bn L_89de
89dd:    00                     HALT

L_89de:
89de:    11 01                  bnc L_89e1
89e0:    00                     HALT

L_89e1:
89e1:    16 01                  blt L_89e4
89e3:    00                     HALT

L_89e4:
89e4:    20 b0                  inc SL, #1
89e6:    13 01                  bnn L_89e9
89e8:    00                     HALT

L_89e9:
89e9:    23 b0                  not SL, #0
89eb:    13 01                  bnn L_89ee
89ed:    00                     HALT

L_89ee:
89ee:    11 01                  bnc L_89f1
89f0:    00                     HALT

L_89f1:
89f1:    14 01                  bz L_89f4
89f3:    00                     HALT

L_89f4:
89f4:    23 b0                  not SL, #0
89f6:    24 b0                  srl SL, #1
89f8:    10 01                  bc L_89fb
89fa:    00                     HALT

L_89fb:
89fb:    13 01                  bnn L_89fe
89fd:    00                     HALT

L_89fe:
89fe:    16 01                  blt L_8a01
8a00:    00                     HALT

L_8a01:
8a01:    27 b0                  rlc SL, #1
8a03:    13 01                  bnn L_8a06
8a05:    00                     HALT

L_8a06:
8a06:    10 01                  bc L_8a09
8a08:    00                     HALT

L_8a09:
8a09:    16 01                  blt L_8a0c
8a0b:    00                     HALT

L_8a0c:
8a0c:    23 b0                  not SL, #0
8a0e:    14 01                  bz L_8a11
8a10:    00                     HALT

L_8a11:
8a11:    13 01                  bnn L_8a14
8a13:    00                     HALT

L_8a14:
8a14:    32 60                  clr Y, #0
8a16:    33 60                  not Y, #0
8a18:    13 01                  bnn L_8a1b
8a1a:    00                     HALT

L_8a1b:
8a1b:    11 01                  bnc L_8a1e
8a1d:    00                     HALT

L_8a1e:
8a1e:    16 01                  blt L_8a21
8a20:    00                     HALT

L_8a21:
8a21:    36 60                  rrc Y, #1
8a23:    10 01                  bc L_8a26
8a25:    00                     HALT

L_8a26:
8a26:    17 01                  bp L_8a29
8a28:    00                     HALT

L_8a29:
8a29:    13 01                  bnn L_8a2c
8a2b:    00                     HALT

L_8a2c:
8a2c:    35 60                  sll Y, #1
8a2e:    12 01                  bn L_8a31
8a30:    00                     HALT

L_8a31:
8a31:    11 01                  bnc L_8a34
8a33:    00                     HALT

L_8a34:
8a34:    16 01                  blt L_8a37
8a36:    00                     HALT

L_8a37:
8a37:    30 60                  inc Y, #1
8a39:    13 01                  bnn L_8a3c
8a3b:    00                     HALT

L_8a3c:
8a3c:    33 60                  not Y, #0
8a3e:    13 01                  bnn L_8a41
8a40:    00                     HALT

L_8a41:
8a41:    11 01                  bnc L_8a44
8a43:    00                     HALT

L_8a44:
8a44:    14 01                  bz L_8a47
8a46:    00                     HALT

L_8a47:
8a47:    33 60                  not Y, #0
8a49:    34 60                  srl Y, #1
8a4b:    10 01                  bc L_8a4e
8a4d:    00                     HALT

L_8a4e:
8a4e:    13 01                  bnn L_8a51
8a50:    00                     HALT

L_8a51:
8a51:    16 01                  blt L_8a54
8a53:    00                     HALT

L_8a54:
8a54:    37 60                  rlc Y, #1
8a56:    13 01                  bnn L_8a59
8a58:    00                     HALT

L_8a59:
8a59:    10 01                  bc L_8a5c
8a5b:    00                     HALT

L_8a5c:
8a5c:    16 01                  blt L_8a5f
8a5e:    00                     HALT

L_8a5f:
8a5f:    33 60                  not Y, #0
8a61:    14 01                  bz L_8a64
8a63:    00                     HALT

L_8a64:
8a64:    13 01                  bnn L_8a67
8a66:    00                     HALT

L_8a67:
8a67:    32 40                  clr X, #0
8a69:    14 01                  bz L_8a6c
8a6b:    00                     HALT

L_8a6c:
8a6c:    3e                     inc X
8a6d:    18 01                  bgt L_8a70
8a6f:    00                     HALT

L_8a70:
8a70:    3f                     dec X
8a71:    14 01                  bz L_8a74
8a73:    00                     HALT

L_8a74:
8a74:    3f                     dec X
8a75:    16 01                  blt L_8a78
8a77:    00                     HALT

L_8a78:
8a78:    3e                     inc X
8a79:    14 01                  bz L_8a7c
8a7b:    00                     HALT

L_8a7c:
8a7c:    3a                     clr A, #0
8a7d:    3b                     not A, #0
8a7e:    3c                     srl A, #1
8a7f:    39                     dec A, #1
8a80:    3d                     sll A, #1
8a81:    38                     inc A, #1
8a82:    38                     inc A, #1
8a83:    38                     inc A, #1
8a84:    38                     inc A, #1
8a85:    14 01                  bz L_8a88
8a87:    00                     HALT

L_8a88:
8a88:    10 01                  bc L_8a8b
8a8a:    00                     HALT

L_8a8b:
8a8b:    13 01                  bnn L_8a8e
8a8d:    00                     HALT

L_8a8e:
8a8e:    3a                     clr A, #0
8a8f:    80 aa                  ld AL, 0xaa
8a91:    11 01                  bnc L_8a94
8a93:    00                     HALT

L_8a94:
8a94:    13 01                  bnn L_8a97
8a96:    00                     HALT

L_8a97:
8a97:    16 01                  blt L_8a9a
8a99:    00                     HALT

L_8a9a:
8a9a:    25 10                  sll AL, #1
8a9c:    10 01                  bc L_8a9f
8a9e:    00                     HALT

L_8a9f:
8a9f:    12 01                  bn L_8aa2
8aa1:    00                     HALT

L_8aa2:
8aa2:    18 01                  bgt L_8aa5
8aa4:    00                     HALT

L_8aa5:
8aa5:    80 00                  ld AL, 0x00
8aa7:    14 01                  bz L_8aaa
8aa9:    00                     HALT

L_8aaa:
8aaa:    c0 80                  ld BL, 0x80
8aac:    10 01                  bc L_8aaf
8aae:    00                     HALT

L_8aaf:
8aaf:    12 01                  bn L_8ab2
8ab1:    00                     HALT

L_8ab2:
8ab2:    16 01                  blt L_8ab5
8ab4:    00                     HALT

L_8ab5:
8ab5:    25 30                  sll BL, #1
8ab7:    14 01                  bz L_8aba
8ab9:    00                     HALT

L_8aba:
8aba:    3a                     clr A, #0
8abb:    90 aa aa               ld A, 0xaaaa
8abe:    11 01                  bnc L_8ac1
8ac0:    00                     HALT

L_8ac1:
8ac1:    13 01                  bnn L_8ac4
8ac3:    00                     HALT

L_8ac4:
8ac4:    16 01                  blt L_8ac7
8ac6:    00                     HALT

L_8ac7:
8ac7:    35 00                  sll A, #1
8ac9:    10 01                  bc L_8acc
8acb:    00                     HALT

L_8acc:
8acc:    12 01                  bn L_8acf
8ace:    00                     HALT

L_8acf:
8acf:    18 01                  bgt L_8ad2
8ad1:    00                     HALT

L_8ad2:
8ad2:    90 00 00               ld A, 0x0000
8ad5:    14 01                  bz L_8ad8
8ad7:    00                     HALT

L_8ad8:
8ad8:    60 80 00               ld X, 0x8000
8adb:    10 01                  bc L_8ade
8add:    00                     HALT

L_8ade:
8ade:    12 01                  bn L_8ae1
8ae0:    00                     HALT

L_8ae1:
8ae1:    16 01                  blt L_8ae4
8ae3:    00                     HALT

L_8ae4:
8ae4:    35 40                  sll X, #1
8ae6:    14 01                  bz L_8ae9
8ae8:    00                     HALT

L_8ae9:
8ae9:    80 aa                  ld AL, 0xaa
8aeb:    c0 aa                  ld BL, 0xaa
8aed:    41 13                  sub BL, AL
8aef:    14 01                  bz L_8af2
8af1:    00                     HALT

L_8af2:
8af2:    10 01                  bc L_8af5
8af4:    00                     HALT

L_8af5:
8af5:    13 01                  bnn L_8af8
8af7:    00                     HALT

L_8af8:
8af8:    c0 55                  ld BL, 0x55
8afa:    40 31                  add AL, BL
8afc:    11 01                  bnc L_8aff
8afe:    00                     HALT

L_8aff:
8aff:    13 01                  bnn L_8b02
8b01:    00                     HALT

L_8b02:
8b02:    2b                     not AL, #0
8b03:    14 01                  bz L_8b06
8b05:    00                     HALT

L_8b06:
8b06:    80 aa                  ld AL, 0xaa
8b08:    43 31                  or AL, BL
8b0a:    11 01                  bnc L_8b0d
8b0c:    00                     HALT

L_8b0d:
8b0d:    13 01                  bnn L_8b10
8b0f:    00                     HALT

L_8b10:
8b10:    2b                     not AL, #0
8b11:    14 01                  bz L_8b14
8b13:    00                     HALT

L_8b14:
8b14:    80 55                  ld AL, 0x55
8b16:    02                     sf
8b17:    06                     sl
8b18:    44 31                  xor AL, BL
8b1a:    10 01                  bc L_8b1d
8b1c:    00                     HALT

L_8b1d:
8b1d:    12 01                  bn L_8b20
8b1f:    00                     HALT

L_8b20:
8b20:    14 01                  bz L_8b23
8b22:    00                     HALT

L_8b23:
8b23:    90 55 55               ld A, 0x5555
8b26:    d0 55 55               ld B, 0x5555
8b29:    51 02                  sub B, A
8b2b:    14 01                  bz L_8b2e
8b2d:    00                     HALT

L_8b2e:
8b2e:    10 01                  bc L_8b31
8b30:    00                     HALT

L_8b31:
8b31:    13 01                  bnn L_8b34
8b33:    00                     HALT

L_8b34:
8b34:    d0 aa aa               ld B, 0xaaaa
8b37:    50 20                  add A, B
8b39:    11 01                  bnc L_8b3c
8b3b:    00                     HALT

L_8b3c:
8b3c:    13 01                  bnn L_8b3f
8b3e:    00                     HALT

L_8b3f:
8b3f:    16 01                  blt L_8b42
8b41:    00                     HALT

L_8b42:
8b42:    3b                     not A, #0
8b43:    14 01                  bz L_8b46
8b45:    00                     HALT

L_8b46:
8b46:    90 55 55               ld A, 0x5555
8b49:    53 20                  or A, B
8b4b:    11 01                  bnc L_8b4e
8b4d:    00                     HALT

L_8b4e:
8b4e:    13 01                  bnn L_8b51
8b50:    00                     HALT

L_8b51:
8b51:    3b                     not A, #0
8b52:    14 01                  bz L_8b55
8b54:    00                     HALT

L_8b55:
8b55:    90 aa aa               ld A, 0xaaaa
8b58:    06                     sl
8b59:    02                     sf
8b5a:    54 20                  xor A, B
8b5c:    10 01                  bc L_8b5f
8b5e:    00                     HALT

L_8b5f:
8b5f:    12 01                  bn L_8b62
8b61:    00                     HALT

L_8b62:
8b62:    14 01                  bz L_8b65
8b64:    00                     HALT

L_8b65:
8b65:    90 aa 55               ld A, 0xaa55
8b68:    55 02                  mov B, A
8b6a:    55 04                  mov X, A
8b6c:    55 06                  mov Y, A
8b6e:    55 08                  mov Z, A
8b70:    55 8a                  mov S, Z
8b72:    55 8c                  mov C, Z
8b74:    55 80                  mov A, Z
8b76:    50 20                  add A, B
8b78:    50 40                  add A, X
8b7a:    50 60                  add A, Y
8b7c:    51 08                  sub Z, A
8b7e:    51 8a                  sub S, Z
8b80:    51 ac                  sub C, S
8b82:    51 c2                  sub B, C
8b84:    14 01                  bz L_8b87
8b86:    00                     HALT

L_8b87:
8b87:    d0 55 aa               ld B, 0x55aa
8b8a:    44 67                  xor YL, YH
8b8c:    44 76                  xor YH, YL
8b8e:    44 67                  xor YL, YH
8b90:    54 62                  xor B, Y
8b92:    14 01                  bz L_8b95
8b94:    00                     HALT

L_8b95:
8b95:    45 69                  mov ZL, YH
8b97:    45 78                  mov ZH, YL
8b99:    44 c8                  xor ZH, CH
8b9b:    44 d9                  xor ZL, CL
8b9d:    55 88                  mov Z, Z
8b9f:    14 01                  bz L_8ba2
8ba1:    00                     HALT

L_8ba2:
8ba2:    90 80 00               ld A, 0x8000
8ba5:    d0 00 01               ld B, 0x0001
8ba8:    59                     sub B, A
8ba9:    12 01                  bn L_8bac
8bab:    00                     HALT

L_8bac:
8bac:    10 01                  bc L_8baf
8bae:    00                     HALT

L_8baf:
8baf:    18 01                  bgt L_8bb2
8bb1:    00                     HALT

L_8bb2:
8bb2:    03                     rf
8bb3:    06                     sl
8bb4:    58                     add B, A
8bb5:    13 01                  bnn L_8bb8
8bb7:    00                     HALT

L_8bb8:
8bb8:    11 01                  bnc L_8bbb
8bba:    00                     HALT

L_8bbb:
8bbb:    33 20                  not B, #0
8bbd:    14 01                  bz L_8bc0
8bbf:    00                     HALT

L_8bc0:
8bc0:    90 aa aa               ld A, 0xaaaa
8bc3:    d0 55 55               ld B, 0x5555
8bc6:    5e                     mov Z, A
8bc7:    5b                     mov X, A
8bc8:    5a                     and B, A
8bc9:    14 01                  bz L_8bcc
8bcb:    00                     HALT

L_8bcc:
8bcc:    5a                     and B, A
8bcd:    14 01                  bz L_8bd0
8bcf:    00                     HALT

L_8bd0:
8bd0:    55 82                  mov B, Z
8bd2:    55 40                  mov A, X
8bd4:    5a                     and B, A
8bd5:    51 40                  sub A, X
8bd7:    14 01                  bz L_8bda
8bd9:    00                     HALT

L_8bda:
8bda:    91 bf fc               ld A, [0xbffc]
8bdd:    5e                     mov Z, A
8bde:    91 00 26               ld A, [0x0026]
8be1:    14 01                  bz L_8be4
8be3:    00                     HALT

L_8be4:
8be4:    d1 00 24               ld B, [0x0024]
8be7:    16 01                  blt L_8bea
8be9:    00                     HALT

L_8bea:
8bea:    61 00 22               ld X, [0x0022]
8bed:    18 01                  bgt L_8bf0
8bef:    00                     HALT

L_8bf0:
8bf0:    b1 00 2c               st A, [0x002c]
8bf3:    14 01                  bz L_8bf6
8bf5:    00                     HALT

L_8bf6:
8bf6:    91 00 2c               ld A, [0x002c]
8bf9:    f1 00 2c               st B, [0x002c]
8bfc:    16 01                  blt L_8bff
8bfe:    00                     HALT

L_8bff:
8bff:    d1 00 2c               ld B, [0x002c]
8c02:    69 00 2c               st X, [0x002c]
8c05:    18 01                  bgt L_8c08
8c07:    00                     HALT

L_8c08:
8c08:    61 00 2c               ld X, [0x002c]
8c0b:    54 42                  xor B, X
8c0d:    58                     add B, A
8c0e:    33 20                  not B, #0
8c10:    14 01                  bz L_8c13
8c12:    00                     HALT

L_8c13:
8c13:    91 bf fc               ld A, [0xbffc]
8c16:    5e                     mov Z, A
8c17:    91 00 10               ld A, [0x0010]
8c1a:    50 80                  add A, Z
8c1c:    b1 00 10               st A, [0x0010]
8c1f:    91 00 12               ld A, [0x0012]
8c22:    50 80                  add A, Z
8c24:    b1 00 12               st A, [0x0012]
8c27:    91 00 14               ld A, [0x0014]
8c2a:    50 80                  add A, Z
8c2c:    b1 00 14               st A, [0x0014]
8c2f:    91 00 16               ld A, [0x0016]
8c32:    50 80                  add A, Z
8c34:    b1 00 16               st A, [0x0016]
8c37:    91 00 18               ld A, [0x0018]
8c3a:    50 80                  add A, Z
8c3c:    b1 00 18               st A, [0x0018]
8c3f:    92 00 12               ld A, @[0x0012]
8c42:    18 01                  bgt L_8c45
8c44:    00                     HALT

L_8c45:
8c45:    d2 00 14               ld B, @[0x0014]
8c48:    16 01                  blt L_8c4b
8c4a:    00                     HALT

L_8c4b:
8c4b:    54 20                  xor A, B
8c4d:    3b                     not A, #0
8c4e:    14 01                  bz L_8c51
8c50:    00                     HALT

L_8c51:
8c51:    94 1c                  ld A, @[0x8c6f]
8c53:    18 01                  bgt L_8c56
8c55:    00                     HALT

L_8c56:
8c56:    d4 19                  ld B, @[0x8c71]
8c58:    16 01                  blt L_8c5b
8c5a:    00                     HALT

L_8c5b:
8c5b:    54 20                  xor A, B
8c5d:    3b                     not A, #0
8c5e:    14 01                  bz L_8c61
8c60:    00                     HALT

L_8c61:
8c61:    93 0c                  ld A, [0x8c6f]
8c63:    d3 0c                  ld B, [0x8c71]
8c65:    58                     add B, A
8c66:    90 ff ba               ld A, 0xffba
8c69:    58                     add B, A
8c6a:    14 01                  bz L_8c6d
8c6c:    00                     HALT

L_8c6d:
8c6d:    73 04                  jmp L_8c73
8c6f:    00
8c70:    22
8c71:    00
8c72:    24

L_8c73:
8c73:    60 00 20               ld X, 0x0020
8c76:    9a                     ld A, [X]
8c77:    d0 ff ff               ld B, 0xffff
8c7a:    59                     sub B, A
8c7b:    14 01                  bz L_8c7e
8c7d:    00                     HALT

L_8c7e:
8c7e:    95 41                  ld A, [X++]
8c80:    3b                     not A, #0
8c81:    14 01                  bz L_8c84
8c83:    00                     HALT

L_8c84:
8c84:    95 41                  ld A, [X++]
8c86:    d5 41                  ld B, [X++]
8c88:    54 20                  xor A, B
8c8a:    3b                     not A, #0
8c8b:    14 01                  bz L_8c8e
8c8d:    00                     HALT

L_8c8e:
8c8e:    9a                     ld A, [X]
8c8f:    14 01                  bz L_8c92
8c91:    00                     HALT

L_8c92:
8c92:    95 42                  ld A, [--X]
8c94:    d5 42                  ld B, [--X]
8c96:    54 20                  xor A, B
8c98:    3b                     not A, #0
8c99:    14 01                  bz L_8c9c
8c9b:    00                     HALT

L_8c9c:
8c9c:    d0 00 24               ld B, 0x0024
8c9f:    9a                     ld A, [X]
8ca0:    65 28 fe               ld X, [B + -0x2]
8ca3:    54 40                  xor A, X
8ca5:    14 01                  bz L_8ca8
8ca7:    00                     HALT

L_8ca8:
8ca8:    95 28 fc               ld A, [B + -0x4]
8cab:    65 29 02               ld X, [B++ + 0x02]
8cae:    50 40                  add A, X
8cb0:    3b                     not A, #0
8cb1:    14 01                  bz L_8cb4
8cb3:    00                     HALT

L_8cb4:
8cb4:    99                     ld A, [B]
8cb5:    65 2a fc               ld X, [--B + -0x4]
8cb8:    54 40                  xor A, X
8cba:    3b                     not A, #0
8cbb:    14 01                  bz L_8cbe
8cbd:    00                     HALT

L_8cbe:
8cbe:    60 00 10               ld X, 0x0010
8cc1:    95 44                  ld A, @[X]
8cc3:    d0 ff ff               ld B, 0xffff
8cc6:    59                     sub B, A
8cc7:    14 01                  bz L_8cca
8cc9:    00                     HALT

L_8cca:
8cca:    95 45                  ld A, @[X++]
8ccc:    3b                     not A, #0
8ccd:    14 01                  bz L_8cd0
8ccf:    00                     HALT

L_8cd0:
8cd0:    95 45                  ld A, @[X++]
8cd2:    d5 45                  ld B, @[X++]
8cd4:    54 20                  xor A, B
8cd6:    3b                     not A, #0
8cd7:    14 01                  bz L_8cda
8cd9:    00                     HALT

L_8cda:
8cda:    95 46                  ld A, @[--X]
8cdc:    d5 46                  ld B, @[--X]
8cde:    54 20                  xor A, B
8ce0:    3b                     not A, #0
8ce1:    14 01                  bz L_8ce4
8ce3:    00                     HALT

L_8ce4:
8ce4:    60 00 14               ld X, 0x0014
8ce7:    95 44                  ld A, @[X]
8ce9:    d5 4c fe               ld B, @[X + -0x2]
8cec:    54 20                  xor A, B
8cee:    3b                     not A, #0
8cef:    14 01                  bz L_8cf2
8cf1:    00                     HALT

L_8cf2:
8cf2:    95 4c fc               ld A, @[X + -0x4]
8cf5:    d5 4d 02               ld B, @[X++ + 0x02]
8cf8:    50 20                  add A, B
8cfa:    3b                     not A, #0
8cfb:    14 01                  bz L_8cfe
8cfd:    00                     HALT

L_8cfe:
8cfe:    95 44                  ld A, @[X]
8d00:    d5 4e fc               ld B, @[--X + -0x4]
8d03:    54 20                  xor A, B
8d05:    3b                     not A, #0
8d06:    14 01                  bz L_8d09
8d08:    00                     HALT

L_8d09:
8d09:    0d                     mov_pc X
8d0a:    90 05 0a               ld A, 0x050a
8d0d:    50 80                  add A, Z
8d0f:    51 04                  sub X, A
8d11:    14 01                  bz L_8d14
8d13:    00                     HALT

L_8d14:
8d14:    90 00 3a               ld A, 0x003a
8d17:    5f                     mov S, A
8d18:    60 20 20               ld X, 0x2020
8d1b:    7b 06                  call L_8d23
8d1d:    01                     nop
8d1e:    01                     nop
8d1f:    00                     HALT
8d20:    73 16                  jmp L_8d38
8d22:    00

L_8d23:
8d23:    95 41                  ld A, [X++]
8d25:    d0 01 01               ld B, 0x0101
8d28:    54 20                  xor A, B
8d2a:    14 01                  bz L_8d2d
8d2c:    00                     HALT

L_8d2d:
8d2d:    9d                     ld A, [S]
8d2e:    d0 20 20               ld B, 0x2020
8d31:    54 20                  xor A, B
8d33:    14 01                  bz L_8d36
8d35:    00                     HALT

L_8d36:
8d36:    3e                     inc X
8d37:    09                     ret

L_8d38:
8d38:    60 09 ef               ld X, 0x09ef
8d3b:    90 11 ff               ld A, 0x11ff
8d3e:    b5 41                  st A, [X++]
8d40:    55 42                  mov B, X
8d42:    90 09 f1               ld A, 0x09f1
8d45:    59                     sub B, A
8d46:    14 01                  bz L_8d49
8d48:    00                     HALT

L_8d49:
8d49:    60 09 ef               ld X, 0x09ef
8d4c:    95 41                  ld A, [X++]
8d4e:    d0 11 ff               ld B, 0x11ff
8d51:    41 02                  sub BH, AH
8d53:    14 01                  bz L_8d56
8d55:    00                     HALT

L_8d56:
8d56:    49                     sub BL, AL
8d57:    14 01                  bz L_8d5a
8d59:    00                     HALT

L_8d5a:
8d5a:    90 60 66               ld A, 0x6066
8d5d:    2f 00                  ld_dma_addr A
8d5f:    2f 21                  st_dma_addr B
8d61:    59                     sub B, A
8d62:    14 01                  bz L_8d65
8d64:    00                     HALT

L_8d65:
8d65:    90 46 11               ld A, 0x4611
8d68:    2f 02                  ld_dma_count A
8d6a:    2f 23                  st_dma_count B
8d6c:    59                     sub B, A
8d6d:    14 01                  bz L_8d70
8d6f:    00                     HALT

L_8d70:
8d70:    81 f2 00               ld AL, [0xf200]
8d73:    2c                     srl AL, #1
8d74:    11 18                  bnc L_8d8e
8d76:    81 f2 01               ld AL, [0xf201]
8d79:    c0 80                  ld BL, 0x80
8d7b:    43 31                  or AL, BL
8d7d:    c0 83                  ld BL, 0x83
8d7f:    49                     sub BL, AL
8d80:    15 0c                  bnz L_8d8e
8d82:    61 bf fe               ld X, [0xbffe]
8d85:    91 bf fc               ld A, [0xbffc]
8d88:    d0 07 74               ld B, 0x0774
8d8b:    58                     add B, A
8d8c:    75 20                  jmp [B]

L_8d8e:
8d8e:    a1 f1 0a               st AL, [0xf10a]
8d91:    90 bf fc               ld A, 0xbffc
8d94:    5f                     mov S, A
8d95:    95 a1                  ld A, [S++]
8d97:    5e                     mov Z, A
8d98:    65 a1                  ld X, [S++]
8d9a:    90 00 7d               ld A, 0x007d
8d9d:    50 80                  add A, Z
8d9f:    75 00                  jmp [A]

InstructionTestInitialRegisterState:
8da1:    05 b1                  (0x5b1)
8da3:    05 b3                  (0x5b3)
8da5:    05 b5                  (0x5b5)
8da7:    05 b7                  (0x5b7)
8da9:    05 b9                  (0x5b9)
8dab:    00 00                  (0x0)
8dad:    00 00                  (0x0)
8daf:    00 00                  (0x0)
8db1:    ff ff                  (0xffff)
8db3:    55 55                  (0x5555)
8db5:    aa aa                  (0xaaaa)
8db7:    00 00                  (0x0)
8db9:    80 01                  (0x8001)

Entry_CPU6_MAPPING_RAM_TEST:
8dbb:    90 07 cc               ld A, 0x07cc
8dbe:    50 80                  add A, Z
8dc0:    7d 00                  call [A]
8dc2:    "\x1b\x1c\x0cCPU-6 MAPPING RAM TEST, CONTROL-C TO EXIT\r\n\0"
8df1:    22 32                  clr BL, #2	 ; 0 for CPU5, non-zero for CPU6
8df3:    15 3a                  bnz MappingRamTestLoop
8df5:    90 07 cc               ld A, 0x07cc
8df8:    50 80                  add A, Z
8dfa:    7d 00                  call [A]
8dfc:    "\r\n*** THIS TEST WILL NOT RUN ON CPU-5 ***\r\n\0"
8e28:    90 07 8a               ld A, 0x078a
8e2b:    50 80                  add A, Z
8e2d:    75 00                  jmp [A]	 ; Press Space to Exit

MappingRamTestLoop:
8e2f:    90 06 d9               ld A, 0x06d9
8e32:    50 80                  add A, Z
8e34:    7d 00                  call [A]	 ; Call MappingInit
8e36:    47 40 ff 01 00 02 00   memcpy 0x100, [0x0100], [0x0200]
8e3d:    7b 36                  call L_8e75
8e3f:    01                     nop
8e40:    7b 33                  call L_8e75
8e42:    02                     sf
8e43:    7b 30                  call L_8e75
8e45:    03                     rf
8e46:    7b 2d                  call L_8e75
8e48:    04                     ei
8e49:    7b 2a                  call L_8e75
8e4b:    05                     di
8e4c:    7b 27                  call L_8e75
8e4e:    06                     sl
8e4f:    7b 24                  call L_8e75
8e51:    07                     rl
8e52:    7b 53                  call L_8ea7
8e54:    7b 1f                  call L_8e75
8e56:    00                     HALT
8e57:    7b 73                  call L_8ecc
8e59:    a1 f1 0a               st AL, [0xf10a]
8e5c:    81 f2 00               ld AL, [0xf200]
8e5f:    2c                     srl AL, #1
8e60:    11 cd                  bnc MappingRamTestLoop

ReturnAddress:
8e62:    81 f2 01               ld AL, [0xf201]
8e65:    c0 80                  ld BL, 0x80
8e67:    43 31                  or AL, BL
8e69:    c0 83                  ld BL, 0x83
8e6b:    49                     sub BL, AL
8e6c:    15 c1                  bnz MappingRamTestLoop
8e6e:    90 07 74               ld A, 0x0774
8e71:    50 80                  add A, Z
8e73:    75 00                  jmp [A]

L_8e75:
8e75:    3a                     clr A, #0
8e76:    85 41                  ld AL, [X++]
8e78:    35 04                  sll A, #5
8e7a:    20 00                  inc AH, #1
8e7c:    7e 45                  push {X, Y, Z}
8e7e:    5c                     mov Y, A
8e7f:    5e                     mov Z, A
8e80:    20 80                  inc ZH, #1
8e82:    60 00 20               ld X, 0x0020

nextMemoryLcation:
8e85:    d0 01 00               ld B, 0x0100

nextByteValue:
8e88:    8b                     ld AL, [Y]	 ; EF = 0x120 or 0x140 etc
8e89:    28                     inc AL, #1
8e8a:    ab                     st AL, [Y]
8e8b:    ac                     st AL, [Z]	 ; HL is EF+0x100
8e8c:    7b 76                  call ReadAllPages
8e8e:    7b 49                  call WriteAllPages
8e90:    47 80 ff 01 00 02 00   memcmp 0x100, [0x0100], [0x0200]
8e97:    15 69                  bnz L_8f02	 ; Branch if parity Error
8e99:    31 20                  dec B, #1	 ; Test every single byte pattern
8e9b:    15 eb                  bnz nextByteValue
8e9d:    30 60                  inc Y, #1
8e9f:    30 80                  inc Z, #1
8ea1:    3f                     dec X
8ea2:    15 e1                  bnz nextMemoryLcation
8ea4:    7f 45                  pop {X, Y, Z}
8ea6:    09                     ret

L_8ea7:
8ea7:    2e 1c f8 03 00         rpf 0xf8, [0x0300]
8eac:    2e 0c f9 03 00         wpf 0xf9, [0x0300]
8eb1:    80 01                  ld AL, 0x01

L_8eb3:
8eb3:    a5 a2                  st AL, [--S]
8eb5:    2a                     clr AL, #0
8eb6:    a5 a2                  st AL, [--S]
8eb8:    6d a2                  st X, [--S]
8eba:    a5 a2                  st AL, [--S]
8ebc:    60 06 c2               ld X, 0x06c2
8ebf:    50 84                  add X, Z
8ec1:    0f                     rsys

rsysContinue:
8ec2:    7b 15                  call WriteAllPages
8ec4:    47 40 ff 01 00 02 00   memcpy 0x100, [0x0100], [0x0200]
8ecb:    09                     ret

L_8ecc:
8ecc:    2e 1c f9 03 00         rpf 0xf9, [0x0300]
8ed1:    2e 0c f8 03 00         wpf 0xf8, [0x0300]
8ed6:    2a                     clr AL, #0
8ed7:    73 da                  jmp L_8eb3

WriteAllPages:
8ed9:    2e 1c f8 01 00         rpf 0xf8, [0x0100]
8ede:    2e 1c f9 01 20         rpf 0xf9, [0x0120]
8ee3:    2e 1c fa 01 40         rpf 0xfa, [0x0140]
8ee8:    2e 1c fb 01 60         rpf 0xfb, [0x0160]
8eed:    2e 1c fc 01 80         rpf 0xfc, [0x0180]
8ef2:    2e 1c fd 01 a0         rpf 0xfd, [0x01a0]
8ef7:    2e 1c fe 01 c0         rpf 0xfe, [0x01c0]
8efc:    2e 1c ff 01 e0         rpf 0xff, [0x01e0]
8f01:    09                     ret

L_8f02:
8f02:    73 29                  jmp L_8f2d

ReadAllPages:
8f04:    2e 0c f8 01 00         wpf 0xf8, [0x0100]
8f09:    2e 0c f9 01 20         wpf 0xf9, [0x0120]
8f0e:    2e 0c fa 01 40         wpf 0xfa, [0x0140]
8f13:    2e 0c fb 01 60         wpf 0xfb, [0x0160]
8f18:    2e 0c fc 01 80         wpf 0xfc, [0x0180]
8f1d:    2e 0c fd 01 a0         wpf 0xfd, [0x01a0]
8f22:    2e 0c fe 01 c0         wpf 0xfe, [0x01c0]
8f27:    2e 0c ff 01 e0         wpf 0xff, [0x01e0]
8f2c:    09                     ret

L_8f2d:
8f2d:    7f 45                  pop {X, Y, Z}
8f2f:    65 a1                  ld X, [S++]
8f31:    90 07 cc               ld A, 0x07cc
8f34:    50 80                  add A, Z
8f36:    7d 00                  call [A]
8f38:    "\r\n*** MAP RAM ERROR ***\r\n\0"
8f52:    a1 f1 0b               st AL, [0xf10b]
8f55:    a1 f1 0c               st AL, [0xf10c]
8f58:    90 07 8a               ld A, 0x078a
8f5b:    50 80                  add A, Z
8f5d:    75 00                  jmp [A]

Entry_ROM_SELF_TEST:
8f5f:    55 86                  mov Y, Z
8f61:    3a                     clr A, #0

ChecksumLoop:
8f62:    85 61                  ld AL, [Y++]	 ; Load Byte via base+index, post-increment index
8f64:    40 10                  add AH, AL
8f66:    d0 07 dd               ld B, 0x07dd
8f69:    50 82                  add B, Z
8f6b:    51 62                  sub B, Y
8f6d:    15 f3                  bnz ChecksumLoop
8f6f:    8b                     ld AL, [Y]	 ; Load Byte via base+index
8f70:    41 01                  sub AL, AH
8f72:    15 32                  bnz ChecksumFail

PrintPassedAndExit:
8f74:    7b 56                  call WriteString
8f76:    "\r\n*** PASS ***\r\n\0"
8f87:    a1 f1 0a               st AL, [0xf10a]

L_8f8a:
8f8a:    7b 40                  call WriteString
8f8c:    "PRESS SPACE\x07\r\n\0"

WaitForKey:
8f9b:    81 f2 00               ld AL, [0xf200]
8f9e:    2c                     srl AL, #1
8f9f:    11 fa                  bnc WaitForKey
8fa1:    81 f2 01               ld AL, [0xf201]
8fa4:    75 40                  jmp [X]

ChecksumFail:
8fa6:    7b 24                  call WriteString
8fa8:    "\r\n*** CHECK SUM ERROR ***\r\n\0"
8fc4:    a1 f1 0b               st AL, [0xf10b]
8fc7:    a1 f1 0c               st AL, [0xf10c]
8fca:    73 be                  jmp L_8f8a

WriteString:
8fcc:    81 f2 00               ld AL, [0xf200]
8fcf:    2c                     srl AL, #1
8fd0:    2c                     srl AL, #1
8fd1:    11 f9                  bnc WriteString
8fd3:    85 41                  ld AL, [X++]
8fd5:    15 01                  bnz L_8fd8
8fd7:    09                     ret

L_8fd8:
8fd8:    a1 f2 01               st AL, [0xf201]
8fdb:    73 ef                  jmp WriteString
8fdd:    82
8fde:    <null bytes>

