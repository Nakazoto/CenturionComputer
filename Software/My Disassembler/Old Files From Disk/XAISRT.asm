0x0000:     00               HLT                ; Halts the CPU
0x0001:     78 00 00         JSR  #0000         ; Jump to subroutine at literal address (not possible?)
0x0004:     B1 00 BA         STAW 00BA          ; Store AW into direct address
0x0007:     7E 63 71         PUSH               ; Push multiple 8-bit registers to stack
0x0008:     63 71            LDXW (PC+0x71)     ; Load direct PC offset by N address into word XW
0x000a:     00               HLT                ; Halts the CPU
0x000b:     08               CL                 ; Complement Link
0x000c:     D5 28 04         LDBW BW, 8, 0x04   ; Load index mode register address into BW (view supplemental material)
0x000f:     F1 00 C6         STBW 00C6          ; Store BW into direct address
0x0012:     91 00 BA         LDAW 00BA          ; Load direct address into byte of AW
0x0015:     B0 00 00         STAW 0000          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0018:     90 00 3E         LDAW #003E         ; Load literal address into byte of AW
0x001b:     B3 ED            STAW (PC-0x13)     ; Store word of AW into direct PC offset by N address
0x001d:     01               NOP                ; No Operation
0x001e:     66 39            JSYS               ; System call. See supplemental material.
0x0020:     03               RF                 ; Reset Fault
0x0021:     00               HLT                ; Halts the CPU
0x0022:     AA               SALX               ; Store byte from address in XW into implicit AL
0x0023:     00               HLT                ; Halts the CPU
0x0024:     01               NOP                ; No Operation
0x0025:     66 1E            JSYS               ; System call. See supplemental material.
0x0027:     00               HLT                ; Halts the CPU
0x0028:     00               HLT                ; Halts the CPU
0x0029:     01               NOP                ; No Operation
0x002a:     66 1F            JSYS               ; System call. See supplemental material.
0x002c:     02               SF                 ; Set Fault
0x002d:     5B               XAXW               ; Transfer implicit AW into XW
0x002e:     01               NOP                ; No Operation
0x002f:     66 37            JSYS               ; System call. See supplemental material.
0x0031:     00               HLT                ; Halts the CPU
0x0032:     AA               SALX               ; Store byte from address in XW into implicit AL
0x0033:     02               SF                 ; Set Fault
0x0034:     5F               XASW               ; Transfer implicit AW into SW
0x0035:     93 DF            LDAW (PC-0x21)     ; Load direct PC offset by N address into word of AW
0x0037:     B1 00 BA         STAW 00BA          ; Store AW into direct address
0x003a:     91 00 C6         LDAW 00C6          ; Load direct address into byte of AW
0x003d:     B1 00 B8         STAW 00B8          ; Store AW into direct address
0x0040:     73 C7            JMP  (PC-0x39)     ; Jump to direct PC offset by N address  (0x0009)
0x0042:     01               NOP                ; No Operation
0x0043:     66 1E            JSYS               ; System call. See supplemental material.
0x0045:     02               SF                 ; Set Fault
0x0046:     5B               XAXW               ; Transfer implicit AW into XW
0x0047:     01               NOP                ; No Operation
0x0048:     66 20            JSYS               ; System call. See supplemental material.
0x004a:     00               HLT                ; Halts the CPU
0x004b:     01               NOP                ; No Operation
0x004c:     01               NOP                ; No Operation
0x004d:     66 1F            JSYS               ; System call. See supplemental material.
0x004f:     02               SF                 ; Set Fault
0x0050:     5B               XAXW               ; Transfer implicit AW into XW
0x0051:     01               NOP                ; No Operation
0x0052:     66 26            JSYS               ; System call. See supplemental material.
0x0054:     02               SF                 ; Set Fault
0x0055:     5B               XAXW               ; Transfer implicit AW into XW
0x0056:     02               SF                 ; Set Fault
0x0057:     63 00            LDXW (PC+0x00)     ; Load direct PC offset by N address into word XW
0x0059:     69 03 01         STXW 0301          ; Store XW into direct address
0x005c:     66 1E            JSYS               ; System call. See supplemental material.
0x005e:     00               HLT                ; Halts the CPU
0x005f:     00               HLT                ; Halts the CPU
0x0060:     01               NOP                ; No Operation
0x0061:     66 1F            JSYS               ; System call. See supplemental material.
0x0063:     02               SF                 ; Set Fault
0x0064:     5B               XAXW               ; Transfer implicit AW into XW
0x0065:     7F 63 90         POP                ; Pop multiple 8-bit registers from stack
0x0066:     63 90            LDXW (PC-0x70)     ; Load direct PC offset by N address into word XW
0x0068:     00               HLT                ; Halts the CPU
0x0069:     72 B3 9E         JMP  [B39E]        ; Jump to indirect address
0x006c:     09               RSR                ; return(cont=1) from Subroutine
0x006d:     79 00 98         JSR  0098          ; Jump to subroutine at direct address
0x0070:     00               HLT                ; Halts the CPU
0x0071:     01               NOP                ; No Operation
0x0072:     7F 63 3A         POP                ; Pop multiple 8-bit registers from stack
0x0073:     63 3A            LDXW (PC+0x3A)     ; Load direct PC offset by N address into word XW
0x0075:     09               RSR                ; return(cont=1) from Subroutine
0x0076:     91 00 BA         LDAW 00BA          ; Load direct address into byte of AW
0x0079:     14 18            BZ   (PC+0x18)     ; Branch if equal to zero to 0x18 ahead PC (0x0093)
0x007b:     01               NOP                ; No Operation
0x007c:     10 00            BL   (PC+0x00)     ; Branch if link set to 0x00 ahead PC (0x007e)
0x007e:     50 00            ADD  AW,  AW       ; Add word of two explicit registers (L + R stored in L)
0x0080:     78 66 1E         JSR  #661E         ; Jump to subroutine at literal address (not possible?)
0x0083:     02               SF                 ; Set Fault
0x0084:     5B               XAXW               ; Transfer implicit AW into XW
0x0085:     01               NOP                ; No Operation
0x0086:     66 20            JSYS               ; System call. See supplemental material.
0x0088:     00               HLT                ; Halts the CPU
0x0089:     01               NOP                ; No Operation
0x008a:     01               NOP                ; No Operation
0x008b:     66 1F            JSYS               ; System call. See supplemental material.
0x008d:     02               SF                 ; Set Fault
0x008e:     5B               XAXW               ; Transfer implicit AW into XW
0x008f:     79 00 98         JSR  0098          ; Jump to subroutine at direct address
0x0092:     00               HLT                ; Halts the CPU
0x0093:     02               SF                 ; Set Fault
0x0094:     7F 63 3A         POP                ; Pop multiple 8-bit registers from stack
0x0095:     63 3A            LDXW (PC+0x3A)     ; Load direct PC offset by N address into word XW
0x0097:     09               RSR                ; return(cont=1) from Subroutine
0x0098:     01               NOP                ; No Operation
0x0099:     66 3A            JSYS               ; System call. See supplemental material.
0x009b:     0A               RI                 ; return(cont=1) from Interrupt
0x009c:     00               HLT                ; Halts the CPU
0x009d:     AA               SALX               ; Store byte from address in XW into implicit AL
0x009e:     7F 63 09         POP                ; Pop multiple 8-bit registers from stack
0x009f:     63 09            LDXW (PC+0x09)     ; Load direct PC offset by N address into word XW
0x00a1:     D0 00 AA         LDBW #00AA         ; Load literal address into byte of BW
0x00a4:     95 41            LDAW X , 1         ; Load index mode register address into AW (view supplemental material)
0x00a6:     A5 28 03         STAL BW, 8, 0x03   ; Store AL into index mode register (view supplemental material)
0x00a9:     66 18            JSYS               ; System call. See supplemental material.
0x00ab:     83 06            LDAL (PC+0x06)     ; Load direct PC offset by N address into byte of AL
0x00ad:     15 01            BNZ  (PC+0x01)     ; Branch if not equal to zero to 0x01 ahead PC (0x00b0)
0x00af:     09               RSR                ; return(cont=1) from Subroutine
0x00b0:     66 09            JSYS               ; System call. See supplemental material.
0x00b2:     3C               SRAW               ; Shift word of implicit AW register left
0x00b3:     00               HLT                ; Halts the CPU
0x00b4:     00               HLT                ; Halts the CPU
0x00b5:     00               HLT                ; Halts the CPU
0x00b6:     00               HLT                ; Halts the CPU
0x00b7:     01               NOP                ; No Operation
0x00b8:     90 00 C8         LDAW #00C8         ; Load literal address into byte of AW
0x00bb:     00               HLT                ; Halts the CPU
0x00bc:     00               HLT                ; Halts the CPU
0x00bd:     00               HLT                ; Halts the CPU
0x00be:     03               RF                 ; Reset Fault
0x00bf:     02               SF                 ; Set Fault
0x00c0:     03               RF                 ; Reset Fault
0x00c1:     00               HLT                ; Halts the CPU
0x00c2:     00               HLT                ; Halts the CPU
0x00c3:     00               HLT                ; Halts the CPU
0x00c4:     00               HLT                ; Halts the CPU
0x00c5:     00               HLT                ; Halts the CPU
0x00c6:     00               HLT                ; Halts the CPU
0x00c7:     00               HLT                ; Halts the CPU
0x00c8:     00               HLT                ; Halts the CPU
0x00c9:     00               HLT                ; Halts the CPU
0x00ca:     00               HLT                ; Halts the CPU
0x00cb:     00               HLT                ; Halts the CPU
0x00cc:     00               HLT                ; Halts the CPU
0x00cd:     02               SF                 ; Set Fault
0x00ce:     5B               XAXW               ; Transfer implicit AW into XW
0x00cf:     01               NOP                ; No Operation
0x00d0:     8B               LALY               ; Load byte from address in YW into implicit AL
0x00d1:     39               DCAW               ; Decrement word of implicit AW register
0x00d2:     00               HLT                ; Halts the CPU
0x00d3:     14 02            BZ   (PC+0x02)     ; Branch if equal to zero to 0x02 ahead PC (0x00d7)
0x00d5:     5A               NABW               ; AND implicit AW and BW
0x00d6:     00               HLT                ; Halts the CPU
0x00d7:     00               HLT                ; Halts the CPU
0x00d8:     00               HLT                ; Halts the CPU
0x00d9:     00               HLT                ; Halts the CPU
0x00da:     00               HLT                ; Halts the CPU
0x00db:     00               HLT                ; Halts the CPU
0x00dc:     04               EI                 ; Enable Interrupt system
0x00dd:     00               HLT                ; Halts the CPU
0x00de:     00               HLT                ; Halts the CPU
0x00df:     00               HLT                ; Halts the CPU
0x00e0:     00               HLT                ; Halts the CPU
0x00e1:     00               HLT                ; Halts the CPU
0x00e2:     00               HLT                ; Halts the CPU
0x00e3:     00               HLT                ; Halts the CPU
0x00e4:     66 56            JSYS               ; System call. See supplemental material.
0x00e6:     8C               LALZ               ; Load byte from address in ZW into implicit AL
0x00e7:     00               HLT                ; Halts the CPU
0x00e8:     8B               LALY               ; Load byte from address in YW into implicit AL
0x00e9:     00               HLT                ; Halts the CPU
0x00ea:     B9               SAWB               ; Store word from address in BW into implicit AW
0x00eb:     01               NOP                ; No Operation
0x00ec:     38               INAW               ; Increment word of implicit AW register
0x00ed:     00               HLT                ; Halts the CPU
0x00ee:     00               HLT                ; Halts the CPU
0x00ef:     00               HLT                ; Halts the CPU
0x00f0:     01               NOP                ; No Operation
0x00f1:     00               HLT                ; Halts the CPU
0x00f2:     06               SL                 ; Set Link
0x00f3:     00               HLT                ; Halts the CPU
0x00f4:     0C               ELO                ; Enable Link Out
0x00f5:     00               HLT                ; Halts the CPU
0x00f6:     0F               RSYS               ; return(cont=1) from JSYS using stack
0x00f7:     00               HLT                ; Halts the CPU
0x00f8:     15 00            BNZ  (PC+0x00)     ; Branch if not equal to zero to 0x00 ahead PC (0x00fa)
0x00fa:     1D 00            BS4  (PC+0x00)     ; Branch if sense switch 4 set to zero to 0x00 ahead PC (0x00fc)
0x00fc:     28               INAL               ; Increment byte of implicit AL register
0x00fd:     00               HLT                ; Halts the CPU
0x00fe:     2D               SLAL               ; Shift byte of implicit AL register right
0x00ff:     00               HLT                ; Halts the CPU
0x0100:     2F 00            ???                ; Special 2 byte instruction. See supplemental material.
0x0102:     34 00            SRR  AW, 0         ; Shift byte of explicit register right by 1 + const. (Odd reg. on MEM)
0x0104:     37 00            RLR  AW, 0         ; Rotate byte of explicit register left by 1 + const. (Odd reg. on MEM)
0x0106:     3A               CLAW               ; Clear word of implicit AW register
0x0107:     00               HLT                ; Halts the CPU
0x0108:     41 00            SUB  AH,  AH       ; Subtract bytes of two explicit registers (L - R stored in L)
0x010a:     4B               XAXL               ; Transfer implicit AL into XL
0x010b:     00               HLT                ; Halts the CPU
0x010c:     50 00            ADD  AW,  AW       ; Add word of two explicit registers (L + R stored in L)
0x010e:     52 00            AND  AW,  AW       ; AND word of two explicit registers (L AND R stored in L)
0x0110:     54 00            ORE  AW,  AW       ; XOR word of two explicit registers (L XOR R stored in L)
0x0112:     5F               XASW               ; Transfer implicit AW into SW
0x0113:     00               HLT                ; Halts the CPU
0x0114:     64 00            LDXW [PC+0x00]     ; Load indirect PC offset by N address into word XW
0x0116:     6A 00 73         STXW [0073]        ; Store XW into indirect address
0x0119:     00               HLT                ; Halts the CPU
0x011a:     7A 00 84         JSR  [0084]        ; Jump to subroutine at indirect address
0x011d:     00               HLT                ; Halts the CPU
0x011e:     87               ???                ; Unknown. Illegal?
0x011f:     00               HLT                ; Halts the CPU
0x0120:     93 00            LDAW (PC+0x00)     ; Load direct PC offset by N address into word of AW
0x0122:     99               LAWB               ; Load word from address in BW into implicit AW
0x0123:     00               HLT                ; Halts the CPU
0x0124:     B0 00 C4         STAW 00C4          ; Store AW into PC address (PC)- <- X (Opposite 60)
0x0127:     03               RF                 ; Reset Fault
0x0128:     00               HLT                ; Halts the CPU
0x0129:     00               HLT                ; Halts the CPU
0x012a:     00               HLT                ; Halts the CPU
0x012b:     00               HLT                ; Halts the CPU
0x012c:     00               HLT                ; Halts the CPU
0x012d:     84 00            LDAL [PC+0x00]     ; Load indirect PC offset by N address into byte of AL
0x012f:     00               HLT                ; Halts the CPU