 TITLE 'CMD and Finch basic Diag tests'
* this is a relocatable diag ROM
* disassembly was done with base 9800
R4ENT   EQU *
DLED2ON EQU X'F10A'
DLED2OFF EQU X'F10B'
DLED3ON EQU X'F10C'
* Test entrypoints
        DW    CMDMEMT-R4ENT     02CE -> 9ace
        DC    '01133 CMD AUX MEMORY TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    CMDSEEKT-R4ENT    03D9 -> 9bd9
        DC    '01133 CMD SEEK TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    CMDREADT-R4ENT    049D -> 9c9d
        DC    '01133 CMD READ TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    FCHMEMT-R4ENT     02D9 -> 9ad9
        DC    'FINCH AUX MEMORY TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    FCHSEEKT-R4ENT    053C -> 9d3c
        DC    'FINCH SEEK TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    FCHREADT-R4ENT    05FF -> 9dff
        DC    'FINCH READ TEST'
        DW    X'8D8A'    CR,LF
        DB    0          NUL
        DW    R4ROMT-R4ENT      069E -> 9e9e
        DC    'ROM SELF TEST'
        DW    X'8D8A'    CR,LF
        DW    X'8A00'    LF,NUL
*
        DW    0          EOL
*
SHOWSTR LDAB+ X+       98a5 load next char
        BNZ   SHOWCHR  98a7 output if not nul
        RSR            98a9 Return
*
SHOWCHR JSR   PUTCHAR  98aa output char
        JMP   SHOWSTR  98ac loop
PUTCHAR LDBB/ X'F200'  98ae read mux status in BL
        SRRB  BL       98b1 shift tx bit
        SRRB  BL       98b3
        BNL   PUTCHAR  98b5 loop while tx full
        STAB/ X'F201'  98b7 write the char
        RSR            98ba return
*
GETCHAR LDAB/ X'F200'  98bb read MUX status
        SRAB           98be check receive
        BNL   GETCHAR  98bf loop until input
        LDAB/ X'F201'  98c1 get the char
        RSR            98c4 return
*
PUTHEXW STAB- S-       98c5 [Store AL indexed, pre-decremented, direct]
        XFRB  AU,AL    98c7 [Transfer AU to AL]
        JSR   PUTHEXB  98c9 =+5 [Jump to subroutine relative]
        LDAB+ S+       98cb [Load AL indexed, direct, post-incremented]
        JSR   PUTHEXB  98cd =+1 [Jump to subroutine relative]
        RSR            98cf [Return from subroutine]
*
* Function PUTHEXB
*
PUTHEXB STAB- S-       98d0 stack AL
        LDBB= X'F0'    98d2 load a mask
        ANDB  BL,AL    98d4 mask high nibble
        RL             98d6 logic right shift AL by 4
        RRRB  AL       98d7 to move high nibble to low
        SRAB           98d9
        SRAB           98da
        SRAB           98db
        LDBB= X'B0'    98dc BL='0'
        ADDB  BL,AL    98de make it a digit
        LDBB= X'B9'    98e0 BL='9'
        SABB           98e2 test if it's over '9'
        BLE   PHEX@NL  98e3 send it if not
        LDBB= X'07'    98e5 add 7 to make it a hex letter
        ADDB  BL,AL    98e7
PHEX@NL JSR   PUTCHAR  98e9 send the digit
        LDAB+ S+       98eb pop the value from the stack
        LDBB= X'0F'    98ed mask the low nibble
        ANDB  BL,AL    98ef
        LDBB= X'B0'    98f1 ='0' make it a digit
        ADDB  BL,AL    98f3
        LDBB= X'B9'    98f5 test if over '9'
        SABB           98f7
        BLE   PHEX@NU  98f8 if not, send it
        LDBB= X'07'    98fa else add 7
        ADDB  BL,AL    98fc to make it a hex letter
PHEX@NU JSR   PUTCHAR  98fe now send it
        RSR            9900 done
*
TESTRUN STAB/ DLED2ON      9901 signal testing
        LDAB/ X'F200'      9904 read MUX status
        SRAB               9907 check receive
        BNL   TESTLOOP     9908 continue test
        LDAB/ X'F201'      990a read MUX char
        LDBB= X'80'        990d set high bit on it
        ORIB  BL,AL        990f
        LDBB= X'83'        9911 load BL with Control-C
        SABB               9913 compare
        BNZ   TESTLOOP     9914 continue if not
        LDAB/ FAILFLG      9916 check to see if we failed
        BZ    EXITOK       9919 okay?
        JSR$  I>SHOWSTR    991b show string
        DW    X'8D8A'      991e CRLF
        DC    '*** FAIL ***'
        DB    0
        STAB/ DLED2OFF     992d signal not testing
        STAB/ DLED3ON      9930 signal fail
