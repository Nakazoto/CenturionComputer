0xfc00:     1C 03            BS3  (PC+0x03)     ; Branch if sense switch 3 set to 0x03 ahead PC (0x0005)
0xfc02:     71 EF C0         JMP  EFC0          ; Jump to direct address
0xfc05:     80 01            LDAL #011D         ; Load literal address into byte of AL
0xfc07:     1D 01            BS4  (PC+0x01)     ; Branch if sense switch 4 set to zero to 0x01 ahead PC (0x000a)
0xfc09:     2A               CLAL               ; Clear byte of implicit AL register
0xfc0a:     A1 F1 4B         STAL F14B          ; Store AL into direct address
0xfc0d:     90 01 00         LDAW #0100         ; Load literal address into byte of AW
0xfc10:     B1 FF F0         STAW FFF0          ; Store AW into direct address
0xfc13:     A1 FF F4         STAL FFF4          ; Store AL into direct address
0xfc16:     A1 FF F7         STAL FFF7          ; Store AL into direct address
0xfc19:     5F               XASW               ; Transfer implicit AW into SW
0xfc1a:     90 E8 8F         LDAW #E88F         ; Load literal address into byte of AW
0xfc1d:     B1 FF F2         STAW FFF2          ; Store AW into direct address
0xfc20:     80 03            LDAL #037B         ; Load literal address into byte of AL
0xfc22:     7B 06            JSR  (PC+0x06)     ; Jump to subroutine at direct PC offset by N address  (0x002a)
0xfc24:     80 00            LDAL #007B         ; Load literal address into byte of AL
0xfc26:     7B 02            JSR  (PC+0x02)     ; Jump to subroutine at direct PC offset by N address  (0x002a)
0xfc28:     75 A0            JMP  SW, 0         ; Jump to index mode register (view supplemental material)
0xfc2a:     A1 F1 48         STAL F148          ; Store AL into direct address
0xfc2d:     81 F1 44         LDAL F144          ; Load direct address into byte of AL
0xfc30:     2C               SRAL               ; Shift byte of implicit AL register left
0xfc31:     15 CD            BNZ  (PC-0x33)     ; Branch if not equal to zero to 0x33 behind PC (0x0000)
0xfc33:     10 F8            BL   (PC-0x08)     ; Branch if link set to 0x8 behind PC (0x002d)
0xfc35:     81 F1 45         LDAL F145          ; Load direct address into byte of AL
0xfc38:     C0 30            LDBL #3042         ; Load literal address into byte of BL
0xfc3a:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0xfc3c:     49               SABL               ; Subtract implicit AL and BL
0xfc3d:     15 EE            BNZ  (PC-0x12)     ; Branch if not equal to zero to 0x12 behind PC (0x002d)
0xfc3f:     09               RSR                ; return(cont=1) from Subroutine
0xfc40:     00               HLT                ; Halts the CPU
0xfc41:     00               HLT                ; Halts the CPU
0xfc42:     00               HLT                ; Halts the CPU
0xfc43:     00               HLT                ; Halts the CPU
0xfc44:     00               HLT                ; Halts the CPU
0xfc45:     00               HLT                ; Halts the CPU
0xfc46:     00               HLT                ; Halts the CPU
0xfc47:     00               HLT                ; Halts the CPU
0xfc48:     00               HLT                ; Halts the CPU
0xfc49:     00               HLT                ; Halts the CPU
0xfc4a:     00               HLT                ; Halts the CPU
0xfc4b:     00               HLT                ; Halts the CPU
0xfc4c:     00               HLT                ; Halts the CPU
0xfc4d:     00               HLT                ; Halts the CPU
0xfc4e:     00               HLT                ; Halts the CPU
0xfc4f:     00               HLT                ; Halts the CPU
0xfc50:     00               HLT                ; Halts the CPU
0xfc51:     00               HLT                ; Halts the CPU
0xfc52:     00               HLT                ; Halts the CPU
0xfc53:     00               HLT                ; Halts the CPU
0xfc54:     00               HLT                ; Halts the CPU
0xfc55:     00               HLT                ; Halts the CPU
0xfc56:     00               HLT                ; Halts the CPU
0xfc57:     00               HLT                ; Halts the CPU
0xfc58:     00               HLT                ; Halts the CPU
0xfc59:     00               HLT                ; Halts the CPU
0xfc5a:     00               HLT                ; Halts the CPU
0xfc5b:     00               HLT                ; Halts the CPU
0xfc5c:     00               HLT                ; Halts the CPU
0xfc5d:     00               HLT                ; Halts the CPU
0xfc5e:     00               HLT                ; Halts the CPU
0xfc5f:     00               HLT                ; Halts the CPU
0xfc60:     00               HLT                ; Halts the CPU
0xfc61:     00               HLT                ; Halts the CPU
0xfc62:     00               HLT                ; Halts the CPU
0xfc63:     00               HLT                ; Halts the CPU
0xfc64:     00               HLT                ; Halts the CPU
0xfc65:     00               HLT                ; Halts the CPU
0xfc66:     00               HLT                ; Halts the CPU
0xfc67:     00               HLT                ; Halts the CPU
0xfc68:     00               HLT                ; Halts the CPU
0xfc69:     00               HLT                ; Halts the CPU
0xfc6a:     00               HLT                ; Halts the CPU
0xfc6b:     00               HLT                ; Halts the CPU
0xfc6c:     00               HLT                ; Halts the CPU
0xfc6d:     00               HLT                ; Halts the CPU
0xfc6e:     00               HLT                ; Halts the CPU
0xfc6f:     00               HLT                ; Halts the CPU
0xfc70:     00               HLT                ; Halts the CPU
0xfc71:     00               HLT                ; Halts the CPU
0xfc72:     00               HLT                ; Halts the CPU
0xfc73:     00               HLT                ; Halts the CPU
0xfc74:     00               HLT                ; Halts the CPU
0xfc75:     00               HLT                ; Halts the CPU
0xfc76:     00               HLT                ; Halts the CPU
0xfc77:     00               HLT                ; Halts the CPU
0xfc78:     00               HLT                ; Halts the CPU
0xfc79:     00               HLT                ; Halts the CPU
0xfc7a:     00               HLT                ; Halts the CPU
0xfc7b:     00               HLT                ; Halts the CPU
0xfc7c:     00               HLT                ; Halts the CPU
0xfc7d:     00               HLT                ; Halts the CPU
0xfc7e:     00               HLT                ; Halts the CPU
0xfc7f:     00               HLT                ; Halts the CPU
0xfc80:     00               HLT                ; Halts the CPU
0xfc81:     00               HLT                ; Halts the CPU
0xfc82:     00               HLT                ; Halts the CPU
0xfc83:     00               HLT                ; Halts the CPU
0xfc84:     00               HLT                ; Halts the CPU
0xfc85:     00               HLT                ; Halts the CPU
0xfc86:     00               HLT                ; Halts the CPU
0xfc87:     00               HLT                ; Halts the CPU
0xfc88:     00               HLT                ; Halts the CPU
0xfc89:     00               HLT                ; Halts the CPU
0xfc8a:     00               HLT                ; Halts the CPU
0xfc8b:     00               HLT                ; Halts the CPU
0xfc8c:     00               HLT                ; Halts the CPU
0xfc8d:     00               HLT                ; Halts the CPU
0xfc8e:     00               HLT                ; Halts the CPU
0xfc8f:     00               HLT                ; Halts the CPU
0xfc90:     00               HLT                ; Halts the CPU
0xfc91:     00               HLT                ; Halts the CPU
0xfc92:     00               HLT                ; Halts the CPU
0xfc93:     00               HLT                ; Halts the CPU
0xfc94:     00               HLT                ; Halts the CPU
0xfc95:     00               HLT                ; Halts the CPU
0xfc96:     00               HLT                ; Halts the CPU
0xfc97:     00               HLT                ; Halts the CPU
0xfc98:     00               HLT                ; Halts the CPU
0xfc99:     00               HLT                ; Halts the CPU
0xfc9a:     00               HLT                ; Halts the CPU
0xfc9b:     00               HLT                ; Halts the CPU
0xfc9c:     00               HLT                ; Halts the CPU
0xfc9d:     00               HLT                ; Halts the CPU
0xfc9e:     00               HLT                ; Halts the CPU
0xfc9f:     00               HLT                ; Halts the CPU
0xfca0:     00               HLT                ; Halts the CPU
0xfca1:     00               HLT                ; Halts the CPU
0xfca2:     00               HLT                ; Halts the CPU
0xfca3:     00               HLT                ; Halts the CPU
0xfca4:     00               HLT                ; Halts the CPU
0xfca5:     00               HLT                ; Halts the CPU
0xfca6:     00               HLT                ; Halts the CPU
0xfca7:     00               HLT                ; Halts the CPU
0xfca8:     00               HLT                ; Halts the CPU
0xfca9:     00               HLT                ; Halts the CPU
0xfcaa:     00               HLT                ; Halts the CPU
0xfcab:     00               HLT                ; Halts the CPU
0xfcac:     00               HLT                ; Halts the CPU
0xfcad:     00               HLT                ; Halts the CPU
0xfcae:     00               HLT                ; Halts the CPU
0xfcaf:     00               HLT                ; Halts the CPU
0xfcb0:     00               HLT                ; Halts the CPU
0xfcb1:     00               HLT                ; Halts the CPU
0xfcb2:     00               HLT                ; Halts the CPU
0xfcb3:     00               HLT                ; Halts the CPU
0xfcb4:     00               HLT                ; Halts the CPU
0xfcb5:     00               HLT                ; Halts the CPU
0xfcb6:     00               HLT                ; Halts the CPU
0xfcb7:     00               HLT                ; Halts the CPU
0xfcb8:     00               HLT                ; Halts the CPU
0xfcb9:     00               HLT                ; Halts the CPU
0xfcba:     00               HLT                ; Halts the CPU
0xfcbb:     00               HLT                ; Halts the CPU
0xfcbc:     00               HLT                ; Halts the CPU
0xfcbd:     00               HLT                ; Halts the CPU
0xfcbe:     00               HLT                ; Halts the CPU
0xfcbf:     00               HLT                ; Halts the CPU
0xfcc0:     90 F0 B0         LDAW #F0B0         ; Load literal address into byte of AW
0xfcc3:     1D 03            BS4  (PC+0x03)     ; Branch if sense switch 4 set to zero to 0x03 ahead PC (0x00c8)
0xfcc5:     90 F0 A0         LDAW #F0A0         ; Load literal address into byte of AW
0xfcc8:     55 0C            XFR  AW,  C        ; Copy word of one explicit register into other (R into L)
0xfcca:     90 00 F0         LDAW #00F0         ; Load literal address into byte of AW
0xfccd:     5F               XASW               ; Transfer implicit AW into SW
0xfcce:     7B 1F            JSR  (PC+0x1F)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfcd0:     4D               XABL               ; Transfer implicit AL into BL
0xfcd1:     7B 1C            JSR  (PC+0x1C)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfcd3:     5B               XAXW               ; Transfer implicit AW into XW
0xfcd4:     4E               XAZL               ; Transfer implicit AL into ZL
0xfcd5:     7B 18            JSR  (PC+0x18)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfcd7:     45 16            XFR  AL,  YH       ; Copy byte of one explicit register into other (R into L)
0xfcd9:     7B 14            JSR  (PC+0x14)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfcdb:     4C               XAYL               ; Transfer implicit AL into YL
0xfcdc:     3F               DCX                ; Decrement word of implicit X register
0xfcdd:     16 06            BM   (PC+0x06)     ; Branch if minus set to 0x06 ahead PC (0x00e5)
0xfcdf:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfce1:     A5 61            STAL YW, 1         ; Store AL into index mode register (view supplemental material)
0xfce3:     73 F7            JMP  (PC-0x09)     ; Jump to direct PC offset by N address  (0x00dc)
0xfce5:     7B 08            JSR  (PC+0x08)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xfce7:     15 E2            BNZ  (PC-0x1e)     ; Branch if not equal to zero to 0x1e behind PC (0x00cb)
0xfce9:     45 99            XFR  ZL,  ZL       ; Copy byte of one explicit register into other (R into L)
0xfceb:     15 E1            BNZ  (PC-0x1f)     ; Branch if not equal to zero to 0x1f behind PC (0x00ce)
0xfced:     75 60            JMP  YW, 0         ; Jump to index mode register (view supplemental material)
0xfcef:     85 C8 01         LDAL C , 8, 0x01   ; Load index mode register address into AL (view supplemental material)
0xfcf2:     16 D7            BM   (PC-0x29)     ; Branch if minus set to 0x29 behind PC (0x00cb)
0xfcf4:     2C               SRAL               ; Shift byte of implicit AL register left
0xfcf5:     11 03            BNL  (PC+0x03)     ; Branch if link not set to 0x03 ahead PC (0x00fa)
0xfcf7:     A5 C8 03         STAL C , 8, 0x03   ; Store AL into index mode register (view supplemental material)
0xfcfa:     2C               SRAL               ; Shift byte of implicit AL register left
0xfcfb:     11 F2            BNL  (PC-0x0e)     ; Branch if link not set to 0xe behind PC (0x00ef)
0xfcfd:     8E               LALC               ; Load byte from address in C into implicit AL
0xfcfe:     48               AABL               ; Add implicit AL and BL
0xfcff:     09               RSR                ; return(cont=1) from Subroutine
0xfd00:     00               HLT                ; Halts the CPU
