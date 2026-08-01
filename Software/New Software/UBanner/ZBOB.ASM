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
MXCPTYE   EQU       B'00000001'    ; .... ...1 Parity even
*
* Parity enable/disable
*
MXCPENBL  EQU       B'00000000'    ; ...0 .... Parity enable
MXCPDSBL  EQU       B'00010000'    ; ...1 .... Parity disable
*
* Data Bits (only documenting 7 or 8)
*
MXDBITS7  EQU       B'00000100'    ; .... 01... Data bits: 7
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
MXCS75    EQU       B'00100000'    ; 001. .... Baud rate 75bp/s
MXCS300   EQU       B'01000000'    ; 010. .... Baud rate 300bp/s
MXCS12    EQU       B'01100000'    ; 011. .... Baud rate 1200bp/s
MXCS24    EQU       B'10000000'    ; 100. .... Baud rate 2400bp/s
MXCS48    EQU       B'10100000'    ; 101. .... Baud rate 4800bp/s
MXCS96    EQU       B'11000000'    ; 110. .... Baud rate 9600bp/s
MXCS192   EQU       B'11100000'    ; 111. .... Baud rate 19200bp/s
*
R9800E71 EQU MXCS96+MXCPENBL+MXCPTYE+MXDBITS7+MXCSTP1 ; 9600E71
*
MMIOSTRT  EQU       X'F000'        ; lowest address of MMIO space
*
******************************************************************
** Uncommeont the appropriate line for real machine or Emulator **
******************************************************************
TRMRDYC   EQU       MXTXEM         ; Use this for Centurion
TRMRDYE   EQU       MXCTS          ; Use this for Emulator 
*
* Print the null-terminated string. Z -> string
*
PRTNULL   STAB-     S-              ; Push AL to the stack
          STBB-     S-              ; Push BL to the stack
          XFRB      YL,AL           ; YL -> AL
          STAB-     S-              ; Push YL to the stack
          LDAB=     MXTXEM          ; Set mask to check for tx buffer empty
          XAYB                      ; AL -> YL
PNLOOP    LDBB+     Z+              ; Load the next byte
          BZ        PNEND           ; If 0, we are done
PNWAIT    LDAB/     MUX0CTRL        ; AL = MUX status byte
          ANDB      YL,AL           ; Check if transmit buffer empty
          BZ        PNWAIT          ; If not empty, loop
          STBB/     MUX0DATA        ; Store the character to the MUX data
          JMP       PNLOOP          ; Go to the next character
PNEND     LDAB+     S+              ; Pop YL from the stack
          XAYB                      ; AL -> YL
          LDBB+     S+              ; Pop BL from the stack
          LDAB+     S+              ; Pop AL from the stack
          RSR                       ; Return
*
*****************************************************************************
* Simple linear congruential random number generator. Returns the next random
* number in B.
*****************************************************************************
RANDA     EQU       30303
RANDSEED  DW        7717            ; Current seed value.
RAND      LDB       RANDSEED        ; B = current seed value.
          MUL=      RANDA,B         ; B = B * random multiplier.
          INR       B               ; B = B + 1.
          STB       RANDSEED        ; Store the new seed value.
          RSR                       ; Return
*
* position top left
*
TOPLEFT   DB        X'1B'           ; Position to 
          DB        'Y'             ; TOP ...
          DB        X'20'           ; ... Left ...
          DB        X'20'           ; ... ... Corner
          DB        0               ; ... ASCII
GOTOTOP   EQU       *
          LDA=      TOPLEFT         ; A -> Hit a key message
          XFR       A,Z             ; Z = Message
          JSR/      PRTNULL         ; ... print the messsage
          RSR
*
*******************************
* hit a key - actuall rand seed
*******************************
HITAKEY   DB        X'1B'           ; Position to 
          DB        'Y'             ; TOP ...
          DB        X'20'           ; ... Left ...
          DB        X'20'           ; ... ... Corner
          DC        'HIT A KEY>'    ; DISPLAY MESSAGE
          DB        0               ; ... ASCIIZ