ASKSPACE JSR$ I>SHOWSTR    9933 show string
        DW    X'8D8A'    CRLF
        DC    'PRESS SPACE'
        DB    X'87'      BEL
        DW    X'8D8A'    CRLF
        DB    0
        JSR$  I>GETCHAR    9947 wait for any char
        JMP$  I>MENU       994a back to menu
EXITOK  JSR$  I>SHOWSTR    994d show string
        DW    X'8D8A'    CRLF
        DC    '*** PASS ***'
        DB    0
        JMP   ASKSPACE     995f wait for user
TESTLOOP LDA= X'C000'      9961 reset stack
        XAS                9964
        LDA/  R4ZBASE      9965 reset base address
        XAZ                9968 in Z
        LDA+  X+           9969 read inline word
        ADD   Z,A          996b [Z + A -> A] add to base
        JMP+  A            996d Jump to it
*
SHOWEXIT JSR$  I>SHOWSTR  996f =0x0112
        DW    X'8D8A'    CRLF
        DC    '(CONTROL-C TO EXIT)'
        DW    X'8D8A'    CRLF
        DB    0
        RSR                998a Return
*
* Setup all entry points this rom uses
* takes device base address as a parameter
*
R4INITV CLA                    998b Clear A
        STA/  FAILFLG          998c =0x0108 assume pass by default
* relocate all the entry points and save them in system RAM
        LDA=  WAITIO-R4ENT     998f =0x01ee
        ADD   Z,A              9992 A -> 99ee
        STA/  I>WAITIO         9994 =0x0118
        LDA=  PUTHEXB-R4ENT    9997 =0x00d0
        ADD   Z,A              999a A -> 98d0
        STA/  I>PUTHEXB        999c =0x010a
        LDA=  WAITFIN-R4ENT    999f =0x0291
        ADD   Z,A              99a2 A -> 9a91
        STA/  I>WAITFIN        99a4
        LDA=  SHOWEXIT-R4ENT   99a7 =0x016f
        ADD   Z,A              99aa A -> 996f
        STA/  I>SHOWEXIT       99ac
        LDA=  GETCHAR-R4ENT    99af =0x00bb
        ADD   Z,A              99b2 A -> 98bb
        STA/  I>GETCHAR        99b4
        LDA=  SHOWSTR-R4ENT    99b7 =0x0a5
        ADD   Z,A              99ba A -> 98a5
        STA/  I>SHOWSTR        99bc =0x0112
        LDA=  PUTHEXW-R4ENT    99bf =0x00c5
        ADD   Z,A              99c2 A -> 98c5
        STA/  I>PUTHEXW        99c4 =0x0110
        LDA=  TESTRUN-R4ENT    99c7 =0x0101
        ADD   Z,A              99ca A -> 9901 begin test and enter at X
        STA/  I>TESTRUN        99cc
        LDA=  ASKSPACE-R4ENT   99cf =0x0133
        ADD   Z,A              99d2 A -> 9933
        STA/  I>ASKSPC         99d4
        XFR   Z,A              99d7 base in Z to A
        STA/  R4ZBASE          99d9 save our base address
        LDA+  X+               99dc load device address
        STA/  I>IODATA         99de command and data address -> f800/f808
        INA                    99e1 status comes after
        STA/  I>IOSTATUS       99e2 status address -> f801/f809
        XFR   X,A              99e5 save return in A
        LDX+  S+               99e7 pop exit point
        STX/  I>MENU           99e9 =0x0100 save the exit point
        JMP+  A                99ec return to caller
*
WAITIO  JSR$  I>WAITFIN    99ee wait for FIN to clear
        STX-  S-           99f1 stack X
        LDX=  1000         99f3 load X with timeout
WAITBSY LDAB$ I>IOSTATUS   99f6 -> f801/f809 get status
        LDBB= B'00001000'  99f9 mask the busy flag
        NABB               99fb
        BZ    NOTBUSY      99fc exit loop when busy clears
        DLY                99fe Delay 4.55 ms
        DCX                99ff Decrement X
        BNZ   WAITBSY      9a00 loop if not timed out
        JSR$  I>SHOWSTR    9a02 show the string
        DC    '*** BUSY DID NOT CLEAR ***'
        DB    0
        STAB/ DLED2OFF     9a20 signal end of test
        STAB/ DLED3ON      9a23 signal fail
        JMP$  I>ASKSPC     9a26 back to menu
