
IPL_Entry_point:
0103:    <null bytes>


L_4c93:
4c93:    <null bytes>


L_4ce7:
4ce7:    <null bytes>


L_8001:
8001:    <null bytes>


EntryPoint:
fc00:    1a 02                  bs1 L_fc04	 ; Check the Sense switch to see if we should jump straight to DIAG
fc02:    73 03                  jmp L_fc07

L_fc04:
fc04:    71 80 01               jmp L_8001

L_fc07:
fc07:    80 c5                  ld AL, 0xc5
fc09:    a1 f2 00               st AL, [0xf200]	 ; Configure the first port on the mux board to 9600 baud, 8N1
fc0c:    80 8c                  ld AL, 0x8c
fc0e:    a1 f2 01               st AL, [0xf201]	 ; Write control code FF aka Form Feed to serial
                                               	 ; Should cause a printer to move to the next page, and
                                               	 ; cause a CRT terminal to clear the screen
fc11:    0e                     dly
fc12:    0e                     dly

Prompt:
fc13:    90 10 00               ld A, 0x1000
fc16:    5f                     mov S, A	 ; Setup stack at 0x1000 (probally)
fc17:    7b 79                  call WriteString
fc19:    "D=\0"
fc1c:    7b 72                  call ReadCharTramp
fc1e:    c0 c6                  ld BL, 0xc6	 ; B == 'F'
fc20:    49                     sub BL, AL
fc21:    e5 a2                  st BL, [--S]
fc23:    14 0a                  bz GetNextChar
fc25:    c0 c3                  ld BL, 0xc3	 ; B == 'C'
fc27:    49                     sub BL, AL
fc28:    14 05                  bz GetNextChar
fc2a:    c0 c8                  ld BL, 0xc8	 ; B == 'H'
fc2c:    49                     sub BL, AL
fc2d:    15 50                  bnz PrintError

GetNextChar:
fc2f:    7b 72                  call ReadChar
fc31:    c0 50                  ld BL, 0x50
fc33:    40 31                  add AL, BL
fc35:    16 48                  blt PrintError	 ; Reject anything below ASCI 0x30 aka '0'
fc37:    c5 a1                  ld BL, [S++]
fc39:    16 7f                  blt LoadFromCMDTramp
fc3b:    18 7f                  bgt LoadFromHawkTramp
fc3d:    c0 03                  ld BL, 0x03
fc3f:    49                     sub BL, AL
fc40:    18 3d                  bgt PrintError
fc42:    d0 0f 00               ld B, 0x0f00
fc45:    f5 a2                  st B, [--S]
fc47:    32 20                  clr B, #0
fc49:    f5 a2                  st B, [--S]
fc4b:    c0 88                  ld BL, 0x88
fc4d:    e5 a2                  st BL, [--S]
fc4f:    d0 83 00               ld B, 0x8300
fc52:    f5 a2                  st B, [--S]
fc54:    d0 81 00               ld B, 0x8100
fc57:    06                     sl

LoadFromFFC:
fc58:    27 30                  rlc BL, #1
fc5a:    29                     dec AL, #1
fc5b:    17 fb                  bp LoadFromFFC
fc5d:    f5 a2                  st B, [--S]
fc5f:    2f 14                  dma_mode #1
fc61:    2f 06                  enable_dma
fc63:    2f a0                  ld_dma_addr S
fc65:    90 ff f6               ld A, 0xfff6
fc68:    2f 02                  ld_dma_count A
fc6a:    7b 22                  call FFC_CommandTramp
fc6c:    43                     (0x43)
fc6d:    90 01 00               ld A, 0x0100
fc70:    2f 00                  ld_dma_addr A
fc72:    90 f0 ff               ld A, 0xf0ff
fc75:    2f 02                  ld_dma_count A
fc77:    7b 15                  call FFC_CommandTramp
fc79:    45                     (0x45)
fc7a:    15 03                  bnz PrintError
fc7c:    71 01 03               jmp IPL_Entry_point

PrintError:
fc7f:    7b 11                  call WriteString
fc81:    "\r\nERROR\r\n\0"
fc8b:    07                     rl
fc8c:    73 85                  jmp Prompt

FFC_CommandTramp:
fc8e:    73 73                  jmp FFC_Command

ReadCharTramp:
fc90:    73 11                  jmp ReadChar

WriteString:
fc92:    81 f2 00               ld AL, [0xf200]
fc95:    2c                     srl AL, #1
fc96:    2c                     srl AL, #1
fc97:    11 f9                  bnc WriteString
fc99:    85 41                  ld AL, [X++]
fc9b:    15 01                  bnz L_fc9e
fc9d:    09                     ret

L_fc9e:
fc9e:    a1 f2 01               st AL, [0xf201]
fca1:    73 ef                  jmp WriteString

