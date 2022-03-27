
EntryPoint:
fc00:    1a 02        b_sense0 L_fc04 ; Check the Sense switch to see if we should jump straight to DIAG
fc02:    73 03        jump L_fc07

L_fc04:
fc04:    71 80 01     jump 0x8001 L_8001

L_fc07:
fc07:    80 c5        mov AL, 0xc5
fc09:    a1 f2 00     mov [0xf200], AL ; Configure the first port on the mux board to 9600 baud, 8N1
fc0c:    80 8c        mov AL, 0x8c
fc0e:    a1 f2 01     mov [0xf201], AL ; Write control code FF aka Form Feed to serial
                                       ; Should cause a printer to move to the next page, and
                                       ; cause a CRT terminal to clear the screen
fc11:    0e           delay 4.5ms
fc12:    0e           delay 4.5ms

Prompt:
fc13:    90 10 00     mov AX, 0x1000
fc16:    5f           mov SP, AX ; Setup stack at 0x1000 (probally)
fc17:    7b 79        call WriteString
fc19:    "D=\0"
fc1c:    7b 72        call ReadCharTramp
fc1e:    c0 c6        mov BL, 0xc6 ; B == 'F'
fc20:    49           sub BL, AL
fc21:    e5 a2        mov [--SP], BH
fc23:    14 0a        b_z GetNextChar
fc25:    c0 c3        mov BL, 0xc3 ; B == 'C'
fc27:    49           sub BL, AL
fc28:    14 05        b_z GetNextChar
fc2a:    c0 c8        mov BL, 0xc8 ; B == 'H'
fc2c:    49           sub BL, AL
fc2d:    15 50        b_nz PrintError

GetNextChar:
fc2f:    7b 72        call ReadChar
fc31:    c0 50        mov BL, 0x50
fc33:    40 31        add AL, BL
fc35:    16 48        b_lt PrintError ; Reject anything below ASCI 0x30 aka '0'
fc37:    c5 a1        mov AL, [SP++]
fc39:    16 7f        b_lt L_fcba
fc3b:    18 7f        b_gt LoadFromHawkTramp
fc3d:    c0 03        mov BL, 0x03
fc3f:    49           sub BL, AL
fc40:    18 3d        b_gt PrintError
fc42:    d0 0f 00     mov BX, 0x0f00
fc45:    f5 a2        mov [--SP], BX
fc47:    32 20        clear AX, BX
fc49:    f5 a2        mov [--SP], BX
fc4b:    c0 88        mov BL, 0x88
fc4d:    e5 a2        mov [--SP], BH
fc4f:    d0 83 00     mov BX, 0x8300
fc52:    f5 a2        mov [--SP], BX
fc54:    d0 81 00     mov BX, 0x8100
fc57:    06           set_carry

L_fc58:
fc58:    27 30        rotate_left AH, BL
fc5a:    29           dec? AL, AL
fc5b:    17 fb        b7 L_fc58
fc5d:    f5 a2        mov [--SP], BX
fc5f:    2f 14        DMA load 1, 4
fc61:    2f 06        DMA load 0, 6
fc63:    2f a0        DMA load 10, 0
fc65:    90 ff f6     mov AX, 0xfff6
fc68:    2f 02        DMA load 0, 2
fc6a:    7b 22        call L_fc8e
fc6c:    43           (0x43)
fc6d:    90 01 00     mov AX, 0x0100
fc70:    2f 00        DMA load 0, 0
fc72:    90 f0 ff     mov AX, 0xf0ff
fc75:    2f 02        DMA load 0, 2
fc77:    7b 15        call L_fc8e
fc79:    45 15        mov r2_low, AL
fc7b:    03           flag3
fc7c:    71 01 03     jump 0x0103 IPL_Entry_point

PrintError:
fc7f:    7b 11        call WriteString
fc81:    "\r\nERROR\r\n\0"
fc8b:    07           clear_carry
fc8c:    73 85        jump Prompt

L_fc8e:
fc8e:    73 73        jump L_fd03

ReadCharTramp:
fc90:    73 11        jump ReadChar

WriteString:
fc92:    81 f2 00     mov AL, [0xf200]
fc95:    2c           shift_right AL, AL
fc96:    2c           shift_right AL, AL
fc97:    11 f9        b1 WriteString
fc99:    85 41        mov AL, [r2++]
fc9b:    15 01        b_nz L_fc9e
fc9d:    09           ret

L_fc9e:
fc9e:    a1 f2 01     mov [0xf201], AL
fca1:    73 ef        jump WriteString