NOTBUSY LDX=  1000         9a29 Load X with timeout
WAITOUT EQU *
* this loop is broken, it does not re-read the status
* LDAB$ I>IOSTATUS
* should have load status here
        SRAB               9a2c shift FOut
        BL    FOUTOK       9a2d exit loop when set
        DLY                9a2f wait
        DCX                9a30 Decrement X
        BNZ   WAITOUT      9a31 loop if not timed out
        JSR$  I>SHOWSTR    9a33 else show error
        DC    '*** FOUT NEVER CAME ON ***'
        DB    0
        STAB/ DLED2OFF     9a51 signal end of test
        STAB/ DLED3ON      9a54 signal fail
        JMP$  I>ASKSPC     9a57 back to menu
FOUTOK  RF                ;9a5a Reset fault
        LDAB$ I>IODATA     9a5b 0114 -> f800/f808 read response
        BNZ   SHOWERR      9a5e branch if error
        LDX+  S+           9a60 pop return address
        RSR                9a62 return to it
*
SHOWERR STAB- S-           9a63 stack the error code
        JSR$  I>SHOWSTR
        DC    '*** '
        DB    0
        LDAB+ S+           pop error code from stack
        JSR$  I>PUTHEXB    show the error code
        JSR$  I>SHOWSTR
        DC    ' ERROR ***'
        DB    X'8D8A'   CRLF
        DW    0
        LDAB= 1          mark the test as failed
        STAB/ FAILFLG
        STAB/ DLED2OFF   signel not testing
        STAB/ DLED3ON    signal failure
        LDX+  S+         pop the return address
        SF               ; Set fault
        RSR              return
*
WAITFIN STX-  S-           9a91 stack X
        DLY                9a93 Delay 4.55 ms
        LDX=  1000         9a94 Load X with timeout
FINLOOP LDAB$ I>IOSTATUS   9a97 =0x0116 -> f801/f809 read status
        SRAB               9a9a shift FIN to link
        SRAB               9a9b
        BNL   FINOK        9a9c exit loop if it clears
        DLY                9a9e wait
        DCX                9a9f Decrement X
        BNZ   FINLOOP      9aa0 loop if not timed out
        JSR$  I>SHOWSTR    9aa2 =0x0112
        DC    '*** FIN DID NOT GO OFF ***'
        DW    X'8D8A'      CR LF
        DB    0
        STAB/ DLED2OFF     9ac2 signal not testing
        STAB/ DLED3ON      9ac5 signal failure
        JMP$  I>ASKSPC     9ac8 back to menu
FINOK   LDX+  S+           9acb pop return address
        RSR                9acd return
*
CMDMEMT LDA=  R4INITV-R4ENT 9ace =0x018b offset of init routine
        ADD   Z,A           9ad1 get ROM address [Z + A -> A]
        JSR+  A             9ad3 initialize test
        DW    X'F808'       9ad5 card base address: CMD
        JMP   MEMTST        9ad7 start test for CMD
FCHMEMT LDA=  R4INITV-R4ENT 9ad9 =0x018b offset of init routine
        ADD   Z,A           9adc get ROM address [Z + A -> A]
        JSR+  A             9ade initialize test
        DW    X'F800'       9ae0 card base address: FFC
* This test works the same on both cards
MEMTST  JSR$  I>SHOWEXIT    9ae2 =0x0106 show Control-C message
MEMTLP  CLR   Y             9ae5 clear Y
        LDX=  X'0F00'       9ae7 load X with count =0x0f00 =3840
        XFR   Y,A           9aea set A
        LDB=  X'011C'       9aec buffer at =0x011c
MEM@STB STAB+ B+            9aef write a pattern byte
        INAB                9af1 count pattern byte up by 3
        INAB                9af2
        INAB                9af3
        DCX                 9af4 remaining bytes
        BNZ   MEM@STB       9af5 loop until filled
        LDA=  X'FFFF'-X'0F00' 9af7 =0xf0ff(-3841)
        DMA   SCT,A         9afa Set DMA count
        LDA=  X'011C'       9afc buffer at =0x011c
        DMA   SAD,A         9aff set DMA address
        DMA   SDV,3         9b01 Set DMA device 3
        DMA   EAB           9b03 Enable DMA
        LDAB= X'46'         9b05 command: DMA system RAM to card RAM
        STAB$ I>IODATA      9b07 0114 -> f800/f808
        JSR$  I>WAITFIN     9b0a =0x010c wait for write
        LDAB= X'01'         9b0d target address 0100 high byte
        STAB$ I>IODATA      9b0f 0114 -> f800/f808
        JSR$  I>WAITFIN     9b12 =0x010c wait for write
        CLAB                9b15 target address 0100 low byte
        STAB$ I>IODATA      9b16 0114 -> f800/f808
        JSR$  I>WAITFIN     9b19 =0x010c wait for write
        LDAB= X'0F'         9b1c target length 0F00 high byte
        STAB$ I>IODATA      9b1e 0114 -> f800/f808
        JSR$  I>WAITFIN     9b21 =0x010c wait for write
        CLAB                9b24 target length 0F00 low byte
        STAB$ I>IODATA      9b25 0114 -> f800/f808
        JSR$  I>WAITIO      9b28 wait for command
        LDX=  X'0F00'       9b2b load count in X =0x0f00 =3840
        CLA                 9b2e Clear A
        LDB=  X'011C'       9b2f point B at buffer =0x011c
