
L_ef00:
ef00:    1c 03        b_sense2 L_ef05
ef02:    71 ef c0     jump 0xefc0 L_efc0

L_ef05:
ef05:    80 01        mov AL, 0x01
ef07:    1d 01        b_sense3 L_ef0a
ef09:    2a           clear AL, AL

L_ef0a:
ef0a:    a1 f1 4b     mov [0xf14b], AL
ef0d:    90 01 00     mov AX, 0x0100
ef10:    b1 ff f0     mov [0xfff0], AX
ef13:    a1 ff f4     mov [0xfff4], AL
ef16:    a1 ff f7     mov [0xfff7], AL
ef19:    5f           mov SP, AX
ef1a:    90 e8 8f     mov AX, 0xe88f
ef1d:    b1 ff f2     mov [0xfff2], AX
ef20:    80 03        mov AL, 0x03
ef22:    7b 06        call L_ef2a
ef24:    80 00        mov AL, 0x00
ef26:    7b 02        call L_ef2a
ef28:    75 a0        jump A + 0xa0

L_ef2a:
ef2a:    a1 f1 48     mov [0xf148], AL

L_ef2d:
ef2d:    81 f1 44     mov AL, [0xf144]
ef30:    2c           shift_right AL, AL
ef31:    15 cd        b_nz L_ef00
ef33:    10 f8        b0 L_ef2d
ef35:    81 f1 45     mov AL, [0xf145]
ef38:    c0 30        mov BL, 0x30
ef3a:    42 31        and AL, BL
ef3c:    49           sub BL, AL
ef3d:    15 ee        b_nz L_ef2d
ef3f:    09           ret

L_efc0:
efc0:    90 f0 b0     mov AX, 0xf0b0
efc3:    1d 03        b_sense3 L_efc8
efc5:    90 f0 a0     mov AX, 0xf0a0

L_efc8:
efc8:    55 0c        mov r6, AX
efca:    90 00 f0     mov AX, 0x00f0
efcd:    5f           mov SP, AX

L_efce:
efce:    7b 1f        call L_efef
efd0:    4d           mov BL, AL
efd1:    7b 1c        call L_efef
efd3:    5b           or BX, AX
efd4:    4e           unknown
efd5:    7b 18        call L_efef
efd7:    45 16        mov r3_high, AL
efd9:    7b 14        call L_efef
efdb:    4c           xor BL, AL

L_efdc:
efdc:    3f           rotate_left AX, AX
efdd:    16 06        b_lt L_efe5
efdf:    7b 0e        call L_efef
efe1:    a5 61        mov [--r3], AL
efe3:    73 f7        jump L_efdc

L_efe5:
efe5:    7b 08        call L_efef
efe7:    15 e2        b_nz L_efcb
efe9:    45 99        mov SP_low, SP_low
efeb:    15 e1        b_nz L_efce
efed:    75 60        jump A + 0x60

L_efef:
efef:    85 c8        mov SP_high, [r6++]
eff1:    01           nop
eff2:    16 d7        b_lt L_efcb
eff4:    2c           shift_right AL, AL
eff5:    11 03        b1 L_effa
eff7:    a5 c8        mov [--r6], SP_high
eff9:    03           flag3

L_effa:
effa:    2c           shift_right AL, AL
effb:    11 f2        b1 L_efef
effd:    8e           mov AL, [None]
effe:    48           add BL, AL
efff:    09           ret
