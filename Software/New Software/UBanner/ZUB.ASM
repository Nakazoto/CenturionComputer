          TITLE     'BANNER'
TOP       BEGIN     X'100'         ; Program loads at location 0x100 
*
* MUX STUFF
*
MUX0CTRL  EQU       X'F200'        ; First MUX port control MMIO address.
MUX0DATA  EQU       X'F201'        ; First MUX port data MMIO address.
*
* MUX Status byte laytout
MXRXDI    EQU       B'00000001'    ; .... ...1 Recieve data available
MXTXEM    EQU       B'00000010'    ; .... ..1. Transmit buffer empty
MXPER     EQU       B'00000100'    ; .... .1.. Parity misatch error
MXFRER    EQU       B'00001000'    ; .... 1... Framing error
MXOVRE    EQU       B'00100000'    ; ...1 .... Receive overrun
MXCTS     EQU       B'00100000'    ; ..1. .... Clear to send 
*
* Parity
*
MXCPTYO   EQU       B'00000000'    ; .... ...0 Parity odd
MXCPTYE   EQU       B'00000000'    ; .... ...1 Parity even
MXCEPTY   EQU       B'00000000'    ; ...0 .... Parity enabled
MXCDPTY   EQU       B'00010000'    ; ...1 .... Parity disabled
*
* Data Bits (only documenting 7 or 8)
*
MXDBITS7  EQU       B'00001000'    ; .... 1... Data bits: 7
MXDBITS8  EQU       B'00001100'    ; .... 11.. Data bits: 8
*
* Stop Bits
*
MXCSTP1   EQU       B'00000000'    ; .... ..0. Stop bits: 1
MXCSTP2   EQU       B'00000010'    ; .... ..1. Stop bits: 2
* 
* Speeds
*
MXC
MXCS75    EQU       B'00100010'    ; 001. .... Baud rate 75bp/s
MXCS300   EQU       B'01000010'    ; 010. .... Baud rate 75bp/s
MXCS12    EQU       B'01100010'    ; 011. .... Baud rate 75bp/s
MXCS24    EQU       B'10000010'    ; 100. .... Baud rate 75bp/s
MXCS48    EQU       B'10100010'    ; 101. .... Baud rate 75bp/s
MXCS96    EQU       B'11000010'    ; 110. .... Baud rate 75bp/s
MXCS192   EQU       B'11100010'    ; 111. .... Baud rate 75bp/s
*
R9800E71  EQU	    MXCs96+MXCBITS7+MXDPTY+MSCPTYE+MXCSTP1 ; 9600 E 7 1
*
MMIOSTRT  EQU       X'F000'        ; lowest address of MMIO space
*
******************************************************************
** Uncommeont the appropriate line for real machine or Emulator **
******************************************************************
*TRMRDY    EQU       MXTXEM         ; Use this for real machine (Transmit Buffer Empty
TRMRDY    EQU       MXCTS          ; Use this for Emulator (Clear To Send)
*
* Print the null-terminated string at X to the CRT
PRINTNULL STAB-     S-             ; Push AL to the stack
          STBB-     S-             ; Push BL to the stack
          XFRB      YL,AL          ; YL -> AL
          STAB-     S-             ; Push YL to the stack
          LDAB=     MXTXEM         ; Set mask to check for tx buffer empty
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
	 
BANNER    EQU       *              ; The program begins here
*
* Start of execution
*
          XFR=      MMIOX

          END       BANNER    ; --> The entry point is BANNER
