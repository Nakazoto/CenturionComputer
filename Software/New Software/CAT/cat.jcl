.NOLOG
.JOB CAT ABORT=CANCEL
.SETA UPSI=0
.SKIP TO #0
=CRT0
=CRT1
=CRT2
=CRT3
=CRT4
=CRT5
=CRT6
=CRT7
=CRT8
=CRT9
=CRT10
=CRT11
=CRT12
=CRT13
=CRT14
=CRT15
.SETA UPSI=#U+2
.USE #0 FOR SYS000
.SKIP TO OUTFILE
=#0
.SETC 6='.'
/ ENTER INPUT LIBRARY OR "NEWLINE" FOR NONE
.ENTER 5
.SKIP 1 IF ? LT #5
.SETC 5='' 6=''
.USE #5#6#0 ON #1 FOR SYS000
.SETC 1=#2
.SETC 2=#3
=OUTFILE
.SKIP TO #1
=CRT0
=CRT1
=CRT2
=CRT3
=CRT4
=CRT5
=CRT6
=CRT7
=CRT8
=CRT9
=CRT10
=CRT11
=CRT12
=CRT13
=CRT14
=CRT15
=PRT0
=PRT1
=PRT2
=PRT3
=PRT4
=PRT5
=PRT6
=PRT7
=PRT8
=PRT9
=PRTQ
=PRTR
.SETA UPSI=#U+1
.USE #1 FOR SYS001
.SKIP TO RUN
=#1
.SETC 6='.'
/ ENTER OUTPUT LIBRARY OR "NEWLINE" FOR NONE
.ENTER 5
.SKIP 1 IF ? LT #5
.SETC 5='' 6=''
.FSPEC #5#6#1 ON #2 3=SIZE
.SKIP TO OK IF #3 GT 0
/ FILE '#5#6#1' NOT FOUND ON #2 CREATE(Y/N)?
.ENTER 3
.SKIP TO END IF Y NE #3
.NEW #5#6#1 ON #2 'A' 1S
=OK
.USE #5#6#1 ON #2 FOR SYS001
=RUN
.RUN XCAT
.SKIP TO END IF 0 EQ #C
/
/ WARNING: I/O ERROR RUNNING CAT
/
=END
/ END CAT
.END
.LOG
S.CON