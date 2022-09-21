0x0000:     00               HLT                ; Halts the CPU
0x0001:     74 00            JMP  [PC+0x00]     ; Jump to indirect PC offset by N address
0x0003:     4C               XAYL               ; Transfer implicit AL into YL
0x0004:     7B 59            JSR  (PC+0x59)     ; Jump to subroutine at direct PC offset by N address  (0x005f)
0x0006:     A5 C8 03         STAL C , 8, 0x03   ; Store AL into index mode register (view supplemental material)
0x0009:     3A               CLAW               ; Clear word of implicit AW register
0x000a:     A3 67            STAL (PC+0x67)     ; Store byte of AL into direct PC offset by N address
0x000c:     7B 58            JSR  (PC+0x58)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x000e:     4D               XABL               ; Transfer implicit AL into BL
0x000f:     16 F3            BM   (PC-0x0d)     ; Branch if minus set to 0xd behind PC (0x0004)
0x0011:     14 2A            BZ   (PC+0x2A)     ; Branch if equal to zero to 0x2A ahead PC (0x003d)
0x0013:     7B 51            JSR  (PC+0x51)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0015:     3C               SRAW               ; Shift word of implicit AW register left
0x0016:     5B               XAXW               ; Transfer implicit AW into XW
0x0017:     7B 4D            JSR  (PC+0x4D)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0019:     45 16            XFR  AL,  YH       ; Copy byte of one explicit register into other (R into L)
0x001b:     7B 49            JSR  (PC+0x49)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x001d:     4C               XAYL               ; Transfer implicit AL into YL
0x001e:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x0021:     5E               XAZW               ; Transfer implicit AW into ZW
0x0022:     50 06            ADD  AW,  YW       ; Add word of two explicit registers (L + R stored in L)
0x0024:     7B 40            JSR  (PC+0x40)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0026:     45 12            XFR  AL,  BH       ; Copy byte of one explicit register into other (R into L)
0x0028:     7B 3C            JSR  (PC+0x3C)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x002a:     4D               XABL               ; Transfer implicit AL into BL
0x002b:     50 82            ADD  ZW,  BW       ; Add word of two explicit registers (L + R stored in L)
0x002d:     99               LAWB               ; Load word from address in BW into implicit AW
0x002e:     50 60            ADD  YW,  AW       ; Add word of two explicit registers (L + R stored in L)
0x0030:     B9               SAWB               ; Store word from address in BW into implicit AW
0x0031:     3F               DCX                ; Decrement word of implicit X register
0x0032:     15 F0            BNZ  (PC-0x10)     ; Branch if not equal to zero to 0x10 behind PC (0x0024)
0x0034:     7B 30            JSR  (PC+0x30)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0036:     C3 3B            LDBL (PC+0x3B)     ; Load direct PC offset by N address into byte of BL
0x0038:     14 CF            BZ   (PC-0x31)     ; Branch if equal to zero to 0x31 behind PC (0x0009)
0x003a:     00               HLT                ; Halts the CPU
0x003b:     73 C7            JMP  (PC-0x39)     ; Jump to direct PC offset by N address  (0x0004)
0x003d:     7B 27            JSR  (PC+0x27)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x003f:     5B               XAXW               ; Transfer implicit AW into XW
0x0040:     7B 24            JSR  (PC+0x24)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0042:     45 10            XFR  AL,  AH       ; Copy byte of one explicit register into other (R into L)
0x0044:     7B 20            JSR  (PC+0x20)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0046:     5C               XAYW               ; Transfer implicit AW into YW
0x0047:     93 D6            LDAW (PC-0x2a)     ; Load direct PC offset by N address into word of AW
0x0049:     50 06            ADD  AW,  YW       ; Add word of two explicit registers (L + R stored in L)
0x004b:     55 44            XFR  X ,  X        ; Copy word of one explicit register into other (R into L)
0x004d:     14 09            BZ   (PC+0x09)     ; Branch if equal to zero to 0x09 ahead PC (0x0058)
0x004f:     7B 15            JSR  (PC+0x15)     ; Jump to subroutine at direct PC offset by N address  (0x0066)
0x0051:     A5 61            STAL YW, 1         ; Store AL into index mode register (view supplemental material)
0x0053:     3F               DCX                ; Decrement word of implicit X register
0x0054:     15 F9            BNZ  (PC-0x07)     ; Branch if not equal to zero to 0x7 behind PC (0x004f)
0x0056:     73 DC            JMP  (PC-0x24)     ; Jump to direct PC offset by N address  (0x0034)
0x0058:     7B 05            JSR  (PC+0x05)     ; Jump to subroutine at direct PC offset by N address  (0x005f)
0x005a:     A5 C8 0A         STAL C , 8, 0x0A   ; Store AL into index mode register (view supplemental material)
0x005d:     75 60            JMP  YW, 0         ; Jump to index mode register (view supplemental material)
0x005f:     85 C8 01         LDAL C , 8, 0x01   ; Load index mode register address into AL (view supplemental material)
0x0062:     2C               SRAL               ; Shift byte of implicit AL register left
0x0063:     11 FA            BNL  (PC-0x06)     ; Branch if link not set to 0x6 behind PC (0x005f)
0x0065:     09               RSR                ; return(cont=1) from Subroutine
0x0066:     85 C8 01         LDAL C , 8, 0x01   ; Load index mode register address into AL (view supplemental material)
0x0069:     16 CF            BM   (PC-0x31)     ; Branch if minus set to 0x31 behind PC (0x003a)
0x006b:     2C               SRAL               ; Shift byte of implicit AL register left
0x006c:     10 CC            BL   (PC-0x34)     ; Branch if link set to 0x34 behind PC (0x003a)
0x006e:     2C               SRAL               ; Shift byte of implicit AL register left
0x006f:     11 F5            BNL  (PC-0x0b)     ; Branch if link not set to 0xb behind PC (0x0066)
0x0071:     8E               LALC               ; Load byte from address in C into implicit AL
0x0072:     C0 00            LDBL #0048         ; Load literal address into byte of BL
0x0074:     48               AABL               ; Add implicit AL and BL
0x0075:     E3 FC            STBL (PC-0x04)     ; Store byte of BL into direct PC offset by N address
0x0077:     09               RSR                ; return(cont=1) from Subroutine
0x0078:     AF               SALP               ; Store byte from address in P into implicit AL
0x0079:     00               HLT                ; Halts the CPU
0x007a:     00               HLT                ; Halts the CPU
0x007b:     00               HLT                ; Halts the CPU
0x007c:     4C               XAYL               ; Transfer implicit AL into YL
0x007d:     B4 80            STAW [PC-0x80]     ; Store word of AW into indirect PC offset by N address
0x007f:     00               HLT                ; Halts the CPU
0x0080:     DC               LBWZ               ; Load byte from address in ZW into implicit BW
0x0081:     49               SABL               ; Subtract implicit AL and BL
0x0082:     E1 08 AE         STBL 08AE          ; Store BL into direct address
0x0085:     14 1B            BZ   (PC+0x1B)     ; Branch if equal to zero to 0x1B ahead PC (0x00a2)
0x0087:     C0 01            LDBL #01E1         ; Load literal address into byte of BL
0x0089:     E1 08 AE         STBL 08AE          ; Store BL into direct address
0x008c:     C0 C3            LDBL #C349         ; Load literal address into byte of BL
0x008e:     49               SABL               ; Subtract implicit AL and BL
0x008f:     14 58            BZ   (PC+0x58)     ; Branch if equal to zero to 0x58 ahead PC (0x00e9)
0x0091:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x0093:     49               SABL               ; Subtract implicit AL and BL
0x0094:     14 53            BZ   (PC+0x53)     ; Branch if equal to zero to 0x53 ahead PC (0x00e9)
0x0096:     C0 FF            LDBL #FFE1         ; Load literal address into byte of BL
0x0098:     E1 08 AE         STBL 08AE          ; Store BL into direct address
0x009b:     C0 D0            LDBL #D049         ; Load literal address into byte of BL
0x009d:     49               SABL               ; Subtract implicit AL and BL
0x009e:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x00a2)
0x00a0:     73 C4            JMP  (PC-0x3c)     ; Jump to direct PC offset by N address  (0x0066)
0x00a2:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x00a5:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x00a6:     86               ???                ; Turn off CPU line 6
0x00a7:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00aa:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00ad:     C0 00            LDBL #0049         ; Load literal address into byte of BL
0x00af:     49               SABL               ; Subtract implicit AL and BL
0x00b0:     14 37            BZ   (PC+0x37)     ; Branch if equal to zero to 0x37 ahead PC (0x00e9)
0x00b2:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00b5:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00b8:     C0 01            LDBL #0149         ; Load literal address into byte of BL
0x00ba:     49               SABL               ; Subtract implicit AL and BL
0x00bb:     14 2C            BZ   (PC+0x2C)     ; Branch if equal to zero to 0x2C ahead PC (0x00e9)
0x00bd:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00c0:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00c3:     C0 02            LDBL #0249         ; Load literal address into byte of BL
0x00c5:     49               SABL               ; Subtract implicit AL and BL
0x00c6:     14 21            BZ   (PC+0x21)     ; Branch if equal to zero to 0x21 ahead PC (0x00e9)
0x00c8:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00cb:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00ce:     C0 03            LDBL #0349         ; Load literal address into byte of BL
0x00d0:     49               SABL               ; Subtract implicit AL and BL
0x00d1:     14 16            BZ   (PC+0x16)     ; Branch if equal to zero to 0x16 ahead PC (0x00e9)
0x00d3:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00d6:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00d9:     C0 04            LDBL #0449         ; Load literal address into byte of BL
0x00db:     49               SABL               ; Subtract implicit AL and BL
0x00dc:     14 0B            BZ   (PC+0x0B)     ; Branch if equal to zero to 0x0B ahead PC (0x00e9)
0x00de:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x00e1:     F1 08 C1         STBW 08C1          ; Store BW into direct address
0x00e4:     C0 06            LDBL #0649         ; Load literal address into byte of BL
0x00e6:     49               SABL               ; Subtract implicit AL and BL
0x00e7:     15 B9            BNZ  (PC-0x47)     ; Branch if not equal to zero to 0x47 behind PC (0x00a2)
0x00e9:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x00ec:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x00ed:     AE               SALC               ; Store byte from address in C into implicit AL
0x00ee:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x00f1:     C0 CE            LDBL #CE49         ; Load literal address into byte of BL
0x00f3:     49               SABL               ; Subtract implicit AL and BL
0x00f4:     14 5D            BZ   (PC+0x5D)     ; Branch if equal to zero to 0x5D ahead PC (0x0153)
0x00f6:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x00f8:     49               SABL               ; Subtract implicit AL and BL
0x00f9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x00fa:     00               HLT                ; Halts the CPU
0x00fb:     78 01 54         JSR  #0154         ; Jump to subroutine at literal address (not possible?)
0x00fe:     14 58            BZ   (PC+0x58)     ; Branch if equal to zero to 0x58 ahead PC (0x0158)
0x0100:     C0 D9            LDBL #D949         ; Load literal address into byte of BL
0x0102:     49               SABL               ; Subtract implicit AL and BL
0x0103:     15 E9            BNZ  (PC-0x17)     ; Branch if not equal to zero to 0x17 behind PC (0x00ee)
0x0105:     60 00 0F         LDXW #000F         ; Load literal word into word XW
0x0108:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x010b:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x010e:     80 52            LDAL #52A2         ; Load literal address into byte of AL
0x0110:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0113:     79 08 A5         JSR  08A5          ; Jump to subroutine at direct address
0x0116:     2A               CLAL               ; Clear byte of implicit AL register
0x0117:     82 02 5F         LDAL [025F]        ; Load indirect address into byte of AL
0x011a:     C0 0F            LDBL #0F4A         ; Load literal address into byte of BL
0x011c:     4A               NABL               ; AND implicit AL and BL
0x011d:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x011f:     C0 08            LDBL #084A         ; Load literal address into byte of BL
0x0121:     4A               NABL               ; AND implicit AL and BL
0x0122:     15 23            BNZ  (PC+0x23)     ; Branch if not equal to zero to 0x23 ahead PC (0x0147)
0x0124:     3F               DCX                ; Decrement word of implicit X register
0x0125:     14 20            BZ   (PC+0x20)     ; Branch if equal to zero to 0x20 ahead PC (0x0147)
0x0127:     C3 F7            LDBL (PC-0x09)     ; Load direct PC offset by N address into byte of BL
0x0129:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x012b:     10 04            BL   (PC+0x04)     ; Branch if link set to 0x04 ahead PC (0x0131)
0x012d:     E3 F1            STBL (PC-0x0f)     ; Store byte of BL into direct PC offset by N address
0x012f:     73 F0            JMP  (PC-0x10)     ; Jump to direct PC offset by N address  (0x0121)
0x0131:     80 08            LDAL #08A3         ; Load literal address into byte of AL
0x0133:     A3 EB            STAL (PC-0x15)     ; Store byte of AL into direct PC offset by N address
0x0135:     93 D2            LDAW (PC-0x2e)     ; Load direct PC offset by N address into word of AW
0x0137:     D0 00 02         LDBW #0002         ; Load literal address into byte of BW
0x013a:     59               SABW               ; Subtract implicit AW and BW
0x013b:     F3 CC            STBW (PC-0x34)     ; Store word of BW into direct PC offset by N address
0x013d:     93 CD            LDAW (PC-0x33)     ; Load direct PC offset by N address into word of AW
0x013f:     D0 00 02         LDBW #0002         ; Load literal address into byte of BW
0x0142:     59               SABW               ; Subtract implicit AW and BW
0x0143:     F3 C7            STBW (PC-0x39)     ; Store word of BW into direct PC offset by N address
0x0145:     73 C1            JMP  (PC-0x3f)     ; Jump to direct PC offset by N address  (0x0108)
0x0147:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0x0149:     A0 00 2A         STAL 002A          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x014c:     A0 00 28         STAL 0028          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x014f:     A1 05 42         STAL 0542          ; Store AL into direct address
0x0152:     A1 04 6E         STAL 046E          ; Store AL into direct address
0x0155:     71 02 E0         JMP  02E0          ; Jump to direct address
0x0158:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x015b:     09               RSR                ; return(cont=1) from Subroutine
0x015c:     AA               SALX               ; Store byte from address in XW into implicit AL
0x015d:     A1 02 A3         STAL 02A3          ; Store AL into direct address
0x0160:     32 20            CLR  BW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0162:     C0 0F            LDBL #0F49         ; Load literal address into byte of BL
0x0164:     49               SABL               ; Subtract implicit AL and BL
0x0165:     18 F1            BGZ  (PC-0x0f)     ; Branch if greater than zero to 0xf behind PC (0x0158)
0x0167:     D0 09 2A         LDBW #092A         ; Load literal address into byte of BW
0x016a:     58               AABW               ; Add implicit AW and BW
0x016b:     89               LALB               ; Load byte from address in BW into implicit AL
0x016c:     4D               XABL               ; Transfer implicit AL into BL
0x016d:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x016f:     14 E7            BZ   (PC-0x19)     ; Branch if equal to zero to 0x19 behind PC (0x0158)
0x0171:     C0 F0            LDBL #F04A         ; Load literal address into byte of BL
0x0173:     4A               NABL               ; AND implicit AL and BL
0x0174:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0176:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0177:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x0179:     00               HLT                ; Halts the CPU
0x017a:     00               HLT                ; Halts the CPU
0x017b:     00               HLT                ; Halts the CPU
0x017c:     00               HLT                ; Halts the CPU
0x017d:     00               HLT                ; Halts the CPU
0x017e:     00               HLT                ; Halts the CPU
0x017f:     00               HLT                ; Halts the CPU
0x0180:     00               HLT                ; Halts the CPU
0x0181:     00               HLT                ; Halts the CPU
0x0182:     00               HLT                ; Halts the CPU
0x0183:     00               HLT                ; Halts the CPU
0x0184:     00               HLT                ; Halts the CPU
0x0185:     00               HLT                ; Halts the CPU
0x0186:     00               HLT                ; Halts the CPU
0x0187:     00               HLT                ; Halts the CPU
0x0188:     00               HLT                ; Halts the CPU
0x0189:     00               HLT                ; Halts the CPU
0x018a:     00               HLT                ; Halts the CPU
0x018b:     00               HLT                ; Halts the CPU
0x018c:     00               HLT                ; Halts the CPU
0x018d:     00               HLT                ; Halts the CPU
0x018e:     00               HLT                ; Halts the CPU
0x018f:     00               HLT                ; Halts the CPU
0x0190:     00               HLT                ; Halts the CPU
0x0191:     78 01 00         JSR  #0100         ; Jump to subroutine at literal address (not possible?)
0x0194:     00               HLT                ; Halts the CPU
0x0195:     00               HLT                ; Halts the CPU
0x0196:     00               HLT                ; Halts the CPU
0x0197:     00               HLT                ; Halts the CPU
0x0198:     00               HLT                ; Halts the CPU
0x0199:     00               HLT                ; Halts the CPU
0x019a:     00               HLT                ; Halts the CPU
0x019b:     00               HLT                ; Halts the CPU
0x019c:     00               HLT                ; Halts the CPU
0x019d:     00               HLT                ; Halts the CPU
0x019e:     00               HLT                ; Halts the CPU
0x019f:     00               HLT                ; Halts the CPU
0x01a0:     00               HLT                ; Halts the CPU
0x01a1:     00               HLT                ; Halts the CPU
0x01a2:     00               HLT                ; Halts the CPU
0x01a3:     00               HLT                ; Halts the CPU
0x01a4:     00               HLT                ; Halts the CPU
0x01a5:     00               HLT                ; Halts the CPU
0x01a6:     00               HLT                ; Halts the CPU
0x01a7:     00               HLT                ; Halts the CPU
0x01a8:     00               HLT                ; Halts the CPU
0x01a9:     00               HLT                ; Halts the CPU
0x01aa:     00               HLT                ; Halts the CPU
0x01ab:     00               HLT                ; Halts the CPU
0x01ac:     00               HLT                ; Halts the CPU
0x01ad:     00               HLT                ; Halts the CPU
0x01ae:     00               HLT                ; Halts the CPU
0x01af:     00               HLT                ; Halts the CPU
0x01b0:     00               HLT                ; Halts the CPU
0x01b1:     00               HLT                ; Halts the CPU
0x01b2:     00               HLT                ; Halts the CPU
0x01b3:     00               HLT                ; Halts the CPU
0x01b4:     00               HLT                ; Halts the CPU
0x01b5:     00               HLT                ; Halts the CPU
0x01b6:     00               HLT                ; Halts the CPU
0x01b7:     00               HLT                ; Halts the CPU
0x01b8:     00               HLT                ; Halts the CPU
0x01b9:     00               HLT                ; Halts the CPU
0x01ba:     00               HLT                ; Halts the CPU
0x01bb:     00               HLT                ; Halts the CPU
0x01bc:     00               HLT                ; Halts the CPU
0x01bd:     00               HLT                ; Halts the CPU
0x01be:     00               HLT                ; Halts the CPU
0x01bf:     00               HLT                ; Halts the CPU
0x01c0:     00               HLT                ; Halts the CPU
0x01c1:     00               HLT                ; Halts the CPU
0x01c2:     00               HLT                ; Halts the CPU
0x01c3:     00               HLT                ; Halts the CPU
0x01c4:     00               HLT                ; Halts the CPU
0x01c5:     00               HLT                ; Halts the CPU
0x01c6:     00               HLT                ; Halts the CPU
0x01c7:     00               HLT                ; Halts the CPU
0x01c8:     00               HLT                ; Halts the CPU
0x01c9:     00               HLT                ; Halts the CPU
0x01ca:     00               HLT                ; Halts the CPU
0x01cb:     00               HLT                ; Halts the CPU
0x01cc:     00               HLT                ; Halts the CPU
0x01cd:     00               HLT                ; Halts the CPU
0x01ce:     00               HLT                ; Halts the CPU
0x01cf:     00               HLT                ; Halts the CPU
0x01d0:     00               HLT                ; Halts the CPU
0x01d1:     00               HLT                ; Halts the CPU
0x01d2:     00               HLT                ; Halts the CPU
0x01d3:     00               HLT                ; Halts the CPU
0x01d4:     00               HLT                ; Halts the CPU
0x01d5:     00               HLT                ; Halts the CPU
0x01d6:     00               HLT                ; Halts the CPU
0x01d7:     00               HLT                ; Halts the CPU
0x01d8:     00               HLT                ; Halts the CPU
0x01d9:     00               HLT                ; Halts the CPU
0x01da:     00               HLT                ; Halts the CPU
0x01db:     00               HLT                ; Halts the CPU
0x01dc:     00               HLT                ; Halts the CPU
0x01dd:     00               HLT                ; Halts the CPU
0x01de:     00               HLT                ; Halts the CPU
0x01df:     00               HLT                ; Halts the CPU
0x01e0:     00               HLT                ; Halts the CPU
0x01e1:     00               HLT                ; Halts the CPU
0x01e2:     00               HLT                ; Halts the CPU
0x01e3:     00               HLT                ; Halts the CPU
0x01e4:     00               HLT                ; Halts the CPU
0x01e5:     00               HLT                ; Halts the CPU
0x01e6:     00               HLT                ; Halts the CPU
0x01e7:     00               HLT                ; Halts the CPU
0x01e8:     00               HLT                ; Halts the CPU
0x01e9:     00               HLT                ; Halts the CPU
0x01ea:     00               HLT                ; Halts the CPU
0x01eb:     00               HLT                ; Halts the CPU
0x01ec:     00               HLT                ; Halts the CPU
0x01ed:     00               HLT                ; Halts the CPU
0x01ee:     00               HLT                ; Halts the CPU
0x01ef:     00               HLT                ; Halts the CPU
0x01f0:     00               HLT                ; Halts the CPU
0x01f1:     00               HLT                ; Halts the CPU
0x01f2:     00               HLT                ; Halts the CPU
0x01f3:     00               HLT                ; Halts the CPU
0x01f4:     00               HLT                ; Halts the CPU
0x01f5:     00               HLT                ; Halts the CPU
0x01f6:     00               HLT                ; Halts the CPU
0x01f7:     00               HLT                ; Halts the CPU
0x01f8:     80 83            LDAL #83A1         ; Load literal address into byte of AL
0x01fa:     A1 00 00         STAL 0000          ; Store AL into direct address
0x01fd:     3A               CLAW               ; Clear word of implicit AW register
0x01fe:     B1 00 2C         STAW 002C          ; Store AW into direct address
0x0201:     B1 00 6C         STAW 006C          ; Store AW into direct address
0x0204:     B1 00 AC         STAW 00AC          ; Store AW into direct address
0x0207:     B1 00 FC         STAW 00FC          ; Store AW into direct address
0x020a:     90 08 0D         LDAW #080D         ; Load literal address into byte of AW
0x020d:     00               HLT                ; Halts the CPU
0x020e:     78 01 78         JSR  #0178         ; Jump to subroutine at literal address (not possible?)
0x0211:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0212:     B1 00 FE         STAW 00FE          ; Store AW into direct address
0x0215:     90 01 64         LDAW #0164         ; Load literal address into byte of AW
0x0218:     A1 F8 01         STAL F801          ; Store AL into direct address
0x021b:     5F               XASW               ; Transfer implicit AW into SW
0x021c:     B1 00 00         STAW 0000          ; Store AW into direct address
0x021f:     90 0C 15         LDAW #0C15         ; Load literal address into byte of AW
0x0222:     B1 00 1E         STAW 001E          ; Store AW into direct address
0x0225:     04               EI                 ; Enable Interrupt system
0x0226:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0229:     09               RSR                ; return(cont=1) from Subroutine
0x022a:     4F               XASL               ; Transfer implicit AL into SL
0x022b:     90 F8 06         LDAW #F806         ; Load literal address into byte of AW
0x022e:     B1 02 5F         STAW 025F          ; Store AW into direct address
0x0231:     38               INAW               ; Increment word of implicit AW register
0x0232:     B1 02 62         STAW 0262          ; Store AW into direct address
0x0235:     3A               CLAW               ; Clear word of implicit AW register
0x0236:     A1 05 42         STAL 0542          ; Store AL into direct address
0x0239:     A1 04 6E         STAL 046E          ; Store AL into direct address
0x023c:     B1 39 11         STAW 3911          ; Store AW into direct address
0x023f:     80 08            LDAL #08A1         ; Load literal address into byte of AL
0x0241:     A1 02 76         STAL 0276          ; Store AL into direct address
0x0244:     90 55 55         LDAW #5555         ; Load literal address into byte of AW
0x0247:     5D               XABW               ; Transfer implicit AW into BW
0x0248:     B1 FF F0         STAW FFF0          ; Store AW into direct address
0x024b:     3A               CLAW               ; Clear word of implicit AW register
0x024c:     91 FF F0         LDAW FFF0          ; Load direct address into byte of AW
0x024f:     59               SABW               ; Subtract implicit AW and BW
0x0250:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x0255)
0x0252:     2A               CLAL               ; Clear byte of implicit AL register
0x0253:     73 02            JMP  (PC+0x02)     ; Jump to direct PC offset by N address  (0x0257)
0x0255:     80 01            LDAL #01A1         ; Load literal address into byte of AL
0x0257:     A1 07 62         STAL 0762          ; Store AL into direct address
0x025a:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x025d:     09               RSR                ; return(cont=1) from Subroutine
0x025e:     7C 79            JSR  [PC+0x79]     ; Jump to to subroutine at indirect PC offset by N address
0x0260:     00               HLT                ; Halts the CPU
0x0261:     00               HLT                ; Halts the CPU
0x0262:     C0 CC            LDBL #CC49         ; Load literal address into byte of BL
0x0264:     49               SABL               ; Subtract implicit AL and BL
0x0265:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x026a)
0x0267:     71 09 28         JMP  0928          ; Jump to direct address
0x026a:     A1 08 C3         STAL 08C3          ; Store AL into direct address
0x026d:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0270:     81 08 C3         LDAL 08C3          ; Load direct address into byte of AL
0x0273:     C0 C2            LDBL #C249         ; Load literal address into byte of BL
0x0275:     49               SABL               ; Subtract implicit AL and BL
0x0276:     E1 08 C3         STBL 08C3          ; Store BL into direct address
0x0279:     14 1B            BZ   (PC+0x1B)     ; Branch if equal to zero to 0x1B ahead PC (0x0296)
0x027b:     C0 01            LDBL #01E1         ; Load literal address into byte of BL
0x027d:     E1 08 C3         STBL 08C3          ; Store BL into direct address
0x0280:     C0 C3            LDBL #C349         ; Load literal address into byte of BL
0x0282:     49               SABL               ; Subtract implicit AL and BL
0x0283:     14 58            BZ   (PC+0x58)     ; Branch if equal to zero to 0x58 ahead PC (0x02dd)
0x0285:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x0287:     49               SABL               ; Subtract implicit AL and BL
0x0288:     14 1E            BZ   (PC+0x1E)     ; Branch if equal to zero to 0x1E ahead PC (0x02a8)
0x028a:     00               HLT                ; Halts the CPU
0x028b:     78 01 F0         JSR  #01F0         ; Jump to subroutine at literal address (not possible?)
0x028e:     53 C0            ORI  C ,  AW       ; OR word of two explicit registers (L OR R stored in L)
0x0290:     FF               SBWP               ; Store word from address in P into implicit BW
0x0291:     E1 08 C3         STBL 08C3          ; Store BL into direct address
0x0294:     C0 D0            LDBL #D049         ; Load literal address into byte of BL
0x0296:     49               SABL               ; Subtract implicit AL and BL
0x0297:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x029b)
0x0299:     73 C4            JMP  (PC-0x3c)     ; Jump to direct PC offset by N address  (0x025f)
0x029b:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x029e:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x029f:     9B               LAWY               ; Load word from address in YW into implicit AW
0x02a0:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02a3:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02a6:     C0 00            LDBL #0049         ; Load literal address into byte of BL
0x02a8:     49               SABL               ; Subtract implicit AL and BL
0x02a9:     14 37            BZ   (PC+0x37)     ; Branch if equal to zero to 0x37 ahead PC (0x02e2)
0x02ab:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02ae:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02b1:     C0 01            LDBL #0149         ; Load literal address into byte of BL
0x02b3:     49               SABL               ; Subtract implicit AL and BL
0x02b4:     14 2C            BZ   (PC+0x2C)     ; Branch if equal to zero to 0x2C ahead PC (0x02e2)
0x02b6:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02b9:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02bc:     C0 02            LDBL #0249         ; Load literal address into byte of BL
0x02be:     49               SABL               ; Subtract implicit AL and BL
0x02bf:     14 21            BZ   (PC+0x21)     ; Branch if equal to zero to 0x21 ahead PC (0x02e2)
0x02c1:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02c4:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02c7:     C0 03            LDBL #0349         ; Load literal address into byte of BL
0x02c9:     49               SABL               ; Subtract implicit AL and BL
0x02ca:     14 16            BZ   (PC+0x16)     ; Branch if equal to zero to 0x16 ahead PC (0x02e2)
0x02cc:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02cf:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02d2:     C0 04            LDBL #0449         ; Load literal address into byte of BL
0x02d4:     49               SABL               ; Subtract implicit AL and BL
0x02d5:     14 0B            BZ   (PC+0x0B)     ; Branch if equal to zero to 0x0B ahead PC (0x02e2)
0x02d7:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x02da:     F1 08 D6         STBW 08D6          ; Store BW into direct address
0x02dd:     C0 06            LDBL #0649         ; Load literal address into byte of BL
0x02df:     49               SABL               ; Subtract implicit AL and BL
0x02e0:     15 B9            BNZ  (PC-0x47)     ; Branch if not equal to zero to 0x47 behind PC (0x029b)
0x02e2:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x02e5:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x02e6:     C3 79            LDBL (PC+0x79)     ; Load direct PC offset by N address into byte of BL
0x02e8:     00               HLT                ; Halts the CPU
0x02e9:     00               HLT                ; Halts the CPU
0x02ea:     C0 CE            LDBL #CE49         ; Load literal address into byte of BL
0x02ec:     49               SABL               ; Subtract implicit AL and BL
0x02ed:     14 5D            BZ   (PC+0x5D)     ; Branch if equal to zero to 0x5D ahead PC (0x034c)
0x02ef:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x02f1:     49               SABL               ; Subtract implicit AL and BL
0x02f2:     14 58            BZ   (PC+0x58)     ; Branch if equal to zero to 0x58 ahead PC (0x034c)
0x02f4:     C0 D9            LDBL #D949         ; Load literal address into byte of BL
0x02f6:     49               SABL               ; Subtract implicit AL and BL
0x02f7:     15 E9            BNZ  (PC-0x17)     ; Branch if not equal to zero to 0x17 behind PC (0x02e2)
0x02f9:     60 00 0F         LDXW #000F         ; Load literal word into word XW
0x02fc:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x02ff:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x0302:     80 52            LDAL #52A2         ; Load literal address into byte of AL
0x0304:     A2 02 CE         STAL [02CE]        ; Store AL into indirect address
0x0307:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x0309:     00               HLT                ; Halts the CPU
0x030a:     00               HLT                ; Halts the CPU
0x030b:     00               HLT                ; Halts the CPU
0x030c:     00               HLT                ; Halts the CPU
0x030d:     00               HLT                ; Halts the CPU
0x030e:     00               HLT                ; Halts the CPU
0x030f:     00               HLT                ; Halts the CPU
0x0310:     00               HLT                ; Halts the CPU
0x0311:     00               HLT                ; Halts the CPU
0x0312:     00               HLT                ; Halts the CPU
0x0313:     00               HLT                ; Halts the CPU
0x0314:     00               HLT                ; Halts the CPU
0x0315:     00               HLT                ; Halts the CPU
0x0316:     00               HLT                ; Halts the CPU
0x0317:     00               HLT                ; Halts the CPU
0x0318:     00               HLT                ; Halts the CPU
0x0319:     00               HLT                ; Halts the CPU
0x031a:     00               HLT                ; Halts the CPU
0x031b:     00               HLT                ; Halts the CPU
0x031c:     00               HLT                ; Halts the CPU
0x031d:     00               HLT                ; Halts the CPU
0x031e:     00               HLT                ; Halts the CPU
0x031f:     00               HLT                ; Halts the CPU
0x0320:     00               HLT                ; Halts the CPU
0x0321:     78 02 68         JSR  #0268         ; Jump to subroutine at literal address (not possible?)
0x0324:     5F               XASW               ; Transfer implicit AW into SW
0x0325:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0328:     2A               CLAL               ; Clear byte of implicit AL register
0x0329:     82 02 5F         LDAL [025F]        ; Load indirect address into byte of AL
0x032c:     C0 0F            LDBL #0F4A         ; Load literal address into byte of BL
0x032e:     4A               NABL               ; AND implicit AL and BL
0x032f:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x0331:     C0 08            LDBL #084A         ; Load literal address into byte of BL
0x0333:     4A               NABL               ; AND implicit AL and BL
0x0334:     15 23            BNZ  (PC+0x23)     ; Branch if not equal to zero to 0x23 ahead PC (0x0359)
0x0336:     3F               DCX                ; Decrement word of implicit X register
0x0337:     14 20            BZ   (PC+0x20)     ; Branch if equal to zero to 0x20 ahead PC (0x0359)
0x0339:     C3 F7            LDBL (PC-0x09)     ; Load direct PC offset by N address into byte of BL
0x033b:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x033d:     10 04            BL   (PC+0x04)     ; Branch if link set to 0x04 ahead PC (0x0343)
0x033f:     E3 F1            STBL (PC-0x0f)     ; Store byte of BL into direct PC offset by N address
0x0341:     73 F0            JMP  (PC-0x10)     ; Jump to direct PC offset by N address  (0x0333)
0x0343:     80 08            LDAL #08A3         ; Load literal address into byte of AL
0x0345:     A3 EB            STAL (PC-0x15)     ; Store byte of AL into direct PC offset by N address
0x0347:     93 D2            LDAW (PC-0x2e)     ; Load direct PC offset by N address into word of AW
0x0349:     D0 00 02         LDBW #0002         ; Load literal address into byte of BW
0x034c:     59               SABW               ; Subtract implicit AW and BW
0x034d:     F3 CC            STBW (PC-0x34)     ; Store word of BW into direct PC offset by N address
0x034f:     93 CD            LDAW (PC-0x33)     ; Load direct PC offset by N address into word of AW
0x0351:     D0 00 02         LDBW #0002         ; Load literal address into byte of BW
0x0354:     59               SABW               ; Subtract implicit AW and BW
0x0355:     F3 C7            STBW (PC-0x39)     ; Store word of BW into direct PC offset by N address
0x0357:     73 C1            JMP  (PC-0x3f)     ; Jump to direct PC offset by N address  (0x031a)
0x0359:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0x035b:     A0 00 2A         STAL 002A          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x035e:     A0 00 28         STAL 0028          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0361:     A1 05 42         STAL 0542          ; Store AL into direct address
0x0364:     A1 04 6E         STAL 046E          ; Store AL into direct address
0x0367:     71 02 E0         JMP  02E0          ; Jump to direct address
0x036a:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x036d:     09               RSR                ; return(cont=1) from Subroutine
0x036e:     BF               SAWP               ; Store word from address in P into implicit AW
0x036f:     A1 02 A3         STAL 02A3          ; Store AL into direct address
0x0372:     32 20            CLR  BW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0374:     C0 0F            LDBL #0F49         ; Load literal address into byte of BL
0x0376:     49               SABL               ; Subtract implicit AL and BL
0x0377:     18 F1            BGZ  (PC-0x0f)     ; Branch if greater than zero to 0xf behind PC (0x036a)
0x0379:     D0 09 3F         LDBW #093F         ; Load literal address into byte of BW
0x037c:     58               AABW               ; Add implicit AW and BW
0x037d:     89               LALB               ; Load byte from address in BW into implicit AL
0x037e:     4D               XABL               ; Transfer implicit AL into BL
0x037f:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x0381:     14 E7            BZ   (PC-0x19)     ; Branch if equal to zero to 0x19 behind PC (0x036a)
0x0383:     C0 F0            LDBL #F04A         ; Load literal address into byte of BL
0x0385:     4A               NABL               ; AND implicit AL and BL
0x0386:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0388:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x038a:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x038c:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x038e:     E1 02 60         STBL 0260          ; Store BL into direct address
0x0391:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x0393:     E1 02 63         STBL 0263          ; Store BL into direct address
0x0396:     C0 0F            LDBL #0F4A         ; Load literal address into byte of BL
0x0398:     4A               NABL               ; AND implicit AL and BL
0x0399:     E1 07 82         STBL 0782          ; Store BL into direct address
0x039c:     4E               XAZL               ; Transfer implicit AL into ZL
0x039d:     00               HLT                ; Halts the CPU
0x039e:     78 02 E0         JSR  #02E0         ; Jump to subroutine at literal address (not possible?)
0x03a1:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x03a4:     09               RSR                ; return(cont=1) from Subroutine
0x03a5:     DB               LBWY               ; Load byte from address in YW into implicit BW
0x03a6:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x03a9:     A3 23            STAL (PC+0x23)     ; Store byte of AL into direct PC offset by N address
0x03ab:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x03ae:     83 1E            LDAL (PC+0x1E)     ; Load direct PC offset by N address into byte of AL
0x03b0:     C0 D3            LDBL #D349         ; Load literal address into byte of BL
0x03b2:     49               SABL               ; Subtract implicit AL and BL
0x03b3:     E1 03 C5         STBL 03C5          ; Store BL into direct address
0x03b6:     14 15            BZ   (PC+0x15)     ; Branch if equal to zero to 0x15 ahead PC (0x03cd)
0x03b8:     C0 C4            LDBL #C449         ; Load literal address into byte of BL
0x03ba:     49               SABL               ; Subtract implicit AL and BL
0x03bb:     E1 03 0D         STBL 030D          ; Store BL into direct address
0x03be:     14 0D            BZ   (PC+0x0D)     ; Branch if equal to zero to 0x0D ahead PC (0x03cd)
0x03c0:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x03c2:     49               SABL               ; Subtract implicit AL and BL
0x03c3:     14 08            BZ   (PC+0x08)     ; Branch if equal to zero to 0x08 ahead PC (0x03cd)
0x03c5:     C0 C8            LDBL #C849         ; Load literal address into byte of BL
0x03c7:     49               SABL               ; Subtract implicit AL and BL
0x03c8:     15 D7            BNZ  (PC-0x29)     ; Branch if not equal to zero to 0x29 behind PC (0x03a1)
0x03ca:     71 06 E4         JMP  06E4          ; Jump to direct address
0x03cd:     80 00            LDAL #0015         ; Load literal address into byte of AL
0x03cf:     15 12            BNZ  (PC+0x12)     ; Branch if not equal to zero to 0x12 ahead PC (0x03e3)
0x03d1:     79 05 63         JSR  0563          ; Jump to subroutine at direct address
0x03d4:     0A               RI                 ; return(cont=1) from Interrupt
0x03d5:     28               INAL               ; Increment byte of implicit AL register
0x03d6:     D1 05 70         LDBW 0570          ; Load direct address into byte of BW
0x03d9:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x03de)
0x03db:     80 4C            LDAL #4CA1         ; Load literal address into byte of AL
0x03dd:     A1 04 BC         STAL 04BC          ; Store AL into direct address
0x03e0:     71 03 C4         JMP  03C4          ; Jump to direct address
0x03e3:     79 05 63         JSR  0563          ; Jump to subroutine at direct address
0x03e6:     0A               RI                 ; return(cont=1) from Interrupt
0x03e7:     3D               SLAW               ; Shift word of implicit AW register right
0x03e8:     D1 05 70         LDBW 0570          ; Load direct address into byte of BW
0x03eb:     15 02            BNZ  (PC+0x02)     ; Branch if not equal to zero to 0x02 ahead PC (0x03ef)
0x03ed:     80 01            LDAL #01A0         ; Load literal address into byte of AL
0x03ef:     A0 00 79         STAL 0079          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x03f2:     05               DI                 ; Disable Interrupt system
0x03f3:     63 0A            LDXW (PC+0x0A)     ; Load direct PC offset by N address into word XW
0x03f5:     55 D1            MEM? MD,  M1       ; Odd register means operation on memory
0x03f7:     05               DI                 ; Disable Interrupt system
0x03f8:     70 15 02         JMP  #1502         ; Jump to literal address (not possible?)
0x03fb:     80 4C            LDAL #4CC1         ; Load literal address into byte of AL
0x03fd:     C1 03 2F         LDBL 032F          ; Load direct address into byte of BL
0x0400:     49               SABL               ; Subtract implicit AL and BL
0x0401:     11 E0            BNL  (PC-0x20)     ; Branch if link not set to 0x20 behind PC (0x03e3)
0x0403:     A0 00 79         STAL 0079          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0406:     00               HLT                ; Halts the CPU
0x0407:     00               HLT                ; Halts the CPU
0x0408:     0A               RI                 ; return(cont=1) from Interrupt
0x0409:     6D 79 00         STXW, 9, 0x00   ; Store XW into index mode register (view supplemental material)
0x040c:     00               HLT                ; Halts the CPU
0x040d:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x040f:     49               SABL               ; Subtract implicit AL and BL
0x0410:     15 02            BNZ  (PC+0x02)     ; Branch if not equal to zero to 0x02 ahead PC (0x0414)
0x0412:     80 D2            LDAL #D2A3         ; Load literal address into byte of AL
0x0414:     A3 06            STAL (PC+0x06)     ; Store byte of AL into direct PC offset by N address
0x0416:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0419:     B6               ???                ; Writes -1 to AH at interrupt level 1. See instructions C6 and 1F
0x041a:     00               HLT                ; Halts the CPU
0x041b:     78 03 58         JSR  #0358         ; Jump to subroutine at literal address (not possible?)
0x041e:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0420:     80 00            LDAL #00C0         ; Load literal address into byte of AL
0x0422:     C0 C1            LDBL #C149         ; Load literal address into byte of BL
0x0424:     49               SABL               ; Subtract implicit AL and BL
0x0425:     14 54            BZ   (PC+0x54)     ; Branch if equal to zero to 0x54 ahead PC (0x047b)
0x0427:     3E               INX                ; Increment word of implicit X register
0x0428:     C0 C4            LDBL #C449         ; Load literal address into byte of BL
0x042a:     49               SABL               ; Subtract implicit AL and BL
0x042b:     14 4E            BZ   (PC+0x4E)     ; Branch if equal to zero to 0x4E ahead PC (0x047b)
0x042d:     3E               INX                ; Increment word of implicit X register
0x042e:     C0 D2            LDBL #D249         ; Load literal address into byte of BL
0x0430:     49               SABL               ; Subtract implicit AL and BL
0x0431:     14 48            BZ   (PC+0x48)     ; Branch if equal to zero to 0x48 ahead PC (0x047b)
0x0433:     3E               INX                ; Increment word of implicit X register
0x0434:     C0 D5            LDBL #D549         ; Load literal address into byte of BL
0x0436:     49               SABL               ; Subtract implicit AL and BL
0x0437:     14 42            BZ   (PC+0x42)     ; Branch if equal to zero to 0x42 ahead PC (0x047b)
0x0439:     3E               INX                ; Increment word of implicit X register
0x043a:     C0 C3            LDBL #C349         ; Load literal address into byte of BL
0x043c:     49               SABL               ; Subtract implicit AL and BL
0x043d:     14 3C            BZ   (PC+0x3C)     ; Branch if equal to zero to 0x3C ahead PC (0x047b)
0x043f:     C0 CD            LDBL #CD49         ; Load literal address into byte of BL
0x0441:     49               SABL               ; Subtract implicit AL and BL
0x0442:     15 C6            BNZ  (PC-0x3a)     ; Branch if not equal to zero to 0x3a behind PC (0x040a)
0x0444:     79 05 63         JSR  0563          ; Jump to subroutine at direct address
0x0447:     0A               RI                 ; return(cont=1) from Interrupt
0x0448:     28               INAL               ; Increment byte of implicit AL register
0x0449:     D1 05 70         LDBW 0570          ; Load direct address into byte of BW
0x044c:     14 19            BZ   (PC+0x19)     ; Branch if equal to zero to 0x19 ahead PC (0x0467)
0x044e:     C1 03 2F         LDBL 032F          ; Load direct address into byte of BL
0x0451:     49               SABL               ; Subtract implicit AL and BL
0x0452:     11 08            BNL  (PC+0x08)     ; Branch if link not set to 0x08 ahead PC (0x045c)
0x0454:     C1 03 43         LDBL 0343          ; Load direct address into byte of BL
0x0457:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x0459:     49               SABL               ; Subtract implicit AL and BL
0x045a:     11 07            BNL  (PC+0x07)     ; Branch if link not set to 0x07 ahead PC (0x0463)
0x045c:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x045f:     0A               RI                 ; return(cont=1) from Interrupt
0x0460:     95 73            LDAW, 3         ; Load index mode register address into AW (view supplemental material)
0x0462:     E1 A5 A2         STBL A5A2          ; Store BL into direct address
0x0465:     73 DD            JMP  (PC-0x23)     ; Jump to direct PC offset by N address  (0x0444)
0x0467:     80 FF            LDAL #FFA5         ; Load literal address into byte of AL
0x0469:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0x046b:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x046d:     90 01 64         LDAW #0164         ; Load literal address into byte of AW
0x0470:     51 A0            SUB  SW,  AW       ; Subtract word of two explicit registers (L - R stored in L)
0x0472:     14 96            BZ   (PC-0x6a)     ; Branch if equal to zero to 0x6a behind PC (0x040a)
0x0474:     31 A0            DCR  SW, 0         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0476:     90 05 DA         LDAW #05DA         ; Load literal address into byte of AW
0x0479:     73 08            JMP  (PC+0x08)     ; Jump to direct PC offset by N address  (0x0483)
0x047b:     35 40            SLR  X,  0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x047d:     D0 05 4F         LDBW #054F         ; Load literal address into byte of BW
0x0480:     50 42            ADD  X ,  BW       ; Add word of two explicit registers (L + R stored in L)
0x0482:     99               LAWB               ; Load word from address in BW into implicit AW
0x0483:     B1 04 B9         STAW 04B9          ; Store AW into direct address
0x0486:     3A               CLAW               ; Clear word of implicit AW register
0x0487:     71 03 1C         JMP  031C          ; Jump to direct address
0x048a:     80 00            LDAL #0014         ; Load literal address into byte of AL
0x048c:     14 67            BZ   (PC+0x67)     ; Branch if equal to zero to 0x67 ahead PC (0x04f5)
0x048e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0491:     0A               RI                 ; return(cont=1) from Interrupt
0x0492:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0493:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0496:     41 80            SUB  ZH,  AH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0498:     00               HLT                ; Halts the CPU
0x0499:     00               HLT                ; Halts the CPU
0x049a:     00               HLT                ; Halts the CPU
0x049b:     00               HLT                ; Halts the CPU
0x049c:     00               HLT                ; Halts the CPU
0x049d:     00               HLT                ; Halts the CPU
0x049e:     00               HLT                ; Halts the CPU
0x049f:     00               HLT                ; Halts the CPU
0x04a0:     00               HLT                ; Halts the CPU
0x04a1:     00               HLT                ; Halts the CPU
0x04a2:     00               HLT                ; Halts the CPU
0x04a3:     00               HLT                ; Halts the CPU
0x04a4:     00               HLT                ; Halts the CPU
0x04a5:     00               HLT                ; Halts the CPU
0x04a6:     00               HLT                ; Halts the CPU
0x04a7:     00               HLT                ; Halts the CPU
0x04a8:     00               HLT                ; Halts the CPU
0x04a9:     00               HLT                ; Halts the CPU
0x04aa:     00               HLT                ; Halts the CPU
0x04ab:     00               HLT                ; Halts the CPU
0x04ac:     00               HLT                ; Halts the CPU
0x04ad:     00               HLT                ; Halts the CPU
0x04ae:     00               HLT                ; Halts the CPU
0x04af:     00               HLT                ; Halts the CPU
0x04b0:     00               HLT                ; Halts the CPU
0x04b1:     78 03 D0         JSR  #03D0         ; Jump to subroutine at literal address (not possible?)
0x04b4:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x04b6:     49               SABL               ; Subtract implicit AL and BL
0x04b7:     15 02            BNZ  (PC+0x02)     ; Branch if not equal to zero to 0x02 ahead PC (0x04bb)
0x04b9:     80 D8            LDAL #D8A3         ; Load literal address into byte of AL
0x04bb:     A3 06            STAL (PC+0x06)     ; Store byte of AL into direct PC offset by N address
0x04bd:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x04c0:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x04c2:     80 00            LDAL #00C0         ; Load literal address into byte of AL
0x04c4:     C0 C1            LDBL #C149         ; Load literal address into byte of BL
0x04c6:     49               SABL               ; Subtract implicit AL and BL
0x04c7:     14 1A            BZ   (PC+0x1A)     ; Branch if equal to zero to 0x1A ahead PC (0x04e3)
0x04c9:     3E               INX                ; Increment word of implicit X register
0x04ca:     C0 D2            LDBL #D249         ; Load literal address into byte of BL
0x04cc:     49               SABL               ; Subtract implicit AL and BL
0x04cd:     14 14            BZ   (PC+0x14)     ; Branch if equal to zero to 0x14 ahead PC (0x04e3)
0x04cf:     3E               INX                ; Increment word of implicit X register
0x04d0:     C0 DA            LDBL #DA49         ; Load literal address into byte of BL
0x04d2:     49               SABL               ; Subtract implicit AL and BL
0x04d3:     14 0E            BZ   (PC+0x0E)     ; Branch if equal to zero to 0x0E ahead PC (0x04e3)
0x04d5:     3E               INX                ; Increment word of implicit X register
0x04d6:     C0 D8            LDBL #D849         ; Load literal address into byte of BL
0x04d8:     49               SABL               ; Subtract implicit AL and BL
0x04d9:     14 08            BZ   (PC+0x08)     ; Branch if equal to zero to 0x08 ahead PC (0x04e3)
0x04db:     73 04            JMP  (PC+0x04)     ; Jump to direct PC offset by N address  (0x04e1)
0x04dd:     3E               INX                ; Increment word of implicit X register
0x04de:     C0 C6            LDBL #C649         ; Load literal address into byte of BL
0x04e0:     49               SABL               ; Subtract implicit AL and BL
0x04e1:     15 C5            BNZ  (PC-0x3b)     ; Branch if not equal to zero to 0x3b behind PC (0x04a8)
0x04e3:     35 40            SLR  X,  0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x04e5:     D0 05 59         LDBW #0559         ; Load literal address into byte of BW
0x04e8:     50 42            ADD  X ,  BW       ; Add word of two explicit registers (L + R stored in L)
0x04ea:     99               LAWB               ; Load word from address in BW into implicit AW
0x04eb:     B1 04 DA         STAW 04DA          ; Store AW into direct address
0x04ee:     73 17            JMP  (PC+0x17)     ; Jump to direct PC offset by N address  (0x0507)
0x04f0:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x04f3:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x04f4:     15 79            BNZ  (PC+0x79)     ; Branch if not equal to zero to 0x79 ahead PC (0x056f)
0x04f6:     00               HLT                ; Halts the CPU
0x04f7:     00               HLT                ; Halts the CPU
0x04f8:     C0 D7            LDBL #D749         ; Load literal address into byte of BL
0x04fa:     49               SABL               ; Subtract implicit AL and BL
0x04fb:     14 0A            BZ   (PC+0x0A)     ; Branch if equal to zero to 0x0A ahead PC (0x0507)
0x04fd:     C0 C9            LDBL #C949         ; Load literal address into byte of BL
0x04ff:     49               SABL               ; Subtract implicit AL and BL
0x0500:     14 0C            BZ   (PC+0x0C)     ; Branch if equal to zero to 0x0C ahead PC (0x050e)
0x0502:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x0504:     49               SABL               ; Subtract implicit AL and BL
0x0505:     15 E7            BNZ  (PC-0x19)     ; Branch if not equal to zero to 0x19 behind PC (0x04ee)
0x0507:     80 00            LDAL #00A1         ; Load literal address into byte of AL
0x0509:     A1 07 A7         STAL 07A7          ; Store AL into direct address
0x050c:     73 05            JMP  (PC+0x05)     ; Jump to direct PC offset by N address  (0x0513)
0x050e:     80 01            LDAL #01A1         ; Load literal address into byte of AL
0x0510:     A1 07 A7         STAL 07A7          ; Store AL into direct address
0x0513:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0516:     0A               RI                 ; return(cont=1) from Interrupt
0x0517:     E7               ???                ; Unknown. Illegal?
0x0518:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x051b:     C0 CE            LDBL #CE49         ; Load literal address into byte of BL
0x051d:     49               SABL               ; Subtract implicit AL and BL
0x051e:     E1 05 49         STBL 0549          ; Store BL into direct address
0x0521:     14 1D            BZ   (PC+0x1D)     ; Branch if equal to zero to 0x1D ahead PC (0x0540)
0x0523:     C0 D9            LDBL #D949         ; Load literal address into byte of BL
0x0525:     49               SABL               ; Subtract implicit AL and BL
0x0526:     14 18            BZ   (PC+0x18)     ; Branch if equal to zero to 0x18 ahead PC (0x0540)
0x0528:     C0 D4            LDBL #D449         ; Load literal address into byte of BL
0x052a:     49               SABL               ; Subtract implicit AL and BL
0x052b:     14 DC            BZ   (PC-0x24)     ; Branch if equal to zero to 0x24 behind PC (0x0509)
0x052d:     00               HLT                ; Halts the CPU
0x052e:     78 04 48         JSR  #0448         ; Jump to subroutine at literal address (not possible?)
0x0531:     02               SF                 ; Set Fault
0x0532:     73 E4            JMP  (PC-0x1c)     ; Jump to direct PC offset by N address  (0x0518)
0x0534:     92 00 3A         LDAW [003A]        ; Load indirect address into byte of AW
0x0537:     D0 05 14         LDBW #0514         ; Load literal address into byte of BW
0x053a:     59               SABW               ; Subtract implicit AW and BW
0x053b:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x0540)
0x053d:     72 00 3A         JMP  [003A]        ; Jump to indirect address
0x0540:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0543:     0A               RI                 ; return(cont=1) from Interrupt
0x0544:     F3 81            STBW (PC-0x7f)     ; Store word of BW into direct PC offset by N address
0x0546:     F2 00 2C         STBW [002C]        ; Store BW into indirect address
0x0549:     11 0B            BNL  (PC+0x0B)     ; Branch if link not set to 0x0B ahead PC (0x0556)
0x054b:     81 F2 01         LDAL F201          ; Load direct address into byte of AL
0x054e:     C0 03            LDBL #0349         ; Load literal address into byte of BL
0x0550:     49               SABL               ; Subtract implicit AL and BL
0x0551:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x0556)
0x0553:     71 01 64         JMP  0164          ; Jump to direct address
0x0556:     80 00            LDAL #0014         ; Load literal address into byte of AL
0x0558:     14 40            BZ   (PC+0x40)     ; Branch if equal to zero to 0x40 ahead PC (0x059a)
0x055a:     81 05 42         LDAL 0542          ; Load direct address into byte of AL
0x055d:     14 3B            BZ   (PC+0x3B)     ; Branch if equal to zero to 0x3B ahead PC (0x059a)
0x055f:     3A               CLAW               ; Clear word of implicit AW register
0x0560:     A1 05 42         STAL 0542          ; Store AL into direct address
0x0563:     81 02 A3         LDAL 02A3          ; Load direct address into byte of AL
0x0566:     29               DCAL               ; Decrement byte of implicit AL register
0x0567:     17 03            BP   (PC+0x03)     ; Branch on positive to 0x03 ahead PC (0x056c)
0x0569:     81 02 A0         LDAL 02A0          ; Load direct address into byte of AL
0x056c:     A1 02 A3         STAL 02A3          ; Store AL into direct address
0x056f:     D0 09 3F         LDBW #093F         ; Load literal address into byte of BW
0x0572:     58               AABW               ; Add implicit AW and BW
0x0573:     89               LALB               ; Load byte from address in BW into implicit AL
0x0574:     4D               XABL               ; Transfer implicit AL into BL
0x0575:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x0577:     14 CC            BZ   (PC-0x34)     ; Branch if equal to zero to 0x34 behind PC (0x0545)
0x0579:     A1 09 3E         STAL 093E          ; Store AL into direct address
0x057c:     C0 F0            LDBL #F04A         ; Load literal address into byte of BL
0x057e:     4A               NABL               ; AND implicit AL and BL
0x057f:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0581:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0583:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0585:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x0587:     E1 02 60         STBL 0260          ; Store BL into direct address
0x058a:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x058c:     E1 02 63         STBL 0263          ; Store BL into direct address
0x058f:     81 09 3E         LDAL 093E          ; Load direct address into byte of AL
0x0592:     C0 0F            LDBL #0F4A         ; Load literal address into byte of BL
0x0594:     4A               NABL               ; AND implicit AL and BL
0x0595:     E1 07 82         STBL 0782          ; Store BL into direct address
0x0598:     73 00            JMP  (PC+0x00)     ; Jump to direct PC offset by N address  (0x059a)
0x059a:     81 03 0D         LDAL 030D          ; Load direct address into byte of AL
0x059d:     15 02            BNZ  (PC+0x02)     ; Branch if not equal to zero to 0x02 ahead PC (0x05a1)
0x059f:     73 05            JMP  (PC+0x05)     ; Jump to direct PC offset by N address  (0x05a6)
0x05a1:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x05a4:     A0 00 81         STAL 0081          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x05a7:     03               RF                 ; Reset Fault
0x05a8:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x05aa:     00               HLT                ; Halts the CPU
0x05ab:     78 04 C0         JSR  #04C0         ; Jump to subroutine at literal address (not possible?)
0x05ae:     15 0E            BNZ  (PC+0x0E)     ; Branch if not equal to zero to 0x0E ahead PC (0x05be)
0x05b0:     79 07 A6         JSR  07A6          ; Jump to subroutine at direct address
0x05b3:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x05b6:     79 08 05         JSR  0805          ; Jump to subroutine at direct address
0x05b9:     79 08 44         JSR  0844          ; Jump to subroutine at direct address
0x05bc:     73 71            JMP  (PC+0x71)     ; Jump to direct PC offset by N address  (0x062f)
0x05be:     81 07 A7         LDAL 07A7          ; Load direct address into byte of AL
0x05c1:     15 23            BNZ  (PC+0x23)     ; Branch if not equal to zero to 0x23 ahead PC (0x05e6)
0x05c3:     90 0C B7         LDAW #0CB7         ; Load literal address into byte of AW
0x05c6:     5C               XAYW               ; Transfer implicit AW into YW
0x05c7:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x05ca:     80 91            LDAL #91A1         ; Load literal address into byte of AL
0x05cc:     A1 0C 1B         STAL 0C1B          ; Store AL into direct address
0x05cf:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x05d2:     80 8E            LDAL #8EA1         ; Load literal address into byte of AL
0x05d4:     A1 0C 1B         STAL 0C1B          ; Store AL into direct address
0x05d7:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x05da:     73 53            JMP  (PC+0x53)     ; Jump to direct PC offset by N address  (0x062f)
0x05dc:     80 88            LDAL #88A1         ; Load literal address into byte of AL
0x05de:     A1 0C 1B         STAL 0C1B          ; Store AL into direct address
0x05e1:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x05e4:     73 49            JMP  (PC+0x49)     ; Jump to direct PC offset by N address  (0x062f)
0x05e6:     90 2B F7         LDAW #2BF7         ; Load literal address into byte of AW
0x05e9:     5C               XAYW               ; Transfer implicit AW into YW
0x05ea:     7A 04 DA         JSR  [04DA]        ; Jump to subroutine at indirect address
0x05ed:     80 86            LDAL #86A1         ; Load literal address into byte of AL
0x05ef:     A1 0C 83         STAL 0C83          ; Store AL into direct address
0x05f2:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x05f5:     80 85            LDAL #85A1         ; Load literal address into byte of AL
0x05f7:     A1 0C 83         STAL 0C83          ; Store AL into direct address
0x05fa:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x05fd:     73 30            JMP  (PC+0x30)     ; Jump to direct PC offset by N address  (0x062f)
0x05ff:     80 84            LDAL #84A1         ; Load literal address into byte of AL
0x0601:     A1 0C 83         STAL 0C83          ; Store AL into direct address
0x0604:     79 07 93         JSR  0793          ; Jump to subroutine at direct address
0x0607:     73 26            JMP  (PC+0x26)     ; Jump to direct PC offset by N address  (0x062f)
0x0609:     81 07 A7         LDAL 07A7          ; Load direct address into byte of AL
0x060c:     15 07            BNZ  (PC+0x07)     ; Branch if not equal to zero to 0x07 ahead PC (0x0615)
0x060e:     90 0C B7         LDAW #0CB7         ; Load literal address into byte of AW
0x0611:     D0 FE 6F         LDBW #FE6F         ; Load literal address into byte of BW
0x0614:     09               RSR                ; return(cont=1) from Subroutine
0x0615:     90 2B F7         LDAW #2BF7         ; Load literal address into byte of AW
0x0618:     D0 FF 7E         LDBW #FF7E         ; Load literal address into byte of BW
0x061b:     09               RSR                ; return(cont=1) from Subroutine
0x061c:     81 07 A7         LDAL 07A7          ; Load direct address into byte of AL
0x061f:     15 07            BNZ  (PC+0x07)     ; Branch if not equal to zero to 0x07 ahead PC (0x0628)
0x0621:     90 0C B7         LDAW #0CB7         ; Load literal address into byte of AW
0x0624:     D0 E0 F0         LDBW #E0F0         ; Load literal address into byte of BW
0x0627:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x0629:     00               HLT                ; Halts the CPU
0x062a:     00               HLT                ; Halts the CPU
0x062b:     00               HLT                ; Halts the CPU
0x062c:     00               HLT                ; Halts the CPU
0x062d:     00               HLT                ; Halts the CPU
0x062e:     00               HLT                ; Halts the CPU
0x062f:     00               HLT                ; Halts the CPU
0x0630:     00               HLT                ; Halts the CPU
0x0631:     00               HLT                ; Halts the CPU
0x0632:     00               HLT                ; Halts the CPU
0x0633:     00               HLT                ; Halts the CPU
0x0634:     00               HLT                ; Halts the CPU
0x0635:     00               HLT                ; Halts the CPU
0x0636:     00               HLT                ; Halts the CPU
0x0637:     00               HLT                ; Halts the CPU
0x0638:     00               HLT                ; Halts the CPU
0x0639:     00               HLT                ; Halts the CPU
0x063a:     00               HLT                ; Halts the CPU
0x063b:     00               HLT                ; Halts the CPU
0x063c:     00               HLT                ; Halts the CPU
0x063d:     00               HLT                ; Halts the CPU
0x063e:     00               HLT                ; Halts the CPU
0x063f:     00               HLT                ; Halts the CPU
0x0640:     00               HLT                ; Halts the CPU
0x0641:     78 05 38         JSR  #0538         ; Jump to subroutine at literal address (not possible?)
0x0644:     BF               SAWP               ; Store word from address in P into implicit AW
0x0645:     09               RSR                ; return(cont=1) from Subroutine
0x0646:     90 2B F7         LDAW #2BF7         ; Load literal address into byte of AW
0x0649:     D0 F2 E5         LDBW #F2E5         ; Load literal address into byte of BW
0x064c:     09               RSR                ; return(cont=1) from Subroutine
0x064d:     80 00            LDAL #0015         ; Load literal address into byte of AL
0x064f:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x0654)
0x0651:     71 04 5C         JMP  045C          ; Jump to direct address
0x0654:     80 00            LDAL #0015         ; Load literal address into byte of AL
0x0656:     15 F9            BNZ  (PC-0x07)     ; Branch if not equal to zero to 0x7 behind PC (0x0651)
0x0658:     71 01 64         JMP  0164          ; Jump to direct address
0x065b:     05               DI                 ; Disable Interrupt system
0x065c:     B1 05 C4         STAW 05C4          ; Store AW into direct address
0x065f:     05               DI                 ; Disable Interrupt system
0x0660:     EC               SBLZ               ; Store byte from address in ZW into implicit BL
0x0661:     06               SL                 ; Set Link
0x0662:     22 06            CLR  AH, 6         ; Clear byte of explicit register by 1 + const.
0x0664:     38               INAW               ; Increment word of implicit AW register
0x0665:     06               SL                 ; Set Link
0x0666:     43 06            ORI  AH,  YH       ; OR bytes of two explicit registers (L OR R stored in L)
0x0668:     67               ???                ; Unknown
0x0669:     06               SL                 ; Set Link
0x066a:     A1 06 94         STAL 0694          ; Store AL into direct address
0x066d:     06               SL                 ; Set Link
0x066e:     AD               SALS               ; Store byte from address in S into implicit AL
0x066f:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x0671:     B3 03            STAW (PC+0x03)     ; Store word of AW into direct PC offset by N address
0x0673:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0676:     00               HLT                ; Halts the CPU
0x0677:     00               HLT                ; Halts the CPU
0x0678:     3A               CLAW               ; Clear word of implicit AW register
0x0679:     B3 1E            STAW (PC+0x1E)     ; Store word of AW into direct PC offset by N address
0x067b:     B0 00 00         STAW 0000          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x067e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0681:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x0683:     49               SABL               ; Subtract implicit AL and BL
0x0684:     14 2C            BZ   (PC+0x2C)     ; Branch if equal to zero to 0x2C ahead PC (0x06b2)
0x0686:     D3 F4            LDBW (PC-0x0c)     ; Load direct PC offset by N address into word of BW
0x0688:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x068a:     F3 F0            STBW (PC-0x10)     ; Store word of BW into direct PC offset by N address
0x068c:     D0 00 B0         LDBW #00B0         ; Load literal address into byte of BW
0x068f:     49               SABL               ; Subtract implicit AL and BL
0x0690:     16 16            BM   (PC+0x16)     ; Branch if minus set to 0x16 ahead PC (0x06a8)
0x0692:     80 09            LDAL #0941         ; Load literal address into byte of AL
0x0694:     41 31            SUB  BL,  AL       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0696:     18 10            BGZ  (PC+0x10)     ; Branch if greater than zero to 0x10 ahead PC (0x06a8)
0x0698:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x069b:     3D               SLAW               ; Shift word of implicit AW register right
0x069c:     58               AABW               ; Add implicit AW and BW
0x069d:     3D               SLAW               ; Shift word of implicit AW register right
0x069e:     3D               SLAW               ; Shift word of implicit AW register right
0x069f:     58               AABW               ; Add implicit AW and BW
0x06a0:     F3 F7            STBW (PC-0x09)     ; Store word of BW into direct PC offset by N address
0x06a2:     90 00 99         LDAW #0099         ; Load literal address into byte of AW
0x06a5:     59               SABW               ; Subtract implicit AW and BW
0x06a6:     17 D6            BP   (PC-0x2a)     ; Branch on positive to 0x2a behind PC (0x067e)
0x06a8:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x06ab:     79 08 BC         JSR  08BC          ; Jump to subroutine at direct address
0x06ae:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x06af:     3A               CLAW               ; Clear word of implicit AW register
0x06b0:     73 C1            JMP  (PC-0x3f)     ; Jump to direct PC offset by N address  (0x0673)
0x06b2:     93 E5            LDAW (PC-0x1b)     ; Load direct PC offset by N address into word of AW
0x06b4:     09               RSR                ; return(cont=1) from Subroutine
0x06b5:     00               HLT                ; Halts the CPU
0x06b6:     00               HLT                ; Halts the CPU
0x06b7:     00               HLT                ; Halts the CPU
0x06b8:     00               HLT                ; Halts the CPU
0x06b9:     00               HLT                ; Halts the CPU
0x06ba:     00               HLT                ; Halts the CPU
0x06bb:     00               HLT                ; Halts the CPU
0x06bc:     B3 00            STAW (PC+0x00)     ; Store word of AW into direct PC offset by N address
0x06be:     78 05 B0         JSR  #05B0         ; Jump to subroutine at literal address (not possible?)
0x06c1:     00               HLT                ; Halts the CPU
0x06c2:     81 39 11         LDAL 3911          ; Load direct address into byte of AL
0x06c5:     14 05            BZ   (PC+0x05)     ; Branch if equal to zero to 0x05 ahead PC (0x06cc)
0x06c7:     81 03 43         LDAL 0343          ; Load direct address into byte of AL
0x06ca:     73 5A            JMP  (PC+0x5A)     ; Jump to direct PC offset by N address  (0x0726)
0x06cc:     80 01            LDAL #01A1         ; Load literal address into byte of AL
0x06ce:     A1 39 11         STAL 3911          ; Store AL into direct address
0x06d1:     81 03 2F         LDAL 032F          ; Load direct address into byte of AL
0x06d4:     09               RSR                ; return(cont=1) from Subroutine
0x06d5:     91 39 11         LDAW 3911          ; Load direct address into byte of AW
0x06d8:     16 06            BM   (PC+0x06)     ; Branch if minus set to 0x06 ahead PC (0x06e0)
0x06da:     39               DCAW               ; Decrement word of implicit AW register
0x06db:     81 03 43         LDAL 0343          ; Load direct address into byte of AL
0x06de:     73 01            JMP  (PC+0x01)     ; Jump to direct PC offset by N address  (0x06e1)
0x06e0:     29               DCAL               ; Decrement byte of implicit AL register
0x06e1:     B1 39 11         STAW 3911          ; Store AW into direct address
0x06e4:     C1 03 2F         LDBL 032F          ; Load direct address into byte of BL
0x06e7:     49               SABL               ; Subtract implicit AL and BL
0x06e8:     14 3C            BZ   (PC+0x3C)     ; Branch if equal to zero to 0x3C ahead PC (0x0726)
0x06ea:     09               RSR                ; return(cont=1) from Subroutine
0x06eb:     91 39 11         LDAW 3911          ; Load direct address into byte of AW
0x06ee:     39               DCAW               ; Decrement word of implicit AW register
0x06ef:     B1 39 11         STAW 3911          ; Store AW into direct address
0x06f2:     39               DCAW               ; Decrement word of implicit AW register
0x06f3:     D0 01 64         LDBW #0164         ; Load literal address into byte of BW
0x06f6:     58               AABW               ; Add implicit AW and BW
0x06f7:     99               LAWB               ; Load word from address in BW into implicit AW
0x06f8:     20 00            INR  AH, 0         ; Increment byte of explicit register by 1 + const.
0x06fa:     14 2A            BZ   (PC+0x2A)     ; Branch if equal to zero to 0x2A ahead PC (0x0726)
0x06fc:     09               RSR                ; return(cont=1) from Subroutine
0x06fd:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0700:     05               DI                 ; Disable Interrupt system
0x0701:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0702:     91 05 AB         LDAW 05AB          ; Load direct address into byte of AW
0x0705:     D0 05 F4         LDBW #05F4         ; Load literal address into byte of BW
0x0708:     58               AABW               ; Add implicit AW and BW
0x0709:     90 56 39         LDAW #5639         ; Load literal address into byte of AW
0x070c:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x070f:     F3 F5            STBW (PC-0x0b)     ; Store word of BW into direct PC offset by N address
0x0711:     3A               CLAW               ; Clear word of implicit AW register
0x0712:     5D               XABW               ; Transfer implicit AW into BW
0x0713:     81 03 43         LDAL 0343          ; Load direct address into byte of AL
0x0716:     C1 03 2F         LDBL 032F          ; Load direct address into byte of BL
0x0719:     49               SABL               ; Subtract implicit AL and BL
0x071a:     20 30            INR  BL, 0         ; Increment byte of explicit register by 1 + const.
0x071c:     93 E8            LDAW (PC-0x18)     ; Load direct PC offset by N address into word of AW
0x071e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0721:     C1 03 2F         LDBL 032F          ; Load direct address into byte of BL
0x0724:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0x0726:     32 20            CLR  BW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0728:     F1 39 11         STBW 3911          ; Store BW into direct address
0x072b:     E3 1D            STBL (PC+0x1D)     ; Store byte of BL into direct PC offset by N address
0x072d:     C0 01            LDBL #01E1         ; Load literal address into byte of BL
0x072f:     E1 05 42         STBL 0542          ; Store BL into direct address
0x0732:     09               RSR                ; return(cont=1) from Subroutine
0x0733:     91 39 11         LDAW 3911          ; Load direct address into byte of AW
0x0736:     16 06            BM   (PC+0x06)     ; Branch if minus set to 0x06 ahead PC (0x073e)
0x0738:     39               DCAW               ; Decrement word of implicit AW register
0x0739:     40 00            ADD  AH,  AH       ; Add bytes of two explicit registers (L + R stored in L)
0x073b:     78 06 28         JSR  #0628         ; Jump to subroutine at literal address (not possible?)
0x073e:     81 03 2F         LDAL 032F          ; Load direct address into byte of AL
0x0741:     73 01            JMP  (PC+0x01)     ; Jump to direct PC offset by N address  (0x0744)
0x0743:     28               INAL               ; Increment byte of implicit AL register
0x0744:     B1 39 11         STAW 3911          ; Store AW into direct address
0x0747:     C1 03 43         LDBL 0343          ; Load direct address into byte of BL
0x074a:     49               SABL               ; Subtract implicit AL and BL
0x074b:     14 DE            BZ   (PC-0x22)     ; Branch if equal to zero to 0x22 behind PC (0x072b)
0x074d:     09               RSR                ; return(cont=1) from Subroutine
0x074e:     80 00            LDAL #002B         ; Load literal address into byte of AL
0x0750:     2B               IVAL               ; Invert byte of implicit AL register
0x0751:     A3 FC            STAL (PC-0x04)     ; Store byte of AL into direct PC offset by N address
0x0753:     14 E3            BZ   (PC-0x1d)     ; Branch if equal to zero to 0x1d behind PC (0x0738)
0x0755:     81 03 2F         LDAL 032F          ; Load direct address into byte of AL
0x0758:     09               RSR                ; return(cont=1) from Subroutine
0x0759:     3A               CLAW               ; Clear word of implicit AW register
0x075a:     81 04 BC         LDAL 04BC          ; Load direct address into byte of AL
0x075d:     B3 06            STAW (PC+0x06)     ; Store word of AW into direct PC offset by N address
0x075f:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x0761:     60 00 14         LDXW #0014         ; Load literal word into word XW
0x0764:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x0767:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0769:     F3 FA            STBW (PC-0x06)     ; Store word of BW into direct PC offset by N address
0x076b:     31 20            DCR  BW, 0         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x076d:     90 00 C8         LDAW #00C8         ; Load literal address into byte of AW
0x0770:     F5 61            STBW YW, 1         ; Store BW into index mode register (view supplemental material)
0x0772:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0774:     39               DCAW               ; Decrement word of implicit AW register
0x0775:     18 F9            BGZ  (PC-0x07)     ; Branch if greater than zero to 0x7 behind PC (0x0770)
0x0777:     3F               DCX                ; Decrement word of implicit X register
0x0778:     18 EA            BGZ  (PC-0x16)     ; Branch if greater than zero to 0x16 behind PC (0x0764)
0x077a:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x077c:     09               RSR                ; return(cont=1) from Subroutine
0x077d:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x077f:     60 0F A0         LDXW #0FA0         ; Load literal word into word XW
0x0782:     3A               CLAW               ; Clear word of implicit AW register
0x0783:     81 04 BC         LDAL 04BC          ; Load direct address into byte of AL
0x0786:     D0 65 93         LDBW #6593         ; Load literal address into byte of BW
0x0789:     50 20            ADD  BW,  AW       ; Add word of two explicit registers (L + R stored in L)
0x078b:     32 20            CLR  BW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x078d:     58               AABW               ; Add implicit AW and BW
0x078e:     3D               SLAW               ; Shift word of implicit AW register right
0x078f:     3D               SLAW               ; Shift word of implicit AW register right
0x0790:     58               AABW               ; Add implicit AW and BW
0x0791:     3D               SLAW               ; Shift word of implicit AW register right
0x0792:     3D               SLAW               ; Shift word of implicit AW register right
0x0793:     3D               SLAW               ; Shift word of implicit AW register right
0x0794:     58               AABW               ; Add implicit AW and BW
0x0795:     3D               SLAW               ; Shift word of implicit AW register right
0x0796:     58               AABW               ; Add implicit AW and BW
0x0797:     3D               SLAW               ; Shift word of implicit AW register right
0x0798:     3D               SLAW               ; Shift word of implicit AW register right
0x0799:     3D               SLAW               ; Shift word of implicit AW register right
0x079a:     58               AABW               ; Add implicit AW and BW
0x079b:     3D               SLAW               ; Shift word of implicit AW register right
0x079c:     58               AABW               ; Add implicit AW and BW
0x079d:     3D               SLAW               ; Shift word of implicit AW register right
0x079e:     3D               SLAW               ; Shift word of implicit AW register right
0x079f:     3D               SLAW               ; Shift word of implicit AW register right
0x07a0:     50 20            ADD  BW,  AW       ; Add word of two explicit registers (L + R stored in L)
0x07a2:     B5 61            STAW YW, 1         ; Store AW into index mode register (view supplemental material)
0x07a4:     3F               DCX                ; Decrement word of implicit X register
0x07a5:     18 DF            BGZ  (PC-0x21)     ; Branch if greater than zero to 0x21 behind PC (0x0786)
0x07a7:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x07a9:     09               RSR                ; return(cont=1) from Subroutine
0x07aa:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x07ac:     81 07 A7         LDAL 07A7          ; Load direct address into byte of AL
0x07af:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x07b4)
0x07b1:     71 04 EE         JMP  04EE          ; Jump to direct address
0x07b4:     71 05 6E         JMP  056E          ; Jump to direct address
0x07b7:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x07b9:     00               HLT                ; Halts the CPU
0x07ba:     00               HLT                ; Halts the CPU
0x07bb:     00               HLT                ; Halts the CPU
0x07bc:     00               HLT                ; Halts the CPU
0x07bd:     00               HLT                ; Halts the CPU
0x07be:     00               HLT                ; Halts the CPU
0x07bf:     00               HLT                ; Halts the CPU
0x07c0:     00               HLT                ; Halts the CPU
0x07c1:     00               HLT                ; Halts the CPU
0x07c2:     00               HLT                ; Halts the CPU
0x07c3:     00               HLT                ; Halts the CPU
0x07c4:     00               HLT                ; Halts the CPU
0x07c5:     00               HLT                ; Halts the CPU
0x07c6:     00               HLT                ; Halts the CPU
0x07c7:     00               HLT                ; Halts the CPU
0x07c8:     00               HLT                ; Halts the CPU
0x07c9:     00               HLT                ; Halts the CPU
0x07ca:     00               HLT                ; Halts the CPU
0x07cb:     00               HLT                ; Halts the CPU
0x07cc:     00               HLT                ; Halts the CPU
0x07cd:     00               HLT                ; Halts the CPU
0x07ce:     00               HLT                ; Halts the CPU
0x07cf:     00               HLT                ; Halts the CPU
0x07d0:     00               HLT                ; Halts the CPU
0x07d1:     78 06 A0         JSR  #06A0         ; Jump to subroutine at literal address (not possible?)
0x07d4:     11 D0            BNL  (PC-0x30)     ; Branch if link not set to 0x30 behind PC (0x07a6)
0x07d6:     E5 E5            STAL P , 5         ; Store BL into index mode register (view supplemental material)
0x07d8:     90 0F A0         LDAW #0FA0         ; Load literal address into byte of AW
0x07db:     F5 61            STBW YW, 1         ; Store BW into index mode register (view supplemental material)
0x07dd:     39               DCAW               ; Decrement word of implicit AW register
0x07de:     18 FB            BGZ  (PC-0x05)     ; Branch if greater than zero to 0x5 behind PC (0x07db)
0x07e0:     09               RSR                ; return(cont=1) from Subroutine
0x07e1:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x07e3:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x07e5:     60 00 00         LDXW #0000         ; Load literal word into word XW
0x07e8:     45 51            XFR  X ,  AL       ; Copy byte of one explicit register into other (R into L)
0x07ea:     A1 04 BC         STAL 04BC          ; Store AL into direct address
0x07ed:     80 87            LDAL #87A1         ; Load literal address into byte of AL
0x07ef:     A1 0C 83         STAL 0C83          ; Store AL into direct address
0x07f2:     90 0C 7F         LDAW #0C7F         ; Load literal address into byte of AW
0x07f5:     D0 FF FA         LDBW #FFFA         ; Load literal address into byte of BW
0x07f8:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x07fb:     79 08 05         JSR  0805          ; Jump to subroutine at direct address
0x07fe:     79 08 44         JSR  0844          ; Jump to subroutine at direct address
0x0801:     3E               INX                ; Increment word of implicit X register
0x0802:     6B E2            STXW (PC-0x1e)     ; Store word of XW into direct PC offset by N address
0x0804:     45 51            XFR  X ,  AL       ; Copy byte of one explicit register into other (R into L)
0x0806:     C0 4D            LDBL #4D49         ; Load literal address into byte of BL
0x0808:     49               SABL               ; Subtract implicit AL and BL
0x0809:     15 DA            BNZ  (PC-0x26)     ; Branch if not equal to zero to 0x26 behind PC (0x07e5)
0x080b:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x080e:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x080f:     F5 3A B3         STBW, A, 0xB3   ; Store BW into index mode register (view supplemental material)
0x0812:     D3 65            LDBW (PC+0x65)     ; Load direct PC offset by N address into word of BW
0x0814:     A1 71 01         STAL 7101          ; Store AL into direct address
0x0817:     64 90            LDXW [PC-0x70]     ; Load indirect PC offset by N address into word XW
0x0819:     01               NOP                ; No Operation
0x081a:     64 5F            LDXW [PC+0x5F]     ; Load indirect PC offset by N address into word XW
0x081c:     90 06 E4         LDAW #06E4         ; Load literal address into byte of AW
0x081f:     B1 04 B9         STAW 04B9          ; Store AW into direct address
0x0822:     80 01            LDAL #01A1         ; Load literal address into byte of AL
0x0824:     A1 03 0D         STAL 030D          ; Store AL into direct address
0x0827:     91 F2 00         LDAW F200          ; Load direct address into byte of AW
0x082a:     2C               SRAL               ; Shift byte of implicit AL register left
0x082b:     11 0B            BNL  (PC+0x0B)     ; Branch if link not set to 0x0B ahead PC (0x0838)
0x082d:     81 F2 01         LDAL F201          ; Load direct address into byte of AL
0x0830:     C0 03            LDBL #0349         ; Load literal address into byte of BL
0x0832:     49               SABL               ; Subtract implicit AL and BL
0x0833:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x0838)
0x0835:     71 01 64         JMP  0164          ; Jump to direct address
0x0838:     2A               CLAL               ; Clear byte of implicit AL register
0x0839:     A1 03 C5         STAL 03C5          ; Store AL into direct address
0x083c:     A1 04 BC         STAL 04BC          ; Store AL into direct address
0x083f:     79 07 A6         JSR  07A6          ; Jump to subroutine at direct address
0x0842:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x0845:     79 08 05         JSR  0805          ; Jump to subroutine at direct address
0x0848:     79 08 44         JSR  0844          ; Jump to subroutine at direct address
0x084b:     80 86            LDAL #8600         ; Load literal address into byte of AL
0x084d:     00               HLT                ; Halts the CPU
0x084e:     78 07 18         JSR  #0718         ; Jump to subroutine at literal address (not possible?)
0x0851:     26 A1            RRR  SH, 1         ; Rotate byte of explicit register right by 1 + const.
0x0853:     04               EI                 ; Enable Interrupt system
0x0854:     BC               SAWZ               ; Store word from address in ZW into implicit AW
0x0855:     79 07 A6         JSR  07A6          ; Jump to subroutine at direct address
0x0858:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x085b:     79 08 05         JSR  0805          ; Jump to subroutine at direct address
0x085e:     79 08 44         JSR  0844          ; Jump to subroutine at direct address
0x0861:     80 60            LDAL #60A2         ; Load literal address into byte of AL
0x0863:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0866:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0869:     81 0C 18         LDAL 0C18          ; Load direct address into byte of AL
0x086c:     C0 80            LDBL #8043         ; Load literal address into byte of BL
0x086e:     43 31            ORI  BL,  AL       ; OR bytes of two explicit registers (L OR R stored in L)
0x0870:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0873:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0876:     80 61            LDAL #61A2         ; Load literal address into byte of AL
0x0878:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x087b:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x087e:     80 0C            LDAL #0CA2         ; Load literal address into byte of AL
0x0880:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0883:     60 01 B8         LDXW #01B8         ; Load literal word into word XW
0x0886:     0E               DLY                ; Delay 4.5ms
0x0887:     3F               DCX                ; Decrement word of implicit X register
0x0888:     15 FC            BNZ  (PC-0x04)     ; Branch if not equal to zero to 0x4 behind PC (0x0886)
0x088a:     80 61            LDAL #61A2         ; Load literal address into byte of AL
0x088c:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x088f:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0892:     2A               CLAL               ; Clear byte of implicit AL register
0x0893:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0896:     73 85            JMP  (PC-0x7b)     ; Jump to direct PC offset by N address  (0x081d)
0x0898:     55 26            XFR  BW,  YW       ; Copy word of one explicit register into other (R into L)
0x089a:     C0 00            LDBL #0014         ; Load literal address into byte of BL
0x089c:     14 0C            BZ   (PC+0x0C)     ; Branch if equal to zero to 0x0C ahead PC (0x08aa)
0x089e:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0x08a0:     55 62            XFR  YW,  BW       ; Copy word of one explicit register into other (R into L)
0x08a2:     2F 22            ???                ; Special 2 byte instruction. See supplemental material.
0x08a4:     2F 34            ???                ; Special 2 byte instruction. See supplemental material.
0x08a6:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0x08a8:     73 10            JMP  (PC+0x10)     ; Jump to direct PC offset by N address  (0x08ba)
0x08aa:     B1 FF F0         STAW FFF0          ; Store AW into direct address
0x08ad:     55 62            XFR  YW,  BW       ; Copy word of one explicit register into other (R into L)
0x08af:     F1 FF F2         STBW FFF2          ; Store BW into direct address
0x08b2:     80 03            LDAL #03A1         ; Load literal address into byte of AL
0x08b4:     A1 FF F4         STAL FFF4          ; Store AL into direct address
0x08b7:     A1 FF F7         STAL FFF7          ; Store AL into direct address
0x08ba:     80 00            LDAL #00A1         ; Load literal address into byte of AL
0x08bc:     A1 0C 18         STAL 0C18          ; Store AL into direct address
0x08bf:     A1 0C 80         STAL 0C80          ; Store AL into direct address
0x08c2:     81 04 BC         LDAL 04BC          ; Load direct address into byte of AL
0x08c5:     A1 0C 1A         STAL 0C1A          ; Store AL into direct address
0x08c8:     A1 C5 00         STAL C500          ; Store AL into direct address
0x08cb:     78 07 90         JSR  #0790         ; Jump to subroutine at literal address (not possible?)
0x08ce:     0C               ELO                ; Enable Link Out
0x08cf:     82 09 79         LDAL [0979]        ; Load indirect address into byte of AL
0x08d2:     07               RL                 ; Reset Link
0x08d3:     A6               ???                ; Turn on CPU line 4
0x08d4:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x08d7:     79 08 05         JSR  0805          ; Jump to subroutine at direct address
0x08da:     79 05 2E         JSR  052E          ; Jump to subroutine at direct address
0x08dd:     79 07 5F         JSR  075F          ; Jump to subroutine at direct address
0x08e0:     79 08 44         JSR  0844          ; Jump to subroutine at direct address
0x08e3:     09               RSR                ; return(cont=1) from Subroutine
0x08e4:     80 00            LDAL #0015         ; Load literal address into byte of AL
0x08e6:     15 27            BNZ  (PC+0x27)     ; Branch if not equal to zero to 0x27 ahead PC (0x090f)
0x08e8:     81 03 C5         LDAL 03C5          ; Load direct address into byte of AL
0x08eb:     14 41            BZ   (PC+0x41)     ; Branch if equal to zero to 0x41 ahead PC (0x092e)
0x08ed:     C1 0C 1B         LDBL 0C1B          ; Load direct address into byte of BL
0x08f0:     90 0C 1B         LDAW #0C1B         ; Load literal address into byte of AW
0x08f3:     B3 01            STAW (PC+0x01)     ; Store word of AW into direct PC offset by N address
0x08f5:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x08f8:     E2 07 B8         STBL [07B8]        ; Store BL into indirect address
0x08fb:     55 26            XFR  BW,  YW       ; Copy word of one explicit register into other (R into L)
0x08fd:     93 F7            LDAW (PC-0x09)     ; Load direct PC offset by N address into word of AW
0x08ff:     D0 0C 7A         LDBW #0C7A         ; Load literal address into byte of BW
0x0902:     59               SABW               ; Subtract implicit AW and BW
0x0903:     14 30            BZ   (PC+0x30)     ; Branch if equal to zero to 0x30 ahead PC (0x0935)
0x0905:     D0 00 05         LDBW #0005         ; Load literal address into byte of BW
0x0908:     58               AABW               ; Add implicit AW and BW
0x0909:     F3 EB            STBW (PC-0x15)     ; Store word of BW into direct PC offset by N address
0x090b:     55 62            XFR  YW,  BW       ; Copy word of one explicit register into other (R into L)
0x090d:     73 E9            JMP  (PC-0x17)     ; Jump to direct PC offset by N address  (0x08f8)
0x090f:     90 0C 83         LDAW #0C83         ; Load literal address into byte of AW
0x0912:     C1 0C 83         LDBL 0C83          ; Load direct address into byte of BL
0x0915:     B3 DF            STAW (PC-0x21)     ; Store word of AW into direct PC offset by N address
0x0917:     E2 07 B8         STBL [07B8]        ; Store BL into indirect address
0x091a:     55 26            XFR  BW,  YW       ; Copy word of one explicit register into other (R into L)
0x091c:     93 D8            LDAW (PC-0x28)     ; Load direct PC offset by N address into word of AW
0x091e:     D0 0C B5         LDBW #0CB5         ; Load literal address into byte of BW
0x0921:     59               SABW               ; Subtract implicit AW and BW
0x0922:     14 18            BZ   (PC+0x18)     ; Branch if equal to zero to 0x18 ahead PC (0x093c)
0x0924:     D0 00 02         LDBW #0002         ; Load literal address into byte of BW
0x0927:     58               AABW               ; Add implicit AW and BW
0x0928:     F3 CC            STBW (PC-0x34)     ; Store word of BW into direct PC offset by N address
0x092a:     55 62            XFR  YW,  BW       ; Copy word of one explicit register into other (R into L)
0x092c:     73 E9            JMP  (PC-0x17)     ; Jump to direct PC offset by N address  (0x0917)
0x092e:     90 0C 17         LDAW #0C17         ; Load literal address into byte of AW
0x0931:     D0 FF FB         LDBW #FFFB         ; Load literal address into byte of BW
0x0934:     09               RSR                ; return(cont=1) from Subroutine
0x0935:     90 0C 17         LDAW #0C17         ; Load literal address into byte of AW
0x0938:     D0 FF 97         LDBW #FF97         ; Load literal address into byte of BW
0x093b:     09               RSR                ; return(cont=1) from Subroutine
0x093c:     90 0C 7F         LDAW #0C7F         ; Load literal address into byte of AW
0x093f:     D0 FF C7         LDBW #FFC7         ; Load literal address into byte of BW
0x0942:     09               RSR                ; return(cont=1) from Subroutine
0x0943:     83 A0            LDAL (PC-0x60)     ; Load direct PC offset by N address into byte of AL
0x0945:     15 4E            BNZ  (PC+0x4E)     ; Branch if not equal to zero to 0x4E ahead PC (0x0995)
0x0947:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x0949:     00               HLT                ; Halts the CPU
0x094a:     00               HLT                ; Halts the CPU
0x094b:     00               HLT                ; Halts the CPU
0x094c:     00               HLT                ; Halts the CPU
0x094d:     00               HLT                ; Halts the CPU
0x094e:     00               HLT                ; Halts the CPU
0x094f:     00               HLT                ; Halts the CPU
0x0950:     00               HLT                ; Halts the CPU
0x0951:     00               HLT                ; Halts the CPU
0x0952:     00               HLT                ; Halts the CPU
0x0953:     00               HLT                ; Halts the CPU
0x0954:     00               HLT                ; Halts the CPU
0x0955:     00               HLT                ; Halts the CPU
0x0956:     00               HLT                ; Halts the CPU
0x0957:     00               HLT                ; Halts the CPU
0x0958:     00               HLT                ; Halts the CPU
0x0959:     00               HLT                ; Halts the CPU
0x095a:     00               HLT                ; Halts the CPU
0x095b:     00               HLT                ; Halts the CPU
0x095c:     00               HLT                ; Halts the CPU
0x095d:     00               HLT                ; Halts the CPU
0x095e:     00               HLT                ; Halts the CPU
0x095f:     00               HLT                ; Halts the CPU
0x0960:     00               HLT                ; Halts the CPU
0x0961:     78 08 08         JSR  #0808         ; Jump to subroutine at literal address (not possible?)
0x0964:     1A 80            BS1  (PC-0x80)     ; Branch if sense switch 1 set to 0x80 behind PC (0x08e6)
0x0966:     41 A2            SUB  SH,  BH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0968:     02               SF                 ; Set Fault
0x0969:     5F               XASW               ; Transfer implicit AW into SW
0x096a:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x096d:     80 00            LDAL #00A2         ; Load literal address into byte of AL
0x096f:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0972:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0975:     80 00            LDAL #00A2         ; Load literal address into byte of AL
0x0977:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x097a:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x097d:     73 19            JMP  (PC+0x19)     ; Jump to direct PC offset by N address  (0x0998)
0x097f:     81 00 41         LDAL 0041          ; Load direct address into byte of AL
0x0982:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0985:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0988:     80 84            LDAL #84A2         ; Load literal address into byte of AL
0x098a:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x098d:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0990:     80 CF            LDAL #CFA2         ; Load literal address into byte of AL
0x0992:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x0995:     79 08 BA         JSR  08BA          ; Jump to subroutine at direct address
0x0998:     80 43            LDAL #43A2         ; Load literal address into byte of AL
0x099a:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x099d:     7B 77            JSR  (PC+0x77)     ; Jump to subroutine at direct PC offset by N address  (0x0a16)
0x099f:     09               RSR                ; return(cont=1) from Subroutine
0x09a0:     80 45            LDAL #45A2         ; Load literal address into byte of AL
0x09a2:     A2 02 5F         STAL [025F]        ; Store AL into indirect address
0x09a5:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x09a7:     60 13 88         LDXW #1388         ; Load literal word into word XW
0x09aa:     7B 6A            JSR  (PC+0x6A)     ; Jump to subroutine at direct PC offset by N address  (0x0a16)
0x09ac:     3F               DCX                ; Decrement word of implicit X register
0x09ad:     15 0F            BNZ  (PC+0x0F)     ; Branch if not equal to zero to 0x0F ahead PC (0x09be)
0x09af:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x09b2:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x09b3:     DD               LBWS               ; Load byte from address in S into implicit BW
0x09b4:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x09b6:     A2 02 62         STAL [0262]        ; Store AL into indirect address
0x09b9:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x09bb:     71 05 41         JMP  0541          ; Jump to direct address
0x09be:     C2 02 62         LDBL [0262]        ; Load indirect address into byte of BL
0x09c1:     80 08            LDAL #084A         ; Load literal address into byte of AL
0x09c3:     4A               NABL               ; AND implicit AL and BL
0x09c4:     15 E4            BNZ  (PC-0x1c)     ; Branch if not equal to zero to 0x1c behind PC (0x09aa)
0x09c6:     82 02 5F         LDAL [025F]        ; Load indirect address into byte of AL
0x09c9:     15 03            BNZ  (PC+0x03)     ; Branch if not equal to zero to 0x03 ahead PC (0x09ce)
0x09cb:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x09cd:     09               RSR                ; return(cont=1) from Subroutine
0x09ce:     C0 33            LDBL #3349         ; Load literal address into byte of BL
0x09d0:     49               SABL               ; Subtract implicit AL and BL
0x09d1:     15 09            BNZ  (PC+0x09)     ; Branch if not equal to zero to 0x09 ahead PC (0x09dc)
0x09d3:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x09d5:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x09d7:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x09d9:     71 05 41         JMP  0541          ; Jump to direct address
0x09dc:     55 00            XFR  AW,  AW       ; Copy word of one explicit register into other (R into L)
0x09de:     78 08 80         JSR  #0880         ; Jump to subroutine at literal address (not possible?)
0x09e1:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x09e3:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x09e5:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x09e7:     82 02 5F         LDAL [025F]        ; Load indirect address into byte of AL
0x09ea:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x09ed:     B1 0B 99         STAW 0B99          ; Store AW into direct address
0x09f0:     81 02 A3         LDAL 02A3          ; Load direct address into byte of AL
0x09f3:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x09f6:     B1 0B 77         STAW 0B77          ; Store AW into direct address
0x09f9:     90 A0 A0         LDAW #A0A0         ; Load literal address into byte of AW
0x09fc:     B1 0B 88         STAW 0B88          ; Store AW into direct address
0x09ff:     3A               CLAW               ; Clear word of implicit AW register
0x0a00:     81 04 BC         LDAL 04BC          ; Load direct address into byte of AL
0x0a03:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0a06:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x0a07:     8A               LALX               ; Load byte from address in XW into implicit AL
0x0a08:     90 D2 BD         LDAW #D2BD         ; Load literal address into byte of AW
0x0a0b:     B1 0B 86         STAW 0B86          ; Store AW into direct address
0x0a0e:     79 08 BC         JSR  08BC          ; Jump to subroutine at direct address
0x0a11:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x0a12:     52 80            AND  ZW,  AW       ; AND word of two explicit registers (L AND R stored in L)
0x0a14:     00               HLT                ; Halts the CPU
0x0a15:     A2 02 62         STAL [0262]        ; Store AL into indirect address
0x0a18:     71 05 41         JMP  0541          ; Jump to direct address
0x0a1b:     0E               DLY                ; Delay 4.5ms
0x0a1c:     09               RSR                ; return(cont=1) from Subroutine
0x0a1d:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x0a1f:     B3 09            STAW (PC+0x09)     ; Store word of AW into direct PC offset by N address
0x0a21:     B3 10            STAW (PC+0x10)     ; Store word of AW into direct PC offset by N address
0x0a23:     80 00            LDAL #0016         ; Load literal address into byte of AL
0x0a25:     16 09            BM   (PC+0x09)     ; Branch if minus set to 0x09 ahead PC (0x0a30)
0x0a27:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0a2a:     00               HLT                ; Halts the CPU
0x0a2b:     00               HLT                ; Halts the CPU
0x0a2c:     83 F6            LDAL (PC-0x0a)     ; Load direct PC offset by N address into byte of AL
0x0a2e:     18 05            BGZ  (PC+0x05)     ; Branch if greater than zero to 0x05 ahead PC (0x0a35)
0x0a30:     7A 08 D6         JSR  [08D6]        ; Jump to subroutine at indirect address
0x0a33:     00               HLT                ; Halts the CPU
0x0a34:     00               HLT                ; Halts the CPU
0x0a35:     09               RSR                ; return(cont=1) from Subroutine
0x0a36:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x0a39:     A3 14            STAL (PC+0x14)     ; Store byte of AL into direct PC offset by N address
0x0a3b:     55 E0            XFR  P ,  AW       ; Copy word of one explicit register into other (R into L)
0x0a3d:     B3 20            STAW (PC+0x20)     ; Store word of AW into direct PC offset by N address
0x0a3f:     55 80            XFR  ZW,  AW       ; Copy word of one explicit register into other (R into L)
0x0a41:     B3 14            STAW (PC+0x14)     ; Store word of AW into direct PC offset by N address
0x0a43:     90 08 ED         LDAW #08ED         ; Load literal address into byte of AW
0x0a46:     B1 00 0E         STAW 000E          ; Store AW into direct address
0x0a49:     32 C0            CLR  C, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0a4b:     0A               RI                 ; return(cont=1) from Interrupt
0x0a4c:     73 EB            JMP  (PC-0x15)     ; Jump to direct PC offset by N address  (0x0a39)
0x0a4e:     80 00            LDAL #0079         ; Load literal address into byte of AL
0x0a50:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0a53:     B1 09 18         STAW 0918          ; Store AW into direct address
0x0a56:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x0a59:     57               ???                ; Clear high bit in internal status register
0x0a5a:     00               HLT                ; Halts the CPU
0x0a5b:     78 08 F8         JSR  #08F8         ; Jump to subroutine at literal address (not possible?)
0x0a5e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0a61:     09               RSR                ; return(cont=1) from Subroutine
0x0a62:     1D 90            BS4  (PC-0x70)     ; Branch if sense switch 4 set to zero to 0x70 behind PC (0x09f4)
0x0a64:     00               HLT                ; Halts the CPU
0x0a65:     00               HLT                ; Halts the CPU
0x0a66:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0a69:     09               RSR                ; return(cont=1) from Subroutine
0x0a6a:     24 79            SRR  YL, 9         ; Shift byte of explicit register right by 1 + const.
0x0a6c:     00               HLT                ; Halts the CPU
0x0a6d:     00               HLT                ; Halts the CPU
0x0a6e:     09               RSR                ; return(cont=1) from Subroutine
0x0a6f:     0D               PCX                ; Transfer PC to X
0x0a70:     71 01 64         JMP  0164          ; Jump to direct address
0x0a73:     00               HLT                ; Halts the CPU
0x0a74:     19 CC            BLE  (PC-0x34)     ; Branch if less than or equal to zero to 0x34 behind PC (0x0a42)
0x0a76:     D6 CC            ???                ; Swap high/low bytes in 16 bit value. Register in LOW nibble. (?)
0x0a78:     B1 B5 A0         STAW B5A0          ; Store AW into direct address
0x0a7b:     C3 C4            LDBL (PC-0x3c)     ; Load direct PC offset by N address into byte of BL
0x0a7d:     BA               SAWX               ; Store word from address in XW into implicit AW
0x0a7e:     B0 B0 A0         STAW B0A0          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0a81:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x0a82:     BD               SAWS               ; Store word from address in S into implicit AW
0x0a83:     B0 B0 B0         STAW B0B0          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0a86:     B0 A0 D0         STAW A0D0          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0a89:     BD               SAWS               ; Store word from address in S into implicit AW
0x0a8a:     B0 B0 B0         STAW B0B0          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0a8d:     B0 A1 FF         STAW A1FF          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0a90:     0D               PCX                ; Transfer PC to X
0x0a91:     A1 FF FE         STAL FFFE          ; Store AL into direct address
0x0a94:     A1 F1 4D         STAL F14D          ; Store AL into direct address
0x0a97:     A1 F5 4D         STAL F54D          ; Store AL into direct address
0x0a9a:     A1 F2 0D         STAL F20D          ; Store AL into direct address
0x0a9d:     A1 F2 1D         STAL F21D          ; Store AL into direct address
0x0aa0:     05               DI                 ; Disable Interrupt system
0x0aa1:     71 FD 00         JMP  FD00          ; Jump to direct address
0x0aa4:     00               HLT                ; Halts the CPU
0x0aa5:     01               NOP                ; No Operation
0x0aa6:     02               SF                 ; Set Fault
0x0aa7:     04               EI                 ; Enable Interrupt system
0x0aa8:     08               CL                 ; Complement Link
0x0aa9:     21 22            DCR  BH, 2         ; Decrement byte of explicit register by 1 + const.
0x0aab:     24 28            SRR  BH, 8         ; Shift byte of explicit register right by 1 + const.
0x0aad:     41 42            SUB  X ,  BH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0aaf:     44 48            ORE  X ,  ZH       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x0ab1:     61 62 64         LDXW 6264          ; Load direct word into word XW
0x0ab4:     68 00 2B         STXW 002B          ; Store XW into PC address (PC)- <- X (Opposite 60)
0x0ab7:     BF               SAWP               ; Store word from address in P into implicit AW
0x0ab8:     C6               ???                ; Writes 0 to AH at interrupt level 1. See instructions B6 and 1F
0x0ab9:     D4 D3            LDBW [PC-0x2d]     ; Load indirect PC offset by N address into word of BW
0x0abb:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0abd:     B3 AE            STAW (PC-0x52)     ; Store word of AW into direct PC offset by N address
0x0abf:     B4 A0            STAW [PC-0x60]     ; Store word of AW into indirect PC offset by N address
0x0ac1:     AD               SALS               ; Store byte from address in S into implicit AL
0x0ac2:     AD               SALS               ; Store byte from address in S into implicit AL
0x0ac3:     A0 C6 CC         STAL C6CC          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ac6:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0ac7:     D0 D0 D9         LDBW #D0D9         ; Load literal address into byte of BW
0x0aca:     A0 C4 C9         STAL C4C9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0acd:     D3 CB            LDBW (PC-0x35)     ; Load direct PC offset by N address into word of BW
0x0acf:     A0 C4 C9         STAL C4C9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ad2:     C1 C7 CE         LDBL C7CE          ; Load direct address into byte of BL
0x0ad5:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0ad6:     BF               SAWP               ; Store word from address in P into implicit AW
0x0ad7:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x0ad9:     00               HLT                ; Halts the CPU
0x0ada:     00               HLT                ; Halts the CPU
0x0adb:     00               HLT                ; Halts the CPU
0x0adc:     00               HLT                ; Halts the CPU
0x0add:     00               HLT                ; Halts the CPU
0x0ade:     00               HLT                ; Halts the CPU
0x0adf:     00               HLT                ; Halts the CPU
0x0ae0:     00               HLT                ; Halts the CPU
0x0ae1:     00               HLT                ; Halts the CPU
0x0ae2:     00               HLT                ; Halts the CPU
0x0ae3:     00               HLT                ; Halts the CPU
0x0ae4:     00               HLT                ; Halts the CPU
0x0ae5:     00               HLT                ; Halts the CPU
0x0ae6:     00               HLT                ; Halts the CPU
0x0ae7:     00               HLT                ; Halts the CPU
0x0ae8:     00               HLT                ; Halts the CPU
0x0ae9:     00               HLT                ; Halts the CPU
0x0aea:     00               HLT                ; Halts the CPU
0x0aeb:     00               HLT                ; Halts the CPU
0x0aec:     00               HLT                ; Halts the CPU
0x0aed:     00               HLT                ; Halts the CPU
0x0aee:     00               HLT                ; Halts the CPU
0x0aef:     00               HLT                ; Halts the CPU
0x0af0:     00               HLT                ; Halts the CPU
0x0af1:     78 09 70         JSR  #0970         ; Jump to subroutine at literal address (not possible?)
0x0af4:     D3 D4            LDBW (PC-0x2c)     ; Load direct PC offset by N address into word of BW
0x0af6:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0af7:     C3 A0            LDBL (PC-0x60)     ; Load direct PC offset by N address into byte of BL
0x0af9:     D5 D4            LDAW, 4         ; Load index mode register address into BW (view supplemental material)
0x0afb:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0afc:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0afd:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0afe:     D4 D9            LDBW [PC-0x27]     ; Load indirect PC offset by N address into word of BW
0x0b00:     00               HLT                ; Halts the CPU
0x0b01:     41 D2            SUB ,  BH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0b03:     C5 D4            LDAL, 4         ; Load index mode register address into BL (view supplemental material)
0x0b05:     D5 D2            LDAW, 2         ; Load index mode register address into BW (view supplemental material)
0x0b07:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0b08:     A0 D4 CF         STAL D4CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b0b:     A0 CC CF         STAL CCCF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b0e:     C1 C4 C5         LDBL C4C5          ; Load direct address into byte of BL
0x0b11:     D2 A8 CC         LDBW [A8CC]        ; Load indirect address into byte of BW
0x0b14:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0b15:     BB               SAWY               ; Store word from address in YW into implicit AW
0x0b16:     A0 C5 D2         STAL C5D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b19:     D2 CF D2         LDBW [CFD2]        ; Load indirect address into byte of BW
0x0b1c:     A0 CC CF         STAL CCCF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b1f:     C7               ???                ; Unknown. Illegal?
0x0b20:     A0 CF CE         STAL CFCE          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b23:     A0 C3 D2         STAL C3D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b26:     D4 A8            LDBW [PC-0x58]     ; Load indirect PC offset by N address into word of BW
0x0b28:     C3 A9            LDBL (PC-0x57)     ; Load direct PC offset by N address into byte of BL
0x0b2a:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0b2b:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b2e:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0b2f:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0b30:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0b32:     D2 A8 D0         LDBW [A8D0]        ; Load indirect address into byte of BW
0x0b35:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0b36:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0b37:     A0 CF D2         STAL CFD2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b3a:     A0 C2 CF         STAL C2CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b3d:     D4 C8            LDBW [PC-0x38]     ; Load indirect PC offset by N address into word of BW
0x0b3f:     A8               SALA               ; Store byte from address in AW into implicit AL
0x0b40:     C2 A9 A0         LDBL [A9A0]        ; Load indirect address into byte of BL
0x0b43:     00               HLT                ; Halts the CPU
0x0b44:     1A C4            BS1  (PC-0x3c)     ; Branch if sense switch 1 set to 0x3c behind PC (0x0b0a)
0x0b46:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0b47:     D3 CB            LDBW (PC-0x35)     ; Load direct PC offset by N address into word of BW
0x0b49:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b4c:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0b4d:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0b50:     A0 A8 B0         STAL A8B0          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b53:     A0 D4 C8         STAL D4C8          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b56:     D2 CF D5         LDBW [CFD5]        ; Load indirect address into byte of BW
0x0b59:     C7               ???                ; Unknown. Illegal?
0x0b5a:     C8               LBLA               ; Load byte from address in AW into implicit BL
0x0b5b:     A0 B7 A9         STAL B7A9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b5e:     A0 00 4B         STAL 004B          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b61:     C8               LBLA               ; Load byte from address in AW into implicit BL
0x0b62:     C5 C1            LDAL C , 1         ; Load index mode register address into BL (view supplemental material)
0x0b64:     C4 A0            LDBL [PC-0x60]     ; Load indirect PC offset by N address into byte of BL
0x0b66:     C1 CC C9         LDBL CCC9          ; Load direct address into byte of BL
0x0b69:     C7               ???                ; Unknown. Illegal?
0x0b6a:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0b6b:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0b6c:     35 00            SLR  AW, 0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x0b6e:     78 09 E8         JSR  #09E8         ; Jump to subroutine at literal address (not possible?)
0x0b71:     C5 CE D4         LDBL C , E, 0xD4   ; Load index mode register address into BL (view supplemental material)
0x0b74:     A8               SALA               ; Store byte from address in AW into implicit AL
0x0b75:     C8               LBLA               ; Load byte from address in AW into implicit BL
0x0b76:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0b77:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0b78:     A0 D3 C5         STAL D3C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b7b:     C5 CB A0         LDBL C , B, 0xA0   ; Load index mode register address into BL (view supplemental material)
0x0b7e:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0b80:     D3 D4            LDBW (PC-0x2c)     ; Load direct PC offset by N address into word of BW
0x0b82:     A8               SALA               ; Store byte from address in AW into implicit AL
0x0b83:     D3 A9            LDBW (PC-0x57)     ; Load direct PC offset by N address into word of BW
0x0b85:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0b86:     A0 C4 C1         STAL C4C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b89:     D4 C1            LDBW [PC-0x3f]     ; Load indirect PC offset by N address into word of BW
0x0b8b:     A0 D4 C5         STAL D4C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b8e:     D3 D4            LDBW (PC-0x2c)     ; Load direct PC offset by N address into word of BW
0x0b90:     A8               SALA               ; Store byte from address in AW into implicit AL
0x0b91:     C4 A9            LDBL [PC-0x57]     ; Load indirect PC offset by N address into byte of BL
0x0b93:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0b94:     A0 CF D2         STAL CFD2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b97:     A0 D3 C5         STAL D3C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0b9a:     C5 CB A6         LDBL C , B, 0xA6   ; Load index mode register address into BL (view supplemental material)
0x0b9d:     C4 C1            LDBL [PC-0x3f]     ; Load indirect PC offset by N address into byte of BL
0x0b9f:     D4 C1            LDBW [PC-0x3f]     ; Load indirect PC offset by N address into word of BW
0x0ba1:     A0 D4 C5         STAL D4C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ba4:     D3 D4            LDBW (PC-0x2c)     ; Load direct PC offset by N address into word of BW
0x0ba6:     A0 A8 CE         STAL A8CE          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ba9:     C5 D7            LDAL, 7         ; Load index mode register address into BL (view supplemental material)
0x0bab:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0bac:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0bad:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0bae:     C5 A9 A0         LDBL SW, 9, 0xA0   ; Load index mode register address into BL (view supplemental material)
0x0bb1:     00               HLT                ; Halts the CPU
0x0bb2:     13 C5            BNF  (PC-0x3b)     ; Branch if fault not set to 0x3b behind PC (0x0b79)
0x0bb4:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0bb5:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0bb7:     D2 A0 D4         LDBW [A0D4]        ; Load indirect address into byte of BW
0x0bba:     D2 C1 C3         LDBW [C1C3]        ; Load indirect address into byte of BW
0x0bbd:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x0bbe:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bc1:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0bc2:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0bc5:     A0 00 16         STAL 0016          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bc8:     C5 CE D4         LDBL C , E, 0xD4   ; Load index mode register address into BL (view supplemental material)
0x0bcb:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0bcd:     A0 CC CF         STAL CCCF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bd0:     A0 D4 D2         STAL D4D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bd3:     C1 C3 CB         LDBL C3CB          ; Load direct address into byte of BL
0x0bd6:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bd9:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0bda:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0bdd:     A0 00 16         STAL 0016          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0be0:     C5 CE D4         LDBL C , E, 0xD4   ; Load index mode register address into BL (view supplemental material)
0x0be3:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0be5:     A0 C8 C9         STAL C8C9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0be8:     A0 4B 00         STAL 4B00          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0beb:     78 0A 60         JSR  #0A60         ; Jump to subroutine at literal address (not possible?)
0x0bee:     D4 D2            LDBW [PC-0x2e]     ; Load indirect PC offset by N address into word of BW
0x0bf0:     C1 C3 CB         LDBL C3CB          ; Load direct address into byte of BL
0x0bf3:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bf6:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0bf7:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0bfa:     A0 00 26         STAL 0026          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0bfd:     C5 CE D4         LDBL C , E, 0xD4   ; Load index mode register address into BL (view supplemental material)
0x0c00:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0c02:     A0 D3 C5         STAL D3C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c05:     C5 CB A0         LDBL C , B, 0xA0   ; Load index mode register address into BL (view supplemental material)
0x0c08:     D0 C1 D4         LDBW #C1D4         ; Load literal address into byte of BW
0x0c0b:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0c0d:     D2 CE A0         LDBW [CEA0]        ; Load indirect address into byte of BW
0x0c10:     C3 CF            LDBL (PC-0x31)     ; Load direct PC offset by N address into byte of BL
0x0c12:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0c14:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c17:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0c18:     D5 AC C4         LDBW SW, C, 0xC4   ; Load index mode register address into BW (view supplemental material)
0x0c1b:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0c1c:     D2 AC C3         LDBW [ACC3]        ; Load indirect address into byte of BW
0x0c1f:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0c20:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0c21:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0c22:     A0 00 12         STAL 0012          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c25:     D4 D2            LDBW [PC-0x2e]     ; Load indirect PC offset by N address into word of BW
0x0c27:     C1 C3 CB         LDBL C3CB          ; Load direct address into byte of BL
0x0c2a:     A0 CE CF         STAL CECF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c2d:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0c2f:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0c30:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0c31:     A0 D2 C1         STAL D2C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c34:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0c35:     C7               ???                ; Unknown. Illegal?
0x0c36:     C5 00            LDAL AW, 0         ; Load index mode register address into BL (view supplemental material)
0x0c38:     22 C5            CLR  C, 5         ; Clear byte of explicit register by 1 + const.
0x0c3a:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0c3b:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0c3d:     D2 A0 C4         LDBW [A0C4]        ; Load indirect address into byte of BW
0x0c40:     C1 D4 C1         LDBL D4C1          ; Load direct address into byte of BL
0x0c43:     A0 D0 C1         STAL D0C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c46:     D4 D4            LDBW [PC-0x2c]     ; Load indirect PC offset by N address into word of BW
0x0c48:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0c4a:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0c4b:     A0 C3 CF         STAL C3CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c4e:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0c50:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c53:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0c54:     D2 AC D8         LDBW [ACD8]        ; Load indirect address into byte of BW
0x0c57:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0c58:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x0c59:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0c5a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c5d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x0c60:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x0c63:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0c64:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0c65:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c68:     00               HLT                ; Halts the CPU
0x0c69:     00               HLT                ; Halts the CPU
0x0c6a:     00               HLT                ; Halts the CPU
0x0c6b:     00               HLT                ; Halts the CPU
0x0c6c:     00               HLT                ; Halts the CPU
0x0c6d:     00               HLT                ; Halts the CPU
0x0c6e:     00               HLT                ; Halts the CPU
0x0c6f:     00               HLT                ; Halts the CPU
0x0c70:     00               HLT                ; Halts the CPU
0x0c71:     00               HLT                ; Halts the CPU
0x0c72:     00               HLT                ; Halts the CPU
0x0c73:     00               HLT                ; Halts the CPU
0x0c74:     00               HLT                ; Halts the CPU
0x0c75:     00               HLT                ; Halts the CPU
0x0c76:     00               HLT                ; Halts the CPU
0x0c77:     00               HLT                ; Halts the CPU
0x0c78:     00               HLT                ; Halts the CPU
0x0c79:     00               HLT                ; Halts the CPU
0x0c7a:     00               HLT                ; Halts the CPU
0x0c7b:     00               HLT                ; Halts the CPU
0x0c7c:     00               HLT                ; Halts the CPU
0x0c7d:     00               HLT                ; Halts the CPU
0x0c7e:     00               HLT                ; Halts the CPU
0x0c7f:     00               HLT                ; Halts the CPU
0x0c80:     00               HLT                ; Halts the CPU
0x0c81:     78 0A D8         JSR  #0AD8         ; Jump to subroutine at literal address (not possible?)
0x0c84:     D7 D2            ???                ; Stores AW into any register in register file
0x0c86:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0c87:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0c89:     A0 C5 D2         STAL C5D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c8c:     D2 CF D2         LDBW [CFD2]        ; Load indirect address into byte of BW
0x0c8f:     A0 BF BF         STAL BFBF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c92:     A0 00 0A         STAL 000A          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0c95:     D2 C5 D0         LDBW [C5D0]        ; Load indirect address into byte of BW
0x0c98:     C5 C1            LDAL C , 1         ; Load index mode register address into BL (view supplemental material)
0x0c9a:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0c9c:     BF               SAWP               ; Store word from address in P into implicit AW
0x0c9d:     BF               SAWP               ; Store word from address in P into implicit AW
0x0c9e:     A0 00 20         STAL 0020          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ca1:     D4 CF            LDBW [PC-0x31]     ; Load indirect PC offset by N address into word of BW
0x0ca3:     D3 A0            LDBW (PC-0x60)     ; Load direct PC offset by N address into word of BW
0x0ca5:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0ca6:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0ca7:     C4 D5            LDBL [PC-0x2b]     ; Load indirect PC offset by N address into byte of BL
0x0ca9:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0caa:     C5 A0            LDAL SW, 0         ; Load index mode register address into BL (view supplemental material)
0x0cac:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0cad:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0cae:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0cb0:     D0 D2 C5         LDBW #D2C5         ; Load literal address into byte of BW
0x0cb3:     D3 C5            LDBW (PC-0x3b)     ; Load direct PC offset by N address into word of BW
0x0cb5:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0cb6:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0cb8:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0cb9:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0cba:     A0 CD C5         STAL CDC5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0cbd:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0cbe:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0cbf:     D2 D9 00         LDBW [D900]        ; Load indirect address into byte of BW
0x0cc2:     23 C5            IVR  C, 5         ; Invert byte of explicit register by 1 + const.
0x0cc4:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0cc5:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0cc7:     D2 A0 C4         LDBW [A0C4]        ; Load indirect address into byte of BW
0x0cca:     C1 D4 C1         LDBL D4C1          ; Load direct address into byte of BL
0x0ccd:     A0 C6 CF         STAL C6CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0cd0:     D2 CD C1         LDBW [CDC1]        ; Load indirect address into byte of BW
0x0cd3:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x0cd5:     C3 CF            LDBL (PC-0x31)     ; Load direct PC offset by N address into byte of BL
0x0cd7:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0cd9:     A0 AD AD         STAL ADAD          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0cdc:     A0 A8 D7         STAL A8D7          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0cdf:     A0 CF D2         STAL CFD2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ce2:     A0 C9 A9         STAL C9A9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ce5:     A0 00 14         STAL 0014          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ce8:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0ce9:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0cea:     D6 C1            ???                ; Swap high/low bytes in 16 bit value. Register in LOW nibble. (?)
0x0cec:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0ced:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0cee:     C4 A0            LDBL [PC-0x60]     ; Load indirect PC offset by N address into byte of BL
0x0cf0:     D4 D2            LDBW [PC-0x2e]     ; Load indirect PC offset by N address into word of BW
0x0cf2:     C1 C3 CB         LDBL C3CB          ; Load direct address into byte of BL
0x0cf5:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0cf8:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0cf9:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0cfc:     08               CL                 ; Complement Link
0x0cfd:     00               HLT                ; Halts the CPU
0x0cfe:     78 0B 50         JSR  #0B50         ; Jump to subroutine at literal address (not possible?)
0x0d01:     00               HLT                ; Halts the CPU
0x0d02:     00               HLT                ; Halts the CPU
0x0d03:     00               HLT                ; Halts the CPU
0x0d04:     47 C6            ???                ; Special 2 byte instruction. See supplemental material.
0x0d06:     C4 C3            LDBL [PC-0x3d]     ; Load indirect PC offset by N address into byte of BL
0x0d08:     A0 C5 D8         STAL C5D8          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d0b:     C5 C3            LDAL C , 3         ; Load index mode register address into BL (view supplemental material)
0x0d0d:     D5 D4            LDAW, 4         ; Load index mode register address into BW (view supplemental material)
0x0d0f:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0d10:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0d11:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d12:     A0 C5 D2         STAL C5D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d15:     D2 CF D2         LDBW [CFD2]        ; Load indirect address into byte of BW
0x0d18:     A0 AD AD         STAL ADAD          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d1b:     A0 C4 C9         STAL C4C9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d1e:     D3 CB            LDBW (PC-0x35)     ; Load direct PC offset by N address into word of BW
0x0d20:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d23:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0d24:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0d27:     BD               SAWS               ; Store word from address in S into implicit AW
0x0d28:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0d29:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0d2a:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0d2b:     A0 D4 D2         STAL D4D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d2e:     C1 C3 CB         LDBL C3CB          ; Load direct address into byte of BL
0x0d31:     A0 CE D5         STAL CED5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d34:     CD               LBLS               ; Load byte from address in S into implicit BL
0x0d35:     C2 C5 D2         LDBL [C5D2]        ; Load indirect address into byte of BL
0x0d38:     BD               SAWS               ; Store word from address in S into implicit AW
0x0d39:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0d3a:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0d3b:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x0d3c:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0d3d:     A0 C5 D2         STAL C5D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d40:     D2 CF D2         LDBW [CFD2]        ; Load indirect address into byte of BW
0x0d43:     A0 C3 CF         STAL C3CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d46:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0d48:     BD               SAWS               ; Store word from address in S into implicit AW
0x0d49:     A0 D8 D8         STAL D8D8          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d4c:     00               HLT                ; Halts the CPU
0x0d4d:     26 C5            RRR  C, 5         ; Rotate byte of explicit register right by 1 + const.
0x0d4f:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d50:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0d52:     D2 A0 D0         LDBW [A0D0]        ; Load indirect address into byte of BW
0x0d55:     D2 C9 CE         LDBW [C9CE]        ; Load indirect address into byte of BW
0x0d58:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0d5a:     D2 A0 CF         LDBW [A0CF]        ; Load indirect address into byte of BW
0x0d5d:     D0 D4 C9         LDBW #D4C9         ; Load literal address into byte of BW
0x0d60:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0d61:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d62:     A0 AD AD         STAL ADAD          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d65:     A0 A8 B0         STAL A8B0          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d68:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0d69:     B1 AC B2         STAW ACB2          ; Store AW into direct address
0x0d6c:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0d6d:     B3 AC            STAW (PC-0x54)     ; Store word of AW into direct PC offset by N address
0x0d6f:     B4 AC            STAW [PC-0x54]     ; Store word of AW into indirect PC offset by N address
0x0d71:     B6               ???                ; Writes -1 to AH at interrupt level 1. See instructions C6 and 1F
0x0d72:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0d73:     A0 00 18         STAL 0018          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d76:     C1 D5 D4         LDBL D5D4          ; Load direct address into byte of BL
0x0d79:     F9               SBWB               ; Store word from address in BW into implicit BW
0x0d7a:     00               HLT                ; Halts the CPU
0x0d7b:     4F               XASL               ; Transfer implicit AL into SL
0x0d7c:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x0d7d:     C8               LBLA               ; Load byte from address in AW into implicit BL
0x0d7e:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0d7f:     A0 D3 C5         STAL D3C5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d82:     D1 D5 C5         LDBW D5C5          ; Load direct address into byte of BW
0x0d85:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d86:     C3 C9            LDBL (PC-0x37)     ; Load direct PC offset by N address into byte of BL
0x0d88:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d89:     C7               ???                ; Unknown. Illegal?
0x0d8a:     A0 BF BF         STAL BFBF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d8d:     A0 A8 D9         STAL A8D9          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d90:     AF               SALP               ; Store byte from address in P into implicit AL
0x0d91:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d92:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0d93:     00               HLT                ; Halts the CPU
0x0d94:     16 C6            BM   (PC-0x3a)     ; Branch if minus set to 0x3a behind PC (0x0d5c)
0x0d96:     C4 C3            LDBL [PC-0x3d]     ; Load indirect PC offset by N address into byte of BL
0x0d98:     A0 C3 CF         STAL C3CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0d9b:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0d9c:     D4 D2            LDBW [PC-0x2e]     ; Load indirect PC offset by N address into word of BW
0x0d9e:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0d9f:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0da0:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0da1:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0da3:     A0 C6 C1         STAL C6C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0da6:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x0da7:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x0da8:     D5 D2            LDAW, 2         ; Load index mode register address into BW (view supplemental material)
0x0daa:     C5 00            LDAL AW, 0         ; Load index mode register address into BL (view supplemental material)
0x0dac:     0A               RI                 ; return(cont=1) from Interrupt
0x0dad:     C5 CE C4         LDBL C , E, 0xC4   ; Load index mode register address into BL (view supplemental material)
0x0db0:     A0 C6 CF         STAL C6CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0db3:     D2 CD C1         LDBW [CDC1]        ; Load indirect address into byte of BW
0x0db6:     D4 FF            LDBW [PC-0x01]     ; Load indirect PC offset by N address into word of BW
0x0db8:     FF               SBWP               ; Store word from address in P into implicit BW
0x0db9:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dba:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dbb:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dbc:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dbd:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dbe:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dbf:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc0:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc1:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc2:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc3:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc4:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc5:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc6:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc7:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc8:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dc9:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dca:     FF               SBWP               ; Store word from address in P into implicit BW
0x0dcb:     00               HLT                ; Halts the CPU
0x0dcc:     00               HLT                ; Halts the CPU
0x0dcd:     33 80            IVR  ZW, 0         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0dcf:     C4 C1            LDBL [PC-0x3f]     ; Load indirect PC offset by N address into byte of BL
0x0dd1:     D4 C1            LDBW [PC-0x3f]     ; Load indirect PC offset by N address into word of BW
0x0dd3:     A0 D0 C1         STAL D0C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0dd6:     D4 D4            LDBW [PC-0x2c]     ; Load indirect PC offset by N address into word of BW
0x0dd8:     C5 D2            LDAL, 2         ; Load index mode register address into BL (view supplemental material)
0x0dda:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0ddb:     A0 C3 CF         STAL C3CF          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0dde:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0de0:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0de3:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0de4:     D2 AC D8         LDBW [ACD8]        ; Load indirect address into byte of BW
0x0de7:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0de8:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x0de9:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0dea:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0ded:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x0df0:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x0df3:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0df4:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0df5:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0df8:     00               HLT                ; Halts the CPU
0x0df9:     00               HLT                ; Halts the CPU
0x0dfa:     00               HLT                ; Halts the CPU
0x0dfb:     00               HLT                ; Halts the CPU
0x0dfc:     00               HLT                ; Halts the CPU
0x0dfd:     00               HLT                ; Halts the CPU
0x0dfe:     00               HLT                ; Halts the CPU
0x0dff:     00               HLT                ; Halts the CPU
0x0e00:     00               HLT                ; Halts the CPU
0x0e01:     00               HLT                ; Halts the CPU
0x0e02:     00               HLT                ; Halts the CPU
0x0e03:     00               HLT                ; Halts the CPU
0x0e04:     00               HLT                ; Halts the CPU
0x0e05:     00               HLT                ; Halts the CPU
0x0e06:     00               HLT                ; Halts the CPU
0x0e07:     00               HLT                ; Halts the CPU
0x0e08:     00               HLT                ; Halts the CPU
0x0e09:     00               HLT                ; Halts the CPU
0x0e0a:     00               HLT                ; Halts the CPU
0x0e0b:     00               HLT                ; Halts the CPU
0x0e0c:     00               HLT                ; Halts the CPU
0x0e0d:     00               HLT                ; Halts the CPU
0x0e0e:     00               HLT                ; Halts the CPU
0x0e0f:     00               HLT                ; Halts the CPU
0x0e10:     00               HLT                ; Halts the CPU
0x0e11:     78 0C 15         JSR  #0C15         ; Jump to subroutine at literal address (not possible?)
0x0e14:     00               HLT                ; Halts the CPU
0x0e15:     00               HLT                ; Halts the CPU
0x0e16:     81 00 83         LDAL 0083          ; Load direct address into byte of AL
0x0e19:     00               HLT                ; Halts the CPU
0x0e1a:     00               HLT                ; Halts the CPU
0x0e1b:     00               HLT                ; Halts the CPU
0x0e1c:     00               HLT                ; Halts the CPU
0x0e1d:     01               NOP                ; No Operation
0x0e1e:     90 00 01         LDAW #0001         ; Load literal address into byte of AW
0x0e21:     00               HLT                ; Halts the CPU
0x0e22:     01               NOP                ; No Operation
0x0e23:     90 00 02         LDAW #0002         ; Load literal address into byte of AW
0x0e26:     00               HLT                ; Halts the CPU
0x0e27:     01               NOP                ; No Operation
0x0e28:     90 00 03         LDAW #0003         ; Load literal address into byte of AW
0x0e2b:     00               HLT                ; Halts the CPU
0x0e2c:     01               NOP                ; No Operation
0x0e2d:     90 00 04         LDAW #0004         ; Load literal address into byte of AW
0x0e30:     00               HLT                ; Halts the CPU
0x0e31:     01               NOP                ; No Operation
0x0e32:     90 00 05         LDAW #0005         ; Load literal address into byte of AW
0x0e35:     00               HLT                ; Halts the CPU
0x0e36:     01               NOP                ; No Operation
0x0e37:     90 00 06         LDAW #0006         ; Load literal address into byte of AW
0x0e3a:     00               HLT                ; Halts the CPU
0x0e3b:     01               NOP                ; No Operation
0x0e3c:     90 00 07         LDAW #0007         ; Load literal address into byte of AW
0x0e3f:     00               HLT                ; Halts the CPU
0x0e40:     01               NOP                ; No Operation
0x0e41:     90 00 08         LDAW #0008         ; Load literal address into byte of AW
0x0e44:     00               HLT                ; Halts the CPU
0x0e45:     01               NOP                ; No Operation
0x0e46:     90 00 09         LDAW #0009         ; Load literal address into byte of AW
0x0e49:     00               HLT                ; Halts the CPU
0x0e4a:     01               NOP                ; No Operation
0x0e4b:     90 00 0A         LDAW #000A         ; Load literal address into byte of AW
0x0e4e:     00               HLT                ; Halts the CPU
0x0e4f:     01               NOP                ; No Operation
0x0e50:     90 00 0B         LDAW #000B         ; Load literal address into byte of AW
0x0e53:     00               HLT                ; Halts the CPU
0x0e54:     01               NOP                ; No Operation
0x0e55:     90 00 0C         LDAW #000C         ; Load literal address into byte of AW
0x0e58:     00               HLT                ; Halts the CPU
0x0e59:     01               NOP                ; No Operation
0x0e5a:     90 00 0D         LDAW #000D         ; Load literal address into byte of AW
0x0e5d:     00               HLT                ; Halts the CPU
0x0e5e:     01               NOP                ; No Operation
0x0e5f:     90 00 0E         LDAW #000E         ; Load literal address into byte of AW
0x0e62:     00               HLT                ; Halts the CPU
0x0e63:     01               NOP                ; No Operation
0x0e64:     90 00 0F         LDAW #000F         ; Load literal address into byte of AW
0x0e67:     00               HLT                ; Halts the CPU
0x0e68:     01               NOP                ; No Operation
0x0e69:     90 00 10         LDAW #0010         ; Load literal address into byte of AW
0x0e6c:     00               HLT                ; Halts the CPU
0x0e6d:     01               NOP                ; No Operation
0x0e6e:     90 00 11         LDAW #0011         ; Load literal address into byte of AW
0x0e71:     00               HLT                ; Halts the CPU
0x0e72:     01               NOP                ; No Operation
0x0e73:     90 00 12         LDAW #0012         ; Load literal address into byte of AW
0x0e76:     00               HLT                ; Halts the CPU
0x0e77:     01               NOP                ; No Operation
0x0e78:     90 00 13         LDAW #0013         ; Load literal address into byte of AW
0x0e7b:     00               HLT                ; Halts the CPU
0x0e7c:     01               NOP                ; No Operation
0x0e7d:     90 81 00         LDAW #8100         ; Load literal address into byte of AW
0x0e80:     83 00            LDAL (PC+0x00)     ; Load direct PC offset by N address into byte of AL
0x0e82:     00               HLT                ; Halts the CPU
0x0e83:     01               NOP                ; No Operation
0x0e84:     00               HLT                ; Halts the CPU
0x0e85:     02               SF                 ; Set Fault
0x0e86:     00               HLT                ; Halts the CPU
0x0e87:     03               RF                 ; Reset Fault
0x0e88:     00               HLT                ; Halts the CPU
0x0e89:     04               EI                 ; Enable Interrupt system
0x0e8a:     00               HLT                ; Halts the CPU
0x0e8b:     05               DI                 ; Disable Interrupt system
0x0e8c:     3E               INX                ; Increment word of implicit X register
0x0e8d:     00               HLT                ; Halts the CPU
0x0e8e:     2A               CLAL               ; Clear byte of implicit AL register
0x0e8f:     0C               ELO                ; Enable Link Out
0x0e90:     8D               LALS               ; Load byte from address in S into implicit AL
0x0e91:     00               HLT                ; Halts the CPU
0x0e92:     06               SL                 ; Set Link
0x0e93:     00               HLT                ; Halts the CPU
0x0e94:     07               RL                 ; Reset Link
0x0e95:     00               HLT                ; Halts the CPU
0x0e96:     08               CL                 ; Complement Link
0x0e97:     00               HLT                ; Halts the CPU
0x0e98:     09               RSR                ; return(cont=1) from Subroutine
0x0e99:     00               HLT                ; Halts the CPU
0x0e9a:     0A               RI                 ; return(cont=1) from Interrupt
0x0e9b:     00               HLT                ; Halts the CPU
0x0e9c:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x0e9d:     00               HLT                ; Halts the CPU
0x0e9e:     0C               ELO                ; Enable Link Out
0x0e9f:     00               HLT                ; Halts the CPU
0x0ea0:     0D               PCX                ; Transfer PC to X
0x0ea1:     00               HLT                ; Halts the CPU
0x0ea2:     0E               DLY                ; Delay 4.5ms
0x0ea3:     00               HLT                ; Halts the CPU
0x0ea4:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x0ea5:     00               HLT                ; Halts the CPU
0x0ea6:     10 00            BL   (PC+0x00)     ; Branch if link set to 0x00 ahead PC (0x0ea8)
0x0ea8:     11 00            BNL  (PC+0x00)     ; Branch if link not set to 0x00 ahead PC (0x0eaa)
0x0eaa:     12 00            BF   (PC+0x00)     ; Branch if fault set to 0x00 ahead PC (0x0eac)
0x0eac:     13 00            BNF  (PC+0x00)     ; Branch if fault not set to 0x00 ahead PC (0x0eae)
0x0eae:     14 00            BZ   (PC+0x00)     ; Branch if equal to zero to 0x00 ahead PC (0x0eb0)
0x0eb0:     15 00            BNZ  (PC+0x00)     ; Branch if not equal to zero to 0x00 ahead PC (0x0eb2)
0x0eb2:     16 00            BM   (PC+0x00)     ; Branch if minus set to 0x00 ahead PC (0x0eb4)
0x0eb4:     17 00            BP   (PC+0x00)     ; Branch on positive to 0x00 ahead PC (0x0eb6)
0x0eb6:     18 00            BGZ  (PC+0x00)     ; Branch if greater than zero to 0x00 ahead PC (0x0eb8)
0x0eb8:     19 00            BLE  (PC+0x00)     ; Branch if less than or equal to zero to 0x00 ahead PC (0x0eba)
0x0eba:     1A ED            BS1  (PC-0x13)     ; Branch if sense switch 1 set to 0x13 behind PC (0x0ea9)
0x0ebc:     00               HLT                ; Halts the CPU
0x0ebd:     02               SF                 ; Set Fault
0x0ebe:     39               DCAW               ; Decrement word of implicit AW register
0x0ebf:     11 00            BNL  (PC+0x00)     ; Branch if link not set to 0x00 ahead PC (0x0ec1)
0x0ec1:     00               HLT                ; Halts the CPU
0x0ec2:     B4 00            STAW [PC+0x00]     ; Store word of AW into indirect PC offset by N address
0x0ec4:     0C               ELO                ; Enable Link Out
0x0ec5:     39               DCAW               ; Decrement word of implicit AW register
0x0ec6:     13 3A            BNF  (PC+0x3A)     ; Branch if fault not set to 0x3A ahead PC (0x0f02)
0x0ec8:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0x0eca:     B5 21            STAW BW, 1         ; Store AW into index mode register (view supplemental material)
0x0ecc:     B9               SAWB               ; Store word from address in BW into implicit AW
0x0ecd:     09               RSR                ; return(cont=1) from Subroutine
0x0ece:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x0ed0:     09               RSR                ; return(cont=1) from Subroutine
0x0ed1:     3A               CLAW               ; Clear word of implicit AW register
0x0ed2:     09               RSR                ; return(cont=1) from Subroutine
0x0ed3:     9E               LAWC               ; Load word from address in C into implicit AW
0x0ed4:     00               HLT                ; Halts the CPU
0x0ed5:     46 39            ???                ; Special 2 byte instruction. See supplemental material.
0x0ed7:     1F 95            BEP? (PC-0x6b)     ; Branch on even parity to zero to 0x6b behind PC (0x0e6e)
0x0ed9:     41 B3            SUB  SL,  BL       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0edb:     03               RF                 ; Reset Fault
0x0edc:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0edf:     00               HLT                ; Halts the CPU
0x0ee0:     00               HLT                ; Halts the CPU
0x0ee1:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x0ee3:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x0ee5:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x0ee8:     4D               XABL               ; Transfer implicit AL into BL
0x0ee9:     14 2A            BZ   (PC+0x2A)     ; Branch if equal to zero to 0x2A ahead PC (0x0f15)
0x0eeb:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x0eed:     49               SABL               ; Subtract implicit AL and BL
0x0eee:     14 25            BZ   (PC+0x25)     ; Branch if equal to zero to 0x25 ahead PC (0x0f15)
0x0ef0:     C0 B0            LDBL #B049         ; Load literal address into byte of BL
0x0ef2:     49               SABL               ; Subtract implicit AL and BL
0x0ef3:     16 25            BM   (PC+0x25)     ; Branch if minus set to 0x25 ahead PC (0x0f1a)
0x0ef5:     80 09            LDAL #0941         ; Load literal address into byte of AL
0x0ef7:     41 31            SUB  BL,  AL       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0ef9:     19 0E            BLE  (PC+0x0E)     ; Branch if less than or equal to zero to 0x0E ahead PC (0x0f09)
0x0efb:     80 11            LDAL #1141         ; Load literal address into byte of AL
0x0efd:     41 31            SUB  BL,  AL       ; Subtract bytes of two explicit registers (L - R stored in L)
0x0eff:     16 19            BM   (PC+0x19)     ; Branch if minus set to 0x19 ahead PC (0x0f1a)
0x0f01:     C0 05            LDBL #0549         ; Load literal address into byte of BL
0x0f03:     49               SABL               ; Subtract implicit AL and BL
0x0f04:     18 14            BGZ  (PC+0x14)     ; Branch if greater than zero to 0x14 ahead PC (0x0f1a)
0x0f06:     C0 0A            LDBL #0A48         ; Load literal address into byte of BL
0x0f08:     48               AABL               ; Add implicit AL and BL
0x0f09:     80 04            LDAL #0407         ; Load literal address into byte of AL
0x0f0b:     07               RL                 ; Reset Link
0x0f0c:     37 40            RLR  X,  0         ; Rotate byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x0f0e:     29               DCAL               ; Decrement byte of implicit AL register
0x0f0f:     18 FA            BGZ  (PC-0x06)     ; Branch if greater than zero to 0x6 behind PC (0x0f0b)
0x0f11:     40 35            ADD  BL,  X        ; Add bytes of two explicit registers (L + R stored in L)
0x0f13:     73 D0            JMP  (PC-0x30)     ; Jump to direct PC offset by N address  (0x0ee5)
0x0f15:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0x0f17:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x0f19:     09               RSR                ; return(cont=1) from Subroutine
0x0f1a:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x0f1c:     73 BE            JMP  (PC-0x42)     ; Jump to direct PC offset by N address  (0x0edc)
0x0f1e:     A5 00            STAL AW, 0         ; Store AL into index mode register (view supplemental material)
0x0f20:     3E               INX                ; Increment word of implicit X register
0x0f21:     39               DCAW               ; Decrement word of implicit AW register
0x0f22:     65 7B 34         LDXW, B, 0x34   ; Load index mode into word XW (view supplemental material)
0x0f25:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x0f27:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x0f29:     55 82            XFR  ZW,  BW       ; Copy word of one explicit register into other (R into L)
0x0f2b:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x0f2d:     65 01            LDXW AW, 1         ; Load index mode into word XW (view supplemental material)
0x0f2f:     5E               XAZW               ; Transfer implicit AW into ZW
0x0f30:     C0 8C            LDBL #8C8C         ; Load literal address into byte of BL
0x0f32:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x0f33:     49               SABL               ; Subtract implicit AL and BL
0x0f34:     15 09            BNZ  (PC+0x09)     ; Branch if not equal to zero to 0x09 ahead PC (0x0f3f)
0x0f36:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x0f39:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x0f3b:     5E               XAZW               ; Transfer implicit AW into ZW
0x0f3c:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x0f3e:     09               RSR                ; return(cont=1) from Subroutine
0x0f3f:     7B 18            JSR  (PC+0x18)     ; Jump to subroutine at direct PC offset by N address  (0x0f59)
0x0f41:     85 81            LDAL ZW, 1         ; Load index mode register address into AL (view supplemental material)
0x0f43:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x0f46:     3F               DCX                ; Decrement word of implicit X register
0x0f47:     18 F6            BGZ  (PC-0x0a)     ; Branch if greater than zero to 0xa behind PC (0x0f3f)
0x0f49:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x0f59)
0x0f4b:     80 A0            LDAL #A0A1         ; Load literal address into byte of AL
0x0f4d:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x0f50:     7B 07            JSR  (PC+0x07)     ; Jump to subroutine at direct PC offset by N address  (0x0f59)
0x0f52:     80 8D            LDAL #8DA1         ; Load literal address into byte of AL
0x0f54:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x0f57:     73 E0            JMP  (PC-0x20)     ; Jump to direct PC offset by N address  (0x0f39)
0x0f59:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x0f5c:     2C               SRAL               ; Shift byte of implicit AL register left
0x0f5d:     2C               SRAL               ; Shift byte of implicit AL register left
0x0f5e:     11 F9            BNL  (PC-0x07)     ; Branch if link not set to 0x7 behind PC (0x0f59)
0x0f60:     09               RSR                ; return(cont=1) from Subroutine
0x0f61:     8A               LALX               ; Load byte from address in XW into implicit AL
0x0f62:     80 A0            LDAL #A0D0         ; Load literal address into byte of AL
0x0f64:     D0 C1 D4         LDBW #C1D4         ; Load literal address into byte of BW
0x0f67:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x0f69:     D2 CE A0         LDBW [CEA0]        ; Load indirect address into byte of BW
0x0f6c:     C3 CF            LDBL (PC-0x31)     ; Load direct PC offset by N address into byte of BL
0x0f6e:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x0f70:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0f73:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0f74:     D2 AC D8         LDBW [ACD8]        ; Load indirect address into byte of BW
0x0f77:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x0f78:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x0f79:     A9               SALB               ; Store byte from address in BW into implicit AL
0x0f7a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0f7d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x0f80:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x0f83:     CF               LBLP               ; Load byte from address in P into implicit BL
0x0f84:     CE               LBLC               ; Load byte from address in C into implicit BL
0x0f85:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x0f88:     00               HLT                ; Halts the CPU
0x0f89:     00               HLT                ; Halts the CPU
0x0f8a:     00               HLT                ; Halts the CPU
0x0f8b:     00               HLT                ; Halts the CPU
0x0f8c:     00               HLT                ; Halts the CPU
0x0f8d:     00               HLT                ; Halts the CPU
0x0f8e:     00               HLT                ; Halts the CPU
0x0f8f:     00               HLT                ; Halts the CPU
0x0f90:     00               HLT                ; Halts the CPU
0x0f91:     00               HLT                ; Halts the CPU
0x0f92:     00               HLT                ; Halts the CPU
0x0f93:     00               HLT                ; Halts the CPU
0x0f94:     00               HLT                ; Halts the CPU
0x0f95:     00               HLT                ; Halts the CPU
0x0f96:     00               HLT                ; Halts the CPU
0x0f97:     00               HLT                ; Halts the CPU
0x0f98:     00               HLT                ; Halts the CPU
0x0f99:     00               HLT                ; Halts the CPU
0x0f9a:     00               HLT                ; Halts the CPU
0x0f9b:     00               HLT                ; Halts the CPU
0x0f9c:     00               HLT                ; Halts the CPU
0x0f9d:     00               HLT                ; Halts the CPU
0x0f9e:     00               HLT                ; Halts the CPU
0x0f9f:     00               HLT                ; Halts the CPU
0x0fa0:     00               HLT                ; Halts the CPU
0x0fa1:     6C 39            STXW [PC+0x39]     ; Store word of XW into indirect PC offset by N address
0x0fa3:     A3 55            STAL (PC+0x55)     ; Store byte of AL into direct PC offset by N address
0x0fa5:     60 B5 A2         LDXW #B5A2         ; Load literal word into word XW
0x0fa8:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x0faa:     5C               XAYW               ; Transfer implicit AW into YW
0x0fab:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x0fad:     65 61            LDXW YW, 1         ; Load index mode into word XW (view supplemental material)
0x0faf:     18 06            BGZ  (PC+0x06)     ; Branch if greater than zero to 0x06 ahead PC (0x0fb7)
0x0fb1:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x0fb3:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x0fb5:     5C               XAYW               ; Transfer implicit AW into YW
0x0fb6:     09               RSR                ; return(cont=1) from Subroutine
0x0fb7:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x0fba:     2C               SRAL               ; Shift byte of implicit AL register left
0x0fbb:     2C               SRAL               ; Shift byte of implicit AL register left
0x0fbc:     10 02            BL   (PC+0x02)     ; Branch if link set to 0x02 ahead PC (0x0fc0)
0x0fbe:     73 F7            JMP  (PC-0x09)     ; Jump to direct PC offset by N address  (0x0fb7)
0x0fc0:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x0fc2:     C0 84            LDBL #8449         ; Load literal address into byte of BL
0x0fc4:     49               SABL               ; Subtract implicit AL and BL
0x0fc5:     14 EA            BZ   (PC-0x16)     ; Branch if equal to zero to 0x16 behind PC (0x0fb1)
0x0fc7:     C0 8C            LDBL #8C49         ; Load literal address into byte of BL
0x0fc9:     49               SABL               ; Subtract implicit AL and BL
0x0fca:     15 08            BNZ  (PC+0x08)     ; Branch if not equal to zero to 0x08 ahead PC (0x0fd4)
0x0fcc:     A4 31            STAL [PC+0x31]     ; Store byte of AL into indirect PC offset by N address
0x0fce:     C0 C0            LDBL #C0E4         ; Load literal address into byte of BL
0x0fd0:     E4 2D            STBL [PC+0x2D]     ; Store byte of BL into indirect PC offset by N address
0x0fd2:     73 DD            JMP  (PC-0x23)     ; Jump to direct PC offset by N address  (0x0fb1)
0x0fd4:     C0 8B            LDBL #8B49         ; Load literal address into byte of BL
0x0fd6:     49               SABL               ; Subtract implicit AL and BL
0x0fd7:     15 0A            BNZ  (PC+0x0A)     ; Branch if not equal to zero to 0x0A ahead PC (0x0fe3)
0x0fd9:     C0 8C            LDBL #8CA4         ; Load literal address into byte of BL
0x0fdb:     A4 22            STAL [PC+0x22]     ; Store byte of AL into indirect PC offset by N address
0x0fdd:     C0 C2            LDBL #C2A4         ; Load literal address into byte of BL
0x0fdf:     A4 1E            STAL [PC+0x1E]     ; Store byte of AL into indirect PC offset by N address
0x0fe1:     73 CE            JMP  (PC-0x32)     ; Jump to direct PC offset by N address  (0x0fb1)
0x0fe3:     E1 F0 E2         STBL F0E2          ; Store BL into direct address
0x0fe6:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x0fe8:     49               SABL               ; Subtract implicit AL and BL
0x0fe9:     14 1B            BZ   (PC+0x1B)     ; Branch if equal to zero to 0x1B ahead PC (0x1006)
0x0feb:     C0 8B            LDBL #8B49         ; Load literal address into byte of BL
0x0fed:     49               SABL               ; Subtract implicit AL and BL
0x0fee:     14 16            BZ   (PC+0x16)     ; Branch if equal to zero to 0x16 ahead PC (0x1006)
0x0ff0:     C0 FA            LDBL #FA49         ; Load literal address into byte of BL
0x0ff2:     49               SABL               ; Subtract implicit AL and BL
0x0ff3:     18 0C            BGZ  (PC+0x0C)     ; Branch if greater than zero to 0x0C ahead PC (0x1001)
0x0ff5:     C0 E1            LDBL #E149         ; Load literal address into byte of BL
0x0ff7:     49               SABL               ; Subtract implicit AL and BL
0x0ff8:     16 04            BM   (PC+0x04)     ; Branch if minus set to 0x04 ahead PC (0x0ffe)
0x0ffa:     80 C1            LDAL #C140         ; Load literal address into byte of AL
0x0ffc:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0x0ffe:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1001:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x1003:     3F               DCX                ; Decrement word of implicit X register
0x1004:     18 E0            BGZ  (PC-0x20)     ; Branch if greater than zero to 0x20 behind PC (0x0fe6)
0x1006:     80 A0            LDAL #A0A4         ; Load literal address into byte of AL
0x1008:     A4 F5            STAL [PC-0x0b]     ; Store byte of AL into indirect PC offset by N address
0x100a:     80 8D            LDAL #8DA4         ; Load literal address into byte of AL
0x100c:     A4 F1            STAL [PC-0x0f]     ; Store byte of AL into indirect PC offset by N address
0x100e:     73 A1            JMP  (PC-0x5f)     ; Jump to direct PC offset by N address  (0x0fb1)
0x1010:     90 00 78         LDAW #0078         ; Load literal address into byte of AW
0x1013:     3A               CLAW               ; Clear word of implicit AW register
0x1014:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x1015:     55 60            XFR  YW,  AW       ; Copy word of one explicit register into other (R into L)
0x1017:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x1019:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x101b:     5C               XAYW               ; Transfer implicit AW into YW
0x101c:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x101e:     95 81            LDAW ZW, 1         ; Load index mode register address into AW (view supplemental material)
0x1020:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x1022:     91 F0 E0         LDAW F0E0          ; Load direct address into byte of AW
0x1025:     5E               XAZW               ; Transfer implicit AW into ZW
0x1026:     65 61            LDXW YW, 1         ; Load index mode into word XW (view supplemental material)
0x1028:     18 09            BGZ  (PC+0x09)     ; Branch if greater than zero to 0x09 ahead PC (0x1033)
0x102a:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x102c:     5E               XAZW               ; Transfer implicit AW into ZW
0x102d:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x102f:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1031:     5C               XAYW               ; Transfer implicit AW into YW
0x1032:     09               RSR                ; return(cont=1) from Subroutine
0x1033:     9C               LAWZ               ; Load word from address in ZW into implicit AW
0x1034:     2C               SRAL               ; Shift byte of implicit AL register left
0x1035:     10 05            BL   (PC+0x05)     ; Branch if link set to 0x05 ahead PC (0x103c)
0x1037:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x103a:     00               HLT                ; Halts the CPU
0x103b:     8F               LALP               ; Load byte from address in P into implicit AL
0x103c:     9C               LAWZ               ; Load word from address in ZW into implicit AW
0x103d:     2C               SRAL               ; Shift byte of implicit AL register left
0x103e:     2C               SRAL               ; Shift byte of implicit AL register left
0x103f:     10 02            BL   (PC+0x02)     ; Branch if link set to 0x02 ahead PC (0x1043)
0x1041:     73 F9            JMP  (PC-0x07)     ; Jump to direct PC offset by N address  (0x103c)
0x1043:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x1045:     C0 84            LDBL #8449         ; Load literal address into byte of BL
0x1047:     49               SABL               ; Subtract implicit AL and BL
0x1048:     14 E0            BZ   (PC-0x20)     ; Branch if equal to zero to 0x20 behind PC (0x102a)
0x104a:     C0 8C            LDBL #8C49         ; Load literal address into byte of BL
0x104c:     49               SABL               ; Subtract implicit AL and BL
0x104d:     15 06            BNZ  (PC+0x06)     ; Branch if not equal to zero to 0x06 ahead PC (0x1055)
0x104f:     80 20            LDAL #207B         ; Load literal address into byte of AL
0x1051:     7B 45            JSR  (PC+0x45)     ; Jump to subroutine at direct PC offset by N address  (0x1098)
0x1053:     73 39            JMP  (PC+0x39)     ; Jump to direct PC offset by N address  (0x108e)
0x1055:     C0 8B            LDBL #8B49         ; Load literal address into byte of BL
0x1057:     49               SABL               ; Subtract implicit AL and BL
0x1058:     15 04            BNZ  (PC+0x04)     ; Branch if not equal to zero to 0x04 ahead PC (0x105e)
0x105a:     80 22            LDAL #2273         ; Load literal address into byte of AL
0x105c:     73 F3            JMP  (PC-0x0d)     ; Jump to direct PC offset by N address  (0x1051)
0x105e:     80 01            LDAL #017B         ; Load literal address into byte of AL
0x1060:     7B 36            JSR  (PC+0x36)     ; Jump to subroutine at direct PC offset by N address  (0x1098)
0x1062:     85 68 FF         LDAL YW, 8, 0xFF   ; Load index mode register address into AL (view supplemental material)
0x1065:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x1067:     49               SABL               ; Subtract implicit AL and BL
0x1068:     14 1D            BZ   (PC+0x1D)     ; Branch if equal to zero to 0x1D ahead PC (0x1087)
0x106a:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x106c:     49               SABL               ; Subtract implicit AL and BL
0x106d:     14 18            BZ   (PC+0x18)     ; Branch if equal to zero to 0x18 ahead PC (0x1087)
0x106f:     4D               XABL               ; Transfer implicit AL into BL
0x1070:     17 05            BP   (PC+0x05)     ; Branch on positive to 0x05 ahead PC (0x1077)
0x1072:     C0 A0            LDBL #A049         ; Load literal address into byte of BL
0x1074:     49               SABL               ; Subtract implicit AL and BL
0x1075:     17 02            BP   (PC+0x02)     ; Branch on positive to 0x02 ahead PC (0x1079)
0x1077:     80 DF            LDAL #DFC0         ; Load literal address into byte of AL
0x1079:     C0 FF            LDBL #FF49         ; Load literal address into byte of BL
0x107b:     49               SABL               ; Subtract implicit AL and BL
0x107c:     14 0B            BZ   (PC+0x0B)     ; Branch if equal to zero to 0x0B ahead PC (0x1089)
0x107e:     C0 E0            LDBL #E049         ; Load literal address into byte of BL
0x1080:     49               SABL               ; Subtract implicit AL and BL
0x1081:     16 04            BM   (PC+0x04)     ; Branch if minus set to 0x04 ahead PC (0x1087)
0x1083:     80 C0            LDAL #C040         ; Load literal address into byte of AL
0x1085:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0x1087:     7B 0F            JSR  (PC+0x0F)     ; Jump to subroutine at direct PC offset by N address  (0x1098)
0x1089:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x108b:     3F               DCX                ; Decrement word of implicit X register
0x108c:     18 AB            BGZ  (PC-0x55)     ; Branch if greater than zero to 0x55 behind PC (0x1039)
0x108e:     00               HLT                ; Halts the CPU
0x108f:     23 3A            IVR  BL, A         ; Invert byte of explicit register by 1 + const.
0x1091:     87               ???                ; Unknown. Illegal?
0x1092:     D7 A5            ???                ; Stores AW into any register in register file
0x1094:     88               LALA               ; Load byte from address in AW into implicit AL
0x1095:     04               EI                 ; Enable Interrupt system
0x1096:     7B 05            JSR  (PC+0x05)     ; Jump to subroutine at direct PC offset by N address  (0x109d)
0x1098:     A5 88 03         STAL ZW, 8, 0x03   ; Store AL into index mode register (view supplemental material)
0x109b:     73 92            JMP  (PC-0x6e)     ; Jump to direct PC offset by N address  (0x102f)
0x109d:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0x109f:     9C               LAWZ               ; Load word from address in ZW into implicit AW
0x10a0:     C0 10            LDBL #104A         ; Load literal address into byte of BL
0x10a2:     4A               NABL               ; AND implicit AL and BL
0x10a3:     14 F9            BZ   (PC-0x07)     ; Branch if equal to zero to 0x7 behind PC (0x109e)
0x10a5:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x10a7:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x10a8:     09               RSR                ; return(cont=1) from Subroutine
0x10a9:     00               HLT                ; Halts the CPU
0x10aa:     0A               RI                 ; return(cont=1) from Interrupt
0x10ab:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x10ae:     CE               LBLC               ; Load byte from address in C into implicit BL
0x10af:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x10b2:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x10b3:     CE               LBLC               ; Load byte from address in C into implicit BL
0x10b4:     D4 8C            LDBW [PC-0x74]     ; Load indirect PC offset by N address into word of BW
0x10b6:     80 6D            LDAL #6DA2         ; Load literal address into byte of AL
0x10b8:     A2 55 82         STAL [5582]        ; Store AL into indirect address
0x10bb:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x10bd:     65 01            LDXW AW, 1         ; Load index mode into word XW (view supplemental material)
0x10bf:     5E               XAZW               ; Transfer implicit AW into ZW
0x10c0:     C0 8C            LDBL #8C8C         ; Load literal address into byte of BL
0x10c2:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x10c3:     49               SABL               ; Subtract implicit AL and BL
0x10c4:     15 09            BNZ  (PC+0x09)     ; Branch if not equal to zero to 0x09 ahead PC (0x10cf)
0x10c6:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x10c9:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x10cb:     5E               XAZW               ; Transfer implicit AW into ZW
0x10cc:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x10ce:     09               RSR                ; return(cont=1) from Subroutine
0x10cf:     7B 18            JSR  (PC+0x18)     ; Jump to subroutine at direct PC offset by N address  (0x10e9)
0x10d1:     85 81            LDAL ZW, 1         ; Load index mode register address into AL (view supplemental material)
0x10d3:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x10d6:     3F               DCX                ; Decrement word of implicit X register
0x10d7:     18 F6            BGZ  (PC-0x0a)     ; Branch if greater than zero to 0xa behind PC (0x10cf)
0x10d9:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x10e9)
0x10db:     80 A0            LDAL #A0A1         ; Load literal address into byte of AL
0x10dd:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x10e0:     7B 07            JSR  (PC+0x07)     ; Jump to subroutine at direct PC offset by N address  (0x10e9)
0x10e2:     80 8D            LDAL #8DA1         ; Load literal address into byte of AL
0x10e4:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x10e7:     73 E0            JMP  (PC-0x20)     ; Jump to direct PC offset by N address  (0x10c9)
0x10e9:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x10ec:     2C               SRAL               ; Shift byte of implicit AL register left
0x10ed:     2C               SRAL               ; Shift byte of implicit AL register left
0x10ee:     11 F9            BNL  (PC-0x07)     ; Branch if link not set to 0x7 behind PC (0x10e9)
0x10f0:     09               RSR                ; return(cont=1) from Subroutine
0x10f1:     8A               LALX               ; Load byte from address in XW into implicit AL
0x10f2:     80 A0            LDAL #A0D0         ; Load literal address into byte of AL
0x10f4:     D0 C1 D4         LDBW #C1D4         ; Load literal address into byte of BW
0x10f7:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x10f9:     D2 CE A0         LDBW [CEA0]        ; Load indirect address into byte of BW
0x10fc:     C3 CF            LDBL (PC-0x31)     ; Load direct PC offset by N address into byte of BL
0x10fe:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x1100:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1103:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x1104:     D2 AC D8         LDBW [ACD8]        ; Load indirect address into byte of BW
0x1107:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x1108:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x1109:     A9               SALB               ; Store byte from address in BW into implicit AL
0x110a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x110d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x1110:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x1113:     CF               LBLP               ; Load byte from address in P into implicit BL
0x1114:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1115:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1118:     00               HLT                ; Halts the CPU
0x1119:     00               HLT                ; Halts the CPU
0x111a:     00               HLT                ; Halts the CPU
0x111b:     00               HLT                ; Halts the CPU
0x111c:     00               HLT                ; Halts the CPU
0x111d:     00               HLT                ; Halts the CPU
0x111e:     00               HLT                ; Halts the CPU
0x111f:     00               HLT                ; Halts the CPU
0x1120:     00               HLT                ; Halts the CPU
0x1121:     00               HLT                ; Halts the CPU
0x1122:     00               HLT                ; Halts the CPU
0x1123:     00               HLT                ; Halts the CPU
0x1124:     00               HLT                ; Halts the CPU
0x1125:     00               HLT                ; Halts the CPU
0x1126:     00               HLT                ; Halts the CPU
0x1127:     00               HLT                ; Halts the CPU
0x1128:     00               HLT                ; Halts the CPU
0x1129:     00               HLT                ; Halts the CPU
0x112a:     00               HLT                ; Halts the CPU
0x112b:     00               HLT                ; Halts the CPU
0x112c:     00               HLT                ; Halts the CPU
0x112d:     00               HLT                ; Halts the CPU
0x112e:     00               HLT                ; Halts the CPU
0x112f:     00               HLT                ; Halts the CPU
0x1130:     00               HLT                ; Halts the CPU
0x1131:     78 3A AA         JSR  #3AAA         ; Jump to subroutine at literal address (not possible?)
0x1134:     7B 5A            JSR  (PC+0x5A)     ; Jump to subroutine at direct PC offset by N address  (0x1190)
0x1136:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x1138:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x113a:     55 82            XFR  ZW,  BW       ; Copy word of one explicit register into other (R into L)
0x113c:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x113e:     65 01            LDXW AW, 1         ; Load index mode into word XW (view supplemental material)
0x1140:     5E               XAZW               ; Transfer implicit AW into ZW
0x1141:     C0 8C            LDBL #8C8C         ; Load literal address into byte of BL
0x1143:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x1144:     49               SABL               ; Subtract implicit AL and BL
0x1145:     15 0D            BNZ  (PC+0x0D)     ; Branch if not equal to zero to 0x0D ahead PC (0x1154)
0x1147:     C0 7F            LDBL #7F44         ; Load literal address into byte of BL
0x1149:     44 31            ORE  BL,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x114b:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x114e:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1150:     5E               XAZW               ; Transfer implicit AW into ZW
0x1151:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1153:     09               RSR                ; return(cont=1) from Subroutine
0x1154:     79 00 87         JSR  0087          ; Jump to subroutine at direct address
0x1157:     85 81            LDAL ZW, 1         ; Load index mode register address into AL (view supplemental material)
0x1159:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x115b:     49               SABL               ; Subtract implicit AL and BL
0x115c:     14 42            BZ   (PC+0x42)     ; Branch if equal to zero to 0x42 ahead PC (0x11a0)
0x115e:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x1160:     49               SABL               ; Subtract implicit AL and BL
0x1161:     14 3D            BZ   (PC+0x3D)     ; Branch if equal to zero to 0x3D ahead PC (0x11a0)
0x1163:     C0 7F            LDBL #7F44         ; Load literal address into byte of BL
0x1165:     44 31            ORE  BL,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x1167:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x116a:     3F               DCX                ; Decrement word of implicit X register
0x116b:     18 E7            BGZ  (PC-0x19)     ; Branch if greater than zero to 0x19 behind PC (0x1154)
0x116d:     7B 4C            JSR  (PC+0x4C)     ; Jump to subroutine at direct PC offset by N address  (0x11bb)
0x116f:     80 A0            LDAL #A0C0         ; Load literal address into byte of AL
0x1171:     C0 7F            LDBL #7F44         ; Load literal address into byte of BL
0x1173:     44 31            ORE  BL,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x1175:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1178:     7B 41            JSR  (PC+0x41)     ; Jump to subroutine at direct PC offset by N address  (0x11bb)
0x117a:     80 8D            LDAL #8DC0         ; Load literal address into byte of AL
0x117c:     C0 7F            LDBL #7F44         ; Load literal address into byte of BL
0x117e:     44 31            ORE  BL,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x1180:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1183:     7B 36            JSR  (PC+0x36)     ; Jump to subroutine at direct PC offset by N address  (0x11bb)
0x1185:     80 8A            LDAL #8AC0         ; Load literal address into byte of AL
0x1187:     C0 7F            LDBL #7F44         ; Load literal address into byte of BL
0x1189:     44 31            ORE  BL,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x118b:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x118e:     73 BE            JMP  (PC-0x42)     ; Jump to direct PC offset by N address  (0x114e)
0x1190:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x1193:     C0 05            LDBL #0542         ; Load literal address into byte of BL
0x1195:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0x1197:     49               SABL               ; Subtract implicit AL and BL
0x1198:     15 16            BNZ  (PC+0x16)     ; Branch if not equal to zero to 0x16 ahead PC (0x11b0)
0x119a:     09               RSR                ; return(cont=1) from Subroutine
0x119b:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x119e:     00               HLT                ; Halts the CPU
0x119f:     95 7B 19         LDAW, B, 0x19   ; Load index mode register address into AW (view supplemental material)
0x11a2:     80 F2            LDAL #F2A1         ; Load literal address into byte of AL
0x11a4:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x11a7:     7B 12            JSR  (PC+0x12)     ; Jump to subroutine at direct PC offset by N address  (0x11bb)
0x11a9:     80 F5            LDAL #F5A1         ; Load literal address into byte of AL
0x11ab:     A1 3A 00         STAL 3A00          ; Store AL into direct address
0x11ae:     2C               SRAL               ; Shift byte of implicit AL register left
0x11af:     3B               IVAW               ; Invert word of implicit AW register
0x11b0:     22 F0            CLR 0         ; Clear byte of explicit register by 1 + const.
0x11b2:     E0 73 BA         STBL 73BA          ; Store BL into PC address (PC)- <- X (Opposite 60)
0x11b5:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x11b8:     C0 05            LDBL #0542         ; Load literal address into byte of BL
0x11ba:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0x11bc:     49               SABL               ; Subtract implicit AL and BL
0x11bd:     15 F6            BNZ  (PC-0x0a)     ; Branch if not equal to zero to 0xa behind PC (0x11b5)
0x11bf:     09               RSR                ; return(cont=1) from Subroutine
0x11c0:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x11c3:     2C               SRAL               ; Shift byte of implicit AL register left
0x11c4:     11 CF            BNL  (PC-0x31)     ; Branch if link not set to 0x31 behind PC (0x1195)
0x11c6:     C0 09            LDBL #0942         ; Load literal address into byte of BL
0x11c8:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0x11ca:     49               SABL               ; Subtract implicit AL and BL
0x11cb:     15 F3            BNZ  (PC-0x0d)     ; Branch if not equal to zero to 0xd behind PC (0x11c0)
0x11cd:     09               RSR                ; return(cont=1) from Subroutine
0x11ce:     00               HLT                ; Halts the CPU
0x11cf:     0A               RI                 ; return(cont=1) from Interrupt
0x11d0:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x11d3:     CE               LBLC               ; Load byte from address in C into implicit BL
0x11d4:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x11d7:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x11d8:     CE               LBLC               ; Load byte from address in C into implicit BL
0x11d9:     D4 90            LDBW [PC-0x70]     ; Load indirect PC offset by N address into word of BW
0x11db:     00               HLT                ; Halts the CPU
0x11dc:     00               HLT                ; Halts the CPU
0x11dd:     21 00            DCR  AH, 0         ; Decrement byte of explicit register by 1 + const.
0x11df:     78 3B 4E         JSR  #3B4E         ; Jump to subroutine at literal address (not possible?)
0x11e2:     55 60            XFR  YW,  AW       ; Copy word of one explicit register into other (R into L)
0x11e4:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x11e6:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x11e8:     5C               XAYW               ; Transfer implicit AW into YW
0x11e9:     B1 00 C5         STAW 00C5          ; Store AW into direct address
0x11ec:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x11ee:     95 81            LDAW ZW, 1         ; Load index mode register address into AW (view supplemental material)
0x11f0:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x11f2:     90 F0 E0         LDAW #F0E0         ; Load literal address into byte of AW
0x11f5:     38               INAW               ; Increment word of implicit AW register
0x11f6:     5E               XAZW               ; Transfer implicit AW into ZW
0x11f7:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x11f9:     65 61            LDXW YW, 1         ; Load index mode into word XW (view supplemental material)
0x11fb:     18 0B            BGZ  (PC+0x0B)     ; Branch if greater than zero to 0x0B ahead PC (0x1208)
0x11fd:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x11ff:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1201:     5C               XAYW               ; Transfer implicit AW into YW
0x1202:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1204:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1206:     5E               XAZW               ; Transfer implicit AW into ZW
0x1207:     09               RSR                ; return(cont=1) from Subroutine
0x1208:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x1209:     2C               SRAL               ; Shift byte of implicit AL register left
0x120a:     10 36            BL   (PC+0x36)     ; Branch if link set to 0x36 ahead PC (0x1242)
0x120c:     D0 01 2C         LDBW #012C         ; Load literal address into byte of BW
0x120f:     FD               SBWS               ; Store word from address in S into implicit BW
0x1210:     2C               SRAL               ; Shift byte of implicit AL register left
0x1211:     10 1C            BL   (PC+0x1C)     ; Branch if link set to 0x1C ahead PC (0x122f)
0x1213:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x1214:     2C               SRAL               ; Shift byte of implicit AL register left
0x1215:     10 2B            BL   (PC+0x2B)     ; Branch if link set to 0x2B ahead PC (0x1242)
0x1217:     DD               LBWS               ; Load byte from address in S into implicit BW
0x1218:     31 20            DCR  BW, 0         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x121a:     FD               SBWS               ; Store word from address in S into implicit BW
0x121b:     0E               DLY                ; Delay 4.5ms
0x121c:     17 F2            BP   (PC-0x0e)     ; Branch on positive to 0xe behind PC (0x1210)
0x121e:     A5 88 03         STAL ZW, 8, 0x03   ; Store AL into index mode register (view supplemental material)
0x1221:     A5 88 02         STAL ZW, 8, 0x02   ; Store AL into index mode register (view supplemental material)
0x1224:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x1225:     2C               SRAL               ; Shift byte of implicit AL register left
0x1226:     10 1A            BL   (PC+0x1A)     ; Branch if link set to 0x1A ahead PC (0x1242)
0x1228:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x122b:     01               NOP                ; No Operation
0x122c:     14 73            BZ   (PC+0x73)     ; Branch if equal to zero to 0x73 ahead PC (0x12a1)
0x122e:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x122f:     2C               SRAL               ; Shift byte of implicit AL register left
0x1230:     11 07            BNL  (PC+0x07)     ; Branch if link not set to 0x07 ahead PC (0x1239)
0x1232:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x1235:     00               HLT                ; Halts the CPU
0x1236:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x1237:     73 05            JMP  (PC+0x05)     ; Jump to direct PC offset by N address  (0x123e)
0x1239:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x123c:     00               HLT                ; Halts the CPU
0x123d:     E4 8C            STBL [PC-0x74]     ; Store byte of BL into indirect PC offset by N address
0x123f:     2C               SRAL               ; Shift byte of implicit AL register left
0x1240:     11 FC            BNL  (PC-0x04)     ; Branch if link not set to 0x4 behind PC (0x123e)
0x1242:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x1244:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x1246:     49               SABL               ; Subtract implicit AL and BL
0x1247:     14 2E            BZ   (PC+0x2E)     ; Branch if equal to zero to 0x2E ahead PC (0x1277)
0x1249:     C0 84            LDBL #8449         ; Load literal address into byte of BL
0x124b:     49               SABL               ; Subtract implicit AL and BL
0x124c:     14 AF            BZ   (PC-0x51)     ; Branch if equal to zero to 0x51 behind PC (0x11fd)
0x124e:     C0 8C            LDBL #8C49         ; Load literal address into byte of BL
0x1250:     49               SABL               ; Subtract implicit AL and BL
0x1251:     14 24            BZ   (PC+0x24)     ; Branch if equal to zero to 0x24 ahead PC (0x1277)
0x1253:     C0 8B            LDBL #8B49         ; Load literal address into byte of BL
0x1255:     49               SABL               ; Subtract implicit AL and BL
0x1256:     14 1F            BZ   (PC+0x1F)     ; Branch if equal to zero to 0x1F ahead PC (0x1277)
0x1258:     C0 8E            LDBL #8E46         ; Load literal address into byte of BL
0x125a:     46 80            ???                ; Special 2 byte instruction. See supplemental material.
0x125c:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x125e:     09               RSR                ; return(cont=1) from Subroutine
0x125f:     7B 18            JSR  (PC+0x18)     ; Jump to subroutine at direct PC offset by N address  (0x1279)
0x1261:     85 81            LDAL ZW, 1         ; Load index mode register address into AL (view supplemental material)
0x1263:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1266:     3F               DCX                ; Decrement word of implicit X register
0x1267:     18 F6            BGZ  (PC-0x0a)     ; Branch if greater than zero to 0xa behind PC (0x125f)
0x1269:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x1279)
0x126b:     80 A0            LDAL #A0A1         ; Load literal address into byte of AL
0x126d:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1270:     7B 07            JSR  (PC+0x07)     ; Jump to subroutine at direct PC offset by N address  (0x1279)
0x1272:     80 8D            LDAL #8DA1         ; Load literal address into byte of AL
0x1274:     A1 F0 E0         STAL F0E0          ; Store AL into direct address
0x1277:     73 E0            JMP  (PC-0x20)     ; Jump to direct PC offset by N address  (0x1259)
0x1279:     81 F0 E1         LDAL F0E1          ; Load direct address into byte of AL
0x127c:     2C               SRAL               ; Shift byte of implicit AL register left
0x127d:     2C               SRAL               ; Shift byte of implicit AL register left
0x127e:     11 F9            BNL  (PC-0x07)     ; Branch if link not set to 0x7 behind PC (0x1279)
0x1280:     09               RSR                ; return(cont=1) from Subroutine
0x1281:     8A               LALX               ; Load byte from address in XW into implicit AL
0x1282:     80 A0            LDAL #A0D0         ; Load literal address into byte of AL
0x1284:     D0 C1 D4         LDBW #C1D4         ; Load literal address into byte of BW
0x1287:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x1289:     D2 CE A0         LDBW [CEA0]        ; Load indirect address into byte of BW
0x128c:     C3 CF            LDBL (PC-0x31)     ; Load direct PC offset by N address into byte of BL
0x128e:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x1290:     A0 A8 C1         STAL A8C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1293:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x1294:     D2 AC D8         LDBW [ACD8]        ; Load indirect address into byte of BW
0x1297:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x1298:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x1299:     A9               SALB               ; Store byte from address in BW into implicit AL
0x129a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x129d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x12a0:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x12a3:     CF               LBLP               ; Load byte from address in P into implicit BL
0x12a4:     CE               LBLC               ; Load byte from address in C into implicit BL
0x12a5:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x12a8:     00               HLT                ; Halts the CPU
0x12a9:     00               HLT                ; Halts the CPU
0x12aa:     00               HLT                ; Halts the CPU
0x12ab:     00               HLT                ; Halts the CPU
0x12ac:     00               HLT                ; Halts the CPU
0x12ad:     00               HLT                ; Halts the CPU
0x12ae:     00               HLT                ; Halts the CPU
0x12af:     00               HLT                ; Halts the CPU
0x12b0:     00               HLT                ; Halts the CPU
0x12b1:     00               HLT                ; Halts the CPU
0x12b2:     00               HLT                ; Halts the CPU
0x12b3:     00               HLT                ; Halts the CPU
0x12b4:     00               HLT                ; Halts the CPU
0x12b5:     00               HLT                ; Halts the CPU
0x12b6:     00               HLT                ; Halts the CPU
0x12b7:     00               HLT                ; Halts the CPU
0x12b8:     00               HLT                ; Halts the CPU
0x12b9:     00               HLT                ; Halts the CPU
0x12ba:     00               HLT                ; Halts the CPU
0x12bb:     00               HLT                ; Halts the CPU
0x12bc:     00               HLT                ; Halts the CPU
0x12bd:     00               HLT                ; Halts the CPU
0x12be:     00               HLT                ; Halts the CPU
0x12bf:     00               HLT                ; Halts the CPU
0x12c0:     00               HLT                ; Halts the CPU
0x12c1:     78 3B C6         JSR  #3BC6         ; Jump to subroutine at literal address (not possible?)
0x12c4:     49               SABL               ; Subtract implicit AL and BL
0x12c5:     14 1A            BZ   (PC+0x1A)     ; Branch if equal to zero to 0x1A ahead PC (0x12e1)
0x12c7:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x12c9:     49               SABL               ; Subtract implicit AL and BL
0x12ca:     14 15            BZ   (PC+0x15)     ; Branch if equal to zero to 0x15 ahead PC (0x12e1)
0x12cc:     C0 A0            LDBL #A049         ; Load literal address into byte of BL
0x12ce:     49               SABL               ; Subtract implicit AL and BL
0x12cf:     10 02            BL   (PC+0x02)     ; Branch if link set to 0x02 ahead PC (0x12d3)
0x12d1:     80 DF            LDAL #DFC0         ; Load literal address into byte of AL
0x12d3:     C0 FF            LDBL #FF49         ; Load literal address into byte of BL
0x12d5:     49               SABL               ; Subtract implicit AL and BL
0x12d6:     14 0B            BZ   (PC+0x0B)     ; Branch if equal to zero to 0x0B ahead PC (0x12e3)
0x12d8:     C0 E0            LDBL #E049         ; Load literal address into byte of BL
0x12da:     49               SABL               ; Subtract implicit AL and BL
0x12db:     16 04            BM   (PC+0x04)     ; Branch if minus set to 0x04 ahead PC (0x12e1)
0x12dd:     80 C0            LDAL #C040         ; Load literal address into byte of AL
0x12df:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0x12e1:     7B 13            JSR  (PC+0x13)     ; Jump to subroutine at direct PC offset by N address  (0x12f6)
0x12e3:     3F               DCX                ; Decrement word of implicit X register
0x12e4:     19 09            BLE  (PC+0x09)     ; Branch if less than or equal to zero to 0x09 ahead PC (0x12ef)
0x12e6:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x12e8:     49               SABL               ; Subtract implicit AL and BL
0x12e9:     14 87            BZ   (PC-0x79)     ; Branch if equal to zero to 0x79 behind PC (0x1272)
0x12eb:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x12ed:     73 BF            JMP  (PC-0x41)     ; Jump to direct PC offset by N address  (0x12ae)
0x12ef:     80 8D            LDAL #8D7B         ; Load literal address into byte of AL
0x12f1:     7B 03            JSR  (PC+0x03)     ; Jump to subroutine at direct PC offset by N address  (0x12f6)
0x12f3:     71 00 1B         JMP  001B          ; Jump to direct address
0x12f6:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0x12f8:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x12f9:     2C               SRAL               ; Shift byte of implicit AL register left
0x12fa:     2C               SRAL               ; Shift byte of implicit AL register left
0x12fb:     2C               SRAL               ; Shift byte of implicit AL register left
0x12fc:     2C               SRAL               ; Shift byte of implicit AL register left
0x12fd:     11 07            BNL  (PC+0x07)     ; Branch if link not set to 0x07 ahead PC (0x1306)
0x12ff:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x1300:     2C               SRAL               ; Shift byte of implicit AL register left
0x1301:     2C               SRAL               ; Shift byte of implicit AL register left
0x1302:     2C               SRAL               ; Shift byte of implicit AL register left
0x1303:     2C               SRAL               ; Shift byte of implicit AL register left
0x1304:     10 06            BL   (PC+0x06)     ; Branch if link set to 0x06 ahead PC (0x130c)
0x1306:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x1308:     A5 88 FF         STAL ZW, 8, 0xFF   ; Store AL into index mode register (view supplemental material)
0x130b:     09               RSR                ; return(cont=1) from Subroutine
0x130c:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x130e:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1310:     90 00 00         LDAW #0000         ; Load literal address into byte of AW
0x1313:     5C               XAYW               ; Transfer implicit AW into YW
0x1314:     71 00 17         JMP  0017          ; Jump to direct address
0x1317:     00               HLT                ; Halts the CPU
0x1318:     17 C1            BP   (PC-0x3f)     ; Branch on positive to 0x3f behind PC (0x12db)
0x131a:     D4 D4            LDBW [PC-0x2c]     ; Load indirect PC offset by N address into word of BW
0x131c:     CE               LBLC               ; Load byte from address in C into implicit BL
0x131d:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1320:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x1321:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1322:     D4 A0            LDBW [PC-0x60]     ; Load indirect PC offset by N address into word of BW
0x1324:     AD               SALS               ; Store byte from address in S into implicit AL
0x1325:     A0 D0 C1         STAL D0C1          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1328:     D0 C5 D2         LDBW #C5D2         ; Load literal address into byte of BW
0x132b:     A0 CF D5         STAL CFD5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x132e:     D4 8D            LDBW [PC-0x73]     ; Load indirect PC offset by N address into word of BW
0x1330:     00               HLT                ; Halts the CPU
0x1331:     2E C1            ???                ; Special 2 byte instruction. See supplemental material.
0x1333:     D4 D4            LDBW [PC-0x2c]     ; Load indirect PC offset by N address into word of BW
0x1335:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1336:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1339:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x133a:     CE               LBLC               ; Load byte from address in C into implicit BL
0x133b:     D4 91            LDBW [PC-0x6f]     ; Load indirect PC offset by N address into word of BW
0x133d:     00               HLT                ; Halts the CPU
0x133e:     31 3C            DCR  MEM, C         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1340:     3E               INX                ; Increment word of implicit X register
0x1341:     A0 AD A0         STAL ADA0          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1344:     C4 C5            LDBL [PC-0x3b]     ; Load indirect PC offset by N address into byte of BL
0x1346:     D3 C5            LDBW (PC-0x3b)     ; Load direct PC offset by N address into word of BW
0x1348:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x1349:     C5 C3            LDAL C , 3         ; Load index mode register address into BL (view supplemental material)
0x134b:     D4 C5            LDBW [PC-0x3b]     ; Load indirect PC offset by N address into word of BW
0x134d:     C4 A0            LDBL [PC-0x60]     ; Load indirect PC offset by N address into byte of BL
0x134f:     CF               LBLP               ; Load byte from address in P into implicit BL
0x1350:     D2 A0 D9         LDBW [A0D9]        ; Load indirect address into byte of BW
0x1353:     CF               LBLP               ; Load byte from address in P into implicit BL
0x1354:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x1355:     C5 AF D6         LDBL SW, F, 0xD6   ; Load index mode register address into BL (view supplemental material)
0x1358:     C6               ???                ; Writes 0 to AH at interrupt level 1. See instructions B6 and 1F
0x1359:     D5 A0            LDAW SW, 0         ; Load index mode register address into BW (view supplemental material)
0x135b:     C7               ???                ; Unknown. Illegal?
0x135c:     C1 D4 C5         LDBL D4C5          ; Load direct address into byte of BL
0x135f:     A0 CF D0         STAL CFD0          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1362:     C5 CE 8D         LDBL C , E, 0x8D   ; Load index mode register address into BL (view supplemental material)
0x1365:     00               HLT                ; Halts the CPU
0x1366:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x1367:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x136a:     CE               LBLC               ; Load byte from address in C into implicit BL
0x136b:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x136e:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x136f:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1370:     D4 8D            LDBW [PC-0x73]     ; Load indirect PC offset by N address into word of BW
0x1372:     C1 00 78         LDBL 0078          ; Load direct address into byte of BL
0x1375:     3C               SRAW               ; Shift word of implicit AW register left
0x1376:     6F
0x1377:     55 60            XFR  YW,  AW       ; Copy word of one explicit register into other (R into L)
0x1379:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x137b:     55 80            XFR  ZW,  AW       ; Copy word of one explicit register into other (R into L)
0x137d:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x137f:     90 F2 06         LDAW #F206         ; Load literal address into byte of AW
0x1382:     5E               XAZW               ; Transfer implicit AW into ZW
0x1383:     80 C5            LDAL #C5AC         ; Load literal address into byte of AL
0x1385:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x1386:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x1388:     5C               XAYW               ; Transfer implicit AW into YW
0x1389:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x138b:     65 61            LDXW YW, 1         ; Load index mode into word XW (view supplemental material)
0x138d:     18 09            BGZ  (PC+0x09)     ; Branch if greater than zero to 0x09 ahead PC (0x1398)
0x138f:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1391:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1393:     5E               XAZW               ; Transfer implicit AW into ZW
0x1394:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x1396:     5C               XAYW               ; Transfer implicit AW into YW
0x1397:     09               RSR                ; return(cont=1) from Subroutine
0x1398:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x139a:     C0 84            LDBL #8449         ; Load literal address into byte of BL
0x139c:     49               SABL               ; Subtract implicit AL and BL
0x139d:     14 F0            BZ   (PC-0x10)     ; Branch if equal to zero to 0x10 behind PC (0x138f)
0x139f:     C0 8C            LDBL #8C49         ; Load literal address into byte of BL
0x13a1:     49               SABL               ; Subtract implicit AL and BL
0x13a2:     14 22            BZ   (PC+0x22)     ; Branch if equal to zero to 0x22 ahead PC (0x13c6)
0x13a4:     C0 8B            LDBL #8B49         ; Load literal address into byte of BL
0x13a6:     49               SABL               ; Subtract implicit AL and BL
0x13a7:     14 1D            BZ   (PC+0x1D)     ; Branch if equal to zero to 0x1D ahead PC (0x13c6)
0x13a9:     C0 8E            LDBL #8E49         ; Load literal address into byte of BL
0x13ab:     49               SABL               ; Subtract implicit AL and BL
0x13ac:     14 18            BZ   (PC+0x18)     ; Branch if equal to zero to 0x18 ahead PC (0x13c6)
0x13ae:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x13b0:     49               SABL               ; Subtract implicit AL and BL
0x13b1:     15 02            BNZ  (PC+0x02)     ; Branch if not equal to zero to 0x02 ahead PC (0x13b5)
0x13b3:     80 8A            LDAL #8AC0         ; Load literal address into byte of AL
0x13b5:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x13b7:     49               SABL               ; Subtract implicit AL and BL
0x13b8:     14 0C            BZ   (PC+0x0C)     ; Branch if equal to zero to 0x0C ahead PC (0x13c6)
0x13ba:     C0 A0            LDBL #A049         ; Load literal address into byte of BL
0x13bc:     49               SABL               ; Subtract implicit AL and BL
0x13bd:     10 02            BL   (PC+0x02)     ; Branch if link set to 0x02 ahead PC (0x13c1)
0x13bf:     80 DF            LDAL #DFC0         ; Load literal address into byte of AL
0x13c1:     C0 FF            LDBL #FF49         ; Load literal address into byte of BL
0x13c3:     49               SABL               ; Subtract implicit AL and BL
0x13c4:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x13c8)
0x13c6:     7B 09            JSR  (PC+0x09)     ; Jump to subroutine at direct PC offset by N address  (0x13d1)
0x13c8:     3F               DCX                ; Decrement word of implicit X register
0x13c9:     18 CD            BGZ  (PC-0x33)     ; Branch if greater than zero to 0x33 behind PC (0x1398)
0x13cb:     80 8A            LDAL #8A7B         ; Load literal address into byte of AL
0x13cd:     7B 02            JSR  (PC+0x02)     ; Jump to subroutine at direct PC offset by N address  (0x13d1)
0x13cf:     73 BE            JMP  (PC-0x42)     ; Jump to direct PC offset by N address  (0x138f)
0x13d1:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0x13d3:     D0 04 4C         LDBW #044C         ; Load literal address into byte of BW
0x13d6:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x13d8:     0E               DLY                ; Delay 4.5ms
0x13d9:     80 22            LDAL #22CC         ; Load literal address into byte of AL
0x13db:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x13dc:     4A               NABL               ; AND implicit AL and BL
0x13dd:     49               SABL               ; Subtract implicit AL and BL
0x13de:     14 15            BZ   (PC+0x15)     ; Branch if equal to zero to 0x15 ahead PC (0x13f5)
0x13e0:     DD               LBWS               ; Load byte from address in S into implicit BW
0x13e1:     31 20            DCR  BW, 0         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x13e3:     FD               SBWS               ; Store word from address in S into implicit BW
0x13e4:     17 F2            BP   (PC-0x0e)     ; Branch on positive to 0xe behind PC (0x13d8)
0x13e6:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x13e9:     00               HLT                ; Halts the CPU
0x13ea:     86               ???                ; Turn off CPU line 6
0x13eb:     80 22            LDAL #22CC         ; Load literal address into byte of AL
0x13ed:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x13ee:     4A               NABL               ; AND implicit AL and BL
0x13ef:     84 00            LDAL [PC+0x00]     ; Load indirect PC offset by N address into byte of AL
0x13f1:     1B 3C            BS2  (PC+0x3C)     ; Branch if sense switch 2 set to zero to 0x3C ahead PC (0x142f)
0x13f3:     E7               ???                ; Unknown. Illegal?
0x13f4:     49               SABL               ; Subtract implicit AL and BL
0x13f5:     14 03            BZ   (PC+0x03)     ; Branch if equal to zero to 0x03 ahead PC (0x13fa)
0x13f7:     0E               DLY                ; Delay 4.5ms
0x13f8:     73 F6            JMP  (PC-0x0a)     ; Jump to direct PC offset by N address  (0x13f0)
0x13fa:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x13fc:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x13fe:     A5 88 01         STAL ZW, 8, 0x01   ; Store AL into index mode register (view supplemental material)
0x1401:     09               RSR                ; return(cont=1) from Subroutine
0x1402:     00               HLT                ; Halts the CPU
0x1403:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x1404:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x1407:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1408:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x140b:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x140c:     CE               LBLC               ; Load byte from address in C into implicit BL
0x140d:     D4 8D            LDBW [PC-0x73]     ; Load indirect PC offset by N address into word of BW
0x140f:     DC               LBWZ               ; Load byte from address in ZW into implicit BW
0x1410:     00               HLT                ; Halts the CPU
0x1411:     13 3D            BNF  (PC+0x3D)     ; Branch if fault not set to 0x3D ahead PC (0x1450)
0x1413:     02               SF                 ; Set Fault
0x1414:     4D               XABL               ; Transfer implicit AL into BL
0x1415:     45 01            XFR  AH,  AL       ; Copy byte of one explicit register into other (R into L)
0x1417:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x141a:     B5 44            STAW X , 4         ; Store AW into index mode register (view supplemental material)
0x141c:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x141e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x1421:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0x1423:     B5 28 02         STAW BW, 8, 0x02   ; Store AW into index mode register (view supplemental material)
0x1426:     09               RSR                ; return(cont=1) from Subroutine
0x1427:     BC               SAWZ               ; Store word from address in ZW into implicit AW
0x1428:     80 A9            LDAL #A9A0         ; Load literal address into byte of AL
0x142a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x142d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x1430:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x1433:     CF               LBLP               ; Load byte from address in P into implicit BL
0x1434:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1435:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1438:     00               HLT                ; Halts the CPU
0x1439:     00               HLT                ; Halts the CPU
0x143a:     00               HLT                ; Halts the CPU
0x143b:     00               HLT                ; Halts the CPU
0x143c:     00               HLT                ; Halts the CPU
0x143d:     00               HLT                ; Halts the CPU
0x143e:     00               HLT                ; Halts the CPU
0x143f:     00               HLT                ; Halts the CPU
0x1440:     00               HLT                ; Halts the CPU
0x1441:     00               HLT                ; Halts the CPU
0x1442:     00               HLT                ; Halts the CPU
0x1443:     00               HLT                ; Halts the CPU
0x1444:     00               HLT                ; Halts the CPU
0x1445:     00               HLT                ; Halts the CPU
0x1446:     00               HLT                ; Halts the CPU
0x1447:     00               HLT                ; Halts the CPU
0x1448:     00               HLT                ; Halts the CPU
0x1449:     00               HLT                ; Halts the CPU
0x144a:     00               HLT                ; Halts the CPU
0x144b:     00               HLT                ; Halts the CPU
0x144c:     00               HLT                ; Halts the CPU
0x144d:     00               HLT                ; Halts the CPU
0x144e:     00               HLT                ; Halts the CPU
0x144f:     00               HLT                ; Halts the CPU
0x1450:     00               HLT                ; Halts the CPU
0x1451:     46 3D            ???                ; Special 2 byte instruction. See supplemental material.
0x1453:     15 95            BNZ  (PC-0x6b)     ; Branch if not equal to zero to 0x6b behind PC (0x13ea)
0x1455:     41 C0            SUB  C ,  AH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x1457:     A0 E5 A2         STAL E5A2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x145a:     55 00            XFR  AW,  AW       ; Copy word of one explicit register into other (R into L)
0x145c:     14 33            BZ   (PC+0x33)     ; Branch if equal to zero to 0x33 ahead PC (0x1491)
0x145e:     17 05            BP   (PC+0x05)     ; Branch on positive to 0x05 ahead PC (0x1465)
0x1460:     3B               IVAW               ; Invert word of implicit AW register
0x1461:     38               INAW               ; Increment word of implicit AW register
0x1462:     C0 AD            LDBL #ADED         ; Load literal address into byte of BL
0x1464:     ED               SBLS               ; Store byte from address in S into implicit BL
0x1465:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0x1467:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x1469:     55 24            XFR  BW,  X        ; Copy word of one explicit register into other (R into L)
0x146b:     3E               INX                ; Increment word of implicit X register
0x146c:     D0 00 0A         LDBW #000A         ; Load literal address into byte of BW
0x146f:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x1472:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x1474:     14 09            BZ   (PC+0x09)     ; Branch if equal to zero to 0x09 ahead PC (0x147f)
0x1476:     C0 B0            LDBL #B048         ; Load literal address into byte of BL
0x1478:     48               AABL               ; Add implicit AL and BL
0x1479:     E5 42            STAL X , 2         ; Store BL into index mode register (view supplemental material)
0x147b:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x147d:     73 ED            JMP  (PC-0x13)     ; Jump to direct PC offset by N address  (0x146c)
0x147f:     4D               XABL               ; Transfer implicit AL into BL
0x1480:     14 05            BZ   (PC+0x05)     ; Branch if equal to zero to 0x05 ahead PC (0x1487)
0x1482:     80 B0            LDAL #B048         ; Load literal address into byte of AL
0x1484:     48               AABL               ; Add implicit AL and BL
0x1485:     E5 42            STAL X , 2         ; Store BL into index mode register (view supplemental material)
0x1487:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x1489:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x148b:     C5 A1            LDAL SW, 1         ; Load index mode register address into BL (view supplemental material)
0x148d:     E5 42            STAL X , 2         ; Store BL into index mode register (view supplemental material)
0x148f:     5B               XAXW               ; Transfer implicit AW into XW
0x1490:     09               RSR                ; return(cont=1) from Subroutine
0x1491:     80 B0            LDAL #B0A5         ; Load literal address into byte of AL
0x1493:     A5 44            STAL X , 4         ; Store AL into index mode register (view supplemental material)
0x1495:     3E               INX                ; Increment word of implicit X register
0x1496:     3E               INX                ; Increment word of implicit X register
0x1497:     C5 A1            LDAL SW, 1         ; Load index mode register address into BL (view supplemental material)
0x1499:     09               RSR                ; return(cont=1) from Subroutine
0x149a:     28               INAL               ; Increment byte of implicit AL register
0x149b:     00               HLT                ; Halts the CPU
0x149c:     52 3D            MEM? M3,  MD       ; Odd register means operation on memory
0x149e:     5B               XAXW               ; Transfer implicit AW into XW
0x149f:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x14a1:     5B               XAXW               ; Transfer implicit AW into XW
0x14a2:     55 80            XFR  ZW,  AW       ; Copy word of one explicit register into other (R into L)
0x14a4:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x14a6:     32 80            CLR  ZW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14a8:     30 80            INR  ZW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14aa:     2A               CLAL               ; Clear byte of implicit AL register
0x14ab:     A5 A2            STAL SW, 2         ; Store AL into index mode register (view supplemental material)
0x14ad:     55 44            XFR  X ,  X        ; Copy word of one explicit register into other (R into L)
0x14af:     17 06            BP   (PC+0x06)     ; Branch on positive to 0x06 ahead PC (0x14b7)
0x14b1:     33 40            IVR  X,  0         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14b3:     3E               INX                ; Increment word of implicit X register
0x14b4:     8D               LALS               ; Load byte from address in S into implicit AL
0x14b5:     2B               IVAL               ; Invert byte of implicit AL register
0x14b6:     AD               SALS               ; Store byte from address in S into implicit AL
0x14b7:     55 22            XFR  BW,  BW       ; Copy word of one explicit register into other (R into L)
0x14b9:     17 07            BP   (PC+0x07)     ; Branch on positive to 0x07 ahead PC (0x14c2)
0x14bb:     33 20            IVR  BW, 0         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14bd:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14bf:     8D               LALS               ; Load byte from address in S into implicit AL
0x14c0:     2B               IVAL               ; Invert byte of implicit AL register
0x14c1:     AD               SALS               ; Store byte from address in S into implicit AL
0x14c2:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0x14c4:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14c6:     F5 A2            STBW SW, 2         ; Store BW into index mode register (view supplemental material)
0x14c8:     59               SABW               ; Subtract implicit AW and BW
0x14c9:     11 0C            BNL  (PC+0x0C)     ; Branch if link not set to 0x0C ahead PC (0x14d7)
0x14cb:     50 84            ADD  ZW,  X        ; Add word of two explicit registers (L + R stored in L)
0x14cd:     55 20            XFR  BW,  AW       ; Copy word of one explicit register into other (R into L)
0x14cf:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x14d1:     35 20            SLR  BW, 0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x14d3:     35 80            SLR  ZW, 0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x14d5:     73 EF            JMP  (PC-0x11)     ; Jump to direct PC offset by N address  (0x14c6)
0x14d7:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x14d9:     07               RL                 ; Reset Link
0x14da:     36 20            RRR  BW, 0         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x14dc:     07               RL                 ; Reset Link
0x14dd:     36 80            RRR  ZW, 0         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x14df:     15 E5            BNZ  (PC-0x1b)     ; Branch if not equal to zero to 0x1b behind PC (0x14c6)
0x14e1:     C5 A1            LDAL SW, 1         ; Load index mode register address into BL (view supplemental material)
0x14e3:     14 03            BZ   (PC+0x03)     ; Branch if equal to zero to 0x03 ahead PC (0x14e8)
0x14e5:     33 40            IVR  X,  0         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x14e7:     3E               INX                ; Increment word of implicit X register
0x14e8:     55 42            XFR  X ,  BW       ; Copy word of one explicit register into other (R into L)
0x14ea:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x14ec:     55 48            XFR  X ,  ZW       ; Copy word of one explicit register into other (R into L)
0x14ee:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x14f0:     09               RSR                ; return(cont=1) from Subroutine
0x14f1:     04               EI                 ; Enable Interrupt system
0x14f2:     00               HLT                ; Halts the CPU
0x14f3:     78 3D AD         JSR  #3DAD         ; Jump to subroutine at literal address (not possible?)
0x14f6:     7B 24            JSR  (PC+0x24)     ; Jump to subroutine at direct PC offset by N address  (0x151c)
0x14f8:     55 60            XFR  YW,  AW       ; Copy word of one explicit register into other (R into L)
0x14fa:     B5 A2            STAW SW, 2         ; Store AW into index mode register (view supplemental material)
0x14fc:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x14fe:     5C               XAYW               ; Transfer implicit AW into YW
0x14ff:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x1501:     65 61            LDXW YW, 1         ; Load index mode into word XW (view supplemental material)
0x1503:     19 11            BLE  (PC+0x11)     ; Branch if less than or equal to zero to 0x11 ahead PC (0x1516)
0x1505:     85 61            LDAL YW, 1         ; Load index mode register address into AL (view supplemental material)
0x1507:     C0 E0            LDBL #E049         ; Load literal address into byte of BL
0x1509:     49               SABL               ; Subtract implicit AL and BL
0x150a:     16 05            BM   (PC+0x05)     ; Branch if minus set to 0x05 ahead PC (0x1511)
0x150c:     C0 20            LDBL #2049         ; Load literal address into byte of BL
0x150e:     49               SABL               ; Subtract implicit AL and BL
0x150f:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x1511:     7B 13            JSR  (PC+0x13)     ; Jump to subroutine at direct PC offset by N address  (0x1526)
0x1513:     3F               DCX                ; Decrement word of implicit X register
0x1514:     18 EF            BGZ  (PC-0x11)     ; Branch if greater than zero to 0x11 behind PC (0x1505)
0x1516:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1518:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x151a:     5C               XAYW               ; Transfer implicit AW into YW
0x151b:     09               RSR                ; return(cont=1) from Subroutine
0x151c:     80 8D            LDAL #8DC3         ; Load literal address into byte of AL
0x151e:     C3 35            LDBL (PC+0x35)     ; Load direct PC offset by N address into byte of BL
0x1520:     49               SABL               ; Subtract implicit AL and BL
0x1521:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x1525)
0x1523:     7B 01            JSR  (PC+0x01)     ; Jump to subroutine at direct PC offset by N address  (0x1526)
0x1525:     09               RSR                ; return(cont=1) from Subroutine
0x1526:     A1 F2 0D         STAL F20D          ; Store AL into direct address
0x1529:     C0 C5            LDBL #C5E1         ; Load literal address into byte of BL
0x152b:     E1 F2 00         STBL F200          ; Store BL into direct address
0x152e:     C0 8C            LDBL #8C49         ; Load literal address into byte of BL
0x1530:     49               SABL               ; Subtract implicit AL and BL
0x1531:     14 11            BZ   (PC+0x11)     ; Branch if equal to zero to 0x11 ahead PC (0x1544)
0x1533:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x1535:     49               SABL               ; Subtract implicit AL and BL
0x1536:     15 10            BNZ  (PC+0x10)     ; Branch if not equal to zero to 0x10 ahead PC (0x1548)
0x1538:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x1548)
0x153a:     80 8A            LDAL #8A7B         ; Load literal address into byte of AL
0x153c:     7B 0A            JSR  (PC+0x0A)     ; Jump to subroutine at direct PC offset by N address  (0x1548)
0x153e:     80 8D            LDAL #8DA3         ; Load literal address into byte of AL
0x1540:     A3 13            STAL (PC+0x13)     ; Store byte of AL into direct PC offset by N address
0x1542:     0E               DLY                ; Delay 4.5ms
0x1543:     09               RSR                ; return(cont=1) from Subroutine
0x1544:     7B 02            JSR  (PC+0x02)     ; Jump to subroutine at direct PC offset by N address  (0x1548)
0x1546:     0E               DLY                ; Delay 4.5ms
0x1547:     09               RSR                ; return(cont=1) from Subroutine
0x1548:     C1 F2 00         LDBL F200          ; Load direct address into byte of BL
0x154b:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x154d:     24 30            SRR  BL, 0         ; Shift byte of explicit register right by 1 + const.
0x154f:     11 F7            BNL  (PC-0x09)     ; Branch if link not set to 0x9 behind PC (0x1548)
0x1551:     A1 F2 01         STAL F201          ; Store AL into direct address
0x1554:     A0 00 09         STAL 0009          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1557:     C1 F2 0F         LDBL F20F          ; Load direct address into byte of BL
0x155a:     0A               RI                 ; return(cont=1) from Interrupt
0x155b:     81 F2 00         LDAL F200          ; Load direct address into byte of AL
0x155e:     2C               SRAL               ; Shift byte of implicit AL register left
0x155f:     10 0F            BL   (PC+0x0F)     ; Branch if link set to 0x0F ahead PC (0x1570)
0x1561:     81 F2 01         LDAL F201          ; Load direct address into byte of AL
0x1564:     81 F2 03         LDAL F203          ; Load direct address into byte of AL
0x1567:     81 F2 05         LDAL F205          ; Load direct address into byte of AL
0x156a:     81 F2 07         LDAL F207          ; Load direct address into byte of AL
0x156d:     2A               CLAL               ; Clear byte of implicit AL register
0x156e:     B8               SAWA               ; Store word from address in AW into implicit AW
0x156f:     80 DD            LDAL #DD31         ; Load literal address into byte of AL
0x1571:     31 20            DCR  BW, 0         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1573:     FD               SBWS               ; Store word from address in S into implicit BW
0x1574:     17 F2            BP   (PC-0x0e)     ; Branch on positive to 0xe behind PC (0x1568)
0x1576:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x1579:     00               HLT                ; Halts the CPU
0x157a:     86               ???                ; Turn off CPU line 6
0x157b:     80 22            LDAL #22CC         ; Load literal address into byte of AL
0x157d:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x157e:     4A               NABL               ; AND implicit AL and BL
0x157f:     84 00            LDAL [PC+0x00]     ; Load indirect PC offset by N address into byte of AL
0x1581:     1B 3C            BS2  (PC+0x3C)     ; Branch if sense switch 2 set to zero to 0x3C ahead PC (0x15bf)
0x1583:     E7               ???                ; Unknown. Illegal?
0x1584:     49               SABL               ; Subtract implicit AL and BL
0x1585:     14 03            BZ   (PC+0x03)     ; Branch if equal to zero to 0x03 ahead PC (0x158a)
0x1587:     0E               DLY                ; Delay 4.5ms
0x1588:     73 F6            JMP  (PC-0x0a)     ; Jump to direct PC offset by N address  (0x1580)
0x158a:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x158c:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x158e:     A5 88 01         STAL ZW, 8, 0x01   ; Store AL into index mode register (view supplemental material)
0x1591:     09               RSR                ; return(cont=1) from Subroutine
0x1592:     00               HLT                ; Halts the CPU
0x1593:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x1594:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x1597:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1598:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x159b:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x159c:     CE               LBLC               ; Load byte from address in C into implicit BL
0x159d:     D4 8D            LDBW [PC-0x73]     ; Load indirect PC offset by N address into word of BW
0x159f:     DC               LBWZ               ; Load byte from address in ZW into implicit BW
0x15a0:     00               HLT                ; Halts the CPU
0x15a1:     13 3D            BNF  (PC+0x3D)     ; Branch if fault not set to 0x3D ahead PC (0x15e0)
0x15a3:     02               SF                 ; Set Fault
0x15a4:     4D               XABL               ; Transfer implicit AL into BL
0x15a5:     45 01            XFR  AH,  AL       ; Copy byte of one explicit register into other (R into L)
0x15a7:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x15aa:     B5 44            STAW X , 4         ; Store AW into index mode register (view supplemental material)
0x15ac:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x15ae:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x15b1:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0x15b3:     B5 28 02         STAW BW, 8, 0x02   ; Store AW into index mode register (view supplemental material)
0x15b6:     09               RSR                ; return(cont=1) from Subroutine
0x15b7:     BC               SAWZ               ; Store word from address in ZW into implicit AW
0x15b8:     80 A9            LDAL #A9A0         ; Load literal address into byte of AL
0x15ba:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x15bd:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x15c0:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x15c3:     CF               LBLP               ; Load byte from address in P into implicit BL
0x15c4:     CE               LBLC               ; Load byte from address in C into implicit BL
0x15c5:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x15c8:     00               HLT                ; Halts the CPU
0x15c9:     00               HLT                ; Halts the CPU
0x15ca:     00               HLT                ; Halts the CPU
0x15cb:     00               HLT                ; Halts the CPU
0x15cc:     00               HLT                ; Halts the CPU
0x15cd:     00               HLT                ; Halts the CPU
0x15ce:     00               HLT                ; Halts the CPU
0x15cf:     00               HLT                ; Halts the CPU
0x15d0:     00               HLT                ; Halts the CPU
0x15d1:     00               HLT                ; Halts the CPU
0x15d2:     00               HLT                ; Halts the CPU
0x15d3:     00               HLT                ; Halts the CPU
0x15d4:     00               HLT                ; Halts the CPU
0x15d5:     00               HLT                ; Halts the CPU
0x15d6:     00               HLT                ; Halts the CPU
0x15d7:     00               HLT                ; Halts the CPU
0x15d8:     00               HLT                ; Halts the CPU
0x15d9:     00               HLT                ; Halts the CPU
0x15da:     00               HLT                ; Halts the CPU
0x15db:     00               HLT                ; Halts the CPU
0x15dc:     00               HLT                ; Halts the CPU
0x15dd:     00               HLT                ; Halts the CPU
0x15de:     00               HLT                ; Halts the CPU
0x15df:     00               HLT                ; Halts the CPU
0x15e0:     00               HLT                ; Halts the CPU
0x15e1:     78 3E 25         JSR  #3E25         ; Jump to subroutine at literal address (not possible?)
0x15e4:     73 E7            JMP  (PC-0x19)     ; Jump to direct PC offset by N address  (0x15cd)
0x15e6:     81 F2 01         LDAL F201          ; Load direct address into byte of AL
0x15e9:     73 E2            JMP  (PC-0x1e)     ; Jump to direct PC offset by N address  (0x15cd)
0x15eb:     80 C5            LDAL #C5A1         ; Load literal address into byte of AL
0x15ed:     A1 F2 00         STAL F200          ; Store AL into direct address
0x15f0:     90 00 65         LDAW #0065         ; Load literal address into byte of AW
0x15f3:     B1 00 6E         STAW 006E          ; Store AW into direct address
0x15f6:     2A               CLAL               ; Clear byte of implicit AL register
0x15f7:     A1 00 61         STAL 0061          ; Store AL into direct address
0x15fa:     80 06            LDAL #06A1         ; Load literal address into byte of AL
0x15fc:     A1 F2 0A         STAL F20A          ; Store AL into direct address
0x15ff:     A1 F2 0E         STAL F20E          ; Store AL into direct address
0x1602:     81 00 61         LDAL 0061          ; Load direct address into byte of AL
0x1605:     14 FB            BZ   (PC-0x05)     ; Branch if equal to zero to 0x5 behind PC (0x1602)
0x1607:     C0 80            LDBL #8043         ; Load literal address into byte of BL
0x1609:     43 31            ORI  BL,  AL       ; OR bytes of two explicit registers (L OR R stored in L)
0x160b:     7B 8F            JSR  (PC-0x71)     ; Jump to subroutine at direct PC offset by N address  (0x159c)
0x160d:     C0 E0            LDBL #E049         ; Load literal address into byte of BL
0x160f:     49               SABL               ; Subtract implicit AL and BL
0x1610:     16 05            BM   (PC+0x05)     ; Branch if minus set to 0x05 ahead PC (0x1617)
0x1612:     C0 20            LDBL #2049         ; Load literal address into byte of BL
0x1614:     49               SABL               ; Subtract implicit AL and BL
0x1615:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x1617:     C0 8A            LDBL #8A49         ; Load literal address into byte of BL
0x1619:     49               SABL               ; Subtract implicit AL and BL
0x161a:     15 07            BNZ  (PC+0x07)     ; Branch if not equal to zero to 0x07 ahead PC (0x1623)
0x161c:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x161f:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x1623)
0x1621:     55 24            XFR  BW,  X        ; Copy word of one explicit register into other (R into L)
0x1623:     09               RSR                ; return(cont=1) from Subroutine
0x1624:     93 F7            LDAW (PC-0x09)     ; Load direct PC offset by N address into word of AW
0x1626:     B3 5A            STAW (PC+0x5A)     ; Store word of AW into direct PC offset by N address
0x1628:     90 01 1B         LDAW #011B         ; Load literal address into byte of AW
0x162b:     B3 F0            STAW (PC-0x10)     ; Store word of AW into direct PC offset by N address
0x162d:     9A               LAWX               ; Load word from address in XW into implicit AW
0x162e:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x1630:     38               INAW               ; Increment word of implicit AW register
0x1631:     5B               XAXW               ; Transfer implicit AW into XW
0x1632:     80 AF            LDAL #AF79         ; Load literal address into byte of AL
0x1634:     79 00 30         JSR  0030          ; Jump to subroutine at direct address
0x1637:     7B B2            JSR  (PC-0x4e)     ; Jump to subroutine at direct PC offset by N address  (0x15eb)
0x1639:     C0 88            LDBL #8849         ; Load literal address into byte of BL
0x163b:     49               SABL               ; Subtract implicit AL and BL
0x163c:     14 05            BZ   (PC+0x05)     ; Branch if equal to zero to 0x05 ahead PC (0x1643)
0x163e:     C0 95            LDBL #9549         ; Load literal address into byte of BL
0x1640:     49               SABL               ; Subtract implicit AL and BL
0x1641:     15 1E            BNZ  (PC+0x1E)     ; Branch if not equal to zero to 0x1E ahead PC (0x1661)
0x1643:     D5 A4            LDAW SW, 4         ; Load index mode register address into BW (view supplemental material)
0x1645:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1647:     51 42            SUB  X ,  BW       ; Subtract word of two explicit registers (L - R stored in L)
0x1649:     14 10            BZ   (PC+0x10)     ; Branch if equal to zero to 0x10 ahead PC (0x165b)
0x164b:     80 A0            LDAL #A079         ; Load literal address into byte of AL
0x164d:     79 00 30         JSR  0030          ; Jump to subroutine at direct address
0x1650:     80 95            LDAL #957C         ; Load literal address into byte of AL
0x1652:     7C FA            JSR  [PC-0x06]     ; Jump to to subroutine at indirect PC offset by N address
0x1654:     80 88            LDAL #887C         ; Load literal address into byte of AL
0x1656:     7C F6            JSR  [PC-0x0a]     ; Jump to to subroutine at indirect PC offset by N address
0x1658:     3F               DCX                ; Decrement word of implicit X register
0x1659:     73 DC            JMP  (PC-0x24)     ; Jump to direct PC offset by N address  (0x1637)
0x165b:     80 BF            LDAL #BF00         ; Load literal address into byte of AL
0x165d:     00               HLT                ; Halts the CPU
0x165e:     34 3E            SRR  MEM, E         ; Shift byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x1660:     9D               LAWS               ; Load word from address in S into implicit AW
0x1661:     86               ???                ; Turn off CPU line 6
0x1662:     7C EF            JSR  [PC-0x11]     ; Jump to to subroutine at indirect PC offset by N address
0x1664:     73 D6            JMP  (PC-0x2a)     ; Jump to direct PC offset by N address  (0x163c)
0x1666:     C0 8D            LDBL #8D49         ; Load literal address into byte of BL
0x1668:     49               SABL               ; Subtract implicit AL and BL
0x1669:     14 12            BZ   (PC+0x12)     ; Branch if equal to zero to 0x12 ahead PC (0x167d)
0x166b:     A3 0C            STAL (PC+0x0C)     ; Store byte of AL into direct PC offset by N address
0x166d:     95 A4            LDAW SW, 4         ; Load index mode register address into AW (view supplemental material)
0x166f:     D0 00 85         LDBW #0085         ; Load literal address into byte of BW
0x1672:     58               AABW               ; Add implicit AW and BW
0x1673:     51 42            SUB  X ,  BW       ; Subtract word of two explicit registers (L - R stored in L)
0x1675:     17 06            BP   (PC+0x06)     ; Branch on positive to 0x06 ahead PC (0x167d)
0x1677:     3E               INX                ; Increment word of implicit X register
0x1678:     80 00            LDAL #00AA         ; Load literal address into byte of AL
0x167a:     AA               SALX               ; Store byte from address in XW into implicit AL
0x167b:     73 BF            JMP  (PC-0x41)     ; Jump to direct PC offset by N address  (0x163c)
0x167d:     95 A4            LDAW SW, 4         ; Load index mode register address into AW (view supplemental material)
0x167f:     38               INAW               ; Increment word of implicit AW register
0x1680:     51 40            SUB  X ,  AW       ; Subtract word of two explicit registers (L - R stored in L)
0x1682:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x1684:     B5 45            STAW X , 5         ; Store AW into index mode register (view supplemental material)
0x1686:     D0 00 00         LDBW #0000         ; Load literal address into byte of BW
0x1689:     F3 97            STBW (PC-0x69)     ; Store word of BW into direct PC offset by N address
0x168b:     09               RSR                ; return(cont=1) from Subroutine
0x168c:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x168e:     3A               CLAW               ; Clear word of implicit AW register
0x168f:     B5 45            STAW X , 5         ; Store AW into index mode register (view supplemental material)
0x1691:     63 F4            LDXW (PC-0x0c)     ; Load direct PC offset by N address into word XW
0x1693:     73 F1            JMP  (PC-0x0f)     ; Jump to direct PC offset by N address  (0x1686)
0x1695:     C2 00 4E         LDBL [004E]        ; Load indirect address into byte of BL
0x1698:     3E               INX                ; Increment word of implicit X register
0x1699:     D1 6D A2         LDBW 6DA2          ; Load direct address into byte of BW
0x169c:     55 64            XFR  YW,  X        ; Copy word of one explicit register into other (R into L)
0x169e:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x16a0:     55 84            XFR  ZW,  X        ; Copy word of one explicit register into other (R into L)
0x16a2:     6D A2            STXW SW, 2         ; Store XW into index mode register (view supplemental material)
0x16a4:     60 80 00         LDXW #8000         ; Load literal word into word XW
0x16a7:     55 46            XFR  X ,  YW       ; Copy word of one explicit register into other (R into L)
0x16a9:     32 40            CLR  X,  0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x16ab:     32 80            CLR  ZW, 0         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x16ad:     55 00            XFR  AW,  AW       ; Copy word of one explicit register into other (R into L)
0x16af:     17 06            BP   (PC+0x06)     ; Branch on positive to 0x06 ahead PC (0x16b7)
0x16b1:     3B               IVAW               ; Invert word of implicit AW register
0x16b2:     38               INAW               ; Increment word of implicit AW register
0x16b3:     33 20            IVR  BW, 0         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x16b5:     30 20            INR  BW, 0         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x16b7:     3B               IVAW               ; Invert word of implicit AW register
0x16b8:     55 00            XFR  AW,  AW       ; Copy word of one explicit register into other (R into L)
0x16ba:     14 1D            BZ   (PC+0x1D)     ; Branch if equal to zero to 0x1D ahead PC (0x16d9)
0x16bc:     07               RL                 ; Reset Link
0x16bd:     36 00            RRR  AW, 0         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x16bf:     10 02            BL   (PC+0x02)     ; Branch if link set to 0x02 ahead PC (0x16c3)
0x16c1:     50 24            ADD  BW,  X        ; Add word of two explicit registers (L + R stored in L)
0x16c3:     07               RL                 ; Reset Link
0x16c4:     36 80            RRR  ZW, 0         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x16c6:     07               RL                 ; Reset Link
0x16c7:     36 40            RRR  X,  0         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x16c9:     11 02            BNL  (PC+0x02)     ; Branch if link not set to 0x02 ahead PC (0x16cd)
0x16cb:     50 68            ADD  YW,  ZW       ; Add word of two explicit registers (L + R stored in L)
0x16cd:     55 22            XFR  BW,  BW       ; Copy word of one explicit register into other (R into L)
0x16cf:     17 E7            BP   (PC-0x19)     ; Branch on positive to 0x19 behind PC (0x16b8)
0x16d1:     55 44            XFR  X ,  X        ; Copy word of one explicit register into other (R into L)
0x16d3:     14 E3            BZ   (PC-0x1d)     ; Branch if equal to zero to 0x1d behind PC (0x16b8)
0x16d5:     50 64            ADD  YW,  X        ; Add word of two explicit registers (L + R stored in L)
0x16d7:     73 DF            JMP  (PC-0x21)     ; Jump to direct PC offset by N address  (0x16b8)
0x16d9:     55 82            XFR  ZW,  BW       ; Copy word of one explicit register into other (R into L)
0x16db:     55 40            XFR  X ,  AW       ; Copy word of one explicit register into other (R into L)
0x16dd:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x16df:     55 48            XFR  X ,  ZW       ; Copy word of one explicit register into other (R into L)
0x16e1:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x16e3:     55 46            XFR  X ,  YW       ; Copy word of one explicit register into other (R into L)
0x16e5:     65 A1            LDXW SW, 1         ; Load index mode into word XW (view supplemental material)
0x16e7:     09               RSR                ; return(cont=1) from Subroutine
0x16e8:     6A 00 28         STXW [0028]        ; Store XW into indirect address
0x16eb:     3F               DCX                ; Decrement word of implicit X register
0x16ec:     1F F5            BEP? (PC-0x0b)     ; Branch on even parity to zero to 0xb behind PC (0x16e3)
0x16ee:     A2 45 10         STAL [4510]        ; Store AL into indirect address
0x16f1:     2C               SRAL               ; Shift byte of implicit AL register left
0x16f2:     2C               SRAL               ; Shift byte of implicit AL register left
0x16f3:     2C               SRAL               ; Shift byte of implicit AL register left
0x16f4:     2C               SRAL               ; Shift byte of implicit AL register left
0x16f5:     D0 0F 0F         LDBW #0F0F         ; Load literal address into byte of BW
0x16f8:     5A               NABW               ; AND implicit AW and BW
0x16f9:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x16fb:     7B 0B            JSR  (PC+0x0B)     ; Jump to subroutine at direct PC offset by N address  (0x1708)
0x16fd:     45 30            XFR  BL,  AH       ; Copy byte of one explicit register into other (R into L)
0x16ff:     45 21            XFR  BH,  AL       ; Copy byte of one explicit register into other (R into L)
0x1701:     7B 05            JSR  (PC+0x05)     ; Jump to subroutine at direct PC offset by N address  (0x1708)
0x1703:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x1705:     D5 A1            LDAW SW, 1         ; Load index mode register address into BW (view supplemental material)
0x1707:     09               RSR                ; return(cont=1) from Subroutine
0x1708:     C0 0A            LDBL #0A49         ; Load literal address into byte of BL
0x170a:     49               SABL               ; Subtract implicit AL and BL
0x170b:     16 04            BM   (PC+0x04)     ; Branch if minus set to 0x04 ahead PC (0x1711)
0x170d:     C0 07            LDBL #0740         ; Load literal address into byte of BL
0x170f:     40 31            ADD  BL,  AL       ; Add bytes of two explicit registers (L + R stored in L)
0x1711:     C0 B0            LDBL #B048         ; Load literal address into byte of BL
0x1713:     48               AABL               ; Add implicit AL and BL
0x1714:     09               RSR                ; return(cont=1) from Subroutine
0x1715:     24 80            SRR  ZH, 0         ; Shift byte of explicit register right by 1 + const.
0x1717:     0E               DLY                ; Delay 4.5ms
0x1718:     73 F6            JMP  (PC-0x0a)     ; Jump to direct PC offset by N address  (0x1710)
0x171a:     95 A1            LDAW SW, 1         ; Load index mode register address into AW (view supplemental material)
0x171c:     85 A1            LDAL SW, 1         ; Load index mode register address into AL (view supplemental material)
0x171e:     A5 88 01         STAL ZW, 8, 0x01   ; Store AL into index mode register (view supplemental material)
0x1721:     09               RSR                ; return(cont=1) from Subroutine
0x1722:     00               HLT                ; Halts the CPU
0x1723:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x1724:     C1 D4 D4         LDBL D4D4          ; Load direct address into byte of BL
0x1727:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1728:     A0 D0 D2         STAL D0D2          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x172b:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x172c:     CE               LBLC               ; Load byte from address in C into implicit BL
0x172d:     D4 8D            LDBW [PC-0x73]     ; Load indirect PC offset by N address into word of BW
0x172f:     DC               LBWZ               ; Load byte from address in ZW into implicit BW
0x1730:     00               HLT                ; Halts the CPU
0x1731:     13 3D            BNF  (PC+0x3D)     ; Branch if fault not set to 0x3D ahead PC (0x1770)
0x1733:     02               SF                 ; Set Fault
0x1734:     4D               XABL               ; Transfer implicit AL into BL
0x1735:     45 01            XFR  AH,  AL       ; Copy byte of one explicit register into other (R into L)
0x1737:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x173a:     B5 44            STAW X , 4         ; Store AW into index mode register (view supplemental material)
0x173c:     45 31            XFR  BL,  AL       ; Copy byte of one explicit register into other (R into L)
0x173e:     79 00 00         JSR  0000          ; Jump to subroutine at direct address
0x1741:     D5 41            LDAW X , 1         ; Load index mode register address into BW (view supplemental material)
0x1743:     B5 28 02         STAW BW, 8, 0x02   ; Store AW into index mode register (view supplemental material)
0x1746:     09               RSR                ; return(cont=1) from Subroutine
0x1747:     BC               SAWZ               ; Store word from address in ZW into implicit AW
0x1748:     80 A9            LDAL #A9A0         ; Load literal address into byte of AL
0x174a:     A0 00 19         STAL 0019          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x174d:     C1 C2 CF         LDBL C2CF          ; Load direct address into byte of BL
0x1750:     D2 D4 A0         LDBW [D4A0]        ; Load indirect address into byte of BW
0x1753:     CF               LBLP               ; Load byte from address in P into implicit BL
0x1754:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1755:     A0 1B 80         STAL 1B80          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1758:     00               HLT                ; Halts the CPU
0x1759:     00               HLT                ; Halts the CPU
0x175a:     00               HLT                ; Halts the CPU
0x175b:     00               HLT                ; Halts the CPU
0x175c:     00               HLT                ; Halts the CPU
0x175d:     00               HLT                ; Halts the CPU
0x175e:     00               HLT                ; Halts the CPU
0x175f:     00               HLT                ; Halts the CPU
0x1760:     00               HLT                ; Halts the CPU
0x1761:     00               HLT                ; Halts the CPU
0x1762:     00               HLT                ; Halts the CPU
0x1763:     00               HLT                ; Halts the CPU
0x1764:     00               HLT                ; Halts the CPU
0x1765:     00               HLT                ; Halts the CPU
0x1766:     00               HLT                ; Halts the CPU
0x1767:     00               HLT                ; Halts the CPU
0x1768:     00               HLT                ; Halts the CPU
0x1769:     00               HLT                ; Halts the CPU
0x176a:     00               HLT                ; Halts the CPU
0x176b:     00               HLT                ; Halts the CPU
0x176c:     00               HLT                ; Halts the CPU
0x176d:     00               HLT                ; Halts the CPU
0x176e:     00               HLT                ; Halts the CPU
0x176f:     00               HLT                ; Halts the CPU
0x1770:     01               NOP                ; No Operation
0x1771:     78 00 00         JSR  #0000         ; Jump to subroutine at literal address (not possible?)
0x1774:     01               NOP                ; No Operation
0x1775:     77 01            ???                ; Multiply or Divide? Using an odd register for either operand will operate on memory.
0x1777:     7D 01            JMP  AW, 1         ; Jump to subroutine at index mode register (view supplemental material)
0x1779:     87               ???                ; Unknown. Illegal?
0x177a:     01               NOP                ; No Operation
0x177b:     90 01 96         LDAW #0196         ; Load literal address into byte of AW
0x177e:     01               NOP                ; No Operation
0x177f:     9A               LAWX               ; Load word from address in XW into implicit AW
0x1780:     01               NOP                ; No Operation
0x1781:     9E               LAWC               ; Load word from address in C into implicit AW
0x1782:     01               NOP                ; No Operation
0x1783:     A1 01 A4         STAL 01A4          ; Store AL into direct address
0x1786:     01               NOP                ; No Operation
0x1787:     A9               SALB               ; Store byte from address in BW into implicit AL
0x1788:     01               NOP                ; No Operation
0x1789:     BF               SAWP               ; Store word from address in P into implicit AW
0x178a:     01               NOP                ; No Operation
0x178b:     C4 01            LDBL [PC+0x01]     ; Load indirect PC offset by N address into byte of BL
0x178d:     CF               LBLP               ; Load byte from address in P into implicit BL
0x178e:     01               NOP                ; No Operation
0x178f:     D2 01 D8         LDBW [01D8]        ; Load indirect address into byte of BW
0x1792:     01               NOP                ; No Operation
0x1793:     DE               LBWC               ; Load byte from address in C into implicit BW
0x1794:     01               NOP                ; No Operation
0x1795:     E5 01            STAL AW, 1         ; Store BL into index mode register (view supplemental material)
0x1797:     F4 02            STBW [PC+0x02]     ; Store word of BW into indirect PC offset by N address
0x1799:     00               HLT                ; Halts the CPU
0x179a:     02               SF                 ; Set Fault
0x179b:     06               SL                 ; Set Link
0x179c:     02               SF                 ; Set Fault
0x179d:     11 02            BNL  (PC+0x02)     ; Branch if link not set to 0x02 ahead PC (0x17a1)
0x179f:     1C 02            BS3  (PC+0x02)     ; Branch if sense switch 3 set to 0x02 ahead PC (0x17a3)
0x17a1:     27 02            RLR  AH, 2         ; Rotate byte of explicit register left by 1 + const.
0x17a3:     32 02            CLR  AW, 2         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x17a5:     3D               SLAW               ; Shift word of implicit AW register right
0x17a6:     02               SF                 ; Set Fault
0x17a7:     47 02            ???                ; Special 2 byte instruction. See supplemental material.
0x17a9:     67               ???                ; Unknown
0x17aa:     02               SF                 ; Set Fault
0x17ab:     6A 02 6E         STXW [026E]        ; Store XW into indirect address
0x17ae:     02               SF                 ; Set Fault
0x17af:     A6               ???                ; Turn on CPU line 4
0x17b0:     02               SF                 ; Set Fault
0x17b1:     A9               SALB               ; Store byte from address in BW into implicit AL
0x17b2:     02               SF                 ; Set Fault
0x17b3:     AC               SALZ               ; Store byte from address in ZW into implicit AL
0x17b4:     02               SF                 ; Set Fault
0x17b5:     B1 02 B4         STAW 02B4          ; Store AW into direct address
0x17b8:     02               SF                 ; Set Fault
0x17b9:     BE               SAWC               ; Store word from address in C into implicit AW
0x17ba:     02               SF                 ; Set Fault
0x17bb:     D3 02            LDBW (PC+0x02)     ; Load direct PC offset by N address into word of BW
0x17bd:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x17be:     02               SF                 ; Set Fault
0x17bf:     DE               LBWC               ; Load byte from address in C into implicit BW
0x17c0:     02               SF                 ; Set Fault
0x17c1:     E3 02            STBL (PC+0x02)     ; Store byte of BL into direct PC offset by N address
0x17c3:     F3 02            STBW (PC+0x02)     ; Store word of BW into direct PC offset by N address
0x17c5:     FB               SBWY               ; Store word from address in YW into implicit BW
0x17c6:     03               RF                 ; Reset Fault
0x17c7:     0A               RI                 ; return(cont=1) from Interrupt
0x17c8:     03               RF                 ; Reset Fault
0x17c9:     11 03            BNL  (PC+0x03)     ; Branch if link not set to 0x03 ahead PC (0x17ce)
0x17cb:     13 03            BNF  (PC+0x03)     ; Branch if fault not set to 0x03 ahead PC (0x17d0)
0x17cd:     16 03            BM   (PC+0x03)     ; Branch if minus set to 0x03 ahead PC (0x17d2)
0x17cf:     1D 03            BS4  (PC+0x03)     ; Branch if sense switch 4 set to zero to 0x03 ahead PC (0x17d4)
0x17d1:     20 03            INR  AH, 3         ; Increment byte of explicit register by 1 + const.
0x17d3:     23 03            IVR  AH, 3         ; Invert byte of explicit register by 1 + const.
0x17d5:     25 03            SLR  AH, 3         ; Shift byte of explicit register left by 1 + const.
0x17d7:     28               INAL               ; Increment byte of implicit AL register
0x17d8:     03               RF                 ; Reset Fault
0x17d9:     31 03            DCR  AW, 3         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x17db:     33 03            IVR  AW, 3         ; Invert byte of explicit register by 1 + const. (Odd reg. on MEM)
0x17dd:     36 03            RRR  AW, 3         ; Rotate byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x17df:     3D               SLAW               ; Shift word of implicit AW register right
0x17e0:     03               RF                 ; Reset Fault
0x17e1:     47 03            ???                ; Special 2 byte instruction. See supplemental material.
0x17e3:     7F 03 81         POP                ; Pop multiple 8-bit registers from stack
0x17e4:     03               RF                 ; Reset Fault
0x17e5:     81 03 84         LDAL 0384          ; Load direct address into byte of AL
0x17e8:     03               RF                 ; Reset Fault
0x17e9:     89               LALB               ; Load byte from address in BW into implicit AL
0x17ea:     03               RF                 ; Reset Fault
0x17eb:     8F               LALP               ; Load byte from address in P into implicit AL
0x17ec:     22 01            CLR  AH, 1         ; Clear byte of explicit register by 1 + const.
0x17ee:     78 00 00         JSR  #0000         ; Jump to subroutine at literal address (not possible?)
0x17f1:     03               RF                 ; Reset Fault
0x17f2:     99               LAWB               ; Load word from address in BW into implicit AW
0x17f3:     03               RF                 ; Reset Fault
0x17f4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x17f5:     03               RF                 ; Reset Fault
0x17f6:     B1 03 B8         STAW 03B8          ; Store AW into direct address
0x17f9:     03               RF                 ; Reset Fault
0x17fa:     BE               SAWC               ; Store word from address in C into implicit AW
0x17fb:     03               RF                 ; Reset Fault
0x17fc:     C2 03 CB         LDBL [03CB]        ; Load indirect address into byte of BL
0x17ff:     04               EI                 ; Enable Interrupt system
0x1800:     02               SF                 ; Set Fault
0x1801:     04               EI                 ; Enable Interrupt system
0x1802:     08               CL                 ; Complement Link
0x1803:     04               EI                 ; Enable Interrupt system
0x1804:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x1805:     04               EI                 ; Enable Interrupt system
0x1806:     26 04            RRR  AH, 4         ; Rotate byte of explicit register right by 1 + const.
0x1808:     2D               SLAL               ; Shift byte of implicit AL register right
0x1809:     04               EI                 ; Enable Interrupt system
0x180a:     32 04            CLR  AW, 4         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x180c:     3B               IVAW               ; Invert word of implicit AW register
0x180d:     04               EI                 ; Enable Interrupt system
0x180e:     5A               NABW               ; AND implicit AW and BW
0x180f:     04               EI                 ; Enable Interrupt system
0x1810:     6B 04            STXW (PC+0x04)     ; Store word of XW into direct PC offset by N address
0x1812:     72 04 78         JMP  [0478]        ; Jump to indirect address
0x1815:     04               EI                 ; Enable Interrupt system
0x1816:     7B 04            JSR  (PC+0x04)     ; Jump to subroutine at direct PC offset by N address  (0x181c)
0x1818:     81 04 84         LDAL 0484          ; Load direct address into byte of AL
0x181b:     04               EI                 ; Enable Interrupt system
0x181c:     87               ???                ; Unknown. Illegal?
0x181d:     04               EI                 ; Enable Interrupt system
0x181e:     91 04 9F         LDAW 049F          ; Load direct address into byte of AW
0x1821:     04               EI                 ; Enable Interrupt system
0x1822:     A4 04            STAL [PC+0x04]     ; Store byte of AL into indirect PC offset by N address
0x1824:     A7               ???                ; Unknown. Illegal?
0x1825:     04               EI                 ; Enable Interrupt system
0x1826:     AD               SALS               ; Store byte from address in S into implicit AL
0x1827:     04               EI                 ; Enable Interrupt system
0x1828:     B2 04 BE         STAW [04BE]        ; Store AW into indirect address
0x182b:     04               EI                 ; Enable Interrupt system
0x182c:     C3 04            LDBL (PC+0x04)     ; Load direct PC offset by N address into byte of BL
0x182e:     C6               ???                ; Writes 0 to AH at interrupt level 1. See instructions B6 and 1F
0x182f:     04               EI                 ; Enable Interrupt system
0x1830:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x1831:     04               EI                 ; Enable Interrupt system
0x1832:     CC               LBLZ               ; Load byte from address in ZW into implicit BL
0x1833:     04               EI                 ; Enable Interrupt system
0x1834:     D1 04 D6         LDBW 04D6          ; Load direct address into byte of BW
0x1837:     04               EI                 ; Enable Interrupt system
0x1838:     DF               LBWP               ; Load byte from address in P into implicit BW
0x1839:     04               EI                 ; Enable Interrupt system
0x183a:     E2 04 E7         STBL [04E7]        ; Store BL into indirect address
0x183d:     04               EI                 ; Enable Interrupt system
0x183e:     EA               SBLX               ; Store byte from address in XW into implicit BL
0x183f:     04               EI                 ; Enable Interrupt system
0x1840:     F1 04 F4         STBW 04F4          ; Store BW into direct address
0x1843:     04               EI                 ; Enable Interrupt system
0x1844:     F9               SBWB               ; Store word from address in BW into implicit BW
0x1845:     04               EI                 ; Enable Interrupt system
0x1846:     FD               SBWS               ; Store word from address in S into implicit BW
0x1847:     05               DI                 ; Disable Interrupt system
0x1848:     02               SF                 ; Set Fault
0x1849:     05               DI                 ; Disable Interrupt system
0x184a:     05               DI                 ; Disable Interrupt system
0x184b:     05               DI                 ; Disable Interrupt system
0x184c:     0A               RI                 ; return(cont=1) from Interrupt
0x184d:     05               DI                 ; Disable Interrupt system
0x184e:     0D               PCX                ; Transfer PC to X
0x184f:     05               DI                 ; Disable Interrupt system
0x1850:     14 05            BZ   (PC+0x05)     ; Branch if equal to zero to 0x05 ahead PC (0x1857)
0x1852:     17 05            BP   (PC+0x05)     ; Branch on positive to 0x05 ahead PC (0x1859)
0x1854:     1C 05            BS3  (PC+0x05)     ; Branch if sense switch 3 set to 0x05 ahead PC (0x185b)
0x1856:     21 05            DCR  AH, 5         ; Decrement byte of explicit register by 1 + const.
0x1858:     28               INAL               ; Increment byte of implicit AL register
0x1859:     05               DI                 ; Disable Interrupt system
0x185a:     2F 05            ???                ; Special 2 byte instruction. See supplemental material.
0x185c:     34 05            SRR  AW, 5         ; Shift byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x185e:     3B               IVAW               ; Invert word of implicit AW register
0x185f:     05               DI                 ; Disable Interrupt system
0x1860:     46 05            ???                ; Special 2 byte instruction. See supplemental material.
0x1862:     4D               XABL               ; Transfer implicit AL into BL
0x1863:     05               DI                 ; Disable Interrupt system
0x1864:     4F               XASL               ; Transfer implicit AL into SL
0x1865:     05               DI                 ; Disable Interrupt system
0x1866:     51 05            MEM? AW,  M5       ; Odd register means operation on memory
0x1868:     53 6D            MEM? YW,  MD       ; Odd register means operation on memory
0x186a:     01               NOP                ; No Operation
0x186b:     78 00 00         JSR  #0000         ; Jump to subroutine at literal address (not possible?)
0x186e:     05               DI                 ; Disable Interrupt system
0x186f:     55 05            MEM? AW,  M5       ; Odd register means operation on memory
0x1871:     57               ???                ; Clear high bit in internal status register
0x1872:     05               DI                 ; Disable Interrupt system
0x1873:     59               SABW               ; Subtract implicit AW and BW
0x1874:     05               DI                 ; Disable Interrupt system
0x1875:     5B               XAXW               ; Transfer implicit AW into XW
0x1876:     05               DI                 ; Disable Interrupt system
0x1877:     5D               XABW               ; Transfer implicit AW into BW
0x1878:     05               DI                 ; Disable Interrupt system
0x1879:     5F               XASW               ; Transfer implicit AW into SW
0x187a:     05               DI                 ; Disable Interrupt system
0x187b:     61 05 A0         LDXW 05A0          ; Load direct word into word XW
0x187e:     05               DI                 ; Disable Interrupt system
0x187f:     A2 05 B2         STAL [05B2]        ; Store AL into indirect address
0x1882:     05               DI                 ; Disable Interrupt system
0x1883:     B7               ???                ; Unknown. Illegal?
0x1884:     05               DI                 ; Disable Interrupt system
0x1885:     BE               SAWC               ; Store word from address in C into implicit AW
0x1886:     05               DI                 ; Disable Interrupt system
0x1887:     C1 05 C5         LDBL 05C5          ; Load direct address into byte of BL
0x188a:     05               DI                 ; Disable Interrupt system
0x188b:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x188c:     05               DI                 ; Disable Interrupt system
0x188d:     D1 05 D4         LDBW 05D4          ; Load direct address into byte of BW
0x1890:     05               DI                 ; Disable Interrupt system
0x1891:     DB               LBWY               ; Load byte from address in YW into implicit BW
0x1892:     05               DI                 ; Disable Interrupt system
0x1893:     DF               LBWP               ; Load byte from address in P into implicit BW
0x1894:     05               DI                 ; Disable Interrupt system
0x1895:     E3 05            STBL (PC+0x05)     ; Store byte of BL into direct PC offset by N address
0x1897:     EF               SBLP               ; Store byte from address in P into implicit BL
0x1898:     05               DI                 ; Disable Interrupt system
0x1899:     F2 05 F5         STBW [05F5]        ; Store BW into indirect address
0x189c:     06               SL                 ; Set Link
0x189d:     03               RF                 ; Reset Fault
0x189e:     06               SL                 ; Set Link
0x189f:     06               SL                 ; Set Link
0x18a0:     06               SL                 ; Set Link
0x18a1:     11 06            BNL  (PC+0x06)     ; Branch if link not set to 0x06 ahead PC (0x18a9)
0x18a3:     18 06            BGZ  (PC+0x06)     ; Branch if greater than zero to 0x06 ahead PC (0x18ab)
0x18a5:     1F 06            BEP? (PC+0x06)     ; Branch on even parity to zero to 0x06 ahead PC (0x18ad)
0x18a7:     23 06            IVR  AH, 6         ; Invert byte of explicit register by 1 + const.
0x18a9:     29               DCAL               ; Decrement byte of implicit AL register
0x18aa:     06               SL                 ; Set Link
0x18ab:     2F 06            ???                ; Special 2 byte instruction. See supplemental material.
0x18ad:     32 06            CLR  AW, 6         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x18af:     40 06            ADD  AH,  YH       ; Add bytes of two explicit registers (L + R stored in L)
0x18b1:     45 06            XFR  AH,  YH       ; Copy byte of one explicit register into other (R into L)
0x18b3:     6E
0x18b4:     06               SL                 ; Set Link
0x18b5:     97
0x18b6:     06               SL                 ; Set Link
0x18b7:     9C               LAWZ               ; Load word from address in ZW into implicit AW
0x18b8:     06               SL                 ; Set Link
0x18b9:     9F               LAWP               ; Load word from address in P into implicit AW
0x18ba:     06               SL                 ; Set Link
0x18bb:     B7               ???                ; Unknown. Illegal?
0x18bc:     06               SL                 ; Set Link
0x18bd:     BC               SAWZ               ; Store word from address in ZW into implicit AW
0x18be:     06               SL                 ; Set Link
0x18bf:     BF               SAWP               ; Store word from address in P into implicit AW
0x18c0:     06               SL                 ; Set Link
0x18c1:     C5 06            LDAL AW, 6         ; Load index mode register address into BL (view supplemental material)
0x18c3:     C8               LBLA               ; Load byte from address in AW into implicit BL
0x18c4:     06               SL                 ; Set Link
0x18c5:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x18c6:     06               SL                 ; Set Link
0x18c7:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x18c8:     06               SL                 ; Set Link
0x18c9:     E2 06 E5         STBL [06E5]        ; Store BL into indirect address
0x18cc:     06               SL                 ; Set Link
0x18cd:     E9               SBLB               ; Store byte from address in BW into implicit BL
0x18ce:     06               SL                 ; Set Link
0x18cf:     EC               SBLZ               ; Store byte from address in ZW into implicit BL
0x18d0:     06               SL                 ; Set Link
0x18d1:     F1 07 02         STBW 0702          ; Store BW into direct address
0x18d4:     07               RL                 ; Reset Link
0x18d5:     06               SL                 ; Set Link
0x18d6:     07               RL                 ; Reset Link
0x18d7:     09               RSR                ; return(cont=1) from Subroutine
0x18d8:     07               RL                 ; Reset Link
0x18d9:     0C               ELO                ; Enable Link Out
0x18da:     07               RL                 ; Reset Link
0x18db:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x18dc:     07               RL                 ; Reset Link
0x18dd:     12 07            BF   (PC+0x07)     ; Branch if fault set to 0x07 ahead PC (0x18e6)
0x18df:     15 07            BNZ  (PC+0x07)     ; Branch if not equal to zero to 0x07 ahead PC (0x18e8)
0x18e1:     1A 07            BS1  (PC+0x07)     ; Branch if sense switch 1 set to 0x07 ahead PC (0x18ea)
0x18e3:     1D 07            BS4  (PC+0x07)     ; Branch if sense switch 4 set to zero to 0x07 ahead PC (0x18ec)
0x18e5:     20 7F            INR  YL, F         ; Increment byte of explicit register by 1 + const.
0x18e7:     80 00            LDAL #0000         ; Load literal address into byte of AL
0x18e9:     00               HLT                ; Halts the CPU
0x18ea:     00               HLT                ; Halts the CPU
0x18eb:     00               HLT                ; Halts the CPU
0x18ec:     00               HLT                ; Halts the CPU
0x18ed:     00               HLT                ; Halts the CPU
0x18ee:     00               HLT                ; Halts the CPU
0x18ef:     00               HLT                ; Halts the CPU
0x18f0:     00               HLT                ; Halts the CPU
0x18f1:     00               HLT                ; Halts the CPU
0x18f2:     00               HLT                ; Halts the CPU
0x18f3:     00               HLT                ; Halts the CPU
0x18f4:     00               HLT                ; Halts the CPU
0x18f5:     00               HLT                ; Halts the CPU
0x18f6:     00               HLT                ; Halts the CPU
0x18f7:     00               HLT                ; Halts the CPU
0x18f8:     00               HLT                ; Halts the CPU
0x18f9:     00               HLT                ; Halts the CPU
0x18fa:     00               HLT                ; Halts the CPU
0x18fb:     00               HLT                ; Halts the CPU
0x18fc:     00               HLT                ; Halts the CPU
0x18fd:     00               HLT                ; Halts the CPU
0x18fe:     00               HLT                ; Halts the CPU
0x18ff:     00               HLT                ; Halts the CPU
0x1900:     01               NOP                ; No Operation
0x1901:     78 00 00         JSR  #0000         ; Jump to subroutine at literal address (not possible?)
0x1904:     07               RL                 ; Reset Link
0x1905:     23 07            IVR  AH, 7         ; Invert byte of explicit register by 1 + const.
0x1907:     26 07            RRR  AH, 7         ; Rotate byte of explicit register right by 1 + const.
0x1909:     2B               IVAL               ; Invert byte of implicit AL register
0x190a:     07               RL                 ; Reset Link
0x190b:     2E 07            ???                ; Special 2 byte instruction. See supplemental material.
0x190d:     31 07            DCR  AW, 7         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x190f:     38               INAW               ; Increment word of implicit AW register
0x1910:     07               RL                 ; Reset Link
0x1911:     3B               IVAW               ; Invert word of implicit AW register
0x1912:     07               RL                 ; Reset Link
0x1913:     40 07            ADD  AH,  YL       ; Add bytes of two explicit registers (L + R stored in L)
0x1915:     43 07            ORI  AH,  YL       ; OR bytes of two explicit registers (L OR R stored in L)
0x1917:     48               AABL               ; Add implicit AL and BL
0x1918:     07               RL                 ; Reset Link
0x1919:     54 07            MEM? AW,  M7       ; Odd register means operation on memory
0x191b:     57               ???                ; Clear high bit in internal status register
0x191c:     07               RL                 ; Reset Link
0x191d:     5B               XAXW               ; Transfer implicit AW into XW
0x191e:     07               RL                 ; Reset Link
0x191f:     84 07            LDAL [PC+0x07]     ; Load indirect PC offset by N address into byte of AL
0x1921:     87               ???                ; Unknown. Illegal?
0x1922:     07               RL                 ; Reset Link
0x1923:     8A               LALX               ; Load byte from address in XW into implicit AL
0x1924:     07               RL                 ; Reset Link
0x1925:     8D               LALS               ; Load byte from address in S into implicit AL
0x1926:     07               RL                 ; Reset Link
0x1927:     90 07 94         LDAW #0794         ; Load literal address into byte of AW
0x192a:     07               RL                 ; Reset Link
0x192b:     97
0x192c:     07               RL                 ; Reset Link
0x192d:     9A               LAWX               ; Load word from address in XW into implicit AW
0x192e:     07               RL                 ; Reset Link
0x192f:     9D               LAWS               ; Load word from address in S into implicit AW
0x1930:     07               RL                 ; Reset Link
0x1931:     A0 07 A3         STAL 07A3          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1934:     07               RL                 ; Reset Link
0x1935:     AB               SALY               ; Store byte from address in YW into implicit AL
0x1936:     07               RL                 ; Reset Link
0x1937:     B0 07 B3         STAW 07B3          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x193a:     07               RL                 ; Reset Link
0x193b:     BB               SAWY               ; Store word from address in YW into implicit AW
0x193c:     07               RL                 ; Reset Link
0x193d:     C2 07 D2         LDBL [07D2]        ; Load indirect address into byte of BL
0x1940:     07               RL                 ; Reset Link
0x1941:     D5 07            LDAW AW, 7         ; Load index mode register address into BW (view supplemental material)
0x1943:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x1944:     07               RL                 ; Reset Link
0x1945:     E1 07 F1         STBL 07F1          ; Store BL into direct address
0x1948:     07               RL                 ; Reset Link
0x1949:     F8               SBWA               ; Store word from address in AW into implicit BW
0x194a:     07               RL                 ; Reset Link
0x194b:     FF               SBWP               ; Store word from address in P into implicit BW
0x194c:     08               CL                 ; Complement Link
0x194d:     0C               ELO                ; Enable Link Out
0x194e:     08               CL                 ; Complement Link
0x194f:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x1950:     08               CL                 ; Complement Link
0x1951:     14 08            BZ   (PC+0x08)     ; Branch if equal to zero to 0x08 ahead PC (0x195b)
0x1953:     17 08            BP   (PC+0x08)     ; Branch on positive to 0x08 ahead PC (0x195d)
0x1955:     1C 08            BS3  (PC+0x08)     ; Branch if sense switch 3 set to 0x08 ahead PC (0x195f)
0x1957:     1F 08            BEP? (PC+0x08)     ; Branch on even parity to zero to 0x08 ahead PC (0x1961)
0x1959:     27 08            RLR  AH, 8         ; Rotate byte of explicit register left by 1 + const.
0x195b:     2A               CLAL               ; Clear byte of implicit AL register
0x195c:     08               CL                 ; Complement Link
0x195d:     2F 08            ???                ; Special 2 byte instruction. See supplemental material.
0x195f:     32 08            CLR  AW, 8         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1961:     37 08            RLR  AW, 8         ; Rotate byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x1963:     3A               CLAW               ; Clear word of implicit AW register
0x1964:     08               CL                 ; Complement Link
0x1965:     3F               DCX                ; Decrement word of implicit X register
0x1966:     08               CL                 ; Complement Link
0x1967:     47 08            ???                ; Special 2 byte instruction. See supplemental material.
0x1969:     56               ???                ; Set high bit in internal status register
0x196a:     08               CL                 ; Complement Link
0x196b:     5B               XAXW               ; Transfer implicit AW into XW
0x196c:     08               CL                 ; Complement Link
0x196d:     60 08 63         LDXW #0863         ; Load literal word into word XW
0x1970:     08               CL                 ; Complement Link
0x1971:     6B 08            STXW (PC+0x08)     ; Store word of XW into direct PC offset by N address
0x1973:     7E 08 87         PUSH               ; Push multiple 8-bit registers to stack
0x1974:     08               CL                 ; Complement Link
0x1975:     87               ???                ; Unknown. Illegal?
0x1976:     08               CL                 ; Complement Link
0x1977:     8D               LALS               ; Load byte from address in S into implicit AL
0x1978:     08               CL                 ; Complement Link
0x1979:     90 08 96         LDAW #0896         ; Load literal address into byte of AW
0x197c:     C7               ???                ; Unknown. Illegal?
0x197d:     01               NOP                ; No Operation
0x197e:     1E 00            BTM? (PC+0x00)     ; Branch on TTY Mark to 0x00 ahead PC (0x1980)
0x1980:     00               HLT                ; Halts the CPU
0x1981:     08               CL                 ; Complement Link
0x1982:     9C               LAWZ               ; Load word from address in ZW into implicit AW
0x1983:     08               CL                 ; Complement Link
0x1984:     A0 08 A5         STAL 08A5          ; Store AL into PC address (PC)- <- X (Opposite 60)
0x1987:     08               CL                 ; Complement Link
0x1988:     AB               SALY               ; Store byte from address in YW into implicit AL
0x1989:     08               CL                 ; Complement Link
0x198a:     AE               SALC               ; Store byte from address in C into implicit AL
0x198b:     08               CL                 ; Complement Link
0x198c:     B0 08 B5         STAW 08B5          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x198f:     08               CL                 ; Complement Link
0x1990:     B8               SAWA               ; Store word from address in AW into implicit AW
0x1991:     08               CL                 ; Complement Link
0x1992:     D0 08 E3         LDBW #08E3         ; Load literal address into byte of BW
0x1995:     08               CL                 ; Complement Link
0x1996:     F3 08            STBW (PC+0x08)     ; Store word of BW into direct PC offset by N address
0x1998:     FB               SBWY               ; Store word from address in YW into implicit BW
0x1999:     09               RSR                ; return(cont=1) from Subroutine
0x199a:     03               RF                 ; Reset Fault
0x199b:     09               RSR                ; return(cont=1) from Subroutine
0x199c:     08               CL                 ; Complement Link
0x199d:     09               RSR                ; return(cont=1) from Subroutine
0x199e:     0B               RIM                ; return(cont=1) from Interrupt Modified
0x199f:     58               AABW               ; Add implicit AW and BW
0x19a0:     01               NOP                ; No Operation
0x19a1:     02               SF                 ; Set Fault
0x19a2:     39               DCAW               ; Decrement word of implicit AW register
0x19a3:     13 05            BNF  (PC+0x05)     ; Branch if fault not set to 0x05 ahead PC (0x19aa)
0x19a5:     ED               SBLS               ; Store byte from address in S into implicit BL
0x19a6:     BF               SAWP               ; Store word from address in P into implicit AW
0x19a7:     01               NOP                ; No Operation
0x19a8:     02               SF                 ; Set Fault
0x19a9:     39               DCAW               ; Decrement word of implicit AW register
0x19aa:     1F 01            BEP? (PC+0x01)     ; Branch on even parity to zero to 0x01 ahead PC (0x19ad)
0x19ac:     FE               SBWC               ; Store word from address in C into implicit BW
0x19ad:     A6               ???                ; Turn on CPU line 4
0x19ae:     01               NOP                ; No Operation
0x19af:     02               SF                 ; Set Fault
0x19b0:     39               DCAW               ; Decrement word of implicit AW register
0x19b1:     1F 02            BEP? (PC+0x02)     ; Branch on even parity to zero to 0x02 ahead PC (0x19b5)
0x19b3:     AF               SALP               ; Store byte from address in P into implicit AL
0x19b4:     F4 01            STBW [PC+0x01]     ; Store word of BW into indirect PC offset by N address
0x19b6:     02               SF                 ; Set Fault
0x19b7:     39               DCAW               ; Decrement word of implicit AW register
0x19b8:     65 02            LDXW AW, 2         ; Load index mode into word XW (view supplemental material)
0x19ba:     03               RF                 ; Reset Fault
0x19bb:     5A               NABW               ; AND implicit AW and BW
0x19bc:     01               NOP                ; No Operation
0x19bd:     02               SF                 ; Set Fault
0x19be:     39               DCAW               ; Decrement word of implicit AW register
0x19bf:     A3 02            STAL (PC+0x02)     ; Store byte of AL into direct PC offset by N address
0x19c1:     0E               DLY                ; Delay 4.5ms
0x19c2:     11 01            BNL  (PC+0x01)     ; Branch if link not set to 0x01 ahead PC (0x19c5)
0x19c4:     02               SF                 ; Set Fault
0x19c5:     3A               CLAW               ; Clear word of implicit AW register
0x19c6:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x19c7:     02               SF                 ; Set Fault
0x19c8:     19 99            BLE  (PC-0x67)     ; Branch if less than or equal to zero to 0x67 behind PC (0x1963)
0x19ca:     01               NOP                ; No Operation
0x19cb:     02               SF                 ; Set Fault
0x19cc:     3A               CLAW               ; Clear word of implicit AW register
0x19cd:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x19ce:     3A               CLAW               ; Clear word of implicit AW register
0x19cf:     34 46            SRR  X,  6         ; Shift byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x19d1:     01               NOP                ; No Operation
0x19d2:     02               SF                 ; Set Fault
0x19d3:     3A               CLAW               ; Clear word of implicit AW register
0x19d4:     AA               SALX               ; Store byte from address in XW into implicit AL
0x19d5:     02               SF                 ; Set Fault
0x19d6:     24 F3            SRR 3         ; Shift byte of explicit register right by 1 + const.
0x19d8:     01               NOP                ; No Operation
0x19d9:     04               EI                 ; Enable Interrupt system
0x19da:     3A               CLAW               ; Clear word of implicit AW register
0x19db:     AA               SALX               ; Store byte from address in XW into implicit AL
0x19dc:     3A               CLAW               ; Clear word of implicit AW register
0x19dd:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x19de:     3B               IVAW               ; Invert word of implicit AW register
0x19df:     14 C3            BZ   (PC-0x3d)     ; Branch if equal to zero to 0x3d behind PC (0x19a4)
0x19e1:     01               NOP                ; No Operation
0x19e2:     02               SF                 ; Set Fault
0x19e3:     3B               IVAW               ; Invert word of implicit AW register
0x19e4:     4E               XAZL               ; Transfer implicit AL into ZL
0x19e5:     02               SF                 ; Set Fault
0x19e6:     2F 43            ???                ; Special 2 byte instruction. See supplemental material.
0x19e8:     01               NOP                ; No Operation
0x19e9:     0C               ELO                ; Enable Link Out
0x19ea:     3B               IVAW               ; Invert word of implicit AW register
0x19eb:     4E               XAZL               ; Transfer implicit AL into ZL
0x19ec:     3B               IVAW               ; Invert word of implicit AW register
0x19ed:     56               ???                ; Set high bit in internal status register
0x19ee:     3B               IVAW               ; Invert word of implicit AW register
0x19ef:     97
0x19f0:     3B               IVAW               ; Invert word of implicit AW register
0x19f1:     A1 3B A8         STAL 3BA8          ; Store AL into direct address
0x19f4:     3B               IVAW               ; Invert word of implicit AW register
0x19f5:     F6               ???                ; Page table management?
0x19f6:     3C               SRAW               ; Shift word of implicit AW register left
0x19f7:     17 C4            BP   (PC-0x3c)     ; Branch on positive to 0x3c behind PC (0x19bd)
0x19f9:     01               NOP                ; No Operation
0x19fa:     02               SF                 ; Set Fault
0x19fb:     3C               SRAW               ; Shift word of implicit AW register left
0x19fc:     6F
0x19fd:     02               SF                 ; Set Fault
0x19fe:     3A               CLAW               ; Clear word of implicit AW register
0x19ff:     16 01            BM   (PC+0x01)     ; Branch if minus set to 0x01 ahead PC (0x1a02)
0x1a01:     02               SF                 ; Set Fault
0x1a02:     3C               SRAW               ; Shift word of implicit AW register left
0x1a03:     6F
0x1a04:     3C               SRAW               ; Shift word of implicit AW register left
0x1a05:     E1 35 01         STBL 3501          ; Store BL into direct address
0x1a08:     02               SF                 ; Set Fault
0x1a09:     3D               SLAW               ; Shift word of implicit AW register right
0x1a0a:     02               SF                 ; Set Fault
0x1a0b:     08               CL                 ; Complement Link
0x1a0c:     F9               SBWB               ; Store word from address in BW into implicit BW
0x1a0d:     BD               SAWS               ; Store word from address in S into implicit AW
0x1a0e:     01               NOP                ; No Operation
0x1a0f:     02               SF                 ; Set Fault
0x1a10:     3D               SLAW               ; Shift word of implicit AW register right
0x1a11:     02               SF                 ; Set Fault
0x1a12:     09               RSR                ; return(cont=1) from Subroutine
0x1a13:     01               NOP                ; No Operation
0x1a14:     B4 01            STAW [PC+0x01]     ; Store word of AW into indirect PC offset by N address
0x1a16:     02               SF                 ; Set Fault
0x1a17:     3D               SLAW               ; Shift word of implicit AW register right
0x1a18:     15 0C            BNZ  (PC+0x0C)     ; Branch if not equal to zero to 0x0C ahead PC (0x1a26)
0x1a1a:     15 8A            BNZ  (PC-0x76)     ; Branch if not equal to zero to 0x76 behind PC (0x19a6)
0x1a1c:     01               NOP                ; No Operation
0x1a1d:     02               SF                 ; Set Fault
0x1a1e:     3D               SLAW               ; Shift word of implicit AW register right
0x1a1f:     17 08            BP   (PC+0x08)     ; Branch on positive to 0x08 ahead PC (0x1a29)
0x1a21:     A3 FE            STAL (PC-0x02)     ; Store byte of AL into direct PC offset by N address
0x1a23:     01               NOP                ; No Operation
0x1a24:     02               SF                 ; Set Fault
0x1a25:     3D               SLAW               ; Shift word of implicit AW register right
0x1a26:     5B               XAXW               ; Transfer implicit AW into XW
0x1a27:     06               SL                 ; Set Link
0x1a28:     0E               DLY                ; Delay 4.5ms
0x1a29:     51 01            MEM? AW,  M1       ; Odd register means operation on memory
0x1a2b:     02               SF                 ; Set Fault
0x1a2c:     3D               SLAW               ; Shift word of implicit AW register right
0x1a2d:     5B               XAXW               ; Transfer implicit AW into XW
0x1a2e:     3D               SLAW               ; Shift word of implicit AW register right
0x1a2f:     31 F7            DCR  MEM, 7         ; Decrement byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1a31:     01               NOP                ; No Operation
0x1a32:     02               SF                 ; Set Fault
0x1a33:     3D               SLAW               ; Shift word of implicit AW register right
0x1a34:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a35:     01               NOP                ; No Operation
0x1a36:     8E               LALC               ; Load byte from address in C into implicit AL
0x1a37:     84 01            LDAL [PC+0x01]     ; Load indirect PC offset by N address into byte of AL
0x1a39:     02               SF                 ; Set Fault
0x1a3a:     3D               SLAW               ; Shift word of implicit AW register right
0x1a3b:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a3c:     01               NOP                ; No Operation
0x1a3d:     C2 50 01         LDBL [5001]        ; Load indirect address into byte of BL
0x1a40:     02               SF                 ; Set Fault
0x1a41:     3D               SLAW               ; Shift word of implicit AW register right
0x1a42:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a43:     02               SF                 ; Set Fault
0x1a44:     45 CC            XFR  C ,  C        ; Copy byte of one explicit register into other (R into L)
0x1a46:     01               NOP                ; No Operation
0x1a47:     02               SF                 ; Set Fault
0x1a48:     3D               SLAW               ; Shift word of implicit AW register right
0x1a49:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a4a:     02               SF                 ; Set Fault
0x1a4b:     E1 30 01         STBL 3001          ; Store BL into direct address
0x1a4e:     02               SF                 ; Set Fault
0x1a4f:     3D               SLAW               ; Shift word of implicit AW register right
0x1a50:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a51:     03               RF                 ; Reset Fault
0x1a52:     45 CB            XFR  C ,  SL       ; Copy byte of one explicit register into other (R into L)
0x1a54:     01               NOP                ; No Operation
0x1a55:     02               SF                 ; Set Fault
0x1a56:     3D               SLAW               ; Shift word of implicit AW register right
0x1a57:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a58:     03               RF                 ; Reset Fault
0x1a59:     97
0x1a5a:     79 01 02         JSR  0102          ; Jump to subroutine at direct address
0x1a5d:     3D               SLAW               ; Shift word of implicit AW register right
0x1a5e:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a5f:     03               RF                 ; Reset Fault
0x1a60:     C9               LBLB               ; Load byte from address in BW into implicit BL
0x1a61:     47 01            ???                ; Special 2 byte instruction. See supplemental material.
0x1a63:     02               SF                 ; Set Fault
0x1a64:     3D               SLAW               ; Shift word of implicit AW register right
0x1a65:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a66:     04               EI                 ; Enable Interrupt system
0x1a67:     0D               PCX                ; Transfer PC to X
0x1a68:     02               SF                 ; Set Fault
0x1a69:     01               NOP                ; No Operation
0x1a6a:     02               SF                 ; Set Fault
0x1a6b:     3D               SLAW               ; Shift word of implicit AW register right
0x1a6c:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a6d:     04               EI                 ; Enable Interrupt system
0x1a6e:     30 DF            INR  MEM, F         ; Increment byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1a70:     01               NOP                ; No Operation
0x1a71:     02               SF                 ; Set Fault
0x1a72:     3D               SLAW               ; Shift word of implicit AW register right
0x1a73:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a74:     04               EI                 ; Enable Interrupt system
0x1a75:     58               AABW               ; Add implicit AW and BW
0x1a76:     B7               ???                ; Unknown. Illegal?
0x1a77:     01               NOP                ; No Operation
0x1a78:     02               SF                 ; Set Fault
0x1a79:     3D               SLAW               ; Shift word of implicit AW register right
0x1a7a:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a7b:     05               DI                 ; Disable Interrupt system
0x1a7c:     68 A6 01         STXW A601          ; Store XW into PC address (PC)- <- X (Opposite 60)
0x1a7f:     02               SF                 ; Set Fault
0x1a80:     3D               SLAW               ; Shift word of implicit AW register right
0x1a81:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a82:     06               SL                 ; Set Link
0x1a83:     D8               LBWA               ; Load byte from address in AW into implicit BW
0x1a84:     35 80            SLR  ZW, 0         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x1a86:     00               HLT                ; Halts the CPU
0x1a87:     00               HLT                ; Halts the CPU
0x1a88:     00               HLT                ; Halts the CPU
0x1a89:     00               HLT                ; Halts the CPU
0x1a8a:     00               HLT                ; Halts the CPU
0x1a8b:     00               HLT                ; Halts the CPU
0x1a8c:     00               HLT                ; Halts the CPU
0x1a8d:     00               HLT                ; Halts the CPU
0x1a8e:     00               HLT                ; Halts the CPU
0x1a8f:     00               HLT                ; Halts the CPU
0x1a90:     01               NOP                ; No Operation
0x1a91:     02               SF                 ; Set Fault
0x1a92:     3D               SLAW               ; Shift word of implicit AW register right
0x1a93:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a94:     08               CL                 ; Complement Link
0x1a95:     54 B7            MEM? MB,  M7       ; Odd register means operation on memory
0x1a97:     01               NOP                ; No Operation
0x1a98:     02               SF                 ; Set Fault
0x1a99:     3D               SLAW               ; Shift word of implicit AW register right
0x1a9a:     AD               SALS               ; Store byte from address in S into implicit AL
0x1a9b:     08               CL                 ; Complement Link
0x1a9c:     C7               ???                ; Unknown. Illegal?
0x1a9d:     44 01            ORE  AH,  AL       ; XOR bytes of two explicit registers (L XOR R stored in L)
0x1a9f:     02               SF                 ; Set Fault
0x1aa0:     3D               SLAW               ; Shift word of implicit AW register right
0x1aa1:     AD               SALS               ; Store byte from address in S into implicit AL
0x1aa2:     09               RSR                ; return(cont=1) from Subroutine
0x1aa3:     06               SL                 ; Set Link
0x1aa4:     04               EI                 ; Enable Interrupt system
0x1aa5:     01               NOP                ; No Operation
0x1aa6:     02               SF                 ; Set Fault
0x1aa7:     3D               SLAW               ; Shift word of implicit AW register right
0x1aa8:     AD               SALS               ; Store byte from address in S into implicit AL
0x1aa9:     39               DCAW               ; Decrement word of implicit AW register
0x1aaa:     24 B6            SRR  SL, 6         ; Shift byte of explicit register right by 1 + const.
0x1aac:     01               NOP                ; No Operation
0x1aad:     02               SF                 ; Set Fault
0x1aae:     3D               SLAW               ; Shift word of implicit AW register right
0x1aaf:     AD               SALS               ; Store byte from address in S into implicit AL
0x1ab0:     3A               CLAW               ; Clear word of implicit AW register
0x1ab1:     32 A7            CLR  SW, 7         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1ab3:     01               NOP                ; No Operation
0x1ab4:     02               SF                 ; Set Fault
0x1ab5:     3D               SLAW               ; Shift word of implicit AW register right
0x1ab6:     AD               SALS               ; Store byte from address in S into implicit AL
0x1ab7:     3B               IVAW               ; Invert word of implicit AW register
0x1ab8:     12 C6            BF   (PC-0x3a)     ; Branch if fault set to 0x3a behind PC (0x1a80)
0x1aba:     01               NOP                ; No Operation
0x1abb:     02               SF                 ; Set Fault
0x1abc:     3D               SLAW               ; Shift word of implicit AW register right
0x1abd:     AD               SALS               ; Store byte from address in S into implicit AL
0x1abe:     3B               IVAW               ; Invert word of implicit AW register
0x1abf:     95 43            LDAW X , 3         ; Load index mode register address into AW (view supplemental material)
0x1ac1:     01               NOP                ; No Operation
0x1ac2:     02               SF                 ; Set Fault
0x1ac3:     3D               SLAW               ; Shift word of implicit AW register right
0x1ac4:     AD               SALS               ; Store byte from address in S into implicit AL
0x1ac5:     3B               IVAW               ; Invert word of implicit AW register
0x1ac6:     9F               LAWP               ; Load word from address in P into implicit AW
0x1ac7:     39               DCAW               ; Decrement word of implicit AW register
0x1ac8:     01               NOP                ; No Operation
0x1ac9:     02               SF                 ; Set Fault
0x1aca:     3D               SLAW               ; Shift word of implicit AW register right
0x1acb:     AD               SALS               ; Store byte from address in S into implicit AL
0x1acc:     3B               IVAW               ; Invert word of implicit AW register
0x1acd:     A6               ???                ; Turn on CPU line 4
0x1ace:     32 01            CLR  AW, 1         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1ad0:     02               SF                 ; Set Fault
0x1ad1:     3D               SLAW               ; Shift word of implicit AW register right
0x1ad2:     AD               SALS               ; Store byte from address in S into implicit AL
0x1ad3:     3C               SRAW               ; Shift word of implicit AW register left
0x1ad4:     DF               LBWP               ; Load byte from address in P into implicit BW
0x1ad5:     F8               SBWA               ; Store word from address in AW into implicit BW
0x1ad6:     01               NOP                ; No Operation
0x1ad7:     02               SF                 ; Set Fault
0x1ad8:     3E               INX                ; Increment word of implicit X register
0x1ad9:     2C               SRAL               ; Shift byte of implicit AL register left
0x1ada:     01               NOP                ; No Operation
0x1adb:     C7               ???                ; Unknown. Illegal?
0x1adc:     CB               LBLY               ; Load byte from address in YW into implicit BL
0x1add:     01               NOP                ; No Operation
0x1ade:     02               SF                 ; Set Fault
0x1adf:     3E               INX                ; Increment word of implicit X register
0x1ae0:     2C               SRAL               ; Shift byte of implicit AL register left
0x1ae1:     02               SF                 ; Set Fault
0x1ae2:     4A               NABL               ; AND implicit AL and BL
0x1ae3:     47 01            ???                ; Special 2 byte instruction. See supplemental material.
0x1ae5:     02               SF                 ; Set Fault
0x1ae6:     3E               INX                ; Increment word of implicit X register
0x1ae7:     2C               SRAL               ; Shift byte of implicit AL register left
0x1ae8:     02               SF                 ; Set Fault
0x1ae9:     E6 AB            ???                ; Load AW from any register in register file?
0x1aeb:     01               NOP                ; No Operation
0x1aec:     02               SF                 ; Set Fault
0x1aed:     3E               INX                ; Increment word of implicit X register
0x1aee:     2C               SRAL               ; Shift byte of implicit AL register left
0x1aef:     03               RF                 ; Reset Fault
0x1af0:     4A               NABL               ; AND implicit AL and BL
0x1af1:     46 01            ???                ; Special 2 byte instruction. See supplemental material.
0x1af3:     02               SF                 ; Set Fault
0x1af4:     3E               INX                ; Increment word of implicit X register
0x1af5:     2C               SRAL               ; Shift byte of implicit AL register left
0x1af6:     03               RF                 ; Reset Fault
0x1af7:     CE               LBLC               ; Load byte from address in C into implicit BL
0x1af8:     C2 01 02         LDBL [0102]        ; Load indirect address into byte of BL
0x1afb:     3E               INX                ; Increment word of implicit X register
0x1afc:     2C               SRAL               ; Shift byte of implicit AL register left
0x1afd:     04               EI                 ; Enable Interrupt system
0x1afe:     12 7D            BF   (PC+0x7D)     ; Branch if fault set to 0x7D ahead PC (0x1b7d)
0x1b00:     01               NOP                ; No Operation
0x1b01:     02               SF                 ; Set Fault
0x1b02:     3E               INX                ; Increment word of implicit X register
0x1b03:     2C               SRAL               ; Shift byte of implicit AL register left
0x1b04:     04               EI                 ; Enable Interrupt system
0x1b05:     35 5A            SLR  MEM, A         ; Shift byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x1b07:     01               NOP                ; No Operation
0x1b08:     02               SF                 ; Set Fault
0x1b09:     3E               INX                ; Increment word of implicit X register
0x1b0a:     2C               SRAL               ; Shift byte of implicit AL register left
0x1b0b:     05               DI                 ; Disable Interrupt system
0x1b0c:     73 1B            JMP  (PC+0x1B)     ; Jump to direct PC offset by N address  (0x1b29)
0x1b0e:     01               NOP                ; No Operation
0x1b0f:     02               SF                 ; Set Fault
0x1b10:     3E               INX                ; Increment word of implicit X register
0x1b11:     2C               SRAL               ; Shift byte of implicit AL register left
0x1b12:     39               DCAW               ; Decrement word of implicit AW register
0x1b13:     2D               SLAL               ; Shift byte of implicit AL register right
0x1b14:     2D               SLAL               ; Shift byte of implicit AL register right
0x1b15:     01               NOP                ; No Operation
0x1b16:     02               SF                 ; Set Fault
0x1b17:     3D               SLAW               ; Shift word of implicit AW register right
0x1b18:     D3 01            LDBW (PC+0x01)     ; Load direct PC offset by N address into word of BW
0x1b1a:     D5 17            LDAW, 7         ; Load index mode register address into BW (view supplemental material)
0x1b1c:     01               NOP                ; No Operation
0x1b1d:     02               SF                 ; Set Fault
0x1b1e:     3D               SLAW               ; Shift word of implicit AW register right
0x1b1f:     D3 02            LDBW (PC+0x02)     ; Load direct PC offset by N address into word of BW
0x1b21:     EB               SBLY               ; Store byte from address in YW into implicit BL
0x1b22:     00               HLT                ; Halts the CPU
0x1b23:     01               NOP                ; No Operation
0x1b24:     02               SF                 ; Set Fault
0x1b25:     3D               SLAW               ; Shift word of implicit AW register right
0x1b26:     D3 03            LDBW (PC+0x03)     ; Load direct PC offset by N address into word of BW
0x1b28:     56               ???                ; Set high bit in internal status register
0x1b29:     94 01            LDAW [PC+0x01]     ; Load indirect PC offset by N address into word of AW
0x1b2b:     02               SF                 ; Set Fault
0x1b2c:     3D               SLAW               ; Shift word of implicit AW register right
0x1b2d:     D3 03            LDBW (PC+0x03)     ; Load direct PC offset by N address into word of BW
0x1b2f:     DA               LBWX               ; Load byte from address in XW into implicit BW
0x1b30:     10 01            BL   (PC+0x01)     ; Branch if link set to 0x01 ahead PC (0x1b33)
0x1b32:     02               SF                 ; Set Fault
0x1b33:     3D               SLAW               ; Shift word of implicit AW register right
0x1b34:     D3 05            LDBW (PC+0x05)     ; Load direct PC offset by N address into word of BW
0x1b36:     9D               LAWS               ; Load word from address in S into implicit AW
0x1b37:     4B               XAXL               ; Transfer implicit AL into XL
0x1b38:     01               NOP                ; No Operation
0x1b39:     02               SF                 ; Set Fault
0x1b3a:     3E               INX                ; Increment word of implicit X register
0x1b3b:     5E               XAZW               ; Transfer implicit AW into ZW
0x1b3c:     01               NOP                ; No Operation
0x1b3d:     84 DC            LDAL [PC-0x24]     ; Load indirect PC offset by N address into byte of AL
0x1b3f:     01               NOP                ; No Operation
0x1b40:     02               SF                 ; Set Fault
0x1b41:     3E               INX                ; Increment word of implicit X register
0x1b42:     59               SABW               ; Subtract implicit AW and BW
0x1b43:     01               NOP                ; No Operation
0x1b44:     67               ???                ; Unknown
0x1b45:     FE               SBWC               ; Store word from address in C into implicit BW
0x1b46:     01               NOP                ; No Operation
0x1b47:     08               CL                 ; Complement Link
0x1b48:     3D               SLAW               ; Shift word of implicit AW register right
0x1b49:     AD               SALS               ; Store byte from address in S into implicit AL
0x1b4a:     3E               INX                ; Increment word of implicit X register
0x1b4b:     32 3E            CLR  MEM, E         ; Clear byte of explicit register by 1 + const. (Odd reg. on MEM)
0x1b4d:     6A 3E 76         STXW [3E76]        ; Store XW into indirect address
0x1b50:     3E               INX                ; Increment word of implicit X register
0x1b51:     8F               LALP               ; Load byte from address in P into implicit AL
0x1b52:     74 01            JMP  [PC+0x01]     ; Jump to indirect PC offset by N address
0x1b54:     02               SF                 ; Set Fault
0x1b55:     3E               INX                ; Increment word of implicit X register
0x1b56:     D1 05 FC         LDBW 05FC          ; Load direct address into byte of BW
0x1b59:     ED               SBLS               ; Store byte from address in S into implicit BL
0x1b5a:     01               NOP                ; No Operation
0x1b5b:     02               SF                 ; Set Fault
0x1b5c:     3F               DCX                ; Decrement word of implicit X register
0x1b5d:     1F 08            BEP? (PC+0x08)     ; Branch on even parity to zero to 0x08 ahead PC (0x1b67)
0x1b5f:     8A               LALX               ; Load byte from address in XW into implicit AL
0x1b60:     0D               PCX                ; Transfer PC to X
0x1b61:     01               NOP                ; No Operation
0x1b62:     02               SF                 ; Set Fault
0x1b63:     3F               DCX                ; Decrement word of implicit X register
0x1b64:     1F 08            BEP? (PC+0x08)     ; Branch on even parity to zero to 0x08 ahead PC (0x1b6e)
0x1b66:     93 04            LDAW (PC+0x04)     ; Load direct PC offset by N address into word of AW
0x1b68:     01               NOP                ; No Operation
0x1b69:     02               SF                 ; Set Fault
0x1b6a:     3F               DCX                ; Decrement word of implicit X register
0x1b6b:     1F 08            BEP? (PC+0x08)     ; Branch on even parity to zero to 0x08 ahead PC (0x1b75)
0x1b6d:     F0 A7 01         STBW A701          ; Store BW into PC address (PC)- <- X (Opposite 60)
0x1b70:     02               SF                 ; Set Fault
0x1b71:     3F               DCX                ; Decrement word of implicit X register
0x1b72:     1F 3D            BEP? (PC+0x3D)     ; Branch on even parity to zero to 0x3D ahead PC (0x1bb1)
0x1b74:     06               SL                 ; Set Link
0x1b75:     5C               XAYW               ; Transfer implicit AW into YW
0x1b76:     01               NOP                ; No Operation
0x1b77:     02               SF                 ; Set Fault
0x1b78:     3F               DCX                ; Decrement word of implicit X register
0x1b79:     1F 3D            BEP? (PC+0x3D)     ; Branch on even parity to zero to 0x3D ahead PC (0x1bb8)
0x1b7b:     0D               PCX                ; Transfer PC to X
0x1b7c:     55 00            XFR  AW,  AW       ; Copy word of one explicit register into other (R into L)
0x1b7e:     00               HLT                ; Halts the CPU
0x1b7f:     01               NOP                ; No Operation
0x1b80:     64 9B            LDXW [PC-0x65]     ; Load indirect PC offset by N address into word XW
0x1b82:     84 A8            LDAL [PC-0x58]     ; Load indirect PC offset by N address into byte of AL
0x1b84:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b85:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b86:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b87:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b88:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b89:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8a:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8b:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8c:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8d:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8e:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b8f:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b90:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b91:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b92:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b93:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b94:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b95:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b96:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b97:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b98:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b99:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9a:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9b:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9c:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9d:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9e:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1b9f:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1ba9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1baa:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bab:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bac:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bad:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bae:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1baf:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bb9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bba:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bbb:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bbc:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bbd:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bbe:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bbf:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bc9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bca:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bcb:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bcc:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bcd:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bce:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bcf:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bd9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bda:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bdb:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bdc:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bdd:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bde:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bdf:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1be9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bea:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1beb:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bec:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bed:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bee:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bef:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf0:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf1:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf2:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf3:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf4:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf5:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf6:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf7:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf8:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bf9:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bfa:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bfb:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bfc:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bfd:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bfe:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1bff:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c00:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c01:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c02:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c03:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c04:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c05:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c06:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c07:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c08:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c09:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0a:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0b:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0c:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0d:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0e:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c0f:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c10:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c11:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c12:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c13:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c14:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c15:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c16:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c17:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c18:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c19:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1a:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1b:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1c:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1d:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1e:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c1f:     A8               SALA               ; Store byte from address in AW into implicit AL
0x1c20:     00               HLT                ; Halts the CPU