ReadChar:
fca3:    84 ee                  ld AL, [0xf200 (via WriteString+1)]
fca5:    2c                     srl AL, #1
fca6:    11 fb                  bnc ReadChar
fca8:    84 f5                  ld AL, [0xf201 (via L_fc9e+1)]
fcaa:    c0 80                  ld BL, 0x80
fcac:    43 31                  or AL, BL	 ; char | 0x80 - Force bit 7 to be set
fcae:    c0 e0                  ld BL, 0xe0
fcb0:    49                     sub BL, AL	 ; Check if char is lowercase (greater than 0x60)
fcb1:    16 04                  blt L_fcb7
fcb3:    c0 df                  ld BL, 0xdf
fcb5:    42 31                  and AL, BL	 ; Clear bit 6, forcing it to be uppercase

L_fcb7:
fcb7:    a4 e6                  st AL, [0xf201 (via L_fc9e+1)]
fcb9:    09                     ret

LoadFromCMDTramp:
fcba:    73 62                  jmp LoadFromCMD

LoadFromHawkTramp:
fcbc:    73 02                  jmp LoadFromHawk

PrintErrorTramp:
fcbe:    73 bf                  jmp PrintError

LoadFromHawk:
fcc0:    c0 07                  ld BL, 0x07
fcc2:    49                     sub BL, AL
fcc3:    18 ba                  bgt PrintError
fcc5:    a1 f1 40               st AL, [0xf140]	 ; HawkUnitSelect = A
fcc8:    94 2d                  ld A, [0xf144 (via 0xfcf6+1)]
fcca:    d0 00 10               ld B, 0x0010
fccd:    5a                     and B, A
fcce:    14 af                  bz PrintError
fcd0:    3a                     clr A, #0
fcd1:    b1 f1 41               st A, [0xf141]	 ; HawkSectorAddressReg = (0, 0, 0)
fcd4:    7b 3b                  call HawkCommand	 ; HawkCommand(3) - ReturnTrackZero
fcd6:    03                     (0x3)

L_fcd7:
fcd7:    94 1e                  ld A, [0xf144 (via 0xfcf6+1)]
fcd9:    d0 04 00               ld B, 0x0400
fcdc:    5a                     and B, A
fcdd:    15 a0                  bnz PrintError
fcdf:    d0 00 20               ld B, 0x0020
fce2:    5a                     and B, A
fce3:    14 f2                  bz L_fcd7
fce5:    2f 04                  dma_mode #0
fce7:    2f 06                  enable_dma
fce9:    90 01 00               ld A, 0x0100	 ; DMA transfer destination address
fcec:    2f 00                  ld_dma_addr A
fcee:    90 ea 1f               ld A, 0xea1f	 ; DMA transfer size, 0xffff - (14 sectors at 400 bytes each)
fcf1:    2f 02                  ld_dma_count A
fcf3:    7b 1c                  call HawkCommand	 ; HawkCommand(0) - Read
fcf5:    00                     (0x0)
fcf6:    81 f1 44               ld AL, [0xf144]	 ; Check Command Status (0 == success?)
fcf9:    15 84                  bnz PrintError
fcfb:    71 01 03               jmp IPL_Entry_point	 ; Transfer control to the IPL that was loaded off disk
fcfe:    7b 2f                  call L_fd2f

AlternativeEntryPoint:
fd00:    71 fc 00               jmp EntryPoint

FFC_Command:
fd03:    85 41                  ld AL, [X++]
fd05:    a1 f8 00               st AL, [0xf800]

L_fd08:
fd08:    81 f8 01               ld AL, [0xf801]
fd0b:    29                     dec AL, #1
fd0c:    15 fa                  bnz L_fd08
fd0e:    84 f6                  ld AL, [0xf800 (via 0xfd05+1)]
fd10:    09                     ret

HawkCommand:
fd11:    85 41                  ld AL, [X++]
fd13:    a1 f1 48               st AL, [0xf148]

WaitForHawkCommand:
fd16:    84 df                  ld AL, [0xf144 (via 0xfcf6+1)]	 ; 0xf144
fd18:    2c                     srl AL, #1
fd19:    10 fb                  bc WaitForHawkCommand
fd1b:    09                     ret

PrintErrorTramp2:
fd1c:    73 a0                  jmp PrintErrorTramp

LoadFromCMD:
fd1e:    a5 a2                  st AL, [--S]
fd20:    90 1f 40               ld A, 0x1f40
fd23:    5e                     mov Z, A
fd24:    90 81 00               ld A, 0x8100
fd27:    b5 81                  st A, [Z++]
fd29:    80 84                  ld AL, 0x84
fd2b:    a5 81                  st AL, [Z++]
fd2d:    85 a1                  ld AL, [S++]

L_fd2f:
fd2f:    14 04                  bz L_fd35
fd31:    c0 0f                  ld BL, 0x0f
fd33:    40 31                  add AL, BL

L_fd35:
fd35:    a5 81                  st AL, [Z++]
fd37:    80 83                  ld AL, 0x83
fd39:    a5 81                  st AL, [Z++]
fd3b:    3a                     clr A, #0
fd3c:    b5 81                  st A, [Z++]
fd3e:    80 85                  ld AL, 0x85
fd40:    a5 81                  st AL, [Z++]
fd42:    2a                     clr AL, #0