HITKEY    EQU       *
          LDA=      HITAKEY         ; A -> Hit a key message
          XFR       A,Z             ; Z = Message
          JSR/      PRTNULL         ; ... print the messsage
          LDAB=     MXRXDI          ; AL = Mux control value mask
          XAYB                      ; YL = AL
HK0001    EQU       * 
          LDA/      RANDSEED        ; A = Random seed.
          INR       A               ; A = A + 1
          STA/      RANDSEED        ; .. save the seed 
          LDAB/     MUX0CTRL        ; al = MUX 0 control register
          ANDB      YL,AL           ; q. byte received?
          BZ        HK0001          ; a. no .. loop until we get one.
          LDAB/     MUX0DATA        ; AL = the received byte (who cares?)
          RSR                       ; .. and return to caller
*
* Storage
*
MYRAND    DW        0               ; My random value
CLRSCRN   DW        X'0C00'         ; clear screen message
*
*
* Clear the screen
*
CLS       EQU       *
          STK       A,2             ; push A&B
          STK       Z,2             ; .. and z
          LDA=      CLRSCRN         ; A -> Message
          XFR       A,Z             ; .. so does Z.
          JSR/      PRTNULL         ; clear the screen
          POP       Z,2             ; restore z
          POP       A,2             ; .. and A&
          RSR
************************************
* Entry point
************************************      
BANNER    EQU       *               ; The program begins here
*
* Start of execution
*
          XFR=      MMIOSTRT,S      ; Stack -> Start of MMIO space
*
          LDAB=     R9800E71        ; A = 9600E71 value 
          STAB/     MUX0CTRL        ; MUX 0 Control = speed/parity/databits/stopbits
          JSR/      CLS             ; clear the screen
          JSR/      HITKEY          ; ... wait for a key & random seed
BIGLOOP   EQU       *
          JSR/      CLS             ; clear the screen
LOOPITY   EQU       *
          JSR/      GETENTRY        ; A = Next entry
          AND       A,A             ; q. any more enties?
          BZ        AGAIN           ; a. no .. Delay and start over
          JSR/      MARKPRT         ; .. else ... mark entry and print it
          JMP       LOOPITY         ; A. No .. print next one
*
AGAIN     EQU       *
          JSR/      GOTOTOP         ; Move to top left
          JSR/      CLRDONE         ; reset all entries
          JSR/      DELAY           ; wait a while
          JMP       BIGLOOP         ; .. do it again!     
*
*  Mark done and print; A -> Entry
*
MARKPRT   EQU       *
          STK       B,2             ; push B
          LDBB=     1               ; BL = 1
          STBB-     A,6             ; ... mark entry as printed
          XFR       A,Z             ; Z -> Entry to Print
          JSR/      PRTNULL         ; ... print the entry
          POP       B,2             ; Restore B
          RSR                       ; ... get outta here.
*
* Get a random entry to display; A -> Entry
*
GETENTRY  EQU       *               ; Get next entry
          STK       X,4             ; Push X and YL
          STK       B,2             ; Push B
          JSR/      RAND            ; B = Random number
          XFR       B,X             ; .. so does XAYB
          DIV=      LOLEN,X         ; x = rnd % #ents; y = rnd / #ents
          SLR       X,3             ; X = X*8 (offset)
          LDA=      LAYOUT          ; A -> Layout 
          ADD       X,A             ; A -> random layout entry
          JSR/      FINDNEXT        ; A -> Next undisplayed entry
          POP       B,2             ; Restore B
          POP       X,4             ; Restore X and Y
          RSR
*
* Find next undisplayed entry. On Entry: A-> Random Entry
*
FINDNEXT  EQU       *
          LDB=      LOLEN           ; B = Number of entries
          XFR       B,Y             ; .. Y does too!
FN0100    EQU       *               
          LDBB-     A,6             ; q. this entry done (BL = 0)?
          BNZ       FN0500          ; a. no... keep looking
          RSR                       ; .. else ... Return
*
FN0500    EQU       *
          DCR       Y,1             ; q. have we examined all entries?
          BNZ       FN0600          ; a. No ... continue to next
          LDA=      0               ; ... we are done.
          RSR                       ; return to calller
