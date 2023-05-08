*
MAIN    BS1   JDIAG        fc00  Branch if Sense Switch 1 set
        JMP   JBOOT        fc02  skip the jump
JDIAG   JMP/  X'8001'      fc04  jump to diag code
JBOOT   LDAB= X'C5'        fc07  baud=9600, Even Parity, 7 Data, 1 Stop
        STAB/ X'F200'      fc09  configure MUX 0
        LDAB= X'8C'        fc0c  =FF (clears terminal)
        STAB/ X'F201'      fc0e  send it
        DLY                fc11  wait for clear, 9.1 ms
        DLY
DSKSEL  LDA=  X'1000'      fc13  top of lowest 4k ram
        XAS                fc16  (re)set stack
        JSR   SENDSTR      fc17  show the prompt
        DC    'D='
        DB    0
        JSR   JGETCHR      fc1c  get char in AL
        LDBB= 'F'          fc1e  'f'inch/floppy card
        SABB               fc20  compare
        STBB- S-           fc21  save selection on stack
        BZ    UNITSEL      fc23  equal 'f'?
        LDBB= 'C'          fc25  'c'md card (phoenix)
        SABB               fc27  compare
        BZ    UNITSEL      fc28  or 'c'?
        LDBB= 'H'          fc2a  or 'h'awk (dsk/dsk2)
        SABB               fc2c  compare
        BNZ   SELERR       fc2d  else no matches, branch to err
UNITSEL JSR   GETCHAR      fc2f  get number
        LDBB= X'50'        fc31  conversion: 80 + '0' = 0
        ADDB  BL,AL        fc33
        BM    SELERR       fc35  branch input less than '0'
        LDBB+ S+           fc37  selection from stack
        BM    JCMDBOOT     fc39  branch minus: 'C' was selected
        BGZ   JHWKBOOT     fc3b  branch greater than zero: 'H' was selected
        LDBB= X'03'        fc3d  'F' selected, check max unit
        SABB               fc3f  compare
        BGZ   SELERR       fc40  branch if unit out of range
* build the FFC command string on the stack
* we're going backwards here!
        LDB=  X'0F00'      fc42  8,9: read 3840 bytes
        STB-  S-           fc45  push word
        CLR   B            fc47  6,7: 0 sector num and 0 key len
        STB-  S-           fc49  push word
        LDBB= X'88'        fc4b  5: read sector
        STBB- S-           fc4d
        LDB=  X'8300'      fc4f  3,4: 0x8300 track zero
        STB-  S-           fc52
        LDB=  X'8100'      fc54  1,2: 0x810u unit select
        SL                ;fc57  convert the unit number into a bit offset
FFCUNIT RLRB  BL           fc58  loop does BL = 1 << AL
        DCAB               fc5a
        BP    FFCUNIT      fc5b  shift loop
        STB-  S-           fc5d  push unit select word
        DMA   SDV,1        fc5f  set DMA mode and device
        DMA   EAB          fc61  enable DMA
        DMA   SAD,S        fc63  use command buffer at S
        LDA=  X'FFFF'-9    fc65  9 byte command string
        DMA   SCT,A        fc68  store DMA count
        JSR   JFFCEXC      fc6a  tell FFC to get command string from DMA
        DB    X'43'        fc6c
        LDA=  X'0100'      fc6d  load IPL at 0x0100
        DMA   SAD,A        fc70
        LDA=  X'FFFF'-3840 fc72  not a multiple of 400!
        DMA   SCT,A        fc75  DMA count
        JSR   JFFCEXC      fc77  tell FFC to execute command string
        DB    X'45'        fc79
        BNZ   SELERR       fc7a  branch if error
        JMP/  X'0103'      fc7c  enter the IPL
SELERR  JSR   SENDSTR      fc7f  show the string:
        DW    X'8D8A'      fc81  =CR,LF
        DC    'ERROR'
        DW    X'8D8A'      fc88  =CR,LF
        DB    0            fc8a  end
        RL                ;fc8b  reset link
        JMP   DSKSEL       fc8c  retry
* shortcuts
JFFCEXC JMP   FFCEXC
JGETCHR JMP   GETCHAR
*
* Function SENDSTR
*
SENDSTR LDAB/ X'F200'      fc92  get status
        SRAB               fc95  put bit 1 in link (tx empty)
        SRAB
        BNL   SENDSTR      fc97  wait for it to become set
        LDAB+ X+           fc99  read inline chars
        BNZ   WRTMUX       fc9b  not NUL, output it
        RSR                fc9d  return on NUL
WRTMUX  STAB/ X'F201'      fc9e  send the char
        JMP   SENDSTR      fca1  loop to next char
