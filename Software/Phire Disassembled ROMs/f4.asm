
Init:
0100:    <null bytes>


ReadChar:
0102:    <null bytes>


FinishTest:
0104:    <null bytes>


PrintCtrlCToExit:
0106:    <null bytes>


WriteHex:
010a:    <null bytes>


WaitNotFIn:
010c:    <null bytes>


PressSpaceThenExit:
010e:    <null bytes>


WriteHex16:
0110:    <null bytes>


WriteString:
0112:    <null bytes>


WaitForReady:
0118:    <null bytes>


TEST_0:
    ; This is a header for this ROM.
    ; It looks like these ROMs are pluggable. There's nothing that refers to this table
    ; in this ROM, so i have a suggestion that there's a "master" rom which scans all the
    ; slots where an "auxiliary test" rom is present; and composes list of tests (applications,
    ; if you want) in runtime.
    ; This leads to a suggestions that a new tests (or, let's call them applets) can be added
    ; to the Diag card by simply adding a ROM with a table like this in the beginning.
    ; The "master ROM" is expected to see them and add to the list.
9800:    02 ce                  (0x2ce)	 ; Entry_01133_CMD_AUX_MEMORY_TEST - 0x9800
9802:    "01133 CMD AUX MEMORY TEST\r\n\0"

TEST_1:
981e:    03 d9                  (0x3d9)	 ; Entry_01133_CMD_SEEK_TEST - 0x9800
9820:    "01133 CMD SEEK TEST\r\n\0"

TEST_2:
9836:    04 9d                  (0x49d)	 ; Entry_01133_CMD_READ_TEST - 0x9800
9838:    "01133 CMD READ TEST\r\n\0"

TEST_3:
984e:    02 d9                  (0x2d9)	 ; Entry_FINCH_AUX_MEMORY_TEST - 0x9800
9850:    "FINCH AUX MEMORY TEST\r\n\0"

TEST_4:
9868:    05 3c                  (0x53c)	 ; Entry_FINCH_SEEK_TEST - 0x9800
986a:    "FINCH SEEK TEST\r\n\0"

TEST_5:
987c:    05 ff                  (0x5ff)	 ; Entry_FINCH_READ_TEST - 0x9800
987e:    "FINCH READ TEST\r\n\0"

TEST_6:
9890:    06 9e                  (0x69e)	 ; Entry_ROM_SELF_TEST - 0x9800
9892:    "ROM SELF TEST\r\n\n\0"

TEST_7:
98a3:    00 00                  (0x0)	 ; Terminator

WriteString:
98a5:    85 41                  ld AL, [X++]
98a7:    15 01                  bnz L_98aa
98a9:    09                     ret

L_98aa:
98aa:    7b 02                  call WriteChar
98ac:    73 f7                  jmp WriteString

WriteChar:
98ae:    c1 f2 00               ld BL, [0xf200]
98b1:    24 30                  srl BL, #1
98b3:    24 30                  srl BL, #1
98b5:    11 f7                  bnc WriteChar
98b7:    a1 f2 01               st AL, [0xf201]
98ba:    09                     ret

ReadChar:
98bb:    81 f2 00               ld AL, [0xf200]
98be:    2c                     srl AL, #1
98bf:    11 fa                  bnc ReadChar
98c1:    81 f2 01               ld AL, [0xf201]
98c4:    09                     ret

WriteHex16:
    ; Writes out a 16-bit value from A as hexadecimal
98c5:    a5 a2                  st AL, [--S]
98c7:    45 01                  mov AL, AH
98c9:    7b 05                  call WriteHex
98cb:    85 a1                  ld AL, [S++]
98cd:    7b 01                  call WriteHex
98cf:    09                     ret

WriteHex:
    ; Writes contents of AL to terminal as a hexadecimal number
98d0:    a5 a2                  st AL, [--S]
98d2:    c0 f0                  ld BL, 0xf0
98d4:    42 31                  and AL, BL
98d6:    07                     rl
98d7:    26 10                  rrc AL, #1
98d9:    2c                     srl AL, #1
98da:    2c                     srl AL, #1
98db:    2c                     srl AL, #1
98dc:    c0 b0                  ld BL, 0xb0
98de:    40 31                  add AL, BL
98e0:    c0 b9                  ld BL, 0xb9
98e2:    49                     sub BL, AL
98e3:    19 04                  ble L_98e9
98e5:    c0 07                  ld BL, 0x07
98e7:    40 31                  add AL, BL

L_98e9:
98e9:    7b c3                  call WriteChar
98eb:    85 a1                  ld AL, [S++]
98ed:    c0 0f                  ld BL, 0x0f
98ef:    42 31                  and AL, BL
98f1:    c0 b0                  ld BL, 0xb0
98f3:    40 31                  add AL, BL
98f5:    c0 b9                  ld BL, 0xb9
98f7:    49                     sub BL, AL
98f8:    19 04                  ble L_98fe
98fa:    c0 07                  ld BL, 0x07
98fc:    40 31                  add AL, BL

L_98fe:
98fe:    7b ae                  call WriteChar
9900:    09                     ret

FinishTest:
    ; This subroutine checks whether a Ctrl-C is pressed, and, if not,
    ; restarts the code from an offset, defined by two bytes, following the call
9901:    a1 f1 0a               st AL, [0xf10a]
9904:    81 f2 00               ld AL, [0xf200]	 ; Check if we have a character from the MUX0
9907:    2c                     srl AL, #1
9908:    11 57                  bnc L_9961
990a:    81 f2 01               ld AL, [0xf201]	 ; Read byte from the terminal
990d:    c0 80                  ld BL, 0x80	 ; The byte is expected to be 0x03 or 0x83
990f:    43 31                  or AL, BL
9911:    c0 83                  ld BL, 0x83
9913:    49                     sub BL, AL
9914:    15 4b                  bnz L_9961
9916:    81 01 08               ld AL, [0x0108]	 ; Exit status
9919:    14 32                  bz L_994d
991b:    7a 01 12               call @[WriteString|0x0112]
991e:    "\r\n*** FAIL ***\0"
992d:    a1 f1 0b               st AL, [0xf10b]	 ; Decimal 2 clear
9930:    a1 f1 0c               st AL, [0xf10c]	 ; Decimal 3 set

PressSpaceThenExit:
9933:    7a 01 12               call @[WriteString|0x0112]
9936:    "\r\nPRESS SPACE\x07\r\n\0"
9947:    7a 01 02               call @[ReadChar|0x0102]	 ; ReadChar
994a:    72 01 00               jmp @[Init|0x0100]	 ; Go to return address

L_994d:
    ; Exit status is 0
994d:    7a 01 12               call @[WriteString|0x0112]
9950:    "\r\n*** PASS ***\0"
995f:    73 d2                  jmp PressSpaceThenExit

L_9961:
    ; No Ctrl-C pressed, resume
9961:    90 c0 00               ld A, 0xc000
9964:    5f                     mov S, A	 ; Reset the stack, place it above the Diag board window
9965:    91 01 1a               ld A, [0x011a]	 ; ROMBase
9968:    5e                     mov Z, A
9969:    95 41                  ld A, [X++]
996b:    50 80                  add A, Z
996d:    75 00                  jmp [A]	 ; Jump to restart point

PrintCtrlCToExit:
996f:    7a 01 12               call @[WriteString|0x0112]
9972:    "\r\n(CONTROL-C TO EXIT)\r\n\0"
998a:    09                     ret

Init:
    ; Every test begins with a call to this routine. All reusable functions are called
    ; indirectly via address table, built in RAM by this function. Also interesting
    ; to note that this address table and its slots are the same between all auxiliary
    ; test ROMs. We can think of it as of a mini-BIOS, or "kernal". Since the structure
    ; of this table appears the same in all auxiliary ROMs, this suggests that this "BIOS"
    ; portion is copypasted from somewhere else. So, we may have more software components,
    ; like bootloaders, WIPL, etc, sharing the same (or similar) function table.
    ; 
    ; Entry parameters:
    ; EX = 0x9800 - base address of this ROM
    ; RT = a pointer to a table of two 16-bit words:
    ; table + 0 - address of a HW controller
    ; table + 2 - address of a test code to execute
998b:    3a                     clr A, #0
998c:    b1 01 08               st A, [0x0108]	 ; Initialize exit status to 0
998f:    90 01 ee               ld A, 0x01ee
9992:    50 80                  add A, Z	 ; WaitForReady
9994:    b1 01 18               st A, [WaitForReady|0x0118]
9997:    90 00 d0               ld A, 0x00d0
999a:    50 80                  add A, Z	 ; WriteHex
999c:    b1 01 0a               st A, [WriteHex|0x010a]
999f:    90 02 91               ld A, 0x0291
99a2:    50 80                  add A, Z	 ; WaitNotFIn
99a4:    b1 01 0c               st A, [WaitNotFIn|0x010c]
99a7:    90 01 6f               ld A, 0x016f
99aa:    50 80                  add A, Z	 ; PrintCtrlCToExit
99ac:    b1 01 06               st A, [PrintCtrlCToExit|0x0106]
99af:    90 00 bb               ld A, 0x00bb
99b2:    50 80                  add A, Z	 ; ReadChar
99b4:    b1 01 02               st A, [ReadChar|0x0102]
99b7:    90 00 a5               ld A, 0x00a5
99ba:    50 80                  add A, Z	 ; WriteString
99bc:    b1 01 12               st A, [WriteString|0x0112]
99bf:    90 00 c5               ld A, 0x00c5
99c2:    50 80                  add A, Z	 ; WriteHex16
99c4:    b1 01 10               st A, [WriteHex16|0x0110]
99c7:    90 01 01               ld A, 0x0101
99ca:    50 80                  add A, Z	 ; FinishTest
99cc:    b1 01 04               st A, [FinishTest|0x0104]
99cf:    90 01 33               ld A, 0x0133
99d2:    50 80                  add A, Z	 ; PressSpaceThenExit
99d4:    b1 01 0e               st A, [PressSpaceThenExit|0x010e]
99d7:    55 80                  mov A, Z
99d9:    b1 01 1a               st A, [0x011a]	 ; ROMBase
99dc:    95 41                  ld A, [X++]	 ; AX = controller base address ?
99de:    b1 01 14               st A, [0x0114]
99e1:    38                     inc A, #1
99e2:    b1 01 16               st A, [0x0116]
99e5:    55 40                  mov A, X
99e7:    65 a1                  ld X, [S++]	 ; RT = return address (pop)
99e9:    69 01 00               st X, [Init|0x0100]
99ec:    75 00                  jmp [A]	 ; Jump back to our caller

WaitForReady:
    ; This routine waits for the completion of the command by the controller
    ; and reads the result code.
    ; Any error here is considered critical, test execution aborts immediately
    ; Wait for the last command byte to be consumed
99ee:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
                                                         	 ; Now wait for BUSY to clear
99f1:    6d a2                  st X, [--S]
99f3:    60 03 e8               ld X, 0x03e8	 ; Timeout for BUSY

L_99f6:
99f6:    82 01 16               ld AL, @[0x0116]	 ; STATUS_REG
99f9:    c0 08                  ld BL, 0x08
99fb:    4a                     and BL, AL	 ; BUSY = STATUS_REG & 0x08
99fc:    14 2b                  bz L_9a29
99fe:    0e                     dly
99ff:    3f                     dec X
9a00:    15 f4                  bnz L_99f6
9a02:    7a 01 12               call @[WriteString|0x0112]
9a05:    "*** BUSY DID NOT CLEAR ***\0"
9a20:    a1 f1 0b               st AL, [0xf10b]	 ; Decimal 2 clear
9a23:    a1 f1 0c               st AL, [0xf10c]	 ; Decimal 3 set
9a26:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9a29:
    ; BUSY == 0
9a29:    60 03 e8               ld X, 0x03e8

L_9a2c:
    ; Now check that FOUT is set
    ; Presumably it signals availability of the result code
9a2c:    2c                     srl AL, #1	 ; FOUT = STATUS_REG & 0x01
9a2d:    10 2b                  bc L_9a5a
9a2f:    0e                     dly
9a30:    3f                     dec X
9a31:    15 f9                  bnz L_9a2c	 ; This looks like a bug. We're re-testing AL by shifting
                                          	 ; it right, but we don't actually re-read it from the controller.
9a33:    7a 01 12               call @[WriteString|0x0112]
9a36:    "*** FOUT NEVER CAME ON ***\0"
9a51:    a1 f1 0b               st AL, [0xf10b]
9a54:    a1 f1 0c               st AL, [0xf10c]
9a57:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9a5a:
9a5a:    03                     rf
9a5b:    82 01 14               ld AL, @[0x0114]	 ; COMMAND_REG - result code
9a5e:    15 03                  bnz L_9a63
9a60:    65 a1                  ld X, [S++]
9a62:    09                     ret

L_9a63:
    ; This will report an error code from the FFC, but continue test execution
    ; It looks like "operation completed, but with an error"
9a63:    a5 a2                  st AL, [--S]
9a65:    7a 01 12               call @[WriteString|0x0112]
9a68:    "*** \0"
9a6d:    85 a1                  ld AL, [S++]
9a6f:    7a 01 0a               call @[WriteHex|0x010a]	 ; WriteHex
9a72:    7a 01 12               call @[WriteString|0x0112]
9a75:    " ERROR ***\r\n\0"
9a82:    80 01                  ld AL, 0x01
9a84:    a1 01 08               st AL, [0x0108]	 ; exit status = 1
9a87:    a1 f1 0b               st AL, [0xf10b]
9a8a:    a1 f1 0c               st AL, [0xf10c]
9a8d:    65 a1                  ld X, [S++]
9a8f:    02                     sf
9a90:    09                     ret

WaitNotFIn:
9a91:    6d a2                  st X, [--S]
9a93:    0e                     dly
9a94:    60 03 e8               ld X, 0x03e8

L_9a97:
9a97:    82 01 16               ld AL, @[0x0116]	 ; STATUS_REG
9a9a:    2c                     srl AL, #1
9a9b:    2c                     srl AL, #1	 ; FIN = STATUS_REG & 0x02
9a9c:    11 2d                  bnc L_9acb
9a9e:    0e                     dly
9a9f:    3f                     dec X
9aa0:    15 f5                  bnz L_9a97
9aa2:    7a 01 12               call @[WriteString|0x0112]
9aa5:    "*** FIN DID NOT GO OFF ***\r\n\0"
9ac2:    a1 f1 0b               st AL, [0xf10b]
9ac5:    a1 f1 0c               st AL, [0xf10c]
9ac8:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9acb:
9acb:    65 a1                  ld X, [S++]
9acd:    09                     ret

Entry_01133_CMD_AUX_MEMORY_TEST:
9ace:    90 01 8b               ld A, 0x018b
9ad1:    50 80                  add A, Z
9ad3:    7d 00                  call [A]	 ; Init
9ad5:    f8 08                  (0xf808)	 ; CMD registers base
                                        	 ; AUX_Mem_Test
9ad7:    73 09                  jmp L_9ae2

Entry_FINCH_AUX_MEMORY_TEST:
    ; This test checks 3840 bytes of FFC's on-board memory.
    ; I suggest that for some reason this is not all of the memory, because as
    ; we can see from read tests below, disks are read on a per-track basis,
    ; and each track is 6400 bytes long (16 sectors, 400 bytes per sector)
    ; Yes, the same code is used for CMD board, the only difference is controller
    ; base address: 0xf808 for CMD vs 0xf800 for FFC.
9ad9:    90 01 8b               ld A, 0x018b
9adc:    50 80                  add A, Z
9ade:    7d 00                  call [A]	 ; Init
9ae0:    f8 00                  (0xf800)	 ; Finch registers address

L_9ae2:
9ae2:    7a 01 06               call @[PrintCtrlCToExit|0x0106]

    ; PrintCtrlCToExit
    ; The test restarts from here
9ae5:    32 60                  clr Y, #0
9ae7:    60 0f 00               ld X, 0x0f00	 ; Test pattern length is 3840 bytes
9aea:    55 60                  mov A, Y
9aec:    d0 01 1c               ld B, 0x011c	 ; Start of our test patterm

L_9aef:
9aef:    a5 21                  st AL, [B++]	 ; Fill in the test pattern
9af1:    28                     inc AL, #1
9af2:    28                     inc AL, #1
9af3:    28                     inc AL, #1
9af4:    3f                     dec X
9af5:    15 f8                  bnz L_9aef
9af7:    90 f0 ff               ld A, 0xf0ff	 ; -3841, does the DMA count up to 0 ?
9afa:    2f 02                  ld_dma_count A
9afc:    90 01 1c               ld A, 0x011c
9aff:    2f 00                  ld_dma_addr A
9b01:    2f 34                  dma_mode #3
9b03:    2f 06                  enable_dma

    ; These are the only two commands, whose parameters are sent using the
    ; memory-mapped command register. All other operations (seek, read, etc)
    ; only use a single byte as command; request parameters are sent as a
    ; data packet over DMA.
    ; After writing each byte we need to wait for FIN status bit to go down.
    ; The bit indicates that the controller hasn't consumed the byte yet
9b05:    80 46                  ld AL, 0x46	 ; Write AUX ?
9b07:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b0a:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b0d:    80 01                  ld AL, 0x01
9b0f:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b12:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b15:    2a                     clr AL, #0
9b16:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b19:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b1c:    80 0f                  ld AL, 0x0f
9b1e:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b21:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b24:    2a                     clr AL, #0
9b25:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b28:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9b2b:    60 0f 00               ld X, 0x0f00	 ; Clear 3840 bytes...
9b2e:    3a                     clr A, #0
9b2f:    d0 01 1c               ld B, 0x011c	 ; Starting at 0x011c

L_9b32:
9b32:    a5 21                  st AL, [B++]
9b34:    3f                     dec X
9b35:    15 fb                  bnz L_9b32
9b37:    90 f0 ff               ld A, 0xf0ff
9b3a:    2f 02                  ld_dma_count A
9b3c:    90 01 1c               ld A, 0x011c
9b3f:    2f 00                  ld_dma_addr A
9b41:    2f 34                  dma_mode #3
9b43:    2f 06                  enable_dma
9b45:    80 47                  ld AL, 0x47	 ; Read AUX ?
9b47:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b4a:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b4d:    80 01                  ld AL, 0x01	 ; 0x0100 - could be memory start address (from FFC pov) ?
9b4f:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b52:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b55:    2a                     clr AL, #0
9b56:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b59:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b5c:    80 0f                  ld AL, 0x0f	 ; 0x0f00 - data size
9b5e:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b61:    7a 01 0c               call @[WaitNotFIn|0x010c]	 ; WaitNotFIn
9b64:    2a                     clr AL, #0
9b65:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9b68:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9b6b:    b5 a2                  st A, [--S]
9b6d:    60 0f 00               ld X, 0x0f00	 ; Compare 3840 bytes
9b70:    d0 01 1c               ld B, 0x011c	 ; Starting from 0x011c
9b73:    55 60                  mov A, Y	 ; AX = 0
9b75:    45 10                  mov AH, AL

L_9b77:
9b77:    85 21                  ld AL, [B++]
9b79:    bd                     st A, [S]
9b7a:    41 01                  sub AL, AH
9b7c:    15 12                  bnz L_9b90
9b7e:    20 00                  inc AH, #1
9b80:    20 00                  inc AH, #1
9b82:    20 00                  inc AH, #1
9b84:    3f                     dec X
9b85:    15 f0                  bnz L_9b77
9b87:    95 a1                  ld A, [S++]
9b89:    20 70                  inc YL, #1
9b8b:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9b8e:    02 e5                  (0x2e5)	 ; Restart point = 0x9ae5

L_9b90:
9b90:    a1 f1 0b               st AL, [0xf10b]
9b93:    a1 f1 0c               st AL, [0xf10c]
9b96:    f5 a2                  st B, [--S]
9b98:    7a 01 12               call @[WriteString|0x0112]
9b9b:    "*** ERROR, ADDR=\0"
9bac:    95 a1                  ld A, [S++]
9bae:    39                     dec A, #1
9baf:    7a 01 10               call @[WriteHex16|0x0110]	 ; WriteHex16
9bb2:    7a 01 12               call @[WriteString|0x0112]
9bb5:    " EXP=\0"
9bbb:    85 a1                  ld AL, [S++]
9bbd:    7a 01 0a               call @[WriteHex|0x010a]	 ; WriteHex
9bc0:    7a 01 12               call @[WriteString|0x0112]
9bc3:    " ACT=\0"
9bc9:    85 a1                  ld AL, [S++]
9bcb:    7a 01 0a               call @[WriteHex|0x010a]	 ; WriteHex
9bce:    7a 01 12               call @[WriteString|0x0112]
9bd1:    " ***\0"
9bd6:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

Entry_01133_CMD_SEEK_TEST:
    ; This test seeks back and forth to each track of the Phoenix drive
    ; It runs continuously until interrupted by Ctrl-C.
    ; An error in communication between the controller board and CPU is considered
    ; fatal. A remote error code, returned by the board as a result of operation,
    ; is logged in hexadecimal, but the test continues. After Ctrl-C the test reports
    ; "PASS" if no errors have been found or "FAILED" if there has been at least one
    ; error code reported by the FFC controller.
    ; The drive has total of 822 tracks.
9bd9:    90 01 8b               ld A, 0x018b
9bdc:    50 80                  add A, Z
9bde:    7d 00                  call [A]	 ; Init
9be0:    f8 08                  (0xf808)	 ; CMD_REGS_BASE
9be2:    7a 01 06               call @[PrintCtrlCToExit|0x0106]

    ; This is restart point
    ; All the code below differs from the aux memory test. The command
    ; is sent to the card via DMA; controller's command register does not
    ; provide any parameters.
9be5:    d0 41 4d               ld B, 0x414d
9be8:    90 81 00               ld A, 0x8100	 ; packet[0,1] = 0x8100 - perhaps unit #0, see Finch code
9beb:    b5 21                  st A, [B++]
9bed:    90 82 ff               ld A, 0x82ff	 ; packet[2,3] = 0x82FF
9bf0:    b9                     st A, [B]
9bf1:    90 ff fb               ld A, 0xfffb	 ; -5 = 4 bytes
9bf4:    2f 02                  ld_dma_count A
9bf6:    90 41 4d               ld A, 0x414d	 ; control packet base
9bf9:    2f 00                  ld_dma_addr A
9bfb:    2f 34                  dma_mode #3
9bfd:    2f 06                  enable_dma
9bff:    80 43                  ld AL, 0x43
9c01:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9c04:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9c07:    13 09                  bnn L_9c12

L_9c09:
    ; Error - drive is not ready
9c09:    a1 f1 0b               st AL, [0xf10b]
9c0c:    a1 f1 0c               st AL, [0xf10c]
9c0f:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9c12:
9c12:    80 45                  ld AL, 0x45
9c14:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9c17:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9c1a:    12 ed                  bn L_9c09

    ; packet[0,1] stays = 0x8100
9c1c:    d0 41 4f               ld B, 0x414f	 ; &packet[2]
9c1f:    90 84 00               ld A, 0x8400
9c22:    b5 21                  st A, [B++]	 ; packet[2,3] = 0x8400
9c24:    80 83                  ld AL, 0x83
9c26:    a5 21                  st AL, [B++]	 ; packet[4] = 0x83
9c28:    3a                     clr A, #0	 ; 0x0000
9c29:    b5 21                  st A, [B++]	 ; packet[5,6] = 0 - initial track number
9c2b:    39                     dec A, #1
9c2c:    a9                     st AL, [B]	 ; packet[7] = 0xFF
9c2d:    38                     inc A, #1
9c2e:    38                     inc A, #1	 ; 0x01
9c2f:    b1 41 b1               st A, [0x41b1]	 ; Tracks per step

L_9c32:
    ; This is the main loop
9c32:    90 41 4d               ld A, 0x414d	 ; control packet base
9c35:    2f 00                  ld_dma_addr A
9c37:    90 ff f7               ld A, 0xfff7	 ; -9 = 8 bytes
9c3a:    2f 02                  ld_dma_count A
9c3c:    2f 34                  dma_mode #3
9c3e:    2f 06                  enable_dma

    ; Seek operation consists of two commands
9c40:    80 43                  ld AL, 0x43
9c42:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9c45:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9c48:    12 bf                  bn L_9c09
9c4a:    80 45                  ld AL, 0x45
9c4c:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9c4f:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9c52:    13 1c                  bnn L_9c70
9c54:    7a 01 12               call @[WriteString|0x0112]
9c57:    "TRACK=\0"
9c5e:    91 41 52               ld A, [0x4152]	 ; packet[5] = Track number
9c61:    7a 01 10               call @[WriteHex16|0x0110]	 ; WriteHex16
9c64:    7a 01 12               call @[WriteString|0x0112]
9c67:    "\r\n\0"
9c6a:    a1 f1 0b               st AL, [0xf10b]
9c6d:    a1 f1 0c               st AL, [0xf10c]

L_9c70:
9c70:    91 41 b1               ld A, [0x41b1]	 ; tracks_per_step
9c73:    16 1a                  blt L_9c8f
9c75:    d1 41 52               ld B, [0x4152]	 ; Track += tracks_per_step
9c78:    50 20                  add A, B
9c7a:    b1 41 52               st A, [0x4152]
9c7d:    d0 03 36               ld B, 0x0336	 ; 822 tracks total
9c80:    59                     sub B, A
9c81:    15 af                  bnz L_9c32
9c83:    3a                     clr A, #0
9c84:    39                     dec A, #1
9c85:    b1 41 b1               st A, [0x41b1]	 ; tracks_per_step = -1
9c88:    80 10                  ld AL, 0x10
9c8a:    a1 41 50               st AL, [0x4150]
9c8d:    73 a3                  jmp L_9c32

L_9c8f:
9c8f:    91 41 52               ld A, [0x4152]	 ; Track -= 1
9c92:    39                     dec A, #1
9c93:    b1 41 52               st A, [0x4152]
9c96:    17 9a                  bp L_9c32
9c98:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9c9b:    03 e5                  (0x3e5)	 ; Restart point is 9be5

Entry_01133_CMD_READ_TEST:
9c9d:    90 01 8b               ld A, 0x018b
9ca0:    50 80                  add A, Z
9ca2:    7d 00                  call [A]	 ; Init
9ca4:    f8 08                  (0xf808)	 ; CMD_REGS_BASE
9ca6:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
9ca9:    90 41 4d               ld A, 0x414d
9cac:    5c                     mov Y, A
9cad:    90 81 00               ld A, 0x8100
9cb0:    b5 61                  st A, [Y++]
9cb2:    90 84 00               ld A, 0x8400
9cb5:    b5 61                  st A, [Y++]
9cb7:    80 83                  ld AL, 0x83
9cb9:    a5 61                  st AL, [Y++]
9cbb:    3a                     clr A, #0
9cbc:    b5 61                  st A, [Y++]
9cbe:    80 85                  ld AL, 0x85
9cc0:    a5 61                  st AL, [Y++]
9cc2:    d0 10 00               ld B, 0x1000	 ; 16 sectors

L_9cc5:
9cc5:    e5 61                  st BL, [Y++]
9cc7:    90 01 90               ld A, 0x0190	 ; Sector length 400 bytes
9cca:    b5 61                  st A, [Y++]
9ccc:    20 30                  inc BL, #1
9cce:    21 20                  dec BH, #1
9cd0:    15 f3                  bnz L_9cc5
9cd2:    80 ff                  ld AL, 0xff
9cd4:    ab                     st AL, [Y]

L_9cd5:
9cd5:    90 ff c3               ld A, 0xffc3
9cd8:    2f 02                  ld_dma_count A
9cda:    90 41 4d               ld A, 0x414d
9cdd:    2f 00                  ld_dma_addr A
9cdf:    2f 34                  dma_mode #3
9ce1:    2f 06                  enable_dma
9ce3:    80 43                  ld AL, 0x43
9ce5:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9ce8:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9ceb:    13 09                  bnn L_9cf6
9ced:    a1 f1 0b               st AL, [0xf10b]
9cf0:    a1 f1 0c               st AL, [0xf10c]
9cf3:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9cf6:
9cf6:    90 e6 ff               ld A, 0xe6ff
9cf9:    2f 02                  ld_dma_count A
9cfb:    90 01 1c               ld A, 0x011c
9cfe:    2f 00                  ld_dma_addr A
9d00:    2f 34                  dma_mode #3
9d02:    2f 06                  enable_dma
9d04:    80 45                  ld AL, 0x45
9d06:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9d09:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9d0c:    13 16                  bnn L_9d24
9d0e:    7a 01 12               call @[WriteString|0x0112]
9d11:    "TRACK=\0"
9d18:    91 41 52               ld A, [0x4152]
9d1b:    7a 01 10               call @[WriteHex16|0x0110]	 ; WriteHex16
9d1e:    7a 01 12               call @[WriteString|0x0112]
9d21:    "\r\n\0"

L_9d24:
9d24:    91 41 52               ld A, [0x4152]
9d27:    15 01                  bnz L_9d2a
9d29:    38                     inc A, #1

L_9d2a:
9d2a:    3d                     sll A, #1
9d2b:    b1 41 52               st A, [0x4152]
9d2e:    d0 03 36               ld B, 0x0336
9d31:    59                     sub B, A
9d32:    19 a1                  ble L_9cd5
9d34:    a1 f1 0a               st AL, [0xf10a]
9d37:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9d3a:    04 a9                  (0x4a9)

Entry_FINCH_SEEK_TEST:
    ; The same as CMD seek test, but uses Finch hard drive unit #2
    ; Seeks back and forth to each track until interrupted. The drive
    ; has 604 tracks.
9d3c:    90 01 8b               ld A, 0x018b
9d3f:    50 80                  add A, Z
9d41:    7d 00                  call [A]	 ; Init
9d43:    f8 00                  (0xf800)	 ; FFC_REGS_BASE
9d45:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
9d48:    d0 41 4d               ld B, 0x414d	 ; Data packet address
9d4b:    90 81 02               ld A, 0x8102
9d4e:    b5 21                  st A, [B++]	 ; packet[0, 1] = 0x8102 - this selects unit 2
9d50:    90 84 00               ld A, 0x8400
9d53:    b5 21                  st A, [B++]	 ; packet[2, 3] = 0x8400
9d55:    90 82 ff               ld A, 0x82ff
9d58:    b9                     st A, [B]	 ; packet[4, 5] = 0x82ff
9d59:    90 ff f9               ld A, 0xfff9	 ; -7 = 6 bytes
9d5c:    2f 02                  ld_dma_count A
9d5e:    90 41 4d               ld A, 0x414d
9d61:    2f 00                  ld_dma_addr A
9d63:    2f 34                  dma_mode #3
9d65:    2f 06                  enable_dma
9d67:    80 43                  ld AL, 0x43
9d69:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9d6c:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9d6f:    13 09                  bnn L_9d7a

L_9d71:
    ; Not ready
9d71:    a1 f1 0b               st AL, [0xf10b]
9d74:    a1 f1 0c               st AL, [0xf10c]
9d77:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9d7a:
9d7a:    80 45                  ld AL, 0x45
9d7c:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9d7f:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9d82:    12 ed                  bn L_9d71

    ; Prepare seek request
9d84:    d0 41 4f               ld B, 0x414f	 ; &packet[2]
9d87:    90 84 00               ld A, 0x8400
9d8a:    b5 21                  st A, [B++]	 ; packet[2,3] = 0x8400
9d8c:    80 83                  ld AL, 0x83
9d8e:    a5 21                  st AL, [B++]	 ; packet[4] = 0x83
9d90:    3a                     clr A, #0
9d91:    b5 21                  st A, [B++]	 ; packet[5,6] = 0 - track number
9d93:    39                     dec A, #1
9d94:    a9                     st AL, [B]	 ; packet[7,8] = -1
9d95:    38                     inc A, #1
9d96:    38                     inc A, #1
9d97:    b1 41 b1               st A, [0x41b1]	 ; tracks_per_step = 1

L_9d9a:
    ; This is the test's main loop
9d9a:    90 41 4d               ld A, 0x414d
9d9d:    2f 00                  ld_dma_addr A
9d9f:    90 ff f7               ld A, 0xfff7	 ; 9 bytes
9da2:    2f 02                  ld_dma_count A
9da4:    2f 34                  dma_mode #3
9da6:    2f 06                  enable_dma
9da8:    80 43                  ld AL, 0x43
9daa:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9dad:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9db0:    12 bf                  bn L_9d71
9db2:    80 45                  ld AL, 0x45
9db4:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9db7:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9dba:    13 1c                  bnn L_9dd8
9dbc:    7a 01 12               call @[WriteString|0x0112]
9dbf:    "TRACK=\0"
9dc6:    91 41 52               ld A, [0x4152]	 ; packet[5, 6] = track number
9dc9:    7a 01 10               call @[WriteHex16|0x0110]	 ; WriteHex16
9dcc:    7a 01 12               call @[WriteString|0x0112]
9dcf:    "\r\n\0"
9dd2:    a1 f1 0b               st AL, [0xf10b]
9dd5:    a1 f1 0c               st AL, [0xf10c]

L_9dd8:
9dd8:    91 41 b1               ld A, [0x41b1]	 ; track_per_step
9ddb:    16 14                  blt L_9df1
9ddd:    91 41 52               ld A, [0x4152]	 ; track++
9de0:    38                     inc A, #1
9de1:    b1 41 52               st A, [0x4152]
9de4:    d0 02 5c               ld B, 0x025c	 ; 604 tracks total
9de7:    59                     sub B, A
9de8:    15 b0                  bnz L_9d9a
9dea:    3a                     clr A, #0
9deb:    39                     dec A, #1
9dec:    b1 41 b1               st A, [0x41b1]	 ; tracks_per_step = -1
9def:    73 a9                  jmp L_9d9a

L_9df1:
    ; track_per_step < 0
9df1:    91 41 52               ld A, [0x4152]
9df4:    39                     dec A, #1
9df5:    b1 41 52               st A, [0x4152]
9df8:    17 a0                  bp L_9d9a
9dfa:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9dfd:    05 48                  (0x548)

Entry_FINCH_READ_TEST:
    ; This test reads certain tracks fron the Finch hard drive.
    ; Each track (16 sectors, 400 bytes each) is read into a 6400 bytes
    ; buffer in main RAM. No checks are done on the contents; apparently
    ; data integrity is entirely verified by the controller card.
    ; The test does not read all tracks, but only those with a number being
    ; power of 2. The sequence starts at zero:
    ; 0 1 2 4 8 16 ...
    ; The test completes by itself after reaching track number 604.
9dff:    90 01 8b               ld A, 0x018b
9e02:    50 80                  add A, Z
9e04:    7d 00                  call [A]	 ; Init
9e06:    f8 00                  (0xf800)	 ; FFC_REGS_BASE
9e08:    7a 01 06               call @[PrintCtrlCToExit|0x0106]
9e0b:    90 41 4d               ld A, 0x414d	 ; Prepare the request packet
9e0e:    5c                     mov Y, A
9e0f:    90 81 02               ld A, 0x8102
9e12:    b5 61                  st A, [Y++]	 ; packet[0, 1] = 0x8102
9e14:    90 84 00               ld A, 0x8400
9e17:    b5 61                  st A, [Y++]	 ; packet[2, 3] = 0x8400
9e19:    80 83                  ld AL, 0x83
9e1b:    a5 61                  st AL, [Y++]	 ; packet[4] = 0x83
9e1d:    3a                     clr A, #0
9e1e:    b5 61                  st A, [Y++]	 ; packet[5,6] = 0 - track number
9e20:    80 8a                  ld AL, 0x8a
9e22:    a5 61                  st AL, [Y++]	 ; packet[7] = 0x8a
9e24:    d0 10 00               ld B, 0x1000

L_9e27:
    ; The following contents of the request packet looks like sector gather list:
    ; 0, 400
    ; 1, 400
    ; 2, 400
    ; ...
    ; 15, 400
    ; (48 bytes total)
9e27:    e5 61                  st BL, [Y++]	 ; Is it sector numbers ?
9e29:    90 01 90               ld A, 0x0190
9e2c:    b5 61                  st A, [Y++]	 ; packet[9,10] = 400
9e2e:    20 30                  inc BL, #1
9e30:    21 20                  dec BH, #1
9e32:    15 f3                  bnz L_9e27
9e34:    80 ff                  ld AL, 0xff	 ; This sequence terminates with 0xff.
9e36:    ab                     st AL, [Y]	 ; It it some list ? Sectors ?

L_9e37:
    ; Test's main loop
    ; A data read operation is executed in two steps.
    ; First a 0x43 is written into the command register
    ; and a request packet is fed into the DMA.
    ; Second a 0x45 is written; and the data is retrieved.
    ; Interesting to note that Seek test also uses a sequence
    ; of the same 0x43, 0x45 commands; but no actual data is
    ; returned. It looks like Seek returns an "empty payload"
9e37:    90 ff c3               ld A, 0xffc3	 ; Request length = 60 bytes
9e3a:    2f 02                  ld_dma_count A
9e3c:    90 41 4d               ld A, 0x414d	 ; Send the request
9e3f:    2f 00                  ld_dma_addr A
9e41:    2f 34                  dma_mode #3
9e43:    2f 06                  enable_dma
9e45:    80 43                  ld AL, 0x43	 ; Execute
9e47:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9e4a:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9e4d:    13 09                  bnn L_9e58
9e4f:    a1 f1 0b               st AL, [0xf10b]
9e52:    a1 f1 0c               st AL, [0xf10c]
9e55:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9e58:
9e58:    90 e6 ff               ld A, 0xe6ff	 ; 6400 bytes = 16 sectors * 400 bytes
9e5b:    2f 02                  ld_dma_count A
9e5d:    90 01 1c               ld A, 0x011c	 ; Address to place data
9e60:    2f 00                  ld_dma_addr A
9e62:    2f 34                  dma_mode #3
9e64:    2f 06                  enable_dma
9e66:    80 45                  ld AL, 0x45	 ; Return data
9e68:    a2 01 14               st AL, @[0x0114]	 ; COMMAND_REG
9e6b:    7a 01 18               call @[WaitForReady|0x0118]	 ; WaitForReady
9e6e:    13 16                  bnn L_9e86
9e70:    7a 01 12               call @[WriteString|0x0112]
9e73:    "TRACK=\0"
9e7a:    91 41 52               ld A, [0x4152]	 ; Track number
9e7d:    7a 01 10               call @[WriteHex16|0x0110]	 ; WriteHex16
9e80:    7a 01 12               call @[WriteString|0x0112]
9e83:    "\r\n\0"

L_9e86:
9e86:    91 41 52               ld A, [0x4152]	 ; Update track number
9e89:    15 01                  bnz L_9e8c
9e8b:    38                     inc A, #1	 ; From track 0 we go to track 1

L_9e8c:
9e8c:    3d                     sll A, #1	 ; And then track number becomes next power of 2
9e8d:    b1 41 52               st A, [0x4152]
9e90:    d0 02 5d               ld B, 0x025d	 ; 604 tracks total
9e93:    59                     sub B, A
9e94:    19 a1                  ble L_9e37
9e96:    a1 f1 0a               st AL, [0xf10a]
9e99:    7a 01 04               call @[FinishTest|0x0104]	 ; FinishTest
9e9c:    06 0b                  (0x60b)

Entry_ROM_SELF_TEST:
9e9e:    90 01 8b               ld A, 0x018b
9ea1:    50 80                  add A, Z
9ea3:    7d 00                  call [A]	 ; Init
9ea5:    00 00                  (0x0)	 ; No hardware base address
9ea7:    55 86                  mov Y, Z
9ea9:    3a                     clr A, #0

L_9eaa:
    ; Simply calculate 8-bit sum of all bytes in this ROM...
9eaa:    85 61                  ld AL, [Y++]
9eac:    40 10                  add AH, AL
9eae:    d0 06 ed               ld B, 0x06ed
9eb1:    50 82                  add B, Z
9eb3:    51 62                  sub B, Y
9eb5:    15 f3                  bnz L_9eaa
9eb7:    8b                     ld AL, [Y]	 ; And compare it with the last byte.
9eb8:    41 01                  sub AL, AH
9eba:    15 18                  bnz L_9ed4
9ebc:    7a 01 12               call @[WriteString|0x0112]
9ebf:    "\n\r*** PASS ***\0"
9ece:    a1 f1 0a               st AL, [0xf10a]
9ed1:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit

L_9ed4:
9ed4:    7a 01 12               call @[WriteString|0x0112]
9ed7:    "*** FAIL ***\0"
9ee4:    a1 f1 0b               st AL, [0xf10b]
9ee7:    a1 f1 0c               st AL, [0xf10c]
9eea:    72 01 0e               jmp @[PressSpaceThenExit|0x010e]	 ; PressSpaceThenExit
9eed:    c5 'E'	 ; Checksum byte
9eee:    <null bytes>