ReadChar:
fca3:    84 ee        mov AL, [pc-0x12]
fca5:    2c           shift_right AL, AL
fca6:    11 fb        b1 ReadChar
fca8:    84 f5        mov AL, [pc-0xb]
fcaa:    c0 80        mov BL, 0x80
fcac:    43 31        or AL, BL ; char | 0x80 - Force bit 7 to be set
fcae:    c0 e0        mov BL, 0xe0
fcb0:    49           sub BL, AL ; Check if char is lowercase (greater than 0x60)
fcb1:    16 04        b_lt L_fcb7
fcb3:    c0 df        mov BL, 0xdf
fcb5:    42 31        and AL, BL ; Clear bit 6, forcing it to be uppercase

L_fcb7:
fcb7:    a4 e6        mov [PC-0x1a], AL
fcb9:    09           ret

L_fcba:
fcba:    73 62        jump L_fd1e

LoadFromHawkTramp:
fcbc:    73 02        jump LoadFromHawk

L_fcbe:
fcbe:    73 bf        jump PrintError

LoadFromHawk:
fcc0:    c0 07        mov BL, 0x07
fcc2:    49           sub BL, AL
fcc3:    18 ba        b_gt PrintError
fcc5:    a1 f1 40     mov [0xf140], AL ; HawkUnitSelect = A
fcc8:    94 2d        mov AX, [pc0x2d]
fcca:    d0 00 10     mov BX, 0x0010
fccd:    5a           and BX, AX
fcce:    14 af        b_z PrintError
fcd0:    3a           clear AX, AX
fcd1:    b1 f1 41     mov [0xf141], AX ; HawkSectorAddressReg = (0, 0, 0)
fcd4:    7b 3b        call DiskCommand ; DiskCommand(3) - ReturnTrackZero
fcd6:    03           flag3

L_fcd7:
fcd7:    94 1e        mov AX, [pc0x1e]
fcd9:    d0 04 00     mov BX, 0x0400
fcdc:    5a           and BX, AX
fcdd:    15 a0        b_nz PrintError
fcdf:    d0 00 20     mov BX, 0x0020
fce2:    5a           and BX, AX
fce3:    14 f2        b_z L_fcd7
fce5:    2f 04        DMA load 0, 4
fce7:    2f 06        DMA load 0, 6
fce9:    90 01 00     mov AX, 0x0100 ; DMA transfer destination address
fcec:    2f 00        DMA load 0, 0
fcee:    90 ea 1f     mov AX, 0xea1f ; DMA source address? It's 0xf1ae backwards.
fcf1:    2f 02        DMA load 0, 2
fcf3:    7b 1c        call DiskCommand ; DiskCommand(0) - Read
fcf5:    00           HALT
fcf6:    81 f1 44     mov AL, [0xf144] ; Check Command Status (0 == success?)
fcf9:    15 84        b_nz PrintError
fcfb:    71 01 03     jump 0x0103 IPL_Entry_point ; Transfer control to the IPL that was loaded off disk
fcfe:    7b 2f        call L_fd2f

AlternativeEntryPoint:
fd00:    71 fc 00     jump 0xfc00 EntryPoint

L_fd03:
fd03:    85 41        mov AL, [r2++]
fd05:    a1 f8 00     mov [0xf800], AL

L_fd08:
fd08:    81 f8 01     mov AL, [0xf801]
fd0b:    29           dec? AL, AL
fd0c:    15 fa        b_nz L_fd08
fd0e:    84 f6        mov AL, [pc-0xa]
fd10:    09           ret

DiskCommand:
fd11:    85 41        mov AL, [r2++]
fd13:    a1 f1 48     mov [0xf148], AL

WaitForHawkCommand:
fd16:    84 df        mov AL, [pc-0x21] ; 0xf144
fd18:    2c           shift_right AL, AL
fd19:    10 fb        b0 WaitForHawkCommand
fd1b:    09           ret

L_fd1c:
fd1c:    73 a0        jump L_fcbe

L_fd1e:
fd1e:    a5 a2        mov [--SP], BH
fd20:    90 1f 40     mov AX, 0x1f40
fd23:    5e           mov r4, AX
fd24:    90 81 00     mov AX, 0x8100
fd27:    b5 81        mov [--r4], AX
fd29:    80 84        mov AL, 0x84
fd2b:    a5 81        mov [--r4], AL
fd2d:    85 a1        mov AL, [SP++]

L_fd2f:
fd2f:    14 04        b_z L_fd35
fd31:    c0 0f        mov BL, 0x0f
fd33:    40 31        add AL, BL

L_fd35:
fd35:    a5 81        mov [--r4], AL
fd37:    80 83        mov AL, 0x83
fd39:    a5 81        mov [--r4], AL
fd3b:    3a           clear AX, AX
fd3c:    b5 81        mov [--r4], AX
fd3e:    80 85        mov AL, 0x85
fd40:    a5 81        mov [--r4], AL
fd42:    2a           clear AL, AL

