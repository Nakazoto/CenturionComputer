0xfc00:     1A 02            BS1  (PC+0x02)     ; Branch if sense switch 1 set to 0x02 ahead PC (0x0004)
0xfc02:     73 03            JMP  (PC+0x03)     ; Jump to direct PC offset by N address  (0x0007)
0xfc04:     71 80 01         JMP  8001          ; Jump to direct address
0xfc07:     80 C5            LDAL #C5A1         ; Load literal address into byte of AL
0xfc09:     A1 F2 00         STAL F200          ; Store AL into direct address
0xfc0c:     80 8C            LDAL #8CA1         ; Load literal address into byte of AL
0xfc0e:     A1 F2 01         STAL F201          ; Store AL into direct address
0xfc11:     0E               DLY                ; Delay 4.5ms
0xfc12:     0E               DLY                ; Delay 4.5ms
0xfc13:     90 10 00         LDAW #1000         ; Load literal address into byte of AW
0xfc16:     5F               XASW               ; Transfer implicit AW into SW
0xfc17:     7B 79            JSR  (PC+0x79)     ; Jump to writestring at direct PC offset by N address  (0x0092)
0xfc19:     'D='
0xfc1c:     7B 72            JSR  (PC+0x72)     ; Jump to subroutine at direct PC offset by N address  (0x0090)
0xfc1e:     C0 C6            LDBL #C649         ; Load literal address into byte of BL
0xfc20:     49               SABL               ; Subtract implicit AL and BL
0xfc21:     E5 A2            STAL SW, 2         ; Store BL into index mode register (view supplemental material)
0xfc23:     14 0A            BZ   (PC+0x0A)     ; Branch if equal to zero to 0x0A ahead PC (0x002f)
0xfc25:     C0 C3            LDBL #C349         ; Load literal address into byte of BL
0xfc27:     49               SABL               ; Subtract implicit AL and BL
0xfc28:     14 05            BZ   (PC+0x05)     ; Branch if equal to zero to 0x05 ahead PC (0x002f)
0xfc2a:     C0 C8            LDBL #C849         ; Load literal address into byte of BL
0xfc2c:     49               SABL               ; Subtract implicit AL and BL
0xfc2d:     15 50            BNZ  (PC+0x50)     ; Branch if not equal to zero to 0x50 ahead PC (0x007f)
0xfc2f:     7B 72            JSR  (PC+0x72)     ; Jump to subroutine at direct PC offset by N address  (0x00a3)
0xfc31:     C0 50            LDBL #5040         ; Load literal address into byte of BL
0xfc33:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0xfc35:     16 48            BM   (PC+0x48)     ; Branch if minus set to 0x48 ahead PC (0x007f)
0xfc37:     C5 A1            LDAL SW, 1         ; Load index mode register address into BL (view supplemental material)
0xfc39:     16 7F            BM   (PC+0x7F)     ; Branch if minus set to 0x7F ahead PC (0x00ba)
0xfc3b:     18 7F            BGZ  (PC+0x7F)     ; Branch if greater than zero to 0x7F ahead PC (0x00bc)
0xfc3d:     C0 03            LDBL #0349         ; Load literal address into byte of BL
0xfc3f:     49               SABL               ; Subtract implicit AL and BL
0xfc40:     18 3D            BGZ  (PC+0x3D)     ; Branch if greater than zero to 0x3D ahead PC (0x007f)
0xfc42:     D0 0F 00         LDBW #0F00         ; Load literal address into byte of BW
0xfc45:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0xfc47:     32 20            CLR  BW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0xfc49:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0xfc4b:     C0 88            LDBL #88E5         ; Load literal address into byte of BL
0xfc4d:     E5 A2            STAL SW, 2         ; Store BL into index mode register (view supplemental material)
0xfc4f:     D0 83 00         LDBW #8300         ; Load literal address into byte of BW
0xfc52:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0xfc54:     D0 81 00         LDBW #8100         ; Load literal address into byte of BW
0xfc57:     06               SL                 ; Set Link
0xfc58:     27 30            RLR  BL, 0         ; Rotate byte of explicit register left by 1 + const.
0xfc5a:     29               DCAL               ; Decrement byte of implicit AL register
0xfc5b:     17 FB            BP   (PC-0x05)     ; Branch on positive to 0x5 behind PC (0x0058)
0xfc5d:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0xfc5f:     2F 14            ???                ; Special 2 byte instruction. See supplemental material.
0xfc61:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0xfc63:     2F A0            ???                ; Special 2 byte instruction. See supplemental material.
0xfc65:     90 FF F6         LDAW #FFF6         ; Load literal address into byte of AW
0xfc68:     2F 02            ???                ; Special 2 byte instruction. See supplemental material.
0xfc6a:     7B 22            JSR  (PC+0x22)     ; Jump to subroutine at direct PC offset by N address  (0x008e)
0xfc6c:     43 90            ORI  ZL,  AH       ; OR bytes of two explicit registers (L OR R stored in L)
0xfc6e:     01               NOP                ; No Operation
0xfc6f:     00               HLT                ; Halts the CPU
0xfc70:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0xfc72:     90 F0 FF         LDAW #F0FF         ; Load literal address into byte of AW
0xfc75:     2F 02            ???                ; Special 2 byte instruction. See supplemental material.
0xfc77:     7B 15            JSR  (PC+0x15)     ; Jump to subroutine at direct PC offset by N address  (0x008e)
0xfc79:     45 15            XFR  AL,  X        ; Copy byte of one explicit register into other (R into L)
0xfc7b:     03               RF                 ; Reset Fault
0xfc7c:     71 01 03         JMP  0103          ; Jump to direct address
0xfc7f:     7B 11            JSR  (PC+0x11)     ; Jump to writestring at direct PC offset by N address  (0x0092)
0xfc81:     '/CR /LF ERROR/CR /LF '
0xfc8b:     07               RL                 ; Reset Link
0xfc8c:     73 85            JMP  (PC-0x7b)     ; Jump to direct PC offset by N address  (0x0013)
0xfc8e:     73 73            JMP  (PC+0x73)     ; Jump to direct PC offset by N address  (0x0103)
0xfc90:     73 11            JMP  (PC+0x11)     ; Jump to direct PC offset by N address  (0x00a3)
0xfc92:     81 F2 00         LDAL F200          ; Load direct address into byte of AL
0xfc95:     2C               SRAL               ; Shift byte of implicit AL register left
0xfc96:     2C               SRAL               ; Shift byte of implicit AL register left
0xfc97:     11 F9            BNL  (PC-0x07)     ; Branch if link not set to 0x7 behind PC (0x0092)
0xfc99:     85 41            LDAL X , 1         ; Load index mode register address into AL (view supplemental material)
0xfc9b:     15 01            BNZ  (PC+0x01)     ; Branch if not equal to zero to 0x01 ahead PC (0x009e)
0xfc9d:     09               RSR                ; return(cont=1) from Subroutine
0xfc9e:     A1 F2 01         STAL F201          ; Store AL into direct address
0xfca1:     73 EF            JMP  (PC-0x11)     ; Jump to direct PC offset by N address  (0x0092)
0xfca3:     84 EE            LDAL [PC-0x12]     ; Load indirect PC offset by N address into byte of AL
0xfca5:     2C               SRAL               ; Shift byte of implicit AL register left
0xfca6:     11 FB            BNL  (PC-0x05)     ; Branch if link not set to 0x5 behind PC (0x00a3)
0xfca8:     84 F5            LDAL [PC-0x0b]     ; Load indirect PC offset by N address into byte of AL
0xfcaa:     C0 80            LDBL #8043         ; Load literal address into byte of BL
0xfcac:     43 31            ORI  BL,  AL       ; OR bytes of two explicit registers (L OR R stored in L)
0xfcae:     C0 E0            LDBL #E049         ; Load literal address into byte of BL
0xfcb0:     49               SABL               ; Subtract implicit AL and BL
0xfcb1:     16 04            BM   (PC+0x04)     ; Branch if minus set to 0x04 ahead PC (0x00b7)
0xfcb3:     C0 DF            LDBL #DF42         ; Load literal address into byte of BL
0xfcb5:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0xfcb7:     A4 E6            STAL [PC-0x1a]     ; Store byte of AL into indirect PC offset by N address
0xfcb9:     09               RSR                ; return(cont=1) from Subroutine
0xfcba:     73 62            JMP  (PC+0x62)     ; Jump to direct PC offset by N address  (0x011e)
0xfcbc:     73 02            JMP  (PC+0x02)     ; Jump to direct PC offset by N address  (0x00c0)
0xfcbe:     73 BF            JMP  (PC-0x41)     ; Jump to direct PC offset by N address  (0x007f)
0xfcc0:     C0 07            LDBL #0749         ; Load literal address into byte of BL
0xfcc2:     49               SABL               ; Subtract implicit AL and BL
0xfcc3:     18 BA            BGZ  (PC-0x46)     ; Branch if greater than zero to 0x46 behind PC (0x007f)
0xfcc5:     A1 F1 40         STAL F140          ; Store AL into direct address
0xfcc8:     94 2D            LDAW [PC+0x2D]     ; Load indirect PC offset by N address into word of AW
0xfcca:     D0 00 10         LDBW #0010         ; Load literal address into byte of BW
0xfccd:     5A               NABW               ; AND implicit AW and BW
0xfcce:     14 AF            BZ   (PC-0x51)     ; Branch if equal to zero to 0x51 behind PC (0x007f)
0xfcd0:     3A               CLAW               ; Clear word of implicit AW register
0xfcd1:     B1 F1 41         STAW F141          ; Store AW into direct address
0xfcd4:     7B 3B            JSR  (PC+0x3B)     ; Jump to subroutine at direct PC offset by N address  (0x0111)
0xfcd6:     03               RF                 ; Reset Fault
0xfcd7:     94 1E            LDAW [PC+0x1E]     ; Load indirect PC offset by N address into word of AW
0xfcd9:     D0 04 00         LDBW #0400         ; Load literal address into byte of BW
0xfcdc:     5A               NABW               ; AND implicit AW and BW
0xfcdd:     15 A0            BNZ  (PC-0x60)     ; Branch if not equal to zero to 0x60 behind PC (0x007f)
0xfcdf:     D0 00 20         LDBW #0020         ; Load literal address into byte of BW
0xfce2:     5A               NABW               ; AND implicit AW and BW
0xfce3:     14 F2            BZ   (PC-0x0e)     ; Branch if equal to zero to 0xe behind PC (0x00d7)
0xfce5:     2F 04            ???                ; Special 2 byte instruction. See supplemental material.
0xfce7:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0xfce9:     90 01 00         LDAW #0100         ; Load literal address into byte of AW
0xfcec:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0xfcee:     90 EA 1F         LDAW #EA1F         ; Load literal address into byte of AW
0xfcf1:     2F 02            ???                ; Special 2 byte instruction. See supplemental material.
0xfcf3:     7B 1C            JSR  (PC+0x1C)     ; Jump to subroutine at direct PC offset by N address  (0x0111)
0xfcf5:     00               HLT                ; Halts the CPU
0xfcf6:     81 F1 44         LDAL F144          ; Load direct address into byte of AL
0xfcf9:     15 84            BNZ  (PC-0x7c)     ; Branch if not equal to zero to 0x7c behind PC (0x007f)
0xfcfb:     71 01 03         JMP  0103          ; Jump to direct address
0xfcfe:     7B 2F            JSR  (PC+0x2F)     ; Jump to subroutine at direct PC offset by N address  (0x012f)
0xfd00:     71 FC 00         JMP  FC00          ; Jump to direct address
0xfd03:     85 41            LDAL X , 1         ; Load index mode register address into AL (view supplemental material)
0xfd05:     A1 F8 00         STAL F800          ; Store AL into direct address
0xfd08:     81 F8 01         LDAL F801          ; Load direct address into byte of AL
0xfd0b:     29               DCAL               ; Decrement byte of implicit AL register
0xfd0c:     15 FA            BNZ  (PC-0x06)     ; Branch if not equal to zero to 0x6 behind PC (0x0108)
0xfd0e:     84 F6            LDAL [PC-0x0a]     ; Load indirect PC offset by N address into byte of AL
0xfd10:     09               RSR                ; return(cont=1) from Subroutine
0xfd11:     85 41            LDAL X , 1         ; Load index mode register address into AL (view supplemental material)
0xfd13:     A1 F1 48         STAL F148          ; Store AL into direct address
0xfd16:     84 DF            LDAL [PC-0x21]     ; Load indirect PC offset by N address into byte of AL
0xfd18:     2C               SRAL               ; Shift byte of implicit AL register left
0xfd19:     10 FB            BL   (PC-0x05)     ; Branch if link set to 0x5 behind PC (0x0116)
0xfd1b:     09               RSR                ; return(cont=1) from Subroutine
0xfd1c:     73 A0            JMP  (PC-0x60)     ; Jump to direct PC offset by N address  (0x00be)
0xfd1e:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0xfd20:     90 1F 40         LDAW #1F40         ; Load literal address into byte of AW
0xfd23:     5E               XAZW               ; Transfer implicit AW into ZW
0xfd24:     90 81 00         LDAW #8100         ; Load literal address into byte of AW
0xfd27:     B5 81            STAW ZW, 1         ; Store AW into index mode register (view supplemental material)
0xfd29:     80 84            LDAL #84A5         ; Load literal address into byte of AL
0xfd2b:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd2d:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0xfd2f:     14 04            BZ   (PC+0x04)     ; Branch if equal to zero to 0x04 ahead PC (0x0135)
0xfd31:     C0 0F            LDBL #0F40         ; Load literal address into byte of BL
0xfd33:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0xfd35:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd37:     80 83            LDAL #83A5         ; Load literal address into byte of AL
0xfd39:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd3b:     3A               CLAW               ; Clear word of implicit AW register
0xfd3c:     B5 81            STAW ZW, 1         ; Store AW into index mode register (view supplemental material)
0xfd3e:     80 85            LDAL #85A5         ; Load literal address into byte of AL
0xfd40:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd42:     2A               CLAL               ; Clear byte of implicit AL register
0xfd43:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd45:     D0 01 90         LDBW #0190         ; Load literal address into byte of BW
0xfd48:     F5 81            STBW ZW, 1         ; Store BW into index mode register (view supplemental material)
0xfd4a:     28               INAL               ; Increment byte of implicit AL register
0xfd4b:     C0 0E            LDBL #0E49         ; Load literal address into byte of BL
0xfd4d:     49               SABL               ; Subtract implicit AL and BL
0xfd4e:     15 F3            BNZ  (PC-0x0d)     ; Branch if not equal to zero to 0xd behind PC (0x0143)
0xfd50:     80 FF            LDAL #FFA5         ; Load literal address into byte of AL
0xfd52:     A5 81            STAL ZW, 1         ; Store AL into index mode register (view supplemental material)
0xfd54:     80 08            LDAL #087B         ; Load literal address into byte of AL
0xfd56:     7B 4E            JSR  (PC+0x4E)     ; Jump to subroutine at direct PC offset by N address  (0x01a6)
0xfd58:     80 41            LDAL #41A1         ; Load literal address into byte of AL
0xfd5a:     A1 F8 08         STAL F808          ; Store AL into direct address
0xfd5d:     0E               DLY                ; Delay 4.5ms
0xfd5e:     2A               CLAL               ; Clear byte of implicit AL register
0xfd5f:     A1 F8 08         STAL F808          ; Store AL into direct address
0xfd62:     0E               DLY                ; Delay 4.5ms
0xfd63:     A1 F8 08         STAL F808          ; Store AL into direct address
0xfd66:     0E               DLY                ; Delay 4.5ms
0xfd67:     90 1F 40         LDAW #1F40         ; Load literal address into byte of AW
0xfd6a:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0xfd6c:     51 80            SUB  ZW,  AW       ; Subtract word of two explicit registers (L - R stored in L)
0xfd6e:     3B               IVAW               ; Invert word of implicit AW register
0xfd6f:     2F 02            ???                ; Special 2 byte instruction. See supplemental material.
0xfd71:     2F 34            ???                ; Special 2 byte instruction. See supplemental material.
0xfd73:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0xfd75:     80 43            LDAL #43A1         ; Load literal address into byte of AL
0xfd77:     A1 F8 08         STAL F808          ; Store AL into direct address
0xfd7a:     0E               DLY                ; Delay 4.5ms
0xfd7b:     0E               DLY                ; Delay 4.5ms
0xfd7c:     7B 20            JSR  (PC+0x20)     ; Jump to subroutine at direct PC offset by N address  (0x019e)
0xfd7e:     73 02            JMP  (PC+0x02)     ; Jump to direct PC offset by N address  (0x0182)
0xfd80:     73 9A            JMP  (PC-0x66)     ; Jump to direct PC offset by N address  (0x011c)
0xfd82:     90 01 00         LDAW #0100         ; Load literal address into byte of AW
0xfd85:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0xfd87:     90 EA 1F         LDAW #EA1F         ; Load literal address into byte of AW
0xfd8a:     2F 02            ???                ; Special 2 byte instruction. See supplemental material.
0xfd8c:     2F 34            ???                ; Special 2 byte instruction. See supplemental material.
0xfd8e:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0xfd90:     80 45            LDAL #45A1         ; Load literal address into byte of AL
0xfd92:     A1 F8 08         STAL F808          ; Store AL into direct address
0xfd95:     80 08            LDAL #087B         ; Load literal address into byte of AL
0xfd97:     7B 0D            JSR  (PC+0x0D)     ; Jump to subroutine at direct PC offset by N address  (0x01a6)
0xfd99:     7B 03            JSR  (PC+0x03)     ; Jump to subroutine at direct PC offset by N address  (0x019e)
0xfd9b:     71 01 03         JMP  0103          ; Jump to direct address
0xfd9e:     81 F8 08         LDAL F808          ; Load direct address into byte of AL
0xfda1:     15 01            BNZ  (PC+0x01)     ; Branch if not equal to zero to 0x01 ahead PC (0x01a4)
0xfda3:     09               RSR                ; return(cont=1) from Subroutine
0xfda4:     73 DA            JMP  (PC-0x26)     ; Jump to direct PC offset by N address  (0x0180)
0xfda6:     C1 F8 09         LDBL F809          ; Load direct address into byte of BL
0xfda9:     4A               NABL               ; AND implicit AL and BL
0xfdaa:     15 FA            BNZ  (PC-0x06)     ; Branch if not equal to zero to 0x6 behind PC (0x01a6)
0xfdac:     09               RSR                ; return(cont=1) from Subroutine
0xfdad:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0xfdae:     00               HLT                ; Halts the CPU
0xfdaf:     8B               LALY               ; Load byte from address in YW into implicit AL
0xfdb0:     00               HLT                ; Halts the CPU
0xfdb1:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0xfdb3:     B3 03            STAW (PC+0x03)     ; Store word of AW into direct PC offset by N address
0xfdb5:     79 4C 93         JSR  4C93          ; Jump to subroutine at direct address
0xfdb8:     47 BE            ???                ; Special 2 byte instruction. See supplemental material.
0xfdba:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0xfdbc:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0xfdbe:     79 4C E7         JSR  4CE7          ; Jump to subroutine at direct address
0xfdc1:     4D               XABL               ; Transfer implicit AL into BL
0xfdc2:     14 2A            BZ   (PC+0x2A)     ; Branch if equal to zero to 0x2A ahead PC (0x01ee)
0xfdc4:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0xfdc6:     49               SABL               ; Subtract implicit AL and BL
0xfdc7:     14 25            BZ   (PC+0x25)     ; Branch if equal to zero to 0x25 ahead PC (0x01ee)
0xfdc9:     C0 B0            LDBL #B049         ; Load literal address into byte of BL
0xfdcb:     49               SABL               ; Subtract implicit AL and BL
0xfdcc:     16 25            BM   (PC+0x25)     ; Branch if minus set to 0x25 ahead PC (0x01f3)
0xfdce:     80 09            LDAL #0941         ; Load literal address into byte of AL
0xfdd0:     41 31            SUB  BL,  AL       ; Subtract bytes of two explicit registers (L - R stored in L)
0xfdd2:     19 0E            BLE  (PC+0x0E)     ; Branch if less than or equal to zero to 0x0E ahead PC (0x01e2)
0xfdd4:     80 11            LDAL #1141         ; Load literal address into byte of AL
0xfdd6:     41 31            SUB  BL,  AL       ; Subtract bytes of two explicit registers (L - R stored in L)
0xfdd8:     16 19            BM   (PC+0x19)     ; Branch if minus set to 0x19 ahead PC (0x01f3)
0xfdda:     C0 05            LDBL #0549         ; Load literal address into byte of BL
0xfddc:     49               SABL               ; Subtract implicit AL and BL
0xfddd:     18 14            BGZ  (PC+0x14)     ; Branch if greater than zero to 0x14 ahead PC (0x01f3)
0xfddf:     C0 0A            LDBL #0A48         ; Load literal address into byte of BL
0xfde1:     48               AABL               ; Add implicit AL and BL
0xfde2:     80 04            LDAL #0407         ; Load literal address into byte of AL
0xfde4:     07               RL                 ; Reset Link
0xfde5:     37 40            RLR  X,  0         ; Rotate byte of explicit register left by 1 + const. (Odd reg. on MEM)
0xfde7:     29               DCAL               ; Decrement byte of implicit AL register
0xfde8:     18 FA            BGZ  (PC-0x06)     ; Branch if greater than zero to 0x6 behind PC (0x01e4)
0xfdea:     40 35            ADD  BL,  X        ; Add bytes of two explicit registers (L + R stored in L)
0xfdec:     73 D0            JMP  (PC-0x30)     ; Jump to direct PC offset by N address  (0x01be)
0xfdee:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0xfdf0:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0xfdf2:     09               RSR                ; return(cont=1) from Subroutine
0xfdf3:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0xfdf5:     73 BE            JMP  (PC-0x42)     ; Jump to direct PC offset by N address  (0x01b5)
0xfdf7:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0xfdf9:     7D 80            JMP  ZW, 0         ; Jump to subroutine at index mode register (view supplemental material)
0xfdfb:     0C               ELO                ; Enable Link Out
0xfdfc:     D0 4B 65         LDBW #4B65         ; Load literal address into byte of BW
0xfdff:     F5 00            STBW AW, 0         ; Store BW into index mode register (view supplemental material)