GETCHAR LDAB* SENDSTR+1    fca3  get status
        SRAB               fca5  put bit 0 in link (rx full)
        BNL   GETCHAR      fca6  wait for it to become set
        LDAB* WRTMUX+1     fca8  read the byte
        LDBB= X'80'        fcaa  set the high bit
        ORIB  BL,AL        fcac
        LDBB= X'E0'        fcae  =128.or.x'60'
        SABB               fcb0  compare
        BM    GETECHO      fcb1  branch if upper case
        LDBB= B'11011111'  fcb3  mask to clear the 'case' bit
        ANDB  BL,AL        fcb5  make it upper case
GETECHO STAB* WRTMUX+1     fcb7  echo the char
        RSR                fcb9  return with AL=char
*
JCMDBOOT JMP  CMDBOOT      fcba  proxy jump
JHWKBOOT JMP  HWKBOOT      fcbc  proxy jump
JSHOWERR JMP  SELERR       fcbe  proxy jump
HWKBOOT LDBB= X'07'        fcc0  max hawk units, range 0 to 7
        SABB               fcc2  compare
        BGZ   SELERR       fcc3  unit out of range
        STAB/ X'F140'      fcc5  select it
        LDA*  HWKSTS+1     fcc8  get status registers
        LDB=  X'0010'      fcca  check unit ready bit
        NAB                fccd
        BZ    SELERR       fcce  error if not.
        CLA                fcd0  clear A
        STA/  X'F141'      fcd1  cyl 0, h 0, sec 0
        JSR   HWKCMD       fcd4  command and wait:
        DB    3            fcd6  [ RTZ seek ]
HWKRTZ  LDA*  HWKSTS+1     fcd7  get status word
        LDB=  X'0400'      fcd9  mask seek error
        NAB                fcdc
        BNZ   SELERR       fcdd  failed RTZ
        LDB=  X'0020'      fcdf  mask, on cylinder
        NAB                fce2
        BZ    HWKRTZ       fce3  wait for seek to finish
        DMA   SDV,0        fce5  set DMA mode and device
        DMA   EAB          fce7  enable DMA
        LDA=  X'0100'      fce9  start DMA at 0x0100
        DMA   SAD,A        fcec
        LDA=  X'ffff'-(400*14)   -5601, burst read 14 sectors
        DMA   SCT,A        fcf1  as DMA count
        JSR   HWKCMD       fcf3  command and await:
        DB    0            fcf5  [ read ]
HWKSTS  LDAB/ X'F144'      fcf6  we should no longer be busy
        BNZ   SELERR       fcf9  all other bits indicate error if set
        JMP/  X'0103'      fcfb  enter IPL
        JSR   OLD1         fcfe  (unused) CMD command string
* CPU reset entry point
ENTRY   JMP/  MAIN         fd00  reset entry: jump back to beginning of ROM
FFCEXC  LDAB+ X+           fd03  get command
FFCDAT  STAB/ X'F800'      fd05  tell FFC the command
FFCWAIT LDAB/ X'F801'      fd08  get status bits
        DCAB               fd0b  ignore fout
        BNZ   FFCWAIT      fd0c  loop to wait for busy and fin to clear
        LDAB* FFCDAT+1     fd0e  get result code
        RSR                fd10  return with that
*
* send a command to DSK2 and wait
*
HWKCMD  LDAB+ X+           fd11  get inline byte
        STAB/ X'F148'      fd13  use as DSK2 command
HWKBSY  LDAB* HWKSTS+1     fd16  get reg 4: status
        SRAB               fd18  bit 0: check busy
        BL    HWKBSY       fd19  loop until it's done
        RSR                fd1b
*
JCMDERR JMP   JSHOWERR     fd1c  short jump to error
*
* handle the CMD boot sequence
*
CMDBOOT STAB- S-           fd1e  stack unit number for later
        LDA=  X'1F40'      fd20  build command string in RAM
        XAZ                fd23  use Z
        LDA=  X'8100'      fd24  [ device select zero ]
        STA+  Z+           fd27
        LDAB= X'84'        fd29  [ platter select? ]
        STAB+ Z+           fd2b
        LDAB+ S+           fd2d  get selected index
OLD1    BZ    CMDZERO      fd2f  skip when unit zero
        LDBB= X'0F'        fd31  other units start at X'10'
        ADDB  BL,AL        fd33  offset
CMDZERO STAB+ Z+           fd35  put it in the command
        LDAB= X'83'        fd37  [ disk address, track?/cyl? ]
        STAB+ Z+           fd39
        CLA                fd3b  [ DW 0 ]
        STA+  Z+           fd3c
        LDAB= X'85'        fd3e  [ read list ]
        STAB+ Z+           fd40
        CLAB               fd42
