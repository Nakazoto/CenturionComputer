.NOLOG
.JOB PCSOFTRAN
.NOTIME
.FSPEC LOGPC#V ON #S 8=SIZE
.SKIP 1 IF #8 NE 0
.NEW LOGPC#V #S 'A' 1
.USE CRT#V FOR SYS10
.USE LOGPC#V ON #S FOR SYSLST
.RUN PC.XSOFTRAN
.SKIP 1 IF #C NE 50
/   PC.CENTURION IS NOT INITIALIZED
.END
S.CON