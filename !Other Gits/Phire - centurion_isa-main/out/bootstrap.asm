
EntryPoint:
fc00:    1a 02        bs1 L_fc04 ; Check the Sense switch to see if we should jump straight to DIAG
fc02:    73 03        jump (PC+0x03) L_fc07

L_fc04:
fc04:    71 80 01     jump #0x8001 L_8001

L_fc07:
fc07:    80 c5        ld AL, #0xc5
fc09:    a1 f2 00     st AL, (0xf200) ; Configure the first port on the mux board to 9600 baud, 8N1
fc0c:    80 8c        ld AL, #0x8c
fc0e:    a1 f2 01     st AL, (0xf201) ; Write control code FF aka Form Feed to serial
                                      ; Should cause a printer to move to the next page, and
                                      ; cause a CRT terminal to clear the screen
fc11:    0e           delay 4.5ms
fc12:    0e           delay 4.5ms

Prompt:
fc13:    90 10 00     ld AX, #0x1000
fc16:    5f           mov SP, AX ; Setup stack at 0x1000 (probally)
fc17:    7b 79        call (PC+0x79) WriteString
fc19:    "D=\0"
fc1c:    7b 72        call (PC+0x72) ReadCharTramp
fc1e:    c0 c6        ld BL, #0xc6 ; B == 'F'
fc20:    49           sub! BL, AL
fc21:    e5 a2        st BL, -(SP)
fc23:    14 0a        bz GetNextChar
fc25:    c0 c3        ld BL, #0xc3 ; B == 'C'
fc27:    49           sub! BL, AL
fc28:    14 05        bz GetNextChar
fc2a:    c0 c8        ld BL, #0xc8 ; B == 'H'
fc2c:    49           sub! BL, AL
fc2d:    15 50        bnz PrintError

GetNextChar:
fc2f:    7b 72        call (PC+0x72) ReadChar
fc31:    c0 50        ld BL, #0x50
fc33:    40 31        add AL, BL
fc35:    16 48        blt PrintError ; Reject anything below ASCI 0x30 aka '0'
fc37:    c5 a1        ld BL, (SP)+
fc39:    16 7f        blt LoadFromCMDTramp
fc3b:    18 7f        bgt LoadFromHawkTramp
fc3d:    c0 03        ld BL, #0x03
fc3f:    49           sub! BL, AL
fc40:    18 3d        bgt PrintError
fc42:    d0 0f 00     ld BX, #0x0f00
fc45:    f5 a2        st BX, -(SP)
fc47:    32 20        clr BX
fc49:    f5 a2        st BX, -(SP)
fc4b:    c0 88        ld BL, #0x88
fc4d:    e5 a2        st BL, -(SP)
fc4f:    d0 83 00     ld BX, #0x8300
fc52:    f5 a2        st BX, -(SP)
fc54:    d0 81 00     ld BX, #0x8100
fc57:    06           fsc

LoadFromFFC:
fc58:    27 30        rlc BL
fc5a:    29           dec! AL
fc5b:    17 fb        ble LoadFromFFC
fc5d:    f5 a2        st BX, -(SP)
fc5f:    2f 14        dma_set_mode 1
fc61:    2f 06        dma_enable
fc63:    2f a0        dma_load_addr SP
fc65:    90 ff f6     ld AX, #0xfff6
fc68:    2f 02        dma_load_count WX
fc6a:    7b 22        call (PC+0x22) FFC_CommandTramp
fc6c:    43           (0x43)
fc6d:    90 01 00     ld AX, #0x0100
fc70:    2f 00        dma_load_addr WX
fc72:    90 f0 ff     ld AX, #0xf0ff
fc75:    2f 02        dma_load_count WX
fc77:    7b 15        call (PC+0x15) FFC_CommandTramp
fc79:    45           (0x45)
fc7a:    15 03        bnz PrintError
fc7c:    71 01 03     jump #0x0103 IPL_Entry_point

PrintError:
fc7f:    7b 11        call (PC+0x11) WriteString
fc81:    "\r\nERROR\r\n\0"
fc8b:    07           fcc
fc8c:    73 85        jump (PC-0x7b) Prompt

FFC_CommandTramp:
fc8e:    73 73        jump (PC+0x73) FFC_Command

ReadCharTramp:
fc90:    73 11        jump (PC+0x11) ReadChar

WriteString:
fc92:    81 f2 00     ld AL, (0xf200)
fc95:    2c           srl! AL
fc96:    2c           srl! AL
fc97:    11 f9        bnc WriteString
fc99:    85 41        ld AL, (RT)+
fc9b:    15 01        bnz L_fc9e
fc9d:    09           ret

L_fc9e:
fc9e:    a1 f2 01     st AL, (0xf201)
fca1:    73 ef        jump (PC-0x11) WriteString