L_fd43:
fd43:    a5 81                  st AL, [Z++]
fd45:    d0 01 90               ld B, 0x0190
fd48:    f5 81                  st B, [Z++]
fd4a:    28                     inc AL, #1
fd4b:    c0 0e                  ld BL, 0x0e
fd4d:    49                     sub BL, AL
fd4e:    15 f3                  bnz L_fd43
fd50:    80 ff                  ld AL, 0xff
fd52:    a5 81                  st AL, [Z++]
fd54:    80 08                  ld AL, 0x08
fd56:    7b 4e                  call CMDWait
fd58:    80 41                  ld AL, 0x41
fd5a:    a1 f8 08               st AL, [0xf808]
fd5d:    0e                     dly
fd5e:    2a                     clr AL, #0
fd5f:    a1 f8 08               st AL, [0xf808]
fd62:    0e                     dly
fd63:    a1 f8 08               st AL, [0xf808]
fd66:    0e                     dly
fd67:    90 1f 40               ld A, 0x1f40
fd6a:    2f 00                  ld_dma_addr A
fd6c:    51 80                  sub A, Z
fd6e:    3b                     not A, #0
fd6f:    2f 02                  ld_dma_count A
fd71:    2f 34                  dma_mode #3
fd73:    2f 06                  enable_dma
fd75:    80 43                  ld AL, 0x43
fd77:    a1 f8 08               st AL, [0xf808]
fd7a:    0e                     dly
fd7b:    0e                     dly
fd7c:    7b 20                  call CMDErrorCheck
fd7e:    73 02                  jmp L_fd82

PrintErrorTramp3:
fd80:    73 9a                  jmp PrintErrorTramp2

L_fd82:
fd82:    90 01 00               ld A, 0x0100
fd85:    2f 00                  ld_dma_addr A
fd87:    90 ea 1f               ld A, 0xea1f
fd8a:    2f 02                  ld_dma_count A
fd8c:    2f 34                  dma_mode #3
fd8e:    2f 06                  enable_dma
fd90:    80 45                  ld AL, 0x45
fd92:    a1 f8 08               st AL, [0xf808]
fd95:    80 08                  ld AL, 0x08
fd97:    7b 0d                  call CMDWait
fd99:    7b 03                  call CMDErrorCheck
fd9b:    71 01 03               jmp IPL_Entry_point

CMDErrorCheck:
    ; Returns if no error
fd9e:    81 f8 08               ld AL, [0xf808]
fda1:    15 01                  bnz CMDError
fda3:    09                     ret

CMDError:
fda4:    73 da                  jmp PrintErrorTramp3

CMDWait:
    ; Spins until command is done
fda6:    c1 f8 09               ld BL, [0xf809]
fda9:    4a                     and BL, AL
fdaa:    15 fa                  bnz CMDWait
fdac:    09                     ret

JunkData:
    ; This isn't actually part of bootstrap, it's just a code fragment left
    ; over from a previous program that the programmer compiled or ran
fdad:    8c                     ld AL, [Z]
fdae:    00                     HALT
fdaf:    8b                     ld AL, [Y]
fdb0:    00                     HALT
fdb1:    95 41                  ld A, [X++]
fdb3:    b3 03                  st A, [0xfdb8]

L_fdb5:
fdb5:    79 4c 93               call L_4c93
fdb8:    47 be 6d a2 32         unkblkB 0x6e, 0xa2, [B]
fdbd:    40 79                  add ZL, YL
fdbf:    4c                     mov YL, AL
fdc0:    e7                     unknown
fdc1:    4d                     mov BL, AL
fdc2:    14 2a                  bz L_fdee
fdc4:    c0 8d                  ld BL, 0x8d
fdc6:    49                     sub BL, AL
fdc7:    14 25                  bz L_fdee
fdc9:    c0 b0                  ld BL, 0xb0
fdcb:    49                     sub BL, AL
fdcc:    16 25                  blt L_fdf3
fdce:    80 09                  ld AL, 0x09
fdd0:    41 31                  sub AL, BL
fdd2:    19 0e                  ble L_fde2
fdd4:    80 11                  ld AL, 0x11
fdd6:    41 31                  sub AL, BL
fdd8:    16 19                  blt L_fdf3
fdda:    c0 05                  ld BL, 0x05
fddc:    49                     sub BL, AL
fddd:    18 14                  bgt L_fdf3
fddf:    c0 0a                  ld BL, 0x0a
fde1:    48                     add BL, AL

L_fde2:
fde2:    80 04                  ld AL, 0x04

L_fde4:
fde4:    07                     rl
fde5:    37 40                  rlc X, #1
fde7:    29                     dec AL, #1
fde8:    18 fa                  bgt L_fde4
fdea:    40 35                  add XL, BL
fdec:    73 d0                  jmp L_fdbe

L_fdee:
fdee:    55 40                  mov A, X
fdf0:    65 a1                  ld X, [S++]
fdf2:    09                     ret

L_fdf3:
fdf3:    65 a1                  ld X, [S++]
fdf5:    73 be                  jmp L_fdb5
fdf7:    d5 41                  ld B, [X++]
fdf9:    7d 80                  call [Z]
fdfb:    0c                     unknown_0c
fdfc:    d0 4b 65               ld B, 0x4b65
fdff:    f5 00                  st B, [A]