MEM@ZB  STAB+ B+            9b32 fill buffer with zero
        DCX                 9b34 count down
        BNZ   MEM@ZB        9b35 loop until filled
        LDA=  X'FFFF'-X'0F00' 9b37 =0xf0ff(-3841)
        DMA   SCT,A         9b3a set DMA count
        LDA=  X'011C'       9b3c use buffer =0x011c
        DMA   SAD,A         9b3f set DMA addres
        DMA   SDV,3         9b41 Set DMA device 3
        DMA   EAB           9b43 Enable DMA
        LDAB= X'47'         9b45 command: DMA card RAM to system RAM
        STAB$ I>IODATA      9b47 0114 -> f800/f808
        JSR$  I>WAITFIN     9b4a =0x010c wait write
        LDAB= X'01'         9b4d target high byte
        STAB$ I>IODATA      9b4f 0114 -> f800/f808
        JSR$  I>WAITFIN     9b52 =0x010c wait write
        CLAB                9b55 target low byte
        STAB$ I>IODATA      9b56 0114 -> f800/f808
        JSR$  I>WAITFIN     9b59 =0x010c wait write
        LDAB= X'0F'         9b5c target length high byte
        STAB$ I>IODATA      9b5e 0114 -> f800/f808
        JSR$  I>WAITFIN     9b61 =0x010c wait write
        CLAB                9b64 target length low byte
        STAB$ I>IODATA      9b65 0114 -> f800/f808
        JSR$  I>WAITIO      9b68 wait for command to complete
        STA-  S-            9b6b stack A
        LDX=  X'0F00'       9b6d load X with count =0x0f00 =3840
        LDB=  X'011C'       9b70 point B at buffer =0x011c
        XFR   Y,A           9b73 copy Y pattern to AL
        XFRB  AL,AU         9b75 copy AL to AU
MEM@TSB LDAB+ B+            9b77 load AL from buffer
        STA+  S             9b79 store current test at S
        SUBB  AU,AL         9b7a compare expected with buffer
        BNZ   MEM@EXP       9b7c branch on mismatch
        INRB  AU            9b7e increment expected by 3
        INRB  AU            9b80
        INRB  AU            9b82
        DCX                 9b84 Decrement remaining count
        BNZ   MEM@TSB       9b85 loop until buffer is checked
        LDA+  S+            9b87 pop the save space
        INRB  YL            9b89 Increment pattern in YL
        JSR$  I>TESTRUN     9b8b rerun the test
        DW    MEMTLP-R4ENT  9b8e =0x02E5 -> 9ae5
*
MEM@EXP STAB/ DLED2OFF      9b90 clear pass light
        STAB/ DLED3ON       9b93 signal failure
        STB-  S-            9b96 stack B (buffer address)
        JSR$  I>SHOWSTR     9b98 =0x0112
        DC    '*** ERROR, ADDR='
        DB    0
        LDA+  S+            9bac pop buffer address into A
        DCA                 9bae off by one
        JSR$  I>PUTHEXW     9baf =0x0110 show address as hex
        JSR$  I>SHOWSTR     9bb2 =0x0112
        DC    ' EXP='
        DB    0
        LDAB+ S+            9bbb pop expectation
        JSR$  I>PUTHEXB     9bbd =0x010a show as hex
        JSR$  I>SHOWSTR     9bc0 =0x0112
        DC    ' ACT='
        DB    0
        LDAB+ S+            9bc9 pop actual byte read
        JSR$  I>PUTHEXB     9bcb =0x010a show it as hex
        JSR$  I>SHOWSTR     9bce =0x0112
        DC    ' ***'
        DB    0
        JMP$  I>ASKSPC      9bd6 back to menu
*
CMDSEEKT LDA=  R4INITV-R4ENT  9bd9 =0x018b get offset to init routine
        ADD   Z,A          9bdc get address [Z + A -> A]
        JSR+  A            9bde initialize
        DW    X'F808'      9be0 card base address
        JSR$  I>SHOWEXIT   9be2 =0x0106 show control-c message