ReadChar:
fca3:    84 ee        ld AL, @(PC-0x12)
fca5:    2c           srl! AL
fca6:    11 fb        bnc ReadChar
fca8:    84 f5        ld AL, @(PC-0xb)
fcaa:    c0 80        ld BL, #0x80
fcac:    43 31        or AL, BL ; char | 0x80 - Force bit 7 to be set
fcae:    c0 e0        ld BL, #0xe0
fcb0:    49           sub! BL, AL ; Check if char is lowercase (greater than 0x60)
fcb1:    16 04        blt L_fcb7
fcb3:    c0 df        ld BL, #0xdf
fcb5:    42 31        and AL, BL ; Clear bit 6, forcing it to be uppercase

L_fcb7:
fcb7:    a4 e6        st AL, @(PC-0x1a)
fcb9:    09           ret

LoadFromCMDTramp:
fcba:    73 62        jump (PC+0x62) LoadFromCMD

LoadFromHawkTramp:
fcbc:    73 02        jump (PC+0x02) LoadFromHawk

PrintErrorTramp:
fcbe:    73 bf        jump (PC-0x41) PrintError

LoadFromHawk:
fcc0:    c0 07        ld BL, #0x07
fcc2:    49           sub! BL, AL
fcc3:    18 ba        bgt PrintError
fcc5:    a1 f1 40     st AL, (0xf140) ; HawkUnitSelect = A
fcc8:    94 2d        ld AX, @(PC+0x2d)
fcca:    d0 00 10     ld BX, #0x0010
fccd:    5a           and! BX, AX
fcce:    14 af        bz PrintError
fcd0:    3a           clr! AX
fcd1:    b1 f1 41     st AX, (0xf141) ; HawkSectorAddressReg = (0, 0, 0)
fcd4:    7b 3b        call (PC+0x3b) HawkCommand ; HawkCommand(3) - ReturnTrackZero
fcd6:    03           (0x3)

L_fcd7:
fcd7:    94 1e        ld AX, @(PC+0x1e)
fcd9:    d0 04 00     ld BX, #0x0400
fcdc:    5a           and! BX, AX
fcdd:    15 a0        bnz PrintError
fcdf:    d0 00 20     ld BX, #0x0020
fce2:    5a           and! BX, AX
fce3:    14 f2        bz L_fcd7
fce5:    2f 04        dma_set_mode 0
fce7:    2f 06        dma_enable
fce9:    90 01 00     ld AX, #0x0100 ; DMA transfer destination address
fcec:    2f 00        dma_load_addr WX
fcee:    90 ea 1f     ld AX, #0xea1f ; DMA transfer size, 0xffff - (14 sectors at 400 bytes each)
fcf1:    2f 02        dma_load_count WX
fcf3:    7b 1c        call (PC+0x1c) HawkCommand ; HawkCommand(0) - Read
fcf5:    00           (0x0)
fcf6:    81 f1 44     ld AL, (0xf144) ; Check Command Status (0 == success?)
fcf9:    15 84        bnz PrintError
fcfb:    71 01 03     jump #0x0103 IPL_Entry_point ; Transfer control to the IPL that was loaded off disk
fcfe:    7b 2f        call (PC+0x2f) L_fd2f

AlternativeEntryPoint:
fd00:    71 fc 00     jump #0xfc00 EntryPoint

FFC_Command:
fd03:    85 41        ld AL, (RT)+
fd05:    a1 f8 00     st AL, (0xf800)

L_fd08:
fd08:    81 f8 01     ld AL, (0xf801)
fd0b:    29           dec! AL
fd0c:    15 fa        bnz L_fd08
fd0e:    84 f6        ld AL, @(PC-0xa)
fd10:    09           ret

HawkCommand:
fd11:    85 41        ld AL, (RT)+
fd13:    a1 f1 48     st AL, (0xf148)

WaitForHawkCommand:
fd16:    84 df        ld AL, @(PC-0x21) ; 0xf144
fd18:    2c           srl! AL
fd19:    10 fb        bc WaitForHawkCommand
fd1b:    09           ret

PrintErrorTramp2:
fd1c:    73 a0        jump (PC-0x60) PrintErrorTramp

LoadFromCMD:
fd1e:    a5 a2        st AL, -(SP)
fd20:    90 1f 40     ld AX, #0x1f40
fd23:    5e           mov EX, AX
fd24:    90 81 00     ld AX, #0x8100
fd27:    b5 81        st AX, (EX)+
fd29:    80 84        ld AL, #0x84
fd2b:    a5 81        st AL, (EX)+
fd2d:    85 a1        ld AL, (SP)+

L_fd2f:
fd2f:    14 04        bz L_fd35
fd31:    c0 0f        ld BL, #0x0f
fd33:    40 31        add AL, BL

L_fd35:
fd35:    a5 81        st AL, (EX)+
fd37:    80 83        ld AL, #0x83
fd39:    a5 81        st AL, (EX)+
fd3b:    3a           clr! AX
fd3c:    b5 81        st AX, (EX)+
fd3e:    80 85        ld AL, #0x85
fd40:    a5 81        st AL, (EX)+
fd42:    2a           clr! AL

