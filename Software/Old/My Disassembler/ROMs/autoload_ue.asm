; Autoload ROM on the DSK/AUT board
; Bootstrap for CPU4 systems with Sykes tape drive or Hawk Disk Drive
; Entry point

; Check Sense Switch 3 and if set jump to EFC0(XXX bootstrap)
0xef00:     1C 03            BS3  (PC+0x03)     ; Branch if sense switch 3 set to 0x03 ahead PC (0x0005)
0xef02:     71 EF C0         JMP  EFC0          ; Jump to direct address 

; Bootstrap for XXX
0xef05:     80 01            LDAL #011D         ; Load literal address into byte of AL
0xef07:     1D 01            BS4  (PC+0x01)     ; Branch if sense switch 4 set to zero to 0x01 ahead PC (0x000a)
0xef09:     2A               CLAL               ; Clear byte of implicit AL register
0xef0a:     A1 F1 4B         STAL F14B          ; Store AL into direct address
0xef0d:     90 01 00         LDAW #0100         ; Load literal address into byte of AW
0xef10:     B1 FF F0         STAW FFF0          ; Store AW into direct address
0xef13:     A1 FF F4         STAL FFF4          ; Store AL into direct address
0xef16:     A1 FF F7         STAL FFF7          ; Store AL into direct address
0xef19:     5F               XASW               ; Transfer implicit AW into SW (Pretty sure this copies into SW as a JUMP addr.)
0xef1a:     90 E8 8F         LDAW #E88F         ; Load literal address into byte of AW
0xef1d:     B1 FF F2         STAW FFF2          ; Store AW into direct address
0xef20:     80 03            LDAL #037B         ; Load literal address into byte of AL

0xef22:     7B 06            JSR  (PC+0x06)     ; Jump to subroutine at direct PC offset by N address  (SUB1)
0xef24:     80 00            LDAL #007B         ; Load literal address into byte of AL 
0xef26:     7B 02            JSR  (PC+0x02)     ; Jump to subroutine at direct PC offset by N address  (SUB1)

0xef28:     75 A0            JMP  SW, 0         ; Jump to index mode register (Jumps to JUMP addr. set above)

; SUB1
0xef2a:     A1 F1 48         STAL F148          ; Store AL into direct address
0xef2d:     81 F1            LDAL F144          ; Load indirect address into byte of AL
0xef30:     2C               SRAL               ; Shift byte of implicit AL register left
0xef31:     15 CD            BNZ  (PC-0x33)     ; Branch if not equal to zero to 0x33 behind PC (braches to top of ROM)
0xef33:     10 F8            BL   (PC-0x08)     ; Branch if link set to 0x8 behind PC (0xef2d)
0xef35:     81 F1            LDAL F145          ; Load indirect address into byte of AL
0xef38:     C0 30            LDBL #3042         ; Load literal address into byte of BL
0xef3a:     42 31            AND  BL,  AL       ; AND bytes of two explicit registers (L AND R stored in L)
0xef3c:     49               SABL               ; Subtract implicit AL and BL
0xef3d:     15 EE            BNZ  (PC-0x12)     ; Branch if not equal to zero to 0x12 behind PC (0xef2d)
0xef3f:     09               RSR                ; Return from Subroutine


; Empty space between the two bootstraps
0xef40:     00               HLT                ; Halts the CPU
0xef41 ~ 0xefbe: 00			 HLT
0xefbf:     00               HLT                ; Halts the CPU


; Bootstrap for XXX
0xefc0:     90 F0 B0         LDAW #F0B0         ; Load literal address into byte of AW
0xefc3:     1D 03            BS4  (PC+0x03)     ; Branch if sense switch 4 set to zero to 0x03 ahead PC (0x00c8)
0xefc5:     90 F0 A0         LDAW #F0A0         ; Load literal address into byte of AW
0xefc8:     55 0C            XFR  AW,  C        ; Copy word of one explicit register into other (R into L)
0xefca:     90 00 F0         LDAW #00F0         ; Load literal address into byte of AW
0xefcd:     5F               XASW               ; Transfer implicit AW into SW
0xefce:     7B 1F            JSR  (PC+0x1F)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefd0:     4D               XABL               ; Transfer implicit AL into BL
0xefd1:     7B 1C            JSR  (PC+0x1C)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefd3:     5B               XAXW               ; Transfer implicit AW into XW
0xefd4:     4E               XAZL               ; Transfer implicit AL into ZL
0xefd5:     7B 18            JSR  (PC+0x18)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefd7:     45 16            XFR  AL,  YH       ; Copy byte of one explicit register into other (R into L)
0xefd9:     7B 14            JSR  (PC+0x14)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefdb:     4C               XAYL               ; Transfer implicit AL into YL
0xefdc:     3F               DCX                ; Decrement word of implicit X register
0xefdd:     16 06            BM   (PC+0x06)     ; Branch if minus set to 0x06 ahead PC (0x00e5)
0xefdf:     7B 0E            JSR  (PC+0x0E)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefe1:     A5 61            STAL YW, 1         ; Store AL into index mode register (view supplemental material)
0xefe3:     73 F7            JMP  (PC-0x09)     ; Jump to direct PC offset by N address  (0x00dc)
0xefe5:     7B 08            JSR  (PC+0x08)     ; Jump to subroutine at direct PC offset by N address  (0x00ef)
0xefe7:     15 E2            BNZ  (PC-0x1e)     ; Branch if not equal to zero to 0x1e behind PC (0x00cb)
0xefe9:     45 99            XFR  ZL,  ZL       ; Copy byte of one explicit register into other (R into L)
0xefeb:     15 E1            BNZ  (PC-0x1f)     ; Branch if not equal to zero to 0x1f behind PC (0x00ce)
0xefed:     75 60            JMP  YW, 0         ; Jump to index mode register (view supplemental material)

; SUB2
0xefef:     85 C8 01         LDAL C , 8, 0x01   ; Load index mode register address into AL (view supplemental material)
0xeff2:     16 D7            BM   (PC-0x29)     ; Branch if minus set to 0x29 behind PC (0x00cb)
0xeff4:     2C               SRAL               ; Shift byte of implicit AL register left
0xeff5:     11 03            BNL  (PC+0x03)     ; Branch if link not set to 0x03 ahead PC (0x00fa)
0xeff7:     A5 C8 03         STAL C , 8, 0x03   ; Store AL into index mode register (view supplemental material)
0xeffa:     2C               SRAL               ; Shift byte of implicit AL register left
0xeffb:     11 F2            BNL  (PC-0x0e)     ; Branch if link not set to 0xe behind PC (0x00ef)
0xeffd:     8E               LALC               ; Load byte from address in C into implicit AL
0xeffe:     48               AABL               ; Add implicit AL and BL
0xefff:     09               RSR                ; Return from Subroutine
0xf000:     00               HLT                ; Halts the CPU