CMDRDS  STAB+ Z+           fd43  [ DB sector (0 to 13) ]
        LDB=  X'0190'      fd45  [ DW 400 bytes ]
        STB+  Z+           fd48
        INAB               fd4a  next
        LDBB= X'0E'        fd4b  14 sectors yet?
        SABB               fd4d  compare
        BNZ   CMDRDS       fd4e  loop if not
        LDAB= X'FF'        fd50  end command string
        STAB+ Z+           fd52
        LDAB= b'00001000'  fd54  wait for busy clear
        JSR   CMDWAIT      fd56
        LDAB= X'41'        fd58  not sure of this (set CRC, same as FFC?)
        STAB/ X'F808'      fd5a  CMD command
        DLY                fd5d  hard wait
        CLAB               fd5e
        STAB/ X'F808'      fd5f  [ 0 ]
        DLY                fd62  hard wait
        STAB/ X'F808'      fd63  [ 0 ]
        DLY                fd66  hard wait
        LDA=  X'1F40'      fd67  put start of command in DMA address
        DMA   SAD,A        fd6a
        SUB   Z,A          fd6c  end pointer to length
        IVA                fd6e  complement to get DMA count
        DMA   SCT,A        fd6f
        DMA   SDV,3        fd71  set DMA mode and device
        DMA   EAB          fd73  enable DMA
        LDAB= X'43'        fd75  tell CMD to DMA the command string
        STAB/ X'F808'      fd77
        DLY                fd7a  hard wait
        DLY                fd7b
        JSR   CCHKERR      fd7c  fail if error
        JMP   CMDSKIP      fd7e  make room in the ROM
JCMDERR1 JMP  JCMDERR      fd80  short jump for error message
CMDSKIP LDA=  X'0100'      fd82  beginning load address
        DMA   SAD,A        fd85
        LDA=  X'ffff'-(14*400)  fd87 get the 14 sectors
        DMA   SCT,A        fd8a
        DMA   SDV,3        fd8c  set DMA mode and device
        DMA   EAB          fd8e  enable DMA
        LDAB= X'45'        fd90  tell CMD to execute command string
        STAB/ X'F808'      fd92
        LDAB= b'00001000'  fd95  this time, wait for busy bit to clear
        JSR   CMDWAIT      fd97
        JSR   CCHKERR      fd99  fail if error
        JMP/  X'0103'      fd9b  enter IPL
*
* Function CCHKERR
*
CCHKERR LDAB/ X'F808'      fd9e  get CMD return data
        BNZ   JCMDERR2     fda1  0=ok, else error
        RSR                fda3  return
JCMDERR2 JMP  JCMDERR1     fda4  so many jumps...
*
* Function CMDWAIT
*
CMDWAIT LDBB/ X'F809'      fda6  get CMD status
        NABB               fda9  check with mask
        BNZ   CMDWAIT      fdaa  loop while bits set
        RSR                fdac  return
*
* leaky dead code in the bootrom
*
        DW    X'8C00'      fdad  =FF,NUL
        DW    X'8B00'      fdaf  =VT,NUL
        LDA+  X+           fdb1
        STA   UNKNARG      fdb3  self modify, not allowed in a ROM
UNKNJSR JSR/  X'4C93'      fdb5  so this is clearly from something else
UNKNARG DW    X'47BE'      fdb8
        STX+  S-           fdba  save X
        CLR   X,0          fdbc  use for conversion
UKNLOOP JSR/  X'4CE7'      fdbe  what I can only assume gets a character
        XABB               fdc1
        BZ    UNKNRET      fdc2  NUL?
        LDBB= X'8D'        fdc4  or CR?
        SABB               fdc6
        BZ    UNKNRET      fdc7
        LDBB= X'B0'        fdc9  ='0' convert digit
        SABB               fdcb
        BM    UNKNFIN      fdcc
        LDAB= X'09'        fdce  ensure it's a digit
        SUBB  BL,AL        fdd0
        BLE   UNKNSKP      fdd2
        LDAB= X'11'        fdd4  between 'A' and 'F'
        SUBB  BL,AL        fdd6
        BM    UNKNFIN      fdd8
        LDBB= X'05'        fdda
        SABB               fddc
        BGZ   UNKNFIN      fddd
        LDBB= X'0A'        fddf  add 10 to make value from ascii hex
        AABB               fde1
UNKNSKP LDAB= X'04'        fde2  put it into register (compatible code)
UNKNSBY RL                ;fde4
        RLR   X            fde5
        DCAB               fde7
        BGZ   UNKNSBY      fde8  loop to get all the bits
        ADDB  BL,XL        fdea  add the new digit
        JMP   UKNLOOP      fdec  loop for more
UNKNRET XFR   X,A          fdee
        LDX+  S+           fdf0
        RSR                fdf2
*
UNKNFIN LDX+  S+           fdf3
        JMP   UNKNJSR      fdf5
        LDB+  X+           fdf7
        JSR+  Z            fdf9
        DW    X'0CD0'      fdfb =3280
        DW    X'4B65'      fdfc
        DB    X'F5'        fdff
* fe00