L_fd43:
fd43:    a5 81        st AL, (EX)+
fd45:    d0 01 90     ld BX, #0x0190
fd48:    f5 81        st BX, (EX)+
fd4a:    28           inc! AL
fd4b:    c0 0e        ld BL, #0x0e
fd4d:    49           sub! BL, AL
fd4e:    15 f3        bnz L_fd43
fd50:    80 ff        ld AL, #0xff
fd52:    a5 81        st AL, (EX)+
fd54:    80 08        ld AL, #0x08
fd56:    7b 4e        call (PC+0x4e) CMDWait
fd58:    80 41        ld AL, #0x41
fd5a:    a1 f8 08     st AL, (0xf808)
fd5d:    0e           delay 4.5ms
fd5e:    2a           clr! AL
fd5f:    a1 f8 08     st AL, (0xf808)
fd62:    0e           delay 4.5ms
fd63:    a1 f8 08     st AL, (0xf808)
fd66:    0e           delay 4.5ms
fd67:    90 1f 40     ld AX, #0x1f40
fd6a:    2f 00        dma_load_addr WX
fd6c:    51 80        sub AX, EX
fd6e:    3b           not! AX
fd6f:    2f 02        dma_load_count WX
fd71:    2f 34        dma_set_mode 3
fd73:    2f 06        dma_enable
fd75:    80 43        ld AL, #0x43
fd77:    a1 f8 08     st AL, (0xf808)
fd7a:    0e           delay 4.5ms
fd7b:    0e           delay 4.5ms
fd7c:    7b 20        call (PC+0x20) CMDErrorCheck
fd7e:    73 02        jump (PC+0x02) L_fd82

PrintErrorTramp3:
fd80:    73 9a        jump (PC-0x66) PrintErrorTramp2

L_fd82:
fd82:    90 01 00     ld AX, #0x0100
fd85:    2f 00        dma_load_addr WX
fd87:    90 ea 1f     ld AX, #0xea1f
fd8a:    2f 02        dma_load_count WX
fd8c:    2f 34        dma_set_mode 3
fd8e:    2f 06        dma_enable
fd90:    80 45        ld AL, #0x45
fd92:    a1 f8 08     st AL, (0xf808)
fd95:    80 08        ld AL, #0x08
fd97:    7b 0d        call (PC+0x0d) CMDWait
fd99:    7b 03        call (PC+0x03) CMDErrorCheck
fd9b:    71 01 03     jump #0x0103 IPL_Entry_point

CMDErrorCheck:
    ; Returns if no error
fd9e:    81 f8 08     ld AL, (0xf808)
fda1:    15 01        bnz CMDError
fda3:    09           ret

CMDError:
fda4:    73 da        jump (PC-0x26) PrintErrorTramp3

CMDWait:
    ; Spins until command is done
fda6:    c1 f8 09     ld BL, (0xf809)
fda9:    4a           and! BL, AL
fdaa:    15 fa        bnz CMDWait
fdac:    09           ret
fdad:    8c           ld AL, (EX)
fdae:    00           HALT
fdaf:    8b           ld AL, (DX)
fdb0:    00           HALT
fdb1:    95 41        ld AX, (RT)+
fdb3:    b3 03        st AX, (PC+0x3)

L_fdb5:
fdb5:    79 4c 93     call #0x4c93 L_4c93
fdb8:    47 be        unk7 HL, SL
fdba:    6d a2        st RT, -(SP)
fdbc:    32 40        clr RT

L_fdbe:
fdbe:    79 4c e7     call #0x4ce7 L_4ce7
fdc1:    4d           mov! BL, AL
fdc2:    14 2a        bz L_fdee
fdc4:    c0 8d        ld BL, #0x8d
fdc6:    49           sub! BL, AL
fdc7:    14 25        bz L_fdee
fdc9:    c0 b0        ld BL, #0xb0
fdcb:    49           sub! BL, AL
fdcc:    16 25        blt L_fdf3
fdce:    80 09        ld AL, #0x09
fdd0:    41 31        sub AL, BL
fdd2:    19 0e        ble L_fde2
fdd4:    80 11        ld AL, #0x11
fdd6:    41 31        sub AL, BL
fdd8:    16 19        blt L_fdf3
fdda:    c0 05        ld BL, #0x05
fddc:    49           sub! BL, AL
fddd:    18 14        bgt L_fdf3
fddf:    c0 0a        ld BL, #0x0a
fde1:    48           add! BL, AL

L_fde2:
fde2:    80 04        ld AL, #0x04

L_fde4:
fde4:    07           fcc
fde5:    37 40        rlc RT
fde7:    29           dec! AL
fde8:    18 fa        bgt L_fde4
fdea:    40 35        add RL, BL
fdec:    73 d0        jump (PC-0x30) L_fdbe

L_fdee:
fdee:    55 40        mov AX, RT
fdf0:    65 a1        ld RT, (SP)+
fdf2:    09           ret

L_fdf3:
fdf3:    65 a1        ld RT, (SP)+
fdf5:    73 be        jump (PC-0x42) L_fdb5
fdf7:    d5 41        ld BX, (RT)+
fdf9:    7d 80        call (A + 0x80)
fdfb:    0c           unknown
fdfc:    d0 4b 65     ld BX, #0x4b65
fdff:    f5 00        st BX, (AX)
