.NOLOG
.NOTIME
.JOB BLDMINOS ABORT=CANCEL
/ ENTER SOURCE DISK NUMBER
.ENTER 0
/ ENTER TARGET DISK NUMBER
.ENTER 1
.VSPEC #0 2=VOL
.VSPEC #1 3=VOL 4=GSTATUS
.SKIP 2 IF #4 EQ 0
/ TARGET DISK #1 (#3) IS GUARDED.
.SKIP TO THEEND
/
/ DISK #1 (#3) WILL BE ERASED AND BUILT FROM DISK #0 (#2)
/
/ ARE YOU SURE (Y/N)?
.ENTER 4
.SKIP TO THEEND IF Y NE #4
.TIME
.LOG
* Copy P library.
.SETA 4=19*16+6
.NEW P ON #1 'L' #4S FSI=2S DSIZE=1S USIZE=4S FSIZE=1S
.SETA 4=2*16+9
.USE P.APLIB6 ON #0 FOR SYS000
.NEW P.APLIB6 ON #1 'E' #4S FSI=1S
.USE P.APLIB6 ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+6
.USE P.CPL ON #0 FOR SYS000
.NEW P.CPL ON #1 'A' #4S FSI=1S
.USE P.CPL ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE P.HICORE ON #0 FOR SYS000
.NEW P.HICORE ON #1 'E' #4S FSI=1S
.USE P.HICORE ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=3*16+15
.USE P.OSLIB6 ON #0 FOR SYS000
.NEW P.OSLIB6 ON #1 'E' #4S FSI=1S
.USE P.OSLIB6 ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+3
.USE P.SYSGEN ON #0 FOR SYS000
.NEW P.SYSGEN ON #1 'A' #4S FSI=1S
.USE P.SYSGEN ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=1*16+11
.USE P.XASSM ON #0 FOR SYS000
.NEW P.XASSM ON #1 'E' #4S FSI=1S
.USE P.XASSM ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+2
.USE P.XASS@0 ON #0 FOR SYS000
.NEW P.XASS@0 ON #1 'E' #4S FSI=2S
.USE P.XASS@0 ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+3
.USE P.XASS@1 ON #0 FOR SYS000
.NEW P.XASS@1 ON #1 'E' #4S FSI=1S
.USE P.XASS@1 ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=3*16+0
.USE P.XCCOMD ON #0 FOR SYS000
.NEW P.XCCOMD ON #1 'E' #4S FSI=1S
.USE P.XCCOMD ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=0*16+13
.USE P.XLINK ON #0 FOR SYS000
.NEW P.XLINK ON #1 'E' #4S FSI=1S
.USE P.XLINK ON #1 FOR SYS001
.RUN S.XCOPUT
.SETA 4=6*16+1
.USE P.XSGMAIN ON #0 FOR SYS000
.NEW P.XSGMAIN ON #1 'E' #4S FSI=1S
.USE P.XSGMAIN ON #1 FOR SYS001
.RUN S.XCOPUT
* Copy S library.
.SETA 4=5*16+7
.NEW S ON #1 'L' #4S FSI=1S DSIZE=1S USIZE=2S FSIZE=1S
.SETA 4=0*16+2
.USE S.CED ON #0 FOR SYS000
.NEW S.CED ON #1 'A' #4S FSI=1S
.USE S.CED ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.CON ON #0 FOR SYS000
.NEW S.CON ON #1 'A' #4S FSI=1S
.USE S.CON ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.COPY ON #0 FOR SYS000
.NEW S.COPY ON #1 'A' #4S FSI=1S
.USE S.COPY ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.CRT ON #0 FOR SYS000
.NEW S.CRT ON #1 'A' #4S FSI=1S
.USE S.CRT ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.DEL ON #0 FOR SYS000
.NEW S.DEL ON #1 'A' #4S FSI=1S
.USE S.DEL ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+7
.USE S.KOMPOZ ON #0 FOR SYS000
.NEW S.KOMPOZ ON #1 'A' #4S FSI=1S
.USE S.KOMPOZ ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+2
.USE S.NCOPN ON #0 FOR SYS000
.NEW S.NCOPN ON #1 'A' #4S FSI=1S
.USE S.NCOPN ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+7
.USE S.XCED ON #0 FOR SYS000
.NEW S.XCED ON #1 'E' #4S FSI=1S
.USE S.XCED ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+11
.USE S.XCOPUT ON #0 FOR SYS000
.NEW S.XCOPUT ON #1 'E' #4S FSI=1S
.USE S.XCOPUT ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+10
.USE S.XCRTVU ON #0 FOR SYS000
.NEW S.XCRTVU ON #1 'E' #4S FSI=1S
.USE S.XCRTVU ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.XEJECT ON #0 FOR SYS000
.NEW S.XEJECT ON #1 'E' #4S FSI=1S
.USE S.XEJECT ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+1
.USE S.XHEAD ON #0 FOR SYS000
.NEW S.XHEAD ON #1 'E' #4S FSI=1S
.USE S.XHEAD ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=1*16+9
.USE S.XKOMPOZ ON #0 FOR SYS000
.NEW S.XKOMPOZ ON #1 'E' #4S FSI=1S
.USE S.XKOMPOZ ON #1 FOR SYS0001
.RUN S.XCOPUT
.SETA 4=0*16+13
.USE S.XSCAN ON #0 FOR SYS000
.NEW S.XSCAN ON #1 'E' #4S FSI=1S
.USE S.XSCAN ON #1 FOR SYS0001
.RUN S.XCOPUT
.NOLOG
.NOTIME
/
/ SYSTEM BUILD COMPLETE
/
=THEEND
.END
S.CON