CMDSEEKL LDB=  CMSADDR     9be5 =0x414d build command with B
        LDA=  X'8100'      9be8 select unit zero
        STA+  B+           9beb
        LDA=  X'82FF'      9bed RTZ, END Command
        STA+  B            9bf0
        LDA=  X'FFFF'-4    9bf1 =0xfffb (-5)
        DMA   SCT,A        9bf4 setup DMA count
        LDA=  CMSADDR      9bf6 get command buffer
        DMA   SAD,A        9bf9 set DMA address
        DMA   SDV,3        9bfb Set DMA device 3
        DMA   EAB          9bfd Enable DMA
        LDAB= X'43'        9bff command: DMA command string
        STAB$ I>IODATA     9c01 0114 -> f800/f808
        JSR$  I>WAITIO     9c04 wait for command
        BNF   CSK@RTZ      9c07 continue if no fault
CSK@FAIL STAB/ DLED2OFF    9c09 clear pass light
        STAB/ DLED3ON      9c0c signal failure
        JMP$  I>ASKSPC     9c0f back to menu
CSK@RTZ LDAB= X'45'        9c12 command: execute command string
        STAB$ I>IODATA     9c14 0114 -> f800/f808
        JSR$  I>WAITIO     9c17 wait for command
        BF    CSK@FAIL     9c1a Exit on fault
        LDB=  CMSDISK      9c1c point B at =0x414f, after select
        LDA=  X'8400'      9c1f [ select platter 0 ]
        STA+  B+           9c22
        LDAB= X'83'        9c24 [ seek to track ]
        STAB+ B+           9c26
        CLA                9c28 track zero
        STA+  B+           9c29
        DCA                9c2b make A = -1 X'FFFF'
        STAB+ B            9c2c store X'FF' for end of command
        INA                9c2d make A = 1
        INA                9c2e
        STA/  TESTDIR      9c2f =0x41b1 set direction to forward
CSK@RUN LDA=  CMSADDR      9c32 load command address =0x414d
        DMA   SAD,A        9c35 set DMA address
        LDA=  X'FFFF'-8    9c37 =0xfff7(-9) buffer size
        DMA   SCT,A        9c3a set DMA count
        DMA   SDV,3        9c3c Set DMA device 3
        DMA   EAB          9c3e Enable DMA
        LDAB= X'43'        9c40 command: DMA command string
        STAB$ I>IODATA     9c42 0114 -> f800/f808
        JSR$  I>WAITIO     9c45 wait for command
        BF    CSK@FAIL     9c48 exit on fault
        LDAB= X'45'        9c4a command: execute command string
        STAB$ I>IODATA     9c4c 0114 -> f800/f808
        JSR$  I>WAITIO     9c4f wait for command
        BNF   CSK@NXT      9c52 continue forward if no fault
        JSR$  I>SHOWSTR    9c54 =0x0112
        DC    'TRACK='
        DB    0
        LDA/  CMSTRACK     9c5e =0x4152 load current track
        JSR$  I>PUTHEXW    9c61 =0x0110 show track as hex
        JSR$  I>SHOWSTR    9c64 =0x0112 write newline
        DW    X'8D8A'      9c67 CRLF
        DB    0
        STAB/ DLED2OFF     9c6a clear pass light
        STAB/ DLED3ON      9c6d signal failure
CSK@NXT LDA/  TESTDIR      9c70 =0x41b1 load direction
        BM    CSK@REV      9c73 branch when minus
        LDB/  CMSTRACK     9c75 =0x4152 load track number
        ADD   B,A          9c78 add direction to track
        STA/  CMSTRACK     9c7a =0x4152 store new track number
        LDB=  822          9c7d ending track number
        SAB                9c80 compare
        BNZ   CSK@RUN      9c81 loop until end track
        CLA                9c83 load A with -1
        DCA                9c84
        STA/  TESTDIR      9c85 =0x41b1 store direction
        LDAB= X'10'        9c88 switch unit number for the return
        STAB/ CMSUNIT      9c8a =0x4150
        JMP   CSK@RUN      9c8d inner test loop
CSK@REV LDA/  CMSTRACK     9c8f =0x4152 load track
        DCA                9c92 Decrement track
        STA/  CMSTRACK     9c93 =0x4152 store new track
        BP    CSK@RUN      9c96 loop until track underflows zero
        JSR$  I>TESTRUN    9c98 rerun the test or exit
        DW    CMDSEEKL-R4ENT   9c9b =0x03e5 -> 9be5
*
CMDREADT LDA=  R4INITV-R4ENT  9c9d =0x018b offset to init routine
        ADD   Z,A          9ca0 get ROM address [Z + A -> A]
        JSR+  A            9ca2 initialize test
        DW    X'F808'      9ca4 device: CMD card
        JSR$  I>SHOWEXIT   9ca6 =0x0106 show control-C message
