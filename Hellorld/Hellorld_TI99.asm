********************************************************************************
*                               FINAL PROGRAM                                  *
********************************************************************************

; Clear the screen
7D00 02E0 70B8      LWPI >70B8          ; Load memory area for registers
7D04 04C0           CLR R0              ; Load zero in register 0
7D06 0201 2000      LI Rl,>2000         ; Load ASCII space [>20] in left byte Rl
7D0A 0420 6024 LP   BLWP @>6024         ; Print the blank
7D0E 0580           INC R0              ; Increase the screen printing position
7D10 0280 0300      CI R0,768           ; Compare to first place beyond screen
7D14 11FA           JLT LP              ; Jump to LP if less than
7D18 0200 012A      LI R0,298           ; Load screen printing position
7D1C 0201 7D28      LI R1,TX            ; Load position of text in memory
7D1E 0202 0009      LI R2,9             ; Length of text: nine bytes
7D22 0420 6028      BLWP @>6028         ; Print text on screen
7D26 10FE           JMP$                ; Create endless loop 
7D28           TX   TEXT 'HELLORLD!'    ; Text to be displayed
7D28 48 45 4C 4C 4F 52 4C 44 21

; LWPI = Load Workspace Pointer Immediate with 70B8 (where the registers are)
; There are 16 workspace registers R0 through R15
; CLR R0 loads 0000 into R0
; LI is a Load Immediate, hexadecimal values have a '>'
; I do not understand BLWP, but it works and it's what the book told me to use
; INC is an increment (start at 0, increment one by one until we break 767)
; CI is a compare, comparing R0 with 768
; JLT is a Jump if Less Than I think?
; If R0 is less than 768 then Jump to LP which is 5 bytes back (FF-FA=5)
; LI R1,TX the TX is the memory address where the text is stored
; LI R2,9 tells it to read 9 bytes from that previous memory address
; I do not understand BLWP, but it works and it's what the book told me to use
; JMP$ sets up an infinite loop, it jumps to itself
; Finally, the ASCII text for HELLORLD!