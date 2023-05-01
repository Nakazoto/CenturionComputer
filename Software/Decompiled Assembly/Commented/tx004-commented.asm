 TITLE 'Transient 4: A to ASCII date'
 BEGIN 0
* on entry:
* A holds date (days since an epoc)
* takes inline DW pointer to buffer to put date
* format is 'MM/DD/YY' 8 chars, valid years 1900 to 1999
* 2000+ overflows ascii tens digit in year
TX004   XAB               copy A to B
        BNZ   CVTDATE     Branch if valid
        LDA/  X'005A'     load level 5 S into A, =comrg address
        LDA+  A,3         get offset 3: current tib address
        LDA+  A,25        from tib, get offset 25: utility word 0 as address
        BZ    NOCPL       branch if that's zero
        LDBB= 2
        STBB+ A,6         store 2 at offset 6 of *that* address
NOCPL   JSR   GETUBUF     get dest in A with range check
        FIL   (8)=' ',-A  Fill it with 8 spaces
        SVC   1           [TRTN - transient return]
        DW    -1          [return code]
*
* 0 meant 'no date', so always A > 0 here
*
CVTDATE DCA               Decrement A for days since epoc
        LDB=  0-1461      number of days in 4 years: 365.25 * 4
        STX-  S-          stack X
        LDX=  -1          init X
L@LEAP  INX               increment X
        ADD   B,A         iterative division 4 years at a time
        BL    L@LEAP      loop while link
        SAB               undo the one that went over: remainder in B
        SLR   X,2         multiply X by 4 to get whole years in X
        LDAB= -29
        STAB/ TB@FEB      assume a leap year
        LDA=  -365
        AAB               'subtract'
        BLE   ISLEAP      branch if within first year of 4
        LDAB= -28         use AL to clear leap day
        STAB  TB@FEB      in Feb
        LDAB= X'93'       low byte for -365 in A
        DCR   B           take the leap day out
L@YEAR  INX               divide by last few years
        AAB
        BP    L@YEAR      loop 0-3 times
ISLEAP  SUB   B,A         undo the amount that went over
        STA-  S-          push remainder of days
        JSR   XTO2DEC     convert X (years) to ASCII in B
        LDA+  *S,2        indirect through the stack to get buffer
        STB+  A,6         put years in buffer: '******YY'
        LDA=  X'FFFF'     reset A to -1
        LDB+  S+          pop remainder days in B
        LDX=  TB@DAYS     load X with days in month table
L@MNTH  LDAB+ X+          AL from table
        AAB               subtract that number of days
        BL    L@MNTH      until we go over
        SUBB  BL,AL       undo the amount that went over
        STAB- S-          save remainder of days
        LDA=  TB@DAYS     load start of table
        SUB   X,A         subtract that to get the index (month) we are at
        XAX               put that back in X
        JSR   XTO2DEC     so we can convert it
        LDA+  *S,1        indirect through the stack to get buffer address
        STB+  A           put month in buffer: 'MM****YY'
        CLA               clear AU
        LDAB+ S+          pop days into AL
        INA               increment, can't show day 00 after all!
        XAX               put it in X
        JSR   XTO2DEC     convert
        LDX+  S+          this time: pop buffer into X
        JSR   GETUBUF     get dest with range check... here... instead of...
        STB+  A+,3        put days in buffer: 'MM*DD*YY'
        LDBB= '/'         put the slashes in
        STBB+ A            at 2+0 'MM/DD*YY'
        STBB+ A,3         and 2+3 'MM/DD/YY'
        SVC   1           [TRTN - transient return]
        DW    -1          [return code]
*
* saves B, pops X, puts buffer pointer in A
*
GETUBUF STX  GETURET+1      save return point
        LDX+ S+             pop X from the stack
        STK  B,2            save B to stack
        LDA+ X+             load A from X
        SUB= X'7FFF',X,B    0x7fff - X => B
        BL   GETUBOK        branch if X in high mem
        SUB= X'7FFF',A,B    0x7fff - A => B
        BNL  GETUBOK        branch if X in low, and A in low mem
        XAB                 A to B, crosses regions, bad! no!
        XFR  X,A            X to A
        SVC  9              [ABRT - abort task]
        DB   23             [abort code]
*
GETUBOK POP   B,2           restore B from stack
GETURET JMP/  X'0000'       return from sub
*
* read X from stack in-place, returns 2 ascii digits in B
*
XTO2DEC LDB+  S             load B from stacked X
        LDAB= X'F6'         AL = -10
L@DEC   INRB  BU            Increment BU by 1 initially and each loop
        AABB                divide by -10 in BL
        BL    L@DEC         loop for iterative divide
* there is the initial +1 and loop ends by going over
* so BL will be negative -10 to -1
* BU will be (N/10) + 2
DECCHAR EQU  '00'-X'200'+10
        LDA= DECCHAR        conversion base
        AAB                 converted output in B
        RSR
* table of minus days in each month
TB@DAYS DB   -31 JANUARY
TB@FEB  DB   -28 FEBUARY special case
        DB   -31 MARCH
        DB   -30 APRIL
        DB   -31 MAY
        DB   -30 JUNE
        DB   -31 JULY
        DB   -31 AUGUST
        DB   -30 SEPTEMBER
        DB   -31 OCTOBER
        DB   -30 NOVEMBER
        DB   -31 DECEMBER
 END TX004