L_fd43:
fd43:    a5 81        mov [--r4], AL
fd45:    d0 01 90     mov BX, 0x0190
fd48:    f5 81        mov [--r4], AX
fd4a:    28           inc? AL, AL
fd4b:    c0 0e        mov BL, 0x0e
fd4d:    49           sub BL, AL
fd4e:    15 f3        b_nz L_fd43
fd50:    80 ff        mov AL, 0xff
fd52:    a5 81        mov [--r4], AL
fd54:    80 08        mov AL, 0x08
fd56:    7b 4e        call L_fda6
fd58:    80 41        mov AL, 0x41
fd5a:    a1 f8 08     mov [0xf808], AL
fd5d:    0e           delay 4.5ms
fd5e:    2a           clear AL, AL
fd5f:    a1 f8 08     mov [0xf808], AL
fd62:    0e           delay 4.5ms
fd63:    a1 f8 08     mov [0xf808], AL
fd66:    0e           delay 4.5ms
fd67:    90 1f 40     mov AX, 0x1f40
fd6a:    2f 00        DMA load 0, 0
fd6c:    51 80        sub AX, r4
fd6e:    3b           neg? AX, AX
fd6f:    2f 02        DMA load 0, 2
fd71:    2f 34        DMA load 3, 4
fd73:    2f 06        DMA load 0, 6
fd75:    80 43        mov AL, 0x43
fd77:    a1 f8 08     mov [0xf808], AL
fd7a:    0e           delay 4.5ms
fd7b:    0e           delay 4.5ms
fd7c:    7b 20        call L_fd9e
fd7e:    73 02        jump L_fd82

L_fd80:
fd80:    73 9a        jump L_fd1c

L_fd82:
fd82:    90 01 00     mov AX, 0x0100
fd85:    2f 00        DMA load 0, 0
fd87:    90 ea 1f     mov AX, 0xea1f
fd8a:    2f 02        DMA load 0, 2
fd8c:    2f 34        DMA load 3, 4
fd8e:    2f 06        DMA load 0, 6
fd90:    80 45        mov AL, 0x45
fd92:    a1 f8 08     mov [0xf808], AL
fd95:    80 08        mov AL, 0x08
fd97:    7b 0d        call L_fda6
fd99:    7b 03        call L_fd9e
fd9b:    71 01 03     jump 0x0103 IPL_Entry_point

L_fd9e:
fd9e:    81 f8 08     mov AL, [0xf808]
fda1:    15 01        b_nz L_fda4
fda3:    09           ret

L_fda4:
fda4:    73 da        jump L_fd80

L_fda6:
fda6:    c1 f8 09     mov BL, [0xf809]
fda9:    4a           and BL, AL
fdaa:    15 fa        b_nz L_fda6
fdac:    09           ret
fdad:    8c           mov AL, [None]
fdae:    00           HALT
fdaf:    8b           mov AL, [None]
fdb0:    00           HALT
fdb1:    95 41        mov AX, [r2++]
fdb3:    b3 03        unknown

L_fdb5:
fdb5:    79 4c 93     call L_4c93
fdb8:    47           unknown
fdb9:    be           mov [None], AX
fdba:    6d a2        unknown
fdbc:    32 40        clear AX, r2

L_fdbe:
fdbe:    79 4c e7     call L_4ce7
fdc1:    4d           mov BL, AL
fdc2:    14 2a        b_z L_fdee
fdc4:    c0 8d        mov BL, 0x8d
fdc6:    49           sub BL, AL
fdc7:    14 25        b_z L_fdee
fdc9:    c0 b0        mov BL, 0xb0
fdcb:    49           sub BL, AL
fdcc:    16 25        b_lt L_fdf3
fdce:    80 09        mov AL, 0x09
fdd0:    41 31        sub AL, BL
fdd2:    19 0e        b_le L_fde2
fdd4:    80 11        mov AL, 0x11
fdd6:    41 31        sub AL, BL
fdd8:    16 19        b_lt L_fdf3
fdda:    c0 05        mov BL, 0x05
fddc:    49           sub BL, AL
fddd:    18 14        b_gt L_fdf3
fddf:    c0 0a        mov BL, 0x0a
fde1:    48           add BL, AL

L_fde2:
fde2:    80 04        mov AL, 0x04

L_fde4:
fde4:    07           clear_carry
fde5:    37 40        rotate_left AX, r2
fde7:    29           dec? AL, AL
fde8:    18 fa        b_gt L_fde4
fdea:    40 35        add r2_low, BL
fdec:    73 d0        jump L_fdbe

L_fdee:
fdee:    55 40        mov AX, r2
fdf0:    65 a1        unknown
fdf2:    09           ret

L_fdf3:
fdf3:    65 a1        unknown
fdf5:    73 be        jump L_fdb5
fdf7:    d5 41        mov AX, [r2++]
fdf9:    7d 80        call A + 0x80
fdfb:    0c           unknown
fdfc:    d0 4b 65     mov BX, 0x4b65
fdff:    f5 00        mov [--AX], AX
