* Transient to peek or poke a byte or word at an MMIO address by ren14500.
*
* To use, assemble, copy to @SYS.@TX019 (for example), and reboot OPSYS, then
* call the transient SVC with the same number (19 for example) as the byte
* argument after the SVC after setting A, B, and Y appropriately. E.g.:
*   LDA= X'F200'
*   LDB= X'0000'
*   SVC 5
*   DB 19
*
* On entry:
* A = address.
* BU = 0 for peek, 1 for poke.
* BL = 0 for byte, 1 for word.
* Y = word to write if BU=1 and BL=1.
* YL = byte to write if BU=1 and BL=0.
*
* On exit:
* A = word read if BU=0 and BL=1.
* AL = byte read if BU=0 and BL=0.
*
* Constants.
TRTN      EQU       1         ; Transient return.
*
* Set the program title and begin.
          TITLE     'MMIO'
ZMMIO     BEGIN     0
*
* Entrypoint.
ENTRY     XFRB      BU,BU     ; Check if peeking or poking.
          BZ        PEEK      ; If 0, peek.
*
* Poke.
          XFRB      BL,BL     ; Check if byte or word.
          BZ        POKEB     ; If 0, poke byte.
*
* Poke word.
          XFR       Y,B       ; Y -> B.
          SIO       B,A       ; Store B in MMIO address in A.
          JMP       EXIT      ; Jump relative to exit.
*
* Poke byte.
POKEB     XFR       Y,B       ; Y -> B.
          SIOB      B,A       ; Store BL in MMIO address in A.
          JMP       EXIT      ; Jump relative to exit.
*
* Peek.
PEEK      XFRB      BL,BL     ; Check if byte or word.
          BZ        PEEKB     ; If 0, peek byte.
*
* Peek word.
          LIO       A,A       ; Load word at MMIO address A to A.
          JMP       EXIT      ; Jump relative to exit.
*
* Peek byte.
PEEKB     LIOB      A,A       ; Load byte at MMIO address A to AL.
*
* Exit.
EXIT      SVC       TRTN      ; Return from transient.
          DW        -1        ; Return code.
*
* End of source. Specify the entrypoint.
          END       ENTRY

