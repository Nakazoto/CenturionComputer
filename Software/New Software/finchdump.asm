* Finch Dump based on GOS by Ren14500
        TITLE   'FIDUMP'
ZFIDMP  BEGIN   X'0100'
*
* MUX constants. 
* Control address = F200 + (MUX# * 2)
* Data address = control address + 1
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address.
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address.
MUX3CTRL  EQU       X'F206'        ; Fourth MUX port data MMIO address.
MUX3DATA  EQU       X'F207'        ; Fourth MUX port control MMIO address.
MUX0CB    EQU       X'C5'          ; First MUX port at 9,600 7E1.
MUX3CB    EQU       X'F6'          ; Third MUX port at 19,200 8N1.
*
* Entry point.
ENTRY     XFR=      X'F000',S      ; Set the stack pointer to just below MMIO.
* Initialize MUX ports
          LDAB=     MUX0CB         ; Load Mux 0 Control Byte into A
          STAB/     MUX0CTRL       ; Store A into MUX0CTRL, MMIO port for MUX0
          LDAB=     MUX3CB         ; Load Mux 3 Control Byte into A
          STAB/     MUX3CTRL       ; Store A into MUX3CTRL, MMIO port for MUX3
* Print Welcome Screen
* 8D = CR, 8A = LF, 8C = Clear?
          JSR/      PRINTNULL
          DB        X'8C'
          DC        'FINCH DUMP PROGRAM'
          DW        X'8D8A'
          DB        0              ; Null terminator
*
*
*
********************************************************************************
*                               SUBROUTINES                                    *          
********************************************************************************
*
* Print the null-terminated string at X to the CRT
PRINTNULL STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
PNLOOP    LDBB+     X+             ; Load the next byte
          BZ        PNEND          ; If 0, we are done
PNWAIT    LDAB/     MUX0CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        PNWAIT         ; If not empty, loop
          STBB/     MUX0DATA       ; Store the character to the MUX data
          JMP       PNLOOP         ; Go to the next character
PNEND     LDAB+     S+             ; Pop YL from the stack
          XAYB                     ; AL -> YL
          LDBB+     S+             ; Pop BL from the stack
          LDAB+     S+             ; Pop AL from the stack
          RSR                      ; Return
*          
* Dump data out CRT3
DMPDATA   STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDX=      X'0300'        ; Start of 400 bytes of DMA'd data
          XFR=      X'0390',Z      ; Set max address for data into Z reg
DCHECK    XFR       X,Y            ; Transfer X into Y
          SUB       Z,Y            ; Subtracts Z-Y -> 0x190 - Counter
          BZ        DEND           ; Branch is zero to da end yo
          LDAB=     B'10'          ; Set mask to check for tx buffer empty
          XAYB                     ; AL -> YL
DWAIT     LDAB/     MUX3CTRL       ; AL = MUX status byte
          ANDB      YL,AL          ; Check if transmit buffer empty
          BZ        DWAIT          ; If not empty, loop
          STBB/     MUX3DATA       ; Store the character to the MUX data
          INR       X              ; Increment X
          JMP       DCHECK         ; Go to the next character
DEND      LDAB+     S+             ; Pop YL from the stack
          XAYB                     ; AL -> YL
          LDBB+     S+             ; Pop BL from the stack
          LDAB+     S+             ; Pop AL from the stack
          RSR                      ; Return
*
* End of source
          END       ENTRY         ; Set the entry point


================================================================================


*Finch DMA Stuff
* Unit select = 0001(Floppy), 0010(Finch 0), 0100(Finch 1), 1000(Finch 2)
* Disk select = 0000(Disk 0), 0001(Disk 1), 0010(Disk 2), 0011(Disk 3), etc.
* 81 = Unit Select, 82 = RTZ, 83 = Seek, 84 = Disk Select, 8A = ??
* Byte format = 81XX (Unit Select) 84XX (Disk Select) 83XX (Seek) 
          LDA=      X'FFFX'        ; Num. bytes to count for DMA (FFFF-FFFX=??)
          DMA       SCT,A          ; Load DMA Count from A word register
          LDA=      X'0400'        ; Location of bytes to read for DMA
          DMA       SAD,A          ; Tell FFC where the command bytes are
          XAY                      ; Transfer A to Y
          LDA=      X'8102'        ; 81 = Unit Select, 02 = Unit 2 (Finch 0)
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDA=      X'8400'        ; 84 = Disk Select, 00 = Disk 0
          STA+      Y+             ; Store A indexed, direct, post-incremented
          LDAB=     X'83'          ; 83 = Seek
          STAB+     Y+             ; Store AL indexed, direct, post-incremented
          LDA=      X'0000'        ; 0000 = Track 0000
          STA+      Y+             ; Store A indexed, direct, post-incremented
          
          
          LDAB=     X'8A'          ; 8A = ??
          STAB+     Y+             ; Store AL indexed, direct, post-incremented
          DMA       SAD,A          ; Store A register to DMA address register
          DMA       EAB            ; Enable DMA
          LDAB=     X'43'          ; 43 = ??
          STAB/     X'F800'        ; Store B into Address F800 (FFC register)



================================================================================

*Finch commands


          
*How the bootstrap ROM prints
          JSR   FFC92         ; =+121 [Jump to subroutine relative]
          DC    'D='          ; hex:c4bd dec:50365(-67)
          DB    X'00'         ; =0x00 =0 =NUL
*     
FFC92     LDAB/ X'F200'       ; =0xf200 =61952(-3584) ='r',NUL [Load AL direct]
          SRAB                ; [Right shift AL]
          SRAB                ; [Right shift AL]
          BNL   FFC92         ; =-7 [Branch on no link]
          LDAB+ X+            ; [Load AL indexed, direct, post-incremented]
          BNZ   PFC9E         ; =+1 [Branch if not zero]
          RSR                 ; [Return from subroutine]
*
PFC9E     STAB/ X'F201'       ; =0xf201 =61953(-3583) [Store AL direct]
          JMP   FFC92         ; =-17 [Jump relative]    

* Gecho Seek Code
M0100 81 02 83 00
M0200 90 ff fb 2f 02 90 01 00 2f 00 2f 03 2f 06 80 43 a1 f8 00 71 84 6f
G0200
MF800 (00)45
MF800 (00)

90 FF FB    LDA=    X'FFFB'     ; Load A with FFFB (DMA related MMIO?)
2F 02       DMA     SCT,A       ; Load DMA Count from A word register
90 01 00    LDA=    X'0100'     ; Load A with 0100
2F 00       DMA     SAD,A       ; [Store A register to DMA address register]
2F 03       DMA     RCT,A       ; [Read DMA count register to A register]
2F 06       DMA     EAB         ; [Enable DMA]
80 43       LDAB=   X'43'       ; Load B with 43
A1 F8 00    STAB/   X'F800'     ; Store B into Address F800 (FFC register)



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