*
FN0600    EQU       *     
          ADD=      8,A             ; A -> next Entry
          XFR       A,Z             ; Z -> next entry too
          SUB=      ELAYOUT,Z       ; q. At end?
          BNZ       FN0100          ; a. no .. continue to next
          LDA=      LAYOUT          ; else .. start at TOP
          JMP       FN0100          ; .. and continue
*
* Clear layout entry done flags
*
CLRDONE   EQU       *               ; Clear all done flags
          STK       A,4             ; Push A & B
          LDA=      LAYOUT          ; A -> LAYOUT
CD0010    EQU       *
          LDBB=     0               ; BL = 0
          STBB-     A,6             ; Clear the entry
          ADD=      8,A             ; A -> next entry
          XFR       A,B             ; .. B does too
          SUB=      ELAYOUT,B       ; Q. at end of list?
          BNZ       CD0010          ; A. No .. clear next
          POP       A,4             ; Restore A&B
          RSR
*
* Delay for a while
*
DELAY     EQU       *               ; Delay random time
          LDA=      2500            ; wait several seconds
DELAY10   DLY                       ; ... 4.55 ms / wait
          DCR       A,1             ; Q. A = 0 (done wating?)
          BNZ       DELAY10         ; a. no... keep on waitin'
          RSR
*
LAYOUT EQU *
 DB X'1b'
 DB 'Y'
 DB 32
 DB 35
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 36
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 37
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 38
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 39
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 40
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 41
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 42
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 43
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 44
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 45
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 47
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 48
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 50
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 51
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 53
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 55
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 56
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 57
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 58
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 61
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 62
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 64
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 65
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 66
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 67
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 68
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 69
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 70
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 71
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 32
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 44
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 45
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 46
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 47
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 48
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 49
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 50
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 51
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 52
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 53
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 55
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 56
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 57
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 58
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 59
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 60
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 61
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 62
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 64
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 65
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 66
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 67
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 68
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 69
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 70
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 71
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 33
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 44
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 45
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 46
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 47
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 48
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 49
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 50
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 51
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 53
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 54
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 56
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 57
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 58
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 61
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 62
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 63
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 64
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 65
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 66
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 67
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 68
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 69
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 70
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 71
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 34
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 43
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 44
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 45
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 46
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 47
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 48
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 49
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 50
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 51
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 52
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 53
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 54
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 57
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 58
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 59
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 60
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 61
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 62
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 63
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 64
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 65
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 66
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 67
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 69
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 70
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 71
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 35
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 43
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 44
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 45
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 46
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 47
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 48
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 49
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 50
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 51
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 52
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 53
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 55
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 57
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 58
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 59
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 60
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 61
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 62
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 63
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 66
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 67
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 68
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 69
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 70
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 71
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 36
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 42
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 43
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 44
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 45
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 46
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 47
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 48
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 49
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 50
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 51
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 52
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 53
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 54
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 55
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 56
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 57
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 58
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 59
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 60
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 61
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 62
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 66
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 67
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 70
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 37
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 44
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 45
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 46
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 47
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 48
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 49
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 50
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 51
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 52
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 53
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 54
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 55
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 56
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 57
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 58
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 61
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 62
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 63
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 66
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 67
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 69
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 72
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 38
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 44
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 45
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 46
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 47
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 48
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 49
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 50
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 51
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 52
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 53
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 54
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 55
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 56
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 57
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 58
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 60
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 61
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 62
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 63
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 64
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 66
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 67
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 68
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 72
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 39
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 41
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 43
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 44
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 45
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 46
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 47
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 48
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 50
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 51
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 53
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 54
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 55
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 56
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 57
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 58
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 60
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 61
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 62
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 63
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 64
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 65
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 70
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 40
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 35
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 36
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 38
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 39
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 40
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 41
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 42
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 43
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 46
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 47
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 48
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 49
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 50
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 51
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 53
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 54
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 57
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 58
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 59
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 60
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 61
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 62
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 65
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 66
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 68
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 70
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 71
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 41
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 35
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 36
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 37
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 38
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 39
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 40
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 41
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 43
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 45
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 46
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 47
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 48
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 49
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 50
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 51
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 52
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 53
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 57
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 58
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 59
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 61
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 62
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 63
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 64
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 65
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 66
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 69
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 70
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 71
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 72
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 73
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 42
 DB 74
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 41
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 42
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 43
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 44
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 46
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 47
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 48
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 49
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 50
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 51
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 52
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 53
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 54
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 55
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 56
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 57
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 58
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 59
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 61
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 62
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 63
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 64
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 65
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 66
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 67
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 69
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 70
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 71
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 43
 DB 74
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 43
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 44
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 45
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 46
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 47
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 48
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 50
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 51
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 52
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 53
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 54
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 55
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 56
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 57
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 58
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 59
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 60
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 61
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 62
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 63
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 64
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 65
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 66
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 67
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 69
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 70
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 71
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 44
 DB 74
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 35
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 43
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 44
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 45
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 46
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 47
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 48
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 49
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 50
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 51
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 53
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 54
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 55
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 56
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 57
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 58
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 59
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 60
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 61
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 62
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 63
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 64
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 65
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 66
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 67
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 69
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 45
 DB 74
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 35
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 36
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 37
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 38
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 39
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 40
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 41
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 42
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 43
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 45
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 46
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 47
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 48
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 50
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 51
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 52
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 53
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 57
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 58
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 59
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 60
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 61
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 62
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 63
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 64
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 65
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 66
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 67
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 69
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 71
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 46
 DB 74
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 35
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 36
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 37
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 38
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 39
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 40
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 43
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 47
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 48
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 49
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 50
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 51
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 53
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 54
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 55
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 56
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 57
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 58
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 59
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 60
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 61
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 62
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 63
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 64
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 65
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 67
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 69
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 70
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 71
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 47
 DB 74
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 35
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 36
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 37
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 38
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 39
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 40
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 44
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 47
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 48
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 49
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 50
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 51
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 52
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 53
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 54
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 55
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 56
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 57
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 58
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 59
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 60
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 61
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 62
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 63
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 64
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 65
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 70
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 71
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 72
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 73
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 48
 DB 74
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 35
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 36
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 37
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 38
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 39
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 44
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 47
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 48
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 50
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 51
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 52
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 53
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 54
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 55
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 56
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 57
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 58
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 59
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 60
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 61
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 62
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 63
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 64
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 65
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 66
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 72
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 73
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 49
 DB 74
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 35
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 36
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 37
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 38
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 39
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 42
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 44
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 45
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 47
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 48
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 49
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 50
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 51
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 52
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 53
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 54
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 56
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 57
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 58
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 59
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 60
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 61
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 62
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 63
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 64
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 66
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 72
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 73
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 50
 DB 74
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 35
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 36
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 37
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 38
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 42
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 44
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 45
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 46
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 47
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 48
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 49
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 50
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 51
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 52
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 53
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 54
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 55
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 56
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 57
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 58
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 59
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 60
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 61
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 62
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 66
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 72
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 51
 DB 74
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 35
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 42
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 43
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 44
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 47
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 48
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 49
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 50
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 51
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 52
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 53
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 54
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 55
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 56
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 57
 DB 58 ; :
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 58
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 59
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 60
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 61
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 62
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 65
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 70
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 71
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 52
 DB 74
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 35
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 42
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 43
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 45
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 46
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 47
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 48
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 49
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 50
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 51
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 52
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 53
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 55
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 56
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 57
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 58
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 59
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 60
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 61
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 62
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 64
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 65
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 68
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 69
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 70
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 71
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 53
 DB 74
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 35
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 36
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 37
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 38
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 39
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 40
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 41
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 42
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 43
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 44
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 45
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 46
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 47
 DB 45 ; -
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 48
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 49
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 50
 DB 42 ; *
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 51
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 52
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 53
 DB 61 ; =
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 54
 DB 43 ; +
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 55
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 56
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 57
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 58
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 59
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 60
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 61
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 62
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 63
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 64
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 65
 DB 37 ; %
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 66
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 67
 DB 35 ; #
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 68
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 69
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 70
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 71
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 72
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 73
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
 DB X'1b'
 DB 'Y'
 DB 54
 DB 74
 DB 64 ; @
 DB 0
 DB 0
 DB 0
*
ELAYOUT EQU *
LOLEN EQU (*-LAYOUT)/8
*
          END       BANNER          ; --> The entry point is BANNER