CMDREADL LDA=  CMSADDR     9ca9 build command at =0x414d
        XAY                9cac point Y at buffer
        LDA=  X'8100'      9cad select device 0
        STA+  Y+           9cb0
        LDA=  X'8400'      9cb2 select disk 0
        STA+  Y+           9cb5
        LDAB= X'83'        9cb7 seek track
        STAB+ Y+           9cb9
        CLA                9cbb start at track zero
        STA+  Y+           9cbc
        LDAB= X'85'        9cbe read sectors
        STAB+ Y+           9cc0
        LDB=  X'1000'      9cc2 16 sectors, start at sector 0
CRD@SCL STBB+ Y+           9cc5 store sector number
        LDA=  400          9cc7 length =400 bytes
        STA+  Y+           9cca store length
        INRB  BL           9ccc Increment sector number
        DCRB  BU           9cce Decrement sectors remaining
        BNZ   CRD@SCL      9cd0 while more to write
        LDAB= X'FF'        9cd2 write end of command
        STAB+ Y            9cd4
CRD@RUN LDA=  X'FFFF'-60   9cd5 =0xffc3(-61) length of command
        DMA   SCT,A        9cd8 set DMA count
        LDA=  CMSADDR      9cda start of buffer =0x414d
        DMA   SAD,A        9cdd set DMA address
        DMA   SDV,3        9cdf Set DMA device 3
        DMA   EAB          9ce1 Enable DMA
        LDAB= X'43'        9ce3 command: DMA command string
        STAB$ I>IODATA     9ce5 0114 -> f800/f808
        JSR$  I>WAITIO     9ce8 wait for command
        BNF   CRD@OK       9ceb continue if no fault
        STAB/ DLED2OFF     9ced clear pass light
        STAB/ DLED3ON      9cf0 signal failure
        JMP$  I>ASKSPC     9cf3 back to menu
CRD@OK  LDA=  X'FFFF'-(400*16)   9cf6 =0xe6ff (-6401)
        DMA   SCT,A        9cf9 set DMA count
        LDA=  X'011C'      9cfb use track buffer at =0x011c
        DMA   SAD,A        9cfe set DMA address
        DMA   SDV,3        9d00 Set DMA device 3
        DMA   EAB          9d02 Enable DMA
        LDAB= X'45'        9d04 command: execute command string
        STAB$ I>IODATA     9d06 0114 -> f800/f808
        JSR$  I>WAITIO     9d09 wait for command
        BNF   CRD@NXT      9d0c continue if no fault
        JSR$  I>SHOWSTR    9d0e
        DC    'TRACK='
        DB    0
        LDA/  CMSTRACK     9d18 =0x4152 get track number
        JSR$  I>PUTHEXW    9d1b =0x0110 show track in hex
        JSR$  I>SHOWSTR    9d1e =0x0112 write newline
        DW    X'8D8A'    CRLF
        DB    0
CRD@NXT LDA/  CMSTRACK        9d24 =0x4152 get track number
        BNZ   CRD@TNZ         9d27 skip 1 if not zero
        INA                   9d29 track 0 to track 1
CRD@TNZ SLA                   9d2a exponential increments
        STA/  CMSTRACK        9d2b =0x4152 save track
        LDB=  822             9d2e check against max track
        SAB                   9d31 compare
        BLE   CRD@RUN         9d32 =-95 [Branch if less than or equal to zero]
        STAB/ DLED2ON         9d34 signal test pass
        JSR$  I>TESTRUN       9d37 check input/rerun test
        DW    CMDREADL-R4ENT  9d3a =0x04a9 -> 9ca9
*
FCHSEEKT LDA=  R4INITV-R4ENT  9d3c =0x018b offset of init routine
        ADD   Z,A          9d3f get ROM address [Z + A -> A]
        JSR+  A            9d41 initialize test
        DW    X'F800'      9d43 device: FFC
        JSR$  I>SHOWEXIT   9d45 =0x0106 show control-C message
FCHSEEKL LDB=  CMSADDR     9d48 =0x414d point B at start of buffer
* building command string with B
        LDA=  X'8102'      9d4b select unit 2, first Finch
        STA+  B+           9d4e
        LDA=  X'8400'      9d50 use platter zero
        STA+  B+           9d53
        LDA=  X'82FF'      9d55 seek rtz
        STA+  B            9d58
        LDA=  X'FFFF'-6    9d59 =0xfff9 (-7)
        DMA   SCT,A        9d5c setup DMA count
        LDA=  CMSADDR      9d5e get command buffer
        DMA   SAD,A        9d61 set DMA address
        DMA   SDV,3        9d63 Set DMA device 3
        DMA   EAB          9d65 Enable DMA
        LDAB= X'43'        9d67 command: DMA command string
        STAB$ I>IODATA     9d69 0114 -> f800/f808
        JSR$  I>WAITIO     9d6c wait for command
        BNF   FSK@RTZ      9d6f continue if no fault
FSK@FAIL STAB/ DLED2OFF    9d71 clear pass light
        STAB/ DLED3ON      9d74 signal failure
        JMP$  I>ASKSPC     9d77 back to menu
FSK@RTZ LDAB= X'45'        9d7a command: execute command string
        STAB$ I>IODATA     9d7c 0114 -> f800/f808
        JSR$  I>WAITIO     9d7f wait for command
        BF    FSK@FAIL     9d82 exit on fault
        LDB=  CMSDISK      9d84 rebuild command with B at 0x414d +2 =0x414f
        LDA=  X'8400'      9d87 [ platter select 0 ]
        STA+  B+           9d8a
        LDAB= X'83'        9d8c [ seek track ]
        STAB+ B+           9d8e
        CLA                9d90 start at track zero
        STA+  B+           9d91 [ DW track number ]
        DCA                9d93 A = -1
        STAB+ B            9d94 [ X'FF' END ]
        INA                9d95
        INA                9d96 A = 1
        STA/  TESTDIR      9d97 =0x41b1 set direction: forward
FSK@RUN LDA=  CMSADDR      9d9a load command buffer address =0x414d
        DMA   SAD,A        9d9d set DMA address
        LDA=  X'FFFF'-8    9d9f =0xfff7(-9) load count
        DMA   SCT,A        9da2 setup DMA count
        DMA   SDV,3        9da4 Set DMA device 3
        DMA   EAB          9da6 Enable DMA
        LDAB= X'43'        9da8 command: DMA command string
        STAB$ I>IODATA     9daa 0114 -> f800/f808
        JSR$  I>WAITIO     9dad wait for command
        BF    FSK@FAIL     9db0 branch on fault
        LDAB= X'45'        9db2 command: execute command string
        STAB$ I>IODATA     9db4 0114 -> f800/f808
        JSR$  I>WAITIO     9db7 wait for command
        BNF   FSK@NXT      9dba branch if no fault
        JSR$  I>SHOWSTR    9dbc
        DC    'TRACK='
        DB    0
        LDA/  CMSTRACK     9dc6 get track number
        JSR$  I>PUTHEXW    9dc9 show track in hex
        JSR$  I>SHOWSTR    9dcc put newline
        DW    X'8D8A'     CR LF
        DB    0
        STAB/ DLED2OFF     9dd2 clear pass light
        STAB/ DLED3ON      9dd5 signal failure
FSK@NXT LDA/  TESTDIR      9dd8 =0x41b1 load direction
        BM    FSK@REV      9ddb branch when minus
        LDA/  CMSTRACK     9ddd =0x4152 current track
        INA                9de0 Increment
        STA/  CMSTRACK     9de1 =0x4152 store next track
        LDB=  604          9de4 max tracks
        SAB                9de7 compare with current [A - B -> B]
        BNZ   FSK@RUN      9de8 loop until we get there
        CLA                9dea set A = -1
        DCA                9deb
        STA/  TESTDIR      9dec =0x41b1 store for reverse seeks
        JMP   FSK@RUN      9def run it back
FSK@REV LDA/  CMSTRACK     9df1 =0x4152 load track
        DCA                9df4 Decrement it
        STA/  CMSTRACK     9df5 =0x4152 store it back
* seeking backwards, finishes after track zero
        BP    FSK@RUN      9df8 loop while positive track number
        JSR$  I>TESTRUN    9dfa =0x0104 check for Control-C else rerun test
        DW    FCHSEEKL-R4ENT   9dfd =0x0548 -> 9d48
*
* command string offsets
CMSADDR  EQU X'414d'
CMSDISK  EQU CMSADDR+2    -> 414f command disk number
CMSUNIT  EQU CMSADDR+3    -> 4150 unit number byte
CMSTRACK EQU CMSADDR+5    -> 4152 track number word
TESTDIR  EQU CMSADDR+64   -> 41b1 direction save
*
FCHREADT LDA=  R4INITV-R4ENT   9dff =0x018b load the offset
        ADD   Z,A          9e02 get address -> 998b R4INITV
        JSR+  A            9e04 call the init function
        DW    X'F800'      9e06 FFC base
        JSR$  I>SHOWEXIT   9e08 back to menu
FCHREADL LDA=  CMSADDR     9e0b build command string at 0x414d
        XAY                9e0e point at it with Y
        LDA=  X'8102'      9e0f =0x8102 first Finch device
        STA+  Y+           9e12
        LDA=  X'8400'      9e14 use platter zero
        STA+  Y+           9e17
        LDAB= X'83'        9e19 [track marker]
        STAB+ Y+           9e1b
        CLA                9e1d start at track zero
        STA+  Y+           9e1e -> 4152
        LDAB= X'8A'        9e20 [ read sectors ]
        STAB+ Y+           9e22
        LDB=  X'1000'      9e24 BU= 16 sectors, BL= starting at 0
FRD@SCL STBB+ Y+           9e27 [ sector number BL ]
        LDA=  400          9e29 sector size
        STA+  Y+           9e2c [ sector size ]
        INRB  BL           9e2e increment sector number
        DCRB  BU           9e30 decrement remaining sectors
        BNZ   FRD@SCL      9e32 loop until all sectors filled in
        LDAB= X'FF'        9e34 write end of command
        STAB+ Y            9e36
FRD@RUN LDA=  X'FFFF'-60   9e37 =0xffc3(-61) load count
        DMA   SCT,A        9e3a setup DMA count
        LDA=  CMSADDR      9e3c use buffer at 0x414d
        DMA   SAD,A        9e3f set DMA address
        DMA   SDV,3        9e41 DMA device 3
        DMA   EAB          9e43 Enable DMA
        LDAB= X'43'        9e45 load command
        STAB$ I>IODATA     9e47 0114 -> f800/f808
        JSR$  I>WAITIO     9e4a wait for command
        BNF   FRD@OK       9e4d skip forward if okay
        STAB/ DLED2OFF     9e4f clear pass light
        STAB/ DLED3ON      9e52 signal failure
        JMP$  I>ASKSPC     9e55 back to menu
FRD@OK  LDA=  X'FFFF'-(400*16)   9e58 =0xe6ff(-6401)
        DMA   SCT,A        9e5b setup DMA count
        LDA=  X'011C'      9e5d use buffer at X'011c'
        DMA   SAD,A        9e60 set DMA address
        DMA   SDV,3        9e62 Set DMA device
        DMA   EAB          9e64 Enable DMA
        LDAB= X'45'        9e66 command: execute command string
        STAB$ I>IODATA     9e68 0114 -> f800/f808
        JSR$  I>WAITIO     9e6b wait for command
        BNF   FRD@NXT      9e6e continue if no fault
        JSR$  I>SHOWSTR    9e70 write string
        DC    'TRACK='
        DB    0
        LDA/  CMSTRACK     9e7a =0x4152
        JSR$  I>PUTHEXW    9e7d show the track in hex
        JSR$  I>SHOWSTR    9e80 write newline
        DW    X'8D8A'   CRLF
        DB    0
FRD@NXT LDA/  CMSTRACK     9e86 =0x4152 load current track
        BNZ   FRD@TNZ      9e89 skip if not zero
        INA                9e8b track 0 to 1
FRD@TNZ SLA                9e8c otherwise, exponential increments
        STA/  CMSTRACK     9e8d =0x4152 store track
        LDB=  605          9e90 ending track
        SAB                9e93 compare [A - B -> B]
        BLE   FRD@RUN      9e94 loop until we get to the end
        STAB/ DLED2ON      9e96 signal test pass
        JSR$  I>TESTRUN    9e99 =0x0104 check input / rerun the test
        DW    FCHREADL-R4ENT   9e9c =0x060b -> 9e0b
*
R4ROMT  LDA=  R4INITV-R4ENT   9e9e =0x018b load offset
        ADD   Z,A          9ea1 add base addr, A -> 998b R4INITV
        JSR+  A            9ea3 call the init routine
        DW    X'0000'      9ea5 unused device address
        XFR   Z,Y          9ea7 copy ROM base in Z to Y
        CLA                9ea9 clear A for sums
R4SLOOP LDAB+ Y+           9eaa load byte from ROM into AL
        ADDB  AL,AU        9eac keep the sum in AU
        LDB=  R4SUM-R4ENT  9eae =0x06ed get offset of checksum
        ADD   Z,B          9eb1 point B at the checksum address
        SUB   Y,B          9eb3 compare current address
        BNZ   R4SLOOP      9eb5 loop until we reach the checksum
        LDAB+ Y            9eb7 load the checksum
        SUBB  AU,AL        9eb8 compare [AU - AL -> AL]
        BNZ   SHOWFAIL     9eba branch if not zero
        JSR$  I>SHOWSTR    9ebc =0x0112
        DW    X'8A8D'   LF CR
        DC    '*** PASS ***'
        DB    0
        STAB/ DLED2ON      9ece signal pass
        JMP$  I>ASKSPC     9ed1 return to menu
SHOWFAIL JSR$  I>SHOWSTR   9ed4 =0x0112
        DC    '*** FAIL ***'
        DB    0
        STAB/ DLED2OFF     9ee4 clear pass LED
        STAB/ DLED3ON      9ee7 signal failure
        JMP$  I>ASKSPC     9eea return to menu
* this would be calculated from start of this ROM to before this address
R4SUM   DB    X'C5'        9eed ROM checksum
        DB    0,274        9eee =0x00,0x0111
a000:ENDPT
